Return-Path: <linux-kernel+bounces-412431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4663B9D08F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66ED1F21460
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73E413D89D;
	Mon, 18 Nov 2024 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KE7nZkW0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B031C4DA03;
	Mon, 18 Nov 2024 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731908056; cv=none; b=Po6tuhyzkTtWmKB3wvSbDn/4Dh5R113j5SJYawHke5fgQ/7SZMosCgSYsc3PSUZF0wHH3CmFRADnLZ9iycb21rQT8AzA4rkx7wjnPKtm35uY1peEPgwYytjRN3ccAU6+I2c7a6qb8wwieSI9orDUVK+1WtkKzsHXA8AaP9Yf3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731908056; c=relaxed/simple;
	bh=JJ14vF3AX4XJQcHxwWeoMn+kJoMItsEjfMDDaFBH0X4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DHUkkUzK4Z7iddJthacU9Jsr03yInwpIhYo6cwMDoyTfWS3WI/I3QIRWl5RuVtqpUhkgS1V32k3D1igcxhXBqRv7F95EAPKlZejat3F7V8XnLY7SMCgmm6C5TjkR/ip3Nd7ms7jjn/KtzhmFcZLLRWj9ZsywLfsJab1xPVkWDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KE7nZkW0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AI5Y8Bk031971;
	Sun, 17 Nov 2024 23:34:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731908048;
	bh=RkkG2wUMLv7vXg7NqpwQ/x23P90Q1+pq1lbWCTs5Vu8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=KE7nZkW0DevOwXmNNmh9C+nyRc4uHlrK3TxyhM6T7gZKvX9n6nbjUChojhxYHWx9e
	 hIvmWF3Dc41NG1984wdNJiKmNagDyGgRUjTZCTJO91YGvrFrBGY9rWA/TcZOzvq/b8
	 p+n0DsEnKSrK+cE5YnOtoeOOi8jx6iZsG07tBl/o=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AI5Y8Gf013778;
	Sun, 17 Nov 2024 23:34:08 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 17
 Nov 2024 23:34:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 17 Nov 2024 23:34:08 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AI5Y80o041450;
	Sun, 17 Nov 2024 23:34:08 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Sun, 17 Nov 2024 23:34:08 -0600
Subject: [PATCH 2/2] arm64: dts: ti: k3-am62l: add initial reference board
 file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241117-am62lx-v1-2-4e71e42d781d@ti.com>
References: <20241117-am62lx-v1-0-4e71e42d781d@ti.com>
In-Reply-To: <20241117-am62lx-v1-0-4e71e42d781d@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Vignesh Raghavendra <vigneshr@ti.com>

Add the initial board file for the AM62L3's Evaluation Module.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62l3-evm.dts | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts b/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts
new file mode 100644
index 0000000000000..2d59389765cab
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only or MIT
+/*
+ * Device Tree file for the AM62L3 Evaluation Module
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * Technical Reference Manual: https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
+ */
+
+/dts-v1/;
+
+#include "k3-am62l3.dtsi"
+
+/ {
+	compatible = "ti,am62l3-evm", "ti,am62l3";
+	model = "Texas Instruments AM62L3 Evaluation Module";
+
+	aliases {
+		serial2 = &main_uart0;
+	};
+
+	chosen {
+		stdout-path = &main_uart0;
+	};
+
+	memory@80000000 {
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+		device_type = "memory";
+		bootph-all;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+	};
+};
+
+&pmx0 {
+	main_uart0_pins_default: main_uart0-default-pins {
+		pinctrl-single,pins = <
+			AM62LX_IOPAD(0x01d4, PIN_INPUT, 1)	  /* (D7)  UART0_RXD */
+			AM62LX_IOPAD(0x01d8, PIN_OUTPUT, 1)	  /* (A6)  UART0_TXD */
+		>;
+		bootph-all;
+	};
+};
+
+&main_uart0 {
+	current-speed = <115200>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart0_pins_default>;
+	status = "okay";
+	bootph-all;
+};

-- 
2.46.0


