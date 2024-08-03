Return-Path: <linux-kernel+bounces-273420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE70094690E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE4A1C20D51
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C025012B143;
	Sat,  3 Aug 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fvgeee4n"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AB847B
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722681137; cv=none; b=HS5LDiuJXEjwDus0r3mxPvm75EPN6V8Hc7E2pLivMUXnbZLkbPbX7YhvhoHTarnSxFVNr5/PNeo4NxVX1Hy6YKopkp/0lewyHBIgsC7XZU7Yqrxuc/O9+X7WiaL5QXOglF2cbFIzffCM7s4OXiimO23of/gBhAgpC1JsIWm73l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722681137; c=relaxed/simple;
	bh=dK4sfVKSX8FxJSZ82JsQE5l2g1wO+PG7XmQlJH+Lmkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unrpW4Z0FDj+EqAcU6hfZoBDXWsCHm10C7T6enbGYGBaflKs5CvcKWNclXgo9BCi7mZ/+BeOcgsRofoQu9quHxpMGjSM3aGWIqDcCscjse/ZdNiYTjP7VAqjLoZCv0iuY8jlQR0q4f4BoYqHFtOz+tYnPJ1OvvQD48Rko3SnMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fvgeee4n; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MFCzhR9IuQQU4WJ8y+IwUGf3IBwjjIjiajEPwxOCick=; b=fvgeee4ncd7fl2VsiPsPiOEDGn
	R/ZiTF567tJDKShxGvoM3dJcCEwC3abOBayLTNwChILd+OLeHc43dark56Q7lrHQ5Sw/nJSM1XgRk
	AAVhS22yYxzNr9o4GdTzYFDh6ognVNL6SyIvIY2TN2x1c2vcMPuD2Rncdhs8JacOCQmWGAKMTUoCC
	mX2ZoBtIhAUOkxTbhR6Cz1XPPttuMeCPD/5qt6pVF4AVVVPaOKb4zGXsd+PMTDQm2HEopWnkZwNL6
	fPipGOUifUUY5dp29uwodKGhRTfr9V8Vm8e6x0g4EG1of0pJ4GrXganxGueQIjO2n1ANMY1zR2PDL
	h4HC0cYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saC3P-000000021qa-1G9M;
	Sat, 03 Aug 2024 10:32:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4676E300820; Sat,  3 Aug 2024 12:32:02 +0200 (CEST)
Date: Sat, 3 Aug 2024 12:32:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH v2] perf/core: Optimize event reschedule for a PMU
Message-ID: <20240803103202.GD12673@noisy.programming.kicks-ass.net>
References: <20240731000607.543783-1-namhyung@kernel.org>
 <476e7cea-f987-432a-995b-f7d52a123c9d@linux.intel.com>
 <20240802183841.GG37996@noisy.programming.kicks-ass.net>
 <20240802184350.GA12673@noisy.programming.kicks-ass.net>
 <20240802185023.GB12673@noisy.programming.kicks-ass.net>
 <20240802191123.GC12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802191123.GC12673@noisy.programming.kicks-ass.net>

On Fri, Aug 02, 2024 at 09:11:23PM +0200, Peter Zijlstra wrote:

> But I'll have to continue staring at this later.

OK, I have the below, which boots and seems able to do:

  perf stat -ae power/energy-pkg/ -- sleep 1

and

  perf top

also still works, so it must be perfect, right, right?

It should be split up in at least 3, possibly more patches, but that's
for Monday. Now I get to mow the lawn or any of the other real-life
things weekends are for :-)

It also isn't ideal in that it still has a ton of pmu_ctx_list
iteration, but at least it will skip all the expensive parts.

---
 kernel/events/core.c | 210 +++++++++++++++++++++++++++------------------------
 1 file changed, 110 insertions(+), 100 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c01a32687dad..2e30ac0fbaf6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -685,30 +685,32 @@ do {									\
 	___p;								\
 })
 
