Return-Path: <linux-kernel+bounces-393156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E934A9B9C7E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5D71C210FD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 03:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A575314A4DF;
	Sat,  2 Nov 2024 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="WK6owBrL"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F1E433B9;
	Sat,  2 Nov 2024 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730516968; cv=none; b=aoJNlnszdWrlz72DzO2c5Jo4+/SFaDLOg/AJTSrlseE2yuFqYwXVL62mZV64cNf7vQShUr2cigNS7UPcjvXR4L0uL+6XJmOvw3yZyXZ1Kf38+vi5fhP06bLTv4+AltDJ7QhY3br9d/dKy5y2JrAEtmATx8FJ4zlBuAMdaq31eco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730516968; c=relaxed/simple;
	bh=WscoEetMerZfbgKZnga9triImhcswg0ki+akIuXVHxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTFnavStkyuyhpSmzrW/IndNJBPO2VHEwdF1ThyG2TDD6QI7f5qwaSOLiBjn+Aj/zOErZS5bhzDu0H6HqDP/1RFDdaVThvWHlXDJodikpMkd+QpBjSxnL7GT5gIqylhzlh2g5yY5dUCyFu25269eAxX6qNadyRm++HR5rTLbXHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=WK6owBrL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730516958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULWUQV2euOeJnEAJ3CyxZrGsfmuHWmE0j0muWaOqgrQ=;
	b=WK6owBrL+0sFVsFZHUFDd9/PO+J6TGgQR0g2+EyEyo4l3SaN+0G4WMosbdezAmNunoD7s8
	Tlne6ENA0gkB21AazsUunrvVZxqGNmyEzVhZ62SlDytVN/M7Eb79c+bjGwEzXl4S3NfpYx
	jLwG7c/7Qc6vXBAUGt6QlHGfgiOeP0KQS8YXW/EYJ4lSU2Ew48CFytktHFH3AeRcwGi+rD
	NGF0oSCP6GkIFGiXkI0s7kWPXC9PrOdGA3Pqjqiazrp3Gnsyrey8c6UnWvCfQ2QP9eesrp
	JLtA0NWDZmAxfhnxZFE+TMggaDS/g10WCaysInzRG8N+90Pfeigd6RNLZY+JBA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	didi.debian@cknow.org
Subject: [PATCH v2 2/3] arm64: dts: rockchip: Prepare RK356x SoC dtsi files for per-variant OPPs
Date: Sat,  2 Nov 2024 04:09:00 +0100
Message-Id: <77e7450b8280bbdf4e2dc47366c9da85d4d8d1de.1730516702.git.dsimic@manjaro.org>
In-Reply-To: <cover.1730516702.git.dsimic@manjaro.org>
References: <cover.1730516702.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Rename the Rockchip RK356x SoC dtsi files and, consequently, adjust their
contents appropriately, to prepare them for the ability to specify different
CPU and GPU OPPs for each of the supported RK356x SoC variants.

The first new RK356x SoC variant to be introduced is the RK3566T, which the
Pine64 Quartz64 Zero SBC is officially based on. [1]  Some other SBCs are
also based on the RK3566T variant, including Radxa ROCK 3C and ZERO 3E/3W,
but the slight trouble is that Radxa doesn't state that officially.  Though,
it's rather easy to spot the RK3566T on such boards, because their official
specifications state that the maximum frequency for the Cortex-A55 cores is
lower than the "full-fat" RK3566's 1.8 GHz. [2][3][4]

