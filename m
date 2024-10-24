Return-Path: <linux-kernel+bounces-379448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05909ADEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59272286BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1543A1D0E11;
	Thu, 24 Oct 2024 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkGfUq5K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2424E1CF2A4;
	Thu, 24 Oct 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757517; cv=none; b=Wcyqjr7dUFHMr8z8t8Yy6fJ93ceD5EOakxlDMvAHOfAGgV9W4M6aS9y107V6skKL1qx0XAQKolqIotWTi4HoTSapx/SrD/uFMKY1KpO98ry948jnj5q0xRIBpKGwS8x5bt77J+wBkBQI8BhxJtMjYrc2PNEHC96RNIzL5jRkhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757517; c=relaxed/simple;
	bh=jKcTbpu0yx48Oo7kn+lKZ4Peipb412R0jRYzrX+F444=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWIeJtSOiqTOVXaaSSnOWwj85L2nlq2HvUlUg4jO1FrCx85UneHhOPvbHyioDUoYnnFymHCBM+YYAVwOdxMA6MVyzbabBWFXq+IDfQsQANXWR3RE/hRk9g3yeQ0wny21VnaWlapgIDhda6TAdpxWdqmfpr0nLie6acqe9FKqDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkGfUq5K; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729757515; x=1761293515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jKcTbpu0yx48Oo7kn+lKZ4Peipb412R0jRYzrX+F444=;
  b=NkGfUq5K5IIv7Tx1yatHEpbkNNvMWBytF2IErNmV0dQzsG3A6NDlgrbP
   DBTlA8x9ajusCVWUoFb/fKVKQr5CSaKY0aFQbNN6tTIMRoD3hAbbpUA/k
   AKZzOJHJ8M2lD/ckuU5zj1ahD92uqF9RVLF/mqJ+7TBRtAFtw3Ye8UFQ0
   h6aEmD0rTeBJkMPL0/Eh7tFhRhulKRaRsr6tr3JQMI2ZvxYVTMxO6rbl8
   tZPv6yQorlRUNi4tHV81vYLTKxHz0QR8rFi4erQunWHhjo2ORYHyfcN93
   giaZjoLa1RfR1b2GPwsk4DNDG9HYfBH5hllt4Kfb6BWSDhTd/C+smyg7j
   A==;
X-CSE-ConnectionGUID: QJisZj34S2yNFPFTiAgYsA==
X-CSE-MsgGUID: 0MF+zaX3Qi20rkq1Thm+kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29501157"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29501157"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 01:11:53 -0700
X-CSE-ConnectionGUID: AXmFCrsWRz6AIpbbNtfbiA==
X-CSE-MsgGUID: JCY5s+5UQviTcpUAXtPy2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80691056"
Received: from shsensorbuild.sh.intel.com ([10.239.133.18])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2024 01:11:50 -0700
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
Subject: [PATCH v1 20/22] HID: intel-thc-hid: intel-quicki2c: Add HIDI2C protocol implementation
Date: Thu, 24 Oct 2024 16:10:21 +0800
Message-Id: <20241024081023.1468951-21-even.xu@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241024081023.1468951-1-even.xu@intel.com>
References: <20241024081023.1468951-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel QuickI2C driver uses THC hardware to accelerate HID over I2C
(HIDI2C) protocol flow.

This patch implements all data flows described in HID over I2C protocol
SPEC by using THC hardware layer APIs.

HID over I2C SPEC:
https://learn.microsoft.com/en-us/previous-versions/windows/hardware/design/dn642101(v=vs.85)

Co-developed-by: Xinpeng Sun <xinpeng.sun@intel.com>
Signed-off-by: Xinpeng Sun <xinpeng.sun@intel.com>
Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-thc-hid/Makefile            |   1 +
 .../intel-quicki2c/quicki2c-dev.h             |   6 +
 .../intel-quicki2c/quicki2c-hid.c             |  18 +-
 .../intel-quicki2c/quicki2c-protocol.c        | 192 ++++++++++++++++++
 .../intel-quicki2c/quicki2c-protocol.h        |  19 ++
 include/linux/hid-over-i2c.h                  |  73 +++++++
 6 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.h

