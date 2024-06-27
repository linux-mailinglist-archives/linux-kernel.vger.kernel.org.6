Return-Path: <linux-kernel+bounces-232669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A11A91ACA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABB01C2241D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F15199EA6;
	Thu, 27 Jun 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i098GdFa"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48F31991A9;
	Thu, 27 Jun 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505556; cv=none; b=BLMckAZ1s0640J7GKsZmRt1KMB8DEVmZv9mOV1CbAMNYYwj0UHDCH/+UaoRFASvX+YuhHSewpP9P1iMZOw1MaNjQLR/aRrNRGHkX2iGlyeOzX84Cs0g62l6KXFupUSgU99Kx2HLv86W2H2Zmk30BrJcz0iw2M84GnkRiA+DoD04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505556; c=relaxed/simple;
	bh=dU2O7vKy53HHzT0u9W8D0aWnguZ5iLZSXWsceBf4/aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9Oktsjg4ve2p+dqT91p7r0NP27io2Bllqvb9kRlRGUYFIv6la72mKT57v3ewWHRNIurhhY+jrKCfGGS0Q4RjDv47yRRQLgzb3FckurukQduOz4PFCzAIW8jnAcwrp/sYrqkT85/V9IgN1Awbq+fohfeOrLLX703z9BTPxKhTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i098GdFa; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RGPfT6049649;
	Thu, 27 Jun 2024 11:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719505541;
	bh=CCJwwKb+hvEmjWMelrMlJG7ya9EjLTcM5ERxIkDLI/k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=i098GdFa11rnXKArF4pIk2k7NNrkWPOavIMxq48LWkjQjsv2WkiETfmPvjrCVDT6K
	 CVOdjvIJFTMlVPOMbLiVS+v0bbHVDgPm2sRiElzMVqaekJxVIcIm+ucyP2I5wPMI+Z
	 SG8CVpQApewUltlnM5wuOnHR66UevVMKvbB28z5I=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RGPfdt023122
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 11:25:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 11:25:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 11:25:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RGPfB9095207;
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
Subject: [PATCH V2 3/3] arm64: dts: ti: k3-j722s: Add gpio-ranges properties
Date: Thu, 27 Jun 2024 11:25:39 -0500
Message-ID: <20240627162539.691223-4-nm@ti.com>
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

From: Jared McArthur <j-mcarthur@ti.com>

The AM67A/J722S/TDA4AEN platform is a derivative of AM62P platform
and we have no single 1:1 relation regarding index of GPIO and pin
controller. The GPIOs and pin controller registers have mapping and
holes in the map. These have been extracted from the J722S data
sheet. The MCU mapping is carried forward as is with J722S, however the
main GPIO block has differences that needs to be accounted for.

Mux mode input is selected as it is bi-directional. In case a specific
pull type or a specific pin level drive setting is desired, the board
device tree files will have to explicitly mux those pins for the GPIO
with the desired setting.

Ref: J722S Data sheet https://www.ti.com/lit/gpn/tda4aen-q1

Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
 - Use PIN_GPIO_RANGE_IOPAD instead of PIN_GPIO_MUX_MODE
 - Refactored on top of next-20240626 (refactored files)

V1: https://lore.kernel.org/linux-arm-kernel/20240618173123.2592074-4-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 228c6c89245c..28aac43aae45 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -181,10 +181,28 @@ &inta_main_dmss {
 	ti,interrupt-ranges = <7 71 21>;
 };
 
+&main_pmx0 {
+	pinctrl-single,gpio-range =
+		<&main_pmx0_range 0 32 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 33 55 PIN_GPIO_RANGE_IOPAD>,
+		<&main_pmx0_range 101 25 PIN_GPIO_RANGE_IOPAD>,
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
+			<&main_pmx0 70 72 17>;
 	ti,ngpio = <87>;
 };
 
 &main_gpio1 {
+	gpio-ranges = <&main_pmx0 7 101 25>, <&main_pmx0 42 137 5>,
+			<&main_pmx0 47 143 3>, <&main_pmx0 50 149 2>;
 	ti,ngpio = <73>;
 };
-- 
2.43.0


