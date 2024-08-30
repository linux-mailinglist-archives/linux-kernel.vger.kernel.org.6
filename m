Return-Path: <linux-kernel+bounces-308796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110129661EB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F81F1F25A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3783199FA4;
	Fri, 30 Aug 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnMVlekn"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17371898E5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021842; cv=none; b=LSgZVXomQ+ZaoDZpMTPuKUlj5cxpBdrAzWGzkiDUwms3U155WNkb2DmZ+D7MnjJssSzssjOtk9/0KKUmWzmd06o9RqCw8CuLStRz0tSsyDZ7Pr/TS9LkHCIr1jLCOm2LwVDx0B3eyi4pHV7RzSMXojlmE9NjWNOIXYN0DYsKAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021842; c=relaxed/simple;
	bh=IIR7X7ZKi/J6Hccgm1wdFU84yD/RxzGbOczmuEkRgS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTIB8lt4cCgGQyxvJALEJRQHcmZhTUjXg+VKMzuzGEelxpolKzMkaPdir8oyRRaI+JriHNsP2ssnibzdpmXsOzzjT5UfNXog1yKxvgqSV5zB9Anh9kms3Q0duWet3YpjPUfF10bPMcl/5wyMAXkxqNDPMHPT2ZNhH6mtN+5Rzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qnMVlekn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d87a0bfaa7so294346a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725021840; x=1725626640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uGhTxa8nb1hTLu4LPBhK5HssfKzYH7PO9pulAV6yziI=;
        b=qnMVlekneNirL+sLA7FZhWqkpal33rQW6yiMZFpuq4KSN2TU1bv+FrPm5CYBzDQcVt
         oKeyDlMsv+i3AxLgs5VfaIbcHt8z2PE7I+xLBZmWgpTt6tLxjThw1VtLqjcb0dJdyGDD
         Xy/F0y5sFFXC1n6jgRRHtlqh3yTPSuQpzVmqzDFJftIrdStPNu+1WIzi223Vq8OZeLd2
         ilc4sSz2ZGrv8cSUU7+7Ar2NgWhZiPoEz8hn/ba9CmgEGxDOAhuMWV193F1jNqVX/Bfw
         MvtWSzBbBngBHpYQaslIyAmea3f6D1n1qY0yldr1LyGfylzNjACTguky+eQIzis9EwvR
         uWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725021840; x=1725626640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGhTxa8nb1hTLu4LPBhK5HssfKzYH7PO9pulAV6yziI=;
        b=cndb2TJaN8XYyislAEJ9jUcg99zU9x6XhHSLtHqkIvd1nfsEpyduKeXYg1/IwJxhMM
         cFidskYOylXKYoxIkveNGJTQGtXxCC8zyYmeQ8zo33VwI9YABpGv0OUMvDa9MyG7vHgH
         H2lrC67pDkhlxcYHzCFWKdh/ULhiTa/7aobwwZwgkRCYGL4N55eSoYLAtG/ZjiXfVEbh
         B41w4FKP6S7T5/ORp3vagRh9nZJ5kB5MGVyGX3sGLTbL5QV8iR5wFEUi8r4zJFPlwMY3
         7PK6h1A2pOZB0W+azlDUEFGjjuFpA61kF39n3Ph87NuWSh6xrIqyYywwkIz8cKeCDv3E
         WGyA==
X-Forwarded-Encrypted: i=1; AJvYcCWp8vlQhBAhJOa8Oeg2nCygQTvQXJVY/av4g769qNTaEo2EqEc0t9t7VJAlybLVaGve0QckhO51ffJrEgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9b+jfSjjehq+fD2Q1/YDw8/oS1BCg9dWLU1OP5uTdHeIUenI0
	kCX1qDAKnoZEQ/fjifC6SQDDE1FaGx47zq/ij118qIZjR+GWiFHlcGVGhBxkkPuVc/ttwp8xkeq
	1YflfjhWvfHDI6UL4fHhQFesSFWJ3x0oz7XpXnA==
