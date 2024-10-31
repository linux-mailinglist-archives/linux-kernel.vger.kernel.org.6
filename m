Return-Path: <linux-kernel+bounces-390075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FDA9B7530
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2F21C2198A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE15149C6F;
	Thu, 31 Oct 2024 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rvsYjor/"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563BD149C54
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359077; cv=none; b=bopD2d3CE+0o4Q/uqwfj+lyCZOVqC9CZYOqImHw3Qt6FeAxBgSAMx9/gjlXnhU7BzfIZGKaDnSGEegJPiWCm91zLOKHX3sBYYmj4fx0nQAPIn44jx2/gIuewyMdk3GEHAQ93D+ug0IkREVpgUa62T9I8tXBuoQKRsu714wGGqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359077; c=relaxed/simple;
	bh=j6d0colaxPKycD+GQrCgSDLkv20Xcns4fpDxmhAFBNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kgkQ+zTtSPvW2ekb1MIfd23k2afSugMSJqo8/JfmgLbtqHbRl5Kn8Q9p1UzaYK1eYWYUNsgi1n+7Ec8mgrmVem+PV+Ch0fwF8jW11kjTD2kxFW8Tm6MpLpEwk4SPF5P/q5UhqXQObCKgim+W4aqc0hp3Zl9eD1dtMMMoKgJX7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rvsYjor/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d47eff9acso394707f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730359074; x=1730963874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH5MUt/+cbzy9bnDTQWkFoXyedi+6bP21xIeET9Apek=;
        b=rvsYjor/Om2bO7suxr9Cx5PntCLvajHVWLdchLch+UKKc/OfeQoo+YdFT7VahF9zsl
         6Ep6iVOq5YWaUeivyj5fUBbalRZaEUaZmp85LDUAQeLb9uKPTzcCGrME1nriG8zo6kha
         Gd1AT/kpM2Amp0UxOW3TTfibjh44TgyhGADPKccI8hqyiMYBagfMKwYMnzcrHl8YYT0g
         P9Odlyp9dWyd5caifoGewGuzQzBzJ7d2EeTU2kL8n/ECytlbJiHoumbl+DmlqEpeL32E
         CrjLJnmCz+afRr6m7umGB9wHhdB6VrFKQEi1Nwp4uVNQ2CITcG+ZZ5/JxrCmW8649+kD
         TDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359074; x=1730963874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NH5MUt/+cbzy9bnDTQWkFoXyedi+6bP21xIeET9Apek=;
        b=X2snHfBSw11ME3nCAly5WaMew1s/ybREQOsSGuAG+ezd8G/IskLdmRtAF/vOIadGQ3
         35gVLZhdkPpmeODYwJUo9iFr8JpgXnPc8PNHwbh8hSpn5iSHIMYgIDFDjs+XmzR3leFW
         1jIcn68hzwBmoETCJmL6mk7hhOfceDWQa92whOZiQ6Ldo/PONOnml2TA1AXpcesQGDRz
         yPen1kvQG8pk0/nW8a6ChjYZjRKIxzjbwMw97R8KoTX3EeYvNWcTNPKVs2x48eW0HeKW
         fweTp65K46WpGSw4dLg704m14OYfuGWXdhJUpgRqTck/H9QEuXkTuFuQ4ZzRHb6bW79H
         RyTA==
X-Forwarded-Encrypted: i=1; AJvYcCW6mtS2K23Cx1BLmk6kUeW4Pg1K/IaJ92lfNqYeuFVYppK8+vKZojFXLz9IAu93+aHa/ySrimCw/OBT2w4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7+QP1A8AJR9fVMwN0I55hDvzrhVewOqA1QvVMXPk4/+M3CK2U
	O6KLdS/LUHHPKDSSx0puOiKBiiqaimbc01iQQOObIJ9Mf/IngPSdd8rLbNPfZP4=
