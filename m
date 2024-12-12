Return-Path: <linux-kernel+bounces-443664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0E19EFA90
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF1F188ECBB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F723EA6E;
	Thu, 12 Dec 2024 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZ8jV3v3"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A823E6EF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026771; cv=none; b=kfibIR6qCzBGftz/jBziR/hplX4r8kIZaNOFCjzwlIxVfeTe8NYseuMLV4f47vQDdnm3Hit7dzQL9ZkQFkHy75+aiwQS+VVt0KqEh4q2OHYNz0pLWJDofYEnFG9v80z4QLsUc3uSx7IixXG8slQxGGUX99ePWp72u5Sy4FiVJTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026771; c=relaxed/simple;
	bh=onbrJ9zcCDEgz4deQmM2rr2og6c6fCddvp2W4BDAzsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nkpyQX46UXGJRT3amCwqqWnPsmGYx5CTYnKvXwFmaEaEl0y9VKw3ie7CFua799BPEVcGbZUCMKdK+JObTWKhjc72jiOyzdis+B5Km51IUSe9nGkN554vae6mnM3sBT02GvFsMIVNdSOtqSq21qMZ2BlldEIiAb7GwOGm3n40+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZ8jV3v3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43627bb20b5so4509775e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026767; x=1734631567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gI/xVfW0NJIG4pabP2PrJlF4/ywCtn5dWW4kgaXryCA=;
        b=WZ8jV3v3iQKyhFighauWEWF0qy7IOC+cC8AfdGfr9nLFb2knJEs1R0MBXwz8/LUNK1
         +XInIWOkwYT67k3DjOv4HcteaAy97LaFYUTH2ypH1fYlHlSJU3KktPwN4v0nRRuh9F6I
         hJGvV4Xnh8dHmBo/UQzjPWgtaAsA/Dp4oymN6nuXPLTcMkkVJDflADJMJwuCOv082o41
         BTgGPBReJCM2iH3FKDk3M3jXkTH0haM2tBatKz765rl/fZZz8tR5mQZ01HwhW8jy2WY0
         CKga/ZdDQ3HwZSO//Cw6Kx8tr8a1aI1JG4yZHc3lKLnNlu0QY8c9zgtGwUKrQDeV6vtq
         5X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026767; x=1734631567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gI/xVfW0NJIG4pabP2PrJlF4/ywCtn5dWW4kgaXryCA=;
        b=c/wpV56RC3iJebFfoUlx3u6C5ZRsK8W57nM2IHxWgPcm9wSUhlDb7FfN9iWI8SEvoG
         3WGBAGLFE18vGIqPFCyhswY8kowkTdLVTZ2fQNNcTrfX6N7DEX3Z++F6w86SX233Fl+s
         ADhiiYVm6KUJ/o1RJiH+oxxd+cZEuRiCEUH9+Uj09w9DPwaqtGAISVSWdJVWt9ZbvMTt
         kYOOxKEVoaNtXTYKHFEYZzOfgdLPExS4ZpgLQWNcMKbqVs5VWBWYhaHLkgrjdZAXYLnw
         c8wd69ZkZSwYyw54yqldEjx86rJatSeNtHOVOfqkUZVhofUiT7f465NfPpU3D+Fl87p2
         OhRw==
X-Forwarded-Encrypted: i=1; AJvYcCWLr6q08vfq5Un91zlVQjI4C4HKnMC/VUitX3PpY0iMRtbRIW0LWyDdD/99ge6+HJXOvfg8wuwVRLdbzhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkDpWZI4Ttozda9dffpldr2Tl/OPLLUfbDwi8PyogQdSXFVO3b
	xoweg0nTYlWjIdP1o4qfIkCEQRSrkhUUDT74SkBL2PvCPglv5wSWz9DBKR34yFVOBbeXwT4utsW
	/V1TvmjIyYA==
X-Google-Smtp-Source: AGHT+IHQ4cd+c/HRUSDI+U6v3tD80p/r2kIFY0himPqzGsq85TsqDSkq/5V4+Is4wQaH97N2w1ilsWBcofMkbQ==
X-Received: from wmgg16.prod.google.com ([2002:a05:600d:10:b0:434:a7ee:3c40])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19ca:b0:434:f819:251a with SMTP id 5b1f17b1804b1-4362282ab8emr40017385e9.9.1734026767627;
 Thu, 12 Dec 2024 10:06:07 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:04 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-41-smostafa@google.com>
