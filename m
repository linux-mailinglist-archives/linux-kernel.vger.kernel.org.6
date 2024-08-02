Return-Path: <linux-kernel+bounces-272101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5696194570D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4702A1C22FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F9E60B8A;
	Fri,  2 Aug 2024 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="WoZLDgvs"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078083E467;
	Fri,  2 Aug 2024 04:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572770; cv=none; b=sXvQAgCbu+lucR6EIOqyRze+ElZ9+b2ZP7N4+WGcTwflGyXS+LnXT+sfGFDls3ah4wLZj2pPEqI49x4XBm6E/qr3Zks/V2OpBwwkBo1OmH7xngqM06szDV54zTwT3NeTtKhIW+BX9QImjjwoWCjIGzq47vKQWGyb+4o0L6Pv+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572770; c=relaxed/simple;
	bh=uC7X0lGxlfuRxFnf2An1GhnCILl4aNBm6rvqrKHiWAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e3CnWbEJI1dOUEWeHPEAzOYyN17GsSTQhWVMcagcTqFEyuSZJtcDSpziWx2halrpnc0lrdZBQ4GcbytXGJCyKoMxCx6n/Md/OCn2eHsRRbY0UEkTx94PnzTlnxjt/XO6Cy5g0upOkeM/BTCZ7f8Pk6+L8ljcS7GyulDfsqWxj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WoZLDgvs; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722572766;
	bh=v0Ah9Ds5C38ORUdeAUCld/R4xg5N/MltZUnX4Av2+fo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WoZLDgvscGj5amlyoiZpehPpE4NVW6Z0hU0Q4nndSkkypbMnO4t9WGe+dWAiLMmic
	 BHyLaWGSU9orYYmGZRvcR9kquAjEwEbZovhNGDNnVvIZIrLcRVebmTsx13IWJSndRo
	 o+gwkMnmgNTlcYytDl6dfSExvxsx9Jgy9a5wj1kWpniCsKBzLuO4eyNB1hv/qIqfzs
	 v1ATae47HWHp4bmNG9OnFCiXoZzNgkP3kKLPaHqOvgEWyMIjsSj7JtPOuGaUfbA49f
	 yAAZeSVR/aGePKE5r2ygCZaA9AbsjRsopnDk0yXuM12CCHiudLlE46rh1IZ+nwo/uy
	 lhBlzLOxEucLg==
Received: from [127.0.1.1] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BDDB866E0B;
	Fri,  2 Aug 2024 12:26:05 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:22 +0930
Subject: [PATCH 5/7] ARM: dts: aspeed: Clean up AST2500 pinctrl properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dt-warnings-bmc-dts-cleanups-v1-5-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eddie James <eajames@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1

Many platforms were specifying the `aspeed,external-nodes` property
required by the AST2500 pinctrl. However, its been specified in the
pinctrl node directly in aspeed-g5.dtsi for quite a long time now.

Remove the unnecessary override from all relevant platform dts files.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts           | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts          | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts         | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts         | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts           | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts             | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts              | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts             | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts               | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts         | 4 ----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts               | 2 --
 arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts       | 4 ----
 13 files changed, 50 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
index 8ab5f301f926..e77f8192902d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
@@ -672,10 +672,6 @@ &gfx {
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
index 7c6af7f226e7..29c68c37e7f5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
@@ -200,10 +200,6 @@ &gfx {
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &gpio {
 	pin_gpio_c7 {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index 8dee4faa9e07..0943e0bf1305 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -254,10 +254,6 @@ &gfx {
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &vhub {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
index 0dea014e4f30..78a5656ef75d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
@@ -814,10 +814,6 @@ &gfx {
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &wdt1 {
 	aspeed,reset-type = "none";
 	aspeed,external-signal;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts
index 5a98a19f445e..7a78c34cff40 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts
@@ -123,10 +123,6 @@ &gfx {
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts
index d5b7d28cda88..da55e7b29fac 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts
@@ -118,10 +118,6 @@ &gfx {
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
index c0847636f20b..370738572a55 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
@@ -263,10 +263,6 @@ &gfx {
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &gpio {
 	pin_gpio_b0 {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
index ac0d666ca10e..b1d0ff85d397 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
@@ -284,10 +284,6 @@ &gfx {
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &ibt {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
index 893e621ecab1..24df24ad9c80 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
@@ -289,10 +289,6 @@ &gfx {
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
index bbf864f84d37..a0e8c97e944a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
@@ -938,10 +938,6 @@ &gfx {
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &wdt1 {
 	aspeed,reset-type = "none";
 	aspeed,external-signal;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
index 7820bc829dff..8b1e82c8cdfe 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
@@ -661,10 +661,6 @@ &gfx {
 	memory-region = <&gfx_memory>;
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &wdt1 {
 	aspeed,reset-type = "none";
 	aspeed,external-signal;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
index 3d2d8db73ca6..9904f0a58cfa 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
@@ -466,8 +466,6 @@ &i2c13 {
 };
 
 &pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-
 	pinctrl_gpioh_unbiased: gpioi_unbiased {
 		pins = "A8", "C7", "B7", "A7", "D7", "B6", "A6", "E7";
 		bias-disable;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts
index 50f3c6a5c0c8..b961dff388d1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dts
@@ -123,10 +123,6 @@ &gfx {
 	status = "okay";
 };
 
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
 &pwm_tacho {
 	status = "okay";
 	pinctrl-names = "default";

-- 
2.39.2


