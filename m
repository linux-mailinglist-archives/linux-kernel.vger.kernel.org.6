Return-Path: <linux-kernel+bounces-187163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDB58CCDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E0F1F22292
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D1013D24A;
	Thu, 23 May 2024 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="mtJtzaHa"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011005.outbound.protection.outlook.com [52.101.133.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB5614A4EC;
	Thu, 23 May 2024 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451504; cv=fail; b=MO/W4K8G3gKgLdNbcej5p5VtPGH5RPsvyDnkKogILEF0ps+t4NYCFPymQ3ARTTbahxI/rfXmWjs3VPL65BBxz8t9PCntYgOm6eE1m6sm6fgfxpfJwAVkPYVgsn8ktwfVqjOTwXLOfzh+54bZtjg6J1fxg9KrvBFfWiy/kehM/aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451504; c=relaxed/simple;
	bh=0/RZfxELZSv5ixlsRWXl29JeFAUJDoCFh+RoEwRg0LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgkS/HZ2c04WrNby8sLqaTZXN53rgg+hmTsJxtZca6fOxCGBEmIq+x2kBhVeeVQ3/6Rs+gpNkMw8hGjbNChAsP4uXMKMUyo/7aHth2tYLlamP1Mds9e9uHf5toJ18UVsJGpoUZo1FFIGFGoon2sBx74DKAMIMiE8wZUfibvC8Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=mtJtzaHa; arc=fail smtp.client-ip=52.101.133.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Su15oM1H6/e9WLyjPlxU2PitYlzkKE2dYe1q8sV5WMb/bM4G6EonZeA7DAmNX93/w42H9o/B5RRSkCffrfJqrWputI4i82OcVhogrxeiQ/ZP348G/SCjji84+xikKuCpxKqpYM7ft8tt9MoK1XxI/t9ScIO8W6K5L+hJyR2SUAZl8F5dIpzk3feSLE7viSOMaNkGcqS2dvIA6fljAFVDX/8IFPsMqyVoGCuBRx15MBwCaHFVqBQMG9HPTdk141EOHBKfluYW9GT8JLKdJNA/SmG/AsOMLJeYLYe7Xv+oOPoLTcHhqS90kI6KF5CnrzVJ88YA1nAgMWsM2NgUIkBOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O16c89fsxykpLXkgqq5cnVpUTCPvI9O9YW+Dewzjs4c=;
 b=OCk/FN5YJ2MIyShqrrWVewhuRo1PY8fwv2OVT6ms+3V06awFrYM8G9NwAfYPpV7lyKWMlpD5C+6Ub+cA1jFAkcVRoTld5XnvmMCX37sqsxp4NYUTvGAA6NpKJQlJkUcLVS3UUzcLerMX8qZQtuAI56dcg3j1rdJuPN449VJMZF2KyRSYd2dKh850fQHWlCMY/1pMKGQ079MxRs85BKWvgTf+NVsWmYlkHsev5heuue8/E9JQWpsqQh6ClC2x3FZClKWvnNPpON0rAaLOlIod4WzeiRAwwaHrWqdbeXXerU3UvlROLgxggGx/yZNbtyPAzmgewsSZoe0/GW6IxlCyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O16c89fsxykpLXkgqq5cnVpUTCPvI9O9YW+Dewzjs4c=;
 b=mtJtzaHa4A1Gm89Axy3J1/MQLvsd2hZt7sysYowBjNuWUP4jY3/nUA/bmErNBlK3OUbK5OBEygGWQztxYTK/TAaRKhQ71GUaGDgz0ffRqGPxY8KG58cgdGoD9mRuRwwvVuyjyoQtWxq9TvIUTLcXnV4neVku8UyFbJ4vx9gtsl90Wq3zaek7JZrIOOf5qcW22GtOIAG/FQijIEz+WWvi4XxKsLCea0utXnUftfFmcNtYdzO/2A7WrNj1fCcIE8765JOkorZN4Gb6y5d8zMbal+Bf+7SBKB94tUUQ+MnOeEPch+9fZk+Cmwz0wMTGaq+H2IlhTlHoXMi3e87ZS6Is0A==
Received: from SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) by
 TYSPR04MB8338.apcprd04.prod.outlook.com (2603:1096:405:bd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Thu, 23 May 2024 08:04:56 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::18) by SG2PR04CA0158.outlook.office365.com
 (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 08:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:04:55 +0000
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
Subject: [PATCH v8 18/23] ARM: dts: aspeed: yosemite4: add mctp config for NIC
Date: Thu, 23 May 2024 16:03:23 +0800
Message-Id: <20240523080330.1860074-19-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYSPR04MB8338:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 04b767b3-d6ad-4b5b-ea58-08dc7aff08a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l8iRdh12BtPcVugd/6dsvHNJSnSecpkc4VmFBfJexgYFoysA4NJgFksZZO7k?=
 =?us-ascii?Q?tdCzMW9EG0/8cZne1b0ypI7m3fSacgcKtCl6X5tdGcQswmgyaKpsvNYT/QRz?=
 =?us-ascii?Q?iyY1JP4PzesjGviB5nxAfkUf6U3UAJgX+xwAiZsAjXx44+Fhh1SB/GsLd1Rt?=
 =?us-ascii?Q?Akb9ZD6fK1blXlKD1A2Mrc0ygq/j/xBt7CRsnM/wquSM+lSKHVQl0l3JM9uy?=
 =?us-ascii?Q?swJqm9cOK4Atd5kClPuL+OPhqk1heqR91BXnensPIM9fqq0P9Etv1z/Pb6qs?=
 =?us-ascii?Q?60Cy5Mi9Ygep3Ir1prjw2Yn+DHs25l6+t6717ETUHWBtBpi6FmAOU2cN6b0I?=
 =?us-ascii?Q?UbTfGGUWUGmLOrMMOoujZGH/GuiCge1Ya7xO1H8JYFZVhzRKBO7280kbkE10?=
 =?us-ascii?Q?/39AMjvXCgEDQxqaGpqbglVylYDpCng50ywWfhEQEa1nmLmEin0TwTpRKSbf?=
 =?us-ascii?Q?UW2fV6+UzZGZg/I+ccJIBuQbaALLHeyS2taxNpS3hlxZsn4cDpowdXJLP2ZD?=
 =?us-ascii?Q?qeFMn83Ll4Xcf4Wi28TXoLk7+IBlLL3KLPG3nz+QdrGxxw7zfW/jpePy+BWo?=
 =?us-ascii?Q?GHFjOxr1W12UVq7hC22PSopFv9v9JB4YVmm+jeUcopXO3zxRE2SM54Iu9+rD?=
 =?us-ascii?Q?9wv48HsMSZzKKuNa+FfX/+bQjVem9T0985LBTtBKEY0Esf2vOp2mM1Jff673?=
 =?us-ascii?Q?oAMbq/9aM9ed60ckwcC7/CWF6W8G3/MzREn2dWZClMSHYhUuvk/r1TOGFhmI?=
 =?us-ascii?Q?0/C8h+4gCuF5tiQVJBoZ0W24rBrpZAEWSYnCtIL8lYCwKxE2H8S5K0mPJSH9?=
 =?us-ascii?Q?LweHAEPWZcr5mPOh9Y5eAZvsiN04rO7p63RmNu7ynQOyNLSerzVZ3OxQWpM5?=
 =?us-ascii?Q?5iR7VqjuC3bpBfCZqgBCUGtQeG3g5j85k5sNI2EeL8KqSFBdr2cPheB5v/qo?=
 =?us-ascii?Q?n+PVNmoLiNa4JYsjtx/s3m64K9gECGcY9P106+Pgc1EmYvDT9vQCtB2eKyxv?=
 =?us-ascii?Q?ZNrBarDbK7Cc3p6p7fLhes4VWdtzisy0nDvy0PeGc5BBAfBTN6gZbnSyp8yO?=
 =?us-ascii?Q?w3Xn3Td3PeLnIVVdob+aar0jUbmc7unwvkUpIAbCAOupBuEOBrwvR3mWe9kz?=
 =?us-ascii?Q?2wtdNDZYVo+KuW6qtDPnveJT1hX5p48aFHUi2AA5+8Zoi6NpK0MEbdVGNlft?=
 =?us-ascii?Q?zc6CAgVwfXQa56V02FrstZzxaCil6I5n3UWkUOukLuugxzfHzmQiN7SUwIki?=
 =?us-ascii?Q?GI5S3U5lv8EkPrSis1M47W5nC973V1PzZ/i0xtI3BVPd10YbcdzT9065cl3Z?=
 =?us-ascii?Q?Z4YXSEpXm76Pre+mQrRyknp4z0Ej3OUiEmxyFExKh8QWr1kfHgDiShuY+9qO?=
 =?us-ascii?Q?YixCZ5IGLWNdl8A02ehKDjVMcnA6?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:04:55.3127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b767b3-d6ad-4b5b-ea58-08dc7aff08a1
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8338

add mctp config for NIC

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 59615a6958ec..83c9d76f5a11 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1281,40 +1281,64 @@ imux24: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux25: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux26: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux27: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 	};
 };
-- 
2.25.1


