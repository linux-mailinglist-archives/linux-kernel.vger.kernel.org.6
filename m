Return-Path: <linux-kernel+bounces-268107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BA6942073
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470972858D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6783518C904;
	Tue, 30 Jul 2024 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlmwMcEV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7933F241E7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367167; cv=none; b=ewfGeAR05MjRbCA2zy/WXhiH6vP29KhsxRTMfTMgqcsqVcxzYDXlPOMBrEfBsTcYA7wDTukXBSM7CUiKwPLvF7kNbuA3qUMYGiMJIN3nwxy3CqKpNPyA99P7h0VWEtlbMggv6Q948kaYjkuHaQzcibUNGN+JU+UN7XZTJvkGyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367167; c=relaxed/simple;
	bh=lcUug7LG6wc3ABpSlVAtHnK8SflEuZJ+761ObswyxVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OceqG4JsN4adqQ2m7FmrqetXaCFJNQP7MtIlMXpwCiIjmRTU3cVpVW4KC9uJ7QG0E+TPnvLhz0q0F710OSix4eLpoPMRPbOBKBQAh/STNgSHsF8mNQZi/KgLMjN2XeUCZhP/ECUgW3esSIItsMJZA70CzKpH2+9TqAud3yu5/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlmwMcEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2FBC32782;
	Tue, 30 Jul 2024 19:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722367167;
	bh=lcUug7LG6wc3ABpSlVAtHnK8SflEuZJ+761ObswyxVk=;
	h=From:To:Cc:Subject:Date:From;
	b=GlmwMcEVUxObQHbTncHWjf2a9ruu5N6KJlDMAZcSvUaxHY13m1yOIrkYIWusXOz7X
	 oYqqmfXsVTfzOWudV95b7XaRy0EkmgZAHiGvClyLIwf45bMKyAvinoQOsq8EoYyU1j
	 h3vmamhIB1zVZtmGEcdGDilLYptG3YglGkM4X080tzYyrgjoWmbwkA7y3Xt7yWf2a8
	 PEQLs+qUeLw+2gj3tNBEL4ULgr4uwx7yotUYoUTomF+EzozlZOfiY13NF6gMs9nFl+
	 0fsLzPgWNL6UKt8OD0NJ/72Pb/Q6i+cvk6VQ9iW0jK7JBsCbuF3b5R63YM8//0/X8f
	 2WXmWLePQPSzg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH] perf/core: Optimize event reschedule for a PMU
Date: Tue, 30 Jul 2024 12:19:25 -0700
Message-ID: <20240730191925.469649-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current ctx_resched() reschedules every events in all PMUs in the
context even if it only needs to do it for a single event.  This is the
case when it opens a new event or enables an existing one.  What we
want is to reschedule events in the PMU only.  Also perf_pmu_resched()
currently calls ctx_resched() without PMU information.

Let's add __perf_pmu_resched() to do the work for the given PMU only.
The context time should be updated by ctx_sched_{out,in}(EVENT_TIME)
outside from it.  And change the __pmu_ctx_sched_in() to be symmetrical
to the _sched_out() for its arguments so that it can be called easily
in the __perf_pmu_resched().

Note that __perf_install_in_context() should call ctx_resched() for the
very first event in the context in order to set ctx->is_active.  Later
events can be handled by __perf_pmu_resched().

Care should be taken when it installs a task event for a PMU and
there's no CPU event for the PMU.  __perf_pmu_resched() will ask the
CPU PMU context to schedule any events in it according to the group
info.  But as the PMU context was not activated, it didn't set the
event context pointer.  So I added new NULL checks in the
__pmu_ctx_sched_{in,out}.

With this change I can get 4x speed up (but actually it's proportional
to the number of uncore PMU events) on a 2-socket Intel EMR machine in
opening and closing a perf event for the core PMU in a loop while there
are a bunch of uncore PMU events active on the CPU.  The test code
(stress-pmu) follows below.

Before)
  # ./stress-pmu
  delta: 0.087068 sec (870 usec/op)

After)
  # ./stress-pmu
  delta: 0.021440 sec (214 usec/op)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
  $ cat stress-pmu.c
  #include <stdio.h>
  #include <unistd.h>
  #include <linux/perf_event.h>
  #include <sys/syscall.h>
  #include <sys/time.h>

  /* from uncore cpumask on EMR */
  #define TARGET_CPU 60

  #define LOOP 100
  #define US2S 1000000

  int open_perf_event(int type, int config)
  {
  	struct perf_event_attr attr = {
  		.type = type,
  		.config = config,
  	};
  	int fd;

  	fd = syscall(SYS_perf_event_open, &attr, /*pid=*/-1, TARGET_CPU,
  			/*group_fd=*/-1, /*flags=*/0);
  	if (fd < 0)
  		printf("perf_event_open failed (type=%d, config=%d): %m\n", type, config);
  	return fd;
  }

  int main(int argc, char *argv[])
  {
  	struct timeval ts1, ts2;
  	unsigned long long delta;
  	int target_cpu = TARGET_CPU;

  	/* open random uncore PMU events */
  	for (int i = 0; i < 100; i++)
  		open_perf_event(/*type=*/i + 20, /*config=*/0);

  	gettimeofday(&ts1, NULL);
  	for (int i = 0; i < LOOP; i++)
  		close(open_perf_event(PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES));
  	gettimeofday(&ts2, NULL);

  	delta = ts2.tv_sec * US2S + ts2.tv_usec - (ts1.tv_sec * US2S + ts1.tv_usec);
  	printf("delta: %llu.%06llu sec (%llu usec/op)\n",
  		delta / US2S, delta % US2S, delta / LOOP);
  	return 0;
  }
