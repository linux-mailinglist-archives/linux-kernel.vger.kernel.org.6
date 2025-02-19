Return-Path: <linux-kernel+bounces-521413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA44DA3BCDA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C16D3AD4F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6C1D86D6;
	Wed, 19 Feb 2025 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYvNzPme"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6F1DF73A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964687; cv=none; b=jJTSnfOk53HF4C56gnbhLe9CUG6bMV4LP/gtcJchuX3Mgagf7qLku9TvB3uelKC/5fggihx7Mpxo/naAzd7ruAvAWopEjid2wqPG1kesrGeW26tLb9fW0wc195jKnrcse7Y58VX+cc3QPhrRhiIAwQU7ytPtoAzKmvwk8w1e/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964687; c=relaxed/simple;
	bh=PxL1eYWpV8IJXdLu03NOXUPUCzSW3MvtSv3AVss/r3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCBB4JFxdVmMV0Gg510YYM1U/za7sztYHwUXOeAX9aHKL+s88RMYnOBjKrBDaeW+9uzb1UDWgzS33IT0IRGpEtrrUAPNUKM8QpZBO1lT71f8vwIU2mvdyzmyUJKH3Ev4zUGS31g5bhmWIHiZZ5bKxTteDaPFUKoqrImxr20CX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYvNzPme; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739964684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zM9gPlVGTUKv+OgzGI1YuB9XSe4IT1VlOATyZWpXw8=;
	b=dYvNzPmenIqYcCEgQpo04Mtso3jZWe/+glkdo/0YTi55ATU2cf78+KwdZKb/5kYbntZXPz
	+kWF2VAC7Geq0Y3EUAoCz8eePB3U6goWWGOCmrVafxlsqm5xFgLywnH6m9Cv+eCWJd14Bd
	lP7GwuD7VubeX6m5BoD39Dp68/8iAfI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-2EmhS82hN9uOLSvxysTlxg-1; Wed,
 19 Feb 2025 06:31:21 -0500
X-MC-Unique: 2EmhS82hN9uOLSvxysTlxg-1
X-Mimecast-MFC-AGG-ID: 2EmhS82hN9uOLSvxysTlxg_1739964680
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B53019783BB;
	Wed, 19 Feb 2025 11:31:19 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.226.122])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8870719560A3;
	Wed, 19 Feb 2025 11:31:15 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-mm@kvack.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v7 1/2] sched: Move task_mm_cid_work to mm work_struct
Date: Wed, 19 Feb 2025 12:31:07 +0100
Message-ID: <20250219113108.325545-2-gmonaco@redhat.com>
In-Reply-To: <20250219113108.325545-1-gmonaco@redhat.com>
References: <20250219113108.325545-1-gmonaco@redhat.com>
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

Run the task_mm_cid_work in a new work_struct connected to the
mm_struct rather than in the task context before returning to
userspace.

This work_struct is initialised with the mm and disabled before freeing
it. Its execution is no longer triggered by scheduler ticks: the queuing
of the work happens while returning to userspace in
__rseq_handle_notify_resume, maintaining the checks to avoid running
more frequently than MM_CID_SCAN_DELAY.

The main advantage of this change is that the function can be offloaded
to a different CPU and even preempted by RT tasks.

Moreover, this new behaviour is more predictable with periodic tasks
with short runtime, which may rarely run during a scheduler tick.
Now, the work is always scheduled when the task returns to userspace.

The work is disabled during mmdrop, since the function cannot sleep in
all kernel configurations, we cannot wait for possibly running work
items to terminate. We make sure the mm is valid in case the task is
terminating by reserving it with mmgrab/mmdrop, returning prematurely if
we are really the last user before mmgrab.
This situation is unlikely since we don't schedule the work for exiting
tasks, but we cannot rule it out.

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/mm_types.h |  8 ++++++++
 include/linux/sched.h    |  7 ++++++-
 kernel/rseq.c            |  1 +
 kernel/sched/core.c      | 33 ++++++++++++---------------------
 kernel/sched/sched.h     |  2 --
 5 files changed, 27 insertions(+), 24 deletions(-)

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
index 442aba29bc4cf..f8394ebbb6f4d 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -419,6 +419,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	}
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
+	task_queue_mm_cid(t);
 	return;
 
 error:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd914ac691..ee35f9962444b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5663,7 +5663,6 @@ void sched_tick(void)
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
-	task_tick_mm_cid(rq, donor);
 	scx_tick(rq);
 
 	rq_unlock(rq, &rf);
@@ -10530,22 +10529,16 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
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
+	if (!atomic_read(&mm->mm_count))
 		return;
+	mmgrab(mm);
 	old_scan = READ_ONCE(mm->mm_cid_next_scan);
 	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	if (!old_scan) {
@@ -10558,9 +10551,9 @@ static void task_mm_cid_work(struct callback_head *work)
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
@@ -10572,6 +10565,8 @@ static void task_mm_cid_work(struct callback_head *work)
 	 */
 	for_each_possible_cpu(cpu)
 		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
+out_drop:
+	mmdrop(mm);
 }
 
 void init_sched_mm_cid(struct task_struct *t)
@@ -10584,23 +10579,19 @@ void init_sched_mm_cid(struct task_struct *t)
 		if (mm_users == 1)
 			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	}
-	t->cid_work.next = &t->cid_work;	/* Protect against double add */
-	init_task_work(&t->cid_work, task_mm_cid_work);
 }
 
-void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
+void task_queue_mm_cid(struct task_struct *curr)
 {
-	struct callback_head *work = &curr->cid_work;
+	struct work_struct *work = &curr->mm->cid_work;
 	unsigned long now = jiffies;
 
-	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
-	    work->next != work)
+	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)))
 		return;
 	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
 		return;
 
-	/* No page allocation under rq lock */
-	task_work_add(curr, work, TWA_RESUME);
+	schedule_work(work);
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


