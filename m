Return-Path: <linux-kernel+bounces-401792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7959C1F40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F100B24105
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0E1F4FD7;
	Fri,  8 Nov 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rkMpewpr"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E81F4702;
	Fri,  8 Nov 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076202; cv=none; b=kix2HZO8E6CphFgqBOIsXubP9k+1yMM3cLVrZFQEag8sH7HB1EVWCCR2rwtPpYxtj3BS+EVIpnH115kJ7kV2o85xEaThGUAW1BzWP55lT/wUrVNghckrSTaQurfUeRT442eJYHnkkuOFw+lfckpTpC6p0iIrM5nTp66WMbLRS60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076202; c=relaxed/simple;
	bh=I2gTX0Gvm9evKoETYHSHaukCUZCRCVANfPTHryR94kE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MM4QgyndeIVQaZw4JhRs1xnn8g4kdjqrTe6hEKMLhJnwm4FKFolSx8Gr65Uy2T7KQEBYAZ94VkU5/UobGFJbhb2BToGx84dDpmMpcSnPLp9OrQ5SOwOHGiT45XVA5pIZIrmU6xA/5rtoCIS1lHCyv6RUAjbbVauZKAd29PPW+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rkMpewpr; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4A8ETrtn2085974
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 8 Nov 2024 08:29:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731076193;
	bh=kKjKdh8uIYu5IDKofoXchUb2lw7bLvsxB0RuFLbP7sQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rkMpewprgc9kC4J9M/BvNFcAlPvrISO7sbKgSr04Bqq1vaGdtIQs+D/kwXczxMyPM
	 3ylS8MhK2+EEYRJSuVQq8gEMxF2gknzNYBOnZtoQrlX7ss3e82WkK0yb+ZlS3INkFW
	 wxpswgKbF8Q6Mi5XPMubSaVr5ePOtoFSsZ3+b6i8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A8ETr7Z072923;
	Fri, 8 Nov 2024 08:29:53 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Nov 2024 08:29:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Nov 2024 08:29:53 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A8ETrxo023832;
	Fri, 8 Nov 2024 08:29:53 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A8ETqta032072;
	Fri, 8 Nov 2024 08:29:52 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <nm@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <danishanwar@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am64-main: Switch ICSSG clock to core clock
Date: Fri, 8 Nov 2024 19:59:46 +0530
Message-ID: <20241108142946.2286098-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108142946.2286098-1-danishanwar@ti.com>
References: <20241108142946.2286098-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

ICSSG currently uses ICSSG_ICLK (clk id 20) which operates at 250MHz.
Switch ICSSG clock to ICSSG_CORE clock (clk id 0) which operates at
333MHz.

ICSSG_CORE clock will help get the most out of ICSSG as more cycles are
needed to fully support all ICSSG features.

This commit also changes assigned-clock-parents of coreclk-mux to
ICSSG_CORE clock from ICSSG_ICLK.

Performance update in dual mac mode
  With ICSSG_CORE Clk @ 333MHz
    Tx throughput - 934 Mbps
    Rx throuhput - 914 Mbps,

  With ICSSG_ICLK clk @ 250MHz,
    Tx throughput - 920 Mbps
    Rx throughput - 706 Mbps

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index c66289a4362b..ceceee2affd9 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1227,6 +1227,10 @@ icssg0: icssg@30000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x00 0x30000000 0x80000>;
+		clocks = <&k3_clks 81 0>,  /* icssg0_core_clk */
+			 <&k3_clks 81 20>; /* icssg0_iclk */
+		assigned-clocks = <&k3_clks 81 0>;
+		assigned-clock-parents = <&k3_clks 81 2>;
 
 		icssg0_mem: memories@0 {
 			reg = <0x0 0x2000>,
@@ -1252,7 +1256,7 @@ icssg0_coreclk_mux: coreclk-mux@3c {
 					clocks = <&k3_clks 81 0>,  /* icssg0_core_clk */
 						 <&k3_clks 81 20>; /* icssg0_iclk */
 					assigned-clocks = <&icssg0_coreclk_mux>;
-					assigned-clock-parents = <&k3_clks 81 20>;
+					assigned-clock-parents = <&k3_clks 81 0>;
 				};
 
 				icssg0_iepclk_mux: iepclk-mux@30 {
@@ -1397,6 +1401,10 @@ icssg1: icssg@30080000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x00 0x30080000 0x80000>;
+		clocks = <&k3_clks 82 0>,   /* icssg1_core_clk */
+			 <&k3_clks 82 20>;  /* icssg1_iclk */
+		assigned-clocks = <&k3_clks 82 0>;
+		assigned-clock-parents = <&k3_clks 82 2>;
 
 		icssg1_mem: memories@0 {
 			reg = <0x0 0x2000>,
@@ -1422,7 +1430,7 @@ icssg1_coreclk_mux: coreclk-mux@3c {
 					clocks = <&k3_clks 82 0>,   /* icssg1_core_clk */
 						 <&k3_clks 82 20>;  /* icssg1_iclk */
 					assigned-clocks = <&icssg1_coreclk_mux>;
-					assigned-clock-parents = <&k3_clks 82 20>;
+					assigned-clock-parents = <&k3_clks 82 0>;
 				};
 
 				icssg1_iepclk_mux: iepclk-mux@30 {
-- 
2.34.1


