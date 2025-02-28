Return-Path: <linux-kernel+bounces-539177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CEA4A1AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED790174164
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4E327BD86;
	Fri, 28 Feb 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="32pnMM3O"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C3277815
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767433; cv=none; b=npHIpDKXOqmVeGC2jXYvZs7NIjbH8g43KwsCGwkj17s8RgHkSm8zxAugxYCkk443eVwx8U2gpSPh2mBFpNCQ9c5WeVqa7tjk7bTVHabebGEIDdHS4mMWBFr/JmpGOdY3oOsqTogLIb8YcwCOqjNxBOjBViP/2Si9ouhG3kQoajQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767433; c=relaxed/simple;
	bh=nIg5m9Ex8f47YbyoiSpc77kPHlDELNvGKJY7NaqdSmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=luMiVyTVvWedrjDEGt4/uwgpTpTTN3i9KxHfWLwp32TzHnfG9H9kJF/RreZfJp5dxjzDDWrIU5afNim8TltrRJYVTb58FAREWd3cUeMfGFoivA002CP8EshDr24GyVQz2fBvs4f8JXflEXyuccIVj4sDusZb0HJIZR4irvbEWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=32pnMM3O; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fea8e4a655so6940621a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767431; x=1741372231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMe19yWV86sRu83AfjzN0OeG5+sON+m39CVh+mgprHg=;
        b=32pnMM3OXozY6uzHlHMcAPqohkKA6QhA7gxRie8ydjUvxl18IuliJWutdO0s+ETHo8
         o0fcaLZXmb+dSCbggXvptwQ47HbKKfmOxB+LriuR7dHyz0h5fTQH+BpPVxEo5KMjJXUK
         g1Q06bRJhxBxDqcVGxGwemNbCVRujZfA0rfhO9am5dgVHx077ih20RCzGuYB1Ff3rOFP
         im79TjaS2s37V/+26pCtgkPMYBSCwCrAIj97iwXxCQ4R/4BrpF9VKwq2hwW1J6wh+rsC
         mDX0ooSV7bJ1yGbKrUFYci5IjpSrE4ve6kpDmdbUPN1htvP54PYrCOpNoQ2ZDrp+EiN0
         W28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767431; x=1741372231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMe19yWV86sRu83AfjzN0OeG5+sON+m39CVh+mgprHg=;
        b=xOqa3bF2aTMbu3hgVx41mK7pV4J+JF9LSUokwdTDwke72hlQAY3yiH+ga+UPtShe6Z
         nSfm2T+qoGnFxu7ALMzpV54UHGQi/+QJD43DRIPWZpbVfQByq4Vffexd8NJbMiE1AZbj
         gZiddzR4Umz//rSwe9sT5H7uNB5V16rLnlhCnC/4Kj0+WsbhBapYs/iu4xSGgRJioCvk
         DWZtDQXaNJH5pX9+9Fc0EfVLqsFJdsBxwRzBFk52LlTM9PFPOgkikh5Y2MYZVlAseg4v
         TyIsY4X5u/El4d2sQiJTe9L61mL1wuWFqx37tDwjZNyZzglNlE4gCLHr2Z9dDmOOp8Sf
         7A7g==
X-Forwarded-Encrypted: i=1; AJvYcCUg+teDfZmBD8Js8g5pguPzgyl8Dx6DdaVAVeEgJX1wsOiHvRcvYOtdAN1RdsQ/7Hsz6eTFam0FufXLoQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGAiLHcJKdB9RvSLSsHoahAtyMWZhWzeUUmPuVmiWhU+1K2S8
	lb1aM81yMAzvl/aOaFceInHpngp7huTXLNVC+iDbqtUiliJmn95Lu/BbwsvNccUD26sjjg==
X-Google-Smtp-Source: AGHT+IFdDufRUVuOA2NiFtFscHtFYi1z0zZ+G49tzlylohpjZ77dDf1/vb2nPMiEU/5Q5ipJa4U2fDbm
X-Received: from pjbsr16.prod.google.com ([2002:a17:90b:4e90:b0:2fa:2891:e310])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d0a:b0:2f6:be57:49d2
 with SMTP id 98e67ed59e1d1-2febab7459bmr8199787a91.17.1740767430763; Fri, 28
 Feb 2025 10:30:30 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:27 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-27-fvdl@google.com>
