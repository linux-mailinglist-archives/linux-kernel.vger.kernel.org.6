Return-Path: <linux-kernel+bounces-544400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F96DA4E0CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F0C169076
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A8720767D;
	Tue,  4 Mar 2025 14:23:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514172063E9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098224; cv=none; b=K/oF8FC90YW1BttF+v9N1pfan/+FkuYFCSyz8V/9exMRBWkaGF91LYAxlVPq2i4Vv3Z+5W8EXJsumDRDX21UlRIPVMmwRX/t8kBMlrEzUh/pujtwa5JHfmVa6Jg8su6xg12ps9N1zZI6rdl+/6sbSlBopFYV3zuWmVv8k5oa6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098224; c=relaxed/simple;
	bh=TEDlHF/i9Vmved/T6z79jyfz+oPYRc/M33scgh/U23Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AS+r6G93SqSy7UwDNNLyk4PnmFigDDSULGj9UuGLYFqg84GHaMtiYNRd9t13cflYo76Pp6Iy9JHxBogUQLm+pFg9q47ENrtavsQ1K5akPvSAbxBsjpnIOWV1dJFqeKSMnOx9B+Xaw4RLogXpoxuGMcMP7kTCBtGf3ggIBLASs/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91976FEC;
	Tue,  4 Mar 2025 06:23:55 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2208C3F66E;
	Tue,  4 Mar 2025 06:23:40 -0800 (PST)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] sched/uclamp: Remove all uclamp bucket logic
Date: Tue,  4 Mar 2025 14:23:12 +0000
Message-Id: <9d071784c2a0ed26d61df571c0ced1e951ecbe3b.1741091349.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741091349.git.hongyan.xia2@arm.com>
References: <cover.1741091349.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also rewrite uclamp_update_active() so that the effective uclamp values
are updated every time we change task group properties, change system
defaults or a request is issued from userspace.

This also signnificantly reduces uclamp overhead because we no longer
need to compute effective uclamp values and manipulate buckets every
time a task is enqueued or dequeued (in uclamp_rq_{inc/dec}()).

TODO: Rewrite documentation to match the new logic.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 include/linux/sched.h   |   4 -
 init/Kconfig            |  32 -----
 kernel/sched/core.c     | 301 ++--------------------------------------
 kernel/sched/fair.c     |   4 -
 kernel/sched/rt.c       |   4 -
 kernel/sched/sched.h    |  95 +------------
 kernel/sched/syscalls.c |   2 +
 7 files changed, 20 insertions(+), 422 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a4bdfa1d6be1..012df2f612d4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -722,9 +722,6 @@ struct sched_dl_entity {
 };
 
 #ifdef CONFIG_UCLAMP_TASK
-/* Number of utilization clamp buckets (shorter alias) */
-#define UCLAMP_BUCKETS CONFIG_UCLAMP_BUCKETS_COUNT
-
 /*
  * Utilization clamp for a scheduling entity
  * @value:		clamp value "assigned" to a se
@@ -750,7 +747,6 @@ struct sched_dl_entity {
  */
 struct uclamp_se {
 	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
-	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
 	unsigned int active		: 1;
 	unsigned int user_defined	: 1;
 };
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..6d6d2eaa2963 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -843,38 +843,6 @@ config UCLAMP_TASK
 	  enforce or grant any specific bandwidth for tasks.
 
 	  If in doubt, say N.
-
-config UCLAMP_BUCKETS_COUNT
-	int "Number of supported utilization clamp buckets"
-	range 5 20
-	default 5
-	depends on UCLAMP_TASK
-	help
-	  Defines the number of clamp buckets to use. The range of each bucket
-	  will be SCHED_CAPACITY_SCALE/UCLAMP_BUCKETS_COUNT. The higher the
-	  number of clamp buckets the finer their granularity and the higher
-	  the precision of clamping aggregation and tracking at run-time.
-
-	  For example, with the minimum configuration value we will have 5
-	  clamp buckets tracking 20% utilization each. A 25% boosted tasks will
-	  be refcounted in the [20..39]% bucket and will set the bucket clamp
-	  effective value to 25%.
-	  If a second 30% boosted task should be co-scheduled on the same CPU,
-	  that task will be refcounted in the same bucket of the first task and
-	  it will boost the bucket clamp effective value to 30%.
-	  The clamp effective value of a bucket is reset to its nominal value
-	  (20% in the example above) when there are no more tasks refcounted in
-	  that bucket.
-
-	  An additional boost/capping margin can be added to some tasks. In the
-	  example above the 25% task will be boosted to 30% until it exits the
-	  CPU. If that should be considered not acceptable on certain systems,
-	  it's always possible to reduce the margin by increasing the number of
-	  clamp buckets to trade off used memory for run-time tracking
-	  precision.
-
-	  If in doubt, use the default value.
-
 endmenu
 
 #
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b00f884701a6..85c69ca7abaa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1495,54 +1495,6 @@ static struct uclamp_se uclamp_default[UCLAMP_CNT];
  */
 DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
 
