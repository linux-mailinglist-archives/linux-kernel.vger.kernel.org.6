Return-Path: <linux-kernel+bounces-176581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECA18C31E6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A411F218B8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A3054F83;
	Sat, 11 May 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnoJyb0h"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD848CF2
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715438721; cv=none; b=j+kUbXSkeN7AfkxXoFZQuWHKGS10JR4sRYms0UrPGhfSA/yJGZaWNuZhPan0LgUcZV5ui0BUGfo44qOkOjtSw59fh2TfylCIgYX8KVv4ZFJOnsdc+J/9bVnE/WrtfvTY+OXvtzEF1u27mipqlTtb9zMqG30Ub+iqggbNeX4DBP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715438721; c=relaxed/simple;
	bh=dDiS96G2pzGmDmvIm2+hnrX/YQEpjpnAOW+VOcn+Boc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JCcf4Vh6dJ5gkS80YYma9cWxXuS/KtfDgUIwI3Se+MrB1vNeSfzg2fMgQE0MFqm2hdvIh3UpdkDmkIdlDktYymQUq/GxSDOfiDWl0ZH6IhQBKeO6smJXNPlUpcigu7ox3L8pyqOoXk1nSInsjzWMopZt/Mt4FjC3nDzUFDPjIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnoJyb0h; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2b432be5cc9so2360318a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715438719; x=1716043519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QZoUwf+W+BMGUD4qE9gpkzqUdn70GdRJp+DpjjyWUIc=;
        b=FnoJyb0hRoq9vejbvMaIhaD1vZ4uFKwkvVn43muOEO4DDMtgG+wurLgK5PP7TbHke/
         pZdJkpbdSy1jta11c2hXYgZK512tceRkJ2HDd5rKeEroOJ191fcHcqssCPh9S4v+tTN2
         s2gpqb2l63+dCsoLWjWKTv4mnCxGmyAdsfd27GF2EpCjQOV5vVxAscjzHXASsqE1rEjf
         iGRGlWkMwMkDaIIPICGotRI3eWgEuTOeXqo5fNiTu40e98sEdjep6iRO/SuUWHJoZ53E
         con8YzEYcRpNlf+6FJd4JukheMOG7kzUpxGiAfeyvZ3EeIbZcmfWTutXUl5c49mbIPSS
         kGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715438719; x=1716043519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZoUwf+W+BMGUD4qE9gpkzqUdn70GdRJp+DpjjyWUIc=;
        b=QTY1SW1sDd6kZnijZEwFORGeroZa1irI2hr2YuKf8ZQuOPIUEGPmfSSD3fgos9CL4Z
         ZbeXVbpCkFw510r6DZ9QHbkGOcZNqjTBijAFaiCDaS53s9wsaSGsvctBGAfl15i6vkdz
         6vL3n/sq5mHNA3+//A3u1Sdwv50AAqRE0EMM+pHvEFFfkDfdGh170LZTz9oW2etVTRh7
         QByzQZFbeWiqcke1gg+ZoHUKgX1FLUcnyDCVDjCActwUDZFiN0irjfJgqa6uweO6TrrZ
         LLXkJjoqeFCL55Q/ucfhlIoliqHEqsqvSTdWp0nGjfmxT7C6QnO443ykpcVWgwdYEyQ2
         iHrA==
X-Gm-Message-State: AOJu0Yxen64L0PPt8zFagPUmCSOB7rPvLtJkzZVRdzUHm02hQ2C0p1jE
	TtJglCrJCNrQ0EpjIBxJi+mNGRzOf6EvkWgltrVTXVrh/hgRP/6w3umVINUTJr17p+WAt+V150H
	MnxB43xSGqJS7RonNnILLlvsrvcQ=
X-Google-Smtp-Source: AGHT+IHS9VpTj9fjbFejQEpqlmQvErj+zHrmGKnQfy5xOdAhWIwhYCLguQWW7ZCJXvb5sfmULBwEZjNKO9wwP7k6owY=
X-Received: by 2002:a17:90b:88d:b0:2b4:39cd:24e1 with SMTP id
 98e67ed59e1d1-2b6cc5642e8mr5226394a91.8.1715438718681; Sat, 11 May 2024
 07:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: lee bruce <xrivendell7@gmail.com>
