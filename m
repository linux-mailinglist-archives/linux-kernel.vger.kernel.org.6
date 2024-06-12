Return-Path: <linux-kernel+bounces-212241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 366CB905D34
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A271B22B46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75261126F1F;
	Wed, 12 Jun 2024 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="G9umbXzZ"
Received: from shout11.mail.de (shout11.mail.de [62.201.172.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C259984E0A;
	Wed, 12 Jun 2024 20:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225668; cv=none; b=c7lcjXUN/6P82eOAQ3uNfN3IPetWfyxRbmxX2EuZs1FNYL/8V5Izw5jkwTe0Eszt8uj26p6zszbMG85IhTPS5Q+MnZUAO3E9eWtHEubwFgmpVop5zQVXlpL9PAkbUxpvjC3FgyqHpgVKSbQjYdbiojjHKxpe6YXGL94PLlgg9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225668; c=relaxed/simple;
	bh=VCtcBjloeq2TIukMSshtT2aha3mHch2VVQdqj442tJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5TsMejCmE6zSJA9Nk/NXeuQN3iWExGa0MTVcAOxwyEHWOY9KIkBlN7nfPnB6wuuUXT4W8ruiQ21c4vjg7w+zsHIVaYJmB+B2ElTqtqsDTCknBDNcFK0Qp4P5IBBJBgwiG9f3cBii+Mhda4gpIFzI7iaAYl7CMP4xTldhttZutI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=G9umbXzZ; arc=none smtp.client-ip=62.201.172.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout01.mail.de (unknown [10.0.120.221])
	by shout11.mail.de (Postfix) with ESMTPS id 55537240CA1;
	Wed, 12 Jun 2024 22:54:19 +0200 (CEST)
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout01.mail.de (Postfix) with ESMTP id 3A2572405B9;
	Wed, 12 Jun 2024 22:54:19 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
	by postfix02.mail.de (Postfix) with ESMTP id 160ABA00E2;
	Wed, 12 Jun 2024 22:54:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1718225659;
	bh=VCtcBjloeq2TIukMSshtT2aha3mHch2VVQdqj442tJI=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
	b=G9umbXzZXXiTuADQjt/FVnCK5JxcQmZjRtkKNWKUeDiizAAs/1ppi3W6uzJo6JKCG
	 f8HDwt46AePF1tax0vYik1sVnDJ+hXzhJAEIlDCvUjaCFwqSYYpqXMxHxRZF72DwXu
	 B1emLH7BK1KMvie06ds4LV+zs9Mw9B3tQepKKoz4RzddFIOJ1+UV7ifAen881hTnED
	 FUXzFNkd0qqeveIqEoIQM6MNZxPe7ZFeS/hIHGFd54JuEYRRBVnds3ub4hiTeohm0B
	 Q6JnUXGbYp5FdSX7WYpgtLiCFzWFoZkloOQ/jGtt8EH426jW2CXzOsEj9o1Ee05HJC
	 +YuKw6QCC87xA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 9B129240A39;
	Wed, 12 Jun 2024 22:54:18 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] arm64: dts: rockchip: Improve LEDs on NanoPi R6C/R6S
Date: Wed, 12 Jun 2024 22:48:12 +0200
Message-ID: <20240612205056.397204-4-seb-dev@mail.de>
In-Reply-To: <20240612205056.397204-1-seb-dev@mail.de>
References: <20240612205056.397204-1-seb-dev@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 6197
X-purgate-ID: 154282::1718225658-FE5BF670-7FE753F2/0/0

Move led-3 node into NanoPi R6C/R6S's source files since they have
different functionalities on each board: On the R6S this LED is used
to signal LAN2 link up, while on the R6C this LED does not have a
pre-defined purpose.

In addition to that:
    - Remove deprecated label property
    - Add color and function properties
    - Add linux,default-trigger to trigger on Ethernet link

Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---

DT validation doesn't like the 'linux,default-trigger = "stmmac-0:01:link"'
properties, since "*:link" is not a valid value according to
[Documentation/devicetree/bindings/leds/common.yaml]. These LEDs do
have the specific purpose to show if an Ethernet link is up though.
There is one LED for each Ethernet port and they are labeled WAN and
LAN.
Using the 'linux,default-trigger' like this does work perfectly fine
with this solution. I could not find another way to achieve this. Please
let me know if there is a better way.
Maybe it would also be valid to add an entry to the DT bindings file to
allow "*:link" as a value for 'linux,default-trigger'?

The same problem also applies to the NanoPi R5C/R5S which also has
these LEDs to show Ethernet link up, although in their current DT
these LEDs are simply not functional.

---
 .../boot/dts/rockchip/rk3588s-nanopi-r6.dtsi  | 32 +++++++------------
 .../boot/dts/rockchip/rk3588s-nanopi-r6c.dts  | 22 ++++++++++---
 .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  | 26 +++++++++++++--
 3 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
index 8b90bae28302..69d0f1f2349b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include "rk3588s.dtsi"
 
 / {
@@ -52,7 +53,8 @@ leds {
 		compatible = "gpio-leds";
 
 		sys_led: led-0 {
-			label = "sys_led";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_HEARTBEAT;
 			gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			pinctrl-names = "default";
@@ -60,24 +62,22 @@ sys_led: led-0 {
 		};
 
 		wan_led: led-1 {
-			label = "wan_led";
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WAN;
 			gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "stmmac-0:01:link";
 			pinctrl-names = "default";
 			pinctrl-0 = <&wan_led_pin>;
 		};
 
 		lan1_led: led-2 {
-			label = "lan1_led";
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
 			gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "r8169-3-3100:00:link";
 			pinctrl-names = "default";
 			pinctrl-0 = <&lan1_led_pin>;
 		};
-
-		lan2_led: led-3 {
-			gpios = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&lan2_led_pin>;
-		};
 	};
 
 	vcc_5v0: regulator-vcc-5v0 {
@@ -328,23 +328,15 @@ key1_pin: key1-pin {
 
 	gpio-leds {
 		sys_led_pin: sys-led-pin {
-			rockchip,pins =
-				<1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
 		wan_led_pin: wan-led-pin {
-			rockchip,pins =
-				<1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
 		lan1_led_pin: lan1-led-pin {
-			rockchip,pins =
-				<1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		lan2_led_pin: lan2-led-pin {
-			rockchip,pins =
-				<1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
index 24dcd3e07ea7..d1b6aa033abc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
@@ -8,6 +8,18 @@ / {
 	model = "FriendlyElec NanoPi R6C";
 	compatible = "friendlyarm,nanopi-r6c", "rockchip,rk3588s";
 
+	leds {
+		compatible = "gpio-leds";
+
+		led1_led: led-3 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = "led1";
+			gpios = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&led1_led_pin>;
+		};
+	};
+
 	/* MP2143DJ power switch (U9536 in schematics) */
 	vcc3v3_pcie: regulator-vcc3v3-pcie {
 		compatible = "regulator-fixed";
@@ -24,16 +36,18 @@ vcc3v3_pcie: regulator-vcc3v3-pcie {
 	};
 };
 
-&lan2_led {
-	label = "user_led";
-};
-
 /* M.2 M-Key socket */
 &pcie2x1l2 {
 	vpcie3v3-supply = <&vcc3v3_pcie>;
 };
 
 &pinctrl {
+	gpio-leds {
+		led1_led_pin: led1-led-pin {
+			rockchip,pins = <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	pcie {
 		pcie20x1_2_con_pwren: pcie20x1-2-con-pwren {
 			rockchip,pins = <3 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
index d24110b6cf5d..09afbc0a2581 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
@@ -7,13 +7,35 @@
 / {
 	model = "FriendlyElec NanoPi R6S";
 	compatible = "friendlyarm,nanopi-r6s", "rockchip,rk3588s";
+
+	leds {
+		compatible = "gpio-leds";
+
+		lan2_led: led-3 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			function-enumerator = <2>;
+			gpios = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "r8169-4-4100:00:link";
+			pinctrl-names = "default";
+			pinctrl-0 = <&lan2_led_pin>;
+		};
+	};
 };
 
-&lan2_led {
-	label = "lan2_led";
+&lan1_led {
+	function-enumerator = <1>;
 };
 
 /* RTL8125BG Ethernet */
 &pcie2x1l2 {
 	vpcie3v3-supply = <&vcc_3v3_s3>;
 };
+
+&pinctrl {
+	gpio-leds {
+		lan2_led_pin: lan2-led-pin {
+			rockchip,pins = <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
-- 
2.43.0


