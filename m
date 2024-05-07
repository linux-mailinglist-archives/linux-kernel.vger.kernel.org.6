Return-Path: <linux-kernel+bounces-171311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 914338BE281
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B515C1C21822
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B00815E201;
	Tue,  7 May 2024 12:50:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDC015E1E8
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086249; cv=none; b=EqAEWKhKATxnE7w4kVA3+lMzw/buLW+Nc4b+FLev9bDIihya9e3uMQDp2nkorcmb2CGe4O/MXtjS9phz1lYy/6Y6qm56Ayg9MSWA1OtKuxQnmhnyr+rrsZ9dWA+9U1MQ9Y1zJsy9fXpCG72IUWnEpN0K9vcyAeP3k694rY4vY5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086249; c=relaxed/simple;
	bh=W18vkwRzbgTeWCm4DZe4LjfYOaydQtyE26fKzYQQdyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dz6ttslw8klpAo1ybC3fVwC79pkeixNEN6F/iiNxdBmSJwHzvvf3drSvAQvemvi5WDviyIeNgsopREbQQI2UseFsLFgyiOt3fBT3f00XU5r1Ly3WipicWFOssgBZnj4HvrH/1nu9nRsYjlXmN7S5XT1U/VD3YlGvQnIrpN2lSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3616E1515;
	Tue,  7 May 2024 05:51:13 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33DFD3F793;
	Tue,  7 May 2024 05:50:45 -0700 (PDT)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: [RFC PATCH v3 2/6] sched/uclamp: Track a new util_avg_bias signal
Date: Tue,  7 May 2024 13:50:25 +0100
Message-Id: <2e43dc6b376ea6d785976a398b5d9ffe823cf35d.1715082714.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715082714.git.hongyan.xia2@arm.com>
References: <cover.1715082714.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a util_avg_bias signal in sched_avg, which is obtained by:

util_avg_bias = clamp(util_avg, uclamp_min, uclamp_max) - util_avg

The task utilization after considering uclamp is;

util_avg_uclamp = util_avg + util_avg_bias

We then sum up all biases on the same rq and use the total bias to bias
the rq utilization. This is the core idea of uclamp sum aggregation. The
rq utilization will be

rq_util_avg_uclamp = rq_util_avg + total_util_avg_bias

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 include/linux/sched.h |  4 +++-
 kernel/sched/debug.c  |  2 +-
 kernel/sched/fair.c   | 16 ++++++++++++++++
 kernel/sched/pelt.c   | 39 +++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  | 28 ++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c75fd46506df..4ea4b8b30f54 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -476,8 +476,10 @@ struct sched_avg {
 	u32				period_contrib;
 	unsigned long			load_avg;
 	unsigned long			runnable_avg;
-	unsigned long			util_avg;
+	unsigned int			util_avg;
+	int				util_avg_bias;
 	unsigned int			util_est;
+	unsigned int			util_est_uclamp;
 } ____cacheline_aligned;
 
 /*
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834d..c4dadb740e96 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -682,7 +682,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->avg.load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_avg",
 			cfs_rq->avg.runnable_avg);
-	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
+	SEQ_printf(m, "  .%-30s: %u\n", "util_avg",
 			cfs_rq->avg.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est",
 			cfs_rq->avg.util_est);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef5bb576ac65..571c8de59508 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1083,6 +1083,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 	}
 
 	sa->runnable_avg = sa->util_avg;
+	sa->util_avg_bias = 0;
 }
 
 #else /* !CONFIG_SMP */
@@ -6801,6 +6802,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, 1);
+	util_bias_enqueue(&rq->cfs.avg, p);
+	/* XXX: We should skip the update above and only do it once here. */
+	cpufreq_update_util(rq, 0);
 
 	/*
 	 * Since new tasks are assigned an initial util_avg equal to
@@ -6892,6 +6896,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	/* At this point se is NULL and we are at root level*/
 	sub_nr_running(rq, 1);
