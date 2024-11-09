Return-Path: <linux-kernel+bounces-402998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D4C9C2F63
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 20:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C131C214C2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A21A256A;
	Sat,  9 Nov 2024 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMBqowIz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E471A0BF2
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 19:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731181739; cv=none; b=eRojO2lhEKMgz48He+BkssmLM+nRekEWrh1Oy+SH0JdrFYf4w9iG9ANmZWGyM/YkcemZbNelN44nMiEbBoSSNvlnVoi7K27LXCqWciMewgy2CcstjoCWkf4R0mThe/3fZb0nfiYtJjfDYz/QuSsZ01olAbCF9oJo5KJMetznjg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731181739; c=relaxed/simple;
	bh=IzjYjVc0MJaZnulUPAiFnztphJ9/U0uz3z6PAz1gXc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKeqLE/WzDeZUTnG3OVpyCy5ODMBpSsSvAYK2plZ9yTA03OUf4riHuO6JQtqlGc9T19hPwBW9T+ezCm2ge+cCEkqyS8vx3A4/vJNbpAA0vupfYeLsJEtiBBiHCP9mn+35IpxDEHQ9rzRy1bSrQIHbZ7b5Kl/wWsP7zWm9xnJE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMBqowIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94F0C4CED3;
	Sat,  9 Nov 2024 19:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731181738;
	bh=IzjYjVc0MJaZnulUPAiFnztphJ9/U0uz3z6PAz1gXc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMBqowIzo2l2FL5tDs3gApv47muR2pzM5Mfd7iAm6/l1kfLq+VLFrygzG3KNVtb2n
	 tR/1LdmIyVQdcjr08jLxv+16O4nr4W+r4gj2UImvf952ry9JSCluT2XJUeAU1bJ0mq
	 iNBx2+CNU/FpX8p+f3dxeU5GhPkq4lVfBAyUo269t8e6ELZy+qgcQz3OXN1B9qQ5/W
	 Daz6ut13+5WG/nR6iVkm2eDy7DC0+zCoHAZN8eButgtaj8jKB+54Zw9JHpyhuCiwHz
	 aif6/rAg/ylOIcIj3CJ3WDa8lPxjJ+1xFo/KRvIn4m98Zcoq3YCljpyDTU5LbTHGRv
	 XlJQOvNdQzd7w==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	sched-ext@meta.com,
	arighi@nvidia.com,
	multics69@gmail.com,
	me@mostlynerdless.de,
	ggherdovich@suse.com,
	dschatzberg@meta.com,
	yougmark94@gmail.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] sched_ext: Rename scx_bpf_consume() to scx_bpf_dsq_move_to_local()
Date: Sat,  9 Nov 2024 09:48:31 -1000
Message-ID: <20241109194853.580310-3-tj@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241109194853.580310-1-tj@kernel.org>
References: <20241109194853.580310-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sched_ext API, a repeatedly reported pain point is the overuse of the
verb "dispatch" and confusion around "consume":

- ops.dispatch()
- scx_bpf_dispatch[_vtime]()
- scx_bpf_consume()
- scx_bpf_dispatch[_vtime]_from_dsq*()

This overloading of the term is historical. Originally, there were only
built-in DSQs and moving a task into a DSQ always dispatched it for
execution. Using the verb "dispatch" for the kfuncs to move tasks into these
DSQs made sense.

Later, user DSQs were added and scx_bpf_dispatch[_vtime]() updated to be
able to insert tasks into any DSQ. The only allowed DSQ to DSQ transfer was
from a non-local DSQ to a local DSQ and this operation was named "consume".
This was already confusing as a task could be dispatched to a user DSQ from
ops.enqueue() and then the DSQ would have to be consumed in ops.dispatch().
Later addition of scx_bpf_dispatch_from_dsq*() made the confusion even worse
as "dispatch" in this context meant moving a task to an arbitrary DSQ from a
user DSQ.

Clean up the API with the following renames:

1. scx_bpf_dispatch[_vtime]()		-> scx_bpf_dsq_insert[_vtime]()
2. scx_bpf_consume()			-> scx_bpf_dsq_move_to_local()
3. scx_bpf_dispatch[_vtime]_from_dsq*()	-> scx_bpf_dsq_move[_vtime]*()

This patch performs the second rename. Compatibility is maintained by:

- The previous kfunc names are still provided by the kernel so that old
  binaries can run. Kernel generates a warning when the old names are used.

- compat.bpf.h provides wrappers for the new names which automatically fall
  back to the old names when running on older kernels. They also trigger
  build error if old names are used for new builds.

