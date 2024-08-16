Return-Path: <linux-kernel+bounces-289390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F230D9545C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26AF283F25
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3111A15B96E;
	Fri, 16 Aug 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="oXCbK+Ay"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985BE1487C5;
	Fri, 16 Aug 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800389; cv=fail; b=Zo81ngJ7EkX655GNKTjP2S+y6pfD0C8YfMdlN9Y73ax7eFAk2VwUU/Mgxg8+wbaO+kBYjEhmYMlM0SY1r8Ndtd+bnMVPJjpToCFUfkOHGnRThNu224lwDHeRwhva0b6D0RHVvRMFC+5/rD/e9sfdM4c8cbWOS50eG94q8Y/dRuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800389; c=relaxed/simple;
	bh=javoh9yV7WrDdF6nED6Caxxup6WdbdzzX/IVbBhNWOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCbNFKiJYhB89CitwqUlfdd7OCTEhWuaL79M5Z1FIgFhcaoT2XjBO7WRrYaRqaF2qdlqZS0Dp1AmRDB7tplIWl3Pzs/2OSBrw/X4gQBoX8eA7TC8WFOae0iVkkMuw8wpP9+MQuQbzKC0xSrFkKLhOje5Z06TZRaVUaC+YQTmxPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=oXCbK+Ay; arc=fail smtp.client-ip=40.107.215.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBxeRLthanZR4VfhgRcVtA/17gtLRA/MeJ/r0SSD0pWE1t4ACS1/hAu+655zjtDz1jrvKT177eRXRD6YdI+BtfkO5AMSa8d9wAqqsbZwwSZA6l60R4Ikzg0K/b3rp+QeIT5GF8b3N5vRCOJme+yrbeVFqG3M7LAs56107rs9+vOORji+NcJMrW4AgT9kSOkt+w5t3g2qcjFhJRck2OEsjuO/cMgGHx9lD1h+yFNbDbFrYKGqHO7kdjODBbER76Zor0I7E6LGgMQ2kH/p+9pVE93Mh/XkkWFTs1sQLbI8rx1+fWOhBmA3xbcuGupL7t4FflF2aFbvwoxxK7kDNB5+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE8IuzdQZjntYqD6nUPQnwn7C+BubHdv/yTEbKi/B1Q=;
 b=gBIJ+XqigB7y8Hl+qEc+/PYRiiO36G6sA7kuA16wK1WPtO9coVyvBXlHFhdi6xddytttJHOmzlvvcW/f2M6DTw5QcJgIK54Ek6RohR0q+XQgA98IKETqK5A8Wet4l79XCOAxzGmhub0t0Nhi/1D59AQo44cNDpS1j/R1yubwEEEq0/Oq1pk+3dZ5jTwiCxc8WhsxFDAoAAJ/jkrcMrMIpGvH13o9kW8LrjEx41/UQ09R5ASjjCEDxa+MFg4Zej996ID+9wHKctJHKcZk5s1fNxxvbJVKh867N7xsbbFLlS/ZcPGzAP/02K/6Xy0w9exv7EiXvvIafiy8OJwlvkw4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE8IuzdQZjntYqD6nUPQnwn7C+BubHdv/yTEbKi/B1Q=;
 b=oXCbK+AyHedMhEDReNKbFIbHLotNx8NBhqKKuEEIIFfQSvaX8xRZne6PKzYxG5sLeJJvpUj5X4H6YJ7v4zFlus8vfbpA3p08tzVqMfr6Cv/cxR5TSOL43WNYC2W4rMOV02ZQHieqWCn5dMTFdhUD7kTOZPyKGQqHH5AYjabLEyL5rs/Z6wDHzykYeFEEXoQN3Vx6kjLQd/5a8bNTuINA5f2OpGVre720wa8Hc9xowLXRVSXpuwjrn28P4pEcOkPx6eKB1I81aR4aO4ku2IsHAgFjt+m8m5wQBVW6r5JE0YLFkx0DnCxmc3PQSMceZiSOcxoARbBJyd35Lm911C+Mbw==
