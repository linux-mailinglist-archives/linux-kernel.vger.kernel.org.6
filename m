Return-Path: <linux-kernel+bounces-530200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBDAA43077
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A7B3B2B52
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F7A1A9B23;
	Mon, 24 Feb 2025 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqNq2sDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053D4430
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438158; cv=none; b=i7ltMnRLta1ggp/HDbOgvBuO4J53MHhT74vC1bmxT7Npi/L0DrA6MxlkZGb50/afMYTuKLewmuhuHNhWdv1YJ20o4kkBa19wKmdDvQi7L52to9Zbkc7owJpOk7jLQEVstXzQh5OMocsAeLYWUQSHo5h3OTZzvLyW0jY7XcLKCWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438158; c=relaxed/simple;
	bh=kkVXBrw8Y8rrFkPgLEYintRuLwZm2BlTxZ7NJ9S/HKA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=guEzqGtB+5Ta1wxoy9L3BjLKBW6RUyEQwSt1BVzBdq7h4qYF85zGzPioQzLitubM7x0TAMM7P7BCwLakFegJSMudymMEMnyczsvb+OVSYfYrqADbk8Kn1Vbc2dLbZLKOvW7ACQ7GuaK5emqxqcdF7u0isLC+UzLFphYqvlA4fhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqNq2sDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8026C4CED6;
	Mon, 24 Feb 2025 23:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740438157;
	bh=kkVXBrw8Y8rrFkPgLEYintRuLwZm2BlTxZ7NJ9S/HKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KqNq2sDGZDUED4fqw1A7tca+Hyc2U40fxoPdAS5ndI2t3Pa5fxfJB3iomRgEcWIae
	 VJErS0gXRoc3oAHfFYddFdvfyWHwJytilDVkXhy1OU3BgJdaSuSdpXUxOlKN7c7v1u
	 Neh06GqbVTJTpkf1gtwcwSzj7E+Je9Fuj/YcPool4ummLnRDpEJ2pUVFLHWBR+LAF9
	 +UibGhS4dXNQ+pDW5chmgNmrGL6YX4ybuZXsBsmtl6LnOs0bfXWhXc+51O+vhM3By+
	 FlGzcYUOAIDyXQsIQLau9xmhLMiDcHnROFvONrsut3pJjZ/bdxImW2aloDYC/RRlfT
	 3eb9sOPmsMqLw==
Date: Tue, 25 Feb 2025 08:02:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Granados
 <joel.granados@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>,
 Lance Yang <ioworker0@gmail.com>, Kent Overstreet
 <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, Steven
 Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-Id: <20250225080231.f98b26c354279b1f74c57990@kernel.org>
In-Reply-To: <fdb8adb0-efaf-45c7-8814-212026d7da53@redhat.com>
References: <174018982058.2766225.1721562132740498299.stgit@mhiramat.tok.corp.google.com>
	<174018983078.2766225.824985516904203702.stgit@mhiramat.tok.corp.google.com>
	<fdb8adb0-efaf-45c7-8814-212026d7da53@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Feb 2025 14:34:58 -0500
Waiman Long <llong@redhat.com> wrote:

