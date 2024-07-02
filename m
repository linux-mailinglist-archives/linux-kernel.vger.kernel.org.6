Return-Path: <linux-kernel+bounces-238118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CD19243D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C68287019
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC071BD512;
	Tue,  2 Jul 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F1MhHh2a"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ECD1BD505;
	Tue,  2 Jul 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938669; cv=none; b=Y9pqBRHiJCiytEC2etS98ucAHoEnFBQiMsOmNgcPv6zixUUWYsfShdatk7L29oEEQ8gAq6HaIf9QY7G+YQ/BOq826I5LNUcupxiXy3XPC6ywn1NsTZcsrUDK/80BSw8VnNVUEE2lAaQFJXaillrglEIyhZ7J27JsptO1Se3+Xh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938669; c=relaxed/simple;
	bh=Ij09GaLS8jCj1Q/4ITErm0ORGTUwbc9BQiywSFBmEQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQnyVA7WprMuu1aZDNzyzPIAau7eRdF7XcrytR/HaTFTW7qtmZGbyjWYXZ+44DWwweam+am4+yh79X/hcWsB/S3VYH+mENpoEPh4Y83k/WhkSweiwJhLITjDqqAhViv07VB6mJEKkfuqVgtdlUf6hYl8ut1jdD5WDnSQqQra6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=F1MhHh2a; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 462Gi67Y041361;
	Tue, 2 Jul 2024 11:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719938646;
	bh=yLCs5mqC5Y2R1+0MelVeW7+pWk0GZmpm5hAwC2rgETI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=F1MhHh2ab/BZfLoXGg97fLiuXAl+jriZJ6W/PnOLIeqjEr7GFSZ8ga8fl2pZKMdYK
	 aoix0KoLCF37g/lIb4qNia4/ru3iyuKUifuyKtTwADU/I1tLXwOoYwp+EtDtbbM81g
	 XKenfN3iMYrxEu14hO60PRsKo4NkIo4II6lG3n10=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 462Gi6hL017072
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 11:44:06 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 11:44:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 11:44:06 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 462Gi4YB112748;
	Tue, 2 Jul 2024 11:44:05 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vaishnav M A
	<vaishnav@beagleboard.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan
 Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Michael Walle
	<mwalle@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson
	<robertcnelson@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Ayush Singh <ayush@beagleboard.org>,
        Ayush Singh <ayushdevel1325@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH RFC 1/3] arm64: dts: ti: k3-am625-beagleplay: Add Grove connector pinmux options
Date: Tue, 2 Jul 2024 11:44:01 -0500
Message-ID: <20240702164403.29067-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702164403.29067-1-afd@ti.com>
References: <20240702164403.29067-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The Grove connector pins on BeaglePlay supports 3 different functions.
Describe these here.

Also move the default to be selected by a new Grove connector node.
As I2C is not the only possible function, do not enable main_i2c1.
It should only be enabled when a add-on board is connected that
makes use of it. That enabling should be done by the add-on board's
overlay.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 32 +++++++++++++++----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 70de288d728e4..004eb5c24a84c 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -227,6 +227,10 @@ simple-audio-card,codec {
 		};
 	};
 
+	grove_connector0: grove-connector0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&grove_pins_default>;
+	};
 };
 
 &main_pmx0 {
@@ -270,6 +274,27 @@ AM62X_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
 		>;
 	};
 
+	grove_pins_digital: grove-digital-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01e8, PIN_INPUT, 7) /* (B17) I2C1_SCL.GPIO1_28 */
+			AM62X_IOPAD(0x01ec, PIN_INPUT, 7) /* (A17) I2C1_SDA.GPIO1_29 */
+		>;
+	};
+
+	grove_pins_uart: grove-uart-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01e8, PIN_INPUT, 1) /* (B17) I2C1_SCL.UART1_RXD */
+			AM62X_IOPAD(0x01ec, PIN_OUTPUT, 1) /* (A17) I2C1_SDA.UART1_TXD */
+		>;
+	};
+
+	grove_pins_i2c: grove-i2c-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x01e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
+			AM62X_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */
+		>;
+	};
+
 	local_i2c_pins_default: local-i2c-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -753,13 +778,6 @@ ldo4_reg: ldo4 {
 	};
 };
 
-&main_i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&grove_pins_default>;
-	clock-frequency = <100000>;
-	status = "okay";
-};
-
 &main_i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_1v8_pins_default>;
-- 
2.39.2


