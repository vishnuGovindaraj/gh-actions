FROM node:14.15.3

# Copy and extract build
ADD package.json /home/appuser/app/package.json
WORKDIR /home/appuser/app

RUN npm install

COPY . .

# create a non-root user
RUN groupadd -g 999 appgrp && \
    useradd -r -u 999 -g appgrp appuser

RUN mkdir /home/appuser/.aws
RUN chown -R appuser:appgrp /home/appuser/
RUN chmod 700 /home/appuser/

USER appuser
CMD npm run start
