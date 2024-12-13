Return-Path: <linux-kernel+bounces-445693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AE79F19D0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B5716AD96
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BC11B4155;
	Fri, 13 Dec 2024 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bKwmay+e"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB72E62B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132156; cv=none; b=OT1l0doaVkLS/gviRMCz3JldWrcsjZx9obry9tq3nyzFmn2FFQHjCDHFw3wyukAe0kQPqjyI81AW80WEQ/pzLK4mbKkOOIqYhkapI0rerHw75PTKlxnFJtdpypPodI1mqtH3X1WIgyYTqEqiyWu0iHWiMgWiV42DYn2s0XdnpI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132156; c=relaxed/simple;
	bh=RB8IUD0cYGapV7oqouIRl+cR2NMC984FJK0+Vw14JGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Po5LJk5Y7B5HQ8ePMIN+BSE2ILc5xlJX+l0I6K6kbtpLSM9isK1TsAzInieU38uZbUI/1It1zPZa9bd6Z/b7lSd1pNgAik+ANmgvxW5Ic2bkGMNSAkskvg4vpFMJnynA0JGVco5xiT6twPv9XMmlBmWe8E8cXVB6NEs8LpujfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bKwmay+e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WV2PK8AxGWaMjacNcThLuYoSz8sBeR1DqP4m1OPPV8s=; b=bKwmay+egYxLFTgbiDaQDS+KNG
	MqQXNGOZsEYjS8DLl4vzzMDZEBF7rdB2tfpXrb6LgVBzLp2ODJU8ZzcwUCZi0qr6CL/AQDGv0qaaJ
	poxdSeSI6azyek8wfSRght+7pVKedt9Hn9+COXT4Llf3/QHNIAyOOwyinJ+VNQzFQlHJ+2Q/YKJmp
	5bmavkk6nwg8XTrMZeRWbnfT/oJl5wyhMNcqnkYUhQW0qwOrtR885kQNsifuMYsAeSOXfntchykTS
	aWuwXDyDWxHO/i2Snc2rgFsrIppJA2sUu5AFG8tnZ1x2CNSUfDyo2t+jikxUhaXscKlrjxLHXhqij
	jXXpieDw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMEzA-0000000GRVK-1I7b;
	Fri, 13 Dec 2024 23:22:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CC01230049D; Sat, 14 Dec 2024 00:22:14 +0100 (CET)
Date: Sat, 14 Dec 2024 00:22:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [RFC][PATCH v14 2/7] locking/mutex: Rework
 task_struct::blocked_on
Message-ID: <20241213232214.GA17501@noisy.programming.kicks-ass.net>
References: <20241125195204.2374458-1-jstultz@google.com>
 <20241125195204.2374458-3-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125195204.2374458-3-jstultz@google.com>

On Mon, Nov 25, 2024 at 11:51:56AM -0800, John Stultz wrote:

> Also add a blocked_on_state value so we can distinguish when a
> task is blocked_on a mutex, but is either blocked, waking up, or
> runnable (such that it can try to acquire the lock its blocked
> on).
> 
> This avoids some of the subtle & racy games where the blocked_on
> state gets cleared, only to have it re-added by the
> mutex_lock_slowpath call when it tries to acquire the lock on
> wakeup

If you can remember those sublte cases, I'm sure our future selves
would've loved it if you wrote a comment to go with these states :-)

