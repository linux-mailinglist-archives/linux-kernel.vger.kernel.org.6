Return-Path: <linux-kernel+bounces-188520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EE28CE2FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3072F1C21B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F29212AAD9;
	Fri, 24 May 2024 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HC3gn+5v"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3B129A7B;
	Fri, 24 May 2024 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541545; cv=none; b=bETuW+u5Kg7PWH7EHOtOe3ihDjZtXDmIFF0gWghC60tN+vm3HOaKHuzn/DnFF1qF6YV55qS14GnsClh3hJFNa4kgASOB/aAa7EYjwBYsUnBDRkpy00UYnd7uZOZJdoKhH2Z/1EZBccbr+j37f6mW/OJbnlYglGpIuKGGNapmbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541545; c=relaxed/simple;
	bh=lLtfDMJpBCI1eCrpCByumCPSJMA7lzHzHZBE6N9M5Pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APJxWMBKkwTxOHbfTs1znqdDFmkDGRqYSqJs5MB0lijsOWAlZjzDwI4yzrL+LjERBUJExwe8k8Wh3461Ll6xvo6zVEJs4QYwfvHl3birWKTsUNM/yW22ulLhBGN5kiAPHAbtUMT05vihJCu7UjRwezjvM7EpVjSMJ5c7GWsOECA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HC3gn+5v; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O95SX7071494;
	Fri, 24 May 2024 04:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716541528;
	bh=7G+uHrKvDOawFqUQ7qn1Hp7B2RU2opGlYlivmL37KBo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HC3gn+5vAKknp+GjPIaJUbAgDE0TXumHUgsLCR6SYASgdLO65tbkQUF8nsB5GHKmm
	 bQIi1xRmasiumd9832iyJENRyffjzVtAwf6DlPT5zyspg+/kI27c08hTMc88q2ae2J
	 w2afskWNW/wu4hfCX7NNhfw+3bm+IVMZgNpMH6oY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O95S48095677
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 04:05:28 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 04:05:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 04:05:28 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O95F7H017455;
	Fri, 24 May 2024 04:05:24 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 2/7] arm64: dts: ti: k3-j722s-main: Redefine USB1 node description
Date: Fri, 24 May 2024 14:35:09 +0530
Message-ID: <20240524090514.152727-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524090514.152727-1-s-vadapalli@ti.com>
References: <20240524090514.152727-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Ravi Gunasekaran <r-gunasekaran@ti.com>

USB1 controller on J722S and AM62P are from different vendors.
Redefine the USB1 node description for J722S by deleting the
node inherited from AM62P dtsi.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
v2:
https://lore.kernel.org/r/20240513114443.16350-3-r-gunasekaran@ti.com/
No changes since v2.

v1:
https://lore.kernel.org/r/20240429120932.11456-3-r-gunasekaran@ti.com/
Changes since v1:
- The entire node which was added in k3-j722s.dtsi in v1 in now moved to
  k3-j722s-main.dtsi as USB is a main domain peripheral.
- Used generic node names - renamed "cdns-usb@f920000" to "usb@f920000".

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 0dac8f1e1291..b069cecebfd9 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -6,6 +6,13 @@
 
 #include <dt-bindings/phy/phy-ti.h>
 
+/*
+ * USB1 controller on AM62P and J722S are of different IP.
+ * Delete AM62P's USBSS1 node definition and redefine it for J722S.
+ */
+
+/delete-node/ &usbss1;
+
 / {
 	serdes_refclk: clk-0 {
 		compatible = "fixed-clock";
@@ -52,6 +59,38 @@ serdes0: serdes@f000000 {
 			status = "disabled"; /* Needs lane config */
 		};
 	};
+
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
 };
 
 &main_conf {
-- 
2.40.1


