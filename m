Return-Path: <linux-kernel+bounces-316159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EFB96CBEB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35981F2613D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC29748D;
	Thu,  5 Sep 2024 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u42YL8Pg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613BE522F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725497225; cv=none; b=JbTuuziNfpSUe0ooOcj3TzS93+dOi8N26IoysYDLRr/FFI3BwL4IBsLq4rtGHIWjCraNtm5FyDzJ7Crgkw98bH0VHTRyTnp9S1fHR6del9jG08TqjfIf2pU/gmlsyPj3GKwadiP0B/CfKxGoYiGSd1RF1OZuntBoXZNaNxhpGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725497225; c=relaxed/simple;
	bh=HaQzHA6ilu3QbQ4+LkS0flctHAxSIWuWzF2jOHZj2xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i3E7NJgPxJXYjyDr6A7z9oc+bq7sXGfE42nKb8T5BNjXG7FRf+8cOMIqzZ2J1i/fdgEl66N57VovZk5Nf4DnbSKXGmk21diRxMyGdCCRn3uzgWtrvBNfzHRwzY8yJ12VyOrZbDbTy2jVlDvwMkKQ6ob9Q0bBkTo4Q2n29hYNgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u42YL8Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A27C4CEC2;
	Thu,  5 Sep 2024 00:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725497224;
	bh=HaQzHA6ilu3QbQ4+LkS0flctHAxSIWuWzF2jOHZj2xQ=;
	h=Date:From:To:Cc:Subject:From;
	b=u42YL8Pg16O6OK0KsmljlxddUXzpRtQ7iqEJCSvFwVN6/wWnP5oukSYmuYgA9aQtY
	 rCr6zfX4/ZaGaq1L0azNlRt8XwHZ5maAokiPM4RfLtFvmaVmsbtmiOQklGEaM7fGvE
	 TOiUMMYq1xCtUSP9jyIj0Z3dM5YfNIQvKQxeYNon+7sLkTbEXI9ml4sw98//5ObjLT
	 2cBwACWfBDXXDo9Bnf7kWprIlSvxEuDJ5a9CP+eQ9u/lAzVDdiLHDo9/dd/YB0gP7q
	 nA34ZTjj8kE86J74oqQAmfVBuEyt90TPJXSPc45om6fr9vi57KL6HWLmdZt4MueEB/
	 ouAtCTBJaf+8A==
Date: Wed, 4 Sep 2024 14:47:03 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH sched_ext/for-6.12] sched_ext: Handle cases where
 pick_task_scx() is called without preceding balance_scx()
Message-ID: <Ztj_h5c2LYsdXYbA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sched_ext dispatches tasks from the BPF scheduler from balance_scx() and
thus every pick_task_scx() call must be preceded by balance_scx(). While
this usually holds, there are rare cases where a higher sched class's
balance() returns true indicating that it has tasks to run on the CPU and
thus terminating balance() calls but fails to actually find the next task to
run when pick_task() is called. In such cases, pick_task_scx() can be called
without preceding balance_scx().

Detect this condition using SCX_RQ_BAL_PENDING flags. If detected, keep
running the previous task if possible and avoid stalling from entering idle
without balancing.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c  |   13 ++++++++-----
 kernel/sched/ext.c   |   34 +++++++++++++++++++++++++++++-----
 kernel/sched/sched.h |    3 ++-
 3 files changed, 39 insertions(+), 11 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5901,12 +5901,15 @@ static void prev_balance(struct rq *rq,
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 	/*
-	 * SCX requires a balance() call before every pick_next_task() including
-	 * when waking up from SCHED_IDLE. If @start_class is below SCX, start
-	 * from SCX instead.
+	 * SCX requires a balance() call before every pick_task() including when
+	 * waking up from SCHED_IDLE. If @start_class is below SCX, start from
+	 * SCX instead. Also, set a flag to detect missing balance() call.
 	 */
-	if (scx_enabled() && sched_class_above(&ext_sched_class, start_class))
-		start_class = &ext_sched_class;
+	if (scx_enabled()) {
+		rq->scx.flags |= SCX_RQ_BAL_PENDING;
+		if (sched_class_above(&ext_sched_class, start_class))
+			start_class = &ext_sched_class;
+	}
 #endif
 
 	/*
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2591,7 +2591,7 @@ static int balance_one(struct rq *rq, st
 
 	lockdep_assert_rq_held(rq);
 	rq->scx.flags |= SCX_RQ_IN_BALANCE;
-	rq->scx.flags &= ~SCX_RQ_BAL_KEEP;
+	rq->scx.flags &= ~(SCX_RQ_BAL_PENDING | SCX_RQ_BAL_KEEP);
 
 	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
 	    unlikely(rq->scx.cpu_released)) {
@@ -2904,25 +2904,49 @@ static struct task_struct *pick_task_scx
 {
 	struct task_struct *prev = rq->curr;
 	struct task_struct *p;
+	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+	bool keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
+	bool kick_idle = false;
+
+	if (unlikely(rq->scx.flags & SCX_RQ_BAL_PENDING)) {
+		/*
+		 * pick_task_scx() can be called without preceding balance_scx()
+		 * call if a higher class's balance() returned %true but its
+		 * pick_task() returned %NULL. Keep running @prev if possible
+		 * and avoid stalling from entering idle without balancing.
+		 */
+		if (prev_on_scx) {
+			keep_prev = true;
+		} else {
+			keep_prev = false;
+			kick_idle = true;
+		}
+	} else if (unlikely(keep_prev && !prev_on_scx)) {
+		/* only allowed during transitions */
+		WARN_ON_ONCE(scx_ops_enable_state() == SCX_OPS_ENABLED);
+		keep_prev = false;
+	}
 
 	/*
 	 * If balance_scx() is telling us to keep running @prev, replenish slice
 	 * if necessary and keep running @prev. Otherwise, pop the first one
 	 * from the local DSQ.
 	 */
-	if ((rq->scx.flags & SCX_RQ_BAL_KEEP) &&
-	    !WARN_ON_ONCE(prev->sched_class != &ext_sched_class)) {
+	if (keep_prev) {
 		p = prev;
 		if (!p->scx.slice)
 			p->scx.slice = SCX_SLICE_DFL;
 	} else {
 		p = first_local_task(rq);
-		if (!p)
+		if (!p) {
+			if (kick_idle)
+				scx_bpf_kick_cpu(cpu_of(rq), SCX_KICK_IDLE);
 			return NULL;
+		}
 
 		if (unlikely(!p->scx.slice)) {
 			if (!scx_ops_bypassing() && !scx_warned_zero_slice) {
-				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
+				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_task_scx()\n",
 						p->comm, p->pid);
 				scx_warned_zero_slice = true;
 			}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -749,7 +749,8 @@ enum scx_rq_flags {
 	 */
 	SCX_RQ_ONLINE		= 1 << 0,
 	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
-	SCX_RQ_BAL_KEEP		= 1 << 2, /* balance decided to keep current */
+	SCX_RQ_BAL_PENDING	= 1 << 2, /* balance hasn't run yet */
+	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_BALANCE	= 1 << 17,