Date: Sat, 11 May 2024 22:45:06 +0800
Message-ID: <CABOYnLy5WHJBjk33pzr12w5e7CDGb43LhQ5zQow0on4pCYusjw@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in
 kill_orphaned_pgrp (2)
To: syzbot+68619f9e9e69accd8e0a@syzkaller.appspotmail.com, luto@kernel.org, 
	peterz@infradead.org, Thomas Gleixner <tglx@linutronix.de>, ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	clf700383@gmail.com, michael.christie@oracle.com, mst@redhat.com, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, I found a reproducer for this bug.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: lingfei cheng <clf700383@gmail.com>

I use the same kernel as syzbot instance
Kernel Commit: upstream dccb07f2914cdab2ac3a5b6c98406f765acab803
Kernel Config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D6d=
14c12b661fb43
with KASAN enabled

Since the same title bug is triggered in
https://syzkaller.appspot.com/bug?id=3D70492b96ff47ff70cfc433be100586119310=
670b.
I make a simple RCA.
In the old-syzbot instance the bug still trigger the title "KASAN:
slab-use-after-free Read in kill_orphaned_pgrp=E2=80=9D and in the lastest
syzbot the bug report as

TITLE: WARNING in signal_wake_up_state
------------[ cut here ]------------
WARNING: CPU: 3 PID: 8591 at kernel/signal.c:762
signal_wake_up_state+0xf8/0x130 kernel/signal.c:762
Modules linked in:
CPU: 3 PID: 8591 Comm: file0 Not tainted 6.9.0-rc7-00012-gdccb07f2914c #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.0-2.fc37 04/01/2014
RIP: 0010:signal_wake_up_state+0xf8/0x130 kernel/signal.c:762
Code: 31 c0 31 c9 31 f6 e9 b2 1f 73 0a e8 42 6f 3a 00 48 89 df 5b 41
5e 41 5f 5d 31 c0 31 c9 31 f6 e9 ce 27 0a 00 ec
RSP: 0000:ffffc900154af918 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8880239a0000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880239a0000
R13: ffff88802bd80908 R14: 0000000000000108 R15: dffffc0000000000
FS: 0000000000000000(0000) GS:ffff88823bc80000(0000) knlGS:0000000000000000
CS: 0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000259fa000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
<TASK>
signal_wake_up include/linux/sched/signal.h:448 [inline]
zap_process fs/coredump.c:373 [inline]
zap_threads fs/coredump.c:392 [inline]
coredump_wait fs/coredump.c:410 [inline]
do_coredump+0x8ff/0x2b60 fs/coredump.c:571
get_signal+0x13fa/0x1740 kernel/signal.c:2896
arch_do_signal_or_restart+0x96/0x870 arch/x86/kernel/signal.c:310
exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
irqentry_exit_to_user_mode+0x79/0x280 kernel/entry/common.c:231
exc_page_fault+0x577/0x8b0 arch/x86/mm/fault.c:1535
asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 002b:00000000ff9bfe10 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
</TASK>

This is also the reason why there are so many people in my cc list.

I debug this bug for a while and found that when our PoC process call vhost=
:
vhost_dev_set_owner
 vhost_worker_create
   copy_process

It will call copy_process to create a =E2=80=9Cvhost-xxxx=E2=80=9D thread i=
n workqueue
to run vhost_task_fn.

Also, PoC create a invalid elf =E2=80=9Cfile0" and execute it afterwards.
It is conceivable that execute syscall will fail and kill itself in
put_task_struct prograss.
However, when the workQueue thread =E2=80=9Cvhost-xxxx=E2=80=9D call vhost_=
task_fn

