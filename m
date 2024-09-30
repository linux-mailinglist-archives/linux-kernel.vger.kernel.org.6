Return-Path: <linux-kernel+bounces-343840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF4B98A025
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6C928365F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C56F18D63F;
	Mon, 30 Sep 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="klhcrj9R"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F4189BAC;
	Mon, 30 Sep 2024 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727694918; cv=none; b=YstRjWAhg9RPZELiYjAognljiYDdsdBSYq9Bca2xded9ZYkeF9/7la76vivr7hpqRIMWXAy1r7HX/n3al3kEU4ZPc9CPFnlwPh4mu675kDsYkPfq0uJFkLh8D4IUJr3ONa2saaN15RuQqpiHazO6AoAv23GS9oVzHXtizzWp5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727694918; c=relaxed/simple;
	bh=CKaTzLzt5Ay9NRYZSPhS9mvPXNtg1LNXzUb/dJPkJBg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C03Xw0IvwJQoWS5ZBQwTY9VJf/oRQK1OcwaSINSp985kyYYjBGtKREf/V1qitnXP9HQB96o4ngEx0zsrAmJ+P8SxqTVHRpe1MgKnrss4tdr5HCsvHRYd4PD30lEev4QeT3p4vZRGhi3w/dQ7HS40o87oiA4hV/j9K/+F8orLzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=klhcrj9R; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48UBF9Ds072041;
	Mon, 30 Sep 2024 06:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727694909;
	bh=/6aOaHEijaebC4X0cTgxm/vVUhcilH7QcmkZ4BzLP5M=;
	h=From:To:CC:Subject:Date;
	b=klhcrj9Ra15EYq+691UjIE3iMLFUgjp8k2jQjO5CgrtBc5K3C+jeLmj1eDKa5yX09
	 6LkgFywCuelkbw+bNJe/VoJJ8OCZghHQ1J78rFmqS7AskkJgWZ4+xTWHYMzYp3RuAP
	 KJVkkWQDwFLpS5TyLxMLKTnaqg+1gGYVF4k0n2I0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48UBF9Ii122516
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Sep 2024 06:15:09 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Sep 2024 06:15:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Sep 2024 06:15:09 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48UBF5Eo130049;
	Mon, 30 Sep 2024 06:15:06 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-j784s4-main: Enable ACSPCIE output for PCIe1
Date: Mon, 30 Sep 2024 16:45:05 +0530
Message-ID: <20240930111505.3101047-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The PCIe reference clock required by the PCIe Endpoints connected to the
PCIe connector corresponding to the PCIe1 instance of PCIe on J784S4-EVM
is driven by the ACSPCIE module. Add the device-tree support for enabling
the same.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240930.
The dependencies mentioned in the v1 patch have been merged and this
patch doesn't have dependencies anymore.

v1:
https://lore.kernel.org/r/20240715123301.1184833-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased patch on next-20240930.

Logs validating this patch with an NVMe SSD connected to the PCIe connector
corresponding to the PCIe1 instance of PCIe on J784S4 EVM:
https://gist.github.com/Siddharth-Vadapalli-at-TI/19a878518b657df434396b4bed78f945

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index e73bb750b09a..bef115575cab 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/mux/mux.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-cadence.h>
 #include <dt-bindings/phy/phy-ti.h>
 
 #include "k3-serdes.h"
@@ -81,6 +82,11 @@ pcie3_ctrl: pcie3-ctrl@407c {
 			reg = <0x407c 0x4>;
 		};
 
+		acspcie0_proxy_ctrl: acspcie0-ctrl@1a090 {
+			compatible = "ti,j784s4-acspcie-proxy-ctrl", "syscon";
+			reg = <0x1a090 0x4>;
+		};
+
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
 			reg = <0x00004080 0x30>;
@@ -1094,11 +1100,12 @@ pcie1_rc: pcie@2910000 {
 		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
 		ti,syscon-pcie-ctrl = <&pcie1_ctrl 0x0>;
+		ti,syscon-acspcie-proxy-ctrl = <&acspcie0_proxy_ctrl 0x1>;
 		max-link-speed = <3>;
 		num-lanes = <4>;
 		power-domains = <&k3_pds 333 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 333 0>;
-		clock-names = "fck";
+		clocks = <&k3_clks 333 0>, <&serdes0 CDNS_TORRENT_REFCLK_DRIVER>;
+		clock-names = "fck", "pcie_refclk";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		bus-range = <0x0 0xff>;
-- 
2.40.1


