Return-Path: <linux-kernel+bounces-363886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF9999C827
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CC51C251DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95921CF5C4;
	Mon, 14 Oct 2024 11:01:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A281A7072
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903694; cv=none; b=GQla6VCHHhAgDH8lPlY1HuijqzRQDp1oPg3x/Ic+KlYT9On3bo9bZ1+0vjy678Xf/vQ7qdwFUyzy9veKJ4VDMoG41/yYo/dlDwUBpx6uveXUgYCNmDqMmK23lT0knfs5/xzizvzxirGLKTF2Teh5uduRHtMBHFF5Jux8jVrwIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903694; c=relaxed/simple;
	bh=tNRmqwpjEXHMzpzMSnF3aAYrA69SiT8r/mJW5vbYbb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgqUFfBZbTcKYYOwV4UuvUSBVB08YD7IbRfmZMgO1YOzzZp+eqgBi9Xu5uLHFP/MQ9pEOAApk5WQdxv7dHg5k543gTYbv2qmla3I++aM0vE8WZ9+tI6TNJp8IU+F7Qca0UcKBAiEZ7URkNQCrfUTE7hcgjHn+lDeGns24ZNAYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FFE01713;
	Mon, 14 Oct 2024 04:02:01 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 204203F51B;
	Mon, 14 Oct 2024 04:01:29 -0700 (PDT)
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
Subject: [RFC PATCH v1 40/57] arm64: Refactor early pgtable size calculation macros
Date: Mon, 14 Oct 2024 11:58:47 +0100
Message-ID: <20241014105912.3207374-40-ryan.roberts@arm.com>
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

The various early idmaps and init/swapper pgtables are constructed using
static storage, the size of which is obviously calculated at
compile-time based on the selected page size. But in the near future,
boot-time page size builds will need to statically allocate enough
storage for the worst case, depending on which page size is selected.

Therefore, refactor the macros that determine the storage requirement to
take a page_shift parameter, then perform the calculation for each page
size we are compiling with support for and take the max. For
compile-time page size builds, the end result is exactly the same
because there is only 1 page size we support. For boot-time page size
builds we end up with the worst case required size.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/include/asm/kernel-pgtable.h | 148 +++++++++++++++++-------
 arch/arm64/include/asm/pgtable-hwdef.h  |   6 +-
 arch/arm64/kernel/pi/map_kernel.c       |   6 +-
 arch/arm64/kernel/pi/map_range.c        |   8 +-
 arch/arm64/kernel/vmlinux.lds.S         |   4 +-
 arch/arm64/mm/mmu.c                     |  13 +--
 6 files changed, 124 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 1722b9217d47d..facdf273d4cda 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -12,28 +12,38 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/sparsemem.h>
 
+#define PGTABLE_LEVELS(page_shift, va_bits)				\
+	__ARM64_HW_PGTABLE_LEVELS(page_shift, va_bits)
+#define PGTABLE_LEVEL_SHIFT(page_shift, n)				\
+	__ARM64_HW_PGTABLE_LEVEL_SHIFT(page_shift, n)
+#define PGTABLE_LEVEL_SIZE(page_shift, n)				\
+	(UL(1) << PGTABLE_LEVEL_SHIFT(page_shift, n))
+
 /*
  * The physical and virtual addresses of the start of the kernel image are
  * equal modulo 2 MiB (per the arm64 booting.txt requirements). Hence we can
  * use section mapping with 4K (section size = 2M) but not with 16K (section
  * size = 32M) or 64K (section size = 512M).
  */
