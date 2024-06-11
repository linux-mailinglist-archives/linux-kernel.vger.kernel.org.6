Return-Path: <linux-kernel+bounces-209474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB081903673
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3D828A422
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99986175579;
	Tue, 11 Jun 2024 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Oo+S0u8W"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79E16F8EC;
	Tue, 11 Jun 2024 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094515; cv=none; b=g9rNJidMsh8FZu2j+pRnpvhVNRVK7br3GNActiXokggK3ga/lpQpCgnxwJlTJ8WmCRzMQJg4nlzpHrP+7nuimW3RntsYZeRsXT4WxXheAussRxO3l+YXkzNzV0+wV5IviMAUT9v1jw5YkHAoQOdLVEmju/3AsWgzCD7sgOppMoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094515; c=relaxed/simple;
	bh=9wfu9ULIvAQVA8zlI1u4jmyHSBhMau9KYUPmAlNR/1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uA6Lx/xvy7D/I5UErmfOET7KPhb29Sxj7MIEtcoQKwaGOSBjEoMyAC1OGSoVyQBgulxm4dHOLDH5cQqhBHiwxt7orCAu9a2gKwlggT221BNghmbCWYF+8benGkForf54QNjLv9c4tVINdZ+KI5LlGGUPxguAXYmukiqbYuazXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Oo+S0u8W; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45B8SMvD122465;
	Tue, 11 Jun 2024 03:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718094502;
	bh=yXqXojAPYeVrmMnZLU+Kz1unQf08/a8UgG8WDqDAolo=;
	h=From:To:CC:Subject:Date;
	b=Oo+S0u8WzxJPa2C7S2P5Hpx+9r5DEW7IaII6yycn9nXbZc0GgXTQCo0zAnyZDRpUP
	 /ngRRWYeB548QmFj4Cb1zTW3f3l5mLwGXqIhNvi4gbwgzMuZZ7PPfKeUVMVJ75XZbW
	 ghdCIkXqcmiL9suYIvp+W3nZ0jHR21lKxmL8uT1A=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45B8SMvF105975
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 03:28:22 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 03:28:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 03:28:21 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45B8SLYE025626;
	Tue, 11 Jun 2024 03:28:21 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <j-luthra@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable analog audio support
Date: Tue, 11 Jun 2024 13:58:19 +0530
Message-ID: <20240611082820.17442-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The audio support on J722S-EVM is using TLV320AIC3106[0] codec
connected to McASP1 serializers.

- Add the nodes for sound-card, audio codec and McASP1.
- Add hog for TRC_MUX_SEL to select between McASP and TRACE signals
- Add hogs for GPIO_AUD_RSTn and MCASP1_FET_SEL which is used to
  switch between HDMI audio and codec audio.
- Add pinmux for MCASP1 and AUDIO_EXT_REFCLK1.
- Add syscon node for audio_refclk1 to set the enable bit in
  CTRL_MMR reg and select the parent clock for the external clock.

[0]: <https://www.ti.com/lit/gpn/TLV320AIC3106>

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---

This patch depends upon the bcdma driver fix posted upstream:
<https://lore.kernel.org/all/20240607-bcdma_chan_cnt-v2-1-bf1a55529d91@ti.com/>

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 121 ++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index bf3c246d13d1..c040dcdebf88 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -105,6 +105,16 @@ vdd_sd_dv: regulator-TLV71033 {
 			 <3300000 0x1>;
 	};
 
