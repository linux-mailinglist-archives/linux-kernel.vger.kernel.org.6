Return-Path: <linux-kernel+bounces-256994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 552B49373B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA70E1F23F98
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C22C13B295;
	Fri, 19 Jul 2024 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="UWGZ//Vj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2075.outbound.protection.outlook.com [40.107.255.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A5E132113;
	Fri, 19 Jul 2024 06:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368839; cv=fail; b=BdPyT67W9JrvyT9ui/ovXQnPtT30zOSJXlpQe1GLeOf00hafumDBDt48417QGPjRCn48YDfvcpQhp7Aba54YK4l9+LkjY+A/Yla/lGA72p5uhTmQJO+P588fM3oIlqQN8oe2+oTQe6L/qhso4r7wSKWFIv5R/miHt/jVW4oJrKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368839; c=relaxed/simple;
	bh=fhg4U8+WiKeb0My6Uagt5utZDdeFL2VNOkO5q6j0/ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhADcYubsDibp8l1q3veL/0cOAGmDkVyU48HB22k4nNIwrkO2JyAoqCxiKw1GERPVjWuE+IjTL4twnGVCBbBTZquVwpsaVZsxhBo6iDVn25ObOS8lTBwvbdcRwVSk3mDK8BfdH1H+gX/OrpdeJLoWdSP4gSQB2qeYp61rSwzzrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=UWGZ//Vj; arc=fail smtp.client-ip=40.107.255.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODyfhJzzLyXc8uPh/zaDTbe2R7MCogbWtjfrWObwm8+wqgQlGNwgLluh2DQfuBhfWyXOyvnaPPgmph0y5nlsts3pb2ciO0JvbmFifHuHLoF67TREgg/LwthPYDBC5UlolxsoV0NMR91+MwQaM2ekXiDQp9x/tgC0az1w0eHyHz5F29Hh4BFk1DEs8rKbYwKw8tKl7L+uQ0tvG50m30+fy4+mVwi42YZPLthokn+tmeKFMN0pYYSxHGrUirbTetAb/85/hV6YA+FN/d/ZcczFKcWfDiF8yccvFUjd/+NNZ0oWNzbBlZfSy3ZY6jtyJGk2SY6W1pO36RVHHsjzO20BRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES3SdMSGvrNhfRoLPeIA0V55NxyaiAY/qzb3Em1tHrY=;
 b=Rt2gpsws0Vc9zyTwWxMNNeJHyMhpT7KHJN9RuP/2ZS6lrCbbVyqpeKiXBDumrW6vMQbGrscPOvhbKcj6zBJ2B96jw0XKSkwG+GyJGVzWDVgvqMv0wNiR+9rYEZAxaqIr2ycpnXUUP87yfeld8Dw/ZKAIkw0LfA/1TbaijvT8XQ0/aWdFWSRWnmrYL7kaprXUwwoIc6MO2ul74DfHkPm5Iyi6lvwbgGX5bbAsVZjVjN3K5wplZgSh/1VwppqPwTejWlL0Dt/HOYChhzdlFmYFp+URfRQmDrvZuSAmOs44NrPTqlYBZXUX16UZfoNymdXYr0ldYj20dC//X/FV2CEMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES3SdMSGvrNhfRoLPeIA0V55NxyaiAY/qzb3Em1tHrY=;
 b=UWGZ//VjYGf2kDW0hqNzO4fcTMkDgEneMom6HyFoAt1hzrjBLt77JsMbvesm7HWSo+LfzTkdQa3Z4mAbmvCy4iORa4BblO8Q5PKpBb+50WNaDYMEzhQFZlmUH5+oerZW8B6Ak2ihuJab3Op1KXzFUTyF6Mjaw3+gu78yh15i3GsH++Iz4MtfQCL5KU0Leb/B0Qr8aHxRLcOlbfelDl4J31MAEC44HGaQBNUWMx1Ado99coa9s9nunj+K+IsgCzU1rZfQg950RY1Ct5ru/HtBcRAZ/boW5jK1L3ltew+y4Mb4T6v0JytbU1IwPqh+wi8naWIiZwLUYyd3LStmePHfmg==
