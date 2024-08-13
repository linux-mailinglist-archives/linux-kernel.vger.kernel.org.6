Return-Path: <linux-kernel+bounces-285605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B6395103C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EF11C22FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB731AE022;
	Tue, 13 Aug 2024 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MlEqDJVg"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCD1AD3EE;
	Tue, 13 Aug 2024 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590211; cv=none; b=ErDyqhfWnxqZquU7jNrrBVyJsInvOit/H5ykwQuIjHlJqOYsMjVUFwUk4UvMFL1pcezEuzTaXQSmwVgjXzDVPNI2k5nXVUboPIzBiDNI52Mj1bAjm86X87mTARKihs4DgUvn37O3n6Us1C54KNZxkxuknuZc1VSTXGp5FGb0YT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590211; c=relaxed/simple;
	bh=apEqxCQKvZC4aqxsMLNsr6VNH3d6tZNmlJxc+Vku1sY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naD9Gnv+de0a1ery3H3bqnyIVghQlnAWmPWu2geATcnw3e8pELzgFGVCmLZpWH/wshegnx8MDNMQquIIAq6zbtJxgXFsXabb3DnghFhT5lSKVhY6uFvZ8HDdRfPrpIeEeVcoCCNB5VQgvTjVX0gQYjKInfIc25Riep2ivVH+tcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MlEqDJVg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3OWY099221;
	Tue, 13 Aug 2024 18:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723590204;
	bh=GcoDBRexeuAj9XJg0j8+TCqGBEHZzKySy+cBwT1zYBo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MlEqDJVg+VKf3YLD1gewv3tQPkD5XNqGQ6dmxqpUqZNLnY11DB8IsEynLuv3I4VRG
	 xhaFrNP8clVLOe8dWaTSkN5VzFbLZLkzRb1rfBVVcoBifD78QXhpnLdvLE32ZSaXaG
	 rMx6qBHSfwVaD3qh15ovNopm6JjBA8jQITx7XW4s=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DN3Osa050282
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 18:03:24 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 18:03:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 18:03:23 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3Khq026425;
	Tue, 13 Aug 2024 18:03:23 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        Judith
 Mendez <jm@ti.com>
Subject: [PATCH v2 5/6] arm64: dts: ti: k3-am64: Add more ESM interrupt sources
Date: Tue, 13 Aug 2024 18:03:11 -0500
Message-ID: <20240813230312.3289428-6-jm@ti.com>
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

Add ESM interrupt sources for rti as per TRM [0] in 9.4
Interrupt Sources.

[0] https://www.ti.com/lit/ug/spruim2h/spruim2h.pdf

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Add patch 5/6 for am64x
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 3 ++-
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index f8370dd033502..652653bb24f26 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -389,7 +389,8 @@ main_esm: esm@420000 {
 		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
-		ti,esm-pins = <160>, <161>;
+		/* Interrupt sources: rti0, rti1, rti8, rti9, rti10, rti11 */
+		ti,esm-pins = <160>, <161>, <162>, <163>, <164>, <165>;
 	};
 
 	main_uart0: serial@2800000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index ec17285869da6..ad4bed5d3f9eb 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -158,6 +158,7 @@ mcu_esm: esm@4100000 {
 		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x4100000 0x00 0x1000>;
-		ti,esm-pins = <0>, <1>;
+		/* Interrupt sources: esm0_cfg, esm0_hi, esm0_low, mrti0 */
+		ti,esm-pins = <0>, <1>, <2>, <85>;
 	};
 };
-- 
2.46.0


