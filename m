Return-Path: <linux-kernel+bounces-289383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02AC9545B3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCE02817B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E592158D91;
	Fri, 16 Aug 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="mTIP82li"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2065.outbound.protection.outlook.com [40.107.255.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB7B15853E;
	Fri, 16 Aug 2024 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800350; cv=fail; b=S9WCwq+sJn5AzL2skqAbQsMcrJDsc2aubcmxgW5k2xNsv2g4vxhPs97lD8LU6hKsrJbxJLzYl8XymYyr68Gz+b+Lm0Lmiwj2AKLtR5h13ENWew4ukNQxFA/++ksszPNBYXUbLVe1XrkH85zYrQjGHMIEwbqmFLNC8Gf8Xkkm9Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800350; c=relaxed/simple;
	bh=IjUBTAVCU5Y6ChjiBa/OvcgHFZFxyyiZfGefmSk6xyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYqN3cuZecFoplD/QRJxy53K2N56AaymoRBuUJfTHoPFPbNAX1eYIIB8x8DOm7eruqIlCx62RN6n3I85mdzQJsiVsXaOsq5iXZaIz0tw8PnWlS8paOccHjwQkfULBesXRU2ms8U9eW6ER0uzEHj7olWyIqDBRepixO4V7sM6j58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=mTIP82li; arc=fail smtp.client-ip=40.107.255.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/5wgz/DEPjU/OVffHp5EC0PMugjrAt/oSdoSL/sTfzgcG8DW34ss5vU+T9WAcI3tZZHAGYuXNXvhz3B3S/ZZZrc2dGEsyj3pUyu7WaZ/KHQVaC8KDLp8b013JNKliw03a4e0A5/irdErpwDuGf5E+/b6kwu3pOS2TMcNFl6foYcBzFFHuFuPgp1cw/zf/h5VwOaUyhQa+FW4qI6OQeZQmPcX7muxz+Lj3Ze+m7EAqdmE18SlmINdgogZ+MmOQkPIUXRQV0PxyHp+0MYHRytfy/yb3sKyx6MaumQ3jTD7rcAVMpg2PjA11chHzLHoF53dnLKF5qyC3GBosZcY50xdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgFXoaC/5DtSawXO9Z49kR8+2OHTKZslFpSvIDp6jkY=;
 b=LXdZf+YGpHSykxuxA5JfAdCg8yEWDrCIrnRXAD6DQSk7fbU0DH2JRG9DejfGsosNkOKKkndqOQCXzvRqRh1O84bEJSVog8FKgAPM19iHl/shbHMWvmOGCWuBhyufxDldSmt1Zcdw3CpPhl+qwJ5O3JkmBywhmEInEixcCmUPlWb11aO64vBF3iC8k3mBrMfWwxgrc5R/UjD2GorMfC7nZ2a4tzaFak/fuFnudbmMi5xlHxmAqYQp50whN+5VH3BceH0F7aMrA+x0SA3ylC5+n0RrO/Fx0V1aXT9M/a7BOeVgWdanxfZwtzSGBSW9Bm7XxQqP9BSU6XnkITwSRME4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgFXoaC/5DtSawXO9Z49kR8+2OHTKZslFpSvIDp6jkY=;
 b=mTIP82liQBdv8UtRfGALcPpStI9OePVtBkZN2oc6wAhHbjmakF4F5geYN5qew//PxIez0gFxkeFLcX/Xqgah0+m+ogRaZHLLODGYEyPcjPOtqgoqoLhSvSUUQl0hVXoRWbEdkQetgL+4ghjsrI83uz5NCRqcQ+4gGf7MAjzQUzOAraotby1of7DSyffzlfasAqKGZ2jtdXDuKdBDX4xn84QLfb4nrtp7ynngnb2kQpip/D1vlp3ILdHV0alRQvdtoziP+zBW5kK6QQSx+FCn1mSZ9L82AS/oW0E9O28fSd3V0KFZKwSntVFh6saPsDaQGVnGRtzN3XLrJsoo49U5jA==
Received: from SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) by TYUPR04MB6762.apcprd04.prod.outlook.com
 (2603:1096:400:359::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 09:25:43 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::84) by SI2PR01CA0041.outlook.office365.com
 (2603:1096:4:193::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:25:42
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
Subject: [PATCH v12 17/28] ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
Date: Fri, 16 Aug 2024 17:24:04 +0800
Message-Id: <20240816092417.3651434-18-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|TYUPR04MB6762:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e813346f-8c5b-447e-cb29-08dcbdd566da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LrDwL0bgsuEHZxa/JFEv3iurI1X4UGv8zPPk4FcSOSLIzLAF3F6ATh5H/HSY?=
 =?us-ascii?Q?ZsJchLIvubL5Xjyc1MffFEu7NOBd6nt/I5Hn5947t5pwARt1kfi9FYLGpksZ?=
 =?us-ascii?Q?OF3U0MOJBiIhkj6ZL4lOoMsOKIqHWVwu10dZ0GpPQQtOe5Eo3/uXSW5pIfiy?=
 =?us-ascii?Q?/UBufG/mFPlJhCWsgDJZFQLkNl/4X/9eAOsGziissRjqUZWXKooqURIPcpna?=
 =?us-ascii?Q?gtb3sWg4key6YJkGZYdKbbfupoBlIvA63Nzp/BLNSEhnfSgqrTxeYS5i0aQ7?=
 =?us-ascii?Q?FJt0tUPg8v8bTs6TMDFpQQQOi7+/GNlXAprTopBFqJuu1sqamivApw7uR2wa?=
 =?us-ascii?Q?WNXDxzhJKNNinSwIj0ynBSE6YzgVrbZt8bvIcfv3hICfY11mUBC4hd5Lzoe4?=
 =?us-ascii?Q?U5xt4zq31EXqgb7PlHwtax3aSULMrEcvung5Nv7TMDpH81CBAkDwqGiBSf4Y?=
 =?us-ascii?Q?lsEInFQ87rpM9ryEBfVNsjzXHlU3cEC9hau2bvI8XWeEqMhZtLi7N/FKysn0?=
 =?us-ascii?Q?S1UFk9c7PlOyPafoYZ+rzouFP61CIH4eHG5ahQMcA794JlBoSY5dOgi7jIjQ?=
 =?us-ascii?Q?HtQOc8B1TiC+2RITFXhxKPgjUhrL8VsOKEAmhfUavETqjSA/PiCvpNmITSaE?=
 =?us-ascii?Q?nZs14hPjtrxfNmZXxuq7iugPdQdA4QT2cOkq8I6FU5Z9uNdLsWR6/2a7PUBj?=
 =?us-ascii?Q?BjkYxg1krqdU/ZMe70D8tvI33RVFInqJ1MeHsYlkB8JOmsY8XLcoLNJRHrjC?=
 =?us-ascii?Q?3Y2gFwjg+5KqX8DF/rm46OHexl/+HmtWaxYZV81bikbKYcVVSFb8+2P4R0p6?=
 =?us-ascii?Q?WrmfmYPtpl80l1nqSBufVcBJP8KkMn+qzIpjSYUo7XTsiKoZ055Ed8xGViWJ?=
 =?us-ascii?Q?RVaFe9DJ3XnsmRN9YBhCvgSz7u2oy8UROXscxq+ySNs2pFzO82d9MaoVSYRC?=
 =?us-ascii?Q?FF1Uzflb0EV2/zkg9eXW8T3ZYyHh3nIM0mTQDYea0Iv+ZkwniyAe5Ny5YTia?=
 =?us-ascii?Q?04UvkSbpqa4QCo8FkxPjLZtzASgn+xmFUMt5+yCsrUHs57XNS97c+T5WmbAT?=
 =?us-ascii?Q?DL+xwKSJdkTjFmZMK2cw7/Sh6elC35F+TQu7ws1+AXM4AxoOGrMGzLCvpNig?=
 =?us-ascii?Q?tZNomXIb+jMYEinHTxyH/NYrngJZTwcLpgevVGcwPCYK0CzT21uOqc3MzCfY?=
 =?us-ascii?Q?3JF6THfjFqtzba/38HMi6lxmo1nlBBxh9GT9wEATHPq3DajN2cDLjweyU1I1?=
 =?us-ascii?Q?zag00MYvCm4wtA6jQPV8gvbpoVySejqV62h/Yb703k0zvubLUdMpjVZ7KxpD?=
 =?us-ascii?Q?PS3PvuWm1F6YxIDWsd1QGICpVpJCxC8iKGk4Dw8eEpvG6ZPiY1VR10yQWTMo?=
 =?us-ascii?Q?38wkHoCF0rAfPVRYySMWWWuCwRjnBdlOaUx3TL1Jb3NR5LbCYFAGDk/SEOuF?=
 =?us-ascii?Q?Hy99UzLS6hEbkoZ1w+Y3Ei8pCFu8TrhD?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:25:42.8878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e813346f-8c5b-447e-cb29-08dcbdd566da
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6762

Revise fan tach config for max31790 driver change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 48 +++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 60743f9829a5..b46a0b9940e2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1103,8 +1103,18 @@ adc@1f {
 
 			pwm@20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
@@ -1116,8 +1126,18 @@ gpio@22{
 
 			pwm@2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
@@ -1153,8 +1173,18 @@ adc@1f {
 
 			pwm@20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
@@ -1166,8 +1196,18 @@ gpio@22{
 
 			pwm@2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
-- 
2.25.1


