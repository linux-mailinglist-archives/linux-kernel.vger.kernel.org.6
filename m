Return-Path: <linux-kernel+bounces-220807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A9490E768
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809021C212A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9400182889;
	Wed, 19 Jun 2024 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pMIgP16x"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6B38172D;
	Wed, 19 Jun 2024 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790788; cv=none; b=pYYooqOfzB/zMDBn+tGKdit0Tto4bOZBslhf5jApPVLcK+F4T8zhigib0MCSu288h+1qkSyR1NkyQ2U6O+H60kTs4EuOzbCmYhSSAuqwUUZuhqgsvdxT3UaHX9G3nnKVFPouUPED1HKeVD8gohwZE16GzZLQ2TStCieUZM4LCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790788; c=relaxed/simple;
	bh=hajIcvLDo8Fnj3EUCFVc8EoUmrz2jGGMr9Y87bra6dE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGg7mUP3YsKaH51oI3qCtnvFuniQrr68w4cyFhOthPIIVevp2BKcC0+cevCeca9qUrzAn/fuwCBGC/mxVWMVsNAE72nE9Rs+lliihyfU0ievyKumHpnGBpGw7apPJ7wqaxYTqSsUyzvvdW/Zao/SH7YTARDRsoESRqSolGF9ybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pMIgP16x; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45J9qxE9022323;
	Wed, 19 Jun 2024 04:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718790779;
	bh=MaBaxOxsrsFxyWqKO/Ghe6TGuy6uNhadyk/BiWEn9SA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pMIgP16x7pOAPesR4LdNX+CY/X5N21uHTDnNOYwqYpgmWf2oPjtilVoFPZ49wIjPQ
	 +T8F5tThPplnGfRlnZR1omWjO6xstHEOMfpD4XK47f1ACvOb3ueL1XnTHWkLErdNJA
	 irvsvcFveRcSPRn2ejmqxYzEtEB4FJVk5WU2XBPs=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45J9qx0O066819
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Jun 2024 04:52:59 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 04:52:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 04:52:59 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45J9qwcJ089961;
	Wed, 19 Jun 2024 04:52:58 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <j-luthra@ti.com>, <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j784s4-evm: Enable analog audio support
Date: Wed, 19 Jun 2024 15:22:53 +0530
Message-ID: <20240619095253.290552-4-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240619095253.290552-1-j-choudhary@ti.com>
References: <20240619095253.290552-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The audio support on J784S4-EVM is using PCM3168A[0] codec
connected to McASP0 serializers.

- Add the nodes for sound-card, audio codec, MAIN_I2C3 and
  McASP0.
- Add pinmux for I2C3, McASP0 and AUDIO_EXT_REFCLK1.
- Add necessary GPIO hogs to route the MAIN_I2C3 lines and
  McASP serializer.
- Add idle-state as 1 in mux1 to route McASP clock signals.

[0]: <https://www.ti.com/lit/gpn/pcm3168a>

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 112 +++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index a4a6efcce362..cb061986bd93 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -312,6 +312,20 @@ mux1: mux-controller {
 		compatible = "gpio-mux";
 		#mux-state-cells = <1>;
 		mux-gpios = <&exp2 14 GPIO_ACTIVE_HIGH>;
+		idle-state = <1>;
+	};
+
+	codec_audio: sound {
+		compatible = "ti,j7200-cpb-audio";
+		model = "j784s4-cpb";
+
+		ti,cpb-mcasp = <&mcasp0>;
+		ti,cpb-codec = <&pcm3168a_1>;
+
+		clocks = <&k3_clks 265 0>, <&k3_clks 265 1>,
+			 <&k3_clks 157 34>, <&k3_clks 157 63>;
+		clock-names = "cpb-mcasp-auxclk", "cpb-mcasp-auxclk-48000",
+			      "cpb-codec-scki", "cpb-codec-scki-48000";
 	};
 };
 
@@ -422,6 +436,28 @@ main_usbss0_pins_default: main-usbss0-default-pins {
 			J784S4_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AN37) TIMER_IO1.USB0_DRVVBUS */
 		>;
 	};
