Return-Path: <linux-kernel+bounces-554320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B50A59626
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833C43B0958
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E022A4C3;
	Mon, 10 Mar 2025 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lTynP7tR"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45B22AE52
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612963; cv=none; b=BxC8Z0cAiDhO/aCP8qtY1cw7VmJTtKcJ/OEIRO4DSSTmdLOL6cUy3UAWCBvrdsg8feTvvkTsH5YnplLWfYRB4xlFNScue+Uiu7ZBavgXo0N+GqS8gL5+5vpe3JVZUxk82ORzC9h2t/kJA2gFdJ5pROWmr3YOzUT+LkPh0yI9DUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612963; c=relaxed/simple;
	bh=EcQ9/0kuftjV10r1Jc9Z3p2FVmHPYosUXDwhSMywLSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Od9L+63JRRlBzNObsxRve4IM+TiJ1oi9t9ii9WUij2u+LXVITCet1tXyocs3SJW9Plc5OoHx3PnCqSMCvqOpBGNpfbd08/uRUv6HTunCSQtJLmG3W8n25FCQdaHUzFyDnqa6S9Kub6KzasW1PZw+nGBY8SHRXitZ96jl21q8hz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lTynP7tR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2feae794508so6235919a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741612961; x=1742217761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbZEX0tRaUwuzIIhwgz0oK3rdSaEKh+GGhpQM1uwbPo=;
        b=lTynP7tRHpUuChbFzKvX2JJwUC/pzpK9b+YJGE9Jtd5cCO9aXirtBGejdetxfSP81f
         Y0qBc+YxCFIyitoa8M+XvmOtsAqEl+JJPk4hOuUu9gXLJhIWo0D1k0/uBETrAdDOF/Mk
         KcqvMg6lmAbO8txJyYNlLbJHAbNH+jd0M6eJc/pf1qdxAtIx8ZImhG09HGyNoB73/08j
         ZaQYPxSnD31fFEQeN1EiFqukXM+zPWphhGXf+KYpJ8Zl2dRLa0vIuIs8geTIv4CEKLTw
         1vTKhe0W8iSFIKxhVnAzFZPWJdxlBE0A/vyQIY8zeFxfLgCANkm1LKRkLkVsw7NpYwSx
         L8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741612961; x=1742217761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbZEX0tRaUwuzIIhwgz0oK3rdSaEKh+GGhpQM1uwbPo=;
        b=V4MlFzYOFaYWidZhuy8W0XLs/l/Ixtb/G4hMggHJOdkQbfz6ocP0fUoOQyvzss93aG
         DDivPXLx3SrBd5Uw8Grf/z22hYa/KT1ySiPMdrrOyaHRa8O298N007WoCv1+SQAjxQd5
         kzz8ggfE3K4GZj7bffiu7bzpNtaflOI7guimMbENzjBtxyruFlflhwpC0q3YZiW53HoD
         vwSbh10S1p4IFRYfcDmA+dDOMLCX24kpk/5fN0fwSe4qVI/riFRB4/ni1WULf8olwJmx
         OrcKHBiijBrHCQg2MZjRPN+dc6Wy3jZFwz1NCte2ubX34WwreMMQiAcJIV5ZXX7QM5KD
         Ts5w==
X-Forwarded-Encrypted: i=1; AJvYcCWLaaaJk3VaEsj42ntjQLvCxDEgy9mLiyCg1pm0t8KokMxMxRNqjQnbjSAy/vBdQCsRTHlEfcAatOlJqvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhDImq/JaCJ8wf5EWsBWvSBrT2TG/CraFaphd2vX7cVNM/mCVU
	970/wlM/rIHXdoYrw+JgcT2MyIEg7LFxf4fh9xQMU+TTsGpQZx+Tjrpj3EQpO6I=
X-Gm-Gg: ASbGncs/TGEUWdPlcvpXJbPQR/hQ2GmkVb4RI+znxw4P4kIy1MFvxoDwdZPPtiDpnRO
	klwG95fwhwdm33gpjYgdOY3iJP8m00onpnB4l4n/xul7n2J14h97YCaPEBV0nrah6gjIpovBrOD
	FxnswbOwT9uxZSpIQ1h77F9LwoF02myGS/1vocnH8uiQGXARcw+8IkXQy1+xTpR160rI734+IRc
	oG/C+xX2kOYG5ZZXxOIsTBS2d6MbqN9CDbGcoZQkkhQI+NIx1pnL2p7gocKjdf6tQP1dCCB+69N
	189d4whozFudhEToXZ2ekGn9qOic/PQf3AEFEId7lFWXiK5k7jon158ERWzLWT72witcEdpCLML
	S8jDH3aea7B//32vt2V0QViHgXxo=
