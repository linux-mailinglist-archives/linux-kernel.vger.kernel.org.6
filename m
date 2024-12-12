Return-Path: <linux-kernel+bounces-443656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B049EFA89
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D570A1892148
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AD523A186;
	Thu, 12 Dec 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kvek8QwT"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D3239BA9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026753; cv=none; b=aLu8JBdnsi7xT8oD3GBWIpuaVpi7z88jHURCD34VIrd5OaT0kYAN55QIFLdl0rJMC4sPd9oc1lrJM8jnbVvEULfaX3XUN9n+3GosogaEtNAY70GQPPinnREhUWVyu/FwaNTJnc4OZGtUqAVUzpd8rT6eV2cWbAissBZvnwQpA+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026753; c=relaxed/simple;
	bh=rKruoUMFqJDGZAjSYxqmVBeUt8pQ/t5eBu3d7duzRY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FOt7WXbYcQyeNLCOY+EAFDm5aDB5rvRtp1SHfgvB3OtrGe9vQshj2f429yTEM9h2n0SxPY1TAik5fNdSfs3b2goIBiHot20hhvDC6u/skUDIztubrOZpXfAKiTIku3x3Nji7NP7IWpAAnRSdv7gZBKFEIcymi74T8l08STGb8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kvek8QwT; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-436219070b4so5746475e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026750; x=1734631550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0p39a77mImTT2bcTUkjv5rHSXECPntFQZjkOUsIrRs=;
        b=Kvek8QwTEsN3DwNVu9bZnUGJhxY+eobbV6MsjPwc/H8SAbhSCp/yM4wrccom6GWsbX
         2hL3JzLYX1BHGrPvJlFtfyhX3B9axky1vEwgTvusueIV5zqWE6q82juw72hobspMxx9C
         Zp3aYlCx5wm9/ldFqD95gUUcykP/KB/FOObI3EIJkO/mYmKmWfhfPmHswvRTOBd5OC1u
         8lpbIaj80XOhV8C3w9EF+T66WkoGX/lRVrnVQbKxOOZOcMhx9bnKAwwY7C8Vcn4cN3mJ
         W51MOkF69AWBWWI12RI6EBS6ua2DYwpjhGU4aka54Pb8cMexjDC9aMFbU5nhUtpX63Bh
         FWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026750; x=1734631550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0p39a77mImTT2bcTUkjv5rHSXECPntFQZjkOUsIrRs=;
        b=FGy9gZbosMEzhiKkFIxULObchggDHh1lRhIeuYAlfJCYefvbJHB8eRZ616jROQqSaG
         04tLmceOI4oMzYbnHeEsuC+e3YEzbaE/EPhEK4vZHHVt6/CEpX3wktTodXXHh5d4iYgd
         aksBUl/V/wRuycHy57dJ4DJK//gB8qH3e14WuAvaKtDqPtCd27p8NzFKXGiGdh/o/mxd
         Vtn042IGJY8NOuvVzEg8FTVW3MrvaueAS4HAvu2hbab3s7Jw6n3D9EXBOp1uWVUSk75o
         DWKOmGdV3qsUgii64gS9pxh45P7naz6umB602paP6w0SkI2GsUhjZ4bKRl0tZTlf97tZ
         lmdA==
X-Forwarded-Encrypted: i=1; AJvYcCX/Dr6rsRWJAvlUBIMjzGohGdn04B5WuV4mMOvsPpv3KtUZ56eSbvgrAYrQgrvVcnGz7xIeBEmLVHnZGS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt7lUhmyNjGe4g3kGAfff5hijOkpDMMAvYepLcsDjg9Ab0HR9j
	1+19/p/sJlwzOwSW+CeWjXGgeWf6NQihIIRKisnzjUb/w6nY8cPKSCUJKHDzDxLpeDj9VlY6+Yy
	xw5XNwyLi4w==
X-Google-Smtp-Source: AGHT+IG1KFj+8kiPF7R9tNS1w0lYL0LFPzKnh4cL4W+DNw5iDRjcSi9WleF5S9ilyTwoZ5oQcyfDOI5ctOSx2A==
X-Received: from wmkz18.prod.google.com ([2002:a7b:c7d2:0:b0:434:a15f:e7ea])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a011:b0:434:f623:9fe3 with SMTP id 5b1f17b1804b1-4361c3755bamr72354245e9.16.1734026750412;
 Thu, 12 Dec 2024 10:05:50 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:56 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-33-smostafa@google.com>
Subject: [RFC PATCH v2 32/58] KVM: arm64: smmu-v3: Add {alloc/free}_domain
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

