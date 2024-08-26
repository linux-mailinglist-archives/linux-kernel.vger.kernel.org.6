Return-Path: <linux-kernel+bounces-302298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB595FC55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA00284F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDD119E827;
	Mon, 26 Aug 2024 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="bVhjX+Cc"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795BF19D8A9;
	Mon, 26 Aug 2024 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709586; cv=none; b=Gh/oLh61HVNUc0SFEWw+Hszfc/fX+T1ueQCPYYdsMdx4+kWmMQz6qMnU97Bi6CI8yTUdTRU9AeZOGEtJVEZ4Z05EitcO1W77J2MPr7Tn/YeRMgxIYfrW1r51tX+wgUL3ndAEZoSmUYPCND87xYK+04mrM/1X77zQly9W2ZN+DVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709586; c=relaxed/simple;
	bh=oLDDDYHNwoSmGgW/E88FUxShwyIwpyGey1dNTzAopZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+93i4SSAhknr0VZS03Mb1JLJmzYuFNPoe9bgWUz4TjPGDTm5sTDRGsh7ruwVUTrD0vlkb7ykhETDpLukgJ2QN+JwHdySciCT5Awq2j+EutXkFu+tHteK5tCGFGjYnZLj5dJy5hsYZMItg7xa6uUoqhUIWEmPmTiC+igqpzshdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=bVhjX+Cc; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 73EF525074;
	Mon, 26 Aug 2024 23:59:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724709580;
	bh=3NPK+p0mJgiOq8GcwZ3CPB6kLXaNxyIbSXm1F2awChY=; h=From:To:Subject;
	b=bVhjX+CcmYlJAb47TAqqNoeoQwZ3t/AwKxEE2ThglUrZfdl7YVoCKA1Q/QwgcLIhQ
	 wPE2jFSZ5Sf/gitHA9Y4XpfxzgdrIUpn2/4h3cGCuh4Lbld3aEPjvXQqUGxf3uSD/Y
	 m4jBJV4MNWFmKrhyn9U3nNxzspyxlzMQICw7GzvmLgWW7dNR//Rdf7KqmG230t9iro
	 ZzB94C7jS+jw6r9/Y8b9bjmRW8bIdiiFkPMLmLgDQtpsMNj72pDb7b8zQCTQB949tv
	 ENxJ9SMTRQ0bs8dKPWZSJVLH2H3V/xXGxbG3kpCKjHAuGxn/ro86rTLUgHP2pE1cdI
	 kXMTDrKicJB6g==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 07/10] arm64: dts: colibri-imx8x: Add vpu support
Date: Mon, 26 Aug 2024 23:59:19 +0200
Message-Id: <20240826215922.13225-8-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826215922.13225-1-francesco@dolcini.it>
References: <20240826215922.13225-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Enable VPU on Colibri-iMX8X.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../boot/dts/freescale/imx8x-colibri.dtsi     | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 7c728208f385..782546a35bf9 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -424,6 +424,15 @@ &lsio_pwm2 {
 	pinctrl-names = "default";
 };
 
+/* VPU Mailboxes */
+&mu_m0 {
+	status="okay";
+};
+
+&mu1_m0 {
+	status="okay";
+};
+
 /* TODO MIPI CSI */
 
 /* TODO MIPI DSI with DSI-to-HDMI bridge lt8912 */
@@ -511,7 +520,24 @@ &usdhc2 {
 	no-1-8-v;
 };
 
-/* TODO VPU Encoder/Decoder */
+&vpu {
+	compatible = "nxp,imx8qxp-vpu";
+	status = "okay";
+};
+
+/* VPU Decoder */
+&vpu_core0 {
+	reg = <0x2d040000 0x10000>;
+	memory-region = <&decoder_boot>, <&decoder_rpc>;
+	status = "okay";
+};
+
+/* VPU Encoder */
+&vpu_core1 {
+	reg = <0x2d050000 0x10000>;
+	memory-region = <&encoder_boot>, <&encoder_rpc>;
+	status = "okay";
+};
 
 &iomuxc {
 	/* On-module touch pen-down interrupt */
-- 
2.39.2


