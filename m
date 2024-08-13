Return-Path: <linux-kernel+bounces-285603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2106951036
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04C91C22CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B2F1AD415;
	Tue, 13 Aug 2024 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h7CRviJa"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C751AC438;
	Tue, 13 Aug 2024 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590210; cv=none; b=c6sQYYnyisc13yrK9euUHmAr2ej/Pek0M6kz4WMCGctz+R8XrwcxWHrNXUAX0rlFAxlcLvWY0qAMiB6YIz/8/7mcUFrIAi7ZWULvYwVj0XDKN/UMYnsk9tv99UoZpthuwjaeCPeoaIQ9lh75UXRIfuAksHBcSFvJVS+yGbXaE7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590210; c=relaxed/simple;
	bh=jFgRU4QLs3xhkkmaXBhRpSZc7851Cih4nn9TUODBu+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgYVmkakaxpxhpR+QAMcvWnTh7i4pqh9mmkmCVe6l1doRrVCdtU6cV3Y17ekUYwRXHZDLhDwt7FIf+ByKT3G0FYVFA4zrj3wdOzOKHHi2S5IABk5TZomlnOm5KA3lPAvJ7OquC12lvOdEgRJ3fkzI9e6w1IyUWG8lN+dLqw2PRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h7CRviJa; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3Mf0034179;
	Tue, 13 Aug 2024 18:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723590202;
	bh=JfbzJd3CTvNYSfJ+E107WsKEBy9UnpH5DGqvNLDwKOY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=h7CRviJa2aXQsmtE3xtzqxv9qz161SDUxsUA3LquWDcfzEBEOVDBMo3UdoBtd/xE+
	 nDyh9ZQUGpAGpC2x7cLIsOXn6XCqZ92YNb5eyQRAt53Gc8mnZlewvCmCSk8BW8K7sT
	 M6G+GkLRYItmvqT8rtuijwe28b4D3RNpy2w4KlTU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DN3MMQ025574
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 18:03:22 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 18:03:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 18:03:22 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3Khn026425;
	Tue, 13 Aug 2024 18:03:21 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        Judith
 Mendez <jm@ti.com>
Subject: [PATCH v2 2/6] arm64: dts: ti: k3-am62p: Fix ESM interrupt sources
Date: Tue, 13 Aug 2024 18:03:08 -0500
Message-ID: <20240813230312.3289428-3-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813230312.3289428-1-jm@ti.com>
References: <20240813230312.3289428-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fix interrupt sources for rti routed to the ESM0 as per [0], in
10.4 Interrupt Sources

Add comments to describe what interrupt sources are routed to
ESM modules.

[0] https://www.ti.com/lit/ug/spruj83/spruj83.pdf

Fixes: b5080c7c1f7e ("arm64: dts: ti: k3-am62p: Add nodes for more IPs")
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Add comment to ESM nodes
- Add more interrupt sources to ESM nodes
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 ++-
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi  | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 9701fc69aed94..7941aab09cf72 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -260,7 +260,8 @@ main_pmx0: pinctrl@f4000 {
 	main_esm: esm@420000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
-		ti,esm-pins = <160>, <161>, <162>, <163>, <177>, <178>;
+		/* Interrupt sources: rti0, rti1, wrti0 rti2, rti3, rti15 */
+		ti,esm-pins = <224>, <225>, <227>, <241>, <242>, <248>;
 		bootph-pre-ram;
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index df7945156397b..49dda340752aa 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -26,9 +26,10 @@ mcu_pmx_range: gpio-range {
 	mcu_esm: esm@4100000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x4100000 0x00 0x1000>;
-		ti,esm-pins = <0>, <1>, <2>, <85>;
-		status = "reserved";
+		/* Interrupt sources: esm0_cfg, esm0_hi, esm0_low, mrti0, wrti0 */
+		ti,esm-pins = <0>, <1>, <2>, <85>, <86>;
 		bootph-pre-ram;
+		status = "reserved";
 	};
 
 	/*
-- 
2.46.0


