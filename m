Return-Path: <linux-kernel+bounces-268362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9FE9423B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57468B21450
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA31C2E;
	Wed, 31 Jul 2024 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtsPYU0K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B407366
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722384368; cv=none; b=qr0Xfsd9ZKD9nOeYXdiSXxG/CQtNU2VtLTYYk/y3yaZbvnXmNoIvqG8FGAw5baEjgaNyoDBA8Gc52ffTc2BKbz7GPVOXKk+zWctWVdqOqk3OQII7CNrkElWuvgsPCXWwmXufadj2xCjfhp0yX0j1BOu5VdVqR2qJzr6uxoLbyA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722384368; c=relaxed/simple;
	bh=QhnwmuFL8j02/2Co9Qx/vLpOevWrZGlACpYS6WyhVTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OHpqxpaEf4+TK2eG8oCmYcjje9/HizNg7qdyKRzYii+XucM+o//xzaS9o4VEyHK+56Rjevs3CVzpVueYptseKtoqTKYCLSVl/UT1mf6wp/pxZEBB5rjIkhFKGhQcLEbjpTC0B6Xb6xTOdME/Od+mX2Mb2sACJDtbOBM3UzzU9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtsPYU0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CD1C32782;
	Wed, 31 Jul 2024 00:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722384368;
	bh=QhnwmuFL8j02/2Co9Qx/vLpOevWrZGlACpYS6WyhVTw=;
	h=From:To:Cc:Subject:Date:From;
	b=gtsPYU0KfPF19VRfUPcwB/JRfpRmzdLut/bfBsSzVHFwEoLRKALnz9l7s0RshUTnU
	 hkjKbuj7zKADOArly38cXA0bWXSCaWxMx9NMAZ5q8lICVG/6YukQMCTb6COAjtxPtK
	 svd021wZq5BEAwNiRcAP4DRnwYUVsPZ6d2K/zyiTtAjzQEHhSHTaTL1u44Gf5Dl+pn
	 jYxI2wwMwzuSdSCu/nmUjgIxk6n+jZcUZouRT3lprKMkQBx96dqK6gIub821Wv1lbh
	 iEi6J0RxoR/5oE+W3wIY2e0+9/CRtEx6sLWaU6a5h45eGJ7ofVvEZxSsitGLmfhq8L
	 iyFtgqgoaOjEg==
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
	Mingwei Zhang <mizhang@google.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2] perf/core: Optimize event reschedule for a PMU
Date: Tue, 30 Jul 2024 17:06:07 -0700
Message-ID: <20240731000607.543783-1-namhyung@kernel.org>
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

Let's add pmu argument to ctx_resched() to do the work for the given
PMU only.  And change the __pmu_ctx_sched_in() to be symmetrical to the
_sched_out() counterpart for its arguments so that it can be called
easily in the __perf_pmu_resched().

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
v2) add 'pmu' argument to ctx_resched() to reduce duplication

 kernel/events/core.c | 118 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 93 insertions(+), 25 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f64c30e7d5da..41e2533859a4 100644
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
 
@@ -2668,6 +2672,17 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
 		 ctx_sched_in(ctx, EVENT_FLEXIBLE);
 }
 
+static void perf_pmu_sched_in(struct perf_cpu_pmu_context *cpc,
+			      struct perf_event_pmu_context *task_epc)
+{
+	__pmu_ctx_sched_in(&cpc->epc, EVENT_PINNED);
+	if (task_epc)
+		 __pmu_ctx_sched_in(task_epc, EVENT_PINNED);
+	__pmu_ctx_sched_in(&cpc->epc, EVENT_FLEXIBLE);
+	if (task_epc)
+		 __pmu_ctx_sched_in(task_epc, EVENT_FLEXIBLE);
+}
+
 /*
  * We want to maintain the following priority of scheduling:
  *  - CPU pinned (EVENT_CPU | EVENT_PINNED)
@@ -2683,16 +2698,13 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
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
+	struct perf_cpu_pmu_context *cpc = NULL;
+	struct perf_event_pmu_context *epc = NULL;
 
 	/*
 	 * If pinned groups are involved, flexible groups also need to be
@@ -2703,10 +2715,24 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 
 	event_type &= EVENT_ALL;
 
-	perf_ctx_disable(&cpuctx->ctx, false);
+	if (pmu) {
+		cpc = this_cpu_ptr(pmu->cpu_pmu_context);
+		perf_pmu_disable(pmu);
+	} else {
+		perf_ctx_disable(&cpuctx->ctx, false);
+	}
+
 	if (task_ctx) {
-		perf_ctx_disable(task_ctx, false);
-		task_ctx_sched_out(task_ctx, event_type);
+		if (pmu) {
+			if (WARN_ON_ONCE(!cpc->task_epc || cpc->task_epc->ctx != task_ctx))
+				goto out;
+
+			epc = cpc->task_epc;
+			__pmu_ctx_sched_out(epc, event_type);
+		} else {
+			perf_ctx_disable(task_ctx, false);
+			task_ctx_sched_out(task_ctx, event_type);
+		}
 	}
 
 	/*
@@ -2716,15 +2742,30 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	 *  - EVENT_PINNED task events: schedule out EVENT_FLEXIBLE groups;
 	 *  - otherwise, do nothing more.
 	 */
