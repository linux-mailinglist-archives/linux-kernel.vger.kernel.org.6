Return-Path: <linux-kernel+bounces-544585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9B6A4E2C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3FF17D562
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59649280A3E;
	Tue,  4 Mar 2025 15:05:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC48278177
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100724; cv=none; b=O9e4ynmFvDVwvoOa7+7H1Mt0bGiHaLG/KFSkv5zw493dgrImW1akFoeYzl4rmdkhgHsDzAMeGUlqp8K/LFmpxyagnsqo39sQpPdYNJ5SPWwIclpxquOhCkBESe6ciAvO+kL5tpskZiuJ9LtlxjiihVKfxCZLJSghkg9z1B4tNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100724; c=relaxed/simple;
	bh=BizjNedsDUXt0gOAQ3mDk3IHO3CO31Z0uKt2z3hZ7AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPECtWhpsVkSePy2HJgaWWv7ZgMJNbL0I5hwJ32tpJYmnznDGsoRuUGj/SwEJ2Bw40QoUHciox3FPnNR9ytuDCWa98J4eXz6Jdt/tMpRpWRnMFQvq5I+HWoX6FhX18zytGZ8oUhk+SOA6J552k3km+ndFMQ9be36ua0KeTOGTP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F4C61C2B;
	Tue,  4 Mar 2025 07:05:30 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D33D3F66E;
	Tue,  4 Mar 2025 07:05:14 -0800 (PST)
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
Subject: [PATCH v3 10/11] mm/vmalloc: Enter lazy mmu mode while manipulating vmalloc ptes
Date: Tue,  4 Mar 2025 15:04:40 +0000
Message-ID: <20250304150444.3788920-11-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304150444.3788920-1-ryan.roberts@arm.com>
References: <20250304150444.3788920-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap vmalloc's pte table manipulation loops with
arch_enter_lazy_mmu_mode() / arch_leave_lazy_mmu_mode(). This provides
the arch code with the opportunity to optimize the pte manipulations.

Note that vmap_pfn() already uses lazy mmu mode since it delegates to
apply_to_page_range() which enters lazy mmu mode for both user and
kernel mappings.

These hooks will shortly be used by arm64 to improve vmalloc
performance.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/vmalloc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6111ce900ec4..b63ca0b7dd40 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -104,6 +104,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	pte = pte_alloc_kernel_track(pmd, addr, mask);
 	if (!pte)
 		return -ENOMEM;
+
+	arch_enter_lazy_mmu_mode();
+
 	do {
 		if (unlikely(!pte_none(ptep_get(pte)))) {
 			if (pfn_valid(pfn)) {
@@ -127,6 +130,8 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
 		pfn++;
 	} while (pte += PFN_DOWN(size), addr += size, addr != end);
+
+	arch_leave_lazy_mmu_mode();
 	*mask |= PGTBL_PTE_MODIFIED;
 	return 0;
 }
@@ -354,6 +359,8 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	unsigned long size = PAGE_SIZE;
 
 	pte = pte_offset_kernel(pmd, addr);
+	arch_enter_lazy_mmu_mode();
+
 	do {
 #ifdef CONFIG_HUGETLB_PAGE
 		size = arch_vmap_pte_range_unmap_size(addr, pte);
@@ -370,6 +377,8 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			ptent = ptep_get_and_clear(&init_mm, addr, pte);
 		WARN_ON(!pte_none(ptent) && !pte_present(ptent));
 	} while (pte += (size >> PAGE_SHIFT), addr += size, addr != end);
+
+	arch_leave_lazy_mmu_mode();
 	*mask |= PGTBL_PTE_MODIFIED;
 }
 
@@ -515,6 +524,9 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 	pte = pte_alloc_kernel_track(pmd, addr, mask);
 	if (!pte)
 		return -ENOMEM;
+
+	arch_enter_lazy_mmu_mode();
+
 	do {
 		struct page *page = pages[*nr];
 
@@ -528,6 +540,8 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
 		(*nr)++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);
+
+	arch_leave_lazy_mmu_mode();
 	*mask |= PGTBL_PTE_MODIFIED;
 	return 0;
 }
-- 
2.43.0


