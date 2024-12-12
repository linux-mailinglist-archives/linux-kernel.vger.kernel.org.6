Return-Path: <linux-kernel+bounces-443641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D7F9EFA72
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6FB18958F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4611C231A41;
	Thu, 12 Dec 2024 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFXCdZTN"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18DA22FE08
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026725; cv=none; b=LrYVW6cvcJG0nyOSGjMTeTJ7mkanVMEovHGCxmIUMgdkjuxFBc5LAHeBhsS7E2z7M4kD0aXHf6wEuUtZhVxkF/WBjVA0FE91rQ8pJnJILjh4GILphVW/9kVbSAR7yuvK6OT6Zt0NA92kYIfMTi79foMw1k0KsXJ6hjXZnb1gtII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026725; c=relaxed/simple;
	bh=8/JR72FsO9ooIjOLkT1P8qfkZvbDSIe4qDlXrNLBT5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tdRq+NIsEDm0V7Zv7lg4kgwKyAw0Rtk3f5UoL6qxZ/6PIklrX0lMDZ6znerSelBMkRhOiBWoxOedqf6OkqPKcbz4mbFYeyl+U4Kh0cUzCMe/T6iNaExtygRFHSkplRE0XJAyxr8/K03W3IxCUQegBavy42il4P0XEEVJqqD7IeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFXCdZTN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361ac607b6so7281025e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026721; x=1734631521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW1+nydU55G8nQ9hrqIcRZ7rSjcAUC8BJY9QSeiwFSI=;
        b=IFXCdZTNyy2kNhCHXGcMDSliESDMDzytMKQoOBnATrrU+LqV738EVGqs8PJQ/5EOVm
         VTVqeoTT2P+T0UxNBe43yWmm7/TkFg39rA3xihdspDAVo+6JB4JDF8lJHpqR4LzQKOUH
         IIGqYDAIy6QW34UClmTY+ljlGEccken0m6FGStD+oHEqjcN9zu9m9Nyl+ryAEus+/bmM
         feN1ZyGDGYotEXGzEmftVuRAAZ9qoYK2K1UvJFxB91MMZ8CLPVs5L3y+fnF07//YNkbR
         G2c/m/a6oYukmpGkqb9BWdJLK7dmeUNehF88GZVKZQX6iH4lqkLFJWQK5fBjlrlNNMH5
         vMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026721; x=1734631521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW1+nydU55G8nQ9hrqIcRZ7rSjcAUC8BJY9QSeiwFSI=;
        b=Emfcnqi72crlDwKU+ieF9w3WAWPVsKKK2DRjlbjJGI+PycM80fBG+bl003f2k73nmj
         p1yKhDthyjiaVr4bsBrEb86OMnXsNMEGLb16SdEV3Lfwctdd5hhExIMlcZNuBn6b+KxR
         2vDJkmMxvRq4M9OW99lnZ+2CEHJGiskqPwKwx9+lTmCin52Gv0CJThkWEASqJTlbf8ci
         TKEzXBDjr7+faTf4bfZBPekBupHDl74SNufKp1XPf7w64uS4OJWlQyqBBsC+TAl9lHVV
         Hk831+yfCjdUAksW2/F+CVdj3n6818D2e6f8uwmIikVy+6ECnLlfW+pIx7k74mtykg53
         68uw==
X-Forwarded-Encrypted: i=1; AJvYcCUwPYoD4fTdIt2nUfgWRLD0BcPGpSw9B0exmcUIXfT9+dt6aVZJs5PXzSzj/1XRBVwlI+XIoHf65xfRe/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEZPF2AcK4Jq7ezBRYMsB9eTXLO70Z/CANtaNV7w8XcyeR8lc
	GZXtXF9GN5bSF73InhQQez9aB6qRIYgbWZKS/i/hlNhy7VKgjad9d8FlKawND4VUGCs9b6fttVq
	OWyhzNK9FUw==
X-Google-Smtp-Source: AGHT+IF/eVrE/BNFHjZA31UXBb9BGDdvQQjzrDNU0uCStoSMr927atSRKA4GQ6BWli6UKC37YTy5oYGnkZ5VOA==
X-Received: from wmpl36.prod.google.com ([2002:a05:600c:8a4:b0:434:f0d4:cbaf])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19ca:b0:434:a75b:5f59 with SMTP id 5b1f17b1804b1-43622823a73mr44642205e9.3.1734026721375;
 Thu, 12 Dec 2024 10:05:21 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:42 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-19-smostafa@google.com>
Subject: [RFC PATCH v2 18/58] KVM: arm64: iommu: Add map/unmap() operations
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

Handle map(), unmap() and iova_to_phys() hypercalls.

In addition to map/unmap, the hypervisor has to ensure that all
mapped pages are tracked, so be before each map()
__pkvm_host_use_dma() would be called to ensure that.

Similarly, on unmap() we need to decrement the refcount using
__pkvm_host_unuse_dma().

