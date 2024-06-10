Return-Path: <linux-kernel+bounces-207714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C94901ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC9E1C23E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F2175817;
	Mon, 10 Jun 2024 05:56:26 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936231BF37
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998985; cv=none; b=SvSBNNmjguPHYgBxDybPOBd/vYrPrn7lFHbl6SmSMGGhqzwjfa1PnI556E7sp9T4pDc7yiI1K3ee0oXtvXOYeo8TMw2aq3/3y96KVoaZcVJAzUtTZkt+u96hAY4syg9l1HUHp5STPtI7Fk/6j7nezp2yPpcgr04Zbw3quOTtytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998985; c=relaxed/simple;
	bh=Y1XVRHwCVZ8xeJIn07qpa+DttHLbfiXuhJi5QGHmEdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyKbhAk6s9108y5I+0ZR58lcMa3lTsi+pSwwWvAfU+6+dAupn4YNKpPRxIjJWz8YmFYcUwwVzwl7O3w5tmCMW4/Rey4ANmXAgTQplNK9YF5b6ajQA9It1kumcFlnXbA6YUSaNEUJsF9TuaOTnUDhLLOAS8chBQ3DhVlAcJhu7mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4VyLcg6k1jz9v73;
	Mon, 10 Jun 2024 07:55:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uvQb-xVsAuKh; Mon, 10 Jun 2024 07:55:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4VyLcM40XWz9v7N;
	Mon, 10 Jun 2024 07:54:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 84A618B764;
	Mon, 10 Jun 2024 07:54:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id rE0TIEg0CqC3; Mon, 10 Jun 2024 07:54:59 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F8088B76C;
	Mon, 10 Jun 2024 07:54:59 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 18/18] mm: Remove CONFIG_ARCH_HAS_HUGEPD
Date: Mon, 10 Jun 2024 07:55:03 +0200
Message-ID: <ba9aa789f41669fd4d1fe818c776f4d6d1891e9d.1717955559.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717955558.git.christophe.leroy@csgroup.eu>
References: <cover.1717955558.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717998888; l=13586; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Y1XVRHwCVZ8xeJIn07qpa+DttHLbfiXuhJi5QGHmEdM=; b=nlQGZGkm0i2EHaDrbzQFa0xwcriWAWzz2/CIhSuOBVOVlnAy28qaWOb9qpmWBvUzrAxMZl0sU PdDXwVipd5pAsMM/H8Td8cwpXtHqcaH/BNls1FR+MZs7y92b5y7gFI+
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

powerpc was the only user of CONFIG_ARCH_HAS_HUGEPD and doesn't
use it anymore, so remove all related code.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
v4: Rebased on v6.10-rc1
---
 include/linux/hugetlb.h |   6 --
 mm/Kconfig              |  10 ---
 mm/gup.c                | 183 ++--------------------------------------
 mm/pagewalk.c           |  57 +------------
 4 files changed, 9 insertions(+), 247 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2b3c3a404769..58daf7d14bf4 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -20,12 +20,6 @@ struct user_struct;
 struct mmu_gather;
 struct node;
 
-#ifndef CONFIG_ARCH_HAS_HUGEPD
-typedef struct { unsigned long pd; } hugepd_t;
-#define is_hugepd(hugepd) (0)
-#define __hugepd(x) ((hugepd_t) { (x) })
-#endif
-
 void free_huge_folio(struct folio *folio);
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a54..049d29ec6e20 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1119,16 +1119,6 @@ config DMAPOOL_TEST
 config ARCH_HAS_PTE_SPECIAL
 	bool
 
-#
-# Some architectures require a special hugepage directory format that is
-# required to support multiple hugepage sizes. For example a4fe3ce76
-# "powerpc/mm: Allow more flexible layouts for hugepage pagetables"
-# introduced it on powerpc.  This allows for a more flexible hugepage
-# pagetable layouts.
-#
-config ARCH_HAS_HUGEPD
-	bool
-
 config MAPPING_DIRTY_HELPERS
         bool
 
diff --git a/mm/gup.c b/mm/gup.c
index 43491246f39d..f8e982a42bba 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -501,7 +501,7 @@ static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
 
 #ifdef CONFIG_MMU
 
