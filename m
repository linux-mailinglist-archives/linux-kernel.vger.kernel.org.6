Return-Path: <linux-kernel+bounces-234113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C772191C25E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7201C22592
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659C1CB30C;
	Fri, 28 Jun 2024 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="THpsF7VR"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B21C9ED9;
	Fri, 28 Jun 2024 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587735; cv=none; b=AssY1crwbftnlKHQjR6chC1LSJbCtAbvcOi/5fdePzrOwhaKVoEEBoMoQcL0ekP2zxqOe6RolPJ6aGhZnIBQ84kRMkQhIEzDZeaSY8BtlyAUs1vyWAPfAW5ygn05OtFOtZiN+WiSFTj3lnIwny9uqqRcYceplsAr4/n0cVP4BxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587735; c=relaxed/simple;
	bh=BFii7ium7QLiIWvuNFN6kUEBY/3kxsr+RC1NPLTp61M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJA4oGRddG92eIVzCW8cWpr+5BMgHEnkiw5DZugohvYBXehS77nkgk09co9T0c4R76Dc7oqPC+w2FEfuuhTfzhVlVoL8qfgKiQRf8jxHJhLIzMCvYCGDjMOPfcWduMDenOGUb7hxTOZNTr+nmBc2iXhdoOgxgt+kCgjqIsGJTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=THpsF7VR; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFMWW056628;
	Fri, 28 Jun 2024 10:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719587722;
	bh=XI9L+G23fu6tx1Vexf6HkbHEHbyN9DgvJ1egJRaX2vo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=THpsF7VRV6/BJ0OnigERAaYYaVgZncA15uZNTig7cBGDn6id80z56OXWI+/ba5FGH
	 fW038D2eM8JPqsVhMhnyFkFUsCVon6BpUNIhRizsgmSSOa5PTzaq9lua/ZraWQAHls
	 EcHbCK2C/FbLtw3bEP6stoJi/OVmx8ferPCDTR1I=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SFFM4F056903
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 10:15:22 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 10:15:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 10:15:22 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFJla087911;
	Fri, 28 Jun 2024 10:15:22 -0500
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
Subject: [PATCH 7/7] arm64: dts: ti: k3-am62: Add cpsw-mac-efuse node to wkup_conf
Date: Fri, 28 Jun 2024 10:15:18 -0500
Message-ID: <20240628151518.40100-8-afd@ti.com>
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

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 2 +-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 0f2722c4bcc32..9662b20d59dae 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -739,7 +739,7 @@ cpsw_port1: port@1 {
 				label = "port1";
 				phys = <&phy_gmii_sel 1>;
 				mac-address = [00 00 00 00 00 00];
-				ti,syscon-efuse = <&wkup_conf 0x200>;
+				ti,syscon-efuse = <&cpsw_mac_syscon 0x0>;
 			};
 
 			cpsw_port2: port@2 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 66ddf2dc51afa..e0afafd532a5c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -22,6 +22,11 @@ chipid: chipid@14 {
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


