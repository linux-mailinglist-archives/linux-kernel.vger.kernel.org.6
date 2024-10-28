Return-Path: <linux-kernel+bounces-384442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E141A9B2A25
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7BF280C48
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26412190470;
	Mon, 28 Oct 2024 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hHa1cZzd"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77C18871E;
	Mon, 28 Oct 2024 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103891; cv=none; b=anrGoX5MJ2dBN3L5auOSEYHP4C9uvOFbTzIr8b/ja4L+crt9pW0DASrlI0rcukd+8j/tODQS4naVvJeWivMbH7BjnjP+o5I0fe9tAoYfFL7YQ9YhvaAEq7KkOsXbzq1a6SBxvETHyvzFGV2z9MfmSXnDP5dojQHdfD2z5W89rNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103891; c=relaxed/simple;
	bh=SNQ+CvL3Rbu1loYvuLiWy4yMfP1pvFISH+yattD7W1A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uuXHKFApLRaft2iGKjv/n73ezSKc84Y9RMdKHJmQU16ojPXhCQ5aISTGQMz99yar+d/8R+CkSJxp6NDJcEo01xVsIlaH9+0OL27vBLuFlmm5aA+czULeuAQg20JwC0/VBZPG1yHApBmR9YPPo3dF1KBsSxt3ibBRpqMbG10gzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hHa1cZzd; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49S8OSaE039569;
	Mon, 28 Oct 2024 03:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730103868;
	bh=Ixb85Zg1wi33Ybq/Oj9u83ymgLGI30K4HkUvDy4gHrc=;
	h=From:To:CC:Subject:Date;
	b=hHa1cZzdwrdWrevZCDnMaqsVv9WP/0Pus+/mOBLji3MK2jfO1FYTaomlXJLDY39lo
	 AiLDIaJ++dXRQjih8DSY2n9dc/aQEc4BdJ3ebuTYvOyjrQYp3Kqw0r7QhfQ75j05wl
	 YvJ8ACn2r3Yxlye+8VOZItQt7gPt6d9p5Mz4WRQE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49S8OSAa030888
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Oct 2024 03:24:28 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 03:24:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 03:24:28 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49S8ORXL038840;
	Mon, 28 Oct 2024 03:24:27 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <s-sinha@ti.com>, <ankurbaranwal@ti.com>, <b-kapoor@ti.com>,
        <u-kumar1@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j722s-evm: Add pinmux for RPi Header
Date: Mon, 28 Oct 2024 13:54:26 +0530
Message-ID: <20241028082426.1551816-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add pinmux required to bring out the i2c and gpios on
40-pin RPi expansion header on the J722S EVM.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Signed-off-by: Shreyash Sinha <s-sinha@ti.com>
---

Rebased To - next-20241025

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 62 +++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index a00f4a7d20d9..7dce021a8a3c 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -359,6 +359,32 @@ audio_ext_refclk1_pins_default: audio-ext-refclk1-default-pins {
 			J722S_IOPAD(0x00a0, PIN_OUTPUT, 1) /* (N24) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
 		>;
 	};
+
+	rpi_header_gpio0_pins_default: rpi-header-gpio0-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x094, PIN_INPUT, 7) /* (P26) GPIO0_36 */
+			J722S_IOPAD(0x088, PIN_INPUT, 7) /* (N22) GPIO0_33 */
+			J722S_IOPAD(0x0ac, PIN_INPUT, 7) /* (P21) GPIO0_42 */
+			J722S_IOPAD(0x0a8, PIN_INPUT, 7) /* (R27) GPIO0_41 */
+		>;
+	};
+
+	rpi_header_gpio1_pins_default: rpi-header-gpio1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x1b0, PIN_INPUT, 7) /* (F24) GPIO1_14 */
+			J722S_IOPAD(0x1ac, PIN_INPUT, 7) /* (C27) GPIO1_13 */
+			J722S_IOPAD(0x198, PIN_INPUT, 7) /* (A26) GPIO1_8 */
+			J722S_IOPAD(0x1a4, PIN_INPUT, 7) /* (D25) GPIO1_11 */
+			J722S_IOPAD(0x194, PIN_INPUT, 7) /* (A25) GPIO1_7 */
+			J722S_IOPAD(0x1b8, PIN_INPUT, 7) /* (C20) GPIO1_16 */
+			J722S_IOPAD(0x1a8, PIN_INPUT, 7) /* (C26) GPIO1_12 */
+			J722S_IOPAD(0x1a0, PIN_INPUT, 7) /* (F23) GPIO1_10 */
+			J722S_IOPAD(0x19c, PIN_INPUT, 7) /* (B25) GPIO1_9 */
+			J722S_IOPAD(0x1b4, PIN_INPUT, 7) /* (B20) GPIO1_15 */
+			J722S_IOPAD(0x1bc, PIN_INPUT, 7) /* (D20) GPIO1_17 */
+			J722S_IOPAD(0x1c0, PIN_INPUT, 7) /* (E19) GPIO1_18 */
+		>;
+	};
 };
 
 &cpsw3g {
@@ -387,6 +413,8 @@ &cpsw_port1 {
 };
 
 &main_gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio1_pins_default>;
 	status = "okay";
 };
 
@@ -443,6 +471,25 @@ J722S_MCU_IOPAD(0x050, PIN_INPUT_PULLUP, 0)	/* (C6) WKUP_I2C1_SDA */
 		>;
 		bootph-all;
 	};
+
+	mcu_rpi_header_gpio0_pins_default: mcu-rpi-header-gpio0-default-pins {
+		pinctrl-single,pins = <
+			J722S_MCU_IOPAD(0x01c, PIN_INPUT, 7) /* (B5) MCU_GPIO0_7 */
+			J722S_MCU_IOPAD(0x020, PIN_INPUT, 7) /* (C5) MCU_GPIO0_8 */
+			J722S_MCU_IOPAD(0x00c, PIN_INPUT, 7) /* (B12) MCU_GPIO0_3 */
+			J722S_MCU_IOPAD(0x010, PIN_INPUT, 7) /* (C11) MCU_GPIO0_4 */
+			J722S_MCU_IOPAD(0x008, PIN_INPUT, 7) /* (A9) MCU_GPIO0_2 */
+			J722S_MCU_IOPAD(0x000, PIN_INPUT, 7) /* (C12) MCU_GPIO0_0 */
+			J722S_MCU_IOPAD(0x004, PIN_INPUT, 7) /* (A10) MCU_GPIO0_1 */
+		>;
+	};
+
+	mcu_i2c0_pins_default: mcu-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J722S_MCU_IOPAD(0x048, PIN_INPUT, 0) /* (E11) MCU_I2C0_SDA */
+			J722S_MCU_IOPAD(0x044, PIN_INPUT, 0) /* (B13) MCU_I2C0_SCL */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -810,5 +857,20 @@ &main_mcan0 {
 };
 
 &mcu_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_rpi_header_gpio0_pins_default>;
+	status = "okay";
+};
+
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rpi_header_gpio0_pins_default>;
+	status = "okay";
+};
+
+&mcu_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_i2c0_pins_default>;
+	clock-frequency = <400000>;
 	status = "okay";
 };
-- 
2.34.1


