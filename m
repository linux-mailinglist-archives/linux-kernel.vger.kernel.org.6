Return-Path: <linux-kernel+bounces-211559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96679053BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8762839BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1656417E459;
	Wed, 12 Jun 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tgG6Qc4C"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C8E17E440;
	Wed, 12 Jun 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198684; cv=none; b=JWgZ7dcxqwISV/+0X89lzHytaYx8QQPbX0CnWtFSw/IQd8lS2nA7+3eNiXfP4H6ngJJEwzIB4rVuKNysx2LTAvK7xDFLrWMIjQ3WxjF4dmiKW9BUNNnBwNzhQJwRECsdiUdPM7xk4UdHOyNsbH5Q9ZYsLtvAxv9PvXjyYeRxils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198684; c=relaxed/simple;
	bh=2c5Ng63OSdX+0hSNyFYhBkj2tUNVlhP2LaurSNjth0o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4Qf3gz3gCW85SlgvcCJISie4Qq/FyHG+IWUN1x8MBiybWNeRnVUNDVSbZJ6xp78keBfhSR3WwauKG6pBTbu3BjbtUJM2Fxg6s0DzgeYdPz+9TcY/rzVfoNSWh5HCe4TS/03UM8kNZKaDuvjsKZSWTsxksYYIFm9pCktfCqM83E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tgG6Qc4C; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDObFL111078;
	Wed, 12 Jun 2024 08:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718198677;
	bh=UmA2KNTj2lKtPyS1jRQtP4Lydmpo7kloxGlDygJDt8A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tgG6Qc4CcgkuZKObx/o8skiGcj/WKAaUxbO2aPWFhr/9tgVm8NOY+WzLagLjLweK/
	 Pi38asnO0WECBeA2WuLNHmJXy91vsxkPKMpzcCNgr1Fdiy2MYpF/wJugPoVms6j28Z
	 E7kTuE8s2nHVPX4BT/hNO2fDYdKObRGgElNomGf4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDObPs065596
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:24:37 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:24:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:24:36 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOAmv046478;
	Wed, 12 Jun 2024 08:24:33 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v6 5/8] arm64: dts: ti: k3-j722s: Move MAIN domain overrides to k3-j722s-main.dtsi
Date: Wed, 12 Jun 2024 18:54:06 +0530
Message-ID: <20240612132409.2477888-6-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240612132409.2477888-1-s-vadapalli@ti.com>
References: <20240612132409.2477888-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Since the MAIN domain peripherals specific to J722S SoC are present in the
"k3-j722s-main.dtsi" file, move the overrides for the MAIN domain from the
"k3-j722s.dtsi" file to the "k3-j722s-main.dtsi" file.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
This patch has been newly introduced in this series and doesn't have a
Changelog.

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 11 +++++++++++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi      | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 84378fc839d6..b75dab8230c2 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -38,3 +38,14 @@ usb1: usb@31200000{
 		};
 	};
 };
+
+/* MAIN domain overrides */
+
+&inta_main_dmss {
+	ti,interrupt-ranges = <7 71 21>;
+};
+
+&oc_sram {
+	reg = <0x00 0x70000000 0x00 0x40000>;
+	ranges = <0x00 0x00 0x70000000 0x40000>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index 1bcbc9152ff0..14c6c6a332ef 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -232,14 +232,3 @@ cbass_wakeup: bus@b00000 {
 
 /* Include J722S specific peripherals */
 #include "k3-j722s-main.dtsi"
-
-/* Main domain overrides */
-
-&inta_main_dmss {
-	ti,interrupt-ranges = <7 71 21>;
-};
-
-&oc_sram {
-	reg = <0x00 0x70000000 0x00 0x40000>;
-	ranges = <0x00 0x00 0x70000000 0x40000>;
-};
-- 
2.40.1


