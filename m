Return-Path: <linux-kernel+bounces-429325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6564F9E1A8A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BB0283B62
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0C41E631A;
	Tue,  3 Dec 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XP2VKFR9"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62FF1E5708
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224423; cv=none; b=TmDX6Q7UE1LqdZFEoLqg2oeUG9EXaJGBpz8VaQ1OeGSR6goKIbvnB+KTloSCi7bMjv5YGq4Xcr4NzsmO00eWqloQi0haKEgwX6pcLjDIYhCUCjodw7DMXOFvloRBZM3OSqMpFILbw1J9X/FcLPoV2Aq/0XgTdM6rA6qvxORUIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224423; c=relaxed/simple;
	bh=gO4ZvBXUTFcYGZh6RIIOFvueXczmp6/AUCy3wQSSRGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ci08e0WqdPKvQ35uFrgHl/eJnGIEnhsp2sYHgJ9o+S2sV4J47IJAO4ZToK+hFBu7/S791iLt2QvnBxn6rUjwkhG8EORjgsufsDZVMUkX1pvDOowsU90l7L1nPjhY/DRIhqZZ+KiyiUbd2o/FJ7pG6NhTHBSgaU639Z/TX+X7LI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XP2VKFR9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a10588f3so34575255e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224419; x=1733829219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea89qn+C4sQlE1UymOyNPT2kFEXlVUxJjzTr785WLz8=;
        b=XP2VKFR913pfmHCy1D8qPSgum3T3g+TA10hDPU/AqwV7mnJj87BQRGzargn3NpvshF
         kANQbNbnHJEWA2RsHd8rkOtFGG+x01m9zipj1xILf9iW19z858YbGhqjF214qxkRbnfi
         Bfl10Tc/CEwCCZHoS/DmTInWNjwiaL8ceDWb5XSs+Q0UsQGHiz4jZkYbl6GqaRlEBSM2
         xnBwHQva5DXcPfd0/MWcrUZOpz6trjwtpa5oeT7pcrWUHKZF4Wo3n7OryZNIwvMe7E3/
         zUYL+boGth3mHMgUeSoPw7R430K9JymkUSMkPLVt+2ir4xCGxysKEbWAajjphHGQ/8dv
         Smfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224419; x=1733829219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ea89qn+C4sQlE1UymOyNPT2kFEXlVUxJjzTr785WLz8=;
        b=kWPiCVROKF0CN/IoL7fY9i535nGydJ/01vYhEM54LyB6xFN3NxFRCN/yY/iOH5YzKo
         4uum+vEpMUn/S5MXJs4UYE06LuRoqQSPZ8QqsJ0kPpaMJGmH6Akf7PDqnRDhjdb3Y/F7
         sk8QUfbOoXAIKujFPqofN9dbxz2cUU5YyKivMfcryyw52VJq8tjwyDSvii4VahMF0yNd
         SkbzaN2USsU3pTrxk3db7v6o9K5UTYrKFYGPq22Mhm0QGHLC5/BzJr5fmSYdUaM6eDqS
         fcg9s+PUDOHSoTXD/Bc1TmGfDfR+zIpSW9QT8T+n5TovH9AkefulwnzsiSxAiceJSChQ
         ITcw==
X-Forwarded-Encrypted: i=1; AJvYcCUhzHkc6735H0KO6rdWQ8z6u/6efF/SE6jElEXGuogrf3hZ2cE6DxutEhKtgl0qYwx010kW1Axuy7Unb/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlzC47NiTDLGPsE6kUsEqP/adEKO6FRWps/nB8YQnd4lWucnZV
	9EbPbrbxuDnoVlFMYs6tMyOH82ts18qD/5eRr7ydFZ5C9b1kP/t7niROO8wU4iY=
X-Gm-Gg: ASbGncuOq7sz/y+VcmiOL232dhfCbaIdcFocACCow+NdITZOq9iDDikiH6XRTFB2FG0
	/vRFQKERP7anQyV880HwgPc0Atys/62O3NGY89osD8JFfDc07qKVZpSs5hbjSKDbb0UgIokrBBe
	eIrdJ+FLQStyOCQT4vEmWKgNOPNZN5mSVBc7G6U2F2U4IJoedqLGpl4+xfhVOMQ4DOvSdFceDyF
	lnB83P7FsccXid2EDzXhz8QZmS/95ap0cIB6JufgoKDDvLaGC2TUuy+95eZJAXW5MAe7uVBqqNF
	RWdV
X-Google-Smtp-Source: AGHT+IFPqx8VqZ8PfxTE5fU9zGnVOxsbbHEHY67sOEJJ9ywazNa1wCT+yEhiDBsok1OIhNAHxkrIZg==
X-Received: by 2002:a5d:6c62:0:b0:385:f17b:de54 with SMTP id ffacd0b85a97d-385fd3c4576mr1617956f8f.5.1733224419249;
        Tue, 03 Dec 2024 03:13:39 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:38 -0800 (PST)
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
Subject: [PATCH 05/14] iio: adc: rzg2l_adc: Use read_poll_timeout()
Date: Tue,  3 Dec 2024 13:13:05 +0200
Message-Id: <20241203111314.2420473-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
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
 drivers/iio/adc/rzg2l_adc.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 5437b21c4e70..62932f9295b6 100644
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
@@ -342,7 +338,6 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 
 static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 {
-	int timeout = 5;
 	u32 reg;
 	int ret;
 
@@ -355,14 +350,10 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
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


