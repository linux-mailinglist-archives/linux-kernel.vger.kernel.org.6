Return-Path: <linux-kernel+bounces-310313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE2596797E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EC01F21A40
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB48186E3A;
	Sun,  1 Sep 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUNxZ0YA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CA186616
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209070; cv=none; b=TOmRx+taxdcgByL+g+dCkKmzwAp7APS/aGPUvX9QrTfqTvC/pEqdhgPJoXMvW4tYsjeIQSARm06fs3sjeGUWzew3lsJvgBk8WI73uDKAB4ksg3BL13n+qir/aerc+/1scDr7ni953aT5TOO9eNlD7xtxHBVAIt6vQkEnlVNf/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209070; c=relaxed/simple;
	bh=1WtLDTUQh/E486qjcgepqFoBiwq5i+k2WT1aoAemAx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jevIiMxLUMOvZAAQBglXgbQHJzWW8rNSQMCSXlDWf8Xi2+Lye8O7GKKQKBcKJEw3ywFPWWSoIX8lGK2pDHjLNushEJBsRh9iu50VhcBcYm4UbaXOfyWpYBskZh84Ui0dA/E8uXIXMwFTWJ1RiafvZnj5YlzkYYl+8sCetj/IOeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUNxZ0YA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2626C4CEC9;
	Sun,  1 Sep 2024 16:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725209069;
	bh=1WtLDTUQh/E486qjcgepqFoBiwq5i+k2WT1aoAemAx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dUNxZ0YASeDQERLSFzXnvkORAaLV2uu8GF0nrubDDAqfvlqT9PUYBWggbMuEOgNHl
	 UlR/5llCD6LbfK1AAif7NfcTybWTw07axiGr13E44iGx3BZ+CZPYjVdCITGDlw8C9b
	 O4dbV1/dho4cPhn+11KRUz7DbBUs7BMhaPVziKW+pjNQd6JqX6BQv7EMl/vUbsto1M
	 74+Ry1SWzzzkJFFetMVjyyzhuhunAtmWQ5ekmJiYS3cG7PmELlniAD8azXx8XZ6b40
	 ADFRQiZiKFdCNDxBN0kXGlp3FUkmNIcj5cmzvgQa9l1pLyvX300edvwGNUxgofyAOY
	 wcLIRm5CujjvQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/12] sched_ext: Replace consume_local_task() with move_local_task_to_local_dsq()
Date: Sun,  1 Sep 2024 06:43:46 -1000
Message-ID: <20240901164417.779239-10-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901164417.779239-1-tj@kernel.org>
References: <20240901164417.779239-1-tj@kernel.org>
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
Acked-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e0bc4851b6e2..d50166a2651a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2101,23 +2101,30 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
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
@@ -2125,8 +2132,8 @@ static void consume_local_task(struct task_struct *p,
  *
  * Move @p which is currently on @src_rq to @dst_rq's local DSQ.
  */
-static void move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
-				   struct rq *src_rq, struct rq *dst_rq)
+static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
+					  struct rq *src_rq, struct rq *dst_rq)
 {
 	lockdep_assert_rq_held(src_rq);
 
@@ -2249,7 +2256,7 @@ static bool consume_remote_task(struct rq *this_rq, struct task_struct *p,
 	raw_spin_rq_unlock(this_rq);
 
 	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
-		move_task_to_local_dsq(p, 0, src_rq, this_rq);
+		move_remote_task_to_local_dsq(p, 0, src_rq, this_rq);
 		return true;
 	} else {
 		raw_spin_rq_unlock(src_rq);
@@ -2280,7 +2287,9 @@ static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
 		struct rq *task_rq = task_rq(p);
 
 		if (rq == task_rq) {
-			consume_local_task(p, dsq, rq);
+			task_unlink_from_dsq(p, dsq);
+			move_local_task_to_local_dsq(p, 0, dsq, rq);
+			raw_spin_unlock(&dsq->lock);
 			return true;
 		}
 
@@ -2360,13 +2369,14 @@ static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
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


