Return-Path: <linux-kernel+bounces-554319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACEBA59621
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A3C16E87F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE829227E8F;
	Mon, 10 Mar 2025 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Nf9tyn0U"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4A22A4C3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612959; cv=none; b=NXLS8Wq9VBcmT9wla8lefwPZnwlAX8yhwI5QK+c1GXgvHkh9NhIC0OH+cb8V0t7tG0456fCR5ZWIcntCDhafR31SeFVwqT5ViLOsW7m5Ib8soIrXBRGxG6uapxBIvIA4GsybmvNK01tlKSGq4uqn11eZfoDx8CSUcGNDIEEKic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612959; c=relaxed/simple;
	bh=Nmr5d7AwhXzi32rUJoW0NKVITyBiEMPY6kXQ9pwa5fM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LvTJNXy4/k2CVsG734jNPycI7wsFiKFQaPsSZ1xGwp1Sa8eRFaSRoYSaLxYIpBVyTLQvKuavUi1dj2WbdcIblbKo/HrlpF53UON1Mg5MdoVm9Nrfn9vUsqfvI8K/FO1JH9JUoOI4dA+EkckdmOMljfg6KdJnSf1t5i3PQJOk2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Nf9tyn0U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-225477548e1so28404535ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741612957; x=1742217757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZMOD/Qf6hHTG0QsYxy12Mjhes8Th3228e4iu7j8c1w=;
        b=Nf9tyn0U093zi8ErEFiueApqtgSDjC8AVdhC3u5SeFnypk85/YSph0RnbmeRACMeuM
         XeJkXVezGHDvYmYEKwiR8QCNOv47eZjqZ/fk03fevkPLFcmCKfjFhtNo2C1Had6BO0MT
         ksuggH8TsXLUwvleGMVGvcsVBIf1r9i8dEGyBSfLJx6E91JH2pUsBKeKYmy6G2vgHkUP
         zxuOKXuqXkIFQ8V5qN1IChqdUaJbB+DP4HSJHkZFjGVpHx7r+H/6aU985xGJEjRXn82k
         pHhxqZbpGZJJfLiq+AaL9P/tsBLASYKgrRG2Phex6fTIKvDn6iFgKYrwegiTnmSUyfD/
         A2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741612957; x=1742217757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZMOD/Qf6hHTG0QsYxy12Mjhes8Th3228e4iu7j8c1w=;
        b=hQPx4BWo5lx1ZuURicJRKP0fuWsLEmWTTIgJtX2Sn0Qghh2d1QX5VMVooUsch2ZJwo
         3UmhR9VxigqJfrfQ1Z5NSbJou/d8QPp80QfB5LeGIA82y535E+WQie2qBnP76u1B2FNj
         1QQYeEOwsXBsRCWzXtOO7UEvboQLUKJ36L+M7Xqid1PJjJKQoRX9MDEZkBtUzzZQVB3U
         wReyreujTE2w/hwP7EdCUdmfT1qAaJKUOXDcImUrp7Yofkae0IMSzFaLGKSbHBd/r+Vm
         wXJJCdqkQ4NRPop0Hi8Tg66Czmp2eee0miU2aO6UtZOpyFHZCu0dlIpedoN+Tvi3W3XR
         D3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWroAo8vM7/+EUGBx24OeH9JPcWJGnDrlnXY95goAB6PKa8Xc/XFu4InJA3cBKVgPHOUFmZWKtgVj4sS5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6QqRhFPhfY0VbuhQnxTDu2iBstqz2foaW8n3FMZCMJX3iZ5h
	7dQFQZOLzyH2EAjXNJJrHA1dnJlS8dG8/+TgWXmjalT5gFYk38zgRTdPNSW4dQM=
X-Gm-Gg: ASbGncvKWQpEdrzGCdNBCe767CKDSjsHot1Xds1NtJCoQ6OpwWGesSqzJ9738NpuOAR
	PfC4ard5as+ppNMtRrZFXjlXq/+tQb5z94aRxZw8CUhQDV8TOhM4+ITlPzCiboQY0z9DFzmYwyD
	wpa2Vj48ymNxUZBgsXXhIuFEthA/5SsrzREZdXcSHRyMXkioRiW8j06mYlAuNfTmcz9/ceTAJzC
	MafEzbNfhFt50lQQeEbiqX8OT0EWTw2VidqGUsJL/1BNLJ6d2e8/n0hI89rnAAlOZFoAF0XYsTy
	czbipYrVDVR3TVHBUdS4WtlKFdp5FMlVV4e2AOvtGgvU5F5evqJl/ehQHuFY6HiLUKFXMIX74k1
	WN85S2pVBAmlm9oZ1RVgWn98pBG8=
X-Google-Smtp-Source: AGHT+IFwyZ7/tPtBqU0g9RIHfp+iyK4Go8JH9gtSnoe0FV3ZnIyO4IbhPZG1IS3E7YfaXc51VxACFw==
X-Received: by 2002:a17:903:1790:b0:224:2a6d:55ae with SMTP id d9443c01a7336-2242a6d585emr214130785ad.48.1741612957112;
        Mon, 10 Mar 2025 06:22:37 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e8617sm77318785ad.61.2025.03.10.06.22.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Mar 2025 06:22:36 -0700 (PDT)
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
Subject: [PATCH 2/4] iommu/riscv: Use pte_t to represent page table entry
Date: Mon, 10 Mar 2025 21:22:20 +0800
Message-Id: <20250310132222.58378-3-luxu.kernel@bytedance.com>
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

Since RISC-V IOMMU has the same pte format and translation process with
MMU as is specified in RISC-V Privileged specification, we use pte_t to
represent IOMMU pte too to reuse existing pte operation functions.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/iommu.c | 66 ++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8f049d4a0e2cb..f752096989a79 100644
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
+static pte_t *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
 					    unsigned long iova, size_t pgsize,
 					    gfp_t gfp)
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
@@ -1154,31 +1156,31 @@ static unsigned long *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
 				goto pte_retry;
 			}
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
@@ -1191,8 +1193,9 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
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
 
@@ -1210,10 +1213,9 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
 			break;
 		}
 
-		old = READ_ONCE(*ptr);
+		old = ptep_get(ptr);
 		pte = _io_pte_entry(phys_to_pfn(phys), pte_prot);
-		if (cmpxchg_relaxed(ptr, old, pte) != old)
-			continue;
+		set_pte(ptr, pte);
 
 		riscv_iommu_pte_free(domain, old, &freelist);
 
@@ -1247,7 +1249,7 @@ static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	size_t size = pgcount << __ffs(pgsize);
-	unsigned long *ptr, old;
+	pte_t *ptr;
 	size_t unmapped = 0;
 	size_t pte_size;
 
@@ -1260,9 +1262,7 @@ static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
 		if (iova & (pte_size - 1))
 			return unmapped;
 
-		old = READ_ONCE(*ptr);
-		if (cmpxchg_relaxed(ptr, old, 0) != old)
-			continue;
+		set_pte(ptr, __pte(0));
 
 		iommu_iotlb_gather_add_page(&domain->domain, gather, iova,
 					    pte_size);
@@ -1279,13 +1279,13 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
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


