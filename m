Return-Path: <linux-kernel+bounces-524982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0C2A3E972
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FA07023A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84401CF7AF;
	Fri, 21 Feb 2025 00:54:15 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA182EB10
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099254; cv=none; b=iaAfB7Sg7DC1egBUFYNX5rL2apdVClei2gXAjuzmeCR39A8zMCNaFMdl7DZXDefa6lJn+lVPxC8fGUMiR2N11p5o24yMq34yU/JSazjMS+vRxCa8Ecbta4C25f2ebgYCFqLhdvPS+kA+l1sUpKeJLe/eHzoCRN828YQIQ5FmFB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099254; c=relaxed/simple;
	bh=CtHS+cImp/Eo9nE/5KdUbmyv3ItjKn4xrcbXCstMJRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9LtER5gi4KaR7emmmmrTc1clA47DusLgQjw8ATI0dwcgjB/hE5YQJSZmvZWHlsmHC3RaaX56/3F5vsxt0KwD6eyWfjqX+L0cR+7okOqG+d/I4JZEvNTiKv2PQsZcnEPHB7HGeMLTJADD4CjnsKxf3uttRNc8qSzkTTZ56IMIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tlHIZ-000000003Qf-1rzG;
	Thu, 20 Feb 2025 19:53:47 -0500
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
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v12 13/16] x86/mm: do targeted broadcast flushing from tlbbatch code
Date: Thu, 20 Feb 2025 19:53:12 -0500
Message-ID: <20250221005345.2156760-14-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221005345.2156760-1-riel@surriel.com>
References: <20250221005345.2156760-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Instead of doing a system-wide TLB flush from arch_tlbbatch_flush,
queue up asynchronous, targeted flushes from arch_tlbbatch_add_pending.

This also allows us to avoid adding the CPUs of processes using broadcast
flushing to the batch->cpumask, and will hopefully further reduce TLB
flushing from the reclaim and compaction paths.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/include/asm/tlb.h      | 12 ++---
 arch/x86/include/asm/tlbflush.h | 19 ++++----
 arch/x86/mm/tlb.c               | 79 +++++++++++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index b3cd521e5e2f..f69b243683e1 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -83,16 +83,16 @@ static inline void __tlbsync(void)
 #define INVLPGB_FINAL_ONLY		BIT(4)
 #define INVLPGB_INCLUDE_NESTED		BIT(5)
 
-static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
-						unsigned long addr,
-						u16 nr,
-						bool pmd_stride)
+static inline void __invlpgb_flush_user_nr_nosync(unsigned long pcid,
+						  unsigned long addr,
+						  u16 nr,
+						  bool pmd_stride)
 {
 	__invlpgb(0, pcid, addr, nr, pmd_stride, INVLPGB_PCID | INVLPGB_VA);
 }
 
 /* Flush all mappings for a given PCID, not including globals. */
-static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
+static inline void __invlpgb_flush_single_pcid_nosync(unsigned long pcid)
 {
 	__invlpgb(0, pcid, 0, 1, 0, INVLPGB_PCID);
 }
@@ -105,7 +105,7 @@ static inline void invlpgb_flush_all(void)
 }
 
 /* Flush addr, including globals, for all PCIDs. */
