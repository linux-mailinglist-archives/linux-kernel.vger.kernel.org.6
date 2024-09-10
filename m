Return-Path: <linux-kernel+bounces-322495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA89729A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BD5285D64
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4228E17A583;
	Tue, 10 Sep 2024 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ngZ+PZ08"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2051.outbound.protection.outlook.com [40.107.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8680208A5;
	Tue, 10 Sep 2024 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950405; cv=fail; b=Vuej01SppTf3YHMYi4rKUqQfAAahFeHk8hmICfY7WbTrWP5S78GZE+SQAjx3sPPYStlJEmG39o2gINRL5mB2mNzsA+HICPiTSUNABGEtf6zDn3s/KbkTS/egc2HUCol1l2KfeAsS7eU+BhuWapJjJuLSAuBnggGhouyRZdB2xSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950405; c=relaxed/simple;
	bh=+SfW16ZtYSvCwsYVELcQ012gqnBbk3Jsi1fuDhnQqAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZrGSYYX/eZNWEtzYByPCgO/l5Aq8g7/WHY06FVv2Rs/Ram/pxMEbBoic8CDOCYNk9eIkARFllm3JQjuZQWPvQPtQasHBtwNdDwOiMvdbB5aRCh3QS1Z4TXeLwSeU1OcyPlHTJqbnlreyPDO2pRx+sSz39M80CA1te8UNiKd19yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ngZ+PZ08; arc=fail smtp.client-ip=40.107.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8I/uIiEWL5Je/VX5BjSGjhDy1ccOk1x5M9bFdq+y8g9sKYcaNjqvdmkviL0lkyw/0g0O1zKQiKWq0/mzl13aml+RuE/ytWViLl+VCJ++y7x4+B9+OQ4dPjBuZPLBbzEBcxAmINElceGlrN2HGcPioow1lXOxuVpd323HAjvbrP1cvwAbG+pwknToaovulobkxVWS4dSwtXn+OHTWQa1kfd+clYlyu0fuD+hvQxs8Eb74IGAniQeOmIYNshv/xxTWlQCDaTZmNJgveVTjYpTYkvMTe+rfA2DUjbDK7yc6ll9RfQFLZwi2UKZNIHfWOQ+OElN6ClvlHKCGZHbOPvizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osuM7RYcT79/L9v4a9AqlEhxPIt29mwan6goSZIdUTw=;
 b=u7+zzb4xA1moPbP7faQdcc3wRaT2OOpbNplVxSXJR186xXa0Is2H+n6QEeREhDSeSC2kFgKlKx0+jedCxMX1/8mTqpd54ve4ScGXFpdkA+vj82zUPWl/JZN4+2oxyhT3v5TnLaagh11P3sgXvyiFiaQLtwio82NzxcNbOa2B73GtoM5FwBWCfLox1JiSsaginRIQ38buOfqqnrA1W9lYf0Ayp15j7mnaHB6P+2FBfMRDMIP1r7YxmIY2IN+W24WY2R8wwGnPH5Przr3ZbSuk0ziQFdrj/7k7tMd9eZt4Q6ANowT/HeCYfkHUOIjdw+4N9pvkZw98hOjIyR5ZTXZ7Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osuM7RYcT79/L9v4a9AqlEhxPIt29mwan6goSZIdUTw=;
 b=ngZ+PZ08MRsXCWpc/vSWTdbYVA7iYoygJLNnXwMA7qR5XS1K1dHI1TNimWGX6WpGf2J0Yfy7hON5JavjDfo4pyBOJcbtqqdlQBdvfIoDoG8zMZwpx+Byu+PyH7MqokCBzzBKGqIVLM0cOM8d+q0J3q7VlGUcE9T1Fvzz4LunnNY1aaf3oTrYURIuphNqtrXS/uXaSpvBgAmXLuKlPJ6HhINkVJvyycEZitvzPBi/QD2WZmChDsKR4JT1mxIDGC+xGzoicpn2etbMgZBhSnvtAi/i6zLfVVGmCvDJVLcjriwcwi5B1vihs0vsftTwGsUSh9xCdfnzZU9U+yoa2jET/Q==
