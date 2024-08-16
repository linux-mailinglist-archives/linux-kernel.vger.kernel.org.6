Return-Path: <linux-kernel+bounces-289958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24498954DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C255E1F23886
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930671BF32B;
	Fri, 16 Aug 2024 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDuPN+5R"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7BE1BE259
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822323; cv=none; b=YWNnQ2Hyn5HlF9c9LqlM7t4NPTUV+DH8LD1LnNaBBnVVeRvuB72pM6p712MmumWVNF76NCcYkYWEWQf7TwYpMkqsQoGbJ9fu5/aEbrZr2VrgUHA0aKhGZYOlbt6VxuF80zFMkEiCjaRTl0LItXLPsOkEDuTAHmZ9Z87TXNNK9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822323; c=relaxed/simple;
	bh=haphcDVabNY+m5Vrc9+jwTzdz2gW4B9j++QCcBv7uus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xjxms0hrxoHM+tPmTG8RzQsO5y76sZ95fy8e3Bip5nWROIrGnhfWCLCCiJ5si7PmdTori030xdp8g5u+6wW6aX7OKquDInOBZivBWV/p4R9wbbDPf+r4085WtiJMQIsrYvDpWblhLQBmx7FbojRVKuqTwxeHaLhzMz9SzIeWUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DDuPN+5R; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367963ea053so1486223f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723822320; x=1724427120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmSp/tI6/cAsvRbhfMHRpQD46ohRd+mOrBdZEg+M/0c=;
        b=DDuPN+5RUhLuKELNtFzqxEBL9OAmgy7IyE9eanUVDFCWRTuw/BWFzniyJOlEdMR+0u
         /jFYIGgqzIGQoGzPX/0RYbyEH2lL4pcM8eB8f1uoEtEVZ0MB2UBNCWHtYuH9HFfiu0me
         AXbP779P6I1A3gF333nvC8wGwDLwbIB9F8MA7uFPrZTzsgxd3HMYlL1vFBoZJDO1stP3
         b8WqkUuq+Xg5p63c/2C2nG1e2sp85AlBrZAMKMwGGzbsTqSAYTqlZCfXVktcbbwiRPrc
         OM9H1gyInE8TqW1PfChABXeDppBE0Nhe7bgTGS9gIxHc2j7AClnSTbn0cm//kLDQ816S
         p+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723822320; x=1724427120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmSp/tI6/cAsvRbhfMHRpQD46ohRd+mOrBdZEg+M/0c=;
        b=TGJmkNDG61MisUmdsX8CDmiFkRsKFg566T+3yFwTagsMAdzCoXVHZeim9izqUw+6mD
         Mb8Uc+Vh3Fy5Odv2mKHJ10LDwE4/Z7Ends+cWGkny1Hte5cxu7HTsd2HKp7HLqM5Qt26
         v6a5t0a8zvlh8vlwR3aEEKsw5ekqFORWEz71H6zCYhCH6WA143fZe7cw4ePEdg1tfkdZ
         H0qlIR+a/Mu7U47PQLNRYTMwA/L7Jz6YklPuIsIe/GcVEzf+NX22wh0fMr00UvKDWYCE
         IBgerMWc8HBBluPoKTcJCL0YSdQvexqn5simvypBByVeXUtR8jxlG+6zPTbBkq3GpCny
         Wkgg==
X-Forwarded-Encrypted: i=1; AJvYcCWqJykp5+cL0Di/67EquAU712K0M6679FAgcYy5+d9hsvq9w9ZrTLdUoOg0uIhBeil6c2L/0+RE1PUG48UNefUeprtdIu1253sCF33X
X-Gm-Message-State: AOJu0YzcQMeONT9l/nIQwP4RzhJ1Si0rjHYagpBGwNhlaP8xMUw5fk3+
	ZGOjDeyZMxDssAa97vqk16h7+kd8XOujvrVnndTXiscVFFGHL9OAuWTdlyjbI9U=
X-Google-Smtp-Source: AGHT+IENvgflPrCRLHnfFtaGxKPmZxIFqASabhejGrvVmiQr8wKujrxn8UdnFq1rYdKsHedXwj+CoA==
X-Received: by 2002:adf:a443:0:b0:368:7f8f:ca68 with SMTP id ffacd0b85a97d-3719464e70fmr2963005f8f.30.1723822320474;
        Fri, 16 Aug 2024 08:32:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497f0sm3853661f8f.39.2024.08.16.08.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:32:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 17:31:36 +0200
