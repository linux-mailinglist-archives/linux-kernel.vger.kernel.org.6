Return-Path: <linux-kernel+bounces-550884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF27A56555
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50C31896DC1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11E92135DF;
	Fri,  7 Mar 2025 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0Pi0z4Y"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799E20E717
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343373; cv=none; b=hRvnmbIfQL6Sv/hQzu6h+uLSowA9NWrPHeC4KguZ0LR0xPAoU6dKLh+TFoTr6xoHN+F3rwvPhsLKaXARv8Q6EkLigZbJ6KLuur72Nleesz6buVLps2piIfQMai3MBjcB3Xssnw9KHNuX/StK8Qf7znUsGiKcKUTcd1JEUTouo0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343373; c=relaxed/simple;
	bh=0g0PL41FvwddA+yzjOccP1eOi8+XeiX+2I7QmRbycHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHq9xyP7I2605+ylPeQzHCrLem7TRzAGhZHRrT3uZGc3Q2uP5pl1fTg0QpXNdRib31SbdnlbOoVgNMGVpz9BMkiUysmuy9b6ZcarkFTlwuwe769kBCYNYodKQmNmrgcJVT7BDIlk8tRV2n81OKHvRPn2G2fnfv4RGQ54HqP2PBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s0Pi0z4Y; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390e702d481so859561f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741343370; x=1741948170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpHtfXZMtovgp9ILU8zfEF7HMKzE1ti5rdjRAjVazZg=;
        b=s0Pi0z4YJotKOZAvZ/eDQZMWcQNFIXcwJ4rDEV88zvI/Facab9Ska/WmEiSLbGVRRg
         /kyiJMWAzyAezk39zGOLHkuMwyGvo2oKOuMK7Akymfq6KRgVHpHT6hvAw/JG2qfZZ4SE
         PFL8d8pkr0hKD5CnTIFS0vzh4RQyBKirwCYmDGHRcJGF7x9XCRg4h5w2peTtKY2kS/l6
         BNo+08gmGopvAiRurGqz27fG2EF+2WBGG7n9Z0fqHTO3DkZmBnBbvMpO2VwZAjycEWBD
         ++he67e36s4E5gMw49poNH7u20H7wvBi7l4xQTdub6AcofsbBnyQ7gL8hByPeOldY+v3
         AiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741343370; x=1741948170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpHtfXZMtovgp9ILU8zfEF7HMKzE1ti5rdjRAjVazZg=;
        b=wimBmZXzd3lEiv8lu5lR/4/BldN44+oOlPL55Tj+TP7qKExQOPG20NRCtE28/5fRBB
         ddXwf7G8BpS865rjcrL8FoPJx9JeioPOskTJat0vwRdsXMP1rCiL93Vz9VJbHx+iPj1H
         Lsbk0ntjENxtp8yURAzHN5bomhXzm0sWLi5fqZ9971tpVg1b0VqtTApQEvMROuwoAWrC
         VF1cC7q8FCFtx26XyIES/bEzuZkReAtBSF6FcDVReYnCsZ1G+GI3u93GSsxdbXwfg6HU
         X1jf5kQdqCB4JjDYeiUvNgpHKgjFBaj0/IRM9SUr4nuv5u9o9jGLrQjXW3qHeaip2dhJ
         Afjw==
X-Forwarded-Encrypted: i=1; AJvYcCUsjUfPDSgtqoelgYdLFs1ZKoDhyws9zJJM/0lk2jCgZ0uut+LRoqxJF7kGoskPJ6OqmP3diVoTsA+7Gv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzleB/zA6EuU8hh6tUuubVreEyoO1eEkz1LImfgRhlPlSp6+z1
	07jJFJfgSuongRr1zNoMjYYRiDkxye7Q+764w5OYFsFWhJq/X8ueWnYsDC9Ruyk=
X-Gm-Gg: ASbGncsDHC+J8ap9si2EPyfzfb3xdF9qCEGS4zgncG9UtID5z2tMwTg4bvJKGZvlfCs
	fyic55cRAXWnuMv4ofETxUuQErvabv+x68+RVUKozGD7RSpwslewBQsrkMEyhAViNCSMqOaECNx
	oQAzZ5gp3CZFDCd1V8mqKqMcfzaMTNGDrsY+3Odeg5qHEJ6JKmC4zJyXu+7N3RQve7cZ1ffQEPr
	JsPE4Pl0K6vvoipNKVn11aD9Yrouk4OxNFKypM/sBvQcnXloxXt6zU19vYXvy61fYDYwJ3GzOwA
	fjgo0UfB9QRri+X+IvCSi/PpxipTQrX5RSGo8ryKSjGKc6CI3ZQNKjYPJR2BrZBYqWN6n8ag/Lk
	=