Add SMMUv3 alloc/free domain, as this operations are not
tied to the IOMMU, we can't do much with the io-pgtable
allocation or configuration.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 64 +++++++++++++++++++++
 include/kvm/arm_smmu_v3.h                   |  6 ++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index 58662c2c4c97..3181933e9a34 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -7,6 +7,8 @@
 #include <asm/arm-smmu-v3-common.h>
 #include <asm/kvm_hyp.h>
 #include <kvm/arm_smmu_v3.h>
+#include <linux/io-pgtable-arm.h>
+#include <nvhe/alloc.h>
 #include <nvhe/iommu.h>
 #include <nvhe/mem_protect.h>
 #include <nvhe/mm.h>
@@ -50,6 +52,22 @@ struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
 	smmu_wait(_cond);					\
 })
 
+/*
+ * SMMUv3 domain:
+ * @domain: Pointer to the IOMMU domain.
+ * @smmu: SMMU instance for this domain.
+ * @type: Type of domain (S1, S2)
+ * @pgt_lock: Lock for page table
+ * @pgtable: io_pgtable instance for this domain
+ */
+struct hyp_arm_smmu_v3_domain {
+	struct kvm_hyp_iommu_domain     *domain;
+	struct hyp_arm_smmu_v3_device	*smmu;
+	u32				type;
+	hyp_spinlock_t			pgt_lock;
+	struct io_pgtable		*pgtable;
+};
+
 static int smmu_write_cr0(struct hyp_arm_smmu_v3_device *smmu, u32 val)
 {
 	writel_relaxed(val, smmu->base + ARM_SMMU_CR0);
@@ -541,7 +559,53 @@ static int smmu_init(void)
 	return ret;
 }
 
+static struct kvm_hyp_iommu *smmu_id_to_iommu(pkvm_handle_t smmu_id)
+{
+	if (smmu_id >= kvm_hyp_arm_smmu_v3_count)
+		return NULL;
+	smmu_id = array_index_nospec(smmu_id, kvm_hyp_arm_smmu_v3_count);
+
+	return &kvm_hyp_arm_smmu_v3_smmus[smmu_id].iommu;
+}
+
+static int smmu_alloc_domain(struct kvm_hyp_iommu_domain *domain, int type)
+{
+	struct hyp_arm_smmu_v3_domain *smmu_domain;
+
+	if (type >= KVM_ARM_SMMU_DOMAIN_MAX)
+		return -EINVAL;
+
+	smmu_domain = hyp_alloc(sizeof(*smmu_domain));
+	if (!smmu_domain)
+		return -ENOMEM;
+
+	/*
+	 * Can't do much without knowing the SMMUv3.
+	 * Page table will be allocated at attach_dev, but can be
+	 * freed from free domain.
+	 */
+	smmu_domain->domain = domain;
+	smmu_domain->type = type;
+	hyp_spin_lock_init(&smmu_domain->pgt_lock);
+	domain->priv = (void *)smmu_domain;
+
+	return 0;
+}
+
+static void smmu_free_domain(struct kvm_hyp_iommu_domain *domain)
+{
+	struct hyp_arm_smmu_v3_domain *smmu_domain = domain->priv;
+
+	if (smmu_domain->pgtable)
+		kvm_arm_io_pgtable_free(smmu_domain->pgtable);
+
+	hyp_free(smmu_domain);
+}
+
 /* Shared with the kernel driver in EL1 */
 struct kvm_iommu_ops smmu_ops = {
 	.init				= smmu_init,
+	.get_iommu_by_id		= smmu_id_to_iommu,
+	.alloc_domain			= smmu_alloc_domain,
+	.free_domain			= smmu_free_domain,
 };
diff --git a/include/kvm/arm_smmu_v3.h b/include/kvm/arm_smmu_v3.h
index 352c1b2dc72a..ded98cbaebc1 100644
--- a/include/kvm/arm_smmu_v3.h
+++ b/include/kvm/arm_smmu_v3.h
@@ -33,4 +33,10 @@ extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
 extern struct hyp_arm_smmu_v3_device *kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_smmus);
 #define kvm_hyp_arm_smmu_v3_smmus kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_smmus)
 
+enum kvm_arm_smmu_domain_type {
+	KVM_ARM_SMMU_DOMAIN_S1,
+	KVM_ARM_SMMU_DOMAIN_S2,
+	KVM_ARM_SMMU_DOMAIN_MAX,
+};
+
 #endif /* __KVM_ARM_SMMU_V3_H */
-- 
2.47.0.338.g60cca15819-goog


