Return-Path: <linux-kernel+bounces-280990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF3594D1AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059B0281E13
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1667197A77;
	Fri,  9 Aug 2024 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dNZWBZfh"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCEB194A48
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211647; cv=none; b=ATj+OOfyl2SQfRYDVXkdlK8D3MI2azJzUiM0h8o0qmApxXoNhVMtt1/OaGIlnUtAN+NK33pFv93LaiKxUe4yceG7tShkbxQjszU0FZMmGpK8G0YOXOh2Rh2UpowJz9G+OBu318RYj7S8xqs8kAENeiRnyJH0Nh2+LLcy5XpIO0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211647; c=relaxed/simple;
	bh=mvQLT1tntNHbExkf2ftIKJuMj57lVOl9oaLdt0l6nHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbr2ZMOcNlWE/5X+/HYvHWSyrGzuhrI4nwkrHEMG9OQvzdPE1HvgGtLBpM/4BQCYkMR6zTAoR3KXGmvuocNle7fAZ8QEyBIedQVBaJCinwUt2GOTB8o7ZyWH8dYpxYk1Lvdbg3jUWXuqfpe+Uumzq3TO4Zg/AV4m5WifBrM6MNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dNZWBZfh; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-704466b19c4so1193839a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723211644; x=1723816444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7vgAvZq99J8o+wD8o6FNHEt86llzA9gJR/gYsfJXHQ=;
        b=dNZWBZfhK2aL+NFbAoG+tv6x4oMpF3bMmwXos0Ws0shsCNVIpWqqmgH7FGZBmK1hrs
         6lIPCeo4tnA2P85fAA+h9rSYcpLuZXlZAeezp7JGU0XrLLGF0KqSaVI7c9Oua9AOn423
         bdKScHTdbAf0Kf2Hsi8NzvhNsxfwWZUJNDliihj2nqk1qzXTbi7XLcUA30M+AuekBLu4
         /TuepyT3uhDGo1gQd3tpSsnhonRcnwKPMxa8DAY71VaslqLBOAFMnP81R64zgl/df6JS
         dLtJwHmW/kgxaAzGU7+iNztnzPZW9IP+wX6BR+tb+jAEeuRFXzslmQJirM845WGInf6z
         F2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211644; x=1723816444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7vgAvZq99J8o+wD8o6FNHEt86llzA9gJR/gYsfJXHQ=;
        b=miEgXxa1XlEXgSjs3tAs1A1SBU1tWkWlPiyWcwHJDTjCSuP5lsnZjW0uT4p7phqB63
         4T11/dFeHqwpZSChlAfviaPVaOaxks9VhsVDFN1OCBJ0eWOXMdz+MOUBKS+ya/1cj767
         kiFTS3suebMwQWOBBWFdtji4R5dqmzcgmLzH8BJi+x0AheNrfPMm6/UFsAxFsUx0p6NJ
         08arec89xEGQjrhgDlEde5lXHAv5TEt4LisAYWxdWr8I4qXLQiPm/F9dFYY9H691miK/
         JsuMu3bIu8nrv0flaDYYvOM4L/LZZIARjjhY6ogZDXhiduFMV0Y7t6QmqlfqRYDiM+iQ
         mhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPTrgd0vDh2QvPIwBanxHMR8ngNj6EtxQE123zwCzO86s/mMhCfsZcavNyRFyD9DQ7vVKaHv3spUiyL3eT1tqeQ3EwuBZHx90Q5I5G
X-Gm-Message-State: AOJu0Yz0KWR1idtw7NSNTh1yaAgCNz4QJyNjM+d+dDeAdWlL67lBHeDZ
	kC9eH1PJamOqtUg1kD669znHyRUy5K8g95aVUi3tf7XBDtdxL0xqjoV2TXuUkik=
