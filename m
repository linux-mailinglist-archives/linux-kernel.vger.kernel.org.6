Return-Path: <linux-kernel+bounces-555474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1872A5B821
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDD8172396
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EB21EB5E0;
	Tue, 11 Mar 2025 04:57:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B191DF25C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741669043; cv=none; b=P9EydT6v5xMCZi36+e2TfaxoA5QBsXuRA/UcRJL/F5xnoBGkRx+DIstGIW3KgCUx7OJkQCouEuttSTQJcIaHYi/pk9jqqDaZCp/rckdA4S2eVxx8A4wS5gxQComHSvTQtyUMsXBNdddvIGQSjQ8g2l8y8YzIqSI0CkPkG8yBSu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741669043; c=relaxed/simple;
	bh=rXhUkLtMfGtbeHk/9pXFSDm9IdTmvizK2Xo6Onf0wYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uR/JRgsSTuXf3iJMR5jm1YKcx+vI9+1uX1ppjwAGXyY1S0UfxDmR0lPY8hYnI8UC6BnkWzHSnfE/uSGGDDIBgoI7OaT6diwNlON8bSAieIz+KOxSKSmrOIlTPVz1ganrnO7Yj17jCBh37A1lWfJMFsp/Z6QZidKqv5ynW07tG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 027B01516;
	Mon, 10 Mar 2025 21:57:32 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 624C13F694;
	Mon, 10 Mar 2025 21:57:16 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Subject: [PATCH V3] arm64/mm: Define PTDESC_ORDER
Date: Tue, 11 Mar 2025 10:27:10 +0530
Message-Id: <20250311045710.550625-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address bytes shifted with a single 64 bit page table entry (any page table
level) has been always hard coded as 3 (aka 2^3 = 8). Although intuitive it
is not very readable or easy to reason about. Besides it is going to change
with D128, where each 128 bit page table entry will shift address bytes by
4 (aka 2^4 = 16) instead.

Let's just formalise this address bytes shift value into a new macro called
PTDESC_ORDER establishing a logical abstraction, thus improving readability
as well. While here re-organize EARLY_LEVEL macro along with its dependents
for better clarity. This does not cause any functional change. Also replace
all (PAGE_SHIFT - PTDESC_ORDER) instances with PTDESC_TABLE_SHIFT.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kasan-dev@googlegroups.com
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.14-rc6

Changes in V3:

- Moved PTDESC_TABLE_SHIFT definition inside asm/pgtable-hwdef.h
- Replaced all (PAGE_SHIFT - PTDESC_ORDER) instances with PTDESC_TABLE_SHIFT

Changes in V2:

https://lore.kernel.org/all/20250310040115.91298-1-anshuman.khandual@arm.com/

- Replaced PTE_SHIFT with PTDESC_ORDER per Ard
- Re-organized EARLY_LEVEL macro per Mark

Changes in V1:

https://lore.kernel.org/all/20250307050851.4034393-1-anshuman.khandual@arm.com/

 arch/arm64/Kconfig                      |  2 +-
 arch/arm64/include/asm/kernel-pgtable.h |  8 +++----
 arch/arm64/include/asm/pgtable-hwdef.h  | 30 +++++++++++++++----------
 arch/arm64/kernel/pi/map_range.c        |  2 +-
 arch/arm64/mm/kasan_init.c              |  6 ++---
 5 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4..c8f48945cc09 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -323,7 +323,7 @@ config ARCH_MMAP_RND_BITS_MIN
 	default 18
 
 # max bits determined by the following formula:
-#  VA_BITS - PAGE_SHIFT - 3
+#  VA_BITS - PTDESC_TABLE_SHIFT
 config ARCH_MMAP_RND_BITS_MAX
 	default 19 if ARM64_VA_BITS=36
 	default 24 if ARM64_VA_BITS=39
diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index fd5a08450b12..9e93733523f6 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -45,11 +45,11 @@
 #define SPAN_NR_ENTRIES(vstart, vend, shift) \
 	((((vend) - 1) >> (shift)) - ((vstart) >> (shift)) + 1)
 
