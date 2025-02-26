Return-Path: <linux-kernel+bounces-534034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F0A461D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2C2188C2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD472221713;
	Wed, 26 Feb 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="TSQptmHI"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2889B21B9CA;
	Wed, 26 Feb 2025 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579003; cv=none; b=TBiTFkKmWv/yjas8wg2Pin7SERsbWGROoZWUQ7VXVKgCzbNV8UWh1vH1c7QF8rbJfEcZ3v5OaJ+AeSKcvY6Zm3yjS3H/V8etmR1hXY/kOH4eXOWzawG4rSp5d0cPP/9jOoQQqeWK8kPiF2p+7fvWbBRnCsD1DcNG4Icxwrs2Cas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579003; c=relaxed/simple;
	bh=YVoNloeVgpf3EVWxDVW4kcg9ar4lcNxhH/EE/fNG7RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6K/DQCorHPkOXhFbYHOuL/oRE/AeHXD8rm9qXccMxW7VoL0Con3f/ZvnKnoCbyacmpZSAsUA5cqDcsXZHpyfRHZPPybyQmxoRTq8PubO5FIfmd6JDNnhDJ8uVXrFJAE9uHkBVVAud/QeDZGaU8bICPWfYOextq81+Ac1SomDHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=TSQptmHI; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s2KiHCRA5QT7UfzfGaUrGKo2f1M1l1E4d9U48qCobb8=; b=TSQptmHI/rY6TIdyEBpV/oEQH3
	4wIuOfHUuDXN9oaL0AZjjfXEOFWuIosn2MYqSCOIqAsxrIvnylog0yOTUiWRPfJEXO/8NeftpFnyA
	zSHKNtXSyQgFdPMKB9rJW4wEKVImFat4JCdRA4XbDK5vccKA3nC+k8FMeq05NewrEBc/QLe9R2WU0
	pCH6Q39tA47+LOlXDDtl/LlsYDq+0fjwSXVNyDDTJLHsh6VckSyR0ilxesLpn0ABGspSbbCbj5SP2
	LOjmx46GcGzgNVEb9mgz8jbxnExoPfkpFhtr97pNrL6YiIvQNW90Eq19bnPb4VroryJkvRxlMw2Qa
	XKFHFA+Q==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnI6p-0000V2-B6; Wed, 26 Feb 2025 15:09:59 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dse@thaumatec.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v3 3/3] arm64: dts: rockchip: add overlay for tiger-haikou video-demo adapter
Date: Wed, 26 Feb 2025 15:09:42 +0100
Message-ID: <20250226140942.3825223-4-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226140942.3825223-1-heiko@sntech.de>
References: <20250226140942.3825223-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

This adds support for the video-demo-adapter DEVKIT ADDON CAM-TS-A01
(https://embedded.cherry.de/product/development-kit/) for the Haikou
devkit with Tiger RK3588 SoM.

The Video Demo adapter is an adapter connected to the fake PCIe slot
labeled "Video Connector" on the Haikou devkit.

It's main feature is a Leadtek DSI-display with touchscreen and a camera
(that is not supported yet). To drive these components a number of
additional regulators are grouped on the adapter as well as a PCA9670
gpio-expander to provide the needed additional gpio-lines.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   5 +
 .../rk3588-tiger-haikou-video-demo.dtso       | 153 ++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index db6017272ff1..4cddb5d2807d 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -158,6 +158,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou-video-demo.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-coolpi-4b.dtb
@@ -214,3 +215,7 @@ rk3588-rock-5b-pcie-ep-dtbs := rk3588-rock-5b.dtb \
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtb
 rk3588-rock-5b-pcie-srns-dtbs := rk3588-rock-5b.dtb \
 	rk3588-rock-5b-pcie-srns.dtbo
+
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou-video-demo.dtb
+rk3588-tiger-haikou-video-demo-dtbs := rk3588-tiger-haikou.dtb \
+	rk3588-tiger-haikou-video-demo.dtbo
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso
new file mode 100644
index 000000000000..b8636fcb4f39
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2024 Cherry Embedded Solutions GmbH
+ *
+ * DEVKIT ADDON CAM-TS-A01
+ * https://embedded.cherry.de/product/development-kit/
+ *
+ * DT-overlay for the camera / DSI demo appliance for Haikou boards.
+ * In the flavour for use with a Tiger system-on-module.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+
+&{/} {
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		power-supply = <&dc_12v>;
+		pwms = <&pwm0 0 25000 0>;
+	};
+
+	vcc1v8_video: regulator-vcc1v8-video {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v8-video";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_baseboard>;
+	};
+
+	vcc2v8_video: regulator-vcc2v8-video {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc2v8-video";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&vcc3v3_baseboard>;
+	};
+
+	video-adapter-leds {
+		compatible = "gpio-leds";
+
+		video-adapter-led {
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pca9670 7 GPIO_ACTIVE_HIGH>;
+			label = "video-adapter-led";
+			linux,default-trigger = "none";
+		};
+	};
+};
+
+&dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "leadtek,ltk050h3148w";
+		reg = <0>;
+		backlight = <&backlight>;
+		iovcc-supply = <&vcc1v8_video>;
+		reset-gpios = <&pca9670 0 GPIO_ACTIVE_LOW>;
+		vci-supply = <&vcc2v8_video>;
+
+		port {
+			mipi_panel_in: endpoint {
+				remote-endpoint = <&dsi0_out_panel>;
+			};
+		};
+	};
+};
+
+&dsi0_in {
+	dsi0_in_vp3: endpoint {
+		remote-endpoint = <&vp3_out_dsi0>;
+	};
+};
+
+&dsi0_out {
+	dsi0_out_panel: endpoint {
+		remote-endpoint = <&mipi_panel_in>;
+	};
+};
+
+&i2c6 {
+	/* OV5675, GT911, DW9714 are limited to 400KHz */
+	clock-frequency = <400000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	touchscreen@14 {
+		compatible = "goodix,gt911";
+		reg = <0x14>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <RK_PC3 IRQ_TYPE_LEVEL_LOW>;
+		irq-gpios = <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_int>;
+		reset-gpios = <&pca9670 1 GPIO_ACTIVE_HIGH>;
+		AVDD28-supply = <&vcc2v8_video>;
+		VDDIO-supply = <&vcc3v3_baseboard>;
+	};
+
+	pca9670: gpio@27 {
+		compatible = "nxp,pca9670";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pca9670_resetn>;
+		reset-gpios = <&gpio3 RK_PC1 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&mipidcphy0 {
+	status = "okay";
+};
+
+&pinctrl {
+	pca9670 {
+		pca9670_resetn: pca9670-resetn {
+			rockchip,pins = <3 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	touch {
+		touch_int: touch-int {
+			rockchip,pins = <3 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&vp3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	vp3_out_dsi0: endpoint@ROCKCHIP_VOP2_EP_MIPI0 {
+		reg = <ROCKCHIP_VOP2_EP_MIPI0>;
+		remote-endpoint = <&dsi0_in_vp3>;
+	};
+};
-- 
2.47.2


