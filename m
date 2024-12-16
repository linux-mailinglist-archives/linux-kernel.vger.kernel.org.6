Return-Path: <linux-kernel+bounces-446741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444589F289C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9F1165280
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2400315359A;
	Mon, 16 Dec 2024 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRmO4C6W"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B084189905
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318741; cv=none; b=OEAP7RjOEkwx330Q6IXhqRNokeYBOZFxZ9yFhQ0qxYLI8TJukNUgvW3mXzmZkRnG3MkrSJQtnpFCYWtcYVc/ZmCiJlwbUCTEeiOee1CGIgXS9hv7ktC0pROxq4hRQIkxPleirNG/anyDsLsVp3xw9Xm3qA7jADEf/FPjtb88EuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318741; c=relaxed/simple;
	bh=ARXOQdQSx11dZrIJgooSqC+dLcFILjDmqZ4pffr3ioU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEdmSwLLWzZ4DgOYwEm4fb0Z/S7hASCha/9pTdnSr5J7crcoQUC3SeRCT9opSstr4ebv89aslcQ9iVTzL4sJEezIDa7uoxy+Z/ojg3rV2GDMog4ugTOGHeRJOw9bqC304EQj8kmL79on9UGE6/6uGiZZVngVAWiy9CSlY9Qy938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRmO4C6W; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so3043339a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 19:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734318739; x=1734923539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqkOMc7yUSchrOgOACYpXkIQ2LF3oE6mW3dZxc94vO8=;
        b=bRmO4C6WRZFLHNOieh2ibpIPJwwyUtxW3esW01gFq2JFLtR2cmz3ZBCcgU8Zj/FfHR
         3C6LBCOWefWFGd3rbCBPxiVcweT2MfsufqhECMmaWlFgZW1D7TjVUXuNy6EE3GFC7kee
         uVv65gIbYrw4nCoQH8/sx+h/oCPuCATDdvgaRBfcCRSEwVhli711Ik7zGpETQ8JmZZQ+
         F+0ieqZmpGPLR1zgLyJFJuq7Zmjagi3dNkmMSskoLDyXcny5UscOwEKZ4o/ariXS01/I
         s8e3dH0JGuUyV2pKOit/uSGwC44Q3byxNtR4d4Cu7pAFMhaG/Yp2PfFBVjLetWfcq2Kd
         nQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734318739; x=1734923539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqkOMc7yUSchrOgOACYpXkIQ2LF3oE6mW3dZxc94vO8=;
        b=SHcVBo03V12NLvH6sCUu7pBq+th2wkdGeuJR4BoefUl8RraCyXgh89xXher/ruOX9V
         /Q3sFFYruYyPFbX2+ILW0/JfMIVuziAiT35QHNFkftwAothhdkgTztp7Nh9CL6WQxU18
         O/6om1gjrWe4t6yke0V4Xx4kTHecyUJ+Pqfqj/serBdXpqB4UL5ijRQw3DB/qFLElaaJ
         Kl1dq18LwUwWBgIWH63+RAvfInhgyzfJvPTla3HXp0pyL7YjR6+JfS2pPeD+olGsJzby
         rI1FKukuWIprKLXaLkLVbDUbS/tvahCs+E7DZfyx2tFAqMyLvw6S8WfGsPXfJsyK9ERJ
         Zt1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaFMmQIP5dMTfi0wIVr1Ei3/DK2iMVt8WBjIK/Jn2GgOyGMDEpMVMItLRFT3+q55zxRzvIVGzDGr3GT4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzT06OWJECuNkTJ60hWoWnhZYQ04kd5fTbeXmEsCrTkumVcKw9
	GmK7R4TFPL8XBBf/TMhEyWaACfgsrAx9cNBwR1bSXOteNH8NpkZ+
X-Gm-Gg: ASbGncso1Ol7wIRxSuTkjZ4UfDJzAGRpNG9FhmYEBcU+cYT7XzjUppGYWHe+F0L3/eH
	R9SwLKY06RmXkZ6ghUgbuk7z3eTkmd7FvYRs/IP04NKtyCaYibbJ6xxwHmO0sYZwCSfnfrdy4te
	QfiTnDg40Ke8mrIWz5NdQOKSNI/pklguA4yfKh0d4pXAW73eTXi/Ug318iulGO5q0E6dkgdO0ch
	FSS8pTqUlKaNH0CakyuvqpOjJRUj3u0vpGVhZMuyyK1gPMJmDW8qUM5DDYkUfX+QvsyOXAWQwDm
	R7Rozv6UWEPj