---
 kernel/events/core.c | 101 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 88 insertions(+), 13 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f64c30e7d5da..a8a078a0a6d9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -709,6 +709,10 @@ static void perf_ctx_enable(struct perf_event_context *ctx, bool cgroup)
 
 static void ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type);
 static void ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type);
+static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
+				enum event_type_t event_type);
+static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
+			       enum event_type_t event_type);
 
 #ifdef CONFIG_CGROUP_PERF
 
@@ -2683,11 +2687,6 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
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
 			enum event_type_t event_type)
@@ -2728,13 +2727,62 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 		perf_ctx_enable(task_ctx, false);
 }
 
+static void __perf_pmu_resched(struct pmu *pmu,
+			       struct perf_event_context *task_ctx,
+			       enum event_type_t event_type)
+{
+	bool cpu_event = !!(event_type & EVENT_CPU);
+	struct perf_event_pmu_context *epc = NULL;
+	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(pmu->cpu_pmu_context);
+
+	/*
+	 * If pinned groups are involved, flexible groups also need to be
+	 * scheduled out.
+	 */
+	if (event_type & EVENT_PINNED)
+		event_type |= EVENT_FLEXIBLE;
+
+	event_type &= EVENT_ALL;
+
+	perf_pmu_disable(pmu);
+	if (task_ctx) {
+		if (WARN_ON_ONCE(!cpc->task_epc || cpc->task_epc->ctx != task_ctx))
+			goto out;
+
+		epc = cpc->task_epc;
+		__pmu_ctx_sched_out(epc, event_type);
+	}
+
+	/*
+	 * Decide which cpu ctx groups to schedule out based on the types
+	 * of events that caused rescheduling:
+	 *  - EVENT_CPU: schedule out corresponding groups;
+	 *  - EVENT_PINNED task events: schedule out EVENT_FLEXIBLE groups;
+	 *  - otherwise, do nothing more.
+	 */
+	if (cpu_event)
+		__pmu_ctx_sched_out(&cpc->epc, event_type);
+	else if (event_type & EVENT_PINNED)
+		__pmu_ctx_sched_out(&cpc->epc, EVENT_FLEXIBLE);
+
+	__pmu_ctx_sched_in(&cpc->epc, EVENT_PINNED);
+	if (task_ctx)
+		 __pmu_ctx_sched_in(epc, EVENT_PINNED);
+	__pmu_ctx_sched_in(&cpc->epc, EVENT_FLEXIBLE);
+	if (task_ctx)
+		 __pmu_ctx_sched_in(epc, EVENT_FLEXIBLE);
+
+out:
+	perf_pmu_enable(pmu);
+}
+
 void perf_pmu_resched(struct pmu *pmu)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 
 	perf_ctx_lock(cpuctx, task_ctx);
-	ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
+	__perf_pmu_resched(pmu, task_ctx, EVENT_ALL|EVENT_CPU);
 	perf_ctx_unlock(cpuctx, task_ctx);
 }
 
@@ -2792,7 +2840,14 @@ static int  __perf_install_in_context(void *info)
 	if (reprogram) {
 		ctx_sched_out(ctx, EVENT_TIME);
 		add_event_to_ctx(event, ctx);
-		ctx_resched(cpuctx, task_ctx, get_event_type(event));
+		if (ctx->nr_events == 1) {
+			/* The first event needs to set ctx->is_active. */
+			ctx_resched(cpuctx, task_ctx, get_event_type(event));
+		} else {
+			__perf_pmu_resched(event->pmu_ctx->pmu, task_ctx,
+					   get_event_type(event));
+			ctx_sched_in(ctx, EVENT_TIME);
+		}
 	} else {
 		add_event_to_ctx(event, ctx);
 	}
@@ -2962,7 +3017,8 @@ static void __perf_event_enable(struct perf_event *event,
 	if (ctx->task)
 		WARN_ON_ONCE(task_ctx != ctx);
 
-	ctx_resched(cpuctx, task_ctx, get_event_type(event));
+	__perf_pmu_resched(event->pmu_ctx->pmu, task_ctx, get_event_type(event));
+	ctx_sched_in(ctx, EVENT_TIME);
 }
 
 /*
@@ -3230,6 +3286,13 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
 	struct perf_event *event, *tmp;
 	struct pmu *pmu = pmu_ctx->pmu;
 
+	/*
+	 * CPU's pmu_ctx might not be active when __perf_pmu_resched() is called
+	 * for task events and there's no cpu events.
+	 */
+	if (ctx == NULL)
+		return;
+
 	if (ctx->task && !ctx->is_active) {
 		struct perf_cpu_pmu_context *cpc;
 
@@ -3872,10 +3935,22 @@ static void ctx_groups_sched_in(struct perf_event_context *ctx,
 	}
 }
 
-static void __pmu_ctx_sched_in(struct perf_event_context *ctx,
-			       struct pmu *pmu)
+static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
+			       enum event_type_t event_type)
 {
-	pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu);
+	struct perf_event_context *ctx = pmu_ctx->ctx;
+
+	/*
+	 * CPU's pmu_ctx might not be active when __perf_pmu_resched() is called
+	 * for task events and there's no cpu events.
+	 */
+	if (ctx == NULL)
+		return;
+
+	if (event_type & EVENT_PINNED)
+		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu);
+	if (event_type & EVENT_FLEXIBLE)
+		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu);
 }
 
 static void
@@ -4309,14 +4384,14 @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
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
-- 
2.46.0.rc1.232.g9752f9e123-goog


