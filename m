Return-Path: <linux-kernel+bounces-228736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0CF916642
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053001F23F62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14926155310;
	Tue, 25 Jun 2024 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gTePldrC"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90461494D7;
	Tue, 25 Jun 2024 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315195; cv=none; b=sbeH5MHdqVWrlZVjX53RVNZxWIiAqu6NdxGMsWANSY+trKyGbcpj4yQzVf/jFhtNCy7WTy0kG/Q+Cn/UQkIuoRbtrYlIQ2HYjIftrloVLUTmo7tPYr6eqIQpb1mAHmJAki02D7xO9aN0ETiRQsWykbDpNxQdJceZaeuisoSSfXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315195; c=relaxed/simple;
	bh=MvtQ+84AKzbgsFqj3GNLttS0ZGRzKYi4zWa1J2fKuHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnKoRZoCs6++g/s4Wx+53JknwgmOICbTTh/yo38IvkVzMVsJe9DBerxP7/3hOAb0GS/jNm+OU7HEg2S+L5yxSDk5LZna/bGSspooylz7O8kRVscvzVBviNFoKPxkdwS/byiDbUv9bJuNSZYGf0LvZGjFErdZ1UZQK2Yz7X70wAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gTePldrC; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45PBX7j7012306;
	Tue, 25 Jun 2024 06:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719315187;
	bh=eRaQo3ELjrKJ5mLwXuRzoSSiXpiZKoHYL6P4QL1pluk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gTePldrCk3Zex7XSF+DjwV+U2UuQyjI2qwpuRJfkLceJN1Npk7S8D8uWhOgYOIZrE
	 fPA/01Ei1oCYrU0aYQNzp/LoeRXCiJc3LXC12NhW2Lg38AcqJA4D63/DtYXBo7zNxO
	 lvyilAMT3FHhfVF6o8PQzqhFoeDTRWPhWUkZ4PTc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45PBX7Z4044133
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 06:33:07 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 06:33:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 06:33:06 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.248])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45PBX5CR099581;
	Tue, 25 Jun 2024 06:33:06 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <j-luthra@ti.com>, <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-j722s-evm: Enable analog audio support
Date: Tue, 25 Jun 2024 17:03:01 +0530
Message-ID: <20240625113301.217369-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240625113301.217369-1-j-choudhary@ti.com>
References: <20240625113301.217369-1-j-choudhary@ti.com>
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

[0]: <https://www.ti.com/lit/gpn/TLV320AIC3106>

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 109 ++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index 253b02f0437d..facf61957af5 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -107,6 +107,15 @@ vdd_sd_dv: regulator-TLV71033 {
 			 <3300000 0x1>;
 	};
 
+	vsys_io_3v3: regulator-vsys-io-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_io_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vsys_io_1v8: regulator-vsys-io-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_io_1v8";
@@ -124,6 +133,35 @@ vsys_io_1v2: regulator-vsys-io-1v2 {
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
@@ -210,6 +248,21 @@ main_usb1_pins_default: main-usb1-default-pins {
 			J722S_IOPAD(0x0258, PIN_INPUT, 0) /* (B27) USB1_DRVVBUS */
 		>;
 	};
+
+	main_mcasp1_pins_default: main-mcasp1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0090, PIN_INPUT, 2) /* (P27) GPMC0_BE0n_CLE.MCASP1_ACLKX */
+			J722S_IOPAD(0x0098, PIN_INPUT, 2) /* (V21) GPMC0_WAIT0.MCASP1_AFSX */
+			J722S_IOPAD(0x008c, PIN_OUTPUT, 2) /* (N23) GPMC0_WEn.MCASP1_AXR0 */
+			J722S_IOPAD(0x0084, PIN_INPUT, 2) /* (N21) GPMC0_ADVn_ALE.MCASP1_AXR2 */
+		>;
+	};
+
+	audio_ext_refclk1_pins_default: audio-ext-refclk1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x00a0, PIN_OUTPUT, 1) /* (N24) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
+		>;
+	};
 };
 
 &cpsw3g {
@@ -285,6 +338,12 @@ &wkup_i2c0 {
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
@@ -316,6 +375,41 @@ p05-hog {
 			gpios = <5 GPIO_ACTIVE_HIGH>;
 			output-high;
 		};
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
+		AVDD-supply = <&vsys_io_3v3>;
+		IOVDD-supply = <&vsys_io_3v3>;
+		DRVDD-supply = <&vsys_io_3v3>;
+		DVDD-supply = <&vsys_io_1v8>;
 	};
 };
 
@@ -457,3 +551,18 @@ &usb1 {
 	phys = <&serdes0_usb_link>;
 	phy-names = "cdns3,usb3-phy";
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
-- 
2.25.1


