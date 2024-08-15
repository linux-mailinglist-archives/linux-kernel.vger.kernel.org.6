Return-Path: <linux-kernel+bounces-288593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAF1953C26
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC24A283657
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB4C157468;
	Thu, 15 Aug 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D2SgFnZC"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00545155A30;
	Thu, 15 Aug 2024 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754932; cv=none; b=ht3rGso33yms0y0dXDYnxhOUTRNIdCg+KatRwY6T37fGZzyapz5JzVanEENOQ3thHtMUxcQhYs1ZxwS85Hkchvz5R30oZKa6wtDys08teogp9q5+52QFLoZr/G26cAZfg0605YMsfVUiGuGB5Nwcb5gekVZxEBeN1b3NR+DLSxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754932; c=relaxed/simple;
	bh=LMllPVaRI4RBUf7wi0bdp2mrDNcYG0A6X2TO2834eh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFYLRgGG2Js4qZVcAYYgo5i8nhnTMY495ZK3JdXkVf0CX+R1M0oKS/q7lHe/xUcnfozC8Wv51DH17oRUpUZXTwqBzr0eNyTgxOCgqSt9xi5vaavP5hYv9gpNajInr2care5RLmbBTG3hCVNESmYPIQ7BFU5igUW0YF4uYm6MS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D2SgFnZC; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmeh1066254;
	Thu, 15 Aug 2024 15:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723754920;
	bh=6hmbpLHNCyb6OCbui+3GKFpDYR4emuYkhkzEfLeQsbM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=D2SgFnZCgtWDut3aTye9bMdlTxU8vQNYPitwxXdM/o7otTie9JJhT8Q21rr6DMhra
	 Jmx+jZ/NVZTVsKY2QllWhzGGR9wHV/PEo3YSBwEhrFixxlf0OizqYqxCB7Ud0Wqsbb
	 v7NufJk7q8wwGP44utyPc9f9bg7YGtVPvA0iBlic=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FKmeEI130369
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 15:48:40 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 15:48:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 15:48:40 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmYO0052918;
	Thu, 15 Aug 2024 15:48:40 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>, Judith Mendez <jm@ti.com>
Subject: [PATCH v3 6/6] arm64: dts: ti: k3-am65: Add ESM nodes
Date: Thu, 15 Aug 2024 15:48:33 -0500
Message-ID: <20240815204833.452132-7-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815204833.452132-1-jm@ti.com>
References: <20240815204833.452132-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add Error Signaling Module (ESM) instances in MCU and MAIN
domains, set ESM interrupt sources for rti as per TRM [0] 9.4
Interrupt Sources.

There are no ESM0_ESM_INT* events routed to MCU ESM, so it is
not possible to reset the CPU using watchdog and ESM0
configuration. However add ESM instances for device completion.

Add comments to describe what interrupt sources are routed to
ESM modules.

[0] https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v2:
- Fix commit message for patch 6/6
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 1af3dedde1f67..07c9f043dac0b 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -54,6 +54,14 @@ gic_its: msi-controller@1820000 {
 		};
 	};
 
+	main_esm: esm@700000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x700000 0x00 0x1000>;
+		/* Interrupt sources: rti0, rti1, rti2, rti3 */
+		ti,esm-pins = <224>, <225>, <226>, <227>;
+		bootph-pre-ram;
+	};
+
 	serdes0: serdes@900000 {
 		compatible = "ti,phy-am654-serdes";
 		reg = <0x0 0x900000 0x0 0x2000>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 43c6118d2bf0f..e10cb9f483698 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -440,6 +440,14 @@ mcu_r5fss0_core1: r5f@41400000 {
 		};
 	};
 
+	mcu_esm: esm@40800000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x40800000 0x00 0x1000>;
+		/* Interrupt sources: mrti0, mrti1 */
+		ti,esm-pins = <104>, <105>;
+		bootph-pre-ram;
+	};
+
 	mcu_rti1: watchdog@40610000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x0 0x40610000 0x0 0x100>;
-- 
2.46.0


