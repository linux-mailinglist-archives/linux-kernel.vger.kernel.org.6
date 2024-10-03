Return-Path: <linux-kernel+bounces-348695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CBF98EAAD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7676F1C21D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FE9130AF6;
	Thu,  3 Oct 2024 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="r8G0jk6K"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2052.outbound.protection.outlook.com [40.107.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB591448DC;
	Thu,  3 Oct 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941396; cv=fail; b=nINMWuEUmOKvpFhSBlqK+meyN5ShXNMtwx0zPYnk/1n6xkXtWANUaNRE87EHeipkhNsAlIRNAfcY2S2WK4JcVaM7M6wrQboh0mloiUXIupbomCv11msf5OzssVCG/r2soxkXyR4YqHWkVg9/Ch8UC+QBMMHeEx8Km+x9mEEw61c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941396; c=relaxed/simple;
	bh=8YCporGGvuFEIYicVgc7/rZgLOc/6sQLjSgoElqGbgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6kb9ZDa53t4zCugj1RiYF9QeM1YcPej388fEe5rIvKwzXa+bGkkof2Fa5X7IF1mXbphQfjNJIYFQX6AGJ4e0wEiYEOI4H2YBhHvljIsq4iLqbcWpuFIfYaK0uz1nTmYIeJPqTl8JkQWSEKQmu3YVTs+t9YBDwAgRb4rK311F7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=r8G0jk6K; arc=fail smtp.client-ip=40.107.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1ndEB3O4KOS9W1k0VHNORUknXr6JXYjvJyF0Ttob0TAY9OK0O5+Umd1TleyS6cDawWoxo/fD7MX+8fhJEhbFROnBwWSjmEcPSQl3gZDJTisZ2ZGsW/4uMlv7gumOX0ejofpgIJAna9+lVOsND6OJgocjeNjgXEQALIqMab+MhMgDFoHTbHtWi9kDFQM9B5cB0oviFHQN6fZmRQeXKNLLp0jU9j3NvV58ToXKowYUTNUkmwLNlpAGbmmvxNYAqqoxEcx94wxNgiFZ4T3EGcoH/3gCkQPwR3XAwSmk4FWcQPtPvWl64j5DrH2vrg/LyEKPSxgthWj25Jm5QDtWGYQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Yy4fR8HWBBwDtve5r7q1np0aURr2s4HCWBOXwCOpEg=;
 b=MTRFdgepLqyChYguIDg9j+hwGKe65iEd5IY5whZlJ0XlUaxRk2f9ARfLcpyNYZZ8c7ychu7uahGQHeb87TZQjq4sEZkv8cq7gPBwnEr8xHOvlfY1GAjPQidMznaz+0kRnjVFXMVGlKF2ifCWJzP2RIgfJN0zMbbt4O7Q+y8ItlyVtq3RPYw+F5Dk0N2+iOX/oyZYTAmPArf98crzo0K68uT7CcfLB36FpLDM/5/cZZI9yojZnIiITtoVC1DaaM/UuO5g9bSYrVFja41WD5C+y0A5AVAnFTvkQ5rFpQAdlGAUofzrmuBuYDMh07JtyT0nBzmGBmSQTGE7hNCN2bcnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Yy4fR8HWBBwDtve5r7q1np0aURr2s4HCWBOXwCOpEg=;
 b=r8G0jk6Ksu1DT8s4GQbOu9Xk8ckwDzceEil4IA5Yhzh97LxA2PLJw7/lgdfPUnC3NecQtObBZa5vZGeoGSMIKOBHStoAI2QJv5wbWoosZV84222/Va+J7AZYdCs55VZuj5oe9tBrMrvmLUtORoB3dyAwELyzBJyY9CQxK0cMX/9SotILoAqdHn4KtwsG7kN/azQUBcLX41qPF4//wZK1qGs/VHx6WXrEG+HcAnXQNkGYiZ/sUrApqG597ZNu6EZRoATe9TVjipFrobDujJgVEOTHlZdzQ6veHW7WoW6GDHUY772Grd6I9XjwACgFOtKLuNZUzaZy66w5VtbJgZrYEg==
Received: from SI2PR02CA0010.apcprd02.prod.outlook.com (2603:1096:4:194::15)
 by KL1PR0401MB6588.apcprd04.prod.outlook.com (2603:1096:820:b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 07:43:09 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::f8) by SI2PR02CA0010.outlook.office365.com
 (2603:1096:4:194::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Thu, 3 Oct 2024 07:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Thu, 3 Oct 2024 07:43:08
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
Subject: [PATCH v3 6/9] ARM: dts: aspeed: yosemite4: Revise address of i2c-mux for two fan boards
Date: Thu,  3 Oct 2024 15:42:47 +0800
Message-Id: <20241003074251.3818101-7-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|KL1PR0401MB6588:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d6b2ae95-9541-4641-34f2-08dce37f06e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xHoYI6lK+9+gCH2n5g2q5Tub7oRuwJGxbRzlFZJHQ+AWfJ/n1+MxfgKQWz4o?=
 =?us-ascii?Q?OHKg74mKDXwoJJFqUQqSaT98vYd2hvYpvngC00gw5UyzqDHpkAx0uz43U0N4?=
 =?us-ascii?Q?xCznWVfF2UsKEDdk1Pot+UPKSLH+eyFCQRWChgyLEndqHsJnh6rRRfktXaX8?=
 =?us-ascii?Q?YE1qvc4CWx+fHlD55chtmLUt94VPtIg5tipU4L0Ih6AazvafETozR2RJFjUH?=
 =?us-ascii?Q?aGon7DjlR0U2UWvUrNHDDkzGBJ4rUWRkXch9zNGNvjro11GVca5knNmRtq8h?=
 =?us-ascii?Q?8QEmk47BqLKV7lGHC+qvaiB6cZpt+Lj/k/kxYiPFO5QrQD01J/n6ttOyEm+V?=
 =?us-ascii?Q?EbA0QUpIPKTpi8h3TmW8wpwN/xAsgtSmFV8le/jLcZTTLoocQ9ZsZZnWOcw4?=
 =?us-ascii?Q?mJIIBdSgJjfbHWrPM9EBZeLMsa/b0leF0O8qaumblW/YLrT4PZcTgYCKsENv?=
 =?us-ascii?Q?vDKnEFfGfVjwY//sLZcrnx2jCtNGhy44vryzE5DrUoluW5hvOiql4KZTjvUA?=
 =?us-ascii?Q?+VdYjQb5UDPHUDmd6I5Ows9ywSlFPvR3L61bgv8wHXkkiR3GC4ucJdinGgjy?=
 =?us-ascii?Q?Xs/zO49M1g4IQ8GBGYTDw+J9OrHM85Gb2qFpPYfIs7K++xgB+EPmQ/TfaoaW?=
 =?us-ascii?Q?uEDsKYdtGxQaET+gV0fAjuFBDvZXTPkIBH+T1sC4IUaA1EkrLTvercQI0gPU?=
 =?us-ascii?Q?aMdmfG4oMV+EQxgehl0XLEArv0WY1Y3CRlI/XPQdMTYqmhcrI4xlQjJdp7hN?=
 =?us-ascii?Q?QA3R2OFqACPQAzko6+Wnv+MC6F0k5bHdZdMR0//Wjc3uwJnrUT1ur/+Vt+JQ?=
 =?us-ascii?Q?TtAB4b0S75itRfssPEcRE80sKphlpHBbmuGsh6HNdo9PWpRAE3O3WWE5bxMW?=
 =?us-ascii?Q?/ruKKsxUyK6iZ9fXXVP1Rm7Jq6sv4iosPO+2Ry0Qb+437IJuE63vzgQNR/S8?=
 =?us-ascii?Q?zQY+yv4ecKj0OWCAnugjugJq2Vi/pnDzDH+aY2T9rWcRS/47Hw9h3IvMCT/P?=
 =?us-ascii?Q?PFVUSDrOxGeJAxtfiUsre1MvBGAOP9HoHzKoXPkmDoaA1QqHHKPPbPE4kPM9?=
 =?us-ascii?Q?/2UW/Ijugfp1ZvQR7L4oaynV/7uC0oWeb8khGcxvyuJ1adPS2TOxa63Y/UK+?=
 =?us-ascii?Q?DIkNnzQzSh7vZRtiyu+kgdpKBbulwJUTIUYkSZj0xZosANSyD0LQxoiAo/hM?=
 =?us-ascii?Q?0ryCMlifbx6CjzqztJXS+8UbAdma8yfSShOo5JHhCbKyp8862ZRcoMvE4Ecr?=
 =?us-ascii?Q?qTHwwKB6CPuZrlW3Hf5ntHRB7bVpUUUNQC17Or3NYyl3V55XBCbFNTLipwib?=
 =?us-ascii?Q?yFbaKfk79fuodIW3N9C37SKY0JSKhpI0+okW+T/Rt/FFKNrNR9WCp4+q+H/z?=
 =?us-ascii?Q?HQl5kPA+r3SbvhJLYBaah3h50OCy?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 07:43:08.8057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b2ae95-9541-4641-34f2-08dce37f06e6
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6588

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Change the address of the I2C mux for two fan boards to 0x74
according to schematic.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 76 ++++++++++---------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 9a9096c94328..7531ac217c81 100644
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
@@ -1034,6 +1036,8 @@ ipmb@10 {
 };
 
 &i2c14 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
 	adc@1d {
@@ -1094,20 +1098,50 @@ eeprom@51 {
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
@@ -1151,10 +1185,10 @@ gpio@61 {
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
@@ -1199,38 +1233,6 @@ gpio@61 {
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


