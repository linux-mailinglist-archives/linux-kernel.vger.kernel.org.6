Return-Path: <linux-kernel+bounces-573047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C86A6D22A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF1816A6EA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602CD1FBC91;
	Sun, 23 Mar 2025 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBPk1M5A"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F51EB9E2
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769591; cv=none; b=Q2ZL3SEMMAM+hIe5Q3b8CDXwcyhAIbQYBmc40xUC7MgPugL2X1KdMkIICFPMseJpUcECv8wNZPJRrWcfpCumPfC0b7z/uexBNkl5w6GcomikLSlwxF6fG4lTBLIGCWoRogy8rUgsozDNVKKTVfUqc2FKJjzp/rao8zfg03J3yEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769591; c=relaxed/simple;
	bh=ql91WCByk9BaVTq64rdM6MDbJhqEHhN99K9XM4Pc+7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bGZGLvBQPzObJ3qNvOsHsu+k6CQfjXaILYsEGH0xQqaJ54t4WBYspF776xFGYuSDMAn0tIFb1hyeaAJ/0kqvyT8UmR5dW8LGcb+PFtg2krWClBHswA59zs7jmHHeSDlEtRrwjkEyCUSR8ZBM8FilWSKWMoQd4oS9Ga0qZoE5hHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZBPk1M5A; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac29fd22163so654485266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769580; x=1743374380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsLbKQJRD9tdVXE8w0Z1fJ+0H6Ywqg5fj1IFaYNGdSQ=;
        b=ZBPk1M5AgRqdzmm45wxl9we6VgNhJ5Bw76zsi6vuh7NEQmSxKipeF8mftzaIicsVNG
         n2scCgYqggw9qtk6AneU3iJFwDqkPWSoF96OY5Ql5LASh2+QbEhzj/axfeJOctfiQHVI
         DYKJStdoEVeKXRrPGBc6oanEktDko+YvDxmQuGM33O5kh3y+q53GWuljQHdYL1OT+wDt
         9RjrlsVoOgbDQX5OP5lGS2ovx+ZqeM1ytsRDWwvattvK02occhSnJvGfe4tM8DAy3Mwj
         opoTJACjjnzCDTwHYNvFn43iqTDrbsdTHln2cwFRYyijfnvLyqcKpLP2hHz8GN5kg3Sb
         Wetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769580; x=1743374380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsLbKQJRD9tdVXE8w0Z1fJ+0H6Ywqg5fj1IFaYNGdSQ=;
        b=MGwlHyrDEzngbbxrAJQnzpNzhh3dR8SRYu7Az0Lu3bU6nXihm1opIdtJbnJHpwaSXE
         PAWsB+RQwHo9l5AyvPvG6pDop1/Y3G2lapjTeDPicGZAVYJNr6TM9JpxgO+HPeU3BcbA
         FiGueFHow7O1eU91hb6FgJr8sovTLUK6zUb+XfI06w0adoDIZ6rj5M4u3SFz4HQTW0z/
         hMYWo2i5pW1rjasJHxq2l9TRrE91t5OTB3njGN5MIq1pUrLmiCIIxkYXHjWUXWHf0+up
         2ByQfyCbKk70ylrgqRjHF/fRE4c0jF0F3w70zEFp5vhprSQT9Zwvl+iTlXOk/nvD1IwW
         250w==
X-Forwarded-Encrypted: i=1; AJvYcCWK+XQcTFlmtwM/mDvMWt8r+QXVaRcUR0ZGxjh/Hb2oiYGW9kNWKoMnhUylS/Zp7rxFDv708bDi63RI0w4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7DUN7norgUQrcz5yHYvWRQ26MViNg5SjfLuecTX4/L7v9YQ9
	PKS8feH3Iz6GufIch2Aq6gnTClVXQfSPbOE2P/ZvcoHKNdjrKic5DCUvinjVqmc=
X-Gm-Gg: ASbGncsph4LEMLZMPefCrR0jEjBNvitrfKJILM9Au+ek8uICEZKQrUMkQ/hXEmnfszt
	2NVAb7aU3mydppZBsaxLBUn0osCCOBoosjRZPUogvWqG39QVvjYcOEPG9PzZKljvwrYkZ6eF/Zp
	R9DoaPIS1ZAf8jfgdsIj8ZxgGXlXj95l8kzmPuDpJOD3wxrfZRWsdNZcM78OooPTkF5jb6/sgI9
	1lpw6rv38NyHDAG1O91qNR16+xW+AKL7OVj5TlxKUisDY+87Q55XYI18ZK+eGgysfzYYrif0BZb
	H8QlZtzDO6YJtP/PsMzu9dZN+Yemn4bjcsJ8h0MBK5os/N07KYx66DQpvtvs/Xu/GM6NEIcHixh
	diRMq/2s2+3Gf50C4acuJXDtNZPhx
X-Google-Smtp-Source: AGHT+IGvOa3XAeKcwT9Vr0T+ZVATFp5TvHs+FtoKfari/ok1W7HicIpcGqvAlFVuwPQSyDN+Jo9fHw==
X-Received: by 2002:a17:907:8694:b0:ac3:b277:2474 with SMTP id a640c23a62f3a-ac3f2285fcdmr1145400566b.28.1742769580258;
        Sun, 23 Mar 2025 15:39:40 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:39 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:44 +0000
