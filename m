Return-Path: <linux-kernel+bounces-418608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031B99D636F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F347286CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56221DFE04;
	Fri, 22 Nov 2024 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l9Td/uRz"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80761DFD81
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297221; cv=none; b=KgQuXH/m0wptIAdaR2R4wtc6a/jDsLXr//T2U0FercfPhQ15WBCsoL0KybGa2cnNiP7Grc0IjorWSmeRVKXjrAF4atjpCRX7E+cQUuHqpCanwU/iqfCFLxHfsbTN9JPVR4Rvb94SQPeq/8oq/z/mO+5qkBhADYzXeh5ShDic8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297221; c=relaxed/simple;
	bh=SCfy0dApgGX+lpHvDT1/XuRFRQohNG3DK0neA2CKyeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a/cqReos2kG/WGKyYNgwxBFNlYDmJqTmzT/RnQq4SvCV17eFhVN0dpr6l7b4nl4/nmvR44+/n5q9OLdqy9trWfLv53NVfYSmc7mgLcHmCg7m1xZ9Bw9Y5ORmD8i1vWVIjYO4qMc3Va8paBkkpPYN2PPm3p5xdPZ64rQWGkaEmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l9Td/uRz; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71807ad76a8so1203768a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732297216; x=1732902016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8g2971JtnzakT9wizgzatOYjfeGd7svZ1JYymTP3R20=;
        b=l9Td/uRz/GlbOeClCnMwJS/mtRFzhaqMHBnvLahsoJj6mBJMu0ffUaB6vNUaP/pp3y
         lN0tGyUtY2SmGUsg9+dH9z4ixTK+ZSify21SSCOjRemor+hlXtAZUZUKRvGyeDZZ5TOa
         KGTKmJLf8eYDemIpX8Rf5rE5aYOQgH8Wtkp6y0QTBEnjxP70ZTDYhv5qIHzaRVDmDX5w
         dY9c8N2NS5ZDZJeH89sWVkwfN7mA7/J+mb+AM3+ASh3r6MgqoWaKJSQkT6Le2bh3ekC6
         peGjUbb4MBxJ25/nIRyPt1utlHyLYY1hUaIpuS5HyA+r0cn2HUrv4bud4/H6629pzSJ6
         mi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297216; x=1732902016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g2971JtnzakT9wizgzatOYjfeGd7svZ1JYymTP3R20=;
        b=tCTV1EoqOryHzxmyjz6cPcm6TUPYnhvGoAEmcckhE5VAPzDT8gTE5hcMXjV1+1cXDp
         hKuY922gSkhGWGKT7PVQbgFA4uOKBxY9wTU6yedAFRGNdXtyLNUtcu5pzztxTcAZlkCW
         xfnfUj6wx/LsE2xNHRCSVNyAoPrsaEo2ME4v/6nM0+9syEQmsD9s9chLFbxiVfymAAzq
         lKxPyFTaatJUE1x8kjIInQ+3IGLkIjpZpS4/vnZRP0k5bv3E+7eyKujrl6iUD4Ubcpxe
         rv4Inh5fwEjYBL0U6uTLrAdWB4IcP5DqJ/kMTLQcVJyI2VdoRT7E+F9wOocoVVy8RK9d
         OgQw==
X-Forwarded-Encrypted: i=1; AJvYcCUeE4TaHB6NFaENCpubGS6e+tfO0G3Ksawh1BwCyh0BRexDPy+/TOKNb5+0cC3W3OEl/9S29bNNBgNnqqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69QHalRT49+tLmIn71MexcCr3Kf7T8TFeczGb3RZk+NrQImDG
	Wm5gG+dhQhekjXaHi17sil+pyBZxFuiX6ilA0nKcR8BNKbGS0dT+lJ07NNDatwDuztHvGIg7csB
	y
X-Gm-Gg: ASbGnctQlEeqjyle59bdZ/lEIaV5mBF1kKFVUPwa6Q2Asm03AWPqr3mO6U3JHTOkfwU
	0BkyQzmGjmPX9tDkQ4xUhzDUtHcI37Jz9zhC48dyl8EVUmoTI/jUrhJHb3qBPhFM/IQcgMxyAnO
	Rg5pM/ZasL4dFtACHyvRyBHc9RZv5MKU0qQmoH/697f0QqMJASoOMhqmP4DNjOdCn6/Ry69ZnS9
	6nzOCIR+i27ezxynyjzq1oVffeBIC9PCUmso3KqUbD9iygFDKKF34QWMFWkCnfKHP30qKC1HyIF
	dzHcag==