Subject: [PATCH v5 26/27] mm/hugetlb: enable bootmem allocation from CMA areas
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

If hugetlb_cma_only is enabled, we know that hugetlb pages
can only be allocated from CMA. Now that there is an interface
to do early reservations from a CMA area (returning memblock
memory), it can be used to allocate hugetlb pages from CMA.

This also allows for doing pre-HVO on these pages (if enabled).

Make sure to initialize the page structures and associated data
correctly. Create a flag to signal that a hugetlb page has been
allocated from CMA to make things a little easier.

Some configurations of powerpc have a special hugetlb bootmem
allocator, so introduce a boolean arch_specific_huge_bootmem_alloc
that returns true if such an allocator is present. In that case,
CMA bootmem allocations can't be used, so check that function
before trying.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h |   6 +
 include/linux/hugetlb.h                      |  17 ++
 mm/hugetlb.c                                 | 168 ++++++++++++++-----
 3 files changed, 152 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index f0bba9c5f9c3..bb786694dd26 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -94,4 +94,10 @@ static inline int check_and_get_huge_psize(int shift)
 	return mmu_psize;
 }
 
+#define arch_has_huge_bootmem_alloc arch_has_huge_bootmem_alloc
+
+static inline bool arch_has_huge_bootmem_alloc(void)
+{
+	return (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled());
+}
 #endif
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2512463bca49..6c6546b54934 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -591,6 +591,7 @@ enum hugetlb_page_flags {
 	HPG_freed,
 	HPG_vmemmap_optimized,
 	HPG_raw_hwp_unreliable,
+	HPG_cma,
 	__NR_HPAGEFLAGS,
 };
 
@@ -650,6 +651,7 @@ HPAGEFLAG(Temporary, temporary)
 HPAGEFLAG(Freed, freed)
 HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
 HPAGEFLAG(RawHwpUnreliable, raw_hwp_unreliable)
+HPAGEFLAG(Cma, cma)
 
 #ifdef CONFIG_HUGETLB_PAGE
 
@@ -678,14 +680,18 @@ struct hstate {
 	char name[HSTATE_NAME_LEN];
 };
 
+struct cma;
+
 struct huge_bootmem_page {
 	struct list_head list;
 	struct hstate *hstate;
 	unsigned long flags;
+	struct cma *cma;
 };
 
 #define HUGE_BOOTMEM_HVO		0x0001
 #define HUGE_BOOTMEM_ZONES_VALID	0x0002
+#define HUGE_BOOTMEM_CMA		0x0004
 
 bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
 
@@ -823,6 +829,17 @@ static inline pte_t arch_make_huge_pte(pte_t entry, unsigned int shift,
 }
 #endif
 
+#ifndef arch_has_huge_bootmem_alloc
+/*
+ * Some architectures do their own bootmem allocation, so they can't use
+ * early CMA allocation.
+ */
+static inline bool arch_has_huge_bootmem_alloc(void)
+{
+	return false;
+}
+#endif
+
 static inline struct hstate *folio_hstate(struct folio *folio)
 {
 	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0b483c466656..664ccaaa717a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -131,8 +131,10 @@ static void hugetlb_free_folio(struct folio *folio)
 #ifdef CONFIG_CMA
 	int nid = folio_nid(folio);
 
-	if (cma_free_folio(hugetlb_cma[nid], folio))
+	if (folio_test_hugetlb_cma(folio)) {
+		WARN_ON_ONCE(!cma_free_folio(hugetlb_cma[nid], folio));
 		return;
+	}
 #endif
 	folio_put(folio);
 }
@@ -1508,6 +1510,9 @@ static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 					break;
 			}
 		}
+
+		if (folio)
+			folio_set_hugetlb_cma(folio);
 	}
 #endif
 	if (!folio) {
@@ -3174,6 +3179,86 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	return ERR_PTR(-ENOSPC);
 }
 
