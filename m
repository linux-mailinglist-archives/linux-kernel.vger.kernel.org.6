Return-Path: <linux-kernel+bounces-246696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0F292C53F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF6E282D7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5212A18C162;
	Tue,  9 Jul 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq72zE3A"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864C7189F37
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560112; cv=none; b=gKhXr5ryiZ0cNMzrpcL+3+6+WdyqJFip5W+4YvYUUksoIm2m6vr9/OiK+wS47JT+BqHS5bXu88G3aeMCSuL9LV5sGtko9p1vfhGVkFLCjRm5qz/u6CCQ7AtQazFhJL5iLe067b0gHVr4AOdKti3BLeM+cKhfCo+bNzskFq0VxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560112; c=relaxed/simple;
	bh=CeizRUvb3JbGkT0SmuvPRFS0eHGVG9tklbWL4AKbVoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeyUshcUHbim9CoguaIo7u9kbPACDCT2DM+wwb6uVKQBzO1SrPsB/DecOnUF/xv29epzZr23chNApedTxflMWztNAGteSs98OM560qNct0gNCcCAGfwlAOmcRocp3PnGPwCxTzycjMTJv79M2Ak1eba+Slo7wXbpqdGbGBao6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iq72zE3A; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b04cb28acso135997b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720560110; x=1721164910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whMV9wx/p7Yhwqt1/Q9gbAswbqaS9hbXZkutfX/rm7Y=;
        b=Iq72zE3ARdoUbhjJmmoPSGY4yDuUOxMOSt7cXBM5CT5zA3t5JQkXNgXrFeOd6EbZcI
         wHyNYL1yUtFiegpcMCs4JrQ+jWMvEjZCEa0dut3FuRH9ewZIgmMe3sMOcbIaZ4RX7H+L
         bhkVTlixwvsZtTbv+cmq8126OvihEB+1C1mNMORccHXK+AVaXyW8N3aQ9bGbLzVsG0av
         AUV/LVP6rzj+2+BFUWZg+zbVIY59AUQn9WxJALKkiR/n/75RwoFBYj1AZeOsFCvXzoW7
         6ampasxpgApcdzRIhD8CiOLPibn2PC7QulM1rCn7f46ujCx3qmEHno+BPmfMSixQFx2r
         mBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560110; x=1721164910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=whMV9wx/p7Yhwqt1/Q9gbAswbqaS9hbXZkutfX/rm7Y=;
        b=gc1xrIEyRCYSQFiHy8bifwf8qz/xQMPbmhOBxd4VGsX/UKAXbkmkjZHvxvB689xQmX
         1n77IePP3hu54VbfnsSN6JzLkpRPRww2hB2OgNvrSFUpSIku0lY3sPtukrmBxCdl59sD
         RbjzgpFMa2jujSjBY5TsLp10122R/kPoodXTqzk7K1AzTR/dw67zUtgrPddEB8VS8m53
         sR4LhTtif5yA/oHrkoqw68EDFRI5KI7WbqqvJdraZkfEFG+z36oHwJT+vU1JHcKKHeg9
         WFVhGSBhDlOe/Gpa5g4Kpn325DdrxJ9L4M9xKSCFlXvCGJmHZvHpGyCbX80RYfaf85TP
         6p8A==
X-Gm-Message-State: AOJu0YyXMoLRUGljVDexWyloHUbG8fd/RIglkz1mVc1kxpePXh/gTxTq
	GmjQgym/yCJgZuJizfjksaEfFcHNBDzY6rRuod0YDELlpQPsJr/R
X-Google-Smtp-Source: AGHT+IGv+fZE5JFMZp72ycSuOSa6u5ILZlqiPJFvtZPDVKQ6LKVZugim92f32lxDGKohEstjoedTBQ==
X-Received: by 2002:a05:6a00:92a3:b0:706:1f67:64d3 with SMTP id d2e1a72fcca58-70b44da595bmr5078196b3a.14.1720560109727;
        Tue, 09 Jul 2024 14:21:49 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439678c3sm2289117b3a.127.2024.07.09.14.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:21:49 -0700 (PDT)
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
Subject: [PATCH 5/6] sched_ext: Allow SCX_DSQ_LOCAL_ON for direct dispatches
Date: Tue,  9 Jul 2024 11:21:11 -1000
Message-ID: <20240709212137.1199269-6-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709212137.1199269-1-tj@kernel.org>
References: <20240709212137.1199269-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ops.dispatch(), SCX_DSQ_LOCAL_ON can be used to dispatch the task to the
local DSQ of any CPU. However, during direct dispatch from ops.select_cpu()
and ops.enqueue(), this isn't allowed. This is because dispatching to the
local DSQ of a remote CPU requires locking both the task's current and new
rq's and such double locking can't be done directly from ops.enqueue().

While waking up a task, as ops.select_cpu() can pick any CPU and both
ops.select_cpu() and ops.enqueue() can use SCX_DSQ_LOCAL as the dispatch
target to dispatch to the DSQ of the picked CPU, the BPF scheduler can still
do whatever it wants to do. However, while a task is being enqueued for a
different reason, e.g. after its slice expiration, only ops.enqueue() is
called and there's no way for the BPF scheduler to directly dispatch to the
local DSQ of a remote CPU. This gap in API forces schedulers into
work-arounds which are not straightforward or optimal such as skipping
direct dispatches in such cases.

