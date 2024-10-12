Return-Path: <linux-kernel+bounces-362491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB9999B592
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2861C2152D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4723819922A;
	Sat, 12 Oct 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1Mttlvob"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF851946CA
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728744023; cv=none; b=XJTbgC7nwNYllnVFQHwvatjlWZXLHChgVW+0qBh1qDxEp6uIOc2gNku1vwrO7h+RI8vN3eX5L+u3nW+3JbTJvV0os0GFO+vQRAFIOmCkibq0g13Tyc6YbtJtIMFFp65W8CTf0oFMkP987idGNYlJFXS6JyT83Ijdsrry2BJKrOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728744023; c=relaxed/simple;
	bh=1dNO0ykSJyMHj7nwRx/ZHojCDWMJLTC6mKghrMYyi6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nfsfZoNu3B3PqjHVY+DaXRAnXEJ39/wiKuYQkxAxjSdHljBaWo0SDRZNmh1E58TvLAIModFpBPrf/UEfVfTmUX8wUICNcSrSPFaNTZozRyfYfcla3ymNhOoM6Eq071b/Hmsb5eIrLOsWU+V716osBthq4jtbg9SnJAhUVIybPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1Mttlvob; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99f646ff1bso38529166b.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728744020; x=1729348820; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3sJ/BMf10VX9JK+mjIqHCa6w7KgT4r2r/Tz2Dc9YFM=;
        b=1MttlvobZWSP9BzP8lXsrsZeUBoh1C3yfLNx1a19csQGZb863p9+8xQ2AV0R0n4LtA
         8zrUdVr7AealNOb4PkQUbNAdUkJGYucdKIHIf4BQfvNxktiY6fN+m/vcc9Wk9TY/kMp9
         tK9/eb5Br76gYhr/MorhxSqXvklVOsCsHLwQXV8BOqQgEqY+2wg+AEoKKAFgPP3zhHC1
         hzrysiM1stmNASBhfj+ombd9P7Whsq56PUUiJFnusPf5YEadXFtXaRGuZayglj4JhE7L
         /HWXVSEijd4MgxZ247Z5AMH9wRXvmv4jK/OABkUXbBzUQpI0OqYJQHAfPdPSR5YkHxOV
         pKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728744020; x=1729348820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3sJ/BMf10VX9JK+mjIqHCa6w7KgT4r2r/Tz2Dc9YFM=;
        b=d9wr1A5C9FCnc80heJVz6LPZX6Niy4pNSpjKO2j8RRGliXd5Oy9R7JJsMps3UIHiAE
         fn6Q9EAxDcrjZx3bivjkYVudCGcv5qKAwvL1+ALrlJbSBxMPC7Dl/SWbQPpbi1DSh94T
         vACxoWbmfgluS8D2YDa50Lrra1FKo+Pf1VPi3YdUE9SQj/VSPlZ76SUESUY0lzmtBC8P
         tXwrsWz9M4q3RxgaXe2TjYclM0hx4ri+LyyBovcYEjOceqHfi4elVsPonHRZSZWa8o3E
         VaRE4exE1Vv3zKtV59jQ5iW0dwQ8491yguWaoDcEbLXavp/wWCXiQVSgVzC0S3wiBOMO
         sjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4yejhOVEF8Z6wkKYPgPOI6J5IRRgJcn8LORdvMmj2zd7XhfJzdbxeBqe1wACNnAYIwN/dc6EksPWmq7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLyxkp73zq5LgOe1kNaSpt8xT8lKW8RQsQkjqwZSJAI2cuHgcD
	63HYsf5JGgOFJfAUJvvucBCWFSfpo4R7D98C/EaW67i3m7pdIPhXbpFylkAEc34=
X-Google-Smtp-Source: AGHT+IEfLMWPqMmZhJIeqfEsJCHMFdrk3bveUBzkKtDRVDwhafGQZqqAYTq9jyaDh5E24EX5ws+dvQ==
X-Received: by 2002:a17:907:d01:b0:a99:403e:2578 with SMTP id a640c23a62f3a-a99b9313475mr575175866b.5.1728744019721;
        Sat, 12 Oct 2024 07:40:19 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f3ed51e8sm49965666b.30.2024.10.12.07.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 07:40:19 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Sat, 12 Oct 2024 16:39:28 +0200