Subject: [RFC PATCH v2 40/58] KVM: arm64: smmu-v3: Add map/unmap pages and iova_to_phys
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

Add map_pages and iova_to_phys HVC code, which
mainly calls the io-pgtable.

For unmap_pages, we rely on IO_PGTABLE_QUIRK_UNMAP_INVAL, where the
driver first calls unmap_pages which invalidate all the pages as
a typical unmap, issuing all the necessary TLB invalidations.
Then, we will start a page table with 2 callbacks:
- visit_leaf: for each unmapped leaf, it would decrement the refcount
  of the page using __pkvm_host_unuse_dma(), reversing the what IOMMU
  core does in map.
- visit_post_table: this would free any invalidated tables as they
  wouldn't be freed because of the quirk.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 147 ++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index ec3f8d9749d3..1821a3420a4d 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -808,15 +808,74 @@ static const struct iommu_flush_ops smmu_tlb_ops = {
 	.tlb_add_page	= smmu_tlb_add_page,
 };
 
+static void smmu_unmap_visit_leaf(phys_addr_t addr, size_t size,
+				  struct io_pgtable_walk_common *data,
+				  void *wd)
+{
+	u64 *ptep = wd;
+
+	WARN_ON(__pkvm_host_unuse_dma(addr, size));
+	*ptep = 0;
+}
+
+/*
+ * On unmap with the IO_PGTABLE_QUIRK_UNMAP_INVAL, unmap doesn't clear
+ * or free any tables, so after the unmap walk the table and on the post
+ * walk we free invalid tables.
+ * One caveat, is that a table can be unmapped while it points to other
+ * tables which would be valid, and we would need to free those also.
+ * The simples solution is to look at the walk PTE info and if any of
+ * the parents is invalid it means that this table also needs to freed.
+ */
+static void smmu_unmap_visit_post_table(struct arm_lpae_io_pgtable_walk_data *walk_data,
+					arm_lpae_iopte *ptep, int lvl)
+{
+	struct arm_lpae_io_pgtable *data = walk_data->cookie;
+	size_t table_size;
+	int i;
+	bool invalid = false;
+
+	if (lvl == data->start_level)
+		table_size = ARM_LPAE_PGD_SIZE(data);
+	else
+		table_size = ARM_LPAE_GRANULE(data);
+
+	for (i = 0 ; i <= lvl ; ++i)
+		invalid |= !iopte_valid(walk_data->ptes[lvl]);
+
+	if (!invalid)
+		return;
+
+	__arm_lpae_free_pages(ptep, table_size, &data->iop.cfg, data->iop.cookie);
+	*ptep = 0;
+}
+
 static void smmu_iotlb_sync(struct kvm_hyp_iommu_domain *domain,
 			    struct iommu_iotlb_gather *gather)
 {
 	size_t size;
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+	struct io_pgtable *pgtable = smmu_domain->pgtable;
+	struct arm_lpae_io_pgtable *data = io_pgtable_to_data(pgtable);
+	struct arm_lpae_io_pgtable_walk_data wd = {
+		.cookie = data,
+		.visit_post_table = smmu_unmap_visit_post_table,
+	};
+	struct io_pgtable_walk_common walk_data = {
+		.visit_leaf = smmu_unmap_visit_leaf,
+		.data = &wd,
+	};
 
 	if (!gather->pgsize)
 		return;
 	size = gather->end - gather->start + 1;
 	smmu_tlb_inv_range(domain, gather->start, size,  gather->pgsize, true);
+
+	/*
+	 * Now decrement the refcount of unmapped pages thanks to
+	 * IO_PGTABLE_QUIRK_UNMAP_INVAL
+	 */
+	pgtable->ops.pgtable_walk(&pgtable->ops, gather->start, size, &walk_data);
 }
 
 static int smmu_domain_config_s2(struct kvm_hyp_iommu_domain *domain,
@@ -966,6 +1025,7 @@ static int smmu_domain_finalise(struct hyp_arm_smmu_v3_device *smmu,
 			.oas = smmu->ias,
 			.coherent_walk = smmu->features & ARM_SMMU_FEAT_COHERENCY,
 			.tlb = &smmu_tlb_ops,
+			.quirks = IO_PGTABLE_QUIRK_UNMAP_INVAL,
 		};
 	} else {
 		cfg = (struct io_pgtable_cfg) {
@@ -975,6 +1035,7 @@ static int smmu_domain_finalise(struct hyp_arm_smmu_v3_device *smmu,
 			.oas = smmu->oas,
 			.coherent_walk = smmu->features & ARM_SMMU_FEAT_COHERENCY,
 			.tlb = &smmu_tlb_ops,
+			.quirks = IO_PGTABLE_QUIRK_UNMAP_INVAL,
 		};
 	}
 
@@ -1125,6 +1186,89 @@ static int smmu_detach_dev(struct kvm_hyp_iommu *iommu, struct kvm_hyp_iommu_dom
 	return ret;
 }
 
+static int smmu_map_pages(struct kvm_hyp_iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t pgsize,
+			  size_t pgcount, int prot, size_t *total_mapped)
+{
+	size_t mapped;
+	size_t granule;
+	int ret;
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+	struct io_pgtable *pgtable = smmu_domain->pgtable;
+
+	if (!pgtable)
+		return -EINVAL;
+
+	granule = 1UL << __ffs(smmu_domain->pgtable->cfg.pgsize_bitmap);
+	if (!IS_ALIGNED(iova | paddr | pgsize, granule))
+		return -EINVAL;
+
+	hyp_spin_lock(&smmu_domain->pgt_lock);
+	while (pgcount && !ret) {
+		mapped = 0;
+		ret = pgtable->ops.map_pages(&pgtable->ops, iova, paddr,
+					     pgsize, pgcount, prot, 0, &mapped);
+		if (ret)
+			break;
+		WARN_ON(!IS_ALIGNED(mapped, pgsize));
+		WARN_ON(mapped > pgcount * pgsize);
+
+		pgcount -= mapped / pgsize;
+		*total_mapped += mapped;
+		iova += mapped;
+		paddr += mapped;
+	}
+	hyp_spin_unlock(&smmu_domain->pgt_lock);
+
+	return 0;
+}
+
+static size_t smmu_unmap_pages(struct kvm_hyp_iommu_domain *domain, unsigned long iova,
+			       size_t pgsize, size_t pgcount, struct iommu_iotlb_gather *gather)
+{
+	size_t granule, unmapped, total_unmapped = 0;
+	size_t size = pgsize * pgcount;
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+	struct io_pgtable *pgtable = smmu_domain->pgtable;
+
+	if (!pgtable)
+		return -EINVAL;
+
+	granule = 1UL << __ffs(smmu_domain->pgtable->cfg.pgsize_bitmap);
+	if (!IS_ALIGNED(iova | pgsize, granule))
+		return 0;
+
+	hyp_spin_lock(&smmu_domain->pgt_lock);
+	while (total_unmapped < size) {
+		unmapped = pgtable->ops.unmap_pages(&pgtable->ops, iova, pgsize,
+						    pgcount, gather);
+		if (!unmapped)
+			break;
+		iova += unmapped;
+		total_unmapped += unmapped;
+		pgcount -= unmapped / pgsize;
+	}
+	hyp_spin_unlock(&smmu_domain->pgt_lock);
+	return total_unmapped;
+}
+
+static phys_addr_t smmu_iova_to_phys(struct kvm_hyp_iommu_domain *domain,
+				     unsigned long iova)
+{
+	phys_addr_t paddr;
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+	struct io_pgtable *pgtable = smmu_domain->pgtable;
+
+	if (!pgtable)
+		return -EINVAL;
+
+	hyp_spin_lock(&smmu_domain->pgt_lock);
+	paddr = pgtable->ops.iova_to_phys(&pgtable->ops, iova);
+	hyp_spin_unlock(&smmu_domain->pgt_lock);
+
+	return paddr;
+}
+
 /* Shared with the kernel driver in EL1 */
 struct kvm_iommu_ops smmu_ops = {
 	.init				= smmu_init,
@@ -1134,4 +1278,7 @@ struct kvm_iommu_ops smmu_ops = {
 	.iotlb_sync			= smmu_iotlb_sync,
 	.attach_dev			= smmu_attach_dev,
 	.detach_dev			= smmu_detach_dev,
+	.map_pages			= smmu_map_pages,
+	.unmap_pages			= smmu_unmap_pages,
+	.iova_to_phys			= smmu_iova_to_phys,
 };
-- 
2.47.0.338.g60cca15819-goog


