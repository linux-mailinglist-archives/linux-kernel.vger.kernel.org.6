Return-Path: <linux-kernel+bounces-398226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 478779BEA68
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614381C259B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973E51F9A8E;
	Wed,  6 Nov 2024 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="FSEk2wbb"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669051F8F18;
	Wed,  6 Nov 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896692; cv=none; b=RsPtKN+dnbJX6Qf5Tr4XNmJPpvBdJWfyHUj2MXq/0EicfgOvMGZEYy9j8MVoYiLoQHzGkAmslE4I7xY2ko/ni13yIh3NmXdxqPU8yYNl393cDzq8k8OKOcS8TZ72sZSWlu+MzixUgVPiVwBVNBW3IvZVjJRJjshuzpNSPFaw+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896692; c=relaxed/simple;
	bh=tMjpxvbngeNlNIlcaBFOupaNvK9ipw97vj5olVqIvoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsVJErcpIvTG620WMVfC6gbz+809u9nKrCNjunPIihh0oM6VE0x8x1svaopfQnckAXZwEifB86IITvz8eTTleR+IvWK8MJOMjzQjlHtaIj7xBL8T2RSkRXPC58pk0MZj8rHnGRMY6xDOYvJVFaqmUUDsxwVLo2Nf4rUb7Zq+F4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=FSEk2wbb; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tgQ2wpFMOWfjeLb3bc1gmQMurl5R7B/AfYWdQuioG5k=; b=FSEk2wbbVXfw4R5fvPJc+K5Vcm
	9LZSKXSjjOJUeUxSe4F1TP2U73GY6pT9elXAN1L0PJrm80e4vuoJ2yRXT4OvYzjvN3eASn7CRo3af
	QgURrN4OxL8lfsnW4G6vqYe+ucgI3PTp7C6QAacFXvRNvc2BMi5MZ0zMILBU8oT5Un+HUrFtqzR4+
	5A/SWWb2ec2u42gbpOac4RQc8AynO3boIaypuCU5N83uMTtdgLJPZv7ZZYEJmZPUtcpqCgHfo8eru
	+h+xJYub8knsyCel3WJ+X2nuA7bvkVSFtkN8mULdAH7KBSDEIHDBb+LMVFr+Jeaam8gIY3v54r9wl
	tfX/IlVQ==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t8fIW-0007A8-Ko; Wed, 06 Nov 2024 13:38:08 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 3/3] arm64: dts: rockchip: add overlay for tiger-haikou video-demo adapter
Date: Wed,  6 Nov 2024 13:37:58 +0100
Message-ID: <20241106123758.423584-4-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106123758.423584-1-heiko@sntech.de>
References: <20241106123758.423584-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

This adds support for the video-demo-adapter for the Haikou devkit with
Tiger RK3588 SoM.

The Video Demo adapter is an adapter connected to the fake PCIe slot
labeled "Video Connector" on the Haikou devkit.

It's main feature is a Leadtek DSI-display with touchscreen. To drive these
components a number of additional regulators are grouped on the adapter as
well as a PCA9670 gpio-expander to provide the needed additional gpio-lines.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rk3588-tiger-haikou-video-demo.dtso       | 153 ++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 09423070c992..0c4ee6a767b8 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -143,6 +143,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-srns.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-tiger-haikou-video-demo.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-toybrick-x0.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-coolpi-4b.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso
new file mode 100644
index 000000000000..c7416349e7d5
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou-video-demo.dtso
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
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
+	video-adapter-leds {
+		compatible = "gpio-leds";
+		status = "okay";
+
+		video-adapter-led {
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pca9670 7 GPIO_ACTIVE_HIGH>;
+			label = "video-adapter-led";
+			linux,default-trigger = "none";
+		};
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		power-supply = <&dc_12v>;
+		pwms = <&pwm0 0 25000 0>;
+	};
+
+	hdmi-con {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi0_out_con>;
+			};
+		};
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
+		pinctrl-0 = <&touch_int>;
+		pinctrl-names = "default";
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
+	};
+};
+
+&mipidcphy0 {
+	status = "okay";
+};
+
+&pinctrl {
+	touch {
+		touch_int: touch-int {
+			rockchip,pins = <3 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm0 {
+	pinctrl-0 = <&pwm0m1_pins>;
+	pinctrl-names = "default";
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
2.45.2


