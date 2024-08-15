Return-Path: <linux-kernel+bounces-288590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5731A953C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4B91F22030
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90FD15532E;
	Thu, 15 Aug 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ytGYOxCR"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA11509B3;
	Thu, 15 Aug 2024 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754929; cv=none; b=UGNapMuayekyoJ9yecccS+Q2pxCiZxGLDcoYn25rZjwTRPUtHvIq0o2jt38rd0sMXXrEynPDjpyjVFy0VQH0pxYP9hYdPcc+fzlnu3OYfAqlvHc+kP6mI2InizIcWdKTHozENfr3mlCrt2FaseWzuavaQXgJBG8UyUH3GMbJ500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754929; c=relaxed/simple;
	bh=DjvcODVa36PD5tIpejpyd0j3hTPNkkdJi8wm0TBF3sY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AR/0eHQ3bhu33N8m6mDekGFjo2uylEeuVZq38zp7dUll+QsCYAuB4HHijyyyuqWO6cwVNdtnoxqz03NkI4RJc7rFsITqJcuoHdPv2emx2ZigJlhtwgM2gUfSUG7+MfpNEPZuY/ETkmER/A4ad9CUNh1Dm9OXrPP7FOwpOQtu4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ytGYOxCR; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmaL4003236;
	Thu, 15 Aug 2024 15:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723754916;
	bh=3vcli9GYNl3poZfw8KxDHbq0ijONEPHH3B2yuubFTvQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ytGYOxCRBjtsTRqU332yLHZ14TKzts4fresJaySBT4gS+GXzfRoWpxAHgoxhBdnLs
	 AYmWkrlUmK7BTFy2hDaeUJflD+hA8mZEJHpmLNNYQ4jBRrzvtM5wxcu/O7D3pNbEpl
	 2xt7tn4Tn+mJrI68EF4jt80qPIkGfUmKyVEnl0ns=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FKmakS059136
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 15:48:36 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 15:48:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 15:48:36 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmYNt052918;
	Thu, 15 Aug 2024 15:48:36 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>, Judith Mendez <jm@ti.com>
Subject: [PATCH v3 1/6] arm64: dts: ti: k3-am62a: Add ESM nodes
Date: Thu, 15 Aug 2024 15:48:28 -0500
Message-ID: <20240815204833.452132-2-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815204833.452132-1-jm@ti.com>
References: <20240815204833.452132-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add Error Signaling Module (ESM) instances in MCU and MAIN
domains, set ESM interrupt sources for rti as per TRM [0] 10.4
Interrupt Sources.

Add comments to describe what interrupt sources are routed to
ESM modules.

[0] https://www.ti.com/lit/ug/spruj16b/spruj16b.pdf

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v2:
- No change
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 916fcf3cc57d1..8c35293c3d2b0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -265,6 +265,14 @@ main_pmx0: pinctrl@f4000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	main_esm: esm@420000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x420000 0x0 0x1000>;
+		/* Interrupt sources: rti0, rti1, wrti0, rti4, rti2, rti3 */
+		ti,esm-pins = <192>, <193>, <195>, <204>, <209>, <210>;
+		bootph-pre-ram;
+	};
+
 	main_timer0: timer@2400000 {
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x2400000 0x00 0x400>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 8c36e56f41388..a5ca4ce523a46 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -15,6 +15,14 @@ mcu_pmx0: pinctrl@4084000 {
 		status = "disabled";
 	};
 
+	mcu_esm: esm@4100000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x4100000 0x0 0x1000>;
+		/* Interrupt sources: esm0_cfg, esm0_hi, esm0_low, mrti0 */
+		ti,esm-pins = <0>, <1>, <2>, <85>;
+		bootph-pre-ram;
+	};
+
 	/*
 	 * The MCU domain timer interrupts are routed only to the ESM module,
 	 * and not currently available for Linux. The MCU domain timers are
-- 
2.46.0


