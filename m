Return-Path: <linux-kernel+bounces-310315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 396EC967981
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55EF2821DE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECC1187344;
	Sun,  1 Sep 2024 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTdvTJLC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C1185952
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209072; cv=none; b=jbMG/nscQ/yGCXK8LfaAfb4GErwqPAAaCLxAeh1cot0VxdXXnQB5MqkZf2nMpc2T5sOdeH3UcL9hkYlEH+iEq7Ff+WqY5Yfdxc70p8+uejCae6XqSEYzPtYT1cfGVUhKNLAZaXIyP5rdaMp/oLYrzPT33Z3KdKp8LQ1RNbgwxko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209072; c=relaxed/simple;
	bh=5ffLQM7fiROFzti5Gd4TGiwIKYlmSITZeZFHfYmHpG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwQonzJf7YgHZGkXfT7bxEz4FHo9ZeyJXVFXwD3BWZCO/cPeyFd66BIGuTmXW0wJFaEiZeWXROadlOLLVnjItifAch2tP1LCGAY8tKc2TWr42y9RtaXvTzmaOQpFryHzV1IjE1VGL3ncoIaNGsBP0h0onwWy19WJws/aw1LAXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTdvTJLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB25BC4CECB;
	Sun,  1 Sep 2024 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725209071;
	bh=5ffLQM7fiROFzti5Gd4TGiwIKYlmSITZeZFHfYmHpG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTdvTJLCVdkryox3zYqXsmQPNbrrJvk585jDxKWy9y03iqFrYWbRHVrTX/YYxZ+U+
	 kVVlR46YdjPYrfupRAaSl03N7LBWpGJ3KrcdJu9vdsV7K1tGatJtTDL3BuLmrk3ORX
	 nN501cgjjPRi9R68MLifU5TITUr5ypk52mIwo3cMgGoWPIPaWoGSxZwLmkh5JgcVIp
	 GznQ1T8CQFWGAlioDZnJlNXmqGlxgqTx6jFYvHBEdCfEjUvL48MkJYBSrQLsiykDMQ
	 vSh30/hqCZx3h+ADOIyK0e3lSLIaUDDn0RiJsBz4MN9jar2lny7QJkmKCRUCuMu1C1
	 RqcF6C5qt2Mnw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Changwoo Min <multics69@gmail.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: [PATCH 11/12] sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()
Date: Sun,  1 Sep 2024 06:43:48 -1000
Message-ID: <20240901164417.779239-12-tj@kernel.org>
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

Once a task is put into a DSQ, the allowed operations are fairly limited.
Tasks in the built-in local and global DSQs are executed automatically and,
ignoring dequeue, there is only one way a task in a user DSQ can be
manipulated - scx_bpf_consume() moves the first task to the dispatching
local DSQ. This inflexibility sometimes gets in the way and is an area where
multiple feature requests have been made.

Implement scx_bpf_dispatch[_vtime]_from_dsq(), which can be called during
DSQ iteration and can move the task to any DSQ - local DSQs, global DSQ and
user DSQs. The kfuncs can be called from ops.dispatch() and any BPF context
which dosen't hold a rq lock including BPF timers and SYSCALL programs.

This is an expansion of an earlier patch which only allowed moving into the
dispatching local DSQ:

  http://lkml.kernel.org/r/Zn4Cw4FDTmvXnhaf@slm.duckdns.org

v2: Remove @slice and @vtime from scx_bpf_dispatch_from_dsq[_vtime]() as
    they push scx_bpf_dispatch_from_dsq_vtime() over the kfunc argument
    count limit and often won't be needed anyway. Instead provide
    scx_bpf_dispatch_from_dsq_set_{slice|vtime}() kfuncs which can be called
    only when needed and override the specified parameter for the subsequent
    dispatch.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
Cc: David Vernet <void@manifault.com>
Cc: Changwoo Min <multics69@gmail.com>
Cc: Andrea Righi <andrea.righi@linux.dev>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 kernel/sched/ext.c                       | 232 ++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |  10 +
 2 files changed, 239 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 28f421227b5b..cb048e264866 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1067,6 +1067,11 @@ static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
 	return true;
 }
 
