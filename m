Return-Path: <linux-kernel+bounces-289970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C57954DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9658FB221AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B0E1C57A8;
	Fri, 16 Aug 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvQIZ+Lo"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D11C462B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822341; cv=none; b=kuQsGbBgQ2PAhou9IrJhwXxi71lnd7Xq/ggqZufMHY+fp48emjKHYdPVnM3e/v4xRhJnEfptjFqdKVILudgrKSPQ3wNcwFyuMQSpjs/G2kBnNZah5lDzngCPlwQbxah5OfPgSOejdqhI4oSLMM1iEcayRK6z55/rOwEAK4F1Lwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822341; c=relaxed/simple;
	bh=HqurU8v6FoUuPIeHjxpMhqt9yfUTtSWFQuHadg1beqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LGQ8HL6sNIUiV66lNaF6045Cph9266amZxgK5dRvaqo+Vwrp1zV7sCIae2eNItrhY9IdBD+7+6UArhT8qpBWA/CpwwEQZjgB0Q7KL/hyoGF412X+hmythecFpTZdf33vHJGuRQqyzAyUImeLZ+oJRwrYADFiAmGau/DLxcDsN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zvQIZ+Lo; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso24848621fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723822338; x=1724427138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4o6NVK+5RxP9AE82dc0tQeAqHho4Q+RR5k5EOL8qCE=;
        b=zvQIZ+LoqGoAcqg0sNzRFRvXKZgqvUzwF1f2upOBw9un894jr8Zd8hwXWdCRwDl7Ak
         pR+tElq70vPTpFKtIaZD1fcTdDW5Dt5vscOvaELgsAwRMIp/Xz7WKveNYwD7YfgOMz87
         yXBSSk9cEC1qhzPTf3VFXgeWR7KYzCtzN0aWZiaCkfKjZQCxwXj2ZrvpcZx6v9WPUI8j
         tN6snZAhAdqZ+S80ySbiTDAoOADgREpb2D5YoJfBdfyOf9s3+eaaI9JILNvdd6hckkZ3
         gAILUzH12CVQrOSFTb/fzVC91YRwXEsvyJ0NQtrKQ0DWv7rbDakiJRJ2wXnVc37oluBP
         UTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723822338; x=1724427138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4o6NVK+5RxP9AE82dc0tQeAqHho4Q+RR5k5EOL8qCE=;
        b=qEcyA4SJ6at3S7QRWjdT9ieUl7lIjK6M5A5+xj57pYJKdq6YnMSmQyDH132GJrVOkW
         rtffH+gGyAoZGKsowTCxhD6NnZqdj/v7lzhSLd1W2lA4fQLT/zIFj6nYc6UD/MKK1Vr0
         L220Eas/SDk5LVb+2sOD+XHQzgmq7LKDPTl1DX+ERmHoKNCgxxF71RCfR57PYaFuQk3k
         vp2WGXYAP/Ah3Xo9F7zhVqQe6rG23f1TLBJ9U9d0xx2uC1ZdYbIuaX5j6ch9CqGtkyFn
         yVvKk/FYsbjdrDEkDSLu70sAPNO5ACXla7vDFiA2+6YFoGr6dR+C9r956n6xRcSIqrq5
         v3lg==
X-Forwarded-Encrypted: i=1; AJvYcCW3XxnIIdlEEjMjaKq9OPds3IwuRc8/e5Es/uPxEEu3xiX+kvGSXSCcgGHd8ZHHwDj/Rfb+TbUhZQMtONeMWjyT2R8nWCi0KES4TPGc
X-Gm-Message-State: AOJu0Yz6ZB7xUVxoqphp4W3fX5BLYn80Vy0RSyeERwuYz6ijnmzzVVCk
	8SR14oBtfL42VImlz/T3Kb0lYFTjOCfkQzvB0SonEhU92hg6OdMuV9fuQeFxwQo=
X-Google-Smtp-Source: AGHT+IET/CjplVHoqhJT1dgGbpnM7bOR/IOJJFLcUpaq7hdaaWtUXfMeQ9ArJ1WuxrwkKCsQRRpLyg==
X-Received: by 2002:a05:6512:3d1e:b0:533:d7d:a34e with SMTP id 2adb3069b0e04-5331c695987mr2342012e87.7.1723822337538;
        Fri, 16 Aug 2024 08:32:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497f0sm3853661f8f.39.2024.08.16.08.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:32:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 17:31:48 +0200
Subject: [PATCH 16/17] leds: turris-omnia: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-var-v1-16-1d0292802470@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=HqurU8v6FoUuPIeHjxpMhqt9yfUTtSWFQuHadg1beqc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmv3Dn/4FodrZqZy9l8ymKC3RzvyZz5qUjuY2CL
 I8dXCHswfSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr9w5wAKCRDBN2bmhouD
 1/k9D/9UMNk7RM3WQGHAruhcdLJVhguE7sJuyHNKcv0JiIT7rLqrxgI0kl0TXtijoBLQifUtmXZ
 n35/z2TOA0jMGVqDPqGfeNVLVubMwH2nrI2Ni5HcdxRIcVmOI5Qx8hGIAXD8y0+OJYkM+e9+MMW
 09hTenPhrVmvb8M7YhycHH1JSDV9cQj5pWdYrcf9X259N9O2dQzVfpdI4UA9GtQqSNLEkbuW9Hp
 y74zqYk3zBvM3xAlvg43roVpp4MqjH45PtJ11CNOOpMNAVh4KO+73Sx7Y/Zxhc/iHv18ky49WfS
 lGjmWX7aYivBbwfKDQrc1uuJsio9CXHKui9IFVREXod3XAW8dFzQmBJhlmrhp2ppVcf3wqOCd/g
 v2zH8BG+SM+ulHja62+nlUfuD6B6vDBpNLRKLkHC0jKuhUb2yXe4OFT17v8Vwkzs6/t0vCbKIoW
 idbzDQf82L1WtL+yWv/brsico0O/8/FBiODTt15BMAZ4wYOG5YrOem6kGbv8kSxea9vP+S7vpdO
 9JpanPlCJQ8Z4xlCm3uumDcswywrJ9FhFvqonNLpVQfBwk6gcMt7q1GkAsIB0P6LjEgEHgdm3qD
 ZGlGjHkSWXHGIFYWFg5IYbAYfEzX3nOZJAkkSKxMA+DQOjYqzxql8WnOoHOeUfh0p5rdk1Os5pI
 C3oB8c3EPtY7V/g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/leds/leds-turris-omnia.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-turris-omnia.c b/drivers/leds/leds-turris-omnia.c
index 39f740be058f..1ef942b5cefa 100644
--- a/drivers/leds/leds-turris-omnia.c
+++ b/drivers/leds/leds-turris-omnia.c
@@ -452,7 +452,7 @@ static int omnia_mcu_get_features(const struct i2c_client *client)
 static int omnia_leds_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct device_node *np = dev_of_node(dev), *child;
+	struct device_node *np = dev_of_node(dev);
 	struct omnia_leds *leds;
 	struct omnia_led *led;
 	int ret, count;
@@ -497,12 +497,10 @@ static int omnia_leds_probe(struct i2c_client *client)
 	}
 
 	led = &leds->leds[0];
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		ret = omnia_led_register(client, led, child);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		}
 
 		led += ret;
 	}

-- 
2.43.0


