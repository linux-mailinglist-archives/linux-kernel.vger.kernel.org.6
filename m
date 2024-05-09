Return-Path: <linux-kernel+bounces-174422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6828C0E7D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9281C2191B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEA514BFA2;
	Thu,  9 May 2024 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrTvi7Wv"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89078131188
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251727; cv=none; b=m8tFqwVknFu8qFR2L88l2/G8XVmeAuiGcesOkKJ9ArWtob8iIKsqciS4ols/ofiogg1N1C48m+QzPf/ZZ+phB3po6b2n8YpPEAvbnBQQoWUk1xSCiH9XOi7bhE+Re1MZzoV1vEahIJ58LQ+wO0MaTFG3fSBENgRNf70lF1qdV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251727; c=relaxed/simple;
	bh=7ce71H0+iO+dpFN+K0elPR2oWkQjuMhFm58muY13Wy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrZOqA0SJUC7UvtWrTolfZTIEB+EWffUNXQB1tLQbH4axMX0vJ7WYOlrjNT+reUBonteENUpQLFPvvYMHHJ9QmNIRgo0Aw/+YfTo1zfd5bdiYd76WBz+TwBQj7srQrxmUZcTUAy3cBWCimluxEdNedLa1br5X90sFk6nEYaf4z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MrTvi7Wv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a157a1cd1so166282666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 03:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715251723; x=1715856523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYlidyl89G5PiBxk0XMF7OIxIFGwq175e8Cd1RD8Edg=;
        b=MrTvi7Wv8Q/X1sFrtt4slAeNg3ag7tQziTNSwzcKsDPBi2fR7MVIp2HOJhWAZ5G9aR
         Ukry0fRHOGs3KZFvgCgB5yVRPyyr/Ct7s6esqTlsQh4JGOwhs5s1EfVpNFCPl9RCy0lX
         n15K4coi4oQElzC3TT0ZEb7yHQekqiZ/bgeDKX/EoRno2sp8PH36UHnwrvOgaFdOkofe
         0N0YVpK7hfQh3IOTCt9LRC3iffyWS6dFlnHo9AoCP4MR11/nDG6JQteKG4datkniYaEA
         /1x1R3eTGe46hPidkSQHEeGQhZlRPUff65/hOQInNnNYOmJKqiiD5XjwsKDX3n76PTkK
         pang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251723; x=1715856523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYlidyl89G5PiBxk0XMF7OIxIFGwq175e8Cd1RD8Edg=;
        b=Wqxx1SPi2X1U0IOdbPZ+jeKb3k+k5NeSmr0MycRq1bgJaEdPgbpAtyOWQhdFnCQ6+j
         lfp1M0X4L6Q8SC7QBOynJ/fcBJRuik5nph93tiZi2g70DzPiJ5YxfUy6yMeOVNyI+rbU
         I/zBlPD8hocoddYPaIc85ZqsHLreXLjhDT5c5Ecq+CF66wbndeamxkDly2P4ZsYErNE8
         McZDStl3FxrMqFCaP6UR9cnJ1CFe7ELOWA+x6v2EZ2UT3HdHnsl0mrSHI+aM8rlTbWyz
         8kIsvaXhwjUxoUzYk/3bc3BUMoW+gL+GeX54IY6SV7U8Mj2sKGdrBx/jTc8nFSmRGBug
         fdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc+I/gY3d9fuq0uhPKt98bX1s3sjhI40n704GzIKdg57Cxpr5nGctAkiScQoDT5T/q3837YmzjSuQPIFUvFxjR//MOoZvb9wwsAbWz
X-Gm-Message-State: AOJu0Yxp0r3vDEVbtNgL6XMeK2qhvyLp66fk5YKgh4X72nf7rilJ87uA
	Wmu0JvFQJLrm14p1dbVJaqZVZbiNqZnefq2zlbmS8OyEBtejpuawR2WMMi99ZNw=
