Return-Path: <linux-kernel+bounces-314477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6834A96B3D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA9AFB2406F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B5D185B4E;
	Wed,  4 Sep 2024 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5xZrZcB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A4D185926
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437012; cv=none; b=bR+3aPkhHwBxnSicshyb0937yfqk8pz+MXnIJrLRCOMX457W9f1YCeJXOnmVwq2LznX6LyxGZvliXAZuVc/j27d1WWXeEf9SRbIUHHTGYFzd4GePBT+c9Bvy/UoiZc4HE7Ef5s0xrc3C8CfcFiHsznsO0jCL20OXqhHpR7CL4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437012; c=relaxed/simple;
	bh=WOto16sbTmRalaWW0+tLLCpOWKB/EQaf1OAbcZIYON8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jweih75+Sdn64ayHenchNBbsvriutK4uQlqPbbXyjfvBvJDp4TKo15g7nR+brRBQtQigag9zGX/rwNv91UBaTN5Az3T3SPmk5emR+aQFjnzcmA45RAAPZ3TXV977dJXnRflaS5imsnJ1mgr17HqZstNEEpkbFzxiYS7Z8E33JEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5xZrZcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B924C4CECC;
	Wed,  4 Sep 2024 08:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725437011;
	bh=WOto16sbTmRalaWW0+tLLCpOWKB/EQaf1OAbcZIYON8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5xZrZcBFH5guzVa9OCHcisMFU6vd/6J57In/icUExtAO73wLGFZR4TTFP4eHDt6N
	 nWQVEATXqVY4LklsEOfgcr9khvb79+0XftcU0TeNEU74USsy0V4XH7/DF63IlHTQvf
	 1YE45dEonJw0x+lDTtCVAALqdMRynirexoYGgnvIKhmtzNFcmB/Q93Snhsd3c1/11l
	 9zG8PsHPpjq7tMdfmBK4ZXCLQfx71UC/BvoGHog72PUPjr/x1JsRMKHnE9zGoyV7qb
	 txMvxp/P8LocRB+sDdnFlUza7MnzeLHFJ/YaJRxXR6qxsLml2aaGMR7+2LjMScfKRf
	 8sL4UU7PnmPsQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] sched_ext: Unify regular and core-sched pick task paths
Date: Tue,  3 Sep 2024 22:03:05 -1000
Message-ID: <20240904080326.1132275-4-tj@kernel.org>
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

Because the BPF scheduler's dispatch path is invoked from balance(),
sched_ext needs to invoke balance_one() on all sibling rq's before picking
the next task for core-sched.

Before the recent pick_next_task() updates, sched_ext couldn't share pick
task between regular and core-sched paths because pick_next_task() depended
on put_prev_task() being called on the current task. Tasks currently running
on sibling rq's can't be put when one rq is trying to pick the next task, so
pick_task_scx() had to have a separate mechanism to pick between a sibling
rq's current task and the first task in its local DSQ.

However, with the preceding updates, pick_next_task_scx() no longer depends
on the current task being put and can compare the current task and the next
in line statelessly, and the pick task logic should be shareable between
regular and core-sched paths.

Unify regular and core-sched pick task paths:

- There's no reason to distinguish local and sibling picks anymore. @local
  is removed from balance_one().

- pick_next_task_scx() is turned into pick_task_scx() by dropping the
  put_prev_set_next_task() call.

- The old pick_task_scx() is dropped.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 78 +++++++---------------------------------------
 1 file changed, 11 insertions(+), 67 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fd979c69de1f..d568b40178e6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2500,7 +2500,7 @@ static void flush_dispatch_buf(struct rq *rq)
 	dspc->cursor = 0;
 }
 
-static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
+static int balance_one(struct rq *rq, struct task_struct *prev)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
@@ -2529,22 +2529,16 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 		/*
 		 * If @prev is runnable & has slice left, it has priority and
 		 * fetching more just increases latency for the fetched tasks.
-		 * Tell pick_next_task_scx() to keep running @prev. If the BPF
+		 * Tell pick_task_scx() to keep running @prev. If the BPF
 		 * scheduler wants to handle this explicitly, it should
 		 * implement ->cpu_release().
 		 *
 		 * See scx_ops_disable_workfn() for the explanation on the
 		 * bypassing test.
-		 *
-		 * When balancing a remote CPU for core-sched, there won't be a
-		 * following put_prev_task_scx() call and we don't own
-		 * %SCX_RQ_BAL_KEEP. Instead, pick_task_scx() will test the same
-		 * conditions later and pick @rq->curr accordingly.
 		 */
 		if ((prev->scx.flags & SCX_TASK_QUEUED) &&
 		    prev->scx.slice && !scx_ops_bypassing()) {
-			if (local)
-				rq->scx.flags |= SCX_RQ_BAL_KEEP;
+			rq->scx.flags |= SCX_RQ_BAL_KEEP;
 			goto has_tasks;
 		}
 	}