Implement deferred enqueueing to allow directly dispatching to the local DSQ
of a remote CPU from ops.select_cpu() and ops.enqueue(). Such tasks are
temporarily queued on rq->scx.ddsp_deferred_locals. When the rq lock can be
safely released, the tasks are taken off the list and queued on the target
local DSQs using dispatch_to_local_dsq().

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Changwoo Min <changwoo@igalia.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
---
 kernel/sched/ext.c   | 164 ++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h |   3 +
 2 files changed, 149 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a88c51ce63a5..f4edc37bf89b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -889,6 +889,7 @@ static struct kobject *scx_root_kobj;
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched_ext.h>
 
+static void process_ddsp_deferred_locals(struct rq *rq);
 static void scx_bpf_kick_cpu(s32 cpu, u64 flags);
 static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 					     s64 exit_code,
@@ -1363,6 +1364,63 @@ static int ops_sanitize_err(const char *ops_name, s32 err)
 	return -EPROTO;
 }
 
+static void run_deferred(struct rq *rq)
+{
+	process_ddsp_deferred_locals(rq);
+}
+
+static void deferred_bal_cb_workfn(struct rq *rq)
+{
+	run_deferred(rq);
+}
+
+static void deferred_irq_workfn(struct irq_work *irq_work)
+{
+	struct rq *rq = container_of(irq_work, struct rq, scx.deferred_irq_work);
+
+	raw_spin_rq_lock(rq);
+	run_deferred(rq);
+	raw_spin_rq_unlock(rq);
+}
+
+/**
+ * schedule_deferred - Schedule execution of deferred actions on an rq
+ * @rq: target rq
+ *
+ * Schedule execution of deferred actions on @rq. Must be called with @rq
+ * locked. Deferred actions are executed with @rq locked but unpinned, and thus
+ * can unlock @rq to e.g. migrate tasks to other rqs.
+ */
+static void schedule_deferred(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+
+#ifdef CONFIG_SMP
+	/*
+	 * If in the middle of waking up a task, task_woken_scx() will be called
+	 * afterwards which will then run the deferred actions, no need to
+	 * schedule anything.
+	 */
+	if (rq->scx.flags & SCX_RQ_IN_WAKEUP)
+		return;
+
+	/*
+	 * If in balance, the balance callbacks will be called before rq lock is
+	 * released. Schedule one.
+	 */
+	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
+		queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
+				       deferred_bal_cb_workfn);
+#endif
+	/*
+	 * No scheduler hooks available. Queue an irq work. They are executed on
+	 * IRQ re-enable which may take a bit longer than the scheduler hooks.
+	 * The above WAKEUP and BALANCE paths should cover most of the cases and
+	 * the time to IRQ re-enable shouldn't be long.
+	 */
+	irq_work_queue(&rq->scx.deferred_irq_work);
+}
+
 /**
  * touch_core_sched - Update timestamp used for core-sched task ordering
  * @rq: rq to read clock from, must be locked
@@ -1578,7 +1636,13 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	bool is_local = dsq == &rq->scx.local_dsq;
 
 	if (!dsq) {
-		WARN_ON_ONCE(!list_empty(&p->scx.dsq_list.node));
+		/*
+		 * If !dsq && on-list, @p is on @rq's ddsp_deferred_locals.
+		 * Unlinking is all that's needed to cancel.
+		 */
+		if (unlikely(!list_empty(&p->scx.dsq_list.node)))
+			list_del_init(&p->scx.dsq_list.node);
+
 		/*
 		 * When dispatching directly from the BPF scheduler to a local
 		 * DSQ, the task isn't associated with any DSQ but
@@ -1587,6 +1651,7 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		 */
 		if (p->scx.holding_cpu >= 0)
 			p->scx.holding_cpu = -1;
+
 		return;
 	}
 
@@ -1674,17 +1739,6 @@ static void mark_direct_dispatch(struct task_struct *ddsp_task,
 		return;
 	}
 
