Return-Path: <linux-kernel+bounces-517788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 030E6A385A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028DD172852
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C700522538B;
	Mon, 17 Feb 2025 14:08:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FC6224B13
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801330; cv=none; b=Il51uU1KrY9pZU42wrkpcQ3Czq5xarYG5J2rQCASU8UWlacCuKU+g/YH1T3G6w8inLtL4+XVQLYWjtVMf8AHTARmP+3Fsu1Lppy9kRLtOsKT2e+ZS4xpMoCmv5nVO5L/RiopObMy/E7QdLd0vbMe0hggPWtoBxCiDuPpobuEBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801330; c=relaxed/simple;
	bh=ch6bZEi6Ht07fUCsXeDpY6YzkgLQvobbfQJbhDWQOGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOmu74ZrAheccmKh56tvyd7RJXVnPfwyL6J0jvUwGQJol/iJRPMuoADPYattKnW1bPJBmdrFjjRHoTIgcSZ+6zWAbIXt5pELcuV9O1TA71JNJpIXbu9NvbrSTehvepySOJoWfrwaH9or9vhpoMTQLneowKSR/pgNQUPAMHg9sGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80BD71E5E;
	Mon, 17 Feb 2025 06:09:07 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 134433F6A8;
	Mon, 17 Feb 2025 06:08:45 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/14] mm/vmalloc: Batch arch_sync_kernel_mappings() more efficiently
Date: Mon, 17 Feb 2025 14:08:03 +0000
Message-ID: <20250217140809.1702789-12-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217140809.1702789-1-ryan.roberts@arm.com>
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When page_shift is greater than PAGE_SIZE, __vmap_pages_range_noflush()
will call vmap_range_noflush() for each individual huge page. But
vmap_range_noflush() would previously call arch_sync_kernel_mappings()
directly so this would end up being called for every huge page.

We can do better than this; refactor the call into the outer
__vmap_pages_range_noflush() so that it is only called once for the
entire batch operation.

This will benefit performance for arm64 which is about to opt-in to
using the hook.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/vmalloc.c | 60 ++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 68950b1824d0..50fd44439875 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -285,40 +285,38 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 
 static int vmap_range_noflush(unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift)
+			unsigned int max_page_shift, pgtbl_mod_mask *mask)
 {
 	pgd_t *pgd;
-	unsigned long start;
 	unsigned long next;
 	int err;
-	pgtbl_mod_mask mask = 0;
 
 	might_sleep();
 	BUG_ON(addr >= end);
 
-	start = addr;
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
 		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot,
-					max_page_shift, &mask);
+					max_page_shift, mask);
 		if (err)
 			break;
 	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
 
-	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
-		arch_sync_kernel_mappings(start, end);
-
 	return err;
 }
 
 int vmap_page_range(unsigned long addr, unsigned long end,
 		    phys_addr_t phys_addr, pgprot_t prot)
 {
+	pgtbl_mod_mask mask = 0;
 	int err;
 
 	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
-				 ioremap_max_page_shift);
+				 ioremap_max_page_shift, &mask);
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(addr, end);
+
 	flush_cache_vmap(addr, end);
 	if (!err)
 		err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
@@ -587,29 +585,24 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
 }
 
 static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
-		pgprot_t prot, struct page **pages)
+		pgprot_t prot, struct page **pages, pgtbl_mod_mask *mask)
 {
-	unsigned long start = addr;
 	pgd_t *pgd;
 	unsigned long next;
 	int err = 0;
 	int nr = 0;
-	pgtbl_mod_mask mask = 0;
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_bad(*pgd))
-			mask |= PGTBL_PGD_MODIFIED;
-		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
+			*mask |= PGTBL_PGD_MODIFIED;
+		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, mask);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
 
-	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
-		arch_sync_kernel_mappings(start, end);
-
 	return err;
 }
 
@@ -626,26 +619,33 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
 	unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
+	unsigned long start = addr;
+	pgtbl_mod_mask mask = 0;
+	int err = 0;
 
 	WARN_ON(page_shift < PAGE_SHIFT);
 
 	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
-			page_shift == PAGE_SHIFT)
-		return vmap_small_pages_range_noflush(addr, end, prot, pages);
-
-	for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
-		int err;
-
-		err = vmap_range_noflush(addr, addr + (1UL << page_shift),
-					page_to_phys(pages[i]), prot,
-					page_shift);
-		if (err)
-			return err;
+			page_shift == PAGE_SHIFT) {
+		err = vmap_small_pages_range_noflush(addr, end, prot, pages,
+						&mask);
+	} else {
+		for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
+			err = vmap_range_noflush(addr,
+						addr + (1UL << page_shift),
+						page_to_phys(pages[i]), prot,
+						page_shift, &mask);
+			if (err)
+				break;
 
-		addr += 1UL << page_shift;
+			addr += 1UL << page_shift;
+		}
 	}
 
-	return 0;
+	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
+		arch_sync_kernel_mappings(start, end);
+
+	return err;
 }
 
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-- 
2.43.0


