Return-Path: <linux-kernel+bounces-314478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131C296B3DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378891C21D91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F21186613;
	Wed,  4 Sep 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGbziy/1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCFC17BEB0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437013; cv=none; b=t7AZfTSy4656VVGv3aFyiMSm7bwa00pQeVpvB1x8L4qU0ap8F+5zPQ2Q1TadkAPvjTsbWTEemMdYqIIX57fNQCl8r8k2zKRdqcBxb1eaAKIw6tovaKZyCH85BktzaeX1IkLYzx3zWvhH/XJiZp0N6LXx/pr4mPV7s0NooeYuYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437013; c=relaxed/simple;
	bh=qnIxkPOadd+sELAg96Qc10Rh7XBtafiNukhbvPNQ+qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACDlGmP03AjJhven6ZeYLor7L8XVtZVnH49i+LgVYtXNKPxKNd7hvK099bEZhelIwgeCpHgJZxQ/e3TE6yff6/wMg8Ils0MS3O2TFI7xe9hsBuWct7EBnFI64DJGsD6ZW6y3rHZ/M2/4HpnrTnAaRqMOq79Jaf68pM9l/k4Ejek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGbziy/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EFCC4CEC2;
	Wed,  4 Sep 2024 08:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725437012;
	bh=qnIxkPOadd+sELAg96Qc10Rh7XBtafiNukhbvPNQ+qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGbziy/13XXVb4ShPbdP/bP0E599UKcmSwOvpQS/ADmHelz25gk/5L/GwYikQibXj
	 r5m07ue69OrWP85OEYx9OHv6pnctPSs3HNnoltNuTL3F4DSdxzddcoWJDmlHPp0x9y
	 RonGnINWFpZI7xsVuVM4KYvGEiiNHaCcLU7TpicUks82AUf+7bG1p7i/JpV3wvd04I
	 xF2q5gckzWsfPnXhmbLEF6G3N0k/T6Ony5dUEiOFGYi8hx4/KiOKZdYn1PZ8BSy+Q+
	 4ZTh1ujJR17OAbOOLMW+UX6oTlV1vQz5cB/3zWSj1E1ebxb0rP8ezk+tWmRBaWvfFr
	 Pi9B56aVz3pHA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] sched_ext: Relocate functions in kernel/sched/ext.c
Date: Tue,  3 Sep 2024 22:03:06 -1000
Message-ID: <20240904080326.1132275-5-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904080326.1132275-1-tj@kernel.org>
References: <20240904080326.1132275-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relocate functions to ease the removal of switch_class_scx(). No functional
changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 156 ++++++++++++++++++++++-----------------------
 1 file changed, 78 insertions(+), 78 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d568b40178e6..24bafa649fdb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2642,6 +2642,31 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 	return ret;
 }
 
+static void process_ddsp_deferred_locals(struct rq *rq)
+{
+	struct task_struct *p;
+
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * Now that @rq can be unlocked, execute the deferred enqueueing of
+	 * tasks directly dispatched to the local DSQs of other CPUs. See
+	 * direct_dispatch(). Keep popping from the head instead of using
+	 * list_for_each_entry_safe() as dispatch_local_dsq() may unlock @rq
+	 * temporarily.
+	 */
+	while ((p = list_first_entry_or_null(&rq->scx.ddsp_deferred_locals,
+				struct task_struct, scx.dsq_list.node))) {
+		s32 ret;
+
+		list_del_init(&p->scx.dsq_list.node);
+
+		ret = dispatch_to_local_dsq(rq, p->scx.ddsp_dsq_id, p,
+					    p->scx.ddsp_enq_flags);
+		WARN_ON_ONCE(ret == DTL_NOT_LOCAL);
+	}
+}
+
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	if (p->scx.flags & SCX_TASK_QUEUED) {
@@ -2684,28 +2709,66 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 }
 
-static void process_ddsp_deferred_locals(struct rq *rq)
+static enum scx_cpu_preempt_reason
+preempt_reason_from_class(const struct sched_class *class)
 {
-	struct task_struct *p;
+#ifdef CONFIG_SMP
+	if (class == &stop_sched_class)
+		return SCX_CPU_PREEMPT_STOP;
+#endif
+	if (class == &dl_sched_class)
+		return SCX_CPU_PREEMPT_DL;
+	if (class == &rt_sched_class)
+		return SCX_CPU_PREEMPT_RT;
+	return SCX_CPU_PREEMPT_UNKNOWN;
+}
 
