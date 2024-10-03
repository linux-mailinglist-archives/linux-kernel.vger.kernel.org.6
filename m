Return-Path: <linux-kernel+bounces-348961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A62598EE80
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80774B24B95
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538611581E5;
	Thu,  3 Oct 2024 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="M0nTHU21"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB32015624C
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956285; cv=none; b=LqK7ZnOKngB35xzEHv6+yg3kFYegEiWAEcmP0SpXKZzsJ8l3uyrJO1mWj7m09aZ4oQzLh3FbYWs3wJoQeTE940oZXuuNllR0gl2Hu1eiI0fcs7DyrXCE8jKfnjPt4SGQxWIYHyqUqy2cAou8nzCYuiUs9AgNwkYMaXISZro5ocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956285; c=relaxed/simple;
	bh=3vs5M+PBJClTj/pnyjaLVVwE4NRicvKtEG6B0vd5HtA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkeO+B/F2If1oxJvRiKZickjG4+Q2FIqWBxKGOQY3fgBwKEBksIMzaWHVAYfINSYcCYidhqS8XDDkM+8LJD8HobrngsqI67mPU5OKruYpe/uzBrA3qdqfCjTl+HHn5Z96QkIFP7HeuPmfOT4mkG8zn1NAy5ETV9bmQh93hYyVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=M0nTHU21; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49345uCD002543;
	Thu, 3 Oct 2024 04:51:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	UZQDvMTUdrKTIYhwObAMWphwZVsUYgtKsY7d0vE6+4=; b=M0nTHU21ScneqoLcG
	MG3dXIAqlYLX7MJHvafkUYhjEPThiOfGJFaweSESp8Qf9v21VVrfcShUSeeXJqnw
	nRLFWMrgAusnHCxjECizQ0El7POcPbUXpmvatGQK96JvuXKlmufaqblnZDdQiBD6
	+JmIToRNI/Hl4YyhLC1zoUQw99GJjaYEvaVwkTBlKB15C9EBbfdvG8IJblKMBvpW
	zmwUqLfrruh0yPl/YF1KAzo0LOACpsD4YjAQMefPM9B86chLgb+0rx8HRRmSnDGz
	F3xXtHGRd1JI1kOSKN57pgW7On2IJmXsgA24i1ZhhEAvc9LsFlpDJcReSDgoVu2s
	IHSMw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 421b849jya-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 04:51:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Oct 2024 04:51:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Oct 2024 04:51:06 -0700
Received: from localhost.localdomain (unknown [10.29.37.241])
	by maili.marvell.com (Postfix) with ESMTP id F12865B6935;
	Thu,  3 Oct 2024 04:51:03 -0700 (PDT)
From: Anshumali Gaur <agaur@marvell.com>
To: <quic_bjorande@quicinc.com>, <christophe.leroy@csgroup.eu>,
        <angelogioacchino.delregno@collabora.com>, <herve.codina@bootlin.com>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH v3 1/4] soc: marvell: Add a general purpose RVU PF driver
Date: Thu, 3 Oct 2024 17:20:54 +0530
Message-ID: <20241003115057.2810857-2-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003115057.2810857-1-agaur@marvell.com>
References: <20241003115057.2810857-1-agaur@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RG-7p-offFT1e6_gNkLLCYCsofgXyMMr
X-Proofpoint-ORIG-GUID: RG-7p-offFT1e6_gNkLLCYCsofgXyMMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Resource virtualization unit (RVU) on Marvell's Octeon series of
silicons maps HW resources from the network, crypto and other
functional blocks into PCI-compatible physical and virtual functions.
Each functional block again has multiple local functions (LFs) for
provisioning to PCI devices.
RVU supports multiple PCIe SRIOV physical functions (PFs) and virtual
functions (VFs). And RVU admin function (AF) is the one which manages
all the resources (local functions etc) in the system.

Functionality of these PFs and VFs depends on which block LFs are
attached to them. Depending on usecase some PFs might support IO
(ie LFs attached) and some may not. For the usecases where PF
doesn't (need to) support IO, PF's driver will be limited to below
functionality.
1. Creating and destroying of PCIe SRIOV VFs
2. Support mailbox communication between VFs and admin function
   (RVU AF)
3. PCIe Function level reset (FLR) for VFs

For such PFs this patch series adds a general purpose driver which
supports above functionality. This will avoid duplicating same
functionality for different RVU PFs.

