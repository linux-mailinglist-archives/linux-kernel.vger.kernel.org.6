Return-Path: <linux-kernel+bounces-308659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDCB966032
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8C44B29E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C6E1ACDE2;
	Fri, 30 Aug 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdKefLn6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC71A7AF7
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015870; cv=none; b=LE/dxO97u9NT8RTpm8BwQ9epf7kratUzRFa83+nV+kwQ6HJRX66dIdi/U8S50j0n1CPDLOOAiuhMvxwXiz0XxPJT0bdjLplTPHa/v4KBvT31oVpuG/SSQFm6uPdf30ewtTPVKYtHQWVv9j1Sm2ACKa8FVKeBvNoDBoVB8iLz3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015870; c=relaxed/simple;
	bh=FdbMCMkMwm3rR96jij5c4cOhkqYsmcCvziuz+/6uQKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWcJFmsmPJj6aFzckAO1ITdTwCtMEQBcpsPT6PkBZQfKNSdswUlJ+2iN6nipu+sUDFVF8se0JRtC1oqd45XlBadW0lJUQz9qJVcUSZ0obKr/FhHHLixtRYU7PIPHG4LPjB+y55MaYGvlPWHGkHQH8IvuPR97zydZbaRYHiWLzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdKefLn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251A0C4CEC2;
	Fri, 30 Aug 2024 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015870;
	bh=FdbMCMkMwm3rR96jij5c4cOhkqYsmcCvziuz+/6uQKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdKefLn6eB6eszriSu7ghIP/+8Muu7OucqH/hkIz0tKbIcChmo7MlZVPSvLwS/44V
	 qSFjnHNb3IyFXpKfbor1KbJFbTyevPAmR0ATm4v1MBTQiuWgBAdmYgLUXukmeFCw2B
	 WmvKGAffM52cMFmXF/eF18orBPoSq6dwRq/YeH49VqWoCLIvUwMEXEVMFXOBiR7nVz
	 O3oXcw+T75Eb9IHJqPVA17ob3AnjMELr2eHeTai6KWI5ZybEIYAQrtQAagIcXLVL1w
	 gL0f8Qxmjg9gRY4z3wLfMdlK+EKIvs4OYsp1UVS9hi4GkIFGzphxhvayFtf/i3hTXg
	 jOPnAlN4brgSQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/11] sched_ext: Restructure dispatch_to_local_dsq()
Date: Fri, 30 Aug 2024 01:03:49 -1000
Message-ID: <20240830110415.116090-6-tj@kernel.org>
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

Now that there's nothing left after the big if block, flip the if condition
and unindent the body.

No functional changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 94 ++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 50 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 34b4e63850c1..add267f31396 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2333,65 +2333,59 @@ static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
 	}
 
 #ifdef CONFIG_SMP
-	if (likely(task_can_run_on_remote_rq(p, dst_rq, true))) {
-		/*
-		 * @p is on a possibly remote @src_rq which we need to lock to
-		 * move the task. If dequeue is in progress, it'd be locking
-		 * @src_rq and waiting on DISPATCHING, so we can't grab @src_rq
-		 * lock while holding DISPATCHING.
-		 *
-		 * As DISPATCHING guarantees that @p is wholly ours, we can
-		 * pretend that we're moving from a DSQ and use the same
-		 * mechanism - mark the task under transfer with holding_cpu,
-		 * release DISPATCHING and then follow the same protocol. See
-		 * unlink_dsq_and_lock_task_rq().
-		 */
-		p->scx.holding_cpu = raw_smp_processor_id();
+	if (unlikely(!task_can_run_on_remote_rq(p, dst_rq, true))) {
+		dispatch_enqueue(&scx_dsq_global, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
+		return;
+	}
 
-		/* store_release ensures that dequeue sees the above */
-		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
+	/*
+	 * @p is on a possibly remote @src_rq which we need to lock to move the
+	 * task. If dequeue is in progress, it'd be locking @src_rq and waiting
+	 * on DISPATCHING, so we can't grab @src_rq lock while holding
+	 * DISPATCHING.
+	 *
+	 * As DISPATCHING guarantees that @p is wholly ours, we can pretend that
+	 * we're moving from a DSQ and use the same mechanism - mark the task
+	 * under transfer with holding_cpu, release DISPATCHING and then follow
+	 * the same protocol. See unlink_dsq_and_lock_task_rq().
+	 */
+	p->scx.holding_cpu = raw_smp_processor_id();
 
-		/* switch to @src_rq lock */
-		if (rq != src_rq) {
-			raw_spin_rq_unlock(rq);
-			raw_spin_rq_lock(src_rq);
-		}
+	/* store_release ensures that dequeue sees the above */
+	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
 
-		/* task_rq couldn't have changed if we're still the holding cpu */
-		if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
-		    !WARN_ON_ONCE(src_rq != task_rq(p))) {
-			/*
-			 * If @p is staying on the same rq, there's no need to
-			 * go through the full deactivate/activate cycle.
-			 * Optimize by abbreviating the operations in
-			 * move_task_to_local_dsq().
-			 */
-			if (src_rq == dst_rq) {
-				p->scx.holding_cpu = -1;
-				dispatch_enqueue(&dst_rq->scx.local_dsq,
-						 p, enq_flags);
-			} else {
-				move_task_to_local_dsq(p, enq_flags,
-						       src_rq, dst_rq);
-			}
+	/* switch to @src_rq lock */
+	if (rq != src_rq) {
+		raw_spin_rq_unlock(rq);
+		raw_spin_rq_lock(src_rq);
+	}
 
-			/* if the destination CPU is idle, wake it up */
-			if (sched_class_above(p->sched_class,
-					      dst_rq->curr->sched_class))
-				resched_curr(dst_rq);
+	/* task_rq couldn't have changed if we're still the holding cpu */
+	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
+	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
+		/*
+		 * If @p is staying on the same rq, there's no need to go
+		 * through the full deactivate/activate cycle. Optimize by
+		 * abbreviating the operations in move_task_to_local_dsq().
+		 */
+		if (src_rq == dst_rq) {
+			p->scx.holding_cpu = -1;
+			dispatch_enqueue(&dst_rq->scx.local_dsq, p, enq_flags);
+		} else {
+			move_task_to_local_dsq(p, enq_flags, src_rq, dst_rq);
 		}
 
-		/* switch back to @rq lock */
-		if (rq != dst_rq) {
-			raw_spin_rq_unlock(dst_rq);
-			raw_spin_rq_lock(rq);
-		}
+		/* if the destination CPU is idle, wake it up */
+		if (sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+			resched_curr(dst_rq);
+	}
 
-		return;
+	/* switch back to @rq lock */
+	if (rq != dst_rq) {
+		raw_spin_rq_unlock(dst_rq);
+		raw_spin_rq_lock(rq);
 	}
 #endif	/* CONFIG_SMP */
-
-	dispatch_enqueue(&scx_dsq_global, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 /**
-- 
2.46.0


