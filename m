Return-Path: <linux-kernel+bounces-403353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB679C3482
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED5B281137
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA9155725;
	Sun, 10 Nov 2024 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8BsN/Mj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818334D8D1
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731268994; cv=none; b=SK9lUK9mVJiFnVikbpVUdjY5TIS5EiIrvnYP6rlHhPaRIpZiCOMVRc+0F6rr876/sWdIxi8AuMAmlo2OPcX1NlPCpbVtMgEdfEXzY61sUjjeFsES/fnbxv2rHr3gEFMa61kSVJr8BCs4ZLuOwpdh8ndh4/sMyxKc08yOeVQ2azQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731268994; c=relaxed/simple;
	bh=XbP9MuGCoOKzxQlEnz7c11diVS/8q5unHEab0Q0+i6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQeLW1ejg4fN0osG3PMPUeHjpEm1YfROH6rHw5NoB/Uh/e1IdcR+RPgMVzT0toWIgM7GYMQJJdQ9NEeDl61JScEavs1Vge4wYYfQ7QcCQNqhUTCndrtaB+xec1+lsWXjKHfJGYTpkVTWUvqgrkYMyxcxTmWOP+pg8W4MgKGCbd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8BsN/Mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09376C4CED2;
	Sun, 10 Nov 2024 20:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731268994;
	bh=XbP9MuGCoOKzxQlEnz7c11diVS/8q5unHEab0Q0+i6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8BsN/Mj9nBeAvXWsztzX89cxy0X0pX97YBxJ430yH3DRlJi6ZZBJYVXDZIXpAiyI
	 56esYXqpHo3ttqu/aSxJyslJMvg81Ixjj/UxcKzcwJubO+uIxUDeODuCQ+BFzjIMbw
	 gckIRRW/6hxcaPLSt4GaDyoarOwLuaoFhp3f5bIrek5vEjexOXi8fl899ODPZ3HlDi
	 6nLbiApSdqBqf3RRWhWEBDxOENcd2/PoMhkOWgfHQGKJULHFBcX4RFUyYIi5OzIPAh
	 EKFpH/0nHychXrSEoKCr0AGvGNxXQN7eMDtpIRQnhmEzAb9Ojrvq+qPnj3DS3DxE5U
	 PPHFlocQs+hzA==
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
Subject: [PATCH 3/3] sched_ext: Rename scx_bpf_dispatch[_vtime]_from_dsq*() -> scx_bpf_dsq_move[_vtime]*()
Date: Sun, 10 Nov 2024 10:02:53 -1000
Message-ID: <20241110200308.103681-4-tj@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241110200308.103681-1-tj@kernel.org>
References: <20241110200308.103681-1-tj@kernel.org>
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

This patch performs the third set of renames. Compatibility is maintained
by:

- The previous kfunc names are still provided by the kernel so that old
  binaries can run. Kernel generates a warning when the old names are used.

- compat.bpf.h provides wrappers for the new names which automatically fall
  back to the old names when running on older kernels. They also trigger
  build error if old names are used for new builds.

- scx_bpf_dispatch[_vtime]_from_dsq*() were already wrapped in __COMPAT
  macros as they were introduced during v6.12 cycle. Wrap new API in
  __COMPAT macros too and trigger build errors on both __COMPAT prefixed and
  naked usages of the old names.

The compat features will be dropped after v6.15.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <multics69@gmail.com>
Cc: Johannes Bechberger <me@mostlynerdless.de>
Cc: Giovanni Gherdovich <ggherdovich@suse.com>
Cc: Dan Schatzberg <dschatzberg@meta.com>
Cc: Ming Yang <yougmark94@gmail.com>
---
 kernel/sched/ext.c                       | 97 +++++++++++++++++-------
 tools/sched_ext/include/scx/common.bpf.h | 12 +--
 tools/sched_ext/include/scx/compat.bpf.h | 82 ++++++++++++++++----
 tools/sched_ext/scx_qmap.bpf.c           | 20 ++---
 4 files changed, 152 insertions(+), 59 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 929475f9b1cd..5081fbdab74d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6422,9 +6422,8 @@ static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
 	.set			= &scx_kfunc_ids_enqueue_dispatch,
 };
 
