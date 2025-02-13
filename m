Return-Path: <linux-kernel+bounces-513397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD5CA349D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2720216E56C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83F245014;
	Thu, 13 Feb 2025 16:17:30 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F223326E177
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463449; cv=none; b=a7aG0FLsIcxnzjDRvzQoudO8LBc/RfQFdpIrqVaBWAe1SQInAR7IFFM+6sw85PByFcLD/X1ZbNu8LcDL80Y4LqsYHv+QV5xqtlAlGtfzfhwfZAppPTtrMkepd1/7HFgi941y9I5AT3wbRF7vKVDVbMor22u64a3v14JZzYyyXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463449; c=relaxed/simple;
	bh=Auerij6VqA92kR9c6kyhLmRb/jviiaUdie5e/5mmxB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0zIhjVwZ1MlVKvpVmZ7NyIZvUG5gJloXocww1cDCgIJdoPuWh/VJLGoiN9WdHRX9OJqfRfr+V7a6RDait3f0fy3/PTks/quytr1xnltXAivAtB7vahtNo0ExlaFlBDEuNfCZqB6q/oEzxSp6mzdRJkz7mYu45KZf8jRNpmkvx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tibr7-000000003xx-0QCo;
	Thu, 13 Feb 2025 11:14:25 -0500
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
Subject: [PATCH v11 01/12] x86/mm: make MMU_GATHER_RCU_TABLE_FREE unconditional
Date: Thu, 13 Feb 2025 11:13:52 -0500
Message-ID: <20250213161423.449435-2-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250213161423.449435-1-riel@surriel.com>
References: <20250213161423.449435-1-riel@surriel.com>
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
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/Kconfig           |  2 +-
 arch/x86/kernel/paravirt.c | 17 +----------------
 arch/x86/mm/pgtable.c      | 27 ++++-----------------------
 3 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6df7779ed6da..aeb07da762fc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -278,7 +278,7 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select MMU_GATHER_RCU_TABLE_FREE	if PARAVIRT
+	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1ccaa3397a67..527f5605aa3e 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -59,21 +59,6 @@ void __init native_pv_lock_init(void)
 		static_branch_enable(&virt_spin_lock_key);
 }
 
-#ifndef CONFIG_PT_RECLAIM
-static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	tlb_remove_page(tlb, ptdesc_page(ptdesc));
-}
-#else
-static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	tlb_remove_table(tlb, table);
-}
-#endif
-
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
@@ -195,7 +180,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
-	.mmu.tlb_remove_table	= native_tlb_remove_table,
+	.mmu.tlb_remove_table	= tlb_remove_table,
 
 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 1fef5ad32d5a..b1c1f72c1fd1 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -18,25 +18,6 @@ EXPORT_SYMBOL(physical_mask);
 #define PGTABLE_HIGHMEM 0
 #endif
 
-#ifndef CONFIG_PARAVIRT
-#ifndef CONFIG_PT_RECLAIM
-static inline
-void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
-
-	pagetable_dtor(ptdesc);
-	tlb_remove_page(tlb, ptdesc_page(ptdesc));
-}
-#else
-static inline
-void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	tlb_remove_table(tlb, table);
-}
-#endif /* !CONFIG_PT_RECLAIM */
-#endif /* !CONFIG_PARAVIRT */
-
 gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
@@ -64,7 +45,7 @@ early_param("userpte", setup_userpte);
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
 	paravirt_release_pte(page_to_pfn(pte));
-	paravirt_tlb_remove_table(tlb, page_ptdesc(pte));
+	tlb_remove_table(tlb, page_ptdesc(pte));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -78,21 +59,21 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pmd));
+	tlb_remove_table(tlb, virt_to_ptdesc(pmd));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pud));
+	tlb_remove_table(tlb, virt_to_ptdesc(pud));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
-	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(p4d));
+	tlb_remove_table(tlb, virt_to_ptdesc(p4d));
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
-- 
2.47.1


