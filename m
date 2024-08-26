Return-Path: <linux-kernel+bounces-300797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3095E88E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4F21C211FD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B7812C53B;
	Mon, 26 Aug 2024 06:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="JhNRUQgd"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2084.outbound.protection.outlook.com [40.107.117.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0C84DF8;
	Mon, 26 Aug 2024 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653489; cv=fail; b=AvGt6/yeOVMwTu8h8E8cHfOqAgNwHrOmP7u04/no/82BwHrFaEIy3+wiPu2O8EEDjbWVC7oHb3OIMUrlaQSTM+mjm4roIUedN95X2xPhyx75xY0V2wnemhd4XBMqCTPDVKGjvVq87ULrLgyg8WBxsq27/BTAk9Hiv3KrlpKJfDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653489; c=relaxed/simple;
	bh=Wbkb7AWPjYhKrtGbgOzA/rhSvxJ8PegMzEHm5IEuWnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxjRd8roO5HZWUUyuy2xwfuiY6OEe3yeiI2PgA0GkF+WdLKeFVY3arZMCESmyDLwSLtEimPuTVjxx1Zw9ZSO+u5LBbpk56Sb3OuWO/BBWtFyWXXdi3kgQYgE2wSpsz2atUz/ZP68E5oXv+ih4Igvx0fSEVFo4PbkEnx/4kWtTUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=JhNRUQgd; arc=fail smtp.client-ip=40.107.117.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hf6af4AWzDrKy7nfrfmhriTF7qvYwugR7hpZohdejcFTwS240zT9J82CWnWAajEw9SSexPw5C2fuB424W/iQsQ7fbuWlnkiqv0+4eKlHezS+XhEHCqdCNGdrV31U7x8Fyacm0U2RTNM+uGROJaCZMvAFNJCRF+NXMo2U6WCMW/XfWum7wIIaIniUxrqT0ebIS4tpqMxEIB14KBW4nGpaNH205eNtoAGa1O5l3gtx/TinLhZYbX2Ch61Zoo3lS/dwTPViDCV08nozZX5OTScwNB1UZ29faosu0Fxgybo6Xym6R39FLHq7zK6f64Z/oKw3UmgE3bfrX+Z8wHLNcOvmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0cbZAgnLmtnZUJUsofCz9gNyd7yXSZFoo6OAwbZAno=;
 b=NGCTleysXJ5iUv1a251jcQrTdx7D+vE7SsTCl4UhUM/2swGfd/7Av+BVSxuIhkHUNi+UvopLE/0GAMtxidIpqU3E7uj2X7pvkzsBqVx883HZGN/eK9GTlbEHo8xDZ9q/HqQjHCJvdTK+D0cV9BZpZU6VGJS8JXT71FE/B+TmXoSbpkV3z+O9iSrCuYK1+45U1/yMQvqDg1SWoLZKMVN+0QzfsRdhiHpBNGzCHQ5TMPTa3iJFLQ1iWX/VrdRkZnDSmykwlc5sQstK85+ocgZSenjwoRrWaWv6Aqstw+t8m2rL9hn/JMsGBfkdWDB37V2MNpi4Npr8NmjJRo+VtojckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0cbZAgnLmtnZUJUsofCz9gNyd7yXSZFoo6OAwbZAno=;
 b=JhNRUQgdV+Beri+k6NjfAjlvvDcC0LYBS5yzwBfnwoHMONsMRx/yfvlpG8o+2oOuVTMEsch+zTyDdJfOE4ePolae/cD68PeaRuQexToT9faXEmvslGo/FIXL4fCDGkHaXJpGUF6kgI75dbN1tUt7lyo9XJji6Kuhd3+brhwVVKEL4zOrUBh2tLdcy0AuVf2bE0Ko8tLpTwziSsH5bbtDn2rKiWn++T7v6C2AeQfCIKG18EKlBk2jmORQmxbcnyIM4RIGf9GeyBj2MuxgIPvRDN3xFndnowwjAEfMd32o0T7SnU0wzf07u1JTmkqzZGjEjj+TJZGg0YnC6MiO3a7yCw==
Received: from PUZP153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::18)
 by SI6PR04MB7918.apcprd04.prod.outlook.com (2603:1096:4:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:24:43 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::bd) by PUZP153CA0016.outlook.office365.com
 (2603:1096:301:c2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:24:42
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
Subject: [PATCH v14 06/31] ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic change
Date: Mon, 26 Aug 2024 14:23:40 +0800
Message-Id: <20240826062408.2885174-7-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|SI6PR04MB7918:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c2c74104-eebd-4fa0-10c8-08dcc597c5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y1jwRH2cgv8/RISY+CyQMiFPNeu2NWJjcChzpib08WI9Np2Im3JRFQMkJLdZ?=
 =?us-ascii?Q?6bLqQJSqSjFdtmk7mjP7GOXN/odqb1fb71H2C7tE3c9LZwn5WDs/SL27BGOy?=
 =?us-ascii?Q?QBxivSFIImTyvLJiE4ViRpr6+KF4Zb9BpbNj2FP7xCcyi7BsHB/dNjzlo5x4?=
 =?us-ascii?Q?Sy2f7SBARXRtWZgNh9HxaljwlVgf3qwUTjgCRGEG7eHv52m9I5pUs/euu5CP?=
 =?us-ascii?Q?IfXtx/OY3n4iriET79LwCF+hKlq6JJPyaY733BTvWWEwjs6wym/OEBl7nLhK?=
 =?us-ascii?Q?mnH8JrAQ3258kFzYg22jLkd83NWZn3CmglNqTSkEDIlwYErXMJAQLG5hM7kH?=
 =?us-ascii?Q?yFJ4CkxJ0lCw8T8rg7Bh6MjdwyQW5gwO49FbkzPXABCvckpYRinnYYFA6BHu?=
 =?us-ascii?Q?cLdT8TXUnmwTPsbVtrroeMsoSH2CBkFwms8DMgBxHx/Jh60LCicyFc1Y+Uip?=
 =?us-ascii?Q?ejftULfJT7KjhAMMDiwKu6ZFYGrLrl6lgEt+9vvWqevXq0tWpJ53tsKUM8jY?=
 =?us-ascii?Q?COa7dZTnBdf9NoaeRRrq3lREO1GhQFVtsLDLrOjnWAmH1wf9qhYN4AaUvq0Q?=
 =?us-ascii?Q?rup0yLd0WUeTE+FytRDxlqvOGAhGsWF8cHR0/R8yGw8yOAvwTYzGU4di/eCP?=
 =?us-ascii?Q?H7ZPvk55sunEQqD74i+YXtG4RaN6L/3OEgQ8bDedU95MRjv3/a/ZkbzThvTb?=
 =?us-ascii?Q?FDydJ5swhZMddkMe+4hP39YSU3OeLoQ6NEXywlCgIB9A5JryWdhI0LNm86+F?=
 =?us-ascii?Q?sErQq7JT4BGim1cc3Y0koeDks2GWfyBY52UwNwohZrq6bsKGWb+IYAaN7H+1?=
 =?us-ascii?Q?CAp1b2VBlypchaL4bVzfXuUEDzrSexcfCk+Z5zMd9MHZbtGbnqGzGiJIN066?=
 =?us-ascii?Q?6vgNWELlGPWlIwqAn3wUGh0wQWcSDYFSWnJ/3g1/ue8KjEyKcGul4lIdMQga?=
 =?us-ascii?Q?CyM/RQsrkGa75lkpDR1REQlp2RoUXf5xSsOr06KzEx+kWZytd+ZlEF+jNwKL?=
 =?us-ascii?Q?jdKI9j7GAyxBlniooOmPJc9hMz1TV5HYQpG+eJN6nQd2u4nI/8wNn/sKMaJ4?=
 =?us-ascii?Q?tJ5ylB2cHjkj5uv0yzbBSz0izISt0nHPWN/VvMrzt3PFlqgK7gbE1UNFLtOQ?=
 =?us-ascii?Q?9mModfw/CoOSfzf++9d8T3nxoQUfP17+bEaGYpCy2Utgo07kGaUbl+2iheZ+?=
 =?us-ascii?Q?xHunzPU2Iw/O1YYUEW0Xt+6/s4xNOT9auTHAZpnAXcPfPSuVNpMYd09MKyWC?=
 =?us-ascii?Q?9qJeH1XxHz+YiHbTrfU1aBYS6UAbIXqHsLrnMCqQpsG1owIELwIp5X4pujtl?=
 =?us-ascii?Q?AwGZu4leU1IFjCxA82H0wrqiHyWgknQWHIVIItSYq/L4sICge9xNN9itH78j?=
 =?us-ascii?Q?aR4A0L8BM7agM6s9jlKcJtKUcJ6jtmaQj+uim8QAMNF4b+ekQJ5Vei9AveKR?=
 =?us-ascii?Q?R+o0fgq4rWwIRXIj8fI8QCATOEdHCQKT?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:24:42.9092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c74104-eebd-4fa0-10c8-08dcc597c5ef
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB7918

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


