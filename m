Return-Path: <linux-kernel+bounces-518737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B12A393ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888C97A14B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDCF1BEF74;
	Tue, 18 Feb 2025 07:42:44 +0000 (UTC)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5541B9831;
	Tue, 18 Feb 2025 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864564; cv=none; b=HXD/m+3tSl1HEMzPYhb0PHPyatPUcPIgSJ/cqbx+lsi0GNqrqa8m4xZE1cCAZJCunT0ySEsu64/jjtFWu+HvjdYl4hqguV2IYBpwTaW1tBVCCu75ORoZJUwT+zjV9pjVPnQorEjb86CJcMTm7ljQRFHYNgKehSFXPiVlKgEj4O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864564; c=relaxed/simple;
	bh=z6rTma/8fWIygAwCGXpCNQU/r5/brk0vEhIJ6E9K3OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P7hGqGSBcXYxVL8S3A762CCp4JfoCNlgMP1iXym8wnX3h8Bdah5w20KCi8nNRoc8gLi2EE5IkIPD+flAXmdFTw3+hRdBMn5ssUInYU+KEEJS5CH9Pa5Rctvi6PdUZ+9kOO9Yna/SLy7Nauk2ZDnziW9n0aSU8rtWTxM7H1TwKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:52604 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tkIFd-00G0MD-0L;
	Tue, 18 Feb 2025 08:42:40 +0100
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
Subject: [PATCH v3 02/15] arm64: dts: imx8mm-phycore-som: Fix bluetooth wakeup source
Date: Tue, 18 Feb 2025 08:41:43 +0100
Message-Id: <20250218074156.807214-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218074156.807214-1-andrej.picej@norik.com>
References: <20250218074156.807214-1-andrej.picej@norik.com>
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
Changes in v3:
- no change
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