Subject: [PATCH 28/34] rtc: s5m: prepare for external regmap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-28-d08943702707@linaro.org>
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

The Samsung S2MPG10 PMIC is not connected via I2C as this driver
assumes, hence this driver's current approach of creating an I2C-based
regmap doesn't work for it, and this driver should use the regmap
provided by the parent (core) driver instead for that PMIC.

To prepare this driver for s2mpg support, restructure the code to only
create a regmap if one isn't provided by the parent.

No functional changes, since the parent doesn't provide a regmap for
any of the PMICs currently supported by this driver. Having this change
separate will simply make the addition of S2MPG10 support more
self-contained, without additional restructuring.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-s5m.c | 83 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index 31bdceac7aa245175a30eb13eaaf1f52f70e22c2..86ccf666c68059408907c97f2647716ffaad10c6 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -640,51 +640,60 @@ static int s5m_rtc_probe(struct platform_device *pdev)
 	const struct platform_device_id	* const id =
 		platform_get_device_id(pdev);
 	struct s5m_rtc_info *info;
-	struct i2c_client *i2c;
-	const struct regmap_config *regmap_cfg;
 	int ret, alarm_irq;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	switch (id->driver_data) {
-	case S2MPS15X:
-		regmap_cfg = &s2mps14_rtc_regmap_config;
-		info->regs = &s2mps15_rtc_regs;
-		alarm_irq = S2MPS14_IRQ_RTCA0;
-		break;
-	case S2MPS14X:
-		regmap_cfg = &s2mps14_rtc_regmap_config;
-		info->regs = &s2mps14_rtc_regs;
-		alarm_irq = S2MPS14_IRQ_RTCA0;
-		break;
-	case S2MPS13X:
-		regmap_cfg = &s2mps14_rtc_regmap_config;
-		info->regs = &s2mps13_rtc_regs;
-		alarm_irq = S2MPS14_IRQ_RTCA0;
-		break;
-	case S5M8767X:
-		regmap_cfg = &s5m_rtc_regmap_config;
-		info->regs = &s5m_rtc_regs;
-		alarm_irq = S5M8767_IRQ_RTCA1;
-		break;
-	default:
-		return dev_err_probe(&pdev->dev, -ENODEV,
-				     "Device type %lu is not supported by RTC driver\n",
-				     id_entry->driver_data);
-	}
+	info->regmap = dev_get_regmap(pdev->dev.parent, "rtc");
+	if (!info->regmap) {
+		const struct regmap_config *regmap_cfg;
+		struct i2c_client *i2c;
 
-	i2c = devm_i2c_new_dummy_device(&pdev->dev, s5m87xx->i2c->adapter,
-					RTC_I2C_ADDR);
-	if (IS_ERR(i2c))
-		return dev_err_probe(&pdev->dev, PTR_ERR(i2c),
-				     "Failed to allocate I2C for RTC\n");
+		switch (id->driver_data) {
+		case S2MPS15X:
+			regmap_cfg = &s2mps14_rtc_regmap_config;
+			info->regs = &s2mps15_rtc_regs;
+			alarm_irq = S2MPS14_IRQ_RTCA0;
+			break;
+		case S2MPS14X:
+			regmap_cfg = &s2mps14_rtc_regmap_config;
+			info->regs = &s2mps14_rtc_regs;
+			alarm_irq = S2MPS14_IRQ_RTCA0;
+			break;
+		case S2MPS13X:
+			regmap_cfg = &s2mps14_rtc_regmap_config;
+			info->regs = &s2mps13_rtc_regs;
+			alarm_irq = S2MPS14_IRQ_RTCA0;
+			break;
+		case S5M8767X:
+			regmap_cfg = &s5m_rtc_regmap_config;
+			info->regs = &s5m_rtc_regs;
+			alarm_irq = S5M8767_IRQ_RTCA1;
+			break;
+		default:
+			return dev_err_probe(&pdev->dev, -ENODEV,
+					     "Unsupported device type %lu\n",
+					     id->driver_data);
+		}
 
-	info->regmap = devm_regmap_init_i2c(i2c, regmap_cfg);
-	if (IS_ERR(info->regmap))
-		return dev_err_probe(&pdev->dev, PTR_ERR(info->regmap),
-				     "Failed to allocate RTC register map\n");
+		i2c = devm_i2c_new_dummy_device(&pdev->dev,
+						s5m87xx->i2c->adapter,
+						RTC_I2C_ADDR);
+		if (IS_ERR(i2c))
+			return dev_err_probe(&pdev->dev, PTR_ERR(i2c),
+					     "Failed to allocate I2C\n");
+
+		info->regmap = devm_regmap_init_i2c(i2c, regmap_cfg);
+		if (IS_ERR(info->regmap))
+			return dev_err_probe(&pdev->dev, PTR_ERR(info->regmap),
+					     "Failed to allocate regmap\n");
+	} else {
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Unsupported device type %lu\n",
+				     id->driver_data);
+	}
 
 	info->dev = &pdev->dev;
 	info->s5m87xx = s5m87xx;

-- 
2.49.0.395.g12beb8f557-goog


