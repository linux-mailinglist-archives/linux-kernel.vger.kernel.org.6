Return-Path: <linux-kernel+bounces-248890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358B492E351
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272321C21298
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2995815531B;
	Thu, 11 Jul 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B8Tygmo2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AAFDDDF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689594; cv=none; b=WuwwnWQAtp1j1lnK5lVfv/u190KaSqAK0NuYbMbXhde0NQmudFPDc2acJvJj7rO1LWMF+1WFevjP/TYuOAfxdrNDAu6XQF5f9Po1bd+uCp52WeT2nzv6Iz/Cv/mIjbOE4F6LMt/S2hB4Ct+3Lvpu6gyEGUxRo3I0R837WqUcqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689594; c=relaxed/simple;
	bh=StGhj4F5X28PxAs8fHRPmPetl5Qh4MtX2st6Bbm/bgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX2Ii9P5FIWNoYNEZ7OzVuHQYOrfMDwnHczi+D7vE499NVhSwRzl2o8NSYfIQg7oZNLtCXH2sEGdaeYCFIMxRBjaqmdt7UarGzr4jrD/oxAdjI3jkz1+c9rS9gPqnXAcbIUYrir1+Kp4i3u5czAgie0J2vEw5f1XiGp6LHqHfvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B8Tygmo2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VdDFKHe7WsI0PRcGzOYSnCSNc5MfGUQHpHlIoFI2v8Y=; b=B8Tygmo2JebPbGsNiRlrcg24cS
	+PT/YCGqU9AUhg02FqqRp0CLutsM1KK4Ue9TnU5pYeM9ztyc0dXcLYyaJr20G7wG7M9TRX/Z5qE/+
	yYm33AR/q2bEqahi3vcnIZG8u78LXBpt/7SHcdZhSC1nBvwtOMu7Q4aqoJKN1qo/cGdSFsOSVD6nH
	rJzRlGglrKNp+O6qpKSLqKMlTYAj+yYLtok8zKXYt0+C4gxGt/d+2U8nUyeO9JwnwhoY9l2cJoEHn
	46r0ZyvWX2pph8cZy95BQWwjncpEL2BVRJ5fi5E8uU2zQ2j4LyQzmMHiZUBt7+a03GTQqTTLfjX1t
	xfu3pZlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRpxh-0000000AoMi-0gFT;
	Thu, 11 Jul 2024 09:19:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C9A4F30050D; Thu, 11 Jul 2024 11:19:36 +0200 (CEST)
Date: Thu, 11 Jul 2024 11:19:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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
Subject: Re: [PATCH 2/3] sched/core: Introduce SM_IDLE and an idle re-entry
 fast-path in __schedule()
Message-ID: <20240711091936.GJ4587@noisy.programming.kicks-ass.net>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
 <20240710090210.41856-3-kprateek.nayak@amd.com>
 <CAKfTPtCNJUC-gNNPkEBRT5a2UVcPUHLdzUJ+-egZGQ5ihnU0Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCNJUC-gNNPkEBRT5a2UVcPUHLdzUJ+-egZGQ5ihnU0Kw@mail.gmail.com>

On Thu, Jul 11, 2024 at 10:00:15AM +0200, Vincent Guittot wrote:
> On Wed, 10 Jul 2024 at 11:03, K Prateek Nayak <kprateek.nayak@amd.com> wrote:

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 1e0c77eac65a..417d3ebbdf60 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6343,19 +6343,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >   * Constants for the sched_mode argument of __schedule().
> >   *
> >   * The mode argument allows RT enabled kernels to differentiate a
> > - * preemption from blocking on an 'sleeping' spin/rwlock. Note that
> > - * SM_MASK_PREEMPT for !RT has all bits set, which allows the compiler to
> > - * optimize the AND operation out and just check for zero.
> > + * preemption from blocking on an 'sleeping' spin/rwlock.
> >   */
> > -#define SM_NONE                        0x0
> > -#define SM_PREEMPT             0x1
> > -#define SM_RTLOCK_WAIT         0x2
> > -
> > -#ifndef CONFIG_PREEMPT_RT
> > -# define SM_MASK_PREEMPT       (~0U)
> > -#else
> > -# define SM_MASK_PREEMPT       SM_PREEMPT
> > -#endif
> > +#define SM_IDLE                        (-1)
> > +#define SM_NONE                        0
> > +#define SM_PREEMPT             1
> > +#define SM_RTLOCK_WAIT         2
> >
> >  /*
> >   * __schedule() is the main scheduler function.
> > @@ -6396,11 +6389,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >   *
> >   * WARNING: must be called with preemption disabled!
> >   */
> > -static void __sched notrace __schedule(unsigned int sched_mode)
> > +static void __sched notrace __schedule(int sched_mode)
> >  {
> >         struct task_struct *prev, *next;
> >         unsigned long *switch_count;
> >         unsigned long prev_state;
> > +       bool preempt = sched_mode > 0;
> >         struct rq_flags rf;
> >         struct rq *rq;
> >         int cpu;
> > @@ -6409,13 +6403,13 @@ static void __sched notrace __schedule(unsigned int sched_mode)
> >         rq = cpu_rq(cpu);
> >         prev = rq->curr;
> >
> > -       schedule_debug(prev, !!sched_mode);
> > +       schedule_debug(prev, preempt);
> >
> >         if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
> >                 hrtick_clear(rq);
> >
> >         local_irq_disable();
> > -       rcu_note_context_switch(!!sched_mode);
> > +       rcu_note_context_switch(preempt);
> >
> >         /*
> >          * Make sure that signal_pending_state()->signal_pending() below
> > @@ -6449,7 +6443,12 @@ static void __sched notrace __schedule(unsigned int sched_mode)
> >          * that we form a control dependency vs deactivate_task() below.
> >          */
> >         prev_state = READ_ONCE(prev->__state);
> > -       if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
> > +       if (sched_mode == SM_IDLE) {
> > +               if (!rq->nr_running) {
> > +                       next = prev;
> > +                       goto picked;
> > +               }
> > +       } else if (!preempt && prev_state) {
> 
> With CONFIG_PREEMPT_RT, it was only for SM_PREEMPT but not for SM_RTLOCK_WAIT

Bah, yes. But then schedule_debug() and rcu_note_context_switch() have
an argument that is called 'preempt' but is set for SM_RTLOCK_WAIT.

Now, I think the RCU think is actually correct here, it doesn't want to
consider SM_RTLOCK_WAIT as a voluntary schedule point, because spinlocks
don't either. But it is confusing as heck.

We can either write things like:

	} else if (sched_mode != SM_PREEMPT && prev_state) {

or do silly things like:

#define SM_IDLE	(-16)

keep the SM_MASK_PREEMPT trickery and do:

	} else if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {

Not sure that is actually going to matter at this point though.

