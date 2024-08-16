Return-Path: <linux-kernel+bounces-289963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898FC954DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD102813D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79A81C378A;
	Fri, 16 Aug 2024 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mk4VUMnu"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01E1C2313
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822330; cv=none; b=QIQQBriExrwAZBDzLkND/aQ8wd3+Avgq9P1ILy45AJfN3jzM+9RtOywlmVQ6mWMqgbKe+WfOI7gIN5seKSfqHUi6VyQdZFkgU10NPvEYrrRqFqbuQeHp3rhiXZpQF9jqsfrJT2k7PpbF32U2ECC5vQuWqLa3HyhQz+AVRbYxqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822330; c=relaxed/simple;
	bh=+81/quQFHALMpUB6fQmVb6mYEiHO0lEYq5t7UhRRMzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ENnAOoqBCkTZEUmT0Bk+LV4vkpF0CYQo+ZcqGX6NtierrynHWnuPM9+Gi1F4jC9v4W61b0ZPqWdKDUCwsJEwAscOqAwiYyyMxZC6bv3dPnFFFsqVHnJOO6nxTjDkSr+mZF//Dv4pPEGfZQZvLD8ij7HZ1RsE/iLNzMWlRjN1yPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mk4VUMnu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3718cd91185so841517f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723822328; x=1724427128; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGaV2RDOc8MAwrZD+PEbChQMiUdw7FasLLrpXnw03mg=;
        b=Mk4VUMnu+OJVGrawouDVin58SeQT6PbCEp4RNNDcp4CUBHymeM+PmpMMAGU0KRqxvp
         ys9e5FZY1aI3o2WmENTAtCkPrJXHpc14ljMv8+gNAlB7JrnY24fQwpzVvTUXqnKbNSN8
         JNgFl7nCUvA6rgiXtWAkgTVX1XiPHc1xSDLO/sc9cR0D8uKfLQ/D1+8jCXd0gDJV/2n4
         12LvLOLYebJs4aCQG+/zQLXdzueaOw3R2drEh3g28o7rHR/r8CL5/cUDes1EkJ3LjOPL
         Bk32YDgx+aOA0MEpXCyGJgZKoVYxx16co+mT3uwKybE4fImZyek0IPyct/9EACMtMCa7
         ffOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723822328; x=1724427128;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGaV2RDOc8MAwrZD+PEbChQMiUdw7FasLLrpXnw03mg=;
        b=DbvTaVV8XaatddQk1w1omC9wBoyEJ/x1a2tFB+TWa1afBpkPVeIeDmb833YHoEfJnQ
         mWpH7avrLTGPqJrictsnW1u+JRHYE8bPrOp+Osr3yiqbFNj0T8HD+Fsf8bU5IvXSjtKV
         nO2jagSomvn4pNp4/zpTJvHZ42Eylp7HACN+xQfwklZ+HQMTvc4LoKunzhywr5GqjrVh
         U6Jl9AJgy9RofaEocSVVB6Fz1YsNPb/VwQUHBd0VO0zGdICPfonrLjUKBc+UWe1cy+O2
         WQYX+C8YXhMWhpnViyO2xXxCTDbCOtPGeDqp2s6WQ7fldSR6ZrZuRTDOa0tqdz+CK8cL
         MaxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxkWyYNJ7eoWjQAstxaP/EsFmm8zOost5HtH1yGcQE/yqWTRbtMLHGDtaHJKt8ht2lOW981vj+D/XEu+IQv5sny2SovdGNch8+lwU+
X-Gm-Message-State: AOJu0Yzvx77JdDltRe3HwdudOEvcS9xHTPdyCZRF5l5rQ1s9ImzQ+oLX
	iPChZQmjgz2nAPm7VJYnQrFdnrhGE98EX5JG2fTD7NJY4ZASh6/zHVQ1BSYDGHY=
X-Google-Smtp-Source: AGHT+IFfmPaV7HvNPh3uTKrf3gPU3+DlTc+If8+6DTZ+FnUuks5SQ2r0R/qNXIMR4vvm/S2Vv5bzyQ==
X-Received: by 2002:a5d:4e4e:0:b0:360:7887:31ae with SMTP id ffacd0b85a97d-3719468d263mr2762190f8f.54.1723822327656;
        Fri, 16 Aug 2024 08:32:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497f0sm3853661f8f.39.2024.08.16.08.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:32:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 17:31:41 +0200
