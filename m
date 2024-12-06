Return-Path: <linux-kernel+bounces-434932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885589E6D11
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4569E283588
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D752066CA;
	Fri,  6 Dec 2024 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Uij/YJ5F"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53A202F8A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483660; cv=none; b=fKhr0YLi7amj3fIVOgPn5DzVKtq8/4fldrbqQtoDYfYaJaESwOtaY7nZ+IWJiIrMRhfNkOxYsr55uVPpB+W/+zu5GmeXquMzjn5qLcY4k4wxjSwfCEMGp6ycJ+Z9BQCVuh7xBHNGHZbTTz7XIA1cEN0y+jnNUFrKgApKBX9o3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483660; c=relaxed/simple;
	bh=AEerx4UEMe9vIhaiw+MKD2CwprNuT0vrrMjdV50wgJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N6bSDaZhDdv87YVEtSXxZMTiIAJKgYkVgoK8VGNi28N67vPyb+YA6eQWjh6pJV5T0zSdtT7ZftnoRr4lZAX5mjkfjCyaKLwC7BPFmZ/MJNi6YUNWTnrqZQmpmnhjoPTY8Uy1lHT39fXPp+SzxS0SFqmKrcuvOhC4FgsVeebOknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Uij/YJ5F; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa5366d3b47so304838766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 03:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483657; x=1734088457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdtjY2iaQx3u/dvLLJlYTlL/H3kwsjb4tDYv6XZS7Mg=;
        b=Uij/YJ5FlUJeSIKZgyhvhtE/kAQPY8WhbGf3al6DEjnFnoIhxVhwxXKdAmrwU0/h1R
         Y0YisScqH8uL9r5CvCM/+Sz7o6oKJ2COQoHMuati3vl5r08u+cE9b29liNUfLK49mPDK
         +e4RlLssnZc1tPD0xI1RfZAb0CpbFUg2ieEhmCiM+lzeY++UzAvlP1GZysxdxxcFMEC9
         7j2xATmNQ1sepEY8SwKkJ+jSTJf3cq4/9WZHMIKeNYa5mXo9+8RFEtXcJM0rP5rPSZnh
         dK1OXNdYEfz+jELr4i9Iyswg6ubzuPk9ljz8yn7g0Zs2pY4g7+87s1Gf9heCm5lje/bJ
         cxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483657; x=1734088457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdtjY2iaQx3u/dvLLJlYTlL/H3kwsjb4tDYv6XZS7Mg=;
        b=In0i4cH8lO1O2a1qLkqa1cG/lKI4816+hkMUv7nJ4PMGmssqUpUsrptEX+i31Yev3Q
         M3wODuvxGacP4DkUcxVxwyr5HNdZz8qOxF/xU38xnZl1GFi02PZ1VGnBJ8l96OHBHuun
         fR/p34pTXRXJiyMhRTENab3wQ1qOv77r7m7FRG0YdYbackiuXqqd3cUmnghPT0eFdxXa
         x/o6h2x3L4XoZi0+dZ6ugdvvpXUDuc9AEACdbWLVEyH0li7LVdNZIkyp0vrq6uEzaGwZ
         NiBZSfcycC2vNkY0XK+6cdamMQcl0px5hTYgBv+wonYSoi5HHdEC4SFXZzizp6QHkfx7
         LvOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAg3INo+SUvKckhEJqeCRCQDxojottyrwjc66uREkElnKAXzYc4UeV1QHXhfW3QGPza3fSY38qwVt/4mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwgk+OsMqm80Jpa+Yw4I6zOBTvFQuXkJgPoj5Lt2mt1TZplNIN
	W+RmKmukRFxW5eQ8uw2BLTGSyK9awJ417c/0utCJaD5SMVd/Jsj6yVvtBN9b6C4=
X-Gm-Gg: ASbGnctalp04rI2EViR61ZCu3yLNEjmZJFMoB6YhOKOEfWqQ1k2XZXFozZyVwDdWI1U
	6JsfStDZG54z8hXgeR3J8ttA3b3/rdbZJ1j617CnRwvdl5FlupA0nSGGJZD/2IHCUdm/fm/8F9K
	gDS0yQY+52Vup2S8W8px3ch1LUie1pUpyeaPiIodfbSdc2ts7t6ErYMeoED2wWaBOnHJPtVnQSf
	240y29qrdWxO/lGh9hN9yGEYCTB2VjwikJVDb9xPQKmLskeRNuLT87jYfWpKlM31xRagfhGybFX
	jjlw
X-Google-Smtp-Source: AGHT+IFGxVio+DmpGkWuPu8PJaQl2GCwf7E3UtKIMeAaIPe+lrYbE/WDjuxxOhcCyvi/hyZufziQrw==
X-Received: by 2002:a17:907:770d:b0:aa6:23ba:d8c4 with SMTP id a640c23a62f3a-aa639fb1a24mr215496566b.4.1733483657113;
        Fri, 06 Dec 2024 03:14:17 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:14:16 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 13/15] iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
Date: Fri,  6 Dec 2024 13:13:35 +0200
Message-Id: <20241206111337.726244-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add ADC support for the Renesas RZ/G3S SoC. The key features of this IP
include:
- 9 channels, with one dedicated to reading the temperature reported by the
  Thermal Sensor Unit (TSU)
- A different default ADCMP value, which is written to the ADM3 register.
- Different default sampling rates
- ADM3.ADSMP field is 8 bits wide
- ADINT.INTEN field is 11 bits wide

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/iio/adc/rzg2l_adc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 2a911269a358..81904e2c4075 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -502,7 +502,16 @@ static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
 	.adivc = true
 };
 
+static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
+	.num_channels = 9,
+	.default_adcmp = 0x1d,
+	.default_adsmp = { 0x7f, 0xff },
+	.adsmp_mask = GENMASK(7, 0),
+	.adint_inten_mask = GENMASK(11, 0),
+};
+
 static const struct of_device_id rzg2l_adc_match[] = {
+	{ .compatible = "renesas,r9a08g045-adc", .data = &rzg3s_hw_params },
 	{ .compatible = "renesas,rzg2l-adc", .data = &rzg2l_hw_params },
 	{ /* sentinel */ }
 };
-- 
2.39.2


