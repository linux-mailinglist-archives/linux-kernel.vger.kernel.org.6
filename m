Return-Path: <linux-kernel+bounces-377892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11F89AC827
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9621F2230F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689DB1AA79A;
	Wed, 23 Oct 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MzJ9nsfQ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9A1A7AF7;
	Wed, 23 Oct 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680354; cv=none; b=TnB8L1yC0Pol3P7e8c0z3i4y5sm5Izx7hbQoCoXKyc52l65mLNX0m+Q2RRkF52hQpMPFuFvsR9a7rUgNA2jvJ2m7fVMQFnAfL/0z9diS1SHMfMT+XpDkrC5DcHKGT9KyJfx51EMVJ6yRLmqnCKuDfOxQuOIlkHAF5WOYeA4Jk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680354; c=relaxed/simple;
	bh=H0CuuWoSOyvMZpuMuKTm93lJ7LdNqAgFJ1MBdhEJoEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TG912Nm55gZuFp1qgcPEWVdDeSee4q+F8os1BPTtpShGqV0W6h9BokW2YjMDJ3w5gUmD9giWKukW4OixyqyLe9Csfjtk/CHSKInY4oNhCYfPdH62YwrdbMnyJVDh9w44wMfRW476LaMMB41chyHfQYkSK4zYNY8oUxPs6rDgIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MzJ9nsfQ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49NAjlkJ117708;
	Wed, 23 Oct 2024 05:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729680347;
	bh=6hBWX1Y33xzdpSsqxwD6CudWj4cUUDqJMHtctcCXvks=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MzJ9nsfQyWCeOWsNpkPHGUwBGtArJjkDI7Q4rJbEFCpLgnb4tP0cFjxGM4b/MeZtQ
	 BXpsePLy2rNyqNcJnNvHu7hw2wRJzo2oa1HVWiusNfOO+u7XUh6OzjHDBf9g1DOAtH
	 bpDlwO+IJXDvgn0VrJTgLOzYnij/895JRObqTAnk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NAjl3A036410;
	Wed, 23 Oct 2024 05:45:47 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 05:45:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 05:45:47 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.112])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NAjW1u014331;
	Wed, 23 Oct 2024 05:45:44 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <j-keerthy@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH 3/4] arm64: dts: ti: k3-j721s2: Fix clock IDs for MCSPI instances
Date: Wed, 23 Oct 2024 16:15:31 +0530
Message-ID: <20241023104532.3438851-4-a-dutta@ti.com>
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
in J721s2 are incorrect when compared with documentation [1]. Fix the
clock IDs to their appropriate values.

[1]https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721s2/clocks.html

Fixes: 04d7cb647b85 ("arm64: dts: ti: k3-j721s2: Add MCSPI nodes")

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi       | 16 ++++++++--------
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 9ed6949b40e9..fae534b5c8a4 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -1708,7 +1708,7 @@ main_spi0: spi@2100000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 339 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 339 1>;
+		clocks = <&k3_clks 339 2>;
 		status = "disabled";
 	};
 
@@ -1719,7 +1719,7 @@ main_spi1: spi@2110000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 340 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 340 1>;
+		clocks = <&k3_clks 340 2>;
 		status = "disabled";
 	};
 
@@ -1730,7 +1730,7 @@ main_spi2: spi@2120000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 341 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 341 1>;
+		clocks = <&k3_clks 341 2>;
 		status = "disabled";
 	};
 
@@ -1741,7 +1741,7 @@ main_spi3: spi@2130000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 342 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 342 1>;
+		clocks = <&k3_clks 342 2>;
 		status = "disabled";
 	};
 
@@ -1752,7 +1752,7 @@ main_spi4: spi@2140000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 343 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 343 1>;
+		clocks = <&k3_clks 343 2>;
 		status = "disabled";
 	};
 
@@ -1763,7 +1763,7 @@ main_spi5: spi@2150000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 344 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 344 1>;
+		clocks = <&k3_clks 344 2>;
 		status = "disabled";
 	};
 
@@ -1774,7 +1774,7 @@ main_spi6: spi@2160000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 345 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 345 1>;
+		clocks = <&k3_clks 345 2>;
 		status = "disabled";
 	};
 
@@ -1785,7 +1785,7 @@ main_spi7: spi@2170000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 346 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 346 1>;
+		clocks = <&k3_clks 346 2>;
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 9d96b19d0e7c..8232d308c23c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -425,7 +425,7 @@ mcu_spi0: spi@40300000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 347 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 347 0>;
+		clocks = <&k3_clks 347 2>;
 		status = "disabled";
 	};
 
@@ -436,7 +436,7 @@ mcu_spi1: spi@40310000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 348 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 348 0>;
+		clocks = <&k3_clks 348 2>;
 		status = "disabled";
 	};
 
@@ -447,7 +447,7 @@ mcu_spi2: spi@40320000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 349 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 349 0>;
+		clocks = <&k3_clks 349 2>;
 		status = "disabled";
 	};
 
-- 
2.34.1


