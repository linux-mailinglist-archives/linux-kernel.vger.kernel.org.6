Return-Path: <linux-kernel+bounces-232110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F2091A38F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFD11F2316A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B113C9CA;
	Thu, 27 Jun 2024 10:10:46 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB413E05F;
	Thu, 27 Jun 2024 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483045; cv=none; b=owHwPyX7pH2MV6fsD9aE6jTr77sC/gED75WJ6q2w4e2JmYei10PtjFhuJ0UUPslJAEV5AMAafmYkByEPQAxQ8FmPUaZHvhgl2YzF5im3Wl6GmjgAU+hBranxTM0nEtJsn5OICKc250wBqB3K7R8hbfSZKc5gCvkRfPJLe1ywh98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483045; c=relaxed/simple;
	bh=JumFjepAK5BceEeoilJQ1Y3XfINuUODu8VGkkHsJI0E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=niwmGEUl5Qr0CaboTxco0Ls11MEIv+H9oDkfAdlF5DUjyz204kwcGOaeSqESgsiLJUYkrxnOvxTkaWjuX9A+huTWluhAlEGwgzhHaM5QJgrE6LigEv06GuiL3GPvoRPze9/94nujZp4o8VrlnxZMMUkX9zc19W6AGYb9B5y/RQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AE3501A0868;
	Thu, 27 Jun 2024 12:10:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 75CB11A0738;
	Thu, 27 Jun 2024 12:10:36 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9FEC3180222F;
	Thu, 27 Jun 2024 18:10:34 +0800 (+08)
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
Subject: [PATCH v2 3/3] arm64: dts: imx8mp-evk: Add audio XCVR sound card
Date: Thu, 27 Jun 2024 17:53:01 +0800
Message-Id: <1719481981-4069-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1719481981-4069-1-git-send-email-shengjiu.wang@nxp.com>
References: <1719481981-4069-1-git-send-email-shengjiu.wang@nxp.com>
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


