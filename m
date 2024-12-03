Return-Path: <linux-kernel+bounces-429328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661B59E1A94
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B672823B0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061511E8835;
	Tue,  3 Dec 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="E3/FKe5Q"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04341E6DFE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224428; cv=none; b=ajEol5laY+Xty6PKXVeXH+hcm/RLr/UlgE7qi3yUgmRasjfjIS0373v3gWBSYF+cNpnlPordH0xOmCQ1jVbbGS9f4efhw9xfPrKhVQcag28l22gs1K9ydOu3Xsee8ZqmkEHVEf56UWH1zP2eAhcoqtrq+k9DT3FF1iloWXnfPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224428; c=relaxed/simple;
	bh=b2848xj2M/knGMp5XAGTu4ypEsjSHVVNIPfU0vg2jEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLwlG/04LQUfA75W/mYADGP4Krp/MuM2BZxYgbXEtJGwXRrLLAL5uFoY+3lHm2MVQDLGLQFsS+MHxLk62S+U3XPndMejaMZkh3+D6GJXPNX+k6B+elhwDNf+s5bumfgqoAbA49ehIVK6APG5TkNqwVo5KaUD6cQEboAWt1HAfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=E3/FKe5Q; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385df53e559so3004877f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224424; x=1733829224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVGXPUCXrM1gT/ZMDtfTCp3I/eTtoUz35r8Puuh49SM=;
        b=E3/FKe5QqwEe4NkqIxKDG2dSdq+k3lbTufkWC5mdAXrmLy8+vtipr4CdOBOUzxhlEV
         W5w9+HGZEoQx51HjbZdYTQVdBgujzMm/6/IrMsIvlpxU4Ot2vuPY9GmAe8BpKnbYlQYx
         kdfjCzEBvdk/xGWDF1+USvvYXsZUJ1gHNsFn5bhEd/yAtnbZi9aZeszSp3nISdZ1DKEH
         lA3Fx/i3NMSVuCgIh2+0Q0KxO+LlUb26j1e3Xzf6iwBgP1tNFEHY/3SmTccqhmVC3m+U
         snVYW8VFnb0AwDuUBc8uXTbqdpRQLYsTjTJqWVqliUxE1C6hMmPwozepDyWibhQ/Ur1N
         O2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224424; x=1733829224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVGXPUCXrM1gT/ZMDtfTCp3I/eTtoUz35r8Puuh49SM=;
        b=rD5MP2LCoG/FvbHpbhNUFZAtRlRaxj+uS3jCFtAUsLLl95DnHfwgON+EKNc3Jm1RsM
         MmQPvzEHvFJPBPO/qwIxTccpuS4NifUDBl8a3iF6nqSR4YFGq8sQp86rxLJR8F3QoIUO
         ThutjqMgVIisNW6NY+SvI6oVuS2LuyzOP6dBhjRs43AfTuDmzNc4nQKnPpVLzolGAqal
         h7IP1WTpy+D6nGG9ICPXjuEoBD8N6F0qJzKIjWRfsEJRTv2vwKlgi0SPmWyi1AXsOWbI
         +0TbIhnvRwYqcYqi/k+zaTvv0woQvXeQ2HfBf5Z8walUyEM/p5nMCuqNfeg/aftf3bss
         lmMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzDlipNcWK9AYmHNH+BbwSyzWwk2jl/8kHBBZy9I2SWhFSSyPDE+N9z/DIoraR4IYt+pnl2ZTmc172bqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7T9BXaVK6680TZtzEGPrz5aokdB2Wnc1DK4yPgqV5KDR29OP
	t4H9G0XTpn53D1Tm+MnluTlqebgsoUy7Hkyxm/xfcl1RvK8uDYKXxsBiFJ3R5jw=
