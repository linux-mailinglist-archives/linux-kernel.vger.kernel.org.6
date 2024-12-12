Return-Path: <linux-kernel+bounces-443661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D79EFA76
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E492882CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC7723DE8F;
	Thu, 12 Dec 2024 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lw7PjOms"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560523D411
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026764; cv=none; b=R64V35dGXfk2LDbrpuX+D5DD9BGHl42iOszHomSOezNgc6aj5o0vHvD+B/LOPiZsrvUE7eZpiGHJGtXeyYbXros8ruHQPmzPfy/r1cQYmxnOQe9wscJSgHD0WO7tmUu9/rttrf4DoICx7oRafFKAuokKyltmn4OGh666jQJ752g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026764; c=relaxed/simple;
	bh=j7RHelNygJtS0BmZw4TjYDGdQnRdI0SgZYT8B5cp46g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aPXUSFLil6U3tVJLQukYcCvL5bC9/Hrq95FKQz0lK4UaJLCw7/r9Nr+PTGjXK0SUg5mUxVg8lCPskiQQ8B9UQuZuyv/DdGWC5CLjDTychYeRSHdAPbylzpJBQSj9hXfa4A+mX4aot0imnVs79o1ziXHVlEdBByWiKRp/19JXT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lw7PjOms; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361ac8b25fso5740665e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026761; x=1734631561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iXAdVcyIvzlz7i7WSO159EYvNqEybHFoFsFwP8+bSos=;
        b=lw7PjOmsSXljCd2ql/TrCnf6J6526dTG3uBkulmlQl/R+kHU3S0+vjTaKB77SBojTg
         CS/pNx0HhxMTw2Oe3YnWERwmxSjHJGhazOok1p7ow71UZEZuN/2ccmI/r8OfHILuJXrE
         F+lHtTOVFpawCc6s2r6MPZd8Ii+e8ZaMzmxYuA0xovOKBgoBgIQcxyB5EEBdcmFIcY06
         TBC18sTj5ifqT6FFUxtii5PMHq8s2CYQf3q6eGOkieLiFUl9vwELGzyUlSQlwWxYPc0B
         VL5olQHIkIMU4nfEIAzXxmZ9dBrsAvrPUlosFj5lvihxaIlqV/NePwuJHY1MaNHaoOv8
         JWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026761; x=1734631561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXAdVcyIvzlz7i7WSO159EYvNqEybHFoFsFwP8+bSos=;
        b=txpcT/iytP9OkhgGiSi8CB6pmMwLM1vC6FgqXhxBA46WMzJ5c5RslDTWTH1lYcbm2w
         rLu/xHllGVct9yE2DEtHtBgMYS187OS6IJ5KrOPZ2i7Re+OboONVFxIXNAJsi1PKnikT
         SepaiviQnLLvtq3unAJzvLC/41I62EXtmo+qL+HNaA/jhnZwpsX1im8y4if5JJ45W9oC
         Y9Brb3jtp8A79ZLLrgV7WaTZVMNRaQM2A+U3f+Knwg5vejzgRVpGo+sDzraG9PyCjCca
         Cn7kWK12z9haj9nBzFOc5QhePLnlkBDTesjs9cjHrq6Adyilk59zPKzEYUiSJIW9z+N1
         AL/g==
X-Forwarded-Encrypted: i=1; AJvYcCWnAl0S5Oog1HUK2qec0Elp8oGzpReDAqMVPC9YMlh6LBYhLaL0V0IwUIikRBAD+lIlOaV0JkMVpszfflY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRgkOq3HFMyjxgLeZo2xL3mAMr6M0MZSdIBYSsQwGe6Nfihfk
	zIT1Y38awwRDn8QdxuG55l8rbvdI7ToV9ndxIytWYC9tsA66Y6NdqENf0NiBCQLDYZ1vuMVonYu
	D7jItBuj/Nw==