+static bool scx_kf_allowed_if_unlocked(void)
+{
+	return !current->scx.kf_mask;
+}
+
 /**
  * nldsq_next_task - Iterate to the next task in a non-local DSQ
  * @dsq: user dsq being interated
@@ -1120,13 +1125,20 @@ enum scx_dsq_iter_flags {
 	/* iterate in the reverse dispatch order */
 	SCX_DSQ_ITER_REV		= 1U << 16,
 
+	__SCX_DSQ_ITER_HAS_SLICE	= 1U << 30,
+	__SCX_DSQ_ITER_HAS_VTIME	= 1U << 31,
+
 	__SCX_DSQ_ITER_USER_FLAGS	= SCX_DSQ_ITER_REV,
-	__SCX_DSQ_ITER_ALL_FLAGS	= __SCX_DSQ_ITER_USER_FLAGS,
+	__SCX_DSQ_ITER_ALL_FLAGS	= __SCX_DSQ_ITER_USER_FLAGS |
+					  __SCX_DSQ_ITER_HAS_SLICE |
+					  __SCX_DSQ_ITER_HAS_VTIME,
 };
 
 struct bpf_iter_scx_dsq_kern {
 	struct scx_dsq_list_node	cursor;
 	struct scx_dispatch_q		*dsq;
+	u64				slice;
+	u64				vtime;
 } __attribute__((aligned(8)));
 
 struct bpf_iter_scx_dsq {
@@ -5463,7 +5475,7 @@ __bpf_kfunc_start_defs();
  * scx_bpf_dispatch - Dispatch a task into the FIFO queue of a DSQ
  * @p: task_struct to dispatch
  * @dsq_id: DSQ to dispatch to
- * @slice: duration @p can run for in nsecs
+ * @slice: duration @p can run for in nsecs, 0 to keep the current value
  * @enq_flags: SCX_ENQ_*
  *
  * Dispatch @p into the FIFO queue of the DSQ identified by @dsq_id. It is safe
@@ -5513,7 +5525,7 @@ __bpf_kfunc void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
  * scx_bpf_dispatch_vtime - Dispatch a task into the vtime priority queue of a DSQ
  * @p: task_struct to dispatch
  * @dsq_id: DSQ to dispatch to
- * @slice: duration @p can run for in nsecs
+ * @slice: duration @p can run for in nsecs, 0 to keep the current value
  * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
  * @enq_flags: SCX_ENQ_*
  *
@@ -5554,6 +5566,118 @@ static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
 	.set			= &scx_kfunc_ids_enqueue_dispatch,
 };
 
