Return-Path: <linux-kernel+bounces-190536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D068CFF9A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066EF282601
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E815ECC5;
	Mon, 27 May 2024 12:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odWyLTXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4135615E5DE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811673; cv=none; b=ZgpQPhIUV1QIDzZOTtXlysiL/iR9V2GlEtN6g+YN7iwBM/IMrJChUPzSW/hzhq36ri1byuOPMkmelIvSyRsFG48hj8zoknqnCBPm9obznx3GlfKUBYkE/lhKcyPuzfdcwS5DhfaU1vYbBmLaFyx6s1gr3DLD0s+X/RM2EdmgTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811673; c=relaxed/simple;
	bh=9iphjjJ3l0wGAk7aOQyFCRiylzWP1wts1/hpHCZEWt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afgbMNqk9aQWg68fJ55PN5rNccqX8jFH+9PVoilZ4WUCYTc9SbDgfUMKxJYxuKGR5mmMrfDhSIHf+iDQ5qvh5lXcWJNmKKl1dWxTtOUERi+Ouh65bAt/z8u3bnIA+8cgaDnv/0Ifjc9jVi2nQhxQCAe3PIDQifgC1dQ6pmQ/VU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odWyLTXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BE3C2BBFC;
	Mon, 27 May 2024 12:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716811672;
	bh=9iphjjJ3l0wGAk7aOQyFCRiylzWP1wts1/hpHCZEWt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odWyLTXgmxbOZj+K6wt4ojKpcBgaD1Mohgq5Nn91w3SyPMQIv349voOWkMbg4iyTh
	 UZy9a9sJBrY//v+h8YVpE4SpPXX+I5HTIU2Duu9c8LfyLtwAEUI6Bd19/V0CMuByC/
	 QM8lh0ZrStApAVR0OMPd6H9yC/hQScPtemO6Sd5OHa4f55QTIgcq9Bm7ydTkI4HPz/
	 n+iQqyg9AI1U8n09AZ0jrw3EHo4NkAwvt4xZ/htGd+jgcHLm8+4dfbJYcsg6FpFuaH
	 GgR+L7blagK1xdPGDqOJw7NkS8WexpnG7oPKcbWrPvb2ixUwXihuln/DkHlMGXe0d6
	 JqqnBn5DbD2UQ==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	bristot@kernel.org,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: [PATCH V7 9/9] sched/rt: Remove default bandwidth control
Date: Mon, 27 May 2024 14:06:55 +0200
Message-ID: <14d562db55df5c3c780d91940743acb166895ef7.1716811044.git.bristot@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716811043.git.bristot@kernel.org>
References: <cover.1716811043.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

Now that fair_server exists, we no longer need RT bandwidth control
unless RT_GROUP_SCHED.

Enable fair_server with parameters equivalent to RT throttling.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/core.c     |   9 +-
 kernel/sched/deadline.c |   5 +-
 kernel/sched/debug.c    |   3 +
 kernel/sched/rt.c       | 242 ++++++++++++++++++----------------------
 kernel/sched/sched.h    |   3 +-
 5 files changed, 120 insertions(+), 142 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 01336277eac9..8439c2f992db 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9987,8 +9987,6 @@ void __init sched_init(void)
 #endif /* CONFIG_RT_GROUP_SCHED */
 	}
 
-	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
-
 #ifdef CONFIG_SMP
 	init_defrootdomain();
 #endif
