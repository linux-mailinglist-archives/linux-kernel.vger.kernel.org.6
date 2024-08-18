Return-Path: <linux-kernel+bounces-291203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F661955EE9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 22:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB15281421
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 20:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C7A153BF6;
	Sun, 18 Aug 2024 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="bWqGHEY4"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618AF14AD3F;
	Sun, 18 Aug 2024 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724012895; cv=none; b=nenoyV2kZDx6exYKfNDFP6SIKvMwL7zbJ5b8R33WuwzQketYnT5YK7PqtZJFCKHAQBFvzF08IXfuRDQK3jS/snWpr2BJO1oI2xebWYsd4481IOkSwqqGmUKpBX/3MqNqD6x7epj+co38iTD1kLXECjAUhV1zZLHKcoUEaZxw29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724012895; c=relaxed/simple;
	bh=mrTl5Fy54DzIqsxJSZmVNlUNf7SoFisVoxkcnuE0KWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+beNe/ANYiobgd+IyeiIwpBYO+eUFZzG7LAKfAN3n0ATuRn35bCw6FH3ZdVU0btgKAqCP9lTLDNRPO96Kq6PK9TDnsnAwX/rucycNNjCpUIlTu1nbP0qcywAO/9U+StS2DHkUkyfWLrQocf1QjrebW9q7vHfhP9RtfVv8buZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=bWqGHEY4; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6154D88327;
	Sun, 18 Aug 2024 22:28:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724012892;
	bh=FkfPtdcQiYhj7HdTnX+0yBybZvMFrEkDvwctQGZVFJE=;
	h=From:To:Cc:Subject:Date:From;
	b=bWqGHEY4sF50b3bjZ4beTppLJnk6gqNdyfKQ/VpnGDDlHewSiIvSO7C0FEy5LmGls
	 evkQWZCH9DeDaRPqR82q0PQguoNxw1ZFY/0EHviq2tTYFMdumV+cjJE/pnJT9qVo1k
	 Zxc3oAxvY/ct7633aIOYo+ciZDMFd8aJh27nDwRl5F9NKknM5lLUFL2FcQjxGvqud6
	 JdYDWg5zg3X101wJt5hJhDM9CKeeOnU0ykQUIDbYAoZtJ7jqz/GanpMRhuzNGR08HI
	 RS+Nq0hz6utTmRZrvduVRl+jSCXRQsU5Cg/bNn8Ic6SqEScgMuzVf2hgPCRDS+tobB
	 vFq3uVyD0PsnQ==
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
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp: Enable HDMI to Data Modul i.MX8M Plus eDM SBC
Date: Sun, 18 Aug 2024 22:27:10 +0200
Message-ID: <20240818202741.95967-1-marex@denx.de>
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

Enable HDMI support on Data Modul i.MX8M Plus eDM SBC.

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
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 .../freescale/imx8mp-data-modul-edm-sbc.dts   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
index 837ea79741e8d..d0fc5977258fb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
@@ -59,6 +59,18 @@ clk_pwm4: clock-pwm4 {
 		pwms = <&pwm4 0 83 0>;
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "J17";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	panel: panel {
 		/* Compatible string is filled in by panel board DT Overlay. */
 		backlight = <&backlight>;
@@ -311,6 +323,33 @@ &gpio5 {
 		"", "SPI3_CS#", "", "", "", "", "", "";
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
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default", "gpio";
@@ -681,6 +720,13 @@ MX8MP_IOMUXC_SPDIF_TX__CAN1_TX			0x154
 		>;
 	};
 
+	pinctrl_hdmi: hdmi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x154
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x154
+		>;
+	};
+
 	pinctrl_hog_feature: hog-feature-grp {
 		fsl,pins = <
 			/* GPIO5_IO03 */
-- 
2.43.0


