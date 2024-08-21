Return-Path: <linux-kernel+bounces-295272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF24959936
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70BF9B227DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB922024DD;
	Wed, 21 Aug 2024 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="WcOvJL+R"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2057.outbound.protection.outlook.com [40.107.255.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A832018B7;
	Wed, 21 Aug 2024 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233425; cv=fail; b=XDvsgzZUdnvzlU0ADEwIheVdX2gETlZBwjnf6GS9pjXwhxayPUlOkJ1hOA2LZsIEa5PKGztEpiW7Snaq4R2ZANG8yj+dvuHyUCsSR7tzvclOo9px06k/198k1LVSI4L1BWbujrePkfV/91mzBVxseQUQ5GxmQqioJEPlqDlgclc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233425; c=relaxed/simple;
	bh=uSK7NwkEi13veaYDqGNJo2rL+lTSGlvtBXedPFbkvMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQH+F4dSC4E3/ol0HIwTh4i5hcnvFj3f/5TXBdHbzCnSbbonNE5qG2omzvOpjXXJYoiXslc4RozHapj0hLCfuPex8k4yIum8xOlNKDbIE2hsV8HALAhYGCjnKQI3zvJ5xNr+RjPICYyV7RCZ/8L2jGOPGxZZkzDYtFfmTPUXa/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=WcOvJL+R; arc=fail smtp.client-ip=40.107.255.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd8SH7qs3Td0ljeko+LQ6e7nfPx8xKW/87dAJrbJSQuux4qMCpb+jfrElL0wkOaTJchf7fBaGcgl3Xe2KMDocim5eRr3OqqGOVW2j/AyOsjrJ9QjhIPzFBqAnb7uau0tSgoU+Oz4/YwRqiJ0p9pESv5/V62wMYoWxe/jkSq9J1NwpnMBpOZycxF/PKDN1ytjiBr4YaCJBF0600XaCB9gTyACowpp50krStjRMyrPXmqjuNdMrOLQWwERKOza+30NSTyzobWHti8R9YMDTff5s8Lf/7FhC0fHpq7akFryo6HiNW8ul42TmiT9aU5x27krDYIlE4/RqMCoKnq3nP8R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+24Kp4KzLO9I4Hcd3hiuundM/PhwavSUaxUKYjbqNc=;
 b=ypwuy6vm1Ts5OT3P4yHKCWT9EgxnMpgWbKOJq3Sz1BgTaU/jCAwZEnrGgfDhhcKCOtiykQqA7n8UPlQpFroSBYdCrwkD5ZeK10atHLrA3U8AZDsuOUzoUbDomaD1lvc9wGACeQ+OlqW/COQuzJYsMDbKzPccURYD2LzHnMUNJNHgCZUYM1sLj/zu97znsO101JxUzfs/YZHbhVvYa/j4UIqCnYh/Jz+muDnqZanE18RoV2/CetGKYssZUaBNinLpfiuRl+TZIXcA6yVRZz/1TSFNAfN341ZIuDRGIzUvdNhEaypCm7wR1fLjjipUSdVzboAO9lgOi3kAeb9+bSs3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+24Kp4KzLO9I4Hcd3hiuundM/PhwavSUaxUKYjbqNc=;
 b=WcOvJL+R5KQsYN46UH0WKPPqY4bM4gLEmRAhVE2lNE1q7290saQTsorFVMB8/cvCgnOr0GEceKI/f+lEHxNoTsZim1oDLBScbNO/sg5hZRhH8srygtqCIxpfbZOW2W9NI/zrxXJuY3PiuuTjZco24qY1LZ1vQk/0HwD1inYGKH3wxK4zuG04G1KtPrmtIYQRzszFoo46Va8Q/Qf8fT4YZev8fF43iW0v5JNV6Yr1wtI3wVdF3kjkn0Q7fTU+p/qhgMUoR3B2wmWPoXCnX4WTzSo1LuAnZX71H4NWfzB4QIZO3+8Hbk8S+BBYIZ7T/V4H5GAtx09W4+A6GxnN7HAZVQ==
Received: from SI2PR02CA0030.apcprd02.prod.outlook.com (2603:1096:4:195::17)
 by SEZPR04MB8150.apcprd04.prod.outlook.com (2603:1096:101:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 09:43:32 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::9b) by SI2PR02CA0030.outlook.office365.com
 (2603:1096:4:195::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17 via Frontend
 Transport; Wed, 21 Aug 2024 09:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:43:31 +0000
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
Subject: [PATCH v13 28/29] ARM: dts: aspeed: yosemite4: fix GPIO linename typo
Date: Wed, 21 Aug 2024 17:40:39 +0800
Message-Id: <20240821094043.4126132-29-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEZPR04MB8150:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fa7fbf00-f98d-4395-c09c-08dcc1c5b809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t1ZmPJsY7tZSiqGfwn8CIuFMYSffz66Fk8TckoxBnTXkZLu6v8Ru7B+u+4i0?=
 =?us-ascii?Q?sq2mWwaNqxZTJwLMkpSD7NLeB3hKpmbjiI1jSZKgyds2RJUcXPBE6WTUDYve?=
 =?us-ascii?Q?FjnHICHUYadi20O3R0xnLY8ef2Y9BmJEmpi+jpgpNBHzXjXBR727mEF/Gd32?=
 =?us-ascii?Q?A36v8iISzyCVT69Kin8L8aWTcoSJfvXLu0g3GgqKY1fBlclDQ2oPMI34ISDE?=
 =?us-ascii?Q?r9ZuH4iKsgtFP6XM7gE/4Lrk/wbRaRNCRqzFqi4a/rg0rJkA31lkd/o9PQk0?=
 =?us-ascii?Q?+tiZF9Ms0rDqBCfFthwqzFp8ryh8oAF3+kU/ZaPVzHP0yu6h0/OAPmI0NWMT?=
 =?us-ascii?Q?cqMZ4Jps/sTWLlGqvolzacYckJCn6u92Ou4ECRh5w79UDJSpOcLMOil9VETd?=
 =?us-ascii?Q?3IbPdDCuimqIlkbKJdvX9zIT1N2YOgVoP4A3tovEOclX8trySionSVKb4GK0?=
 =?us-ascii?Q?DvVJIHSfE/Wb4wDgSV41soVMkZ4z1EddTByz7HOWJGRkHoU9En5guC2YapaF?=
 =?us-ascii?Q?Zq4pGT1XibKezTwQ9UWDNgr3oyTrfz/MqW5Ilr3IjsJIHrOOME83Zj+IcBiU?=
 =?us-ascii?Q?6PGA/V0WhoeHd+zKM9MBFaU8bRGIEJXqyOJIHXSPn89kMG5R/7SBYDSfczSG?=
 =?us-ascii?Q?QBG6DVULJCX5220238ds3fcV86EXiGCIR6K5MpRTVOixSYNKYdwpThJ/Li0U?=
 =?us-ascii?Q?vagpsk2po/a0S0yg1DLMKxdGXRGk7Y3nFEAcjxEjJ0xTsAQNmbfDs/LeZRXw?=
 =?us-ascii?Q?q+fwSBaebb/7J7AqPjfq8QJK1a1z5dvkQAzfpntTiNIksyjDpGbzfoR6usCh?=
 =?us-ascii?Q?DlEAr0Uce/hxH2H5rEF6B+GmNX9hWE3ZWWJQh7PNAd56/e+XFh6DKDSnu/X5?=
 =?us-ascii?Q?yQBDdPmTOT6j/xlNfxjNbH92J2KxnRpk6PlWup90VLdZFNoMnyc87Ty4yyjd?=
 =?us-ascii?Q?0CpQJ003CnOXeVFklz84Qu/jj9CkayKFJmqTOsIHY7/2kLbetD7pRo+t50re?=
 =?us-ascii?Q?4tn4h8p4jrfDOT67AEce/DndpvgfQ3nmD4nk+WvyPFUOsfqQoxcxl1xEsoAT?=
 =?us-ascii?Q?4NfTvF1Rp5aExzz3GP+RigkRS5mIjM7QaBWt4lZSzM2sL9n5Txfk8M9i2275?=
 =?us-ascii?Q?mh4Zsolgymg/fQLvRTduTRKA0mdHzadHe3dika6W/61J25vpeDZVi7loKnoQ?=
 =?us-ascii?Q?/qWDqPyzIuhPCSxNgi1PZVQHsxH8Ropiw5VaYElhmF6h9UrAusaYQRgg90A4?=
 =?us-ascii?Q?yxsGypClmtLUNYdC1sbh1imrghmByhr0qtFv+gVa4Nk1RJFzvx972cO10vVk?=
 =?us-ascii?Q?Xwn/R+1EwIMuqtUsgHyUOEAYJxxrh3R4uwtqs2ftRVJ5L59TZuyjuvapJS3F?=
 =?us-ascii?Q?E3qmFONbHhQNTG183pvNbH5BIhi1WVJ84BlmyF76VBgS0+wuYdXXY0ogtCml?=
 =?us-ascii?Q?CQSa0l0MvV+Axq5MTnUK4dK8eesv/W+0?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:43:31.3882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7fbf00-f98d-4395-c09c-08dcc1c5b809
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8150

Fix GPIO linename typo and add missing GPIO pin initial state.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 554 ++++++++++++++----
 1 file changed, 455 insertions(+), 99 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index abd4a9173de4..4090725160f9 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -285,6 +285,8 @@ &mac2 {
 	pinctrl-0 = <&pinctrl_rmii3_default>;
 	use-ncsi;
 	mellanox,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
 };
 
 &mac3 {
@@ -293,6 +295,8 @@ &mac3 {
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
 	mellanox,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
 };
 
 &fmc {
@@ -327,6 +331,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -348,13 +359,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -373,6 +377,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -394,13 +405,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -419,6 +423,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -440,13 +451,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -465,6 +469,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -486,13 +497,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -511,6 +515,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -532,13 +543,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -557,6 +561,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -578,13 +589,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -603,6 +607,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -624,13 +635,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -649,6 +653,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -670,13 +681,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -687,6 +691,7 @@ power-sensor@40 {
 &i2c8 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux@70 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -798,6 +803,7 @@ eeprom@54 {
 &i2c9 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux@71 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -993,7 +999,7 @@ power-sensor@13 {
 		reg = <0x13>;
 	};
 
-	gpio@20 {
+	gpio_ext1: pca9555@20 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
 		gpio-controller;
@@ -1012,7 +1018,7 @@ gpio@20 {
 		"","";
 	};
 
-	gpio@21 {
+	gpio_ext2: pca9555@21 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
 		gpio-controller;
@@ -1031,7 +1037,7 @@ gpio@21 {
 		"","";
 	};
 
-	gpio@22 {
+	gpio_ext3: pca9555@22 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
 		gpio-controller;
@@ -1050,7 +1056,7 @@ gpio@22 {
 		"PWRGD_P12V_AUX_0","PWRGD_P12V_AUX_1";
 	};
 
-	gpio@23 {
+	gpio_ext4: pca9555@23 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
 		gpio-controller;
@@ -1070,21 +1076,21 @@ gpio@23 {
 	};
 
 	power-sensor@40 {
-		compatible = "mps,mp5023";
-		reg = <0x40>;
+			compatible = "mps,mp5023";
+			reg = <0x40>;
 	};
 
 	power-sensor@41 {
-			compatible = "ti,ina233";
-			resistor-calibration = /bits/ 16 <0x0a00>;
-			current-lsb= /bits/ 16 <0x0001>;
-			reg = <0x41>;
+		compatible = "ti,ina233";
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
+		reg = <0x41>;
 	};
 
 	power-sensor@44 {
-			compatible = "ti,ina238";
-			shunt-resistor = <1000>;
-			reg = <0x44>;
+		compatible = "ti,ina238";
+		shunt-resistor = <1000>;
+		reg = <0x44>;
 	};
 
 	temperature-sensor@48 {
@@ -1156,33 +1162,32 @@ rtc@6f {
 				compatible = "nuvoton,nct3018y";
 				reg = <0x6f>;
 			};
-
 			gpio@20 {
-				compatible = "nxp,pca9506";
-				reg = <0x20>;
-				gpio-controller;
-				#gpio-cells = <2>;
+					compatible = "nxp,pca9506";
+					reg = <0x20>;
+					gpio-controller;
+					#gpio-cells = <2>;
 			};
 
 			gpio@21 {
-				compatible = "nxp,pca9506";
-				reg = <0x21>;
-				gpio-controller;
-				#gpio-cells = <2>;
+					compatible = "nxp,pca9506";
+					reg = <0x21>;
+					gpio-controller;
+					#gpio-cells = <2>;
 			};
 
 			gpio@22 {
-				compatible = "nxp,pca9506";
-				reg = <0x22>;
-				gpio-controller;
-				#gpio-cells = <2>;
+					compatible = "nxp,pca9506";
+					reg = <0x22>;
+					gpio-controller;
+					#gpio-cells = <2>;
 			};
 
 			gpio@23 {
-				compatible = "nxp,pca9506";
-				reg = <0x23>;
-				gpio-controller;
-				#gpio-cells = <2>;
+					compatible = "nxp,pca9506";
+					reg = <0x23>;
+					gpio-controller;
+					#gpio-cells = <2>;
 			};
 		};
 
@@ -1242,35 +1247,35 @@ adc@37 {
 	power-sensor@40 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x40>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x41>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x42>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x43>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x44>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
@@ -1323,6 +1328,42 @@ channel@5 {
 				};
 			};
 
+			hwmon0: hwmon@21 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x21>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
@@ -1330,6 +1371,42 @@ gpio@22{
 				#gpio-cells = <2>;
 			};
 
+			hwmon1: hwmon@23 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x23>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			pwm@2f{
 				compatible = "maxim,max31790";
 				#address-cells = <1>;
@@ -1393,6 +1470,42 @@ channel@5 {
 				};
 			};
 
+			hwmon2: hwmon@21 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x21>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon2 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon2 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon2 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon2 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon2 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon2 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
@@ -1400,6 +1513,42 @@ gpio@22{
 				#gpio-cells = <2>;
 			};
 
+			hwmon3: hwmon@23 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x23>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon3 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon3 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon3 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon3 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon3 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon3 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			pwm@2f{
 				compatible = "maxim,max31790";
 				#address-cells = <1>;
@@ -1493,7 +1642,7 @@ temperature-sensor@1f {
 				reg = <0x1f>;
 			};
 
-			temperature-sensor@3c {
+			emc1403@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
@@ -1514,7 +1663,7 @@ temperature-sensor@1f {
 				reg = <0x1f>;
 			};
 
-			temperature-sensor@3c {
+			emc1403@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
@@ -1535,7 +1684,7 @@ temperature-sensor@1f {
 				reg = <0x1f>;
 			};
 
-			temperature-sensor@3c {
+			emc1403@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
@@ -1556,7 +1705,7 @@ temperature-sensor@1f {
 				reg = <0x1f>;
 			};
 
-			temperature-sensor@3c {
+			emc1403@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
@@ -1569,6 +1718,92 @@ eeprom@50 {
 	};
 };
 
+&i3c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i3c1_default>;
+	i3c-pp-scl-hi-period-ns = <40>;
+	i3c-pp-scl-lo-period-ns = <40>;
+	i3c-od-scl-hi-period-ns = <380>;
+	i3c-od-scl-lo-period-ns = <620>;
+	sda-tx-hold-ns = <10>;
+
+	mctp-controller;
+	hub@0x70 {
+		reg = <0x70 0x3c0 0x00700000>;
+		cp0-ldo-en = "enabled";
+		cp1-ldo-en = "enabled";
+		cp0-ldo-volt = "1.2V";
+		cp1-ldo-volt = "1.2V";
+		tp0145-ldo-en = "enabled";
+		tp2367-ldo-en = "enabled";
+		tp0145-ldo-volt = "1.2V";
+		tp2367-ldo-volt = "1.2V";
+		tp0145-pullup = "2k";
+		tp2367-pullup = "2k";
+
+		target-port@0 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@1 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@2 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@3 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+	};
+};
+
+&i3c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i3c2_default>;
+	i3c-pp-scl-hi-period-ns = <40>;
+	i3c-pp-scl-lo-period-ns = <40>;
+	i3c-od-scl-hi-period-ns = <380>;
+	i3c-od-scl-lo-period-ns = <620>;
+	sda-tx-hold-ns = <10>;
+
+	mctp-controller;
+	hub@0x70 {
+		reg = <0x70 0x3c0 0x00700000>;
+		cp0-ldo-en = "enabled";
+		cp1-ldo-en = "enabled";
+		cp0-ldo-volt = "1.2V";
+		cp1-ldo-volt = "1.2V";
+		tp0145-ldo-en = "enabled";
+		tp2367-ldo-en = "enabled";
+		tp0145-ldo-volt = "1.2V";
+		tp2367-ldo-volt = "1.2V";
+		tp0145-pullup = "2k";
+		tp2367-pullup = "2k";
+
+		target-port@0 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@1 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@2 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@3 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+	};
+};
+
 &adc0 {
 	status = "okay";
 	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
@@ -1579,8 +1814,8 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 
 &adc1 {
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>
-			&pinctrl_adc15_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+	    &pinctrl_adc15_default>;
 };
 
 &ehci0 {
@@ -1595,6 +1830,10 @@ &uhci {
 	status = "okay";
 };
 
+&jtag1 {
+      status = "okay";
+};
+
 &sgpiom0 {
 	status = "okay";
 	ngpios = <128>;
@@ -1701,16 +1940,29 @@ &pinctrl_gpio3_unbiased &pinctrl_gpio4_unbiased
 			"","PRSNT_NIC0_N","","",
 	/*V0-V7*/       "FM_RESBTN_SLOT5_BMC_N","FM_RESBTN_SLOT6_BMC_N",
 			"FM_RESBTN_SLOT7_BMC_N","FM_RESBTN_SLOT8_BMC_N",
-			"","","","",
+			"ALT_SPIDER_INA233_R_N","ALT_SPIDER_TMP75_R_N",
+			"INT_FANBOARD1_IOEXP_N","INT_FANBOARD0_IOEXP_N",
 	/*W0-W7*/       "PRSNT_TPM_BMC_N","PRSNT_OCP_DEBUG_BMC_N","ALT_TEMP_BMC_N","ALT_RTC_BMC_N",
 			"","","","",
-	/*X0-X7*/       "","LT_HSC_SERVER_SLOT6_N","FLT_HSC_SERVER_SLOT7_N","","","",
+	/*X0-X7*/       "","FLT_HSC_SERVER_SLOT6_N","FLT_HSC_SERVER_SLOT7_N","","","",
 			"PWRGD_SLOT5_STBY","PWRGD_SLOT6_STBY",
 	/*Y0-Y7*/       "","","SPI_LOCK_REQ_BMC_N","PWRGD_SLOT7_STBY",
 			"","","EN_NIC2_POWER_BMC_R","",
 	/*Z0-Z7*/       "EN_P5V_USB_CPLD_R","FLT_HSC_SERVER_SLOT5_N",
 			"PWRGD_SLOT8_STBY","","","","","";
 
+	pin_gpio_b0 {
+		gpios = <ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_b2 {
+		gpios = <ASPEED_GPIO(B, 2) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_b3 {
+		gpios = <ASPEED_GPIO(B, 3) GPIO_ACTIVE_HIGH>;
+		input;
+	};
 	pin_gpio_b4 {
 		gpios = <ASPEED_GPIO(B, 4) GPIO_ACTIVE_HIGH>;
 		input;
@@ -1719,6 +1971,14 @@ pin_gpio_b5 {
 		gpios = <ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
 		input;
 	};
+	pin_gpio_e0 {
+		gpios = <ASPEED_GPIO(E, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_e1 {
+		gpios = <ASPEED_GPIO(E, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_f0 {
 		gpios = <ASPEED_GPIO(F, 0) GPIO_ACTIVE_LOW>;
 		input;
@@ -1759,6 +2019,58 @@ pin_gpio_l7 {
 		gpios = <ASPEED_GPIO(L, 7) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_m3 {
+		gpios = <ASPEED_GPIO(M, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_m4 {
+		gpios = <ASPEED_GPIO(M, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_m5 {
+		gpios = <ASPEED_GPIO(M, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_n0 {
+		gpios = <ASPEED_GPIO(N, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_n1 {
+		gpios = <ASPEED_GPIO(N, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_n2 {
+		gpios = <ASPEED_GPIO(N, 2) GPIO_ACTIVE_LOW>;
+		input;
+		};
+	pin_gpio_n3 {
+		gpios = <ASPEED_GPIO(N, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_p1 {
+		gpios = <ASPEED_GPIO(P, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_q4 {
+		gpios = <ASPEED_GPIO(Q, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_q5 {
+		gpios = <ASPEED_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_q6 {
+		gpios = <ASPEED_GPIO(Q, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_q7 {
+		gpios = <ASPEED_GPIO(Q, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_r1 {
+		gpios = <ASPEED_GPIO(R, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_s0 {
 		gpios = <ASPEED_GPIO(S, 0) GPIO_ACTIVE_LOW>;
 		input;
@@ -1767,6 +2079,14 @@ pin_gpio_s1 {
 		gpios = <ASPEED_GPIO(S, 1) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_s5 {
+		gpios = <ASPEED_GPIO(S, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_u5 {
+		gpios = <ASPEED_GPIO(U, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_v0 {
 		gpios = <ASPEED_GPIO(V, 0) GPIO_ACTIVE_LOW>;
 		input;
@@ -1783,6 +2103,14 @@ pin_gpio_v3 {
 		gpios = <ASPEED_GPIO(V, 3) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_v6 {
+		gpios = <ASPEED_GPIO(V, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_v7 {
+		gpios = <ASPEED_GPIO(V, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_w0 {
 		gpios = <ASPEED_GPIO(W, 0) GPIO_ACTIVE_LOW>;
 		input;
@@ -1815,6 +2143,34 @@ pin_gpio_w7 {
 		gpios = <ASPEED_GPIO(W, 7) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_x1 {
+		gpios = <ASPEED_GPIO(X, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_x2 {
+		gpios = <ASPEED_GPIO(X, 2) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_x6 {
+		gpios = <ASPEED_GPIO(X, 6) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_x7 {
+		gpios = <ASPEED_GPIO(X, 7) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_y3 {
+		gpios = <ASPEED_GPIO(Y, 3) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_z1 {
+		gpios = <ASPEED_GPIO(Z, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_z2 {
+		gpios = <ASPEED_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
+		input;
+	};
 	pin_gpio_z3 {
 		gpios = <ASPEED_GPIO(Z, 3) GPIO_ACTIVE_LOW>;
 		input;
-- 
2.25.1