Received: from SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) by JH0PR04MB8188.apcprd04.prod.outlook.com
 (2603:1096:990:aa::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:26:16 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::41) by SI2PR01CA0045.outlook.office365.com
 (2603:1096:4:193::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:26:15
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
Subject: [PATCH v12 24/28] ARM: dts: aspeed: yosemite4: add XDP710
Date: Fri, 16 Aug 2024 17:24:11 +0800
Message-Id: <20240816092417.3651434-25-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|JH0PR04MB8188:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4ac8dc09-9e3a-4982-1fab-08dcbdd57a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t8B6dnUoe37cRCqESjU4sPcNASnoLjPnVheBWl1tGPvHcsAqMToQKdDaMqL/?=
 =?us-ascii?Q?jPJGCMLKcgU0C/05lDfX9+Kwegy4h8rgu2XBW46glui810YetOUx6qxssvXi?=
 =?us-ascii?Q?JXi8Q8jgyX/h6PN8JLYN0sb0QK8H1QYbzxqhAV/qZcSm/BxTdN4bZxDvsm+b?=
 =?us-ascii?Q?tLPmfNW/ibxAiLJyUdKyTUWwfriD5W0eicYO4fbZ9ny7IkgZlYqgGA4UTwQx?=
 =?us-ascii?Q?k8iT8F4qEpqIWq57TyU9cgw5zm1bEXKTSf09ClwXK5XYDFBykWUdSix2JWWS?=
 =?us-ascii?Q?kVRPjOI6QuEzvymOMdycFMMR5PmcNCBEydTiJnJOVZvoGu4O3qyGqMLdDyW+?=
 =?us-ascii?Q?E00napjZjQvQNKR3UQHTGK9bxmXGn/kx88w1a4RZae0p8SuwVYYPVDkpeb1J?=
 =?us-ascii?Q?D0okrbmRncRIx/wNtJAUdyehbKd+U+DPteJr+QB/iwe0h7OuHYrES1WAPZTt?=
 =?us-ascii?Q?PIFhSR9MTSRkmBR73OacgIs0s4xrqdnofmV8m82QXPHEGgb84uy/QcVaoycM?=
 =?us-ascii?Q?lBFors13X3FY5hOUEGlg8yar67NgaxgIYM+0JsW221zs7NRdoNzY8w1wqS1W?=
 =?us-ascii?Q?GtHJi/h500pVxD6T8/pA+5h0LmLyNewoROUmpQxop0kxN/MDN1LscwQqlqnZ?=
 =?us-ascii?Q?oN16xFUdT6wlEku5Wa9E4SO0K1C+cBZ7C891uVhO12RuMhjZ0xZfKCk784vN?=
 =?us-ascii?Q?fjFJPUs7IXD7xR6QMYDVc9QGj7EwgT1cJANi/qpOSNjb/UvlQ2EDI6/V7Nz+?=
 =?us-ascii?Q?7CbtjDMAYPW1FrOal56l04/Vk8fVlIByQvq9Xm6Djfoj/rjaoRAPUw6pDtCH?=
 =?us-ascii?Q?HJDlsdxnPMZE7/ubDwVl9R5KA12qqjCItvMUrAfzQKVWunn1EgeRjqldx4rc?=
 =?us-ascii?Q?sz5IbV82xXqKpf+Ls5HO4JMz6AZWtXLWhUj5ZdQd42Lg9IhejPjqUCtGg4qW?=
 =?us-ascii?Q?yByQmvAWXf3e83q7/xHlX6rcaha3yZZRfqyRt8IPPdTznltNcHVU0FclqM4b?=
 =?us-ascii?Q?0wLSI7DXg7UjM4uCWQ7yOkFGDjMsvNkXrvqQAjrOGmYoKOh5k/r42cl7NAIc?=
 =?us-ascii?Q?nysLt0TwHzQ44njA7tJTLVPRgfDHKFd9A/bD7+ud9cNPGWrj0YL9e34aXKDv?=
 =?us-ascii?Q?i9eVd7ib5bzrcf2L5E2LyRIBe66SiDF8AdaSXMnqt8EuLfO7fa6W0f2YLC0S?=
 =?us-ascii?Q?Cf2s0WE9jTrgzWDLk/1xOY0DLI5m8TxJyvEg6RrEqBioEWFVfH6rmY5D5XW1?=
 =?us-ascii?Q?glBhKXH7hrogt6goTKUMqhmetusZr/JckUNRSB1TkDytV/BGjeiNWaT5an8W?=
 =?us-ascii?Q?PvFGuRud8gG/LHUB5/WCZzXj2xNLQ28ezxJ+ewPJ0L1YD6ovpPJ6ovQlSiGn?=
 =?us-ascii?Q?ybCfJmnI1d5/HRKlBih59QhQ8jT7pqYwDFIgArFtKIQtwnpFatWuO5q1FzGp?=
 =?us-ascii?Q?ISzVbyoQXqMEYIIArqzih0QBDdthtFg4?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:26:15.7629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac8dc09-9e3a-4982-1fab-08dcbdd57a73
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8188

Add XDP710 in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 2f4e9c5edd5a..f73719b3c2f1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -978,11 +978,21 @@ power-sensor@10 {
 		reg = <0x10>;
 	};
 
+	power-sensor@11 {
+		compatible = "infineon,xdp710";
+		reg = <0x11>;
+	};
+
 	power-sensor@12 {
 		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
+	power-sensor@13 {
+		compatible = "infineon,xdp710";
+		reg = <0x13>;
+	};
+
 	gpio@20 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
-- 
2.25.1


