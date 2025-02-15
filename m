Return-Path: <linux-kernel+bounces-516048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36665A36C6A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7671171EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266CE18C01E;
	Sat, 15 Feb 2025 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="VelXm3zB"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68BB2753FC
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739604075; cv=none; b=j9xucv1WTGi03TQ0zAIaXMAy0CtXROXEZ5mWTy2mZALodkxO9Jl3r/XL3ekZiA5bmhQ7WY38SQWafMeivNGFUxiMibXdMnC4U9oPv4rTzvVVygYmh98IXurZnBOHTroMLkRAxyFvcllzfWP79RjoE7TV9FFPjAskjY0CMNnQ2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739604075; c=relaxed/simple;
	bh=KwgyuZcUY4y8bDCbi66j9KBksFUWq3oFlj/daIQ/lJ4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dVm4/fh6YzuXzSmHViuIJAtnxfDGqmwresUVlfSTNCcv4PtPY0ggJoPAt9LwLAhJabj5W6sXKFFikXoRwW/+95ibPywPF8fzMSSr84Q5UrMb4pSJyzCC9RTRp6q8iiG1PI50nz1o72Yg+Cy9KO9ejttMu4QkUc63zME1BW8aAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=VelXm3zB; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=agHQ3lenbLOgIS9g7b
	cB70WfrVWcB0GiCF7MKu9qzgM=; b=VelXm3zB73ANjuuDCGmHZwdJ23/NOSMyZf
	cFdAa9gYjh2sG5Ph/3LMmCzBZUdfmjtgA2pVWnzzaIcYzfZG1IhSEmVX2xGCgwkI
	mjggBmt/wDI9GI4Sz6sT30uNS/SdCDrpBZlhC2rw3oGH4Sn3M/lIBu5baQe0JBzL
	4tRd5HciM=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3j9M8QLBnZ7P7Aw--.29501S2;
	Sat, 15 Feb 2025 15:20:29 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	21cnbao@gmail.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	liuzixing@hygon.cn,
	Ge Yang <yangge1116@126.com>
Subject: [PATCH V2] mm/hugetlb: wait for hugepage folios to be freed
Date: Sat, 15 Feb 2025 15:20:26 +0800
Message-Id: <1739604026-2258-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wC3j9M8QLBnZ7P7Aw--.29501S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXryrCFy8Xr45tw4UKr1UAwb_yoWrZF1xpF
	yUKr43GFWDJ3sakrnrZws8Ar1Ik395ZFW2krWIqw45Z3ZxJa4DKFy2vw1qq3y5ZrWkCFWx
	ZrWjvrWDuF1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoGQDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifgb0G2ewM0J3AAAAsG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Ge Yang <yangge1116@126.com>

Since the introduction of commit b65d4adbc0f0 ("mm: hugetlb: defer freeing
of HugeTLB pages"), which supports deferring the freeing of HugeTLB pages,
the allocation of contiguous memory through cma_alloc() may fail
probabilistically.

In the CMA allocation process, if it is found that the CMA area is occupied
by in-use hugepage folios, these in-use hugepage folios need to be migrated
to another location. When there are no available hugepage folios in the
free HugeTLB pool during the migration of in-use HugeTLB pages, new folios
are allocated from the buddy system. A temporary state is set on the newly
allocated folio. Upon completion of the hugepage folio migration, the
temporary state is transferred from the new folios to the old folios.
Normally, when the old folios with the temporary state are freed, it is
directly released back to the buddy system. However, due to the deferred
freeing of HugeTLB pages, the PageBuddy() check fails, ultimately leading
to the failure of cma_alloc().

Here is a simplified call trace illustrating the process:
cma_alloc()
    ->__alloc_contig_migrate_range() // Migrate in-use hugepage
        ->unmap_and_move_huge_page()
            ->folio_putback_hugetlb() // Free old folios
    ->test_pages_isolated()
        ->__test_page_isolated_in_pageblock()
             ->PageBuddy(page) // Check if the page is in buddy

To resolve this issue, we have implemented a function named
wait_for_hugepage_folios_freed(). This function ensures that the hugepage
folios are properly released back to the buddy system after their migration
is completed. By invoking wait_for_hugepage_folios_freed() before calling
PageBuddy(), we ensure that PageBuddy() will succeed.

Fixes: b65d4adbc0f0 ("mm: hugetlb: defer freeing of HugeTLB pages")
Signed-off-by: Ge Yang <yangge1116@126.com>
---

V2:
- flush all folios at once suggested by David

 include/linux/hugetlb.h |  5 +++++
 mm/hugetlb.c            |  8 ++++++++
 mm/page_isolation.c     | 10 ++++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6c6546b..04708b0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -697,6 +697,7 @@ bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
+void wait_for_hugepage_folios_freed(void);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, bool cow_from_owner);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
@@ -1092,6 +1093,10 @@ static inline int replace_free_hugepage_folios(unsigned long start_pfn,
 	return 0;
 }
 
+static inline void wait_for_hugepage_folios_freed(void)
+{
+}
+
 static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   bool cow_from_owner)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 30bc34d..36dd3e4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2955,6 +2955,14 @@ int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
 	return ret;
 }
 
+void wait_for_hugepage_folios_freed(void)
+{
+	struct hstate *h;
+
+	for_each_hstate(h)
+		flush_free_hpage_work(h);
+}
+
 typedef enum {
 	/*
 	 * For either 0/1: we checked the per-vma resv map, and one resv
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 8ed53ee0..f56cf02 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -615,6 +615,16 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 	int ret;
 
 	/*
+	 * Due to the deferred freeing of HugeTLB folios, the hugepage folios may
+	 * not immediately release to the buddy system. This can cause PageBuddy()
+	 * to fail in __test_page_isolated_in_pageblock(). To ensure that the
+	 * hugepage folios are properly released back to the buddy system, we
+	 * invoke the wait_for_hugepage_folios_freed() function to wait for the
+	 * release to complete.
+	 */
+	wait_for_hugepage_folios_freed();
+
+	/*
 	 * Note: pageblock_nr_pages != MAX_PAGE_ORDER. Then, chunks of free
 	 * pages are not aligned to pageblock_nr_pages.
 	 * Then we just check migratetype first.
-- 
2.7.4


