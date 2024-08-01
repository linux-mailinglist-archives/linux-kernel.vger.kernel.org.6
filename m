Return-Path: <linux-kernel+bounces-271725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F06194529B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAF91C21324
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD8E145350;
	Thu,  1 Aug 2024 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D5T1aOIx"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080613D897;
	Thu,  1 Aug 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535975; cv=none; b=EYvHivhKFcN/JVrMdRtJNorAW3V7DpMUQq4ciWcVeoo6qie5zQFwc7c5iHsDNxZMiCPjIFoL8u4JeXW0XGS/1BnAKmT3L5+bichl1VzF5+VcX69Fa+h2G7QPO4j6xuMMM55RR3+KOFkCtn7h+5Scqv/Uo3To2Ed3lS0Antgz450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535975; c=relaxed/simple;
	bh=f6fCnURo+jz5DoAmboBSAW1hm1EGiFrdTyvWo4VHU6I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p2z/NvncdMequU8+J/n/1NbWQhKQ5CtysPEtkrgfbAIZ0w3mMLokA4pUsMsxAhTHEjeiBNkDyHM6K+5wrUNZ8XI9TQdyjRNx/mmnhm14vgeciN6I3yg9f1UnK6jB8UB+r0tB0bWI4Ks9J2J+Md+IEMgv3Qg/+GhaYQi/8buPj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D5T1aOIx; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 471ICYkM064441;
	Thu, 1 Aug 2024 13:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722535954;
	bh=mqfS0Suhk9tbSrulDfjVQlJSzOxBiZt8dA1HYObsXJQ=;
	h=From:To:CC:Subject:Date;
	b=D5T1aOIxDYXqx+Pu9TYvcZ9uiQLanwpw9zCiU4qNhETnHvfFOwUFfKuRC11yuIv3E
	 jhHbEg5CeE4+/kNjNM7rI8EMm1cY957YR6nmxDZ+xX0A1G7c8EFg6Si+aUXx4UJGh2
	 O2YCjRkJiiOZouvwN5+GElgoNYdlHGNsTtgOEFLY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 471ICYCE041560
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Aug 2024 13:12:34 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Aug 2024 13:12:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Aug 2024 13:12:34 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 471ICXkF059498;
	Thu, 1 Aug 2024 13:12:33 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations
Date: Thu, 1 Aug 2024 13:12:31 -0500
Message-ID: <20240801181232.55027-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The DMA carveout for the C6x core 0 is at 0xa6000000 and core 1 is at
0xa7000000. These are reversed in DT. While both C6x can access either
region, so this is not normally a problem, but if we start restricting
the memory each core can access (such as with firewalls) the cores
accessing the regions for the wrong core will not work. Fix this here.

Fixes: f46d16cf5b43 ("arm64: dts: ti: k3-j721e-sk: Add DDR carveout memory nodes")
Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 89fbfb21e5d3b..e709edeb95cf7 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -120,7 +120,7 @@ main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
 			no-map;
 		};
 
-		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
+		c66_0_dma_memory_region: c66-dma-memory@a6000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xa6000000 0x00 0x100000>;
 			no-map;
@@ -132,7 +132,7 @@ c66_0_memory_region: c66-memory@a6100000 {
 			no-map;
 		};
 
-		c66_0_dma_memory_region: c66-dma-memory@a7000000 {
+		c66_1_dma_memory_region: c66-dma-memory@a7000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xa7000000 0x00 0x100000>;
 			no-map;
-- 
2.39.2


