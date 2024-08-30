Return-Path: <linux-kernel+bounces-308799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F039661F1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE751C22AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267CA19E81F;
	Fri, 30 Aug 2024 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFZ4jOGU"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818C17B4FF
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021929; cv=none; b=K8cZIISCI2eB5KcLHgvUnB5pVvhxKLSMvF7X3BHf1JZF4s+ahe0i3laVQPc6pMXPt2vHO1kCEjahHG+dbAsKbZkCcXy249QJDUSZicDV65FINVLbb+WQzyc+n/kEyO32Jq1p45tKBkKyVLlHI/VD2yxLxkCmp1mPciBGK+xAVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021929; c=relaxed/simple;
	bh=tsvBTMNGelacg0MBdkaWhbc4QkoaLsOOrjGxNenUYGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bpi7e41yP+cz/80K6e+hhbbjeWYHvU6OyHaVE8Lq/qemDxnKl8eyFBhUAC2HQQGYBzft0E+HykIiFzjE3+30hl9qqXLYV8D1qZtjmcqoPf0AwkluCFIXOrV+rSB1jEbPs1kWp5c0kb3UqbCXGc+NI+1QJbN9bbGNgdoLq85KvRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mFZ4jOGU; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3da054f7cso1336562a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725021927; x=1725626727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h+FeDiOcpzd3lJd+qmUqBuaQarh+ne7xi28njktI5ho=;
        b=mFZ4jOGUUlh+c/xvgDRTaP7bGiE8UxrWiiCg2zIGBJYnVlG92nVq7cYymEpbAuTWA4
         duOJC3N89LrN4WYsJQzUhvINiWSl9OaKZ+BQQaChUfqcJpPlT+v1O/YEr5AZ1BVmqqD2
         7zSkG8vfmiazovZ/c1x2t8eMpu49ZbHwGDMGAdSapwhxdEPWyG0DiLKKFfV7P1xze+Hc
         nRWUt2DR5xEE4kEOc3RMhPUr97pUqU+0703kyJKFmufq58K3dbkFBrOzK8Vkz1zX2yyy
         nfvoPsIWN1La0AJFYDFJjLsDIbddOPZCC/a57lpxys3Aj+ouGH3vq6sDrg1DA2Idjfnj
         cdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725021927; x=1725626727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+FeDiOcpzd3lJd+qmUqBuaQarh+ne7xi28njktI5ho=;
        b=vTAZz1Dm6navwq7h8TrrCmRnqdNNnKGqDYk24U341Jb1WKBRI9vPFcZttzRq95YWo9
         Hp1jTQ5MPYz1yYHY5QZb2W+6gtsKiyEBPQeqCQp7ESr1i0Y+n0KT6sW6mHbkhYfD8A2U
         Kh3K7ubkEWSIoEyzBtEtAz9spMykXqCHU8I6JMdqPXQJcM0i6cCBLNTXrJc0STV/pq1y
         R4rZW3bYs1HgGQQsls1gvSV5Pf+ZcISXfPK2aTiu8/LIwHwM2xN9NGA0L0kIfZgXJnxh
         n8O7ha3c5om2KsKXrOOgKb7ZjlxpVbbBIBwv8TXk4qFT3NFDqkZ8Jqr2pAv7H8PXNPFC
         0ujg==
X-Forwarded-Encrypted: i=1; AJvYcCWaSitezDWI5ixu/wZfIiKvaRz39rFhODCF7kBdgnp1MNm7fd6KvsQi8nDcAzWK10bRt5bVP1u2f52/zq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/YT+Axu59OgBr+a/JM++fhtg29qERzmKAhnSQL+Kyl4QIsQe
	CEa21+iIIKyzQ2RJWNww4v44AFua5pYg/ub+gs8bX91ZPp0He0sznc5Y0Hwms65Yc1ae+UkW4kL
	fo6piHUWI7M/ynXb/nwfWQwDk0JGULgZYTcN6pQ==
X-Google-Smtp-Source: AGHT+IFEQvBrajKYsIPrpesMzMtNU+hSj5XsOPGysSUaZdKosTU+5bxslUcUHn8MTqNmL8GEeJEI7qVtcJgvKjtbqqg=
X-Received: by 2002:a17:90b:242:b0:2d1:b49d:7f2 with SMTP id
 98e67ed59e1d1-2d8561db63emr6652223a91.22.1725021926710; Fri, 30 Aug 2024
 05:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-6MJC+D0DzxLOpVvCbYzHE-r1YzNORtpOh-f+hgEkMjzg@mail.gmail.com>
 <CAKfTPtDLS07TuK+-vZY9B2azSPUDdpXNCSxMuRmo7m=F+5MPvQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDLS07TuK+-vZY9B2azSPUDdpXNCSxMuRmo7m=F+5MPvQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 30 Aug 2024 14:45:15 +0200
