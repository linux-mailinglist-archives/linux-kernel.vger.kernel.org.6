Return-Path: <linux-kernel+bounces-310306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBDC967975
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A68281A08
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1831A184550;
	Sun,  1 Sep 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrnjqrYy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A42184532
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209062; cv=none; b=WGlZp3C+qhMyBn+jpl6Jh3CLsW8uCeOfHuK3qKyW+2Wrhsi7+IJ22skw9gccPwgx2JD5u6f/mKsk0LoUVDRieety90bHuvCnTwoXACDXvt0SsICM3SYD46DrcAjJJEM+81TwwxpUrlhQwevo+CNtjkh4k1ku1sw+kkSWG4eJhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209062; c=relaxed/simple;
	bh=6B+9ZPMJEDXdQbYn0D8ErTymAtchn02mYq3OLtRP4rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zq3pamvlSnx4LeYzdcSuqfK0VONK6AbkOsGKS+UyMc+KaxFfOWasmoTVta9lO0upk5x0okW1z1RENJGejol23lm6kX+flQxJiiGB8o4Ec2NWKg+tkHm5WOUOF+dFw2dopRpdi1YexSjCo544aGqusF+kdy9TsEB3zjfKgcLm12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrnjqrYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD80C4CECE;
	Sun,  1 Sep 2024 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725209061;
	bh=6B+9ZPMJEDXdQbYn0D8ErTymAtchn02mYq3OLtRP4rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrnjqrYytDXCfPwZ26DnsLEbJdlTUdvKODQ6q4f+UDi0FSdywUEce6DgNEOJjPf97
	 m30igev5Zro8ZdnqmCnlLO0gN3ywySzB/EU3C4hF/iYF6SmNYrBnEqaahPyEGrZ+KB
	 6T0zY39x+PaHaf4JQw0rx9sUNYY0b5FNz0KbopQuPRL5X3j6sNT+QC3MUe6wcu0tMP
	 lrhP6z200STMzqYU280cpAc324BD+JSlHi43wCRpBG6GsGv7ygN11Qe0arB27rMZWF
	 FaaUUiiGbHeekPmv18KoX8CE3xy0K8UuPz9OJulCrMTov+JCWplbtCf2M4X1gi7tLw
	 reKtZ0txn0ghQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/12] sched_ext: Refactor consume_remote_task()
Date: Sun,  1 Sep 2024 06:43:39 -1000
Message-ID: <20240901164417.779239-3-tj@kernel.org>
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

The tricky p->scx.holding_cpu handling was split across
consume_remote_task() body and move_task_to_local_dsq(). Refactor such that:

- All the tricky part is now in the new unlink_dsq_and_lock_src_rq() with
  consolidated documentation.

- move_task_to_local_dsq() now implements straightforward task migration
  making it easier to use in other places.

- dispatch_to_local_dsq() is another user move_task_to_local_dsq(). The
  usage is updated accordingly. This makes the local and remote cases more
  symmetric.

No functional changes intended.

v2: s/task_rq/src_rq/ for consistency.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 145 ++++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 69 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e7c6e824f875..e148c7c5341d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2107,49 +2107,13 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
  * @src_rq: rq to move the task from, locked on entry, released on return
  * @dst_rq: rq to move the task into, locked on return
  *
- * Move @p which is currently on @src_rq to @dst_rq's local DSQ. The caller
- * must:
- *
- * 1. Start with exclusive access to @p either through its DSQ lock or
- *    %SCX_OPSS_DISPATCHING flag.
- *
- * 2. Set @p->scx.holding_cpu to raw_smp_processor_id().
- *
- * 3. Remember task_rq(@p) as @src_rq. Release the exclusive access so that we
- *    don't deadlock with dequeue.
- *
- * 4. Lock @src_rq from #3.
- *
- * 5. Call this function.
- *
- * Returns %true if @p was successfully moved. %false after racing dequeue and
- * losing. On return, @src_rq is unlocked and @dst_rq is locked.
+ * Move @p which is currently on @src_rq to @dst_rq's local DSQ.
  */
