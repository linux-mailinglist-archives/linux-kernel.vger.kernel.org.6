Return-Path: <linux-kernel+bounces-377490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531679ABF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A97DB26045
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAF215B546;
	Wed, 23 Oct 2024 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h6w16wQ6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E915A86A;
	Wed, 23 Oct 2024 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666703; cv=none; b=reUPfvbo6DkMj54v4sG/3emWxhRIv46aQgxOyfl+qPoeEMqaT2nLBtbg4c1062zDxohkYmsiTCH3Ry0i+g4NojpoAFaGItjzApmnjiWjlbmxfamWDhp2x4Qr4frabl24V7u0i6MB7K1qDXMfX/zhCowbdFyW6o2KS/rafIw3oOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666703; c=relaxed/simple;
	bh=qUvWem0cL99Oxp7SbUsQAAdeviSA7ZzljlX6DsjUkUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RTVZrpfqVBRGxgjLEljGhaKzmXcTa6kBxWgjIDI8GYPq8K3K0/etLHh+tB0y2/iMUZlnvEZOtPvHczGK//gLg3wpUYPPOLq2ensrirH5SAWo+4zr+OInrtmcuIBi1v/PuR3NeULYVf0euv7Yx+G6gu0iOrAO1nFXK3QxEXXCmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h6w16wQ6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N6wHXw056561;
	Wed, 23 Oct 2024 01:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729666697;
	bh=bQbLm1veHZyG/McZunNy0D7mhwxtuZOcgnOezuckP58=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=h6w16wQ6U3jdq2kRn7Jn5Hyp8rwH546DKrW7Q1muK0bj1yeBDiRU59UtYJ6leBxjP
	 DyhTPX4xgzvxtNBTyejlHNyVCHgdw/HyAExdlvT3OZuKO9dnevv5r3q7s7535aOVnZ
	 XCJ4wymt0NGxS94vjHj59duEDP12YZylUkvOXN3w=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6wHtA026888;
	Wed, 23 Oct 2024 01:58:17 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 01:58:16 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 01:58:16 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vWUV129058;
	Wed, 23 Oct 2024 01:58:11 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 23 Oct 2024 12:27:22 +0530
Subject: [PATCH v5 08/12] arm64: dts: ti: k3-j721s2-evm*: Add bootph-*
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241023-b4-upstream-bootph-all-v5-8-a974d06370ab@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729666652; l=5042;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=qUvWem0cL99Oxp7SbUsQAAdeviSA7ZzljlX6DsjUkUg=;
 b=Cf5t3SnQkimaZBJoSXyz07O2RSoBuZ9pXxAvZBGNKQ4ey5/461oq6Q0KuNT9svw3zlXi5/bL5
 W4p8znVwPADAyRK1XJBfWxIzSS2IH+DSQTrYTqGjFeuAiJo2R5Dv0ah
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Adds bootph-* properties to the leaf nodes to enable bootloaders to
utilise them.

Following adds bootph-* to:
- pmic regulator for enabling AVS Support
- main_uart8, mcu_uart0(DM), wkup_uart0(TIFS) for Traces
- mmc0, mmc1, usb0, ospi0, ospi1 for enabling various bootmodes.

Reviewed-by: Andrew Davis <afd@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---

Notes:
    R-by picked up in v3 ( Andrew )

 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi           |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index c5a0b7cbb14f..e2fc1288ed07 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -138,6 +138,7 @@ J721S2_IOPAD(0x044, PIN_OUTPUT, 14) /* (Y26) MCASP0_AXR1.UART8_RTSn */
 			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
 			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
 		>;
+		bootph-all;
 	};
 
 	main_i2c3_pins_default: main-i2c3-default-pins {
@@ -165,6 +166,7 @@ J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
 			J721S2_IOPAD(0x0f0, PIN_INPUT, 0) /* (R22) MMC1_DAT3 */
 			J721S2_IOPAD(0x0e8, PIN_INPUT, 8) /* (AE25) TIMER_IO0.MMC1_SDCD */
 		>;
+		bootph-all;
 	};
 
 	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
