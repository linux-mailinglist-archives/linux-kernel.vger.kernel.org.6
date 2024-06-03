Return-Path: <linux-kernel+bounces-199052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E038D8144
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE61CB25B70
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADBC84A53;
	Mon,  3 Jun 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dBw/29Ii"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07C24A08;
	Mon,  3 Jun 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414220; cv=none; b=dU0+t5wNwVjITO2Y8m/3IXoZrRgII7hO96FBBmJhoCpqI1mDl3NT7rHLwLiLROLDA9buj36Su+l4gaku9tjI1uVg46XRa6B59c5HtQYjIn7dUKXyjPCUqLvZcfcqMbZAoPS7lIWSZspnUv2j1R8po8RKjrbkUjjh5jaFBm+OrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414220; c=relaxed/simple;
	bh=ofKJJ2dCu7uGRLd+LeAsh5JzMduJOhSrfwcOYcq00GY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iKNOPonMek/1r3vckDaetPSiBYlOkGrtgMmOV4prd0vI4CMD64+kzmF1ny5OKYmZ4LcRp0zBAiQy2UeGrrMhZB8KoSqt+PmScljfR6c2kKpl0Z0sNm4bl2yoT/fWivoYlqK4YsUoXFsY6Gzf6TuZNGlbEYke/CUTJxflMBTsjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dBw/29Ii; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 453BTrqr109765;
	Mon, 3 Jun 2024 06:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717414193;
	bh=/gK4bYbUB3jEPRB79RUhIuG6Z16oJ4GstdSi/sOCJVM=;
	h=From:To:CC:Subject:Date;
	b=dBw/29IiF9PVv46sh8HD3dX5aZfVp4gMMA1uK17mnGkXI0Nx7HAfdrccdClaVosQw
	 95+ujlcdYhd2S0zB8auBE1WI4zgITEJV5n3Qg0JVSa4T2V17/gXNeyEyJ7PbW70Con
	 EAm6rBD9ooD3+3NgncGtyob3mmz/uzb6OQ1nx6II=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 453BTrec016377
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 06:29:53 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 06:29:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 06:29:52 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 453BTn5H011713;
	Mon, 3 Jun 2024 06:29:49 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dasnavis Sabiya
	<sabiya.d@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j784s4-main: Add node for EHRPWMs
Date: Mon, 3 Jun 2024 16:59:38 +0530
Message-ID: <20240603112938.2188510-1-u-kumar1@ti.com>
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

From: Dasnavis Sabiya <sabiya.d@ti.com>

Add dts nodes for 6 EHRPWM instances on SoC.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 6a4554c6c9c1..f6fc2ce55f9b 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -75,6 +75,72 @@ serdes_ln_ctrl: mux-controller@4080 {
 				      <J784S4_SERDES4_LANE2_EDP_LANE2>,
 				      <J784S4_SERDES4_LANE3_EDP_LANE3>;
 		};
+
+		ehrpwm_tbclk: clock-controller@4140 {
+			compatible = "ti,am654-ehrpwm-tbclk";
+			reg = <0x4140 0x18>;
+			#clock-cells = <1>;
+		};
+	};
+
+	main_ehrpwm0: pwm@3000000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3000000 0x00 0x100>;
+		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 219 0>;
+		clock-names = "tbclk", "fck";
+		power-domains = <&k3_pds 219 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_ehrpwm1: pwm@3010000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3010000 0x00 0x100>;
+		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 220 0>;
+		clock-names = "tbclk", "fck";
+		power-domains = <&k3_pds 220 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_ehrpwm2: pwm@3020000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3020000 0x00 0x100>;
+		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 221 0>;
+		clock-names = "tbclk", "fck";
+		power-domains = <&k3_pds 221 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_ehrpwm3: pwm@3030000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3030000 0x00 0x100>;
+		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 222 0>;
+		clock-names = "tbclk", "fck";
+		power-domains = <&k3_pds 222 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_ehrpwm4: pwm@3040000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3040000 0x00 0x100>;
+		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 223 0>;
+		clock-names = "tbclk", "fck";
+		power-domains = <&k3_pds 223 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	main_ehrpwm5: pwm@3050000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3050000 0x00 0x100>;
+		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 224 0>;
+		clock-names = "tbclk", "fck";
+		power-domains = <&k3_pds 224 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	gic500: interrupt-controller@1800000 {
-- 
2.34.1


