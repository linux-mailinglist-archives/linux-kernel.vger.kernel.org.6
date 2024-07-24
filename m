Return-Path: <linux-kernel+bounces-260987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9622C93B142
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DB31C2350C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9351F15D5C5;
	Wed, 24 Jul 2024 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NTCn771e";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="TEPrS64s"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6781B285;
	Wed, 24 Jul 2024 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825972; cv=none; b=cXh7pK8dxg6FximmJwHnDNCDEuMponjnHOoa9jXKFxybLuhe8B0/JuFvcTdD+JuBLvVKN+tBZDtLDe2yYl08KBpV6gz5OfugWAE1ZTHgBuSrOCHhqmHvftTPfY0VV2YCEmWI+9+hGxH708GNb+HPfSAt29bUtGNzCcuQTMlXTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825972; c=relaxed/simple;
	bh=k4PATdqEEjOgTojtMGmaVlltZcUXwlXMB03bcCEgb44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFpJkpsyxdaqNymCVrTGLwwoQwx0cjf8FifXIPPKte5etH+PCO3KLGet8A7+/BAB0pVn5Gtcb4KDHjrlr4QuTFbwFaPy/8jwxwshy69RQrao+HywIcphngGT2J9zTuiglOnjgeCB8AOpyA5Z6M1q0DX19m8ED1HC4KC53Hz4YyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=NTCn771e; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=TEPrS64s reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825971; x=1753361971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LrioAY2XP+9s/AYYX2diLS+Cw7MeaKrQ+ycpTBxI4jc=;
  b=NTCn771ezGs9vOXHeJV/GSmBORbcY3uro+3x13qko3puSolXEhzHqYHt
   zyJu5nBYgp7ywuTNpXj9hurwKU714iI513dFLWVuT83bCcqweKlVMVCf6
   TSz0E9OTNFC1u3C3GfKI+C99aY3jqcNpFWN5hEec0unE9mLdGk4crpPp5
   GBqKjvh5NmZKxZWB4YXSFq6KhL6gF4Kzwo4OxoW8B8yXcHx0X2Q8nHeFu
   eiQCC6Q+WdthFXSlnGrYrRDdjfdDINToju8g+TNgO6MDHu0MVTfGPs3rG
   8OXGB3vKwszs2S0pRdNFfvAnnaD3M9EVrO5bRZGg7hVJIBCGvq56zMkC2
   w==;
X-CSE-ConnectionGUID: ZIWDJNYhTU6exqjfc8cuZg==
X-CSE-MsgGUID: 5h5JiYk9S4KqQ6cotafIvQ==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058833"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:30 +0200
X-CheckPoint: {66A0FAB2-C-E6D9A9-F72EA055}
X-MAIL-CPID: F5379B085898A047144BEA0ED1F636BE_4
X-Control-Analysis: str=0001.0A782F26.66A0FAB2.00D7,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E82016373A;
	Wed, 24 Jul 2024 14:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825970; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=LrioAY2XP+9s/AYYX2diLS+Cw7MeaKrQ+ycpTBxI4jc=;
	b=TEPrS64sGJMd0Oc80VCbekg9miqIt13qS/EFf2Jvc+HUWn3318t8mx2oJo2Sq+k6u2OgYl
	wYx/6MFpdRzHmk1b8+MIcGzP8txeujfmrNFfrjpGA9PjO3pKYPPDR5JKJGhXav5w2dsHtV
	7Nf453ubtg+cGn/cj9VdOj7reZNDGbU+pnsWNuD04ZZghigATUWk0oxbCxfzXmLuFLrKkG
	pkyrCJQWfeZM9i4O3xWllnB5zw/xDntDHzIdVKcd1VlnXpkUUky4WyhfaQfY6I4fAFrVGR
	efvzunTHchVLsTz0Dgz/ZPsr3AuSGnlYcgOJNWAfWbszJIzC/y3AEvOSgkmP5w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] arm64: dts: freescale: imx93-tqma9352-mba93xxca: add RTC / temp sensor IRQ
Date: Wed, 24 Jul 2024 14:58:58 +0200
Message-Id: <20240724125901.1391698-12-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

The IRQ lines from devices on SoM are connected to CPU GPIO on
this mainboard.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../dts/freescale/imx93-tqma9352-mba93xxca.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index 99a0b6b9e304..2d979ab085ee 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -500,6 +500,22 @@ &lpuart8 {
 	status = "okay";
 };
 
+&pcf85063 {
+	/* RTC_EVENT# from SoM is connected on mainboard */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcf85063>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+};
+
+&se97_som {
+	/* TEMP_EVENT# from SoM is connected on mainboard */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_temp_sensor_som>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
+
 &tpm5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_tpm5>;
-- 
2.34.1


