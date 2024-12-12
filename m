Return-Path: <linux-kernel+bounces-443666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C879EFA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A4228DE6E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645FD23EA77;
	Thu, 12 Dec 2024 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ju/kGi7r"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7E23EA78
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026775; cv=none; b=Ms8FJpZ3zWWKblw8Jc7FxUcKYL0X9w1J8CKzvR61DIbN6UUeeeFGn1Ap9RIZAyLkuhMHnFDTUg4ZkLAwebTkrAlyAL5DY72dehRc5otawE5bTL7+DF6kyFVxsD80odfhDgKqX/MJYkvLVT3dEabM3FmFOq2ZcHIsy4p1rW1Ly84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026775; c=relaxed/simple;
	bh=8EtCY8V7X3ycV5JM9rJ11+gKlTambbtPDkoVVyt+M/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uv1sC5kHwX6GgOxlh3yMaUvVPaecOdMWY8bMMprE0EbgU/BGS3+kztR7aJPuUCjtE+yjtv3YiEfpG8QxIWbJHqNS1EB5BnjWbvyAGyxZAKk1/MlAM8WU0YAF96lB5kSnO89Dpei7hHmNGOqcLCCiLL+qGJUg/oZTupIK5UICn7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ju/kGi7r; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385fdff9db5so435771f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026772; x=1734631572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mH2sHDIHNxX5nvm0uCAa4ZRouYkSHZdk/Fqj9806/G4=;
        b=Ju/kGi7rWlLiR5ki6EQqEdgWmNNqdj9c5xVBZ7gsIdKxSbn4orIj93yasl72xcLy58
         ITzLFlO0xR7GiQiy7YGc/MJKQnyfWL8p+B1/IrE4pWW7LiD4WNn6+Ch1Eo8f3Me0PMXo
         CXkSvcavlIeLCvHGe8pVRZvdezzC1fjWdbic0V5PuCdkvHAsQKRVZ8I87nYqkfdXV4vN
         0dzPmn0B9b5jzLo1XlBMBP7+HGkvoy1T1unVlzGf05vccnqkP3C9ep2/Mi3XxK7kzX1M
         wf3XvJCCq90THHuQAmVQ1zAxxUix+T4uvUwOEbFrdZwwHkh6m5EE374L5OpqaEV2PoJp
         pqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026772; x=1734631572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mH2sHDIHNxX5nvm0uCAa4ZRouYkSHZdk/Fqj9806/G4=;
        b=iF3n12miXCz57Za4hSGoG0uxl0KtFcdnqwHBf/NZdo9riSTQvwkDDr3uzGzsl57ra5
         jUhs4tPWcOm5zxMqt2FMU1ahrhnACS1aC5C2jvcrNo6YO4/TM6G/B+pnw3+CUtmTr8z4
         HwRGc35M5DhgQmAMmx+VkQnbDTVV5hSaeJlK6FXAIx+J+HPswG6Kp42x7dnICvoCNlbp
         XKZJqUcs7TcOLpXo6er6mlBts0WYdbT0GmiJQsr+leXH7yYLq8QG6Xa0EbTlN9fcKpnn
         Y/9sECZt2vK1OLaKAK9WRqr+ZW6uiX4egJ9+GE2vIfLKZ/HSmHdUqfpZx87hnEmU/irL
         P+0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBnSIvqtPl0Q2Xu/hB2u0ec17F1aWOokHgolp9Q/5cS6R/xrm49yhRkST4/FHvyIjcMENhL5DQvqbzeSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcD1y1YFLnvsrRa3fDC+3jt+tHPNQWKD4qu7Ru9g33CgatVzsz
	ZqXUOM1cfvFEkG5xk/mkRRNn3039N087wEV9pdaB/SluuWW5e3JrwDHzardh3V/eWDrt8fi74j2
	XkENrWtxuqw==
