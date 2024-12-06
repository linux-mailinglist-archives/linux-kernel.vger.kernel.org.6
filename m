Return-Path: <linux-kernel+bounces-434925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6419E6CF5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5BA282560
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B751FC7D8;
	Fri,  6 Dec 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="emkRSVVg"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222620013C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483649; cv=none; b=q1hkwpPEnw4n6myB85gNI0bvoXFJw5jUItlXI/7UWEj+pkCseD/GiehtD0mrjSZIRqwdhtjiJNEAkMrxIk1g1F1Zc/Ylk1QVZ1FPenbRJJZ4QSMS1aIg8nNztkKHYWAysWHSHEs+KgDqTIaKVqGxfITeghI7T76VXXV9quFuqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483649; c=relaxed/simple;
	bh=k+e2xOqzzPlHXfQrE6tIHd8B8n0ckX4ZsqRauyT6SrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ckdyKmy9jL2I9FcpfTOLwHi0hn2rbhx6st0e92M7z/vN0z0ILzDBQKjwNASzSFQtx42zmlK+cP6uws56vvxmZcsfXLwanaQ9B3AUtaT4gWKjOz4tpHoIcW/HX0dI8lfL43ZmKbNhDQkvypg5lMYjPv6NB57ExcOF78cClpc4EHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=emkRSVVg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e2880606so1646011f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 03:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483644; x=1734088444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Opknw59dd1fO7VceDAzkVbX2zeeLYIzonu5RWkuZeEg=;
        b=emkRSVVggyVlkmoOV1p1JmE08HiIcJ8YoF7+FB4K0l4OBR641AiHLbHDd2tKZVQVTs
         n1Ak1hFx1XUVUINezCkL6A/BZlVnzbihXdFoIQ9aRBgS+ixvxMbn7UbW9sAUJZXi3LKI
         WRnCSU78wJVggdW7OUaPqTzCUn70bKm4ZvnQ++HAyN8wx6ttyj9ZTT/XNGT3otHkp3L8
         cS7OHhaVV65PCLMiE1qy86bBGZpVQZZ8CUJjMbIkMiT0z8Ckucu+ZYzXD9z+sedwV35f
         0AmYy1t+EUOoNUqiFsbxm4jigpTvdThLC6pB0rkqD+fjVOf3FZ1OIFURuDdAfjqamKWh
         hvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483644; x=1734088444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Opknw59dd1fO7VceDAzkVbX2zeeLYIzonu5RWkuZeEg=;
        b=Wmy/lHFANQtYslWZCirfXaj/RtSctQPvORaUg5usr13Q5Cq917pPngOTmd2gEFh3Ou
         RAJejKY/7ouwlGPFC2drdKPzS56v+DEkKDfLQiXeVKhS0g4Z+5rIm8l/UE/Xs9YPf0Eb
         wF4TF4a5vYAnqGZQrdmRPWXPgexGonCcNwJzbYdLCUeJEQwxIz/49iBUN/yIM8CPuIOl
         370l0d+Z1juIwBNfFEr/z3J/tyQ312b8VeL+gA/OkpuydivwbvH1LBX91RHenxEkKBL3
         u/Ew6urvRpVUNlBemKgFJ/4u1i7CqdO6+c/t+HQMVoQaKqpsJ6qogwi9dVlSKZFty2Ii
         gs/g==
X-Forwarded-Encrypted: i=1; AJvYcCWHvvi26PP+SzF1Hm5ZTQweB431ArOiy44PaSnfYZUdSCiKpbfq7JJmYJeipD7fJWCnRI5gb83R2tVi1uY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5th3tG+wNw47thhv6yAN0JkyoGIJAfiL2NKYzrolI9J7d676A
	3mHvg6kcr8aSU/Jodk3zhZfo1HuAI/4fSkbhAZXvm4WTNy9r/UtEhfAHGUIc0+4=
