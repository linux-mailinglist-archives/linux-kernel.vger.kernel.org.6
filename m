Return-Path: <linux-kernel+bounces-239433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B6925FDB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC8AB2D521
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A7178CC1;
	Wed,  3 Jul 2024 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AS/uMFHq"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BF2173359
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008676; cv=none; b=ZrkclKmthAYQ6mvZjpF7MPJUaBZP2Y/DpgbDTpKBVbrbeP1Xb4+XIfBDovGx+RGZYfKaboBTee2LCij6rALpwtzzk5CA8BxciFHMWY+0v258xDNmjRrSNZaKrLlhFXuDynPAhYXvPrHzcpJzVGb10O6f2uTovlJm38gVPU+22Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008676; c=relaxed/simple;
	bh=C2mr7bEsmKb5ROqOqNDH7IBKsoD0jmhYaojg0nmAdOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RlUcFGuqRuc8ib1IKX2xXcAWnDMNlVN3aUmwN8f+Fk3eAdcadRjC0lWPrsQZMuCRlNzd8mC83RFQvejgRzGeoJiwcasDcLhOWA9kKBWmNiAhygXZSlBGwCW5a4IcTX3J5v2so8WHujqKvVD0Yrc7n3ok8mDFWDbDRElBR+ENm9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AS/uMFHq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-425809eef0eso24406455e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720008672; x=1720613472; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7ezAWLj7MMf6cupnuxIo+JndCzydckyqulVxplwpWA=;
        b=AS/uMFHqiFE5tc581B5apYRNtnR3h8asIeU1fs6ZS3XcZd7Iu/d4ajsbcZGi82/fVc
         GoNWM4WOsa1bpQ+kKjks+eowbTQSLXjHyVepTwnV5jhxL1WWghBMb2XoXNnnE9MIhnwT
         6E9F6JtFMZCdL+jpAe0JgmLU9HGx5sdeNrEE196/p3jOLk1wJ68fkKGxFRmw9E+GEvVs
         eeASsX8p/81vAOXknF1PqvOfLwsRXag7F5BL57lQGRDy4NJgSpAu3Jv3klzIAS4jTNp8
         XtdCAGhiIOK2zp4uzzCOJtQiYImzGXx4w9hNQ57Tod1JcYP0Ja/2WzhDPhoIUN6zG9YT
         TvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720008672; x=1720613472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7ezAWLj7MMf6cupnuxIo+JndCzydckyqulVxplwpWA=;
        b=JfdB3V4MIouW7ru4MhbDoZrSRur/1PrjA2UG4GJOM0HN5XAJnC7PYVUS+NdZ78x/7k
         J8xTvK0bAg2mCptR1RKm3mBhnDa5jDNPtXL6d0ZFLl1pOO2TlXnTs5HknOlILaMAohe9
         lOazHhfHKLryjdOH1yAC8XjAwZxetuMzFb8XMz9S+Scbzpfhnhv4SqRVGWIAhv3yansd
         j/4yfkLFEqYbeY3P+W6zpTE/s6nZckF28wdttqmmxqvev8T5FEfEOQlrFkkhE9zy/b20
         32wQQUqTS/AmOZPZVxhhu/LVx0Qyyr8eTYvBtct6lRYs6w+Yv7trQV3RWAulSbWxg1vr
         +DBg==
X-Forwarded-Encrypted: i=1; AJvYcCUYMK2lggyerDaIGkFsK/DUau8FC789uJwu6W/KnpvVNbvgpX2YP7b2cMa9sRTJDeIMtRS8CzVF3xQD2fLwOjXmaaicmAljhzs0lBza
X-Gm-Message-State: AOJu0YyPD+vuhJr/iTYWb4sZWjmGtZW6GmzysoKK2rJauwvgmebVwMW4
	HujhGw7ykisDlogTGpkviBEL3tmyem+V+aqYEmTPBmOuehaIfANScsZE5l8dkjc=
X-Google-Smtp-Source: AGHT+IHjhpXQtXuOXL2sG7Nz/kypplntZTHCDuejtJNJgkYlN74FsUPBIXDr/hqUtpG9V0bzXDVXnA==
X-Received: by 2002:a05:600c:181b:b0:421:7bed:5274 with SMTP id 5b1f17b1804b1-4257a02f7f0mr79850405e9.10.1720008672113;
        Wed, 03 Jul 2024 05:11:12 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a10307bsm15716222f8f.94.2024.07.03.05.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:11:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 14:10:56 +0200
Subject: [PATCH 02/11] ASoC: codecs: audio-iio-aux: Simplify
 audio_iio_aux_probe() with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-asoc-cleanup-h-v1-2-71219dfd0aef@linaro.org>