X-Google-Smtp-Source: AGHT+IH1CmRJSg3xhi+VUJ3TVNOjm9s+MndboSe1LvFSho3NF1BCuqzFPPDeEK7mG1aMmNDFxXz38g==
X-Received: by 2002:a17:906:c404:b0:a59:a282:5db7 with SMTP id a640c23a62f3a-a59fb9d0889mr284564266b.65.1715251722913;
        Thu, 09 May 2024 03:48:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894d85sm60195966b.72.2024.05.09.03.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:48:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] ARM: dts: imx: align panel timings node name with dtschema
Date: Thu,  9 May 2024 12:48:34 +0200
Message-ID: <20240509104838.216773-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DT schema expects panel timings node to follow certain pattern,
dtbs_check warnings:

  imx6dl-gw54xx.dtb: display-timings: 'hsd100pxn1' does not match any of the regexes: '^timing', 'pinctrl-[0-9]+'

Linux drivers do not care about node name, so this should not have
effect on Linux.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx51-apf51dev.dts     |  2 +-
 arch/arm/boot/dts/nxp/imx/imx51-babbage.dts      |  2 +-
 arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts       |  2 +-
 arch/arm/boot/dts/nxp/imx/imx53-m53evk.dts       |  2 +-
 arch/arm/boot/dts/nxp/imx/imx53-tx53-x03x.dts    | 14 +++++++-------
 arch/arm/boot/dts/nxp/imx/imx53-tx53-x13x.dts    |  6 +++---
 .../boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts  |  2 +-
 .../boot/dts/nxp/imx/imx6dl-aristainetos_4.dts   |  2 +-
 .../boot/dts/nxp/imx/imx6dl-aristainetos_7.dts   |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi   | 16 ++++++++--------
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi  | 16 ++++++++--------
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi      | 14 +++++++-------
 19 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx51-apf51dev.dts b/arch/arm/boot/dts/nxp/imx/imx51-apf51dev.dts