> +enum blocked_on_state {
> +	BO_RUNNABLE,
> +	BO_BLOCKED,
> +	BO_WAKING,
> +};
> +
>  struct task_struct {
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/*
> @@ -1195,10 +1202,9 @@ struct task_struct {
>  	struct rt_mutex_waiter		*pi_blocked_on;
>  #endif
>  
> -#ifdef CONFIG_DEBUG_MUTEXES
> -	/* Mutex deadlock detection: */
> -	struct mutex_waiter		*blocked_on;
> -#endif
> +	enum blocked_on_state		blocked_on_state;
> +	struct mutex			*blocked_on;	/* lock we're blocked on */
> +	raw_spinlock_t			blocked_lock;
>  
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>  	int				non_block_count;
> @@ -2118,6 +2124,56 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
>  	__cond_resched_rwlock_write(lock);					\
>  })
>  
> +static inline void __set_blocked_on_runnable(struct task_struct *p)
> +{
> +	lockdep_assert_held(&p->blocked_lock);
> +
> +	if (p->blocked_on_state == BO_WAKING)
> +		p->blocked_on_state = BO_RUNNABLE;
> +}
> +
> +static inline void set_blocked_on_runnable(struct task_struct *p)
> +{
> +	unsigned long flags;
> +
> +	if (!sched_proxy_exec())
> +		return;
> +
> +	raw_spin_lock_irqsave(&p->blocked_lock, flags);

Do we want to make this:

	guard(raw_spinlock_irqsave)(&p->blocked_lock);

?

> +	__set_blocked_on_runnable(p);
> +	raw_spin_unlock_irqrestore(&p->blocked_lock, flags);
> +}
> +
> +static inline void set_blocked_on_waking(struct task_struct *p)

consistent naming would be __set_blocked_on_waking()

> +{
> +	lockdep_assert_held(&p->blocked_lock);
> +
> +	if (p->blocked_on_state == BO_BLOCKED)
> +		p->blocked_on_state = BO_WAKING;
> +}
> +
> +static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)

__set_task_blocked_on()

> +{
> +	lockdep_assert_held(&p->blocked_lock);
> +
> +	/*
> +	 * Check we are clearing values to NULL or setting NULL
> +	 * to values to ensure we don't overwrite existing mutex
> +	 * values or clear already cleared values
> +	 */
> +	WARN_ON((!m && !p->blocked_on) || (m && p->blocked_on));
> +
> +	p->blocked_on = m;
> +	p->blocked_on_state = m ? BO_BLOCKED : BO_RUNNABLE;
> +}
> +
> +static inline struct mutex *get_task_blocked_on(struct task_struct *p)

__get_task_blocked_on()

> +{
> +	lockdep_assert_held(&p->blocked_lock);
> +
> +	return p->blocked_on;
> +}

That gets us the __ prefix if the caller is assumed to have taken
blocked_lock.

