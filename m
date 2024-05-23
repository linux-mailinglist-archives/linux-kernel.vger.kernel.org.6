Return-Path: <linux-kernel+bounces-187159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E18CCDD7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4A91F2222E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F65A146A95;
	Thu, 23 May 2024 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="V9gP5sB6"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2080.outbound.protection.outlook.com [40.107.117.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365113D24E;
	Thu, 23 May 2024 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451486; cv=fail; b=qrd9okHiM4MSQZTMzVKx2cBinpX9fRln8qyIc8Z6MeNey3K4pKzJLrtoc5X3dCv4xP3SWzvaKLoUPFtaRc5zXj2XOuuuOVIiJn2WmgxFZK8qyQJvnrVD2VFZwKkhPe6H38dLGIvl3Zaae91l8g8oGpoBah1vvEBHshF90XWIhw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451486; c=relaxed/simple;
	bh=FReh6MBF7e+wsHlImkrS7+qksdnnHJVP3YlsJeVxPf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFUPkPJ4Dklf0yMPnjVNhQOzNtE+rwwrL1opNur8OBGqeZ6ZJTt/gf3fJv+JdBYYRm3QjwGurNlaMkkEsNjECiIUoUd188RwP/6Zn0OqGN9ou0N2iUmP1CvKI8YTTu5+LvZa1l63iV2qMQ8odgyAZon6Wl+O0B1hsYvq5RCn8hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=V9gP5sB6; arc=fail smtp.client-ip=40.107.117.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ek64Knv82mbruMUS+vXJoGQ7GX1Uu4CKLIZkWwFZ8w++iaVTXYAq4vSzZiIga79qMiT/Q+cMsOktEXWuoTmE/Qd/Pu7fnMJ/hW7YLVTKQ13BkkKE9g0gk/nStIZ5CvJ0yqCGxuVoNRny+fwDv8jmLrAB92jqsDXuQwWU3ul0AJW1EeD428A3MSwP3XJKroT9nu29fucoOP9j6QBGAZFBWD1Bkbxv6NlU2/Mg4xT/XAIZbe1CP2gbMo7PxZJhvB3uFAHEWa0Jqc0T21HwjVSh2aa/5i+V9RbQwCMIkyhhpEex15DYVYe5wQmRbE/3cmnC85VQuVAAcoMV8PJofRPhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrss1LFTszE1pis/nUOnfDY03qkapLfO8Yjsln0bIZ0=;
 b=aML7n/fAsh2JT1HPJ9pReTHKRoI0L8+uLuL/537LaFG6baSGvFLPFIuqKAN1tQfN8QhIcvJSVm05a+JYXsBf320L4cSUexoYo8MhuyQeRIzzU7kwUh0YVeKF3ttb4ViWZ99Thjubc5YZHCDEWK6l0c5RRYBghgcAdPNT5/M1K1TBoC5eHyWkmt4ryRWw/CejMvbf9/glhkkc74yyUToRLERIbxHLpM6oR+FAnq8shVfSC+GaZgdguOubOMqOlR/ifmO/TQzebiuR9YmwpoGSrH0p07src35tksDXpvWX/CaVuFSqpa0Nm/bbojR9c/UHNCIPt0mMg6C1bUy+qKVP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrss1LFTszE1pis/nUOnfDY03qkapLfO8Yjsln0bIZ0=;
 b=V9gP5sB6gS3Zvfh3NdALvLu3ob4iYeMTmRs8AFz/KykfdHvGNz37fifT+Wg6jZlnNaO9tehyPBTNbf+xQO94dRpHD59rRDck3cqbq+NHuMPDFbeAnifABIDgh357W4xYENDptx+uVwfxXprM9Vw+7bUYTp+fLlqOVoCx1IpuBxUq2BNFyLcYil2gqRVYf7xmyMwWf604TTNkfp+bhoBteNn0tlLmtSfugThA5R3QwueFJMN6ytSPSxfz3lzw8sWEWHc2Ks/B/6RKQ6n7NNErAxogWMjkXofHp8ck5gDahfNf0IYftzfGTNdAFSgS7dTwfdbnFlCiC6EBWvzilV2Nyg==
Received: from SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16) by
 TYZPR04MB7154.apcprd04.prod.outlook.com (2603:1096:400:465::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Thu, 23 May 2024 08:04:41 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::a) by SG2PR04CA0154.outlook.office365.com
 (2603:1096:4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Thu, 23 May 2024 08:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:04:40 +0000
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
Subject: [PATCH v8 14/23] ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4 schematic change
Date: Thu, 23 May 2024 16:03:19 +0800
Message-Id: <20240523080330.1860074-15-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYZPR04MB7154:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 53e80a3c-011d-4bc6-ebdc-08dc7afeffa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3QNwZJK0Vjwy2VeCjbTO85BWPe8YseGegiPzziil/15wXHrh4viFXZBVtK75?=
 =?us-ascii?Q?6o9H2z5ZqjRlCtyOHOKRWjuH+4fT+OF0PKBkMAH4ZL7oz4D6ZUpe/1/+2/XV?=
 =?us-ascii?Q?LxmySRENQmMvJo5flEkrlJpkniA2wWM9mEQCeaUx/DsQcXLD5JpbZ6fWM/x2?=
 =?us-ascii?Q?ucarsMmIh2NApy1Q5RpbPX2chWpbBTJrnpFRcFWy1BiR3asrqDNimdwVIcq1?=
 =?us-ascii?Q?ZX2lbhizNKfPfxBvk02eY5EP22u9oFZu3+xLyqqnVmAr9cgrYCb+e/AnuMeN?=
 =?us-ascii?Q?lkWuhsYVE8a3jUsZCmAVShAK3c1zcgSB6RsvI9YesfDK52Q9zIOmJIQaN+Id?=
 =?us-ascii?Q?y6IJc4hpWUSCUUWM95bPpvuj5rV2XtZdtKuWnP4bwKOGhx3uaKSKYDqLTGYC?=
 =?us-ascii?Q?3orT+mW3T3SVf0DhX2hUFE0sJcoWBo8cDbxHGHTCItvd0cQbzA+SIlJloFm5?=
 =?us-ascii?Q?lmDnSKekxS+sbokzuFKfbhORD2v4Js4F0JiUkQDQlvYdbEPyw85uJzjaRJs+?=
 =?us-ascii?Q?QxG8sgnugtgoU/rrnJd+pvKZZbGJeb5T7e2c1KEVztxlWKYwrZnXKu4iUfBg?=
 =?us-ascii?Q?iq4eUH3xsjtm0SMx2amb/niIWvdBIJ49ZkG+mH3ZwjPTqcEG5FahcfAIw0ty?=
 =?us-ascii?Q?hJi3AIt1nhTWCW+5xf09sLMvq7yljuh6o9nNVuKueX7VpJ8zeb6y3BAi902c?=
 =?us-ascii?Q?Y62df7H35xaq5NfInXgMrz2BYQhgMM6UAdfsCshBwIxFKZirbgxxTOd4vslc?=
 =?us-ascii?Q?Sokl7GQXKOANr6+iYE1XHpDJuWj0G8/C8YyBLEkbddnvcNCeIAX/SxFIlxN9?=
 =?us-ascii?Q?QiNDO6ilx09LX3591TuZNMOYGbaPnXOQpomUr59kQmwCITXYXKZzzVgmibVN?=
 =?us-ascii?Q?nwe+PidzitZVc7bm6/wTQHvxT2kIHuuLgyW+pm+0U1XxlLRXxtS0ag1L/7Vt?=
 =?us-ascii?Q?M0cpZBOOmHHmGmzMpzMEZMASXRTw8IHqIjUiqF2w8IEqupzngnXNJcVoSTub?=
 =?us-ascii?Q?G5opzTpj+9Zf5JkbTZOMMWZYwqXOiTzWc+laR/BAGNtaH91k8yS0eojPy+xx?=
 =?us-ascii?Q?QkHwbj1wVYiWfJ/Po28sc4wKVXAaHJAYFL8v/OyppExOUJRSKCkjUQ7/F/YC?=
 =?us-ascii?Q?Ji7LM91lVbLWloW5D/s2aweaD7ap569n3lHbfO1UlSAmu0acazXd/aVV+Ums?=
 =?us-ascii?Q?+m6oiPQzVXla03TXOsdpawiu+JdH0MsxqJHH3ygMALvz+1ChS3QKKvhTtNEH?=
 =?us-ascii?Q?DEz4ySXDqvJ+yOhLN0NzKMYYjPBXHULhhGjvPenZPvGEArFDJkjKZwu95qEq?=
 =?us-ascii?Q?M84Ns7nV+utDbCdVbbCx5+/oYQqEsXF1R2sMH53aSCop/Lrb8Bvj5EfNo9o3?=
 =?us-ascii?Q?8FO2ae8=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:04:40.2813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e80a3c-011d-4bc6-ebdc-08dc7afeffa9
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7154

Revise ina233 config for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 0c7d85ff4360..67e3c787d675 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1034,28 +1034,38 @@ adc@37 {
 	};
 
 	power-sensor@40 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x40>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x41>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x42>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x43>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x44>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	temperature-sensor@4e {
-- 
2.25.1


