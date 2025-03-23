Return-Path: <linux-kernel+bounces-573033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC10A6D21D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2CD1895A95
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AFF1F3FC6;
	Sun, 23 Mar 2025 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytCHdf13"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2812B1922EE
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769581; cv=none; b=knSWefgwsP00F4Xy3tlZAGlrXK3W8isLV/d6katb1MEABn8/Pc1h9BWyMu5bdbztJmFCrW0PslIYUbQPQmSKi1nLUQSGMiCQRwqG8yrUN6BJk73h5L9Eu+EeJ+F8WZDCpGzFh/J0Jz1ox8mnIDvFQTgqln4XKDm0LnQiyTSYRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769581; c=relaxed/simple;
	bh=CNr8O5YK2JQvgLnYqrPn1/s+31iKPD62ZA/NdspWTmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+yZL1tK8157yJ8nt8pLtDYS20eCzObRck8bnW1CH9QrxEX9bEpyajCSvop/o8WvEhv75w5vQJW8bPDt7JphHn3VLwofWezmlc1MF0V7ZRlkEy7f16Gz/zrMuZ/5bFch4t5U52vxB18llRocm5Vd3E4j0C+vsmUwsueGeo/VcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ytCHdf13; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so567665166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769574; x=1743374374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ma2h8YcPyNzHzzZtNTsrMSq+4WFWkERbNAUqbwhG/XE=;
        b=ytCHdf13wQ6wy9w2OC+acXO/7QQuQ964Lje7iCXaJKOv5ibrRpLS397TcfRJR1kq7u
         PbKza7+Uyomr8s+8ztSGfVZw/Nbf0nhi2lv/16WaVGbdKhKdI6ifWqXtKbo0KsseLr1d
         olViCTOQvQenLyUjQzkPyfTmTlk4F7LjSDoThJoTkHYv0hERy8wl8Fj6AiApIK483BTi
         S9TSqX6zG24ms89OZcRG2kK/gtpI82ihdfAFTpk3QCWwRXBkfxp/X0gX71r0l+LLX144
         YzEGBviX+jBTOmnS/oZL/Z+6kAWCvkTDVryEmVCth79Ks/ALcUNRO7qtZJt4gDgzunDP
         p5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769574; x=1743374374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ma2h8YcPyNzHzzZtNTsrMSq+4WFWkERbNAUqbwhG/XE=;
        b=xMkq4ZiJvEELS/pV2LwG9wAVG94K9ahhzR/+Ly+HS2P/AFqsiIq3YzkI6AX82wmuqk
         9DSTCt74Kx8P8s4sjcVWvuWkwu+amxYWKg3Bh2TnOLGmkqAuAki7J+O/4QVP6ygPD+aE
         p7zuycL9l86C2/xtkBYGAayOnQghbWZZK07EuRnd6m1WPDM/+k4u22CC6kZxZ0Guk7Us
         uWXMduDrcb9yvi/R/CqQJNPsDKqyKQ1NMGAXklbLydOlptZdyMmfh4cmcziCkM/bM8TQ
         gP4CEqNjA4/DbQlqpiv52LOjDWvGcLIzNaTbS94M8HOXrqxEtjpKteY7cB1rRTqtXMIF
         dHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4Qhad0kxlb/bs3PctAqNWxdovxPVqWk6w29vovKmANcfLR++Z4gI+i0LGw7wCF9o90JKCb7IP2qQ+oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMZmEpcn99IQ7/Nc7nNw1DA2tmVWpsNztlRcVCcUJBrcA8Ja5G
	hIXL6xWSUc+/bcq52OmEtjeXDpdHTp7oMYHtvIy1ZYcH9w1+cw+4NTTXszGd0BY=
X-Gm-Gg: ASbGncv4Mai0uVCezViMuvDxGJxaIRZZHhCQJ5ki/lCERWvFD8j4SDkDkImYgnDkiEk
	y8Jl9oQ5i5NoTKZehffiIxEegvXyd3qgUwmTNufMv5G3P/wgWqqwSUdSo4piU0wUDoTXDi4MRDw
	kqd8kMr9hzmtiDMYCzwh2kamPkzbxqzTjrGv0gnP5wazOHUppANlsBd5genEuHQ4nwL/06J351I
	IT35BJp26bfihRhkqvH6J1Ks5YBQVS1nzI/v52bgwzZ6JEixKqQjWgC9FxkYDVlFwqThiYlDd2o
	rHQxh9bwUaPnZB2QjQPuEXxkAgOoYd/1S99Tea5k6+jp1NZrz4C39D7FgsHNeUmUUu6lwOj6fhm
	9o8zg6weU+XSjJB69dTIWfjDWS9Yr
X-Google-Smtp-Source: AGHT+IEAdjv9xEbMYB+Oz8xJ1E35q2wdeD2HNBvV+6r3g5vXOlzMcwWya0yXpD0Ui6X7vYMMVnjHVw==
X-Received: by 2002:a17:907:d91:b0:ac2:a4c2:604f with SMTP id a640c23a62f3a-ac3f24a7838mr974893166b.46.1742769573704;
        Sun, 23 Mar 2025 15:39:33 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:33 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:33 +0000
Subject: [PATCH 17/34] mfd: sec: drop generic regmap config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-17-d08943702707@linaro.org>
References: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
In-Reply-To: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

When support for PMICs without compatibles was removed in
commit f736d2c0caa8 ("mfd: sec: Remove PMICs without compatibles"),
sec_regmap_config effectively became an orphan, because S5M8763X was
the only user left of it before removal, using the default: case of the
switch statement.

Subsequently, the accidental new users have been updated, so
sec_regmap_config is an orphan again, and can and should be removed
from the code. Doing so will also ensure future additions to support
new devices in this driver don't forget to add a regmap config.

Drop this fallback regmap config.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/mfd/sec-i2c.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/sec-i2c.c b/drivers/mfd/sec-i2c.c
index 3912baa5c2f918b7ad345e2bbbbe4daf2e49ca6d..1bdd6ea36fcd9f56ea5ec1159a87723f4c09a0bd 100644
--- a/drivers/mfd/sec-i2c.c
+++ b/drivers/mfd/sec-i2c.c
@@ -61,11 +61,6 @@ static bool s2mpu02_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-static const struct regmap_config sec_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-};
-
 static const struct regmap_config s2dos05_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -196,8 +191,9 @@ static int sec_pmic_i2c_probe(struct i2c_client *client)
 		regmap = &s5m8767_regmap_config;
 		break;
 	default:
-		regmap = &sec_regmap_config;
-		break;
+		return dev_err_probe(&client->dev, -ENODEV,
+				     "Unsupported device type %lu\n",
+				     device_type);
 	}
 
 	regmap_pmic = devm_regmap_init_i2c(client, regmap);

-- 
2.49.0.395.g12beb8f557-goog


