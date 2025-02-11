Return-Path: <linux-kernel+bounces-510024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF32A3175A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5019E169EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82880269CEB;
	Tue, 11 Feb 2025 21:08:40 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD9267B6C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308119; cv=none; b=eskcTe9XWT6Ms2FTngXTxpmDquCugWONxpGYgsNcAeErOri0UcnjMN/gINVwD/Z5MYzY5G7eLS9U8OYh5UV+A0G+06d3o43NmZviHpU1UVmaafpThpNV86Vgow2TQh58chzaeIGUwTmJF0XYkqgWZBUPynSc2UmFH1h0oVA2Yy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308119; c=relaxed/simple;
	bh=tt2bfFP7jcFdUo2afv4sOIwu1yhbhpmr0QNY7U9JVp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx1C5bNbs7rMTkSAJsEQEwX3knagB8rUt5fbbUxR9FBjEtySKST2ZLFZ+AVdud08zmQ9MHLkvssbYNuj1Uupwx8i7WTcCUdtBKSE3A4+X863kargoiXtbhhUQXC21Xnw/fKx45tbgOsWreQR42V/FF1UY/otYkTL6IDdCmVOOZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1thxUX-000000008HU-2WcT;
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
Subject: [PATCH v10 01/12] x86/mm: make MMU_GATHER_RCU_TABLE_FREE unconditional
Date: Tue, 11 Feb 2025 16:07:56 -0500
Message-ID: <20250211210823.242681-2-riel@surriel.com>
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

Currently x86 uses CONFIG_MMU_GATHER_TABLE_FREE when using
paravirt, and not when running on bare metal.

There is no real good reason to do things differently for
each setup. Make them all the same.

Currently get_user_pages_fast synchronizes against page table
freeing in two different ways:
- on bare metal, by blocking IRQs, which block TLB flush IPIs
- on paravirt, with MMU_GATHER_RCU_TABLE_FREE

This is done because some paravirt TLB flush implementations
handle the TLB flush in the hypervisor, and will do the flush
even when the target CPU has interrupts disabled.

Always handle page table freeing with MMU_GATHER_RCU_TABLE_FREE.
Using RCU synchronization between page table freeing and get_user_pages_fast()
allows bare metal to also do TLB flushing while interrupts are disabled.

Various places in the mm do still block IRQs or disable preemption
as an implicit way to block RCU frees.

That makes it safe to use INVLPGB on AMD CPUs.

Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/Kconfig           |  2 +-
 arch/x86/kernel/paravirt.c |  7 +------
 arch/x86/mm/pgtable.c      | 16 ++++------------
 mm/mmu_gather.c            |  4 ++--
 4 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d7bd0ae48c4..e8743f8c9fd0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -274,7 +274,7 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select MMU_GATHER_RCU_TABLE_FREE	if PARAVIRT
+	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index fec381533555..2b78a6b466ed 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -59,11 +59,6 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
 
-static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	tlb_remove_page(tlb, table);
-}
-
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
@@ -191,7 +186,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
-	.mmu.tlb_remove_table	= native_tlb_remove_table,
+	.mmu.tlb_remove_table	= tlb_remove_table,
 
 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 5745a354a241..3dc4af1f7868 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -18,14 +18,6 @@ EXPORT_SYMBOL(physical_mask);
 #define PGTABLE_HIGHMEM 0
 #endif
 
-#ifndef CONFIG_PARAVIRT
-static inline
-void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	tlb_remove_page(tlb, table);
-}
-#endif
-
 gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
@@ -54,7 +46,7 @@ void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
 	pagetable_pte_dtor(page_ptdesc(pte));
 	paravirt_release_pte(page_to_pfn(pte));
-	paravirt_tlb_remove_table(tlb, pte);
+	tlb_remove_table(tlb, pte);
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -70,7 +62,7 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 	tlb->need_flush_all = 1;
 #endif
 	pagetable_pmd_dtor(ptdesc);
-	paravirt_tlb_remove_table(tlb, ptdesc_page(ptdesc));
+	tlb_remove_table(tlb, ptdesc_page(ptdesc));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
@@ -80,14 +72,14 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 
 	pagetable_pud_dtor(ptdesc);
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
+	tlb_remove_table(tlb, virt_to_page(pud));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
+	tlb_remove_table(tlb, virt_to_page(p4d));
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 99b3e9408aa0..59fd0137af63 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -246,8 +246,8 @@ static void __tlb_remove_table_free(struct mmu_table_batch *batch)
  * IRQs delays the completion of the TLB flush we can never observe an already
  * freed page.
  *
- * Architectures that do not have this (PPC) need to delay the freeing by some
- * other means, this is that means.
+ * Architectures that do not use IPIs (PPC, x86 paravirt, AMD INVLPGB, ARM64)
+ * need to delay the freeing by some other means, this is that means.
  *
  * What we do is batch the freed directory pages (tables) and RCU free them.
  * We use the sched RCU variant, as that guarantees that IRQ/preempt disabling
-- 
2.47.1


