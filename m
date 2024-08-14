Return-Path: <linux-kernel+bounces-286772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C149951EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2503D282B34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459C1B86CA;
	Wed, 14 Aug 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NuYKvywH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71A1B4C46
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649999; cv=none; b=h6qZtj9HIVHit5Cg4xcRC6JKwAA+D5XXZx2Fk1tHBGbEorvONZM356jua+3psdE+zFRY6Gw6Z1BrgX1Mi17VPAfIi9vCg2OnGBjGwRdv7ubd2QXxNoRuAYaQB5Ucfu8Rr0DClatDmuVzmL0c20RBT2+EZr9UZ6m4UR7x1hiABGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649999; c=relaxed/simple;
	bh=xyA5dliytXUpbWO7v2epgoP88Le1MsYfwoAy1nBVk+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KqBqnhy34/oJrkAnyKflScmk1jBShvJs2wMCFbs76CJSsMoCGe+uyDGIwG+6vtyYWIxJMf5Dwh6GJcxiqLf/QmGOj/tCZTI6DwN0TPQaramMynY46VSTydT6M9mDSjrgcww5mvEaGUlqPr/nUa7wIqZmg37cMAmg581p9CPWTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NuYKvywH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc52394c92so61471245ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723649997; x=1724254797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uO4MyaKUc9bmjiuuyPvs+rb8eIrbgGn8c1dFfmNv0w4=;
        b=NuYKvywH3cl1JDgasNRjXnkjU0v+ed64sd4G04jnctvGd7ft/0hiQuKwp4ut5ty5nn
         erAAz0LXLvEeKyZ6BbIvbOCZPII6NlnAESqxPdPsZ+vVe73mYJ7g1V3DFhfmsV0E4uqz
         eJbcDlmudZ0S2s/ua6ZVsOWl3IV4HQ10YOF4s0sx3r/2Ha+OXJ2WLoWoO2Oxyx+2y6kF
         41psxgrjQHs4gi/eEtjHuZGQA9JJIXFNexpq0j703JsH+NMlZ56Zv3yz1cJca0HsIMff
         zenuyDnDDkJAFkeE29aXsgNpxp6VX7dwI+uZC6J3+Oi38lACJ4Vnlo8cRQkRIj79r52C
         QNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723649997; x=1724254797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO4MyaKUc9bmjiuuyPvs+rb8eIrbgGn8c1dFfmNv0w4=;
        b=NL0JpXa1XBLkCpc0UsromXb99f3akawn6+Vyj5/mfyKjM7zwNVk2JjU+WkSy8Ncegp
         IvvynbpeN6zK9NYBKDsyx/hK957s6PM7hJRvn8LBlZZe+iSjtZQncbw1FCU4F3UAeYiV
         AN29FmndSJqbqQL0k5h5pFDle2csjRHR+YfgfXAB9Pk4RdBFTqngtyBbC6+uYK8m7Nso
         xN1xdxNKlVKtcr7IGy/Mzhw04GeYABAVT3IvN6ri6JbfOPQ97MVY81eF5uOoDYNl4Dhs
         2hXI0YcLK1E017hL/n2KN7ZsjwZL+GLCXPfXDqskoI53THkzb33WLUSrM5G+8GUUqcD6
         07/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUU6SwuEN89LywwkT5KYqJkhr/aoI9L3fJPd4P7YuUXvHc2txWYA+NXcBcRPM6IRM5dVpKZoKpDA6+CZ4kE9d4klhuZf/H0VehOZUf1
X-Gm-Message-State: AOJu0YxhqslLlA47gRjQ+L/sddcqUHrXT2UV4BAQ54fEG03p0hlS6DIF
	vBCQ2IpCTZGYe6gg96IZp0oYX28BcLIg92m56SNYKWpJAei4+WZ2FbHjPDTBQ3M=
X-Google-Smtp-Source: AGHT+IFG2MHs0YyP2eBi5ugkdj+fq/r1ld/Md39wf06Uk2jsQ6U9aRM7t0s5xZi33X1KxVfIsJ/HhQ==
X-Received: by 2002:a17:903:1211:b0:1ff:39d4:1663 with SMTP id d9443c01a7336-201d648b6damr33819125ad.47.1723649996645;
        Wed, 14 Aug 2024 08:39:56 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14c729sm31057595ad.118.2024.08.14.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:39:55 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
