Return-Path: <linux-kernel+bounces-177154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E73D8C3AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E04B20D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708361465AC;
	Mon, 13 May 2024 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YMUTmWTT"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77249146004
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715576927; cv=none; b=b8/kOFoYfT2IFp6A7hgpTNZJj0Zcu+FUiHRC7cK8Ry6hD/F+UYfsBYPtV1VfgQ2tLgitsvH04/2/tVhbf93Yya0woEbDdS9BPdT8QLZqQ8ecC1OAZxLlFM1w7dRPd4r7GGD9sOyws9d00FOJKt/HjLPBY/vy+tKENkSEqs2bCKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715576927; c=relaxed/simple;
	bh=nMSF1IFNK+xtK1MkmmMs2/4yvCnaAux+3CiGthjHebQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVMSu8brZvRu/DDMLoPL9kLetTN5K7Xdo3lw7cufgY/k5LJLhAV/oOjwGiwly5eOMV5rh6ybRpLZ/s5xQFDHxjXrlgxqR9dfUkEpBC9OxEtZ1C4NuD1L+IeKhY78uEmlsrLnd5yU5yGw2wnTjto78agVP9i+cBO42Z4wm9d5FNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YMUTmWTT; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715576916; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/wPvXkyuXgii0bLFUI24fcIW75QnUckPu3WAKMN0v0o=;
	b=YMUTmWTT1UYtaBphNlJ83Z0UnGWSGCE0+ov7/10Ik9Tn5PxQBQiq09cWTGntFbo7toUqx+uSk9njFnAV92U2ZCcpalXPqOuFa+HkGkBiQQsjxtUpSGl+qYSAnGuAR10TfvgVupdkEozq1XSn7VYknhjkBZUl8+aLLfdalaWC6pg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6HFTB5_1715576913;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6HFTB5_1715576913)
          by smtp.aliyun-inc.com;
          Mon, 13 May 2024 13:08:34 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] mm: memory: extend finish_fault() to support large folio
Date: Mon, 13 May 2024 13:08:11 +0800
Message-Id: <131bcf31a07fade15a012ed5cdf7156d42a4c2fa.1715571279.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1715571279.git.baolin.wang@linux.alibaba.com>
References: <cover.1715571279.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add large folio mapping establishment support for finish_fault() as a preparation,
to support multi-size THP allocation of anonymous shmem pages in the following
patches.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memory.c | 58 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index eea6e4984eae..f5ffe012556c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4747,9 +4747,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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
@@ -4780,24 +4783,59 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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
+		for (i = 0; i < nr_pages; i++)
+			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
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


