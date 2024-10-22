Return-Path: <linux-kernel+bounces-376323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6A9AA32D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253E7283EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016A71A01C4;
	Tue, 22 Oct 2024 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ykkxO6Ia"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837C19E96B;
	Tue, 22 Oct 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603863; cv=none; b=NMOo2lmMkv+FtVAEgpgUsFCH6YHllblc5dry8xig9Y+Eb2nhtHSmih1A4/rPFvIr2jJP+AgTDBCbB1Si7eg7GgRp9fSp1k+AD2FO+fgdWr8HV2kkKqsGpRGdYI/Q60W4fpP8WLvq6S0R9kw5i8dBdr0DcNSrPFaV31WBKdoTkk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603863; c=relaxed/simple;
	bh=B605ie6hbhEiWejaomklCq8vZH9CuMrPEgMkotzuKSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hxayVu2dw8Gli/BQJr3RyAaZQGYcpiqGws2SHgaiouk1HopgwRXYVLkxm0iRWUw/VcOhZY196h0WNTmxbNtPojD6KHn8a010g70nCCcyZsBueF5k2ME4RZ/4HnoEb1OIunkfgvrdvqNbX1uclhieOqwxQtBDiCjr3LX2CfYEA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ykkxO6Ia; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1425588FBB;
	Tue, 22 Oct 2024 15:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729603858;
	bh=PDWpVpTNNenhke5RRZTjdnNQjYKMF7ls8UYnaSLtbng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ykkxO6Ia01mbCx5ueb8XH2pzudj6GNKkZf6xcAUm9pwHJ+npaRwmSorNFFeUjN3T2
	 G8c3pTITWz9+TdeaXxOsuN0MVDAZqXVWAi2A4LIgkJ+dJWERDCOMqGMKf+VU/Ojn+v
	 e72puyEL7jkHQz4ITD5HizyzOqj0WpUQb3ASmbhx1Q3uvx5jA2MNZ/zIc7JQPlnWXm
	 6Vch/nR3agcmCgnQXSh2hwNMxJkWddPIBapqLbqO8Ini6tzPpxzlOsdQSJUoEi7DM0
	 yy9GlfTh/n4StRZf8ru6Lx8ci6LLu/v5/3p9Dw9r5bIXlbUjf5LCNCmLfJDtwAs9Rp
	 4+uc+0SSR/dDQ==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v10 4/4] ARM: dts: mxs: Add descriptions for imx287 based btt3-[012] devices
Date: Tue, 22 Oct 2024 15:30:40 +0200
Message-Id: <20241022133040.686562-4-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241022133040.686562-1-lukma@denx.de>
References: <20241022133040.686562-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
some extend similar to already upstreamed XEA devices, hence are
using common imx28-lwe.dtsi file.

New, imx28-btt3.dtsi has been added to embrace common DTS
properties for different HW revisions for this device.

As a result - changes introduced in imx28-btt3-[012].dts are
minimal.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- Rename dts file from btt3-[012] to imx28-btt3-[012] to match current
  linux kernel naming convention
- Remove 'wlf,wm8974' from compatible for codec@1a

Changes for v3:
- Keep alphabethical order for Makefile entries

Changes for v4:
- Change compatible for btt3 board (to 'lwn,imx28-btt3')

Changes for v5:
- Combine patch, which adds btt3-[012] with one adding board entry to
  fsl.yaml

Changes for v6:
- Make the patch series for adding entry in fsl.yaml and btt3

Changes for v7:
- Use "panel" property as suggested by the community
- Use panel-timing to specify the display parameters
- Update subject line with correct tags

Changes for v8:
- Use GPIO_ACTIVE_HIGH instead of '0'
- Add the comment regarding mac address specification
- Remove superfluous comment
- Change wifi-en-pin node name

Changes for v9:
- Remove not used 'pm-ignore-notify'
- Add display names for 'panel-dpi' compatible to avoid Schema warnings

Changes for v10:
- Drop new line with panel-timing definitions
- Add new lines with 'sound' node
- Change 'codec' to 'audio-codec'
- Change order of properties for saif1 node
---
 arch/arm/boot/dts/nxp/mxs/Makefile         |   3 +
 arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts |  12 +
 arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts |   8 +
 arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts |  39 +++
 arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi  | 313 +++++++++++++++++++++
 5 files changed, 375 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
 create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi

diff --git a/arch/arm/boot/dts/nxp/mxs/Makefile b/arch/arm/boot/dts/nxp/mxs/Makefile
index a430d04f9c69..96dd31ea19ba 100644
--- a/arch/arm/boot/dts/nxp/mxs/Makefile
+++ b/arch/arm/boot/dts/nxp/mxs/Makefile
@@ -8,6 +8,9 @@ dtb-$(CONFIG_ARCH_MXS) += \
 	imx28-apf28.dtb \
 	imx28-apf28dev.dtb \
 	imx28-apx4devkit.dtb \
