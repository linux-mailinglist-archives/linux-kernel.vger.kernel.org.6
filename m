Return-Path: <linux-kernel+bounces-525627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC34A3F278
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3724B700185
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A83207656;
	Fri, 21 Feb 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="m30QTjo7"
Received: from enterprise01.smtp.diehl.com (enterprise01.smtp.diehl.com [193.201.238.219])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740091F03EF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.201.238.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740135032; cv=none; b=K3riQDtjh3op15x1ZQP26N/1za1HswfNGJhTmeS6Mg5LIseu0QDAZ2kWJbWGXsttFrLiJqOLfvKm+/KINHwqtwwZFg7NKIBQfvBJJXottQl4DrvUBAF4fjIwDLutFky7C4xYpoBZEe1VWdGwdkg1FaV7NrOahjjozvUUkiR0b5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740135032; c=relaxed/simple;
	bh=Xcz19PdniixDKt6GSmPZ99JrurHu49WUeNcMFogVGqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CHRKkGU/um7TtACNOk/bMp8Wc4CU9eyrZ91R6v5CrLPRmlH4KL/lbbSvTl5ZhoqgUN+LdqG8OmzjPihMztik/TutZb9X6JadMzv614W4UmBUg1sgPyp/UKgM3Cgm7RkH5Myg9jsz+/z95AHEXSNndYuuwEG5bIEDBDzvX0Dvwec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com; spf=pass smtp.mailfrom=diehl.com; dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=m30QTjo7; arc=none smtp.client-ip=193.201.238.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diehl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1740135029; x=1771671029;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Gg6udJolaPDmxbBOSz2KZtWZXF/18okAmziYlAVclE0=;
  b=m30QTjo7JluUjMMbSpOsMFjbxHm52/mtnMLJSB8E6QZX+boiKQrFED1R
   V4QIXUiGlV29C2nME2nNt52Z/93/ZOfr1ZRXs6NaGLsRbyt2u28rf42Xj
   AO1M6M6VIlAwWM55myyQkGabRIKPuZn7BZ/AQCW4CGCz6yFAYgrpJPbMa
   YNAx+GoySdYm5dDyjO/DDEfkbPF8uUMs5/D2FJPbSL2u8LqE5vL81h3/N
   dFraZZJJUC0fIhIOo7TEWho64+EdwwFG3Ig44UH0tGPYrvRx1aI47pYdy
   026udMlf2Z4v+NC+I0kWOV7awRx8MzDVBImUI2RsARLfGlVu1/D6ehKGb
   Q==;
