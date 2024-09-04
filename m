Return-Path: <linux-kernel+bounces-314476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E81D096B3D8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65AF286EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B616718453A;
	Wed,  4 Sep 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ2a8SAP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D3917CA1D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437011; cv=none; b=MSQK6B0F9PjVHt71FeKLJF597f4NydeiJz71ZmYG+YG0Kd1jfCgMqtc/ReYoUeHhNHvgJEh1j5Ntv69kqImZt6Lq+de85shor95b7HzNVQxU8VcVyyakRuoy6F/XztV4+a1hNIvcBBwHIK5zpZMib7HtGkCXIaRCAkk996CIbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437011; c=relaxed/simple;
	bh=BXic2p9wXJnZ2duok0r9rHSnYrtnr0OS+zC/qBewzzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg3W7elQOpToD4AHhpb0MJLbfIJnHj8jCP2tpjrTCn6lbxDlPrNUDcjDDr6Az+J61mroeNFjX2Bc6aWUtC0Z1P6PL5ux7Mwg+Cv4LfLKiG90bUAsT716zoAriPw4bRuUHFRCLmQF6g5DP44Bh5P1kNNMeqkUBmzKDcIKPOu5hHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ2a8SAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88930C4CEC5;
	Wed,  4 Sep 2024 08:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725437010;
	bh=BXic2p9wXJnZ2duok0r9rHSnYrtnr0OS+zC/qBewzzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQ2a8SAP7DzhueKB8L9njV2BXG44jPWEqSjOHzBmO1v7cvelQhtQIAzS2YLan6F3/
	 VhYCKcdY1FCHt4cudE7xXdsRSeETydgoFoy3E7enCyduxdDk0Kc5AqH+Cmuib44kpL
	 V6Ywj9Iz6zkjSeGd6CVhQPxjI6Grp0GlO4pb14AjpL03AYErRqORCw3pqaYlrsxWdz
	 o2ntuN2ja9RG/L1aFfoLt5rjH9DavXx6l4fGOqyaZeqXjFpCRvZ13YHRL8PvIknDNk
	 mMl+7gZIKCw++OHCmROB8PJZGrli7enZXZqV9CSlt74ACTuLVfHpfd1i4buHMy40IM
	 sE1qTeRRXzDWQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] sched_ext: Replace SCX_TASK_BAL_KEEP with SCX_RQ_BAL_KEEP
Date: Tue,  3 Sep 2024 22:03:04 -1000
Message-ID: <20240904080326.1132275-3-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904080326.1132275-1-tj@kernel.org>
References: <20240904080326.1132275-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCX_TASK_BAL_KEEP is used by balance_one() to tell pick_next_task_scx() to
keep running the current task. It's not really a task property. Replace it
with SCX_RQ_BAL_KEEP which resides in rq->scx.flags and is a better fit for
the usage. Also, the existing clearing rule is unnecessarily strict and
makes it difficult to use with core-sched. Just clear it on entry to
balance_one().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  1 -
 kernel/sched/ext.c        | 20 +++++++++-----------
 kernel/sched/sched.h      |  1 +
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 69f68e2121a8..db2a266113ac 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -71,7 +71,6 @@ struct scx_dispatch_q {
 /* scx_entity.flags */
 enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
-	SCX_TASK_BAL_KEEP	= 1 << 1, /* balance decided to keep current */
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index be86dbfa75a8..fd979c69de1f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2508,6 +2508,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 
 	lockdep_assert_rq_held(rq);
 	rq->scx.flags |= SCX_RQ_IN_BALANCE;
+	rq->scx.flags &= ~SCX_RQ_BAL_KEEP;
 
 	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
 	    unlikely(rq->scx.cpu_released)) {
@@ -2523,7 +2524,6 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 	}
 
 	if (prev_on_scx) {
-		WARN_ON_ONCE(local && (prev->scx.flags & SCX_TASK_BAL_KEEP));
 		update_curr_scx(rq);
 
 		/*
@@ -2538,13 +2538,13 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 		 *
 		 * When balancing a remote CPU for core-sched, there won't be a
 		 * following put_prev_task_scx() call and we don't own
-		 * %SCX_TASK_BAL_KEEP. Instead, pick_task_scx() will test the
-		 * same conditions later and pick @rq->curr accordingly.
+		 * %SCX_RQ_BAL_KEEP. Instead, pick_task_scx() will test the same
+		 * conditions later and pick @rq->curr accordingly.
 		 */
 		if ((prev->scx.flags & SCX_TASK_QUEUED) &&
 		    prev->scx.slice && !scx_ops_bypassing()) {
 			if (local)
-				prev->scx.flags |= SCX_TASK_BAL_KEEP;
+				rq->scx.flags |= SCX_RQ_BAL_KEEP;
 			goto has_tasks;
 		}
 	}
@@ -2604,7 +2604,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
 	    (!static_branch_unlikely(&scx_ops_enq_last) || scx_ops_bypassing())) {
 		if (local)
-			prev->scx.flags |= SCX_TASK_BAL_KEEP;
+			rq->scx.flags |= SCX_RQ_BAL_KEEP;
 		goto has_tasks;
 	}
 	rq->scx.flags &= ~SCX_RQ_IN_BALANCE;
@@ -2726,8 +2726,6 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, true);
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
-		p->scx.flags &= ~SCX_TASK_BAL_KEEP;
-
 		set_task_runnable(rq, p);
 
 		/*
@@ -2772,8 +2770,8 @@ static struct task_struct *pick_next_task_scx(struct rq *rq,
 	 * if necessary and keep running @prev. Otherwise, pop the first one
 	 * from the local DSQ.
 	 */
-	if (prev->scx.flags & SCX_TASK_BAL_KEEP) {
-		prev->scx.flags &= ~SCX_TASK_BAL_KEEP;
+	if ((rq->scx.flags & SCX_RQ_BAL_KEEP) &&
+	    !WARN_ON_ONCE(prev->sched_class != &ext_sched_class)) {
 		p = prev;
 		if (!p->scx.slice)
 			p->scx.slice = SCX_SLICE_DFL;
@@ -2841,7 +2839,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
  *
  * As put_prev_task_scx() hasn't been called on remote CPUs, we can't just look
  * at the first task in the local dsq. @rq->curr has to be considered explicitly
- * to mimic %SCX_TASK_BAL_KEEP.
+ * to mimic %SCX_RQ_BAL_KEEP.
  */
 static struct task_struct *pick_task_scx(struct rq *rq)
 {
@@ -3872,7 +3870,7 @@ bool task_should_scx(struct task_struct *p)
  *
  * b. ops.dispatch() is ignored.
  *
- * c. balance_scx() does not set %SCX_TASK_BAL_KEEP on non-zero slice as slice
+ * c. balance_scx() does not set %SCX_RQ_BAL_KEEP on non-zero slice as slice
  *    can't be trusted. Whenever a tick triggers, the running task is rotated to
  *    the tail of the queue with core_sched_at touched.
  *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1eda2ce31787..477e7a861d10 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -737,6 +737,7 @@ enum scx_rq_flags {
 	 */
 	SCX_RQ_ONLINE		= 1 << 0,
 	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
+	SCX_RQ_BAL_KEEP		= 1 << 2, /* balance decided to keep current */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_BALANCE	= 1 << 17,
-- 
2.46.0


