Return-Path: <linux-kernel+bounces-209616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF0C90387B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAD61C23778
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7017B404;
	Tue, 11 Jun 2024 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ePnvKXJV"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3A17838E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100688; cv=none; b=p5lHGoEhnZWVT7VIOVHLMtvwikkNIwDA6i847Mwo2ok8cO3hJZzC2j53A6swpNLSqtYskiLnx40EgcGU/Cdi1Li0Rp5Ok1i0POg4Xwk6zF+cqnDKr6uGPdx94bL8RrKQxxbFuWoBIsBXX0Hj6wAUEy8b4UpVEUVykC/CA1cXzSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100688; c=relaxed/simple;
	bh=jKWpOmVynP3kLGwu9JmWswjDh+/ioHfX22ehBjGFNLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N9AJ+9BdV1BHjTiqMP8i3TNU8etnROWYDUJuqZfDoxxnFIPcEy6x9qkTzE+Xrxi5x7pFZuTo2S0OdQ6ZaboYac3siZSPeR1jUu27ST9cJJH6dPKMbjHfIB1qYDyZu82RJS8GowIodzYLFDAJOXjbQ19VxuhPcUEIsMM0V8z7wWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ePnvKXJV; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718100678; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=W4Bbp1+23OsISWkX2qQa4Pc7burV6pvce6vC6TkTWEc=;
	b=ePnvKXJVCqr3Ii5A/fJ/90hydRdas5oRF/iykti+9p+WyJhpBQk5gyVnswChnSe2g5gIRLBF3d+qn0ylw3ohHuyMxSoMEvxckYtRie6X9llu6nUNkIgRT+UY+2o2FIete/Zk7dQ8WgCqPvMp1MqkIti2amBJUc7QQYkiWI5RQQQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8G7ELN_1718100676;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8G7ELN_1718100676)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 18:11:16 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] mm: memory: extend finish_fault() to support large folio
Date: Tue, 11 Jun 2024 18:11:05 +0800
Message-Id: <3a190892355989d42f59cf9f2f98b94694b0d24d.1718090413.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add large folio mapping establishment support for finish_fault() as a
preparation, to support multi-size THP allocation of anonymous shmem pages
in the following patches.

Keep the same behavior (per-page fault) for non-anon shmem to avoid inflating
the RSS unintentionally, and we can discuss what size of mapping to build
when extending mTHP to control non-anon shmem in the future.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memory.c | 57 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index eef4e482c0c2..72775ee99ff3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4831,9 +4831,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
+	struct folio *folio;
 	vm_fault_t ret;
 	bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
 		      !(vma->vm_flags & VM_SHARED);
+	int type, nr_pages;
+	unsigned long addr = vmf->address;
 
 	/* Did we COW the page? */
 	if (is_cow)
@@ -4864,24 +4867,58 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return VM_FAULT_OOM;
 	}
 
+	folio = page_folio(page);
+	nr_pages = folio_nr_pages(folio);
+
+	/*
+	 * Using per-page fault to maintain the uffd semantics, and same
+	 * approach also applies to non-anonymous-shmem faults to avoid
+	 * inflating the RSS of the process.
+	 */
+	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
+		nr_pages = 1;
+	} else if (nr_pages > 1) {
+		pgoff_t idx = folio_page_idx(folio, page);
+		/* The page offset of vmf->address within the VMA. */
+		pgoff_t vma_off = vmf->pgoff - vmf->vma->vm_pgoff;
+
+		/*
+		 * Fallback to per-page fault in case the folio size in page
+		 * cache beyond the VMA limits.
+		 */
+		if (unlikely(vma_off < idx ||
+			     vma_off + (nr_pages - idx) > vma_pages(vma))) {
+			nr_pages = 1;
+		} else {
+			/* Now we can set mappings for the whole large folio. */
+			addr = vmf->address - idx * PAGE_SIZE;
+			page = &folio->page;
+		}
+	}
+
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-				      vmf->address, &vmf->ptl);
+				       addr, &vmf->ptl);
 	if (!vmf->pte)
 		return VM_FAULT_NOPAGE;
 
 	/* Re-check under ptl */
-	if (likely(!vmf_pte_changed(vmf))) {
-		struct folio *folio = page_folio(page);
-		int type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
-
-		set_pte_range(vmf, folio, page, 1, vmf->address);
-		add_mm_counter(vma->vm_mm, type, 1);
-		ret = 0;
-	} else {
-		update_mmu_tlb(vma, vmf->address, vmf->pte);
+	if (nr_pages == 1 && unlikely(vmf_pte_changed(vmf))) {
+		update_mmu_tlb(vma, addr, vmf->pte);
+		ret = VM_FAULT_NOPAGE;
+		goto unlock;
+	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
+		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
 		ret = VM_FAULT_NOPAGE;
+		goto unlock;
 	}
 
+	folio_ref_add(folio, nr_pages - 1);
+	set_pte_range(vmf, folio, page, nr_pages, addr);
+	type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
+	add_mm_counter(vma->vm_mm, type, nr_pages);
+	ret = 0;
+
+unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
 }
-- 
2.39.3


