Return-Path: <linux-kernel+bounces-300799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BB595E895
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9C01C21028
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826F8405D;
	Mon, 26 Aug 2024 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="MJ2GK2bZ"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010049.outbound.protection.outlook.com [52.101.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259283CC8;
	Mon, 26 Aug 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653497; cv=fail; b=A9aao9xW/kRNlKAo0krbZH9TGzctdkk9AqkofMPGR38rPtSKt73HPs1VwhKmTjDfGcMvArKsEZRieNRigNYBuf17wPmrKtMjWE+NGbKfTBCdPGCnzkLeFsE944CaZ7rb9YDHCINnsZHeLZgkxI1vPuxzFg+yS8/inAyLscm9xs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653497; c=relaxed/simple;
	bh=TKm+OI9fWbBrT5J+HkZQsH17XDtM7uMYc+S4dkcBFSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qU4xUvvf/YoYTGwKAQI+41Jhi4eawobDU49QTv8dRupQwh7vzmqSgK0wXDqcz1uhzf/106ZW1fqDaGiMaL8b6vHjccVS49PjqVEPVD+ZQ+ylrAnnI2eW3DVrSjNl5yL1iI8IFxGrqNJaLCHipNuGCgwevhvX1jiqFzrI8TjDxN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=MJ2GK2bZ; arc=fail smtp.client-ip=52.101.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tI9aUT7M7/I+S03W0oKd77UM4rpbspkmrrZ1EEVPhXDVUdUY76UU2bZh8piaijj1c6grQCB3irCuIOnlaB0aE4UTptuHHW9n9aG2rpUDLKSUGiAhj+FcGjp22vEseoVmwfYYsyEbgiKM625xXVXWsjfV4Vw4vvv7aOGMzNGBz0v3WBg9f8JtNU4+YBZjZS6oljcCPscPFZ/BLYNd6n9GRc+ZGzk+vHKIwxPwzvX4ZLbxssteIMAJIyrndGKGmEyJcE6sLw/JWVX7FL2bAIOdatX22h4UGhiDlrPomUvkkpD/tAhKHxMGFdKEzE0ZTkyrXI5BRHAJb3Wp23uYL3eG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIYwTFLr7k3/66Qq65omckRUKm3v7IIjsRhJzbIKUfk=;
 b=XwklJSKx57UrPIV6/pcuyzm50wbCuFsiuqX2qZH/W6dJh5bGk5+ZF4lhIGHBEmpRF18aru75n9Ko9c+KMtDAAEcOID48wYhuEJHDmea9XyDAw3uN5v4nVM8pbeoaIXY6UjxUvatbfygFU6Z2+2eddH2ull5igcS3epueJQgwG0O88nX7KUH+JVUsg502odZN2nPdR/q6aXsTexYK1HjagpKmJi2if6UopWbx7a95EB2OS2uL1NUOKFRb6FYY+juLV9mfIwFuaLAZCwVpr0jNe3DAyan7A59NNgG+ifXd0PprLKY9/OiQOHc9q5HGqJRpzF18jqD8h15qE87Rf3tbVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIYwTFLr7k3/66Qq65omckRUKm3v7IIjsRhJzbIKUfk=;
 b=MJ2GK2bZiycNx+heIOjLBY9MTaKiabC90IA2tK6fDhR5L3T3+s2OqIzbgSWf/NnjdkXY3lByJpiCeocSPwFlLsI88B8jR4tS42R1Zi4TJ/lU5S87NKCi3/P71uBE0XJVg0oVmey7uLV3+GIv80KlBG+Kk2qsUygDO4tgn1VmZ75vSgJFExum0x+SrgXEo517T53TPHO+x2idkXYAIFnuE9vJ2dnz4nF97R05Xvluw4Hh6R9WYHQejVZr16WC9kfFL6gR4o1sRQlqz9ZZ+gSBvqGraZZqYlBYIpTRXl2KAgaNvoeNsyCnXu4LMa5BNVRYdTtZy0vsTTnQFpQj93tUJQ==
Received: from PUZP153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::20)
 by SEZPR04MB6876.apcprd04.prod.outlook.com (2603:1096:101:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 26 Aug
 2024 06:24:47 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::fe) by PUZP153CA0012.outlook.office365.com
 (2603:1096:301:c2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:24:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:24:47
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
Subject: [PATCH v14 07/31] ARM: dts: aspeed: yosemite4: Add gpio pca9506
Date: Mon, 26 Aug 2024 14:23:41 +0800
Message-Id: <20240826062408.2885174-8-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|SEZPR04MB6876:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6a38f719-a67f-46f7-53b7-08dcc597c87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T9knfn4l+HoRKd0HiH2cEOY5WcIxp2+0LqwubOdgeZMMowr1v/nzo5iEVcXn?=
 =?us-ascii?Q?hXYRP9JCbazCw2/LAYJRNGuI0hGUvd40ZMgMMPN9qtNBun6ELNyhdvW3wqkU?=
 =?us-ascii?Q?Y5K5/YbTfW7lu+YT4WxLd98UD3NE49DsAnSSZ9MVhQZDXNlr2LMfoEz0A+kM?=
 =?us-ascii?Q?ptTUxk34glFcRleYJ2tfrozzBYB7uSzlK+Yta6XO9deVodp9JeP+S+4yTHZD?=
 =?us-ascii?Q?yet0TK0U0gkCfRimLFmFdRTkJfrjQCyAL5BFLJks8V3nX+CBmdKklkrtCQh3?=
 =?us-ascii?Q?b4ap4oMaBQw5tLOsmfDRSoCch3eKPs60N9tERt4cjjOfe92eM1p9n8VnCYrS?=
 =?us-ascii?Q?zHiHC5oZ6c4F85bOBOfcghmMypt2uo0ou+TS2pmXHu/6nBhq8fI9COHVDlZo?=
 =?us-ascii?Q?YUsdGrN5LksloQWCs8iMCtoeuRnAi88dMQQijLa/jWSbAwvv/r5Q/xrugBlY?=
 =?us-ascii?Q?iyFY2DVI1JF/irtakTvuuadDPiDHHxsJkKBVyf2hCpM6X5K+YwxYeXZSfeCP?=
 =?us-ascii?Q?bR/OC4SKREaYRc2X4K1Oa7CgEUMb3Oum5VskwnG5H1aFRzsUFLaXPZ1+cdl4?=
 =?us-ascii?Q?l3Cptusyd+YUXub6CxtVsTcYPOm4jwKu0v8+d39SREooHEtjLfvb/W+60TMY?=
 =?us-ascii?Q?mCaLpx76/5Hd9SAOjs+qoGSF+aouYj8vMIUfYgLSfZPPxh7/7ROk8oN76Ml4?=
 =?us-ascii?Q?VlS8oevXqSrTWKHPmeB6W0rstDd3oBhRIcVcKmSykg2b3HFShbcStUbSLTff?=
 =?us-ascii?Q?VOaMhERoJBi31HZ8sOldbVteSdsh/wS038NQVptuQc2vEAT412iMrhA4OucK?=
 =?us-ascii?Q?s3UntNA5zEe+L47vX2nLkSEFSPvjDtd2dYjN7pKp15QB0bUfpMz4bN1kiNHx?=
 =?us-ascii?Q?G/2J4bAg7aE8PEnUsSW6ghzzjue18fIOwcj/Hz3RfU3D30JGMVTCCiJMfSXM?=
 =?us-ascii?Q?jewa0atsS+B59JtDNKNGIGyPvA49VOJgufjVmmc5YpNUw8Q2tUk7x61y6BRm?=
 =?us-ascii?Q?YaH7Cz56Go8jhWvq/BAha0NLy0cdVIEpCphPiqH1Csfc44jqre7encqYNsQa?=
 =?us-ascii?Q?Re7Wwd4K+A+tvQwtXRePpIKp5OxoaeiFMn3N0052pTrbJ+j8eCxkNyddVqrx?=
 =?us-ascii?Q?s8MQoiJySV/F0a8PtHiF8tFuhGAnLksPNF0uOCVZWUbn/MQ5TFUWQoi3iI+L?=
 =?us-ascii?Q?4BUJhLSUIWN+OluJ7iwDZ1j4EvXzff/4zbHqtfqn8F8P9xN3Kw5KQkE3FebZ?=
 =?us-ascii?Q?3XiLrbjoxtVRSHIOq3EezffKWzI1N4XPdk/8GKqTV23CBFhkPhC5tMmsKoru?=
 =?us-ascii?Q?npVZ1SLuZ/pZt5NwEJwjFOUnkFn8oDVe5CU1h5Y3fxjRQTPD37xjQ3+ANB5J?=
 =?us-ascii?Q?GLv2536jvmCAQJaVBvwwHzVJa8yBgC16v55mk72AHbeW+Yh+Wpk0jTKMeLbo?=
 =?us-ascii?Q?aRh6qKIIPFkN9V6WeOUQUTSAXFS1yC66?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:24:47.1748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a38f719-a67f-46f7-53b7-08dcc597c87c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6876

Add gpio pca9506 I/O expander for yv4 use

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 252 ++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 7b79fcd77c8c..f4d27f1ffdb8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -175,6 +175,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -193,6 +221,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -211,6 +267,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -229,6 +313,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -247,6 +359,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -265,6 +405,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -283,6 +451,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -301,6 +497,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -690,6 +914,34 @@ ipmb@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 		i2c-protocol;
 	};
+
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &i2c14 {
-- 
2.25.1