-static inline unsigned int
-uclamp_idle_value(struct rq *rq, enum uclamp_id clamp_id,
-		  unsigned int clamp_value)
-{
-	/*
-	 * Avoid blocked utilization pushing up the frequency when we go
-	 * idle (which drops the max-clamp) by retaining the last known
-	 * max-clamp.
-	 */
-	if (clamp_id == UCLAMP_MAX) {
-		rq->uclamp_flags |= UCLAMP_FLAG_IDLE;
-		return clamp_value;
-	}
-
-	return uclamp_none(UCLAMP_MIN);
-}
-
-static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
-				     unsigned int clamp_value)
-{
-	/* Reset max-clamp retention only on idle exit */
-	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
-		return;
-
-	uclamp_rq_set(rq, clamp_id, clamp_value);
-}
-
-static inline
-unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
-				   unsigned int clamp_value)
-{
-	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
-	int bucket_id = UCLAMP_BUCKETS - 1;
-
-	/*
-	 * Since both min and max clamps are max aggregated, find the
-	 * top most bucket with tasks in.
-	 */
-	for ( ; bucket_id >= 0; bucket_id--) {
-		if (!bucket[bucket_id].tasks)
-			continue;
-		return bucket[bucket_id].value;
-	}
-
-	/* No tasks -- default clamp values */
-	return uclamp_idle_value(rq, clamp_id, clamp_value);
-}
-
 static void __uclamp_update_util_min_rt_default(struct task_struct *p)
 {
 	unsigned int default_util_min;
@@ -1598,8 +1550,7 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 }
 
 /*
- * The effective clamp bucket index of a task depends on, by increasing
- * priority:
+ * The effective uclamp value of a task depends on, by increasing priority:
  * - the task specific clamp value, when explicitly requested from userspace
  * - the task group effective clamp value, for tasks not either in the root
  *   group or in an autogroup
@@ -1620,202 +1571,23 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
-	struct uclamp_se uc_eff;
-
-	/* Task currently refcounted: use back-annotated (effective) value */
-	if (p->uclamp[clamp_id].active)
-		return (unsigned long)p->uclamp[clamp_id].value;
-
-	uc_eff = uclamp_eff_get(p, clamp_id);
-
-	return (unsigned long)uc_eff.value;
-}
-
-/*
- * When a task is enqueued on a rq, the clamp bucket currently defined by the
- * task's uclamp::bucket_id is refcounted on that rq. This also immediately
- * updates the rq's clamp value if required.
- *
- * Tasks can have a task-specific value requested from user-space, track
- * within each bucket the maximum value for tasks refcounted in it.
- * This "local max aggregation" allows to track the exact "requested" value
- * for each bucket when all its RUNNABLE tasks require the same clamp.
- */
-static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
-				    enum uclamp_id clamp_id)
-{
-	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
-	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
-	struct uclamp_bucket *bucket;
-
-	lockdep_assert_rq_held(rq);
-
-	/* Update task effective clamp */
-	p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
-
-	bucket = &uc_rq->bucket[uc_se->bucket_id];
-	bucket->tasks++;
-	uc_se->active = true;
-
-	uclamp_idle_reset(rq, clamp_id, uc_se->value);
-
-	/*
-	 * Local max aggregation: rq buckets always track the max
-	 * "requested" clamp value of its RUNNABLE tasks.
-	 */
-	if (bucket->tasks == 1 || uc_se->value > bucket->value)
-		bucket->value = uc_se->value;
-
-	if (uc_se->value > uclamp_rq_get(rq, clamp_id))
-		uclamp_rq_set(rq, clamp_id, uc_se->value);
-}
-
-/*
- * When a task is dequeued from a rq, the clamp bucket refcounted by the task
- * is released. If this is the last task reference counting the rq's max
- * active clamp value, then the rq's clamp value is updated.
- *
- * Both refcounted tasks and rq's cached clamp values are expected to be
- * always valid. If it's detected they are not, as defensive programming,
- * enforce the expected state and warn.
- */
-static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
-				    enum uclamp_id clamp_id)
-{
-	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
-	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
-	struct uclamp_bucket *bucket;
-	unsigned int bkt_clamp;
-	unsigned int rq_clamp;
-
-	lockdep_assert_rq_held(rq);
-
-	/*
-	 * If sched_uclamp_used was enabled after task @p was enqueued,
-	 * we could end up with unbalanced call to uclamp_rq_dec_id().
-	 *
-	 * In this case the uc_se->active flag should be false since no uclamp
-	 * accounting was performed at enqueue time and we can just return
-	 * here.
-	 *
-	 * Need to be careful of the following enqueue/dequeue ordering
-	 * problem too
-	 *
-	 *	enqueue(taskA)
-	 *	// sched_uclamp_used gets enabled
-	 *	enqueue(taskB)
-	 *	dequeue(taskA)
-	 *	// Must not decrement bucket->tasks here
-	 *	dequeue(taskB)
-	 *
-	 * where we could end up with stale data in uc_se and
-	 * bucket[uc_se->bucket_id].
-	 *
-	 * The following check here eliminates the possibility of such race.
-	 */
-	if (unlikely(!uc_se->active))
-		return;
-
-	bucket = &uc_rq->bucket[uc_se->bucket_id];
-
-	SCHED_WARN_ON(!bucket->tasks);
-	if (likely(bucket->tasks))
-		bucket->tasks--;
-
-	uc_se->active = false;
-
-	/*
-	 * Keep "local max aggregation" simple and accept to (possibly)
-	 * overboost some RUNNABLE tasks in the same bucket.
-	 * The rq clamp bucket value is reset to its base value whenever
-	 * there are no more RUNNABLE tasks refcounting it.
-	 */
-	if (likely(bucket->tasks))
-		return;
-
-	rq_clamp = uclamp_rq_get(rq, clamp_id);
-	/*
-	 * Defensive programming: this should never happen. If it happens,
-	 * e.g. due to future modification, warn and fix up the expected value.
-	 */
-	SCHED_WARN_ON(bucket->value > rq_clamp);
-	if (bucket->value >= rq_clamp) {
-		bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
-		uclamp_rq_set(rq, clamp_id, bkt_clamp);
-	}
-}
-
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
-{
-	enum uclamp_id clamp_id;
-
-	/*
-	 * Avoid any overhead until uclamp is actually used by the userspace.
-	 *
-	 * The condition is constructed such that a NOP is generated when
-	 * sched_uclamp_used is disabled.
-	 */
-	if (!static_branch_unlikely(&sched_uclamp_used))
-		return;
-
-	if (unlikely(!p->sched_class->uclamp_enabled))
-		return;
-
-	if (p->se.sched_delayed)
-		return;
-
-	for_each_clamp_id(clamp_id)
-		uclamp_rq_inc_id(rq, p, clamp_id);
+	if (!uclamp_is_used() || !p->uclamp[clamp_id].active)
+		return uclamp_none(clamp_id);
 
-	/* Reset clamp idle holding when there is one RUNNABLE task */
-	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
-		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
+	return p->uclamp[clamp_id].value;
 }
 
