Return-Path: <linux-kernel+bounces-443631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7529EFA57
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACD8288774
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993FF22966E;
	Thu, 12 Dec 2024 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/AIpOsG"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34964223E69
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026704; cv=none; b=MEq2pN3C7w0tjsh6ORNsTafezs+UCIoiieENygY/QK9jri0hi8ceIRMPTlHLxJPU7htIquZVpiGRXusZXqWj+FdFXGmuZKjLb4ZddFMfmsLaansmPFiRbypgTpDq/+TXeQnhaEq21BuX0PqyYxOggFQMNYBOSBdRz8rk+eOGc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026704; c=relaxed/simple;
	bh=WMwE/dNVHizFjbVhOCSe7B/7FXE4TRfu8fmUOUXrn38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LR2Q00kLxd8g+YMtXTKQS9oUJaICq2M40L5r8t2Mbtr9OMfQutqc5bUGkt6G6WYJhsejHm9FvZHMdGkZaKZLgS3copdOBpo8BslQWnlkZjL6nzTrBxfAsFHUOFSR1rXl/9kaw65xpiymPG8gI1MpgqUM/Q3Aa5gVzl+e9PxgnnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/AIpOsG; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385d52591d6so534016f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026700; x=1734631500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5tYgfa42Qu0evfptuxAajuASNAN4dnebvy4bJLnTSRk=;
        b=J/AIpOsGWkzARDkfC+HeB6qFlEBgwOmqdWcfdThK0SfDiujnWEebji3vLJbhv09ZeI
         a7MX4p5lNI/FXUYQ2S6fAGun2yAIPcE+UcIg0x6SdfQ/n0av0nRdv0ZZ2pV/1n5xnVOm
         AM2XLPdnhEP8hiY3mLW/rqFsyKhQyICAQp/+VfwxXOoG5JFr+Xomy1vxL/zO2iPRNhzS
         FaH/2ZAcIqqPAISiNP2AJ9S09SciPUnq1JmGEfnnWZ6lgFkmeuQM0rOhfe64w4wEmCg2
         oja7I/1v0vP8L/nvV1Q4D29+1ikFK8kVGBtTuVmLaXTrmelShVP4xrdBCHn8tw4I0wq4
         PJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026700; x=1734631500;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tYgfa42Qu0evfptuxAajuASNAN4dnebvy4bJLnTSRk=;
        b=V+huqm73ngUA+3wGZViqQ0s3ZenpKvI3kPB4r35J/de7qGnbRlNPPJbTT3mCw4sRq8
         Fk0r5DfDZLs7pxohEkzqBHvqzz2aEvzBanD8m0ApSbbNoeeHRdyfCBpLn6RXhAjZvyL9
         BejXFbi17VFsLFX9BJ9Nm7ap2D3xCJIepiiKks2d5aW/hmJxUddUy35pHB2T0JE62Bo5
         6+yepZZ0wBNavghmJhx32S0NolYCdHqXrLk7bVGxxWui4XWEWEiIq9A1CO2WjDYOT+kk
         YCRRsVvLklTvAryVGLXysar0ogr2/idRccPoEeCIziuIkXKVLOHP68gdgH9guOBQD8n6
         jJLw==
X-Forwarded-Encrypted: i=1; AJvYcCXC4SbVC0/xMqeKw2MVzOTs94XWCPd211R96of/cRbmLMpRy77s4BsFwK3zwfPLXEHPvrva/R4aRbxmL4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFVFdV7joVQFBzkcbuPuOoYwG6oIUbGHfYZoAuxfEF7aX7BZSQ
	Rvp7XJPLFp/Nb55lrLMrlrrOggR9iqhyEhqXv4ShEC0VVLjYLhiuZqmtUmBzpB+htr7vk4OghpJ
	VVpDuk0hBdw==
X-Google-Smtp-Source: AGHT+IHXTmXTs9qNjhnollSYp0ZY1MWz75DhgysDcjgOTrRd4ncRnZH4VHrbAicgmJyQ6qHp6MJ5a1TqqJaaWQ==
X-Received: from wmfv18.prod.google.com ([2002:a05:600c:15d2:b0:42c:8a48:f007])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f92:0:b0:386:37f8:450b with SMTP id ffacd0b85a97d-387887c252emr2631173f8f.5.1734026700644;
 Thu, 12 Dec 2024 10:05:00 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:32 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-9-smostafa@google.com>
Subject: [RFC PATCH v2 08/58] iommu/arm-smmu-v3: Move firmware probe to arm-smmu-v3-common
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

Move the FW probe functions to the common source.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-common.c      | 146 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 142 +----------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
 3 files changed, 150 insertions(+), 141 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
index 80ac13b0dc06..04f1e2f1c458 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
@@ -1,11 +1,157 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/acpi.h>
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 
 #include "arm-smmu-v3.h"
 #include "../../dma-iommu.h"
 