+#define for_each_epc(_epc, _ctx, _pmu, _cgroup)				\
+	list_for_each_entry(_epc, &((_ctx)->pmu_ctx_list), pmu_ctx_entry) \
+		if (_cgroup && !_epc->nr_cgroups)			\
+			continue;					\
+		else if (_pmu && _epc->pmu != _pmu)			\
+			continue;					\
+		else
+
 static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
-			continue;
+	for_each_epc(pmu_ctx, ctx, NULL, cgroup)
 		perf_pmu_disable(pmu_ctx->pmu);
-	}
 }
 
 static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
 {
 	struct perf_event_pmu_context *pmu_ctx;
 
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
-			continue;
+	for_each_epc(pmu_ctx, ctx, NULL, cgroup)
 		perf_pmu_enable(pmu_ctx->pmu);
-	}
 }
 
-static void ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type);
-static void ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type);
+static void ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type);
+static void ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type);
 
 #ifdef CONFIG_CGROUP_PERF
 
@@ -865,7 +867,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_ctx_disable(&cpuctx->ctx, true);
 
-	ctx_sched_out(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
+	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 	/*
 	 * must not be done before ctxswout due
 	 * to update_cgrp_time_from_cpuctx() in
@@ -877,7 +879,7 @@ static void perf_cgroup_switch(struct task_struct *task)
 	 * perf_cgroup_set_timestamp() in ctx_sched_in()
 	 * to not have to pass task around
 	 */
-	ctx_sched_in(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
+	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 
 	perf_ctx_enable(&cpuctx->ctx, true);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -2328,6 +2330,24 @@ group_sched_out(struct perf_event *group_event, struct perf_event_context *ctx)
 		event_sched_out(event, ctx);
 }
 
+static void
+ctx_update_time(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
+{
+	if (ctx->is_active & EVENT_TIME) {
+		update_context_time(ctx);
+		update_cgrp_time_from_cpuctx(cpuctx, false);
+	}
+}
+
+static void
+ctx_update_event_time(struct perf_event_context *ctx, struct perf_event *event)
+{
+	if (ctx->is_active & EVENT_TIME) {
+		update_context_time(ctx);
+		update_cgrp_time_from_event(event);
+	}
+}
+
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
 #define DETACH_DEAD	0x04UL
@@ -2347,10 +2367,7 @@ __perf_remove_from_context(struct perf_event *event,
 	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
 	unsigned long flags = (unsigned long)info;
 
-	if (ctx->is_active & EVENT_TIME) {
-		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx, false);
-	}
+	ctx_update_time(cpuctx, ctx);
 
 	/*
 	 * Ensure event_sched_out() switches to OFF, at the very least
@@ -2435,12 +2452,8 @@ static void __perf_event_disable(struct perf_event *event,
 	if (event->state < PERF_EVENT_STATE_INACTIVE)
 		return;
 
-	if (ctx->is_active & EVENT_TIME) {
-		update_context_time(ctx);
-		update_cgrp_time_from_event(event);
-	}
-
 	perf_pmu_disable(event->pmu_ctx->pmu);
+	ctx_update_event_time(ctx, event);
 
 	if (event == event->group_leader)
 		group_sched_out(event, ctx);
@@ -2656,7 +2669,8 @@ static void add_event_to_ctx(struct perf_event *event,
 }
 
 static void task_ctx_sched_out(struct perf_event_context *ctx,
-				enum event_type_t event_type)
+			       struct pmu *pmu,
+			       enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 
@@ -2666,18 +2680,19 @@ static void task_ctx_sched_out(struct perf_event_context *ctx,
 	if (WARN_ON_ONCE(ctx != cpuctx->task_ctx))
 		return;
 
-	ctx_sched_out(ctx, event_type);
+	ctx_sched_out(ctx, pmu, event_type);
 }
 
 static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
-				struct perf_event_context *ctx)
+				struct perf_event_context *ctx,
+				struct pmu *pmu)
 {
-	ctx_sched_in(&cpuctx->ctx, EVENT_PINNED);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED);
 	if (ctx)
-		 ctx_sched_in(ctx, EVENT_PINNED);
-	ctx_sched_in(&cpuctx->ctx, EVENT_FLEXIBLE);
+		 ctx_sched_in(ctx, pmu, EVENT_PINNED);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
 	if (ctx)
-		 ctx_sched_in(ctx, EVENT_FLEXIBLE);
+		 ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE);
 }
 
 /*
@@ -2695,16 +2710,12 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
  * event_type is a bit mask of the types of events involved. For CPU events,
  * event_type is only either EVENT_PINNED or EVENT_FLEXIBLE.
  */
-/*
- * XXX: ctx_resched() reschedule entire perf_event_context while adding new
- * event to the context or enabling existing event in the context. We can
- * probably optimize it by rescheduling only affected pmu_ctx.
- */
 static void ctx_resched(struct perf_cpu_context *cpuctx,
 			struct perf_event_context *task_ctx,
-			enum event_type_t event_type)
+			struct pmu *pmu, enum event_type_t event_type)
 {
 	bool cpu_event = !!(event_type & EVENT_CPU);
+	struct perf_event_pmu_context *epc;
 
 	/*
 	 * If pinned groups are involved, flexible groups also need to be
@@ -2715,10 +2726,14 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 
 	event_type &= EVENT_ALL;
 
-	perf_ctx_disable(&cpuctx->ctx, false);
+	for_each_epc(epc, &cpuctx->ctx, pmu, false)
+		perf_pmu_disable(epc->pmu);
+
 	if (task_ctx) {
-		perf_ctx_disable(task_ctx, false);
-		task_ctx_sched_out(task_ctx, event_type);
+		for_each_epc(epc, task_ctx, pmu, false)
+			perf_pmu_disable(epc->pmu);
+
+		task_ctx_sched_out(task_ctx, pmu, event_type);
 	}
 
 	/*
@@ -2729,15 +2744,19 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	 *  - otherwise, do nothing more.
 	 */
 	if (cpu_event)
-		ctx_sched_out(&cpuctx->ctx, event_type);
+		ctx_sched_out(&cpuctx->ctx, pmu, event_type);
 	else if (event_type & EVENT_PINNED)
-		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
+		ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
 
-	perf_event_sched_in(cpuctx, task_ctx);
+	perf_event_sched_in(cpuctx, task_ctx, pmu);
 
-	perf_ctx_enable(&cpuctx->ctx, false);
-	if (task_ctx)
-		perf_ctx_enable(task_ctx, false);
+	for_each_epc(epc, &cpuctx->ctx, pmu, false)
+		perf_pmu_enable(epc->pmu);
+
+	if (task_ctx) {
+		for_each_epc(epc, task_ctx, pmu, false)
+			perf_pmu_enable(epc->pmu);
+	}
 }
 
 void perf_pmu_resched(struct pmu *pmu)
@@ -2746,7 +2765,7 @@ void perf_pmu_resched(struct pmu *pmu)
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 
 	perf_ctx_lock(cpuctx, task_ctx);
-	ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
+	ctx_resched(cpuctx, task_ctx, pmu, EVENT_ALL|EVENT_CPU);
 	perf_ctx_unlock(cpuctx, task_ctx);
 }
 