+static bool __init hugetlb_early_cma(struct hstate *h)
+{
+	if (arch_has_huge_bootmem_alloc())
+		return false;
+
+	return (hstate_is_gigantic(h) && hugetlb_cma_only);
+}
+
+static __init void *alloc_bootmem(struct hstate *h, int nid, bool node_exact)
+{
+	struct huge_bootmem_page *m;
+	unsigned long flags;
+	struct cma *cma;
+	int listnode = nid;
+
+#ifdef CONFIG_CMA
+	if (hugetlb_early_cma(h)) {
+		flags = HUGE_BOOTMEM_CMA;
+		cma = hugetlb_cma[nid];
+		m = cma_reserve_early(cma, huge_page_size(h));
+		if (!m) {
+			int node;
+
+			if (node_exact)
+				return NULL;
+			for_each_online_node(node) {
+				cma = hugetlb_cma[node];
+				if (!cma || node == nid)
+					continue;
+				m = cma_reserve_early(cma, huge_page_size(h));
+				if (m) {
+					listnode = node;
+					break;
+				}
+			}
+		}
+	} else
+#endif
+	{
+		flags = 0;
+		cma = NULL;
+		if (node_exact)
+			m = memblock_alloc_exact_nid_raw(huge_page_size(h),
+				huge_page_size(h), 0,
+				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+		else {
+			m = memblock_alloc_try_nid_raw(huge_page_size(h),
+				huge_page_size(h), 0,
+				MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+			/*
+			 * For pre-HVO to work correctly, pages need to be on
+			 * the list for the node they were actually allocated
+			 * from. That node may be different in the case of
+			 * fallback by memblock_alloc_try_nid_raw. So,
+			 * extract the actual node first.
+			 */
+			if (m)
+				listnode = early_pfn_to_nid(PHYS_PFN(virt_to_phys(m)));
+		}
+	}
+
+	if (m) {
+		/*
+		 * Use the beginning of the huge page to store the
+		 * huge_bootmem_page struct (until gather_bootmem
+		 * puts them into the mem_map).
+		 *
+		 * Put them into a private list first because mem_map
+		 * is not up yet.
+		 */
+		INIT_LIST_HEAD(&m->list);
+		list_add(&m->list, &huge_boot_pages[listnode]);
+		m->hstate = h;
+		m->flags = flags;
+		m->cma = cma;
+	}
+
+	return m;
+}
+
 int alloc_bootmem_huge_page(struct hstate *h, int nid)
 	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
 int __alloc_bootmem_huge_page(struct hstate *h, int nid)
@@ -3183,22 +3268,15 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 
 	/* do node specific alloc */
 	if (nid != NUMA_NO_NODE) {
-		m = memblock_alloc_exact_nid_raw(huge_page_size(h), huge_page_size(h),
-				0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
+		m = alloc_bootmem(h, node, true);
 		if (!m)
 			return 0;
 		goto found;
 	}
+
 	/* allocate from next node when distributing huge pages */
 	for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, &node_states[N_ONLINE]) {
-		m = memblock_alloc_try_nid_raw(
-				huge_page_size(h), huge_page_size(h),
-				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
-		/*
-		 * Use the beginning of the huge page to store the
-		 * huge_bootmem_page struct (until gather_bootmem
-		 * puts them into the mem_map).
-		 */
+		m = alloc_bootmem(h, node, false);
 		if (!m)
 			return 0;
 		goto found;
@@ -3216,21 +3294,6 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	memblock_reserved_mark_noinit(virt_to_phys((void *)m + PAGE_SIZE),
 		huge_page_size(h) - PAGE_SIZE);
 
-	/*
-	 * Put them into a private list first because mem_map is not up yet.
-	 *
-	 * For pre-HVO to work correctly, pages need to be on the list for
-	 * the node they were actually allocated from. That node may be
-	 * different in the case of fallback by memblock_alloc_try_nid_raw.
-	 * So, extract the actual node first.
-	 */
-	if (nid == NUMA_NO_NODE)
-		node = early_pfn_to_nid(PHYS_PFN(virt_to_phys(m)));
-
-	INIT_LIST_HEAD(&m->list);
-	list_add(&m->list, &huge_boot_pages[node]);
-	m->hstate = h;
-	m->flags = 0;
 	return 1;
 }
 
@@ -3271,13 +3334,25 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 	prep_compound_head((struct page *)folio, huge_page_order(h));
 }
 
+static bool __init hugetlb_bootmem_page_prehvo(struct huge_bootmem_page *m)
+{
+	return m->flags & HUGE_BOOTMEM_HVO;
+}
+
+static bool __init hugetlb_bootmem_page_earlycma(struct huge_bootmem_page *m)
+{
+	return m->flags & HUGE_BOOTMEM_CMA;
+}
+
 /*
  * memblock-allocated pageblocks might not have the migrate type set
  * if marked with the 'noinit' flag. Set it to the default (MIGRATE_MOVABLE)
- * here.
+ * here, or MIGRATE_CMA if this was a page allocated through an early CMA
+ * reservation.
  *
- * Note that this will not write the page struct, it is ok (and necessary)
- * to do this on vmemmap optimized folios.
+ * In case of vmemmap optimized folios, the tail vmemmap pages are mapped
+ * read-only, but that's ok - for sparse vmemmap this does not write to
+ * the page structure.
  */
 static void __init hugetlb_bootmem_init_migratetype(struct folio *folio,
 							  struct hstate *h)
@@ -3286,9 +3361,13 @@ static void __init hugetlb_bootmem_init_migratetype(struct folio *folio,
 
 	WARN_ON_ONCE(!pageblock_aligned(folio_pfn(folio)));
 
-	for (i = 0; i < nr_pages; i += pageblock_nr_pages)
-		set_pageblock_migratetype(folio_page(folio, i),
+	for (i = 0; i < nr_pages; i += pageblock_nr_pages) {
+		if (folio_test_hugetlb_cma(folio))
+			init_cma_pageblock(folio_page(folio, i));
+		else
+			set_pageblock_migratetype(folio_page(folio, i),
 					  MIGRATE_MOVABLE);
+	}
 }
 
 static void __init prep_and_add_bootmem_folios(struct hstate *h,
@@ -3334,10 +3413,16 @@ bool __init hugetlb_bootmem_page_zones_valid(int nid,
 		return true;
 	}
 
+	if (hugetlb_bootmem_page_earlycma(m)) {
+		valid = cma_validate_zones(m->cma);
+		goto out;
+	}
+
 	start_pfn = virt_to_phys(m) >> PAGE_SHIFT;
 
 	valid = !pfn_range_intersects_zones(nid, start_pfn,
 			pages_per_huge_page(m->hstate));
+out:
 	if (!valid)
 		hstate_boot_nrinvalid[hstate_index(m->hstate)]++;
 
@@ -3366,11 +3451,6 @@ static void __init hugetlb_bootmem_free_invalid_page(int nid, struct page *page,
 	}
 }
 
-static bool __init hugetlb_bootmem_page_prehvo(struct huge_bootmem_page *m)
-{
-	return (m->flags & HUGE_BOOTMEM_HVO);
-}
-
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) pages.
@@ -3420,14 +3500,21 @@ static void __init gather_bootmem_prealloc_node(unsigned long nid)
 			 */
 			folio_set_hugetlb_vmemmap_optimized(folio);
 
+		if (hugetlb_bootmem_page_earlycma(m))
+			folio_set_hugetlb_cma(folio);
+
 		list_add(&folio->lru, &folio_list);
 
 		/*
 		 * We need to restore the 'stolen' pages to totalram_pages
 		 * in order to fix confusing memory reports from free(1) and
 		 * other side-effects, like CommitLimit going negative.
+		 *
+		 * For CMA pages, this is done in init_cma_pageblock
+		 * (via hugetlb_bootmem_init_migratetype), so skip it here.
 		 */
-		adjust_managed_page_count(page, pages_per_huge_page(h));
+		if (!folio_test_hugetlb_cma(folio))
+			adjust_managed_page_count(page, pages_per_huge_page(h));
 		cond_resched();
 	}
 
@@ -3612,8 +3699,11 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long allocated;
 
-	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
-	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
+	/*
+	 * Skip gigantic hugepages allocation if early CMA
+	 * reservations are not available.
+	 */
+	if (hstate_is_gigantic(h) && hugetlb_cma_size && !hugetlb_early_cma(h)) {
 		pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
 		return;
 	}
-- 
2.48.1.711.g2feabab25a-goog


