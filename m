Return-Path: <linux-kernel+bounces-544580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13B5A4E2BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CCA42088B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11CE283C94;
	Tue,  4 Mar 2025 15:05:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C2C24C09F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100708; cv=none; b=IcwnCNztsju++G2SqF+LNfwsT/V1dsZ7TslWpH5m72oMU7y2wepYbks0r/2FeyxGy263vNTm0k3R5+zXI40jj1WNlbj0dtdr4miaWQgQ+zn9CZkTedyxEUZjHJc/BqUa21wrC+3EkbJMKJ/qRut7ykmmKEb2E8bICaLjYIfxvWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100708; c=relaxed/simple;
	bh=7WJEfMZkzJg+EQyI2R+8IAQMA4v5MI5fpcvLDS0yhyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCjou2S1MJmCvsaih15jsHYkCuTRxb5Fytdt74RhrY80BXl+5kRjIdWOLAGRYi/d4AkMNPLpPTD+mnv1zkOWOPE/CbMaq8IXalYoAAt/EByExOrbtW00Jp2RlrHKUr/6gxlZLQdaPR0crFrZ8VrytgRcWUjlZySAUw21kL0Ewq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75EFD1C2B;
	Tue,  4 Mar 2025 07:05:19 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E43683F66E;
	Tue,  4 Mar 2025 07:05:03 -0800 (PST)
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
Subject: [PATCH v3 05/11] arm64: hugetlb: Use set_ptes_anysz() and ptep_get_and_clear_anysz()
Date: Tue,  4 Mar 2025 15:04:35 +0000
Message-ID: <20250304150444.3788920-6-ryan.roberts@arm.com>
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
index 065be8650aa5..efd18bd1eae3 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -159,12 +159,12 @@ static pte_t get_clear_contig(struct mm_struct *mm,
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
@@ -208,7 +208,7 @@ static void clear_flush(struct mm_struct *mm,
 	unsigned long i, saddr = addr;
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		__ptep_get_and_clear(mm, addr, ptep);
+		ptep_get_and_clear_anysz(mm, ptep, pgsize);
 
 	__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, true);
 }
@@ -219,32 +219,20 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
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
@@ -434,11 +422,9 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
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
@@ -447,7 +433,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 		return __ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 
 	ncontig = num_contig_ptes(huge_page_size(hstate_vma(vma)), &pgsize);
-	dpfn = pgsize >> PAGE_SHIFT;
 
 	if (!__cont_access_flags_changed(ptep, pte, ncontig))
 		return 0;
@@ -462,19 +447,14 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
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
 
@@ -487,16 +467,11 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
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
@@ -505,13 +480,6 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
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


