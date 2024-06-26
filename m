Return-Path: <linux-kernel+bounces-230368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FADD917BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9329C1C217DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522AE176ACB;
	Wed, 26 Jun 2024 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="bmvXPQco"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944F1741D1;
	Wed, 26 Jun 2024 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392910; cv=fail; b=pBddZ3r028x5Lhfi7FjLXK3mkn+hbKbB5cN1blVEZkg/+22hU3IJvlLFf+fg49L2hmb+k2u9PLV1fHiJ306ySJNz1UA31LwAGSWwRS4pMpHBcgX4Ada4jVZkJeqH/aZs+LsoyaMGVfI1ONWEjBqmWvtZqmD6odQBAe/tPobHhF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392910; c=relaxed/simple;
	bh=9rqdb3bweZo+DREd0kHWSfrwaBZM0bC0snPT9FyLXh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USEwvIJnPKODpU1gXN26C3DAqlC46mrp0a9NKn5OUoHrN1nZXT/61ZerLoytZf7w0WIECAHiSMtPP7cj0HsPeY6YfirN2CMLtfPW22KL0aWpAAwrZv5hhAKtpUJbGazWmyKRnl9JQzmqPeMbCwMcQQcb4/XQyZKmBco50M3qNqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=bmvXPQco; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbcC49Zpzc+RkPeG6SKV1uN7MBNweVoRbz1EM6Dk/nCOji+dcdmVokPJOUdhLpXp5driSwiSTTafe6yvKORXnmzbNfd/jKY7pGfHZYbeLPYX0LK/4RQAI/XtDtCiltMJMeNFHjGue58/5akTPveadRbTr1XesSthStzCYns2OTzXH5ESes3QAAystC0DyqFokXCzQFBKsmlC9/zhsjusZBkb5WWS8Gc+PKe8Sgcw+YX69nFp/dK38ENJMflCarlclyNWdmAiYvigydiqE2xCcb5/sCAaB1SK5kIVLbmcwN7SAyDsC5NkGXSLoR/i0mAW//PpGNiXYdyepSI2HeVwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB96pUAHPYpne52+aZSEHu32dSiQWPF5XIERkA9QsJk=;
 b=VyWQF9b/w5bq/fooj2wXp9+uF/02y6mGAF3tZql3Di7hBUcA8SPznW6cbfEPDCvuYL7OHYBwrujKhZc2RmstPLKMLZfM0Z9qX99PZ17teXYut/QLT8EvUKF5tpi86VIsqOYO0/xdZ/2Z9yU6qV5bu9UB1sEzi2GHdau3VEBL2PQoC4xMjzYHBsB/1f4IsNz0QpG+dw8ufBxmq/lhtB+zS+ckPHLv/VuHl9v6XwxY8KBTLwrVPz9fC/jAoCowpL2Mw8QsMaUK+G4ZfxizMa6SPZQBV5Pl+XSD8dVeVN+cWaGGwrBlplkMwjw+uYz/AGP0hu6ZOVo9g3XjhyIkNlQCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB96pUAHPYpne52+aZSEHu32dSiQWPF5XIERkA9QsJk=;
 b=bmvXPQco5EVQwja1LBcHThFuK1UjUmXuu7z0PqFycs9tjZheDQJ9YQ0/RrJQKXXaS3oHv0w2F2Vo2CGrAM38KX/GhDEpCZBmfh8ZMjMy+Y39TeJ+yhsfs5uh66uRjHsavlDs4rqhRwn6AMp9yPrsgBBI4OYk6a4rQzXf2xAOMt5uhRMlgvBEjWXbNYHiKaSHwJ4JUT1QMWW8RqWxy+uVYUByWRAQtiBQSST9woood9xkNK/DfjH/wbflaVyI4ZOZsqLJOex2wieZnzO3elPb/Y0jkU8uw01TDCQlKtueUmQRgHYUt/eMlsm+oFWGl8FNNQnvqi9UcrNN/9+7W/4NSA==