X-Gm-Gg: ASbGncuXbeU2ukiTKAZSD0/F9/nTjao+duut6/wX13DkszD+nr/njTgIqafMomCGvn6
	pVjrVsSHcsHQJFYfbQULynlu1VUsyvUpEvahhko9V1MuUXF79CYeum1kYGHTt/T+6HQ8ulAxdxe
	QZP0srz/C4PJmp5WUZvLlG2MX0TAOdWoCPkqrhHc6B7SkQjJpMNt+YAZ06PpV/DECowTcBbYeBN
	GazAWGadnX/LXI9ignPwbnXGikzEggxuLgntqOiZTLnnjdYVsxBldPikc+L6Y+TzZtKQxvc7sXq
	mWET
X-Google-Smtp-Source: AGHT+IG0WtfIGcMb0kVVWnjP2rDiuvppmFHwT1gIhGdkt10NUOXv3qwgoaqe1bQFSzdCudBHUWIsyw==
X-Received: by 2002:a05:6000:1449:b0:385:f4db:e336 with SMTP id ffacd0b85a97d-385fd3c6a79mr1382407f8f.2.1733224424275;
        Tue, 03 Dec 2024 03:13:44 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:43 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 08/14] iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
Date: Tue,  3 Dec 2024 13:13:08 +0200
Message-Id: <20241203111314.2420473-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The ADC IP available on the RZ/G3S differs slightly from the one found on
the RZ/G2L. The identified differences are as follows:
- different number of channels (one being used for temperature conversion);
  consequently, various registers differ
- different default sampling periods
- the RZ/G3S variant lacks the ADVIC register.

To accommodate these differences, the rzg2l_adc driver has been updated by
introducing the struct rzg2l_adc_hw_params, which encapsulates the
hardware-specific differences between the IP variants. A pointer to an
object of type struct rzg2l_adc_hw_params is embedded in
struct rzg2l_adc_data.

Additionally, the completion member of struct rzg2l_adc_data was relocated
to avoid potential padding, if any.

The code has been adjusted to utilize hardware-specific parameters stored
in the new structure instead of relying on plain macros.

The check of chan->channel in rzg2l_adc_read_raw() function, against the
driver specific mask was removed as the subsystem should have already
been done this before reaching the rzg2l_adc_read_raw() function.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 92 ++++++++++++++++++++++++++-----------
 1 file changed, 64 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index fda8b42ded81..aff41152ebf8 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -32,20 +32,15 @@
 #define RZG2L_ADM1_MS			BIT(2)
 #define RZG2L_ADM1_BS			BIT(4)
 #define RZG2L_ADM1_EGA_MASK		GENMASK(13, 12)
-#define RZG2L_ADM2_CHSEL_MASK		GENMASK(7, 0)
 #define RZG2L_ADM3_ADIL_MASK		GENMASK(31, 24)
 #define RZG2L_ADM3_ADCMP_MASK		GENMASK(23, 16)
-#define RZG2L_ADM3_ADCMP_E		FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, 0xe)
-#define RZG2L_ADM3_ADSMP_MASK		GENMASK(15, 0)
 
 #define RZG2L_ADINT			0x20
-#define RZG2L_ADINT_INTEN_MASK		GENMASK(7, 0)
 #define RZG2L_ADINT_CSEEN		BIT(16)
 #define RZG2L_ADINT_INTS		BIT(31)
 
 #define RZG2L_ADSTS			0x24
 #define RZG2L_ADSTS_CSEST		BIT(16)
-#define RZG2L_ADSTS_INTST_MASK		GENMASK(7, 0)
 
 #define RZG2L_ADIVC			0x28
 #define RZG2L_ADIVC_DIVADC_MASK		GENMASK(8, 0)
@@ -56,12 +51,26 @@
 #define RZG2L_ADCR(n)			(0x30 + ((n) * 0x4))
 #define RZG2L_ADCR_AD_MASK		GENMASK(11, 0)
 
-#define RZG2L_ADSMP_DEFAULT_SAMPLING	0x578
-
-#define RZG2L_ADC_MAX_CHANNELS		8
-#define RZG2L_ADC_CHN_MASK		0x7
 #define RZG2L_ADC_TIMEOUT		usecs_to_jiffies(1 * 4)
 
