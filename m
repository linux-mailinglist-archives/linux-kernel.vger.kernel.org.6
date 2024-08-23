Return-Path: <linux-kernel+bounces-299513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A9895D5AF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FA61C2119B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93486192B86;
	Fri, 23 Aug 2024 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KsoJeWSM"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454D72D7B8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439650; cv=none; b=kZ9tY88QEWugyJhhG0zsjzwJvtz4mGKwb9RVvFrVQSIAoIgD3cadHMSq4UFb4z82VLmJ8e04MVMZ9mVj8HtbJVLrfHHmmkUMWtLMjc9TBv7JijsgqRIfJZ5IocAqw69Ud3VeyMZeSW5PuspbYi5bbvoJCfq7RAYA/6a6xjvaUKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439650; c=relaxed/simple;
	bh=AIhRzOLvS4U65/4cPzOeZ2udR7+Z/2R+ED2RYBBkDwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OdM8TV9SlagFGNCsnV34RluzZIZwIXX2wkA6RLoifEVs7CmtjSQsEp07/VtKp2N7HakqlRzz4khiNCoP1bYRggBl2Ao4ssU58HF4DJQypOYK9uO60ix2fxytZPsBPYihWg4kBGVVOfmTGhPte0exKuOY17/VGvSOV3VzzfwUMKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=KsoJeWSM; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724439622;
	bh=AIhRzOLvS4U65/4cPzOeZ2udR7+Z/2R+ED2RYBBkDwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KsoJeWSMSSgeAYtM0WVPLXm267Hj+9DuRO2jBFsrICEQuNzgVL4OhFWtm5wesMCSd
	 zPI/8Cm8MWifm6SfBljKHq1dgNHQn8J1rPJhRRSd2rQnCljPEi3l97E2csyyuvbkSY
	 aXD6xwc5Oy1edLf6rjpG3/AGr6sqyfvoQ241qSySCttd3O43S2WY/SRHsbUvwbw3x9
	 iYIWm3FYtMdYClN9hF6/nroaJx6/ppjxTMlpSH9ZKu/j7gUY5KDceDttn4gXy+1VaZ
	 vIJ3M5OOy6IohTrtdFXkN9GQDVamhekGAiSUgo4EUVUnout3v37zNqfbaRr8tJDpze
	 sKRDA1mgB1rAA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:b243:804e:3bbd:91c9])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wr8XQ1zCGz1J04;
	Fri, 23 Aug 2024 15:00:22 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [RFC PATCH v1 4/6] sched: NUMA-aware per-memory-map concurrency IDs
Date: Fri, 23 Aug 2024 14:59:44 -0400
Message-Id: <20240823185946.418340-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
References: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue addressed by this change is the non-locality of NUMA accesses
to data structures indexed by concurrency IDs: for example, in a
scenario where a process has two threads, and they periodically run one
after the other on different NUMA nodes, each will be assigned mm_cid=0.
As a consequence, they will end up accessing the same pages, and thus at
least one of the threads will need to perform remote NUMA accesses,
which is inefficient.

That being said, the same issue theoretically exists due to false
sharing of cache lines by threads running on after another on different
cores/CPUs within a single NUMA node, but the extent of the performance
impact is lesser than remote NUMA accesses.

Solve this by making the rseq concurrency ID (mm_cid) NUMA-aware. On
NUMA systems, when a NUMA-aware concurrency ID is observed by user-space
to be associated with a NUMA node, guarantee that it never changes NUMA
node unless either a kernel-level NUMA configuration change happens, or
scheduler migrations end up migrating tasks across NUMA nodes.

There is a tradeoff between NUMA locality and compactness of the
concurrency ID allocation. Favor compactness over NUMA locality when
the scheduler migrates tasks across NUMA nodes, as this does not cause
the frequent remote NUMA accesses behavior. This is done by limiting the
concurrency ID range to minimum between the number of threads belonging
to the process and the number of allowed CPUs.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
---
Changes since v0:
- Rename "notandnot" to "nor".
---
 include/linux/mm_types.h |  57 +++++++++++++++-
 kernel/sched/core.c      |  10 ++-
 kernel/sched/sched.h     | 139 +++++++++++++++++++++++++++++++++++----
 3 files changed, 190 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index af3a0256fa93..4307352c8900 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
