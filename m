Return-Path: <linux-kernel+bounces-322202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF729725BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 01:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBA91F2443B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A126A18DF84;
	Mon,  9 Sep 2024 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7P9mr9u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F05189909
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725924584; cv=none; b=ESwe1JxbwHEd9wl7X+iJVGEyjifBPpEqhHt9vlBtFf8OZdZfYT/qr6akK6daJBDBNA+SZoeEaf1y3zqjZQNFU/OMyqZ/iQ2UrWcdgV6dK6rAtt8lp6JsU6PkpJ9Y2/N5KpjPBFo/SQ/qeW+dnpv8qJsDfj/UstK77KqBZ4siBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725924584; c=relaxed/simple;
	bh=FUu/z1CQYv3oi5zSAh2onH+hx9mS6Wr7Z4kDT4b5clE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCXwfC3p9tyouFHQrWyAf3jJHDousYante6OMksEsBYTMfCHQTGM574Ep/rlH9q7rrQY9oMWSsTWhSMX1hTD5RhjPBs9S7LRPsXFDlg6kszP8YfvgfisNKKQ7SWC8K//PyIIVYDUWqqIPqLJVqf93G5XhxLbXqUzndecLZRSSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7P9mr9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEC0C4CEC5;
	Mon,  9 Sep 2024 23:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725924583;
	bh=FUu/z1CQYv3oi5zSAh2onH+hx9mS6Wr7Z4kDT4b5clE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7P9mr9uP1/5OXHe90TXAs8P2TUZ+2qtB4cKl8bOofRNo4kQw+M4wPEPYnZ0ivAfL
	 UjQZW6MYuSCjGD6M4yGOxtOcQhku6y3Jad9W6Zd2iKbjOQ7Jrp5E7PzTGBRX5ZpZxB
	 ewcrUNhv4ygSyAgSLZBS1wYBbWR/x2lAhHB0wA4zrMa4jRD1U5Ho/fTG1UI9XOYAJm
	 hcSI2D9qM/AP8GipKtfvgju7/5ve9FuRjFx/xkKu9hx46q5gbn36ocMR7nZD7jM62U
	 mXeoL77lU4YEqNof/7Lru2qUklkaoNhLczPQFsEQDfBn5kc8ZIjLsFEZm74cNR2tm/
	 VWjG/u0+wH/mA==
Date: Mon, 9 Sep 2024 13:29:42 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 sched_ext/for-6.12] sched_ext: Synchronize bypass state
 changes with rq lock
Message-ID: <Zt-E5mwbfoJgcBtX@slm.duckdns.org>
References: <Zt9pIAw06q_TZBoY@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt9pIAw06q_TZBoY@slm.duckdns.org>

While the BPF scheduler is being unloaded, the following warning messages
trigger sometimes:

 NOHZ tick-stop error: local softirq work is pending, handler #80!!!

This is caused by the CPU entering idle while there are pending softirqs.
The main culprit is the bypassing state assertion not being synchronized
with rq operations. As the BPF scheduler cannot be trusted in the disable
path, the first step is entering the bypass mode where the BPF scheduler is
ignored and scheduling becomes global FIFO.

This is implemented by turning scx_ops_bypassing() true. However, the
transition isn't synchronized against anything and it's possible for enqueue
and dispatch paths to have different ideas on whether bypass mode is on.

Make each rq track its own bypass state with SCX_RQ_BYPASSING which is
modified while rq is locked.

This removes most of the NOHZ tick-stop messages but not completely. I
believe the stragglers are from the sched core bug where pick_task_scx() can
be called without preceding balance_scx(). Once that bug is fixed, we should
verify that all occurrences of this error message are gone too.

v2: scx_enabled() test moved inside the for_each_possible_cpu() loop so that
    the per-cpu states are always synchronized with the global state.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c   |   63 +++++++++++++++++++++++++++++----------------------
 kernel/sched/sched.h |    1 
 2 files changed, 38 insertions(+), 26 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1397,9 +1397,9 @@ static bool scx_ops_tryset_enable_state(
 	return atomic_try_cmpxchg(&scx_ops_enable_state_var, &from_v, to);
 }
 
-static bool scx_ops_bypassing(void)
+static bool scx_rq_bypassing(struct rq *rq)
 {
-	return unlikely(atomic_read(&scx_ops_bypass_depth));
+	return unlikely(rq->scx.flags & SCX_RQ_BYPASSING);
 }
 
 /**
@@ -1932,7 +1932,7 @@ static void do_enqueue_task(struct rq *r
 	if (!scx_rq_online(rq))
 		goto local;
 
-	if (scx_ops_bypassing())
+	if (scx_rq_bypassing(rq))
 		goto global;
 
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
@@ -2620,7 +2620,7 @@ static int balance_one(struct rq *rq, st
 		 * bypassing test.
 		 */
 		if ((prev->scx.flags & SCX_TASK_QUEUED) &&
-		    prev->scx.slice && !scx_ops_bypassing()) {
+		    prev->scx.slice && !scx_rq_bypassing(rq)) {
 			rq->scx.flags |= SCX_RQ_BAL_KEEP;
 			goto has_tasks;
 		}