X-CSE-ConnectionGUID: txpFt9ziQfOj6ST8J+uQAA==
X-CSE-MsgGUID: c+c8jzoXRLyQgYy4zeJBQw==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:hEWwS6sDF57vn9tAlobZjLQDzefnVHlZMUV32f8akzHdYApBs4E2v
 jNfGTXfaa7OOz2rZJFrKNbltk0b+s+CkIcnDUA5nZ0HZ2lPqM/IQ8zGNS8cVAucd8bPQhI6t
 ckXZoibdpFoESODrxqnaemxo3cmiP/XHbGnArGdYnt7HFZoQnt/hR9ox+Vi04JliNO3CgrS6
 YOpyyGzEFa9wzp1OWsI6qWF7wtst++t/SgZsVo3ee1RsTcyslFMZH5IDf/pdCuQrvBoNu6mW
 /6Ri/aw/2qf5AgsEci+k7n9NEYKBbfTJ03U1HMJAqP6010e+SE4l/pmafNZOE0N23DVldwuk
 tlD7c3qGQtxBO6UEgzVfRlEDzkseupB86TfZ2OgsNeI1EzJdT3nw7J1DU4weooT4aN+CGpF/
 vEUdXVTMB3Twr7unuP+G+M1jIEtIJO6NYlA4XxuwDqBF8tOfXy4eEm82DMi9Gx23qhzNfbCe
 9JLLn1mbR2GeAJOIUwMCZ042uyowXD+aXgEoQ2b/PVnsy2JkgYsleS9PdGQc4HWGoBex02U/
 mjIpjvyWR1CCbSjJUG+HgSRapXnxmWjML86FKGk7qwtx1aJwioIFxwNTkC6rv//gU75UN5Hb
 hcZ93dzo6RusRH6FYm4A0S1rTvU5BIWHoEKSbYz4wyDl6GOuF6kblToNQWtHuHKzudtA2RC6
 3eJg8/xV3sou6eRD2mC96yPtjK9P24eLSgJaTdBQFpa7YG8q912g0yUEpM/G6O+y434Qzi1m
 2yA9nA32LxI1cVWj5jTwby8uN7am3SzZlVzvm3qY1+YAiNFiK+NN4ChtgHRtK8QdIjBEwGM7
 HRbl5HHvbBTAcncxSKHSehRReH47Pu7azCN2lQH87vNVdiO0yP5IdoAsGkWyGNBaJtslerBO
 ReL0e9pzMYNeiPsNekvPt7Z5/0ClcDIDc7iWu3fcu1Aa51wcB7v1Cx1bCZ85Ui0+KQXuf95Y
 MzznfqEVy5AVPw9lmPuHo/x7JdwrswA7TKKLXzE50T/uVauTCb9YasINlKIctc44MusyC3J8
 8xSPte90B5WVuvzeEH/qeb/+nhTcBDXrbivwyBmXrbrzjhOQQnNONeIqV8VQLGJqowO/gv+E
 tNRbWcDoLb3rSWvxQxn8RmPYpu3NXp0hSpT0SDBoT9EcpXsCGqixP53Snc5QVUo3PBz1dBoH
 usEQsunAKp0dmTluCkkRLCo+eSOdDzz7e6PFyagcjMwYMY6AQfO4Meicgri9C1IBS2y3Sc8i
 +T4kFOBB8NTAV05Vq46a9r2p7+1lXQQnuNpGUzTPtRJfEzq/KBmKiHxirk8JMRkxRDrn2LGj
 1rKW0ZFzQXLi4R2+4nLl6e0laO4KuRPDxZIEkvx1KnjYEE2+ULmm+esSt2gcjHaUW7o5KSKa
 ONTwvz6NvBBl1FP26J4ErB23ec96sHpqrty0AtpBjPIYk6tB7cmJWOJtfSjrYUUnvkJ403vC
 gTWoYMy1ai1Bf4J2WU5fGINBtlvH9lN8tUOxZzZ+HnH2RI=
IronPort-HdrOrdr: A9a23:1sKTD6jIxNqFSrj8524NCRIp/HBQXhMji2hC6mlwRA09TySZ//
 re+cjztCWE8wr5PUtKpTnuAsi9qB/nlaKdwLNhW4tKPzOW31dATrsSibcKqgeIc0KRygc079
 YbT0EUMqySMbEVt7eZ3CCIV/wb7J2s9qeuie3Cz3FrYz1LRshbhTtRO0KwKGEzYBNJK6YYOf
 Oni/avoQDNRZ1uVLXCOpB/ZZm7m+H2
X-Talos-CUID: 9a23:DmCx1GN60BcRnO5DRDl/2lJFCMEcfFrfkkzsc237FF9AYejA
X-Talos-MUID: 9a23:jv62dQlI7z7qKkMP0nqkdnppd8w44bapOHopgKwJitjYJyFSEQ6C2WE=
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; 
   d="p7s'346?scan'346,208,346";a="114044295"
From: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] pps: add epoll support
Date: Fri, 21 Feb 2025 11:49:18 +0100 (CET)
Message-ID: <40322dd7ce0243b6bc89b21d8884980b@diehl.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----77A88045F452DC5B9DEE54D8DB36EB59"

This is an S/MIME signed message

------77A88045F452DC5B9DEE54D8DB36EB59
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

Okay, if poll is expected to work, than we have a bug.
Actually a pretty old one.

pps_cdev_poll() uncoditionally returns (EPOLLIN | EPOLLRDNORM), which results in poll() will return immediately with data available 
(EPOLLIN | EPOLLRDNORM).
To avoid this, you need conditionally return 0.
My patch adds a context per open file to store the last_ev value when ioctl(PPS_FETCH) is invoked and uses this last_ev in poll as 
condition.

Sorry, for the missing memset(&fdata, 0, sizeof(fdata)).
Intention was set to 0, yes.

