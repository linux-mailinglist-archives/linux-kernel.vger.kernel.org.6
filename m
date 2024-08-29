Return-Path: <linux-kernel+bounces-307633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34C996509E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766081F22193
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F67E1BB695;
	Thu, 29 Aug 2024 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U3OP/jeX"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1626296
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962582; cv=none; b=UvGrLIqXseVXuPVu87VNuIdUd5Y0L3FzdpP+ykZCYa67+ujbWVGGea2gRLGBQulo8bydvnL/JNXMv3kS2rZo0fCYTPIZolhIyTie8ryxfWEJuQObrULgYeO2R2FrO6Avl6kY+bpnrfkPsDxbu9gHDDCoD5DNwGOtbZhq/UCqtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962582; c=relaxed/simple;
	bh=2YLbQOl6WOhv1G4HHICKVjYmxtSAiu7Sijn/5qjxjdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8KEPZh3iPsw+5nzwdseTtrD6iZEYWgQ1sKGd2dRDDHEM281uRiOWqd3mn0OUtU0qs/sQjNrS3tI56mEopCsXzdbQFAgq4zN2yod+uzLdx3aUdlIJaUN8/WoigxdzB2fJok8Vgg8EU3CL1S2+rCajjueJfafdrnA/mz5qOLVJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U3OP/jeX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3730749ee7aso722672f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724962578; x=1725567378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NSe3kJCdAnk8fxBGYDM5JR1V1f/i3ndMrx1xJImgPc=;
        b=U3OP/jeXeaz4oqI4A0lO4+OndD2DkmzZADhLJhdpuy23rxWffDDGmgeetJ0lpDcBrI
         KKnH1Pzuv7aPhyK8ZTS07l1s98L5wovMWcIF8KF2RVrlZl9b8Lxu9eDLEO1BHZcJPdio
         nVGOCqenjX6NheKrtq7Ez/zYJ+A/uCWO/mdwYDZ416bfL1lwuySU/Pso4hLIycCM3I7z
         lN/kJxNJFmmFNbERczeTNjLIWxnDgbtu3uyKznk+NQEtzMVZn8k8uGTMerfrcCjepV1p
         B796ffajT/B7Viufqg8LP8qDtVoNf7/44cBkk5VUJutFKphuizctXN3WAhYgL8E+w56C
         kn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962578; x=1725567378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NSe3kJCdAnk8fxBGYDM5JR1V1f/i3ndMrx1xJImgPc=;
        b=g9R8QJ00dG4xbNI2kJQngzXtF9PHpmuEE6MmYRCuirX/yk9Lk1LLC4Pbs11g7S5cQn
         c6ak/fa2AFXOfZXrfmhxrscREtf9ItfHWWv180zWsMbYbSylaRsOIdR7QxH3Olg6sECG
         hQOXamlnWowo/sgAtYXt7OJFEa0OOJ0TEUF6iiAHnE9Uf9f7nHC7QdjHb7ExL4TeTWme
         VwzwZ8teJ2RR6wGawwx7PbQiV9RYnUZ6vOVkAefoDDI+ZMw4ouoz+aR4pczYWE8pAt8K
         dniu9RvQXZOCEk9SI9fAuMdRGeYJ1GdUfKP/FvsYPNoPzbsc/imHFTzSow0WXBIpGE40
         HIFA==
X-Forwarded-Encrypted: i=1; AJvYcCVUr2uFbemvjkGeJKa7mhYDsXVy1zdEvbOgeLb+YbiSERU9EA9J9eXy5PgB+v3VrlYwedps4PoA05YDR6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1FJ3+1xktyhZFcuGJfoM0zP2JCmdMz5spPJtVXcpYcysUYaFY
	tj28zrDVpGXFtd7RgnwcT53LVQRrSHFE2XDo42a8f4aNQlEVy32E4UmBZ43Pfj0=
