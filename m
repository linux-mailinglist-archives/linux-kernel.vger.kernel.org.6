Return-Path: <linux-kernel+bounces-187140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7DC8CCDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EABB22AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7DE13D255;
	Thu, 23 May 2024 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fQx+ycYi"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C32D13CABA
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451357; cv=none; b=jZm4FbF1ttG+fYqNXYsNVUuZYeXu6zcsLP14CBQHrwP0E/owY2dioy6D5Tt2daFEMj+2D1k1JAI+H5OrVJWN8W1clMSjaUkfE2bThp2qQLkKjmxt6CZF/bzbzbRAmEByqWkg8f6+37zr1QAWYFXpj8D1FXE0Mdac1j8gGMB/pFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451357; c=relaxed/simple;
	bh=j8+sHDjNw31cei+wC4fEL/gHqSzt2rHIkiQwgzGG6JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRJsAQibUhsSdRzkeA4osZya0lThpbq9N6dkdKyFvVnaWkmvQ3iZF8JhujxzuleQCrnKLvWSRlDtPOmTVfZ+EDIYlT4JRoL4e0TTS3s5ZreHcfzk5Lp65M1XyX3HoiiH6gF8vtSejLEtBgyrvhzHQ3sOx/rqfTvVjgi4uf24xZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fQx+ycYi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34dc129accaso1666127f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451353; x=1717056153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKfwfIlswqj+NeWyOeSXupSHhvK+FlBEhFYxTgaPgZg=;
        b=fQx+ycYiq/5lpOJzeG2FRDQPqu+t4wwEgWWM1uPfguJ2OscVdBQwtuA6Lyq/cmuMV+
         udKsQbcqhgRqWmBE1IWwMwF3E995ypggUkN3H8w8m50Ydr0n1kS4Hk8UcwV3p17bNsAr
         0rRY/TdJxvt7kJkhRmlHT/CaoDfwM6ikfVaikIPfniucWCCut0B2uJa7VRdLP5zvpbmG
         ThgVo+6jXVCdblE/HI0Uvr8I6YklnhtQ9N5kkW5axw1ZHJ1kschsb+A9jx/73Tdeq1te
         UeqD0QkHwzqPkh8O/EoDsgJBvPnf0MGMhgCvjLtjecKCLzIiVj4PRmslgzl6xBvHkKGT
         Lbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451353; x=1717056153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKfwfIlswqj+NeWyOeSXupSHhvK+FlBEhFYxTgaPgZg=;
        b=plBXCDa8kXoLpt/pk+wXCknJKrxTUAazW/SDiQWr1swAxIP+BEfzqV5tGEArjLHDlb
         Ekoi/ZSF3GNIqYe5yYWHRDjuHIggnHsx2cpb02Sg2eKmgED4r0yQfQjFz46PiYoj0zbz
         zv9sZiT02DwueJHQ0391FLNshu6nSL2k0Yio0TRZdrA0gkA6Fl+hgPMzzCbf4AO0PC9X
         lJx7MhOTXu+6caKHN0tfaT03rT7HvQdPgnCZVTsVV/9+ZgO3TpZnvf6e/+8/sIb7sgsO
         i6cMOTeUnuXI23S7VdlOmkUto3BZLviu9VDz1YUJiALMihWdayJ2y7/G0u8H2vh9Fylv
         90mQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ozjKS/OOb+krXCYZmpz2MP46HeHIuHYTKSLV6y5W6cdXpJeaPtftGS7ErfKgZ9c4Gyu3HC+Kbge4WTmQTcjJ7srUFJGnu9ClqZ+7
X-Gm-Message-State: AOJu0Yx5N2z4i7kMoESBVH2Gzk4rfzOYunAJ2s5Iv8Bl8Qylq5JycZJ2
	uiPk3hN5rgZpAErT5c4da2HnHTZctLGId6O59yJ4SK+dIffnw8mGatO1ikb6L9Q=
X-Google-Smtp-Source: AGHT+IEiGPP2k0Tes52yuipZMzp/g7mrJRY1V/fQrwHdTe2JA41WKN+HYayFlOJdmGCEyJZnrhwD6Q==
X-Received: by 2002:a5d:4007:0:b0:354:e72f:d5d7 with SMTP id ffacd0b85a97d-354e72fd6f3mr2266834f8f.24.1716451353123;
        Thu, 23 May 2024 01:02:33 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35501abfdddsm93637f8f.110.2024.05.23.01.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:02:31 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 2/6] firmware: ti_sci: Partial-IO support
Date: Thu, 23 May 2024 10:02:21 +0200
Message-ID: <20240523080225.1288617-3-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523080225.1288617-1-msp@baylibre.com>
References: <20240523080225.1288617-1-msp@baylibre.com>
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

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 135 +++++++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h |  31 +++++++++
 2 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 160968301b1f..04730c4df2de 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -116,6 +116,9 @@ struct ti_sci_info {
 	u8 host_id;
 	/* protected by ti_sci_list_mutex */
 	int users;
+
+	int nr_wakeup_sources;
+	struct device_node **wakeup_source_nodes;
 };
 
 #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
@@ -380,6 +383,28 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
 	up(&minfo->sem_xfer_count);
 }
 
+/**
+ * ti_sci_do_send() - Do one send, do not expect a response
+ * @info:	Pointer to SCI entity information
+ * @xfer:	Transfer to initiate
+ *
+ * Return: If send error, return corresponding error, else
+ *	   if all goes well, return 0.
+ */
+static inline int ti_sci_do_send(struct ti_sci_info *info,
+				 struct ti_sci_xfer *xfer)
+{
+	int ret;
+
+	ret = mbox_send_message(info->chan_tx, &xfer->tx_message);
+	if (ret < 0)
+		return ret;
+
+	mbox_client_txdone(info->chan_tx, ret);
+
+	return 0;
+}
+
 /**
  * ti_sci_do_xfer() - Do one transfer
  * @info:	Pointer to SCI entity information
@@ -3262,6 +3287,79 @@ static int tisci_reboot_handler(struct sys_off_data *data)
 	return NOTIFY_BAD;
 }
 
+/* Does not return if successful */
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
+	ret = ti_sci_do_send(info, xfer);
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
+	if (ret)
+		dev_err(info->dev,
+			"Failed to enter Partial-IO %pe, halting system\n",
+			ERR_PTR(ret));
+
+	/* Halt system/code execution */
+	while (1)
+		;
+
+	return NOTIFY_DONE;
+}
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3398,6 +3496,35 @@ static int ti_sci_probe(struct platform_device *pdev)
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
@@ -3407,7 +3534,13 @@ static int ti_sci_probe(struct platform_device *pdev)
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
index ef3a8214d002..6d8b12341f68 100644
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
 
@@ -545,6 +548,34 @@ struct ti_sci_msg_resp_get_clock_freq {
 	u64 freq_hz;
 } __packed;
 
+#define TISCI_MSG_VALUE_SLEEP_MODE_DEEP_SLEEP				0x0
+#define TISCI_MSG_VALUE_SLEEP_MODE_MCU_ONLY				0x1
+#define TISCI_MSG_VALUE_SLEEP_MODE_STANDBY				0x2
+#define TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO				0x3
+
+/**
+ * struct tisci_msg_prepare_sleep_req - Request for TISCI_MSG_PREPARE_SLEEP.
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
2.43.0


