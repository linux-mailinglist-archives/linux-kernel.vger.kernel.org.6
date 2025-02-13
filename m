Return-Path: <linux-kernel+bounces-512577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F7AA33AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428B2188D45A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D120D4FC;
	Thu, 13 Feb 2025 09:16:30 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD420D4F2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438190; cv=none; b=NrZeK6EiadopjH1f1nTuEaLkpkbwHyRT1RLMxYhelZJwdpkhJ5Ak5KK1JIDWAZnW20zX7wwlPEEr9dExBPi4RQezacfbD4ypBBsti5YfDQfCWTzEO675tsUN4RmEFoBQ6xWfwsE+hLVm3Bwjg1rsGvBAovQSWIbDWYWNPsrMrK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438190; c=relaxed/simple;
	bh=SrbPKHU6Zc9z3xk8GW7dms8xnnUi3DUyQCLUdW3knsA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VizqndwTP1jskEXGgt+YSK1P6nLftygeO7ke0hDccA5H/ilwb1PWTOAEiVCgNu6VJ6v/yYF8gWsZ68KT5L5NgQvs7Mt2NTJmVidr198x0Bo0MBtK8uy8j5k/1M0eQi3CSL+5wSYrVc5IwQlrTKew9rzHHxD5ILO4/BaL1YFEgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 51D9Fxs0077971;
	Thu, 13 Feb 2025 17:15:59 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4YtqF15GfXz2RysxG;
	Thu, 13 Feb 2025 17:11:49 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 13 Feb 2025 17:15:56 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>, <qyousef@layalina.io>,
        <ke.wang@unisoc.com>, <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] sched/uclamp: Alaways using uclamp_is_used()
Date: Thu, 13 Feb 2025 17:15:53 +0800
Message-ID: <20250213091554.2593-1-xuewen.yan@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 51D9Fxs0077971

Now, we have the uclamp_is_used() func to judge the uclamp enabled,
so replace the static_branch_unlikely(&sched_uclamp_used) with it.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/sched.h | 28 ++++++++++++++--------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 165c90ba64ea..841147759ec7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1756,7 +1756,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 	 * The condition is constructed such that a NOP is generated when
 	 * sched_uclamp_used is disabled.
 	 */
-	if (!static_branch_unlikely(&sched_uclamp_used))
+	if (!uclamp_is_used())
 		return;
 
 	if (unlikely(!p->sched_class->uclamp_enabled))
@@ -1783,7 +1783,7 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 	 * The condition is constructed such that a NOP is generated when
 	 * sched_uclamp_used is disabled.
 	 */
-	if (!static_branch_unlikely(&sched_uclamp_used))
+	if (!uclamp_is_used())
 		return;
 
 	if (unlikely(!p->sched_class->uclamp_enabled))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 38e0e323dda2..f5de05354d80 100644
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


