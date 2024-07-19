Return-Path: <linux-kernel+bounces-256981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30932937388
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B7B281885
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2221A47F60;
	Fri, 19 Jul 2024 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="xaraKEbj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B063F9EC;
	Fri, 19 Jul 2024 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368789; cv=fail; b=a0sBZ8DUg9/Va7I4N4INbH5pQ5TF2MEDoRRnTylqnlCHpbMz6aPTbK4AthCa+M/VTkY18c+GmPlFfVr8EdIYff3lejdkd0yu3BTGnFGQHnI7E2qfhEWel/8o/XQMrfXfV9S3SR02EL7jD+pPoYUjtda7lWcWOcKkjKU8HSdnsY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368789; c=relaxed/simple;
	bh=p46/iEbtucdsAZ5iLyBpexuMThuhsad8XBAxzF3ngFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2T6HgrT5ROiDJMcyYK+6+dWt9MnVh7lqhvEZNPQqt9UGUpiCfVj1EwlN+qkJIiywMPaDXzJ2C7NvOPiyfKTrDpGD5HMUS14bcP1l1cHQXsBjtg89ZP0iAFTjzaaofkRG89cgdaHe9+rPvhsa7zqVyDFjFrs+w4Je1pXnOMDl/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=xaraKEbj; arc=fail smtp.client-ip=40.107.255.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs8xUYoJG7ENJ0WMWzpbPfdnDN13yxMJPm/UGAhq+punQtzxJLAxXl3ZQyhlHwnk1pK/nNbq1C7fhuWyY9Vnp8CopUqtvYJ2AxRXBzcGEAGky/kprlpBRWJDkOmn2wa6YLrdemc+jCe0NqVKi0zUs4BlycFl3k45eCo26tfDU1EKjFd4km2WGMCBFGYIxUz0MMeZk8v59BvAw4+i87ANSzhnD3xgsjYAVlvvAH+H9ALIXOdLJgM9cHZg67e8oreS8I2hfOXHv7aRw/9zliFvcKfJ2HZLHA8YOHDuQ9Yl4aJj0C76TJdfEoc8L4FjyHGW39/g21lXNxd6vf7/wqUuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFKimFjZ/HhebE08E0uoD3C7UlaPmpkE4lfEBFrj+a8=;
 b=ezM+3pkctsWsZc+12n+KTmehrVMMJSH85b2tA4nM0Od61aiga3BkcozyumlrYqqnXShvtBNNykWXjnFTRViFdz6jNH3uoU2wZWCHI/zLozvaK+a3zcgJbkrtjkJT5iLPGIQvf8rfFomh6gOzd2mPMTJ/bh0CTonuDZJXsPFZVkODwTX9l++g8m63BJNpphZ0slOw3LDx0zH96aS2X5IpAvK4QhFnntNg+iIXrrtZagFCZl9Nbnq1K+YaKKg4otbNfgSvSKnCObuH+Oxp50TjK+1+lxiPslypB0OsynqsGtAsv/tCTboXkKyn9DpK5SYtN4L+EmcjTE9SvqpQCMtWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFKimFjZ/HhebE08E0uoD3C7UlaPmpkE4lfEBFrj+a8=;
 b=xaraKEbjNZg7h1+RGBBMilFEFJ+9TG55KevGD46xw5ZHNZCtB8c4qRnneeeyMMiYdQmVJjOo8WK7jOFCycUON0sjHemzO5qWdAd1FJ4BInKy75Rrl7POeWJXkahm9ySNGWHfJSoeYu3jX8HsRJ6C1cVFyOwYWa/NJlaX9i9/sv/YlxXs1YjelqxSRw7UZOKqXKwsjlopXP+mSRxjmHunybO5yqQ+Z+zf5IAwJ9uD81jApMFEmgMAvSi4gg7lvUcMhD8QgI7RrdX4FzME3cdfQ49SAjexqU522CQvOWrAUNqEEFXQNS6cB3m7CmrSQPR9dOWAoopJdVqueieyF5R0JA==
