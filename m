Return-Path: <linux-kernel+bounces-407688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD929C7117
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72C11F28E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5E32139B1;
	Wed, 13 Nov 2024 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lCs3eT2U"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE43212D16
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504992; cv=none; b=Yu4D1aHlzgbgvCNHMf9XNe9nSLJY0WjWTm2hfn3g4LjLGpsIaXSbXUGK/tGAWR4KloES06H//iMPE8EIRbrgaaVT32pHQ4dZCJkdde2fPqRaD5yNUOTiVtccJlyt0/vejXSgcUR6GVrp9D50AO1BMqBGafewHJjAfgIN45nFR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504992; c=relaxed/simple;
	bh=Lz3aoSUo6+0PF0wZUJ8U3vu3GObZqmPF9iuKY2yZJgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBUObl/greSCfStb7Hfb+xVMZL/ESHZ6DUBJioob9IkHP05y631K/FX1TjE7iSV3wrbajGMCfeLIBbA2qaT+me/lbgFlLTStVD2wAIteEgeZQethORH0d9vleHejOr9jkEat0kAE2O9vpfFBR65RvLRTiCoBBtHY8gE+weeSxag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=lCs3eT2U; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso60214595e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731504989; x=1732109789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgXhv7pRczmNcx6HSYZsMHDnL3arPRRw+a6h6xJlA4k=;
        b=lCs3eT2UotIOr8yDeStXAzNnTfF2RhaD3YTnVmuj6T4Y6FMuDA32qf29UgB3APCg29
         necxDDe+9z420tijid7R8RI1w88Kx6tyyYpOX6LAtEbZQcpF8KAbxARRHgpXeWIon4b6
         nYZYC24+gfSKg0UEFkkHa60gMuD7ojjUFpwjJNZ6SA+7r0MirDUhmQTRXM+sKTcO9RJK
         livJPcd6KcastXZ68Xxpcdchs/j6q2TrF3izjPZ30SIzQ9kOstr2iabT36l/VkstCvMR
         /BjMsDzPci3kjoSYgtqiJs0rpBalvKL0ugliwbl0mnbGN51GRl/F4N8yhuuD72snHS+A
         ezbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731504989; x=1732109789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgXhv7pRczmNcx6HSYZsMHDnL3arPRRw+a6h6xJlA4k=;
        b=j4wSljUQTDb21/acBmrXfL7gn0a3SGq2/ZliBziwOD3I8NVkDcj49+hx3yIoAXMQfG
         cCCm7t+7bo3TixeSU0z3FJYuIwivi1LgjxlCMS0sHjiel6CVr5zf5ebMhUJc5QI9aQAY
         gy9Bz2mT19xC003tUerN3A01B8+J7Tl4VtMhs2H6qPLh+5uhN2JXrDTjhjFemzApZi1d
         J6iBAKddwe8QAZsczItnBKkD4zq3KMzHetDJRfd0HyO+RWTuG2mFCaqY99j8hnyY03wY
         4uppb+3Zu1o/JlzOcInl5ZOy29tpX4tWbL3joxn/LYK2xTHjC8O1JIsTGsKvMtzBuASg
         jF7A==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8OrBvTMFW8IjLahGgPGqUrg0hu9OIsFZF1A+/GphnANGYx1wyyto3hhUXxVtm4HcoIWzEy58c94gTIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJB5Ov61r0HZI0aEjDiuBb8iKzwDkkPkuax4Q4oNJRyAXX8U4m
	FofbiIHgPKf568B88fn3ClIvWY1OKZ00zwV+UyQ8wq64PCnfGT4mEUnMF9TIWf4=
X-Google-Smtp-Source: AGHT+IHn5cPSQcUztin4zy9dKdNFqeNDZ7RPNRJWoUAxSAY0cZ1T6lh8oLNCtmmCdp1ollguf9sC0g==
X-Received: by 2002:a05:600c:3c8b:b0:428:f0c2:ef4a with SMTP id 5b1f17b1804b1-432b75002a7mr173945815e9.13.1731504989219;
        Wed, 13 Nov 2024 05:36:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e2f2esm25664165e9.1.2024.11.13.05.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 05:36:28 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	linus.walleij@linaro.org,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 22/25] arm64: dts: renesas: rzg3s-smarc-som: Add versa3 clock generator node
Date: Wed, 13 Nov 2024 15:35:37 +0200
Message-Id: <20241113133540.2005850-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241113133540.2005850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241113133540.2005850-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add versa3 clock generator node. It provides the clocks for the Ethernet
PHY, PCIe, audio devices.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- none

 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 2ed01d391554..6e58d47d85b0 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -92,6 +92,12 @@ vcc_sdhi2: regulator2 {
 		gpios = <&pinctrl RZG2L_GPIO(8, 1) GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	x3_clk: x3-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
 };
 
 #if SW_CONFIG3 == SW_ON
@@ -152,6 +158,30 @@ &extal_clk {
 
 &i2c1 {
 	status = "okay";
+
+	versa3: clock-generator@68 {
+		compatible = "renesas,5l35023";
+		reg = <0x68>;
+		clocks = <&x3_clk>;
+		#clock-cells = <1>;
+		assigned-clocks = <&versa3 0>,
+				  <&versa3 1>,
+				  <&versa3 2>,
+				  <&versa3 3>,
+				  <&versa3 4>,
+				  <&versa3 5>;
+		assigned-clock-rates = <24000000>,
+				       <12288000>,
+				       <11289600>,
+				       <25000000>,
+				       <100000000>,
+				       <100000000>;
+		renesas,settings = [
+		  80 00 11 19 4c 42 dc 2f 06 7d 20 1a 5f 1e f2 27
+		  00 40 00 00 00 00 00 00 06 0c 19 02 3f f0 90 86
+		  a0 80 30 30 9c
+		];
+	};
 };
 
 #if SW_CONFIG2 == SW_ON
-- 
2.39.2


