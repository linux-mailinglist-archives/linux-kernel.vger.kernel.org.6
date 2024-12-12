Return-Path: <linux-kernel+bounces-443650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9B9EFA79
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B73616DADE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD556236956;
	Thu, 12 Dec 2024 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NK3fQWbA"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B730225A5E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026740; cv=none; b=h9I/HwuM2dOXQFi09jXgwTz1EI9NkQ95MoXuaKImdAEYiKZ5f5+LM9eg5s89tfP6r311tEHwu0tb9U1mvEWWDvIjDDi21cD4pQdQM+KJDmPM1qM9urv/3IBd+xyjrr2jnVbP9mlEjfdjbKEwX7io408nk2/OdXNCQ7+4gyUxFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026740; c=relaxed/simple;
	bh=zZ1Nzljx/w3TaRRu2FIWD04CjYa8X5+HeWRzj5ds/lk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IQkZN3GoVzg0Gul28OrUWT1SEfQmlvUXMCHpAq2UfkwCBdRnOgN8m3TF1LXEcorcjHQABvDIhSbApwLrlv3ewnHT0Z7da1zmOJqTOtdiH6+uJC4BL5/4PPoJcQaCoaE4528k1m7p2ZsPkUS6y0E+4y4mPiVEGDWQ5UzO5eIVWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NK3fQWbA; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385ed79291eso1146127f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026738; x=1734631538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybNvGVgl/hoCzKNXbffTwzQBiR9JZU3Un5nM2P0DGi4=;
        b=NK3fQWbAbCQzqrtPAkbMPVrwtUcReSSLuKCmelLOqVrX4XYnQaztAOjwxeEE/DvP46
         kDJSzdBeXGVwlr6daW71uB7qauZM5xDDBSYZUvI6eQkCdxvPBYGh2E0WPd0gg9FXQNbU
         kGR2fyh8ociDGexoUIeg9TJEvPQeWf2tE5o2/VSVqe8rWSF6Wu2mR/JZgJhCHe2Ynf5F
         cZPGQ69pc3s9onRtG4+UhrhQBZQuQSrDgRjIXqV2K4I6EpE9OcjhSxdKzoa3NBQcX69O
         ynE5j3hek7mgA9PiuMsb7LYBJiiRS1EY+ZtzreVMfhjW7sXfISayXB4lvICOnsVBANVL
         k9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026738; x=1734631538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybNvGVgl/hoCzKNXbffTwzQBiR9JZU3Un5nM2P0DGi4=;
        b=PoIER54v8/Dq0roWRCuz9C8YCgsN3h5McwiAZpLVWwqSPke8S3z2HmOQPm3MycflIe
         HnfcKGlbA4J9R+60SJT8OF3eMGGZCG5PQ2j83kNvVfZ9XiZESGplprZss94V9RFS2e2c
         +QJmaZAmqroMcDywjaL1Z+qFIU1x7NjqNasDTPHZzAaYIK04XScGRjaTkewVQsqp8xBz
         U5O6bp94BrFBqMxeUqaJ94TeaaRwAlaoc132OJO3JrWJeCeyJd5GFeGuRBLdXn7KNIOx
         u4g7mW01JUMbsUtm/pmnsBWwybp7+bnti85rpn9aMp+TWNg03AFmyvyFtU+MRmleBo4O
         2LkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8hftIGwY1tZvb0Byn9MrKVcO5/1nY3AvCP+9GS4uj/69zzNMi1gPGdcw5Cbj/V43vXc9epBLZPWaP75g=@vger.kernel.org
X-Gm-Message-State: AOJu0YziDXOh5lv1BgrrtemqbMWU7iWV2Micxbipevv6BmQhGhMjcW3K
	wvKEQ1MS9xMYKB8VXNbm4wcv6fyUDmxB2o127+ZotNALmBRjhl3rLhrP/ejKALgKozG/oxd1YXE
	7AdTWCj9oQw==
X-Google-Smtp-Source: AGHT+IE0b7txsRIOyvGxW20/4w0Q8YO5iAlMJIT7VhEN6QmR2/Vq39IVy03R+zOk9tpZ9g+gCkzVceXKRYZllw==
X-Received: from wmbg5.prod.google.com ([2002:a05:600c:a405:b0:434:fddf:5c1a])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:18a2:b0:385:faf5:ebc8 with SMTP id ffacd0b85a97d-38788847313mr3909644f8f.21.1734026737836;
 Thu, 12 Dec 2024 10:05:37 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:50 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-27-smostafa@google.com>
Subject: [RFC PATCH v2 26/58] KVM: arm64: smmu-v3: Initialize registers
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Ensure all writable registers are properly initialized. We do not touch
registers that will not be read by the SMMU due to disabled features.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 130 +++++++++++++++++++-
 include/kvm/arm_smmu_v3.h                   |  11 ++
 2 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
index d2a570c9f3ec..f7e60c188cb0 100644
--- a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -4,16 +4,144 @@
  *
  * Copyright (C) 2022 Linaro Ltd.
  */
+#include <asm/arm-smmu-v3-common.h>
 #include <asm/kvm_hyp.h>
 #include <kvm/arm_smmu_v3.h>
 #include <nvhe/iommu.h>
+#include <nvhe/mem_protect.h>
+#include <nvhe/mm.h>
+#include <nvhe/pkvm.h>
+
+#define ARM_SMMU_POLL_TIMEOUT_US	100000 /* 100ms arbitrary timeout */
 
 size_t __ro_after_init kvm_hyp_arm_smmu_v3_count;
 struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
 
