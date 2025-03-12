Return-Path: <linux-kernel+bounces-558510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B40A5E6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831743BA27B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257941F2367;
	Wed, 12 Mar 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOjC99r7"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA11E1F0E5F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816781; cv=none; b=pVw56t3tPEvofNGQ4DduHo1u4rV9AFK1VJqSx5yJ8xgxHBMUxVtKdaTXYFbyWmjeOuzSLasjH9FRsWOkW7djjVwF3mAFaHbXhoI515KDSArhEjHG0HdarnhIktDn698rwqgw0zo/ch3UvsCbWsO+BjNXIkfyo56omHE/OZD2TTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816781; c=relaxed/simple;
	bh=SkBbnPsVX15wtHtN6iY5cx+NaOV7n4YOhSv2f1BtU64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fV1473Zqx3Jek5JA/1Ce/35kSUGhHm4UmMB6P61wC0cuqIWOZX5QlQSEn7tE9vd2QW45nBoqd0zqzOKHx6HCR2pjjHw7prOJSIO/inVOmqtjMgT8tyKRs+cDZXJDX9a4zc4CSAc2slPDK7FNrgGr2dCVrGJziA5pmut1SwR/wNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOjC99r7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so2231625e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741816777; x=1742421577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hewRn4TFzt6guGzWgtaUCJe9z9aGdKj5SqHFjFZfBSM=;
        b=xOjC99r7GSZouOd84cH/GlT8XloOb3QGlil2gotkcj5Eb0spEi5o62Zgw/+uPFziGa
         c5KBNbqrvSabIBup4AtD4b+Z3wbOwiknDk1Gi6nmFYMnCwolr61YCQCzv667LM6dtMKu
         zJXbGUOguAv15vlL8BwX/IUUCE7/6/2EpRAlhNbhCcJ5VMrc2OG5hxELr3vGhslI2Rr8
         kJh1Xil61ow0zwlJOymQ+LPiPsq7J2Qq7dMeVjgezchMxC+lKhP17OjWXEL7PXjjJI/5
         lFw72lEQVos6LHulDJH3PcpMPdQlvyd9Mj+awlju4okoG8DnrrKoUvmtL2nLCUWrw6rN
         23vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741816777; x=1742421577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hewRn4TFzt6guGzWgtaUCJe9z9aGdKj5SqHFjFZfBSM=;
        b=X2sI73vbKNhUOoEoNCYKcrj6fUHgTjQSeBLH/svOwIsusn2xJWZrvBxhbpE09BxMt0
         sQ8K+KG3+ERF5ufygfq1TBhV4BPgi81SYa7h2XZCLxe8DnNdf0nSyh/q0yKl6wWPVDQg
         wxrjXd2xoT1zWxMc4L3awEAV7HxLzQBrVIfTp6Df3a97ObGyZt8j9LQ7w9/RClZaKqJU
         pHd0C7GI/5Ehsjl1rw68pn1l6wsnay1u7ZfKz9JLa0gzjZVheDoGJKUXT97nggH8SNcj
         gTiUO6kGbfUICayFLrJK0sr9TnqBPDK5ZY0NlyutSt7bpZg0U5giwX1uF2hEovJDUsl4
         OmCw==
X-Forwarded-Encrypted: i=1; AJvYcCWz6l/4m1Qpfnce3bWe2G30EFo9i6LqscNMaoKXxnDBPdtmDZKJLkLHe7jTRYHV63E1Fa8S+0pYqDtfCOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeNpq27mw9VKHYIx2wKPd5AQcOWj00YiHfW+RDPsr7DD+XdorU
	f5dLSMkvAzyebpvnCjVUeUrrfA05um03wcmGgfMLFdsUHsRgOVfNSOR0tBQkuYk+dOxZ9DtOZhI
	j
X-Gm-Gg: ASbGncsH+Z+K/rrZEksUNU6PN8+1dSJNem6wEyZk9AWYK8k0QZj56Y06SxwdB24G4Qz
	B3lhogVHj3mQckQFXmHgvEmQys1Zmarrr/YgiXrfaBWWxf/HTMn9sp97vmj8wXlrARZ+d/XMMCA
	WrlLUodlcp7iMCGOKcS2W7VrqI74fgOgHCap5aCwZZgv0dvo99G98EtwP7tTSCCT1a1L7JSydpj
	qAZHYJUat9kcV9kqScJjr2sAkAz0mu/VE8qArAhx6FiC6vtWkjNDwLCNuWrCyfMDeB7YZTRxhMp
	MbqDjO5K7dSxB6K02TRSRC6gzgfOCB3Nul3Jaugtm0/0yjrUP2nEExXGv0W/z0ZnB8utMjgR5Jq
	d
