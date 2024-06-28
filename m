Return-Path: <linux-kernel+bounces-234117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8E691C266
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2C61F24EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD4C1CF3C1;
	Fri, 28 Jun 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BNDyzQ3x"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4281CE08A;
	Fri, 28 Jun 2024 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587740; cv=none; b=nEy+qfUg5/b6O9kIJ8FjckJWgSf8GVVl1yBoF5bnyfuOJrHcDD8IX+37f8e2imEd2ROtadKVqDso2PIeV/TrkNUqhqb9cy0RMV/3tqwdayoq3bTVZQkNfv9oDFVs5nm8TegLydNUKuOrUJsibRYX159pHepoP7/QzBauCU2AE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587740; c=relaxed/simple;
	bh=oHVv0/SCCVI3F7WFGHyeGNhEBrtKYoQxxA0t6HyZu60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmkTlbg33GLBtxb+J6rDNEN+fPCdlQTAsujLj6f+bWOR5jTc5UO2vfcfbYEepsRwaQbV8rVjNnN07U7/qSYNJ5pzoGOTygjvZBabMpGluinLyo61m1pJI7RfipgQDMdGe+hJY9ZdOtl7ykzUhRbRU3nlFbdY4VexjBaQW2LSLtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BNDyzQ3x; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFK5M106479;
	Fri, 28 Jun 2024 10:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719587720;
	bh=bX/INQxCOvUYPBjtz6cmPeM5ZIJqmCkwp95Q9pPdEYo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BNDyzQ3xSp6HksXShakkm93iMEKI26qr8i+e1YSXz31X32tL4wvIhbgn7Qzc0xgig
	 iCwf+Eh9ya3GklmKrtjyoK34v4B1v8a7XJgiy1n8Urev/VtNvQDhKxPIG+WDrEZ8gH
	 z7cHEaTVragtgACxTo/2Jdu94H+qRu3P5laXFOTY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SFFK8o071748
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 10:15:20 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 10:15:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 10:15:20 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFJlU087911;
	Fri, 28 Jun 2024 10:15:19 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/7] arm64: dts: ti: k3-am65: Add cpsw-mac-efuse node to mcu_conf
Date: Fri, 28 Jun 2024 10:15:12 -0500
Message-ID: <20240628151518.40100-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628151518.40100-1-afd@ti.com>
References: <20240628151518.40100-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The MCU system controller address region contains an eFuse block with
MAC addresses to be used by the Ethernet controller. The property
“ti,syscon-efuse” contains a phandle to a syscon region and an offset
into this region where the MAC addresses can be found. Currently
"ti,syscon-efuse" points to the entire system controller address space
node with an offset to the eFuse IP address.

Instead add a cpsw-mac-efuse node to describe the exact eFuse area. Then
point the Ethernet controller directly to this region, no offset needed.

This makes it so the system controller memory area does not need to be one
big syscon area, describe this bus address area as the simple-bus it is.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 8feab93176447..43c6118d2bf0f 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -6,13 +6,17 @@
  */
 
 &cbass_mcu {
-	mcu_conf: scm-conf@40f00000 {
-		compatible = "syscon", "simple-mfd";
-		reg = <0x0 0x40f00000 0x0 0x20000>;
+	mcu_conf: bus@40f00000 {
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x40f00000 0x20000>;
 
+		cpsw_mac_syscon: ethernet-mac-syscon@200 {
+			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
+			reg = <0x200 0x8>;
+		};
+
 		phy_gmii_sel: phy@4040 {
 			compatible = "ti,am654-phy-gmii-sel";
 			reg = <0x4040 0x4>;
@@ -358,7 +362,7 @@ cpsw_port1: port@1 {
 				reg = <1>;
 				ti,mac-only;
 				label = "port1";
-				ti,syscon-efuse = <&mcu_conf 0x200>;
+				ti,syscon-efuse = <&cpsw_mac_syscon 0x0>;
 				phys = <&phy_gmii_sel 1>;
 			};
 		};
-- 
2.39.2


