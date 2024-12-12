Return-Path: <linux-kernel+bounces-443679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98A29EFA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B868B16D094
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B811242EE6;
	Thu, 12 Dec 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZtWczK7"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20253242AB8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026802; cv=none; b=n2vmKBF9Cy9g9D7HSp7H6wDegWdP3P7NMMK58nrVldTD1ROOW9WSGmLfG7rygTPwOkk7w4v0Uk+kdLgKMX9aUKciL8N/pFw0UAX/XGC936/STjPJ0D0iGrreKIQIAtS17w2jpKeqEDzrbQ2I+Rpc9dSA5BK7iH1MnCRYpRW5ryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026802; c=relaxed/simple;
	bh=FrK+n20vhoeayrvHwydsyHrEB44WwH99GJuWSDw5pcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IFBX7VYB58HFDep76sG3mIGW3b52Q+bWedTk6tzPDsVwyoTN967ocfNzUgT1RpnlUJ2wxy6r+zYxquuNVffhcsyyRwEyEL/hyavA5XE1k0ETi9to+cmp1yjGaTnzTJR4WpspRQmKxYcKMUFLOykax2jfuyR5CJRoWUumcj6/kSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZtWczK7; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43626224274so5446345e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026799; x=1734631599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/WH1qyYX+7rpIZva9xL+b2vQ8iEfpW50WvBw5yyV8M=;
        b=OZtWczK77lch/MIW+33UuULn0hKkzTSqgHAk8+FmGaszhuow18aguBkpm6NBBP88Cg
         Db+rt2F8dywQhMB1GOe0kzVSwsoJr+vLS2Z2pwn0JnNmWW8zgnpR7tukcmehSoFP5qcy
         72wW6A23bMSc+qMOiGp1juMNIzIEoTa4GDSsOhNLBI+CQXo97jLm2kfrFf19aAd1A7Pt
         na26oOcEpcfIkP2e+YcUeo8dn3Svxlc4Y1+8WQ4XdRjg7UuYSp2oYeknw/yakeNA77CL
         QZCzKjnYUsY8aRY6i6ZPaAIMJ7MHZ5mLYxf1UWbuMjCOJ8N6dX9mb46vtXqqGR71SfuM
         gsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026799; x=1734631599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/WH1qyYX+7rpIZva9xL+b2vQ8iEfpW50WvBw5yyV8M=;
        b=DlQY9eOlPIM4LUkGtgqFFjfr2A/s7GJG1217oskMVjLCUHZU82iGwUQRkDu4XLVLdQ
         KCw3ddeDDc+Rs6S81fljOX1rLxYMc1aGAGm+UfbvTC82UPh0fgzQ+zjCg/1oAEaW7inw
         lzVIz9L6/JPXUM7KEgg4C+fjXA0IClMpyqSVhJv+4c6EZ84PKXNlXqZcGWdxAo2H8k4p
         zk3WSWw/zxdhV19aFvrY6uQClJjXDf7XGrasGpFOgfcPDsCytt1IwW5WQZ+3SwQ7hBOu
         +h6ttnvfuSV2FkFEEKcrhc6vwPUuYYH2KI9DIfSTZPbaegqoXXAgC2RnuEQlc9b4G6D9
         DsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWACbppjMDK96+9KyRFrnzPXB2RBgnVMxQYWalTwXkPTCCwK+r5Wb+D/U5EOfY1/xvDBvRR4BbtZfMqOwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzOnC3+Asj9JOSOLLg32a+FTjjlAiRyfYLGnfn05FWxpOiblxS
	gU6rz8pchSN9SzKXC8p3Q8r0HiQtB/+zQxokwIpukuYrNlvYYGOirBtsr892dUbkOfz68BrZBRz
	ukKIRdjNtHQ==
X-Google-Smtp-Source: AGHT+IHo7wmBmLTPy0XiRrrgBETwIuBRTOBnsQtf6QtHUwUE60Tx6ltVM6P9M60Uqtp3lgGDJwn8Dzv+JpaDLg==
X-Received: from wmph6.prod.google.com ([2002:a05:600c:4986:b0:434:e96f:86b0])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b94:b0:434:fdaf:af2d with SMTP id 5b1f17b1804b1-4361c441f23mr72295225e9.30.1734026798776;
 Thu, 12 Dec 2024 10:06:38 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:19 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-56-smostafa@google.com>
Subject: [RFC PATCH v2 55/58] drivers/iommu: Add deferred map_sg operations
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

With pKVM SMMUv3 driver which para-virtualizes the IOMMU in the
hypervisor, has an extra overhead with map_sg, as it loops over
iommu_map, and for each map requires context switching, disabling
interrupts...

Instead, add an new domain operations:
- alloc_cookie_sg: Allocate a new sg deferred cookie
- add_deferred_map_sg: Add a mapping to the cookie
- consume_deferred_map_sg: Consume and release the cookie