Subject: [PATCH 09/17] leds: is31fl32xx: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-var-v1-9-1d0292802470@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1925;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+81/quQFHALMpUB6fQmVb6mYEiHO0lEYq5t7UhRRMzs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmv3DgYLr3gj7531lmAyEQypWWevzG4gT7CE04J
 K7wVw1+wd2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr9w4AAKCRDBN2bmhouD
 18xTEACSro+sjGBUtLTGgjVaSxyV60PtwZwyOAK7Fqq5RH1ZZVgzESSlUU4qdgNYZeDkODJl+XV
 q7Orhu0Ajk5cK5db9fLOIQJkaXRvUU47dRau+PErZEtCvDdRmpFkxBMmw8KR0l/Vnv4RYUZV3Jm
 P0cQEcKCg9YRbojaWpMU+quoyK5LaLGG+Cx0tPZeSuUJpJTOGFZ1J45hL6greDe5n2VKdBukx6a
 aZWqSnZrvVfGnwiUx5a2CGDix7osxzq7lmbmutLc6T/AY65rW3hg5oCT1O7jYY3uuXD0Laf42eC
 BBTlIhd6KtnfY2oto8IDnEA2vKT8PjFD/nN7rSdU41LNMMDMDYz7erZQsvRjYvSqguihznoR5/B
 Bv+QTFItKK/xXo1rDiigsO8nYwzjLJLRt6HRkQJYq+Vjpoalu2pdQst+Ag3PG0PL2UBBR5jGGgm
 T8gf3mtGBE39cfCl/Mzx0EtK+q1COmuvOZzQdjByTdCoDc81E41quD4JvGt4IjHKJttzblIkOuw
 wD1jYqT4VIgAxshxIwIGVhY7xHvx7CIPQjOmj499jKFh4+alZP/cTnAnUfiDZ4m/3sKulB8kiqF
 9NGVGnke+Ui9f3fbfrhIjExOqOW7HcXHD7w+LwnJSHkvbiclraXKpDezFEiTmuvKQ2slyYcVW1r
 zTb+hCEeRcSiRkA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/leds/leds-is31fl32xx.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-is31fl32xx.c b/drivers/leds/leds-is31fl32xx.c
index b0a0be77bb33..8793330dd414 100644
--- a/drivers/leds/leds-is31fl32xx.c
+++ b/drivers/leds/leds-is31fl32xx.c
@@ -363,10 +363,9 @@ static struct is31fl32xx_led_data *is31fl32xx_find_led_data(
 static int is31fl32xx_parse_dt(struct device *dev,
 			       struct is31fl32xx_priv *priv)
 {
-	struct device_node *child;
 	int ret = 0;
 
-	for_each_available_child_of_node(dev_of_node(dev), child) {
+	for_each_available_child_of_node_scoped(dev_of_node(dev), child) {
 		struct led_init_data init_data = {};
 		struct is31fl32xx_led_data *led_data =
 			&priv->leds[priv->num_leds];
@@ -376,7 +375,7 @@ static int is31fl32xx_parse_dt(struct device *dev,
 
 		ret = is31fl32xx_parse_child_dt(dev, child, led_data);
 		if (ret)
-			goto err;
+			return ret;
 
 		/* Detect if channel is already in use by another child */
 		other_led_data = is31fl32xx_find_led_data(priv,
@@ -385,8 +384,7 @@ static int is31fl32xx_parse_dt(struct device *dev,
 			dev_err(dev,
 				"Node %pOF 'reg' conflicts with another LED\n",
 				child);
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 
 		init_data.fwnode = of_fwnode_handle(child);
@@ -396,17 +394,13 @@ static int is31fl32xx_parse_dt(struct device *dev,
 		if (ret) {
 			dev_err(dev, "Failed to register LED for %pOF: %d\n",
 				child, ret);
-			goto err;
+			return ret;
 		}
 
 		priv->num_leds++;
 	}
 
 	return 0;
-
-err:
-	of_node_put(child);
-	return ret;
 }
 
 static const struct of_device_id of_is31fl32xx_match[] = {

-- 
2.43.0


