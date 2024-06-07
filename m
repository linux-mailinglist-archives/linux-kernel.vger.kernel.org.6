Return-Path: <linux-kernel+bounces-205669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41C08FFEAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728DF1F21B00
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36F15B57B;
	Fri,  7 Jun 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Holxq3hw"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF2D15B556;
	Fri,  7 Jun 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751092; cv=none; b=f6MnhCSI0I/DVlRZrrm6tw0OqNbaAONlymG7PG2HQsGPj3dzoXQGpMioliwEPTXYKevWN7myHS5obalOEoBCtnmpzXVO66pNHnwJ3vHcUxqafWOAtEZdAO9ArlTyPiL71FS3rDk/whoplqHfElqUQyqVNXTgsu88Ayh8lpkY4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751092; c=relaxed/simple;
	bh=EfH6RGhEyXtRycnSNlIJFDnoF6A3+RynBwoX/CmEOgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ul+ZMor/2AZwFev/n3FX4DPDtF9T51TDkLEFG3M5yu/nF17/Zi6qam5NXXREYC573Tt6h4mWbl3K8LHqRaAehAEc4dwN80LEF4PxZK82Sza/fbWs8kWC0hkhEYEqqKWqNvnJDMODgi+a+rl27jIeKXk9zzSjtMPNSzxVKhNEP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Holxq3hw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45794fLA124345;
	Fri, 7 Jun 2024 04:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717751081;
	bh=y8iEQZdBJrT05CHGObd8DnQRyIVkw4FhSN7lZ87J+rY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Holxq3hw93NnBbihMlT3lnvXqxIH4DkWcQw/L6Qkbjwu2Fb/6tsTJWVK9d22Pq3wS
	 gFiC3V/d8i9qpRt5xxltTpJFBTRHv4sv0zdMco0CXozaU21+FS2Vu08HP51GX/FCV1
	 OTKE5VXzJrCPfUvNyTpYkXuoBCz1MYQV2/LXGYGQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45794f5o018317
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 04:04:41 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 04:04:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 04:04:41 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45794Xgk020305;
	Fri, 7 Jun 2024 04:04:38 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>, <u-kumar1@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: Add R5F and C7x remote processor nodes
Date: Fri, 7 Jun 2024 14:34:31 +0530
Message-ID: <20240607090433.488454-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607090433.488454-1-b-padhi@ti.com>
References: <20240607090433.488454-1-b-padhi@ti.com>
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
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s.dtsi | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index c75744edb1433..a894a132f1667 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -87,3 +87,66 @@ &oc_sram {
 	reg = <0x00 0x70000000 0x00 0x40000>;
 	ranges = <0x00 0x00 0x70000000 0x40000>;
 };
+
+&cbass_main {
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
+};
-- 
2.34.1


