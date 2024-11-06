Return-Path: <linux-kernel+bounces-398158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92669BE68A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7981F25AEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49D31DFD82;
	Wed,  6 Nov 2024 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="m/DgjVZM"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525471DF25B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894495; cv=none; b=Ofyrod/4HTLyjnFDU+qhG8GGz9zLaLVP0cn45IkG1XGfBTkwJZWJygORCym6UdgMF3hjHetX97Bw0K55szLNMBb1s4uJWH5w7/QXIGcdKxo4fS2e2rMicOK/+iBb/wzM44Oo3Zx53bbTzXR9MrupLfo7NnViVVm3Vtl4KboRrYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894495; c=relaxed/simple;
	bh=P7CWogJPQM21WpJfz6OSvLoBx226S9Pt+GMqlMdNMGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLzd8srJJR3EabZ34S/EIwoBmaXH0wjGmeNJZsZq4Emx/N5N3iZO/szHsye8+JpL69VULl9FmdhuKz02v8BwZGCUuhvgy75nZZQKXEGCm3o/AyjlWTYbWtXx6pLQkLYOUITrv0GiuxoDcep521cF+3RleF2g4BeuDsYxOLhysgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=m/DgjVZM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so7863962a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 04:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730894491; x=1731499291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8lYtdAk2t8Mv7NgBsg6Mi4wEfebdPcoNLcs7zuky2E=;
        b=m/DgjVZMpPsRsqrFWGY+ZV/BZ0YpLj4tlPKAOEibdVs7/vfFZJagOi4MgMMq3Tqt66
         0AaZgR7+PPUgkvLZNmEhO2+PjpNfRuXinYa5+utcZojnGH6P2AD8L8z/YY12g82buYBd
         FdP/DKTNM2y8fLmcn0XSku9pc77eDd6zEXq/dMchbsLW17g0u29IHx6iGYQANPIeuRiz
         anxQdZcKQN69mRQK3TgdeUDMPsQJia18IJuKNUAmBXeSePyV8zpaFGWn6Hz+hks9/Vnd
         CkDjSvevtUHvbhlIVgnw4MrK8uaKs+YUkwz0pgI8TIOpiQ6XGCXA2SHAZ6tb2g+4MBfV
         WY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894491; x=1731499291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8lYtdAk2t8Mv7NgBsg6Mi4wEfebdPcoNLcs7zuky2E=;
        b=Jm24cnah7H7wNFkjaD/EzEsX97kmvSOEhKZiIrf5l4F/jHVbVuS0tfzCL3QY9I+W24
         cR0sCkAJoaD2GHO6w0qQ0p8h2uLkN9n9cRHgePwq+DMYEOmtfvEhJrnxWeSx2O4FGKqp
         CAJ0VEmXtj4hXRfbmdORHJXnm9c0jecPBeVpcIpwQnRAdkjwgZfQradOyoJsdyElav3y
         95PazJXeUnXNBi2/yQlK117rPxCpQhMvDasEHLnHRh2o0bQaGvQ3/ah1Gs/Ondst2sDJ
         JMrb/sKaw8qLL5YCgGm7rq6kTXWMDnAXP8FQxZP2qkzG/4Ko+0OOPtyo0v4lg+Q1vz0J
         FRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkEsTBGuQHEROUJFqA5knH7UmjdA0pce+j2x30gliIeekNqechgqEr1Jah1jQNDYtPNospMf4ga+mnkLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrIonZecXsrZygzTcjJ9dYV3nAqLwZG88bJ2dgIPRaLH+p6xlL
	IJrDc5edaeCLLPM1pVyEAd7fRXmVxmlOqrT35BstRP+iLKn1nuB5ItximthvN+U=
X-Google-Smtp-Source: AGHT+IEHbGP3jKASCYX6JDjA5zSC1bzPmDrPZcnhe6m+Bty+EVe70SHHz9Sm24XqJjT7qbeicqGf9g==
X-Received: by 2002:aa7:c6c7:0:b0:5c9:7d96:772d with SMTP id 4fb4d7f45d1cf-5ceb9343ac0mr13125638a12.22.1730894491013;
        Wed, 06 Nov 2024 04:01:31 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe528sm2697984a12.55.2024.11.06.04.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:01:30 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	ysato@users.sourceforge.jp,
	ulrich.hecht+renesas@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/9] clk: renesas: r9a08g045: Add clock, reset and power domain for the remaining SCIFs
Date: Wed,  6 Nov 2024 14:01:10 +0200
Message-Id: <20241106120118.1719888-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC has 6 SCIF interfaces. SCIF0 is used as debug
console and is already enabled. Add the clock, reset and power domain
support for the remaining ones.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index b2ae8cdc4723..da6dfffa089a 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -224,6 +224,11 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("i2c2_pclk",		R9A08G045_I2C2_PCLK, R9A08G045_CLK_P0, 0x580, 2),
 	DEF_MOD("i2c3_pclk",		R9A08G045_I2C3_PCLK, R9A08G045_CLK_P0, 0x580, 3),
 	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
+	DEF_MOD("scif1_clk_pck",	R9A08G045_SCIF1_CLK_PCK, R9A08G045_CLK_P0, 0x584, 1),
+	DEF_MOD("scif2_clk_pck",	R9A08G045_SCIF2_CLK_PCK, R9A08G045_CLK_P0, 0x584, 2),
+	DEF_MOD("scif3_clk_pck",	R9A08G045_SCIF3_CLK_PCK, R9A08G045_CLK_P0, 0x584, 3),
+	DEF_MOD("scif4_clk_pck",	R9A08G045_SCIF4_CLK_PCK, R9A08G045_CLK_P0, 0x584, 4),
+	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x584, 5),
 	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0),
 };
@@ -249,6 +254,11 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_I2C2_MRST, 0x880, 2),
 	DEF_RST(R9A08G045_I2C3_MRST, 0x880, 3),
 	DEF_RST(R9A08G045_SCIF0_RST_SYSTEM_N, 0x884, 0),
+	DEF_RST(R9A08G045_SCIF1_RST_SYSTEM_N, 0x884, 1),
+	DEF_RST(R9A08G045_SCIF2_RST_SYSTEM_N, 0x884, 2),
+	DEF_RST(R9A08G045_SCIF3_RST_SYSTEM_N, 0x884, 3),
+	DEF_RST(R9A08G045_SCIF4_RST_SYSTEM_N, 0x884, 4),
+	DEF_RST(R9A08G045_SCIF5_RST_SYSTEM_N, 0x884, 5),
 	DEF_RST(R9A08G045_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A08G045_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A08G045_GPIO_SPARE_RESETN, 0x898, 2),
@@ -306,6 +316,16 @@ static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
 				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(13)), 0),
 	DEF_PD("scif0",		R9A08G045_PD_SCIF0,
 				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(1)), 0),
+	DEF_PD("scif1",		R9A08G045_PD_SCIF1,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(2)), 0),
+	DEF_PD("scif2",		R9A08G045_PD_SCIF2,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(3)), 0),
+	DEF_PD("scif3",		R9A08G045_PD_SCIF3,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(4)), 0),
+	DEF_PD("scif4",		R9A08G045_PD_SCIF4,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(5)), 0),
+	DEF_PD("scif5",		R9A08G045_PD_SCIF5,
+				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(4)), 0),
 	DEF_PD("vbat",		R9A08G045_PD_VBAT,
 				DEF_REG_CONF(CPG_BUS_MCPU3_MSTOP, BIT(8)),
 				GENPD_FLAG_ALWAYS_ON),
-- 
2.39.2


