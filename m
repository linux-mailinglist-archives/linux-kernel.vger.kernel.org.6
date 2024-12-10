Return-Path: <linux-kernel+bounces-439929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBADE9EB645
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51385283712
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0B71BEF70;
	Tue, 10 Dec 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bXXp6rm9"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88E1C3040;
	Tue, 10 Dec 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847956; cv=none; b=gEbi1iWnFojR0K+WkYEd7uYKK/bFrmQclS5my+JX8FBmcTYqUFP1rWJLqrKHrSEBRTyT2AH0Fr4yZgrIhlKdSaV+hC/FKtN0zl6eZVo2vNMYFS1PUdCJaAf1GpeKt3AZ5DjuzYpMe0F4C1ZEKSlDXtRIDMfLJ/4YCInO5pnt8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847956; c=relaxed/simple;
	bh=DlNs/Z4Wd6wIp6vI6wjMskh6Esgevs4QkI/cSvEJJSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMLpOPJrAMEENIl47WIKibmwaPhpdz3sTPQcZ5Y03YdGDZVfEUeRQa1X9+rTNKI49KDA0RUo1FthlSx8JUTtPxpURMmID3zFVvbr5bzwPv91BULu78UE6SrAlJvHti7LPGxuheBLGcMii9KoMw+wGAcDTXRb93GQvb2sHvcMie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bXXp6rm9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733847946;
	bh=DlNs/Z4Wd6wIp6vI6wjMskh6Esgevs4QkI/cSvEJJSs=;
	h=From:To:Cc:Subject:Date:From;
	b=bXXp6rm9AXEaFBxahXCF+gPwXndo825SOm1iDJYFmM1GEOtIUMq9qsCoxjRZd2ShM
	 4hHPOjn1L96XZ1+z/H1AQ24blDnKpxUX0IwopFEfMWVUIHCbPutRcXKQ7pMtqnb97c
	 jDDNWdWU1tn52D91OWfO6DkWTPNVyBIyPfbDyVAtX60z/ZKh7PjLu56BEKrm1LHJD3
	 uYhxzsh0KC4JmTkTcc76olQwyb0lt0Pi2r1hNq/fiXFUAxIHEGMRb+iv5ZXmxyIbQP
	 lp2qL28j6B8IfGXpEeHOlsoxIJ2OiHxbBujAmosxZdKUDWJRA77kkx5IQrhPjWKakv
	 D/BguEEC4iPMw==
Received: from jupiter.universe (dyndsl-091-248-190-127.ewe-ip-backbone.de [91.248.190.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 932C317E3781;
	Tue, 10 Dec 2024 17:25:46 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 2726248CC8A; Tue, 10 Dec 2024 17:25:46 +0100 (CET)
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
Subject: [PATCH v2 1/1] arm64: dts: rockchip: rk3588-evb1: add WLAN controller
Date: Tue, 10 Dec 2024 17:24:04 +0100
Message-ID: <20241210162452.116767-1-sebastian.reichel@collabora.com>
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
Changes since PATCHv1:
 * rebase to latest for-next branch from Heiko
 * add regulator- prefix to regulator nodes
 * sort properties alphabetically in regulator nodes
 * sort regulator nodes alphabetically
---
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index d6e464cdc536..ba49f0bbaac6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -206,6 +206,28 @@ vcc3v3_pcie30: regulator-vcc3v3-pcie30 {
 		pinctrl-0 = <&vcc3v3_pcie30_en>;
 	};
 
+	vcc3v3_pciewl_vbat: regulator-vcc3v3-pciewl-vbat {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "wlan-vbat";
+		vin-supply = <&vcc_3v3_s0>;
+	};
+
+	vcc3v3_wlan: regulator-vcc3v3-wlan {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_pwren>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "wlan-en";
+		vin-supply = <&vcc3v3_pciewl_vbat>;
+	};
+
 	vcc5v0_host: regulator-vcc5v0-host {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_host";
@@ -249,12 +271,26 @@ vcc5v0_usb: regulator-vcc5v0-usb {
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc5v0_usbdcin>;
 	};
+
+	vccio_wl: regulator-vccio-wl {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-name = "wlan-vddio";
+		vin-supply = <&vcc_1v8_s0>;
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
@@ -440,6 +476,30 @@ rgmii_phy: ethernet-phy@1 {
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
@@ -494,6 +554,18 @@ hym8563_int: hym8563-int {
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
@@ -524,6 +596,16 @@ usbc0_int: usbc0-int {
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


