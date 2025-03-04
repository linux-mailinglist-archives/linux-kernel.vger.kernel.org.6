Return-Path: <linux-kernel+bounces-544313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76875A4E003
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DF83B4F18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63E0205AB4;
	Tue,  4 Mar 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP9sY8U5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D5204C3F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096724; cv=none; b=rJaF2z5xFzMH00eBnK1C+R2528jgxFTVO8hMuBNklOM4ptLeSR+sT74vOxFaHbJhvAa7gnHWUCVS5sowoc8futuaVoSuUTo6zosY9pmAiBB54q8Q0diWy8yHpv308LqXJM685vdhgWVb60OiYa3ULpvEwecqdHEEEJjZhFR97M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096724; c=relaxed/simple;
	bh=AVkerff15j+dPRSSgj4ss5DTO/4GX95JT9jOuxMQPW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyL7PTVNSZbf5dr7cKnGhHn4AmFK5QIPh2jBrkQOkTRY36pV6LOkt7Nxb8fwSGhEu02+PNU9RbYozUbMundwkH+nTiaqLjHfVWc370kovQ9OFwoYHFl1pPJRB5qZen1o00NcDR0wjUA1R57TljfaCyMoUkCQEbh+XDJxlz+3M0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP9sY8U5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE90C4CEEB;
	Tue,  4 Mar 2025 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096723;
	bh=AVkerff15j+dPRSSgj4ss5DTO/4GX95JT9jOuxMQPW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JP9sY8U5pmzL0VXVtQ8DDXVIcr5nWRhexUni6oc/fUrknFMJtHLFHKJRB1st1emWQ
	 kU5CCsTVKjRpi6pn/M9QIA9yFglTQfOdkolgWfCWMMUZO434DUnu3IRQ4hoF7bEvMq
	 dABsMZf1WIAzxP0r25tMwC1VddoeVqG0FwTLJR9iSLjJy4ECVG7F2H7qe9VlML8JNc
	 saYG1dibzGIgBoZg3HVjRejXpCqBiYYKVorKP2ltAhoO1jbrgfkPEMJhLZm/vbHfQn
	 9hMn+gaJCyiYpVVD5KEqdLlbxqxt8q2+eTMHWyZHf/si6HoKkBa+442e09197SgHqA
	 wup9zdwT5oiKQ==
From: Borislav Petkov <bp@kernel.org>
To: riel@surriel.com
Cc: Manali.Shukla@amd.com,
	akpm@linux-foundation.org,
	andrew.cooper3@citrix.com,
	jackmanb@google.com,
	jannh@google.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhklinux@outlook.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	x86@kernel.org,
	zhengqi.arch@bytedance.com,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH v15 06/11] x86/mm: Add global ASID allocation helper functions
Date: Tue,  4 Mar 2025 14:58:11 +0100
Message-ID: <20250304135816.12356-7-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304135816.12356-1-bp@kernel.org>
References: <20250304135816.12356-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

Add functions to manage global ASID space. Multithreaded processes that are
simultaneously active on 4 or more CPUs can get a global ASID, resulting in the
same PCID being used for that process on every CPU.

This in turn will allow the kernel to use hardware-assisted TLB flushing
through AMD INVLPGB or Intel RAR for these processes.

  [ bp:
   - Extend use_global_asid() comment
   - s/X86_BROADCAST_TLB_FLUSH/BROADCAST_TLB_FLUSH/g
   - other touchups ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-8-riel@surriel.com
---
 arch/x86/include/asm/mmu.h         |  12 +++
 arch/x86/include/asm/mmu_context.h |   2 +
 arch/x86/include/asm/tlbflush.h    |  37 +++++++
 arch/x86/mm/tlb.c                  | 154 ++++++++++++++++++++++++++++-
 4 files changed, 202 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 3b496cdcb74b..8b8055a8eb9e 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -69,6 +69,18 @@ typedef struct {
 	u16 pkey_allocation_map;
 	s16 execute_only_pkey;
 #endif
+
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
+	/*
+	 * The global ASID will be a non-zero value when the process has
+	 * the same ASID across all CPUs, allowing it to make use of
+	 * hardware-assisted remote TLB invalidation like AMD INVLPGB.
+	 */
+	u16 global_asid;
+
+	/* The process is transitioning to a new global ASID number. */
+	bool asid_transition;
+#endif
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(mm)						\
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 795fdd53bd0a..a2c70e495b1b 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -139,6 +139,8 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 #define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
+extern void mm_free_global_asid(struct mm_struct *mm);
+
 /*
  * Init a new mm.  Used on mm copies, like at fork()
  * and on mm's that are brand-new, like at execve().
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 855c13da2045..f7b374bcdc0b 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -6,6 +6,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
 
+#include <asm/barrier.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/special_insns.h>
@@ -234,6 +235,42 @@ void flush_tlb_one_kernel(unsigned long addr);
 void flush_tlb_multi(const struct cpumask *cpumask,
 		      const struct flush_tlb_info *info);
 
+static inline bool is_dyn_asid(u16 asid)
+{
+	return asid < TLB_NR_DYN_ASIDS;
+}
+
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
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
+
+static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
+{
+	/*
+	 * Notably flush_tlb_mm_range() -> broadcast_tlb_flush() ->
+	 * finish_asid_transition() needs to observe asid_transition = true
+	 * once it observes global_asid.
+	 */
+	mm->context.asid_transition = true;
+	smp_store_release(&mm->context.global_asid, asid);
+}
+#else
+static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
+static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
+#endif /* CONFIG_BROADCAST_TLB_FLUSH */
+
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #endif
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 76b4a88afb56..6c24d967b77d 100644
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
@@ -251,6 +253,152 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 	*need_flush = true;
 }
 
