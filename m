Return-Path: <linux-kernel+bounces-187250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EEC8CCF09
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609931C214B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E214EC65;
	Thu, 23 May 2024 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="RtWRvU9U"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2084.outbound.protection.outlook.com [40.107.117.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8948214E2EF;
	Thu, 23 May 2024 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455958; cv=fail; b=tIP72lDy7ZY3b9P0IHEPBqFyxwv7W72TtZSbL9zLFmhZnoWcKoKC2cK1Jx8K2GQ/bD748IEd3OeLlYO291Y9l8gq4T3scbCoo8mYItbFOcw5W0K+sUbHUthMiVZ6byBt0e7ePn9id8Mkj8aWDPGEUKHLoaFWSWGFZZ1ZlhrmaKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455958; c=relaxed/simple;
	bh=zaOozxHUVJiMg10Ow5jRJ4oxfkoLBzQis4kr0nEJ4aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgWdGHmVT4w7vFvOT+7S8CpdbyuJKHU9cXe0fjuOJd2cBgAKfgRKyob8/5FEwipcGiNgCnBWk3LTmiF/ni2MHRIoJft0qdzwkaTzNlk+5auczgaGwRUeTnNrErFC5xG88c6pCoTYtnk0bTikK2nng1NZs71tX1449QN08s2H28s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=RtWRvU9U; arc=fail smtp.client-ip=40.107.117.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpsSVb9mhjjKddD4o1dJjgMyxVJK1x9Nd1du8/JSjh19QQxDHqUQeVc36qU3A6E+W3hDyaUkz1Klf4oVO3ugcXYLNXXw4ocG33rf3mQQONpxbfP5+BytkVZDYZgFWauTi6qUi54D6ceCx1nXKo+RuwqRkmSLStgA/kOUbY8hKuH1zZCra1qXpjX3a7UFeA7242q84KBHjrI/eM3l4US5J8fZDBppwETJQ5R6DV/bIrW3EARqFqJ9xB7N+NZefGxzS1iRXrOdDQxZIfHp/WyTQfyyxUv6UxBfvkeeS/w69SQ0d6w1WS/214TtWSF5AEypegJeuJMPLlIQHuA1RUS5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aG2tAObnqGVyXWs4nhAzlLQoN7HCq1EYScCcl7VH/s=;
 b=mv8013+Loi4XEKluwYG2NKCgwi0Lu+plFCtC01GVLxyaNH5EK9MIlAl9QwuqV1/rbAsjiMMGR4AM3YlWUEkV3GOfZb9wd6BbdhRpe+pvtZZDvM++/XrGqD0Djofy5LRwoynFTOuU+XP7Z7GNdmTYHRV+xVwDRpL0czLeAZwuK5Waxs15fUB8IPUwCQv0QhtdQOKlRJYZBsXh/7OLnllKHBY5bD7joxJdN6X9I+CfUWP1ouy3h2GY5NGmd3mc/4N3nIHEMRtmvx8TgVAn9ctcQ57G3u10veQk8nQY0e07Fy2oTgvYpdkac5c/W/E4R1s1qKS8hXYGF+ndLR3BDK3JZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aG2tAObnqGVyXWs4nhAzlLQoN7HCq1EYScCcl7VH/s=;
 b=RtWRvU9UQLTlcjlT7qRYC9OOWStY7EhAtPm3+DjLgb1XNrMUGFuWc625aKgf2ZtcIDYOnBj67/bZmGaS4Xap0KGLxWGad9nEzQPLMZZDs7to3yXAvZfWtSKIp9s/fjXTrwl/HaitritOX9TCe5DPu37c57foV7HxWt7GLHkTV3Ieo3luQGNl5Swddpaxat9ESzfEZdEMwAnNDxhiXZ+Z4coowkjLxd2sehnKUNBABkA4lT1gg0vzJvauNvm/HEqo+flr+KiQ94bnD3LMT6oYjQ+XQT1ByirfFmZko5yeGPBw3m3SQoINnKBdF/osTVpj6u3/Wk34HI4eV2BISEWKkA==
Received: from PS2PR03CA0018.apcprd03.prod.outlook.com (2603:1096:300:5b::30)
 by TY0PR04MB6343.apcprd04.prod.outlook.com (2603:1096:400:328::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 09:19:11 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::1f) by PS2PR03CA0018.outlook.office365.com
 (2603:1096:300:5b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:19:10
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
Subject: [PATCH v8 17/23] ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
Date: Thu, 23 May 2024 17:18:04 +0800
Message-Id: <20240523091812.2032933-18-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TY0PR04MB6343:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4695aef4-74ca-424e-4c0c-08dc7b09680c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|7416005|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k8dROagPR4WwcLtwn7/OWMTBTMs3tSHdYl+dKjzKbEJIjuNjfMEykTf7e3ZY?=
 =?us-ascii?Q?6W6jOoJFzmpjaL+4U61HM5YyowU8E73MpB9GjLhDwtUizUPxsRF0p/fheb/a?=
 =?us-ascii?Q?egxILUr4UIbmDOcEHlxePxm6q2U+5WQpriKjhaZNJx/naszzrJLo02Tt8ZVc?=
 =?us-ascii?Q?mPkR95Dx1+MNf0RxluJ9B1CUbKxb1wjvrneJBWV3ACQpLxGKGmCXrAlY4TuJ?=
 =?us-ascii?Q?VDUDT8glXcyjCd83el5YShpBD7GIjewqQ+PfGzx153ofSBBftKVWZblOcJ1s?=
 =?us-ascii?Q?Xix309WelyyXKa71ti3pJu1wdKlbZs7tXFkt45QZEIaBw4mIjQ7xnOK33kf0?=
 =?us-ascii?Q?ejwbPfRxotkwLCmjS0kS3+fJkXMWyjwyMdApGRCau+zN/AVf7qlOqcFxPjHw?=
 =?us-ascii?Q?5R6ps3+PvtbUM1bXBZIlF3sdCPf4xZR4zCTAZXHyRnyQBgFfp0QApFyKLo9n?=
 =?us-ascii?Q?egMcLVF9iSByAD4/59/I+iD5ee/LlZayvYXm7ucR7LsDI9UStnSzGGFx7kUI?=
 =?us-ascii?Q?eYg3fHzrMmv0z+Q0QD+gxc/089ltri8nSzGMwO0CZdXn67hgwm37YrzNuj1z?=
 =?us-ascii?Q?BSu0FqnQRWJr40HzdeHdP5o79QeUnv6hNCFKUpVICRzg2aUMZGjBw7vIztlu?=
 =?us-ascii?Q?yyMAryMWPE2BXYokNXCZEXPrFQ/tmejCHaEv54LKcnktdmYKgcXDk00bAMjJ?=
 =?us-ascii?Q?x+20aPNAZ6IdQP8YpIqsm48QxN+T9tnzVs2hC1pVv4QZBD7Bq49+cvXEdG4N?=
 =?us-ascii?Q?vGFIWjDdqxxX8u97WqwhCgFQsUBsaZ0LZ26R8JB3G0X4HKSUfta3bBg3M/EK?=
 =?us-ascii?Q?7BnCP05zErxPQEedDnXlD2B75AiEmNCOq9m6M3sGyX2Hiw8jTWCoWjKOgsPW?=
 =?us-ascii?Q?BJfOcEIrJdVo2HF3a5xP8zr9jMuMNoPj3pdIdSoIMSuc6pBKSz8NnTzJaKuc?=
 =?us-ascii?Q?olSPX9LGwbGE/z5hoc2FhiTreSjI/e6K5EvNoSObG10JoGAI0YkQe8FUQitC?=
 =?us-ascii?Q?UrBhbSHkKgkbSR61fCKH8Y9TMGBTATiPbrL3dPZjaMw/kvVhK973709sAzxs?=
 =?us-ascii?Q?gBrIuJaU7GZ4QXNSxOe6UJZtPZ9I9KJufquQk1e1pIZmXxHDhmGpH33pfkMD?=
 =?us-ascii?Q?S+XDfTxQ72bxZTJtbBlTUAWLH0/wMP5v0PTOu6nkV3Dca6gDNG0mvzXWMBDa?=
 =?us-ascii?Q?u6zZLtmNrurgSubjwGSLTymzbY7HTdzAdOaB0AKIPlsghcqYarZs3vxCE9A2?=
 =?us-ascii?Q?8OUIlkszQ8oDQ6kskYnRsx4R1o9gB2W9ZVvlapyEFs4x+XhMnG6HNthNTpr5?=
 =?us-ascii?Q?/WnRbSwbMbn6pIY0MbyxC2Z3fH2nORnF2fOhjyx9sez4wPt3W29MZZ4mF2P6?=
 =?us-ascii?Q?XG9vxv6lR3aJ2YCDpSTYT/nfl+Rc?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(7416005)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:19:10.8138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4695aef4-74ca-424e-4c0c-08dc7b09680c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6343

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


