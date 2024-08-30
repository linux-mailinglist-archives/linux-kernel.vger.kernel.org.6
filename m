Return-Path: <linux-kernel+bounces-308657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23511965FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824091C20EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146F819E81F;
	Fri, 30 Aug 2024 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfeY27Ed"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305CE19ABAA
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015866; cv=none; b=rndLNhBT3QyYLX+y5Q7qketv/Ky+rXjKejMV6BND6W0wATvCoVHMUNYHbHdwWYFn0MsB9oga2JtArNDtf9dEHHWZXo/zsWYSeF6I8WI0QxQGKkf8JYqpyH5peu8/tEzrtf5KQXjXIc+4kjUDf8ms7nZTJZcDObJXGO1VM27croQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015866; c=relaxed/simple;
	bh=PxQxs1dzpTVKaadJ3L8xHOFUMg9pWjdhmkgI2eKkz3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qL4BpT2nc1DqVJWQC5CAIg+Rf+vIQjMP/BTeVepLdYinzIL2BIT88F7PxQtKpkPDrv1kojRnIOGZ4Lh1ZJlC8anvl8QHtgvwXO5U/kEm+pUEBH5IS+bzCDy+kvjxOMh3idjWeHNHepG/gl0jIY6DXUsJ1gjbkSzyBgNXCFNsxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfeY27Ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E296BC4CEC2;
	Fri, 30 Aug 2024 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015866;
	bh=PxQxs1dzpTVKaadJ3L8xHOFUMg9pWjdhmkgI2eKkz3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MfeY27EdYi+2BHEB5zGux4wIoh7pfSVti8IwQs+BeuCqfeHbBFuMsUWaaYg0Lo5Kj
	 k1bb5hh0i+okTy3VOsQegR0Bfdd6XCOh0GqhHfyOuNZ48a0mdIBFkfnXXrtLZqTBmu
	 ER3MIqfTvhRSjSI78SDi973lx4fu0OHV8+DiVQV9nuK3oMC28esDKRG5J/hBwcdb7i
	 R3/VY4Szn7z60cLcCo0Pkwk/jB/3MzeYRTP/7j0wUS5z09ue+LyESSav7kmEiPO2gd
	 WOXxFRz9LZD7TXtrB/dc09XdkO//WoHCUZ9YtPhMRVTyxxLDzKsRUNHh20o4008a3Y
	 CiLb42EpOpSTQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/11] sched_ext: Make find_dsq_for_dispatch() handle SCX_DSQ_LOCAL_ON
Date: Fri, 30 Aug 2024 01:03:47 -1000
Message-ID: <20240830110415.116090-4-tj@kernel.org>
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

find_dsq_for_dispatch() handles all DSQ IDs except SCX_DSQ_LOCAL_ON.
Instead, each caller is hanlding SCX_DSQ_LOCAL_ON before calling it. Move
SCX_DSQ_LOCAL_ON lookup into find_dsq_for_dispatch() to remove duplicate
code in direct_dispatch() and dispatch_to_local_dsq().

