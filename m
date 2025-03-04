Return-Path: <linux-kernel+bounces-544317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073AA4E007
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5513A261A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1842D2063C3;
	Tue,  4 Mar 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwH/QIJc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EDD205E34
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096737; cv=none; b=n4zUN25yTgCUzym6niDy8e285cSjvIjNGTa+MLvUHuBMpOcvmLhkKIKrjCpeV5a0XQjdQFQZBKL6diey07+RjQ/vWnSRHfaSS9w3e9O95EcrI1JaKfibEFGGxom5bvPvNGW1sD5nKrf+T9caLYJ1opjo+o9OKNZlMDhxBsXPuRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096737; c=relaxed/simple;
	bh=stV7xxxBalUUJGGfdqVe/j6rs+E8JtA24+pOHC7n1qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DevJDKgw04jmd5YDVcZOCnCWEaMb6Gtuc/vkIXwIM61smwESGRWfdlatxY9I5bb+vCu7VlftyvKy8e4RG8QyVdOMVdO7MLsy+0BeTmGJDtNMxgcGPnm2+gBRSTLJp0C/Dim8KZnPA6Srg+45tEytYKgPyl3SN5rIopobwOV8N3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwH/QIJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30815C4CEE5;
	Tue,  4 Mar 2025 13:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096737;
	bh=stV7xxxBalUUJGGfdqVe/j6rs+E8JtA24+pOHC7n1qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwH/QIJcNEZuv14gJ1GlBIj0C24z2Il17tn5+VNrDVbF78IHCNS8RRmVhVrnoHm1u
	 MvuOAMxjYV8ex3ydzFufLf4b883+FR9Ppd0ORuMOjG0SyOmLlv1BIqPTGlZc2+h+Xo
	 fzoPx2i5uqIDcGTcSfRiJ7K54l1/wxAED8x2dSZ0UqDXwyvkKFI5n+tPM7hHaAy/0g
	 bZwc3GyP0h45riZXdUset9sogaMUvybd11rtIYjdNdmh0Zz7XuSL36e8n0hePF8CIi
	 02APEkK9B8DT91ndAFC3ou06Mooc3lFi11klMfxsAqGnuVa7NoAYlGtuhywJ537vwK
	 kL/63Oj2YACEw==
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
Subject: [PATCH v15 10/11] x86/mm: Do targeted broadcast flushing from tlbbatch code
Date: Tue,  4 Mar 2025 14:58:15 +0100
Message-ID: <20250304135816.12356-11-bp@kernel.org>
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

Instead of doing a system-wide TLB flush from arch_tlbbatch_flush(), queue up
asynchronous, targeted flushes from arch_tlbbatch_add_pending().

This also allows to avoid adding the CPUs of processes using broadcast
flushing to the batch->cpumask, and will hopefully further reduce TLB flushing
from the reclaim and compaction paths.

  [ bp:
   - Massage
   - :%s/\<static_cpu_has\>/cpu_feature_enabled/cgi
   - merge in improvements from dhansen ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-12-riel@surriel.com
---
 arch/x86/include/asm/tlb.h      | 10 ++--
 arch/x86/include/asm/tlbflush.h | 27 ++++++----
 arch/x86/mm/tlb.c               | 88 +++++++++++++++++++++++++++++++--
 3 files changed, 108 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 8ffcae7beb55..e8561a846754 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -108,9 +108,9 @@ static inline void __tlbsync(void) { }
 /* The implied mode when all bits are clear: */
 #define INVLPGB_MODE_ALL_NONGLOBALS	0UL
 
-static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
-						unsigned long addr,
-						u16 nr, bool stride)
+static inline void __invlpgb_flush_user_nr_nosync(unsigned long pcid,
+						  unsigned long addr,
+						  u16 nr, bool stride)
 {
 	enum addr_stride str = stride ? PMD_STRIDE : PTE_STRIDE;
 	u8 flags = INVLPGB_FLAG_PCID | INVLPGB_FLAG_VA;
@@ -119,7 +119,7 @@ static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
 }
 
 /* Flush all mappings for a given PCID, not including globals. */
-static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
+static inline void __invlpgb_flush_single_pcid_nosync(unsigned long pcid)
 {
 	__invlpgb(0, pcid, 0, 1, PTE_STRIDE, INVLPGB_FLAG_PCID);
 }
@@ -139,7 +139,7 @@ static inline void invlpgb_flush_all(void)
 }
 
 /* Flush addr, including globals, for all PCIDs. */
