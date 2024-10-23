Return-Path: <linux-kernel+bounces-377894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61469AC82E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5E11C22A72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721CC1AAE1C;
	Wed, 23 Oct 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UDBVanBx"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1881AAE2E;
	Wed, 23 Oct 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680358; cv=none; b=aS0qjcUc3dq+G3vJRz7WXE6/j5G9o5ZcLI7NVQTLfPiLm09ru8WdLEH+saGPpJTQ8GLwqsnZQEO4oREHenlPTpPhYz2UJXJmezEh0MkBpG2VXYVgrDBft61AH6lc71f5xiy0jxbbF0F8Imy000l+sb8tAWi9Uu2lC/TGs8CyPxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680358; c=relaxed/simple;
	bh=s2f0NV8Yo+cqVMU0ikMZd2+fXpLvLnRxg4ZQgsJF49U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkAxAVg0hsc89x0QREOpKbtVvWov+XuDssyIsZtGST5mQAH5gR9+0W5Y9fd9CnPvMWoJausBnqshYQ+eQ3HdfGKn+6xAXALBLhSAQB/b3oPsRs9FIyumXmX2yPgK+c5IBZWsin/HT/5qqSbROXfzqij4X1L7JNl/ojC3T27NR1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UDBVanBx; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49NAjpvk090794;
	Wed, 23 Oct 2024 05:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729680351;
	bh=csUKGiVK2HsvgfvRBbrDSKbQ6Dfvy+AyewZWb+pdrcs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UDBVanBxW++zMmwZNOnRg09m/rZIJwhtCyoMLvn3F6+ElxBxwydizd40eEFLH2kIT
	 RAUofV2KvLZ3Uc0gNyZNAYl4aKompXItPpagnAmi1j0ywNxm1psBEGpjDkEjN9Nl6N
	 MXCpj4WlH+u1bNdz86PpSidE59zGvNYN70Y1peYc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49NAjpNw031274
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 05:45:51 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 05:45:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 05:45:50 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.112])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NAjW1v014331;
	Wed, 23 Oct 2024 05:45:47 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <j-keerthy@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-j784s4: Fix clock IDs for MCSPI instances
Date: Wed, 23 Oct 2024 16:15:32 +0530
Message-ID: <20241023104532.3438851-5-a-dutta@ti.com>
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

The clock IDs for multiple MCSPI instances across wakeup domain
in J784s4 are incorrect when compared with documentation [1]. Fix
the clock IDs to their appropriate values.

[1]https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j784s4/clocks.html

Fixes: e23d5a3d116d ("arm64: dts: ti: k3-j784s4: Add MCSPI nodes")

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index e73bb750b09a..5c5398990514 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -2141,7 +2141,7 @@ main_spi0: spi@2100000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 376 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 376 1>;
+		clocks = <&k3_clks 376 0>;
 		status = "disabled";
 	};
 
@@ -2152,7 +2152,7 @@ main_spi1: spi@2110000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 377 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 377 1>;
+		clocks = <&k3_clks 377 0>;
 		status = "disabled";
 	};
 
@@ -2163,7 +2163,7 @@ main_spi2: spi@2120000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 378 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 378 1>;
+		clocks = <&k3_clks 378 0>;
 		status = "disabled";
 	};
 
@@ -2174,7 +2174,7 @@ main_spi3: spi@2130000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 379 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 379 1>;
+		clocks = <&k3_clks 379 0>;
 		status = "disabled";
 	};
 
@@ -2185,7 +2185,7 @@ main_spi4: spi@2140000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 380 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 380 1>;
+		clocks = <&k3_clks 380 0>;
 		status = "disabled";
 	};
 
@@ -2196,7 +2196,7 @@ main_spi5: spi@2150000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 381 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 381 1>;
+		clocks = <&k3_clks 381 0>;
 		status = "disabled";
 	};
 
@@ -2207,7 +2207,7 @@ main_spi6: spi@2160000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 382 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 382 1>;
+		clocks = <&k3_clks 382 0>;
 		status = "disabled";
 	};
 
@@ -2218,7 +2218,7 @@ main_spi7: spi@2170000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 383 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 383 1>;
+		clocks = <&k3_clks 383 0>;
 		status = "disabled";
 	};
 
-- 
2.34.1