-static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
+void uclamp_update_active_nolock(struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
-	/*
-	 * Avoid any overhead until uclamp is actually used by the userspace.
-	 *
-	 * The condition is constructed such that a NOP is generated when
-	 * sched_uclamp_used is disabled.
-	 */
-	if (!static_branch_unlikely(&sched_uclamp_used))
-		return;
-
-	if (unlikely(!p->sched_class->uclamp_enabled))
-		return;
-
-	if (p->se.sched_delayed)
-		return;
-
 	for_each_clamp_id(clamp_id)
-		uclamp_rq_dec_id(rq, p, clamp_id);
-}
-
-static inline void uclamp_rq_reinc_id(struct rq *rq, struct task_struct *p,
-				      enum uclamp_id clamp_id)
-{
-	if (!p->uclamp[clamp_id].active)
-		return;
-
-	uclamp_rq_dec_id(rq, p, clamp_id);
-	uclamp_rq_inc_id(rq, p, clamp_id);
-
-	/*
-	 * Make sure to clear the idle flag if we've transiently reached 0
-	 * active tasks on rq.
-	 */
-	if (clamp_id == UCLAMP_MAX && (rq->uclamp_flags & UCLAMP_FLAG_IDLE))
-		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
+		p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
 }
 
 static inline void
 uclamp_update_active(struct task_struct *p)
 {
-	enum uclamp_id clamp_id;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -1829,14 +1601,7 @@ uclamp_update_active(struct task_struct *p)
 	 */
 	rq = task_rq_lock(p, &rf);
 
-	/*
-	 * Setting the clamp bucket is serialized by task_rq_lock().
-	 * If the task is not yet RUNNABLE and its task_struct is not
-	 * affecting a valid clamp bucket, the next time it's enqueued,
-	 * it will already see the updated clamp bucket value.
-	 */
-	for_each_clamp_id(clamp_id)
-		uclamp_rq_reinc_id(rq, p, clamp_id);
+	uclamp_update_active_nolock(p);
 
 	task_rq_unlock(rq, p, &rf);
 }
