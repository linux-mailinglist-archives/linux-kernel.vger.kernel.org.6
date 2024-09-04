Return-Path: <linux-kernel+bounces-314031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E40596ADED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47950284C74
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EFED2FB;
	Wed,  4 Sep 2024 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="e4BY4zd1"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B3567D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413518; cv=none; b=ZF7YAxkagjmNwgJ/Hyh2RAdYiZU4InGaBOj/eN4tJSaxCSB8KkkgUawmwzsIic0IEih8zF83I+AKfrzQhSzbhcGys8dsvcvt1svTWG6lR/8wHNXTUzekPHiI+QHuY11ArlPfqvMAUdmt9aM8LpYOSsdSEFGZD/1+tN/WGjKGiPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413518; c=relaxed/simple;
	bh=E+LqYUJjQXSX7wZrUScyDLjg5Ap8AKJ/btudsh50Cd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTu+pndWpPfAdPCW8mCjJ4qq3cJVWUvRfb57M4/duELeXR56uTZSudIvNhyy5mSz6yBDzTP50q4khTnfvpwtVk76BW3X5ueBipg9cRLffBx+Y9jDeCRqGAsMrr4JKkWiv4GgATyXEhnatuv5UA4jIL6SrOk0PsBXomPEIqwXwpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=e4BY4zd1; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725413514;
	bh=E+LqYUJjQXSX7wZrUScyDLjg5Ap8AKJ/btudsh50Cd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e4BY4zd1iSzYX4bzmmQa8olc9q9Rur8/sahybjTiI3JBxP/1hFN2Rbi0FQid6tvlu
	 FjBKHQeL7up9W/r2Zr+RdY/B4vaUZ6y34vh3LJq2xzcR4k98Wxqk7c6HY0/QbEVTHy
	 30KFzJekos28mFHlAquMh9dNiBwUx1gekPjCyBrpEz88rdi1+aQN0sdDv4X/m78o+S
	 NTo0YjBy4p4TdgdPH+nZZkVDx278Uo4Xlu6UF8luJ1tYtgnC+i1lPQVbfOj63VpXct
	 +xkyN35PLaH7kK728Cv0k62eUoN8Nq3dIgrbrDyM5+yh3IRXRUJ3fz9PYQT/PA41xO
	 RZ804IPpA0nyA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wz4j631n6z1K8K;
	Tue,  3 Sep 2024 21:31:54 -0400 (EDT)
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
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>
Subject: [RFC PATCH v1 1/1] sched: Improve cache locality of RSEQ concurrency IDs for intermittent workloads
Date: Tue,  3 Sep 2024 21:31:27 -0400
Message-Id: <20240904013127.75064-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240904013127.75064-1-mathieu.desnoyers@efficios.com>
References: <20240904013127.75064-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")
introduced a per-mm/cpu current concurrency id (mm_cid), which keeps
a reference to the concurrency id allocated for each CPU. This reference
expires shortly after a 100ms delay.

These per-CPU references keep the per-mm-cid data cache-local in
situations where threads are running at least once on each CPU within
each 100ms window, thus keeping the per-cpu reference alive.

However, intermittent workloads behaving in bursts spaced by more than
100ms on each CPU exhibit bad cache locality and degraded performance
compared to purely per-cpu data indexing, because concurrency IDs are
allocated over various CPUs and cores, therefore losing cache locality
of the associated data.

Introduce the following changes to improve per-mm-cid cache locality:

- Add a "recent_cid" field to the per-mm/cpu mm_cid structure to keep
  track of which mm_cid value was last used, and use it as a hint to
  attempt re-allocating the same concurrency ID the next time this
  mm/cpu needs to allocate a concurrency ID,

- Add a per-mm CPUs allowed mask, which keeps track of the union of
  CPUs allowed for all threads belonging to this mm. This cpumask is
  only set during the lifetime of the mm, never cleared, so it
  represents the union of all the CPUs allowed since the beginning of
  the mm lifetime. (note that the mm_cpumask() is really arch-specific
  and tailored to the TLB flush needs, and is thus _not_ a viable
  approach for this)

