Return-Path: <linux-kernel+bounces-194870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A798D434E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 04:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12617283833
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4991F947;
	Thu, 30 May 2024 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iJGpOrWE"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB317BA4
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034684; cv=none; b=jm//qoveOrWu4nxHuuqWMvgk2RbFwIItGt+tZ7A8Iw+D+lNh0kO0Xt4sQYh0Wm+7WHNEyO3ABz1PtdBztMvWn0CtWgv6CdEL1p9wKFi54ctmOAEtLBozT4xaJquKcJuiRDS5Ib9LFXUACqqrIQlRasn6fplDproQMagdOhiPvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034684; c=relaxed/simple;
	bh=oFpDVkd3AJ0z63HwZuCQgwGm1Qpc5P78bp0ZjLawg7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9T85BkXfKPOi5cg/Y4yYJ7zVEHTfQXDdeBv5NIztoiadhR5fKgfgTqEpTWn6nA0Npnm15Rs8ubl5U7B1RNfwEPjHO4jd6f0ytslbEayCVJX0zxR8+hsD0l4zmmFNh+W3fP+5DTZEY8oYCzPJNn4JF+lTFLO+n9lpHBwts5a4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iJGpOrWE; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717034677; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=r9qBGwXCngyL5anV+10XHk4WWPAHBJnN4gQCvtOnGdw=;
	b=iJGpOrWEyuMeexP6HjNJn9fM1KPl7fAxG1GgJQcqDcx/ueusUB9RJ21HLnFj8Ognr+7VUv4cKIUelgMumm17fE3ucquiCnjV0Gt0akXdfto/r5B2vVZM/nFleeHtolX02Us//tIdqY+SsKORaHF8h0nEaIm+QHmrWbHj0vzx2aA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7V0ZBe_1717034674;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7V0ZBe_1717034674)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 10:04:35 +0800
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
Subject: [PATCH v3 1/6] mm: memory: extend finish_fault() to support large folio
Date: Thu, 30 May 2024 10:04:12 +0800
Message-Id: <bf80d4a792ea82ab066f819ad7d10ed22a2f8e66.1717033868.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
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
index eef4e482c0c2..435187ff7ea4 100644
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
@@ -4864,24 +4867,59 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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
 		ret = VM_FAULT_NOPAGE;
+		goto unlock;
+	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
+		for (i = 0; i < nr_pages; i++)
+			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
+		ret = VM_FAULT_NOPAGE;
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