X-Gm-Gg: ASbGnct55SCI1KO6sJKlkLVRxFwh0d3TlSCBkjw5o6cqyMEarkgyu4MJOkiFt/ouDgN
	Ks9TN/w2HRa4ro2zDjWSxdruPJQSbbz5S1BVpJ3Ohg/TDL7CNNSea7Q1JadCPrpJE5ht9p8kae/
	Dwk7aoSAEOX3llnwArqwT2ACm2TOs71Dwf9VoCuCZMzX/oDFJtq9J+xPOyOHkv0Tot3hKAj/OYI
	t7dVNBxMbkig35b51JTWnstPm2PsKkzFd/GDd35Kui5dNOG4mgYPoGfGTBpjQKmG31lI58/JPim
	1f5l
X-Google-Smtp-Source: AGHT+IGHPjOUenYoqUgXzgnQIz721t4g0doqmz4uKaZGCl3bSPXpuHOTDDdqMtgiDrRz79pHzQnacA==
X-Received: by 2002:a05:6000:178e:b0:385:e013:b844 with SMTP id ffacd0b85a97d-3862b355269mr1789922f8f.15.1733483644418;
        Fri, 06 Dec 2024 03:14:04 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:14:03 -0800 (PST)
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
Subject: [PATCH v2 06/15] iio: adc: rzg2l_adc: Use read_poll_timeout()
Date: Fri,  6 Dec 2024 13:13:28 +0200
Message-Id: <20241206111337.726244-7-claudiu.beznea.uj@bp.renesas.com>
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

Replace the driver-specific implementation with the read_poll_timeout()
function. This change simplifies the code and improves maintainability by
leveraging the standardized helper.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/iio/adc/rzg2l_adc.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 482da6dcf174..38d4fb014847 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -13,6 +13,7 @@
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -112,7 +113,7 @@ static void rzg2l_adc_pwr(struct rzg2l_adc *adc, bool on)
 
 static void rzg2l_adc_start_stop(struct rzg2l_adc *adc, bool start)
 {
-	int timeout = 5;
+	int ret;
 	u32 reg;
 
 	reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
@@ -125,15 +126,10 @@ static void rzg2l_adc_start_stop(struct rzg2l_adc *adc, bool start)
 	if (start)
 		return;
 
-	do {
-		usleep_range(100, 200);
-		reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
-		timeout--;
-		if (!timeout) {
-			pr_err("%s stopping ADC timed out\n", __func__);
-			break;
-		}
-	} while (((reg & RZG2L_ADM0_ADBSY) || (reg & RZG2L_ADM0_ADCE)));
+	ret = read_poll_timeout(rzg2l_adc_readl, reg, !(reg & (RZG2L_ADM0_ADBSY | RZG2L_ADM0_ADCE)),
+				200, 1000, true, adc, RZG2L_ADM(0));
+	if (ret)
+		pr_err("%s stopping ADC timed out\n", __func__);
 }
 
 static void rzg2l_set_trigger(struct rzg2l_adc *adc)
@@ -338,7 +334,6 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 
 static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 {
-	int timeout = 5;
 	u32 reg;
 	int ret;
 
@@ -351,14 +346,10 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	reg |= RZG2L_ADM0_SRESB;
 	rzg2l_adc_writel(adc, RZG2L_ADM(0), reg);
 
-	while (!(rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_SRESB)) {
-		if (!timeout) {
-			ret = -EBUSY;
-			goto exit_hw_init;
-		}
-		timeout--;
-		usleep_range(100, 200);
-	}
+	ret = read_poll_timeout(rzg2l_adc_readl, reg, reg & RZG2L_ADM0_SRESB,
+				200, 1000, false, adc, RZG2L_ADM(0));
+	if (ret)
+		goto exit_hw_init;
 
 	/* Only division by 4 can be set */
 	reg = rzg2l_adc_readl(adc, RZG2L_ADIVC);
-- 
2.39.2


