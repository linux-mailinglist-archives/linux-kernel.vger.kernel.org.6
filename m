Return-Path: <linux-kernel+bounces-255251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCAE933DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EC91F22615
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFB0180A92;
	Wed, 17 Jul 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="haRDfJAQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="a9YDOgKW"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44A1802A5;
	Wed, 17 Jul 2024 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224240; cv=none; b=E4F/OX6oq8rQaJptjM9Ilnj5sUIJGaUyZHfaAAWURs4FgifPcri4Rt7G1lTKLw6TSlXfOxM7Svr0CSUwm4CEnzrcFd7H3AFazCxdY43ZwH+ETQ/LUKhpatxlBuh55mY0/NULfLzYFWZWarIWIeCCvcyQsy/UwpD34QQAI+zriPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224240; c=relaxed/simple;
	bh=bwygqn6+9uhx6pMQYhVllG3338pbtgzbxXdViSthslI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dhWigIScEPv2fmYGsNtB0CMpM79DR6FibM160l1zhiaMelfQSX+dneX/Tvmq2Ak8HqhWsGAP5kSwIIDq/CmHZjKhUx+6oWJBVvLtJ2d0YNgVjvB3JLIHVxae7IRGVVY2Qcm8osWlsNiGF+CDps37Rov/TqHXTRhB0eaX/bgrQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=haRDfJAQ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=a9YDOgKW reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721224238; x=1752760238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZlUA9rHowEfvKWvmWiFn0EsAUSZaJLvPi2v64JoU+5M=;
  b=haRDfJAQbqnCNr8RIpYcccMZ1X8FzgsEkZmtgQxetk13yd8BYmx/Z1F7
   NN80dTafTeBv0lCdnZgxCE9aVKY4tFUtgPYEJFdl1PF+LM7TWsErqa8dG
   FLmBKdI/XfJK1JFAi3fA7/OhDEAqi3XB2shWgKw3l30TVQZEiLAnaCel7
   RkjdrTx5h+jYzrYopbpTPyJ8mxRi9gF3mvXxaar09aWMIJ2q1qZ2XMcA4
   QYOZWfN8gBSz1rYaCWfz2V6yt8Rut7I9aWuX23QEimjtdACmeNrTUlx/A
   2YmBgKL4/DnVMkF9YTvG5Tr1sv+DoFMu1opeebZ54wLZeibKg36OTlJfT
   g==;
X-CSE-ConnectionGUID: aBkVQxayT1C5n+pQKeb2ng==
X-CSE-MsgGUID: XWcf0ovjQxqYyLxnf6WPAg==
X-IronPort-AV: E=Sophos;i="6.09,214,1716242400"; 
   d="scan'208";a="37953367"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jul 2024 15:50:35 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA8BA165BDF;
	Wed, 17 Jul 2024 15:50:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721224235; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZlUA9rHowEfvKWvmWiFn0EsAUSZaJLvPi2v64JoU+5M=;
	b=a9YDOgKWlJVHgJlE9dI5QZwHgXjAwmJOm+2twCx2b7F2Ueqqg/A+k4yPIUT9taoCCFq5s1
	aLbALGhBO7lt7AMuVBMZ1jlqbxm9B5E4P5hz0YLsaJlHO2tga9X6x9M861KMrZeh/CYm0J
	QhBnbt3OG9bCzxLCxds/97gPp+ahHPCcsLvNpCOR330ZgejZuiTLh1yhW2gAR6OZ6IeJOz
	55By/idWde14UOo1lrUV47o/5AMrhyyyo/lnH6kUs325WdWMhBGa06FjYgWaKkZJB7dCoN
	v6JyqNWRmCKnrbJhYvjm4Ks7H7uEN1mr1eghokyFij4P5bmFA5nMWwNKZjkyMw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: imx8-ss-dma: Fix adc0 closing brace location
Date: Wed, 17 Jul 2024 15:50:26 +0200
Message-Id: <20240717135027.4116101-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717135027.4116101-1-alexander.stein@ew.tq-group.com>
References: <20240717135027.4116101-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Align the closing brace to opening line.

Fixes: 1db044b25d2e ("arm64: dts: imx8dxl: add adc0 support")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 3f521441faf7e..1ee9496c988c5 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -370,7 +370,7 @@ adc0: adc@5a880000 {
 		assigned-clock-rates = <24000000>;
 		power-domains = <&pd IMX_SC_R_ADC_0>;
 		status = "disabled";
-	 };
+	};
 
 	adc1: adc@5a890000 {
 		compatible = "nxp,imx8qxp-adc";
-- 
2.34.1