These changes follow the approach used for the Rockchip RK3588 SoC variants,
which was introduced and described further in commit def88eb4d836 ("arm64:
dts: rockchip: Prepare RK3588 SoC dtsi files for per-variant OPPs").  Please
see that commit for a more detailed explanation.

No functional changes are introduced, which was validated by decompiling and
comparing all affected board dtb files before and after these changes.  In
more detail, the affected dtb files have some of their blocks shuffled around
a bit and some of their phandles have different values, as a result of the
changes to the order in which the building blocks from the parent dtsi files
are included, but they effectively remain the same as the originals.

As a side note, due to the nature of introduced changes, this commit is a bit
more readable when viewed using the --break-rewrites option for git-log(1).

[1] https://wiki.pine64.org/wiki/Quartz64
[2] https://dl.radxa.com/rock3/docs/hw/3c/radxa_rock3c_product_brief.pdf
[3] https://dl.radxa.com/zero3/docs/hw/3e/radxa_zero_3e_product_brief.pdf
[4] https://dl.radxa.com/zero3/docs/hw/3w/radxa_zero_3w_product_brief.pdf

Related-to: def88eb4d836 ("arm64: dts: rockchip: Prepare RK3588 SoC dtsi files for per-variant OPPs")
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 .../{rk3566.dtsi => rk3566-base.dtsi}         |   2 +-
 arch/arm64/boot/dts/rockchip/rk3566.dtsi      | 142 +++++++++++++-----
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 114 +++++++++++++-
 .../{rk356x.dtsi => rk356x-base.dtsi}         |  87 -----------
 4 files changed, 215 insertions(+), 130 deletions(-)
 copy arch/arm64/boot/dts/rockchip/{rk3566.dtsi => rk3566-base.dtsi} (95%)
 rewrite arch/arm64/boot/dts/rockchip/rk3566.dtsi (87%)
 rename arch/arm64/boot/dts/rockchip/{rk356x.dtsi => rk356x-base.dtsi} (96%)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-base.dtsi
similarity index 95%
copy from arch/arm64/boot/dts/rockchip/rk3566.dtsi
copy to arch/arm64/boot/dts/rockchip/rk3566-base.dtsi
index 6c4b17d27bdc..e56e0b6ba941 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-base.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
-#include "rk356x.dtsi"
+#include "rk356x-base.dtsi"
 
 / {
 	compatible = "rockchip,rk3566";
diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
dissimilarity index 87%
index 6c4b17d27bdc..3fcca79279f7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
@@ -1,35 +1,107 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-
-#include "rk356x.dtsi"
-
-/ {
-	compatible = "rockchip,rk3566";
-};
-
-&pipegrf {
-	compatible = "rockchip,rk3566-pipe-grf", "syscon";
-};
-
-&power {
-	power-domain@RK3568_PD_PIPE {
-		reg = <RK3568_PD_PIPE>;
-		clocks = <&cru PCLK_PIPE>;
-		pm_qos = <&qos_pcie2x1>,
-			 <&qos_sata1>,
-			 <&qos_sata2>,
-			 <&qos_usb3_0>,
-			 <&qos_usb3_1>;
-		#power-domain-cells = <0>;
-	};
-};
-
-&usb_host0_xhci {
-	phys = <&usb2phy0_otg>;
-	phy-names = "usb2-phy";
-	extcon = <&usb2phy0>;
-	maximum-speed = "high-speed";
-};
-
-&vop {
-	compatible = "rockchip,rk3566-vop";
-};
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3566-base.dtsi"
+
+/ {
+	cpu0_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <850000 850000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <850000 850000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <850000 850000 1150000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <900000 900000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1025000 1025000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <1100000 1100000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1150000 1150000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
+	gpu_opp_table: opp-table-1 {
+		compatible = "operating-points-v2";
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <850000 850000 1000000>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <850000 850000 1000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <850000 850000 1000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000 900000 1000000>;
+		};
+
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <950000 950000 1000000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 5c54898f6ed1..ecaefe208e3e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -3,11 +3,99 @@
  * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
  */
 
-#include "rk356x.dtsi"
+#include "rk356x-base.dtsi"
 
 / {
 	compatible = "rockchip,rk3568";
 
+	cpu0_opp_table: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <850000 850000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <850000 850000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <850000 850000 1150000>;
+			clock-latency-ns = <40000>;
+			opp-suspend;
+		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <900000 900000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1025000 1025000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <1100000 1100000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1150000 1150000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+
+		opp-1992000000 {
+			opp-hz = /bits/ 64 <1992000000>;
+			opp-microvolt = <1150000 1150000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+	};
+
+	gpu_opp_table: opp-table-1 {
+		compatible = "operating-points-v2";
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <850000 850000 1000000>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <850000 850000 1000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <850000 850000 1000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000 900000 1000000>;
+		};
+
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <950000 950000 1000000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
+		};
+	};
+
 	sata0: sata@fc000000 {
 		compatible = "rockchip,rk3568-dwc-ahci", "snps,dwc-ahci";
 		reg = <0 0xfc000000 0 0x1000>;
@@ -269,12 +357,24 @@ combphy0: phy@fe820000 {
 	};
 };
 
-&cpu0_opp_table {
-	opp-1992000000 {
-		opp-hz = /bits/ 64 <1992000000>;
-		opp-microvolt = <1150000 1150000 1150000>;
-		clock-latency-ns = <40000>;
-	};
+&cpu0 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&cpu1 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&cpu2 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&cpu3 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
 };
 
 &pipegrf {
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
similarity index 96%
rename from arch/arm64/boot/dts/rockchip/rk356x.dtsi
rename to arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 534593f2ed0b..62be06f3b863 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -56,7 +56,6 @@ cpu0: cpu@0 {
 			clocks = <&scmi_clk 0>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
-			operating-points-v2 = <&cpu0_opp_table>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -72,7 +71,6 @@ cpu1: cpu@100 {
 			reg = <0x0 0x100>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
-			operating-points-v2 = <&cpu0_opp_table>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -88,7 +86,6 @@ cpu2: cpu@200 {
 			reg = <0x0 0x200>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
-			operating-points-v2 = <&cpu0_opp_table>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -104,7 +101,6 @@ cpu3: cpu@300 {
 			reg = <0x0 0x300>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
-			operating-points-v2 = <&cpu0_opp_table>;
 			i-cache-size = <0x8000>;
 			i-cache-line-size = <64>;
 			i-cache-sets = <128>;
@@ -128,54 +124,6 @@ l3_cache: l3-cache {
 		cache-sets = <512>;
 	};
 
-	cpu0_opp_table: opp-table-0 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-408000000 {
-			opp-hz = /bits/ 64 <408000000>;
-			opp-microvolt = <850000 850000 1150000>;
-			clock-latency-ns = <40000>;
-		};
-
-		opp-600000000 {
-			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <850000 850000 1150000>;
-			clock-latency-ns = <40000>;
-		};
-
-		opp-816000000 {
-			opp-hz = /bits/ 64 <816000000>;
-			opp-microvolt = <850000 850000 1150000>;
-			clock-latency-ns = <40000>;
-			opp-suspend;
-		};
-
-		opp-1104000000 {
-			opp-hz = /bits/ 64 <1104000000>;
-			opp-microvolt = <900000 900000 1150000>;
-			clock-latency-ns = <40000>;
-		};
-
-		opp-1416000000 {
-			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <1025000 1025000 1150000>;
-			clock-latency-ns = <40000>;
-		};
-
-		opp-1608000000 {
-			opp-hz = /bits/ 64 <1608000000>;
-			opp-microvolt = <1100000 1100000 1150000>;
-			clock-latency-ns = <40000>;
-		};
-
-		opp-1800000000 {
-			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <1150000 1150000 1150000>;
-			clock-latency-ns = <40000>;
-		};
-	};
-
 	display_subsystem: display-subsystem {
 		compatible = "rockchip,display-subsystem";
 		ports = <&vop_out>;
@@ -196,40 +144,6 @@ scmi_clk: protocol@14 {
 		};
 	};
 
-	gpu_opp_table: opp-table-1 {
-		compatible = "operating-points-v2";
-
-		opp-200000000 {
-			opp-hz = /bits/ 64 <200000000>;
-			opp-microvolt = <850000 850000 1000000>;
-		};
-
-		opp-300000000 {
-			opp-hz = /bits/ 64 <300000000>;
-			opp-microvolt = <850000 850000 1000000>;
-		};
-
-		opp-400000000 {
-			opp-hz = /bits/ 64 <400000000>;
-			opp-microvolt = <850000 850000 1000000>;
-		};
-
-		opp-600000000 {
-			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <900000 900000 1000000>;
-		};
-
-		opp-700000000 {
-			opp-hz = /bits/ 64 <700000000>;
-			opp-microvolt = <950000 950000 1000000>;
-		};
-
-		opp-800000000 {
-			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <1000000 1000000 1000000>;
-		};
-	};
-
 	hdmi_sound: hdmi-sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "HDMI";
@@ -635,7 +549,6 @@ gpu: gpu@fde60000 {
 		clocks = <&scmi_clk 1>, <&cru CLK_GPU>;
 		clock-names = "gpu", "bus";
 		#cooling-cells = <2>;
-		operating-points-v2 = <&gpu_opp_table>;
 		power-domains = <&power RK3568_PD_GPU>;
 		status = "disabled";
 	};

