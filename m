Return-Path: <linux-kernel+bounces-305437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B3962E92
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00D71F21DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802A1AB51F;
	Wed, 28 Aug 2024 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZCFVqCh2"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F61AB504;
	Wed, 28 Aug 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866214; cv=none; b=uVaXey2QrNca7mtEfzyt8WFm7WtQ2e0QYL66PietXyeqljopa2rGByrwPYz4XXNaVjCtGKAylAnrXM4ZGC/5iHB/EWq8McZJzvn1wMQoZVjeddBj4wHUhs3njj83eXWrH8um3ueXpwHFbO8MRKRi3FENVK2GxLt7j1viU2eqEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866214; c=relaxed/simple;
	bh=5HdX/PWhEgmmrIeXaH1FjA31AEgRFlZjfsyzkSbkXyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qan9QUs+3mE+5c5xoH4MAnmIWWPb+5zvmmuVQpFHD/C0crJFtvueDjFF2A7p1AJFipJ/UgZa7npURDrqm5zGKtT+a4N/bpCpfgiZxR3MPmYE98K53Vdq8QBqYQSgcIZklG5ZsMuO7un4GMFqzO2tggX+B/ck/Dcp+RGnVTs9zl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZCFVqCh2; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SHTwjM072779;
	Wed, 28 Aug 2024 12:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724866198;
	bh=GZp972pZvt5VAyXcD93nKCiVZ1ATgFPNjK3K4/SasJw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZCFVqCh2xqJKgjSVsN3ChatXx0xM95tProZSJY0Wi1aScLB9LX7QiuQnIDRUIHuQ4
	 3CjFQL7DYGmfC33E+A/0bf7L+ek1E2bEvlwfAS+VcXkrG41k81TycIsBM4jyUF8v3L
	 k58kDNA6MfvVm0/q6F45hOTe5ZyM64+pVn88FEIk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SHTwdF024251
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 12:29:58 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 12:29:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 12:29:58 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SHTugB073490;
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
Subject: [PATCH v2 2/4] arm64: dts: ti: k3-j721e: Include entire FSS region in ranges
Date: Wed, 28 Aug 2024 12:29:54 -0500
Message-ID: <20240828172956.26630-3-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 10 +++++-----
 arch/arm64/boot/dts/ti/k3-j721e.dtsi            |  8 +++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 6b6ef6a306142..3731ffb4a5c96 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -354,8 +354,8 @@ fss: bus@47000000 {
 			 <0x0 0x47034000 0x0 0x47034000 0x0 0x100>, /* HBMC Control */
 			 <0x0 0x47040000 0x0 0x47040000 0x0 0x100>, /* OSPI0 Control */
 			 <0x0 0x47050000 0x0 0x47050000 0x0 0x100>, /* OSPI1 Control */
-			 <0x5 0x00000000 0x5 0x00000000 0x1 0x0000000>, /* HBMC/OSPI0 Memory */
-			 <0x7 0x00000000 0x7 0x00000000 0x1 0x0000000>; /* OSPI1 Memory */
+			 <0x0 0x50000000 0x0 0x50000000 0x0 0x10000000>, /* FSS data region 1 */
+			 <0x4 0x00000000 0x4 0x00000000 0x4 0x00000000>; /* FSS data region 0/3 */
 
 		hbmc_mux: mux-controller@47000004 {
 			compatible = "reg-mux";
@@ -367,7 +367,7 @@ hbmc_mux: mux-controller@47000004 {
 		hbmc: hyperbus@47034000 {
 			compatible = "ti,am654-hbmc";
 			reg = <0x00 0x47034000 0x00 0x100>,
-				<0x05 0x00000000 0x01 0x0000000>;
+			      <0x05 0x00000000 0x01 0x00000000>;
 			power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
 			clocks = <&k3_clks 102 0>;
 			assigned-clocks = <&k3_clks 102 5>;
@@ -381,7 +381,7 @@ hbmc: hyperbus@47034000 {
 		ospi0: spi@47040000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x0 0x47040000 0x0 0x100>,
-				<0x5 0x00000000 0x1 0x0000000>;
+			      <0x5 0x00000000 0x1 0x00000000>;
 			interrupts = <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>;
 			cdns,fifo-depth = <256>;
 			cdns,fifo-width = <4>;
@@ -399,7 +399,7 @@ ospi0: spi@47040000 {
 		ospi1: spi@47050000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x0 0x47050000 0x0 0x100>,
-				<0x7 0x00000000 0x1 0x00000000>;
+			      <0x7 0x00000000 0x1 0x00000000>;
 			interrupts = <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>;
 			cdns,fifo-depth = <256>;
 			cdns,fifo-width = <4>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index 5a72c518ceb6b..a7f2f52f42f71 100644
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
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS data region 1 */
+				 <0x04 0x00000000 0x04 0x00000000 0x04 0x00000000>; /* FSS data region 0/3 */
 		};
 	};
 
-- 
2.39.2