@@ -1968,20 +1733,14 @@ static void uclamp_fork(struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
-	/*
-	 * We don't need to hold task_rq_lock() when updating p->uclamp_* here
-	 * as the task is still at its early fork stages.
-	 */
-	for_each_clamp_id(clamp_id)
-		p->uclamp[clamp_id].active = false;
-
-	if (likely(!p->sched_reset_on_fork))
-		return;
-
-	for_each_clamp_id(clamp_id) {
-		uclamp_se_set(&p->uclamp_req[clamp_id],
-			      uclamp_none(clamp_id), false);
+	if (unlikely(p->sched_reset_on_fork)) {
+		for_each_clamp_id(clamp_id) {
+			uclamp_se_set(&p->uclamp_req[clamp_id],
+				      uclamp_none(clamp_id), false);
+		}
 	}
+
+	uclamp_update_active(p);
 }
 
 static void uclamp_post_fork(struct task_struct *p)
@@ -1989,28 +1748,10 @@ static void uclamp_post_fork(struct task_struct *p)
 	uclamp_update_util_min_rt_default(p);
 }
 
-static void __init init_uclamp_rq(struct rq *rq)
-{
-	enum uclamp_id clamp_id;
-	struct uclamp_rq *uc_rq = rq->uclamp;
-
-	for_each_clamp_id(clamp_id) {
-		uc_rq[clamp_id] = (struct uclamp_rq) {
-			.value = uclamp_none(clamp_id)
-		};
-	}
-
-	rq->uclamp_flags = UCLAMP_FLAG_IDLE;
-}
-
 static void __init init_uclamp(void)
 {
 	struct uclamp_se uc_max = {};
 	enum uclamp_id clamp_id;
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		init_uclamp_rq(cpu_rq(cpu));
 
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&init_task.uclamp_req[clamp_id],
@@ -2029,8 +1770,6 @@ static void __init init_uclamp(void)
 }
 
 #else /* !CONFIG_UCLAMP_TASK */
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
-static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_fork(struct task_struct *p) { }
 static inline void uclamp_post_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
@@ -2066,11 +1805,6 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 		update_rq_clock(rq);
 
 	p->sched_class->enqueue_task(rq, p, flags);
-	/*
-	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
-	 * ->sched_delayed.
-	 */
-	uclamp_rq_inc(rq, p);
 
 	psi_enqueue(p, flags);
 
@@ -2097,11 +1831,6 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 	psi_dequeue(p, flags);
 
-	/*
-	 * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
-	 * and mark the task ->sched_delayed.
-	 */
-	uclamp_rq_dec(rq, p);
 	return p->sched_class->dequeue_task(rq, p, flags);
 }
 
@@ -9079,6 +8808,7 @@ void sched_move_task(struct task_struct *tsk)
 
 	sched_change_group(tsk, group);
 	scx_move_task(tsk);
+	uclamp_update_active_nolock(tsk);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -9225,7 +8955,6 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 			if (eff[clamp_id] == uc_se[clamp_id].value)
 				continue;
 			uc_se[clamp_id].value = eff[clamp_id];
