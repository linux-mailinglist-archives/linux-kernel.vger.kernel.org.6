Return-Path: <linux-kernel+bounces-300813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E8995E8C1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5F2281A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D317144D1F;
	Mon, 26 Aug 2024 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="cAB/BxSW"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2082.outbound.protection.outlook.com [40.107.215.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AF12DD88;
	Mon, 26 Aug 2024 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653583; cv=fail; b=pdJa2oP4OV+ReY+9DTmRC5Wk1gF9MYeAtLrZXci7PnexrxG0iKaRZ5ltSW51sbAPYiORAGU2lnMCY2to4ArDbMgR+bFaC+6Q5bCNggMx6WnokyD5bxMIK/zAh2x+wHJdxcbQGE2zVB3zOGgU5wkJxhgPxk99TNQvB5vVNosaxqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653583; c=relaxed/simple;
	bh=cikm2FC6auBIaOh1vJuCHO/icFMbB2u/ZGK8PRDbfM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBdLJxlc0VktU5tTN2B162zTfmH1LMVKgG2RoZW2egLMJhCEW8IngLx+zv7TVEg45V32wW5/XuEj4cbtoYhthGCFveje8D3mQj/PejuveM3lzfJ5fzeLvfUlfMtmyBSXup7ULIjkefz/sT9gZfuu0cMjEO/4b1YYBMpWEt283ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=cAB/BxSW; arc=fail smtp.client-ip=40.107.215.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAL4w9Uz+r3kw9CYM4lIbJ/BSr952w0bBcNk5pFSM+waaIzlVg3RYR4sYKeEIQGsObroZ+b2l0oY4FxphBRa78auqBplaAvGZvBgPsd3Gfqxr3izSKoKJeWiZp1vcPAAsli6Myxd/XDTOkCMAz1urCT3J4Ml23I2CjdfA8yyWh3Z/J+3RwqJf6GZhhW7tjlrjoPjAP6cwToMvcK4q1bP+QsdJhAy7072blkFL0l1x1rdpxRCd4FrerG6VjPBLMciHEqnDw+5sZvJYkOOMyMjc8QRwx8hZTVOsPtD/oI8dxp745a7ThPxuiHXONlBLzsQpNEHYYTNlGLbHHbfh9dJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOLJimcPeCpdCfRBtB9HXjhtSG89GuCrW23kDWg2py8=;
 b=p53KA130y+/mwTalMfdN8Uh+WtEG9lJIjwa9Cai2odwye3UVnE2DbhPI24nttiIPnefC7dvLKUPC9hqKJwaw5UPyGvh0H2ndnPLKEdkvCxiKunqhbwNAB0gTw+SVzvMWhXcqOVd8WLfCmkQf+GOgDvW981hL171OD9Z0L6azmdbx7g57jBrVX4Ne+pWG0nn2p7SveJXW0Xf/jRYcODZErS6OJxQn5SWJJLNsMH7FVWUaxoG5mhN8K8qUQwWrH+L49m0zHA7TRi/lSmxhAEOgYldZCRvp0oyu/GxU0MlfIhOLInY3LG1mUG0uu9RAh82gIfzvAiJ5i5Ag6xjNpLCneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOLJimcPeCpdCfRBtB9HXjhtSG89GuCrW23kDWg2py8=;
 b=cAB/BxSWU2IIAS7m35Z/Q3et7+mqULXZS7VqxqD7DfgJ1tZtzay2CLTNZTbuN0DWOReTAQFUa4B5dfkkGC0d1Qgr2takrASw29OzpKJgSn6jMDfQ1U/bjVZTFcUFOcZf2OaMwQf8yhE5sGgclnrtHJRp720eFNbnWz10HeKBVGB/xlFh64BKzySLGH9VFtVMUCmNo6w9oS3OJ7ZPDIEhR6oGUhSx4gQCwhcMWUqo9dndQtw6cw+m4Hyjl7bdQdTwXRKAb6edMc1WTO4qm4FS0jZoEhYPL39sxrjBqiohPirUOIRUttceByOSVBkcLnST9jWvgahMHqroQrHxFUBJ1g==
Received: from PS1PR03CA0001.apcprd03.prod.outlook.com (2603:1096:803:3d::13)
 by TYZPR04MB6765.apcprd04.prod.outlook.com (2603:1096:400:343::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Mon, 26 Aug
 2024 06:25:42 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::c8) by PS1PR03CA0001.outlook.office365.com
 (2603:1096:803:3d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:25:41
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
Subject: [PATCH v14 19/31] ARM: dts: aspeed: yosemite4: support mux to cpld
Date: Mon, 26 Aug 2024 14:23:53 +0800
Message-Id: <20240826062408.2885174-20-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYZPR04MB6765:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: db1eedb1-1159-43f1-eed4-08dcc597e898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VGI2avNrJ9gdIIH5GhlhSF+jJm+MBLAf+Tc6QdB44mCUOx15jybthuCD94Dc?=
 =?us-ascii?Q?7BvBTY3VH1tVt8JtcO/6lcUH9k9UBmDZCo/d0j9HjtHya3XB9CxHJSE6qTVG?=
 =?us-ascii?Q?QBWk0+nwWwQiRwfd2NB2UdGHdb5XS4RuX/B/IH/2EnF8MMwRNzFmfexQgmkN?=
 =?us-ascii?Q?r3IcOadkzo4iFI3CSexZQd0JiHb+PfrVYWJVRnQ/baHvNLAaCuENpllVavvj?=
 =?us-ascii?Q?WKU+yjGC/wVwtimiNo6Y6ms0jwGRYi6yXnS8eYNMtyZ9r23ot+8HQlARr/iU?=
 =?us-ascii?Q?VqDXRup8eP7OIvy4JoSCP+0OvCDijveSx2i7m71Q4mDxFqkYlwXXhOPM/SZ4?=
 =?us-ascii?Q?21ArMpXr/c6nteTxevRtcWPFeUhmvfZ8wi0RqYH1uAPxmriCZZ4bqE8cQo99?=
 =?us-ascii?Q?dIfRSya/x7QyzbekPbvRzY02Tid6Q0b4OWX4TnLDZVOQW3axyHQBsD/uXEi0?=
 =?us-ascii?Q?TBdHyJNhw5qDLirHI+KdoXNchJFaElhuFB1EA43IRqzgfTUDeUI63Wr5so/M?=
 =?us-ascii?Q?cCuZiPeI93etnz5Rp8G1IJUYk8NDtXi85XspktomuZpCd2pcfWlox9r3G6Cg?=
 =?us-ascii?Q?hy92eX/owZH9VHqPb6dwchPV6xQ302iTKHaRqGEqqKUi+eQRdAue+LavOoXE?=
 =?us-ascii?Q?AkAxdFdSboVvbs+Re+NtCjAsKac8hdnWv+jIyj6CVlov2oS5fVilzaRfXFxO?=
 =?us-ascii?Q?EGjo40dzJiHNH9vl+1FKpWvYkl+58qIBpPPEophqmWwHo9Yo0yShAsLiKUIL?=
 =?us-ascii?Q?/R/vxX1cMryHQNedggLKmaFYItbweoylO/JztMY+QISIUPDw3EGw6dgWAyz+?=
 =?us-ascii?Q?1+YL9b+BFqiGjMAeJw1Vb4883UdFYxy31d/bB3IVcfjXfnd10uZhVh9o0afw?=
 =?us-ascii?Q?ojt2Y8Bf82pWrjjbICHIlG35/GxVGtjB7GDdkTgelFz+sH12lfihCc7/4tZG?=
 =?us-ascii?Q?RS15680zICsc8Njfv1srKtEZ/03l6sscNutyo1qy73DGIA/kzDr8QbysUSV2?=
 =?us-ascii?Q?1g6nk35IXuT1GxZsYmvybm8z/f9zkSqk4iD5OU2+uJH0eBcCmnOQitJUJFHp?=
 =?us-ascii?Q?NTRLWZBqkjOLMJsvxAdHYEBqktWcaQNCGJVfA+stDf2K01QZyAMdyLJX8sjw?=
 =?us-ascii?Q?Q82JFwgdHDIkNadcJiaF+NhPeLqgnkHgBLMIMZftUq1TIppmgjRtlDMEL8Rg?=
 =?us-ascii?Q?z2zsBE1KPDhjp0/nkqQGnU5tIdj6psn6pTDYBstBXws6bKA0EVoZZef10UoI?=
 =?us-ascii?Q?WFEwk0McKcmT3B1VLK38DVvbD0ldOyYVnGW7nODwHikSue6s7KUwmTNOvgfE?=
 =?us-ascii?Q?H8LYUa1DMV0s57Qb0CWvlKmDD6OmTym811NexLvblKdzgfHgQATnjad/KbZu?=
 =?us-ascii?Q?kTpvJqpCNUeWi271U4e2H1dov3Xxco1tlnpI92UUSJjLDs3DsT6KHQmpMl/c?=
 =?us-ascii?Q?JM5OyJY1UClwFR25WL4Sj4V04uf58x1j?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:25:41.0650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db1eedb1-1159-43f1-eed4-08dcc597e898
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6765

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


