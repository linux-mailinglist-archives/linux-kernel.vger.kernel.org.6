Return-Path: <linux-kernel+bounces-377890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BCD9AC822
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5501FB226C0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8203A19CC20;
	Wed, 23 Oct 2024 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pSnSvYJ4"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7F1A2C32;
	Wed, 23 Oct 2024 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680348; cv=none; b=e75CDGkOibcrSAd4ZAGQTS48JbH8AStJADZQ/Xdt4StbpRSbjKQOX3dOpMyR9AwpxNeJ0DMX68KSTCFph3zo2TV1reFNuGckImGaRn7lGV+wMsHdvItteT+BpG7WFQv20ZVRpDLZQo6qpLct3h6Hkz/I3mdzj4mq8rfBis086nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680348; c=relaxed/simple;
	bh=cJVOt74sNb01DhUopwpGUA033B9IocyLF3+OC8ejuaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLkdkIee3pC1TqUkirfjm2qMBKAzM+Pr4maKc//zaIe54MEb9vG4MepcRhhCo89/TN3q2NWlAHJ439wi2UB9eob3OeR0v93lG0Rw06/SE+0MxDmRbu4jnBCu9hJfskDX0LeijUeqW7bMoojJ5gjUTeupe7sBylSEFQHCi6j/D9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pSnSvYJ4; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49NAjeBB102038;
	Wed, 23 Oct 2024 05:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729680340;
	bh=g8XkaaTwVn1pEtca7T5QpBmMyz/VvqvE0668l+CnlLk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pSnSvYJ47q+HYXyrV+fazk6L51oO6WbCtDKNeLq5UKKA/2ZrV8UeJG58qKCxVBpxP
	 gCtf+6VTSqMIJA7eIEc43maX+o3VcA8mPO4i3Wb6/RQXx/TxUfyg2SM55a0UgKVHMK
	 MO8KSbHNTranwBCCm4lMo5BLUB91lr4g32TaxjUc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49NAje0a031226
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 05:45:40 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 05:45:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 05:45:39 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.112])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NAjW1s014331;
	Wed, 23 Oct 2024 05:45:37 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <j-keerthy@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-j7200: Fix clock ids for MCSPI instances
Date: Wed, 23 Oct 2024 16:15:29 +0530
Message-ID: <20241023104532.3438851-2-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023104532.3438851-1-a-dutta@ti.com>
References: <20241023104532.3438851-1-a-dutta@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The clock IDs for multiple MCSPI instances across wakeup as
well as main domain in J7200 are incorrect when compared with
documentation [1]. This results in kernel crashes when the said
instances are enabled. Fix the clock ids to their appropriate
values.

[1]https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html

Fixes: 8f6c475f4ca7 ("arm64: dts: ti: k3-j7200: Add MCSPI nodes")

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       | 16 ++++++++--------
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 9386bf3ef9f6..ee953c0bf11f 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -1145,7 +1145,7 @@ main_spi0: spi@2100000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 266 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 266 1>;
+		clocks = <&k3_clks 266 4>;
 		status = "disabled";
 	};
 
@@ -1156,7 +1156,7 @@ main_spi1: spi@2110000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 267 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 267 1>;
+		clocks = <&k3_clks 267 4>;
 		status = "disabled";
 	};
 
@@ -1167,7 +1167,7 @@ main_spi2: spi@2120000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 268 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 268 1>;
+		clocks = <&k3_clks 268 4>;
 		status = "disabled";
 	};
 
@@ -1178,7 +1178,7 @@ main_spi3: spi@2130000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 269 1>;
+		clocks = <&k3_clks 269 4>;
 		status = "disabled";
 	};
 
@@ -1189,7 +1189,7 @@ main_spi4: spi@2140000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 270 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 270 1>;
+		clocks = <&k3_clks 270 2>;
 		status = "disabled";
 	};
 
@@ -1200,7 +1200,7 @@ main_spi5: spi@2150000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 271 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 271 1>;
+		clocks = <&k3_clks 271 4>;
 		status = "disabled";
 	};
 
@@ -1211,7 +1211,7 @@ main_spi6: spi@2160000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 272 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 272 1>;
+		clocks = <&k3_clks 272 4>;
 		status = "disabled";
 	};
 
@@ -1222,7 +1222,7 @@ main_spi7: spi@2170000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 273 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 273 1>;
+		clocks = <&k3_clks 273 4>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 5097d192c2b2..b18b2f2deb96 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -494,7 +494,7 @@ mcu_spi0: spi@40300000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 274 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 274 0>;
+		clocks = <&k3_clks 274 4>;
 		status = "disabled";
 	};
 
@@ -505,7 +505,7 @@ mcu_spi1: spi@40310000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 275 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 275 0>;
+		clocks = <&k3_clks 275 4>;
 		status = "disabled";
 	};
 
@@ -516,7 +516,7 @@ mcu_spi2: spi@40320000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 276 0>;
+		clocks = <&k3_clks 276 2>;
 		status = "disabled";
 	};
 
-- 
2.34.1


