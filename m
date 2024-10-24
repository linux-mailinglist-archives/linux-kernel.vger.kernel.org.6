Return-Path: <linux-kernel+bounces-379437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD86B9ADEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C459281108
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520291C3025;
	Thu, 24 Oct 2024 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dazf7aAp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA111C07F2;
	Thu, 24 Oct 2024 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757491; cv=none; b=tBDC6eItHOuhFKhySY9F5wqmDh9PQeTDx7ZEidH0AMxRQUmed8lt8Gs7NGColwpej2my8TfHyUoreNr02L+aPgjinO8MkUwgy5oXB98kGdDVKI8yPSainEdDaebV9QZXTGJdmw8AS4BqXtpA2ddpCSMwNbauU/nRiVBuvH7cvMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757491; c=relaxed/simple;
	bh=CuyC66RQnIYTEQfzaHHSjKBC7+bSJgAjGVCjwTzx48o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPleXhZYNA22m8Jmk17pBKiufiyUbtTQcKuLCqFJkznn9rmoJJr75eXrWtxUihTj1wY3WzDE/QIZkwcpnEtOV7tAWsByB/lZ6whQmrGaQqYqHUMlWqNe0LHRYTkE6YvajNdfKGqNipyMisIutDjo+NDE8QFi03Lqa97hzQFL7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dazf7aAp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729757489; x=1761293489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CuyC66RQnIYTEQfzaHHSjKBC7+bSJgAjGVCjwTzx48o=;
  b=dazf7aAp1+jrpcK5LvJelZEDrYXBo7b0NdyTFEAFMAXNlDdnejH68vz1
   1m6C50G97HoOR0XgWOa7Lnz+FvVNer0klSnAcnCSbh/Yl7FOQyGZs2lW8
   TCq2ZPRanGVkc6jeCIb9KIK93b0J8URhSeECrdQyEB4sPikox+q2/0B+0
   rDv3ZCxxv0XJ/ZqOkPfy1s13NGFtqCNs83ddy11J/7KnBtmpM/eVRBRTH
   5X597rfeP8nPosnU5JC2vDaRi3EUDt8WpdBN0klEU9/a57f8zbigpNaMh
   F43TS4MYezgH1UGP4Ftrf9z3/dPkbycBndldDD6+t1Pim+/oZK2ZBBjv1
   w==;
X-CSE-ConnectionGUID: Xn5eZxCOSoCSoiBLFyfatg==
X-CSE-MsgGUID: WOWhrpURSiGBI8kAmGmxVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29501065"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29501065"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:11:28 -0700
X-CSE-ConnectionGUID: XYwT5F1RR9uSUyrjCTZhHA==
X-CSE-MsgGUID: J6Ss7ct1SCuPTfjqXQbHqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80690828"
Received: from shsensorbuild.sh.intel.com ([10.239.133.18])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2024 01:11:25 -0700
From: Even Xu <even.xu@intel.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	corbet@lwn.net
Cc: linux-input@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 12/22] HID: intel-thc-hid: intel-quickspi: Add THC QuickSPI driver hid layer
Date: Thu, 24 Oct 2024 16:10:13 +0800
Message-Id: <20241024081023.1468951-13-even.xu@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241024081023.1468951-1-even.xu@intel.com>
References: <20241024081023.1468951-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add HID Low level driver callbacks and hid probe function to register
QucikSPI as a HID driver, and external touch device as a HID device.

Co-developed-by: Xinpeng Sun <xinpeng.sun@intel.com>
Signed-off-by: Xinpeng Sun <xinpeng.sun@intel.com>
Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-thc-hid/Makefile            |   1 +
 .../intel-quickspi/quickspi-dev.h             |  11 ++
 .../intel-quickspi/quickspi-hid.c             | 142 ++++++++++++++++++
 .../intel-quickspi/quickspi-hid.h             |  14 ++
 include/linux/hid-over-spi.h                  |  37 +++++
 5 files changed, 205 insertions(+)
 create mode 100644 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h
 create mode 100644 include/linux/hid-over-spi.h

diff --git a/drivers/hid/intel-thc-hid/Makefile b/drivers/hid/intel-thc-hid/Makefile
index 7669739a39b7..4dd9e815021d 100644
--- a/drivers/hid/intel-thc-hid/Makefile
+++ b/drivers/hid/intel-thc-hid/Makefile
@@ -11,5 +11,6 @@ intel-thc-objs += intel-thc/intel-thc-dma.o
 
 obj-$(CONFIG_INTEL_QUICKSPI) += intel-quickspi.o
 intel-quickspi-objs += intel-quickspi/pci-quickspi.o
