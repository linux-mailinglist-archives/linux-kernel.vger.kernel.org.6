Return-Path: <linux-kernel+bounces-280988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17EB94D1A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CED281C89
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7E7195FE5;
	Fri,  9 Aug 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TFmbHDPS"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1C194151
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211642; cv=none; b=PVIq+6rat3hr3LFb0nLVUJrlsPUyHgqZwINaeXZqI/I0vuPFnYa6l6/tmoTQfRB6TDPgfkiBaeQjyIAUHf/V04jBfzz8GbC557s0aHnDUX4Gz7yD1Le/YEg/eo0m2+rRgxs7ZWAJvKnmo2CNCcQKvmf1FeQ9Eof1M8ncqPOOneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211642; c=relaxed/simple;
	bh=POj7jA8UhnoASujM1v5DmDiPbZCoaP3rtZMGiVpVX5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekhReIIv9zUocSOsCjDuvTGZR99TycW/HTi/rEeO2uudJ4j7CquDjKUT22jnnoGzt0C9TaBYfffyngWpQoBcHeE1RuZ/GE0QBIwzYsa0tdC87U7qEj49al9r60n+3bM+zjteynoYgLnEVeLZS5wvLUMcne7LMOJ+pRZBYWTr8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TFmbHDPS; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db16a98d16so1347831b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723211639; x=1723816439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxuZMvWun4EQd1zAF9+3+W4x5fWK9fpDJd5YAQFDLJs=;
        b=TFmbHDPSXLEJurSdY3qL5MOU/kpr8vpIk/J4smeam0M2oOPgEUVMqRoaINrSuI4wOd
         6t50n7zDtVpX+pC2uYoxpmYYzfqzmc5anNF95sL+Nf6rUxZ44ZDXm8LJZ5cizwgCe5FK
         Cs3+YMKEBjuxFLOBQqwOrV03qGsSkF/hr130DFdLMwm56hFnxDJVLrGsTHDCOOwC7Oyo
         V4KcpnDj4PPBu5Rn8Xk+s7Uw+k2TzLtHmvwoNQKUqtK3u9Dx8sRmO72dophgR2Wm60LO
         wn/Q2/E2le62wj/nZQJJux+zx8DBic5GS75Q51gfsKEQurXJjMZiEBL13QkdjbXdguiI
         ruig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211639; x=1723816439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxuZMvWun4EQd1zAF9+3+W4x5fWK9fpDJd5YAQFDLJs=;
        b=fHbC6NBK14Lrul5SvOytXg/ECzjVGqVa0UbWtcVYAi4jZr6KouodIvWDQLFSL5ISQq
         UH/GB5tIh8x3MTQyyDST/O2e5uSzz+awI0HzcAFnhrcFKUCRWpORLulHIZlV9D05WJzt
         EzYLkHoekNOANXOSOwKHm319ZuW7Vh204qOiQFiNQOqidrlzS6D6D8h8AVtDzfpRAvVc
         Dho7UgGrEPg8H6QH2kJt7lZ/gLG5H6w20wk/iga05byF7awjQ2n2hTy8Sel+FOwJCWLc
         Ors9fONfH9pp9Vg8thP0dWWtabukKN+i9JvUwm+UI/Bz5WeyqQIF0irBf6dhzCzR+RPk
         fCfw==
X-Forwarded-Encrypted: i=1; AJvYcCXSZxfXnsm/0+sBTG+DINibaUSOGVjv5XIGADT9ofcl/vwBvIwoGLPzoHyjW+7Xv4K57BycgwPz8QzmQ9Ul2Sh/dFrEsEKTsdGhkYgg
X-Gm-Message-State: AOJu0YxSPVFA8Fy/GVNGl4bKql+xv+uKfHfre4wdW8oVS4r/tBA0mb+M
	oafBLsli9YfBk87TIgFNsOvJHHVPJD8UKeWKQLpJpve6ZG+mllthjg3G6nUfYBA=
X-Google-Smtp-Source: AGHT+IE13rFXts45KUG8MoyPzPvktpRdjcAwS3RrXtrfaA1NABdgCbzIU8w73pXL4Yn1srFpqJJDsw==
X-Received: by 2002:a05:6358:7203:b0:1aa:a01a:23da with SMTP id e5c5f4694b2df-1b177198cbdmr171397355d.27.1723211639153;
        Fri, 09 Aug 2024 06:53:59 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a2728bsm4158640173.103.2024.08.09.06.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:53:58 -0700 (PDT)
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
Subject: [PATCH v9 1/4] firmware: ti_sci: Add support for querying the firmware caps
Date: Fri,  9 Aug 2024 15:53:44 +0200
Message-ID: <20240809135347.2112634-2-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809135347.2112634-1-msp@baylibre.com>
References: <20240809135347.2112634-1-msp@baylibre.com>
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
 drivers/firmware/ti_sci.c | 69 ++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h | 22 +++++++++++++
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
2.45.2


