Return-Path: <linux-kernel+bounces-265304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E2593EF4F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433E41C21C20
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E0E13B28A;
	Mon, 29 Jul 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uw89me4f"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E3137903
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240079; cv=none; b=S5gqbKG/u5GRg0+2Qp3E9pLX6RBkzhqj1XjsCRigQZg4txSrj/eS773q7DZR6/flTZfsv2Z4ihmDXQyiX8OguZwNaLiRXzzHIUJ2xyJ8FB17CMKfBzOkseBVCt6kHmX9rQm4zDy1WB+Jpm+lmzL7Lxz7qHkJvjxDNpSSRYyQwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240079; c=relaxed/simple;
	bh=hJv3UAfhwjYG8ZjCYDVvzpEw+klMfDJfd0O09UN1Icg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4R5AzGuZlm2//+g44qctHAHewJHlhv7PTG2W+AwboOKlmxxkfUI1etkeFaXw+1QCG0PNq5wmqOYMOaDWZLYQCaOnSfF+xVIixoS2fBxSHKDfSuyS593Sn76iz7RRjaYGiLzjxHQgf0MRVO6VeTeZWeker4z38O8guCWpm0fHSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uw89me4f; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so36028371fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722240075; x=1722844875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaL7q+hiN8Znt9KwWlJ8p8DadxVN8fjOTmOOEp7Y4Nk=;
        b=uw89me4fZCkZAAKTO4yEA065FsS9mY4vBUrdQmOBeF8hpgnntWS29JnvHryWsWXSHp
         UVzSmljZe6cZYdIScNzJe9n55Dx+Tev2wSANC+jBg+aH/gpflJT/s8V+CjEXyKPWg2Pg
         Um0k5eDHiMVC5nvVVOUp58GVjbmDrO1k+Cea7ymMG2f+yqwCQMr0RgGQAPTDhlGtQS+e
         KKMWtbbc8KZP78ofYAtBkMM86jJCe//5iL3uV+PKFctjM3zzmqP0PbDYHfYSv3ceHmQz
         oLS7MtSg0HU3Pzcoipo2wji7O8Cs9XSHUEorh8NQkAMMHeN6SplsaFRmXvAN013kS1ye
         o8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240075; x=1722844875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaL7q+hiN8Znt9KwWlJ8p8DadxVN8fjOTmOOEp7Y4Nk=;
        b=v9uJMX+bxSDObaAYKw77qDNoEZapwZaez8BjrYrdK5/+OioRzTbdFwVBLn/U/5AYsr
         Njp1FBDrRkvIlJfVgyQzh7bwkmxQO2SDK9rtAZRsRvO/k3BxzFdQ8aRnyuNwieDS5/mE
         P9xC6D/daJ6BPB5AnQ96IXyO8oQuDKUpajeV96O2ksIuCVMy+tPBpi0kNFHxt1lXyFFa
         Rit+zUboP4QVHwvoW3fstZxAEZg9XEv3heFhVsw8l/5yzy/9H/0tq7nd06Z7IDy/HMzs
         W66WlE0JtKXMofupMLkGxATeGVBU07Kp5mpr6B4uOXr+IIb8iWYR5ESvldB7vU28XPij
         PiZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuQIXHd/b9bG4rTPPjzWpM6vSEN360mpfSP5lrObFTsvV5tbK0le9iDMkAmn+ILi3t5KKTQK0L+FMYY4rP2Q+5t2J7BG1txA6WmuLW
X-Gm-Message-State: AOJu0Yx/jpZ9ObPFjfQh8A39bRbk7XV7x4DmYBrVghZgyY9iDumCF6jp
	slHbDApYilh1c/EkXxoqgACAU3JE0B0d5fBg5CZD6oNTNswkwON/SYaY1OBDYNk=
X-Google-Smtp-Source: AGHT+IGtANNWAtpJ37DU4Kxw1e1nJWCUhsfVu/g/dZDrwXEI/bbW1ovATxt7o4e1cFRfgvw2yE0d6w==
X-Received: by 2002:a2e:7c07:0:b0:2ec:5c94:3d99 with SMTP id 38308e7fff4ca-2f12edf8009mr44140081fa.2.1722240074606;
        Mon, 29 Jul 2024 01:01:14 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42819d9a007sm45452635e9.1.2024.07.29.01.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:01:14 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 2/6] firmware: ti_sci: Partial-IO support