+intel-quickspi-objs += intel-quickspi/quickspi-hid.o
 
 ccflags-y += -I $(src)/intel-thc
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index cdd1e647e68c..4699922c1c9b 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -4,6 +4,8 @@
 #ifndef _QUICKSPI_DEV_H_
 #define _QUICKSPI_DEV_H_
 
+#include <linux/hid-over-spi.h>
+
 #define PCI_DEVICE_ID_INTEL_THC_MTL_DEVICE_ID_SPI_PORT1	0x7E49
 #define PCI_DEVICE_ID_INTEL_THC_MTL_DEVICE_ID_SPI_PORT2	0x7E4B
 #define PCI_DEVICE_ID_INTEL_THC_LNL_DEVICE_ID_SPI_PORT1	0xA849
@@ -34,24 +36,33 @@ struct quickspi_driver_data {
 struct device;
 struct pci_dev;
 struct thc_device;
+struct hid_device;
 
 /**
  * struct quickspi_device -  THC QuickSpi device struct
  * @dev: point to kernel device
  * @pdev: point to PCI device
  * @thc_hw: point to THC device
+ * @hid_dev: point to hid device
  * @driver_data: point to quickspi specific driver data
  * @state: THC SPI device state
  * @mem_addr: MMIO memory address
+ * @dev_desc: device descriptor for HIDSPI protocol
+ * @report_descriptor: store a copy of device report descriptor
  */
 struct quickspi_device {
 	struct device *dev;
 	struct pci_dev *pdev;
 	struct thc_device *thc_hw;
+	struct hid_device *hid_dev;
 	struct quickspi_driver_data *driver_data;
 	enum quickspi_dev_state state;
 
 	void __iomem *mem_addr;
+
+	struct hidspi_dev_descriptor dev_desc;
+
+	u8 *report_descriptor;
 };
 
 #endif /* _QUICKSPI_DEV_H_ */
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
new file mode 100644
index 000000000000..eae53a749a38
--- /dev/null
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024 Intel Corporation */
+
+#include <linux/hid.h>
+#include <linux/input.h>
+
+#include "quickspi-dev.h"
+#include "quickspi-hid.h"
+
+/**
+ * quickspi_hid_parse() - HID core parse() callback
+ *
+ * @hid: HID device instance
+ *
+ * This function gets called during call to hid_add_device
+ *
+ * Return: 0 on success and non zero on error.
+ */
+static int quickspi_hid_parse(struct hid_device *hid)
+{
+	struct quickspi_device *qsdev = hid->driver_data;
+
+	if (qsdev->report_descriptor)
+		return hid_parse_report(hid, qsdev->report_descriptor,
+					le16_to_cpu(qsdev->dev_desc.rep_desc_len));
+
+	dev_err(qsdev->dev, "invalid report descriptor\n");
+	return -EINVAL;
+}
+
+static int quickspi_hid_start(struct hid_device *hid)
+{
+	return 0;
+}
+
+static void quickspi_hid_stop(struct hid_device *hid)
+{
+}
+
+static int quickspi_hid_open(struct hid_device *hid)
+{
+	return 0;
+}
+
+static void quickspi_hid_close(struct hid_device *hid)
+{
+}
+
+static int quickspi_hid_raw_request(struct hid_device *hid,
+				    unsigned char reportnum,
+				    __u8 *buf, size_t len,
+				    unsigned char rtype, int reqtype)
+{
+	return 0;
+}
+
+static int quickspi_hid_power(struct hid_device *hid, int lvl)
+{
+	return 0;
+}
+
+static struct hid_ll_driver quickspi_hid_ll_driver = {
+	.parse = quickspi_hid_parse,
+	.start = quickspi_hid_start,
+	.stop = quickspi_hid_stop,
+	.open = quickspi_hid_open,
+	.close = quickspi_hid_close,
+	.power = quickspi_hid_power,
+	.raw_request = quickspi_hid_raw_request,
+};
+
+/**
+ * quickspi_hid_probe() - Register HID low level driver
+ *
+ * @qsdev: point to quickspi device
+ *
+ * This function is used to allocate and add HID device.
+ *
+ * Return: 0 on success, non zero on error.
+ */
+int quickspi_hid_probe(struct quickspi_device *qsdev)
+{
+	struct hid_device *hid;
+	int ret;
+
+	hid = hid_allocate_device();
+	if (IS_ERR(hid))
+		return PTR_ERR(hid);
+
+	hid->ll_driver = &quickspi_hid_ll_driver;
+	hid->bus = BUS_PCI;
+	hid->dev.parent = qsdev->dev;
+	hid->driver_data = qsdev;
+	hid->version = le16_to_cpu(qsdev->dev_desc.version_id);
+	hid->vendor = le16_to_cpu(qsdev->dev_desc.vendor_id);
+	hid->product = le16_to_cpu(qsdev->dev_desc.product_id);
+	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X", "quickspi-hid",
+		 hid->vendor, hid->product);
+
+	ret = hid_add_device(hid);
+	if (ret) {
+		hid_destroy_device(hid);
+		return ret;
+	}
+
+	qsdev->hid_dev = hid;
+
+	return 0;
+}
+
+/**
+ * quickspi_hid_remove() - Destroy HID device
+ *
+ * @qsdev: point to quickspi device
+ *
+ * Return: 0 on success, non zero on error.
+ */
+void quickspi_hid_remove(struct quickspi_device *qsdev)
+{
+	hid_destroy_device(qsdev->hid_dev);
+}
+
+/**
+ * quickspi_hid_send_report() - Send HID input report data to HID core
+ *
+ * @qsdev: point to quickspi device
+ * @data: point to input report data buffer
+ * @data_len: the length of input report data
+ *
+ * Return: 0 on success, non zero on error.
+ */
+int quickspi_hid_send_report(struct quickspi_device *qsdev,
+			     void *data, size_t data_len)
+{
+	int ret;
+
+	ret = hid_input_report(qsdev->hid_dev, HID_INPUT_REPORT, data, data_len, 1);
+	if (ret)
+		dev_err(qsdev->dev, "Failed to send HID input report, ret = %d.\n", ret);
+
+	return ret;
+}
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h
new file mode 100644
index 000000000000..f640fa876a40
--- /dev/null
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024 Intel Corporation */
+
+#ifndef _QUICKSPI_HID_H_
+#define _QUICKSPI_HID_H_
+
+struct quickspi_device;
+
+int quickspi_hid_send_report(struct quickspi_device *qsdev,
+			     void *data, size_t data_size);
+int quickspi_hid_probe(struct quickspi_device *qsdev);
+void quickspi_hid_remove(struct quickspi_device *qsdev);
+
+#endif /* _QUICKSPI_HID_H_ */
diff --git a/include/linux/hid-over-spi.h b/include/linux/hid-over-spi.h
new file mode 100644
index 000000000000..ddbe41c5d8fd
--- /dev/null
+++ b/include/linux/hid-over-spi.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2024 Intel Corporation */
+
+#ifndef _HID_OVER_SPI_H_
+#define _HID_OVER_SPI_H_
+
+/**
+ * struct hidspi_dev_descriptor - HIDSPI device descriptor definition
+ * @dev_desc_len: The length of the complete device descriptor, fixed to 0x18 (24).
+ * @bcd_ver: The version number of the HIDSPI protocol supported.
+ *           In binary coded decimal (BCD) format. Must be fixed to 0x0300.
+ * @rep_desc_len: The length of the report descriptor
+ * @max_input_len: The length of the largest possible HID input (or feature) report
+ * @max_output_len: The length of the largest output (or feature) report
+ * @max_frag_len: The length of the largest fragment, where a fragment represents
+ *                the body of an input report.
+ * @vendor_id: Device manufacturers vendor ID
+ * @product_id: Device unique model/product ID
+ * @version_id: Device’s unique version
+ * @flags: Specify flags for the device’s operation
+ * @reserved: Reserved and should be 0
+ */
+struct hidspi_dev_descriptor {
+	__le16 dev_desc_len;
+	__le16 bcd_ver;
+	__le16 rep_desc_len;
+	__le16 max_input_len;
+	__le16 max_output_len;
+	__le16 max_frag_len;
+	__le16 vendor_id;
+	__le16 product_id;
+	__le16 version_id;
+	__le16 flags;
+	__le32 reserved;
+};
+
+#endif /* _HID_OVER_SPI_H_ */
-- 
2.40.1


