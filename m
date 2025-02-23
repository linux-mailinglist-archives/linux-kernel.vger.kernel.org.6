Return-Path: <linux-kernel+bounces-527919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1B3A4114A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58797A978A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960EA1632EF;
	Sun, 23 Feb 2025 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/Mki39A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889EB846F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740339306; cv=none; b=nK2Odb0MiOY4IshK0SOww4buEGdi3X8L0TnyAxP9LdYXeLK3ojgQoEoJaPu52pRZC/e1Q1QQ2cwD6vg+2aU9GnAtzry4Q2n509ZryofVn89EhjvLdowwMmHM6XZp9qrOkFNh38zpMSuPpNY+alL4a0BaPVTfuV68FnMTqzhiy+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740339306; c=relaxed/simple;
	bh=PUqpbMb+6ExX8bIxY2H0hbdqf8iSW/ySK+9fdOlLylI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TjHk0SLM0ZMsUoPw663Ja3QDPsFdF7oANK42DbvUry3d2/XVk3pZsJXkXwVNMxJgr6qSQdMMpOBznSjd0aY6x+ZBSWHUyZAcUxIA0KzdbrGDF1P597GsgHfQmJ98qNv3P7crT3AocSuNFBkU9ViXcKJkmjqevD5XBwHqTGXnz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/Mki39A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740339303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=686itv6I963h5+kbvhCPxE4uIEHbXXPmnc6dzgWyLiQ=;
	b=M/Mki39AWKzdoKkupGdEmqTWR2RCogjon7npN+7+QAI/mGX3Rm4nDg8F7X4xS86hZpkKXi
	Y3hlt7jxvem9H0pUq+dGkx1EDRiIfSyOySEhFLN2N+ntbWFYYbNovRTK57u6PaNl8gIdh+
	2N+2goje7zvmKpqUjm1+ZpCpFJoNXbY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-r1LHmqmKPk6a2DqecSQjHQ-1; Sun, 23 Feb 2025 14:35:02 -0500
X-MC-Unique: r1LHmqmKPk6a2DqecSQjHQ-1
X-Mimecast-MFC-AGG-ID: r1LHmqmKPk6a2DqecSQjHQ_1740339301
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-471fc73b941so115630131cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740339301; x=1740944101;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=686itv6I963h5+kbvhCPxE4uIEHbXXPmnc6dzgWyLiQ=;
        b=uUm+C50zUCrLILJe4kfwT+H6r9Z2JoJhpvE09nM4ROalsNn4Np59o8BZBECCACpGZw
         NLS/JZmOVBz2M4Hq5xws3t9CsVtJUB9lD4gqJyYDsWQPpmklG3KrkTPaeONGvaekpLKb
         WDwwYpV35NzExQUgWxk7vhhfGdzMK9YFJCMv1qI+EYPO26CH2BDcEDdLLhC4XJzgNhGV
         695u5Jnmwv38enkirIVxkgpAPLRc6VlK6aUhf/SNzwvwpn/9LSj24htWLl5GmKSKeBTf
         +BSxrOaD0qruArSsg4jp9zfNRs4GjTdJBMrClZariOZYfswcIjnEzHsJIOl6xd+/x+9b
         1ePg==
X-Forwarded-Encrypted: i=1; AJvYcCXQTIDyvVJu+bdEhYnlc9FuE3Tnyi31j10D3eUK7RsPAHBVjEpaP1cK1PwPhvhAs+9lfTfKExNpj9Pnqv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+VALhFUO7WfKyYTmHJTGcqJfjjN8Cli+skG1WOZhc5L2DEALm
	t/77dVg5LMB8n0xyW8LIm3Uw6qzds3u5bM7KQnkScwj4Pg9zG2ZL/MP/isSmNkzHoUcmSw0/jED
	xNGInKF6Lvo1llDeZJ457cc7qLSJMM1YsII0benA1n2PHaxDFmK6ZYjvnnOsGCQ==
X-Gm-Gg: ASbGncszpfL/NxdlXIiEuDvG/Dle2uu8ChIbWBwvNX0ntQdzQ8Es/VUwZIP8ptOYVuO
	ZG/zubVeEbj0Jl4c9ayFTN++/tW7KTs8doAkIYy+ChJBps7pnGm8tmOWxBAuDDvbRs3clsge/XO
	fuHC9xFfkOAlRm0rZhjOBggThf7YePUYjxTzU6eqdLzxub3M1MiaMybjS7iNIQZJgarrZcj0FVl
	82JZBps+P75NpPhBu2PRk9LKVv7LwN4UeD0MGueuEuozZx8jC4kmhghgGycy2pPWHBTGW2vsAmT
	avMOR7uYMwUfniVjBlMGzcwRuJJb00MWpBCbBjzM4FVkbjLsdnh+DYOwpzo=
X-Received: by 2002:a05:622a:38a:b0:472:1289:f88c with SMTP id d75a77b69052e-472228e6f7fmr166118751cf.28.1740339301351;
        Sun, 23 Feb 2025 11:35:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhW7DLZmvUM+5FXeRhmjVwx+l293cQQQ12dpaBM8nMP9CA3kkPfUJNQ6oUTRYwwSqGX3jwEw==
X-Received: by 2002:a05:622a:38a:b0:472:1289:f88c with SMTP id d75a77b69052e-472228e6f7fmr166118421cf.28.1740339300952;
        Sun, 23 Feb 2025 11:35:00 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f6186111sm77040781cf.68.2025.02.23.11.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 11:35:00 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <fdb8adb0-efaf-45c7-8814-212026d7da53@redhat.com>
Date: Sun, 23 Feb 2025 14:34:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hung_task: Show the blocker task if the task is
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
References: <174018982058.2766225.1721562132740498299.stgit@mhiramat.tok.corp.google.com>
 <174018983078.2766225.824985516904203702.stgit@mhiramat.tok.corp.google.com>
Content-Language: en-US
In-Reply-To: <174018983078.2766225.824985516904203702.stgit@mhiramat.tok.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/25 9:03 PM, Masami Hiramatsu (Google) wrote:
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
>   Changes in v3:
>    - Add RCU_LOCKDEP_WARN() to ensure rcu_read_lock() is held.
>    - Cleanup code to make it fail-fast and add brace to
>      for_each_process_thread().
>    - Change the message to "likely owned" instead of "owned".
>   Changes in v2:
>    - Introduce CONFIG_DETECT_HUNG_TASK_BLOCKER for this feature.
>    - Introduce task_struct::blocker_mutex to point the mutex.
>    - Rename debug_mutex_get_owner() to mutex_get_owner().
>    - Remove unneeded mutex_waiter::mutex.
> ---
>   include/linux/mutex.h  |    2 ++
>   include/linux/sched.h  |    4 ++++
>   kernel/hung_task.c     |   36 ++++++++++++++++++++++++++++++++++++
>   kernel/locking/mutex.c |   14 ++++++++++++++
>   lib/Kconfig.debug      |   10 ++++++++++
>   5 files changed, 66 insertions(+)
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

This patch looks good, but there is a PREEMPT_RT complication that you 
need to handle as well. Most of the mutex.c is compiled out if 
CONFIG_PREEMPT_RT is defined.

You can either add the CONFIG_PREEMPT_RT check in your 
debug_show_blocker() function or in the mutex_get_owner() declaration in 
mutex.h.

You should enable CONFIG_PREEMPT_RT in a test build to make sure that 
nothing break.

Cheers,
Longman


