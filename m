Return-Path: <linux-kernel+bounces-178230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74EA8C4AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C0B1C22B78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE9A17FF;
	Tue, 14 May 2024 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Uf9gQv3T"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F797ED8;
	Tue, 14 May 2024 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648854; cv=none; b=U0M1daqSfHwuAsDD78gQRrtRQnXNC7ii0sMhRBQy5JSloeR1WN3PnSRF9TA9k/+UCaKLJ7SeGwoZOTVU6RnxQTlTus6DXTbJLlRsUC3JAJgL0x4zOsVYpts3gKy8bBcUH5u2k6s81CWxbn/dh7jJ5l9hcLFwm9tZ+tisNIlDPJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648854; c=relaxed/simple;
	bh=f3uKJl77S3XOtyuC/S9DUc5g9aTtxON73vg/NMUwG8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdPF3fXoyWS0naklc4zXNMqkoUXQ0gPs492G0u69+oLiWwNp+JmiUfRanHBAanQvzuYd/Z5vGT2ujp8RAwkULGe62BVOaRC4mD4Wx2tsurxDz64iTl6arRAFIV29Z8uLIw2lvWqaPaN7ZTbw6WkiAZc/xKHfwCHOYqLSM5DEJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Uf9gQv3T; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D24AF87CDA;
	Tue, 14 May 2024 03:07:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715648848;
	bh=xa8qPwKZOCPA6/bJm4wN473IAF5TnUbKp0w2XO2euGc=;
	h=From:To:Cc:Subject:Date:From;
	b=Uf9gQv3TS2ZdvuTL4ueqYusy6VjZooHp2Umwz+LKpfP67fFq7AeUWlf5nxC7JquMa
	 WCvnBbF6UH9Ek4d7p2tT+hiZIWQVcCgZS8li7GrHQwexqLYMLYxF+ETX9a2a4UP+ky
	 QdB0Ef/gHRzHBilbVNWBEzcSO6zxFaAIpLc3aDGq9WoYGErUK4H3p20CyJuHnGNdOP
	 QSfdguK/iOhK7hcN9cZeiApKO1NcDl/Jth2UduaKWh5H0fOyH4frlJZkG0YQuOuMdn
	 T9d853XIJidH0Bft89HtfVa8z10rjMuSJqc+bL9JsvEVwmyKOWP1ucYtkHzO13NaMB
	 SKF4O9kEzJnfg==
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp: Enable HDMI on i.MX8MP DHCOM PDK2 and PDK3
Date: Tue, 14 May 2024 03:06:42 +0200
Message-ID: <20240514010706.245874-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Enable HDMI output on i.MX8MP DHCOM PDK2 and PDK3. The I2C5 on PDK2 and
I2C mux port 1 on PDK3 respectively are used in regular I2C mode instead
of HDMI DDC mode to permit connection of other I2C devices on those buses.
The pinctrl_hdmi node is part of the SoM DTSI already.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: kernel@dh-electronics.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 .../boot/dts/freescale/imx8mp-dhcom-pdk2.dts  | 39 +++++++++++++++++++
 .../boot/dts/freescale/imx8mp-dhcom-pdk3.dts  | 39 +++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dts b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dts
index 3b1c940860e02..ebdf13e97b4e2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dts
@@ -69,6 +69,18 @@ button-3 {
 		};
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "X38";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	led {
 		compatible = "gpio-leds";
 
@@ -184,6 +196,33 @@ &flexcan1 {
 	status = "okay";
 };
 
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	ddc-i2c-bus = <&i2c5>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&lcdif3 {
+	status = "okay";
+};
+
 &pcie_phy {
 	clock-names = "ref";
 	clocks = <&hsio_blk_ctrl>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk3.dts b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk3.dts
index ac7ec7533a3c8..ef012e8365b1f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk3.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk3.dts
@@ -75,6 +75,18 @@ button-3 {
 		};
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "X28";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	led {
 		compatible = "gpio-leds";
 
@@ -248,6 +260,33 @@ &flexcan1 {
 	status = "okay";
 };
 
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	ddc-i2c-bus = <&i2cmuxed1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&lcdif3 {
+	status = "okay";
+};
+
 &pcie_phy {
 	clocks = <&pcieclk 1>;
 	clock-names = "ref";
-- 
2.43.0


