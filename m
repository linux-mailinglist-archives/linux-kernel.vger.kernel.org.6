Return-Path: <linux-kernel+bounces-193726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641F98D315A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD27B2BD9E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C935916E89C;
	Wed, 29 May 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XtKwjEiI"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA116DED5;
	Wed, 29 May 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971006; cv=none; b=hODGOXHL2lwjbetGCRQFhND0PdQbS2JHhP75a97Qs4NRg5BVgs2VsTsUnpfUKnhMi/c/yQJuYsA+p5H3bCRKcAm4ac/RDu+d4Y5GK/9FtupXguyxEkxdKMi3ZtLhhhYFg/YOzDpFeyNUvz/EC4vZ63peOlM/E8uTE3ddVcdCNqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971006; c=relaxed/simple;
	bh=VnVBIeiO8J5Og0O5hAYi41IbHAakSkvSUNs+FoobE7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2BJJJ4TVPm/HWQHNdn+72t7eYDEZHKGofJhr9zymZ/8QnXSwfgnqBjKmjYHAKnOHTmR2CUsPD9242kNV0ibpQvutG3D+426w5XaTs1VV8lL24g2YuCoVzEUVixZo399ow3hfhEisgiawo2zjwCitIK6f6FVu4zdDxRQ5Vvgn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XtKwjEiI; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T8NEr1056641;
	Wed, 29 May 2024 03:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716970994;
	bh=ejZRiHRsr4ih1uE2oZpoLmUZbqu9MwySwj0E6XJhQ90=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XtKwjEiIdORVt1+ZUwdJ190FA3xDMB6W2rW2YRulMFth9mFyJF/+DMrPN23N07uxp
	 EW0wVciUVqEPw3WAs+2wiHRj7PNouqdFM5ZGhsadylxHGoJGsUMSIVF5DrinLLIrLO
	 4UB3uvpdi8FsOMWptomR9N+8IfC3f6r5ShiXFRMo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T8NE0H068085
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 03:23:14 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 03:23:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 03:23:13 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T8N0d8084708;
	Wed, 29 May 2024 03:23:09 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <francesco@dolcini.it>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sabiya.d@ti.com>,
        <u-kumar1@ti.com>, <danishanwar@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 2/4] arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode
Date: Wed, 29 May 2024 13:52:57 +0530
Message-ID: <20240529082259.1619695-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240529082259.1619695-1-s-vadapalli@ti.com>
References: <20240529082259.1619695-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Enable PCIe0 and PCIe1 instances of PCIe in Root Complex mode of
operation on J784S4 EVM. The lanes of PCIe0 are connected to Serdes1
instance of Serdes while the lanes of PCIe1 are connected to Serdes0
instance of Serdes in J784S4 SoC. Despite both PCIe instances supporting
up to 4 Lanes, since the physical connections to the PCIe connector
corresponding to the PCIe1 instance of PCIe are limited to 2 Lanes on
the J784S4 EVM, update the "num-lanes" property of PCIe1 accordingly.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
v3:
https://lore.kernel.org/r/20240523111008.4057988-3-s-vadapalli@ti.com/
No changes since v3.

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index d511b25d62e3..31e88a6445f4 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -1105,3 +1105,49 @@ dp0_out: endpoint {
 		};
 	};
 };
+
+&serdes0 {
+	status = "okay";
+	serdes0_pcie1_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <4>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>,
+			 <&serdes_wiz0 3>, <&serdes_wiz0 4>;
+	};
+};
+
+&serdes_wiz0 {
+	status = "okay";
+};
+
+&pcie1_rc {
+	status = "okay";
+	num-lanes = <2>;
+	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie1_link>;
+	phy-names = "pcie-phy";
+};
+
+&serdes1 {
+	status = "okay";
+	serdes1_pcie0_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <2>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>;
+	};
+};
+
+&serdes_wiz1 {
+	status = "okay";
+};
+
+&pcie0_rc {
+	status = "okay";
+	reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes1_pcie0_link>;
+	phy-names = "pcie-phy";
+};
-- 
2.40.1


