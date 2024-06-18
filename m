Return-Path: <linux-kernel+bounces-218722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5461790C468
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 09:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A828312D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADA66D1B9;
	Tue, 18 Jun 2024 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hk4ul8FS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F8F1B813
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694269; cv=none; b=KjWtaDXGALmWdCqj+Dy/LEcFqmXUhs9oaJ8f8EuHzSC2F5Gtlswx6wxGrlWnrwprxZbNk423fcVE+EsstXaR61W+qAMdLkdrlObRnDD8viWvY9GNYIO1ChVlS2QJ9x7J7Mi33pykGE0Ih6aNARC7ILFK6HaxVIGHZLLobpwls5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694269; c=relaxed/simple;
	bh=MDg6RkmO4Yfsh1OY/z+MpJauhy4HGsHIMFEcIS5bVm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDhBU32CeWiRyXc/KqPU2fzKk7kIkNqojzutwyqS8bYAf9Mz5M0Z6LM+eEQRCaYiKWCJ8tuPu7lTmO9xNc9Nls3W5xkF0UMF198/UfIe69HaHLVNzdg6sQPXIuZu2txyOtgl0KxAUac00NXvtKkDWq+GmTQsHCkgrIhDWYeHwkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hk4ul8FS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=a32itoIQGPJ1mtia7JDbs0YlYwz6jPXDjPzhY4qzUcY=; b=hk4ul8FSgDOThtskWfLPHOe1MN
	AOr3zCVWX0YDATupAgZQN/Jqatv0ehRNMX8VtZgU+xNi8vvgqzJPHPumkIfHeZoGxnIbEBaRHV4xi
	ltw25976N8geH97pSWxk2cV/vujxT8cXrYq7GXjkd2pyj+sFARZOKILocNaPAJdqm9AtTKO0L4Xij
	pwaVOyFADPZfcjOz8WhJJxz08/1bJPqejl1IA+kz7ViUTRIzfUJPx0SR5huMEK9ORWLXC6m+gn3WT
	6heeO++3xfQIVjXXTF9jD3uSEeDBCeQm3A9koYSUggIP2CfBeJXg363TZYRPW0S2n6Surh8LzYd5D
	oKvuswqA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJSt2-00000002v1L-4B1J;
	Tue, 18 Jun 2024 07:04:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 68EB8300886; Tue, 18 Jun 2024 09:04:12 +0200 (CEST)
Date: Tue, 18 Jun 2024 09:04:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling
 update_rq_clock
Message-ID: <20240618070412.GA31592@noisy.programming.kicks-ass.net>
References: <20240613015837.4132703-1-jstultz@google.com>
 <20240613100441.GC17707@noisy.programming.kicks-ass.net>
 <20240613115142.kxrmlf3btmwjcprg@airbuntu>
 <20240614094833.GM8774@noisy.programming.kicks-ass.net>
 <20240616223616.im3tlh6jheadlhnz@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616223616.im3tlh6jheadlhnz@airbuntu>

On Sun, Jun 16, 2024 at 11:36:16PM +0100, Qais Yousef wrote:

> > Which then gets me something like the (completely untested) below..
> > 
> > Hmm?
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0935f9d4bb7b..36aed99d6a6c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -724,7 +724,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
> >  
> >  	rq->prev_irq_time += irq_delta;
> >  	delta -= irq_delta;
> > -	psi_account_irqtime(rq->curr, irq_delta);
> >  	delayacct_irq(rq->curr, irq_delta);
> >  #endif
> >  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> > @@ -5459,6 +5458,8 @@ void sched_tick(void)
> >  
> >  	sched_clock_tick();
> >  
> > +	psi_account_irqtime(curr, NULL, &rq->psi_irq_time);
> > +
> >  	rq_lock(rq, &rf);
> >  
> >  	update_rq_clock(rq);
> > @@ -6521,6 +6524,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
> >  		++*switch_count;
> >  
> >  		migrate_disable_switch(rq, prev);
> > +		psi_account_irqtime(prev, next, &rq->psi_irq_time);
> 
> Hmm are prev and next swapped here? next == curr in my view if there's no
> subtly I missed

This is before context_switch() so prev == current at this point.
However, more importantly, the PSI thing accounts to its 'curr' group
and that should very much be the outgoing task's group in this case.

That is, we need to make sure the outgoing group is up-to-date before
switching to a new group.

Makes sense?

> >  		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
> >  
> >  		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 146baa91d104..65bba162408f 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -991,22 +991,31 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
> >  }
> >  
> >  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> > -void psi_account_irqtime(struct task_struct *task, u32 delta)
> > +void psi_account_irqtime(struct task_struct *curr, struct task_struct *prev, u64 *time)
> >  {
> > -	int cpu = task_cpu(task);
> > +	int cpu = task_cpu(curr);
> >  	struct psi_group *group;
> >  	struct psi_group_cpu *groupc;
> > -	u64 now;
> > +	u64 now, irq;
> > +	s64 delta;
> >  
> >  	if (static_branch_likely(&psi_disabled))
> >  		return;
> >  
> > -	if (!task->pid)
> > +	if (!curr->pid)
> > +		return;
> > +
> > +	group = task_psi_group(curr);
> > +	if( prev && task_psi_group(prev) == group)
> 
> nit: whitespace misplaced

Ha!, is that's all and it all works in one go it's awesome :-)

I'm still trying to learn to type again after switching keyboards. I've
used a thinkpad keyboard (either on an actual laptop or the travel
version on my desktop for nearly 20 years... Now I've picked up a split
keyboard out of necessity (UHK 60 v2 for those interested) and muscle
memory is still cursing me every single day.

As a result, I now also cannot type on my laptop anymore, so lose-lose I
suppose ... urgh.

> LGTM otherwise.
> 
> Reviewed-by: Qais Yousef <qyousef@layalina.io>

Thanks!

John, can you write up a changelog with some pretty numbers and all
that? Also, when you re-post, can you make sure to Cc the PSI folks
(johannes and suren iirc, get_maintainers.pl seems to find them).