- Add a per-mm nr_cpus_allowed to keep track of the weight of the
  per-mm CPUs allowed mask (for fast access),

- Add a per-mm nr_cids_used to keep track of the highest concurrency
  ID allocated for the mm. This is used for expanding the concurrency ID
  allocation within the upper bound defined by:

    min(mm->nr_cpus_allowed, mm->mm_users)

  When the next unused CID value reaches this threshold, stop trying
  to expand the cid allocation and use the first available cid value
  instead.

Spreading allocation to use all the cid values within the range

  [ 0, min(mm->nr_cpus_allowed, mm->mm_users) - 1 ]

improves cache locality while preserving mm_cid compactness within the
expected user limits.

- In __mm_cid_try_get, only return cid values within the range
  [ 0, mm->nr_cpus_allowed ] rather than [ 0, nr_cpu_ids ]. This
  prevents allocating cids above the number of allowed cpus in
  rare scenarios where cid allocation races with a concurrent
  remote-clear of the per-mm/cpu cid. This improvement is made
  possible by the addition of the per-mm CPUs allowed mask.

- In sched_mm_cid_migrate_to, use mm->nr_cpus_allowed rather than
  t->nr_cpus_allowed. This criterion was really meant to compare
  the number of mm->mm_users to the number of CPUs allowed for the
  entire mm. Therefore, the prior comparison worked fine when all
  threads shared the same CPUs allowed mask, but not so much in
  scenarios where those threads have different masks (e.g. each
  thread pinned to a single CPU). This improvement is made
  possible by the addition of the per-mm CPUs allowed mask.

* Benchmarks

Each thread increments 16kB worth of 8-bit integers in bursts, with
a configurable delay between each thread's execution. Each thread run
one after the other (no threads run concurrently). The order of
thread execution in the sequence is random. The thread execution
sequence begins again after all threads have executed. The 16kB areas
are allocated with rseq_mempool and indexed by either cpu_id, mm_cid
(not cache-local), or cache-local mm_cid. Each thread is pinned to its
own core.

Testing configurations:

8-core/1-L3:        Use 8 cores within a single L3
24-core/24-L3:      Use 24 cores, 1 core per L3
192-core/24-L3:     Use 192 cores (all cores in the system)
384-thread/24-L3:   Use 384 HW threads (all HW threads in the system)

Intermittent workload delays between threads: 200ms, 10ms.

Hardware:

CPU(s):                   384
  On-line CPU(s) list:    0-383
Vendor ID:                AuthenticAMD
  Model name:             AMD EPYC 9654 96-Core Processor
    Thread(s) per core:   2
    Core(s) per socket:   96
    Socket(s):            2
Caches (sum of all):
  L1d:                    6 MiB (192 instances)
  L1i:                    6 MiB (192 instances)
  L2:                     192 MiB (192 instances)
  L3:                     768 MiB (24 instances)

Each result is an average of 5 test runs. The cache-local speedup
is calculated as: (cache-local mm_cid) / (mm_cid).

Intermittent workload delay: 200ms

                     per-cpu     mm_cid    cache-local mm_cid    cache-local speedup
                         (ns)      (ns)                  (ns)
8-core/1-L3             1374      19289                  1336            14.4x
24-core/24-L3           2423      26721                  1594            16.7x
192-core/24-L3          2291      15826                  2153             7.3x
384-thread/24-L3        1874      13234                  1907             6.9x

Intermittent workload delay: 10ms

                     per-cpu     mm_cid    cache-local mm_cid    cache-local speedup
                         (ns)      (ns)                  (ns)
8-core/1-L3               662       756                   686             1.1x
24-core/24-L3            1378      3648                  1035             3.5x
192-core/24-L3           1439     10833                  1482             7.3x
384-thread/24-L3         1503     10570                  1556             6.8x

[ This deprecates the prior "sched: NUMA-aware per-memory-map concurrency IDs"
  patch series with a simpler and more general approach. ]

Link: https://lore.kernel.org/lkml/20240823185946.418340-1-mathieu.desnoyers@efficios.com/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Changes since v0:
- Use for_each_cpu_andnot.
- Drop "cpumask: Implement cpumask_next_andnot" from the series, which
  is not needed anymore.