>  static __always_inline bool need_resched(void)
>  {
>  	return unlikely(tif_need_resched());
> @@ -2157,8 +2213,6 @@ extern bool sched_task_on_rq(struct task_struct *p);
>  extern unsigned long get_wchan(struct task_struct *p);
>  extern struct task_struct *cpu_curr_snapshot(int cpu);
>  
> -#include <linux/spinlock.h>
> -
>  /*
>   * In order to reduce various lock holder preemption latencies provide an
>   * interface to see if a vCPU is currently running or not.
> diff --git a/init/init_task.c b/init/init_task.c
> index e557f622bd906..7e29d86153d9f 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -140,6 +140,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
>  	.journal_info	= NULL,
>  	INIT_CPU_TIMERS(init_task)
>  	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
> +	.blocked_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.blocked_lock),
>  	.timer_slack_ns = 50000, /* 50 usec default slack */
>  	.thread_pid	= &init_struct_pid,
>  	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f253e81d0c28e..160bead843afb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2231,6 +2231,7 @@ __latent_entropy struct task_struct *copy_process(
>  	ftrace_graph_init_task(p);
>  
>  	rt_mutex_init_task(p);
> +	raw_spin_lock_init(&p->blocked_lock);
>  
>  	lockdep_assert_irqs_enabled();
>  #ifdef CONFIG_PROVE_LOCKING
> @@ -2329,9 +2330,8 @@ __latent_entropy struct task_struct *copy_process(
>  	lockdep_init_task(p);
>  #endif
>  
> -#ifdef CONFIG_DEBUG_MUTEXES
> +	p->blocked_on_state = BO_RUNNABLE;
>  	p->blocked_on = NULL; /* not blocked yet */
> -#endif
>  #ifdef CONFIG_BCACHE
>  	p->sequential_io	= 0;
>  	p->sequential_io_avg	= 0;
> diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
> index 6e6f6071cfa27..1d8cff71f65e1 100644
> --- a/kernel/locking/mutex-debug.c
> +++ b/kernel/locking/mutex-debug.c
> @@ -53,17 +53,18 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>  {
>  	lockdep_assert_held(&lock->wait_lock);
>  
> -	/* Mark the current thread as blocked on the lock: */
> -	task->blocked_on = waiter;
> +	/* Current thread can't be already blocked (since it's executing!) */
> +	DEBUG_LOCKS_WARN_ON(get_task_blocked_on(task));
>  }
>  
>  void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>  			 struct task_struct *task)
>  {
> +	struct mutex *blocked_on = get_task_blocked_on(task);
> +
>  	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
>  	DEBUG_LOCKS_WARN_ON(waiter->task != task);
> -	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
> -	task->blocked_on = NULL;
> +	DEBUG_LOCKS_WARN_ON(blocked_on && blocked_on != lock);
>  
>  	INIT_LIST_HEAD(&waiter->list);
>  	waiter->task = NULL;
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 3302e52f0c967..8f5d3fe6c1029 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -597,6 +597,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  	}
>  
>  	raw_spin_lock_irqsave(&lock->wait_lock, flags);
> +	raw_spin_lock(&current->blocked_lock);
>  	/*
>  	 * After waiting to acquire the wait_lock, try again.
>  	 */
> @@ -627,6 +628,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  			goto err_early_kill;
>  	}
>  
> +	set_task_blocked_on(current, lock);
>  	set_current_state(state);

blocked_on_state mirrors task-state

>  	trace_contention_begin(lock, LCB_F_MUTEX);
>  	for (;;) {
> @@ -639,7 +641,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  		 * the handoff.
>  		 */
>  		if (__mutex_trylock(lock))
> -			goto acquired;
> +			break; /* acquired */;
>  
>  		/*
>  		 * Check for signals and kill conditions while holding
> @@ -657,6 +659,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  				goto err;
>  		}
>  
> +		raw_spin_unlock(&current->blocked_lock);
>  		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>  		/* Make sure we do wakeups before calling schedule */
>  		wake_up_q(&wake_q);
> @@ -666,6 +669,13 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  
>  		first = __mutex_waiter_is_first(lock, &waiter);
>  
> +		raw_spin_lock_irqsave(&lock->wait_lock, flags);
> +		raw_spin_lock(&current->blocked_lock);
> +
> +		/*
> +		 * Re-set blocked_on_state as unlock path set it to WAKING/RUNNABLE
> +		 */
> +		current->blocked_on_state = BO_BLOCKED;
>  		set_current_state(state);

And blocked_on_state again mirrors taks-state

>  		/*
>  		 * Here we order against unlock; we must either see it change
> @@ -676,16 +686,26 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  			break;
>  
>  		if (first) {
> +			bool opt_acquired;
> +
> +			/*
> +			 * mutex_optimistic_spin() can schedule, so  we need to
> +			 * release these locks before calling it.
> +			 */
> +			current->blocked_on_state = BO_RUNNABLE;
> +			raw_spin_unlock(&current->blocked_lock);
> +			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>  			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
> -			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
> +			opt_acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);

I'm confused -- didn't I kill optimistic spinning for proxy? IIRC it
fundamentally doesn't make sense since we do a hand-off to the donor
thread.

> +			raw_spin_lock_irqsave(&lock->wait_lock, flags);
> +			raw_spin_lock(&current->blocked_lock);
> +			current->blocked_on_state = BO_BLOCKED;
> +			if (opt_acquired)
>  				break;
>  			trace_contention_begin(lock, LCB_F_MUTEX);
>  		}
> -
> -		raw_spin_lock_irqsave(&lock->wait_lock, flags);
>  	}
> -	raw_spin_lock_irqsave(&lock->wait_lock, flags);
> -acquired:
> +	set_task_blocked_on(current, NULL);
>  	__set_current_state(TASK_RUNNING);

