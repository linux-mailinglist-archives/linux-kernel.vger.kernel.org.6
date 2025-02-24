Return-Path: <linux-kernel+bounces-528923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07613A41E11
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0114B7A4027
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6158D267B15;
	Mon, 24 Feb 2025 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="mQPmnAHt"
Received: from enterprise02.smtp.diehl.com (enterprise02.smtp.diehl.com [193.201.238.220])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA57525A347
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.201.238.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397142; cv=none; b=UKmZiwUJ9xSmtMElcWdRCLHS05725XKfq0hu+2XfD2BRnlxym6lgBO/DoY9ZlmWjZVPsHfbcuuBkN427ckkk8DthphP4ADA6HefZOwDhWX4ubfvXQ0264N/mVZVVgUuHnsdlYCjUTpmycd2w7+N4ISr+tBeQoaJHCtfSQnPthvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397142; c=relaxed/simple;
	bh=LqZbXuTMhkboreamp4h8WSE+cRi0pv+7LKjzKlr1Te4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YEIF5zuREYh0pMxBumdaCFDJZk0UE+DIzF68LuuFGkHMLVFQGyiAlOBr/bPCFDDVVRj/A/ZI4ZKuReBb/dZ2hYvpqZKzXZFPm5K/zxOqZatj6jb0p6ItHV9HfkSBmepf5QFQBe/VxMLuNkc4QM4yKhHV9gFtsIRcN0CzdyW6U6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com; spf=pass smtp.mailfrom=diehl.com; dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=mQPmnAHt; arc=none smtp.client-ip=193.201.238.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diehl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1740397138; x=1771933138;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=BZPqaSUYpMA1gThwSa5jJ17wrHP0TL/fZ/ro4bFKiCA=;
  b=mQPmnAHt8ZgYL4nOex73KHrSfwcFFbeyJU+mdQLqdSHyhUkzgu4X4Waj
   mi7E+va3+sZ3PlsRVgaERjZSkseUfA6T3Xs9JIsXXk+HJsZLi0x06cShM
   CIixcojCGVbqkyTcWI1VCdl9iwQOoo8Z9lYHp3FGGHEs45hqp3uHEs1tl
   X9/EB7Bow2O1EXiPkUvtoYrSwFLJ+NQypU83KMratsrY3VInxH2PxXmzV
   91Pv/GfdeowrlwPW2SdrrMtdj79yhjkRHDL1K+awFWFlm8anyIdvabfYO
   kkHzOt0lmo5wpLr3Pvdab4dPe0Q8pDWR+Ys+hXU4LAOM0CJxxySMEBHfu
   Q==;
