Return-Path: <linux-kernel+bounces-296625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B6195ACEE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94ECE1C22871
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD401132464;
	Thu, 22 Aug 2024 05:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UwJGGL/V"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C12E3EE;
	Thu, 22 Aug 2024 05:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724304955; cv=none; b=ZrpKMyM7Yc7HaKpBZH2m8UncmlJJi2SSiccG113rCCU7jj6twbpe4mNH7ZScA5Ul8A5U+fi0EbCE0metC42Cssul2+mFbqt8+jnfSKoxPdQrLnvDu8GcQKHd4/2fabeDRsKzlILK3hKo+nQ4ZQPjce8R62FCl+Saq0dUOOe1ICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724304955; c=relaxed/simple;
	bh=CtEq7g1d94vXFrvgU8cst6cdSd/EbtYFYxOLd205oZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RWSON6zmERqu0OnD2aC7fioK0KsXwe7FPs9xYZLO2CeHhPiNjtFM8erkDFJoAwq9PxB6+dZQRliSC6/MqOe4PyXiZEaNA7lSYzoryKRT5Rtj9FcggO/m21e9obBod/U5IkEqLCBpq0Rt/+gljAWc6x/7iri0lPiytbGUeKSgvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UwJGGL/V; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47M5Ze9Z120376;
	Thu, 22 Aug 2024 00:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724304940;
	bh=3G/831VZMPg/EVxycyligIipdeBJkvkoKP5/tNrzULg=;
	h=From:To:CC:Subject:Date;
	b=UwJGGL/VSqUVmoz8nyp0T6sEhyc10NVwUCYcbEt9lrbSf6ZjnHpmR+hpCjA3oVUsh
	 Kb0ry/0UX7qfTfA7/Y05LvQ2NQG5fmjFBKn+jsrM8p7i3ljRVxNYWRZhlVPonb/EI4
	 NVgbDBoU3YWyjaMsQeil7CaBHFfv8xNBiTZwvZS4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47M5ZeLq002632
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 00:35:40 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 00:35:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 00:35:40 -0500
Received: from localhost ([10.249.128.135])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47M5ZcHY042740;
	Thu, 22 Aug 2024 00:35:39 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j722s-evm: Describe main_uart5
Date: Thu, 22 Aug 2024 11:05:38 +0530
Message-ID: <20240822053538.10475-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

main_uart5 in J722S platform is used by the firmware. Thus,
describe it for completeness, adding the pinmux and mark
it as reserved.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index 24e9f2ea509b..5addf1c0afc2 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -20,6 +20,7 @@ / {
 	aliases {
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
+		serial3 = &main_uart5;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 	};
@@ -211,6 +212,13 @@ J722S_IOPAD(0x01cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
 		bootph-all;
 	};
 
+	main_uart5_pins_default: main-uart5-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0108, PIN_INPUT, 3)       /* (J27) UART5_RXD */
+			J722S_IOPAD(0x010c, PIN_OUTPUT, 3)      /* (H27) UART5_TXD */
+		>;
+	};
+
 	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
 		pinctrl-single,pins = <
 			J722S_IOPAD(0x0120, PIN_INPUT, 7) /* (F27) MMC2_CMD.GPIO0_70 */
@@ -330,6 +338,12 @@ &main_uart0 {
 	bootph-all;
 };
 
+&main_uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart5_pins_default>;
+	status = "reserved";
+};
+
 &mcu_pmx0 {
 
 	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
-- 
2.34.1


