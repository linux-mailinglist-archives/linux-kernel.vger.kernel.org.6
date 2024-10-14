Return-Path: <linux-kernel+bounces-363901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36A399C83A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F1A28E9A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121151D9A72;
	Mon, 14 Oct 2024 11:02:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CFF1D9A66
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903733; cv=none; b=MGAfLGkVmnfsRiWU5z2MqWOWgOLLVb9O2M9xhwFnCwy5qHRsBp+7V6hsqe1vEiYwlH0CMIhiACggmcd3fqtpfpVP8wK+rzIs1Rn8GLzMn6gonINCC54MaXhZvdBARps33taOXCa5M45/UYaUdCSZNJtlRk3z0jl/y6i2eJGETCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903733; c=relaxed/simple;
	bh=LvH7Th5+xLJ7P3eRD+AcldaKQ8Vt13Giclt14TbToh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m10fmsEMd8vPdxFirJmkIk/vl2EIBtTuO31l6ya3BGv2TDvQgFOkbITAkuatf7sIrTjtZN3uGm1CUKOgtbT+7PMi+/VVdH90/+4gOZ0j+5T0nun/cainTHWDNqIX43bohzVlvpgnrG9vVG1DegGBKX0flhnXrY5LP2BL3QA+r2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD6AF1763;
	Mon, 14 Oct 2024 04:02:40 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE3BE3F51B;
	Mon, 14 Oct 2024 04:02:08 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 54/57] arm64: Support runtime folding in idmap_kpti_install_ng_mappings
Date: Mon, 14 Oct 2024 11:59:01 +0100
Message-ID: <20241014105912.3207374-54-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TODO:

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/include/asm/assembler.h |   5 ++
 arch/arm64/kernel/cpufeature.c     |  21 +++++-
 arch/arm64/mm/proc.S               | 107 ++++++++++++++++++++++-------
 3 files changed, 108 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 6424fd6be1cbe..0cfa7c3efd214 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -919,6 +919,11 @@ alternative_cb_end
 	value_for_page_size \val, \val, SZ_4K, SZ_16K, SZ_64K
 	.endm
 
+	.macro	get_page_shift, val
+	get_tg0 \val
+	value_for_page_size \val, \val, ARM64_PAGE_SHIFT_4K, ARM64_PAGE_SHIFT_16K, ARM64_PAGE_SHIFT_64K
+	.endm
+
 	.macro	get_page_mask, val
 	get_tg0 \val
 	value_for_page_size \val, \val, (~(SZ_4K-1)), (~(SZ_16K-1)), (~(SZ_64K-1))
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 663cc76569a27..ee94de556d3f0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1908,11 +1908,27 @@ static phys_addr_t __init kpti_ng_pgd_alloc(int shift)
 	return kpti_ng_temp_alloc;
 }
 
+struct install_ng_pgtable_geometry {
+	unsigned long ptrs_per_pte;
+	unsigned long ptrs_per_pmd;
+	unsigned long ptrs_per_pud;
+	unsigned long ptrs_per_p4d;
+	unsigned long ptrs_per_pgd;
+};
+
 static int __init __kpti_install_ng_mappings(void *__unused)
 {
-	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
+	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long,
+				     struct install_ng_pgtable_geometry *);
 	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
 	kpti_remap_fn *remap_fn;
+	struct install_ng_pgtable_geometry geometry = {
+		.ptrs_per_pte = PTRS_PER_PTE,
+		.ptrs_per_pmd = PTRS_PER_PMD,
+		.ptrs_per_pud = PTRS_PER_PUD,
+		.ptrs_per_p4d = PTRS_PER_P4D,
+		.ptrs_per_pgd = PTRS_PER_PGD,
+	};
 
 	int cpu = smp_processor_id();
 	int levels = CONFIG_PGTABLE_LEVELS;
@@ -1957,7 +1973,8 @@ static int __init __kpti_install_ng_mappings(void *__unused)
 	}
 
 	cpu_install_idmap();