+static bool scx_dispatch_from_dsq(struct bpf_iter_scx_dsq_kern *kit,
+				  struct task_struct *p, u64 dsq_id,
+				  u64 enq_flags)
+{
+	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
+	struct rq *this_rq, *src_rq, *dst_rq, *locked_rq;
+	bool dispatched = false;
+	bool in_balance;
+	unsigned long flags;
+
+	if (!scx_kf_allowed_if_unlocked() && !scx_kf_allowed(SCX_KF_DISPATCH))
+		return false;
+
+	/*
+	 * Can be called from either ops.dispatch() locking this_rq() or any
+	 * context where no rq lock is held. If latter, lock @p's task_rq which
+	 * we'll likely need anyway.
+	 */
+	src_rq = task_rq(p);
+
+	local_irq_save(flags);
+	this_rq = this_rq();
+	in_balance = this_rq->scx.flags & SCX_RQ_IN_BALANCE;
+
+	if (in_balance) {
+		if (this_rq != src_rq) {
+			raw_spin_rq_unlock(this_rq);
+			raw_spin_rq_lock(src_rq);
+		}
+	} else {
+		raw_spin_rq_lock(src_rq);
+	}
+
+	locked_rq = src_rq;
+	raw_spin_lock(&src_dsq->lock);
+
+	/*
+	 * Did someone else get to it? @p could have already left $src_dsq, got
+	 * re-enqueud, or be in the process of being consumed by someone else.
+	 */
+	if (unlikely(p->scx.dsq != src_dsq ||
+		     u32_before(kit->cursor.priv, p->scx.dsq_seq) ||
+		     p->scx.holding_cpu >= 0) ||
+	    WARN_ON_ONCE(src_rq != task_rq(p))) {
+		raw_spin_unlock(&src_dsq->lock);
+		goto out;
+	}
+
+	/* @p is still on $src_dsq and stable, determine the destination */
+	dst_dsq = find_dsq_for_dispatch(this_rq, dsq_id, p);
+
+	if (dst_dsq->id == SCX_DSQ_LOCAL) {
+		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
+		if (!task_can_run_on_remote_rq(p, dst_rq, true)) {
+			dst_dsq = &scx_dsq_global;
+			dst_rq = src_rq;
+		}
+	} else {
+		/* no need to migrate if destination is a non-local DSQ */
+		dst_rq = src_rq;
+	}
+
+	/*
+	 * Move @p into $dst_dsq. If $dst_dsq is the local DSQ of a different
+	 * CPU, @p will be migrated.
+	 */
+	if (dst_dsq->id == SCX_DSQ_LOCAL) {
+		/* @p is going from a non-local DSQ to a local DSQ */
+		if (src_rq == dst_rq) {
+			task_unlink_from_dsq(p, src_dsq);
+			move_local_task_to_local_dsq(p, enq_flags,
+						     src_dsq, dst_rq);
+			raw_spin_unlock(&src_dsq->lock);
+		} else {
+			raw_spin_unlock(&src_dsq->lock);
+			move_remote_task_to_local_dsq(p, enq_flags,
+						      src_rq, dst_rq);
+			locked_rq = dst_rq;
+		}
+	} else {
+		/*
+		 * @p is going from a non-local DSQ to a non-local DSQ. As
+		 * $src_dsq is already locked, do an abbreviated dequeue.
+		 */
+		task_unlink_from_dsq(p, src_dsq);
+		p->scx.dsq = NULL;
+		raw_spin_unlock(&src_dsq->lock);
+
+		if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
+			p->scx.dsq_vtime = kit->vtime;
+		dispatch_enqueue(dst_dsq, p, enq_flags);
+	}
+
+	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_SLICE)
+		p->scx.slice = kit->slice;
+
+	dispatched = true;
+out:
+	if (in_balance) {
+		if (this_rq != locked_rq) {
+			raw_spin_rq_unlock(locked_rq);
+			raw_spin_rq_lock(this_rq);
+		}
+	} else {
+		raw_spin_rq_unlock_irqrestore(locked_rq, flags);
+	}
+
+	kit->cursor.flags &= ~(__SCX_DSQ_ITER_HAS_SLICE |
+			       __SCX_DSQ_ITER_HAS_VTIME);
+	return dispatched;
+}
+
 __bpf_kfunc_start_defs();
 
 /**
@@ -5633,12 +5757,112 @@ __bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
 	}
 }
 
+/**
+ * scx_bpf_dispatch_from_dsq_set_slice - Override slice when dispatching from DSQ
+ * @it__iter: DSQ iterator in progress
+ * @slice: duration the dispatched task can run for in nsecs
+ *
+ * Override the slice of the next task that will be dispatched from @it__iter
+ * using scx_bpf_dispatch_from_dsq[_vtime](). If this function is not called,
+ * the previous slice duration is kept.
+ */
+__bpf_kfunc void scx_bpf_dispatch_from_dsq_set_slice(
+				struct bpf_iter_scx_dsq *it__iter, u64 slice)
+{
+	struct bpf_iter_scx_dsq_kern *kit = (void *)it__iter;
+
+	kit->slice = slice;
+	kit->cursor.flags |= __SCX_DSQ_ITER_HAS_SLICE;
+}
+
+/**
+ * scx_bpf_dispatch_from_dsq_set_vtime - Override vtime when dispatching from DSQ
+ * @it__iter: DSQ iterator in progress
+ * @vtime: task's ordering inside the vtime-sorted queue of the target DSQ
+ *
+ * Override the vtime of the next task that will be dispatched from @it__iter
+ * using scx_bpf_dispatch_from_dsq_vtime(). If this function is not called, the
+ * previous slice vtime is kept. If scx_bpf_dispatch_from_dsq() is used to
+ * dispatch the next task, the override is ignored and cleared.
+ */
+__bpf_kfunc void scx_bpf_dispatch_from_dsq_set_vtime(
+				struct bpf_iter_scx_dsq *it__iter, u64 vtime)
+{
+	struct bpf_iter_scx_dsq_kern *kit = (void *)it__iter;
+
+	kit->vtime = vtime;
+	kit->cursor.flags |= __SCX_DSQ_ITER_HAS_VTIME;
+}
+
+/**
+ * scx_bpf_dispatch_from_dsq - Move a task from DSQ iteration to a DSQ
+ * @it__iter: DSQ iterator in progress
+ * @p: task to transfer
+ * @dsq_id: DSQ to move @p to
+ * @enq_flags: SCX_ENQ_*
+ *
+ * Transfer @p which is on the DSQ currently iterated by @it__iter to the DSQ
+ * specified by @dsq_id. All DSQs - local DSQs, global DSQ and user DSQs - can
+ * be the destination.
+ *
+ * For the transfer to be successful, @p must still be on the DSQ and have been
+ * queued before the DSQ iteration started. This function doesn't care whether
+ * @p was obtained from the DSQ iteration. @p just has to be on the DSQ and have
+ * been queued before the iteration started.
+ *
+ * @p's slice is kept by default. Use scx_bpf_dispatch_from_dsq_set_slice() to
+ * update.
+ *
+ * Can be called from ops.dispatch() or any BPF context which doesn't hold a rq
+ * lock (e.g. BPF timers or SYSCALL programs).
+ *
+ * Returns %true if @p has been consumed, %false if @p had already been consumed
+ * or dequeued.
+ */
+__bpf_kfunc bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter,
+					   struct task_struct *p, u64 dsq_id,
+					   u64 enq_flags)
+{
+	return scx_dispatch_from_dsq((struct bpf_iter_scx_dsq_kern *)it__iter,
+				     p, dsq_id, enq_flags);
+}
+
+/**
+ * scx_bpf_dispatch_vtime_from_dsq - Move a task from DSQ iteration to a PRIQ DSQ
+ * @it__iter: DSQ iterator in progress
+ * @p: task to transfer
+ * @dsq_id: DSQ to move @p to
+ * @enq_flags: SCX_ENQ_*
+ *
+ * Transfer @p which is on the DSQ currently iterated by @it__iter to the
+ * priority queue of the DSQ specified by @dsq_id. The destination must be a
+ * user DSQ as only user DSQs support priority queue.
+ *
+ * @p's slice and vtime are kept by default. Use
+ * scx_bpf_dispatch_from_dsq_set_slice() and
+ * scx_bpf_dispatch_from_dsq_set_vtime() to update.
+ *
+ * All other aspects are identical to scx_bpf_dispatch_from_dsq(). See
+ * scx_bpf_dispatch_vtime() for more information on @vtime.
+ */
+__bpf_kfunc bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter,
+						 struct task_struct *p, u64 dsq_id,
+						 u64 enq_flags)
+{
+	return scx_dispatch_from_dsq((struct bpf_iter_scx_dsq_kern *)it__iter,
+				     p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
 BTF_ID_FLAGS(func, scx_bpf_consume)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
@@ -5735,6 +5959,8 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
 BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 20280df62857..c8fe21f65d14 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -35,6 +35,10 @@ void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vt
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
+void scx_bpf_dispatch_from_dsq_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym;
+void scx_bpf_dispatch_from_dsq_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym;
+bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
+bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
@@ -62,6 +66,12 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 
+/*
+ * Use the following as @it__iter when calling
+ * scx_bpf_dispatch[_vtime]_from_dsq() from within bpf_for_each() loops.
+ */
+#define BPF_FOR_EACH_ITER	(&___it)
+
 static inline __attribute__((format(printf, 1, 2)))
 void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
 
-- 
2.46.0


