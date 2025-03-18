Return-Path: <linux-kernel+bounces-565427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F937A667F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B347188B68C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD0D1ADC67;
	Tue, 18 Mar 2025 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ABoydGab"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860401C3BF7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270398; cv=none; b=BEbXkboeH1g9JXes3bZgoPkWNyO20JVKWwc4L/ylEM8k5u5QCy/0+9wDpST/MNa1O29o/C8I6cmq8e7UNJAKJhLEa+ubofsCjjhyySwdI7v8Mab7U1X2CZIc1mDGe5DjxKZCWNVYB/Rw/zrJ7l+eKKatDITQhwE5BNYZy+xsu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270398; c=relaxed/simple;
	bh=+wRpuN0A/HjofcnYPeltvF9g4Pbwgb7sI3k1r3yDo7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCHWMQXe6V2mkJ7XgROoaL/ZGNIwl/fAmAgMz79rH1SQAOdb/UeV3zbHJrQ/JclbYGNoyjGibiEk0dsPJqQE9BMACn/2BpB6Roqt/aBHU4dM9VMovF2H2nOkEA/FDfJTJY0rzt0gjGz1ge1+pN9fVrJI2VP6mmnWkSXaxZT4xXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ABoydGab; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2241053582dso47153595ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742270396; x=1742875196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaRB3Z7Zn9kGyUKfUpl8WYZaXTZf5T6vpq1GZf0TWl4=;
        b=ABoydGab2xRkj0xcnWwrvCHU9yOm/4PQVDimTTBJTEs6Rti/axjNRJkMGLHGcIU83u
         w00s+n9RMAJxrhm3mbP3Yax+PgFHdATR6fmNxvhSVxTsnYMXTGaAB61+s4i/t1tihyj+
         J0ExMtN0yN9EmFouOfRjdbK33flCigCb/OOQMCy4z4XS0JYaZaksB1EtRjvq6UXPb/3M
         GDDHk2ulUcFEMIScq1qDLQUq/VR7W/kpS+uoGpfqvQmm1iwH/iO7O6dYK2n46HXNqosz
         jwRfw4aHVMvyfLUOwCU4ofQdMBl9SMa5ixcQhDxR++z3RjLQ9ZFjKhFgAO/xoS/P41rx
         O0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742270396; x=1742875196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaRB3Z7Zn9kGyUKfUpl8WYZaXTZf5T6vpq1GZf0TWl4=;
        b=j3q6M976ubr9jt9cfrwfkZzFzb0OQwR5rxUDTrF0tf9L7+/uIyElzNqh6k3VFTZTky
         OD2lDLg6oo1O6RdigUOKODaZQfHrfUEay/vKg+8Ndv5f/ojxpNqjSSRCl5u74YrhdoYc
         srA4OKFm2EUIPKwAVK/NgBfvAldzjUxzUv3GjBtUtdCvsq96w69VIk7Lftr/2JYevC7+
         S7NTcW8tR4RF1cb/PR37rqIoK6qx85Xl9NdYAm5nqWkHlVNuJuG1ApBwuPhOKYA7+HyO
         WtaTUncFNQrnu/FIumX0W3v9BB0wy/BDAmEeDv7qvY0MipXxxgmr4T6Wmm58RhSTk38v
         HC/g==
X-Forwarded-Encrypted: i=1; AJvYcCXXDHxXVWC45QHE+aKRJ/F11KKrJS+fGdYcPTVjDsUB0S53JouwdiuksHQdx965r+5QbHkLjOnR5CU9UTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/kc7XzqiIJ1VkGykO1/03o8cDomp2BxUU+jghZlflAQe4Efac
	XweZqsFY0aLZqygIEus3SvIz9Cx9oUqD2tHuwPuKgX+ILVHVtJu4/1xpI4/KRvI=
X-Gm-Gg: ASbGncvbI3YLmdMVSwMEvW0BFTBYXkoyre3aexYvKnGKs8WEP6Ev6sEc1pEkqAJ+q8H
	w0TgL7a/FQG5gc/+GbUL5wNmpl+RYbe48L6E+JWClqf8V46vqxJAuX1sxHbgP8nhnm/9QXU+Z3F
	1ScP5iPGGdmb4T3qzv23UvsJFuv+QybZL4vyHqNLgD925vwYXiKDMB1wwQsaM/7f65BSbYTVSK7
	5cg9+6gSNAI9S29DfvltiNyDKaSh21aYXRnvEj6UuRKXV6SPuxVVT1iIXkLyDeEYa5pAlE+Yfbe
	HAgNBiETFTrr+OMYxZhv53hAuEJocadKms1wtSy4C3gMfYXD+s6FZ0pTKBSp1ZW4jeCU2SVPIEU
	vog096bSxoVyIlv5MQc9K8OOimG0=
