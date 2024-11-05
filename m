Return-Path: <linux-kernel+bounces-396161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062C49BC8CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D321C23175
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968BC1CFED8;
	Tue,  5 Nov 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OezhxN4V"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989019993D;
	Tue,  5 Nov 2024 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797970; cv=none; b=nLhBQNjDDBgzW4S29++kGntZj+43lqyA3hy675dlFl09wuF67JgLDNwIR+qxxZgxniXBNgBgcsbESEEK8pJvBcmH6zsgx3iTtn4ekQV74ztpvdpCNvboOhbKWM4sPaU8C9tR4x8njWBZrvYn6ZihSQ82oqeCrJ8x3pXxhCVglLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797970; c=relaxed/simple;
	bh=e3bDNG85v98/JJrTItGwf1O9+AL2cml8r5t6nDtvdVk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CcfQ+F8mV5cO7KNRawEtdWAdknEMoVfGhQ753HZBDz4bED6hU19I4boTdVi5DGykggk5OUvokrhi02se057qr3/C0lvtpRHo/Ak++Mi5DvcreKSUBBsbkU8EeUAC3QcrI5RMRDHsITOUdY2ej9LdnVoNXUky8M75+UZjG1EUSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OezhxN4V; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A59CR4b053563;
	Tue, 5 Nov 2024 03:12:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730797947;
	bh=pSA2DcK6+VL4PVPhLhuyvaj/CGjejRtTkA3hYib9a0c=;
	h=From:To:CC:Subject:Date;
	b=OezhxN4VX9rHbRsTqEjiZODjRuplYhc49cTDGmMVUXNd5Rx/nGN8RvBTta6CUpAo7
	 HZC7obGcs/5eYu91tqCmhkwrrmyxS3PMaFAd+5eex9JINTcl68+ku7Gk7QbmrvQXG+
	 TnaMDWMxTX/UT3qUNHyWzcPn81ZGGvfRGu0rv1Gs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A59CRob050273
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Nov 2024 03:12:27 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Nov 2024 03:12:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Nov 2024 03:12:27 -0600
Received: from localhost ([10.249.128.178])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A59CP0q088748;
	Tue, 5 Nov 2024 03:12:26 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>,
        <u-kumar1@ti.com>, <s-sinha@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable support for mcu_i2c0
Date: Tue, 5 Nov 2024 14:42:24 +0530
Message-ID: <20241105091224.23453-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Enable support for mcu_i2c0 and add pinmux required to bring out the
mcu_i2c0 signals on 40-pin RPi expansion header on the J722S EVM.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Signed-off-by: Shreyash Sinha <s-sinha@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index a00f4a7d20d9..796287c76b69 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -406,6 +406,13 @@ &main_uart5 {
 
 &mcu_pmx0 {
 
+	mcu_i2c0_pins_default: mcu-i2c0-default-pins {
+		pinctrl-single,pins = <
+			J722S_MCU_IOPAD(0x048, PIN_INPUT, 0) /* (E11) MCU_I2C0_SDA */
+			J722S_MCU_IOPAD(0x044, PIN_INPUT, 0) /* (B13) MCU_I2C0_SCL */
+		>;
+	};
+
 	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
 		pinctrl-single,pins = <
 			J722S_MCU_IOPAD(0x038, PIN_INPUT, 0) /* (D8) MCU_MCAN0_RX */
@@ -812,3 +819,10 @@ &main_mcan0 {
 &mcu_gpio0 {
 	status = "okay";
 };
+
+&mcu_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+};
-- 
2.34.1


