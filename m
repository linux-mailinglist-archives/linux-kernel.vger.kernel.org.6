Return-Path: <linux-kernel+bounces-418607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD49D636D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBE3286777
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7421DFD9C;
	Fri, 22 Nov 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pXDiWM6V"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB51DF996
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297217; cv=none; b=H1pK80lgDwCD4QFZJr5kpxhkoQMttkpBO9CzK/FsMrSatJpZ4P2PZaucfk8jF/whFGMjCGGSqPVRQQX6qZs5Vp0UnakHfsPalrJLlP1ljlcvQs19sB8vmiXQlC9JnBmXM0gFy8ai3zUZKh0MwFGmD0adqJinIX8ND0ZNUY+gB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297217; c=relaxed/simple;
	bh=oM9nEJRyR7kSPK0cowKnY+9Z/23OHvdNcGF4YvLmkxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MUsqKLLC7cvGwD2CD16U211AxVv0ykCidEq+D3USd4Ul3h4wBu160frzh3nffosA/DoCHNtIi0t+PVCtrE7htMk4uooL2RMLDSmVQvbt5J25VLRlKs30NAI7njHyT/QHaPfWpfWkEkmLAT0ydpZAbSdvxKLgyxfLugFMZCXYpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pXDiWM6V; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-718123ec383so1347028a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732297213; x=1732902013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0y/MRzmtB9fib4YsJewrbfWoKaOo42y7/AnIHQhdUQ=;
        b=pXDiWM6Vb0U0tqxKqgjd9b7ujFcagpnpFQvMnk1NumKxhKV7+jkdzlTYYC+RuQrJcZ
         mbkYILXKalwLVGwzBIBH5taqW8OLUcBAEL9LbL4F+WssGqkLjSBdLTjCFePu9XWSaL4C
         Zly0g/FR10ecpnpT5/cKbi2w/atdn2mtcMAQK81nqnC0VCb4v5Q5PFh83cBwU47fIEXh
         8UNzLci+Ot8s0wNStGpssqRXWgtFUI2R6b66u4/V80m3DAUi2VJjpxSmZK/koiW6Vnq6
         qkRoVtyYttlTu0B1B62F2s+byONVT/qkSIAsQT5Vp9I5i5pMpR+OPtYnKt0R+dQv4/Uo
         r1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297213; x=1732902013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0y/MRzmtB9fib4YsJewrbfWoKaOo42y7/AnIHQhdUQ=;
        b=kRIu5EzQ0xqLGpaT/DKAtwJEAZqOlg280fQSFQ49Sho/U+ghTueL3XmdbJHHT5Ek6Q
         tvHOZ2LiaBVm5nVMQoT2ByIrcB4sYiKwdqvLPTDhHNvMHobtNFWTkBqPmujUa2yHZTiO
         SugAHqXk6joDHjy52acezccpa2hDE1vMhZV2NNDOpL889FCytoCb9VmfEerIFgHlNd3r
         eAK1kvsieQ5kDSJCks52vE25WrEuj5F86uLUxKHSzutovzfKAxaYAAH3uWpB6/b/JylO
         HW6igIow8rdXr4W7l1V/b9InLI+GNcaBd/ghBLIt3tNUPo3GI7o2baf7d8L7YA8wB/gT
         YGHA==
X-Forwarded-Encrypted: i=1; AJvYcCWEaXfnqRhkf3pufTLA9n/M6hXddZcbntqyT/akaYV5xU1XkQg+J+rPMQy4dy4EHi4ENFbILJ2EmaJeYLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvYU+AFGZWxu8heJqoqAWBQqNK3MbzvFlGAN6CrxQTTOlBmi/3
	4Nl7HRtb46uSo8LExf+IX8GgW8mS85ALDFeroYW4Ld+3EPt6Fax2L1YV4m03bBs=
X-Gm-Gg: ASbGncsjBihwiJHEIhz45y99ZJAnHNRXSUQWtblGT4wCM6EvKiNrdVMl8hq1kNsikJ+
	hvpFnIu5DpXN5q/hkE3I5Pg1CjwxrgSHHsUqQwKfsxYh7+Gugg3lWmo3tYl4F6Hh8Jzbo2li4MM
	Kl4/dEiypy2pt5ifMCtOlTiLVeTUZJag1QBXF0ITUiWrlXUkLEilPL+xkMAO6tF/VgQk3JtZ6Uk
	NgmASbx/E1GUAvBET6hpc3Yr6c23CDmVNHionkZ7vdTX3I98y3zv0smXM4zEFjKdFJ8MXpOMbtk
	MaRLTg==