-static bool scx_dispatch_from_dsq(struct bpf_iter_scx_dsq_kern *kit,
-				  struct task_struct *p, u64 dsq_id,
-				  u64 enq_flags)
+static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
+			 struct task_struct *p, u64 dsq_id, u64 enq_flags)
 {
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
 	struct rq *this_rq, *src_rq, *locked_rq;
@@ -6594,16 +6593,16 @@ __bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
 }
 
 /**
- * scx_bpf_dispatch_from_dsq_set_slice - Override slice when dispatching from DSQ
+ * scx_bpf_dsq_move_set_slice - Override slice when moving between DSQs
  * @it__iter: DSQ iterator in progress
- * @slice: duration the dispatched task can run for in nsecs
+ * @slice: duration the moved task can run for in nsecs
  *
- * Override the slice of the next task that will be dispatched from @it__iter
- * using scx_bpf_dispatch_from_dsq[_vtime](). If this function is not called,
- * the previous slice duration is kept.
+ * Override the slice of the next task that will be moved from @it__iter using
+ * scx_bpf_dsq_move[_vtime](). If this function is not called, the previous
+ * slice duration is kept.
  */
-__bpf_kfunc void scx_bpf_dispatch_from_dsq_set_slice(
-				struct bpf_iter_scx_dsq *it__iter, u64 slice)
+__bpf_kfunc void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq *it__iter,
+					    u64 slice)
 {
 	struct bpf_iter_scx_dsq_kern *kit = (void *)it__iter;
 
@@ -6611,18 +6610,26 @@ __bpf_kfunc void scx_bpf_dispatch_from_dsq_set_slice(
 	kit->cursor.flags |= __SCX_DSQ_ITER_HAS_SLICE;
 }
 
+/* for backward compatibility, will be removed in v6.15 */
+__bpf_kfunc void scx_bpf_dispatch_from_dsq_set_slice(
+			struct bpf_iter_scx_dsq *it__iter, u64 slice)
+{
+	printk_deferred_once(KERN_WARNING "sched_ext: scx_bpf_dispatch_from_dsq_set_slice() renamed to scx_bpf_dsq_move_set_slice()");
+	scx_bpf_dsq_move_set_slice(it__iter, slice);
+}
+
 /**
- * scx_bpf_dispatch_from_dsq_set_vtime - Override vtime when dispatching from DSQ
+ * scx_bpf_dsq_move_set_vtime - Override vtime when moving between DSQs
  * @it__iter: DSQ iterator in progress
  * @vtime: task's ordering inside the vtime-sorted queue of the target DSQ
  *
- * Override the vtime of the next task that will be dispatched from @it__iter
- * using scx_bpf_dispatch_from_dsq_vtime(). If this function is not called, the
- * previous slice vtime is kept. If scx_bpf_dispatch_from_dsq() is used to
- * dispatch the next task, the override is ignored and cleared.
+ * Override the vtime of the next task that will be moved from @it__iter using
+ * scx_bpf_dsq_move_vtime(). If this function is not called, the previous slice
+ * vtime is kept. If scx_bpf_dsq_move() is used to dispatch the next task, the
+ * override is ignored and cleared.
  */
-__bpf_kfunc void scx_bpf_dispatch_from_dsq_set_vtime(
-				struct bpf_iter_scx_dsq *it__iter, u64 vtime)
+__bpf_kfunc void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter,
+					    u64 vtime)
 {
 	struct bpf_iter_scx_dsq_kern *kit = (void *)it__iter;
 
@@ -6630,8 +6637,16 @@ __bpf_kfunc void scx_bpf_dispatch_from_dsq_set_vtime(
 	kit->cursor.flags |= __SCX_DSQ_ITER_HAS_VTIME;
 }
 
+/* for backward compatibility, will be removed in v6.15 */
+__bpf_kfunc void scx_bpf_dispatch_from_dsq_set_vtime(
+			struct bpf_iter_scx_dsq *it__iter, u64 vtime)
+{
+	printk_deferred_once(KERN_WARNING "sched_ext: scx_bpf_dispatch_from_dsq_set_vtime() renamed to scx_bpf_dsq_move_set_vtime()");
+	scx_bpf_dsq_move_set_vtime(it__iter, vtime);
+}
+
 /**
- * scx_bpf_dispatch_from_dsq - Move a task from DSQ iteration to a DSQ
+ * scx_bpf_dsq_move - Move a task from DSQ iteration to a DSQ
  * @it__iter: DSQ iterator in progress
  * @p: task to transfer
  * @dsq_id: DSQ to move @p to
@@ -6646,8 +6661,7 @@ __bpf_kfunc void scx_bpf_dispatch_from_dsq_set_vtime(
  * @p was obtained from the DSQ iteration. @p just has to be on the DSQ and have
  * been queued before the iteration started.
  *
- * @p's slice is kept by default. Use scx_bpf_dispatch_from_dsq_set_slice() to
- * update.
+ * @p's slice is kept by default. Use scx_bpf_dsq_move_set_slice() to update.
  *
  * Can be called from ops.dispatch() or any BPF context which doesn't hold a rq
  * lock (e.g. BPF timers or SYSCALL programs).
@@ -6655,16 +6669,25 @@ __bpf_kfunc void scx_bpf_dispatch_from_dsq_set_vtime(
  * Returns %true if @p has been consumed, %false if @p had already been consumed
  * or dequeued.
  */
+__bpf_kfunc bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
+				  struct task_struct *p, u64 dsq_id,
+				  u64 enq_flags)
+{
+	return scx_dsq_move((struct bpf_iter_scx_dsq_kern *)it__iter,
+			    p, dsq_id, enq_flags);
+}
+
+/* for backward compatibility, will be removed in v6.15 */
 __bpf_kfunc bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter,
 					   struct task_struct *p, u64 dsq_id,
 					   u64 enq_flags)
 {
-	return scx_dispatch_from_dsq((struct bpf_iter_scx_dsq_kern *)it__iter,
-				     p, dsq_id, enq_flags);
+	printk_deferred_once(KERN_WARNING "sched_ext: scx_bpf_dispatch_from_dsq() renamed to scx_bpf_dsq_move()");
+	return scx_bpf_dsq_move(it__iter, p, dsq_id, enq_flags);
 }
 
 /**
- * scx_bpf_dispatch_vtime_from_dsq - Move a task from DSQ iteration to a PRIQ DSQ
+ * scx_bpf_dsq_move_vtime - Move a task from DSQ iteration to a PRIQ DSQ
  * @it__iter: DSQ iterator in progress
  * @p: task to transfer
  * @dsq_id: DSQ to move @p to
@@ -6674,19 +6697,27 @@ __bpf_kfunc bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter,
  * priority queue of the DSQ specified by @dsq_id. The destination must be a
  * user DSQ as only user DSQs support priority queue.
  *
- * @p's slice and vtime are kept by default. Use
- * scx_bpf_dispatch_from_dsq_set_slice() and
- * scx_bpf_dispatch_from_dsq_set_vtime() to update.
+ * @p's slice and vtime are kept by default. Use scx_bpf_dsq_move_set_slice()
+ * and scx_bpf_dsq_move_set_vtime() to update.
  *
- * All other aspects are identical to scx_bpf_dispatch_from_dsq(). See
+ * All other aspects are identical to scx_bpf_dsq_move(). See
  * scx_bpf_dsq_insert_vtime() for more information on @vtime.
  */
