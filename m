Return-Path: <linux-kernel+bounces-295248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81EA959906
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2194CB23EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D27E1F9B54;
	Wed, 21 Aug 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="cwHZAYYB"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2043.outbound.protection.outlook.com [40.107.117.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F21F9B4B;
	Wed, 21 Aug 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233313; cv=fail; b=ffkGWGwXji9ovLDfo+mlE2VQnwwOhTgPjRsFPCPmT/OY2nSHQwh4FQDYPmUXCI8lF8Ldpek/nrj+kkojkkZJ+q8FdFnFZL/AyDj1PYT4guGhTnr+8ol9/GTj6s6YaEVLGi8bIzopynwiqqq0zd/tJTdNC6K0baHzcunfyP/Pia0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233313; c=relaxed/simple;
	bh=k9TQrTgj/bmsUx8/XHB2Q72cYyInledEqhlOsk5dxvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XElZCZi7FZE7DWFtRxNsk9QJBm2hCrSFgOye90PoCy2F9Rjcrd/C1WaWu8GL2OHkjPH9r1hudEckvmAba4hICxJVaNj9GApejz/YmUN+vGSz/Nr5j47l/57wUwtNrXt6nd6WGQv2E0+mxmJ58xjodOCU0FRTbF3nDE8FAH4iRi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=cwHZAYYB; arc=fail smtp.client-ip=40.107.117.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYt78uP9BBwb3kTCXM9z2PW9rb18+YEWEAmM3YvbNwbv0ZoZ9rLU3sq5u1nqffP2Dt3QkYbK5pnCDCdwcmts3OCq1/rptWaodFQFB3TQ2nSCTCsenNsbEQ7Cix1WhVNwvPFd/DOzqOrjORCUaxeAHk4VD1FEBmONMYVFaIZfQo0is2YjxcEd7KomF61X2zSy5ufxyDRRDns4O5sYaMGPtQ+mfW5Y7/8AVxLYxOurZtJrVGcuM7DyE2wr4D0d8tU4tuULcZvu7CWKc6U/Nkhow7gl5VAQER/8IgnVj1qMO0RcdGMoqBMEM/HeYPw28l2wZh42roXx6AGHtV8UgFLA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTnjvURfXlo53+eVxwkhIqzweQBqIwx6vFyYMB4uolA=;
 b=DlBGoAVI0vN3TF7s7iPCAERArVnVA8fqbZ8COHuMoaPdLAKM1mIqW351s7jkpE8OEpj3E7pFL5WOVMQH7kJ5Vrun0b4NZV6FruE5zDi/17Jy99dzZj5DnPd/05d+dgR5HD6rW4RbHKZH8Pr79yP6ajSB89SloakyMCHoaGr90doQDfFpF4L/IYvdqn7s3nV5V2wseI0bMShUAYDvWRDqf8L1fG3FtiEUxJjVxD04u8xO2S6B1si6TGVPvlpvL7bnjJGPn+GsE0r6b46tN5/+YL52MerkxyDB6fYv6vIg8EGI2jqKv2kUijsoRGxrq/wHzz4jtvhN/9tBM6J3GflFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTnjvURfXlo53+eVxwkhIqzweQBqIwx6vFyYMB4uolA=;
 b=cwHZAYYBNy6RdXIvjc6QEfUyWA37SdlxDEYrpnkvoMgPXdPDTOqZpmAFm9zNkya4buOd4f6bJBZXFcOLJuK6YxGUOkmknYukhhWTiIhgdvbrDbld+ft/3u1WYSswI47RX5Lut92wFu7AD4wpug0Qg5ixwwitoHrYDvk6xEBUPuBFs3xUev6+d4abv8il9qvECSYBvPbsFiPkPbjWAgcMTKtk8w1fBZ4zC4/LgWivU9bUVKF0iM+qTFKCLZH4/sYazVcvRrcXusiDQVur7MJoOHXao5yJa76E2WnwdwoknbVqqzwsvZg+APqbyDCbbrSDmqeotvnh93thNQG4+6Cuzw==
Received: from SI2PR02CA0028.apcprd02.prod.outlook.com (2603:1096:4:195::8) by
 PUZPR04MB6463.apcprd04.prod.outlook.com (2603:1096:301:f9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.25; Wed, 21 Aug 2024 09:41:45 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::70) by SI2PR02CA0028.outlook.office365.com
 (2603:1096:4:195::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17 via Frontend
 Transport; Wed, 21 Aug 2024 09:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:41:42 +0000
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
Subject: [PATCH v13 05/29] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date: Wed, 21 Aug 2024 17:40:16 +0800
Message-Id: <20240821094043.4126132-6-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|PUZPR04MB6463:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eeabd825-68a2-42fe-1ee3-08dcc1c576f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XmJXQow0wUf6BvmpLJoCwNSlyDN55VXKnh1GlzxWHIVJ/7rO+Q+FZZKaqACv?=
 =?us-ascii?Q?32mQAD2Oc0D2kXIrK8V4A/C45JvoiTn6YgelX9T+uM6kQ4Tb1iJUkipJsbBW?=
 =?us-ascii?Q?EYc98V4o6YOmD00FeGUZQs0Lc3FBdSjyOwbHQZ1pGiUQWIebBIuDVAkOUkHK?=
 =?us-ascii?Q?GhMmq8Lz8PyNd+NdAGfb/+BuFCtY1B6mIEz8G1sjB55opmY2G77ZWH+ex7Ab?=
 =?us-ascii?Q?edEAez/HtU4xzZWpcfkUi6C6KU14Vl80HR+N2THBqANWIVxFvhy0AnVDsV1T?=
 =?us-ascii?Q?5EqH9DZ2Bww+sm2nmJVBtqibbnVCuJ1IQ62zRHDX6NHxcqZ5X0IFldneW81A?=
 =?us-ascii?Q?bAWahiXUsGbgMlnlhYCKNUfAtO1TvtiT5Bxb2GkedBZhKiQel/TCfhTaeXnC?=
 =?us-ascii?Q?pii8a9DQG6XNrubSdF/K5tkxoXNfnXclvTzldk+6qSpI4uwLVviV3Y3g4bwl?=
 =?us-ascii?Q?TQZ/mINlhIuOOo4taahjH2KVqEZkir1xEKSW9EfXZ30Bi9yhhhQrhtEOaZNt?=
 =?us-ascii?Q?/aHeD0ZfeUYII0gHP+0cNeBvPnXeSfQ57TUOjBuJE35Bl1px8RP5e3Ibnwyh?=
 =?us-ascii?Q?f13w4IXu4SVMEs+uF3RohF25b9yDNTJJyprbkZ+E0Ie8sJR4hRzcr2Rgh1jb?=
 =?us-ascii?Q?MV1ueRMTDYQLEgddFGyquQ6V9UFMcU+1e+8UVGI4ev/JposZ51Gl1Wr0taqY?=
 =?us-ascii?Q?faCcF9GXslnArq8JrjyUZd6Xjt0NwvfgJnxhYbmgIkCo2XaBzmn6gW38GaIr?=
 =?us-ascii?Q?NvdeDimxwsUq++f6agaL1dweySl6x2rTqgus5QHrUGrH3ldvadbwldxV8WyS?=
 =?us-ascii?Q?WK4HJXPQGerX88AKVdCN2BMfN/SmEPn9j8+J1ZlrWUu6Yukop9+cbnzSO0sy?=
 =?us-ascii?Q?WoMJkx45u9YQgLlZEx31HS8yWnXFJiGrNXRyEi40snayAqae4UW+9Nw4BkuJ?=
 =?us-ascii?Q?jY2h0gCzMTzvaFNKtEOrV0jSc3NSauHAANJuOBTOkk0xR2b1B8v+/z3Vx8e4?=
 =?us-ascii?Q?P4bES1j/g90ij2vspQLs/bvs80D5huLwOrEzZ084FoA0dlwO8cPPbmgAHKpE?=
 =?us-ascii?Q?CITqw24cEHX05nhXVibodOM43I0gKplsphqjinvtSeJemCU729Zva64GtfY3?=
 =?us-ascii?Q?D5yrJ4yZ66QKjFzTOaBsQrivz+MpMgoI2s4ibXZn/P0UgGuwVIP7WOP/o0oP?=
 =?us-ascii?Q?hEF3W0spI7mye0U7Otl7L2SUv5UF2gWQI6mKLihkMtV1+d+9dZBUoLpSLQVL?=
 =?us-ascii?Q?ubFRXiPzT5ay1h8DiPPRIitt4hqRrMSchh0VcJxk6ifmBaeniQ6YGiV4Z4oJ?=
 =?us-ascii?Q?5MTZzr/cOBrktCVkqlvUAP3MAxGSFSBOy6eQFwKswoILwV/R/GBEf/QvVDuj?=
 =?us-ascii?Q?hToIBeltumgQYjMizN2FE17sttrVdBCnwwB3fgAsvROAYvvs32D4SSqvy+KB?=
 =?us-ascii?Q?CJnUuZ1mYn98uCU0YzDCme3atM0O4r/4?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:41:42.1683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeabd825-68a2-42fe-1ee3-08dcc1c576f0
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6463

Revise quad mode to dual mode to avoid WP pin influnece the SPI

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 51b4e9ae13cc..e5354efbb903 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -149,15 +149,17 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-64.dtsi"
+#include "openbmc-flash-layout-128.dtsi"
 	};
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.25.1


