Return-Path: <linux-kernel+bounces-363884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E8799C823
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1A328BF8E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020F1CDFBE;
	Mon, 14 Oct 2024 11:01:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C771946C2
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903689; cv=none; b=Y+ohfHpHA3Y4hHdQTh3oRCm9TxOaNGqujbiFBceDOVBcpNrXgruE9yZ649c/nDmie77/RMVr4zU48DjkLqXH1TmDAlDTf0hODeTNZQeQbowfx5r3ukcvJ3n0gwuEEYsSDUt1MabLVNkmNpYel6Kwt/UaOSz41xyIq0DeaPt0WcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903689; c=relaxed/simple;
	bh=J3JFKkaIvwbv7WrNiTvi9p1CSe++HVnPhxPMjweksY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/BI6z0h7yb/tQ+Ro9EbsgoBHGmBquFy2ucvQ6b9lmagNAmJLdNFhDWiMKHkTIMH+eOB6HkTnaqt3m0yyw30PaDdRX0dMBTTkoOM0wQTN3N+qkdOOdgM+vD9F3G1GbUTr+HhXzGcQ8iaxOXReOfGWQ2umNmt2HxeEWVXsL4n2Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE0851713;
	Mon, 14 Oct 2024 04:01:55 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE5983F51B;
	Mon, 14 Oct 2024 04:01:23 -0700 (PDT)
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
Subject: [RFC PATCH v1 38/57] arm64: Track early pgtable allocation limit
Date: Mon, 14 Oct 2024 11:58:45 +0100
Message-ID: <20241014105912.3207374-38-ryan.roberts@arm.com>
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

Early pgtables (e.g. init_idmap_pg_dir, init_pg_dir, etc) are allocated
from statically defined memory blocks within the kernel image that are
sized for the calculated worst case requirements. Let's make the
allocator aware of the block's limit so that it can detect any overflow.

This boils down to passing the limit of the memory block to map_range()
so let's add it as a parameter. If an overflow is detected, report the
error to __early_cpu_boot_status and park the cpu.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/include/asm/smp.h      |  1 +
 arch/arm64/kernel/head.S          |  3 +-
 arch/arm64/kernel/image-vars.h    |  3 ++
 arch/arm64/kernel/pi/map_kernel.c | 35 +++++++++++---------
 arch/arm64/kernel/pi/map_range.c  | 54 +++++++++++++++++++++++++------
 arch/arm64/kernel/pi/pi.h         |  4 +--
 arch/arm64/mm/mmu.c               | 14 +++++---
 7 files changed, 81 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 2510eec026f7e..86edc5f8c9673 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -22,6 +22,7 @@
 
 #define CPU_STUCK_REASON_52_BIT_VA	(UL(1) << CPU_STUCK_REASON_SHIFT)
 #define CPU_STUCK_REASON_NO_GRAN	(UL(2) << CPU_STUCK_REASON_SHIFT)
+#define CPU_STUCK_REASON_NO_PGTABLE_MEM	(UL(3) << CPU_STUCK_REASON_SHIFT)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cb68adcabe078..7e17a71fd9e4b 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -89,7 +89,8 @@ SYM_CODE_START(primary_entry)
 	mov	sp, x1
 	mov	x29, xzr
 	adrp	x0, init_idmap_pg_dir
