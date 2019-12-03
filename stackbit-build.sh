#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://a3a61223.ngrok.io/project/5de629c39b7ebf19f085cb42/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://a3a61223.ngrok.io/pull/5de629c39b7ebf19f085cb42 
fi
curl -s -X POST https://a3a61223.ngrok.io/project/5de629c39b7ebf19f085cb42/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://a3a61223.ngrok.io/project/5de629c39b7ebf19f085cb42/webhook/build/publish > /dev/null
