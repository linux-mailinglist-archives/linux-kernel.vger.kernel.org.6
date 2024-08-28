Return-Path: <linux-kernel+bounces-304869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF396962609
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E73F1C225F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6F517332C;
	Wed, 28 Aug 2024 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uwlPL5p4"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575516B752;
	Wed, 28 Aug 2024 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844467; cv=none; b=DqBbmlX29SXRpYi8pcUaJ2b1GW+YGd+8vOQ0FjMJFI8mR4Oj7vbe7RQUFI7cB72Iyv8mi8S6za3ydLzAKFSqphjUaYYYOUDODjoyVxPhBpoi7fpSeM8WkJmATL6bkxFpbAUaPZAIyZ30d98nBEmp68MSAvi3deKDEeszLLJ6jg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844467; c=relaxed/simple;
	bh=nrlEpNcc9O8P/dQuO8p6d48v88tX1exC5mju9L/LAIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoBFLJUzcEinD2MxHWMbURi1IVKexwnaki2sJnNVFG3dxJtSPTjAZ4T2EQU5lo/R7qLu3zBPRFBy6ME95BebTIEhxQv0SB1TZf32cQ3N8ZU9WQYoxn2scwDk/q2W8IGlHrHfmpM1tC/dKEuSAQe8neWy7oOjPsh30pUVOIIGdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uwlPL5p4; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SBRMk7112237;
	Wed, 28 Aug 2024 06:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724844442;
	bh=d9efV/rvCCK1E6Vpnt75lb5mOZaqIgzkcej2lwOtD4s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uwlPL5p4C06h9zp9+EXBgFEBD0wn1OgyktETXf+Ps5dj7+HYp9UjQTfQkvKsf7CkX
	 soNr3HZvEx2cq83VxxUOSwN9nDnKSHYfaWKjTmlNb2yMKKT/PFaqPiUp5/HMDVqA+F
	 t5iOo4C2oIetDtteEvpAxM3bPwPlbwZVOUEnf5lc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SBRMXN007233
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 06:27:22 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 06:27:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 06:27:22 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SBRE6G008364;
	Wed, 28 Aug 2024 06:27:18 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <j-choudhary@ti.com>, <vaishnav.a@ti.com>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/2] arm64: dts: ti: k3-j722s-main: Add R5F and C7x remote processor nodes
Date: Wed, 28 Aug 2024 16:57:12 +0530
Message-ID: <20240828112713.2668526-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828112713.2668526-1-b-padhi@ti.com>
References: <20240828112713.2668526-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Apurva Nandan <a-nandan@ti.com>

The K3 J722S SoCs have one single-core Arm Cortex-R5F processor in each
of the WAKEUP, MCU and MAIN voltage domain, and two C71x DSP subsystems
in MAIN voltage domain. Add the DT nodes to support Inter-Processor
Communication.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
[ refactoring changes to k3-j722s-main.dtsi ]
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v3: Changelog:
1) None to this patch.

Link to v2:
https://lore.kernel.org/all/20240612112259.1131653-2-b-padhi@ti.com/

v2: Changelog:
1) Refactored changes from k3-j722s.dtsi to k3-j722s-main.dtsi. (Andrew)

Link to v1:
https://lore.kernel.org/all/20240607090433.488454-2-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 61 +++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index cadb4f7c2ea9..69ff8872ddff 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -153,6 +153,67 @@ usb1: usb@31200000{
 			dr_mode = "otg";
 		};
 	};
+
+	main_r5fss0: r5fss@78400000 {
+		compatible = "ti,am62-r5fss";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x78400000 0x00 0x78400000 0x8000>,
+			 <0x78500000 0x00 0x78500000 0x8000>;
+		power-domains = <&k3_pds 261 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		main_r5fss0_core0: r5f@78400000 {
+			compatible = "ti,am62-r5f";
+			reg = <0x78400000 0x00008000>,
+			      <0x78500000 0x00008000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <262>;
+			ti,sci-proc-ids = <0x04 0xff>;
+			resets = <&k3_reset 262 1>;
+			firmware-name = "j722s-main-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	c7x_0: dsp@7e000000 {
+		compatible = "ti,am62a-c7xv-dsp";
+		reg = <0x00 0x7e000000 0x00 0x00200000>;
+		reg-names = "l2sram";
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <208>;
+		ti,sci-proc-ids = <0x30 0xff>;
+		resets = <&k3_reset 208 1>;
+		firmware-name = "j722s-c71_0-fw";
+		status = "disabled";
+	};
+
+	c7x_1: dsp@7e200000 {
+		compatible = "ti,am62a-c7xv-dsp";
+		reg = <0x00 0x7e200000 0x00 0x00200000>;
+		reg-names = "l2sram";
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <268>;
+		ti,sci-proc-ids = <0x31 0xff>;
+		resets = <&k3_reset 268 1>;
+		firmware-name = "j722s-c71_1-fw";
+		status = "disabled";
+	};
+};
+
+/* MCU domain overrides */
+
+&mcu_r5fss0_core0 {
+	firmware-name = "j722s-mcu-r5f0_0-fw";
+};
+
+/* Wakeup domain overrides */
+
+&wkup_r5fss0_core0 {
+	firmware-name = "j722s-wkup-r5f0_0-fw";
 };
 
 &main_conf {
-- 
2.34.1


