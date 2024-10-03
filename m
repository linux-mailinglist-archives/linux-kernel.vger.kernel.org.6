Return-Path: <linux-kernel+bounces-348692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB2B98EAA7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3642870D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01C813C9D9;
	Thu,  3 Oct 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Hz0zneIA"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2042.outbound.protection.outlook.com [40.107.215.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD5126C09;
	Thu,  3 Oct 2024 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941388; cv=fail; b=E0BGm2JDzr6nRTd9x6o5ozVm4IxhBajaTsekAZWrTH1dD0bFWSzM66xZ0wavF7RnPFccuvXSrBCvDaxa9Zx9xnTD+8v5w0Co5cxHvxTj2ER2v1vW4zfffnz2TsquFgfzEdpQLjgSEZX9YCOuNci53+G9ztQvm/qlBPrVZ1kXgzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941388; c=relaxed/simple;
	bh=mcc6oiTh9Y2USANwo//ga6ueqx9r7gTkpsP2lxE0AFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGAx3oQg5GTv8GuqZrZd8HVgMtEGmr+sKCgUMDe/obhGPdnauJ3Li6gxBq3JE2uDVn/51AAgi9PmFjOgpzbRKbgSEe0u1acq81me/bGw94uQM7eHgtxDyY0HyraZZz38gjEiWWOr3r3k1K2UNq0RMtJq1TcQD24N1wyRVm5yIiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Hz0zneIA; arc=fail smtp.client-ip=40.107.215.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgB1OJ6YptkdRXOHEl1JBocLIAWo8nQPyRqq+lNjP0qX7ZPq2jJbjKMHHSCMmsws/myGP8+DTXuXBgSCDLz08gr5JuUElr3AeVwMRmo6LGvIyHWSRilNsUC4zRg/SsF+22cC+2eeo2YEtQk8ujLPydOVNVHgFOv7lWYqRedpQNUucpmdjFGitvjYRReiIIPHPTz1RTJb4cEw04lkJn8n9DX0vXCvEmrQDy/l/8zGTVyiz5icHkjYTdllbtVRrFsOypl6QIDQVyAzFBO8tvHAn/0//GRjoSAKGsOYFg3X4YySKKh1W7U+nVGZcHKbhe8SPfyEzCkXYY1hl1Xr5EqSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eh5xX0fEePzrG9T557ejz+GmoYP2wzajNteZogmcISo=;
 b=TrUTm5ubhxStrK4jycm08K+YuUJZz/gcmRQVOsnM1nQUqiiIQNaRRcUjZEsVYMpABql4vVragKsQo9bhbvRAoEOiSCtMKE2b6WFkTc5jM3QMBI6RJUXxnM1WEGAeB5i+EGLwfpmlXp8Da57AJUTdQDH6cBBDaLY+0tZbBK0VVM2BT+QfFXlWXGIfm/Wv97X3hwmxohrwluvBPgrVmeAiur0dSyY1CEJ0kHsXiottjsmE8OHolQ1zAsFEg+DgCaFDxlfoMJg8l6TlziP3ZrKyq2ikamToX28JT4QOOlNbnqCPDJMLk2kxslTHnsldP8d61BEqC7eh4o0g7vA5E6/m2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eh5xX0fEePzrG9T557ejz+GmoYP2wzajNteZogmcISo=;
 b=Hz0zneIArmBCdIm42bJ6QrOfcCSlI98lnVI7vEgH97+10GyVDizw/ZTlyAyqUWQBgd2hpIDZpCXJfYjbz/q52jqqsBtOTYuCffct28Va1+6OVvmLy7Z9qAIZNSIZTF0gHFzQ1lsPUvTU25scWad74wUsxyL3VjKe7B0/hj/c+9tgh/KuADaRmTVW+q0PNlFxj3fH0OyqQcKBfp+yI+LRVyJ4kcuiJYvvN9R4eP+HJFo/C/wR03XNYCZmQrvbw2VqwZpKxoEkgZCTr0xq35mZiiTAcVrcgQp3CBOODejISuamjyhNwRpUKPZ2sYfWw41iDzXMXKdlbXg42OlBdNG3Rg==
