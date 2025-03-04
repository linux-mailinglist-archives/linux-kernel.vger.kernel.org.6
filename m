Return-Path: <linux-kernel+bounces-545112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A639A4EB67
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FC48A0F9E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71F12DE0E1;
	Tue,  4 Mar 2025 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTDnTvR9"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D1528FFDB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107943; cv=none; b=THIfhyu+y2yBm5TEyTJpeXZ7o2eChhYfN2llrVev2D7LNpJ8PLLxqQqJMDBhkf35R+pL9TTWWYwQpwFKRzROClWfeZz+UreJEHBQ/+vG79GZzwN5EiOHL2JZK8Da8q/LUQkEXrGPNrZx+fjB/rjuk6didY+kr/h3d5DrLtozyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107943; c=relaxed/simple;
	bh=UGMJ3GCPyVV/uGz6DNqBy2mH3s73qryTRoU1mvi31cQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p727IJ2R/LOgc9j660AEYnI2OdVkBhBJQZHopNe0E6e83O9PDaDGh/PLK2T2rtosP1yJ08/hb7KoLSvU+7KO5DGzf7+mWkB7FMAE8IeCq960+WJqVDFE4Wo6o/yUsvBh9A6nw0omIvfnUoB4UrGDs+K2TO9dDqZ/d+Sk1ORydr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UTDnTvR9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-439a4fc2d65so63366785e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107937; x=1741712737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvWUKPp3Qf/mJMvtGf6kleKwT9jTpA0O53gNmEgl49A=;
        b=UTDnTvR97lbQChwnawl2/OUY6d2PQLZraBs7YRMGLL03EvYfholAzz3x8d7k2a/N+f
         qI15DarsYcaoyzYx9O8qlwSC6L3O47FwYY2MjTCYUug5dU8sNI4QEdtNc3xThqpLcJbJ
         UPz0r2TDWjVzN4b7byUxB6GTwPKhWPbgC8iKA+8SoHZuvF5bX9gAfLrQ33DPykxQsDVt
         B1L7fupERgwY7sXiI9w48uWRPAkIJKLQ5ZUAzLlMmlSbvXlZRJB0miy+MqL5X0Wqxdul
         cnwhMG+4KjG0lJcK6xNNQ80kmyxocuNWh11pj5UTJYLysfvK5j1Dqv/eHzEqAyT/D0Td
         iTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107937; x=1741712737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvWUKPp3Qf/mJMvtGf6kleKwT9jTpA0O53gNmEgl49A=;
        b=X5FVmAebMboc/JRN0hO/6sgeX1x08BRYy+tWDppYCwIbePHQI6x5ix88CIYFRrLuQf
         j9w/txZXbc14wJRFjvTg3JH+Wh7HedTBWAQjrr3pXBCtQgeZlHqq+TO1xVdgY5o5gWlq
         aqPqa1X7pe7eIvFfMHMyy1AeOAgIjip7ANmVO5Hcw3Q7PoCSQPgSUbyJKvPd3gfhPsma
         IRr99F0Rb+Bs6MuMxLJkQr0/BwJLcAGdz4hf4odQmSh9Ia/xW69LafbEwYcXaprvBSUg
         dzc3TCn4S5jkUOcE6h9IuYwctxO5jlkXgZE//bzP/l4JxnVZY2w9CIrrYmrVgeJQ6HM7
         4+pw==
X-Gm-Message-State: AOJu0YzqHh6N4jseOAYXmESYZ9R8wL78ux/YVSUYQS25pIFcixPW4dwe
	mpZ+TuErQk0R5GwOYL+sSYv8EGVH0VEdxSklTDIncj/V6Xdq0ng9Hb1+9uteK+Y=
X-Gm-Gg: ASbGncvdD/2oUZ7VQOThXNJH3yhfROrlbbQMWjLO+daTXOSJZGT8jbmBJBIrD+5iQtu
	L8iV7NmNO+CCu1sdMTym+h21oC1eR5W/dO6Gow26WSh1fWHDksC2UQdQNQohE8WheIy2Qf44121
	D3nKvOMRGh++VHmtTEpATnxiGLdgwNg6nOsVWxgAtSUVnUbpg3a/9hsPKrCcNZ2VtlR78UZog9/
	zVzYNkmbqRwB2HbBL6ZRm5eI2WbPA4hz0XmCNDdMy0NGinqiK27WWjTfyJ3Ggfbm2E0C4QwEY4N
	RZs8nmj5y5Mmc+282JwQOcG1ON/dP67fEnFMULYa6iYft3PPtlItkg47aPniZarR27eW4hcHEU3
	CPqylQtAM+EQ97ItYJfPiqvVRe1dv
X-Google-Smtp-Source: AGHT+IHZdsv7jYfFsjyY3TIB4euke/dHgzMkeAeSorD4HntlJXvk76kkhxE/lHiggYkJdsJqp3nEfg==
X-Received: by 2002:a05:6000:10c1:b0:38d:df29:e14f with SMTP id ffacd0b85a97d-390eca069a5mr17165829f8f.43.1741107937298;
        Tue, 04 Mar 2025 09:05:37 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:36 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:37 +0000
Subject: [PATCH v2 09/16] rtc: meson-vrtc: drop needless struct
 meson_vrtc_data::rtc member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-rtc-cleanups-v2-9-d4689a71668c@linaro.org>
References: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
In-Reply-To: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>, 
 Dianlong Li <long17.cool@163.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The memory pointed to by the ::rtc member is managed via devres, and
no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-meson-vrtc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-meson-vrtc.c b/drivers/rtc/rtc-meson-vrtc.c
index 5849729f7d01d7ec7868ff3bbdc5ed599aaa8238..7d38258cbe376e5a1b2af6250cb6d04c313175fb 100644
--- a/drivers/rtc/rtc-meson-vrtc.c
+++ b/drivers/rtc/rtc-meson-vrtc.c
@@ -13,7 +13,6 @@
 
 struct meson_vrtc_data {
 	void __iomem *io_alarm;
-	struct rtc_device *rtc;
 	unsigned long alarm_time;
 	bool enabled;
 };
@@ -65,6 +64,7 @@ static const struct rtc_class_ops meson_vrtc_ops = {
 static int meson_vrtc_probe(struct platform_device *pdev)
 {
 	struct meson_vrtc_data *vrtc;
+	struct rtc_device *rtc;
 
 	vrtc = devm_kzalloc(&pdev->dev, sizeof(*vrtc), GFP_KERNEL);
 	if (!vrtc)
@@ -78,12 +78,12 @@ static int meson_vrtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, vrtc);
 
-	vrtc->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(vrtc->rtc))
-		return PTR_ERR(vrtc->rtc);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	vrtc->rtc->ops = &meson_vrtc_ops;
-	return devm_rtc_register_device(vrtc->rtc);
+	rtc->ops = &meson_vrtc_ops;
+	return devm_rtc_register_device(rtc);
 }
 
 static int __maybe_unused meson_vrtc_suspend(struct device *dev)

-- 
2.48.1.711.g2feabab25a-goog


