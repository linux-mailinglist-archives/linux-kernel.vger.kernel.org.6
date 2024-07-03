Return-Path: <linux-kernel+bounces-239196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF139257E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694101F24725
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2A3142629;
	Wed,  3 Jul 2024 10:07:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB413D2BE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001275; cv=none; b=HRqltLsRkdqRCji8mLggjydpnjIoLD/a847N0hrybPRU2JgvW8gW+QXcOjLRMDb0HVlghdDiwIaw6sGlAgK0NBUPiD8wUwA/QRPoBuYUQaert+uw6h0bbJlGWziAjN3HhCyGB3T0A4zK4do6R/Yo6EwhNzh/UdbTs6uKruZdO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001275; c=relaxed/simple;
	bh=rx5RnTU+kGBmxxatiIrk+TX3fJ4/GceRbwqeJB9OxDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qWAiyb+Ttk8dXXvLRhHay/C33xOk5oysih18hS6MA0yEinneEYWTJzHzeJ8IqBA163ydjAE7mmqGYM6M7ZHj3Z4WX9MwBnpXM8PpBTCu3mPjCM58E+uxf8RDOBv5xVFZnNzKXBu8ZP2v6YMQ2x5xmcnFJ6ZaWD206Sum9s3O4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B23A1007;
	Wed,  3 Jul 2024 03:08:18 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D507F3F766;
	Wed,  3 Jul 2024 03:07:52 -0700 (PDT)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched/uclamp: Delegate uclamp to each sched_class
Date: Wed,  3 Jul 2024 11:07:47 +0100
Message-Id: <45e58e2fe1f72d6c095c8824c7da696edfd80bd7.1719999165.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719999165.git.hongyan.xia2@arm.com>
References: <cover.1719999165.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uclamp-related operations are written in core.c in a way that may
suggest it is a global thing regardless of sched_class, but we end up
checking sched_class->uclamp_enabled, so in reality it is sched_class
specific anyway.

Remove sched_class->uclamp_enabled and simply delegate uclamp to
sched_class->{enqueue,dequeue}_task(). This also removes extra
uclamp_enabled checks in uclamp_rq_{inc,dec}().

No functional changes for fair and RT.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
---
 kernel/sched/core.c  | 14 ++------------
 kernel/sched/ext.c   |  4 ----
 kernel/sched/fair.c  |  6 ++----
 kernel/sched/rt.c    |  7 +++----
 kernel/sched/sched.h | 15 +++++++++++----
 5 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1092955a7d6e..5c5e5aefca81 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1671,7 +1671,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	}
 }
 
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
+void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
@@ -1684,9 +1684,6 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 	if (!static_branch_unlikely(&sched_uclamp_used))
 		return;
 
-	if (unlikely(!p->sched_class->uclamp_enabled))
-		return;
-
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_inc_id(rq, p, clamp_id);
 
@@ -1695,7 +1692,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
 }
 
-static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
+void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
@@ -1708,9 +1705,6 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 	if (!static_branch_unlikely(&sched_uclamp_used))
 		return;
 
-	if (unlikely(!p->sched_class->uclamp_enabled))
-		return;
-
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
@@ -1949,8 +1943,6 @@ static void __init init_uclamp(void)
 }
 
 #else /* !CONFIG_UCLAMP_TASK */
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
-static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_fork(struct task_struct *p) { }
 static inline void uclamp_post_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
@@ -1990,7 +1982,6 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
 	}
 
-	uclamp_rq_inc(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
 
 	if (sched_core_enabled(rq))
@@ -2010,7 +2001,6 @@ void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_dequeue(p, flags & DEQUEUE_SLEEP);
 	}
 
-	uclamp_rq_dec(rq, p);
 	p->sched_class->dequeue_task(rq, p, flags);
 }
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ae9ec8f542f2..0b120104a7ce 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3520,10 +3520,6 @@ DEFINE_SCHED_CLASS(ext) = {
 	.prio_changed		= prio_changed_scx,
 
 	.update_curr		= update_curr_scx,
-
-#ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
-#endif
 };
 
 static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d59537416865..a861fafd53f9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6752,6 +6752,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 
+	uclamp_rq_inc(rq, p);
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
 	 * the cfs_rq utilization to select a frequency.
@@ -6846,6 +6847,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
 
+	uclamp_rq_dec(rq, p);
 	util_est_dequeue(&rq->cfs, p);
 
 	for_each_sched_entity(se) {
@@ -13227,10 +13229,6 @@ DEFINE_SCHED_CLASS(fair) = {
 #ifdef CONFIG_SCHED_CORE
 	.task_is_throttled	= task_is_throttled_fair,
 #endif
-
-#ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
-#endif
 };
 
 #ifdef CONFIG_SCHED_DEBUG
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 63e49c8ffc4d..f0b3ba5e8867 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1480,6 +1480,8 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 
+	uclamp_rq_inc(rq, p);
+
 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
 
@@ -1496,6 +1498,7 @@ static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 
+	uclamp_rq_dec(rq, p);
 	update_curr_rt(rq);
 	dequeue_rt_entity(rt_se, flags);
 
@@ -2680,10 +2683,6 @@ DEFINE_SCHED_CLASS(rt) = {
 #ifdef CONFIG_SCHED_CORE
 	.task_is_throttled	= task_is_throttled_rt,
 #endif
-
-#ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 1,
-#endif
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 963a2fa180ad..619b1cc972bd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2340,10 +2340,6 @@ extern s64 update_curr_common(struct rq *rq);
 
 struct sched_class {
 
-#ifdef CONFIG_UCLAMP_TASK
-	int uclamp_enabled;
-#endif
-
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task)   (struct rq *rq);
@@ -3246,6 +3242,9 @@ uclamp_se_set(struct uclamp_se *uc_se, unsigned int value, bool user_defined)
 	uc_se->user_defined = user_defined;
 }
 
+void uclamp_rq_inc(struct rq *rq, struct task_struct *p);
+void uclamp_rq_dec(struct rq *rq, struct task_struct *p);
+
 #else /* !CONFIG_UCLAMP_TASK: */
 
 static inline unsigned long
@@ -3283,6 +3282,14 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 	return false;
 }
 
+static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
+{
+}
+
+static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
+{
+}
+
 #endif /* !CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-- 
2.34.1


