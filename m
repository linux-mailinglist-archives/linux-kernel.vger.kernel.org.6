Return-Path: <linux-kernel+bounces-271817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF99945390
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A085DB228E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B192314B083;
	Thu,  1 Aug 2024 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SMqrIhz3"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AB14A4F1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542085; cv=none; b=usFGf0ysI+0n8DQO3AFBZz6TgNGuwiKOfUwSp7RjK4vWkX01QU9uM3NDHAwJosd3Xi45wLNGheRq/hjsnNkS+QhaHc3IfPNzZaYAGQR5CNt5XkcNO44VZlDqJn4v5zk2bHNzdV11lZ3yqWBX4PIA5+ufuJc8PlKWJeSkePCClmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542085; c=relaxed/simple;
	bh=rL0hcYGtSYJQm+Eh4Yv65LHtTUtuzz1aKk2dHpP/qj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPhV2U+Df/92EsznqvXR7A/8nph7heGpQZ+q8O8ktvVLxhAk8udmdFJeX0Ob4R3k96CiWFCClaVNW9NJI4Ke9w3dNKx6mWNu+/FIgZHWOz7q4DGUzEbSxEqjwTxYiFs7RsL8u3ix7sI/exyQ67EoWY1+irV9tsktSalOEiSdF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SMqrIhz3; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-81f86fd9305so395404339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722542082; x=1723146882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyBzGSbNNZJyJGVpSGqO2w0XbdSg5iJM/LiLsJKmnYE=;
        b=SMqrIhz3A3te/VY5ccxXgNGY5BfGjSK9vMUbH62eTa3hK0WbJd48TYp48/YcsAhrrR
         X6AV0n6PT7TjRcXLBXlfWZr+ZzEJ8AniFClTClDCFWVINJkMRo/cpGcsJwilcK06yRHy
         7DkLjRzFBcjvfham+CT0NQHJkVXDQjkit1n8waSnXpkLwrvL4QmsMDleAIeh7/4H+CzO
         8/L+ZuLARghpDd3+a+FOLWwxBdPPTEbjTIWszD/oq4eVaW+kypPq0Wi9D0D/LfujRq1T
         5jn5j+gEO49mo+IcsCbIJIbX1/Ub2APlwX3Tv4wU6IW3Ki46v7rHeCfWUFDpXWProuxo
         uDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542082; x=1723146882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyBzGSbNNZJyJGVpSGqO2w0XbdSg5iJM/LiLsJKmnYE=;
        b=lvfPIdn95mY/Z4xBVGw9FNNB13YpiNTBHWjULJymfYlInF5c9g426SSQnp4S6M5P1q
         NgRB23/703yAdRkC4pmWM9TvNpbWOeegTlQWVEXFfI+YTS5wE3DJ7PhvnxZBmzGFd+Hk
         Je/u40RoCx+VWoSSCEsv0oiLbEmWVCJN31xfOW1RVTH8PME8wtsXEXEBUfpYSwnobs9y
         HXzN/CqlCI9L/IcHZYAKj1oDy7ujdiKWOwWYNmn11Ls7n522hDnPOAsfJ2US6KkUIG3e
         P8MpPBiSqF/xDdfTx9DzYzwg7Dnmv39gUvfQVQ9VY1dJxR1UI1/LCkrSMk70Z2yh2fKa
         UX+w==
X-Forwarded-Encrypted: i=1; AJvYcCX/W4coaFDxMiRI1OkwFTpY7+8VQFHUC81dc/9/JXiIBtzTe+sqAG1ptzQqZiIKzs0iAVENrPztknnxuJM8snH6LpMztg4XwLuSk8BX
X-Gm-Message-State: AOJu0Yyqulc2qy527X9dHrWW/np6l2y5ClmR0JwFMyGMmuiqsSobj/7s
	pXAM3330HNdien4jarH8e6zP0hsYSsEZpJkyCnifFwFkszKfgDOkxYo3ls2EDCk=
X-Google-Smtp-Source: AGHT+IFl+970XEoy5uqLBNmw845i1qcDK7YO6hUwnU+h8RGtqZWfTI63SVaF3Is2/uZ0PhhKUvZAfg==
X-Received: by 2002:a05:6602:6c08:b0:81f:8bed:7035 with SMTP id ca18e2360f4ac-81fd435559dmr172824539f.3.1722542081693;
        Thu, 01 Aug 2024 12:54:41 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d1b7ddsm14395039f.3.2024.08.01.12.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:54:41 -0700 (PDT)
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
Subject: [PATCH v8 1/3] firmware: ti_sci: Introduce Power Management Ops
Date: Thu,  1 Aug 2024 21:54:20 +0200
Message-ID: <20240801195422.2296347-2-msp@baylibre.com>
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

From: Dave Gerlach <d-gerlach@ti.com>

Introduce power management ops supported by the TISCI
Low Power Mode API [1].

1) TISCI_MSG_PREPARE_SLEEP
Prepare the SOC for entering into a low power mode and
provide details to firmware about the state being entered.

2) TISCI_MSG_LPM_WAKE_REASON
Get which wake up source woke the SoC from Low Power Mode.
The wake up source IDs will be common for all K3 platforms.

3) TISCI_MSG_SET_IO_ISOLATION
Control the IO isolation for Low Power Mode.

4) TISCI_MSG_LPM_SET_DEVICE_CONSTRAINT
Set LPM constraint on behalf of a device. By setting a constraint, the
device ensures that it will not be powered off or reset in the selected
mode.

5) TISCI_MSG_LPM_SET_LATENCY_CONSTRAINT
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
 drivers/firmware/ti_sci.c              | 283 ++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h              | 115 +++++++++-
 include/linux/soc/ti/ti_sci_protocol.h |  46 ++++
 3 files changed, 442 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 160968301b1f..3599aeecef86 100644
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
 
