Return-Path: <linux-kernel+bounces-300812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 819CE95E8BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E32B20C52
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808AC12D75C;
	Mon, 26 Aug 2024 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="CoIHJi/U"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010052.outbound.protection.outlook.com [52.101.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BFC12D1FA;
	Mon, 26 Aug 2024 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653580; cv=fail; b=jhw7U2Vc8R57NQhqEuU+OdFE9ZPm19vTZBHZpkN6En03unMYhR8ViDTNIGiN1j3SwmqDrbpkmw6MyljAnjXm1cKo3g1ucJK+yokQpZpgV8LEdEL5aAImC6m2nHYGoVVBYrXRMoNMoHrQTdwucOntwLfFRDxuJJRGRyMzGEWCNYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653580; c=relaxed/simple;
	bh=CiwkhpR7VbJ58wUM7Ct53vT3yoEHw3YDSjBZX8BpqGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNfFTcJsdj0jmIJ409pjo8cvPdL8I5lbABYYpTz4Vyc+NhdyRgR4PHC2CA9xH+ItEgtGWIydP5XGJyee4AVK/wSLy+H/QTzJ773OT2BiA8piXngSfQeQs1SJIZU0uqtMV6R+RBTwbqZ3VI0ePQIGa0FRBdMUgEFl4rmvAsvw3Fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=CoIHJi/U; arc=fail smtp.client-ip=52.101.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVddTLR0B1l+5iyPRqe+qWMDSvJG/PVeCCnTh03waFyvGf+XPOGFDNTfp5zs+lavAbGbMiE2MEWMmPVLnOlWZXiarB8mu92Uw/itsnqL9xDIiccOuoXbFUXz4rP4d9VvgWCW2ejE0npCkeQdB2uGzb+5kKf5TbpoPqvPDQaSEX7TqqhNr9CSY2TLKV7ekhzLj6roLZRlM8Zol3TN6LyCuulHLN5YM1rpbcvakvarzooucpdj22tvL565j1UUQjutGLCKEA6iKjlIDY3HRnZ/z97pv9f0eqyQ/ttDTOd5kLHKvo5wNKQ629fvaabpd6oTQOhx0sbxAIKQyIR5N8I0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrtsG6giv8Vmzw5ONrss4xcIYIDPtDHUY7eE3zbiJjM=;
 b=Vn3xEeSiVnrco9+voKly6IwXSwaa/2sQShq+pw3G12ntNjlK6Tjkz2ptVkKUO5yIaxcU0W8qdzlE9bFesqKcGE4ijtFwvtsykwcwZY0dp1XWdMdqDQ55VQrZ9mQRgSBqC/pgevSnBdc2imm9DXSoT6Kzh0WiVfyv3+JzJZdIlp3uWASdWGHi84RmKF1+i4yqk+noibv6GPYub4tKjaADM6AutQ2SBSCWdwCUIYCcqFR81ZrypY/g87zJh0C3eq+Wpt5ieuF0c6dj64PF+nCw+3hzK794pTx8zEjNOYACcyeGt3jeso0fwEyGcC2y2IbNvJ2q4Jaha8Pt00Gsfb3Ipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrtsG6giv8Vmzw5ONrss4xcIYIDPtDHUY7eE3zbiJjM=;
 b=CoIHJi/UGUOQRUR7XEI4VuOas3cxUOZVd032ntGmGqqgS/Hg/MGaQgeYsWrm0ev8godHi3T93hoATvnMTy1foXBqupnk9BwI4y9LrQglNk4OTqIFp1CzPu4tDMo38PAshsNwmIhtM7lBWhpIxwGUWGvwqVEWbZy3JhG6hWs+4uuA1md620bF6rADZaFvqTvUV3BkYZNgz1mwWsd/YDYj/eNO1mv26hfhwrornPLQpHanrm3/k/mYdUbTurQgrZuMwhasfOOqFFkJQIEBGt96de3Gv9eDxRU5nfNxn1e87XS4XIMOyfAekmePO2RAocV2o6tCqoMxUUh4O538w1WNHw==
Received: from PS1PR03CA0001.apcprd03.prod.outlook.com (2603:1096:803:3d::13)
 by KL1PR04MB7682.apcprd04.prod.outlook.com (2603:1096:820:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:26:12 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::5e) by PS1PR03CA0001.outlook.office365.com
 (2603:1096:803:3d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:26:11
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
Subject: [PATCH v14 21/31] ARM: dts: aspeed: yosemite4: support NIC eeprom
Date: Mon, 26 Aug 2024 14:23:55 +0800
Message-Id: <20240826062408.2885174-22-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|KL1PR04MB7682:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b9bdab4d-22da-4d72-fc0d-08dcc597faae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gvGdnbiTR5b4HnE9eVeJZyuCoCIGKsZcjZwUUt7dL1uNVSjvDhn/pFpHnEjD?=
 =?us-ascii?Q?bBjWBhiqmAGPw0BQlUq1TGt6uKBn1E9pR3vVMZUjuF9npJZsXFrt6xjAD8sO?=
 =?us-ascii?Q?rXFGhcz2ruKjM5Z1MkCRaEbWzyXF0PsQMc9Ll05kk49QjsYkyfxPWqclMHEZ?=
 =?us-ascii?Q?JMWfqpt+Q/AqqLsAdgx42QixFJnaqm/xCSft/Uy3UsRO3/darVKIss2iMeNI?=
 =?us-ascii?Q?kqOinwwo8MnXBu5TO2tthp+Qq4vhEiRwU9HRi8WflMTx/AFnBF/l196+RR8C?=
 =?us-ascii?Q?qcBZYnwQH2Yin6KbveojxQb+36srjMc2Nbz2F7yrruqMRvshM0iPYLscHX/C?=
 =?us-ascii?Q?w4tEDvUvI3dOPm2Sb/+986fVheXKqJNYuZl1jRNDV7fdrdqPORciw3yvqvEs?=
 =?us-ascii?Q?Lr1JMvVGI0Wrfn1979jJiRot5QcsFd0XlYrXKpHChvR5l3sPCItYcTSt8dHf?=
 =?us-ascii?Q?EnSy2bF1jwO53nY/9HQMnRPLAq7XUla03Aumd9g5Vp3MMHt7P34OPfbNCJtR?=
 =?us-ascii?Q?R6ad5Ne/e+CbJtNA6hPA6b2EbdHZIc5EnbVINv+SV09VXW7U3vHFBRfylgki?=
 =?us-ascii?Q?/qRzV/JAZi43MkRa3NTGh3DJ38RUJTQZvEbgdFhnTnfAdHBVRK/KeP3oP8ip?=
 =?us-ascii?Q?kAufhBVyV+LFK2dGHFXGhupo1OE8l1aGzeAmIApb6G5KydUgkS/hd75gXU7X?=
 =?us-ascii?Q?4CxDFgalNfdBC4Jq598cHEOsjA9wL9lPfEreH8Iw2UVmYBAROVTRTc1zPoHT?=
 =?us-ascii?Q?UOMXrmir7puaqrPNxPxc7OgJY/ONIXiGy/SHkb3Jkmlx5JPskOXVKYWU/zWj?=
 =?us-ascii?Q?3/6fH6DFPMS9ZHdKbcIm0WaQTefKpfl5rTc6bCugrNfAGw/+uShLV+qs+0Fc?=
 =?us-ascii?Q?nBZfUkqfRVrcjAQ0hGv3Zsl71m7lWpVcrZCf5KvL3u6p43A7s88fKZ8qIwv5?=
 =?us-ascii?Q?KO9ChIX11Qwp/mx+RzBlsdP/73t3AeZ5w1bwn6d94//giQvtjMqeFwFRcDVa?=
 =?us-ascii?Q?xJfkAThHyNO+fO06aoXB7InNjMf5qLmzYF2zNtvS6xZWilr+dikeA3TyBW4X?=
 =?us-ascii?Q?iEk+uDVnY1Psc9THjVFFR3EpKpJTkfcu2Sr5TkravgparFf395/nGMnGozcM?=
 =?us-ascii?Q?qWDY5PwvZHWBShnEZhofK56ejB++d1QtfoiAuRU7xXFraG4XHIABwvhnuvDI?=
 =?us-ascii?Q?45fspEY8JPtj6nup5QopLNDm/5CrLRSm8d+3oTWo8aJ6wtFSX99voEHE1pFa?=
 =?us-ascii?Q?XxRNlO4C74EQg5X9dvnH9NZtbPHimuGpryuRpVy0LNvqS+AI0+ICEMmiW/EF?=
 =?us-ascii?Q?jM4LdkNCAiDe7biN6snA4V4QYLTYWqX5XcJxgdSKWCRxWu0MJA4uci81qiIK?=
 =?us-ascii?Q?7Ru8CqJqTKTLcmrXlGMJ01zi+BE9zsTbVvzzzWicg+ni+A/FLH/fOgfg5Znb?=
 =?us-ascii?Q?VDCiSjbYERBTRnEPD1oeyC+YRGjQO4v3?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:26:11.4085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bdab4d-22da-4d72-fc0d-08dcc597faae
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7682

Add NIC eeprom devicetree config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 49500db53a13..c2994651e747 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1338,6 +1338,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux25: i2c@1 {
@@ -1354,6 +1359,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux26: i2c@2 {
@@ -1370,6 +1380,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux27: i2c@3 {
@@ -1386,6 +1401,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 	};
 };
-- 
2.25.1