```c
#include <stdio.h>
#include <string.h>
#include <poll.h>
#include <fcntl.h>
#include "timepps.h"

int main(int argc, const char* argv[]) {
    struct pollfd instance = { .fd = open((argc > 1) ? argv[1] : "/dev/pps0", O_RDONLY), .events = POLLIN|POLLERR , .revents = 0 };
    pps_handle_t pps_handle;
    static const struct timespec timeout = { 0, 0 };
    if (time_pps_create(instance.fd, &pps_handle)) {
        perror("failed to create pps handle");
        return 1;
    }
    for (int loops = 4; --loops; ) {
        pps_info_t pps_info;
        memset(&pps_info, 0, sizeof(pps_info));
        if (!poll(&instance, 1, 2000/*ms*/)) {
            printf("timeout");
            continue;
        }
        if ((instance.revents & POLLIN) != POLLIN) {
            printf("nothing to read?");
            continue;
        }
        if (time_pps_fetch(pps_handle, PPS_TSFMT_TSPEC, &pps_info, &timeout)) {
            perror("failed to fetch");
            return 1;
        }

        printf(
            "assert: %lu\ntime: %ld.%09ld\n",
            pps_info.assert_sequence,
            pps_info.assert_tu.tspec.tv_sec,
            pps_info.assert_tu.tspec.tv_nsec
        );
    }
    return 0;
}
```

Currently output looks like:
```
$ cat /sys/class/pps/pps0/assert; ./test /dev/pps0
1520598954.468882076#60
assert: 60
time: 1520598954.468882076
assert: 60
time: 1520598954.468882076
assert: 60
time: 1520598954.468882076
```

You see no waits between the loops.

With my patch, this looks like:
```
$ cat /sys/class/pps/pps0/assert; ./test /dev/pps0
1520599016.682113965#122
assert: 123
time: 1520599017.682133871
assert: 124
time: 1520599018.682155815
assert: 125
time: 1520599019.682161204
```

I am currently rebasing and testing it with recent changes to pps.c for v2.

Regards, Denis

-----Original Message-----
From: Rodolfo Giometti <giometti@enneenne.com>
Sent: Friday, February 21, 2025 10:18 AM
To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pps: add epoll support


On 20/02/25 17:45, Denis OSTERLAND-HEIM wrote:
> Hi,
>
> Thanks for the fast answer.
>
> -----Original Message-----
> From: Rodolfo Giometti <giometti@enneenne.com>
> Sent: Thursday, February 20, 2025 9:51 AM
> To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH] pps: add epoll support
>
>> Can you explain it a bit better?
> I will do my best.
>
> In an application, that has more to do than just dealing with one PPS device,
> to use PPS_FETCH with a timeout until next event, you need a thread which can sleep.

Why are you saying that? If you use blocking I/O with a timeout in the poll() it
should work.

