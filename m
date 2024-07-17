Return-Path: <linux-kernel+bounces-255250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26843933DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFB51F22D34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB43180A67;
	Wed, 17 Jul 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="eIbvHzwc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Rr2AtOr4"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D586180A65;
	Wed, 17 Jul 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224239; cv=none; b=A5XbA8tfDi5uu+N1KOmg59Pm30FLtMW79VGM3S4VD4LwtKawAEP+DRgeVQm7FT6iwp96XhJ9rvMUe/OHkGvTIq8Zp/+PPn31BC9CwzwXh+lV7KwVL68rlJ9cUaMUwjY/01OOfxVUgtMN5LzU9hWumGnpKFGglQYACInq5ZdjJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224239; c=relaxed/simple;
	bh=DoPxYrJkvrWRCXhmrFuOTOuVm29tK5TC6szwdunInAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TvDHsKp6qV+zHOnXoAEHK8L9xCrE0RLW5v08BMD7U0hmx0mMn2cIc2MQ7i1UQqCR5LM1s8Zu1kiI0lApLJGUdh1vwH/2NxEZOcjemlt/1AZr4/5yAmAXijh/WmyzIrqTX17y8vFrNkCLO86e7h7XQY28tDp9tpXJ5ROGXOHca2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=eIbvHzwc; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Rr2AtOr4 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721224235; x=1752760235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2y7nYfeZdJ6DryTb57/sSzAXz78Ly9UaH+MjhDPihRU=;
  b=eIbvHzwcszExkIi3WjK5saIZiRNggVSq7GRsCp5STzh1U1JRbHSTcZHg
   Z8kqWOxzMDvBS6GWuCfbmkiOVRQU/yt+a+rOl3lW+FXHXrSmt9t9zISkC
   8t5K1yjgACBww9Yz8XfZ/Sr26Gi2GenVHoTrdINlTRzxwFNj1fUGLFLlG
   Os5eB4oPM7FRsuX+mztTemFGZpEBmvBg3kxCDm8eJ/BEZWEhlZu+vxWom
   ctJWChKQlNMXd5K94KmwsNe/w8F7Y1YFFyeH/3MC3rB9nuN4P4ljFt6wM
   rKeYybamkqocYPa97chlyhqn35vYCFs1EVy/SWVtOcBW9OKby6aPsyTX2
   A==;
X-CSE-ConnectionGUID: XZ3ROfsfRNGwBRkiS4zoAQ==
X-CSE-MsgGUID: rnFblU/iRh6UL2GGKHPAkw==
X-IronPort-AV: E=Sophos;i="6.09,214,1716242400"; 
   d="scan'208";a="37953366"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jul 2024 15:50:33 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66585165BDF;
	Wed, 17 Jul 2024 15:50:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721224233; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=2y7nYfeZdJ6DryTb57/sSzAXz78Ly9UaH+MjhDPihRU=;
	b=Rr2AtOr4AjFwZ1uyeMDdO80Wfkvruug4E2LerVJ3tTOEMigninwJfHxhLIA5YvDVVKtIOB
	LMY7sr7TYC98NJ9qZXBqazoy20+ZI1zsMNlg6FzyxXH02WPYyOagroDZUpKkTaHnIXwMs7
	4Xfks1zIZa3R9SiLVtGFsIeP71PKze8phGVPg6mldBvsa7n324TIglC0NOzBSN+DLxDKgZ
	yHjJXsPNBvyXiuCxexvYvuWa+urTJxHDX+8FnM9ia4wVvN1sD6xDg8wbeTZhZQi+uF8UsN
	89Ihu05UgBRfgfFmP/PeRTihT7fLdnbGA++GbeeZ/FdG3I3z+YBkMe5k5Tzg0Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: imx8-ss-dma: add #address-cells and #size-cells to LPI2C nodes
Date: Wed, 17 Jul 2024 15:50:25 +0200
Message-Id: <20240717135027.4116101-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

These properties are required by i2c-controller.yaml bindings.
Add them on SoC level, rather than on board level.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index f7a91d43a0ffe..3f521441faf7e 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -303,6 +303,8 @@ adma_pwm_lpcg: clock-controller@5a590000 {
 
 	i2c0: i2c@5a800000 {
 		reg = <0x5a800000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&i2c0_lpcg IMX_LPCG_CLK_0>,
 			 <&i2c0_lpcg IMX_LPCG_CLK_4>;
@@ -315,6 +317,8 @@ i2c0: i2c@5a800000 {
 
 	i2c1: i2c@5a810000 {
 		reg = <0x5a810000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&i2c1_lpcg IMX_LPCG_CLK_0>,
 			 <&i2c1_lpcg IMX_LPCG_CLK_4>;
@@ -327,6 +331,8 @@ i2c1: i2c@5a810000 {
 
 	i2c2: i2c@5a820000 {
 		reg = <0x5a820000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&i2c2_lpcg IMX_LPCG_CLK_0>,
 			 <&i2c2_lpcg IMX_LPCG_CLK_4>;
@@ -339,6 +345,8 @@ i2c2: i2c@5a820000 {
 
 	i2c3: i2c@5a830000 {
 		reg = <0x5a830000 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&i2c3_lpcg IMX_LPCG_CLK_0>,
 			 <&i2c3_lpcg IMX_LPCG_CLK_4>;
-- 
2.34.1


