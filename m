Return-Path: <linux-kernel+bounces-265454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE6A93F16E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41531C21C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9518E13F42F;
	Mon, 29 Jul 2024 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="UA3P/trA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ltiJPzbF"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067DB84FDF;
	Mon, 29 Jul 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246328; cv=none; b=DBSdibC3W9NE686tjYkPk6AOQvo7OSE+VNNnn455Xj7DdhD0BNuk7p3k6wo28xnvm0UEoQ9P21yTAM66Q3sb/R4RIxOy0yVdXpwqol+caAgXPcRDzpAIu06dOyPypjjcPyHof3n2yH7zU8DF/QwU9qAbLcKzVmZ/RgRfVipp/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246328; c=relaxed/simple;
	bh=BhaZ7Rc9aF9i9ArddOfTXrgPz6tl9rJUNGxa29a61yE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V7e7peZxObQxhGY2EnaUQROMq4tCKgntymqVHFrkXzkAurcLD/wnOOGK4SrTrwUlHJeoiHo7jKm1nxNV2YCoxXUaCl6CvY2Nx4w3MNgCvlL/wOT6sgNe+oaZ1g3uSVHtARro2V6jlZF3Ng5W6f56p40nrECrdy/UjhtcKm/KyJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=UA3P/trA; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ltiJPzbF reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1722246325; x=1753782325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L/Jlbrty+MzML5G8tyzzNVjp9Rsyo7JZTTPa+J3gl+E=;
  b=UA3P/trAgFMd2HmKsxzHw8gUcKpcj9tHRE2O1ErkcUXZyRzIwTTGhN7l
   v4imTTr1Mi1tUqW/1Caw+/Hce+8HcK3FvB0eu+qXoLxW8alwgA1DNp6u5
   7n9CYo2qQy+uon0OEWqUW8A8QGjVd2vyrLLZdFBk9iqU1hipEtxkq8PBw
   YWb7a2t3/klC4Ict59NoPVeYLwXirgK1bMo+LsDK9sD8uu9wY9hSpHr7Q
   hgVlt/ba6UrN99MVI+fLj4hdcLVg6BLh2Fb4w8Vfq96LyPt4ZCu+LWQlR
   2bsFwovLxJXZHMI8mAKj8duiZdZ1AEOIjUhkvsUE+5A6knWTPSSqsIos+
   Q==;
X-CSE-ConnectionGUID: WhuqI1NHSkWRwviwQYtdlA==
X-CSE-MsgGUID: SBieUcVESaS1e0LRa0kXAg==
X-IronPort-AV: E=Sophos;i="6.09,245,1716242400"; 
   d="scan'208";a="38121794"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 29 Jul 2024 11:45:16 +0200
X-CheckPoint: {66A764AC-17-E6D9A9-F72EA055}
X-MAIL-CPID: 21804CAF3C8574BEB2D5434E4405EE3F_4
X-Control-Analysis: str=0001.0A782F15.66A764AC.0136,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23648161486;
	Mon, 29 Jul 2024 11:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1722246312; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=L/Jlbrty+MzML5G8tyzzNVjp9Rsyo7JZTTPa+J3gl+E=;
	b=ltiJPzbFhPHwDr/MsWqnk1ArQIjbSe/kNebypNeVBvk589n5QmV7V4tPFXnQhKAoRKZC/r
	/+AHn8bYS9wLzW4pyteIHttWRQ5+fljm3OuhUw+0KzsNSAX8c5/dsU7r196mhWm3ikMqv0
	x0zZZP5AgoNpZb7J7DYulz3HnPtHA4p3iHkbU6jxiQxRGEHgHTsc7/X5H7r2gSRKOW+1rU
	WuATx4UOkyGK+23NAe4B/9k8ovoCp5sv4Z0jNSmJKM1wSUWWMdwqLlVnRjKjelIyMOogJY
	8oQk8lyIa2Oj4dLJaZ8UX9U7S6GYR0GCkWT70WMAN7emw1xGlnXwNzGvJp6qqg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Clark Wang <xiaoning.wang@nxp.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: imx8-ss-dma: enable dma support for lpspi
Date: Mon, 29 Jul 2024 11:45:10 +0200
Message-Id: <20240729094511.159467-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Clark Wang <xiaoning.wang@nxp.com>

Add DMA configurations for LPSPI nodes on i.MX8QX/QM/DXL.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Using the DMA configuration bits from downstream kernel.
Tested on TQMa8XxS.

 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 1ee9496c988c5..8ae5f065b4180 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -34,6 +34,8 @@ lpspi0: spi@5a000000 {
 		assigned-clocks = <&clk IMX_SC_R_SPI_0 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <60000000>;
 		power-domains = <&pd IMX_SC_R_SPI_0>;
+		dma-names = "tx","rx";
+		dmas = <&edma2 1 0 0>, <&edma2 0 0 FSL_EDMA_RX>;
 		status = "disabled";
 	};
 
@@ -50,6 +52,8 @@ lpspi1: spi@5a010000 {
 		assigned-clocks = <&clk IMX_SC_R_SPI_1 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <60000000>;
 		power-domains = <&pd IMX_SC_R_SPI_1>;
+		dma-names = "tx","rx";
+		dmas = <&edma2 3 0 0>, <&edma2 2 0 FSL_EDMA_RX>;
 		status = "disabled";
 	};
 
@@ -66,6 +70,8 @@ lpspi2: spi@5a020000 {
 		assigned-clocks = <&clk IMX_SC_R_SPI_2 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <60000000>;
 		power-domains = <&pd IMX_SC_R_SPI_2>;
+		dma-names = "tx","rx";
+		dmas = <&edma2 5 0 0>, <&edma2 4 0 FSL_EDMA_RX>;
 		status = "disabled";
 	};
 
@@ -82,6 +88,8 @@ lpspi3: spi@5a030000 {
 		assigned-clocks = <&clk IMX_SC_R_SPI_3 IMX_SC_PM_CLK_PER>;
 		assigned-clock-rates = <60000000>;
 		power-domains = <&pd IMX_SC_R_SPI_3>;
+		dma-names = "tx","rx";
+		dmas = <&edma2 7 0 0>, <&edma2 6 0 FSL_EDMA_RX>;
 		status = "disabled";
 	};
 
-- 
2.34.1


