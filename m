Return-Path: <linux-kernel+bounces-348697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF49098EAB1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A33B250EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FC51494CA;
	Thu,  3 Oct 2024 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="dq/JvmRH"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2067.outbound.protection.outlook.com [40.107.215.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B413212B;
	Thu,  3 Oct 2024 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941401; cv=fail; b=ieud6dbTb7hRg2hA8yju6gOG1tZ2K6+wuzkILUzxPZmbMlrC5+c0dUgTfJTcbv70k1UD8ZPA1Nb7STQQIFg5OLUk32Y0NkCWufFJRuk3UzKbjDlpdV/jGj448Tav9+K7YZYmyb/hm6+D3vhwrJ/NYj7Ht1mYEfuXiOzu1iSxNOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941401; c=relaxed/simple;
	bh=bylv3tl8BdxieS0OcWY80tfU9KOHOn+r8tA9Hk135tU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfcvmEZ44peFjhE/hyYcfRtl+JLwBGrSmWp5kzEPZluaODU3jCecyBn9tOooaMudL1zRnSxarVMkLSyuYE7d0kuXYg8WvjkNsL8RsSGiQ/duSQEYHeowIOhc6rZoOLrRRjZTT+EDHTuHKOOymA6TTL5WSyqasjIrVsg6kKOzYwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=dq/JvmRH; arc=fail smtp.client-ip=40.107.215.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwFBqbr7tR5JfR5NuFHEmGATL7g3GgZF9x5L6uux7TW8mSlMQOW+pIduSVQrKNlfZ1KPcd0MUkiY0mR1j8tD8bBL6Lg6tiF0rL5Lhlumt2JRGmuarXkzxiurWVR8ydHb5wlC6UHNItAfxQj1SUJDAz+GpaUlBHrY4cpXlhJbi6DOCJMnJb98A/BS9NWyktWSaOwvvNwXkXmVK4hgINBhIVY18F2XlbKCxEc+HzeL9uSuMvA307LKd9Fw9YBtAVtXgRwysn6BAXgc6qoOXlT0wAjMQRRU59T6i5sP3GXrbZlxTvi3sTlO+jo+KZnjeJ69p6FhqNmsn22YdkBSABF6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mModBgmepEJWWR7Kf4dAi1ExcTyRUyLHFz2AZPi6FTU=;
 b=GT6/GkM9rS0gEhw/P1xAYjjIhfXSGuR1XAeis3IIpiOXdpfMjhAGKcKw4PHskfKm7voeWzKKj2YPRqe/qU40UXQxRlHehxTmFPuKUNlWm6MxzglMbbSsF3hmQ6Tr0X5fuDPVisQfiMawrdx2nhsZdXkehlihPrurm402B85oAWg5paN49eog3d9cfilHylXQe/vpg27dQyQCBFE7PTEvrv9I0f4J0G5b2SFGZ8/mz1dA2r8nqvjgHfqfOoslcjoO4crAqMSARpNQXh6bo84IH7Eis0EUlB14kXX6taoZuPfdXn3SWHZ248bwiKA5NlhloGedoUhEMrdKMnSHFJvFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mModBgmepEJWWR7Kf4dAi1ExcTyRUyLHFz2AZPi6FTU=;
 b=dq/JvmRHYpOAvbQVE5u4os36PLTtwBPiu0ik52bA2za67okAsxrZUY/a1FD+CQ2leUhQhumJgLpt2+d44n/gwhTfDxRWefLH2acf/+coxEJfBULiOysV5zmqMW5OpbHs8OS8wplTIbla0c7VvfTjYgdPdMwS407wGOYhQ8KIJ6DoLr/sH2NNUbwN6vmKly1gvdo8GQtaZtdakt9udtHtxTBNhuoYe7Xp6CyIemc6C+hLbbsfa7RCdUdx8ji1hcHK92moylmKODeNS9ytsqbhpBYUu6UJvz7GNpCEIwsh0T4dlZQoPuehd63hlVhfuEv33BpubA8vs0oajpyCEKYd5A==
Received: from SI2PR02CA0007.apcprd02.prod.outlook.com (2603:1096:4:194::23)
 by SI2PR04MB5846.apcprd04.prod.outlook.com (2603:1096:4:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 07:43:14 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::d4) by SI2PR02CA0007.outlook.office365.com
 (2603:1096:4:194::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Thu, 3 Oct 2024 07:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Thu, 3 Oct 2024 07:43:13
 +0000
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
Subject: [PATCH v3 8/9] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode on Fan Boards
Date: Thu,  3 Oct 2024 15:42:49 +0800
Message-Id: <20241003074251.3818101-9-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SI2PR04MB5846:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 609d4b43-1a3f-4276-63dd-08dce37f09dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I02Fc9myd/92bc3D5y8o22xq99w8gNKQzqRhuoQTZSeYrFrwl5f2Oy7aKMvO?=
 =?us-ascii?Q?bvJANgCOdGKtkLGnSFwNfD2wnneZAgqsY7WvZR17oMzwPv1CrSAABXq1WAtp?=
 =?us-ascii?Q?9vSPGXSHCDDGmW5xzNIrOUarvcv9P1covQgYIncH1flk6l25ZdLEEU1pISua?=
 =?us-ascii?Q?gWZEZYhcQCm7+hqlUPDPctd4Rg13F3wZKUMjYrmj4rS2yve3NDT3RLzmdeO8?=
 =?us-ascii?Q?fBa/STIfcF4VadERFadcJHBvy9c1ibbQV2SiPdRcLLbRL16jdcuvyNaotjaz?=
 =?us-ascii?Q?mbxXEksBQsBk64lenFbjU2WF/uH3D7BGyoEWaWFl9u3r8u550lj1rOdcRCs7?=
 =?us-ascii?Q?HzG/KyKzpCqKUnm0hRLPwcZUU5fsUwQB2h/9cWFehnga7D9irCyUSI96SxuV?=
 =?us-ascii?Q?FqFlTgIu9FM35y6fB9w+fZYVK+E6gQbIW+CykPKEILYH7d+AJAN1fBWf3JqY?=
 =?us-ascii?Q?/qx09UvyDJpk583WivSA/CZISUYS6h/JSQcDfIkQzhd6ge+oG1S//OTUMw7/?=
 =?us-ascii?Q?p43UEsFL6w+ZpT62KHfqyl2oMjIUh8X/TgHMhMcOWb/V8MEUPzn7OE0WP9AM?=
 =?us-ascii?Q?J8Pmo0pWv49xLn6UJjlmVGeRvKNqxcZ5LW24rX2unl7h06nZ/rXWLaQnjhbR?=
 =?us-ascii?Q?T2ZKXadqrx5x//c4CGdTNX3TdiCXOZCViZgbt57NOlDq2XAjq56iDFsHn2hx?=
 =?us-ascii?Q?LBMYw9iil6OR1PhTrlFCbewPiLyzX3MVQtW3l4+j57rynmJAMt41IMo8xPnt?=
 =?us-ascii?Q?HDTNQNFdfIbedQqYVLqkeeoDSiN+uwLYN4Sd4bCAgMCKeKq5DbOx++FlzmyQ?=
 =?us-ascii?Q?VWkURGgi8hsdckJZvJD0MMpDY83YaxJ4Fk0w7J5L3ZtwO5LNb5ZAYYSnRyjv?=
 =?us-ascii?Q?V82mQArnZHBpRlBr/fmHHk6xZIi7CxfJG0pyHjHs9tOkvf4TyrnamQIn/ODr?=
 =?us-ascii?Q?BvKTh1nadgdX/LCxIsF37uaoAqyhUWf7n/nOBH5j1S+a3koTww8e5MRvl9Px?=
 =?us-ascii?Q?hEVBokhak3SkcMKK/HfLy7oAWeWS8RkcVyIRf7DaxIOMOjCgxbMysG+y8gsF?=
 =?us-ascii?Q?870S/DCzA8R/0JnJeMSloK+mTzHqR2uyneXUSPvSB09YXo5K+hMczwT45vhJ?=
 =?us-ascii?Q?7AATUCx9n2sPMGbzQvVsgtmn6qS9wmSiKBoBG3LZmazbwieq2rKFipTc2x4N?=
 =?us-ascii?Q?V1/wJ44oCJPCzJmjTp1Qkt0QQzT1Fc/dmEphAlhtXL0+H2Kbf/mc7zTTxU9s?=
 =?us-ascii?Q?BbcFekFVVzZ3SDW5Y8dvxAwgjewR1j89MujzFM4tmE0L+N7ub4EPhHdSxALi?=
 =?us-ascii?Q?PF0CM61irmnMJgfaISlIyaEDfGnCI60YIaYjoXs0MqjdCw8qaktftKAd+Yla?=
 =?us-ascii?Q?pPNd5W/UCSAmFDF8J8L00ZtZNw1J?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 07:43:13.7745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 609d4b43-1a3f-4276-63dd-08dce37f09dc
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5846

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Revise adc128d818 adc mode on Fan Boards according to schematic.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 6b8fce786963..bc25c11df255 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1145,7 +1145,7 @@ imux30: i2c@0 {
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
@@ -1193,7 +1193,7 @@ imux31: i2c@1 {
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-- 
2.25.1


