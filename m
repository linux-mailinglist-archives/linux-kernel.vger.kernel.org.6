Return-Path: <linux-kernel+bounces-279139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537694B977
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BDC1C20DB8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B3B18D63E;
	Thu,  8 Aug 2024 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="bqbP4YhC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="a7buNEdN"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E62D145FE0;
	Thu,  8 Aug 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107835; cv=none; b=fK6VhXEtEZWt+IokJmoN0KThfvp6GUDh6uU4k0ZZ49ybDy1q96Pk6RbP7it772rw7SJXyPoUQvHwbzEeRdcoNMmdek93lFUr4JKEJOQZLSD2pNv6vEbfZU0BjIx7omDXo03KYTAe2pfYqxNgToM6k+LH+W3m+Ee/ikRiU4NzVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107835; c=relaxed/simple;
	bh=3Nuh7Ymw4p9mmj/hmi80A9HOla1TJH0HdtM2MSn63Go=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kKoX4HTY68FHRMUultj2CI91L6l2YL+yfLZjpJB0htaqt47gjBd3Agjc6Cgsp06i32bEzbKN2Cay/hRAaHdPd2x6Y3y3zE7gv73o4AnjtkJEuxwtb8VlXwNfn04bIfWkdDkmD3FpW31yLfUU/hr0Te6ccSTTFiE5YtzUs8z00Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=bqbP4YhC; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=a7buNEdN reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723107831; x=1754643831;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e/440+A8dXK0xe7E7t1UQYOm04r40gqeXMmIrOnIwgE=;
  b=bqbP4YhCss9U8dLmMZ7/ivVrRGfHBkvp69bkVShXKEp1dnfggqCLmsXP
   KkJunVp2fldfdxJ8xGtyWJMIJR2e4+U6hnM+y1Znwa3xr8MkKjLERe9kT
   TMiGK8NWYYkNVr+j18KdXoY/XZCeybHOQwdWVnHIgkMMlqbMcW4EjLB+u
   QCoolS0d8s3dCrdIZ5Xqr16oQAUFIlTzAdbIb3i/pKl3Xeu2j5oMHedub
   QCb3xDW0ATDPMED5ZooQkomyQzruS+p4SGmZhzMsQVUh/aOBvS/ykWIvf
   opMNM6V2lV7scSoV9xiU4lHAFknJNWYs4s3sSAWMtSznwqfdax1F+FTgJ
   Q==;
X-CSE-ConnectionGUID: bgTlkpRNTKqBVidGHiHAMA==
X-CSE-MsgGUID: KkxzrK0GSZO28hfEUSbJwA==
X-IronPort-AV: E=Sophos;i="6.09,272,1716242400"; 
   d="scan'208";a="38310522"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Aug 2024 11:03:43 +0200
X-CheckPoint: {66B489EF-1-CFE9415D-C7159436}
X-MAIL-CPID: CD2309DF6539872ED09BA5D025073AB1_1
X-Control-Analysis: str=0001.0A782F1E.66B489EF.0049,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C5F6161356;
	Thu,  8 Aug 2024 11:03:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723107818; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=e/440+A8dXK0xe7E7t1UQYOm04r40gqeXMmIrOnIwgE=;
	b=a7buNEdN+opiCalsy34kFxBfiwjK1gA2b6STxzvvF76LaIslywzc+N7Iun9tTUDkitLAIQ
	FLa33GmNpJ+Qtj6kDU2rp30qyfUWubP3AxSLpSyruJKPcltQUXXs+cjLFk/jE4ALpBMOJn
	6pTWrEMMhVOJTaRmQnPrP1ehK+hzWQtwiPRtXZ1pQo2onN6UVf4oFoq65S2Ih8oQeQGSBN
	meazJRrIh44MCri4KZk0doMEEwnIx7V6D5GYY5DQDAQ1+WC8IohIO6N36G7yUw/s7PO4qj
	EcXW3gRaVzdbd0mNqFvTuFvmp0Nx5oVelXhb1Pb98tM8Yn6gINrdUihVj0c69g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs
Date: Thu,  8 Aug 2024 11:03:26 +0200
Message-Id: <20240808090326.425296-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

imx8-ss-vpu only contained imx8qxp IRQ numbers, only mu2_m0 uses the
correct imx8qm IRQ number, as imx8qxp lacks this MU.
Fix this by providing imx8qm IRQ numbers in the main imx8-ss-vpu.dtsi
and override the IRQ numbers in SoC-specific imx8qxp-ss-vpu.dtsi, similar
to reg property for VPU core devices.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
I did not include a Fixes tag as adding support for imx8qxp and imx8qm
is split into several commits. It's at lease the combination of the
following commits:

0d9968d98467d ("arm64: dts: freescale: imx8q: add imx vpu codec entries")
b4efce453f0ca ("arm64: dts: imx8qm: add vpu decoder and encoder")

 arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi    | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
index c6540768bdb92..87211c18d65a9 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi
@@ -15,7 +15,7 @@ vpu: vpu@2c000000 {
 	mu_m0: mailbox@2d000000 {
 		compatible = "fsl,imx6sx-mu";
 		reg = <0x2d000000 0x20000>;
-		interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>;
 		#mbox-cells = <2>;
 		power-domains = <&pd IMX_SC_R_VPU_MU_0>;
 		status = "disabled";
@@ -24,7 +24,7 @@ mu_m0: mailbox@2d000000 {
 	mu1_m0: mailbox@2d020000 {
 		compatible = "fsl,imx6sx-mu";
 		reg = <0x2d020000 0x20000>;
-		interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>;
 		#mbox-cells = <2>;
 		power-domains = <&pd IMX_SC_R_VPU_MU_1>;
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi
index 7894a3ab26d6b..f81937b5fb720 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi
@@ -5,6 +5,14 @@
  * Author: Alexander Stein
  */
 
+&mu_m0 {
+	interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&mu1_m0 {
+	interrupts = <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &vpu_core0 {
 	reg = <0x2d040000 0x10000>;
 };
-- 
2.34.1