X-Google-Smtp-Source: AGHT+IFbo6wVuE1OCIlqpI8tH3ydH+JxuXb4lbrcE5BzLgtsPGBhrBLQ4qnmY9ZDoVjIApFmQRsZaw==
X-Received: by 2002:a17:90b:3c0a:b0:2ee:c9b6:c266 with SMTP id 98e67ed59e1d1-2f28fb67310mr15938915a91.13.1734318738578;
        Sun, 15 Dec 2024 19:12:18 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e503cdsm32715075ad.113.2024.12.15.19.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:12:18 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v5 2/6] sched_ext: Implement scx_bpf_now_ns()
Date: Mon, 16 Dec 2024 12:11:40 +0900
Message-ID: <20241216031144.98097-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216031144.98097-1-changwoo@igalia.com>
References: <20241216031144.98097-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Returns a high-performance monotonically non-decreasing clock for the current
CPU. The clock returned is in nanoseconds.

It provides the following properties:

1) High performance: Many BPF schedulers call bpf_ktime_get_ns() frequently
 to account for execution time and track tasks' runtime properties.
 Unfortunately, in some hardware platforms, bpf_ktime_get_ns() -- which
 eventually reads a hardware timestamp counter -- is neither performant nor
 scalable. scx_bpf_now_ns() aims to provide a high-performance clock by
 using the rq clock in the scheduler core whenever possible.

2) High enough resolution for the BPF scheduler use cases: In most BPF
 scheduler use cases, the required clock resolution is lower than the most
 accurate hardware clock (e.g., rdtsc in x86). scx_bpf_now_ns() basically
 uses the rq clock in the scheduler core whenever it is valid. It considers
 that the rq clock is valid from the time the rq clock is updated
 (update_rq_clock) until the rq is unlocked (rq_unpin_lock).

3) Monotonically non-decreasing clock for the same CPU: scx_bpf_now_ns()
 guarantees the clock never goes backward when comparing them in the same
 CPU. On the other hand, when comparing clocks in different CPUs, there
 is no such guarantee -- the clock can go backward. It provides a
 monotonically *non-decreasing* clock so that it would provide the same
 clock values in two different scx_bpf_now_ns() calls in the same CPU
 during the same period of when the rq clock is valid.

An rq clock becomes valid when it is updated using update_rq_clock()
and invalidated when the rq is unlocked using rq_unpin_lock().

Let's suppose the following timeline in the scheduler core:

   T1. rq_lock(rq)
   T2. update_rq_clock(rq)
   T3. a sched_ext BPF operation
   T4. rq_unlock(rq)
   T5. a sched_ext BPF operation
   T6. rq_lock(rq)
   T7. update_rq_clock(rq)

For [T2, T4), we consider that rq clock is valid (SCX_RQ_CLK_VALID is
set), so scx_bpf_now_ns() calls during [T2, T4) (including T3) will
return the rq clock updated at T2. For duration [T4, T7), when a BPF
scheduler can still call scx_bpf_now_ns() (T5), we consider the rq clock
is invalid (SCX_RQ_CLK_VALID is unset at T4). So when calling
scx_bpf_now_ns() at T5, we will return a fresh clock value by calling
sched_clock_cpu() internally. Also, to prevent getting outdated rq clocks
from a previous scx scheduler, invalidate all the rq clocks when unloading
a BPF scheduler.

One example of calling scx_bpf_now_ns(), when the rq clock is invalid
(like T5), is in scx_central [1]. The scx_central scheduler uses a BPF
timer for preemptive scheduling. In every msec, the timer callback checks
if the currently running tasks exceed their timeslice. At the beginning of
the BPF timer callback (central_timerfn in scx_central.bpf.c), scx_central
gets the current time. When the BPF timer callback runs, the rq clock could
be invalid, the same as T5. In this case, scx_bpf_now_ns() returns a fresh
clock value rather than returning the old one (T2).

