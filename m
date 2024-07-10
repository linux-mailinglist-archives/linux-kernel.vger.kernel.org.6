Return-Path: <linux-kernel+bounces-247789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC84392D48F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46591C21756
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0324D193479;
	Wed, 10 Jul 2024 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hh6Pa1ad"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00B193462
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623224; cv=none; b=VnoEhjOcV8uYxg5PnEBZBsRc6sOSfVcmH0g9yE3im5VdbPLjiIxk8PTSEesmNNy24OIYla+/DcTjYJaNidj1AltKJ88+Kk1q9wtYhGh5zS80aviI6zcdH+K6ehYRL2u752Q5SqvCOYfKl0iIST32xu3mD9NMB6CcshcIT7FOuUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623224; c=relaxed/simple;
	bh=pMOw2aqKt8wZam3p3vPJat/5dAgBLwNw61xOamvNdqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoneEBzDo2nWBhPsupPWqZTCAo0pogjwP4xkX+8Tu7/8Qfasdo2MQw3pnu1bPhfYncOhurcD2FNlfo+7GFGjTuSybEmPlBzICnfRT7+KqN/Y7K8dXelPp2hV8mZze0652Cml5pxg/LUAZo7lzHpELDTWpxneb8IVDz8xUmkrPPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hh6Pa1ad; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0FRJV/HCKqdLSxbeB6npqIsxmIRGJPJkosWmQJ7bPUo=; b=Hh6Pa1adhPABWirmZPVN7wW7Nd
	Z6O3ETccArGJ0OElj0M97TNE93BxzBQcr2rYxf8lBAsyzeL3goRdBeE+ao7UvOBLCUfBPWX8LSE3O
	PXwq2akPdmVPSzJHaXmQKMUwt06wpSt5ppiaI8Cb9M3KK5LnhG5Ipf7m04f2oGOS0Sk24irauJv9N
	gsuUaqdxyzrfRupLrIHEiNDXTUphrZ4eLMdWDUUvTHRfBVmOz3CuCRTq/jHKmpZGw9G4re2qAGtsX
	u/9zHzdgo8zJffum0wKFWPmHKJTnZaX/7SnSWV5eYQ6OxfhofmaYyFutPPx8ExdmULJ+QmUJAwOsf
	F7ea9FuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRYh7-00000000uob-2WNY;
	Wed, 10 Jul 2024 14:53:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F343D300694; Wed, 10 Jul 2024 16:53:20 +0200 (CEST)
Date: Wed, 10 Jul 2024 16:53:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Imran Khan <imran.f.khan@oracle.com>,
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
	Rik van Riel <riel@surriel.com>, Tejun Heo <tj@kernel.org>,
	Cruz Zhao <CruzZhao@linux.alibaba.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH 1/3] sched/core: Remove the unnecessary need_resched()
 check in nohz_csd_func()
Message-ID: <20240710145320.GA27299@noisy.programming.kicks-ass.net>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
 <20240710090210.41856-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710090210.41856-2-kprateek.nayak@amd.com>

