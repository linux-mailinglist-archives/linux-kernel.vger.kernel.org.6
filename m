Return-Path: <linux-kernel+bounces-200284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750C8FAE16
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7485CB23BAC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35119142E9D;
	Tue,  4 Jun 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZEVicY3O"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA71428FA;
	Tue,  4 Jun 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491204; cv=none; b=AW4twM7vDKQp1oriXcIyuUqaJ/NW8jtOLV0EJYKYt5v0GTzZS6a5KlCuGBMD923JXQqhb3UlDwjTjGU+gYNmQdSHugmMzToSv9BgT1swnnit2z5iGbSwaUoBucrhhOSiGkbXlsVMAgHaBYVOnfAlmPXGaAKNPOpJOgR48w7rto4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491204; c=relaxed/simple;
	bh=NDjjiG4C1KBE7XG5eHEnnlNL/2hTHXZqB2NotJEGCmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUPdp2rsj2ac/6NyYKm7nR6vNK9JFwDHSRFeH3vp2JeF16A8xKVnb7levN0M1OUc4/be25tVNBk8BVgJG4MoVQeku1MYum2Fs+I06UBLSDdEWnNNq+aavVjBnXHn6HmL9Wgh9Gv2Zi6FufPO42l++vfpS1y+Q3nAWoYKmGLYcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZEVicY3O; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4548rF7L069305;
	Tue, 4 Jun 2024 03:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717491195;
	bh=A3xBNcQ8wLm8339Z6LOc/8zgbSMmT1b2GM+j9FvE9oU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZEVicY3Oo9P/hJok/hGUt9hnn5b/9TsIglsyKb0xhWPF2LQUtWj2q7Xck1ZHFq87j
	 xymCE6AKpRQ6RvHK21E6Ql0FOo9hFs8CC70YQAwFdeT3h4GkE1wcPovE88UzV6JzpR
	 cXjb8Dek8HrDbB4YoGE7SVZXubc2xRva+kA8DFn4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4548rFxY016073
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 03:53:15 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 03:53:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 03:53:15 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4548qqQl066926;
	Tue, 4 Jun 2024 03:53:11 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 4/7] arm64: dts: ti: k3-j722s: Switch to k3-am62p-j722s-common.dtsi
Date: Tue, 4 Jun 2024 14:22:49 +0530
Message-ID: <20240604085252.3686037-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240604085252.3686037-1-s-vadapalli@ti.com>
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update "k3-j722s.dtsi" to use "k3-am62p-j722s-common.dtsi" which
contains the nodes shared with AM62P, followed by including the J722S
specific main domain peripherals contained in "k3-j722s-main.dtsi".

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
v4:
https://lore.kernel.org/r/20240601121554.2860403-5-s-vadapalli@ti.com/
No changes since v4.

 arch/arm64/boot/dts/ti/k3-j722s.dtsi | 97 +++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index c75744edb143..9e04e6a5c0fd 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -10,12 +10,107 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/ti,sci_pm_domain.h>
 
-#include "k3-am62p5.dtsi"
+#include "k3-am62p-j722s-common.dtsi"
+#include "k3-j722s-main.dtsi"
 
 / {
 	model = "Texas Instruments K3 J722S SoC";
 	compatible = "ti,j722s";
 
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
 	cbass_main: bus@f0000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.40.1


