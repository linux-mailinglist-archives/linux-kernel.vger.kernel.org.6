Return-Path: <linux-kernel+bounces-565425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA07A667DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C31647A9546
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488691B3957;
	Tue, 18 Mar 2025 03:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HbnvhFYp"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060DE18871F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270388; cv=none; b=m9zA/USod6ZDq4cjvgVlgbNlCa6fke4G1W6VlU4mh6FAd0gCjLPeguwVJYrLR4U9e29xwpr1MHS1/pmgpcgsDRcg1T7Xqr2rryh4ln0y0Lsd5N8PJJ1ZHCg+p8GTLtlvDclS6UXYlQ2BTqJasxJP/6fZXqRfD7P52RTpBA7TugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270388; c=relaxed/simple;
	bh=/USjbKKq5YfDfRJ6A+DM8l4Ia7tqauRSn5x7aeDJHKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hb57bYzTQGi/53XIPLsy1nGIg3vndJdjAy0CCrdsnoXEyG8ISCx+P/prnC5DjLV0707A8SeQ5wmtbbK8mBoI5/PMKw7uZdgxRZJ7BP1QUr110wBw+0xiaGxpUc2hfUz6buFNRz6uhxACe0oWZ/DeLf4BldaQ/Cl29CbEWtTaFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HbnvhFYp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22359001f1aso50273215ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742270385; x=1742875185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OMb2TInCE9Qb7KUVvNgWIsY4Uxx9EaJDiVCyGMWyMw=;
        b=HbnvhFYpAeD7SPnNRisFWXl9tHpHw18JWbyxaA+Zo/MBJK2V5DoIzlclQGkMrKzrrF
         ZfP1xtmxDc55TF+tOeOAWzjL+xlwgRCPwB7H7aMqYEz2zs0O383/v2f3fdwD1VtqU1UW
         pCh5LfVPNTzD5+LqJ6suFH5lGv/0GynzbmcQ/cOyVgGFJpu5UBuugQXuF/wYNXVDDl6g
         5eQ7RYCWG9rlq6vym/tP4XR88EIkNV+n6nATErNfFwpmRAxFKt/3DLJyZs3Rwe/jd/xT
         +HU1mQNrj/IKbcE2CoRCsxQb9KJmjsvR0GShzHatohgjGcuG4TLonafs1KldKiZ8ZvrY
         RFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742270385; x=1742875185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OMb2TInCE9Qb7KUVvNgWIsY4Uxx9EaJDiVCyGMWyMw=;
        b=tmVZ4rNOjMMdtqR4yyz8jZq2wKhWwA+eRs2YjgnKAimmqGXYl6U5GMIMegrtUgwNiF
         OkQlXmM+gTv1oyZkaq1BPoUaMF6CFQzcqNCU2w6XrtCqvyQIPTOiqWFnZlOrJkgAm42e
         u+tXvsrsLJE/ykSyo/+Xj5d7Ip+OHh5ARstGh+u4ZFDdBUgNqOMHoe4yEw8NQemlOkLm
         9CTgxuPDriQWdZ6lpsOWbJ31VvL7vT0QdxcgVdv/KArTj7kA6i8wJm7IPZhXawYeHt+o
         McXBXt7inf7sp4wJu12dux2qmf8Av4rduuqsKhPd+lHRJAlULjMd6v1D11XlG9VPLYcL
         zVPg==
X-Forwarded-Encrypted: i=1; AJvYcCXqtlmukuTIdUc+Npz+K1mmHSzSW2KdrM14X0qDCBjHOyVUEyhEhOwGUhvUuXf1gl7Ov1spLrPftv2NtFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGE/1f++3Yrgf9MvwC8F37aHyOub86idKjfIAzS0pPL3PpGHO
	QeMNl/3wB5Ie9f831EbQ/L57pPOtA1gq/GIzejykWDtjNrszcbyLlyDD+vqA89U=
X-Gm-Gg: ASbGncsL+mmpfrB7omU8pGn5WpWCq0+BAc70b28MxBFOsNXWwauFXQlEqEbfRHgt8bC
	g/WaiWgfqdNcK/BO/8sgY2lqWVC7m/D9kgc6AjvTBg4PeFuyMa/avahSei7ArEjXn2PuWxo+ChP
	/biODFef66PTDpBVtCh2PaEZGFAttFrqoFrP+d+euShc4GfmDUX834fQ8J+R4SfeIoI5VbqNFRJ
	8au2cluJ+kOMPtsodLNK3UHu5KfuIHmKMNmzsblIcX3YG+A+Y397rj+wQt07yLtuiFTePXQZlzN
	QQzhSHf3WGm9gY22F/gHdVBB01hET0zzIYE0rRPkdSRdP/WmZsmAT/R4k/+nYuGyrMCC/G0pLSe
	m6u5xP3dGrftesptT2SKmQHmXQyU=