+	util_bias_dequeue(&rq->cfs.avg, p);
+	/* XXX: We should skip the update above and only do it once here. */
+	cpufreq_update_util(rq, 0);
 
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
@@ -6900,6 +6907,15 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
+
+#ifdef CONFIG_UCLAMP_TASK
+	if (rq->cfs.h_nr_running == 0) {
+		WARN_ONCE(rq->cfs.avg.util_avg_bias,
+			"0 tasks on CFS of CPU %d, but util_avg_bias is %d\n",
+			rq->cpu, rq->cfs.avg.util_avg_bias);
+		WRITE_ONCE(rq->cfs.avg.util_avg_bias, 0);
+	}
+#endif
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index ef00382de595..56346988182f 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -266,6 +266,40 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
 	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
+#ifdef CONFIG_UCLAMP_TASK
+/* avg must belong to the queue this se is on. */
+static void update_util_bias(struct sched_avg *avg, struct task_struct *p)
+{
+	unsigned int util, uclamp_min, uclamp_max;
+	int old, new;
+
+	/*
+	 * We MUST update the rq summed total every time we update the
+	 * util_avg_bias of a task. If we are on a rq but we are not given the
+	 * rq, then the best thing is to just skip this update.
+	 */
+	if (p->se.on_rq && !avg)
+		return;
+
+	util = READ_ONCE(p->se.avg.util_avg);
+	uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
+	uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
+	if (uclamp_max == SCHED_CAPACITY_SCALE)
+		uclamp_max = UINT_MAX;
+	old = READ_ONCE(p->se.avg.util_avg_bias);
+	new = (int)clamp(util, uclamp_min, uclamp_max) - (int)util;
+
+	WRITE_ONCE(p->se.avg.util_avg_bias, new);
+	if (!p->se.on_rq)
+		return;
+	WRITE_ONCE(avg->util_avg_bias, READ_ONCE(avg->util_avg_bias) + new - old);
+}
+#else /* !CONFIG_UCLAMP_TASK */
+static void update_util_bias(struct sched_avg *avg, struct task_struct *p)
+{
+}
+#endif
+
 /*
  * sched_entity:
  *
@@ -296,6 +330,8 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
 	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
 		___update_load_avg(&se->avg, se_weight(se));
+		if (entity_is_task(se))
+			update_util_bias(NULL, task_of(se));
 		trace_pelt_se_tp(se);
 		return 1;
 	}
@@ -310,6 +346,9 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 
 		___update_load_avg(&se->avg, se_weight(se));
 		cfs_se_util_change(&se->avg);
+		if (entity_is_task(se))
+			update_util_bias(&rq_of(cfs_rq)->cfs.avg,
+					 task_of(se));
 		trace_pelt_se_tp(se);
 		return 1;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cb3792c04eea..aec812e6c6ba 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3095,6 +3095,24 @@ static inline bool uclamp_is_used(void)
 {
 	return static_branch_likely(&sched_uclamp_used);
 }
+
+static inline void util_bias_enqueue(struct sched_avg *avg,
+				     struct task_struct *p)
+{
+	int avg_val = READ_ONCE(avg->util_avg_bias);
+	int p_val = READ_ONCE(p->se.avg.util_avg_bias);
+
+	WRITE_ONCE(avg->util_avg_bias, avg_val + p_val);
+}
+
+static inline void util_bias_dequeue(struct sched_avg *avg,
+				     struct task_struct *p)
+{
+	int avg_val = READ_ONCE(avg->util_avg_bias);
+	int p_val = READ_ONCE(p->se.avg.util_avg_bias);
+
+	WRITE_ONCE(avg->util_avg_bias, avg_val - p_val);
+}
 #else /* CONFIG_UCLAMP_TASK */
 static inline unsigned long uclamp_eff_value(struct task_struct *p,
 					     enum uclamp_id clamp_id)
@@ -3130,6 +3148,16 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 {
 	return false;
 }
+
+static inline void util_bias_enqueue(struct sched_avg *avg,
+				     struct task_struct *p)
+{
+}
+
+static inline void util_bias_dequeue(struct sched_avg *avg,
+				     struct task_struct *p)
+{
+}
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-- 
2.34.1


