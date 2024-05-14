Return-Path: <linux-kernel+bounces-178781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4DC8C5799
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF911C21AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3791448FF;
	Tue, 14 May 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um6pxZBb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0D1459E2
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695513; cv=none; b=Ld3ThblyIIWEh4OHNJE5/Km9HAqRWM5Hd27AvSpxBOhIM1C4quIgJNWLfROTFvXu5JWmwEP8LbeaCM0Z3+q6pclR30QE2jARVX7MqBqy/sTLUHmcuVBWy6E7MTuts7OQChCpYVgbNZF9g9ACG8B7JpnSqNFavu8eek+ryXiK5LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695513; c=relaxed/simple;
	bh=TaDiQetQybqKd6ZxR/jcE5PkU8hQbMlo+vFY+ZDy3zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQTQUXVN0ySeR/z3/7UQBZ2sDCwmx1xxA0vFsrcBncpo91bI+IAdkF3tju4cAeWRekHI/GdR+YAxMXdLsvRBbB89BeSsIv9tJMidlep+ygmw981iVUPyJITAKUu2b7XPWwaQP1/ys1YnepLTPbm4zaL95uJVZTLLNjrqDT83t/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um6pxZBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABF4C32782;
	Tue, 14 May 2024 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695513;
	bh=TaDiQetQybqKd6ZxR/jcE5PkU8hQbMlo+vFY+ZDy3zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Um6pxZBb03VIozcHaKKyM/e7rsrF2bB7BRxYDLJp7hWQla6fuSi8TPOnXKDNIPa56
	 DMA6SCQqLJvrf9NPtQQa3VDNIg3QbcaUzxenDWFXHcy7WZ+e9lijNqsV1qEuKedsCj
	 fhMgKGD4nqxmx88Pdfkw7QlsmYYUk1nO9c47s/UIXGvNBuqd/42g3ZEPlTu0yF+Uhn
	 BzU437TCi2CekrhYc2nT6ojxNdLYrUlwfGcJsofv+Rl8Qf8Q4BeOiRki3hU/ihNoo/
	 CQZHkziFcg/X+M1WW5G561IkP3VC6xbOqRHxvURTL4ZpvQyOc5rHaDhZt9wGsJy2hU
	 g9z/70AL1e2Wg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 2/8] riscv: mm: Change attribute from __init to __meminit for page functions
Date: Tue, 14 May 2024 16:04:40 +0200
Message-Id: <20240514140446.538622-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240514140446.538622-1-bjorn@kernel.org>
References: <20240514140446.538622-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Prepare for memory hotplugging support by changing from __init to
__meminit for the page table functions that are used by the upcoming
architecture specific callbacks.

Changing the __init attribute to __meminit, avoids that the functions
are removed after init. The __meminit attribute makes sure the
functions are kept in the kernel text post init, but only if memory
hotplugging is enabled for the build.

Also, make sure that the altmap parameter is properly passed on to
vmemmap_populate_hugepages().

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/mmu.h     |  4 +--
 arch/riscv/include/asm/pgtable.h |  2 +-
 arch/riscv/mm/init.c             | 58 ++++++++++++++------------------
 3 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 60be458e94da..c09c3c79f496 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -28,8 +28,8 @@ typedef struct {
 #endif
 } mm_context_t;
 
-void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
-			       phys_addr_t sz, pgprot_t prot);
+void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+				  pgprot_t prot);
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_MMU_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 58fd7b70b903..7933f493db71 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -162,7 +162,7 @@ struct pt_alloc_ops {
 #endif
 };
 
-extern struct pt_alloc_ops pt_ops __initdata;
+extern struct pt_alloc_ops pt_ops __meminitdata;
 
 #ifdef CONFIG_MMU
 /* Number of PGD entries that a user-mode program can use */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5b8cdfafb52a..c969427eab88 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -295,7 +295,7 @@ static void __init setup_bootmem(void)
 }
 
 #ifdef CONFIG_MMU
-struct pt_alloc_ops pt_ops __initdata;
+struct pt_alloc_ops pt_ops __meminitdata;
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
@@ -357,7 +357,7 @@ static inline pte_t *__init get_pte_virt_fixmap(phys_addr_t pa)
 	return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
 }
 
-static inline pte_t *__init get_pte_virt_late(phys_addr_t pa)
+static inline pte_t *__meminit get_pte_virt_late(phys_addr_t pa)
 {
 	return (pte_t *) __va(pa);
 }
@@ -376,7 +376,7 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t __init alloc_pte_late(uintptr_t va)
+static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
@@ -384,9 +384,8 @@ static phys_addr_t __init alloc_pte_late(uintptr_t va)
 	return __pa((pte_t *)ptdesc_address(ptdesc));
 }
 
-static void __init create_pte_mapping(pte_t *ptep,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_pte_mapping(pte_t *ptep, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+					 pgprot_t prot)
 {
 	uintptr_t pte_idx = pte_index(va);
 
@@ -440,7 +439,7 @@ static pmd_t *__init get_pmd_virt_fixmap(phys_addr_t pa)
 	return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
 }
 
-static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
+static pmd_t *__meminit get_pmd_virt_late(phys_addr_t pa)
 {
 	return (pmd_t *) __va(pa);
 }
@@ -457,7 +456,7 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t __init alloc_pmd_late(uintptr_t va)
+static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
@@ -465,9 +464,9 @@ static phys_addr_t __init alloc_pmd_late(uintptr_t va)
 	return __pa((pmd_t *)ptdesc_address(ptdesc));
 }
 
