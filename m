Return-Path: <linux-kernel+bounces-289967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A60954DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D90E1F21743
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87D11C4601;
	Fri, 16 Aug 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlIWNI5N"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437DE1C3F11
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822337; cv=none; b=NtOfAUPNKdDkNfmvBCPLjUbirEBlu77NW0XpSnevjFGnC7ffD53+K+LFbpI57F+1yjv7/DB+MpKZXJPPoic4C9Tp2snr2c4YtblnZuUZLil87hJ/L5IBNkRLk66g9EMLR4hljBa91OIvuGmb0i5k3VfnKmIDc9eX0q3q7+WTy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822337; c=relaxed/simple;
	bh=ZbpwvH2ustjiwLvVNFB7gNYO6vZKL2oVpGeN6mWbO44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEfVTXgr4DXYSHQV6aLu9NGk4ctF9NIvZDc+XzvcHWdjI3Zwm23+ZPlebEgFyzcvVkqjhfv53muFuSe0Z4CWyTiExxpvqFatE++wgxznVUb8tJGfSgSdVhnBowZjgo+tHCU2OgwQ02u+PFah49oBHCAXkWb8x3TaAiUyAMCj480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AlIWNI5N; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso14936795e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723822333; x=1724427133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JgxLZXaOT7jTL6qyBA9SLrwZQeJRHeBJE8R6L3hV10=;
        b=AlIWNI5Nbr2dsS2braiesxfSuHAtlapKnUKxJDAMCfvoKb43Mk+ktqOsnrdgeeYJ8p
         DeMZM/FwPRUNFhF2A3nI0s4qN7qF2njf19VU7Fdi5B/gmPY0KWpFh4aQpLn0QkQuuYa7
         Mmi88vWknfQxUpyBDp5ttiTC0iA03vcOaGTI50wvTNWS4kshxSp7sQKsHAweUjeuTtex
         n6X0Beij2O1kRF5JjMSTm27nQ1f9uje/1yJE8VsXEFRAULmU6j6zRdIQDStodofQEJQ7
         1O1NmcL6qVwYzoR6foQSjWYskzODMxq9yt3+j5BbVQ5jfbDMrc2ljRcpdqs0X8pL68d2
         cfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723822333; x=1724427133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JgxLZXaOT7jTL6qyBA9SLrwZQeJRHeBJE8R6L3hV10=;
        b=rvHhlNIdg95cLKknfMRHIdq7TsKnVKspqghTaZjCo9K6H+2Esq74001SqXq6C8hITm
         seZELuGW6c+boLoMtlqiI6AbTuYxAn2xov6PRW93zF9kPv1PV+RgfFX7L5XTZbmjx+JH
         Evou8PUJyR+sFXcGzJ6wVm/V77eLNe49Gop6El9B7kLEeZARQWntTQ5YH4IB2W+ldeYw
         +PsG8udkIzERBq8UEocN9H5v0ijzLw68w3CSEiCRDgbdX/5X5QzfkpiIsda+5+OduwHh
         GTo6pFAJO3bfKEBbddzRQjgFm0mNNzNwkPp7gl+gh/pMY6ODdAfApjFwJrrQkjHvMiWV
         RWoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7B7KXn1ZCconF7b18F3X1O2dnDmFsCSWpvNA85LAP1CQD9Aq4/ApItT0hVvHwMuU3wyvpl4KjVRy+TKc0J0QV7KB5Oby1DkiiJbUC
X-Gm-Message-State: AOJu0Yx9VbSja0jlMZyXKQmeNuxf4OL+crf9lkqlfDoXUOnffSQvUWUb
	FO9aoEoc29/Bgi+qe+VYYzG85jP0CUWpv7Oj8TGzN1BsemZgzeBTj0fSwKyOQrA=
X-Google-Smtp-Source: AGHT+IGEXRtSKYqMHdRXL9A0IVWYnjdiaFA3vVmWXlDDw3F+xS7fwXoLMur4GHVC1AGF3Jdg085/ig==
X-Received: by 2002:a05:600c:3b1e:b0:428:1fa1:7b92 with SMTP id 5b1f17b1804b1-429ed7ae3ecmr20377775e9.19.1723822333456;
        Fri, 16 Aug 2024 08:32:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497f0sm3853661f8f.39.2024.08.16.08.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:32:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 17:31:45 +0200
