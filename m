Return-Path: <linux-kernel+bounces-259816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A1939DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603881F22C52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3F6152182;
	Tue, 23 Jul 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="rXFrhyW7"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010057.outbound.protection.outlook.com [52.101.128.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4882D152169;
	Tue, 23 Jul 2024 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726646; cv=fail; b=kpStPJopf7loN6ECDGwNqzA16ihmhy93ngwQB52Dbra/9LZt6HNg39ZkIPiDjCOK/l9kEmrc+uDpfWMRsT2Z64lzPL0Q0IJdc4erJ5sVzxgQHl2cFeFW6t1tiQmtKU1ivChFg5NU8h4PSoriMGhoYghZPp5/qHxg8jCVTp0BZOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726646; c=relaxed/simple;
	bh=9vedNn4zZ5Ih4XUlJByZ0k4YoTGBuTwqHj0FUTJT7YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPUCZb7RwEtvsIEJC0/XZ1ZURrq6HLuWixtjXOUnN6WckWDKd+6oHmx6xPW82mEkTcPJh/pAdr1w/xCaaqvlRX+cLNjThYEhqxmC2xwxNG9xkm8J2TZTJ+mL0TprPfFDzNIOmap8n9XMqn69zK4WL5YlLT3bOfL336f5tyX1Jls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=rXFrhyW7; arc=fail smtp.client-ip=52.101.128.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI2y+kZTOcez/z2ukx+U5L+WPug4unOPbGQeUT+exSR23ReXLGLMlrLc9C/J9n8d1UrDtJ3WlK/5VVhfvk7lWYdu27+rSziK+pkv/HG6IvgY23Os7+FL7pTPGVZFD+H6ksWoG8Z6fU96rsEDYh/LSA16f0j/1UmeNTd4Q5icypcZOBsqBHqsYuAhu8WJn6X+0Y7oxn9gqiczMHnZ3SP3y9XHFnNo4K8tCCAVMP44XW826kF0bPNrSBKcXei96+PanXSto+tKSb3OQhByfh9zAGm8C5edeZN19QjBeZ2JZ3j5RyNWPicFhEkA0dY4L8QU5EW5dTzsH0HLVU8V+eE/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ8R9uD5dS2CYOtc4xvne6zIrhYDAk0BYpQGanDefRc=;
 b=FRQbTttvbefKBbh+KWZ48ybkq9kvowxfvpoW+D6JZ6kFfCHLmUzP7gUloMb2BeGq2aFr1F2HFkAFu7EvlgAQ+ibCfZgRGea/oQmO0o28Si9HPVdedQs3sSO8lmJz5AGv6e3eLkgNZZc5bsWLqqah3ZNgkZWz1mF6cAFije8jZ9iPljcldySsigJlraMxwN97cVH7pap4kioa4nwil4608F6vooZMF+34owWVkdNo2Tl2AHXWVhvVvNq156RHMZX9D8kmChugbXE9Ut80xsExO4DoyoYuPBkOLhp0vxI6jpjvjZfQnmAo9wGVpSuc/ZA2GpHBbs4maC5XusHsont7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ8R9uD5dS2CYOtc4xvne6zIrhYDAk0BYpQGanDefRc=;
 b=rXFrhyW7r7Fbn6aVUNp4rOsQpqge0T3gezI1WhYWNdUV+PPxD/wp+icCDRXFC30ahSTtk+6NfeLPsj8BkJJkm3Ni5Ll/0NC5BIWoQsbc4O76IZYNnB96kDyb0mGL72v1h1Okaon27cw69c+NuHLd9STRUBW+RsSEBbtxl6ZqC+x4I8sLcrj1d36uYH5TXqMJdpOnIBRJvAG66c0qDZpA8XVnscLHZK9GEkFrq/gjjO741XplatZLA2ywyWW7SwaDCumvF4UsyHFH433NU7y4ppeuEgOrKIQsxYYFKTIwvfrGx3EXq8/+tpQM48jTYi4Sac0LqjUTB8gb7ZTcH6sZQQ==
Received: from PS1PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::32) by TYUPR04MB6837.apcprd04.prod.outlook.com
 (2603:1096:400:359::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 23 Jul
 2024 09:24:00 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::2a) by PS1PR01CA0020.outlook.office365.com
 (2603:1096:300:75::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Tue, 23 Jul 2024 09:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:24:00
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
Subject: [PATCH v11 12/27] ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4 schematic change
Date: Tue, 23 Jul 2024 17:22:53 +0800
Message-Id: <20240723092310.3565410-13-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYUPR04MB6837:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8eba4109-53dd-46be-9d61-08dcaaf92fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p4tXR8iHyUCzx3bKEBQUK7TtMSpCKml61VTH8kAl/SDvSri9f+PBI7NXx5qg?=
 =?us-ascii?Q?L7UqXkuYyL+O4xS+x8N7tM+CwGgKT6Kp5UObRqE7+7wHcU3RL646U1ID97cY?=
 =?us-ascii?Q?taqA7pBm+n1FUVfLL4PiV5ok6bSwrlaxDImbd4WjBSlHeshLPa426y6zeaYW?=
 =?us-ascii?Q?NCsL/wXmGrjlwLWjq70p/TZOshg/SZoG1WKFHzXPp4z3ZEMYmLudy+eoLuKb?=
 =?us-ascii?Q?UZqIU1Iq7ZMq3kaFzxzpp35wgIPBgs7LSLK8gR0vViPJH0iPcGqIX+svG1bm?=
 =?us-ascii?Q?WE/dA/qd1H2hAW/mgzBmQVwx956NZ+TDlmjop+NOO7IrsNzdWes9QfQOMBGH?=
 =?us-ascii?Q?AKTPQsjUmM8HJ3Hsa0zKL7C/QnoStW6HluDrRWWXKQEJnO+Hytp9GUxORn1N?=
 =?us-ascii?Q?QojCNhcEgB9iowQX6s9cmTRMX1vLMqw6piW+Y+K95HWBWM3ajfjKQSWnmEVF?=
 =?us-ascii?Q?52cQ+i+jKg2jfYmLepu9Hz5AFXCg+YWSzroRwS5xMfGMKhluL+r2FVd3E2ec?=
 =?us-ascii?Q?CjsvQcqPDdxeMS/vgM9v2PRMdp7g5Sz2L1UpIpO8ZWBi4OZM8yajdvo3ooiZ?=
 =?us-ascii?Q?+7mK+F/9mixeVT/BLanC7dR9iPWRpT22JoCQTCt7ac3mJM9AjydYkgx2dEQs?=
 =?us-ascii?Q?5MpznsRfpqe0ZVt2mQVByH7Z0y7tHAnsncuxGELs+K+G98gIOSlkTNQ1LX2r?=
 =?us-ascii?Q?2YOjEyEu1QnlBNSDe1EMTiOQMzcr+v2BYENCAjaGLDtkF8KwGsEnz1A8qh3O?=
 =?us-ascii?Q?lb+gMH6e3JLxakMycRGa1DuzUTGS9Qau/L1AJMavbNUyNmiH03gf/yp6vgyo?=
 =?us-ascii?Q?oadgg/aIuKPA31kBvD/6BK1qUNwpYphd3IOOOwIuRhpF41B3anTsss7E/AWU?=
 =?us-ascii?Q?pnN9kVBkBr9eKt+XEIgCsRj8UqwZQWK2YiH7sCy21+2usWW/CXsPbZjLQg1j?=
 =?us-ascii?Q?HV1GOQnikkdCjb8UJhjzXLp76hFmq7aY9QKy2k/z5KufB/ebJpD4p4BJNP5d?=
 =?us-ascii?Q?IJxtjMTTrt4jzjRI+NxiL8LVvSJMO+ihZLCj6/TE/8z4BI+CycKDqg1U2UMa?=
 =?us-ascii?Q?6YKsBX7X4HRibRci7MBBdf7VZ9xb+B48oQFykvWL1dKVfB0r+YOxvovT83a9?=
 =?us-ascii?Q?1oEXmfuItKboLNwUndaAk/tcYgkrSwodaj/BasAE0aIXWKJnwXeAgAnsYFyA?=
 =?us-ascii?Q?lHZC4oYhDuSYoSBm4ypWmILpR0EVjpR3NTRqa1oFuI1/LdoOpHZYY3m9+deB?=
 =?us-ascii?Q?IwyttOcjKLzPirHLgYQ8s6BdIWvM+aFih9b5OMTSK5ilPvye4KuaOhc6w+Cl?=
 =?us-ascii?Q?IAk/gDU8xaDPxGY+NuCkFK8Kvnd+zSskTm23YWafgkoqPWH2kxwknAsO9/YA?=
 =?us-ascii?Q?Xilyr6SABxEz/C31h2hFBBfCNoxyUJKCk/TadDVIq6huNFlzXhPK3XM8HNyX?=
 =?us-ascii?Q?jx9oFX6frNWxrGdxssoCZT6BwGVoWG31?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:24:00.5194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eba4109-53dd-46be-9d61-08dcaaf92fec
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6837

Remove temperature sensor for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index e83cb51ac19d..2c0c37b3ee5b 100644
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


