Return-Path: <linux-kernel+bounces-259829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B646939DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC51B2374A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9E314EC7F;
	Tue, 23 Jul 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="hvfnUu4y"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2063.outbound.protection.outlook.com [40.107.215.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BD71552ED;
	Tue, 23 Jul 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726695; cv=fail; b=shOinzTIxGeNvJ/dDu3I/OaZULNybVMqebi2Ze7sYOF/QFwGw7TNEXcPwJ8q7/qulMuchUjRER2GFcoZNUxrrA0rwFxyVpDpDq3JRWPKR3zHxzZJGXvusepk1yIIYA0Lg2+LewI+Abg2ZwrgdkNGf87Z7SibFYUFoarojfNQCQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726695; c=relaxed/simple;
	bh=n1VEhUcraB2L6lx1OzD6PjBTJW2T0K4J34nm/ZXFIVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hD5xvoLqYlI8Jc9UcqxNblK+rJMy5wblxAA5FZQvtHZKiGmA4ok3icaBdQFvjGZqf2F6aUNsuzjf6vuzEoO7q6KHxTSQZdDbFu/0V9NZjFiwMapB1CuO7SdeYDm4PVFOdGzb78ClWcRATuNb8Hky8Ji5XbRMPgySs8Pk4m8YGdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=hvfnUu4y; arc=fail smtp.client-ip=40.107.215.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAcSwZhx96dC9xpMqcyUP81Gdoyl0zZ05GOI6tDaTNMwBLaBx6Mxtz4yhDgh3M12wx1/6wtn+r29mCwLIHEOCv963dl5SK3ZwGqzNoVlUh9KbaGnzO25NY/SINQV8lDZEIMycR1xNZRlcqTyQ6zDFJ2c8I7lULikqZi78U6MQAhoRYcpYjhfdcTiP+GVdaOFBDFS3n0Nk2f+BT8lirwWsknIiyiT1/PaMOgH1ozt7kTlzIWZExdzQ7Qin1NAQRgfV1g1G1kdZB+GtIuxgou8xEFwM73CNH7v3BnU9gQGwCdrQ+I+nV7P08xPRQiThxKN3X/vdvtwXA+Kic+99FCMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgT/6R4EC/XEEfY2gUrLR0f3dvDaYSzSpR2s+GBhOIk=;
 b=XcVdYFRiapY32RUjhO1Sahpcb7hzRnriYTxhhk+hEAZ6fwarcl4zeJy/5qjKJkdOitMTZBURDr+wco2ddFV16urHlnJUQKbkcMLLS+blxWaAP9uSnA4IqavIaXF2ENhwgErbfxLWKBtbb3IAFlXdyfL0PluyjjAIej5+ScgjjHTgHPpqUYkzIXkPSpeoBCe9MwT5t7Tqx28tLBX4ND/UgF7032VLEbsPUS7RwJVrA1Wq0A224DDYvFEbyVbKtY0FZI6f2WEhsIQAM+RJDlXUNfRRh/0AL6UaclEjrjO6Umn9ckRMlENWN1rCPbXDNROdSDjlLc1HwL8gPFickGKnHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgT/6R4EC/XEEfY2gUrLR0f3dvDaYSzSpR2s+GBhOIk=;
 b=hvfnUu4yTFFLICzKecJ7JnOz/T9YYjRe82o1ST5sBOcd3U3ap8x3kGtdatJDWyqqcTpjXeSRp4hcCyLTwd0L4OQeByEYAXdfqqovuq5zoBoIJNhVBzcaxK2+43MafE5aWg6p9rTiuvtRZqrOt69wERq2DPNkpg4HHln0/WdgPTJ46/ks/gQZHZcU57rK5sm1y1upFsffRWQf8LtC+WjV4F5lKjwRv2wzjk5wgLxHWqwdNJP2CHv8q7GBv9n0ovfUAgNLYwkRI7NqRg8XtuCAkhy2LKKTkJXz442Ct+yJMtuda5d+gHxq8z4bebpqrIQq41X5ukrsAA3Ayc7vAJsqPQ==
Received: from PS1PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::24) by OSQPR04MB7946.apcprd04.prod.outlook.com
 (2603:1096:604:29f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 09:24:49 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::fb) by PS1PR01CA0012.outlook.office365.com
 (2603:1096:300:75::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 09:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:24:49
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
Subject: [PATCH v11 25/27] ARM: dts: aspeed: yosemite4: add RTQ6056 support
Date: Tue, 23 Jul 2024 17:23:06 +0800
Message-Id: <20240723092310.3565410-26-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|OSQPR04MB7946:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ab5b3556-383f-40e3-f5e3-08dcaaf94cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o8/4CeXnBZul53mPpWSUY43Eg2gYFABUv7YeT3FO8Yt1OxlCLFAyOSUdm3xf?=
 =?us-ascii?Q?CzqQgCp5DEJHHcdqhw2aM49TwzuvC4VrF8Q+VWmFcURF6Pyi1s6E6cKkqGms?=
 =?us-ascii?Q?1Y3ypB/9oxINcBIUhSqlKAfVE50F1mC494Z0N1doqLrdCqGKf0NDSfqWkiy/?=
 =?us-ascii?Q?NZT/CTkqX/sAp3wLL2cTLbHec/nc/VMKhonqnUOcPwq1SuFzeYHKzErx15vj?=
 =?us-ascii?Q?ARBnyMKXKA0u9T+Y3pmpI+/0NKiKKTqnzjYfPRJ7v+PsmCYO3x6shPLp/mZ9?=
 =?us-ascii?Q?8u2qgO/fVrR9aXgogJTtEgIOgaNVzCujwG11oW3AAyEl5gxJ0ah61SFhb0Do?=
 =?us-ascii?Q?KZSM4pFQTf+qu8zjKfQ6E9SqYeNP79japKwmvFgsIv1vCcWgfQEQltO6mf+J?=
 =?us-ascii?Q?2e7KzLZtylCAriRzOw5Ln0kx+yHRlD8NWmsq06HPtZdbIxwN/jVKREXOIPgg?=
 =?us-ascii?Q?DxCQkszGoyaBGct92mwk6UKNIcS14QXo4LvKSgKEo3n7MG6zGbDBYv8YKmt4?=
 =?us-ascii?Q?gGELtGu6jv9yifBkmuuYU1utxB20U9eZbsCP/NUTpwIAQ2ZzvFR67POTChh7?=
 =?us-ascii?Q?1+9DvUjq6LYdil3Ydw63wO03203FjJyN5HgQBy1JsKnvIz0UoEg5GL584vwA?=
 =?us-ascii?Q?v5xPQN3Lg59jXGyGSLByEnxbpyPTV9NWpzQrVyd1VVAd6demHI7u85MA5gUV?=
 =?us-ascii?Q?bThEXvuw4QpE49DoWRL4j9lY/Esncs7NKbP/UWFujW5M83YKtT4OwJp2gstr?=
 =?us-ascii?Q?ee4jxgvJlBkq9von4Cp0Jm7FQc6GZcR+qL2Rc1HhQg5iRptV6EpH6mEy78RG?=
 =?us-ascii?Q?A5nzrf+EU9mVPYB9Q3GUVzH5x4f/SNkVe/wCtLZ3UBc1Rr/qatPBWP3LWBMI?=
 =?us-ascii?Q?zcBUnvN3WwzC7D/Ka9xHMoHSO4vmZz0uycB42Ibx5qSow529N5hKVB9XIM8s?=
 =?us-ascii?Q?46HI3X2eadkScqi9JzHkC8UOeYbdSrHgJO7uVVyo4nzhVbVSEzxzfHkHgBAO?=
 =?us-ascii?Q?Xa/a2c1Gw7asG5XgdbJBgcl49lEkEELIeGRp6AfixAJGlXfBlnOFd7kzrWXa?=
 =?us-ascii?Q?iwIxlSh0Z8c1mxeOax0mg2tdD6HWYqI3wYRO2joG2NXiKZrr/BZ4L8+kVVkP?=
 =?us-ascii?Q?XtdoH74f6NxiH5a0Go3P0+pD4tjBiFpSihmECbPU2Izu2na+lk1gk6IGwRVL?=
 =?us-ascii?Q?ZGPRuQ1J7DFkU+uK6wiQ6q1t61pS2E7WgCnDwcUY3oOeXdlP6d17IS0xJq2w?=
 =?us-ascii?Q?AAPUjPM8P11vY2W0RsQBC9163gODRCpnJHj6ad4oOzxyCLJRN8sBMyK/0nqE?=
 =?us-ascii?Q?rNDtvFoNGE/QeIpPKPbQjOHBiQ9W6JPzgkj8zHpvNj6cRnFnqq8gf8mL6jqq?=
 =?us-ascii?Q?ptDKP9K1+etzl4JbYi9/w1yYdHxzUsn/gjuLm1D0dpRrlMJl1+f/igpe1sgO?=
 =?us-ascii?Q?VNAmvzHEZUdJZ2sWkJBTFqlBILvFyUA0?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:24:49.2543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5b3556-383f-40e3-f5e3-08dcaaf94cf8
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7946

Add RTQ6056 (spider board 3rd source) support in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f73719b3c2f1..03a1e41312e3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1240,35 +1240,35 @@ adc@37 {
 	};
 
 	power-sensor@40 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x40>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x41>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x42>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x43>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x44>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
-- 
2.25.1


