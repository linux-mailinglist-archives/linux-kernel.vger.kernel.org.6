Return-Path: <linux-kernel+bounces-264984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B5793EADB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 321ACB20B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA767E58D;
	Mon, 29 Jul 2024 01:59:25 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7597B3F3;
	Mon, 29 Jul 2024 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218364; cv=none; b=YuVtoy7MVDginRculE4JKBaOxRpEY/8SnZ0APTg28nlMCJURwGubqbqQS6E2TE2OKOpF2yqNH2ABzGH9p/YBHV6Xwh0WMn+DLfL2pH/qH979L/E1cYdd6pNKzg+7Cl8uh04/qaseHRVb02uVDe0Q5y5enaCHKf/oThtWzNAHg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218364; c=relaxed/simple;
	bh=FixKCR2dCmfEvgammA+egWU8wPdUz7O9Vy4nWlCnoXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mhEPI/b2gji5Q9Tk4EV/l6JUE8mHimNtMgOW+ZlRwYcXDOGUSfUoF0PcJy3Tt8+x9qZGYrSTZ+UsgCTcB63pmKGLFa6oHg/OpiuNWJPCDigv45LanKOlNbupJ05Hr41XA01StSeiFYBN1d9okKRHrLCzUvBoJQe46uV1jbXGSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A84451A0E2F;
	Mon, 29 Jul 2024 03:59:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7214F1A0B4D;
	Mon, 29 Jul 2024 03:59:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D8C4618002A2;
	Mon, 29 Jul 2024 09:59:13 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: shengjiu.wang@gmail.com
Subject: [PATCH v2 3/4] arm64: dts: imx93-11x11-evk: Add PDM microphone sound card support
Date: Mon, 29 Jul 2024 09:39:58 +0800
Message-Id: <1722217199-10640-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1722217199-10640-1-git-send-email-shengjiu.wang@nxp.com>
References: <1722217199-10640-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add PDM micphone sound card support, configure the pinmux.

This sound card supports recording sound from PDM microphone
and convert the PDM format data to PCM data.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 5ebf25726c33..5e4c162e0355 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -104,6 +104,20 @@ simple-audio-card,codec {
 			sound-dai = <&bt_sco_codec 1>;
 		};
 	};
+
+	sound-micfil {
+		compatible = "fsl,imx-audio-card";
+		model = "micfil-audio";
+
+		pri-dai-link {
+			link-name = "micfil hifi";
+			format = "i2s";
+
+			cpu {
+				sound-dai = <&micfil>;
+			};
+		};
+	};
 };
 
 &adc1 {
@@ -361,6 +375,16 @@ &lpuart5 {
 	status = "okay";
 };
 
+&micfil {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_pdm>;
+	pinctrl-1 = <&pinctrl_pdm_sleep>;
+	assigned-clocks = <&clk IMX93_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <49152000>;
+	status = "okay";
+};
+
 &mu1 {
 	status = "okay";
 };
@@ -563,6 +587,22 @@ MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX93_PAD_PDM_CLK__PDM_CLK			0x31e
+			MX93_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM00	0x31e
+			MX93_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM01	0x31e
+		>;
+	};
+
+	pinctrl_pdm_sleep: pdmsleepgrp {
+		fsl,pins = <
+			MX93_PAD_PDM_CLK__GPIO1_IO08			0x31e
+			MX93_PAD_PDM_BIT_STREAM0__GPIO1_IO09		0x31e
+			MX93_PAD_PDM_BIT_STREAM1__GPIO1_IO10		0x31e
+		>;
+	};
+
 	pinctrl_sai1: sai1grp {
 		fsl,pins = <
 			MX93_PAD_SAI1_TXC__SAI1_TX_BCLK			0x31e
-- 
2.34.1


