Return-Path: <linux-kernel+bounces-523023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0320A3D111
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDB53B887C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325D61B2194;
	Thu, 20 Feb 2025 06:00:27 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381EC18DB24
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031226; cv=none; b=W5WPG71DK2KQ0Q+3hOyKMf4IMPjBnzlPM1Rw5o8gMzu4JipSZQBSLEfdt2s05W5FomDc+9RP/8PACuoXIE+uKgYGS6hbfclVUWnfYI1WEI+aSn/sxJhyHEn8zjiW2qDOnL0S3Dxl/4fXXumWVuubNQCzonw2vcANKJm3ko1/zA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031226; c=relaxed/simple;
	bh=50OeJhZ6DTzJltF9I+ydzVlF1UMknlf/ZqFvRZQNCnw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aZQch0f2oc7oWNJu36lCSufwx0ACdjVo0984eV3NoqIMQ2c+ii9q64fZxC676weoCL766hn6MzhMEiK4PvjI03lYxAnahxV1Gks35olgByil8TS3ebPdQNgNnOd12E9dllOqX1BoU0NHhuh+F7531+3DI88mcoDJwG8X0eD13UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 51K6038p039842;
	Thu, 20 Feb 2025 14:00:03 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Yz2YR457Cz2SVGgs;
	Thu, 20 Feb 2025 13:55:39 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 20 Feb 2025 14:00:00 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <christian.loehle@arm.com>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>, <hongyan.xia2@arm.com>,
        <ke.wang@unisoc.com>, <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] sched/uclamp: Always using uclamp_is_used()
Date: Thu, 20 Feb 2025 13:59:49 +0800
Message-ID: <20250220055950.4405-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 51K6038p039842

Now, we have the uclamp_is_used() func to judge the uclamp enabled,
so replace the static_branch_unlikely(&sched_uclamp_used) with it.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
V3:
- no change.
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