Subject: [PATCH 04/17] leds: max77693: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-var-v1-4-1d0292802470@linaro.org>
References: <20240816-cleanup-h-of-node-put-var-v1-0-1d0292802470@linaro.org>
In-Reply-To: <20240816-cleanup-h-of-node-put-var-v1-0-1d0292802470@linaro.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Riku Voipio <riku.voipio@iki.fi>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=haphcDVabNY+m5Vrc9+jwTzdz2gW4B9j++QCcBv7uus=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmv3DcFsjEVoUNxcpg4fNpAtVDyd+JTLcgwo8Hw
 k/LlBeAdrSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr9w3AAKCRDBN2bmhouD
 17zkD/0b5uHnjnzjPvy7kRfLttY9Q5sWPLsfyEq6CLUzPTCBewXF8K27CAlQIluNVr9MosDCghO
 U7QGtLk8uSvJj9KQ02Yig2QWAcy/s5wRX+ONqPYRue6VOXglHUB0PaP/hurfyKbriRaOUyg3bm3
 Ffad+VfZ46D5xsiEVre/lHkn2amNZE4K2cYDi73IjaGDH4+rdGn/xY4GWlBlA0sDiFaaZbq9mE9
 1bHtk3cykDUdm2ykX4X+1ycApN5D9e0drHjadREgiSLjd8NQmMWPwb9yroUwjZSfEPsFZzXEiGH
 ESatJmodVxi+VpuKSU6tN+pn36jp7Uvo8oJLg2ciIqkhH7l/8f26PToam8oq0III9BmKa7K+WE2
 SA2i561NmARvZKIb7ov2/YXtvUFPzgn/7ENHvP3gnz3QrvNmc6UPPaGIWeENQnPPlEqh9VDOciQ
 GtOI3WZtohFdCug3984yJMuJtGZ2lScEuevzxO0cF2t1KI8+qhrQ4yog1t0e/OS5HQT8Iz4fa8g
 XzXe3ZIxRQQ4cV9Dazp74uPSEkMMyN8EKzdftcVEuL48b9NbqZBencwcIcjhkt6pPpRXBMgLvu4
 weZ7WS3MKriAVqcl2tPp4IjWatK/agobg3xKELYxOlZDdKiHQJc6uUI665Mi9MamHNKIXUMmcyo
 ejGSHUPPEivrccw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/leds/flash/leds-max77693.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/leds/flash/leds-max77693.c b/drivers/leds/flash/leds-max77693.c
index 16b169e658de..90d78b3d22f8 100644
--- a/drivers/leds/flash/leds-max77693.c
+++ b/drivers/leds/flash/leds-max77693.c
@@ -599,7 +599,7 @@ static int max77693_led_parse_dt(struct max77693_led_device *led,
 {
 	struct device *dev = &led->pdev->dev;
 	struct max77693_sub_led *sub_leds = led->sub_leds;
-	struct device_node *node = dev_of_node(dev), *child_node;
+	struct device_node *node = dev_of_node(dev);
 	struct property *prop;
 	u32 led_sources[2];
 	int i, ret, fled_id;
@@ -608,7 +608,7 @@ static int max77693_led_parse_dt(struct max77693_led_device *led,
 	of_property_read_u32(node, "maxim,boost-mvout", &cfg->boost_vout);
 	of_property_read_u32(node, "maxim,mvsys-min", &cfg->low_vsys);
 
-	for_each_available_child_of_node(node, child_node) {
+	for_each_available_child_of_node_scoped(node, child_node) {
 		prop = of_find_property(child_node, "led-sources", NULL);
 		if (prop) {
 			const __be32 *srcs = NULL;
@@ -622,7 +622,6 @@ static int max77693_led_parse_dt(struct max77693_led_device *led,
 		} else {
 			dev_err(dev,
 				"led-sources DT property missing\n");
-			of_node_put(child_node);
 			return -EINVAL;
 		}
 
@@ -638,14 +637,12 @@ static int max77693_led_parse_dt(struct max77693_led_device *led,
 		} else {
 			dev_err(dev,
 				"Wrong led-sources DT property value.\n");
-			of_node_put(child_node);
 			return -EINVAL;
 		}
 
 		if (sub_nodes[fled_id]) {
 			dev_err(dev,
 				"Conflicting \"led-sources\" DT properties\n");
-			of_node_put(child_node);
 			return -EINVAL;
 		}
 
@@ -681,10 +678,8 @@ static int max77693_led_parse_dt(struct max77693_led_device *led,
 
 		if (++cfg->num_leds == 2 ||
 		    (max77693_fled_used(led, FLED1) &&
-		     max77693_fled_used(led, FLED2))) {
-			of_node_put(child_node);
+		     max77693_fled_used(led, FLED2)))
 			break;
-		}
 	}
 
 	if (cfg->num_leds == 0) {

-- 
2.43.0