The compat features will be dropped after v6.15.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <multics69@gmail.com>
Cc: Johannes Bechberger <me@mostlynerdless.de>
Cc: Giovanni Gherdovich <ggherdovich@suse.com>
Cc: Dan Schatzberg <dschatzberg@meta.com>
Cc: Ming Yang <yougmark94@gmail.com>
---
 kernel/sched/ext.c                       | 40 ++++++++++++++----------
 tools/sched_ext/include/scx/common.bpf.h |  2 +-
 tools/sched_ext/include/scx/compat.bpf.h | 11 +++++++
 tools/sched_ext/scx_central.bpf.c        |  4 +--
 tools/sched_ext/scx_flatcg.bpf.c         |  6 ++--
 tools/sched_ext/scx_qmap.bpf.c           |  4 +--
 tools/sched_ext/scx_simple.bpf.c         |  2 +-
 7 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8c4f588f54e4..f39cb1344751 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -264,17 +264,17 @@ struct sched_ext_ops {
 	void (*dequeue)(struct task_struct *p, u64 deq_flags);
 
 	/**
-	 * dispatch - Dispatch tasks from the BPF scheduler and/or consume DSQs
+	 * dispatch - Dispatch tasks from the BPF scheduler and/or user DSQs
 	 * @cpu: CPU to dispatch tasks for
 	 * @prev: previous task being switched out
 	 *
 	 * Called when a CPU's local dsq is empty. The operation should dispatch
 	 * one or more tasks from the BPF scheduler into the DSQs using
-	 * scx_bpf_dsq_insert() and/or consume user DSQs into the local DSQ
-	 * using scx_bpf_consume().
+	 * scx_bpf_dsq_insert() and/or move from user DSQs into the local DSQ
+	 * using scx_bpf_dsq_move_to_local().
 	 *
 	 * The maximum number of times scx_bpf_dsq_insert() can be called
-	 * without an intervening scx_bpf_consume() is specified by
+	 * without an intervening scx_bpf_dsq_move_to_local() is specified by
 	 * ops.dispatch_max_batch. See the comments on top of the two functions
 	 * for more details.
 	 *
@@ -282,7 +282,7 @@ struct sched_ext_ops {
 	 * @prev is still runnable as indicated by set %SCX_TASK_QUEUED in
 	 * @prev->scx.flags, it is not enqueued yet and will be enqueued after
 	 * ops.dispatch() returns. To keep executing @prev, return without
-	 * dispatching or consuming any tasks. Also see %SCX_OPS_ENQ_LAST.
+	 * dispatching or moving any tasks. Also see %SCX_OPS_ENQ_LAST.
 	 */
 	void (*dispatch)(s32 cpu, struct task_struct *prev);
 
@@ -6372,9 +6372,8 @@ __bpf_kfunc void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
  * @enq_flags: SCX_ENQ_*
  *
  * Insert @p into the vtime priority queue of the DSQ identified by @dsq_id.
- * Tasks queued into the priority queue are ordered by @vtime and always
- * consumed after the tasks in the FIFO queue. All other aspects are identical
- * to scx_bpf_dsq_insert().
+ * Tasks queued into the priority queue are ordered by @vtime. All other aspects
+ * are identical to scx_bpf_dsq_insert().
  *
  * @vtime ordering is according to time_before64() which considers wrapping. A
  * numerically larger vtime may indicate an earlier position in the ordering and
@@ -6539,21 +6538,20 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(void)
 }
 
 /**
- * scx_bpf_consume - Transfer a task from a DSQ to the current CPU's local DSQ
- * @dsq_id: DSQ to consume
+ * scx_bpf_dsq_move_to_local - move a task from a DSQ to the current CPU's local DSQ
+ * @dsq_id: DSQ to move task from
  *
- * Consume a task from the non-local DSQ identified by @dsq_id and transfer it
- * to the current CPU's local DSQ for execution. Can only be called from
- * ops.dispatch().
+ * Move a task from the non-local DSQ identified by @dsq_id to the current CPU's
+ * local DSQ for execution. Can only be called from ops.dispatch().
  *
  * This function flushes the in-flight dispatches from scx_bpf_dsq_insert()
- * before trying to consume the specified DSQ. It may also grab rq locks and
+ * before trying to move from the specified DSQ. It may also grab rq locks and
  * thus can't be called under any BPF locks.
  *
- * Returns %true if a task has been consumed, %false if there isn't any task to
- * consume.
+ * Returns %true if a task has been moved, %false if there isn't any task to
+ * move.
  */
-__bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
+__bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
@@ -6583,6 +6581,13 @@ __bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
 	}
 }
 
+/* for backward compatibility, will be removed in v6.15 */
+__bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
+{
+	printk_deferred_once(KERN_WARNING "sched_ext: scx_bpf_consume() renamed to scx_bpf_dsq_move_to_local()");
+	return scx_bpf_dsq_move_to_local(dsq_id);
+}
+
 /**
  * scx_bpf_dispatch_from_dsq_set_slice - Override slice when dispatching from DSQ
  * @it__iter: DSQ iterator in progress
@@ -6684,6 +6689,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local)
 BTF_ID_FLAGS(func, scx_bpf_consume)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 16c7100c69e4..535377649a22 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -40,7 +40,7 @@ void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_fl
 void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
-bool scx_bpf_consume(u64 dsq_id) __ksym;
+bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym;
 void scx_bpf_dispatch_from_dsq_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
 void scx_bpf_dispatch_from_dsq_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
 bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 183aa4c6f674..c00ed24a8721 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -43,6 +43,7 @@
  */
 void scx_bpf_dispatch___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 void scx_bpf_dispatch_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