-			uc_se[clamp_id].bucket_id = uclamp_bucket_id(eff[clamp_id]);
 			clamps |= (0x1 << clamp_id);
 		}
 		if (!clamps) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3d91dbd19a85..68e7b1ac7a57 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13626,10 +13626,6 @@ DEFINE_SCHED_CLASS(fair) = {
 #ifdef CONFIG_SCHED_CORE
 	.task_is_throttled	= task_is_throttled_fair,
 #endif
-
-#ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
-#endif
 };
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..4cd8d3e06eeb 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2649,10 +2649,6 @@ DEFINE_SCHED_CLASS(rt) = {
 #ifdef CONFIG_SCHED_CORE
 	.task_is_throttled	= task_is_throttled_rt,
 #endif
-
-#ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
-#endif
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b50e3d6e79c4..cfeaefcec8b6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1050,46 +1050,6 @@ extern void rto_push_irq_work_func(struct irq_work *work);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_UCLAMP_TASK
-/*
- * struct uclamp_bucket - Utilization clamp bucket
- * @value: utilization clamp value for tasks on this clamp bucket
- * @tasks: number of RUNNABLE tasks on this clamp bucket
- *
- * Keep track of how many tasks are RUNNABLE for a given utilization
- * clamp value.
- */
-struct uclamp_bucket {
-	unsigned long value : bits_per(SCHED_CAPACITY_SCALE);
-	unsigned long tasks : BITS_PER_LONG - bits_per(SCHED_CAPACITY_SCALE);
-};
-
-/*
- * struct uclamp_rq - rq's utilization clamp
- * @value: currently active clamp values for a rq
- * @bucket: utilization clamp buckets affecting a rq
- *
- * Keep track of RUNNABLE tasks on a rq to aggregate their clamp values.
- * A clamp value is affecting a rq when there is at least one task RUNNABLE
- * (or actually running) with that value.
- *
- * There are up to UCLAMP_CNT possible different clamp values, currently there
- * are only two: minimum utilization and maximum utilization.
- *
- * All utilization clamping values are MAX aggregated, since:
- * - for util_min: we want to run the CPU at least at the max of the minimum
- *   utilization required by its currently RUNNABLE tasks.
- * - for util_max: we want to allow the CPU to run up to the max of the
- *   maximum utilization allowed by its currently RUNNABLE tasks.
- *
- * Since on each system we expect only a limited number of different
- * utilization clamp values (UCLAMP_BUCKETS), use a simple array to track
- * the metrics required to compute all the per-rq utilization clamp values.
- */
-struct uclamp_rq {
-	unsigned int value;
-	struct uclamp_bucket bucket[UCLAMP_BUCKETS];
-};
-
 DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
 #endif /* CONFIG_UCLAMP_TASK */
 
@@ -1126,10 +1086,6 @@ struct rq {
 	u64			nr_switches;
 
 #ifdef CONFIG_UCLAMP_TASK
-	/* Utilization clamp values based on CPU's RUNNABLE tasks */
-	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
-	unsigned int		uclamp_flags;
-#define UCLAMP_FLAG_IDLE 0x01
 #endif
 
 	struct cfs_rq		cfs;
@@ -2409,11 +2365,6 @@ struct affinity_context {
 extern s64 update_curr_common(struct rq *rq);
 
 struct sched_class {
-
-#ifdef CONFIG_UCLAMP_TASK
-	int uclamp_enabled;
-#endif
-
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
 	bool (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task)   (struct rq *rq);
@@ -3393,23 +3344,7 @@ static inline bool update_other_load_avgs(struct rq *rq) { return false; }
 #ifdef CONFIG_UCLAMP_TASK
 
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
-
-static inline unsigned long uclamp_rq_get(struct rq *rq,
-					  enum uclamp_id clamp_id)
-{
-	return READ_ONCE(rq->uclamp[clamp_id].value);
-}
-
-static inline void uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id,
-				 unsigned int value)
-{
-	WRITE_ONCE(rq->uclamp[clamp_id].value, value);
-}
-
-static inline bool uclamp_rq_is_idle(struct rq *rq)
-{
-	return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
-}
+void uclamp_update_active_nolock(struct task_struct *p);
 
 /*
  * When uclamp is compiled in, the aggregation at rq level is 'turned off'
@@ -3437,19 +3372,10 @@ static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
 	return SCHED_CAPACITY_SCALE;
 }
 
-/* Integer rounded range for each bucket */
-#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
-
-static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
-{
-	return min_t(unsigned int, clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
-}
-
 static inline void
 uclamp_se_set(struct uclamp_se *uc_se, unsigned int value, bool user_defined)
 {
 	uc_se->value = value;
-	uc_se->bucket_id = uclamp_bucket_id(value);
 	uc_se->user_defined = user_defined;
 }
 
@@ -3480,26 +3406,11 @@ uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline bool uclamp_is_used(void)
-{
-	return false;
-}
-
-static inline unsigned long
-uclamp_rq_get(struct rq *rq, enum uclamp_id clamp_id)
-{
-	if (clamp_id == UCLAMP_MIN)
-		return 0;
-
-	return SCHED_CAPACITY_SCALE;
-}
-
-static inline void
-uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id, unsigned int value)
+static inline void uclamp_update_active_nolock(struct task_struct *p)
 {
 }
 
-static inline bool uclamp_rq_is_idle(struct rq *rq)
+static inline bool uclamp_is_used(void)
 {
 	return false;
 }
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 9f40348f1dc7..24af915f8d18 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -437,6 +437,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
 	}
+
+	uclamp_update_active_nolock(p);
 }
 
 #else /* !CONFIG_UCLAMP_TASK: */
-- 
2.34.1


