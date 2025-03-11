Return-Path: <linux-kernel+bounces-556113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489A4A5C11D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4AD3ACD67
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F3F25CC75;
	Tue, 11 Mar 2025 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XQgfw8Y/"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5C25C71D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695929; cv=none; b=P8tqHWvYN2VN7bzfGynkufCgP5o84rjADZDLVNrgL+vmgn3hm6GCG7hxvMOQzM6EdBHkrofS8KIdaAH9L2aUnKyEpIemAmv3B+vlyehBe8UOIb7Ibt6CSsmt2XXDVQDFuEQX8+Cjh/OA/8URPuxYk+kD4NUHei4EM87jTli+VR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695929; c=relaxed/simple;
	bh=yjkhHriFUj/pjJLTsHrBMQnNQw7+EpDNpDVbDZBqKTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HSypa4t739hCnS5ilu8Aa0fpPaHMOdvXe53ufBSr9UimHN+h43Dki9cYgCO8odh+8rMpRNEMqwt+p8G/XS5JdrCYaFUsRsgA89Nr6/2DdQWzqf5c2kRqSzEbsYySQbxPL/8TY/bqsb90O8cxUwpReeTHLlWFfAK/4xfHugjVO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XQgfw8Y/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223f4c06e9fso89058775ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741695926; x=1742300726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RzuTPLpNm7preMNxFl4olDUAY05FyWZH15sy7wmcR0=;
        b=XQgfw8Y/LW0ypdPjBiK0LCmDOcbCoQs1haOEKMuYpQLVCO6tUzY1ceGUSZFR3ToMMl
         InCP5iqw90K+3MrUs579/OoEIZ2PkdP5S7NkXgSGYrQMZZfm3OjQSkHOTSIfueBuvaj7
         jPp5mF6jfUtUZudVnnW+JuqQxVk9addUpRSXqbi5TYZnOoWgRj78TYtXdv/P4Ma7o/RD
         Gwq/p+H0BKTQCUKEZowrm4Mo+fZCEIKTDRiUTLJ24YQutfDt2e5FqaR9gkhFYp6/Pd/O
         Z5EoR4cmKgS+D5kw+CBwwNBh1UGVtKo54yOJKS8U9EAz7XYAWYTpzu9I5GG4MiSehvn3
         q82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741695926; x=1742300726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RzuTPLpNm7preMNxFl4olDUAY05FyWZH15sy7wmcR0=;
        b=wTZWcVL4x0ZKxwAIyGHOa4WRl2fuDmpAiLxaCMhHS7DP0jdRsPTY7fNu+HNtHSI+7K
         3iOKZk63DKagmmyxps7FsSo22HVhnZ74YNE8dgQQbsS7bjRU/p1ijqIrkJ30ILRTk/Ca
         rDxu2d0BZQu5O528UDliH1mrMi3cO59Z67Z/sCGLCdi71F8lK0evzpa+caY7Sk7dPk+O
         iLHPtDb78aEWrAAtylnJwpV6RDcJQBIN/eOvMGG+Ccv2GLU0e1hvRRpr5pIlkJ3udKNW
         kdyDrb/SPPStKtFPQrUheRZ5x1X7FzbtVkL8zjBpOFdGS36oToRqNv2NdwvOqaxW8En7
         6AMg==
X-Forwarded-Encrypted: i=1; AJvYcCUZb4HDF1fn2O5WMkPmXdPelzf/GDQy/kPD1DjWkDmgBDB6xV9mZhVgvBOcDIUEQlcJFIifLlnH8tu/ifc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZu3Ir0QnIifdN646XPgk4Vmf0aW5ed3mRGyQUiiTQxWaC7wx
	wi1r+ISOnXflCklNy9F3wt+S5pb0vt5C1klEQYLTsnlucdPq7fmrYXGNiFx7iW4=
X-Gm-Gg: ASbGncsUj3/9yOFvYYuwfYaECYNQfM787oMBguw6TTgQFF1BHkdkucSux9zxJJ+axro
	x7BBb5hq/RzP/+Ly65Hz9gyiUYWOA0urcYZEoa1LYejcP9+rgbJPgoTkVs9QVcwOmsdohqilj6v
	W0bLVqRe3bVG2bpDu/XeNKLTV0XWKjHimendGCsV34mgV/f8K3ba1XfpATbDHTYpjB6fMCtdg1D
	dvbNxQr47IhvmJ+W97o5hzDcoigtx10Ch+IPGCG5JanCmtnFB4Wz3kBrRI9JBmWQigLeIHmbj7u
	zqqjXYrRC9niepsZcT7CBaPc31dbYFBCAAKTtCXktbaaGWsKx8a8YdYDM121Nj+unZZ5ZQFmUtM
	iUYvGPn95+K43GxS1+4ZDVODUEbA=
X-Google-Smtp-Source: AGHT+IHHairhRley3Z0YtWmhECEN1QFgthVXv+QZN2Jlw6i0j1evvIpG3tBXLE7daxMtzzOJIpUjxQ==
X-Received: by 2002:a17:902:cf0f:b0:220:ff82:1c60 with SMTP id d9443c01a7336-22593d78a97mr51960105ad.14.1741695926535;
        Tue, 11 Mar 2025 05:25:26 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698450244sm10226621b3a.80.2025.03.11.05.25.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Mar 2025 05:25:26 -0700 (PDT)
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
Subject: [PATCH v2 2/4] iommu/riscv: Use pte_t to represent page table entry
Date: Tue, 11 Mar 2025 20:25:08 +0800
Message-Id: <20250311122510.72934-3-luxu.kernel@bytedance.com>
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


