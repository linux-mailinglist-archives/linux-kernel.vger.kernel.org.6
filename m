Return-Path: <linux-kernel+bounces-307631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F08496509B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841411C20434
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142351BAEDD;
	Thu, 29 Aug 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kuA7eU8e"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C761C1BA877
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962581; cv=none; b=p03+Qu7hBRqf3oPKYiQF60qP/brNtSnyGKoIDOP0ycfo3jCCpYf2+ET5i8kJ/sAKKQ7Gbt1Yt84lRChAwijDbZbNWmp7h/Iy5NfxTtG0fqea4Jiia+kj1fu7RpGxZfdzDJ2TiEWuc947pGOVVTcjx64hbMF8t3w6GIlNKMGYz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962581; c=relaxed/simple;
	bh=zGxaD8U9T+U4b4C+2/HJJQNmmk4gYPbj991Oi1n/7Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+SffrpXpG2aPOaBKSBwFd8+PF7QxK9hVqcguTNCkAw99xxFzLLfDPYmenOiQcy+LVuqOOyfKnmeE1HJhFbYEnEDVgsOkk9VjeXfrmlPFf++vp6zEK0nq9U0+SRO8F95dXLVAIEbYhxqNAsiDAfYvNmnoSLXl40VtyNsP6fxbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kuA7eU8e; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so9346855e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724962576; x=1725567376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGlk+6RhKnBgzhvhm0ocxM8uELwMTtl2eqHYRSP1FzQ=;
        b=kuA7eU8ejXZTRSCaRg1bnkDK4/xK2duSTsArL8LMSu6oPvOMp80rwUv49FuS8+XIkU
         Q+y1WfNqqVrTODWJd6xhz9iEtK93RiQgtfjPuzvTfjQPcSZi4XpdRoKr+Waa7n+gQvgR
         bFN4qnam6eXaR0jXfw/mdS3GfeIjs53GjocxEOyfqn/ub1FQ1+bNREKiInh7WqQktzkA
         AUQUOSvuQbN4e/lK9OyGXDA2rSxvuRCIERB0korigKz3LvyfXmjH6eUPSLyevPoFJLEZ
         CIeTXjuM1b3LGsxqYfEuhnVdL6x/RWkchDvDydlZqGFnZqbmCRcMKXP4z+NDHkojpOdm
         14Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962576; x=1725567376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGlk+6RhKnBgzhvhm0ocxM8uELwMTtl2eqHYRSP1FzQ=;
        b=mYn3eMS/FynNb7BC2D2yt64Nq7gHp6k8p2IdqBvdm+tvrXZHWYF4s8ONrQVkWYni6a
         7tAfrVxMXRmW2ATGLvCmcsKJQyYUi8o9hj/MkFv4hPp69HifHtqo+8088ju1lxR1rZ63
         2dJVRdjm28kP1pPZygbXCAelBAJPvPorkEdlL1THTQAE82EUR/F+LVzMG5rV4MLcXH8P
         Au+VzeeKG30LtduIixX0+Yzeh42OMxaaDi0irG8VMCwrxTbmQsidONe1oXDbzzrq35lp
         gWjKatBnuTRZdaxYSTFoftFikLLoVySc8+EBWmW9R7EpfRazEWGNHVpJHFi+obna/Lhe
         URlg==
X-Forwarded-Encrypted: i=1; AJvYcCW7cIRiCskuPV6wcBlTulZnS2QjWBnhjDBQKY4IyBLiIyh5KdAl0f4Nd4CbAvfq4cXloZXsdSH1DbXVZhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzylDIAoQxlglklJlW6ngBMGy+bTgKLatokJt0rng+OhaqU8QQ
	qeENAWhwfDYnknulOsfBftTxWbOeM7+cugYYA8IITN2XnMoG8ewVADNmbM5iKuo=
X-Google-Smtp-Source: AGHT+IEX9BEL/aSSY4fkZb4HqB4p1WoEr4eolcIacJOSg8a9+g4vDR3ZPBbzPuaUQ5RK8ohKWgpiWQ==
X-Received: by 2002:a05:600c:4fcd:b0:426:58ca:5a3 with SMTP id 5b1f17b1804b1-42bb032caf5mr26615175e9.30.1724962575865;
        Thu, 29 Aug 2024 13:16:15 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:802f:3a47:b29:5530:28a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb303sm26681385e9.9.2024.08.29.13.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:16:15 -0700 (PDT)
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
Subject: [PATCH v11 1/4] firmware: ti_sci: Add support for querying the firmware caps
Date: Thu, 29 Aug 2024 22:16:02 +0200
Message-ID: <20240829201606.1407773-2-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829201606.1407773-1-msp@baylibre.com>
References: <20240829201606.1407773-1-msp@baylibre.com>
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
features of the FW/SoC. As there's no other kernel consumers yet, this
is not added to struct ti_sci_core_ops.

Sysfw version >= 10.00.04 support LPM_DM_MANAGED capability [2], where
Device Mgr firmware now manages which low power mode is chosen. Going
forward, this is the default configuration supported for TI AM62 family
of devices. The state chosen by the DM can be influenced by sending
constraints using the new LPM constraint APIs.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html
[2] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-msg-query-fw-caps

Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
[vibhore@ti.com: Support for LPM_DM_MANAGED mode]
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 74 ++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h | 22 ++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 160968301b1f..bed7c8892341 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2,10 +2,11 @@
 /*
  * Texas Instruments System Control Interface Protocol Driver
  *
- * Copyright (C) 2015-2022 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2015-2024 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  */
 
+#include "linux/dev_printk.h"
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/bitmap.h>
@@ -24,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/sys_soc.h>
 #include <linux/reboot.h>
 
 #include "ti_sci.h"
@@ -98,6 +100,7 @@ struct ti_sci_desc {
  * @minfo:	Message info
  * @node:	list head
  * @host_id:	Host ID
+ * @fw_caps:	FW/SoC low power capabilities
  * @users:	Number of users of this instance
  */
 struct ti_sci_info {
@@ -114,6 +117,7 @@ struct ti_sci_info {
 	struct ti_sci_xfers_info minfo;
 	struct list_head node;
 	u8 host_id;
+	u64 fw_caps;
 	/* protected by ti_sci_list_mutex */
 	int users;
 };
@@ -1651,6 +1655,67 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_msg_cmd_query_fw_caps() - Get the FW/SoC capabilities
+ * @handle:		Pointer to TI SCI handle
+ * @fw_caps:		Each bit in fw_caps indicating one FW/SOC capability
+ *
+ * Check if the firmware supports any optional low power modes.
+ * Old revisions of TIFS (< 08.04) will NACK the request which results in
+ * -ENODEV being returned.
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
+		dev_err(dev, "Failed to get capabilities\n");
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
@@ -3390,6 +3455,13 @@ static int ti_sci_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
+	dev_dbg(dev, "Detected firmware capabilities: %s%s%s\n",
+		info->fw_caps & MSG_FLAG_CAPS_GENERIC ? "Generic" : "",
+		info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO ? " Partial-IO" : "",
+		info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED ? " DM-Managed" : ""
+	);
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
2.45.2


