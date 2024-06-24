Return-Path: <linux-kernel+bounces-227024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1857D91475E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D03E1F24808
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2483613790F;
	Mon, 24 Jun 2024 10:24:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5601D137904
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224651; cv=none; b=VIdcgi1ShecidLZ1+afP8s+xxlgBw7W/P5CAkigsveaIe/9+OwbjYHyKltITmJpu8YKAT7yjyCVN5m2jFrqA1Y550Vq7+brLzxdtFFOKID5JBfhoza0rDd8hqrFUsfFuFNxfXatxUZkP4tcEC9qaU94+JfW5IydeOjzFxCnaFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224651; c=relaxed/simple;
	bh=X2aDfNQVEg4IgBUI1QgLufrrmUjBVes4+C6giy6UdMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aXgJYRpNo8vmwX+RcFtXVEHIpkwupj8yjTWBdo1cFlTDtIprTuSRpDwQ9QYP6WYfiTS9E+zFKp7OSbYHLUoghN62yQlraVDg5Fnk/iB0JPzN7GUykf4I2Yl9DEdfkQAdor9pr6zGu6A/dCbTnl2PVqaDrBmjGpheGzqz736wJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66BE7113E;
	Mon, 24 Jun 2024 03:24:33 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 839C23F766;
	Mon, 24 Jun 2024 03:24:06 -0700 (PDT)
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
	Pierre Gondois <pierre.gondois@arm.com>,
	Youssef Esmat <youssefesmat@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] sched/uclamp: Track a new util_avg_bias signal
Date: Mon, 24 Jun 2024 11:23:51 +0100
Message-Id: <85519f7a06e7a59dca644baca10b78c85749c1b5.1719223916.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719223916.git.hongyan.xia2@arm.com>
References: <cover.1719223916.git.hongyan.xia2@arm.com>
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
 kernel/sched/fair.c   | 31 +++++++++++++++++++++++++++++++
 kernel/sched/pelt.c   | 37 +++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  | 24 ++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 90691d99027e..63bcb81b20bb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -476,7 +476,8 @@ struct sched_avg {
 	u32				period_contrib;
 	unsigned long			load_avg;
 	unsigned long			runnable_avg;
-	unsigned long			util_avg;
+	unsigned int			util_avg;
+	int				util_avg_bias;
 	unsigned int			util_est;
 } ____cacheline_aligned;
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c1eb9a1afd13..d416be6e3a83 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -683,7 +683,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->avg.load_avg);
 	SEQ_printf(m, "  .%-30s: %lu\n", "runnable_avg",
 			cfs_rq->avg.runnable_avg);
-	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
+	SEQ_printf(m, "  .%-30s: %u\n", "util_avg",
 			cfs_rq->avg.util_avg);
 	SEQ_printf(m, "  .%-30s: %u\n", "util_est",
 			cfs_rq->avg.util_est);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f8ed6561a9f..23360c666829 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1089,6 +1089,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 	}
 
 	sa->runnable_avg = sa->util_avg;
+	sa->util_avg_bias = 0;
 }
 
 #else /* !CONFIG_SMP */
@@ -4844,6 +4845,32 @@ static inline unsigned long task_util_est(struct task_struct *p)
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
@@ -6807,6 +6834,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	/* At this point se is NULL and we are at root level*/
 	add_nr_running(rq, 1);
+	util_bias_enqueue(rq, p);
+	/* XXX: We should skip the update above and only do it once here. */
+	cpufreq_update_util(rq, 0);
 
 	/*
 	 * Since new tasks are assigned an initial util_avg equal to
@@ -6898,6 +6928,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	/* At this point se is NULL and we are at root level*/
 	sub_nr_running(rq, 1);
+	util_bias_dequeue(rq, p);
 
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index fa52906a4478..11aa845d212c 100644
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
index 62fd8bc6fd08..5f93a6b1b563 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3178,6 +3178,22 @@ uclamp_se_set(struct uclamp_se *uc_se, unsigned int value, bool user_defined)
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
@@ -3215,6 +3231,14 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
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