-	if (cpu_event)
-		ctx_sched_out(&cpuctx->ctx, event_type);
-	else if (event_type & EVENT_PINNED)
-		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
+	if (cpu_event) {
+		if (pmu)
+			__pmu_ctx_sched_out(&cpc->epc, event_type);
+		else
+			ctx_sched_out(&cpuctx->ctx, event_type);
+	} else if (event_type & EVENT_PINNED) {
+		if (pmu)
+			__pmu_ctx_sched_out(&cpc->epc, EVENT_FLEXIBLE);
+		else
+			ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
+	}
+
+	if (pmu)
+		perf_pmu_sched_in(cpc, epc);
+	else
+		perf_event_sched_in(cpuctx, task_ctx);
 
-	perf_event_sched_in(cpuctx, task_ctx);
+out:
+	if (pmu)
+		perf_pmu_enable(pmu);
+	else
+		perf_ctx_enable(&cpuctx->ctx, false);
 
-	perf_ctx_enable(&cpuctx->ctx, false);
-	if (task_ctx)
+	if (task_ctx && !pmu)
 		perf_ctx_enable(task_ctx, false);
 }
 
@@ -2734,7 +2775,7 @@ void perf_pmu_resched(struct pmu *pmu)
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 
 	perf_ctx_lock(cpuctx, task_ctx);
-	ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
+	ctx_resched(cpuctx, task_ctx, pmu, EVENT_ALL|EVENT_CPU);
 	perf_ctx_unlock(cpuctx, task_ctx);
 }
 
@@ -2792,7 +2833,14 @@ static int  __perf_install_in_context(void *info)
 	if (reprogram) {
 		ctx_sched_out(ctx, EVENT_TIME);
 		add_event_to_ctx(event, ctx);
-		ctx_resched(cpuctx, task_ctx, get_event_type(event));
+		if (ctx->nr_events == 1) {
+			/* The first event needs to set ctx->is_active. */
+			ctx_resched(cpuctx, task_ctx, NULL, get_event_type(event));
+		} else {
+			ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
+				    get_event_type(event));
+			ctx_sched_in(ctx, EVENT_TIME);
+		}
 	} else {
 		add_event_to_ctx(event, ctx);
 	}
@@ -2962,7 +3010,8 @@ static void __perf_event_enable(struct perf_event *event,
 	if (ctx->task)
 		WARN_ON_ONCE(task_ctx != ctx);
 
-	ctx_resched(cpuctx, task_ctx, get_event_type(event));
+	ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu, get_event_type(event));
+	ctx_sched_in(ctx, EVENT_TIME);
 }
 
 /*
@@ -3230,6 +3279,13 @@ static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
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
 
@@ -3872,10 +3928,22 @@ static void ctx_groups_sched_in(struct perf_event_context *ctx,
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
@@ -4309,14 +4377,14 @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
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
@@ -4394,7 +4462,7 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 	 */
 	if (enabled) {
 		clone_ctx = unclone_ctx(ctx);
-		ctx_resched(cpuctx, ctx, event_type);
+		ctx_resched(cpuctx, ctx, NULL, event_type);
 	} else {
 		ctx_sched_in(ctx, EVENT_TIME);
 	}
-- 
2.46.0.rc1.232.g9752f9e123-goog


