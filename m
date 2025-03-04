Return-Path: <linux-kernel+bounces-544397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCCEA4E0E4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4A63B112E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6412063FF;
	Tue,  4 Mar 2025 14:23:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FAE2066DE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098215; cv=none; b=K+8z6rANozA8V+KLtvVssMVoNemALQQMv2i7QxaOW3nEweXEOb4HW+dsnUQUw3ey6b4hfqQeecCMCqwQGCMTP5ooPJYtL60p3jt0hYGRXTN5LHUYhc4rrTmFEOnbfjp+pc8QRIuwULkFqzFpQe2h1qoquNcX6Gd4UjhwtUZtHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098215; c=relaxed/simple;
	bh=qwOHIjJoK+nAIUIyVranFczSuwcOV87HZG5JpsHbf5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+cYLft7gsajIjcjrtcVUsg3ej+Sb4EiUPMY8xhtWni1uWE+fj8qBs+A/8ov0oG72rEANJZgTFY/BiPo/C9FSm6+4Wa4FH0apenTnDGtFcSrcePwHLJ/MD3CBG8phapsgZl8Luk1bZFAg5pCR4Aveq93FEu1c08/7VV/ppgaMqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 016241C25;
	Tue,  4 Mar 2025 06:23:46 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A15093F66E;
	Tue,  4 Mar 2025 06:23:30 -0800 (PST)
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
Subject: [PATCH v2 2/8] sched/uclamp: Track a new util_avg_bias signal
Date: Tue,  4 Mar 2025 14:23:09 +0000
Message-Id: <24dd7c5800cfca1e7c63e4fab66338f3bdbb1aeb.1741091349.git.hongyan.xia2@arm.com>
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
 include/linux/sched.h |  3 ++-
 kernel/sched/debug.c  |  2 +-
 kernel/sched/fair.c   | 33 +++++++++++++++++++++++++++++++++
 kernel/sched/pelt.c   | 37 +++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  | 24 ++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d..1f3b06aa024d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -487,7 +487,8 @@ struct sched_avg {
 	u32				period_contrib;
 	unsigned long			load_avg;
 	unsigned long			runnable_avg;
-	unsigned long			util_avg;
+	unsigned int			util_avg;
+	int				util_avg_bias;
 	unsigned int			util_est;
 } ____cacheline_aligned;
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ef047add7f9e..264ee83958b5 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -853,7 +853,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->avg.load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_avg",
 			cfs_rq->avg.runnable_avg);
-	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
+	SEQ_printf(m, "  .%-30s: %u\n", "util_avg",
 			cfs_rq->avg.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est",
 			cfs_rq->avg.util_est);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 71fc86eafbd9..438755f55624 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1131,6 +1131,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 	}
 
 	sa->runnable_avg = sa->util_avg;
+	sa->util_avg_bias = 0;
 }
 
 #else /* !CONFIG_SMP */
@@ -4852,6 +4853,32 @@ static inline unsigned long task_util_est(struct task_struct *p)
 	return max(task_util(p), _task_util_est(p));
 }
 
