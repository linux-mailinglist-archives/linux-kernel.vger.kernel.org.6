Return-Path: <linux-kernel+bounces-286769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8122D951EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101B21F22A97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA21B5803;
	Wed, 14 Aug 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rhCbOKIU"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F51B3F20
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649997; cv=none; b=cPs/bZYmnIKkgssPnijd4fX6NNBC7sG4qmZkePRzRZXlo0yEjm1aNnCtHyR3muSwasNI9hCTYBuz6HtBGxajBGoXh0lEhJyyD13jUSSIetSWkE0wg3BtiGgY+uHWEZ2ZjopMLvuNU0HlgI+nCbDvHFHWiFl7MdZQOgwlfcJ0hmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649997; c=relaxed/simple;
	bh=k0IWkc/XYUwY9mbwNF4Mom1JEa3IN6gBW+n97jZ0ZXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPNGmuicx8SYf5GpDSev+Aa0vywQ+rEx1vhzpsfh3ifYtaSC9Fry1MbADVoHmIaaCXPtjlwMsgI42GOIhVWAaGkg5SqJgZGeZceLXUBxzIR2+enUKdOKWThBnsn/u5PMsusGovTgDFsujhA3KhXQzKxnWr1/Y1gZz0B7MZm1Yjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rhCbOKIU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201d6ac1426so8786175ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723649994; x=1724254794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZwoHHCn+atSlmqhOT1+A6eF8trrUBAMiXzmjVgxULI=;
        b=rhCbOKIUItN0Jg/BPMrfXLcrN9p/fhM6FGDbXY6FhXZqecjWgiRudQ7c9SNLHqdM3S
         3DcO0AHZkV3uIMQJyDvVx90gCF5yWKSZyqvv6gIxTRsEDz76lgLWogra+zVGP+x27PF+
         LoUaHgzSqx7MgFuTbMO1HM0O48fTXFBqa37Kq12N2po/vyjx4mhCSwGnqy/6OBy17Kfb
         pf92YGg79p4755GuMlXEZLvpyeQwpZEb9MFXFnG+gbrwV4Xf7v96NuJnFcKsNICe9Djv
         0nqvCw3Xz4Dq/aMmVuXjXL4t3jtPKl9iKgri4EZYAcSjK9POpggHUu2l0fpxGLEGE60t
         6cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649994; x=1724254794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZwoHHCn+atSlmqhOT1+A6eF8trrUBAMiXzmjVgxULI=;
        b=UeOAVegroKnkcoU3ftHqw8MQa2pSVkUTipLclil7pUbNcKMmjaryTBZsxSJlDZL0zD
         tM+T3yn+J7RS8Xbn6dBv76NnkXQ7EMc0NDSsliCkMLCiul25zLimE7ww9+ZrM00+zlXl
         3uLQGUnodK28ZFVZzgUZfYXgBi8MnKCnC/moM/SOH8L4u7arH7omclstvHOoxTUifMlD
         qDPHNI7YsA9Zl35HfDcdKEA+n3Ru2zsvoobnkihAdfWbWMyLcDRD5kTYdrL1k+goFMju
         wJ84zqcxwvZRfQGr2wABD+R8C9/RiE/9yifAACJS/sfEjPg1Js65pGcolQYKVzTHwOjv
         GVHw==
X-Forwarded-Encrypted: i=1; AJvYcCWWvkseoIeMPARssP5RNwmWcJUXlaxtRZ8qaQLT2L3rKfqhiSj8cFUuDCaT3ka8b+iAc3mUuKyYFfkALzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDUZjLhRGfNgrOzH+HIvhchvtKa2UcaG0Dt+1pgU9du2cpjCFs
	Jf94HI9yJNtNARmb8dpeBOL4ACjWVpWJOwzqxfgiUl13W95jC4orXXiE2ECnE2E=
