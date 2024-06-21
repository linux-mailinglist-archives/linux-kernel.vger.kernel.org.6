Return-Path: <linux-kernel+bounces-224281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6C912035
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E9AEB20DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E0916DEA9;
	Fri, 21 Jun 2024 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fT93Dhyb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEA1C02;
	Fri, 21 Jun 2024 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961070; cv=none; b=tKG60tLLRUEI+a1Pw/DW0M4toeJzZJzo3z1LblErQ82X1qAVAcmmS+zfxS4mp27GGEkiqSE98JZExY2L1LqkMfD1Kf0ORCTw9W1CzhdSPPi91zvOrevCW+qNJVi5fAtGveimcn1nWpIncVrowTsB/pmBRvvRE9l7cBxEhY7nzeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961070; c=relaxed/simple;
	bh=iuP3DH+e4EmqehqmdaTuZLo5wOug4ug6lvNPY83cpX4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nf7DESbOkMgekwhuc2RIGaQ3RlOKBzUdccTEVPgnCvi9JsbSS4a6qE5I+PzfYcN1GNkrIWqTjVmht8QmJea1EWMhSG88zLVmnQX5eWgJMoCq/5fLEnQUkKOGuiXSGfZCdC98JLp3Gmpb8Qr9uMYeDkJ7MpS31egxEs0l9DPYrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fT93Dhyb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45L9Axkm122671;
	Fri, 21 Jun 2024 04:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718961059;
	bh=lAnWK91X6Tnj0Yois+KoasbejiaNekW4O9mtRdXVNfw=;
	h=From:To:CC:Subject:Date;
	b=fT93DhybRqwXmvxoPuuYW7baUjJffl9im2KjgGEd9z1t7rnM9OWS+7PJ2v1iSOg6F
	 bXIpfQxQGeCDVHUwp9w9anfU36o5YvKhjJMqfcDvESnbOR6kcpqqyOZvHDU/w41V6L
	 HdnUPoRQPssG41plExr0aI5VJinwrTlfkEDqPheI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45L9AxOG079078
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 04:10:59 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 04:10:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 04:10:58 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45L9AwNe072612;
	Fri, 21 Jun 2024 04:10:58 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <b-kapoor@ti.com>, <jm@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j722s-evm: Add support for multiple CAN instances
Date: Fri, 21 Jun 2024 14:40:57 +0530
Message-ID: <20240621091057.1473010-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

CAN instances 0 and 1 in the mcu domain and 0 in the main domain are
brought on the evm through headers J5, J8 and J10 respectively. Thus,
add their respective transceiver's 0, 1 and 2 dt nodes as well as
add the required pinmux to add support for these CAN instances.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---

rebased to: next-20240620

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 74 +++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index 253b02f0437d..4fcfbade07c8 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -124,10 +124,39 @@ vsys_io_1v2: regulator-vsys-io-1v2 {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	transceiver0: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
+		standby-gpios = <&mcu_gpio0 12 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver1: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
+
+	transceiver2: can-phy2 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&exp1 17 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &main_pmx0 {
 
+	main_mcan0_pins_default: main-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x1dc, PIN_INPUT, 0) /* (C22) MCAN0_RX */
+			J722S_IOPAD(0x1d8, PIN_OUTPUT, 0) /*(D22) MCAN0_TX */
+		>;
+	};
+
 	main_i2c0_pins_default: main-i2c0-default-pins {
 		pinctrl-single,pins = <
 			J722S_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (D23) I2C0_SCL */
@@ -250,6 +279,26 @@ &main_uart0 {
 
 &mcu_pmx0 {
 
+	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J722S_MCU_IOPAD(0x038, PIN_INPUT, 0) /* (D8) MCU_MCAN0_RX */
+			J722S_MCU_IOPAD(0x034, PIN_OUTPUT, 0) /* (B2) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
+		pinctrl-single,pins = <
+			J722S_MCU_IOPAD(0x040, PIN_INPUT, 0) /* (B1) MCU_MCAN1_RX */
+			J722S_MCU_IOPAD(0x03C, PIN_OUTPUT, 0) /*(C1) MCU_MCAN1_TX */
+		>;
+	};
+
+	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-default-pins {
+		pinctrl-single,pins = <
+			J722S_MCU_IOPAD(0x0030, PIN_OUTPUT, 7) /* (C3) MCU_GPIO0_12 */
+		>;
+	};
+
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
 			J722S_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C7) WKUP_UART0_CTSn */
@@ -457,3 +506,28 @@ &usb1 {
 	phys = <&serdes0_usb_link>;
 	phy-names = "cdns3,usb3-phy";
 };
+
+&mcu_mcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver0>;
+};
+
+&mcu_mcan1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&main_mcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan0_pins_default>;
+	phys = <&transceiver2>;
+};
+
+&mcu_gpio0 {
+	status = "okay";
+};
-- 
2.34.1