+__bpf_kfunc bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter,
+					struct task_struct *p, u64 dsq_id,
+					u64 enq_flags)
+{
+	return scx_dsq_move((struct bpf_iter_scx_dsq_kern *)it__iter,
+			    p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+}
+
+/* for backward compatibility, will be removed in v6.15 */
 __bpf_kfunc bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter,
 						 struct task_struct *p, u64 dsq_id,
 						 u64 enq_flags)
 {
-	return scx_dispatch_from_dsq((struct bpf_iter_scx_dsq_kern *)it__iter,
-				     p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+	printk_deferred_once(KERN_WARNING "sched_ext: scx_bpf_dispatch_from_dsq_vtime() renamed to scx_bpf_dsq_move_vtime()");
+	return scx_bpf_dsq_move_vtime(it__iter, p, dsq_id, enq_flags);
 }
 
 __bpf_kfunc_end_defs();
@@ -6696,6 +6727,10 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_to_local)
 BTF_ID_FLAGS(func, scx_bpf_consume)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
@@ -6796,6 +6831,10 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
 BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 535377649a22..2f36b7b6418d 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -41,10 +41,10 @@ void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_dsq_move_to_local(u64 dsq_id) __ksym;
-void scx_bpf_dispatch_from_dsq_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
-void scx_bpf_dispatch_from_dsq_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
-bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
-bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
+void scx_bpf_dsq_move_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym;
+void scx_bpf_dsq_move_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym;
+bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
+bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
@@ -74,8 +74,8 @@ struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 
 /*
- * Use the following as @it__iter when calling
- * scx_bpf_dispatch[_vtime]_from_dsq() from within bpf_for_each() loops.
+ * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
+ * within bpf_for_each() loops.
  */
 #define BPF_FOR_EACH_ITER	(&___it)
 
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index c00ed24a8721..d56520100a26 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -20,30 +20,24 @@
 	(bpf_ksym_exists(scx_bpf_task_cgroup) ?					\
 	 scx_bpf_task_cgroup((p)) : NULL)
 
