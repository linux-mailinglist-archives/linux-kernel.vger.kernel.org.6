Return-Path: <linux-kernel+bounces-269608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264189434CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8922AB22289
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756B51BF308;
	Wed, 31 Jul 2024 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m4qbGVlX"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06B1BD504;
	Wed, 31 Jul 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445865; cv=none; b=cU1IG/LrKrDlC5K3oKoJEpGjaG+OqJ3tmhN7ffmVq9TVClp/J5hy/CL5sUtUv+YQ+o+FAHD7nJcviEfOCLrNeB4VXXUbOI3xrm+PDBg2Hx6av6vARgAMfW1dq9yKahS61lSzguz0rNmbiBEX+oHqr6m/8LpuUzNPs5qj4Mx2+7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445865; c=relaxed/simple;
	bh=Dp1xqNmWjeEfyr8ivz3G2b03eCcQ102npwLXFy/YWnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=o9U9+CkWe5YV0Vd1A07TMOgTWjjoVtPUPPKJcY4KT5KNRW1Ky6iDuCswH8/mDBAJISzz6YHx0Mmvpa6TOkMXg92ZDOTetsieBR52TGG/ypom+pWVX0QS5QUDPLwKOQex4KqYKeTB7Yg3v9+EhqvC/sT+ZL8xpeO1KxtlPlfxwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m4qbGVlX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAwKd090501;
	Wed, 31 Jul 2024 12:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722445858;
	bh=S0EVF2J3bxH4Rux65iS8ruAQxaG26bK/wUdfuAFiVo4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=m4qbGVlXXQY965jCLoT3MZ1/YvKFkavB1VbWwULyiBc1hcytgZ7IIxTiGFvPRloh8
	 vQnSpAVHkrEe3nACDgg5ToGqg1gw8xWNYrHAbEo9vsGDOl21QQqcHHgu/u2CCsHpeU
	 oaqWOCkxUjLN7LZn+PkacgA66GCYEVjBJrHehLwU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VHAwWW109094
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 12:10:58 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 12:10:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 12:10:58 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAVgT036362;
	Wed, 31 Jul 2024 12:10:54 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 31 Jul 2024 22:40:32 +0530
Subject: [PATCH v3 6/9] arm64: dts: ti: Split
 k3-j784s4-j742s2-evm-common.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240731-b4-upstream-j742s2-v3-6-da7fe3aa9e90@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722445831; l=3971;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=Dp1xqNmWjeEfyr8ivz3G2b03eCcQ102npwLXFy/YWnY=;
 b=zqkjf/ntxkB2RWXxq2+tCnvBJZBixmFo5VYVDX995HSltebQsEfm4f1xXpGcOFCVAfNigi+Dx
 iKJuhr509S6BUcoxcc9Qn8l/PHc9xOi2Ux/ilyY5qw6fmSFoyKYRGZK
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

k3-j784s4-j742s2-evm-common.dtsi will be included in k3-j742s2-evm.dts
at a later point so move j784s4 related stuff to k3-j784s4-evm.dts

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 49 ++++++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 42 -------------------
 2 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index e3730b2bca92..2543983b7fe7 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -5,4 +5,53 @@
  * EVM Board Schematics: https://www.ti.com/lit/zip/sprr458
  */
 
+/dts-v1/;
+
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-j784s4.dtsi"
 #include "k3-j784s4-j742s2-evm-common.dtsi"
+
+/ {
+	compatible = "ti,j784s4-evm", "ti,j784s4";
+	model = "Texas Instruments J784S4 EVM";
+
+	memory@80000000 {
+		device_type = "memory";
+		bootph-all;
+		/* 32G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000007 0x80000000>;
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		c71_3_dma_memory_region: c71-dma-memory@ab000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xab000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_3_memory_region: c71-memory@ab100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xab100000 0x00 0xf00000>;
+			no-map;
+		};
+	};
+};
+
+&mailbox0_cluster5 {
+	mbox_c71_3: mbox-c71-3 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&c71_3 {
+	status = "okay";
+	mboxes = <&mailbox0_cluster5 &mbox_c71_3>;
+	memory-region = <&c71_3_dma_memory_region>,
+			<&c71_3_memory_region>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index ffa38f41679d..068ceed4ea15 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -4,17 +4,7 @@
  *
  * EVM Board Schematics: https://www.ti.com/lit/zip/sprr458
  */
-
-/dts-v1/;
-
-#include <dt-bindings/net/ti-dp83867.h>
-#include <dt-bindings/gpio/gpio.h>
-#include "k3-j784s4.dtsi"
-
 / {
-	compatible = "ti,j784s4-evm", "ti,j784s4";
-	model = "Texas Instruments J784S4 EVM";
-
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
@@ -31,14 +21,6 @@ aliases {
 		ethernet1 = &main_cpsw1_port1;
 	};
 
-	memory@80000000 {
-		device_type = "memory";
-		bootph-all;
-		/* 32G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
-		      <0x00000008 0x80000000 0x00000007 0x80000000>;
-	};
-
 	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -180,18 +162,6 @@ c71_2_memory_region: c71-memory@aa100000 {
 			reg = <0x00 0xaa100000 0x00 0xf00000>;
 			no-map;
 		};
-
-		c71_3_dma_memory_region: c71-dma-memory@ab000000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xab000000 0x00 0x100000>;
-			no-map;
-		};
-
-		c71_3_memory_region: c71-memory@ab100000 {
-			compatible = "shared-dma-pool";
-			reg = <0x00 0xab100000 0x00 0xf00000>;
-			no-map;
-		};
 	};
 
 	evm_12v0: regulator-evm12v0 {
@@ -1133,11 +1103,6 @@ mbox_c71_2: mbox-c71-2 {
 		ti,mbox-rx = <0 0 0>;
 		ti,mbox-tx = <1 0 0>;
 	};
-
-	mbox_c71_3: mbox-c71-3 {
-		ti,mbox-rx = <2 0 0>;
-		ti,mbox-tx = <3 0 0>;
-	};
 };
 
 &mcu_r5fss0_core0 {
@@ -1217,13 +1182,6 @@ &c71_2 {
 			<&c71_2_memory_region>;
 };
 
-&c71_3 {
-	status = "okay";
-	mboxes = <&mailbox0_cluster5 &mbox_c71_3>;
-	memory-region = <&c71_3_dma_memory_region>,
-			<&c71_3_memory_region>;
-};
-
 &tscadc0 {
 	pinctrl-0 = <&mcu_adc0_pins_default>;
 	pinctrl-names = "default";

-- 
2.45.1


