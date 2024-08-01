Return-Path: <linux-kernel+bounces-271707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DD0945246
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EC81F2A942
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1FE1BC081;
	Thu,  1 Aug 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NNJzR2vq"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65671BA875;
	Thu,  1 Aug 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534616; cv=none; b=tUi4p4OxJVjTXZ2kF7ZqrWdLKOSN2wQlloQ33LicPnAdZC8zSHQraY8hXnuw4PnWSylcRwcDiuiMY0JcQnNwdNbDSOjlhxf/T9cious0bXE2IoBqFhCWdCeerv/rkyePwg47Rw+5lVMTH+4W4pzEnTBUWy2r+cmispIy7V2tZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534616; c=relaxed/simple;
	bh=+uOXqvjYNlV/hmK5pwNYeCxnwEt6FFN3iKubU4aRtCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YU1mHlwU0GU4Ve1w5X3wsrkpK22UE6w4pnsY5S5uHxnmCbOk8mCQPfmRx0R6G2xxRIXJe6B8WqORErELxhPIeyUpXOfeVGIzNWAUWpkL3FrQmLcadR/tRJx355/mc+dlaHpYB43OtJfmKwl2YticRLCq8vN9R0hyM30xNeuy+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NNJzR2vq; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 471HniFD085639;
	Thu, 1 Aug 2024 12:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722534584;
	bh=z4uXRPQ/d+RS/wjzJ0DulEwP2HPOoSMOr60Z0cnP5dU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NNJzR2vqSbXvSDkygNpb9rCeQRf6sqkvX/H5TSsEHx0x1tbPLXzdPpx0nuYOZzvNf
	 vl6nRXAJHRgHwsfEdHmPvppqAKifjMtTiFFOWBuCw3ucuT7FYHbKMgU9NrGTKdAMw4
	 tS5CVrXRKpggka8FFCi1Hd4WD5BwCLOz34qe2DoU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 471Hni9X036730
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Aug 2024 12:49:44 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Aug 2024 12:49:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Aug 2024 12:49:43 -0500
Received: from localhost.localdomain ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 471Hngki067627;
	Thu, 1 Aug 2024 12:49:43 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jonathan Humphreys <j-humphreys@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-j721e: Include entire FSS region in ranges
Date: Thu, 1 Aug 2024 12:49:39 -0500
Message-ID: <20240801174941.41002-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240801174941.41002-1-afd@ti.com>
References: <20240801174941.41002-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add FSS regions at 0x50000000, 0x400000000, and 0x600000000. Although
not used currently by the Linux FSS driver, these regions belong to
the FSS and should be included in the ranges mapping.

While here, a couple of these numbers had missing zeros which was
hidden by odd alignments, fix both these issues.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 14 +++++++++-----
 arch/arm64/boot/dts/ti/k3-j721e.dtsi            |  8 +++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 6b6ef6a306142..63497dfcded64 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -354,8 +354,12 @@ fss: bus@47000000 {
 			 <0x0 0x47034000 0x0 0x47034000 0x0 0x100>, /* HBMC Control */
 			 <0x0 0x47040000 0x0 0x47040000 0x0 0x100>, /* OSPI0 Control */
 			 <0x0 0x47050000 0x0 0x47050000 0x0 0x100>, /* OSPI1 Control */
-			 <0x5 0x00000000 0x5 0x00000000 0x1 0x0000000>, /* HBMC/OSPI0 Memory */
-			 <0x7 0x00000000 0x7 0x00000000 0x1 0x0000000>; /* OSPI1 Memory */
+			 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>, /* HBMC/OSPI0 Memory 1 */
+			 <0x0 0x58000000 0x0 0x58000000 0x0 0x08000000>, /* OSPI1 Memory 1 */
+			 <0x4 0x00000000 0x4 0x00000000 0x1 0x00000000>, /* HBMC/OSPI0 Memory 0 */
+			 <0x5 0x00000000 0x5 0x00000000 0x1 0x00000000>, /* HBMC/OSPI0 Memory 3 */
+			 <0x6 0x00000000 0x6 0x00000000 0x1 0x00000000>, /* OSPI1 Memory 0 */
+			 <0x7 0x00000000 0x7 0x00000000 0x1 0x00000000>; /* OSPI1 Memory 3 */
 
 		hbmc_mux: mux-controller@47000004 {
 			compatible = "reg-mux";
@@ -367,7 +371,7 @@ hbmc_mux: mux-controller@47000004 {
 		hbmc: hyperbus@47034000 {
 			compatible = "ti,am654-hbmc";
 			reg = <0x00 0x47034000 0x00 0x100>,
-				<0x05 0x00000000 0x01 0x0000000>;
+			      <0x05 0x00000000 0x01 0x00000000>;
 			power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
 			clocks = <&k3_clks 102 0>;
 			assigned-clocks = <&k3_clks 102 5>;
@@ -381,7 +385,7 @@ hbmc: hyperbus@47034000 {
 		ospi0: spi@47040000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x0 0x47040000 0x0 0x100>,
-				<0x5 0x00000000 0x1 0x0000000>;
+			      <0x5 0x00000000 0x1 0x00000000>;
 			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
 			cdns,fifo-depth = <256>;
 			cdns,fifo-width = <4>;
@@ -399,7 +403,7 @@ ospi0: spi@47040000 {
 		ospi1: spi@47050000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x0 0x47050000 0x0 0x100>,
-				<0x7 0x00000000 0x1 0x00000000>;
+			      <0x7 0x00000000 0x1 0x00000000>;
 			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
 			cdns,fifo-depth = <256>;
 			cdns,fifo-width = <4>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index 5a72c518ceb6b..6a18734171d72 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -145,8 +145,7 @@ cbass_main: bus@100000 {
 			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
 			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
 			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
-			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
-			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
+			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>;
 
 		cbass_mcu_wakeup: bus@28380000 {
 			compatible = "simple-bus";
@@ -162,9 +161,8 @@ cbass_mcu_wakeup: bus@28380000 {
 				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
 				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
 				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
-				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS OSPI0/1 data region 0 */
-				 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS OSPI0 data region 3 */
-				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS Data Region 1 */
+				 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS Data Region 0/3 */
 		};
 	};
 
-- 
2.39.2