-#if defined(PMD_SIZE) && PMD_SIZE <= MIN_KIMG_ALIGN
-#define SWAPPER_BLOCK_SHIFT	PMD_SHIFT
-#define SWAPPER_SKIP_LEVEL	1
-#else
-#define SWAPPER_BLOCK_SHIFT	PAGE_SHIFT
-#define SWAPPER_SKIP_LEVEL	0
-#endif
-#define SWAPPER_BLOCK_SIZE	(UL(1) << SWAPPER_BLOCK_SHIFT)
-#define SWAPPER_TABLE_SHIFT	(SWAPPER_BLOCK_SHIFT + PAGE_SHIFT - 3)
-
-#define SWAPPER_PGTABLE_LEVELS		(CONFIG_PGTABLE_LEVELS - SWAPPER_SKIP_LEVEL)
-#define INIT_IDMAP_PGTABLE_LEVELS	(IDMAP_LEVELS - SWAPPER_SKIP_LEVEL)
-
-#define IDMAP_VA_BITS		48
-#define IDMAP_LEVELS		ARM64_HW_PGTABLE_LEVELS(IDMAP_VA_BITS)
-#define IDMAP_ROOT_LEVEL	(4 - IDMAP_LEVELS)
+#define SWAPPER_BLOCK_SHIFT(page_shift)					\
+	((PGTABLE_LEVEL_SIZE(page_shift, 2) <= MIN_KIMG_ALIGN) ?	\
+		PGTABLE_LEVEL_SHIFT(page_shift, 2) : (page_shift))
+
+#define SWAPPER_SKIP_LEVEL(page_shift)					\
+	((PGTABLE_LEVEL_SIZE(page_shift, 2) <= MIN_KIMG_ALIGN) ? 1 : 0)
+
+#define SWAPPER_BLOCK_SIZE(page_shift)					\
+	(UL(1) << SWAPPER_BLOCK_SHIFT(page_shift))
+
+#define SWAPPER_PGTABLE_LEVELS(page_shift)				\
+	(PGTABLE_LEVELS(page_shift, VA_BITS) - SWAPPER_SKIP_LEVEL(page_shift))
+
+#define INIT_IDMAP_PGTABLE_LEVELS(page_shift)				\
+	(IDMAP_LEVELS(page_shift) - SWAPPER_SKIP_LEVEL(page_shift))
+
+#define IDMAP_VA_BITS			48
+#define IDMAP_LEVELS(page_shift)	PGTABLE_LEVELS(page_shift, IDMAP_VA_BITS)
+#define IDMAP_ROOT_LEVEL(page_shift)	(4 - IDMAP_LEVELS(page_shift))
 
 #define KIMAGE_VADDR_END	(_AT(u64, _end) - _AT(u64, _text) + KIMAGE_VADDR)
 
@@ -43,47 +53,99 @@
  * with two adjacent PGDIR entries, which means that an additional page table
  * may be needed at each subordinate level.
  */
-#define EXTRA_PAGE	__is_defined(CONFIG_RELOCATABLE)
+#define EXTRA_PAGE			__is_defined(CONFIG_RELOCATABLE)
 
-#define SPAN_NR_ENTRIES(vstart, vend, shift) \
+#define SPAN_NR_ENTRIES(vstart, vend, shift)				\
 	((((vend) - 1) >> (shift)) - ((vstart) >> (shift)) + 1)
 
-#define EARLY_ENTRIES(vstart, vend, shift, add) \
+#define EARLY_ENTRIES(vstart, vend, shift, add)				\
 	(SPAN_NR_ENTRIES(vstart, vend, shift) + (add))
 
-#define EARLY_LEVEL(lvl, lvls, vstart, vend, add)	\
-	(lvls > lvl ? EARLY_ENTRIES(vstart, vend, SWAPPER_BLOCK_SHIFT + lvl * (PAGE_SHIFT - 3), add) : 0)
-
-#define EARLY_PAGES(lvls, vstart, vend, add) (1 	/* PGDIR page */				\
-	+ EARLY_LEVEL(3, (lvls), (vstart), (vend), add) /* each entry needs a next level page table */	\
-	+ EARLY_LEVEL(2, (lvls), (vstart), (vend), add)	/* each entry needs a next level page table */	\
-	+ EARLY_LEVEL(1, (lvls), (vstart), (vend), add))/* each entry needs a next level page table */
-#define INIT_DIR_SIZE (PAGE_SIZE * (EARLY_PAGES(SWAPPER_PGTABLE_LEVELS, KIMAGE_VADDR, KIMAGE_VADDR_END, EXTRA_PAGE) \
-				    + EARLY_SEGMENT_EXTRA_PAGES))
-
-#define INIT_IDMAP_DIR_PAGES	(EARLY_PAGES(INIT_IDMAP_PGTABLE_LEVELS, KIMAGE_VADDR, KIMAGE_VADDR_END, 1))
-#define INIT_IDMAP_DIR_SIZE	((INIT_IDMAP_DIR_PAGES + EARLY_IDMAP_EXTRA_PAGES) * PAGE_SIZE)
+#define EARLY_LEVEL(page_shift, lvl, lvls, vstart, vend, add)		\
+	(lvls > lvl ? EARLY_ENTRIES(vstart, vend,			\
+		SWAPPER_BLOCK_SHIFT(page_shift) + lvl * ((page_shift) - 3), \
+		add) : 0)
 