-/* v6.12: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()") */
-#define __COMPAT_scx_bpf_dispatch_from_dsq_set_slice(it, slice)			\
-	(bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_slice) ?			\
-	 scx_bpf_dispatch_from_dsq_set_slice((it), (slice)) : (void)0)
-#define __COMPAT_scx_bpf_dispatch_from_dsq_set_vtime(it, vtime)			\
-	(bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_vtime) ?			\
-	 scx_bpf_dispatch_from_dsq_set_vtime((it), (vtime)) : (void)0)
-#define __COMPAT_scx_bpf_dispatch_from_dsq(it, p, dsq_id, enq_flags)		\
-	(bpf_ksym_exists(scx_bpf_dispatch_from_dsq) ?				\
-	 scx_bpf_dispatch_from_dsq((it), (p), (dsq_id), (enq_flags)) : false)
-#define __COMPAT_scx_bpf_dispatch_vtime_from_dsq(it, p, dsq_id, enq_flags)	\
-	(bpf_ksym_exists(scx_bpf_dispatch_vtime_from_dsq) ?			\
-	 scx_bpf_dispatch_vtime_from_dsq((it), (p), (dsq_id), (enq_flags)) : false)
-
 /*
  * v6.13: The verb `dispatch` was too overloaded and confusing. kfuncs are
  * renamed to unload the verb.
  *
  * Build error is triggered if old names are used. New binaries work with both
  * new and old names. The compat macros will be removed on v6.15 release.
+ *
+ * scx_bpf_dispatch_from_dsq() and friends were added during v6.12 by
+ * 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()").
+ * Preserve __COMPAT macros until v6.15.
  */
 void scx_bpf_dispatch___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 void scx_bpf_dispatch_vtime___compat(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 bool scx_bpf_consume___compat(u64 dsq_id) __ksym __weak;
+void scx_bpf_dispatch_from_dsq_set_slice___compat(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
+void scx_bpf_dispatch_from_dsq_set_vtime___compat(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
+bool scx_bpf_dispatch_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
+bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 
 #define scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags)				\
 	(bpf_ksym_exists(scx_bpf_dsq_insert) ?					\
@@ -60,6 +54,34 @@ bool scx_bpf_consume___compat(u64 dsq_id) __ksym __weak;
 	 scx_bpf_dsq_move_to_local((dsq_id)) :					\
 	 scx_bpf_consume___compat((dsq_id)))
 
+#define __COMPAT_scx_bpf_dsq_move_set_slice(it__iter, slice)			\
+	(bpf_ksym_exists(scx_bpf_dsq_move_set_slice) ?				\
+	 scx_bpf_dsq_move_set_slice((it__iter), (slice)) :			\
+	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_slice___compat) ?	\
+	  scx_bpf_dispatch_from_dsq_set_slice___compat((it__iter), (slice)) :	\
+	  (void)0))
+
+#define __COMPAT_scx_bpf_dsq_move_set_vtime(it__iter, vtime)			\
+	(bpf_ksym_exists(scx_bpf_dsq_move_set_vtime) ?				\
+	 scx_bpf_dsq_move_set_vtime((it__iter), (vtime)) :			\
+	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_vtime___compat) ?	\
+	  scx_bpf_dispatch_from_dsq_set_vtime___compat((it__iter), (vtime)) :	\
+	  (void) 0))
+
+#define __COMPAT_scx_bpf_dsq_move(it__iter, p, dsq_id, enq_flags)		\
+	(bpf_ksym_exists(scx_bpf_dsq_move) ?					\
+	 scx_bpf_dsq_move((it__iter), (p), (dsq_id), (enq_flags)) :		\
+	 (bpf_ksym_exists(scx_bpf_dispatch_from_dsq___compat) ?			\
+	  scx_bpf_dispatch_from_dsq___compat((it__iter), (p), (dsq_id), (enq_flags)) : \
+	  false))
+
+#define __COMPAT_scx_bpf_dsq_move_vtime(it__iter, p, dsq_id, enq_flags)		\
+	(bpf_ksym_exists(scx_bpf_dsq_move_vtime) ?				\
+	 scx_bpf_dsq_move_vtime((it__iter), (p), (dsq_id), (enq_flags)) :	\
+	 (bpf_ksym_exists(scx_bpf_dispatch_vtime_from_dsq___compat) ?		\
+	  scx_bpf_dispatch_vtime_from_dsq___compat((it__iter), (p), (dsq_id), (enq_flags)) : \
+	  false))
+
 #define scx_bpf_dispatch(p, dsq_id, slice, enq_flags)				\
 	_Static_assert(false, "scx_bpf_dispatch() renamed to scx_bpf_dsq_insert()")
 
