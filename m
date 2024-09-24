Return-Path: <linux-kernel+bounces-336730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68567983FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0F62869E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2E014A617;
	Tue, 24 Sep 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="UQeuz0hI"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC52149E17
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165305; cv=none; b=FC8tRAosA1mv7UKyWaqDHQ8O5SE8JcOfZ9/aKUNSvtIMiSS+rnp3ZYgUkN51VF0hG8BVqvI/kTIk9vyYefWhRZcTMbV7JqwIjHBY1D4x7eG2Mbx1mdceJVeNR7ISvEZSZ4mtZBZP5m+2c93WWMTLuBY929c6YT+bk2eRXoiLZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165305; c=relaxed/simple;
	bh=Y/6F/P6GI6Ued+q693i0Z0AROnyWZBqqJ5etygwM6B8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=J/gogeZjaVnzP3IGXI4KRRPTzYpUyKyI7OtoE/4U2FbztptFecQLiq21VsejLsjAHETikE5kTufww69nny1eaqnhaxntN4QAOVF/8u2RYrWf1k4RYNzSQPXWTiHiA9JQ6L8kUU+D37I3IlvahuH4bM5OO2W8IfmzBcyCghUaRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=UQeuz0hI; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1727164392; x=1729756392;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y/6F/P6GI6Ued+q693i0Z0AROnyWZBqqJ5etygwM6B8=;
	b=UQeuz0hIRX//UXsL577pdlFCEpXr57yk/76Xpz16xqPCMwuBi995S13EhfjD5NqZ
	b2ZyVQ0Pxrrk3Pv9RkPmPZd0KYx1qsm/ACTHsPK52N7oZ3zo+DdZuetmvhi/+XPR
	hWIVBrAZhS+M+y02VBo85wcLM8jUTXEXRR56j9QUD9Y=;
X-AuditID: ac14000a-4637f70000004e2a-24-66f26fe89aa5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 65.25.20010.8EF62F66; Tue, 24 Sep 2024 09:53:12 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 24 Sep
 2024 09:53:12 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 24 Sep 2024 09:53:04 +0200
Subject: [PATCH] arm64: dts: imx8mp-phyboard-pollux-rdk: add gpio-fan
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240924-wip-y-moog-phytec-de-phyboard-pollux-fan-v1-1-9ea6ec43f27b@phytec.de>
X-B4-Tracking: v=1; b=H4sIAN9v8mYC/x2NywrCMBAAf6Xs2YW4iBJ/RTyk2W27ULMh8dFS+
 u9GbzOXmQ2qFJUK126DIm+taqnJ8dBBnEIaBZWbAzk6OU8OP5pxxYfZiHlanxKR5Ue9hcKYbZ5
 fCw4hoYtMns9Mvb9Ay+Uigy7/1e2+71/8lcKWegAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWyRpKBR/dF/qc0g6Nb5SzW7D3HZDH/yDlW
	i4dX/S1m3mtls1g1dSeLxctZ99gsNj2+xmpxedccNov/e3awW/zdvonF4sUWcYvud+oOPB47
	Z91l99i0qpPNY/OSeo8Xm2cyevR3t7B69P818Pi8SS6APYrLJiU1J7MstUjfLoEro3vRAtaC
	V4IV8+/FNjBO5+ti5OSQEDCReNnRzd7FyMUhJLCESWLe2W+MIAkhgYeMEtsmGYHYbAIqEo9f
	3GMFsVkEVCXOTmthB7GFBVwlXiyeCmbzCghKnJz5hKWLkYODWUBTYv0ufZAws4C8RPPW2cwQ
	JdESN8+eYwLZJSFwglFi/+Q9jCCOiMAkJomj104wQnTsZ5SYeysJ4jphic+717BBHCQr8eJ8
	LztEXF5i2rnXzBB2qMTWL9uZJjAKzkJyxyyEO2YhuWMBI/MqRqHczOTs1KLMbL2CjMqS1GS9
	lNRNjKCIEWHg2sHYN8fjECMTB+MhRgkOZiUR3kk3P6YJ8aYkVlalFuXHF5XmpBYfYpTmYFES
	513dEZwqJJCeWJKanZpakFoEk2Xi4JRqYLTdrZilXm65/cUEpZK5lvOqmr6snlYxkf/HOxHW
	F/Mz9XcX7FNuaM68lnXg79Ow3Vsbbn/7vD/88w6lm881CwJ7s02l769WPRnqnxbxJeh70+Z7
	zD2eyc/l/V9/jFzgvjT5x9dEJqZXOsnGt4SdN2yKFP6SUjwhxnaxYc6eAMsLRxe+ztvPp6PE
	UpyRaKjFXFScCAABnFQRhgIAAA==

A GPIO fan may be connected to Pollux fan header. The fan should
activate at 60°C and stay active until critical SoC temperature is
reached and the board shuts down.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 50debe821c42..9b551a50533f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -9,6 +9,7 @@
 #include <dt-bindings/phy/phy-imx8-pcie.h>
 #include <dt-bindings/leds/leds-pca9532.h>
 #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "imx8mp-phycore-som.dtsi"
 
 / {
@@ -32,6 +33,16 @@ backlight_lvds: backlight {
 		pwms = <&pwm3 0 50000 0>;
 	};
 
+	fan0: fan {
+		compatible = "gpio-fan";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_fan>;
+		gpio-fan,speed-map = <0     0
+				      13000 1>;
+		gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
+		#cooling-cells = <2>;
+	};
+
 	panel1_lvds: panel-lvds {
 		compatible = "edt,etml1010g3dra";
 		backlight = <&backlight_lvds>;
@@ -111,6 +122,25 @@ reg_vcc_3v3_sw: regulator-vcc-3v3-sw {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	thermal-zones {
+		soc-thermal {
+			trips {
+				active1: trip2 {
+					temperature = <60000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+			};
+
+			cooling-maps {
+				map1 {
+					trip = <&active1>;
+					cooling-device = <&fan0 1 THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
 };
 
 /* TPM */
@@ -377,6 +407,12 @@ MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20			0x10
 		>;
 	};
 
+	pinctrl_fan: fan0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__GPIO5_IO04       0x16
+		>;
+	};
+
 	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI5_RXD2__CAN1_RX		0x154

---
base-commit: 79e1b8171ca476abb9b8eceef81cd1b6f58b75e9
change-id: 20240920-wip-y-moog-phytec-de-phyboard-pollux-fan-0cd29d6d2b97

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>


