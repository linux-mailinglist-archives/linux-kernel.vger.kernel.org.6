Return-Path: <linux-kernel+bounces-527559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6B1A40C9A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 03:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37253B470A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 02:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EE425776;
	Sun, 23 Feb 2025 02:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOZXfYOK"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EE212B63
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 02:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740279538; cv=none; b=TPJV8O+7H6cSiQxeHfJZWqGPjPcj/4Zqta+wIYRXt/MoBAoosW+kQceqAjNcVr4pc0m1ubOAA5mpHOkDCFKpDxO3O2ivzQZaOAICWpXeGVpiRsoKG2GfLPgmzzyFcDKLxwIh9ptTZ+RuYhE/3Te/ipdSW8RMHFV3ExbWaVmER7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740279538; c=relaxed/simple;
	bh=w3A30DjE6TWpPsXjAU8fnisrHJgOiMN5kemzptoG7e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiFnCeYNqAGew/M88zG6jmL9WmDA1yHXH8L7W4P3Fhdqsg+t7Xk8f7MkLME4PaLpBFLdZHfvBz0fsuPJ/DQOiedRyYS6+z1roYxC0nUdP/y4yh2ElwzjgIP8TdinvOHlbURlfOz381iSd9yxgU7QK+0VLqXqVnMmp/ReakgAxqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOZXfYOK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so4508071a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 18:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740279534; x=1740884334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHGCvVM4HKZP86uO3YLiJHYWtb3Zrh0goabjnV8ABus=;
        b=QOZXfYOKC8W/W74xiCmmzKts1+FLPH5WmFbAmgUzK3L/URShkzndonzIAKBYEQuWxT
         WikgANbGtCtXuelmd5fXzwj6g/br01VFS1dKGM9Z8UAfPv4FMxNrejpcIUrgNknmozgE
         QIdKfjxgXqDg2PqXaolaU96k8yXORWpAy52+lOWoGl8Xl1YvPx1K0oOmtyD4Ibu++YMA
         QDzZih669WxCBO7Y/ayheSPXnflOa3NyE2l7f0cQHiOiso6/3Hqno61j3CjLX+B4bMEy
         ilSTmvxeBYaXfrkJ9I62k8LJEmDY+Avv5/oUPDeZQ55VF7hO0NzrqQUaKouFBMwBt/92
         eDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740279534; x=1740884334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHGCvVM4HKZP86uO3YLiJHYWtb3Zrh0goabjnV8ABus=;
        b=qkzY0hSCI0F32n3nU4L9MzqHlUs/0anubKjYIXenxQ/PveGyw1rNexzuyETvRqcs43
         jKCgUsAomNnX8fPD2AlCiHPhIyUOkUZWIRLsj1W+k2hZAFHw9irGwI8zACgvWR3p7Sqr
         HWxXy91p7RVJCerSej75lzGB5t3GUlHbQsBAGu7CKvCXKprWPPRqMk+AUTpVayunSuqJ
         ow/v8hCwvcJbk6tZDSrslsfTSp/HakOXLqrKyk34Lxzwk4fM4TCUNGjNkuQMuPLs3syC
         oJDXI6o0NEjVblkeGq4JgyyEvTiZlHkXCC+MHqA4OCjqOKc1H3B0st3oJL089p2fWLTl
         5mcw==
X-Forwarded-Encrypted: i=1; AJvYcCUb92MGMZCy85cK/Em5haWr8l+uDFZPkFvpPCd+jDjBQdEMIcl7Fsoe+xGJv2qgXcQdA05WxZ2I0nTZUTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMMvpIGLjvuQNXWXibKXaTbyBrBuUbQx2eeC39Qfxbj1J0sOl
	m76SMdI5ZW0/8/r91eN91oW4ABH0SOy/TX/jOC43U91Icbz0cRmQB2mYlxLlU9i7r0QOX7HFqkj
	Oq6ylEi8jqB/GDufY/JSfZgONpeg=
X-Gm-Gg: ASbGncuRoOHm/6QGrN5Dcd9zFdjxRoHCraMBtSk5v09zevU/hZwAlsv09C7T4bqIyjF
	pIZN2LlNtJuTCRmZNsntcO6D6lW1HYuOkJ/4X/EErkZDHCuVrQ9MhpPceZic2uKxJc39c8S2NQR
	3yVgOFkDBGxw==
X-Google-Smtp-Source: AGHT+IFldNxjNaVfnTLz6b97WZhagJ1NzizVXg4HdNxA5ZwXSTH4jQuldVkHpklFnf9EAh3T7OVLb1hWOCa5inYfauU=
X-Received: by 2002:a05:6402:1ec8:b0:5e0:6770:2b6a with SMTP id
 4fb4d7f45d1cf-5e0b72268a2mr8039452a12.23.1740279534332; Sat, 22 Feb 2025
 18:58:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174018982058.2766225.1721562132740498299.stgit@mhiramat.tok.corp.google.com>
 <174018983078.2766225.824985516904203702.stgit@mhiramat.tok.corp.google.com>
