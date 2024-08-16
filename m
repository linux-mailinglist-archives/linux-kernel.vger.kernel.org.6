Return-Path: <linux-kernel+bounces-289394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADD89545CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094981C240D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942B15DBAE;
	Fri, 16 Aug 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="XjeC2vHz"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2088.outbound.protection.outlook.com [40.107.215.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F56515E5C0;
	Fri, 16 Aug 2024 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800403; cv=fail; b=hQ2/Dzn/PdBSMELdP0Uzu8uqRzzwn44DBsmrvXjGQfWFMRwU23et32DDAPiKq5aZqyP4fsoL3cugRcr91+SbZIU4TLZ2IZ/6xRJrouad8iE8ptM/ZWnVdSD84ck0Ld8/cG2F2wj/vRl1l2OMKX2gvIDbqGxZweHLOMDgKyAKtlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800403; c=relaxed/simple;
	bh=uSK7NwkEi13veaYDqGNJo2rL+lTSGlvtBXedPFbkvMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIPOG9lUTMG8d+G+Hd2fqWbMJUHLDS7DKNEz3q3Fj0xyZqeB6YP9WLFX7c9/OVQKeBggdOIy6Tx4bX6vpEG2W9t/iaJtCl22YZZBTwfw0NR9vouDxyV3h41wDkQ5AlMqrIZj5RCLJrzrbjB8d7AeuslJnaW+fl3sMMlR392EdcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=XjeC2vHz; arc=fail smtp.client-ip=40.107.215.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CI33zvLIk+hkm28T7VfxMlRePR+L/zrkbH+uZ7/GEcc1f76qkcKay90zLlp9soRkypDGZyPuL4zdIhIP8uVnBrJvwsGmCc5bQWz8JURjfjp++NM3EpCIAmSr3Z3R2oVEQ5/m8W0mePfopLGhjGxFhImkpCVzRkdewo4ckV8ZRYMqFLAcHsIe6rPljTUeQwqhT8NO90iBlOszXQc97h8xC3a3DAjIJX2qx/ttH0QuC77Bv7MJ25+mdcke4js5kvuiJ2A8/oxrIRJm/k8qNABCqsBVWhleMoo3KubcvVwMMu9AVjrkyQVLjX1VlziP9b/8uMjlBC9cFfns2ic0nOjhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+24Kp4KzLO9I4Hcd3hiuundM/PhwavSUaxUKYjbqNc=;
 b=up30C88clK7THxyDpCehx+1VD2PjZB1Q0sp2irRW0t4FToub6jb5HF+RdEP6qSGyrp1qNa25c7UnYv4aL8ksVzVnvYir0bCty48/mkXmLC/4BcOA35Zl2kleOw5XKMXlPSzDwZvOgkm96iY09FSU/rG3xCFZgFo7nIfiESbKtp47sp7FMncJ1UKGNamcUcJCFy5uKNIJfgNyLZClGdEIjBz4wFJmsGElg2gWEZ7hU9crwhyDU+Iqc4pxXiS4WLa00nBjEkXGvJRrxfGwnxxuKnOTie3pF2z0Rx7z2KNFIuxhAJ/yksrLBQa9z6I5P33qm2pM4MeSk+9QTJ8XK4uzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+24Kp4KzLO9I4Hcd3hiuundM/PhwavSUaxUKYjbqNc=;
 b=XjeC2vHzbkg3kJs/lkr0u0ks/CPY/NXvuRwF1xkdAe95PepwmctPjIgRdgfGZNyv8i0qXLm2q8G1YPAV789DX7CMhMUbgN4qxpqsvyNqUewaEUpKVTZrM6XC79UNsOjyFoCPoBNp2k8t07PVWW9qhjTLdewh7HarkeRFjLxZQo+c3Bl5n4gz1iotT/WMXJcL7bo9azr04wPhJBVtQFIwqba/s9RjFy1NYQK8AYZpu6X1cd5eq4Ikv1Pyj7gqJt9JhUnHJUPXB7dO2k8dYR3hX7zNDjWZGbTGE3FgFfwfMiW+4QXC32VTMAVySwZ44XyQm8nADcCPU57eTZ5KLmHXEA==
Received: from SG2PR06CA0242.apcprd06.prod.outlook.com (2603:1096:4:ac::26) by
 TY0PR04MB6175.apcprd04.prod.outlook.com (2603:1096:400:32c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:26:33 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:ac:cafe::9) by SG2PR06CA0242.outlook.office365.com
 (2603:1096:4:ac::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:26:32
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
Subject: [PATCH v12 28/28] ARM: dts: aspeed: yosemite4: fix GPIO linename typo
Date: Fri, 16 Aug 2024 17:24:15 +0800
Message-Id: <20240816092417.3651434-29-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|TY0PR04MB6175:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a7763086-d688-4a00-46e2-08dcbdd5847d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vawKqUkIZl+qFICNLW5tyRtKvLuegeR/H82OnNFrgjtUGDRVdUUNNr2NL72W?=
 =?us-ascii?Q?ernRTqFWAkMjt8STGyZRYsAYne7Jr8EVfLfGoz14bS3RFpm24wj8m5dNvd4F?=
 =?us-ascii?Q?1b0wV4btVwEqgfpZ0cR8ajBXP/DOz70rcOb7tDUtwm+DKsoYj2hGq0hOJLkF?=
 =?us-ascii?Q?qKAbJMFZI9eKOK0HrzPD1RKUN9VRx+3hgLsZx2o96i8pYcex20HK76bG28J7?=
 =?us-ascii?Q?zbO6zjVs8sK8YI/Nrda6dp5QfxUty6hWAaRVaWX21hKl+nltSTyHLwqRaloi?=
 =?us-ascii?Q?np2KclFvuXYgeHQYVowij+X9xGbZEARet+HEQWKxlbxN7wIiFDMYHZmciZqH?=
 =?us-ascii?Q?AdE2YaBS9YvU88IJ5roiQKYlJ8KPVsUAalWh3GqzrYHuVKjEK1WzqYV0N8TX?=
 =?us-ascii?Q?4VpZ2P+V1qUQ10+HyL3q7TOXG0BhqXJwDAOAw33+l9e/s88Jod2hAQE9U9Rh?=
 =?us-ascii?Q?3FU1HSVOkiUYtdpvQ1kcrIpdDVtLGono8xe3S+W7HgmSdJslAL75WfuaiMNC?=
 =?us-ascii?Q?5mE+pxxMBmycYHVoQ5cxOrF5/QKb6m+g+e0iihpsi0segnq5asNfdZY/T9KL?=
 =?us-ascii?Q?NE04UVPbLtELKa5r+fZ1Go9P0RdN8MIOZDqXvCrIxPeRmvxvC+/8+kf2ECVs?=
 =?us-ascii?Q?wZcRsfzyFxB0HZrbmQxyVGKUin2EHNcs8im88eXan1Rcke0NMtyFJMcNd6JS?=
 =?us-ascii?Q?OPSPW9NAJVz5/XRfofuZrn77qyG0hJ2hmM3HxewBEs05kmazdrgzqu1hfzEp?=
 =?us-ascii?Q?0Qm1piM+xgNJb2i3QCkredzYKmASJVXdQdDcV51IKO/iH17fWs2BN6bbHd36?=
 =?us-ascii?Q?KlLWFbo4OaXOR/wUadoTAEZqZArKxyLmcek/+7vntwdc1lTWT/EJ4YVA//5c?=
 =?us-ascii?Q?yQxSxZzwUERzjCV70yFA8CYj6HABFJlhjrBLrWx8u01Lx7a94qY2kJFOOjYk?=
 =?us-ascii?Q?HJYk1kHTQ97TT36x/H2kWdqg0Pl27nBhu4yGNFc2m9N5709AGlDE3NFPWt/Z?=
 =?us-ascii?Q?D1vvWyAd9Uv8RhGp89r7greD67yUNcSWqzjnFQ+092nqPz4Jpx+j9k3Tn3Z7?=
 =?us-ascii?Q?km/OMMpjd/mEPz3dcCpSwGBzFmqZtYVGXVizf+PSvuboIE13rldO39LvkyUO?=
 =?us-ascii?Q?429wto4T78BWNGt3u0LIJhDQ9VitBwXZ9IEfh2D9TY+SKUyQdHCF4wE7/ULU?=
 =?us-ascii?Q?uE9EVipbSIFYPD5fsnHMXK05cQNMycX7D7U7IZUl9qH+s/dWyFGJ48zd4shH?=
 =?us-ascii?Q?WXK/KNuIS9wA9BhJjBLN6w2J+O1sar0q4LDVBThiaw+P76GMzPi6SW8Jj3c4?=
 =?us-ascii?Q?soj0sCmoz8/b56i6wJupdaFDH+TQaF2RxOImUFbYpwxv/x+WHhL5rGqWM3GR?=
 =?us-ascii?Q?VuoUBF8Nye9rB8smViqNSb+VOFsGM++0B2xtVkPDeabYPxIN49p6ZSgOKWV4?=
 =?us-ascii?Q?cL22ZuFT15OX+u8uUvRfg+HycEvDZHD/?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:26:32.5910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7763086-d688-4a00-46e2-08dcbdd5847d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6175

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


