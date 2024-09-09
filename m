Return-Path: <linux-kernel+bounces-321192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFBF9715AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6B52855CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348901B5338;
	Mon,  9 Sep 2024 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="yAb8Ds2V"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2064.outbound.protection.outlook.com [40.107.117.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6D1B5311;
	Mon,  9 Sep 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725879276; cv=fail; b=IH7ohETc764X+6Gv+jOydsFbQeaDtUel0P2xZcFDmvsTQTUBayuk0xVx6h1gp1cCecwmDfipRxwYOLZx28KtTHAqbSjG3sVVihAY9ThAP8f6CqxBf1DEeK0rgzKkN4CO17+fq8V93lnV0/3Thnjf8Pwapa2m1leE6Mwm/ohKEWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725879276; c=relaxed/simple;
	bh=yze2INEU/dpx/bRFGiNSCWwwBKGQ/kr8FWF+DMAYJo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoReuHr+gDGpyE1MvvxPxJPRAaq6VjCqTTUEyeS9HlXrdkXDftGYjJXDJ6RHbjVjpkDajQ+8RBd1sj8PJyriTXPlK9/1/Um7oCYPtTq9c+tmJjgYMAjB1iJYpnVkJdUBjt4orDqeee6KZTTxO5DinypuT35f4bpo/XuvNwdN+eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=yAb8Ds2V; arc=fail smtp.client-ip=40.107.117.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2sggSh1IwB/yPxMk7kNJnD77+9zOzz6OA3tVFJ+oplh/vmJU5LyFPdjFwhKxfniNqJt6Ft/huWL/f10nZ5GngCeRq1B1Hb1dD8yQARhsjYEDgugsutnuG+EgCBnipPRHhEzqudlWKyNA6OxgwRCkw46n/cQ+Vm2HWvtaFlivMOH4biIWg1GcTDHghLYbeqVKGUQRDNJ4UnLCpQZdp/Mibg1B5PT1FfYejNR7gqM6nFHTSCeM5g4l+NlqJlpnjeDwYqy9RYOnrPNVA5W9UN7O/HkEdqtsgILsa89/W9vwVLKQHRI9Ghr25pOL27bWW/etBNZk4mCxBnUd64YOa7Psg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4USzMxeBU9EH3DrSJM49cRXUWi0wRlmxC1ux7rp49ew=;
 b=sQIqyfdDJWz7/LJGL7aK5OIVef6kGEEaj7ct29DkNBq8MBoWJ3E+1ZwA4XHX+Y70bGoOlro67TMMzDvbrEqiZyllC9RlMEspJ2C5bP4oXjp5nc/QZAJEhRtIordV495PFHEsATf//B0ORmVT6f2QhMJ1v5HIiov7r1dQvE5+DIxK0JY21vvWiLmO0eqCohJ7/tTuqsqceqDgqNSbC/muHxL9eih6wKrcJ64Z3yUfkTKnj+QC66wC7gawOG//qG15DAmTAX1bv4Ib+WNj6J2g/BjVfMDTz/5viG0x7jr4ZTn878dwnHTU7asCSQqzGdqlDoCyzrYqaSavDk9Sd5uUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4USzMxeBU9EH3DrSJM49cRXUWi0wRlmxC1ux7rp49ew=;
 b=yAb8Ds2VwWBSacinX1sDIoHM0/D9ZuL9zPBE21iMSpZGaSwtatMGMkhMnjA7ZZEHPS/3Muw107/OxpvXnGg8qzON7jiV46pqf4vkWpsV4znzt8WZ9yv2xF23JyrKyim07dQviXeCoPoHsgAt0QxZl6SH8J6Oo1u0n3Y2G9VAjemxSIKTffKRPQlqZXZ15ZNuBR6LTZd6pieRV3Iw2T3DkUp05EIhxe5qrbNnwusbkWUk54MYMLWo1ezww0KC9ZzFjjrdG4tk3J4YGNix+PV/481YhDCcIs/8hX3pMXLHvvRZPJaIsKijDSZ1VuuhENrmKcklCZp4g7J+rfTwBkH6Ag==
Received: from SG2PR06CA0215.apcprd06.prod.outlook.com (2603:1096:4:68::23) by
 TYSPR04MB8291.apcprd04.prod.outlook.com (2603:1096:405:c5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Mon, 9 Sep 2024 10:54:28 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:68:cafe::8a) by SG2PR06CA0215.outlook.office365.com
 (2603:1096:4:68::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 10:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:54:27
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
Subject: [PATCH v18 2/3] ARM: dts: aspeed: yosemite4: add mctp config and sensors for NIC
Date: Mon,  9 Sep 2024 18:54:17 +0800
Message-Id: <20240909105420.441607-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240909105420.441607-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|TYSPR04MB8291:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0a01817b-dd81-4875-2361-08dcd0bdc6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U/YDvLuHuT8ZJPNvYOrftj72DXanPsSmgwlBfG21LElH6EANv5OId9tBEzxa?=
 =?us-ascii?Q?87oY7PmCoK5BZ2ZmFIkPWzIiSmeUPIC3e2o+ZJXHX792yhoeEK9PEpaUOriQ?=
 =?us-ascii?Q?CJqOzvW+XxMr+ilGO2BAGwMO+R0iOC0n4qDh3GFIZEiqW45uTjyzu5Z1DFQc?=
 =?us-ascii?Q?gHWkdNYHB5SL0+jDHS9EOtkMC7g4bhZgk/+0cEpOsUqz86NQiai8SXzSJ0rO?=
 =?us-ascii?Q?LYSNyUWEGzrbNSqnRQy2n4auNHearMRrWwdT1IQUTtT0mKLcFE50REcfXShF?=
 =?us-ascii?Q?HpxJc7j+aMF05ldYkPR48fwTE6d8knNRwsV85/bAET5EjcHrXmcauMy0znQd?=
 =?us-ascii?Q?v5TLypmxxAl3xj2uhOqqFqNg5fPcIG18ZxpB65xpJjE+mCALENvqRNwkzKfF?=
 =?us-ascii?Q?AbsGSG7d75VG/aS6tmhjDVIuGP+cT1LhL1naEmpv4iVxC3OSgt8Jkt8nHVhd?=
 =?us-ascii?Q?ulbExYwnCeJDAqpgdwQD3liGRrU7jjQbdBKSAELO2aop0/4w8U5d6ftvNJoz?=
 =?us-ascii?Q?a+dgT7fNtGWsMy0fUWcEppDu9aE8o9sQrBS9sp+eoAVty2AdL5WOtvOrFfZR?=
 =?us-ascii?Q?wly+y/Eb4g1fMkqRZECkVsUWZce3fsXH3BAly82oYfdloq59FooE+5p/ypZ2?=
 =?us-ascii?Q?P+XfFyskwYyXvcsTWrGcfnGYbhvLUHe3ghI122/Hc+Rxmqepec52oDK9A9mC?=
 =?us-ascii?Q?6bnoAsyxWrL8m3JvoGwFFOaCiBgkZUdIsSUsXkrpFtUymtEx/FSvP7pkQmKj?=
 =?us-ascii?Q?2k0EHYL3XapymLB+d97OJqYPrtG1PAtI5Zg26sX5hegVjOEF3S28BTYePry0?=
 =?us-ascii?Q?OaNKAxms4g354KPaXuSgXLmkHxgcmt20OI7EKyWpY+ln0KEBGUbi7vzxYcvz?=
 =?us-ascii?Q?2cCyph2LB+uD/QD4hUKqhECPz4TugRO9OGecPXXHPLNu+Uk+WqTlZtdx1WgR?=
 =?us-ascii?Q?5axRpq642uZsorY9gUfzrGeXSpRsZaoDrmIbebw/2Btv1mztBCRq1NQOrBPP?=
 =?us-ascii?Q?MpiFbe0RNva/lK0nW+pbuHJW4I/WqGWZ8L5esXoI0hmH01ygRnnzE08LgC1n?=
 =?us-ascii?Q?gKpKu7a+T8ANNWu7FCh1IYkLSxixhDcDk8HLjvthtoO2TQPOgEIsCSVJv3NX?=
 =?us-ascii?Q?pMnGOW/1cPvQ6O+WSHObKsc2kfZ6ZrQqUgREe8aeQ8qj5HeKF5Kv3WAABQ8u?=
 =?us-ascii?Q?O0/XjMVrNZXiRBeSwiW1K+rZVSpOZ8KsIi2Xd3k84Qzrav8sizzWw+Pk1B6z?=
 =?us-ascii?Q?8kFqRUHho0uPTIreuKkGTdr0T7TC1ZsDFX5OJL3A1b7zosV/iYVcGHBrvPpI?=
 =?us-ascii?Q?GlLqV8K+Ius0yUS9BK1Q0wNk9PLvo+7RkhRAe7HAQe5M0OWJ12DzkAf1M5MW?=
 =?us-ascii?Q?Pqy1o9KWmjAHfNitVntqhTGHJmccY1WV0Nw55xkiLXl5i1eNtzIDBVg2cDM/?=
 =?us-ascii?Q?SF/KnU2OHK7VDgUVCwZK4pajsQrjC+sC?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:54:27.7531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a01817b-dd81-4875-2361-08dcd0bdc6a5
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8291

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

- Add MCTP config for NIC and remove the unnecessary MCTP config on bus
15.
- Add 2nd source temperature sensors EMC1403 for NIC.
- Add eeprom for NIC.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 49 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index bed6bf695496..7898c4c94b9f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -938,7 +938,6 @@ &i2c15 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
 
@@ -958,40 +957,88 @@ imux24: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux25: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux26: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux27: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
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