- Use the shorter form
    "nr_set += !cpumask_test_and_set_cpu(cpu, mm_allowed);"
  as suggested by Yury Norov.
- Document that ordering between mm_cpus_allowed mask and
  nr_cpus_allowed is unnecessary, because the cid algorithm
  only cares about nr_cpus_allowed.
---
 fs/exec.c                |  2 +-
 include/linux/mm_types.h | 75 +++++++++++++++++++++++++++++++++++-----
 kernel/fork.c            |  2 +-
 kernel/sched/core.c      |  7 ++--
 kernel/sched/sched.h     | 47 +++++++++++++++++--------
 5 files changed, 106 insertions(+), 27 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 0c17e59e3767..7e73b0fc1305 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1039,7 +1039,7 @@ static int exec_mmap(struct mm_struct *mm)
 	active_mm = tsk->active_mm;
 	tsk->active_mm = mm;
 	tsk->mm = mm;
-	mm_init_cid(mm);
+	mm_init_cid(mm, tsk);
 	/*
 	 * This prevents preemption while active_mm is being loaded and
 	 * it and mm are being updated, which could cause problems for
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index af3a0256fa93..dc887dd58b32 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -755,6 +755,7 @@ struct vm_area_struct {
 struct mm_cid {
 	u64 time;
 	int cid;
+	int recent_cid;
 };
 #endif
 
@@ -825,6 +826,20 @@ struct mm_struct {
 		 * When the next mm_cid scan is due (in jiffies).
 		 */
 		unsigned long mm_cid_next_scan;
+		/**
+		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
+		 *
+		 * Number of CPUs allowed in the union of all mm's
+		 * threads allowed CPUs.
+		 */
+		atomic_t nr_cpus_allowed;
+		/**
+		 * @nr_cids_used: Number of used concurrency IDs.
+		 *
+		 * Track the highest concurrency ID allocated for the
+		 * mm: nr_cids_used - 1.
+		 */
+		atomic_t nr_cids_used;
 #endif
 #ifdef CONFIG_MMU
 		atomic_long_t pgtables_bytes;	/* size of all page tables */
@@ -1143,18 +1158,30 @@ static inline int mm_cid_clear_lazy_put(int cid)
 	return cid & ~MM_CID_LAZY_PUT;
 }
 
+/*
+ * mm_cpus_allowed: Union of all mm's threads allowed CPUs.
+ */
+static inline cpumask_t *mm_cpus_allowed(struct mm_struct *mm)
+{
+	unsigned long bitmap = (unsigned long)mm;
+
+	bitmap += offsetof(struct mm_struct, cpu_bitmap);
+	/* Skip cpu_bitmap */
+	bitmap += cpumask_size();
+	return (struct cpumask *)bitmap;
+}
+
 /* Accessor for struct mm_struct's cidmask. */
 static inline cpumask_t *mm_cidmask(struct mm_struct *mm)
 {
-	unsigned long cid_bitmap = (unsigned long)mm;
+	unsigned long cid_bitmap = (unsigned long)mm_cpus_allowed(mm);
 
-	cid_bitmap += offsetof(struct mm_struct, cpu_bitmap);
-	/* Skip cpu_bitmap */
+	/* Skip mm_cpus_allowed */
 	cid_bitmap += cpumask_size();
 	return (struct cpumask *)cid_bitmap;
 }
 
-static inline void mm_init_cid(struct mm_struct *mm)
+static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
 {
 	int i;
 
@@ -1162,17 +1189,21 @@ static inline void mm_init_cid(struct mm_struct *mm)
 		struct mm_cid *pcpu_cid = per_cpu_ptr(mm->pcpu_cid, i);
 
 		pcpu_cid->cid = MM_CID_UNSET;
+		pcpu_cid->recent_cid = MM_CID_UNSET;
 		pcpu_cid->time = 0;
 	}
+	atomic_set(&mm->nr_cpus_allowed, p->nr_cpus_allowed);
+	atomic_set(&mm->nr_cids_used, 0);
+	cpumask_copy(mm_cpus_allowed(mm), p->cpus_ptr);
 	cpumask_clear(mm_cidmask(mm));
 }
 
