Return-Path: <linux-kernel+bounces-541626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D11A4BF43
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DDB188D124
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D87620E338;
	Mon,  3 Mar 2025 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NBRJ9t0/"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39520E022
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002477; cv=none; b=RfDv53d/frw8NpqcGqUHsLpD5fa+peCjBscUs67PooKI84Pd4JpX+Xzei3zWfiqRP2wa7i8yIMtJmxCzbgEfwh+CrCP40b4mnzeLIp/bkJ2rv04zhTCj/8DF3A0OhzLPMElOAR/tqQmDef7X8Gfq9+MsjCh4hCxZpNWEwlapUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002477; c=relaxed/simple;
	bh=jqr9EwXfZY3b+14dJHqEdl3sytYGW0GVhd2OmY7oUBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aY1UdanQftltCFRN3yJSNXGQEGQ/2+PzYB2TV66KRrflh1f3D3yKzskh+LslqXRnINawMql0wIuNVEg/rWFU93dAW9wER4F4qo4SiatLii3yG6hSCwwg9FhCFheRWuUAOaaeY61BVNgic+G8OgN6yuw0RvXc5xdkfc5uVXseHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NBRJ9t0/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-438a39e659cso29314225e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002473; x=1741607273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQozffwnOCsYFoqS8k7yOzUIgAbpTEtaLUGEzpJWOM8=;
        b=NBRJ9t0//e8B+CKEW+UUUgx5fjbZqxNGjQXtzkKzqUMs6va+5HtB5fAGU/tqIhv64L
         d9oeIBN8dmYuNtuXFwDvSjLliIe4syDd0/neJXd8KATVQ4rbeWzOsH354S36oGTSiZKh
         DA3rwOIkKTWnm/ZJm2xn1sAVqxJ7NTKTE41yhZh9bn3djPqbUIs8u3/XJi4JNLKZfPzb
         CUWqNQu6ECZe9caabBoP6NlLlEIBGiJrihdE+mF2yzWZNxu3DzoKfsZtG7uoPaeHPpZD
         ZMuDsH2EmRrnvsTCGL/qw4ZX4t8NAbv1LZ0BUUjIh/ZaE8L645GYIcIOo21oCrp570KS
         U2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002473; x=1741607273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQozffwnOCsYFoqS8k7yOzUIgAbpTEtaLUGEzpJWOM8=;
        b=dyXZnotuoPGoW7u0CfciC8zWoGAJZ4RJ0msd+Ccm4e40ORmI2vMB4Jg1fPz63P0Oys
         MAh90Ujp+uA/wJrunOsq6YDW8pieTSOBBm4/RPZ1ecqr8nr3+YeMJ6+0c3ywVwzgK2Ja
         WhNp5dCJxODLlh3cRgv8XOAUomf1n2tAkbkmAQwg2CUuaLhDv3apVo/iPNqWXiY79biE
         dFGlPP5N1sraRkRMlIqmbfQIwo1jnp6p/xOm03Le2vpQ73HZsWRq6uqZlYSkCYgSBbWB
         PeqyzVuLpwzya+eMNlZkXsDylAUoEMv6HaZoJefIDzY5AvsWY8A1rbBcjpeiTayU/dzO
         KMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGjah0/tfdoYP2z7NzP1ptl0kZo8kSxt0DricLete4gMFrCm34sUpslyurw6rmZWets+Aj5FYzFPvyTsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFUWdp/o+37DUtWA7J/aLIxt8TzT+yxx83eOUlOlOwF7K3M33
	G08zV++hy3P7FIkvbgXBot+O369hpIr6gxAGDE1oJlrp2vvNA1KFrXZcdppHOEk=
X-Gm-Gg: ASbGnctKdNhlcdIB7YyS8PUn74SvlOZqREJjBAgdw1mxHOxtxmkFJFGMhmzR4rowBni
	orF2zVkaoEH5/RR0c8Gw9fTSR6UTh6+JTLLUmin0zNCmwqhzRdzbOjPM/Jvon2YZwMajcLIx9DW
	fJIjEgz7dAGXpj+OOus0LgIf1F1oCrf4Kp4tfu4SwLsmnajh4Gzl66M7whatdlanXBJspNwmMjL
	KJLdPfJhtIsTUXWH8LTU/l3lYD1xMdS3mriDA0TCfofaJl/YgCL6a5GZeV/BIj8ij83AfGM2uRs
	N6XJZYSQZWZDSD62sYvvuqMy3y/onQxttEw+FKm9KBxT8Rj0T6AQjsdz3NWu+ma0JirHPQrWL3B
	/tR1R39NU/xl+gvAazZV9qNu6tA==
