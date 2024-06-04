Return-Path: <linux-kernel+bounces-200412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F7E8FAFB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B255286817
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B117144D10;
	Tue,  4 Jun 2024 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JLKer6UM"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB025131182
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496297; cv=none; b=EbnGeIiXgF1meh+pHGzGNa3lRTBsjltyfrO/FYcccg/omQsrrwV/jQXrItxpVSleyweGV8kOWaSHdrlFcJIpN8EVQpMjXJg90ZFLBZHxLhnnsMxH8r/WQn1MycYVb8DUBr9w3sTq/m1WpW1r5VwUhfcEvWd2j/aJeNRQThlEjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496297; c=relaxed/simple;
	bh=/fVmuq9CdZIkKXBFXzfnRnUNga8NX9r9r77/TyV/H60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XoXiNMVkulL7rMdr63rE2KmOyTKWiawmcXXxEoaYaD4nNFyo+r6akseuOGnFCi4ImOYEftuBw5cu8V7tclbcQI50zYd3k60ZNTnXI84kQ0T5FO0aUar2XT74/jAOOIX1JnGNona5PthDdSRBoHTCHxD9LRAQ3UxvTE0iGX5nRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JLKer6UM; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717496287; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=guoh/QGJfMTFO1luBsme9MpL+CeGbbXVEAqgA5Cl58c=;
	b=JLKer6UMNIhkBIsgqgRxZNYo86N7MdN4I7lgROC5ICujdtCFkw0OjlAnnIq1UoxwpKWDStqfKCciechgGqHVnw4U8jwF83z9/e3syWcibu/i9dsWA7iT359gltxnbmyl65mFdEc/CwTw74uvF7llGeVgsR7ez0Q1rjQYxSqLcgg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7qooHn_1717496284;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7qooHn_1717496284)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 18:18:05 +0800
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
Subject: [PATCH v4 1/6] mm: memory: extend finish_fault() to support large folio
Date: Tue,  4 Jun 2024 18:17:45 +0800
Message-Id: <bee11bfd9157e60aaea6db033a4af7c13c982c82.1717495894.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
References: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
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
index eef4e482c0c2..1f7be4c6aac4 100644
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
+	int type, nr_pages, i;
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


