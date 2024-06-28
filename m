Return-Path: <linux-kernel+bounces-234114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC391C260
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243201C227A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1871CE094;
	Fri, 28 Jun 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bg0fZZGL"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F931CE080;
	Fri, 28 Jun 2024 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587739; cv=none; b=FmC3ltUaHS+Bfs/ipPqub+ga+E0seXg64dMQSj7Q0UmtoIRMr2yLKFkyzG9d+RfzVE4D5+FBxWgfgJFeY7q+k1k+RIwRo94JmHLwFs6Nz0GePGxOds7Xj3CWW2WfktYUsu2J0OBaG3EWwy+NFK/2oXrUR+Ni6VR+aiey6o/rteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587739; c=relaxed/simple;
	bh=JjXBjmoqRLrivIjxwcsq2rz3H88BzVco+4kVndO5Qz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wk5VKSZ8RfdKZMBzrzyoo/xEp1u2swp7k0LrCgvB+u4/2R2B5Tq+63ygi6yynciqe21r630EXRZFQ8ReGDTtW7xnQjnQy4A9Haz9fnCEqDRHgfj2edDaWVqKiMRCluzwwzPGkOhLrNcojBt8LZJyk0487dHmTsZUtwj//eBgDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Bg0fZZGL; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFLVY116473;
	Fri, 28 Jun 2024 10:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719587721;
	bh=qYHDVLHacLKzMcQzi+EEjWrRCDBUZSq0E56hocrKWUs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Bg0fZZGLkv98ig6IuEUVN2a4w7eUZTir3l6hAI2mlrT0euupB1oAgbYAD9FVTM3QC
	 fi2F1yVAnJTn08KhFAmKdfWy6BHUpncR96lbIMcu0+ZvAjJR3sSDm68PCZWtQ1DJ5X
	 jicQDUkyfwf2nDZvR1CjxZz/eudMqjN91c2XlqGc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SFFL0H078004
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 10:15:21 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 10:15:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 10:15:20 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFJlW087911;
	Fri, 28 Jun 2024 10:15:20 -0500
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
Subject: [PATCH 3/7] arm64: dts: ti: k3-j721e: Add cpsw-mac-efuse node to mcu_conf
Date: Fri, 28 Jun 2024 10:15:14 -0500
Message-ID: <20240628151518.40100-4-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 9349ae07c046e..6b6ef6a306142 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -34,13 +34,17 @@ k3_reset: reset-controller {
 		};
 	};
 
-	mcu_conf: syscon@40f00000 {
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
@@ -546,7 +550,7 @@ cpsw_port1: port@1 {
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