-	mov	x1, xzr
+	adrp	x1, init_idmap_pg_end
+	mov	x2, xzr
 	bl	__pi_create_init_idmap
 
 	/*
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 8f5422ed1b758..a168f3337446f 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -52,6 +52,7 @@ PROVIDE(__pi_cavium_erratum_27456_cpus	= cavium_erratum_27456_cpus);
 #endif
 PROVIDE(__pi__ctype			= _ctype);
 PROVIDE(__pi_memstart_offset_seed	= memstart_offset_seed);
+PROVIDE(__pi___early_cpu_boot_status	= __early_cpu_boot_status);
 
 PROVIDE(__pi_init_idmap_pg_dir		= init_idmap_pg_dir);
 PROVIDE(__pi_init_idmap_pg_end		= init_idmap_pg_end);
@@ -68,6 +69,8 @@ PROVIDE(__pi___inittext_end       	= __inittext_end);
 PROVIDE(__pi___initdata_begin     	= __initdata_begin);
 PROVIDE(__pi___initdata_end       	= __initdata_end);
 PROVIDE(__pi__data                	= _data);
+PROVIDE(__pi___mmuoff_data_start	= __mmuoff_data_start);
+PROVIDE(__pi___mmuoff_data_end		= __mmuoff_data_end);
 PROVIDE(__pi___bss_start		= __bss_start);
 PROVIDE(__pi__end			= _end);
 
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index f374a3e5a5fe1..dcf9233ccfff2 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -20,11 +20,11 @@ extern const u8 __eh_frame_start[], __eh_frame_end[];
 
 extern void idmap_cpu_replace_ttbr1(void *pgdir);
 
-static void __init map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
-			       void *start, void *end, pgprot_t prot,
-			       bool may_use_cont, int root_level)
+static void __init map_segment(pgd_t *pg_dir, u64 *pgd, u64 limit,
+			       u64 va_offset, void *start, void *end,
+			       pgprot_t prot, bool may_use_cont, int root_level)
 {
-	map_range(pgd, ((u64)start + va_offset) & ~PAGE_OFFSET,
+	map_range(pgd, limit, ((u64)start + va_offset) & ~PAGE_OFFSET,
 		  ((u64)end + va_offset) & ~PAGE_OFFSET, (u64)start,
 		  prot, root_level, (pte_t *)pg_dir, may_use_cont, 0);
 }
@@ -32,7 +32,7 @@ static void __init map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
 static void __init unmap_segment(pgd_t *pg_dir, u64 va_offset, void *start,
 				 void *end, int root_level)
 {
-	map_segment(pg_dir, NULL, va_offset, start, end, __pgprot(0),
+	map_segment(pg_dir, NULL, 0, va_offset, start, end, __pgprot(0),
 		    false, root_level);
 }
 
@@ -41,6 +41,7 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 	bool enable_scs = IS_ENABLED(CONFIG_UNWIND_PATCH_PAC_INTO_SCS);
 	bool twopass = IS_ENABLED(CONFIG_RELOCATABLE);
 	u64 pgdp = (u64)init_pg_dir + PAGE_SIZE;
+	u64 limit = (u64)init_pg_end;
 	pgprot_t text_prot = PAGE_KERNEL_ROX;
 	pgprot_t data_prot = PAGE_KERNEL;
 	pgprot_t prot;
@@ -78,16 +79,16 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 	twopass |= enable_scs;
 	prot = twopass ? data_prot : text_prot;
 
-	map_segment(init_pg_dir, &pgdp, va_offset, _stext, _etext, prot,
+	map_segment(init_pg_dir, &pgdp, limit, va_offset, _stext, _etext, prot,
 		    !twopass, root_level);
-	map_segment(init_pg_dir, &pgdp, va_offset, __start_rodata,
+	map_segment(init_pg_dir, &pgdp, limit, va_offset, __start_rodata,
 		    __inittext_begin, data_prot, false, root_level);
-	map_segment(init_pg_dir, &pgdp, va_offset, __inittext_begin,
+	map_segment(init_pg_dir, &pgdp, limit, va_offset, __inittext_begin,
 		    __inittext_end, prot, false, root_level);
-	map_segment(init_pg_dir, &pgdp, va_offset, __initdata_begin,
+	map_segment(init_pg_dir, &pgdp, limit, va_offset, __initdata_begin,
 		    __initdata_end, data_prot, false, root_level);
-	map_segment(init_pg_dir, &pgdp, va_offset, _data, _end, data_prot,
-		    true, root_level);
+	map_segment(init_pg_dir, &pgdp, limit, va_offset, _data, _end,
+		    data_prot, true, root_level);
 	dsb(ishst);
 
 	idmap_cpu_replace_ttbr1(init_pg_dir);
@@ -120,9 +121,9 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_offset, int root_level)
 		 * Remap these segments with different permissions
 		 * No new page table allocations should be needed
 		 */
