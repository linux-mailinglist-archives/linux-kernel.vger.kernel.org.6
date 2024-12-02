Return-Path: <linux-kernel+bounces-426998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805129DFB10
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC990160354
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7861F9A8F;
	Mon,  2 Dec 2024 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="iDmF/s5N"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5E31E231E;
	Mon,  2 Dec 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124083; cv=none; b=dRqlvJ7A/bxGNMtpKv48gCu8jxWkm1fMOAIlKhRW2uWMGJp8aZAHriFKrpnjZrzEBeCyc5ASq2rbsguJuL3EW3SMOYSa3ZVsTf9gA9nPvHsVbxDvXpNpCAOR7Kg7Az0DHiWeTeVBuKcyBqAgQOVHUiHT3J3SmocXdpmJmwWzXSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124083; c=relaxed/simple;
	bh=TFSj0pVg9NsMKmoTaReudccvv/B4IHqaKK4BLVu+z4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oa2tpMBpz8LCLx9QvxTruaW5yvml+hhcRmmdroo/YIGpFZ+11jJA/lHH4sYKPOhyVdsAMvFdLoJdN/GJm9j5pEEnK7e0lXjW3U4BCa7SoOb20E6FHFTiIWCj8NOjrlee6bCluNTbixRA3O95ruvciKZf8M8ePihZXs0tRV1GOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=iDmF/s5N; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dJCF6u9wmsGGL1HlWysKRP9xUlakLUGKtnCwf31e46U=; b=iDmF/s5NGg+nYBMMYP+uLupgxy
	O/r2QoBPik5twG77UUbKUGb0+1R0NGODqhpCUX6BZ0pWEJDzYxxhyMgV5kel7GaM/4Kz+PRCfHw8Y
	pVseIn0zeGe7JYziouh3b2BfYp6IQo4qHVvlWhqQLS076HFWH5xmwxS4EL+5eB7Rc+AjjxSd42BBB
	1kh//I+4gOBokTPRraBjxxKjRxGc7EZiJlf5uSpLecJXuCqsx5PZe+3IVUcce6nbxgtupJOVuESg8
	hAWmiG/K+BImtpJZlGjxzvjgdOYirdanItvPIDa7oT+Zj5q7XR8AcsEiAegM9EQT1bCPNTGLfT/wH
	+RA6U6Iw==;
Received: from [89.212.21.243] (port=53766 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tI0k4-007Bva-30;
	Mon, 02 Dec 2024 08:21:12 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 02/15] arm64: dts: imx8mm-phycore-som: Fix bluetooth wakeup source
Date: Mon,  2 Dec 2024 08:20:39 +0100
Message-Id: <20241202072052.2195283-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202072052.2195283-1-andrej.picej@norik.com>
References: <20241202072052.2195283-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Not using pull-up on the host wake-up line triggers the wake up
immediately after device enters suspend. Fix this by enabling internal
pull-up and setting interrupt triggering on the falling edge.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
---
Changes in v2:
 - added Teresa's Reviewed-by tag.
---
 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
index 5eacbd9611ee..31d5c57d3c24 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
@@ -255,7 +255,7 @@ bluetooth {
 		device-wakeup-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
 		interrupt-names = "host-wakeup";
 		interrupt-parent = <&gpio2>;
-		interrupts = <9 IRQ_TYPE_EDGE_BOTH>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
 		max-speed = <2000000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_bt>;
@@ -332,7 +332,7 @@ pinctrl_bt: btgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD1_DATA4_GPIO2_IO6	0x00
 			MX8MM_IOMUXC_SD1_DATA6_GPIO2_IO8	0x00
-			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9	0x00
+			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9	0x140
 		>;
 	};
 
-- 
2.34.1