X-Google-Smtp-Source: AGHT+IHbFpaqCqy7oJ39CyR2Zwl/9NuAfZAB+lM4qcvF3LKM+A/AKR9yfndWp4sIKq8aPZyIHh+KQA==
X-Received: by 2002:a05:600c:a581:b0:43b:ba80:4393 with SMTP id 5b1f17b1804b1-43bba80467emr32420225e9.3.1741002473131;
        Mon, 03 Mar 2025 03:47:53 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc222362dsm23270805e9.0.2025.03.03.03.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:52 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] iio: adc: ad7124: Implement internal calibration at probe time
Date: Mon,  3 Mar 2025 12:47:05 +0100
Message-ID: <20250303114659.1672695-17-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7681; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=jqr9EwXfZY3b+14dJHqEdl3sytYGW0GVhd2OmY7oUBw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZbOJ2NHnT28BuDYn5pn9Cy6XUnoy62wNXfb8 1o1Xgxn7j+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WWzgAKCRCPgPtYfRL+ TlPWB/9kBA/YalUMm9uRc0QIp6zcwfZVklEnf5cUkfHuLQSemru4lDAKLWuZ+lL+vT0jAF4jV8n 7xZcSv8VR3a2ya5bAuJyImvR6GBMkWGZWlm2oU4J/6/6LKZcuumNLwZW6Ugvm5BmbZjxhkOsPH9 yXwP/ruUPptaJgvRK8Y4JYdMfsSulBDX+ht13pS9YSiNnCotRkmwIrQ3HG7RfqOAq4an1Q0+hSf ZCQHouM5Vd4vmdXvLmrLTJcs8OtNUYwf1/1UTrb3nYROcmrcT5Fwk6DF8Q0/zh4iPFtOM2xUJgv nTWQ6ebaS9bWCUd+OB8Hh9+tmmPqI571CRcOq9pi13xZldqj
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Use the calibration function provided by the ad_sigma_delta shim to
calibrate all channels at probe time.

For measurements with gain 1 (i.e. if CONFIG_x.PGA = 0) full-scale
calibrations are not supported and the reset default value of the GAIN
register is supposed to be used then.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 129 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index de90ecb5f630..382f46ff2b51 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -53,6 +53,11 @@
 #define AD7124_ADC_CTRL_MODE_MSK	GENMASK(5, 2)
 #define AD7124_ADC_CTRL_MODE(x)	FIELD_PREP(AD7124_ADC_CTRL_MODE_MSK, x)
 
+#define AD7124_MODE_CAL_INT_ZERO	0x5 /* Internal Zero-Scale Calibration */
+#define AD7124_MODE_CAL_INT_FULL	0x6 /* Internal Full-Scale Calibration */
+#define AD7124_MODE_CAL_SYS_ZERO	0x7 /* System Zero-Scale Calibration */
+#define AD7124_MODE_CAL_SYS_FULL	0x8 /* System Full-Scale Calibration */
+
 /* AD7124 ID */
 #define AD7124_DEVICE_ID_MSK		GENMASK(7, 4)
 #define AD7124_DEVICE_ID_GET(x)		FIELD_GET(AD7124_DEVICE_ID_MSK, x)
@@ -166,6 +171,8 @@ struct ad7124_channel_config {
 		unsigned int odr;
 		unsigned int odr_sel_bits;
 		unsigned int filter_type;
+		unsigned int calibration_offset;
+		unsigned int calibration_gain;
 	);
 };
 
@@ -186,6 +193,12 @@ struct ad7124_state {
 	unsigned int num_channels;
 	struct mutex cfgs_lock; /* lock for configs access */
 	unsigned long cfg_slots_status; /* bitmap with slot status (1 means it is used) */
+
+	/*
+	 * Stores the power-on reset value for the GAIN(x) registers which are
+	 * needed for measurements at gain 1 (i.e. CONFIG(x).PGA == 0)
+	 */
+	unsigned int gain_default;
 	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD7124_MAX_CONFIGS);
 };
 
@@ -359,6 +372,8 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 				     unsigned int odr;
 				     unsigned int odr_sel_bits;
 				     unsigned int filter_type;
+				     unsigned int calibration_offset;
+				     unsigned int calibration_gain;
 			     }));
 
 	for (i = 0; i < st->num_channels; i++) {
@@ -373,7 +388,9 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 		    cfg->pga_bits == cfg_aux->pga_bits &&
 		    cfg->odr == cfg_aux->odr &&
 		    cfg->odr_sel_bits == cfg_aux->odr_sel_bits &&
-		    cfg->filter_type == cfg_aux->filter_type)
+		    cfg->filter_type == cfg_aux->filter_type &&
+		    cfg->calibration_offset == cfg_aux->calibration_offset &&
+		    cfg->calibration_gain == cfg_aux->calibration_gain)
 			return cfg_aux;
 	}
 
@@ -429,6 +446,14 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 
 	cfg->cfg_slot = cfg_slot;
 