X-Google-Smtp-Source: AGHT+IH5I32inTVM2hFsmDF4gYIw+2BugAKmtZa29eyRhS+bMhKLQsivsxU2d1tSVp0EUGffei4JHg==
X-Received: by 2002:a05:6830:1110:b0:718:b83:8f7e with SMTP id 46e09a7af769-71c04cea89dmr3455090a34.24.1732297214492;
        Fri, 22 Nov 2024 09:40:14 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0381c976sm494572a34.50.2024.11.22.09.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:40:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 22 Nov 2024 11:39:53 -0600
Subject: [PATCH 2/2] iio: adc: ad7173: make struct ad_sigma_delta_info
 ad7173_sigma_delta_info const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-2-d05c02324b73@baylibre.com>
References: <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com>
In-Reply-To: <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guillaume Ranquet <granquet@baylibre.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Make struct ad_sigma_delta_info ad7173_sigma_delta_info static const.
This structure is shared by all instances of the driver, so it can't be
safely modified by one instance without affecting all other instances.

The num_slots field was being modified, so we need to make two copies of
the structure, one for each possible value of num_slots. Then we add a
field to the chip-specific info struct to point to the correct copy of
the struct ad_sigma_delta_info depending on the chip's capabilities.

In order to do this, all of the chip-specific info structs have to be
moved after the struct ad_sigma_delta_info definitions.