X-Google-Smtp-Source: AGHT+IELqpVmd0fvvLrbeGlBslX14EFMXRP9VSs8vnkHH4WGNHv+xxIo63qhgA6uSenseZlnpH1JeQ==
X-Received: by 2002:a05:6000:4112:b0:391:d52:d042 with SMTP id ffacd0b85a97d-39132d883f3mr1316285f8f.32.1741343369573;
        Fri, 07 Mar 2025 02:29:29 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.90.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b0461sm49192955e9.4.2025.03.07.02.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:29:29 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 07 Mar 2025 10:29:08 +0000
Subject: [PATCH v4 4/4] pinctrl: samsung: Add filter selection support for
 alive bank on gs101
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250307-pinctrl-fltcon-suspend-v4-4-2d775e486036@linaro.org>
References: <20250307-pinctrl-fltcon-suspend-v4-0-2d775e486036@linaro.org>
In-Reply-To: <20250307-pinctrl-fltcon-suspend-v4-0-2d775e486036@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, tudor.ambarus@linaro.org, willmcvicker@google.com, 
 semen.protsenko@linaro.org, kernel-team@android.com, 
 jaewon02.kim@samsung.com, Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5749;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=0g0PL41FvwddA+yzjOccP1eOi8+XeiX+2I7QmRbycHw=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBnysqBWYKPT3JlFe3EPL9ZQ4Cxe9Oo6QkFzQ3J3
 g/okGUam0KJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ8rKgQAKCRDO6LjWAjRy
 utzhD/9SPJA0sK/S5QY+aQ2jbKWzDSNcZLzygXB/AH06vQGgCdMyqqV4uA5fnVT/7UQvweoR8jx
 TwEWWZEPyFhTyVinHXgBNc674T4NE1hHF5KYtVgU7GYV+j+Fpm3PfbJPKvvHzHncNmvE+l654Nu
 YqdVf8q3Y8+gMPqtL+C+tR/9sLO471lzqCm3qXZO95ZFSFXz9XMjCBOcAI3wS4rHq/2ydG94tZw
 02PGCPpj1gHbSOEKlwQ84OVEC8aVsWKpbF+b1Jrz1Hhd+4lpxb0SC0CbZPFFRWM38iNUFj9rihp
 d0HjNZ789nCTQR58nAAYndk62BVkK/YNKBTRDeNVl1h4IBQvFTRTP/QJjRPmWA5fUz6NpgFwmLY
 XYj0h4xhtHsNtS+6+UBwtDzyEv8ZwzT6zcxkNzTlDKqqThUcQ3sgp9cBdP1EevUWAqhj48mog4w
 3RalHQj7D5sedV0N9l1tOzwF+hW63cdSwegrbCWleLUy+ATb3W3opbrTbpquFExfx2XTYC/9QDr
 9eHpuqsNZGx4X+GnM9VMqiRWbRf8MiB/NV64I9BNzx1b6mg4LV7FuyP8+5la26T58ddcAhoLeq5
 3IvWYWer8IQ6sECPJTX6FznWnZ0eRq+8ZvOYiW0IbEkaCcnPxNhQXG2oRgAM58nFtMaop1qDPWH
 OyUnDN56Ht4kWOA==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Newer Exynos based SoCs have a filter selection bitfield in the filter
configuration registers on alive bank pins. This allows the selection of
a digital or analog delay filter for each pin. Add support for selecting
and enabling the filter.

On suspend we set the analog filter to all pins in the bank (as the
digital filter relies on a clock). On resume the digital filter is
reapplied to all pins in the bank. The digital filter is working via
a clock and has an adjustable filter delay flt_width bitfield, whereas
the analog filter uses a fixed delay.

The filter determines to what extent signal fluctuations received through
the pad are considered glitches.

The code path can be exercised using
echo mem > /sys/power/state
And then wake the device using a eint gpio

Reviewed-by: André Draszik <andre.draszik@linaro.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---

Changes since v2:
* Ensure EXYNOS_FLTCON_DIGITAL bit is cleared (Andre)
* Make it obvious that exynos_eint_set_filter() is conditional on bank type (Andre)

Changes since v1:
* Remove eint_flt_selectable bool as it can be deduced from EINT_TYPE_WKUP (Peter)
* Move filter config comment to header (Andre)
* Rename EXYNOS_FLTCON_DELAY to EXYNOS_FLTCON_ANALOG (Andre)
* Remove misleading old comment (Andre)
* Refactor exynos_eint_update_flt_reg() into a loop (Andre)

Note: this patch was previously sent as part of the initial gs101/ Pixel 6
series and was dropped in v6. This new version incorporates the review
feedback from Sam Protsenko here in v5.

Link: https://lore.kernel.org/all/20231201160925.3136868-1-peter.griffin@linaro.org/T/#m79ced98939e895c840d812c8b4c2b3f33ce604c8

