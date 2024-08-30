Return-Path: <linux-kernel+bounces-308664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CAF966004
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E48E1C2239C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E01B1D62;
	Fri, 30 Aug 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/Lxw7Mp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AF31B1D47
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015876; cv=none; b=HHryNMt2OTKVB7c3LxoZIooQM03UcjRMKjtvK5b8o1gjgO0H+UAho9koTcIzxp6QhwwlLIBW6a3GToluMxFvZLo21SHMMgKNprDnlu6MKLvIkJeIuwEaH051R00qCQLW+hCofTxWNzMA8UILEJd6X/I+zGD9jekoTLiUQW91fsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015876; c=relaxed/simple;
	bh=4aAT3sq2Akzz4xoZoBWFndyFASZxLnhjnDg4MWuOPRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYIdQW3K2hrS0auegZt1pvACpl/NlVD/hkp6zoKdG4QVnrj4/y9/Q3Q8RkhgMIIN69wd7R7vYysEIlXyh6cXn8hOaUYi1KJl+Uq8Cgh8maI/zgQyQAzL6kgSuHGOvJylcF16DrIV7cQJS9tp4m13xQhJ1Uh0RB5kDiHj+XKCMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/Lxw7Mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8E6C4CEC4;
	Fri, 30 Aug 2024 11:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015875;
	bh=4aAT3sq2Akzz4xoZoBWFndyFASZxLnhjnDg4MWuOPRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/Lxw7MpQZhsaiScUATqJ6HL88QxfgBE4VlXsbKMz2gOc9jA4OdhGF5DCw7hzaIwm
	 TkQWrulmf0BAcvHMoZIQkwu2eE5KlFsY5Zl+iGONaYyRv2wqOgO4RhNapZWSomphtW
	 TNoz+nu2zoj4tsFV6ewAiSOGWXd422x3G3LpkcNVlu8e/BPTnYP13C8+ECYyPi4HrG
	 2s7ZBh5bgrr//EOWAdy27AeuR2fKOuH8PWpPeZ6IRbIN1aUh3EXXluhkpDeeSGXd21
	 BgatVcZo7q4qgK5H0qFhba8Yx+8MZcnNv7LubYxc8b3dDn+OcAExoW4umc0POLDUoe
	 rQUjUta4sIx8Q==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Changwoo Min <multics69@gmail.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: [PATCH 10/11] sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()
Date: Fri, 30 Aug 2024 01:03:54 -1000
Message-ID: <20240830110415.116090-11-tj@kernel.org>
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

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
Cc: David Vernet <void@manifault.com>
Cc: Changwoo Min <multics69@gmail.com>
Cc: Andrea Righi <andrea.righi@linux.dev>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
---
 kernel/sched/ext.c                       | 180 ++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |   8 +
 2 files changed, 186 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index df33524d68f3..96b8cc490841 100644
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
@@ -5461,7 +5466,7 @@ __bpf_kfunc_start_defs();
  * scx_bpf_dispatch - Dispatch a task into the FIFO queue of a DSQ
  * @p: task_struct to dispatch
  * @dsq_id: DSQ to dispatch to
- * @slice: duration @p can run for in nsecs
+ * @slice: duration @p can run for in nsecs, 0 to keep the current value
  * @enq_flags: SCX_ENQ_*
  *
  * Dispatch @p into the FIFO queue of the DSQ identified by @dsq_id. It is safe
@@ -5511,7 +5516,7 @@ __bpf_kfunc void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
  * scx_bpf_dispatch_vtime - Dispatch a task into the vtime priority queue of a DSQ
  * @p: task_struct to dispatch
  * @dsq_id: DSQ to dispatch to
- * @slice: duration @p can run for in nsecs
+ * @slice: duration @p can run for in nsecs, 0 to keep the current value
  * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
  * @enq_flags: SCX_ENQ_*
  *
@@ -5552,6 +5557,117 @@ static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
 	.set			= &scx_kfunc_ids_enqueue_dispatch,
 };
 
+static bool scx_dispatch_from_dsq(struct bpf_iter_scx_dsq_kern *kit,
+				  struct task_struct *p, u64 dsq_id,
+				  u64 slice, u64 vtime, u64 enq_flags)
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
+		     u32_before(kit->dsq_seq, p->scx.dsq_seq) ||
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
+		p->scx.dsq_vtime = vtime;
+		dispatch_enqueue(dst_dsq, p, enq_flags);
+	}
+
+	if (slice)
+		p->scx.slice = slice;
+	else
+		p->scx.slice = p->scx.slice ?: 1;
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
+	return dispatched;
+}
+
 __bpf_kfunc_start_defs();
 
 /**
@@ -5631,12 +5747,70 @@ __bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
 	}
 }
 
+/**
+ * scx_bpf_dispatch_from_dsq - Move a task from DSQ iteration to a DSQ
+ * @it__iter: DSQ iterator in progress
+ * @p: task to transfer
+ * @dsq_id: DSQ to move @p to
+ * @slice: duration @p can run for in nsecs, 0 to keep the current value
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
+ * Can be called from ops.dispatch() or any BPF context which doesn't hold a rq
+ * lock (e.g. BPF timers or SYSCALL programs).
+ *
+ * Returns %true if @p has been consumed, %false if @p had already been consumed
+ * or dequeued.
+ */
+__bpf_kfunc bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter,
+					   struct task_struct *p, u64 dsq_id,
+					   u64 slice, u64 enq_flags)
+{
+	return scx_dispatch_from_dsq((struct bpf_iter_scx_dsq_kern *)it__iter,
+				     p, dsq_id, slice, 0, enq_flags);
+}
+
+/**
+ * scx_bpf_dispatch_vtime_from_dsq - Move a task from DSQ iteration to a PRIQ DSQ
+ * @it__iter: DSQ iterator in progress
+ * @p: task to transfer
+ * @dsq_id: DSQ to move @p to
+ * @slice: duration @p can run for in nsecs, 0 to keep the current value
+ * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
+ * @enq_flags: SCX_ENQ_*
+ *
+ * Transfer @p which is on the DSQ currently iterated by @it__iter to the
+ * priority queue of the DSQ specified by @dsq_id. The destination must be a
+ * user DSQ as only user DSQs support priority queue.
+ *
+ * All other aspects are identical to scx_bpf_dispatch_from_dsq(). See
+ * scx_bpf_dispatch_vtime() for more information on @vtime.
+ */
+__bpf_kfunc bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter,
+						 struct task_struct *p, u64 dsq_id,
+						 u64 slice, u64 vtime, u64 enq_flags)
+{
+	return scx_dispatch_from_dsq((struct bpf_iter_scx_dsq_kern *)it__iter,
+				     p, dsq_id, slice, vtime,
+				     enq_flags | SCX_ENQ_DSQ_PRIQ);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
 BTF_ID_FLAGS(func, scx_bpf_consume)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
@@ -5733,6 +5907,8 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
 BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 20280df62857..ef018071da31 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -35,6 +35,8 @@ void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vt
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
+bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
+bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
@@ -62,6 +64,12 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
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


