Return-Path: <linux-kernel+bounces-332612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A7997BBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3008F1C218E3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A2189901;
	Wed, 18 Sep 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="oGHM76aF"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7BD17C9BA;
	Wed, 18 Sep 2024 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726661285; cv=none; b=dZsNntlJV8pgIh34gh45DQzvPLifX6impUhd+4vdmpSPSkbbfJXfpeZ7q4rxddu9sHNNw91QiUP6OaVYPulmBRy9Vm9IbzjTOvMi3z61a6ClGz3P0rHk9DAGyD5xyCivGspHUc1hJ5OFukv9uU0zEUpPVXc4BRCiBMY16eTtbx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726661285; c=relaxed/simple;
	bh=e+grsrw7X10ZOPlPc72sgvxinJrP6CJB5urz+D13ZJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D6g6I5AO5bI8uqEazypJFcCVU+8sks6BjKod9hvTvUPRRLZpfY73gWOrWlhhlk7WkFDjKan/U675zPJT18NkzWgLejo96LoPTfzs454SXGeV1ifGvIlo3+sCuFRekvr1enBpISL+kwJ8g2fuy9NUBCklP0F9bSAQTyjcEPxDoLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=oGHM76aF; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ryG+DpEEYzpFDZHslmtvAz+CY1MLuD8QWuWHWwZLF1k=; b=oGHM76aFDy7jcPV83YF5sxSDK2
	xIdYCCNMmYegzplnPHkMwW9F5KSM1CvuWWTHJN42T5cLZrQyVGZ7MBADEyy04MReatKy4eY2SkftD
	l5LBMYcdnEVmI/ebPxbwzSHlVBoYK6/bVffUMImsqRAe19RyaESgStJ3s5eqz1sUBTpEgpc/SvEcm
	SBYDJ4DIXHRsYV8XdhV93cYShuQwNQLKJjeCZ7tN8lSj2tj99nVK0GxTFkFXkWlx3w4QPPdm7yvOY
	yZeNd5H5ZEULNDj3qD3KDgKzuc4KL34yVaAkwV2gpX0ZR9oroDVzMkEnMKJqzwO4vH4VVzSkylbLj
	63z22aCQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sqtTF-000Nl7-9J; Wed, 18 Sep 2024 14:07:45 +0200
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sqtTF-000Fv4-13;
	Wed, 18 Sep 2024 14:07:44 +0200
From: Sean Nyekjaer <sean@geanix.com>
Date: Wed, 18 Sep 2024 14:07:43 +0200
Subject: [PATCH 2/2] ARM: dts: nxp: imx6ull: add dma support for uart8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-imx6ul-sdma-v1-2-d25abd56e65c@geanix.com>
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

Add dma support on uart8.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ull.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi
index 8a1776067ecc..db0c339022ac 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi
@@ -88,6 +88,8 @@ uart8: serial@2288000 {
 				clocks = <&clks IMX6UL_CLK_UART8_IPG>,
 					 <&clks IMX6UL_CLK_UART8_SERIAL>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 45 4 0>, <&sdma 46 4 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 		};

-- 
2.45.2


