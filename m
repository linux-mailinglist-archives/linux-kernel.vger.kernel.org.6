Return-Path: <linux-kernel+bounces-244473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DDD92A4AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C213F1F22229
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFE313DDC9;
	Mon,  8 Jul 2024 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PRv0PxsU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621313D639
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448932; cv=none; b=J8vFKyShiXd1ItDdu05wjvVIDKZTKwiLydUxBbJAGjVE7fTVKnGiAhevDnqdUJaNvs7Z7JagR8HmoVN7hbSlU6QSbrgWG8D1Hmtk2/+2UpncnzgawZCr1+32tcwF45qwT6Vy2u0efKG5IHc1akQDDCN3FOYsa5P6KFwnjh22U60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448932; c=relaxed/simple;
	bh=iCjp5l9ZLXSMtX09jIMhv2Es+oU9vMyqDfW1AYCUQUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnBdUlYubMze/EwxP6tI2VneWOFZNQggXWrKBQMgZ7Wq9MkcEpWkKD9LveZy3FKoi8NHvtUWZ3eHiN+4tt057ZUIA0o/w+KLg1oEEx7iSBRaZkSRutf4oLu9BRSqToyozt6TmjE2k/HivEY0Tidtypbm0HC5EYovNxOPNCZ2tsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PRv0PxsU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h9f100joe6WcX16q+01lxB7ejVKGlkMh5tlSI/z7mpw=; b=PRv0PxsUfjIousHM4DQpQliqiE
	5L/FYODJo9w6RI49eAuNwvKcoQ1qHBvFvv2oRiqK8NmC5EAJ/erZnxAW794JR9i8v5h9Gjc/k9KsE
	0tu6uPGXn2fYrqLbTXrRfiYICztCJZAjjlJqlwPtN5QtVj5pBWruE8JdIayYp//+lpjT+cCR8gS3x
	N6oxZzXh91Hh6EQg5Bq1lVJjqrQaz7uAxBS5HD6KuU0HyWT2itVdEDCuu/kalPDDqmvH3eIzMPEXV
	k+eg1wCPvHaPkPDRIuJsxVj90KMfF9gyEKk9of2LeqOxmfoTLH6rRzEp+cmNd/OtMuAeyPsUNb8iV
	w0LDZpLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQpM7-00000006ttl-1VEl;
	Mon, 08 Jul 2024 14:28:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 51CDF300694; Mon,  8 Jul 2024 16:28:32 +0200 (CEST)
Date: Mon, 8 Jul 2024 16:28:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Tianchen Ding <dtcccc@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>
Subject: Re: [PATCH v2] sched/fair: Make SCHED_IDLE entity be preempted in
 strict hierarchy
Message-ID: <20240708142832.GB27299@noisy.programming.kicks-ass.net>
References: <20240626023505.1332596-1-dtcccc@linux.alibaba.com>
 <20240708120254.GA27299@noisy.programming.kicks-ass.net>
 <CAKfTPtDxdLpm6cC-vv1PpHaEtiOeLtuCwChgZ6Ypg6owz3Vvsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDxdLpm6cC-vv1PpHaEtiOeLtuCwChgZ6Ypg6owz3Vvsw@mail.gmail.com>

On Mon, Jul 08, 2024 at 02:47:34PM +0200, Vincent Guittot wrote:
> On Mon, 8 Jul 2024 at 14:02, Peter Zijlstra <peterz@infradead.org> wrote:

> > > @@ -8409,6 +8400,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> > >       if (cse_is_idle != pse_is_idle)
> > >               return;
> > >
> > > +     /*
> > > +      * Batch tasks do not preempt non-idle tasks (their preemption
> > > +      * is driven by the tick).
> > > +      * We've done the check about "only one of the entities is idle",
> > > +      * so cse must be non-idle if p is a batch task.
> > > +      */
> > > +     if (unlikely(entity_is_task(pse) && p->policy == SCHED_BATCH))
> > > +             return;
> >
> > I'm not convinced this condition is right. The current behaviour of
> > SCHED_BATCH doesn't care about pse, only p.
> >
> > That is, if p is SCHED_BATCH it will not preempt -- except an
> > SCHED_IDLE.
> >
> > So I'm tempted to delete this first part of your condition and have it
> > be:
> >
> >         if (p->policy == SCHED_BATCH)
> >                 return;
> >
> > That is, suppose you have:
> >
> >                         root
> >                          |
> >               ------------------------
> >               |                      |
> >         normal_cgroup          normal_cgroup
> >               |                      |
> >         SCHED_BATCH task_A     SCHED_BATCH task_B
> >
> > Then the preemption crud will end up comparing the groups to one another
> > and still allow A to preempt B -- except we explicitly do not want this.
> >
> > The 'problem' is that the whole BATCH thing isn't cgroup aware ofcourse,
> > but I'm not sure we want to go fix that -- esp. not in this patch.
> >
> > Hmm?
> 
> Good question, but do we want to make SCHED_BATCH tasks behave
> differently than SCHED_IDLE tasks in a group in this case ?

I suspect we'll have to. People added the idle-cgroup thing, but never
did the same for batch. With the result that they're now fundamentally
different.

> With this patch, we don't want task_B to preempt task_A for the case
> but task_A will preempt task_B whereas task A is SCHED_IDLE
> 
>                          root
>                           |
>                ------------------------
>                |                      |
>          normal_cgroup          idle_cgroup
>                |                      |
>          SCHED_IDLE task_A     SCHED_NORMAL task_B
> 
> As we only look at the common level of hierarchy between the tasks,
> the below will make A to preempt B whereas both are SCHED_IDLE
> 
>                          root
>                           |
>                ------------------------
>                |                      |
>          normal_cgroup          normal_cgroup
>                |                      |
>          SCHED_IDLE task_A     SCHED_IDLE task_B

So we can make the last test be:

	if (unlikely(p->policy != SCHED_NORMAL))
		return;

Much like the original condition removed here:

-       if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+       if (!sched_feat(WAKEUP_PREEMPTION))

Except now after all that cgroup nonsense. Then the OP case will preempt
because normal_cgroup vs idle_cgroup, my BATCH example will not preempt,
because BATCH != NORMAL, your IDLE example will not preempt either,
because IDLE != NORMAL.



