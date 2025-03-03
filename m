Return-Path: <linux-kernel+bounces-541058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D6AA4B7EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 07:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F22188E590
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875B51E573B;
	Mon,  3 Mar 2025 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFykHc80"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988FF156237
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740983353; cv=none; b=lWeOLZh8yv5dQG8gWdxmjNpA00Brue4T2/PVyTTyANTM58mRNTHusJWYRnfQRjrIXOYbj6/iN6L28R7BriMaikef552cHCtrIOVCQPleP3mo30bcLlbCCsm2OmH7UuFTpQzRGyVzj7bYBernAJIQtdhBURR1Xt+Cj8MWzlPaEaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740983353; c=relaxed/simple;
	bh=BFtx/ZBVR48s0jNbp4xvL8poRgnxh/++hv6+2YiQR2g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q5DftWQQzDtuhR5qtClnMlEGBsGN7Io6ZUe7tNAIYCWm8wO//NM6HmEXFzygKSLFMpM1DWSzmGx+DIvV2HDV7dpSBmxiLtDrbgKXBziSIOlczCWVHbY8hdgv/eIFgvupU23rgLZi1wskj1xGuq40qrKmqDsqDp9rJDMOaTMhkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFykHc80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C636C4CEE4;
	Mon,  3 Mar 2025 06:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740983353;
	bh=BFtx/ZBVR48s0jNbp4xvL8poRgnxh/++hv6+2YiQR2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nFykHc80pMNXKTD76b8bfdxh0PRW3tQPibrGeWBDwYZafh4wv73eTPmIlyGRiKTIs
	 2GNPp5V2WGPuf3SJyLjGjV5X347loAhtz0sAtljaycGO9Vq6j8EUQJZOYGUcjJW7+K
	 mKdzGymWDwle6KyswRwsY5f1+OmA3C1BInSzQby3YFSutoigGRNeBep8LPggXxFIUc
	 wOEwCNmocMHREK+LEuv4aV/2u+j9HzBiICssdrGVGu45FTMQadb/YPFY3cigJTAA+s
	 mfWwL6n4+Fjwg5FI96KI55Y3T1ctDaZ2k2MNMP0+HzWau4DH7va6LDVRN/hW3tPIXb
	 PmxEqPzGudIQQ==
Date: Mon, 3 Mar 2025 15:29:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org,
 mingo@redhat.com, longman@redhat.com, mhiramat@kernel.org,
 anna.schumaker@oracle.com, boqun.feng@gmail.com, joel.granados@kernel.org,
 kent.overstreet@linux.dev, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 senozhatsky@chromium.org, tfiga@chromium.org, Mingzhe Yang
 <mingzhe.yang@ly.com>
Subject: Re: [PATCH 1/1] hung_task: show the blocker task if the task is
 hung on semaphore
Message-Id: <20250303152907.d61151bbdaf0b8a6a8f9978f@kernel.org>
In-Reply-To: <20250301055102.88746-1-ioworker0@gmail.com>
References: <20250301055102.88746-1-ioworker0@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Mar 2025 13:51:02 +0800
Lance Yang <ioworker0@gmail.com> wrote:

> Inspired by mutex blocker tracking[1], this patch makes a trade-off to
> balance the overhead and utility of the hung task detector.

Thanks for adding new one! 

> 
> Unlike mutexes, semaphores lack explicit ownership tracking, making it
> challenging to identify the root cause of hangs. To address this, we
> introduce a last_holder field to the semaphore structure, which is
> updated when a task successfully calls down() and cleared during up().
> 
> The assumption is that if a task is blocked on a semaphore, the holders
> must not have released it. While this does not guarantee that the last
> holder is one of the current blockers, it likely provides a practical hint
> for diagnosing semaphore-related stalls.

Yeah, if we can have something like the owner_list, we can find the
longest time blocker (owner) but it takes more {memory, performance}
overheads.

