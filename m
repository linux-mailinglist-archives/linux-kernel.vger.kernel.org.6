Return-Path: <linux-kernel+bounces-322587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC16972B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659701F25039
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0FC181317;
	Tue, 10 Sep 2024 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ApXvI83A"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010039.outbound.protection.outlook.com [52.101.128.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3DB1514DA;
	Tue, 10 Sep 2024 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954853; cv=fail; b=J1F1uITZbKmiyl9fQ3ceXfEi48dya4z1+x7DzqzsGtgFCEUl9IcuaRMkapxzdSUEiBNlLyQdEiOUAGQcpn172ec8Uwp0AuirVmV44w6p7C/Tj2WcCiWLPZyf5QFUtDxtLkQ9JeqZ42N5GZNzMI6jPmIt2VYzndk81psYKqwn02c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954853; c=relaxed/simple;
	bh=mIsFmPNF1WsQ90uQuJHjT8XHiotMUZdUbTD19LPGRVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XgfjSBHOh23Y8X0rfHjGsIk8Dadfeb1FOglYXGUSSuXODgeGT0nccZesv/L9WAVDB4BeNaWnOXpteu6MuwYLhm4PuvaNRNOOjpkr56hqMt34twaW5KB42qEiIOMDO7j0rWql5sgkmCZ4+k4WvcWPVvW1LBHRFX9CB+IPmF+sAjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ApXvI83A; arc=fail smtp.client-ip=52.101.128.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCvk4Kb9/zBw5ReXLcbXwHMsxNSs4vTnc7inTtoARI80XXc1qElfWGsCoripc1O857yPLChyC///2gMbftNkpLjy7F9gKnk7wnFwJ/9Usikay/CsezxPI+4i7CWuD67y/sZxNmmmmF9OM4//ZEAsmwdLiVzCy5vSAER5VjEY//QJ2rAczw6YBAH9Y021gs9ymQlxB32Dh05AMdhemStdCiIhxUYURGS/rQuQsFfztjjF9sPmoRRGxHp+EFdnhm5Te/j7wPceYV5LJubmThOtM7vP6Uj8sHeJHfwABTmTT+0aoRpV/XSPb0HOq7k5+gjkAiNRomqB8l/WJWxa/XYlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82UjMnDviUCfoXJpruXdvSFIJEpdlnWeojGSnk0G3CI=;
 b=Cs3CqzImjH9Hy4bKslGVGDDlKiWzf9XItKpfmkf7oLpodbvpmWC3bmWF5ERh1e8ysAuynQqg4ciweRykrpNYkFQB/+J7gZ3bAwR+NO+fRO5NLhxtCL6G9uLrW4+xrYTn6gjK6xP3liIOgZ7WQJyDlmXHMqIQMKjs9csyjK6CW1RoF5HNE0dyNWV96P3hDYU4VOyDEcMhAbShGG7A/9K/qXoeHWgwpvGxQ7vyy3iVVjtdmmlU8j4aK5v2Z/sD2qZfDqiw1iUAlW+PTbLYvfnc2IznMeUnC2EwF4zFxlWJ94wfA6xrMfjQpPKB4TO8XQ9re3E8zUZhyHbOHSmixQu0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82UjMnDviUCfoXJpruXdvSFIJEpdlnWeojGSnk0G3CI=;
 b=ApXvI83AuSwiiOnU7RSA+CGjk5RNM1oyoTA4sI/QeNai8bgYqTzu9LNrwr4ZOMlIyCshWprrDLB77b8+DUPAfNWk94zf0pvaiWVpbHYBoNzxA//I25VOPrvofdBNeswJI/5XKY2vH1SxyIY1xey6JoPguz1NdHLernTdWn+lo9MZEiE+GXGCF8TY6k0M1ZfbhCpJG7FfDd+cvy/WklGWNdsCZIP+M2ZBw7TnjO/iVU1D2ckrRIcWoghEXhYjiOZBoNWOpa3/SvhzCZ+8iELNbhxABaFv7de+XJfrxre9uD58gIU/xwAWVZaqSMUwD6l5k40l5y7IOPsVE4kMk0gnaQ==