Received: from KL1PR02CA0018.apcprd02.prod.outlook.com (2603:1096:820:c::23)
 by TYZPR04MB8022.apcprd04.prod.outlook.com (2603:1096:405:ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22; Wed, 26 Jun
 2024 09:08:24 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:820:c:cafe::68) by KL1PR02CA0018.outlook.office365.com
 (2603:1096:820:c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 09:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:08:24
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
Subject: [PATCH v9 07/26] ARM: dts: aspeed: yosemite4: Add gpio pca9506
Date: Wed, 26 Jun 2024 17:07:23 +0800
Message-Id: <20240626090744.174351-8-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|TYZPR04MB8022:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d64fd3f-17af-48e0-e01c-08dc95bf88bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|82310400024|36860700011|1800799022|376012|7416012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xz3X8UJcL/cfhHHhd1REirEE6rzduHyHDZB/uppj+tw6XXzxRm3nW6TdJV1v?=
 =?us-ascii?Q?QzRnwLvs1x2KpCvFMkX7Ko2d7kuMSJARoiPDV3JGPxAPmXfUJXWoUVXjxfwj?=
 =?us-ascii?Q?g2W9TpJWEZsoZZmc1DukAp91R5wClzXWHqbjtHSxgl2I3vNR3AiKccMH8LKN?=
 =?us-ascii?Q?aecK/1Q3CaR8GJsEQSLAXkjdtVom6yx/Xccx09g1Q5LU1pBv0g8kHFqMRmEe?=
 =?us-ascii?Q?T8redg0D9vAhSyxYBsehslN9jF2de3eXaAZaKG0Fu93wRnIC2s9Fc8YTCoY8?=
 =?us-ascii?Q?vb7Sg5hM5Tb6T3V7yTUOjmSGKB+Fn6A8fddn17NezbjnxuGCsXqM+pFTqejE?=
 =?us-ascii?Q?3xyN5h2BJgjONGOfU+/m3RiIcGVrRBAsMTmS661udjO/5eDXxFpLPCxuIrCa?=
 =?us-ascii?Q?gL7FiVhxAEu+vriVbiFchjo/xoEAYFlGvOMjHqCpVl175JWVQceTK+sLFA1t?=
 =?us-ascii?Q?EUrk7wOEbOEQmxQkSlWAakAmuUwcKZn/cc2ehxN9vOkCNhxGFpg/j9bEXb1S?=
 =?us-ascii?Q?8d8lbaIgwK1x0wBErWcRT8KlJrpz35RTiHcVldttffU4W38z7CjmRAkkUY2+?=
 =?us-ascii?Q?QjaUwNv1+RFlhdx4YCpcqHfWLgWnCZV45r6xGWcnCYbg3tJwMv44/vW4uviF?=
 =?us-ascii?Q?eKpgSH9s8ztT4jjboVXu7lZWXLzDddo0uJyQYbED4gynbSnx8Hu6Wbb7BaeF?=
 =?us-ascii?Q?Oqp6iW6bar/p/SqVgL1MEPubTYQpud0fqVLkGdtTiAAsKRNt+V3GO/WdPjo4?=
 =?us-ascii?Q?RIDh65Fqu4db2pKmcbSNxBonQgteQvaNh4qoHlce/lpYOeKE6Eg28n7ZlZUY?=
 =?us-ascii?Q?Tr3s8NQWq6qmZyemmoSHxMRGUMu+YUpu7dv4dJz6/LMRMjFKCWjKi1hRJsMW?=
 =?us-ascii?Q?Pxx3kZI7EdTJhNijHNqg2UE0cIa+rMRTskNxih3Q3jko+yE1q3XAjEWcOkXc?=
 =?us-ascii?Q?pyGGWsTRfjqlv/E9H6FDcR0mliCYucwOu99usHtbATtC5pApgbefEfhvtizz?=
 =?us-ascii?Q?bnyOvt4HARBVH8pyKYglacI6eruWq6a7SYatrQFOi6WzHFh/kNR2FDYP/O7C?=
 =?us-ascii?Q?DwdEZj5Ce8AXAHFG8fMv3+b9MqXunfd2wUKbjEHh4HET+DZPHLb+rZNS1eQt?=
 =?us-ascii?Q?DZWSffaUMp11beE/i/bN4V/J42Zw3V+gKRMOtUkoxwxQACcsoQZm44yjWX1a?=
 =?us-ascii?Q?9SnDxdos5UiTJdWKImIfGhdsDz+ug66NnwPaU/ofKuKHDc2VTid/yOSglCkw?=
 =?us-ascii?Q?rmDeGBF6CP7PBFGsiD70YtYZbbsrr+uC8mLNENf+pZDqN9+Zo6CrGg2Ddo40?=
 =?us-ascii?Q?xeuFWnivZ1dayj2/qoacQ+JWSsOd1KpHPhFQq3/JPqUsERLGVF0mFnPlTWNH?=
 =?us-ascii?Q?t0IRP7JwmimPGsBtf7fn16sV/88FZiWU7lPhYjB7JREo8443gw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(82310400024)(36860700011)(1800799022)(376012)(7416012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:08:24.3017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d64fd3f-17af-48e0-e01c-08dc95bf88bd
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB8022

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


