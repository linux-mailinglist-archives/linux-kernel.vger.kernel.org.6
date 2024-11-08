Return-Path: <linux-kernel+bounces-401514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 620E09C1B9E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9417A1C267F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85FE1E6DC0;
	Fri,  8 Nov 2024 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="b5QF2SRW"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9591F81B0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063077; cv=none; b=WdDRMmG8tTyOmUMExitH/yDiqYPfPyBImWR4wwp/81JqZRJdB/xsiDamE6gzLxkN1Oz0iesRhfjjhMcHM/Q52ogkaV3MjiPkRSw3ucL8rtVaxA0FbY+d35+uI7US17wTgiy82el/2j/c0GJGdkV5k3lLuOg+GRO1OebO5LLbL0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063077; c=relaxed/simple;
	bh=hqyu/9qwuqDDVwdAINLf2spd90W5bEVXoMMCjRUAF+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HxR5DfcYCam8LkXxyqMFw0Bxe0kCYZcqvDkwK3rfD2e3eYupjFHrr3TOeeNSiNjJZNF7e2Mv3mlb4a0mcLSPjP0gf/zt/t21FvRo1GignH50ofnlEsjHcxsGok94p5UdknO1WzyyK30dtG8V15Q2GsmaoIAXHkyul5LWa5cqvac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=b5QF2SRW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so2653472a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 02:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731063074; x=1731667874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nhv+LUNkX03bFAIIjXJ8kSHL67xt82fodrUWsAE+DN4=;
        b=b5QF2SRW7dwruDQtoYYbgvRLhlZiw7pV4vDoXRUGgw1IHJWGbkIsX+UQeGYAdgUFht
         9V6S6AcQrO70wNgEL7f3CbRarYy6HlP8CQFp3Pd7Hz8AA6wgL79cTXGUFskdsqYuVY/W
         ROOxS5BfJi7m6teqBcS/Vn7m/xIuyO4LYoMsuIjn4OxLWCLY8ynfAyZdJD/24GZfCYVN
         x4wN55SiatmMDcbrmK/C7wm1+crMfWH4r3H4jbjCBzTRQtfAnCau0sZo9L3K4xPdQbCQ
         Z6zTKOTTy3e8KpJqYcvaIk16fW+jMIgK1gNbmh9sCMxUFLAfAPkWRXd7heVzzZBEzmW9
         Czfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731063074; x=1731667874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nhv+LUNkX03bFAIIjXJ8kSHL67xt82fodrUWsAE+DN4=;
        b=ZwAy+xvS0NLub7kdoYoyYRO/r2N1FbJmzcGbu9n3ER+Kq05gS4tO+bxYA1MKxTAoYL
         cNZyINnq7P4Q9MKJd+6WxfaYwW2OGZ9Eo5zgSXqnZOA2y9Uqlfj8s1WoGcX64Jn4ASCj
         COE8DcUezpkuqS1EGBN8/K7ApSXsnWkaeDAvOqFWrYCmyfaixjlgGiyoemaW28wE+8kR
         gx33J+AkZgQojx+cM1ww5Ui2ysRbs1k0uIccHLTZhoG+odjvx8GQZXZA/BVKgiwcougq
         wvbTyZKlfitjxy5car3TDRcf/hI0VXx4rSwplcICCFrTdLLN4hHKkUUTpHIHx/zZT0oI
         hgIA==
X-Forwarded-Encrypted: i=1; AJvYcCX3VvyCay1Jni322pXGze3oQMKVhHpJztFvWmqXkU9FAOp7BI+Iw/LJqXWCB68bfa40qHx1xijOeNB1Xxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaVBgOZNMlFTaY8AE9i1qYGO8vTxMtd4WTSxkcqGdg88Gujh6Q
	uNjxOne+lC9T6JfwYqn/MsG618SnqSVHU9LWL8c0IXFtBL0OvTi2rKXXxg83ddc=
X-Google-Smtp-Source: AGHT+IHUKLF63fTQjZZXGL9+QOGbq1MfnR4SJIk9s5yAvSCxzRCwnV4uEpnoB/HG2rOronjoba1QRA==
X-Received: by 2002:a17:907:608b:b0:a9a:6847:e82c with SMTP id a640c23a62f3a-a9eefeecd1emr186776366b.15.1731063073712;
        Fri, 08 Nov 2024 02:51:13 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc574dsm220464866b.101.2024.11.08.02.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:51:13 -0800 (PST)
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
Subject: [PATCH v2 24/25] arm64: dts: renesas: rzg3s-smarc: Enable SSI3
Date: Fri,  8 Nov 2024 12:49:57 +0200
Message-Id: <20241108104958.2931943-25-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241108104958.2931943-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241108104958.2931943-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable SSI3.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 4aa99814b808..6dd439e68bd4 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -64,6 +64,11 @@ vccq_sdhi1: regulator-vccq-sdhi1 {
 	};
 };
 
+&audio_clk2 {
+	clock-frequency = <12288000>;
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -94,6 +99,11 @@ da7212: codec@1a {
 };
 
 &pinctrl {
+	audio_clock_pins: audio-clock {
+		pins = "AUDIO_CLK1", "AUDIO_CLK2";
+		input-enable;
+	};
+
 	key-1-gpio-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(18, 0) GPIO_ACTIVE_LOW>;
@@ -151,6 +161,13 @@ cd {
 			pinmux = <RZG2L_PORT_PINMUX(0, 2, 1)>; /* SD1_CD */
 		};
 	};
+
+	ssi3_pins: ssi3 {
+		pinmux = <RZG2L_PORT_PINMUX(18, 2, 8)>, /* BCK */
+			 <RZG2L_PORT_PINMUX(18, 3, 8)>, /* RCK */
+			 <RZG2L_PORT_PINMUX(18, 4, 8)>, /* TXD */
+			 <RZG2L_PORT_PINMUX(18, 5, 8)>; /* RXD */
+	};
 };
 
 &scif0 {
@@ -171,3 +188,12 @@ &sdhi1 {
 	max-frequency = <125000000>;
 	status = "okay";
 };
+
+&ssi3 {
+	clocks = <&cpg CPG_MOD R9A08G045_SSI3_PCLK2>,
+		 <&cpg CPG_MOD R9A08G045_SSI3_PCLK_SFR>,
+		 <&versa3 2>, <&audio_clk2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&ssi3_pins>, <&audio_clock_pins>;
+	status = "okay";
+};
-- 
2.39.2


