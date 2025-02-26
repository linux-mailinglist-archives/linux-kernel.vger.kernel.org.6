Return-Path: <linux-kernel+bounces-533070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049FA45560
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D289189894F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0D26A093;
	Wed, 26 Feb 2025 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azwxf2z5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F04269806
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550571; cv=none; b=JPVFthjGiWTB2rXvmXzMM4a6AT/piLMnQ4G9oEda2g8/+1Ehte7/wJZR5b/ljsWPRz3X5zvMGldMQXAjvXj9m5Dnc2ylZui69zz1ghxpS0xs0m994Ley9XkbIbeEpP6PjE93kZFe5W22BZjk3dghwjnvYyAb9Kj5cEZzsT13okM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550571; c=relaxed/simple;
	bh=QHNRHvG/OXkKvZb6dLBeHah+A42rdz+0hcZn9bEWh/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DsN9xk5DWctZDZQH9upgwk50UPq1+q4q0k0rzeQKrjuvfN1s2/jrQ59cUk32I/5ZS5+LI4/Ltn7xAPtLTegqSDR6ZgxBDgEPmzwkdE55gmd7+ZqC8C0A1bapgwd6zkGn9YkL5atuVW9T/wJjjKofRxizgyoAlN0hcHBDXC7EBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azwxf2z5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740550568; x=1772086568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QHNRHvG/OXkKvZb6dLBeHah+A42rdz+0hcZn9bEWh/w=;
  b=azwxf2z5xOBjXfbomRr1C5hcKU7hODzr5D2E6/QRVZacDMtJ4/uXlZUJ
   nHr/clVgr2yA399noBWnIfXqIifEttBPixtHIMQgOSfjJSz1YtPEk9Y3G
   LUxL9CmmgaJRV4bWQllZrQTVKB09LI4vNyk4lITf+43NF9A5p0hhpJccT
   PgMDBaFkrUq1ofe5JlsuFlmJpAgJVk8qQkmiuQNT/rKmc8fIqxDNGz0rI
   kinK1+tTzWzyQ6XvdSDYGRXWd1kJq5W1q2h6lkmSvQ2frxBqRhOfLPkDW
   0vEeHPVg6u3vfO2vJlm8EoJemgYquDNC6/3HsqmahiuICim3yNvxxAqNB
   A==;
X-CSE-ConnectionGUID: AXdz+t2FQs6lgSVS/0xGQA==
X-CSE-MsgGUID: nBGYD0xxRCaxjIE/JM71Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41636487"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41636487"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:16:08 -0800
X-CSE-ConnectionGUID: O/swzXeCSAqZ5z6LVTOOQg==
X-CSE-MsgGUID: qpvMoH1jSjuGSiF8Pp4DvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="147434834"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa002.jf.intel.com with ESMTP; 25 Feb 2025 22:16:05 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: lee@kernel.org,
	giometti@enneenne.com,
	gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	raymond.tan@intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 4/4] mfd: intel-ehl: Introduce Intel Elkhart Lake PSE GPIO and TIO
Date: Wed, 26 Feb 2025 11:45:27 +0530
Message-Id: <20250226061527.3031250-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226061527.3031250-1-raag.jadav@intel.com>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Elkhart Lake Programmable Service Engine (PSE) includes two PCI
devices that expose two different capabilities of GPIO and Timed I/O
as a single PCI function through shared MMIO.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 MAINTAINERS                  |  5 ++
 drivers/mfd/Kconfig          |  9 ++++
 drivers/mfd/Makefile         |  1 +
 drivers/mfd/intel-ehl-gpio.c | 95 ++++++++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 drivers/mfd/intel-ehl-gpio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d4280facbe51..7e50a6892878 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11643,6 +11643,11 @@ F:	drivers/gpio/gpio-sodaville.c
 F:	drivers/gpio/gpio-tangier.c
 F:	drivers/gpio/gpio-tangier.h
 
+INTEL GPIO MFD DRIVER
+M:	Raag Jadav <raag.jadav@intel.com>
+S:	Supported
+F:	drivers/mfd/intel-ehl-gpio.c
+
 INTEL GVT-g DRIVERS (Intel GPU Virtualization)
 M:	Zhenyu Wang <zhenyuw@linux.intel.com>
 M:	Zhi Wang <zhi.wang.linux@gmail.com>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6b0682af6e32..8ba3db736a8f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -609,6 +609,15 @@ config MFD_INTEL_QUARK_I2C_GPIO
 	  their respective IO driver.
 	  The GPIO exports a total amount of 8 interrupt-capable GPIOs.
 
