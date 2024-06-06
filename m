Return-Path: <linux-kernel+bounces-203493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 455A68FDC10
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9391F25196
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E767F10A11;
	Thu,  6 Jun 2024 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7mVVapB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818F19D884;
	Thu,  6 Jun 2024 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717636585; cv=none; b=aJsxvegyo+bTQnqhxilUbHeQ2l+YHOD4hPZA4TxKYk3xe+rvR6hKxVQwhtkhr1n+rmNDji8YaTtLCdkNm9KX7vvqxO6meYjNmKm2rStAYMEmm/yFEWccPqVVf8F3zAeGUxrzfEHWrvKzU6sCyZgtlVrNHwfyIMVSw+tZPy1loPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717636585; c=relaxed/simple;
	bh=UPfw2rQiVEjw+rnno9eCBwxveOieh6/KEE+rEF9Oufo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Tf9os8EepXBIsdEVSY8nSDCGJWDQhPC43Gta15XHnUiWjZhcKmFKSnnZvNfkO1cEKS5WaPmmf0BkM6xhPGiFjA+33HOcaxL52VZT29EJ+yqPnjKMeH5j3Wxo7KGOJzcdVtq7gNUDzYvfociIISY58oMbLijS57vRYQu0dC0Yz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7mVVapB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717636583; x=1749172583;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UPfw2rQiVEjw+rnno9eCBwxveOieh6/KEE+rEF9Oufo=;
  b=T7mVVapByKH39/70pq6n0Pv2Up2OZJAfLnqYWL55szZO0qUiEGxD2rbO
   CNxFtL7lSsPc98JaMXSYeBa7QiD/jLCNhpT0nIJjjP+u6jVYsLOCjP5iI
   KojceaaFXzJApOCJbFd86QsVMlD/g5MXLgfkluM2reFiZLDPpl+CwtuMQ
   1MMGRKuqS1US2/CuhNyWgcTNVM2dIbHF0DOIZkyaaFMrhFm0HXSMpo4Xb
   6W8mm4K0dW+GXeDyl+ptQWEJdAGS0UaskYhFW3Cz/DcGmeYu1C+0e7IeU
   XtdawxvXBQZ4oA4jQCNqv4iyhoOfdfI2xk6JgZe2m9t48a2M3ZCKa6fbM
   Q==;
X-CSE-ConnectionGUID: m40XUyVwQcCVGwx8GVor1A==
X-CSE-MsgGUID: KZbnRLWIRmSqePRWwXxs7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14084173"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14084173"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 18:16:22 -0700
X-CSE-ConnectionGUID: W8UpD3lcSGmXYGZSNuk50w==
X-CSE-MsgGUID: R90FU2/NTc2xGMgMFCtXLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="37889782"
Received: from mhlooi-mobl1.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.212.212.220])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 18:16:22 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: linux-doc@vger.kernel.org,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH V3 1/3] platform/x86/intel/sdsi: Add ioctl SPDM transport
Date: Wed,  5 Jun 2024 18:16:15 -0700
Message-Id: <20240606011617.557264-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel On Demand adds attestation and firmware measurement retrieval
services through use of the protocols defined the Security Protocols and
Data Measurement (SPDM) specification. SPDM messages exchanges are used to
authenticate On Demand hardware and to retrieve signed measurements of the
NVRAM state used to track feature provisioning and the NVRAM state used for
metering services. These allow software to verify the authenticity of the
On Demand hardware as well as the integrity of the reported silicon
configuration.

Add an ioctl interface for sending SPDM messages through the On Demand
mailbox. Provides commands to get a list of SPDM enabled devices, get the
message size limits for SPDM Requesters and Responders, and perform an SPDM
message exchange.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.0.1.pdf [1]
---
V3
   - Use %zu format for size_t
   - Simplify return in sdsi_spdm_ioctl()

V2
   - Move size < 4 check into sdsi_spdm_exchange() and add comment
     clarifying return values of that function.
   - Use SZ_4K and add helpers
   - Use devm_kasprintf()
   - Remove unnecessary parens
   - Use --attest for long option

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 drivers/platform/x86/intel/sdsi.c             | 207 +++++++++++++++++-
 include/uapi/linux/intel_sdsi.h               |  81 +++++++
 4 files changed, 289 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/intel_sdsi.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a141e8e65c5d..17a0b4a90bac 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -384,6 +384,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:mathieu.desnoyers@efficios.com>
 0xF8  all    arch/x86/include/uapi/asm/amd_hsmp.h                    AMD HSMP EPYC system management interface driver
                                                                      <mailto:nchatrad@amd.com>