Message-ID: <CAKfTPtBWtrcpagubeB4BS8p0NQd9fSsJJny8YWb2QHgTmZ4Wnw@mail.gmail.com>
Subject: Re: BUG: WARNING: ODEBUG bug in schedule_timeout
To: Xingyu Li <xli399@ucr.edu>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Aug 2024 at 14:43, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Xingyu,
>
> On Wed, 28 Aug 2024 at 23:05, Xingyu Li <xli399@ucr.edu> wrote:
> >
> > Hi,
> >
> > We found a bug in Linux 6.10. It is possibly a use-before-initialization  bug.

...

> >
> > C reproducer:
> > // autogenerated by syzkaller (https://github.com/google/syzkaller)

I tried the reproducer below on my system but nothing happens after a
night of run

> >
> > #define _GNU_SOURCE
> >
> > #include <dirent.h>
> > #include <endian.h>
> > #include <errno.h>
> > #include <fcntl.h>
> > #include <signal.h>
> > #include <stdarg.h>
> > #include <stdbool.h>
> > #include <stdint.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <sys/prctl.h>
> > #include <sys/stat.h>
> > #include <sys/syscall.h>
> > #include <sys/types.h>
> > #include <sys/wait.h>
> > #include <time.h>
> > #include <unistd.h>
> >
> > static void sleep_ms(uint64_t ms)
> > {
> >   usleep(ms * 1000);
> > }
> >
> > static uint64_t current_time_ms(void)
> > {
> >   struct timespec ts;
> >   if (clock_gettime(CLOCK_MONOTONIC, &ts))
> >     exit(1);
> >   return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> > }
> >
> > static bool write_file(const char* file, const char* what, ...)
> > {
> >   char buf[1024];
> >   va_list args;
> >   va_start(args, what);
> >   vsnprintf(buf, sizeof(buf), what, args);
> >   va_end(args);
> >   buf[sizeof(buf) - 1] = 0;
> >   int len = strlen(buf);
> >   int fd = open(file, O_WRONLY | O_CLOEXEC);
> >   if (fd == -1)
> >     return false;
> >   if (write(fd, buf, len) != len) {
> >     int err = errno;
> >     close(fd);
> >     errno = err;
> >     return false;
> >   }
> >   close(fd);
> >   return true;
> > }
> >
> > static long syz_open_dev(volatile long a0, volatile long a1, volatile long a2)
> > {
> >   if (a0 == 0xc || a0 == 0xb) {
> >     char buf[128];
> >     sprintf(buf, "/dev/%s/%d:%d", a0 == 0xc ? "char" : "block", (uint8_t)a1,
> >             (uint8_t)a2);
> >     return open(buf, O_RDWR, 0);
> >   } else {
> >     char buf[1024];
> >     char* hash;
> >     strncpy(buf, (char*)a0, sizeof(buf) - 1);
> >     buf[sizeof(buf) - 1] = 0;
> >     while ((hash = strchr(buf, '#'))) {
> >       *hash = '0' + (char)(a1 % 10);
> >       a1 /= 10;
> >     }
> >     return open(buf, a2, 0);
> >   }
> > }
> >
> > static void kill_and_wait(int pid, int* status)
> > {
> >   kill(-pid, SIGKILL);
> >   kill(pid, SIGKILL);
> >   for (int i = 0; i < 100; i++) {
> >     if (waitpid(-1, status, WNOHANG | __WALL) == pid)
> >       return;
> >     usleep(1000);
> >   }
> >   DIR* dir = opendir("/sys/fs/fuse/connections");
> >   if (dir) {
> >     for (;;) {
> >       struct dirent* ent = readdir(dir);
> >       if (!ent)
> >         break;
> >       if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
> >         continue;
> >       char abort[300];
> >       snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
> >                ent->d_name);
> >       int fd = open(abort, O_WRONLY);
> >       if (fd == -1) {
> >         continue;
> >       }
> >       if (write(fd, abort, 1) < 0) {
> >       }
> >       close(fd);
> >     }
> >     closedir(dir);
> >   } else {
> >   }
> >   while (waitpid(-1, status, __WALL) != pid) {
> >   }
> > }
> >
> > static void setup_test()
> > {
> >   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
> >   setpgrp();
> >   write_file("/proc/self/oom_score_adj", "1000");
> > }
> >
> > static void execute_one(void);
> >
> > #define WAIT_FLAGS __WALL
> >
> > static void loop(void)
> > {
> >   int iter = 0;
> >   for (;; iter++) {
> >     int pid = fork();
> >     if (pid < 0)
> >       exit(1);
> >     if (pid == 0) {
> >       setup_test();
> >       execute_one();
> >       exit(0);
> >     }
> >     int status = 0;
> >     uint64_t start = current_time_ms();
> >     for (;;) {
> >       sleep_ms(10);
> >       if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
> >         break;
> >       if (current_time_ms() - start < 5000)
> >         continue;
> >       kill_and_wait(pid, &status);
> >       break;
> >     }
> >   }
> > }
> >
> > uint64_t r[1] = {0xffffffffffffffff};
> >
> > void execute_one(void)
> > {
> >   intptr_t res = 0;
> >   if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {
> >   }
> >   memcpy((void*)0x20000000,
> >          "\x2b\x95\x24\x80\xc7\xca\x55\x09\x7d\x17\x07\x93\x5b\xa6\x4b\x20\xf3"
> >          "\x02\x6c\x03\xd6\x58\x02\x6b\x81\xbf\x26\x43\x40\x51\x2b\x3c\xb4\xe0"
> >          "\x1a\xfd\xa2\xde\x75\x42\x99\xea\x7a\x11\x33\x43\xab\x7b\x9b\xda\x2f"
> >          "\xc0\xa2\xe2\xcd\xbf\xec\xbc\xa0\x23\x3a\x07\x72\xb1\x2e\xbd\xe5\xd9"
> >          "\x8a\x12\x03\xcb\x87\x16\x72\xdf\xf7\xe4\xc8\x6e\xc1\xdc\xce\xf0\xa7"
> >          "\x63\x12\xfb\xe8\xd4\x5d\xc2\xbd\x0f\x8f\xc2\xeb\xeb\x2a\x6b\xe6\xa3"
> >          "\x00\x91\x6c\x52\x81\xda\x2c\x1e\xf6\x4d\x66\x26\x70\x91\xb8\x24\x29"
> >          "\x97\x6c\x01\x9d\xa3\x64\x55\x57\xed\x1d\x43\x9c\x5a\x63\x7f\x6b\xf5"
> >          "\x8c\x53\xbc\x41\x45\x39\xdd\x87\xc6\x90\x98\xd6\x71\x40\x25\x86\xb6"
> >          "\x31\xf9\xac\x5c\x2f\xe9\xce\xdc\x28\x1a\x6f\x00\x5b\x5c\x4d\x1d\xd5"
> >          "\xed\x9b\xe4\x00\x00\x00\x00\x00\x00\x00",
> >          180);
> >   syscall(__NR_write, /*fd=*/-1, /*arg0=*/0x20000000ul, /*len=*/0xb4ul);
> >   memcpy((void*)0x20000080, "/dev/sg#\000", 9);
> >   res = -1;
> >   res = syz_open_dev(/*dev=*/0x20000080, /*id=*/0,
> >                      /*flags=O_CREAT|FASYNC|O_RDWR*/ 0x2042);
> >   if (res != -1)
> >     r[0] = res;
> >   *(uint32_t*)0x20000080 = 0;
> >   *(uint32_t*)0x20000084 = 2;
> >   *(uint8_t*)0x20000088 = 0x85;
> >   *(uint8_t*)0x20000089 = 8;
> >   *(uint8_t*)0x2000008a = 2;
> >   *(uint8_t*)0x2000008b = 0xd;
> >   syscall(__NR_ioctl, /*fd=*/r[0], /*arg0=*/1, /*arg1=*/0x20000080ul);
> > }
> > int main(void)
> > {
> >   syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
> >           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
> >           /*offset=*/0ul);
> >   syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
> >           /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
> >           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
> >           /*offset=*/0ul);
> >   syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
> >           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
> >           /*offset=*/0ul);
> >   const char* reason;
> >   (void)reason;
> >   loop();
> >   return 0;
> > }
> >
> > --
> > Yours sincerely,
> > Xingyu