@@ -71,6 +93,38 @@ bool scx_bpf_consume___compat(u64 dsq_id) __ksym __weak;
 	false;									\
 })
 
+#define scx_bpf_dispatch_from_dsq_set_slice(it__iter, slice)		\
+	_Static_assert(false, "scx_bpf_dispatch_from_dsq_set_slice() renamed to scx_bpf_dsq_move_set_slice()")
+
+#define scx_bpf_dispatch_from_dsq_set_vtime(it__iter, vtime)		\
+	_Static_assert(false, "scx_bpf_dispatch_from_dsq_set_vtime() renamed to scx_bpf_dsq_move_set_vtime()")
+
+#define scx_bpf_dispatch_from_dsq(it__iter, p, dsq_id, enq_flags) ({	\
+	_Static_assert(false, "scx_bpf_dispatch_from_dsq() renamed to scx_bpf_dsq_move()"); \
+	false;									\
+})
+
+#define scx_bpf_dispatch_vtime_from_dsq(it__iter, p, dsq_id, enq_flags) ({  \
+	_Static_assert(false, "scx_bpf_dispatch_vtime_from_dsq() renamed to scx_bpf_dsq_move_vtime()"); \
+	false;									\
+})
+
+#define __COMPAT_scx_bpf_dispatch_from_dsq_set_slice(it__iter, slice)		\
+	_Static_assert(false, "__COMPAT_scx_bpf_dispatch_from_dsq_set_slice() renamed to __COMPAT_scx_bpf_dsq_move_set_slice()")
+
+#define __COMPAT_scx_bpf_dispatch_from_dsq_set_vtime(it__iter, vtime)		\
+	_Static_assert(false, "__COMPAT_scx_bpf_dispatch_from_dsq_set_vtime() renamed to __COMPAT_scx_bpf_dsq_move_set_vtime()")
+
+#define __COMPAT_scx_bpf_dispatch_from_dsq(it__iter, p, dsq_id, enq_flags) ({	\
+	_Static_assert(false, "__COMPAT_scx_bpf_dispatch_from_dsq() renamed to __COMPAT_scx_bpf_dsq_move()"); \
+	false;									\
+})
+
+#define __COMPAT_scx_bpf_dispatch_vtime_from_dsq(it__iter, p, dsq_id, enq_flags) ({  \
+	_Static_assert(false, "__COMPAT_scx_bpf_dispatch_vtime_from_dsq() renamed to __COMPAT_scx_bpf_dsq_move_vtime()"); \
+	false;									\
+})
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 08f121252c56..ee264947e0c3 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -294,10 +294,10 @@ static void update_core_sched_head_seq(struct task_struct *p)
 }
 
 /*
- * To demonstrate the use of scx_bpf_dispatch_from_dsq(), implement silly
- * selective priority boosting mechanism by scanning SHARED_DSQ looking for
- * highpri tasks, moving them to HIGHPRI_DSQ and then consuming them first. This
- * makes minor difference only when dsp_batch is larger than 1.
+ * To demonstrate the use of scx_bpf_dsq_move(), implement silly selective
+ * priority boosting mechanism by scanning SHARED_DSQ looking for highpri tasks,
+ * moving them to HIGHPRI_DSQ and then consuming them first. This makes minor
+ * difference only when dsp_batch is larger than 1.
  *
  * scx_bpf_dispatch[_vtime]_from_dsq() are allowed both from ops.dispatch() and
  * non-rq-lock holding BPF programs. As demonstration, this function is called
@@ -318,11 +318,11 @@ static bool dispatch_highpri(bool from_timer)
 
 		if (tctx->highpri) {
 			/* exercise the set_*() and vtime interface too */
