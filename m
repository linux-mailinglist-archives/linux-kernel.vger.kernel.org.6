Return-Path: <linux-kernel+bounces-306198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD2F963B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E187EB25BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2E217837E;
	Thu, 29 Aug 2024 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jwb1pXpI"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5A614B96F;
	Thu, 29 Aug 2024 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911792; cv=none; b=ary3fQrVf+SWjQiBj6SgeYIs25423FedEA6CBucjq0nRuaE2B9RDVe6drAma55HG69xAFxTTeaQWfRnFtqbfPUy9az9bhkBMOI44edFJ8Ij8WAyqE9JzwI5HbWSiMrwAJ/hSVzMIH2nqeqQwI+T1fwlB7ADf9PlGR0Whxdw+skw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911792; c=relaxed/simple;
	bh=E18KCSEO1P6gK1opFctjc1u2+ZEMHv98uvCXZhRWb+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H16wbqkDdVhX+a3ANTqyrPltw+Xnt7DMaJvGVtPr57WW2btxrzcZ3sIf29lNYCCBOr9K7Z6WH0xGh/VQPH+GWh1leQU7DSNZL7jXqh5ng2RB8vmP+2Bj95Q7+yD9awGRJzEF1ZzataP+cSRJBuczkU6fSUyHFZLTnNmqeh0S544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Jwb1pXpI; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47T69i2x046266;
	Thu, 29 Aug 2024 01:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724911784;
	bh=00DAZbq1zfJzTYRRMqNrRuL6F1cYf0kUrd9Rz/om+GQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Jwb1pXpI1OTFLBn66IMUOsCaAIg1IwYEf4Ov3ZzSrFjxLGLt1os98BlFlMxS1IoJ+
	 N8wDOZIsxq0jzw7TxptwV+A9P5WNAEDKRr7gVlIqd5rfg4AjfruPgL7zmxN+s0va1L
	 TZyIHFD8RiB5w9YB6s4bhNhQkDQFRYIQ1BShG4/A=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47T69i6Q011067
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 01:09:44 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 01:09:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 01:09:44 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47T69XCK126434;
	Thu, 29 Aug 2024 01:09:41 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <u-kumar1@ti.com>, <j-choudhary@ti.com>, <vaishnav.a@ti.com>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 2/2] arm64: dts: ti: k3-j722s-evm: Enable Inter-Processor Communication
Date: Thu, 29 Aug 2024 11:39:32 +0530
Message-ID: <20240829060932.3441295-3-b-padhi@ti.com>
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

The K3 J722S-EVM platform is based on the J722S SoC which has one
single-core Arm Cortex-R5F processor in each of the WAKEUP, MCU and MAIN
voltage domain, and two C71x DSP subsystems in MAIN voltage domain.

The Inter-Processor communication between the A72 cores and these R5F
and DSP remote cores is achieved through shared memory and Mailboxes.
Thus, add the memory carveouts and enable the mailbox clusters required
for communication.

Also, The remoteproc firmware like of R5F and DSPs in the MAIN voltage
domain use timers. Therefore, change the status of the timer nodes to
"reserved" to avoid any clash during booting of remotecores. Usage is
described as below:

	+===================+=============+
	|  Remoteproc Node  | Timer Node  |
	+===================+=============+
	| main_r5fss0_core0 | main_timer0 |
	+-------------------+-------------+
	| c7x_0             | main_timer1 |
	+-------------------+-------------+
	| c7x_1             | main_timer2 |
	+-------------------+-------------+

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
[ Enabled mailbox instances and Reserved timer nodes ]
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v4: Changelog:
1) Moved "status" property to the end in all the extended DT nodes added
in this patch.
2) Preceded child-nodes by a single blank line in the extended DT nodes
added in this patch.

Link to v3:
https://lore.kernel.org/all/20240828112713.2668526-3-b-padhi@ti.com/

v3: Changelog:
1) Reserved conflicting timer nodes with remoteproc firmware (reflected the same
in commit message).
2) Simplified $subject to clarify that this patch enables IPC and transferred
the details into commit message.

Link to v2:
https://lore.kernel.org/all/20240612112259.1131653-3-b-padhi@ti.com/

v2: Changelog:
1) Squashed Patch 2 and 3 from V1 into Patch 2 in V2 as they were doing
the same logical thing.

Links to v1:
https://lore.kernel.org/all/20240607090433.488454-3-b-padhi@ti.com/
https://lore.kernel.org/all/20240607090433.488454-4-b-padhi@ti.com/


 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 157 ++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index dd3b5f7039d7..38620c76c3be 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -51,12 +51,71 @@ secure_ddr: optee@9e800000 {
 			no-map;
 		};
 
+		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0000000 0x00 0x100000>;
+			no-map;
+		};
+
 		wkup_r5fss0_core0_memory_region: r5f-memory@a0100000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xa0100000 0x00 0xf00000>;
 			no-map;
 		};
 
+		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@a1000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1000000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@a1100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_dma_memory_region: main-r5fss-dma-memory-region@a2000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_memory_region: main-r5fss-memory-region@a2100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c7x_0_dma_memory_region: c7x-dma-memory@a3000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c7x_0_memory_region: c7x-memory@a3100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c7x_1_dma_memory_region: c7x-dma-memory@a4000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c7x_1_memory_region: c7x-memory@a4100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		rtos_ipc_memory_region: ipc-memories@a5000000 {
+			reg = <0x00 0xa5000000 0x00 0x1c00000>;
+			alignment = <0x1000>;
+			no-map;
+		};
 	};
 
 	vmain_pd: regulator-0 {
@@ -494,6 +553,104 @@ &sdhci1 {
 	bootph-all;
 };
 
+&mailbox0_cluster0 {
+	status = "okay";
+
+	mbox_r5_0: mbox-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	status = "okay";
+
+	mbox_mcu_r5_0: mbox-mcu-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster2 {
+	status = "okay";
+
+	mbox_c7x_0: mbox-c7x-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster3 {
+	status = "okay";
+
+	mbox_main_r5_0: mbox-main-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_c7x_1: mbox-c7x-1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+/* Timers are used by Remoteproc firmware */
+&main_timer0 {
+	status = "reserved";
+};
+
+&main_timer1 {
+	status = "reserved";
+};
+
+&main_timer2 {
+	status = "reserved";
+};
+
+&wkup_r5fss0 {
+	status = "okay";
+};
+
+&wkup_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
+	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
+			<&wkup_r5fss0_core0_memory_region>;
+};
+
+&mcu_r5fss0 {
+	status = "okay";
+};
+
+&mcu_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+};
+
+&main_r5fss0 {
+	status = "okay";
+};
+
+&main_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster3 &mbox_main_r5_0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
+};
+
+&c7x_0 {
+	mboxes = <&mailbox0_cluster2 &mbox_c7x_0>;
+	memory-region = <&c7x_0_dma_memory_region>,
+			<&c7x_0_memory_region>;
+	status = "okay";
+};
+
+&c7x_1 {
+	mboxes = <&mailbox0_cluster3 &mbox_c7x_1>;
+	memory-region = <&c7x_1_dma_memory_region>,
+			<&c7x_1_memory_region>;
+	status = "okay";
+};
+
 &serdes_ln_ctrl {
 	idle-states = <J722S_SERDES0_LANE0_USB>,
 		      <J722S_SERDES1_LANE0_PCIE0_LANE0>;
-- 
2.34.1


