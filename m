Return-Path: <linux-kernel+bounces-276961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC1C949A76
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25FA1C21C3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE6F16F84A;
	Tue,  6 Aug 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SjUWyoV/"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0322149001;
	Tue,  6 Aug 2024 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980773; cv=none; b=gHBX6B4ZMD93KaJOnag9Q+R0MmRGI/Y3o3ADb0rElVK9ogCpJpYI5qrsw4YTMNVp0Zzch6eaxw36AZQhK/PQWRnf+LpaOXyIUvM3tdK1WBjZ2S7UDEY9xt/ns6tOnX66LCR+8FNg1u894IOB3gpIHgGsd3vw+Hk6A74yq5pDyp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980773; c=relaxed/simple;
	bh=t4i7MXY5QDLAjIrTJys6RTV10YsyEtn/Pc3aUXAaFpw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5zMKbv/A7czyqG+OG3mH/7XyzS2SIagF63P3KVpuvz08N8imcXZsOz3DE5VcRWqhiRGqnLi2lhjpJmAMoF4Kn9TMgsviJv5RwgdMg5iuHdQorgtSDlegKfHtlxFPp/0z/7/CGhu1vxsJ4crxN13LCPiWIdh+Lxz07Mh+b+yfEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SjUWyoV/; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476Lk5Fa124335;
	Tue, 6 Aug 2024 16:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722980765;
	bh=Mbld4HzfBXJijKtqXLRXMeuDexa5YZLFdO8Vy+UG7Tg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SjUWyoV//MLVBCq2FJ5HGcK4C5Kl6b4wx62pxiy+rHfTgCNRqEKVXCYz9Tvv40AFH
	 A5VIzQOVAZNapKzajJiKMgn5nuIgRJ2Egx0yaW/UVEHctN5x9DVNHV+KYUJ8/yXZ/W
	 bixNx5s6o5lLJHos80rYXFuLB0QUkSvQymVXes5s=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476Lk5NW127333
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 16:46:05 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 16:46:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 16:46:05 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476Lk5Qs100327;
	Tue, 6 Aug 2024 16:46:05 -0500
From: Judith Mendez <jm@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Santhosh Kumar <s-k6@ti.com>,
        Bryan Brattlof
	<bb@ti.com>
Subject: [PATCH 3/5] arm64: dts: ti: k3-am62p: Remove 'reserved' status
Date: Tue, 6 Aug 2024 16:46:02 -0500
Message-ID: <20240806214605.3379881-4-jm@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806214605.3379881-1-jm@ti.com>
References: <20240806214605.3379881-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Santhosh Kumar K <s-k6@ti.com>

Remove 'reserved' status for MCU ESM node in AM62P device tree.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index e65db6ce02bf6..d913e6319bad8 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -27,7 +27,6 @@ mcu_esm: esm@4100000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x4100000 0x00 0x1000>;
 		ti,esm-pins = <0>, <1>, <2>, <85>;
-		status = "reserved";
 		bootph-pre-ram;
 	};
 
-- 
2.45.2