-			__COMPAT_scx_bpf_dispatch_from_dsq_set_slice(
+			__COMPAT_scx_bpf_dsq_move_set_slice(
 				BPF_FOR_EACH_ITER, slice_ns * 2);
-			__COMPAT_scx_bpf_dispatch_from_dsq_set_vtime(
+			__COMPAT_scx_bpf_dsq_move_set_vtime(
 				BPF_FOR_EACH_ITER, highpri_seq++);
-			__COMPAT_scx_bpf_dispatch_vtime_from_dsq(
+			__COMPAT_scx_bpf_dsq_move_vtime(
 				BPF_FOR_EACH_ITER, p, HIGHPRI_DSQ, 0);
 		}
 	}
@@ -340,9 +340,9 @@ static bool dispatch_highpri(bool from_timer)
 		else
 			cpu = scx_bpf_pick_any_cpu(p->cpus_ptr, 0);
 
-		if (__COMPAT_scx_bpf_dispatch_from_dsq(BPF_FOR_EACH_ITER, p,
-						       SCX_DSQ_LOCAL_ON | cpu,
-						       SCX_ENQ_PREEMPT)) {
+		if (__COMPAT_scx_bpf_dsq_move(BPF_FOR_EACH_ITER, p,
+					      SCX_DSQ_LOCAL_ON | cpu,
+					      SCX_ENQ_PREEMPT)) {
 			if (cpu == this_cpu) {
 				dispatched = true;
 				__sync_fetch_and_add(&nr_expedited_local, 1);
-- 
2.47.0


