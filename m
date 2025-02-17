Return-Path: <linux-kernel+bounces-510025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B07A3175C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EBF16A4F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5155D269D17;
	Tue, 11 Feb 2025 21:08:41 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4712265CD1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308120; cv=none; b=VplueRA9sIYcgdzAE/u5be9vnC12uvr30gBFqUHzT5j4M7gRMNHxisZLCJtAnFImydJ77txKv9dFLHjrvR1mTBkbFp3sIYvyPQ5Uw2pIPfQDM0KmNnrGJCzY/vO1Q94uTkLElqEBdzYvx25syB6bzSkV0xSZIZeIwZDFQyXYGzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308120; c=relaxed/simple;
	bh=bq0jIyN70oPK90YI7PYJbIX9nOP2bqEvUrwKoINK7UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnSTFGel6BqZFXx+w0zx2/8TBpyUq73grE6LQjB3A9VBPc17dx4IqyJYyNuKmIWJI+9NL8Hda/rcWi1rTj4+BiCqUFGayICQBNXXTCfdkkY6Zlpx5SaWhk2jWhnh3GzJbItTGps9fvZ0wLlgFLQL7MT2t59Y1Bb4Ddc7v6Xv7bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1thxUX-000000008HU-3Gkh;
	Tue, 11 Feb 2025 16:08:25 -0500
From: Rik van Riel <riel@surriel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	jackmanb@google.com,
	jannh@google.com,
	mhklinux@outlook.com,
	andrew.cooper3@citrix.com,
	Rik van Riel <riel@surriel.com>,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: [PATCH v10 09/12] x86/mm: enable broadcast TLB invalidation for multi-threaded processes
Date: Tue, 11 Feb 2025 16:08:04 -0500
Message-ID: <20250211210823.242681-10-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250211210823.242681-1-riel@surriel.com>
References: <20250211210823.242681-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Use broadcast TLB invalidation, using the INVPLGB instruction, on AMD EPYC 3
and newer CPUs.

