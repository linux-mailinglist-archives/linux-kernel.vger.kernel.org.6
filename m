Return-Path: <linux-kernel+bounces-323005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AF297368A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9F71F25C61
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041BB18F2DB;
	Tue, 10 Sep 2024 11:58:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A06189BA4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969483; cv=none; b=m7Nej1O9V1MGVOgb6UKKBXLclC/d8GtHjoU6GXjCfg+IHBMZxmA4RyDeDxmShuMjZc8SldONWfDny5x5/KsV1Kv6DujLZvtibO2EM9MYUz4u+lPqOQkArcPePgk+nSri9WvFsJ6IcXLrXohzMORgJuF2xoa0pdUtjndua4i0NiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969483; c=relaxed/simple;
	bh=7/XSPNXotBzs7z666cnvZUX4kelMfqYm55CRFQlNM+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LsjALztMpJJEmLEpOlWYVn6Sxtb9LFFT2G5CyVXC/FDRhYqiAmxzU2bvfaWvDngavIx0ZOYdut8et8TB2LVcM9sXUcw9lFlUoc614bu+z7T+J7bxx8Y5RLFsDxXz5UL9Tdr3S+X/jbyJZkdwawvsqRZjovX+y6Ie2QzjTtuBgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4D6A113E;
	Tue, 10 Sep 2024 04:58:28 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.63.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C47F93F64C;
	Tue, 10 Sep 2024 04:57:56 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/debug_vm_pgtable: Use pxdp_get() for accessing page table entries
Date: Tue, 10 Sep 2024 17:27:46 +0530
Message-Id: <20240910115746.514454-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replaces all the existing READ_ONCE() based page table accesses with
respective pxdp_get() helpers. Although these helpers might also fallback
to READ_ONCE() as default, but they do provide an opportunity for various
platforms to override when required. This change is a step in direction to
replace all page table entry accesses with respective pxdp_get() helpers.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index e4969fb54da3..bc748f700a9e 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -231,10 +231,10 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
 	flush_dcache_page(page);
 	pmdp_set_wrprotect(args->mm, vaddr, args->pmdp);
-	pmd = READ_ONCE(*args->pmdp);
+	pmd = pmdp_get(args->pmdp);
 	WARN_ON(pmd_write(pmd));
 	pmdp_huge_get_and_clear(args->mm, vaddr, args->pmdp);
-	pmd = READ_ONCE(*args->pmdp);
+	pmd = pmdp_get(args->pmdp);
 	WARN_ON(!pmd_none(pmd));
 
 	pmd = pfn_pmd(args->pmd_pfn, args->page_prot);
@@ -245,10 +245,10 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 	pmd = pmd_mkwrite(pmd, args->vma);
 	pmd = pmd_mkdirty(pmd);
 	pmdp_set_access_flags(args->vma, vaddr, args->pmdp, pmd, 1);
-	pmd = READ_ONCE(*args->pmdp);
+	pmd = pmdp_get(args->pmdp);
 	WARN_ON(!(pmd_write(pmd) && pmd_dirty(pmd)));
 	pmdp_huge_get_and_clear_full(args->vma, vaddr, args->pmdp, 1);
-	pmd = READ_ONCE(*args->pmdp);
+	pmd = pmdp_get(args->pmdp);
 	WARN_ON(!pmd_none(pmd));
 
 	pmd = pmd_mkhuge(pfn_pmd(args->pmd_pfn, args->page_prot));
@@ -256,7 +256,7 @@ static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
 	set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
 	flush_dcache_page(page);
 	pmdp_test_and_clear_young(args->vma, vaddr, args->pmdp);
-	pmd = READ_ONCE(*args->pmdp);
+	pmd = pmdp_get(args->pmdp);
 	WARN_ON(pmd_young(pmd));
 
 	/*  Clear the pte entries  */
@@ -357,12 +357,12 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
 	flush_dcache_page(page);
 	pudp_set_wrprotect(args->mm, vaddr, args->pudp);
-	pud = READ_ONCE(*args->pudp);
+	pud = pudp_get(args->pudp);
 	WARN_ON(pud_write(pud));
 
 #ifndef __PAGETABLE_PMD_FOLDED
 	pudp_huge_get_and_clear(args->mm, vaddr, args->pudp);
