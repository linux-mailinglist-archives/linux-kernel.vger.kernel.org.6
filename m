Return-Path: <linux-kernel+bounces-295249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40234959908
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3436283D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94071F9B74;
	Wed, 21 Aug 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Dj8bCYMi"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E411F9B62;
	Wed, 21 Aug 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233317; cv=fail; b=JuYkZByoLn123t8AAofWW93JUY0UkJ1yWbZefV/OZBdyl1xrcprSnGgABlkCvmDclPYmt3IxMQcRT3So39e3NbjgFe499OLHZqAKG/Z9nbagvnSNVQOTP2vePzAM7l+zKX5panseOZ7eb3V2ju3rK54mySRtAFMKdUDYUF5Gqoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233317; c=relaxed/simple;
	bh=Wbkb7AWPjYhKrtGbgOzA/rhSvxJ8PegMzEHm5IEuWnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aopVBRqdbjOBo4C4wSbicMRbZEmt/tYRY9l92OfSOc2vpqce9Ugp1Cl2H3izGuDgpfjUQA8ScFLXGATArq0pKEEEVKiPHJrGIcw6k6uBLCMtPHMYSk64ReliNmcQOCIM2zoeSHcJyxXQCLsvgc7kUKK2KclFUJTjrkMsQdNNEH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Dj8bCYMi; arc=fail smtp.client-ip=40.107.255.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RD4mWsU1hV3PXd9aNU8Agw1Wnwk6uq+RoeYDuJ9MZ/QO+0XualZjfw3Qilbuu4fGZtS5Czb+SSuNxtvwXp85xBt3/qskmruT1QaIbRd2tpQ3rEnjT27vYeIIXIcRBMl1xlr8PU3o6wHRz4DA8O6GCXoXELWf5CORmf3Fpm3q4hE3uNiEABfFjzxOPy+0voA1/tCTvepidujPL6rdcW/Th2IIKsg6iJKCDXg1ZaBqoKQTuRH6mgQ9MEtaRc5kAKQVOoUpMb4GWrBdya/hIxPla3RS68mj+gzfg5L+tSz1ro2xX584uWVhDfEN5eDWgMlukiViZeL/pi4J1YAGnIlzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0cbZAgnLmtnZUJUsofCz9gNyd7yXSZFoo6OAwbZAno=;
 b=mzTfiFqHfvIMyrLpvLu8vHxUMh/X8I0DBhPDV8W5SpKzkZbLk/pLgKJ/+W+sdl+OeivB08tqOJbD0uaG5/znxCiGcMwhVdCC1Fbq4YMLn+3UB6KiwsiCTY2IQxW6jRL/uvu+8BDknDHBiu+fNxF+RvcA5ZTOWd5VGuu0kAhF0gTSylNS91ayKTRGmk0p4zhljhdYJVVTKzZl/yjX2EVp5RvIYDoL6TeloQJ7WO685/w+P3uhEyq9KqvJqEv2GXfknUwtUgnkSP0VZ4aOEbaK8kgQZGQDdNL02odzDR6/fodV8EJgdh5gflsUjCK9MiEmu6I9uGM7bgHJx5lJ6abGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0cbZAgnLmtnZUJUsofCz9gNyd7yXSZFoo6OAwbZAno=;
 b=Dj8bCYMipW3SUgDmoSw6AZZc/k2bs9Xt6Z5ZnJFB6fSvjr2e4Y+UGYpnkLEqgcSNN31vRhkLyJ2bjgdmvuXGAmLncMlayK488aV/NlkCKNYmJE+EygBrBqb1uy/mtXoxz/b+vWiES7ycwNOUwqzitpu6G4lqJ7r/WVAHn1DYKWnq/ANYQavuZkO2NWGY595ol0qInT7W+6nzvPBe0MZsdYDigYNg8nlANxYlehUnIVM9SUhVtoVHEjQQwRaPM5jJrUZDnKlSPvTn9WsLfz6jUBif3lPGuBmPaIqktcX/3gAVXujERc27k9xZFJ64/0B37IKWp/1aQS+9N9lA2wBJwA==
