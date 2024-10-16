Return-Path: <linux-kernel+bounces-368895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AAA9A1633
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174B31C21DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D301D63DF;
	Wed, 16 Oct 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ds0gdHEe"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E011D5ABE;
	Wed, 16 Oct 2024 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729121466; cv=none; b=du80Uw/RXs8G6E3Gd9xMHbjzAOhE3bW91Ri0Y1XyTsY3q5DNLPauQdBd8PVZKuDOM4DWqDux9egQJm5UGG/wdHct04n79EpyU3TcMy9iz0A2++XYMa3T0S68DEnnP3h9LPzmsCirETlKnVhmfhf8S0D8vZ51DzaploJqkhfOUR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729121466; c=relaxed/simple;
	bh=nA0RE8tX12e28bYjQkkUvdt6eLsQzyRzH+TpAKmSYZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lb0S9VuS9Z6L1XlmQgtKyblCbnz1Kco2Q/TZN1RfBD+73QjdU4XFNwIqwJewU1p3wQskFKJdWSzUpJS3ZrXww8AYVVtR6kkB49ZRa0lO5BeU0yBdKwLxewKdXLIAYL5KqML+1BfEkAb9sojRYYsZNgVzyTRL855BtGcVGxWOnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ds0gdHEe; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49GNUlbM053750;
	Wed, 16 Oct 2024 18:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729121447;
	bh=v3vQxJMPxC/rFVD7hZcDs0KM4zN+9zW2SXYuhWcXwSs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ds0gdHEes7RPbfS+hiymtycqhcbwquo2jDhnk/DCnHD27thBPI099X5ud9zaPYf3s
	 g9wPmeMkeCX1/PKP2QY81aWek6Uty8YPZnGGm/GdEPdNN8OnFOvEiS/eOcdyp47vZy
	 bI/UfdciArl9O79Qg3h+l44Idp00ScZ9xMuwsZT8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49GNUlmE011750
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Oct 2024 18:30:47 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Oct 2024 18:30:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Oct 2024 18:30:47 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49GNUj7l070988;
	Wed, 16 Oct 2024 18:30:46 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 4/5] arm64: dts: ti: k3-j721s2: Add PCIe ctrl node to scm_conf region
Date: Wed, 16 Oct 2024 18:30:43 -0500
Message-ID: <20241016233044.240699-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241016233044.240699-1-afd@ti.com>
References: <20241016233044.240699-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This region is used for controlling the function of the PCIe IP. It is
compatible with "ti,j784s4-pcie-ctrl", add this here and use it with
the PCIe node.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso | 2 +-
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso b/arch/arm64/boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso
index 5ff390915b75b..8c2cd99cf2b42 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso
@@ -38,7 +38,7 @@ pcie1_ep: pcie-ep@2910000 {
 		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&scm_conf 0x074>;
+		ti,syscon-pcie-ctrl = <&pcie1_ctrl 0x0>;
 		max-link-speed = <3>;
 		num-lanes = <1>;
 		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 9ed6949b40e9d..b32b0ce8be462 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -57,6 +57,11 @@ phy_gmii_sel_cpsw: phy@34 {
 			#phy-cells = <1>;
 		};
 
+		pcie1_ctrl: pcie-ctrl@74 {
+			compatible = "ti,j784s4-pcie-ctrl", "syscon";
+			reg = <0x74 0x4>;
+		};
+
 		serdes_ln_ctrl: mux-controller@80 {
 			compatible = "reg-mux";
 			reg = <0x80 0x10>;
@@ -1398,7 +1403,7 @@ pcie1_rc: pcie@2910000 {
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&scm_conf 0x074>;
+		ti,syscon-pcie-ctrl = <&pcie1_ctrl 0x0>;
 		max-link-speed = <3>;
 		num-lanes = <4>;
 		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
-- 
2.39.2


