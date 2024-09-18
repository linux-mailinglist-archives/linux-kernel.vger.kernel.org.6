Return-Path: <linux-kernel+bounces-332614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 340B797BBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670951C213C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D72189BBE;
	Wed, 18 Sep 2024 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Y5BZR5yX"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5770417C98C;
	Wed, 18 Sep 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661286; cv=none; b=EkXXvkjpUSma3QZE81WM08xvEmAIwy0u7Fuk+9JNwBAfJBriFMGnIbehgRqWSkyeDnsrXp1lANPsAkeIsuFdmFkPj1hjg1gNmN977WRFUlZUM/OMEzN5E22HsNt8hc8sE8H9Xg2b/ABBJW6T3xN33ItJPV/wMhFeslx80deJ2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661286; c=relaxed/simple;
	bh=BMWcxuuYadRj1cmSNDSsvmmpyRSWUl3YEex9rlXeUPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J0ped2I3Ec9KGRAn5u2DNlKxmNhoJ7bOBekQKH+jwOspd5gp+YfOP1KKk2hy8rSjyE2vcoQPZTp/9yRS+mwkMwoNV909mN3IrY7KjbnNocWojaBp9HK0AcJv9XQ0sMgNbWVh+1Vcp9ml4neqqFd7aPHymbEKMLBPD+zDhAFLvg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Y5BZR5yX; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=HdxkpAhtUoAhJMQeArjLrrrlHbN0R0p+W+58ksBNDKQ=; b=Y5BZR5yXrICc6yVE5EnSVFBTpJ
	UCwOaPGRR+va9fObbX3+Vl/iLsy1pbvdGMhUC3wHlWTQW97O+MTsWCEVSTwoTwNcEZU51J0psMmEJ
	Y2xkbVUFOF3BUAAHo5SyhjtjHR1E1yPxTLJWNM9wwynR4Trp5dFfrjmdGpvBExdDxV2bU/IzHX5OZ
	EHfDYS98NkUk65vbFn3hNUN4vmymJIF0+XBnuwA/sZrvdavNi8Fvc2ZKUPSZuKvlYudnVI/9SZZhk
	MEoJKBhP2tAR5Z90cj4LUhUgLxsAjZyMh95CfRW4nI4C+nr7VkezL10rofhLJGCKT3IAQuFfOl/Ut
	0zzSqrAA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sqtTE-000Nl5-Vx; Wed, 18 Sep 2024 14:07:45 +0200
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sqtTF-000Fv4-0D;
	Wed, 18 Sep 2024 14:07:44 +0200
From: Sean Nyekjaer <sean@geanix.com>
Date: Wed, 18 Sep 2024 14:07:42 +0200
Subject: [PATCH 1/2] ARM: dts: nxp: imx6ul: add dma support for all uarts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-imx6ul-sdma-v1-1-d25abd56e65c@geanix.com>
References: <20240918-imx6ul-sdma-v1-0-d25abd56e65c@geanix.com>
In-Reply-To: <20240918-imx6ul-sdma-v1-0-d25abd56e65c@geanix.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.13.0
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27402/Wed Sep 18 12:32:17 2024)

Add dma support on uart1, uart2, uart3, uart4, uart5, uart6 and uart7.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index 235aa676618b..6de224dd2bb9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -274,6 +274,8 @@ uart7: serial@2018000 {
 					clocks = <&clks IMX6UL_CLK_UART7_IPG>,
 						 <&clks IMX6UL_CLK_UART7_SERIAL>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 43 4 0>, <&sdma 44 4 0>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -285,6 +287,8 @@ uart1: serial@2020000 {
 					clocks = <&clks IMX6UL_CLK_UART1_IPG>,
 						 <&clks IMX6UL_CLK_UART1_SERIAL>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 25 4 0>, <&sdma 26 4 0>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -296,6 +300,8 @@ uart8: serial@2024000 {
 					clocks = <&clks IMX6UL_CLK_UART8_IPG>,
 						 <&clks IMX6UL_CLK_UART8_SERIAL>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 45 4 0>, <&sdma 46 4 0>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -1075,6 +1081,8 @@ uart2: serial@21e8000 {
 				clocks = <&clks IMX6UL_CLK_UART2_IPG>,
 					 <&clks IMX6UL_CLK_UART2_SERIAL>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 27 4 0>, <&sdma 28 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -1086,6 +1094,8 @@ uart3: serial@21ec000 {
 				clocks = <&clks IMX6UL_CLK_UART3_IPG>,
 					 <&clks IMX6UL_CLK_UART3_SERIAL>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 29 4 0>, <&sdma 30 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -1097,6 +1107,8 @@ uart4: serial@21f0000 {
 				clocks = <&clks IMX6UL_CLK_UART4_IPG>,
 					 <&clks IMX6UL_CLK_UART4_SERIAL>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 31 4 0>, <&sdma 32 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -1108,6 +1120,8 @@ uart5: serial@21f4000 {
 				clocks = <&clks IMX6UL_CLK_UART5_IPG>,
 					 <&clks IMX6UL_CLK_UART5_SERIAL>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 33 4 0>, <&sdma 34 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -1129,6 +1143,8 @@ uart6: serial@21fc000 {
 				clocks = <&clks IMX6UL_CLK_UART6_IPG>,
 					 <&clks IMX6UL_CLK_UART6_SERIAL>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 0 4 0>, <&sdma 47 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 		};

-- 
2.45.2


