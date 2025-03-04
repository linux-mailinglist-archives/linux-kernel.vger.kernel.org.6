Return-Path: <linux-kernel+bounces-544579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57192A4E2B6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C4317D767
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D5725DB16;
	Tue,  4 Mar 2025 15:05:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F3324C086
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100706; cv=none; b=ffjBAov3U2EVRga268+YPsP9E8kjVDb577d5dE59tQf7i/cWScnUwzir5K1/hCYPgBfdRlYetVaN+9tAxiWrHW3Bz5aab7X/17IHGzGrPoPxCk4r/WvfVUqB4QlLXtUqDqM+E2TQKohfChUvfHVBK3vRsM9LkPghCmhsX9JnbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100706; c=relaxed/simple;
	bh=RP0eyjcaLDQTxV/AGDfVfA6Dk85D3xwNK3gK9+8GOM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OT2/77ggentQ3DsQzKc25irpNUrglY80ue6ceyCmf6PZPoGkwkzoDwjYXbgWBbLT35hKaQHPKQ8NzmugIWHUUsYfTckgnjy58rE8clC4DkecdIGYi2ULxytlAGq6ZeSGgYBe671B8RKdMNMrakaoqo1csbXSdbDVWrLsT3bn6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5626F1007;
	Tue,  4 Mar 2025 07:05:17 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C43DD3F66E;
	Tue,  4 Mar 2025 07:05:01 -0800 (PST)
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
Subject: [PATCH v3 04/11] arm64/mm: Refactor __set_ptes() and __ptep_get_and_clear()
Date: Tue,  4 Mar 2025 15:04:34 +0000
Message-ID: <20250304150444.3788920-5-ryan.roberts@arm.com>
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

Refactor __set_ptes(), set_pmd_at() and set_pud_at() so that they are
all a thin wrapper around a new common set_ptes_anysz(), which takes
pgsize parameter. Additionally, refactor __ptep_get_and_clear() and
pmdp_huge_get_and_clear() to use a new common ptep_get_and_clear_anysz()
which also takes a pgsize parameter.

These changes will permit the huge_pte API to efficiently batch-set
pgtable entries and take advantage of the future barrier optimizations.
Additionally since the new *_anysz() helpers call the correct
page_table_check_*_set() API based on pgsize, this means that huge_ptes
will be able to get proper coverage. Currently the huge_pte API always
uses the pte API which assumes an entry only covers a single page.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 108 +++++++++++++++++++------------
 1 file changed, 67 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b2a2ad1b9e8..e255a36380dc 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -420,23 +420,6 @@ static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
 	return pfn_pte(pte_pfn(pte) + nr, pte_pgprot(pte));
 }
 
-static inline void __set_ptes(struct mm_struct *mm,
-			      unsigned long __always_unused addr,
-			      pte_t *ptep, pte_t pte, unsigned int nr)
-{
-	page_table_check_ptes_set(mm, ptep, pte, nr);
-	__sync_cache_and_tags(pte, nr);
-
-	for (;;) {
-		__check_safe_pte_update(mm, ptep, pte);
-		__set_pte(ptep, pte);
-		if (--nr == 0)
-			break;
-		ptep++;
-		pte = pte_advance_pfn(pte, 1);
-	}
-}
-
 /*
  * Hugetlb definitions.
  */
@@ -641,30 +624,59 @@ static inline pgprot_t pud_pgprot(pud_t pud)
 	return __pgprot(pud_val(pfn_pud(pfn, __pgprot(0))) ^ pud_val(pud));
 }
 