@@ -2802,9 +2821,10 @@ static int  __perf_install_in_context(void *info)
 #endif
 
 	if (reprogram) {
-		ctx_sched_out(ctx, EVENT_TIME);
+		ctx_update_time(cpuctx, ctx);
 		add_event_to_ctx(event, ctx);
-		ctx_resched(cpuctx, task_ctx, get_event_type(event));
+		ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
+			    get_event_type(event));
 	} else {
 		add_event_to_ctx(event, ctx);
 	}
@@ -2947,8 +2967,7 @@ static void __perf_event_enable(struct perf_event *event,
 	    event->state <= PERF_EVENT_STATE_ERROR)
 		return;
 
-	if (ctx->is_active)
-		ctx_sched_out(ctx, EVENT_TIME);
+	ctx_update_time(cpuctx, ctx);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 	perf_cgroup_event_enable(event, ctx);
@@ -2956,25 +2975,21 @@ static void __perf_event_enable(struct perf_event *event,
 	if (!ctx->is_active)
 		return;
 
-	if (!event_filter_match(event)) {
-		ctx_sched_in(ctx, EVENT_TIME);
+	if (!event_filter_match(event))
 		return;
-	}
 
 	/*
 	 * If the event is in a group and isn't the group leader,
 	 * then don't put it on unless the group is on.
 	 */
-	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
-		ctx_sched_in(ctx, EVENT_TIME);
+	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE)
 		return;
