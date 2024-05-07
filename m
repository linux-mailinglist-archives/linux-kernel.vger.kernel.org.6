Return-Path: <linux-kernel+bounces-171260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890FF8BE1F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E78A1F24DB8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA90158D8C;
	Tue,  7 May 2024 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JqGSbR42"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C42415DBAE;
	Tue,  7 May 2024 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084551; cv=none; b=epArIQ8JEzDciwiIZvbWrZavhG/4xl3Vv/XEV/OZT2Je2SsI+DeMSeOT9+uQJpXHpZHNxnDB+8WoRA/+MwhAAUaxR5s7vwBNI+jkqMTZY9MognyZuV/leXQBkfzyfZkfOkIdY6NI1PWy3CN/uxvK0I49QFT8Hdvz7XKTIhLFiIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084551; c=relaxed/simple;
	bh=TrQPkiqFILjwkVxEVBioLjNmQ9LUPtxhBIXCGiuUIrE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R18kFV+VZ5cbLXs4oCbsmU8U+PB/86YNAU67cuxeyadfcwqqz4Iwa/hZXK0B+1TlNTVwVMSTK+5tsc0jBhX+tNz8wTCfkusYIACAx1zLb73sDngioKogTGNKYabBLSkryVE8HQ5wHq4UeeavYJIBNwl+sj9FaDbdyWXWFL0n8rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JqGSbR42; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 447CMKD9091022;
	Tue, 7 May 2024 07:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715084540;
	bh=T32qsh2H3WTkWUNyra2+KOYKEoHfMLIagmYfyTSFwb4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JqGSbR42K/JIr83iWdIqjz9kWWO4Ls6Y0ME9BI1Kat98pI3EfSCP15GMYbMy1jq2u
	 1ksuCtxR0W38HHD3y9PAxcKuXltyletJ8Wvy+ti/MS5xbBvtuCM2gNCE4+L3DJvXYs
	 wHYpwZ5fDteHAo1axiANvBve5BlaSVu9y5o5bPsU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 447CMK1T077479
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 07:22:20 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 07:22:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 07:22:20 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 447CLwDR038074;
	Tue, 7 May 2024 07:22:16 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 4/5] arm64: boot: dts: ti: k3-am69-sk: Add TPS62873 node
Date: Tue, 7 May 2024 17:51:57 +0530
Message-ID: <20240507122158.3739291-5-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507122158.3739291-1-n-francis@ti.com>
References: <20240507122158.3739291-1-n-francis@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 50de2a448a3a..37257d616cd1 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -814,6 +814,28 @@ ldoa4: ldo4 {
 			};
 		};
 	};
+
+	tps62873a: tps62873@40 {
+		compatible = "ti,tps6287x";
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
+		compatible = "ti,tps6287x";
+		bootph-pre-ram;
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