X-CSE-ConnectionGUID: kEdVPvq8RgqtO8mta0qtvg==
X-CSE-MsgGUID: /ZrGZRcfSU6K1SJYmYKTAw==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:HpStZKvBtavXIiysSE02wqHPiOfnVHlZMUV32f8akzHdYApBs4E2v
 jNfGTXfaa7OOz2rZJFrKNbltk0b+s+CkIcnDUA5nZ0HZ2lPqM/IQ8zGNS8cVAvLJJCaQEltt
 p1PNIGZIJ1rFnLRrEujPrG79SV13v7ZTOGhWbTJMSkhFQVqRnt5gxk6y+VgjtQy0dK3Cg3Qt
 NmsyyGzEFa9wzp1OWsI6qWF7wtst++t/SgZsVo3ee1RsTcyslFMZH5IDf/pdCuQrvBoNu6mW
 /6Ri/aw/2qf5AgsEci+k7n9NEYKBbfTJ03U1HMJAqP6010e+SE4l/pmafNZOE0N23DVldwuk
 tlD7c3qGQtxBO6UEgzVfRlEDzkseupB86TfZ2OgsNeI1EzJdT3nw7J1DU4weooT4aN+CGpF/
 vEUdXVTMB3Twr7unuP+G+M1jIEtIJO6NYlA4XxuwDqBF8tOfXy4eEm82DMi9Gx23qhzNfbCe
 9JLLn1mbR2GeAJOIUwMCZ042uyowXD+aXgEoQ2b/PVnsy2JkgYsleS9PdGQc4HWGoBex02U/
 mjIpjvyWR1CCbSjJUG+HgSRapXnxmWjML86FKGk7qwtx1aJwioIFxwNTkC6rv//gU75UN5Hb
 hcZ93dzo6RusRH6FYm4A0S1rTvU5BIWHoEKSbYz4wyDl6GOuF6kblToNQWtHuHKzudtA2RC6
 3eJg8/xV3sou6eRD2mC96yPtjK9P24eLSgJaTdBQFpa7YG8q912g0yUEpM/G6O+y434Qzi1m
 2yA9nA32LxI1cVWj5jTwby8uN7am3SzZlVzvm3qY1+YAiNFiK+NaYX5tgDXsfsYdN7GEVKLt
 XZVxJTP5btVUM/SnSGDEblRReH47Pu7azCN2lQH87vNVdiO0yP5IdoAsGkWyGNBaJtslerBO
 ReL0e9pzMYNeiPsNekvPt7Z5/0ClcDIDc7iWu3fcu1Aa51wcB7v1Cx1bCZ85Ui0+KQXuf95Y
 MzznfqEVy5AVPw9lmHuHo/x7JdwrswA7TKKLXzE50T/uVauTCb9YasINlKIctc44MusyC3J8
 8xSPte90B5WVuvzeEH/qeb/+nhTcBDXrbivwyBmXrbrzjhOQQnNONeIqV8VQLGJqowO/gv+E
 tNRbWcDoLb3rSWvxQxn8RmPYpu3NXp0hSpT0SDBoT9EcpXsCGqixP53Snc5QVUo3O9OwcBMU
 eBVQcqZHtMfTyjOoy0Bc5ao+eSOdDzz7e6PFyagcjMwYMY6AQfO4Meicgri9C1IBS2y3Sc8i
 +T4kFOBB8NTAV05Vq46a9r2p7+1lXQQnuNpGUzTPtRJfEzq/KBmKiHxirk8JMRkxRDrn2PFi
 FjJWklIzQXLi8gH6vb7v6uKlLr3MLJFPHtfLkrnxKnjYEE2+ULmm+esSt2gcjHaUW7o5KSKa
 ONTwvz6NvBBl1FP26J4ErB23ec96sHpqrty0AtpBjPIYk6tB7cmJWOJtfSjrYUUnvkJ403vC
 gTWoYMy1ai1Bf4J2WU5fGINBtlvH9lN8tUOxZzZ+HnH2RI=
IronPort-HdrOrdr: A9a23:KFXm3q5YaTDQcsSYqQPXwK3XdLJyesId70hD6qm+c3Bom62j5q
 OTdZsguyMc5Ax6ZJhCo7C90cu7IE80nKQdieIs1NyZMzUO1lHEEL1f
X-Talos-CUID: 9a23:cDe7g2G4ejfIb6WMqmJk2UIqIt48IkfS1Wv3c0qkAD5wVKOaHAo=
X-Talos-MUID: 9a23:FAR4vQi4Ys6iaIKTTisln8Mpc/VyzJaUA042rMsl4vKmBClBGAu0k2Hi
X-IronPort-AV: E=Sophos;i="6.13,309,1732575600"; 
   d="p7s'346?scan'346,208,346";a="107767368"
From: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH] pps: add epoll support
Date: Mon, 24 Feb 2025 12:38:50 +0100 (CET)
Message-ID: <0653b036d2b44d57914f8cb3e405aa0d@diehl.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----55641D40FC72EAA65106898A5DCFE30C"

This is an S/MIME signed message

------55641D40FC72EAA65106898A5DCFE30C
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I tested it today and that patch creates not the expected behavior.

With your patch:
```
# cat /sys/class/pps/pps1/assert; PpsPollTest /dev/pps1; cat =
/sys/class/pps/pps1/assert
1520599141.381117584#77
timeout
timeout
timeout
1520599147.529114368#83
```

And pps-ktimer without POLL flag restores current behavor:

diff --git a/drivers/pps/clients/pps-ktimer.c =
b/drivers/pps/clients/pps-ktimer.c
index d33106bd7..07a804c35 100644
--- a/drivers/pps/clients/pps-ktimer.c
+++ b/drivers/pps/clients/pps-ktimer.c
@@ -46,7 +46,7 @@ static struct pps_source_info pps_ktimer_info =3D {
        .path           =3D "",
        .mode           =3D PPS_CAPTUREASSERT | PPS_OFFSETASSERT |
                          PPS_ECHOASSERT |
-                         PPS_CANWAIT | PPS_TSFMT_TSPEC,
+                         PPS_TSFMT_TSPEC,
        .owner          =3D THIS_MODULE,
 };

```
# cat /sys/class/pps/pps1/mode
1051
# cat /sys/class/pps/pps1/assert; PpsPollTest /dev/pps1; cat =
/sys/class/pps/pps1/assert
1520598959.622011600#45
assert: 45
time: 1520598959.622011600
assert: 45
time: 1520598959.622011600
assert: 45
time: 1520598959.622011600
1520598959.622011600#45
```

The idea is to use poll to wait for the next data become available.
The should poll work like `wait_event_interruptible(pps->queue, ev !=3D =
pps->last_ev)`,
where `poll_wait(file, &pps->queue, wait)` already does the first part,
but the condition `ev !=3D pps->last_ev` is missing.

Poll shall return 0 if ev =3D=3D ps->last_ev
and shall return EPOLLIN if ev !=3D ps->last_ev; EPOLLRDNORM is =
equivalent[^1] so better return both

In case of ioctl(PPS_FETCH) ev is stored on the stack.
If two applications access one pps device, they both get the right =
result, because the wait_event uses the ev from their stack.
To do so with poll() ev needs to be available via file, because every =
applications opens a sepate file and the file is passed to poll.
That is what my patch does.
It adds a per file storage so that poll has the ev value of the last =
fetch to compare.

If you want to avoid this extra alloc and derefers, we may use file =
position (file.f_pos) to store last fetched ev value.
The pps does not provide read/write, so f_pos is unused anyway.

I am a little bit puzzeled about your second diff.
Every pps client that uses pps_event() supports WAITEVENT, because this =
is in the generic part.
To me not using pps_event() but reimplement parts of pps_event() seems =
to be a bad idea.
That=E2=80=99s why I thing that this diff is not needed.

Regards, Denis

[^1]: https://man7.org/linux/man-pages/man2/poll.2.html


-----Original Message-----
From: Rodolfo Giometti <giometti@enneenne.com>=20
Sent: Friday, February 21, 2025 12:40 PM
To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pps: add epoll support
=20

On 21/02/25 11:49, Denis OSTERLAND-HEIM wrote:
> Hi,
>=20
> Okay, if poll is expected to work, than we have a bug.
> Actually a pretty old one.
>=20
> pps_cdev_poll() uncoditionally returns (EPOLLIN | EPOLLRDNORM), which =
results in poll() will return immediately with data available
> (EPOLLIN | EPOLLRDNORM).
> To avoid this, you need conditionally return 0.

I think you are right!

Looking at the code I think the correct patch should be:

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 6a02245ea35f..7a52bb9f835b 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -41,7 +41,7 @@ static __poll_t pps_cdev_poll(struct file *file, =
poll_table *wait)

         poll_wait(file, &pps->queue, wait);

-       return EPOLLIN | EPOLLRDNORM;
+       return pps->info.mode & PPS_CANWAIT ? 0 : EPOLLIN | EPOLLRDNORM;
  }

  static int pps_cdev_fasync(int fd, struct file *file, int on)

> My patch adds a context per open file to store the last_ev value when =
ioctl(PPS_FETCH) is invoked and uses this last_ev in poll as
> condition.
>=20
> Sorry, for the missing memset(&fdata, 0, sizeof(fdata)).
> Intention was set to 0, yes.

OK