+	vcc_3v3_aud: regulator-vcc3v3 {
+		/* Output of LM5140 */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vsys_io_1v8: regulator-vsys-io-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_io_1v8";
@@ -122,6 +132,35 @@ vsys_io_1v2: regulator-vsys-io-1v2 {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	codec_audio: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "J722S-EVM";
+		simple-audio-card,widgets =
+			"Headphone",	"Headphone Jack",
+			"Line",		"Line In",
+			"Microphone",	"Microphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack",	"HPLOUT",
+			"Headphone Jack",	"HPROUT",
+			"LINE1L",		"Line In",
+			"LINE1R",		"Line In",
+			"MIC3R",		"Microphone Jack",
+			"Microphone Jack",	"Mic Bias";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+		};
+
+		sound_master: simple-audio-card,codec {
+			sound-dai = <&tlv320aic3106>;
+			clocks = <&audio_refclk1>;
+		};
+	};
 };
 
 &main_pmx0 {
@@ -202,6 +241,21 @@ J722S_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AG26) RGMII1_TXC */
 			J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
 		>;
 	};
+
+	main_mcasp1_pins_default: main-mcasp1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0090, PIN_INPUT, 2) /* (U24) GPMC0_BE0n_CLE.MCASP1_ACLKX */
+			J722S_IOPAD(0x0098, PIN_INPUT, 2) /* (AA24) GPMC0_WAIT0.MCASP1_AFSX */
+			J722S_IOPAD(0x008c, PIN_OUTPUT, 2) /* (T25) GPMC0_WEn.MCASP1_AXR0 */
+			J722S_IOPAD(0x0084, PIN_INPUT, 2) /* (R25) GPMC0_ADVn_ALE.MCASP1_AXR2 */
+		>;
+	};
+
+	audio_ext_refclk1_pins_default: audi-ext-refclk1-pins-default {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0a0, PIN_OUTPUT, 1) /* (N24) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
+		>;
+	};
 };
 
 &cpsw3g {
@@ -277,6 +331,12 @@ &wkup_i2c0 {
 	bootph-all;
 };
 
+&k3_clks {
+	/* Configure AUDIO_EXT_REFCLK1 pin as output */
+	pinctrl-names = "default";
+	pinctrl-0 = <&audio_ext_refclk1_pins_default>;
+};
+
 &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
@@ -301,6 +361,41 @@ exp1: gpio@23 {
 				  "PCIe0_1L_RC_RSTz", "PCIe0_1L_PRSNT#",
 				  "ENET1_EXP_SPARE2", "ENET1_EXP_PWRDN",
 				  "PD_I2ENET1_I2CMUX_SELC_IRQ", "ENET1_EXP_RESETZ";
+
+		p01_hog: p01-hog {
+			/* P01 - TRC_MUX_SEL */
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_HIGH>;
+			output-low;
+			line-name = "TRC_MUX_SEL";
+		};
+
+		p02_hog: p02-hog {
+			/* P02 - MCASP1_FET_SEL */
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "MCASP1_FET_SEL";
+		};
+
+		p13_hog: p13-hog {
+			/* P13 - GPIO_AUD_RSTn */
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "GPIO_AUD_RSTn";
+		};
+	};
+
+	tlv320aic3106: audio-codec@1b {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x1b>;
+		ai3x-micbias-vg = <1>;  /* 2.0V */
+		AVDD-supply = <&vcc_3v3_aud>;
+		IOVDD-supply = <&vcc_3v3_aud>;
+		DRVDD-supply = <&vcc_3v3_aud>;
+		DVDD-supply = <&vsys_io_1v8>;
 	};
 };
 
@@ -384,3 +479,29 @@ &sdhci1 {
 	status = "okay";
 	bootph-all;
 };
+
+&mcasp1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcasp1_pins_default>;
+	op-mode = <0>; /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	serial-dir = < /* 0: INACTIVE, 1: TX, 2: RX */
+	       1 0 2 0
+	       0 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	>;
+};
+
+&main_conf {
+	audio_refclk1: clock@82e4 {
+		compatible = "ti,am62-audio-refclk";
+		reg = <0x82e4 0x4>;
+		clocks = <&k3_clks 157 18>;
+		assigned-clocks = <&k3_clks 157 18>;
+		assigned-clock-parents = <&k3_clks 157 33>;
+		#clock-cells = <0>;
+	};
+};
-- 
2.25.1


