Return-Path: <linux-kernel+bounces-527930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0E9A41158
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F18E3B35C4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C692C1DDC08;
	Sun, 23 Feb 2025 19:50:16 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7248194AC7
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740340215; cv=none; b=fXLBuN3AXBtFL79rIxzpy4q3/fxwgqSrfIMw0eIwFVceDO4aNWfa6AeQVdSDcMHHwqtaDPqE7jveO/+lIfOPN1ugIbmViX+AucTPSDUTN9KcFnrECVk+Z1uUkdX4A5aUAvJhYM3EjY0ajr6HTSftINB6EFD+37MeTUl/1Lkt3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740340215; c=relaxed/simple;
	bh=jNxnNHOFnqPCCxuEwXN0gg4J1RIm49lYeE7Cf74FRL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbkK2UxdvMhOBEDjEXTkzhU6sj71TTWKOml24MFtSAL4ijX1kxt4OzCt1nmXt3Ia/6CApvfERSpeLQYPOl/H/MDMLUCFFuzlQvqMgrkQaevwaZjXC5q+K7GVXEbUAorVtStYd5nyOb2y/dmoosjVJ7p+IOu8tcUWADIpDu8ssFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tmHyy-000000001hX-43q3;
	Sun, 23 Feb 2025 14:49:44 -0500
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
	Manali.Shukla@amd.com,
	mingo@kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v13 07/14] x86/mm: global ASID allocation helper functions
Date: Sun, 23 Feb 2025 14:48:57 -0500
Message-ID: <20250223194943.3518952-8-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250223194943.3518952-1-riel@surriel.com>
References: <20250223194943.3518952-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Functions to manage global ASID space. Multithreaded processes that
are simultaneously active on 4 or more CPUs can get a global ASID,
resulting in the same PCID being used for that process on every CPU.

This in turn will allow the kernel to use hardware-assisted TLB flushing
through AMD INVLPGB or Intel RAR for these processes.

Helper functions split out by request.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/include/asm/mmu.h      |  11 +++
 arch/x86/include/asm/tlbflush.h |  43 ++++++++++
 arch/x86/mm/tlb.c               | 144 +++++++++++++++++++++++++++++++-
 3 files changed, 195 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 3b496cdcb74b..edb5942d4829 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -69,6 +69,17 @@ typedef struct {
 	u16 pkey_allocation_map;
 	s16 execute_only_pkey;
 #endif
+
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+	/*
+	 * The global ASID will be a non-zero value when the process has
+	 * the same ASID across all CPUs, allowing it to make use of
+	 * hardware-assisted remote TLB invalidation like AMD INVLPGB.
+	 */
+	u16 global_asid;
+	/* The process is transitioning to a new global ASID number. */
+	bool asid_transition;
+#endif
 } mm_context_t;
 
 #define INIT_MM_CONTEXT(mm)						\
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 09463a2fb05f..83f1da2f1e4a 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -6,6 +6,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
 
+#include <asm/barrier.h>
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/special_insns.h>
@@ -234,6 +235,48 @@ void flush_tlb_one_kernel(unsigned long addr);
 void flush_tlb_multi(const struct cpumask *cpumask,
 		      const struct flush_tlb_info *info);
 
+static inline bool is_dyn_asid(u16 asid)
+{
+	return asid < TLB_NR_DYN_ASIDS;
+}
+
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
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
+static inline void assign_mm_global_asid(struct mm_struct *mm, u16 asid)
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
+static inline u16 mm_global_asid(struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline void assign_mm_global_asid(struct mm_struct *mm, u16 asid)
+{
+}
+#endif
+
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
 #endif
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 16839651f67f..405630479b90 100644
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
@@ -251,6 +253,142 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 	*need_flush = true;
 }
 
+/*
+ * Global ASIDs are allocated for multi-threaded processes that are
+ * active on multiple CPUs simultaneously, giving each of those
+ * processes the same PCIDs on every CPU, for use with hardware-assisted
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
+	if (mm_global_asid(mm))
+		return;
+
+	/* The last global ASID was consumed while waiting for the lock. */
+	if (!global_asid_available) {
+		VM_WARN_ONCE(1, "Ran out of global ASIDs\n");
+		return;
+	}
+
+	asid = allocate_global_asid();
+	if (!asid)
+		return;
+
+	assign_mm_global_asid(mm, asid);
+}
+
+void destroy_context_free_global_asid(struct mm_struct *mm)
+{
+	if (!mm_global_asid(mm))
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
 /*
  * Given an ASID, flush the corresponding user ASID.  We can delay this
  * until the next time we switch to it.
-- 
2.47.1