static int vhost_task_fn(void *data)
{
struct vhost_task *vtsk =3D data;
bool dead =3D false;

for (;;) {
bool did_work;

if (!dead && signal_pending(current)) {
struct ksignal ksig;
/*
* Calling get_signal will block in SIGSTOP,
* or clear fatal_signal_pending, but remember
* what was set.
*
* This thread won't actually exit until all
* of the file descriptors are closed, and
* the release function is called.
*/
dead =3D get_signal(&ksig);
if (dead)
clear_thread_flag(TIF_SIGPENDING);
}

/* mb paired w/ vhost_task_stop */
set_current_state(TASK_INTERRUPTIBLE);

if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
__set_current_state(TASK_RUNNING);
break;
}

did_work =3D vtsk->fn(vtsk->data);
if (!did_work)
schedule();
}

complete(&vtsk->exited);
do_exit(0);
}

I found, which seems a bit strange but I=E2=80=99m not sure:

gef> bt
#0 kill_orphaned_pgrp (tsk=3D0xffff888107833780, parent=3Dparent@entry=3D0x=
0
<fixed_percpu_data>) at ./include/linux/sched/signal.h:694
#1 0xffffffff811ff54d in exit_notify (group_dead=3D0x1,
tsk=3D0xffff888245e0d340) at kernel/exit.c:737
#2 do_exit (code=3Dcode@entry=3D0x0) at kernel/exit.c:894
#3 0xffffffff812331ea in vhost_task_fn (data=3D0xffff88824570c700) at
kernel/vhost_task.c:61
#4 0xffffffff810d7f7c in ret_from_fork (prev=3D<optimized out>,
regs=3D0xffffc90007eaff58, fn=3D0xffffffff81233110 <vhost_task_fn>,
fn_arg=3D0xffff88824570c700)
at arch/x86/kernel/process.c:147
#5 0xffffffff81002431 in ret_from_fork_asm () at arch/x86/entry/entry_64.S:=
304
#6 0x00007fff1f50a958 in ?? ()
#7 0x00007fff1f50a870 in ?? ()
#8 0x0000000000000011 in fixed_percpu_data ()
#9 0xffffffffffffffb0 in ?? ()
#10 0x00007fe268ae3220 in ?? ()
#11 0x00007fe268ae36c0 in ?? ()
#12 0x0000000000000203 in ?? ()
#13 0x0000000000000000 in ?? ()
gef> p tsk->comm
$64 =3D "PoC", '\\000' <repeats 12 times>


the vhost_task_fn trying to call kill_orphaned_pgrp to and cause a UAF
because the PoC task is feed by idle in the KASAN report.

I don't know if my analysis is correct, please feel free to correct me.


=3D* repro.c =3D*
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/futex.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static void sleep_ms(uint64_t ms) { usleep(ms * 1000); }

static uint64_t current_time_ms(void) {
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts)) exit(1);
 return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg) {
 pthread_t th;
 pthread_attr_t attr;
 pthread_attr_init(&attr);
 pthread_attr_setstacksize(&attr, 128 << 10);
 int i =3D 0;
 for (; i < 100; i++) {
   if (pthread_create(&th, &attr, fn, arg) =3D=3D 0) {
     pthread_attr_destroy(&attr);
     return;
   }
   if (errno =3D=3D EAGAIN) {
     usleep(50);
     continue;
   }
   break;
 }
 exit(1);
}

typedef struct {
 int state;
} event_t;

static void event_init(event_t* ev) { ev->state =3D 0; }

static void event_reset(event_t* ev) { ev->state =3D 0; }

static void event_set(event_t* ev) {
 if (ev->state) exit(1);
 __atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
 syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev) {
 while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
   syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev) {
 return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout) {
 uint64_t start =3D current_time_ms();
 uint64_t now =3D start;
 for (;;) {
   uint64_t remain =3D timeout - (now - start);
   struct timespec ts;
   ts.tv_sec =3D remain / 1000;
   ts.tv_nsec =3D (remain % 1000) * 1000 * 1000;
   syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
   if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE)) return 1;
   now =3D current_time_ms();
   if (now - start > timeout) return 0;
 }
}

