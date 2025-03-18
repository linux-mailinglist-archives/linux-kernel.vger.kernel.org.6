Return-Path: <linux-kernel+bounces-565428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF08A667F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D5517AC59
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A91C5F10;
	Tue, 18 Mar 2025 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GBCkQqy0"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0461C5D6C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270403; cv=none; b=dlz0kUyesjLVs7hdP63x1JwT3D8beLRo54v64ltUrO/bZeYlQQ0fiLJeLUIEIrQ56HmPeRPDPse2tdrjl6GXxrHADRQGikgkS/h47puXnPgHHRZ8Y31W5OkbaoKkwm1+0iw1pugATqBWqZNkciTWSkKY710MNfxeGoc23UxaopU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270403; c=relaxed/simple;
	bh=EBw0pp0DQXvs46s1Cun5L7W7ygqXcv2euwtVQoMQwxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhsmCcYGBQIQlykgyOq4LVeECNo+GS0n3xQ0eN9uOaumjbEQaesPmGRAXEPjtfWmtSgXTRafBuYrzsu3sfPCOpuzu/4eE//gvTBLuIAX7BUsQ3i+zWXGDJK2aIBmY38RwNy7qDUNZd0+SMP6iqmYsBzjmK53hWpNr69IY5bhUcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GBCkQqy0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22438c356c8so89154685ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742270401; x=1742875201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25EEGwiFn3VnbkwivdTLYPKqZQgF1BeYiMnWI1gQipU=;
        b=GBCkQqy0oppsha48UjqLp0WzZblMXlAGQzNKEI8/Ekc2xMWxGPBxqNJATT3x146NAm
         ax3PGuJvyZsLvjO+25CYmddiSL5uwzn2Yh9jxKn7/C/G4KgAhQ6NX8Ue2rJ9l4OVXoUc
         IiJJfTFrtPI6QPIKVqpruh4zMuGPVdR0tyWjNhE99D4s0t528AAg0QLPPWK2YtLhGhCb
         XvdCHdwzpaat/IGtDq3+8F2ir90Ub6UF28U39R3uCHBwAVFg7fA8t6vGGnH2zqH8X6Ey
         9vD6ZeJmWW+0cR/y/3Btiak05bQ2ahT3Bqn2VGx4q4tfpuAW3AGfIxRXm0OEa6e4395p
         6rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742270401; x=1742875201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25EEGwiFn3VnbkwivdTLYPKqZQgF1BeYiMnWI1gQipU=;
        b=mJjjaos0ZdSR3f7fq3XKtYxghS3q4OJ109L9ehrEDssuzsWctGzTPKl30t+A8TvWVq
         18+PQNKhUNOw9ngtx02Z17t9fvR56WUXccqP6QK1C6CMYHWTktHB7JSy7pjJkyAJCr3P
         CRDo1ujVB7Z1duokXY8dLfIYzySsblLiyiUUgg+hzHoXGFzA8D9O+pVumLPbZOpyp2Nj
         ObgV6yUbWXgNEb9W4YIpwPX4wtV0noNWKfemVGqdDZ9Sv5UhOciClnWkCDFUTqE86xgI
         mPCWBWh0xMwy3QGHh+Dq5D91HnVbhMy0TKfGTWNzNgl+cjMGqsPtQbwnaf6O5+9UGVHe
         vIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy2gXTIh+R9tcGk44jFgM7J7Q5Wcs6n9f5aK8PorF0rQCQ4dc5bGYVcpmLvJWImu3AOyK38VE4jZ3ADjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG88EKLEjzzZYtZ8HYXnLl1xfFucmolymr0SM+GL65SQzz1T2C
	o5Z6z3Wj3kM52JGFoIQ9uBQd21KgAZN8ip5UyCLo5wMCApcBbAM857fG4Ks3SjA=
X-Gm-Gg: ASbGncsPbhezskVpiR8pphuRGxnkIhKN5t78+fAT6qGxbZqZ2qx6j0vjWe3E40PgG7U
	pKJ3SnZLib+XHx2wN6Q6uzOYh+wJ8nBRGOpArgAG/Yd7uzFQXItRyQWutlwAeXsV8l2dDwPa9Nk
	rssKUB2duXmIeXw1ve2DBendduMqz8lx02BmDjlrT0W3d5koe+3vvnzbykQgCD7M86YqPaqSXl+
	ReQNWjpmRy8LK20mx7rJCL1fMECxjro7pDsJMLgiM4x3ZWyGFE9LeWwADCFua1VicEGl+eml8b2
	Wgk4P9KwdVG62RLQ+vdhxg70CV7f7JTBuqTf7tRQFP78Bz62rOH0aQH78+nxnGoZRGpC/T1XKNS
	lNF0g2/QPmOjqUuZJ84o2Y02g32ZNu7Dob1FsGQ==
X-Google-Smtp-Source: AGHT+IFBc6TvuWKKSrWPTLSErVQ1GkoHiMOoKLD8NwCVFkbU9sjHFxonJru7yaMaEU5aIspYftiubw==
X-Received: by 2002:a17:903:230f:b0:223:5e54:c521 with SMTP id d9443c01a7336-225e0859fafmr199239715ad.0.1742270400974;
        Mon, 17 Mar 2025 21:00:00 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4b30sm83720135ad.235.2025.03.17.20.59.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Mar 2025 20:59:59 -0700 (PDT)
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
Subject: [PATCH RESEND v2 4/4] iommu/riscv: Add support for Svnapot
Date: Tue, 18 Mar 2025 11:59:30 +0800
Message-Id: <20250318035930.11855-5-luxu.kernel@bytedance.com>
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

