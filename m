Return-Path: <linux-kernel+bounces-357913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C59C9977B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9CF284C21
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E141E47B0;
	Wed,  9 Oct 2024 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/QuTL0Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BCF1A0AFA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510258; cv=none; b=s50tvoLDVCdArQDi871ceMQtRH5AwI2tFwO5nmqWBk1bFbLUHyKRT29Ag+544oX5l9lWJwi/9rVTteUJ8iOFTni2USY6odn7GmSSiyqlFWB/pqM7et18NIoHa18PdNF/YMdnvE/aH9JbjwTPw239QAHqzIoDdxnvEi0+MkWpj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510258; c=relaxed/simple;
	bh=pEECDfe/1oQEvejQPDZsIxZ6GLe5/aboWzETU7HjblI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrdIdlHHjjmN2LbpiDN+gOEP1/ccYaLKCBYNIfgBD6UdIgQ/blsFzR0YpI/+NCGYdcvSiU/ub6ya8H1P6ZwJ1G8ujsoGeu1czS2pUrs/7Yr6XSM1NHSEQnjaDrbFazLD9TqT1GaEpQ9OOhd60EAsVrxOrmr+VhAB26uVIp6pdrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/QuTL0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F07C4CECC;
	Wed,  9 Oct 2024 21:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728510258;
	bh=pEECDfe/1oQEvejQPDZsIxZ6GLe5/aboWzETU7HjblI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/QuTL0Y9c6wwvWdSWhH/aJK+KNlKGP6TfVXmgPcIiqkUieTA4sWyRP5SkX2pZK1O
	 8zvn6xinlpt93hRl1OuxSC4zUF5814UapPQINVq7s5kMZIxGU/L83u7Tch7i/jZAIX
	 c+Uu/iWkEOPnpbdvXEa5sNTN0e6YM+QpzAUozz7re65rLTYILtH7bBRGCM8LeDfFWu
	 6TS2Lt66Gj03yEBAqHv/TPu1lROgJN26TmAgU2+yqyd9ltiMURNqk0J8DGt4KMMAfK
	 orpOLkEW66LmxiAnjfgCYgBPQv+pQGBWoYo2jg3cCaWAfhtqbLrX6i+ABNFj8U9arB
	 0pbzKL8HRvPyg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] sched_ext: bypass mode shouldn't depend on ops.select_cpu()
Date: Wed,  9 Oct 2024 11:41:00 -1000
Message-ID: <20241009214411.681233-5-tj@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009214411.681233-1-tj@kernel.org>
References: <20241009214411.681233-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bypass mode was depending on ops.select_cpu() which can't be trusted as with
the rest of the BPF scheduler. Always enable and use scx_select_cpu_dfl() in
bypass mode.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1cae18000de1..c5cda7368de5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3126,7 +3126,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 	if (unlikely(wake_flags & WF_EXEC))
 		return prev_cpu;
 
-	if (SCX_HAS_OP(select_cpu)) {
+	if (SCX_HAS_OP(select_cpu) && !scx_rq_bypassing(task_rq(p))) {
 		s32 cpu;
 		struct task_struct **ddsp_taskp;
 
@@ -3191,7 +3191,7 @@ void __scx_update_idle(struct rq *rq, bool idle)
 {
 	int cpu = cpu_of(rq);
 
-	if (SCX_HAS_OP(update_idle)) {
+	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
 		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
 		if (!static_branch_unlikely(&scx_builtin_idle_enabled))
 			return;
@@ -4254,21 +4254,23 @@ bool task_should_scx(struct task_struct *p)
  * the DISABLING state and then cycling the queued tasks through dequeue/enqueue
  * to force global FIFO scheduling.
  *
- * a. ops.enqueue() is ignored and tasks are queued in simple global FIFO order.
- *    %SCX_OPS_ENQ_LAST is also ignored.
+ * - ops.select_cpu() is ignored and the default select_cpu() is used.
  *
- * b. ops.dispatch() is ignored.
+ * - ops.enqueue() is ignored and tasks are queued in simple global FIFO order.
+ *   %SCX_OPS_ENQ_LAST is also ignored.
  *
- * c. balance_scx() does not set %SCX_RQ_BAL_KEEP on non-zero slice as slice
- *    can't be trusted. Whenever a tick triggers, the running task is rotated to
- *    the tail of the queue with core_sched_at touched.
+ * - ops.dispatch() is ignored.
  *
- * d. pick_next_task() suppresses zero slice warning.
+ * - balance_scx() does not set %SCX_RQ_BAL_KEEP on non-zero slice as slice
+ *   can't be trusted. Whenever a tick triggers, the running task is rotated to
+ *   the tail of the queue with core_sched_at touched.
  *
- * e. scx_bpf_kick_cpu() is disabled to avoid irq_work malfunction during PM
- *    operations.
+ * - pick_next_task() suppresses zero slice warning.
  *
- * f. scx_prio_less() reverts to the default core_sched_at order.
+ * - scx_bpf_kick_cpu() is disabled to avoid irq_work malfunction during PM
+ *   operations.
+ *
+ * - scx_prio_less() reverts to the default core_sched_at order.
  */
 static void scx_ops_bypass(bool bypass)
 {
@@ -4338,7 +4340,7 @@ static void scx_ops_bypass(bool bypass)
 
 		rq_unlock_irqrestore(rq, &rf);
 
-		/* kick to restore ticks */
+		/* resched to restore ticks and idle state */
 		resched_cpu(cpu);
 	}
 }
-- 
2.46.2


