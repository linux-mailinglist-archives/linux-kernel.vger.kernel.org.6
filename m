Return-Path: <linux-kernel+bounces-559172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9EEA5F05F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF39E3BC5E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C44264A7B;
	Thu, 13 Mar 2025 10:14:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDBC1EE028
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860840; cv=none; b=UXdWVocQiGKhPNKOiDPZ1HSJYm33CTjz8LZl6GEbZ+JYsw5kf7YhnE+y8+Nq4YokR+MEKaY31f0BOMk4Mo1AV2BROdNO+t/7MYjy84NjSNR/KbKqY+qmhwbgSzGN4R4x24t53EGxzPoF0EcE1P/qsG4wnXbo9jycpOGuOnK5LNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860840; c=relaxed/simple;
	bh=QAvY60nFRsvo+brbaJsOsW6FJe4W2Iosodam+1HiqMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aEm+YMV0RitKD811KqzvjwwYO6XqLHDgpPEpqIb5EehfjRe9TmzulFNqdEUf2Kz2xPMKp02qK3JQbaWEIkZGKTbLlS3UOxXgaoSOuirA4s01Flkvi3d6Z5an9lB4eMuuIX5geUeHOnnLZXz1rmK9AQTqNyC9q3uT4qFVGqITJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E369C4CEDD;
	Thu, 13 Mar 2025 10:13:54 +0000 (UTC)
Date: Thu, 13 Mar 2025 06:13:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef
 <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
 <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Zimuzo Ezeozue
 <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya
 <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal
 <suleiman@google.com>, kernel-team@android.com, "Connor O'Brien"
 <connoro@google.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH v15 2/7] locking/mutex: Rework
 task_struct::blocked_on
Message-ID: <20250313061351.412bc92e@batman.local.home>
In-Reply-To: <20250312221147.1865364-3-jstultz@google.com>
References: <20250312221147.1865364-1-jstultz@google.com>
	<20250312221147.1865364-3-jstultz@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


FYI, this is useful for Masami's "hung task" work that will show what
tasks a hung task is blocked on in a crash report.

  https://lore.kernel.org/all/174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com/

-- Steve


