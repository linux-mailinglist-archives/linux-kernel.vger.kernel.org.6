Return-Path: <linux-kernel+bounces-545103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3680CA4E90A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728DD17F1D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB1A28D0B6;
	Tue,  4 Mar 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWwuzUgF"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74C286292
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107935; cv=none; b=f4UXAmRONkZUv7C3vIaITMkTyGM8FOqMZ7KzWApOXRJ6yj8Y7mVIJf/e4lcnxxIRNrldHJ4J5RbD8sB9VOVnXUmhqOJCAPJiPfDRbmRs+5TyzFCM029JtX7BBANzA39Xm+RIHrNT81AxR7Jl/G4RneTtwYhk6aRkP3uLzDWYLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107935; c=relaxed/simple;
	bh=uYPyL/IWo3+zxsKwPHXxHCdTPQr36Ok0GjwhGtYCZ8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXReRNV20JcHKq5uH425drqQQvdvKbYpBqb1Z8od9+M7hEnQWG/ipPmGlM6diEWpLHuHqQ9nw7Q8r+JmsSU4ehY5F8N8YE6WPrnjIxIsBwaD5ox6njieB9V1a5HWtUhYESO9xPb79bfhZSD7ajo8ieO8ryNAmAtN8bnPujm/3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LWwuzUgF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390fdaf2897so3096680f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107932; x=1741712732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1Zs+DHu4keoQ7nH0HfotkX9qiVtwoVoQvIhvtnI4DA=;
        b=LWwuzUgFnhYf5w853jXU4MbTtJG5AKP1cFGZ/rJ82kPJ6qEzUkYAnP7WpAzjw4caml
         CD9bu06MA2LmxelRdj4Wxtn1sFMXfvwP9BtZSMRcQ1pLoeAPQhC2/bo4tNPpci7HrFfw
         Dsy4ab1qeCOIN1l6SSS2f4NgX2ZjLweg2stZA0fvO8Xmwvpc1/jmpkPzVVHYH2yE79ob
         D5biFz0mJCIs5QHsQom5/OR1YrpojGaURub+qHWxfWI64nGNsABh8Fl0g5BpM8nFzf4r
         2/Qx6kTt2bI4scSFCzRpYyGVKRWSx7hmZ9z1A3sRKCSuocug2QrVMj/AcgIBNkkW8A24
         WLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107932; x=1741712732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1Zs+DHu4keoQ7nH0HfotkX9qiVtwoVoQvIhvtnI4DA=;
        b=Ndv8ebPF9tYW+/any1d+fd2+dNWUtLztLzgTUE+wT7reCd/5rkWhfvS1Sc6puwQyEi
         SBD8VgIOn+KFHS4olLtPIPQgbF3EJ4bSQsngZQk4uqVXUUt2TgxhGg5LCygOR7DJ7Be2
         9WZXpKePv/LdyA4mSD1bS+eug9Uf8MU3SFYoUcA2FNJcM/P++yXLAwI3mv2Zq0AzJc5G
         vkH+31HcA7uYqP+xR6AmIUv+ooEaNgdXIEKmPqNUwvDIvUSzl0ntW6s0FILiS5UxkJUq
         bXbUOLQMzkubVgG0fx39o1KNuinFAcwbB0QnfFZSyt2U5SP7mUj8iEPEttErH2yIPPv9
         mGlQ==
X-Gm-Message-State: AOJu0Yx5Fc2eeMXwR7dUbujTlXPX3h18Q3JnvfGm9YpDkKsEG42sa7D4
	uU7xUeBmkvx+mCErrKu+gKfbR9WdatOEC5Ad90MlSVo+eP98UYsiYMjNG9KfNaE=
X-Gm-Gg: ASbGncsggpRNGvGhLjWw4XIc0Qk+1RiowjV31gV7cKpHk0ukS75g/cEkRIRG8L1Aw9F
	19r3D9tCQC3ETrd+Anz56713xOsm8n/rO6ti7jC/JwY87cwek4O1DTa14EwtGO0jI8PCyuCsPUu
	Z5T+UmLCH4a2M4bpKvK1u9HMsfE6gd8tnV2gJhmz3d3LztXHQTo4n9sh9+sGzi7Me3TYCkcg9uj
	9UltBo0kfGKWe00ty7JjGJPTCst5SsGyS+Lp2xwR2/FHb+QNDJq1tjyfi08/MJe/7fh2GH+sclN
	FQgXWcCx72IrzAslBt9uvUk504l9qi8cs+BTNk7qA9JAScEk/j1txU+Z3+EqpuOmd4+/rUzboZp
	mhLshDyD9d2tvBTCr+piIy3qGdGkQ
X-Google-Smtp-Source: AGHT+IHSc8pjwattEBJyeHF3OjOkT41+G9Y/Rh1pozPSubIjG3eC8i5kYIqu87xMZCHZm4ULB7j+yA==
X-Received: by 2002:a05:6000:1faf:b0:391:888:f534 with SMTP id ffacd0b85a97d-3910888f656mr7939190f8f.20.1741107931986;
        Tue, 04 Mar 2025 09:05:31 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:31 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:29 +0000
Subject: [PATCH v2 01/16] rtc: max77686: drop needless struct
 max77686_rtc_info::rtc member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-rtc-cleanups-v2-1-d4689a71668c@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

When this driver was converted to using the devres managed i2c device
in commit 59a7f24fceb3 ("rtc: max77686: convert to
devm_i2c_new_dummy_device()"), struct max77686_rtc_info::rtc became
essentially unused.

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-max77686.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 7bb044d2ac25aeaaf2404b47b7e7bd485ae3d39e..6b0d02b44c8097453f704cbec9f02580fb869ca3 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -85,7 +85,6 @@ struct max77686_rtc_driver_data {
 
 struct max77686_rtc_info {
 	struct device		*dev;
-	struct i2c_client	*rtc;
 	struct rtc_device	*rtc_dev;
 	struct mutex		lock;
 
@@ -691,6 +690,7 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 {
 	struct device *parent = info->dev->parent;
 	struct i2c_client *parent_i2c = to_i2c_client(parent);
+	struct i2c_client *client;
 	int ret;
 
 	if (info->drv_data->rtc_irq_from_platform) {
@@ -714,14 +714,14 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 		goto add_rtc_irq;
 	}
 
-	info->rtc = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
-					      info->drv_data->rtc_i2c_addr);
-	if (IS_ERR(info->rtc)) {
+	client = devm_i2c_new_dummy_device(info->dev, parent_i2c->adapter,
+					   info->drv_data->rtc_i2c_addr);
+	if (IS_ERR(client)) {
 		dev_err(info->dev, "Failed to allocate I2C device for RTC\n");
-		return PTR_ERR(info->rtc);
+		return PTR_ERR(client);
 	}
 
-	info->rtc_regmap = devm_regmap_init_i2c(info->rtc,
+	info->rtc_regmap = devm_regmap_init_i2c(client,
 						info->drv_data->regmap_config);
 	if (IS_ERR(info->rtc_regmap)) {
 		ret = PTR_ERR(info->rtc_regmap);

-- 
2.48.1.711.g2feabab25a-goog


