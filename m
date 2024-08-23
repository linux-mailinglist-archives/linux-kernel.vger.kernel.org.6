Return-Path: <linux-kernel+bounces-299693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 415C295D8C3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED914283761
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7A61C8FB4;
	Fri, 23 Aug 2024 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KXE92nwM"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB61C8232;
	Fri, 23 Aug 2024 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450093; cv=none; b=HDlVvGQgqMwRu7aHmYH0SQaina0yr8In/mVRoRycCHqlew3FctlzlKmgI2vsJFvug3/1Qc6QSnPi4OyiH5PbdVwENMMeuk7y5HTtTh6O2ov1c99tWgyqPq+ZFAvBXRHylXYSIZ+WpBmnQKlOiLiXqqjARGrqud0uqvR6qGFFqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450093; c=relaxed/simple;
	bh=vYE/qZmsfbciJiFL/bHFJHz81V4KmNB2YcG8/5eU6eU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qw2dw9j2WdTSG7lTkRjAxWt6ytSfTsgwAnI02JLRAjYB/nC/hBYR03VhkkEUbf0zIyOLmrhu06MUbXUMIY9FAsi+eWvaNevYf7ndjvbWcKbS8wdCANpUyvtGMb94myRsau+91Q6+RQYs5pyQ7Qft6tS0LJlmrksc3wckADhk8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KXE92nwM; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47NLsaS1098768;
	Fri, 23 Aug 2024 16:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724450076;
	bh=KCNTHRyGuaW+z27I5tCtxDoryE6MTJUPYVy+0mfnwJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=KXE92nwM1YlSD71VsQJ/q4oS5k/8TVEXQ1lQI43RsTG59hkTSNDmmJxGsCqkAemxh
	 j3aOeDRrRCi3nm/s8iCehXGI545jTy+1UKA6UgNfkOB+ZPLjETFE65PliU4ZSXFKr4
	 s+t369HwKKh9y4CJ6qa4mNGnRsdFOqauta10w5uc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47NLsaZ7058879
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Aug 2024 16:54:36 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Aug 2024 16:54:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Aug 2024 16:54:35 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47NLsZui123809;
	Fri, 23 Aug 2024 16:54:35 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 23 Aug 2024 16:54:28 -0500
Subject: [PATCH v2 1/4] arm64: dts: ti: k3-am62a: add opp frequencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240823-opp-v2-1-e2f67b37c299@ti.com>
References: <20240823-opp-v2-0-e2f67b37c299@ti.com>
In-Reply-To: <20240823-opp-v2-0-e2f67b37c299@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3672; i=bb@ti.com;
 h=from:subject:message-id; bh=vYE/qZmsfbciJiFL/bHFJHz81V4KmNB2YcG8/5eU6eU=;
 b=owNCWmg5MUFZJlNZdrN0gAAAY3///797pu95OfSz/d7nm8/6eMs//NaKn/fnz79vn/7973+wA
 RswHaTQBoAGQaADIZBoNAABoNNNA0xAAAGgANAGgNBoNAxNNNB5TaaPUJtQ4I00ZNABkNA00AaM
 TQGmgaaNHqaD1DQGhk0xDQB6EaeoaNDIMQDRggAA0A0GSGjJpoaaDCNDQAaDJiZGQGgAZAGmE00
 ZGJgAEAA0GgADBANAyAABg48MnsM9gFw0YQTFARpAfUwuyBvMQx2tDuJsXGAMOQEqs+9BLXc50d
 IJ2RspM0KEQegTMLFU5+NajhAWeTI+KpgwAbdIWRAaskbBRv+jm2Ern0a5c8yOwPURAY6Uf0MEr
 Nt3VOM07S0Lx+AYcPznGSAKtbFAmEwvgQVs6Zy/d0keD1+YcfEOHuQJqHclAyUVj491/ZAKEBjr
 BgSN75iQGNnh02Z0Gla9M+TSkNIRVppNak2GixipVDL+WYZU9SWihfZGqUHA2aEmZB27k4F06ax
 OY+se1RFT4Y2EfvAegbUZuIuo2hl48vNKUPVS1snebNB+HMAggQE9Qmi7OdW1QwhUVmEunZ/SYB
 MhTu19kS7EqpJCWD/tBTMuIjdS4wOZ9iy/vrXrdw2lEeiDwltBoD5a4Y45YIeGENxsG4cASjifs
 9/i7kinChIO1m6QAA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

One power management technique available to the Cortex-A53s is their
ability to dynamically scale their frequency across the device's
Operating Performance Points (OPP)

The OPPs available for the Cortex-A53s on the AM62Ax can vary based on
the silicon variant used. The SoC variant is encoded into the
WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register which is used to limit
to only OPP entries the variant supports. A table of all these variants
can be found in it's data sheet[0] for the AM62Ax family.

Add the OPP table into the SoC's ftdi file along with the syscon node to
describe the WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID register to detect
the SoC variant.

[0] https://www.ti.com/lit/ds/symlink/am62a3.pdf

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi |  5 +++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi       | 51 +++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index f5ac101a04dfa..0b1dd5390cd3f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -17,6 +17,11 @@ chipid: chipid@14 {
 			reg = <0x14 0x4>;
 		};
 
+		opp_efuse_table: syscon@18 {
+			compatible = "ti,am62-opp-efuse-table", "syscon";
+			reg = <0x18 0x4>;
+		};
+
 		cpsw_mac_syscon: ethernet-mac-syscon@200 {
 			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
 			reg = <0x200 0x8>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
index f86a23404e6dd..6c99221beb6bd 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a7.dtsi
@@ -48,6 +48,8 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 135 0>;
 		};
 
 		cpu1: cpu@1 {
@@ -62,6 +64,8 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 136 0>;
 		};
 
 		cpu2: cpu@2 {
@@ -76,6 +80,8 @@ cpu2: cpu@2 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 137 0>;
 		};
 
 		cpu3: cpu@3 {
@@ -90,6 +96,51 @@ cpu3: cpu@3 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 138 0>;
+		};
+	};
+
+	a53_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		opp-shared;
+		syscon = <&opp_efuse_table>;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x01 0x0006>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1250000000 {
+			opp-hz = /bits/ 64 <1250000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+			opp-suspend;
 		};
 	};
 

-- 
2.45.2


