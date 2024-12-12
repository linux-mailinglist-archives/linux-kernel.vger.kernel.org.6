Return-Path: <linux-kernel+bounces-443680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FF79EFAA9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77F21891656
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F15242F09;
	Thu, 12 Dec 2024 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSReQJIJ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11856242EEE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026803; cv=none; b=hh0tA/z7yoJM9hpfE1uUuoKPVd/HIQ7lhE3cc9txBIJRq52taa+0aSWPVEh6erIcv577iQJV9rN67UAV9Uyu1PKgfc3wIzLI0JYa3/rNNr+e+B7a+H6phxrs3xxmVY7JqHx2PVrbxRyW5U1lklvr00Baa69gr/Z/xkOEqDKRQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026803; c=relaxed/simple;
	bh=hiVH2C6llEMbjz526V+xYppiQALZW/CAzVLix4VAOkk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I0iCYUFgnd5GB5PpPuqGpw5OA1vAGyl26c9Q+A368rqt1Yr5br76PHbFvkOViMXvI0ZNRmRZzuK3FFlX3l81xdDKn6NmD/F7BKT53E6yZIbuYocvJbj7lVgUY51BEm7++IP+0ufRpI6pvxOd2RUqf1onYlTIgr2BzkSZOPu6P24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSReQJIJ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-436228ebc5eso5631745e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026800; x=1734631600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8LOnKB51DX+hbW0El8jQ5+VtfI8i+DJEmanKBr5IaOc=;
        b=MSReQJIJZa5j7QS/dVEcZ2WZAAt0PSnZiOraVGIEI8fcNepSr+cQliY+S99lvX69oh
         yEWnPUfVk/VxvGGHvYXIUlyBVzvnFSvm8fBS5DMHUfu8mpMjzJYSN9B8EEGepJ9AqcwR
         j9Gz263ro/5KzJwJx+RubYc6lz41ZItd++u24V81VUAuR4S8bUq/lHNSiKoiu2ZpAlKX
         HZ4Qd8lr+Y31fAzZsh5exazAzq0K5auBZ9+GBjb62d6eBc5gzMAaWSwQ3XdclVQGyfZe
         u+Yjgx7I1YwjxN8Dz9/yBF6BekleVz+63JbOqaeYAlogrZERqN075eHviUFEdvgvhFjD
         9r/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026800; x=1734631600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LOnKB51DX+hbW0El8jQ5+VtfI8i+DJEmanKBr5IaOc=;
        b=h4rzggbQgg5BrhLGHkZiNdnI6MUIeF7RLUwGpXH/b9I82iX9tDiUepcFagQzm9YH7h
         PIGcgEh/rZayCirHuZTNDCNvnAT8q5jWjH7Fn9ylV6zhA9OKXRXcMyqydbqgkP7waoBr
         Tp2a0lL6cPBqfoxFqTA6o20faT8Gq/zjfXJktA3OFytH1T642wMLANTIr685a2kRgXVu
         CQzC2T/tof0I+7OVvFBbEAsAhTC5NFNwmGhkEj0uqPr7DPgcB1vrOT/oxhxhIwjcDRdF
         vFGIY0m58Pu+Ynh5UD2AhWU1293s4J1fySIAKUfYJgoS9klHZQQXdj2suX95ScMK7a4p
         LTxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsqWWPgpZ0kJBSk7DLCBK7PUCLh9mnQ30tZHdMjSVUlmKQfd+BwZMe/moHDhVfJXBVJ5cyC7j6vNxDc+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBUlkPPkQLGJXK8ushrJ93uJljY8PivqfdgjWnTkAWAzR6e+C
	M+FNJ9cbHUOxWV31UxkOtMhRyYaqTUmBppJjbc4rujd7brI1ZhyNQNc1DcJl5EkejhE0pfUe26v
	cGLpaMTMyYA==
X-Google-Smtp-Source: AGHT+IE8zSOvadgYlQu/oyCrvtp7QB6KNjjif3fcyBgRNu+AsyTgZxEHuVmvUAgeCaCC/YUaZxC98HiuTjTEZA==
X-Received: from wmgg15.prod.google.com ([2002:a05:600d:f:b0:434:feb1:add1])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3109:b0:434:fafe:edb with SMTP id 5b1f17b1804b1-4361c3e22e7mr61901735e9.24.1734026800793;
 Thu, 12 Dec 2024 10:06:40 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:20 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-57-smostafa@google.com>