X-Google-Smtp-Source: AGHT+IEP+TGC9RKatpbyZpIxDv3+1fS/yDDEnwQ1eOy/g2fI+aWI3FGrFLMyRlQqk6aSU0uKaO3gEQ==
X-Received: by 2002:a05:6358:904b:b0:1aa:d6fe:f424 with SMTP id e5c5f4694b2df-1b176f7e1d9mr199233755d.13.1723211644211;
        Fri, 09 Aug 2024 06:54:04 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a2728bsm4158640173.103.2024.08.09.06.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:54:03 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dave Gerlach <d-gerlach@ti.com>,
	Georgi Vlaev <g-vlaev@ti.com>,
	Akashdeep Kaur <a-kaur@ti.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v9 3/4] firmware: ti_sci: Introduce Power Management Ops
Date: Fri,  9 Aug 2024 15:53:46 +0200
Message-ID: <20240809135347.2112634-4-msp@baylibre.com>
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

From: Dave Gerlach <d-gerlach@ti.com>

Introduce power management ops supported by the TISCI
Low Power Mode API [1].

1) TISCI_MSG_LPM_WAKE_REASON
Get which wake up source woke the SoC from Low Power Mode.
The wake up source IDs will be common for all K3 platforms.

2) TISCI_MSG_LPM_SET_DEVICE_CONSTRAINT
Set LPM constraint on behalf of a device. By setting a constraint, the
device ensures that it will not be powered off or reset in the selected
mode.

