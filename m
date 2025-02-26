Return-Path: <linux-kernel+bounces-533155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC3EA45637
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426B216D5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1552626A1B4;
	Wed, 26 Feb 2025 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5I+NL2q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966026B081
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553349; cv=none; b=Olpp+FDcNRBwUcd0MbNcEypIOcDu04Hn1fAHLD9u8TDffxRDiRjVFqZ3yWrxmLT4JYHOIrnSnaUxe9acKsTcKkI4kT8C0ZOckv8MQuX2sZbqLZigHkFbKhX9ww+zKeZOhZj9EcLiiqsx84LXnh1bPTh1E7ExxmX+YZ0PkobrydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553349; c=relaxed/simple;
	bh=0VZeYEpJjKG8FlVeb0KmC6SydJWiUpks+bNWEbO1nJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRBrwfx3TLBm1vwDgnAXFJ2n9brYjGouQemxh7qvFdrDcXqQG7Kn0rL1tkiAQg08oB5dR4Wko5aP8WNSCZ2dxfXOSB6oyQM6RgMfTwJOSczZsafYKMCuOT4ZfWw3fO7iqxtsAOkag1aksjq31FOdqMAw1FYbPYo1G2Q/cDFcC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5I+NL2q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740553346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKADj1i1CKixbzKQ+5t4bMYvjX5EhAdJrdn+jLO0xj8=;
	b=J5I+NL2qYkXwJ22BgKaaCg9wYGigjyVPynW4I9/kUoOdnwuEY7UpjCgTMp6bZZOGVo/7fM
	2TOI0yfPeoRylVZrf5kqDFZdXW25WtjyZntokZhk96IkjDHzdU5JpS4ucuC7VXhUYMtaiU
	WYCQP/ZCl0FlFEOL9cNHz1BqE9Dw3yQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-orOD1LYBO0aDZM69mMIk6Q-1; Wed,
 26 Feb 2025 02:02:24 -0500
X-MC-Unique: orOD1LYBO0aDZM69mMIk6Q-1
X-Mimecast-MFC-AGG-ID: orOD1LYBO0aDZM69mMIk6Q_1740553342
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A99E19783BD;
	Wed, 26 Feb 2025 07:02:22 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.200])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B5D119560AB;
	Wed, 26 Feb 2025 07:02:17 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-mm@kvack.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v10 2/3] sched: Move task_mm_cid_work to mm work_struct
Date: Wed, 26 Feb 2025 08:01:59 +0100
Message-ID: <20250226070202.95062-3-gmonaco@redhat.com>
In-Reply-To: <20250226070202.95062-1-gmonaco@redhat.com>
References: <20250226070202.95062-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Currently, the task_mm_cid_work function is called in a task work
triggered by a scheduler tick to frequently compact the mm_cids of each
process. This can delay the execution of the corresponding thread for
the entire duration of the function, negatively affecting the response
in case of real time tasks. In practice, we observe task_mm_cid_work
increasing the latency of 30-35us on a 128 cores system, this order of
magnitude is meaningful under PREEMPT_RT.

Run the task_mm_cid_work in a new work_struct connected to the
mm_struct rather than in the task context before returning to
userspace.

This work_struct is initialised with the mm and disabled before freeing
it. The queuing of the work happens while returning to userspace in
__rseq_handle_notify_resume, maintaining the checks to avoid running
more frequently than MM_CID_SCAN_DELAY.
To make sure this happens predictably also on long running tasks, we
trigger a call to __rseq_handle_notify_resume also from the scheduler
tick if the runtime exceeded a 100ms threshold.

The main advantage of this change is that the function can be offloaded
to a different CPU and even preempted by RT tasks.

Moreover, this new behaviour is more predictable with periodic tasks
with short runtime, which may rarely run during a scheduler tick.
Now, the work is always scheduled when the task returns to userspace.

