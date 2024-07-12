Return-Path: <linux-kernel+bounces-250880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A4C92FE18
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82507283927
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BEE176AB8;
	Fri, 12 Jul 2024 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KeMt8SQl"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D3617557C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800248; cv=none; b=ffgqragBNc621a48Xf8PAVtxV7QL1wLja7QTzO+qhrvP0l7jv/+BfenvkIZ+N1yv6MwOgWk4ucg94Znns4Da5ckwhBaDS0pjxPdpaCSErrnO/rua/zC4Lrvs66msG4TFlcKPZRpT6sndyPLzQdmO4odrwEYBy1d49g9KJ/63Df8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800248; c=relaxed/simple;
	bh=LiCm3tBJ7AYWSQZO/TCKsxT1uryLYML0nN19d4B4ZF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWw76Tb2V+2EO2Jq06JHkCYB0OP8G6uwmhhHbGXAUuVUHRzstMho8SPR/TIajLaocR36OpzHhJAcS2f++T4RLXm6r+ZZXo1wcQalPNtpqlCI/k5qTwKDF/u4tannpjGeYtTs24ojc1I4A8GuJNS4bE9r4eXsLRE1n7zwlIGuJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KeMt8SQl; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25e1610e359so930599fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720800246; x=1721405046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yfWKG0y/JQs2Xv+AEtYK/Qt5yfxPJbz/kYQptJy6iA=;
        b=KeMt8SQlM0UjK4ie+NebsRt8QVaRmBzyREDsbvp7BBBBXeUmIwCVV5au67+bk861oH
         IsXsIQH3dygQEvxQoRPNyhGIxOf8yJuEho4nI5YEMbeimzXkOpx0NxjRhaVYJKwwtyYz
         cOx8nSo/DmI68jo9Z16I+/oZzrqnOXz26e3kAVXvF3a7rRh0xO/eQDScyzb99PTmNGAG
         /Iu9RWgUogGmojxW/iFu0ohf4Pf8/pDH6uPShT1o1p/5y6e32OVoEuphuGzaksFqB618
         R6QuWo8qXf3i9ylXRnMw8uOg/JxnaPTRSevR327PEuRzrtd8Fh/B+PwPHsRXW7WxhypW
         2TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800246; x=1721405046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yfWKG0y/JQs2Xv+AEtYK/Qt5yfxPJbz/kYQptJy6iA=;
        b=Z2WNWkYc6HtB5HN0mFvtxwoS1q7noJI50eLdKBEdJtJBXRt/AqKaWeQzEDOLYPTnR7
         KAt+84bBz/ALa63Ce0DqggQaym71lngJoctebdJwn9X6WWtstvRRhjumqAQvnjhPKWMy
         V9+yHkRkGpeYhK6qMXHe8d7BNA/hq3RA6YeXINc+w62Rm9sFoiGyX2UJq7Tax24ZeVG1
         ELFD/JpU1A4k3mBGorhzjilIpRwq9j3ZYfutJKTRys+x6zxRNbw7UGJLQK7QRoT0ZSGe
         K4dfhqcbnvTV+pMG65qLNu9FQOkOkzd2n6v96q7lpK9Jc0AFyayK8tJPzBsHUsU/oH1r
         9RPg==
X-Forwarded-Encrypted: i=1; AJvYcCUdX2FI4hMxDyFPYtmz1kRpa4Q1d6vQM1ZSL/43KC+xRcp6kzO3L+oFmYDWe/MpBC4FJEpOStb5OoonM2jP2g04jreoeWQEduqatY/a
X-Gm-Message-State: AOJu0YwhC4aKHIynhOLV/eiZq/9rTpUv3vtRAd0GPs9gwT7ATTHSMWbw
	QLWyNCSfVCkRN+ZQ0UDGp1sYJa8N+eHDF33ystDNobwNqJctHhiDueQd7KaZxK8=
X-Google-Smtp-Source: AGHT+IFZ4u28V0aXqe1EKH1JX+VjsznMpOJ+/9Zy0MPgBrfQDd+ZR7G8IEC/bVTMldowmHzd8Hm2Ug==
X-Received: by 2002:a05:6870:a11a:b0:254:a57e:1aed with SMTP id 586e51a60fabf-25eae84e38dmr10560652fac.26.1720800245795;
        Fri, 12 Jul 2024 09:04:05 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f78d35sm1615131a34.23.2024.07.12.09.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:04:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>
Cc: David Lechner <dlechner@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] iio: dac: mcp4922: use devm_regulator_get_enable_read_voltage()
Date: Fri, 12 Jul 2024 11:03:54 -0500
Message-ID: <20240712-iio-regulator-refactor-round-3-v1-3-835017bae43d@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
References: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
helper function to reduce boilerplate code in the MCP4922 DAC driver.

The error message is slightly different because there is only one error
return path now.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/mcp4922.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index da4327624d45..f89af70fa5af 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -30,7 +30,6 @@ struct mcp4922_state {
 	struct spi_device *spi;
 	unsigned int value[MCP4922_NUM_CHANNELS];
 	unsigned int vref_mv;
-	struct regulator *vref_reg;
 	u8 mosi[2] __aligned(IIO_DMA_MINALIGN);
 };
 
@@ -132,24 +131,11 @@ static int mcp4922_probe(struct spi_device *spi)
 
 	state = iio_priv(indio_dev);
 	state->spi = spi;
-	state->vref_reg = devm_regulator_get(&spi->dev, "vref");
-	if (IS_ERR(state->vref_reg))
-		return dev_err_probe(&spi->dev, PTR_ERR(state->vref_reg),
-				     "Vref regulator not specified\n");
 
-	ret = regulator_enable(state->vref_reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable vref regulator: %d\n",
-				ret);
-		return ret;
-	}
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0)
+		return dev_err_probe(&spi->dev, ret, "Failed to get vref voltage\n");
 
-	ret = regulator_get_voltage(state->vref_reg);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to read vref regulator: %d\n",
-				ret);
-		goto error_disable_reg;
-	}
 	state->vref_mv = ret / 1000;
 
 	spi_set_drvdata(spi, indio_dev);
@@ -167,25 +153,17 @@ static int mcp4922_probe(struct spi_device *spi)
 	if (ret) {
 		dev_err(&spi->dev, "Failed to register iio device: %d\n",
 				ret);
-		goto error_disable_reg;
+		return ret;
 	}
 
 	return 0;
-
-error_disable_reg:
-	regulator_disable(state->vref_reg);
-
-	return ret;
 }
 
 static void mcp4922_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct mcp4922_state *state;
 
 	iio_device_unregister(indio_dev);
-	state = iio_priv(indio_dev);
-	regulator_disable(state->vref_reg);
 }
 
 static const struct spi_device_id mcp4922_id[] = {

-- 
2.43.0


