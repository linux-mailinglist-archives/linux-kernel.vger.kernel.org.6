Return-Path: <linux-kernel+bounces-443675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B995A9EFA95
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F69A16C4AA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD5424037A;
	Thu, 12 Dec 2024 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2IBIcBeh"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F7240394
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026794; cv=none; b=IZe0L7eM9mXOqhuCAflIyiu6ZJJyuiBdFyRwZiy4RnKWTXqiZQLkidvYSbZpVYuhq+tZmDbBNZWK/lQXPNmhuttlD/GS0lORjwdDiORag8Z+wASdM3dYKSi9uF6sWdDlh0GizmVKgHktK96bGGeWWBvUpN79nXSjwdZ7kRM+xbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026794; c=relaxed/simple;
	bh=07ud3kdPqRkJyWJjKZmbhmLN44HYdmlP0Fh8jQS65qQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U0qaiP43IqpBilEZdDHHgrn//o3yl6OU6iPGDO8DzAiRyJCZ/Kb2Y+QzcuZhJ6sWlOtDqUO1/iA4WMLllHAmw76WFNfmHvYhH+nWIKTs7PQqKckIJoHj/hcSzzWQUlO0jzyTAZLata1tyZa427Aglh74hr6whHQR8rSHtQHFuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2IBIcBeh; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43582d49dacso8235185e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026790; x=1734631590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDsPUb0bWk00lVk5VrmMCzR9hOnWzhzOdUMd5hdynGI=;
        b=2IBIcBeh/xwfkhJLZeuIOJYqDRmEHfHVsL5aeRHeXpEVd3AOEXfMRxgbScz6auUiPQ
         FLLKAG60yOEiPtkoUP36zof9EfQ39KXh/WtKl5iJ/34A1NFqaJhyKZ/V8JFXt+zxEu8J
         VTa0v5oHco9jayNHyQ6GL6XV88G21AujG1UmU03nUrYqjczYM2msbIjdbzEtqqH6MAkG
         lxl2H/xhyxy3TtIyWGZyQ4EPByuenLu895ZOaT0DOIwC9NXLQJJz/8lmB1z8cg2ng4I2
         22C8IDkXtVjz1zN5BRF/OLt350TIbayjoL0ZFsQcY7g/+ikXesh9p89rGj/EZe9ria8S
         5acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026790; x=1734631590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDsPUb0bWk00lVk5VrmMCzR9hOnWzhzOdUMd5hdynGI=;
        b=dFYG+OJ8j41+cEg8lIo+4GReC+4Xws2ahlB2hZ0iTp+CQfHWgJCN+p72ezIcNZSVmX
         1xl/vzKEBjlh4Z/6PYrcT7mgx9XwIPaHqifZKuNsQTSgzQ+svQNkrbmn+EDzP6tHl/KJ
         iRN3yytLFwWOOeMX+fiiM/A116w9tlELvWazEvWaCJBqcTpa3xOjw4Zt16t2P/qQIEPP
         U2DCQo04S2sLub7qERVupA9YDQcTEPcxpbm3jX8L8ktk22QhwltKoa4S2uUS1oT1+wKz
         39V6muplrfZzXoXi9h1yFwazsA1DLHw/R/o6Hm4ekqGhuZpeaN9rrmYA5bK5aKYf+kYB
         Uahg==
X-Forwarded-Encrypted: i=1; AJvYcCXceLHhWavjh1ZA9pfsFIBiJ5RgKxMovvf9HFN1WE/dJfYzRPuRa0Uj+hzHXbDX68AJGikWEO+iZ+J2MYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNCSeDCtxQ3TWCosztknKDx1fxArw+SSDsIa33RTu2bD69h1iS
	Dbb9PsexepNpRn/JEYadwdWtLZ35AYzWU9ruo/PBatS1urNAy6U4deIgrAZVHILLTl/mmT6YoDt
	wAUUKqI+hrQ==
