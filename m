Return-Path: <linux-kernel+bounces-233642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD68A91BA9D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943AA285321
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6831534E6;
	Fri, 28 Jun 2024 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="P3M/44Po"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC41514DC;
	Fri, 28 Jun 2024 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565175; cv=none; b=OQmqt48wEmljHYKFgQZRh+KiP9uqlJtt8X+YDz7CmyDNanUpGX3acv3pajUzzu/GglDpT8zqJWpNurTscaKZc5jTtXidBi3XBv3KTVWMn68aoY5KDYGkPfh7d5C3zwvFAqETfc0rET2aScFpjIWQtQ+53zEk9oV+sDltzoChle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565175; c=relaxed/simple;
	bh=eKmEApCLtrBXoEas0MfyfelglNHo/OxwLXCHMlRaR9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWJF2/My2Gaw3KWui1GaFSsl8/S+WyU+SkS3CNlCXcGvfyFQDzsyZCrDaL5OiRuGsQf44IO4zA4ugGDpk3styoCMwNDEkD6Ys0X8+2BXCaOD1VpKYaWxyuiD9wkgiD+6TVzXxrZ/2IUIB63r8KeOKTVGb7Pha1slByJuiE407ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=P3M/44Po; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S118of023905;
	Fri, 28 Jun 2024 10:59:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	KZgWttku0OrDv1E5xjjSYd/Hd42fWLcFhwhUgXT4EB4=; b=P3M/44PoIDL1suJP
	i65AUpyBxkZYT97XQVPoorppLfIXee1fke/WYu246bSGVIqns65jXebh0qfl9ONo
	Ul0cvsyd2vHAJoYOlBr+5lQXquVli/Lsh40wFFsw0s+YED7WMl7rFcBZC2hXT1P5
	SngCh3VHQ+1YqNhNS6a7MCwNanm0ikczQpIeOpKz2Hptz+kOd90/RiIK/vq/P1G0
	XvM6pl+2uFGxh3qFqfpPTSNiNSKDqM3PpBBayzOjvUdbby9yj8UScrShH6gKX3fz
	o+Sdd/zWGkBG8xoNjJDC+NHymLKM16hnC+9vK1+Ez02zH4iDnVn5xs3KdGTLxC1n
	fz2Hlg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywngdrmcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 10:59:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 242E840046;
	Fri, 28 Jun 2024 10:59:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7FD1421ADA7;
	Fri, 28 Jun 2024 10:58:22 +0200 (CEST)
Received: from localhost (10.252.26.109) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 28 Jun
 2024 10:58:21 +0200
From: Pascal Paillet <p.paillet@foss.st.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC: <p.paillet@foss.st.com>, Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH v2 3/4] arm64: dts: st: describe power supplies for stm32mp257f-ev1 board
Date: Fri, 28 Jun 2024 10:58:13 +0200
Message-ID: <20240628085814.1586186-4-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628085814.1586186-1-p.paillet@foss.st.com>
References: <20240628085814.1586186-1-p.paillet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_05,2024-06-28_01,2024-05-17_01

Describe power supplies for stm32mp257f-ev1 board.

Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 43 +++++++++++++++++-----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 18c6266532b2..979847e0ea05 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/st,stm32mp25-regulator.h>
 #include "stm32mp257.dtsi"
 #include "stm32mp25xf.dtsi"
 #include "stm32mp25-pinctrl.dtsi"
@@ -41,14 +42,6 @@ fw@80000000 {
 			no-map;
 		};
 	};
-
-	vdd_sdcard: vdd-sdcard {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_sdcard";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
 };
 
 &arm_wdt {
@@ -56,6 +49,37 @@ &arm_wdt {
 	status = "okay";
 };
 
+&scmi_regu {
+	scmi_vddio1: regulator@0 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+	scmi_vddcore: regulator@11  {
+		reg = <VOLTD_SCMI_STPMIC2_BUCK2>;
+		regulator-name = "vddcore";
+	};
+	scmi_v1v8: regulator@14  {
+		reg = <VOLTD_SCMI_STPMIC2_BUCK5>;
+		regulator-name = "v1v8";
+	};
+	scmi_v3v3: regulator@16 {
+		reg = <VOLTD_SCMI_STPMIC2_BUCK7>;
+		regulator-name = "v3v3";
+	};
+	scmi_vdd_emmc: regulator@18 {
+		reg = <VOLTD_SCMI_STPMIC2_LDO2>;
+		regulator-name = "vdd_emmc";
+	};
+	scmi_vdd3v3_usb: regulator@20 {
+		reg = <VOLTD_SCMI_STPMIC2_LDO4>;
+		regulator-name = "vdd3v3_usb";
+	};
+	scmi_vdd_sdcard: regulator@23 {
+		reg = <VOLTD_SCMI_STPMIC2_LDO7>;
+		regulator-name = "vdd_sdcard";
+	};
+};
+
 &i2c2 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c2_pins_a>;
@@ -85,7 +109,8 @@ &sdmmc1 {
 	disable-wp;
 	st,neg-edge;
 	bus-width = <4>;
-	vmmc-supply = <&vdd_sdcard>;
+	vmmc-supply = <&scmi_vdd_sdcard>;
+	vqmmc-supply = <&scmi_vddio1>;
 	status = "okay";
 };
 
-- 
2.34.1


