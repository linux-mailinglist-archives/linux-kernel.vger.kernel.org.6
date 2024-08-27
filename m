Return-Path: <linux-kernel+bounces-303143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1064D9607FE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A120B1F23823
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC3D19F46C;
	Tue, 27 Aug 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WJuR56Qq"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266A34C634;
	Tue, 27 Aug 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756221; cv=none; b=fnBsFS3/+vvcW+OoPCRUIJc0tWhVhax0EYXr52wGO7GaPZli+vJKRCaoZ5NS5vM8Tvu0Ny6067Ib8rYBj1BXdTeL+5n0s0YFKklbcGIsnrTgoWHoGnEISljZT7MeCnv0wAlDwXsQS2VB3QfZBBTlZXKbO+xEhpFH4EFRZ453xMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756221; c=relaxed/simple;
	bh=WL9khaMm++FuSOrKih5AmGA1iUV3G1kSXo5keWVWApY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kh6Swg/Iwk5vOReQjRIvqgOd+Q0PWIGB4nEbAt96ZsPhlXaEXJd+tJ8bpCz6XMfxA9GtedXKyAXqKEJ32KOKE6LLQR1RkOiB/G4ckqzWxtyR90YYnOgmoli4cyzUnjdM45w512HKN0d1TW6vnm9yAlgff6oiRzfqrpdFsSkZYe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WJuR56Qq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47RAulPL068787;
	Tue, 27 Aug 2024 05:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724756208;
	bh=wv7JKWDQyt9FGASLFjOIcNJuw/piuYTm3nmC/c/75+k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WJuR56QqJ9fwDI8VqSak/UvBmd3unJC3+jtbUZrNOcrr4kyZ6uGyRklGhpQYMW2DP
	 /Z5+iaGU4KOfW1RsnNqtWo3T8KXshfFqqQTsJHkNKha6hSFBQXggX4BAwWRQWOYJr3
	 AGtxFk5GwDKq7TzHEQPBGX6ulB/9dvfz5zYBbWYs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47RAul7p005595
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 05:56:47 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 05:56:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 05:56:47 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47RAukwv051318;
	Tue, 27 Aug 2024 05:56:47 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <b-kapoor@ti.com>, <jm@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j722s-evm: Add support for multiple CAN instances
Date: Tue, 27 Aug 2024 16:26:43 +0530
Message-ID: <20240827105644.575862-2-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827105644.575862-1-b-kapoor@ti.com>
References: <20240827105644.575862-1-b-kapoor@ti.com>
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

Link to v1: https://lore.kernel.org/all/20240808082030.2812216-1-b-kapoor@ti.com/

changelog v1->v2:
	Modified code to maintain proper dts coding style

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 74 +++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index dd3b5f7039d7..8daa47a245aa 100644
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
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver0>;
+	status = "okay";
+};
+
+&mcu_mcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver1>;
+	status = "okay";
+};
+
+&main_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan0_pins_default>;
+	phys = <&transceiver2>;
+	status = "okay";
+};
+
+&mcu_gpio0 {
+	status = "okay";
+};
-- 
2.34.1