-static bool move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
+static void move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 				   struct rq *src_rq, struct rq *dst_rq)
 {
 	lockdep_assert_rq_held(src_rq);
 
-	/*
-	 * If dequeue got to @p while we were trying to lock @src_rq, it'd have
-	 * cleared @p->scx.holding_cpu to -1. While other cpus may have updated
-	 * it to different values afterwards, as this operation can't be
-	 * preempted or recurse, @p->scx.holding_cpu can never become
-	 * raw_smp_processor_id() again before we're done. Thus, we can tell
-	 * whether we lost to dequeue by testing whether @p->scx.holding_cpu is
-	 * still raw_smp_processor_id().
-	 *
-	 * @p->rq couldn't have changed if we're still the holding cpu.
-	 *
-	 * See dispatch_dequeue() for the counterpart.
-	 */
-	if (unlikely(p->scx.holding_cpu != raw_smp_processor_id()) ||
-	    WARN_ON_ONCE(src_rq != task_rq(p))) {
-		raw_spin_rq_unlock(src_rq);
-		raw_spin_rq_lock(dst_rq);
-		return false;
-	}
-
 	/* the following marks @p MIGRATING which excludes dequeue */
 	deactivate_task(src_rq, p, 0);
 	set_task_cpu(p, cpu_of(dst_rq));
@@ -2168,8 +2132,6 @@ static bool move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 	dst_rq->scx.extra_enq_flags = enq_flags;
 	activate_task(dst_rq, p, 0);
 	dst_rq->scx.extra_enq_flags = 0;
-
-	return true;
 }
 
 #endif	/* CONFIG_SMP */
@@ -2234,28 +2196,69 @@ static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq,
 	return true;
 }
 
-static bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *dsq,
-				struct task_struct *p, struct rq *task_rq)
+/**
+ * unlink_dsq_and_lock_src_rq() - Unlink task from its DSQ and lock its task_rq
+ * @p: target task
+ * @dsq: locked DSQ @p is currently on
+ * @src_rq: rq @p is currently on, stable with @dsq locked
+ *
+ * Called with @dsq locked but no rq's locked. We want to move @p to a different
+ * DSQ, including any local DSQ, but are not locking @src_rq. Locking @src_rq is
+ * required when transferring into a local DSQ. Even when transferring into a
+ * non-local DSQ, it's better to use the same mechanism to protect against
+ * dequeues and maintain the invariant that @p->scx.dsq can only change while
+ * @src_rq is locked, which e.g. scx_dump_task() depends on.
+ *
+ * We want to grab @src_rq but that can deadlock if we try while locking @dsq,
+ * so we want to unlink @p from @dsq, drop its lock and then lock @src_rq. As
+ * this may race with dequeue, which can't drop the rq lock or fail, do a little
+ * dancing from our side.
+ *
+ * @p->scx.holding_cpu is set to this CPU before @dsq is unlocked. If @p gets
+ * dequeued after we unlock @dsq but before locking @src_rq, the holding_cpu
+ * would be cleared to -1. While other cpus may have updated it to different
+ * values afterwards, as this operation can't be preempted or recurse, the
+ * holding_cpu can never become this CPU again before we're done. Thus, we can
+ * tell whether we lost to dequeue by testing whether the holding_cpu still
+ * points to this CPU. See dispatch_dequeue() for the counterpart.
+ *
+ * On return, @dsq is unlocked and @src_rq is locked. Returns %true if @p is
+ * still valid. %false if lost to dequeue.
+ */
+static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
+				       struct scx_dispatch_q *dsq,
+				       struct rq *src_rq)
 {
-	lockdep_assert_held(&dsq->lock);	/* released on return */
+	s32 cpu = raw_smp_processor_id();
+
+	lockdep_assert_held(&dsq->lock);
 
-	/*
-	 * @dsq is locked and @p is on a remote rq. @p is currently protected by
-	 * @dsq->lock. We want to pull @p to @rq but may deadlock if we grab
-	 * @task_rq while holding @dsq and @rq locks. As dequeue can't drop the
-	 * rq lock or fail, do a little dancing from our side. See
-	 * move_task_to_local_dsq().
-	 */
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 	task_unlink_from_dsq(p, dsq);
 	dsq_mod_nr(dsq, -1);
-	p->scx.holding_cpu = raw_smp_processor_id();
+	p->scx.holding_cpu = cpu;
+
 	raw_spin_unlock(&dsq->lock);
+	raw_spin_rq_lock(src_rq);
 
-	raw_spin_rq_unlock(rq);
-	raw_spin_rq_lock(task_rq);
+	/* task_rq couldn't have changed if we're still the holding cpu */
+	return likely(p->scx.holding_cpu == cpu) &&
+		!WARN_ON_ONCE(src_rq != task_rq(p));
+}
 
