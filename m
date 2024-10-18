Return-Path: <linux-kernel+bounces-372110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92219A448A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54FBC1F2163E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B518320401D;
	Fri, 18 Oct 2024 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jtLQakga"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F312038A3;
	Fri, 18 Oct 2024 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272278; cv=none; b=lRzJvKrU4e0dT+Oq30sOKvaRQA0BRvxSbcPhkZFZt6jLGodLY3YBK1S0n2RYmIIQTJfYjlMVmH2N4R9JOA0wgxi71Soq54iHPYMfBpl3LctACb+3LBKX7d5C2BU4ZH7vr6hmN8nI/FF1hMG4YffJHykFBngzRKdfM+qPN1DMI80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272278; c=relaxed/simple;
	bh=fWTUGUbvtxGgdUl3mI+I8UiYVV3ELG6T2ASGw2R93Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R4brSEcEl3qT5+ac23rZnEkbABltvcJd7OqFn0qoIrKaO2+CMNhDevrtGq090gqK1VNvlRsHO4H3vkCRdADepALi5kpr+fV8wPiflIOwcSHAIgl1SVHVCTYUHRE63HN/NciDyL9ucXmfoPKDLFZ7uaTZWcNpnBmEzW/PnmNVaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jtLQakga; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729272274;
	bh=fWTUGUbvtxGgdUl3mI+I8UiYVV3ELG6T2ASGw2R93Dg=;
	h=From:To:Cc:Subject:Date:From;
	b=jtLQakgatYLOAtYpLqyRV51Un6cbN7cvmnh4hy+F2b3cHB9kxk0IyDIwBX+rR+3+J
	 h2o198viNsa0rHJIEWTtm4clJuQKpe4eTherydBqnz0caYTDV82UAiNnEuWV1hRDcq
	 oj5pjUBOyzAceB8biQ90QdaF2rAd1iT2zYyVXeVbEHFAUdLR9Ls80SW3cKVhezsFDF
	 p2BY4MberRL5alzfJTILUlG0e9K9N9cTvUXIcwdHreWvPBa7Iqd1jjsxipQgqlWR0B
	 GPWvgXNWWGI+xlmjc/sP1KxtrVuUUuvqiCoctEtN+UQWLxPP5NYThGlmoZdEllFTl8
	 lyzR8GC3QScuQ==
Received: from jupiter.universe (dyndsl-091-248-211-226.ewe-ip-backbone.de [91.248.211.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0451217E367D;
	Fri, 18 Oct 2024 19:24:34 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9A6764800EA; Fri, 18 Oct 2024 19:24:33 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 1/1] arm64: dts: rockchip: rk3588-evb1: add WLAN controller
Date: Fri, 18 Oct 2024 19:24:21 +0200
Message-ID: <20241018172432.53182-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3588 EVB1 has an onboard AP6275P WLAN/BT module. This adds
support for the WLAN side, which is connected to the second
PCIe bus. The Bluetooth side is connected to UART and handled
separately.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index df44dbc394ca..f55ab8f59d65 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -237,12 +237,48 @@ vcc5v0_usb: vcc5v0-usb-regulator {
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc5v0_usbdcin>;
 	};
+
+	vccio_wl: vccio-wl {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-vddio";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc_1v8_s0>;
+	};
+
+	vcc3v3_pciewl_vbat: vcc3v3-pciewl-vbat {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-vbat";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc_3v3_s0>;
+	};
+
+	vcc3v3_wlan: vcc3v3-wlan {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_pwren>;
+		regulator-name = "wlan-en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&vcc3v3_pciewl_vbat>;
+	};
 };
 
 &combphy0_ps {
 	status = "okay";
 };
 
+&combphy1_ps {
+	status = "okay";
+};
+
 &combphy2_psu {
 	status = "okay";
 };
@@ -408,6 +444,30 @@ rgmii_phy: ethernet-phy@1 {
 	};
 };
 
+&pcie2x1l0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_0_rst>, <&pcie2_0_wake>, <&pcie2_0_clkreq>, <&wifi_host_wake_irq>;
+	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_wlan>;
+	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x200000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x20 0x2f>;
+
+		wifi: wifi@0,0 {
+			compatible = "pci14e4,449d";
+			reg = <0x210000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "lpo";
+		};
+	};
+};
+
 &pcie2x1l1 {
 	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
@@ -462,6 +522,18 @@ hym8563_int: hym8563-int {
 	};
 
 	pcie2 {
+		pcie2_0_rst: pcie2-0-rst {
+			rockchip,pins = <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie2_0_wake: pcie2-0-wake {
+			rockchip,pins = <4 RK_PA4 4 &pcfg_pull_none>;
+		};
+
+		pcie2_0_clkreq: pcie2-0-clkreq {
+			rockchip,pins = <4 RK_PA3 4 &pcfg_pull_none>;
+		};
+
 		pcie2_1_rst: pcie2-1-rst {
 			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
@@ -492,6 +564,16 @@ usbc0_int: usbc0-int {
 			rockchip,pins = <3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	wlan {
+		wifi_host_wake_irq: wifi-host-wake-irq {
+			rockchip,pins = <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		wifi_pwren: wifi-pwren {
+			rockchip,pins = <3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
 };
 
 &pwm2 {
-- 
2.45.2


