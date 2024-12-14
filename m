Return-Path: <linux-kernel+bounces-445979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E179F1E1C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3EC188AC70
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8E616F8F5;
	Sat, 14 Dec 2024 10:47:53 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E9F38DE0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734173273; cv=none; b=ahCo9ZNuxU1YZn1w0VLUDYQ3GPqG7c1yf+wtU21XVaWZ3X4iKQGd5FIWgwTL1qBb/gT5InWmUInBrP84h7AojcRmIXvn1PD7TYnv6WlMAgZvBElfn0seat0Oc7Si8f88uGgb+agz6s50sxty1yR/0XIGRn6xc+/xqdR1oQSUp7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734173273; c=relaxed/simple;
	bh=WI1t+qPQepVOc9F7iAQQLRwd7ofgmLKsE25bDBKVN74=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GUfMlPH3QkArV84D6EMtivoNDwLO2KTWkwjIB5vKRxGd7K5I85FQDMCWeg2f2XyGCoDs7l9h5gptyb4crY503YjXR1IszXXb5v1IaEpvbeX1pVPcCcex+RludJldWUqJ8XizowpCG/zeLB5MjAX3XViRAiFJ5qEIaaA5NmPVu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y9NBs59rYz2DhRj;
	Sat, 14 Dec 2024 18:45:09 +0800 (CST)
