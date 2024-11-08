Return-Path: <linux-kernel+bounces-401732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE29C1E7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4E61C2137B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789591F6669;
	Fri,  8 Nov 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="EdpNA+dx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DFrqDmQR"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881461F585F;
	Fri,  8 Nov 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073800; cv=none; b=TdqzsEDNd66sf6AqgaIsTo/8RfUXrSsXOUcIE96gHOtPBsi7o25hqn4DxC8qnICMfO2CR8YqpXU5tp6l4LForWK8GkeQwUXEalJKR7noxtHKv6+Y4T5IxQBjruyamjXQXZdL1eaQULxlx183omHVcefeQrJWetIFlnawsM7yyRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073800; c=relaxed/simple;
	bh=x6Lebkct6PYdCRRxEPVCpoWj3aBlWbdgC9ayheQ5p9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjtG92LndZjH1DUK46/aNA2tmTl/OoOV5zR9ZGXdJvxGAvG2xCQ7qBLXORZAp1Z8W8EF6vYPW44mxXgSybSGIKMVvjb10KuxnsN6jFb3k0Gs3y+E+xaunijPH1+Tosrm1QCGnLbbMdyzsL6KbZvYIY7yViHwNQg4Ix70JD83f0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=EdpNA+dx; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=DFrqDmQR reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731073799; x=1762609799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DJurGxsK8uCi65WSK796cGo8UlfRslV8FdH49GA6Q/Y=;
  b=EdpNA+dxpVcND8C/rxWrx0jTBNq2rNVq0PTMub2h0VZzEQn3sSjIOO2H
   LZWs2AfSZ6uanKEVByDE0mYze0kL3pKH/QMamepCrocs7ScUojCztwn+u
   3KxjY12cHebNMBqS8lOoNy7dEFEfzMl7ty+0zyvJjVq0gUbcfIRPPVO9O
   KKbfpRsORNSM9zk22cwKvBZfxFYn20fNGGVv5thtNGzC51N2PgciO4FBK
   GIBLOTt/ERUdeqM/1RNeRENZYCCYkgXzARWgtqdidc7m80jpaTJCk5eNE
   UBME2A5voM3uhq+nDHnW3GKJGcMM6s/wiDDBSa+vpJc6a+qvsPnpLihhr
   w==;
X-CSE-ConnectionGUID: MK9ldqucRs6qslH3v8YZAw==
X-CSE-MsgGUID: YxUeWQK/SfiKbRP+f/bXKA==
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="39936929"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Nov 2024 14:49:58 +0100
X-CheckPoint: {672E1705-29-5736D786-D50827BE}
X-MAIL-CPID: BE6FE53A4DD63A425696AA2378CC106C_2
X-Control-Analysis: str=0001.0A682F21.672E1706.0043,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE9141657DC;
	Fri,  8 Nov 2024 14:49:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731073793; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=DJurGxsK8uCi65WSK796cGo8UlfRslV8FdH49GA6Q/Y=;
	b=DFrqDmQR1s9DGboqTLnWbsjOjrV5mzyI6ajNpYpxI5M7ndjyKuXWMUExY/leu8ehDpkLDy
	O8U48O14DDjaQsGbV/Osc52kEPHPiDQ6PhaEPv8LOvEEZ2mXBORNbhpNA0PwpPhAZXV9v7
	4OkJ74iNoqeylexFqemlDeSkKOodKLXBCYhBKUM1U+gst1u01PObY9RzxRte7lcbJtfAhN
	/HJ6PVUAmlYCIxgWSORYOdGNQAz7U3Ivp2Bufo030IA2oYWAb7u6chB7tJEB2PfNVVcLEq
	buWrpO6yPBxHD12X57f77zpLhWELrmiv7xOI6Pe6qYTWB6WgzsfSeppzKI3L4g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Jo=C3=A3o=20Rodrigues?= <jrodrigues@ubimet.com>,
	Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] ARM: dts: imx7-mba7: Add 3.3V and 5.0V regulators
Date: Fri,  8 Nov 2024 14:49:22 +0100
Message-Id: <20241108134926.1324626-5-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
References: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

These voltages are provided unconditionally from external power supply and
are input voltages to various dedicated, switchable, power rails.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
index cc3760fa7d981..a23d7b0a195f1 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
@@ -141,6 +141,7 @@ reg_mpcie_1v5: regulator-mpcie-1v5 {
 		gpio = <&pca9555 12 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
+		vin-supply = <&reg_mba_5v>;
 	};
 
 	reg_mpcie_3v3: regulator-mpcie-3v3 {
@@ -151,6 +152,7 @@ reg_mpcie_3v3: regulator-mpcie-3v3 {
 		gpio = <&pca9555 10 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
+		vin-supply = <&reg_mba_3v3>;
 	};
 
 	reg_mba_12v0: regulator-mba-12v0 {
@@ -162,6 +164,20 @@ reg_mba_12v0: regulator-mba-12v0 {
 		enable-active-high;
 	};
 
+	reg_mba_5v: regulator-mba-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_mba_3v3: regulator-mba-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_vref_1v8: regulator-vref-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC1V8_REF";
@@ -177,6 +193,7 @@ reg_audio_3v3: regulator-audio-3v3 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
+		vin-supply = <&reg_mba_3v3>;
 	};
 
 	reg_vcc_3v3: regulator-vcc-3v3 {
-- 
2.34.1


