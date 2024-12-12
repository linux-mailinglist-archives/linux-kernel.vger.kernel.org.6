Return-Path: <linux-kernel+bounces-443640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1434B9EFA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D3317263C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F0822FAD4;
	Thu, 12 Dec 2024 18:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tc6pTaCG"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEBF22F39D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026722; cv=none; b=GiRPe/YSYlNGD5jUeJbvryGvD7Y+6q8ynEwfO3W/pjjGLhqUp1GXUmMc3m5sGKTP8X5K3CNBbuQl5b0LgTEIrXA7H5VPd1f0h6Zqo1efS7SilgO3TK+8FPS7ehxiREFHlbX5avtMTn/yglQJF6xDEnBmdPOH4FkRDxh4N7to5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026722; c=relaxed/simple;
	bh=7DeqoP+0h4J/nlEoKq6qxUg79CviM0U7ODp/Jiv7XFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eqru/swKo08Velif0npoqlpEj8UrQ+osBb+9Be8bBxtjDwaNxJhgjsf6YjIpdCZtns5IEMUX9LXeySA7ieaDnRiUvGbvLKVgILL+WWGoa7Ho5gayow2TJjWlTEsvUwhTGiaxv6BdZa1T+X1wA88AVEEu4c+pfH3Gv1NFTLpf+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tc6pTaCG; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43624b081f3so8256605e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026719; x=1734631519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r96D7jtEo6iMT7XaPgJfnXzgjFVNWq31bg+JNNbd33c=;
        b=tc6pTaCGByxyCC/8LBWgSUwpmkEXVLg8UnWxcCETvGjl1b2jSYMo4zLSrNjRpulPUd
         vcCH8DPqkbDgcuvKpJY3wihp4SfQNn3I+6bQnuleXBRQuEYVTFoxpHl9JIetc8fYVomS
         9aA6Qy6iTCefNzw5zW/YSx3ljE3wOPY6HWrLu6HGv8lsdm5zcacOQ2BUOEAmipAqtZ7v
         VokPPYL+RZHDMOuCIXxJyMkJIhLObeFLaytHElUcJDaNhVST/rCx0UAm3/4kstMPJQOp
         rjMLNEsPnH2fDY1EOMwiYCmIbKiB8PVkJpxgYbTnsb4s2l6CMMlO554O8x4J+1XnSIxY
         CKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026719; x=1734631519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r96D7jtEo6iMT7XaPgJfnXzgjFVNWq31bg+JNNbd33c=;
        b=el+yjWgdLw92QuCO0XXkO4I+oQ5QntQrrcjWFGzbpk+m5ZLyzGYXdn0EqUjAYiMJrP
         IzAT3katZPcbUjdPJbIWV3hodLphA5QE77ywAwxcscJShXW35eRZNdeNdZ1Ldkw42H78
         ztJwPHRKl8GG7Tr4Sl1IAMBCJiQqK6ShPiI2EGJxRYv+Lo3Smk+tQpaopDo8A2DO5lv9
         fi0IPDhZRahJnvRoRzUUVCcoIU3Z3R6HeM8kTBBjG+BxuVo4jXXBsZDY6vWkdZCtYnWr
         0W6vqUCrpPXBlvQa/GHExVs44VgOFyizs66qGaBzwprKJkY6V1nB/DNLBbclvnHE4Ozf
         yASg==
X-Forwarded-Encrypted: i=1; AJvYcCV6k66v2GqxmlPnddD/QuK9mct2nxx4/FIb3kUH3jdl6Z5PfXAkdPduPfYX6T86u9jiCj9XpjtpUaAMnYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12EZQcdMsp6V1NlE7w2P7kVNH7UOxg21aU+nJTJAtRwuW28U8
	jj7ZJAyRaELhgxW3rLmnc0DQBG5MklyB66v1XYHwY/5Rpk+nhV1AqIC+m90vXqFEg1XHwpTQq1g
	lWuZdS+BMow==
X-Google-Smtp-Source: AGHT+IHOlQVhqOBCLyKRJBicSu0YdgpRP9Z8cEsxdD6v5Zy8WYvPT3uz4gGoRc3GnnVzZTWZ+pU892qsZdg7uQ==
X-Received: from wmhj22.prod.google.com ([2002:a05:600c:3016:b0:434:fe74:1bd5])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3593:b0:435:294:f1c8 with SMTP id 5b1f17b1804b1-43622883637mr32346155e9.28.1734026719225;
 Thu, 12 Dec 2024 10:05:19 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:41 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-18-smostafa@google.com>
Subject: [RFC PATCH v2 17/58] KVM: arm64: iommu: Add {attach, detach}_dev
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

Add attach/detach dev operations which are forwarded to the driver.

To avoid racing between alloc/free domain and attach/detach dev,
the refcount is used.

Although, as IOMMU attach/detach are per-IOMMU and would require
some sort of locking, nothing in the IOMMU core code need the lock
so delegate that to the driver to use locks when needed and the
hypervisor only guarantees no races between alloc/free domain.