+config MFD_INTEL_EHL_PSE_GPIO
+	tristate "Intel Elkhart Lake PSE GPIO MFD"
+	depends on PCI && (X86 || COMPILE_TEST)
+	select MFD_CORE
+	help
+	  This MFD provides support for GPIO and TIO that exist on Intel
+	  Elkhart Lake PSE as a single PCI device. It splits the two I/O
+	  devices to their respective I/O drivers.
+
 config LPC_ICH
 	tristate "Intel ICH LPC"
 	depends on PCI
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9220eaf7cf12..bf7245fb6824 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -197,6 +197,7 @@ obj-$(CONFIG_PMIC_ADP5520)	+= adp5520.o
 obj-$(CONFIG_MFD_ADP5585)	+= adp5585.o
 obj-$(CONFIG_MFD_KEMPLD)	+= kempld-core.o
 obj-$(CONFIG_MFD_INTEL_QUARK_I2C_GPIO)	+= intel_quark_i2c_gpio.o
+obj-$(CONFIG_MFD_INTEL_EHL_PSE_GPIO)	+= intel-ehl-gpio.o
 obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
 obj-$(CONFIG_LPC_ICH)		+= lpc_ich.o
 obj-$(CONFIG_MFD_RDC321X)	+= rdc321x-southbridge.o
diff --git a/drivers/mfd/intel-ehl-gpio.c b/drivers/mfd/intel-ehl-gpio.c
new file mode 100644
index 000000000000..039c74c64848
--- /dev/null
+++ b/drivers/mfd/intel-ehl-gpio.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Multi-Functional driver for Elkhart Lake - Programmable
+ * Service Engine (PSE) GPIO & TIO
+ *
+ * Copyright (c) 2025 Intel Corporation
+ *
+ * Intel Elkhart Lake PSE includes two PCI devices that expose two
+ * different capabilities of GPIO and Timed I/O as a single PCI
+ * function through shared MMIO.
+ */
+
+#include <linux/array_size.h>
+#include <linux/ioport.h>
+#include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+
+#define PSE_GPIO_OFFSET		0x0000
+#define PSE_GPIO_SIZE		0x0134
+
+#define PSE_TIO_OFFSET		0x1000
+#define PSE_TIO_SIZE		0x06B0
+
+static struct resource ehl_pse_gpio_resources[] = {
+	DEFINE_RES_MEM(PSE_GPIO_OFFSET, PSE_GPIO_SIZE),
+	DEFINE_RES_IRQ(0),
+};
+
+static struct resource ehl_pse_tio_resources[] = {
+	DEFINE_RES_MEM(PSE_TIO_OFFSET, PSE_TIO_SIZE),
+	DEFINE_RES_IRQ(1),
+};
+
+static struct mfd_cell ehl_pse_gpio_devs[] = {
+	{
+		.name = "gpio-elkhartlake",
+		.num_resources = ARRAY_SIZE(ehl_pse_gpio_resources),
+		.resources = ehl_pse_gpio_resources,
+		.ignore_resource_conflicts = true,
+	},
+	{
+		.name = "pps-gen-tio",
+		.num_resources = ARRAY_SIZE(ehl_pse_tio_resources),
+		.resources = ehl_pse_tio_resources,
+		.ignore_resource_conflicts = true,
+	},
+};
+
+static int ehl_pse_gpio_probe(struct pci_dev *pci, const struct pci_device_id *id)
+{
+	int ret;
+
+	ret = pcim_enable_device(pci);
+	if (ret)
+		return ret;
+
+	pci_set_master(pci);
+
+	ret = pci_alloc_irq_vectors(pci, 2, 2, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		return ret;
+
+	return mfd_add_devices(&pci->dev, PLATFORM_DEVID_AUTO, ehl_pse_gpio_devs,
+			       ARRAY_SIZE(ehl_pse_gpio_devs), &pci->resource[0],
+			       pci_irq_vector(pci, 0), NULL);
+}
+
+static void ehl_pse_gpio_remove(struct pci_dev *pdev)
+{
+	mfd_remove_devices(&pdev->dev);
+	pci_free_irq_vectors(pdev);
+}
+
+static const struct pci_device_id ehl_pse_gpio_ids[] = {
+	{ PCI_VDEVICE(INTEL, 0x4b88) },
+	{ PCI_VDEVICE(INTEL, 0x4b89) },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, ehl_pse_gpio_ids);
+
+static struct pci_driver ehl_pse_gpio_driver = {
+	.probe		= ehl_pse_gpio_probe,
+	.remove		= ehl_pse_gpio_remove,
+	.id_table	= ehl_pse_gpio_ids,
+	.name		= "ehl_pse_gpio",
+};
+module_pci_driver(ehl_pse_gpio_driver);
+
+MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
+MODULE_AUTHOR("Raag Jadav <raag.jadav@intel.com>");
+MODULE_DESCRIPTION("Intel MFD for Elkhart Lake PSE GPIO & TIO");
+MODULE_LICENSE("GPL");
-- 
2.34.1


