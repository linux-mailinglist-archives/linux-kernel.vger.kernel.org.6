Return-Path: <linux-kernel+bounces-230385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F54917C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B27C1F27A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736831850A9;
	Wed, 26 Jun 2024 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="2fpg/ivc"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2065.outbound.protection.outlook.com [40.107.215.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD6184103;
	Wed, 26 Jun 2024 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392966; cv=fail; b=haJ1Rvvbas1NyQJya8tiH1dV7T9ehx8jft7h3nwKdKRPsZx4jrWG9wcM01P3qIk2PqbN1DNQSdUGYNI/3uPBKAhn9Qqs6Z2Nb0VJxBNR9wmGfufEaCj5FdoCZ2PXyiwXMZfdDVOUtHIsLqWNpmomB+KHRFTapDjPG5Bv1kQ+zxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392966; c=relaxed/simple;
	bh=AQ4i6Qu58H2Mz2uR8G2Vyh48mhMggrP06dUm8cpEJ3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlOurOV7aO3HLMn8fbdLrJ6IDL6q5Sld4lgJlP9EKLiAfCUmSSIH4Cqu7AyThhMyMTc6tYXG0I9qxwGsdZfdqUxuFetDlf9gZV5XRh1OycI20+bhycztirWqhx3hYrLOPjdgAjuMwTo4GIGSUkdMl5XS8v342GZcP6/Sy94CP7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=2fpg/ivc; arc=fail smtp.client-ip=40.107.215.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfP12tzGLoanFeMMTEKrvwx4T7MkfVdE+r4pWrM0Z7i87/5MPoicuNNO4JlArGcX3WG//nBQJ25KyYGM+OK8NiRqDFTvLRVGACJ3AO/KddMHXNrMG673gCC3vhoQ6brgrYIAsg5mRcVN5SO66bJZwwTTIsnhppr9EHjQ8ZGBBluQkMiLjcBDqCYwwy4Z3PSGqYrpsQ9LBwhUgA6yiuq2n8N0bo0o1gZf/ACllCr5iMsYH/KYRr6OE3BnnVh7xNaJOxe12nIUvJvKcFzzPQsaXeC8H7Y0chfib1mvu4aNL4PWixSTNG1aqTGRDLuqAco78Mz+h75RkZ8Pf3o/5blq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqimXxCSFfjlalerndMtt8J4+kzLlcFkd5OkESE2nnI=;
 b=bHyE1aY7DaKPBgZmYmAGn6YZA9WXdOcXXu/gRBIB/9pZjj9bN9hm4YmhPb1htyjqR7xTGHuKjCUsvgKwDkz5EIW/GSa3w5bCJI2leYuSEdQqEw6AUbtv2PsIU9XHpWsqhnHuXUyTddCpjzzi9qCH4jbAwnqYnSCAyxxquMJmW/zMCpl1aHZNtH52kAFlWtIuL7XORwC8QYzroDRIAFYmZMEnng+HECHFaH+bbCEVfbFYGhyDK2E1T7s/7ZrF6pWd5ky4HbG37zrvhGas885yawjQjflyDbI6ADhcTaaDEaxF9ilSiCW8qkboOW7DHxSH1wAKrvTrwUn6RCUCmi63qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqimXxCSFfjlalerndMtt8J4+kzLlcFkd5OkESE2nnI=;
 b=2fpg/ivcZfGed+U22s16TzkzpbP9qwGbb2n1Ng39RGuiKIViESC+ARG+3PxWaG34AtmC2IF61fZdOgAHBmUDOSji3lN3lJG8ub2IZXjpB1DIoNZKZdoS1xVyTSqdKpWxu7vrl/8xNkeXgpynG/RAyd8QB4Z562asXsFFEIr5PojHoVhw9i6GfJFyqv6iPbhjdM/PzL9I71WcKFxpJxp7Sh8T2FTmxx/Pu1Gz0Rj8NP3fB5Uvz8dh4RSfflxqQ6Mv9/Ys4CRCqlIrDfeTJo8xjwzFTmzjhEjlTLhNwlgpnRKFI+oX0wuxiAktV/1cHjNTc6VClSopoh5fCQ5Y0Nxx0A==
Received: from PS2PR04CA0007.apcprd04.prod.outlook.com (2603:1096:300:55::19)
 by JH0PR04MB7842.apcprd04.prod.outlook.com (2603:1096:990:91::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22; Wed, 26 Jun
 2024 09:09:20 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:300:55:cafe::1e) by PS2PR04CA0007.outlook.office365.com
 (2603:1096:300:55::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 09:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:09:19
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
Subject: [PATCH v9 24/26] ARM: dts: aspeed: yosemite4: add XDP710
Date: Wed, 26 Jun 2024 17:07:40 +0800
Message-Id: <20240626090744.174351-25-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|JH0PR04MB7842:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9276b3ad-19e6-45b2-52b1-08dc95bfa9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5q8rUtC3r+t1k4AA5VMht8MMtK8N3g0+oYcpz++BLLH+HFjMKQ6mwkLbaDT0?=
 =?us-ascii?Q?QvuFVy+ah96xQZhoalN5RjOFh2SXf5KLtAIXrMpY3jTyBviX3JXaoDEKdbn7?=
 =?us-ascii?Q?jlZwEeVKj54ZJveBd0mXZyyJcmLAozjV10IAExMAic9rFxfmQ2IG4M+oBaAP?=
 =?us-ascii?Q?0KgW4jkhLoyc/9AntIY2JEqnIoqRlVaq/yV0Lx1G5LSgLpvP+o/5FAmGv5lr?=
 =?us-ascii?Q?2YM3Znfi4PjE3xAd94DwKvf7o4Nb2KqtpY9zzHsW7cKTF7gP6ZK6oZ5xWFIr?=
 =?us-ascii?Q?Xb2Lf4s6Vs0O0dOJsXTTem1cBElj+GFfd7J6ljxWmvhar+nbe+0hJ1Pxas3M?=
 =?us-ascii?Q?/oaIrbbm5XmYdWiJc1I76vBln+nHABkZZv0cqMhkM6z0i5Q8PpJYKldi9e7h?=
 =?us-ascii?Q?lpkdg0+FD/T2LkY9p8MMVSTtKE606aUQiAGyo2/EbDEk1/FWr3ko5UQiED4i?=
 =?us-ascii?Q?UYGkmxarfaEkrb5Wx9DcvaFg5+ihyNmnhjJeq4TzWVw1snxlA2mekXNpBFZt?=
 =?us-ascii?Q?GMGGlNsWrDYLuWFgvE3Nxvp6WzpvkQvi/84kVomiJnFmdFq5sBXEM503fhtG?=
 =?us-ascii?Q?jXmF4RntOsRTrkjPA4lqX++e1D3zeiMyxn9Ivh2FInfv0tsFPRwiGB6Cfl5G?=
 =?us-ascii?Q?8d1Py4cSeCJ5s4giWap4R2UGDaIWbjumsP2/vF3X+wARdxxUCMZD/xA0TMu+?=
 =?us-ascii?Q?8h60DCaMSC7dBRBlAeGbEgzMzloPAi5W0UF4bkEzvbMG8tdzyEOSS7dYy3bh?=
 =?us-ascii?Q?WYP3eb5s31UYqJG/ICFldAMI8NH1ruJNydqzn5Jq6vjcUew7Wwi5duuL+iD7?=
 =?us-ascii?Q?0GY+qCf4GL5yGMdzlAZv8ISZNLHGQALK8ARAQN8SsXG6WPr2J85Ejv3DICTe?=
 =?us-ascii?Q?iClnZgvCtYndbG1Zzry/qHnbB4QdUpxfQ8dh6lYuoiWRekXK/TakKq2ZFjrH?=
 =?us-ascii?Q?GOZsWQkTvGWESsJEkKlmP1umyiUOFwCQ8CIg0u21ziPZVWfNTQYciHlIaJqW?=
 =?us-ascii?Q?mEv6tYhSjMLBSnUtV5TL1Q2Na1rJhoFRNVzci5UbS4Hen87olG9pUvrADxb2?=
 =?us-ascii?Q?kK8XB6u2sFt1h2BsU6DAmlf5wlyenAcBY11/cbM9hTMA5ndQ22wqE2QvJWdm?=
 =?us-ascii?Q?FdLAYW0L1JJqTR3GfXvL8PBUDyGGKKmvXRKhlKo0pv2vyHZeuVpx21zAuTZE?=
 =?us-ascii?Q?iBhJGHOOe7toGM0mD9BdFwmQM3rQLvPs4ugYwr8nb77Uf2+I/a1DuVgjtM3Z?=
 =?us-ascii?Q?KludnLBpeDlrse9FG8iTMz9lilyAd78q4hAWsP4N6mrD12gHtOmdUM7+OKg8?=
 =?us-ascii?Q?4n+7m9ZSdIx85M+axmw8Y+UKbO2kKGlVnsyd5dsfyIRnuXeiKm4CczFQA4jY?=
 =?us-ascii?Q?VQfsOBMPt0m9GZrFQe89LsF1XOUZqobeReP8ss5di/MYZFJKmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:09:19.8333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9276b3ad-19e6-45b2-52b1-08dc95bfa9d7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7842

Add XDP710 in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 2cbb210ed53e..05f109687ee2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -978,11 +978,21 @@ power-sensor@10 {
 		reg = <0x10>;
 	};
 
+	power-sensor@11 {
+		compatible = "infineon,xdp710";
+		reg = <0x11>;
+	};
+
 	power-sensor@12 {
 		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
+	power-sensor@13 {
+		compatible = "infineon,xdp710";
+		reg = <0x13>;
+	};
+
 	gpio@20 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
-- 
2.25.1


