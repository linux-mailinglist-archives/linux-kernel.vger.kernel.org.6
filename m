Return-Path: <linux-kernel+bounces-445760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586199F1B3B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EFB188E299
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37199BE49;
	Sat, 14 Dec 2024 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MHxoIQO6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7ED3C14
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734134770; cv=none; b=Nvxc/byiadr2/GYtlqSGPHr3rPWxzqpJKYPTat6bKysy6o+YV1ZIvN4mhvc/rgeML7WgJDwc+dWdVUK/KT9hvL8CWziYjIAH1/vZVsypHKhx7bV252wauNXtispKNSqG4tavdnwXQOh65kndUPBiEolcTYVRkFRQyQs/ZPcoVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734134770; c=relaxed/simple;
	bh=pk9b7aQjULDMsfhCdbV7APXJ9Vk01GgEXcJP7pCPinA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOH+SdMOBWtkN18vYrTKu8uwfJY/i2HBZM/QnTgI9xBvilPYZjFzmk/YLohYMjdYxiTHq3qMS4n8lBJCv80hXryNFdN/cIXB2cEOUV4YgSe5lqLVhsaL8moRs0ESdlmLcck8MIUTFwxuTdTjhV64Ud6lwQnmzINHFp8OR9MPpuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MHxoIQO6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M/oCU0QXpHv5wBTl4rjJLN6MhY5SgrkcuVkrhZ30vWo=; b=MHxoIQO60BVUQzhQzCqX6cS24Q
	gZLsDe50RESXLkOlPBD0joVURo9tgEDaPKCoFBgkCvHBBlKNQBYhXiCXpyvgUC77GdCHbdcYmfemX
	4DmgQ5BwJsXGvR6gAHJW23iNUbCQw4Xy/ypjPgVv9lHiRREdrnEtCML3HYdAvtckaxZs/uU842V6c
	BRj9qFsX/8sBAzmlRiPSbxQSZxIuyZxH4QDenWhPVCtQ5E4Az2V4aQie6MMDvwPRpTVxUALP9oYXV
	j3aU1Rai33vhjKtA1Ctfx8+Lxqpp86LOwNjYSxMbIWtS84CVGvHD0r9+ssdGsAN6gI/SJPK28lFIK
	zmTIVu3Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMFfU-0000000Gf4s-3pPj;
	Sat, 14 Dec 2024 00:06:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D2DC30049D; Sat, 14 Dec 2024 01:06:00 +0100 (CET)
Date: Sat, 14 Dec 2024 01:05:59 +0100
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
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Subject: Re: [RFC][PATCH v14 5/7] sched: Add an initial sketch of the
 find_proxy_task() function
Message-ID: <20241214000559.GC17501@noisy.programming.kicks-ass.net>
References: <20241125195204.2374458-1-jstultz@google.com>
 <20241125195204.2374458-6-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125195204.2374458-6-jstultz@google.com>

On Mon, Nov 25, 2024 at 11:51:59AM -0800, John Stultz wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f8714050b6d0d..b492506d33415 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5052,6 +5052,34 @@ static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
>  	}
>  }
>  
> +/*
> + * Only called from __schedule context
> + *
> + * There are some cases where we are going to re-do the action
> + * that added the balance callbacks. We may not be in a state
> + * where we can run them, so just zap them so they can be
> + * properly re-added on the next time around. This is similar
> + * handling to running the callbacks, except we just don't call
> + * them.
> + */

Which specific callbacks are this? sched_core_balance()?

In general, shooting down all callbacks like this makes me feel somewhat
uncomfortable.

> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +
> +static inline struct task_struct *
> +proxy_resched_idle(struct rq *rq)
> +{
> +	put_prev_task(rq, rq->donor);
> +	rq_set_donor(rq, rq->idle);
> +	set_next_task(rq, rq->idle);
> +	set_tsk_need_resched(rq->idle);
> +	return rq->idle;
> +}
> +
> +static bool proxy_deactivate(struct rq *rq, struct task_struct *donor)
> +{
> +	unsigned long state = READ_ONCE(donor->__state);
> +
> +	/* Don't deactivate if the state has been changed to TASK_RUNNING */
> +	if (state == TASK_RUNNING)
> +		return false;
> +	/*
> +	 * Because we got donor from pick_next_task, it is *crucial*
> +	 * that we call proxy_resched_idle before we deactivate it.
> +	 * As once we deactivate donor, donor->on_rq is set to zero,
> +	 * which allows ttwu to immediately try to wake the task on
> +	 * another rq. So we cannot use *any* references to donor
> +	 * after that point. So things like cfs_rq->curr or rq->donor
> +	 * need to be changed from next *before* we deactivate.
> +	 */
> +	proxy_resched_idle(rq);
> +	return try_to_block_task(rq, donor, state, true);
> +}
> +
> +/*
> + * Initial simple proxy that just returns the task if it's waking
> + * or deactivates the blocked task so we can pick something that
> + * isn't blocked.
> + */
> +static struct task_struct *
> +find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
> +{
> +	struct task_struct *p = donor;
> +	struct mutex *mutex;
> +
> +	mutex = p->blocked_on;
> +	/* Something changed in the chain, so pick again */
> +	if (!mutex)
> +		return NULL;
> +	/*
> +	 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
> +	 * and ensure @owner sticks around.
> +	 */
> +	raw_spin_lock(&mutex->wait_lock);
> +	raw_spin_lock(&p->blocked_lock);

I'm still wondering what this blocked_lock does, that previous patch had
it mirror wait_mutex too, so far I don't see the point.

> +
> +	/* Check again that p is blocked with blocked_lock held */
> +	if (!task_is_blocked(p) || mutex != get_task_blocked_on(p)) {
> +		/*
> +		 * Something changed in the blocked_on chain and
> +		 * we don't know if only at this level. So, let's
> +		 * just bail out completely and let __schedule
> +		 * figure things out (pick_again loop).
> +		 */
> +		goto out;
> +	}
> +	if (!proxy_deactivate(rq, donor))
> +		/* XXX: This hack won't work when we get to migrations */
> +		donor->blocked_on_state = BO_RUNNABLE;
> +
> +out:
> +	raw_spin_unlock(&p->blocked_lock);
> +	raw_spin_unlock(&mutex->wait_lock);
> +	return NULL;
> +}
> +#else /* SCHED_PROXY_EXEC */
> +static struct task_struct *
> +find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
> +{
> +	WARN_ONCE(1, "This should never be called in the !SCHED_PROXY_EXEC case\n");
> +	return donor;
> +}
> +#endif /* SCHED_PROXY_EXEC */
> +
>  /*
>   * __schedule() is the main scheduler function.
>   *
> @@ -6732,12 +6845,22 @@ static void __sched notrace __schedule(int sched_mode)
>  			goto picked;
>  		}
>  	} else if (!preempt && prev_state) {
> -		block = try_to_block_task(rq, prev, prev_state);
> +		block = try_to_block_task(rq, prev, prev_state,
> +					  !task_is_blocked(prev));
>  		switch_count = &prev->nvcsw;
>  	}
>  
> -	next = pick_next_task(rq, prev, &rf);
> +pick_again:
> +	next = pick_next_task(rq, rq->donor, &rf);
>  	rq_set_donor(rq, next);
> +	if (unlikely(task_is_blocked(next))) {
> +		next = find_proxy_task(rq, next, &rf);
> +		if (!next) {
> +			/* zap the balance_callbacks before picking again */
> +			zap_balance_callbacks(rq);
> +			goto pick_again;
> +		}
> +	}
>  picked:
>  	clear_tsk_need_resched(prev);
>  	clear_preempt_need_resched();

