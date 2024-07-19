Return-Path: <linux-kernel+bounces-256987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D729373A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFC3280F01
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F71683CD4;
	Fri, 19 Jul 2024 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="raYzDYN0"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2089.outbound.protection.outlook.com [40.107.117.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFEA84A27;
	Fri, 19 Jul 2024 06:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368810; cv=fail; b=Za9AX2eZcTxFbxBousEh5sz9x6jWkg9RR3wp/VRxQvmW3kKnq0bjao1yzQN0rAK47uTU6qBcn7VhomyGcV9PTUmiboBAqDbIHv70+XyXZj+YcZXekEP7HPB79bTcL4oUQ6xxk61RtGN80KvVGMolGV0d2UzmnLesWc9oSve1HZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368810; c=relaxed/simple;
	bh=H+ztG9nn4KGO+7HjT0nWeoYZCKeBbNIFW1aM6ZekDjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRu1AnkwDLhSiRdVCuWKLDIb5pznXp2UnoOh9QWZQLtw07d3WzkFZyZMKFBXcWtuPViU1ZXVqAqeKnj+T20WzL0W892IsP2AMREigEGHwEwQQnJqgnwkJkKheBNTDB38oNk5VUOvdhhNzAn0fkr+TC5WGXd+Eecmzeae7QuAv3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=raYzDYN0; arc=fail smtp.client-ip=40.107.117.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJA2J+9/UZXNrB11dPHeri/dHKzJTSmCCLHVzGdZ88kqi+6iBHenTT8uxjOZL9jBm3rDMlGiGr6cK0L0d8eHR+6dJrSl1iw/j1pAV3AVpzFDBwoeV/dwVPQzvrgGrwkXg4Rzx/CXRABdmNqOsclzIVjEJrpo1aWq9OOsuUZEzrDnnntyuWVEbprv9+b5m2fg4agwOGV5Cj9LnNetsi/7C6NpzwrjADrTDLPONojr92VWa/gjmDiW1H1CgrkuS67uVJI3xm52LRLkg1SaCuEwPTNVCljTdGo9XZOzfKVBqGsTUmaxs/zqLmVJ4KuQHhj54VD/xV2I0Nk5vGaovhdu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Q5MeEW03FNC2r/kxYIzAJUQLLsW+EcYLhskSOMMcDo=;
 b=PqSRJE20OJNt/LEuxHFVyqGNySnQtw/xTansg+CJg0yD24MdqU3SRaCsc4KWBbo5aiLEdlITMbc4ORjwHYU10pmFgK6Zim2LkTae2eU8yJs0huhpYOQKoDwvEXOebZ2B3+fq1T7j4prqmBFfFrUCNKszpet1qrsANLZOTKBZaUlzan3cD1dV6uCOsvfjj8vfDXiCWUCsDUAjj3HglR878+4K+93TO0iajyjtc7pHoUqkOCCU88voWuiYWVKEJWjRnGYwr8zpuyGESJzSII0Yl67sC6jr6N16HdT/Bdprrh+K8X98cDJd+6f5GMIHTrUwmuhV6s21xyqPAhdQRsC6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Q5MeEW03FNC2r/kxYIzAJUQLLsW+EcYLhskSOMMcDo=;
 b=raYzDYN0mr2I/ZJjU6zhD92mFxMhlAGWjeRT1YYPbHirViKWu9wn9jcKeiwGxn8sAIB2Fg31fztLX9zDEOYE0rPTjCLpwjfnwhVES3BXw0qUCpdjSGhLfnjw87e8+Hc0OiMRNONR99lD1Am2CiM5jJ8zwzFb07BnLN1jnrKFi0GlubfPXG3pU3jmWQXmz+c/GSMnSVZEwQU3lIhO1n2qyjjPRAmE6M38xV6Gzfq/vEVMzeF9kBAEyQCah8ac8UbfxwSmPpgPnA39TzDM8YLuD5UNfTa3mkyFRa+vWdkpmvGTthzIMPCXOJy9M+8bV3W6sRhlVsNKo5x8qD1/6J8XzA==
Received: from KL1PR0401CA0023.apcprd04.prod.outlook.com (2603:1096:820:e::10)
 by TYSPR04MB8160.apcprd04.prod.outlook.com (2603:1096:405:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.6; Fri, 19 Jul
 2024 06:00:05 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::2b) by KL1PR0401CA0023.outlook.office365.com
 (2603:1096:820:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:03
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
Subject: [PATCH v10 12/27] ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4 schematic change
Date: Fri, 19 Jul 2024 13:58:41 +0800
Message-Id: <20240719055859.4166887-13-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYSPR04MB8160:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 42337f66-107b-4833-e3d6-08dca7b808a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bPzf3FiHTUEhqUHdP6SQXYIok69KfeCFTD+A2wVQSvVVaAGSgzIm6xUBbC8o?=
 =?us-ascii?Q?tRtfulqBHZG0F+D/akl/0tI9J6z9yywBSFVFhzMrV6J1AwzYU2q9NnfeWxMr?=
 =?us-ascii?Q?lwcxGTXv6XMggiN/HZC3iDCuFwp32g7To02BCzePJPgJbaA+i2FUPz5PUjen?=
 =?us-ascii?Q?TIsKKQeS5x6KapPv3kjJMPJ7NA84QxOKC2X//h/rjggrbt0yR68/71QhSzDK?=
 =?us-ascii?Q?nWltBgqKfRcGcALJhRFOmw72uMGaHtgzKlIr47IPe7IUXHk15eK92yOlRAv/?=
 =?us-ascii?Q?sUSuDrz8Uf1s8bMljqnDmH9Nm8Ef9X2mB1oaRvcDfqwV3/O9J71YD8yqTz4G?=
 =?us-ascii?Q?63+zF3gqFODaFhrMP5WdBrt1KwhVFjdYdKC5eSnsIjt0AjUGqenHdmhHF83c?=
 =?us-ascii?Q?K30isSJbEyiHOr4drcLbcMKU7xr0Fvk9+B/y0oICCsGL7obMA/BV5lS+I07Q?=
 =?us-ascii?Q?bWXCr2N3x+Ki3iYA/F30gveOLnhYtXtjeZfZ/OrqPMwp/hAxagGcFjVqo69E?=
 =?us-ascii?Q?Fxg2xC8vXUIRmPFxqQv3J2hYKBFCQflcGwwNM7yWZauh4TfgQtbO51YITvkV?=
 =?us-ascii?Q?HzH04ip6pLvNZM8TOrfO8Ks3SX3wtrZ5NfoJ9/fF1leS7VLv1gR+NLl05q71?=
 =?us-ascii?Q?MIlPISgV4F/VTRem0YF3wGLMtpGq2WWwcOa49n0ovF/3yHTPkTDnd7lM7lTf?=
 =?us-ascii?Q?IPCPDkP7KgBkeC5lr+UNb1TvWzonNfbIY2Z5uXOhRj6DUIaB8+1KKHViUdnL?=
 =?us-ascii?Q?CEi9px78hao8/CsFspwF+bPDUsfC8uK8OuBQ3HeHA8niOnPKxV4ZLBjH72MS?=
 =?us-ascii?Q?4RBuKTsh0AiY/s6XT0MdPSJ8UbnJxBRfQ4AwjizgHmN1Q6b3DDI8NlVh0lWv?=
 =?us-ascii?Q?d0Yd2qnq0552xgU40jTSrWL3lkavcuzWhC1Jq3zXyI+m+UBKAvg5kex+Riah?=
 =?us-ascii?Q?Eotfm6HCX+KvEY4/RUSUa4PhDfZhB5WzejtTokog+6M6RFVhn6H+1ggA9WfO?=
 =?us-ascii?Q?M2hzirpNUqFfGeQ4y2PIXtKtzbzSTNyOZbcSTsVlOcxEiJV5zena+vvd0uCA?=
 =?us-ascii?Q?SfrbhYBVCk3FEMca2tje67cbIb3OQKqBIYTIz5RLopLt1g5ZLasi//8HLg0y?=
 =?us-ascii?Q?I5bVNfbMtHa/r/GE8eU8+dRJBe7Dzqd9cls9TMpmMmboBIT+BJKA7g6RlQKW?=
 =?us-ascii?Q?2rpUT6IPl75lluJXjggCECsiRR6heAmixEUVq20golIo/34c6xIbhrvkDWOU?=
 =?us-ascii?Q?Dl4WsIIthfYOOPB8qxCUV2IcPGSj6dKGwljJtqyVHtPFLjbFIgb9fd9arFxk?=
 =?us-ascii?Q?tBdt7sgTBQjMAHj5Wh6EQuDmLcRABhenvghaJWKnQL2cdLAiG5f9HkVsB3dG?=
 =?us-ascii?Q?Z49/PsFBIGoQMHzpoQeJGl63sXkByi5+ucNOI77mpNQOcuJpZF1V3s+nxheM?=
 =?us-ascii?Q?RkyqrYTPYT5+Xa+zsUlo+iNdbejXNDk0?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(34020700016)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:03.8138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42337f66-107b-4833-e3d6-08dca7b808a2
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8160

Remove temperature sensor for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 9a14f0220cf6..8f3bbdd1bbc5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -921,16 +921,6 @@ temperature-sensor@49 {
 		reg = <0x49>;
 	};
 
-	temperature-sensor@4a {
-		compatible = "ti,tmp75";
-		reg = <0x4a>;
-	};
-
-	temperature-sensor@4b {
-		compatible = "ti,tmp75";
-		reg = <0x4b>;
-	};
-
 	eeprom@54 {
 		compatible = "atmel,24c128";
 		reg = <0x54>;
-- 
2.25.1