On Wed, Jul 10, 2024 at 09:02:08AM +0000, K Prateek Nayak wrote:
> The need_resched() check currently in nohz_csd_func() can be tracked
> to have been added in scheduler_ipi() back in 2011 via commit
> ca38062e57e9 ("sched: Use resched IPI to kick off the nohz idle balance")
> 
> Since then, it has travelled quite a bit but it seems like an idle_cpu()
> check currently is sufficient to detect the need to bail out from an
> idle load balancing. To justify this removal, consider all the following
> case where an idle load balancing could race with a task wakeup:
> 
> o Since commit f3dd3f674555b ("sched: Remove the limitation of WF_ON_CPU
>   on wakelist if wakee cpu is idle") a target perceived to be idle
>   (target_rq->nr_running == 0) will return true for
>   ttwu_queue_cond(target) which will offload the task wakeup to the idle
>   target via an IPI.
> 
>   In all such cases target_rq->ttwu_pending will be set to 1 before
>   queuing the wake function.
> 
>   If an idle load balance races here, following scenarios are possible:
> 
>   - The CPU is not in TIF_POLLING_NRFLAG mode in which case an actual
>     IPI is sent to the CPU to wake it out of idle. If the
>     nohz_csd_func() queues before sched_ttwu_pending(), the idle load
>     balance will bail out since idle_cpu(target) returns 0 since
>     target_rq->ttwu_pending is 1. If the nohz_csd_func() is queued after
>     sched_ttwu_pending() it should see rq->nr_running to be non-zero and
>     bail out of idle load balancing.
> 
>   - The CPU is in TIF_POLLING_NRFLAG mode and instead of an actual IPI,
>     the sender will simply set TIF_NEED_RESCHED for the target to put it
>     out of idle and flush_smp_call_function_queue() in do_idle() will
>     execute the call function. Depending on the ordering of the queuing
>     of nohz_csd_func() and sched_ttwu_pending(), the idle_cpu() check in
>     nohz_csd_func() should either see target_rq->ttwu_pending = 1 or
>     target_rq->nr_running to be non-zero if there is a genuine task
>     wakeup racing with the idle load balance kick.

For completion sake, we should also consider the !TTWU_QUEUE case, this
configuration is default for PREEMPT_RT, where the wake_list is a source
of non-determinism.

In quick reading I think that case should be fine, since we directly
enqueue remotely and ->nr_running adjusts accordingly, but it is late in
the day and I'm easily mistaken.

> o The waker CPU perceives the target CPU to be busy
>   (targer_rq->nr_running != 0) but the CPU is in fact going idle and due
>   to a series of unfortunate events, the system reaches a case where the
>   waker CPU decides to perform the wakeup by itself in ttwu_queue() on
>   the target CPU but target is concurrently selected for idle load
>   balance (Can this happen? I'm not sure, but we'll consider its
>   possibility to estimate the worst case scenario).
> 
>   ttwu_do_activate() calls enqueue_task() which would increment
>   "rq->nr_running" post which it calls wakeup_preempt() which is
>   responsible for setting TIF_NEED_RESCHED (via a resched IPI or by
>   setting TIF_NEED_RESCHED on a TIF_POLLING_NRFLAG idle CPU) The key
>   thing to note in this case is that rq->nr_running is already non-zero
>   in case of a wakeup before TIF_NEED_RESCHED is set which would
>   lead to idle_cpu() check returning false.
> 
> In all cases, it seems that need_resched() check is unnecessary when
> checking for idle_cpu() first since an impending wakeup racing with idle
> load balancer will either set the "rq->ttwu_pending" or indicate a newly
> woken task via "rq->nr_running".

Right.

> Chasing the reason why this check might have existed in the first place,
> I came across  Peter's suggestion on the fist iteration of Suresh's
> patch from 2011 [1] where the condition to raise the SCHED_SOFTIRQ was:
> 
> 	sched_ttwu_do_pending(list);
> 
> 	if (unlikely((rq->idle == current) &&
> 	    rq->nohz_balance_kick &&
> 	    !need_resched()))
> 		raise_softirq_irqoff(SCHED_SOFTIRQ);
> 
> However, since this was preceded by sched_ttwu_do_pending() which is
> equivalent of sched_ttwu_pending() in the current upstream kernel, the
> need_resched() check was necessary to catch a newly queued task. Peter
> suggested modifying it to:
> 
> 	if (idle_cpu() && rq->nohz_balance_kick && !need_resched())
> 		raise_softirq_irqoff(SCHED_SOFTIRQ);
> 
> where idle_cpu() seems to have replaced "rq->idle == current" check.
> However, even back then, the idle_cpu() check would have been sufficient
> to have caught the enqueue of a new task and since commit b2a02fc43a1f
> ("smp: Optimize send_call_function_single_ipi()") overloads the
> interpretation of TIF_NEED_RESCHED for TIF_POLLING_NRFLAG idling, remove
> the need_resched() check in nohz_csd_func() to raise SCHED_SOFTIRQ based
> on Peter's suggestion.

... sooo many years ago :-)

> Link: https://lore.kernel.org/all/1317670590.20367.38.camel@twins/ [1]
> Link: https://lore.kernel.org/lkml/20240615014521.GR8774@noisy.programming.kicks-ass.net/
> Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0935f9d4bb7b..1e0c77eac65a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1205,7 +1205,7 @@ static void nohz_csd_func(void *info)
>  	WARN_ON(!(flags & NOHZ_KICK_MASK));
>  
>  	rq->idle_balance = idle_cpu(cpu);
> -	if (rq->idle_balance && !need_resched()) {
> +	if (rq->idle_balance) {
>  		rq->nohz_idle_balance = flags;
>  		raise_softirq_irqoff(SCHED_SOFTIRQ);
>  	}
> -- 
> 2.34.1
> 