Changes since previous version
* Drop fltcon_type enum and use bool eint_flt_selectable (Sam)
* Refactor and add exynos_eint_update_flt_reg() (Sam)
* Rename function to exynos_eint_set_filter() for easier readability (Sam)
* Remove comments and `if bank->fltcon_type != FLT_DEFAULT)` checks and indentation (Sam)
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 37 +++++++++++++++++++++++++++++++-
 drivers/pinctrl/samsung/pinctrl-exynos.h | 20 +++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 5f0045d03346600557fa6735bad709897c71935c..1d2a4f4b825fce4be3f3d337145f2a4128315f0b 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -369,6 +369,37 @@ struct exynos_eint_gpio_save {
 	u32 eint_mask;
 };
 
+static void exynos_eint_update_flt_reg(void __iomem *reg, int cnt, int con)
+{
+	unsigned int val, shift;
+	int i;
+
+	val = readl(reg);
+	for (i = 0; i < cnt; i++) {
+		shift = i * EXYNOS_FLTCON_LEN;
+		val &= ~(EXYNOS_FLTCON_DIGITAL << shift);
+		val |= con << shift;
+	}
+	writel(val, reg);
+}
+
+/*
+ * Set the desired filter (digital or analog delay) and enable it to
+ * every pin in the bank. Note the filter selection bitfield is only
+ * found on alive banks. The filter determines to what extent signal
+ * fluctuations received through the pad are considered glitches.
+ */
+static void exynos_eint_set_filter(struct samsung_pin_bank *bank, int filter)
+{
+	unsigned int off = EXYNOS_GPIO_EFLTCON_OFFSET + bank->eint_fltcon_offset;
+	void __iomem *reg = bank->drvdata->virt_base + off;
+	unsigned int con = EXYNOS_FLTCON_EN | filter;
+
+	for (int n = 0; n < bank->nr_pins; n += 4)
+		exynos_eint_update_flt_reg(reg + n,
+					   min(bank->nr_pins - n, 4), con);
+}
+
 /*
  * exynos_eint_gpio_init() - setup handling of external gpio interrupts.
  * @d: driver data of samsung pinctrl driver.
@@ -828,8 +859,10 @@ void gs101_pinctrl_suspend(struct samsung_pin_bank *bank)
 				 bank->name, save->eint_fltcon1);
 		pr_debug("%s: save    mask %#010x\n",
 			 bank->name, save->eint_mask);
-	} else if (bank->eint_type == EINT_TYPE_WKUP)
+	} else if (bank->eint_type == EINT_TYPE_WKUP) {
 		exynos_set_wakeup(bank);
+		exynos_eint_set_filter(bank, EXYNOS_FLTCON_ANALOG);
+	}
 }
 
 void exynosautov920_pinctrl_suspend(struct samsung_pin_bank *bank)
@@ -883,6 +916,8 @@ void gs101_pinctrl_resume(struct samsung_pin_bank *bank)
 			writel(save->eint_fltcon1, eint_fltcfg0 + 4);
 		writel(save->eint_mask, regs + bank->irq_chip->eint_mask
 		       + bank->eint_offset);
+	} else if (bank->eint_type == EINT_TYPE_WKUP) {
+		exynos_eint_set_filter(bank, EXYNOS_FLTCON_DIGITAL);
 	}
 }
 
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 773f161a82a38cbaad05fcbc09a936300f5c7595..66acbd08d3445ca6ee7358d3c4a6cb2be5d82842 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -52,6 +52,26 @@
 #define EXYNOS_EINT_MAX_PER_BANK	8
 #define EXYNOS_EINT_NR_WKUP_EINT
 
+/*
+ * EINT filter configuration register (on alive banks) has
+ * the following layout.
+ *
+ * BitfieldName[PinNum][Bit:Bit]
+ * FLT_EN[3][31] FLT_SEL[3][30] FLT_WIDTH[3][29:24]
+ * FLT_EN[2][23] FLT_SEL[2][22] FLT_WIDTH[2][21:16]
+ * FLT_EN[1][15] FLT_SEL[1][14] FLT_WIDTH[1][13:8]
+ * FLT_EN[0][7]  FLT_SEL[0][6]  FLT_WIDTH[0][5:0]
+ *
+ * FLT_EN	0x0 = Disable, 0x1=Enable
+ * FLT_SEL	0x0 = Analog delay filter, 0x1 Digital filter (clock count)
+ * FLT_WIDTH	Filtering width. Valid when FLT_SEL is 0x1
+ */
+
+#define EXYNOS_FLTCON_EN		BIT(7)
+#define EXYNOS_FLTCON_DIGITAL		BIT(6)
+#define EXYNOS_FLTCON_ANALOG		(0 << 6)
+#define EXYNOS_FLTCON_LEN		8
+
 #define EXYNOS_PIN_BANK_EINTN(pins, reg, id)		\
 	{						\
 		.type		= &bank_type_off,	\

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


