Return-Path: <linux-kernel+bounces-232109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4351C91A38D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2878282C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6861513C83C;
	Thu, 27 Jun 2024 10:10:44 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A1113C9CA;
	Thu, 27 Jun 2024 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483043; cv=none; b=ESKkvrZYfz6SUWwMxHdHjkn26+YLxcNvqgE5I+EChp/i6b5dDEA4epMa48Hq9RvPrwqgvZKtN9zjz/i4BbbjBYv7r6+2VhEJocjCPwQjN81WrILg16O5iRZidIVJH26DY5M4rrm2rZed6H0hLoKCpWPNWcBpmej71iboF8PnZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483043; c=relaxed/simple;
	bh=u8jybJLxI/3xcF56iSvDUXSZFQJeUCBQKm8bnSHqaEY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=kQhEOOshsCydC2wk+tyBpVs/hg0bVQhYYkCF8hXYAGIEHht/tb8lGSoXzSR41BxI3Y2IVl9wysOKVrOAWZcSkWprugX2WZJ66A752/EBIoQYEZoRFI32PkqfdE3SwRopB3lFsOlEdPBC20dVorU3WmuNBXDlHbbew0Ema8AFYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 586822007D1;
	Thu, 27 Jun 2024 12:10:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2024F20193D;
	Thu, 27 Jun 2024 12:10:35 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4D2C71820F59;
	Thu, 27 Jun 2024 18:10:33 +0800 (+08)
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
Subject: [PATCH v2 2/3] arm64: dts: imx8mp: Add audio XCVR device node
Date: Thu, 27 Jun 2024 17:53:00 +0800
Message-Id: <1719481981-4069-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1719481981-4069-1-git-send-email-shengjiu.wang@nxp.com>
References: <1719481981-4069-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

XCVR (Audio Transceiver) is a on-chip functional module found
on i.MX8MP. It supports HDMI2.1 eARC, HDMI1.4 ARC and SPDIF.

The reset controller is provided by the audio block control driver.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index f25fc7a8358f..f0297e12ff85 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1540,6 +1540,31 @@ aud2htx: aud2htx@30cb0000 {
 					dma-names = "tx";
 					status = "disabled";
 				};
+
+				xcvr: xcvr@30cc0000 {
+					compatible = "fsl,imx8mp-xcvr";
+					reg = <0x30cc0000 0x800>,
+					      <0x30cc0800 0x400>,
+					      <0x30cc0c00 0x080>,
+					      <0x30cc0e00 0x080>;
+					reg-names = "ram", "regs", "rxfifo",
+						    "txfifo";
+					interrupts = /* XCVR IRQ 0 */
+						     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+						     /* XCVR IRQ 1 */
+						     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+						     /* XCVR PHY - SPDIF wakeup IRQ */
+						     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_EARC_IPG>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_EARC_PHY>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SPBA2_ROOT>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_AUDPLL_ROOT>;
+					clock-names = "ipg", "phy", "spba", "pll_ipg";
+					dmas = <&sdma2 30 2 0>, <&sdma2 31 2 0>;
+					dma-names = "rx", "tx";
+					resets = <&audio_blk_ctrl 0>;
+					status = "disabled";
+				};
 			};
 
 			sdma3: dma-controller@30e00000 {
@@ -1568,6 +1593,7 @@ audio_blk_ctrl: clock-controller@30e20000 {
 				compatible = "fsl,imx8mp-audio-blk-ctrl";
 				reg = <0x30e20000 0x10000>;
 				#clock-cells = <1>;
+				#reset-cells = <1>;
 				clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
 					 <&clk IMX8MP_CLK_SAI1>,
 					 <&clk IMX8MP_CLK_SAI2>,
-- 
2.34.1