@@ -1651,6 +1651,284 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_cmd_prepare_sleep() - Prepare system for system suspend
+ * @handle:		pointer to TI SCI handle
+ * @mode:		Device identifier
+ * @ctx_lo:		Low part of address for context save
+ * @ctx_hi:		High part of address for context save
+ * @debug_flags:	Debug flags to pass to firmware
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
+				    u32 ctx_lo, u32 ctx_hi, u32 debug_flags)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_msg_req_prepare_sleep *req;
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
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+
+	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
+	req->mode = mode;
+	req->ctx_lo = ctx_lo;
+	req->ctx_hi = ctx_hi;
+	req->debug_flags = debug_flags;
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
+ * ti_sci_cmd_set_io_isolation() - Enable IO isolation in LPM
+ * @handle:		Pointer to TI SCI handle
+ * @state:		The desired state of the IO isolation
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_set_io_isolation(const struct ti_sci_handle *handle,
+				       u8 state)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_msg_req_set_io_isolation *req;
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
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_SET_IO_ISOLATION,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+	req = (struct ti_sci_msg_req_set_io_isolation *)xfer->xfer_buf;
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
@@ -2793,6 +3071,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_core_ops *core_ops = &ops->core_ops;
 	struct ti_sci_dev_ops *dops = &ops->dev_ops;
 	struct ti_sci_clk_ops *cops = &ops->clk_ops;
+	struct ti_sci_pm_ops *pmops = &ops->pm_ops;
 	struct ti_sci_rm_core_ops *rm_core_ops = &ops->rm_core_ops;
 	struct ti_sci_rm_irq_ops *iops = &ops->rm_irq_ops;
 	struct ti_sci_rm_ringacc_ops *rops = &ops->rm_ring_ops;
@@ -2832,6 +3111,8 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	cops->set_freq = ti_sci_cmd_clk_set_freq;
 	cops->get_freq = ti_sci_cmd_clk_get_freq;
 
+	pmops->lpm_wake_reason = ti_sci_msg_cmd_lpm_wake_reason;
+
 	rm_core_ops->get_range = ti_sci_cmd_get_resource_range;
 	rm_core_ops->get_range_from_shost =
 				ti_sci_cmd_get_resource_range_from_shost;
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 5846c60220f5..424bc192ce3e 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -6,7 +6,7 @@
  * The system works in a message response protocol
  * See: https://software-dl.ti.com/tisci/esd/latest/index.html for details
  *
- * Copyright (C)  2015-2016 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C)  2015-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __TI_SCI_H
@@ -35,6 +35,13 @@
 #define TI_SCI_MSG_QUERY_CLOCK_FREQ	0x010d
 #define TI_SCI_MSG_GET_CLOCK_FREQ	0x010e
 
+/* Low Power Mode Requests */
+#define TI_SCI_MSG_PREPARE_SLEEP	0x0300
+#define TI_SCI_MSG_LPM_WAKE_REASON	0x0306
+#define TI_SCI_MSG_SET_IO_ISOLATION	0x0307
+#define TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT	0x0309
+#define TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT	0x030A
+
 /* Resource Management Requests */
 #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
 
@@ -545,6 +552,112 @@ struct ti_sci_msg_resp_get_clock_freq {
 	u64 freq_hz;
 } __packed;
 
+/**
+ * struct tisci_msg_req_prepare_sleep - Request for TISCI_MSG_PREPARE_SLEEP.
+ *
+ * @hdr				TISCI header to provide ACK/NAK flags to the host.
+ * @mode			Low power mode to enter.
+ * @ctx_lo			Low 32-bits of physical pointer to address to use for context save.
+ * @ctx_hi			High 32-bits of physical pointer to address to use for context save.
+ * @debug_flags			Flags that can be set to halt the sequence during suspend or
+ *				resume to allow JTAG connection and debug.
+ *
+ * This message is used as the first step of entering a low power mode. It
+ * allows configurable information, including which state to enter to be
+ * easily shared from the application, as this is a non-secure message and
+ * therefore can be sent by anyone.
+ */
+struct ti_sci_msg_req_prepare_sleep {
+	struct ti_sci_msg_hdr	hdr;
+
+#define TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED				0xfd
+	u8			mode;
+	u32			ctx_lo;
+	u32			ctx_hi;
+	u32			debug_flags;
+} __packed;
+
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
+ * struct tisci_msg_set_io_isolation_req - Request for TI_SCI_MSG_SET_IO_ISOLATION.
+ *
+ * @hdr:	Generic header
+ * @state:	The deseared state of the IO isolation.
+ *
+ * This message is used to enable/disable IO isolation for low power modes.
+ * Response is generic ACK / NACK message.
+ */
+struct ti_sci_msg_req_set_io_isolation {
+	struct ti_sci_msg_hdr hdr;
+	u8 state;
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
index bd0d11af76c5..9f92a8071972 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -195,6 +195,51 @@ struct ti_sci_clk_ops {
 			u64 *current_freq);
 };
 
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
+/* TISCI LPM IO isolation control values */
+#define TISCI_MSG_VALUE_IO_ENABLE			1
+#define TISCI_MSG_VALUE_IO_DISABLE			0
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
@@ -539,6 +584,7 @@ struct ti_sci_ops {
 	struct ti_sci_core_ops core_ops;
 	struct ti_sci_dev_ops dev_ops;
 	struct ti_sci_clk_ops clk_ops;
+	struct ti_sci_pm_ops pm_ops;
 	struct ti_sci_rm_core_ops rm_core_ops;
 	struct ti_sci_rm_irq_ops rm_irq_ops;
 	struct ti_sci_rm_ringacc_ops rm_ring_ops;
-- 
2.45.2


