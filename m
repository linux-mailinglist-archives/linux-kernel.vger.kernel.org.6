Return-Path: <linux-kernel+bounces-448091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 663219F3AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F2916C8B1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EC31D63D0;
	Mon, 16 Dec 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QyPAmi97"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6BF1D514B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381477; cv=none; b=uhhDr77MjS71BtvPTMzlcIGOVHcos0xf8MM/2ssT8TLhpoIn/wJMcROTxkb29zja19Lyswn2iPISCLuU0gPHJjCWn/cqCMhA9+Ua2xmiZE9H50YHH4tZ5D731CJJCnkWt4u5ndJIgNImfKSxi9VCOqOojnRZV5H/PewBl6e5QCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381477; c=relaxed/simple;
	bh=2TNtd8bu9LxPRIrOodJUWYgJ1168COuSyLXsxGXbSEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=THBJw2X7KM+4WsZEXitBJcD3LyR1Rerq0VzVh+FHihvD6d9ph+JNmtYBbx6WRq8evEVrIk1omBWZBB2CbHt6FNu8MDJJoAGYufsQ8/FnSf7lMJ/YFN66VbinVRUd7bXH7qqo5Pwlj0hvuCZTqlbstPtViSMHAm0TAoMBOexVjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QyPAmi97; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361d5dcf5bso49883145e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381474; x=1734986274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJIklXOID+OyZc6zxu5hCcPuRwlOSwyq9lkiHYE4XLg=;
        b=QyPAmi97HiyoOrNiF1e+cZlgGR5eyiCWYGFy2x8eqYUFWFzxlo+KC1tAMkfRVcUaIW
         aAAd7ia2qU2krClnelA6no3dQFTrAFeLxfePC7cG3gbiuofBXB2GovU/qV9XSPs1wgWr
         EwBgp9jVs+kjZxDgf9DoLUWxOtnjtHtlpE6BFpmEyxgHSCpETwIUe3eYVsxJkO3OD86T
         yJJoktOgPUFjhpQQpm7grrxe2UXpKFZxvEvb9WcDMrNZVKtCiTg5EKMDKK4BQ03vDp4l
         ud9NkW8U0ZJKrsDejlsrGVIEp+pzjZIRNZDACTRk6t/J9RZwiVTx27y8sbEj5djct5py
         lsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381474; x=1734986274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJIklXOID+OyZc6zxu5hCcPuRwlOSwyq9lkiHYE4XLg=;
        b=OFLjn8Q6opxOrA41lEFNyoNSyeCPbiTT/nUNxo+kMUwDg7ge6d9w7w6TxAba9x+6Qt
         HMJB8Op4xPT2W/0arBGDwqdYoPFrUbZ7kI7oDwyz51vvxifg5cssDBZtbhv93tkEELBJ
         6JMX0D40EEoJEisuw5d/cKmoJshkctESOrIQwU9fEQPNIbCItyej7bkZgIWPDA4GblDx
         aneQisxIHn3Ug2MFpsOgFzrVlLlJCsCnNZKP/czdqr0ulDMQedxWvMtal6a64H5i8M5G
         mQEkO7P1qRxKVw/bLOlVx+kj8cgZNgPsf3X1tcsqyha3+7UYY2DPdaBObSzVme48ybF4
         FPBg==
X-Forwarded-Encrypted: i=1; AJvYcCUOUQsG3IbfuLOh2CosehJFtMeG/RO+Wg2aBDMiRx95+Fk2KPGRsECGICZD5r8PFKKJHhsuwFIQtBkJ3A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHlusayDZV+IYIC7bggwP3D51pcAgMz5U6rvQGJmIVVBBuBG6
	eVhAvGBvDd5SiGbDhuYisXoVzIf1L8nu3WofBdEdmUY2pUJo/6pGOgq2QwayhdQ=
