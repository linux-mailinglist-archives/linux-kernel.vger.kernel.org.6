Return-Path: <linux-kernel+bounces-520112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFCFA3A5D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26D93A3B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780F31EB5D6;
	Tue, 18 Feb 2025 18:38:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9626E170
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903916; cv=none; b=es+zUlIixmH3Al+GOm4Uf63zDbBrOfYSO8xZ6SHRSpBpFidg/vPcYf0pPvM8W4+lTOvXEizPZVGK4cqki3N6kdadyel13t1fGUPTVKpKu07OnElEppxSymer8CfX+44k8wuRyiPslEyTjbHww0DELovkqWOmFBnh1FqnY2OZkIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903916; c=relaxed/simple;
	bh=BYhE08cI7plNbh3BneNXgg76j/4lo/JpVzjRzc8cg3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=suH6OyjWRjak35D6jlHBsAY8OvCvhv51+MTSVlAZ7giHDKKUnFPO6EL/VD3nI1jeKsTskysDu/2A48HkWM54GuVY6s+ssVbnxBpLa4JL7yBhZPLy5HaGPYfD/+Ngfzqgn8fO4Jvc4tYWtfA31RV8S5KaqjXWvLlkdODUdaEn9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSU2-0000Gw-OG; Tue, 18 Feb 2025 19:38:14 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSU2-001dal-1J;
	Tue, 18 Feb 2025 19:38:14 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSU2-00AL9G-13;
	Tue, 18 Feb 2025 19:38:14 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Tue, 18 Feb 2025 19:38:15 +0100
Subject: [PATCH v2 3/6] arm64: dts: imx8mp-skov: move I2C2 pin control
 group into DTSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-skov-imx8mp-new-boards-v2-3-4040379742ea@pengutronix.de>
References: <20250218-skov-imx8mp-new-boards-v2-0-4040379742ea@pengutronix.de>
In-Reply-To: <20250218-skov-imx8mp-new-boards-v2-0-4040379742ea@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

I2C2 is exposed on a pin header on the base board, so its pinmux is
always the same if it's enabled.

Therefore, move the definition to the common DTSI, so board DTs only
need to override the status to enable it.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi          | 12 ++++++++++++
 .../boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts   | 11 -----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi
index e39674457b4f92a94e40a1a3700745b038cebfb4..b1dfd8eb7062ae5e736146458833a11c4d37eb7b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi
@@ -331,6 +331,11 @@ reg_nvcc_sd2: LDO5 {
 	};
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+};
+
 &i2c3 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -562,6 +567,13 @@ MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA				0x400001c2
 		>;
 	};
 
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL				0x400001c2
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA				0x400001c2
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL				0x400001c2
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts b/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts
index 2c75da5f064f2b0cd97f5040febac13c4adc020b..ba581765b52298ea26a5a63079c08f39f10e4e3b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-skov-revb-mi1010ait-1cp1.dts
@@ -27,8 +27,6 @@ &backlight {
 
 &i2c2 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
 
 	touchscreen@38 {
@@ -90,12 +88,3 @@ &reg_tft_vcom {
 	voltage-table = <3160000 73>;
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL				0x400001c2
-			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA				0x400001c2
-		>;
-	};
-};

-- 
2.39.5


