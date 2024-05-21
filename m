Return-Path: <linux-kernel+bounces-185467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857BC8CB53F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF281C2191E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E25D1514D3;
	Tue, 21 May 2024 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="XT9srpWB"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C529B1514C5
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325882; cv=none; b=UrWMWXZPnTnG97dXiI2R9uu8yXPuuLG8Fn360NwVOLt3mq8XYxYUQ/8pp7zwexpTaSygPB8ifPLUr1qmlAzRzu0F2/b1WwFOthkTKBKAf3R7oqzjnJtep+s/+o5f5M6j0Uf0dJJQFhzlIE34UIPA3all8bwBv/usfOPrkae7x0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325882; c=relaxed/simple;
	bh=780LjI9zHykK8F9yF1AvzIEg7laoNZ1MFbBqgi3DkCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aP2i2zM3WttiHRkBz9jmwv47REpiGe0ybMALTk8JGupmoT2Lk/Q6mB36FdF21VaiyY5pC7Zk3ttnmbZhsV1+9S0BssTVc9Ctm0VqyWkDVe3HQ60xSA4RCwnslRqcULo7q7xF4CEEeOP6S/qrRpSmSfr//VWi8bF96E1uhVjk+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=XT9srpWB; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1716325865; bh=Q+KNqYGJ2pU6mX/5douK68ZydcHesKtGsJ1fQQSMki8=;
 b=XT9srpWBp9X8lt5U3jtP9AQkwIYe8Iaj9DHwrpekvNs3mlkU5JUaIieBBx9sVxSydr+LXaoz2
 YKK+N+TSnvZCIHPk/ugUmi7/90CFsF1cq+h+K8BloUPl2WaTkFFz5mBuKI/eqW1a0BWkm1lbNlD
 W1sdPxVZZKuEKg/4NKuLrUaUo+yKMitmw8K/hFCMWxWqgN3bq0f5KOIYWE5lQN2mXxmSP5Qcw2M
 a9zfXKcd4HA/Pthf5NDp47Aw0tMjUEjNGSV3Gyn2jAZqok8s2CBt3GrVi5a3XVvU0ml3VctiCBu
 F9DQuRZ11JE88gVxoLfepARwzeQ8az4k4ekvq6KPu9uQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sjoerd Simons <sjoerd@collabora.com>, Akash Gajjar
 <akash@openedev.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 06/13] arm64: dts: rockchip: rk3308-rock-pi-s: Rename LED related pinctrl nodes
Date: Tue, 21 May 2024 21:10:09 +0000
Message-ID: <20240521211029.1236094-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240521211029.1236094-1-jonas@kwiboo.se>
References: <20240521211029.1236094-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 664d0de48b6b0c828344af00

The nodename, <name>-gpio, of referenced pinctrl nodes for the two LEDs
on the ROCK Pi S cause DT schema validation error:

  leds: green-led-gpio: {'rockchip,pins': [[0, 6, 0, 90]], 'phandle': [[98]]} is not of type 'array'
        from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
  leds: heartbeat-led-gpio: {'rockchip,pins': [[0, 5, 0, 90]], 'phandle': [[99]]} is not of type 'array'
        from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#

Rename the pinctrl nodes and symbols to pass DT schema validation, also
extend LED nodes with information about color and function.

Fixes: 2e04c25b1320 ("arm64: dts: rockchip: add ROCK Pi S DTS support")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
index 08d1be3a5de7..d4cf6026241c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
@@ -5,6 +5,8 @@
  */
 
 /dts-v1/;
+
+#include <dt-bindings/leds/common.h>
 #include "rk3308.dtsi"
 
 / {
@@ -24,17 +26,21 @@ chosen {
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&green_led_gio>, <&heartbeat_led_gpio>;
+		pinctrl-0 = <&green_led>, <&heartbeat_led>;
 
 		green-led {
+			color = <LED_COLOR_ID_GREEN>;
 			default-state = "on";
+			function = LED_FUNCTION_POWER;
 			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
 			label = "rockpis:green:power";
 			linux,default-trigger = "default-on";
 		};
 
 		blue-led {
+			color = <LED_COLOR_ID_BLUE>;
 			default-state = "on";
+			function = LED_FUNCTION_HEARTBEAT;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
 			label = "rockpis:blue:user";
 			linux,default-trigger = "heartbeat";
@@ -216,11 +222,11 @@ &pinctrl {
 	pinctrl-0 = <&rtc_32k>;
 
 	leds {
-		green_led_gio: green-led-gpio {
+		green_led: green-led {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		heartbeat_led_gpio: heartbeat-led-gpio {
+		heartbeat_led: heartbeat-led {
 			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-- 
2.43.2


