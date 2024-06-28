Return-Path: <linux-kernel+bounces-234118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CF091C268
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245051C20EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FEA1CF3E5;
	Fri, 28 Jun 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ksKVWg4M"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826971CE088;
	Fri, 28 Jun 2024 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587741; cv=none; b=ruQxvv7ND4nWsGcqfxPVsYDDXfsrh5OFstI8h/d3pHOw2aY3yK9b2LAPAipcyzSrgyvP9SPbiKPVX2DcfUYoiiZuXEdu2GBh4tVPGi7fMxZdTSkrgrswFRS6DiD7OKVeQ4kUgtoHYeqEI18Vr75xG1KXQ1o0MuP9u99tXir+LmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587741; c=relaxed/simple;
	bh=zdF1VkxwewH7Umdmjs1flfLW0dszHOPJSeUBHPuNHZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gA72CDJAJvv7WzO/yWnJswEheo9sC8190SO0oq5/I4R5626WUc59AdHwNvzG9famuDtOObkPpenaCmd9SuNobOPgOHVO+D3U9noq4ws4t/+P65+LrITGCRAYqht6UjqxXL+U3UNtbCKhGycRCsBappQ2Z8jjU4ypNKs20QwafkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ksKVWg4M; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFMTs001309;
	Fri, 28 Jun 2024 10:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719587722;
	bh=/gLayUbAVhvA3GyhpUv+5Btid7S5m4fwue6TZZlJdhI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ksKVWg4M7EvhPNCdCtdMBCtP6RzW9RbqtD+hXBAnwuoUYNlUsQDdaD0+oauIlmuWc
	 Nb8HKT/PR9GcYhtkGmuR04p1Z+LcMMuGk2y1ATtF9r0RD5XjbF8SWLNqLQik1H2Wg+
	 wEKOCT1SboDeNObWsJjw8coNoBqxLrkUWMZaD/m8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SFFMFm056897
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 10:15:22 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 10:15:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 10:15:22 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFJlZ087911;
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
Subject: [PATCH 6/7] arm64: dts: ti: k3-am62a: Add cpsw-mac-efuse node to wkup_conf
Date: Fri, 28 Jun 2024 10:15:17 -0500
Message-ID: <20240628151518.40100-7-afd@ti.com>
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

The WKUP system controller address region contains an eFuse block with
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
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   |  2 +-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index ce4a2f1056300..6b81abec8a145 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -713,7 +713,7 @@ cpsw_port1: port@1 {
 				label = "port1";
 				phys = <&phy_gmii_sel 1>;
 				mac-address = [00 00 00 00 00 00];
-				ti,syscon-efuse = <&wkup_conf 0x200>;
+				ti,syscon-efuse = <&cpsw_mac_syscon 0x0>;
 			};
 
 			cpsw_port2: port@2 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index 5c5aca4bb9258..f5ac101a04dfa 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -6,9 +6,8 @@
  */
 
 &cbass_wakeup {
-	wkup_conf: syscon@43000000 {
-		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
-		reg = <0x00 0x43000000 0x00 0x20000>;
+	wkup_conf: bus@43000000 {
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x43000000 0x20000>;
@@ -18,6 +17,11 @@ chipid: chipid@14 {
 			reg = <0x14 0x4>;
 		};
 
+		cpsw_mac_syscon: ethernet-mac-syscon@200 {
+			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
+			reg = <0x200 0x8>;
+		};
+
 		usb0_phy_ctrl: syscon@4008 {
 			compatible = "ti,am62-usb-phy-ctrl", "syscon";
 			reg = <0x4008 0x4>;
-- 
2.39.2


