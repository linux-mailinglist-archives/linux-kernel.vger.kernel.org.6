Return-Path: <linux-kernel+bounces-279097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1916A94B8EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01A728A4BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62F6189511;
	Thu,  8 Aug 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qZjuODV4"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA2145336;
	Thu,  8 Aug 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105281; cv=none; b=aevliKjfuxhUhBCOZVPv+lSlr7hIXIaMJDYiFDnaeJG70/CBN+6xBLi88DCQwskoioB3kcDS3dIY7SLZs+dvLOYKhvJU497oltHdGJwiMRXrSEKOev7ySNDIutJWNnBtFFTe8XSyZlWp/iVV/v/SdZJOzIpEiWrHwdVVP9/g4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105281; c=relaxed/simple;
	bh=zW4gXRl9j7t4LD6ZiJAERuv8KT7u29VEcU2dhh5LRqY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NbTZu3HnCysoJAqq3+1gFNW/gkeW9TBaZYLycxji/s2LxHwyPNeC4xo0xLjVghBfTBALe01S2frK/nKUm06OpVAYUKhGP7TjMQHG+MAwuafpb1VvG5h6aXCenM4IDEhMuEsI/VAVJXrncRl+u9ycX2XqPWWwnDHbk21d7BfAyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qZjuODV4; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4788KWe7060032;
	Thu, 8 Aug 2024 03:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723105232;
	bh=/1xyuDyfSwA12wuJAyb3Q+WDU/YmPBcJ/cd3RNWmHg8=;
	h=From:To:CC:Subject:Date;
	b=qZjuODV4MrPzS2PPjJ0bt++qQ4bBm5GcvnSEf28fwnJemnl2FLCXfXKrRJUNjZH8G
	 z0hRlPUT70KVk0fkQjO/d05z3+aUIzfcKNDffQEYDklLgyrZWyDJZ5Y1khXL65eqP2
	 xxw4jalbayABc0XlcugfKj9yaPVl8dZ9ifXZdomI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4788KWqS113373
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 03:20:32 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 03:20:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 03:20:31 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4788KVeP092084;
	Thu, 8 Aug 2024 03:20:31 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <b-kapoor@ti.com>, <jm@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [RESEND PATCH] arm64: dts: ti: k3-j722s-evm: Add support for multiple CAN instances
Date: Thu, 8 Aug 2024 13:50:30 +0530
Message-ID: <20240808082030.2812216-1-b-kapoor@ti.com>
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
Reviewed-by: Judith Mendez <jm@ti.com>
---

Rebased to next-20240808

Resend of - https://lore.kernel.org/all/d1d7f693-1dd6-4aea-bdbd-4385dc35d462@ti.com/

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 74 +++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index dd3b5f7039d7..24e9f2ea509b 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -162,10 +162,39 @@ sound_master: simple-audio-card,codec {
 			clocks = <&audio_refclk1>;
 		};
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
@@ -303,6 +332,26 @@ &main_uart0 {
 
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
@@ -566,3 +615,28 @@ &mcasp1 {
 	       0 0 0 0
 	>;
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