Date: Wed, 14 Aug 2024 08:39:30 -0700
Subject: [PATCH v10 3/4] firmware: ti_sci: Introduce Power Management Ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-lpm-constraints-firmware-msp-v10-3-bee4314bbdc8@baylibre.com>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
In-Reply-To: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=14911; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=fSvGYH6bEljQwJMgBnVzuMSmfecbP7FGCrchyJkV3Mc=;
 b=owEBbQKS/ZANAwAKAVk3GJrT+8ZlAcsmYgBmvM/Ieqt73LbDKz7vJLiUye7cptks5xH3Y5cfJ
 byoACHUCrGJAjMEAAEKAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCZrzPyAAKCRBZNxia0/vG
 ZYv6EACXja8sFYXgAl8bQ0L9T5cU5B6aedtosv1B5CFvLTD+mWrrHLINeZoA3Tmkg2D7CznVLTn
 0w64fCw7T84BIZJdmz4qtf09CURprpN3v7grNpD1y44wsIvPWDxdz4jgabHrYESaRNHN65DDwFm
 9Lv7h/loeP1OvazU7azAtfS61uJO8dq/oIKNk8x/lY5MR47IiXMQjEJ5blcROoRZSN3AG/S19vb
 55XktjEg+c9G/gAkZLYvnUPMuxlvrHr59541HkH+wgz2KA+O1EvJIG6O/FQRgxWQ/2cHtkQPt+D
 T92P2N4IMo6mAb7WnJpZecVgYMzJH3UChAKcZV806iaksRh7TASarvn1gWGYkuGH2Gs8uTER0z/
 M/MbA8/3pjeYFk0yMRUV0jZ0VRsdrLN/dKJfQBB+rKy1prX44cV7KIg+ScAh+aCX13o79Soz8Ib
 I3VhVSmnZQJTgHtims/2EIYRvnPWaM5r9oPlfSSAt5GFroEoU+YV7043mPte0WCY0H5PG/Zdiap
 qkhOSHF5Ay2PkFSaQatTeQqgK073pS/WWjH3Hi5o915duZMIdey2vKNOoDrsoD7BmcS/MUXjHab
 ZddE0Mj6+YXbiDz28UZEz13VRL1NKXzwG/L+qEKeGQdVx/rcomGa+2GH8rLdB51nY2QuaOMyrBg
 w7Ah9tTjIcHrcNw==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

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
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/firmware/ti_sci.c              | 189 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              |  76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h |  42 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 307 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 808149dcc635..107494406fa5 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1822,6 +1822,179 @@ static int ti_sci_cmd_set_io_isolation(const struct ti_sci_handle *handle,
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
@@ -2964,6 +3137,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_core_ops *core_ops = &ops->core_ops;
 	struct ti_sci_dev_ops *dops = &ops->dev_ops;
 	struct ti_sci_clk_ops *cops = &ops->clk_ops;
+	struct ti_sci_pm_ops *pmops = &ops->pm_ops;
 	struct ti_sci_rm_core_ops *rm_core_ops = &ops->rm_core_ops;
 	struct ti_sci_rm_irq_ops *iops = &ops->rm_irq_ops;
 	struct ti_sci_rm_ringacc_ops *rops = &ops->rm_ring_ops;
@@ -3003,6 +3177,13 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
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
@@ -3490,12 +3671,20 @@ static int ti_sci_resume_noirq(struct device *dev)
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
 	dev_dbg(dev, "%s: disable isolation: %d\n", __func__, ret);
 
+	ti_sci_msg_cmd_lpm_wake_reason(&info->handle, &source, &time, &pin, &mode);
+	dev_info(dev, "ti_sci: wakeup source:0x%x, pin:0x%x, mode:0x%x\n",
+		 source, pin, mode);
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
index 1f1871e23f76..4ba9e520a28f 100644
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
@@ -543,6 +584,7 @@ struct ti_sci_ops {
 	struct ti_sci_core_ops core_ops;
 	struct ti_sci_dev_ops dev_ops;
 	struct ti_sci_clk_ops clk_ops;
+	struct ti_sci_pm_ops pm_ops;
 	struct ti_sci_rm_core_ops rm_core_ops;
 	struct ti_sci_rm_irq_ops rm_irq_ops;
 	struct ti_sci_rm_ringacc_ops rm_ring_ops;

-- 
2.46.0


