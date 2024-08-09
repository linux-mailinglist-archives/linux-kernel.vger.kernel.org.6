Return-Path: <linux-kernel+bounces-281561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604D094D82D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6BD28420A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6376F16B3B4;
	Fri,  9 Aug 2024 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAW99tlI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B115E5CF;
	Fri,  9 Aug 2024 20:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236417; cv=none; b=TtM94LUmGdh9aVkmwLB1HN8YtcJiTLO6Amgf5vwvg8Dm5mBMq1F5LeYvNVZuNf2yBnx27AoguGOD3PyL80Lvl8SXmgQP++AwDaif17HMcTS9aLCFS38CFMksYPLVmb4WFfwNFNRSPqPRejWFvTXOM2PsBNjJOg4Wvq8d0h/yCJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236417; c=relaxed/simple;
	bh=JLPcpmBUGAby5NZuWv7PL4MtRY4yjsp/YYxO8Qydfiw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1scaY57R+Cn6OkYVcOaAXBB8r4vRYMIGuJUHzCoeZCFDE6VreWPVheaAI3RKWh6Ej9w4ve7M62FYdUIKyUWSVPqIBBS3I0s0ihPb78sdBgGkM38BdnmxEpQ1pXcpf85rv+VaYkskXn6t7ijY2L+IM36+TdkxeUcb0jF+OztIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAW99tlI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723236415; x=1754772415;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JLPcpmBUGAby5NZuWv7PL4MtRY4yjsp/YYxO8Qydfiw=;
  b=oAW99tlIVER1vmALqy1nR7v9Q/V/qhhNpGnHKruRXXUagB5HLiND0+xS
   scvTPu74DyGONeRK7z4j0ydkFcdv5iC/kCu/tFcs+ab2mMBpZupP72rfa
   ILegkVu5eaOhP1DvxQAUWOCi8SuYCaoYYx5bV5C7DzIstqSPAyCYV3HUe
   nrxrDvut4eO3NKue308pm8SHJP/EGYkcWeOOn3ZiVjZtqgH19NiaPTWtT
   FPe5ytGQtqZXac59DWaPlnSaJGU2NdpvyaMnh7LS+QPsJLoliwoRxXxIQ
   fDXzOubTp+eW7aO6woSl/vY/4D6C0NMahE3QNMUrriry2/J/8DF3sWkm4
   g==;
X-CSE-ConnectionGUID: ZjMK9DuOQn+o/ThDZ5sWNw==
X-CSE-MsgGUID: oyyj5fheTp+RmV7lZrbIHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32819019"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="32819019"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:53 -0700
X-CSE-ConnectionGUID: n8JEiC2fTiWR6IIsMwrlVw==
X-CSE-MsgGUID: wircZBkxQjmK1QUHa4Gc3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57650471"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO xpardee-desk.hsd1.or.comcast.net) ([10.124.221.156])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 13:46:53 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] platform/x86:intel/pmc: Create Intel PMC SSRAM Telemetry driver
Date: Fri,  9 Aug 2024 13:46:31 -0700
Message-ID: <20240809204648.1124545-3-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809204648.1124545-1-xi.pardee@linux.intel.com>
References: <20240809204648.1124545-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xi Pardee <xi.pardee@intel.com>

Create Intel PMC SSRAM Telemetry driver for SSRAM device. The driver binds
to SSRAM device and provides the following functionalities:
1. Look for and register telemetry regions available in SSRAM device.
2. Provide devid and PWRMBASE address information for the corresponding
   PMCs.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
---
 drivers/platform/x86/intel/pmc/Kconfig        |  10 +
 drivers/platform/x86/intel/pmc/Makefile       |   4 +
 drivers/platform/x86/intel/pmc/core.h         |  10 +
 .../platform/x86/intel/pmc/ssram_telemetry.c  | 184 ++++++++++++++++++
 .../platform/x86/intel/pmc/ssram_telemetry.h  |  45 +++++
 5 files changed, 253 insertions(+)
 create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.c
 create mode 100644 drivers/platform/x86/intel/pmc/ssram_telemetry.h

diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
index d2f651fbec2c..fe33348cd7e2 100644
--- a/drivers/platform/x86/intel/pmc/Kconfig
+++ b/drivers/platform/x86/intel/pmc/Kconfig
@@ -24,3 +24,13 @@ config INTEL_PMC_CORE
 		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
 		- Low Power Mode registers (Tigerlake and beyond)
 		- PMC quirks as needed to enable SLPS0/S0ix
+
+config INTEL_PMC_SSRAM_TELEMETRY
+	tristate "Intel PMC SSRAM Telemetry driver"
+	depends on INTEL_VSEC
+	help
+	  The PMC SSRAM device contains counters structured in Intel Platform
+	  Monitoring Techology (PMT) telemetry regions. This driver looks for
+	  and register these telemetry regions so they would be available for
+	  read through sysfs and Intel PMT API. The driver also provides API to
+	  expose information of PMCs available in the platform.
diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
index 6b682be0ec5a..8352c6d66f2b 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -8,3 +8,7 @@ intel_pmc_core-y			:= core.o spt.o cnp.o icl.o \
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
 intel_pmc_core_pltdrv-y			:= pltdrv.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o
