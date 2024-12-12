Return-Path: <linux-kernel+bounces-443674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7148E9EFA8B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D39A28C8D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D369422967D;
	Thu, 12 Dec 2024 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5LNyzBK"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF124037A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026791; cv=none; b=rIEP3Bw6pfRYS7pN0lD3yRtqzVIoi1LqH5PjHLI/+cXNLnRVT1gMNk670I0uor/YoKdnlfYyxLDIcEuQ1n5RVvLjoCs++GOrhvFAywSM3eu9B3UhzyLarb2HWtM3guQNPGRQ4sEwwmln7hICq7jsb8q+tB/bKgtceiD63Pc+3KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026791; c=relaxed/simple;
	bh=GZlHSVCi9DCDsyP55JASUXXIEwXOMYR8FDYiO32tVeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f6KCrelfo7s6MHoTPXhiuTIslsThaToQDDMckAIpd8w4z3Bp7S5P57m7sytaY2xxn5Z7WUVFZuvl+Ey8YnVc/OHjUeolAfLKB/3xub9qlL5n7jbS1PM4wTHO5dqHSPbbtw6chx8l0b5Ib2vKtXhomhwPk1Q1LCY3JW2VBiR06YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5LNyzBK; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385e9c69929so427167f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026788; x=1734631588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FlfJ2RoRGMYx/VEn6wy5+97mQsVAl5qyYx+2pIE2d8k=;
        b=a5LNyzBKLeKPdUUzeWR2jWWrUdaYk6/QdrKDQU2h397NiAI4YFQRqa2acTLv+zJPiJ
         MrdFkb7sT6K3qJ1JNBqM2bLsrpkYM3FlWL0FM0dUoOU4+GNKqSwU31x3e7bhb1J30ELb
         AtNt4B6bpoQ3RJzZv4zaYJkttjohayawtNuqY9kfWWY7b1Zu+DxN8Ap/V7YTeJBLuy9I
         NL/iqaZT3PAoBp9LL0fqgRG44br7gOUqDJVE6PJbH7GTLayvIMngxfUNHqaIgBzzPZDu
         xTj0ShApj0MwdQJsf4+jxJnpJeMC1iOSENj7e2fvWGDDK5tw9SD41JSosVjvJioueRSd
         Lyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026788; x=1734631588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlfJ2RoRGMYx/VEn6wy5+97mQsVAl5qyYx+2pIE2d8k=;
        b=taZecOFgDzuLOpOdXzl8m7o6mSUOW7cr9pFM+UgVV4crbVlXDYrEhLJ0GceJScsABa
         yc4vnRSb/Mns4A9ulBPJrUrHkn0MfiHkDkWqNObt+QCRP/j3KL5f8pFgQpph8vSiMq5s
         DIanfAS3NT7j+ep24mYZs0WdIYM7GBI3GKNONX1ESNb/ZbuTCxkkAfoT5x/s2uxTTgu+
         uxNmlQXYvJ6bYJ3qv3OAknmEDrDkssc/Eh6cJpW31LFWlGE3JExlJZrR69knbaGfkLOf
         O0/vlDNp16pBmuykP4EwoVA1KCLTz11lSj7rKXtsatA8Cskhu5sTsVOoNG2ozX0KqSSe
         wmeA==
X-Forwarded-Encrypted: i=1; AJvYcCX0cIesGYSKu7qwsSL/SQa3VkHe+wHKVatvwXGNq8o764ojl+6vh3fMhMiHiKuxgC3jITPZhbneEtgBkdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+RXeaxDSYEJob6sYWhETwH15IPaarEiXsHIj5Yog+mR19gJR
	ey8s5SoCzUBLcl2xV2dGItNhU16kjsdM3c7YgH6A8CEdJj4vrmu28KnGDfvkDdr0124d3NiUH8u
	rPLxqfiNT7w==
X-Google-Smtp-Source: AGHT+IGJYqzxLBeZXH8b4nITiRWycPugiMNUuQieYr7f4NE4ezaD/pAg6hUBcibKZ+vgqVmM+kM3IYkR8ouErw==
X-Received: from wmmu14.prod.google.com ([2002:a05:600c:ce:b0:434:f0a3:7876])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:154a:b0:385:ef2f:92ad with SMTP id ffacd0b85a97d-3864ce86a7fmr7352121f8f.10.1734026788086;
 Thu, 12 Dec 2024 10:06:28 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:14 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-51-smostafa@google.com>