Subject: [RFC PATCH v2 56/58] KVM: arm64: iommu: Add hypercall for map_sg
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

Add a new type struct kvm_iommu_sg, that describes a simple sglist,
and a hypercall that can consume it while calling the map_pages ops.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/include/asm/kvm_asm.h        |  1 +
 arch/arm64/include/asm/kvm_host.h       | 19 ++++++++
 arch/arm64/kvm/hyp/include/nvhe/iommu.h |  2 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      | 14 ++++++
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 58 +++++++++++++++++++++++++
 arch/arm64/kvm/iommu.c                  | 32 ++++++++++++++
 6 files changed, 126 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 3dbf30cd10f3..f2b86d1a62ed 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -115,6 +115,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_iommu_unmap_pages,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_iommu_iova_to_phys,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_hvc_pd,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_iommu_map_sg,
 
 	/*
 	 * Start of the dynamically registered hypercalls. Start a bit
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3cdc99ebdd0d..704648619d28 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1655,4 +1655,23 @@ int kvm_iommu_register_driver(struct kvm_iommu_driver *kern_ops,
 int kvm_iommu_init_driver(void);
 void kvm_iommu_remove_driver(void);
 
+struct kvm_iommu_sg {
+	phys_addr_t phys;
+	size_t pgsize;
+	unsigned int pgcount;
+};
+
+static inline struct kvm_iommu_sg *kvm_iommu_sg_alloc(unsigned int nents, gfp_t gfp)
+{
+	return alloc_pages_exact(PAGE_ALIGN(nents * sizeof(struct kvm_iommu_sg)), gfp);
+}
+
+static inline void kvm_iommu_sg_free(struct kvm_iommu_sg *sg, unsigned int nents)
+{
+	free_pages_exact(sg, PAGE_ALIGN(nents * sizeof(struct kvm_iommu_sg)));
+}
+
+int kvm_iommu_share_hyp_sg(struct kvm_iommu_sg *sg, unsigned int nents);
+int kvm_iommu_unshare_hyp_sg(struct kvm_iommu_sg *sg, unsigned int nents);
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
index cff75d67d807..1004465b680a 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -22,6 +22,8 @@ size_t kvm_iommu_unmap_pages(pkvm_handle_t domain_id, unsigned long iova,
 			     size_t pgsize, size_t pgcount);
 phys_addr_t kvm_iommu_iova_to_phys(pkvm_handle_t domain_id, unsigned long iova);
 bool kvm_iommu_host_dabt_handler(struct kvm_cpu_context *host_ctxt, u64 esr, u64 addr);
+size_t kvm_iommu_map_sg(pkvm_handle_t domain, unsigned long iova, struct kvm_iommu_sg *sg,
+			unsigned int nent, unsigned int prot);
 
 /* Flags for memory allocation for IOMMU drivers */
 #define IOMMU_PAGE_NOCACHE				BIT(0)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 1ab8e5507825..5659aae0c758 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -1682,6 +1682,19 @@ static void handle___pkvm_host_hvc_pd(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = pkvm_host_hvc_pd(device_id, on);
 }
 
+static void handle___pkvm_host_iommu_map_sg(struct kvm_cpu_context *host_ctxt)
+{
+	unsigned long ret;
+	DECLARE_REG(pkvm_handle_t, domain, host_ctxt, 1);
+	DECLARE_REG(unsigned long, iova, host_ctxt, 2);
+	DECLARE_REG(struct kvm_iommu_sg *, sg, host_ctxt, 3);
+	DECLARE_REG(unsigned int, nent, host_ctxt, 4);
+	DECLARE_REG(unsigned int, prot, host_ctxt, 5);
+
+	ret = kvm_iommu_map_sg(domain, iova, kern_hyp_va(sg), nent, prot);
+	hyp_reqs_smccc_encode(ret, host_ctxt, this_cpu_ptr(&host_hyp_reqs));
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -1747,6 +1760,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_host_iommu_unmap_pages),
 	HANDLE_FUNC(__pkvm_host_iommu_iova_to_phys),
 	HANDLE_FUNC(__pkvm_host_hvc_pd),
