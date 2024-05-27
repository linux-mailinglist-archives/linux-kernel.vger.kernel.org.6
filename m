Return-Path: <linux-kernel+bounces-190602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71288D0057
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F360FB227C1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD1115ECE3;
	Mon, 27 May 2024 12:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yDZ86ZBF"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C258E15E5CF;
	Mon, 27 May 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813885; cv=none; b=Vrt6pPFSwFN4YmiV9N+8gDebkZRD78ZoCDMqYqn/6qiD9iZUZMRGUHyLyTKT7WRl36Rve7Qwz6m1T5582FDsSruOp8qLHg8fvuRGMiJjGPTIG89MMweKMksA0HieA0b6us1AtTEZkLaR/bg6Tt2eDa7R/3sepWIoeFaZf0G+oNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813885; c=relaxed/simple;
	bh=4avZwmCNFpb1GvTuWy/978kWYonR8Ou2jA690fpax0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeaafJnuiTgYhTWJS1dg/x9b2mRmLOWFRLscOsizzTcNQOV4jXljUVFH6IS07jQPoDPOTPyC32jzGy4gA4dycoX+4CB1fX9aSAncF53gXfYaTWuLphzNGK/WGL6NXBHMKRuGG1bjJZag57AwXzeVUBGFKBjcG7wIOKxgHvHHZdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yDZ86ZBF; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44RCiaFx033831;
	Mon, 27 May 2024 07:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716813876;
	bh=FHkHayuM2HghvcLigZpWtBs99mtB53gmcT5KDEX3UoQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yDZ86ZBFGAAavHsylL0/3hU+WutjyLZIDgfDUEKipljYrm0UZbFGm6hEc68DAkDaQ
	 3hogMkTTEN5ZXxCz4JV1S2eg9UjzR/X4sbmS/mGfm+96yPx+PhrtlzxQGC4dloic9f
	 7GtzdaarXr6i+ycGUz78RaVB46KPRTLL9V6mkzlc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44RCiZZR124626
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 07:44:35 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 07:44:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 07:44:35 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44RCiMbV035499;
	Mon, 27 May 2024 07:44:31 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2 2/3] arm64: boot: dts: ti: k3-am69-sk: Add TPS62873 node
Date: Mon, 27 May 2024 18:14:21 +0530
Message-ID: <20240527124422.3553828-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527124422.3553828-1-n-francis@ti.com>
References: <20240527124422.3553828-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add DTS node for two TPS6287x high current buck convertors.

The two TPS6287x supply power to the MAIN domain for AVS and other core
supplies.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index d88651c297a2..d5132b2029af 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -814,6 +814,27 @@ ldoa4: ldo4 {
 			};
 		};
 	};
+
+	tps62873a: tps62873@40 {
+		compatible = "ti,tps62873";
+		bootph-pre-ram;
+		reg = <0x40>;
+		regulator-name = "VDD_CPU_AVS";
+		regulator-min-microvolt = <600000>;
+		regulator-max-microvolt = <900000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	tps62873b: tps62873@43 {
+		compatible = "ti,tps62873";
+		reg = <0x43>;
+		regulator-name = "VDD_CORE_0V8";
+		regulator-min-microvolt = <760000>;
+		regulator-max-microvolt = <840000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &wkup_gpio0 {
-- 
2.34.1


