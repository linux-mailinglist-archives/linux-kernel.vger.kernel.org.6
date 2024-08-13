Return-Path: <linux-kernel+bounces-284710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739D4950457
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3132B2880A0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5AF1991D6;
	Tue, 13 Aug 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="fl53sCSa"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A41990A2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550555; cv=none; b=kzMsaeGpvSUFseK4iPa7xSQ/LSvtezE7lVWGFNPVv0TO2yTE9buSvH/zQvCcnDeYuO+c2eAdWeCJzyXfwdO7+BsiDzjQhZY929VeSKZoKO6++fEMpb3vjTCyjgkG1MK7CjbG7X90UaH8zuPGHjdiJQZ59yFdCpmUk5N2Uc6vAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550555; c=relaxed/simple;
	bh=SCEjQ2f/AVQGw13+jnl/qj3hrJi2gyjF3kjKwUvF/08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=kAQkd8wE8FPEBE/tjYCYqYVvPIECeV8m69jf1Umngl0/veYVfbztQ10nYGAlsuPLLew4jIWtf8QXtNqD7KdBEXrBuIDkNdYqR+2xTM4vFZonk7QxHrwU9+TzT0v7oV7gIAhTcvYFKt48hbExgbp3tehs6buQD1QgvVO/Evg0moc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=fl53sCSa; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723550541; x=1726142541;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SCEjQ2f/AVQGw13+jnl/qj3hrJi2gyjF3kjKwUvF/08=;
	b=fl53sCSaEuQ4Rv+Q5YD0VX8Xv00qj4R7GoM0gGERibVWTjy4wXgL944uLDGNzukG
	MvWd1bFZiwxyhnvDQ0eA4bsD/bxh+e3grGvfhFwkbOWLzCMmsAmboSIGfGusAOPR
	P/gIsqmXtdu5QvWAFJ6plLvunNnhTqoBRFLZZ2NiC98=;
X-AuditID: ac14000a-03e52700000021bc-3e-66bb4b4c5236
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7F.20.08636.C4B4BB66; Tue, 13 Aug 2024 14:02:20 +0200 (CEST)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 13 Aug
 2024 14:02:20 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 13 Aug 2024 14:02:14 +0200
Subject: [PATCH] arm64: dts: imx8mp-phyboard-pollux-rdk: Add support for
 PCIe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240813-wip-bhahn-add_pcie_support-v1-1-c1bb062b4e1f@phytec.de>
X-B4-Tracking: v=1; b=H4sIAEVLu2YC/x3MSwqDMBAA0KvIrDvgF7VXKSUkmbGZTRwSq4J49
 4Yu3+ZdkDkJZ3hWFyTeJcsaC5pHBT7Y+GEUKoa2bvt6ajo8RNEFGyJaIqNe2OSv6po2dLOjcVh
 8T/MEJdDEi5z//PW+7x9FLPILbAAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Teresa Remmet
	<t.remmet@phytec.de>
CC: <upstream@lists.phytec.de>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Benjamin Hahn <B.Hahn@phytec.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723550540; l=2384;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=SCEjQ2f/AVQGw13+jnl/qj3hrJi2gyjF3kjKwUvF/08=;
 b=/0dWgUE99fI6jHFjyRx/49dTec+RsfkxbJuGEClIRp2/pJ4Jzlc+L58U6EP4eHq2V2cbHOyCP
 3pE9XgdTSedCQDNvkUSg2ZNy/p3fFqqsdHukeRMr2esiO0lHmU6Ui3l
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42JZI8nAo+vjvTvNYPptE4s1e88xWcw/co7V
	4uFVf4uZ91rZLFZN3cli8XLWPTaLTY+vsVpc3jWHzeL/nh3sFn+3b2KxeLFF3KL7nboDj8fO
	WXfZPTat6mTz2Lyk3uPF5pmMHv3dLawe/X8NPD5vkgtgj+KySUnNySxLLdK3S+DK2PLxO3vB
	JaGKdfPusjYw7uTvYuTkkBAwkWh4eJ+xi5GLQ0hgCZPE/L7vTBDOQ0aJPfMbWECq2ATUJHa9
	ec0KYrMIqEp0tyxiBLGFBfwlXvc+ZQKxeQUEJU7OfAJUz8HBLKApsX6XPkiYWUBeYvvbOcwg
	YV4BX4n7KwNAxksI7GGUWDnrNjtIjYjADiaJx/2GIAlmgYOMEn/WP2CHuE5Y4vPuNWwQ9m4m
	iY19HiCDJAQSJXa+lgMJCwnIStw8vwWqRF5i2rnXzBB2qMSRTauZJjAKz0Jy3SyE62YhuW4B
	I/MqRqHczOTs1KLMbL2CjMqS1GS9lNRNjKAIE2Hg2sHYN8fjECMTB+MhRgkOZiUR3kCTXWlC
	vCmJlVWpRfnxRaU5qcWHGKU5WJTEeVd3BKcKCaQnlqRmp6YWpBbBZJk4OKUaGG2qHHak7rCU
	lkgQnX3wtOLltr4pzX9O9qzXDtsw89r2ui2fHZr/rvg8YeLiKuNp4m3H5Fu4b35uvv7o4aeW
	pwp72GXlKy7HcRlO+X/FY0GZXZmwR9rtiBdqr6Umxz1/cPdin8y+y6nvXOvcI+xDbSfKbs/n
	nfvdc/qrK6vVemrNxR2Z/eYLnlZiKc5INNRiLipOBABfkb6CngIAAA==

Add support for the Mini PCIe slot.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 00a240484c25..0ecb2f62c37f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/phy/phy-imx8-pcie.h>
 #include <dt-bindings/leds/leds-pca9532.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "imx8mp-phycore-som.dtsi"
@@ -63,6 +64,17 @@ reg_can2_stby: regulator-can2-stby {
 		regulator-name = "can2-stby";
 	};
 
+	reg_pcie0: regulator-pcie {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcie0_reg>;
+		regulator-name = "MPCIE_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_lvds1_reg_en: regulator-lvds1 {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -195,6 +207,23 @@ &snvs_pwrkey {
 	status = "okay";
 };
 
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+	fsl,clkreq-unsupported;
+	clocks = <&hsio_blk_ctrl>;
+	clock-names = "ref";
+	status = "okay";
+};
+
+/* Mini PCIe */
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie0>;
+	status = "okay";
+};
+
 &pwm3 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -366,6 +395,19 @@ MX8MP_IOMUXC_SD2_WP__GPIO2_IO20		0x12
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11	0x60 /* open drain, pull up */
+			MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08	0x40
+		>;
+	};
+
+	pinctrl_pcie0_reg: pcie0reggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14	0x40
+		>;
+	};
+
 	pinctrl_pwm3: pwm3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SPDIF_TX__PWM3_OUT		0x12

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240813-wip-bhahn-add_pcie_support-b9bd75fc4d98

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>