Subject: [RFC PATCH v2 50/58] iommu/arm-smmu-v3-kvm: Add map, unmap and
 iova_to_phys operations
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

Add map, unmap and iova_to_phys, which are forwarded to the
hypervisor.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index 071743f5acf9..82f0191b222c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -331,6 +331,75 @@ static bool kvm_arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
+static int kvm_arm_smmu_map_pages(struct iommu_domain *domain,
+				  unsigned long iova, phys_addr_t paddr,
+				  size_t pgsize, size_t pgcount, int prot,
+				  gfp_t gfp, size_t *total_mapped)
+{
+	size_t mapped;
+	size_t size = pgsize * pgcount;
+	struct kvm_arm_smmu_domain *kvm_smmu_domain = to_kvm_smmu_domain(domain);
+	struct arm_smccc_res res;
+
+	do {
+		res = kvm_call_hyp_nvhe_smccc(__pkvm_host_iommu_map_pages,
+					      kvm_smmu_domain->id,
+					      iova, paddr, pgsize, pgcount, prot);
+		mapped = res.a1;
+		iova += mapped;
+		paddr += mapped;
+		WARN_ON(mapped % pgsize);
+		WARN_ON(mapped > pgcount * pgsize);
+		pgcount -= mapped / pgsize;
+		*total_mapped += mapped;
+	} while (*total_mapped < size && !kvm_arm_smmu_topup_memcache(&res, gfp));
+	if (*total_mapped < size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static size_t kvm_arm_smmu_unmap_pages(struct iommu_domain *domain,
+				       unsigned long iova, size_t pgsize,
+				       size_t pgcount,
+				       struct iommu_iotlb_gather *iotlb_gather)
+{
+	size_t unmapped;
+	size_t total_unmapped = 0;
+	size_t size = pgsize * pgcount;
+	struct kvm_arm_smmu_domain *kvm_smmu_domain = to_kvm_smmu_domain(domain);
+	struct arm_smccc_res res;
+
+	do {
+		res = kvm_call_hyp_nvhe_smccc(__pkvm_host_iommu_unmap_pages,
+					      kvm_smmu_domain->id,
+					      iova, pgsize, pgcount);
+		unmapped = res.a1;
+		total_unmapped += unmapped;
+		iova += unmapped;
+		WARN_ON(unmapped % pgsize);
+		pgcount -= unmapped / pgsize;
+
+		/*
+		 * The page table driver can unmap less than we asked for. If it
+		 * didn't unmap anything at all, then it either reached the end
+		 * of the range, or it needs a page in the memcache to break a
+		 * block mapping.
+		 */
+	} while (total_unmapped < size &&
+		 (unmapped || !kvm_arm_smmu_topup_memcache(&res, GFP_ATOMIC)));
+
+	return total_unmapped;
+}
+
+static phys_addr_t kvm_arm_smmu_iova_to_phys(struct iommu_domain *domain,
+					     dma_addr_t iova)
+{
+	struct kvm_arm_smmu_domain *kvm_smmu_domain = to_kvm_smmu_domain(domain);
+
+	return kvm_call_hyp_nvhe(__pkvm_host_iommu_iova_to_phys, kvm_smmu_domain->id, iova);
+}
+
 static struct iommu_ops kvm_arm_smmu_ops = {
 	.capable		= kvm_arm_smmu_capable,
 	.device_group		= arm_smmu_device_group,
@@ -344,6 +413,9 @@ static struct iommu_ops kvm_arm_smmu_ops = {
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= kvm_arm_smmu_attach_dev,
 		.free		= kvm_arm_smmu_domain_free,
+		.map_pages	= kvm_arm_smmu_map_pages,
+		.unmap_pages	= kvm_arm_smmu_unmap_pages,
+		.iova_to_phys	= kvm_arm_smmu_iova_to_phys,
 	}
 };
 
-- 
2.47.0.338.g60cca15819-goog


