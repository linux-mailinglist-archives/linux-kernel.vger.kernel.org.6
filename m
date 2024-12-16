Return-Path: <linux-kernel+bounces-447368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7FD9F3143
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7403818849C2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7925205AA1;
	Mon, 16 Dec 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSigkhnX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270B2054F0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354570; cv=none; b=S1aL9VyY+RVhHKB1oo3w0mv8Y+NrRobz7d8HMjcOia8mcnqK/4FFTPG14Be7QPCWXX2D+HS4OSRAb2U27m+zZeG6UQkQ56X2DucmhApxm6aj4Mwfe3Wm4qDrq8GyiPac507dhw4dmYGhdZFOclAQrnm3w21nWoQ9hPffP0axFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354570; c=relaxed/simple;
	bh=xKdWgrGQbQ66cEIzO/2PbLwuYRh4NppdahDdTewXLqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdtubMpC5+qrbN8yz79O5xSRbKeQymBVw8l0yiZpW4xOshyI55zdUqbV0y+DEcRFfCSsEejIfVGvx4DlNIc63vx9ehQ1BfjMWFAdEBaXODnUeEWNc/JcqELJ/hjQRgEP6TTIDkEodBeXpQVH2vGhH66ulVdz2DqlEFRnDadpe9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSigkhnX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734354567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDvTtsToy10cct7t5ck8viUzORJyYfeA1yptX9MXqDM=;
	b=GSigkhnX1bUffmna7dHodkvtI4yGPncyONyzpALf3DRCJr82VX2PtJCmYqfjK4fxtB7q3r
	KIAC8S9CdjUNFMOHwTV0ssWMnV/9xtyXew9L/sdUs+Ki2TBFjswHMnU+QhpnjHU7HLCGKR
	EJ0MlJVB8JgjUbi734XKMbHI81ziHA4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-S-U76gCfN7SzpAq_Rouh5A-1; Mon,
 16 Dec 2024 08:09:25 -0500
X-MC-Unique: S-U76gCfN7SzpAq_Rouh5A-1
X-Mimecast-MFC-AGG-ID: S-U76gCfN7SzpAq_Rouh5A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A7FC1956059;
	Mon, 16 Dec 2024 13:09:24 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.193.102])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED8A51956052;
	Mon, 16 Dec 2024 13:09:20 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 2/3] sched: Move task_mm_cid_work to mm delayed work
Date: Mon, 16 Dec 2024 14:09:08 +0100
Message-ID: <20241216130909.240042-3-gmonaco@redhat.com>
In-Reply-To: <20241216130909.240042-1-gmonaco@redhat.com>
References: <20241216130909.240042-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently, the task_mm_cid_work function is called in a task work
triggered by a scheduler tick to frequently compact the mm_cids of each
process. This can delay the execution of the corresponding thread for
the entire duration of the function, negatively affecting the response
in case of real time tasks. In practice, we observe task_mm_cid_work
increasing the latency of 30-35us on a 128 cores system, this order of
magnitude is meaningful under PREEMPT_RT.

This patch runs the task_mm_cid_work in a new delayed work connected to
the mm_struct rather than in the task context before returning to
userspace.

This delayed work is initialised while allocating the mm and disabled
before freeing it, its execution is no longer triggered by scheduler
ticks but run periodically based on the defined MM_CID_SCAN_DELAY.

The main advantage of this change is that the function can be offloaded
to a different CPU and even preempted by RT tasks.

Moreover, this new behaviour could be more predictable with periodic
tasks with short runtime, which may rarely run during a scheduler tick.
Now, the work is always scheduled with the same periodicity for each mm
(though the periodicity is not guaranteed due to interference from other
tasks, but mm_cid compaction is mostly best effort).

