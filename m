Return-Path: <linux-kernel+bounces-407442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A539C6D74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6C128586E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51B01FF618;
	Wed, 13 Nov 2024 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rt8mGv/s"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761CD1FF03F;
	Wed, 13 Nov 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496213; cv=none; b=CKbabpHSZoloTcy/6PGZE+1l0L1IyswrgtV/JowusvHLT7R4DDsdAO4E3owTerIPl9wND7NJQS3Zx9BTICmR6UDVwH54x0f5EpLGo7eorlilbMfynpdPm1jZLGXUUpdAmPVq4PEybXZPPLACIludTxrTu0TW4bF07W1CVi8EFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496213; c=relaxed/simple;
	bh=gqo+4Eow4bw+MA5Y118fPvWvX1BYT/VWc/q4jwn69m4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRZT0wbJIJk/vLLrVHnbWXFX4Io+JKSRL10WLMFUzpT6Ag+IJ8lUNGSmB4kj/+w7Sur6iDkAr9I1ICDx94MGWwnfKKxFyGgBKbjAc/Ohibbu7QnS/WTYWg/Pr6j+CCQVveBw9p1Aw7BYz5CoYlM7jlaxKlh1kKiSC+uxdxqPv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rt8mGv/s; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ADBA3YF032469;
	Wed, 13 Nov 2024 05:10:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731496203;
	bh=ezUZUBpfTn5lX0jVgbBCSPADKDHBLLkKbCQkyiQs3cI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Rt8mGv/sKN6UC2HLMqWZpyhJX3gVte+QQxbH1AllliS1vEDoAuLSNX0JP+PsT2FGw
	 uht6k0Q+30NcRddWzN1jdrkfFfRQhJt9CiLtg04ppIQxScmc4y6OhDcEKAbqjhxqYX
	 fh5JB7YXakLgYB4wYzHAyMcD6Ew38MA3hAdlh4dg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ADBA3wK031291
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 13 Nov 2024 05:10:03 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Nov 2024 05:10:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Nov 2024 05:10:03 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ADBA2jZ077257;
	Wed, 13 Nov 2024 05:10:02 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4ADBA2Xk021307;
	Wed, 13 Nov 2024 05:10:02 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-am64-main: Switch ICSSG clock to core clock
Date: Wed, 13 Nov 2024 16:39:55 +0530
Message-ID: <20241113110955.3876045-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113110955.3876045-1-danishanwar@ti.com>
References: <20241113110955.3876045-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

ICSSG has 7 available clocks per instance. Add all the cloks to ICSSG
nodes. ICSSG currently uses ICSSG_ICLK (clk id 20) which operates at
250MHz. Switch ICSSG clock to ICSSG_CORE clock (clk id 0) which operates at
333MHz.

ICSSG_CORE clock will help get the most out of ICSSG as more cycles are
needed to fully support all ICSSG features.

This commit also changes assigned-clock-parents of coreclk-mux to
ICSSG_CORE clock from ICSSG_ICLK.

Performance update in dual mac mode
  With ICSSG_CORE Clk @ 333MHz
    Tx throughput - 934 Mbps
    Rx throughput - 914 Mbps,

  With ICSSG_ICLK clk @ 250MHz,
    Tx throughput - 920 Mbps
    Rx throughput - 706 Mbps

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index c66289a4362b..324eb44c258d 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1227,6 +1227,15 @@ icssg0: icssg@30000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x00 0x30000000 0x80000>;
+		clocks = <&k3_clks 81 0>,  /* icssg0_core_clk */
+			 <&k3_clks 81 3>,  /* icssg0_iep_clk */
+			 <&k3_clks 81 16>, /* icssg0_rgmii_mhz_250_clk */
+			 <&k3_clks 81 17>, /* icssg0_rgmii_mhz_50_clk */
+			 <&k3_clks 81 18>, /* icssg0_rgmii_mhz_5_clk */
+			 <&k3_clks 81 19>, /* icssg0_uart_clk */
+			 <&k3_clks 81 20>; /* icssg0_iclk */
+		assigned-clocks = <&k3_clks 81 0>;
+		assigned-clock-parents = <&k3_clks 81 2>;
 
 		icssg0_mem: memories@0 {
 			reg = <0x0 0x2000>,
@@ -1252,7 +1261,7 @@ icssg0_coreclk_mux: coreclk-mux@3c {
 					clocks = <&k3_clks 81 0>,  /* icssg0_core_clk */
 						 <&k3_clks 81 20>; /* icssg0_iclk */
 					assigned-clocks = <&icssg0_coreclk_mux>;
-					assigned-clock-parents = <&k3_clks 81 20>;
+					assigned-clock-parents = <&k3_clks 81 0>;
 				};
 
 				icssg0_iepclk_mux: iepclk-mux@30 {
@@ -1397,6 +1406,15 @@ icssg1: icssg@30080000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x00 0x30080000 0x80000>;
+		clocks = <&k3_clks 82 0>,  /* icssg1_core_clk */
+			 <&k3_clks 82 3>,  /* icssg1_iep_clk */
+			 <&k3_clks 82 16>, /* icssg1_rgmii_mhz_250_clk */
+			 <&k3_clks 82 17>, /* icssg1_rgmii_mhz_50_clk */
+			 <&k3_clks 82 18>, /* icssg1_rgmii_mhz_5_clk */
+			 <&k3_clks 82 19>, /* icssg1_uart_clk */
+			 <&k3_clks 82 20>; /* icssg1_iclk */
+		assigned-clocks = <&k3_clks 82 0>;
+		assigned-clock-parents = <&k3_clks 82 2>;
 
 		icssg1_mem: memories@0 {
 			reg = <0x0 0x2000>,
@@ -1422,7 +1440,7 @@ icssg1_coreclk_mux: coreclk-mux@3c {
 					clocks = <&k3_clks 82 0>,   /* icssg1_core_clk */
 						 <&k3_clks 82 20>;  /* icssg1_iclk */
 					assigned-clocks = <&icssg1_coreclk_mux>;
-					assigned-clock-parents = <&k3_clks 82 20>;
+					assigned-clock-parents = <&k3_clks 82 0>;
 				};
 
 				icssg1_iepclk_mux: iepclk-mux@30 {
-- 
2.34.1


