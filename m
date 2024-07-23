Return-Path: <linux-kernel+bounces-259812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B56939D96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F39284684
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4D814F9EB;
	Tue, 23 Jul 2024 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="nrs/d/Um"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010040.outbound.protection.outlook.com [52.101.128.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ADE14D6EE;
	Tue, 23 Jul 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726634; cv=fail; b=Oqh2f7WDlC5WKrzdVOZOMqdqT7R8mwx2gPITu1kgertwFzM0uVOiGy6izyedPe5JokvQZSzxa/I8HSEfqm67oT2+q2XX8bb8AUQarEE+xtNA9EnBQpU+wwGx5ZJpM6aW9H1LGa0g8cnc+0sdCJuzrdszQjT2KizFEETv2SMxBY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726634; c=relaxed/simple;
	bh=TKm+OI9fWbBrT5J+HkZQsH17XDtM7uMYc+S4dkcBFSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFFEbePSIWETGp/3mENgj9qmmyPRvvfLOkko/p2GiCpwTxhulKrwQhYEJsVbCkSMzx4k302KrM1sAw1yGMm/f4hH7G7Dwj0woSiEQmRO6fprIg1lQVan3g5/oK2JsKjrcbIMeV96eFJY1AvbyzmvVmqjANRJ1i9WHizGJZpJs4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=nrs/d/Um; arc=fail smtp.client-ip=52.101.128.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYNfkfzsiU1pUQ8JCwgEEWDdfbILCb54s5lqtYAGTd/LIpVGNPsPGoP3nGO7Bsfzu+2E74s2NQI8FVo/iLlBSxOwlr7raIXfhXj6NNwHFQtSAijgxAX6ucXHMCp3n+uyYVXQeITs8OOWePcL07Y8aGB7mX1iasAWcof2d8rN5l2UP8hJ6wJCvKScGM7c7JNauV68gGHUT3HIw5fusEHxY95txyCd46tdn8y5i9nbAquxfj+b3mwe4dou1c8LfQ6P8Eq4xUtBEjoWFJoEJeyvSaBrOzDyteUZoKqrhkzZ46WFxgA+BdT39NXQlMYZTZiaMkUV3CNdndaqrX6d4T3byg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIYwTFLr7k3/66Qq65omckRUKm3v7IIjsRhJzbIKUfk=;
 b=OaTaZVnUY77Gn7nluJgdkVuEJNbKHqx+4MTYqba8vYWPNTxuUTdtAl88iN6yc2dZ3IM8jV8pLXsDM8lRmuRnN/Wsv6IZ+s9boeClzFzHyShODs2VB42hext+vikd9pkSd+XTwQqVIOMPWDKd5tTLJVTQe5kv6g+e8GUrMA5ec2QCytCAEqMfZpxxY26QUsfjnv4o9bZfCUBrjYS8mZMn0/rfyt4azc4FMEVH6p+dslRGn1W2wE1Q6525SXvChMphnB4ohDjZ9AVkM95Op0qFVVmx8Ev4/CXzB3zoQ+wyFp4nC2rXfYrK5Km1xNJH66jxY9Giwtg9LbiD+Y7zwK36bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIYwTFLr7k3/66Qq65omckRUKm3v7IIjsRhJzbIKUfk=;
 b=nrs/d/UmEnvSnjaVaziHfoZ1iSbEfyexSw+crgnzs/jtvYOggxvBBBwupY9sONEg0Q2rmULhIot73/Wk8FR9rHlZdsdcn2mi5Zf4W3eC2fxBAAP3XOMfxsS8BM0qqt+L9JkAEQqYcM0CLeh4JBv8v7US8SkfJBCzn1hTazzfX8wVUGhSOP7uHo1UZ/pVQEjkVplimBNStQ6A52VO1u+4af5yHSUuOagmuNePaO+oW9VvTgbU0xopw3wvOTB6PJ3fandnv4BQAqUv58J9gyAqZajsmmDY+N2rEubm0BVmxT9HI9ZUaszdQxXvqRxHYNgNbHhKgEmVC3yfMhVAi/iRpA==
Received: from PS1PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::22) by SEZPR04MB6455.apcprd04.prod.outlook.com
 (2603:1096:101:9f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.7; Tue, 23 Jul
 2024 09:23:44 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::75) by PS1PR01CA0010.outlook.office365.com
 (2603:1096:300:75::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 09:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:23:43
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
Subject: [PATCH v11 07/27] ARM: dts: aspeed: yosemite4: Add gpio pca9506
Date: Tue, 23 Jul 2024 17:22:48 +0800
Message-Id: <20240723092310.3565410-8-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEZPR04MB6455:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4e8dcd1e-7e6b-4ca1-718d-08dcaaf925c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ziSWkS2295iuakEUjW5oga3OY9TUbE9NfX3YB/SMCygcqm/+6TikqWfv4/6l?=
 =?us-ascii?Q?HOMIEHgZzGqap4Zu8QYDT+B8TPXWikoktZRFeCNbhQ/37Etdy9ju/WYjy7TV?=
 =?us-ascii?Q?6hh0eWlizGt/NNDLbyejWUsWOhnlRp0foWAZ69igHPyDKeKgaGIbqfjaIg7W?=
 =?us-ascii?Q?F84pO6yhxGlssWdG/LkymJb6m7NMeORu4J2Sww979Numi52khCSZL4Stmgdn?=
 =?us-ascii?Q?ijiiSQf9/kzwqGA/dN7fT8UCE71cG99wLUS0l3dFk/6UnhSJ0ogNJ4+kySOm?=
 =?us-ascii?Q?QU07KKFE/cIvhWXepbpmD1DkKCId0zGmVeCmwscGsvUK7i7SCkHIZHWmKt0n?=
 =?us-ascii?Q?uTTJ0jmiJREnB63XALQtQTPCb9/Pb6KlGw+ZTEPAuMVIi9t/fI7xlXnDFHL7?=
 =?us-ascii?Q?0L1pRUTrOO08AVgB5eu0x1Sc8aq0s5O/iFxl60mu+i3E41IGfftpLCyq3580?=
 =?us-ascii?Q?R45PzmL2heRTdlZJdt49X9HmGCYtRMqwT59yyW36+L8Un7mNpaA6ajXB1klm?=
 =?us-ascii?Q?jZCK/hRZU/33hm3XImB0dYb53dTzm6sNGnaJT1rDKFL8x8YzoXn7HAz4iLxq?=
 =?us-ascii?Q?Xf6qUbYalFpPuFYLSbT5U2fv5X6XEU3PF/pXJhX2Hr02RaAzmphGHicvOAQc?=
 =?us-ascii?Q?ugo8GJwJ7uUkUCsJGnKNu9Ys2Ez0+3KhP/G+CuF42pjhjD1zoJvOlwsZozk7?=
 =?us-ascii?Q?29lB1mDpJ1s2LuVGGIZOxfhyCUQJtgMf1D8vp5Vdi6+dhzM7qBTYxzS/FbmZ?=
 =?us-ascii?Q?En0BHs0eWfSUA4xFqNi1YOjU2A3+LQoyB8LmK/RQ2MP98dfw8AQjycGXwSB5?=
 =?us-ascii?Q?PYDCyQTekfiY4Wc6eztHEfUgpG7F6Xx7zAHsu987mhqtpLpEJekpkaE0H50n?=
 =?us-ascii?Q?rCuagMnKpeE24u+absi6XhPncbYMrEpAUnu/xgN1Ww+0crHHRLsjDpBXyyeb?=
 =?us-ascii?Q?d/FB4tK0jGSOkTKszIhAssOeUgJb1eGoDvhWLPJ9RdTeETnt7Gt7NP01l14b?=
 =?us-ascii?Q?1irCusav+dBIc3iMSwx6HQ6n4PJFN+gmqfRMYaOiOp/EiGHSKGxJpepO+bZv?=
 =?us-ascii?Q?0vjCS3z5Oj8mytG9gWFXGKmpJIL+zIYhrZClOKjT4UBuiQDLW/NxBczl9e3W?=
 =?us-ascii?Q?/oiiTVpZgbSFJnGHaWEt9K8v4fa8n+f7QDfAfxGSg9NwUYtfbQB4gpMBLaFb?=
 =?us-ascii?Q?JGFLxxRj0IuWkVCmVnWomSLPNAXJGgLyMKInOyiF+yc/OIIjJfJS7nUIeoJM?=
 =?us-ascii?Q?I2tpt95OFTw4S5mMrONTeYUzoOPPXAy990NKNTJNcD/wawMykiI0Ai1mHRLk?=
 =?us-ascii?Q?cNsgvxvAQbXVlYlBv6nZ575YGbo6ZH3JQCczlaGaEn3QE5tP+xy+Ag8VOb88?=
 =?us-ascii?Q?wjd0EEZGQshyfler4A34d+/8+PLorXMYuSVvrHZDCQMKtrs3oGc8Mxn3ONU7?=
 =?us-ascii?Q?UMSGA/d0L5HqDre0oirtBf6fiqeH3m8b?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:23:43.4724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8dcd1e-7e6b-4ca1-718d-08dcaaf925c3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6455

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


