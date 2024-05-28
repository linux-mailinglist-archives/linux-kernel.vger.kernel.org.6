Return-Path: <linux-kernel+bounces-192725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69FB8D214D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F991C23256
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2D6173329;
	Tue, 28 May 2024 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rJ71QeKW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB917279B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912556; cv=none; b=Ftob8VYZTr+Td8vWVEgcSQFk7st48q3nvBUBigDMTin8VK77enCbz8zwMT56Jq6cI0xp39Si4hAREWMEb33BtbGl6w5qxvalxJDFWjrJIVlWTY0sYrb57ERxfPibUzvj+RsyJv9//X0W1l4kWtPufiRBOj9WzsFGBRXMSc+dGBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912556; c=relaxed/simple;
	bh=4tCWBrS3xzIkrC1eYcxYTjhHPFAZtsAmGJ3EYsPysO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCId775fAL2T9wR6m5qgQRt/kGX88exLIOUwysqeXRoLqJB+VaxSPgZWRZEVhbO5qQOLJsyxWlPouCiJ5HSR1MsspYKTbBxikFU2TPsupQgB/fyDodluw/xXdDR2jQYYXbualZ+Fhl2K76X9Tlboomr07LpMyL9n6+esMAS2w1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rJ71QeKW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lLWwxjgp78dkT02X8c5Q9W7rjOAJlZLbuuIgOktWhpc=; b=rJ71QeKWOgcl5wQeOU9dEkxZGE
	WWe8kz3vnJVFKHmyOa8gGHJvp03Ql1wrHqEzrXLyGWSSCsVrT+CV79sn9q6IOkNCvk2ZT1S4j/wo0
	mj59LmSMpbKvJx0hX9NSMHMHJWE5Z6ATzeRFxIWrhyX3fCgNyYjfF3ZcoU2VesNqNy54GHOzupP7C
	t4AwnygXK6BrhECeYqpK/2Us3rgxD7r9KZSLgX5Cd2B2hZYgIOotQohJl4WbjMRiEb85TjqghChoQ
	WY6IMQc651dR4o97nJXe0Na5KZGh+UormvAaJSEYB90zJrbkjZE4jwU2cvNtYo8VZBGleyMSGFrSs
	UQsOoPSw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzNq-00000008o4V-1EFG;
	Tue, 28 May 2024 16:09:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DFB5430058E; Tue, 28 May 2024 18:09:05 +0200 (CEST)
Date: Tue, 28 May 2024 18:09:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 07/35] sched: define *_tsk_need_resched_lazy() helpers
Message-ID: <20240528160905.GC26599@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-8-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528003521.979836-8-ankur.a.arora@oracle.com>

On Mon, May 27, 2024 at 05:34:53PM -0700, Ankur Arora wrote:
> Define __{set,test}_tsk_need_resched() to test for the immediacy of the
> need-resched.
> 
> The current helpers, {set,test}_tsk_need_resched(...) stay the same.
> 
> In scheduler code, switch to the more explicit variants,
> __set_tsk_need_resched(...), __test_tsk_need_resched(...).
> 
> Note that clear_tsk_need_resched() is only used from __schedule()
> to clear the flags before switching context. Now it clears all the
> need-resched flags.
> 
> Cc: Peter Ziljstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  include/linux/sched.h   | 45 +++++++++++++++++++++++++++++++++++++----
>  kernel/sched/core.c     |  9 +++++----
>  kernel/sched/deadline.c |  4 ++--
>  kernel/sched/fair.c     |  2 +-
>  kernel/sched/rt.c       |  4 ++--
>  5 files changed, 51 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 37a51115b691..804a76e6f3c5 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1952,19 +1952,56 @@ static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
>  	return test_ti_thread_flag(task_thread_info(tsk), flag);
>  }
>  
> -static inline void set_tsk_need_resched(struct task_struct *tsk)
> +/*
> + * With !CONFIG_PREEMPT_AUTO, tif_resched(RESCHED_LAZY) reduces to
> + * tif_resched(RESCHED_NOW). Add a check in the helpers below to ensure
> + * we don't touch the tif_reshed(RESCHED_NOW) bit unnecessarily.
> + */
> +static inline void __set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>  {
> -	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == RESCHED_NOW)
> +		set_tsk_thread_flag(tsk, tif_resched(rs));
> +	else
> +		/*
> +		 * RESCHED_LAZY is only touched under CONFIG_PREEMPT_AUTO.
> +		 */
> +		BUG();
>  }

This straight up violates coding style and would require a dose of {}.

	if (!IS_ENABLED(CONFIG_PREEMPT_AUTO && rs == RESCHED_LAZY)
		BUG();

	set_tsk_thread_flag(tsk, tif_resched(rs));

seems much saner to me.

>  static inline void clear_tsk_need_resched(struct task_struct *tsk)
>  {
> -	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
> +	clear_tsk_thread_flag(tsk, tif_resched(RESCHED_NOW));
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
> +		clear_tsk_thread_flag(tsk, tif_resched(RESCHED_LAZY));
> +}
> +
> +static inline bool __test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == RESCHED_NOW)
> +		return unlikely(test_tsk_thread_flag(tsk, tif_resched(rs)));
> +	else
> +		return false;
>  }

	if (!IS_ENABLED(CONFIG_PREEMPT_AUTO) && rs == RESCHED_LAZY)
		return false;

	return unlikely(test_tsk_thread_flag(tsk, tif_resched(rs)));

