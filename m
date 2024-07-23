Return-Path: <linux-kernel+bounces-259823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34714939DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F6F1C203A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89EC15357F;
	Tue, 23 Jul 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="BCsBhghY"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010069.outbound.protection.outlook.com [52.101.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B21534FB;
	Tue, 23 Jul 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726674; cv=fail; b=mM5T+qvIStwGLoUAcFU7VGCJkkr0o5MLvE/WVeU7RJuzrPEzDtuX5U/Uqu7dNgnOlobMWPPeskxG3UFeAElP+XqUXcwVIf4AlJTFlCX48xCrwTUFOie0fJdpxun5mqJoI49+TK/OCvbndzql8yWJUvlWwsSldhCP11PjcT9x69U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726674; c=relaxed/simple;
	bh=cikm2FC6auBIaOh1vJuCHO/icFMbB2u/ZGK8PRDbfM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEutL5rZFkwi1b7i7xYpgqRxqesDHuGfQRo+wAIpcnloBzSUmBsIZUTGmOWMIF8jLckBIiEq/lzUaonViGrKJiGFp5wkToK4FA+XsU/7pGp7lumma3yLR14kvx8YKZtAMraYGex7iebAa97ldOs0LK+0teEThHfsD21CYF6jyxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=BCsBhghY; arc=fail smtp.client-ip=52.101.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hruzfUrMXdT34GR+4XgGrQIgH+H1SKKcutLh+6uCp0QPPsq7byHqH+SGhmGjBRBWXCIBeDwklEKqLAmZCM/jyEZ1EeXEkjro4/djzkUxwqFE2+NZ1RivslpSJWAJKM+YzeQ4j6eOdJ2wEmNFHz75dLNhNzS3HuvDNu5yaruyyGBL28GLDy6vDYvaxvYtTSBhngZkpupQPEv9U84MZc8G948BeR/qXdVdhbBkNs+9HfRCgImi2GzJ8Bo+BUryx1ceqiHUQHwfe0bQ+aV2JUj18GPTP4F5dyiEpop7aof8PdcWCasZOtZQ28WJMXucUL0J6dK7k77hIjNXRfM5Pdt5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOLJimcPeCpdCfRBtB9HXjhtSG89GuCrW23kDWg2py8=;
 b=G4G6bX/aYIhr9j7wplMA9AReDHaUIp09re7uyAOnXnVucwE5ql+n8P8OyULtG0I+9JuiI/fon0Jv9QUG5s0jd/WBEK7eCLvNV97hpxYJVxtpuAmzThP2AYMfyAQQKwK5Jd4LzIhR92nSTPe4AKO7+LA1bW5GLGua9tt9cmYFXxzEj3fxuOmvwJUfotVyaQ1cL052Uli6c1FgzmpadlWKPm92b6qk3jraI5SFL7fFcyIIM0iOxA6FUe8FZCIb5jHrn7nxe3njWv1qUOe+p2OM5oKouzUqR21kCZV/1KQ1bGQ0ROAfwRdE+0YVUnB6thomRKrciCG0tkczUB/52863sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOLJimcPeCpdCfRBtB9HXjhtSG89GuCrW23kDWg2py8=;
 b=BCsBhghYbfGgxi7CUKFCWvmozB48DHbg1BEl5SPWExmGJEOlI77JxmLxGNc7OSJMgzPuybYuf5iP0rzHk69HKabduhyB5fIu6qi4bO64f3bC3wX5R/n0vM+pp2vychrgzNLq7eEpeF6r+HOJp0PgYZfX4qJDA0Ep/GbEPKNrVYyYbPT/C86t/MinSVbCMV8U8OKpRnPIk8Tt1XalPH8oTO99pyTEALq74DnVsxa8KL/nXO+ahCdgmp41b4GhzKJFDLfBlmLQHnLipNGOfTzb+LZoiA2PUYmesY2H/VJHvv3ZHtBvIASNqWZxgjECB/hQpzLqgzLLzRW+wfNbEHY4zA==
Received: from PS1PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::17) by TYZPR04MB6907.apcprd04.prod.outlook.com
 (2603:1096:400:340::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.12; Tue, 23 Jul
 2024 09:24:28 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::42) by PS1PR01CA0005.outlook.office365.com
 (2603:1096:300:75::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 09:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:24:28
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
Subject: [PATCH v11 19/27] ARM: dts: aspeed: yosemite4: support mux to cpld
Date: Tue, 23 Jul 2024 17:23:00 +0800
Message-Id: <20240723092310.3565410-20-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYZPR04MB6907:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 50cf2486-23b9-47e4-bcb1-08dcaaf9407b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H8oZS1i7sQTKnSA2hr8a59ZXjc+hnZ4Yj8OeOGdNaVmhk7nszKRQQgaunTmF?=
 =?us-ascii?Q?QcJsJmkSAhzn8OImRYg3XTsqZPv5keJoB7qv+B8YtwVM5qsIjK8aR7BgZ5mt?=
 =?us-ascii?Q?yflOSH3+AQdIdYMBVz9MUHS18JoQmirT+X3ETMcRQCwCdmZn3u34TrL038Ha?=
 =?us-ascii?Q?p5zjVU04kqXnPuupdu7Gr2FHqvi/5xMbrAKgLKiyTGFFNYOXMvJpXyUCCG+U?=
 =?us-ascii?Q?aest3MlG7EhxwfMkDWI4ukuLx/QAKXjvJD8fomxpAQOfzoEJ9C/IpLu3kpw4?=
 =?us-ascii?Q?2qunrLoxL5CVa2KL+MMxR2BockPfgDcYGDVCrBJNBVe4IMatUDcMlAIR1sKc?=
 =?us-ascii?Q?xAlaixyj//kYHP4X6LPE/FCQNBuAFJZAmczSYi+sUlPF+srm5v6VmYmWFDRc?=
 =?us-ascii?Q?F4Tup2sUvPu70I2/buPuMgQri/WzpE7MlDwKi0ZnOQdo5RY0FXLx8xlpsHdF?=
 =?us-ascii?Q?OWftDKbp1Rq1BNm3SNmv2c/XXsYCu15UbNhDq0FnuQ3qLuDDswjo+DqRlc8p?=
 =?us-ascii?Q?nfwEB950I15iu74tXBAWI21rG3fVqiTUdWgdfurmD2uGW5qz5mL9CvrCGjFj?=
 =?us-ascii?Q?V6sI+BNzNur1IFRhCmuG33zav9fFRfyW3bNPG5hSvzafviemgDyZ6jSQ9j0n?=
 =?us-ascii?Q?p9r1AM1ZNCquCjAAcWRy9eTfA0cwJgkAxLPqvCBpyjmXqnGzZ0SyJ+hgFshK?=
 =?us-ascii?Q?hP7cPYOx1vdzwQW9Yn0AeyPKM5RQB/GZkui6YTZiksk1RuMx06NTu2cvSw1m?=
 =?us-ascii?Q?5VE/09PJmg0ETvFLP7HDcX6iLIoWuneqtnDfA1GUwVz/51m9gQs0HmLbzLWK?=
 =?us-ascii?Q?ro5WsekKCQ9OiPflhBjhyxYxFEZTg6PdV++sZbEjuvm7wOM3dARV+AIowLkE?=
 =?us-ascii?Q?VTx/zN+KIJiedgpl31i2FZeUf+nvigbgjVubFyp+FiffF3soXx0NjHxHaryF?=
 =?us-ascii?Q?9HrETLIh4hgm+kbrlKNH1OT8y+EzCuQlxFTh1LhZ6HvqE49rL8QCEEBAVJ5K?=
 =?us-ascii?Q?oDhUa03YNJgl+1s2X+aUrz58KlsGNiD/sQZyBwHv4LU97ELbD3Gl39nHgTg4?=
 =?us-ascii?Q?iF/4H/VpR5dyz+sST3UPgrILkwAwx7qO/7fVBz+5rydIxw5p83IhBusq/o2o?=
 =?us-ascii?Q?tcr+b/trhpbc2Mns4zde1eA++L3ZDgF33qz5lJHwwInuDRop8x9XdTgsD9mZ?=
 =?us-ascii?Q?zfu0n9JMh29WnwP1NCm8U49gOFjnX6y6ugSX7SkpzIVZAghTBSp/INXso2iR?=
 =?us-ascii?Q?vQ+dX2dGWUHi1228BRZxajmvDT5MOFVoDOqY4fAnJ/utljAnvlUtWthhP/LQ?=
 =?us-ascii?Q?bSmoUg5HiIoJQjZjWBls76WHo8nG8CDudrISfaZW6EYA+W07Lyjf9Xwip5B+?=
 =?us-ascii?Q?/j9roOud5o0lkmI7zGOcPEIdONkw26xu2ANo15gOTbDPuhH7FZhUw02DPyb5?=
 =?us-ascii?Q?S+3ienqO5LnZ3m5dyZXzDqN/EUn2wsA6?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:24:28.3009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cf2486-23b9-47e4-bcb1-08dcaaf9407b
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6907

Mux pca9544 to cpld was added on EVT HW schematic design,
so add dts setting for devices behind mux pca9544 to cpld

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 64 ++++++++++++++-----
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 7b8a2384d99d..98eeee49b082 100644
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


