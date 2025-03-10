Return-Path: <linux-kernel+bounces-554322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C7FA59629
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE113A5644
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6166D22B8D1;
	Mon, 10 Mar 2025 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e5H1JXbw"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9BC22AE7F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612967; cv=none; b=To6tT7YyqxxA9sf1TLgh441g3EYirSa2vI6s/9BF8bV7w1D6tjp0R5KiHnhxvICw1Qh/ENgftpp6uEX3/Pve77V8DnZNnnD/sPWlbsyRLTiyS5RD7qoYOOh33RWSUcgGvLU3zmAJxXTCc59eAnRNqYFyd7zqk+v1Bxnan86JSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612967; c=relaxed/simple;
	bh=0nfVO5sUm2e0FH3Gfvj26LwKA0FPWjtsqZ2XmVsGS9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8juHJRKYvIb/oKUJwPusAQSgIlJq4hl5cMqZK+wd6WUXLl29WtloIADH5xBIuwhFE5IKeOMI+4bCpPlhou+5MK/kPp1x8ydXxfY1b2/FBmapcUTrkAu9wYyYMw9EzIrU78UZ3VG3YRcHTZ37Tt+Mz/lL6l+O7XdyIrU2SHRtF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e5H1JXbw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223f4c06e9fso69144385ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741612964; x=1742217764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxeP0cya+7a8WL+U/abw2KfwIo+gie7J/iF7xNJEC1g=;
        b=e5H1JXbwuhyAP2NhvRy/d44AT0loD/wmjfjtePVIxUcI4dYC4ZQ+AnSxcVngneUUQC
         HgCTJMRv0/IjweucUUkSgvjCoklmcra7WeNZlj4oANwmXviYx/IaddZOLTAQs15RbITp
         g6oszNdU1NPKYaHVmy8UDjwLAHIQnmeF63mGuNfxEKiGJZjYqUNe/UtZ0GZEyMuC22Bo
         fkFTYnvIfWogbJWii6eLlBN54g5wJWgZTysFHjQwLezq/36TZBQhp9krxtNJFH31+RoC
         B6j/Y/+vlJlagcNwOQDYdR7fjztY/bAGdQInM8tOGPGyySU/niTXEfuhLoYo9ZuxFxH8
         DuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741612964; x=1742217764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxeP0cya+7a8WL+U/abw2KfwIo+gie7J/iF7xNJEC1g=;
        b=eJErWgBIuaxCbAxx+ori1ZUHi9qu6gXIepbJw6Ftoqk28fUlYisNcwQoaIL34UhXcV
         FMD3W/IAcGJTDE8tnXukg9q1tihf9kaeDQ+F/4G/POv8XTinSSjJqiaJrS/WIq4obmlI
         wVVBw150NLRGCWdP+PhvZAirZePmZuk/7Q1qxlVp5KsaKzgJNQMfqy8mUQnsK2xBFvKA
         3lFFchGVHjxgIQhy1O5S8H/lBgbqtW8bfevwhUm3NYGf20jvH0WWkCgknGVgpbAuyWQk
         9IPtgpzGesWkPLWqJ9yd8qcTaGDvYSR/0r1SO4hYhFoH88E39zlU/y6x3tr/6AkdS3hq
         nnRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv9Sgk/wg/ocgDt9divEAA7hLh+RwgUiVfTnZrfIKXle6exlXkrx/XoILq5Tdf39yg82NvS3+dqrz31AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV5eYoeMRT/Q9YqN+rpYly0Rl4EhWRgyAmXhQ+QYQ99B/n5grj
	/wDEl6HlOI0l7OcIHuaPOXRtpq/yhXOIdC0p5JCNFPFQNM6nTpPbgpXkri7Q0gY=
X-Gm-Gg: ASbGnctfhKqHe3kMjNnKSnTOBk9Gn8t6EcUKl8wVlILRvvNpxXAFNzYs30D1jYv9JU6
	B/NzMKFFsCnlSNGwXOEO24aEGaJlxM88tFjLMXO2Ku1CZask18kgF2agEJRw5ujGQo3MSYRXVRw
	F0mm7wp2o2chahM24ykv+2puc7+8G+4JJnoCgzK2YSczR2jRS84c9eAqVNdb8vnidODzBoRDASq
	zchBWux5Jm4+1qiyTLPucSUWT9VXIup9tuYSmAYqtkBQKn2EwOysa4dWfqr5G5OWEhwpHrhz8C3
	EkFcqrG9dHIPXbmNt0qMId3FpMcTZrRoiziiky1n5stSGvUp5xxqnEAytjof+k8PTfO+l9I47Nc
	LAF7YdsCcnlwSiS9JK3GJ7fb0zBU=
X-Google-Smtp-Source: AGHT+IFGZvCmpJb7xpAqLXMSe32HiKjux3YzHuqmj20G2NlKQjkFcfFgUFq3QXpqyV1ePvUpOlmI/Q==
X-Received: by 2002:a17:902:ce04:b0:215:6c5f:d142 with SMTP id d9443c01a7336-22464532f5emr148863585ad.20.1741612964286;
        Mon, 10 Mar 2025 06:22:44 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e8617sm77318785ad.61.2025.03.10.06.22.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Mar 2025 06:22:44 -0700 (PDT)
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
Subject: [PATCH 4/4] iommu/riscv: Add support for Svnapot
Date: Mon, 10 Mar 2025 21:22:22 +0800
Message-Id: <20250310132222.58378-5-luxu.kernel@bytedance.com>
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

Add Svnapot size as supported page size and apply Svnapot when it is
possible.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/iommu.c | 85 +++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index ffc474987a075..379875d637901 100644
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
 	spinlock_t *ptl;
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
 	spinlock_t *ptl;
+	unsigned long pte_num;
+	pte_t pte;
+	int i;
 
 	while (unmapped < size) {
 		ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
@@ -1347,7 +1397,20 @@ static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
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
+		} else
+			set_pte(ptr, __pte(0));
 		spin_unlock(ptl);
 
 		iommu_iotlb_gather_add_page(&domain->domain, gather, iova,
@@ -1447,6 +1510,7 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	unsigned int pgd_mode;
 	dma_addr_t va_mask;
 	int va_bits, level;
+	size_t order;
 
 	iommu = dev_to_iommu(dev);
 	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
@@ -1506,6 +1570,9 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	domain->domain.geometry.aperture_end = va_mask;
 	domain->domain.geometry.force_aperture = true;
 	domain->domain.pgsize_bitmap = va_mask & (SZ_4K | SZ_2M | SZ_1G | SZ_512G);
+	if (has_svnapot())
+		for_each_napot_order(order)
+			domain->domain.pgsize_bitmap |= napot_cont_size(order) & va_mask;
 
 	domain->domain.ops = &riscv_iommu_paging_domain_ops;
 
-- 
2.20.1


