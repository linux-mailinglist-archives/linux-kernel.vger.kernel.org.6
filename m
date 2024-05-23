Return-Path: <linux-kernel+bounces-187161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B378CCDDD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18EFF280C74
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021FD13D28D;
	Thu, 23 May 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="aACE/E7l"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2082.outbound.protection.outlook.com [40.107.117.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780CB149C75;
	Thu, 23 May 2024 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451497; cv=fail; b=kutmUuBy/0eQsUNd/sz0BrRjDVyt0V9KAdjiqAD6fBHD96SPS9sbMFUfea2cKQAcUW8XV0zCtc53ZR4nZb7npsbNI6v8BvSyk11cGqRlF1XppXTN2kdhXBgUgeEaP/0WHZaixvO5OWDW6JKbdHck008T994sazL9rn+QnJR8XLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451497; c=relaxed/simple;
	bh=zaOozxHUVJiMg10Ow5jRJ4oxfkoLBzQis4kr0nEJ4aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccCWKEq7QOIBzaMaIOuiV5VRADlmWUIKOO3Idu+YqILyaqgwlcxl4B6H78dSogI/PCUjhwCrXawQCHrIaF6J7ihf+7qXl+Ij9NysyINy54itpfG3Dkb5FUqj6Snc0KsOI1t+eHqi8ejEJukpmyU0LP7jPA4u6t7pQNzKPF5wl/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=aACE/E7l; arc=fail smtp.client-ip=40.107.117.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiR8bNdG9MjWd4ojT0X9SEh7mv4AyLQpAbmntMTUeAj3ikqGXEjEb/kG3btn6cn4KBA8AYtBwQZ4DMYPTHZOSv9P5/iLfIkOvWuymYsUKtIkyfcnm+yldfECgDHNS3l/vDwmt83WWK6yZcAxm7K/1HFBF82TwbXmjnx6iVr11baxBmUUnPMwOoGnqdpb1fYdc/xWXBCwvBzje8A4JvMMOl9XjAUMes4a5YkvRHhnYh1bnM/CNTiczm4NpEVan/6LosH3IXJ6O9kSnD+IWR5zTGDjVj68uWn80g5pRbvG3fC52Aktirl8qR91WCmLBocbZAb+YaM4txAzzOO5Ar9cUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aG2tAObnqGVyXWs4nhAzlLQoN7HCq1EYScCcl7VH/s=;
 b=aSOFk7FMKEBSZ/n2K77jnlvlEV+oBVzjDZ0UGqNye2gbDTUKYdM7sd1Ugxx2Nkv9EGUaxJq4sZNG860NDp9cSR1TQZBy30a6bo0SVJqbs6BK+9nGHS2G2jah/bSYA7KUnnlSumz0hoLxtUszy73AXcZtCwn5EukR1j4rDS7HPfva/ZxqJU997jhQmjnkb3BMWq+Y6UjaRIlPpX+g7zZR38bLYjK3hmXbg9IDth2ToQQYiwoj5pv+vX4VutELXMYEgkpHRfjmVuMNqRQsU3eff3/FqwGalnNfW16AiLlS0lCN3HAxP745Kbo2oBoZZ794A3Egimo4FRc2fVIsS2SaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aG2tAObnqGVyXWs4nhAzlLQoN7HCq1EYScCcl7VH/s=;
 b=aACE/E7lR0YeUopZiDswHUYBYZFGXaik8UAnlR9ndaMtU6agfF9muxWIDg3O1/xeCuki2iV+lwoONKDM54mlJig1aHKw+80Qge2B0KwSedaHxhI/E9FzJy0Ky3bIIDo1FM6xwMfwkxVdxDjhI5Hdrc+9Mm0xXICf8/tHcllyBH/L5vGtTXwm9joAbRCfqO0egsDt/da3NJuXag6HlX3Veu1t/oQqnc7QP0m5j8pCulsY+7cSlIMzCs6lwlYjA0mnylmMjyAfT6kWQfaCicr2zvlRfv6ScCnIZpvvYXqfBFDHt9bzoCltXcbLpVOgEA/ulw64W11ejY7HNCtud6YmgA==
Received: from SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36) by
 SG2PR04MB5915.apcprd04.prod.outlook.com (2603:1096:4:1d7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Thu, 23 May 2024 08:04:53 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::cb) by SG2PR04CA0174.outlook.office365.com
 (2603:1096:4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 08:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:04:52 +0000
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
Subject: [PATCH v8 17/23] ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
Date: Thu, 23 May 2024 16:03:22 +0800
Message-Id: <20240523080330.1860074-18-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SG2PR04MB5915:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 38ff4cef-f486-456e-2575-08dc7aff06d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bkzypt5PjO4lIETMlyX5QkCkhx5aOfJIYV4eZ00WcZKwo3jjmKcBw3/hjHnv?=
 =?us-ascii?Q?V85zqBCk3ptG5mTIvQo7YCT1B26fVPVV6Y3z/X6Mp8OK5RoBVGhk3jPaiVNf?=
 =?us-ascii?Q?cXmEXbppbz+jF5PgJpZeVBhSkMAS8s/wxr6Ygwajh/0c7sOR4GrFEidd9/12?=
 =?us-ascii?Q?xEaE8QfS9RMImRVvtjixvznWjN9ow8jmD0cuK4xnm0SqjFdHK04JDs+CATvw?=
 =?us-ascii?Q?zye/rm/m0B50iKZ2GEK62fDO1wqvl9KZL6J84V5KGDVfXERSEFuhekP8suBH?=
 =?us-ascii?Q?rp9Ugj0CWm9hnIXhMBTzEL6pqLds20UT1oNacQIZ64LapjnU8NpFgrVQOaT3?=
 =?us-ascii?Q?q0d58tUpeO9hCB8wkXijH5ced06rBwbJV19AY3Y+1qpHDkVexhjhcpnv/Tin?=
 =?us-ascii?Q?Ursb7GXHjsCmXYnMCT0IMJIxAw8soRJowJiA1trMZ+GRQ42/j3y+BKtUPdDh?=
 =?us-ascii?Q?lpmX7K7fI7GQQd5oA9jXTSd1DmiEHa8Otx6VLNXWFGBKA8Sowy7wmrGUeJi8?=
 =?us-ascii?Q?bqDBzRUKNi2Sa+r6tT127PxMOlOy/YHadL7N96eeoMCDD/n5CRjui9LPnx7B?=
 =?us-ascii?Q?twtfq9P9t/k6FRmXkOzWei7ejhGD5OyVJB9wdR8aEiyvCHX9fvYfEQYZa5vs?=
 =?us-ascii?Q?eDWreOB8JpdWoRt1s33EpTrEWw6p28oFV56TkOl6KrPNlsBnsiWkKpssT8in?=
 =?us-ascii?Q?bvXmYtXtrsb8GD4ue3tpXH79QhuCDxqmzZROyq6/+6qaGEwgPQgblIge3+Tj?=
 =?us-ascii?Q?3CATfZOaxk50+xyjJrmaEwvK/z97haSu5nB7+pJI7ZtY4K2F5yImC8ao/q4N?=
 =?us-ascii?Q?d6RaisT+jZDiNe6otVR1gs1Rgj3A4BwetKqLFYxyayqYv+QhT3Z3dXHYkW4Q?=
 =?us-ascii?Q?hQVr3k+SWxu8twH2Vr7GdGECP0AerxRWdZOB9+Eh8FkEIIzl9gilxJja1md8?=
 =?us-ascii?Q?y4EkBZcnazHDmQK2FXDYBHlmFtzMsrTIC0ENGU3lxBZNbNtDP7VEoPmXKWbh?=
 =?us-ascii?Q?hyXt+dZqmY4u1RqnHxhgMYBXaVKwSQGw9gD0nSE0YI814xo9uC6VNHychKVA?=
 =?us-ascii?Q?WJrJt5CTX5/vxgxUBIXPI9QInq01pi748D8yjCyoSPJJgc7hqs6IFjOtkD1a?=
 =?us-ascii?Q?pwlpaXGvNsewCsE5JJzgnng5acM9DLeh0Ze38PtZmSdzq9l/V1025kKt1oO7?=
 =?us-ascii?Q?pbl5cjh/ym1p1TVihg0Uwx5aI5yB8DwwIkXm9e7iNvtoCnlg5FpiLUqp5G7g?=
 =?us-ascii?Q?fEEVNKp67OJfnoxvo2RFSS3eWK0q4d8QMcHK62waru8k0ZT4o6xSIlLJCVff?=
 =?us-ascii?Q?BrQUvMqsWHcTAYWgrHNDUblfIJBzWAsGwLmzkWcnIOExJoAH5QrJcBHYIDnO?=
 =?us-ascii?Q?fYNVItj2YbLYWdMSvBkJUm59uTX7?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:04:52.3283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ff4cef-f486-456e-2575-08dc7aff06d8
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5915

Revise fan tach config for max31790 driver change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 48 +++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 3baf1df11a81..59615a6958ec 100644
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