X-Google-Smtp-Source: AGHT+IGHO8cx8ckfDIHxWMgqvQhdq4sCCYAYAML9a+Udl9ONIKirtb2WHArjW9djfVtwLHqHp3jjYg==
X-Received: by 2002:a17:903:1ca:b0:21f:b483:2ad5 with SMTP id d9443c01a7336-2262c555e78mr19060495ad.20.1742270385373;
        Mon, 17 Mar 2025 20:59:45 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4b30sm83720135ad.235.2025.03.17.20.59.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Mar 2025 20:59:44 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: akpm@linux-foundation.org,
	jhubbard@nvidia.com,
	kirill.shutemov@linux.intel.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH RESEND v2 1/4] mm/gup: Add huge pte handling logic in follow_page_pte()
Date: Tue, 18 Mar 2025 11:59:27 +0800
Message-Id: <20250318035930.11855-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250318035930.11855-1-luxu.kernel@bytedance.com>
References: <20250318035930.11855-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page mapped at pte level can also be huge page when ARM CONT_PTE or
RISC-V SVNAPOT is applied. Lack of huge pte handling logic in
follow_page_pte() may lead to both performance and correctness issues.

For example, on RISC-V platform, pages in the same 64K huge page have
the same pte value, which means follow_page_pte() will get the same page
for all of them using pte_pfn(). Then __get_user_pages() will return an
array of pages with the same pfn. Mapping these pages causes memory
confusion. This error can be triggered by the following code:

  void *addr = mmap(NULL, 0x10000, PROT_READ | PROT_WRITE, MAP_ANONYMOUS |
		  MAP_PRIVATE | MAP_HUGETLB | MAP_HUGE_64KB, -1, 0);
  struct vfio_iommu_type1_dma_map dmap_map = {
	  .argsz = sizeof(dma_map),
	  .flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
	  .vaddr = (uint64_t)addr,
	  .size = 0x10000,
  };

  ioctl(vfio_container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);

This commit supplies huge pte handling logic in follow_page_pte() to
avoid such problems.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h |  6 ++++++
 include/linux/pgtable.h          |  8 ++++++++
 mm/gup.c                         | 17 +++++++++++------
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 050fdc49b5ad7..40ae5979dd82c 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -800,6 +800,12 @@ static inline bool pud_user_accessible_page(pud_t pud)
 #endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define pte_trans_huge	pte_trans_huge
+static inline int pte_trans_huge(pte_t pte)
+{
+	return pte_huge(pte) && pte_napot(pte);
+}
+
 static inline int pmd_trans_huge(pmd_t pmd)
 {
 	return pmd_leaf(pmd);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 94d267d02372e..3f57ee6dcf017 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1584,6 +1584,14 @@ static inline unsigned long my_zero_pfn(unsigned long addr)
 
 #ifdef CONFIG_MMU
 
+#if (defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(pte_trans_huge)) || \
+	(!defined(CONFIG_TRANSPARENT_HUGEPAGE))
+static inline int pte_trans_huge(pte_t pte)
+{
+	return 0;
+}
+#endif
+
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pmd_trans_huge(pmd_t pmd)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 3883b307780ea..67981ee28df86 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -838,7 +838,7 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmd, unsigned int flags,
-		struct dev_pagemap **pgmap)
+		struct follow_page_context *ctx)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct folio *folio;
@@ -879,8 +879,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		 * case since they are only valid while holding the pgmap
 		 * reference.
 		 */
-		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
-		if (*pgmap)
+		ctx->pgmap = get_dev_pagemap(pte_pfn(pte), ctx->pgmap);
+		if (ctx->pgmap)
 			page = pte_page(pte);
 		else
 			goto no_page;
@@ -940,6 +940,11 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		 */
 		folio_mark_accessed(folio);
 	}
+	if (is_vm_hugetlb_page(vma) || pte_trans_huge(pte)) {
+		ctx->page_mask = (1 << folio_order(folio)) - 1;
+		page = folio_page(folio, 0) +
+		       ((address & (folio_size(folio) - 1)) >> PAGE_SHIFT);
+	}
 out:
 	pte_unmap_unlock(ptep, ptl);
 	return page;
@@ -975,7 +980,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags, address);
 	}
 	if (likely(!pmd_leaf(pmdval)))
-		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+		return follow_page_pte(vma, address, pmd, flags, ctx);
 
 	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(vma, flags))
 		return no_page_table(vma, flags, address);
@@ -988,14 +993,14 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	}
 	if (unlikely(!pmd_leaf(pmdval))) {
 		spin_unlock(ptl);
-		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+		return follow_page_pte(vma, address, pmd, flags, ctx);
 	}
 	if (pmd_trans_huge(pmdval) && (flags & FOLL_SPLIT_PMD)) {
 		spin_unlock(ptl);
 		split_huge_pmd(vma, pmd, address);
 		/* If pmd was left empty, stuff a page table in there quickly */
 		return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
-			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+			follow_page_pte(vma, address, pmd, flags, ctx);
 	}
 	page = follow_huge_pmd(vma, address, pmd, flags, ctx);
 	spin_unlock(ptl);
-- 
2.20.1