-#if defined(CONFIG_ARCH_HAS_HUGEPD) || defined(CONFIG_HAVE_GUP_FAST)
+#ifdef CONFIG_HAVE_GUP_FAST
 static int record_subpages(struct page *page, unsigned long sz,
 			   unsigned long addr, unsigned long end,
 			   struct page **pages)
@@ -515,147 +515,7 @@ static int record_subpages(struct page *page, unsigned long sz,
 
 	return nr;
 }
-#endif	/* CONFIG_ARCH_HAS_HUGEPD || CONFIG_HAVE_GUP_FAST */
-
-#ifdef CONFIG_ARCH_HAS_HUGEPD
-static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
-				      unsigned long sz)
-{
-	unsigned long __boundary = (addr + sz) & ~(sz-1);
-	return (__boundary - 1 < end - 1) ? __boundary : end;
-}
-
-/*
- * Returns 1 if succeeded, 0 if failed, -EMLINK if unshare needed.
- *
- * NOTE: for the same entry, gup-fast and gup-slow can return different
- * results (0 v.s. -EMLINK) depending on whether vma is available.  This is
- * the expected behavior, where we simply want gup-fast to fallback to
- * gup-slow to take the vma reference first.
- */
-static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz,
-		       unsigned long addr, unsigned long end, unsigned int flags,
-		       struct page **pages, int *nr)
-{
-	unsigned long pte_end;
-	struct page *page;
-	struct folio *folio;
-	pte_t pte;
-	int refs;
-
-	pte_end = (addr + sz) & ~(sz-1);
-	if (pte_end < end)
-		end = pte_end;
-
-	pte = huge_ptep_get(vma->vm_mm, addr, ptep);
-
-	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
-		return 0;
-
-	/* hugepages are never "special" */
-	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
-
-	page = pte_page(pte);
-	refs = record_subpages(page, sz, addr, end, pages + *nr);
-
-	folio = try_grab_folio(page, refs, flags);
-	if (!folio)
-		return 0;
-
-	if (unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
-		gup_put_folio(folio, refs, flags);
-		return 0;
-	}
-
-	if (!pte_write(pte) && gup_must_unshare(vma, flags, &folio->page)) {
-		gup_put_folio(folio, refs, flags);
-		return -EMLINK;
-	}
-
-	*nr += refs;
-	folio_set_referenced(folio);
-	return 1;
-}
-
-/*
- * NOTE: currently GUP for a hugepd is only possible on hugetlbfs file
- * systems on Power, which does not have issue with folio writeback against
- * GUP updates.  When hugepd will be extended to support non-hugetlbfs or
- * even anonymous memory, we need to do extra check as what we do with most
- * of the other folios. See writable_file_mapping_allowed() and
- * gup_fast_folio_allowed() for more information.
- */
-static int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
-		      unsigned long addr, unsigned int pdshift,
-		      unsigned long end, unsigned int flags,
-		      struct page **pages, int *nr)
-{
-	pte_t *ptep;
-	unsigned long sz = 1UL << hugepd_shift(hugepd);
-	unsigned long next;
-	int ret;
-
-	ptep = hugepte_offset(hugepd, addr, pdshift);
-	do {
-		next = hugepte_addr_end(addr, end, sz);
-		ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr);
-		if (ret != 1)
-			return ret;
-	} while (ptep++, addr = next, addr != end);
-
-	return 1;
-}
-
-static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
-				  unsigned long addr, unsigned int pdshift,
-				  unsigned int flags,
-				  struct follow_page_context *ctx)
-{
-	struct page *page;
-	struct hstate *h;
-	spinlock_t *ptl;
-	int nr = 0, ret;
-	pte_t *ptep;
-
-	/* Only hugetlb supports hugepd */
-	if (WARN_ON_ONCE(!is_vm_hugetlb_page(vma)))
-		return ERR_PTR(-EFAULT);
-
-	h = hstate_vma(vma);
-	ptep = hugepte_offset(hugepd, addr, pdshift);
-	ptl = huge_pte_lock(h, vma->vm_mm, ptep);
-	ret = gup_hugepd(vma, hugepd, addr, pdshift, addr + PAGE_SIZE,
-			 flags, &page, &nr);
-	spin_unlock(ptl);
-
-	if (ret == 1) {
-		/* GUP succeeded */
-		WARN_ON_ONCE(nr != 1);
-		ctx->page_mask = (1U << huge_page_order(h)) - 1;
-		return page;
-	}
-
-	/* ret can be either 0 (translates to NULL) or negative */
-	return ERR_PTR(ret);
-}
-#else /* CONFIG_ARCH_HAS_HUGEPD */
-static inline int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
-			     unsigned long addr, unsigned int pdshift,
-			     unsigned long end, unsigned int flags,
-			     struct page **pages, int *nr)
-{
-	return 0;
-}
-
-static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
-				  unsigned long addr, unsigned int pdshift,
-				  unsigned int flags,
-				  struct follow_page_context *ctx)
-{
-	return NULL;
-}
-#endif /* CONFIG_ARCH_HAS_HUGEPD */
-
+#endif	/* CONFIG_HAVE_GUP_FAST */
 
 static struct page *no_page_table(struct vm_area_struct *vma,
 				  unsigned int flags, unsigned long address)