X-Google-Smtp-Source: AGHT+IExX+iDrDCGHA8Aq12SWZuDNNckGnu8pihoRkyjLOg0HP1RuQ216rkdL14FWV3g+VDeX680Yg==
X-Received: by 2002:a17:903:238b:b0:223:6180:1bf7 with SMTP id d9443c01a7336-225e0b2fba7mr186404745ad.42.1742270395708;
        Mon, 17 Mar 2025 20:59:55 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4b30sm83720135ad.235.2025.03.17.20.59.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Mar 2025 20:59:54 -0700 (PDT)
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
Subject: [PATCH RESEND v2 3/4] iommu/riscv: Introduce IOMMU page table lock
Date: Tue, 18 Mar 2025 11:59:29 +0800
Message-Id: <20250318035930.11855-4-luxu.kernel@bytedance.com>
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

Introduce page table lock to address competition issues when modifying
multiple PTEs, for example, when applying Svnapot. We use fine-grained
page table locks to minimize lock contention.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/iommu.c | 123 +++++++++++++++++++++++++++++++-----
 1 file changed, 107 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 3b0c934decd08..ce4cf6569ffb4 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -808,6 +808,7 @@ struct riscv_iommu_domain {
 	struct iommu_domain domain;
 	struct list_head bonds;
 	spinlock_t lock;		/* protect bonds list updates. */
+	spinlock_t page_table_lock;	/* protect page table updates. */
 	int pscid;
 	bool amo_enabled;
 	int numa_node;
@@ -1086,8 +1087,80 @@ static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
 #define _io_pte_none(pte)	(pte_val(pte) == 0)
 #define _io_pte_entry(pn, prot)	(__pte((_PAGE_PFN_MASK & ((pn) << _PAGE_PFN_SHIFT)) | (prot)))
 
+#define RISCV_IOMMU_PMD_LEVEL		1
+
+static bool riscv_iommu_ptlock_init(struct ptdesc *ptdesc, int level)
+{
+	if (level <= RISCV_IOMMU_PMD_LEVEL)
+		return ptlock_init(ptdesc);
+	return true;
+}
+
+static void riscv_iommu_ptlock_free(struct ptdesc *ptdesc, int level)
+{
+	if (level <= RISCV_IOMMU_PMD_LEVEL)
+		ptlock_free(ptdesc);
+}
+
+static spinlock_t *riscv_iommu_ptlock(struct riscv_iommu_domain *domain,
+				      pte_t *pte, int level)
+{
+	spinlock_t *ptl; /* page table page lock */
+
+#ifdef CONFIG_SPLIT_PTE_PTLOCKS
+	if (level <= RISCV_IOMMU_PMD_LEVEL)
+		ptl = ptlock_ptr(page_ptdesc(virt_to_page(pte)));
+	else
+#endif
+		ptl = &domain->page_table_lock;
+	spin_lock(ptl);
+
+	return ptl;
+}
+
+static void *riscv_iommu_alloc_pagetable_node(int numa_node, gfp_t gfp, int level)
+{
+	struct ptdesc *ptdesc;
+	void *addr;
+
+	addr = iommu_alloc_page_node(numa_node, gfp);
+	if (!addr)
+		return NULL;
+
+	ptdesc = page_ptdesc(virt_to_page(addr));
+	if (!riscv_iommu_ptlock_init(ptdesc, level)) {
+		iommu_free_page(addr);
+		addr = NULL;
+	}
+
+	return addr;
+}
+
+static void riscv_iommu_free_pagetable(void *addr, int level)
+{
+	struct ptdesc *ptdesc = page_ptdesc(virt_to_page(addr));
+
+	riscv_iommu_ptlock_free(ptdesc, level);
+	iommu_free_page(addr);
+}
+
+static int pgsize_to_level(size_t pgsize)
+{
+	int level = RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57 -
+			RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 + 2;
+	int shift = PAGE_SHIFT + PT_SHIFT * level;
+
+	while (pgsize < ((size_t)1 << shift)) {
+		shift -= PT_SHIFT;
+		level--;
+	}
+
+	return level;
+}
+
 static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
-				 pte_t pte, struct list_head *freelist)
+				 pte_t pte, int level,
+				 struct list_head *freelist)
 {
 	pte_t *ptr;
 	int i;
@@ -1102,10 +1175,11 @@ static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
 		pte = ptr[i];
 		if (!_io_pte_none(pte)) {
 			ptr[i] = __pte(0);
-			riscv_iommu_pte_free(domain, pte, freelist);
+			riscv_iommu_pte_free(domain, pte, level - 1, freelist);
 		}
 	}
 
+	riscv_iommu_ptlock_free(page_ptdesc(virt_to_page(ptr)), level);
 	if (freelist)
 		list_add_tail(&virt_to_page(ptr)->lru, freelist);
 	else