X-Google-Smtp-Source: AGHT+IHYgcere8DY5zEOS+VqEf+/VNdzFtnyb9Z2He5v/bXnj5TKjXPCmvJhIeCirHysNJOzaHefewW8JahNgA==
X-Received: from wmgg16.prod.google.com ([2002:a05:600d:10:b0:434:a7ee:3c40])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:584b:0:b0:385:df84:8496 with SMTP id ffacd0b85a97d-3864ce4b01fmr5749345f8f.3.1734026771740;
 Thu, 12 Dec 2024 10:06:11 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:06 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-43-smostafa@google.com>
Subject: [RFC PATCH v2 42/58] iommu/arm-smmu-v3-kvm: Add host driver for pKVM
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

Under protected KVM (pKVM), the host does not have access to guest or
hypervisor memory. This means that devices owned by the host must be
isolated by the SMMU, and the hypervisor is in charge of the SMMU.

Introduce the host component that replaces the normal SMMUv3 driver when
pKVM is enabled, and sends configuration and requests to the actual
driver running in the hypervisor (EL2).

Rather than rely on regular driver probe, pKVM directly calls
kvm_arm_smmu_v3_init(), which synchronously finds all SMMUs and hands
them to the hypervisor. If the regular driver is enabled, it will not
find any free SMMU to drive once it gets probed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/Makefile        |  6 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 64 +++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c

diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 515a84f14783..7a182adbebc1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -6,3 +6,9 @@ arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
 arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
 
 obj-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
+
+obj-$(CONFIG_ARM_SMMU_V3_PKVM) += arm_smmu_v3_kvm.o
+ccflags-$(CONFIG_ARM_SMMU_V3_PKVM) += -Iarch/arm64/kvm/
+arm_smmu_v3_kvm-objs-y += arm-smmu-v3-kvm.o
+arm_smmu_v3_kvm-objs-y += arm-smmu-v3-common.o
+arm_smmu_v3_kvm-objs := $(arm_smmu_v3_kvm-objs-y)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
new file mode 100644
index 000000000000..8cea33d15e08
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pKVM host driver for the Arm SMMUv3
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+#include <asm/kvm_mmu.h>
+
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include <kvm/arm_smmu_v3.h>
+
+#include "arm-smmu-v3.h"
+
+extern struct kvm_iommu_ops kvm_nvhe_sym(smmu_ops);
+
+static int kvm_arm_smmu_probe(struct platform_device *pdev)
+{
+	return -ENOSYS;
+}
+
+static void kvm_arm_smmu_remove(struct platform_device *pdev)
+{
+}
+
+static const struct of_device_id arm_smmu_of_match[] = {
+	{ .compatible = "arm,smmu-v3", },
+	{ },
+};
+
+static struct platform_driver kvm_arm_smmu_driver = {
+	.driver = {
+		.name = "kvm-arm-smmu-v3",
+		.of_match_table = arm_smmu_of_match,
+	},
+	.remove = kvm_arm_smmu_remove,
+};
+
+static int kvm_arm_smmu_v3_init_drv(void)
+{
+	return platform_driver_probe(&kvm_arm_smmu_driver, kvm_arm_smmu_probe);
+}
+
+static void kvm_arm_smmu_v3_remove_drv(void)
+{
+	platform_driver_unregister(&kvm_arm_smmu_driver);
+}
+
+struct kvm_iommu_driver kvm_smmu_v3_ops = {
+	.init_driver = kvm_arm_smmu_v3_init_drv,
+	.remove_driver = kvm_arm_smmu_v3_remove_drv,
+};
+
+static int kvm_arm_smmu_v3_register(void)
+{
+	if (!is_protected_kvm_enabled())
+		return 0;
+
+	return kvm_iommu_register_driver(&kvm_smmu_v3_ops,
+					kern_hyp_va(lm_alias(&kvm_nvhe_sym(smmu_ops))));
+};
+
+core_initcall(kvm_arm_smmu_v3_register);
-- 
2.47.0.338.g60cca15819-goog


