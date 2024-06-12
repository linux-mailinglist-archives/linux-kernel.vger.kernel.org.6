Return-Path: <linux-kernel+bounces-211558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E79E99053B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4011F246AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207E517DE37;
	Wed, 12 Jun 2024 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PCEVruWU"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA317DE23;
	Wed, 12 Jun 2024 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198680; cv=none; b=r7DkRRyQzIKLybfZ40zjzUQkUKDQU0sOPihu7HBgAihAIL4zrGk+jEUP15YbI3wCFrkvMrT/KiLnYgBRSJbC+ku7ZQ0H86lFzNJ8InaHYtsKpmhb8UtQRdnmng6ukLcy6UVaEYp5FzVvrr1lymmE4QquS+IPO4cmHXHQuKb45d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198680; c=relaxed/simple;
	bh=9Ye9eGBdIMwatn6BGWxVne4Gtpt/opGuLBfj9uAUcrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFLvgTYpAOXcpsKLUVx376s6u2QLyaQZnWx7k4HfOh6i79/3j0LuvwGsM3+sQmP28skGOVYzhenvKti1G0bNajPKR1c/64u1yqj3ojE3m3pRwM5gcHzmx7q2savLXzrDQKQiv17l/smcSk6RvFJmYXNEPVNap1XlL0iXp0a/Y4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PCEVruWU; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOXfB115286;
	Wed, 12 Jun 2024 08:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718198673;
	bh=fLaRYpszCyI+VJCixfWCXgonJjYfNx/QeL5FWpsKpEw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PCEVruWUDvPA6pzAIJUkJ70HqzHsuO7eD3qYp4vTHJf+h07PBJlKVpCCvFEwqjUAQ
	 E2itxdfeoJL8FIngqV+q7PbSM4qAwa+msguPkch3nGZXtyO+Pm6mPMoCcUFq+9PhON
	 7ZtWlP5oHSx3o7/nkCZpuILPB8C4VSgEE1RF1p2k=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDOXBj004775
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:24:33 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:24:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:24:32 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOAmu046478;
	Wed, 12 Jun 2024 08:24:28 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v6 4/8] arm64: dts: ti: k3-j722s: Switch to k3-am62p-j722s-common-{}.dtsi includes
Date: Wed, 12 Jun 2024 18:54:05 +0530
Message-ID: <20240612132409.2477888-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240612132409.2477888-1-s-vadapalli@ti.com>
References: <20240612132409.2477888-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update "k3-j722s.dtsi" to include "k3-am62p-j722s-common-{}".dtsi files in
order to reuse the nodes shared with AM62P. Also include the J722S specific
"k3-j722s-main.dtsi".

Since the J7 family of SoCs has the k3-{soc}.dtsi file organized as:
k3-{soc}.dtsi = CPU + Cache + CBASS-Ranges + "Peripheral-Includes"
switch the "k3-j722s.dtsi" file to the same convention.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
v5:
https://lore.kernel.org/r/20240604085252.3686037-5-s-vadapalli@ti.com/
Changes since v5:
- Rather than including "k3-am62p-j722s-common.dtsi" which is the
  equivalent of "k3-am62p.dtsi" in the current series, k3-j722s.dtsi
  includes "k3-am62p-j722s-common-{}.dtsi" and "k3-j722s-main.dtsi".
  Also, to match the J7 family of SoCs, the CPU, Cache and CBASS-Ranges
  are included in "k3-j722s.dtsi".

 arch/arm64/boot/dts/ti/k3-j722s.dtsi | 158 ++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index c75744edb143..1bcbc9152ff0 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -10,11 +10,133 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
-#include "k3-am62p5.dtsi"
+#include "k3-pinctrl.h"
 
 / {
 	model = "Texas Instruments K3 J722S SoC";
 	compatible = "ti,j722s";
+	interrupt-parent = <&gic500>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0: cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			reg = <0x000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			clocks = <&k3_clks 135 0>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			reg = <0x001>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			clocks = <&k3_clks 136 0>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a53";
+			reg = <0x002>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			clocks = <&k3_clks 137 0>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a53";
+			reg = <0x003>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			clocks = <&k3_clks 138 0>;
+		};
+	};
+
+	l2_0: l2-cache0 {
+		compatible = "cache";
+		cache-unified;
+		cache-level = <2>;
+		cache-size = <0x80000>;
+		cache-line-size = <64>;
+		cache-sets = <512>;
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	a53_timer0: timer-cl0-cpu0 {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
+	};
+
+	pmu: pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
 
 	cbass_main: bus@f0000 {
 		compatible = "simple-bus";
@@ -74,9 +196,43 @@ cbass_main: bus@f0000 {
 			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>,
 			 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>,
 			 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>;
+
+		cbass_mcu: bus@4000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>, /* Peripheral window */
+				 <0x00 0x79000000 0x00 0x79000000 0x00 0x00008000>, /* MCU R5 ATCM */
+				 <0x00 0x79020000 0x00 0x79020000 0x00 0x00008000>, /* MCU R5 BTCM */
+				 <0x00 0x79100000 0x00 0x79100000 0x00 0x00040000>, /* MCU IRAM0 */
+				 <0x00 0x79140000 0x00 0x79140000 0x00 0x00040000>; /* MCU IRAM1 */
+			bootph-all;
+		};
+
+		cbass_wakeup: bus@b00000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
+				 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
+				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>, /* WKUP CTRL MMR */
+				 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>, /* DM R5 ATCM*/
+				 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>; /* DM R5 BTCM*/
+			bootph-all;
+		};
 	};
+
+	#include "k3-am62p-j722s-common-thermal.dtsi"
 };
 
+/* Include peripherals shared with AM62P */
+#include "k3-am62p-j722s-common-main.dtsi"
+#include "k3-am62p-j722s-common-mcu.dtsi"
+#include "k3-am62p-j722s-common-wakeup.dtsi"
+
+/* Include J722S specific peripherals */
+#include "k3-j722s-main.dtsi"
+
 /* Main domain overrides */
 
 &inta_main_dmss {
-- 
2.40.1


