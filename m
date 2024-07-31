Return-Path: <linux-kernel+bounces-269605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16439434C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C731F21C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FD51BE24A;
	Wed, 31 Jul 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xkHMc/kT"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF5D1BE248;
	Wed, 31 Jul 2024 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445854; cv=none; b=M2YcEX0Ni59sKDpF1e+5Z+5+NhoTt53EwSskAcr3r1gjZR8UQue1uG/Xgkfo+fIY0EVk3PoVXFwZj2BSoFZKwCuA+UAczxfx4iW9jig5HQIqN/ETtY62N8mYkCT2ZUlZfEUgVJ+3EMUMAv3u0/AJgb+eS0oCqcnKgn1u9Gq+Ybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445854; c=relaxed/simple;
	bh=tiZgpMVSYamgxzdjCpc1ORHBAdASeolJLopA9GJxS7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mOA8LFVvkuV0Dy8S6mheUiPqKO546A2QzNAkQnCM9dPjXaTEkJGtg741IIR8Z0N34BBu3er7zl3VgihQV1QgBXNEbWUy5FgyXc37G8fW7ZKX6Qe7Mua9t043PR3UYN05FM327oW5qpdKvS9KAsvP6CzDes2olweE4FwnGCsK9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xkHMc/kT; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAlKh090439;
	Wed, 31 Jul 2024 12:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722445847;
	bh=3AtFgjJhDFuISlCzXz0wAjKkkwNzREb/N8mjoS1t8SU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=xkHMc/kTiANgvQDsDUnc3Asy0j0tMl0JbDZxlWqstU5VXGvYEwodQLyBg3mPIVrSU
	 dEky7HmODjbAbtlm92ny6YXk9hVeSFpmj53kIZQqqywWrNM4+6qNGG106jCJ9ssuKP
	 5YGN/px5a3/qQRrlY/4jdHIKR7L7I4aSnHeNCB4g=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VHAl3u123646
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 12:10:47 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 12:10:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 12:10:46 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAVgQ036362;
	Wed, 31 Jul 2024 12:10:43 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 31 Jul 2024 22:40:29 +0530
Subject: [PATCH v3 3/9] arm64: dts: ti: Split k3-j784s4-j742s2-common.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240731-b4-upstream-j742s2-v3-3-da7fe3aa9e90@ti.com>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
In-Reply-To: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Manorit Chawdhry
	<m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722445831; l=8025;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=tiZgpMVSYamgxzdjCpc1ORHBAdASeolJLopA9GJxS7g=;
 b=qmaSfh25Oo0U+Y9xZrOuwl2vqpnHEq0aCMZ81ehmr0q2sG4MHm+vVlcn1emRY/2BavouiLa2a
 uTQE6rqQRzoBgq3O8vVbViBM8VJeIEVZ8BNmZh0+FC3eyLTc58bL5I2
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

k3-j784s4-j742s2-common.dtsi will be included in k3-j742s2.dtsi at a
later point so move j784s4 related stuff to k3-j784s4.dtsi

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi | 156 --------------------
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi              | 158 +++++++++++++++++++++
 2 files changed, 158 insertions(+), 156 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
index 76e43ee44496..958054ab1018 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
@@ -15,166 +15,10 @@
 #include "k3-pinctrl.h"
 
 / {
-	model = "Texas Instruments K3 J784S4 SoC";
-	compatible = "ti,j784s4";
 	interrupt-parent = <&gic500>;
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		cpu-map {
-			cluster0: cluster0 {
-				core0 {
-					cpu = <&cpu0>;
-				};
-
-				core1 {
-					cpu = <&cpu1>;
-				};
-
-				core2 {
-					cpu = <&cpu2>;
-				};
-
-				core3 {
-					cpu = <&cpu3>;
-				};
-			};
-
-			cluster1: cluster1 {
-				core0 {
-					cpu = <&cpu4>;
-				};
-
-				core1 {
-					cpu = <&cpu5>;
-				};
-
-				core2 {
-					cpu = <&cpu6>;
-				};
-
-				core3 {
-					cpu = <&cpu7>;
-				};
-			};
-		};
-
-		cpu0: cpu@0 {
-			compatible = "arm,cortex-a72";
-			reg = <0x000>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_0>;
-		};
-
-		cpu1: cpu@1 {
-			compatible = "arm,cortex-a72";
-			reg = <0x001>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_0>;
-		};
-
-		cpu2: cpu@2 {
-			compatible = "arm,cortex-a72";
-			reg = <0x002>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_0>;
-		};
-
-		cpu3: cpu@3 {
-			compatible = "arm,cortex-a72";
-			reg = <0x003>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_0>;
-		};
-
-		cpu4: cpu@100 {
-			compatible = "arm,cortex-a72";
-			reg = <0x100>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_1>;
-		};
-
-		cpu5: cpu@101 {
-			compatible = "arm,cortex-a72";
-			reg = <0x101>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_1>;
-		};
-
-		cpu6: cpu@102 {
-			compatible = "arm,cortex-a72";
-			reg = <0x102>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_1>;
-		};
-
-		cpu7: cpu@103 {
-			compatible = "arm,cortex-a72";
-			reg = <0x103>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_1>;
-		};
-	};
-
 	L2_0: l2-cache0 {
 		compatible = "cache";
 		cache-level = <2>;
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index 46cff5ed3730..16ade4fd9cbd 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -10,3 +10,161 @@
 
 #include "k3-j784s4-j742s2-common.dtsi"
 
+/ {
+	model = "Texas Instruments K3 J784S4 SoC";
+	compatible = "ti,j784s4";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
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
+
+			cluster1: cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+
+				core1 {
+					cpu = <&cpu5>;
+				};
+
+				core2 {
+					cpu = <&cpu6>;
+				};
+
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a72";
+			reg = <0x000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a72";
+			reg = <0x001>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a72";
+			reg = <0x002>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a72";
+			reg = <0x003>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu4: cpu@100 {
+			compatible = "arm,cortex-a72";
+			reg = <0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu5: cpu@101 {
+			compatible = "arm,cortex-a72";
+			reg = <0x101>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu6: cpu@102 {
+			compatible = "arm,cortex-a72";
+			reg = <0x102>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu7: cpu@103 {
+			compatible = "arm,cortex-a72";
+			reg = <0x103>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_1>;
+		};
+	};
+};

-- 
2.45.1