However, doing this in standard way as mentioned in the comments is
challenging, so we leave that to the driver.

Also, the hypervisor only guarantees that there are no races
between alloc/free domain operations using the domain refcount to
avoid using extra locks.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kvm/hyp/include/nvhe/iommu.h |  7 +++
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 80 ++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
index d6d7447fbac8..17f24a8eb1b9 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -40,6 +40,13 @@ struct kvm_iommu_ops {
 			  u32 endpoint_id, u32 pasid, u32 pasid_bits);
 	int (*detach_dev)(struct kvm_hyp_iommu *iommu, struct kvm_hyp_iommu_domain *domain,
 			  u32 endpoint_id, u32 pasid);
+	int (*map_pages)(struct kvm_hyp_iommu_domain *domain, unsigned long iova,
+			 phys_addr_t paddr, size_t pgsize,
+			 size_t pgcount, int prot, size_t *total_mapped);
+	size_t (*unmap_pages)(struct kvm_hyp_iommu_domain *domain, unsigned long iova,
+			      size_t pgsize, size_t pgcount);
+	phys_addr_t (*iova_to_phys)(struct kvm_hyp_iommu_domain *domain, unsigned long iova);
+
 };
 
 int kvm_iommu_init(void);
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index df2dbe4c0121..83321cc5f466 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -263,22 +263,96 @@ int kvm_iommu_detach_dev(pkvm_handle_t iommu_id, pkvm_handle_t domain_id,
 	return ret;
 }
 
+#define IOMMU_PROT_MASK (IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE |\
+			 IOMMU_NOEXEC | IOMMU_MMIO | IOMMU_PRIV)
+
 size_t kvm_iommu_map_pages(pkvm_handle_t domain_id,
 			   unsigned long iova, phys_addr_t paddr, size_t pgsize,
 			   size_t pgcount, int prot)
 {
-	return 0;
+	size_t size;
+	int ret;
+	size_t total_mapped = 0;
+	struct kvm_hyp_iommu_domain *domain;
+
+	if (prot & ~IOMMU_PROT_MASK)
+		return 0;
+
+	if (__builtin_mul_overflow(pgsize, pgcount, &size) ||
+	    iova + size < iova || paddr + size < paddr)
+		return 0;
+
+	domain = handle_to_domain(domain_id);
+	if (!domain || domain_get(domain))
+		return 0;
+
+	ret = __pkvm_host_use_dma(paddr, size);
+	if (ret)
+		return 0;
+
+	kvm_iommu_ops->map_pages(domain, iova, paddr, pgsize, pgcount, prot, &total_mapped);
+
+	pgcount -= total_mapped / pgsize;
+	/*
+	 * unuse the bits that haven't been mapped yet. The host calls back
+	 * either to continue mapping, or to unmap and unuse what's been done
+	 * so far.
+	 */
+	if (pgcount)
+		__pkvm_host_unuse_dma(paddr + total_mapped, pgcount * pgsize);
+
+	domain_put(domain);
+	return total_mapped;
 }
 
 size_t kvm_iommu_unmap_pages(pkvm_handle_t domain_id, unsigned long iova,
 			     size_t pgsize, size_t pgcount)
 {
-	return 0;
+	size_t size;
+	size_t unmapped;
+	struct kvm_hyp_iommu_domain *domain;
+
+	if (!pgsize || !pgcount)
+		return 0;
+
+	if (__builtin_mul_overflow(pgsize, pgcount, &size) ||
+	    iova + size < iova)
+		return 0;
+
+	domain = handle_to_domain(domain_id);
+	if (!domain || domain_get(domain))
+		return 0;
+
+	/*
+	 * Unlike map, the common code doesn't call the __pkvm_host_unuse_dma,
+	 * because this means that we need either walk the table using iova_to_phys
+	 * similar to VFIO then unmap and call this function, or unmap leaf (page or
+	 * block) at a time, where both might be suboptimal.
+	 * For some IOMMU, we can do 2 walks where one only invalidate the pages
+	 * and the other decrement the refcount.
+	 * As, semantics for this might differ between IOMMUs and it's hard to
+	 * standardized, we leave that to the driver.
+	 */
+	unmapped = kvm_iommu_ops->unmap_pages(domain, iova, pgsize,
+						pgcount);
+
+	domain_put(domain);
+	return unmapped;
 }
 
 phys_addr_t kvm_iommu_iova_to_phys(pkvm_handle_t domain_id, unsigned long iova)
 {
-	return 0;
+	phys_addr_t phys = 0;
+	struct kvm_hyp_iommu_domain *domain;
+
+	domain = handle_to_domain( domain_id);
+
+	if (!domain || domain_get(domain))
+		return 0;
+
+	phys = kvm_iommu_ops->iova_to_phys(domain, iova);
+	domain_put(domain);
+	return phys;
 }
 
 /* Must be called from the IOMMU driver per IOMMU */
-- 
2.47.0.338.g60cca15819-goog


