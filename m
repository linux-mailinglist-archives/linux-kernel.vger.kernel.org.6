Return-Path: <linux-kernel+bounces-208339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856209023B5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D62928EAE0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC821369AC;
	Mon, 10 Jun 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="CLTGjL3B"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0A915A8;
	Mon, 10 Jun 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028613; cv=none; b=qwjKDIT8RZ9amNP92Ldlbn3GT3yuxzkra+dUFE6vvX48AP57h0LA2ZoM2KHknDKdwZK7M99LlMLjPs7EmoBrwxvS72ioKZOMZf+O5wWrRILfYqp6eoqtLEK3xt6FP0rFqDWSSMtCZPnuyKCO/lXr93QA5xtRyt0+XjsSQm/ulKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028613; c=relaxed/simple;
	bh=yrvsW6NpIyyvUzCuw7XD/v8m6AxV1qlSrNJk9MBhaio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PMsW195owhTyNdZtF7wVax6iYMmTQCKno32tWpXKTYfnOGRFfRk3ZcFgeCocjExYSYzbfGxqB3jZCtiFu+wuup82lF/HS7S9oVTPl6GpatGYs6xrF5rs/bULcsl7mq7DCP/WERKjIbGQnrhTD2PplVfR/cSxFf/hH9nnpxrLqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=CLTGjL3B; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 83D4A1FB6F;
	Mon, 10 Jun 2024 16:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1718028608;
	bh=YkGB/2C2PmPaw5Fgoeug/KCYvx1pa2uTv5PzS+7PUHo=; h=From:To:Subject;
	b=CLTGjL3BIWIdo5p7FKFB94y7rgpgH2kqmc6uPfaI34mtfEcW7dTEPOARknXsrtLhP
	 zfgR262AEbFmCiziNL4Qm2GpYDgYpIT0zRYqL/aL3Acj+IO283Sd3VqO7JpovZZNtG
	 IeFU+EUuzuEgh1T+uU3rXZOfiQfWUdej5l5RS1qBGetARADhSLCdAUgw5l51ngt2xn
	 hUdGSSiC/Cc7EPoqjLTWPiVgQ/Qko9ak4uccdvlPK7SIJ3cWizqp13MuycrAsmXCVt
	 1vHubB1QXNjiazyjR0XGDSAgot8FhykazyD3/d4BZlQyUa6hGamuqTMB0AKTMD5205
	 IBIPXe+zzpJGQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: freescale: imx8mp-verdin: add HDMI support
Date: Mon, 10 Jun 2024 16:10:01 +0200
Message-Id: <20240610141001.32034-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Enable HDMI output on Verdin iMX8MP on all the supported carrier boards
(dev, dahlia, mallow and yavia).

HDMI DDC I2C is used in regular I2C mode, see link on the related
dt-bindings patch.

Fix CEC and HPD pinctrl, having a pull-down on HPD and a pull-up on CEC.

Link: https://lore.kernel.org/all/20240515062753.111746-1-marex@denx.de/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../dts/freescale/imx8mp-verdin-dahlia.dtsi   | 37 +++++++++++++++++++
 .../boot/dts/freescale/imx8mp-verdin-dev.dtsi | 37 +++++++++++++++++++
 .../dts/freescale/imx8mp-verdin-mallow.dtsi   | 37 +++++++++++++++++++
 .../dts/freescale/imx8mp-verdin-nonwifi.dtsi  |  3 +-
 .../dts/freescale/imx8mp-verdin-wifi.dtsi     |  3 +-
 .../dts/freescale/imx8mp-verdin-yavia.dtsi    | 37 +++++++++++++++++++
 .../boot/dts/freescale/imx8mp-verdin.dtsi     | 13 +++++--
 7 files changed, 160 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