> 
> With this change, the hung task detector can now show blocker task's info
> like below:
> 
> [Sat Mar  1 02:39:52 2025] INFO: task cat:1437 blocked for more than 122 seconds.
> [Sat Mar  1 02:39:52 2025]       Tainted: G           OE      6.14.0-rc3+ #9
> [Sat Mar  1 02:39:52 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Sat Mar  1 02:39:52 2025] task:cat             state:D stack:0     pid:1437  tgid:1437  ppid:1007   task_flags:0x400000 flags:0x00000004
> [Sat Mar  1 02:39:52 2025] Call trace:
> [Sat Mar  1 02:39:52 2025]  __switch_to+0x1ec/0x380 (T)
> [Sat Mar  1 02:39:52 2025]  __schedule+0xc30/0x44f8
> [Sat Mar  1 02:39:52 2025]  schedule+0xb8/0x3b0
> [Sat Mar  1 02:39:52 2025]  schedule_timeout+0x1d0/0x208
> [Sat Mar  1 02:39:52 2025]  __down_common+0x27c/0x600
> [Sat Mar  1 02:39:52 2025]  __down+0x24/0x50
> [Sat Mar  1 02:39:52 2025]  down+0xe0/0x140
> [Sat Mar  1 02:39:52 2025]  read_dummy+0x3c/0xa0 [hung_task_sem]
> [Sat Mar  1 02:39:52 2025]  full_proxy_read+0xfc/0x1d0
> [Sat Mar  1 02:39:52 2025]  vfs_read+0x1a0/0x858
> [Sat Mar  1 02:39:52 2025]  ksys_read+0x100/0x220
> [Sat Mar  1 02:39:52 2025]  __arm64_sys_read+0x78/0xc8
> [Sat Mar  1 02:39:52 2025]  invoke_syscall+0xd8/0x278
> [Sat Mar  1 02:39:52 2025]  el0_svc_common.constprop.0+0xb8/0x298
> [Sat Mar  1 02:39:52 2025]  do_el0_svc+0x4c/0x88
> [Sat Mar  1 02:39:52 2025]  el0_svc+0x44/0x108
> [Sat Mar  1 02:39:52 2025]  el0t_64_sync_handler+0x134/0x160
> [Sat Mar  1 02:39:52 2025]  el0t_64_sync+0x1b8/0x1c0
> [Sat Mar  1 02:39:52 2025] INFO: task cat:1437 blocked on a semaphore likely last held by task cat:1436
> [Sat Mar  1 02:39:52 2025] task:cat             state:S stack:0     pid:1436  tgid:1436  ppid:1007   task_flags:0x400000 flags:0x00000004
> [Sat Mar  1 02:39:52 2025] Call trace:
> [Sat Mar  1 02:39:52 2025]  __switch_to+0x1ec/0x380 (T)
> [Sat Mar  1 02:39:52 2025]  __schedule+0xc30/0x44f8
> [Sat Mar  1 02:39:52 2025]  schedule+0xb8/0x3b0
> [Sat Mar  1 02:39:52 2025]  schedule_timeout+0xf4/0x208
> [Sat Mar  1 02:39:52 2025]  msleep_interruptible+0x70/0x130
> [Sat Mar  1 02:39:52 2025]  read_dummy+0x48/0xa0 [hung_task_sem]
> [Sat Mar  1 02:39:52 2025]  full_proxy_read+0xfc/0x1d0
> [Sat Mar  1 02:39:52 2025]  vfs_read+0x1a0/0x858
> [Sat Mar  1 02:39:52 2025]  ksys_read+0x100/0x220
> [Sat Mar  1 02:39:52 2025]  __arm64_sys_read+0x78/0xc8
> [Sat Mar  1 02:39:52 2025]  invoke_syscall+0xd8/0x278
> [Sat Mar  1 02:39:52 2025]  el0_svc_common.constprop.0+0xb8/0x298
> [Sat Mar  1 02:39:52 2025]  do_el0_svc+0x4c/0x88
> [Sat Mar  1 02:39:52 2025]  el0_svc+0x44/0x108
> [Sat Mar  1 02:39:52 2025]  el0t_64_sync_handler+0x134/0x160
> [Sat Mar  1 02:39:52 2025]  el0t_64_sync+0x1b8/0x1c0
> 
> [1] https://lore.kernel.org/all/174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com
> 
> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  include/linux/sched.h      |  1 +
>  include/linux/semaphore.h  | 15 ++++++++++-
>  kernel/hung_task.c         | 52 ++++++++++++++++++++++++++-----------
>  kernel/locking/semaphore.c | 53 ++++++++++++++++++++++++++++++++++----
>  4 files changed, 100 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 0cebdd736d44..5dfdca879ac4 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1219,6 +1219,7 @@ struct task_struct {
>  
>  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
>  	struct mutex			*blocker_mutex;
> +	struct semaphore		*blocker_sem;

Can we make this a union because only one blocker is active at a time?
Waiman has been suggested the update way;

https://lore.kernel.org/all/9f9150b4-1cf5-4380-b431-419f70775a7d@redhat.com/

If we can use MSB or LSB of those pointers, it is the smallest memory
footprint.

>  #endif
>  
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
> index 04655faadc2d..ca8240a5dbfc 100644
> --- a/include/linux/semaphore.h
> +++ b/include/linux/semaphore.h
> @@ -16,13 +16,25 @@ struct semaphore {
>  	raw_spinlock_t		lock;
>  	unsigned int		count;
>  	struct list_head	wait_list;
> +
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +	atomic_long_t last_holder;
> +#endif

Would we need to make this atomic? I think mutex needs to use it directly
as a pointer, but debug_show_blocker() searches the task, so we can
use an unsigned long + WRITE_ONCE()/READ_ONCE().

>  };
>  
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +#define __LAST_HOLDER_SEMAPHORE_INITIALIZER				\
> +	, .last_holder = ATOMIC_LONG_INIT(0)
> +#else
> +#define __LAST_HOLDER_SEMAPHORE_INITIALIZER
> +#endif
> +
>  #define __SEMAPHORE_INITIALIZER(name, n)				\
>  {									\
>  	.lock		= __RAW_SPIN_LOCK_UNLOCKED((name).lock),	\
>  	.count		= n,						\
> -	.wait_list	= LIST_HEAD_INIT((name).wait_list),		\
> +	.wait_list	= LIST_HEAD_INIT((name).wait_list)		\
> +	__LAST_HOLDER_SEMAPHORE_INITIALIZER				\
>  }
>  
>  /*
> @@ -47,5 +59,6 @@ extern int __must_check down_killable(struct semaphore *sem);
>  extern int __must_check down_trylock(struct semaphore *sem);
>  extern int __must_check down_timeout(struct semaphore *sem, long jiffies);
>  extern void up(struct semaphore *sem);
> +extern unsigned long sem_last_holder(struct semaphore *sem);
>  
>  #endif /* __LINUX_SEMAPHORE_H */
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index ccd7217fcec1..332f555a97a9 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -98,30 +98,52 @@ static struct notifier_block panic_block = {
>  static void debug_show_blocker(struct task_struct *task)
>  {
>  	struct task_struct *g, *t;
> -	unsigned long owner;
> -	struct mutex *lock;
> +	unsigned long owner, holder;
> +	struct semaphore *sem_lock;
> +	struct mutex *mutex_lock;
>  
>  	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
>  
> -	lock = READ_ONCE(task->blocker_mutex);
> -	if (!lock)
> -		return;
> +	mutex_lock = READ_ONCE(task->blocker_mutex);
> +	if (mutex_lock) {
> +		owner = mutex_get_owner(mutex_lock);
> +		if (unlikely(!owner)) {
> +			pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
> +			       task->comm, task->pid);
> +			goto blocker_sem;
> +		}
>  
> -	owner = mutex_get_owner(lock);
> -	if (unlikely(!owner)) {
> -		pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
> -			task->comm, task->pid);
> +		/* Ensure the owner information is correct. */
> +		for_each_process_thread(g, t) {
> +			if ((unsigned long)t == owner) {
> +				pr_err("INFO: task %s:%d is blocked on a mutex likely owned by task %s:%d.\n",
> +				       task->comm, task->pid, t->comm, t->pid);
> +				sched_show_task(t);
> +				return;
> +			}
> +		}
>  		return;
>  	}
>  
> -	/* Ensure the owner information is correct. */
> -	for_each_process_thread(g, t) {
> -		if ((unsigned long)t == owner) {
> -			pr_err("INFO: task %s:%d is blocked on a mutex likely owned by task %s:%d.\n",
> -				task->comm, task->pid, t->comm, t->pid);
> -			sched_show_task(t);
> +blocker_sem:
> +	sem_lock = READ_ONCE(task->blocker_sem);
> +	if (sem_lock) {
> +		holder = sem_last_holder(sem_lock);
> +		if (unlikely(!holder)) {
> +			pr_err("INFO: task %s:%d is blocked on a semaphore, but the last holder is not found.\n",
> +			       task->comm, task->pid);
>  			return;
>  		}
> +
> +		for_each_process_thread(g, t) {
> +			if ((unsigned long)t == holder) {
> +				pr_err("INFO: task %s:%d blocked on a semaphore likely last held by task %s:%d\n",
> +				       task->comm, task->pid, t->comm, t->pid);
> +				sched_show_task(t);
> +				return;
> +			}
> +		}
> +		return;
>  	}
>  }
>  #else
> diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
> index 34bfae72f295..5a684c0a3087 100644
> --- a/kernel/locking/semaphore.c
> +++ b/kernel/locking/semaphore.c
> @@ -39,6 +39,7 @@ static noinline int __down_interruptible(struct semaphore *sem);
>  static noinline int __down_killable(struct semaphore *sem);
>  static noinline int __down_timeout(struct semaphore *sem, long timeout);
>  static noinline void __up(struct semaphore *sem);
> +static inline void __sem_acquire(struct semaphore *sem);
>  
>  /**
>   * down - acquire the semaphore
> @@ -58,7 +59,7 @@ void __sched down(struct semaphore *sem)
>  	might_sleep();
>  	raw_spin_lock_irqsave(&sem->lock, flags);
>  	if (likely(sem->count > 0))
> -		sem->count--;
> +		__sem_acquire(sem);
>  	else
>  		__down(sem);
>  	raw_spin_unlock_irqrestore(&sem->lock, flags);
> @@ -82,7 +83,7 @@ int __sched down_interruptible(struct semaphore *sem)
>  	might_sleep();
>  	raw_spin_lock_irqsave(&sem->lock, flags);
>  	if (likely(sem->count > 0))
> -		sem->count--;
> +		__sem_acquire(sem);
>  	else
>  		result = __down_interruptible(sem);
>  	raw_spin_unlock_irqrestore(&sem->lock, flags);
> @@ -109,7 +110,7 @@ int __sched down_killable(struct semaphore *sem)
>  	might_sleep();
>  	raw_spin_lock_irqsave(&sem->lock, flags);
>  	if (likely(sem->count > 0))
> -		sem->count--;
> +		__sem_acquire(sem);
>  	else
>  		result = __down_killable(sem);
>  	raw_spin_unlock_irqrestore(&sem->lock, flags);
> @@ -139,7 +140,7 @@ int __sched down_trylock(struct semaphore *sem)
>  	raw_spin_lock_irqsave(&sem->lock, flags);
>  	count = sem->count - 1;
>  	if (likely(count >= 0))
> -		sem->count = count;
> +		__sem_acquire(sem);
>  	raw_spin_unlock_irqrestore(&sem->lock, flags);
>  
>  	return (count < 0);
> @@ -164,7 +165,7 @@ int __sched down_timeout(struct semaphore *sem, long timeout)
>  	might_sleep();
>  	raw_spin_lock_irqsave(&sem->lock, flags);
>  	if (likely(sem->count > 0))
> -		sem->count--;
> +		__sem_acquire(sem);
>  	else
>  		result = __down_timeout(sem, timeout);
>  	raw_spin_unlock_irqrestore(&sem->lock, flags);
> @@ -242,10 +243,18 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
>  {
>  	int ret;
>  
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +	WRITE_ONCE(current->blocker_sem, sem);
> +#endif
> +
>  	trace_contention_begin(sem, 0);
>  	ret = ___down_common(sem, state, timeout);
>  	trace_contention_end(sem, ret);
>  
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +	WRITE_ONCE(current->blocker_sem, NULL);
> +#endif
> +
>  	return ret;
>  }
>  
> @@ -274,6 +283,40 @@ static noinline void __sched __up(struct semaphore *sem)
>  	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
>  						struct semaphore_waiter, list);
>  	list_del(&waiter->list);
> +
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +	atomic_long_cmpxchg_release(&sem->last_holder, (unsigned long)current,
> +				    0UL);

Ah, you don't need atomic here because __up() is called with sem->lock locked.
Also, if wait_list is empty, the 'up()' does only sem->count++. In this case,
the owner is not cleared.

Thank you,

> +#endif
> +
>  	waiter->up = true;
>  	wake_up_process(waiter->task);
>  }
> +
> +static inline struct task_struct *__holder_task(unsigned long holder)
> +{
> +	return (struct task_struct *)holder;
> +}
> +
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +/* Do not use the return value as a pointer directly. */
> +unsigned long sem_last_holder(struct semaphore *sem)
> +{
> +	unsigned long holder = atomic_long_read(&sem->last_holder);
> +
> +	return (unsigned long)__holder_task(holder);
> +}
> +#else
> +unsigned long sem_last_holder(struct semaphore *sem)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static inline void __sem_acquire(struct semaphore *sem)
> +{
> +	sem->count--;
> +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> +	atomic_long_set(&sem->last_holder, (unsigned long)current);
> +#endif
> +}
> -- 
> 2.45.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