Received: from KL1PR0401CA0036.apcprd04.prod.outlook.com (2603:1096:820:e::23)
 by KL1PR0401MB6259.apcprd04.prod.outlook.com (2603:1096:820:c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 06:00:33 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::af) by KL1PR0401CA0036.outlook.office365.com
 (2603:1096:820:e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:32
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
Subject: [PATCH v10 19/27] ARM: dts: aspeed: yosemite4: support mux to cpld
Date: Fri, 19 Jul 2024 13:58:48 +0800
Message-Id: <20240719055859.4166887-20-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|KL1PR0401MB6259:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 65874533-f738-418a-abc7-08dca7b819fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|34020700016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NI2eWqVlYUlWIk5SgwGjcLLkOlKaZwp4VMI0vzQdALW0TvSVGbL1WqU5ROLL?=
 =?us-ascii?Q?kS60BtNA6NNXcTTahtmcGAYfmBauumhQ0XLDJNEci1Vv2DdMMN/YxjlJNHrp?=
 =?us-ascii?Q?ESz3ZNB/I72gKUnDGzXv7oywCnOSobZToU75/L4+fKuQYJKF55ceBqT8v1XY?=
 =?us-ascii?Q?qntEXSREah50CTN9swmzzIIvd/5i7z+Bp9LeCpD9Oy2Zoe0Xz227qGqNMm4A?=
 =?us-ascii?Q?PtW8Ct+W8QrOXY1MZLLwAh681zMWI2bAG7oxD7ZY84nUlxX3eppJmndaSP15?=
 =?us-ascii?Q?T2OdEi215tRIypjqVoX1og8/tdhgFUJkOtufkbxr/OLyLPvc2sYQ2GEJL0/N?=
 =?us-ascii?Q?9rVbBqzj97IK9ESJmcMs+QxqGcZpH8nQzzs4BQxLDqlqAcQQ3TJyfn/WkUxE?=
 =?us-ascii?Q?b1ndubr9wOWpEwFjROvkxrWJrqHzJe0Lxf8n8xmqASEY49KtPnMxLZuepnaF?=
 =?us-ascii?Q?YqCA0gb0NHwSxNf7KbAGDI9rWITO08LA3ny5/cjBI80RzYEUt+H/+yuzjNSC?=
 =?us-ascii?Q?JpyypeJC6YWoV4nsrvBoAHjF8M9tRIY33If26zkNpbPqHdDhwPzgRZ2oBtn6?=
 =?us-ascii?Q?zXSYUEfmXKUv9x+dtFIWWuBpU90rESh0bDPdJE4LjJhG9RbtXFIxBJwxIdUh?=
 =?us-ascii?Q?ym5bx8pvn2DO6422HFIq04OXr56hGLQTRu8jRtyPdLcTwT97M8qA1xLaXczL?=
 =?us-ascii?Q?uBNxWCggCY4E9tAjXNnNHeqquwce4881UMLfmTiFyS/JHjG62mvUp8/6mClW?=
 =?us-ascii?Q?O3zT1Bk15F0a+OfNEqosyYeMIVjfJ0lngWgOQxD4ajCdJFXzZeRroh8z+qjG?=
 =?us-ascii?Q?SheTh1/S5ZcF6KtLaUyAiCNH+MCdgwhAc1fgsSOEEDvpNnjj35HyQ/MtxXcY?=
 =?us-ascii?Q?EEchgSNBxmJ5bQgcx0MnA/6A+nD7EYjDk31OdUMQ5/3TAnpt4rt8bPKw5JFx?=
 =?us-ascii?Q?q+zDg7WaBJnKHRB31a3nhtmD5AcUCKmKZUUQkHqhXf12dd94+9cWF9SJ+F7b?=
 =?us-ascii?Q?k5H8iIEnkmm35Qz08MRuyW4EtT0TMVuCOTGNs/FTRynpIsjZ/UHALH3D17+N?=
 =?us-ascii?Q?ZRYLvCwo8WU5XmgPWYGZdQhhmU6heEpVqNaS6hOxRcViOgQ5Ck264t69L/0v?=
 =?us-ascii?Q?x1DjJPPTTPtkBp+2ZpyEujt6g7bJudagofSGn6kPmbK17qeZFhU5lV4Ed3ko?=
 =?us-ascii?Q?qvONdvGP1Y5mYU7resSx0Cp2z7yVMyuu2mjB9hKvBG4VNzB3pD7PJ/O9w++4?=
 =?us-ascii?Q?UeJ0ia4g9AtfdqzpI2WabxJS7vJ+bOO5idjXFODsWq8mdTRcxKPnwbV+So4i?=
 =?us-ascii?Q?x+X6g9sosVC5Iuw+lgiNSlXPUNkH7l4Y3oAU9VADGqdfq24JFSorOT37BqxU?=
 =?us-ascii?Q?3xOy/87YFDe40WYRX4yTe2+L2zcG2i8K7KOhWEeaFcMUa+SnDWpXfQawyRqN?=
 =?us-ascii?Q?+iBgmedMDW3b16Jza5WAzn0Pz6fl2XPO?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(34020700016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:32.9390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65874533-f738-418a-abc7-08dca7b819fc
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6259

Mux pca9544 to cpld was added on EVT HW schematic design,
so add dts setting for devices behind mux pca9544 to cpld

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 64 ++++++++++++++-----
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 83c9d76f5a11..f4e37187bd5b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -36,6 +36,10 @@ aliases {
 		i2c31 = &imux31;
 		i2c32 = &imux32;
 		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
 	};
 
 	chosen {
@@ -951,24 +955,54 @@ &i2c12 {
 	status = "okay";
 	bus-frequency = <400000>;
 
-	temperature-sensor@48 {
-		compatible = "ti,tmp75";
-		reg = <0x48>;
-	};
+	i2c-mux@70 {
+		compatible = "nxp,pca9544";
+		i2c-mux-idle-disconnect;
+		reg = <0x70>;
 
-	eeprom@50 {
-		compatible = "atmel,24c128";
-		reg = <0x50>;
-	};
+		imux34: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
 
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
-	};
+			temperature-sensor@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
 
-	rtc@6f {
-		compatible = "nuvoton,nct3018y";
-		reg = <0x6f>;
+			eeprom@54 {
+				compatible = "atmel,24c64";
+				reg = <0x54>;
+			};
+
+			rtc@6f {
+				compatible = "nuvoton,nct3018y";
+				reg = <0x6f>;
+			};
+		};
+
+		imux35: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux36: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux37: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 };
 
-- 
2.25.1