This patch adds basic stub PF driver with PCI device init logic and
SRIOV enable/disable support.

Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
 drivers/soc/Kconfig                     |   1 +
 drivers/soc/Makefile                    |   1 +
 drivers/soc/marvell/Kconfig             |  19 +++
 drivers/soc/marvell/Makefile            |   2 +
 drivers/soc/marvell/rvu_gen_pf/Makefile |   5 +
 drivers/soc/marvell/rvu_gen_pf/gen_pf.c | 160 ++++++++++++++++++++++++
 drivers/soc/marvell/rvu_gen_pf/gen_pf.h |  19 +++
 7 files changed, 207 insertions(+)
 create mode 100644 drivers/soc/marvell/Kconfig
 create mode 100644 drivers/soc/marvell/Makefile
 create mode 100644 drivers/soc/marvell/rvu_gen_pf/Makefile
 create mode 100644 drivers/soc/marvell/rvu_gen_pf/gen_pf.c
 create mode 100644 drivers/soc/marvell/rvu_gen_pf/gen_pf.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 6a8daeb8c4b9..a5d3770a6acf 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -15,6 +15,7 @@ source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/litex/Kconfig"
 source "drivers/soc/loongson/Kconfig"
+source "drivers/soc/marvell/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/microchip/Kconfig"
 source "drivers/soc/nuvoton/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 2037a8695cb2..b20ec6071302 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -20,6 +20,7 @@ obj-y				+= ixp4xx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
 obj-y				+= loongson/
+obj-y				+= marvell/
 obj-y				+= mediatek/
 obj-y				+= microchip/
 obj-y				+= nuvoton/
