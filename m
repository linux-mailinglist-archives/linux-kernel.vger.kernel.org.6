Return-Path: <linux-kernel+bounces-212261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBD6905D69
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3CDB22CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECF112DDA7;
	Wed, 12 Jun 2024 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YRsdl3nn"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8E127B56
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226204; cv=none; b=fBedjM2xYauDc46E11IpjzBzmiALD6DF2s/GIix+PQrdI1p8bdTM0XbdN7wAAqBcwqbEppBga7CDSKYzsQ997MqHXN1XXCbhbafqIo3f8qxPlI01dgnUWQCizl0NfF3t6tapS+v4uGU+WJmKpRewwz3PXMKjnpzd1hN99ZyP6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226204; c=relaxed/simple;
	bh=sezQ4w6PZZve8U3ILWq1Xq5i5J6FPy2Gc64TgHqk4/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lO6tlpJh4HGoMIE0HgbCzHtJzVlxP05Y4vAkGda8Zb/vyPwTqqyKFN7OyeNYmVG90ti1VA1eiWzq61ak+B3eNerwf2oIQlqeqenEf6mAH7G0h0CdJBoraryMspJtP5PsWVIuAkNpZFtKdm0k3Rz5tZxYQRD+FzRRuraXc8+e5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YRsdl3nn; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d218ea7750so112098b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718226202; x=1718831002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w2EhrQZ4+BmCMfRs36lFVBfa5pXsiS+VLdsM94tNmk=;
        b=YRsdl3nncMccG/IArtSdxOuiHewELH9I3v7S2k8Up3fEH+vc2rsZ6uxFu/biQi9zxd
         //JQioJIOhBrs66ud2SwArFWtR9pWGyuRUk8KS4ZIRQZhZdqKwv6rRQNMeHieowSnVIc
         KqcDBfZ9hY0U6vRNHphZBXIj1rywQgQ0yxIZIXUr9Kufv1lTGPmGLoc39rZ8QVevIBIY
         p3t8DZW/TgASb5xBWcc/9xwqvHgw1ftw1AfxJ5y9B4zpPkImL8j9SV80TOMH+gTW0xSy
         vJ/Vo68iW96AlJUV7xH9VW/FqXuGctlaEb+yezYqvd9TkOByl+eM8lvilX84VvALUrJl
         7R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226202; x=1718831002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2w2EhrQZ4+BmCMfRs36lFVBfa5pXsiS+VLdsM94tNmk=;
        b=Sde/RCWPAjbe7XzC+WskeiUHiWYJ5OSQBNxmMIBfK8ec8lu/1E1dgXZR70OH+7dhxd
         SWqswfQMF+hBCkCx+lOrMuGaiqaNeTeGv/tzQgLjNI8xzMh8ALRM+st+H7QMjF9kSO3H
         KoU7DLMYAmQA7l4be10GIVFWKyraABIPdpHVnYPl4Yyg6S958M4jl20le2V132qan1YD
         xKaq4cRoni3FYgVFMW6pEuqx2VsX6LSm4UwLpgMHMYbhruhsZyFGfE1U4PYEnp8F07RS
         6R+Z1hhvNTl2DBUZazan56d595dFJckBfRhEAsSPixusWUPSEMDCRFOcf818DOq8AjVR
         CqUw==
X-Forwarded-Encrypted: i=1; AJvYcCUFLISOZkjFhTV6aohFPN3cOMgMFZo894TYQlg1A2qQWQ9jvBdxnK8wUXwcKyZkTmoBuMHeM3R+urhbfRB3V1EUUuJ3Z44m85IfRWbi
X-Gm-Message-State: AOJu0YzJrZu9jLDgJth1IKUD1BMju5krHb4prxWTNzhSFXe2aqZNRrrE
	3zF2uBrH2Tpsw+7UKeobr1oESOwQmGpN0rpYY+bqxMcNH44H6spkNrVh4oRsSoo=
X-Google-Smtp-Source: AGHT+IH+n9V+MzaCy4aZHHNtHPMSXI+bS8hlK5eCVyi4DOF1NPWgoBSrSmEm04QGkU67m4l1Ly1jZw==
X-Received: by 2002:a05:6808:1282:b0:3d2:304c:982e with SMTP id 5614622812f47-3d23e0800a9mr4381718b6e.42.1718226202413;
        Wed, 12 Jun 2024 14:03:22 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d20b68f5a1sm2433368b6e.23.2024.06.12.14.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:03:22 -0700 (PDT)
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
Subject: [PATCH v2 4/5] iio: adc: ad7793: use devm_regulator_get_enable_read_voltage
Date: Wed, 12 Jun 2024 16:03:08 -0500
Message-ID: <20240612-iio-adc-ref-supply-refactor-v2-4-fa622e7354e9@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
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
v2 changes: none
---
 drivers/iio/adc/ad7793.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 5f8cb9aaac70..d4ad7e0b515a 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -152,7 +152,6 @@ struct ad7793_chip_info {
 
 struct ad7793_state {
 	const struct ad7793_chip_info	*chip_info;
-	struct regulator		*reg;
 	u16				int_vref_mv;
 	u16				mode;
 	u16				conf;
@@ -769,11 +768,6 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 	},
 };
 
-static void ad7793_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad7793_probe(struct spi_device *spi)
 {
 	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
@@ -800,23 +794,11 @@ static int ad7793_probe(struct spi_device *spi)
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7793_sigma_delta_info);
 
 	if (pdata->refsel != AD7793_REFSEL_INTERNAL) {
-		st->reg = devm_regulator_get(&spi->dev, "refin");
-		if (IS_ERR(st->reg))
-			return PTR_ERR(st->reg);
-
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(&spi->dev, ad7793_reg_disable, st->reg);
-		if (ret)
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refin");
+		if (ret < 0)
 			return ret;
 
-		vref_mv = regulator_get_voltage(st->reg);
-		if (vref_mv < 0)
-			return vref_mv;
-
-		vref_mv /= 1000;
+		vref_mv = ret / 1000;
 	} else {
 		vref_mv = 1170; /* Build-in ref */
 	}

-- 
2.45.2