@@ -1117,8 +1191,9 @@ static pte_t *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
 				    gfp_t gfp)
 {
 	pte_t *ptr = domain->pgd_root;
-	pte_t pte, old;
+	pte_t pte;
 	int level = domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 + 2;
+	spinlock_t *ptl; /* page table page lock */
 	void *addr;
 
 	do {
@@ -1146,14 +1221,21 @@ static pte_t *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
 		 * page table. This might race with other mappings, retry.
 		 */
 		if (_io_pte_none(pte)) {
-			addr = iommu_alloc_page_node(domain->numa_node, gfp);
+			addr = riscv_iommu_alloc_pagetable_node(domain->numa_node, gfp,
+								level - 1);
 			if (!addr)
 				return NULL;
-			old = ptep_get(ptr);
-			if (!_io_pte_none(old))
+
+			ptl = riscv_iommu_ptlock(domain, ptr, level);
+			pte = ptep_get(ptr);
+			if (!_io_pte_none(pte)) {
+				spin_unlock(ptl);
+				riscv_iommu_free_pagetable(addr, level - 1);
 				goto pte_retry;
+			}
 			pte = _io_pte_entry(virt_to_pfn(addr), _PAGE_TABLE);
 			set_pte(ptr, pte);
+			spin_unlock(ptl);
 		}
 		ptr = (pte_t *)pfn_to_virt(pte_pfn(pte));
 	} while (level-- > 0);
@@ -1193,9 +1275,10 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	size_t size = 0;
 	pte_t *ptr;
-	pte_t pte, old;
+	pte_t pte;
 	unsigned long pte_prot;
-	int rc = 0;
+	int rc = 0, level;
+	spinlock_t *ptl; /* page table page lock */
 	LIST_HEAD(freelist);
 
 	if (!(prot & IOMMU_WRITE))
@@ -1212,11 +1295,12 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
 			break;
 		}
 
-		old = ptep_get(ptr);
+		level = pgsize_to_level(pgsize);
+		ptl = riscv_iommu_ptlock(domain, ptr, level);
+		riscv_iommu_pte_free(domain, ptep_get(ptr), level, &freelist);
 		pte = _io_pte_entry(phys_to_pfn(phys), pte_prot);
 		set_pte(ptr, pte);
-
-		riscv_iommu_pte_free(domain, old, &freelist);
+		spin_unlock(ptl);
 
 		size += pgsize;
 		iova += pgsize;
@@ -1251,6 +1335,7 @@ static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
 	pte_t *ptr;
 	size_t unmapped = 0;
 	size_t pte_size;
+	spinlock_t *ptl; /* page table page lock */
 
 	while (unmapped < size) {
 		ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
@@ -1261,7 +1346,9 @@ static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
 		if (iova & (pte_size - 1))
 			return unmapped;
 
+		ptl = riscv_iommu_ptlock(domain, ptr, pgsize_to_level(pte_size));
 		set_pte(ptr, __pte(0));
+		spin_unlock(ptl);
 
 		iommu_iotlb_gather_add_page(&domain->domain, gather, iova,
 					    pte_size);
@@ -1291,13 +1378,14 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	const unsigned long pfn = virt_to_pfn(domain->pgd_root);
+	int level = domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 + 2;
 
 	WARN_ON(!list_empty(&domain->bonds));
 
 	if ((int)domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
 
-	riscv_iommu_pte_free(domain, _io_pte_entry(pfn, _PAGE_TABLE), NULL);
+	riscv_iommu_pte_free(domain, _io_pte_entry(pfn, _PAGE_TABLE), level, NULL);
 	kfree(domain);
 }
 
@@ -1358,7 +1446,7 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	struct riscv_iommu_device *iommu;
 	unsigned int pgd_mode;
 	dma_addr_t va_mask;
-	int va_bits;
+	int va_bits, level;
 
 	iommu = dev_to_iommu(dev);
 	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
@@ -1381,11 +1469,14 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 
 	INIT_LIST_HEAD_RCU(&domain->bonds);
 	spin_lock_init(&domain->lock);
+	spin_lock_init(&domain->page_table_lock);
 	domain->numa_node = dev_to_node(iommu->dev);
 	domain->amo_enabled = !!(iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD);
 	domain->pgd_mode = pgd_mode;
-	domain->pgd_root = iommu_alloc_page_node(domain->numa_node,
-						 GFP_KERNEL_ACCOUNT);
+	level = domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 + 2;
+	domain->pgd_root = riscv_iommu_alloc_pagetable_node(domain->numa_node,
+							    GFP_KERNEL_ACCOUNT,
+							    level);
 	if (!domain->pgd_root) {
 		kfree(domain);
 		return ERR_PTR(-ENOMEM);
@@ -1394,7 +1485,7 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
 					RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
 	if (domain->pscid < 0) {
-		iommu_free_page(domain->pgd_root);
+		riscv_iommu_free_pagetable(domain->pgd_root, level);
 		kfree(domain);
 		return ERR_PTR(-ENOMEM);
 	}
-- 
2.20.1