+#include <linux/nodemask.h>
 
 #include <asm/mmu.h>
 
@@ -1154,6 +1155,59 @@ static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
 	return (struct cpumask *)cid_bitmap;
 }
 
+#ifdef CONFIG_NUMA
+/*
+ * Layout of NUMA cidmasks:
+ * - node_alloc cidmask:        cpumask tracking which cids were
+ *                              allocated (across nodes) in this
+ *                              memory map.
+ * - node cidmask[nr_node_ids]: per-node cpumask tracking which cid
+ *                              were allocated in this memory map.
+ */
+static inline cpumask_t *mm_node_alloc_cidmask(struct mm_struct *mm)
+{
+	unsigned long cid_bitmap = (unsigned long)mm_cidmask(mm);
+
+	/* Skip mm_cidmask */
+	cid_bitmap += cpumask_size();
+	return (struct cpumask *)cid_bitmap;
+}
+
+static inline cpumask_t *mm_node_cidmask(struct mm_struct *mm, unsigned int node)
+{
+	unsigned long cid_bitmap = (unsigned long)mm_node_alloc_cidmask(mm);
+
+	/* Skip node alloc cidmask */
+	cid_bitmap += cpumask_size();
+	cid_bitmap += node * cpumask_size();
+	return (struct cpumask *)cid_bitmap;
+}
+
+static inline void mm_init_node_cidmask(struct mm_struct *mm)
+{
+	unsigned int node;
+
+	if (num_possible_nodes() == 1)
+		return;
+	cpumask_clear(mm_node_alloc_cidmask(mm));
+	for (node = 0; node < nr_node_ids; node++)
+		cpumask_clear(mm_node_cidmask(mm, node));
+}
+
+static inline unsigned int mm_node_cidmask_size(void)
+{
+	if (num_possible_nodes() == 1)
+		return 0;
+	return (nr_node_ids + 1) * cpumask_size();
+}
+#else /* CONFIG_NUMA */
+static inline void mm_init_node_cidmask(struct mm_struct *mm) { }
+static inline unsigned int mm_node_cidmask_size(void)
+{
+	return 0;
+}
+#endif /* CONFIG_NUMA */
+
 static inline void mm_init_cid(struct mm_struct *mm)
 {
 	int i;
@@ -1165,6 +1219,7 @@ static inline void mm_init_cid(struct mm_struct *mm)
 		pcpu_cid->time = 0;
 	}
 	cpumask_clear(mm_cidmask(mm));
+	mm_init_node_cidmask(mm);
 }
 
 static inline int mm_alloc_cid_noprof(struct mm_struct *mm)
@@ -1185,7 +1240,7 @@ static inline void mm_destroy_cid(struct mm_struct *mm)
 
 static inline unsigned int mm_cid_size(void)
 {
-	return cpumask_size();
+	return cpumask_size() + mm_node_cidmask_size();
 }
 #else /* CONFIG_SCHED_MM_CID */
 static inline void mm_init_cid(struct mm_struct *mm) { }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e84a3b7b7bb..26f53bd66de6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11818,9 +11818,13 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
 	 * scenarios.
 	 *
 	 * It is not useful to clear the src cid when the number of threads is
-	 * greater or equal to the number of allowed cpus, because user-space
+	 * greater or equal to the number of CPUs allowed, because user-space
 	 * can expect that the number of allowed cids can reach the number of
-	 * allowed cpus.
+	 * CPUs allowed.
+	 *
+	 * This also prevents moving cid across NUMA nodes when the
+	 * number of threads is greater or equal to the number of
+	 * CPUs allowed.
 	 */
 	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
 	dst_cid = READ_ONCE(dst_pcpu_cid->cid);