+	HANDLE_FUNC(__pkvm_host_iommu_map_sg),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index e45dadd0c4aa..b0c9b9086fd1 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -392,6 +392,64 @@ bool kvm_iommu_host_dabt_handler(struct kvm_cpu_context *host_ctxt, u64 esr, u64
 	return ret;
 }
 
+size_t kvm_iommu_map_sg(pkvm_handle_t domain_id, unsigned long iova, struct kvm_iommu_sg *sg,
+			unsigned int nent, unsigned int prot)
+{
+	int ret;
+	size_t total_mapped = 0, mapped;
+	struct kvm_hyp_iommu_domain *domain;
+	phys_addr_t phys;
+	size_t size, pgsize, pgcount;
+	unsigned int orig_nent = nent;
+	struct kvm_iommu_sg *orig_sg = sg;
+
+	if (!kvm_iommu_ops || !kvm_iommu_ops->map_pages)
+		return 0;
+
+	if (prot & ~IOMMU_PROT_MASK)
+		return 0;
+
+	domain = handle_to_domain(domain_id);
+	if (!domain || domain_get(domain))
+		return 0;
+
+	ret = hyp_pin_shared_mem(sg, sg + nent);
+	if (ret)
+		goto out_put_domain;
+
+	while (nent--) {
+		phys = sg->phys;
+		pgsize = sg->pgsize;
+		pgcount = sg->pgcount;
+
+		if (__builtin_mul_overflow(pgsize, pgcount, &size) ||
+		    iova + size < iova)
+			goto out_unpin_sg;
+
+		ret = __pkvm_host_use_dma(phys, size);
+		if (ret)
+			goto out_unpin_sg;
+
+		mapped = 0;
+		kvm_iommu_ops->map_pages(domain, iova, phys, pgsize, pgcount, prot, &mapped);
+		total_mapped += mapped;
+		phys += mapped;
+		iova += mapped;
+		/* Might need memory */
+		if (mapped != size) {
+			__pkvm_host_unuse_dma(phys, size - mapped);
+			break;
+		}
+		sg++;
+	}
+
+out_unpin_sg:
+	hyp_unpin_shared_mem(orig_sg, orig_sg + orig_nent);
+out_put_domain:
+	domain_put(domain);
+	return total_mapped;
+}
+
 static int iommu_power_on(struct kvm_power_domain *pd)
 {
 	struct kvm_hyp_iommu *iommu = container_of(pd, struct kvm_hyp_iommu,
diff --git a/arch/arm64/kvm/iommu.c b/arch/arm64/kvm/iommu.c
index af3417e6259d..99718af0cba6 100644
--- a/arch/arm64/kvm/iommu.c
+++ b/arch/arm64/kvm/iommu.c
@@ -55,3 +55,35 @@ void kvm_iommu_remove_driver(void)
 	if (smp_load_acquire(&iommu_driver))
 		iommu_driver->remove_driver();
 }
+
+int kvm_iommu_share_hyp_sg(struct kvm_iommu_sg *sg, unsigned int nents)
+{
+	size_t nr_pages = PAGE_ALIGN(sizeof(*sg) * nents) >> PAGE_SHIFT;
+	phys_addr_t sg_pfn = virt_to_phys(sg) >> PAGE_SHIFT;
+	int i;
+	int ret;
+
+	for (i = 0 ; i < nr_pages ; ++i) {
+		ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp, sg_pfn + i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int kvm_iommu_unshare_hyp_sg(struct kvm_iommu_sg *sg, unsigned int nents)
+{
+	size_t nr_pages = PAGE_ALIGN(sizeof(*sg) * nents) >> PAGE_SHIFT;
+	phys_addr_t sg_pfn = virt_to_phys(sg) >> PAGE_SHIFT;
+	int i;
+	int ret;
+
+	for (i = 0 ; i < nr_pages ; ++i) {
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp, sg_pfn + i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
-- 
2.47.0.338.g60cca15819-goog


