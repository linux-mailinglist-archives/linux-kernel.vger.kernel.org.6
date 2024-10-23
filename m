Return-Path: <linux-kernel+bounces-377489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814B89ABF89
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C36B1F231BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61E15958A;
	Wed, 23 Oct 2024 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vDxLeKyp"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7961537AC;
	Wed, 23 Oct 2024 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666698; cv=none; b=gUAe3lfjGuaCblR4t8eGo6Rfj8LQyEHkN7hE5FRXFJkU2GL4n+uJMnU7Pqxs3sv+SRaSV4TVPIORqCxjb+TGp3qHZPHA1W3NJbu9DZDXmqQgUHkjQmgZLt7z5kFohMykzOBimkrbzTv/zDYmxqmIPN6eRwGwxJ7P/LQ6QjPi3cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666698; c=relaxed/simple;
	bh=fsgEeowNfLZ+AEu0rnrEvO6+4zAPScFF0LW6LOvL5Sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K1sCesz2sw5mc0mWDhWsij0guobkIdGSQNzAT3sDDIIUkQz+GNp+5gTS8c9spMU+8Gos2mYbyGOOWOB/N1OmEdNKfyx70mTCuHALqHH7O/pvy2Ta2NULSQZD4Up3/Qiy9KLdSnIE8LP/m2PouWA5jM1tsqpZRQGaNgecy1TKJtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vDxLeKyp; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N6wB0v031224;
	Wed, 23 Oct 2024 01:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729666691;
	bh=MSYXO80D/xh2KgocznlVgSWpmNHaoPLZStd9/B6a9U4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=vDxLeKyp05tg+JpWWhFi+suXwzAbu003jwBiqCCKWlhvu3eygqSpFkoKyQdmhAUVW
	 kh2lymJghSW4x0duW0zJ1z3EB4cCNePeIgZCjmxT8T04gxbHFrtbKL37LXnluL4HNA
	 qHgN2W/nKVqI0myNsCMwWCNzPxI+pHm+8nHKZEpg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49N6wBqL006353
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 01:58:11 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 01:58:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 01:58:10 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vWUU129058;
	Wed, 23 Oct 2024 01:58:05 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 23 Oct 2024 12:27:21 +0530
Subject: [PATCH v5 07/12] arm64: dts: ti: k3-j784s4-j742s2-evm-common:
 Remove parent nodes bootph-*
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241023-b4-upstream-bootph-all-v5-7-a974d06370ab@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729666652; l=2292;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=fsgEeowNfLZ+AEu0rnrEvO6+4zAPScFF0LW6LOvL5Sc=;
 b=lL3+BOnSSkmHrG3il7RUQ0d7ieM8eZaDa87FZTMlaqXUbVhznJUhopOtXW0nyidRzJaL+d3dV
 N40RZz1jBMZB1RYQmLUGua/NwZ6pteOhxq1+gOX8Hzz19fP9mHBK/wk
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Adding bootph properties on leaf nodes imply that they are applicable to
the parent nodes as well. Bootloaders can derive the parent nodes when
bootph is available in the leaf nodes.

Remove the bootph-* properties from parent nodes as they are redundant.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index 98453171a179..b2e2b9f507a9 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -305,7 +305,6 @@ &wkup_gpio0 {
 };
 
 &main_pmx0 {
-	bootph-all;
 	main_cpsw2g_default_pins: main-cpsw2g-default-pins {
 		pinctrl-single,pins = <
 			J784S4_IOPAD(0x0b8, PIN_INPUT, 6) /* (AC34) MCASP1_ACLKX.RGMII1_RD0 */
@@ -432,7 +431,6 @@ J784S4_IOPAD(0x078, PIN_OUTPUT, 1) /* (AH37) MCAN2_RX.AUDIO_EXT_REFCLK1 */
 };
 
 &wkup_pmx2 {
-	bootph-all;
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -548,7 +546,6 @@ J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 7)
 };
 
 &wkup_pmx0 {
-	bootph-all;
 	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -568,7 +565,6 @@ J784S4_WKUP_IOPAD(0x008, PIN_INPUT, 0) /* (C34) MCU_OSPI0_DQS */
 };
 
 &wkup_pmx1 {
-	bootph-all;
 	mcu_fss0_ospi0_1_pins_default: mcu-fss0-ospi0-1-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -740,18 +736,15 @@ &ufs_wrapper {
 };
 
 &fss {
-	bootph-all;
 	status = "okay";
 };
 
 &ospi0 {
-	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>, <&mcu_fss0_ospi0_1_pins_default>;
 
 	flash@0 {
-		bootph-all;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <8>;
@@ -808,13 +801,11 @@ partition@3fc0000 {
 };
 
 &ospi1 {
-	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi1_pins_default>;
 
 	flash@0 {
-		bootph-all;
 		compatible = "jedec,spi-nor";
 		reg = <0x0>;
 		spi-tx-bus-width = <1>;

-- 
2.46.0


