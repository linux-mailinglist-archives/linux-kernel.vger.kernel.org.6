Return-Path: <linux-kernel+bounces-322437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6B3972902
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205EE1C23D27
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0201D16DC12;
	Tue, 10 Sep 2024 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="fnXLu0z6"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502C13A885;
	Tue, 10 Sep 2024 05:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947297; cv=fail; b=WcVKbhQMoAu1oY/cDaTJRCS+msZPEHoqsKAwd1mqWAxphxoGDyZjyborhGGg1Xu1FKLd3Qc/s6kBCrtsQJ0Emj67tb4we05oeCvq4QiEd3rfGVSKtxS4VMvRSkIBPu2FrnXSeKEg9ze8p5pSQxSNr/Kaz1O7mmcC5IQeQrkKSII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947297; c=relaxed/simple;
	bh=ErcfR6uW1SC1xBiobocwrRlj52V1ha0eQm4vg8l5CCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rE9evW6dXn4w78htMxP87mSQpO8O9FNkt77rIXl777MWbx3d4cNmiRXZJJ/6NJT8qaDjZbtfAEJcuaypTN+AfDw2sQqaKSXcuW4AOFWKovSVNCLuCl7KEKzrArszstJAPgaynTPjGBXNsHGIUxICHKzD9q3yO/9tm36B1mQUqmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=fnXLu0z6; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbZH/D3a5YPanJ+YkS9fx2eMzh3sLrW1PvOH1XhlKZVLifiEiKH7xniFZnbQJAnEcl+ZVFpjPV+lPjm5AwBChodb2yHKGzjIByWCORsVWU1A8uJohiET74V501PodOBYWu85fQiS+EHRZ1waW1GXgOWeHk07PlAZPebVuid3F1rR1kq5O+pIIT1cbhV9ezfkR97xs0GllOQQP5GjT/LexcEZeJ3Xa7CSSWSSluvrUJg9GRWmiIXh5+c3xRy3HQCCu/vPXYQMK+OjXaz3hQsfPBebDU0ZWRSOrsBVAV57IPqw0mfU27XkSmSr2eU6ExxZb/aPh+qCwB83iTiFvGOiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HrVp9W8YT6MfcwWnQbdTmqpnzwBWn+1py39xGucwtg=;
 b=T89RSUhJAgudbBq77b68bLxpw2jU9kbZNXnTtqI3yCtHvtl2TUqjJ+pwABdWpyEQNQMfaM84JsZ3EkpVN0VRwRh7GxUXW9SL2k3wD7YFmSqXkweCdEILKqteiaEOVA5B8BWWZkOxG64rBmqLjQFbTnTsBvFcbWUtKdSbAC1BG/F1ks52w3hDdqhiwYzaauM/7owvtc8lf1CxV7hfctaljz4QZgwGtz7+5e4t0XhhQZjQJIxiHmGD33NHwdq0L/qqbhEbieT6Sgfp48t1Wv0fuEVVstZaeb2e/APOY4u421mGciQM5JsYrt7WtZmkMf62u26C6Q6s/YbDo+64Nw/ibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HrVp9W8YT6MfcwWnQbdTmqpnzwBWn+1py39xGucwtg=;
 b=fnXLu0z6VX9Qc5nnicS9ycc2VsG1GCn01u02tqIPm65Z/kGwn56jIhCGCIwNEXlbKrmZdzW15PzIqiGpeVLO01qcIeh5kkgkmSpQjhODHHHvnVL9OwjhmkcI6vEnaIfWypZ3TL5zTnaX++TEpI1JzD8in/cjim5QQiR6vrJHCpUzdTeh4FIcPe6FbMZDslPiDK2sVpWnf/ZL9j3Z4Wy8PCCYwekMrYesktPSobmWQ43FFcEKpAqRc9owCaY2Jb6r2ftkHb2c6wCTOK/d9FH9J2q+zZARF/fEolhI9fRR/qr9H2s06RaOQH4geu2zgqM8tttC8ecWBHHqC8U4ti+R4Q==