X-Google-Smtp-Source: AGHT+IFqvelwoSi19crIY7cSvQsHBQH6NsXHxPWvECq3yNRMlEGXT2iQ4rFHd5MRgRYaRlPogLspsg==
X-Received: by 2002:a5d:4285:0:b0:374:af19:7992 with SMTP id ffacd0b85a97d-380610f8e2fmr12888771f8f.7.1730359073687;
        Thu, 31 Oct 2024 00:17:53 -0700 (PDT)
Received: from axelh-ThinkPad-T450s.home (lfbn-nic-1-251-169.w2-15.abo.wanadoo.fr. [2.15.94.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e694sm1187547f8f.86.2024.10.31.00.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:17:53 -0700 (PDT)
From: ahaslam@baylibre.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH v3 3/6] iio: dac: ad5791: Include chip_info in device match tables
Date: Thu, 31 Oct 2024 08:17:43 +0100
Message-Id: <20241031071746.848694-4-ahaslam@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031071746.848694-1-ahaslam@baylibre.com>
References: <20241031071746.848694-1-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Axel Haslam <ahaslam@baylibre.com>

Include a chip info struct in device SPI and device OF match tables to
provide channel definitions for each particular ADC model and drop
device enum.

Suggested-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/iio/dac/ad5791.c | 110 +++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 553431bf0232..f6b9a40241f3 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -61,11 +61,14 @@
 
 /**
  * struct ad5791_chip_info - chip specific information
+ * @name:		name of the dac chip
+ * @channel:		channel specification
  * @get_lin_comp:	function pointer to the device specific function
  */
-
 struct ad5791_chip_info {
-	int (*get_lin_comp)	(unsigned int span);
+	const char *name;
+	const struct iio_chan_spec channel;
+	int (*get_lin_comp)(unsigned int span);
 };
 
 /**
@@ -98,13 +101,6 @@ struct ad5791_state {
 	} data[3] __aligned(IIO_DMA_MINALIGN);
 };
 
-enum ad5791_supported_device_ids {
-	ID_AD5760,
-	ID_AD5780,
-	ID_AD5781,
-	ID_AD5791,
-};
-
 static int ad5791_spi_write(struct ad5791_state *st, u8 addr, u32 val)
 {
 	st->data[0].d32 = cpu_to_be32(AD5791_CMD_WRITE |
@@ -228,20 +224,6 @@ static int ad5780_get_lin_comp(unsigned int span)
 	else
 		return AD5780_LINCOMP_10_20;
 }
-static const struct ad5791_chip_info ad5791_chip_info_tbl[] = {
-	[ID_AD5760] = {
-		.get_lin_comp = ad5780_get_lin_comp,
-	},
-	[ID_AD5780] = {
-		.get_lin_comp = ad5780_get_lin_comp,
-	},
-	[ID_AD5781] = {
-		.get_lin_comp = ad5791_get_lin_comp,
-	},
-	[ID_AD5791] = {
-		.get_lin_comp = ad5791_get_lin_comp,
-	},
-};
 
 static int ad5791_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
@@ -289,30 +271,34 @@ static const struct iio_chan_spec_ext_info ad5791_ext_info[] = {
 	{ },
 };
 
-#define AD5791_CHAN(bits, _shift) {			\
-	.type = IIO_VOLTAGE,				\
-	.output = 1,					\
-	.indexed = 1,					\
-	.address = AD5791_ADDR_DAC0,			\
-	.channel = 0,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
-		BIT(IIO_CHAN_INFO_OFFSET),		\
-	.scan_type = {					\
-		.sign = 'u',				\
-		.realbits = (bits),			\
-		.storagebits = 24,			\
-		.shift = (_shift),			\
-	},						\
-	.ext_info = ad5791_ext_info,			\
+#define AD5791_DEFINE_CHIP_INFO(_name, bits, _shift, _lin_comp)		\
+static const struct ad5791_chip_info _name##_chip_info = {		\
+	.name = #_name,							\
+	.get_lin_comp = &(_lin_comp),					\
+	.channel = {							\
+			.type = IIO_VOLTAGE,				\
+			.output = 1,					\
+			.indexed = 1,					\
+			.address = AD5791_ADDR_DAC0,			\
+			.channel = 0,					\
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_OFFSET),		\
+			.scan_type = {					\
+				.sign = 'u',				\
+				.realbits = (bits),			\
+				.storagebits = 24,			\
+				.shift = (_shift),			\
+			},						\
+			.ext_info = ad5791_ext_info,			\
+	},								\
 }
 
-static const struct iio_chan_spec ad5791_channels[] = {
-	[ID_AD5760] = AD5791_CHAN(16, 4),
-	[ID_AD5780] = AD5791_CHAN(18, 2),
-	[ID_AD5781] = AD5791_CHAN(18, 2),
-	[ID_AD5791] = AD5791_CHAN(20, 0)
-};
+AD5791_DEFINE_CHIP_INFO(ad5760, 16, 4, ad5780_get_lin_comp);
+AD5791_DEFINE_CHIP_INFO(ad5780, 18, 2, ad5780_get_lin_comp);
+AD5791_DEFINE_CHIP_INFO(ad5781, 18, 2, ad5791_get_lin_comp);
+AD5791_DEFINE_CHIP_INFO(ad5790, 20, 0, ad5791_get_lin_comp);
+AD5791_DEFINE_CHIP_INFO(ad5791, 20, 0, ad5791_get_lin_comp);
 
 static int ad5791_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
@@ -400,9 +386,9 @@ static int ad5791_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg_neg;
 
-	st->chip_info =	&ad5791_chip_info_tbl[spi_get_device_id(spi)
-					      ->driver_data];
-
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return dev_err_probe(&spi->dev, -EINVAL, "no chip info\n");
 
 	st->ctrl = AD5761_CTRL_LINCOMP(st->chip_info->get_lin_comp(st->vref_mv))
 		  | (use_rbuf_gain2 ? 0 : AD5791_CTRL_RBUF) |
@@ -416,10 +402,9 @@ static int ad5791_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	indio_dev->info = &ad5791_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels
-		= &ad5791_channels[spi_get_device_id(spi)->driver_data];
+	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
-	indio_dev->name = spi_get_device_id(st->spi)->name;
+	indio_dev->name = st->chip_info->name;
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_disable_reg_neg;
@@ -448,19 +433,30 @@ static void ad5791_remove(struct spi_device *spi)
 		regulator_disable(st->reg_vss);
 }
 
+static const struct of_device_id ad5791_of_match[] = {
+	{ .compatible = "adi,ad5760", .data = &ad5760_chip_info },
+	{ .compatible = "adi,ad5780", .data = &ad5780_chip_info },
+	{ .compatible = "adi,ad5781", .data = &ad5781_chip_info },
+	{ .compatible = "adi,ad5790", .data = &ad5790_chip_info },
+	{ .compatible = "adi,ad5791", .data = &ad5791_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5791_of_match);
+
 static const struct spi_device_id ad5791_id[] = {
-	{"ad5760", ID_AD5760},
-	{"ad5780", ID_AD5780},
-	{"ad5781", ID_AD5781},
-	{"ad5790", ID_AD5791},
-	{"ad5791", ID_AD5791},
-	{}
+	{ "ad5760", (kernel_ulong_t)&ad5760_chip_info },
+	{ "ad5780", (kernel_ulong_t)&ad5780_chip_info },
+	{ "ad5781", (kernel_ulong_t)&ad5781_chip_info },
+	{ "ad5790", (kernel_ulong_t)&ad5790_chip_info },
+	{ "ad5791", (kernel_ulong_t)&ad5791_chip_info },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5791_id);
 
 static struct spi_driver ad5791_driver = {
 	.driver = {
 		   .name = "ad5791",
+		   .of_match_table = ad5791_of_match,
 		   },
 	.probe = ad5791_probe,
 	.remove = ad5791_remove,
-- 
2.34.1