-	pud = READ_ONCE(*args->pudp);
+	pud = pudp_get(args->pudp);
 	WARN_ON(!pud_none(pud));
 #endif /* __PAGETABLE_PMD_FOLDED */
 	pud = pfn_pud(args->pud_pfn, args->page_prot);
@@ -374,12 +374,12 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	pud = pud_mkwrite(pud);
 	pud = pud_mkdirty(pud);
 	pudp_set_access_flags(args->vma, vaddr, args->pudp, pud, 1);
-	pud = READ_ONCE(*args->pudp);
+	pud = pudp_get(args->pudp);
 	WARN_ON(!(pud_write(pud) && pud_dirty(pud)));
 
 #ifndef __PAGETABLE_PMD_FOLDED
 	pudp_huge_get_and_clear_full(args->vma, vaddr, args->pudp, 1);
-	pud = READ_ONCE(*args->pudp);
+	pud = pudp_get(args->pudp);
 	WARN_ON(!pud_none(pud));
 #endif /* __PAGETABLE_PMD_FOLDED */
 
@@ -389,7 +389,7 @@ static void __init pud_advanced_tests(struct pgtable_debug_args *args)
 	set_pud_at(args->mm, vaddr, args->pudp, pud);
 	flush_dcache_page(page);
 	pudp_test_and_clear_young(args->vma, vaddr, args->pudp);
-	pud = READ_ONCE(*args->pudp);
+	pud = pudp_get(args->pudp);
 	WARN_ON(pud_young(pud));
 
 	pudp_huge_get_and_clear(args->mm, vaddr, args->pudp);
@@ -441,7 +441,7 @@ static void __init pmd_huge_tests(struct pgtable_debug_args *args)
 	WRITE_ONCE(*args->pmdp, __pmd(0));
 	WARN_ON(!pmd_set_huge(args->pmdp, __pfn_to_phys(args->fixed_pmd_pfn), args->page_prot));
 	WARN_ON(!pmd_clear_huge(args->pmdp));
-	pmd = READ_ONCE(*args->pmdp);
+	pmd = pmdp_get(args->pmdp);
 	WARN_ON(!pmd_none(pmd));
 }
 
@@ -461,7 +461,7 @@ static void __init pud_huge_tests(struct pgtable_debug_args *args)
 	WRITE_ONCE(*args->pudp, __pud(0));
 	WARN_ON(!pud_set_huge(args->pudp, __pfn_to_phys(args->fixed_pud_pfn), args->page_prot));
 	WARN_ON(!pud_clear_huge(args->pudp));
-	pud = READ_ONCE(*args->pudp);
+	pud = pudp_get(args->pudp);
 	WARN_ON(!pud_none(pud));
 }
 #else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
@@ -490,7 +490,7 @@ static void __init pgd_basic_tests(struct pgtable_debug_args *args)
 #ifndef __PAGETABLE_PUD_FOLDED
 static void __init pud_clear_tests(struct pgtable_debug_args *args)
 {
-	pud_t pud = READ_ONCE(*args->pudp);
+	pud_t pud = pudp_get(args->pudp);
 
 	if (mm_pmd_folded(args->mm))
 		return;
@@ -498,7 +498,7 @@ static void __init pud_clear_tests(struct pgtable_debug_args *args)
 	pr_debug("Validating PUD clear\n");
 	WARN_ON(pud_none(pud));
 	pud_clear(args->pudp);
-	pud = READ_ONCE(*args->pudp);
+	pud = pudp_get(args->pudp);
 	WARN_ON(!pud_none(pud));
 }
 
@@ -515,7 +515,7 @@ static void __init pud_populate_tests(struct pgtable_debug_args *args)
 	 * Hence this must not qualify as pud_bad().
 	 */
 	pud_populate(args->mm, args->pudp, args->start_pmdp);
-	pud = READ_ONCE(*args->pudp);
+	pud = pudp_get(args->pudp);
 	WARN_ON(pud_bad(pud));
 }
 #else  /* !__PAGETABLE_PUD_FOLDED */
