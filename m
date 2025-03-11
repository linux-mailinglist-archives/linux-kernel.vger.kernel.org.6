Return-Path: <linux-kernel+bounces-556112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63036A5C13D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AA41885803
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12EA25C710;
	Tue, 11 Mar 2025 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fiNLk9jY"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A725A351
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695925; cv=none; b=XQqAyHQ2rHwfqX79AqnkM4TloCUj+coyv4op+RyZVyi/v9Uya7NLp/F1krJcW71x2qlzekCBmQsQuOSWdVnY3TCjY+VAB1XJ4UPJaUcYvSnBrcS+2mJRRTw6xndFjiQKRQ0ig7KAs5SO6CYEIkFkdiSc28On4UNzX29JmE1gE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695925; c=relaxed/simple;
	bh=/USjbKKq5YfDfRJ6A+DM8l4Ia7tqauRSn5x7aeDJHKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQjfRU8JusXcrX0aiqA1y+u9jbQyKSJZlf6oQzEPp8mpANMiO7XVTDmi8Bj5h0CH48Evew4XHG1RllujNw8LJnTp7NIjG6cylF6J2pxC5DkrCS+PEj7qEkB0+Hc50JBGCCNgcw1mgxCY/6y10dY5siBQz68GSJu/f0vsa5OOM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fiNLk9jY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224019ad9edso120590415ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741695922; x=1742300722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OMb2TInCE9Qb7KUVvNgWIsY4Uxx9EaJDiVCyGMWyMw=;
        b=fiNLk9jY24TeWEE1mrA6Y0jLKjcBU+WBJp7+AG+GCN0pbjkBuMm041F7uH+xh6x6s1
         lez8+Zelst7wokD8eePtn1znua1e3co772BeuaLwd3IMooO95h+65l3V6p54pMQsiZVI
         66NALnGYEAdh/oWrSivoUN9jAZdDifX2s+D04jA/pcyaYpNkX/5befaqdKPDBPPsccWb
         ySIuEcWN92TNFkD99E21g8dnpAYSHG6aJbnJCZwpz/UY2rUKvrvxhysRDPIFSWPzw4zP
         U9yok0xBFfAHJkFgOjIzaSFRDrllVEUhHZQUoGiylKRBEfHZksRXuueIW4nveoxiC+Lv
         8nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741695922; x=1742300722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OMb2TInCE9Qb7KUVvNgWIsY4Uxx9EaJDiVCyGMWyMw=;
        b=dC3EQ1Tibt6rA7Rs09uh/JxN/OgguNiGEhfySxnNn+F1ERiLW0hKL2RqmHBOXtDkn/
         mf/pcGwOtlZ0Q0auUnjYsLIMIIsZMi8pJBo3cxBWNVw3772q696Mh7hMJwi1bPFYH9AB
         6iKYDXuJu6mZMhlQGH4m0dJiQmQRY5QhF5k502G+nHXJ2Xgq5FJes/3Pr/VjgOrXM5N4
         uuA/b191zeHvqbUJpriNdNyz0BazAogK0VQ/wrL/9ubEZ6FvO+mW91WzeOiZ3EgQwqpR
         6kX1dri4sZPJ/BVghydulPQnFJP+YCfiW1aOyJJNd/L9N8uFAzGcA2RqCDecYvr7cNeQ
         97TA==
X-Forwarded-Encrypted: i=1; AJvYcCXRUcReK9tjeM9JQZKnXxiR0cQvMVbHL1v6vY7oGNCv2jrteJPIJ66sr2J0G/Go+jFAfQI8UGoXRH4SVVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaW560dPkDqQlUm7ZXjYYsq3m+7vmDBFbtVsekTK87WwRx2sG8
	bpMLykQfDrQZ2tnLd5Avt0/+47J9YhYRxgyC4iagUTQR0SC3kCMlB+Xvo5YvPXg=
X-Gm-Gg: ASbGnctU3reFeudFy78WIeRMbSgdHW/uszUMJYP1PUcxHeFOu803ZSt2sdd/qPzmj0Z
	fVuvBVDwLRxz1OHr/oxu9Wo3I+NsDmzqphXlZ3KfoXJBJ/T+NIULwfIj0Q5906FmrL6Rn1dQpok
	Sy5GXawOCt9Wzoe28lWx5TlzypPVgU3EMtqWO9157PAzO21/dBhY7nVMi6uxsoDhC45VDUdT06j
	NnMGlzXv/4Y9Ijr3N2gJMQO3IKvv5Cr7kG1lkCQ6vwuStE33i9QGvQf/hvCRh2/Bwj1jJGBPtWu
	5YzJqlB1oAxyZv5+MR+0Je/a4d/UxbV7p7FRw0+z43akpsMEGBUKxp0Qak5meiAtGwyO+N21mUh
	fjdK2+e9o7smxG5Hk0ylp9zfWS2k=
X-Google-Smtp-Source: AGHT+IF+AKaM7+LGh1MSeSzuaMnYSTp9Pfd35y7XVQv+2e9hDZ72MVIWeURa7iA/fxUl+/8M2l45Ow==
X-Received: by 2002:a05:6a20:c891:b0:1f5:59e5:8ada with SMTP id adf61e73a8af0-1f559e58e8dmr18738163637.4.1741695922464;
        Tue, 11 Mar 2025 05:25:22 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698450244sm10226621b3a.80.2025.03.11.05.25.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Mar 2025 05:25:22 -0700 (PDT)
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
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v2 1/4] mm/gup: Add huge pte handling logic in follow_page_pte()
Date: Tue, 11 Mar 2025 20:25:07 +0800
Message-Id: <20250311122510.72934-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250311122510.72934-1-luxu.kernel@bytedance.com>
References: <20250311122510.72934-1-luxu.kernel@bytedance.com>
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


