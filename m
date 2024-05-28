Return-Path: <linux-kernel+bounces-191722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D1C8D1321
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73120284500
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B7117BD8;
	Tue, 28 May 2024 04:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pdCDUyd8"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECB317E8E4;
	Tue, 28 May 2024 04:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868943; cv=none; b=rOncHWBkywBN6Rixd7VSGNULNUboLrZbqVWV7gGPaSMZqcothsc7WQWPHZGKA3GIAHo79Vgd0vXubbsbdqgFK/nm19hLzQK7MCKV8gF20eQwrMG3EQfcu2u4280xhX+J5cNWuC4hZs6V96QcaLL9Xt9Fmn2lWLDzOC/DlElpABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868943; c=relaxed/simple;
	bh=A7krJ9hN8ETag6cmVIyu2zB1IeKU/qgLv1W7pyi1+Lc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7CYOLA+Y3izIzXtvXZjLfDTXIW/nc7NK1ZXR+FLzIHrENM5EVvzAQ+tC+oW32WJNOcyhox3sFCKH/VWRiIgfC0/BK3VAxAMZ/g4NFx8b+BVYIdN0hrwX69e76aL0wwgRIK/+NCym8z0ULJ7NCI0R2Ju65GGquEruR5xO/PNz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pdCDUyd8; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S429iP041030;
	Mon, 27 May 2024 23:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716868929;
	bh=7o5xZejU8GZnlz4grUA7u5BI/1wdELyrdB+AeysAwMY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pdCDUyd8e7wv+IlE9oniHd6vNfvBelZ6f8xx5TEEEi5HysUe35hSkAmEbTKVm/Qve
	 iROHIXgQGTGP7FqSXfn4BQO7CtZkESjOI0zkEFHnWVEyurJtmlHhgKqUENy5McdBxH
	 INf11QVEtAvLla9qcMDa41/YEGyg/z08XAY0qRVc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S429vK018987
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 23:02:09 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 May 2024 23:02:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 May 2024 23:02:09 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S420P0028431;
	Mon, 27 May 2024 23:02:05 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v3 1/3] arm64: dts: ti: k3-am68-sk-base-board: Add LP8733 and TPS6287 nodes
Date: Tue, 28 May 2024 09:31:57 +0530
Message-ID: <20240528040159.3919652-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528040159.3919652-1-n-francis@ti.com>
References: <20240528040159.3919652-1-n-francis@ti.com>
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
 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index d743f023cdd9..90dbe31c5b81 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -414,6 +414,82 @@ &wkup_uart0 {
 	pinctrl-0 = <&wkup_uart0_pins_default>;
 };
 
+&wkup_i2c0 {
+	bootph-all;
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	status = "okay";
+
+	lp8733: pmic@60 {
+		compatible = "ti,lp8733";
+		reg = <0x60>;
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
+	tps62873a: regulator@40 {
+		compatible = "ti,tps62873";
+		reg = <0x40>;
+		bootph-pre-ram;
+		regulator-name = "VDD_CPU_AVS";
+		regulator-min-microvolt = <600000>;
+		regulator-max-microvolt = <900000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	tps62873b: regulator@43 {
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