X-Google-Smtp-Source: AGHT+IFnKjcBQeJx/chFq8c0o9CMJ7FPD3dzE9m/kGlMoq47N332WUPQme/Sp9wx6QPyp5o2lll7RKFpTUzJV9GYFS4=
X-Received: by 2002:a17:90b:4b45:b0:2c9:754d:2cba with SMTP id
 98e67ed59e1d1-2d856182414mr6624440a91.3.1725021839782; Fri, 30 Aug 2024
 05:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-6MJC+D0DzxLOpVvCbYzHE-r1YzNORtpOh-f+hgEkMjzg@mail.gmail.com>
In-Reply-To: <CALAgD-6MJC+D0DzxLOpVvCbYzHE-r1YzNORtpOh-f+hgEkMjzg@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 30 Aug 2024 14:43:48 +0200
Message-ID: <CAKfTPtDLS07TuK+-vZY9B2azSPUDdpXNCSxMuRmo7m=F+5MPvQ@mail.gmail.com>
Subject: Re: BUG: WARNING: ODEBUG bug in schedule_timeout
To: Xingyu Li <xli399@ucr.edu>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi Xingyu,

On Wed, 28 Aug 2024 at 23:05, Xingyu Li <xli399@ucr.edu> wrote:
>
> Hi,
>
> We found a bug in Linux 6.10. It is possibly a use-before-initialization  bug.

Have you tried to reproduce the problem Linux 6.11 ?

I'm not sure this can be a use-before-initialization because the
schedule_timeout() is like below:
{
    struct process_timer timer;
...
    expire = timeout + jiffies;
    timer.task = current;
    timer_setup_on_stack(&timer.timer, process_timeout, 0);
    __mod_timer(&timer.timer, expire, MOD_TIMER_NOTPENDING);
    schedule();
    del_timer_sync(&timer.timer);
...
}

Could it be related to a corruption of the stack ?