-static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
+static inline void __invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
 {
 	__invlpgb(0, 0, addr, nr, 0, INVLPGB_INCLUDE_GLOBAL);
 }
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index f1f82571249b..241fa1435375 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -105,6 +105,9 @@ struct tlb_state {
 	 * need to be invalidated.
 	 */
 	bool invalidate_other;
+#ifdef CONFIG_X86_BROADCAST_TLB_FLUSH
+	bool need_tlbsync;
+#endif
 
 #ifdef CONFIG_ADDRESS_MASKING
 	/*
@@ -288,6 +291,10 @@ static inline u16 mm_global_asid(struct mm_struct *mm)
 static inline void assign_mm_global_asid(struct mm_struct *mm, u16 asid)
 {
 }
+
+static inline void tlbsync(void)
+{
+}
 #endif
 
 #ifdef CONFIG_PARAVIRT
@@ -337,21 +344,15 @@ static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
 	return atomic64_inc_return(&mm->context.tlb_gen);
 }
 
-static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
-					     struct mm_struct *mm,
-					     unsigned long uaddr)
-{
-	inc_mm_tlb_gen(mm);
-	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
-	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
-}
-
 static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 {
 	flush_tlb_mm(mm);
 }
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+extern void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+					     struct mm_struct *mm,
+					     unsigned long uaddr);
 
 static inline bool pte_flags_need_flush(unsigned long oldflags,
 					unsigned long newflags,
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 01a5edb51ebe..9ca22c504f82 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -485,6 +485,37 @@ static void finish_asid_transition(struct flush_tlb_info *info)
 	WRITE_ONCE(mm->context.asid_transition, false);
 }
 
+static inline void tlbsync(void)
+{
+	if (!this_cpu_read(cpu_tlbstate.need_tlbsync))
+		return;
+	__tlbsync();
+	this_cpu_write(cpu_tlbstate.need_tlbsync, false);
+}
+
+static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
+						unsigned long addr,
+						u16 nr, bool pmd_stride)
+{
+	__invlpgb_flush_user_nr_nosync(pcid, addr, nr, pmd_stride);
+	if (!this_cpu_read(cpu_tlbstate.need_tlbsync))
+		this_cpu_write(cpu_tlbstate.need_tlbsync, true);
+}
+
+static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
+{
+	__invlpgb_flush_single_pcid_nosync(pcid);
+	if (!this_cpu_read(cpu_tlbstate.need_tlbsync))
+		this_cpu_write(cpu_tlbstate.need_tlbsync, true);
+}
+
+static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
+{
+	__invlpgb_flush_addr_nosync(addr, nr);
+	if (!this_cpu_read(cpu_tlbstate.need_tlbsync))
+		this_cpu_write(cpu_tlbstate.need_tlbsync, true);
+}
+
 static void broadcast_tlb_flush(struct flush_tlb_info *info)
 {
 	bool pmd = info->stride_shift == PMD_SHIFT;
@@ -783,6 +814,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(!irqs_disabled());
 
+	tlbsync();
+
 	/*
 	 * Verify that CR3 is what we think it is.  This will catch
 	 * hypothetical buggy code that directly switches to swapper_pg_dir
@@ -959,6 +992,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
  */
 void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
+	tlbsync();
+
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
 		return;
 
@@ -1632,9 +1667,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
-		invlpgb_flush_all_nonglobals();
-	} else if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
+	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
 		flush_tlb_multi(&batch->cpumask, info);
 	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
@@ -1643,12 +1676,52 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		local_irq_enable();
 	}
 
+	/*
+	 * If we issued (asynchronous) INVLPGB flushes, wait for them here.
+	 * The cpumask above contains only CPUs that were running tasks
+	 * not using broadcast TLB flushing.
+	 */
+	tlbsync();
+
 	cpumask_clear(&batch->cpumask);
 
 	put_flush_tlb_info();
 	put_cpu();
 }
 
+void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+					     struct mm_struct *mm,
+					     unsigned long uaddr)
+{
+	u16 asid = mm_global_asid(mm);
+
+	if (asid) {
+		invlpgb_flush_user_nr_nosync(kern_pcid(asid), uaddr, 1, false);
+		/* Do any CPUs supporting INVLPGB need PTI? */
+		if (static_cpu_has(X86_FEATURE_PTI))
+			invlpgb_flush_user_nr_nosync(user_pcid(asid), uaddr, 1, false);
+
+		/*
+		 * Some CPUs might still be using a local ASID for this
+		 * process, and require IPIs, while others are using the
+		 * global ASID.
+		 *
+		 * In this corner case we need to do both the broadcast
+		 * TLB invalidation, and send IPIs. The IPIs will help
+		 * stragglers transition to the broadcast ASID.
+		 */
+		if (in_asid_transition(mm))
+			asid = 0;
+	}
+
+	if (!asid) {
+		inc_mm_tlb_gen(mm);
+		cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
+	}
+
+	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
+}
+
 /*
  * Blindly accessing user memory from NMI context can be dangerous
  * if we're in the middle of switching the current user task or
-- 
2.47.1