Fixes: 76a1e6a42802 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 469 +++++++++++++++++++++++++----------------------
 1 file changed, 249 insertions(+), 220 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 5215584438bf..ab2a7a16c477 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -166,6 +166,7 @@ struct ad7173_device_info {
 	unsigned int clock;
 	unsigned int id;
 	char *name;
+	const struct ad_sigma_delta_info *sd_info;
 	bool has_current_inputs;
 	bool has_vincom_input;
 	bool has_temp;
@@ -257,223 +258,6 @@ static unsigned int ad4111_current_channel_config[] = {
 	0x18B, /* 12:IIN3+   11:IIN3− */
 };
 
-static const struct ad7173_device_info ad4111_device_info = {
-	.name = "ad4111",
-	.id = AD4111_ID,
-	.num_voltage_in_div = 8,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_voltage_in = 8,
-	.num_gpios = 2,
-	.higher_gpio_bits = true,
-	.has_temp = true,
-	.has_vincom_input = true,
-	.has_input_buf = true,
-	.has_current_inputs = true,
-	.has_int_ref = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad4112_device_info = {
-	.name = "ad4112",
-	.id = AD4112_ID,
-	.num_voltage_in_div = 8,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_voltage_in = 8,
-	.num_gpios = 2,
-	.higher_gpio_bits = true,
-	.has_vincom_input = true,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_current_inputs = true,
-	.has_int_ref = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad4113_device_info = {
-	.name = "ad4113",
-	.id = AD4113_ID,
-	.num_voltage_in_div = 8,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_voltage_in = 8,
-	.num_gpios = 2,
-	.data_reg_only_16bit = true,
-	.higher_gpio_bits = true,
-	.has_vincom_input = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad4114_device_info = {
-	.name = "ad4114",
-	.id = AD4114_ID,
-	.num_voltage_in_div = 16,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_voltage_in = 16,
-	.num_gpios = 4,
-	.has_vincom_input = true,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad4115_device_info = {
-	.name = "ad4115",
-	.id = AD4115_ID,
-	.num_voltage_in_div = 16,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_voltage_in = 16,
-	.num_gpios = 4,
-	.has_vincom_input = true,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.clock = 8 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad4115_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad4115_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad4116_device_info = {
-	.name = "ad4116",
-	.id = AD4116_ID,
-	.num_voltage_in_div = 11,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_voltage_in = 16,
-	.num_gpios = 4,
-	.has_vincom_input = true,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.clock = 4 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad4116_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad4116_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7172_2_device_info = {
-	.name = "ad7172-2",
-	.id = AD7172_2_ID,
-	.num_voltage_in = 5,
-	.num_channels = 4,
-	.num_configs = 4,
-	.num_gpios = 2,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_pow_supply_monitoring = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7172_4_device_info = {
-	.name = "ad7172-4",
-	.id = AD7172_4_ID,
-	.num_voltage_in = 9,
-	.num_channels = 8,
-	.num_configs = 8,
-	.num_gpios = 4,
-	.has_input_buf = true,
-	.has_ref2 = true,
-	.has_pow_supply_monitoring = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7173_8_device_info = {
-	.name = "ad7173-8",
-	.id = AD7173_ID,
-	.num_voltage_in = 17,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_gpios = 4,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_ref2 = true,
-	.clock = 2 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7173_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7175_2_device_info = {
-	.name = "ad7175-2",
-	.id = AD7175_2_ID,
-	.num_voltage_in = 5,
-	.num_channels = 4,
-	.num_configs = 4,
-	.num_gpios = 2,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_pow_supply_monitoring = true,
-	.clock = 16 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7175_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7175_8_device_info = {
-	.name = "ad7175-8",
-	.id = AD7175_8_ID,
-	.num_voltage_in = 17,
-	.num_channels = 16,
-	.num_configs = 8,
-	.num_gpios = 4,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_ref2 = true,
-	.has_pow_supply_monitoring = true,
-	.clock = 16 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7175_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7176_2_device_info = {
-	.name = "ad7176-2",
-	.id = AD7176_ID,
-	.num_voltage_in = 5,
-	.num_channels = 4,
-	.num_configs = 4,
-	.num_gpios = 2,
-	.has_int_ref = true,
-	.clock = 16 * HZ_PER_MHZ,
-	.sinc5_data_rates = ad7175_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
-};
-
-static const struct ad7173_device_info ad7177_2_device_info = {
-	.name = "ad7177-2",
-	.id = AD7177_ID,
-	.num_voltage_in = 5,
-	.num_channels = 4,
-	.num_configs = 4,
-	.num_gpios = 2,
-	.has_temp = true,
-	.has_input_buf = true,
-	.has_int_ref = true,
-	.has_pow_supply_monitoring = true,
-	.clock = 16 * HZ_PER_MHZ,
-	.odr_start_value = AD7177_ODR_START_VALUE,
-	.sinc5_data_rates = ad7175_sinc5_data_rates,
-	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
-};
-
 static const char *const ad7173_ref_sel_str[] = {
 	[AD7173_SETUP_REF_SEL_EXT_REF]    = "vref",
 	[AD7173_SETUP_REF_SEL_EXT_REF2]   = "vref2",
@@ -752,7 +536,7 @@ static int ad7173_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
 	return ad_sd_write_reg(sd, AD7173_REG_CH(chan), 2, 0);
 }
 
-static struct ad_sigma_delta_info ad7173_sigma_delta_info = {
+static const struct ad_sigma_delta_info ad7173_sigma_delta_info_4_slots = {
 	.set_channel = ad7173_set_channel,
 	.append_status = ad7173_append_status,
 	.disable_all = ad7173_disable_all,
@@ -764,6 +548,252 @@ static struct ad_sigma_delta_info ad7173_sigma_delta_info = {
 	.read_mask = BIT(6),
 	.status_ch_mask = GENMASK(3, 0),
 	.data_reg = AD7173_REG_DATA,
+	.num_slots = 4,
+};
+
+static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots = {
+	.set_channel = ad7173_set_channel,
+	.append_status = ad7173_append_status,
+	.disable_all = ad7173_disable_all,
+	.disable_one = ad7173_disable_one,
+	.set_mode = ad7173_set_mode,
+	.get_irq_by_name = true,
+	.has_registers = true,
+	.addr_shift = 0,
+	.read_mask = BIT(6),
+	.status_ch_mask = GENMASK(3, 0),
+	.data_reg = AD7173_REG_DATA,
+	.num_slots = 8,
+};
+
+static const struct ad7173_device_info ad4111_device_info = {
+	.name = "ad4111",
+	.id = AD4111_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in_div = 8,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 8,
+	.num_gpios = 2,
+	.higher_gpio_bits = true,
+	.has_temp = true,
+	.has_vincom_input = true,
+	.has_input_buf = true,
+	.has_current_inputs = true,
+	.has_int_ref = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad4112_device_info = {
+	.name = "ad4112",
+	.id = AD4112_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in_div = 8,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 8,
+	.num_gpios = 2,
+	.higher_gpio_bits = true,
+	.has_vincom_input = true,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_current_inputs = true,
+	.has_int_ref = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad4113_device_info = {
+	.name = "ad4113",
+	.id = AD4113_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in_div = 8,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 8,
+	.num_gpios = 2,
+	.data_reg_only_16bit = true,
+	.higher_gpio_bits = true,
+	.has_vincom_input = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad4114_device_info = {
+	.name = "ad4114",
+	.id = AD4114_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in_div = 16,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 16,
+	.num_gpios = 4,
+	.has_vincom_input = true,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad4115_device_info = {
+	.name = "ad4115",
+	.id = AD4115_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in_div = 16,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 16,
+	.num_gpios = 4,
+	.has_vincom_input = true,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.clock = 8 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad4115_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad4115_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad4116_device_info = {
+	.name = "ad4116",
+	.id = AD4116_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in_div = 11,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_voltage_in = 16,
+	.num_gpios = 4,
+	.has_vincom_input = true,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.clock = 4 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad4116_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad4116_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7172_2_device_info = {
+	.name = "ad7172-2",
+	.id = AD7172_2_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in = 5,
+	.num_channels = 4,
+	.num_configs = 4,
+	.num_gpios = 2,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_pow_supply_monitoring = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7172_4_device_info = {
+	.name = "ad7172-4",
+	.id = AD7172_4_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in = 9,
+	.num_channels = 8,
+	.num_configs = 8,
+	.num_gpios = 4,
+	.has_input_buf = true,
+	.has_ref2 = true,
+	.has_pow_supply_monitoring = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7173_8_device_info = {
+	.name = "ad7173-8",
+	.id = AD7173_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in = 17,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_gpios = 4,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_ref2 = true,
+	.clock = 2 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7173_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7175_2_device_info = {
+	.name = "ad7175-2",
+	.id = AD7175_2_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in = 5,
+	.num_channels = 4,
+	.num_configs = 4,
+	.num_gpios = 2,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_pow_supply_monitoring = true,
+	.clock = 16 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7175_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7175_8_device_info = {
+	.name = "ad7175-8",
+	.id = AD7175_8_ID,
+	.sd_info = &ad7173_sigma_delta_info_8_slots,
+	.num_voltage_in = 17,
+	.num_channels = 16,
+	.num_configs = 8,
+	.num_gpios = 4,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_ref2 = true,
+	.has_pow_supply_monitoring = true,
+	.clock = 16 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7175_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7176_2_device_info = {
+	.name = "ad7176-2",
+	.id = AD7176_ID,
+	.sd_info = &ad7173_sigma_delta_info_4_slots,
+	.num_voltage_in = 5,
+	.num_channels = 4,
+	.num_configs = 4,
+	.num_gpios = 2,
+	.has_int_ref = true,
+	.clock = 16 * HZ_PER_MHZ,
+	.sinc5_data_rates = ad7175_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+};
+
+static const struct ad7173_device_info ad7177_2_device_info = {
+	.name = "ad7177-2",
+	.id = AD7177_ID,
+	.sd_info = &ad7173_sigma_delta_info_4_slots,
+	.num_voltage_in = 5,
+	.num_channels = 4,
+	.num_configs = 4,
+	.num_gpios = 2,
+	.has_temp = true,
+	.has_input_buf = true,
+	.has_int_ref = true,
+	.has_pow_supply_monitoring = true,
+	.clock = 16 * HZ_PER_MHZ,
+	.odr_start_value = AD7177_ODR_START_VALUE,
+	.sinc5_data_rates = ad7175_sinc5_data_rates,
+	.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 };
 
 static int ad7173_setup(struct iio_dev *indio_dev)
@@ -1429,8 +1459,7 @@ static int ad7173_probe(struct spi_device *spi)
 	spi->mode = SPI_MODE_3;
 	spi_setup(spi);
 
-	ad7173_sigma_delta_info.num_slots = st->info->num_configs;
-	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7173_sigma_delta_info);
+	ret = ad_sd_init(&st->sd, indio_dev, spi, st->info->sd_info);
 	if (ret)
 		return ret;
 

-- 
2.43.0


