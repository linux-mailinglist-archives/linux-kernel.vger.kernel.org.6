Return-Path: <linux-kernel+bounces-534120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60A8A462FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF16189850E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C352B221F21;
	Wed, 26 Feb 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bGopM7t9"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752D218AAB;
	Wed, 26 Feb 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580555; cv=none; b=C6RqKwteH8KHYYDdOO8aIn/WGsCT1pmGBw9CqwUMht/EGSdbC4U/2u9nlU2VrrqZMAoKYJn7Ujq0Yx6IAhRYK5mdeGWJpJ1tyE81CsXrEwLVXFIPY+OEjPGJ6nOH2DUiG5isKEnZ2lLomJJrR6sIzkjmj1mLC+I54ULg3yri1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580555; c=relaxed/simple;
	bh=oeoroF8KNenaCDMp30ILoE7NYXjjtAHcEZu1+5jM4O8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7kWNMvX52mScoKPg2eIIL3MYBr6Q9PwNUlboL1zk4AmnBiCecTN0/tn8JLtzA6uuotQsHy/noiWF3AxY+d/i+EA7qC7sTPMcUIHlWugml4zKdkkJ557ul29/zo+h0r5nREdQuCojIrhlQRzx+oVpnGyKQZsy/UECmLf9Y5Cf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bGopM7t9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740580551;
	bh=oeoroF8KNenaCDMp30ILoE7NYXjjtAHcEZu1+5jM4O8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bGopM7t9Gc+tPxRmLZVTAumruwzXbteqxFjJKpPdKvv+Jf5Tw+XQ1AqiajK3AB0sU
	 2G37BPuqSvukYP3muFbN5L5++T7VDyUa9HRW3w4SbohrCZHGZQSvHqemrg3eBG8EyI
	 gOkdbUiK19AWfxmOcvbtTtt9z+pvyGUGWNGHYKYSybKeWmR/TruUA3wN1WxEWSJh1f
	 nJZiQL2DN4yQBTsT+HKdpWRDUy9ibb6rnNoSWv/uSa5TXlqp/qq8LEkz98wOpEzj5p
	 Cj3V6krk8DcsK1z6AOBcvjlfwmQCJ0uuQaqNmNiI/Dnizi8YoXjpqt/XA78TG4cOEt
	 xA72VdZhwzxQg==
Received: from apertis-1.home (2a01cb088CcA73006086F5F072c6a07a.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:8cca:7300:6086:f5f0:72c6:a07a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0DFD617E05EA;
	Wed, 26 Feb 2025 15:35:51 +0100 (CET)
From: Julien Massot <julien.massot@collabora.com>
Date: Wed, 26 Feb 2025 15:35:27 +0100
Subject: [PATCH 1/2] arm64: dts: mediatek: mt8395-nio-12l: Prepare MIPI DSI
 port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-radxa-panel-overlay-v1-1-9e8938dfbead@collabora.com>
References: <20250226-radxa-panel-overlay-v1-0-9e8938dfbead@collabora.com>
In-Reply-To: <20250226-radxa-panel-overlay-v1-0-9e8938dfbead@collabora.com>
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
add a pipeline connecting VDOSYS0 components to DSI0.

Also add the backlight, and some pin definitions available
through the DSI0 port.

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
 .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts     | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 7184dc99296c7f5d749c7e6d378722677970b3b7..65c77e43d1cd4913b6741e25130febd746ff753c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -48,6 +48,17 @@ memory@40000000 {
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
+	};
+
 	wifi_vreg: regulator-wifi-3v3-en {
 		compatible = "regulator-fixed";
 		regulator-name = "wifi_3v3_en";
@@ -499,9 +510,20 @@ &mt6359_vsram_others_ldo_reg {
 	regulator-max-microvolt = <750000>;
 };
 
+&ovl0_in {
+	remote-endpoint = <&vdosys0_ep_main>;
+};
+
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
@@ -699,6 +721,13 @@ pins-irq {
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
@@ -717,6 +746,12 @@ pins-bus {
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
@@ -737,6 +772,19 @@ pins-bus {
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
@@ -912,6 +960,18 @@ &ssusb2 {
 	status = "okay";
 };
 
+&vdosys0 {
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vdosys0_ep_main: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&ovl0_in>;
+		};
+	};
+};
+
 &xhci0 {
 	vbus-supply = <&otg_vbus_regulator>;
 	status = "okay";

-- 
2.48.1


