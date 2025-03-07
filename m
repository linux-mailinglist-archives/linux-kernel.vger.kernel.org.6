Return-Path: <linux-kernel+bounces-550217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4E7A55CAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D02C3B2963
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68F0155C87;
	Fri,  7 Mar 2025 01:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln0sEF+y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287421547C0;
	Fri,  7 Mar 2025 01:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309685; cv=none; b=pUHQPy1CIZ1zqo0rZlimIoA1382+x4eaaVCokXN+E4rxUgr3gljNbvgtgzJUVNDUIEYkAJf7/F1nDV/PkpK/zN6T7FIjuf1V9UolwEAgChWa1CHzCnHq00FTyiYThaMi/oQBaVUj50XkMZyHl6p3JSuzDTHyzucrerVFDD05tt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309685; c=relaxed/simple;
	bh=RlfOMZj3emqkxFb+feCatg2AnFF5nDS/d+HMUOBQckw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fD6hm0dGeUiG7oTz89VRq1gEfbue2KluvIV9MHeRbx4MXFLWBJoHoua7rFOO2B8OEjGtNWVTeYVO4ze8ZN264cCRJ3Exnw858Nj4s8RhvVp4NlFmN1MiHmZeTXtluSSHwIMglZZlHir4yOStJdbQ8GluwKD4u/v06sSyaQ8ZgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln0sEF+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911C2C4CEE0;
	Fri,  7 Mar 2025 01:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741309684;
	bh=RlfOMZj3emqkxFb+feCatg2AnFF5nDS/d+HMUOBQckw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ln0sEF+yDX5uxme0z1htcAeJNMJL2ySqi8b97uuHbt//7LquDveqdsA97mdAyHBJ5
	 mkH/V1EljqlTcc2i17od6/BWtnha6QwNytuVpIgETXXjo6XCw6BJM/axKdBFBCf/yK
	 Eb3LkqRhkanc1oacaO3V88/WAePny4XLY+Ieu1gpeevRQoo3ZKGQz0Dfa0utIQd5i7
	 qstRqidLqRwooUr7aEbKsMvMihH6SqbnQSB+gzrKzzZfqReTYUBONtoJUtwsdDFThY
	 ACak/82UZcz+ajUmT/JvNVrE7JzzP5clDrnHKdMWbf98gjCe2ILr+fsBSAAFi9+2aW
	 dqn3XejhUQawA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 06 Mar 2025 19:07:44 -0600
Subject: [PATCH 2/4] arm64: dts: amd/seattle: Move and simplify fixed
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-dt-amd-fixes-v1-2-011c423ba99a@kernel.org>
References: <20250306-dt-amd-fixes-v1-0-011c423ba99a@kernel.org>
In-Reply-To: <20250306-dt-amd-fixes-v1-0-011c423ba99a@kernel.org>
To: soc@kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

The fixed clocks are not part of "simple-bus", so move them out of the
bus to the top-level. In the process, use the preferred node names of
"clock-<freq>". There's also little reason to have multiple fixed
clocks at the same frequencies, so remove them keeping the labels
to minimize the change.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/amd/amd-seattle-clks.dtsi   | 24 ++++++---------------
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi    |  4 ++--
 arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi | 28 -------------------------
 3 files changed, 8 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-clks.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-clks.dtsi
index 2dd2c28171ee..73f687773ce6 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-clks.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-clks.dtsi
@@ -5,51 +5,39 @@
  * Copyright (C) 2014 Advanced Micro Devices, Inc.
  */
 
-	adl3clk_100mhz: clk100mhz_0 {
+	adl3clk_100mhz: uartspiclk_100mhz: clock-100000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <100000000>;
 		clock-output-names = "adl3clk_100mhz";
 	};
 
-	ccpclk_375mhz: clk375mhz {
+	ccpclk_375mhz: clock-375000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <375000000>;
 		clock-output-names = "ccpclk_375mhz";
 	};
 
-	sataclk_333mhz: clk333mhz {
+	sataclk_333mhz: clock-333000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <333000000>;
 		clock-output-names = "sataclk_333mhz";
 	};
 
-	pcieclk_500mhz: clk500mhz_0 {
+	dmaclk_500mhz: pcieclk_500mhz: clock-500000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <500000000>;
 		clock-output-names = "pcieclk_500mhz";
 	};
 
-	dmaclk_500mhz: clk500mhz_1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <500000000>;
-		clock-output-names = "dmaclk_500mhz";
-	};
-
-	miscclk_250mhz: clk250mhz_4 {
+	xgmacclk0_dma_250mhz: xgmacclk0_ptp_250mhz: xgmacclk1_dma_250mhz: xgmacclk1_ptp_250mhz:
+	miscclk_250mhz: clock-250000000 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <250000000>;
 		clock-output-names = "miscclk_250mhz";
 	};
 
-	uartspiclk_100mhz: clk100mhz_1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-		clock-output-names = "uartspiclk_100mhz";
-	};
diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index d3d931eb7677..6a073d13478d 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -11,6 +11,8 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	/include/ "amd-seattle-clks.dtsi"
+
 	gic0: interrupt-controller@e1101000 {
 		compatible = "arm,gic-400", "arm,cortex-a15-gic";
 		interrupt-controller;
@@ -51,8 +53,6 @@ smb0: smb {
 		 */
 		dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x0>;
 
-		/include/ "amd-seattle-clks.dtsi"
-
 		sata0: sata@e0300000 {
 			compatible = "snps,dwc-ahci";
 			reg = <0 0xe0300000 0 0xf0000>;
diff --git a/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
index 9259e547e2e8..056dd3e35042 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-xgbe-b.dtsi
@@ -5,34 +5,6 @@
  * Copyright (C) 2015 Advanced Micro Devices, Inc.
  */
 
-	xgmacclk0_dma_250mhz: clk250mhz_0 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <250000000>;
-		clock-output-names = "xgmacclk0_dma_250mhz";
-	};
-
-	xgmacclk0_ptp_250mhz: clk250mhz_1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <250000000>;
-		clock-output-names = "xgmacclk0_ptp_250mhz";
-	};
-
-	xgmacclk1_dma_250mhz: clk250mhz_2 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <250000000>;
-		clock-output-names = "xgmacclk1_dma_250mhz";
-	};
-
-	xgmacclk1_ptp_250mhz: clk250mhz_3 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <250000000>;
-		clock-output-names = "xgmacclk1_ptp_250mhz";
-	};
-
 	xgmac0: xgmac@e0700000 {
 		compatible = "amd,xgbe-seattle-v1a";
 		reg = <0 0xe0700000 0 0x80000>,

-- 
2.47.2