@@ -177,6 +179,7 @@ main_usbss0_pins_default: main-usbss0-default-pins {
 		pinctrl-single,pins = <
 			J721S2_IOPAD(0x0ec, PIN_OUTPUT, 6) /* (AG25) TIMER_IO1.USB0_DRVVBUS */
 		>;
+		bootph-all;
 	};
 
 	main_mcan3_pins_default: main-mcan3-default-pins {
@@ -200,6 +203,7 @@ wkup_uart0_pins_default: wkup-uart0-default-pins {
 			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
 			J721S2_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	mcu_uart0_pins_default: mcu-uart0-default-pins {
@@ -209,6 +213,7 @@ J721S2_WKUP_IOPAD(0x094, PIN_OUTPUT, 0) /* (D25) WKUP_GPIO0_15.MCU_UART0_RTSn */
 			J721S2_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C24) WKUP_GPIO0_13.MCU_UART0_RXD */
 			J721S2_WKUP_IOPAD(0x088, PIN_OUTPUT, 0) /* (C25) WKUP_GPIO0_12.MCU_UART0_TXD */
 		>;
+		bootph-all;
 	};
 
 	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
@@ -301,6 +306,7 @@ J721S2_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (A20) MCU_OSPI1_D3 */
 			J721S2_WKUP_IOPAD(0x010, PIN_INPUT, 0) /* (B19) MCU_OSPI1_DQS */
 			J721S2_WKUP_IOPAD(0x00c, PIN_INPUT, 0) /* (B20) MCU_OSPI1_LBCLKO */
 		>;
+		bootph-all;
 	};
 };
 
@@ -316,12 +322,14 @@ &wkup_uart0 {
 	status = "reserved";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_uart0_pins_default>;
+	bootph-all;
 };
 
 &mcu_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
+	bootph-all;
 };
 
 &main_uart8 {
@@ -330,6 +338,7 @@ &main_uart8 {
 	pinctrl-0 = <&main_uart8_pins_default>;
 	/* Shared with TFA on this platform */
 	power-domains = <&k3_pds 357 TI_SCI_PD_SHARED>;
+	bootph-all;
 };
 
 &main_i2c0 {
@@ -383,6 +392,7 @@ &main_sdhci0 {
 	/* eMMC */
 	status = "okay";
 	non-removable;
+	bootph-all;
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
@@ -395,6 +405,7 @@ &main_sdhci1 {
 	disable-wp;
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vdd_sd_dv>;
+	bootph-all;
 };
 
 &mcu_cpsw {
@@ -444,6 +455,7 @@ &usbss0 {
 	status = "okay";
 	pinctrl-0 = <&main_usbss0_pins_default>;
 	pinctrl-names = "default";
+	bootph-all;
 	ti,vbus-divider;
 	ti,usb2-only;
 };
@@ -451,6 +463,7 @@ &usbss0 {
 &usb0 {
 	dr_mode = "otg";
 	maximum-speed = "high-speed";
+	bootph-all;
 };
 
 &ospi1 {
@@ -464,6 +477,7 @@ flash@0 {
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
 		spi-max-frequency = <40000000>;
+		bootph-all;
 		cdns,tshsl-ns = <60>;
 		cdns,tsd2d-ns = <60>;
 		cdns,tchsh-ns = <60>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index 89252e4a5f1b..b3a0385ed3d8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -170,6 +170,7 @@ J721S2_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (F20) MCU_OSPI0_D7 */
 			J721S2_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (E18) MCU_OSPI0_DQS */
 			J721S2_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (E20) MCU_OSPI0_LBCLKO */
 		>;
+		bootph-all;
 	};
 };
 
@@ -188,6 +189,7 @@ wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 			J721S2_WKUP_IOPAD(0x98, PIN_INPUT, 0) /* (H24) WKUP_I2C0_SCL */
 			J721S2_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (H27) WKUP_I2C0_SDA */
 		>;
+		bootph-pre-ram;
 	};
 };
 
@@ -440,6 +442,7 @@ flash@0 {
 		spi-tx-bus-width = <8>;
 		spi-rx-bus-width = <8>;
 		spi-max-frequency = <25000000>;
+		bootph-all;
 		cdns,tshsl-ns = <60>;
 		cdns,tsd2d-ns = <60>;
 		cdns,tchsh-ns = <60>;

-- 
2.46.0