X-Google-Smtp-Source: AGHT+IHtTo35JtlZ8/m29TZlsI0b/ssf/ysVqUpaaxETWJ8XCyGnCmdxyzua/2cCppL2whUqVfCbSA==
X-Received: by 2002:a05:6830:6a15:b0:70f:3720:16bb with SMTP id 46e09a7af769-71c04ce7411mr4405440a34.19.1732297213655;
        Fri, 22 Nov 2024 09:40:13 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0381c976sm494572a34.50.2024.11.22.09.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:40:13 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 22 Nov 2024 11:39:52 -0600
Subject: [PATCH 1/2] iio: adc: ad7313: fix irq number stored in static info
 struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-1-d05c02324b73@baylibre.com>
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

Replace the int irq_line field in struct ad_sigma_delta_info with a
bool get_irq_by_name flag. (The field is reordered for better struct
packing.)

This struct is intended to be used as static const data. Currently, in
the ad7173 driver it is static, but not const and so each driver probe
will write over the struct, which is a problem if there is more than
one driver instance probing at the same time.

Instead of storing the actual IRQ number in the struct, a flag is added
to indicate that we need to get the IRQ number by name. Then the code
is modified to check this flag when setting sigma_delta->irq_line in
ad_sd_init().

fwnode_irq_get_byname() is moved to ad_sd_init() to be able to handle
this change with the bonus that it can be shared with other drivers in
the future.

static struct ad_sigma_delta_info ad7173_sigma_delta_info can't be
changed to const yet in this patch because there is still another bug
where another field is being written to in the probe function.

Fixes: 76a1e6a42802 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c               |  7 +------
 drivers/iio/adc/ad_sigma_delta.c       | 14 +++++++++++---
 include/linux/iio/adc/ad_sigma_delta.h |  5 +++--
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 29ff9c7036c0..5215584438bf 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -758,6 +758,7 @@ static struct ad_sigma_delta_info ad7173_sigma_delta_info = {
 	.disable_all = ad7173_disable_all,
 	.disable_one = ad7173_disable_one,
 	.set_mode = ad7173_set_mode,
+	.get_irq_by_name = true,
 	.has_registers = true,
 	.addr_shift = 0,
 	.read_mask = BIT(6),
@@ -1397,12 +1398,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	ret = fwnode_irq_get_byname(dev_fwnode(dev), "rdy");
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Interrupt 'rdy' is required\n");
-
-	ad7173_sigma_delta_info.irq_line = ret;
-
 	return ad7173_fw_parse_channel_config(indio_dev);
 }
 
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 2f3b61765055..af982f21adfa 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -653,6 +653,8 @@ EXPORT_SYMBOL_NS_GPL(devm_ad_sd_setup_buffer_and_trigger, IIO_AD_SIGMA_DELTA);
 int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 	struct spi_device *spi, const struct ad_sigma_delta_info *info)
 {
+	int ret;
+
 	sigma_delta->spi = spi;
 	sigma_delta->info = info;
 
@@ -674,10 +676,16 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 		}
 	}
 
-	if (info->irq_line)
-		sigma_delta->irq_line = info->irq_line;
-	else
+	if (info->get_irq_by_name) {
+		ret = fwnode_irq_get_byname(dev_fwnode(&spi->dev), "rdy");
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Interrupt 'rdy' is required\n");
+
+		sigma_delta->irq_line = ret;
+	} else {
 		sigma_delta->irq_line = spi->irq;
+	}
 
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index f8c1d2505940..2d8bc5de8332 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -43,6 +43,8 @@ struct iio_dev;
  *		the value required for the driver to identify the channel.
  * @postprocess_sample: Is called for each sampled data word, can be used to
  *		modify or drop the sample data, it, may be NULL.
+ * @get_irq_by_name: Usually, the RDY IRQ is the first one and therefore ==
+ *		spi->irq. If not, set this to true to get the IRQ by name.
  * @has_registers: true if the device has writable and readable registers, false
  *		if there is just one read-only sample data shift register.
  * @addr_shift: Shift of the register address in the communications register.
@@ -52,7 +54,6 @@ struct iio_dev;
  *   be used.
  * @irq_flags: flags for the interrupt used by the triggered buffer
  * @num_slots: Number of sequencer slots
- * @irq_line: IRQ for reading conversions. If 0, spi->irq will be used
  */
 struct ad_sigma_delta_info {
 	int (*set_channel)(struct ad_sigma_delta *, unsigned int channel);
@@ -61,6 +62,7 @@ struct ad_sigma_delta_info {
 	int (*disable_all)(struct ad_sigma_delta *);
 	int (*disable_one)(struct ad_sigma_delta *, unsigned int chan);
 	int (*postprocess_sample)(struct ad_sigma_delta *, unsigned int raw_sample);
+	bool get_irq_by_name;
 	bool has_registers;
 	unsigned int addr_shift;
 	unsigned int read_mask;
@@ -68,7 +70,6 @@ struct ad_sigma_delta_info {
 	unsigned int data_reg;
 	unsigned long irq_flags;
 	unsigned int num_slots;
-	int irq_line;
 };
 
 /**

-- 
2.43.0


