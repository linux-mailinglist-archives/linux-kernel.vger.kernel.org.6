Return-Path: <linux-kernel+bounces-234119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED3691C26B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBEB1C226BD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18BB1CFD4C;
	Fri, 28 Jun 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iwcuaT8Z"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F861CE0AE;
	Fri, 28 Jun 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587742; cv=none; b=Tes4c1Aztser3qaUrvOORpDEL1j6xqU0z4fpciGc9qgm+rQld1rLeq5hUaEoBnWYaqBONfWqXdArS88qJ/FP6SVGlspsc8tmvRZCmsWiDUzDuR9xfEkok87llR5koCud+youePnJU2lqebn4pJxvdGPplJplHKAHTgc0sgRNmgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587742; c=relaxed/simple;
	bh=ezL8bk3Jk35BI/dergt8ULF2Jomyu78P8+/sCPXhFN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjGy48u0Yw9HKTPPJyI7GvSJwKv13cWwrfbWdlzwCAQBN3syRYiLCMRJwFqkvUbj1i9Mp0HO+1oZFX6jVaf6+9zDB12GdJXDwzSS3UQBDLC9rzyFjNoNzV/phfCsPORL6LKDcmzvUBQlcNcH6BnNvEc2p+5YNAMKC0dckYcmmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iwcuaT8Z; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFLPH106484;
	Fri, 28 Jun 2024 10:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719587721;
	bh=6YDAaAwdIo9OQpjoC1BeBH/MaKnZR7JSkGfvxuqwJ6Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iwcuaT8Zvt0Hn1JGPM9rzQSQ8nEbj6lMQfyVfyOO5lvY4Ga5AgGoRv+Sb3flSHmda
	 T3QE6P3/kW495NfbKHW6us0lO9Vn4XqdDFHMZgfB1Xl9b2Xue8LQCeQ9LqV0sUkMXB
	 JpJQHNOC46vb8us14psMbR4YyueKICWBoAmm0b+0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SFFLhY071756
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 10:15:21 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 10:15:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 10:15:21 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFJlX087911;
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
Subject: [PATCH 4/7] arm64: dts: ti: k3-j721s2: Add cpsw-mac-efuse node to mcu_conf
Date: Fri, 28 Jun 2024 10:15:15 -0500
Message-ID: <20240628151518.40100-5-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 5ccb04c7c4624..8feb42c89e476 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -139,13 +139,17 @@ wkup_gpio_intr: interrupt-controller@42200000 {
 		ti,interrupt-ranges = <16 960 16>;
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
@@ -544,7 +548,7 @@ cpsw_port1: port@1 {
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


