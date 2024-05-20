Return-Path: <linux-kernel+bounces-183595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077B68C9B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6041C21A08
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2E64F1F9;
	Mon, 20 May 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kknTgXkC"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18164E1CB;
	Mon, 20 May 2024 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199945; cv=none; b=OJuHdm7XKvVirpVhQ1HShrcFVMpaPPluowLBE/4UPbff3qU7aj/gKMkhHGZA2areX3QvWbPXilpwt2TfliDNovdNszEghzEBX8XD+jZj+bS0XWKSkSqhkUQFMh8M3yhrF8yXOMmLTSxY0t4pDocJ2dNGfA5+5euFn6/zARm0eis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199945; c=relaxed/simple;
	bh=B7UGf62VIlfbsuG41GpXoPMlwig2i+WLhtcuxN9rsUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kE96nyx6rHRb/+0wPCnqZfzDYk7IMfL2/J4/MsRLJQkqc5C9TLG4MycgYe3s6/v/YBbG3IQtb6+6hFYwfxcS4zH8Gla2ot0/C6iwGcpt3zZoQ1JJjuXyjVs9TXImqt1SE3mPcCCZtq8nS1/GEp4xcAtOppr8M14Sp6H21JZ6EvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kknTgXkC; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44KAC16i078594;
	Mon, 20 May 2024 05:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716199921;
	bh=0adn+D3xwf79tqNaR78Q3qvk0G7vP3pbuZLrIFjpqLg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kknTgXkC83j92N/IpQQ2PlEndOBP73V8bP5RbiQRK6AfF5yMUdKuNe7lUUAMa7xMA
	 8s//1OYnY+/ssKde9SF+pZRaLyqZ06a5pIL/VPeLYlpMhcwcG67EtloCtNKxKGb0fo
	 XWhWAWEfwaHcyT+mQKWfzRPOO8L0bmDRaUva7aVk=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44KAC1hV067710
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 May 2024 05:12:01 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 May 2024 05:12:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 May 2024 05:12:00 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44KABnjU060604;
	Mon, 20 May 2024 05:11:57 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <danishanwar@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode
Date: Mon, 20 May 2024 15:41:48 +0530
Message-ID: <20240520101149.3243151-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240520101149.3243151-1-s-vadapalli@ti.com>
References: <20240520101149.3243151-1-s-vadapalli@ti.com>
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
v1:
https://lore.kernel.org/r/20240129114749.1197579-3-s-vadapalli@ti.com/
Changes since v1:
- NA

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


