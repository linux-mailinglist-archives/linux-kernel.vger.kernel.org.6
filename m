Return-Path: <linux-kernel+bounces-384182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174739B25BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF53B20B44
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8D318FC91;
	Mon, 28 Oct 2024 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IBjsIpy0"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916518EFC8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097209; cv=none; b=XzAvjQgY2ixXL7ww9xcPcysy4Rcr2Dlm8S8zDUuljex0Pc6ZTnsP4trb9PeaaXyp8Cy9QY/Ur/MTyc/Lpf3G+l7a0GqCHsrEgXbjQgdoE1jDiAhPlDbxpX0L8FQPlXBGRuQvsvm2TfWOaVQMkATPYT2GCLC+nLK8PMt4RjTIh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097209; c=relaxed/simple;
	bh=aJmD+tzdn01sv2C6XDzn8Lk5Uk2O6OVaSH9KogPf4Do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LH8pLH2msUKpW3sQnny+5ZYWcmzgWVzXQs6a2KYe+tfaQO5BnMVIZw/8OiVZY1N2uPTRa+SWXjkS/GewiMj+VbiQa/BTdDR7I+xhxuhdQVMmicwgh2IWt7SRtDDUtmoTKcjPuubaomN+9ZqNYlZ0vIxuzfICrX3sA/g3QXUrSn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IBjsIpy0; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730097202; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kXhxi8wlkLTFyQw0e7Djk5fqlJWVa3qjZsZmcjrORCk=;
	b=IBjsIpy0QU2Lfy2jPR1urLC3bEeg/S5G3TltGzmvsRplDorU/XVXDBU6mbFepGV+gFMChkv8tpt628tdEWtcR5aB7GNiQyt/Hm6QUq3amB6156FAI0kmgpC4imF60M6KL/lpko/gTOgBjg/q+2f2MmTN1FmBzTrfu2aomy8b7qQ=
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WI.X8v4_1730097201 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 14:33:21 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [RFC PATCH 2/2] sched/eevdf: Introduce a cgroup interface for slice
Date: Mon, 28 Oct 2024 14:33:13 +0800
Message-Id: <20241028063313.8039-3-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241028063313.8039-1-dtcccc@linux.alibaba.com>
References: <20241028063313.8039-1-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce "cpu.fair_slice" for cgroup v2 and "cpu.fair_slice_us" for v1
according to their name styles. The unit is always microseconds.

A cgroup with shorter slice can preempt others more easily. This could be
useful in container scenarios.

By default, cpu.fair_slice is 0, which means the slice of se is
calculated by min_slice from its cfs_rq. If cpu.fair_slice is set, it
will overwrite se->slice with the customized value.

Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
CC Tejun, do we need (and reuse) this slice interface for sched_ext?
---
 kernel/sched/core.c  | 34 ++++++++++++++++++++++++++++++
 kernel/sched/fair.c  | 49 +++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h |  3 +++
 3 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 114adac5a9c8..8d57b7d88d18 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9690,6 +9690,24 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 }
 #endif
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static u64 cpu_fair_slice_read_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cft)
+{
+	u64 fair_slice_us = css_tg(css)->slice;
+
+	do_div(fair_slice_us, NSEC_PER_USEC);
+
+	return fair_slice_us;
+}
+
+static int cpu_fair_slice_write_u64(struct cgroup_subsys_state *css,
+				    struct cftype *cftype, u64 fair_slice_us)
+{
+	return sched_group_set_slice(css_tg(css), fair_slice_us);
+}
+#endif
+
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_GROUP_SCHED_WEIGHT
 	{
@@ -9703,6 +9721,14 @@ static struct cftype cpu_legacy_files[] = {
 		.write_s64 = cpu_idle_write_s64,
 	},
 #endif
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	{
+		.name = "fair_slice_us",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_fair_slice_read_u64,
+		.write_u64 = cpu_fair_slice_write_u64,
+	},
+#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "cfs_quota_us",
@@ -9943,6 +9969,14 @@ static struct cftype cpu_files[] = {
 		.write_s64 = cpu_idle_write_s64,
 	},
 #endif
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	{
+		.name = "fair_slice",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_fair_slice_read_u64,
+		.write_u64 = cpu_fair_slice_write_u64,
+	},
+#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "max",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7dc90a6e6e26..694dc0655719 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -797,6 +797,11 @@ static inline u64 cfs_rq_min_slice(struct cfs_rq *cfs_rq)
 	return min_slice;
 }
 
