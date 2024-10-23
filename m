Return-Path: <linux-kernel+bounces-377492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FE49ABF90
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A1B1F24E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F4F1607AC;
	Wed, 23 Oct 2024 06:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hW2uZ8RX"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6415E5D4;
	Wed, 23 Oct 2024 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666710; cv=none; b=pWB1PLdbtrIMBF6hCwzqZEB5RE+0iiXnQTWK2FdrXAkTB6Rf8W8jfIaeKKwGXba6h74JL+x5gMpKcldTuX9dXiSUP7H3rY8covltgbSK52ILxQpChGFHlxql5+gbvnjVpz61Omd8oFhVT94mp7xvOR94Ng9M2ej6FOF6dhHdCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666710; c=relaxed/simple;
	bh=Q6AEzA9B//pSElsKicBAhYC55/J10Sfu9iiUgEPtJsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BNUAKvfxzqORaFpGDZqO4hLWSDcc+aev4ApQe9yByfA5zlyHeUcGL8lh+1qru/3+xn9p/DvaoGkN0fUqFYmKT6ebGkMmxYK8bskAdPbFrYdBnYsYhc9+CPq14Jnmvyu5Qq49WBM5Cs/Sv5uU6Jse5WH9PNa5HUUp2M+oheYusuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hW2uZ8RX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N6wMsx031321;
	Wed, 23 Oct 2024 01:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729666702;
	bh=fBO/za3Uq1MZ+jIGWCcAXFtTCNYO5DoBbYXi4UG8+E8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=hW2uZ8RXQ5ZALSgSD28GKpAQUYDrt+Y0KyDZ0N+FFb2mncRWiEh/Je3eqjPMWkGN3
	 yciDNVsBrBz0TOoASXkRV7kIVfVnUFJpeH1Grjf4oQTtBmEzOdCa0JPQyXfZs3Z9Tz
	 rkHGGEHQwvjuDFP+7qTBPVCroFmkR9IgoZETtZCo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49N6wMOi068924
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 01:58:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 01:58:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 01:58:22 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vWUW129058;
	Wed, 23 Oct 2024 01:58:17 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 23 Oct 2024 12:27:23 +0530
Subject: [PATCH v5 09/12] arm64: dts: ti: k3-am68-sk*: Add bootph-*
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241023-b4-upstream-bootph-all-v5-9-a974d06370ab@ti.com>
References: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
In-Reply-To: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis
	<afd@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729666652; l=3843;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=Q6AEzA9B//pSElsKicBAhYC55/J10Sfu9iiUgEPtJsE=;
 b=hOkNXIYTCsaHHCajd1Kc7vVAZx0TG5fNc2yYXpWx35ZehGwzKonrSvxGSdC/ITC1pTh9lCNIP
 9dVfHCGMKIQCSUfELDs6S4G+4KiTjCvfj8YTtSKTA16Gyvbv5K6qSD+
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Adds bootph-* properties to the leaf nodes to enable bootloaders to
utilise them.

Following adds bootph-* to:
- main_uart8, mcu_uart0(DM), wkup_uart0(TIFS) for Traces
- mmc1, ospi0 for enabling various bootmodes.
- eeprom for board detection

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---

Notes:
    R-by picked up in v4 ( Udit )

 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi       | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index d5ceab79536c..11522b36e0ce 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -184,6 +184,7 @@ main_uart8_pins_default: main-uart8-default-pins {
 			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
 			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
 		>;
+		bootph-all;
 	};
 
 	main_i2c0_pins_default: main-i2c0-default-pins {
@@ -211,6 +212,7 @@ J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
 			J721S2_IOPAD(0x0f0, PIN_INPUT, 0) /* (R22) MMC1_DAT3 */
 			J721S2_IOPAD(0x0e8, PIN_INPUT, 8) /* (AE25) TIMER_IO0.MMC1_SDCD */
 		>;
+		bootph-all;
 	};
 
 	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
@@ -313,6 +315,7 @@ J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (F28) WKUP_GPIO0_7.WKUP_UART0_RTSn */
 			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
 			J721S2_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
@@ -372,6 +375,7 @@ mcu_uart0_pins_default: mcu-uart0-default-pins {
 			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C24) WKUP_GPIO0_13.MCU_UART0_RXD */
 			J721S2_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (C25) WKUP_GPIO0_12.MCU_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	mcu_rpi_header_gpio0_pins0_default: mcu-rpi-header-gpio0-default-pins-0 {
@@ -413,6 +417,7 @@ &wkup_uart0 {
 	status = "reserved";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_uart0_pins_default>;
+	bootph-all;
 };
 
 &wkup_i2c0 {
@@ -495,6 +500,7 @@ &mcu_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
+	bootph-all;
 };
 
 &main_uart8 {
@@ -503,6 +509,7 @@ &main_uart8 {
 	pinctrl-0 = <&main_uart8_pins_default>;
 	/* Shared with TFA on this platform */
 	power-domains = <&k3_pds 357 TI_SCI_PD_SHARED>;
+	bootph-all;
 };
 
 &main_i2c0 {
@@ -597,6 +604,7 @@ &main_sdhci1 {
 	disable-wp;
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vdd_sd_dv>;
+	bootph-all;
 };
 
 &mcu_cpsw {
diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
index 5bc0d2fb4b8f..4ca2d4e2fb9b 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
@@ -156,6 +156,7 @@ wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 			J721S2_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (H24) WKUP_I2C0_SCL */
 			J721S2_WKUP_IOPAD(0x09c, PIN_INPUT, 0) /* (H27) WKUP_I2C0_SDA */
 		>;
+		bootph-all;
 	};
 };
 
@@ -169,6 +170,7 @@ eeprom@51 {
 		/* AT24C512C-MAHM-T */
 		compatible = "atmel,24c512";
 		reg = <0x51>;
+		bootph-all;
 	};
 };
 
@@ -190,7 +192,6 @@ flash@0 {
 		cdns,read-delay = <4>;
 
 		partitions {
-			bootph-all;
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -226,9 +227,9 @@ partition@800000 {
 			};
 
 			partition@3fc0000 {
-				bootph-pre-ram;
 				label = "ospi.phypattern";
 				reg = <0x3fc0000 0x40000>;
+				bootph-all;
 			};
 		};
 	};

-- 
2.46.0


