Return-Path: <linux-kernel+bounces-565426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D0BA667F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B422C17A48C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88971A9B52;
	Tue, 18 Mar 2025 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="k140h19y"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C721BC099
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270393; cv=none; b=OAkxWA93SqkBN01Fnf8H51W+x/VwahWaJUcggFRcmFtiJ6BDeiWmLlrkoErpcll72VzZrt07df8PCp4/Y79xHhi5k1Y7l8VUaIEMVGdtt1tWmN408/JneEdAgHYq+UPvt4l9nBhlekx4wVHJ+cPZea1YqXGSXmWutVU8pfOt2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270393; c=relaxed/simple;
	bh=yjkhHriFUj/pjJLTsHrBMQnNQw7+EpDNpDVbDZBqKTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCbNLfcDKVED/0cPWxyFpcD3HfQ2PYUYDqsnvKdWYRURg7w0pdJlgYf3e7+1dNTpuw4G+f4wobZTjfevGDx+kfZjzkBnzheX8SVnrhmWHaIJP2CrLcNSXxNPGbI9M1OSX4bzrr8Ro3rHweWw3xpLeMaa+ShcQMlpk5ydmt4XXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=k140h19y; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22398e09e39so109859485ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742270390; x=1742875190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RzuTPLpNm7preMNxFl4olDUAY05FyWZH15sy7wmcR0=;
        b=k140h19yIS0k+9Om3zkwuECp43DxOKxa+N8F4tRzoEXQVIU+IpaytNBnXiLIpOQfjd
         LgaDTarfIWzhlSQbyBAkYEBDNlqvh1KGgeGSZ1kzU0n9Yg3kQNUanTkKC4LEJ/73COkB
         Rl6iEuduvwkmFFUNiWx226cRX/Br4dYsMcuV90ylWzC6uY1VjAkvQ4E2Eyy5me/LqCRr
         qK/3wEeAB/VKpExVTMKHqwPKr8ELp5lpUJTR6f2yLi8e3VIxUd3sYZq61Hw8L1vRDl5J
         nNz4FO+7DWxH3EwGFYQubCnwDvi41AHIZBU56mNIKa7R7yCobk4Sg+hcxdiaP2fCUHm7
         NliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742270390; x=1742875190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RzuTPLpNm7preMNxFl4olDUAY05FyWZH15sy7wmcR0=;
        b=lHMmo1UqYjH2h+uuL3lLMsqeyUgYM1UzmLoODJGZ7qXWQCfPX/Hh1t/Sg3AiOqJCe3
         EdLsA19gsJ731Ic4Wwkg0xyt+Z6+RzBnyOjpN2rT2xQjk8sL04cwqi3ZbmcVSH1pXRLH
         eZYiwJ0gXSjBeqACkzNh0nSNmncliW6AKlynx5Cb9J0I6E0h1+VKwNEJe+dq4twtRvoL
         2y2mIDhPAvfU8vr48rDKh/Wda7Vq+p7/x2Xvmv9Q/F+z+CLwpMITsSIhIahgct9dxuTW
         Dw2grfk1+6ge3nMt7r1nRC/vQ9gZM3I/nH/HMFvSw54ji2M4VpDnBtns+hA8Ly6LrQDZ
         EOWg==
X-Forwarded-Encrypted: i=1; AJvYcCXoGL9PzbusJRwI57wD03GAY9gRHLq43fc7XBpZ/R+o6j6Sok3FXihjiOV6natygtPru5AQoFe9tG8jQdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHlOOeKVsSmBLCS7pUHiWXggAq6DsUKMcnxlkuPUxJH4XoBBbP
	5QLlzuc2+m8iK0qQmbkRZ6oDlTl/3HU737jKkAswHPVHJkt6Sl9+IPYgE2pc3Z8=
X-Gm-Gg: ASbGnct34FW/i6H88p+9K2nz1LYUFnnxfZOt32BCW44VGonhlIK+832dOF0GMD9umPI
	1DKXHjwjeWar8hRjMRI40OvA50nc2px1hCxAV+/ln3Rcm1eqDdLNblvvywfCZhj3Jm+InWNZ6Pk
	PuQYtI+12Hf6yu2DI64Uh7BS/spPZUr0glSYt4EdG+5npv5PA9t0ISZ/Y8l3CRwH1X5rnxT9wZx
	FkD/+N6FOA2U0oWU4Kg/wEJnllFQ/1NiYP8grmkBHchoAonW2W5afG4UgczJNbp7oJqbDcMHSrk
	ga2yJk8Lfrb5sImLeunCBEl9ge5YMqK0e8cUy281ur6tvChFbUIjlk1etODa6OaNtcSku0/+HaZ
	BqgbycKF2uy63WvbPKGxIbIlOgII=
