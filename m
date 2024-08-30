Return-Path: <linux-kernel+bounces-309262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777AC96683F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B7C281E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3D71B9B5A;
	Fri, 30 Aug 2024 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO0rC8Hd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54B1C6A5
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039888; cv=none; b=jSjuQvRmz/JIXQ+ObowbgiKbFMGEiYYoB2efD9EUjVXfI5eESrlABQNY9vmdOdbnrleakMRsUPtViVVJ1DfSiEgJQHtiNeMz+B9HejwszHr4q1BUAiU8vxSFfKhdRnPpuhKNBSjlrLx6TuaRpEQgiCbnJbdIZrqUZTu7XkHKvV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039888; c=relaxed/simple;
	bh=GvovP1TKCI3F3a/YRtBd6GlpQM42BHJT2s6FKNEnzp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olO/79fD25+gV5pZ4EBol1SzX9rWYrcBDK1+SFWuI6RAMzMQOOrt50q2EuxKPPp9tDzsAUvc15pemNYENOZjtBBDmx5cHgdHwVpH0MzNkrOy/3knqOdmNCvLTx2CAxtVm75lu5mDfg82jE6IZc+fK2VwZ1o7lqzZDf3XUs5WyTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO0rC8Hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620E6C4CEC2;
	Fri, 30 Aug 2024 17:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725039887;
	bh=GvovP1TKCI3F3a/YRtBd6GlpQM42BHJT2s6FKNEnzp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uO0rC8HdgGUq6EKQESde+MHkiGknMlLFfjIRqtbmpZnZ7SlsSgTxAZ4axXEuVwZUp
	 wOMdZF9KOH6Y4X4hwK9uYT4zp+pxmLuDlMKpV5E46Hh1Vlp9O3HLcW2sUmla2sR+AB
	 JIY9JahmwRO44WVoyFJGcgJRydMfH9QBb1PbMbxGyA8Xktmx9qn07DOQZQsWy1Oh9s
	 C4miX3TszRtwQ4PnFOlZwtJe8N1rYxyp/DGHwO5rFeP3W9qI7gfVSqyh3uTi0Ik1gy
	 6CflXErb3bW3ANotjDiQ1dJWPL89eMlKBoZ0wnGW8b7rEif9jyWwuPjKNSt7JAumm6
	 KAHroCGokraMw==
Date: Fri, 30 Aug 2024 07:44:46 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] sched_ext: Fix processs_ddsp_deferred_locals() by
 unifying DTL_INVALID handling
Message-ID: <ZtIFDmWxIO0nXCZA@slm.duckdns.org>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830110415.116090-5-tj@kernel.org>

With the preceding update, the only return value which makes meaningful
difference is DTL_INVALID, for which one caller, finish_dispatch(), falls
back to the global DSQ and the other, process_ddsp_deferred_locals(),
doesn't do anything.

It should always fallback to the global DSQ. Move the global DSQ fallback
into dispatch_to_local_dsq() and remove the return value.

v2: Patch title and description updated to reflect the behavior fix for
    process_ddsp_deferred_locals().

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c |   41 ++++++++++-------------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2301,12 +2301,6 @@ retry:
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
@@ -2336,13 +2329,11 @@ dispatch_to_local_dsq(struct rq *rq, str
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
@@ -2367,10 +2358,8 @@ dispatch_to_local_dsq(struct rq *rq, str
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
@@ -2398,11 +2387,11 @@ dispatch_to_local_dsq(struct rq *rq, str
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
@@ -2479,20 +2468,10 @@ retry:
 
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

