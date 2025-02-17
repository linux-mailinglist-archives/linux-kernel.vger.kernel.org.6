Return-Path: <linux-kernel+bounces-517782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E6A38596
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D0C1893377
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD021D3DB;
	Mon, 17 Feb 2025 14:08:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32B9221575
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801315; cv=none; b=IN6OVGm61I44KjBPHfb2HoIh6q0U35cqv9McX+Vdg8MARQ/jVrbYOPf4VAlxGU8p+/DOtqYoSbU4hrO4ihv1MfUnC+Fhx2NK0ZTAbsNUXj2EYXCBZTrzGfGEznZDmZS+KdnpRrKukfq0ou9/X9ZwvDvFU83Dg606Nre9hr/NEO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801315; c=relaxed/simple;
	bh=pkdur6oh1pZgYmO+n4Hrxc231s4U4fT7LsTlsJhAADU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eo/Va+cEX6FMdcuzKnL983mhcVkii0ab+9k1T/4suTYUBZbPIuCBR1QPY2Ah02kEo5EdJS2fXy4xYRKaZgSCICIQvruE9CrdSvO6xiuVGGoPcWjvYjf4ELPi3RNw97W++el+Zk3kHvwr11TT0Jw706STgam+5vRwdWdUVXP9/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45EC71A2D;
	Mon, 17 Feb 2025 06:08:52 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC4143F6A8;
	Mon, 17 Feb 2025 06:08:30 -0800 (PST)
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
Subject: [PATCH v2 05/14] arm64: hugetlb: Use set_ptes_anysz() and ptep_get_and_clear_anysz()
Date: Mon, 17 Feb 2025 14:07:57 +0000
Message-ID: <20250217140809.1702789-6-ryan.roberts@arm.com>
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

Refactor the huge_pte helpers to use the new common set_ptes_anysz() and
ptep_get_and_clear_anysz() APIs.

This provides 2 benefits; First, when page_table_check=on, hugetlb is
now properly/fully checked. Previously only the first page of a hugetlb
folio was checked. Second, instead of having to call __set_ptes(nr=1)
for each pte in a loop, the whole contiguous batch can now be set in one
go, which enables some efficiencies and cleans up the code.

One detail to note is that huge_ptep_clear_flush() was previously
calling ptep_clear_flush() for a non-contiguous pte (i.e. a pud or pmd
block mapping). This has a couple of disadvantages; first
ptep_clear_flush() calls ptep_get_and_clear() which transparently
handles contpte. Given we only call for non-contiguous ptes, it would be
safe, but a waste of effort. It's preferable to go straight to the layer
below. However, more problematic is that ptep_get_and_clear() is for
PAGE_SIZE entries so it calls page_table_check_pte_clear() and would not
clear the whole hugetlb folio. So let's stop special-casing the non-cont
case and just rely on get_clear_contig_flush() to do the right thing for
non-cont entries.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 52 +++++++------------------------------
 1 file changed, 10 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index b7434ed1b93b..8ac86cd180b3 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -166,12 +166,12 @@ static pte_t get_clear_contig(struct mm_struct *mm,
 	pte_t pte, tmp_pte;
 	bool present;
 
-	pte = __ptep_get_and_clear(mm, addr, ptep);
+	pte = ptep_get_and_clear_anysz(mm, ptep, pgsize);
 	present = pte_present(pte);
 	while (--ncontig) {
 		ptep++;
 		addr += pgsize;
-		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
+		tmp_pte = ptep_get_and_clear_anysz(mm, ptep, pgsize);
 		if (present) {
 			if (pte_dirty(tmp_pte))
 				pte = pte_mkdirty(pte);
@@ -215,7 +215,7 @@ static void clear_flush(struct mm_struct *mm,
 	unsigned long i, saddr = addr;
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		__ptep_get_and_clear(mm, addr, ptep);
+		ptep_get_and_clear_anysz(mm, ptep, pgsize);
 
 	__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, true);
 }
@@ -226,32 +226,20 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	size_t pgsize;
 	int i;
 	int ncontig;
-	unsigned long pfn, dpfn;
-	pgprot_t hugeprot;
 
 	ncontig = num_contig_ptes(sz, &pgsize);
 
 	if (!pte_present(pte)) {
 		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
-			__set_ptes(mm, addr, ptep, pte, 1);
+			set_ptes_anysz(mm, ptep, pte, 1, pgsize);
 		return;
 	}
 
-	if (!pte_cont(pte)) {
-		__set_ptes(mm, addr, ptep, pte, 1);
-		return;
-	}
-
-	pfn = pte_pfn(pte);
-	dpfn = pgsize >> PAGE_SHIFT;
-	hugeprot = pte_pgprot(pte);
-
 	/* Only need to "break" if transitioning valid -> valid. */
-	if (pte_valid(__ptep_get(ptep)))
+	if (pte_cont(pte) && pte_valid(__ptep_get(ptep)))
 		clear_flush(mm, addr, ptep, pgsize, ncontig);
 
-	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		__set_ptes(mm, addr, ptep, pfn_pte(pfn, hugeprot), 1);
+	set_ptes_anysz(mm, ptep, pte, ncontig, pgsize);
 }
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -441,11 +429,9 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       unsigned long addr, pte_t *ptep,
 			       pte_t pte, int dirty)
 {
-	int ncontig, i;
+	int ncontig;
 	size_t pgsize = 0;
-	unsigned long pfn = pte_pfn(pte), dpfn;
 	struct mm_struct *mm = vma->vm_mm;
-	pgprot_t hugeprot;
 	pte_t orig_pte;
 
 	VM_WARN_ON(!pte_present(pte));
@@ -454,7 +440,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 		return __ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 
 	ncontig = num_contig_ptes(huge_page_size(hstate_vma(vma)), &pgsize);
-	dpfn = pgsize >> PAGE_SHIFT;
 
 	if (!__cont_access_flags_changed(ptep, pte, ncontig))
 		return 0;
@@ -469,19 +454,14 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	if (pte_young(orig_pte))
 		pte = pte_mkyoung(pte);
 
-	hugeprot = pte_pgprot(pte);
-	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		__set_ptes(mm, addr, ptep, pfn_pte(pfn, hugeprot), 1);
-
+	set_ptes_anysz(mm, ptep, pte, ncontig, pgsize);
 	return 1;
 }
 
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     unsigned long addr, pte_t *ptep)
 {
-	unsigned long pfn, dpfn;
-	pgprot_t hugeprot;
-	int ncontig, i;
+	int ncontig;
 	size_t pgsize;
 	pte_t pte;
 
@@ -494,16 +474,11 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	}
 
 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-	dpfn = pgsize >> PAGE_SHIFT;
 
 	pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
 	pte = pte_wrprotect(pte);
 
-	hugeprot = pte_pgprot(pte);
-	pfn = pte_pfn(pte);
-
-	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		__set_ptes(mm, addr, ptep, pfn_pte(pfn, hugeprot), 1);
+	set_ptes_anysz(mm, ptep, pte, ncontig, pgsize);
 }
 
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
@@ -512,13 +487,6 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 	size_t pgsize;
 	int ncontig;
-	pte_t pte;
-
-	pte = __ptep_get(ptep);
-	VM_WARN_ON(!pte_present(pte));
-
-	if (!pte_cont(pte))
-		return ptep_clear_flush(vma, addr, ptep);
 
 	ncontig = num_contig_ptes(huge_page_size(hstate_vma(vma)), &pgsize);
 	return get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
-- 
2.43.0


