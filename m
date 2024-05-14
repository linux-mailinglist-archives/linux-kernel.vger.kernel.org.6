Return-Path: <linux-kernel+bounces-179046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E35C8C5AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A83B21058
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1E1181321;
	Tue, 14 May 2024 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ucYWv+1j"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B91181300
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710624; cv=none; b=jsysUxjOrxSn5LYAn3t2lW11eCf8VGJJFGmm547lKPovGKDQMOBlRCyeCLlfr8tUwkXTchu2IHMB/dpbnedO+hrzNeaMoRVeVPSC8Yqhk5/B5+Ewc9Ce5+UTKwpXsXX45KTq3qGC9KXJBNx5Ydn9FA/sj9hIhWBzxV7GBP8Uo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710624; c=relaxed/simple;
	bh=HoFwp2NvrZ/kgOo1bSjj3elxDpYa/qQz+6YWpjmIG1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gg3AtD15JdXEnkQrrDdI1oexqp90nqf7NGdYVsrNkEqy6CbR46YZlzWf1HWRFUHDrTZdyLHQ3LjXEVzAiyshvAdYR1m3F/vjhcr1i69fGKXo+04/4kSe+fRLg/C3KZYF6SytZoTS6H47q1cDQ2Fe5CU1inHOb1hat8O+FXlw5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ucYWv+1j; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f0537e39b3so31920395ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715710622; x=1716315422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgmIcC/shr4A/zWz9MZMwn+W/sUs7tQkcY5o3763qNA=;
        b=ucYWv+1jmxDPjywQ24MU5kxdUAHEq5A2D3GFLpXA6iCgjavaCvlOZadnSVHVR+ZlId
         xR4iYK2X2hNmY6mFTkVTy5D8GwVHJWWTaA3RkKV3EkL28+vCXk9gg/sq8peduUWGBK6S
         eafTmQ+npq8p7K4IKK0O2X7ddduOm4j3x2GDGoeZyVbLXRGHTs41DydhH0Owskc3vT1n
         3VvikOSou/9of1rvh7kSXAtOT3X62LQ/eMZCBdj/Sxj8gzV9OR5+9BhqlR0DLmdaklJd
         /drYocxRo88FjJFW0JSSeRwlGY9AP4wZM8ZXm/OxW2bzItIZBqzq6BR7urBO4MmorzJA
         tivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715710622; x=1716315422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgmIcC/shr4A/zWz9MZMwn+W/sUs7tQkcY5o3763qNA=;
        b=gkeRd2RL7ryJ8Ey5F7adSbwHXyPAoxrTX8SzJdkIrwjDqGW+ppKPSu300psaXKABgG
         kHe38+U4OJIJkk3gEuoOjze9CPfPK5Fd9fF8XbAZ81swwbPh1PsFF8gw6/CNduMyYsHY
         qHN9IPLx8TxSwRK3jOkNPJnbCHIXbaVpVOtqeoUkkYFkoXeMBLsGgH16B9e9czC1c2Gc
         HrMH+dUlWBPxEnftHcRldDiRMABGliaGsK8azH1UAMDnN8HH6FvslzdOqBTD7JM1iFG7
         D625R8x3XM9386l/jQs1oAobmxcGv8b+KGWyXtuBbeycTR66oPtRxfzDqINBRzY1l6P5
         Y6jg==
X-Forwarded-Encrypted: i=1; AJvYcCU2SHNgj68iUAHITr6ABf8ArlDIG9ASBSEGF/rfut817k77otUEeLdKgPsrZYTWpK4d/FZdFzjZyampzEjVEFR3XKHlY9vsaVLT7Waq
X-Gm-Message-State: AOJu0Yx5YxwLh8qsDuwp8f5UUaUE2zh8uALJRlcq35RmMoK6gJ73ebeB
	4D6kg93ANnwjSdT3I5sBBQxmoSEk53/eaDXrYa9jECQVF6nmhs9yHC7msz51b7o=
X-Google-Smtp-Source: AGHT+IFhpX4t56j2JQla2JooYLaxoSHy2mymfYJNtUfgW6LVrY1mnVzmPiLf9SE1+Xpp4mkUinMPlg==
X-Received: by 2002:a17:902:fc4f:b0:1e8:c962:4f6e with SMTP id d9443c01a7336-1ef43d27f6fmr150703805ad.20.1715710622250;
        Tue, 14 May 2024 11:17:02 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad6386sm100993625ad.80.2024.05.14.11.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 11:17:01 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 3/7] iommu/riscv: Add RISC-V IOMMU PCIe device driver
Date: Tue, 14 May 2024 11:16:15 -0700
Message-Id: <7f6b1a277f9dd793704ddf1fa337ca3e78711942.1715708679.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1715708679.git.tjeznach@rivosinc.com>
References: <cover.1715708679.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit

Introduce device driver for PCIe implementation
of RISC-V IOMMU architected hardware.

IOMMU hardware and system support for MSI or MSI-X is
required by this implementation.

Vendor and device identifiers used in this patch
matches QEMU implementation of the RISC-V IOMMU PCIe
device, from Rivos VID (0x1efd) range allocated by the PCI-SIG.

MAINTAINERS | added iommu-pci.c already covered by matching pattern.

Link: https://lore.kernel.org/qemu-devel/20240307160319.675044-1-dbarboza@ventanamicro.com/
Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/Kconfig     |   5 ++
 drivers/iommu/riscv/Makefile    |   1 +
 drivers/iommu/riscv/iommu-pci.c | 119 ++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/iommu/riscv/iommu-pci.c

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index 5dcc5c45aa50..c071816f59a6 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -13,3 +13,8 @@ config RISCV_IOMMU
 
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the RISC-V IOMMU architecture.
+
+config RISCV_IOMMU_PCI
+	def_bool y if RISCV_IOMMU && PCI_MSI
+	help
+	  Support for the PCIe implementation of RISC-V IOMMU architecture.
diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
index e4c189de58d3..f54c9ed17d41 100644
--- a/drivers/iommu/riscv/Makefile
+++ b/drivers/iommu/riscv/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o
+obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
new file mode 100644
index 000000000000..0a60e068fdc9
--- /dev/null
+++ b/drivers/iommu/riscv/iommu-pci.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright © 2022-2024 Rivos Inc.
+ * Copyright © 2023 FORTH-ICS/CARV
+ *
+ * RISCV IOMMU as a PCIe device
+ *
+ * Authors
+ *	Tomasz Jeznach <tjeznach@rivosinc.com>
+ *	Nick Kossifidis <mick@ics.forth.gr>
+ */
+
+#include <linux/compiler.h>
+#include <linux/init.h>
+#include <linux/iommu.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include "iommu-bits.h"
+#include "iommu.h"
+
+/* Rivos Inc. assigned PCI Vendor and Device IDs */
+#ifndef PCI_VENDOR_ID_RIVOS
+#define PCI_VENDOR_ID_RIVOS             0x1efd
+#endif
+
+#ifndef PCI_DEVICE_ID_RIVOS_IOMMU
+#define PCI_DEVICE_ID_RIVOS_IOMMU       0xedf1
+#endif
+
+static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct riscv_iommu_device *iommu;
+	int rc, vec;
+
+	rc = pcim_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
+		return -ENODEV;
+
+	if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
+		return -ENODEV;
+
+	rc = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (rc)
+		return dev_err_probe(dev, rc, "pcim_iomap_regions failed\n");
+
+	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
+	if (!iommu)
+		return -ENOMEM;
+
+	iommu->dev = dev;
+	iommu->reg = pcim_iomap_table(pdev)[0];
+
+	pci_set_master(pdev);
+	dev_set_drvdata(dev, iommu);
+
+	/* Check device reported capabilities / features. */
+	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
+	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
+
+	/* The PCI driver only uses MSIs, make sure the IOMMU supports this */
+	switch (FIELD_GET(RISCV_IOMMU_CAP_IGS, iommu->caps)) {
+	case RISCV_IOMMU_CAP_IGS_MSI:
+	case RISCV_IOMMU_CAP_IGS_BOTH:
+		break;
+	default:
+		return dev_err_probe(dev, -ENODEV,
+				     "unable to use message-signaled interrupts\n");
+	}
+
+	/* Allocate and assign IRQ vectors for the various events */
+	rc = pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT,
+				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (rc <= 0)
+		return dev_err_probe(dev, -ENODEV,
+				     "unable to allocate irq vectors\n");
+
+	iommu->irqs_count = rc;
+	for (vec = 0; vec < iommu->irqs_count; vec++)
+		iommu->irqs[vec] = msi_get_virq(dev, vec);
+
+	/* Enable message-signaled interrupts, fctl.WSI */
+	if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
+		iommu->fctl ^= RISCV_IOMMU_FCTL_WSI;
+		riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
+	}
+
+	return riscv_iommu_init(iommu);
+}
+
+static void riscv_iommu_pci_remove(struct pci_dev *pdev)
+{
+	struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
+
+	riscv_iommu_remove(iommu);
+}
+
+static const struct pci_device_id riscv_iommu_pci_tbl[] = {
+	{PCI_VENDOR_ID_RIVOS, PCI_DEVICE_ID_RIVOS_IOMMU,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{0,}
+};
+
+static struct pci_driver riscv_iommu_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = riscv_iommu_pci_tbl,
+	.probe = riscv_iommu_pci_probe,
+	.remove = riscv_iommu_pci_remove,
+	.driver = {
+		.suppress_bind_attrs = true,
+	},
+};
+
+builtin_pci_driver(riscv_iommu_pci_driver);
-- 
2.34.1


