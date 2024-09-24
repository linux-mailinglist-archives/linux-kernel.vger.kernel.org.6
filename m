Return-Path: <linux-kernel+bounces-337574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF3A984BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6520A28281F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7700A136E01;
	Tue, 24 Sep 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fk8I8i10"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F76F13A87E;
	Tue, 24 Sep 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207633; cv=none; b=bGzQptVvXcL9OynZF5XsPHr4rOnovdG54prBGdJuQFiYuqFQw5vpVCJyu7HXPRQE1us7IzddhaUt6KFwj1m8mtJIOA1tpKpnr7cioORfCsuJRrnNn/lHT5XHrQH5RD+byRSvuKBxvVeOD6wF7/j/95JlIAMuRoOaji+lBT0UswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207633; c=relaxed/simple;
	bh=mygylFGi/DtqlGjrqKKkn20L+mhK6WeSEg7rQqA2Q1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AZF+Bsjxq4Sw2FDeq4XOZP8661i0ELMzvpBWW3uixANnB1CGwG6aCqWtHG/TSJBDmrqytV/L6lme2dDwlCpZiwQ92Cir0sv/cTuuch/1XKKz+Q4uGpZJ+QroNKhtyx0UhP/U3pnMHoGV7zUEjtAwq64S8k6DGQ7sjBcF8Hwh+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fk8I8i10; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48OJrbC8047406;
	Tue, 24 Sep 2024 14:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727207617;
	bh=qXUAI3F9t3IZz019e/8Pys9ir1GUXu1Sn/W+81GgYVE=;
	h=From:To:CC:Subject:Date;
	b=Fk8I8i10Ai0dzHa6qmPYVOSNfkG3z4LW07su5yfHkl020fxRe/WWlWw+g+uLcTN7p
	 eWy2y5PO6XVtozQtNtlsnxxffHrbzB3mUhMO7s2BXj5trP4XGIpEQTJRqG9rDmBXQB
	 gq5GMA7qjgZ0IISvmwPQc2JHMUsGnyvrIBc2H0jM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48OJrb8l089156
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Sep 2024 14:53:37 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 14:53:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 14:53:36 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48OJra0Q025489;
	Tue, 24 Sep 2024 14:53:36 -0500
From: Judith Mendez <jm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Bhavya Kapoor <b-kapoor@ti.com>, Judith Mendez <jm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62-main: Update otap/itap values
Date: Tue, 24 Sep 2024 14:53:35 -0500
Message-ID: <20240924195335.546900-1-jm@ti.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Update itap/itap values according to device datasheet [0].

Now that we have fixed timing issues for am62x [1], lets
change the otap/itap values back according to the device
datasheet.

[0] https://www.ti.com/lit/ds/symlink/am625.pdf
[1] https://lore.kernel.org/linux-mmc/20240913185403.1339115-1-jm@ti.com/

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 47 ++++++++++++------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 5b92aef5b284..7194603fd3bc 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -561,10 +561,9 @@ sdhci0: mmc@fa10000 {
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-mmc-hs = <0x0>;
-		ti,otap-del-sel-ddr52 = <0x5>;
-		ti,otap-del-sel-hs200 = <0x5>;
-		ti,itap-del-sel-legacy = <0xa>;
-		ti,itap-del-sel-mmc-hs = <0x1>;
+		ti,otap-del-sel-hs200 = <0x6>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-mmc-hs = <0x0>;
 		status = "disabled";
 	};
 
@@ -577,17 +576,17 @@ sdhci1: mmc@fa00000 {
 		clock-names = "clk_ahb", "clk_xin";
 		bus-width = <4>;
 		ti,clkbuf-sel = <0x7>;
-		ti,otap-del-sel-legacy = <0x8>;
+		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
-		ti,otap-del-sel-sdr12 = <0x0>;
-		ti,otap-del-sel-sdr25 = <0x0>;
-		ti,otap-del-sel-sdr50 = <0x8>;
-		ti,otap-del-sel-sdr104 = <0x7>;
-		ti,otap-del-sel-ddr50 = <0x4>;
-		ti,itap-del-sel-legacy = <0xa>;
-		ti,itap-del-sel-sd-hs = <0x1>;
-		ti,itap-del-sel-sdr12 = <0xa>;
-		ti,itap-del-sel-sdr25 = <0x1>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x6>;
+		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
 		status = "disabled";
 	};
 
@@ -600,17 +599,17 @@ sdhci2: mmc@fa20000 {
 		clock-names = "clk_ahb", "clk_xin";
 		bus-width = <4>;
 		ti,clkbuf-sel = <0x7>;
-		ti,otap-del-sel-legacy = <0x8>;
+		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
-		ti,otap-del-sel-sdr12 = <0x0>;
-		ti,otap-del-sel-sdr25 = <0x0>;
-		ti,otap-del-sel-sdr50 = <0x8>;
-		ti,otap-del-sel-sdr104 = <0x7>;
-		ti,otap-del-sel-ddr50 = <0x8>;
-		ti,itap-del-sel-legacy = <0xa>;
-		ti,itap-del-sel-sd-hs = <0xa>;
-		ti,itap-del-sel-sdr12 = <0xa>;
-		ti,itap-del-sel-sdr25 = <0x1>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x6>;
+		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
 		status = "disabled";
 	};
 
-- 
2.46.0


