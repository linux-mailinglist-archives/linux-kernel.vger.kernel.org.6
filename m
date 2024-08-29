Return-Path: <linux-kernel+bounces-307632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B5596509C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664B11C2250B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1B41BAEFA;
	Thu, 29 Aug 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a3cE2c+N"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1301BA882
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962581; cv=none; b=J/8jsKC6SLnT5F37Wp+x+UzMz484F2ET435i9jcV5pq6pfpgaqymAvizm9Rz6khMaeRQvhtt83WJ/l5vzTf/WxNaTWMloXIjC96918ch70KgZemH7Ze1MQFxH1nk+CLOoCPMBvZR4+GGYyQAJSvgZn3MP7p9T6D3kbCWvkSlluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962581; c=relaxed/simple;
	bh=So+QR1H7UTFsrN2KzCZH+aJD18yr6yPO4k39Loh9Vos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8prJJtAHmKk5P0DzawR4ARrPjv+7edcWqfed9pbmOqen3OlV1SFyFWp/q1eh7sceetll3jIHt+QvLgbzch1nQRBcfcwEyNnim2I6sHOuQYsb/FspLr6MF95KxgepixwifLCKdambDLXuZ+Hk04UudBWvIdtFKwIxQNnxvEitnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a3cE2c+N; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso11942525e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724962577; x=1725567377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LodsHN6ErMm8ud8I1c+jnkeAh6yIwKqYwAyRW5ne69Y=;
        b=a3cE2c+NbEHdcvMxC2fbllu2jXdJJ0Yz+9kXmf+VfrjTuboG8ht0suLdmTUmHN/lEr
         MYEZlq67QlzHZFAMzMqElk79BqH0VkAAl7ujCMXbuD6QWRBNbFcteVxu5e+kb9G9EMan
         zEyuKqTCJsbA/xOinGyBMrpaurpQlbhXbbbRsK1mgFdbDViC4vpUtZigAwPVctBO6LJL
         Sq6VXP0OhnSc9DalpfOQ7O7LnK0BUpL+nr8xo8dJaXXKW5np7f9/cjk28fK2ZYPXIdaP
         NX+tNXa+2NF+gmof3pzzfCOEBThRwkQjfeMRE+Nk/nc0MxyqN1j8FaTUOTYS+/UkjVcY
         lb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962577; x=1725567377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LodsHN6ErMm8ud8I1c+jnkeAh6yIwKqYwAyRW5ne69Y=;
        b=uRF7i1XczlkbK656du56ieTS8GgH8JsKCTL+iuHsHwmJxWjP9OOdNqXVb/CJygxVQv
         3OCOKPQMhwdxiCQdy9nTxMPJxZloBtfKWGfvz5b9v3+bLRk3oVTsKtna1TnPsy5V5fI3
         LtP1sWsdTZ0UbH/Cooq6ed0sENwP8qXZ7IHVGTqqp/26dlhoI1gDe2MqO9DK7viWDlHz
         /wHxk8K0LPNjnAQsiFYi0Z9G3rDLlaZcl1gceW0xcSTeNKqC/mldA7AyUqikVypZVGaK
         fLq+zAX7Ae+VKhQWNST1HM+JkA2DauR1redUkB4Ge4iqV/mLS1uGPPxPDkoseaQuAEnY
         nLCA==
X-Forwarded-Encrypted: i=1; AJvYcCW/pAyEzfuKALVovB0s8r4gfa89wh5s7wC+eBjEXCQlTJP26aW16G1eOmf/Jh1+v6z311JJlEEw+xSY0go=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrM9fCQ8oewqXi3PbKGpMOzv6WjRniDuTgyQrG3G5LEo3pU2ih
	gOjCj9KQ9qSdfh+UZBMYAV7l3l3jwO8zCZYW3WDZzWQzhYRNA0d1Z6BDeVpOTlA=
X-Google-Smtp-Source: AGHT+IECSB50MXx+BfwG2vtb8X49S00D85Tdel6FMzdTwn5cB4lcbHCao7mKV+rdfS5rjMk+B3kojA==
X-Received: by 2002:a05:600c:1c83:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-42bb01edc2amr39072725e9.26.1724962576803;
        Thu, 29 Aug 2024 13:16:16 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:802f:3a47:b29:5530:28a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb303sm26681385e9.9.2024.08.29.13.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 13:16:16 -0700 (PDT)
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
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v11 2/4] firmware: ti_sci: Add system suspend and resume call
Date: Thu, 29 Aug 2024 22:16:03 +0200
Message-ID: <20240829201606.1407773-3-msp@baylibre.com>
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

From: Vibhore Vardhan <vibhore@ti.com>

Introduce system suspend call that enables the ti_sci driver to support
low power mode when the user space issues a suspend to mem.

The following power management operations defined in the TISCI
Low Power Mode API [1] are implemented to support suspend and resume:

1) TISCI_MSG_PREPARE_SLEEP
Prepare the SOC for entering into a low power mode and
provide details to firmware about the state being entered.

