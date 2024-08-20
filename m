Return-Path: <linux-kernel+bounces-294517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621B958EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966FB1F2304B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9662E15855B;
	Tue, 20 Aug 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J8iBb94f"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B7618E344;
	Tue, 20 Aug 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724182573; cv=none; b=lNJIskxpU+BgqQ4sm9+ZgwA34HbmOI2TZka5Ciub6LVKHHI4dKs0UnQSxketlC47byPGc3n9Xc+/m7ODlXTc6wLOjApS6s2Yjyf7KCoSWlx4NkPxoWubLRC4Vxx7AYFa0p0ffQZ4/ghclKt+ZicI7C2/F0+JMXxuhHq+/WGykX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724182573; c=relaxed/simple;
	bh=cOiekeev6rboGHHqGdqb1WjVCCU0ERSHU0V1gtQo2cE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ON01p9YR8dBjNMlatcJvfWKMgiMFlhcWz2hrOhVPK1iUYddYRoB2AIifSGPshUpis/mpskHVKxPE2UnG6pkRfZJCwQU5HcvGrTbWc5Vc0b2/AS5Z31SBlvEvKQSZb1E8AYmw6CUG3T0VX/jtwlBVngVIn5Zph2/ytH2z42Y7exg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J8iBb94f; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KJYLdd070049;
	Tue, 20 Aug 2024 14:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724182461;
	bh=7VxsXiOBuB77K83K09T3n0c3TQYauUlHJkmNSsCfAR8=;
	h=From:To:CC:Subject:Date;
	b=J8iBb94fPEKjb9BzSGIWxKVAF4S2D/JdhOIafVPyBu0BR577ez1y3ToHA9It8ujCF
	 7/pF3r7VDp4vLe70htFsViF2dD7BV3ydU1ACuPf9IXcYWKBjEoE9zYiRQJJipCFz0d
	 wxhjC5pNFsdyP+n0pHVqvNQse2N2iHiIlTM4FcqY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KJYLDF055960
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 14:34:21 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 14:34:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 14:34:20 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KJYKNW081261;
	Tue, 20 Aug 2024 14:34:20 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka
	<jan.kiszka@siemens.com>,
        Bhavya Kapoor <b-kapoor@ti.com>
Subject: [PATCH] arm64: dts: k3-am654-idk: Add Support for MCAN
Date: Tue, 20 Aug 2024 14:34:20 -0500
Message-ID: <20240820193420.29184-1-jm@ti.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Faiz Abbas <faiz_abbas@ti.com>

There are two MCAN instances present on the am65x SoC [0].
Since there are two CAN transceivers on the IDK application
board for AM654 EVM [1], enable m_can0 and m_can1, add the
two corresponding CAN transceiver nodes, and set a maximum
data rate of 5 Mbps.

[0] https://www.ti.com/lit/ds/symlink/am6548.pdf
[1] https://www.ti.com/lit/zip/sprr382

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso | 61 ++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
index 8bdb87fcbde00..39c96b7961881 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
@@ -8,6 +8,7 @@
 /dts-v1/;
 /plugin/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
 #include "k3-pinctrl.h"
 
@@ -154,6 +155,24 @@ icssg1_emac1: port@1 {
 			};
 		};
 	};
+
+	transceiver1: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcan0_gpio_pins_default>;
+		standby-gpios = <&main_gpio1 47 GPIO_ACTIVE_LOW>;
+	};
+
+	transceiver2: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcan1_gpio_pins_default>;
+		standby-gpios = <&main_gpio1 67 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &main_pmx0 {
@@ -243,6 +262,34 @@ icssg1_iep0_pins_default: icssg1-iep0-default-pins {
 			AM65X_IOPAD(0x012c, PIN_INPUT, 2) /* (AG26) PRG1_PRU0_GPO19.PRG1_IEP0_EDC_SYNC_OUT0 */
 		>;
 	};
+
+	mcan0_gpio_pins_default: mcan0-gpio-default-pins {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x023c, PIN_INPUT, 7) /* (V25) PRG0_PRU0_GPIO18:GPIO1_47 */
+		>;
+	};
+
+	mcan1_gpio_pins_default: mcan1-gpio-default-pins {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x028c, PIN_INPUT, 7) /* (Y26) PRG0_PRU1_GPIO18.GPIO1_67 */
+		>;
+	};
+};
+
+&wkup_pmx0 {
+	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			AM65X_WKUP_IOPAD(0x00ac, PIN_INPUT_PULLUP, 0) /* (W2) MCU_MCAN0_RX */
+			AM65X_WKUP_IOPAD(0x00a8, PIN_OUTPUT_PULLUP, 0) /* (W1) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan1_pins_default: mcu-mcan1-default-pins {
+		pinctrl-single,pins = <
+			AM65X_WKUP_IOPAD(0x00c4, PIN_INPUT_PULLUP, 1) /* (AD3) WKUP_GPIO0_5.MCU_MCAN1_RX */
+			AM65X_WKUP_IOPAD(0x00c0, PIN_OUTPUT_PULLUP, 1) /* (AC3) WKUP_GPIO0_4.MCU_MCAN1_TX */
+		>;
+	};
 };
 
 &icssg0_mdio {
@@ -294,3 +341,17 @@ &icssg1_iep0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&icssg1_iep0_pins_default>;
 };
+
+&m_can0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&m_can1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver2>;
+};

base-commit: e3cce1229c34b5c28f103361c4d6b3ef17302d5d
-- 
2.46.0


