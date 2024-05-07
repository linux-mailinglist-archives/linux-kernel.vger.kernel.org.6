Return-Path: <linux-kernel+bounces-171261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326B78BE1F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D522883E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A7315E217;
	Tue,  7 May 2024 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ig276Z9u"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9FD158D9A;
	Tue,  7 May 2024 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084553; cv=none; b=fgmSExpMI3NLNMEjP6aVOqLvaD05CKVAYovlIsPJG4DphiFlamaq7ajgEak080n0BVdn2liNNI2bvvorvx/k5frKjyfyqGIagr9R7z6R5jru5o3Pin0riSZc75EeLznIqlXOg7ZtLWNBTKJX3M+eVgEVvTGKc7dTBtzQDBEbQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084553; c=relaxed/simple;
	bh=2cQv6XBDyOhTgee0zAQJ0zsYKovRivundyuqbli8OFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDEmhRdz+EtOm5DkOCdKvGDJr12kcoMsTGrQONSshtbVF0k0eeLsaemFUJGRNpW2LxH/ZQX2rnavr84ZVmhFhxuxgr7uW40HNZ2/i0YweqWv9E/QIwGycAO1fK9RdiceMwbAXnSmmJ/E5H7M0Ou+BaGQkurlsRQGefEY4UMYKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ig276Z9u; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 447CMGod018818;
	Tue, 7 May 2024 07:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715084536;
	bh=5o3XXAlBSBfUclHCSASQlw8HuZIIIRdrGqTM+UaDGxk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ig276Z9uqB2Dc9cnDwcoZIg9uUO6TMLDSmWo3UqCJepfQoSiKgrodCoKi0/qjGDaz
	 iEFEBNcepD/yIxK3GTbQIQhy9CVNE/UBlJP9sQ/3Y6GCpF/JgH3SF0yksabkZNmJgL
	 kj6E+6t+dod/l4nvV4Pucyup4tvE194ZhAgS+TVA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 447CMG17015786
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 07:22:16 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 07:22:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 07:22:15 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 447CLwDQ038074;
	Tue, 7 May 2024 07:22:12 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 3/5] arm64: boot: dts: ti: k3-am68-sk-base-board: Add LP8733 and TPS6287 nodes
Date: Tue, 7 May 2024 17:51:56 +0530
Message-ID: <20240507122158.3739291-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507122158.3739291-1-n-francis@ti.com>
References: <20240507122158.3739291-1-n-francis@ti.com>
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
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index d743f023cdd9..5cd8310ea1c3 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -414,6 +414,84 @@ &wkup_uart0 {
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
+		compatible = "ti,tps6287x";
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
+		compatible = "ti,tps6287x";
+		bootph-pre-ram;
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