-	remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
+	remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA,
+		 &geometry);
 	cpu_uninstall_idmap();
 
 	if (!cpu) {
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index ab5aa84923524..11bf6ba6dac33 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -190,7 +190,7 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 	.pushsection ".idmap.text", "a"
 
 	.macro	pte_to_phys, phys, pte
-	and	\phys, \pte, #PTE_ADDR_LOW
+	and	\phys, \pte, pte_addr_low
 #ifdef CONFIG_ARM64_PA_BITS_52
 	and	\pte, \pte, #PTE_ADDR_HIGH
 	orr	\phys, \phys, \pte, lsl #PTE_ADDR_HIGH_SHIFT
@@ -198,7 +198,8 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 	.endm
 
 	.macro	kpti_mk_tbl_ng, type, num_entries
-	add	end_\type\()p, cur_\type\()p, #\num_entries * 8
+	lsl	scratch, \num_entries, #3
+	add	end_\type\()p, cur_\type\()p, scratch
 .Ldo_\type:
 	ldr	\type, [cur_\type\()p], #8	// Load the entry and advance
 	tbz	\type, #0, .Lnext_\type		// Skip invalid and
@@ -220,14 +221,18 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 	.macro	kpti_map_pgtbl, type, level
 	str	xzr, [temp_pte, #8 * (\level + 2)]	// break before make
 	dsb	nshst
-	add	pte, temp_pte, #PAGE_SIZE * (\level + 2)
+	mov	scratch, #(\level + 2)
+	mul	scratch, scratch, page_size
+	add	pte, temp_pte, scratch
 	lsr	pte, pte, #12
 	tlbi	vaae1, pte
 	dsb	nsh
 	isb
 
 	phys_to_pte pte, cur_\type\()p
-	add	cur_\type\()p, temp_pte, #PAGE_SIZE * (\level + 2)
+	mov	scratch, #(\level + 2)
+	mul	scratch, scratch, page_size
+	add	cur_\type\()p, temp_pte, scratch
 	orr	pte, pte, pte_flags
 	str	pte, [temp_pte, #8 * (\level + 2)]
 	dsb	nshst
@@ -235,7 +240,8 @@ SYM_FUNC_ALIAS(__pi_idmap_cpu_replace_ttbr1, idmap_cpu_replace_ttbr1)
 
 /*
  * void __kpti_install_ng_mappings(int cpu, int num_secondaries, phys_addr_t temp_pgd,
- *				   unsigned long temp_pte_va)
+ *				   unsigned long temp_pte_va,
+ *				   struct install_ng_pgtable_geometry *geometry)
  *
  * Called exactly once from stop_machine context by each CPU found during boot.
  */
@@ -251,6 +257,8 @@ SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 	temp_pgd_phys	.req	x2
 	swapper_ttb	.req	x3
 	flag_ptr	.req	x4
+	geometry	.req	x4
+	scratch		.req	x4
 	cur_pgdp	.req	x5
 	end_pgdp	.req	x6
 	pgd		.req	x7
@@ -264,18 +272,45 @@ SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 	valid		.req	x17
 	cur_p4dp	.req	x19
 	end_p4dp	.req	x20
-
-	mov	x5, x3				// preserve temp_pte arg
-	mrs	swapper_ttb, ttbr1_el1
-	adr_l	flag_ptr, __idmap_kpti_flag
+	page_size	.req	x21
+	ptrs_per_pte	.req	x22
+	ptrs_per_pmd	.req	x23
+	ptrs_per_pud	.req	x24
+	ptrs_per_p4d	.req	x25
+	ptrs_per_pgd	.req	x26
+	pte_addr_low	.req	x27
 
 	cbnz	cpu, __idmap_kpti_secondary
 
-#if CONFIG_PGTABLE_LEVELS > 4
-	stp	x29, x30, [sp, #-32]!
+	/* Preserve callee-saved registers */
+	stp	x19, x20, [sp, #-96]!
+	stp	x21, x22, [sp, #80]
+	stp	x23, x24, [sp, #64]
+	stp	x25, x26, [sp, #48]
+	stp	x27, x28, [sp, #32]
+	stp	x29, x30, [sp, #16]
 	mov	x29, sp
-	stp	x19, x20, [sp, #16]
-#endif
+
+	/* Load pgtable geometry parameters */
+	get_page_size page_size
+	ldr	ptrs_per_pte, [geometry, #0]
+	ldr	ptrs_per_pmd, [geometry, #8]
+	ldr	ptrs_per_pud, [geometry, #16]
+	ldr	ptrs_per_p4d, [geometry, #24]
+	ldr	ptrs_per_pgd, [geometry, #32]
+
+	/* Precalculate pte_addr_low mask */
+	get_page_shift x0
+	mov	pte_addr_low, #50
+	sub	pte_addr_low, pte_addr_low, x0
+	mov	scratch, #1
+	lsl	pte_addr_low, scratch, pte_addr_low
+	sub	pte_addr_low, pte_addr_low, #1
+	lsl	pte_addr_low, pte_addr_low, x0
+
+	mov	temp_pte, x3
+	mrs	swapper_ttb, ttbr1_el1
+	adr_l	flag_ptr, __idmap_kpti_flag
 
 	/* We're the boot CPU. Wait for the others to catch up */
 	sevl
@@ -290,7 +325,6 @@ SYM_TYPED_FUNC_START(idmap_kpti_install_ng_mappings)
 	msr	ttbr1_el1, temp_pgd_phys
 	isb
 
-	mov	temp_pte, x5
 	mov_q	pte_flags, KPTI_NG_PTE_FLAGS
 
 	/* Everybody is enjoying the idmap, so we can rewrite swapper. */
@@ -320,7 +354,7 @@ alternative_else_nop_endif
 	/* PGD */
 	adrp		cur_pgdp, swapper_pg_dir
 	kpti_map_pgtbl	pgd, -1
-	kpti_mk_tbl_ng	pgd, PTRS_PER_PGD
+	kpti_mk_tbl_ng	pgd, ptrs_per_pgd
 
 	/* Ensure all the updated entries are visible to secondary CPUs */
 	dsb	ishst
@@ -331,21 +365,33 @@ alternative_else_nop_endif
 	isb
 
 	/* Set the flag to zero to indicate that we're all done */
+	adr_l	flag_ptr, __idmap_kpti_flag
 	str	wzr, [flag_ptr]
-#if CONFIG_PGTABLE_LEVELS > 4
-	ldp	x19, x20, [sp, #16]
-	ldp	x29, x30, [sp], #32
-#endif
+
+	/* Restore callee-saved registers */
+	ldp	x29, x30, [sp, #16]
+	ldp	x27, x28, [sp, #32]
+	ldp	x25, x26, [sp, #48]
+	ldp	x23, x24, [sp, #64]
+	ldp	x21, x22, [sp, #80]
+	ldp	x19, x20, [sp], #96
+
 	ret
 
 .Lderef_pgd:
 	/* P4D */
 	.if		CONFIG_PGTABLE_LEVELS > 4
 	p4d		.req	x30
+	cmp		ptrs_per_p4d, #1
+	b.eq		.Lfold_p4d
 	pte_to_phys	cur_p4dp, pgd
 	kpti_map_pgtbl	p4d, 0
-	kpti_mk_tbl_ng	p4d, PTRS_PER_P4D
+	kpti_mk_tbl_ng	p4d, ptrs_per_p4d
 	b		.Lnext_pgd
+.Lfold_p4d:
+	mov		p4d, pgd		// fold to next level
+	mov		cur_p4dp, end_p4dp	// must be equal to terminate loop
+	b		.Lderef_p4d
 	.else		/* CONFIG_PGTABLE_LEVELS <= 4 */
 	p4d		.req	pgd
 	.set		.Lnext_p4d, .Lnext_pgd
@@ -355,10 +401,16 @@ alternative_else_nop_endif
 	/* PUD */
 	.if		CONFIG_PGTABLE_LEVELS > 3
 	pud		.req	x10
+	cmp		ptrs_per_pud, #1
+	b.eq		.Lfold_pud
 	pte_to_phys	cur_pudp, p4d
 	kpti_map_pgtbl	pud, 1
-	kpti_mk_tbl_ng	pud, PTRS_PER_PUD
+	kpti_mk_tbl_ng	pud, ptrs_per_pud
 	b		.Lnext_p4d
+.Lfold_pud:
+	mov		pud, p4d		// fold to next level
+	mov		cur_pudp, end_pudp	// must be equal to terminate loop
+	b		.Lderef_pud
 	.else		/* CONFIG_PGTABLE_LEVELS <= 3 */
 	pud		.req	pgd
 	.set		.Lnext_pud, .Lnext_pgd
@@ -368,10 +420,16 @@ alternative_else_nop_endif
 	/* PMD */
 	.if		CONFIG_PGTABLE_LEVELS > 2
 	pmd		.req	x13
+	cmp		ptrs_per_pmd, #1
+	b.eq		.Lfold_pmd
 	pte_to_phys	cur_pmdp, pud
 	kpti_map_pgtbl	pmd, 2
-	kpti_mk_tbl_ng	pmd, PTRS_PER_PMD
+	kpti_mk_tbl_ng	pmd, ptrs_per_pmd
 	b		.Lnext_pud
+.Lfold_pmd:
+	mov		pmd, pud		// fold to next level
+	mov		cur_pmdp, end_pmdp	// must be equal to terminate loop
+	b		.Lderef_pmd
 	.else		/* CONFIG_PGTABLE_LEVELS <= 2 */
 	pmd		.req	pgd
 	.set		.Lnext_pmd, .Lnext_pgd
@@ -381,7 +439,7 @@ alternative_else_nop_endif
 	/* PTE */
 	pte_to_phys	cur_ptep, pmd
 	kpti_map_pgtbl	pte, 3
-	kpti_mk_tbl_ng	pte, PTRS_PER_PTE
+	kpti_mk_tbl_ng	pte, ptrs_per_pte
 	b		.Lnext_pmd
 
 	.unreq	cpu
@@ -408,6 +466,9 @@ alternative_else_nop_endif
 
 	/* Secondary CPUs end up here */
 __idmap_kpti_secondary:
+	mrs	swapper_ttb, ttbr1_el1
+	adr_l	flag_ptr, __idmap_kpti_flag
+
 	/* Uninstall swapper before surgery begins */
 	__idmap_cpu_set_reserved_ttbr1 x16, x17
 
-- 
2.43.0