Received: from SI2PR02CA0013.apcprd02.prod.outlook.com (2603:1096:4:194::21)
 by SEZPR04MB6201.apcprd04.prod.outlook.com (2603:1096:101:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 07:43:01 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::ad) by SI2PR02CA0013.outlook.office365.com
 (2603:1096:4:194::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Thu, 3 Oct 2024 07:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Thu, 3 Oct 2024 07:43:00
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
Subject: [PATCH v3 3/9] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE on Spider Board
Date: Thu,  3 Oct 2024 15:42:44 +0800
Message-Id: <20241003074251.3818101-4-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEZPR04MB6201:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0b3b55f2-52db-4c08-57b2-08dce37f01dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QfoUGf7H1DvZzJFDWJCoek16J08TkMpHgp0HxzS3lmc9AO8PHCLKgngKXg5o?=
 =?us-ascii?Q?cEc3IeHns2Wl0OQPWMuOtQpVXv+jk2jEpGtDOAkP8oNTdccgwKur6vuB35DI?=
 =?us-ascii?Q?xEE+UcOsjsiyJu5dSXa6LdXDmd4g63e7A5tcHkPM17/HD16AL9RxGTk9IVMv?=
 =?us-ascii?Q?gSsLoeVzt3Eu4sNGS+o2L/sIXQ1nbSFUoiDWN20XAKgU05rJKT13HwpCgzSw?=
 =?us-ascii?Q?JDguZzI5e7dX5/LfWH1aqCMSoSbtemRkymaLvcMA1HnjinjpAAIv0uZd+xxO?=
 =?us-ascii?Q?ySoy8vVmHDn4Kzzcd5npCtuA0kKtGeO/GQkihF+JB7gEzQejxNGQ6lgMt0iZ?=
 =?us-ascii?Q?lw8tSrAT9IQJS2c4AHiXizXTarDAshxbjVidYMWOKYfiTA17svr4txBDCUOr?=
 =?us-ascii?Q?voiLWOQVoDwLFiZVqBL1sLsqENZ49VJZ2OxgwNV0qGM+hptCCo95sFUe+MN2?=
 =?us-ascii?Q?YFYtfugqbSQmmAmPnnoTjyF9GFeFmGjJ1blA347NFFMqwLLuQw5+2/lJkEK0?=
 =?us-ascii?Q?DcIWvGZSDK7SDWBYPL+enva6ptJNBJD9cP7L5ydPdGeBuNsr+0PpPovsnLNa?=
 =?us-ascii?Q?3DjIj0UJa/8DmLw+yDag/RnrPRv70qZwidvtJJTekCOzlv0sRTuddRiVn1xt?=
 =?us-ascii?Q?ocCI/T+tZIFNo8E6OyodyDeEay8wdhoog/Vr84b7oZEbPmZq2vOTlYa1gH/p?=
 =?us-ascii?Q?NRZhWzhhwb2/ebrLkXCBsYj4z0Kaf2e4DsuD3TqZmR6rC0ZmYuroMpDMzH/z?=
 =?us-ascii?Q?8GGYYVVrz0CeYPt8NxEit92xYCvmrA4tZ0ABjGQtXAxasSfpPMz1ufDRrPSe?=
 =?us-ascii?Q?cH0E0L2Rh3PGtKcDMENOpwIa4oXtW+SVknNxrzxDEjNhgTbFTFao/0vcdY7Z?=
 =?us-ascii?Q?nzuH0XxhBFDF7OZAzTsxe0O1FQOH1BGn3PZw8Zokur0xoesRdxpmzDh7pFwl?=
 =?us-ascii?Q?MG8h+Qa3zv0UyoLSlT2eoSEoPY1591tX1yHx/gxi7frK93Sx7gAhsFc30qMy?=
 =?us-ascii?Q?ZuS55M9jdciu3iklP9+fbEQZFRkB3LaReojN/wOcvhfwYMuIDuXR5lITj7iH?=
 =?us-ascii?Q?njUCJisXB4UZSlXMYogRsLnV+Vz2QYfkHh/xFWZAvI+3lDg1HLbTzUAhy5bm?=
 =?us-ascii?Q?CoI9oMxbRhnUEYRb3umKj04evNesJVOGvb6QqED1ijY6nOgsu1GzhKaLfDqc?=
 =?us-ascii?Q?mMLhLuOGB3QPvXJmDqZeEJxKB/qaFNHV7NfDOHCq8O6QMjh9io7J7Qgh00TD?=
 =?us-ascii?Q?ZVVajt0Wy8xMMkIAAifDMIX4oENsFlLO+xV5zLdvz0tLSo+H2k0M6S8a25Vi?=
 =?us-ascii?Q?XM4xxBnKRtE5d/a2MFxWCNR/ei+4pBtY0rSwvzuSfrE5X/Z8sbX1BA1ssfVA?=
 =?us-ascii?Q?BP1CBMt8TC6jgGQi1NrbfdPn6MHn?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 07:43:00.4305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3b55f2-52db-4c08-57b2-08dce37f01dc
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6201

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add I2C mux for CPLD IOE on Spider Board.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index fc8af704fe20..62fe4d513852 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -30,6 +30,8 @@ aliases {
 		i2c25 = &imux25;
 		i2c26 = &imux26;
 		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
 		i2c34 = &imux34;
 		i2c35 = &imux35;
 	};
@@ -773,8 +775,72 @@ eeprom@54 {
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


