Return-Path: <linux-kernel+bounces-180932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C019D8C7511
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B9B1C219E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803951459E3;
	Thu, 16 May 2024 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHFyTcL/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE6145354
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715858239; cv=none; b=j0HmxT/fIMhiYCRNzpBOAI7JFBTxTaryg729yf9S/hl2E4CAhNJJgOtr7iOM+LBzDczuBcfvqtabJR8y+3sEQnDam1eebFieTwxJhvDjs49zvtLrc+GDCTKm5VQR3/5yD37RryCs/zuyeSi3BN8LeR4GepvLWC9RKssGbVQ4GGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715858239; c=relaxed/simple;
	bh=1UfKGMJ9TThxAQag/fpQqjCYHLaRtcWRad/IDztYG+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T458vQ+nLRWlhTdRxi+7l4ve9GfY8akZ51pLULyCMoBziVJu07tb2fdpsDlIapzSFDBnQ/bS87ovHwqVjnD/yYlRxRFa/9G1RITb0wvkRxExdhuMvyplDpb/OqgZKzJQIzmHCBGbVkmqEet/lIBznwWFYKqYLinK1OwiHZeo7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHFyTcL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF519C113CC;
	Thu, 16 May 2024 11:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715858239;
	bh=1UfKGMJ9TThxAQag/fpQqjCYHLaRtcWRad/IDztYG+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHFyTcL/drb07H45gqUnNdYjzZbszYvz5AJdotwKTEmzuNAGyrvuQHTEhUHa8SSi8
	 8CV+/PJ7+41peChdh5ZsHI6icu3yp8Yc3S5lMXk1xpB1PHIZWpJyEq8FFrdEG6gyF2
	 Ws8e8jpPkxfR/sBJd0gbGZDdxeGp1dOm+ITe+KQ0YnDhncyHgnWD3Or+L8HRetA7UL
	 DHtYHP4lepyMR4NlYyBb8/kvcbNPht4O4+JLjejuuQwevWW3XKnBZmnLJ3rFqdaYKU
	 EKxY5WFfBr94tjx5LmlNsBk0Y8Afpe+LACYnSA52o3qnDOMeWJ28vg2gKTW4+mc7yx
	 7h7l7HalWhB6Q==
Date: Thu, 16 May 2024 13:17:16 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3/4] perf: Fix event leak upon exit
Message-ID: <ZkXrPNZCu1Eq8bTb@lothringen>
References: <20240515144311.16038-1-frederic@kernel.org>
 <20240515144311.16038-4-frederic@kernel.org>
 <20240516090529.GH22557@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516090529.GH22557@noisy.programming.kicks-ass.net>

On Thu, May 16, 2024 at 11:05:29AM +0200, Peter Zijlstra wrote:
> On Wed, May 15, 2024 at 04:43:10PM +0200, Frederic Weisbecker wrote:
> > When a task is scheduled out, pending sigtrap deliveries are deferred
> > to the target task upon resume to userspace via task_work.
> > 
> > However failures while adding en event's callback to the task_work
> > engine are ignored. And since the last call for events exit happen
> > after task work is eventually closed, there is a small window during
> > which pending sigtrap can be queued though ignored, leaking the event
> > refcount addition such as in the following scenario:
> > 
> >     TASK A
> >     -----
> > 
> >     do_exit()
> >        exit_task_work(tsk);
> > 
> >        <IRQ>
> >        perf_event_overflow()
> >           event->pending_sigtrap = pending_id;
> >           irq_work_queue(&event->pending_irq);
> >        </IRQ>
> >     =========> PREEMPTION: TASK A -> TASK B
> >        event_sched_out()
> >           event->pending_sigtrap = 0;
> >           atomic_long_inc_not_zero(&event->refcount)
> >           // FAILS: task work has exited
> >           task_work_add(&event->pending_task)
> >        [...]
> >        <IRQ WORK>
> >        perf_pending_irq()
> >           // early return: event->oncpu = -1
> >        </IRQ WORK>
> >        [...]
> >     =========> TASK B -> TASK A
> >        perf_event_exit_task(tsk)
> >           perf_event_exit_event()
> >              free_event()
> >                 WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1)
> >                 // leak event due to unexpected refcount == 2
> > 
> > As a result the event is never released while the task exits.
> 
> Urgh...
> 
> > 
> > Fix this with appropriate task_work_add()'s error handling.
> > 
> > Fixes: 517e6a301f34 ("perf: Fix perf_pending_task() UaF")
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/events/core.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 724e6d7e128f..c1632e69c69d 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2289,10 +2289,11 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
> >  		event->pending_sigtrap = 0;
> >  		if (state != PERF_EVENT_STATE_OFF &&
> >  		    !event->pending_work) {
> > -			event->pending_work = 1;
> > -			dec = false;
> > -			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> > -			task_work_add(current, &event->pending_task, TWA_RESUME);
> > +			if (task_work_add(current, &event->pending_task, TWA_RESUME) >= 0) {
> 
> AFAICT the thing is a return 0 on success -Efoo on fail, no? That is,
> should this not simply be '== 0' ?

Right.

> 
> > +				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> > +				dec = false;
> > +				event->pending_work = 1;
> > +			}
> 
> Also, do we want to write it like so and save an indent?
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2288,11 +2288,11 @@ event_sched_out(struct perf_event *event
>  
>  		event->pending_sigtrap = 0;
>  		if (state != PERF_EVENT_STATE_OFF &&
> -		    !event->pending_work) {
> +		    !event->pending_work &&
> +		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
>  			event->pending_work = 1;
>  			dec = false;
>  			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> -			task_work_add(current, &event->pending_task, TWA_RESUME);
>  		}
>  		if (dec)
>  			local_dec(&event->ctx->nr_pending);

Looks good, I'm resending this one patch.

Thanks.

