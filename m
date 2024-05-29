Return-Path: <linux-kernel+bounces-193730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1752F8D3139
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38DD2944B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD23E16EC02;
	Wed, 29 May 2024 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D/NZDMyh"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B2172BB1;
	Wed, 29 May 2024 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971013; cv=none; b=Q3jSYmOAKP0MzdkcKWpAAH8UlYvsvZg4sqtmbV+5pV2aczPEfszYBo7vb6lZmL02oUj7XpHhqbzjscbHWir1fVPw/HGmPEAxoBhng/zbJu0nC7kovZaOHBjvEVzPt3XxuXohDxmiDp8HWTgaAbFs5CbruzwfvvcMV6CUz0M9dEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971013; c=relaxed/simple;
	bh=AD9oGYs/vuo7I65xvnNGZGgh0R1EloxnLrxqTPiAuQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7gSD+403BVefe9ZtLXCLHAp+3VyuVs3Hryveggw0qf54b5xyPemxPbdLm+sVL3nRn/CRUjWS6xYbEIcE80Hlh21EVSB48o3qTEHz2QypPebCFcrjnfgEt1j1VyhQBmDv1kP6JtKPaP/rq9/Ef0+QUI/49k5P7GInBiV9+f7sEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D/NZDMyh; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T8NNQ1028215;
	Wed, 29 May 2024 03:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716971003;
	bh=rFJvQzV8kqV3Z6+ZhkYla/WZjye7srpWKlW2xEYN7Qo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=D/NZDMyhhSJ3tgw4sy/+yBO1P3gGeEumdVMXLivRjTa2GN2jQF9M8ATi3SCB1nnSw
	 5mBzq5+VUi95IkryojrQSdNQWh8bGu3nzxpE5Q6XthwBEZSRQrYbA1XbRGHB1g7WjF
	 f+E3fSrqjbVpK3bcVRN4rKhwW1HfA7sq0nwKWPHY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T8NN7s002842
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 03:23:23 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 03:23:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 03:23:22 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T8N0dA084708;
	Wed, 29 May 2024 03:23:18 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <francesco@dolcini.it>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sabiya.d@ti.com>,
        <u-kumar1@ti.com>, <danishanwar@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 4/4] arm64: dts: ti: k3-am69-sk: Add PCIe support
Date: Wed, 29 May 2024 13:52:59 +0530
Message-ID: <20240529082259.1619695-5-s-vadapalli@ti.com>
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

From: Dasnavis Sabiya <sabiya.d@ti.com>

The AM69-SK board has 3 instances of PCIe namely PCIe0, PCIe1 and PCIe3.
The x4 PCIe0 instance is connected to a Card Edge connector via SERDES1.
The x2 PCIe1 instance is connected to an M.2 M Key connector via SERDES0.
The x1 PCIe3 instance is connected to an M.2 E Key connector via SERDES0.

Add device-tree support for enabling all 3 PCIe instances in Root-Complex
mode of operation.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
This patch has been added newly in this series.

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 60 +++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index d88651c297a2..14c359d810d7 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -1203,3 +1203,63 @@ partition@3fc0000 {
 		};
 	};
 };
+
+&serdes_ln_ctrl {
+	idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>, <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
+		      <J784S4_SERDES0_LANE2_PCIE3_LANE0>, <J784S4_SERDES0_LANE3_USB>,
+			<J784S4_SERDES1_LANE0_PCIE0_LANE0>, <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
+			<J784S4_SERDES1_LANE2_PCIE0_LANE2>, <J784S4_SERDES1_LANE3_PCIE0_LANE3>;
+};
+
+&serdes_wiz0 {
+	status = "okay";
+};
+
+&serdes0 {
+	status = "okay";
+	serdes0_pcie_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <3>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>, <&serdes_wiz0 3>;
+	};
+};
+
+&serdes_wiz1 {
+	status = "okay";
+};
+
+&serdes1 {
+	status = "okay";
+	serdes1_pcie_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <4>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>, <&serdes_wiz1 3>, <&serdes_wiz1 4>;
+	};
+};
+
+&pcie0_rc {
+	status = "okay";
+	reset-gpios = <&exp1 4 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes1_pcie_link>;
+	phy-names = "pcie-phy";
+};
+
+&pcie1_rc {
+	status = "okay";
+	reset-gpios = <&exp1 5 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <2>;
+};
+
+&pcie3_rc {
+	status = "okay";
+	reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes0_pcie_link>;
+	phy-names = "pcie-phy";
+	num-lanes = <1>;
+};
-- 
2.40.1


