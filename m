Return-Path: <linux-kernel+bounces-190603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78C78D0059
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D940F1C21AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0A415E5CB;
	Mon, 27 May 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LNxW912t"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193F15E5BF;
	Mon, 27 May 2024 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813890; cv=none; b=flDN3IrW5N4WvpWYaG8Jr11QI2pxwN3GLmGzenkesABAi4BERk6dTA7a1lmEGTRPth52CbkNb93ilTRbcU0qm7OwYOIUfXXOrHlP4IV31ddGLvaaMZEL8Xfn5WMc4GenJiLsNpMWdOFuzii2NcmEpWZQZMJOLQd1PwaWhxsAmnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813890; c=relaxed/simple;
	bh=yf7pA7Ivanmi3RMGzumv+NQfcs+QEVD5zl4cbYtHC0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nq8H4UNo4SnYVWuMYHJMCt3bEgGcryVOXXY9Lt1ArdWBy8GUx+4twinYHfqJYj5JRP5P1Ilnf+91jHZ8LeT6arLRGg4QORWAoqB/ATLOH0VGjR0sHCZFcEHE1rZVwcXPk0kttTP+PdGY6GMTLKp80acDxBrQ0XSMYuNQFZyePP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LNxW912t; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44RCie5n000985;
	Mon, 27 May 2024 07:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716813880;
	bh=o4gWqOIjKwTCFY8gybaZSHm1C8i4+ZRYp77p4a/hxpg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LNxW912tIY2hULrm5H/ToNvIxrbU4zf3V1JcUm3WRyHBgQoEO/R79uQz750OIUm3n
	 eP8CFnPkOEEz8hJt6eYopR48w9GgzJHiATtaYMF9Iszr5F5GAPPU9YFtsqk5/UizWp
	 5E5wyI2o+dytf4wVPi+Ac61zVrH0iGv34J/gxUDw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44RCie92124655
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 07:44:40 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 07:44:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 07:44:39 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44RCiMbW035499;
	Mon, 27 May 2024 07:44:36 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2 3/3] arm64: boot: dts: ti: k3-j784s4-evm: Add TPS62873 node
Date: Mon, 27 May 2024 18:14:22 +0530
Message-ID: <20240527124422.3553828-4-n-francis@ti.com>
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

Add Tulip TPS62873 nodes for J784S4 EVM. These are step-down regulators
that supply VDD_CPU_AVS and VDD_CORE_0V8 to the SoC.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index d511b25d62e3..3884be9ca7f7 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -579,6 +579,27 @@ ldoa4: ldo4 {
 			};
 		};
 	};
+
+	tps62873a: tps62873@40 {
+		compatible = "ti,tps62873";
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


