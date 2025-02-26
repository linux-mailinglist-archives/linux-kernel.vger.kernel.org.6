Return-Path: <linux-kernel+bounces-532784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84294A45229
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7323A7A3BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC51624C3;
	Wed, 26 Feb 2025 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7A30VxU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678114EC73
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740533030; cv=none; b=kNm6QQBuGyc/8cxpfUs7bEuzO2WKvU9d1fUB+Z0W4znYo9Anc+ihbT4l0lzs8+pO6AFFwoOwKcpkNd4ITLEJ97uNkTdd61Sl8pkK284V7F6uVKrwtoBIc6pA9JTDfKc3eK5HqcuGNHZo7bZKHLZmPzezsfZ5V/2pjzOCQA4gkqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740533030; c=relaxed/simple;
	bh=400wTcuUmKhp5Css/ZHe2lyXG6IQNINP0NzemNI/I8c=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FgNaBElCvrysq+pKyx82TKVQ9VlSAVFkzsZHAUUlHq1QPFLxQcy8LevIBWkL6fXmiYzsAVfToySz+8PCMV6XTK0uS0V8UBvWNlkF1YRkUSbhqn6gNpZJzKWGIOgfZ6fKC/WCrc4OvQ3ltYUVjTPKrlfho/56HfXMU4yZWVfGjyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7A30VxU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740533027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INJRj91kgLqlLnsmRZ57Q0cno7qxcS2AlVON4Iui3pU=;
	b=R7A30VxUj/5PUji85Nt7Ksn+vGp9/il38dV75wqNG7Kwe9ZAy2nPhoxjjgJoHvX8llsk0S
	Ynv3vUHiCPM1hLrLAoMU4E4FakzOCKri1aO/yd0czhSyKucIMUqTLo6yulqm/t+mV1kZDh
	MLHIU5yzKxW9kD8dASSs1ZS0KalKpTE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-3rd-Lw_DO2qp_azk0l7m0Q-1; Tue, 25 Feb 2025 20:23:45 -0500
X-MC-Unique: 3rd-Lw_DO2qp_azk0l7m0Q-1
X-Mimecast-MFC-AGG-ID: 3rd-Lw_DO2qp_azk0l7m0Q_1740533025
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3f3fbe10235so6736978b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740533025; x=1741137825;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INJRj91kgLqlLnsmRZ57Q0cno7qxcS2AlVON4Iui3pU=;
        b=sbyXfYqmFOaF14eaHAUykFHmpqfqCYni/Sq7IPYf6Y9vru9PwXOyklZ7CBUQriR4+u
         N8cGKL3Gd8P8oWrZ4T9/Tw9ISTacBg2/VAYrCylAKtYp5P5UnWjzbLG4ud2HMYTERweb
         YjqyXPkLrCw3l7wDjK8hD72aiG6HI0piXzGMoNM5m6B8SUZJukoWXvJkdRFEnGAy05KZ
         Yoa//hF8rAVzbxrr8Kv6X8eKdBtpWmJjls9/OJBU6aXvoPn2QubVV2cHFl0ARc+Dc7xQ
         kvBMUVSBYzitWf/N80KuOz1H0oP4tWRe5ZAqLExJUmaSMn9ZsLS0NfXaiQO/dBY7qPQ2
         qIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeDXlr1YFW3asENk6O+We8J6gyAab6MbiI1d9B8RXnkZmyP2u1HqCKz5BtXmGS/mcsxa9fzYnceW9gfSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgvKrTXCFyV7P9p62DDIEsuOVDBv68xOUANPiMFsdt8Vw82U5
	ikwNtblU5mt7dc/XK7KgPENW2hiRaG9ZzbOSLvr6GCBiHudLiqtChWSmEtQRxyQKS7yEtkqXaw3
	JEIEvHtcvQ1QQT2mk3JhJQ44qOEQRPWWVVVC4jaC3GFyxlV3jVBdc51McwRVM5g==
X-Gm-Gg: ASbGncss2k/qCNUJivc6NIAbdONazD7KAK4oxbpNslDIlU9I2V/mPBAG+e3Spvodt7Z
	/oFVS15ZV0syfOgdpRoo/kXf6WVaiG/OP9/VoVsmhmeHWsPp1Q9bJ6SxQvpJcjN0HhePENsJ/FC
	Lr2My6kX9G4mdmDK7EWu04m3g1ZXDXESbEHhqwAU67fGlbO92x3yeYplOp4PZrnaWHnDoofJNmG
	JkNBdUpf2wbuJS5H7ieHKfqAf8j83pcXHJLM3FEfsnc9B+PUtj1DD9pKoJNMrZaHWZKDjEG5o0P
	0WjzyoT05sff7sR9Bg7LPWths7WUWxPq8tlje/FYcxgdzul2jRSUa/SM3Os=
