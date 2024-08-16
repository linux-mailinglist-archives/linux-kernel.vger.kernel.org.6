Return-Path: <linux-kernel+bounces-289387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F65A9545BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1E5281BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD61448E0;
	Fri, 16 Aug 2024 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="eoxx3JBp"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2085.outbound.protection.outlook.com [40.107.215.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB515B0FA;
	Fri, 16 Aug 2024 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800371; cv=fail; b=poqQryGoPHs9iG2nBTBkik6ojxTiMpnkpQJcun7OVscwgesHyDNquqtvEmQWNMG5hqFz8RA1zM9/vtiJRO2HLyVxEVTwEgfreQbowFCpzQlhmYE07BnqiCgCNVZ/p+9gPxKfThvQnQDw1omg/7l4IgUSkhdAOX3wvwZ5fiKdlWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800371; c=relaxed/simple;
	bh=CiwkhpR7VbJ58wUM7Ct53vT3yoEHw3YDSjBZX8BpqGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6OdoDfqy6VxSPRjUbmGqI8Xecx73GQ78t9vTNCxhoSTjCGmfshexxodaMkTYb6Zy1TJpH3SzoIc7CkmPMJHdqSBV7wYi4tyMGVonVpJaOIy0dY6VOQWYuvquGz0qyarsmuthgt7na+6RzEvqZisrbzu9WFMkKyFog/ZALfagtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=eoxx3JBp; arc=fail smtp.client-ip=40.107.215.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXuaYBIKPXzpcHWe1z88SpSlMHiv3NLlQ/xq2SAegKn2hp7usoIcRdvWbmEr6EC5AF5pbxa5HX0fcVGYo5j8ua463GqV/cRlFtqc97wHPKh3SWq+l6Vv32bNnDJXH0kzmq1+UCHltAbp0DCFX7VqFq9jDXR1dlmInMw8EwEp0QR4K2v7pEybfPlkVSLw1oZc9SPvYlBK8cK0sMQk1PQ+cVvFt0AG1fAjLPQvkdKI4xCbIUmGTOCt3eGmCGI+m5UzGKyzNQol7ABu4ill2zhh7q5OFmZqige2Bw+Xwv68wMcZNL/8dfuf3orYemhUMnlNhjS9z6TX+VKcYHCDv6p7OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrtsG6giv8Vmzw5ONrss4xcIYIDPtDHUY7eE3zbiJjM=;
 b=gxQ6vWQm6C8MR5O9IKw56R8Fn/K47ujRBaIrkpztSEELy4qTff8BQ/oa6OGO0xmBR7afoRNMwiPlQWc/pc502wIAzbPjZpu32Hue1gWstV9OU1Y4qpcinAURpdGld3qkzVP6pomHnuCYjJvMLuobKC3uq4arbnWI5X3owRrsHHp9wntkrdowPJf6U0kYj3liMC9iY7K1ajmOeHBxmTMw1SZYqvkxaXm4ek5M+ikFgrCqWf1NXTsK8fweRqu9dxO+CCaERxRcnOqrFOCcQUNUJ+ETGZiNexMjeiDTrZzoACR47OXqRCQTSJEGcjoen2kBLOk5kSu/LxHrX4y6d9YFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrtsG6giv8Vmzw5ONrss4xcIYIDPtDHUY7eE3zbiJjM=;
 b=eoxx3JBpDdUXACAofbYvHBCvon6wLR3ogY+eMdPLFelLQzSYDIRN4VQKLJFT9gnC0ZSEfq9hICMEe2JsnHKrwOe3cn/bcyWKI5EfJi+24l+WeSjBBOjaj6ronJRLIVg68JhLAtNlOTkVldm8Z8xgzy0/H/sV7Nifnxn1witWKQcD2LCsieVSkY4kAlmAumBWk5QhSHk3f4lueg1ZTIY+Fmue+RlNRrLj7SA1OPGx31+8d1nlTNzvXhV86tHRYzYHCfH+KNatVfRR4PXv3X5Iw2hlaTx5c/VNqnsvb4AcoCZ6ql9U9UylmSVD1qYQuZqe82KiMleMaUE3L6TTiVD9TA==
Received: from SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) by TYSPR04MB7521.apcprd04.prod.outlook.com
 (2603:1096:400:46a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:26:02 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::95) by SI2PR01CA0048.outlook.office365.com
 (2603:1096:4:193::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Fri, 16 Aug 2024 09:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:26:01
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
Subject: [PATCH v12 21/28] ARM: dts: aspeed: yosemite4: support NIC eeprom
Date: Fri, 16 Aug 2024 17:24:08 +0800
Message-Id: <20240816092417.3651434-22-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|TYSPR04MB7521:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0fbeac4b-4b72-46cb-20f4-08dcbdd571f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5W++W6CyTFOSiP/D3un8X1ZitDiAPrbiSOAgVguSG5ebR62gaQ+Yfm4Mhmcy?=
 =?us-ascii?Q?0RH445skVfd5ttWijkHFAKXXN7eosERa9p9S2Eooi2sb6qR/RU1aukjpTCRq?=
 =?us-ascii?Q?R1IUWYJPRvFSjF4G45KV7Xr9MDWf61/KROvsGEnNw3E8reidVghqRMu/euR5?=
 =?us-ascii?Q?wsUOdq5mAkQ1ay+Xv9w9HmoxBv46HJZ6Vy+QqLjU32e2QshFxW367g/sA9MW?=
 =?us-ascii?Q?Yul0JU0J4V0o0lfxDW3SZcThymvv+tZLX9gIGQesYVaEs8BN18lq+tc53j61?=
 =?us-ascii?Q?hsR5p3RhWG7VBZ4MbGC1EMqOkYkFa45C9v+YJyvth364VzbCmNykEKWJu3D6?=
 =?us-ascii?Q?7fiRKpuvlK86ZQCQ0w7LdnYx6nDNy7RLxA+o3gtVlDWE6swcSJHt+W7kr7Kk?=
 =?us-ascii?Q?AVrSKLtFNnViH9WOD2iOZAkv5O4V6mqdZyv3AX9ccnfh/NOcPbHJf39i7N00?=
 =?us-ascii?Q?o/6K0gYhQp3FVrhrhbdJhssu+rhb3joBcYMk/xYL0rVtaMTU6nPnQVSlMNAi?=
 =?us-ascii?Q?ABfQNyYbzb2EEIvcGgeJlQ2TpOIJuqI1kC2+/d7CaXd6qz+wR2p7g2CWS9F5?=
 =?us-ascii?Q?6cYn9dBROY90uGP1RsboZtrMeb+eXfx6XpfwsLKSoRCg//iF2Vb2P93MFtGn?=
 =?us-ascii?Q?VfzbJDcHtHZ/KPfXhzyGis0ApfJ93iyA8ct5YjA0wJfNdFAjr4TdybUHqrRU?=
 =?us-ascii?Q?sQaPO27QxXC7y8CBOF8b+F+4oS3XwRx3AdUI/+UP1cYq9XUJpYpXbIfJYkf7?=
 =?us-ascii?Q?Pge5PU+q9XbxBvYdYY/pMJZ6MgLKU2vh+WKNQBWBLdESYH/UWqGFGMlSeP7p?=
 =?us-ascii?Q?tq2BVThALeR2wfCqhaWBMmrISXk/3k3Qfdsx5/qCcOsCLVdnHi2ierZw3Erf?=
 =?us-ascii?Q?xDBWoz467+NhJrms6CgtxycPUdU54brLPkJwAgDG7I5QgeR3MT536loCJ1fD?=
 =?us-ascii?Q?g08vGfVSqfqNsq/cw0uGRrIdU+8nyloSxsmtjnJPW9pIHK5VWKmAdC/Ym62q?=
 =?us-ascii?Q?S2HX1lj8WozcYAU8sSkO3I2o54G1KS0cs8mvUJOGJCvIcnyM9MWC7+g5xwr1?=
 =?us-ascii?Q?CbOYn5AT0NMtTLPi0h6CeVuNXUEF5s3ccrT05Jt+SqFzL8UjIMYQ9WvruDPs?=
 =?us-ascii?Q?WJCh46QG7ypvaoFMT9dZOEsKrDM7Qx+gOtbkr2lmn4j3C1pD9SxhZ9iWA//d?=
 =?us-ascii?Q?vuwqI1dgxbk7FYIotrI8eoSn5TkbKSV7hQgLZTZfV6SpD13Fz0vx61TNdi8a?=
 =?us-ascii?Q?ReeaShyscbxVLVZ0G+/s38/byUK8g+IY7fi8Cfuk8QeMVWxbjWlDj81FYjon?=
 =?us-ascii?Q?QKADjT1XG13FK+9SXnAg4kVEM/dC53cU62GB2fcKE4Jfk3luLjgoJ5Ega2Jk?=
 =?us-ascii?Q?C2sSvd7uiNzLtSIUYteqoqOG33FVSckTwGWbxXQbIApcF4ji3wzqwnckwGC6?=
 =?us-ascii?Q?psadiF3RbSFVMibOwLaYTkn+hwjHxWkv?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:26:01.5285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbeac4b-4b72-46cb-20f4-08dcbdd571f7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7521

Add NIC eeprom devicetree config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 49500db53a13..c2994651e747 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1338,6 +1338,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux25: i2c@1 {
@@ -1354,6 +1359,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux26: i2c@2 {
@@ -1370,6 +1380,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux27: i2c@3 {
@@ -1386,6 +1401,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 	};
 };
-- 
2.25.1