> ```c
> #include <stdio.h>
> #include =
<string.h>///home/giometti/Projects/ailux/imx9/linux/linux-imx
> #include <poll.h>
> #include <fcntl.h>
> #include "timepps.h"
>=20
> int main(int argc, const char* argv[]) {
>      struct pollfd instance =3D { .fd =3D open((argc > 1) ? argv[1] : =
"/dev/pps0", O_RDONLY), .events =3D POLLIN|POLLERR , .revents =3D 0 };
>      pps_handle_t pps_handle;
>      static const struct timespec timeout =3D { 0, 0 };
>      if (time_pps_create(instance.fd, &pps_handle)) {
>          perror("failed to create pps handle");
>          return 1;
>      }
>      for (int loops =3D 4; --loops; ) {
>          pps_info_t pps_info;
>          memset(&pps_info, 0, sizeof(pps_info));
>          if (!poll(&instance, 1, 2000/*ms*/)) {
>              printf("timeout");
>              continue;
>          }
>          if ((instance.revents & POLLIN) !=3D POLLIN) {
>              printf("nothing to read?");
>              continue;
>          }
>          if (time_pps_fetch(pps_handle, PPS_TSFMT_TSPEC, &pps_info, =
&timeout)) {
>              perror("failed to fetch");
>              return 1;
>          }
>=20
>          printf(
>              "assert: %lu\ntime: %ld.%09ld\n",
>              pps_info.assert_sequence,
>              pps_info.assert_tu.tspec.tv_sec,
>              pps_info.assert_tu.tspec.tv_nsec
>          );
>      }
>      return 0;
> }
> ```
>=20
> Currently output looks like:
> ```
> $ cat /sys/class/pps/pps0/assert; ./test /dev/pps0
> 1520598954.468882076#60
> assert: 60
> time: 1520598954.468882076
> assert: 60
> time: 1520598954.468882076
> assert: 60
> time: 1520598954.468882076
> ```
>=20
> You see no waits between the loops.

Please, try again with the above patch.

However, before doing the test, you should consider to add this patch =
too:

diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 6a02245ea35f..7a52bb9f835b 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -56,10 +56,13 @@ static int pps_cdev_pps_fetch(struct pps_device =
*pps, struct=20
pps_fdata *fdata)
         int err =3D 0;

         /* Manage the timeout */
-       if (fdata->timeout.flags & PPS_TIME_INVALID)
-               err =3D wait_event_interruptible(pps->queue,
+       if (fdata->timeout.flags & PPS_TIME_INVALID) {
+               if (pps->info.mode & PPS_CANWAIT)
+                       err =3D wait_event_interruptible(pps->queue,
                                 ev !=3D pps->last_ev);
-       else {
+               else
+                       return -EOPNOTSUPP;
+       } else {
                 unsigned long ticks;

                 dev_dbg(&pps->dev, "timeout %lld.%09d\n",
@@ -69,12 +72,15 @@ static int pps_cdev_pps_fetch(struct pps_device =
*pps, struct=20
pps_fdata *fdata)
                 ticks +=3D fdata->timeout.nsec / (NSEC_PER_SEC / HZ);

                 if (ticks !=3D 0) {
-                       err =3D wait_event_interruptible_timeout(
+                       if (pps->info.mode & PPS_CANWAIT) {
+                               err =3D =
wait_event_interruptible_timeout(
                                         pps->queue,
                                         ev !=3D pps->last_ev,
                                         ticks);
-                       if (err =3D=3D 0)
-                               return -ETIMEDOUT;
+                               if (err =3D=3D 0)
+                                       return -ETIMEDOUT;
+                       } else
+                               return -EOPNOTSUPP;
                 }
         }

In fact RFC2783 states:

3.4.3 New functions: access to PPS timestamps

...
    Support for blocking behavior is an implementation option.  If the
    PPS_CANWAIT mode bit is clear, and the timeout parameter is either
    NULL or points to a non-zero value, the function returns an
    EOPNOTSUPP error.  An application can discover whether the feature =
is
    implemented by using time_pps_getcap() to see if the PPS_CANWAIT =
mode
    bit is set.
...

Ciao,

Rodolfo

--=20
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming

------55641D40FC72EAA65106898A5DCFE30C
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

------55641D40FC72EAA65106898A5DCFE30C--


