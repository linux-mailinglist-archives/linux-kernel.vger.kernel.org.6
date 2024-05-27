Return-Path: <linux-kernel+bounces-190600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839528D0055
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27181C202EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F615E5D3;
	Mon, 27 May 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ByrcjnkE"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA513AA2A;
	Mon, 27 May 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813883; cv=none; b=sdQBiCX1AB9cdQQvHeK4je46W5eeHHrzvkEPiQu1zfT14qiNGbdTPRNp2HV1XomZevcthVhQ5zt/qXQ7Z/6adc63ejUsKNj09r6noczxQoyu9s9B5I2q1s1ixVQMRXYlneq7qWiBx0Xy0RjsKS1xWS+ynUzAEzNh9WLJd8TZ2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813883; c=relaxed/simple;
	bh=p5Efjc/Ni96fxa6Ej1iaMGFxYhrhQwpv/tq8i/OJOLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOHyEG16ydkJaCtN2E2oSm3U06eLoCV9WNemR+wfFQ/sR/X+V9NzXbjEezv0VZSDOr/grPd4cNlYJYu9GDym8GagamkGa2oiwnoZsbIjwm21y+onK1I/1CNc04NiingvG19l3DLSloENSH4KsbRJj9HOb4/whNfTth07fhNafL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ByrcjnkE; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44RCiVXq033820;
	Mon, 27 May 2024 07:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716813871;
	bh=JTrMPEOBiWUstqA2vkv6Z0yZuDNil0eDNS9hlAjd5xQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ByrcjnkEIyh5rYcFg+mFl44imj7uZga860cjZVgJnUezmGVDiFGJuFixso52AleHi
	 0TIQ4lajJJqYoxhALTlQ6opvL5PwpyFTFt6UV1m1VZJM0P+U6rIOV9eMscrGN908E3
	 e9FsUKsngJxFcwm+Jcj20iAgoH0MnO2WQzRSdBqk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44RCiVAi000970
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 07:44:31 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 07:44:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 07:44:31 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44RCiMbU035499;
	Mon, 27 May 2024 07:44:27 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2 1/3] arm64: boot: dts: ti: k3-am68-sk-base-board: Add LP8733 and TPS6287 nodes
Date: Mon, 27 May 2024 18:14:20 +0530
Message-ID: <20240527124422.3553828-2-n-francis@ti.com>
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

Add DTS node for LP87334E PMIC and two TPS6287x high current buck
converters.

LP87334E is responsible for supplying power to the MCU and MAIN domains
as well as to LPDDR4. The two TPS6287x supply power to the MAIN
domain for AVS and other core supplies.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Link: https://www.ti.com/lit/pdf/slda060
---
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index d743f023cdd9..74e59035013c 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -414,6 +414,83 @@ &wkup_uart0 {
 	pinctrl-0 = <&wkup_uart0_pins_default>;
 };
 
+&wkup_i2c0 {
+	bootph-all;
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	lp8733: pmic@60 {
+		compatible = "ti,lp8733";
+		reg = <0x60>;
+
+		buck0-in-supply = <&vsys_3v3>;
+		buck1-in-supply = <&vsys_3v3>;
+		ldo0-in-supply = <&vsys_3v3>;
+		ldo1-in-supply = <&vsys_3v3>;
+
+		lp8733_regulators: regulators {
+			lp8733_buck0_reg: buck0 {
+				/* FB_B0 -> LP8733-BUCK1 - VDD_MCU_0V85 */
+				regulator-name = "lp8733-buck0";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			lp8733_buck1_reg: buck1 {
+				/* FB_B1 -> LP8733-BUCK2 - VDD_DDR_1V1 */
+				regulator-name = "lp8733-buck1";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			lp8733_ldo0_reg: ldo0 {
+				/* LDO0 -> LP8733-LDO1 - VDA_DLL_0V8 */
+				regulator-name = "lp8733-ldo0";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			lp8733_ldo1_reg: ldo1 {
+				/* LDO1 -> LP8733-LDO2 - VDA_LN_1V8 */
+				regulator-name = "lp8733-ldo1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+
+	tps62873a: tps62873@40 {
+		compatible = "ti,tps62873";
+		bootph-pre-ram;
+		reg = <0x40>;
+		regulator-name = "VDD_CPU_AVS";
+		regulator-min-microvolt = <600000>;
+		regulator-max-microvolt = <900000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	tps62873b: tps62873@43 {
+		compatible = "ti,tps62873";
+		reg = <0x43>;
+		regulator-name = "VDD_CORE_0V8";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
 &mcu_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.34.1


