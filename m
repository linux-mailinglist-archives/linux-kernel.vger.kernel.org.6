Return-Path: <linux-kernel+bounces-377481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B0D9ABF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94A51C23610
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A313155324;
	Wed, 23 Oct 2024 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SpgrGPUV"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF4154BFB;
	Wed, 23 Oct 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666675; cv=none; b=kNQopYGs478eMyjkNNVHhaIxTOPt0eDERP8MjOx/tflMNLrKAVo/XYEm4mpx1AE5TqbaIvnXzrN9fm2b+vwoOQDxYqVgtZR/ZPLnUsLlBg3fm9nJ5etmlfyiVMP4blxPYOUHWiFpWiW+hz7uy0e/Zz+eoqwxwhbevb/UCcvfTnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666675; c=relaxed/simple;
	bh=KZbHZuHPzVVOw5/YUibS3MIHFAN3oLZJ7JtB4e4b3KM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BjHGCPCW+v6jO7OA9m6gsh7UKaO6V2x7AC44bwve9Ni/Mf7fdeLnyznSIZ+8HT/FxuEgavSiCAbxn3KbfacuQj7i2juprCi/uXdTj5BdtP3z8uuAagt1X1egMsfPxyH/J3DoCyXHcflJdd4o5odR/JLyg5dGfDfzCIQXkiRjm0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SpgrGPUV; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vfMt056462;
	Wed, 23 Oct 2024 01:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729666661;
	bh=ndyJdRvJJnqCdNLgocPXEINIW2HGhAp3Lnlb9t5J8js=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=SpgrGPUV81Nf2WL5y6CfkBa02mkw6n6ivqBQ44Xd6IzXxurM9KoILood4qPUElao7
	 xYXH7fFhNbkUuTzEMzBD+7d6P38p1p7LVmh4SQrUBbf6pSBDOiJDT4GhpQrurdyvyb
	 jhXLyrq17e7VMLN/YOLY6CpChHQOnIAG/Ixx3CLg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49N6vfse055595
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 01:57:41 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 01:57:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 01:57:41 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vWUO129058;
	Wed, 23 Oct 2024 01:57:37 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 23 Oct 2024 12:27:15 +0530
Subject: [PATCH v5 01/12] arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup: Move
 bootph from mcu_timer1 to mcu_timer0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241023-b4-upstream-bootph-all-v5-1-a974d06370ab@ti.com>
References: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
In-Reply-To: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis
	<afd@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729666652; l=1093;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=KZbHZuHPzVVOw5/YUibS3MIHFAN3oLZJ7JtB4e4b3KM=;
 b=8VnuLOoOXQlehXw9bV+vBEl161PuwhiheueLlTeggB0eRFDJtvw+HewfR2F7vM7WCK5NHeqSx
 Zf4ZPuGuiOxC5mwCYsUgmzpgtZJ/jEPfd8uhpzSpuPwOwJLQ9V6mbWF
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Bootloader are using mcu_timer0 instead of mcu_timer1. Adds bootph to
mcu_timer0 instead of mcu_timer1.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
index cba8d0e64f2e..9899da73a905 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
@@ -172,13 +172,13 @@ mcu_timer0: timer@40400000 {
 		assigned-clocks = <&k3_clks 35 2>;
 		assigned-clock-parents = <&k3_clks 35 3>;
 		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		bootph-all;
 		ti,timer-pwm;
 		/* Non-MPU Firmware usage */
 		status = "reserved";
 	};
 
 	mcu_timer1: timer@40410000 {
-		bootph-all;
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x40410000 0x00 0x400>;
 		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.46.0


