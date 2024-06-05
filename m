Return-Path: <linux-kernel+bounces-202277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3558FCAA7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AA41C22A24
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C11B194139;
	Wed,  5 Jun 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbFVgcWH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE2190079
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587689; cv=none; b=W9oI0dmtCTmcufdoDQ8002tayNqzhtUKMKapGFkb09DDIJlTm8wFoPG0ZxJVuS+LhOobkPkKZTlI39n/W71zw+YZiDlN+DWUHVX3sST4WcwLCZ/tmRLqX2u+jRg6w++GeI7PCjywfzJHBpjRRaYbIveglTFb0i3C3eiP4y9UBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587689; c=relaxed/simple;
	bh=MFof7xn/oSifUp6j3V5p4AYP/CSYuS80BqueZAmmuuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6cFZX2hzlzaa0u5aN+smXYOquyQpF7qcwk0H8UI5aJ0WJNb5WLvcLipUesjPyfYuMdOzvcB8zEk9yLYRXzXEHe3pJiG7EYADwtWrjBMosASkPZSJ/n6ETGJmmD7CH6oXtNKf/2PeOWxsFasnSJ2q0pRFUecYdP2LQvAHCr9GBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbFVgcWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5382CC32786;
	Wed,  5 Jun 2024 11:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587688;
	bh=MFof7xn/oSifUp6j3V5p4AYP/CSYuS80BqueZAmmuuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbFVgcWHRiy8pGFDtngTEv5eU6zwJP5WKhapkZnCc2mI03cZWTm4GzvL8iv/Je5MF
	 oWk3OVTiG83nP8OWaGHrdw+5nwhzAkmJrNMIcwNMLOvmZu8MZUQ3BNkaksv1UyWJ2i
	 OYHMGVswkTwTQSes3oSvy40gJcpCLSJ6ma+leHj6n4bikuN++iRIG+IUTthtz2pvuW
	 2JSchG9gqfdrCInzs6Ty2xoH4RRiofEW1UNYJg3Hra555cYeBPfDkvtDjGE+GxD9yg
	 JvfaSOCKVfspDfSQ+OxaRJt1zHhTct51b72y77qW2EuFj7hJNM9yFEpFwX7z/m+z9v
	 Wc79Ge1oe18gA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v4 03/11] riscv: mm: Change attribute from __init to __meminit for page functions
Date: Wed,  5 Jun 2024 13:40:46 +0200
Message-ID: <20240605114100.315918-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114100.315918-1-bjorn@kernel.org>
References: <20240605114100.315918-1-bjorn@kernel.org>
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

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/mmu.h     |  4 +--
 arch/riscv/include/asm/pgtable.h |  2 +-
 arch/riscv/mm/init.c             | 56 ++++++++++++++------------------
 3 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 947fd60f9051..c9e03e9da3dc 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -31,8 +31,8 @@ typedef struct {
 #define cntx2asid(cntx)		((cntx) & SATP_ASID_MASK)
 #define cntx2version(cntx)	((cntx) & ~SATP_ASID_MASK)
 
-void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
-			       phys_addr_t sz, pgprot_t prot);
+void __meminit create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+				  pgprot_t prot);
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_MMU_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index aad8b8ca51f1..41f1b2c6f949 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -165,7 +165,7 @@ struct pt_alloc_ops {
 #endif
 };
 
-extern struct pt_alloc_ops pt_ops __initdata;
+extern struct pt_alloc_ops pt_ops __meminitdata;
 
 #ifdef CONFIG_MMU
 /* Number of PGD entries that a user-mode program can use */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index a5b3bc1f3b88..0dd04cedc0d2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -297,7 +297,7 @@ static void __init setup_bootmem(void)
 }
 
 #ifdef CONFIG_MMU
-struct pt_alloc_ops pt_ops __initdata;
+struct pt_alloc_ops pt_ops __meminitdata;
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
@@ -359,7 +359,7 @@ static inline pte_t *__init get_pte_virt_fixmap(phys_addr_t pa)
 	return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
 }
 
-static inline pte_t *__init get_pte_virt_late(phys_addr_t pa)
+static inline pte_t *__meminit get_pte_virt_late(phys_addr_t pa)
 {
 	return (pte_t *) __va(pa);
 }
