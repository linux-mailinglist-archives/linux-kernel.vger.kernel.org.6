Return-Path: <linux-kernel+bounces-544324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2621EA4E01D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727443B36CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1814E204C2C;
	Tue,  4 Mar 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jOOUnhh7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B37202F90;
	Tue,  4 Mar 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096922; cv=none; b=sAbfcq2s5uoXHlhFkBvpP+xqDkeO6BGAUh/TxIgS9MxlBV0LG7e2ly4ryMPdIE9nuEzsvwkt+Jx669iq9QCu5hxbH8MGJ3iw1pcB9Et6IsKEhwj4M5UGEdqO88Xh2Rzaa4h77qEqf9CYQiexjPJ1r5APp9f/szeyQq9NhD3n1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096922; c=relaxed/simple;
	bh=pq3KZLjVtYgG3QJjA0gfc0ATstLTL4U024ZZLEq+S30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HsyRCJAFcSY+5xc5MXgZ7XYf3iUCsu/jXWPjmlYEhkduZUAIy3WnSl7e0+ajEkq1/WlEr8Eqh4gaXmU/Oi3z7q+kLS9Z3x9qFV/dhNfz46M0rs5HUZZbF2hvFYJ/vfvwglLMjpBu8R81ukZZeJVjUiyE6gy9ni3FQEJx4opt2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jOOUnhh7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741096918;
	bh=pq3KZLjVtYgG3QJjA0gfc0ATstLTL4U024ZZLEq+S30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jOOUnhh7ghUI7j0/Rzy79CJhgMGKYVh8gNeUQyN3tI+o1DY+O4FTOn2G8cbBVD3fN
	 16B2GZdaUK9f53fxgfmB7n+bq+AWzsF74bV7UCayIDzYLfvWKZYxsv5lesh0NtjQJg
	 eGGcPU+2mEf3C60V8JeKC0YHHxtEPt7Ovccp8hj8hkGN0priJUtbel9GJ/xkUHvFfX
	 byrmL+bIbkRyJXjMGoYgQzCbB3GVnbO1DNSOI55K8YpIYmXnCnCH6Fn73eCYNTUm3w
	 JYmmRFDOEXApUgTSYjx5P2Od7fRzx/h4GSXAH/aMos2nzz3EgnE7LPkXWhVTHeA9ZX
	 gHxZUc4IfUSDw==
Received: from apertis-1.home (2a01cb0892F2D600C8F85cf092d4Af51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CF2EE17E0B56;
	Tue,  4 Mar 2025 15:01:57 +0100 (CET)
From: Julien Massot <julien.massot@collabora.com>
Date: Tue, 04 Mar 2025 15:01:55 +0100
Subject: [PATCH v2 1/2] arm64: dts: mediatek: mt8395-nio-12l: Prepare MIPI
 DSI port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-radxa-panel-overlay-v2-1-3ee6797d3f86@collabora.com>
References: <20250304-radxa-panel-overlay-v2-0-3ee6797d3f86@collabora.com>
In-Reply-To: <20250304-radxa-panel-overlay-v2-0-3ee6797d3f86@collabora.com>
To: kernel@collabora.com, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com, Julien Massot <julien.massot@collabora.com>
X-Mailer: b4 0.14.2

This board can use a MIPI-DSI panel on the DSI0 connector: in
preparation for adding an overlay for the Radxa Display 8HD,
add the backlight, and some definitions for pins available
through the DSI0 port.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts     | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 7184dc99296c7f5d749c7e6d378722677970b3b7..1c922e98441a1aadf0aa3cdd76583a70401a1fa3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -48,6 +48,18 @@ memory@40000000 {
 		reg = <0 0x40000000 0x1 0x0>;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 1023>;
+		default-brightness-level = <576>;
+		enable-gpios = <&pio 107 GPIO_ACTIVE_HIGH>;
+		num-interpolated-steps = <1023>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dsi0_backlight_pins>;
+		pwms = <&disp_pwm0 0 500000>;
+		status = "disabled";
+	};
+
 	wifi_vreg: regulator-wifi-3v3-en {
 		compatible = "regulator-fixed";
 		regulator-name = "wifi_3v3_en";
@@ -502,6 +514,13 @@ &mt6359_vsram_others_ldo_reg {
 &pio {
 	mediatek,rsel-resistance-in-si-unit;
 
+	dsi0_backlight_pins: dsi0-backlight-pins {
+		pins-backlight-en {
+			pinmux = <PINMUX_GPIO107__FUNC_GPIO107>;
+			output-high;
+		};
+	};
+
 	eth_default_pins: eth-default-pins {
 		pins-cc {
 			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
@@ -699,6 +718,13 @@ pins-irq {
 		};
 	};
 
+	panel_default_pins: panel-pins {
+		pins-rst {
+			pinmux = <PINMUX_GPIO108__FUNC_GPIO108>;
+			bias-pull-up;
+		};
+	};
+
 	pcie0_default_pins: pcie0-default-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO19__FUNC_WAKEN>,
@@ -717,6 +743,12 @@ pins-bus {
 		};
 	};
 
+	pwm0_default_pins: pwm0-pins {
+		pins-disp-pwm {
+			pinmux = <PINMUX_GPIO97__FUNC_DISP_PWM0>;
+		};
+	};
+
 	spi1_pins: spi1-default-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO136__FUNC_SPIM1_CSB>,
@@ -737,6 +769,19 @@ pins-bus {
 		};
 	};
 
+	touch_pins: touch-pins {
+		pins-touch-int {
+			pinmux = <PINMUX_GPIO132__FUNC_GPIO132>;
+			input-enable;
+			bias-disable;
+		};
+
+		pins-touch-rst {
+			pinmux = <PINMUX_GPIO133__FUNC_GPIO133>;
+			output-high;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,

-- 
2.48.1