X-Google-Smtp-Source: AGHT+IG5YT0EqzqwRu68YDl6GFjwRjdyDc1eUBljQvzlbHZ6i5XzGDeiAujVaOE5XHTme90ZWc1iBhvfMg1TXA==
X-Received: from wmdp19.prod.google.com ([2002:a05:600c:5d3:b0:434:f271:522e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e0b:b0:436:1b96:7072 with SMTP id 5b1f17b1804b1-43622827675mr38391595e9.5.1734026790384;
 Thu, 12 Dec 2024 10:06:30 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:15 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-52-smostafa@google.com>
Subject: [RFC PATCH v2 51/58] iommu/arm-smmu-v3-kvm: Support PASID operations
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

Add support for set_dev_pasid and remove_dev_pasid, the hypervisor
already supports pasid, so we just need to forward it in the
hypercalls in addition to proper tracking of domains per master.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 58 +++++++++++++++----
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index 82f0191b222c..cbcd8a75d562 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -29,7 +29,8 @@ struct host_arm_smmu_device {
 struct kvm_arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
-	struct kvm_arm_smmu_domain      *domain;
+	struct xarray			domains;
+	u32				ssid_bits;
 };
 
 struct kvm_arm_smmu_domain {
@@ -119,6 +120,10 @@ static struct iommu_device *kvm_arm_smmu_probe_device(struct device *dev)
 
 	master->dev = dev;
 	master->smmu = smmu;
+
+	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
+	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
+	xa_init(&master->domains);
 	dev_iommu_priv_set(dev, master);
 
 	return &smmu->iommu;
@@ -235,13 +240,14 @@ static void kvm_arm_smmu_domain_free(struct iommu_domain *domain)
 	kfree(kvm_smmu_domain);
 }
 
-static int kvm_arm_smmu_detach_dev(struct host_arm_smmu_device *host_smmu,
-				   struct kvm_arm_smmu_master *master)
+static int kvm_arm_smmu_detach_dev_pasid(struct host_arm_smmu_device *host_smmu,
+					 struct kvm_arm_smmu_master *master,
+					 ioasid_t pasid)
 {
 	int i, ret;
 	struct arm_smmu_device *smmu = &host_smmu->smmu;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
-	struct kvm_arm_smmu_domain *domain = master->domain;
+	struct kvm_arm_smmu_domain *domain = xa_load(&master->domains, pasid);
 
 	if (!domain)
 		return 0;
@@ -250,7 +256,7 @@ static int kvm_arm_smmu_detach_dev(struct host_arm_smmu_device *host_smmu,
 		int sid = fwspec->ids[i];
 
 		ret = kvm_call_hyp_nvhe(__pkvm_host_iommu_detach_dev,
-					host_smmu->id, domain->id, sid, 0);
+					host_smmu->id, domain->id, sid, pasid);
 		if (ret) {
 			dev_err(smmu->dev, "cannot detach device %s (0x%x): %d\n",
 				dev_name(master->dev), sid, ret);
@@ -258,22 +264,39 @@ static int kvm_arm_smmu_detach_dev(struct host_arm_smmu_device *host_smmu,
 		}
 	}
 
-	master->domain = NULL;
+	xa_erase(&master->domains, pasid);
 
 	return ret;
 }
 
+static int kvm_arm_smmu_detach_dev(struct host_arm_smmu_device *host_smmu,
+				   struct kvm_arm_smmu_master *master)
+{
+	return kvm_arm_smmu_detach_dev_pasid(host_smmu, master, 0);
+}
+
+static void kvm_arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+					  struct iommu_domain *domain)
+{
+	struct kvm_arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct host_arm_smmu_device *host_smmu = smmu_to_host(master->smmu);
+
+	kvm_arm_smmu_detach_dev_pasid(host_smmu, master, pasid);
+}
+
 static void kvm_arm_smmu_release_device(struct device *dev)
 {
 	struct kvm_arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct host_arm_smmu_device *host_smmu = smmu_to_host(master->smmu);
 
 	kvm_arm_smmu_detach_dev(host_smmu, master);
+	xa_destroy(&master->domains);
 	kfree(master);
 	iommu_fwspec_free(dev);
 }
 
-static int kvm_arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
+static int kvm_arm_smmu_set_dev_pasid(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid)
 {
 	int i, ret;
 	struct arm_smmu_device *smmu;
@@ -288,7 +311,7 @@ static int kvm_arm_smmu_attach_dev(struct iommu_domain *domain, struct device *d
 	smmu = master->smmu;
 	host_smmu = smmu_to_host(smmu);
 
-	ret = kvm_arm_smmu_detach_dev(host_smmu, master);
+	ret = kvm_arm_smmu_detach_dev_pasid(host_smmu, master, pasid);
 	if (ret)
 		return ret;
 
@@ -303,14 +326,14 @@ static int kvm_arm_smmu_attach_dev(struct iommu_domain *domain, struct device *d
 
 		ret = kvm_call_hyp_nvhe_mc(__pkvm_host_iommu_attach_dev,
 					   host_smmu->id, kvm_smmu_domain->id,
-					   sid, 0, 0);
+					   sid, pasid, master->ssid_bits);
 		if (ret) {
 			dev_err(smmu->dev, "cannot attach device %s (0x%x): %d\n",
 				dev_name(dev), sid, ret);
 			goto out_ret;
 		}
 	}
-	master->domain = kvm_smmu_domain;
+	ret = xa_insert(&master->domains, pasid, kvm_smmu_domain, GFP_KERNEL);
 
 out_ret:
 	if (ret)
@@ -318,6 +341,19 @@ static int kvm_arm_smmu_attach_dev(struct iommu_domain *domain, struct device *d
 	return ret;
 }
 
+static int kvm_arm_smmu_attach_dev(struct iommu_domain *domain,
+				   struct device *dev)
+{
+	struct kvm_arm_smmu_master *master = dev_iommu_priv_get(dev);
+	unsigned long pasid = 0;
+
+	/* All pasids must be removed first. */
+	if (xa_find_after(&master->domains, &pasid, ULONG_MAX, XA_PRESENT))
+		return -EBUSY;
+
+	return kvm_arm_smmu_set_dev_pasid(domain, dev, 0);
+}
+
 static bool kvm_arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 {
 	struct kvm_arm_smmu_master *master = dev_iommu_priv_get(dev);
@@ -409,6 +445,7 @@ static struct iommu_ops kvm_arm_smmu_ops = {
 	.release_device		= kvm_arm_smmu_release_device,
 	.domain_alloc		= kvm_arm_smmu_domain_alloc,
 	.pgsize_bitmap		= -1UL,
+	.remove_dev_pasid	= kvm_arm_smmu_remove_dev_pasid,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= kvm_arm_smmu_attach_dev,
@@ -416,6 +453,7 @@ static struct iommu_ops kvm_arm_smmu_ops = {
 		.map_pages	= kvm_arm_smmu_map_pages,
 		.unmap_pages	= kvm_arm_smmu_unmap_pages,
 		.iova_to_phys	= kvm_arm_smmu_iova_to_phys,
+		.set_dev_pasid	= kvm_arm_smmu_set_dev_pasid,
 	}
 };
 
-- 
2.47.0.338.g60cca15819-goog


