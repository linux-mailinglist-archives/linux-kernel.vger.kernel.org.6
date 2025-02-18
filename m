Return-Path: <linux-kernel+bounces-518553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B6FA390D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 03:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48E43A46C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 02:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8C8149E17;
	Tue, 18 Feb 2025 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=studer.dev header.i=@studer.dev header.b="pJHRuUoi"
Received: from mail-b.studer.dev (mail-b.studer.dev [3.21.136.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FD31EEE6;
	Tue, 18 Feb 2025 02:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.21.136.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739845021; cv=none; b=DTAf3DiL04yTD1871ahpGyCm6QvzpB1yEfxHmcCPoORTRFL9Jh7A77mn4FATOWICTJMoNinS3v7CvjTVzjidwe761rjP+53pilEDaceczz6ftmL9lMWEY8XMc3qyLxKkCRt2TQNnWQ0/F3osJuOmp68wri+e8epSO4vyJaR2rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739845021; c=relaxed/simple;
	bh=1JXVA2sVlnhfQcgr028+qseD4GYQ502lyjwFC65z7iA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeeNnH9jseCD8ekaOmCF5TemrME3xyuz6XCVTfq3vn6475A6WEYTi2rKlpRzKm+IJ+yBkApTLpTYfl2/w0aZQi6kw7hWoem6gM7Hslb6TFVb428Qa/O4eALCPx7/0fxdPZGtOLb/V+fzvTrKWRT4hCaiPESypdDq9DkeIO6+r30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=studer.dev; spf=pass smtp.mailfrom=studer.dev; dkim=pass (2048-bit key) header.d=studer.dev header.i=@studer.dev header.b=pJHRuUoi; arc=none smtp.client-ip=3.21.136.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=studer.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=studer.dev
Received: from mail.studer.dev (mail.studer.dev [168.62.161.121])
	by mail-b.studer.dev (Postfix) with ESMTPSA id 0913840028;
	Tue, 18 Feb 2025 02:08:58 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=studer.dev; s=hmail;
	c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding;
	bh=5AA+a4IxbsmGiRmLLlpgl3OVaLWtMwq00DaT2+GNKdU=;
	b=pJHRuUoirhakSXgBVi1wAqvRu8P4O5UhqKep0hqV2Xm+WPpeDjpMf3G2SiBDyTQhaAaDOfdFtTYMEPzp399MtvTka7gVjb6ZBsbCbBJaMrgKXEXbAGHz0hAhcftTB8Xud/hBqZeqB073X/MIdu4SF8SNzXmNiQ0do5RANUV+/rJkWqsCAuskK5ao+8lcCEQFsUQS3wWnBNUzP5CGZttjyshujt4jXO4/rfTzMVM/tuGw+Sw7BGTlPw0AH2
	lHGT6PIWkXU98F36Tl8JlhswCK38SkV9nb58J1kGjYtkq8+iQ6II+Dc441In2meOCQfjINh3wYQSJ1yFwKP4iRZMbXmA==
Received: from alex-framework.mynetworksettings.com (pool-68-239-44-167.bstnma.fios.verizon.net [68.239.44.167])
	by mail.studer.dev with ESMTPSA
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
	; Tue, 18 Feb 2025 02:08:55 +0000
From: Alex Studer <alex@studer.dev>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alex Studer <alex@studer.dev>
Subject: [PATCH] riscv: dts: allwinner: d1: Add CPU thermal sensor and zone
Date: Mon, 17 Feb 2025 21:06:29 -0500
Message-ID: <20250218020629.1476126-1-alex@studer.dev>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sun20i THS (built in CPU thermal sensor) is supported in code, but
was never added to the device tree. So, add it to the device tree,
along with a thermal zone for the CPU.

Signed-off-by: Alex Studer <alex@studer.dev>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 31 +++++++++++++++++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 16 ++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 6367112e6..bdde82aa8 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -3,6 +3,8 @@
 
 #define SOC_PERIPHERAL_IRQ(nr)	(nr + 16)
 
+#include <dt-bindings/thermal/thermal.h>
+
 #include "sunxi-d1s-t113.dtsi"
 
 / {
@@ -115,4 +117,33 @@ pmu {
 			<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
 			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths>;
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
+			trips {
+				cpu_alert: cpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu-crit {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index e4175adb0..fcfcaf06c 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -426,6 +426,10 @@ sid: efuse@3006000 {
 			reg = <0x3006000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@14 {
+				reg = <0x14 0x8>;
+			};
 		};
 
 		crypto: crypto@3040000 {
@@ -934,5 +938,17 @@ rtc: rtc@7090000 {
 			clock-names = "bus", "hosc", "ahb";
 			#clock-cells = <1>;
 		};
+
+		ths: thermal-sensor@2009400 {
+			compatible = "allwinner,sun20i-d1-ths";
+			reg = <0x2009400 0x100>;
+			interrupts = <SOC_PERIPHERAL_IRQ(58) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			#thermal-sensor-cells = <0>;
+		};
 	};
 };
-- 
2.48.1



