Return-Path: <linux-kernel+bounces-443629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862D09EFA64
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A202218854A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABDB2288D2;
	Thu, 12 Dec 2024 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9wVLKsi"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0422540F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026700; cv=none; b=TqevYJw8OZmpLm8zPn0Ls/+KnhA7dP3froBQaj7uQVXO4c5j5Ga4irRDylrNCqeiLpxc+ogKGqGUxE1y5gcfaOmEtnCcV4UvojyqP0YWTtpKRXsmvHU2RXCoaFD389Epe5PUYqmXgV/DDBxlaqoiW6lB9XI7/+svXjB5qdSu1wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026700; c=relaxed/simple;
	bh=xUlIBhmSp+ZhASDX+TgCLIU26rEDHhUaLZGF41HT1YA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IoQkeCBejclJ5hEUvtHgdYhisYJvw7uvcuLoCOTLn5nRy6wspdeC1YLb1qIWfC9ZguovS7pIoxZg7vYCmJx6ar49X0dva+gl4uA+i4EyL1UEtw2RqfpYiR8CL3kZR1X++5sCVVYHiAjILieHnU7kmNoC8RRROMeHZZ/fUlImgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A9wVLKsi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4361ecebc5bso5648035e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026696; x=1734631496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XUvxXRJ1+y/fkPaxEcJoZOef6jFXTK4/g96LVt9tKU4=;
        b=A9wVLKsiva6aIsvbmUyIxUJgzpUfjVEFiVT4hm/r5RR4LUlFdz2ctJXFe3ZS7TP7qQ
         oxyYi5gpX7dGmeh8fzp9bKWOCULTmC0XbS+733O0H5SFprbs6viUth2+Jc3ao5dedNzV
         kkRJZVhwa2S106+JoIkObiEmqa8By3YyItHiELSKJDhSZjybmCWJ5hFs64XUyjG8sHUF
         L2/3r6fEXuOlR0Q2XZzXo3pBuhpJZJXEKdOE0p+YiR0iOZG2TA1x1HWpax/j6GJmc3qF
         k1XJurgYh/b/PCk+HLRTzzB15SHPjVNhLuXur4rBWGtKXti1Xog2MqFcsiTVSKdiBHVM
         d2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026696; x=1734631496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUvxXRJ1+y/fkPaxEcJoZOef6jFXTK4/g96LVt9tKU4=;
        b=RQaOB2Qe39n/KaLvxsVCaEyZkEn2JMkZ77XuwwpI5s4I8v3dVgXLtZvbzKBGBjXNxZ
         /yvs3ol+xQwlZb5qTVomVFbrZ3voYmo/FMHzkMSozumRZvQfpcSXsxdYzN2pVzxpFveO
         3fC8sbqqBVv2H/dAoTSupUpcU9QgjvX+zus0PrwD9CiVZVDXPS5fyD7a/PODQdKE8Hv7
         Pa4HLKChtz5JHrwDbQw4rNkG6mqL+V0N7RaK75Z4q3yic/seK/SvRzWHNYwHvR5wWiq/
         muKVOSwi2p6b1UtRJwFXvnvC7Tf4vjEzsOXtvt9WEWiAxUspZyIGtmYYnCVO9itEBwrL
         9ifA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ym/3PcLRp4gXKvN9wAmE1CXtcaJaFEcpi0fvEDvahm3EYZGo4Ya9LAXmEfBjshWX189QvyF8tIuhR18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrxh85Ji+80n3lELEuOKqXmw0yi3Sou/Vxpl4hWJNIPYcP/y+
	pl21VlZ+qFqDzSlzJLRGNjWY17STaZqzFa05AMw7YiIfw6zv94fqp56+Opd31JwPKwDO3iJaxfw
	ze/aCrO28SQ==
