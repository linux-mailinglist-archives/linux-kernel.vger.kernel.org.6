Return-Path: <linux-kernel+bounces-271818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7D7945391
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC1D1F240BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2566514B945;
	Thu,  1 Aug 2024 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GN0h/jel"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189614AD25
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542087; cv=none; b=VwTEXTtIoPgmdFB718gM/MC9ClsRTZ0YJxM6U5An/EGX+VdsaTfLLZ5OYZfv39byOGKO6/sS12724HCRcfjFwfe3TSjTY3tJWdZ2KkN42PVKBZ70RUPYbI2dRyGWjj/2bQKyhv4M5plE7n2ya0iWgo7joNgfEWpjrgFnPPloXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542087; c=relaxed/simple;
	bh=wCAA5NqL6BzBzEJek6OiRFd9bSYHDcgYXFADSLro2f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAA71mNi/pJu3vn1Tyz61U6mCA7E/zymaoLhG/JLFizlxolhKulSxcwoBYLzUssydyPFWnb4W+NF/IyMa6Vo+PoKCWiauVXGuEtga/RD+VT3+LDvWtkSQEf/z+ncXXZnaiuDU4lx0Ro24xDf0ofElz6oVQEyA8EFA07xYKLY6Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GN0h/jel; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f83b14d65so320194539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722542084; x=1723146884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcvr3sCzC6JRh5BWaUixpZzO8bdpYlRw3Ht2YY2cy6g=;
        b=GN0h/jelIMw+E3k1ETx98O8GWQWDgcNiIsSMJZEdVrUqsRt1hM5i+b3PuFjuktRptI
         9vnCISJqPgn//Pi/t/hUruUTYVT1hLFkI5gZIVfmy5zpSqS6Mws6L2b2QUWZaiRt788e
         Zg2CCpp0MuTsZLmgFNn5TCPyIsi8hQUQBRnkviDggsjMiIJ7sZCuUZOtjCwdKlYXNwq3
         ADB6z0QuiEMvpyYwKX9BPF2iml8htgyeLHxou0vdB1OLaNHegvclLkd3XaW7WTi+Zaek
         7aveVgUQx/xQrN2nnzeeabj7u/PDoYwYRR7LqjzxgIDovXqdhcrPgkSCoWnMpTDClqH4
         Mukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542084; x=1723146884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcvr3sCzC6JRh5BWaUixpZzO8bdpYlRw3Ht2YY2cy6g=;
        b=RVxASshsdYmyz9A5MQwVeX3Nt8NZMMGZBDSxJ9ghG0DWmBb6piH0gLHJD3kjTKnFzY
         1Hbl2zkJrT5ccd87oOGARkvC2jkQP40dB9/w+KoabmSDMnMqWBBN2n9yx0kx0guFW1yk
         NRuLVWdacrJ8OfHmciT2o0Qbj0lcu8YUXXM/AEWNV/KTe24bTh4bvPvWfyRoTAvyxvdT
         vicZLcRjAMeAzQnjc5rLwdBeRHyNEKRlVWDXQuWSwktmHAO04K2HgbRemEbXmzSUmGX2
         qlfnJtHQ22qFpDaic0Vw0Fl/TPMKjXc4ywULwnTxA85KnObetsvf0TYHhUCaBfym2g6a
         nfvw==
X-Forwarded-Encrypted: i=1; AJvYcCXFPggN4IDxkKycCgoBlGwJeD6DwxudsRWHa8vd/2zqGjkBj5SoKJO68FL4YKFDz45R2y9ejSuNM3s02jaGd36UwF9vhx4bTnlAtiMq
X-Gm-Message-State: AOJu0YyjMJPZ/V1+siz0bX1bzTLow8WJjBzwKx4fIVZ3OSBbhuIKpHdQ
	m4Fa3MekxHp+WhA/SGzN+1Z4jZ+orxlMe5xibiWoXMHY8PKg3zIv02x7mFNYZtw=
X-Google-Smtp-Source: AGHT+IFFPU4SQ/ve1pnNOqa00XykUHQ6+BnwhBlaeI8hCGJOnC+c5xzIcxEhjQ70PpZH2B/3i1qQzA==
X-Received: by 2002:a05:6602:1507:b0:806:7f5a:1fb7 with SMTP id ca18e2360f4ac-81fd434beddmr171669739f.5.1722542084014;
        Thu, 01 Aug 2024 12:54:44 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d1b7ddsm14395039f.3.2024.08.01.12.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:54:43 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Georgi Vlaev <g-vlaev@ti.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v8 2/3] firmware: ti_sci: Add support for querying the firmware caps
Date: Thu,  1 Aug 2024 21:54:21 +0200
Message-ID: <20240801195422.2296347-3-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801195422.2296347-1-msp@baylibre.com>
References: <20240801195422.2296347-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/firmware/ti_sci.c | 73 +++++++++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h | 22 ++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 3599aeecef86..d7a3990a6353 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
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
@@ -1929,6 +1932,62 @@ static int ti_sci_cmd_set_latency_constraint(const struct ti_sci_handle *handle,
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
@@ -3113,6 +3172,12 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 
 	pmops->lpm_wake_reason = ti_sci_msg_cmd_lpm_wake_reason;
 
+	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
+		pr_debug("detected DM managed LPM in fw_caps\n");
+		ops->pm_ops.set_device_constraint = ti_sci_cmd_set_device_constraint;
+		ops->pm_ops.set_latency_constraint = ti_sci_cmd_set_latency_constraint;
+	}
+
 	rm_core_ops->get_range = ti_sci_cmd_get_resource_range;
 	rm_core_ops->get_range_from_shost =
 				ti_sci_cmd_get_resource_range_from_shost;
@@ -3671,6 +3736,14 @@ static int ti_sci_probe(struct platform_device *pdev)
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
index 424bc192ce3e..b8bba5d521d7 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -19,6 +19,7 @@
 #define TI_SCI_MSG_WAKE_REASON	0x0003
 #define TI_SCI_MSG_GOODBYE	0x0004
 #define TI_SCI_MSG_SYS_RESET	0x0005
+#define TI_SCI_MSG_QUERY_FW_CAPS	0x0022
 
 /* Device requests */
 #define TI_SCI_MSG_SET_DEVICE_STATE	0x0200
@@ -139,6 +140,27 @@ struct ti_sci_msg_req_reboot {
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
2.45.2


