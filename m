Return-Path: <linux-kernel+bounces-314475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7DA96B3D7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677F0285E95
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04000170A0E;
	Wed,  4 Sep 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMMe7goq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FE17BECA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437010; cv=none; b=idv3afjcbw5WbLEyqBemMtEyR3ArdJ1oIaAjtk5omUftbF0xLzbwkKDU9eNOdPzKoqO1O62+yv9tKqlZzG93XGOTMJS41ITguU/jcwWFIAfMOm3RP2f1aBYmj3sPKbsiSK8mWU8QoWxMHKeOtaEsHqYtIJ/xs5apVjVPeJNbxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437010; c=relaxed/simple;
	bh=w9ru0TA7V+XoZZSfnHrgCGbcpka8zHucqxfryu4UTYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9QjN+9OymAIiRywLZ3iC3RLhFfPn7xq1Dd9BEy3mDTwWLZO+wuAixUmpoGu+dYHvnug9O86qQCviAS+HRuhAlfdWDcs+a7tUEYwhHAyctL4uCBX2hYxT7M5iNHkD5L+fZ5E5yhSo8DsGsSp57Vy8t8nzVA75WH24ubsLefwlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMMe7goq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F469C4CEC2;
	Wed,  4 Sep 2024 08:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725437009;
	bh=w9ru0TA7V+XoZZSfnHrgCGbcpka8zHucqxfryu4UTYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WMMe7goqLRPFuVmgNbjzLmHF0Ip33PV44bgnNQ6E2QHCci8tx6dBg5mm7DaYR5tZB
	 g5s5oXm1rdbqOqYzhs89LOgQ3Oxm83fZQJS+GT2HZRrctQD558vUnhkjaYPZtwiDhX
	 nBDxMLlYLFwbLSqj3Woo4KjfsJjI6J4K5ZrGgCGDR0FEOLZqwhzi50SPbyw0VKpgS0
	 kcj9w0TfcR8VRCNbiwezTc1XyTVaMO8DtIdKjun0vQFsyZx0gLX0/3NRCrl2kI6oN1
	 XPJRxQCVhvDpmkMb8ho3nzFKF4DBIZxOA2c7jZFQUGV/sy1xpqhfH0ununL3ihRxJB
	 OkU26V3DCn/bw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] sched_ext: Don't call put_prev_task_scx() before picking the next task
Date: Tue,  3 Sep 2024 22:03:03 -1000
Message-ID: <20240904080326.1132275-2-tj@kernel.org>
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

fd03c5b85855 ("sched: Rework pick_next_task()") changed the definition of
pick_next_task() from:

  pick_next_task() := pick_task() + set_next_task(.first = true)

to:

  pick_next_task(prev) := pick_task() + put_prev_task() + set_next_task(.first = true)

making invoking put_prev_task() pick_next_task()'s responsibility. This
reordering allows pick_task() to be shared between regular and core-sched
paths and put_prev_task() to know the next task.

sched_ext depended on put_prev_task_scx() enqueueing the current task before
pick_next_task_scx() is called. While pulling sched/core changes,
70cc76aa0d80 ("Merge branch 'tip/sched/core' into for-6.12") added an
explicit put_prev_task_scx() call for SCX tasks in pick_next_task_scx()
before picking the first task as a workaround.

Clean it up and adopt the conventions that other sched classes are
following.

The operation of keeping running the current task was spread and required
the task to be put on the local DSQ before picking:

  - balance_one() used SCX_TASK_BAL_KEEP to indicate that the task is still
    runnable, hasn't exhausted its slice, and thus should keep running.

  - put_prev_task_scx() enqueued the task to local DSQ if SCX_TASK_BAL_KEEP
    is set. It also called do_enqueue_task() with SCX_ENQ_LAST if it is the
    only runnable task. do_enqueue_task() in turn decided whether to use the
    local DSQ depending on SCX_OPS_ENQ_LAST.