Received: from kwepemg200013.china.huawei.com (unknown [7.202.181.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 57907180044;
	Sat, 14 Dec 2024 18:47:39 +0800 (CST)
Received: from huawei.com (10.175.113.32) by kwepemg200013.china.huawei.com
 (7.202.181.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 14 Dec
 2024 18:47:38 +0800
From: Liu Shixin <liushixin2@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song
	<muchun.song@linux.dev>, Kenneth W Chen <kenneth.w.chen@intel.com>, Kefeng
 Wang <wangkefeng.wang@huawei.com>, Nanyong Sun <sunnanyong@huawei.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Liu Shixin
	<liushixin2@huawei.com>
Subject: [PATCH] mm: hugetlb: independent PMD page table shared count
Date: Sat, 14 Dec 2024 18:44:01 +0800
Message-ID: <20241214104401.1052550-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200013.china.huawei.com (7.202.181.64)

The folio refcount may be increased unexpectly through try_get_folio() by
caller such as split_huge_pages. In huge_pmd_unshare(), we use refcount to
check whether a pmd page table is shared. The check is incorrect if the
refcount is increased by the above caller, and this can cause the page
table leaked:

 BUG: Bad page state in process sh  pfn:109324
 page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x66 pfn:0x109324
 flags: 0x17ffff800000000(node=0|zone=2|lastcpupid=0xfffff)
 page_type: f2(table)
 raw: 017ffff800000000 0000000000000000 0000000000000000 0000000000000000
 raw: 0000000000000066 0000000000000000 00000000f2000000 0000000000000000
 page dumped because: nonzero mapcount
 ...
 CPU: 31 UID: 0 PID: 7515 Comm: sh Kdump: loaded Tainted: G    B              6.13.0-rc2master+ #7
 Tainted: [B]=BAD_PAGE
 Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
 Call trace:
  show_stack+0x20/0x38 (C)
  dump_stack_lvl+0x80/0xf8
  dump_stack+0x18/0x28
  bad_page+0x8c/0x130
  free_page_is_bad_report+0xa4/0xb0
  free_unref_page+0x3cc/0x620
  __folio_put+0xf4/0x158
  split_huge_pages_all+0x1e0/0x3e8
  split_huge_pages_write+0x25c/0x2d8
  full_proxy_write+0x64/0xd8
  vfs_write+0xcc/0x280
  ksys_write+0x70/0x110
  __arm64_sys_write+0x24/0x38
  invoke_syscall+0x50/0x120
  el0_svc_common.constprop.0+0xc8/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x34/0x128
  el0t_64_sync_handler+0xc8/0xd0
  el0t_64_sync+0x190/0x198

The issue may be triggered by damon, offline_page, page_idle etc. which
will increase the refcount of page table.

Fix it by introducing independent PMD page table shared count.

Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 include/linux/mm.h       |  1 +
 include/linux/mm_types.h | 28 ++++++++++++++++++++++++++++
 mm/hugetlb.c             | 16 +++++++---------
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c39c4945946c..50fbf2a1b0ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3115,6 +3115,7 @@ static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
 	if (!pmd_ptlock_init(ptdesc))
 		return false;
 	__folio_set_pgtable(folio);
+	ptdesc_pmd_pts_init(ptdesc);
 	lruvec_stat_add_folio(folio, NR_PAGETABLE);
 	return true;
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7361a8f3ab68..740b765ac91e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -445,6 +445,7 @@ FOLIO_MATCH(compound_head, _head_2a);
  * @pt_index:         Used for s390 gmap.
  * @pt_mm:            Used for x86 pgds.
  * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
+ * @pt_share_count:   Used for HugeTLB PMD page table share count.
  * @_pt_pad_2:        Padding to ensure proper alignment.
  * @ptl:              Lock for the page table.
  * @__page_type:      Same as page->page_type. Unused for page tables.
@@ -471,6 +472,9 @@ struct ptdesc {
 		pgoff_t pt_index;
 		struct mm_struct *pt_mm;
 		atomic_t pt_frag_refcount;
+#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
+		atomic_t pt_share_count;
+#endif
 	};
 
 	union {
@@ -516,6 +520,30 @@ static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
 	const struct page *:		(const struct ptdesc *)(p),	\
 	struct page *:			(struct ptdesc *)(p)))
 
+#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
+static inline void ptdesc_pmd_pts_init(struct ptdesc *ptdesc)
+{
+	atomic_set(&ptdesc->pt_share_count, 0);
+}
+
+static inline void ptdesc_pmd_pts_inc(struct ptdesc *ptdesc)
+{
+	atomic_inc(&ptdesc->pt_share_count);
+}
+
+static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
+{
+	atomic_dec(&ptdesc->pt_share_count);
+}
+
+static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
+{
+	return atomic_read(&ptdesc->pt_share_count);
+}
+#else
+#define ptdesc_pmd_pts_init NULL
+#endif
+
 /*
  * Used for sizing the vmemmap region on some architectures
  */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea2ed8e301ef..60846b060b87 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7212,7 +7212,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 			spte = hugetlb_walk(svma, saddr,
 					    vma_mmu_pagesize(svma));
 			if (spte) {
-				get_page(virt_to_page(spte));
+				ptdesc_pmd_pts_inc(virt_to_ptdesc(spte));
 				break;
 			}
 		}
@@ -7227,7 +7227,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
 		mm_inc_nr_pmds(mm);
 	} else {
-		put_page(virt_to_page(spte));
+		ptdesc_pmd_pts_dec(virt_to_ptdesc(spte));
 	}
 	spin_unlock(&mm->page_table_lock);
 out:
@@ -7239,10 +7239,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 /*
  * unmap huge page backed by shared pte.
  *
- * Hugetlb pte page is ref counted at the time of mapping.  If pte is shared
- * indicated by page_count > 1, unmap is achieved by clearing pud and
- * decrementing the ref count. If count == 1, the pte page is not shared.
- *
  * Called with page table lock held.
  *
  * returns: 1 successfully unmapped a shared pte page
@@ -7251,18 +7247,20 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep)
 {
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 	pgd_t *pgd = pgd_offset(mm, addr);
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	pud_t *pud = pud_offset(p4d, addr);
 
 	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
 	hugetlb_vma_assert_locked(vma);
-	BUG_ON(page_count(virt_to_page(ptep)) == 0);
-	if (page_count(virt_to_page(ptep)) == 1)
+	if (sz != PMD_SIZE)
+		return 0;
+	if (!ptdesc_pmd_pts_count(virt_to_ptdesc(ptep)))
 		return 0;
 
 	pud_clear(pud);
-	put_page(virt_to_page(ptep));
+	ptdesc_pmd_pts_dec(virt_to_ptdesc(ptep));
 	mm_dec_nr_pmds(mm);
 	return 1;
 }
-- 
2.34.1


