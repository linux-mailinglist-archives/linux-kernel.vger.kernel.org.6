Return-Path: <linux-kernel+bounces-309433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0619966A62
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61441F239E7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1264B1BF335;
	Fri, 30 Aug 2024 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="rDcIY1Tw";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="S24IKoZk"
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833813B297
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049417; cv=none; b=XK0QrepxUnqGvt5PTPVg/RySDai4KzNGiU0SsbXRotRJ+wLA8BlO9JplT6N6JVsRbN7dqZ3kPg4Eai5X9ZxL5jPhdaJAlZR8oWWeZ/RXQDkCPP9oWvnMWbrE4pClqASmdS4vinA03s0JJGuoxCc3foOqGiiFSVz72TVTiBcl5oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049417; c=relaxed/simple;
	bh=JZr1xF6lX+Sp2Tsnz9zwwp9q0yrDW5nA1a6xqCxC3Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJ6O/jeAW1ikKfQAalPhbOqnBoZNLHasTGt9C83SX2L10mCATTShOVCcfVFRtprhRoq1/LPLsT6v1zx9r5SII1Bm7icR6PrEI5jwrWsWQ5CRmCbrlnkWm/yi9ul0g6tUn5hxCVkCjnKRai9hWGhc1gbUEF7slM/H3kq+p0oKE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=rDcIY1Tw; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=S24IKoZk; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1725049416; x=1756585416;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=JZr1xF6lX+Sp2Tsnz9zwwp9q0yrDW5nA1a6xqCxC3Vw=;
  b=rDcIY1TwYJiYoXvZ1PIIZzBs7DZrl5kwiCjUqoMkp3sl9H576OSe8fEl
   JHWDG2DK2wmwSAFNAzqZtMJsWlvqN3+HZx9hvbuECtp0xsKV6PK+3KWUi
   L9gIwUk3+09xNkskVTkUtMHGajwOMobejVNbQaffvdY8TZo4VgQD/90MM
   LsMDTALjClvEq9xMv8HzhO7O+m8mbNXOQ1NggahmLPDez46LyzXesNs4i
   /D6gP1byQZnOatYqxo3I+lxAvXcT4OL/fK0xABsLmnuhTkfr6pZuQrYGU
   AdEev+jxw9qNTffcZqfkCzmBzMdzxsmqADZO+dfK18FP8AATBQ3Kl6Wwl
   w==;
X-CSE-ConnectionGUID: S9XYyAkjRW66M2HcYICQNA==
X-CSE-MsgGUID: qpMkt1uaQ26jGmdFtdgWxQ==
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 30 Aug 2024 13:23:30 -0700
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d877d2ad3fso865058a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1725049409; x=1725654209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJpsWVww96PuMSCJlY5KyvPLWMxy1mJ7w+wr7vOcwX8=;
        b=S24IKoZkJKCaVfY4GlEaRadLHDyOkurm+dKxbrM7XH/lturc+j+HDDJCZr0q8Dx68c
         UesMx7GgDm22LF3D3vKzF1lD1z+gSp27zNB6dMdPjoWBA9cxXgjM4IVEm+5b9B84NbqW
         YKzAv9DAlpes8B6qZ2tnftgE5VQas6wlaN/04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049409; x=1725654209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJpsWVww96PuMSCJlY5KyvPLWMxy1mJ7w+wr7vOcwX8=;
        b=IPeHjrPV/L7weQLOR30ljdiTYMznmKhM33qOw+/XAYMhW57w7aQRR1QxsIqOQv6j82
         mzadhQWHNOMtPWRnTfuI0xulV4bffA0B+uhd3/dimyQJPaaiouRD1+waXFXx9zXbyB1O
         kwPbqZmTNlBOJBcx5Np+5UQKw0dKUuCuLPvgu7e5u6WaST1StGKUsoO/UJRJd8+yYqG0
         XqqVeRWXsJPc8V4dkbFfXxdAOiNwkvP+1v2gZX3uHQjYum04/cQXl+yqlzux7afmAa4V
         +oroJ0y1LqxnSyICO/9f1FpOefwnTg/DZhMlX3cJVyehClVmCqmI4w0Xex1CramzMiIN
         9MVg==
