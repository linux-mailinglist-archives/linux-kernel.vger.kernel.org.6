Return-Path: <linux-kernel+bounces-285606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE45D95103D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8545B1F215CD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C851F1AE03D;
	Tue, 13 Aug 2024 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LbQ5cBUi"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE251AC43D;
	Tue, 13 Aug 2024 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590212; cv=none; b=kaBSYIt7EBSXvnTb7Vj1j/gAWtThrtYh4x007TgH1fcJbjbUAiyLraoFbsjeUR6UQ0nFRiePt0gGtHH24mrDm0Z5EEseYMqZp4zraggMYa5R1bBmsW1DZdM+0qWw3vhPLc5lIUfA4V7mFS8GwMmmm0S4j3qnqHwa0WxywchxCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590212; c=relaxed/simple;
	bh=O7XmV9pWmdbwEZO0DyN97+hQzsVFVpW3OFPa6xushYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPiu+UY8E6yPq0Wl0C0Ex89htSaN5Vxyq+6nRcrmCYvc7yyVXR8NOP8rzLpwpdmlwHOj89biRgYLYsHkH+9BS96OOYKBeIvBojwNFou03YJyFPuCRiCa2hGtYO1J0DVEYmBF8oPG8JQx68P6AlqGFto4BS9aVkp6NwinS94y5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LbQ5cBUi; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3OEp115467;
	Tue, 13 Aug 2024 18:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723590204;
	bh=I0b+FVv1XyHiEheKELStZchV1W/gHjMUvxullqrHOXU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LbQ5cBUiZd8GR2PjZFpsXKqVWG83eJ8IHXP50r1GvlToCXSakLmyzadYcX4U5Es8h
	 5zSMwQxtrFmYWkdxWiSJMS+CXE3MNBDzJ9eQ6Fc1BSUZ0Jkx+kW+Arud/seI9VH9aP
	 u8K3ShvOqKHSrV9eRsCm+ubxlFqApBrbm+ZgR6RE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DN3Oum050286
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 18:03:24 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 18:03:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 18:03:24 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3Khr026425;
	Tue, 13 Aug 2024 18:03:24 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        Judith
 Mendez <jm@ti.com>
Subject: [PATCH v2 6/6] arm64: dts: ti: k3-am65: Add ESM nodes
Date: Tue, 13 Aug 2024 18:03:12 -0500
Message-ID: <20240813230312.3289428-7-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813230312.3289428-1-jm@ti.com>
References: <20240813230312.3289428-1-jm@ti.com>
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

Add comments to describe what interrupt sources are routed to
ESM modules.

[0] https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Add patch 6/6 for am65x
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