+struct arm_smmu_option_prop {
+	u32 opt;
+	const char *prop;
+};
+
+static struct arm_smmu_option_prop arm_smmu_options[] = {
+	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
+	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
+	{ 0, NULL},
+};
+
+static void parse_driver_options(struct arm_smmu_device *smmu)
+{
+	int i = 0;
+
+	do {
+		if (of_property_read_bool(smmu->dev->of_node,
+						arm_smmu_options[i].prop)) {
+			smmu->options |= arm_smmu_options[i].opt;
+			dev_notice(smmu->dev, "option %s\n",
+				arm_smmu_options[i].prop);
+		}
+	} while (arm_smmu_options[++i].opt);
+}
+
+#ifdef CONFIG_ACPI
+#ifdef CONFIG_TEGRA241_CMDQV
+static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
+						struct arm_smmu_device *smmu)
+{
+	const char *uid = kasprintf(GFP_KERNEL, "%u", node->identifier);
+	struct acpi_device *adev;
+
+	/* Look for an NVDA200C node whose _UID matches the SMMU node ID */
+	adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
+	if (adev) {
+		/* Tegra241 CMDQV driver is responsible for put_device() */
+		smmu->impl_dev = &adev->dev;
+		smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
+		dev_info(smmu->dev, "found companion CMDQV device: %s\n",
+			 dev_name(smmu->impl_dev));
+	}
+	kfree(uid);
+}
+#else
+static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
+						struct arm_smmu_device *smmu)
+{
+}
+#endif
+
+static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
+				      struct arm_smmu_device *smmu)
+{
+	struct acpi_iort_smmu_v3 *iort_smmu =
+		(struct acpi_iort_smmu_v3 *)node->node_data;
+
+	switch (iort_smmu->model) {
+	case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
+		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
+		break;
+	case ACPI_IORT_SMMU_V3_HISILICON_HI161X:
+		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
+		break;
+	case ACPI_IORT_SMMU_V3_GENERIC:
+		/*
+		 * Tegra241 implementation stores its SMMU options and impl_dev
+		 * in DSDT. Thus, go through the ACPI tables unconditionally.
+		 */
+		acpi_smmu_dsdt_probe_tegra241_cmdqv(node, smmu);
+		break;
+	}
+
+	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
+	return 0;
+}
+
+static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
+				      struct arm_smmu_device *smmu)
+{
+	struct acpi_iort_smmu_v3 *iort_smmu;
+	struct device *dev = smmu->dev;
+	struct acpi_iort_node *node;
+
+	node = *(struct acpi_iort_node **)dev_get_platdata(dev);
+
+	/* Retrieve SMMUv3 specific data */
+	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+
+	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
+		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
+
+	switch (FIELD_GET(ACPI_IORT_SMMU_V3_HTTU_OVERRIDE, iort_smmu->flags)) {
+	case IDR0_HTTU_ACCESS_DIRTY:
+		smmu->features |= ARM_SMMU_FEAT_HD;
+		fallthrough;
+	case IDR0_HTTU_ACCESS:
+		smmu->features |= ARM_SMMU_FEAT_HA;
+	}
+
+	return acpi_smmu_iort_probe_model(node, smmu);
+}
+#else
+static inline int arm_smmu_device_acpi_probe(struct platform_device *pdev,
+					     struct arm_smmu_device *smmu)
+{
+	return -ENODEV;
+}
+#endif
+
+static int arm_smmu_device_dt_probe(struct platform_device *pdev,
+				    struct arm_smmu_device *smmu)
+{
+	struct device *dev = &pdev->dev;
+	u32 cells;
+	int ret = -EINVAL;
+
+	if (of_property_read_u32(dev->of_node, "#iommu-cells", &cells))
+		dev_err(dev, "missing #iommu-cells property\n");
+	else if (cells != 1)
+		dev_err(dev, "invalid #iommu-cells value (%d)\n", cells);
+	else
+		ret = 0;
+
+	parse_driver_options(smmu);
+
+	if (of_dma_is_coherent(dev->of_node))
+		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
+
+	return ret;
+}
+
+int arm_smmu_fw_probe(struct platform_device *pdev,
+		      struct arm_smmu_device *smmu)
+{
+	if (smmu->dev->of_node)
+		return arm_smmu_device_dt_probe(pdev, smmu);
+	else
+		return arm_smmu_device_acpi_probe(pdev, smmu);
+}
+
 #define IIDR_IMPLEMENTER_ARM		0x43b
 #define IIDR_PRODUCTID_ARM_MMU_600	0x483
 #define IIDR_PRODUCTID_ARM_MMU_700	0x487
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index cfee7f9b5afc..91f64416900b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -9,7 +9,6 @@
  * This driver is powered by bad coffee and bombay mix.
  */
 
-#include <linux/acpi.h>
 #include <linux/acpi_iort.h>
 #include <linux/bitops.h>
 #include <linux/crash_dump.h>
@@ -19,9 +18,6 @@
 #include <linux/io-pgtable.h>
 #include <linux/module.h>
 #include <linux/msi.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
 #include <kunit/visibility.h>
@@ -67,38 +63,13 @@ static phys_addr_t arm_smmu_msi_cfg[ARM_SMMU_MAX_MSIS][3] = {
 	},
 };
 