In-Reply-To: <174018983078.2766225.824985516904203702.stgit@mhiramat.tok.corp.google.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sun, 23 Feb 2025 10:58:17 +0800
X-Gm-Features: AWEUYZmlwJ00_l5kH7U9Uj78Q7AGifCMyBGlE3UvPh61VMizZZeVaqQSJZCDSxg
Message-ID: <CAK1f24=erjdUzFvCYUFr3L0Yq+bGC8iRmFMstAWd9QSsG98vWg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Joel Granados <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 10:03=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> The "hung_task" shows a long-time uninterruptible slept task, but most
> often, it's blocked on a mutex acquired by another task. Without
> dumping such a task, investigating the root cause of the hung task
> problem is very difficult.
>
> This introduce task_struct::blocker_mutex to point the mutex lock
> which this task is waiting for. Since the mutex has "owner"
> information, we can find the owner task and dump it with hung tasks.
>
> Note: the owner can be changed while dumping the owner task, so
> this is "likely" the owner of the mutex.
>
> With this change, the hung task shows blocker task's info like below;
>
>  INFO: task cat:115 blocked for more than 122 seconds.
>        Not tainted 6.14.0-rc3-00003-ga8946be3de00 #156
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message=
.
>  task:cat             state:D stack:13432 pid:115   tgid:115   ppid:106  =
  task_flags:0x400100 flags:0x00000002
>  Call Trace:
>   <TASK>
>   __schedule+0x731/0x960
>   ? schedule_preempt_disabled+0x54/0xa0
>   schedule+0xb7/0x140
>   ? __mutex_lock+0x51b/0xa60
>   ? __mutex_lock+0x51b/0xa60
>   schedule_preempt_disabled+0x54/0xa0
>   __mutex_lock+0x51b/0xa60
>   read_dummy+0x23/0x70
>   full_proxy_read+0x6a/0xc0
>   vfs_read+0xc2/0x340
>   ? __pfx_direct_file_splice_eof+0x10/0x10
>   ? do_sendfile+0x1bd/0x2e0
>   ksys_read+0x76/0xe0
>   do_syscall_64+0xe3/0x1c0
>   ? exc_page_fault+0xa9/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x4840cd
>  RSP: 002b:00007ffe99071828 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>  RDX: 0000000000001000 RSI: 00007ffe99071870 RDI: 0000000000000003
>  RBP: 00007ffe99071870 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>  R13: 00000000132fd3a0 R14: 0000000000000001 R15: ffffffffffffffff
>   </TASK>
>  INFO: task cat:115 is blocked on a mutex likely owned by task cat:114.
>  task:cat             state:S stack:13432 pid:114   tgid:114   ppid:106  =
  task_flags:0x400100 flags:0x00000002
>  Call Trace:
>   <TASK>
>   __schedule+0x731/0x960
>   ? schedule_timeout+0xa8/0x120
>   schedule+0xb7/0x140
>   schedule_timeout+0xa8/0x120
>   ? __pfx_process_timeout+0x10/0x10
>   msleep_interruptible+0x3e/0x60
>   read_dummy+0x2d/0x70
>   full_proxy_read+0x6a/0xc0
>   vfs_read+0xc2/0x340
>   ? __pfx_direct_file_splice_eof+0x10/0x10
>   ? do_sendfile+0x1bd/0x2e0
>   ksys_read+0x76/0xe0
>   do_syscall_64+0xe3/0x1c0
>   ? exc_page_fault+0xa9/0x1d0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  RIP: 0033:0x4840cd
>  RSP: 002b:00007ffe3e0147b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>  RDX: 0000000000001000 RSI: 00007ffe3e014800 RDI: 0000000000000003
>  RBP: 00007ffe3e014800 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>  R13: 000000001a0a93a0 R14: 0000000000000001 R15: ffffffffffffffff
>   </TASK>
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Nice. I just tried it out, and it works as expected. The overhead is
almost nothing based on my micro-benchmark ;)

Tested-by: Lance Yang <ioworker0@gmail.com>

Thanks,
Lance