3) TISCI_MSG_LPM_SET_LATENCY_CONSTRAINT
Set LPM resume latency constraint. By setting a constraint, the host
ensures that the resume time from selected mode will be less than the
constraint value.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[g-vlaev@ti.com: LPM_WAKE_REASON and IO_ISOLATION support]
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
[a-kaur@ti.com: SET_DEVICE_CONSTRAINT support]
Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
[vibhore@ti.com: SET_LATENCY_CONSTRAINT support]
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c              | 175 +++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              |  70 ++++++++++
 include/linux/soc/ti/ti_sci_protocol.h |  42 ++++++
 3 files changed, 287 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 808149dcc635..5cbeca5df313 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1822,6 +1822,173 @@ static int ti_sci_cmd_set_io_isolation(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_msg_cmd_lpm_wake_reason() - Get the wakeup source from LPM
+ * @handle:		Pointer to TI SCI handle
+ * @source:		The wakeup source that woke the SoC from LPM
+ * @timestamp:		Timestamp of the wakeup event
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_msg_cmd_lpm_wake_reason(const struct ti_sci_handle *handle,
+					  u32 *source, u64 *timestamp)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	struct ti_sci_msg_resp_lpm_wake_reason *resp;
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
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_LPM_WAKE_REASON,
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
+	resp = (struct ti_sci_msg_resp_lpm_wake_reason *)xfer->xfer_buf;
+
+	if (!ti_sci_is_response_ack(resp)) {
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	if (source)
+		*source = resp->wake_source;
+	if (timestamp)
+		*timestamp = resp->wake_timestamp;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
+/**
+ * ti_sci_cmd_set_device_constraint() - Set LPM constraint on behalf of a device
+ * @handle:	pointer to TI SCI handle
+ * @id:	Device identifier
+ * @state:	The desired state of device constraint: set or clear
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_set_device_constraint(const struct ti_sci_handle *handle,
+					    u32 id, u8 state)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_msg_req_lpm_set_device_constraint *req;
+	struct ti_sci_msg_hdr *resp;
+	struct ti_sci_xfer *xfer;
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
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+	req = (struct ti_sci_msg_req_lpm_set_device_constraint *)xfer->xfer_buf;
+	req->id = id;
+	req->state = state;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
+
+	ret = ti_sci_is_response_ack(resp) ? 0 : -ENODEV;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
+/**
+ * ti_sci_cmd_set_latency_constraint() - Set LPM resume latency constraint
+ * @handle:	pointer to TI SCI handle
+ * @latency:	maximum acceptable latency (in ms) to wake up from LPM
+ * @state:	The desired state of latency constraint: set or clear
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_set_latency_constraint(const struct ti_sci_handle *handle,
+					     u16 latency, u8 state)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_msg_req_lpm_set_latency_constraint *req;
+	struct ti_sci_msg_hdr *resp;
+	struct ti_sci_xfer *xfer;
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
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+	req = (struct ti_sci_msg_req_lpm_set_latency_constraint *)xfer->xfer_buf;
+	req->latency = latency;
+	req->state = state;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
+
+	ret = ti_sci_is_response_ack(resp) ? 0 : -ENODEV;
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
@@ -2964,6 +3131,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_core_ops *core_ops = &ops->core_ops;
 	struct ti_sci_dev_ops *dops = &ops->dev_ops;
 	struct ti_sci_clk_ops *cops = &ops->clk_ops;
+	struct ti_sci_pm_ops *pmops = &ops->pm_ops;
 	struct ti_sci_rm_core_ops *rm_core_ops = &ops->rm_core_ops;
 	struct ti_sci_rm_irq_ops *iops = &ops->rm_irq_ops;
 	struct ti_sci_rm_ringacc_ops *rops = &ops->rm_ring_ops;
@@ -3003,6 +3171,13 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	cops->set_freq = ti_sci_cmd_clk_set_freq;
 	cops->get_freq = ti_sci_cmd_clk_get_freq;
 
+	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
+		pr_debug("detected DM managed LPM in fw_caps\n");
+		pmops->lpm_wake_reason = ti_sci_msg_cmd_lpm_wake_reason;
+		pmops->set_device_constraint = ti_sci_cmd_set_device_constraint;
+		pmops->set_latency_constraint = ti_sci_cmd_set_latency_constraint;
+	}
+
 	rm_core_ops->get_range = ti_sci_cmd_get_resource_range;
 	rm_core_ops->get_range_from_shost =
 				ti_sci_cmd_get_resource_range_from_shost;
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 8efe4d0e61fb..9dd40b6711d4 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -38,7 +38,10 @@
 
 /* Low Power Mode Requests */
 #define TI_SCI_MSG_PREPARE_SLEEP	0x0300
+#define TI_SCI_MSG_LPM_WAKE_REASON	0x0306
 #define TI_SCI_MSG_SET_IO_ISOLATION	0x0307
+#define TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT	0x0309
+#define TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT	0x030A
 
 /* Resource Management Requests */
 #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
@@ -610,6 +613,73 @@ struct ti_sci_msg_req_set_io_isolation {
 	u8 state;
 } __packed;
 
+/**
+ * struct ti_sci_msg_resp_lpm_wake_reason - Response for TI_SCI_MSG_LPM_WAKE_REASON.
+ *
+ * @hdr:		Generic header.
+ * @wake_source:	The wake up source that woke soc from LPM.
+ * @wake_timestamp:	Timestamp at which soc woke.
+ *
+ * Response to a generic message with message type TI_SCI_MSG_LPM_WAKE_REASON,
+ * used to query the wake up source from low power mode.
+ */
+struct ti_sci_msg_resp_lpm_wake_reason {
+	struct ti_sci_msg_hdr hdr;
+	u32 wake_source;
+	u64 wake_timestamp;
+} __packed;
+
+/**
+ * struct ti_sci_msg_req_lpm_set_device_constraint - Request for
+ * TISCI_MSG_LPM_SET_DEVICE_CONSTRAINT.
+ *
+ * @hdr:	TISCI header to provide ACK/NAK flags to the host.
+ * @id:	Device ID of device whose constraint has to be modified.
+ * @state:	The desired state of device constraint: set or clear.
+ * @rsvd:	Reserved for future use.
+ *
+ * This message is used by host to set constraint on the device. This can be
+ * sent anytime after boot before prepare sleep message. Any device can set a
+ * constraint on the low power mode that the SoC can enter. It allows
+ * configurable information to be easily shared from the application, as this
+ * is a non-secure message and therefore can be sent by anyone. By setting a
+ * constraint, the device ensures that it will not be powered off or reset in
+ * the selected mode. Note: Access Restriction: Exclusivity flag of Device will
+ * be honored. If some other host already has constraint on this device ID,
+ * NACK will be returned.
+ */
+struct ti_sci_msg_req_lpm_set_device_constraint {
+	struct ti_sci_msg_hdr hdr;
+	u32 id;
+	u8 state;
+	u32 rsvd[2];
+} __packed;
+
+/**
+ * struct ti_sci_msg_req_lpm_set_latency_constraint - Request for
+ * TISCI_MSG_LPM_SET_LATENCY_CONSTRAINT.
+ *
+ * @hdr:	TISCI header to provide ACK/NAK flags to the host.
+ * @wkup_latency:	The maximum acceptable latency to wake up from low power mode
+ *			in milliseconds. The deeper the state, the higher the latency.
+ * @state:	The desired state of wakeup latency constraint: set or clear.
+ * @rsvd:	Reserved for future use.
+ *
+ * This message is used by host to set wakeup latency from low power mode. This can
+ * be sent anytime after boot before prepare sleep message, and can be sent after
+ * current low power mode is exited. Any device can set a constraint on the low power
+ * mode that the SoC can enter. It allows configurable information to be easily shared
+ * from the application, as this is a non-secure message and therefore can be sent by
+ * anyone. By setting a wakeup latency constraint, the host ensures that the resume time
+ * from selected low power mode will be less than the constraint value.
+ */
+struct ti_sci_msg_req_lpm_set_latency_constraint {
+	struct ti_sci_msg_hdr hdr;
+	u16 latency;
+	u8 state;
+	u32 rsvd;
+} __packed;
+
 #define TI_SCI_IRQ_SECONDARY_HOST_INVALID	0xff
 
 /**
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 1f1871e23f76..e781381e2f7c 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -199,6 +199,47 @@ struct ti_sci_clk_ops {
 #define TISCI_MSG_VALUE_IO_ENABLE			1
 #define TISCI_MSG_VALUE_IO_DISABLE			0
 
+/* TISCI LPM wake up sources */
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_I2C0	0x00
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_UART0	0x10
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_GPIO0	0x20
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_ICEMELTER0	0x30
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER0	0x40
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER1	0x41
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_RTC0	0x50
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_RESET		0x60
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB0		0x70
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB1		0x71
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MAIN_IO		0x80
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_IO		0x81
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_CAN_IO		0x82
+#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_INVALID		0xFF
+
+/* TISCI LPM constraint state values */
+#define TISCI_MSG_CONSTRAINT_SET			1
+#define TISCI_MSG_CONSTRAINT_CLR			0
+
+/**
+ * struct ti_sci_pm_ops - Low Power Mode (LPM) control operations
+ * @lpm_wake_reason: Get the wake up source that woke the SoC from LPM
+ *		- source: The wake up source that woke soc from LPM.
+ *		- timestamp: Timestamp at which soc woke.
+ * @set_device_constraint: Set LPM constraint on behalf of a device
+ *		- id: Device Identifier
+ *		- state: The desired state of device constraint: set or clear.
+ * @set_latency_constraint: Set LPM resume latency constraint
+ *		- latency: maximum acceptable latency to wake up from low power mode
+ *		- state: The desired state of latency constraint: set or clear.
+ */
+struct ti_sci_pm_ops {
+	int (*lpm_wake_reason)(const struct ti_sci_handle *handle,
+			       u32 *source, u64 *timestamp);
+	int (*set_device_constraint)(const struct ti_sci_handle *handle,
+				     u32 id, u8 state);
+	int (*set_latency_constraint)(const struct ti_sci_handle *handle,
+				      u16 latency, u8 state);
+};
+
 /**
  * struct ti_sci_resource_desc - Description of TI SCI resource instance range.
  * @start:	Start index of the first resource range.
@@ -543,6 +584,7 @@ struct ti_sci_ops {
 	struct ti_sci_core_ops core_ops;
 	struct ti_sci_dev_ops dev_ops;
 	struct ti_sci_clk_ops clk_ops;
+	struct ti_sci_pm_ops pm_ops;
 	struct ti_sci_rm_core_ops rm_core_ops;
 	struct ti_sci_rm_irq_ops rm_irq_ops;
 	struct ti_sci_rm_ringacc_ops rm_ring_ops;
-- 
2.45.2