+/*
+ * Global ASIDs are allocated for multi-threaded processes that are
+ * active on multiple CPUs simultaneously, giving each of those
+ * processes the same PCID on every CPU, for use with hardware-assisted
+ * TLB shootdown on remote CPUs, like AMD INVLPGB or Intel RAR.
+ *
+ * These global ASIDs are held for the lifetime of the process.
+ */
+static DEFINE_RAW_SPINLOCK(global_asid_lock);
+static u16 last_global_asid = MAX_ASID_AVAILABLE;
+static DECLARE_BITMAP(global_asid_used, MAX_ASID_AVAILABLE);
+static DECLARE_BITMAP(global_asid_freed, MAX_ASID_AVAILABLE);
+static int global_asid_available = MAX_ASID_AVAILABLE - TLB_NR_DYN_ASIDS - 1;
+
+/*
+ * When the search for a free ASID in the global ASID space reaches
+ * MAX_ASID_AVAILABLE, a global TLB flush guarantees that previously
+ * freed global ASIDs are safe to re-use.
+ *
+ * This way the global flush only needs to happen at ASID rollover
+ * time, and not at ASID allocation time.
+ */
+static void reset_global_asid_space(void)
+{
+	lockdep_assert_held(&global_asid_lock);
+
+	invlpgb_flush_all_nonglobals();
+
+	/*
+	 * The TLB flush above makes it safe to re-use the previously
+	 * freed global ASIDs.
+	 */
+	bitmap_andnot(global_asid_used, global_asid_used,
+			global_asid_freed, MAX_ASID_AVAILABLE);
+	bitmap_clear(global_asid_freed, 0, MAX_ASID_AVAILABLE);
+
+	/* Restart the search from the start of global ASID space. */
+	last_global_asid = TLB_NR_DYN_ASIDS;
+}
+
+static u16 allocate_global_asid(void)
+{
+	u16 asid;
+
+	lockdep_assert_held(&global_asid_lock);
+
+	/* The previous allocation hit the edge of available address space */
+	if (last_global_asid >= MAX_ASID_AVAILABLE - 1)
+		reset_global_asid_space();
+
+	asid = find_next_zero_bit(global_asid_used, MAX_ASID_AVAILABLE, last_global_asid);
+
+	if (asid >= MAX_ASID_AVAILABLE && !global_asid_available) {
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
+ * Check whether a process is currently active on more than @threshold CPUs.
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
+	if (mm_global_asid(mm))
+		return;
+
+	/*
+	 * The last global ASID was consumed while waiting for the lock.
+	 *
+	 * If this fires, a more aggressive ASID reuse scheme might be
+	 * needed.
+	 */
+	if (!global_asid_available) {
+		VM_WARN_ONCE(1, "Ran out of global ASIDs\n");
+		return;
+	}
+
+	asid = allocate_global_asid();
+	if (!asid)
+		return;
+
+	mm_assign_global_asid(mm, asid);
+}
+
+void mm_free_global_asid(struct mm_struct *mm)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return;
+
+	if (!mm_global_asid(mm))
+		return;
+
+	guard(raw_spinlock_irqsave)(&global_asid_lock);
+
+	/* The global ASID can be re-used only after flush at wrap-around. */
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
+	__set_bit(mm->context.global_asid, global_asid_freed);
+
+	mm->context.global_asid = 0;
+	global_asid_available++;
+#endif
+}
+
 /*
  * Given an ASID, flush the corresponding user ASID.  We can delay this
  * until the next time we switch to it.
-- 
2.43.0