index b61d55ca1467..f72e109342bc 100644
--- a/arch/arm/boot/dts/nxp/imx/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx51-apf51dev.dts
@@ -25,7 +25,7 @@ disp1 {
 		pinctrl-0 = <&pinctrl_ipu_disp1>;
 
 		display-timings {
-			lw700 {
+			timing0: timing-lw700 {
 				native-mode;
 				clock-frequency = <33000033>;
 				hactive = <800>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx51-babbage.dts b/arch/arm/boot/dts/nxp/imx/imx51-babbage.dts
index 16ff543f3fbf..f4a47e8348b2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx51-babbage.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx51-babbage.dts
@@ -89,7 +89,7 @@ display2: disp2 {
 		status = "disabled";
 		display-timings {
 			native-mode = <&timing1>;
-			timing1: claawvga {
+			timing1: timing-claawvga {
 				clock-frequency = <27000000>;
 				hactive = <800>;
 				vactive = <480>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts b/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts
index 2bd0761c7e90..87a34cbdf233 100644
--- a/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx51-ts4800.dts
@@ -58,7 +58,7 @@ display1: disp1 {
 		pinctrl-0 = <&pinctrl_lcd>;
 
 		display-timings {
-			800x480p60 {
+			timing0: timing-800x480p60 {
 				native-mode;
 				clock-frequency = <30066000>;
 				hactive = <800>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx53-m53evk.dts b/arch/arm/boot/dts/nxp/imx/imx53-m53evk.dts
index 1353d985969c..f0f92ee7ba95 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx53-m53evk.dts
@@ -17,7 +17,7 @@ display1: disp1 {
 		pinctrl-0 = <&pinctrl_ipu_disp1>;
 
 		display-timings {
-			800x480p60 {
+			timing0: timing-800x480p60 {
 				native-mode;
 				clock-frequency = <31500000>;
 				hactive = <800>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx53-tx53-x03x.dts b/arch/arm/boot/dts/nxp/imx/imx53-tx53-x03x.dts
index a7f77527269d..a02d77bb5672 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx53-tx53-x03x.dts
@@ -67,7 +67,7 @@ display0_in: endpoint {
 		};
 
 		display-timings {
-			VGA {
+			timing-vga {
 				clock-frequency = <25200000>;
 				hactive = <640>;
 				vactive = <480>;
@@ -83,7 +83,7 @@ VGA {
 				pixelclk-active = <0>;
 			};
 
-			ETV570 {
+			timing-etc570 {
 				clock-frequency = <25200000>;
 				hactive = <640>;
 				vactive = <480>;
@@ -99,7 +99,7 @@ ETV570 {
 				pixelclk-active = <0>;
 			};
 
-			ET0350 {
+			timing-et0350 {
 				clock-frequency = <6413760>;
 				hactive = <320>;
 				vactive = <240>;
@@ -115,7 +115,7 @@ ET0350 {
 				pixelclk-active = <0>;
 			};
 
-			ET0430 {
+			timing-et0430 {
 				clock-frequency = <9009000>;
 				hactive = <480>;
 				vactive = <272>;
@@ -131,7 +131,7 @@ ET0430 {
 				pixelclk-active = <1>;
 			};
 
-			ET0500 {
+			timing-et0500 {
 				clock-frequency = <33264000>;
 				hactive = <800>;
 				vactive = <480>;
@@ -147,7 +147,7 @@ ET0500 {
 				pixelclk-active = <0>;
 			};
 
-			ET0700 { /* same as ET0500 */
+			timing-et0700 { /* same as ET0500 */
 				clock-frequency = <33264000>;
 				hactive = <800>;
 				vactive = <480>;
@@ -163,7 +163,7 @@ ET0700 { /* same as ET0500 */
 				pixelclk-active = <0>;
 			};
 
-			ETQ570 {
+			timing-etq570 {
 				clock-frequency = <6596040>;
 				hactive = <320>;
 				vactive = <240>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx53-tx53-x13x.dts b/arch/arm/boot/dts/nxp/imx/imx53-tx53-x13x.dts
index 6cdf2082c742..e10c179dbdb3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx53-tx53-x13x.dts
@@ -191,7 +191,7 @@ lvds0: lvds-channel@0 {
 		display-timings {
 			native-mode = <&lvds0_timing0>;
 
-			lvds0_timing0: hsd100pxn1 {
+			lvds0_timing0: timing-hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
@@ -207,7 +207,7 @@ lvds0_timing0: hsd100pxn1 {
 				pixelclk-active = <1>;
 			};
 
-			lvds0_timing1: nl12880bc20 {
+			lvds0_timing1: timing-nl12880bc20 {
 				clock-frequency = <71000000>;
 				hactive = <1280>;
 				vactive = <800>;
@@ -233,7 +233,7 @@ lvds1: lvds-channel@1 {
 		display-timings {
 			native-mode = <&lvds1_timing0>;
 
-			lvds1_timing0: hsd100pxn1 {
+			lvds1_timing0: timing-hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts
index dfa6f64d43cc..c75606fc4abd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts
@@ -85,7 +85,7 @@ lcd_panel: display@0 {
 		power-on-delay = <10>;
 
 		display-timings {
-			480x800p57 {
+			timing0: timing-480x800p57 {
 				native-mode;
 				clock-frequency = <27000027>;
 				hactive = <480>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dts
index a5ac79346854..0d86927819c2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dts
@@ -36,7 +36,7 @@ display0: disp0 {
 		status = "okay";
 
 		display-timings {
-			480x800p60 {
+			timing0: timing-480x800p60 {
 				native-mode;
 				clock-frequency = <30000000>;
 				hactive = <480>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dts
index 5a25bdbbeb68..66271daf97d9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dts
@@ -25,7 +25,7 @@ display0: disp0 {
 		status = "okay";
 
 		display-timings {
-			800x480p60 {
+			timing0: timing-800x480p60 {
 				native-mode;
 				clock-frequency = <33246000>;
 				hactive = <800>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
index 48ffb3ee01bd..082a2e3a391f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw52xx.dtsi
@@ -485,7 +485,7 @@ lvds-channel@0 {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: hsd100pxn1 {
+			timing0: timing-hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
index 1eae438fbdae..8ec442038ea0 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw53xx.dtsi
@@ -482,7 +482,7 @@ lvds-channel@0 {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: hsd100pxn1 {
+			timing0: timing-hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
index c2ec8572c8a5..9df9f79affae 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw54xx.dtsi
@@ -529,7 +529,7 @@ lvds-channel@0 {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: hsd100pxn1 {
+			timing0: timing-hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
index 7cee983da669..7693f92195d5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
@@ -584,7 +584,7 @@ lvds-channel@0 {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: hsd100pxn1 {
+			timing0: timing-hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
index fbc704c064b6..9d0836df0fed 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
@@ -486,7 +486,7 @@ lvds-channel@0 {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: g101evn010 {
+			timing0: timing-g101evn010 {
 				clock-frequency = <68930000>;
 				hactive = <1280>;
 				vactive = <800>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
index 070506279186..f4cb9e1d34a9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
@@ -551,7 +551,7 @@ lvds-channel@0 {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: hsd100pxn1 {
+			timing0: timing-hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
index 6656e2e762a1..0a3deaf92eea 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabreauto.dtsi
@@ -786,7 +786,7 @@ lvds-channel@0 {
 
 		display-timings {
 			native-mode = <&timing0>;
-			timing0: hsd100pxn1 {
+			timing0: timing-hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi
index 79f2354886b7..7ae495bdc48f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lcd.dtsi
@@ -110,7 +110,7 @@ lcd_out: endpoint {
 		};
 
 		display-timings {
-			VGA {
+			timing-vga {
 				clock-frequency = <25200000>;
 				hactive = <640>;
 				vactive = <480>;
@@ -126,7 +126,7 @@ VGA {
 				pixelclk-active = <0>;
 			};
 
-			ETV570 {
+			timing-etv570 {
 				u-boot,panel-name = "edt,et057090dhu";
 				clock-frequency = <25200000>;
 				hactive = <640>;
@@ -143,7 +143,7 @@ ETV570 {
 				pixelclk-active = <0>;
 			};
 
-			ET0350 {
+			timing-et0350 {
 				u-boot,panel-name = "edt,et0350g0dh6";
 				clock-frequency = <6413760>;
 				hactive = <320>;
@@ -160,7 +160,7 @@ ET0350 {
 				pixelclk-active = <0>;
 			};
 
-			ET0430 {
+			timing-et0430 {
 				u-boot,panel-name = "edt,et0430g0dh6";
 				clock-frequency = <9009000>;
 				hactive = <480>;
@@ -177,7 +177,7 @@ ET0430 {
 				pixelclk-active = <1>;
 			};
 
-			ET0500 {
+			timing-et0500 {
 				clock-frequency = <33264000>;
 				hactive = <800>;
 				vactive = <480>;
@@ -193,7 +193,7 @@ ET0500 {
 				pixelclk-active = <0>;
 			};
 
-			ET0700 { /* same as ET0500 */
+			timing-et0700 { /* same as ET0500 */
 				u-boot,panel-name = "edt,etm0700g0dh6";
 				clock-frequency = <33264000>;
 				hactive = <800>;
@@ -210,7 +210,7 @@ ET0700 { /* same as ET0500 */
 				pixelclk-active = <0>;
 			};
 
-			ETQ570 {
+			timing-etq570 {
 				clock-frequency = <6596040>;
 				hactive = <320>;
 				vactive = <240>;
@@ -226,7 +226,7 @@ ETQ570 {
 				pixelclk-active = <0>;
 			};
 
-			CoMTFT { /* same as ET0700 but with inverted pixel clock */
+			timing-comtft { /* same as ET0700 but with inverted pixel clock */
 				u-boot,panel-name = "edt,etm0700g0edh6";
 				clock-frequency = <33264000>;
 				hactive = <800>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi
index 2ca2eb37e14f..dfbdbb87aec4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-lvds.dtsi
@@ -127,7 +127,7 @@ lvds0_out: endpoint {
 		};
 
 		display-timings {
-			hsd100pxn1 {
+			timing-hsd100pxn1 {
 				u-boot,panel-name = "hannstar,hsd100pxn1";
 				clock-frequency = <65000000>;
 				hactive = <1024>;
@@ -142,7 +142,7 @@ hsd100pxn1 {
 				pixelclk-active = <1>;
 			};
 
-			VGA {
+			timing-vga {
 				clock-frequency = <25200000>;
 				hactive = <640>;
 				vactive = <480>;
@@ -158,7 +158,7 @@ VGA {
 				pixelclk-active = <0>;
 			};
 
-			nl12880bc20 {
+			timing-nl12880bc20 {
 				u-boot,panel-name = "nlt,nl12880bc20-spwg-24";
 				clock-frequency = <71000000>;
 				hactive = <1280>;
@@ -175,7 +175,7 @@ nl12880bc20 {
 				pixelclk-active = <1>;
 			};
 
-			ET0700 {
+			timing-et0700 {
 				u-boot,panel-name = "edt,etm0700g0dh6";
 				clock-frequency = <33264000>;
 				hactive = <800>;
@@ -192,7 +192,7 @@ ET0700 {
 				pixelclk-active = <0>;
 			};
 
-			ETV570 {
+			timing-etv570 {
 				u-boot,panel-name = "edt,et057090dhu";
 				clock-frequency = <25200000>;
 				hactive = <640>;
@@ -224,7 +224,7 @@ lvds1_out: endpoint {
 		};
 
 		display-timings {
-			hsd100pxn1 {
+			timing-hsd100pxn1 {
 				clock-frequency = <65000000>;
 				hactive = <1024>;
 				vactive = <768>;
@@ -238,7 +238,7 @@ hsd100pxn1 {
 				pixelclk-active = <1>;
 			};
 
-			VGA {
+			timing-vga {
 				clock-frequency = <25200000>;
 				hactive = <640>;
 				vactive = <480>;
@@ -254,7 +254,7 @@ VGA {
 				pixelclk-active = <0>;
 			};
 
-			nl12880bc20 {
+			timing-nl12880bc20 {
 				clock-frequency = <71000000>;
 				hactive = <1280>;
 				vactive = <800>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
index 1db146ac1c17..864173e30709 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
@@ -405,7 +405,7 @@ display: disp0 {
 		status = "okay";
 
 		display-timings {
-			VGA {
+			timing-vga {
 				clock-frequency = <25200000>;
 				hactive = <640>;
 				vactive = <480>;
@@ -421,7 +421,7 @@ VGA {
 				pixelclk-active = <1>;
 			};
 
-			ETV570 {
+			timing-etv570 {
 				clock-frequency = <25200000>;
 				hactive = <640>;
 				vactive = <480>;
@@ -437,7 +437,7 @@ ETV570 {
 				pixelclk-active = <1>;
 			};
 
-			ET0350 {
+			timing-et0350 {
 				clock-frequency = <6413760>;
 				hactive = <320>;
 				vactive = <240>;
@@ -453,7 +453,7 @@ ET0350 {
 				pixelclk-active = <1>;
 			};
 
-			ET0430 {
+			timing-et0430 {
 				clock-frequency = <9009000>;
 				hactive = <480>;
 				vactive = <272>;
@@ -469,7 +469,7 @@ ET0430 {
 				pixelclk-active = <0>;
 			};
 
-			ET0500 {
+			timing-et0500 {
 				clock-frequency = <33264000>;
 				hactive = <800>;
 				vactive = <480>;
@@ -485,7 +485,7 @@ ET0500 {
 				pixelclk-active = <1>;
 			};
 
-			ET0700 { /* same as ET0500 */
+			timing-et0700 { /* same as ET0500 */
 				clock-frequency = <33264000>;
 				hactive = <800>;
 				vactive = <480>;
@@ -501,7 +501,7 @@ ET0700 { /* same as ET0500 */
 				pixelclk-active = <1>;
 			};
 
-			ETQ570 {
+			timing-etq570 {
 				clock-frequency = <6596040>;
 				hactive = <320>;
 				vactive = <240>;
-- 
2.43.0


