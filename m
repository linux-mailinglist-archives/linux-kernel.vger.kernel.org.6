Return-Path: <linux-kernel+bounces-187373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208A18CD0E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D989D281836
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3773614532A;
	Thu, 23 May 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NOobIZkk"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D01448D4;
	Thu, 23 May 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462631; cv=none; b=TOnmoVIOnqddp5xqQzwQU+n+CNNKSU/a7eD1dXzHi4kGph0zZyOnqIglvlILdzKjaxVqqqh9Y5POW750VLxZuctGUpD0e/O6WEt2EK5HXgHphlOaVQOekHxJ8tl7BwvGTmjkh3XY8n+f/jp3oIZ18/592wPy1EwoL92BYK7e9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462631; c=relaxed/simple;
	bh=A2xGuvCqGKAf/y7/bl68wiq0u8UEAzk+qWGV90ELDNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+ahaJXiFaHWAH8mOkx01eHbZic5JPmUyiyPBH+tC3NW4FSZxTdI3l5QF1IO2j6AcOKGp4pk4pb3Cb6ruqAaaQrAJcdewvpzgk07ECJRDEV29piwnYslJbUt1PyUuMrtvw85rAY/wdO//yd6k7hq8qgR9VdLdUa8jDgJaXppTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NOobIZkk; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44NBAMCF092654;
	Thu, 23 May 2024 06:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716462622;
	bh=2i5urqhchcFxMy4WKG+AtWrr1gKGq/EvNrmiggHJB0A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NOobIZkkfXkfgft0bWi9d0/LyLvXzNvzcqlSmEWdzqwslx17stmK+R+Tmz5Ihe+hv
	 aCDTFmEpkfQzG6hT0j2X9ELBVNdr6LUa0IXOga/izkaJ5X6EKYcTRnU+VgSiLf2qtb
	 mxPjh6gTsOnQeiGPgqjHNOxK19F7IRrcKG9UddJw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44NBAMuX045823
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 May 2024 06:10:22 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 06:10:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 06:10:21 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44NBA9Ec082115;
	Thu, 23 May 2024 06:10:18 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <francesco@dolcini.it>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <danishanwar@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 2/3] arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode
Date: Thu, 23 May 2024 16:40:07 +0530
Message-ID: <20240523111008.4057988-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240523111008.4057988-1-s-vadapalli@ti.com>
References: <20240523111008.4057988-1-s-vadapalli@ti.com>
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


