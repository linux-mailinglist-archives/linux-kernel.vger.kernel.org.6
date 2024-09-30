Return-Path: <linux-kernel+bounces-343445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35140989B02
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E8B1F21BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452651552E3;
	Mon, 30 Sep 2024 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="TESTw8GU"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2066.outbound.protection.outlook.com [40.107.215.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086E15F3F9;
	Mon, 30 Sep 2024 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679927; cv=fail; b=eelEChRa1KS9OrV4jlrNk7/rxUBJ+jVR5DZcClm+APELeFg77tbLsZewmkvbqiGkoq2GY36lv1o5Ib/fHbLZovbWrCp1P0gt+GnkyiuR5atjgdCCZqq7YWt6qOt1cd2X1wq+l6hZMCXcmMagamOPQCZ59qJmg2PyGxQh2v6Zu3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679927; c=relaxed/simple;
	bh=E9uZO1DcV1bJu5JvZ5q9lhJ5O6T2r6dvRju2VjPx4qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRWDgSfP/IVNX2idm5bAaUEU6Ab1/AjlTELApRRYat5jZE2TEovywd7CpHxJvbGBa20lMnXVnV5b1ai4dXH+y5X/74rKXXnTfyzvS48+lnuL+tS8QkbrWB47mjaLxlqf84ljZcNqsvgcHaJJeDTg/8BAV45lKLo4SoSYz45JkTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=TESTw8GU; arc=fail smtp.client-ip=40.107.215.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRhfkF7Rdq9CW87br0QJ0GTvHPfxC4oazHU9yNQmPsJKRGiu/uTe7n4zQCK7CumP//P3FsMbt39F0coyVlKFB5JytdwN9yCe69nliU9xE8ufQT7c28cYS8VGCplaIXpDPgqP7Jd0Mzkv7iVfEVLTVnZt2JPQ483A7xg/XOsPjWNBpymaTTxIAHOG2J79KLGWmw/QosHIRAtTi6uEljDa0nnSeG/Fbo5g1ulJUTaysPbluFQtHPKX9klKTvn3P/xjtvS3oMZOGLdX+la1TyWCLIkC0shl5fY7JyZhduCMugp93IS/+0eFDlgQa8o8R+0WBLDHcMCKLKjNvPEalLwI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtIH1/Y9+onerIagJL+FnMR970KWC38a65nTICYTn5M=;
 b=fm+NpFZiQ1OZfx5UAY3VdbkQEmxxSVVmiEg+3MmVaSaj5+e9QI6Gvu+864xv4KzUItHUVuQKU31EnYPxnpcz20488DP6QrWFphZy/5lz8zLHGW8diHv+fgUjxWEsVbqzqVokewZ0Iew+HBC3NL3LpETq9B+bWkRcNtTFZavEG3I2pdvnUmCffb3fm/gIj8KkrdG5GUCi7b36rPEUx4IhuCo2jk/FZAWmjVXwOB89oYy151COZiT5c2RP9W3wLxasUW85WjLoS7H4qzGzsL6h/Iw2E4YxN/MfqG3GALCXAIgE7pmPnKBtcNlwI7U88F+et7b734sT6oO0TIYTJzV02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtIH1/Y9+onerIagJL+FnMR970KWC38a65nTICYTn5M=;
 b=TESTw8GU46dTKnQo6dV4s0uzNIWUr4ilGrSy9TbE0EpK0xALYWbD1iVOrmYUQkPQSG32cs+xbSdJABdxCvOVoS2PSuauKYALjyEhYl8eguhW9/q3FwOAKAdluJEp1l9w+3QpCEoe9lhQ6Py7n0VuijhOsDQEN4LNIE0VZMmb0Ie1X2MgG31KAX/IC1XEqo73se5teEkZi76FbbCcXNib49gh67BF3p+W8P9VzlbRdoax80UQzA41YpMXNBsqU3oMES+SKygYcPR66V6SsbJ44/l0cDXhZ3nf2vRTF6Th/I4iLzZB2DgKVnJkwU0Qdg/oS1w7+5grCSUDm7xJJo6Z6Q==
Received: from SI1PR02CA0047.apcprd02.prod.outlook.com (2603:1096:4:1f5::15)
 by TYUPR04MB6764.apcprd04.prod.outlook.com (2603:1096:400:35f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 07:05:18 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::d7) by SI1PR02CA0047.outlook.office365.com
 (2603:1096:4:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Mon, 30 Sep 2024 07:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server id 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024
 07:05:17 +0000
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
Subject: [PATCH v1 4/8] ARM: dts: aspeed: yosemite4: Revise address of i2c-mux for two fan boards
Date: Mon, 30 Sep 2024 15:04:55 +0800
Message-Id: <20240930070500.3174431-5-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|TYUPR04MB6764:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e4d108f2-c21f-43e4-edec-08dce11e3e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vhLbRl0A5FILQ1ZcjAVu2R21f3vfUfvFLnYuGk7d3IvinCpUM42C9FhiRNxw?=
 =?us-ascii?Q?rT9dqJABbBEsEVo1YGV9bdFLmjkPwZNrmfe2alVvNTUxl14gOSi4lVLAoS/0?=
 =?us-ascii?Q?B100P2410Es+J6QH3Jp4U+xjdTMQQ/igIqgD1tDDleaVTLM1XG08UcuPCuMj?=
 =?us-ascii?Q?coiffSiiOg6jWlg7KIA3IzBWT6KIpgg25Iq3yRy/S4yUER5V/o3SPQMepNZ/?=
 =?us-ascii?Q?2y5l11Bieh1NVwg9BkRhqIHR7ulRpO5dgIIQ6kvHU30F0lJC/0zPip2dB6gW?=
 =?us-ascii?Q?foIHuqHaWqlDQ9mH4iQTGfrT3IYBh49m17TQM7Z5z2sWD3z6+9zIqGPFwmar?=
 =?us-ascii?Q?wbZY+ULGUFJBW/6oYN5U2pAh7EYaXN39ZmaBfvlskglthMr3vWlZn9bmzvO5?=
 =?us-ascii?Q?8DjEkjhBJXToXXBIqYnc0LXzA0AtxuMI2gFxpjEHHdU0BQjKsnmZ368Hh4rr?=
 =?us-ascii?Q?5AtpQrsRfMM2xakoAGm2d2stuQQpW5TkDJYB5xpdQ/Z/ob8QwhZmwvoyatU6?=
 =?us-ascii?Q?cJG3j6g/Cp/jVsJGvowxERIqzaOvSdlaKF8Q1kdgaulsKcaOr0eNYU08XjDV?=
 =?us-ascii?Q?JU8C3GPzGmGQbVeQHPN6ZC9hrjiDGhYld3xYMo4/AUqBKHBwX1Z+eZpFrB4Z?=
 =?us-ascii?Q?I4T39Zzf/d09SAcugukLTE4T9ohcN8UhizpuTMsErrGFW9kRKo2nIW1TwKFg?=
 =?us-ascii?Q?rs/usQjqqLTE5K2LzVJ1KC2vrLe1A+Os83L9/PT9MMehsaI2j/ExQ6qDAnFv?=
 =?us-ascii?Q?nwMiawYETB+1TV4ZpPyljC/X7fYMP25CgnQft5C8TkuZN/RrG8XCqP8n9HOd?=
 =?us-ascii?Q?EcGAUdg7uQW/UwQXpvfuN5ffu8ziwDt0nXoaqjTNiBrD5SVwfexYtjl2zQE9?=
 =?us-ascii?Q?MBaxYsTeaqehXiryszGpVpuO63QV1dg0mzPRqNLqJNIYA6Tu+rx8HKSPZg5/?=
 =?us-ascii?Q?RxKAhJ3R36q+7+NYNi8f86eatn+qm++GuAghkaiMUGYoBjDVd77/ghSk/eEL?=
 =?us-ascii?Q?vyBb/tOLGktIPGzkNhfGg01fxuo01AxaWYekrUOpaW+bk6Ic7gOow5PNrW/k?=
 =?us-ascii?Q?urcHLqioIaSLIqFmBDh5pnk6Q0pNVyILecwHOSZaDYT/EYoRDI9yoFGVGYCq?=
 =?us-ascii?Q?V8p58ifYARJku/4TXYMx7fgWPKn8AFOHxQ6IGOAif7AD3lQDyYqXnLS/Q1gC?=
 =?us-ascii?Q?BPcdAykADSyVyBqDW9ReJHc5g+5a0YqHHKq/zrq9SZrdsPXNbo8cLqEQvHgh?=
 =?us-ascii?Q?ECFhyOYrDpItp8NT+a2SknvqM2TlD940EwRyBK/48R1OI5MpK0iUXrA9K8yP?=
 =?us-ascii?Q?tRQNrg4J1hAf5aa1gonWnd/DGO/Oyh9mJwC7LUI0PTxdC6PM1gI7o+zKo+EE?=
 =?us-ascii?Q?/lfTJetcq2gPggdmLXc+nHk7RbgpcrpCtYV0skh6EQZ7t14MZgZevAsDJ1AR?=
 =?us-ascii?Q?XygILmXEpgLnPBphnEpWcVxm3Dpel82j?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 07:05:17.9155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d108f2-c21f-43e4-edec-08dce11e3e09
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6764

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Change the address of the I2C mux for two fan boards to 0x74
according to schematic.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 80 ++++++++++---------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 26e0fcbed8d2..ecf012c9cbbc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -32,6 +32,8 @@ aliases {
 		i2c27 = &imux27;
 		i2c28 = &imux28;
 		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
 		i2c34 = &imux34;
 		i2c35 = &imux35;
 	};
@@ -1062,6 +1064,8 @@ gpio@23 {
 };
 
 &i2c14 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	adc@1d {
@@ -1122,20 +1126,50 @@ eeprom@51 {
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
@@ -1152,6 +1186,8 @@ pwm@20{
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pwm@23{
@@ -1181,10 +1217,10 @@ gpio@61 {
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
@@ -1202,6 +1238,8 @@ pwm@20{
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pwm@23{
@@ -1231,38 +1269,6 @@ gpio@61 {
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


