Return-Path: <linux-kernel+bounces-427000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D276F9DFB14
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985AC281C33
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A516D1FA154;
	Mon,  2 Dec 2024 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="Ao1vJbyg"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA11F9F54;
	Mon,  2 Dec 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124087; cv=none; b=uc6TdBu/WRSgV5zvloZ2CqVKf/zgulH4BRqrng7YbfS+l/8l7km1TZOmoz1exoYXyiVr6hT6+NbpIh4CHKbVyxl+VIHXM5XIYH71DqTywNVqKeDF9drErcpeX2CMzwUGIRMmXLujLzpzDEDSFZ36a5Kwn27wFzmh4kYvqeVeNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124087; c=relaxed/simple;
	bh=7oROM/uU6QiX7ZsPyoU0SUBaeB4KfAZxWBmwVXyPBD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOtu3gOQ09p/HQSifvK9Q6ocE3ztjcHMfBBdBeTRSuQ2+KGgP82N3MAAmYPABzYf5mNMW10CJn3x5KPrRFB5xQF/XSO+rhx0biFrbSXblrIycr/Uy8cTGJuiQvQUGQRqpu899/ypFC9m487z88otuEy38o1HLjOlj6cylg4tXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=Ao1vJbyg; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7BDR6Ve2GPKeZi3IFw07Op60rY6Y7XNEznDb0xpMINY=; b=Ao1vJbygVyJybMVKDg0toStcTC
	ZsmJbH3Eq9MH08QDLwvjc9vqUL6llTnGqPYZ5B2mSSRkIH+XHtxzEn0ENTOaXHl6sodJsshyedAbL
	JC+dVHGKdOjyZD1NZHiVn3n4ZmsYQuviQLGx0PNM3JVn1SOrWAj7QWiHVpDQ9UKgbs7ryAoRMSS8H
	CCKny0YwTXBlOuH41/ptuc0C6Vwj8FDYbrbK1ZIgYUgtk0ch1onK8ELd+eOSYrjUgwYU54DQBh1eI
	2VgLN4ndu2UFYdjG5DfuqHaB+cOoFhyPt+79HOFuLM8HPVjRaN37H16zNvipVmFUaBwbVOXfGcoHV
	PV0aOo0Q==;
Received: from [89.212.21.243] (port=53766 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tI0kA-007Bva-0n;
	Mon, 02 Dec 2024 08:21:18 +0100
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
Subject: [PATCH v2 05/15] arm64: dts: imx8mm-phycore-som: add descriptions to nodes
Date: Mon,  2 Dec 2024 08:20:42 +0100
Message-Id: <20241202072052.2195283-6-andrej.picej@norik.com>
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

From: Yannic Moog <y.moog@phytec.de>

Add missing EEPROM and RTC descriptions. Also use eMMC with
lower-case "e".

Signed-off-by: Yannic Moog <y.moog@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v2:
 - no change
---
 arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
index 7e859c65317a..cced82226c6d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
@@ -290,6 +290,7 @@ sn65dsi83: bridge@2d {
 		status = "disabled";
 	};
 
+	/* EEPROM */
 	eeprom@51 {
 		compatible = "atmel,24c32";
 		pagesize = <32>;
@@ -297,6 +298,7 @@ eeprom@51 {
 		vcc-supply = <&reg_vdd_3v3_s>;
 	};
 
+	/* RTC */
 	rv3028: rtc@52 {
 		compatible = "microcrystal,rv3028";
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
@@ -307,7 +309,7 @@ rv3028: rtc@52 {
 	};
 };
 
-/* EMMC */
+/* eMMC */
 &usdhc3 {
 	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
 	assigned-clock-rates = <400000000>;
-- 
2.34.1