-#define EARLY_ENTRIES(vstart, vend, shift, add) \
-	(SPAN_NR_ENTRIES(vstart, vend, shift) + (add))
+#define EARLY_ENTRIES(lvl, vstart, vend) \
+	SPAN_NR_ENTRIES(vstart, vend, SWAPPER_BLOCK_SHIFT + lvl * PTDESC_TABLE_SHIFT)
 
-#define EARLY_LEVEL(lvl, lvls, vstart, vend, add)	\
-	(lvls > lvl ? EARLY_ENTRIES(vstart, vend, SWAPPER_BLOCK_SHIFT + lvl * (PAGE_SHIFT - 3), add) : 0)
+#define EARLY_LEVEL(lvl, lvls, vstart, vend, add) \
+	((lvls) > (lvl) ? EARLY_ENTRIES(lvl, vstart, vend) + (add) : 0)
 
 #define EARLY_PAGES(lvls, vstart, vend, add) (1 	/* PGDIR page */				\
 	+ EARLY_LEVEL(3, (lvls), (vstart), (vend), add) /* each entry needs a next level page table */	\
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index a9136cc551cc..288964341404 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -7,40 +7,46 @@
 
 #include <asm/memory.h>
 
+#define PTDESC_ORDER 3
+
+/* Number of VA bits resolved by a single translation table level */
+#define PTDESC_TABLE_SHIFT	(PAGE_SHIFT - PTDESC_ORDER)
+
 /*
  * Number of page-table levels required to address 'va_bits' wide
  * address, without section mapping. We resolve the top (va_bits - PAGE_SHIFT)
- * bits with (PAGE_SHIFT - 3) bits at each page table level. Hence:
+ * bits with PTDESC_TABLE_SHIFT bits at each page table level. Hence:
  *
- *  levels = DIV_ROUND_UP((va_bits - PAGE_SHIFT), (PAGE_SHIFT - 3))
+ *  levels = DIV_ROUND_UP((va_bits - PAGE_SHIFT), PTDESC_TABLE_SHIFT)
  *
  * where DIV_ROUND_UP(n, d) => (((n) + (d) - 1) / (d))
  *
  * We cannot include linux/kernel.h which defines DIV_ROUND_UP here
  * due to build issues. So we open code DIV_ROUND_UP here:
  *
- *	((((va_bits) - PAGE_SHIFT) + (PAGE_SHIFT - 3) - 1) / (PAGE_SHIFT - 3))
+ *	((((va_bits) - PAGE_SHIFT) + PTDESC_TABLE_SHIFT - 1) / PTDESC_TABLE_SHIFT)
  *
  * which gets simplified as :
  */
-#define ARM64_HW_PGTABLE_LEVELS(va_bits) (((va_bits) - 4) / (PAGE_SHIFT - 3))
+#define ARM64_HW_PGTABLE_LEVELS(va_bits) \
+	(((va_bits) - PTDESC_ORDER - 1) / PTDESC_TABLE_SHIFT)
 
 /*
  * Size mapped by an entry at level n ( -1 <= n <= 3)
- * We map (PAGE_SHIFT - 3) at all translation levels and PAGE_SHIFT bits
+ * We map PTDESC_TABLE_SHIFT at all translation levels and PAGE_SHIFT bits
  * in the final page. The maximum number of translation levels supported by
  * the architecture is 5. Hence, starting at level n, we have further
  * ((4 - n) - 1) levels of translation excluding the offset within the page.
  * So, the total number of bits mapped by an entry at level n is :
  *
- *  ((4 - n) - 1) * (PAGE_SHIFT - 3) + PAGE_SHIFT
+ *  ((4 - n) - 1) * PTDESC_TABLE_SHIFT + PAGE_SHIFT
  *
  * Rearranging it a bit we get :
- *   (4 - n) * (PAGE_SHIFT - 3) + 3
+ *   (4 - n) * PTDESC_TABLE_SHIFT + PTDESC_ORDER
  */