diff --git a/drivers/hid/intel-thc-hid/Makefile b/drivers/hid/intel-thc-hid/Makefile
index 91bde6d6aa14..6f762d87af07 100644
--- a/drivers/hid/intel-thc-hid/Makefile
+++ b/drivers/hid/intel-thc-hid/Makefile
@@ -17,5 +17,6 @@ intel-quickspi-objs += intel-quickspi/quickspi-protocol.o
 obj-$(CONFIG_INTEL_QUICKI2C) += intel-quicki2c.o
 intel-quicki2c-objs += intel-quicki2c/pci-quicki2c.o
 intel-quicki2c-objs += intel-quicki2c/quicki2c-hid.o
+intel-quicki2c-objs += intel-quicki2c/quicki2c-protocol.o
 
 ccflags-y += -I $(src)/intel-thc
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
index 59907e59b96f..043126803997 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h
@@ -134,6 +134,9 @@ struct acpi_device;
  * @i2c_clock_hcnt: I2C CLK high period time (unit in cycle count)
  * @i2c_clock_lcnt: I2C CLK low period time (unit in cycle count)
  * @report_descriptor: store a copy of device report descriptor
+ * @input_buf: store a copy of latest input report data
+ * @report_buf: store a copy of latest input/output report packet from set/get feature
+ * @report_len: the length of input/output report packet
  */
 struct quicki2c_device {
 	struct device *dev;
@@ -157,6 +160,9 @@ struct quicki2c_device {
 	u32 i2c_clock_lcnt;
 
 	u8 *report_descriptor;
+	u8 *input_buf;
+	u8 *report_buf;
+	u32 report_len;
 };
 
 #endif /* _QUICKI2C_DEV_H_ */
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
index 4236603f3f76..e8e6f10b7952 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
@@ -6,6 +6,7 @@
 
 #include "quicki2c-dev.h"
 #include "quicki2c-hid.h"
+#include "quicki2c-protocol.h"
 
 /**
  * quicki2c_hid_parse() - HID core parse() callback
@@ -51,7 +52,22 @@ static int quicki2c_hid_raw_request(struct hid_device *hid,
 				    __u8 *buf, size_t len,
 				    unsigned char rtype, int reqtype)
 {
-	return 0;
+	struct quicki2c_device *qcdev = hid->driver_data;
+	int ret = 0;
+
+	switch (reqtype) {
+	case HID_REQ_GET_REPORT:
+		ret = quicki2c_get_report(qcdev, rtype, reportnum, buf, len);
+		break;
+	case HID_REQ_SET_REPORT:
+		ret = quicki2c_set_report(qcdev, rtype, reportnum, buf, len);
+		break;
+	default:
+		dev_err(qcdev->dev, "Not supported request type %d\n", reqtype);
+		break;
+	}
+
+	return ret;
 }
 
 static int quicki2c_hid_power(struct hid_device *hid, int lvl)
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
new file mode 100644
index 000000000000..6e6463abe894
--- /dev/null
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.c
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2024 Intel Corporation */
+
+#include <linux/bitfield.h>
+#include <linux/hid.h>
+#include <linux/hid-over-i2c.h>
+
+#include "intel-thc-dev.h"
+#include "intel-thc-dma.h"
+
+#include "quicki2c-dev.h"
+#include "quicki2c-hid.h"
+#include "quicki2c-protocol.h"
+
+static int quicki2c_init_write_buf(struct quicki2c_device *qcdev, u32 cmd, int cmd_len,
+				   bool append_data_reg, u8 *data, int data_len,
+				   u8 *write_buf, int write_buf_len)
+{
+	int buf_len, offset = 0;
+
+	buf_len = HIDI2C_REG_LEN + cmd_len;
+
+	if (append_data_reg)
+		buf_len += HIDI2C_REG_LEN;
+
+	if (data && data_len)
+		buf_len += data_len;
+
+	if (buf_len > write_buf_len)
+		return -EINVAL;
+
+	memcpy(write_buf, &qcdev->dev_desc.cmd_reg, HIDI2C_REG_LEN);
+	offset += HIDI2C_REG_LEN;
+	memcpy(write_buf + offset, &cmd, cmd_len);
+	offset += cmd_len;
+
+	if (append_data_reg) {
+		memcpy(write_buf + offset, &qcdev->dev_desc.data_reg, HIDI2C_REG_LEN);
+		offset += HIDI2C_REG_LEN;
+	}
+
+	if (data && data_len)
+		memcpy(write_buf + offset, data, data_len);
+
+	return buf_len;
+}
+
+static int quicki2c_encode_cmd(struct quicki2c_device *qcdev, u32 *cmd_buf,
+			       u8 opcode, u8 report_type, u8 report_id)
+{
+	int cmd_len;
+
+	*cmd_buf = FIELD_PREP(HIDI2C_CMD_OPCODE, opcode) |
+		   FIELD_PREP(HIDI2C_CMD_REPORT_TYPE, report_type);
+
+	if (report_id < HIDI2C_CMD_MAX_RI) {
+		*cmd_buf |= FIELD_PREP(HIDI2C_CMD_REPORT_ID, report_id);
+		cmd_len = HIDI2C_CMD_LEN;
+	} else {
+		*cmd_buf |= FIELD_PREP(HIDI2C_CMD_REPORT_ID, HIDI2C_CMD_MAX_RI) |
+			    FIELD_PREP(HIDI2C_CMD_3RD_BYTE, report_id);
+		cmd_len = HIDI2C_CMD_LEN_OPT;
+	}
+
+	return cmd_len;
+}
+
+static int write_cmd_to_txdma(struct quicki2c_device *qcdev, int opcode,
+			      int report_type, int report_id, u8 *buf, int buf_len)
+{
+	size_t write_buf_len;
+	int cmd_len, ret;
+	u32 cmd;
+
+	cmd_len = quicki2c_encode_cmd(qcdev, &cmd, opcode, report_type, report_id);
+
+	ret = quicki2c_init_write_buf(qcdev, cmd, cmd_len, buf ? true : false, buf,
+				      buf_len, qcdev->report_buf, qcdev->report_len);
+	if (ret < 0)
+		return ret;
+
+	write_buf_len = ret;
+
+	return thc_dma_write(qcdev->thc_hw, qcdev->report_buf, write_buf_len);
+}
+
+int quicki2c_set_power(struct quicki2c_device *qcdev, enum hidi2c_power_state power_state)
+{
+	return write_cmd_to_txdma(qcdev, HIDI2C_SET_POWER, HIDI2C_RESERVED, power_state, NULL, 0);
+}
+
+int quicki2c_get_device_descriptor(struct quicki2c_device *qcdev)
+{
+	u32 read_len = 0;
+	int ret;
+
+	ret = thc_tic_pio_write_and_read(qcdev->thc_hw, qcdev->hid_desc_addr,
+					 HIDI2C_REG_LEN, NULL, HIDI2C_DEV_DESC_LEN,
+					 &read_len, (u32 *)&qcdev->dev_desc);
+	if (ret || HIDI2C_DEV_DESC_LEN != read_len) {
+		dev_err_once(qcdev->dev, "Get device descriptor failed, ret %d, read len %u\n",
+			     ret, read_len);
+		return -EIO;
+	}
+
+	if (le16_to_cpu(qcdev->dev_desc.bcd_ver) != HIDI2C_HID_DESC_BCDVERSION)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+int quicki2c_get_report_descriptor(struct quicki2c_device *qcdev)
+{
+	u16 desc_reg = le16_to_cpu(qcdev->dev_desc.report_desc_reg);
+	size_t read_len = le16_to_cpu(qcdev->dev_desc.report_desc_len);
+	u32 prd_len = read_len;
+
+	return thc_swdma_read(qcdev->thc_hw, (u8 *)&desc_reg, HIDI2C_REG_LEN,
+			      &prd_len, qcdev->report_descriptor, &read_len);
+}
+
+int quicki2c_get_report(struct quicki2c_device *qcdev, u8 report_type,
+			unsigned int reportnum, void *buf, u32 buf_len)
+{
+	struct hidi2c_report_packet *rpt;
+	size_t write_buf_len, read_len = 0;
+	int cmd_len, rep_type;
+	u32 cmd;
+	int ret;
+
+	if (report_type == HID_INPUT_REPORT) {
+		rep_type = HIDI2C_INPUT;
+	} else if (report_type == HID_FEATURE_REPORT) {
+		rep_type = HIDI2C_FEATURE;
+	} else {
+		dev_err(qcdev->dev, "Unsupported report type for GET REPORT: %d\n", report_type);
+		return -EINVAL;
+	}
+
+	cmd_len = quicki2c_encode_cmd(qcdev, &cmd, HIDI2C_GET_REPORT, rep_type, reportnum);
+
+	ret = quicki2c_init_write_buf(qcdev, cmd, cmd_len, true, NULL, 0,
+				      qcdev->report_buf, qcdev->report_len);
+	if (ret < 0)
+		return ret;
+
+	write_buf_len = ret;
+
+	rpt = (struct hidi2c_report_packet *)qcdev->input_buf;
+
+	ret = thc_swdma_read(qcdev->thc_hw, qcdev->report_buf, write_buf_len,
+			     NULL, rpt, &read_len);
+	if (ret) {
+		dev_err_once(qcdev->dev, "Get report failed, ret %d, read len (%zu vs %d)\n",
+			     ret, read_len, buf_len);
+		return ret;
+	}
+
+	if (HIDI2C_DATA_LEN(le16_to_cpu(rpt->len)) != buf_len || rpt->data[0] != reportnum) {
+		dev_err_once(qcdev->dev, "Invalid packet, len (%d vs %d) report id (%d vs %d)\n",
+			     le16_to_cpu(rpt->len), buf_len, rpt->data[0], reportnum);
+		return -EINVAL;
+	}
+
+	memcpy(buf, rpt->data, buf_len);
+
+	return buf_len;
+}
+
+int quicki2c_set_report(struct quicki2c_device *qcdev, u8 report_type,
+			unsigned int reportnum, void *buf, u32 buf_len)
+{
+	int rep_type;
+	int ret;
+
+	if (report_type == HID_OUTPUT_REPORT) {
+		rep_type = HIDI2C_OUTPUT;
+	} else if (report_type == HID_FEATURE_REPORT) {
+		rep_type = HIDI2C_FEATURE;
+	} else {
+		dev_err(qcdev->dev, "Unsupported report type for SET REPORT: %d\n", report_type);
+		return -EINVAL;
+	}
+
+	ret = write_cmd_to_txdma(qcdev, HIDI2C_SET_REPORT, rep_type, reportnum, buf, buf_len);
+	if (ret) {
+		dev_err_once(qcdev->dev, "Set Report failed, ret %d\n", ret);
+		return ret;
+	}
+
+	return buf_len;
+}
diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.h b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.h
new file mode 100644
index 000000000000..3a0d66c7d9ef
--- /dev/null
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-protocol.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024 Intel Corporation */
+
+#ifndef _QUICKI2C_PROTOCOL_H_
+#define _QUICKI2C_PROTOCOL_H_
+
+#include <linux/hid-over-i2c.h>
+
+struct quicki2c_device;
+
+int quicki2c_set_power(struct quicki2c_device *qcdev, enum hidi2c_power_state power_state);
+int quicki2c_get_report(struct quicki2c_device *qcdev, u8 report_type,
+			unsigned int reportnum, void *buf, u32 buf_len);
+int quicki2c_set_report(struct quicki2c_device *qcdev, u8 report_type,
+			unsigned int reportnum, void *buf, u32 buf_len);
+int quicki2c_get_device_descriptor(struct quicki2c_device *qcdev);
+int quicki2c_get_report_descriptor(struct quicki2c_device *qcdev);
+
+#endif /* _QUICKI2C_PROTOCOL_H_ */
diff --git a/include/linux/hid-over-i2c.h b/include/linux/hid-over-i2c.h
index b70626723a38..3b1a0208a6b8 100644
--- a/include/linux/hid-over-i2c.h
+++ b/include/linux/hid-over-i2c.h
@@ -1,9 +1,80 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright 2024 Intel Corporation */
 
+#include <linux/bits.h>
+
 #ifndef _HID_OVER_I2C_H_
 #define _HID_OVER_I2C_H_
 
+#define HIDI2C_REG_LEN		sizeof(__le16)
+
+/* Input report type definition in HIDI2C protocol */
+enum hidi2c_report_type {
+	HIDI2C_RESERVED = 0,
+	HIDI2C_INPUT,
+	HIDI2C_OUTPUT,
+	HIDI2C_FEATURE,
+};
+
+/* Power state type definition in HIDI2C protocol */
+enum hidi2c_power_state {
+	HIDI2C_ON,
+	HIDI2C_SLEEP,
+};
+
+/* Opcode type definition in HIDI2C protocol */
+enum hidi2c_opcode {
+	HIDI2C_RESET = 1,
+	HIDI2C_GET_REPORT,
+	HIDI2C_SET_REPORT,
+	HIDI2C_GET_IDLE,
+	HIDI2C_SET_IDLE,
+	HIDI2C_GET_PROTOCOL,
+	HIDI2C_SET_PROTOCOL,
+	HIDI2C_SET_POWER,
+};
+
+/**
+ * struct hidi2c_report_packet - Report packet definition in HIDI2C protocol
+ * @len: data field length
+ * @data: HIDI2C report packet data
+ */
+struct hidi2c_report_packet {
+	__le16 len;
+	u8 data[];
+} __packed;
+
+#define HIDI2C_LENGTH_LEN	sizeof(__le16)
+
+#define HIDI2C_PACKET_LEN(data_len)	((data_len) + HIDI2C_LENGTH_LEN)
+#define HIDI2C_DATA_LEN(pkt_len)	((pkt_len) - HIDI2C_LENGTH_LEN)
+
+#define HIDI2C_CMD_MAX_RI	0x0F
+
+/**
+ * HIDI2C command data packet - Command packet definition in HIDI2C protocol
+ * @report_id:		[0:3] report id (<15) for features or output reports
+ * @report_type:	[4:5] indicate report type, reference to hidi2c_report_type
+ * @reserved0:		[6:7] reserved bits
+ * @opcode:		[8:11] command operation code, reference to hidi2c_opcode
+ * @reserved1:		[12:15] reserved bits
+ * @report_id_optional: [23:16] appended 3rd byte.
+ *                      If the report_id in the low byte is set to the
+ *                      sentinel value (HIDI2C_CMD_MAX_RI), then this
+ *                      optional third byte represents the report id (>=15)
+ *                      Otherwise, not this 3rd byte.
+ */
+
+#define HIDI2C_CMD_LEN			sizeof(__le16)
+#define HIDI2C_CMD_LEN_OPT		(sizeof(__le16) + 1)
+#define HIDI2C_CMD_REPORT_ID		GENMASK(3, 0)
+#define HIDI2C_CMD_REPORT_TYPE		GENMASK(5, 4)
+#define HIDI2C_CMD_OPCODE		GENMASK(11, 8)
+#define HIDI2C_CMD_OPCODE		GENMASK(11, 8)
+#define HIDI2C_CMD_3RD_BYTE		GENMASK(23, 16)
+
+#define HIDI2C_HID_DESC_BCDVERSION	0x100
+
 /**
  * struct hidi2c_dev_descriptor - HIDI2C device descriptor definition
  * @dev_desc_len: The length of the complete device descriptor, fixed to 0x1E (30).
@@ -41,4 +112,6 @@ struct hidi2c_dev_descriptor {
 	__le16 reserved1;
 } __packed;
 
+#define HIDI2C_DEV_DESC_LEN		sizeof(struct hidi2c_dev_descriptor)
+
 #endif /* _HID_OVER_I2C_H_ */
-- 
2.40.1