Consolidate the logic in balance_one() as it always knows whether it is
going to keep the current task. balance_one() now considers all conditions
where the current task should be kept and uses SCX_TASK_BAL_KEEP to tell
pick_next_task_scx() to keep the current task instead of picking one from
the local DSQ. Accordingly, SCX_ENQ_LAST handling is removed from
put_prev_task_scx() and do_enqueue_task() and pick_next_task_scx() is
updated to pick the current task if SCX_TASK_BAL_KEEP is set.

The workaround put_prev_task[_scx]() calls are replaced with
put_prev_set_next_task().

This causes two behavior changes observable from the BPF scheduler:

- When a task keep running, it no longer goes through enqueue/dequeue cycle
  and thus ops.stopping/running() transitions. The new behavior is better
  and all the existing schedulers should be able to handle the new behavior.

- The BPF scheduler cannot keep executing the current task by enqueueing
  SCX_ENQ_LAST task to the local DSQ. If SCX_OPS_ENQ_LAST is specified, the
  BPF scheduler is responsible for resuming execution after each
  SCX_ENQ_LAST. SCX_OPS_ENQ_LAST is mostly useful for cases where scheduling
  decisions are not made on the local CPU - e.g. central or userspace-driven
  schedulin - and the new behavior is more logical and shouldn't pose any
  problems. SCX_OPS_ENQ_LAST demonstration from scx_qmap is dropped as it
  doesn't fit that well anymore and the last task handling is moved to the
  end of qmap_dispatch().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c             | 130 ++++++++++++++++-----------------
 tools/sched_ext/scx_qmap.bpf.c |  22 +++++-
 2 files changed, 80 insertions(+), 72 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5e862c7c0e6b..be86dbfa75a8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -630,11 +630,8 @@ enum scx_enq_flags {
 	 * %SCX_OPS_ENQ_LAST is specified, they're ops.enqueue()'d with the
 	 * %SCX_ENQ_LAST flag set.
 	 *
-	 * If the BPF scheduler wants to continue executing the task,
-	 * ops.enqueue() should dispatch the task to %SCX_DSQ_LOCAL immediately.
-	 * If the task gets queued on a different dsq or the BPF side, the BPF
-	 * scheduler is responsible for triggering a follow-up scheduling event.
-	 * Otherwise, Execution may stall.
+	 * The BPF scheduler is responsible for triggering a follow-up
+	 * scheduling event. Otherwise, Execution may stall.
 	 */
 	SCX_ENQ_LAST		= 1LLU << 41,
 
@@ -1852,12 +1849,8 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (!scx_rq_online(rq))
 		goto local;
 
-	if (scx_ops_bypassing()) {
-		if (enq_flags & SCX_ENQ_LAST)
-			goto local;
-		else
-			goto global;
-	}
+	if (scx_ops_bypassing())
+		goto global;
 
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
 		goto direct;
@@ -1867,11 +1860,6 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	    unlikely(p->flags & PF_EXITING))
 		goto local;
 
-	/* see %SCX_OPS_ENQ_LAST */
-	if (!static_branch_unlikely(&scx_ops_enq_last) &&
-	    (enq_flags & SCX_ENQ_LAST))
-		goto local;
-
 	if (!SCX_HAS_OP(enqueue))
 		goto global;
 
@@ -2517,7 +2505,6 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
-	bool has_tasks = false;
 
 	lockdep_assert_rq_held(rq);
 	rq->scx.flags |= SCX_RQ_IN_BALANCE;