In order to not exhaust PCID space, and keep TLB flushes local for single
threaded processes, we only hand out broadcast ASIDs to processes active on
4 or more CPUs.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/include/asm/mmu.h         |   6 +
 arch/x86/include/asm/mmu_context.h |  14 ++
 arch/x86/include/asm/tlbflush.h    |  73 ++++++
 arch/x86/mm/tlb.c                  | 348 ++++++++++++++++++++++++++++-
 4 files changed, 429 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 3b496cdcb74b..d71cd599fec4 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -69,6 +69,12 @@ typedef struct {
 	u16 pkey_allocation_map;
 	s16 execute_only_pkey;
 #endif
+
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+	u16 global_asid;
+	bool asid_transition;
+#endif
+
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(mm)						\
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 795fdd53bd0a..d670699d32c2 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -139,6 +139,8 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 #define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
+extern void destroy_context_free_global_asid(struct mm_struct *mm);
+
 /*
  * Init a new mm.  Used on mm copies, like at fork()
  * and on mm's that are brand-new, like at execve().
@@ -161,6 +163,14 @@ static inline int init_new_context(struct task_struct *tsk,
 		mm->context.execute_only_pkey = -1;
 	}
 #endif
+
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+		mm->context.global_asid = 0;
+		mm->context.asid_transition = false;
+	}
+#endif
+
 	mm_reset_untag_mask(mm);
 	init_new_context_ldt(mm);
 	return 0;
@@ -170,6 +180,10 @@ static inline int init_new_context(struct task_struct *tsk,
 static inline void destroy_context(struct mm_struct *mm)
 {
 	destroy_context_ldt(mm);
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		destroy_context_free_global_asid(mm);
+#endif
 }
 
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index dba5caa4a9f4..234277a5ef89 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -6,6 +6,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
 
+#include <asm/barrier.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/special_insns.h>
@@ -239,6 +240,78 @@ void flush_tlb_one_kernel(unsigned long addr);
 void flush_tlb_multi(const struct cpumask *cpumask,
 		      const struct flush_tlb_info *info);
 
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+static inline bool is_dyn_asid(u16 asid)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return true;
+
+	return asid < TLB_NR_DYN_ASIDS;
+}
+
+static inline bool is_global_asid(u16 asid)
+{
+	return !is_dyn_asid(asid);
+}
+
+static inline bool in_asid_transition(struct mm_struct *mm)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return false;
+
+	return mm && READ_ONCE(mm->context.asid_transition);
+}
+
+static inline u16 mm_global_asid(struct mm_struct *mm)
+{
+	u16 asid;
+
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return 0;
+
+	asid = smp_load_acquire(&mm->context.global_asid);
+
+	/* mm->context.global_asid is either 0, or a global ASID */
+	VM_WARN_ON_ONCE(asid && is_dyn_asid(asid));
+
+	return asid;
+}
+#else
+static inline bool is_dyn_asid(u16 asid)
+{
+	return true;
+}
+
+static inline bool is_global_asid(u16 asid)
+{
+	return false;
+}
+
+static inline bool in_asid_transition(struct mm_struct *mm)
+{
+	return false;
+}
+
+static inline u16 mm_global_asid(struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline bool needs_global_asid_reload(struct mm_struct *next, u16 prev_asid)
+{
+	return false;
+}
+
+static inline void broadcast_tlb_flush(struct flush_tlb_info *info)
+{
+	VM_WARN_ON_ONCE(1);
+}
+
+static inline void consider_global_asid(struct mm_struct *mm)
+{
+}
+#endif
+
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #endif
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 55c922083aa2..f3c0d8fafc57 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -74,13 +74,15 @@
  * use different names for each of them:
  *
  * ASID  - [0, TLB_NR_DYN_ASIDS-1]
- *         the canonical identifier for an mm
+ *         the canonical identifier for an mm, dynamically allocated on each CPU
+ *         [TLB_NR_DYN_ASIDS, MAX_ASID_AVAILABLE-1]
+ *         the canonical, global identifier for an mm, identical across all CPUs
  *
- * kPCID - [1, TLB_NR_DYN_ASIDS]
+ * kPCID - [1, MAX_ASID_AVAILABLE]
  *         the value we write into the PCID part of CR3; corresponds to the
  *         ASID+1, because PCID 0 is special.
  *
- * uPCID - [2048 + 1, 2048 + TLB_NR_DYN_ASIDS]
+ * uPCID - [2048 + 1, 2048 + MAX_ASID_AVAILABLE]
  *         for KPTI each mm has two address spaces and thus needs two
  *         PCID values, but we can still do with a single ASID denomination
  *         for each mm. Corresponds to kPCID + 2048.
@@ -225,6 +227,20 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 		return;
 	}
 
+	/*
+	 * TLB consistency for global ASIDs is maintained with broadcast TLB
+	 * flushing. The TLB is never outdated, and does not need flushing.
+	 */
+	if (static_cpu_has(X86_FEATURE_INVLPGB)) {
+		u16 global_asid = mm_global_asid(next);
+
+		if (global_asid) {
+			*new_asid = global_asid;
+			*need_flush = false;
+			return;
+		}
+	}
+
 	if (this_cpu_read(cpu_tlbstate.invalidate_other))
 		clear_asid_other();
 