Alternativly, we can pass the sg list as is. However, this would
duplicate some of the logic and it would make more sense to
conolidate all the sg list parsing for IOMMU drivers in one place.

virtio-iommu is another IOMMU that can benfit from this, but it
would need to have a new operation that standerdize passing
an sglist based on these ops.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu.c | 53 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/iommu.h | 19 ++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c5..3a3c48631dd6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2608,6 +2608,37 @@ size_t iommu_unmap_fast(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_unmap_fast);
 
+static int __iommu_add_sg(struct iommu_map_cookie_sg *cookie_sg,
+			  unsigned long iova, phys_addr_t paddr, size_t size)
+{
+	struct iommu_domain *domain = cookie_sg->domain;
+	const struct iommu_domain_ops *ops = domain->ops;
+	unsigned int min_pagesz;
+	size_t pgsize, count;
+
+	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
+		return -EINVAL;
+
+	if (WARN_ON(domain->pgsize_bitmap == 0UL))
+		return -ENODEV;
+
+	/* find out the minimum page size supported */
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+
+	/*
+	 * both the virtual address and the physical one, as well as
+	 * the size of the mapping, must be aligned (at least) to the
+	 * size of the smallest page supported by the hardware
+	 */
+	if (!IS_ALIGNED(iova | paddr | size, min_pagesz)) {
+		pr_err("unaligned: iova 0x%lx pa %pa size 0x%zx min_pagesz 0x%x\n",
+		       iova, &paddr, size, min_pagesz);
+		return -EINVAL;
+	}
+	pgsize = iommu_pgsize(domain, iova, paddr, size, &count);
+	return ops->add_deferred_map_sg(cookie_sg, paddr, pgsize, count);
+}
+
 ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 		     struct scatterlist *sg, unsigned int nents, int prot,
 		     gfp_t gfp)
@@ -2617,6 +2648,9 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	phys_addr_t start;
 	unsigned int i = 0;
 	int ret;
+	bool deferred_sg = ops->alloc_cookie_sg && ops->add_deferred_map_sg &&
+			   ops->consume_deferred_map_sg;
+	struct iommu_map_cookie_sg *cookie_sg;
 
 	might_sleep_if(gfpflags_allow_blocking(gfp));
 
@@ -2625,12 +2659,24 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 				__GFP_HIGHMEM)))
 		return -EINVAL;
 
+	if (deferred_sg) {
+		cookie_sg = ops->alloc_cookie_sg(iova, prot, nents, gfp);
+		if (!cookie_sg) {
+			pr_err("iommu: failed alloc cookie\n");
+			return -ENOMEM;
+		}
+		cookie_sg->domain = domain;
+	}
+
 	while (i <= nents) {
 		phys_addr_t s_phys = sg_phys(sg);
 
 		if (len && s_phys != start + len) {
-			ret = __iommu_map(domain, iova + mapped, start,
-					len, prot, gfp);
+			if (deferred_sg)
+				ret = __iommu_add_sg(cookie_sg, iova + mapped, start, len);
+			else
+				ret = __iommu_map(domain, iova + mapped, start,
+						  len, prot, gfp);
 
 			if (ret)
 				goto out_err;
@@ -2654,6 +2700,9 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			sg = sg_next(sg);
 	}
 
+	if (deferred_sg)
+		ops->consume_deferred_map_sg(cookie_sg);
+
 	if (ops->iotlb_sync_map) {
 		ret = ops->iotlb_sync_map(domain, iova, mapped);
 		if (ret)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c75877044185..5e60ac349228 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -601,6 +601,14 @@ struct iommu_ops {
 	u8 user_pasid_table:1;
 };
 
+/**
+ * struct iommu_map_cookie_sg - Cookie for a deferred map sg
+ * @domain: Domain for the sg lit
+ */
+struct iommu_map_cookie_sg {
+	struct iommu_domain *domain;
+};
+
 /**
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
@@ -638,6 +646,11 @@ struct iommu_ops {
  * @enable_nesting: Enable nesting
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @free: Release the domain after use.
+ * @alloc_cookie_sg: Allocate a cookie that would be used to create
+ *		     a sg list, filled from the next functions
+ * @add_deferred_map_sg: Add a mapping to a cookie of a sg list.
+ * @consume_deferred_map_sg: Consume the sg list as now all mappings are added,
+ *			     it should also release the cookie as it's not used.
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
@@ -668,6 +681,12 @@ struct iommu_domain_ops {
 				  unsigned long quirks);
 
 	void (*free)(struct iommu_domain *domain);
+
+	struct iommu_map_cookie_sg *(*alloc_cookie_sg)(unsigned long iova, int prot,
+						       unsigned int nents, gfp_t gfp);
+	int (*add_deferred_map_sg)(struct iommu_map_cookie_sg *cookie,
+				   phys_addr_t paddr, size_t pgsize, size_t pgcount);
+	int (*consume_deferred_map_sg)(struct iommu_map_cookie_sg *cookie);
 };
 
 /**
-- 
2.47.0.338.g60cca15819-goog