+static inline u64 cfs_rq_slice(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->tg->slice ? : cfs_rq_min_slice(cfs_rq);
+}
+
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
 {
 	return entity_before(__node_2_se(a), __node_2_se(b));
@@ -6994,7 +6999,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			se->custom_slice = 1;
 		}
 		enqueue_entity(cfs_rq, se, flags);
-		slice = cfs_rq_min_slice(cfs_rq);
+		slice = cfs_rq_slice(cfs_rq);
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
@@ -7018,7 +7023,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		se->slice = slice;
 		min_vruntime_cb_propagate(&se->run_node, NULL);
-		slice = cfs_rq_min_slice(cfs_rq);
+		slice = cfs_rq_slice(cfs_rq);
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
@@ -7093,7 +7098,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		idle_h_nr_running = task_has_idle_policy(p);
 	} else {
 		cfs_rq = group_cfs_rq(se);
-		slice = cfs_rq_min_slice(cfs_rq);
+		slice = cfs_rq_slice(cfs_rq);
 	}
 
 	for_each_sched_entity(se) {
@@ -7118,7 +7123,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
-			slice = cfs_rq_min_slice(cfs_rq);
+			slice = cfs_rq_slice(cfs_rq);
 
 			/* Avoid re-evaluating load for this entity: */
 			se = parent_entity(se);
@@ -7143,7 +7148,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		se->slice = slice;
 		min_vruntime_cb_propagate(&se->run_node, NULL);
-		slice = cfs_rq_min_slice(cfs_rq);
+		slice = cfs_rq_slice(cfs_rq);
 
 		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
@@ -13535,6 +13540,40 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	return 0;
 }
 
+int sched_group_set_slice(struct task_group *tg, u64 fair_slice_us)
+{
+	u64 slice = 0;
+	int i;
+
+	if (fair_slice_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+
+	if (fair_slice_us) {
+		slice = clamp_t(u64, fair_slice_us * NSEC_PER_USEC,
+				NSEC_PER_MSEC / 10,	/* HZ = 1000 * 10 */
+				NSEC_PER_MSEC * 100);	/* HZ = 100 / 10 */
+	}
+
+	if (slice == tg->slice)
+		return 0;
+
+	tg->slice = slice;
+
+	for_each_possible_cpu(i) {
+		struct sched_entity *se = tg->se[i];
+		struct rq *rq = cpu_rq(i);
+
+		guard(rq_lock_irqsave)(rq);
+		for_each_sched_entity(se) {
+			se->custom_slice = 1;
+			se->slice = cfs_rq_slice(group_cfs_rq(se));
+			min_vruntime_cb_propagate(&se->run_node, NULL);
+		}
+	}
+
+	return 0;
+}
+
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7b139016cbd9..e02f8715bc04 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -443,6 +443,7 @@ struct task_group {
 	/* runqueue "owned" by this group on each CPU */
 	struct cfs_rq		**cfs_rq;
 	unsigned long		shares;
+	u64			slice;
 #ifdef	CONFIG_SMP
 	/*
 	 * load_avg can be heavily contended at clock tick time, so put
@@ -574,6 +575,8 @@ extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
+extern int sched_group_set_slice(struct task_group *tg, u64 fair_slice_us);
+
 #ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);
-- 
2.39.3