-	/*
-	 * %SCX_DSQ_LOCAL_ON is not supported during direct dispatch because
-	 * dispatching to the local DSQ of a different CPU requires unlocking
-	 * the current rq which isn't allowed in the enqueue path. Use
-	 * ops.select_cpu() to be on the target CPU and then %SCX_DSQ_LOCAL.
-	 */
-	if (unlikely((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON)) {
-		scx_ops_error("SCX_DSQ_LOCAL_ON can't be used for direct-dispatch");
-		return;
-	}
-
 	WARN_ON_ONCE(p->scx.ddsp_dsq_id != SCX_DSQ_INVALID);
 	WARN_ON_ONCE(p->scx.ddsp_enq_flags);
 
@@ -1694,13 +1748,58 @@ static void mark_direct_dispatch(struct task_struct *ddsp_task,
 
 static void direct_dispatch(struct task_struct *p, u64 enq_flags)
 {
+	struct rq *rq = task_rq(p);
 	struct scx_dispatch_q *dsq;
+	u64 dsq_id = p->scx.ddsp_dsq_id;
+
+	touch_core_sched_dispatch(rq, p);
+
+	p->scx.ddsp_enq_flags |= enq_flags;
+
+	/*
+	 * We are in the enqueue path with @rq locked and pinned, and thus can't
+	 * double lock a remote rq and enqueue to its local DSQ. For
+	 * DSQ_LOCAL_ON verdicts targeting the local DSQ of a remote CPU, defer
+	 * the enqueue so that it's executed when @rq can be unlocked.
+	 */
+	if ((dsq_id & SCX_DSQ_LOCAL_ON) == SCX_DSQ_LOCAL_ON) {
+		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
+		unsigned long opss;
+
+		if (cpu == cpu_of(rq)) {
+			dsq_id = SCX_DSQ_LOCAL;
+			goto dispatch;
+		}
+
+		opss = atomic_long_read(&p->scx.ops_state) & SCX_OPSS_STATE_MASK;
+
+		switch (opss & SCX_OPSS_STATE_MASK) {
+		case SCX_OPSS_NONE:
+			break;
+		case SCX_OPSS_QUEUEING:
+			/*
+			 * As @p was never passed to the BPF side, _release is
+			 * not strictly necessary. Still do it for consistency.
+			 */
+			atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
+			break;
+		default:
+			WARN_ONCE(true, "sched_ext: %s[%d] has invalid ops state 0x%lx in direct_dispatch()",
+				  p->comm, p->pid, opss);
+			atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
+			break;
+		}
 
-	touch_core_sched_dispatch(task_rq(p), p);
+		WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
+		list_add_tail(&p->scx.dsq_list.node,
+			      &rq->scx.ddsp_deferred_locals);
+		schedule_deferred(rq);
+		return;
+	}
 
-	enq_flags |= (p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
-	dsq = find_dsq_for_dispatch(task_rq(p), p->scx.ddsp_dsq_id, p);
-	dispatch_enqueue(dsq, p, enq_flags);
+dispatch:
+	dsq = find_dsq_for_dispatch(rq, dsq_id, p);
+	dispatch_enqueue(dsq, p, p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
 }
 
 static bool scx_rq_online(struct rq *rq)
@@ -2631,6 +2730,29 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 }
 
+static void process_ddsp_deferred_locals(struct rq *rq)
+{
+	struct task_struct *p, *tmp;
+
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * Now that @rq can be unlocked, execute the deferred enqueueing of
+	 * tasks directly dispatched to the local DSQs of other CPUs. See
+	 * direct_dispatch().
+	 */
+	list_for_each_entry_safe(p, tmp, &rq->scx.ddsp_deferred_locals,
+				 scx.dsq_list.node) {
+		s32 ret;
+
+		list_del_init(&p->scx.dsq_list.node);
+
+		ret = dispatch_to_local_dsq(rq, NULL, p->scx.ddsp_dsq_id, p,
+					    p->scx.ddsp_enq_flags);
+		WARN_ON_ONCE(ret == DTL_NOT_LOCAL);
+	}
+}
+
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 {
 #ifndef CONFIG_SMP
@@ -3052,6 +3174,11 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 	}
 }
 
+static void task_woken_scx(struct rq *rq, struct task_struct *p)
+{
+	run_deferred(rq);
+}
+
 static void set_cpus_allowed_scx(struct task_struct *p,
 				 struct affinity_context *ac)
 {
@@ -3568,8 +3695,6 @@ bool scx_can_stop_tick(struct rq *rq)
  *
  * - task_fork/dead: We need fork/dead notifications for all tasks regardless of
  *   their current sched_class. Call them directly from sched core instead.
- *
- * - task_woken: Unnecessary.
  */
 DEFINE_SCHED_CLASS(ext) = {
 	.enqueue_task		= enqueue_task_scx,
@@ -3589,6 +3714,7 @@ DEFINE_SCHED_CLASS(ext) = {
 #ifdef CONFIG_SMP
 	.balance		= balance_scx,
 	.select_task_rq		= select_task_rq_scx,
+	.task_woken		= task_woken_scx,
 	.set_cpus_allowed	= set_cpus_allowed_scx,
 
 	.rq_online		= rq_online_scx,
@@ -5293,11 +5419,13 @@ void __init init_sched_ext_class(void)
 
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
+		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
 
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
 		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_wait, GFP_KERNEL));
+		init_irq_work(&rq->scx.deferred_irq_work, deferred_irq_workfn);
 		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
 
 		if (cpu_online(cpu))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8a0e8052f6b0..be7be54484c0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -746,6 +746,7 @@ enum scx_rq_flags {
 struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
+	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
 	unsigned long		ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
@@ -757,6 +758,8 @@ struct scx_rq {
 	cpumask_var_t		cpus_to_preempt;
 	cpumask_var_t		cpus_to_wait;
 	unsigned long		pnt_seq;
+	struct balance_callback	deferred_bal_cb;
+	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
-- 
2.45.2


