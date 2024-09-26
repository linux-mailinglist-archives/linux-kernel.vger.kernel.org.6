Return-Path: <linux-kernel+bounces-339847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C865F986B52
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3789A28386E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27BD17BEC1;
	Thu, 26 Sep 2024 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="AvKCshK6"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EAB1714A8;
	Thu, 26 Sep 2024 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321315; cv=fail; b=eFOlwHoET4CBtB2QCF5Xl69h1q836xBoPEQHh8ooOx3JKicdYdEQ8KOmFCHA2re4mq/9W2tgR1GqCKjndzdWjlhoZDhqvsAAiWZTS7GNMA6v4laSoEf/NJjm4rROENC5kI+dqv+AIXCmIFZwuThOYgLl1DYstBT+oj2mbhgBr6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321315; c=relaxed/simple;
	bh=9uXwEvJbMslsKtxDIE8DUKVtFTyrg06Ry2ermG2asSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTPQ70PHm6lPPcOIj/lf6sDuWFm6QAwK29c4Gxp9knOOgX8R7f42i6v4TzCvX6WgT3/EmDATg43dw2OalZg3lW9pB401YHBT7SWNm3Fr5GedoTsTD+e1aF/AGnvWBXIR1gqr46bDG//DdNsR+eOJCoYNclB17TsZg1mGDTA9EIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=AvKCshK6; arc=fail smtp.client-ip=40.107.255.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFihB5gO5CQ1Ji3jfzKCZf0B9LBfkETWdbuB95OuLOZrustZOFabp0si3KDzCHn1PzRd6KtVV4m/iAk+GShyr/Pafl+PI9Uqwbsr6snu+9zIGzxTH0kWg3m+MbGJvJzqAmLE5vCRNr9HjRC+jiNavWZbqKaHobvLDSLV84CELkCit1M8bk+pNWS0kynVCNKxgiLnP1MUlouhzTmiMR14u+l6/q3csYkSld1ZCdT8zznxuZ+ZhRGWCWQUVmPWMa4uUDq5A8qyzLwCOLJmSZJp8dXKoeKcdDb++pnYdvxeLfzY16maIOf6+c+WT2BLuPkaA1IreUAey4KcYP45itWmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMtSQcN9CV4Ragazm03k1sewAAIpWZxMagwsuuVYUX8=;
 b=oY6yIVkZNRDlHMGxpIENJsj0eiPNsrB9ac/+4dmwLrP+1w4SmjsGw7iLJwEG5k+nwbFAyXM75//4ohJ9doU+z9X8m30Pt4M2l1SzkgHTy1TDX+d68G0R543hgy8sasVYLSnwUFKi3PNhx2YT4t661HhiGCznSlajf+8NUn57dpdBXSkAHqu33H4QWIIFJprJQDV5Ex8+IU5x68/2S2husO/cpMHRu6mPVVxJbkZr7SZUk4VqW95zbCODslJpYOFsfLy4rRK7SFD5z9s4fzE0DAzgAgzt2CU7jxVyxYovj4ZJqG/nwn3bqmRM87Kd8EK36T/MItEkx7X8/78SchVijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMtSQcN9CV4Ragazm03k1sewAAIpWZxMagwsuuVYUX8=;
 b=AvKCshK6W58z2PYPCt+fKO39CJ+iYoF8O66CSYuhE6RrEXLka+8di3pg0rW+xNt96DJCZIgvm8QW2nEouHumL+wcf7o+4M62k+fWpWLmbacZ9ji29P6kNQS+LPrb1jzFN/tQAlvVSwhxrZiWOndw6rRsWMyWSJhLTRTFibH+V+P+R5dBwhyDDofxOcxV2eSR/OHtbPVYcb22GdEz4hU6UbmJd3HBWB4x/qg6kl+CtrgD2Q5oB75eMktMD4G8k4UHYgNEZGPLmoNiuhX1jv55lKJhLSNzWiOGVisllF/r/YDHfSqlzpmGDLGmsly3laQaGod9wIX0KU18oD0cpsw4hw==
