Return-Path: <linux-kernel+bounces-521259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BEFA3BAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E743B981A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38CA1C549E;
	Wed, 19 Feb 2025 09:38:26 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42C158862
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957906; cv=none; b=HjbfHMpfuJePkVYRMtkEoMvS0OKPGvE5AoZjov+z00mO3SWH6dnKtF85t0Vsc6wezaDNOI/S0MvWE5OzgZk8ExziYWgWixOQHDAWxWAeZPnn8PosjS/3cPTBMbjft+Fb1VrfwhKUkkRizZYgb1wKYsrgvmp+KqtzOBoheuCGSEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957906; c=relaxed/simple;
	bh=ysn8Ps0vO2OODTfoa/COI0o36WWXjzc7jOD3tFpkkpU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=btU4m5bGVhdq6MvQyTHmwm9PIKVm/3m9CmXgetDjaKmsksEGQQ7Er2AxQKyzgU+ehEmgcG53NWxkhrf9kAGQz9m8t2ALO/bI5KnIepAzWTGUpEr4jcGXzs3IKv2LaIKf+78KT348pZkcQIu1JAXX7b8LVJdIgp2E5a0GetrpUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 51J9c5d3052013;
	Wed, 19 Feb 2025 17:38:05 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4YyWRX4Vf0z2SR95B;
	Wed, 19 Feb 2025 17:33:44 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 19 Feb 2025 17:38:03 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>, <christian.loehle@arm.com>,
        <hongyan.xia2@arm.com>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] sched/uclamp: Always using uclamp_is_used()
Date: Wed, 19 Feb 2025 17:37:46 +0800
Message-ID: <20250219093747.2612-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 51J9c5d3052013

Now, we have the uclamp_is_used() func to judge the uclamp enabled,
so replace the static_branch_unlikely(&sched_uclamp_used) with it.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
V2:
- Correct the spelling mistakes in the commit message (Hongyan)
- Add Reviewed-by
---
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/sched.h | 28 ++++++++++++++--------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd914ac69..38a7192bfc19 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1757,7 +1757,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 	 * The condition is constructed such that a NOP is generated when
 	 * sched_uclamp_used is disabled.
 	 */
-	if (!static_branch_unlikely(&sched_uclamp_used))
+	if (!uclamp_is_used())
 		return;
 
 	if (unlikely(!p->sched_class->uclamp_enabled))
@@ -1784,7 +1784,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 	 * The condition is constructed such that a NOP is generated when
 	 * sched_uclamp_used is disabled.
 	 */
-	if (!static_branch_unlikely(&sched_uclamp_used))
+	if (!uclamp_is_used())
 		return;
 
 	if (unlikely(!p->sched_class->uclamp_enabled))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b93c8c3dc05a..3624fdce5536 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3394,6 +3394,19 @@ static inline bool update_other_load_avgs(struct rq *rq) { return false; }
 
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
+/*
+ * When uclamp is compiled in, the aggregation at rq level is 'turned off'
+ * by default in the fast path and only gets turned on once userspace performs
+ * an operation that requires it.
+ *
+ * Returns true if userspace opted-in to use uclamp and aggregation at rq level
+ * hence is active.
+ */
+static inline bool uclamp_is_used(void)
+{
+	return static_branch_likely(&sched_uclamp_used);
+}
+
 static inline unsigned long uclamp_rq_get(struct rq *rq,
 					  enum uclamp_id clamp_id)
 {
@@ -3417,7 +3430,7 @@ static inline bool uclamp_rq_is_capped(struct rq *rq)
 	unsigned long rq_util;
 	unsigned long max_util;
 
-	if (!static_branch_likely(&sched_uclamp_used))
+	if (!uclamp_is_used())
 		return false;
 
 	rq_util = cpu_util_cfs(cpu_of(rq)) + cpu_util_rt(rq);
@@ -3426,19 +3439,6 @@ static inline bool uclamp_rq_is_capped(struct rq *rq)
 	return max_util != SCHED_CAPACITY_SCALE && rq_util >= max_util;
 }
 
-/*
- * When uclamp is compiled in, the aggregation at rq level is 'turned off'
- * by default in the fast path and only gets turned on once userspace performs
- * an operation that requires it.
- *
- * Returns true if userspace opted-in to use uclamp and aggregation at rq level
- * hence is active.
- */
-static inline bool uclamp_is_used(void)
-{
-	return static_branch_likely(&sched_uclamp_used);
-}
-
 #define for_each_clamp_id(clamp_id) \
 	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
 
-- 
2.25.1