-static void __init create_pmd_mapping(pmd_t *pmdp,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_pmd_mapping(pmd_t *pmdp,
+					 uintptr_t va, phys_addr_t pa,
+					 phys_addr_t sz, pgprot_t prot)
 {
 	pte_t *ptep;
 	phys_addr_t pte_phys;
@@ -503,7 +502,7 @@ static pud_t *__init get_pud_virt_fixmap(phys_addr_t pa)
 	return (pud_t *)set_fixmap_offset(FIX_PUD, pa);
 }
 
-static pud_t *__init get_pud_virt_late(phys_addr_t pa)
+static pud_t *__meminit get_pud_virt_late(phys_addr_t pa)
 {
 	return (pud_t *)__va(pa);
 }
@@ -521,7 +520,7 @@ static phys_addr_t __init alloc_pud_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t alloc_pud_late(uintptr_t va)
+static phys_addr_t __meminit alloc_pud_late(uintptr_t va)
 {
 	unsigned long vaddr;
 
@@ -541,7 +540,7 @@ static p4d_t *__init get_p4d_virt_fixmap(phys_addr_t pa)
 	return (p4d_t *)set_fixmap_offset(FIX_P4D, pa);
 }
 
-static p4d_t *__init get_p4d_virt_late(phys_addr_t pa)
+static p4d_t *__meminit get_p4d_virt_late(phys_addr_t pa)
 {
 	return (p4d_t *)__va(pa);
 }
@@ -559,7 +558,7 @@ static phys_addr_t __init alloc_p4d_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t alloc_p4d_late(uintptr_t va)
+static phys_addr_t __meminit alloc_p4d_late(uintptr_t va)
 {
 	unsigned long vaddr;
 
@@ -568,9 +567,8 @@ static phys_addr_t alloc_p4d_late(uintptr_t va)
 	return __pa(vaddr);
 }
 
-static void __init create_pud_mapping(pud_t *pudp,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_pud_mapping(pud_t *pudp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+					 pgprot_t prot)
 {
 	pmd_t *nextp;
 	phys_addr_t next_phys;
@@ -595,9 +593,8 @@ static void __init create_pud_mapping(pud_t *pudp,
 	create_pmd_mapping(nextp, va, pa, sz, prot);
 }
 
-static void __init create_p4d_mapping(p4d_t *p4dp,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_p4d_mapping(p4d_t *p4dp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+					 pgprot_t prot)
 {
 	pud_t *nextp;
 	phys_addr_t next_phys;
@@ -653,9 +650,8 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
 #define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot) do {} while(0)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-void __init create_pgd_mapping(pgd_t *pgdp,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+				  pgprot_t prot)
 {
 	pgd_next_t *nextp;
 	phys_addr_t next_phys;
@@ -680,8 +676,7 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 	create_pgd_next_mapping(nextp, va, pa, sz, prot);
 }
 
-static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
-				      phys_addr_t size)
+static uintptr_t __meminit best_map_size(phys_addr_t pa, uintptr_t va, phys_addr_t size)
 {
 	if (pgtable_l5_enabled &&
 	    !(pa & (P4D_SIZE - 1)) && !(va & (P4D_SIZE - 1)) && size >= P4D_SIZE)
@@ -714,7 +709,7 @@ asmlinkage void __init __copy_data(void)
 #endif
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-static __init pgprot_t pgprot_from_va(uintptr_t va)
+static __meminit pgprot_t pgprot_from_va(uintptr_t va)
 {
 	if (is_va_kernel_text(va))
 		return PAGE_KERNEL_READ_EXEC;
@@ -739,7 +734,7 @@ void mark_rodata_ro(void)
 				  set_memory_ro);
 }
 #else
-static __init pgprot_t pgprot_from_va(uintptr_t va)
+static __meminit pgprot_t pgprot_from_va(uintptr_t va)
 {
 	if (IS_ENABLED(CONFIG_64BIT) && !is_kernel_mapping(va))
 		return PAGE_KERNEL;
@@ -1231,9 +1226,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	pt_ops_set_fixmap();
 }
 
-static void __init create_linear_mapping_range(phys_addr_t start,
-					       phys_addr_t end,
-					       uintptr_t fixed_map_size)
+static void __meminit create_linear_mapping_range(phys_addr_t start, phys_addr_t end,
+						  uintptr_t fixed_map_size)
 {
 	phys_addr_t pa;
 	uintptr_t va, map_size;
@@ -1435,7 +1429,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	 * memory hotplug, we are not able to update all the page tables with
 	 * the new PMDs.
 	 */
-	return vmemmap_populate_hugepages(start, end, node, NULL);
+	return vmemmap_populate_hugepages(start, end, node, altmap);
 }
 #endif
 
-- 
2.40.1