@@ -526,7 +526,7 @@ static void __init pud_populate_tests(struct pgtable_debug_args *args) { }
 #ifndef __PAGETABLE_P4D_FOLDED
 static void __init p4d_clear_tests(struct pgtable_debug_args *args)
 {
-	p4d_t p4d = READ_ONCE(*args->p4dp);
+	p4d_t p4d = p4dp_get(args->p4dp);
 
 	if (mm_pud_folded(args->mm))
 		return;
@@ -534,7 +534,7 @@ static void __init p4d_clear_tests(struct pgtable_debug_args *args)
 	pr_debug("Validating P4D clear\n");
 	WARN_ON(p4d_none(p4d));
 	p4d_clear(args->p4dp);
-	p4d = READ_ONCE(*args->p4dp);
+	p4d = p4dp_get(args->p4dp);
 	WARN_ON(!p4d_none(p4d));
 }
 
@@ -553,13 +553,13 @@ static void __init p4d_populate_tests(struct pgtable_debug_args *args)
 	pud_clear(args->pudp);
 	p4d_clear(args->p4dp);
 	p4d_populate(args->mm, args->p4dp, args->start_pudp);
-	p4d = READ_ONCE(*args->p4dp);
+	p4d = p4dp_get(args->p4dp);
 	WARN_ON(p4d_bad(p4d));
 }
 
 static void __init pgd_clear_tests(struct pgtable_debug_args *args)
 {
-	pgd_t pgd = READ_ONCE(*(args->pgdp));
+	pgd_t pgd = pgdp_get(args->pgdp);
 
 	if (mm_p4d_folded(args->mm))
 		return;
@@ -567,7 +567,7 @@ static void __init pgd_clear_tests(struct pgtable_debug_args *args)
 	pr_debug("Validating PGD clear\n");
 	WARN_ON(pgd_none(pgd));
 	pgd_clear(args->pgdp);
-	pgd = READ_ONCE(*args->pgdp);
+	pgd = pgdp_get(args->pgdp);
 	WARN_ON(!pgd_none(pgd));
 }
 
@@ -586,7 +586,7 @@ static void __init pgd_populate_tests(struct pgtable_debug_args *args)
 	p4d_clear(args->p4dp);
 	pgd_clear(args->pgdp);
 	pgd_populate(args->mm, args->pgdp, args->start_p4dp);
-	pgd = READ_ONCE(*args->pgdp);
+	pgd = pgdp_get(args->pgdp);
 	WARN_ON(pgd_bad(pgd));
 }
 #else  /* !__PAGETABLE_P4D_FOLDED */
@@ -627,12 +627,12 @@ static void __init pte_clear_tests(struct pgtable_debug_args *args)
 
 static void __init pmd_clear_tests(struct pgtable_debug_args *args)
 {
-	pmd_t pmd = READ_ONCE(*args->pmdp);
+	pmd_t pmd = pmdp_get(args->pmdp);
 
 	pr_debug("Validating PMD clear\n");
 	WARN_ON(pmd_none(pmd));
 	pmd_clear(args->pmdp);
-	pmd = READ_ONCE(*args->pmdp);
+	pmd = pmdp_get(args->pmdp);
 	WARN_ON(!pmd_none(pmd));
 }
 
@@ -646,7 +646,7 @@ static void __init pmd_populate_tests(struct pgtable_debug_args *args)
 	 * Hence this must not qualify as pmd_bad().
 	 */
 	pmd_populate(args->mm, args->pmdp, args->start_ptep);
-	pmd = READ_ONCE(*args->pmdp);
+	pmd = pmdp_get(args->pmdp);
 	WARN_ON(pmd_bad(pmd));
 }
 
@@ -1251,7 +1251,7 @@ static int __init init_args(struct pgtable_debug_args *args)
 		ret = -ENOMEM;
 		goto error;
 	}
-	args->start_ptep = pmd_pgtable(READ_ONCE(*args->pmdp));
+	args->start_ptep = pmd_pgtable(pmdp_get(args->pmdp));
 	WARN_ON(!args->start_ptep);
 
 	init_fixed_pfns(args);
-- 
2.30.2