+#ifdef CONFIG_UCLAMP_TASK
+static inline long task_util_bias(struct task_struct *p)
+{
+	return READ_ONCE(p->se.avg.util_avg_bias);
+}
+
+static inline unsigned long task_util_uclamp(struct task_struct *p)
+{
+	long ret = task_util(p);
+
+	ret += task_util_bias(p);
+
+	return max(ret, 0L);
+}
+#else
+static inline long task_util_bias(struct task_struct *p)
+{
+	return 0;
+}
+
+static inline unsigned long task_util_uclamp(struct task_struct *p)
+{
+	return task_util(p);
+}
+#endif
+
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 				    struct task_struct *p)
 {
@@ -7027,6 +7054,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, 1);
+	util_bias_enqueue(rq, p);
+	/* XXX: We should skip the update above and only do it once here. */
+	if (task_util_bias(p) > 0)
+		cpufreq_update_util(rq, 0);
 
 	/*
 	 * Since new tasks are assigned an initial util_avg equal to
@@ -7150,6 +7181,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	}
 
 	sub_nr_running(rq, h_nr_queued);
+	if (p)
+		util_bias_dequeue(rq, p);
 
 	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
 		dl_server_stop(&rq->fair_server);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 7a8534a2deff..f38abe6f0b8b 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -266,6 +266,39 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
 	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
+#ifdef CONFIG_UCLAMP_TASK
+/* avg must belong to the queue this se is on. */
+static void util_bias_update(struct task_struct *p)
+{
+	unsigned int util, uclamp_min, uclamp_max;
+	struct rq *rq;
+	int old, new;
+
+	util = READ_ONCE(p->se.avg.util_avg);
+	uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
+	uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
+	/*
+	 * uclamp_max at the max value means there is no uclamp_max, and should
+	 * not have any clamping effect at all here.
+	 */
+	if (uclamp_max == SCHED_CAPACITY_SCALE)
+		uclamp_max = UINT_MAX;
+	old = READ_ONCE(p->se.avg.util_avg_bias);
+	new = (int)clamp(util, uclamp_min, uclamp_max) - (int)util;
+
+	WRITE_ONCE(p->se.avg.util_avg_bias, new);
+	if (!p->se.on_rq)
+		return;
+	rq = task_rq(p);
+	WRITE_ONCE(rq->cfs.avg.util_avg_bias,
+		   READ_ONCE(rq->cfs.avg.util_avg_bias) + new - old);
+}
+#else /* !CONFIG_UCLAMP_TASK */
+static void util_bias_update(struct task_struct *p)
+{
+}
+#endif
+
 /*
  * sched_entity:
  *
@@ -296,6 +329,8 @@ int __update_load_avg_blocked_se(u64 now, struct sched_entity *se)
 {
 	if (___update_load_sum(now, &se->avg, 0, 0, 0)) {
 		___update_load_avg(&se->avg, se_weight(se));
+		if (entity_is_task(se))
+			util_bias_update(task_of(se));
 		trace_pelt_se_tp(se);
 		return 1;
 	}
@@ -310,6 +345,8 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 
 		___update_load_avg(&se->avg, se_weight(se));
 		cfs_se_util_change(&se->avg);
+		if (entity_is_task(se))
+			util_bias_update(task_of(se));
 		trace_pelt_se_tp(se);
 		return 1;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ab16d3d0e51c..74363bc74e23 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3468,6 +3468,22 @@ uclamp_se_set(struct uclamp_se *uc_se, unsigned int value, bool user_defined)
 	uc_se->user_defined = user_defined;
 }
 
+static inline void util_bias_enqueue(struct rq *rq, struct task_struct *p)
+{
+	int rq_val = READ_ONCE(rq->cfs.avg.util_avg_bias);
+	int p_val = READ_ONCE(p->se.avg.util_avg_bias);
+
+	WRITE_ONCE(rq->cfs.avg.util_avg_bias, rq_val + p_val);
+}
+
+static inline void util_bias_dequeue(struct rq *rq, struct task_struct *p)
+{
+	int rq_val = READ_ONCE(rq->cfs.avg.util_avg_bias);
+	int p_val = READ_ONCE(p->se.avg.util_avg_bias);
+
+	WRITE_ONCE(rq->cfs.avg.util_avg_bias, rq_val - p_val);
+}
+
 #else /* !CONFIG_UCLAMP_TASK: */
 
 static inline unsigned long
@@ -3505,6 +3521,14 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 	return false;
 }
 
+static inline void util_bias_enqueue(struct rq *rq, struct task_struct *p)
+{
+}
+
+static inline void util_bias_dequeue(struct rq *rq, struct task_struct *p)
+{
+}
+
 #endif /* !CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-- 
2.34.1