Received: from SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) by
 TYZPR04MB5854.apcprd04.prod.outlook.com (2603:1096:400:1f2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Thu, 26 Sep 2024 03:28:26 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096::cafe:0:0:20) by SG2P153CA0012.outlook.office365.com
 (2603:1096::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.5 via Frontend
 Transport; Thu, 26 Sep 2024 03:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server id 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024
 03:28:26 +0000
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
Subject: [PATCH v1 1/5] ARM: dts: aspeed: yosemite4: Add i2c-mux for two fan boards
Date: Thu, 26 Sep 2024 11:28:17 +0800
Message-Id: <20240926032821.4171466-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|TYZPR04MB5854:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7c4cd154-c1b3-49d2-809d-08dcdddb48b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvKIYPty472hp2kHoeoyaBIhFankMwqm2hkDj5ydZ0WzJYL0+UmCIYBB1Ypf?=
 =?us-ascii?Q?lsY9rohjR8F0h+iAxr/sbB10EmkS7Pr3Er99RP0486FYXhDbCRd75tkNj+PH?=
 =?us-ascii?Q?/Bu5yCUslUu8Ufn5x4x4F6ImDEtC5ov9fmxAk0a2SiB5ZEbpV36NcU8Okp+i?=
 =?us-ascii?Q?lnSL3hKMqo6TRIRaHfPS2LXpwZ63BV+9/WtOzTqPjcaVF2X/Su9x7LiES4O1?=
 =?us-ascii?Q?vZ6akIIBk0HqaGkMuXZ115f4NkCSewHUidpQXeTwCPdMEOiP95E9oy6KjxQL?=
 =?us-ascii?Q?h1+H0J5sxuVtwb2jl+hwzKJz9LoiiWfuRaVvJHekeQmC45AvcHUQsMex5COE?=
 =?us-ascii?Q?ePwoazVMVOj9NKwtC3pfVN3KPLG2fVSsKeV5zOgxT7EFMKToDl7Kuu7xiTKB?=
 =?us-ascii?Q?w+Vnj8CuVBeOcVDEopkepZTnz+9mCE4zat+tsErtzNZ4zz7U+ZXEFbsdA4dx?=
 =?us-ascii?Q?4wKzrqFLEqPbR+JdtuTwQrLOhzxmJs4+RhNXC9fc19OQ+u5nipuWDNhuqZkG?=
 =?us-ascii?Q?1IhQttyKRsQqI/Hi/JPXoz2L66ctw3GAtmOirlKehQ+ECNrUmDrgiuaJliNH?=
 =?us-ascii?Q?/nF7s68Kd5XW+NcEbsMuRapRmfAY2Cm7tTPH1oCW24gsSkL1ZbnlapnWMYeY?=
 =?us-ascii?Q?pUqrUBBw6j9j3No1hfAL1ZMIGvvZIVMWwkmLgVvY/FFHUiMVRVb7po+psMZM?=
 =?us-ascii?Q?YnQavbV7p/822+WQjXo/YbTkRqEBv7jt3k9Du8tojB/fqrGQqwlB54zgr18y?=
 =?us-ascii?Q?Ddam/t5bYE3WOQsyvvcjONvSdrC8CurLetO2eJ0Onf/WQkIr/7dGBlSVKnWs?=
 =?us-ascii?Q?8lir2FPw6qZUCWHIUlgV6x7EKEoYIQNW33GOYIEorsJp+wX0LrA7CVNCXPTd?=
 =?us-ascii?Q?R3O/I+ylytOE69kjD4AjYO6aKlQ4AtuD4WT2sEQdJ/UA3qW4/Tzmq/Wy8FKm?=
 =?us-ascii?Q?lTSYGiEr6M77DgNtRXNplP34l8ODA3h7JpyueAFpEN7VsyVBotVkay8CU6uC?=
 =?us-ascii?Q?qFoBIhvfkJB+iqj/oNsfH+CykbBscnN0x0D+OXcU7JbZZBhJQ5nVbVf08jQ4?=
 =?us-ascii?Q?HnoTlisJ7ASwVHCmfdBLK9Lpu2F/ElkT4jEwGMBPFHLMBeUK9FkVcO8YfiHz?=
 =?us-ascii?Q?0W62AC3t6kxpO2wGHzft82BS+BJOI7n4K+bLnLUC3nq1xiZj/YqnA89pJzRj?=
 =?us-ascii?Q?YvDXmATacVYCSU+nyIgY2txvhDw9N21K1u16SJkj+KRR02KsWwfYihOsFKtY?=
 =?us-ascii?Q?8s+e55pBlWFcl+8tofT5EucjhI/YIcxsAuau0LbAd8SsxMVvKFKxLu8hTYqy?=
 =?us-ascii?Q?97YAvx7FF3fTFDl0X6lJZpl4yvNczeXDYVnKFhES7OdXIyW/9qYnyMgeRiqf?=
 =?us-ascii?Q?muBqDtezmQBggExlDquVyLgfP6ue?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 03:28:26.0298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4cd154-c1b3-49d2-809d-08dcdddb48b7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5854

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Change the address of the I2C mux for two fan boards to 0x74
according to schematic.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 81 ++++++++++---------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..04f6378c2b5f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -17,6 +17,9 @@ aliases {
 		serial6 = &uart7;
 		serial7 = &uart8;
 		serial8 = &uart9;
+
+		i2c30 = &imux30;
+		i2c31 = &imux31;
 	};
 
 	chosen {
@@ -380,6 +383,8 @@ ipmb@10 {
 };
 
 &i2c14 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	adc@1d {
@@ -440,20 +445,50 @@ eeprom@51 {
 		reg = <0x51>;
 	};
 
-	i2c-mux@71 {
-		compatible = "nxp,pca9846";
+	i2c-mux@73 {
+		compatible = "nxp,pca9544";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
 		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x71>;
+		reg = <0x73>;
 
 		i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
 
+			adc@35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			adc@35 {
+				compatible = "maxim,max11617";
+				reg = <0x35>;
+			};
+		};
+	};
+
+	i2c-mux@74 {
+		compatible = "nxp,pca9546";
+		reg = <0x74>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		imux30: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
@@ -470,6 +505,8 @@ pwm@20{
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pwm@23{
@@ -499,10 +536,10 @@ gpio@61 {
 			};
 		};
 
-		i2c@1 {
+		imux31: i2c@1 {
+			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
 
 			adc@1f {
 				compatible = "ti,adc128d818";
@@ -520,6 +557,8 @@ pwm@20{
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pwm@23{
@@ -549,38 +588,6 @@ gpio@61 {
 			};
 		};
 	};
-
-	i2c-mux@73 {
-		compatible = "nxp,pca9544";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		idle-state = <0>;
-		i2c-mux-idle-disconnect;
-		reg = <0x73>;
-
-		i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-
-			adc@35 {
-				compatible = "maxim,max11617";
-				reg = <0x35>;
-			};
-		};
-
-		i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-
-			adc@35 {
-				compatible = "maxim,max11617";
-				reg = <0x35>;
-			};
-		};
-	};
 };
 
 &i2c15 {
-- 
2.25.1