+	ret = ad_sd_write_reg(&st->sd, AD7124_OFFSET(cfg->cfg_slot), 3, cfg->calibration_offset);
+	if (ret)
+		return ret;
+
+	ret = ad_sd_write_reg(&st->sd, AD7124_GAIN(cfg->cfg_slot), 3, cfg->calibration_gain);
+	if (ret)
+		return ret;
+
 	tmp = (cfg->buf_positive << 1) + cfg->buf_negative;
 	val = AD7124_CONFIG_BIPOLAR(cfg->bipolar) | AD7124_CONFIG_REF_SEL(cfg->refsel) |
 	      AD7124_CONFIG_IN_BUFF(tmp) | AD7124_CONFIG_PGA(cfg->pga_bits);
@@ -835,13 +860,22 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 			return dev_err_probe(dev, ret, "Error reading status register\n");
 
 		if (!(readval & AD7124_STATUS_POR_FLAG_MSK))
-			return 0;
+			break;
 
 		/* The AD7124 requires typically 2ms to power up and settle */
 		usleep_range(100, 2000);
 	} while (--timeout);
 
-	return dev_err_probe(dev, -EIO, "Soft reset failed\n");
+	if (readval & AD7124_STATUS_POR_FLAG_MSK)
+		return dev_err_probe(dev, -EIO, "Soft reset failed\n");
+
+	ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(0), 3, &st->gain_default);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Error reading gain register\n");
+
+	dev_dbg(dev, "Reset value of GAIN register is 0x%x\n", st->gain_default);
+
+	return 0;
 }
 
 static int ad7124_check_chip_id(struct ad7124_state *st)
@@ -1054,6 +1088,91 @@ static int ad7124_setup(struct ad7124_state *st)
 	return ret;
 }
 
+static int __ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio_dev)
+{
+	struct device *dev = &st->sd.spi->dev;
+	int ret, i;
+
+	for (i = 0; i < st->num_channels; i++) {
+
+		if (indio_dev->channels[i].type != IIO_VOLTAGE)
+			continue;
+
+		/*
+		 * For calibration the OFFSET register should hold its reset default
+		 * value. For the GAIN register there is no such requirement but
+		 * for gain 1 it should hold the reset default value, too. So to
+		 * simplify matters use the reset default value for both.
+		 */
+		st->channels[i].cfg.calibration_offset = 0x800000;
+		st->channels[i].cfg.calibration_gain = st->gain_default;
+
+		/*
+		 * Full-scale calibration isn't supported at gain 1, so skip in
+		 * that case. Note that untypically full-scale calibration has
+		 * to happen before zero-scale calibration. This only applies to
+		 * the internal calibration. For system calibration it's as
+		 * usual: first zero-scale then full-scale calibration.
+		 */
+		if (st->channels[i].cfg.pga_bits > 0) {
+			ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_INT_FULL, i);
+			if (ret < 0)
+				return ret;
+
+			/*
+			 * read out the resulting value of GAIN
+			 * after full-scale calibration because the next
+			 * ad_sd_calibrate() call overwrites this via
+			 * ad_sigma_delta_set_channel() -> ad7124_set_channel()
+			 * ... -> ad7124_enable_channel().
+			 */
+			ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(st->channels[i].cfg.cfg_slot), 3,
+					     &st->channels[i].cfg.calibration_gain);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_INT_ZERO, i);
+		if (ret < 0)
+			return ret;
+
+		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(st->channels[i].cfg.cfg_slot), 3,
+				     &st->channels[i].cfg.calibration_offset);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "offset and gain for channel %d = 0x%x + 0x%x\n", i,
+			st->channels[i].cfg.calibration_offset,
+			st->channels[i].cfg.calibration_gain);
+	}
+
+	return 0;
+}
+
+static int ad7124_calibrate_all(struct ad7124_state *st, struct iio_dev *indio_dev)
+{
+	int ret;
+	unsigned int adc_control = st->adc_control;
+
+	/*
+	 * Calibration isn't supported at full power, so speed down a bit.
+	 * Setting .adc_control is enough here because the control register is
+	 * written as part of ad_sd_calibrate() -> ad_sigma_delta_set_mode().
+	 * The resulting calibration is then also valid for high-speed, so just
+	 * restore adc_control afterwards.
+	 */
+	if (FIELD_GET(AD7124_ADC_CTRL_PWR_MSK, adc_control) >= AD7124_FULL_POWER) {
+		st->adc_control &= ~AD7124_ADC_CTRL_PWR_MSK;
+		st->adc_control |= AD7124_ADC_CTRL_PWR(AD7124_MID_POWER);
+	}
+
+	ret = __ad7124_calibrate_all(st, indio_dev);
+
+	st->adc_control = adc_control;
+
+	return ret;
+}
+
 static void ad7124_reg_disable(void *r)
 {
 	regulator_disable(r);
@@ -1132,6 +1251,10 @@ static int ad7124_probe(struct spi_device *spi)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to setup triggers\n");
 
+	ret = ad7124_calibrate_all(st, indio_dev);
+	if (ret)
+		return ret;
+
 	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to register iio device\n");
-- 
2.47.1


