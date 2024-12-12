Return-Path: <linux-kernel+bounces-443643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7929EFA74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AF418949CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBC6231A28;
	Thu, 12 Dec 2024 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GwtORUaq"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1759231A29
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026726; cv=none; b=IoMBE8lTJxYtdbGATZbXMrQtLaVq4ay9CfWcmlI8zxZZGSbP6HnuFEctrcREWUEeN8+AXsgq1DqfFFah80kB09iVIxY1YH5bWZiPQgCd+Vy1xEhQhwSJEyXT9yBaBsrf3AlibZtfaps9JSltD1caRBphWeQlzwKYbF+Wb+NqmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026726; c=relaxed/simple;
	bh=7KXEuH5v8YrWgzX2fXUjWcfTANvESrnvUggEWHtho/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=COscG+F4M68chl3D5VlRBvucI/KzIcrkhQN+iGj3eeUm/gXRto2tItvkJc63FQrWlGxGMqtYxXNLqWoUL9E+byYIzWY7FWBSes88W2fLKEUs+Rm7Qz0G1pXXxzIRxYBJBNdN7tQA47kK/HcAnygxZcqMIZTMVcIv+Y8NRf6/tX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GwtORUaq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361fc2b2d6so5532605e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026723; x=1734631523; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAsQTCVq1k5cQX4NrU1R+91jvUrFkU1qGqPwmUapmCQ=;
        b=GwtORUaqR4uaW09WyyFb62HKxAszU+RVKhO7eLALIlo7R4oJticIEwUXjzW/gCVGoz
         OlW7oPECBERWPGQ1zk6Gynkm6z4Pvry9FNF3EIU/zf7BXQ5FohWdQsFjUCfUcgmbWMf+
         qCfH6NV5MbpQoGBiVonz+b/c0w2unnRQs9TWog7+kdIqQMTseAjM0CYhEhKhDNp96Vqr
         mvDqe8t7ghNU9I6TJwS86Z3HAqJQffrY1/Zad9TdMflYJhBQqgAebC7cavAzKb2UxpdU
         D8hbNVXUbc2RL4Vlpkc+lciHv4+Gp4o9TzAeEPekDsvfzZSdSftDU72oZI/2mnC08HSX
         BDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026723; x=1734631523;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAsQTCVq1k5cQX4NrU1R+91jvUrFkU1qGqPwmUapmCQ=;
        b=JxKaX2m60J4qnJaS71llI0uXNw7BPyGgH8Hc/6MSOf2u6ySbpVhP2+ZTKh2XG5sKES
         EZdO2Vssc/7bWpSxIFzgSBdmjpXTxPmJWTYWeSiyKyfdJgNBvFhstV9lshRFElWTIoxl
         Zz/lEKncSnHQcxgaHf8x6IP8yYGde40Da/dgdJIB7uJVbYz6ihXbSfz5k4SsgcQKyFg8
         KSbBKTl26e8cgVGrghc4gKTzIayTpzz+Ruo9o1J3ZOdrUmLKYtQ6QMKka/F6dUkiIWQ6
         PXfOQ3HaCBgMV3CuxD306t3pa9iIUA391NJdl/MGJyyjQbMpxw2Pa1Ozl+LRfQ2lzhVK
         qwZw==
X-Forwarded-Encrypted: i=1; AJvYcCWBgUnkq7ISop2xd9WzlUmiCeeJvsELxRkWGeQjXN2FTDNUm8cgVfHbK2cVKerrbMWEFEGPCaO2LmIisuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJbC9DTn8BWOWsEDum+0bDgdyB4IijAgeML3wLSlgX0ASzzzLb
	s9r3JLUgWzEcNEfd2hlGH0o9GwY3/DvUtI569xwD3lesALkEJvO7IoOCWS7vzaGaqj+cXuA7zPY
	XAlG6MDqi9Q==
X-Google-Smtp-Source: AGHT+IEK5984jXibFupy1tKIQcqayv18x11IpqLmg4k+VIF9btcstf/EJxCVy5RbSEtdnliqdjvouvMqk5ypZg==
X-Received: from wmej18.prod.google.com ([2002:a05:600c:42d2:b0:434:a1af:5d39])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:59ad:0:b0:385:fb2c:6021 with SMTP id ffacd0b85a97d-3864ce986camr4566052f8f.39.1734026723319;
 Thu, 12 Dec 2024 10:05:23 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:43 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-20-smostafa@google.com>
Subject: [RFC PATCH v2 19/58] KVM: arm64: iommu: support iommu_iotlb_gather
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

To improve unmap performance, we can batch TLB invalidations at the
end of the unmap similarly to what the kernel.

