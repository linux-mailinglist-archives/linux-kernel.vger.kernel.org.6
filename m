Return-Path: <linux-kernel+bounces-317407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3022C96DDB6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D7F1F215BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42C917ADFF;
	Thu,  5 Sep 2024 15:15:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10C7F7FC;
	Thu,  5 Sep 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549354; cv=none; b=lFdV2sfi+WJRPmvD1Iw7BElHeYNHZqkNlRKck8vECMb5uDxtsMSH+si63l7lm2cgoOhZE+T6zI22YHR4RiRGM+AoycOV1xnFEG+VCbl+HLMqxs707kO2Why7WFMV3ck2uEEMe6WNwyHa8TgCJ+slg53rZ+tzn87HXn+RpDSYuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549354; c=relaxed/simple;
	bh=n29qv5sQDiBUurEZ3BBtuDs1PXb3HFmKMx+CCIqOCyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRFSdc/zHTNHe+Q6rWf4VjPLZUcxb1vkcnlqbhOjVxY/5SeV2R2czA2IVy4gwepcZ5Th5Pj7ZDWLj5fXLllg0mqbFVv4iKLN7h6d5PvKYBRVhgIb1TSSaf0+gKdbVpiqVzjixXVb2/PovaWzdTZvOWe0Tx8aeWQDxj3/G8O3Qlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA7AC4CEC3;
	Thu,  5 Sep 2024 15:15:51 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2] LoongArch: Improve hardware page table walker
Date: Thu,  5 Sep 2024 23:15:28 +0800
Message-ID: <20240905151528.3029082-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LoongArch has similar problems explained in commit 7f0b1bf04511348995d6
("arm64: Fix barriers used for page table modifications"), when hardware
page table walker (PTW) enabled, speculative accesses may cause spurious
page fault in kernel space. Theoretically, in order to completely avoid
spurious page fault we need a "dbar + ibar" pair between the page table
modifications and the subsequent memory accesses using the corresponding
virtual address. But "ibar" is too heavy for performace, so we only use
a "dbar 0b11000" in set_pte(). And let spurious_fault() filter the rest
rare spurious page faults which should be avoided by "ibar".

Besides, we replace the llsc loop with amo in set_pte() which has better
performace, and refactor mmu_context.h to 1) avoid any load/store/branch
instructions between the writing of CSR.ASID & CSR.PGDL, 2) ensure flush
tlb operation is after updating ASID.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
V2: Ensure flush tlb operation is after updating ASID.

 arch/loongarch/include/asm/atomic.h      |  2 ++
 arch/loongarch/include/asm/mmu_context.h | 35 +++++++++++++++-----
 arch/loongarch/include/asm/pgtable.h     | 32 ++++++++----------
 arch/loongarch/mm/fault.c                | 41 ++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 27 deletions(-)

diff --git a/arch/loongarch/include/asm/atomic.h b/arch/loongarch/include/asm/atomic.h
index 99af8b3160a8..c86f0ab922ec 100644
--- a/arch/loongarch/include/asm/atomic.h
+++ b/arch/loongarch/include/asm/atomic.h
@@ -15,6 +15,7 @@
 #define __LL		"ll.w	"
 #define __SC		"sc.w	"
 #define __AMADD		"amadd.w	"
+#define __AMOR		"amor.w		"
 #define __AMAND_DB	"amand_db.w	"
 #define __AMOR_DB	"amor_db.w	"
 #define __AMXOR_DB	"amxor_db.w	"
@@ -22,6 +23,7 @@
 #define __LL		"ll.d	"
 #define __SC		"sc.d	"
 #define __AMADD		"amadd.d	"
+#define __AMOR		"amor.d		"
 #define __AMAND_DB	"amand_db.d	"
 #define __AMOR_DB	"amor_db.d	"
 #define __AMXOR_DB	"amxor_db.d	"
diff --git a/arch/loongarch/include/asm/mmu_context.h b/arch/loongarch/include/asm/mmu_context.h
index 9f97c3453b9c..304363bd3935 100644
--- a/arch/loongarch/include/asm/mmu_context.h
+++ b/arch/loongarch/include/asm/mmu_context.h
@@ -49,12 +49,12 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 
 /* Normal, classic get_new_mmu_context */
 static inline void
-get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
+get_new_mmu_context(struct mm_struct *mm, unsigned long cpu, bool *need_flush)
 {
 	u64 asid = asid_cache(cpu);
 
 	if (!((++asid) & cpu_asid_mask(&cpu_data[cpu])))
-		local_flush_tlb_user();	/* start new asid cycle */
+		*need_flush = true;	/* start new asid cycle */
 
 	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
 }