@@ -2633,7 +2633,7 @@ static int balance_one(struct rq *rq, st
 	if (consume_dispatch_q(rq, &scx_dsq_global))
 		goto has_tasks;
 
-	if (!SCX_HAS_OP(dispatch) || scx_ops_bypassing() || !scx_rq_online(rq))
+	if (!SCX_HAS_OP(dispatch) || scx_rq_bypassing(rq) || !scx_rq_online(rq))
 		goto no_tasks;
 
 	dspc->rq = rq;
@@ -2679,7 +2679,8 @@ no_tasks:
 	 * %SCX_OPS_ENQ_LAST is in effect.
 	 */
 	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
-	    (!static_branch_unlikely(&scx_ops_enq_last) || scx_ops_bypassing())) {
+	    (!static_branch_unlikely(&scx_ops_enq_last) ||
+	     scx_rq_bypassing(rq))) {
 		rq->scx.flags |= SCX_RQ_BAL_KEEP;
 		goto has_tasks;
 	}
@@ -2871,7 +2872,7 @@ static void put_prev_task_scx(struct rq
 		 * forcing a different task. Leave it at the head of the local
 		 * DSQ.
 		 */
-		if (p->scx.slice && !scx_ops_bypassing()) {
+		if (p->scx.slice && !scx_rq_bypassing(rq)) {
 			dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
 			return;
 		}
@@ -2936,7 +2937,7 @@ static struct task_struct *pick_task_scx
 			return NULL;
 
 		if (unlikely(!p->scx.slice)) {
-			if (!scx_ops_bypassing() && !scx_warned_zero_slice) {
+			if (!scx_rq_bypassing(rq) && !scx_warned_zero_slice) {
 				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
 						p->comm, p->pid);
 				scx_warned_zero_slice = true;
@@ -2974,7 +2975,7 @@ bool scx_prio_less(const struct task_str
 	 * calling ops.core_sched_before(). Accesses are controlled by the
 	 * verifier.
 	 */
-	if (SCX_HAS_OP(core_sched_before) && !scx_ops_bypassing())
+	if (SCX_HAS_OP(core_sched_before) && !scx_rq_bypassing(task_rq(a)))
 		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, core_sched_before,
 					      (struct task_struct *)a,
 					      (struct task_struct *)b);
@@ -3333,7 +3334,7 @@ static void task_tick_scx(struct rq *rq,
 	 * While disabling, always resched and refresh core-sched timestamp as
 	 * we can't trust the slice management or ops.core_sched_before().
 	 */
-	if (scx_ops_bypassing()) {
+	if (scx_rq_bypassing(rq)) {
 		curr->scx.slice = 0;
 		touch_core_sched(rq, curr);
 	} else if (SCX_HAS_OP(tick)) {
@@ -3672,7 +3673,7 @@ bool scx_can_stop_tick(struct rq *rq)
 {
 	struct task_struct *p = rq->curr;
 
-	if (scx_ops_bypassing())
+	if (scx_rq_bypassing(rq))
 		return false;
 
 	if (p->sched_class != &ext_sched_class)
@@ -4265,16 +4266,8 @@ static void scx_ops_bypass(bool bypass)
 	}
 
 	/*
-	 * We need to guarantee that no tasks are on the BPF scheduler while
-	 * bypassing. Either we see enabled or the enable path sees the
-	 * increased bypass_depth before moving tasks to SCX.
-	 */
-	if (!scx_enabled())
-		return;
-
-	/*
 	 * No task property is changing. We just need to make sure all currently
-	 * queued tasks are re-queued according to the new scx_ops_bypassing()
+	 * queued tasks are re-queued according to the new scx_rq_bypassing()
 	 * state. As an optimization, walk each rq's runnable_list instead of
 	 * the scx_tasks list.
 	 *
@@ -4288,6 +4281,24 @@ static void scx_ops_bypass(bool bypass)
 
 		rq_lock_irqsave(rq, &rf);
 
+		if (bypass) {
+			WARN_ON_ONCE(rq->scx.flags & SCX_RQ_BYPASSING);
+			rq->scx.flags |= SCX_RQ_BYPASSING;
+		} else {
+			WARN_ON_ONCE(!(rq->scx.flags & SCX_RQ_BYPASSING));
+			rq->scx.flags &= ~SCX_RQ_BYPASSING;
+		}
+
+		/*
+		 * We need to guarantee that no tasks are on the BPF scheduler
+		 * while bypassing. Either we see enabled or the enable path
+		 * sees scx_rq_bypassing() before moving tasks to SCX.
+		 */
+		if (!scx_enabled()) {
+			rq_unlock_irqrestore(rq, &rf);
+			continue;
+		}
+
 		/*
 		 * The use of list_for_each_entry_safe_reverse() is required
 		 * because each task is going to be removed from and added back
@@ -6191,17 +6202,17 @@ __bpf_kfunc void scx_bpf_kick_cpu(s32 cp
 	if (!ops_cpu_valid(cpu, NULL))
 		return;
 
+	local_irq_save(irq_flags);
+
+	this_rq = this_rq();
+
 	/*
 	 * While bypassing for PM ops, IRQ handling may not be online which can
 	 * lead to irq_work_queue() malfunction such as infinite busy wait for
 	 * IRQ status update. Suppress kicking.
 	 */
-	if (scx_ops_bypassing())
-		return;
-
-	local_irq_save(irq_flags);
-
-	this_rq = this_rq();
+	if (scx_rq_bypassing(this_rq))
+		goto out;
 
 	/*
 	 * Actual kicking is bounced to kick_cpus_irq_workfn() to avoid nesting
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -750,6 +750,7 @@ enum scx_rq_flags {
 	SCX_RQ_ONLINE		= 1 << 0,
 	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
 	SCX_RQ_BAL_KEEP		= 1 << 2, /* balance decided to keep current */
+	SCX_RQ_BYPASSING	= 1 << 3,
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_BALANCE	= 1 << 17,