On Wed, 12 Mar 2025 15:11:32 -0700
John Stultz <jstultz@google.com> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Track the blocked-on relation for mutexes, to allow following this
> relation at schedule time.
> 
>    task
>      | blocked-on
>      v
>    mutex
>      | owner
>      v
>    task
> 
> This all will be used for tracking blocked-task/mutex chains
> with the prox-execution patch in a similar fashion to how
> priority inheritance is done with rt_mutexes.
> 
> For serialization, blocked-on is only set by the task itself
> (current). And both when setting or clearing (potentially by
> others), is done while holding the mutex::wait_lock.
> 
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: kernel-team@android.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [minor changes while rebasing]
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Connor O'Brien <connoro@google.com>
> [jstultz: Fix blocked_on tracking in __mutex_lock_common in error paths]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v2:
> * Fixed blocked_on tracking in error paths that was causing crashes
> v4:
> * Ensure we clear blocked_on when waking ww_mutexes to die or wound.
>   This is critical so we don't get circular blocked_on relationships
>   that can't be resolved.
> v5:
> * Fix potential bug where the skip_wait path might clear blocked_on
>   when that path never set it
> * Slight tweaks to where we set blocked_on to make it consistent,
>   along with extra WARN_ON correctness checking
> * Minor comment changes
> v7:
> * Minor commit message change suggested by Metin Kaya
> * Fix WARN_ON conditionals in unlock path (as blocked_on might already
>   be cleared), found while looking at issue Metin Kaya raised.
> * Minor tweaks to be consistent in what we do under the
>   blocked_on lock, also tweaked variable name to avoid confusion
>   with label, and comment typos, as suggested by Metin Kaya
> * Minor tweak for CONFIG_SCHED_PROXY_EXEC name change
> * Moved unused block of code to later in the series, as suggested
>   by Metin Kaya
> * Switch to a tri-state to be able to distinguish from waking and
>   runnable so we can later safely do return migration from ttwu
> * Folded together with related blocked_on changes
> v8:
> * Fix issue leaving task BO_BLOCKED when calling into optimistic
>   spinning path.
> * Include helper to better handle BO_BLOCKED->BO_WAKING transitions
> v9:
> * Typo fixup pointed out by Metin
> * Cleanup BO_WAKING->BO_RUNNABLE transitions for the !proxy case
> * Many cleanups and simplifications suggested by Metin
> v11:
> * Whitespace fixup pointed out by Metin
> v13:
> * Refactor set_blocked_on helpers clean things up a bit
> v14:
> * Small build fixup with PREEMPT_RT
> v15:
> * Improve consistency of names for functions that assume blocked_lock
>   is held, as suggested by Peter
> * Use guard instead of separate spinlock/unlock calls, also suggested
>   by Peter
> * Drop blocked_on_state tri-state for now, as its not needed until
>   later in the series, when we get to proxy-migration and return-
>   migration.
> ---
>  include/linux/sched.h        |  5 +----
>  kernel/fork.c                |  3 +--
>  kernel/locking/mutex-debug.c |  9 +++++----
>  kernel/locking/mutex.c       | 19 +++++++++++++++++++
>  kernel/locking/ww_mutex.h    | 18 ++++++++++++++++--
>  5 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1462f2c70aefc..03775c44b7073 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1212,10 +1212,7 @@ struct task_struct {
>  	struct rt_mutex_waiter		*pi_blocked_on;
>  #endif
>  
> -#ifdef CONFIG_DEBUG_MUTEXES
> -	/* Mutex deadlock detection: */
> -	struct mutex_waiter		*blocked_on;
> -#endif
> +	struct mutex			*blocked_on;	/* lock we're blocked on */
>  
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>  	int				non_block_count;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 735405a9c5f32..38f055082d07a 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2357,9 +2357,8 @@ __latent_entropy struct task_struct *copy_process(
>  	lockdep_init_task(p);
>  #endif
>  
> -#ifdef CONFIG_DEBUG_MUTEXES
>  	p->blocked_on = NULL; /* not blocked yet */
> -#endif
> +
>  #ifdef CONFIG_BCACHE
>  	p->sequential_io	= 0;
>  	p->sequential_io_avg	= 0;
> diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
> index 6e6f6071cfa27..758b7a6792b0c 100644
> --- a/kernel/locking/mutex-debug.c
> +++ b/kernel/locking/mutex-debug.c
> @@ -53,17 +53,18 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>  {
>  	lockdep_assert_held(&lock->wait_lock);
>  
> -	/* Mark the current thread as blocked on the lock: */
> -	task->blocked_on = waiter;
> +	/* Current thread can't be already blocked (since it's executing!) */
> +	DEBUG_LOCKS_WARN_ON(task->blocked_on);
>  }
>  
>  void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>  			 struct task_struct *task)
>  {
> +	struct mutex *blocked_on = READ_ONCE(task->blocked_on);
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
> index b36f23de48f1b..37d1966970617 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -627,6 +627,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  			goto err_early_kill;
>  	}
>  
> +	WARN_ON(current->blocked_on);
> +	current->blocked_on = lock;
>  	set_current_state(state);
>  	trace_contention_begin(lock, LCB_F_MUTEX);
>  	for (;;) {
> @@ -663,6 +665,12 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  
>  		first = __mutex_waiter_is_first(lock, &waiter);
>  
> +		/*
> +		 * As we likely have been woken up by task
> +		 * that has cleared our blocked_on state, re-set
> +		 * it to the lock we are trying to aquire.
> +		 */
> +		current->blocked_on = lock;
>  		set_current_state(state);
>  		/*
>  		 * Here we order against unlock; we must either see it change
> @@ -683,6 +691,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  	}
>  	raw_spin_lock_irqsave(&lock->wait_lock, flags);
>  acquired:
> +	current->blocked_on = NULL;
>  	__set_current_state(TASK_RUNNING);
>  
>  	if (ww_ctx) {
> @@ -712,9 +721,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  	return 0;
>  
>  err:
> +	current->blocked_on = NULL;
>  	__set_current_state(TASK_RUNNING);
>  	__mutex_remove_waiter(lock, &waiter);
>  err_early_kill:
> +	WARN_ON(current->blocked_on);
>  	trace_contention_end(lock, ret);
>  	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
>  	debug_mutex_free_waiter(&waiter);
> @@ -924,6 +935,14 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>  		next = waiter->task;
>  
>  		debug_mutex_wake_waiter(lock, waiter);
> +		/*
> +		 * Unlock wakeups can be happening in parallel
> +		 * (when optimistic spinners steal and release
> +		 * the lock), so blocked_on may already be
> +		 * cleared here.
> +		 */
> +		WARN_ON(next->blocked_on && next->blocked_on != lock);
> +		next->blocked_on = NULL;
>  		wake_q_add(&wake_q, next);
>  	}
>  
> diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
> index 37f025a096c9d..00db40946328e 100644
> --- a/kernel/locking/ww_mutex.h
> +++ b/kernel/locking/ww_mutex.h
> @@ -284,6 +284,14 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
>  #ifndef WW_RT
>  		debug_mutex_wake_waiter(lock, waiter);
>  #endif
> +		/*
> +		 * When waking up the task to die, be sure to clear the
> +		 * blocked_on pointer. Otherwise we can see circular
> +		 * blocked_on relationships that can't resolve.
> +		 */
> +		WARN_ON(waiter->task->blocked_on &&
> +			waiter->task->blocked_on != lock);
> +		waiter->task->blocked_on = NULL;
>  		wake_q_add(wake_q, waiter->task);
>  	}
>  
> @@ -331,9 +339,15 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
>  		 * it's wounded in __ww_mutex_check_kill() or has a
>  		 * wakeup pending to re-read the wounded state.
>  		 */
> -		if (owner != current)
> +		if (owner != current) {
> +			/*
> +			 * When waking up the task to wound, be sure to clear the
> +			 * blocked_on pointer. Otherwise we can see circular
> +			 * blocked_on relationships that can't resolve.
> +			 */
> +			owner->blocked_on = NULL;
>  			wake_q_add(wake_q, owner);
> -
> +		}
>  		return true;
>  	}
>  


