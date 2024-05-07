Return-Path: <linux-kernel+bounces-171262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0508BE1F8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF9B1F255A0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB7715E5B4;
	Tue,  7 May 2024 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="heZ0joYI"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025215E1E5;
	Tue,  7 May 2024 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084553; cv=none; b=X6sgvPLzPDSbs24hiHz6MYdzJo16GIM/YwbDgaoI1OqYa/WwQ9ptwJYzjcONXapmr7PxFo+bnaQescnvtFpN+QkSYeZy+VxREqrKllwp+RTUlKTrG6dbnslIbsjoj+2rnDTJwiTPCFLPp+SvtTs5f+wXXSSd97gJPNVpMg1GlLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084553; c=relaxed/simple;
	bh=6cQoncQ5unf3QFO+Zm6z73ucOUPvr7q1ARLhhcNcNiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cV1/I4zsoD8CFc71kE4u/HdI1vkDgtizsNBpTJUtzde8G2tXoywvWD76NnBRntTPwm0LGsa0XbFRmxg9JYxXOWfpajY9wrnJ8BoOGqh3YRSo3P69g2cV2lS4NYXNAQHtm+sTg4dRfmYjs7Crk3pLDpZoSqZ80hgrEzmM89twnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=heZ0joYI; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 447CMODs091036;
	Tue, 7 May 2024 07:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715084544;
	bh=VaPYXP7plLTdrxeb9bd/XeTAgqX+Y/r4AjC1Y9AxwXU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=heZ0joYIeGHwE/lPw2zbpmjfgbmw8oaFLg9XXlCtDbXfSr8LRt6xk2i3Rmi7B6a+t
	 dzl2vr+b5rn/6QAH2KE/erw5LCtJ9TC6EOZnBa7FSDKjd/XwZZwKEZV/yZIsBVfqAc
	 RRUGp6phh8TEfQYoaVq8rMIpbwm25K0Yyv/nZ1ek=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 447CMO1J050119
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 07:22:24 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 07:22:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 07:22:24 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 447CLwDS038074;
	Tue, 7 May 2024 07:22:20 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 5/5] arm64: boot: dts: ti: k3-j784s4-evm: Add TPS62873 node
Date: Tue, 7 May 2024 17:51:58 +0530
Message-ID: <20240507122158.3739291-6-n-francis@ti.com>
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

Add Tulip TPS62873 nodes for J784S4 EVM. These are step-down regulators
that supply VDD_CPU_AVS and VDD_CORE_0V8 to the SoC.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 81fd7afac8c5..ccd91f266840 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -579,6 +579,28 @@ ldoa4: ldo4 {
 			};
 		};
 	};
+
+	tps62873a: tps62873@40 {
+		compatible = "ti,tps6287x";
+		bootph-pre-ram;
+		reg = <0x40>;
+		regulator-name = "VDD_CPU_AVS";
+		regulator-min-microvolt = <750000>;
+		regulator-max-microvolt = <1330000>;
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
 
 &mcu_uart0 {
-- 
2.34.1