Received: from KL1PR0401CA0036.apcprd04.prod.outlook.com (2603:1096:820:e::23)
 by KL1PR04MB7346.apcprd04.prod.outlook.com (2603:1096:820:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 05:59:40 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::e3) by KL1PR0401CA0036.outlook.office365.com
 (2603:1096:820:e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Fri, 19 Jul 2024 05:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 05:59:39
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
Subject: [PATCH v10 06/27] ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic change
Date: Fri, 19 Jul 2024 13:58:35 +0800
Message-Id: <20240719055859.4166887-7-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|KL1PR04MB7346:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 477563ba-adc6-4216-d4cb-08dca7b7fa29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|34020700016|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3ifzdJi749H4T6yGPvoq44QfjneftCIKOzmxybStZbNBGXw+1BuIunFPBUN0?=
 =?us-ascii?Q?gYsbN0S8hoMwsdsCm27faUqGfn5g+qTErOGTMBrFe20L6DUmp9JVuar1JxwR?=
 =?us-ascii?Q?7pzFcwH8O13MY59UuawL2lvhb+qw5noOoyL1KWoq6Keq3gu2tw0g8tYs260e?=
 =?us-ascii?Q?vPYKWSjFQhknU++rYWwyCyj5hkY/hby7p9ouJEevt0qpzaD/S84QZd8+9kYB?=
 =?us-ascii?Q?kQmQ4K9eXKaH7fQQqaSHiwBD1d+I2lGZbHSMsQwvgJby3Z4Y7crmR2vgFf6v?=
 =?us-ascii?Q?Egp2do7Mt4YUkUXF53E6LK2u+rrS8J2ag3aZQbFR75GXZ2d4SXxcjT1xVqs4?=
 =?us-ascii?Q?q76zgc1UWuzLbShyqdPKZ1NY8A0XQ++o+HS1F3/q58+iZCfXhDbvkywqTp9t?=
 =?us-ascii?Q?jai3hpbk2JCqzhJ27ZwjJXD7bhhre4J3Tnq/pwKSCtWI8F5C9jBqdH+oEvxk?=
 =?us-ascii?Q?C/Tv38a6ZQXCOC52FhGRdUj8ZQpZWe05VBjmU+t9GJ3Tc4eoCszYK73RZRd6?=
 =?us-ascii?Q?r5ozSosokM5Kp/NdPj6usMdLn6qGJJqt/SybQmBfraNVZzRNNpokLaDgVeuO?=
 =?us-ascii?Q?dH2Mw6hsfFY80fQiKjQtOzFBNEvhSf/ypO/LORgPlyW4IgXYFEUetMTi0O5b?=
 =?us-ascii?Q?JxFcQF9fyHC8DFaEOwBGoFo4Y70zsDmxV0CqLWVrchTJXKjtVOzhzjLrH/JZ?=
 =?us-ascii?Q?+fCU0xZFIQNl5/qr3vZgIdsFMXoSfL0VCCRRXu3TBzZB46WFt3ibtCuiaoPe?=
 =?us-ascii?Q?LsMo8sFRpMjfIX9hKmCaIMV9HQ4zEUzHMzrre8Q3lfcwaP0zVLsLg9E2ELxZ?=
 =?us-ascii?Q?rjfkwsp0DJ60LDlrVf6aMw766XTB0/B7PYzu3VdqHeqHoLxvLzlhitIFOSSo?=
 =?us-ascii?Q?xsKW41QRSSREMTpv4kEp952NMsTVqY41ZeEOUht0QUGKgi37XTWB4dEOSeRx?=
 =?us-ascii?Q?CJotc6RFKu/LObItLLzJZZaZyeNdIx1uesVI8E0C3DFBECRPP1P2gf47Ojyo?=
 =?us-ascii?Q?OC+5auR93fVpKI2br5USF7A3uOATNLculQc854cYehI/IsuY5SS6AurEvrPf?=
 =?us-ascii?Q?Gso/CnLISx9/x+cpZ2Bo2yM0RWpwiNTSl8jkgdxmyR+Tea8uNIWIz55yeIKo?=
 =?us-ascii?Q?AjBaxZTMz2iuoFkQw53PhHEO7KhzM2PQm9hZdNVB77tXkwkX+aXvOYhofNr3?=
 =?us-ascii?Q?Hh3AgsOqyuA+9t/mE47IOasGBOA45A3c5ewSrtL7tmKLOo9szl1Sm8VYve7m?=
 =?us-ascii?Q?2ZPxJxNPvqoGKGoWgVkyvl5WNZjR0kAl7inSIVUyCfr4OX9wKpYLwQ0W/EoS?=
 =?us-ascii?Q?5ucOchZqqkc7bPYrzYsQcidgOBKZn8gJUNuCI8l74n2v0h6r66gXz8GmZ8Yn?=
 =?us-ascii?Q?FmN4cUEbs0nRJP0aD+6YA1Q/iEL+A7mlcUQeUAzN+rgRK+RciTpY03FxtmhD?=
 =?us-ascii?Q?3Vp0RY+R7Rk53wLbyxQbkEqHZgDTp2Xz?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(34020700016)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 05:59:39.5167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 477563ba-adc6-4216-d4cb-08dca7b7fa29
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7346

Revise power sensor adm1281 for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index a708e56b7ec3..f0f714c7bc77 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -176,8 +176,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -193,8 +194,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -210,8 +212,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -227,8 +230,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -244,8 +248,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -261,8 +266,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -278,8 +284,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -295,8 +302,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
-- 
2.25.1