X-Forwarded-Encrypted: i=1; AJvYcCWplF45rwptCCD+ONqYuQcglS3pu5fgmtcqsFgeFfE+HGoUvyKcdQNqBAmUK7yfwWN2u/G1XwG2ivnjL/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFDjPZXSluKCuOKX+7Lf1muQuu9wRLsBVxqqJSez6/BzQSzf8G
	BOydvycdncYTSrZBHIHzWKdf524xbdB1V1BaL7dgpYhsb8Bchn+876HdFrItdEKHiTabmHzO8B9
	IhUt2hbWW12gW7wbn3cb5+Uwg1zyrlM7ne5Mrzm/TN9wcBHzL+W9WDYiD1fSOClQ4F9X0hWAoVZ
	yHGDBWG0m/TgIrMCay38PeoKw9UIXwrQ6kJskhrg==
X-Received: by 2002:a17:90b:4a02:b0:2d3:ba42:774b with SMTP id 98e67ed59e1d1-2d8561a36ffmr8019495a91.16.1725049408663;
        Fri, 30 Aug 2024 13:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc8kQpSJ8Yxb/ETARuBuXvV6qM28yhp8gYXAhkltUsvH1ooXJXTGY/X4iZZJl72itcMbgfqrmqiTsxXzExJW8=
X-Received: by 2002:a17:90b:4a02:b0:2d3:ba42:774b with SMTP id
 98e67ed59e1d1-2d8561a36ffmr8019472a91.16.1725049408288; Fri, 30 Aug 2024
 13:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-6MJC+D0DzxLOpVvCbYzHE-r1YzNORtpOh-f+hgEkMjzg@mail.gmail.com>
 <CAKfTPtDLS07TuK+-vZY9B2azSPUDdpXNCSxMuRmo7m=F+5MPvQ@mail.gmail.com> <CAKfTPtBWtrcpagubeB4BS8p0NQd9fSsJJny8YWb2QHgTmZ4Wnw@mail.gmail.com>
In-Reply-To: <CAKfTPtBWtrcpagubeB4BS8p0NQd9fSsJJny8YWb2QHgTmZ4Wnw@mail.gmail.com>
From: Xingyu Li <xli399@ucr.edu>
Date: Fri, 30 Aug 2024 13:23:17 -0700
Message-ID: <CALAgD-6=ssqeeZKmW67CyX=jDBf8AsS-O=3JzRdORkAA9psgZg@mail.gmail.com>
Subject: Re: BUG: WARNING: ODEBUG bug in schedule_timeout
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Have you tried to reproduce the problem Linux 6.11 ?

I did not try it on 6.11, but tried it on 6.10 and it was triggered.

I tried the reproducer below on my system but nothing happens after a
night of run

Which configurations do you use? You can use this config file:
https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd.

On Fri, Aug 30, 2024 at 5:45=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 30 Aug 2024 at 14:43, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Hi Xingyu,
> >
> > On Wed, 28 Aug 2024 at 23:05, Xingyu Li <xli399@ucr.edu> wrote:
> > >
> > > Hi,
> > >
> > > We found a bug in Linux 6.10. It is possibly a use-before-initializat=
ion  bug.
>
> ...
>
> > >
> > > C reproducer:
> > > // autogenerated by syzkaller (https://github.com/google/syzkaller)
>
> I tried the reproducer below on my system but nothing happens after a
> night of run
>
> > >
> > > #define _GNU_SOURCE
> > >
> > > #include <dirent.h>
> > > #include <endian.h>
> > > #include <errno.h>
> > > #include <fcntl.h>
> > > #include <signal.h>
> > > #include <stdarg.h>
> > > #include <stdbool.h>
> > > #include <stdint.h>
> > > #include <stdio.h>
> > > #include <stdlib.h>
> > > #include <string.h>
> > > #include <sys/prctl.h>
> > > #include <sys/stat.h>
> > > #include <sys/syscall.h>
> > > #include <sys/types.h>
> > > #include <sys/wait.h>
> > > #include <time.h>
> > > #include <unistd.h>
> > >
> > > static void sleep_ms(uint64_t ms)
> > > {
> > >   usleep(ms * 1000);
> > > }
> > >
> > > static uint64_t current_time_ms(void)
> > > {
> > >   struct timespec ts;
> > >   if (clock_gettime(CLOCK_MONOTONIC, &ts))
> > >     exit(1);
> > >   return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> > > }
> > >
> > > static bool write_file(const char* file, const char* what, ...)
> > > {
> > >   char buf[1024];
> > >   va_list args;
> > >   va_start(args, what);
> > >   vsnprintf(buf, sizeof(buf), what, args);
> > >   va_end(args);
> > >   buf[sizeof(buf) - 1] =3D 0;
> > >   int len =3D strlen(buf);
> > >   int fd =3D open(file, O_WRONLY | O_CLOEXEC);
> > >   if (fd =3D=3D -1)
> > >     return false;
> > >   if (write(fd, buf, len) !=3D len) {
> > >     int err =3D errno;
> > >     close(fd);
> > >     errno =3D err;
> > >     return false;
> > >   }
> > >   close(fd);
> > >   return true;
> > > }
> > >
> > > static long syz_open_dev(volatile long a0, volatile long a1, volatile=
 long a2)