And again..

>  
>  	if (ww_ctx) {
> @@ -710,16 +730,20 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  	if (ww_ctx)
>  		ww_mutex_lock_acquired(ww, ww_ctx);
>  
> +	raw_spin_unlock(&current->blocked_lock);
>  	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>  	wake_up_q(&wake_q);
>  	preempt_enable();
>  	return 0;
>  
>  err:
> +	set_task_blocked_on(current, NULL);
>  	__set_current_state(TASK_RUNNING);

and one again..

>  	__mutex_remove_waiter(lock, &waiter);
>  err_early_kill:
> +	WARN_ON(get_task_blocked_on(current));
>  	trace_contention_end(lock, ret);
> +	raw_spin_unlock(&current->blocked_lock);
>  	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>  	debug_mutex_free_waiter(&waiter);
>  	mutex_release(&lock->dep_map, ip);
> @@ -928,8 +952,12 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>  
>  		next = waiter->task;
>  
> +		raw_spin_lock(&next->blocked_lock);
>  		debug_mutex_wake_waiter(lock, waiter);
> +		WARN_ON(get_task_blocked_on(next) != lock);
> +		set_blocked_on_waking(next);

and more..

>  		wake_q_add(&wake_q, next);
> +		raw_spin_unlock(&next->blocked_lock);
>  	}
>  
>  	if (owner & MUTEX_FLAG_HANDOFF)
> diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
> index 37f025a096c9d..d9ff2022eef6f 100644
> --- a/kernel/locking/ww_mutex.h
> +++ b/kernel/locking/ww_mutex.h
> @@ -281,10 +281,21 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
>  		return false;
>  
>  	if (waiter->ww_ctx->acquired > 0 && __ww_ctx_less(waiter->ww_ctx, ww_ctx)) {
> +		/* nested as we should hold current->blocked_lock already */
> +		raw_spin_lock_nested(&waiter->task->blocked_lock, SINGLE_DEPTH_NESTING);
>  #ifndef WW_RT
>  		debug_mutex_wake_waiter(lock, waiter);
> +		/*
> +		 * When waking up the task to die, be sure to set the
> +		 * blocked_on_state to WAKING. Otherwise we can see
> +		 * circular blocked_on relationships that can't
> +		 * resolve.
> +		 */
> +		WARN_ON(get_task_blocked_on(waiter->task) != lock);
>  #endif
> +		set_blocked_on_waking(waiter->task);
>  		wake_q_add(wake_q, waiter->task);
> +		raw_spin_unlock(&waiter->task->blocked_lock);
>  	}
>  
>  	return true;
> @@ -331,9 +342,18 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
>  		 * it's wounded in __ww_mutex_check_kill() or has a
>  		 * wakeup pending to re-read the wounded state.
>  		 */
> -		if (owner != current)
> +		if (owner != current) {
> +			/* nested as we should hold current->blocked_lock already */
> +			raw_spin_lock_nested(&owner->blocked_lock, SINGLE_DEPTH_NESTING);
> +			/*
> +			 * When waking up the task to wound, be sure to set the
> +			 * blocked_on_state flag. Otherwise we can see circular
> +			 * blocked_on relationships that can't resolve.
> +			 */
> +			set_blocked_on_waking(owner);
>  			wake_q_add(wake_q, owner);
> -
> +			raw_spin_unlock(&owner->blocked_lock);
> +		}
>  		return true;
>  	}
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d712e177d3b75..f8714050b6d0d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4350,6 +4350,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  		ttwu_queue(p, cpu, wake_flags);
>  	}
>  out:
> +	set_blocked_on_runnable(p);
>  	if (success)
>  		ttwu_stat(p, task_cpu(p), wake_flags);
>  

All in all I'm properly confused by this patch... please write
more/better comments changelog.

