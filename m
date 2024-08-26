Return-Path: <linux-kernel+bounces-300822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8709195E8D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DFA1F22717
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9641494BF;
	Mon, 26 Aug 2024 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="E80FS5vO"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010046.outbound.protection.outlook.com [52.101.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2D148318;
	Mon, 26 Aug 2024 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653619; cv=fail; b=VC/vX9vd8W4qBUsSm6Lp85e77iSoK4ba31t93nJ4T85x9prJMpxbzg39ru3bdokrY0i1LZO/ZwymCiwCg84xbm0kFvVHhsKVI2mmkexCz8mZzrqVstq4UiFplmx5hKnWPyMuCzfjPojmDCJf1GATkUb3LXNHMcUBPpqJLou3kOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653619; c=relaxed/simple;
	bh=uSK7NwkEi13veaYDqGNJo2rL+lTSGlvtBXedPFbkvMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYddIm5ZlVpeKZRvqBaHogdH7Py3k37l4ssR/aItT61G39NI2oPeH0fOT+iEICHTnoeboNOTZVKWtKbr0f0ok7BnWAekoeD7sQVdCGRh5zQSwDdFhV4GbUpJdhg6c+do09nvttLEUtPclcIuum7p6ISBec8tzHsbrZbkt6pSwSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=E80FS5vO; arc=fail smtp.client-ip=52.101.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQ477YLVrUFY9UjVfjOYph2B94rCv2MZJGzb3xzHPHiW5YNHWvVuTC+x3tRFigJNvR3Ocx5FEnoND4V6yVkSfqE9XVfEVAjq+kAfnkWKrdrDRXX4S+3CyVfp02cmBINyiXWDD6UFLo5UbnjAjJnWXPCcyPye7PG58fjo9Od90sjdPkcYqm4simhKAr3EK+NF0yNd+1lhwDYw3JIR+LB0uMPOaVSrIxTL3eumw+qzl9F+itgpJffrrkTy6cJswPQN0W5Cx4ZrrYQWeb79jWWQjHnRD/nW0RL7TR9eC/WVzFJ5jvNohF90cYDTgnWEo/lttM5vjeenjCW0wn7tsu/+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+24Kp4KzLO9I4Hcd3hiuundM/PhwavSUaxUKYjbqNc=;
 b=d2aIS70HgALuWj3YEINKUmtUYXy2MIjVI4Hsgsflmzq/qaDFsv7AVgUfPQ+Kvf2PI6FNqv2lRkq+i0uLCEYwLoJIGiva44VnF2fulix6rgl69ZcYvChXoH+YNfxHgQ10cQhWsQepZawJYdNCOOXhqD8HsN0jEGCsTnDhocd3S3l79SqbHH7X9y0segAx1l2U9nkLhlZioPIrDMALqHNPpV20NrkWXxyZsQo3xRpd2fE+RqM9ciiDeBEB5cwlVtFfzCKKrdXZ/EONnkuNxX341hXjSUdlKnG5IMUI+76ucOhl4DtxERPvdu500tpdyQNgQ4nRN53A8zqFMkBbyyBIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+24Kp4KzLO9I4Hcd3hiuundM/PhwavSUaxUKYjbqNc=;
 b=E80FS5vOpWk07TqR1YJyjDRmWzPQ71ghhHhSzpS+B8ehhCrOyurH47nrzANKuIAJF+EgYw88x9P61Gb4Vi3TMeZAFHeS20rsDJKl5abdZOP7tHWUpriJQdG/5Vj+tH4LKeaJZ3n/2nRuiddkT+IyGddJui6ndDDgZKj+kRtqSya0H6RHNBgpd9LJ/WP6eeEpj48EGVesEaZEF3deiRRLHd/e3+C1DOx/6TDQErMXlH3x0UQDm9+NdUz+mc+7/ifRLVO/btlLG9woOqUk0i57ztCjyoQYe7C89e0ZfBXX4EejH6g4TWJAwpW0xtWuXxo/wSWIx0ymVz++4GjBtPYfYw==
Received: from PS1PR03CA0015.apcprd03.prod.outlook.com (2603:1096:803:3d::27)
 by SEYPR04MB5810.apcprd04.prod.outlook.com (2603:1096:101:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:26:43 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::2f) by PS1PR03CA0015.outlook.office365.com
 (2603:1096:803:3d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:26:42
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
Subject: [PATCH v14 28/31] ARM: dts: aspeed: yosemite4: fix GPIO linename typo
Date: Mon, 26 Aug 2024 14:24:02 +0800
Message-Id: <20240826062408.2885174-29-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|SEYPR04MB5810:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fce5999d-a5e2-48b0-0056-08dcc5980d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pmNR9el7g7CexkuEtoGUmjsHtVHWy8KekZ7QxpNz6mHFrGMiXZdoGXlqCsDX?=
 =?us-ascii?Q?+LLzn8gBAbI4mIQ/lGBpase9lWf+l9LPVtMGNubF0NefaJ9/v4O/DCd5hujm?=
 =?us-ascii?Q?bt0g2bhD5KPwij9MTK7moGdt5P5Snr73BtQw3WrCgKSeY1GcPuwjxUisxOaq?=
 =?us-ascii?Q?avGabiLYteDDXQ9boDjjPwMvPi8wHi+2VK3Dqt7/apHWGaw04RUnhmvR/CMa?=
 =?us-ascii?Q?2cTOLx+7Ya/l/XFMfJNVmzg70eZgh0tDqA2leeuUzmQrwFAcQrOxnLMXTzNq?=
 =?us-ascii?Q?qP7FBl8lvb4f2/OedC/7kYJEpDV6vhPEIKYC8so/i+a2zm8Xr3EaTZ6jfaSQ?=
 =?us-ascii?Q?Jt5dgi1B612R5d6CDAbjMojqJz3DRlo14nseVfT+itkDJ6tuT7ffz/Cm5eee?=
 =?us-ascii?Q?JiJ3IOBLo88udMpMwDQjdgYau+NViTjpU4KPydB8SAKzdMfMC4MTOLi42+F+?=
 =?us-ascii?Q?wldEE2CX/4gKNrl2XghkIPIic51D0fmXA/CEV8+FJrSyEZzK7c6oq3Mznwfs?=
 =?us-ascii?Q?gn49Ih14SPDCvWE6aTqUBIPQpmg7Xb1DTrW26x+JCfzAyLisUfwjKha8MgLW?=
 =?us-ascii?Q?s799at37sePZd4FWlaMxCLSbmHlvNH5IZsSxK/XC6+mfi3Km6bmQsOp3VDni?=
 =?us-ascii?Q?iQMOvlgZAZNpPRLaMKgOLZrOCahw03aImszWsYSm0Iz6bH+/zpHDuj/9mwFg?=
 =?us-ascii?Q?DWAIuX286oZav/uSlcTdr4LXHB33Y8eVqMhoLx9Xy/FRNRM8zTqaOq6iYm8t?=
 =?us-ascii?Q?0eIhNZASA5R4vrbVSkeO4JWbxTWej1Ag0cN1EvakvEJ6TfhXNQZ0Kly6GOCb?=
 =?us-ascii?Q?h4tBNjXkKHb8P1AH6sT0ASDt1kaHCGQGYnc+n2lxFJqiY4WXCMVqIVcy+vQH?=
 =?us-ascii?Q?ZbbMWWanAM6V57a/9JnVHuq/vh8OBtGLWuXf70IYfBi5btVIp4/TFkFsR+Dr?=
 =?us-ascii?Q?VvZU0P+PYasjTnyb5Z8BwdLGmTx7v2PDAJPw0T+NsvjTCisMWa/5L6zO8gNQ?=
 =?us-ascii?Q?KffkFBmz9NvCFMBLwuStyzxWozulBb8iLOJTiqkdG9h+qX2l1Ceq0yFJlkVM?=
 =?us-ascii?Q?jGAboV5QxpLzFylsX2sqFimcAyULtfDhhgXxCvUiIGMgKVnsR3yxYv//AMhi?=
 =?us-ascii?Q?pE83NPGX7pIlJMdiVpj0E9VMi11xDxzCWhUCHxiNE8VEeA/3qHjdE56QjRQE?=
 =?us-ascii?Q?cM6oOq+swc/NCbsJLjdGaxHOXf20w6/ZHvAi43TH6PgwfV3jnnNQvYao9dw4?=
 =?us-ascii?Q?hGHxTMLs/BIRXTa5vD+Ma0PIJ2KaVQVPD0acw+4Z9Graf5oofdTqAaqRRtdV?=
 =?us-ascii?Q?Ouo862AB9+ltZ40QQTdwf6sBX7CONJuojzx3kusHOiGZDL0Pole7qgeKG1ef?=
 =?us-ascii?Q?PvhEEAeo5mwWIRVIEtg2NzW+ZattSwhasqnspSu4qrtlaeULYt/np3v+Ib9X?=
 =?us-ascii?Q?i9SVe2OcEcgHkSJ9HM9ifQf8ZK0y3/y3?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:26:42.9395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce5999d-a5e2-48b0-0056-08dcc5980d7f
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5810

Fix GPIO linename typo and add missing GPIO pin initial state.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 554 ++++++++++++++----
 1 file changed, 455 insertions(+), 99 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index abd4a9173de4..4090725160f9 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -285,6 +285,8 @@ &mac2 {
 	pinctrl-0 = <&pinctrl_rmii3_default>;
 	use-ncsi;
 	mellanox,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
 };
 
 &mac3 {
@@ -293,6 +295,8 @@ &mac3 {
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
 	mellanox,multi-host;
+	ncsi-ctrl,start-redo-probe;
+	ncsi-ctrl,no-channel-monitor;
 };
 
 &fmc {
@@ -327,6 +331,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -348,13 +359,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -373,6 +377,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -394,13 +405,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -419,6 +423,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -440,13 +451,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -465,6 +469,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -486,13 +497,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -511,6 +515,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -532,13 +543,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -557,6 +561,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -578,13 +589,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -603,6 +607,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -624,13 +635,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -649,6 +653,13 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@24 {
+		compatible = "nxp,pca9506";
+		reg = <0x24>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gpio@21 {
 		compatible = "nxp,pca9506";
 		reg = <0x21>;
@@ -670,13 +681,6 @@ gpio@23 {
 		#gpio-cells = <2>;
 	};
 
-	gpio@24 {
-		compatible = "nxp,pca9506";
-		reg = <0x24>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	power-sensor@40 {
 		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
@@ -687,6 +691,7 @@ power-sensor@40 {
 &i2c8 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux@70 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -798,6 +803,7 @@ eeprom@54 {
 &i2c9 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux@71 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -993,7 +999,7 @@ power-sensor@13 {
 		reg = <0x13>;
 	};
 
-	gpio@20 {
+	gpio_ext1: pca9555@20 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
 		gpio-controller;
@@ -1012,7 +1018,7 @@ gpio@20 {
 		"","";
 	};
 
-	gpio@21 {
+	gpio_ext2: pca9555@21 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
 		gpio-controller;
@@ -1031,7 +1037,7 @@ gpio@21 {
 		"","";
 	};
 
-	gpio@22 {
+	gpio_ext3: pca9555@22 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
 		gpio-controller;
@@ -1050,7 +1056,7 @@ gpio@22 {
 		"PWRGD_P12V_AUX_0","PWRGD_P12V_AUX_1";
 	};
 
-	gpio@23 {
+	gpio_ext4: pca9555@23 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
 		gpio-controller;
@@ -1070,21 +1076,21 @@ gpio@23 {
 	};
 
 	power-sensor@40 {
-		compatible = "mps,mp5023";
-		reg = <0x40>;
+			compatible = "mps,mp5023";
+			reg = <0x40>;
 	};
 
 	power-sensor@41 {
-			compatible = "ti,ina233";
-			resistor-calibration = /bits/ 16 <0x0a00>;
-			current-lsb= /bits/ 16 <0x0001>;
-			reg = <0x41>;
+		compatible = "ti,ina233";
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
+		reg = <0x41>;
 	};
 
 	power-sensor@44 {
-			compatible = "ti,ina238";
-			shunt-resistor = <1000>;
-			reg = <0x44>;
+		compatible = "ti,ina238";
+		shunt-resistor = <1000>;
+		reg = <0x44>;
 	};
 
 	temperature-sensor@48 {
@@ -1156,33 +1162,32 @@ rtc@6f {
 				compatible = "nuvoton,nct3018y";
 				reg = <0x6f>;
 			};
-
 			gpio@20 {
-				compatible = "nxp,pca9506";
-				reg = <0x20>;
-				gpio-controller;
-				#gpio-cells = <2>;
+					compatible = "nxp,pca9506";
+					reg = <0x20>;
+					gpio-controller;
+					#gpio-cells = <2>;
 			};
 
 			gpio@21 {
-				compatible = "nxp,pca9506";
-				reg = <0x21>;
-				gpio-controller;
-				#gpio-cells = <2>;
+					compatible = "nxp,pca9506";
+					reg = <0x21>;
+					gpio-controller;
+					#gpio-cells = <2>;
 			};
 
 			gpio@22 {
-				compatible = "nxp,pca9506";
-				reg = <0x22>;
-				gpio-controller;
-				#gpio-cells = <2>;
+					compatible = "nxp,pca9506";
+					reg = <0x22>;
+					gpio-controller;
+					#gpio-cells = <2>;
 			};
 
 			gpio@23 {
-				compatible = "nxp,pca9506";
-				reg = <0x23>;
-				gpio-controller;
-				#gpio-cells = <2>;
+					compatible = "nxp,pca9506";
+					reg = <0x23>;
+					gpio-controller;
+					#gpio-cells = <2>;
 			};
 		};
 
@@ -1242,35 +1247,35 @@ adc@37 {
 	power-sensor@40 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x40>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x41>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x42>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x43>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
 		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x44>;
-		resistor-calibration = /bits/ 16 <0x0a00>;
+		resistor-calibration = /bits/ 16 <0x0400>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
@@ -1323,6 +1328,42 @@ channel@5 {
 				};
 			};
 
+			hwmon0: hwmon@21 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x21>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
@@ -1330,6 +1371,42 @@ gpio@22{
 				#gpio-cells = <2>;
 			};
 
+			hwmon1: hwmon@23 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x23>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon0 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon0 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon0 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			pwm@2f{
 				compatible = "maxim,max31790";
 				#address-cells = <1>;
@@ -1393,6 +1470,42 @@ channel@5 {
 				};
 			};
 
+			hwmon2: hwmon@21 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x21>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon2 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon2 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon2 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon2 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon2 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon2 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
@@ -1400,6 +1513,42 @@ gpio@22{
 				#gpio-cells = <2>;
 			};
 
+			hwmon3: hwmon@23 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x23>;
+				#pwm-cells = <2>;
+
+				fan-3 {
+					pwms = <&hwmon3 2 20000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+
+				fan-4 {
+					pwms = <&hwmon3 5 20000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+
+				fan-5 {
+					pwms = <&hwmon3 5 20000>;
+					tach-ch = /bits/ 8 <0x02>;
+				};
+
+				fan-0 {
+					pwms = <&hwmon3 0 20000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+
+				fan-1 {
+					pwms = <&hwmon3 0 20000>;
+					tach-ch = /bits/ 8 <0x0c>;
+				};
+
+				fan-2 {
+					pwms = <&hwmon3 2 20000>;
+					tach-ch = /bits/ 8 <0x0e>;
+				};
+			};
+
 			pwm@2f{
 				compatible = "maxim,max31790";
 				#address-cells = <1>;
@@ -1493,7 +1642,7 @@ temperature-sensor@1f {
 				reg = <0x1f>;
 			};
 
-			temperature-sensor@3c {
+			emc1403@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
@@ -1514,7 +1663,7 @@ temperature-sensor@1f {
 				reg = <0x1f>;
 			};
 
-			temperature-sensor@3c {
+			emc1403@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
@@ -1535,7 +1684,7 @@ temperature-sensor@1f {
 				reg = <0x1f>;
 			};
 
-			temperature-sensor@3c {
+			emc1403@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
@@ -1556,7 +1705,7 @@ temperature-sensor@1f {
 				reg = <0x1f>;
 			};
 
-			temperature-sensor@3c {
+			emc1403@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
@@ -1569,6 +1718,92 @@ eeprom@50 {
 	};
 };
 
+&i3c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i3c1_default>;
+	i3c-pp-scl-hi-period-ns = <40>;
+	i3c-pp-scl-lo-period-ns = <40>;
+	i3c-od-scl-hi-period-ns = <380>;
+	i3c-od-scl-lo-period-ns = <620>;
+	sda-tx-hold-ns = <10>;
+
+	mctp-controller;
+	hub@0x70 {
+		reg = <0x70 0x3c0 0x00700000>;
+		cp0-ldo-en = "enabled";
+		cp1-ldo-en = "enabled";
+		cp0-ldo-volt = "1.2V";
+		cp1-ldo-volt = "1.2V";
+		tp0145-ldo-en = "enabled";
+		tp2367-ldo-en = "enabled";
+		tp0145-ldo-volt = "1.2V";
+		tp2367-ldo-volt = "1.2V";
+		tp0145-pullup = "2k";
+		tp2367-pullup = "2k";
+
+		target-port@0 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@1 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@2 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@3 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+	};
+};
+
+&i3c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i3c2_default>;
+	i3c-pp-scl-hi-period-ns = <40>;
+	i3c-pp-scl-lo-period-ns = <40>;
+	i3c-od-scl-hi-period-ns = <380>;
+	i3c-od-scl-lo-period-ns = <620>;
+	sda-tx-hold-ns = <10>;
+
+	mctp-controller;
+	hub@0x70 {
+		reg = <0x70 0x3c0 0x00700000>;
+		cp0-ldo-en = "enabled";
+		cp1-ldo-en = "enabled";
+		cp0-ldo-volt = "1.2V";
+		cp1-ldo-volt = "1.2V";
+		tp0145-ldo-en = "enabled";
+		tp2367-ldo-en = "enabled";
+		tp0145-ldo-volt = "1.2V";
+		tp2367-ldo-volt = "1.2V";
+		tp0145-pullup = "2k";
+		tp2367-pullup = "2k";
+
+		target-port@0 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@1 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@2 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@3 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+	};
+};
+
 &adc0 {
 	status = "okay";
 	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
@@ -1579,8 +1814,8 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 
 &adc1 {
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>
-			&pinctrl_adc15_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+	    &pinctrl_adc15_default>;
 };
 
 &ehci0 {
@@ -1595,6 +1830,10 @@ &uhci {
 	status = "okay";
 };
 
+&jtag1 {
+      status = "okay";
+};
+
 &sgpiom0 {
 	status = "okay";
 	ngpios = <128>;
@@ -1701,16 +1940,29 @@ &pinctrl_gpio3_unbiased &pinctrl_gpio4_unbiased
 			"","PRSNT_NIC0_N","","",
 	/*V0-V7*/       "FM_RESBTN_SLOT5_BMC_N","FM_RESBTN_SLOT6_BMC_N",
 			"FM_RESBTN_SLOT7_BMC_N","FM_RESBTN_SLOT8_BMC_N",
-			"","","","",
+			"ALT_SPIDER_INA233_R_N","ALT_SPIDER_TMP75_R_N",
+			"INT_FANBOARD1_IOEXP_N","INT_FANBOARD0_IOEXP_N",
 	/*W0-W7*/       "PRSNT_TPM_BMC_N","PRSNT_OCP_DEBUG_BMC_N","ALT_TEMP_BMC_N","ALT_RTC_BMC_N",
 			"","","","",
-	/*X0-X7*/       "","LT_HSC_SERVER_SLOT6_N","FLT_HSC_SERVER_SLOT7_N","","","",
+	/*X0-X7*/       "","FLT_HSC_SERVER_SLOT6_N","FLT_HSC_SERVER_SLOT7_N","","","",
 			"PWRGD_SLOT5_STBY","PWRGD_SLOT6_STBY",
 	/*Y0-Y7*/       "","","SPI_LOCK_REQ_BMC_N","PWRGD_SLOT7_STBY",
 			"","","EN_NIC2_POWER_BMC_R","",
 	/*Z0-Z7*/       "EN_P5V_USB_CPLD_R","FLT_HSC_SERVER_SLOT5_N",
 			"PWRGD_SLOT8_STBY","","","","","";
 
+	pin_gpio_b0 {
+		gpios = <ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_b2 {
+		gpios = <ASPEED_GPIO(B, 2) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_b3 {
+		gpios = <ASPEED_GPIO(B, 3) GPIO_ACTIVE_HIGH>;
+		input;
+	};
 	pin_gpio_b4 {
 		gpios = <ASPEED_GPIO(B, 4) GPIO_ACTIVE_HIGH>;
 		input;
@@ -1719,6 +1971,14 @@ pin_gpio_b5 {
 		gpios = <ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
 		input;
 	};
+	pin_gpio_e0 {
+		gpios = <ASPEED_GPIO(E, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_e1 {
+		gpios = <ASPEED_GPIO(E, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_f0 {
 		gpios = <ASPEED_GPIO(F, 0) GPIO_ACTIVE_LOW>;
 		input;
@@ -1759,6 +2019,58 @@ pin_gpio_l7 {
 		gpios = <ASPEED_GPIO(L, 7) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_m3 {
+		gpios = <ASPEED_GPIO(M, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_m4 {
+		gpios = <ASPEED_GPIO(M, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_m5 {
+		gpios = <ASPEED_GPIO(M, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_n0 {
+		gpios = <ASPEED_GPIO(N, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_n1 {
+		gpios = <ASPEED_GPIO(N, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_n2 {
+		gpios = <ASPEED_GPIO(N, 2) GPIO_ACTIVE_LOW>;
+		input;
+		};
+	pin_gpio_n3 {
+		gpios = <ASPEED_GPIO(N, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_p1 {
+		gpios = <ASPEED_GPIO(P, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_q4 {
+		gpios = <ASPEED_GPIO(Q, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_q5 {
+		gpios = <ASPEED_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_q6 {
+		gpios = <ASPEED_GPIO(Q, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_q7 {
+		gpios = <ASPEED_GPIO(Q, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_r1 {
+		gpios = <ASPEED_GPIO(R, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_s0 {
 		gpios = <ASPEED_GPIO(S, 0) GPIO_ACTIVE_LOW>;
 		input;
@@ -1767,6 +2079,14 @@ pin_gpio_s1 {
 		gpios = <ASPEED_GPIO(S, 1) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_s5 {
+		gpios = <ASPEED_GPIO(S, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_u5 {
+		gpios = <ASPEED_GPIO(U, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_v0 {
 		gpios = <ASPEED_GPIO(V, 0) GPIO_ACTIVE_LOW>;
 		input;
@@ -1783,6 +2103,14 @@ pin_gpio_v3 {
 		gpios = <ASPEED_GPIO(V, 3) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_v6 {
+		gpios = <ASPEED_GPIO(V, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_v7 {
+		gpios = <ASPEED_GPIO(V, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_w0 {
 		gpios = <ASPEED_GPIO(W, 0) GPIO_ACTIVE_LOW>;
 		input;
@@ -1815,6 +2143,34 @@ pin_gpio_w7 {
 		gpios = <ASPEED_GPIO(W, 7) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_x1 {
+		gpios = <ASPEED_GPIO(X, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_x2 {
+		gpios = <ASPEED_GPIO(X, 2) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_x6 {
+		gpios = <ASPEED_GPIO(X, 6) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_x7 {
+		gpios = <ASPEED_GPIO(X, 7) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_y3 {
+		gpios = <ASPEED_GPIO(Y, 3) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_z1 {
+		gpios = <ASPEED_GPIO(Z, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_z2 {
+		gpios = <ASPEED_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
+		input;
+	};
 	pin_gpio_z3 {
 		gpios = <ASPEED_GPIO(Z, 3) GPIO_ACTIVE_LOW>;
 		input;
-- 
2.25.1