> > > {
> > >   if (a0 =3D=3D 0xc || a0 =3D=3D 0xb) {
> > >     char buf[128];
> > >     sprintf(buf, "/dev/%s/%d:%d", a0 =3D=3D 0xc ? "char" : "block", (=
uint8_t)a1,
> > >             (uint8_t)a2);
> > >     return open(buf, O_RDWR, 0);
> > >   } else {
> > >     char buf[1024];
> > >     char* hash;
> > >     strncpy(buf, (char*)a0, sizeof(buf) - 1);
> > >     buf[sizeof(buf) - 1] =3D 0;
> > >     while ((hash =3D strchr(buf, '#'))) {
> > >       *hash =3D '0' + (char)(a1 % 10);
> > >       a1 /=3D 10;
> > >     }
> > >     return open(buf, a2, 0);
> > >   }
> > > }
> > >
> > > static void kill_and_wait(int pid, int* status)
> > > {
> > >   kill(-pid, SIGKILL);
> > >   kill(pid, SIGKILL);
> > >   for (int i =3D 0; i < 100; i++) {
> > >     if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
> > >       return;
> > >     usleep(1000);
> > >   }
> > >   DIR* dir =3D opendir("/sys/fs/fuse/connections");
> > >   if (dir) {
> > >     for (;;) {
> > >       struct dirent* ent =3D readdir(dir);
> > >       if (!ent)
> > >         break;
> > >       if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, ".=
.") =3D=3D 0)
> > >         continue;
> > >       char abort[300];
> > >       snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abo=
rt",
> > >                ent->d_name);
> > >       int fd =3D open(abort, O_WRONLY);
> > >       if (fd =3D=3D -1) {
> > >         continue;
> > >       }
> > >       if (write(fd, abort, 1) < 0) {
> > >       }
> > >       close(fd);
> > >     }
> > >     closedir(dir);
> > >   } else {
> > >   }
> > >   while (waitpid(-1, status, __WALL) !=3D pid) {
> > >   }
> > > }
> > >
> > > static void setup_test()
> > > {
> > >   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
> > >   setpgrp();
> > >   write_file("/proc/self/oom_score_adj", "1000");
> > > }
> > >
> > > static void execute_one(void);
> > >
> > > #define WAIT_FLAGS __WALL
> > >
> > > static void loop(void)
> > > {
> > >   int iter =3D 0;
> > >   for (;; iter++) {
> > >     int pid =3D fork();
> > >     if (pid < 0)
> > >       exit(1);
> > >     if (pid =3D=3D 0) {
> > >       setup_test();
> > >       execute_one();
> > >       exit(0);
> > >     }
> > >     int status =3D 0;
> > >     uint64_t start =3D current_time_ms();
> > >     for (;;) {
> > >       sleep_ms(10);
> > >       if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
> > >         break;
> > >       if (current_time_ms() - start < 5000)
> > >         continue;
> > >       kill_and_wait(pid, &status);
> > >       break;
> > >     }
> > >   }
> > > }
> > >
> > > uint64_t r[1] =3D {0xffffffffffffffff};
> > >
> > > void execute_one(void)
> > > {
> > >   intptr_t res =3D 0;
> > >   if (write(1, "executing program\n", sizeof("executing program\n") -=
 1)) {
> > >   }
> > >   memcpy((void*)0x20000000,
> > >          "\x2b\x95\x24\x80\xc7\xca\x55\x09\x7d\x17\x07\x93\x5b\xa6\x4=
b\x20\xf3"
> > >          "\x02\x6c\x03\xd6\x58\x02\x6b\x81\xbf\x26\x43\x40\x51\x2b\x3=
c\xb4\xe0"
> > >          "\x1a\xfd\xa2\xde\x75\x42\x99\xea\x7a\x11\x33\x43\xab\x7b\x9=
b\xda\x2f"
> > >          "\xc0\xa2\xe2\xcd\xbf\xec\xbc\xa0\x23\x3a\x07\x72\xb1\x2e\xb=
d\xe5\xd9"
> > >          "\x8a\x12\x03\xcb\x87\x16\x72\xdf\xf7\xe4\xc8\x6e\xc1\xdc\xc=
e\xf0\xa7"
> > >          "\x63\x12\xfb\xe8\xd4\x5d\xc2\xbd\x0f\x8f\xc2\xeb\xeb\x2a\x6=
b\xe6\xa3"
> > >          "\x00\x91\x6c\x52\x81\xda\x2c\x1e\xf6\x4d\x66\x26\x70\x91\xb=
8\x24\x29"
> > >          "\x97\x6c\x01\x9d\xa3\x64\x55\x57\xed\x1d\x43\x9c\x5a\x63\x7=
f\x6b\xf5"
> > >          "\x8c\x53\xbc\x41\x45\x39\xdd\x87\xc6\x90\x98\xd6\x71\x40\x2=
5\x86\xb6"
> > >          "\x31\xf9\xac\x5c\x2f\xe9\xce\xdc\x28\x1a\x6f\x00\x5b\x5c\x4=
d\x1d\xd5"
> > >          "\xed\x9b\xe4\x00\x00\x00\x00\x00\x00\x00",
> > >          180);
> > >   syscall(__NR_write, /*fd=3D*/-1, /*arg0=3D*/0x20000000ul, /*len=3D*=
/0xb4ul);
> > >   memcpy((void*)0x20000080, "/dev/sg#\000", 9);
> > >   res =3D -1;
> > >   res =3D syz_open_dev(/*dev=3D*/0x20000080, /*id=3D*/0,
> > >                      /*flags=3DO_CREAT|FASYNC|O_RDWR*/ 0x2042);
> > >   if (res !=3D -1)
> > >     r[0] =3D res;
> > >   *(uint32_t*)0x20000080 =3D 0;
> > >   *(uint32_t*)0x20000084 =3D 2;
> > >   *(uint8_t*)0x20000088 =3D 0x85;
> > >   *(uint8_t*)0x20000089 =3D 8;
> > >   *(uint8_t*)0x2000008a =3D 2;
> > >   *(uint8_t*)0x2000008b =3D 0xd;
> > >   syscall(__NR_ioctl, /*fd=3D*/r[0], /*arg0=3D*/1, /*arg1=3D*/0x20000=
080ul);
> > > }
> > > int main(void)
> > > {
> > >   syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*p=
rot=3D*/0ul,
> > >           /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*f=
d=3D*/-1,
> > >           /*offset=3D*/0ul);
> > >   syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,
> > >           /*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
> > >           /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*f=
d=3D*/-1,
> > >           /*offset=3D*/0ul);
> > >   syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*p=
rot=3D*/0ul,
> > >           /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*f=
d=3D*/-1,
> > >           /*offset=3D*/0ul);
> > >   const char* reason;
> > >   (void)reason;
> > >   loop();
> > >   return 0;
> > > }
> > >
> > > --
> > > Yours sincerely,
> > > Xingyu



--=20
Yours sincerely,
Xingyu

