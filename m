Return-Path: <linux-kernel+bounces-283834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EFB94F92B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0081B21E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB81194C8F;
	Mon, 12 Aug 2024 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p+Ao+wJF"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59150198E60
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723499503; cv=none; b=BDTSIOXT73gdvAFEvyUbJgXJjhN7OC7Px9EqAnShbY/Bc2m/EqykjG+g01IHuLUiab7eQWoisHhyY6TVXdjfGmliLP0SBw1wOgZmfGk3fOI5lXBtQXLAJ2k1ml5i+j/wH+jHFYJ0otPGivS3QdwCnB+GyZwCHHY+5MhOUL1TF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723499503; c=relaxed/simple;
	bh=NCuLiByUXURV2FoSaj7KvZABKA+4jtpNi83z2HCZI40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VyrFfNxmuvSGjJ7g7EmGchC3LFgL+bTskKrijc966ks43MSmBwUfHMsbYX0o7Ip2nhB19ISYVAFfnl+e0ZLEzPZR1U0qfTWJTVlQKyjCTOageM20z/+0tMt95SUVFi25ZLdQQsqZYlsHatzKzhMfWniJr2dh6xHxcDJ2zOVTwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p+Ao+wJF; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723499499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENZn4L1RAB9o73amjJzb3/C6+GzUAncJ/FTZDbsVazI=;
	b=p+Ao+wJFCr7d+OlONUc7xkLlPaLuZsiDDqIZRtjRM1USEk+PY417r1JMMUAh4e5Op+vwAy
	V7aidpB4Y0VqpDeg7N2mqSPfxeqtN1iAzwivgYaVS4EuvG6t2HSvKAaJnEiB6kGBsVbQBL
	2YOpNfVu5a6E6wL3i+1RaZCYGFz8odQ=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 3/3] arm64: zynqmp: Add thermal zones
Date: Mon, 12 Aug 2024 17:51:28 -0400
Message-Id: <20240812215129.3599832-4-sean.anderson@linux.dev>
In-Reply-To: <20240812215129.3599832-1-sean.anderson@linux.dev>
References: <20240812215129.3599832-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add some thermal trip points. We can't undervolt the CPUs to save power
when we underclock them, so there isn't really a point in throttling
them until we are about to overheat. As such, the passive trip point is
right below the critical trip point.

The critical trip point is the extended/industrial-grade maximum
junction temperature of 100C minus the maximum temperature sensor error
of 3.5C (in the range -55C to 110C). Automotive- and military-grade
parts can go up to 125C, but as far as I can tell there is no way to
detect them at runtime. Userspace can adjust the trip points at runtime,
but this may not be viable when booting above 100C. I think it's
reasonable to ask automotive/military users to edit their device trees
to bump the trip points, but if that proves to be an issue we can
always go with no default temperatures. However, that wouldn't be too
nice for the majority of extended/industrial users.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 86 ++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 21c1adbaf35f..467f084c6469 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/power/xlnx-zynqmp-power.h>
 #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "xlnx,zynqmp";
@@ -36,6 +37,7 @@ cpus {
 		#size-cells = <0>;
 
 		cpu0: cpu@0 {
+			#cooling-cells = <2>;
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "psci";
@@ -46,6 +48,7 @@ cpu0: cpu@0 {
 		};
 
 		cpu1: cpu@1 {
+			#cooling-cells = <2>;
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "psci";
@@ -56,6 +59,7 @@ cpu1: cpu@1 {
 		};
 
 		cpu2: cpu@2 {
+			#cooling-cells = <2>;
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "psci";
@@ -66,6 +70,7 @@ cpu2: cpu@2 {
 		};
 
 		cpu3: cpu@3 {
+			#cooling-cells = <2>;
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "psci";
@@ -406,6 +411,87 @@ ams {
 			<&xilinx_ams 27>, <&xilinx_ams 28>, <&xilinx_ams 29>;
 	};
 
+
+	tsens_apu: thermal-sensor-apu {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&xilinx_ams 7>;
+		io-channel-names = "sensor-channel";
+	};
+
+	tsens_rpu: thermal-sensor-rpu {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&xilinx_ams 8>;
+		io-channel-names = "sensor-channel";
+	};
+
+	tsens_pl: thermal-sensor-pl {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&xilinx_ams 20>;
+		io-channel-names = "sensor-channel";
+	};
+
+	thermal-zones {
+		apu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tsens_apu>;
+
+			trips {
+				apu_passive: passive {
+					temperature = <93000>;
+					hysteresis = <3500>;
+					type = "passive";
+				};
+
+				apu_critical: critical {
+					temperature = <96500>;
+					hysteresis = <3500>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map {
+					trip = <&apu_passive>;
+					cooling-device =
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		rpu-thermal {
+			polling-delay = <10000>;
+			thermal-sensors = <&tsens_rpu>;
+
+			trips {
+				critical {
+					temperature = <96500>;
+					hysteresis = <3500>;
+					type = "critical";
+				};
+			};
+		};
+
+		pl-thermal {
+			polling-delay = <10000>;
+			thermal-sensors = <&tsens_pl>;
+
+			trips {
+				critical {
+					temperature = <96500>;
+					hysteresis = <3500>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	amba: axi {
 		compatible = "simple-bus";
 		bootph-all;
-- 
2.35.1.1320.gc452695387.dirty