index 6e6b9c2c4640..fbcd93e33aea 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
@@ -4,6 +4,18 @@
  */
 
 / {
+	native-hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "X21";
+		type = "a";
+
+		port {
+			native_hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,bitclock-master = <&codec_dai>;
@@ -94,6 +106,27 @@ &gpio4 {
 	pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
 };
 
+/* Verdin HDMI_1 */
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&native_hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
 /* Current measurement into module VCC */
 &hwmon {
 	status = "okay";
@@ -139,6 +172,10 @@ &i2c5 {
 	status = "okay";
 };
 
+&lcdif3 {
+	status = "okay";
+};
+
 /* Verdin PCIE_1 */
 &pcie {
 	vpcie-supply = <&reg_pcie>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
index 42ed44a11711..09733fea036d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
@@ -4,6 +4,18 @@
  */
 
 / {
+	native-hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "X37";
+		type = "a";
+
+		port {
+			native_hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	reg_eth2phy: regulator-eth2phy {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -103,6 +115,27 @@ &gpio_expander_21 {
 	vcc-supply = <&reg_1p8v>;
 };
 
+/* Verdin HDMI_1 */
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&native_hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
 /* Current measurement into module VCC */
 &hwmon {
 	status = "okay";
@@ -141,6 +174,10 @@ &i2c5 {
 	status = "okay";
 };
 
+&lcdif3 {
+	status = "okay";
+};
+
 /* Verdin PCIE_1 */
 &pcie {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-mallow.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-mallow.dtsi
index 1d15f7449c58..3a40338cf2d8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-mallow.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-mallow.dtsi
@@ -11,6 +11,18 @@
 #include <dt-bindings/leds/common.h>
 
 / {
+	native-hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "X14";
+		type = "a";
+
+		port {
+			native_hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -91,6 +103,27 @@ &flexcan2 {
 	status = "okay";
 };
 
+/* Verdin HDMI_1 */
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&native_hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
 /* Temperature sensor on Mallow */
 &hwmon_temp {
 	compatible = "ti,tmp1075";
@@ -117,6 +150,10 @@ &i2c5 {
 	status = "okay";
 };
 
+&lcdif3 {
+	status = "okay";
+};
+
 /* Verdin PCIE_1 */
 &pcie {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi.dtsi
index 91d597391b7c..2ee91f31e7f0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi.dtsi
@@ -41,8 +41,7 @@ &iomuxc {
 	pinctrl-0 = <&pinctrl_gpio1>, <&pinctrl_gpio2>,
 		    <&pinctrl_gpio3>, <&pinctrl_gpio4>,
 		    <&pinctrl_gpio7>, <&pinctrl_gpio8>,
-		    <&pinctrl_gpio_hog1>, <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>,
-		    <&pinctrl_hdmi_hog>;
+		    <&pinctrl_gpio_hog1>, <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>;
 };
 
 /*
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
index ef94f9a57e20..efcab00c0142 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi.dtsi
@@ -55,8 +55,7 @@ &iomuxc {
 	pinctrl-0 = <&pinctrl_gpio1>, <&pinctrl_gpio2>,
 		    <&pinctrl_gpio3>, <&pinctrl_gpio4>,
 		    <&pinctrl_gpio7>, <&pinctrl_gpio8>,
-		    <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>, <&pinctrl_gpio_hog4>,
-		    <&pinctrl_hdmi_hog>;
+		    <&pinctrl_gpio_hog2>, <&pinctrl_gpio_hog3>, <&pinctrl_gpio_hog4>;
 };
 
 /* On-module Bluetooth */
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
index a7b261ff3e4c..533b7fe218ce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
@@ -6,6 +6,18 @@
 #include <dt-bindings/leds/common.h>
 
 / {
+	native-hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "J15";
+		type = "a";
+
+		port {
+			native_hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	/* Carrier Board Supply +V1.8 */
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
@@ -105,6 +117,27 @@ &gpio4 {
 	pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
 };
 
+/* Verdin HDMI_1 */
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&native_hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
 &hwmon_temp {
 	status = "okay";
 };
@@ -127,6 +160,10 @@ &i2c5 {
 	status = "okay";
 };
 
+&lcdif3 {
+	status = "okay";
+};
+
 /* Verdin PCIE_1 */
 &pcie {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index aef4bef4bccd..834236db86fe 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -457,6 +457,13 @@ &gpio4 {
 			  "SODIMM_44";
 };
 
+/* Verdin HDMI_1 */
+&hdmi_tx {
+	ddc-i2c-bus = <&i2c5>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+};
+
 /* On-module I2C */
 &i2c1 {
 	clock-frequency = <400000>;
@@ -1117,10 +1124,10 @@ pinctrl_gpio_keys: gpiokeysgrp {
 			<MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00		0x1c4>;	/* SODIMM 252 */
 	};
 
-	pinctrl_hdmi_hog: hdmihoggrp {
+	pinctrl_hdmi: hdmigrp {
 		fsl,pins =
-			<MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC	0x40000019>,	/* SODIMM 63 */
-			<MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD	0x40000019>;	/* SODIMM 61 */
+			<MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC	0x140>,	/* SODIMM 63 */
+			<MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD	0x180>;	/* SODIMM 61 */
 	};
 
 	/* On-module I2C */
-- 
2.39.2