X-Google-Smtp-Source: AGHT+IFE368rAoYFIO0lZVoCVYA7ODibd0bQTYRx4G4UreI6PSfoC7ExcjehLoXI4QO5c2ehzPanCg==
X-Received: by 2002:a17:902:e886:b0:211:e812:3948 with SMTP id d9443c01a7336-225e08597f2mr204021375ad.0.1742270390531;
        Mon, 17 Mar 2025 20:59:50 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4b30sm83720135ad.235.2025.03.17.20.59.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Mar 2025 20:59:49 -0700 (PDT)
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
Subject: [PATCH RESEND v2 2/4] iommu/riscv: Use pte_t to represent page table entry
Date: Tue, 18 Mar 2025 11:59:28 +0800
Message-Id: <20250318035930.11855-3-luxu.kernel@bytedance.com>
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

Since RISC-V IOMMU has the same pte format and translation process with
MMU as is specified in RISC-V Privileged specification, we use pte_t to
represent IOMMU pte too to reuse existing pte operation functions.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/iommu.c | 79 ++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8f049d4a0e2cb..3b0c934decd08 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -812,7 +812,7 @@ struct riscv_iommu_domain {
 	bool amo_enabled;
 	int numa_node;
 	unsigned int pgd_mode;
-	unsigned long *pgd_root;
+	pte_t *pgd_root;
 };
 
 #define iommu_domain_to_riscv(iommu_domain) \
@@ -1081,27 +1081,29 @@ static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
 
 #define PT_SHIFT (PAGE_SHIFT - ilog2(sizeof(pte_t)))
 
-#define _io_pte_present(pte)	((pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE))
-#define _io_pte_leaf(pte)	((pte) & _PAGE_LEAF)
-#define _io_pte_none(pte)	((pte) == 0)
-#define _io_pte_entry(pn, prot)	((_PAGE_PFN_MASK & ((pn) << _PAGE_PFN_SHIFT)) | (prot))
+#define _io_pte_present(pte)	(pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE))
+#define _io_pte_leaf(pte)	(pte_val(pte) & _PAGE_LEAF)
+#define _io_pte_none(pte)	(pte_val(pte) == 0)
+#define _io_pte_entry(pn, prot)	(__pte((_PAGE_PFN_MASK & ((pn) << _PAGE_PFN_SHIFT)) | (prot)))
 
 static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
-				 unsigned long pte, struct list_head *freelist)
+				 pte_t pte, struct list_head *freelist)
 {
-	unsigned long *ptr;
+	pte_t *ptr;
 	int i;
 
 	if (!_io_pte_present(pte) || _io_pte_leaf(pte))
 		return;
 
-	ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
+	ptr = (pte_t *)pfn_to_virt(pte_pfn(pte));
 
 	/* Recursively free all sub page table pages */
 	for (i = 0; i < PTRS_PER_PTE; i++) {
-		pte = READ_ONCE(ptr[i]);
-		if (!_io_pte_none(pte) && cmpxchg_relaxed(ptr + i, pte, 0) == pte)
+		pte = ptr[i];
+		if (!_io_pte_none(pte)) {
+			ptr[i] = __pte(0);
 			riscv_iommu_pte_free(domain, pte, freelist);
+		}
 	}
 
 	if (freelist)
@@ -1110,12 +1112,12 @@ static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
 		iommu_free_page(ptr);
 }
 
