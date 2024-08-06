Return-Path: <linux-kernel+bounces-276904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3C59499E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FAB1F2259A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4DD15F3F8;
	Tue,  6 Aug 2024 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dxMg23sK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0367F1EB2A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722978609; cv=none; b=X97GpPjikYekxUTXH6dow+qtcif0/yTpsM9j4XgVAvCd/QtTAc+VhNK4KBjonS8sJXOsWhaHXHZKxEAw/arWTOVVD6XcRU5rqUn24byeiCojRRPh8COrSxCGyUdTGIyIu40gs4EGuShkkrN/tH+yS+UVjMJ2EiWqRw7926FUudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722978609; c=relaxed/simple;
	bh=kKru8HxH5Ekpv0FzB4LE7ujsjFpwmXgI0M7T2lCWaj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXGwt59KOhQj+zlTQZ/k8JD0lye0XX4vNkH97GlabTXVvQKQKT729ZPzb2L3V0dI3tNzWsZpOl9cAsI+0dhWJgzbswZjgouwuy+2yzke6pt+wyiP4AFXgBbO2tCs5KlKTCPT1RhuiSL1KkYlWvvluC2NLdlUbpTt2kpt/XrUYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dxMg23sK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vU6UU4v54ZKNI87YtWtUngD0BKx3YAvGYJgw0QK6TeM=; b=dxMg23sKC0rD/BxpC4cxsojtkR
	mbRkjZuYUXHmPW+4wq7ZnWJFHDcXMAtgvaUfFf0X+M9XLCo4WWknZrYEm494UaT1S6i4FOCxur4ox
	sSTPMVVE/m4GXEtft+LYSLEQeqyNP1XbCMo9Drft5kYsPcUY39p8+R5WB/wxHN71NjMlEyjsirXXB
	bBoGHrRsqNQ2KrGOts1PXZeVeqoFQ7heQLAFibEEm+bs5u3srxdsu+bCSrU0tDWWfPbQHaa9LPJoB
	QqUABtXHd87KAspWC1ytG6+3kmDf6fCWhuT+ag/KvhM+2nGTbF+zuv/sLcs9gEPg/nYq2o459UcVW
	JHugatxQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbRRT-00000006H1O-0vez;
	Tue, 06 Aug 2024 21:10:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A256130066A; Tue,  6 Aug 2024 23:10:02 +0200 (CEST)
Date: Tue, 6 Aug 2024 23:10:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240806211002.GA37996@noisy.programming.kicks-ass.net>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
 <ZqmVG9ZiktN6bnm0@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqmVG9ZiktN6bnm0@slm.duckdns.org>

On Tue, Jul 30, 2024 at 03:36:27PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jul 24, 2024 at 10:52:21AM +0200, Peter Zijlstra wrote:
> ...
> > So pick_task() came from the SCHED_CORE crud, which does a remote pick
> > and as such isn't able to do a put -- remote is still running its
> > current etc.
> > 
> > So pick_task() *SHOULD* already be considering its current and pick
> > that if it is a better candidate than whatever is on the queue.
> > 
> > If we have a pick_task() that doesn't do that, it's a pre-existing bug
> > and needs fixing anyhow.
> 
> Right, I don't think it affects SCX in any significant way. Either way
> should be fine.

So I just looked at things. And considering we currently want to have:

  pick_next_task := pick_task() + set_next_task(.first = true)

and want to, with those other patches moving put_prev_task() around, get
to fully making pick_next_task() optional, it looks to me you're not
quite there yet. Notably:

