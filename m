Return-Path: <linux-kernel+bounces-303605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D03B29610A2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0801C237C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668401C3F19;
	Tue, 27 Aug 2024 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EoEv3bOv"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D261C57A9;
	Tue, 27 Aug 2024 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771466; cv=none; b=if2xF5Hozf8L+/JCkepxOhIsCbpEhwCTZOucxFLNILL3fdWVIabxKjY8crNOX5uXfZMi8JYW6FT74rU3w5Mr0crH2pqkvIJ7m3A+DAHMsk2b1U018Uko17Cy61kvlzQrwAsl53eD5lkKy2t2tsxU4gbhH7JDyWffT6sEvY8Cqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771466; c=relaxed/simple;
	bh=3xVLnGcTId0XQFiNIOwnPImEiBTXkSLlAj7t4/dT72U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NZ2bat9n0BCccyUbxJ1AuRzx4oVfBwM73zyTnyALUyDeyovviVLn0YBnOxIdG1UqqfaGAt/KOpvLrJAcGo34o3/yULi4TFGD4woUxqNq9sqVcQdlBRhVV2g6EHApCfuTCnT6tgi4bjHS122SZ9H9BM9GE1zEb8dY9WXtY89kxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=EoEv3bOv; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 309FD87F5C;
	Tue, 27 Aug 2024 17:11:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724771462;
	bh=3WZUiJ+S1tJ3Av97erWGdxb+OR4BtI+I9p0lNeSdlV4=;
	h=From:To:Cc:Subject:Date:From;
	b=EoEv3bOvf3C940mtrhICVIynLhMsZGdDbDkSGOwlcZgMZ+J9rEDTLH8eW9BDNStTs
	 iX3bsPt/V7q+0mwGxwPct/FZ8/aKv9FVXGXynYxi29YcOWav9ZYtpeqjAU3/k/Gzrn
	 E6J4q1ChVa6L8zbYv0my9U5GwSUxku5TKpRCPFkYlktmj6H1j3XheZDXGi3m4tz9N5
	 inH55G9kXIiFUMLPTVRdx4UOD1kYs4E39GbUMMrKx7HuRuOc9xhflHegJrUSNyEbO/
	 SuzkZS31ZhiKaPYIMVGeQwbs/QYDxkL3xmGY7FQvXquFLBrkoyz7YWVGcWJ0Cp2Dy4
	 ShBN6I+2ojk4w==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2] dts: nxp: mxs: Fix partitions definitions and remove saif (imx28-lwe.dtsi)
Date: Tue, 27 Aug 2024 17:10:42 +0200
Message-Id: <20240827151042.2254651-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The SPI-NOR memory layout has evolved during time lifetime of the
device - for example special partitions to keep track of booted devices
for A/B booting scheme were added.

Additionally the saifX nodes are specific to other group of the imx287
based devices, so needs to be moved to different devices description.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- Add more descriptive commit message
- Replace e.g. partition@4 with partition@fe0000
- Use lower case letters for HEX offsets descriptions
---
 arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi | 38 +++++++++---------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
index 69fcb0dde940..410dfe17f8ca 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
@@ -55,23 +55,6 @@ &i2c0 {
 	status = "okay";
 };
 
-&saif0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&saif0_pins_a>;
-	#sound-dai-cells = <0>;
-	assigned-clocks = <&clks 53>;
-	assigned-clock-rates = <12000000>;
-	status = "okay";
-};
-
-&saif1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&saif1_pins_a>;
-	fsl,saif-master = <&saif0>;
-	#sound-dai-cells = <0>;
-	status = "okay";
-};
-
 &spi3_pins_a {
 	fsl,pinmux-ids = <
 		MX28_PAD_AUART2_RX__SSP3_D4
@@ -109,7 +92,7 @@ &ssp3 {
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
-		spi-max-frequency = <40000000>;
+		spi-max-frequency = <20000000>;
 		reg = <0>;
 
 		partitions {
@@ -133,14 +116,21 @@ partition@90000 {
 				reg = <0x90000 0x10000>;
 			};
 
-			partition@100000 {
-				label = "kernel";
-				reg = <0x100000 0x400000>;
+			partition@a0000 {
+				label = "rescue";
+				reg = <0xa0000 0xf40000>;
+			};
+
+			partition@fe0000 {
+				/* 1st sector for SPL boot img source data */
+				label = "spl-boot-data1";
+				reg = <0xfe0000 0x10000>;
 			};
 
-			partition@500000 {
-				label = "swupdate";
-				reg = <0x500000 0x800000>;
+			partition@ff0000 {
+				/* 2nd sector for SPL boot img source data */
+				label = "spl-boot-data2";
+				reg = <0xff0000 0x10000>;
 			};
 		};
 	};
-- 
2.39.2


