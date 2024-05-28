Return-Path: <linux-kernel+bounces-191724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A77A88D1325
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0ECDB211BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A4E1429B;
	Tue, 28 May 2024 04:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vx5XCkQt"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7A31DA4D;
	Tue, 28 May 2024 04:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868948; cv=none; b=JQvJjeiOOYgBE8h+KbJXWGgHKF+yJsUGnG2xO9TrZ+tO3bdBRmJ0KuJW6dg50VTUkwJmlfSVGceSXmaphxSqIhOtLhca6XE6bKG0QEoPwN3B/Rh8ApUyljG/Qp7jaUDpAY334hPAJ+PA1vYyeDyxr8robE/OygK+DhLE28RY3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868948; c=relaxed/simple;
	bh=KqCoS9ReYcUv8szPP6e3PL2+Wc/n2pWlykBvRSuUVcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqGlydOgIYmykcrFKnTCQQbOzsVMpsJo5msj+Dd4p6Yur83WoA+Kz4EFOoneYfZkDa9AHCdLAuejCZbwitb7s2nysD72XVhhXnhA92Tz8ppCI7De2WKYEcQs+SEiCVsDvcze/DQsffRXJv3E9W95Ln9B4QGMLAjvjx/RYcBBFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vx5XCkQt; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S42IBH085031;
	Mon, 27 May 2024 23:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716868938;
	bh=BqK9oLp9g+VCSonA8VHGZ43d9OHCsShl4R8A5nCFkYI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Vx5XCkQt/ZDR0ixo5z0Iq6D1MoEIb1uE6TE0o4vX92AFmbX7XGx3Aw41pTwzV6/GM
	 kaABvS2QN/4fUkZpvZRl0XAULyWMvldQK8RytDNy+mmUJlyNQp7lwbUijTAidIL9m1
	 Ymdqf71ps7+zzluPM6szmibCgDPVqcMpetDkstpw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S42Hup093179
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 23:02:18 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 23:02:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 23:02:17 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S420P2028431;
	Mon, 27 May 2024 23:02:13 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v3 3/3] arm64: dts: ti: k3-j784s4-evm: Add TPS62873 node
Date: Tue, 28 May 2024 09:31:59 +0530
Message-ID: <20240528040159.3919652-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528040159.3919652-1-n-francis@ti.com>
References: <20240528040159.3919652-1-n-francis@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index d511b25d62e3..5a9e9f596d71 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -579,6 +579,27 @@ ldoa4: ldo4 {
 			};
 		};
 	};
+
+	tps62873a: regulator@40 {
+		compatible = "ti,tps62873";
+		reg = <0x40>;
+		bootph-pre-ram;
+		regulator-name = "VDD_CPU_AVS";
+		regulator-min-microvolt = <750000>;
+		regulator-max-microvolt = <1330000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	tps62873b: regulator@43 {
+		compatible = "ti,tps62873";
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