-	}
 
 	task_ctx = cpuctx->task_ctx;
 	if (ctx->task)
 		WARN_ON_ONCE(task_ctx != ctx);
 
-	ctx_resched(cpuctx, task_ctx, get_event_type(event));
+	ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu, get_event_type(event));
 }
 
 /*
@@ -3250,7 +3265,7 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
 		cpc->task_epc = NULL;
 	}
 
-	if (!event_type)
+	if (!(event_type & EVENT_ALL))
 		return;
 
 	perf_pmu_disable(pmu);
@@ -3276,8 +3291,17 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
 	perf_pmu_enable(pmu);
 }
 
+/*
+ * Be very careful with the @pmu argument since this will change ctx state.
+ * The @pmu argument works for ctx_resched(), because that is symmetric in
+ * ctx_sched_out() / ctx_sched_in() usage and the ctx state ends up invariant.
+ *
+ * However, if you were to be asymmetrical, you could end up with messed up
+ * state, eg. ctx->is_active cleared even though most EPCs would still actually
+ * be active.
+ */
 static void
-ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
+ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_pmu_context *pmu_ctx;
@@ -3331,11 +3355,8 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
 
 	is_active ^= ctx->is_active; /* changed bits */
 
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
-			continue;
+	for_each_epc(pmu_ctx, ctx, pmu, cgroup)
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
-	}
 }
 
 /*
@@ -3579,7 +3600,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 
 inside_switch:
 		perf_ctx_sched_task_cb(ctx, false);
-		task_ctx_sched_out(ctx, EVENT_ALL);
+		task_ctx_sched_out(ctx, NULL, EVENT_ALL);
 
 		perf_ctx_enable(ctx, false);
 		raw_spin_unlock(&ctx->lock);
@@ -3877,29 +3898,22 @@ static void pmu_groups_sched_in(struct perf_event_context *ctx,
 			   merge_sched_in, &can_add_hw);
 }
 
-static void ctx_groups_sched_in(struct perf_event_context *ctx,
-				struct perf_event_groups *groups,
-				bool cgroup)
+static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
+			       enum event_type_t event_type)
 {
-	struct perf_event_pmu_context *pmu_ctx;
-
-	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
-		if (cgroup && !pmu_ctx->nr_cgroups)
-			continue;
-		pmu_groups_sched_in(ctx, groups, pmu_ctx->pmu);
-	}
-}
+	struct perf_event_context *ctx = pmu_ctx->ctx;
 
-static void __pmu_ctx_sched_in(struct perf_event_context *ctx,
-			       struct pmu *pmu)
-{
-	pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu);
+	if (event_type & EVENT_PINNED)
+		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu);
+	if (event_type & EVENT_FLEXIBLE)
+		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu);
 }
 
 static void
-ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
+ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t event_type)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
+	struct perf_event_pmu_context *pmu_ctx;
 	int is_active = ctx->is_active;
 	bool cgroup = event_type & EVENT_CGROUP;
 
@@ -3935,12 +3949,16 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
 	 * First go through the list and put on any pinned groups
 	 * in order to give them the best chance of going on.
 	 */
-	if (is_active & EVENT_PINNED)
-		ctx_groups_sched_in(ctx, &ctx->pinned_groups, cgroup);
+	if (is_active & EVENT_PINNED) {
+		for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED);
+	}
 
 	/* Then walk through the lower prio flexible groups */