-struct arm_smmu_option_prop {
-	u32 opt;
-	const char *prop;
-};
-
 DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
 DEFINE_MUTEX(arm_smmu_asid_lock);
 
-static struct arm_smmu_option_prop arm_smmu_options[] = {
-	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
-	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
-	{ 0, NULL},
-};
-
 static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 				    struct arm_smmu_device *smmu, u32 flags);
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
-static void parse_driver_options(struct arm_smmu_device *smmu)
-{
-	int i = 0;
-
-	do {
-		if (of_property_read_bool(smmu->dev->of_node,
-						arm_smmu_options[i].prop)) {
-			smmu->options |= arm_smmu_options[i].opt;
-			dev_notice(smmu->dev, "option %s\n",
-				arm_smmu_options[i].prop);
-		}
-	} while (arm_smmu_options[++i].opt);
-}
-
 /* Low-level queue manipulation functions */
 static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
 {
@@ -3828,113 +3799,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-#ifdef CONFIG_TEGRA241_CMDQV
-static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
-						struct arm_smmu_device *smmu)
-{
-	const char *uid = kasprintf(GFP_KERNEL, "%u", node->identifier);
-	struct acpi_device *adev;
-
-	/* Look for an NVDA200C node whose _UID matches the SMMU node ID */
-	adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
-	if (adev) {
-		/* Tegra241 CMDQV driver is responsible for put_device() */
-		smmu->impl_dev = &adev->dev;
-		smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
-		dev_info(smmu->dev, "found companion CMDQV device: %s\n",
-			 dev_name(smmu->impl_dev));
-	}
-	kfree(uid);
-}
-#else
-static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
-						struct arm_smmu_device *smmu)
-{
-}
-#endif
-
-static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
-				      struct arm_smmu_device *smmu)
-{
-	struct acpi_iort_smmu_v3 *iort_smmu =
-		(struct acpi_iort_smmu_v3 *)node->node_data;
-
-	switch (iort_smmu->model) {
-	case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
-		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
-		break;
-	case ACPI_IORT_SMMU_V3_HISILICON_HI161X:
-		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
-		break;
-	case ACPI_IORT_SMMU_V3_GENERIC:
-		/*
-		 * Tegra241 implementation stores its SMMU options and impl_dev
-		 * in DSDT. Thus, go through the ACPI tables unconditionally.
-		 */
-		acpi_smmu_dsdt_probe_tegra241_cmdqv(node, smmu);
-		break;
-	}
-
-	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
-	return 0;
-}
-
-static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
-				      struct arm_smmu_device *smmu)
-{
-	struct acpi_iort_smmu_v3 *iort_smmu;
-	struct device *dev = smmu->dev;
-	struct acpi_iort_node *node;
-
-	node = *(struct acpi_iort_node **)dev_get_platdata(dev);
-
-	/* Retrieve SMMUv3 specific data */
-	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
-
-	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
-		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
-
-	switch (FIELD_GET(ACPI_IORT_SMMU_V3_HTTU_OVERRIDE, iort_smmu->flags)) {
-	case IDR0_HTTU_ACCESS_DIRTY:
-		smmu->features |= ARM_SMMU_FEAT_HD;
-		fallthrough;
-	case IDR0_HTTU_ACCESS:
-		smmu->features |= ARM_SMMU_FEAT_HA;
-	}
-
-	return acpi_smmu_iort_probe_model(node, smmu);
-}
-#else
-static inline int arm_smmu_device_acpi_probe(struct platform_device *pdev,
-					     struct arm_smmu_device *smmu)
-{
-	return -ENODEV;
-}
-#endif
-
-static int arm_smmu_device_dt_probe(struct platform_device *pdev,
-				    struct arm_smmu_device *smmu)
-{
-	struct device *dev = &pdev->dev;
-	u32 cells;
-	int ret = -EINVAL;
-
-	if (of_property_read_u32(dev->of_node, "#iommu-cells", &cells))
-		dev_err(dev, "missing #iommu-cells property\n");
-	else if (cells != 1)
-		dev_err(dev, "invalid #iommu-cells value (%d)\n", cells);
-	else
-		ret = 0;
-
-	parse_driver_options(smmu);
-
-	if (of_dma_is_coherent(dev->of_node))
-		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
-
-	return ret;
-}
-
 static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
 {
 	if (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY)
@@ -4030,11 +3894,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	smmu->dev = dev;
 
-	if (dev->of_node) {
-		ret = arm_smmu_device_dt_probe(pdev, smmu);
-	} else {
-		ret = arm_smmu_device_acpi_probe(pdev, smmu);
-	}
+	ret = arm_smmu_fw_probe(pdev, smmu);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1a3452554ca8..2d658f15973a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -334,6 +334,9 @@ int arm_smmu_of_xlate(struct device *dev, const struct of_phandle_args *args);
 void arm_smmu_get_resv_regions(struct device *dev,
 			       struct list_head *head);
 
+struct platform_device;
+int arm_smmu_fw_probe(struct platform_device *pdev,
+		      struct arm_smmu_device *smmu);
 int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu);
 int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 			    struct arm_smmu_queue *q,
-- 
2.47.0.338.g60cca15819-goog