-static inline void __set_pte_at(struct mm_struct *mm,
-				unsigned long __always_unused addr,
-				pte_t *ptep, pte_t pte, unsigned int nr)
+static inline void set_ptes_anysz(struct mm_struct *mm, pte_t *ptep, pte_t pte,
+				  unsigned int nr, unsigned long pgsize)
 {
-	__sync_cache_and_tags(pte, nr);
-	__check_safe_pte_update(mm, ptep, pte);
-	__set_pte(ptep, pte);
+	unsigned long stride = pgsize >> PAGE_SHIFT;
+
+	switch (pgsize) {
+	case PAGE_SIZE:
+		page_table_check_ptes_set(mm, ptep, pte, nr);
+		break;
+	case PMD_SIZE:
+		page_table_check_pmds_set(mm, (pmd_t *)ptep, pte_pmd(pte), nr);
+		break;
+	case PUD_SIZE:
+		page_table_check_puds_set(mm, (pud_t *)ptep, pte_pud(pte), nr);
+		break;
+	default:
+		VM_WARN_ON(1);
+	}
+
+	__sync_cache_and_tags(pte, nr * stride);
+
+	for (;;) {
+		__check_safe_pte_update(mm, ptep, pte);
+		__set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte = pte_advance_pfn(pte, stride);
+	}
 }
 
-static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
-			      pmd_t *pmdp, pmd_t pmd)
+static inline void __set_ptes(struct mm_struct *mm,
+			      unsigned long __always_unused addr,
+			      pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	page_table_check_pmd_set(mm, pmdp, pmd);
-	return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd),
-						PMD_SIZE >> PAGE_SHIFT);
+	set_ptes_anysz(mm, ptep, pte, nr, PAGE_SIZE);
 }
 
-static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
-			      pud_t *pudp, pud_t pud)
+static inline void __set_pmds(struct mm_struct *mm,
+			      unsigned long __always_unused addr,
+			      pmd_t *pmdp, pmd_t pmd, unsigned int nr)
+{
+	set_ptes_anysz(mm, (pte_t *)pmdp, pmd_pte(pmd), nr, PMD_SIZE);
+}
+#define set_pmd_at(mm, addr, pmdp, pmd) __set_pmds(mm, addr, pmdp, pmd, 1)
+
+static inline void __set_puds(struct mm_struct *mm,
+			      unsigned long __always_unused addr,
+			      pud_t *pudp, pud_t pud, unsigned int nr)
 {
-	page_table_check_pud_set(mm, pudp, pud);
-	return __set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud),
-						PUD_SIZE >> PAGE_SHIFT);
+	set_ptes_anysz(mm, (pte_t *)pudp, pud_pte(pud), nr, PUD_SIZE);
 }
+#define set_pud_at(mm, addr, pudp, pud) __set_puds(mm, addr, pudp, pud, 1)
 
 #define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
 #define __phys_to_p4d_val(phys)	__phys_to_pte_val(phys)
@@ -1276,16 +1288,34 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG */
 
-static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
-				       unsigned long address, pte_t *ptep)
+static inline pte_t ptep_get_and_clear_anysz(struct mm_struct *mm, pte_t *ptep,
+					     unsigned long pgsize)
 {
 	pte_t pte = __pte(xchg_relaxed(&pte_val(*ptep), 0));
 
-	page_table_check_pte_clear(mm, pte);
+	switch (pgsize) {
+	case PAGE_SIZE:
+		page_table_check_pte_clear(mm, pte);
+		break;
+	case PMD_SIZE:
+		page_table_check_pmd_clear(mm, pte_pmd(pte));
+		break;
+	case PUD_SIZE:
+		page_table_check_pud_clear(mm, pte_pud(pte));
+		break;
+	default:
+		VM_WARN_ON(1);
+	}
 
 	return pte;
 }
 
+static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
+				       unsigned long address, pte_t *ptep)
+{
+	return ptep_get_and_clear_anysz(mm, ptep, PAGE_SIZE);
+}
+
 static inline void __clear_full_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, unsigned int nr, int full)
 {
@@ -1322,11 +1352,7 @@ static inline pte_t __get_and_clear_full_ptes(struct mm_struct *mm,
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address, pmd_t *pmdp)
 {
-	pmd_t pmd = __pmd(xchg_relaxed(&pmd_val(*pmdp), 0));
-
-	page_table_check_pmd_clear(mm, pmd);
-
-	return pmd;
+	return pte_pmd(ptep_get_and_clear_anysz(mm, (pte_t *)pmdp, PMD_SIZE));
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-- 
2.43.0


