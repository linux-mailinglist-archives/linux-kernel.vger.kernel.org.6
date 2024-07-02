Return-Path: <linux-kernel+bounces-238120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E521E9243D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DC41C21F59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341621BE249;
	Tue,  2 Jul 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Al4IMDk0"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6D1BD50B;
	Tue,  2 Jul 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938670; cv=none; b=BlVgWcuMoKDTAtbySkUTw8PtA6cRRft8HV0fxyve7dJKi1gtTdwY9AI5exc+oVEgoRuwLi53NacuJzcRyES/vRoO3io0KfOqmTfZA9UrXom6ztzPzsod86PF6i6h/VyP9kwFRBAHepzjSwjTJMV7fABv4x/tf3R/bvFndAtn9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938670; c=relaxed/simple;
	bh=rjKPz+3JOAzygx63SAqCXlYPPWEkZ2o37A+a/sW0NEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1WUOiQhgVOmzMoRo216HDmbndzDg415H3WE5DWjND0qSCbqScW/Mys3bMRtQqitWe68IHeAL25SE7AXFOo8ANCPWifOmOMSsBaDcuhjcC0PHn1gtIkSeEZW2ZLNtfye3GG3ZVT+spMn/rOmQSPKszhmeZ0I72Yi10313pz2fOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Al4IMDk0; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 462Gi7QW041366;
	Tue, 2 Jul 2024 11:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719938647;
	bh=YVaFzmQNxAnOPoU5K+88Hc1/hl359lTjwEE+XjlFZHg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Al4IMDk0HkyUlVUDM+LLyiv8JLsYRVAxXwEoHicc4B4HKggkdSYPdU+YmcATi7lEY
	 as5SxXCXp4WmyFg3vPIJJI5wf4cJGS6dvv+kkje95oNbnSADVvIu2yRLGhcgz/W/gF
	 ba20lH8dH1npV4m1F3e1QoLBG+4jqrhgWhN0R8E0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 462Gi7ek030994
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 11:44:07 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 11:44:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 11:44:07 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 462Gi4YC112748;
	Tue, 2 Jul 2024 11:44:06 -0500
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
Subject: [PATCH RFC 2/3] arm64: dts: ti: k3-am625-beagleplay: Add Grove connector adapter overlays
Date: Tue, 2 Jul 2024 11:44:02 -0500
Message-ID: <20240702164403.29067-3-afd@ti.com>
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

The second connector is only an example and will be removed.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../k3-am625-beagleplay-grove-connector0.dtso | 41 +++++++++++++++++++
 .../k3-am625-beagleplay-grove-connector1.dtso | 22 ++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-beagleplay-grove-connector0.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-beagleplay-grove-connector1.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index e20b27ddf9011..a859629a6072c 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -12,6 +12,8 @@
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-grove-connector0.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-grove-connector1.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-grove-connector0.dtso b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-grove-connector0.dtso
new file mode 100644
index 0000000000000..897d77a6de90a
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-grove-connector0.dtso
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/**
+ * Gasket Overlay for BeaglePlay Grove Connector 0
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	__symbols__ {
+		GROVE_CONNECTOR = "/grove-connector0";
+
+		/* Grove connector 0 Pin1 options */
+		GROVE_PIN1_MUX_I2C_SCL = "/bus@f0000/pinctrl@f4000/grove-i2c-pins";
+		GROVE_PIN1_MUX_DIGITAL = "/bus@f0000/pinctrl@f4000/grove-digital-pins";
+		/* GROVE_PIN1_MUX_ANALOG not available on this pin on this connector on this board */
+		GROVE_PIN1_MUX_UART_RX = "/bus@f0000/pinctrl@f4000/grove-uart-pins";
+
+		/* Grove connector 0 Pin2 options */
+		GROVE_PIN2_MUX_I2C_SDA = "/bus@f0000/pinctrl@f4000/grove-i2c-pins";
+		GROVE_PIN2_MUX_DIGITAL = "/bus@f0000/pinctrl@f4000/grove-digital-pins";
+		/* GROVE_PIN2_MUX_ANALOG not available on this pin on this connector on this board */
+		GROVE_PIN2_MUX_UART_TX = "/bus@f0000/pinctrl@f4000/grove-uart-pins";
+
+		/* Grove connector 0 uses main_i2c1 for I2C on BeaglePlay */
+		GROVE_PIN1_I2C = "/bus@f0000/i2c@20010000";
+		GROVE_PIN2_I2C = "/bus@f0000/i2c@20010000";
+
+		/* Grove connector 0 uses main_gpio1 for DIGITAL on BeaglePlay */
+		GROVE_PIN1_DIGITAL = "/bus@f0000/gpio@601000";
+		GROVE_PIN2_DIGITAL = "/bus@f0000/gpio@601000";
+
+		/* Grove connector 0 does not have ANALOG on BeaglePlay */
+
+		/* Grove connector 0 uses main_uart1 for UART on BeaglePlay */
+		GROVE_PIN1_UART = "/bus@f0000/serial@2810000";
+		GROVE_PIN2_UART = "/bus@f0000/serial@2810000";
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay-grove-connector1.dtso b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-grove-connector1.dtso
new file mode 100644
index 0000000000000..1a0e463d4ec65
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay-grove-connector1.dtso
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/**
+ * Gasket Overlay for BeaglePlay Grove Connector 1
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	__symbols__ {
+		GROVE_CONNECTOR = "/grove-connector1";
+
+		/* This connector does not exist on BeaglePlay, this
+		 * file is here as an example to show that add-ons cannot
+		 * be applied when the needed pins are unavailable. No
+		 * pin is available so all add-on overlays should fail
+		 * to attach to this connector.
+		 */
+	};
+};
-- 
2.39.2