> On 2/21/25 9:03 PM, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > The "hung_task" shows a long-time uninterruptible slept task, but most
> > often, it's blocked on a mutex acquired by another task. Without
> > dumping such a task, investigating the root cause of the hung task
> > problem is very difficult.
> >
> > This introduce task_struct::blocker_mutex to point the mutex lock
> > which this task is waiting for. Since the mutex has "owner"
> > information, we can find the owner task and dump it with hung tasks.
> >
> > Note: the owner can be changed while dumping the owner task, so
> > this is "likely" the owner of the mutex.
> >
> > With this change, the hung task shows blocker task's info like below;
> >
> >   INFO: task cat:115 blocked for more than 122 seconds.
> >         Not tainted 6.14.0-rc3-00003-ga8946be3de00 #156
> >   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >   task:cat             state:D stack:13432 pid:115   tgid:115   ppid:106    task_flags:0x400100 flags:0x00000002
> >   Call Trace:
> >    <TASK>
> >    __schedule+0x731/0x960
> >    ? schedule_preempt_disabled+0x54/0xa0
> >    schedule+0xb7/0x140
> >    ? __mutex_lock+0x51b/0xa60
> >    ? __mutex_lock+0x51b/0xa60
> >    schedule_preempt_disabled+0x54/0xa0
> >    __mutex_lock+0x51b/0xa60
> >    read_dummy+0x23/0x70
> >    full_proxy_read+0x6a/0xc0
> >    vfs_read+0xc2/0x340
> >    ? __pfx_direct_file_splice_eof+0x10/0x10
> >    ? do_sendfile+0x1bd/0x2e0
> >    ksys_read+0x76/0xe0
> >    do_syscall_64+0xe3/0x1c0
> >    ? exc_page_fault+0xa9/0x1d0
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >   RIP: 0033:0x4840cd
> >   RSP: 002b:00007ffe99071828 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> >   RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
> >   RDX: 0000000000001000 RSI: 00007ffe99071870 RDI: 0000000000000003
> >   RBP: 00007ffe99071870 R08: 0000000000000000 R09: 0000000000000000
> >   R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
> >   R13: 00000000132fd3a0 R14: 0000000000000001 R15: ffffffffffffffff
> >    </TASK>
> >   INFO: task cat:115 is blocked on a mutex likely owned by task cat:114.
> >   task:cat             state:S stack:13432 pid:114   tgid:114   ppid:106    task_flags:0x400100 flags:0x00000002
> >   Call Trace:
> >    <TASK>
> >    __schedule+0x731/0x960
> >    ? schedule_timeout+0xa8/0x120
> >    schedule+0xb7/0x140
> >    schedule_timeout+0xa8/0x120
> >    ? __pfx_process_timeout+0x10/0x10
> >    msleep_interruptible+0x3e/0x60
> >    read_dummy+0x2d/0x70
> >    full_proxy_read+0x6a/0xc0
> >    vfs_read+0xc2/0x340
> >    ? __pfx_direct_file_splice_eof+0x10/0x10
> >    ? do_sendfile+0x1bd/0x2e0
> >    ksys_read+0x76/0xe0
> >    do_syscall_64+0xe3/0x1c0
> >    ? exc_page_fault+0xa9/0x1d0
> >    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >   RIP: 0033:0x4840cd
> >   RSP: 002b:00007ffe3e0147b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> >   RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004840cd
> >   RDX: 0000000000001000 RSI: 00007ffe3e014800 RDI: 0000000000000003
> >   RBP: 00007ffe3e014800 R08: 0000000000000000 R09: 0000000000000000
> >   R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000001000
> >   R13: 000000001a0a93a0 R14: 0000000000000001 R15: ffffffffffffffff
> >    </TASK>
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >   Changes in v3:
> >    - Add RCU_LOCKDEP_WARN() to ensure rcu_read_lock() is held.
> >    - Cleanup code to make it fail-fast and add brace to
> >      for_each_process_thread().
> >    - Change the message to "likely owned" instead of "owned".
> >   Changes in v2:
> >    - Introduce CONFIG_DETECT_HUNG_TASK_BLOCKER for this feature.
> >    - Introduce task_struct::blocker_mutex to point the mutex.
> >    - Rename debug_mutex_get_owner() to mutex_get_owner().
> >    - Remove unneeded mutex_waiter::mutex.
> > ---
> >   include/linux/mutex.h  |    2 ++
> >   include/linux/sched.h  |    4 ++++
> >   kernel/hung_task.c     |   36 ++++++++++++++++++++++++++++++++++++
> >   kernel/locking/mutex.c |   14 ++++++++++++++
> >   lib/Kconfig.debug      |   10 ++++++++++
> >   5 files changed, 66 insertions(+)
> >
> > diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> > index 2bf91b57591b..2143d05116be 100644
> > --- a/include/linux/mutex.h
> > +++ b/include/linux/mutex.h
> > @@ -202,4 +202,6 @@ DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
> >   DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
> >   DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
> >   
> > +extern unsigned long mutex_get_owner(struct mutex *lock);
> > +
> >   #endif /* __LINUX_MUTEX_H */
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 9632e3318e0d..0cebdd736d44 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1217,6 +1217,10 @@ struct task_struct {
> >   	struct mutex_waiter		*blocked_on;
> >   #endif
> >   
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +	struct mutex			*blocker_mutex;
> > +#endif
> > +
> >   #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> >   	int				non_block_count;
> >   #endif
> > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > index 04efa7a6e69b..ccd7217fcec1 100644
> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -93,6 +93,41 @@ static struct notifier_block panic_block = {
> >   	.notifier_call = hung_task_panic,
> >   };
> >   
> > +
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +static void debug_show_blocker(struct task_struct *task)
> > +{
> > +	struct task_struct *g, *t;
> > +	unsigned long owner;
> > +	struct mutex *lock;
> > +
> > +	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
> > +
> > +	lock = READ_ONCE(task->blocker_mutex);
> > +	if (!lock)
> > +		return;
> > +
> > +	owner = mutex_get_owner(lock);
> > +	if (unlikely(!owner)) {
> > +		pr_err("INFO: task %s:%d is blocked on a mutex, but the owner is not found.\n",
> > +			task->comm, task->pid);
> > +		return;
> > +	}
> > +
> > +	/* Ensure the owner information is correct. */
> > +	for_each_process_thread(g, t) {
> > +		if ((unsigned long)t == owner) {
> > +			pr_err("INFO: task %s:%d is blocked on a mutex likely owned by task %s:%d.\n",
> > +				task->comm, task->pid, t->comm, t->pid);
> > +			sched_show_task(t);
> > +			return;
> > +		}
> > +	}
> > +}
> > +#else
> > +#define debug_show_blocker(t)	do {} while (0)
> > +#endif
> > +
> >   static void check_hung_task(struct task_struct *t, unsigned long timeout)
> >   {
> >   	unsigned long switch_count = t->nvcsw + t->nivcsw;
> > @@ -152,6 +187,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
> >   		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
> >   			" disables this message.\n");
> >   		sched_show_task(t);
> > +		debug_show_blocker(t);
> >   		hung_task_show_lock = true;
> >   
> >   		if (sysctl_hung_task_all_cpu_backtrace)
> > diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> > index b36f23de48f1..6a543c204a14 100644
> > --- a/kernel/locking/mutex.c
> > +++ b/kernel/locking/mutex.c
> > @@ -72,6 +72,14 @@ static inline unsigned long __owner_flags(unsigned long owner)
> >   	return owner & MUTEX_FLAGS;
> >   }
> >   
> > +/* Do not use the return value as a pointer directly. */
> > +unsigned long mutex_get_owner(struct mutex *lock)
> > +{
> > +	unsigned long owner = atomic_long_read(&lock->owner);
> > +
> > +	return (unsigned long)__owner_task(owner);
> > +}
> > +
> >   /*
> >    * Returns: __mutex_owner(lock) on failure or NULL on success.
> >    */
> > @@ -180,6 +188,9 @@ static void
> >   __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
> >   		   struct list_head *list)
> >   {
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +	WRITE_ONCE(current->blocker_mutex, lock);
> > +#endif
> >   	debug_mutex_add_waiter(lock, waiter, current);
> >   
> >   	list_add_tail(&waiter->list, list);
> > @@ -195,6 +206,9 @@ __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
> >   		__mutex_clear_flag(lock, MUTEX_FLAGS);
> >   
> >   	debug_mutex_remove_waiter(lock, waiter, current);
> > +#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
> > +	WRITE_ONCE(current->blocker_mutex, NULL);
> > +#endif
> >   }
> 
> This patch looks good, but there is a PREEMPT_RT complication that you 
> need to handle as well. Most of the mutex.c is compiled out if 
> CONFIG_PREEMPT_RT is defined.

Thanks for pointing it out!
I think we can make the DETECT_HUNG_TASK_BLOCKER depend on !PREEMPT_RT.

> 
> You can either add the CONFIG_PREEMPT_RT check in your 
> debug_show_blocker() function or in the mutex_get_owner() declaration in 
> mutex.h.
> 
> You should enable CONFIG_PREEMPT_RT in a test build to make sure that 
> nothing break.

OK.

Thank you!

> 
> Cheers,
> Longman
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