[1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_central.bpf.c

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/core.c  |   6 ++-
 kernel/sched/ext.c   | 121 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  28 +++++++++-
 3 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a519..b0191977d919 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -789,6 +789,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 void update_rq_clock(struct rq *rq)
 {
 	s64 delta;
+	u64 clock;
 
 	lockdep_assert_rq_held(rq);
 
@@ -800,11 +801,14 @@ void update_rq_clock(struct rq *rq)
 		SCHED_WARN_ON(rq->clock_update_flags & RQCF_UPDATED);
 	rq->clock_update_flags |= RQCF_UPDATED;
 #endif
+	clock = sched_clock_cpu(cpu_of(rq));
+	scx_rq_clock_update(rq, clock, true);
 
-	delta = sched_clock_cpu(cpu_of(rq)) - rq->clock;
+	delta = clock - rq->clock;
 	if (delta < 0)
 		return;
 	rq->clock += delta;
+
 	update_rq_clock_task(rq, delta);
 }
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index afeed9dfeecb..991a86e87187 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4910,7 +4910,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	struct task_struct *p;
 	struct rhashtable_iter rht_iter;
 	struct scx_dispatch_q *dsq;
-	int i, kind;
+	int i, kind, cpu;
 
 	kind = atomic_read(&scx_exit_kind);
 	while (true) {
@@ -4993,6 +4993,15 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
 
+	/*
+	 * Invalidate all the rq clocks to prevent getting outdated
+	 * rq clocks from a previous scx scheduler.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+		scx_rq_clock_invalidate(rq);
+	}
+
 	/* no task is on scx, turn off all the switches and flush in-progress calls */
 	static_branch_disable(&__scx_ops_enabled);
 	for (i = SCX_OPI_BEGIN; i < SCX_OPI_END; i++)
@@ -7601,6 +7610,115 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
 }
 #endif
 
+/**
+ * scx_bpf_now_ns - Returns a high-performance monotonically non-decreasing
+ * clock for the current CPU. The clock returned is in nanoseconds.
+ *
+ * It provides the following properties:
+ *
+ * 1) High performance: Many BPF schedulers call bpf_ktime_get_ns() frequently
+ *  to account for execution time and track tasks' runtime properties.
+ *  Unfortunately, in some hardware platforms, bpf_ktime_get_ns() -- which
+ *  eventually reads a hardware timestamp counter -- is neither performant nor
+ *  scalable. scx_bpf_now_ns() aims to provide a high-performance clock by
+ *  using the rq clock in the scheduler core whenever possible.
+ *
+ * 2) High enough resolution for the BPF scheduler use cases: In most BPF
+ *  scheduler use cases, the required clock resolution is lower than the most
+ *  accurate hardware clock (e.g., rdtsc in x86). scx_bpf_now_ns() basically
+ *  uses the rq clock in the scheduler core whenever it is valid. It considers
+ *  that the rq clock is valid from the time the rq clock is updated
+ *  (update_rq_clock) until the rq is unlocked (rq_unpin_lock).
+ *
+ * 3) Monotonically non-decreasing clock for the same CPU: scx_bpf_now_ns()
+ *  guarantees the clock never goes backward when comparing them in the same
+ *  CPU. On the other hand, when comparing clocks in different CPUs, there
+ *  is no such guarantee -- the clock can go backward. It provides a
+ *  monotonically *non-decreasing* clock so that it would provide the same
+ *  clock values in two different scx_bpf_now_ns() calls in the same CPU
+ *  during the same period of when the rq clock is valid.
+ */
+__bpf_kfunc u64 scx_bpf_now_ns(void)
+{
+	struct rq *rq;
+	u64 clock;
+
+	preempt_disable();
+
+	/*
+	 * If the rq clock is valid, use the cached rq clock
+	 * whenever the clock does not go backward.
+	 */
+	rq = this_rq();
+	clock = READ_ONCE(rq->scx.clock);
+
+	if (!(READ_ONCE(rq->scx.flags) & SCX_RQ_CLK_VALID) ||
+	    time_after_eq64(READ_ONCE(rq->scx.prev_clock), clock)) {
+		/*
+		 * If the rq clock is invalid or goes backward,
+		 * start a new rq clock period with a fresh sched_clock_cpu().
+		 *
+		 * The cached rq clock can go backward because this kfunc can
+		 * be called from anywhere, including timer interrupts and
+		 * tracepoints for code running in the IRQ context.
+		 *
+		 * For example, suppose a timer interrupt occurred while
+		 * running scx_bpf_now_ns() *after* reading the rq clock and
+		 * *before* comparing the if condition.
+		 *
+		 * The timer interrupt will eventually call a BPF scheduler's
+		 * ops.tick(), and the BPF scheduler can call scx_bpf_now_ns().
+		 * Since the scheduler core updates the rq clock before calling
+		 * ops.tick(), the scx_bpf_now_ns() call will get the fresh
+		 * clock.
+		 *
+		 * After handling the timer interrupt, the interrupted
+		 * scx_bpf_now_ns() will be resumed, so the if condition will
+		 * be compared.
+		 *
+		 * In this case, the clock read before the timer interrupt
+		 * will be the same as rq->scx.prev_clock.
+		 *
+		 * When such a case is detected (i.e., prev_clock is smaller
+		 * or equal to the current clock), get a new rq clock with a
+		 * fresh sched_clock_cpu().
+		 *
+		 * The following illustrates the detailed sequence over time:
+		 *
+		 * Time| Task                   | Timer interrupt
+		 * ----+------------------------+------------------------------
+		 * T1  | call scx_bpf_now_ns()  |
+		 * T2  | load rq->scx.clock     |
+		 * T3  | compare rq->scx.flags  |
+		 * T4  |                        | timer interrupt occured
+		 * T5  |                        | sched_tick() called
+		 * T6  |                        | + rq_lock() called
+		 * T7  |                        | + update_rq_clock() called
+		 * T8  |                        | + sched_class->task_tick()
+		 * T9  |                        |  + scx_bpf_now_ns() returns
+		 *     |                        |    a fresh clock updated at T7.
+		 * T10 |                        | + rq_unlock() called
+		 * T11 | resume the execution   |
+		 * T12 | compare scx.prev_clock |
+		 *
+		 * Note that since the scx.prev_clock at T12 was updated at T7,
+		 * it will be the same as rq->scx.clock at T2.
+		 */
+		clock = sched_clock_cpu(cpu_of(rq));
+
+		/*
+		 * The rq clock is updated outside of the rq lock.
+		 * In this case, keep the updated rq clock invalid so the next
+		 * kfunc call outside the rq lock gets a fresh rq clock.
+		 */
+		scx_rq_clock_update(rq, clock, false);
+	}
+
+	preempt_enable();
+
+	return clock;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
@@ -7632,6 +7750,7 @@ BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
 #ifdef CONFIG_CGROUP_SCHED
 BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 #endif
+BTF_ID_FLAGS(func, scx_bpf_now_ns)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 440ecedf871b..892975543a6d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -754,6 +754,7 @@ enum scx_rq_flags {
 	SCX_RQ_BAL_PENDING	= 1 << 2, /* balance hasn't run yet */
 	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
 	SCX_RQ_BYPASSING	= 1 << 4,
+	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_BALANCE	= 1 << 17,
@@ -766,9 +767,11 @@ struct scx_rq {
 	unsigned long		ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
-	u32			flags;
 	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
 	bool			cpu_released;
+	u32			flags;
+	u64			clock;			/* current per-rq clock -- see scx_bpf_now_ns() */
+	u64			prev_clock;		/* previous per-rq clock -- see scx_bpf_now_ns() */
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
 	cpumask_var_t		cpus_to_preempt;
@@ -1725,9 +1728,30 @@ DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
 
 #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
 #define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
+
+static inline void scx_rq_clock_update(struct rq *rq, u64 clock, bool valid)
+{
+	if (!scx_enabled())
+		return;
+	WRITE_ONCE(rq->scx.prev_clock, rq->scx.clock);
+	WRITE_ONCE(rq->scx.clock, clock);
+	if (valid)
+		WRITE_ONCE(rq->scx.flags, rq->scx.flags | SCX_RQ_CLK_VALID);
+}
+
+static inline void scx_rq_clock_invalidate(struct rq *rq)
+{
+	if (!scx_enabled())
+		return;
+	WRITE_ONCE(rq->scx.flags, rq->scx.flags & ~SCX_RQ_CLK_VALID);
+}
+
 #else /* !CONFIG_SCHED_CLASS_EXT */
 #define scx_enabled()		false
 #define scx_switched_all()	false
+
+static inline void scx_rq_clock_update(struct rq *rq, u64 clock, bool valid) {}
+static inline void scx_rq_clock_invalidate(struct rq *rq) {}
 #endif /* !CONFIG_SCHED_CLASS_EXT */
 
 /*
@@ -1759,7 +1783,7 @@ static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 	if (rq->clock_update_flags > RQCF_ACT_SKIP)
 		rf->clock_update_flags = RQCF_UPDATED;
 #endif
-
+	scx_rq_clock_invalidate(rq);
 	lockdep_unpin_lock(__rq_lockp(rq), rf->cookie);
 }
 
-- 
2.47.1