-static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
+static inline void __invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
 {
 	__invlpgb(0, 0, addr, nr, PTE_STRIDE, INVLPGB_FLAG_INCLUDE_GLOBAL);
 }
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 7cad283d502d..214d912ac148 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -105,6 +105,9 @@ struct tlb_state {
 	 * need to be invalidated.
 	 */
 	bool invalidate_other;
+#ifdef CONFIG_BROADCAST_TLB_FLUSH
+	bool need_tlbsync;
+#endif
 
 #ifdef CONFIG_ADDRESS_MASKING
 	/*
@@ -292,12 +295,24 @@ static inline bool mm_in_asid_transition(struct mm_struct *mm)
 
 	return mm && READ_ONCE(mm->context.asid_transition);
 }
+
+static inline bool cpu_need_tlbsync(void)
+{
+	return this_cpu_read(cpu_tlbstate.need_tlbsync);
+}
+
+static inline void cpu_set_tlbsync(bool state)
+{
+	this_cpu_write(cpu_tlbstate.need_tlbsync, state);
+}
 #else
 static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
 static inline void mm_init_global_asid(struct mm_struct *mm) { }
 static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
 static inline void mm_clear_asid_transition(struct mm_struct *mm) { }
 static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
+static inline bool cpu_need_tlbsync(void) { return false; }
+static inline void cpu_set_tlbsync(bool state) { }
 #endif /* CONFIG_BROADCAST_TLB_FLUSH */
 
 #ifdef CONFIG_PARAVIRT
@@ -347,21 +362,15 @@ static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
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
index 0efd99053c09..61065975c139 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -492,6 +492,37 @@ static void finish_asid_transition(struct flush_tlb_info *info)
 	mm_clear_asid_transition(mm);
 }
 
+static inline void tlbsync(void)
+{
+	if (cpu_need_tlbsync()) {
+		__tlbsync();
+		cpu_set_tlbsync(false);
+	}
+}
+
+static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
+						unsigned long addr,
+						u16 nr, bool pmd_stride)
+{
+	__invlpgb_flush_user_nr_nosync(pcid, addr, nr, pmd_stride);
+	if (!cpu_need_tlbsync())
+		cpu_set_tlbsync(true);
+}
+
+static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
+{
+	__invlpgb_flush_single_pcid_nosync(pcid);
+	if (!cpu_need_tlbsync())
+		cpu_set_tlbsync(true);
+}
+
+static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
+{
+	__invlpgb_flush_addr_nosync(addr, nr);
+	if (!cpu_need_tlbsync())
+		cpu_set_tlbsync(true);
+}
+
 static void broadcast_tlb_flush(struct flush_tlb_info *info)
 {
 	bool pmd = info->stride_shift == PMD_SHIFT;
@@ -790,6 +821,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(!irqs_disabled());
 
+	tlbsync();
+
 	/*
 	 * Verify that CR3 is what we think it is.  This will catch
 	 * hypothetical buggy code that directly switches to swapper_pg_dir
@@ -966,6 +999,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
  */
 void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
+	tlbsync();
+
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
 		return;
 
@@ -1633,9 +1668,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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
@@ -1644,12 +1677,61 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		local_irq_enable();
 	}
 
+	/*
+	 * Wait for outstanding INVLPGB flushes. batch->cpumask will
+	 * be empty when the batch was handled completely by INVLPGB.
+	 * Note that mm_in_asid_transition() mm's may use INVLPGB and
+	 * the flush_tlb_multi() IPIs at the same time.
+	 */
+	tlbsync();
+
 	cpumask_clear(&batch->cpumask);
 
 	put_flush_tlb_info();
 	put_cpu();
 }
 
+void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+			       struct mm_struct *mm, unsigned long uaddr)
+{
+	u16 global_asid = mm_global_asid(mm);
+
+	if (global_asid) {
+		/*
+		 * Global ASIDs can be flushed with INVLPGB. Flush
+		 * now instead of batching them for later. A later
+		 * tlbsync() is required to ensure these completed.
+		 */
+		invlpgb_flush_user_nr_nosync(kern_pcid(global_asid), uaddr, 1, false);
+		/* Do any CPUs supporting INVLPGB need PTI? */
+		if (cpu_feature_enabled(X86_FEATURE_PTI))
+			invlpgb_flush_user_nr_nosync(user_pcid(global_asid), uaddr, 1, false);
+
+		/*
+		 * Some CPUs might still be using a local ASID for this
+		 * process, and require IPIs, while others are using the
+		 * global ASID.
+		 *
+		 * In this corner case, both broadcast TLB invalidation
+		 * and IPIs need to be sent. The IPIs will help
+		 * stragglers transition to the broadcast ASID.
+		 */
+		if (mm_in_asid_transition(mm))
+			global_asid = 0;
+	}
+
+	if (!global_asid) {
+		/*
+		 * Mark the mm and the CPU so that
+		 * the TLB gets flushed later.
+		 */
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
2.43.0


