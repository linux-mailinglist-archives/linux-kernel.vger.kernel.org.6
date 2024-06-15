Return-Path: <linux-kernel+bounces-215772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4350C9096D8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA400B21CD5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F14C22F19;
	Sat, 15 Jun 2024 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QCLyKXMc"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945B1CFBC;
	Sat, 15 Jun 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439385; cv=none; b=JtvrYN2A/5h1ifCFsSay34LETwEmG7R0+I+NrjUyxhRNaociyJmt7b36W0YcdXu/VRM6VLS8DXBFhAO5CoUpo/wA5GOQJk1Cg/4Cr19afw9hCe9stahpbwUWyuVVvKY/ytZHadyeleHGWqGwHfyfIcKviiBWEeQGFkK6gtBKGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439385; c=relaxed/simple;
	bh=gUJcJ5KArJ60DY6wuRuA2iSP5OLyG/cAR8EOWvtK7ic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnLnFXnBw+p6NlY0sIDZbKaNHWnDTvan9g9qmGbEMNdfyWd19+gfBc6774/+GPqo2jXqWlADj1lVIxJ7tRX9qHQgtq6UNGimUHcAJJyNde8rYzWibn4p8BJ1bdka0pTPMm41HNSNA89DT6yRzHyDqfEwCp2rTMnjjpiuppB3e14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QCLyKXMc; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45F8GJel052871;
	Sat, 15 Jun 2024 03:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718439379;
	bh=/nMNn/Q9Pl1TR9MHJwmz0h5ZACHUGbgRIKUcIWqHir4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QCLyKXMc61rUpmxfc1qvlwSlQHF5vtqeUwQUuUUM5Aw0l+rJDpTOLM0BGYrB+FnBc
	 64d5DI9ftxI58cAMim26NI5TzPOoUTnwOCMTEj3IsSLYAOM5Bz1wcdmFxZ1ToR+S3h
	 E/6p7SqApD0Xqu1T3VZhsZaDQyWeYeEAaPSR3Lz0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45F8GJP8063852
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 15 Jun 2024 03:16:19 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Jun 2024 03:16:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Jun 2024 03:16:19 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45F8G1QX024463;
	Sat, 15 Jun 2024 03:16:15 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v7 3/8] arm64: dts: ti: k3-j722s: Add main domain peripherals specific to J722S
Date: Sat, 15 Jun 2024 13:45:55 +0530
Message-ID: <20240615081600.3602462-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240615081600.3602462-1-s-vadapalli@ti.com>
References: <20240615081600.3602462-1-s-vadapalli@ti.com>
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
Acked-by: Roger Quadros <rogerq@kernel.org>
---
v6:
https://lore.kernel.org/r/20240612132409.2477888-4-s-vadapalli@ti.com/
No changes since v6.

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