Subject: [PATCH 13/17] leds: netxbig: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-var-v1-13-1d0292802470@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2775;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ZbpwvH2ustjiwLvVNFB7gNYO6vZKL2oVpGeN6mWbO44=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmv3DkDqyZck82XNzSXwocQQY4b+BjTR2I/skAe
 /0iaxSnekWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr9w5AAKCRDBN2bmhouD
 1zT7D/9LA9styAbhhWAgbwLixcjU5nsbijFUo4i2fJCjHsFr6OI5L9kYopu/4IqvUkdsFfIoLoi
 Am8mhH37EL2J7Wqaa4UyyyDhl828FW+J5WWGorkvyeZub68/URCiLwlvw754aiqAlZvXBcUW/wq
 DBvZUCDT2I93vgdlaK8T+jaeqXFh/ZiPBGOopvru4O/IHC8Q3T/uKoAKcF/IlmDptsz/l127ml3
 Wj1RmTgWTFJ1fnpxd4gFo9bEMZ8NcmHpidcBQY8G8A82hJlKNJ3qqz5RXVPaySGdGSv/9YUF7bw
 rdOrzSpRB3vBzgAt9HuRDAdzaCZJRYlbW7g4/mDP71dpVRnDebllQX/BJhobp4h+MA+4ZLGFfET
 /fCp//41B8J4LrjD14f7Z/j3HXXGthuMBpi+WTQRXiS5QSRwzAjIYV13D+dmbCuzGPD8aMwAWLZ
 Vii9spzKcwv3Y20GxPQuHXVeIIY8Fp3lyhfwCO7HBJbzmUi9sKfcWPvjKzFIpJHodgEt/L34942
 8qp2LY/qUq2KqrGKhePZtJW8D5tfXBrpDWpVZPb2zByLex/FttuvcKtjzvwP1q6pf2J/MzD8ba9
 QJbWLFhD1zPgxo6X+YG9IePLDsz6HLk1vH8xbfu8ppnwbToivodXMGG9k78U7yqj6vG2S4ZjsC+
 neKFv1FiAciy6/Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/leds/leds-netxbig.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index 77213b79f84d..af5a908b8d9e 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -423,7 +423,6 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 	struct device_node *gpio_ext_np;
 	struct platform_device *gpio_ext_pdev;
 	struct device *gpio_ext_dev;
-	struct device_node *child;
 	struct netxbig_gpio_ext *gpio_ext;
 	struct netxbig_led_timer *timers;
 	struct netxbig_led *leds, *led;
@@ -507,7 +506,7 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 	}
 
 	led = leds;
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		const char *string;
 		int *mode_val;
 		int num_modes;
@@ -515,17 +514,17 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 		ret = of_property_read_u32(child, "mode-addr",
 					   &led->mode_addr);
 		if (ret)
-			goto err_node_put;
+			goto put_device;
 
 		ret = of_property_read_u32(child, "bright-addr",
 					   &led->bright_addr);
 		if (ret)
-			goto err_node_put;
+			goto put_device;
 
 		ret = of_property_read_u32(child, "max-brightness",
 					   &led->bright_max);
 		if (ret)
-			goto err_node_put;
+			goto put_device;
 
 		mode_val =
 			devm_kcalloc(dev,
@@ -533,7 +532,7 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 				     GFP_KERNEL);
 		if (!mode_val) {
 			ret = -ENOMEM;
-			goto err_node_put;
+			goto put_device;
 		}
 
 		for (i = 0; i < NETXBIG_LED_MODE_NUM; i++)
@@ -542,12 +541,12 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 		ret = of_property_count_u32_elems(child, "mode-val");
 		if (ret < 0 || ret % 2) {
 			ret = -EINVAL;
-			goto err_node_put;
+			goto put_device;
 		}
 		num_modes = ret / 2;
 		if (num_modes > NETXBIG_LED_MODE_NUM) {
 			ret = -EINVAL;
-			goto err_node_put;
+			goto put_device;
 		}
 
 		for (i = 0; i < num_modes; i++) {
@@ -560,7 +559,7 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 						   "mode-val", 2 * i + 1, &val);
 			if (mode >= NETXBIG_LED_MODE_NUM) {
 				ret = -EINVAL;
-				goto err_node_put;
+				goto put_device;
 			}
 			mode_val[mode] = val;
 		}
@@ -583,8 +582,6 @@ static int netxbig_leds_get_of_pdata(struct device *dev,
 
 	return 0;
 
-err_node_put:
-	of_node_put(child);
 put_device:
 	put_device(gpio_ext_dev);
 	return ret;

-- 
2.43.0


