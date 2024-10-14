Return-Path: <linux-kernel+bounces-363892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B999C82D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CEBB25803
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372071D0F5D;
	Mon, 14 Oct 2024 11:01:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1921F19E7ED
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903710; cv=none; b=ZMemxbos6PgOYuBNt6NhZ2neXeHKDsDEZ4jvuFgQtF2bybvdgu37DlciuEJfRLgphUGqf4Zdzb0+x8kdzLGwRHNsToEc5OJpV6meNmOU2HtmonnT9XrYSWDeg/gPh++HLjOZUdVqqf6DypHylrPPu5vD0nvAZtnUBZDCEuLn2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903710; c=relaxed/simple;
	bh=sBsx2K4GxATWVZJSOcRSSsvMjk7bi1jITwvcQsL4Qfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bw6StZ4ca6A9KIdQ1AlR6gZAh1/3XO4YJ1fAUubGt+7Sz+ZBommMaETRE5/h+4+1yVPimrE8n3qA6HapcVgnnU7CcYeHEjj/F5lj9jUQhlSEo6zmZd91OINvfKJsg+SWzUPzE0RxEb5Du3Ht++iMSxY0u68IHok2eRsnzsRb/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E2C6176A;
	Mon, 14 Oct 2024 04:02:18 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FACB3F51B;
	Mon, 14 Oct 2024 04:01:45 -0700 (PDT)
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
Subject: [RFC PATCH v1 46/57] arm64: Generalize fixmap for boot-time page size
Date: Mon, 14 Oct 2024 11:58:53 +0100
Message-ID: <20241014105912.3207374-46-ryan.roberts@arm.com>
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

Some fixmap fixed address slots previously depended on PAGE_SIZE (i.e.
to determine how many slots were required to cover a given size). Since
we require the fixed address slots to be compile-time constant, let's
work out the worst case number of required slots when page size is
PAGE_SIZE_MIN instead.

Additionally, let's determine the worst-case number of PTE tables we
require and statically allocate enough memory.

For compile-time page size builds, the end result is the same as it was
previously.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/include/asm/fixmap.h | 12 ++++++++----
 arch/arm64/mm/fixmap.c          | 34 ++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 9a496d54dfe6e..c73fd3c1334ff 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -43,7 +43,7 @@ enum fixed_addresses {
 	 * whether it crosses any page boundary.
 	 */
 	FIX_FDT_END,
-	FIX_FDT = FIX_FDT_END + DIV_ROUND_UP(MAX_FDT_SIZE, PAGE_SIZE) + 1,
+	FIX_FDT = FIX_FDT_END + DIV_ROUND_UP(MAX_FDT_SIZE, PAGE_SIZE_MIN) + 1,
 
 	FIX_EARLYCON_MEM_BASE,
 	FIX_TEXT_POKE0,
@@ -79,7 +79,7 @@ enum fixed_addresses {
 	 * Temporary boot-time mappings, used by early_ioremap(),
 	 * before ioremap() is functional.
 	 */
-#define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
+#define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE_MIN)
 #define FIX_BTMAPS_SLOTS	7
 #define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
 
@@ -101,8 +101,12 @@ enum fixed_addresses {
 
 #define FIXADDR_SIZE		(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
-#define FIXADDR_TOT_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_TOT_START	(FIXADDR_TOP - FIXADDR_TOT_SIZE)
+#define __FIXADDR_TOT_SIZE(page_shift)					\
+	(__end_of_fixed_addresses << (page_shift))
+#define __FIXADDR_TOT_START(page_shift)					\
+	(FIXADDR_TOP - __FIXADDR_TOT_SIZE(page_shift))
+#define FIXADDR_TOT_SIZE	__FIXADDR_TOT_SIZE(PAGE_SHIFT)
+#define FIXADDR_TOT_START	__FIXADDR_TOT_START(PAGE_SHIFT)
 
 #define FIXMAP_PAGE_IO     __pgprot(PROT_DEVICE_nGnRE)
 
diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index 15ce3253ad359..a0dcf2375ccb4 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -17,27 +17,39 @@
 #include <asm/tlbflush.h>
 
 /* ensure that the fixmap region does not grow down into the PCI I/O region */
-static_assert(FIXADDR_TOT_START > PCI_IO_END);
+static_assert(__FIXADDR_TOT_START(PAGE_SHIFT_MAX) > PCI_IO_END);
 
-#define NR_BM_PTE_TABLES \
-	SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PMD_SHIFT)
-#define NR_BM_PMD_TABLES \
-	SPAN_NR_ENTRIES(FIXADDR_TOT_START, FIXADDR_TOP, PUD_SHIFT)
+#define FIXMAP_LEVEL(page_shift, lvl, vstart, vend)			\
+	SPAN_NR_ENTRIES(vstart, vend, PGTABLE_LEVEL_SHIFT(page_shift, lvl))
 
-static_assert(NR_BM_PMD_TABLES == 1);
+#define FIXMAP_PAGES(page_shift, level)					\
+	FIXMAP_LEVEL(page_shift, level,					\
+		     __FIXADDR_TOT_START(page_shift), FIXADDR_TOP)
+
+#define FIXMAP_SIZE(page_shift, level)					\
+	(FIXMAP_PAGES(page_shift, level) * (UL(1) << (page_shift)))
+
+#define FIXMAP_PTE_SIZE_MAX						\
+	MAX_IF_HAVE_PGSZ(FIXMAP_SIZE(ARM64_PAGE_SHIFT_4K, 2),		\
+			 FIXMAP_SIZE(ARM64_PAGE_SHIFT_16K, 2),		\
+			 FIXMAP_SIZE(ARM64_PAGE_SHIFT_64K, 2))
+
+static_assert(FIXMAP_PAGES(ARM64_PAGE_SHIFT_4K, 1) == 1);
+static_assert(FIXMAP_PAGES(ARM64_PAGE_SHIFT_16K, 1) == 1);
+static_assert(FIXMAP_PAGES(ARM64_PAGE_SHIFT_64K, 1) == 1);
 
 #define __BM_TABLE_IDX(addr, shift) \
 	(((addr) >> (shift)) - (FIXADDR_TOT_START >> (shift)))
 
 #define BM_PTE_TABLE_IDX(addr)	__BM_TABLE_IDX(addr, PMD_SHIFT)
 
-static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
-static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
-static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
+static pte_t bm_pte[FIXMAP_PTE_SIZE_MAX / sizeof(pte_t)] __page_aligned_bss;
+static pmd_t bm_pmd[MAX_PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
+static pud_t bm_pud[MAX_PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
 
 static inline pte_t *fixmap_pte(unsigned long addr)
 {
-	return &bm_pte[BM_PTE_TABLE_IDX(addr)][pte_index(addr)];
+	return &bm_pte[BM_PTE_TABLE_IDX(addr) * PTRS_PER_PTE + pte_index(addr)];
 }
 
 static void __init early_fixmap_init_pte(pmd_t *pmdp, unsigned long addr)
@@ -46,7 +58,7 @@ static void __init early_fixmap_init_pte(pmd_t *pmdp, unsigned long addr)
 	pte_t *ptep;
 
 	if (pmd_none(pmd)) {
-		ptep = bm_pte[BM_PTE_TABLE_IDX(addr)];
+		ptep = &bm_pte[BM_PTE_TABLE_IDX(addr) * PTRS_PER_PTE];
 		__pmd_populate(pmdp, __pa_symbol(ptep), PMD_TYPE_TABLE);
 	}
 }
-- 
2.43.0