-static inline int mm_alloc_cid_noprof(struct mm_struct *mm)
+static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *p)
 {
 	mm->pcpu_cid = alloc_percpu_noprof(struct mm_cid);
 	if (!mm->pcpu_cid)
 		return -ENOMEM;
-	mm_init_cid(mm);
+	mm_init_cid(mm, p);
 	return 0;
 }
 #define mm_alloc_cid(...)	alloc_hooks(mm_alloc_cid_noprof(__VA_ARGS__))
@@ -1185,16 +1216,42 @@ static inline void mm_destroy_cid(struct mm_struct *mm)
 
 static inline unsigned int mm_cid_size(void)
 {
-	return cpumask_size();
+	return 2 * cpumask_size();	/* mm_cpus_allowed(), mm_cidmask(). */
+}
+
+static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask)
+{
+	struct cpumask *mm_allowed = mm_cpus_allowed(mm);
+	int cpu, nr_set = 0;
+
+	if (!mm)
+		return;
+	/*
+	 * The mm_cpus_allowed is the union of each thread allowed CPUs masks.
+	 *
+	 * The mm CPUs allowed masks tracks the allowed set. Based on
+	 * the result of the cpumask_test_and_set_cpu, accumulate the
+	 * number of bits set and atomically add the total to
+	 * nr_cpus_allowed. The mm_cid algorithms only care about mm
+	 * nr_cpus_allowed. Those don't even need to load from the mm
+	 * CPUs allowed mask, therefore there is no need to provide any
+	 * ordering guarantees between mm_cpus_allowed and
+	 * nr_allowed_cpus stores.
+	 */
+	for_each_cpu_andnot(cpu, cpumask, mm_allowed)
+		nr_set += !cpumask_test_and_set_cpu(cpu, mm_allowed);
+	atomic_add(nr_set, &mm->nr_cpus_allowed);
 }
 #else /* CONFIG_SCHED_MM_CID */
-static inline void mm_init_cid(struct mm_struct *mm) { }
-static inline int mm_alloc_cid(struct mm_struct *mm) { return 0; }
+static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p) { }
+static inline int mm_alloc_cid(struct mm_struct *mm, struct task_struct *p) { return 0; }
 static inline void mm_destroy_cid(struct mm_struct *mm) { }
+
 static inline unsigned int mm_cid_size(void)
 {
 	return 0;
 }
+static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask) { }
 #endif /* CONFIG_SCHED_MM_CID */
 
 struct mmu_gather;
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..b44f545ad82c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1298,7 +1298,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
-	if (mm_alloc_cid(mm))
+	if (mm_alloc_cid(mm, p))
 		goto fail_cid;
 
 	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e84a3b7b7bb..3243e9abfefb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2784,6 +2784,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		put_prev_task(rq, p);
 
 	p->sched_class->set_cpus_allowed(p, ctx);
+	mm_set_cpus_allowed(p->mm, ctx->new_mask);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -11784,6 +11785,7 @@ int __sched_mm_cid_migrate_from_try_steal_cid(struct rq *src_rq,
 	 */
 	if (!try_cmpxchg(&src_pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
 		return -1;
+	WRITE_ONCE(src_pcpu_cid->recent_cid, MM_CID_UNSET);
 	return src_cid;
 }
 
@@ -11825,7 +11827,7 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
 	dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
 	dst_cid = READ_ONCE(dst_pcpu_cid->cid);
 	if (!mm_cid_is_unset(dst_cid) &&
-	    atomic_read(&mm->mm_users) >= t->nr_cpus_allowed)
+	    atomic_read(&mm->mm_users) >= atomic_read(&mm->nr_cpus_allowed))
 		return;
 	src_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, src_cpu);
 	src_rq = cpu_rq(src_cpu);
@@ -11843,6 +11845,7 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
 	/* Move src_cid to dst cpu. */
 	mm_cid_snapshot_time(dst_rq, mm);
 	WRITE_ONCE(dst_pcpu_cid->cid, src_cid);
+	WRITE_ONCE(dst_pcpu_cid->recent_cid, src_cid);
 }
 
 static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *pcpu_cid,