-#define INIT_IDMAP_FDT_PAGES	(EARLY_PAGES(INIT_IDMAP_PGTABLE_LEVELS, 0UL, UL(MAX_FDT_SIZE), 1) - 1)
-#define INIT_IDMAP_FDT_SIZE	((INIT_IDMAP_FDT_PAGES + EARLY_IDMAP_EXTRA_FDT_PAGES) * PAGE_SIZE)
+#define EARLY_PAGES(page_shift, lvls, vstart, vend, add) (1 /* PGDIR */	\
+	+ EARLY_LEVEL((page_shift), 3, (lvls), (vstart), (vend), add)	\
+	+ EARLY_LEVEL((page_shift), 2, (lvls), (vstart), (vend), add)	\
+	+ EARLY_LEVEL((page_shift), 1, (lvls), (vstart), (vend), add))
 
 /* The number of segments in the kernel image (text, rodata, inittext, initdata, data+bss) */
-#define KERNEL_SEGMENT_COUNT	5
+#define KERNEL_SEGMENT_COUNT		5
 
-#if SWAPPER_BLOCK_SIZE > SEGMENT_ALIGN
-#define EARLY_SEGMENT_EXTRA_PAGES (KERNEL_SEGMENT_COUNT + 1)
 /*
  * The initial ID map consists of the kernel image, mapped as two separate
  * segments, and may appear misaligned wrt the swapper block size. This means
  * we need 3 additional pages. The DT could straddle a swapper block boundary,
  * so it may need 2.
  */
-#define EARLY_IDMAP_EXTRA_PAGES		3
-#define EARLY_IDMAP_EXTRA_FDT_PAGES	2
-#else
-#define EARLY_SEGMENT_EXTRA_PAGES	0
-#define EARLY_IDMAP_EXTRA_PAGES		0
-#define EARLY_IDMAP_EXTRA_FDT_PAGES	0
-#endif
+#define EARLY_SEGMENT_EXTRA_PAGES(page_shift)				\
+	((SWAPPER_BLOCK_SIZE(page_shift) > SEGMENT_ALIGN) ?		\
+		(KERNEL_SEGMENT_COUNT + 1) : 0)
+
+#define EARLY_IDMAP_EXTRA_PAGES(page_shift)				\
+	((SWAPPER_BLOCK_SIZE(page_shift) > SEGMENT_ALIGN) ? 3 : 0)
+
+#define EARLY_IDMAP_EXTRA_FDT_PAGES(page_shift)				\
+	((SWAPPER_BLOCK_SIZE(page_shift) > SEGMENT_ALIGN) ? 2 : 0)
+
+#define INIT_DIR_PAGES(page_shift)					\
+	(EARLY_PAGES((page_shift), SWAPPER_PGTABLE_LEVELS(page_shift),	\
+		KIMAGE_VADDR, KIMAGE_VADDR_END, EXTRA_PAGE))
+
+#define INIT_DIR_SIZE(page_shift)					\
+	((INIT_DIR_PAGES(page_shift) +					\
+	EARLY_SEGMENT_EXTRA_PAGES(page_shift)) * (UL(1) << (page_shift)))
+
+#define INIT_IDMAP_DIR_PAGES(page_shift)				\
+	(EARLY_PAGES((page_shift),					\
+		INIT_IDMAP_PGTABLE_LEVELS(page_shift),			\
+		KIMAGE_VADDR, KIMAGE_VADDR_END, 1))
+
+#define INIT_IDMAP_DIR_SIZE(page_shift)					\
+	((INIT_IDMAP_DIR_PAGES(page_shift) +				\
+	EARLY_IDMAP_EXTRA_PAGES(page_shift)) * (UL(1) << (page_shift)))
+
+#define INIT_IDMAP_FDT_PAGES(page_shift)				\
+	(EARLY_PAGES((page_shift),					\
+		INIT_IDMAP_PGTABLE_LEVELS(page_shift),			\
+		UL(0), UL(MAX_FDT_SIZE), 1) - 1)
+
+#define INIT_IDMAP_FDT_SIZE(page_shift)					\
+	((INIT_IDMAP_FDT_PAGES(page_shift) +				\
+	EARLY_IDMAP_EXTRA_FDT_PAGES(page_shift)) * (UL(1) << (page_shift)))
+
+#define VAL_IF_HAVE_PGSZ(val, page_shift)				\
+	((page_shift) >= PAGE_SHIFT_MIN &&				\
+	 (page_shift) <= PAGE_SHIFT_MAX ? (val) : 0)
+
+#define MAX_IF_HAVE_PGSZ(val4k, val16k, val64k)				\
+	MAX(VAL_IF_HAVE_PGSZ((val4k), ARM64_PAGE_SHIFT_4K), MAX(	\
+	    VAL_IF_HAVE_PGSZ((val16k), ARM64_PAGE_SHIFT_16K),		\
+	    VAL_IF_HAVE_PGSZ((val64k), ARM64_PAGE_SHIFT_64K)))
+
+#define IDMAP_LEVELS_MAX						\
+	MAX_IF_HAVE_PGSZ(IDMAP_LEVELS(ARM64_PAGE_SHIFT_4K),		\
+			 IDMAP_LEVELS(ARM64_PAGE_SHIFT_16K),		\
+			 IDMAP_LEVELS(ARM64_PAGE_SHIFT_64K))
+
+#define __INIT_DIR_SIZE_MAX						\
+	MAX_IF_HAVE_PGSZ(INIT_DIR_SIZE(ARM64_PAGE_SHIFT_4K),		\
+			 INIT_DIR_SIZE(ARM64_PAGE_SHIFT_16K),		\
+			 INIT_DIR_SIZE(ARM64_PAGE_SHIFT_64K))
+
+#define INIT_DIR_SIZE_MAX						\
+	MAX(__INIT_DIR_SIZE_MAX, INIT_IDMAP_DIR_SIZE_MAX)
+
+#define INIT_IDMAP_DIR_SIZE_MAX						\
+	MAX_IF_HAVE_PGSZ(INIT_IDMAP_DIR_SIZE(ARM64_PAGE_SHIFT_4K),	\
+			 INIT_IDMAP_DIR_SIZE(ARM64_PAGE_SHIFT_16K),	\
+			 INIT_IDMAP_DIR_SIZE(ARM64_PAGE_SHIFT_64K))
+
+#define INIT_IDMAP_FDT_SIZE_MAX						\
+	MAX_IF_HAVE_PGSZ(INIT_IDMAP_FDT_SIZE(ARM64_PAGE_SHIFT_4K),	\
+			 INIT_IDMAP_FDT_SIZE(ARM64_PAGE_SHIFT_16K),	\
+			 INIT_IDMAP_FDT_SIZE(ARM64_PAGE_SHIFT_64K))
 
 #endif	/* __ASM_KERNEL_PGTABLE_H */
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 54a9153f56bc5..ca8bcbc1fe220 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -23,7 +23,8 @@
  *
  * which gets simplified as :
  */
