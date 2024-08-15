Return-Path: <linux-kernel+bounces-288595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BD6953C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049D12877CD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD460159568;
	Thu, 15 Aug 2024 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XjOUe1i1"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9D158D8D;
	Thu, 15 Aug 2024 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754937; cv=none; b=F5PKOmVagMXjl/9ghHOAE6dXxGvaNCl8SjBJeanvSDcgUJ/QPpAnlhxdWJnWjli0+Q81MbhZA/gKEElOjYlPCUbyIYPlaELb0WdKJl2ANLD7XuGsJ18oj7T4A0FF/etIgg/9dezeYAgeBi0Yix/G7i+REQJVH8XQirJDMCv7AM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754937; c=relaxed/simple;
	bh=zOBYgcs2EVfcecneLisIk22+4KskCx2srflsyjtoMnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDb9jy89XqFzTvIeD8HKHZttj+iJLIdnuw3FS2OafQ9ROiVaGep7jXuVECaVqYGIOH3jY25pDXcPq7qZxzZ6+wzTSkfx9HiTbhbvm8leBqUok76GWeKxWK6Yx4d1vEBMrLL8W2aEHfI5ZMSx0atVvQ/U3KMuxmY3wE91ADYxvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XjOUe1i1; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmbKA122614;
	Thu, 15 Aug 2024 15:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723754917;
	bh=uINUYXIuZ/Fint00oG+vQ2OvoBRG3vBZRTLyRqn2Hak=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XjOUe1i16S0CIJNfPoL2frimmOxJ424HbHXFv9ABGT/ePa8rBYjSsWQtfOElYkKuk
	 zVc2vZ8EooS2Yhl4kQEay46CVvCyQAszpf/Yh4+9sKoEN1KYHQwjwDzDst4aGDbLI9
	 bck0/IlkPDqBoF0FdevqfY6BC/H13qP2NIz6T5Bw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FKmb3Y005545
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 15:48:37 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 15:48:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 15:48:36 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmYNu052918;
	Thu, 15 Aug 2024 15:48:36 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>, Judith Mendez <jm@ti.com>
Subject: [PATCH v3 2/6] arm64: dts: ti: k3-am62p: Fix ESM interrupt sources
Date: Thu, 15 Aug 2024 15:48:29 -0500
Message-ID: <20240815204833.452132-3-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815204833.452132-1-jm@ti.com>
References: <20240815204833.452132-1-jm@ti.com>
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
Changes since v2:
- No change
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