X-Google-Smtp-Source: AGHT+IEUPe8sQHa+iqRLGa5scCLBoeNHtfI88S/tHB5GkHGLOTZ8UPXhxFKv8w4yT/cAAfNK/if8vQ==
X-Received: by 2002:a17:902:d508:b0:201:e792:d6ff with SMTP id d9443c01a7336-201e792d9f9mr14530265ad.10.1723649994415;
        Wed, 14 Aug 2024 08:39:54 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14e084sm30927495ad.110.2024.08.14.08.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:39:54 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Wed, 14 Aug 2024 08:39:28 -0700
Subject: [PATCH v10 1/4] firmware: ti_sci: Add support for querying the
 firmware caps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-lpm-constraints-firmware-msp-v10-1-bee4314bbdc8@baylibre.com>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
In-Reply-To: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6409; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=2Z3NwIB8KsuUQoqYJK95phdpT243RgM8VSUOwStsjBA=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmvM/IW3kpcUhWKX5oP42+OPxGmBZFXfXtly4KZ
 x6h92RsvRuJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZrzPyAAKCRBZNxia0/vG
 ZfA7D/4+dft8JswMtTMnCvUH5buU3yl8cMIyqydnQ9Bo0n1DPsiBsILbIb3JOq/ULRWLUdoEmGh
 D7DnnOTfD0XjTcQbg2vVFYBcG6VdAxGEDPYqKBrumB1cloDamMXaVVbVuZsenBZO4/12jTjMsUD
 nNx6dH8dXdJBLBgB/RmxJPfYzAHaV+B1EzM0UFDrDZEtQIqrt6RA83wEc6I/UQpmMXHOsrnAwNo
 ewSRv+GaLBvi97sEsgv0T12K0Zrf5lsBIqANqsY66U7K2+eQeWm8wNQmFr5Fu42WnsbKxACZNYX
 2jKT16JDGtMQAG5NbgOQIssWbetfOCOsobDObiEf7mCiXdY2dLbdVWJT3c/IVB2Un8CN+9a1nUb
 eYJvO5XriSXOdO9xlCUogtL+muiR25oz/WqioIDAs9rk4p+FKHb++jueA0kN09LnQmJ+Rstnd0R
 2+0q7cxjTmpbEqmUr68elc1HXMXeT9ZBkIdM4rxRHZOnCbXoYxphDcSC0jZLp0EkH9lwgFgBOoi
 PYXTX/7QU94RbSZqJZL0Q1tHMIDn+5rAGky2GYOs1Cg+C5HrT8biLw945ptBXqAnG8FTctfrzTx
 0K5jMBHg+GY9HQD8hTg9YB/1B/KtDdgAhR6jaotcnVXm3b17Qd3+mICwCmIciVU0X5EBzUq2a9W
 AiEbNrEZXvH3cKw==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

From: Georgi Vlaev <g-vlaev@ti.com>

Add support for the TISCI_MSG_QUERY_FW_CAPS message, used to retrieve
the firmware capabilities of the currently running system firmware. The
message belongs to the TISCI general core message API [1] and is
available in SysFW version 08.04.03 and above. Currently, the message is
supported on devices with split architecture of the system firmware (DM
+ TIFS) like AM62x. Old revisions or not yet supported platforms will
NACK this request.

We're using this message locally in ti_sci.c to get the low power
featutes of the FW/SoC. As there's no other kernel consumers yet, this
is not added to struct ti_sci_core_ops.

Sysfw version >= 10.00.04 support LPM_DM_MANAGED capability [2], where
Device Mgr firmware now manages which low power mode is chosen. Going
forward, this is the default configuration supported for TI AM62 family
of devices. The state chosen by the DM can be influenced by sending
constraints using the new LPM constraint APIs.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html
[2] https://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-msg-query-fw-caps

Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
[vibhore@ti.com: Support for LPM_DM_MANAGED mode]
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/firmware/ti_sci.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h | 22 ++++++++++++++++++++++
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 160968301b1f..f77e13577eb8 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments System Control Interface Protocol Driver
  *
- * Copyright (C) 2015-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2015-2024 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  */
 
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/sys_soc.h>
 #include <linux/reboot.h>
 
 #include "ti_sci.h"