> ---
>  Changes in v3:
>   - Add RCU_LOCKDEP_WARN() to ensure rcu_read_lock() is held.
>   - Cleanup code to make it fail-fast and add brace to
>     for_each_process_thread().
>   - Change the message to "likely owned" instead of "owned".
>  Changes in v2:
>   - Introduce CONFIG_DETECT_HUNG_TASK_BLOCKER for this feature.
>   - Introduce task_struct::blocker_mutex to point the mutex.
>   - Rename debug_mutex_get_owner() to mutex_get_owner().
>   - Remove unneeded mutex_waiter::mutex.
> ---
>  include/linux/mutex.h  |    2 ++
>  include/linux/sched.h  |    4 ++++
>  kernel/hung_task.c     |   36 ++++++++++++++++++++++++++++++++++++
>  kernel/locking/mutex.c |   14 ++++++++++++++
>  lib/Kconfig.debug      |   10 ++++++++++
>  5 files changed, 66 insertions(+)
>
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 2bf91b57591b..2143d05116be 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -202,4 +202,6 @@ DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), m=
utex_unlock(_T))
>  DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
>  DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) =3D=3D 0)
>
> +extern unsigned long mutex_get_owner(struct mutex *lock);
> +
>  #endif /* __LINUX_MUTEX_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9632e3318e0d..0cebdd736d44 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1217,6 +1217,10 @@ struct task_struct {
>         struct mutex_waiter             *blocked_on;
>  #endif
>
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +       struct mutex                    *blocker_mutex;
> +#endif
> +
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>         int                             non_block_count;
>  #endif
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 04efa7a6e69b..ccd7217fcec1 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -93,6 +93,41 @@ static struct notifier_block panic_block =3D {
>         .notifier_call =3D hung_task_panic,
>  };
>
> +
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +static void debug_show_blocker(struct task_struct *task)
> +{
> +       struct task_struct *g, *t;
> +       unsigned long owner;
> +       struct mutex *lock;
> +
> +       RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
> +
> +       lock =3D READ_ONCE(task->blocker_mutex);
> +       if (!lock)
> +               return;
> +
> +       owner =3D mutex_get_owner(lock);
> +       if (unlikely(!owner)) {
> +               pr_err("INFO: task %s:%d is blocked on a mutex, but the o=
wner is not found.\n",
> +                       task->comm, task->pid);
> +               return;
> +       }
> +
> +       /* Ensure the owner information is correct. */
> +       for_each_process_thread(g, t) {
> +               if ((unsigned long)t =3D=3D owner) {
> +                       pr_err("INFO: task %s:%d is blocked on a mutex li=
kely owned by task %s:%d.\n",
> +                               task->comm, task->pid, t->comm, t->pid);
> +                       sched_show_task(t);
> +                       return;
> +               }
> +       }
> +}
> +#else
> +#define debug_show_blocker(t)  do {} while (0)
> +#endif
> +
>  static void check_hung_task(struct task_struct *t, unsigned long timeout=
)
>  {
>         unsigned long switch_count =3D t->nvcsw + t->nivcsw;
> @@ -152,6 +187,7 @@ static void check_hung_task(struct task_struct *t, un=
signed long timeout)
>                 pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s\""
>                         " disables this message.\n");
>                 sched_show_task(t);
> +               debug_show_blocker(t);
>                 hung_task_show_lock =3D true;
>
>                 if (sysctl_hung_task_all_cpu_backtrace)
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index b36f23de48f1..6a543c204a14 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -72,6 +72,14 @@ static inline unsigned long __owner_flags(unsigned lon=
g owner)
>         return owner & MUTEX_FLAGS;
>  }
>
> +/* Do not use the return value as a pointer directly. */
> +unsigned long mutex_get_owner(struct mutex *lock)
> +{
> +       unsigned long owner =3D atomic_long_read(&lock->owner);
> +
> +       return (unsigned long)__owner_task(owner);
> +}
> +
>  /*
>   * Returns: __mutex_owner(lock) on failure or NULL on success.
>   */
> @@ -180,6 +188,9 @@ static void
>  __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>                    struct list_head *list)
>  {
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +       WRITE_ONCE(current->blocker_mutex, lock);
> +#endif
>         debug_mutex_add_waiter(lock, waiter, current);
>
>         list_add_tail(&waiter->list, list);
> @@ -195,6 +206,9 @@ __mutex_remove_waiter(struct mutex *lock, struct mute=
x_waiter *waiter)
>                 __mutex_clear_flag(lock, MUTEX_FLAGS);
>
>         debug_mutex_remove_waiter(lock, waiter, current);
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +       WRITE_ONCE(current->blocker_mutex, NULL);
> +#endif
>  }
>
>  /*
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af972a92d06..91dfd8c10fbb 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1260,6 +1260,16 @@ config BOOTPARAM_HUNG_TASK_PANIC
>
>           Say N if unsure.
>
> +config DETECT_HUNG_TASK_BLOCKER
> +       bool "Dump Hung Tasks Blocker"
> +       depends on DETECT_HUNG_TASK
> +       default y
> +       help
> +         Say Y here to show the blocker task's stacktrace who acquires
> +         the mutex lock which "hung tasks" are waiting.
> +         This will add overhead a bit but shows suspicious tasks and
> +         call trace if it comes from waiting a mutex.
> +
>  config WQ_WATCHDOG
>         bool "Detect Workqueue Stalls"
>         depends on DEBUG_KERNEL
>

