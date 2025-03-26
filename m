Return-Path: <linux-kernel+bounces-577456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C9A71D46
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FE03B84C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6F823BCEC;
	Wed, 26 Mar 2025 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="aoCSDZ6Q"
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C223A560;
	Wed, 26 Mar 2025 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010468; cv=none; b=U9fWpXIPuWkIXRpaQC1f+/fzR4PXNu8XTXLtWWcLYFQC/+mReF+cW4iWdtn6v0S19WRGsTQZVdF5gqosoJ2EuBcxBuSVAuVCoKcqLeoftMG8UaRnzuUfjy8aXgW3umy2Hi59tERBpN9PP4wLjGvog2+ZJPaQqI+dHp47MSGhrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010468; c=relaxed/simple;
	bh=gCIXR7mTy8VpiPkmnIGl7UQd2d/joGKOTM9O3rTwxR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IROPcgaeRFwRUDEhPZ29zYbVvk2MkqiPlM6/wMcFXgzoVUmYlHXbEu9wJi1R3XvmusILVADSopZg0jKxnC+MO+lTgrDIoyfNOd1PsKUvA7W6oeoVgE0ixdT1ljAzEvI3tjc+ZYjYyteVOHAxpylQO7Vh0UV4olFCkwWNEPRm4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=aoCSDZ6Q; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15794101CA7A7;
	Wed, 26 Mar 2025 18:34:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743010464; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ei1R1XbtM/7Jpvo7XffeVR6Qpxo7UXhh0v2AqV7Yr2A=;
	b=aoCSDZ6QyTEa707rwWYg/05iFgZV4YFwahmiWRk0077pLaFOMhUV7Yu6wvxTpjpwmvo4P2
	3uWni/5XvUBIGAfWshBYlo2hzx1ov5YNgpv6qXYqrpuR7bTpB7kNn+S43LEChLdEajGkHJ
	SPuLy2ZflfU2mA8swQ5ADwhkdDlSCCc4aMy4slUO/emOnd7ZDtwIM3De8ptgqXqo3qamC6
	0yAbCBK7vcajJuc7YyW4OoAdLTkEzr+NQOSeuWPDIz7yfsmjygizQAmmGXX3kDApw+7X/a
	LQyTbazgErsUtRf/IjsK8WIoCebmWDbxoIsNkV22dyVnuS4kh8v7/TDWlWKqhg==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/2] ARM: dts: Update common LWE file for XEA and BTT3 boards
Date: Wed, 26 Mar 2025 18:33:59 +0100
Message-Id: <20250326173400.2697684-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

During development it has turned out that the spidev node needs to be
defined.

Moreover, some crucial for the systems operation, regulator properties
were missing.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
index 410dfe17f8ca..46858050d0d3 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
@@ -26,6 +26,7 @@ reg_3v3: regulator-reg-3v3 {
 		regulator-name = "3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
 	};
 
 	reg_usb_5v: regulator-reg-usb-5v {
@@ -33,6 +34,7 @@ reg_usb_5v: regulator-reg-usb-5v {
 		regulator-name = "usb_vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
+		enable-active-high;
 	};
 
 	reg_fec_3v3: regulator-reg-fec-3v3 {
@@ -40,6 +42,8 @@ reg_fec_3v3: regulator-reg-fec-3v3 {
 		regulator-name = "fec-phy";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		regulator-boot-on;
 	};
 };
 
@@ -134,6 +138,12 @@ partition@ff0000 {
 			};
 		};
 	};
+
+	spidev2@2 {
+		compatible = "lwn,btt";
+		spi-max-frequency = <100000000>;
+		reg = <2>;
+	};
 };
 
 &usb0 {
-- 
2.39.5