@@ -12079,7 +12083,7 @@ void sched_mm_cid_after_execve(struct task_struct *t)
 		 * Matches barrier in sched_mm_cid_remote_clear_old().
 		 */
 		smp_mb();
-		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
+		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, t, mm);
 	}
 	rseq_set_notify_resume(t);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 38aeedd8a6cc..5422e0df155f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -68,6 +68,7 @@
 #include <linux/wait_api.h>
 #include <linux/wait_bit.h>
 #include <linux/workqueue_api.h>
+#include <linux/nodemask.h>
 
 #include <trace/events/power.h>
 #include <trace/events/sched.h>
@@ -3311,12 +3312,10 @@ static inline void mm_cid_put(struct mm_struct *mm)
 	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
 }
 
-static inline int __mm_cid_try_get(struct mm_struct *mm)
+static inline int __mm_cid_test_and_set_first(struct cpumask *cpumask)
 {
-	struct cpumask *cpumask;
 	int cid;
 
-	cpumask = mm_cidmask(mm);
 	/*
 	 * Retry finding first zero bit if the mask is temporarily
 	 * filled. This only happens during concurrent remote-clear
@@ -3333,9 +3332,123 @@ static inline int __mm_cid_try_get(struct mm_struct *mm)
 	return cid;
 }
 
+#ifdef CONFIG_NUMA
+/*
+ * NUMA locality is preserved as long as the mm_cid range is restricted
+ * to the minimum between the number of CPUs allowed and the number of
+ * threads with references to the mm_struct.
+ */
+static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
+{
+	struct cpumask *cpumask = mm_cidmask(mm),
+		      *node_cpumask = mm_node_cidmask(mm, numa_node_id()),
+		      *node_alloc_cpumask = mm_node_alloc_cidmask(mm);
+	unsigned int node;
+	int cid;
+
+	if (num_possible_nodes() == 1)
+		return __mm_cid_test_and_set_first(cpumask);
+
+	/*
+	 * Try to reserve lowest available cid number within those
+	 * already reserved for this NUMA node.
+	 */
+	cid = cpumask_first_andnot(node_cpumask, cpumask);
+	if (cid >= t->nr_cpus_allowed || cid >= atomic_read(&mm->mm_users))
+		goto alloc_numa;
+	if (cpumask_test_and_set_cpu(cid, cpumask))
+		return -1;
+	goto end;
+
+alloc_numa:
+	/*
+	 * Try to reserve lowest available cid number within those not
+	 * already allocated for NUMA nodes.
+	 */
+	cid = cpumask_first_nor(node_alloc_cpumask, cpumask);
+	if (cid >= t->nr_cpus_allowed)
+		goto steal_overprovisioned_cid;
+	if (cid >= atomic_read(&mm->mm_users))
+		goto steal_first_available_cid;
+	if (cpumask_test_and_set_cpu(cid, cpumask))
+		return -1;
+	__cpumask_set_cpu(cid, node_cpumask);
+	__cpumask_set_cpu(cid, node_alloc_cpumask);
+	goto end;
+
+steal_overprovisioned_cid:
+	/*
+	 * Either the NUMA node id configuration changed for at least
+	 * one CPU in the system, or the scheduler migrated threads
+	 * across NUMA nodes, or the CPUs allowed mask changed. We need
+	 * to steal a currently unused cid. Userspace must handle the
+	 * fact that the node id associated with this cid may change.
+	 *
+	 * Try to steal an available cid number from an overprovisioned
+	 * NUMA node. A NUMA node is overprovisioned when more cids are
+	 * associated to it than the number of cores associated with
+	 * this NUMA node in the CPUs allowed mask. Stealing from
+	 * overprovisioned NUMA nodes ensures cid movement across NUMA
+	 * nodes stabilises after a configuration or CPUs allowed mask
+	 * change.
+	 */
+	for (node = 0; node < nr_node_ids; node++) {
+		struct cpumask *iter_cpumask;
+		int nr_allowed_cores;
+
+		if (node == numa_node_id())
+			continue;
+		iter_cpumask = mm_node_cidmask(mm, node);
+		nr_allowed_cores = cpumask_weight_and(cpumask_of_node(node), t->cpus_ptr);
+		if (cpumask_weight(iter_cpumask) <= nr_allowed_cores)
+			continue;
+		/* Try to steal from an overprovisioned NUMA node. */
+		cid = cpumask_first_andnot(iter_cpumask, cpumask);
+		if (cid >= t->nr_cpus_allowed || cid >= atomic_read(&mm->mm_users))
+			goto steal_first_available_cid;
+		if (cpumask_test_and_set_cpu(cid, cpumask))
+			return -1;
+		__cpumask_clear_cpu(cid, iter_cpumask);
+		__cpumask_set_cpu(cid, node_cpumask);
+		goto end;
+	}
+
+steal_first_available_cid:
+	/*
+	 * Steal the first available cid, without caring about NUMA
+	 * locality. This is needed when the scheduler migrates threads
+	 * across NUMA nodes, when those threads belong to processes
+	 * which have fewer threads than the number of CPUs allowed.
+	 */
+	cid = __mm_cid_test_and_set_first(cpumask);
+	if (cid < 0)
+		return -1;
+	/* Steal cid from its NUMA node mask. */
+	for (node = 0; node < nr_node_ids; node++) {
+		struct cpumask *iter_cpumask;
+
+		if (node == numa_node_id())
+			continue;
+		iter_cpumask = mm_node_cidmask(mm, node);
+		if (cpumask_test_cpu(cid, iter_cpumask)) {
+			__cpumask_clear_cpu(cid, iter_cpumask);
+			break;
+		}
+	}
+	__cpumask_set_cpu(cid, node_cpumask);
+end:
+	return cid;
+}
+#else
+static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
+{
+	return __mm_cid_test_and_set_first(mm_cidmask(mm));
+}
+#endif
+
 /*
- * Save a snapshot of the current runqueue time of this cpu
- * with the per-cpu cid value, allowing to estimate how recently it was used.
+ * Save a snapshot of the current runqueue time of this CPU
+ * with the per-CPU cid value, allowing to estimate how recently it was used.
  */
 static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
 {
@@ -3345,7 +3458,8 @@ static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
 	WRITE_ONCE(pcpu_cid->time, rq->clock);
 }
 
-static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
+static inline int __mm_cid_get(struct rq *rq, struct task_struct *t,
+			       struct mm_struct *mm)
 {
 	int cid;
 
@@ -3355,13 +3469,13 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
 	 * guarantee forward progress.
 	 */
 	if (!READ_ONCE(use_cid_lock)) {
-		cid = __mm_cid_try_get(mm);
+		cid = __mm_cid_try_get(t, mm);
 		if (cid >= 0)
 			goto end;
 		raw_spin_lock(&cid_lock);
 	} else {
 		raw_spin_lock(&cid_lock);
-		cid = __mm_cid_try_get(mm);
+		cid = __mm_cid_try_get(t, mm);
 		if (cid >= 0)
 			goto unlock;
 	}
@@ -3381,7 +3495,7 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
 	 * all newcoming allocations observe the use_cid_lock flag set.
 	 */
 	do {
-		cid = __mm_cid_try_get(mm);
+		cid = __mm_cid_try_get(t, mm);
 		cpu_relax();
 	} while (cid < 0);
 	/*
@@ -3397,7 +3511,8 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
 	return cid;
 }
 
-static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
+static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
+			     struct mm_struct *mm)
 {
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
 	struct cpumask *cpumask;
@@ -3414,7 +3529,7 @@ static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
 		if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
 			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
 	}
-	cid = __mm_cid_get(rq, mm);
+	cid = __mm_cid_get(rq, t, mm);
 	__this_cpu_write(pcpu_cid->cid, cid);
 	return cid;
 }
@@ -3467,7 +3582,7 @@ static inline void switch_mm_cid(struct rq *rq,
 		prev->mm_cid = -1;
 	}
 	if (next->mm_cid_active)
-		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next->mm);
+		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next, next->mm);
 }
 
 #else
-- 
2.39.2


