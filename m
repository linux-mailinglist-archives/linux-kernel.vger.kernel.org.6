Return-Path: <linux-kernel+bounces-308658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EA4965FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06001F21459
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F631A4AAB;
	Fri, 30 Aug 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaWHtFIc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF341A2863
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015867; cv=none; b=YWJ1T63Ogj/PQrH7fhaz0LP36dSXI8NzrVIp949o5tpmp4dCXeqMGtg/CwYiU7myb2DAtcxIQhPB4Ad8TV3d4yXUbwFWzGPWLFGIx0uNDTR+0/obv98njyjN0Le3ClEgSLgrmwPVY8MdOK9nkC9hh6vBER4yxmDHZfbg4Dhedwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015867; c=relaxed/simple;
	bh=yDPU3IaqInl49wqqFfiLSHPRNiWelph6oDPT7RtNM1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq2koZ7juxg1QOu5p7J9hjoRWDf29U1KNcrIjlq8xdLLeyIaYd7GFtj1fiQf4PU0OGh+yyzyC/lFWLwLsEwcpzOi8v1Cl/QBqjRaFnRbaacIz2J1k+dkt2Cj8Yu5BP63qcgHKdT8i1VOvLM509PAUDU006+6pv/9z5t67PGEhig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaWHtFIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0515CC4CEC2;
	Fri, 30 Aug 2024 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015867;
	bh=yDPU3IaqInl49wqqFfiLSHPRNiWelph6oDPT7RtNM1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaWHtFIclRRwb0FcXbOyhDOX+aRr1H6IfyaBivlZjUhXOjsXGkJw+QqDltUcnXMID
	 6rFMHTIhgKKQQJf8huuhzd/TUnNqbhDZiewaCrQmBgbpfjptPSI4YJGxWipYSJTee6
	 MaDk+moNukc8bT9p2NeA3ZC6pzgAGC2D8AW6lPRysF+blg9ouiAyNk4i+RkCC5vwwZ
	 t5YWa/Uj+i5eMGe0cGZSP/GuvML76z4i303ijNCiqs8Z/q+3sMirepCXk1F93reP5L
	 Mp8fWLMBQtzTYfXy/t9xzkPzWA0JwKgabV/qLnkuLG9mDZ7xwLiIZUEZN5WD+b++sV
	 S66TC/3sFZfyw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/11] sched_ext: Make dispatch_to_local_dsq() return void
Date: Fri, 30 Aug 2024 01:03:48 -1000
Message-ID: <20240830110415.116090-5-tj@kernel.org>
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

With the preceding update, the only return value which makes meaningful
difference is DTL_INVALID, for which the caller dispatches the task to the
global DSQ. Move the global DSQ fallback into dispatch_to_local_dsq() and
remove the return value.

No functional changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 41 ++++++++++-------------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 80387cd9b8c3..34b4e63850c1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2301,12 +2301,6 @@ static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
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
@@ -2321,9 +2315,8 @@ enum dispatch_to_local_dsq_ret {
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
@@ -2336,13 +2329,11 @@ dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
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
@@ -2367,10 +2358,8 @@ dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
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
@@ -2398,11 +2387,11 @@ dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
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
@@ -2479,20 +2468,10 @@ static void finish_dispatch(struct rq *rq, struct task_struct *p,
 
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