+
+	main_i2c3_pins_default: main-i2c3-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x064, PIN_INPUT, 13) /* (AF38) MCAN0_TX.I2C3_SCL */
+			J784S4_IOPAD(0x060, PIN_INPUT, 13) /* (AE36) MCASP2_AXR1.I2C3_SDA */
+		>;
+	};
+
+	mcasp0_pins_default: mcasp0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x038, PIN_OUTPUT_PULLDOWN, 1) /* (AK35) MCASP0_ACLKX */
+			J784S4_IOPAD(0x03c, PIN_OUTPUT_PULLDOWN, 1) /* (AK38) MCASP0_AFSX */
+			J784S4_IOPAD(0x07c, PIN_OUTPUT_PULLDOWN, 1) /* (AJ38) MCASP0_AXR3 */
+			J784S4_IOPAD(0x080, PIN_INPUT_PULLDOWN, 1) /* (AK34) MCASP0_AXR4 */
+		>;
+	};
+
+	audio_ext_refclk1_pins_default: audio-ext-refclk1-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x078, PIN_OUTPUT, 1) /* (AH37) MCAN2_RX.AUDIO_EXT_REFCLK1 */
+		>;
+	};
 };
 
 &wkup_pmx2 {
@@ -881,6 +917,14 @@ exp1: gpio@20 {
 				  "PCIE0_4L_RC_RSTZ", "PCIE0_4L_EP_RST_EN", "PCIE1_4L_PRSNT#",
 				  "PCIE0_4L_PRSNT#", "CDCI1_OE1/OE4", "CDCI1_OE2/OE3",
 				  "AUDIO_MUX_SEL", "EXP_MUX2", "EXP_MUX3", "GESI_EXP_PHY_RSTZ";
+
+		p12-hog {
+			/* P12 - AUDIO_MUX_SEL */
+			gpio-hog;
+			gpios = <12 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "AUDIO_MUX_SEL";
+		};
 	};
 
 	exp2: gpio@22 {
@@ -896,6 +940,22 @@ exp2: gpio@22 {
 				  "CANUART_MUX1_SEL1", "ENET1_EXP_PWRDN", "ENET1_EXP_RESETZ",
 				  "ENET1_I2CMUX_SEL", "ENET1_EXP_SPARE2", "ENET2_EXP_RESETZ",
 				  "USER_INPUT1", "USER_LED1", "USER_LED2";
+
+		p13-hog {
+			/* P13 - CANUART_MUX_SEL0 */
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "CANUART_MUX_SEL0";
+		};
+
+		p15-hog {
+			/* P15 - CANUART_MUX1_SEL1 */
+			gpio-hog;
+			gpios = <15 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "CANUART_MUX1_SEL1";
+		};
 	};
 };
 
@@ -1373,3 +1433,55 @@ &pcie0_rc {
 	phys = <&serdes1_pcie0_link>;
 	phy-names = "pcie-phy";
 };
+
+&k3_clks {
+	/* Confiure AUDIO_EXT_REFCLK2 pin as output */
+	pinctrl-names = "default";
+	pinctrl-0 = <&audio_ext_refclk1_pins_default>;
+};
+
+&main_i2c3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c3_pins_default>;
+	clock-frequency = <400000>;
+
+	exp3: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	pcm3168a_1: audio-codec@44 {
+		compatible = "ti,pcm3168a";
+		reg = <0x44>;
+		#sound-dai-cells = <1>;
+		reset-gpios = <&exp3 0 GPIO_ACTIVE_LOW>;
+		/* C_AUDIO_REFCLK2 -> RGMII6_RXC (W26) */
+		clocks = <&audio_refclk1>;
+		clock-names = "scki";
+		VDD1-supply = <&vsys_3v3>;
+		VDD2-supply = <&vsys_3v3>;
+		VCCAD1-supply = <&vsys_5v0>;
+		VCCAD2-supply = <&vsys_5v0>;
+		VCCDA1-supply = <&vsys_5v0>;
+		VCCDA2-supply = <&vsys_5v0>;
+	};
+};
+
+&mcasp0 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcasp0_pins_default>;
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	auxclk-fs-ratio = <256>;
+	serial-dir = <	/* 0: INACTIVE, 1: TX, 2: RX */
+		0 0 0 1
+		2 0 0 0
+		0 0 0 0
+		0 0 0 0
+	>;
+};
-- 
2.25.1


