Return-Path: <linux-kernel+bounces-306197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DC1963B09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9AF1F21310
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBCF16D4CA;
	Thu, 29 Aug 2024 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nKPMTnqb"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD538159565;
	Thu, 29 Aug 2024 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911788; cv=none; b=ZKc7LO2eb6FFBkZEqT6EtOAbY9AW8OFvWR0fUbpHQrPLkHwTrdJB+pMkiN/FLxSApdu+hcItfBeGb/NTG+UOXqLa+WRHx+g5H8Et2sufZaSMNc/hQLh8+l9BbqYidyfp1+Sg5oC1s5OkImiHnJ61XtDYGFwvcXCBnv4+oXaSIZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911788; c=relaxed/simple;
	bh=P6URFCyILLuvQKGjCRmRtPmHCG8HTjO1EBgsdE7kBjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiZT/2T8nI78g0/vGV+8DpSaWxi0l5W1Z9csOJ8K7r9aAKzNnpIUCk39qdN2CYgCC9pbfSG/oxYQm4wO8/Y11lCLdl+IBq37xH2vrm62rQ90MfYMURGwXgtxhIDggJ89grXBH6XF9HHIXIVkhudFUJEWNn0QbhKEOOjbf85taIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nKPMTnqb; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47T69f9w099448;
	Thu, 29 Aug 2024 01:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724911781;
	bh=okC2TvE0zEjed1VKpRCxWIShXFgdJubfvoCN/k85K+4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nKPMTnqbQ0KeMWa1P3qxwDqfVEkNfxMMF4KF4YdEpumMQRPL0gSSVnlFXfh8n+wVA
	 gILWAgHf8mqV7opzwi9BJbG1rxkcb+YQ3Wflnwb5qB+0bRJP4qF/a+eIspoya6UyjJ
	 Q1EK24zFDbstLJdv8y4yWk1wD6SUv3UnO75ky3zs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47T69f04120566
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 01:09:41 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 01:09:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 01:09:41 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47T69XCJ126434;
	Thu, 29 Aug 2024 01:09:37 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <j-choudhary@ti.com>, <vaishnav.a@ti.com>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 1/2] arm64: dts: ti: k3-j722s-main: Add R5F and C7x remote processor nodes
Date: Thu, 29 Aug 2024 11:39:31 +0530
Message-ID: <20240829060932.3441295-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829060932.3441295-1-b-padhi@ti.com>
References: <20240829060932.3441295-1-b-padhi@ti.com>
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
v4: Changelog:
1) Put standard properties (resets, firmware-name) before vendor
specific properties in added DT Nodes. (Nishanth)

Link to v3:
https://lore.kernel.org/all/20240828112713.2668526-2-b-padhi@ti.com/

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
index cadb4f7c2ea9..ed6f4ba08afc 100644
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
+			resets = <&k3_reset 262 1>;
+			firmware-name = "j722s-main-r5f0_0-fw";
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <262>;
+			ti,sci-proc-ids = <0x04 0xff>;
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
+		resets = <&k3_reset 208 1>;
+		firmware-name = "j722s-c71_0-fw";
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <208>;
+		ti,sci-proc-ids = <0x30 0xff>;
+		status = "disabled";
+	};
+
+	c7x_1: dsp@7e200000 {
+		compatible = "ti,am62a-c7xv-dsp";
+		reg = <0x00 0x7e200000 0x00 0x00200000>;
+		reg-names = "l2sram";
+		resets = <&k3_reset 268 1>;
+		firmware-name = "j722s-c71_1-fw";
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <268>;
+		ti,sci-proc-ids = <0x31 0xff>;
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


