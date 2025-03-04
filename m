Return-Path: <linux-kernel+bounces-544402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B92BA4E0D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B4A17B1C4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8412F207A3B;
	Tue,  4 Mar 2025 14:23:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1D207A2A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098229; cv=none; b=pfEbiD3JG0kbs+OGBSIJruhrOhGm9ChvjYamvJtEFvMYCKhMaA3WDGZ4o2Odo2T2cYr+eSPWXp1wCflyeVTbgjgvqeR2Uyg6q5V7qQDzpID1XZl3/xvfCLQDbq1XB7yf7z/CL0cG2hYvQkk4vqpF2r7hH5HhwBwTpVIEoXNillI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098229; c=relaxed/simple;
	bh=ePyTVUHpYXKRFzTNY0Q7NWvN8OyPJ3n0fcbMve5YEMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eaaM710DbPcshkiNVOPxx4L/XTUeo9c5QUtTRs0sheMPiCE8Zhb/VkejUpEhnErq5jS9p1obLElXJA30eRcnnXCSe6oQVXm9yfSZQTHtkbJ3CM2kEnl/4xP8zuu/KBkRK7qfAdypxzLa0URDDN+u+uKqEv4ZEj4bm5DcmA0oyPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 758D7FEC;
	Tue,  4 Mar 2025 06:24:00 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 219013F66E;
	Tue,  4 Mar 2025 06:23:45 -0800 (PST)
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
Subject: [PATCH v2 7/8] sched/uclamp: Propagate negative bias
Date: Tue,  4 Mar 2025 14:23:14 +0000
Message-Id: <53749ecebbed9ef59f6f0fea9c8a8daec0733d68.1741091349.git.hongyan.xia2@arm.com>
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

Negative bias is interesting, because dequeuing such a task will
actually increase utilization.

Solve by applying PELT decay to negative biases as well. This in fact
can be implemented easily with some math tricks.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/fair.c  | 46 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  4 ++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 68e7b1ac7a57..944953b90297 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4886,6 +4886,48 @@ static inline unsigned long root_cfs_util_uclamp(struct rq *rq)
 
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
+
+		p->se.avg.util_avg_bias = 0;
+
+		for_each_sched_entity(se) {
+			struct sched_avg *sa = &se->avg;
+			u32 divider = get_pelt_divider(sa);
+
+			sub_positive(&sa->util_avg, neg_bias);
+			sub_positive(&sa->util_sum, neg_bias * divider);
+			sa->util_sum = max_t(u32, sa->util_sum,
+					     sa->util_avg * PELT_MIN_DIVIDER);
+			sa = &cfs_rq_of(se)->avg;
+			divider = get_pelt_divider(sa);
+			sub_positive(&sa->util_avg, neg_bias);
+			sub_positive(&sa->util_sum, neg_bias * divider);
+			sa->util_sum = max_t(u32, sa->util_sum,
+					     sa->util_avg * PELT_MIN_DIVIDER);
+		}
+	}
+}
 #else
 static inline long task_util_bias(struct task_struct *p)
 {
@@ -7114,8 +7156,10 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	}
 
 	sub_nr_running(rq, h_nr_queued);
-	if (p)
+	if (p) {
 		util_bias_dequeue(rq, p);
+		propagate_negative_bias(p);
+	}
 
 	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
 		dl_server_stop(&rq->fair_server);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f4a82e6cc029..654eede62979 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3431,6 +3431,10 @@ static inline void util_bias_dequeue(struct rq *rq, struct task_struct *p)
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


