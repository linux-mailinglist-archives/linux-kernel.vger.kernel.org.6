Return-Path: <linux-kernel+bounces-253484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDA69321F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8714428286F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3967B17D36C;
	Tue, 16 Jul 2024 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jbeXH7k9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jbeXH7k9"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E20142E9D;
	Tue, 16 Jul 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119089; cv=none; b=EKwtgfi16oplMb0f6eFzrL9JD5gHzVq56/s2APtOhtpySM1Tv/rsT8Tlk7PQ+LcDHUzkGIO71BZvokdOKfkPiTS/1GDLXkOTixeZ/Iv65SAe+jVgLPH7GehfT5NwSXH5eUiNW3vIp8IrLFmGMg1+K3zFeT3IE5ZWsXBUwo5QPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119089; c=relaxed/simple;
	bh=h8o3oRHmLl/azwP+hpM8aQmxsMBmeviL+0DH7hM8/js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hhiJ5z+094BD6JE5wlOrtdpakZWwTeAlNsldT0tqgHAs3wn3xWJlmDxWvYon0PaGjs/k1D5iGPpahZ8qF9lcn9OclsOUIzPCX51rpm5O3x5QeV57IN4IaLB6w2ol/DnmL8rZ6Y85rLBczAuwcg+suL/vi6i+GyAO6agw892TxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jbeXH7k9; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=jbeXH7k9; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WNXWw5Jzpz9sVN;
	Tue, 16 Jul 2024 10:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721119084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ow+QdwIrgyh8EvIaH+qkUT5SOVpYbVc8f2Oz9+7S0Cg=;
	b=jbeXH7k9JqKT3QrM2Q6d12suCfHzCxiTvjNc4NGyLb3eZn/n4zZ/4t33lGJPs2pOu5fUX0
	lEfD3gKgeiNcTA/odlFIs1zkf2dHmh8xUH6PGSghZfhYSnAUzyTGgRLZUG+Tvm8sA33vnF
	4+2fvuS/TSbOmK135gOAN8l2mN45lEGzODrKCE5Vt5a7qmjgk7V26huXrRhkoYJlDF/tX5
	Wc49bjWaAMIHpTMc97YoX64YsjZFi4f74KBzXW4Y8hQ8BGALArF+hYO7c/rucPiRxyHXMS
	Qrr3j34DnlJfqm5xIBIN6/RKWP4NdEYphUEjTVa2wXB0Kxm7yPf7bU3SbxoqWw==
From: Christopher Wecht <cwecht@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1721119084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ow+QdwIrgyh8EvIaH+qkUT5SOVpYbVc8f2Oz9+7S0Cg=;
	b=jbeXH7k9JqKT3QrM2Q6d12suCfHzCxiTvjNc4NGyLb3eZn/n4zZ/4t33lGJPs2pOu5fUX0
	lEfD3gKgeiNcTA/odlFIs1zkf2dHmh8xUH6PGSghZfhYSnAUzyTGgRLZUG+Tvm8sA33vnF
	4+2fvuS/TSbOmK135gOAN8l2mN45lEGzODrKCE5Vt5a7qmjgk7V26huXrRhkoYJlDF/tX5
	Wc49bjWaAMIHpTMc97YoX64YsjZFi4f74KBzXW4Y8hQ8BGALArF+hYO7c/rucPiRxyHXMS
	Qrr3j34DnlJfqm5xIBIN6/RKWP4NdEYphUEjTVa2wXB0Kxm7yPf7bU3SbxoqWw==
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christopher Wecht <cwecht@mailbox.org>
Subject: [PATCH] arm64: dts: freescale: imx8mp-phyboard-pollux-rdk: add HDMI support
Date: Tue, 16 Jul 2024 10:36:35 +0200
Message-Id: <20240716083635.626596-1-cwecht@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 072d6153867c17ad5d9
X-MBO-RS-META: 4k3pbw9cnfn889ay8kianab16t8kpfnk
X-Rspamd-Queue-Id: 4WNXWw5Jzpz9sVN

Enable the HDMI output on the phyBOARD Pollux, using the HDMI encoder
present in the i.MX8MP SoC.

Please note that lcdif3 has not bee enabled. This is due the fact
that as of now either HDMI or LVDS may be enabled. If both are
enabled it won't worked. With this patch, however, HDMI can be
enabled by turning ldcif3 on and ldcif2 off.

Signed-off-by: Christopher Wecht <cwecht@mailbox.org>
---
 .../freescale/imx8mp-phyboard-pollux-rdk.dts  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 00a240484c25..3ea67bada2c1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -101,6 +101,18 @@ reg_vcc_3v3_sw: regulator-vcc-3v3-sw {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
 };
 
 &eqos {
@@ -127,6 +139,38 @@ ethphy0: ethernet-phy@1 {
 	};
 };
 
+
+/* HDMI */
+&irqsteer_hdmi {
+	status = "okay";
+};
+
+&hdmi_blk_ctrl {
+	status = "okay"";
+};
+
+&hdmi_pvi {
+	status = "okay"";
+};
+
+&hdmi_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	status = "okay"";
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
 /* CAN FD */
 &flexcan1 {
 	pinctrl-names = "default";
@@ -346,6 +390,15 @@ MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21	0x154
 		>;
 	};
 
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL     0x400001c3
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA     0x400001c3
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD         0x40000019
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC         0x40000019
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
-- 
2.34.1