X-Google-Smtp-Source: AGHT+IEv9trywyRhFNpKLmyQCHa1KXy/laHIVh8Z4rtcW7mSbOGhZQtW8954nUj91xsudPP8/kvhlE70Laak2A==
X-Received: from wmsn8.prod.google.com ([2002:a05:600c:3b88:b0:434:f018:dd30])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c5:b0:385:f417:ee3d with SMTP id ffacd0b85a97d-3878769a01fmr3792369f8f.35.1734026761231;
 Thu, 12 Dec 2024 10:06:01 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:01 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-38-smostafa@google.com>
Subject: [RFC PATCH v2 37/58] iommu/io-pgtable: Generalize walker interface
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a common struct for walker, which has a callback visitor
with HW agnostic info (phys addr + size).

Add size to walker so it can walk a range of IOVAs.

Also, add a cookie for the arm walker.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/gpu/drm/msm/msm_iommu.c       |  5 +++-
 drivers/iommu/io-pgtable-arm-common.c | 35 ++++++++++++++++++---------
 include/linux/io-pgtable-arm.h        |  2 +-
 include/linux/io-pgtable.h            | 18 ++++++++++++--
 4 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 3e692818ba1f..8516861dd626 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -200,6 +200,9 @@ msm_iommu_pagetable_walk(struct msm_mmu *mmu, unsigned long iova, uint64_t ptes[
 {
 	struct msm_iommu_pagetable *pagetable;
 	struct arm_lpae_io_pgtable_walk_data wd = {};
+	struct io_pgtable_walk_common walker = {
+		.data = &wd,
+	};
 
 	if (mmu->type != MSM_MMU_IOMMU_PAGETABLE)
 		return -EINVAL;
@@ -209,7 +212,7 @@ msm_iommu_pagetable_walk(struct msm_mmu *mmu, unsigned long iova, uint64_t ptes[
 	if (!pagetable->pgtbl_ops->pgtable_walk)
 		return -EINVAL;
 
-	pagetable->pgtbl_ops->pgtable_walk(pagetable->pgtbl_ops, iova, &wd);
+	pagetable->pgtbl_ops->pgtable_walk(pagetable->pgtbl_ops, iova, 1, &walker);
 
 	for (int i = 0; i < ARRAY_SIZE(wd.ptes); i++)
 		ptes[i] = wd.ptes[i];
diff --git a/drivers/iommu/io-pgtable-arm-common.c b/drivers/iommu/io-pgtable-arm-common.c
index 21ee8ff7c881..4fc0b03494e3 100644
--- a/drivers/iommu/io-pgtable-arm-common.c
+++ b/drivers/iommu/io-pgtable-arm-common.c
@@ -481,7 +481,8 @@ struct iova_to_phys_data {
 static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
 			      arm_lpae_iopte *ptep, size_t size)
 {
-	struct iova_to_phys_data *data = walk_data->data;
+	struct io_pgtable_walk_common *walker = walk_data->data;
+	struct iova_to_phys_data *data = walker->data;
 	data->pte = *ptep;
 	data->lvl = lvl;
 	return 0;
@@ -492,8 +493,11 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct iova_to_phys_data d;
-	struct io_pgtable_walk_data walk_data = {
+	struct io_pgtable_walk_common walker = {
 		.data = &d,
+	};
+	struct io_pgtable_walk_data walk_data = {
+		.data = &walker,
 		.visit = visit_iova_to_phys,
 		.addr = iova,
 		.end = iova + 1,
@@ -511,23 +515,25 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
 			      arm_lpae_iopte *ptep, size_t size)
 {
-	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
-	data->ptes[data->level++] = *ptep;
+	struct io_pgtable_walk_common *walker = walk_data->data;
+	struct arm_lpae_io_pgtable_walk_data *data = walker->data;
+
+	data->ptes[lvl] = *ptep;
+	data->level = lvl + 1;
 	return 0;
 }
 
-static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova, void *wd)
+static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
+				 size_t size, struct io_pgtable_walk_common *walker)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_walk_data walk_data = {
-		.data = wd,
+		.data = walker,
 		.visit = visit_pgtable_walk,
 		.addr = iova,
-		.end = iova + 1,
+		.end = iova + size,
 	};
 
-	((struct arm_lpae_io_pgtable_walk_data *)wd)->level = 0;
-
 	return __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
 }
 
@@ -537,6 +543,7 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 {
 	struct io_pgtable *iop = &data->iop;
 	arm_lpae_iopte pte = READ_ONCE(*ptep);
+	struct io_pgtable_walk_common *walker = walk_data->data;
 
 	size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
 	int ret = walk_data->visit(walk_data, lvl, ptep, size);
@@ -544,6 +551,8 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
 		return ret;
 
 	if (iopte_leaf(pte, lvl, iop->fmt)) {
+		if (walker->visit_leaf)
+			walker->visit_leaf(iopte_to_paddr(pte, data), size, walker, ptep);
 		walk_data->addr += size;
 		return 0;
 	}
@@ -585,7 +594,8 @@ static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
 static int visit_dirty(struct io_pgtable_walk_data *walk_data, int lvl,
 		       arm_lpae_iopte *ptep, size_t size)
 {
-	struct iommu_dirty_bitmap *dirty = walk_data->data;
+	struct io_pgtable_walk_common *walker = walk_data->data;
+	struct iommu_dirty_bitmap *dirty = walker->data;
 
 	if (!iopte_leaf(*ptep, lvl, walk_data->iop->fmt))
 		return 0;
@@ -606,9 +616,12 @@ static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	struct io_pgtable_walk_common walker = {
+		.data = dirty,
+	};
 	struct io_pgtable_walk_data walk_data = {
 		.iop = &data->iop,
-		.data = dirty,
+		.data = &walker,
 		.visit = visit_dirty,
 		.flags = flags,
 		.addr = iova,
diff --git a/include/linux/io-pgtable-arm.h b/include/linux/io-pgtable-arm.h
index 88922314157d..9e5878c37d78 100644
--- a/include/linux/io-pgtable-arm.h
+++ b/include/linux/io-pgtable-arm.h
@@ -18,7 +18,7 @@ struct arm_lpae_io_pgtable {
 
 struct io_pgtable_walk_data {
 	struct io_pgtable		*iop;
-	void				*data;
+	struct io_pgtable_walk_common	*data;
 	int (*visit)(struct io_pgtable_walk_data *walk_data, int lvl,
 		     arm_lpae_iopte *ptep, size_t size);
 	unsigned long			flags;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index f789234c703b..da50e17b0177 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -185,12 +185,25 @@ struct io_pgtable_cfg {
  *
  * @ptes:     The recorded PTE values from the walk
  * @level:    The level of the last PTE
+ * @cookie:   Cookie set by caller to identify it
  *
  * @level also specifies the last valid index in @ptes
  */
 struct arm_lpae_io_pgtable_walk_data {
 	u64 ptes[4];
 	int level;
+	void *cookie;
+};
+
+/**
+ * struct io_pgtable_walk_common - common information from a pgtable walk
+ * @visit_leaf: callback for each leaf providing it's physical address and size
+ */
+struct io_pgtable_walk_common {
+	void (*visit_leaf)(phys_addr_t paddr, size_t size,
+			   struct io_pgtable_walk_common *data,
+			   void *wd);
+	void *data; /* pointer to walk data as arm_lpae_io_pgtable_walk_data*/
 };
 
 /**
@@ -199,7 +212,7 @@ struct arm_lpae_io_pgtable_walk_data {
  * @map_pages:    Map a physically contiguous range of pages of the same size.
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
  * @iova_to_phys: Translate iova to physical address.
- * @pgtable_walk: (optional) Perform a page table walk for a given iova.
+ * @pgtable_walk: (optional) Perform a page table walk for a given iova and size.
  *
  * These functions map directly onto the iommu_ops member functions with
  * the same names.
@@ -213,7 +226,8 @@ struct io_pgtable_ops {
 			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
-	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
+	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova,
+			    size_t size, struct io_pgtable_walk_common *walker);
 	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
 				    unsigned long iova, size_t size,
 				    unsigned long flags,
-- 
2.47.0.338.g60cca15819-goog