+
+# Intel PMC SSRAM driver
+intel_pmc_ssram_telemetry-y		+= ssram_telemetry.o
+obj-$(CONFIG_INTEL_PMC_SSRAM_TELEMETRY)	+= intel_pmc_ssram_telemetry.o
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index b0c66df8cd98..1e5726745394 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -285,6 +285,16 @@ enum ppfear_regs {
 #define LNL_PPFEAR_NUM_ENTRIES			12
 #define LNL_S0IX_BLOCKER_OFFSET			0x2004
 
+/* SSRAM PMC Device ID*/
+/* ARL */
+#define PMC_DEVID_ARL_SOCS	0xae7f
+
+/* MTL */
+#define PMC_DEVID_MTL_SOCM	0x7e7f
+
+/* LNL */
+#define PMC_DEVID_LNL_SOCM	0xa87f
+
 extern const char *pmc_lpm_modes[];
 
 struct pmc_bit_map {
diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
new file mode 100644
index 000000000000..25f6e07c15be
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel PMC SSRAM TELEMETRY PCI Driver
+ *
+ * Copyright (c) 2024, Intel Corporation.
+ * All Rights Reserved.
+ *
+ */
+
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include "../vsec.h"
+#include "core.h"
+#include "ssram_telemetry.h"
+
+#define SSRAM_HDR_SIZE		0x100
+#define SSRAM_PWRM_OFFSET	0x14
+#define SSRAM_DVSEC_OFFSET	0x1C
+#define SSRAM_DVSEC_SIZE	0x10
+#define SSRAM_PCH_OFFSET	0x60
+#define SSRAM_IOE_OFFSET	0x68
+#define SSRAM_DEVID_OFFSET	0x70
+
+static struct pmc_ssram_telemetry *pmc_ssram_telems;
+static bool device_probed;
+
+DEFINE_FREE(pmc_ssram_telemetry_iounmap, void __iomem *, iounmap(_T));
+
+static void pmc_ssram_telemetry_add_pmt(struct pci_dev *pdev, u64 ssram_base, void __iomem *ssram)
+{
+	struct intel_vsec_platform_info info = {};
+	struct intel_vsec_header *headers[2] = {};
+	struct intel_vsec_header header;
+	void __iomem *dvsec;
+	u32 dvsec_offset;
+	u32 table, hdr;
+
+	dvsec_offset = readl(ssram + SSRAM_DVSEC_OFFSET);
+	dvsec = ioremap(ssram_base + dvsec_offset, SSRAM_DVSEC_SIZE);
+	if (!dvsec)
+		return;
+
+	hdr = readl(dvsec + PCI_DVSEC_HEADER1);
+	header.id = readw(dvsec + PCI_DVSEC_HEADER2);
+	header.rev = PCI_DVSEC_HEADER1_REV(hdr);
+	header.length = PCI_DVSEC_HEADER1_LEN(hdr);
+	header.num_entries = readb(dvsec + INTEL_DVSEC_ENTRIES);
+	header.entry_size = readb(dvsec + INTEL_DVSEC_SIZE);
+
+	table = readl(dvsec + INTEL_DVSEC_TABLE);
+	header.tbir = INTEL_DVSEC_TABLE_BAR(table);
+	header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
+	iounmap(dvsec);
+
+	headers[0] = &header;
+	info.caps = VSEC_CAP_TELEMETRY;
+	info.headers = headers;
+	info.base_addr = ssram_base;
+	info.parent = &pdev->dev;
+
+	intel_vsec_register(pdev, &info);
+}
+
+static inline u64 get_base(void __iomem *addr, u32 offset)
+{
+	return lo_hi_readq(addr + offset) & GENMASK_ULL(63, 3);
+}
+
+static int pmc_ssram_telemetry_get_pmc(struct pci_dev *pdev, unsigned int pmc_idx, u32 offset)
+{
+	void __iomem __free(pmc_ssram_telemetry_iounmap) * tmp_ssram = NULL;
+	void __iomem __free(pmc_ssram_telemetry_iounmap) * ssram = NULL;
+	u64 ssram_base, pwrm_base;
+	u16 devid;
+
+	ssram_base = pdev->resource[0].start;
+	tmp_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
+
+	if (!tmp_ssram)
+		return -ENOMEM;
+
+	if (pmc_idx != PMC_IDX_MAIN) {
+		/*
+		 * The secondary PMC BARS (which are behind hidden PCI devices)
+		 * are read from fixed offsets in MMIO of the primary PMC BAR.
+		 */
+		ssram_base = get_base(tmp_ssram, offset);
+		if (!ssram_base)
+			return -ENODEV;
+
+		ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
+		if (!ssram)
+			return -ENOMEM;
+	} else
+		ssram = no_free_ptr(tmp_ssram);
+
+	/* Find and register and PMC telemetry entries */
+	pmc_ssram_telemetry_add_pmt(pdev, ssram_base, ssram);
+
+	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
+	if (!pwrm_base)
+		return -ENODEV;
+	devid = readw(ssram + SSRAM_DEVID_OFFSET);
+
+	pmc_ssram_telems[pmc_idx].devid = devid;
+	pmc_ssram_telems[pmc_idx].base_addr = pwrm_base;
+
+	return 0;
+}
+
+int pmc_ssram_telemetry_get_pmc_info(unsigned int pmc_idx,
+				     struct pmc_ssram_telemetry *pmc_ssram_telemetry)
+{
+	/*
+	 * PMCs are discovered in probe function. If this function is called before
+	 * probe function complete, the result would be invalid. Use device_probed
+	 * variable to avoid this case. Return -EAGAIN to inform the user to call
+	 * again later.
+	 */
+	if (!device_probed)
+		return -EAGAIN;
+
+	if (pmc_idx >= MAX_NUM_PMC)
+		return -EINVAL;
+
+	if (!pmc_ssram_telems || !pmc_ssram_telems[pmc_idx].devid)
+		return -ENODEV;
+
+	pmc_ssram_telemetry->devid = pmc_ssram_telems[pmc_idx].devid;
+	pmc_ssram_telemetry->base_addr = pmc_ssram_telems[pmc_idx].base_addr;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pmc_ssram_telemetry_get_pmc_info);
+
+static int intel_pmc_ssram_telemetry_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int ret;
+
+	pmc_ssram_telems = devm_kzalloc(&pdev->dev, sizeof(*pmc_ssram_telems) * MAX_NUM_PMC,
+					GFP_KERNEL);
+	if (!pmc_ssram_telems) {
+		ret = -ENOMEM;
+		goto probe_finish;
+	}
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		dev_dbg(&pdev->dev, "failed to enable PMC SSRAM device\n");
+		goto probe_finish;
+	}
+
+	ret = pmc_ssram_telemetry_get_pmc(pdev, PMC_IDX_MAIN, 0);
+	if (ret)
+		goto probe_finish;
+
+	pmc_ssram_telemetry_get_pmc(pdev, PMC_IDX_IOE, SSRAM_IOE_OFFSET);
+	pmc_ssram_telemetry_get_pmc(pdev, PMC_IDX_PCH, SSRAM_PCH_OFFSET);
+
+probe_finish:
+	device_probed = true;
+	return ret;
+}
+
+static const struct pci_device_id intel_pmc_ssram_telemetry_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_MTL_SOCM) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_LNL_SOCM) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCS) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, intel_pmc_ssram_telemetry_pci_ids);
+
+static struct pci_driver intel_pmc_ssram_telemetry_driver = {
+	.name = "intel_pmc_ssram_telemetry",
+	.id_table = intel_pmc_ssram_telemetry_pci_ids,
+	.probe = intel_pmc_ssram_telemetry_probe,
+};
+module_pci_driver(intel_pmc_ssram_telemetry_driver);
+
+MODULE_IMPORT_NS(INTEL_VSEC);
+MODULE_AUTHOR("Xi Pardee <xi.pardee@intel.com>");
+MODULE_DESCRIPTION("Intel PMC SSRAM TELEMETRY driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.h b/drivers/platform/x86/intel/pmc/ssram_telemetry.h
new file mode 100644
index 000000000000..938d0baf50be
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Intel PMC SSRAM TELEMETRY PCI Driver Header File
+ *
+ * Copyright (c) 2024, Intel Corporation.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef PMC_SSRAM_H
+#define PMC_SSRAM_H
+
+/**
+ * struct pmc_ssram_telemetry - Structure to keep pmc info in ssram device
+ * @devid:		device id of the pmc device
+ * @base_addr:		contains PWRM base address
+ */
+struct pmc_ssram_telemetry {
+	u16 devid;
+	u64 base_addr;
+};
+
+#if IS_REACHABLE(CONFIG_INTEL_PMC_SSRAM_TELEMETRY)
+/**
+ * pmc_ssram_telemetry_get_pmc_info() - Get a PMC devid and base_addr information
+ * @pmc_idx:               Index of the PMC
+ * @pmc_ssram_telemetry:   pmc_ssram_telemetry structure to store the PMC information
+ *
+ * Return:
+ * * 0           - Success
+ * * -EAGAIN     - Probe function has not finished yet. Try again.
+ * * -EINVAL     - Invalid pmc_idx
+ * * -ENODEV     - PMC device is not available
+ */
+int pmc_ssram_telemetry_get_pmc_info(unsigned int pmc_idx,
+				     struct pmc_ssram_telemetry *pmc_ssram_telemetry);
+#else /* !CONFIG_INTEL_PMC_SSRAM_TELEMETRY */
+static inline int pmc_ssram_telemetry_get_pmc_info(int pmc_idx,
+						   struct pmc_ssram_telemetry *pmc_ssram_telemetry)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_INTEL_PMC_SSRAM_TELEMETRY */
+
+#endif /* PMC_SSRAM_H */
-- 
2.43.0