+bool scx_bpf_consume___compat(u64 dsq_id) __ksym __weak;
 
 #define scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags)				\
 	(bpf_ksym_exists(scx_bpf_dsq_insert) ?					\
@@ -54,12 +55,22 @@ void scx_bpf_dispatch_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slic
 	 scx_bpf_dsq_insert_vtime((p), (dsq_id), (slice), (vtime), (enq_flags)) : \
 	 scx_bpf_dispatch_vtime___compat((p), (dsq_id), (slice), (vtime), (enq_flags)))
 
+#define scx_bpf_dsq_move_to_local(dsq_id)					\
+	(bpf_ksym_exists(scx_bpf_dsq_move_to_local) ?				\
+	 scx_bpf_dsq_move_to_local((dsq_id)) :					\
+	 scx_bpf_consume___compat((dsq_id)))
+
 #define scx_bpf_dispatch(p, dsq_id, slice, enq_flags)				\
 	_Static_assert(false, "scx_bpf_dispatch() renamed to scx_bpf_dsq_insert()")
 
 #define scx_bpf_dispatch_vtime(p, dsq_id, slice, vtime, enq_flags)		\
 	_Static_assert(false, "scx_bpf_dispatch_vtime() renamed to scx_bpf_dsq_insert_vtime()")
 
+#define scx_bpf_consume(dsq_id) ({						\
+	_Static_assert(false, "scx_bpf_consume() renamed to scx_bpf_dsq_move_to_local()"); \
+	false;									\
+})
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 153d9656c75f..e6fad6211f6c 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -219,13 +219,13 @@ void BPF_STRUCT_OPS(central_dispatch, s32 cpu, struct task_struct *prev)
 		}
 
 		/* look for a task to run on the central CPU */
-		if (scx_bpf_consume(FALLBACK_DSQ_ID))
+		if (scx_bpf_dsq_move_to_local(FALLBACK_DSQ_ID))
 			return;
 		dispatch_to_cpu(central_cpu);
 	} else {
 		bool *gimme;
 
-		if (scx_bpf_consume(FALLBACK_DSQ_ID))
+		if (scx_bpf_dsq_move_to_local(FALLBACK_DSQ_ID))
 			return;
 
 		gimme = ARRAY_ELEM_PTR(cpu_gimme_task, cpu, nr_cpu_ids);
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 4dcb6c747b46..4e3afcd260bf 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -665,7 +665,7 @@ static bool try_pick_next_cgroup(u64 *cgidp)
 		goto out_free;
 	}
 
-	if (!scx_bpf_consume(cgid)) {
+	if (!scx_bpf_dsq_move_to_local(cgid)) {
 		bpf_cgroup_release(cgrp);
 		stat_inc(FCG_STAT_PNC_EMPTY);
 		goto out_stash;
@@ -745,7 +745,7 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
 		goto pick_next_cgroup;
 
 	if (vtime_before(now, cpuc->cur_at + cgrp_slice_ns)) {
-		if (scx_bpf_consume(cpuc->cur_cgid)) {
+		if (scx_bpf_dsq_move_to_local(cpuc->cur_cgid)) {
 			stat_inc(FCG_STAT_CNS_KEEP);
 			return;
 		}
@@ -785,7 +785,7 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
 pick_next_cgroup:
 	cpuc->cur_at = now;
 
-	if (scx_bpf_consume(FALLBACK_DSQ)) {
+	if (scx_bpf_dsq_move_to_local(FALLBACK_DSQ)) {
 		cpuc->cur_cgid = 0;
 		return;
 	}
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 65c52cc4fffb..08f121252c56 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -374,7 +374,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	if (dispatch_highpri(false))
 		return;
 
-	if (!nr_highpri_queued && scx_bpf_consume(SHARED_DSQ))
+	if (!nr_highpri_queued && scx_bpf_dsq_move_to_local(SHARED_DSQ))
 		return;
 
 	if (dsp_inf_loop_after && nr_dispatched > dsp_inf_loop_after) {
@@ -439,7 +439,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 			if (!batch || !scx_bpf_dispatch_nr_slots()) {
 				if (dispatch_highpri(false))
 					return;
-				scx_bpf_consume(SHARED_DSQ);
+				scx_bpf_dsq_move_to_local(SHARED_DSQ);
 				return;
 			}
 			if (!cpuc->dsp_cnt)
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index ce86a4a690b5..31f915b286c6 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -94,7 +94,7 @@ void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
 
 void BPF_STRUCT_OPS(simple_dispatch, s32 cpu, struct task_struct *prev)
 {
-	scx_bpf_consume(SHARED_DSQ);
+	scx_bpf_dsq_move_to_local(SHARED_DSQ);
 }
 
 void BPF_STRUCT_OPS(simple_running, struct task_struct *p)
-- 
2.47.0