X-Google-Smtp-Source: AGHT+IHCQte13YpgjRC8VlNMd1j/6bcecbJqZgEElVCIYtvZlpVlkeYhvsrIux781DK+TTsFHbqgBw==
X-Received: by 2002:a17:90b:4c4a:b0:2ff:7ad4:77b1 with SMTP id 98e67ed59e1d1-2ff7ce4f260mr22306375a91.2.1741612960728;
        Mon, 10 Mar 2025 06:22:40 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e8617sm77318785ad.61.2025.03.10.06.22.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Mar 2025 06:22:40 -0700 (PDT)
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
Subject: [PATCH 3/4] iommu/riscv: Introduce IOMMU page table lock
Date: Mon, 10 Mar 2025 21:22:21 +0800
Message-Id: <20250310132222.58378-4-luxu.kernel@bytedance.com>
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

Introduce page table lock to address competition issues when modifying
multiple PTEs, for example, when applying Svnapot. We use fine-grained
page table locks to minimize lock contention.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/iommu.c | 126 ++++++++++++++++++++++++++++++------
 1 file changed, 108 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index f752096989a79..ffc474987a075 100644
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
+	spinlock_t *ptl;
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
+	spinlock_t *ptl;
 	void *addr;
 
 	do {
@@ -1146,15 +1221,21 @@ static pte_t *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
 		 * page table. This might race with other mappings, retry.
 		 */
 		if (_io_pte_none(pte)) {
-			addr = iommu_alloc_page_node(domain->numa_node, gfp);
+			addr = riscv_iommu_alloc_pagetable_node(domain->numa_node, gfp,
+								level - 1);
 			if (!addr)
 				return NULL;
-			old = pte;
-			pte = _io_pte_entry(virt_to_pfn(addr), _PAGE_TABLE);
-			if (cmpxchg_relaxed(ptr, old, pte) != old) {
-				iommu_free_page(addr);
+
+			ptl = riscv_iommu_ptlock(domain, ptr, level);
+			pte = ptep_get(ptr);
+			if (!_io_pte_none(pte)) {
+				spin_unlock(ptl);
+				riscv_iommu_free_pagetable(addr, level - 1);
 				goto pte_retry;
 			}
+			pte = _io_pte_entry(virt_to_pfn(addr), _PAGE_TABLE);
+			set_pte(ptr, pte);
+			spin_unlock(ptl);
 		}
 		ptr = (pte_t *)pfn_to_virt(pte_pfn(pte));
 	} while (level-- > 0);
@@ -1194,9 +1275,10 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	size_t size = 0;
 	pte_t *ptr;
-	pte_t pte, old;
+	pte_t pte;
 	unsigned long pte_prot;
-	int rc = 0;
+	int rc = 0, level;
+	spinlock_t *ptl;
 	LIST_HEAD(freelist);
 
 	if (!(prot & IOMMU_WRITE))
@@ -1213,11 +1295,12 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
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
@@ -1252,6 +1335,7 @@ static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
 	pte_t *ptr;
 	size_t unmapped = 0;
 	size_t pte_size;
+	spinlock_t *ptl;
 
 	while (unmapped < size) {
 		ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
@@ -1262,7 +1346,9 @@ static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
 		if (iova & (pte_size - 1))
 			return unmapped;
 
+		ptl = riscv_iommu_ptlock(domain, ptr, pgsize_to_level(pte_size));
 		set_pte(ptr, __pte(0));
+		spin_unlock(ptl);
 
 		iommu_iotlb_gather_add_page(&domain->domain, gather, iova,
 					    pte_size);
@@ -1292,13 +1378,14 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
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
 
@@ -1359,7 +1446,7 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	struct riscv_iommu_device *iommu;
 	unsigned int pgd_mode;
 	dma_addr_t va_mask;
-	int va_bits;
+	int va_bits, level;
 
 	iommu = dev_to_iommu(dev);
 	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
@@ -1382,11 +1469,14 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 
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
@@ -1395,7 +1485,7 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
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


