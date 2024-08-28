Return-Path: <linux-kernel+bounces-305435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03717962E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 663D4B23AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38B01AAE23;
	Wed, 28 Aug 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BUohwwUA"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F1D1A7AE3;
	Wed, 28 Aug 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866209; cv=none; b=Wc/F6+DhCrDF5JND816o33/p8jwqqdNGwD/jd0LMJJ7bFVBAtypZw3dRaUMx9aakIu+JacRm8z5dVoOHjEN9NTgTOO6rLEJNpY3Ekir7YfQ7r2N/zVatQwqXB2SwXqQJm6eiix4z/Hozdo7/K1hq/s99954PmTlN7nkzMvkwCi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866209; c=relaxed/simple;
	bh=Zw3soVdvjI3oauNwVlSroXGfxJb4p1clujxhp9ntskU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHEXPKoNkJtTnxvhLXMEbj7TZfMM60miPjZERMAXplCguKIMqlwFwPzlcXlMw6HR9xWb97OKk0PbxplcklHjSgIDjFtCY6RW77D5TqxDwG8PG9feADoIACHqd5wTNVgJG2VaZMQZ+/PPVEwafF3xoKDfCPowYgdmmjVFKr6ehd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BUohwwUA; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SHTxRC006253;
	Wed, 28 Aug 2024 12:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724866199;
	bh=mRgUEXSclmzCQoAQfvKVLv3LZBXCHgagmU+IdAe4KTc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BUohwwUAof5YrvnLSRPjJHzfdiZiQR9V8R49p7M3pJ73RLDnc7BwRnJmKAH3AprLd
	 QwbvGMVzPDPdK9jMuVvfnPre4RoUaXnZl2QjH/NzDZycv1DigSNl+V3gUyezQLnrmC
	 +5cZ02qkDvpWN88W9Auilv8TGxQTUC3I/V04QNUk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SHTx0C024283
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 12:29:59 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 12:29:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 12:29:58 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SHTugD073490;
	Wed, 28 Aug 2024 12:29:58 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Santhosh Kumar K <s-k6@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-j784s4: Include entire FSS region in ranges
Date: Wed, 28 Aug 2024 12:29:56 -0500
Message-ID: <20240828172956.26630-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828172956.26630-1-afd@ti.com>
References: <20240828172956.26630-1-afd@ti.com>
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
Reviewed-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi            |  8 +++-----
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index f3a6ed1c979d0..f603380fc91cf 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -678,16 +678,16 @@ fss: bus@47000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x100>, /* FSS Control */
-			 <0x0 0x47040000 0x0 0x47040000 0x0 0x100>, /* OSPI0 Control */
-			 <0x0 0x47050000 0x0 0x47050000 0x0 0x100>, /* OSPI1 Control */
-			 <0x5 0x00000000 0x5 0x00000000 0x1 0x0000000>, /* OSPI0 Memory */
-			 <0x7 0x00000000 0x7 0x00000000 0x1 0x0000000>; /* OSPI1 Memory */
+		ranges = <0x00 0x47000000 0x00 0x47000000 0x00 0x00000100>, /* FSS Control */
+			 <0x00 0x47040000 0x00 0x47040000 0x00 0x00000100>, /* OSPI0 Control */
+			 <0x00 0x47050000 0x00 0x47050000 0x00 0x00000100>, /* OSPI1 Control */
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS data region 1 */
+			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS data region 0/3 */
 
 		ospi0: spi@47040000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x00 0x47040000 0x00 0x100>,
-			      <0x05 0x0000000 0x01 0x0000000>;
+			      <0x05 0x00000000 0x01 0x00000000>;
 			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
 			cdns,fifo-depth = <256>;
 			cdns,fifo-width = <4>;
@@ -705,7 +705,7 @@ ospi0: spi@47040000 {
 		ospi1: spi@47050000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x00 0x47050000 0x00 0x100>,
-			      <0x07 0x0000000 0x01 0x0000000>;
+			      <0x07 0x00000000 0x01 0x00000000>;
 			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
 			cdns,fifo-depth = <256>;
 			cdns,fifo-width = <4>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index 73cc3c1fec08d..5e84c6b4f5ad4 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -271,8 +271,7 @@ cbass_main: bus@100000 {
 			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
 			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
 			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
-			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
-			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
+			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>;
 
 		cbass_mcu_wakeup: bus@28380000 {
 			bootph-all;
@@ -289,9 +288,8 @@ cbass_mcu_wakeup: bus@28380000 {
 				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
 				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
 				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
-				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS OSPI0/1 data region 0 */
-				 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS OSPI0 data region 3 */
-				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS data region 1 */
+				 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS data region 0/3 */
 		};
 	};
 
-- 
2.39.2