@@ -1025,9 +885,6 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags, address);
 	if (!pmd_present(pmdval))
 		return no_page_table(vma, flags, address);
-	if (unlikely(is_hugepd(__hugepd(pmd_val(pmdval)))))
-		return follow_hugepd(vma, __hugepd(pmd_val(pmdval)),
-				     address, PMD_SHIFT, flags, ctx);
 	if (pmd_devmap(pmdval)) {
 		ptl = pmd_lock(mm, pmd);
 		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
@@ -1078,9 +935,6 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	pud = READ_ONCE(*pudp);
 	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
-	if (unlikely(is_hugepd(__hugepd(pud_val(pud)))))
-		return follow_hugepd(vma, __hugepd(pud_val(pud)),
-				     address, PUD_SHIFT, flags, ctx);
 	if (pud_leaf(pud)) {
 		ptl = pud_lock(mm, pudp);
 		page = follow_huge_pud(vma, address, pudp, flags, ctx);
@@ -1106,10 +960,6 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 	p4d = READ_ONCE(*p4dp);
 	BUILD_BUG_ON(p4d_leaf(p4d));
 
-	if (unlikely(is_hugepd(__hugepd(p4d_val(p4d)))))
-		return follow_hugepd(vma, __hugepd(p4d_val(p4d)),
-				     address, P4D_SHIFT, flags, ctx);
-
 	if (!p4d_present(p4d) || p4d_bad(p4d))
 		return no_page_table(vma, flags, address);
 
@@ -1153,10 +1003,7 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 	ctx->page_mask = 0;
 	pgd = pgd_offset(mm, address);
 
-	if (unlikely(is_hugepd(__hugepd(pgd_val(*pgd)))))
-		page = follow_hugepd(vma, __hugepd(pgd_val(*pgd)),
-				     address, PGDIR_SHIFT, flags, ctx);
-	else if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
 		page = no_page_table(vma, flags, address);
 	else
 		page = follow_p4d_mask(vma, address, pgd, flags, ctx);
@@ -3270,14 +3117,6 @@ static int gup_fast_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr,
 				pages, nr))
 				return 0;
 
-		} else if (unlikely(is_hugepd(__hugepd(pmd_val(pmd))))) {
-			/*
-			 * architecture have different format for hugetlbfs
-			 * pmd format and THP pmd format
-			 */
-			if (gup_hugepd(NULL, __hugepd(pmd_val(pmd)), addr,
-				       PMD_SHIFT, next, flags, pages, nr) != 1)
-				return 0;
 		} else if (!gup_fast_pte_range(pmd, pmdp, addr, next, flags,
 					       pages, nr))
 			return 0;
@@ -3304,10 +3143,6 @@ static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
 			if (!gup_fast_pud_leaf(pud, pudp, addr, next, flags,
 					       pages, nr))
 				return 0;
-		} else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
-			if (gup_hugepd(NULL, __hugepd(pud_val(pud)), addr,
-				       PUD_SHIFT, next, flags, pages, nr) != 1)
-				return 0;
 		} else if (!gup_fast_pmd_range(pudp, pud, addr, next, flags,
 					       pages, nr))
 			return 0;
