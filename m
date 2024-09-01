Return-Path: <linux-kernel+bounces-310309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F47F967979
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07FD1F21B27
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437E0185B55;
	Sun,  1 Sep 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzyEm9rz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79370185952
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209065; cv=none; b=pE7zD/oBX9buuE6Y9gi4nPdVoAoiBuKQ/mE7ItkvYHRmwlqOJlPj0mro3ZAbBfkTl6nRzcCZ3r5BVfIYxk129rYLcuNL7SkyPZ1L9t2DPoI1KQeZ71RcJvHqf/LVKBCEVvM1m/0JfVJDY+/KfXFF9/ua5cAb6GXWmrIjLtACm8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209065; c=relaxed/simple;
	bh=8+d8pX8S9fJLXlqAg7fhG8TGE62ZMvnvXIpx02Y/oHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9sgpMnXgwHy1bquW6g+CW2zbefztbcDXhy/b5aA1nGrgZJQraoJj2JbUbPbfvSEYutT98E5RHAs0u9K6/axTm7DObiJgo8Bi5U8KmVtyFfqb/oHxjzzvlUWBlwxSqOiH/vY3+aUzLS/hkh+OvhmbCsioSEPqOju5+3WZQRNrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzyEm9rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20152C4CEC3;
	Sun,  1 Sep 2024 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725209065;
	bh=8+d8pX8S9fJLXlqAg7fhG8TGE62ZMvnvXIpx02Y/oHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tzyEm9rza5sk7W5OwhQDq6b6Os5f2NbrEs+7+P26U1+/gXPgsZkoeX3gsE0pei0w0
	 R+FvtJYAIeD1XcBJQ6J2aOPE1tEpm/ndvsz2Ij++RKjYkldMNOHoqzlG6NlmXH+oq1
	 L11NlWGun0qrmrpPtMpPAWbqz5asZcU46QQw6f5TShxONDsR1s/bp3VzsJt/xrbfOK
	 m8TjOt6j6N44kLzHpZMa/mBzRDG7T9lqsghL8GyhrD4MDw02Af0LWp2NQCXerhdRgA
	 UMob9pOgwYZzagOXzE6XgnEOFYhh8PMIk2cH8OOQc5d/dTeg7RkFfiFZohel4rzP4G
	 uB4YcsjrHnABg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/12] sched_ext: Restructure dispatch_to_local_dsq()
Date: Sun,  1 Sep 2024 06:43:42 -1000
Message-ID: <20240901164417.779239-6-tj@kernel.org>
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

Now that there's nothing left after the big if block, flip the if condition
and unindent the body.

No functional changes intended.

v2: Add BUG() to clarify control can't reach the end of
    dispatch_to_local_dsq() in UP kernels per David.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 96 ++++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ec61ab676517..89a393f183dd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2331,65 +2331,61 @@ static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
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
-		 * unlink_dsq_and_lock_src_rq().
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
+	 * the same protocol. See unlink_dsq_and_lock_src_rq().
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
+#else	/* CONFIG_SMP */
+	BUG();	/* control can not reach here on UP */
 #endif	/* CONFIG_SMP */
-
-	dispatch_enqueue(&scx_dsq_global, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 /**
-- 
2.46.0


