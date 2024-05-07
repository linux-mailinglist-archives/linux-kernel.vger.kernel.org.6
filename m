Return-Path: <linux-kernel+bounces-171315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C08BE287
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD2328C8C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4D515E813;
	Tue,  7 May 2024 12:51:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6826B15E5CC
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086262; cv=none; b=jBAzLGJPjMmoS/sR51UDDn+O/u7iRv9dalT+w3QCeV4GUL/M9bmtNOVDgZY1f9WLnXtSnrXihXqd/dmfDoEhQuKeJBk1SX1o2QRqvOkeeOyn777dw5dVbx6lg6Lu71j52/YhdYNW/xFLpUqrlcrLVlyy01kzE1JOQdTjI2SsJFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086262; c=relaxed/simple;
	bh=kCOFTh2w1NJO+h53GHlkLLXq/I3SCktxk8/Z5w+DA04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i77hMn9ZR8OLmJ58b/sYVLzQLZ2lnngsJG69Lgt0e9gOcbZzYgaTFzOuCwtO3rpCEAoM8sSdaJ2tkfcd0ELfUNrhDPghX3TM/68Yui/2yyZhibTDSqOAiqsvqL7syLwZj/YhCexKDpftryfEC2nP0w8gXM4d7i2Xz1apFzcg1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4AC31063;
	Tue,  7 May 2024 05:51:26 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1EF83F793;
	Tue,  7 May 2024 05:50:58 -0700 (PDT)
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
Subject: [RFC PATCH v3 6/6] Propagate negative bias
Date: Tue,  7 May 2024 13:50:29 +0100
Message-Id: <f60a29ac1af5098e0d37d426aec27db05d5d43e1.1715082714.git.hongyan.xia2@arm.com>
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

Negative bias is interesting, because dequeuing such a task will
actually increase utilization.

Solve by applying PELT decay to negative biases as well. This in fact
can be implemented easily with some math tricks.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/fair.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0177d7e8f364..7259a61e9ae5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4863,6 +4863,45 @@ static inline unsigned long task_util_est_uclamp(struct task_struct *p)
 {
 	return max(task_util_uclamp(p), _task_util_est_uclamp(p));
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
@@ -4883,6 +4922,10 @@ static inline unsigned long task_util_est_uclamp(struct task_struct *p)
 {
 	return task_util_est(p);
 }
+
+static void propagate_negative_bias(struct task_struct *p)
+{
+}
 #endif
 
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
@@ -6844,6 +6887,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	/* At this point se is NULL and we are at root level*/
 	sub_nr_running(rq, 1);
 	util_bias_dequeue(&rq->cfs.avg, p);
+	propagate_negative_bias(p);
 	/* XXX: We should skip the update above and only do it once here. */
 	cpufreq_update_util(rq, 0);
 
-- 
2.34.1


