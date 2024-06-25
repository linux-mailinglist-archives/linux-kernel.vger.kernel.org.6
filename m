Return-Path: <linux-kernel+bounces-228318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CA1915E13
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481D51C2227A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EEB145A15;
	Tue, 25 Jun 2024 05:14:34 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F84144D3B;
	Tue, 25 Jun 2024 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719292473; cv=none; b=eb1jA+GzzbZbHiM3/rgoq9fkhMbNMXvNA6Ky/U8iNu+6r4qlTg31ww9AbsaC7mJU/y56HUYV/u7HJxmp8n48OlQsXZsTJpsUZC0tDrx4gtVgWK/VDL5MgWbz5u/9c/x4CQ7jFKgknmrL25ee++rskDs+jVD9P0sDc3EVQh8YBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719292473; c=relaxed/simple;
	bh=JumFjepAK5BceEeoilJQ1Y3XfINuUODu8VGkkHsJI0E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=tHV4DegMXmP3MQ5IsZlHqHJUNyQhbs2Hy75LG+h5w+uXE86K/3fmYlKmE+WfCzeVNuOhgIzSOewE7aliwGDrySu6yWr/kAQ3Y7JSNU61nSNebrXmLNy7I2TnbQQhAjflqIk4sv4IRAXuHg3W1UjwkHIbLegYy1OscIOWZkhBJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C0D21A04F8;
	Tue, 25 Jun 2024 07:14:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 11CDB1A0385;
	Tue, 25 Jun 2024 07:14:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 06B6C180226C;
	Tue, 25 Jun 2024 13:14:22 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm64: dts: imx8mp-evk: Add audio XCVR sound card
Date: Tue, 25 Jun 2024 12:56:55 +0800
Message-Id: <1719291415-1168-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1719291415-1168-1-git-send-email-shengjiu.wang@nxp.com>
References: <1719291415-1168-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add audio XCVR sound card, which supports SPDIF TX & RX,
eARC RX, ARC RX functions.

HDMI_HPD is shared with the HDMI module so use pinctrl_hog.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index c2c708c492c0..a64e8a6c830d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -209,6 +209,19 @@ cpu {
 		};
 	};
 
+	sound-xcvr {
+		compatible = "fsl,imx-audio-card";
+		model = "imx-audio-xcvr";
+
+		pri-dai-link {
+			link-name = "XCVR PCM";
+
+			cpu {
+				sound-dai = <&xcvr>;
+			};
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -748,7 +761,15 @@ &wdog1 {
 	status = "okay";
 };
 
+&xcvr {
+	#sound-dai-cells = <0>;
+	status = "okay";
+};
+
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
 	pinctrl_audio_pwr_reg: audiopwrreggrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29		0xd6
@@ -838,6 +859,12 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
 		>;
 	};
 
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x40000010
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x400001c2
-- 
2.34.1


