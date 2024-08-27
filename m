Return-Path: <linux-kernel+bounces-302890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE19604BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB151F209AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5319D889;
	Tue, 27 Aug 2024 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="rBG78Zq8"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C7199EA1;
	Tue, 27 Aug 2024 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748207; cv=none; b=oS4ym07Cd1nHblPOgFkWk36EyZB8fs+uWck0ElQgrVuAd11G7h0ZOzOIebx3n/M0gcvETdxkEfu5PXhhlTnY+Cec30L+QFjN4bCodvfs3LHfYgf1oXsU59jHPCDAScyAscTR/1Xg0XJe+XYU01dxRmMuknGfrndPpNslfvhRolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748207; c=relaxed/simple;
	bh=1eRuCf9XeEdJXtNyxi2gS18SBR3ZYra5isalcTqIjD4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uR7n3PAy/SYodSDHMPukSCVchYbeLpb26+IAVf1jIucPmNJWlu0ht0UlPVKSrR70reMtBzfn0KQfbojeDccE4i6xtn0shYtEy63NL5kAYQIVTKeFtMIcBtHaFvm2IIhELbQHWQL2iKdAQPkEFnXRCrsJK8rQAISoNvD7FQMJaeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=rBG78Zq8; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AD59F879C1;
	Tue, 27 Aug 2024 10:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724748197;
	bh=/SuxlEv1Mh6aG9u7W2TzBehN0K7zytpzIZo1KqSiJOA=;
	h=From:To:Cc:Subject:Date:From;
	b=rBG78Zq8w5WrUhndrDGRb4YR+swB51eEBKyBoe2/H56TAFbCREKW7+lBle6f0vjxQ
	 CJMptoeThA65Z9cbXfssSbaZop1HhaxxjPJ1BA24VzkpEMUgiFO7dRvBVk9QHdiwmW
	 oia/G4D77O8v5B/jWl+lz8PJSwwRnxXdVVgjs37AOfQA3QYkmnyFrIxYb84T1V4+bN
	 iW+Xnjhzb2a4TQmezxOYRDvbIvrIwHOvIUnwNd6EzinQy6+R1UOTLMvo4FMxufpqsf
	 IA1WrrPv0vGetocZGL5OXmWKIbVc54Q3ktI44nAvNprnw8C30vnXmS626nAkZvpkgy
	 X/QNXQSKSfq9w==
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
Subject: [PATCH] dts: nxp: mxs: Update device tree description for LWE imx28 based devices
Date: Tue, 27 Aug 2024 10:42:55 +0200
Message-Id: <20240827084255.2120864-1-lukma@denx.de>
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

The description for imx28 based devices needs to be updated after some
further development.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi | 38 +++++++++---------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
index 69fcb0dde940..6fa1f3e25b08 100644
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
+			partition@3 {
+				label = "rescue";
+				reg = <0xA0000 0xF40000>;
+			};
+
+			partition@4 {
+				/* 1st sector for SPL boot img source data */
+				label = "spl-boot-data1";
+				reg = <0xFE0000 0x10000>;
 			};
 
-			partition@500000 {
-				label = "swupdate";
-				reg = <0x500000 0x800000>;
+			partition@5 {
+				/* 2nd sector for SPL boot img source data */
+				label = "spl-boot-data2";
+				reg = <0xFF0000 0x10000>;
 			};
 		};
 	};
-- 
2.39.2


