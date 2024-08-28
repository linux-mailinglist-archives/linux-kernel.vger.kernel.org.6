Return-Path: <linux-kernel+bounces-305433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC4962E8B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D42B239A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3961AAE06;
	Wed, 28 Aug 2024 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bfz+gCk2"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F71A76CD;
	Wed, 28 Aug 2024 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866208; cv=none; b=JZcjUnWLwyDiaPrP3h7XQFFyiE8F+mYrcCt+pY0Lx/U4jl+G6ojKKhhmHUC6GpyOpSqn6qYD7RW9y1lhQsRWBtW0XZkdvp7oIUmSfU8HmiANBdLi9TLiMeV+gTyT1VbFjs/4ROSH+CZUt1eZK/kD73jHUwqWdK4wUrGtvezj4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866208; c=relaxed/simple;
	bh=1aHk8uoYILWSlTkVXcRtLDylvsnt5dFcEEP6GE35KLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfJ8SzyeSN26jQf9+pZoVUbrqC2pzBGwiFKKmg0fLyv4vNuGPgBxdQVONqOmgAdCUMgrmaXHPgrVm+GxEjlrDCYya6PfVV9a6pv5Jxb9p4PS0bBCKlnOFC2orpGR0acPYfMK6Wz5ZwFUGI/aHtVYEa/pf+ezh+ITINioh+HbPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bfz+gCk2; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SHTw0I006247;
	Wed, 28 Aug 2024 12:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724866198;
	bh=jLd/z6J2FG7h4NjMTyJ5YqtPEzz11AW4zQl5njp5rEU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bfz+gCk2qZwUA91f9U61G783Tg0jENjtvRYa5buIhvCe6RWQp3A0gOXOikuXkGNlz
	 lEo0X0/LYIY7d4KKSzszYSSflrFpSRRopFWG7+DURXA17uo4d7T9peSOYA3VMsJuws
	 Xkc8LtdJrCsAf6pr4oUDz43bzcmDyxycV/oSuMkA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SHTw1K094317
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 12:29:58 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 12:29:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 12:29:57 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SHTugA073490;
	Wed, 28 Aug 2024 12:29:57 -0500
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
Subject: [PATCH v2 1/4] arm64: dts: ti: k3-am65: Include entire FSS region in ranges
Date: Wed, 28 Aug 2024 12:29:53 -0500
Message-ID: <20240828172956.26630-2-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi |  8 ++++----
 arch/arm64/boot/dts/ti/k3-am65.dtsi     | 12 +++++-------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 43c6118d2bf0f..1a251d13f80ab 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -292,13 +292,13 @@ fss: bus@47000000 {
 		ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x100>, /* FSS Control */
 			 <0x0 0x47040000 0x0 0x47040000 0x0 0x100>, /* OSPI0 Control */
 			 <0x0 0x47050000 0x0 0x47050000 0x0 0x100>, /* OSPI1 Control */
-			 <0x5 0x00000000 0x5 0x00000000 0x1 0x0000000>, /* OSPI0 Memory */
-			 <0x7 0x00000000 0x7 0x00000000 0x1 0x0000000>; /* OSPI1 Memory */
+			 <0x0 0x50000000 0x0 0x50000000 0x0 0x10000000>, /* FSS data region 1 */
+			 <0x4 0x00000000 0x4 0x00000000 0x4 0x00000000>; /* FSS data region 0/3 */
 
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
index c59baebc5a25b..c74a0a25832cb 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -69,11 +69,10 @@ cbass_main: bus@100000 {
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
+			 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>;
 
 		cbass_mcu: bus@28380000 {
 			compatible = "simple-bus";
@@ -89,9 +88,8 @@ cbass_mcu: bus@28380000 {
 				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
 				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
 				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI space 1 */
-				 <0x00 0x50000000 0x00 0x50000000 0x00 0x8000000>, /*  FSS OSPI0 data region 1 */
-				 <0x05 0x00000000 0x05 0x00000000 0x01 0x0000000>, /* FSS OSPI0 data region 3*/
-				 <0x07 0x00000000 0x07 0x00000000 0x01 0x0000000>; /* FSS OSPI1 data region 3*/
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS data region 1 */
+				 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS data region 0/3 */
 
 			cbass_wakeup: bus@42040000 {
 				compatible = "simple-bus";
-- 
2.39.2