@@ -10043,8 +10041,13 @@ void __init sched_init(void)
 		init_tg_cfs_entry(&root_task_group, &rq->cfs, NULL, i, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
-		rq->rt.rt_runtime = def_rt_bandwidth.rt_runtime;
 #ifdef CONFIG_RT_GROUP_SCHED
+		/*
+		 * This is required for init cpu because rt.c:__enable_runtime()
+		 * starts working after scheduler_running, which is not the case
+		 * yet.
+		 */
+		rq->rt.rt_runtime = global_rt_runtime();
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0dbb42cf7fe6..7df8179bfa08 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1554,6 +1554,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	if (dl_se == &rq->fair_server)
 		return;
 
+#ifdef CONFIG_RT_GROUP_SCHED
 	/*
 	 * Because -- for now -- we share the rt bandwidth, we need to
 	 * account our runtime there too, otherwise actual rt tasks
@@ -1578,6 +1579,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 			rt_rq->rt_time += delta_exec;
 		raw_spin_unlock(&rt_rq->rt_runtime_lock);
 	}
+#endif
 }
 
 /*
@@ -1632,8 +1634,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	 * this before getting generic.
 	 */
 	if (!dl_server(dl_se)) {
-		/* Disabled */
-		u64 runtime = 0;
+		u64 runtime =  50 * NSEC_PER_MSEC;
 		u64 period = 1000 * NSEC_PER_MSEC;
 
 		dl_server_apply_params(dl_se, runtime, period, 1);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index b14ffb100867..2d5851d65c67 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -889,9 +889,12 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", #x, SPLIT_NS(rt_rq->x))
 
 	PU(rt_nr_running);
+
+#ifdef CONFIG_RT_GROUP_SCHED
 	P(rt_throttled);
 	PN(rt_time);
 	PN(rt_runtime);
+#endif
 
 #undef PN
 #undef PU
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index aa4c1c874fa4..fb591b98d71f 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -8,10 +8,6 @@ int sched_rr_timeslice = RR_TIMESLICE;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
 
-static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
-
-struct rt_bandwidth def_rt_bandwidth;
-
 /*
  * period over which we measure -rt task CPU usage in us.
  * default: 1s
@@ -66,6 +62,40 @@ static int __init sched_rt_sysctl_init(void)
 late_initcall(sched_rt_sysctl_init);
 #endif
 
+void init_rt_rq(struct rt_rq *rt_rq)
+{
+	struct rt_prio_array *array;
+	int i;
+
+	array = &rt_rq->active;
+	for (i = 0; i < MAX_RT_PRIO; i++) {
+		INIT_LIST_HEAD(array->queue + i);
+		__clear_bit(i, array->bitmap);
+	}
+	/* delimiter for bitsearch: */
+	__set_bit(MAX_RT_PRIO, array->bitmap);
+
+#if defined CONFIG_SMP
+	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
+	rt_rq->highest_prio.next = MAX_RT_PRIO-1;
+	rt_rq->overloaded = 0;
+	plist_head_init(&rt_rq->pushable_tasks);
+#endif /* CONFIG_SMP */
+	/* We start is dequeued state, because no RT tasks are queued */
+	rt_rq->rt_queued = 0;
+
+#ifdef CONFIG_RT_GROUP_SCHED
+	rt_rq->rt_time = 0;
+	rt_rq->rt_throttled = 0;
+	rt_rq->rt_runtime = 0;
+	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
+#endif
+}
+
+#ifdef CONFIG_RT_GROUP_SCHED
+
+static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
+
 static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
 {
 	struct rt_bandwidth *rt_b =
@@ -130,35 +160,6 @@ static void start_rt_bandwidth(struct rt_bandwidth *rt_b)
 	do_start_rt_bandwidth(rt_b);
 }
 
-void init_rt_rq(struct rt_rq *rt_rq)
-{
-	struct rt_prio_array *array;
-	int i;
-
-	array = &rt_rq->active;
-	for (i = 0; i < MAX_RT_PRIO; i++) {
-		INIT_LIST_HEAD(array->queue + i);
-		__clear_bit(i, array->bitmap);
-	}
-	/* delimiter for bitsearch: */
-	__set_bit(MAX_RT_PRIO, array->bitmap);
-
-#if defined CONFIG_SMP
-	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
-	rt_rq->highest_prio.next = MAX_RT_PRIO-1;
-	rt_rq->overloaded = 0;
-	plist_head_init(&rt_rq->pushable_tasks);
-#endif /* CONFIG_SMP */
-	/* We start is dequeued state, because no RT tasks are queued */
-	rt_rq->rt_queued = 0;
-
-	rt_rq->rt_time = 0;
-	rt_rq->rt_throttled = 0;
-	rt_rq->rt_runtime = 0;
-	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
-}
-
-#ifdef CONFIG_RT_GROUP_SCHED
 static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
 {
 	hrtimer_cancel(&rt_b->rt_period_timer);
@@ -195,7 +196,6 @@ void unregister_rt_sched_group(struct task_group *tg)
 {
 	if (tg->rt_se)
 		destroy_rt_bandwidth(&tg->rt_bandwidth);
-
 }
 
 void free_rt_sched_group(struct task_group *tg)
@@ -253,8 +253,7 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 	if (!tg->rt_se)
 		goto err;
 
-	init_rt_bandwidth(&tg->rt_bandwidth,
-			ktime_to_ns(def_rt_bandwidth.rt_period), 0);
+	init_rt_bandwidth(&tg->rt_bandwidth, ktime_to_ns(global_rt_period()), 0);
 
 	for_each_possible_cpu(i) {
 		rt_rq = kzalloc_node(sizeof(struct rt_rq),
@@ -604,70 +603,6 @@ static inline struct rt_bandwidth *sched_rt_bandwidth(struct rt_rq *rt_rq)
 	return &rt_rq->tg->rt_bandwidth;
 }
 
-#else /* !CONFIG_RT_GROUP_SCHED */
-
-static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
-{
-	return rt_rq->rt_runtime;
-}
-
-static inline u64 sched_rt_period(struct rt_rq *rt_rq)
-{
-	return ktime_to_ns(def_rt_bandwidth.rt_period);
-}
-
-typedef struct rt_rq *rt_rq_iter_t;
-
-#define for_each_rt_rq(rt_rq, iter, rq) \
-	for ((void) iter, rt_rq = &rq->rt; rt_rq; rt_rq = NULL)
-
-#define for_each_sched_rt_entity(rt_se) \
-	for (; rt_se; rt_se = NULL)
-
-static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
-{
-	return NULL;
-}
-
-static inline void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
-{
-	struct rq *rq = rq_of_rt_rq(rt_rq);
-
-	if (!rt_rq->rt_nr_running)
-		return;
-
-	enqueue_top_rt_rq(rt_rq);
-	resched_curr(rq);
-}
-
-static inline void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
-{
-	dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
-}
-
-static inline int rt_rq_throttled(struct rt_rq *rt_rq)
-{
-	return rt_rq->rt_throttled;
-}
-
-static inline const struct cpumask *sched_rt_period_mask(void)
-{
-	return cpu_online_mask;
-}
-
-static inline
-struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
-{
-	return &cpu_rq(cpu)->rt;
-}
-
-static inline struct rt_bandwidth *sched_rt_bandwidth(struct rt_rq *rt_rq)
-{
-	return &def_rt_bandwidth;
-}
-
-#endif /* CONFIG_RT_GROUP_SCHED */
-
 bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
 {
 	struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
@@ -859,7 +794,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 	const struct cpumask *span;
 
 	span = sched_rt_period_mask();
-#ifdef CONFIG_RT_GROUP_SCHED
+
 	/*
 	 * FIXME: isolated CPUs should really leave the root task group,
 	 * whether they are isolcpus or were isolated via cpusets, lest
@@ -871,7 +806,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 	 */
 	if (rt_b == &root_task_group.rt_bandwidth)
 		span = cpu_online_mask;
-#endif
+
 	for_each_cpu(i, span) {
 		int enqueue = 0;
 		struct rt_rq *rt_rq = sched_rt_period_rt_rq(rt_b, i);
@@ -938,18 +873,6 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 	return idle;
 }
 
-static inline int rt_se_prio(struct sched_rt_entity *rt_se)
-{
-#ifdef CONFIG_RT_GROUP_SCHED
-	struct rt_rq *rt_rq = group_rt_rq(rt_se);
-
-	if (rt_rq)
-		return rt_rq->highest_prio.curr;
-#endif
-
-	return rt_task_of(rt_se)->prio;
-}
-
 static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 {
 	u64 runtime = sched_rt_runtime(rt_rq);
@@ -993,6 +916,72 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 	return 0;
 }
 
+#else /* !CONFIG_RT_GROUP_SCHED */
+
+typedef struct rt_rq *rt_rq_iter_t;
+
+#define for_each_rt_rq(rt_rq, iter, rq) \
+	for ((void) iter, rt_rq = &rq->rt; rt_rq; rt_rq = NULL)
+
+#define for_each_sched_rt_entity(rt_se) \
+	for (; rt_se; rt_se = NULL)
+
+static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
+{
+	return NULL;
+}
+
+static inline void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
+{
+	struct rq *rq = rq_of_rt_rq(rt_rq);
+
+	if (!rt_rq->rt_nr_running)
+		return;
+
+	enqueue_top_rt_rq(rt_rq);
+	resched_curr(rq);
+}
+
+static inline void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
+{
+	dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
+}
+
+static inline int rt_rq_throttled(struct rt_rq *rt_rq)
+{
+	return false;
+}
+
+static inline const struct cpumask *sched_rt_period_mask(void)
+{
+	return cpu_online_mask;
+}
+
+static inline
+struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
+{
+	return &cpu_rq(cpu)->rt;
+}
+
+#ifdef CONFIG_SMP
+static void __enable_runtime(struct rq *rq) { }
+static void __disable_runtime(struct rq *rq) { }
+#endif
+
+#endif /* CONFIG_RT_GROUP_SCHED */
+
+static inline int rt_se_prio(struct sched_rt_entity *rt_se)
+{
+#ifdef CONFIG_RT_GROUP_SCHED
+	struct rt_rq *rt_rq = group_rt_rq(rt_se);
+
+	if (rt_rq)
+		return rt_rq->highest_prio.curr;
+#endif
+
+	return rt_task_of(rt_se)->prio;
+}
+
 /*
  * Update the current task's runtime statistics. Skip current tasks that
  * are not in our scheduling class.
@@ -1000,7 +989,6 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
-	struct sched_rt_entity *rt_se = &curr->rt;
 	s64 delta_exec;
 
 	if (curr->sched_class != &rt_sched_class)
@@ -1010,6 +998,9 @@ static void update_curr_rt(struct rq *rq)
 	if (unlikely(delta_exec <= 0))
 		return;
 
+#ifdef CONFIG_RT_GROUP_SCHED
+	struct sched_rt_entity *rt_se = &curr->rt;
+
 	if (!rt_bandwidth_enabled())
 		return;
 
@@ -1028,6 +1019,7 @@ static void update_curr_rt(struct rq *rq)
 				do_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
 		}
 	}
+#endif
 }
 
 static void
@@ -1184,7 +1176,6 @@ dec_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 static void
 inc_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 {
-	start_rt_bandwidth(&def_rt_bandwidth);
 }
 
 static inline
@@ -2912,19 +2903,6 @@ int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 #ifdef CONFIG_SYSCTL
 static int sched_rt_global_constraints(void)
 {
-	unsigned long flags;
-	int i;
-
-	raw_spin_lock_irqsave(&def_rt_bandwidth.rt_runtime_lock, flags);
-	for_each_possible_cpu(i) {
-		struct rt_rq *rt_rq = &cpu_rq(i)->rt;
-
-		raw_spin_lock(&rt_rq->rt_runtime_lock);
-		rt_rq->rt_runtime = global_rt_runtime();
-		raw_spin_unlock(&rt_rq->rt_runtime_lock);
-	}
-	raw_spin_unlock_irqrestore(&def_rt_bandwidth.rt_runtime_lock, flags);
-
 	return 0;
 }
 #endif /* CONFIG_SYSCTL */
@@ -2944,12 +2922,6 @@ static int sched_rt_global_validate(void)
 
 static void sched_rt_do_global(void)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&def_rt_bandwidth.rt_runtime_lock, flags);
-	def_rt_bandwidth.rt_runtime = global_rt_runtime();
-	def_rt_bandwidth.rt_period = ns_to_ktime(global_rt_period());
-	raw_spin_unlock_irqrestore(&def_rt_bandwidth.rt_runtime_lock, flags);
 }
 
 static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3b8684b5ec8e..c93de331171b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -729,13 +729,13 @@ struct rt_rq {
 #endif /* CONFIG_SMP */
 	int			rt_queued;
 
+#ifdef CONFIG_RT_GROUP_SCHED
 	int			rt_throttled;
 	u64			rt_time;
 	u64			rt_runtime;
 	/* Nests inside the rq lock: */
 	raw_spinlock_t		rt_runtime_lock;
 
-#ifdef CONFIG_RT_GROUP_SCHED
 	unsigned int		rt_nr_boosted;
 
 	struct rq		*rq;
@@ -2478,7 +2478,6 @@ extern void reweight_task(struct task_struct *p, int prio);
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
 extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 
-- 
2.45.1


