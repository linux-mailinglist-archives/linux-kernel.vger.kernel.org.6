Return-Path: <linux-kernel+bounces-308663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EC7966003
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CED71F24115
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C71B150F;
	Fri, 30 Aug 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVO252cL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946C1AF4EC
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015874; cv=none; b=KH216mtETbDanYvykGHCqLzboIt4Yj0tXQzH2UT7TQbpQSmbIaony2ro2z1yNhcsejYSKH3f+yT89WyjwqC85zpBB0Ky8Q7BWkG106uKdIPTuRtOPRbX/d4xN2muDeXXFNLLCovmV+3vNFVHxbQ9HGYACn8b6wco9V5rIcwaZ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015874; c=relaxed/simple;
	bh=A+Zgv3uKRyKTnSQFssqPQLgmV36zhCAyhrympNlWjxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtiHKWyhD9z498tvy/Mz3AbOLbbK+NNMf/vVw0xwtq2q1hutp9kJHp1+88rIIvdZaIQfKbrP5h6MNhx1DxktsEDnwvGZtfxP5sODcN8WqeDGMwCWJM++u75ZLdMkbgxqXi1IBdbfnd7lSGT51+AKQHVYvlqLDki15i85bkK2hqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVO252cL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DB4C4CEC4;
	Fri, 30 Aug 2024 11:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015874;
	bh=A+Zgv3uKRyKTnSQFssqPQLgmV36zhCAyhrympNlWjxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVO252cLZLzRk7dszrwB8naAdpVPpaQQhRbltghcc+oDG3gXbePw2RH82DwVvSIAC
	 aGVwwgnmATqpXhViXLz5PjPvE32/xhcBiGxC287CS0zDX/q/9xc6eHsLYpXa1p8Z3T
	 2W2+VGVj9nMZL0vu3ETfRP7nh5P6ZQfmUn7cH7WnTmyLMhUYmJVghY3fbOE6NjooFd
	 5Em2Ohh18602Flf+I0jqCvhBXoKCda2EsXJPALkEB5do4p7latHscfy8CClmR3WilH
	 1o0yPzyaeGbB0J4y0WqpiY73KM494MAWnnh82WLOx3pAcDyQGTIToAi3IKJ0A2KUX/
	 9jm4+UnsC8iew==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/11] sched_ext: Replace consume_local_task() with move_local_task_to_local_dsq()
Date: Fri, 30 Aug 2024 01:03:53 -1000
Message-ID: <20240830110415.116090-10-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830110415.116090-1-tj@kernel.org>
References: <20240830110415.116090-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Rename move_task_to_local_dsq() to move_remote_task_to_local_dsq().

- Rename consume_local_task() to move_local_task_to_local_dsq() and remove
  task_unlink_from_dsq() and source DSQ unlocking from it.

This is to make the migration code easier to reuse.

No functional changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 51d141602a11..df33524d68f3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2103,23 +2103,30 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 		return false;
 }
 
-static void consume_local_task(struct task_struct *p,
-			       struct scx_dispatch_q *dsq, struct rq *rq)
+static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
+					 struct scx_dispatch_q *src_dsq,
+					 struct rq *dst_rq)
 {
-	lockdep_assert_held(&dsq->lock);	/* released on return */
+	struct scx_dispatch_q *dst_dsq = &dst_rq->scx.local_dsq;
+
+	/* @dsq is locked and @p is on @dst_rq */
+	lockdep_assert_held(&src_dsq->lock);
+	lockdep_assert_rq_held(dst_rq);
 
-	/* @dsq is locked and @p is on this rq */
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
-	task_unlink_from_dsq(p, dsq);
-	list_add_tail(&p->scx.dsq_list.node, &rq->scx.local_dsq.list);
-	dsq_mod_nr(&rq->scx.local_dsq, 1);
-	p->scx.dsq = &rq->scx.local_dsq;
-	raw_spin_unlock(&dsq->lock);
+
+	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
+		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
+	else
+		list_add_tail(&p->scx.dsq_list.node, &dst_dsq->list);
+
+	dsq_mod_nr(dst_dsq, 1);
+	p->scx.dsq = dst_dsq;
 }
 
 #ifdef CONFIG_SMP
 /**
- * move_task_to_local_dsq - Move a task from a different rq to a local DSQ
+ * move_remote_task_to_local_dsq - Move a task from a foreign rq to a local DSQ
  * @p: task to move
  * @enq_flags: %SCX_ENQ_*
  * @src_rq: rq to move the task from, locked on entry, released on return
@@ -2127,8 +2134,8 @@ static void consume_local_task(struct task_struct *p,
  *
  * Move @p which is currently on @src_rq to @dst_rq's local DSQ.
  */
-static void move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
-				   struct rq *src_rq, struct rq *dst_rq)
+static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
+					  struct rq *src_rq, struct rq *dst_rq)
 {
 	lockdep_assert_rq_held(src_rq);
 
@@ -2251,7 +2258,7 @@ static bool consume_remote_task(struct rq *this_rq, struct task_struct *p,
 	raw_spin_rq_unlock(this_rq);
 
 	if (unlink_dsq_and_lock_task_rq(p, dsq, task_rq)) {
-		move_task_to_local_dsq(p, 0, task_rq, this_rq);
+		move_remote_task_to_local_dsq(p, 0, task_rq, this_rq);
 		return true;
 	} else {
 		raw_spin_rq_unlock(task_rq);
@@ -2282,7 +2289,9 @@ static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
 		struct rq *task_rq = task_rq(p);
 
 		if (rq == task_rq) {
-			consume_local_task(p, dsq, rq);
+			task_unlink_from_dsq(p, dsq);
+			move_local_task_to_local_dsq(p, 0, dsq, rq);
+			raw_spin_unlock(&dsq->lock);
 			return true;
 		}
 
@@ -2362,13 +2371,14 @@ static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
 		/*
 		 * If @p is staying on the same rq, there's no need to go
 		 * through the full deactivate/activate cycle. Optimize by
-		 * abbreviating the operations in move_task_to_local_dsq().
+		 * abbreviating move_remote_task_to_local_dsq().
 		 */
 		if (src_rq == dst_rq) {
 			p->scx.holding_cpu = -1;
 			dispatch_enqueue(&dst_rq->scx.local_dsq, p, enq_flags);
 		} else {
-			move_task_to_local_dsq(p, enq_flags, src_rq, dst_rq);
+			move_remote_task_to_local_dsq(p, enq_flags,
+						      src_rq, dst_rq);
 		}
 
 		/* if the destination CPU is idle, wake it up */
-- 
2.46.0


