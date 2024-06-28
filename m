Return-Path: <linux-kernel+bounces-234116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFF891C265
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7865C1F24CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65D31CE0B7;
	Fri, 28 Jun 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y13SUzF4"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826341CE087;
	Fri, 28 Jun 2024 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587740; cv=none; b=Zlxfb5nvVPLAdEhZxNSmKuZ2bV7VN52igK86ROC8cbmgUrOCcOAfL4w6Lsw7jMia7LniL60ZGpFxaQqUvvhLfF8JZtcrJhR2d6LnZ555nA8shkc5VbmLDCS4ZmXkqzFSAxC/TllT5V+VeoMRmLulD2XC9w2iWpxjc6axBt7IBd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587740; c=relaxed/simple;
	bh=UFzp48sdTV7PnHlUaB78IqGx/4CcREbpJVqW3suBwDg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBWsey/dEL+4+6WO1iWPQEcXUA9PFiTaYTlEx/wIvC5wC+id0DMmZh+Pcp2KtT7tPhO17PPV9dXf7VElX7TT60+Y6vsUKGTap1Njuse7N7nAd1FgqbrjkwNaOPBUTZ/8uYcyaE1P1iMOZ8TBBqIRsDZsDYyGPOQ2k5ErxBr+CXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y13SUzF4; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFMjE001304;
	Fri, 28 Jun 2024 10:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719587722;
	bh=EjRGWqtSA2M5g2YzMIZ4ttfcV4c5LM6Vt+zr7WjOyhc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Y13SUzF4K7Fm1rLky8KcsQwoMWm4UIDV1rgphuBsX/vDBdNuXcqUmBNeWlA3qXzUw
	 9tIaP1PyzROJoiqvrsLpBTM/gClRW6hCHMOKV5utyseS2u3AUUUIqNdC4GsY79c4Cc
	 0VSxHNFZjLQbDw2SfD/5UNC0onO6SfKDeTBcXZmk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SFFMUD071759
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 10:15:22 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 10:15:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 10:15:21 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFJlY087911;
	Fri, 28 Jun 2024 10:15:21 -0500
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
Subject: [PATCH 5/7] arm64: dts: ti: k3-j784s4: Add cpsw-mac-efuse node to mcu_conf
Date: Fri, 28 Jun 2024 10:15:16 -0500
Message-ID: <20240628151518.40100-6-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 2e18d91ae92f8..f3a6ed1c979d0 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -145,12 +145,16 @@ mcu_timerio_output: pinctrl@40f04280 {
 		status = "reserved";
 	};
 
-	mcu_conf: syscon@40f00000 {
-		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
-		reg = <0x00 0x40f00000 0x00 0x20000>;
+	mcu_conf: bus@40f00000 {
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0x00 0x00 0x40f00000 0x20000>;
+		ranges = <0x0 0x0 0x40f00000 0x20000>;
+
+		cpsw_mac_syscon: ethernet-mac-syscon@200 {
+			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
+			reg = <0x200 0x8>;
+		};
 
 		phy_gmii_sel: phy@4040 {
 			compatible = "ti,am654-phy-gmii-sel";
@@ -553,7 +557,7 @@ mcu_cpsw_port1: port@1 {
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


