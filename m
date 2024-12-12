Return-Path: <linux-kernel+bounces-443649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7EF9EFA78
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E69172875
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BB5226165;
	Thu, 12 Dec 2024 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDkly875"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2E2368E9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026738; cv=none; b=KpQFt2zbKgTt8Udxmu/KGtkp+mxMveQaIbTokNkdBTJpxoH8rDfLBTuW3hDopdih69TiyhiUIN++HYRmnmahLTa4kdr5YpPKUKAIWt3AOrDJCA6bmNnp8mvxn8duuoLKRIJvHGW7ShCHtmpOFpHIF2KBJJNSmvUsIC17LCb7WDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026738; c=relaxed/simple;
	bh=Z2UHwzkM46eNyOELnlSu5KplZV6dyg6FmiiX5LeoOuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PMInivWQegoOMo97bI5x2Uk6sxiu5pZvIQ497fxdg0o1Y39xQ99lcPliBZ34MTWFmqaK3C2AMwKsuVxo/V48SjMzAU6SDuuM6BgA1SZEMCNEpUTsLviqhP+826lGPicq8SCRV7hmqmbmAMMK2aJ3+B2Ij05paiywhfMyvlp+ONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HDkly875; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43582d49dacso8227735e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026736; x=1734631536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdMuO2gtmeL3RMqWaakXFL6M4DlcZZq40B5WqzcNta4=;
        b=HDkly875IfJkYrNdjky4itPOkt4EsAS85atpFDpufJ7IoUw41Nlgl43AvWc9EnqW3/
         4iZUQYwdEJwkF3OPs8a2OLcoNck6pekbBtbViea/KuwR/R3IBvCiLBv6O+5AK9j8MzLv
         xtH1r7qKOOZ+dvORe4M6CUpP1lAaviWMQ/yNFGSlxtttTkp4+c08bCzVudoQ//IXgmij
         0mvre9HNEbGsscOHdgVqtyNQma/S5jd5LRKYB6lfpNPV2Nr1s8hrr8+ca8sZEuRy9UnR
         12wIUyPedjEWEhg4rSV5cP3ZHAV07/uwUPNhieZmDm5F7R/kVlJRt/IGZgXB3bLKUP+P
         JfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026736; x=1734631536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdMuO2gtmeL3RMqWaakXFL6M4DlcZZq40B5WqzcNta4=;
        b=VR6aDsoihucg9tA7okcz8SDytnmgOc6UKrnnUzmKTYrO5K66ZBmsge7PmEHc7kqh8n
         QR86A7Muc6J80+rnCDRb+DZo2x6FxJzHkavRQusSwSMXc/lfeZbXL96i6Bk9ynA+sxMV
         +Y6NAOZZ56LImW83/iYu1KqX8HCWOc2EGyu23feBxriXoCTlK8C/uKou9e/Dk8Mu+EXQ
         gjy64EniPr0p6cpRBS3RSbRTf0wuUk7RsazMQAuIP/GOvWE0Pk3gorXMP++yV19Lq22D
         u4AfyFgoMUkY4283Hqd9tExVA7Bg8lK5W3B9q3slvKUAqbFlSCoFq2VRUXk1XyEVUszk
         i8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCW47X1MB+/oYpkaB/gGLDGqdAjFsSSYTllsT+l8EZd+yGKedvGKK9HOWzMinhd7glP0EMOAFwfb3XdSHdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZAgspnSLrYdyK9S/B9n86APY3SM0jaLBspJsk8H6/Rw0ltzOE
	O+7VkaOeJHhZ1gDEYobQE6r8BJtvqq/2SMB0wm4UZRt8jAxAFBnwjHage86cH4EskISAg4A8Tj9
	k/aL2bsL3hw==
X-Google-Smtp-Source: AGHT+IFhLgvU2Rm+DNubCv6JNasQpuX6sd+/DiydVh4HkRumx8mqOJN1mpnAimZm+KH9fDL3y3s/kc2a4/LuEQ==
X-Received: from wmso20.prod.google.com ([2002:a05:600c:5114:b0:436:1abf:b8fe])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5028:b0:435:172:5052 with SMTP id 5b1f17b1804b1-4362282768bmr38379225e9.1.1734026735825;
 Thu, 12 Dec 2024 10:05:35 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:49 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-26-smostafa@google.com>
Subject: [RFC PATCH v2 25/58] KVM: arm64: iommu: Add SMMUv3 driver
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

Add the skeleton for an Arm SMMUv3 driver at EL2.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile            |  2 ++
 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c | 22 +++++++++++++++++++++
 drivers/iommu/Kconfig                       |  9 +++++++++
 include/kvm/arm_smmu_v3.h                   | 18 +++++++++++++++++
 4 files changed, 51 insertions(+)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
 create mode 100644 include/kvm/arm_smmu_v3.h

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index d846962e7246..edfd8a11ac90 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -16,6 +16,8 @@ hyp-obj-$(CONFIG_TRACING) += clock.o events.o trace.o
 hyp-obj-$(CONFIG_MODULES) += modules.o
 hyp-obj-y += $(lib-objs)
 
+hyp-obj-$(CONFIG_ARM_SMMU_V3_PKVM) += iommu/arm-smmu-v3.o
+
 $(obj)/hyp.lds: $(src)/hyp.lds.S FORCE
 	$(call if_changed_dep,cpp_lds_S)
 
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
new file mode 100644
index 000000000000..d2a570c9f3ec
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/arm-smmu-v3.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pKVM hyp driver for the Arm SMMUv3
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+#include <asm/kvm_hyp.h>
+#include <kvm/arm_smmu_v3.h>
+#include <nvhe/iommu.h>
+
+size_t __ro_after_init kvm_hyp_arm_smmu_v3_count;
+struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
+
+static int smmu_init(void)
+{
+	return -ENOSYS;
+}
+
+/* Shared with the kernel driver in EL1 */
+struct kvm_iommu_ops smmu_ops = {
+	.init				= smmu_init,
+};
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index b3aa1f5d5321..fea5d6a8b90b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -437,6 +437,15 @@ config TEGRA241_CMDQV
 	  CMDQ-V extension.
 endif
 
+config ARM_SMMU_V3_PKVM
+	bool "ARM SMMUv3 support for protected Virtual Machines"
+	depends on KVM && ARM64
+	help
+	  Enable a SMMUv3 driver in the KVM hypervisor, to protect VMs against
+	  memory accesses from devices owned by the host.
+
+	  Say Y here if you intend to enable KVM in protected mode.
+
 config S390_IOMMU
 	def_bool y if S390 && PCI
 	depends on S390 && PCI
diff --git a/include/kvm/arm_smmu_v3.h b/include/kvm/arm_smmu_v3.h
new file mode 100644
index 000000000000..521028b3ff71
--- /dev/null
+++ b/include/kvm/arm_smmu_v3.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_ARM_SMMU_V3_H
+#define __KVM_ARM_SMMU_V3_H
+
+#include <asm/kvm_asm.h>
+#include <kvm/iommu.h>
+
+struct hyp_arm_smmu_v3_device {
+	struct kvm_hyp_iommu	iommu;
+};
+
+extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
+#define kvm_hyp_arm_smmu_v3_count kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count)
+
+extern struct hyp_arm_smmu_v3_device *kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_smmus);
+#define kvm_hyp_arm_smmu_v3_smmus kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_smmus)
+
+#endif /* __KVM_ARM_SMMU_V3_H */
-- 
2.47.0.338.g60cca15819-goog