> The bug report and the reproducer are as follows:
>
> Bug report:
>
> ODEBUG: assert_init not available (active state 0) object:
> ffffc9000a9cf540 object type: timer_list hint:
> process_timeout+0x0/0x40
> WARNING: CPU: 0 PID: 8051 at lib/debugobjects.c:517
> debug_print_object+0x176/0x1e0 lib/debugobjects.c:514
> Modules linked in:
> CPU: 0 PID: 8051 Comm: syz-executor163 Not tainted 6.10.0 #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:debug_print_object+0x176/0x1e0 lib/debugobjects.c:514
> Code: df e8 6e e9 95 fd 4c 8b 0b 48 c7 c7 a0 61 a9 8b 48 8b 74 24 08
> 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 de 2c f7 fc 48 83 c4 08 <0f> 0b
> ff 05 42 1e c6 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d
> RSP: 0018:ffffc9000a9cf298 EFLAGS: 00010282
> RAX: 23ee1da135379d00 RBX: ffffffff8b4ee740 RCX: ffff88801a0c9e00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffffff8ba96360 R08: ffffffff8155a25a R09: 1ffff1100c74519a
> R10: dffffc0000000000 R11: ffffed100c74519b R12: 0000000000000000
> R13: ffffffff8ba96248 R14: dffffc0000000000 R15: ffffc9000a9cf540
> FS:  000055558a14e3c0(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f79c90aaa60 CR3: 000000001f8be000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  debug_object_assert_init+0x35f/0x420 lib/debugobjects.c:910
>  debug_timer_assert_init kernel/time/timer.c:846 [inline]
>  debug_assert_init kernel/time/timer.c:891 [inline]
>  __try_to_del_timer_sync kernel/time/timer.c:1504 [inline]
>  __timer_delete_sync+0x2ba/0x410 kernel/time/timer.c:1665
>  timer_delete_sync kernel/time/timer.c:1720 [inline]
>  del_timer_sync include/linux/timer.h:185 [inline]
>  schedule_timeout+0x1c3/0x300 kernel/time/timer.c:2582
>  io_schedule_timeout+0x96/0x120 kernel/sched/core.c:9034
>  do_wait_for_common kernel/sched/completion.c:95 [inline]
>  __wait_for_common kernel/sched/completion.c:116 [inline]
>  wait_for_common_io+0x31c/0x620 kernel/sched/completion.c:133
>  blk_wait_io block/blk.h:82 [inline]
>  blk_execute_rq+0x369/0x4a0 block/blk-mq.c:1408
>  sg_scsi_ioctl drivers/scsi/scsi_ioctl.c:593 [inline]
>  scsi_ioctl+0x20fc/0x2c70 drivers/scsi/scsi_ioctl.c:901
>  sg_ioctl_common drivers/scsi/sg.c:1109 [inline]
>  sg_ioctl+0x16c3/0x2d50 drivers/scsi/sg.c:1163
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x67/0x6f
> RIP: 0033:0x7f6a2ca8418d
> Code: c3 e8 a7 1f 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe3f6398f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000002fba0 RCX: 00007f6a2ca8418d
> RDX: 0000000020000080 RSI: 0000000000000001 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 002367732f766564 R09: 0000000000000000
> R10: 000000000000000f R11: 0000000000000246 R12: 00007ffe3f63990c
> R13: 431bde82d7b634db R14: 00007f6a2cb014f0 R15: 0000000000000001
>  </TASK>
>
> C reproducer:
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
>
> #define _GNU_SOURCE
>
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
>
> static void sleep_ms(uint64_t ms)
> {
>   usleep(ms * 1000);
> }
>
> static uint64_t current_time_ms(void)
> {
>   struct timespec ts;
>   if (clock_gettime(CLOCK_MONOTONIC, &ts))
>     exit(1);
>   return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
>
> static bool write_file(const char* file, const char* what, ...)
> {
>   char buf[1024];
>   va_list args;
>   va_start(args, what);
>   vsnprintf(buf, sizeof(buf), what, args);
>   va_end(args);
>   buf[sizeof(buf) - 1] = 0;
>   int len = strlen(buf);
>   int fd = open(file, O_WRONLY | O_CLOEXEC);
>   if (fd == -1)
>     return false;
>   if (write(fd, buf, len) != len) {
>     int err = errno;
>     close(fd);
>     errno = err;
>     return false;
>   }
>   close(fd);
>   return true;
> }
>
> static long syz_open_dev(volatile long a0, volatile long a1, volatile long a2)
> {
>   if (a0 == 0xc || a0 == 0xb) {
>     char buf[128];
>     sprintf(buf, "/dev/%s/%d:%d", a0 == 0xc ? "char" : "block", (uint8_t)a1,
>             (uint8_t)a2);
>     return open(buf, O_RDWR, 0);
>   } else {
>     char buf[1024];
>     char* hash;
>     strncpy(buf, (char*)a0, sizeof(buf) - 1);
>     buf[sizeof(buf) - 1] = 0;
>     while ((hash = strchr(buf, '#'))) {
>       *hash = '0' + (char)(a1 % 10);
>       a1 /= 10;
>     }
>     return open(buf, a2, 0);
>   }
> }
>
> static void kill_and_wait(int pid, int* status)
> {
>   kill(-pid, SIGKILL);
>   kill(pid, SIGKILL);
>   for (int i = 0; i < 100; i++) {
>     if (waitpid(-1, status, WNOHANG | __WALL) == pid)
>       return;
>     usleep(1000);
>   }
>   DIR* dir = opendir("/sys/fs/fuse/connections");
>   if (dir) {
>     for (;;) {
>       struct dirent* ent = readdir(dir);
>       if (!ent)
>         break;
>       if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
>         continue;
>       char abort[300];
>       snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>                ent->d_name);
>       int fd = open(abort, O_WRONLY);
>       if (fd == -1) {
>         continue;
>       }
>       if (write(fd, abort, 1) < 0) {
>       }
>       close(fd);
>     }
>     closedir(dir);
>   } else {
>   }
>   while (waitpid(-1, status, __WALL) != pid) {
>   }
> }
>
> static void setup_test()
> {
>   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>   setpgrp();
>   write_file("/proc/self/oom_score_adj", "1000");
> }
>
> static void execute_one(void);
>
> #define WAIT_FLAGS __WALL
>
> static void loop(void)
> {
>   int iter = 0;
>   for (;; iter++) {
>     int pid = fork();
>     if (pid < 0)
>       exit(1);
>     if (pid == 0) {
>       setup_test();
>       execute_one();
>       exit(0);
>     }
>     int status = 0;
>     uint64_t start = current_time_ms();
>     for (;;) {
>       sleep_ms(10);
>       if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
>         break;
>       if (current_time_ms() - start < 5000)
>         continue;
>       kill_and_wait(pid, &status);
>       break;
>     }
>   }
> }
>
> uint64_t r[1] = {0xffffffffffffffff};
>
> void execute_one(void)
> {
>   intptr_t res = 0;
>   if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {
>   }
>   memcpy((void*)0x20000000,
>          "\x2b\x95\x24\x80\xc7\xca\x55\x09\x7d\x17\x07\x93\x5b\xa6\x4b\x20\xf3"
>          "\x02\x6c\x03\xd6\x58\x02\x6b\x81\xbf\x26\x43\x40\x51\x2b\x3c\xb4\xe0"
>          "\x1a\xfd\xa2\xde\x75\x42\x99\xea\x7a\x11\x33\x43\xab\x7b\x9b\xda\x2f"
>          "\xc0\xa2\xe2\xcd\xbf\xec\xbc\xa0\x23\x3a\x07\x72\xb1\x2e\xbd\xe5\xd9"
>          "\x8a\x12\x03\xcb\x87\x16\x72\xdf\xf7\xe4\xc8\x6e\xc1\xdc\xce\xf0\xa7"
>          "\x63\x12\xfb\xe8\xd4\x5d\xc2\xbd\x0f\x8f\xc2\xeb\xeb\x2a\x6b\xe6\xa3"
>          "\x00\x91\x6c\x52\x81\xda\x2c\x1e\xf6\x4d\x66\x26\x70\x91\xb8\x24\x29"
>          "\x97\x6c\x01\x9d\xa3\x64\x55\x57\xed\x1d\x43\x9c\x5a\x63\x7f\x6b\xf5"
>          "\x8c\x53\xbc\x41\x45\x39\xdd\x87\xc6\x90\x98\xd6\x71\x40\x25\x86\xb6"
>          "\x31\xf9\xac\x5c\x2f\xe9\xce\xdc\x28\x1a\x6f\x00\x5b\x5c\x4d\x1d\xd5"
>          "\xed\x9b\xe4\x00\x00\x00\x00\x00\x00\x00",
>          180);
>   syscall(__NR_write, /*fd=*/-1, /*arg0=*/0x20000000ul, /*len=*/0xb4ul);
>   memcpy((void*)0x20000080, "/dev/sg#\000", 9);
>   res = -1;
>   res = syz_open_dev(/*dev=*/0x20000080, /*id=*/0,
>                      /*flags=O_CREAT|FASYNC|O_RDWR*/ 0x2042);
>   if (res != -1)
>     r[0] = res;
>   *(uint32_t*)0x20000080 = 0;
>   *(uint32_t*)0x20000084 = 2;
>   *(uint8_t*)0x20000088 = 0x85;
>   *(uint8_t*)0x20000089 = 8;
>   *(uint8_t*)0x2000008a = 2;
>   *(uint8_t*)0x2000008b = 0xd;
>   syscall(__NR_ioctl, /*fd=*/r[0], /*arg0=*/1, /*arg1=*/0x20000080ul);
> }
> int main(void)
> {
>   syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>           /*offset=*/0ul);
>   syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
>           /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
>           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>           /*offset=*/0ul);
>   syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>           /*offset=*/0ul);
>   const char* reason;
>   (void)reason;
>   loop();
>   return 0;
> }
>
> --
> Yours sincerely,
> Xingyu

