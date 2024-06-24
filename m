Return-Path: <linux-kernel+bounces-227025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECD591475F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A231284CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D315137C36;
	Mon, 24 Jun 2024 10:24:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B42C1369A7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224654; cv=none; b=L20AlMrwzhEegsFgLBcxtlvxUHmZjZzSn9MHdniHcJy69GhsEU5lSyMYP7dCFlGZmEjyOlPRxj6lf/jR7ZW0+SGJcm5ghBca+3Pw7r4MjyFuDqQMXubENgxrUsCyxnbCTXJ9tqYW1UX4QNlQTxXe7pe4AczNsY9NKVRtn6OUjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224654; c=relaxed/simple;
	bh=ONpgqyi1Co8BYmXFUGQYubc5DOmD5HMOV0F0PQ9jeX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bW8LiWS9/ipCxfsm5kcem/8xNIUrL3JqKlqMZlJoHL4KoklicM8+39Xzs6m7FbnxpVLz4eDvZLp7UHFpv4NpepXTnV/7ZR3iVm14sEJ/FEqglQTRH0hr/i0BsaDBGxC0t1dRMV+qTzBjCKzFSeH9xkBpVykLFSYKpO2xywMbEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56DEADA7;
	Mon, 24 Jun 2024 03:24:36 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7732D3F766;
	Mon, 24 Jun 2024 03:24:09 -0700 (PDT)
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
Subject: [PATCH 3/7] sched/uclamp: Add util_est_uclamp
Date: Mon, 24 Jun 2024 11:23:52 +0100
Message-Id: <6db7769986b58c278bef743785f1ff7a348b0d88.1719223916.git.hongyan.xia2@arm.com>
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

The new util_est_uclamp is essentially clamp(util_est, min, max) and
follows how util_est operates.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/fair.c   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 63bcb81b20bb..0160567314ae 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -479,6 +479,7 @@ struct sched_avg {
 	unsigned int			util_avg;
 	int				util_avg_bias;
 	unsigned int			util_est;
+	unsigned int			util_est_uclamp;
 } ____cacheline_aligned;
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23360c666829..0fa48466e02e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4859,6 +4859,16 @@ static inline unsigned long task_util_uclamp(struct task_struct *p)
 
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
@@ -4869,6 +4879,16 @@ static inline unsigned long task_util_uclamp(struct task_struct *p)
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
@@ -4883,6 +4903,9 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 	enqueued  = cfs_rq->avg.util_est;
 	enqueued += _task_util_est(p);
 	WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
+	enqueued  = cfs_rq->avg.util_est_uclamp;
+	enqueued += _task_util_est_uclamp(p);
+	WRITE_ONCE(cfs_rq->avg.util_est_uclamp, enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
@@ -4899,6 +4922,9 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
 	enqueued  = cfs_rq->avg.util_est;
 	enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));
 	WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
+	enqueued  = cfs_rq->avg.util_est_uclamp;
+	enqueued -= min_t(unsigned int, enqueued, _task_util_est_uclamp(p));
+	WRITE_ONCE(cfs_rq->avg.util_est_uclamp, enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
@@ -4986,6 +5012,10 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
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


