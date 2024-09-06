Return-Path: <linux-kernel+bounces-318515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB0696EF0D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2CE287868
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D011C86F9;
	Fri,  6 Sep 2024 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="AEw3Vn5O"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010050.outbound.protection.outlook.com [52.101.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43D1C86E7;
	Fri,  6 Sep 2024 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614696; cv=fail; b=ST3Rdu3mLI7kPSsbFCp/LXf531seLEgldfZDgII4RXBMfBuIrFH5KB52Xi6tuLgk06NHRmlR6QTEsKYed/j4fQfyrO3I3tNBeTmx4HfW3M/Tq30HqptY5NUhWp8kQFE0Tgrf0X12JnZP70VIypzivdeEdbIqHimyBi2s9kWJDSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614696; c=relaxed/simple;
	bh=2C14TWpdVfCf9azQHpYdHCrX+SGUDNsQbi5M+KXluv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3Ej7yRyMEffDBIakIwR6bjCYCWlJSv/RLyDmtAJWX6vachLUOqaYMrVmeqqx375R8LeBXIP+LYZRK4y5tsxC66AKzCntczb4Z0VLpn34yNFBqSg+WNqssqNVKUuwM+3Ik5FMfFCux4/uIvqumQXvkKyppbRdxkgJYCPIpdDWtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=AEw3Vn5O; arc=fail smtp.client-ip=52.101.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqb4aM3ecaflRr3ZMlbZt2+1qr/xUg8TIuH1nY0prr0dPEcxbjXAfYqbit9wx/fnjMUH5nDvSFwvpEwbCVkLeBMNuHIPpnRnsPlNSPpTpfAlhfGhvKFXedSMnu8xiPt4qWOglwU2zGl4gaZU1BrFSYMA1IhnU0Bf33/UYnYULxO1+UPvmmICGfOrnVX90QEZ+RdutOW1rWrCFN/wVCYNMCpir8gfBAuq6tGIXQOag8O4uOrtACNDE9DSh4UAuRZQAiI11pJ3LdK2gKssb5GtwPnNj8zp6J9JyF41rGHAze739pAs/O5FNlK4zTrSlvLYc8xXLcIH7G4fESP9sMC0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SIbfjvZwmlGJ8kd6wBED2sYF457eE76aX7eniIT9ro=;
 b=Hy3ezP9FiFQON8ru4KCOOXk0/vhdztU7CKeipa7v32kM2QdJzp7wUdHlHekWegIg6srhilDqEK2hKdOmg5I0/Kgd9S4rTvTLNnsvdjtNfsyk4hqlJok/6JfpPMsfDNZod48fx2elqOiC0XvYTWcQ09iNVRNmrigTv28Vx/8W5dNCfuzayWSSpkaUJPpZBdvqvR2AcLvY6FzGe1dB2g+iUF1Oi3cuijb/D4W0mAOM44hV5smcXOphU9IxxzW8noht8qF1PE9/0NnVeD+lu/NfnbCT0POZnnzrnKk36r0Bc92elhLJD6aadt97xSXXXrbjcIiCoqU81LaIkirJ+7o4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SIbfjvZwmlGJ8kd6wBED2sYF457eE76aX7eniIT9ro=;
 b=AEw3Vn5OIu6ni/3e//XGB9eE5THPJEc9sDotfp7FqKv/09DUrH/4vbF6GhF/xKaM/0T2GVaP0BVxbf+7SbhB8Am3ZzC/rVjn/o8fKHjfyMBHOvdRnY1smVxt2f7U8z095zwxyyGCvLvw/mqLi5n9EUxldCVaLSIVPPjRzWfR4WagIGgDyjrhKwIeqjuQcCIlKrxDf8ooPR6qZYVEgMN2ygMZx40fmoRSqAS+ctcL8ZrF7GJL28C6YM2zVy/qF9iM1KOqXbr3hFarJxvr6fgU58243U4gHGWnr+HuPt+l6JWfkpkb2Cw/nrLXap2ab3V5NVc6Ip8wXKDkyJsYi95PJA==
Received: from SI1PR02CA0025.apcprd02.prod.outlook.com (2603:1096:4:1f4::13)
 by OSQPR04MB7912.apcprd04.prod.outlook.com (2603:1096:604:295::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 09:24:45 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:1f4:cafe::a4) by SI1PR02CA0025.outlook.office365.com
 (2603:1096:4:1f4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 09:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 09:24:44
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v16 1/3] ARM: dts: aspeed: yosemite4: Revise i2c-mux devices
Date: Fri,  6 Sep 2024 17:24:35 +0800
Message-Id: <20240906092438.1047225-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240906092438.1047225-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|OSQPR04MB7912:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 459462f1-725d-49bc-1d77-08dcce55bf1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zvJ3MpY/XKKF0xvff7E2prCKREOz9i6oO5wBHgkhj5O1vkD9QVlCG3S7uro1?=
 =?us-ascii?Q?GoWkPFhkWXYdGVgIPOFNZo60rWEn7Et9iZWsD31eBEed8Ly3aYd68B8yA3nQ?=
 =?us-ascii?Q?A9NLzSTIeSkl/UHgdAf1URmvi+GvmAgCRDCtOk+iY+whjoPRsC1cwZiROape?=
 =?us-ascii?Q?Nra7bjeQAK6OOVNQUwbxGmRCC9keAL3dXP7LEKJJvYexvyyMk1muuPKs5xKu?=
 =?us-ascii?Q?vTgzDfSWFVi2xyZmJ4ZX+6vEyv76PdU2jDky8LuhnCKVhFLdsXVVaxyjRrwE?=
 =?us-ascii?Q?TLwNn529WC3T0RY5HaNGhrtdbVOikIx7gg6ayWL33vQTek4s4Q/imk0Xu0aR?=
 =?us-ascii?Q?8eakDGA1EA9r5do3oKA9ZbrA0l2AgWv1J15dX2VSse7MsE6FLJk5tvwcxI52?=
 =?us-ascii?Q?2J/VelHPEmZaApGY/qIauRx9WMxIq3n8cCZqfErPKd4ooWlKEi31KDOp4b8b?=
 =?us-ascii?Q?UyV0HyzMl3oHWsNio7Okkvb/Jn7ThptnEK57EGqF/OYlquyJEvvtWT4gMp3+?=
 =?us-ascii?Q?DWyOL8RN748snuSdu0AORY/b5BqJJ3ZF7zikOS+3tXzI+UGTtqvKTRIJsNju?=
 =?us-ascii?Q?4oIw5BqYnZyfcbVX5sSobMeiMu0E9FA21e5+OisMlDpgFIlRPEZNRe1PDIti?=
 =?us-ascii?Q?RDEO+Jr6IGLpDhD+qvFps0QrxYIqcRhRoFSQF5p6EurZIoczSFENgt+CwwQM?=
 =?us-ascii?Q?FBIiciNNjgJHi5VsyJ3KqMrxZKkNnnQHepscDT72/ALVloQCbp4DdluOSCm+?=
 =?us-ascii?Q?cpIegxGy0Ag1urFcxIvlO4/3G2deM4v8St+W55FgYhPmcf9VkQLPGGmNcF6i?=
 =?us-ascii?Q?H1Sp1r+SvnSDpIr+HDv9Nx/08JDx9vewkQvfspX0irJ7mf02QYQptszCf0Wa?=
 =?us-ascii?Q?s5IC4j0LTSREAQUHGvTDvxrkLlvFFeYgY0p5+q++oV8NhxkBQ8hGa27PjFDT?=
 =?us-ascii?Q?1sKaGi24DorztKBewnAOxaCbsSBdM5od/t/lKiIzIqnJZdoUDA8FMNuuO+w0?=
 =?us-ascii?Q?8zpm1MUkXrMzaRai48Nc8hw9IdLHCB/4sS+eMQPglUQjEjw3AM2o5cvidQWb?=
 =?us-ascii?Q?ZUg56bQ+waqqbisF8mCaCdmW3v5dqLeh/oSWxVsRmqjx3FbWSynYOb7ty/9M?=
 =?us-ascii?Q?Il2RhlDOY1ekndnzoReqADxCZApgi9YaKI0CqM3LMSnGAMt6akQNuwbtZtuW?=
 =?us-ascii?Q?L8udRRT1q7bqKv9iSJDg5pFTp3vjq0VrYSJXt88xJCxsxOHh5f1NmlUO1kBr?=
 =?us-ascii?Q?bosHIP8zYAudTNLCOQFblqQ90XIBXTitjNmKnHCpxZ4vcMUOSChiI+QTgvyW?=
 =?us-ascii?Q?iPQnxoeDP4lO2935NQIDiDkJVwfVwfQ0JM3aWzto6t2QxNY6aLbMXSaJWfXi?=
 =?us-ascii?Q?hwSycErV59xyTb+R4hCsrdjzn99NPJq1ZixAwUNOHafQqjU8QSEdB5wPlBAg?=
 =?us-ascii?Q?rvTol8f8NI7LJiL4B1tWKljkbl5ECzUC?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:24:44.7194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 459462f1-725d-49bc-1d77-08dcce55bf1c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7912

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Revise Yosemite 4 devicetree for devices behind i2c-mux
- Add gpio and eeprom behind i2c-mux
- Remove redundant idle-state setting for i2c-mux
- Revise address of max31790 devices after i2c-mux.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 450 ++++++++++++++++--
 1 file changed, 411 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..96039ffbf8ef 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -17,6 +17,29 @@ aliases {
 		serial6 = &uart7;
 		serial7 = &uart8;
 		serial8 = &uart9;
+
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
 	};
 
 	chosen {
@@ -259,9 +282,117 @@ &i2c8 {
 	bus-frequency = <400000>;
 	i2c-mux@70 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x70>;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux17: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux18: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux19: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
 	};
 };
 
@@ -270,26 +401,193 @@ &i2c9 {
 	bus-frequency = <400000>;
 	i2c-mux@71 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x71>;
+
+		imux20: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux21: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux22: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
+
+		imux23: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			gpio@49 {
+				compatible = "nxp,pca9537";
+				reg = <0x49>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c128";
+				reg = <0x51>;
+			};
+
+			eeprom@54 {
+				compatible = "atmel,24c128";
+				reg = <0x54>;
+			};
+		};
 	};
 };
 
 &i2c10 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-mux@74 {
+		compatible = "nxp,pca9544";
+		i2c-mux-idle-disconnect;
+		reg = <0x74>;
+
+		imux28: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
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
+				gpio-line-names =
+				"","","","",
+				"NIC0_MAIN_PWR_EN","NIC1_MAIN_PWR_EN",
+				"NIC2_MAIN_PWR_EN","NIC3_MAIN_PWR_EN",
+				"","","","","","","","",
+				"","","","","","","","",
+				"","","","","","","","";
+			};
+		};
+
+		imux29: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+	};
 };
 
 &i2c11 {
 	status = "okay";
 	power-sensor@10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
 	power-sensor@12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
@@ -351,19 +649,54 @@ &i2c12 {
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
+
+			temperature-sensor@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+
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
 
-	rtc@6f {
-		compatible = "nuvoton,nct3018y";
-		reg = <0x6f>;
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
 
@@ -440,16 +773,14 @@ eeprom@51 {
 		reg = <0x51>;
 	};
 
-	i2c-mux@71 {
-		compatible = "nxp,pca9846";
+	i2c-mux@74 {
+		compatible = "nxp,pca9546";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x71>;
+		reg = <0x74>;
 
-		i2c@0 {
+		imux30: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -457,11 +788,11 @@ i2c@0 {
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -470,11 +801,13 @@ pwm@20{
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
+			pwm@2f{
+				compatible = "maxim,max31790";
+				reg = <0x2f>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
@@ -499,19 +832,19 @@ gpio@61 {
 			};
 		};
 
-		i2c@1 {
+		imux31: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -520,11 +853,13 @@ pwm@20{
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
+			pwm@2f{
+				compatible = "maxim,max31790";
+				reg = <0x2f>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 			};
@@ -554,12 +889,10 @@ i2c-mux@73 {
 		compatible = "nxp,pca9544";
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x73>;
 
-		i2c@0 {
+		imux32: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -570,10 +903,10 @@ adc@35 {
 			};
 		};
 
-		i2c@1 {
+		imux33: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			adc@35 {
 				compatible = "maxim,max11617";
@@ -596,9 +929,48 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
 		reg = <0x72>;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
 	};
 };
 
-- 
2.25.1