@@ -12079,7 +12082,7 @@ void sched_mm_cid_after_execve(struct task_struct *t)
 		 * Matches barrier in sched_mm_cid_remote_clear_old().
 		 */
 		smp_mb();
-		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
+		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, t, mm);
 	}
 	rseq_set_notify_resume(t);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 38aeedd8a6cc..4d11dbd5847b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3311,24 +3311,40 @@ static inline void mm_cid_put(struct mm_struct *mm)
 	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
 }
 
-static inline int __mm_cid_try_get(struct mm_struct *mm)
+static inline int __mm_cid_try_get(struct task_struct *t, struct mm_struct *mm)
 {
-	struct cpumask *cpumask;
-	int cid;
+	struct cpumask *cidmask = mm_cidmask(mm);
+	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
+	int cid = __this_cpu_read(pcpu_cid->recent_cid);
 
-	cpumask = mm_cidmask(mm);
+	/* Try to re-use recent cid. This improves cache locality. */
+	if (!mm_cid_is_unset(cid) && !cpumask_test_and_set_cpu(cid, cidmask))
+		return cid;
+	/*
+	 * Expand cid allocation if used cids are below the number cpus
+	 * allowed and number of threads. Expanding cid allocation as
+	 * much as possible improves cache locality.
+	 */
+	cid = atomic_read(&mm->nr_cids_used);
+	while (cid < atomic_read(&mm->nr_cpus_allowed) && cid < atomic_read(&mm->mm_users)) {
+		if (!atomic_try_cmpxchg(&mm->nr_cids_used, &cid, cid + 1))
+			continue;
+		if (!cpumask_test_and_set_cpu(cid, cidmask))
+			return cid;
+	}
 	/*
+	 * Find the first available concurrency id.
 	 * Retry finding first zero bit if the mask is temporarily
 	 * filled. This only happens during concurrent remote-clear
 	 * which owns a cid without holding a rq lock.
 	 */
 	for (;;) {
-		cid = cpumask_first_zero(cpumask);
-		if (cid < nr_cpu_ids)
+		cid = cpumask_first_zero(cidmask);
+		if (cid < atomic_read(&mm->nr_cpus_allowed))
 			break;
 		cpu_relax();
 	}
-	if (cpumask_test_and_set_cpu(cid, cpumask))
+	if (cpumask_test_and_set_cpu(cid, cidmask))
 		return -1;
 	return cid;
 }
@@ -3345,7 +3361,8 @@ static inline void mm_cid_snapshot_time(struct rq *rq, struct mm_struct *mm)
 	WRITE_ONCE(pcpu_cid->time, rq->clock);
 }
 
-static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
+static inline int __mm_cid_get(struct rq *rq, struct task_struct *t,
+			       struct mm_struct *mm)
 {
 	int cid;
 
@@ -3355,13 +3372,13 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
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
@@ -3381,7 +3398,7 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
 	 * all newcoming allocations observe the use_cid_lock flag set.
 	 */
 	do {
-		cid = __mm_cid_try_get(mm);
+		cid = __mm_cid_try_get(t, mm);
 		cpu_relax();
 	} while (cid < 0);
 	/*
@@ -3397,7 +3414,8 @@ static inline int __mm_cid_get(struct rq *rq, struct mm_struct *mm)
 	return cid;
 }
 
-static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
+static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
+			     struct mm_struct *mm)
 {
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
 	struct cpumask *cpumask;
@@ -3414,8 +3432,9 @@ static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
 		if (try_cmpxchg(&this_cpu_ptr(pcpu_cid)->cid, &cid, MM_CID_UNSET))
 			__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
 	}
-	cid = __mm_cid_get(rq, mm);
+	cid = __mm_cid_get(rq, t, mm);
 	__this_cpu_write(pcpu_cid->cid, cid);
+	__this_cpu_write(pcpu_cid->recent_cid, cid);
 	return cid;
 }
 
@@ -3467,7 +3486,7 @@ static inline void switch_mm_cid(struct rq *rq,
 		prev->mm_cid = -1;
 	}
 	if (next->mm_cid_active)
-		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next->mm);
+		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next, next->mm);
 }
 
 #else
-- 
2.39.2


