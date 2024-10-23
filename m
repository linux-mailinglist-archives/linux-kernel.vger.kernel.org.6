Return-Path: <linux-kernel+bounces-377891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610D69AC824
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230B6284B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FFD1A7AE3;
	Wed, 23 Oct 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NltPLOWU"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084071A7274;
	Wed, 23 Oct 2024 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680351; cv=none; b=RR38Q89lrBisJVYY37QreZ3WkCssKcTya1Hs1DobAj8KZ1+1KEtP4ngDg5myILVIs/BIi7D7KEKVoShAA1hTO+SoNE8ME4A5ybhy29vx0oyYppKQzPtW5bYfURBTzVLFM131K2LUr1kl3KG3sfSgNhbEn8SPI+k4CCyU16MWpQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680351; c=relaxed/simple;
	bh=PhzVcqIXrRtfzEfTRWHjEdYVRtM/MGRjgIiLB9CRgd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOa8SH9W5gnS0aPV60QwBz+ogBqY0UJaF5heIjucckD3aaONm0zc4IPtLe9DAZR5M6xwrhDv+plaf1FT9DWJrrvqiUMDbf+x89+I44vxG3oKcE3Efiv76PbvkXrE20wiW4yt99OsweW3GXDZAqC02c9vcWrHtd+1S1jx987J854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NltPLOWU; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49NAjhnq090780;
	Wed, 23 Oct 2024 05:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729680343;
	bh=0k7uaQxG1LTm56cE+IJh+eSfRTjl3w2u+gPAkiNBwXg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NltPLOWUJT/yjjvPaBevPYwItHapP1u9XrQa/sFfScVUnkg1zOR+hijADwfWp206h
	 R2JPlZAf8aRWF5VykRRKslQ65koAwEMOVm2a/KZFanVpO+rbSZob8mYyMQzGBzMQaZ
	 S1QDPoQ7hUBN5BAww2hpog5BDFeLcBp0PW99Zzoo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49NAjhHv082185
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 05:45:43 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 05:45:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 05:45:43 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.112])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NAjW1t014331;
	Wed, 23 Oct 2024 05:45:40 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <j-keerthy@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-j721e: Fix clock IDs for MCSPI instances
Date: Wed, 23 Oct 2024 16:15:30 +0530
Message-ID: <20241023104532.3438851-3-a-dutta@ti.com>
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
in J721e are incorrect when compared with documentation [1]. Fix
the clock ids to their appropriate values.

[1]https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721e/clocks.html

Fixes: 76aa309f9fa7 ("arm64: dts: ti: k3-j721e: Add MCSPI nodes")

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 3731ffb4a5c9..6f5c1401ebd6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -654,7 +654,7 @@ mcu_spi0: spi@40300000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 274 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 274 0>;
+		clocks = <&k3_clks 274 1>;
 		status = "disabled";
 	};
 
@@ -665,7 +665,7 @@ mcu_spi1: spi@40310000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 275 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 275 0>;
+		clocks = <&k3_clks 275 1>;
 		status = "disabled";
 	};
 
@@ -676,7 +676,7 @@ mcu_spi2: spi@40320000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 276 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 276 0>;
+		clocks = <&k3_clks 276 1>;
 		status = "disabled";
 	};
 
-- 
2.34.1