> +static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
> +{
> +	if (p->scx.flags & SCX_TASK_QUEUED) {
> +		/*
> +		 * Core-sched might decide to execute @p before it is
> +		 * dispatched. Call ops_dequeue() to notify the BPF scheduler.
> +		 */
> +		ops_dequeue(p, SCX_DEQ_CORE_SCHED_EXEC);
> +		dispatch_dequeue(rq, p);
> +	}
> +
> +	p->se.exec_start = rq_clock_task(rq);
> +
> +	/* see dequeue_task_scx() on why we skip when !QUEUED */
> +	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
> +		SCX_CALL_OP_TASK(SCX_KF_REST, running, p);
> +
> +	clr_task_runnable(p, true);
> +
> +	/*
> +	 * @p is getting newly scheduled or got kicked after someone updated its
> +	 * slice. Refresh whether tick can be stopped. See scx_can_stop_tick().
> +	 */
> +	if ((p->scx.slice == SCX_SLICE_INF) !=
> +	    (bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
> +		if (p->scx.slice == SCX_SLICE_INF)
> +			rq->scx.flags |= SCX_RQ_CAN_STOP_TICK;
> +		else
> +			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
> +
> +		sched_update_tick_dependency(rq);
> +
> +		/*
> +		 * For now, let's refresh the load_avgs just when transitioning
> +		 * in and out of nohz. In the future, we might want to add a
> +		 * mechanism which calls the following periodically on
> +		 * tick-stopped CPUs.
> +		 */
> +		update_other_load_avgs(rq);
> +	}
> +}

> +static struct task_struct *pick_next_task_scx(struct rq *rq)
> +{
> +	struct task_struct *p;
> +
> +#ifndef CONFIG_SMP
> +	/* UP workaround - see the comment at the head of put_prev_task_scx() */
> +	if (unlikely(rq->curr->sched_class != &ext_sched_class))
> +		balance_one(rq, rq->curr, true);
> +#endif

(should already be gone in your latest branch)

> +
> +	p = first_local_task(rq);
> +	if (!p)
> +		return NULL;
> +
> +	set_next_task_scx(rq, p, true);
> +
> +	if (unlikely(!p->scx.slice)) {
> +		if (!scx_ops_bypassing() && !scx_warned_zero_slice) {
> +			printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
> +					p->comm, p->pid);
> +			scx_warned_zero_slice = true;
> +		}
> +		p->scx.slice = SCX_SLICE_DFL;
> +	}

This condition should probably move to set_next_task_scx(.first = true).

> +
> +	return p;
> +}

> +/**
> + * pick_task_scx - Pick a candidate task for core-sched
> + * @rq: rq to pick the candidate task from
> + *
> + * Core-sched calls this function on each SMT sibling to determine the next
> + * tasks to run on the SMT siblings. balance_one() has been called on all
> + * siblings and put_prev_task_scx() has been called only for the current CPU.
> + *
> + * As put_prev_task_scx() hasn't been called on remote CPUs, we can't just look
> + * at the first task in the local dsq. @rq->curr has to be considered explicitly
> + * to mimic %SCX_TASK_BAL_KEEP.
> + */
> +static struct task_struct *pick_task_scx(struct rq *rq)
> +{
> +	struct task_struct *curr = rq->curr;
> +	struct task_struct *first = first_local_task(rq);
> +
> +	if (curr->scx.flags & SCX_TASK_QUEUED) {
> +		/* is curr the only runnable task? */
> +		if (!first)
> +			return curr;
> +
> +		/*
> +		 * Does curr trump first? We can always go by core_sched_at for
> +		 * this comparison as it represents global FIFO ordering when
> +		 * the default core-sched ordering is used and local-DSQ FIFO
> +		 * ordering otherwise.
> +		 *
> +		 * We can have a task with an earlier timestamp on the DSQ. For
> +		 * example, when a current task is preempted by a sibling
> +		 * picking a different cookie, the task would be requeued at the
> +		 * head of the local DSQ with an earlier timestamp than the
> +		 * core-sched picked next task. Besides, the BPF scheduler may
> +		 * dispatch any tasks to the local DSQ anytime.
> +		 */
> +		if (curr->scx.slice && time_before64(curr->scx.core_sched_at,
> +						     first->scx.core_sched_at))
> +			return curr;
> +	}

And the above condition seems a little core_sched specific. Is that
suitable for the primary pick function?

> +
> +	return first;	/* this may be %NULL */
> +}


