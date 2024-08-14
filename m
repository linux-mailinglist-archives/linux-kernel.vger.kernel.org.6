Return-Path: <linux-kernel+bounces-287219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A769524E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BA21C21B91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C18E1C824D;
	Wed, 14 Aug 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="QY+y66X6"
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4221C822D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723671851; cv=none; b=dhvmJs6g6+yNds+I7pGajgMF8meKNv8TLs0WBC9HneeauacMnlWgArNF55SrCtTWVnQgZ8045pC+1JQbhF/+1LDcnJSVrTRJ4GlucZzo/jMQsCEfBZLbSP7FTJRkDCfBkhQ0BaviUTE0SbZE9hi7eole7HNUDtPlhCOB2nhe8HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723671851; c=relaxed/simple;
	bh=eBTZSp5j6CC8dwU82VhqOBRfXXPgHMXllqlsAAnBqs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USjxmuq/eHaqFISI4q/0M7dfjE7SX/7H/GVLoplbR17I2NIWVx7WrDhTmqXFdg8B0QY7EjQtoq2QbA64vKSpaK3D+8HKh9MCh0S+BJKZqnAd3y2MbN3G1SdORppfju9fygLNTA1E6fBQnb0W8hPoX54fh4fIad7q/YTj/IX6bSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=QY+y66X6; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240814214400012429998bc4e62ee8
        for <linux-kernel@vger.kernel.org>;
        Wed, 14 Aug 2024 23:44:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=GjhiRS8yozzeIZl8Y9QecMUTSAsMNfDPfShDO0czdT8=;
 b=QY+y66X6JrNLESGQaQKg9K0C08+XXTTESGzvk3Y/2gj2V51HBzSe3YEzYWz9KJm67GTlHd
 tW/X2xcNndXP2VJJLuuOuUyBZR+5nlGQmk4RugBoFC6cW6f53maRoWII2ZflsAY7izwK78Ur
 prVYFGQ2Z6e0ozcppUnMuGnEzmQHek19SHzU14d+wNqj2Fw0ji9mbM3eWkeE71MZDf0U5cd4
 LRKZV/hXsuRtp1edFL7JCNRtgOajqnRE5A7PUYFNyyCYbfukjuwiQ1vUj8IMixCnajpk/L/N
 G4Jw+pPIeEw2XbrRbY0iOFF+WePoCPfAvzQw9O11FLXwPyxH2YILXYUQ==;
From: "A. Zini" <alessandro.zini@siemens.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH] arm64: dts: ti: k3-am62: enable cpu freq throttling on thermal alert
Date: Wed, 14 Aug 2024 23:43:28 +0200
Message-ID: <20240814214328.14155-1-alessandro.zini@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1327013:519-21489:flowmailer

From: Alessandro Zini <alessandro.zini@siemens.com>

Enable throttling down the cpu frequency when an alert temperature
threshold (lower than the critical threshold) is reached.

Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi | 34 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625.dtsi        |  4 +++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
index a358757e26f0..c1683bbb241d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-thermal.dtsi
@@ -9,12 +9,29 @@ main0_thermal: main0-thermal {
 		thermal-sensors = <&wkup_vtm0 0>;
 
 		trips {
+			main0_alert: main0-alert {
+				temperature = <95000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+
 			main0_crit: main0-crit {
 				temperature = <105000>;	/* milliCelsius */
 				hysteresis = <2000>;	/* milliCelsius */
 				type = "critical";
 			};
 		};
+
+		cooling-maps {
+			map0 {
+				trip = <&main0_alert>;
+				cooling-device =
+					<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
 	};
 
 	main1_thermal: main1-thermal {
@@ -23,11 +40,28 @@ main1_thermal: main1-thermal {
 		thermal-sensors = <&wkup_vtm0 1>;
 
 		trips {
+			main1_alert: main1-alert {
+				temperature = <95000>;
+				hysteresis = <2000>;
+				type = "passive";
+			};
+
 			main1_crit: main1-crit {
 				temperature = <105000>;	/* milliCelsius */
 				hysteresis = <2000>;	/* milliCelsius */
 				type = "critical";
 			};
 		};
+
+		cooling-maps {
+			map0 {
+				trip = <&main1_alert>;
+				cooling-device =
+					<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
index 4193c2b3eed6..091aebb41dd9 100644
--- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
@@ -50,6 +50,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 135 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -66,6 +67,7 @@ cpu1: cpu@1 {
 			next-level-cache = <&L2_0>;
 			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 136 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -82,6 +84,7 @@ cpu2: cpu@2 {
 			next-level-cache = <&L2_0>;
 			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 137 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -98,6 +101,7 @@ cpu3: cpu@3 {
 			next-level-cache = <&L2_0>;
 			operating-points-v2 = <&a53_opp_table>;
 			clocks = <&k3_clks 138 0>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.46.0

