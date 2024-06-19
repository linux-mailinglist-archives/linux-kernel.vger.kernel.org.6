Return-Path: <linux-kernel+bounces-220712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C8190E5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3761C214AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39BD7E78E;
	Wed, 19 Jun 2024 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EdVWQYzE"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385D37CF3E;
	Wed, 19 Jun 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786249; cv=none; b=P0sDTBf1bEF5XH1wCrfZPp1/LB5lcLqM+dbusgarMJ8oClux0jNG38kh4yUEpzCr2wVR9Kvm56RL78VVGORIK8n9ECG3izQxdnJ0h0nrh+Nq4sFfBxB2EiVuDanCZsTtM71jltM3H77me9Rid9W/McnaX6LqEfes3proDQFPjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786249; c=relaxed/simple;
	bh=eKmEApCLtrBXoEas0MfyfelglNHo/OxwLXCHMlRaR9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFRi+eje0GdGFs+NNAikm2wu6+KvUYU3+TjWawmAnyVQMHKtfJTJ0X1z22hrzNDn8zmlOOmctbIepMki4m9UhgQz2FR0lUEvwaIpksRZH9QQ7tT9+kQ0uDgnvLjhm/yRsBrrFLhER6WctoQalZ73kz9Sys9NP6Bph/i7U1kU1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EdVWQYzE; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J7K3mP024133;
	Wed, 19 Jun 2024 10:37:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	KZgWttku0OrDv1E5xjjSYd/Hd42fWLcFhwhUgXT4EB4=; b=EdVWQYzE58jbs3eY
	mhWhlVnXlT4cXbWtBWFaRSIi0qWJaArKvjGY8iWUE8eNWXnwi+Fv00fmQudYqIXs
	HWqB4bxluUNG3aIBIndNXD6vLK0+SU/YodE96Cmi7N205Pni0L28ogT0JRR3NiM/
	3Jk3faKpAgd1BKe2qySBfF+lS5oUQ/4BsFCNltdO6XQoBg8hWbgwrN6EzL5zxD1Q
	CMT0Mq1xCS2D+PL61JZLVlAMkOp40w6pB+49fYEHfQsP2mR8zjtDtUVuYIDheSI7
	t4m8/G7e9GZuN8kRyZx6BlaAkciMecmacl7TDNDUmNOZNMtDo3zQ+90Eq4R3k7zz
	LFtvPA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9n23xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 10:37:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6FC9A4004A;
	Wed, 19 Jun 2024 10:36:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6344E210590;
	Wed, 19 Jun 2024 10:36:12 +0200 (CEST)
Received: from localhost (10.48.86.232) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 19 Jun
 2024 10:36:12 +0200
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
Subject: [PATCH 3/4] arm64: dts: st: describe power supplies for stm32mp257f-ev1 board
Date: Wed, 19 Jun 2024 10:36:01 +0200
Message-ID: <20240619083602.33007-4-p.paillet@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619083602.33007-1-p.paillet@foss.st.com>
References: <20240619083602.33007-1-p.paillet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01

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