X-Google-Smtp-Source: AGHT+IEwBCg3v0reTBTsBgwPvgqpkZez+Txf1nVrUpVsg2nvKWLfe7Nn37pnVbgRe07amPYMjnlFzg==
X-Received: by 2002:a05:6000:104c:b0:368:3f60:8725 with SMTP id ffacd0b85a97d-3749b57ecccmr2665767f8f.39.1724962577905;
        Thu, 29 Aug 2024 13:16:17 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:802f:3a47:b29:5530:28a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb303sm26681385e9.9.2024.08.29.13.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:16:17 -0700 (PDT)
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
Subject: [PATCH v11 3/4] firmware: ti_sci: Introduce Power Management Ops
Date: Thu, 29 Aug 2024 22:16:04 +0200
Message-ID: <20240829201606.1407773-4-msp@baylibre.com>
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
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Akashdeep Kaur <a-kaur@ti.com>
Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c              | 198 +++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              |  76 ++++++++++
 include/linux/soc/ti/ti_sci_protocol.h |  26 ++++
 3 files changed, 300 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 8a772b378ffa..8482b7077eef 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1834,6 +1834,186 @@ static int ti_sci_cmd_set_io_isolation(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_msg_cmd_lpm_wake_reason() - Get the wakeup source from LPM
+ * @handle:		Pointer to TI SCI handle
+ * @source:		The wakeup source that woke the SoC from LPM
+ * @timestamp:		Timestamp of the wakeup event
+ * @pin:		The pin that has triggered wake up
+ * @mode:		The last entered low power mode
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_msg_cmd_lpm_wake_reason(const struct ti_sci_handle *handle,
+					  u32 *source, u64 *timestamp, u8 *pin, u8 *mode)
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
+		dev_err(dev, "Failed to get wake reason\n");
+		ret = -ENODEV;
+		goto fail;
+	}
+
+	if (source)
+		*source = resp->wake_source;
+	if (timestamp)
+		*timestamp = resp->wake_timestamp;
+	if (pin)
+		*pin = resp->wake_pin;
+	if (mode)
+		*mode = resp->mode;
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
+	if (!ti_sci_is_response_ack(resp)) {
+		dev_err(dev, "Failed to set device constraint\n");
+		ret = -ENODEV;
+	}
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
+	if (!ti_sci_is_response_ack(resp)) {
+		dev_err(dev, "Failed to set device constraint\n");
+		ret = -ENODEV;
+	}
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
@@ -2976,6 +3156,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_core_ops *core_ops = &ops->core_ops;
 	struct ti_sci_dev_ops *dops = &ops->dev_ops;
 	struct ti_sci_clk_ops *cops = &ops->clk_ops;
+	struct ti_sci_pm_ops *pmops = &ops->pm_ops;
 	struct ti_sci_rm_core_ops *rm_core_ops = &ops->rm_core_ops;
 	struct ti_sci_rm_irq_ops *iops = &ops->rm_irq_ops;
 	struct ti_sci_rm_ringacc_ops *rops = &ops->rm_ring_ops;
@@ -3015,6 +3196,13 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
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
@@ -3506,11 +3694,21 @@ static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
 {
 	struct ti_sci_info *info = dev_get_drvdata(dev);
 	int ret = 0;
+	u32 source;
+	u64 time;
+	u8 pin;
+	u8 mode;
 
 	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
 	if (ret)
 		return ret;
 
+	ret = ti_sci_msg_cmd_lpm_wake_reason(&info->handle, &source, &time, &pin, &mode);
+	/* Do not fail to resume on error as the wake reason is not critical */
+	if (!ret)
+		dev_info(dev, "ti_sci: wakeup source:0x%x, pin:0x%x, mode:0x%x\n",
+			 source, pin, mode);
+
 	return 0;
 }
 
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 8efe4d0e61fb..053387d7baa0 100644
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
@@ -610,6 +613,79 @@ struct ti_sci_msg_req_set_io_isolation {
 	u8 state;
 } __packed;
 
+/**
+ * struct ti_sci_msg_resp_lpm_wake_reason - Response for TI_SCI_MSG_LPM_WAKE_REASON.
+ *
+ * @hdr:		Generic header.
+ * @wake_source:	The wake up source that woke soc from LPM.
+ * @wake_timestamp:	Timestamp at which soc woke.
+ * @wake_pin: The pin that has triggered wake up.
+ * @mode: The last entered low power mode.
+ * @rsvd:	Reserved for future use.
+ *
+ * Response to a generic message with message type TI_SCI_MSG_LPM_WAKE_REASON,
+ * used to query the wake up source, pin and entered low power mode.
+ */
+struct ti_sci_msg_resp_lpm_wake_reason {
+	struct ti_sci_msg_hdr hdr;
+	u32 wake_source;
+	u64 wake_timestamp;
+	u8 wake_pin;
+	u8 mode;
+	u32 rsvd[2];
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
index 1f1871e23f76..fd104b666836 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -199,6 +199,31 @@ struct ti_sci_clk_ops {
 #define TISCI_MSG_VALUE_IO_ENABLE			1
 #define TISCI_MSG_VALUE_IO_DISABLE			0
 
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
+			       u32 *source, u64 *timestamp, u8 *pin, u8 *mode);
+	int (*set_device_constraint)(const struct ti_sci_handle *handle,
+				     u32 id, u8 state);
+	int (*set_latency_constraint)(const struct ti_sci_handle *handle,
+				      u16 latency, u8 state);
+};
+
 /**
  * struct ti_sci_resource_desc - Description of TI SCI resource instance range.
  * @start:	Start index of the first resource range.
@@ -543,6 +568,7 @@ struct ti_sci_ops {
 	struct ti_sci_core_ops core_ops;
 	struct ti_sci_dev_ops dev_ops;
 	struct ti_sci_clk_ops clk_ops;
+	struct ti_sci_pm_ops pm_ops;
 	struct ti_sci_rm_core_ops rm_core_ops;
 	struct ti_sci_rm_irq_ops rm_irq_ops;
 	struct ti_sci_rm_ringacc_ops rm_ring_ops;
-- 
2.45.2