Received: from SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30) by
 TYUPR04MB6932.apcprd04.prod.outlook.com (2603:1096:400:357::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Tue, 10 Sep 2024 07:54:02 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:b0:cafe::db) by SGBP274CA0018.outlook.office365.com
 (2603:1096:4:b0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 07:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024
 07:53:59 +0000
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
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add power module and ADC on Medusa Board
Date: Tue, 10 Sep 2024 15:53:56 +0800
Message-Id: <20240910075357.3531211-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|TYUPR04MB6932:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 089af6f9-8ca5-4092-23c0-08dcd16dbb1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTCP81XAn5pKeUNIB5JCufwbH/M9IZAr1hUvQPGdnnPLHEFCmLkFYSEX/R+1?=
 =?us-ascii?Q?N/jGMN9ExHcYtea5QilL/x23JZCdlcBJHstiaLkNSsofhRsJUCPs4im59ByF?=
 =?us-ascii?Q?10g+63cpDj9vHZGLNqBu5EJ0WPcvVn/R8fG8LED1CEXkan9t7pqw9GDybw8C?=
 =?us-ascii?Q?k0hFeqCMWbxwzv6id8z9KjlCM7WKWgaokzzDpuxXJ+nlYrzkwhki8UNkZiAp?=
 =?us-ascii?Q?K07uE1NbiIuiV3jjJ/Is9TuqnIl2xlv/QauxVsUaoq4IvSw4tR6kIZCo4Jrh?=
 =?us-ascii?Q?OGhU3JFrDzV4uYDSBbRPw2EdFGjKaB4QFvV0paY/eKlQ+TvrVmi+ippZULji?=
 =?us-ascii?Q?QByp076HkibFGm6kSJiq5tTpqqSw8C85xD7INmNlFY/EtSe0XJxWFN5E8Akg?=
 =?us-ascii?Q?aa5ACI5TYwIbY5FhFUtfgSDa5EzAJ3fz8gHxyNCLZikjkXof2GyZ0qD/WVJ+?=
 =?us-ascii?Q?3XgVyqUpGmgUVKV4SYOQAWYzcdqE/WnyRZNK2hd8yjmnKTvam8l7ZvXybFRy?=
 =?us-ascii?Q?+9mDvY/FE6hIsXjzSb0afeqZDMi3814Wm0hTPvjsuWhdPBt27NDRETh3GKUc?=
 =?us-ascii?Q?frPhGC+BH91GHuBcCRzFiqqiu2cGNNowlz629jYHa34Ev6SmG4fjgc1hRIMI?=
 =?us-ascii?Q?I41ufnRd7RxFW3ktj/6KfewYxefM95SOjMcnuNgo0qfVWvZE6tVM7dMyYxPz?=
 =?us-ascii?Q?UXxU4fFZI7QFcCw90/SCCnrOVT7aWPmckbseZxmHdHvTvsGB3uXj5UOQ/+uY?=
 =?us-ascii?Q?h5Y3PXuCorR2OnFpmE90agcmZ4br4g815548bN1V3E7HdyAJz16P5OJXm9Zy?=
 =?us-ascii?Q?FB/P+7oJUEuP2XRe2bV5WmoJlToC/7yKmXCrerOGu3jF5AF8eoP1C9dW627B?=
 =?us-ascii?Q?C4/sh3W2ejPAoc/J6/Re7FeUILMhdXjz+XnJEWt9In73Zg7ArfE8LCk/2G/R?=
 =?us-ascii?Q?i3U8r7fyKfHSSs5HMZrsYnNXuiEonq6U4YvoryZDg9nxe/Y6kki1yfNbwWL1?=
 =?us-ascii?Q?dv99eAc8hMq6zt3Y6DF+QcjyFY/DaUrqSna3nyKA0euJXG6Ohmfy/7PliarN?=
 =?us-ascii?Q?wpJUfB01f1G2DYmQlA4BT2DrHsW4Mh/txMxNqdbIKw8Wphq2AJW7izhJWzz8?=
 =?us-ascii?Q?Il0NSn6pKIDMtTxiSxQagO+86mi7m7onQoGQbY9baoJFnjIazQTbxhU0Cl3D?=
 =?us-ascii?Q?1zBld9qWYy0wL1apOMIrkgtPuBEnWg54ebw0guWwpFU2Y79PT5OHPY4uILcD?=
 =?us-ascii?Q?UV4ZIaxBGSNI/+ztX/gMU/8JSJRpSofdtX4qipKRzkxR/yokEjkbFUT10KwP?=
 =?us-ascii?Q?6iM5FN5kLOXc/fKMKXjLRuJRb2VdPbDp7knwYiLCUkjZYajxA+sZ221u6WBv?=
 =?us-ascii?Q?vINfNXkKd/oU2VNazv7BicVwV46nnTdCOU1ZHqfLY8bnHCDohNzj3T4bPZVg?=
 =?us-ascii?Q?8CdpEPO3EVw/kNhpnSQx2j+iFRHNbfeY?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 07:53:59.3691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 089af6f9-8ca5-4092-23c0-08dcd16dbb1e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6932

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add RTQ6056 as 2nd source ADC sensor on Medusa Board.
Add power sensors on Medusa board:
- Add XDP710 as 2nd source HSC to monitor P48V PSU power.
- Add MP5023 as P12V efuse (Driver exists but un-documented).
- Add PMBUS sensors as P12V Delta Module.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 45 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..e486b9d78f61 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -284,15 +284,25 @@ &i2c10 {
 &i2c11 {
 	status = "okay";
 	power-sensor@10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
+	power-sensor@11 {
+		compatible = "infineon,xdp710";
+		reg = <0x11>;
+	};
+
 	power-sensor@12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
+	power-sensor@13 {
+		compatible = "infineon,xdp710";
+		reg = <0x13>;
+	};
+
 	gpio@20 {
 		compatible = "nxp,pca9555";
 		reg = <0x20>;
@@ -321,6 +331,17 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
+	power-sensor@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
+	adc@41 {
+		compatible = "richtek,rtq6056";
+		reg = <0x41>;
+		#io-channel-cells = <1>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -345,6 +366,26 @@ eeprom@54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
 	};
+
+	power-sensor@62 {
+		compatible = "pmbus";
+		reg = <0x62>;
+	};
+
+	power-sensor@64 {
+		compatible = "pmbus";
+		reg = <0x64>;
+	};
+
+	power-sensor@65 {
+		compatible = "pmbus";
+		reg = <0x65>;
+	};
+
+	power-sensor@68 {
+		compatible = "pmbus";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1