-	if (is_active & EVENT_FLEXIBLE)
-		ctx_groups_sched_in(ctx, &ctx->flexible_groups, cgroup);
+	if (is_active & EVENT_FLEXIBLE) {
+		for_each_epc(pmu_ctx, ctx, pmu, cgroup)
+			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE);
+	}
 }
 
 static void perf_event_context_sched_in(struct task_struct *task)
@@ -3983,10 +4001,10 @@ static void perf_event_context_sched_in(struct task_struct *task)
 	 */
 	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree)) {
 		perf_ctx_disable(&cpuctx->ctx, false);
-		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
+		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
 	}
 
-	perf_event_sched_in(cpuctx, ctx);
+	perf_event_sched_in(cpuctx, ctx, NULL);
 
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
 
@@ -4327,14 +4345,14 @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
 		update_context_time(&cpuctx->ctx);
 		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
 		rotate_ctx(&cpuctx->ctx, cpu_event);
-		__pmu_ctx_sched_in(&cpuctx->ctx, pmu);
+		__pmu_ctx_sched_in(cpu_epc, EVENT_FLEXIBLE);
 	}
 
 	if (task_event)
 		rotate_ctx(task_epc->ctx, task_event);
 
 	if (task_event || (task_epc && cpu_event))
-		__pmu_ctx_sched_in(task_epc->ctx, pmu);
+		__pmu_ctx_sched_in(task_epc, EVENT_FLEXIBLE);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -4400,7 +4418,7 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 
 	cpuctx = this_cpu_ptr(&perf_cpu_context);
 	perf_ctx_lock(cpuctx, ctx);
-	ctx_sched_out(ctx, EVENT_TIME);
+	ctx_update_time(cpuctx, ctx);
 
 	list_for_each_entry(event, &ctx->event_list, event_entry) {
 		enabled |= event_enable_on_exec(event, ctx);
@@ -4412,9 +4430,7 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 	 */
 	if (enabled) {
 		clone_ctx = unclone_ctx(ctx);
-		ctx_resched(cpuctx, ctx, event_type);
-	} else {
-		ctx_sched_in(ctx, EVENT_TIME);
+		ctx_resched(cpuctx, ctx, NULL, event_type);
 	}
 	perf_ctx_unlock(cpuctx, ctx);
 
@@ -4517,10 +4533,7 @@ static void __perf_event_read(void *info)
 		return;
 
 	raw_spin_lock(&ctx->lock);
-	if (ctx->is_active & EVENT_TIME) {
-		update_context_time(ctx);
-		update_cgrp_time_from_event(event);
-	}
+	ctx_update_event_time(ctx, event);
 
 	perf_event_update_time(event);
 	if (data->group)
@@ -4720,10 +4733,7 @@ static int perf_event_read(struct perf_event *event, bool group)
 		 * May read while context is not active (e.g., thread is
 		 * blocked), in that case we cannot update context time
 		 */
-		if (ctx->is_active & EVENT_TIME) {
-			update_context_time(ctx);
-			update_cgrp_time_from_event(event);
-		}
+		ctx_update_event_time(ctx, event);
 
 		perf_event_update_time(event);
 		if (group)
@@ -13202,7 +13212,7 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	 * in.
 	 */
 	raw_spin_lock_irq(&child_ctx->lock);
-	task_ctx_sched_out(child_ctx, EVENT_ALL);
+	task_ctx_sched_out(child_ctx, NULL, EVENT_ALL);
 
 	/*
 	 * Now that the context is inactive, destroy the task <-> ctx relation
@@ -13751,7 +13761,7 @@ static void __perf_event_exit_context(void *__info)
 	struct perf_event *event;
 
 	raw_spin_lock(&ctx->lock);
-	ctx_sched_out(ctx, EVENT_TIME);
+	ctx_sched_out(ctx, NULL, EVENT_TIME);
 	list_for_each_entry(event, &ctx->event_list, event_entry)
 		__perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
 	raw_spin_unlock(&ctx->lock);


