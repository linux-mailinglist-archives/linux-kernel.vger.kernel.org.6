Return-Path: <linux-kernel+bounces-544398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3508A4E0C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37572165A5D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749012063D3;
	Tue,  4 Mar 2025 14:23:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4F0206F01
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098217; cv=none; b=eo8TKRTsH99GeywJnKxkAoIWd6owzwcgya6eJ75rNxemAZDD2iBGhKdLj/ZDeL1hQO4IL5MbhxYGQsC/oA7LfJX+o8j4fWRlYGyg+N7bb7BqH75OqD2gUQPimTzTefFXZ9d9iIHGwwujZ8HUtgH9VAqiYTYcqfZV4sJ2C1IMjS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098217; c=relaxed/simple;
	bh=gF/kBpcoYSDf4gxMDlpN07XcjBl9f1gdlaUeSadBZ5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z31CCA4vQ3YgBBvWFPwFhHYWND0R1+yGKqOMGYmYfAwwOQeJM87r3ac0X9nR5x1ehLvZrkg28zs3VX3GiIoZ+J25jEJhByD+kIAI8H+qL5tx/hNJorWage+Ke88YA+jDMgVpfrFH/J4UivCG+XkPa10JZG/jbMPf29CtIOFDA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F52EFEC;
	Tue,  4 Mar 2025 06:23:48 -0800 (PST)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AF953F66E;
	Tue,  4 Mar 2025 06:23:33 -0800 (PST)
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
Subject: [PATCH v2 3/8] sched/uclamp: Add util_est_uclamp
Date: Tue,  4 Mar 2025 14:23:10 +0000
Message-Id: <723859b17ea463f91e04c87696b6d38ea2839deb.1741091349.git.hongyan.xia2@arm.com>
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

The new util_est_uclamp is essentially clamp(util_est, min, max) and
follows how util_est operates.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/fair.c   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1f3b06aa024d..a4bdfa1d6be1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -490,6 +490,7 @@ struct sched_avg {
 	unsigned int			util_avg;
 	int				util_avg_bias;
 	unsigned int			util_est;
+	unsigned int			util_est_uclamp;
 } ____cacheline_aligned;
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 438755f55624..e9aa93f99a4e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4867,6 +4867,16 @@ static inline unsigned long task_util_uclamp(struct task_struct *p)
 
 	return max(ret, 0L);
 }
+
+static inline unsigned long _task_util_est_uclamp(struct task_struct *p)
+{
+	return READ_ONCE(p->se.avg.util_est_uclamp);
+}
+
+static inline unsigned long task_util_est_uclamp(struct task_struct *p)
+{
+	return max(task_util_uclamp(p), _task_util_est_uclamp(p));
+}
 #else
 static inline long task_util_bias(struct task_struct *p)
 {
@@ -4877,6 +4887,16 @@ static inline unsigned long task_util_uclamp(struct task_struct *p)
 {
 	return task_util(p);
 }
+
+static inline unsigned long _task_util_est_uclamp(struct task_struct *p)
+{
+	return _task_util_est(p);
+}
+
+static inline unsigned long task_util_est_uclamp(struct task_struct *p)
+{
+	return task_util_est(p);
+}
 #endif
 
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
@@ -4891,6 +4911,9 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 	enqueued  = cfs_rq->avg.util_est;
 	enqueued += _task_util_est(p);
 	WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
+	enqueued  = cfs_rq->avg.util_est_uclamp;
+	enqueued += _task_util_est_uclamp(p);
+	WRITE_ONCE(cfs_rq->avg.util_est_uclamp, enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
@@ -4907,6 +4930,9 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
 	enqueued  = cfs_rq->avg.util_est;
 	enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));
 	WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
+	enqueued  = cfs_rq->avg.util_est_uclamp;
+	enqueued -= _task_util_est_uclamp(p);
+	WRITE_ONCE(cfs_rq->avg.util_est_uclamp, enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
@@ -4994,6 +5020,10 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	ewma  -= last_ewma_diff;
 	ewma >>= UTIL_EST_WEIGHT_SHIFT;
 done:
+	WRITE_ONCE(p->se.avg.util_est_uclamp,
+		   clamp(ewma,
+			 (unsigned int)uclamp_eff_value(p, UCLAMP_MIN),
+			 (unsigned int)uclamp_eff_value(p, UCLAMP_MAX)));
 	ewma |= UTIL_AVG_UNCHANGED;
 	WRITE_ONCE(p->se.avg.util_est, ewma);
 
-- 
2.34.1


