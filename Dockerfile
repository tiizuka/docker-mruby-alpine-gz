FROM alpine AS builder

RUN apk add -U --no-cache \
            mruby \
            gzip

RUN gzexe /usr/bin/mruby

RUN mkdir /alpine

RUN apk \
      -p /alpine \
      --initdb \
      -X https://dl-cdn.alpinelinux.org/alpine/latest-stable/main \
      --allow-untrusted \
      -U \
      --no-cache \
    add \
      allow-baselayout

RUN cp -p /usr/bin/mruby /alpine/usr/bin/mruby


FROM scratch

COPY --from=builder \
     /alpine \
     /
