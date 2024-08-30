Return-Path: <linux-kernel+bounces-309142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169F69666AC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE291F214C5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B451B81DE;
	Fri, 30 Aug 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F/BCF2Ll"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0FB14F130;
	Fri, 30 Aug 2024 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034682; cv=none; b=EGzWO7VPDLo5CfgMWj5od4DliEQqH1Ftrwk2zZwOe7JVvKcRiJyvMNgUbu+7iSpfeuG41yTDz9Zxp5jb/GrmZ6HK0WPIIv8skIbELwq93M4jPByWAZ7+/Sh+GK2NeQnVWTAIf/mtty04moMjfBiasOtK57bNX/0FMY0/ypoLBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034682; c=relaxed/simple;
	bh=fhpWDpfwQlH75vPk0Mf66qOpqEk+G2LvhEppvSKU/K0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgIvvyzhDU7SEh7U01HUJEjFK7G+YjF5NiDhN1hlivJrbuTARzi2eti7Jh1pOF1GaeOWfLEWpjx4X2Xp7XdpCMXG67CdvL4PAiWrb15/8T8pYd0iZt++3tlNTU4BUi6mdy6VlhyPYhGvPXx+AwOJ6q2SuEg/pWqnFEn7pe5q8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=F/BCF2Ll; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UGHpa9066724;
	Fri, 30 Aug 2024 11:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725034671;
	bh=DhekLUAz8k/SYochinI0gHjVHHz9+x99j+ULBxqC+jg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=F/BCF2LlWtwfMWiAdmBqaTrs9FQ89LQJbm0coRDi4/A3FRabJMbyoQS4XGaxxLGUF
	 Uz0WPZY4g6C3rsJP0ocaqwN7yZD0bPf4eR8WoNPYNJdzu4W1Xt9/0ZnMDew5Qz3ov7
	 YPGvN/EXVqs6Z2GVNQm47FCYqmVSjeomHuWNpj7Y=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UGHpn1064189;
	Fri, 30 Aug 2024 11:17:51 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 11:17:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 11:17:50 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UGHhRb103243;
	Fri, 30 Aug 2024 11:17:47 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <j-choudhary@ti.com>, <vaishnav.a@ti.com>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 1/2] arm64: dts: ti: k3-j722s-main: Add R5F and C7x remote processor nodes
Date: Fri, 30 Aug 2024 21:47:41 +0530
Message-ID: <20240830161742.925145-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830161742.925145-1-b-padhi@ti.com>
References: <20240830161742.925145-1-b-padhi@ti.com>
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
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
---
v5: Changelog:
1) Collected Reviewed-by tags from Udit and Andrew given in v4 revision
of this patch.

Link to v4:
https://lore.kernel.org/all/20240829060932.3441295-2-b-padhi@ti.com/

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