@@ -2542,9 +2529,9 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 		/*
 		 * If @prev is runnable & has slice left, it has priority and
 		 * fetching more just increases latency for the fetched tasks.
-		 * Tell put_prev_task_scx() to put @prev on local_dsq. If the
-		 * BPF scheduler wants to handle this explicitly, it should
-		 * implement ->cpu_released().
+		 * Tell pick_next_task_scx() to keep running @prev. If the BPF
+		 * scheduler wants to handle this explicitly, it should
+		 * implement ->cpu_release().
 		 *
 		 * See scx_ops_disable_workfn() for the explanation on the
 		 * bypassing test.
@@ -2570,7 +2557,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 		goto has_tasks;
 
 	if (!SCX_HAS_OP(dispatch) || scx_ops_bypassing() || !scx_rq_online(rq))
-		goto out;
+		goto no_tasks;
 
 	dspc->rq = rq;
 
@@ -2609,13 +2596,23 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 		}
 	} while (dspc->nr_tasks);
 
-	goto out;
+no_tasks:
+	/*
+	 * Didn't find another task to run. Keep running @prev unless
+	 * %SCX_OPS_ENQ_LAST is in effect.
+	 */
+	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
+	    (!static_branch_unlikely(&scx_ops_enq_last) || scx_ops_bypassing())) {
+		if (local)
+			prev->scx.flags |= SCX_TASK_BAL_KEEP;
+		goto has_tasks;
+	}
+	rq->scx.flags &= ~SCX_RQ_IN_BALANCE;
+	return false;
 
 has_tasks:
-	has_tasks = true;
-out:
 	rq->scx.flags &= ~SCX_RQ_IN_BALANCE;
-	return has_tasks;
+	return true;
 }
 
 static int balance_scx(struct rq *rq, struct task_struct *prev,
@@ -2728,25 +2725,16 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
 		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, true);
 
-	/*
-	 * If we're being called from put_prev_task_balance(), balance_scx() may
-	 * have decided that @p should keep running.
-	 */
-	if (p->scx.flags & SCX_TASK_BAL_KEEP) {
+	if (p->scx.flags & SCX_TASK_QUEUED) {
 		p->scx.flags &= ~SCX_TASK_BAL_KEEP;
-		set_task_runnable(rq, p);
-		dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
-		return;
-	}
 
-	if (p->scx.flags & SCX_TASK_QUEUED) {
 		set_task_runnable(rq, p);
 
 		/*
-		 * If @p has slice left and balance_scx() didn't tag it for
-		 * keeping, @p is getting preempted by a higher priority
-		 * scheduler class or core-sched forcing a different task. Leave
-		 * it at the head of the local DSQ.
+		 * If @p has slice left and is being put, @p is getting
+		 * preempted by a higher priority scheduler class or core-sched
+		 * forcing a different task. Leave it at the head of the local
+		 * DSQ.
 		 */
 		if (p->scx.slice && !scx_ops_bypassing()) {
 			dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
@@ -2754,18 +2742,17 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		}
 
 		/*
-		 * If we're in the pick_next_task path, balance_scx() should
-		 * have already populated the local DSQ if there are any other
-		 * available tasks. If empty, tell ops.enqueue() that @p is the
-		 * only one available for this cpu. ops.enqueue() should put it
-		 * on the local DSQ so that the subsequent pick_next_task_scx()
-		 * can find the task unless it wants to trigger a separate
-		 * follow-up scheduling event.
+		 * If @p is runnable but we're about to enter a lower
+		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
+		 * ops.enqueue() that @p is the only one available for this cpu,
+		 * which should trigger an explicit follow-up scheduling event.
 		 */
-		if (list_empty(&rq->scx.local_dsq.list))
+		if (sched_class_above(&ext_sched_class, next->sched_class)) {
+			WARN_ON_ONCE(!static_branch_unlikely(&scx_ops_enq_last));
 			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
-		else
+		} else {
 			do_enqueue_task(rq, p, 0, -1);
+		}
 	}
 }
 