static bool write_file(const char* file, const char* what, ...) {
 char buf[1024];
 va_list args;
 va_start(args, what);
 vsnprintf(buf, sizeof(buf), what, args);
 va_end(args);
 buf[sizeof(buf) - 1] =3D 0;
 int len =3D strlen(buf);
 int fd =3D open(file, O_WRONLY | O_CLOEXEC);
 if (fd =3D=3D -1) return false;
 if (write(fd, buf, len) !=3D len) {
   int err =3D errno;
   close(fd);
   errno =3D err;
   return false;
 }
 close(fd);
 return true;
}

static void kill_and_wait(int pid, int* status) {
 kill(-pid, SIGKILL);
 kill(pid, SIGKILL);
 for (int i =3D 0; i < 100; i++) {
   if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid) return;
   usleep(1000);
 }
 DIR* dir =3D opendir("/sys/fs/fuse/connections");
 if (dir) {
   for (;;) {
     struct dirent* ent =3D readdir(dir);
     if (!ent) break;
     if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =3D=
=3D 0)
       continue;
     char abort[300];
     snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
              ent->d_name);
     int fd =3D open(abort, O_WRONLY);
     if (fd =3D=3D -1) {
       continue;
     }
     if (write(fd, abort, 1) < 0) {
     }
     close(fd);
   }
   closedir(dir);
 } else {
 }
 while (waitpid(-1, status, __WALL) !=3D pid) {
 }
}

static void setup_test() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setpgrp();
 write_file("/proc/self/oom_score_adj", "1000");
}

struct thread_t {
 int created, call;
 event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg) {
 struct thread_t* th =3D (struct thread_t*)arg;
 for (;;) {
   event_wait(&th->ready);
   event_reset(&th->ready);
   execute_call(th->call);
   __atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
   event_set(&th->done);
 }
 return 0;
}

static void execute_one(void) {
 int i, call, thread;
 for (call =3D 0; call < 6; call++) {
   for (thread =3D 0; thread < (int)(sizeof(threads) / sizeof(threads[0]));
        thread++) {
     struct thread_t* th =3D &threads[thread];
     if (!th->created) {
       th->created =3D 1;
       event_init(&th->ready);
       event_init(&th->done);
       event_set(&th->done);
       thread_start(thr, th);
     }
     if (!event_isset(&th->done)) continue;
     event_reset(&th->done);
     th->call =3D call;
     __atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
     event_set(&th->ready);
     event_timedwait(&th->done, 50);
     break;
   }
 }
 for (i =3D 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
   sleep_ms(1);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
 int iter =3D 0;
 for (;; iter++) {
   int pid =3D fork();
   if (pid < 0) exit(1);
   if (pid =3D=3D 0) {
     setup_test();
     execute_one();
     exit(0);
   }
   int status =3D 0;
   uint64_t start =3D current_time_ms();
   for (;;) {
     if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid) break;
     sleep_ms(1);
     if (current_time_ms() - start < 5000) continue;
     kill_and_wait(pid, &status);
     break;
   }
 }
}

uint64_t r[2] =3D {0xffffffffffffffff, 0xffffffffffffffff};