Subject: [PATCH v3 2/6] firmware: ti_sci: Partial-IO support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-topic-am62-partialio-v6-12-b4-v3-2-f7c6c2739681@baylibre.com>
References: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
In-Reply-To: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6763; i=msp@baylibre.com;
 h=from:subject:message-id; bh=1dNO0ykSJyMHj7nwRx/ZHojCDWMJLTC6mKghrMYyi6o=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNK5uiwOcTHJZmhaCMhl7y+3aAvmYNtyYa7Aga4d9xn3X
 VlrbGjZUcrCIMbBICumyHL3w8J3dXLXF0Sse+QIM4eVCWQIAxenAEzkShvDf6fHajMjZ8w5tprz
 a2xayv2/AR6xh1d94kw7+ueqz4G7U38wMixSutYpHPD32c0XOUUBYlNczLTL/ZfdUfmzSFb115V
 iXgYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add support for Partial-IO poweroff. In Partial-IO pins of a few
hardware units can generate system wakeups while DDR memory is not
powered resulting in a fresh boot of the system. These hardware units in
the SoC are always powered so that some logic can detect pin activity.

If the system supports Partial-IO as described in the fw capabilities, a
sys_off handler is added. This sys_off handler decides if the poweroff
is executed by entering normal poweroff or Partial-IO instead. The
decision is made by checking if wakeup is enabled on all devices that
may wake up the SoC from Partial-IO.

The possible wakeup devices are found by checking which devices are
powered by the regulator supplying the "vddshv_canuart" line. These are
considered possible wakeup sources. Only wakeup sources that are
actually enabled by the user will be considered as a an active wakeup
source. If none of the wakeup sources are enabled the system will do a
normal poweroff. If at least one wakeup source is enabled it will
instead send a TI_SCI_MSG_PREPARE_SLEEP message from the sys_off
handler. Sending this message will result in an immediate shutdown of
the system. No execution is expected after this point. The code will
wait for 5s and do an emergency_restart afterwards if Partial-IO wasn't
entered at that point.

A short documentation about Partial-IO can be found in section 6.2.4.5
of the TRM at
  https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 130 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h |   5 ++
 2 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 9ef86ea27a3c9ac6b9aa4a838a4f5e9fc09a81a9..fe964e5e2b2a06ba2fb9754537d28661951a6b78 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3746,6 +3746,115 @@ static const struct dev_pm_ops ti_sci_pm_ops = {
 #endif
 };
 
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
+	dev_info(dev, "Entering Partial-IO because a powered wakeup-enabled device was found.\n");
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
+static bool tisci_canuart_wakeup_enabled(struct ti_sci_info *info)
+{
+	static const char canuart_name[] = "vddshv_canuart";
+	struct device_node *wakeup_node = NULL;
+
+	for (wakeup_node = of_find_node_with_property(NULL, "vio-supply");
+	     wakeup_node;
+	     wakeup_node = of_find_node_with_property(wakeup_node, "vio-supply")) {
+		struct device_node *supply_node;
+		const char *supply_name;
+		struct platform_device *pdev;
+		int ret;
+
+		supply_node = of_parse_phandle(wakeup_node, "vio-supply", 0);
+		if (!supply_node)
+			continue;
+
+		ret = of_property_read_string(supply_node, "regulator-name", &supply_name);
+		of_node_put(supply_node);
+		if (ret) {
+			dev_warn(info->dev, "Failed to parse vio-supply phandle at %pOF %d\n",
+				 wakeup_node, ret);
+			continue;
+		}
+
+		if (strncmp(canuart_name, supply_name, strlen(canuart_name)))
+			continue;
+
+		pdev = of_find_device_by_node(wakeup_node);
+		if (!pdev)
+			continue;
+
+		if (device_may_wakeup(&pdev->dev)) {
+			dev_dbg(info->dev, "%pOF identified as wakeup source for Partial-IO\n",
+				wakeup_node);
+			put_device(&pdev->dev);
+			of_node_put(wakeup_node);
+			return true;
+		}
+		put_device(&pdev->dev);
+	}
+
+	return false;
+}
+
+static int tisci_sys_off_handler(struct sys_off_data *data)
+{
+	struct ti_sci_info *info = data->cb_data;
+	bool enter_partial_io = tisci_canuart_wakeup_enabled(info);
+	int ret;
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
+	mdelay(5000);
+	emergency_restart();
+
+	return NOTIFY_DONE;
+}
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3889,6 +3998,19 @@ static int ti_sci_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	if (info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO) {
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
@@ -3898,7 +4020,13 @@ static int ti_sci_probe(struct platform_device *pdev)
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
index 053387d7baa064498e6a208daa7f70040ef87281..dec9e20cbe5da8f6d9393d56bb9a1e73cb083a42 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -592,6 +592,11 @@ struct ti_sci_msg_resp_get_clock_freq {
 struct ti_sci_msg_req_prepare_sleep {
 	struct ti_sci_msg_hdr	hdr;
 
+/*
+ * When sending perpare_sleep with MODE_PARTIAL_IO no response will be sent,
+ * no further steps are required.
+ */
+#define TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO				0x03
 #define TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED				0xfd
 	u8			mode;
 	u32			ctx_lo;

-- 
2.45.2