+0xFC  all    linux/intel_sdsi.h
 0xFD  all    linux/dm-ioctl.h
 0xFE  all    linux/isst_if.h
 ====  =====  ======================================================= ================================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 8754ac2c259d..df5adb49ccc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11343,6 +11343,7 @@ INTEL SDSI DRIVER
 M:	David E. Box <david.e.box@linux.intel.com>
 S:	Supported
 F:	drivers/platform/x86/intel/sdsi.c
+F:	include/uapi/linux/intel_sdsi.h
 F:	tools/arch/x86/intel_sdsi/
 F:	tools/testing/selftests/drivers/sdsi/
 
diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 277e4f4b20ac..9834301052c4 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -11,9 +11,12 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/iopoll.h>
+#include <linux/intel_sdsi.h>
 #include <linux/kernel.h>
+#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/pci.h>
@@ -42,6 +45,7 @@
 
 #define SDSI_ENABLED_FEATURES_OFFSET	16
 #define SDSI_FEATURE_SDSI		BIT(3)
+#define SDSI_FEATURE_ATTESTATION	BIT(12)
 #define SDSI_FEATURE_METERING		BIT(26)
 
 #define SDSI_SOCKET_ID_OFFSET		64
@@ -91,6 +95,7 @@ enum sdsi_command {
 	SDSI_CMD_PROVISION_CAP		= 0x0008,
 	SDSI_CMD_READ_STATE		= 0x0010,
 	SDSI_CMD_READ_METER		= 0x0014,
+	SDSI_CMD_ATTESTATION		= 0x1012,
 };
 
 struct sdsi_mbox_info {
@@ -109,12 +114,14 @@ struct disc_table {
 struct sdsi_priv {
 	struct mutex		mb_lock;	/* Mailbox access lock */
 	struct device		*dev;
+	struct miscdevice	miscdev;
 	void __iomem		*control_addr;
 	void __iomem		*mbox_addr;
 	void __iomem		*regs_addr;
 	int			control_size;
 	int			maibox_size;
 	int			registers_size;
+	int			id;
 	u32			guid;
 	u32			features;
 };
@@ -582,6 +589,97 @@ static const struct attribute_group sdsi_group = {
 };
 __ATTRIBUTE_GROUPS(sdsi);
 
+/*
+ * SPDM transport
+ * Returns size of the response message or an error code on failure.
+ */
+static int sdsi_spdm_exchange(void *private, const void *request,
+			      size_t request_sz, void *response,
+			      size_t response_sz)
+{
+	struct sdsi_priv *priv = private;
+	struct sdsi_mbox_info info = {};
+	size_t spdm_msg_size, size;
+	int ret;
+
+	/*
+	 * For the attestation command, the mailbox write size is the sum of:
+	 *     Size of the SPDM request payload, padded for qword alignment
+	 *     8 bytes for the mailbox command
+	 *     8 bytes for the actual (non-padded) size of the SPDM request
+	 */
+	if (request_sz > SDSI_SIZE_WRITE_MSG - 2 * sizeof(u64))
+		return -EOVERFLOW;
+
+	info.size = round_up(request_sz, sizeof(u64)) + 2 * sizeof(u64);
+
+	u64 *payload __free(kfree) = kzalloc(info.size, GFP_KERNEL);
+	if (!payload)
+		return -ENOMEM;
+
+	memcpy(payload, request, request_sz);
+
+	/* The non-padded SPDM payload size is the 2nd-to-last qword */
+	payload[(info.size / sizeof(u64)) - 2] = request_sz;
+
+	/* Attestation mailbox command is the last qword of payload buffer */
+	payload[(info.size / sizeof(u64)) - 1] = SDSI_CMD_ATTESTATION;
+
+	info.payload = payload;
+	info.buffer = response;
+
+	ret = mutex_lock_interruptible(&priv->mb_lock);
+	if (ret)
+		return ret;
+	ret = sdsi_mbox_write(priv, &info, &size);
+	mutex_unlock(&priv->mb_lock);
+
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The read size is the sum of:
+	 *     Size of the SPDM response payload, padded for qword alignment
+	 *     8 bytes for the actual (non-padded) size of the SPDM payload
+	 */
+
+	if (size < sizeof(u64)) {
+		dev_err(priv->dev,
+			"Attestation error: Mailbox reply size, %zu, too small\n",
+			size);
+		return -EPROTO;
+	}
+
+	if (!IS_ALIGNED(size, sizeof(u64))) {
+		dev_err(priv->dev,
+			"Attestation error: Mailbox reply size, %zu, is not aligned\n",
+			size);
+		return -EPROTO;
+	}
+
+	/*
+	 * Get the SPDM response size from the last QWORD and check it fits
+	 * with no more than 7 bytes of padding
+	 */
+	spdm_msg_size = ((u64 *)info.buffer)[(size - sizeof(u64)) / sizeof(u64)];
+	if (!in_range(size - spdm_msg_size - sizeof(u64), 0, 8)) {
+		dev_err(priv->dev,
+			"Attestation error: Invalid SPDM response size, %zu\n",
+			spdm_msg_size);
+		return -EPROTO;
+	}
+
+	if (spdm_msg_size > response_sz || spdm_msg_size < SPDM_HEADER_SIZE) {
+		dev_err(priv->dev, "Attestation error: Expected response size %zu, got %zu\n",
+			response_sz, spdm_msg_size);
+		return -EOVERFLOW;
+	}
+
+	memcpy(response, info.buffer, spdm_msg_size);
+
+	return spdm_msg_size;
+}
+
 static int sdsi_get_layout(struct sdsi_priv *priv, struct disc_table *table)
 {
 	switch (table->guid) {
@@ -649,6 +747,89 @@ static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev *paren
 	return 0;
 }
 
+#define SDSI_SPDM_DRIVER_VERSION	1
+
+static int sdsi_spdm_get_info(struct sdsi_priv *priv,
+			      struct sdsi_spdm_info __user *argp)
+{
+	struct sdsi_spdm_info info;
+
+	info.driver_version = SDSI_SPDM_DRIVER_VERSION;
+	info.api_version = priv->guid;
+	info.dev_no = priv->id;
+	info.max_request_size = SDSI_SIZE_WRITE_MSG - 2 * sizeof(u64);
+	info.max_response_size = SDSI_SIZE_READ_MSG - sizeof(u64);
+
+	if (copy_to_user(argp, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int sdsi_spdm_do_command(struct sdsi_priv *priv,
+				struct sdsi_spdm_command __user *argp)
+{
+	u32 req_size, rsp_size;
+
+	if (get_user(req_size, &argp->size))
+		return -EFAULT;
+
+	if (req_size < 4 || req_size > sizeof(struct sdsi_spdm_message))
+		return -EINVAL;
+
+	struct sdsi_spdm_message *request __free(kfree) =
+		kmalloc(req_size, GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+
+	struct sdsi_spdm_command *response __free(kfree) =
+		kmalloc(SDSI_SIZE_READ_MSG, GFP_KERNEL);
+	if (!response)
+		return -ENOMEM;
+
+	if (copy_from_user(request, &argp->message, req_size))
+		return -EFAULT;
+
+	rsp_size = sdsi_spdm_exchange(priv, request, req_size, response,
+				      SDSI_SIZE_READ_MSG);
+	if (rsp_size < 0)
+		return rsp_size;
+
+	if (put_user(rsp_size, &argp->size))
+		return -EFAULT;
+
+	if (copy_to_user(&argp->message, response, rsp_size))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long sdsi_spdm_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct sdsi_priv *priv;
+
+	priv = container_of(file->private_data, struct sdsi_priv, miscdev);
+
+	switch (cmd) {
+	case SDSI_IF_SPDM_INFO:
+		return sdsi_spdm_get_info(priv,
+				(struct sdsi_spdm_info __user *)arg);
+	case SDSI_IF_SPDM_COMMAND:
+		return sdsi_spdm_do_command(priv,
+				(struct sdsi_spdm_command __user *)arg);
+	default:
+		break;
+	}
+
+	return -ENOTTY;
+}
+
+static const struct file_operations sdsi_spdm_ops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = sdsi_spdm_ioctl,
+};
+
 static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
 {
 	struct intel_vsec_device *intel_cap_dev = auxdev_to_ivdev(auxdev);
@@ -663,6 +844,7 @@ static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_de
 		return -ENOMEM;
 
 	priv->dev = &auxdev->dev;
+	priv->id = auxdev->id;
 	mutex_init(&priv->mb_lock);
 	auxiliary_set_drvdata(auxdev, priv);
 
@@ -686,9 +868,32 @@ static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_de
 	if (ret)
 		return ret;
 
+	/* Attestation miscdevice */
+	if (priv->features & SDSI_FEATURE_ATTESTATION) {
+		priv->miscdev.name = devm_kasprintf(&auxdev->dev, GFP_KERNEL,
+						    "isdsi%d", priv->id);
+		if (!priv->miscdev.name)
+			return -ENOMEM;
+
+		priv->miscdev.minor = MISC_DYNAMIC_MINOR;
+		priv->miscdev.fops = &sdsi_spdm_ops;
+
+		ret = misc_register(&priv->miscdev);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
+static void sdsi_remove(struct auxiliary_device *auxdev)
+{
+	struct sdsi_priv *priv = auxiliary_get_drvdata(auxdev);
+
+	if (priv->features & SDSI_FEATURE_ATTESTATION)
+		misc_deregister(&priv->miscdev);
+}
+
 static const struct auxiliary_device_id sdsi_aux_id_table[] = {
 	{ .name = "intel_vsec.sdsi" },
 	{}
@@ -701,7 +906,7 @@ static struct auxiliary_driver sdsi_aux_driver = {
 	},
 	.id_table	= sdsi_aux_id_table,
 	.probe		= sdsi_probe,
-	/* No remove. All resources are handled under devm */
+	.remove		= sdsi_remove,
 };
 module_auxiliary_driver(sdsi_aux_driver);
 
diff --git a/include/uapi/linux/intel_sdsi.h b/include/uapi/linux/intel_sdsi.h
new file mode 100644
index 000000000000..8e28764f4a98
--- /dev/null
+++ b/include/uapi/linux/intel_sdsi.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Intel On Demand (SDSi) Interface for SPDM based attestation.
+ * Copyright (c) 2019, Intel Corporation.
+ * All rights reserved.
+ *
+ * Author: David E. Box <david.e.box@linux.intel.com>
+ */
+
+#ifndef __SDSI_H
+#define __SDSI_H
+
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+/**
+ * struct sdsi_spdm_info - Define platform information
+ * @api_version:	Version of the firmware document, which this driver
+ *			can communicate
+ * @driver_version:	Driver version, which will help user to send right
+ *			commands. Even if the firmware is capable, driver may
+ *			not be ready
+ * @dev_no:		Returns the auxiliary device number the corresponding
+ *			sdsi instance
+ * @max_request_size:	Returns the maximum allowed size for SPDM request
+ *			messages
+ * @max_response_size:	Returns the maximum size of an SPDM response message
+ *
+ * Used to return output of IOCTL SDSI_SPDM_INFO. This
+ * information can be used by the user space, to get the driver, firmware
+ * support and also number of commands to send in a single IOCTL request.
+ */
+struct sdsi_spdm_info {
+	__u32 api_version;
+	__u16 driver_version;
+	__u16 dev_no;
+	__u16 max_request_size;
+	__u16 max_response_size;
+};
+
+#define SPDM_HEADER				\
+	struct {				\
+		__u8 spdm_version;		\
+		__u8 request_response_code;	\
+		__u8 param1;			\
+		__u8 param2;			\
+	}
+#define SPDM_HEADER_SIZE	sizeof(SPDM_HEADER)
+
+/**
+ * struct sdsi_spdm_message - The SPDM message sent and received from the device
+ * @spdm_version:		Supported SPDM version
+ * @request_response_code:	The SPDM message code for requests and responses
+ * @param1:			Parameter 1
+ * @param2:			Parameter 2
+ * @buffer:			SDPM message specific buffer
+ *
+ */
+struct sdsi_spdm_message {
+	SPDM_HEADER;
+	__u8 buffer[SZ_4K - SPDM_HEADER_SIZE];
+};
+
+#define SDSI_SPDM_BUF_SIZE	(sizeof(struct sdsi_spdm_message) - SPDM_HEADER_SIZE)
+
+/**
+ * struct sdsi_spdm_command - The SPDM command
+ * @ size:		The size of the SPDM message
+ * @ message:		The SPDM message
+ *
+ * Used to return output of IOCTL SDSI_SPDM_COMMAND.
+ */
+struct sdsi_spdm_command {
+	__u32 size;
+	struct sdsi_spdm_message message;
+};
+
+#define SDSI_IF_MAGIC		0xFC
+#define SDSI_IF_SPDM_INFO	_IOR(SDSI_IF_MAGIC, 0, struct sdsi_spdm_info *)
+#define SDSI_IF_SPDM_COMMAND	_IOWR(SDSI_IF_MAGIC, 1, struct sdsi_spdm_command *)
+#endif

base-commit: c3f38fa61af77b49866b006939479069cd451173
-- 
2.34.1