>  
>  static inline bool test_tsk_need_resched(struct task_struct *tsk)
>  {
> -	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
> +	return __test_tsk_need_resched(tsk, RESCHED_NOW);
> +}
> +
> +static inline bool test_tsk_need_resched_lazy(struct task_struct *tsk)
> +{
> +	return __test_tsk_need_resched(tsk, RESCHED_LAZY);
> +}
> +
> +static inline void set_tsk_need_resched(struct task_struct *tsk)
> +{
> +	return __set_tsk_need_resched(tsk, RESCHED_NOW);
> +}
> +
> +static inline void set_tsk_need_resched_lazy(struct task_struct *tsk)
> +{
> +	return __set_tsk_need_resched(tsk, RESCHED_LAZY);
>  }
>  
>  /*

So far so good, however:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7019a40457a6..d00d7b45303e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -933,7 +933,7 @@ static bool set_nr_if_polling(struct task_struct *p)
>  #else
>  static inline bool set_nr_and_not_polling(struct task_struct *p)
>  {
> -	set_tsk_need_resched(p);
> +	__set_tsk_need_resched(p, RESCHED_NOW);
>  	return true;
>  }
>  
> @@ -1045,13 +1045,13 @@ void resched_curr(struct rq *rq)
>  
>  	lockdep_assert_rq_held(rq);
>  
> -	if (test_tsk_need_resched(curr))
> +	if (__test_tsk_need_resched(curr, RESCHED_NOW))
>  		return;
>  
>  	cpu = cpu_of(rq);
>  
>  	if (cpu == smp_processor_id()) {
> -		set_tsk_need_resched(curr);
> +		__set_tsk_need_resched(curr, RESCHED_NOW);
>  		set_preempt_need_resched();
>  		return;
>  	}
> @@ -2245,7 +2245,8 @@ void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
>  	 * A queue event has occurred, and we're going to schedule.  In
>  	 * this case, we can save a useless back to back clock update.
>  	 */
> -	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
> +	if (task_on_rq_queued(rq->curr) &&
> +	    __test_tsk_need_resched(rq->curr, RESCHED_NOW))
>  		rq_clock_skip_update(rq);
>  }
>  
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index a04a436af8cc..d24d6bfee293 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2035,7 +2035,7 @@ static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
>  	 * let us try to decide what's the best thing to do...
>  	 */
>  	if ((p->dl.deadline == rq->curr->dl.deadline) &&
> -	    !test_tsk_need_resched(rq->curr))
> +	    !__test_tsk_need_resched(rq->curr, RESCHED_NOW))
>  		check_preempt_equal_dl(rq, p);
>  #endif /* CONFIG_SMP */
>  }
> @@ -2564,7 +2564,7 @@ static void pull_dl_task(struct rq *this_rq)
>  static void task_woken_dl(struct rq *rq, struct task_struct *p)
>  {
>  	if (!task_on_cpu(rq, p) &&
> -	    !test_tsk_need_resched(rq->curr) &&
> +	    !__test_tsk_need_resched(rq->curr, RESCHED_NOW) &&
>  	    p->nr_cpus_allowed > 1 &&
>  	    dl_task(rq->curr) &&
>  	    (rq->curr->nr_cpus_allowed < 2 ||
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c62805dbd608..c5171c247466 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8316,7 +8316,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	 * prevents us from potentially nominating it as a false LAST_BUDDY
>  	 * below.
>  	 */
> -	if (test_tsk_need_resched(curr))
> +	if (__test_tsk_need_resched(curr, RESCHED_NOW))
>  		return;
>  
>  	/* Idle tasks are by definition preempted by non-idle tasks. */
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 3261b067b67e..f0a6c9bb890b 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1680,7 +1680,7 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
>  	 * to move current somewhere else, making room for our non-migratable
>  	 * task.
>  	 */
> -	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
> +	if (p->prio == rq->curr->prio && !__test_tsk_need_resched(rq->curr, RESCHED_NOW))
>  		check_preempt_equal_prio(rq, p);
>  #endif
>  }
> @@ -2415,7 +2415,7 @@ static void pull_rt_task(struct rq *this_rq)
>  static void task_woken_rt(struct rq *rq, struct task_struct *p)
>  {
>  	bool need_to_push = !task_on_cpu(rq, p) &&
> -			    !test_tsk_need_resched(rq->curr) &&
> +			    !__test_tsk_need_resched(rq->curr, RESCHED_NOW) &&
>  			    p->nr_cpus_allowed > 1 &&
>  			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
>  			    (rq->curr->nr_cpus_allowed < 2 ||

These are all NO-OPs.... Changelog says:
 
> In scheduler code, switch to the more explicit variants,
> __set_tsk_need_resched(...), __test_tsk_need_resched(...).

But leaves me wondering *WHY* ?!?

I can't help but feel this patch attempts to do 2 things and fails to
justify at least one of them.

