Return-Path: <linux-kernel+bounces-230493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3109917D99
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D53284F26
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFCE17BB3D;
	Wed, 26 Jun 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UPwe2yKb"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5961E176FB6;
	Wed, 26 Jun 2024 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397017; cv=none; b=CZzfMJjn5fdMTAd8DuXeO68dRVeusQORLQa1+IDsqyY6dmX3JCS1urQJFLNy6XFP5NyQxYoBEu+ZQISGaHHwCB7vKdUsBZgMaS4z0y1KHapzYGd6PtBhkc0Zyax6mFxxEW1PcKZCW9LyK5YRZL2mshtm12JuvETNIGLNuif7Dr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397017; c=relaxed/simple;
	bh=3tl6dCie2RQtO9mwXaZUSPgI0x3UrMhfhHWc5AKUqh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHt+/xB81NpX7WHEHtAYN77Uhn8nsa9PFK7sfhLuSqQH3GEgAgpbOm007koIbgrrDPG2QAUixtFNr/L4wYKhPR7NRGi/m05iNpO4FVb/gmQvBU//1wGV18yTvQxBfjQfNioidsbfafra8wZ/ABv5PTosA6LXSmjYPdiNvnrnSXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UPwe2yKb; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45QAGoFL102235;
	Wed, 26 Jun 2024 05:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719397010;
	bh=KZd+sD316qBW9LDmJvCFu8jfe26UJNT3QS4oMUPPQg8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UPwe2yKbnnHRe5Y+ZN0MS0G4BP12bTRYox1LHEz/+3dKJqZsbEwRE05CQr9F6LDld
	 Gi6AZciBh+qCNBYaPUO6mH4OpoDFxl3uAs5v8Zi23T9zJsZLcI293UDzaqAfmrGk2j
	 plcK6TfXW866gZ3t6//LERpQpryNxZ93RkAYr990=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45QAGoaZ012590
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 05:16:50 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jun 2024 05:16:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jun 2024 05:16:48 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.248])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45QAGl6U094570;
	Wed, 26 Jun 2024 05:16:48 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <j-luthra@ti.com>, <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-j784s4-main: Add McASP nodes
Date: Wed, 26 Jun 2024 15:46:43 +0530
Message-ID: <20240626101645.36764-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626101645.36764-1-j-choudhary@ti.com>
References: <20240626101645.36764-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add McASP 0-4 instances and keep them disabled because several
required properties are missing as they are board specific.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index a3e91ff87b4a..7e10be314684 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -2683,4 +2683,94 @@ dss_ports: ports {
 			 */
 		};
 	};
+
+	mcasp0: mcasp@2b00000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b00000 0x00 0x2000>,
+		      <0x00 0x02b08000 0x00 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+		dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
+		dma-names = "tx", "rx";
+		clocks = <&k3_clks 265 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 265 0>;
+		assigned-clock-parents = <&k3_clks 265 1>;
+		power-domains = <&k3_pds 265 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp1: mcasp@2b10000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b10000 0x00 0x2000>,
+		      <0x00 0x02b18000 0x00 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 546 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 547 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+		dmas = <&main_udmap 0xc401>, <&main_udmap 0x4401>;
+		dma-names = "tx", "rx";
+		clocks = <&k3_clks 266 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 266 0>;
+		assigned-clock-parents = <&k3_clks 266 1>;
+		power-domains = <&k3_pds 266 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp2: mcasp@2b20000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b20000 0x00 0x2000>,
+		      <0x00 0x02b28000 0x00 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 548 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 549 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+		dmas = <&main_udmap 0xc402>, <&main_udmap 0x4402>;
+		dma-names = "tx", "rx";
+		clocks = <&k3_clks 267 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 267 0>;
+		assigned-clock-parents = <&k3_clks 267 1>;
+		power-domains = <&k3_pds 267 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp3: mcasp@2b30000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b30000 0x00 0x2000>,
+		      <0x00 0x02b38000 0x00 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 550 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+		dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
+		dma-names = "tx", "rx";
+		clocks = <&k3_clks 268 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 268 0>;
+		assigned-clock-parents = <&k3_clks 268 1>;
+		power-domains = <&k3_pds 268 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp4: mcasp@2b40000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b40000 0x00 0x2000>,
+		      <0x00 0x02b48000 0x00 0x1000>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 552 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 553 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+		dmas = <&main_udmap 0xc501>, <&main_udmap 0x4501>;
+		dma-names = "tx", "rx";
+		clocks = <&k3_clks 269 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 269 0>;
+		assigned-clock-parents = <&k3_clks 269 1>;
+		power-domains = <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
 };
-- 
2.25.1