Date: Mon, 29 Jul 2024 10:00:57 +0200
Message-ID: <20240729080101.3859701-3-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729080101.3859701-1-msp@baylibre.com>
References: <20240729080101.3859701-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Partial-IO poweroff. In Partial-IO pins of a few modules
can generate system wakeups while DDR memory is not powered resulting in
a fresh boot of the system. The modules that can be wakeup sources are
defined by the devicetree.

Only wakeup sources that are actually enabled by the user will be
considered as a an active wakeup source. If none of the wakeup sources
are enabled the system will do a normal poweroff. If at least one wakeup
source is enabled it will instead send a TI_SCI_MSG_PREPARE_SLEEP
message from the sys_off handler. Sending this message will result in an
immediate shutdown of the system. No execution is expected after this
point. The code will enter an infinite loop.

The wakeup source device nodes are gathered during probe. But they are
only resolved to the actual devices in the sys_off handler, if they
exist. If they do not exist, they are ignored.

A short documentation about Partial-IO can be found in section 6.2.4.5
of the TRM at
  https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 160 +++++++++++++++++++++++++++++++++-----
 drivers/firmware/ti_sci.h |  34 ++++++++
 2 files changed, 175 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 160968301b1f..ba2e56da0215 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -99,6 +99,9 @@ struct ti_sci_desc {
  * @node:	list head
  * @host_id:	Host ID
  * @users:	Number of users of this instance
+ * @nr_wakeup_sources: Number of device nodes in wakeup_source_nodes
+ * @wakeup_source_nodes: Array of all device_nodes listed as wakeup sources in
+ *			 the devicetree
  */
 struct ti_sci_info {
 	struct device *dev;
@@ -116,6 +119,9 @@ struct ti_sci_info {
 	u8 host_id;
 	/* protected by ti_sci_list_mutex */
 	int users;
+
+	int nr_wakeup_sources;
+	struct device_node **wakeup_source_nodes;
 };
 
 #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
@@ -392,10 +398,13 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
 static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 				 struct ti_sci_xfer *xfer)
 {
+	struct ti_sci_msg_hdr *hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
 	int ret;
 	int timeout;
 	struct device *dev = info->dev;
 	bool done_state = true;
+	bool response_expected = !!(hdr->flags & (TI_SCI_FLAG_REQ_ACK_ON_PROCESSED |
+						  TI_SCI_FLAG_REQ_ACK_ON_RECEIVED));
 
 	ret = mbox_send_message(info->chan_tx, &xfer->tx_message);
 	if (ret < 0)
@@ -403,25 +412,27 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 
 	ret = 0;
 
-	if (system_state <= SYSTEM_RUNNING) {
-		/* And we wait for the response. */
-		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
-		if (!wait_for_completion_timeout(&xfer->done, timeout))
-			ret = -ETIMEDOUT;
-	} else {
-		/*
-		 * If we are !running, we cannot use wait_for_completion_timeout
-		 * during noirq phase, so we must manually poll the completion.
-		 */
-		ret = read_poll_timeout_atomic(try_wait_for_completion, done_state,
-					       done_state, 1,
-					       info->desc->max_rx_timeout_ms * 1000,
-					       false, &xfer->done);
-	}
+	if (response_expected) {
+		if (system_state <= SYSTEM_RUNNING) {
+			/* And we wait for the response. */
+			timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
+			if (!wait_for_completion_timeout(&xfer->done, timeout))
+				ret = -ETIMEDOUT;
+		} else {
+			/*
+			 * If we are !running, we cannot use wait_for_completion_timeout
+			 * during noirq phase, so we must manually poll the completion.
+			 */
+			ret = read_poll_timeout_atomic(try_wait_for_completion, done_state,
+						       done_state, 1,
+						       info->desc->max_rx_timeout_ms * 1000,
+						       false, &xfer->done);
+		}
 
-	if (ret == -ETIMEDOUT)
-		dev_err(dev, "Mbox timedout in resp(caller: %pS)\n",
-			(void *)_RET_IP_);
+		if (ret == -ETIMEDOUT)
+			dev_err(dev, "Mbox timedout in resp(caller: %pS)\n",
+				(void *)_RET_IP_);
+	}
 
 	/*
 	 * NOTE: we might prefer not to need the mailbox ticker to manage the
@@ -3262,6 +3273,82 @@ static int tisci_reboot_handler(struct sys_off_data *data)
 	return NOTIFY_BAD;
 }
 
+/*
+ * Enter Partial-IO, which disables everything including DDR with only a small
+ * logic being active for wakeup.
+ */
+static int tisci_enter_partial_io(struct ti_sci_info *info)
+{
+	struct ti_sci_msg_req_prepare_sleep *req;
+	struct ti_sci_xfer *xfer;
+	struct device *dev = info->dev;
+	int ret = 0;
+
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
+				   TI_SCI_FLAG_REQ_GENERIC_NORESPONSE,
+				   sizeof(*req), sizeof(struct ti_sci_msg_hdr));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+
+	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
+	req->mode = TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO;
+	req->ctx_lo = 0;
+	req->ctx_hi = 0;
+	req->debug_flags = 0;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
+static int tisci_sys_off_handler(struct sys_off_data *data)
+{
+	struct ti_sci_info *info = data->cb_data;
+	int i;
+	int ret;
+	bool enter_partial_io = false;
+
+	for (i = 0; i != info->nr_wakeup_sources; ++i) {
+		struct platform_device *pdev =
+			of_find_device_by_node(info->wakeup_source_nodes[i]);
+
+		if (!pdev)
+			continue;
+
+		if (device_may_wakeup(&pdev->dev)) {
+			dev_dbg(info->dev, "%pOFp identified as wakeup source\n",
+				info->wakeup_source_nodes[i]);
+			enter_partial_io = true;
+		}
+	}
+
+	if (!enter_partial_io)
+		return NOTIFY_DONE;
+
+	ret = tisci_enter_partial_io(info);
+
+	if (ret) {
+		dev_err(info->dev,
+			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
+			ERR_PTR(ret));
+		emergency_restart();
+	}
+
+	while (1);
+
+	return NOTIFY_DONE;
+}
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3398,6 +3485,35 @@ static int ti_sci_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	if (of_property_read_bool(dev->of_node, "ti,partial-io-wakeup-sources")) {
+		info->nr_wakeup_sources =
+			of_count_phandle_with_args(dev->of_node,
+						   "ti,partial-io-wakeup-sources",
+						   NULL);
+		info->wakeup_source_nodes =
+			devm_kzalloc(dev, sizeof(*info->wakeup_source_nodes),
+				     GFP_KERNEL);
+
+		for (i = 0; i != info->nr_wakeup_sources; ++i) {
+			struct device_node *devnode =
+				of_parse_phandle(dev->of_node,
+						 "ti,partial-io-wakeup-sources",
+						 i);
+			info->wakeup_source_nodes[i] = devnode;
+		}
+
+		ret = devm_register_sys_off_handler(dev,
+						    SYS_OFF_MODE_POWER_OFF,
+						    SYS_OFF_PRIO_FIRMWARE,
+						    tisci_sys_off_handler,
+						    info);
+		if (ret) {
+			dev_err(dev, "Failed to register sys_off_handler %pe\n",
+				ERR_PTR(ret));
+			goto out;
+		}
+	}
+
 	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
 		 info->handle.version.abi_major, info->handle.version.abi_minor,
 		 info->handle.version.firmware_revision,
@@ -3407,7 +3523,13 @@ static int ti_sci_probe(struct platform_device *pdev)
 	list_add_tail(&info->node, &ti_sci_list);
 	mutex_unlock(&ti_sci_list_mutex);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "platform_populate failed %pe\n", ERR_PTR(ret));
+		goto out;
+	}
+	return 0;
+
 out:
 	if (!IS_ERR(info->chan_tx))
 		mbox_free_channel(info->chan_tx);
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 5846c60220f5..ec8e6bb1791a 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -35,6 +35,9 @@
 #define TI_SCI_MSG_QUERY_CLOCK_FREQ	0x010d
 #define TI_SCI_MSG_GET_CLOCK_FREQ	0x010e
 
+/* Low Power Mode Requests */
+#define TI_SCI_MSG_PREPARE_SLEEP	0x0300
+
 /* Resource Management Requests */
 #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
 
@@ -545,6 +548,37 @@ struct ti_sci_msg_resp_get_clock_freq {
 	u64 freq_hz;
 } __packed;
 
+#define TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP				0x0
+#define TISCI_MSG_VALUE_SLEEP_MODE_MCU_ONLY				0x1
+#define TISCI_MSG_VALUE_SLEEP_MODE_STANDBY				0x2
+/*
+ * When sending perpare_sleep with MODE_PARTIAL_IO no response will be sent,
+ * no further steps are required. */
+#define TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO				0x3
+
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
+	u8			mode;
+	u32			ctx_lo;
+	u32			ctx_hi;
+	u32			debug_flags;
+} __packed;
+
 #define TI_SCI_IRQ_SECONDARY_HOST_INVALID	0xff
 
 /**
-- 
2.45.2


