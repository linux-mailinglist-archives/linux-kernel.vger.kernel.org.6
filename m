Return-Path: <linux-kernel+bounces-289375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A88A9545A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4305B28270B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0CC15383F;
	Fri, 16 Aug 2024 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="b5q2+m4r"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010047.outbound.protection.outlook.com [52.101.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB45152160;
	Fri, 16 Aug 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800316; cv=fail; b=DXfb8J/i7s5e7rN5vEM/FI+oM/tJw3AESZ6pEpw1qb5NPnn4dhneJaKdSRg6nstfikChSItnhlsqPEzEH6AdBXu4vRAo/2leHj/03lOgM/weY9W/qTCm6KXjQFA0DLISTL8TDwjn5fnNJJg7P4DnN5LGnw+ycJsa07sG1kJ4y18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800316; c=relaxed/simple;
	bh=jlqOSxEPKHkI5dL52Ybr7lYRxAF7bp9tTwUj9yreez0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwJE1j6AkLuPz/7u6j9m23EqIQOzuZXCaLtqzXBXHR88H7EvQ6vFxUAP8tVcQMCfWidz4Sm8QFhBQ3kKmALaJ9B39zzx0xZziOcPVVVwg0TKlomw1/JBby0R3xygsx6lc5UunvBjKf8d236xNHCPKWn1NognI5uWv7Jk7oiWiCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=b5q2+m4r; arc=fail smtp.client-ip=52.101.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0ZWqJwvmeQ02QaXGjfoiHDWGYTNHecelukIeSHD/UldDVCK8fADZ5jsveXNA1W+dJJ5FqMwmOegP+uBnvXF87F98cmEDmCx+N3PSDZexEesltCA3/tNoEun2cIyGYKOZoMq7IB8A57re63wyij5FKx5+o2Sww+8EV86qRL/8hTilRAOfy5nsYjCQH743K+BvnwkbnlxYg8Qb9ocVOixXEdDRkCJ0TIlr6CzEu1FLrBum5ddCQeABms5xZskNq35cARXioeHwnkaAJRnZwySX1IPEGr/IWSiWnUwouaNR0uAABwjTEYV3PhWbtDamWlGxCCWjdDaWq/CqeWXtOoSNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JazR4JFYH/44Q8aeFrnjOL2rYIPNbPmPhwoAEXWC6OQ=;
 b=tWgZU3MHRbZxVlx11B45Sxz3blkB6QS7eOke65UV3h8r8W3MJyAm/zGiMgrFgvXyO8kQY5fS1/Pl9OwbDnDuqvqVUIVFTmEj2Sc3bdYYCJDVIxEJhnE7pnfasLtkz4cfkedpJyywHSXipBDi88XuvDxJuq76wsambbU/PU7eI8Hq7qmLzxn07PbhqJL/MEJ2/SRrCzAilhk7RmkuztigjOPI1/yvEj1qS6uRc6tDpMLs/WcoFiAEMx0VsTMlJFtXqm+SU/Xbg16fsvtvf7LBj9dh1OYnO2oslV+C4MQKBaSjF/bvjFeXL7w1oa719SMpHoXM/tG6N1MtrVAH8ao9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JazR4JFYH/44Q8aeFrnjOL2rYIPNbPmPhwoAEXWC6OQ=;
 b=b5q2+m4rjcFtS3TqqEIDL8h7JnE7D9YsOamRamkPmULKwU4rQxGdIHbPDQe8qrZ6KtV+zVEovKA1cqzh9wyhZxLQ3OS108guXpl0/pipKPfd2P3MgTCWKOI/WeOixEhLHDvm4GT2UzbfjLuF+CBAgathHNdUvlIVXuoHzcb8WWHeLFoDPl4knwHDgrocd5lWQ1tmVYlZunQCBK+fVbi0mxwM/AJvuuJNSYYHJg8U6y3HIzzs7XqO3BzestwoTG5ipro+fi29t10IJ9hpRoctfh68WabahCBQi6x2GEERBET+DnLfZODpv8sK7YIpucp7NruWtLHZVmIHgSp7jK8+mQ==
Received: from SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) by SEYPR04MB7400.apcprd04.prod.outlook.com
 (2603:1096:101:1b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:25:08 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::cf) by SI2PR01CA0047.outlook.office365.com
 (2603:1096:4:193::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:25:08
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 09/28] ARM: dts: aspeed: yosemite4: Enable interrupt setting for pca9555
Date: Fri, 16 Aug 2024 17:23:56 +0800
Message-Id: <20240816092417.3651434-10-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|SEYPR04MB7400:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7d074948-fd5c-4861-d340-08dcbdd5521a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wj6IAuQJLPAVVi9FsIdDwYBpIeHv8SGylx6DvwN5SnLoGD+g2jgtlYjlv2Fl?=
 =?us-ascii?Q?UQMeMNxqRkSsBPXLU2JxhHWHUqXAjj1Cxz9e2b87fuVLX3xUsuOTZcCDmBID?=
 =?us-ascii?Q?wEJsvWS7abjGuDpHdo8PaIts3JWY4tqIcm0G+El0nQNZzC+ySDOjXe25dZBR?=
 =?us-ascii?Q?5za+IC3esues1D7VIt2ErQ5v7zAKU4/4GkeRfGFK8cVztOfHBmAdNNkQPoVH?=
 =?us-ascii?Q?g5OQv6wNTkGRs4P7WzNmWftScBKPJHcrxbt+O60ahhujdW+04VDmbTfBQtnu?=
 =?us-ascii?Q?H7+sqU8oL6FftQ/zHYg6ZeAnqoyCpIVK9ZhxJfTAFhUAFgMQ3kpoMjzNCuq8?=
 =?us-ascii?Q?e/lZuCLvHxbz395uyumJV/5BaNm79/8345GpFoODK1zCgwWGu3LhCvexT3Hk?=
 =?us-ascii?Q?c08MdC7UEi+F1z/l4iC0jTikUM1wdAOD3REVOV+2LeNnAvzAP8854iEFsgbm?=
 =?us-ascii?Q?kE6pcHDzW8Bc5IFtEb4kLhL7DhCEeehTXvMSTMUisxJFB3dQMuCQLKFi0kdw?=
 =?us-ascii?Q?6PbO5MgGj1lNliDpk/QuYQAhjJBj5HXPis6GlVbVIxSOeatnfuKrOYaEjE2P?=
 =?us-ascii?Q?q7nkcVS0eQyHd7gb6L35QmZKzp5j8hk0KjyUaLrx5419Z/ncJYVisOT+9lck?=
 =?us-ascii?Q?KcjdatyPgGnLGQi4OLkYN7WQmsZpvHVLFFjRFGuv1IvYtES0eIu6jWaRf1MF?=
 =?us-ascii?Q?kP2xkqSmCR70YtDhRrxydLxHuavbQyL6UAE0Z0F6Sz+Rf9+44JEohIWPT3Fs?=
 =?us-ascii?Q?DLYJ1DF8ExhHBQT3JElSJEv5UGDwFujD0lssgV+OFws2W1FmzebhhNxdf/8X?=
 =?us-ascii?Q?thmD5HpjpEjUx9G6UKzCh1NeSeTse28C76Y9pIRImK04FiBCh8Na5Ia5yMp1?=
 =?us-ascii?Q?sOZPa8rqG3LccO2klQ0IuQ/RrKOKusN2JMTyArMTj0M4INoBRMdxJGiLLfVG?=
 =?us-ascii?Q?OG/b1GiRSDAamYLWoVBUlnPCNSmKPRZKMuC/Tpf7mOi7/FtIljdvdnQ9IAI3?=
 =?us-ascii?Q?6JZ6a1k6Y64yg0UH/ffNbEw5ESvI4XrpcWHiCaHDzX50N0YQccgVtKJAO2OW?=
 =?us-ascii?Q?xqAvGsYoGu7iw7TINnNxy1O/J+DtA9hTra6scFqnzX2dshISKCOOkxOwhi0I?=
 =?us-ascii?Q?nxCSRg/KK1OyMYwssw3sFSJfsR7+ayYA2JDHnS6wtUpu8Cr9J2KIf1jV70qA?=
 =?us-ascii?Q?kGXBne67/wsLEBknQ12daenAsjnZboXtaYCiJAbTbsrJO3Wz2b8WfCSFMcnq?=
 =?us-ascii?Q?RxseKzxPNpJmj652Xvz5uERFR7uIhVOMuEBkwWLwab4g4qmxIt0e+mN8cddw?=
 =?us-ascii?Q?K7NIgMM3rrZ8/KbCDS6wv26gkp9oYwRW5FbLVTchHBjccFh+4LNGPNQZvuO0?=
 =?us-ascii?Q?7iiyyTvnXiofTcj3jEy+uDTdpQtU6MlxX1tUktyqKFv7UNJnSne+cn2bFjyA?=
 =?us-ascii?Q?hpNmlOJ8tQnmTd6UUdTiWf5zmsYSGXaG?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:25:08.0753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d074948-fd5c-4861-d340-08dcbdd5521a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7400

Enable interrupt setting for pca9555

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 56 +++++++++++++++++--
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b11951c2f71e..09bbbcb192f5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -832,30 +832,78 @@ power-sensor@12 {
 
 	gpio@20 {
 		compatible = "nxp,pca9555";
-		reg = <0x20>;
+		pinctrl-names = "default";
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
+		pinctrl-names = "default";
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
+		pinctrl-names = "default";
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
+		pinctrl-names = "default";
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