@@ -98,6 +99,7 @@ struct ti_sci_desc {
  * @minfo:	Message info
  * @node:	list head
  * @host_id:	Host ID
+ * @fw_caps:	FW/SoC low power capabilities
  * @users:	Number of users of this instance
  */
 struct ti_sci_info {
@@ -114,6 +116,7 @@ struct ti_sci_info {
 	struct ti_sci_xfers_info minfo;
 	struct list_head node;
 	u8 host_id;
+	u64 fw_caps;
 	/* protected by ti_sci_list_mutex */
 	int users;
 };
@@ -1651,6 +1654,62 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_msg_cmd_query_fw_caps() - Get the FW/SoC capabilities
+ * @handle:		Pointer to TI SCI handle
+ * @fw_caps:		Each bit in fw_caps indicating one FW/SOC capability
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_msg_cmd_query_fw_caps(const struct ti_sci_handle *handle,
+					u64 *fw_caps)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	struct ti_sci_msg_resp_query_fw_caps *resp;
+	struct device *dev;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+	dev = info->dev;
+
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_QUERY_FW_CAPS,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(struct ti_sci_msg_hdr),
+				   sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+	resp = (struct ti_sci_msg_resp_query_fw_caps *)xfer->xfer_buf;
+
+	if (!ti_sci_is_response_ack(resp)) {
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	if (fw_caps)
+		*fw_caps = resp->fw_caps;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
 static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
 {
 	struct ti_sci_info *info;
@@ -3390,6 +3449,14 @@ static int ti_sci_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	/*
+	 * Check if the firmware supports any optional low power modes.
+	 * Old revisions of TIFS (< 08.04) will NACK the request.
+	 */
+	ret = ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
+	if (ret || !(info->fw_caps & MSG_FLAG_CAPS_GENERIC))
+		pr_debug("Unable to detect LPM capabilities in fw_caps\n");
+
 	ti_sci_setup_ops(info);
 
 	ret = devm_register_restart_handler(dev, tisci_reboot_handler, info);
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 5846c60220f5..73ca9503606b 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -19,6 +19,7 @@
 #define TI_SCI_MSG_WAKE_REASON	0x0003
 #define TI_SCI_MSG_GOODBYE	0x0004
 #define TI_SCI_MSG_SYS_RESET	0x0005
+#define TI_SCI_MSG_QUERY_FW_CAPS	0x0022
 
 /* Device requests */
 #define TI_SCI_MSG_SET_DEVICE_STATE	0x0200
@@ -132,6 +133,27 @@ struct ti_sci_msg_req_reboot {
 	struct ti_sci_msg_hdr hdr;
 } __packed;
 
+/**
+ * struct ti_sci_msg_resp_query_fw_caps - Response for query firmware caps
+ * @hdr:	Generic header
+ * @fw_caps:	Each bit in fw_caps indicating one FW/SOC capability
+ *		MSG_FLAG_CAPS_GENERIC: Generic capability (LPM not supported)
+ *		MSG_FLAG_CAPS_LPM_PARTIAL_IO: Partial IO in LPM
+ *		MSG_FLAG_CAPS_LPM_DM_MANAGED: LPM can be managed by DM
+ *
+ * Response to a generic message with message type TI_SCI_MSG_QUERY_FW_CAPS
+ * providing currently available SOC/firmware capabilities. SoC that don't
+ * support low power modes return only MSG_FLAG_CAPS_GENERIC capability.
+ */
+struct ti_sci_msg_resp_query_fw_caps {
+	struct ti_sci_msg_hdr hdr;
+#define MSG_FLAG_CAPS_GENERIC		TI_SCI_MSG_FLAG(0)
+#define MSG_FLAG_CAPS_LPM_PARTIAL_IO	TI_SCI_MSG_FLAG(4)
+#define MSG_FLAG_CAPS_LPM_DM_MANAGED	TI_SCI_MSG_FLAG(5)
+#define MSG_MASK_CAPS_LPM		GENMASK_ULL(4, 1)
+	u64 fw_caps;
+} __packed;
+
 /**
  * struct ti_sci_msg_req_set_device_state - Set the desired state of the device
  * @hdr:		Generic header

-- 
2.46.0


