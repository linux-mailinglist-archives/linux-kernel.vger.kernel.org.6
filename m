Return-Path: <linux-kernel+bounces-275827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE3948AB9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE51285CEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACD41BBBEF;
	Tue,  6 Aug 2024 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eL8lP599"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC013C909
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931001; cv=none; b=kAwmy/fedWsTxiFWYePowjmQ3//uA6ShK8ayttdwRoyGLWYOz0I7lGgPgoM1FdqwWd+7Y1Tf4GWGCMJrvcjC0PKktJ3iGIzLBEHYwqH199DfrcPC3yVlV4sTKegPm/v43QKljxFmdcMKKFHut1F4selnZitBcJoq/zNOvvfC4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931001; c=relaxed/simple;
	bh=5bdzd9K/AtwtYl7cbYcOkK/yOmKM0K8gFdsRI8puG28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7q8/C/VHX1yGwL9WeUBvXVjf0EhrZsky04mWGSnNXuxqsz/R9BuMRwIyZAtlbZJibsWFVWt4ajCqIDcI5t9FR4J+Ry+Zc53+ppd84qdxxt17vSUoq/M2YO0jEeAub/5Nva0kz6ipscGWmPGOX2ZlobFgzocIH00ce2oB1Rxp2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eL8lP599; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=RyI1+a0NiVexXweUzjZjnzQOAvEwUqYTo4sdwRDY2FY=; b=eL8lP599jrdFciDZIX0Vq2Z6Uz
	jlKC6QVwHE2JtfZEAajxJhNzzm8w+g1jwEfPQBp+SUaudwg306335+5z4hSioxk/8U3uNrR5HnsBM
	MmL5W2SV2BZvI+CRQLlgM6Fj5hbyY+WbBSCbJJWv6ePvyZEDGo3vbf+7cbj7QFLQTzQtoDy9kZOWq
	Ftn58zpgi/RXw6MikEYQeMeN+zt8Y821d1OIyhm3f8uQVsAfNtvLHnz362bSnK/YQta8l0P3K8wnQ
	xaWIPSDIOAKexzAr+9YkigXteil2MHpIgmZx5s4xMEmhzUu8n3UffpeifWDntPHqeQ4YpkxQh7t4A
	+6/9qNeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbF3X-00000006OKT-2pEY;
	Tue, 06 Aug 2024 07:56:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C4AA830049D; Tue,  6 Aug 2024 09:56:30 +0200 (CEST)
Date: Tue, 6 Aug 2024 09:56:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH v2] perf/core: Optimize event reschedule for a PMU
Message-ID: <20240806075630.GL37996@noisy.programming.kicks-ass.net>
References: <20240731000607.543783-1-namhyung@kernel.org>
 <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240805092058.GK37996@noisy.programming.kicks-ass.net>
 <20240805145827.GE12673@noisy.programming.kicks-ass.net>
 <CAM9d7cj8YMt-YiVZ=7dRiEnfODqo=WLRJ87Rd134YR_O6MU_Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cj8YMt-YiVZ=7dRiEnfODqo=WLRJ87Rd134YR_O6MU_Qg@mail.gmail.com>

On Mon, Aug 05, 2024 at 11:19:48PM -0700, Namhyung Kim wrote:
> On Mon, Aug 5, 2024 at 7:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Aug 05, 2024 at 11:20:58AM +0200, Peter Zijlstra wrote:
> > > On Fri, Aug 02, 2024 at 02:30:19PM -0400, Liang, Kan wrote:
> > > > > @@ -2792,7 +2833,14 @@ static int  __perf_install_in_context(void *info)
> > > > >   if (reprogram) {
> > > > >           ctx_sched_out(ctx, EVENT_TIME);
> > > > >           add_event_to_ctx(event, ctx);
> > > > > -         ctx_resched(cpuctx, task_ctx, get_event_type(event));
> > > > > +         if (ctx->nr_events == 1) {
> > > > > +                 /* The first event needs to set ctx->is_active. */
> > > > > +                 ctx_resched(cpuctx, task_ctx, NULL, get_event_type(event));
> > > > > +         } else {
> > > > > +                 ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
> > > > > +                             get_event_type(event));
> > > > > +                 ctx_sched_in(ctx, EVENT_TIME);
> > > >
> > > > The changelog doesn't mention the time difference much. As my
> > > > understanding, the time is shared among PMUs in the same ctx.
> > > > When perf does ctx_resched(), the time is deducted.
> > > > There is no problem to stop and restart the global time when perf
> > > > re-schedule all PMUs.
> > > > But if only one PMU is re-scheduled while others are still running, it
> > > > may be a problem to stop and restart the global time. Other PMUs will be
> > > > impacted.
> > >
> > > So afaict, since we hold ctx->lock, nobody can observe EVENT_TIME was
> > > cleared for a little while.
> > >
> > > So the point was to make all the various ctx_sched_out() calls have the
> > > same timestamp. It does this by clearing EVENT_TIME first. Then the
> > > first ctx_sched_in() will set it again, and later ctx_sched_in() won't
> > > touch time.
> > >
> > > That leaves a little hole, because the time between
> > > ctx_sched_out(EVENT_TIME) and the first ctx_sched_in() gets lost.
> > >
> > > This isn't typically a problem, but not very nice. Let me go find an
> > > alternative solution for this. The simple update I did saturday is
> > > broken as per the perf test.
> >
> > OK, took a little longer than I would have liked, nor is it entirely
> > pretty, but it seems to pass 'perf test'.
> >
> > Please look at: queue.git perf/resched
> >
> > I'll try and post it all tomorrow.
> 
> Thanks for doing this.  But some of my tests are still failing.
> I'm seeing some system-wide events are not counted.
> Let me take a deeper look at it.

Does this help? What would be an easy reproducer?

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c67fc43fe877..4a04611333d9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -179,23 +179,27 @@ static void perf_ctx_lock(struct perf_cpu_context *cpuctx,
 	}
 }
 
+static inline void __perf_ctx_unlock(struct perf_event_context *ctx)
+{
+	/*
+	 * If ctx_sched_in() didn't again set any ALL flags, clean up
+	 * after ctx_sched_out() by clearing is_active.
+	 */
+	if (ctx->is_active & EVENT_FROZEN) {
+		if (!(ctx->is_active & EVENT_ALL))
+			ctx->is_active = 0;
+		else
+			ctx->is_active &= ~EVENT_FROZEN;
+	}
+	raw_spin_unlock(&ctx->lock);
+}
+
 static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
 			    struct perf_event_context *ctx)
 {
-	if (ctx) {
-		/*
-		 * If ctx_sched_in() didn't again set any ALL flags, clean up
-		 * after ctx_sched_out() by clearing is_active.
-		 */
-		if (ctx->is_active & EVENT_FROZEN) {
-			if (!(ctx->is_active & EVENT_ALL))
-				ctx->is_active = 0;
-			else
-				ctx->is_active &= ~EVENT_FROZEN;
-		}
-		raw_spin_unlock(&ctx->lock);
-	}
-	raw_spin_unlock(&cpuctx->ctx.lock);
+	if (ctx)
+		__perf_ctx_unlock(ctx);
+	__perf_ctx_unlock(&cpuctx->ctx.lock);
 }
 
 #define TASK_TOMBSTONE ((void *)-1L)

