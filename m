Return-Path: <linux-kernel+bounces-359969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D84599931F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B931A2859D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D61EB9E6;
	Thu, 10 Oct 2024 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="poBxU/F0"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3411E885C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589716; cv=none; b=BXwXj8xgwPp0KLlgg8T1MX3JEhPwaxbSPf4DmgokxHcPZW/Mg/eGhzhml7MHfGoLdqtmeUdjsV+eA+fhJf3d5CrkqAx8VOJSSc1RzuFtjzBYH65mp0ighV0rtmdfBdaSwlTTT1yi6RTTPUD+YMv01T9kuNaAw0AzqUdtq2JySBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589716; c=relaxed/simple;
	bh=Te/Q1kP4+1VYDUEulqGDVjmArtl7oE8N40xpPsWG7CI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cW4bZ03KeNtuAVa0okrRnqzERHeKSeuNb3hlNweJAl6pez3RJPmDZgW6Dx0o9m6jvuc++dlxxIv0mWKi3pD1WrFSVO6Ok8dL5oV6RV6f2/8AiToop1QWCjI3/Dip1Xm6Id5aa7qaxLNkbpoTuJyejK0cTQrTUNW6Z7mKXryDaQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=poBxU/F0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e9f98f2147so807054a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728589713; x=1729194513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNvjcSMD1XB1l6NOS6ExlEo9cUT+I176k7DgI2zQ1iA=;
        b=poBxU/F0UvIDswvXwuTq7aCRDr4mT/H5cFVIVdnEfT/2wDNG2qRJT1ta+R0hq7npzX
         8EZv+5le50bIvGzAAyMhLrk71KD161pf006azdQ4T3OwfLwzOyiw1Dw/9/8HHNvCXtCX
         Zz7QTrN3K3V9wKe2Ebz7nVmgUp6iPESWfThXykUH386+3S5xXQz6LqAap8SD1fTbZO7T
         7peZhzF+Xmu7Jr2aX/tDJsPQSWjlW5qkrmD/B/1mP+rzqz7O8jmKYuw1Lk+veiGmMGkg
         Qmeg9CPf5OaRov8iJWmxhgeMVOzhJuBcDMvyArL93W/DWncbEUXuKoIbOnPXP855/wwZ
         F8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589713; x=1729194513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNvjcSMD1XB1l6NOS6ExlEo9cUT+I176k7DgI2zQ1iA=;
        b=OtI3548GKXEyObqVVMrrjvAKMXaN3eOVver0+HxwjbJpwh5rPJkeKd+TCGOGbLs8X2
         g24aTAAxPiufXhVrGQ7+65ApJ/KpasdU7OHWr0shSyPSvF7z54JB8GUi26UpFzQA2kgv
         ipXpVBujYLDy/xt61IrWm/udd+nl6Pwnmme1dFYoMnFuSNpQQkurp+xmGyQS27rNYy6S
         j7GGrzmBIn6Z+ZEl1tXCAaQnGBaYaM1l3gm/xIpVPVzs9A5sa5Lt1Y/aYW+crBu8Wwfw
         cfwlBZEOXiHOG3o2qpQermj4j9kaXqydmi1QqWSnlL/iVn4OEAnnCLjndK/yqdLczOPR
         eLRw==
X-Forwarded-Encrypted: i=1; AJvYcCU25EDeKnWim8yl5gHQ5ZXKdWq0xMu4jafr4/63YZDVGGkuHQU/xKKgP7Ofj8R0slX3HB5EReTl/OOEduA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPI8thjx/zDI6zSwIRR4gKVjw1kvMQQcftbU2McFVoHMYYjvQV
	xzyrliXEBvQlBPcBF+t2aiuhkQ5TT9KigML7OrumFye5AmF/s82dhSXoy0LnEfQ=
X-Google-Smtp-Source: AGHT+IElWj3MBVHOh3B+iyij2musyj+SidDkbhoc+Fw3p7WR30V31+IbJsERJ4NjnBhf6uNry2i6AQ==
X-Received: by 2002:a17:90a:a00b:b0:2e2:ba35:356c with SMTP id 98e67ed59e1d1-2e2f0dc659emr339295a91.39.1728589713463;
        Thu, 10 Oct 2024 12:48:33 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2e6ef1ad0sm749135a91.49.2024.10.10.12.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:48:32 -0700 (PDT)
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
Subject: [PATCH v9 3/7] iommu/riscv: Add RISC-V IOMMU PCIe device driver
Date: Thu, 10 Oct 2024 12:48:06 -0700
Message-Id: <606ff9e3151cc264bc2377d66508b95619d529b1.1728579958.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728579958.git.tjeznach@rivosinc.com>
References: <cover.1728579958.git.tjeznach@rivosinc.com>
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
 drivers/iommu/riscv/iommu-pci.c | 120 ++++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
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
index 000000000000..c7a89143014c
--- /dev/null
+++ b/drivers/iommu/riscv/iommu-pci.c
@@ -0,0 +1,120 @@
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
+/* QEMU RISC-V IOMMU implementation */
+#define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU     0x0014
+
+/* Rivos Inc. assigned PCI Vendor and Device IDs */
+#ifndef PCI_VENDOR_ID_RIVOS
+#define PCI_VENDOR_ID_RIVOS                  0x1efd
+#endif
+
+#define PCI_DEVICE_ID_RIVOS_RISCV_IOMMU_GA   0x0008
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
+	iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
+	iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
+
+	/* The PCI driver only uses MSIs, make sure the IOMMU supports this */
+	switch (FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps)) {
+	case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
+	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
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
+	{PCI_VDEVICE(REDHAT, PCI_DEVICE_ID_REDHAT_RISCV_IOMMU), 0},
+	{PCI_VDEVICE(RIVOS, PCI_DEVICE_ID_RIVOS_RISCV_IOMMU_GA), 0},
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