X-Google-Smtp-Source: AGHT+IErrW6KaUE3r0yNKle6RE9MujQTtaEPJ6L13qcJhERWA4il9AORO6vfqZfpXrdKRD87xfLXxA==
X-Received: by 2002:a05:600c:4ed1:b0:43c:e7ae:4bc9 with SMTP id 5b1f17b1804b1-43ce7ae4df2mr142086825e9.1.1741816777079;
        Wed, 12 Mar 2025 14:59:37 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([209.198.129.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188bb34asm110175e9.18.2025.03.12.14.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:59:36 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 12 Mar 2025 21:59:02 +0000
Subject: [PATCH v5 5/5] pinctrl: samsung: Add filter selection support for
 alive bank on gs101
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250312-pinctrl-fltcon-suspend-v5-5-d98d5b271242@linaro.org>
References: <20250312-pinctrl-fltcon-suspend-v5-0-d98d5b271242@linaro.org>
In-Reply-To: <20250312-pinctrl-fltcon-suspend-v5-0-d98d5b271242@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5535;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=SkBbnPsVX15wtHtN6iY5cx+NaOV7n4YOhSv2f1BtU64=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBn0gO+PsQliP2TZVr6zz3elNKIi9ZDEuphHGwft
 9qY8fm0lriJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ9IDvgAKCRDO6LjWAjRy
 uriQD/sFGSrrlBo4k9ymB93PltMTCcgETREBPLXAP5zK5ADUpQfeU3gY34DvflTL9PYlTw5UTlB
 yb0lvAy/BKiZ9lNfJJwxwI8dEnNQHz6LBDqSGW6rb5wzA0vQ25sa71+tygTSJhJyCyEphpyz2u0
 Nv9vBYCyzTusptmyNnGcnYP5KR90weJubvTaiBisuFDqZTy7KRYuYHXy5k0JAclgpXpKSIFl809
 o77xypJB7Y/mkxK9x9f3jKdGcdlMXh+9aEDwzL153/Q/pV9driNFZ8lQGtHHWcMxOSVrVhYTXsE
 pCjChZTUTh7eI0RokedEJVs/Y4jmHy/o5DPEpD2mBYpFxefK+Fv7N46dfDKtntHpaU2i6DpzMRe
 oIPJGKjU2X7YBZxMRVVF+HKWr5EsmsLrV3yKarvgH5NAa087UU7oeKRoveOYsG6tlP0+PR+12pF
 3CBqP2eMlB9cBlpaF1+jHUqVlv8RiX3X4iUIHzEgNVVl5bdygiKfp0iZX87AcXI2QZUVYnp1kDF
 rU62K7K6X4mZF4nwKkGXFBbKuT9SDKq+KqL2aRRYpkmR5MZA9woVgD1QRbkELy05Cb9ZfHZ6DVh
 02UFesU5aI9p2Dbo91xijRLvbMoIp7yGyXy2wZ3n4C4PB1QFsdTXWgVpXY0WtXSd0RH5osakIs4
 L5PQLKOLch2Q1og==
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
 drivers/pinctrl/samsung/pinctrl-exynos.c | 34 ++++++++++++++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.h | 20 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 7887fd41665111d7c4b47e2d74f4e6e335914915..41de39767a3e09a6b1cb446aeec48552546a98a3 100644
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
@@ -831,6 +862,7 @@ void gs101_pinctrl_suspend(struct samsung_pin_bank *bank)
 			 bank->name, save->eint_mask);
 	} else if (bank->eint_type == EINT_TYPE_WKUP) {
 		exynos_set_wakeup(bank);
+		exynos_eint_set_filter(bank, EXYNOS_FLTCON_ANALOG);
 	}
 }
 
@@ -886,6 +918,8 @@ void gs101_pinctrl_resume(struct samsung_pin_bank *bank)
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
2.49.0.rc1.451.g8f38331e32-goog