To avoid excessively increased runtime, we quickly return from the
function if we have no work to be done (i.e. no mm_cid is allocated).
This is helpful for tasks that sleep for a long time, but also for
terminated task. We are no longer following the process' state, hence
the function continues to run after a process terminates but before its
mm is freed.

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/mm_types.h | 16 ++++++----
 include/linux/sched.h    |  1 -
 kernel/sched/core.c      | 66 +++++-----------------------------------
 kernel/sched/sched.h     |  7 -----
 4 files changed, 18 insertions(+), 72 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d56948a74254..16076e70a6b9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -829,12 +829,6 @@ struct mm_struct {
 		 * runqueue locks.
 		 */
 		struct mm_cid __percpu *pcpu_cid;
-		/*
-		 * @mm_cid_next_scan: Next mm_cid scan (in jiffies).
-		 *
-		 * When the next mm_cid scan is due (in jiffies).
-		 */
-		unsigned long mm_cid_next_scan;
 		/**
 		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
 		 *
@@ -857,6 +851,7 @@ struct mm_struct {
 		 * mm nr_cpus_allowed updates.
 		 */
 		raw_spinlock_t cpus_allowed_lock;
+		struct delayed_work mm_cid_work;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -1145,11 +1140,16 @@ static inline void vma_iter_init(struct vma_iterator *vmi,
 
 #ifdef CONFIG_SCHED_MM_CID
 
+#define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
+#define MM_CID_SCAN_DELAY	100			/* 100ms */
+
 enum mm_cid_state {
 	MM_CID_UNSET = -1U,		/* Unset state has lazy_put flag set. */
 	MM_CID_LAZY_PUT = (1U << 31),
 };
 
+extern void task_mm_cid_work(struct work_struct *work);
+
 static inline bool mm_cid_is_unset(int cid)
 {
 	return cid == MM_CID_UNSET;
@@ -1222,12 +1222,16 @@ static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *
 	if (!mm->pcpu_cid)
 		return -ENOMEM;
 	mm_init_cid(mm, p);
+	INIT_DELAYED_WORK(&mm->mm_cid_work, task_mm_cid_work);
+	schedule_delayed_work(&mm->mm_cid_work,
+			      msecs_to_jiffies(MM_CID_SCAN_DELAY));
 	return 0;
 }
 #define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
 
 static inline void mm_destroy_cid(struct mm_struct *mm)
 {
+	disable_delayed_work_sync(&mm->mm_cid_work);
 	free_percpu(mm->pcpu_cid);
 	mm->pcpu_cid = NULL;
 }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d380bffee2ef..5d141c310917 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1374,7 +1374,6 @@ struct task_struct {
 	int				last_mm_cid;	/* Most recent cid in mm */
 	int				migrate_from_cpu;
 	int				mm_cid_active;	/* Whether cid bitmap is active */
-	struct callback_head		cid_work;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c6d8232ad9ee..30d78fe14eff 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4516,7 +4516,6 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 	p->migration_pending = NULL;
 #endif
-	init_sched_mm_cid(p);
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
@@ -5654,7 +5653,6 @@ void sched_tick(void)
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
-	task_tick_mm_cid(rq, donor);
 	scx_tick(rq);
 
 	rq_unlock(rq, &rf);
@@ -10520,38 +10518,17 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
 	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
 }
 
-static void task_mm_cid_work(struct callback_head *work)
+void task_mm_cid_work(struct work_struct *work)
 {
-	unsigned long now = jiffies, old_scan, next_scan;
-	struct task_struct *t = current;
 	struct cpumask *cidmask;
-	struct mm_struct *mm;
+	struct delayed_work *delayed_work = container_of(work, struct delayed_work, work);
+	struct mm_struct *mm = container_of(delayed_work, struct mm_struct, mm_cid_work);
 	int weight, cpu;
 
-	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
-
-	work->next = work;	/* Prevent double-add */
-	if (t->flags & PF_EXITING)
-		return;
-	mm = t->mm;
-	if (!mm)
-		return;
-	old_scan = READ_ONCE(mm->mm_cid_next_scan);
-	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
-	if (!old_scan) {
-		unsigned long res;
-
-		res = cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
-		if (res != old_scan)
-			old_scan = res;
-		else
-			old_scan = next_scan;
-	}
-	if (time_before(now, old_scan))
-		return;
-	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
-		return;
 	cidmask = mm_cidmask(mm);
+	/* Nothing to clear for now */
+	if (cpumask_empty(cidmask))
+		goto out;
 	/* Clear cids that were not recently used. */
 	for_each_possible_cpu(cpu)
 		sched_mm_cid_remote_clear_old(mm, cpu);
@@ -10562,35 +10539,8 @@ static void task_mm_cid_work(struct callback_head *work)
 	 */
 	for_each_possible_cpu(cpu)
 		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
-}
-
-void init_sched_mm_cid(struct task_struct *t)
-{
-	struct mm_struct *mm = t->mm;
-	int mm_users = 0;
-
-	if (mm) {
-		mm_users = atomic_read(&mm->mm_users);
-		if (mm_users == 1)
-			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
-	}
-	t->cid_work.next = &t->cid_work;	/* Protect against double add */
-	init_task_work(&t->cid_work, task_mm_cid_work);
-}
-
-void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
-{
-	struct callback_head *work = &curr->cid_work;
-	unsigned long now = jiffies;
-
-	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
-	    work->next != work)
-		return;
-	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
-		return;
-
-	/* No page allocation under rq lock */
-	task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
+out:
+	schedule_delayed_work(delayed_work, msecs_to_jiffies(MM_CID_SCAN_DELAY));
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b50dcd908702..f3b0d1d86622 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3581,16 +3581,11 @@ extern void sched_dynamic_update(int mode);
 
 #ifdef CONFIG_SCHED_MM_CID
 
-#define SCHED_MM_CID_PERIOD_NS	(100ULL * 1000000)	/* 100ms */
-#define MM_CID_SCAN_DELAY	100			/* 100ms */
-
 extern raw_spinlock_t cid_lock;
 extern int use_cid_lock;
 
 extern void sched_mm_cid_migrate_from(struct task_struct *t);
 extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t);
-extern void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
-extern void init_sched_mm_cid(struct task_struct *t);
 
 static inline void __mm_cid_put(struct mm_struct *mm, int cid)
 {
@@ -3858,8 +3853,6 @@ static inline void switch_mm_cid(struct rq *rq,
 static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
 static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
 static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
-static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
-static inline void init_sched_mm_cid(struct task_struct *t) { }
 #endif /* !CONFIG_SCHED_MM_CID */
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
-- 
2.47.1