> I would really like to avoid threads and the resulting synchronization complexity.
>
> Alternative is to fetch the current assert value in at least twice the expected fequency.
> This would definetly work, but epoll is the more efficent way to do.
>
> Without epoll in one thread:
> ```c
> #include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <linux/pps.h>
>
> struct per_pps {
>      int dev_fd;
>      struct pps_fdata fdata;
>      unsigned int last_assert;
> };
>
> int main(int argc, const char* argv[]) {
>      int ret = 0;
>      struct per_pps instances[] = {
>          { .dev_fd = open((argc > 1) ? argv[1] : "/dev/pps0", O_RDONLY) },
>          { .dev_fd = open((argc > 2) ? argv[2] : "/dev/pps1", O_RDONLY) }
>      };
>      if (instances[0].dev_fd < 0 || instances[1].dev_fd < 0) {
>          perror("failed to open dev");
>          ret = 1;
>          goto out;
>      }
>
>      for (int loops = 10; --loops;) {
>          for (int i = 0; i < 2; ++i) {
>              if (ioctl(instances[i].dev_fd, PPS_FETCH, &instances[i].fdata) < 0) {

fdata is not initialized here... is it set to all zero?

>                  perror("failed to fetch data");
>                  ret = 1;
>                  goto out;
>              }
>
>              if (instances[i].last_assert != instances[i].fdata.info.assert_sequence) {
>                  instances[i].last_assert = instances[i].fdata.info.assert_sequence;
>                  printf(
>                      "assert: %u\ntime: %lld.%09d\n",
>                      instances[i].fdata.info.assert_sequence,
>                      instances[i].fdata.info.assert_tu.sec,
>                      instances[i].fdata.info.assert_tu.nsec
>                  );
>              }
>
>          }
>          usleep(300000);
>      }
>
> out:
>      if (instances[0].dev_fd >= 0)
>          close(instances[0].dev_fd);
>      if (instances[1].dev_fd >= 0)
>          close(instances[1].dev_fd);
>      return ret;
> }
> ```
>
> Syscalls are pretty expensive and epoll allows use to reduce them.
>
> ```c
> #include <stdio.h>
> #include <string.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <linux/pps.h>
> #include <poll.h>
>
> int main(int argc, const char* argv[]) {
>      int ret = 0;
>      struct pollfd instances[] = {
>          { .fd = open((argc > 1) ? argv[1] : "/dev/pps0", O_RDONLY), .events = POLLIN|POLLERR , .revents = 0 },
>          { .fd = open((argc > 2) ? argv[2] : "/dev/pps1", O_RDONLY), .events = POLLIN|POLLERR , .revents = 0 }
>      };
>      if (instances[0].fd < 0 || instances[1].fd < 0) {
>          perror("failed to open dev");
>          ret = 1;
>          goto out;
>      }
>
>      for (int loops = 4; --loops;) {
>          if(poll(instances, 2, 2000/*ms*/)) {

Here you are using poll()...

>              struct pps_fdata fdata;
>              for (int i = 0; i < 2; ++i) {
>                  if ((instances[i].revents & POLLIN) != POLLIN)
>                      continue;
>
>                  if (ioctl(instances[i].fd, PPS_FETCH, &fdata) < 0) {

Again, fdata is not initialized here...

>                      perror("failed to fetch data");
>                      ret = 1;
>                      goto out;
>                  }
>
>                  printf(
>                      "assert: %u\ntime: %lld.%09d\n",
>                      fdata.info.assert_sequence,
>                      fdata.info.assert_tu.sec,
>                      fdata.info.assert_tu.nsec
>                  );
>              }
>          } else {
>              printf("time-out\n");
>          }
>      }
>
> out:
>      if (instances[0].fd >= 0)
>          close(instances[0].fd);
>      if (instances[1].fd >= 0)
>          close(instances[1].fd);
>      return ret;
> }
> ```

I think you should try current LinuxPPS implementation but with proper fdata
initialization.

>> RFC2783 states that to access to PPS timestamps we should use the
>> time_pps_fetch() function, where we may read:
>>
>> 3.4.3 New functions: access to PPS timestamps
>>
>>     The API includes one function that gives applications access to PPS
>>     timestamps.  As an implementation option, the application may request
>>     the API to block until the next timestamp is captured.  (The API does
>>     not directly support the use of the select() or poll() system calls
>>     to wait for PPS events.)
>>
>> How do you think to use this new select()/poll() support without breaking the
>> RFC2783 compliance?
> To me RFC reads like the spcification of pps-tools/timepps.h and not the one for the char device.

Yes, but the char device used to implement the PPS API should work with
select()/poll()!

> 3.4.1 New functions: obtaining PPS sources
> ...
>     The definition of what special files are appropriate for use with the
>     PPS API is outside the scope of this specification, and may vary
>     based on both operating system implementation, and local system
>     configuration.
>
> To me "The API does not directly support the use of the select() or poll() system calls" simply means:
>     there is no wrapper function that calls select() or poll() for you

I agree.

> I do not see why an additional function of the underlying character device would break the API.
> You may just do not use it and everything works like before.
> But I see your point.
> If the char dev interface is ment to be the RFC interface only, there is no need to support epoll.
> Maybe it would be better to add epoll support to sysfs assert/clear?

As far as I know, epoll() uses the kernel select/poll mechanism and this support
should work correctly at the moment. If no, we have to fix it.

Try your code with the current LinuxPPS implementation replacing the ioctl(fd,
PPS_FETCH &fdata) with:

     time_pps_fetch(instances[i].fd, PPS_TSFMT_TSPEC, &info, NULL);

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming

------77A88045F452DC5B9DEE54D8DB36EB59
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIXkgYJKoZIhvcNAQcCoIIXgzCCF38CAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgghPaMIIGpTCCBI2gAwIBAgIUPseeE9qJ+oSdbny5LvEHTpzUCAIw
DQYJKoZIhvcNAQELBQAwUzELMAkGA1UEBhMCQ0gxFTATBgNVBAoTDFN3aXNzU2ln
biBBRzEtMCsGA1UEAxMkU3dpc3NTaWduIFJTQSBTTUlNRSBSb290IENBIDIwMjIg
LSAxMB4XDTI0MDUyODA4NDExMFoXDTM2MDUyODA4NDExMFowUjELMAkGA1UEBhMC
Q0gxFTATBgNVBAoTDFN3aXNzU2lnbiBBRzEsMCoGA1UEAwwjU3dpc3NTaWduIFJT
QSBTTUlNRSBNViBJQ0EgMjAyNCAtIDEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
ggIKAoICAQC6Dz+IfbUsaCl0cWcbnNS1BIaKrdka8ev1Kc1G6OCYH4PMtkZmC6Zo
nnh/Dl5bOuiH+pMq1fj4BSEkRYTuOGtsWelcf6UNA11KL//zh1enaaNayqqRaCSE
JTZH+JFb0UJWwO+qGVb1RfHnPXYrI6n8w1chCxL9AibzvsDPR6I37iUwiNo4p6Uo
aPNAmIncpDIGgTGodkOjjPPbGwYjg58eINT63rqMQASJxUnPPIa0gZRix0NY7A6U
z8Iv98RbbQy7ZEDvHdLFeVmzl/5TXKbQExfnEpyOjjifWoJ+FeKkEj4O9Ohd/2fg
HQ6Y+DYwLFbHZPTmDvHQoOSS//V2NBkdnGTsfIcziIH1hypFxR/hqexJ+Da7Z7uN
jBh2ligdXNHDGMeq640X2WVx0sfSZljxbeknrr3KFfzqfealPps1UI68Q+1iBLl/
Ep8aZeRmzwCK+ibAPQpKfbxsjd8cBe8FcXaOWU4DjP6YmYy0xMC4vHXr3ZgrHqL9
8D56InfiYbrBMZp1UKDSzlz/rjXWRmrXnsY5gFU705KWrJu2guSYCrc4InG3Pj+E
mPmE6Eosikk2wg90nYFxJDM/9dPJnyIw6IdkV6qdrv9h7VKrpLrl22qETWC4/Xfi
JU7YsY6HFKnpAElKu8t6rUnU5GcwgWjcB+zBfQD1Kt59jlLob2PcDwIDAQABo4IB
cDCCAWwwXAYIKwYBBQUHAQEEUDBOMEwGCCsGAQUFBzAChkBodHRwOi8vYWlhLnN3
aXNzc2lnbi5jaC9haXItNGE3ZjE3ODgtMjZiNS00OGVjLWE1NDctYzFjZDBiZjE3
YzNkMBIGA1UdEwEB/wQIMAYBAf8CAQAwQAYDVR0gBDkwNzAJBgdngQwBBQEBMAkG
B2eBDAEFAQIwCQYHZ4EMAQUBAzAIBgYEAI96AQMwCgYIYIV0AVkCAQswUQYDVR0f
BEowSDBGoESgQoZAaHR0cDovL2NybC5zd2lzc3NpZ24uY2gvY2RwLTNlZTU1ZmQ0
LTU5MzgtNDFlZS04MmRiLTMyMjNhY2VmNWMyMzATBgNVHSUEDDAKBggrBgEFBQcD
BDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFL+0FkGip5/XTYUBCqFcvtvF0uWU
MB8GA1UdIwQYMBaAFMwurYmMg+NAoyVppeqSfdI3OsfGMA0GCSqGSIb3DQEBCwUA
A4ICAQBGpYYvkjNsVP7geKv1jY+KtUNmyx8vlCoOo8tZ5Cc76175ocrVs50lZit+
nHWXe9Lqnuu1fMo+0jEpgC9dqy6cCxAEgNH5kwbFxXFPHOB/kxMdWubZ1xwcOP2l
B4ns7Ps9RUGOIcpfuAp2KLYwavjO58g+6FVGhY3R6VAhmNRO6bHhz0wQRwKAZNo2
GMwYMmxW63mI4bz1JYvCSeZtqZhyxTMDOwEUDdYkxrz3g5gQUoMnrrak1kGRdpFB
Eefok8aK8ngfwwIgefNBF9BnzoRhlIVrm3//zboqShj4IXqMEUgScWNz2WTjqKaU
uhLk+MyynNqrbp6EeFZ0BPgA7AfVWevRf4OOCxrH6S4FJtMKmuczZ0wqebTML7Ax
VtkSqeT7/NBDTh8D8j+HVvHwMi4s+cunS3DMdXE9yzuixlcjfsD/2aS17quE23Qf
nNESdDy5TUs5Wlm1ClYQ+L1cZGwSwAyqMs9RNg57+gtJu5Uhjn+FGVLndGQgzIor
/+ynq6KEzN2rhGzLpPHpwUdDoX+YnNlrZpdx/IOgknaSGznJ/mQzA6PjffNS0Fx3
pqd41QO0uX5HWDFEa/gG0Uo7faymzXFcFb9AKCrKR5Xrd0W+f2U2z/hvC843i9q2
8CoJ7xRMt0wF8Sun9U278iaLgPNNyCNDJorz9NmIomvT45XK7jCCBe4wggPWoAMC
AQICEACzBRGxFrSgVlEdfGgfh30wDQYJKoZIhvcNAQELBQAwRTELMAkGA1UEBhMC
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
bIRutw/gmkT7b9aP2Wmm3PtjnasrM+RdDlfGKqHkeCR2zkeRDDP2BE2LKc9CFGJB
PysNjZSVlp5/fxb8atVwVk+TphIHuHjeP+3z/ykiDr64Yq2yjyNlXrWVg2yxju4M
LdX8wfkCx/uAIlYLACinK+/RATAYz1f3Y+kJ81CQbfFpnFZBRhxjDfj65zxMrWsJ
ydnoGsZUHt7zXFOQvw7JrFL/X5s7hBv/3uy107vBwcA8Hyw9m3DH/ChBMen6gyy+
CkNXalP9AOZ66CoEgIE8PfsrzfBVjVxQq2+iQLNlJ8a1r6URPNd5h1YZILBy6yTK
8tUs5MbM2CjbXAylEC1P02GFKhh/aN0gW5RTRk3vpA64KPQ/ckvUTmHVWONUE9cj
iE1/MVDuc+tMfQus2HBQ0LH+EKaVZmsA1OEKujelRFleMEpBBWS0fQ+zT2Y4bfPZ
RB5iQLGLf9hSacG+ib5cid44OL6s9kjzE5+Yy70LNcoHwIaQzqoc6t7sFNVDecMc
tTbrs+raTu/cOMSc45aEDKXjhYw46cyuLwnY9DauweK3K89jUrCNqNqPwQke6QID
AQABo4ICCzCCAgcwgbIGCCsGAQUFBwEBBIGlMIGiMEwGCCsGAQUFBzAChkBodHRw
Oi8vYWlhLnN3aXNzc2lnbi5jaC9haXItMjZhNzFjMDktNDdlYi00NTVhLTliMjgt
NGJkNzJkZjA5MjhkMFIGCCsGAQUFBzABhkZodHRwOi8vb2NzcC5zd2lzc3NpZ24u
Y2gvc2lnbi9vY3MtYWFjY2NlZDUtNjZlOC00MDY5LTliMWItZmQyOWFiNzNlZmVj
MHIGA1UdIARrMGkwCQYHZ4EMAQUBATAIBgYEAI96AQMwUgYIYIV0AVkCAQswRjBE
BggrBgEFBQcCARY4aHR0cHM6Ly9yZXBvc2l0b3J5LnN3aXNzc2lnbi5jb20vU3dp
c3NTaWduX0NQU19TTUlNRS5wZGYwUQYDVR0fBEowSDBGoESgQoZAaHR0cDovL2Ny
bC5zd2lzc3NpZ24uY2gvY2RwLWU5N2YwN2M0LWU2MzQtNGNlYy04ZTJhLTA0YjIw
YTdhMzBjNTATBgNVHSUEDDAKBggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCBaAwJAYD
VR0RBB0wG4EZZGVuaXMub3N0ZXJsYW5kQGRpZWhsLmNvbTAdBgNVHQ4EFgQUcDNC
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

------77A88045F452DC5B9DEE54D8DB36EB59--