Add Svnapot size as supported page size and apply Svnapot when it is
possible.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/iommu.c | 86 +++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index ce4cf6569ffb4..7cc736abd2a61 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1158,6 +1158,26 @@ static int pgsize_to_level(size_t pgsize)
 	return level;
 }
 
+static unsigned long napot_size_to_order(unsigned long size)
+{
+	unsigned long order;
+
+	if (!has_svnapot())
+		return 0;
+
+	for_each_napot_order(order) {
+		if (size == napot_cont_size(order))
+			return order;
+	}
+
+	return 0;
+}
+
+static bool is_napot_size(unsigned long size)
+{
+	return napot_size_to_order(size) != 0;
+}
+
 static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
 				 pte_t pte, int level,
 				 struct list_head *freelist)
@@ -1205,7 +1225,8 @@ static pte_t *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
 		 * existing mapping with smaller granularity. Up to the caller
 		 * to replace and invalidate.
 		 */
-		if (((size_t)1 << shift) == pgsize)
+		if ((((size_t)1 << shift) == pgsize) ||
+		    (is_napot_size(pgsize) && pgsize_to_level(pgsize) == level))
 			return ptr;
 pte_retry:
 		pte = ptep_get(ptr);
@@ -1256,7 +1277,10 @@ static pte_t *riscv_iommu_pte_fetch(struct riscv_iommu_domain *domain,
 		ptr += ((iova >> shift) & (PTRS_PER_PTE - 1));
 		pte = ptep_get(ptr);
 		if (_io_pte_present(pte) && _io_pte_leaf(pte)) {
-			*pte_pgsize = (size_t)1 << shift;
+			if (pte_napot(pte))
+				*pte_pgsize = napot_cont_size(napot_cont_order(pte));
+			else
+				*pte_pgsize = (size_t)1 << shift;
 			return ptr;
 		}
 		if (_io_pte_none(pte))
@@ -1274,13 +1298,18 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	size_t size = 0;
-	pte_t *ptr;
-	pte_t pte;
-	unsigned long pte_prot;
-	int rc = 0, level;
+	pte_t *ptr, old, pte;
+	unsigned long pte_prot, order = 0;
+	int rc = 0, level, i;
 	spinlock_t *ptl; /* page table page lock */
 	LIST_HEAD(freelist);
 
+	if (iova & (pgsize - 1))
+		return -EINVAL;
+
+	if (is_napot_size(pgsize))
+		order = napot_size_to_order(pgsize);
+
 	if (!(prot & IOMMU_WRITE))
 		pte_prot = _PAGE_BASE | _PAGE_READ;
 	else if (domain->amo_enabled)
@@ -1297,9 +1326,27 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
 
 		level = pgsize_to_level(pgsize);
 		ptl = riscv_iommu_ptlock(domain, ptr, level);
-		riscv_iommu_pte_free(domain, ptep_get(ptr), level, &freelist);
+
+		old = ptep_get(ptr);
+		if (pte_napot(old) && napot_cont_size(napot_cont_order(old)) > pgsize) {
+			spin_unlock(ptl);
+			rc = -EFAULT;
+			break;
+		}
+
 		pte = _io_pte_entry(phys_to_pfn(phys), pte_prot);
-		set_pte(ptr, pte);
+		if (order) {
+			pte = pte_mknapot(pte, order);
+			for (i = 0; i < napot_pte_num(order); i++, ptr++) {
+				old = ptep_get(ptr);
+				riscv_iommu_pte_free(domain, old, level, &freelist);
+				set_pte(ptr, pte);
+			}
+		} else {
+			riscv_iommu_pte_free(domain, old, level, &freelist);
+			set_pte(ptr, pte);
+		}
+
 		spin_unlock(ptl);
 
 		size += pgsize;
@@ -1336,6 +1383,9 @@ static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
 	size_t unmapped = 0;
 	size_t pte_size;
 	spinlock_t *ptl; /* page table page lock */
+	unsigned long pte_num;
+	pte_t pte;
+	int i;
 
 	while (unmapped < size) {
 		ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
@@ -1347,7 +1397,21 @@ static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
 			return unmapped;
 
 		ptl = riscv_iommu_ptlock(domain, ptr, pgsize_to_level(pte_size));
-		set_pte(ptr, __pte(0));
+		if (is_napot_size(pte_size)) {
+			pte = ptep_get(ptr);
+
+			if (!pte_napot(pte) ||
+			    napot_cont_size(napot_cont_order(pte)) != pte_size) {
+				spin_unlock(ptl);
+				return unmapped;
+			}
+
+			pte_num = napot_pte_num(napot_cont_order(pte));
+			for (i = 0; i < pte_num; i++, ptr++)
+				set_pte(ptr, __pte(0));
+		} else {
+			set_pte(ptr, __pte(0));
+		}
 		spin_unlock(ptl);
 
 		iommu_iotlb_gather_add_page(&domain->domain, gather, iova,
@@ -1447,6 +1511,7 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	unsigned int pgd_mode;
 	dma_addr_t va_mask;
 	int va_bits, level;
+	size_t order;
 
 	iommu = dev_to_iommu(dev);
 	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
@@ -1506,6 +1571,9 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	domain->domain.geometry.aperture_end = va_mask;
 	domain->domain.geometry.force_aperture = true;
 	domain->domain.pgsize_bitmap = va_mask & (SZ_4K | SZ_2M | SZ_1G | SZ_512G);
+	if (has_svnapot())
+		for_each_napot_order(order)
+			domain->domain.pgsize_bitmap |= napot_cont_size(order) & va_mask;
 
 	domain->domain.ops = &riscv_iommu_paging_domain_ops;
 
-- 
2.20.1