No functional changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 90 +++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 50 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3facfca73337..80387cd9b8c3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1726,6 +1726,15 @@ static struct scx_dispatch_q *find_dsq_for_dispatch(struct rq *rq, u64 dsq_id,
 	if (dsq_id == SCX_DSQ_LOCAL)
 		return &rq->scx.local_dsq;
 
+	if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
+		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
+
+		if (!ops_cpu_valid(cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
+			return &scx_dsq_global;
+
+		return &cpu_rq(cpu)->scx.local_dsq;
+	}
+
 	dsq = find_non_local_dsq(dsq_id);
 	if (unlikely(!dsq)) {
 		scx_ops_error("non-existent DSQ 0x%llx for %s[%d]",
@@ -1769,8 +1778,8 @@ static void mark_direct_dispatch(struct task_struct *ddsp_task,
 static void direct_dispatch(struct task_struct *p, u64 enq_flags)
 {
 	struct rq *rq = task_rq(p);
-	struct scx_dispatch_q *dsq;
-	u64 dsq_id = p->scx.ddsp_dsq_id;
+	struct scx_dispatch_q *dsq =
+		find_dsq_for_dispatch(rq, p->scx.ddsp_dsq_id, p);
 
 	touch_core_sched_dispatch(rq, p);
 
@@ -1782,15 +1791,9 @@ static void direct_dispatch(struct task_struct *p, u64 enq_flags)
 	 * DSQ_LOCAL_ON verdicts targeting the local DSQ of a remote CPU, defer
 	 * the enqueue so that it's executed when @rq can be unlocked.
 	 */
-	if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
-		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
+	if (dsq->id == SCX_DSQ_LOCAL && dsq != &rq->scx.local_dsq) {
 		unsigned long opss;
 
-		if (cpu == cpu_of(rq)) {
-			dsq_id = SCX_DSQ_LOCAL;
-			goto dispatch;
-		}
-
 		opss = atomic_long_read(&p->scx.ops_state) & SCX_OPSS_STATE_MASK;
 
 		switch (opss & SCX_OPSS_STATE_MASK) {
@@ -1817,8 +1820,6 @@ static void direct_dispatch(struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
-dispatch:
-	dsq = find_dsq_for_dispatch(rq, dsq_id, p);
 	dispatch_enqueue(dsq, p, p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
@@ -2303,51 +2304,38 @@ static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
 enum dispatch_to_local_dsq_ret {
 	DTL_DISPATCHED,		/* successfully dispatched */
 	DTL_LOST,		/* lost race to dequeue */
-	DTL_NOT_LOCAL,		/* destination is not a local DSQ */
 	DTL_INVALID,		/* invalid local dsq_id */
 };
 
 /**
  * dispatch_to_local_dsq - Dispatch a task to a local dsq
  * @rq: current rq which is locked
- * @dsq_id: destination dsq ID
+ * @dst_dsq: destination DSQ
  * @p: task to dispatch
  * @enq_flags: %SCX_ENQ_*
  *
- * We're holding @rq lock and want to dispatch @p to the local DSQ identified by
- * @dsq_id. This function performs all the synchronization dancing needed
- * because local DSQs are protected with rq locks.
+ * We're holding @rq lock and want to dispatch @p to @dst_dsq which is a local
+ * DSQ. This function performs all the synchronization dancing needed because
+ * local DSQs are protected with rq locks.
  *
  * The caller must have exclusive ownership of @p (e.g. through
  * %SCX_OPSS_DISPATCHING).
  */
 static enum dispatch_to_local_dsq_ret
-dispatch_to_local_dsq(struct rq *rq, u64 dsq_id, struct task_struct *p,
-		      u64 enq_flags)
+dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
+		      struct task_struct *p, u64 enq_flags)
 {
 	struct rq *src_rq = task_rq(p);
-	struct rq *dst_rq;
+	struct rq *dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 
 	/*
 	 * We're synchronized against dequeue through DISPATCHING. As @p can't
 	 * be dequeued, its task_rq and cpus_allowed are stable too.
+	 *
+	 * If dispatching to @rq that @p is already on, no lock dancing needed.
 	 */
-	if (dsq_id == SCX_DSQ_LOCAL) {
-		dst_rq = rq;
-	} else if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
-		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
-
-		if (!ops_cpu_valid(cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
-			return DTL_INVALID;
-		dst_rq = cpu_rq(cpu);
-	} else {
-		return DTL_NOT_LOCAL;
-	}
-
-	/* if dispatching to @rq that @p is already on, no lock dancing needed */
 	if (rq == src_rq && rq == dst_rq) {
-		dispatch_enqueue(&dst_rq->scx.local_dsq, p,
-				 enq_flags | SCX_ENQ_CLEAR_OPSS);
+		dispatch_enqueue(dst_dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return DTL_DISPATCHED;
 	}
 
@@ -2489,19 +2477,21 @@ static void finish_dispatch(struct rq *rq, struct task_struct *p,
 
 	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
 
-	switch (dispatch_to_local_dsq(rq, dsq_id, p, enq_flags)) {
-	case DTL_DISPATCHED:
-		break;
-	case DTL_LOST:
-		break;
-	case DTL_INVALID:
-		dsq_id = SCX_DSQ_GLOBAL;
-		fallthrough;
-	case DTL_NOT_LOCAL:
-		dsq = find_dsq_for_dispatch(cpu_rq(raw_smp_processor_id()),
-					    dsq_id, p);
+	dsq = find_dsq_for_dispatch(this_rq(), dsq_id, p);
+
+	if (dsq->id == SCX_DSQ_LOCAL) {
+		switch (dispatch_to_local_dsq(rq, dsq, p, enq_flags)) {
+		case DTL_DISPATCHED:
+			break;
+		case DTL_LOST:
+			break;
+		case DTL_INVALID:
+			dispatch_enqueue(&scx_dsq_global, p,
+					 enq_flags | SCX_ENQ_CLEAR_OPSS);
+			break;
+		}
+	} else {
 		dispatch_enqueue(dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
-		break;
 	}
 }
 
@@ -2718,13 +2708,13 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 	 */
 	while ((p = list_first_entry_or_null(&rq->scx.ddsp_deferred_locals,
 				struct task_struct, scx.dsq_list.node))) {
-		s32 ret;
+		struct scx_dispatch_q *dsq;
 
 		list_del_init(&p->scx.dsq_list.node);
 
-		ret = dispatch_to_local_dsq(rq, p->scx.ddsp_dsq_id, p,
-					    p->scx.ddsp_enq_flags);
-		WARN_ON_ONCE(ret == DTL_NOT_LOCAL);
+		dsq = find_dsq_for_dispatch(rq, p->scx.ddsp_dsq_id, p);
+		if (!WARN_ON_ONCE(dsq->id != SCX_DSQ_LOCAL))
+			dispatch_to_local_dsq(rq, dsq, p, p->scx.ddsp_enq_flags);
 	}
 }
 
-- 
2.46.0