2) TISCI_MSG_SET_IO_ISOLATION
Control the IO isolation for Low Power Mode.

Also, write a ti_sci_prepare_system_suspend call to be used in the driver
suspend handler to allow the system to identify the low power mode being
entered and if necessary, send TISCI_MSG_PREPARE_SLEEP with information
about the mode being entered.

Sysfw version >= 10.00.04 support LPM_DM_MANAGED capability [2], where
Device Mgr firmware now manages which low power mode is chosen. Going
forward, this is the default configuration supported for TI AM62 family
of devices. The state chosen by the DM can be influenced by sending
constraints using the new LPM constraint APIs.

In case the firmware does not support LPM_DM_MANAGED mode, the mode
selection logic can be extended as needed. If no suspend-to-RAM modes
are supported, return without taking any action.

We're using "pm_suspend_target_state" to map the kernel's target suspend
state to SysFW low power mode. Make sure this is available only when
CONFIG_SUSPEND is enabled.

Suspend has to be split into two parts, ti_sci_suspend() will send
the prepare sleep message to prepare suspend. ti_sci_suspend_noirq()
sets IO isolation which needs to be done as late as possible to avoid
any issues. On resume this has to be done as early as possible.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html

Co-developed-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c              | 196 +++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              |  45 +++++-
 include/linux/soc/ti/ti_sci_protocol.h |   4 +
 3 files changed, 244 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index bed7c8892341..8a772b378ffa 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/suspend.h>
 #include <linux/sys_soc.h>
 #include <linux/reboot.h>
 
@@ -1655,6 +1656,68 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
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
+	if (!ti_sci_is_response_ack(resp)) {
+		dev_err(dev, "Failed to prepare sleep\n");
+		ret = -ENODEV;
+	}
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
 /**
  * ti_sci_msg_cmd_query_fw_caps() - Get the FW/SoC capabilities
  * @handle:		Pointer to TI SCI handle
@@ -1716,6 +1779,61 @@ static int ti_sci_msg_cmd_query_fw_caps(const struct ti_sci_handle *handle,
 	return ret;
 }
 
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
+	if (!ti_sci_is_response_ack(resp)) {
+		dev_err(dev, "Failed to set IO isolation\n");
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
@@ -3327,6 +3445,83 @@ static int tisci_reboot_handler(struct sys_off_data *data)
 	return NOTIFY_BAD;
 }
 
+static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
+{
+	/*
+	 * Map and validate the target Linux suspend state to TISCI LPM.
+	 * Default is to let Device Manager select the low power mode.
+	 */
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_MEM:
+		if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
+			/*
+			 * For the DM_MANAGED mode the context is reserved for
+			 * internal use and can be 0
+			 */
+			return ti_sci_cmd_prepare_sleep(&info->handle,
+							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED,
+							0, 0, 0);
+		} else {
+			/* DM Managed is not supported by the firmware. */
+			dev_err(info->dev, "Suspend to memory is not supported by the firmware\n");
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		/*
+		 * Do not fail if we don't have action to take for a
+		 * specific suspend mode.
+		 */
+		return 0;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused ti_sci_suspend(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	int ret;
+
+	ret = ti_sci_prepare_system_suspend(info);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int __maybe_unused ti_sci_suspend_noirq(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct dev_pm_ops ti_sci_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend = ti_sci_suspend,
+	.suspend_noirq = ti_sci_suspend_noirq,
+	.resume_noirq = ti_sci_resume_noirq,
+#endif
+};
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3495,6 +3690,7 @@ static struct platform_driver ti_sci_driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
 		   .suppress_bind_attrs = true,
+		   .pm = &ti_sci_pm_ops,
 	},
 };
 module_platform_driver(ti_sci_driver);
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 73ca9503606b..8efe4d0e61fb 100644
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
@@ -36,6 +36,10 @@
 #define TI_SCI_MSG_QUERY_CLOCK_FREQ	0x010d
 #define TI_SCI_MSG_GET_CLOCK_FREQ	0x010e
 
+/* Low Power Mode Requests */
+#define TI_SCI_MSG_PREPARE_SLEEP	0x0300
+#define TI_SCI_MSG_SET_IO_ISOLATION	0x0307
+
 /* Resource Management Requests */
 #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
 
@@ -567,6 +571,45 @@ struct ti_sci_msg_resp_get_clock_freq {
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
 #define TI_SCI_IRQ_SECONDARY_HOST_INVALID	0xff
 
 /**
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index bd0d11af76c5..1f1871e23f76 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -195,6 +195,10 @@ struct ti_sci_clk_ops {
 			u64 *current_freq);
 };
 
+/* TISCI LPM IO isolation control values */
+#define TISCI_MSG_VALUE_IO_ENABLE			1
+#define TISCI_MSG_VALUE_IO_DISABLE			0
+
 /**
  * struct ti_sci_resource_desc - Description of TI SCI resource instance range.
  * @start:	Start index of the first resource range.
-- 
2.45.2


