Return-Path: <linux-kernel+bounces-429320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 921BD9E1A77
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57901166833
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717AD1E410E;
	Tue,  3 Dec 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hBoIfaSe"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750E01E379F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224415; cv=none; b=DX95uLi3dK5XuRNjI0K2gIpboT4veYmMEAWeaAhn2s8rjNC5oyATeZS9qCosFFUQ3iu1ZrNPokBj1/o7wdRQsjneVU/1JrMJ7bAPwzL8Jh3MsX9Tco90Baue/oVIPnexKl9TkFbcBSrYgWrs2mldSym/wEAPD8pCCMV8QnLz890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224415; c=relaxed/simple;
	bh=RopmsHTG1UMXuCUnIG+niJrDqNJE2KsmP2ZTr3/uJ6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmwcIOkWXGLq5J/lI+NPUEnl+NVcW2ZTKtbNfIOvQpvZeMDKpaqHl3okaRTqfh43+gPN0LB42Ldlnxtfx5408Cup0rwLHIs8+gnzEHqSvqj82LgaezZETRpLBv/Y3qqIr439mnbiu9Se3weLsZc2txHJjzmII/q48IsCy/TCncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hBoIfaSe; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e1721716so2000813f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224412; x=1733829212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIh9KG2087Lc+/NI/AZoCh8y07VQf1QjJuvqfBHru8o=;
        b=hBoIfaSe+BXx6O+LiZ/rUOMryCvJN2i7iTN2L9i+R82ZVi4J9j6jM4IvcIu57xZELp
         pG0+ac3WT0blI565/gIMfJs/ziLgxBqISYLaAloHYamJ1P0v2RiMRkvIP7x3qd1FCDFn
         XzL1mvc6AZdY1v3K9CCowy5tjmTqaUpKo2NfdNsbslwnVBe52/sbrEhXuf/eDD77l8Hy
         N9RpZ80XrCq6yezT4uYFDKwIXrgUfMB4tAqBjuOuhxoO899YCgUdWhBPLQMPQQIxm/Wi
         Wp37pDiNeLfmBAVn7gMimlRNGN+Kd9BsDnN4LKztjjufK86Nh4zcTJ/BMKwAyd7tGRHe
         wvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224412; x=1733829212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIh9KG2087Lc+/NI/AZoCh8y07VQf1QjJuvqfBHru8o=;
        b=uh0dFPGSvUpGZaFDzy+v0e+2q12R1qbyXe9B/9zUZ1ty/3CI7xs5xE2rwfdlXOEnyd
         W5yJdSsR7rl3kvd1+Ie+5wYjwyRga0aqewLm3mwHTvMiPAhl5a65JVWwMLsDcwr+QWzC
         zOctQKdh2MpvxG7Xguy98mGMFn5i6ysFXSedE4qqIRjYlPoYdTf7+Y/umWzWYjDZEiSu
         pe4q9xO3DGmOQYKcND88mBQh9DvZH/Jua/EmqRup2alwjGAzKBUF7wdqfhoFkNzXFp0a
         RlwVRoQ+ZlnWDsscwavJGy+e7tJLWKchk0cGhbJ/Kh9++Eavso8XjZmLYqBntoc64F2j
         Atag==
X-Forwarded-Encrypted: i=1; AJvYcCWTcDAc0er9u4g0rCYUSNSw2rGpBORczdomFb0N6u4xZd4fG7cevM97JYvWn6t7BC7Gf3DlSaDMP4W82xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDLWMYHS+luCDfW/7U9xknly+PuBIFKcE/+Og2cBFOdnOpu95
	Xm8wQBN5XECDzafFb0Xe60J1UxBve+lHjPEqnsfi7q1CKSHsVXW/vyxkPJkUQvk=
X-Gm-Gg: ASbGncsw5Ot0rSFypH/BgEWsj+05VWWSOTUUtdX8Lvz7Izge6TZWwLyRlasQDlvvhFA
	THuHF9aqbSqkIYroof56w8599VEsKWKyTAfc/b/BcZlT6CQnGwVlbqVEdR9MdvN8M9I+Ae7wtA4
	b1VBAz+mr9ggbUTHaDPEJz1dP2et1vg3Ei52mXCFyTqpzkVBu448EcqDj7qlk9BE5UiWvwfX8Kh
	F4rn7bDl8IQ9tE2n7F2PIg5F8wpQBnzxNCdupUK9oLzNo4Ob0IFpXbushClqzjp0ih8fePVd1uo
	OV6u
X-Google-Smtp-Source: AGHT+IGsb8jAJwQfrchSyQVub/QChbDat/piTHBCeQTUzKWcFrBkZVk9OvkJAzj2S0oI/D2iLocc0A==
X-Received: by 2002:a5d:6d08:0:b0:385:f280:d55 with SMTP id ffacd0b85a97d-385fd418db2mr1791150f8f.37.1733224411561;
        Tue, 03 Dec 2024 03:13:31 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:31 -0800 (PST)
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
Subject: [PATCH 01/14] clk: renesas: r9a08g045: Add clocks, resets and power domain support for the ADC IP
Date: Tue,  3 Dec 2024 13:13:01 +0200
Message-Id: <20241203111314.2420473-2-claudiu.beznea.uj@bp.renesas.com>
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

Add clocks, resets and power domains for ADC IP available on the Renesas
RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index b2ae8cdc4723..a124e3339d84 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -187,6 +187,7 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 	DEF_FIXED("OSC", R9A08G045_OSCCLK, CLK_EXTAL, 1, 1),
 	DEF_FIXED("OSC2", R9A08G045_OSCCLK2, CLK_EXTAL, 1, 3),
 	DEF_FIXED("HP", R9A08G045_CLK_HP, CLK_PLL6, 1, 2),
+	DEF_FIXED("TSU", R9A08G045_CLK_TSU, CLK_PLL2_DIV2, 1, 8),
 };
 
 static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
@@ -225,6 +226,8 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("i2c3_pclk",		R9A08G045_I2C3_PCLK, R9A08G045_CLK_P0, 0x580, 3),
 	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
+	DEF_MOD("adc_adclk",		R9A08G045_ADC_ADCLK, R9A08G045_CLK_TSU, 0x5a8, 0),
+	DEF_MOD("adc_pclk",		R9A08G045_ADC_PCLK, R9A08G045_CLK_TSU, 0x5a8, 1),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
 
@@ -252,6 +255,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
+	DEF_RST(R9A08G045_ADC_PRESETN, 0x8a8, 0),
+	DEF_RST(R9A08G045_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
 
@@ -306,6 +311,8 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(13)), 0),
 	DEF_PD("scif0",		R9A08G045_PD_SCIF0,
 				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(1)), 0),
+	DEF_PD("adc",		R9A08G045_PD_ADC,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(14)), 0),
 	DEF_PD("vbat",		R9A08G045_PD_VBAT,
 				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(8)),
 				GENPD_FLAG_ALWAYS_ON),
-- 
2.39.2


