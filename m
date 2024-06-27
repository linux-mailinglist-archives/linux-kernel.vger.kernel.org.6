Return-Path: <linux-kernel+bounces-232668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2275091AC9C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D067F2822FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D471993B4;
	Thu, 27 Jun 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aQ4pniGE"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415C61991A9;
	Thu, 27 Jun 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505551; cv=none; b=sdRa/fAhr5w97a1O6nVY63rTMdfMP8eDgDS7PvgSdT7ljrvoL9jgg5H27EhSnMDyKGAtE5QAJQod4lfhPVt6Qobe+a12He8LkAd7ZqwnJE4jDApNHvSFoXW0629usIvEbQFmkY+qkGXkbmgQDIgwQ6u1qybknKJnmS0Rtbh8LFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505551; c=relaxed/simple;
	bh=qck3a2TrPRKylU8zgABdxPbYDq27HmoZnuVMmuL8KIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yxj3sG+jgJ2re3HvKMsAF0RlITEMSN59Bl2sPgEwDt7v5tHjDFFtTainupbcdoD7ZlOYCw8MzNgUAPIzqP3k7Q1XcGZzKhT2REvh4rOK00y0eE5lFRx6/aC0D6HMlGqOirxwkj0L+VmRz87mkoyo/PYatYISkynpnGZDV1RQjAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aQ4pniGE; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RGPfn5033152;
	Thu, 27 Jun 2024 11:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719505541;
	bh=QWLAeR0SbvPwAQvjXd9TFa3s9O6NKETMaJ1nSHrnJPo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aQ4pniGEnPDNfiBTn4vZkkag3fhbzRXtvAGqd9G5uhwcKqneE5DkhMlxpDlZlgX9C
	 FtgJSh0W3fOQF4s6fRuFW96SBGA3Jqj8AbIdpbcYSE5cHp48h60Ie2INVi0ZTzylgV
	 38IZfhAdcdgxUCcL0w9T9iRx4xprJTK87p7q/UVk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RGPfHQ092933
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 11:25:41 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 11:25:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 11:25:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RGPfHf095204;
	Thu, 27 Jun 2024 11:25:41 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Vignesh Raghavendra
	<vigneshr@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>, Bryan Brattlof <bb@ti.com>,
        Dhruva Gole <d-gole@ti.com>, Nishanth Menon
	<nm@ti.com>
Subject: [PATCH V2 2/3] arm64: dts: ti: k3-am62p: Add gpio-ranges properties
Date: Thu, 27 Jun 2024 11:25:38 -0500
Message-ID: <20240627162539.691223-3-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627162539.691223-1-nm@ti.com>
References: <20240627162539.691223-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On the AM62P platform we have no single 1:1 relation regarding index
of GPIO and pin controller. The GPIOs and pin controller registers
have mapping and holes in the map. These have been extracted from the
AM62P data sheet.

MCU pinctrl definition is shared as it is common between AM62P and
J722S, but that is not the case for main domain.

Ref: AM62P Data sheet https://www.ti.com/lit/gpn/am62p

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
 - Use PIN_GPIO_RANGE_IOPAD instead of PIN_GPIO_MUX_MODE
 - Refactored on top of next-20240626 (new common files)
 - Since the patch had to be refactored as well as new define used, I
   have skipped picking up Dhruva's Reviewed-by.

V1: https://lore.kernel.org/linux-arm-kernel/20240618173123.2592074-3-nm@ti.com/

 .../boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi  |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi       | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index 1d4e5fc8b4e0..e65db6ce02bf 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -12,7 +12,15 @@ mcu_pmx0: pinctrl@4084000 {
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
+		pinctrl-single,gpio-range =
+			<&mcu_pmx_range 0 21 PIN_GPIO_RANGE_IOPAD>,
+			<&mcu_pmx_range 23 1 PIN_GPIO_RANGE_IOPAD>,
+			<&mcu_pmx_range 32 2 PIN_GPIO_RANGE_IOPAD>;
 		bootph-all;
+
+		mcu_pmx_range: gpio-range {
+			#pinctrl-single,gpio-range-cells = <3>;
+		};
 	};
 
 	mcu_esm: esm@4100000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index f8a7f0cbd327..57383bd2eaeb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -42,10 +42,27 @@ &inta_main_dmss {
 	ti,interrupt-ranges = <5 69 35>;
 };
 
+&main_pmx0 {
+	pinctrl-single,gpio-range =
+		<&main_pmx0_range 0 32 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 33 92 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 137 5 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 143 3 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 149 2 PIN_GPIO_RANGE_IOPAD>;
+
+	main_pmx0_range: gpio-range {
+		#pinctrl-single,gpio-range-cells = <3>;
+	};
+};
+
 &main_gpio0 {
+	gpio-ranges = <&main_pmx0 0 0 32>, <&main_pmx0 32 33 38>,
+			<&main_pmx0 70 72 22>;
 	ti,ngpio = <92>;
 };
 
 &main_gpio1 {
+	gpio-ranges = <&main_pmx0 0 94 32>, <&main_pmx0 42 137 5>,
+			<&main_pmx0 47 143 3>, <&main_pmx0 50 149 2>;
 	ti,ngpio = <52>;
 };
-- 
2.43.0


