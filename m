Return-Path: <linux-kernel+bounces-271706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DDA945244
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F081C22E4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF521BC072;
	Thu,  1 Aug 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dlbC/Dx9"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3E1B9B4A;
	Thu,  1 Aug 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534616; cv=none; b=iFP1jQtj4bh6Layk13fGP1RsZX04NpGO20ZAAEgvI8PQZJUKD3MM3sp6yirMIG/wJJw2mi/RSuR5I/jvr987ce3JipioPXvF8E8MwnaeMsvS+DCIrXn2xfhf0vYEm5NN6FqgFm2ub1NkJDNKFcR+v0xPgpdANrvcJ/7qe+MQEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534616; c=relaxed/simple;
	bh=898Hx97TBdkuow5gz3wwNDeeLG36j60GDGPBwWppy6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PrJPU18rfO8g8S1V7vs5Kx/pZ32a3IPxNQWDeubrZXHp7pGajdqzKGNZAsiov2er1RuqSDwYVfn66m/ARUUWZW2pqlQ3SlMvKMOtNSU6h04FiyIj/vSnmmtp1Ihvu2f8Agh3aE/NKqk4Q3o96B/BwG+hfUvCoOXwA1xuTBPttqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dlbC/Dx9; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 471Hnh8h123996;
	Thu, 1 Aug 2024 12:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722534583;
	bh=PdjQrlpC72LYhz6S+39HbLi1OofMVcEKS+sc+CNdPS0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dlbC/Dx9R/8KYM6WsdAl/W89p8d0mHzuSkm/6WhfZBI06/a9CjtTKTg10u52XVtTL
	 mM519cyZxu0UZkpwijBnHbIdt3sCDR2s9AvkFhQI92YHfOJ4q2+bDh8Ygrp855pL11
	 iMUWGow+QnUkYbm5C0BUJ76ue4WXlkrgdJLT+wj0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 471HnhnF036723
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Aug 2024 12:49:43 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Aug 2024 12:49:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Aug 2024 12:49:43 -0500
Received: from localhost.localdomain ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 471Hngkh067627;
	Thu, 1 Aug 2024 12:49:42 -0500
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
Subject: [PATCH 1/4] arm64: dts: ti: k3-am65: Include entire FSS region in ranges
Date: Thu, 1 Aug 2024 12:49:38 -0500
Message-ID: <20240801174941.41002-2-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi |  8 ++++----
 arch/arm64/boot/dts/ti/k3-am65.dtsi     | 13 ++++++-------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 43c6118d2bf0f..5948ab3b50fc2 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -292,13 +292,13 @@ fss: bus@47000000 {
 		ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x100>, /* FSS Control */
 			 <0x0 0x47040000 0x0 0x47040000 0x0 0x100>, /* OSPI0 Control */
 			 <0x0 0x47050000 0x0 0x47050000 0x0 0x100>, /* OSPI1 Control */
-			 <0x5 0x00000000 0x5 0x00000000 0x1 0x0000000>, /* OSPI0 Memory */
-			 <0x7 0x00000000 0x7 0x00000000 0x1 0x0000000>; /* OSPI1 Memory */
+			 <0x0 0x50000000 0x0 0x50000000 0x0 0x10000000>, /* OSPI0/1 Memory 1 */
+			 <0x4 0x00000000 0x4 0x00000000 0x4 0x00000000>; /* OSPI0/1 Memory 0/3 */
 
 		ospi0: spi@47040000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x0 0x47040000 0x0 0x100>,
-				<0x5 0x00000000 0x1 0x0000000>;
+			      <0x5 0x00000000 0x1 0x00000000>;
 			interrupts = <GIC_SPI 552 IRQ_TYPE_LEVEL_HIGH>;
 			cdns,fifo-depth = <256>;
 			cdns,fifo-width = <4>;
@@ -316,7 +316,7 @@ ospi0: spi@47040000 {
 		ospi1: spi@47050000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x0 0x47050000 0x0 0x100>,
-				<0x7 0x00000000 0x1 0x00000000>;
+			      <0x7 0x00000000 0x1 0x00000000>;
 			interrupts = <GIC_SPI 553 IRQ_TYPE_LEVEL_HIGH>;
 			cdns,fifo-depth = <256>;
 			cdns,fifo-width = <4>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index c59baebc5a25b..5b8cbdd6942e7 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -69,11 +69,11 @@ cbass_main: bus@100000 {
 			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
 			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
 			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
-			 <0x00 0x50000000 0x00 0x50000000 0x00 0x8000000>,
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
 			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A53 PERIPHBASE */
-			 <0x00 0x70000000 0x00 0x70000000 0x00 0x200000>,
-			 <0x05 0x00000000 0x05 0x00000000 0x01 0x0000000>,
-			 <0x07 0x00000000 0x07 0x00000000 0x01 0x0000000>;
+			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00200000>,
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
+			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
 
 		cbass_mcu: bus@28380000 {
 			compatible = "simple-bus";
@@ -89,9 +89,8 @@ cbass_mcu: bus@28380000 {
 				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
 				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
 				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI space 1 */
-				 <0x00 0x50000000 0x00 0x50000000 0x00 0x8000000>, /*  FSS OSPI0 data region 1 */
-				 <0x05 0x00000000 0x05 0x00000000 0x01 0x0000000>, /* FSS OSPI0 data region 3*/
-				 <0x07 0x00000000 0x07 0x00000000 0x01 0x0000000>; /* FSS OSPI1 data region 3*/
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS Data Region 1 */
+				 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS Data Region 0/3 */
 
 			cbass_wakeup: bus@42040000 {
 				compatible = "simple-bus";
-- 
2.39.2


