Return-Path: <linux-kernel+bounces-187152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372788CCDC8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25FAB22E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6446813DDC3;
	Thu, 23 May 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="NYkbossU"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011004.outbound.protection.outlook.com [52.101.133.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8713D899;
	Thu, 23 May 2024 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451462; cv=fail; b=XID9W+YJ0ubKY3C0wAFczW7OyPwR3eRNoktc6s7EMAGv76xLOR/BZJnlYXs/+beASqVv11jzqty3jn6EwR/AwowntvRhs78Y/u9FJHF9uHqE7vRfljxVzmu2uMfl28h5+641PhCJO5XnRRpfsUL/p4ChHJZTzTr5ijdFBfvwuJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451462; c=relaxed/simple;
	bh=9rqdb3bweZo+DREd0kHWSfrwaBZM0bC0snPT9FyLXh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7gf4kQJ5XE7apcbS083Lewu19UFbVxZCXMyzwIt+WNlhkW7B4sVzhR/6Ag+xoJpFmy9yUE0uyO9925pj3+G+ZL2xZKrH6W7BxGYuzBtXtUWq+KGNS8AQQmOSO85raIYZSmC/JNqjY0RvgDoNGsXfRhlJManoELoajQafzN2KpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=NYkbossU; arc=fail smtp.client-ip=52.101.133.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgWBt8GRVVmhzMTK5rg/pTSDCAoKsxFpgeOvBftncVttQuEYXP/YkAUGyoKDLoLHOn0OkqSl+FN14NL7/RmLeV4IXweooxzKPcd2Dyg+WOy2BUU79RyaipKCPRw7YVywORLgbu3K6V/EMd9MOFM1wwqWGDKk2lJesRWftH+yO4v89H1wzDIuN9s+zoSUWY9/jQsxW/cJPupL2MeYI5ooKg7aCxhXfua4LqFeappOmBJaFzpwIDPUUzJZbWsW3h/pAnz4/BG1H1G0rEZ//hyTxKI82c5sC6wUjmMwGplz7qLYcTpHdClr1HpmUleCctRpsQOnkGi2RmhbWcU39dogug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB96pUAHPYpne52+aZSEHu32dSiQWPF5XIERkA9QsJk=;
 b=N3MZc5hpPt6Y6/5kyKzPOxhrm65elDnCVSB8XEsafbywaxMIeKHQH+7BOAIkjBBrWN5aycZlzWT4mP9WgC+fSOxsUDdOe9VNXlhDevIbbgB3SEcaKMe21XLhI7uY6PeR5erN5H+vNkcw+o7UmU35mGtRDg0Ufbm0boztdVAiM9yjjjexlxQ/d9dadLQ/BfAGCobBFB89aM6nKQl/kZ5q7gy+y/NisNM9HmcSoQViufUfzJqc7WsfWAN7qaJmYlt9C/QGT2gq9mIBjbkOcU0jkLyrDIYRv6+t2yH2hBDTqKmbQ7NEJp9MjCzwnGVk2Cpq1kgG5icDXCYLGBvFM6BRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB96pUAHPYpne52+aZSEHu32dSiQWPF5XIERkA9QsJk=;
 b=NYkbossUgSdi0aTVVvk0WIE9z8BcdYP057A3rRA9HK4YKaSi1tibpr0ApninLoor5mf7QD/z/vtNogMliryHdR123Vgd7ehdNLE5mAXp2ea9TGOLGbZxcFgJczNs6x89CnJECHLf+gicgI3daFm45qJMCtvf/vzZ91NW05tucfSU/YNnMN1mwJFRWfO9O63dEm/4o7YB8Jy3FARowo0loKdnJFTf7LtAkcjuJ9oOhxKFJ8imNFZk+3/b9dyhM7uGdNPk59BGzPqei7le/uH7rHYJpI5sJEBrt92w2inhSaGYOiofC4lbhYa9uKnGZY3uWRJwFml4OAlKKEgdJSbB/w==
Received: from SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24) by
 SI2PR04MB5893.apcprd04.prod.outlook.com (2603:1096:4:1e9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Thu, 23 May 2024 08:04:16 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::29) by SG2PR04CA0162.outlook.office365.com
 (2603:1096:4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 08:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:04:15 +0000
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
Subject: [PATCH v8 07/23] ARM: dts: aspeed: yosemite4: Add gpio pca9506
Date: Thu, 23 May 2024 16:03:12 +0800
Message-Id: <20240523080330.1860074-8-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SI2PR04MB5893:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6239b967-ea52-4cdc-a219-08dc7afef116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?70nREUCNsdTWtrd89cpIV7tcDvc1iJDrhkEYaCugye5BPojUNEIUgJCsAncO?=
 =?us-ascii?Q?cHMP5L5PoSETn50Bs/qPJeeEurK4cZZrtuXvih8g63ZU/XuVpf0J12qJcLjD?=
 =?us-ascii?Q?x0kofI1TS3Rftp+ixmoPYHwxnF8uJCBieRzZvXe8PJH5ex93NFoayrH+mKtB?=
 =?us-ascii?Q?KiOfgowNhq2js58avs8DDW/xiLqPDqcn54nlq2U2RdiDvMP4WcEwF5bg5J8J?=
 =?us-ascii?Q?pt7/P3MhZcSReJHPT+9sTREH00m1bqLVtKU9ewCh8hlCudhmYFe2D759OGV2?=
 =?us-ascii?Q?E0SDbDLx0OdTzRe4v7An1/KM5oRLhuGMqR0882nJFWmgrDVJG6bATwWNLr+N?=
 =?us-ascii?Q?8OytaPHBJcDvu34MyZkrivsAw+xwy3/QRX4JQlZF4NXiQ5UfwWxKB+q/OksI?=
 =?us-ascii?Q?6gK6fVW4faydj2TWBan7oi9sNvQHbOenMTdOZNDzbnE1G8h8TOirafp3190H?=
 =?us-ascii?Q?9lQQ67S7zGaaXPhbIANTgSDhP+82isz04iZQk3X0otv4PavUTaI+DAYu/6Rm?=
 =?us-ascii?Q?rbe/P6QkepfN6xUxZT4sIX0TErQUgc2JVYe5cAoO56hCWlkEl8bnkXPhPavT?=
 =?us-ascii?Q?hTnU5G4HiCctPs9CyIkRSfzul07hw26xAVxypaPhZH1vpHsTQ2eSDGekKC3o?=
 =?us-ascii?Q?b/3U3Pk/JJ63AcdWrvPLPPCf6+xVeF3Six6GRdCkwnFaS4do76IjIIo/bNsa?=
 =?us-ascii?Q?bhmTVlLJnzl90xEg0iked0GUW8IDnhFzUaXfku2+YEM1lBIc1sScxC/VOrnJ?=
 =?us-ascii?Q?o/Aue5Qu99mO7C2G2GCgnIzXUy6A/g7Clb96hl3a2yIFFT5y340EDZztijpa?=
 =?us-ascii?Q?Yi5hpfzXMsO7qInbszQuJZZvCQwJTNMjwFUKzqKtU2Kjg2Te7LiegTmI4V0t?=
 =?us-ascii?Q?XOyU5+iUF2vgyKdQ+mbWBWeRUanLyOKlkqVkQE1L8qWWoMmxCFWdHFHkaolh?=
 =?us-ascii?Q?obHQPRwD7M+mS7Q+WLyo7yJnEtP2WHSEhCTo3XxXjqj7GcfcDXF4NtQyHL3Z?=
 =?us-ascii?Q?NRRBhEJ5ywq6gGm0E16jlksH+FMT+6Ca9iWxTQFRr9aYo9wDiBs1Vi1EcjSc?=
 =?us-ascii?Q?HJCksl/tW8X8QgpgVf5zWe4QIud8X6ANv4QPjA/r6dHE6+I59J5NxEecUhSH?=
 =?us-ascii?Q?ZZDhzD6bbQJLJZjh/oBkus3yHBXgwU9of9ECQR8FbQH1BnXT4NBSl1pQnEE9?=
 =?us-ascii?Q?QoO1dgJ5HVfeUdntS1xV/By8xOeNdwJ27Z4VeulqrLCQohi5ZB7/gk9Aj+si?=
 =?us-ascii?Q?z7TI6Qm3zD1wc/yigTUz9W+wNEXSOq/MQv/WVZlqxmVrF1joR7p5n6sv4d0G?=
 =?us-ascii?Q?gr3vhY7Kgkfq0JKmChKoB9a9zVka1A+b9zVG9bmMdRu1dasFI5CU4zPL6MDg?=
 =?us-ascii?Q?jRh75X8=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:04:15.7810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6239b967-ea52-4cdc-a219-08dc7afef116
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5893

Add gpio pca9506 I/O expander for yv4 use

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 252 ++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f0f714c7bc77..33dcb2451ae3 100644
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


