Return-Path: <linux-kernel+bounces-556114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA81A5C12D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A61167659
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444882571B1;
	Tue, 11 Mar 2025 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zky2lgGT"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE625CC7F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695933; cv=none; b=epEopOoML1cTFo/uXfg1IxFKxBX3FKaVZk4x7fW7Y5/zpWiow7VSVDUyDzZVrSVv51K5hKyxJ2sWfpPNRQI9c4VMSnZfH9nGAIt48H2XUmQE8UZeE9FfS/7UjdgqcYxUZ3oIMjUdKGn3LAjOUX/yaQ4CvPPIpxr9j7FpyF8Nd9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695933; c=relaxed/simple;
	bh=+wRpuN0A/HjofcnYPeltvF9g4Pbwgb7sI3k1r3yDo7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i9DRjtXKpU0RKIvYqy23UkrzS3KcGt2G4fkARZAUNxlNeupWUt/B4M9aJHMSMxPNgj4dXa8r1P4WZtPTUiNVTNCknYcZfwuJvArahUZbKbwKL91jTpr0svbwNAjokoNt8+BcwHN4o0lxSvQqslbXckAEp17a7rSVGOvblwhkFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zky2lgGT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22337bc9ac3so101171805ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741695931; x=1742300731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaRB3Z7Zn9kGyUKfUpl8WYZaXTZf5T6vpq1GZf0TWl4=;
        b=Zky2lgGTS9rIAvVETCO0Dq9lWWEfU9CJwt1aouuG7hrsbfz5DBB6UvoQBIZPHy9Geq
         L9WZHDQDChUOgoMmevzdiv+fs0tbdpIJUDma5m2ISbzDNNdTHQu8P9jWF/Ljc5xXoH2F
         N0ZEKKXvaz/66NrGXZps6O1IybdErCaidtU8xt4JYFqhniJQy5XwninvBYX2Kk+KtxPk
         cM/IgetwS0bBVxoSIJiQFgn8LhZguA8jraWKevv07j4fAFxkgS5bm4FMDceCc0I5W4+F
         2U3jXlFxg+Q+c7LluGGPEvQIpDEjxl7LZl9VNwIBg09aqlt1wdz8y90qfdS6ix6l9lLR
         /ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741695931; x=1742300731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaRB3Z7Zn9kGyUKfUpl8WYZaXTZf5T6vpq1GZf0TWl4=;
        b=G9Iw6gFO7/YjTbEyTfsz8Qbvr3mLya3yC0uxUj/eAW3dRAvyTFA9LQo6QV5o+USz/m
         V/TbSSTlnzbmojobX9yStDyE7L3TwpU45mtzDIQRApfBXUt08nkTuz1wHrzleUkddo1J
         Sl5ADsyuvjVtjsSkdj2BijdclFYxpaXN7TLBY2CunII4Ogkc1KzktAUTuME9K39+XC9b
         9zPCKW7zLkY0dtrHWLFYnvGOpKqSM+LHyVPW7A6/wtKABgUavc8v+c1khP/74X/E9WP2
         H5Z84o9FnlJ+LmQpaAWNuH9Us1Qq8+BhOT+05mY80yPQrPCDcFznLZo2x9UUvb6xxAQ3
         F1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFdcpjKIx+MgRGSCPz+6E2ujug0p+LmZgirbf6oN7EA7a3LDHU8fvFs+dL/OGey1CEOqmz1mn7hnnApig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXnpL7Tlef9AXjx24c/lKycwFBUTNgDbIMJxAiN7uxiba8YifH
	GYx7Ffs2HTo7Cj6FjSnpjuDf2+BQ72Da/YzQNirSof+pOBb0BHJjZuxK7F1yRUU=
X-Gm-Gg: ASbGnctONAOBac4Nn3FulzMM1juYsFvxQMGOG7jCye/HC+HvcLayRR90578euH9kcXO
	f7C9tsEikb9vTDOqnb7lMdHDfVvgfcYpHrxI9v4UOkrnlDLJYrIMJm7JykVv4ZmNvBATE/+Xelh
	PaB16zT4yppqv2JqcpKIQg40H0UGTjH/Xtt8APKLcSmg4jilRTjILxpQKFEDh3VliF1iEfWzu/M
	rwpipehnu7nBTZzcj2Rz/IVspfNBxOrHA/ZmcdDfJjBkBj4XCZuIXKAnEmNNY+oBV3/kLmd/3Hh
	VMS5s+gVYtud7KsvLmA2K3L8SPmidcpoOKTTrVQrzQXRFVyvC0NXDe79AbiHmFSfZF6V3SVQdl8
	ycR35tZZON6o1f1SJJga5uECPSoRa3c6vu6+awg==
X-Google-Smtp-Source: AGHT+IHyZHInMD5SykYccWKdstIzjRz05MOYhFQPfcCcFj0ULoo9WguYAXrHgJpVCASbofOODWBviA==
X-Received: by 2002:a05:6a00:10d5:b0:736:47a5:e268 with SMTP id d2e1a72fcca58-736eb7b363bmr4610912b3a.1.1741695930617;
        Tue, 11 Mar 2025 05:25:30 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698450244sm10226621b3a.80.2025.03.11.05.25.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Mar 2025 05:25:30 -0700 (PDT)
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
Subject: [PATCH v2 3/4] iommu/riscv: Introduce IOMMU page table lock
Date: Tue, 11 Mar 2025 20:25:09 +0800
Message-Id: <20250311122510.72934-4-luxu.kernel@bytedance.com>
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


