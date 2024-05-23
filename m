Return-Path: <linux-kernel+bounces-187252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50408CCF0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB06287253
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074514F12E;
	Thu, 23 May 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="T9HvxzIL"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2084.outbound.protection.outlook.com [40.107.215.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC414F107;
	Thu, 23 May 2024 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455962; cv=fail; b=pyskwcynKMO/w5ajyxnFIFvrOYTv5zoNw3C1AQviYHX72AUnBQxSF4r9byOdpkB1rrG6izrpTdC1OlQopF6n3l3qOLptGFs8SwOIhD2HVgdC0Jq0Bbc1J+QPgXwatceqG/JY+2Bz4gSvgbvqLTv13z6Mh/1nntMSeMPva7hwd9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455962; c=relaxed/simple;
	bh=fhg4U8+WiKeb0My6Uagt5utZDdeFL2VNOkO5q6j0/ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKPhQbchOx1vpfaTIH31w/TqQjaCMj47sUrnfkha+Im6SrFlC8ep3k70+RpHQDKr4brAtA0EoIhCSe/IjhtmedF8hwCTe4pViM8U/w+I2s+Koe5izFcQpcwHzzo3424xlCTGDnZv8j7ykegzUeyjPGBKzgCLgiuO1UPcgLXY6Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=T9HvxzIL; arc=fail smtp.client-ip=40.107.215.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asHnIn/+Tnowr4VWE4Y+X7xB5y6J23CzQWZ0EDYgokUfuRXOwUMefn9ECvDTGXSk1fCBHx2vc2IMeFvjcsPcs1nYQuDOsm1WvL09C5qs8uBUxhvqmKWXrQUBO/unUPgE/A0eDO3Df6GWOFs+CMQagWr6vYQoJbOKKCdCogfwylhQGASOhF3yBduhSfQO8hhbHmwepaTOXMJqhJOjC6+Ov2akW8zDxNokwh1Dsn4Ex8RksqQUvQNyy1sJxJdzhoqRca3CIVgFW3M4zMr+5xFiNlcT+bhf2stCsYQMbcUG2VOAC86Y5eeVwDRGi6T3J0xG54IJeRCW6iQFNf9hFlPOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES3SdMSGvrNhfRoLPeIA0V55NxyaiAY/qzb3Em1tHrY=;
 b=K7Z8Cw6jQCdZOasyZ7s1MWlxr9OONg/SpUgdPm2/NY8vC3Au8FPu2Q/GKPZSS9TLCNq5S7Gd5fz/0QGn8pQD4eJiMN2szZ7Y9XlciK7mHZFCLwk1oyR+8Wx/mytpE8rCJUZr6kgQtEv8beG7RmQb23cZDR5kBYqct6mbkmJRVxmqe+vDihPQ52nrOhlMwfxssmmPVvFSzFEkFdfQjsA0lvsF6CQ+RJRpaqjDEa9/HVxojcgoiXgH87GNgF7JMlJ3siivUyyheykSBGuyS07Fgp0xn2T8t5ljt5qHARURhrWsC3DFuE4rxh6jgwPy74sw408ll5bx2P/Cs5DlbtjraA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES3SdMSGvrNhfRoLPeIA0V55NxyaiAY/qzb3Em1tHrY=;
 b=T9HvxzILnO60TOhoOjKzrpuKY9JcuNuL/KiSCeZEFSXnuYDH7fXxWEZTMrHairXWn0Xnozn66G9KIW5k6bTn8oSfH24h1/OBUOrkwmPYaQPZXrV0sR9B6X0Hst8AZhdJCtSe6kdo37XLZVdjPvOt+eEHDmuyzUVEMVq0yge/K85lXg+4/GzpBo3LOdwpjr4QbFa7uiEJtH/ig2pE8jlPvDWrFH9iOJF4T5t7ab2r9vw7acW9BgabHc5Q1YqICWxxOcRg0pE7vCpdcSb/QHtiAjoW5IunBNJs5/zxs8AKN7rh9myqYybV6Ocn7iEqa60CME41IDKGx1EYOVu7SFhXSQ==
Received: from PS2PR03CA0005.apcprd03.prod.outlook.com (2603:1096:300:5b::17)
 by JH0PR04MB7201.apcprd04.prod.outlook.com (2603:1096:990:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 09:19:18 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::21) by PS2PR03CA0005.outlook.office365.com
 (2603:1096:300:5b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:19:16
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
Subject: [PATCH v8 19/23] ARM: dts: aspeed: yosemite4: support mux to cpld
Date: Thu, 23 May 2024 17:18:06 +0800
Message-Id: <20240523091812.2032933-20-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|JH0PR04MB7201:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b5ac4762-af8f-4917-fa06-08dc7b096ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DlhuqBSKJ/84TByyyROUCEEWbua3X+5UeARD77Syg5iduW0fJU3MwYoKCT+w?=
 =?us-ascii?Q?d18/AC3lTMvGjQeGlU5UhrozZ8PZnDxT16nfquBQGBbYLGKis8ObhPFFxqcX?=
 =?us-ascii?Q?zB9jMqhucHOOrVvWrR2V+RP1F+JC4qKEJhAFPuJI9EDpgehQOJTVi+8yqAMf?=
 =?us-ascii?Q?ZZaiBArtMxMNbCVAiD47grdol87bCEIHLXD+3inGm58dXcjXI/Xjx54VKqj3?=
 =?us-ascii?Q?bbnSK+XZw7KhL99+Akyh+HwKN3gozW359HumbLK9T3Tj5ioCJrIu8JXbqm6Z?=
 =?us-ascii?Q?5SB963k8D3U9WGv3e0xVV7PBsV7vdYeCBQyt1JtCveTJE7qJg+y4zI08lbuy?=
 =?us-ascii?Q?ud/ndmn9La7/sZ+7JypjU5+Svp3s9OXoM/MxKuvBuSsP4UM5sCE7qFhNgZFt?=
 =?us-ascii?Q?YFi7O/C24IWAd60NS6WCLtxgAUrj55WyKthOKUZn4uexj7gENefKlRHSDVWc?=
 =?us-ascii?Q?ZQaK0lXrJIjdhTCcKyZDnhS9NvBOLMGwTx3dAs6Oipd+9axDq20umkz+eh7f?=
 =?us-ascii?Q?YC3XtIWHIDU50WttHefxjuAThawzc8GoNQRjYBVVwNYWL8nbGpmVlsqddCNb?=
 =?us-ascii?Q?p2nCb6qAKrklqdYMe+EleMkJzhgU8ud71LzSomBNgD49KcuMGby8YPyKXPJd?=
 =?us-ascii?Q?5Vw3kI+yUySP4f2s2tY8wDBfYTTzT538Bnv2MiLhUiQW+r6m/T4QJxP8TmL6?=
 =?us-ascii?Q?glqU05GbkTieMZm79jeFvLbixOFUR+0fqSZtNEnSCiOMzXdVE48hvgI0weKg?=
 =?us-ascii?Q?hV5JrGjTuVi03lA3hHadCQpQRb5/E5SWeDNur7xcK5AKWhbLuKf8kx8vlR2B?=
 =?us-ascii?Q?B0cOGyBvMPP/whu7TW3FUi4qnFMLKtHfvz1Oh7VAcXlaudGKIxR6CW5YPc56?=
 =?us-ascii?Q?gjjx+GcbOd+XiK6iMA/7il11v1Pwlv+ykHrl5RXh8UHiic6pAG9s1yRnhdwm?=
 =?us-ascii?Q?1tYrzFzuJESqJ9E0frniZOO4QHVmnerxAZgigILRTCqhLNT+Wr938BG84Q1E?=
 =?us-ascii?Q?8B7y3GuYlCazAb7oyDqreB9vE0wesKK9R+YpNpQeTZljtCpLXw2j+g+sYJ+7?=
 =?us-ascii?Q?eFp2itkk9RxAExwJnUhn+1lKMvRCo7N2E+7EXBqMjFTkdKJZGBudiviY8XWs?=
 =?us-ascii?Q?xdGxpDLbzw8HkgeKvZVJDFiTN3NUVs/Ib9zY5Zn6BJTYBk2N8WCd8SEAthx2?=
 =?us-ascii?Q?gYcpRlr+3VNpbMFDmH6hpY2kpM1wEmNW+voktuc31puaCVvye5i3O8//JLjz?=
 =?us-ascii?Q?oXB2G46r/K94cSvoH2o9CcgPfT3D5dp6QFce1pIYaHlMOw6L6g0SwxyypxfC?=
 =?us-ascii?Q?U25Aah/AHpoBD5wixUwDEsQ4gqtaJ4HD929f9P+xrOAk7jZka6NGI+zjiMcj?=
 =?us-ascii?Q?3ZIcPlEpSQpvLY8XndnSkkWafLyL?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:19:16.8607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ac4762-af8f-4917-fa06-08dc7b096ba6
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7201

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


