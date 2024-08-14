Return-Path: <linux-kernel+bounces-286770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EB6951EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E280D282B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7A1B5816;
	Wed, 14 Aug 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TxcFUWr8"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689DE1B4C45
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649998; cv=none; b=SAHx2jlfAucXflH8d0mXtzpAroeFfrJ1grhEVQFgtqec0WQsqXNZEflYpmZZqNSAaEaRFl99cN6zhfx/DzOqjZm7BzEYuudkg8lKe/U/g5lZekmX0ZjKlY6qixhsLBuN7FkXRM5j2Wz6z1hrSzhg1o2I85WDQkNCLkfb/2irNUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649998; c=relaxed/simple;
	bh=fJGypyEgJLhCF7Ad1296756iOFBRzBXWK1WwIuco6Ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crYFNABcYbEIHF00/2OLT1xWisj4ZI/5a0uRlZcMJLXVYGi5PWFIThwHEv/j+qYTDPtn5MfQDav07UomSJRWyFsP9FnI7xxCGlcsNC7VqbVR6KSvQK3UCKESV9T+g+df8/LeQfmjx/vIq2JVc+uxOC/lIm002jTmTagICZZOxa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TxcFUWr8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc566ac769so61153355ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723649996; x=1724254796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVC8+R3o277w5fNoilij6jhy0Uz3vrCP4aj5epdO9AI=;
        b=TxcFUWr8eMwJkLl9JQBOzy2lTVApzPvV93zttxbadcCnbq1HGBPEq5QcfzONU6kKzD
         i/frzxU5iX0N37V2Lt1gvk4SRi05RY+zgfSd8PGsDI392Ipmy8y2WRITRl9CsOQdhdz4
         qRI5Z4mR3/btw3WWWZBXu6SWRdlAPqMPnuAMyfF6K632wh8+e6+qG/MwoGgjk+2vwUgP
         Zgd/ochW8iY4dVM6vSKFSmGpPEdcCvHTIdCxBSeYeXl4mtmaz1UUq/j2Riz7N+v5HmW1
         EMAYwVGBSgnuxwoVtQsyhbmoMi6vRQRIJM6r7GSKm02veQp+QJBYGwhFMbtoDa0atNKR
         QrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649996; x=1724254796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVC8+R3o277w5fNoilij6jhy0Uz3vrCP4aj5epdO9AI=;
        b=n48/oiH2d/arLBfHivsPMqYJWIa1hRkgJI7iVEfxWjTI6Uivs38r9ci4BhhVVosv7B
         zVo6+l3JUs5igrnCqtu2IL/2Zf8BEmMBSHBHvzdzbs53/+Y4dKPuNcIhfyp02eh3VwbW
         SD25oAmmIZ6tSLdJivMbWiN7ZCxI7EJUB0suPUQJ2p1gNJISPa/fGpywf6KJUGjKFEZ5
         aSNvxFZEexXFnCK5dzqqjHv9ZXXR+7tLQOXaicQEelBirADrXy/I2Xhxjaw0Z7Tz+M09
         7UyyltMG7vUOP008/oAiYNhTn1unYg6QwOWrNEGDJKe+Oi26RxHyafqXpLJhJKg2wmfq
         ecFA==
X-Forwarded-Encrypted: i=1; AJvYcCVVwTGTfImenfnWiDkA9pEEdaS48CIZ2DY5yd3deM9DDNtkXKYIVYrQ+LJ4sQF2U57ShwTEE3MYM/9fz9fwMIfQGNRZtCWtxf2puD21
X-Gm-Message-State: AOJu0YxrkSCBmCTIfZZ1ZOEauPlZ9ZeEXoYwjodhKsxBqJOyVoHjRPlR
	5DDtRVdzabXFCr+M/FbXdBAK7zMknaqlp5Hd+kfF3DXu5CUMT4K8E5kxOtNW3pA=
X-Google-Smtp-Source: AGHT+IF5oDNr91igBSg2NfRwuOvbCVJoL4vmoO1/1J8Fnt1BqFQUkyXIHnt6DufRL2VaEduL5OBEIg==
X-Received: by 2002:a17:902:dad2:b0:1ff:4a1e:865c with SMTP id d9443c01a7336-201d642a47amr34790655ad.29.1723649995515;
        Wed, 14 Aug 2024 08:39:55 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1cfae8sm30998135ad.264.2024.08.14.08.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:39:54 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Wed, 14 Aug 2024 08:39:29 -0700