References: <20240703-asoc-cleanup-h-v1-0-71219dfd0aef@linaro.org>
In-Reply-To: <20240703-asoc-cleanup-h-v1-0-71219dfd0aef@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=C2mr7bEsmKb5ROqOqNDH7IBKsoD0jmhYaojg0nmAdOo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhT/S1XP/zEy17um3RkbB+7GXXnM0KA43l8+pw
 GB5H7vS1OCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoU/0gAKCRDBN2bmhouD
 15/ED/4tY2cdMjmCzBV33UogE0kN1pHip/43JaL23ZH7qMeMHA3I3HXhF7aKMqK7J2sC0UIzYGz
 3UF5+KEbKvi9RXaKQmvPhEEboYiZWEeayVfsviuXZz8nxxyJd+9az94jDrtbZTcz+A/y7RrQpIV
 0RRIbNATso7rZk4UUuVrjIKKlRO2N78g4xrJRvaTmsEUB88uJGF3kZAQOniUdfxXOUpn8eCwLQM
 ED/8KZPkZCnzSghFw8NgYfG8qG7VzAVWfp+IDWZPwF875VBep7TgSR8l8oxFvSjhtzykewNxMXH
 170X/msAVpt0RDwMRwNiSYjecVw4pCmF6nG1b7jzaUQ8bf9tJpqzHD+Xzilpx5y/CFIgz6Qvv2Y
 2ykvK6o4boLyK+rgP+KAr+/jnfAfLT5yIGFu6ufyNL2JkaWnwvo9B6Rh5T3Ccts3uOvJyWNCXG2
 Fm0n1cnNo3w4Y1sYeSqq1znPn7s5a25nX9fFp+9pCwLPFei70SRPfU5+jB3fbDlGcqm/vITVx2f
 raw0aCQ2q6xyCFwKg/H2Ib62EqpEAKnUuC99UxwTH+ud5nYPnxN+pqS55kZPvGDzyWZuEty8kK8
 reZVthBBte8bn0XyuOOkBiJ7vd9IvPpbOFsJpx34YEEruH6wFTVCkUf3D3WRfx28Zg5ccZcC5nh
 2dZFA30ZhxUEPwg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h in audio_iio_aux_probe() to
reduce error handling (less error paths) and make the code a bit
simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/audio-iio-aux.c | 47 +++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/audio-iio-aux.c b/sound/soc/codecs/audio-iio-aux.c
index 3969ee45f41e..588e48044c13 100644
--- a/sound/soc/codecs/audio-iio-aux.c
+++ b/sound/soc/codecs/audio-iio-aux.c
@@ -230,8 +230,6 @@ static int audio_iio_aux_probe(struct platform_device *pdev)
 	struct audio_iio_aux_chan *iio_aux_chan;
 	struct device *dev = &pdev->dev;
 	struct audio_iio_aux *iio_aux;
-	const char **names;
-	u32 *invert_ranges;
 	int count;
 	int ret;
 	int i;
@@ -248,22 +246,22 @@ static int audio_iio_aux_probe(struct platform_device *pdev)
 
 	iio_aux->num_chans = count;
 
-	names = kcalloc(iio_aux->num_chans, sizeof(*names), GFP_KERNEL);
+	const char **names __free(kfree) = kcalloc(iio_aux->num_chans,
+						   sizeof(*names),
+						   GFP_KERNEL);
 	if (!names)
 		return -ENOMEM;
 
-	invert_ranges = kcalloc(iio_aux->num_chans, sizeof(*invert_ranges), GFP_KERNEL);
-	if (!invert_ranges) {
-		ret = -ENOMEM;
-		goto out_free_names;
-	}
+	u32 *invert_ranges __free(kfree) = kcalloc(iio_aux->num_chans,
+						   sizeof(*invert_ranges),
+						   GFP_KERNEL);
+	if (!invert_ranges)
+		return -ENOMEM;
 
 	ret = device_property_read_string_array(dev, "io-channel-names",
 						names, iio_aux->num_chans);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "failed to read io-channel-names\n");
-		goto out_free_invert_ranges;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read io-channel-names\n");
 
 	/*
 	 * snd-control-invert-range is optional and can contain fewer items
@@ -274,10 +272,8 @@ static int audio_iio_aux_probe(struct platform_device *pdev)
 		count = min_t(unsigned int, count, iio_aux->num_chans);
 		ret = device_property_read_u32_array(dev, "snd-control-invert-range",
 						     invert_ranges, count);
-		if (ret < 0) {
-			dev_err_probe(dev, ret, "failed to read snd-control-invert-range\n");
-			goto out_free_invert_ranges;
-		}
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "failed to read snd-control-invert-range\n");
 	}
 
 	for (i = 0; i < iio_aux->num_chans; i++) {
@@ -286,23 +282,16 @@ static int audio_iio_aux_probe(struct platform_device *pdev)
 		iio_aux_chan->is_invert_range = invert_ranges[i];
 
 		iio_aux_chan->iio_chan = devm_iio_channel_get(dev, iio_aux_chan->name);
-		if (IS_ERR(iio_aux_chan->iio_chan)) {
-			ret = PTR_ERR(iio_aux_chan->iio_chan);
-			dev_err_probe(dev, ret, "get IIO channel '%s' failed\n",
-				      iio_aux_chan->name);
-			goto out_free_invert_ranges;
-		}
+		if (IS_ERR(iio_aux_chan->iio_chan))
+			return dev_err_probe(dev, PTR_ERR(iio_aux_chan->iio_chan),
+					     "get IIO channel '%s' failed\n",
+					     iio_aux_chan->name);
 	}
 
 	platform_set_drvdata(pdev, iio_aux);
 
-	ret = devm_snd_soc_register_component(dev, &audio_iio_aux_component_driver,
-					      NULL, 0);
-out_free_invert_ranges:
-	kfree(invert_ranges);
-out_free_names:
-	kfree(names);
-	return ret;
+	return devm_snd_soc_register_component(dev, &audio_iio_aux_component_driver,
+					       NULL, 0);
 }
 
 static const struct of_device_id audio_iio_aux_ids[] = {

-- 
2.43.0