-		map_segment(init_pg_dir, NULL, va_offset, _stext, _etext,
+		map_segment(init_pg_dir, NULL, 0, va_offset, _stext, _etext,
 			    text_prot, true, root_level);
-		map_segment(init_pg_dir, NULL, va_offset, __inittext_begin,
+		map_segment(init_pg_dir, NULL, 0, va_offset, __inittext_begin,
 			    __inittext_end, text_prot, false, root_level);
 	}
 
@@ -164,7 +165,7 @@ static void __init remap_idmap_for_lpa2(void)
 	 * LPA2 compatible fashion, and update the initial ID map while running
 	 * from that.
 	 */
-	create_init_idmap(init_pg_dir, mask);
+	create_init_idmap(init_pg_dir, init_pg_end, mask);
 	dsb(ishst);
 	set_ttbr0_for_lpa2((u64)init_pg_dir);
 
@@ -175,7 +176,7 @@ static void __init remap_idmap_for_lpa2(void)
 	memset(init_idmap_pg_dir, 0,
 	       (u64)init_idmap_pg_end - (u64)init_idmap_pg_dir);
 
-	create_init_idmap(init_idmap_pg_dir, mask);
+	create_init_idmap(init_idmap_pg_dir, init_idmap_pg_end, mask);
 	dsb(ishst);
 
 	/* switch back to the updated initial ID map */
@@ -188,6 +189,7 @@ static void __init remap_idmap_for_lpa2(void)
 static void __init map_fdt(u64 fdt)
 {
 	static u8 ptes[INIT_IDMAP_FDT_SIZE] __initdata __aligned(PAGE_SIZE);
+	u64 limit = (u64)&ptes[INIT_IDMAP_FDT_SIZE];
 	u64 efdt = fdt + MAX_FDT_SIZE;
 	u64 ptep = (u64)ptes;
 
@@ -195,7 +197,8 @@ static void __init map_fdt(u64 fdt)
 	 * Map up to MAX_FDT_SIZE bytes, but avoid overlap with
 	 * the kernel image.
 	 */
-	map_range(&ptep, fdt, (u64)_text > fdt ? min((u64)_text, efdt) : efdt,
+	map_range(&ptep, limit, fdt,
+		  (u64)_text > fdt ? min((u64)_text, efdt) : efdt,
 		  fdt, PAGE_KERNEL, IDMAP_ROOT_LEVEL,
 		  (pte_t *)init_idmap_pg_dir, false, 0);
 	dsb(ishst);
diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
index 5410b2cac5907..f0024d9b1d921 100644
--- a/arch/arm64/kernel/pi/map_range.c
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -11,11 +11,36 @@
 
 #include "pi.h"
 
+static void __init mmuoff_data_clean(void)
+{
+	bool cache_ena = !!(read_sysreg(sctlr_el1) & SCTLR_ELx_C);
+
+	if (cache_ena)
+		dcache_clean_poc((unsigned long)__mmuoff_data_start,
+				 (unsigned long)__mmuoff_data_end);
+	else
+		dcache_inval_poc((unsigned long)__mmuoff_data_start,
+				 (unsigned long)__mmuoff_data_end);
+}
+
+static void __init report_cpu_stuck(long val)
+{
+	val |= CPU_STUCK_IN_KERNEL;
+	WRITE_ONCE(__early_cpu_boot_status, val);
+
+	/* Ensure the visibility of the status update */
+	dsb(ishst);
+	mmuoff_data_clean();
+
+	cpu_park_loop();
+}
+
 /**
  * map_range - Map a contiguous range of physical pages into virtual memory
  *
  * @pte:		Address of physical pointer to array of pages to
  *			allocate page tables from
+ * @limit:		Physical address of end of page allocation array
  * @start:		Virtual address of the start of the range
  * @end:		Virtual address of the end of the range (exclusive)
  * @pa:			Physical address of the start of the range
@@ -26,8 +51,9 @@
  * @va_offset:		Offset between a physical page and its current mapping
  * 			in the VA space
  */
-void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
-		      int level, pte_t *tbl, bool may_use_cont, u64 va_offset)
+void __init map_range(u64 *pte, u64 limit, u64 start, u64 end, u64 pa,
+		      pgprot_t prot, int level, pte_t *tbl, bool may_use_cont,
+		      u64 va_offset)
 {
 	u64 cmask = (level == 3) ? CONT_PTE_SIZE - 1 : U64_MAX;
 	u64 protval = pgprot_val(prot) & ~PTE_TYPE_MASK;
@@ -56,11 +82,18 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
 			 * table mapping if necessary and recurse.
 			 */
 			if (pte_none(*tbl)) {
+				u64 size = PTRS_PER_PTE * sizeof(pte_t);
+
+				if (*pte + size > limit) {
+					report_cpu_stuck(
+						CPU_STUCK_REASON_NO_PGTABLE_MEM);
+				}
+
 				*tbl = __pte(__phys_to_pte_val(*pte) |
 					     PMD_TYPE_TABLE | PMD_TABLE_UXN);
-				*pte += PTRS_PER_PTE * sizeof(pte_t);
+				*pte += size;
 			}
-			map_range(pte, start, next, pa, prot, level + 1,
+			map_range(pte, limit, start, next, pa, prot, level + 1,
 				  (pte_t *)(__pte_to_phys(*tbl) + va_offset),
 				  may_use_cont, va_offset);
 		} else {
@@ -87,7 +120,8 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
 	}
 }
 
-asmlinkage u64 __init create_init_idmap(pgd_t *pg_dir, pteval_t clrmask)
+asmlinkage u64 __init create_init_idmap(pgd_t *pg_dir, pgd_t *pg_end,
+					pteval_t clrmask)
 {
 	u64 ptep = (u64)pg_dir + PAGE_SIZE;
 	pgprot_t text_prot = PAGE_KERNEL_ROX;
@@ -96,10 +130,12 @@ asmlinkage u64 __init create_init_idmap(pgd_t *pg_dir, pteval_t clrmask)
 	pgprot_val(text_prot) &= ~clrmask;
 	pgprot_val(data_prot) &= ~clrmask;
 
-	map_range(&ptep, (u64)_stext, (u64)__initdata_begin, (u64)_stext,
-		  text_prot, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir, false, 0);
-	map_range(&ptep, (u64)__initdata_begin, (u64)_end, (u64)__initdata_begin,
-		  data_prot, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir, false, 0);
+	map_range(&ptep, (u64)pg_end, (u64)_stext, (u64)__initdata_begin,
+		  (u64)_stext, text_prot, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir,
+		  false, 0);
+	map_range(&ptep, (u64)pg_end, (u64)__initdata_begin, (u64)_end,
+		  (u64)__initdata_begin, data_prot, IDMAP_ROOT_LEVEL,
+		  (pte_t *)pg_dir, false, 0);
 
 	return ptep;
 }
diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
index c91e5e965cd39..20fe0941cb8ee 100644
--- a/arch/arm64/kernel/pi/pi.h
+++ b/arch/arm64/kernel/pi/pi.h
@@ -28,9 +28,9 @@ u64 kaslr_early_init(void *fdt, int chosen);
 void relocate_kernel(u64 offset);
 int scs_patch(const u8 eh_frame[], int size);
 
-void map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
+void map_range(u64 *pgd, u64 limit, u64 start, u64 end, u64 pa, pgprot_t prot,
 	       int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
 
 asmlinkage void early_map_kernel(u64 boot_status, void *fdt);
 
-asmlinkage u64 create_init_idmap(pgd_t *pgd, pteval_t clrmask);
+asmlinkage u64 create_init_idmap(pgd_t *pgd, pgd_t *pg_end, pteval_t clrmask);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 353ea5dc32b85..969348a2e93c9 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -773,8 +773,9 @@ static void __init declare_kernel_vmas(void)
 	declare_vma(&vmlinux_seg[4], _data, _end, 0);
 }
 
-void __pi_map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
-		    int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
+void __pi_map_range(u64 *pgd, u64 limit, u64 start, u64 end, u64 pa,
+		    pgprot_t prot, int level, pte_t *tbl, bool may_use_cont,
+		    u64 va_offset);
 
 static u8 idmap_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
 	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
@@ -784,8 +785,9 @@ static void __init create_idmap(void)
 	u64 start = __pa_symbol(__idmap_text_start);
 	u64 end   = __pa_symbol(__idmap_text_end);
 	u64 ptep  = __pa_symbol(idmap_ptes);
+	u64 limit  = __pa_symbol(&idmap_ptes[IDMAP_LEVELS - 1][0]);
 
-	__pi_map_range(&ptep, start, end, start, PAGE_KERNEL_ROX,
+	__pi_map_range(&ptep, limit, start, end, start, PAGE_KERNEL_ROX,
 		       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
 		       __phys_to_virt(ptep) - ptep);
 
@@ -798,8 +800,10 @@ static void __init create_idmap(void)
 		 * of its synchronization flag in the ID map.
 		 */
 		ptep = __pa_symbol(kpti_ptes);
-		__pi_map_range(&ptep, pa, pa + sizeof(u32), pa, PAGE_KERNEL,
-			       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
+		limit  = __pa_symbol(&kpti_ptes[IDMAP_LEVELS - 1][0]);
+		__pi_map_range(&ptep, limit, pa, pa + sizeof(u32), pa,
+			       PAGE_KERNEL, IDMAP_ROOT_LEVEL,
+			       (pte_t *)idmap_pg_dir, false,
 			       __phys_to_virt(ptep) - ptep);
 	}
 }
-- 
2.43.0