-	return move_task_to_local_dsq(p, 0, task_rq, rq);
+static bool consume_remote_task(struct rq *this_rq, struct scx_dispatch_q *dsq,
+				struct task_struct *p, struct rq *src_rq)
+{
+	raw_spin_rq_unlock(this_rq);
+
+	if (unlink_dsq_and_lock_src_rq(p, dsq, src_rq)) {
+		move_task_to_local_dsq(p, 0, src_rq, this_rq);
+		return true;
+	} else {
+		raw_spin_rq_unlock(src_rq);
+		raw_spin_rq_lock(this_rq);
+		return false;
+	}
 }
 #else	/* CONFIG_SMP */
 static inline bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq, bool trigger_error) { return false; }
@@ -2359,7 +2362,8 @@ dispatch_to_local_dsq(struct rq *rq, u64 dsq_id, struct task_struct *p,
 		 * As DISPATCHING guarantees that @p is wholly ours, we can
 		 * pretend that we're moving from a DSQ and use the same
 		 * mechanism - mark the task under transfer with holding_cpu,
-		 * release DISPATCHING and then follow the same protocol.
+		 * release DISPATCHING and then follow the same protocol. See
+		 * unlink_dsq_and_lock_src_rq().
 		 */
 		p->scx.holding_cpu = raw_smp_processor_id();
 
@@ -2372,28 +2376,31 @@ dispatch_to_local_dsq(struct rq *rq, u64 dsq_id, struct task_struct *p,
 			raw_spin_rq_lock(src_rq);
 		}
 
-		if (src_rq == dst_rq) {
+		/* task_rq couldn't have changed if we're still the holding cpu */
+		dsp = p->scx.holding_cpu == raw_smp_processor_id() &&
+			!WARN_ON_ONCE(src_rq != task_rq(p));
+
+		if (likely(dsp)) {
 			/*
-			 * As @p is staying on the same rq, there's no need to
+			 * If @p is staying on the same rq, there's no need to
 			 * go through the full deactivate/activate cycle.
 			 * Optimize by abbreviating the operations in
 			 * move_task_to_local_dsq().
 			 */
-			dsp = p->scx.holding_cpu == raw_smp_processor_id();
-			if (likely(dsp)) {
+			if (src_rq == dst_rq) {
 				p->scx.holding_cpu = -1;
-				dispatch_enqueue(&dst_rq->scx.local_dsq, p,
-						 enq_flags);
+				dispatch_enqueue(&dst_rq->scx.local_dsq,
+						 p, enq_flags);
+			} else {
+				move_task_to_local_dsq(p, enq_flags,
+						       src_rq, dst_rq);
 			}
-		} else {
-			dsp = move_task_to_local_dsq(p, enq_flags,
-						     src_rq, dst_rq);
-		}
 
-		/* if the destination CPU is idle, wake it up */
-		if (dsp && sched_class_above(p->sched_class,
-					     dst_rq->curr->sched_class))
-			resched_curr(dst_rq);
+			/* if the destination CPU is idle, wake it up */
+			if (sched_class_above(p->sched_class,
+					      dst_rq->curr->sched_class))
+				resched_curr(dst_rq);
+		}
 
 		/* switch back to @rq lock */
 		if (rq != dst_rq) {
-- 
2.46.0