@@ -3331,12 +3166,8 @@ static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
 		if (!p4d_present(p4d))
 			return 0;
 		BUILD_BUG_ON(p4d_leaf(p4d));
-		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
-			if (gup_hugepd(NULL, __hugepd(p4d_val(p4d)), addr,
-				       P4D_SHIFT, next, flags, pages, nr) != 1)
-				return 0;
-		} else if (!gup_fast_pud_range(p4dp, p4d, addr, next, flags,
-					       pages, nr))
+		if (!gup_fast_pud_range(p4dp, p4d, addr, next, flags,
+					pages, nr))
 			return 0;
 	} while (p4dp++, addr = next, addr != end);
 
@@ -3360,10 +3191,6 @@ static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 			if (!gup_fast_pgd_leaf(pgd, pgdp, addr, next, flags,
 					       pages, nr))
 				return;
-		} else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
-			if (gup_hugepd(NULL, __hugepd(pgd_val(pgd)), addr,
-				       PGDIR_SHIFT, next, flags, pages, nr) != 1)
-				return;
 		} else if (!gup_fast_p4d_range(pgdp, pgd, addr, next, flags,
 					       pages, nr))
 			return;
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index f46c80b18ce4..ae2f08ce991b 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -73,45 +73,6 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	return err;
 }
 
-#ifdef CONFIG_ARCH_HAS_HUGEPD
-static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
-			     unsigned long end, struct mm_walk *walk, int pdshift)
-{
-	int err = 0;
-	const struct mm_walk_ops *ops = walk->ops;
-	int shift = hugepd_shift(*phpd);
-	int page_size = 1 << shift;
-
-	if (!ops->pte_entry)
-		return 0;
-
-	if (addr & (page_size - 1))
-		return 0;
-
-	for (;;) {
-		pte_t *pte;
-
-		spin_lock(&walk->mm->page_table_lock);
-		pte = hugepte_offset(*phpd, addr, pdshift);
-		err = ops->pte_entry(pte, addr, addr + page_size, walk);
-		spin_unlock(&walk->mm->page_table_lock);
-
-		if (err)
-			break;
-		if (addr >= end - page_size)
-			break;
-		addr += page_size;
-	}
-	return err;
-}
-#else
-static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
-			     unsigned long end, struct mm_walk *walk, int pdshift)
-{
-	return 0;
-}
-#endif
-
 static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			  struct mm_walk *walk)
 {
@@ -159,10 +120,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 		if (walk->vma)
 			split_huge_pmd(walk->vma, pmd, addr);
 
-		if (is_hugepd(__hugepd(pmd_val(*pmd))))
-			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
-		else
-			err = walk_pte_range(pmd, addr, next, walk);
+		err = walk_pte_range(pmd, addr, next, walk);
 		if (err)
 			break;
 
@@ -215,10 +173,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 		if (pud_none(*pud))
 			goto again;
 
-		if (is_hugepd(__hugepd(pud_val(*pud))))
-			err = walk_hugepd_range((hugepd_t *)pud, addr, next, walk, PUD_SHIFT);
-		else
-			err = walk_pmd_range(pud, addr, next, walk);
+		err = walk_pmd_range(pud, addr, next, walk);
 		if (err)
 			break;
 	} while (pud++, addr = next, addr != end);
@@ -250,9 +205,7 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 			if (err)
 				break;
 		}
-		if (is_hugepd(__hugepd(p4d_val(*p4d))))
-			err = walk_hugepd_range((hugepd_t *)p4d, addr, next, walk, P4D_SHIFT);
-		else if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
+		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
 			err = walk_pud_range(p4d, addr, next, walk);
 		if (err)
 			break;
@@ -287,9 +240,7 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 			if (err)
 				break;
 		}
-		if (is_hugepd(__hugepd(pgd_val(*pgd))))
-			err = walk_hugepd_range((hugepd_t *)pgd, addr, next, walk, PGDIR_SHIFT);
-		else if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry || ops->pte_entry)
+		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry || ops->pte_entry)
 			err = walk_p4d_range(pgd, addr, next, walk);
 		if (err)
 			break;
-- 
2.44.0