@@ -251,6 +267,276 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 	*need_flush = true;
 }
 
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+/*
+ * Logic for broadcast TLB invalidation.
+ */
+static DEFINE_RAW_SPINLOCK(global_asid_lock);
+static u16 last_global_asid = MAX_ASID_AVAILABLE;
+static DECLARE_BITMAP(global_asid_used, MAX_ASID_AVAILABLE) = { 0 };
+static DECLARE_BITMAP(global_asid_freed, MAX_ASID_AVAILABLE) = { 0 };
+static int global_asid_available = MAX_ASID_AVAILABLE - TLB_NR_DYN_ASIDS - 1;
+
+static void reset_global_asid_space(void)
+{
+	lockdep_assert_held(&global_asid_lock);
+
+	/*
+	 * A global TLB flush guarantees that any stale entries from
+	 * previously freed global ASIDs get flushed from the TLB
+	 * everywhere, making these global ASIDs safe to reuse.
+	 */
+	invlpgb_flush_all_nonglobals();
+
+	/*
+	 * Clear all the previously freed global ASIDs from the
+	 * broadcast_asid_used bitmap, now that the global TLB flush
+	 * has made them actually available for re-use.
+	 */
+	bitmap_andnot(global_asid_used, global_asid_used,
+			global_asid_freed, MAX_ASID_AVAILABLE);
+	bitmap_clear(global_asid_freed, 0, MAX_ASID_AVAILABLE);
+
+	/*
+	 * ASIDs 0-TLB_NR_DYN_ASIDS are used for CPU-local ASID
+	 * assignments, for tasks doing IPI based TLB shootdowns.
+	 * Restart the search from the start of the global ASID space.
+	 */
+	last_global_asid = TLB_NR_DYN_ASIDS;
+}
+
+static u16 get_global_asid(void)
+{
+
+	u16 asid;
+
+	lockdep_assert_held(&global_asid_lock);
+
+	/* The previous allocated ASID is at the top of the address space. */
+	if (last_global_asid >= MAX_ASID_AVAILABLE - 1)
+		reset_global_asid_space();
+
+	asid = find_next_zero_bit(global_asid_used, MAX_ASID_AVAILABLE, last_global_asid);
+
+	if (asid >= MAX_ASID_AVAILABLE) {
+		/* This should never happen. */
+		VM_WARN_ONCE(1, "Unable to allocate global ASID despite %d available\n",
+				global_asid_available);
+		return 0;
+	}
+
+	/* Claim this global ASID. */
+	__set_bit(asid, global_asid_used);
+	last_global_asid = asid;
+	global_asid_available--;
+	return asid;
+}
+
+/*
+ * Returns true if the mm is transitioning from a CPU-local ASID to a global
+ * (INVLPGB) ASID, or the other way around.
+ */
+static bool needs_global_asid_reload(struct mm_struct *next, u16 prev_asid)
+{
+	u16 global_asid = mm_global_asid(next);
+
+	/* Process is transitioning to a global ASID */
+	if (global_asid && prev_asid != global_asid)
+		return true;
+
+	/* Transition from global->local ASID does not currently happen. */
+	if (!global_asid && is_global_asid(prev_asid))
+		return true;
+
+	return false;
+}
+
+void destroy_context_free_global_asid(struct mm_struct *mm)
+{
+	if (!mm->context.global_asid)
+		return;
+
+	guard(raw_spinlock_irqsave)(&global_asid_lock);
+
+	/* The global ASID can be re-used only after flush at wrap-around. */
+	__set_bit(mm->context.global_asid, global_asid_freed);
+
+	mm->context.global_asid = 0;
+	global_asid_available++;
+}
+
+/*
+ * Check whether a process is currently active on more than "threshold" CPUs.
+ * This is a cheap estimation on whether or not it may make sense to assign
+ * a global ASID to this process, and use broadcast TLB invalidation.
+ */
+static bool mm_active_cpus_exceeds(struct mm_struct *mm, int threshold)
+{
+	int count = 0;
+	int cpu;
+
+	/* This quick check should eliminate most single threaded programs. */
+	if (cpumask_weight(mm_cpumask(mm)) <= threshold)
+		return false;
+
+	/* Slower check to make sure. */
+	for_each_cpu(cpu, mm_cpumask(mm)) {
+		/* Skip the CPUs that aren't really running this process. */
+		if (per_cpu(cpu_tlbstate.loaded_mm, cpu) != mm)
+			continue;
+
+		if (per_cpu(cpu_tlbstate_shared.is_lazy, cpu))
+			continue;
+
+		if (++count > threshold)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * Assign a global ASID to the current process, protecting against
+ * races between multiple threads in the process.
+ */
+static void use_global_asid(struct mm_struct *mm)
+{
+	u16 asid;
+
+	guard(raw_spinlock_irqsave)(&global_asid_lock);
+
+	/* This process is already using broadcast TLB invalidation. */
+	if (READ_ONCE(mm->context.global_asid))
+		return;
+
+	/* The last global ASID was consumed while waiting for the lock. */
+	if (!READ_ONCE(global_asid_available)) {
+		VM_WARN_ONCE(1, "Ran out of global ASIDs\n");
+		return;
+	}
+
+	asid = get_global_asid();
+	if (!asid)
+		return;
+
+	/*
+	 * Notably flush_tlb_mm_range() -> broadcast_tlb_flush() ->
+	 * finish_asid_transition() needs to observe asid_transition = true
+	 * once it observes global_asid.
+	 */
+	mm->context.asid_transition = true;
+	smp_store_release(&mm->context.global_asid, asid);
+}
+
+/*
+ * x86 has 4k ASIDs (2k when compiled with KPTI), but the largest
+ * x86 systems have over 8k CPUs. Because of this potential ASID
+ * shortage, global ASIDs are handed out to processes that have
+ * frequent TLB flushes and are active on 4 or more CPUs simultaneously.
+ */
+static void consider_global_asid(struct mm_struct *mm)
+{
+	if (!static_cpu_has(X86_FEATURE_INVLPGB))
+		return;
+
+	/* Check every once in a while. */
+	if ((current->pid & 0x1f) != (jiffies & 0x1f))
+		return;
+
+	if (!READ_ONCE(global_asid_available))
+		return;
+
+	/*
+	 * Assign a global ASID if the process is active on
+	 * 4 or more CPUs simultaneously.
+	 */
+	if (mm_active_cpus_exceeds(mm, 3))
+		use_global_asid(mm);
+}
+
+static void finish_asid_transition(struct flush_tlb_info *info)
+{
+	struct mm_struct *mm = info->mm;
+	int bc_asid = mm_global_asid(mm);
+	int cpu;
+
+	if (!READ_ONCE(mm->context.asid_transition))
+		return;
+
+	for_each_cpu(cpu, mm_cpumask(mm)) {
+		/*
+		 * The remote CPU is context switching. Wait for that to
+		 * finish, to catch the unlikely case of it switching to
+		 * the target mm with an out of date ASID.
+		 */
+		while (READ_ONCE(per_cpu(cpu_tlbstate.loaded_mm, cpu)) == LOADED_MM_SWITCHING)
+			cpu_relax();
+
+		if (READ_ONCE(per_cpu(cpu_tlbstate.loaded_mm, cpu)) != mm)
+			continue;
+
+		/*
+		 * If at least one CPU is not using the global ASID yet,
+		 * send a TLB flush IPI. The IPI should cause stragglers
+		 * to transition soon.
+		 *
+		 * This can race with the CPU switching to another task;
+		 * that results in a (harmless) extra IPI.
+		 */
+		if (READ_ONCE(per_cpu(cpu_tlbstate.loaded_mm_asid, cpu)) != bc_asid) {
+			flush_tlb_multi(mm_cpumask(info->mm), info);
+			return;
+		}
+	}
+
+	/* All the CPUs running this process are using the global ASID. */
+	WRITE_ONCE(mm->context.asid_transition, false);
+}
+
+static void broadcast_tlb_flush(struct flush_tlb_info *info)
+{
+	bool pmd = info->stride_shift == PMD_SHIFT;
+	unsigned long maxnr = invlpgb_count_max;
+	unsigned long asid = info->mm->context.global_asid;
+	unsigned long addr = info->start;
+	unsigned long nr;
+
+	/* Flushing multiple pages at once is not supported with 1GB pages. */
+	if (info->stride_shift > PMD_SHIFT)
+		maxnr = 1;
+
+	/*
+	 * TLB flushes with INVLPGB are kicked off asynchronously.
+	 * The inc_mm_tlb_gen() guarantees page table updates are done
+	 * before these TLB flushes happen.
+	 */
+	if (info->end == TLB_FLUSH_ALL) {
+		invlpgb_flush_single_pcid_nosync(kern_pcid(asid));
+		/* Do any CPUs supporting INVLPGB need PTI? */
+		if (static_cpu_has(X86_FEATURE_PTI))
+			invlpgb_flush_single_pcid_nosync(user_pcid(asid));
+	} else do {
+		/*
+		 * Calculate how many pages can be flushed at once; if the
+		 * remainder of the range is less than one page, flush one.
+		 */
+		nr = min(maxnr, (info->end - addr) >> info->stride_shift);
+		nr = max(nr, 1);
+
+		invlpgb_flush_user_nr_nosync(kern_pcid(asid), addr, nr, pmd);
+		/* Do any CPUs supporting INVLPGB need PTI? */
+		if (static_cpu_has(X86_FEATURE_PTI))
+			invlpgb_flush_user_nr_nosync(user_pcid(asid), addr, nr, pmd);
+
+		addr += nr << info->stride_shift;
+	} while (addr < info->end);
+
+	finish_asid_transition(info);
+
+	/* Wait for the INVLPGBs kicked off above to finish. */
+	tlbsync();
+}
+#endif /* CONFIG_X86_BROADCAST_TLB_FLUSH */
+
 /*
  * Given an ASID, flush the corresponding user ASID.  We can delay this
  * until the next time we switch to it.
@@ -556,8 +842,9 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	 */
 	if (prev == next) {
 		/* Not actually switching mm's */
-		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
-			   next->context.ctx_id);
+		VM_WARN_ON(is_dyn_asid(prev_asid) &&
+				this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
+				next->context.ctx_id);
 
 		/*
 		 * If this races with another thread that enables lam, 'new_lam'
@@ -573,6 +860,23 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 
+		/*
+		 * Check if the current mm is transitioning to a new ASID.
+		 */
+		if (needs_global_asid_reload(next, prev_asid)) {
+			next_tlb_gen = atomic64_read(&next->context.tlb_gen);
+
+			choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
+			goto reload_tlb;
+		}
+
+		/*
+		 * Broadcast TLB invalidation keeps this PCID up to date
+		 * all the time.
+		 */
+		if (is_global_asid(prev_asid))
+			return;
+
 		/*
 		 * If the CPU is not in lazy TLB mode, we are just switching
 		 * from one thread in a process to another thread in the same
@@ -606,6 +910,13 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 */
 		cond_mitigation(tsk);
 
+		/*
+		 * Let nmi_uaccess_okay() and finish_asid_transition()
+		 * know that we're changing CR3.
+		 */
+		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
+		barrier();
+
 		/*
 		 * Leave this CPU in prev's mm_cpumask. Atomic writes to
 		 * mm_cpumask can be expensive under contention. The CPU
@@ -620,14 +931,12 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
-
-		/* Let nmi_uaccess_okay() know that we're changing CR3. */
-		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
-		barrier();
 	}
 
+reload_tlb:
 	new_lam = mm_lam_cr3_mask(next);
 	if (need_flush) {
+		VM_WARN_ON_ONCE(is_global_asid(new_asid));
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
 		load_new_mm_cr3(next->pgd, new_asid, new_lam, true);
@@ -746,7 +1055,7 @@ static void flush_tlb_func(void *info)
 	const struct flush_tlb_info *f = info;
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+	u64 local_tlb_gen;
 	bool local = smp_processor_id() == f->initiating_cpu;
 	unsigned long nr_invalidate = 0;
 	u64 mm_tlb_gen;
@@ -769,6 +1078,16 @@ static void flush_tlb_func(void *info)
 	if (unlikely(loaded_mm == &init_mm))
 		return;
 
+	/* Reload the ASID if transitioning into or out of a global ASID */
+	if (needs_global_asid_reload(loaded_mm, loaded_mm_asid)) {
+		switch_mm_irqs_off(NULL, loaded_mm, NULL);
+		loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	}
+
+	/* Broadcast ASIDs are always kept up to date with INVLPGB. */
+	if (is_global_asid(loaded_mm_asid))
+		return;
+
 	VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].ctx_id) !=
 		   loaded_mm->context.ctx_id);
 
@@ -786,6 +1105,8 @@ static void flush_tlb_func(void *info)
 		return;
 	}
 
+	local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+
 	if (unlikely(f->new_tlb_gen != TLB_GENERATION_INVALID &&
 		     f->new_tlb_gen <= local_tlb_gen)) {
 		/*
@@ -953,7 +1274,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	 * up on the new contents of what used to be page tables, while
 	 * doing a speculative memory access.
 	 */
-	if (info->freed_tables)
+	if (info->freed_tables || in_asid_transition(info->mm))
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
 		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
@@ -1049,9 +1370,12 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
+	if (mm_global_asid(mm)) {
+		broadcast_tlb_flush(info);
+	} else if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
 		info->trim_cpumask = should_trim_cpumask(mm);
 		flush_tlb_multi(mm_cpumask(mm), info);
+		consider_global_asid(mm);
 	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-- 
2.47.1