X-Google-Smtp-Source: AGHT+IFzPx9Qlm2oSiOOqD2lEb+aD+ViZ+vxvuCF+LiMJIDKi+Rvut8RxtYpYi7M5NjOo9xZIBfzoQAKIPzsAQ==
X-Received: from wmik26.prod.google.com ([2002:a7b:c41a:0:b0:434:f801:bf67])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4450:b0:434:a7e7:a1ca with SMTP id 5b1f17b1804b1-4361c3e1cfcmr58211195e9.20.1734026696232;
 Thu, 12 Dec 2024 10:04:56 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:30 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-7-smostafa@google.com>
Subject: [RFC PATCH v2 06/58] iommu/arm-smmu-v3: Move some functions to arm-smmu-v3-common.c
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

Move functions that can be shared between normal and KVM drivers to
arm-smmu-v3-common.c

Only straightforward moves here. More subtle factoring will be done in
then next patches.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 .../arm/arm-smmu-v3/arm-smmu-v3-common.c      | 365 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 363 -----------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  11 +
 4 files changed, 377 insertions(+), 363 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c

diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index dc98c88b48c8..515a84f14783 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-y := arm-smmu-v3.o
+arm_smmu_v3-y += arm-smmu-v3-common.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
 arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
new file mode 100644
index 000000000000..cfd5ba69e67e
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
+#include <linux/pci.h>
+
+#include "arm-smmu-v3.h"
+#include "../../dma-iommu.h"
+
+#define IIDR_IMPLEMENTER_ARM		0x43b
+#define IIDR_PRODUCTID_ARM_MMU_600	0x483
+#define IIDR_PRODUCTID_ARM_MMU_700	0x487
+
+static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+	unsigned int implementer, productid, variant, revision;
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IIDR);
+	implementer = FIELD_GET(IIDR_IMPLEMENTER, reg);
+	productid = FIELD_GET(IIDR_PRODUCTID, reg);
+	variant = FIELD_GET(IIDR_VARIANT, reg);
+	revision = FIELD_GET(IIDR_REVISION, reg);
+
+	switch (implementer) {
+	case IIDR_IMPLEMENTER_ARM:
+		switch (productid) {
+		case IIDR_PRODUCTID_ARM_MMU_600:
+			/* Arm erratum 1076982 */
+			if (variant == 0 && revision <= 2)
+				smmu->features &= ~ARM_SMMU_FEAT_SEV;
+			/* Arm erratum 1209401 */
+			if (variant < 2)
+				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
+			break;
+		case IIDR_PRODUCTID_ARM_MMU_700:
+			/* Arm erratum 2812531 */
+			smmu->features &= ~ARM_SMMU_FEAT_BTM;
+			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
+			/* Arm errata 2268618, 2812531 */
+			smmu->features &= ~ARM_SMMU_FEAT_NESTING;
+			break;
+		}
+		break;
+	}
+}
+
+static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
+{
+	u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD);
+	u32 hw_features = 0;
+
+	switch (FIELD_GET(IDR0_HTTU, reg)) {
+	case IDR0_HTTU_ACCESS_DIRTY:
+		hw_features |= ARM_SMMU_FEAT_HD;
+		fallthrough;
+	case IDR0_HTTU_ACCESS:
+		hw_features |= ARM_SMMU_FEAT_HA;
+	}
+
+	if (smmu->dev->of_node)
+		smmu->features |= hw_features;
+	else if (hw_features != fw_features)
+		/* ACPI IORT sets the HTTU bits */
+		dev_warn(smmu->dev,
+			 "IDR0.HTTU features(0x%x) overridden by FW configuration (0x%x)\n",
+			  hw_features, fw_features);
+}
+
+int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
+
+	/* IDR0 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
+
+	/* 2-level structures */
+	if (FIELD_GET(IDR0_ST_LVL, reg) == IDR0_ST_LVL_2LVL)
+		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
+
+	if (reg & IDR0_CD2L)
+		smmu->features |= ARM_SMMU_FEAT_2_LVL_CDTAB;
+
+	/*
+	 * Translation table endianness.
+	 * We currently require the same endianness as the CPU, but this
+	 * could be changed later by adding a new IO_PGTABLE_QUIRK.
+	 */
+	switch (FIELD_GET(IDR0_TTENDIAN, reg)) {
+	case IDR0_TTENDIAN_MIXED:
+		smmu->features |= ARM_SMMU_FEAT_TT_LE | ARM_SMMU_FEAT_TT_BE;
+		break;
+#ifdef __BIG_ENDIAN
+	case IDR0_TTENDIAN_BE:
+		smmu->features |= ARM_SMMU_FEAT_TT_BE;
+		break;
+#else
+	case IDR0_TTENDIAN_LE:
+		smmu->features |= ARM_SMMU_FEAT_TT_LE;
+		break;
+#endif
+	default:
+		dev_err(smmu->dev, "unknown/unsupported TT endianness!\n");
+		return -ENXIO;
+	}
+
+	/* Boolean feature flags */
+	if (IS_ENABLED(CONFIG_PCI_PRI) && reg & IDR0_PRI)
+		smmu->features |= ARM_SMMU_FEAT_PRI;
+
+	if (IS_ENABLED(CONFIG_PCI_ATS) && reg & IDR0_ATS)
+		smmu->features |= ARM_SMMU_FEAT_ATS;
+
+	if (reg & IDR0_SEV)
+		smmu->features |= ARM_SMMU_FEAT_SEV;
+
+	if (reg & IDR0_MSI) {
+		smmu->features |= ARM_SMMU_FEAT_MSI;
+		if (coherent)
+			smmu->options |= ARM_SMMU_OPT_MSIPOLL;
+	}
+
+	if (reg & IDR0_HYP) {
+		smmu->features |= ARM_SMMU_FEAT_HYP;
+		if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+			smmu->features |= ARM_SMMU_FEAT_E2H;
+	}
+
+	arm_smmu_get_httu(smmu, reg);
+
+	/*
+	 * The coherency feature as set by FW is used in preference to the ID
+	 * register, but warn on mismatch.
+	 */
+	if (!!(reg & IDR0_COHACC) != coherent)
+		dev_warn(smmu->dev, "IDR0.COHACC overridden by FW configuration (%s)\n",
+			 coherent ? "true" : "false");
+
+	switch (FIELD_GET(IDR0_STALL_MODEL, reg)) {
+	case IDR0_STALL_MODEL_FORCE:
+		smmu->features |= ARM_SMMU_FEAT_STALL_FORCE;
+		fallthrough;
+	case IDR0_STALL_MODEL_STALL:
+		smmu->features |= ARM_SMMU_FEAT_STALLS;
+	}
+
+	if (reg & IDR0_S1P)
+		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
+
+	if (reg & IDR0_S2P)
+		smmu->features |= ARM_SMMU_FEAT_TRANS_S2;
+
+	if (!(reg & (IDR0_S1P | IDR0_S2P))) {
+		dev_err(smmu->dev, "no translation support!\n");
+		return -ENXIO;
+	}
+
+	/* We only support the AArch64 table format at present */
+	switch (FIELD_GET(IDR0_TTF, reg)) {
+	case IDR0_TTF_AARCH32_64:
+		smmu->ias = 40;
+		fallthrough;
+	case IDR0_TTF_AARCH64:
+		break;
+	default:
+		dev_err(smmu->dev, "AArch64 table format not supported!\n");
+		return -ENXIO;
+	}
+
+	/* ASID/VMID sizes */
+	smmu->asid_bits = reg & IDR0_ASID16 ? 16 : 8;
+	smmu->vmid_bits = reg & IDR0_VMID16 ? 16 : 8;
+
+	/* IDR1 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
+	if (reg & (IDR1_TABLES_PRESET | IDR1_QUEUES_PRESET | IDR1_REL)) {
+		dev_err(smmu->dev, "embedded implementation not supported\n");
+		return -ENXIO;
+	}
+
+	if (reg & IDR1_ATTR_TYPES_OVR)
+		smmu->features |= ARM_SMMU_FEAT_ATTR_TYPES_OVR;
+
+	/* Queue sizes, capped to ensure natural alignment */
+	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
+					     FIELD_GET(IDR1_CMDQS, reg));
+	if (smmu->cmdq.q.llq.max_n_shift <= ilog2(CMDQ_BATCH_ENTRIES)) {
+		/*
+		 * We don't support splitting up batches, so one batch of
+		 * commands plus an extra sync needs to fit inside the command
+		 * queue. There's also no way we can handle the weird alignment
+		 * restrictions on the base pointer for a unit-length queue.
+		 */
+		dev_err(smmu->dev, "command queue size <= %d entries not supported\n",
+			CMDQ_BATCH_ENTRIES);
+		return -ENXIO;
+	}
+
+	smmu->evtq.q.llq.max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT,
+					     FIELD_GET(IDR1_EVTQS, reg));
+	smmu->priq.q.llq.max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT,
+					     FIELD_GET(IDR1_PRIQS, reg));
+
+	/* SID/SSID sizes */
+	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
+	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
+	smmu->iommu.max_pasids = 1UL << smmu->ssid_bits;
+
+	/*
+	 * If the SMMU supports fewer bits than would fill a single L2 stream
+	 * table, use a linear table instead.
+	 */
+	if (smmu->sid_bits <= STRTAB_SPLIT)
+		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+
+	/* IDR3 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
+	if (FIELD_GET(IDR3_RIL, reg))
+		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
+
+	/* IDR5 */
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
+
+	/* Maximum number of outstanding stalls */
+	smmu->evtq.max_stalls = FIELD_GET(IDR5_STALL_MAX, reg);
+
+	/* Page sizes */
+	if (reg & IDR5_GRAN64K)
+		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
+	if (reg & IDR5_GRAN16K)
+		smmu->pgsize_bitmap |= SZ_16K | SZ_32M;
+	if (reg & IDR5_GRAN4K)
+		smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
+
+	/* Input address size */
+	if (FIELD_GET(IDR5_VAX, reg) == IDR5_VAX_52_BIT)
+		smmu->features |= ARM_SMMU_FEAT_VAX;
+
+	/* Output address size */
+	switch (FIELD_GET(IDR5_OAS, reg)) {
+	case IDR5_OAS_32_BIT:
+		smmu->oas = 32;
+		break;
+	case IDR5_OAS_36_BIT:
+		smmu->oas = 36;
+		break;
+	case IDR5_OAS_40_BIT:
+		smmu->oas = 40;
+		break;
+	case IDR5_OAS_42_BIT:
+		smmu->oas = 42;
+		break;
+	case IDR5_OAS_44_BIT:
+		smmu->oas = 44;
+		break;
+	case IDR5_OAS_52_BIT:
+		smmu->oas = 52;
+		smmu->pgsize_bitmap |= 1ULL << 42; /* 4TB */
+		break;
+	default:
+		dev_info(smmu->dev,
+			"unknown output address size. Truncating to 48-bit\n");
+		fallthrough;
+	case IDR5_OAS_48_BIT:
+		smmu->oas = 48;
+	}
+
+	/* Set the DMA mask for our table walker */
+	if (dma_set_mask_and_coherent(smmu->dev, DMA_BIT_MASK(smmu->oas)))
+		dev_warn(smmu->dev,
+			 "failed to set DMA mask for table walker\n");
+
+	smmu->ias = max(smmu->ias, smmu->oas);
+
+	if ((smmu->features & ARM_SMMU_FEAT_TRANS_S1) &&
+	    (smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+		smmu->features |= ARM_SMMU_FEAT_NESTING;
+
+	arm_smmu_device_iidr_probe(smmu);
+
+	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
+		 smmu->ias, smmu->oas, smmu->features);
+	return 0;
+}
+
+int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
+			    unsigned int reg_off, unsigned int ack_off)
+{
+	u32 reg;
+
+	writel_relaxed(val, smmu->base + reg_off);
+	return readl_relaxed_poll_timeout(smmu->base + ack_off, reg, reg == val,
+					  1, ARM_SMMU_POLL_TIMEOUT_US);
+}
+
+/* GBPA is "special" */
+int arm_smmu_update_gbpa(struct arm_smmu_device *smmu, u32 set, u32 clr)
+{
+	int ret;
+	u32 reg, __iomem *gbpa = smmu->base + ARM_SMMU_GBPA;
+
+	ret = readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
+					 1, ARM_SMMU_POLL_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	reg &= ~clr;
+	reg |= set;
+	writel_relaxed(reg | GBPA_UPDATE, gbpa);
+	ret = readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
+					 1, ARM_SMMU_POLL_TIMEOUT_US);
+
+	if (ret)
+		dev_err(smmu->dev, "GBPA not responding to update\n");
+	return ret;
+}
+
+int arm_smmu_device_disable(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
+	if (ret)
+		dev_err(smmu->dev, "failed to clear cr0\n");
+
+	return ret;
+}
+
+struct iommu_group *arm_smmu_device_group(struct device *dev)
+{
+	struct iommu_group *group;
+
+	/*
+	 * We don't support devices sharing stream IDs other than PCI RID
+	pick f473c7c1b189 fixup drv splt * aliases, since the necessary ID-to-device lookup becomes rather
+	 * impractical given a potential sparse 32-bit stream ID space.
+	 */
+	if (dev_is_pci(dev))
+		group = pci_device_group(dev);
+	else
+		group = generic_device_group(dev);
+
+	return group;
+}
+
+int arm_smmu_of_xlate(struct device *dev, const struct of_phandle_args *args)
+{
+	return iommu_fwspec_add_ids(dev, args->args, 1);
+}
+
+void arm_smmu_get_resv_regions(struct device *dev,
+			       struct list_head *head)
+{
+	struct iommu_resv_region *region;
+	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+
+	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
+					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
+	if (!region)
+		return;
+
+	list_add_tail(&region->list, head);
+
+	iommu_dma_get_resv_regions(dev, head);
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 702863c94f91..8741b8f57a8d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -17,13 +17,11 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
-#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
-#include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
 #include <kunit/visibility.h>
@@ -1914,8 +1912,6 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
-
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 {
 	u32 gerror, gerrorn, active;
@@ -3361,23 +3357,6 @@ static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 }
 
-static struct iommu_group *arm_smmu_device_group(struct device *dev)
-{
-	struct iommu_group *group;
-
-	/*
-	 * We don't support devices sharing stream IDs other than PCI RID
-	 * aliases, since the necessary ID-to-device lookup becomes rather
-	 * impractical given a potential sparse 32-bit stream ID space.
-	 */
-	if (dev_is_pci(dev))
-		group = pci_device_group(dev);
-	else
-		group = generic_device_group(dev);
-
-	return group;
-}
-
 static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -3393,28 +3372,6 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev,
-			     const struct of_phandle_args *args)
-{
-	return iommu_fwspec_add_ids(dev, args->args, 1);
-}
-
-static void arm_smmu_get_resv_regions(struct device *dev,
-				      struct list_head *head)
-{
-	struct iommu_resv_region *region;
-	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
-
-	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
-	if (!region)
-		return;
-
-	list_add_tail(&region->list, head);
-
-	iommu_dma_get_resv_regions(dev, head);
-}
-
 static int arm_smmu_dev_enable_feature(struct device *dev,
 				       enum iommu_dev_features feat)
 {
@@ -3711,38 +3668,6 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-static int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
-				   unsigned int reg_off, unsigned int ack_off)
-{
-	u32 reg;
-
-	writel_relaxed(val, smmu->base + reg_off);
-	return readl_relaxed_poll_timeout(smmu->base + ack_off, reg, reg == val,
-					  1, ARM_SMMU_POLL_TIMEOUT_US);
-}
-
-/* GBPA is "special" */
-static int arm_smmu_update_gbpa(struct arm_smmu_device *smmu, u32 set, u32 clr)
-{
-	int ret;
-	u32 reg, __iomem *gbpa = smmu->base + ARM_SMMU_GBPA;
-
-	ret = readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
-					 1, ARM_SMMU_POLL_TIMEOUT_US);
-	if (ret)
-		return ret;
-
-	reg &= ~clr;
-	reg |= set;
-	writel_relaxed(reg | GBPA_UPDATE, gbpa);
-	ret = readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
-					 1, ARM_SMMU_POLL_TIMEOUT_US);
-
-	if (ret)
-		dev_err(smmu->dev, "GBPA not responding to update\n");
-	return ret;
-}
-
 static void arm_smmu_free_msis(void *data)
 {
 	struct device *dev = data;
@@ -3889,17 +3814,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
-{
-	int ret;
-
-	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
-	if (ret)
-		dev_err(smmu->dev, "failed to clear cr0\n");
-
-	return ret;
-}
-
 static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 {
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
@@ -4057,283 +3971,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-#define IIDR_IMPLEMENTER_ARM		0x43b
-#define IIDR_PRODUCTID_ARM_MMU_600	0x483
-#define IIDR_PRODUCTID_ARM_MMU_700	0x487
-
-static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
-{
-	u32 reg;
-	unsigned int implementer, productid, variant, revision;
-
-	reg = readl_relaxed(smmu->base + ARM_SMMU_IIDR);
-	implementer = FIELD_GET(IIDR_IMPLEMENTER, reg);
-	productid = FIELD_GET(IIDR_PRODUCTID, reg);
-	variant = FIELD_GET(IIDR_VARIANT, reg);
-	revision = FIELD_GET(IIDR_REVISION, reg);
-
-	switch (implementer) {
-	case IIDR_IMPLEMENTER_ARM:
-		switch (productid) {
-		case IIDR_PRODUCTID_ARM_MMU_600:
-			/* Arm erratum 1076982 */
-			if (variant == 0 && revision <= 2)
-				smmu->features &= ~ARM_SMMU_FEAT_SEV;
-			/* Arm erratum 1209401 */
-			if (variant < 2)
-				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
-			break;
-		case IIDR_PRODUCTID_ARM_MMU_700:
-			/* Arm erratum 2812531 */
-			smmu->features &= ~ARM_SMMU_FEAT_BTM;
-			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
-			/* Arm errata 2268618, 2812531 */
-			smmu->features &= ~ARM_SMMU_FEAT_NESTING;
-			break;
-		}
-		break;
-	}
-}
-
-static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
-{
-	u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD);
-	u32 hw_features = 0;
-
-	switch (FIELD_GET(IDR0_HTTU, reg)) {
-	case IDR0_HTTU_ACCESS_DIRTY:
-		hw_features |= ARM_SMMU_FEAT_HD;
-		fallthrough;
-	case IDR0_HTTU_ACCESS:
-		hw_features |= ARM_SMMU_FEAT_HA;
-	}
-
-	if (smmu->dev->of_node)
-		smmu->features |= hw_features;
-	else if (hw_features != fw_features)
-		/* ACPI IORT sets the HTTU bits */
-		dev_warn(smmu->dev,
-			 "IDR0.HTTU features(0x%x) overridden by FW configuration (0x%x)\n",
-			  hw_features, fw_features);
-}
-
-static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
-{
-	u32 reg;
-	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
-
-	/* IDR0 */
-	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
-
-	/* 2-level structures */
-	if (FIELD_GET(IDR0_ST_LVL, reg) == IDR0_ST_LVL_2LVL)
-		smmu->features |= ARM_SMMU_FEAT_2_LVL_STRTAB;
-
-	if (reg & IDR0_CD2L)
-		smmu->features |= ARM_SMMU_FEAT_2_LVL_CDTAB;
-
-	/*
-	 * Translation table endianness.
-	 * We currently require the same endianness as the CPU, but this
-	 * could be changed later by adding a new IO_PGTABLE_QUIRK.
-	 */
-	switch (FIELD_GET(IDR0_TTENDIAN, reg)) {
-	case IDR0_TTENDIAN_MIXED:
-		smmu->features |= ARM_SMMU_FEAT_TT_LE | ARM_SMMU_FEAT_TT_BE;
-		break;
-#ifdef __BIG_ENDIAN
-	case IDR0_TTENDIAN_BE:
-		smmu->features |= ARM_SMMU_FEAT_TT_BE;
-		break;
-#else
-	case IDR0_TTENDIAN_LE:
-		smmu->features |= ARM_SMMU_FEAT_TT_LE;
-		break;
-#endif
-	default:
-		dev_err(smmu->dev, "unknown/unsupported TT endianness!\n");
-		return -ENXIO;
-	}
-
-	/* Boolean feature flags */
-	if (IS_ENABLED(CONFIG_PCI_PRI) && reg & IDR0_PRI)
-		smmu->features |= ARM_SMMU_FEAT_PRI;
-
-	if (IS_ENABLED(CONFIG_PCI_ATS) && reg & IDR0_ATS)
-		smmu->features |= ARM_SMMU_FEAT_ATS;
-
-	if (reg & IDR0_SEV)
-		smmu->features |= ARM_SMMU_FEAT_SEV;
-
-	if (reg & IDR0_MSI) {
-		smmu->features |= ARM_SMMU_FEAT_MSI;
-		if (coherent)
-			smmu->options |= ARM_SMMU_OPT_MSIPOLL;
-	}
-
-	if (reg & IDR0_HYP) {
-		smmu->features |= ARM_SMMU_FEAT_HYP;
-		if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
-			smmu->features |= ARM_SMMU_FEAT_E2H;
-	}
-
-	arm_smmu_get_httu(smmu, reg);
-
-	/*
-	 * The coherency feature as set by FW is used in preference to the ID
-	 * register, but warn on mismatch.
-	 */
-	if (!!(reg & IDR0_COHACC) != coherent)
-		dev_warn(smmu->dev, "IDR0.COHACC overridden by FW configuration (%s)\n",
-			 coherent ? "true" : "false");
-
-	switch (FIELD_GET(IDR0_STALL_MODEL, reg)) {
-	case IDR0_STALL_MODEL_FORCE:
-		smmu->features |= ARM_SMMU_FEAT_STALL_FORCE;
-		fallthrough;
-	case IDR0_STALL_MODEL_STALL:
-		smmu->features |= ARM_SMMU_FEAT_STALLS;
-	}
-
-	if (reg & IDR0_S1P)
-		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
-
-	if (reg & IDR0_S2P)
-		smmu->features |= ARM_SMMU_FEAT_TRANS_S2;
-
-	if (!(reg & (IDR0_S1P | IDR0_S2P))) {
-		dev_err(smmu->dev, "no translation support!\n");
-		return -ENXIO;
-	}
-
-	/* We only support the AArch64 table format at present */
-	switch (FIELD_GET(IDR0_TTF, reg)) {
-	case IDR0_TTF_AARCH32_64:
-		smmu->ias = 40;
-		fallthrough;
-	case IDR0_TTF_AARCH64:
-		break;
-	default:
-		dev_err(smmu->dev, "AArch64 table format not supported!\n");
-		return -ENXIO;
-	}
-
-	/* ASID/VMID sizes */
-	smmu->asid_bits = reg & IDR0_ASID16 ? 16 : 8;
-	smmu->vmid_bits = reg & IDR0_VMID16 ? 16 : 8;
-
-	/* IDR1 */
-	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
-	if (reg & (IDR1_TABLES_PRESET | IDR1_QUEUES_PRESET | IDR1_REL)) {
-		dev_err(smmu->dev, "embedded implementation not supported\n");
-		return -ENXIO;
-	}
-
-	if (reg & IDR1_ATTR_TYPES_OVR)
-		smmu->features |= ARM_SMMU_FEAT_ATTR_TYPES_OVR;
-
-	/* Queue sizes, capped to ensure natural alignment */
-	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_CMDQS, reg));
-	if (smmu->cmdq.q.llq.max_n_shift <= ilog2(CMDQ_BATCH_ENTRIES)) {
-		/*
-		 * We don't support splitting up batches, so one batch of
-		 * commands plus an extra sync needs to fit inside the command
-		 * queue. There's also no way we can handle the weird alignment
-		 * restrictions on the base pointer for a unit-length queue.
-		 */
-		dev_err(smmu->dev, "command queue size <= %d entries not supported\n",
-			CMDQ_BATCH_ENTRIES);
-		return -ENXIO;
-	}
-
-	smmu->evtq.q.llq.max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_EVTQS, reg));
-	smmu->priq.q.llq.max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_PRIQS, reg));
-
-	/* SID/SSID sizes */
-	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
-	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
-	smmu->iommu.max_pasids = 1UL << smmu->ssid_bits;
-
-	/*
-	 * If the SMMU supports fewer bits than would fill a single L2 stream
-	 * table, use a linear table instead.
-	 */
-	if (smmu->sid_bits <= STRTAB_SPLIT)
-		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
-
-	/* IDR3 */
-	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
-	if (FIELD_GET(IDR3_RIL, reg))
-		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
-
-	/* IDR5 */
-	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
-
-	/* Maximum number of outstanding stalls */
-	smmu->evtq.max_stalls = FIELD_GET(IDR5_STALL_MAX, reg);
-
-	/* Page sizes */
-	if (reg & IDR5_GRAN64K)
-		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
-	if (reg & IDR5_GRAN16K)
-		smmu->pgsize_bitmap |= SZ_16K | SZ_32M;
-	if (reg & IDR5_GRAN4K)
-		smmu->pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
-
-	/* Input address size */
-	if (FIELD_GET(IDR5_VAX, reg) == IDR5_VAX_52_BIT)
-		smmu->features |= ARM_SMMU_FEAT_VAX;
-
-	/* Output address size */
-	switch (FIELD_GET(IDR5_OAS, reg)) {
-	case IDR5_OAS_32_BIT:
-		smmu->oas = 32;
-		break;
-	case IDR5_OAS_36_BIT:
-		smmu->oas = 36;
-		break;
-	case IDR5_OAS_40_BIT:
-		smmu->oas = 40;
-		break;
-	case IDR5_OAS_42_BIT:
-		smmu->oas = 42;
-		break;
-	case IDR5_OAS_44_BIT:
-		smmu->oas = 44;
-		break;
-	case IDR5_OAS_52_BIT:
-		smmu->oas = 52;
-		smmu->pgsize_bitmap |= 1ULL << 42; /* 4TB */
-		break;
-	default:
-		dev_info(smmu->dev,
-			"unknown output address size. Truncating to 48-bit\n");
-		fallthrough;
-	case IDR5_OAS_48_BIT:
-		smmu->oas = 48;
-	}
-
-	/* Set the DMA mask for our table walker */
-	if (dma_set_mask_and_coherent(smmu->dev, DMA_BIT_MASK(smmu->oas)))
-		dev_warn(smmu->dev,
-			 "failed to set DMA mask for table walker\n");
-
-	smmu->ias = max(smmu->ias, smmu->oas);
-
-	if ((smmu->features & ARM_SMMU_FEAT_TRANS_S1) &&
-	    (smmu->features & ARM_SMMU_FEAT_TRANS_S2))
-		smmu->features |= ARM_SMMU_FEAT_NESTING;
-
-	arm_smmu_device_iidr_probe(smmu);
-
-	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
-		 smmu->ias, smmu->oas, smmu->features);
-	return 0;
-}
-
 #ifdef CONFIG_ACPI
 #ifdef CONFIG_TEGRA241_CMDQV
 static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index fc1b8c2af2a2..1ffc8320b846 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -341,6 +341,17 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
 		       struct arm_smmu_cd *cd);
 
+int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
+			    unsigned int reg_off, unsigned int ack_off);
+int arm_smmu_update_gbpa(struct arm_smmu_device *smmu, u32 set, u32 clr);
+int arm_smmu_device_disable(struct arm_smmu_device *smmu);
+struct iommu_group *arm_smmu_device_group(struct device *dev);
+int arm_smmu_of_xlate(struct device *dev, const struct of_phandle_args *args);
+void arm_smmu_get_resv_regions(struct device *dev,
+			       struct list_head *head);
+
+int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu);
+
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
-- 
2.47.0.338.g60cca15819-goog