Received: from SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) by
 SEZPR04MB6501.apcprd04.prod.outlook.com (2603:1096:101:9d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.24; Tue, 10 Sep 2024 06:39:54 +0000
Received: from SG1PEPF000082E7.apcprd02.prod.outlook.com
 (2603:1096::cafe:0:0:19) by SG2P153CA0009.outlook.office365.com
 (2603:1096::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.6 via Frontend
 Transport; Tue, 10 Sep 2024 06:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E7.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024
 06:39:53 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
Date: Tue, 10 Sep 2024 14:39:51 +0800
Message-Id: <20240910063952.3006665-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E7:EE_|SEZPR04MB6501:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0483e709-8e14-4288-103a-08dcd1636154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?56lczstpbokUphtQQ9kDM3LsqHs0XgYj/W54LQ8INrs7xt/pM9Sc+/0j66xp?=
 =?us-ascii?Q?KGwK7M/r81Xlr9UXDdy+QnHVdF4QVweFWAV1PVfCog1530ZWJjP+YqxRQbfB?=
 =?us-ascii?Q?+2vvvilnLadPf/bLNiMKyciMafQPGIxB/xUk5LK+jLplxpXhlb4OAVAZImOE?=
 =?us-ascii?Q?KaxCSyaj2AObqgvn9HcsKUHBQ9qPHMDKQnCoHhjyGKaNRt0qVb0/WUWq5e07?=
 =?us-ascii?Q?CD54i/byOHeDrMpbuvh08ukZjt5/PIXlhkUUTJYRH8aAOXMPCEPnHu1OuMZi?=
 =?us-ascii?Q?rb8hqhMx/YAAlbJ13xAuK1cd4UmqPB9ugyjWnVeXkXO0meM+ShWnAhEwziR4?=
 =?us-ascii?Q?829TKAgTpUm4ca83nCaJaBjZi+hXceN1sHIiyxoWx4B4IfqA33MPOG2fmZhu?=
 =?us-ascii?Q?TjybK9U7MiBtr/Mo5OWLHMf1BaeZeUsdz7huox4l2E1MhJunDo8t9BDrKqG8?=
 =?us-ascii?Q?6hHpRoDBfrSIu1PXP1EIK54QH/xeCiWNY6brjaVCFJFbU7YDO2jgNqUadNHA?=
 =?us-ascii?Q?oXc0sPoG28jdPpaaU13nlIKxnn7uUWALW/WQQy4sJv1wxh3oRL+5xhQ6Ti06?=
 =?us-ascii?Q?laZFae1NcLMnJfDjaWGXg5wBh6nhldowJOhRA0IHGFZoIszW1nOJKSqPVNCO?=
 =?us-ascii?Q?d6nDvAmd7n5QLQVwfX62PZJIjEbY09FSkyERl+4HluS+Q6pUAM/nBWTH4Duv?=
 =?us-ascii?Q?cuU2vIkXkiW0egMucB36qHrTrGb9QXPwm6JPoGuHQsZuUhmWUyJnMvDTLpD5?=
 =?us-ascii?Q?vscV8kz5ZZQmQWCDSMj7w9CvZOZlFJjn1aD8hk8ECQqa9PuMw6phOeZLMXTu?=
 =?us-ascii?Q?wzElfJcv6P83xfgEPbI7PH29a2E5NYtY3pXUevF5/DXyIkTtzlqLrK9NICxm?=
 =?us-ascii?Q?PoylGq/My0rHh4Wt2dlY6dyNOd+ioameCQ9XFKNSJSjaX76XTUpwrf0ocnyS?=
 =?us-ascii?Q?cuG3ZGAFgxnCLsJ3bNUPEfJAqql8ZVBx+2lgRm9UX/BAGiOJNQmmCpKXmJ9e?=
 =?us-ascii?Q?GBaMrZCtiH37XDGL+cKORIVs84IjsNC5tk2EqPBDg8vxgiAwMu6gKVa5QsAX?=
 =?us-ascii?Q?lbkHUhhx7zWzU8cAVtN+hkAD2cG5E4eog4ur7gOFAEkjGfTHtkxZIg25EDkk?=
 =?us-ascii?Q?irEfNIKwS1acClVGmiCv9qD6rIkaAI5MqbyXOw4Bm1uSQ74W0Hgrlrf5H361?=
 =?us-ascii?Q?2TKKv+dxy39nuZx5o4cIEShqR7dWeL4KlA8+gREYQWiMdZaikc7++k/Aq/AK?=
 =?us-ascii?Q?Ph6CyqbuILcDoqkX5xgkVEHV+dApstkehBKgfBws5fl3ZtoFwa6FVJ9e8gPG?=
 =?us-ascii?Q?92GtewytvIYJPniJorhvxuoAsbh95HcTSV4yz1IGaF+83GHuXRURsRIs8yWq?=
 =?us-ascii?Q?5EcK5llMUlnfkV9xwMr2Djv/lvOTTuwmx5xEjYU9CC2ER9fiQWHL2MRG2dyD?=
 =?us-ascii?Q?RZpq6T9hCqx3s13mAhCpXuRiC3d7hhMR?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:39:53.7915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0483e709-8e14-4288-103a-08dcd1636154
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6501

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Enable interrupt setting and add GPIO line name for pca9555 for the I/O
expanders on Medusa board.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 52 +++++++++++++++++--
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..cb2436031181 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -295,30 +295,74 @@ power-sensor@12 {
 
 	gpio@20 {
 		compatible = "nxp,pca9555";
-		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"P48V_OCP_GPIO1","P48V_OCP_GPIO2",
+		"P48V_OCP_GPIO3","FAN_BOARD_0_REVISION_0_R",
+		"FAN_BOARD_0_REVISION_1_R","FAN_BOARD_1_REVISION_0_R",
+		"FAN_BOARD_1_REVISION_1_R","RST_MUX_R_N",
+		"RST_LED_CONTROL_FAN_BOARD_0_N","RST_LED_CONTROL_FAN_BOARD_1_N",
+		"RST_IOEXP_FAN_BOARD_0_N","RST_IOEXP_FAN_BOARD_1_N",
+		"PWRGD_LOAD_SWITCH_FAN_BOARD_0_R","PWRGD_LOAD_SWITCH_FAN_BOARD_1_R",
+		"","";
 	};
 
 	gpio@21 {
 		compatible = "nxp,pca9555";
-		reg = <0x21>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x21>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"HSC_OCP_SLOT_ODD_GPIO1","HSC_OCP_SLOT_ODD_GPIO2",
+		"HSC_OCP_SLOT_ODD_GPIO3","HSC_OCP_SLOT_EVEN_GPIO1",
+		"HSC_OCP_SLOT_EVEN_GPIO2","HSC_OCP_SLOT_EVEN_GPIO3",
+		"ADC_TYPE_0_R","ADC_TYPE_1_R",
+		"MEDUSA_BOARD_REV_0","MEDUSA_BOARD_REV_1",
+		"MEDUSA_BOARD_REV_2","MEDUSA_BOARD_TYPE",
+		"DELTA_MODULE_TYPE","P12V_HSC_TYPE",
+		"","";
 	};
 
 	gpio@22 {
 		compatible = "nxp,pca9555";
-		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x22>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"CARD_TYPE_SLOT1","CARD_TYPE_SLOT2",
+		"CARD_TYPE_SLOT3","CARD_TYPE_SLOT4",
+		"CARD_TYPE_SLOT5","CARD_TYPE_SLOT6",
+		"CARD_TYPE_SLOT7","CARD_TYPE_SLOT8",
+		"OC_P48V_HSC_0_N","FLT_P48V_HSC_0_N",
+		"OC_P48V_HSC_1_N","FLT_P48V_HSC_1_N",
+		"EN_P48V_AUX_0","EN_P48V_AUX_1",
+		"PWRGD_P12V_AUX_0","PWRGD_P12V_AUX_1";
 	};
 
 	gpio@23 {
 		compatible = "nxp,pca9555";
-		reg = <0x23>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		reg = <0x23>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <98 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+		"HSC1_ALERT1_R_N","HSC2_ALERT1_R_N",
+		"HSC3_ALERT1_R_N","HSC4_ALERT1_R_N",
+		"HSC5_ALERT1_R_N","HSC6_ALERT1_R_N",
+		"HSC7_ALERT1_R_N","HSC8_ALERT1_R_N",
+		"HSC1_ALERT2_R_N","HSC2_ALERT2_R_N",
+		"HSC3_ALERT2_R_N","HSC4_ALERT2_R_N",
+		"HSC5_ALERT2_R_N","HSC6_ALERT2_R_N",
+		"HSC7_ALERT2_R_N","HSC8_ALERT2_R_N";
 	};
 
 	temperature-sensor@48 {
-- 
2.25.1


