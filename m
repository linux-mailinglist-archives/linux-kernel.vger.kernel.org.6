Return-Path: <linux-kernel+bounces-200282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0418FAE0B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D65FB22E57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B90143751;
	Tue,  4 Jun 2024 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vn6qvo+V"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487ECBA39;
	Tue,  4 Jun 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491198; cv=none; b=AXIaw3ONeIQvDjjTZFEaRrrX/qG9xhN1ylhRrj1pWrHcP1mr02E4Mw7dDpMZIEUEionc7LpYZjXlqBXFEBOBVxhyxkThQrtyOgcGclNK9DRWJH8U4JU064xU8z9BqDAjmCRBGALc1d6SbYQ/76E1uOkymgDmlkcT9uY0HIBOB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491198; c=relaxed/simple;
	bh=Za4YivYA71b9zGu5oBzZnkcWWAHciRY7XfW2tQa8cjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0izzMt7un4VQUJRDMOqUO2LYmYGt8Ph7bhZM33e8a3dyLbNpdS8tUOKbzJuSI9sE2/bpyVtVzlsilzznUlVSVhLJnDjE6M+aBZjIDol9VNWwHPzfwUkzsmfjfZuGK2L5++f0rX0HzEsMr2YrucTfG4LAWo718J/MHDhU8dL2kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vn6qvo+V; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4548rBGn104999;
	Tue, 4 Jun 2024 03:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717491191;
	bh=mqw2wpr5dwqoRbT46YWoETJD6jH8FJ9NUJlsn9ijPL8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vn6qvo+VCPQ0QNsjC7vuE6l6iF5fVKplLBvgO8/elnevXgUWrgSuUb/gnbbs1m+qt
	 rt2EMjYp1mRZcJWUN3ma6JOoBBPr2CoTMCm7gZbK5fi1ciAhpJrMFOKtkqTSRDcsyD
	 MwsHGvoSch1bMqFE4GZ+1ikQRjY9zk9p4y5AYReI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4548rBT9016040
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 03:53:11 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 03:53:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 03:53:10 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4548qqQk066926;
	Tue, 4 Jun 2024 03:53:06 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 3/7] arm64: dts: ti: k3-j722s: Add main domain peripherals specific to J722S
Date: Tue, 4 Jun 2024 14:22:48 +0530
Message-ID: <20240604085252.3686037-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240604085252.3686037-1-s-vadapalli@ti.com>
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Introduce the "k3-j722s-main.dtsi" file to contain main domain peripherals
that are specific to J722S SoC and are not shared with AM62P. The USB1
instance of the USB controller on J722S is different from that on AM62P.
Thus, add the USB1 node in "k3-j722s-main.dtsi".

Co-developed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
v4:
https://lore.kernel.org/r/20240601121554.2860403-4-s-vadapalli@ti.com/
Changes since v4:
- s/main/MAIN in k3-j722s-main.dtsi

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
new file mode 100644
index 000000000000..84378fc839d6
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree file for the J722S MAIN domain peripherals
+ *
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_main {
+	usbss1: usb@f920000 {
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x0f920000 0x00 0x100>;
+		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 278 3>, <&k3_clks 278 1>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 278 3>; /* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 278 4>; /* HF0SC0 */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		usb1: usb@31200000{
+			compatible = "cdns,usb3";
+			reg = <0x00 0x31200000 0x00 0x10000>,
+			      <0x00 0x31210000 0x00 0x10000>,
+			      <0x00 0x31220000 0x00 0x10000>;
+			reg-names = "otg",
+				    "xhci",
+				    "dev";
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
+				     <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>, /* irq.6 */
+				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>; /* otgirq */
+			interrupt-names = "host",
+					  "peripheral",
+					  "otg";
+			maximum-speed = "super-speed";
+			dr_mode = "otg";
+		};
+	};
+};
-- 
2.40.1


