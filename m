Return-Path: <linux-kernel+bounces-285604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF6F951039
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892E9285AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3971AD9E1;
	Tue, 13 Aug 2024 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rDJ2QjjJ"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF11AC452;
	Tue, 13 Aug 2024 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590211; cv=none; b=g1yZfar/wJ7JFWAi+4LNTxiPj84r60po80A1+W/h3nJgBWaVaj+4Zx5LQpFvB/+l302HDaOEUbqxENSx9VxOHXkFipDdkAoZBBAbx1GLqLL1XxjOXsoxH4mjeNSagufuyYOM0aIcu8lUJns76N96fqQnaHwFnpU8oehf8mHRTwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590211; c=relaxed/simple;
	bh=CT3H5p8o3j+6UENMBxUdmJtEdOKk1cCSzZAzTTQD/Sw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRfaGnS3Ds8GqBKoGKsrOl5GIxWOvuGcfFiOzDzAx5J77+3Rb6a/wvOcD+d8c67qBsjiqvFFoZqv+fbxbU5OMAbRTO2gf0KnpEbnAvwVyI1FwRGVcbbxMCFTlqt2aWApI/IBH1Eybfo72z87vTTwMUYkFR5gPcCbN2cl4/0E+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rDJ2QjjJ; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3NuX014081;
	Tue, 13 Aug 2024 18:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723590203;
	bh=mlgavM4VLcXnEeYWwNPzCmvF+eUbd1j6VMtMjnxMa3E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rDJ2QjjJbUWsMnzpJgis8uz17sFFHOd9qshjQDQ5SNbxpwoikCfLyf4VJGxaMHoK5
	 5m57pbDMFJTSgxdirtqiO1x8mUv2bD+u4+ChGL+fCTeDZofuBj52d3XPdbGh3JlYFb
	 7Bi1gYICkrrjzuwjKU9pwa+qvMxTtEF2eBtnOKqg=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DN3NBi033316
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 18:03:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 18:03:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 18:03:23 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DN3Khp026425;
	Tue, 13 Aug 2024 18:03:23 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        Judith
 Mendez <jm@ti.com>
Subject: [PATCH v2 4/6] arm64: dts: ti: k3-am62: Add comments to ESM nodes
Date: Tue, 13 Aug 2024 18:03:10 -0500
Message-ID: <20240813230312.3289428-5-jm@ti.com>
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

Add comments to describe what interrupt sources are routed to
ESM modules.

There is no functional change.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Add comment to ESM nodes
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 328929c740dc0..5b92aef5b284b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -241,6 +241,7 @@ main_esm: esm@420000 {
 		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x420000 0x00 0x1000>;
+		/* Interrupt sources: rti0, rti1, rti15, wrti0, rti2, rti3 */
 		ti,esm-pins = <160>, <161>, <162>, <163>, <177>, <178>;
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index e66d486ef1f21..bb43a411f59b2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -19,6 +19,7 @@ mcu_esm: esm@4100000 {
 		bootph-pre-ram;
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x4100000 0x00 0x1000>;
+		/* Interrupt sources: esm0_cfg, esm0_hi, esm0_low, mrti0 */
 		ti,esm-pins = <0>, <1>, <2>, <85>;
 	};
 
-- 
2.46.0