X-Gm-Gg: ASbGncuGg+S9BJ0WPz+8toRxvY8DjVlle7gC3nZsnQ5fcDjduUF0HA0TKwe+q4lZud8
	4WZUBCvn9uqLgn3OpHbSysoL/zyAx+NvuF4Om4WZVsPK3saeEMPtIuAdbUsoBD6/cQp4kqm8jXT
	rAswu+QqFi6LJBA1NHbpVfrmDuDh5Fsfj/HYo1OCXOxHB2K8lPAV+k/Lg8BXBWwUfahQI0ub5eV
	F2F0y0q9eKo3rVE+mmAqcqCQlHTa8QzLi9nMx0C7DuFgKrnxqJ500diVEnyAuHcjWyuOYoeQp5J
	/9eZRiP65hb4E1llCe/tYQebGiRWpAQnFQ==
X-Google-Smtp-Source: AGHT+IEqQC7MOTbxN57stiY7bAykjPNYWOaM2c6G5oj9OGIy69wCD6fru70qM6fFomrs0Q01tRwbOg==
X-Received: by 2002:a05:600c:510f:b0:434:f9e1:5cf8 with SMTP id 5b1f17b1804b1-4362aa9fe20mr134933515e9.31.1734381473773;
        Mon, 16 Dec 2024 12:37:53 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:53 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:25 +0100
Subject: [PATCH 5/8] iio: dac: adi-axi-dac: add bus mode setup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-5-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

The ad354xr requires DSPI mode to work in buffering mode, so
backend needs to allow a mode selection between:
    SPI  (entire ad35xxr family),
    DSPI (ad354xr),
    QSPI (ad355xr).

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index d02eb535b648..f7d22409e9b3 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -64,7 +64,7 @@
 #define   AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
 #define AXI_DAC_CUSTOM_CTRL_REG			0x008C
 #define   AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
-#define   AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
+#define   AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE	GENMASK(3, 2)
 #define   AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
 #define   AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
 
@@ -95,6 +95,12 @@ enum {
 	AXI_DAC_DATA_INTERNAL_RAMP_16BIT = 11,
 };
 
+enum multi_io_mode {
+	AXI_DAC_MULTI_IO_MODE_SPI,
+	AXI_DAC_MULTI_IO_MODE_DSPI,
+	AXI_DAC_MULTI_IO_MODE_QSPI,
+};
+
 struct axi_dac_info {
 	unsigned int version;
 	const struct iio_backend_info *backend_info;
@@ -725,6 +731,43 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
 }
 
+static int axi_dac_interface_type_set(struct iio_backend *back,
+				      enum iio_backend_interface_type type)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int mode, ival, ret;
+
+	switch (type) {
+	case IIO_BACKEND_INTERFACE_SERIAL_SPI:
+		mode = AXI_DAC_MULTI_IO_MODE_SPI;
+		break;
+	case IIO_BACKEND_INTERFACE_SERIAL_DSPI:
+		mode = AXI_DAC_MULTI_IO_MODE_DSPI;
+		break;
+	case IIO_BACKEND_INTERFACE_SERIAL_QSPI:
+		mode = AXI_DAC_MULTI_IO_MODE_QSPI;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+			AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE,
+			FIELD_PREP(AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE, mode));
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(st->regmap,
+			AXI_DAC_UI_STATUS_REG, ival,
+			FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
+			10, 100 * KILO);
+
+	if (ret == -ETIMEDOUT)
+		dev_err(st->dev, "AXI read timeout\n");
+
+	return ret;
+}
+
 static void axi_dac_child_remove(void *data)
 {
 	platform_device_unregister(data);
@@ -774,6 +817,7 @@ static const struct iio_backend_ops axi_ad3552r_ops = {
 	.request_buffer = axi_dac_request_buffer,
 	.free_buffer = axi_dac_free_buffer,
 	.data_source_set = axi_dac_data_source_set,
+	.interface_type_set = axi_dac_interface_type_set,
 	.ddr_enable = axi_dac_ddr_enable,
 	.ddr_disable = axi_dac_ddr_disable,
 	.data_stream_enable = axi_dac_data_stream_enable,

-- 
2.47.0


