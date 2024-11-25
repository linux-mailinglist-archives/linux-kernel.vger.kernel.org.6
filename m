Return-Path: <linux-kernel+bounces-420651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370999D7FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DAC2833A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC718F2DD;
	Mon, 25 Nov 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="iv1oiJ65"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A449714885E;
	Mon, 25 Nov 2024 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525368; cv=none; b=BglCBGBeeRDSJl60HTtA34dIry7N5N5Au8x6SqbBIb8wQuLrt3tRq5JVHXa4n57uE3VbnYI6YZ/1x1FNOwZ1YaycBNPLTfwFBgTsXeLDeDUkx9XxlUF+9CPlB28RjrJul7fgxC3OmJw5raz40B6xScuAX+TpGG+a67UVSTq54LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525368; c=relaxed/simple;
	bh=moye7+rAbEF75I8Vz7/S5oWD/NyLQi99at0LkLw/DpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YLJymtxEsiTAlzoTseFnE9U4AC6ljx+7jeSydpeiv68TmCAcuR09yY8l8ZDhfKQ9T+DRZza6EeuAkiSaAMCckfTnlCL+QBMoV9g3digmnQaTTxYyr6+Ad+Y2g92Q9tsKAC9SjHlpYF5ODN80X5N/2VbBAKacjGV+FTR9R0ivJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=iv1oiJ65; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=V+qSCG7OvsEXIIRRw7Pi0nnCo1fiNOSsrVbS8QaQL6I=; b=iv1oiJ653Ry86VW5Opkp5TEqbr
	/ILa1wWx/FRaIP35zd4Hx9reHJOswpyZGnuYxxs9ZogIRAE88FBxuKRp8le+IGLLxb7IoTYcIOiA9
	jRCuxxLIAsh45GnBZfA/QFjak7DtnaxWvMg/rRWZX+pqB3EehTEQb2fkAweCr7bBuDHycAypsjINl
	7qAKVHMy+Yjj0aqav1Q9s+TSdvVI8CdOZUi4CvvPyQo+XZB36CN2TXiDYxwe7YTaTFFoRZjmE6NlP
	POJUAuv12Y7H7xzeK2HHpH7m2+Y0DBIBbhPpK55CRw8A4aOeCkb9WdxUtmvPOi/IYlsdIXJwPnqtR
	eNW4sEcA==;
Received: from [91.26.50.162] (port=58340 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tFUIp-00Eq70-34;
	Mon, 25 Nov 2024 09:18:39 +0100
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
Subject: [PATCH 05/15] arm64: dts: imx8mm-phycore-som: add descriptions to nodes
Date: Mon, 25 Nov 2024 09:18:04 +0100
Message-Id: <20241125081814.397352-6-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125081814.397352-1-andrej.picej@norik.com>
References: <20241125081814.397352-1-andrej.picej@norik.com>
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