Subject: [PATCH v10 2/4] firmware: ti_sci: Add system suspend and resume
 call
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-lpm-constraints-firmware-msp-v10-2-bee4314bbdc8@baylibre.com>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
In-Reply-To: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=11683; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=SApvXlKvTU624fFIvy/O4UZ3820V3is+SI1BRhZolQg=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmvM/Ie+n+Nf3UcgIudixyFrsttDD2YnNWjE6RM
 noHtGd/VMWJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZrzPyAAKCRBZNxia0/vG
 ZUH9D/oDFbGSy0yrvCYC2a9tvln5b9lk1Oe4O1iqylXwy6bOQ4Q9kp+7CV4OModr9zxJPQrm8Y+
 Rb90Wexniq/T233MTyydLh6miZhaMsYKxyX3PdIiTL5J8wJXgcrUk/InT0z3Q5ACGDrIlYvnWpF
 S9nDb6GP5rh67UHzIdJNUPi8ygqCwKRQgIbFQkfx8lJGpV3Qh9DqH+4Vu8i+7ByJFF7GD+J9f6z
 gruedE4zauyliLjq5mlnv6ekts9gtvYW4/9bm8qiaRkAkuW5K9daubXmtbEU1e6Cl+E4pXAwl/f
 V8xVy+ScqJtOYn/O5U9NwiyjQU2vCSZmw/lu3NIpFpQL5JMtXFTXmy3ikmO+879qVVN7/aIemzz
 Q8JIsyEjGryo6Cad4LEze3QiJkoZtRQh7+EslA9VMdovvunCf0GLiF9gJhTKn1MA7uAbgPwBSUt
 QIyyH+EWlZUN2NrR1DDKYWmoJZId0TPKc0cSfswI7XpTPYfIqDw3i1TKpOogX6ZeQVKTkn914gl
 mWAU1Cu6Y6pGTDxkrOSPtJKaotdXYz0EDkW+zWQP5OHKprCgeBh3BlzK8OOc/oJFkByA8ioEkJe
 9kgkKgRweIMsR4Lh5JErMLullMGfpjyVj2RQ80eMPEa+fj1tpkwTk3D2dRvr6Z0qf9JTNHqayPS
 CULLTb0VnvNGw/Q==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

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
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/firmware/ti_sci.c              | 188 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              |  45 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/soc/ti/ti_sci_protocol.h |   4 ++++
 3 files changed, 236 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index f77e13577eb8..808149dcc635 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/suspend.h>
 #include <linux/sys_soc.h>
 #include <linux/reboot.h>
 
@@ -1654,6 +1655,65 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
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
 /**
  * ti_sci_msg_cmd_query_fw_caps() - Get the FW/SoC capabilities
  * @handle:		Pointer to TI SCI handle
@@ -1710,6 +1770,58 @@ static int ti_sci_msg_cmd_query_fw_caps(const struct ti_sci_handle *handle,
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
@@ -3321,6 +3433,79 @@ static int tisci_reboot_handler(struct sys_off_data *data)
 	return NOTIFY_BAD;
 }
 
+#ifdef CONFIG_SUSPEND
+static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
+{
+	u8 mode;
+
+	/*
+	 * Map and validate the target Linux suspend state to TISCI LPM.
+	 * Default is to let Device Manager select the low power mode.
+	 */
+	switch (pm_suspend_target_state) {
+	case PM_SUSPEND_MEM:
+		if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED)
+			mode = TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED;
+		else
+			/* DM Managed is not supported by the firmware. */
+			return -EOPNOTSUPP;
+		break;
+	default:
+		/*
+		 * Do not fail if we don't have action to take for a
+		 * specific suspend mode.
+		 */
+		return 0;
+	}
+
+	return ti_sci_cmd_prepare_sleep(&info->handle, mode, 0, 0, 0);
+}
+
+static int ti_sci_suspend(struct device *dev)
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
+static int ti_sci_suspend_noirq(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
+	if (ret)
+		return ret;
+	dev_dbg(dev, "%s: set isolation: %d\n", __func__, ret);
+
+	return 0;
+}
+
+static int ti_sci_resume_noirq(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
+	if (ret)
+		return ret;
+	dev_dbg(dev, "%s: disable isolation: %d\n", __func__, ret);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ti_sci_pm_ops = {
+	.suspend = ti_sci_suspend,
+	.suspend_noirq = ti_sci_suspend_noirq,
+	.resume_noirq = ti_sci_resume_noirq,
+};
+#endif  /* CONFIG_SUSPEND */
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3490,6 +3675,9 @@ static struct platform_driver ti_sci_driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
 		   .suppress_bind_attrs = true,
+#ifdef CONFIG_SUSPEND
+		   .pm = &ti_sci_pm_ops,
+#endif
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
2.46.0