Also, add a new function kvm_iommu_init_device() to initialise common
fields of the IOMMU struct, which is only the lock at the moment.
The IOMMU core code will need to use the lock next for power
management.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kvm/hyp/include/nvhe/iommu.h | 29 +++++++++++++
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 56 ++++++++++++++++++++++++-
 include/kvm/iommu.h                     |  8 ++++
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
index 8f619f415d1f..d6d7447fbac8 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/iommu.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -35,10 +35,39 @@ struct kvm_iommu_ops {
 	int (*init)(void);
 	int (*alloc_domain)(struct kvm_hyp_iommu_domain *domain, int type);
 	void (*free_domain)(struct kvm_hyp_iommu_domain *domain);
+	struct kvm_hyp_iommu *(*get_iommu_by_id)(pkvm_handle_t iommu_id);
+	int (*attach_dev)(struct kvm_hyp_iommu *iommu, struct kvm_hyp_iommu_domain *domain,
+			  u32 endpoint_id, u32 pasid, u32 pasid_bits);
+	int (*detach_dev)(struct kvm_hyp_iommu *iommu, struct kvm_hyp_iommu_domain *domain,
+			  u32 endpoint_id, u32 pasid);
 };
 
 int kvm_iommu_init(void);
 
+int kvm_iommu_init_device(struct kvm_hyp_iommu *iommu);
+
+static inline hyp_spinlock_t *kvm_iommu_get_lock(struct kvm_hyp_iommu *iommu)
+{
+	/* See struct kvm_hyp_iommu */
+	BUILD_BUG_ON(sizeof(iommu->lock) != sizeof(hyp_spinlock_t));
+	return (hyp_spinlock_t *)(&iommu->lock);
+}
+
+static inline void kvm_iommu_lock_init(struct kvm_hyp_iommu *iommu)
+{
+	hyp_spin_lock_init(kvm_iommu_get_lock(iommu));
+}
+
+static inline void kvm_iommu_lock(struct kvm_hyp_iommu *iommu)
+{
+	hyp_spin_lock(kvm_iommu_get_lock(iommu));
+}
+
+static inline void kvm_iommu_unlock(struct kvm_hyp_iommu *iommu)
+{
+	hyp_spin_unlock(kvm_iommu_get_lock(iommu));
+}
+
 extern struct hyp_mgt_allocator_ops kvm_iommu_allocator_ops;
 
 #endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
index ba2aed52a74f..df2dbe4c0121 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -127,6 +127,19 @@ handle_to_domain(pkvm_handle_t domain_id)
 	return &domains[domain_id % KVM_IOMMU_DOMAINS_PER_PAGE];
 }
 
+static int domain_get(struct kvm_hyp_iommu_domain *domain)
+{
+	int old = atomic_fetch_inc_acquire(&domain->refs);
+
+	BUG_ON(!old || (old + 1 < 0));
+	return 0;
+}
+
+static void domain_put(struct kvm_hyp_iommu_domain *domain)
+{
+	BUG_ON(!atomic_dec_return_release(&domain->refs));
+}
+
 int kvm_iommu_init(void)
 {
 	int ret;
@@ -210,13 +223,44 @@ int kvm_iommu_free_domain(pkvm_handle_t domain_id)
 int kvm_iommu_attach_dev(pkvm_handle_t iommu_id, pkvm_handle_t domain_id,
 			 u32 endpoint_id, u32 pasid, u32 pasid_bits)
 {
-	return -ENODEV;
+	int ret;
+	struct kvm_hyp_iommu *iommu;
+	struct kvm_hyp_iommu_domain *domain;
+
+	iommu = kvm_iommu_ops->get_iommu_by_id(iommu_id);
+	if (!iommu)
+		return -EINVAL;
+
+	domain = handle_to_domain(domain_id);
+	if (!domain || domain_get(domain))
+		return -EINVAL;
+
+	ret = kvm_iommu_ops->attach_dev(iommu, domain, endpoint_id, pasid, pasid_bits);
+	if (ret)
+		domain_put(domain);
+	return ret;
 }
 
 int kvm_iommu_detach_dev(pkvm_handle_t iommu_id, pkvm_handle_t domain_id,
 			 u32 endpoint_id, u32 pasid)
 {
-	return -ENODEV;
+	int ret;
+	struct kvm_hyp_iommu *iommu;
+	struct kvm_hyp_iommu_domain *domain;
+
+	iommu = kvm_iommu_ops->get_iommu_by_id(iommu_id);
+	if (!iommu)
+		return -EINVAL;
+
+	domain = handle_to_domain(domain_id);
+	if (!domain || atomic_read(&domain->refs) <= 1)
+		return -EINVAL;
+
+	ret = kvm_iommu_ops->detach_dev(iommu, domain, endpoint_id, pasid);
+	if (ret)
+		return ret;
+	domain_put(domain);
+	return ret;
 }
 
 size_t kvm_iommu_map_pages(pkvm_handle_t domain_id,
@@ -236,3 +280,11 @@ phys_addr_t kvm_iommu_iova_to_phys(pkvm_handle_t domain_id, unsigned long iova)
 {
 	return 0;
 }
+
+/* Must be called from the IOMMU driver per IOMMU */
+int kvm_iommu_init_device(struct kvm_hyp_iommu *iommu)
+{
+	kvm_iommu_lock_init(iommu);
+
+	return 0;
+}
diff --git a/include/kvm/iommu.h b/include/kvm/iommu.h
index 10ecaae0f6a3..6ff78d766466 100644
--- a/include/kvm/iommu.h
+++ b/include/kvm/iommu.h
@@ -45,4 +45,12 @@ extern void **kvm_nvhe_sym(kvm_hyp_iommu_domains);
 #define KVM_IOMMU_DOMAINS_ROOT_ORDER_NR	\
 	(1 << get_order(KVM_IOMMU_DOMAINS_ROOT_SIZE))
 
+struct kvm_hyp_iommu {
+#ifdef __KVM_NVHE_HYPERVISOR__
+	hyp_spinlock_t			lock;
+#else
+	u32				unused;
+#endif
+};
+
 #endif /* __KVM_IOMMU_H */
-- 
2.47.0.338.g60cca15819-goog