The work is disabled during mmdrop, since the function cannot sleep in
all kernel configurations, we cannot wait for possibly running work
items to terminate. We make sure the mm is valid in case the task is
terminating by reserving it with mmgrab/mmdrop, returning prematurely if
we are really the last user while the work gets to run.
This situation is unlikely since we don't schedule the work for exiting
tasks, but we cannot rule it out.

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/mm_types.h |  8 +++++++
 include/linux/rseq.h     |  2 ++
 include/linux/sched.h    |  7 +++++-
 kernel/rseq.c            |  3 +++
 kernel/sched/core.c      | 47 +++++++++++++++-------------------------
 kernel/sched/sched.h     |  2 --
 6 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0234f14f2aa6b..e748cf51e0c32 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -889,6 +889,10 @@ struct mm_struct {
 		 * mm nr_cpus_allowed updates.
 		 */
 		raw_spinlock_t cpus_allowed_lock;
+		/*
+		 * @cid_work: Work item to run the mm_cid scan.
+		 */
+		struct work_struct cid_work;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -1185,6 +1189,8 @@ enum mm_cid_state {
 	MM_CID_LAZY_PUT = (1U << 31),
 };
 
+extern void task_mm_cid_work(struct work_struct *work);
+
 static inline bool mm_cid_is_unset(int cid)
 {
 	return cid == MM_CID_UNSET;
@@ -1257,12 +1263,14 @@ static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *
 	if (!mm->pcpu_cid)
 		return -ENOMEM;
 	mm_init_cid(mm, p);
+	INIT_WORK(&mm->cid_work, task_mm_cid_work);
 	return 0;
 }
 #define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
 
 static inline void mm_destroy_cid(struct mm_struct *mm)
 {
+	disable_work(&mm->cid_work);
 	free_percpu(mm->pcpu_cid);
 	mm->pcpu_cid = NULL;
 }
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index bc8af3eb55987..3e708e2e5e459 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -7,6 +7,8 @@
 #include <linux/preempt.h>
 #include <linux/sched.h>
 
+#define RSEQ_UNPREEMPTED_THRESHOLD	(100ULL * 1000000)	/* 100ms */
+
 /*
  * Map the event mask on the user-space ABI enum rseq_cs_flags
  * for direct mask checks.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d6..2fd65f125153d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1397,7 +1397,6 @@ struct task_struct {
 	int				last_mm_cid;	/* Most recent cid in mm */
 	int				migrate_from_cpu;
 	int				mm_cid_active;	/* Whether cid bitmap is active */
-	struct callback_head		cid_work;
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
@@ -2254,4 +2253,10 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
 #define alloc_tag_restore(_tag, _old)		do {} while (0)
 #endif
 
+#ifdef CONFIG_SCHED_MM_CID
+extern void task_queue_mm_cid(struct task_struct *curr);
+#else
+static inline void task_queue_mm_cid(struct task_struct *curr) { }
+#endif
+
 #endif
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 2cb16091ec0ae..c684622b16f03 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -402,6 +402,7 @@ static int rseq_ip_fixup(struct pt_regs *regs)
 void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 {
 	struct task_struct *t = current;
+	unsigned long now = jiffies;
 	int ret, sig;
 
 	if (unlikely(t->flags & PF_EXITING))
@@ -419,6 +420,8 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	}
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
+	if (t->mm && !time_before(now, READ_ONCE(t->mm->mm_cid_next_scan)))
+		task_queue_mm_cid(t);
 	return;
 
 error:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd914ac691..97f0d41c70bc3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5639,7 +5639,7 @@ void sched_tick(void)
 	struct task_struct *donor;
 	struct rq_flags rf;
 	unsigned long hw_pressure;
-	u64 resched_latency;
+	u64 resched_latency, rtime;
 
 	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		arch_scale_freq_tick();
@@ -5648,6 +5648,7 @@ void sched_tick(void)
 
 	rq_lock(rq, &rf);
 	donor = rq->donor;
+	rtime = donor->se.sum_exec_runtime - donor->se.prev_sum_exec_runtime;
 
 	psi_account_irqtime(rq, donor, NULL);
 
@@ -5663,7 +5664,8 @@ void sched_tick(void)
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
-	task_tick_mm_cid(rq, donor);
+	if (rtime > RSEQ_UNPREEMPTED_THRESHOLD)
+		rseq_preempt(donor);
 	scx_tick(rq);
 
 	rq_unlock(rq, &rf);
@@ -10530,22 +10532,16 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
 	sched_mm_cid_remote_clear(mm, pcpu_cid, cpu);
 }
 
-static void task_mm_cid_work(struct callback_head *work)
+void task_mm_cid_work(struct work_struct *work)
 {
 	unsigned long now = jiffies, old_scan, next_scan;
-	struct task_struct *t = current;
 	struct cpumask *cidmask;
-	struct mm_struct *mm;
+	struct mm_struct *mm = container_of(work, struct mm_struct, cid_work);
 	int weight, cpu;
 
-	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
-
-	work->next = work;	/* Prevent double-add */
-	if (t->flags & PF_EXITING)
-		return;
-	mm = t->mm;
-	if (!mm)
-		return;
+	/* We are the last user, process already terminated. */
+	if (atomic_read(&mm->mm_count) == 1)
+		goto out_drop;
 	old_scan = READ_ONCE(mm->mm_cid_next_scan);
 	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	if (!old_scan) {
@@ -10558,9 +10554,9 @@ static void task_mm_cid_work(struct callback_head *work)
 			old_scan = next_scan;
 	}
 	if (time_before(now, old_scan))
-		return;
+		goto out_drop;
 	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
-		return;
+		goto out_drop;
 	cidmask = mm_cidmask(mm);
 	/* Clear cids that were not recently used. */
 	for_each_possible_cpu(cpu)
@@ -10572,6 +10568,8 @@ static void task_mm_cid_work(struct callback_head *work)
 	 */
 	for_each_possible_cpu(cpu)
 		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
+out_drop:
+	mmdrop(mm);
 }
 
 void init_sched_mm_cid(struct task_struct *t)
@@ -10584,23 +10582,14 @@ void init_sched_mm_cid(struct task_struct *t)
 		if (mm_users == 1)
 			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	}
-	t->cid_work.next = &t->cid_work;	/* Protect against double add */
-	init_task_work(&t->cid_work, task_mm_cid_work);
 }
 
-void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
+/* Call only when curr is a user thread. */
+void task_queue_mm_cid(struct task_struct *curr)
 {
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
-	task_work_add(curr, work, TWA_RESUME);
+	/* Ensure the mm exists when we run. */
+	mmgrab(curr->mm);
+	queue_work(system_unbound_wq, &curr->mm->cid_work);
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8512a9fb0229..37a2e2328283e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3630,7 +3630,6 @@ extern int use_cid_lock;
 
 extern void sched_mm_cid_migrate_from(struct task_struct *t);
 extern void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t);
-extern void task_tick_mm_cid(struct rq *rq, struct task_struct *curr);
 extern void init_sched_mm_cid(struct task_struct *t);
 
 static inline void __mm_cid_put(struct mm_struct *mm, int cid)
@@ -3899,7 +3898,6 @@ static inline void switch_mm_cid(struct rq *rq,
 static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
 static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
 static inline void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t) { }
-static inline void task_tick_mm_cid(struct rq *rq, struct task_struct *curr) { }
 static inline void init_sched_mm_cid(struct task_struct *t) { }
 #endif /* !CONFIG_SCHED_MM_CID */
 
-- 
2.48.1


