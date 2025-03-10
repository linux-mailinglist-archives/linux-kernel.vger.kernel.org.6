Return-Path: <linux-kernel+bounces-554318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF86A59620
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4547B16614A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB47122A7FA;
	Mon, 10 Mar 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SnCvSyPT"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F85227E8F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612956; cv=none; b=Mgmx6b0jJwy4tkl7eygAQrcADGx7PTM7xj4gBf1SmRJKNDOYmUU+eHV2RDWaHx5vKnW/SO6wwIDqqgbXcRlZmTdBlnO7ldul9faXfFCcHw0PeeNa4uBBUeP4C1NlRJg6JjLOGMQc/sI47p69EYMwigyrNy/Ctr/81BVom3bLYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612956; c=relaxed/simple;
	bh=b0Vp9alDNo3p5bMlniWA8CX7hk8UNqOsPhZqDPfDa9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5LVfMN8awCNVjvRQPgxKP77ygojoT8oMGqqrrz9pU11SiFT/qZxJXrztGSXYJXcVbno8enabmFAkAfnHEyGIA1VvbWLkOUrSM0aHmJJ9x0HlgeBcvv/TezXRQZMzqpDFepWKVteR82yMxuLZF5e8/PJis5OUrcPgkt83rthVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SnCvSyPT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2234e4b079cso72429465ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741612953; x=1742217753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE1/PtV/9zmh+GtmYcbFmUleMVWqQrw0bsQW718u9NM=;
        b=SnCvSyPTFO9uVhYY09RvH4AYGU2/bE4wbitt+oDI4OH6klBWlHSOxbFks7WGc/M6/E
         drF/iAa/4b6M/qgFGH6Ay3pGyAPpXJPvJS+tKVoUuVfm0AYhbnxfPZI8MwPuMP0VZIgU
         3VVXya2T3zaY5H2sr3gup+99hIPgJTmjYXWb3//m1skocdx21jgqvr9FJNICRxaxf0YY
         ATZ74mc2TTaAnjU75nw3cA7YKXziOjNqrDFXfLsT50zW7XVSvRgHmOZ/OSvSOsDR9rgG
         olZyVm5ZcLbAvldMN7rKjHKgh8lphDkfLYv55EgwFh0GwbsXgf2G5MgLRCGmF3CbiVkY
         PkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741612953; x=1742217753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE1/PtV/9zmh+GtmYcbFmUleMVWqQrw0bsQW718u9NM=;
        b=Ui29Hc3YPX4IyUBazXha3nZrh7MTf4msqi2PUBQtiwR7jY0yETBYYaxnbZ6UcxxpA9
         LELBWFzRRGLbM/sCF4p8VZ6KCGksbpmp8fbn4dlhKIcsBNNQkpNEXSKWqegJ8Ym51bvL
         MrEbVfFm4YLT9UQWxpCWYQpaE85mGg9OsJbloLW8TtbYPKx3GqLMFkussJPOFzCPou8T
         DsuLT/EdxsbrCN9+lOFkuoOiDf1LnV4gi6JWAdBa7qXQpBDOwPPUugINWqMpk/7V7P78
         1deOUBKqvH7PAKGi5kc2qbaU6N4gMyM3Z03zab3wSv+fd1EjkfGTNoD3gp+SjKQZg1yA
         g1hg==
X-Forwarded-Encrypted: i=1; AJvYcCWBh5IpNgz/13rhhtwNwqGr6T5KHrlxLSyr2KmIvceb56wrErIW7eSgVVc/qgNOsqFLvKuijDE1Xc32L74=@vger.kernel.org
X-Gm-Message-State: AOJu0YztjJw7qXDj7/kc8YEtWYPatYGm1xtIUQ5cy/jjvuG4DnkUqLlx
	bIZ3DGFoaqqIlyfYemFzxFUL3HoANTU3Lz49SJRoLuRd+lCR6kQT14kZfTocMpk=
X-Gm-Gg: ASbGncveialYC+yJ/VHEiiFjaAZg2B+MHR9CEO6F7FqIN7nDag65qERoFly/as/CgxV
	fj+ApRPNzxhLqlQOxywaPFNra5Iab4qzMv2FwEFBI0z9ki5FDZyc8bRsxHx18OONJQ5RNegZvd6
	KM+LxBv4Ub+bilIv/rmqAJqmDNvoj1yHSAACsPeyDuUNKQDcefgsgyVBl2v39vaAlHRPL5UtIkx
	QkJm0WO3od2xTIepuTASSXLjolGpf6jnh8x9RuJM2veu6Ri6bLTu1gTPpZDqr+o/srLroZ5kbkB
	VlzH6sek7I9hW/+cQHUBMt1fmw4iKTR8andocR1eeeg7yoaAtJpEHVQzsgBq1DGXcBCRfhytLlr
	EpCHJ4G/0XwN59Xz9tOuTpf0eHuI=
X-Google-Smtp-Source: AGHT+IFOJcXfNCpatjHpLLH+KqUeCMuEXwNM6dMHRsGOsPG3x+GF1UVPkseaFy0PQweH89Hz1NMnYg==
X-Received: by 2002:a17:902:cccf:b0:224:194c:694c with SMTP id d9443c01a7336-22428aaeb6dmr273817455ad.28.1741612953507;
        Mon, 10 Mar 2025 06:22:33 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e8617sm77318785ad.61.2025.03.10.06.22.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Mar 2025 06:22:33 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: akpm@linux-foundation.org,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 1/4] mm/gup: Handle huge pte for follow_page_pte()
Date: Mon, 10 Mar 2025 21:22:19 +0800
Message-Id: <20250310132222.58378-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250310132222.58378-1-luxu.kernel@bytedance.com>
References: <20250310132222.58378-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page mapped at pte level can also be huge page when ARM CONT_PTE or
RISC-V SVNAPOT is enabled. Handle this scenario in follow_page_pte.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h |  6 ++++++
 include/linux/pgtable.h          |  8 ++++++++
 mm/gup.c                         | 22 ++++++++++++++++------
 3 files changed, 30 insertions(+), 6 deletions(-)

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
index 3883b307780ea..84710896f42eb 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -838,11 +838,12 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmd, unsigned int flags,
-		struct dev_pagemap **pgmap)
+		struct follow_page_context *ctx)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct folio *folio;
 	struct page *page;
+	struct hstate *h;
 	spinlock_t *ptl;
 	pte_t *ptep, pte;
 	int ret;
@@ -879,8 +880,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
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
@@ -940,6 +941,15 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		 */
 		folio_mark_accessed(folio);
 	}
+	if (is_vm_hugetlb_page(vma)) {
+		h = hstate_vma(vma);
+		WARN_ON_ONCE(page_size(page) != huge_page_size(h));
+		page += (address & (huge_page_size(h) - 1)) >> PAGE_SHIFT;
+		ctx->page_mask = (1 << huge_page_order(h)) - 1;
+	} else if (pte_trans_huge(pte)) {
+		page += (address & (page_size(page) - 1)) >> PAGE_SHIFT;
+		ctx->page_mask = (page_size(page) >> PAGE_SHIFT) - 1;
+	}
 out:
 	pte_unmap_unlock(ptep, ptl);
 	return page;
@@ -975,7 +985,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		return no_page_table(vma, flags, address);
 	}
 	if (likely(!pmd_leaf(pmdval)))
-		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
+		return follow_page_pte(vma, address, pmd, flags, ctx);
 
 	if (pmd_protnone(pmdval) && !gup_can_follow_protnone(vma, flags))
 		return no_page_table(vma, flags, address);
@@ -988,14 +998,14 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
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