Received: from SI2PR02CA0022.apcprd02.prod.outlook.com (2603:1096:4:195::23)
 by JH0PR04MB8154.apcprd04.prod.outlook.com (2603:1096:990:a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Wed, 21 Aug
 2024 09:41:49 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::52) by SI2PR02CA0022.outlook.office365.com
 (2603:1096:4:195::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 09:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:41:48 +0000
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
Subject: [PATCH v13 06/29] ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic change
Date: Wed, 21 Aug 2024 17:40:17 +0800
Message-Id: <20240821094043.4126132-7-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|JH0PR04MB8154:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a0e39e59-1367-4816-f255-08dcc1c57aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JX2MVuGY9T+r8gpWU6s9jkUft9s9ToePWknFSo+6uK9JIylGdWLbvS2hHYsY?=
 =?us-ascii?Q?Y0BJwfpn+O4bNHu46iRiyarlg0eIwNQ6lRpfeKTkUh4jktoBsvz5kTWxLPEF?=
 =?us-ascii?Q?GZYcm/8Btjlb4jRPDVtXJz5DJTGazEdi3geYAHEkYLOzPl2EfDpPcJEjIOj8?=
 =?us-ascii?Q?dYuieNC4HqV9i6cus5sXH+HeAxJ1KrvvI3P3Wj9EiCVKRWKZTNCjgjH8Ttk6?=
 =?us-ascii?Q?2ovJ9v2XBR0rlGZczIjbpofX/b2kTaxBfVK4aaMaooIzPcv/h4zl/WXa23Fw?=
 =?us-ascii?Q?kqHxJAcr0voIJa6J4Q7qWZBjggcyDfltsG/o/yjcEJIbQol8vR5kPMX6AOow?=
 =?us-ascii?Q?zTpkek3avq9GMZ/h3FOiQgANHvQ+OsnhpIylZu1mUI47e9GRDq6JQezqVeBg?=
 =?us-ascii?Q?RIY5LRN5uv81fdDNEM6clOPnfDD4r8vXz/WgBT9Q+BHoeDUf7ABIeonug0s2?=
 =?us-ascii?Q?PTMQcZbXMMx47HQkjng1JhxxUjIuAlx31c5823zmXZeS+fVSEUhzM9bHmkyu?=
 =?us-ascii?Q?YmfJ0RkU9SyJZFa9bEjWX+6XROpVyyTCeDG+OSfm0dZDQ6fS4iSmQLiQnOyX?=
 =?us-ascii?Q?5BB/RA2ZSV19G0pTEnBX8PdzSLKCJf1EUY7+y6Ht9m7az49XvZSnBYtrwP/A?=
 =?us-ascii?Q?H2XY0cQfTOOTx0zTWTL1Al4F7MmH+CZA82sgEhOzYmKROL911NCKZcljGZXd?=
 =?us-ascii?Q?mWJmQJnqyrVxM3cM1x1dTYJ0eAzabgYlfokmBJYkPwAjiSUbQLj4UfhpGDsi?=
 =?us-ascii?Q?ABDeFUX7EqM+OV5IVbIGzDZ6cWT3Q0yKe6Y8IeyyWf8KDkp418VXh8ddLCuD?=
 =?us-ascii?Q?TsmT8iyP/vQbpil1anlIZBbBGW2Wnj71DoxQRm42wxiHwKcRZmNOscHHhtl+?=
 =?us-ascii?Q?3oky+fYQBFTbonjDnN+FJHoY6hPN4I7q4OUrYGd1Q6+2wu5an5OdFPaifOEW?=
 =?us-ascii?Q?6qOJhnhfoqlzfiPQ4jX4rWTyEPsrn68VjAhy97a9TKXk8/+oBSGoOL23NHmx?=
 =?us-ascii?Q?6+M5wl+bdqq47yCuAelYvivV4wP4qeE+rWV3HxC1mcF7/gwZ3whNuymLiTcl?=
 =?us-ascii?Q?4/+M8PlosBKYC+N5KyaYwuV23xhqMo9QwqGzlMRWmUrVJ2FQg6JyymQa715M?=
 =?us-ascii?Q?sw0hjI6Fl11dV9luj3L+efmeun63EEPPDBWcpj3ZQfhStpfq1BIWI+XjITtr?=
 =?us-ascii?Q?pT65C+R1dD/zidFFD8AVy2djOFj0bvmIM6/2DlAXvyCJrOVtfnf0XNWDaC7u?=
 =?us-ascii?Q?j4kIWtd8iUyANct662VNHvliAdwswiwehbiMZ7Z0kAKMrb1Nj5mAI9zOzaaM?=
 =?us-ascii?Q?i3un7JE5039SOV+LwpWv4oIsEqn9bnW7xjAenbYWjM0NQ61wTC7HxUiNBkJ5?=
 =?us-ascii?Q?0dcOIAQNmWjMaSqwrmMMCTzZG9BSpXJf6P7EuTqx/nT5Z/r709IYVdj2P7Pz?=
 =?us-ascii?Q?O8Q6YUApAVfiHRQ7kTfuO+VJUAFiirjc?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:41:48.8247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e39e59-1367-4816-f255-08dcc1c57aee
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8154

Revise power sensor adm1281 for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index e5354efbb903..7b79fcd77c8c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -176,8 +176,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -193,8 +194,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -210,8 +212,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -227,8 +230,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -244,8 +248,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -261,8 +266,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -278,8 +284,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -295,8 +302,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
-- 
2.25.1