-static unsigned long *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
-					    unsigned long iova, size_t pgsize,
-					    gfp_t gfp)
+static pte_t *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
+				    unsigned long iova, size_t pgsize,
+				    gfp_t gfp)
 {
-	unsigned long *ptr = domain->pgd_root;
-	unsigned long pte, old;
+	pte_t *ptr = domain->pgd_root;
+	pte_t pte, old;
 	int level = domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 + 2;
 	void *addr;
 
@@ -1131,7 +1133,7 @@ static unsigned long *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
 		if (((size_t)1 << shift) == pgsize)
 			return ptr;
 pte_retry:
-		pte = READ_ONCE(*ptr);
+		pte = ptep_get(ptr);
 		/*
 		 * This is very likely incorrect as we should not be adding
 		 * new mapping with smaller granularity on top
@@ -1147,38 +1149,37 @@ static unsigned long *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
 			addr = iommu_alloc_page_node(domain->numa_node, gfp);
 			if (!addr)
 				return NULL;
-			old = pte;
-			pte = _io_pte_entry(virt_to_pfn(addr), _PAGE_TABLE);
-			if (cmpxchg_relaxed(ptr, old, pte) != old) {
-				iommu_free_page(addr);
+			old = ptep_get(ptr);
+			if (!_io_pte_none(old))
 				goto pte_retry;
-			}
+			pte = _io_pte_entry(virt_to_pfn(addr), _PAGE_TABLE);
+			set_pte(ptr, pte);
 		}
-		ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
+		ptr = (pte_t *)pfn_to_virt(pte_pfn(pte));
 	} while (level-- > 0);
 
 	return NULL;
 }
 
-static unsigned long *riscv_iommu_pte_fetch(struct riscv_iommu_domain *domain,
-					    unsigned long iova, size_t *pte_pgsize)
+static pte_t *riscv_iommu_pte_fetch(struct riscv_iommu_domain *domain,
+				    unsigned long iova, size_t *pte_pgsize)
 {
-	unsigned long *ptr = domain->pgd_root;
-	unsigned long pte;
+	pte_t *ptr = domain->pgd_root;
+	pte_t pte;
 	int level = domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 + 2;
 
 	do {
 		const int shift = PAGE_SHIFT + PT_SHIFT * level;
 
 		ptr += ((iova >> shift) & (PTRS_PER_PTE - 1));
-		pte = READ_ONCE(*ptr);
+		pte = ptep_get(ptr);
 		if (_io_pte_present(pte) && _io_pte_leaf(pte)) {
 			*pte_pgsize = (size_t)1 << shift;
 			return ptr;
 		}
 		if (_io_pte_none(pte))
 			return NULL;
-		ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
+		ptr = (pte_t *)pfn_to_virt(pte_pfn(pte));
 	} while (level-- > 0);
 
 	return NULL;
@@ -1191,8 +1192,9 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	size_t size = 0;
-	unsigned long *ptr;
-	unsigned long pte, old, pte_prot;
+	pte_t *ptr;
+	pte_t pte, old;
+	unsigned long pte_prot;
 	int rc = 0;
 	LIST_HEAD(freelist);
 
@@ -1210,10 +1212,9 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
 			break;
 		}
 
-		old = READ_ONCE(*ptr);
+		old = ptep_get(ptr);
 		pte = _io_pte_entry(phys_to_pfn(phys), pte_prot);
-		if (cmpxchg_relaxed(ptr, old, pte) != old)
-			continue;
+		set_pte(ptr, pte);
 
 		riscv_iommu_pte_free(domain, old, &freelist);
 
@@ -1247,7 +1248,7 @@ static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	size_t size = pgcount << __ffs(pgsize);
-	unsigned long *ptr, old;
+	pte_t *ptr;
 	size_t unmapped = 0;
 	size_t pte_size;
 
@@ -1260,9 +1261,7 @@ static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
 		if (iova & (pte_size - 1))
 			return unmapped;
 
-		old = READ_ONCE(*ptr);
-		if (cmpxchg_relaxed(ptr, old, 0) != old)
-			continue;
+		set_pte(ptr, __pte(0));
 
 		iommu_iotlb_gather_add_page(&domain->domain, gather, iova,
 					    pte_size);
@@ -1279,13 +1278,13 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	size_t pte_size;
-	unsigned long *ptr;
+	pte_t *ptr;
 
 	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
-	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
+	if (_io_pte_none(ptep_get(ptr)) || !_io_pte_present(ptep_get(ptr)))
 		return 0;
 
-	return pfn_to_phys(__page_val_to_pfn(*ptr)) | (iova & (pte_size - 1));
+	return pfn_to_phys(pte_pfn(ptep_get(ptr))) | (iova & (pte_size - 1));
 }
 
 static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
-- 
2.20.1


