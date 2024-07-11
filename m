Return-Path: <linux-kernel+bounces-248481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456DF92DDD2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B9B1C21A55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BEE39847;
	Thu, 11 Jul 2024 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf9NBI+Y"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278F168CC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660484; cv=none; b=cViYEDY5DC/HulDgHyAXzwacCtO+S+BvHfglVAx0yMIIQP46/WWosV9mKrEOWE2MtMLjBZEYuddapoMKNEgWbTd2BBNgzrPYRwgw8Ou93GfuLTeSoyxjPR6xicdLWqw6N5vr2l/R16NUsq18xPg6AINU3E7ooFqOFSsyiPck/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660484; c=relaxed/simple;
	bh=s4v7fgltZGAe54D6VG8LEV0hwvh03eNfJ5vxA75ytes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMdTWIpS39BzLkehTPHVwZPpLurDZPTGxR5K4EdPSS6zgxXoV46Lddlnblp7Ky9Lk90yGUVYIGzVRfnEVS1PA9mInIOTUD1VyzQH1SEKIQqaTTJW465Rvi9MzTgIr6CyVWQEe3u918hTcjNNs6dJeO/5POGqNpcFmzrH85j91Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lf9NBI+Y; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fafc9e07f8so2504995ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720660482; x=1721265282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJJSf5oR3kQN0eEhskMp7G708IalEJkrKAj5CKBlLZU=;
        b=lf9NBI+Yg31DTn9PvlfIbtL7Z6wOsmPuJY1579NwcHimg06/+T9hMZ2kvXMdT65dls
         v1lFLqZkfdiaz4FldLlAdmo7Ck56POy6g8CiwE/93zNPtKNp/Ptf+lyA0yi0FdAkTiwG
         Z8L3WbYPaAeZaYutztP1uItfaosNwFAcUg8MGalxW40GPuwcFD9TzZyQqiVy6KvujnyD
         tFaimkThOpXF/aGtWFt7XbIRcxiEGpy8iGwdUg6wqJhlNdeCqZI5qvGXJAL/z0n1ko1a
         +iMOS5Tbj3UhItdTwU5sOZKAUqg7t62lGVWjNaFUiYVFhBnQsLwt4rtkv4zwfTRgcGm5
         MiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720660482; x=1721265282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJJSf5oR3kQN0eEhskMp7G708IalEJkrKAj5CKBlLZU=;
        b=CvM6l2R4LWL3S/dt0eqVgF8HlALvt/Ff2IwHDc497jzksU0AGt9sW2auS5D5yU8OFP
         1+KpnIon7Z4vDajOOl5tQ90I/5XlF6z5rW6/2DEKg9X8XW4auJ+6JHioP/hZiGgIs2LS
         wXKK0y/Io5MBbbABGTkBNVSoB+odcNbJH2dkx2iTcOgk4Ew0e3DN5kX7efPul4kZabRP
         Kf9Ar+kZKIuANo+jrSxb9UkhnMLIjsMM4q5Q8vNo1g5pFPe01dN3kZx6fJN7f56VA+L1
         p0mgnmur79KKNhiftMZAlTEVvNINWLxvItVmTKQG5s/1gVTBbKYx6FWxeR/Gwh6ODcDv
         6Y4A==
X-Gm-Message-State: AOJu0Yw7xOsojWbxgi5/Doh9TLYF/7yolrJN8yIEpwYysws7ADWNJ/5i
	kY1zg0n6knwcTHxxvWeOnYPyJYPk0c69d9kKhrhWZVSsdvrtLif1
X-Google-Smtp-Source: AGHT+IE79P65C03JbHMip9X8qNQUOhPQ6fyqnpPbkkQXr+akuxERYb3z9OGZUJupyHxVTVRCAhMi+w==
X-Received: by 2002:a17:902:d50e:b0:1fb:38c0:173d with SMTP id d9443c01a7336-1fbb6d5aac7mr66236635ad.39.1720660481536;
        Wed, 10 Jul 2024 18:14:41 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a12ccfsm39677645ad.47.2024.07.10.18.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 18:14:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	schatzberg.dan@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	changwoo@igalia.com,
	righi.andrea@gmail.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] sched_ext: Unpin and repin rq lock from balance_scx()