@@ -74,21 +74,34 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
+static inline void atomic_update_pgd_asid(unsigned long asid, unsigned long pgdl)
+{
+	__asm__ __volatile__(
+	"csrwr %[pgdl_val], %[pgdl_reg] \n\t"
+	"csrwr %[asid_val], %[asid_reg] \n\t"
+	: [asid_val] "+r" (asid), [pgdl_val] "+r" (pgdl)
+	: [asid_reg] "i" (LOONGARCH_CSR_ASID), [pgdl_reg] "i" (LOONGARCH_CSR_PGDL)
+	: "memory"
+	);
+}
+
 static inline void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 				      struct task_struct *tsk)
 {
+	bool need_flush = false;
 	unsigned int cpu = smp_processor_id();
 
 	/* Check if our ASID is of an older version and thus invalid */
 	if (!asid_valid(next, cpu))
-		get_new_mmu_context(next, cpu);
-
-	write_csr_asid(cpu_asid(cpu, next));
+		get_new_mmu_context(next, cpu, &need_flush);
 
 	if (next != &init_mm)
-		csr_write64((unsigned long)next->pgd, LOONGARCH_CSR_PGDL);
+		atomic_update_pgd_asid(cpu_asid(cpu, next), (unsigned long)next->pgd);
 	else
-		csr_write64((unsigned long)invalid_pg_dir, LOONGARCH_CSR_PGDL);
+		atomic_update_pgd_asid(cpu_asid(cpu, next), (unsigned long)invalid_pg_dir);
+
+	if (need_flush)
+		local_flush_tlb_user(); /* Flush tlb after update ASID */
 
 	/*
 	 * Mark current->active_mm as not "active" anymore.
@@ -135,9 +148,15 @@ drop_mmu_context(struct mm_struct *mm, unsigned int cpu)
 	asid = read_csr_asid() & cpu_asid_mask(&current_cpu_data);
 
 	if (asid == cpu_asid(cpu, mm)) {
+		bool need_flush = false;
+
 		if (!current->mm || (current->mm == mm)) {
-			get_new_mmu_context(mm, cpu);
+			get_new_mmu_context(mm, cpu, &need_flush);
+
 			write_csr_asid(cpu_asid(cpu, mm));
+			if (need_flush)
+				local_flush_tlb_user(); /* Flush tlb after update ASID */
+
 			goto out;
 		}
 	}
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 85431f20a14d..9965f52ef65b 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -331,29 +331,23 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 		 * Make sure the buddy is global too (if it's !none,
 		 * it better already be global)
 		 */
+		if (pte_none(ptep_get(buddy))) {
 #ifdef CONFIG_SMP
-		/*
-		 * For SMP, multiple CPUs can race, so we need to do
-		 * this atomically.
-		 */
-		unsigned long page_global = _PAGE_GLOBAL;
-		unsigned long tmp;
-
-		__asm__ __volatile__ (
-		"1:"	__LL	"%[tmp], %[buddy]		\n"
-		"	bnez	%[tmp], 2f			\n"
-		"	 or	%[tmp], %[tmp], %[global]	\n"
-			__SC	"%[tmp], %[buddy]		\n"
-		"	beqz	%[tmp], 1b			\n"
-		"	nop					\n"
-		"2:						\n"
-		__WEAK_LLSC_MB
-		: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
-		: [global] "r" (page_global));
+			/*
+			 * For SMP, multiple CPUs can race, so we need
+			 * to do this atomically.
+			 */
+			__asm__ __volatile__(
+			__AMOR "$zero, %[global], %[buddy] \n"
+			: [buddy] "+ZB" (buddy->pte)
+			: [global] "r" (_PAGE_GLOBAL)
+			: "memory");
+
+			DBAR(0b11000); /* o_wrw = 0b11000 */
 #else /* !CONFIG_SMP */
-		if (pte_none(ptep_get(buddy)))
 			WRITE_ONCE(*buddy, __pte(pte_val(ptep_get(buddy)) | _PAGE_GLOBAL));
 #endif /* CONFIG_SMP */
+		}
 	}
 }
 
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index 97b40defde06..deefd9617d00 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -31,11 +31,52 @@
 
 int show_unhandled_signals = 1;
 
+static int __kprobes spurious_fault(unsigned long write, unsigned long address)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	if (!(address & __UA_LIMIT))
+		return 0;
+
+	pgd = pgd_offset_k(address);
+	if (!pgd_present(pgdp_get(pgd)))
+		return 0;
+
+	p4d = p4d_offset(pgd, address);
+	if (!p4d_present(p4dp_get(p4d)))
+		return 0;
+
+	pud = pud_offset(p4d, address);
+	if (!pud_present(pudp_get(pud)))
+		return 0;
+
+	pmd = pmd_offset(pud, address);
+	if (!pmd_present(pmdp_get(pmd)))
+		return 0;
+
+	if (pmd_leaf(*pmd)) {
+		return write ? pmd_write(pmdp_get(pmd)) : 1;
+	} else {
+		pte = pte_offset_kernel(pmd, address);
+		if (!pte_present(ptep_get(pte)))
+			return 0;
+
+		return write ? pte_write(ptep_get(pte)) : 1;
+	}
+}
+
 static void __kprobes no_context(struct pt_regs *regs,
 			unsigned long write, unsigned long address)
 {
 	const int field = sizeof(unsigned long) * 2;
 
+	if (spurious_fault(write, address))
+		return;
+
 	/* Are we prepared to handle this kernel fault?	 */
 	if (fixup_exception(regs))
 		return;
-- 
2.43.5


