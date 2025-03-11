Return-Path: <linux-kernel+bounces-556115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 531FAA5C120
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B0A3B4E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB53125D1E9;
	Tue, 11 Mar 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y1zp31ki"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7254D2571A1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695937; cv=none; b=qKibe/gzf4PLV/bFaqL4mS/6bQxnuEYA6Hp4S1xXzP7+Ty3Wcw91E+FRgr//l9I1EAdX8JyJZr9Uca1rjT5NbFh0y64mwZTcQAJmp9DNjncL+XOZoVDVZjClVd8NDGelh2INcHQL1uVuEFuwqcOgJ2MkPRmRRIY7N+ZyzUVrhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695937; c=relaxed/simple;
	bh=EBw0pp0DQXvs46s1Cun5L7W7ygqXcv2euwtVQoMQwxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOIpZ3dwfQFfPk6pie0Av4phHMnRh9LhFCNr32chlR+TIcSkYUlH9DU6Reo6BZ0/cZMoq+s/VOXOjqFqqVQswsMS7XrNuiQ9az/vKSv+AwaUnjP1+lMvO8sJtGMs3nkipHXZP1UD7IA638qJbZNIcSa+3hI5Rpz1U7hbCtePMQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y1zp31ki; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2243803b776so93269725ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741695935; x=1742300735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25EEGwiFn3VnbkwivdTLYPKqZQgF1BeYiMnWI1gQipU=;
        b=Y1zp31kiqhUN4oj4mFRXNRopQ4YaEFzEtZAMUPRBHlN6L/mhm421tS7zt6jLiABAZP
         8YXYcfmMJ3UIHXMeKdJiFgYRFPpj+caSLe8rbL9PUPyoE0oXRTSlP/N8CLUWGj+VVRfA
         KRLNmLqxbnwunQz0Wj4iFV6EyV7KnYvflh6Eckg8LXsvIOJ1cEtpbW1bE5E0Q0g0mXw2
         1GNT+os5ZhHQBilIZ3Srm48DBHgJnRYXN1EYRQpPROJb5ZqLzh0CjOM/IQBUN14r2GEA
         6JqhQIw6VZdtBByMUWpgWqmt9smVXuyJUVYqP/nBpyClehJqhjFXAvteHKe3rK/1lfL5
         0ehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741695935; x=1742300735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25EEGwiFn3VnbkwivdTLYPKqZQgF1BeYiMnWI1gQipU=;
        b=IrrlS81NPaDexPFftNhQ+WQNyyrzFtFufP/fEkKEy0go8LHvW8/6I+Oj2w4DyHxGmO
         CODcJTmZt5o5jT2V6hyVCoym2aKtBQnHhvZ+/9pDpXqI0jPs+wiU8JMDy51GVux17IyB
         /psH0j23UyIrVzTJh0BP2ajCcczgiX+900kgRY2Ct7QtZe73Zx83ozPYRCKy8mkyp63+
         7yT3yhH8nHpEYjSoY6aLhr0ed0nemzJzNmzWt6Vq6OD4JoNyGT2tTZgU02Zk54ZrtoPG
         vMfkiNwv5JBqU52UdukMpo8PHnpNRPcok60ASm1/p0t0QKVi9JFwdXc50sfGBhO0w3ZP
         UuSg==
X-Forwarded-Encrypted: i=1; AJvYcCUjkt8Z4KWGHElCsBtC5zuLNHvj8k+BYGjp4iu8xCyn6WV0ZiMoRv19oCC+x8g0zN+vlMNKIjipzhy5mEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/k0FasVNrxpf9AEaOdLV1j44/c3masjU1+GFtJbGVhHKP60E
	Gd69RT/IWmAB1Lb1aB7gyh9M6OFx3Av0PRjvkEtmdmfaO8jRMNFbgoMDK6gSqr0=
X-Gm-Gg: ASbGnctcsCdCc2RfTp1/8P+xPM6JYTUi5bWF/RXBseOWzSSsEntpcmBWkfZyCE5RBVK
	NqTmcfr+tjdxrzXsLvk/yfrP8ViK711iirnWd+BWiMxsfJ2WGHpnZFIF+lDYL34zcjbY8JWXj+J
	3H/MzFlVE7vasU7A+XKvj1Kzrns7LlzVT5At8JS/EXsOUXpAGR2d/LigN9HFb4UPAG9tz3LB0k4
	mzhf9GwE1Q7ZVF7Qwr0aFvrjtUuKajDR1ImcOSfXSXyboFrWdA8j8d7C3GEQrOsUwlrRmdt7MG4
	zTAhVvpLroT8eBJGtaPIQtMy6rIiXhUWwVRZidBNW8E+a307zhWa59WF7PFmzlKSMYSc2uXjhGN
	Lv0N8ADouXVOC5Dh4s2wI1PQM4Dc=
X-Google-Smtp-Source: AGHT+IHy0qPijH5qvnCVrXw7QQ1MI4RxDeaXxBgMZ4OfxRl/g9KDvFkXIYQvqU0hi4IEIQad7sl9DA==
X-Received: by 2002:a17:902:f650:b0:224:1609:a747 with SMTP id d9443c01a7336-22428a9c09fmr326665675ad.31.1741695934635;
        Tue, 11 Mar 2025 05:25:34 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698450244sm10226621b3a.80.2025.03.11.05.25.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Mar 2025 05:25:34 -0700 (PDT)
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
Subject: [PATCH v2 4/4] iommu/riscv: Add support for Svnapot
Date: Tue, 11 Mar 2025 20:25:10 +0800
Message-Id: <20250311122510.72934-5-luxu.kernel@bytedance.com>
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