@@ -378,7 +378,7 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t __init alloc_pte_late(uintptr_t va)
+static phys_addr_t __meminit alloc_pte_late(uintptr_t va)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
@@ -386,9 +386,8 @@ static phys_addr_t __init alloc_pte_late(uintptr_t va)
 	return __pa((pte_t *)ptdesc_address(ptdesc));
 }
 
-static void __init create_pte_mapping(pte_t *ptep,
-				      uintptr_t va, phys_addr_t pa,
-				      phys_addr_t sz, pgprot_t prot)
+static void __meminit create_pte_mapping(pte_t *ptep, uintptr_t va, phys_addr_t pa, phys_addr_t sz,
+					 pgprot_t prot)
 {
 	uintptr_t pte_idx = pte_index(va);
 
@@ -442,7 +441,7 @@ static pmd_t *__init get_pmd_virt_fixmap(phys_addr_t pa)
 	return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
 }
 
-static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
+static pmd_t *__meminit get_pmd_virt_late(phys_addr_t pa)
 {
 	return (pmd_t *) __va(pa);
 }
@@ -459,7 +458,7 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t __init alloc_pmd_late(uintptr_t va)
+static phys_addr_t __meminit alloc_pmd_late(uintptr_t va)
 {
 	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, 0);
 
@@ -467,9 +466,9 @@ static phys_addr_t __init alloc_pmd_late(uintptr_t va)
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
@@ -505,7 +504,7 @@ static pud_t *__init get_pud_virt_fixmap(phys_addr_t pa)
 	return (pud_t *)set_fixmap_offset(FIX_PUD, pa);
 }
 
-static pud_t *__init get_pud_virt_late(phys_addr_t pa)
+static pud_t *__meminit get_pud_virt_late(phys_addr_t pa)
 {
 	return (pud_t *)__va(pa);
 }
@@ -523,7 +522,7 @@ static phys_addr_t __init alloc_pud_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t alloc_pud_late(uintptr_t va)
+static phys_addr_t __meminit alloc_pud_late(uintptr_t va)
 {
 	unsigned long vaddr;
 
@@ -543,7 +542,7 @@ static p4d_t *__init get_p4d_virt_fixmap(phys_addr_t pa)
 	return (p4d_t *)set_fixmap_offset(FIX_P4D, pa);
 }
 
-static p4d_t *__init get_p4d_virt_late(phys_addr_t pa)
+static p4d_t *__meminit get_p4d_virt_late(phys_addr_t pa)
 {
 	return (p4d_t *)__va(pa);
 }
@@ -561,7 +560,7 @@ static phys_addr_t __init alloc_p4d_fixmap(uintptr_t va)
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
-static phys_addr_t alloc_p4d_late(uintptr_t va)
+static phys_addr_t __meminit alloc_p4d_late(uintptr_t va)
 {
 	unsigned long vaddr;
 
@@ -570,9 +569,8 @@ static phys_addr_t alloc_p4d_late(uintptr_t va)
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
@@ -597,9 +595,8 @@ static void __init create_pud_mapping(pud_t *pudp,
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
@@ -655,9 +652,8 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
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
@@ -682,8 +678,7 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 	create_pgd_next_mapping(nextp, va, pa, sz, prot);
 }
 
-static uintptr_t __init best_map_size(phys_addr_t pa, uintptr_t va,
-				      phys_addr_t size)
+static uintptr_t __meminit best_map_size(phys_addr_t pa, uintptr_t va, phys_addr_t size)
 {
 	if (debug_pagealloc_enabled())
 		return PAGE_SIZE;
@@ -719,7 +714,7 @@ asmlinkage void __init __copy_data(void)
 #endif
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-static __init pgprot_t pgprot_from_va(uintptr_t va)
+static __meminit pgprot_t pgprot_from_va(uintptr_t va)
 {
 	if (is_va_kernel_text(va))
 		return PAGE_KERNEL_READ_EXEC;
@@ -744,7 +739,7 @@ void mark_rodata_ro(void)
 				  set_memory_ro);
 }
 #else
-static __init pgprot_t pgprot_from_va(uintptr_t va)
+static __meminit pgprot_t pgprot_from_va(uintptr_t va)
 {
 	if (IS_ENABLED(CONFIG_64BIT) && !is_kernel_mapping(va))
 		return PAGE_KERNEL;
@@ -1236,9 +1231,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
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
-- 
2.43.0