@@ -2603,8 +2597,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 	 */
 	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
 	    (!static_branch_unlikely(&scx_ops_enq_last) || scx_ops_bypassing())) {
-		if (local)
-			rq->scx.flags |= SCX_RQ_BAL_KEEP;
+		rq->scx.flags |= SCX_RQ_BAL_KEEP;
 		goto has_tasks;
 	}
 	rq->scx.flags &= ~SCX_RQ_IN_BALANCE;
@@ -2622,13 +2615,13 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 
 	rq_unpin_lock(rq, rf);
 
-	ret = balance_one(rq, prev, true);
+	ret = balance_one(rq, prev);
 
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * When core-sched is enabled, this ops.balance() call will be followed
-	 * by put_prev_scx() and pick_task_scx() on this CPU and pick_task_scx()
-	 * on the SMT siblings. Balance the siblings too.
+	 * by pick_task_scx() on this CPU and the SMT siblings. Balance the
+	 * siblings too.
 	 */
 	if (sched_core_enabled(rq)) {
 		const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
@@ -2640,7 +2633,7 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 
 			WARN_ON_ONCE(__rq_lockp(rq) != __rq_lockp(srq));
 			update_rq_clock(srq);
-			balance_one(srq, sprev, false);
+			balance_one(srq, sprev);
 		}
 	}
 #endif
@@ -2760,9 +2753,9 @@ static struct task_struct *first_local_task(struct rq *rq)
 					struct task_struct, scx.dsq_list.node);
 }
 
-static struct task_struct *pick_next_task_scx(struct rq *rq,
-					      struct task_struct *prev)
+static struct task_struct *pick_task_scx(struct rq *rq)
 {
+	struct task_struct *prev = rq->curr;
 	struct task_struct *p;
 
 	/*
@@ -2790,8 +2783,6 @@ static struct task_struct *pick_next_task_scx(struct rq *rq,
 		}
 	}
 
-	put_prev_set_next_task(rq, prev, p);
-
 	return p;
 }
 
@@ -2828,49 +2819,6 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	else
 		return time_after64(a->scx.core_sched_at, b->scx.core_sched_at);
 }
-
-/**
- * pick_task_scx - Pick a candidate task for core-sched
- * @rq: rq to pick the candidate task from
- *
- * Core-sched calls this function on each SMT sibling to determine the next
- * tasks to run on the SMT siblings. balance_one() has been called on all
- * siblings and put_prev_task_scx() has been called only for the current CPU.
- *
- * As put_prev_task_scx() hasn't been called on remote CPUs, we can't just look
- * at the first task in the local dsq. @rq->curr has to be considered explicitly
- * to mimic %SCX_RQ_BAL_KEEP.
- */
-static struct task_struct *pick_task_scx(struct rq *rq)
-{
-	struct task_struct *curr = rq->curr;
-	struct task_struct *first = first_local_task(rq);
-
-	if (curr->scx.flags & SCX_TASK_QUEUED) {
-		/* is curr the only runnable task? */
-		if (!first)
-			return curr;
-
-		/*
-		 * Does curr trump first? We can always go by core_sched_at for
-		 * this comparison as it represents global FIFO ordering when
-		 * the default core-sched ordering is used and local-DSQ FIFO
-		 * ordering otherwise.
-		 *
-		 * We can have a task with an earlier timestamp on the DSQ. For
-		 * example, when a current task is preempted by a sibling
-		 * picking a different cookie, the task would be requeued at the
-		 * head of the local DSQ with an earlier timestamp than the
-		 * core-sched picked next task. Besides, the BPF scheduler may
-		 * dispatch any tasks to the local DSQ anytime.
-		 */
-		if (curr->scx.slice && time_before64(curr->scx.core_sched_at,
-						     first->scx.core_sched_at))
-			return curr;
-	}
-
-	return first;	/* this may be %NULL */
-}
 #endif	/* CONFIG_SCHED_CORE */
 
 static enum scx_cpu_preempt_reason
@@ -3638,7 +3586,7 @@ DEFINE_SCHED_CLASS(ext) = {
 	.wakeup_preempt		= wakeup_preempt_scx,
 
 	.balance		= balance_scx,
-	.pick_next_task		= pick_next_task_scx,
+	.pick_task		= pick_task_scx,
 
 	.put_prev_task		= put_prev_task_scx,
 	.set_next_task		= set_next_task_scx,
@@ -3654,10 +3602,6 @@ DEFINE_SCHED_CLASS(ext) = {
 	.rq_offline		= rq_offline_scx,
 #endif
 
-#ifdef CONFIG_SCHED_CORE
-	.pick_task		= pick_task_scx,
-#endif
-
 	.task_tick		= task_tick_scx,
 
 	.switching_to		= switching_to_scx,
-- 
2.46.0


