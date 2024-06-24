Return-Path: <linux-kernel+bounces-227030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517A491476B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821741C23347
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E913B2B0;
	Mon, 24 Jun 2024 10:24:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABA013AA2C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224667; cv=none; b=KJfbEt6RekzdfA7gYcgjEFF9inSNrepPWR0btuQScpe7897Wb9VJS47dClnqhzDOHMMN+I/aSD5wJiDTanSufBaaNvP2hOTLKQhPF3RptxFjshnirwJ9OGiWJrAg/hhwSlvOmSb3W7jnEs2mFZsflEErw/wOnRWvozV05xqUiTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224667; c=relaxed/simple;
	bh=cQws8ortMF+x3AGFx4Uqqj8FnUiGqPelfHlVhi+4xhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BzCcis+qZwpV0szsvG9DoxT8QnZvOG+vfhvgK8ZseLaVrNTjKr5fHKhNAb9sNTWBSRGr/tJIxRYzuveRyQLXmDOhVcBvJMabSAK6W3RUjY2Etq1tenFVF4YDG9mggIkfn19B4lECNpCqlCSmSgAPuRNBJtMWo8BpFS63YWzQjiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5188FDA7;
	Mon, 24 Jun 2024 03:24:50 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7122E3F766;
	Mon, 24 Jun 2024 03:24:23 -0700 (PDT)
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
Subject: [PATCH 7/7] Propagate negative bias
Date: Mon, 24 Jun 2024 11:23:56 +0100
Message-Id: <60985d07acd8a2daf4f3adf31ce4bf3be2982306.1719223916.git.hongyan.xia2@arm.com>
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

Negative bias is interesting, because dequeuing such a task will
actually increase utilization.

Solve by applying PELT decay to negative biases as well. This in fact
can be implemented easily with some math tricks.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  4 ++++
 2 files changed, 44 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3bb077df52ae..d09af6abf464 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4878,6 +4878,45 @@ static inline unsigned long root_cfs_util_uclamp(struct rq *rq)
 
 	return max(ret, 0L);
 }
+
+/*
+ * Negative biases are tricky. If we remove them right away then dequeuing a
+ * uclamp_max task has the interesting effect that dequeuing results in a higher
+ * rq utilization. Solve this by applying PELT decay to the bias itself.
+ *
+ * Keeping track of a PELT-decayed negative bias is extra overhead. However, we
+ * observe this interesting math property, where y is the decay factor and p is
+ * the number of periods elapsed:
+ *
+ *	util_new = util_old * y^p - neg_bias * y^p
+ *		 = (util_old - neg_bias) * y^p
+ *
+ * Therefore, we simply subtract the negative bias from util_avg the moment we
+ * dequeue, then the PELT signal itself is the total of util_avg and the decayed
+ * negative bias, and we no longer need to track the decayed bias separately.
+ */
+static void propagate_negative_bias(struct task_struct *p)
+{
+	if (task_util_bias(p) < 0 && !task_on_rq_migrating(p)) {
+		unsigned long neg_bias = -task_util_bias(p);
+		struct sched_entity *se = &p->se;
+		struct cfs_rq *cfs_rq;
+
+		p->se.avg.util_avg_bias = 0;
+
+		for_each_sched_entity(se) {
+			u32 divider, neg_sum;
+
+			cfs_rq = cfs_rq_of(se);
+			divider = get_pelt_divider(&cfs_rq->avg);
+			neg_sum = neg_bias * divider;
+			sub_positive(&se->avg.util_avg, neg_bias);
+			sub_positive(&se->avg.util_sum, neg_sum);
+			sub_positive(&cfs_rq->avg.util_avg, neg_bias);
+			sub_positive(&cfs_rq->avg.util_sum, neg_sum);
+		}
+	}
+}
 #else
 static inline long task_util_bias(struct task_struct *p)
 {
@@ -6869,6 +6908,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	/* At this point se is NULL and we are at root level*/
 	sub_nr_running(rq, 1);
 	util_bias_dequeue(rq, p);
+	propagate_negative_bias(p);
 
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 59e5ea421a4c..9d14ef9c717e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3140,6 +3140,10 @@ static inline void util_bias_dequeue(struct rq *rq, struct task_struct *p)
 {
 }
 
+static inline void propagate_negative_bias(struct task_struct *p)
+{
+}
+
 #endif /* !CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-- 
2.34.1