Date: Wed, 10 Jul 2024 15:14:00 -1000
Message-ID: <20240711011434.1421572-4-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711011434.1421572-1-tj@kernel.org>
References: <20240711011434.1421572-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_ext often needs to migrate tasks across CPUs right before execution
and thus uses the balance path to dispatch tasks from the BPF scheduler.
balance_scx() is called with rq locked and pinned but is passed @rf and thus
allowed to unpin and unlock. Currently, @rf is passed down the call stack so
the rq lock is unpinned just when double locking is needed.

This creates unnecessary complications such as having to explicitly
manipulate lock pinning for core scheduling. We also want to use
dispatch_to_local_dsq_lock() from other paths which are called with rq
locked but unpinned.

rq lock handling in the dispatch path is straightforward outside the
migration implementation and extending the pinning protection down the
callstack doesn't add enough meaningful extra protection to justify the
extra complexity.

Unpin and repin rq lock from the outer balance_scx() and drop @rf passing
and lock pinning handling from the inner functions. UP is updated to call
balance_one() instead of balance_scx() to avoid adding NULL @rf handling to
balance_scx(). AS this makes balance_scx() unused in UP, it's put inside a
CONFIG_SMP block.

No functional changes intended outside of lock annotation updates.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Righi <righi.andrea@gmail.com>
Cc: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 93 +++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 59 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 62574d980409..d4f801cd2548 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -851,7 +851,6 @@ static u32 scx_dsp_max_batch;
 
 struct scx_dsp_ctx {
 	struct rq		*rq;
-	struct rq_flags		*rf;
 	u32			cursor;
 	u32			nr_tasks;
 	struct scx_dsp_buf_ent	buf[];
@@ -2040,7 +2039,6 @@ static bool move_task_to_local_dsq(struct rq *rq, struct task_struct *p,
 /**
  * dispatch_to_local_dsq_lock - Ensure source and destination rq's are locked
  * @rq: current rq which is locked
- * @rf: rq_flags to use when unlocking @rq
  * @src_rq: rq to move task from
  * @dst_rq: rq to move task to
  *
@@ -2049,20 +2047,16 @@ static bool move_task_to_local_dsq(struct rq *rq, struct task_struct *p,
  * @rq stays locked isn't important as long as the state is restored after
  * dispatch_to_local_dsq_unlock().
  */
-static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq_flags *rf,
-				       struct rq *src_rq, struct rq *dst_rq)
+static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq *src_rq,
+				       struct rq *dst_rq)
 {
-	rq_unpin_lock(rq, rf);
-
 	if (src_rq == dst_rq) {
 		raw_spin_rq_unlock(rq);
 		raw_spin_rq_lock(dst_rq);
 	} else if (rq == src_rq) {
 		double_lock_balance(rq, dst_rq);
-		rq_repin_lock(rq, rf);
 	} else if (rq == dst_rq) {
 		double_lock_balance(rq, src_rq);
-		rq_repin_lock(rq, rf);
 	} else {
 		raw_spin_rq_unlock(rq);
 		double_rq_lock(src_rq, dst_rq);
@@ -2072,19 +2066,17 @@ static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq_flags *rf,
 /**
  * dispatch_to_local_dsq_unlock - Undo dispatch_to_local_dsq_lock()
  * @rq: current rq which is locked
- * @rf: rq_flags to use when unlocking @rq
  * @src_rq: rq to move task from
  * @dst_rq: rq to move task to
  *
  * Unlock @src_rq and @dst_rq and ensure that @rq is locked on return.
  */
-static void dispatch_to_local_dsq_unlock(struct rq *rq, struct rq_flags *rf,
-					 struct rq *src_rq, struct rq *dst_rq)
+static void dispatch_to_local_dsq_unlock(struct rq *rq, struct rq *src_rq,
+					 struct rq *dst_rq)
 {
 	if (src_rq == dst_rq) {
 		raw_spin_rq_unlock(dst_rq);
 		raw_spin_rq_lock(rq);
-		rq_repin_lock(rq, rf);
 	} else if (rq == src_rq) {
 		double_unlock_balance(rq, dst_rq);
 	} else if (rq == dst_rq) {
@@ -2092,7 +2084,6 @@ static void dispatch_to_local_dsq_unlock(struct rq *rq, struct rq_flags *rf,
 	} else {
 		double_rq_unlock(src_rq, dst_rq);
 		raw_spin_rq_lock(rq);
-		rq_repin_lock(rq, rf);
 	}
 }
 #endif	/* CONFIG_SMP */
@@ -2132,8 +2123,7 @@ static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq)
 	return true;
 }
 
-static bool consume_remote_task(struct rq *rq, struct rq_flags *rf,
-				struct scx_dispatch_q *dsq,
+static bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *dsq,
 				struct task_struct *p, struct rq *task_rq)
 {
 	bool moved = false;
@@ -2153,9 +2143,7 @@ static bool consume_remote_task(struct rq *rq, struct rq_flags *rf,
 	p->scx.holding_cpu = raw_smp_processor_id();
 	raw_spin_unlock(&dsq->lock);
 
-	rq_unpin_lock(rq, rf);
 	double_lock_balance(rq, task_rq);
-	rq_repin_lock(rq, rf);
 
 	moved = move_task_to_local_dsq(rq, p, 0);
 
@@ -2165,13 +2153,11 @@ static bool consume_remote_task(struct rq *rq, struct rq_flags *rf,
 }
 #else	/* CONFIG_SMP */
 static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq) { return false; }
-static bool consume_remote_task(struct rq *rq, struct rq_flags *rf,
-				struct scx_dispatch_q *dsq,
+static bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *dsq,
 				struct task_struct *p, struct rq *task_rq) { return false; }
 #endif	/* CONFIG_SMP */
 
-static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
-			       struct scx_dispatch_q *dsq)
+static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
 {
 	struct task_struct *p;
 retry:
@@ -2194,7 +2180,7 @@ static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
 		}
 
 		if (task_can_run_on_remote_rq(p, rq)) {
-			if (likely(consume_remote_task(rq, rf, dsq, p, task_rq)))
+			if (likely(consume_remote_task(rq, dsq, p, task_rq)))
 				return true;
 			goto retry;
 		}
@@ -2214,7 +2200,6 @@ enum dispatch_to_local_dsq_ret {
 /**
  * dispatch_to_local_dsq - Dispatch a task to a local dsq
  * @rq: current rq which is locked
- * @rf: rq_flags to use when unlocking @rq
  * @dsq_id: destination dsq ID
  * @p: task to dispatch
  * @enq_flags: %SCX_ENQ_*
@@ -2227,8 +2212,8 @@ enum dispatch_to_local_dsq_ret {
  * %SCX_OPSS_DISPATCHING).
  */
 static enum dispatch_to_local_dsq_ret
-dispatch_to_local_dsq(struct rq *rq, struct rq_flags *rf, u64 dsq_id,
-		      struct task_struct *p, u64 enq_flags)
+dispatch_to_local_dsq(struct rq *rq, u64 dsq_id, struct task_struct *p,
+		      u64 enq_flags)
 {
 	struct rq *src_rq = task_rq(p);
 	struct rq *dst_rq;
@@ -2277,7 +2262,7 @@ dispatch_to_local_dsq(struct rq *rq, struct rq_flags *rf, u64 dsq_id,
 		/* store_release ensures that dequeue sees the above */
 		atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
 
-		dispatch_to_local_dsq_lock(rq, rf, src_rq, locked_dst_rq);
+		dispatch_to_local_dsq_lock(rq, src_rq, locked_dst_rq);
 
 		/*
 		 * We don't require the BPF scheduler to avoid dispatching to
@@ -2312,7 +2297,7 @@ dispatch_to_local_dsq(struct rq *rq, struct rq_flags *rf, u64 dsq_id,
 					     dst_rq->curr->sched_class))
 			resched_curr(dst_rq);
 
-		dispatch_to_local_dsq_unlock(rq, rf, src_rq, locked_dst_rq);
+		dispatch_to_local_dsq_unlock(rq, src_rq, locked_dst_rq);
 
 		return dsp ? DTL_DISPATCHED : DTL_LOST;
 	}
@@ -2326,7 +2311,6 @@ dispatch_to_local_dsq(struct rq *rq, struct rq_flags *rf, u64 dsq_id,
 /**
  * finish_dispatch - Asynchronously finish dispatching a task
  * @rq: current rq which is locked
- * @rf: rq_flags to use when unlocking @rq
  * @p: task to finish dispatching
  * @qseq_at_dispatch: qseq when @p started getting dispatched
  * @dsq_id: destination DSQ ID
@@ -2343,8 +2327,7 @@ dispatch_to_local_dsq(struct rq *rq, struct rq_flags *rf, u64 dsq_id,
  * was valid in the first place. Make sure that the task is still owned by the
  * BPF scheduler and claim the ownership before dispatching.
  */
-static void finish_dispatch(struct rq *rq, struct rq_flags *rf,
-			    struct task_struct *p,
+static void finish_dispatch(struct rq *rq, struct task_struct *p,
 			    unsigned long qseq_at_dispatch,
 			    u64 dsq_id, u64 enq_flags)
 {
@@ -2397,7 +2380,7 @@ static void finish_dispatch(struct rq *rq, struct rq_flags *rf,
 
 	BUG_ON(!(p->scx.flags & SCX_TASK_QUEUED));
 
-	switch (dispatch_to_local_dsq(rq, rf, dsq_id, p, enq_flags)) {
+	switch (dispatch_to_local_dsq(rq, dsq_id, p, enq_flags)) {
 	case DTL_DISPATCHED:
 		break;
 	case DTL_LOST:
@@ -2413,7 +2396,7 @@ static void finish_dispatch(struct rq *rq, struct rq_flags *rf,
 	}
 }
 
-static void flush_dispatch_buf(struct rq *rq, struct rq_flags *rf)
+static void flush_dispatch_buf(struct rq *rq)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	u32 u;
@@ -2421,7 +2404,7 @@ static void flush_dispatch_buf(struct rq *rq, struct rq_flags *rf)
 	for (u = 0; u < dspc->cursor; u++) {
 		struct scx_dsp_buf_ent *ent = &dspc->buf[u];
 
-		finish_dispatch(rq, rf, ent->task, ent->qseq, ent->dsq_id,
+		finish_dispatch(rq, ent->task, ent->qseq, ent->dsq_id,
 				ent->enq_flags);
 	}
 
@@ -2429,8 +2412,7 @@ static void flush_dispatch_buf(struct rq *rq, struct rq_flags *rf)
 	dspc->cursor = 0;
 }
 
-static int balance_one(struct rq *rq, struct task_struct *prev,
-		       struct rq_flags *rf, bool local)
+static int balance_one(struct rq *rq, struct task_struct *prev, bool local)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
@@ -2484,14 +2466,13 @@ static int balance_one(struct rq *rq, struct task_struct *prev,
 	if (rq->scx.local_dsq.nr)
 		goto has_tasks;
 
-	if (consume_dispatch_q(rq, rf, &scx_dsq_global))
+	if (consume_dispatch_q(rq, &scx_dsq_global))
 		goto has_tasks;
 
 	if (!SCX_HAS_OP(dispatch) || scx_ops_bypassing() || !scx_rq_online(rq))
 		goto out;
 
 	dspc->rq = rq;
-	dspc->rf = rf;
 
 	/*
 	 * The dispatch loop. Because flush_dispatch_buf() may drop the rq lock,
@@ -2506,11 +2487,11 @@ static int balance_one(struct rq *rq, struct task_struct *prev,
 		SCX_CALL_OP(SCX_KF_DISPATCH, dispatch, cpu_of(rq),
 			    prev_on_scx ? prev : NULL);
 
-		flush_dispatch_buf(rq, rf);
+		flush_dispatch_buf(rq);
 
 		if (rq->scx.local_dsq.nr)
 			goto has_tasks;
-		if (consume_dispatch_q(rq, rf, &scx_dsq_global))
+		if (consume_dispatch_q(rq, &scx_dsq_global))
 			goto has_tasks;
 
 		/*
@@ -2537,12 +2518,15 @@ static int balance_one(struct rq *rq, struct task_struct *prev,
 	return has_tasks;
 }
 
+#ifdef CONFIG_SMP
 static int balance_scx(struct rq *rq, struct task_struct *prev,
 		       struct rq_flags *rf)
 {
 	int ret;
 
-	ret = balance_one(rq, prev, rf, true);
+	rq_unpin_lock(rq, rf);
+
+	ret = balance_one(rq, prev, true);
 
 #ifdef CONFIG_SCHED_SMT
 	/*
@@ -2556,28 +2540,19 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 
 		for_each_cpu_andnot(scpu, smt_mask, cpumask_of(cpu_of(rq))) {
 			struct rq *srq = cpu_rq(scpu);
-			struct rq_flags srf;
 			struct task_struct *sprev = srq->curr;
 
-			/*
-			 * While core-scheduling, rq lock is shared among
-			 * siblings but the debug annotations and rq clock
-			 * aren't. Do pinning dance to transfer the ownership.
-			 */
 			WARN_ON_ONCE(__rq_lockp(rq) != __rq_lockp(srq));
-			rq_unpin_lock(rq, rf);
-			rq_pin_lock(srq, &srf);
-
 			update_rq_clock(srq);
-			balance_one(srq, sprev, &srf, false);
-
-			rq_unpin_lock(srq, &srf);
-			rq_repin_lock(rq, rf);
+			balance_one(srq, sprev, false);
 		}
 	}
 #endif
+	rq_repin_lock(rq, rf);
+
 	return ret;
 }
+#endif
 
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
@@ -2647,11 +2622,11 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 	 * balance_scx() must be called before the previous SCX task goes
 	 * through put_prev_task_scx().
 	 *
-	 * As UP doesn't transfer tasks around, balance_scx() doesn't need @rf.
-	 * Pass in %NULL.
+         * @rq is pinned and can't be unlocked. As UP doesn't transfer tasks
+         * around, balance_one() doesn't need to.
 	 */
 	if (p->scx.flags & (SCX_TASK_QUEUED | SCX_TASK_DEQD_FOR_SLEEP))
-		balance_scx(rq, p, NULL);
+		balance_one(rq, p, true);
 #endif
 
 	update_curr_scx(rq);
@@ -2714,7 +2689,7 @@ static struct task_struct *pick_next_task_scx(struct rq *rq)
 #ifndef CONFIG_SMP
 	/* UP workaround - see the comment at the head of put_prev_task_scx() */
 	if (unlikely(rq->curr->sched_class != &ext_sched_class))
-		balance_scx(rq, rq->curr, NULL);
+		balance_one(rq, rq->curr, true);
 #endif
 
 	p = first_local_task(rq);
@@ -5577,7 +5552,7 @@ __bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
 	if (!scx_kf_allowed(SCX_KF_DISPATCH))
 		return false;
 
-	flush_dispatch_buf(dspc->rq, dspc->rf);
+	flush_dispatch_buf(dspc->rq);
 
 	dsq = find_non_local_dsq(dsq_id);
 	if (unlikely(!dsq)) {
@@ -5585,7 +5560,7 @@ __bpf_kfunc bool scx_bpf_consume(u64 dsq_id)
 		return false;
 	}
 
-	if (consume_dispatch_q(dspc->rq, dspc->rf, dsq)) {
+	if (consume_dispatch_q(dspc->rq, dsq)) {
 		/*
 		 * A successfully consumed task can be dequeued before it starts
 		 * running while the CPU is trying to migrate other dispatched
-- 
2.45.2


