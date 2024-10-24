Return-Path: <linux-kernel+bounces-379208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F05E9ADB6E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0672836A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4939C17625F;
	Thu, 24 Oct 2024 05:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gfn9dYqN"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF07175D5D;
	Thu, 24 Oct 2024 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747306; cv=none; b=JxEM+3VQEz3v3m033v9ffwCZTnAnD+BsFSdewUV1VxL2JbXZIfDiG352puA8yk/XVwxSrY1c7pjWd2pXCARUthzmGlsLS5QLxLf5Vy8mnNOPK7e52Ruq9Rt88HJLt8U2ti3dMnJ0lpSmu2kye8IJcWzjEpQHDnMMt+YJ7m+MATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747306; c=relaxed/simple;
	bh=9iGWhy2bJ0M0XUaJJe5iD1g+ItxzMy6MMTq9OU0rsI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BaoljsdpGi7OYAWVXYccMNKK6zOjDrPm2SGIEfCXYBOBU2whkaibxMBhI8NcaZB+6y3LE2oEAL0BNeiSa7Ituwku7iXEQcJaeWugL1Oeqfz2wEh5gyV6C4dhkNFjzY4eOg0yOSGmLpbvhjxJhhcuE3uGQY72FJlEJeGl3t2QFjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Gfn9dYqN; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49O5LdYu113372;
	Thu, 24 Oct 2024 00:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729747299;
	bh=e4I3VAihgVFcjroe2fX4sZY8z494elq8Tb7Hxcm9BS4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=Gfn9dYqNLlxoMONPhdcHUPxg2hR1uQpv1iIAx9IaHE1Den4q+iiojolXStirhbW01
	 RMmXmO8Ifm4qiJJv+hi334q/ZE4b60RLuLdPM3t5RPFdRUFfGzyOXxFh2zXPyh23X7
	 jmaQdydiRLwC3b+fyP4Vg5C4vxBbjfnrWQtbmOEc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49O5LdEd025088;
	Thu, 24 Oct 2024 00:21:39 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 00:21:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 00:21:39 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49O5L4lF090467;
	Thu, 24 Oct 2024 00:21:35 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 24 Oct 2024 10:51:04 +0530
Subject: [PATCH v6 07/12] arm64: dts: ti: k3-j784s4-j742s2-evm-common:
 Remove parent nodes bootph-*
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-b4-upstream-bootph-all-v6-7-2af90e3a4fe7@ti.com>
References: <20241024-b4-upstream-bootph-all-v6-0-2af90e3a4fe7@ti.com>
In-Reply-To: <20241024-b4-upstream-bootph-all-v6-0-2af90e3a4fe7@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729747264; l=2443;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=9iGWhy2bJ0M0XUaJJe5iD1g+ItxzMy6MMTq9OU0rsI4=;
 b=2u2ia0gSVbFfVnpX9akDxUCz8yuK3O6CC37YPQ4kxOrIUwm6oC7kgC+lVWS9Bp/mo+Jluacmc
 3wUPvQjhcWyCBh05KDexIzgWxpjhcfmjKJD2fryIsvsNbQ6BUj7driB
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Adding bootph properties on leaf nodes imply that they are applicable to
the parent nodes as well. Bootloaders can derive the parent nodes when
bootph is available in the leaf nodes.

Remove the bootph-* properties from parent nodes as they are redundant.

Reviewed-by: Aniket Limaye <a-limaye@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---

Notes:
    R-by picked up in v5 ( Aniket )

 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index 98453171a1790cd605d25ad939f556127519524a..b2e2b9f507a9828d49b1eb94d098b2c6682cef0e 100644
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