+#define for_each_smmu(smmu) \
+	for ((smmu) = kvm_hyp_arm_smmu_v3_smmus; \
+	     (smmu) != &kvm_hyp_arm_smmu_v3_smmus[kvm_hyp_arm_smmu_v3_count]; \
+	     (smmu)++)
+
+/*
+ * Wait until @cond is true.
+ * Return 0 on success, or -ETIMEDOUT
+ */
+#define smmu_wait(_cond)					\
+({								\
+	int __i = 0;						\
+	int __ret = 0;						\
+								\
+	while (!(_cond)) {					\
+		if (++__i > ARM_SMMU_POLL_TIMEOUT_US) {		\
+			__ret = -ETIMEDOUT;			\
+			break;					\
+		}						\
+		pkvm_udelay(1);					\
+	}							\
+	__ret;							\
+})
+
+static int smmu_write_cr0(struct hyp_arm_smmu_v3_device *smmu, u32 val)
+{
+	writel_relaxed(val, smmu->base + ARM_SMMU_CR0);
+	return smmu_wait(readl_relaxed(smmu->base + ARM_SMMU_CR0ACK) == val);
+}
+
+/* Transfer ownership of structures from host to hyp */
+static int smmu_take_pages(u64 phys, size_t size)
+{
+	WARN_ON(!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size));
+	return __pkvm_host_donate_hyp(phys >> PAGE_SHIFT, size >> PAGE_SHIFT);
+}
+
+static void smmu_reclaim_pages(u64 phys, size_t size)
+{
+	WARN_ON(!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size));
+	WARN_ON(__pkvm_hyp_donate_host(phys >> PAGE_SHIFT, size >> PAGE_SHIFT));
+}
+
+static int smmu_init_registers(struct hyp_arm_smmu_v3_device *smmu)
+{
+	u64 val, old;
+	int ret;
+
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_GBPA) & GBPA_ABORT))
+		return -EINVAL;
+
+	/* Initialize all RW registers that will be read by the SMMU */
+	ret = smmu_write_cr0(smmu, 0);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(CR1_TABLE_SH, ARM_SMMU_SH_ISH) |
+	      FIELD_PREP(CR1_TABLE_OC, CR1_CACHE_WB) |
+	      FIELD_PREP(CR1_TABLE_IC, CR1_CACHE_WB) |
+	      FIELD_PREP(CR1_QUEUE_SH, ARM_SMMU_SH_ISH) |
+	      FIELD_PREP(CR1_QUEUE_OC, CR1_CACHE_WB) |
+	      FIELD_PREP(CR1_QUEUE_IC, CR1_CACHE_WB);
+	writel_relaxed(val, smmu->base + ARM_SMMU_CR1);
+	writel_relaxed(CR2_PTM, smmu->base + ARM_SMMU_CR2);
+	writel_relaxed(0, smmu->base + ARM_SMMU_IRQ_CTRL);
+
+	val = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	old = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+	/* Service Failure Mode is fatal */
+	if ((val ^ old) & GERROR_SFM_ERR)
+		return -EIO;
+	/* Clear pending errors */
+	writel_relaxed(val, smmu->base + ARM_SMMU_GERRORN);
+
+	return 0;
+}
+
+static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
+{
+	int ret;
+
+	if (!PAGE_ALIGNED(smmu->mmio_addr | smmu->mmio_size))
+		return -EINVAL;
+
+	ret = ___pkvm_host_donate_hyp(smmu->mmio_addr >> PAGE_SHIFT,
+				      smmu->mmio_size >> PAGE_SHIFT,
+				      /* accept_mmio */ true);
+	if (ret)
+		return ret;
+
+	smmu->base = hyp_phys_to_virt(smmu->mmio_addr);
+
+	ret = smmu_init_registers(smmu);
+	if (ret)
+		return ret;
+
+	return kvm_iommu_init_device(&smmu->iommu);
+}
+
 static int smmu_init(void)
 {
-	return -ENOSYS;
+	int ret;
+	struct hyp_arm_smmu_v3_device *smmu;
+	size_t smmu_arr_size = PAGE_ALIGN(sizeof(*kvm_hyp_arm_smmu_v3_smmus) *
+					  kvm_hyp_arm_smmu_v3_count);
+	phys_addr_t smmu_arr_phys;
+
+	kvm_hyp_arm_smmu_v3_smmus = kern_hyp_va(kvm_hyp_arm_smmu_v3_smmus);
+
+	smmu_arr_phys = hyp_virt_to_phys(kvm_hyp_arm_smmu_v3_smmus);
+
+	ret = smmu_take_pages(smmu_arr_phys, smmu_arr_size);
+	if (ret)
+		return ret;
+
+	for_each_smmu(smmu) {
+		ret = smmu_init_device(smmu);
+		if (ret)
+			goto out_reclaim_smmu;
+	}
+
+	return 0;
+out_reclaim_smmu:
+	smmu_reclaim_pages(smmu_arr_phys, smmu_arr_size);
+	return ret;
 }
 
 /* Shared with the kernel driver in EL1 */
diff --git a/include/kvm/arm_smmu_v3.h b/include/kvm/arm_smmu_v3.h
index 521028b3ff71..fb24bcef1624 100644
--- a/include/kvm/arm_smmu_v3.h
+++ b/include/kvm/arm_smmu_v3.h
@@ -5,8 +5,19 @@
 #include <asm/kvm_asm.h>
 #include <kvm/iommu.h>
 
+/*
+ * Parameters from the trusted host:
+ * @mmio_addr		base address of the SMMU registers
+ * @mmio_size		size of the registers resource
+ *
+ * Other members are filled and used at runtime by the SMMU driver.
+ */
 struct hyp_arm_smmu_v3_device {
 	struct kvm_hyp_iommu	iommu;
+	phys_addr_t		mmio_addr;
+	size_t			mmio_size;
+
+	void __iomem		*base;
 };
 
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
-- 
2.47.0.338.g60cca15819-goog