+	imx28-btt3-0.dtb \
+	imx28-btt3-1.dtb \
+	imx28-btt3-2.dtb \
 	imx28-cfa10036.dtb \
 	imx28-cfa10037.dtb \
 	imx28-cfa10049.dtb \
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
new file mode 100644
index 000000000000..6ac46e4b21bb
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include "imx28-btt3.dtsi"
+
+&hog_pins_rev {
+	fsl,pull-up = <MXS_PULL_ENABLE>;
+};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
new file mode 100644
index 000000000000..213fe931c58b
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include "imx28-btt3.dtsi"
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
new file mode 100644
index 000000000000..4bccd784d065
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+
+/dts-v1/;
+#include "imx28-btt3.dtsi"
+
+/ {
+	panel {
+		compatible = "powertip,st7272", "panel-dpi";
+		power-supply = <&reg_3v3>;
+		width-mm = <70>;
+		height-mm = <52>;
+
+		panel-timing {
+			clock-frequency = <6500000>;
+			hactive = <320>;
+			vactive = <240>;
+			hfront-porch = <20>;
+			hback-porch = <68>;
+			hsync-len = <30>;
+			vfront-porch = <4>;
+			vback-porch = <14>;
+			vsync-len = <4>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi
new file mode 100644
index 000000000000..2c52e67e5c14
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ */
+/dts-v1/;
+#include "imx28-lwe.dtsi"
+
+/ {
+	model = "BTT3";
+
+	compatible = "lwn,imx28-btt3", "fsl,imx28";
+
+	chosen {
+	       bootargs = "root=/dev/mmcblk0p2 rootfstype=ext4 ro rootwait console=ttyAMA0,115200 panic=1 quiet";
+	};
+
+	memory@40000000 {
+		reg = <0x40000000 0x10000000>;
+		device_type = "memory";
+	};
+
+	panel {
+		compatible = "powertip,hx8238a", "panel-dpi";
+		power-supply = <&reg_3v3>;
+		width-mm = <70>;
+		height-mm = <52>;
+
+		panel-timing {
+			clock-frequency = <6500000>;
+			hactive = <320>;
+			vactive = <240>;
+			hfront-porch = <20>;
+			hback-porch = <38>;
+			hsync-len = <30>;
+			vfront-porch = <4>;
+			vback-porch = <14>;
+			vsync-len = <4>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <0>;
+			pixelclk-active = <1>;
+		};
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
+
+	poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio0 24 GPIO_ACTIVE_HIGH>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "BTTC Audio";
+		simple-audio-card,widgets = "Speaker", "BTTC Speaker";
+		simple-audio-card,routing = "BTTC Speaker", "SPKOUTN", "BTTC Speaker", "SPKOUTP";
+
+		simple-audio-card,dai-link@0 {
+			format = "left_j";
+			bitclock-master = <&dai0_master>;
+			frame-master = <&dai0_master>;
+			mclk-fs = <256>;
+
+			dai0_master: cpu {
+				sound-dai = <&saif0>;
+			};
+
+			codec {
+				sound-dai = <&wm89xx>;
+				clocks = <&saif0>;
+			};
+		};
+	};
+
+	wifi_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_en_pin_bttc>;
+		reset-gpios = <&gpio0 27 GPIO_ACTIVE_LOW>;
+		/* W1-163 needs 60us for WL_EN to be low and */
+		/* 150ms after high before downloading FW is possible */
+		post-power-on-delay-ms = <200>;
+		power-off-delay-us = <100>;
+	};
+};
+
+&auart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&auart0_2pins_a>;
+	status = "okay";
+};
+
+&auart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&auart3_pins_a>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&i2c0 {
+	wm89xx: audio-codec@1a {
+		compatible = "wlf,wm8940";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+	};
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcdif_24bit_pins_a>, <&lcdif_sync_pins_bttc>,
+		    <&lcdif_reset_pins_bttc>;
+	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&mac0 {
+	clocks = <&clks 57>, <&clks 57>, <&clks 64>;
+	clock-names = "ipg", "ahb", "enet_out";
+	phy-handle = <&mac0_phy>;
+	phy-mode = "rmii";
+	phy-supply = <&reg_3v3>;
+	/*
+	 * This MAC address is adjusted during production.
+	 * Value specified below is used as a fallback during recovery.
+	 */
+	local-mac-address = [ 00 11 B8 00 BF 8A ];
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		mac0_phy: ethernet-phy@0 {
+			/* LAN8720Ai - PHY ID */
+			compatible = "ethernet-phy-id0007.c0f0","ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			smsc,disable-energy-detect;
+			max-speed = <100>;
+			reset-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <1000>;
+			reset-deassert-us = <1000>;
+		};
+	};
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hog_pins_a>, <&hog_pins_rev>;
+
+	hog_pins_a: hog@0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_GPMI_RDY2__GPIO_0_22
+			MX28_PAD_GPMI_RDY3__GPIO_0_23
+			MX28_PAD_GPMI_RDN__GPIO_0_24
+			MX28_PAD_LCD_VSYNC__GPIO_1_28
+			MX28_PAD_SSP2_SS1__GPIO_2_20
+			MX28_PAD_SSP2_SS2__GPIO_2_21
+			MX28_PAD_AUART2_CTS__GPIO_3_10
+			MX28_PAD_AUART2_RTS__GPIO_3_11
+			MX28_PAD_GPMI_WRN__GPIO_0_25
+			MX28_PAD_ENET0_RXD2__GPIO_4_9
+			MX28_PAD_ENET0_TXD2__GPIO_4_11
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+
+	hog_pins_rev: hog@1 {
+		reg = <1>;
+		fsl,pinmux-ids = <
+			MX28_PAD_ENET0_RXD3__GPIO_4_10
+			MX28_PAD_ENET0_TX_CLK__GPIO_4_5
+			MX28_PAD_ENET0_COL__GPIO_4_14
+			MX28_PAD_ENET0_CRS__GPIO_4_15
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+
+	keypad_pins_bttc: keypad-bttc@0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_GPMI_D00__GPIO_0_0
+			MX28_PAD_AUART0_CTS__GPIO_3_2
+			MX28_PAD_AUART0_RTS__GPIO_3_3
+			MX28_PAD_GPMI_D03__GPIO_0_3
+			MX28_PAD_GPMI_D04__GPIO_0_4
+			MX28_PAD_GPMI_D05__GPIO_0_5
+			MX28_PAD_GPMI_D06__GPIO_0_6
+			MX28_PAD_GPMI_D07__GPIO_0_7
+			MX28_PAD_GPMI_CE1N__GPIO_0_17
+			MX28_PAD_GPMI_CE2N__GPIO_0_18
+			MX28_PAD_GPMI_CE3N__GPIO_0_19
+			MX28_PAD_GPMI_RDY0__GPIO_0_20
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+
+	lcdif_sync_pins_bttc: lcdif-bttc@0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_LCD_DOTCLK__LCD_DOTCLK
+			MX28_PAD_LCD_ENABLE__LCD_ENABLE
+			MX28_PAD_LCD_HSYNC__LCD_HSYNC
+			MX28_PAD_LCD_RD_E__LCD_VSYNC
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_DISABLE>;
+	};
+
+	lcdif_reset_pins_bttc: lcdif-bttc@1 {
+		reg = <1>;
+		fsl,pinmux-ids = <
+			MX28_PAD_LCD_RESET__GPIO_3_30
+		>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_ENABLE>;
+	};
+
+	ssp1_sdio_pins_a: ssp1-sdio@0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_SSP1_DATA0__SSP1_D0
+			MX28_PAD_GPMI_D01__SSP1_D1
+			MX28_PAD_GPMI_D02__SSP1_D2
+			MX28_PAD_SSP1_DATA3__SSP1_D3
+			MX28_PAD_SSP1_CMD__SSP1_CMD
+			MX28_PAD_SSP1_SCK__SSP1_SCK
+		>;
+		fsl,drive-strength = <MXS_DRIVE_8mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_ENABLE>;
+	};
+
+	wifi_en_pin_bttc: wifi-en-pin@0 {
+		reg = <0>;
+		fsl,pinmux-ids = <
+			MX28_PAD_GPMI_CLE__GPIO_0_27
+		>;
+		fsl,drive-strength = <MXS_DRIVE_8mA>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+		fsl,pull-up = <MXS_PULL_ENABLE>;
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm3_pins_a>;
+	status = "okay";
+};
+
+&reg_usb_5v {
+	gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+};
+
+&saif0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&saif0_pins_a>;
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clks 53>;
+	assigned-clock-rates = <12000000>;
+	status = "okay";
+};
+
+&saif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&saif1_pins_a>;
+	#sound-dai-cells = <0>;
+	fsl,saif-master = <&saif0>;
+	status = "okay";
+};
+
+&ssp1 {
+	compatible = "fsl,imx28-mmc";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ssp1_sdio_pins_a>;
+	bus-width = <4>;
+	no-1-8-v;       /* force 3.3V VIO */
+	non-removable;
+	vmmc-supply = <&reg_3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	keep-power-in-suspend;
+	status = "okay";
+
+	wlan@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&ssp2 {
+	compatible = "fsl,imx28-spi";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>;
+	status = "okay";
+};
-- 
2.39.5