Received: from SG2PR02CA0135.apcprd02.prod.outlook.com (2603:1096:4:188::23)
 by SEZPR04MB7572.apcprd04.prod.outlook.com (2603:1096:101:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 05:48:03 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::64) by SG2PR02CA0135.outlook.office365.com
 (2603:1096:4:188::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 05:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024
 05:48:02 +0000
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
Subject: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506 for CPLD IOE
Date: Tue, 10 Sep 2024 13:47:51 +0800
Message-Id: <20240910054751.2943217-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEZPR04MB7572:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 55695325-4d13-40cb-ca14-08dcd15c22b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZJHM067KI1NI3hJBCATOgRVp3yqMXQ57Q1FxPcLfUUGhmeunKVsCjLNxEjUX?=
 =?us-ascii?Q?ybf0huvlEL4T65nnbORuC0sRxa7sf2121cmNziaNBzd42j1yJXEwAHibBc4J?=
 =?us-ascii?Q?Gp5YwC7eSL/TBA4Q8qgnl8OPfcnifNMXcOcBVV+rO34P51mZ7hjuNNaBIx2b?=
 =?us-ascii?Q?F6UFn3eFqGZRB1SuCQb6kzGCjT6xTg/Z6G2FG5DP/HkHqdGD5TTpNu8tITsU?=
 =?us-ascii?Q?5HLzvVHmPTMSvj1I6miCcFn0p7LHpFC8t8cQ8x0H14xUF8eCNue/NA0kZ5rE?=
 =?us-ascii?Q?TzXEhGBEVIiO+SOpZ5v6ROrXKQX1PqueUHpff1isrOswqTcrvHrcUd+cd3oB?=
 =?us-ascii?Q?Q2SQ6cBr0UzIbQSRCjXT9g0XgQSufJ5GbTCd5m1izd/rWxco9LlBLQc+XoPw?=
 =?us-ascii?Q?OxsAglS/xgYYwzXuUhwT/PPVBSPTAXgXEEZN4G3vbHkYvsjuwu8NMW9Ka8pc?=
 =?us-ascii?Q?3CSqpq7E18tMbrELmYYnLtbobXndR1PlRTn59EfZ41TVo4xkedt0MRIFYz62?=
 =?us-ascii?Q?lXR/VZWbxfFmh563iUTWUzntqzyV9Z3nf+WBHhv0rd6Q8rvgWlTltijgk3Vz?=
 =?us-ascii?Q?ewqtW59Z2D2UU1Zo93BfF9LR1b8gjcMy0Rp39Z9orjkEn+ec8w+Q+/TRJ9MC?=
 =?us-ascii?Q?QwgnTYKDaxr/7rC0BCxWH77TcIhO+tOwCkhsZHu0u90sK4ZQzSwfAi63PfDn?=
 =?us-ascii?Q?hmZNckQdlSxB9j9KoVWyNBuf8oORzCq3yK91e+nm2cmAAy99J/RjNaHZ4FX8?=
 =?us-ascii?Q?FoXf5Nb0dlwb6ANPmGUD0fdxd6ZNCX9TZbgna5KgqLbd3t/6VK3nDJszbiFX?=
 =?us-ascii?Q?rWC4ErDeUQLxBD6ShoaH52uRyImNiJ/qWJ0hQQoot8UBo5+Q5XJyHIs0y7rd?=
 =?us-ascii?Q?CX1hmfdKBvwFFfM0v3jWM6qw2efu9mG1zM5YFuHc7KGEZBVCg7TIiI5ksv+S?=
 =?us-ascii?Q?CYTBwFj0X2Y37LTFrdn/bNdht6Kp5hgnqfHshI3jXHYTv8kmnsXm6O5x6+8Z?=
 =?us-ascii?Q?h5katBUL9UN4P2X++XiviVXFuABxup/qdSm3odyPfPLpVKqIvZ+2p4trvkiq?=
 =?us-ascii?Q?2O4WYAqlR7Yt3MQX0eUqRLQEQi/KFVS6kuD8sNc8RddwmIU4btfbQ+iZYs0A?=
 =?us-ascii?Q?naea8cJ2+IuKHuje9UqWwpR56Q6Vw8OV8zNg8WdI74UTMhgchicEP8MyZmaI?=
 =?us-ascii?Q?kMUndPwPza8NQjPgMWEvCPmQJSC1LRDPdmIfzNMP2n28tcIxYJ5J2DOoFT78?=
 =?us-ascii?Q?viaJVAoAuzTdONA/Y+gv0DXUpez2hbN8hNicwGbSysTqtRyEs9fif6PTbt6b?=
 =?us-ascii?Q?dXX/k6UmmhQLnywgKgsHAlzZzZ67reFCrnVIinBy+fWHe1MVlOBm0xQRHpzS?=
 =?us-ascii?Q?nluNB5JiMg+0x5q3Wg9bpW10QHL/wxRGaHbzGT+Z7qzr/7mUDbCfjuz1PkrM?=
 =?us-ascii?Q?tbXv93FdO+LqXScO35fImM+b1+If2myL?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 05:48:02.2090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55695325-4d13-40cb-ca14-08dcd15c22b7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7572

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

We use CPLD to emulate gpio pca9506 I/O expander on each server
boards.
Therefore, add pca9506 to probe driver for the CPLD I/O expander.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 252 ++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 08d32e42286e..9d2efb5f2f67 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -129,6 +129,34 @@ mctp@10 {
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
@@ -147,6 +175,34 @@ mctp@10 {
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
@@ -165,6 +221,34 @@ mctp@10 {
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
@@ -183,6 +267,34 @@ mctp@10 {
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
@@ -201,6 +313,34 @@ mctp@10 {
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
@@ -219,6 +359,34 @@ mctp@10 {
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
@@ -237,6 +405,34 @@ mctp@10 {
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
@@ -255,6 +451,34 @@ mctp@10 {
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
@@ -385,6 +609,34 @@ ipmb@10 {
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


