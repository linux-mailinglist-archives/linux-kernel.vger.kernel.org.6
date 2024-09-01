Return-Path: <linux-kernel+bounces-310308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45874967977
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D841C21334
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D15D18593F;
	Sun,  1 Sep 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJtA5W4u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBCC185928
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209064; cv=none; b=UH7fUwSLqctwviKzSQxcn9xMAaTOFtjJe5qEUoPwTFQ0GiR2+ZrJf7fT/oGYMwSMssSofiDpw6JJVwgNU/+wDE+OG/rJTk3R+083nF/hNPeHnWdIr/0+x2tmZtn3VhXV0t0xnBeUTfG00sEIlwTc9G+WTli6tA76zORQysyFlHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209064; c=relaxed/simple;
	bh=wdpp4NTpqf58DnAy2hc0evRRxBqe4dNCqnI2TjCWzi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4yLGTzBvBdd6iiTM8skoQ2gqGyw8oNjYljP/IupvL2deN8spT8PXBntC/96rfk9LwBugFGea0DfsmYRRq7szHj9I3te8OPJwjKZEsaHfZWVsbbxncPXevc+JZ8uK5gxCK7pJXUHjb4pmEU8xb+Zhg/LGiJiPQMdIc9QeNXf3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJtA5W4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04617C4CECC;
	Sun,  1 Sep 2024 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725209064;
	bh=wdpp4NTpqf58DnAy2hc0evRRxBqe4dNCqnI2TjCWzi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJtA5W4u31twWh9U8lGucRZQVvIri9PoQ5jAq/FbKXl1griFh+AxpZ/p0RJDn/HZi
	 ei/rAer4CoYrVRBnMwtFSM/2Ri960kdcmV9B/YTEHxEh13apowL5v1csNzJxPrqlQe
	 lPQMdFUzPUh2iuA0G0W/KyI1lQBF/xIuBT8h2uKK+EOTAx9RJIShlE/zU8w6duwE8z
	 16dA9FQ+gSLjueX0c4WFEpnYWYcv5e9lVQYilojlhrehzG27MXb4sHGIAFRsfBdIOV
	 TuPA9EpNyBrcfoQvOD3Xw5Fd/TEJHShpRc0sL6/sbfxMSVL1oqsa0IO/tjqkQGJ63j
	 OnL0aCHtcm7cw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/12] sched_ext: Fix processs_ddsp_deferred_locals() by unifying DTL_INVALID handling
Date: Sun,  1 Sep 2024 06:43:41 -1000
Message-ID: <20240901164417.779239-5-tj@kernel.org>
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

With the preceding update, the only return value which makes meaningful
difference is DTL_INVALID, for which one caller, finish_dispatch(), falls
back to the global DSQ and the other, process_ddsp_deferred_locals(),
doesn't do anything.

It should always fallback to the global DSQ. Move the global DSQ fallback
into dispatch_to_local_dsq() and remove the return value.

v2: Patch title and description updated to reflect the behavior fix for
    process_ddsp_deferred_locals().

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 41 ++++++++++-------------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1d35298ee561..ec61ab676517 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2299,12 +2299,6 @@ static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
 	return false;
 }
 
-enum dispatch_to_local_dsq_ret {
-	DTL_DISPATCHED,		/* successfully dispatched */
-	DTL_LOST,		/* lost race to dequeue */
-	DTL_INVALID,		/* invalid local dsq_id */
-};
-
 /**
  * dispatch_to_local_dsq - Dispatch a task to a local dsq
  * @rq: current rq which is locked
@@ -2319,9 +2313,8 @@ enum dispatch_to_local_dsq_ret {
  * The caller must have exclusive ownership of @p (e.g. through
  * %SCX_OPSS_DISPATCHING).
  */
-static enum dispatch_to_local_dsq_ret
-dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
-		      struct task_struct *p, u64 enq_flags)
+static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
+				  struct task_struct *p, u64 enq_flags)
 {
 	struct rq *src_rq = task_rq(p);
 	struct rq *dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
@@ -2334,13 +2327,11 @@ dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
 	 */
 	if (rq == src_rq && rq == dst_rq) {
 		dispatch_enqueue(dst_dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
-		return DTL_DISPATCHED;
+		return;
 	}
 
 #ifdef CONFIG_SMP
 	if (likely(task_can_run_on_remote_rq(p, dst_rq, true))) {
-		bool dsp;
-
 		/*
 		 * @p is on a possibly remote @src_rq which we need to lock to
 		 * move the task. If dequeue is in progress, it'd be locking
@@ -2365,10 +2356,8 @@ dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
 		}
 
 		/* task_rq couldn't have changed if we're still the holding cpu */
-		dsp = p->scx.holding_cpu == raw_smp_processor_id() &&
-			!WARN_ON_ONCE(src_rq != task_rq(p));
-
-		if (likely(dsp)) {
+		if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
+		    !WARN_ON_ONCE(src_rq != task_rq(p))) {
 			/*
 			 * If @p is staying on the same rq, there's no need to
 			 * go through the full deactivate/activate cycle.
@@ -2396,11 +2385,11 @@ dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
 			raw_spin_rq_lock(rq);
 		}
 
-		return dsp ? DTL_DISPATCHED : DTL_LOST;
+		return;
 	}
 #endif	/* CONFIG_SMP */
 
-	return DTL_INVALID;
+	dispatch_enqueue(&scx_dsq_global, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 /**
@@ -2477,20 +2466,10 @@ static void finish_dispatch(struct rq *rq, struct task_struct *p,
 
 	dsq = find_dsq_for_dispatch(this_rq(), dsq_id, p);
 
-	if (dsq->id == SCX_DSQ_LOCAL) {
-		switch (dispatch_to_local_dsq(rq, dsq, p, enq_flags)) {
-		case DTL_DISPATCHED:
-			break;
-		case DTL_LOST:
-			break;
-		case DTL_INVALID:
-			dispatch_enqueue(&scx_dsq_global, p,
-					 enq_flags | SCX_ENQ_CLEAR_OPSS);
-			break;
-		}
-	} else {
+	if (dsq->id == SCX_DSQ_LOCAL)
+		dispatch_to_local_dsq(rq, dsq, p, enq_flags);
+	else
 		dispatch_enqueue(dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
-	}
 }
 
 static void flush_dispatch_buf(struct rq *rq)
-- 
2.46.0