-	lockdep_assert_rq_held(rq);
+static void switch_class_scx(struct rq *rq, struct task_struct *next)
+{
+	const struct sched_class *next_class = next->sched_class;
 
+	if (!scx_enabled())
+		return;
+#ifdef CONFIG_SMP
 	/*
-	 * Now that @rq can be unlocked, execute the deferred enqueueing of
-	 * tasks directly dispatched to the local DSQs of other CPUs. See
-	 * direct_dispatch(). Keep popping from the head instead of using
-	 * list_for_each_entry_safe() as dispatch_local_dsq() may unlock @rq
-	 * temporarily.
+	 * Pairs with the smp_load_acquire() issued by a CPU in
+	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
+	 * resched.
 	 */
-	while ((p = list_first_entry_or_null(&rq->scx.ddsp_deferred_locals,
-				struct task_struct, scx.dsq_list.node))) {
-		s32 ret;
+	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+#endif
+	if (!static_branch_unlikely(&scx_ops_cpu_preempt))
+		return;
 
-		list_del_init(&p->scx.dsq_list.node);
+	/*
+	 * The callback is conceptually meant to convey that the CPU is no
+	 * longer under the control of SCX. Therefore, don't invoke the callback
+	 * if the next class is below SCX (in which case the BPF scheduler has
+	 * actively decided not to schedule any tasks on the CPU).
+	 */
+	if (sched_class_above(&ext_sched_class, next_class))
+		return;
 
-		ret = dispatch_to_local_dsq(rq, p->scx.ddsp_dsq_id, p,
-					    p->scx.ddsp_enq_flags);
-		WARN_ON_ONCE(ret == DTL_NOT_LOCAL);
+	/*
+	 * At this point we know that SCX was preempted by a higher priority
+	 * sched_class, so invoke the ->cpu_release() callback if we have not
+	 * done so already. We only send the callback once between SCX being
+	 * preempted, and it regaining control of the CPU.
+	 *
+	 * ->cpu_release() complements ->cpu_acquire(), which is emitted the
+	 *  next time that balance_scx() is invoked.
+	 */
+	if (!rq->scx.cpu_released) {
+		if (SCX_HAS_OP(cpu_release)) {
+			struct scx_cpu_release_args args = {
+				.reason = preempt_reason_from_class(next_class),
+				.task = next,
+			};
+
+			SCX_CALL_OP(SCX_KF_CPU_RELEASE,
+				    cpu_release, cpu_of(rq), &args);
+		}
+		rq->scx.cpu_released = true;
 	}
 }
 
@@ -2821,69 +2884,6 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 }
 #endif	/* CONFIG_SCHED_CORE */
 
-static enum scx_cpu_preempt_reason
-preempt_reason_from_class(const struct sched_class *class)
-{
-#ifdef CONFIG_SMP
-	if (class == &stop_sched_class)
-		return SCX_CPU_PREEMPT_STOP;
-#endif
-	if (class == &dl_sched_class)
-		return SCX_CPU_PREEMPT_DL;
-	if (class == &rt_sched_class)
-		return SCX_CPU_PREEMPT_RT;
-	return SCX_CPU_PREEMPT_UNKNOWN;
-}
-
-static void switch_class_scx(struct rq *rq, struct task_struct *next)
-{
-	const struct sched_class *next_class = next->sched_class;
-
-	if (!scx_enabled())
-		return;
-#ifdef CONFIG_SMP
-	/*
-	 * Pairs with the smp_load_acquire() issued by a CPU in
-	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
-	 * resched.
-	 */
-	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
-#endif
-	if (!static_branch_unlikely(&scx_ops_cpu_preempt))
-		return;
-
-	/*
-	 * The callback is conceptually meant to convey that the CPU is no
-	 * longer under the control of SCX. Therefore, don't invoke the callback
-	 * if the next class is below SCX (in which case the BPF scheduler has
-	 * actively decided not to schedule any tasks on the CPU).
-	 */
-	if (sched_class_above(&ext_sched_class, next_class))
-		return;
-
-	/*
-	 * At this point we know that SCX was preempted by a higher priority
-	 * sched_class, so invoke the ->cpu_release() callback if we have not
-	 * done so already. We only send the callback once between SCX being
-	 * preempted, and it regaining control of the CPU.
-	 *
-	 * ->cpu_release() complements ->cpu_acquire(), which is emitted the
-	 *  next time that balance_scx() is invoked.
-	 */
-	if (!rq->scx.cpu_released) {
-		if (SCX_HAS_OP(cpu_release)) {
-			struct scx_cpu_release_args args = {
-				.reason = preempt_reason_from_class(next_class),
-				.task = next,
-			};
-
-			SCX_CALL_OP(SCX_KF_CPU_RELEASE,
-				    cpu_release, cpu_of(rq), &args);
-		}
-		rq->scx.cpu_released = true;
-	}
-}
-
 #ifdef CONFIG_SMP
 
 static bool test_and_clear_cpu_idle(int cpu)
-- 
2.46.0


