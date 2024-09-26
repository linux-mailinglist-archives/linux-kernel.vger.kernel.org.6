Return-Path: <linux-kernel+bounces-339824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D577986B08
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE931C21345
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC84176AA0;
	Thu, 26 Sep 2024 02:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="lk5AP6eZ"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2058.outbound.protection.outlook.com [40.107.215.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DE13DBA0;
	Thu, 26 Sep 2024 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727318503; cv=fail; b=ZsqzymkFmBYzoBaqvmXiwAoTgJpQgsmUD/YPEqPqSSwopTpjlWfruR71up2F8so0Ugm/MJ95/wslpSzCtW7fGQVmGcmnZHdXycQpG3tj63BlciMb+a94LTPcP38Ehppy//1BS1GxqO5bS8LWfvDXO96jSb5fqGEGmQe2D4dnpD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727318503; c=relaxed/simple;
	bh=wzweIetEflxsWbQtu2LaFHDOcjNvAdMeuWILluPaaa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qRluMfZS9WWXDjYtkNF7sC6hMF9+5lYij5IeNAJelP/AxWP7XkwIJJHiLmncRwx8ceZBM+B63LRVlsf8cJeJsOF5NXkYRwW7MphqbQJOoKP658izsAcSs07hXV38OEdNfaZSuxc2YPm0SgrgrExuGtzvgOyjKIpArtfy0QUwMC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=lk5AP6eZ; arc=fail smtp.client-ip=40.107.215.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nu5p9Dz/ZkkKVViqr3X9WSSAsyRxNz2iY7oxg/xXMBvi5EibK8Ewk2RG6GC7HKXQDiX+GgqXYIe1YJMTOooW8XMD6lOxRZnoP9uyQRdQIvs696Wfl6H7E75fNj+fCRx5i2zXlzoAGZlJHZKuT44eRCJKGvbGPsMysVKMFSO2bPoR+vGsw8Aq8HFwi9ZN38O1wYRCdmIoOINqDUWwYTnPO2BL5YAam23tQy0xHtzIb/fVTf76VIAedD76UJzNFzLHbLAZ4pKKmmyC86KQ24H5HorLCqWRYbacarrceuJMU4J8FCJIsMxlm0rlMQBJRpJsIDEA9Pg4VuV5Wn+oUekU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlTR1FU91XQZuWy93fy0iL7aFA03dDh8Hpev0PPVETs=;
 b=oKpwKe/eDGw0nq4dO0HWgrIAeqfbAyyR7jPke3DxMkBApinleHqKCkb4jzMTDxTJns2o3YA9JEz2xuh31+bVlPLrDuKmcM9wxzeYrzAl5Tofc8tFqg+SBMfiJHVWqX3VILEG+9cimuWmSlG0B4srM6E1nc+1eUNPnxP+kgCOIKjW65KbTYR9l85WzSTSG4E+kpmaxCBVVfWSg7L2gsCSjsgqatc4OCUWrnlKMDZHBNqLen4oT89oUme1x31andonRg8F72Mt2v1T57G9VkSqxCQEJqqUnJjFza/OPIFoG646mI1LOiVIkYnUXG7E6XnDix0D55dhrMORSiZQ/O7Okg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlTR1FU91XQZuWy93fy0iL7aFA03dDh8Hpev0PPVETs=;
 b=lk5AP6eZi4aUwMcuHr6bZKCXHttTWbMuqduJL2WiyuYhKDSWmTKJgxmpjKPopzDUx7eaBr50pfMSENa+1Ia6OedXLzVmlJkcEx9/rCIqcZ5HFv7yt/2g4NU2Or46wtYSkUx9vky/rIO++FvUE6exFexL3Xv97jOwRlOqWWuIeLkKWUIClQ1VpHdWENAm5bJAL5su5Q52cpy68/FtQbRBMdUlzjdCUlSlTV/K+l5NM2Alen3GGlmC41AEEvaYuzhZmZse5WsAinFXTS6jWuSfZdh5DwjECUHc4pB+wcKihBZMF3bIhgOyUueHzyjrCWvhoVCi7FyDgr9OD+KYjnUrIg==
Received: from PS2PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::21) by SEZPR04MB6503.apcprd04.prod.outlook.com
 (2603:1096:101:af::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Thu, 26 Sep
 2024 02:41:36 +0000
Received: from HK3PEPF0000021B.apcprd03.prod.outlook.com
 (2603:1096:300:57:cafe::ee) by PS2PR01CA0057.outlook.office365.com
 (2603:1096:300:57::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Thu, 26 Sep 2024 02:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021B.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server id 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 02:41:35
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
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE on Spider Board
Date: Thu, 26 Sep 2024 10:41:33 +0800
Message-Id: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021B:EE_|SEZPR04MB6503:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4ef3caf6-8cb7-49e2-35a5-08dcddd4bd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eRJ0GfmYr9gP1lDXhAGa1O7AiFTKOlCH1aXcIgaJqQevScUwCb2D1XARGvYu?=
 =?us-ascii?Q?nULo8IRRuPALhTdJnbTsFN7XB38mPrxpt+myBbus4J2GCtMYgkWgcGf2p5Cu?=
 =?us-ascii?Q?VQeCozCCiZzJiSSRQVIAag5oAiymh03X4CxeKOKLTV9E6z4+M3UwFKGb4BCv?=
 =?us-ascii?Q?k8HJpq9+k7OD9nPFrAXp82+V9JVc5Uzk/pAS8eiNIBpnqf7FzhOxHCakUnC3?=
 =?us-ascii?Q?COYZ7bXdR+/dY0aXzM2hcXT5DJpJ9bcoXNrUIhJvE3bQNoD+qjX1b1BeljTo?=
 =?us-ascii?Q?ZdsT2su/9JHC44vOVC0jyKSZFUYS/l2F2ZdbzEE+yqDCfMNfNXnsOy+pNeLn?=
 =?us-ascii?Q?edXakTbCWj1VjgRO8lan+bn4a2mm9dndQJKt2FFSQGSzoTUVgoTKUSLLmSwD?=
 =?us-ascii?Q?Lr7lavND0FAow8VmEOMGZpuSyP/QuomzDLFT/GJdf+RR9BWGeuy3csAG+V4V?=
 =?us-ascii?Q?heW2LtpERSiOj1AXvaCGA1eEHdO5xW/UhGC+iB07wW1ElJdvq5+eCsQ5if0p?=
 =?us-ascii?Q?gVPnmsNRkiEJ0XPMmppfLc9nCGK7YI2isAyKUcT0dR4w46N/RKqkWU6EqOKZ?=
 =?us-ascii?Q?Pr5Rfbet9VZlrV9DEYz/PuhfvXkUqvmdckNiToP4sOilF2vllq87oXei3cly?=
 =?us-ascii?Q?IxxxBXtgbFbGkf+jBftJ4WCw2oJ2IO10UdVSswoAXZoji6lYcgrSsv4vMzyF?=
 =?us-ascii?Q?nDqxWyH3y4uc2Dbc8O4Djfh+Mr0BZ3LZBF5D5SKtzfuZIRNDnVHEmUwz9ene?=
 =?us-ascii?Q?hYLtRLlH75MJ+E40vmuAP8Iz5GSgfBVgferzQuW2W1uTDSr8YcMi1qzLrUJs?=
 =?us-ascii?Q?s5L9vPdjyVvpBs+aLPSTHrLFPWUou09EYQ2DBf9Mnf/cEtqMSPJ8B2vcZ0SI?=
 =?us-ascii?Q?eHTmQT/I8VKmlYjispS74LEqEC+L7LMu298r59r82f+lF5s8qyrmf8v7RDGP?=
 =?us-ascii?Q?eG08W6OCVR13tzf/IgOQ2NXA/HzNaLMUNG8g9DTodHQRmeSNngPcR2gJZeVM?=
 =?us-ascii?Q?bNizIfT4OwBYm5Ric+D4XsTopBPZUl0MPScFzlbFgjPY5Rxt5RR6lazQeN6b?=
 =?us-ascii?Q?ii1IOth247d2Ktm6F6hMHvNWUktekkhIIrgGsTDVWiU1ce7lMfeeO56u1Z1d?=
 =?us-ascii?Q?lECJXVFZz5f8Ybjw4Bf8TNzsV7b7JhSE/Wvve1m9zQ5+nfvGNqdxY1+G3hIn?=
 =?us-ascii?Q?tzonWEUTUBtsqWrm7j2dz32EVspPR8pDrevHEE2bhsCHG0Dkc82UfdfokJ6n?=
 =?us-ascii?Q?QyFh5P0ccxtBUPqGTv6J8IuDTJjFUsoFZCrHsxKHvL0OGJXWqsnyaWjkxTc4?=
 =?us-ascii?Q?tup9G31U/s5n5SqzoTXPaoVMK39jAv5FTRv/xtVtNhCJTtNByj3WTFtw+tTm?=
 =?us-ascii?Q?NWt3PUfm0DRI8iV6inWvCLWxebZoSaYDwh0wy0YZ6Zn18sxrOJ+Sx5bQGetP?=
 =?us-ascii?Q?W/fpSsN2sl/LOjo+86rkoQVpuv0gKyK6?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 02:41:35.1595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef3caf6-8cb7-49e2-35a5-08dcddd4bd07
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021B.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6503

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add I2C mux for CPLD IOE on Spider Board.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..ea1a9c765483 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -17,6 +17,9 @@ aliases {
 		serial6 = &uart7;
 		serial7 = &uart8;
 		serial8 = &uart9;
+
+		i2c28 = &imux28;
+		i2c29 = &imux29;
 	};
 
 	chosen {
@@ -277,8 +280,72 @@ i2c-mux@71 {
 };
 
 &i2c10 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-mux@74 {
+		compatible = "nxp,pca9544";
+		reg = <0x74>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		imux28: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@24 {
+				compatible = "nxp,pca9506";
+				reg = <0x24>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-line-names = "","","","",
+						  "NIC0_MAIN_PWR_EN",
+						  "NIC1_MAIN_PWR_EN",
+						  "NIC2_MAIN_PWR_EN",
+						  "NIC3_MAIN_PWR_EN",
+						  "","","","","","","","",
+						  "","","","","","","","",
+						  "","","","","","","","";
+			};
+		};
+
+		imux29: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
 };
 
 &i2c11 {
-- 
2.25.1