diff --git a/drivers/soc/marvell/Kconfig b/drivers/soc/marvell/Kconfig
new file mode 100644
index 000000000000..b55d3bbfaf2a
--- /dev/null
+++ b/drivers/soc/marvell/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# MARVELL SoC drivers
+#
+
+menu "Marvell SoC drivers"
+
+config MARVELL_OCTEON_RVU_GEN_PF
+	tristate "Marvell Octeon RVU Generic PF Driver"
+	depends on ARM64 && PCI && OCTEONTX2_AF
+	default n
+	help
+	This driver is used to create and destroy PCIe SRIOV VFs of the
+	RVU PFs that doesn't need to support any I/O functionality. It also
+	enables VFs to communicate with RVU admin function (AF) & handles
+	PCIe FLR for VFs.
+
+	Say ‘Yes’ to this driver if you have such a RVU PF device.
+endmenu
diff --git a/drivers/soc/marvell/Makefile b/drivers/soc/marvell/Makefile
new file mode 100644
index 000000000000..9a6917393873
--- /dev/null
+++ b/drivers/soc/marvell/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MARVELL_OCTEON_RVU_GEN_PF) += rvu_gen_pf/
diff --git a/drivers/soc/marvell/rvu_gen_pf/Makefile b/drivers/soc/marvell/rvu_gen_pf/Makefile
new file mode 100644
index 000000000000..6c3d2568942b
--- /dev/null
+++ b/drivers/soc/marvell/rvu_gen_pf/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for Marvell's Octeon RVU GENERIC PF driver
+#
+obj-$(CONFIG_MARVELL_OCTEON_RVU_GEN_PF) += gen_pf.o
+ccflags-y += -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af
diff --git a/drivers/soc/marvell/rvu_gen_pf/gen_pf.c b/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
new file mode 100644
index 000000000000..6437916cb6d7
--- /dev/null
+++ b/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell Octeon RVU Generic Physical Function driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/sysfs.h>
+
+#include "gen_pf.h"
+#include <rvu_trace.h>
+#include <rvu.h>
+
+#define DRV_NAME    "rvu_generic_pf"
+
+/* Supported devices */
+static const struct pci_device_id rvu_gen_pf_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xA0F6) },
+	{ }  /* end of table */
+};
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Marvell Octeon RVU Generic PF Driver");
+MODULE_DEVICE_TABLE(pci, rvu_gen_pf_id_table);
+
+static int rvu_gen_pf_check_pf_usable(struct gen_pf_dev *pfdev)
+{
+	u64 rev;
+
+	rev = readq(pfdev->reg_base + RVU_PF_BLOCK_ADDRX_DISC(BLKADDR_RVUM));
+	rev = (rev >> 12) & 0xFF;
+	/*
+	 * Check if AF has setup revision for RVUM block,
+	 * otherwise this driver probe should be deferred
+	 * until AF driver comes up.
+	 */
+	if (!rev) {
+		dev_warn(pfdev->dev,
+			 "AF is not initialized, deferring probe\n");
+		return -EPROBE_DEFER;
+	}
+	return 0;
+}
+
+static int rvu_gen_pf_sriov_enable(struct pci_dev *pdev, int numvfs)
+{
+	int ret;
+
+	ret = pci_enable_sriov(pdev, numvfs);
+	if (ret)
+		return ret;
+
+	return numvfs;
+}
+
+static int rvu_gen_pf_sriov_disable(struct pci_dev *pdev)
+{
+	int numvfs = pci_num_vf(pdev);
+
+	if (!numvfs)
+		return 0;
+
+	pci_disable_sriov(pdev);
+
+	return 0;
+}
+
+static int rvu_gen_pf_sriov_configure(struct pci_dev *pdev, int numvfs)
+{
+	if (numvfs == 0)
+		return rvu_gen_pf_sriov_disable(pdev);
+
+	return rvu_gen_pf_sriov_enable(pdev, numvfs);
+}
+
+static void rvu_gen_pf_remove(struct pci_dev *pdev)
+{
+	struct gen_pf_dev *pfdev = pci_get_drvdata(pdev);
+
+	rvu_gen_pf_sriov_disable(pfdev->pdev);
+	pci_set_drvdata(pdev, NULL);
+
+	pci_release_regions(pdev);
+}
+
+static int rvu_gen_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct gen_pf_dev *pfdev;
+	int err;
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		return err;
+	}
+
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err) {
+		dev_err(dev, "PCI request regions failed %d\n", err);
+		goto err_map_failed;
+	}
+
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
+	if (err) {
+		dev_err(dev, "DMA mask config failed, abort\n");
+		goto err_release_regions;
+	}
+
+	pci_set_master(pdev);
+
+	pfdev = devm_kzalloc(dev, sizeof(struct gen_pf_dev), GFP_KERNEL);
+	if (!pfdev) {
+		err = -ENOMEM;
+		goto err_release_regions;
+	}
+
+	pci_set_drvdata(pdev, pfdev);
+	pfdev->pdev = pdev;
+	pfdev->dev = dev;
+	pfdev->total_vfs = pci_sriov_get_totalvfs(pdev);
+
+	err = rvu_gen_pf_check_pf_usable(pfdev);
+	if (err)
+		goto err_release_regions;
+
+	return 0;
+
+err_release_regions:
+	pci_release_regions(pdev);
+	pci_set_drvdata(pdev, NULL);
+err_map_failed:
+	pci_disable_device(pdev);
+	return err;
+}
+
+static struct pci_driver rvu_gen_driver = {
+	.name = DRV_NAME,
+	.id_table = rvu_gen_pf_id_table,
+	.probe = rvu_gen_pf_probe,
+	.remove = rvu_gen_pf_remove,
+	.sriov_configure = rvu_gen_pf_sriov_configure,
+};
+
+static int __init rvu_gen_pf_init_module(void)
+{
+	return pci_register_driver(&rvu_gen_driver);
+}
+
+static void __exit rvu_gen_pf_cleanup_module(void)
+{
+	pci_unregister_driver(&rvu_gen_driver);
+}
+
+module_init(rvu_gen_pf_init_module);
+module_exit(rvu_gen_pf_cleanup_module);
diff --git a/drivers/soc/marvell/rvu_gen_pf/gen_pf.h b/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
new file mode 100644
index 000000000000..d89b674b1a0f
--- /dev/null
+++ b/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell Octeon RVU Generic Physical Function driver
+ *
+ * Copyright (C) 2024 Marvell.
+ */
+#include <linux/device.h>
+#include <linux/pci.h>
+
+#define RVU_PFFUNC(pf, func)    \
+	((((pf) & RVU_PFVF_PF_MASK) << RVU_PFVF_PF_SHIFT) | \
+	(((func) & RVU_PFVF_FUNC_MASK) << RVU_PFVF_FUNC_SHIFT))
+
+struct gen_pf_dev {
+	struct pci_dev		*pdev;
+	struct device		*dev;
+	void __iomem		*reg_base;
+	int			pf;
+	u8			total_vfs;
+};
-- 
2.25.1