+/**
+ * struct rzg2l_adc_hw_params - ADC hardware specific parameters
+ * @default_adsmp: default ADC sampling period (see ADM3 register)
+ * @adsmp_mask: ADC sampling period mask (see ADM3 register)
+ * @adint_inten_mask: conversion end interrupt mask (see ADINT register)
+ * @default_adcmp: default ADC cmp (see ADM3 register)
+ * @num_channels: number of supported channels
+ * @adivc: specifies if ADVIC register is available
+ */
+struct rzg2l_adc_hw_params {
+	u16 default_adsmp;
+	u16 adsmp_mask;
+	u16 adint_inten_mask;
+	u8 default_adcmp;
+	u8 num_channels;
+	bool adivc;
+};
+
 struct rzg2l_adc_data {
 	const struct iio_chan_spec *channels;
 	u8 num_channels;
@@ -71,10 +80,11 @@ struct rzg2l_adc {
 	void __iomem *base;
 	struct reset_control *presetn;
 	struct reset_control *adrstn;
-	struct completion completion;
 	const struct rzg2l_adc_data *data;
+	const struct rzg2l_adc_hw_params *hw_params;
+	u16 *last_val;
+	struct completion completion;
 	struct mutex lock;
-	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
 };
 
 static const char * const rzg2l_adc_channel_name[] = {
@@ -153,6 +163,7 @@ static void rzg2l_set_trigger(struct rzg2l_adc *adc)
 
 static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 {
+	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
 	u32 reg;
 
 	if (rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_ADBSY)
@@ -162,7 +173,7 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 
 	/* Select analog input channel subjected to conversion. */
 	reg = rzg2l_adc_readl(adc, RZG2L_ADM(2));
-	reg &= ~RZG2L_ADM2_CHSEL_MASK;
+	reg &= ~GENMASK(hw_params->num_channels - 1, 0);
 	reg |= BIT(ch);
 	rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
 
@@ -174,7 +185,7 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 	 */
 	reg = rzg2l_adc_readl(adc, RZG2L_ADINT);
 	reg &= ~RZG2L_ADINT_INTS;
-	reg &= ~RZG2L_ADINT_INTEN_MASK;
+	reg &= ~hw_params->adint_inten_mask;
 	reg |= (RZG2L_ADINT_CSEEN | BIT(ch));
 	rzg2l_adc_writel(adc, RZG2L_ADINT, reg);
 
@@ -183,6 +194,7 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 
 static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc, u8 ch)
 {
+	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
 	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
@@ -200,7 +212,7 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
 
 	if (!wait_for_completion_timeout(&adc->completion, RZG2L_ADC_TIMEOUT)) {
 		rzg2l_adc_writel(adc, RZG2L_ADINT,
-				 rzg2l_adc_readl(adc, RZG2L_ADINT) & ~RZG2L_ADINT_INTEN_MASK);
+				 rzg2l_adc_readl(adc, RZG2L_ADINT) & ~hw_params->adint_inten_mask);
 		ret = -ETIMEDOUT;
 	}
 
@@ -217,8 +229,8 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
 			      int *val, int *val2, long mask)
 {
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
+	u8 ch = chan->channel;
 	int ret;
-	u8 ch;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -226,7 +238,6 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		mutex_lock(&adc->lock);
-		ch = chan->channel & RZG2L_ADC_CHN_MASK;
 		ret = rzg2l_adc_conversion(indio_dev, adc, ch);
 		if (!ret)
 			*val = adc->last_val[ch];
@@ -254,6 +265,7 @@ static const struct iio_info rzg2l_adc_iio_info = {
 static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
 {
 	struct rzg2l_adc *adc = dev_id;
+	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
 	unsigned long intst;
 	u32 reg;
 	int ch;
@@ -266,11 +278,11 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	intst = reg & RZG2L_ADSTS_INTST_MASK;
+	intst = reg & GENMASK(hw_params->num_channels - 1, 0);
 	if (!intst)
 		return IRQ_NONE;
 
-	for_each_set_bit(ch, &intst, RZG2L_ADC_MAX_CHANNELS)
+	for_each_set_bit(ch, &intst, hw_params->num_channels)
 		adc->last_val[ch] = rzg2l_adc_readl(adc, RZG2L_ADCR(ch)) & RZG2L_ADCR_AD_MASK;
 
 	/* clear the channel interrupt */
@@ -283,6 +295,7 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
 
 static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l_adc *adc)
 {
+	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
 	struct iio_chan_spec *chan_array;
 	struct rzg2l_adc_data *data;
 	unsigned int channel;
@@ -300,7 +313,7 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 		return -ENODEV;
 	}
 
-	if (num_channels > RZG2L_ADC_MAX_CHANNELS) {
+	if (num_channels > hw_params->num_channels) {
 		dev_err(&pdev->dev, "num of channel children out of range\n");
 		return -EINVAL;
 	}
@@ -316,7 +329,7 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 		if (ret)
 			return ret;
 
-		if (channel >= RZG2L_ADC_MAX_CHANNELS)
+		if (channel >= hw_params->num_channels)
 			return -EINVAL;
 
 		chan_array[i].type = IIO_VOLTAGE;
@@ -336,6 +349,7 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 
 static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 {
+	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
 	u32 reg;
 	int ret;
 
@@ -353,11 +367,13 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	if (ret)
 		goto exit_hw_init;
 
-	/* Only division by 4 can be set */
-	reg = rzg2l_adc_readl(adc, RZG2L_ADIVC);
-	reg &= ~RZG2L_ADIVC_DIVADC_MASK;
-	reg |= RZG2L_ADIVC_DIVADC_4;
-	rzg2l_adc_writel(adc, RZG2L_ADIVC, reg);
+	if (hw_params->adivc) {
+		/* Only division by 4 can be set */
+		reg = rzg2l_adc_readl(adc, RZG2L_ADIVC);
+		reg &= ~RZG2L_ADIVC_DIVADC_MASK;
+		reg |= RZG2L_ADIVC_DIVADC_4;
+		rzg2l_adc_writel(adc, RZG2L_ADIVC, reg);
+	}
 
 	/*
 	 * Setup AMD3
@@ -368,8 +384,10 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	reg = rzg2l_adc_readl(adc, RZG2L_ADM(3));
 	reg &= ~RZG2L_ADM3_ADIL_MASK;
 	reg &= ~RZG2L_ADM3_ADCMP_MASK;
-	reg &= ~RZG2L_ADM3_ADSMP_MASK;
-	reg |= (RZG2L_ADM3_ADCMP_E | RZG2L_ADSMP_DEFAULT_SAMPLING);
+	reg &= ~hw_params->adsmp_mask;
+	reg |= FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, hw_params->default_adcmp) |
+	       hw_params->default_adsmp;
+
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
 exit_hw_init:
@@ -392,6 +410,15 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 
 	adc = iio_priv(indio_dev);
 
+	adc->hw_params = device_get_match_data(dev);
+	if (!adc->hw_params)
+		return -EINVAL;
+
+	adc->last_val = devm_kcalloc(dev, adc->hw_params->num_channels,
+				     sizeof(*adc->last_val), GFP_KERNEL);
+	if (!adc->last_val)
+		return -ENOMEM;
+
 	ret = rzg2l_adc_parse_properties(pdev, adc);
 	if (ret)
 		return ret;
@@ -449,8 +476,17 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
+	.num_channels = 8,
+	.default_adcmp = 0xe,
+	.default_adsmp = 0x578,
+	.adsmp_mask = GENMASK(15, 0),
+	.adint_inten_mask = GENMASK(7, 0),
+	.adivc = true
+};
+
 static const struct of_device_id rzg2l_adc_match[] = {
-	{ .compatible = "renesas,rzg2l-adc",},
+	{ .compatible = "renesas,rzg2l-adc", .data = &rzg2l_hw_params },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
-- 
2.39.2