void execute_call(int call) {
 intptr_t res =3D 0;
 switch (call) {
   case 0:
     memcpy((void*)0x20000280, "./file0\000", 8);
     res =3D syscall(__NR_creat, /*file=3D*/0x20000280ul,
                   /*mode=3D*/0xecf86c37d53049ccul);
     if (res !=3D -1) r[0] =3D res;
     break;
   case 1:
     *(uint8_t*)0x20000440 =3D 0x7f;
     *(uint8_t*)0x20000441 =3D 0x45;
     *(uint8_t*)0x20000442 =3D 0x4c;
     *(uint8_t*)0x20000443 =3D 0x46;
     *(uint8_t*)0x20000444 =3D 0;
     *(uint8_t*)0x20000445 =3D 0;
     *(uint8_t*)0x20000446 =3D 0;
     *(uint8_t*)0x20000447 =3D 0;
     *(uint64_t*)0x20000448 =3D 0;
     *(uint16_t*)0x20000450 =3D 2;
     *(uint16_t*)0x20000452 =3D 0x3e;
     *(uint32_t*)0x20000454 =3D 0;
     *(uint32_t*)0x20000458 =3D 0;
     *(uint32_t*)0x2000045c =3D 0x38;
     *(uint32_t*)0x20000460 =3D 0;
     *(uint32_t*)0x20000464 =3D 0;
     *(uint16_t*)0x20000468 =3D 0xeb0;
     *(uint16_t*)0x2000046a =3D 0x20;
     *(uint16_t*)0x2000046c =3D 2;
     *(uint16_t*)0x2000046e =3D 0;
     *(uint16_t*)0x20000470 =3D 0;
     *(uint16_t*)0x20000472 =3D 0;
     *(uint32_t*)0x20000478 =3D 0;
     *(uint32_t*)0x2000047c =3D 0;
     *(uint32_t*)0x20000480 =3D 0;
     *(uint32_t*)0x20000484 =3D 0;
     *(uint32_t*)0x20000488 =3D 0;
     *(uint32_t*)0x2000048c =3D 0;
     *(uint32_t*)0x20000490 =3D 0;
     *(uint32_t*)0x20000494 =3D 0;
     memset((void*)0x20000498, 0, 256);
     memset((void*)0x20000598, 0, 256);
     memset((void*)0x20000698, 0, 256);
     memset((void*)0x20000798, 0, 256);
     memset((void*)0x20000898, 0, 256);
     memset((void*)0x20000998, 0, 256);
     memset((void*)0x20000a98, 0, 256);
     syscall(__NR_write, /*fd=3D*/r[0], /*data=3D*/0x20000440ul, /*len=3D*/=
0x758ul);
     break;
   case 2:
     syscall(__NR_close, /*fd=3D*/r[0]);
     break;
   case 3:
     memcpy((void*)0x20000000, "/dev/vhost-net\000", 15);
     res =3D syscall(__NR_openat, /*fd=3D*/0xffffffffffffff9cul,
                   /*file=3D*/0x20000000ul, /*flags=3D*/2ul, /*mode=3D*/0ul=
);
     if (res !=3D -1) r[1] =3D res;
     break;
   case 4:
     syscall(__NR_ioctl, /*fd=3D*/r[1], /*cmd=3D*/0xaf01, /*v=3D*/0ul);
     break;
   case 5:
     memcpy((void*)0x20000400, "./file0\000", 8);
     syscall(__NR_execve, /*file=3D*/0x20000400ul, /*argv=3D*/0ul, /*envp=
=3D*/0ul);
     break;
 }
}
int main(void) {
 syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=3D*=
/0ul,
         /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
 syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul, /*prot=
=3D*/7ul,
         /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
 syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D*=
/0ul,
         /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
 loop();
 return 0;
}

=3D* repro.txt =3D*
r0 =3D creat(&(0x7f0000000280)=3D'./file0\x00', 0xecf86c37d53049cc)
write$binfmt_elf32(r0, &(0x7f0000000440)=3D{{0x7f, 0x45, 0x4c, 0x46,
0x0, 0x0, 0x0, 0x0, 0x0, 0x2, 0x3e, 0x0, 0x0, 0x38, 0x0, 0x0, 0xeb0,
0x20, 0x2}, [{}], "", ['\x00', '\x00', '\x00', '\x00', '\x00', '\x00',
'\x00']}, 0x758)
close(r0)
r1 =3D openat$vnet(0xffffffffffffff9c, &(0x7f0000000000), 0x2, 0x0)
ioctl$int_in(r1, 0x40000000af01, 0x0)
execve(&(0x7f0000000400)=3D'./file0\x00', 0x0, 0x0)

and see also in
https://gist.github.com/xrivendell7/c1540d905cdbcc43fc134a76dd364f6d

I hope it helps.
Best regards

