Return-Path: <linux-kernel+bounces-288592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37A8953C24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0208F1C24A61
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729FD156C65;
	Thu, 15 Aug 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YbJ1STGF"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CCE155730;
	Thu, 15 Aug 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754931; cv=none; b=fg2RMwRio85iM/WBlk1x+HkflS0PQ2HpUoOg+tnzukvKntzIYvkLkDnZxBoxEm+Zuw5Jl4umk2gl13hSdRyXkSLQR6Nquumz8nYXtj/kJfkEmZob243t3jRZP8Au/D7ixGhvgVHNKoFj83cn+yWh+/xGrbrcGbXLTG2zCNqdlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754931; c=relaxed/simple;
	bh=rZAiY+7ECZqrw/h0erS+9Q2CWbK+GcwYrv18F5uxbBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSGDFJ58DrDCcB6x5s4wIYkRDT7bp96lTPiiVcuj2V5O0A8Cs0Up65mMwPl4F5IaQOsB/MRgzy+Ig21AOp8rmMFXRy8xs5htW/thY4L4KfVM0N7rpTzmUCRdaVUuAigdlRRMVRL8LmlaNgH518taROkegnbg90hEto8FGV3x+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YbJ1STGF; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmdaY026531;
	Thu, 15 Aug 2024 15:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723754919;
	bh=2vojAbclMvgOmOoKeBpCzRP54ynwmu7jLOViHUKwuXY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YbJ1STGFZbV9FEOneZIYbandi5UdDdUZ/3q1260Xlkek7VRg+eUHHeB1mynrCuBox
	 38/v/5HfqkTs5oFR04HXv9qwU4wPuCz11tzKDyP245zELW+z43tyfT7iLIRTwnYjcI
	 92OrBaO1ClF00/hJuvFafTRpwhnOYa9A6OiwS/NM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FKmdIs130352
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 15:48:39 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 15:48:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 15:48:38 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmYNx052918;
	Thu, 15 Aug 2024 15:48:38 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>, Judith Mendez <jm@ti.com>
Subject: [PATCH v3 5/6] arm64: dts: ti: k3-am64: Add more ESM interrupt sources
Date: Thu, 15 Aug 2024 15:48:32 -0500
Message-ID: <20240815204833.452132-6-jm@ti.com>
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

Add ESM interrupt sources for rti as per TRM [0] in 9.4
Interrupt Sources.

[0] https://www.ti.com/lit/ug/spruim2h/spruim2h.pdf

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v2:
- No change
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 3 ++-
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index f8370dd033502..652653bb24f26 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -389,7 +389,8 @@ main_esm: esm@420000 {
 		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
-		ti,esm-pins = <160>, <161>;
+		/* Interrupt sources: rti0, rti1, rti8, rti9, rti10, rti11 */
+		ti,esm-pins = <160>, <161>, <162>, <163>, <164>, <165>;
 	};
 
 	main_uart0: serial@2800000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index ec17285869da6..ad4bed5d3f9eb 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -158,6 +158,7 @@ mcu_esm: esm@4100000 {
 		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x4100000 0x00 0x1000>;
-		ti,esm-pins = <0>, <1>;
+		/* Interrupt sources: esm0_cfg, esm0_hi, esm0_low, mrti0 */
+		ti,esm-pins = <0>, <1>, <2>, <85>;
 	};
 };
-- 
2.46.0


