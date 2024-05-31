Return-Path: <linux-kernel+bounces-197500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B98F68D6B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3E2B211FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6221312FF8E;
	Fri, 31 May 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dmRLypdA"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381482498
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190390; cv=none; b=RN/kfyo6tU43vSDjKmPjsNWf9k9H2dLh00jxGmQ39/Sd6pFcOmYMy1HzJaB6Q+cyY+114G+2rdx1CZCFSnwrs/6BgUCgNDnPsOkg89zllVbcs6QCf8sodF0N7uIo5m55xtSjx6VZbQGLlcdLmlQ8OUuAoYqy7qWE2z7XOe333Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190390; c=relaxed/simple;
	bh=cTiNyK1ys4ahQNaXNuf6ikv8kxy/TxXonMWyDgt/QB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMLAJE57TaVtW0LUae8TaBIFzyuUzSUk01QX9wlRdBuysTc4+3xA6bAA+9mWgMmYwY63i39wVRxfO+MsAZjCgVv5ZUDQDXQ4BHVJCIFc+YakYF0DM0S4LIwgE13Mo6Cvm8kRAYmrXQrzbOM61856Jc8TKLrSO9B2kqlukmslN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dmRLypdA; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f12ff2da3fso1374738a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717190388; x=1717795188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qx10f6FDnpDWXmsP3ksz4V0Ywa+gZQfSKGlvjoHLNnA=;
        b=dmRLypdA+V/mDE1CFkoDEtGHeMt499zJ6SlLgJG0P78ZREWzY9dU959JQEQiclukIn
         T7Jhv0v8qUKab9EpxpdlUQj0VfCjGXcQBYTvhKNcx3d5vtpZHoPpwgA6jSie8s64ryFk
         7l6tZfqA+s/FmedYqerBP/elAd5oQ2y2FacPlPCkZMOwvKT/iL1Uf7zYxscxBHaKLdiT
         +YEPrDT7EpkLiu0O5QP38Xi/sZnHZYbsqQ5eMSnPet/7KblQz8nphDEGWIRAl4Vdl/7h
         owBlz0z5EKmjUp9JbwCUIJxCz6Kext8AXb0/ocnj7VCyS7g6hnHoG6R/kIf+Wm99iZjm
         N7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717190388; x=1717795188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx10f6FDnpDWXmsP3ksz4V0Ywa+gZQfSKGlvjoHLNnA=;
        b=oxUt6uIwdzeG7X4PZEWYLTiYI9q2BhOnis3uXGUgKHlgkvWApGTkhOkBtDtsYlGxLm
         gkGx0ql0SkMMw6sAXiG1SgSWo/NczfFqdcBWM7eQNEn2SAqMpj1Zm8kj3BIrX+z+KA5w
         wssdLN+5hhZgvsx3jmkpgQFslij/9+nERppPRqige0WNh7pNyl4mqCvHKs2r069E8pQq
         HgqLfgR3UD/RXHuVRSBk4412zsXnZVoaWfN/9Fqw1dCQw9J2Jrk0SU656D58b2RevaE4
         zy8vQfkUHDxIGPy34GEH3qCd4gtmyJo5vMUZoCh4SVAVgaf69sF9ekEitfWrY9DNBWIZ
         nLDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEV3BPiRBPFNvEX/a6t7wI7kkCfOd7KPTPqXdwDxNhojq1VPjoyxt5ZFV92H6auGZYoQ745Af2TMhhT6tl3rbLuKAgnOh184Q10bji
X-Gm-Message-State: AOJu0YxmnVdOQTwODULJ4hlEIo+PczPtYSaYGBE+JUsHI7fxagtDNuFq
	va3QV+gtR48GNM95+XUIA1DYaqyRotvmBXvFT27z9pacJdJhi29ZC6Dmxj94oEoMyVGEi9y5rHQ
	X
X-Google-Smtp-Source: AGHT+IHecu+MAUNmrjh2sKi9JnDPh/FwFOg+MlU6Ki9NaEl1LqgtU9wELvhFrSYdVexLapJxPEZI9Q==
X-Received: by 2002:a05:6830:151:b0:6f0:5cd9:d5de with SMTP id 46e09a7af769-6f911f3fe26mr3085558a34.18.1717190388071;
        Fri, 31 May 2024 14:19:48 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91054f6c5sm470176a34.38.2024.05.31.14.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:19:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] iio: adc: ad7944: use devm_regulator_get_enable_read_voltage
Date: Fri, 31 May 2024 16:19:36 -0500
Message-ID: <20240531-iio-adc-ref-supply-refactor-v1-5-4b313c0615ad@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
function to reduce boilerplate code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 62 +++++++++++++++---------------------------------
 1 file changed, 19 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index e2cb64cef476..42bbcb904778 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -464,23 +464,16 @@ static const char * const ad7944_power_supplies[] = {
 	"avdd",	"dvdd",	"bvdd", "vio"
 };
 
-static void ad7944_ref_disable(void *ref)
-{
-	regulator_disable(ref);
-}
-
 static int ad7944_probe(struct spi_device *spi)
 {
 	const struct ad7944_chip_info *chip_info;
 	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct ad7944_adc *adc;
-	bool have_refin = false;
-	struct regulator *ref;
 	struct iio_chan_spec *chain_chan;
 	unsigned long *chain_scan_masks;
 	u32 n_chain_dev;
-	int ret;
+	int ret, ref_mv, refin_mv;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (!indio_dev)
@@ -531,47 +524,30 @@ static int ad7944_probe(struct spi_device *spi)
 	 * - external reference: REF is connected, REFIN is not connected
 	 */
 
-	ref = devm_regulator_get_optional(dev, "ref");
-	if (IS_ERR(ref)) {
-		if (PTR_ERR(ref) != -ENODEV)
-			return dev_err_probe(dev, PTR_ERR(ref),
-					     "failed to get REF supply\n");
-
-		ref = NULL;
-	}
+	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (ret == -ENODEV)
+		ref_mv = 0;
+	else if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
+	else
+		ref_mv = ret / 1000;
 
-	ret = devm_regulator_get_enable_optional(dev, "refin");
-	if (ret == 0)
-		have_refin = true;
-	else if (ret != -ENODEV)
-		return dev_err_probe(dev, ret,
-				     "failed to get and enable REFIN supply\n");
+	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
+	if (ret == -ENODEV)
+		refin_mv = 0;
+	else if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get REFIN voltage\n");
+	else
+		refin_mv = ret / 1000;
 
-	if (have_refin && ref)
+	if (ref_mv && refin_mv)
 		return dev_err_probe(dev, -EINVAL,
 				     "cannot have both refin and ref supplies\n");
 
-	if (ref) {
-		ret = regulator_enable(ref);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "failed to enable REF supply\n");
-
-		ret = devm_add_action_or_reset(dev, ad7944_ref_disable, ref);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(ref);
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "failed to get REF voltage\n");
-
-		/* external reference */
-		adc->ref_mv = ret / 1000;
-	} else {
-		/* internal reference */
+	if (ref_mv)
+		adc->ref_mv = ref_mv;
+	else
 		adc->ref_mv = AD7944_INTERNAL_REF_MV;
-	}
 
 	adc->cnv = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
 	if (IS_ERR(adc->cnv))

-- 
2.45.1