We use the same data structure as the kernel and most of the same
code.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/iommu.h | 11 +++++++++--
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 22 +++++++++++++++++++++-
 include/linux/iommu.h                   | 24 +++++++++++++-----------
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
index 17f24a8eb1b9..06d12b35fa3e 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -44,15 +44,22 @@ struct kvm_iommu_ops {
 			 phys_addr_t paddr, size_t pgsize,
 			 size_t pgcount, int prot, size_t *total_mapped);
 	size_t (*unmap_pages)(struct kvm_hyp_iommu_domain *domain, unsigned long iova,
-			      size_t pgsize, size_t pgcount);
+			      size_t pgsize, size_t pgcount,
+			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct kvm_hyp_iommu_domain *domain, unsigned long iova);
-
+	void (*iotlb_sync)(struct kvm_hyp_iommu_domain *domain,
+			   struct iommu_iotlb_gather *gather);
 };
 
 int kvm_iommu_init(void);
 
 int kvm_iommu_init_device(struct kvm_hyp_iommu *iommu);
 
+void kvm_iommu_iotlb_gather_add_page(struct kvm_hyp_iommu_domain *domain,
+				     struct iommu_iotlb_gather *gather,
+				     unsigned long iova,
+				     size_t size);
+
 static inline hyp_spinlock_t *kvm_iommu_get_lock(struct kvm_hyp_iommu *iommu)
 {
 	/* See struct kvm_hyp_iommu */
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index 83321cc5f466..a6e0f3634756 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -305,12 +305,30 @@ size_t kvm_iommu_map_pages(pkvm_handle_t domain_id,
 	return total_mapped;
 }
 
+static inline void kvm_iommu_iotlb_sync(struct kvm_hyp_iommu_domain *domain,
+					struct iommu_iotlb_gather *iotlb_gather)
+{
+	if (kvm_iommu_ops->iotlb_sync)
+		kvm_iommu_ops->iotlb_sync(domain, iotlb_gather);
+
+	iommu_iotlb_gather_init(iotlb_gather);
+}
+
+void kvm_iommu_iotlb_gather_add_page(struct kvm_hyp_iommu_domain *domain,
+				     struct iommu_iotlb_gather *gather,
+				     unsigned long iova,
+				     size_t size)
+{
+	_iommu_iotlb_add_page(domain, gather, iova, size, kvm_iommu_iotlb_sync);
+}
+
 size_t kvm_iommu_unmap_pages(pkvm_handle_t domain_id, unsigned long iova,
 			     size_t pgsize, size_t pgcount)
 {
 	size_t size;
 	size_t unmapped;
 	struct kvm_hyp_iommu_domain *domain;
+	struct iommu_iotlb_gather iotlb_gather;
 
 	if (!pgsize || !pgcount)
 		return 0;
@@ -323,6 +341,7 @@ size_t kvm_iommu_unmap_pages(pkvm_handle_t domain_id, unsigned long iova,
 	if (!domain || domain_get(domain))
 		return 0;
 
+	iommu_iotlb_gather_init(&iotlb_gather);
 	/*
 	 * Unlike map, the common code doesn't call the __pkvm_host_unuse_dma,
 	 * because this means that we need either walk the table using iova_to_phys
@@ -334,7 +353,8 @@ size_t kvm_iommu_unmap_pages(pkvm_handle_t domain_id, unsigned long iova,
 	 * standardized, we leave that to the driver.
 	 */
 	unmapped = kvm_iommu_ops->unmap_pages(domain, iova, pgsize,
-						pgcount);
+						pgcount, &iotlb_gather);
+	kvm_iommu_iotlb_sync(domain, &iotlb_gather);
 
 	domain_put(domain);
 	return unmapped;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bd722f473635..c75877044185 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -911,6 +911,18 @@ static inline void iommu_iotlb_gather_add_range(struct iommu_iotlb_gather *gathe
 		gather->end = end;
 }
 
+/*
+ * If the new page is disjoint from the current range or is mapped at
+ * a different granularity, then sync the TLB so that the gather
+ * structure can be rewritten.
+ */
+#define _iommu_iotlb_add_page(domain, gather, iova, size, sync)		\
+	if (((gather)->pgsize && (gather)->pgsize != (size)) ||		\
+	    iommu_iotlb_gather_is_disjoint((gather), (iova), (size)))	\
+		sync((domain), (gather));				\
+	(gather)->pgsize = (size);					\
+	iommu_iotlb_gather_add_range((gather), (iova), (size))
+
 /**
  * iommu_iotlb_gather_add_page - Gather for page-based TLB invalidation
  * @domain: IOMMU domain to be invalidated
@@ -926,17 +938,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 					       struct iommu_iotlb_gather *gather,
 					       unsigned long iova, size_t size)
 {
-	/*
-	 * If the new page is disjoint from the current range or is mapped at
-	 * a different granularity, then sync the TLB so that the gather
-	 * structure can be rewritten.
-	 */
-	if ((gather->pgsize && gather->pgsize != size) ||
-	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
-		iommu_iotlb_sync(domain, gather);
-
-	gather->pgsize = size;
-	iommu_iotlb_gather_add_range(gather, iova, size);
+	_iommu_iotlb_add_page(domain, gather, iova, size, iommu_iotlb_sync);
 }
 
 static inline bool iommu_iotlb_gather_queued(struct iommu_iotlb_gather *gather)
-- 
2.47.0.338.g60cca15819-goog