-#define ARM64_HW_PGTABLE_LEVEL_SHIFT(n)	((PAGE_SHIFT - 3) * (4 - (n)) + 3)
+#define ARM64_HW_PGTABLE_LEVEL_SHIFT(n)	(PTDESC_TABLE_SHIFT * (4 - (n)) + PTDESC_ORDER)
 
-#define PTRS_PER_PTE		(1 << (PAGE_SHIFT - 3))
+#define PTRS_PER_PTE		(1 << PTDESC_TABLE_SHIFT)
 
 /*
  * PMD_SHIFT determines the size a level 2 page table entry can map.
@@ -49,7 +55,7 @@
 #define PMD_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
 #define PMD_SIZE		(_AC(1, UL) << PMD_SHIFT)
 #define PMD_MASK		(~(PMD_SIZE-1))
-#define PTRS_PER_PMD		(1 << (PAGE_SHIFT - 3))
+#define PTRS_PER_PMD		(1 << PTDESC_TABLE_SHIFT)
 #endif
 
 /*
@@ -59,14 +65,14 @@
 #define PUD_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(1)
 #define PUD_SIZE		(_AC(1, UL) << PUD_SHIFT)
 #define PUD_MASK		(~(PUD_SIZE-1))
-#define PTRS_PER_PUD		(1 << (PAGE_SHIFT - 3))
+#define PTRS_PER_PUD		(1 << PTDESC_TABLE_SHIFT)
 #endif
 
 #if CONFIG_PGTABLE_LEVELS > 4
 #define P4D_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(0)
 #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
 #define P4D_MASK		(~(P4D_SIZE-1))
-#define PTRS_PER_P4D		(1 << (PAGE_SHIFT - 3))
+#define PTRS_PER_P4D		(1 << PTDESC_TABLE_SHIFT)
 #endif
 
 /*
diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
index 2b69e3beeef8..dc68d09555b9 100644
--- a/arch/arm64/kernel/pi/map_range.c
+++ b/arch/arm64/kernel/pi/map_range.c
@@ -31,7 +31,7 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
 {
 	u64 cmask = (level == 3) ? CONT_PTE_SIZE - 1 : U64_MAX;
 	pteval_t protval = pgprot_val(prot) & ~PTE_TYPE_MASK;
-	int lshift = (3 - level) * (PAGE_SHIFT - 3);
+	int lshift = (3 - level) * PTDESC_TABLE_SHIFT;
 	u64 lmask = (PAGE_SIZE << lshift) - 1;
 
 	start	&= PAGE_MASK;
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index b65a29440a0c..d541ce45daeb 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -190,7 +190,7 @@ static void __init kasan_pgd_populate(unsigned long addr, unsigned long end,
  */
 static bool __init root_level_aligned(u64 addr)
 {
-	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits_actual) - 1) * (PAGE_SHIFT - 3);
+	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits_actual) - 1) * PTDESC_TABLE_SHIFT;
 
 	return (addr % (PAGE_SIZE << shift)) == 0;
 }
@@ -245,7 +245,7 @@ static int __init root_level_idx(u64 addr)
 	 */
 	u64 vabits = IS_ENABLED(CONFIG_ARM64_64K_PAGES) ? VA_BITS
 							: vabits_actual;
-	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits) - 1) * (PAGE_SHIFT - 3);
+	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits) - 1) * PTDESC_TABLE_SHIFT;
 
 	return (addr & ~_PAGE_OFFSET(vabits)) >> (shift + PAGE_SHIFT);
 }
@@ -269,7 +269,7 @@ static void __init clone_next_level(u64 addr, pgd_t *tmp_pg_dir, pud_t *pud)
  */
 static int __init next_level_idx(u64 addr)
 {
-	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits_actual) - 2) * (PAGE_SHIFT - 3);
+	int shift = (ARM64_HW_PGTABLE_LEVELS(vabits_actual) - 2) * PTDESC_TABLE_SHIFT;
 
 	return (addr >> (shift + PAGE_SHIFT)) % PTRS_PER_PTE;
 }
-- 
2.25.1