X-Received: by 2002:a05:6808:1791:b0:3f3:dd22:e921 with SMTP id 5614622812f47-3f425c097ebmr10737716b6e.33.1740533024911;
        Tue, 25 Feb 2025 17:23:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/KNGb4J92uczmMM+W6SAB21nWHHfW/O+KdXXewk9ylSTA+T8rwovudrIBnrLJzO8d77MPcQ==
X-Received: by 2002:a05:6808:1791:b0:3f3:dd22:e921 with SMTP id 5614622812f47-3f425c097ebmr10737704b6e.33.1740533024510;
        Tue, 25 Feb 2025 17:23:44 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9410c808sm514457eaf.7.2025.02.25.17.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 17:23:43 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <21a692ce-3fa4-48f2-8d1c-5542c1cfb15c@redhat.com>
Date: Tue, 25 Feb 2025 20:23:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
 <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
Content-Language: en-US
In-Reply-To: <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 2:02 AM, Masami Hiramatsu (Google) wrote:
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
>   INFO: task cat:115 blocked for more than 122 seconds.
>         Not tainted 6.14.0-rc3-00003-ga8946be3de00 #156
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>   task:cat             state:D stack:13432 pid:115   tgid:115   ppid:106    task_flags:0x400100 flags:0x00000002
>   Call Trace:
>    <TASK>
>    __schedule+0x731/0x960
>    ? schedule_preempt_disabled+0x54/0xa0
>    schedule+0xb7/0x140
>    ? __mutex_lock+0x51b/0xa60
>    ? __mutex_lock+0x51b/0xa60
>    schedule_preempt_disabled+0x54/0xa0
>    __mutex_lock+0x51b/0xa60
>    read_dummy+0x23/0x70
>    full_proxy_read+0x6a/0xc0
>    vfs_read+0xc2/0x340
>    ? __pfx_direct_file_splice_eof+0x10/0x10
>    ? do_sendfile+0x1bd/0x2e0
>    ksys_read+0x76/0xe0
>    do_syscall_64+0xe3/0x1c0
>    ? exc_page_fault+0xa9/0x1d0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   RIP: 0033:0x4840cd
>   RSP: 002b:00007ffe99071828 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>   RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>   RDX: 0000000000001000 RSI: 00007ffe99071870 RDI: 0000000000000003
>   RBP: 00007ffe99071870 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>   R13: 00000000132fd3a0 R14: 0000000000000001 R15: ffffffffffffffff
>    </TASK>
>   INFO: task cat:115 is blocked on a mutex likely owned by task cat:114.
>   task:cat             state:S stack:13432 pid:114   tgid:114   ppid:106    task_flags:0x400100 flags:0x00000002
>   Call Trace:
>    <TASK>
>    __schedule+0x731/0x960
>    ? schedule_timeout+0xa8/0x120
>    schedule+0xb7/0x140
>    schedule_timeout+0xa8/0x120
>    ? __pfx_process_timeout+0x10/0x10
>    msleep_interruptible+0x3e/0x60
>    read_dummy+0x2d/0x70
>    full_proxy_read+0x6a/0xc0
>    vfs_read+0xc2/0x340
>    ? __pfx_direct_file_splice_eof+0x10/0x10
>    ? do_sendfile+0x1bd/0x2e0
>    ksys_read+0x76/0xe0
>    do_syscall_64+0xe3/0x1c0
>    ? exc_page_fault+0xa9/0x1d0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   RIP: 0033:0x4840cd
>   RSP: 002b:00007ffe3e0147b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>   RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
>   RDX: 0000000000001000 RSI: 00007ffe3e014800 RDI: 0000000000000003
>   RBP: 00007ffe3e014800 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
>   R13: 000000001a0a93a0 R14: 0000000000000001 R15: ffffffffffffffff
>    </TASK>
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   Changes in v4:
>    - Make this option depends on !PREEMPT_RT because it changes mutex to
>      rt_mutex.
> ---
>   include/linux/mutex.h  |    2 ++
>   include/linux/sched.h  |    4 ++++
>   kernel/hung_task.c     |   36 ++++++++++++++++++++++++++++++++++++
>   kernel/locking/mutex.c |   14 ++++++++++++++
>   lib/Kconfig.debug      |   11 +++++++++++
>   5 files changed, 67 insertions(+)
>
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 2bf91b57591b..2143d05116be 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -202,4 +202,6 @@ DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
>   DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
>   DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
>   
> +extern unsigned long mutex_get_owner(struct mutex *lock);
> +
>   #endif /* __LINUX_MUTEX_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9632e3318e0d..0cebdd736d44 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1217,6 +1217,10 @@ struct task_struct {
>   	struct mutex_waiter		*blocked_on;
>   #endif
>   
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +	struct mutex			*blocker_mutex;
> +#endif
> +
>   #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>   	int				non_block_count;
>   #endif
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 04efa7a6e69b..ccd7217fcec1 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -93,6 +93,41 @@ static struct notifier_block panic_block = {
>   	.notifier_call = hung_task_panic,
>   };
>   
> +
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +static void debug_show_blocker(struct task_struct *task)
> +{
> +	struct task_struct *g, *t;
> +	unsigned long owner;
> +	struct mutex *lock;
> +
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
> +
> +	lock = READ_ONCE(task->blocker_mutex);
> +	if (!lock)
> +		return;
> +
> +	owner = mutex_get_owner(lock);
> +	if (unlikely(!owner)) {
> +		pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
> +			task->comm, task->pid);
> +		return;
> +	}
> +
> +	/* Ensure the owner information is correct. */
> +	for_each_process_thread(g, t) {
> +		if ((unsigned long)t == owner) {
> +			pr_err("INFO: task %s:%d is blocked on a mutex likely owned by task %s:%d.\n",
> +				task->comm, task->pid, t->comm, t->pid);
> +			sched_show_task(t);
> +			return;
> +		}
> +	}
> +}
> +#else
> +#define debug_show_blocker(t)	do {} while (0)
> +#endif
> +
>   static void check_hung_task(struct task_struct *t, unsigned long timeout)
>   {
>   	unsigned long switch_count = t->nvcsw + t->nivcsw;
> @@ -152,6 +187,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>   		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
>   			" disables this message.\n");
>   		sched_show_task(t);
> +		debug_show_blocker(t);
>   		hung_task_show_lock = true;
>   
>   		if (sysctl_hung_task_all_cpu_backtrace)
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index b36f23de48f1..6a543c204a14 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -72,6 +72,14 @@ static inline unsigned long __owner_flags(unsigned long owner)
>   	return owner & MUTEX_FLAGS;
>   }
>   
> +/* Do not use the return value as a pointer directly. */
> +unsigned long mutex_get_owner(struct mutex *lock)
> +{
> +	unsigned long owner = atomic_long_read(&lock->owner);
> +
> +	return (unsigned long)__owner_task(owner);
> +}
> +
>   /*
>    * Returns: __mutex_owner(lock) on failure or NULL on success.
>    */
> @@ -180,6 +188,9 @@ static void
>   __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>   		   struct list_head *list)
>   {
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +	WRITE_ONCE(current->blocker_mutex, lock);
> +#endif
>   	debug_mutex_add_waiter(lock, waiter, current);
>   
>   	list_add_tail(&waiter->list, list);
> @@ -195,6 +206,9 @@ __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
>   		__mutex_clear_flag(lock, MUTEX_FLAGS);
>   
>   	debug_mutex_remove_waiter(lock, waiter, current);
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +	WRITE_ONCE(current->blocker_mutex, NULL);
> +#endif
>   }
>   
>   /*
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af972a92d06..77d8c7e5ce96 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1260,6 +1260,17 @@ config BOOTPARAM_HUNG_TASK_PANIC
>   
>   	  Say N if unsure.
>   
> +config DETECT_HUNG_TASK_BLOCKER
> +	bool "Dump Hung Tasks Blocker"
> +	depends on DETECT_HUNG_TASK
> +	depends on !PREEMPT_RT
> +	default y
> +	help
> +	  Say Y here to show the blocker task's stacktrace who acquires
> +	  the mutex lock which "hung tasks" are waiting.
> +	  This will add overhead a bit but shows suspicious tasks and
> +	  call trace if it comes from waiting a mutex.
> +
>   config WQ_WATCHDOG
>   	bool "Detect Workqueue Stalls"
>   	depends on DEBUG_KERNEL
>
Reviewed-by: Waiman Long <longman@redhat.com>