@@ -2780,27 +2767,33 @@ static struct task_struct *pick_next_task_scx(struct rq *rq,
 {
 	struct task_struct *p;
 
-	if (prev->sched_class == &ext_sched_class)
-		put_prev_task_scx(rq, prev, NULL);
-
-	p = first_local_task(rq);
-	if (!p)
-		return NULL;
-
-	if (prev->sched_class != &ext_sched_class)
-		prev->sched_class->put_prev_task(rq, prev, p);
-
-	set_next_task_scx(rq, p, true);
+	/*
+	 * If balance_scx() is telling us to keep running @prev, replenish slice
+	 * if necessary and keep running @prev. Otherwise, pop the first one
+	 * from the local DSQ.
+	 */
+	if (prev->scx.flags & SCX_TASK_BAL_KEEP) {
+		prev->scx.flags &= ~SCX_TASK_BAL_KEEP;
+		p = prev;
+		if (!p->scx.slice)
+			p->scx.slice = SCX_SLICE_DFL;
+	} else {
+		p = first_local_task(rq);
+		if (!p)
+			return NULL;
 
-	if (unlikely(!p->scx.slice)) {
-		if (!scx_ops_bypassing() && !scx_warned_zero_slice) {
-			printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
-					p->comm, p->pid);
-			scx_warned_zero_slice = true;
+		if (unlikely(!p->scx.slice)) {
+			if (!scx_ops_bypassing() && !scx_warned_zero_slice) {
+				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
+						p->comm, p->pid);
+				scx_warned_zero_slice = true;
+			}
+			p->scx.slice = SCX_SLICE_DFL;
 		}
-		p->scx.slice = SCX_SLICE_DFL;
 	}
 
+	put_prev_set_next_task(rq, prev, p);
+
 	return p;
 }
 
@@ -3875,12 +3868,13 @@ bool task_should_scx(struct task_struct *p)
  * to force global FIFO scheduling.
  *
  * a. ops.enqueue() is ignored and tasks are queued in simple global FIFO order.
+ *    %SCX_OPS_ENQ_LAST is also ignored.
  *
  * b. ops.dispatch() is ignored.
  *
- * c. balance_scx() never sets %SCX_TASK_BAL_KEEP as the slice value can't be
- *    trusted. Whenever a tick triggers, the running task is rotated to the tail
- *    of the queue with core_sched_at touched.
+ * c. balance_scx() does not set %SCX_TASK_BAL_KEEP on non-zero slice as slice
+ *    can't be trusted. Whenever a tick triggers, the running task is rotated to
+ *    the tail of the queue with core_sched_at touched.
  *
  * d. pick_next_task() suppresses zero slice warning.
  *
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 892278f12dce..7e7f28f4117e 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -205,8 +205,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 
 	/*
 	 * All enqueued tasks must have their core_sched_seq updated for correct
-	 * core-sched ordering, which is why %SCX_OPS_ENQ_LAST is specified in
-	 * qmap_ops.flags.
+	 * core-sched ordering. Also, take a look at the end of qmap_dispatch().
 	 */
 	tctx->core_sched_seq = core_sched_tail_seqs[idx]++;
 
@@ -214,7 +213,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	 * If qmap_select_cpu() is telling us to or this is the last runnable
 	 * task on the CPU, enqueue locally.
 	 */
-	if (tctx->force_local || (enq_flags & SCX_ENQ_LAST)) {
+	if (tctx->force_local) {
 		tctx->force_local = false;
 		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
 		return;
@@ -285,6 +284,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 {
 	struct task_struct *p;
 	struct cpu_ctx *cpuc;
+	struct task_ctx *tctx;
 	u32 zero = 0, batch = dsp_batch ?: 1;
 	void *fifo;
 	s32 i, pid;
@@ -349,6 +349,21 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 
 		cpuc->dsp_cnt = 0;
 	}
+
+	/*
+	 * No other tasks. @prev will keep running. Update its core_sched_seq as
+	 * if the task were enqueued and dispatched immediately.
+	 */
+	if (prev) {
+		tctx = bpf_task_storage_get(&task_ctx_stor, prev, 0, 0);
+		if (!tctx) {
+			scx_bpf_error("task_ctx lookup failed");
+			return;
+		}
+
+		tctx->core_sched_seq =
+			core_sched_tail_seqs[weight_to_idx(prev->scx.weight)]++;
+	}
 }
 
 void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
@@ -701,6 +716,5 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .cpu_offline		= (void *)qmap_cpu_offline,
 	       .init			= (void *)qmap_init,
 	       .exit			= (void *)qmap_exit,
-	       .flags			= SCX_OPS_ENQ_LAST,
 	       .timeout_ms		= 5000U,
 	       .name			= "qmap");
-- 
2.46.0