-#define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))
+#define __ARM64_HW_PGTABLE_LEVELS(page_shift, va_bits)	(((va_bits) - 4) / ((page_shift) - 3))
+#define ARM64_HW_PGTABLE_LEVELS(va_bits)		__ARM64_HW_PGTABLE_LEVELS(PAGE_SHIFT, va_bits)
 
 /*
  * Size mapped by an entry at level n ( -1 <= n <= 3)
@@ -38,7 +39,8 @@
  * Rearranging it a bit we get :
  *   (4 - n) * (PAGE_SHIFT - 3) + 3
  */
-#define ARM64_HW_PGTABLE_LEVEL_SHIFT(n)	((PAGE_SHIFT - 3) * (4 - (n)) + 3)
+#define __ARM64_HW_PGTABLE_LEVEL_SHIFT(page_shift, n)	(((page_shift) - 3) * (4 - (n)) + 3)
+#define ARM64_HW_PGTABLE_LEVEL_SHIFT(n)			__ARM64_HW_PGTABLE_LEVEL_SHIFT(PAGE_SHIFT, n)
 
 #define PTRS_PER_PTE		(1 << (PAGE_SHIFT - 3))
 #define MAX_PTRS_PER_PTE	(1 << (PAGE_SHIFT_MAX - 3))
diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index dcf9233ccfff2..a53fc225d2d0d 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -188,8 +188,8 @@ static void __init remap_idmap_for_lpa2(void)
 
 static void __init map_fdt(u64 fdt)
 {
-	static u8 ptes[INIT_IDMAP_FDT_SIZE] __initdata __aligned(PAGE_SIZE);
-	u64 limit = (u64)&ptes[INIT_IDMAP_FDT_SIZE];
+	static u8 ptes[INIT_IDMAP_FDT_SIZE_MAX] __initdata __aligned(PAGE_SIZE);
+	u64 limit = (u64)&ptes[INIT_IDMAP_FDT_SIZE_MAX];
 	u64 efdt = fdt + MAX_FDT_SIZE;
 	u64 ptep = (u64)ptes;
 
@@ -199,7 +199,7 @@ static void __init map_fdt(u64 fdt)
 	 */
 	map_range(&ptep, limit, fdt,
 		  (u64)_text > fdt ? min((u64)_text, efdt) : efdt,
-		  fdt, PAGE_KERNEL, IDMAP_ROOT_LEVEL,
+		  fdt, PAGE_KERNEL, IDMAP_ROOT_LEVEL(PAGE_SHIFT),
 		  (pte_t *)init_idmap_pg_dir, false, 0);
 	dsb(ishst);
 }
diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
index f0024d9b1d921..b62d2e3135f81 100644
--- a/arch/arm64/kernel/pi/map_range.c
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -131,11 +131,11 @@ asmlinkage u64 __init create_init_idmap(pgd_t *pg_dir, pgd_t *pg_end,
 	pgprot_val(data_prot) &= ~clrmask;
 
 	map_range(&ptep, (u64)pg_end, (u64)_stext, (u64)__initdata_begin,
-		  (u64)_stext, text_prot, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir,
-		  false, 0);
+		  (u64)_stext, text_prot,
+		  IDMAP_ROOT_LEVEL(PAGE_SHIFT), (pte_t *)pg_dir, false, 0);
 	map_range(&ptep, (u64)pg_end, (u64)__initdata_begin, (u64)_end,
-		  (u64)__initdata_begin, data_prot, IDMAP_ROOT_LEVEL,
-		  (pte_t *)pg_dir, false, 0);
+		  (u64)__initdata_begin, data_prot,
+		  IDMAP_ROOT_LEVEL(PAGE_SHIFT), (pte_t *)pg_dir, false, 0);
 
 	return ptep;
 }
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 55a8e310ea12c..7f3f6d709ae73 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -249,7 +249,7 @@ SECTIONS
 	__initdata_begin = .;
 
 	init_idmap_pg_dir = .;
-	. += INIT_IDMAP_DIR_SIZE;
+	. += INIT_IDMAP_DIR_SIZE_MAX;
 	init_idmap_pg_end = .;
 
 	.init.data : {
@@ -319,7 +319,7 @@ SECTIONS
 
 	. = ALIGN(PAGE_SIZE);
 	init_pg_dir = .;
-	. += INIT_DIR_SIZE;
+	. += INIT_DIR_SIZE_MAX;
 	init_pg_end = .;
 	/* end of zero-init region */
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 969348a2e93c9..d4d30eaefb4cd 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -777,19 +777,19 @@ void __pi_map_range(u64 *pgd, u64 limit, u64 start, u64 end, u64 pa,
 		    pgprot_t prot, int level, pte_t *tbl, bool may_use_cont,
 		    u64 va_offset);
 
-static u8 idmap_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
-	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
+static u8 idmap_ptes[IDMAP_LEVELS_MAX - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
+	  kpti_ptes[IDMAP_LEVELS_MAX - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
 
 static void __init create_idmap(void)
 {
 	u64 start = __pa_symbol(__idmap_text_start);
 	u64 end   = __pa_symbol(__idmap_text_end);
 	u64 ptep  = __pa_symbol(idmap_ptes);
-	u64 limit  = __pa_symbol(&idmap_ptes[IDMAP_LEVELS - 1][0]);
+	u64 limit  = __pa_symbol(&idmap_ptes[IDMAP_LEVELS_MAX - 1][0]);
 
 	__pi_map_range(&ptep, limit, start, end, start, PAGE_KERNEL_ROX,
-		       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
-		       __phys_to_virt(ptep) - ptep);
+		       IDMAP_ROOT_LEVEL(PAGE_SHIFT), (pte_t *)idmap_pg_dir,
+		       false, __phys_to_virt(ptep) - ptep);
 
 	if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) && !arm64_use_ng_mappings) {
 		extern u32 __idmap_kpti_flag;
@@ -800,9 +800,8 @@ static void __init create_idmap(void)
 		 * of its synchronization flag in the ID map.
 		 */
 		ptep = __pa_symbol(kpti_ptes);
-		limit  = __pa_symbol(&kpti_ptes[IDMAP_LEVELS - 1][0]);
 		__pi_map_range(&ptep, limit, pa, pa + sizeof(u32), pa,
-			       PAGE_KERNEL, IDMAP_ROOT_LEVEL,
+			       PAGE_KERNEL, IDMAP_ROOT_LEVEL(PAGE_SHIFT),
 			       (pte_t *)idmap_pg_dir, false,
 			       __phys_to_virt(ptep) - ptep);
 	}
-- 
2.43.0


