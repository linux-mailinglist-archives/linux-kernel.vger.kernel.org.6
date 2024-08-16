Return-Path: <linux-kernel+bounces-289373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADA495459C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFE11F27110
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A93914EC47;
	Fri, 16 Aug 2024 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="C5Ec+Zn1"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2078.outbound.protection.outlook.com [40.107.255.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9B145A15;
	Fri, 16 Aug 2024 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800308; cv=fail; b=c3YL1pK7KCMJtUrjCXKCPbN9r9xyTIX1ENfhf+EgbTa80Z/8XXFTdRig/V7Ks4ViXOoMdJsh0vtbGPWLCD5UAonCwAVy1sPLlHvQid2gsiS2RIbG/BnyVNH9p8oCLmJmePTmUgdoaWtM3JECzhZASJ31Cwb54POptleijwTFX3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800308; c=relaxed/simple;
	bh=TKm+OI9fWbBrT5J+HkZQsH17XDtM7uMYc+S4dkcBFSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVbw2TMJ4e4tLwtk8TL3nCw54h0F7W0PHfKLQ8Wpbo1C8615nr0U+ryvzbMGBmHesu60VJHcAEsfKsE0LLDBnyJyPpIySdSlbS5Kkc5dZlvPeHkdsTlwfEhWnzIxCKhKCkzlTGeziyupkmtU1sAThFbPlzoHedb6ukrENtNUpEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=C5Ec+Zn1; arc=fail smtp.client-ip=40.107.255.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMmxHJ0thwesMfyo+hDhau6gNOZQ48Z4TzK5TzLa4wobkO9+lFL/ueGmdChC+brwWDAV3LycHf1AeqQkAMsQ4Ndo1Ld+INcw8yldacz5+TO9GxghVLzbCNtGB6iEzX0JbtG664KBzl0qK+6vepk4fzRHFZ052SJ0B2fBe95JX0o6UMXNbxRkX2At4Nj9th7d888P3bKhvN1keeifPDreHqn1x0krTbvRVSmkIXTr/EWaeh4wJvWZGHrAY8mMJAqu69NAX7p4LnqS7UCP9xoi4QEW8RPd8/b/Bt0mCSc4j67bP7yvsj1e1taks0tqs6sJYkf9nakVfu6w/c5tEl7xRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIYwTFLr7k3/66Qq65omckRUKm3v7IIjsRhJzbIKUfk=;
 b=r3wXxsGYKr+LRu93KreH3FN8+zohU6orlgMad87SrUDQk0CCZDRf71YGQmldVDET+sN5N2IHcppTm/okrBlcRVfMheo92T3u6HqW0BzZ3iQo91JWJ3oIiod99HhBI7KXHrBraxTegmYoC8L7rT/hScA8gteJGR8LLL+Q4ldXjRtJz2Zl64D2IxccDm1etreOwE8sTJLhiWwkUIePp8tC8pe1r6N8EKYxF7cdLY5U4lrRTGiA2pymlyeq+F6YdmwmHbvdORiTuICNxEolA10K78rg7NJ1MWyAOWW3AGtBuD7tVYHbdQIzxmdkCoMiBS6peMBedO5dP6nnEs7/dFV4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIYwTFLr7k3/66Qq65omckRUKm3v7IIjsRhJzbIKUfk=;
 b=C5Ec+Zn146ws5mKo7xFjH0y+9pSluLawU3wGgVdJ/ePAs+cXP2FAgWDVftptyNbao00XGPy56KcXS/B18tOw+Ymz3Z9qWHUQNSsGFFnDyYsw4wKuMl06cV26GmGHnBeZ42CZbScy92Pel1o51/kBCVA481DgbpOH8w8/Nw3iqNC8N/V3WcYOt1ExcYwu41AV+dVNPhrMKoAL47bJ0RcQ2qswJ0vOlAn4Fi8rki4BnS3JDUM14mtYl46eo35sLjsLL+kqtoLLC1KGDG87Y8qHq9hINDse9o5c7QvcHjzyrNvHCYQJhJkM012LdBmNa7dox6DHZfYoKnS18ah+baDgfw==
Received: from SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) by KL1PR0401MB6610.apcprd04.prod.outlook.com
 (2603:1096:820:b8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Fri, 16 Aug
 2024 09:25:00 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::4f) by SI2PR01CA0045.outlook.office365.com
 (2603:1096:4:193::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:25:00
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
Subject: [PATCH v12 07/28] ARM: dts: aspeed: yosemite4: Add gpio pca9506
Date: Fri, 16 Aug 2024 17:23:54 +0800
Message-Id: <20240816092417.3651434-8-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|KL1PR0401MB6610:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 328732de-6237-4e1c-9442-08dcbdd54d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iiW6gan/I0CHTsfrGViVLIEi17EJYr4nFfhlCU7Zwm37wUfX8/CskBZF0D4R?=
 =?us-ascii?Q?7quU/3GU2KlUhGt0mV7studTp3nDXhkAQyWTIAcSKXXYAz/B7fvDnVhuD6IB?=
 =?us-ascii?Q?xnKgyHnh7dZxW7IDwWAU2bVFt6AEtxD0g41dAbPqRohxSust9xNzyLV35M57?=
 =?us-ascii?Q?30WJW9baD0Ma70rscxh2WNX9SU5GhVNRrenw/q0JPmgUJhmCcgiueH2nId8q?=
 =?us-ascii?Q?dnPmzLsfpdEYwOigRR80Bi0E0/nwPRb0dB9hkWvq/V+GcxBnPy3lQX5gmTst?=
 =?us-ascii?Q?NUR4/Ay4jRPyw8g30zPhCkWNLsIQF/l8A1f8UNNPVddMR6FKMmqKo91/L/XR?=
 =?us-ascii?Q?XBIK8GlbhHE2nftOnz8qKlyrpTBDrPsAvkfsrfMHFcFzRaUlrT05+WjamAks?=
 =?us-ascii?Q?SBgV73nNh+n7dpDwPn4I5BD3eLiPMbRApUT2GVO1Gmi+oFYTELqA/jGSGJPi?=
 =?us-ascii?Q?lQgUPyCCLCxShXlrHFh4HYFSRCyhl09ht6mbXD7Tjb7NOiVaWsc6bd7ItB59?=
 =?us-ascii?Q?Ysv+lfop365XDQhFOiXF4JEcPjNIDNjsTPL6tLQr/GHhTyVs2YsV0mFV4jVf?=
 =?us-ascii?Q?uGQoqqlVaBR9zWF82drUvRpmTsXEnLLe2Iu7FgAdR7Tae58A+ZK9ruUvsMdr?=
 =?us-ascii?Q?XQoWRW5X9MJFRWFyopqPDvMa5CjKToSSpHMnTi6i2HmK4SLMqKV9zNoC/PNm?=
 =?us-ascii?Q?lKoUzt1kF5JXfQ+hjIw6enFuSaDNfNZ/kCccUL6474UHIzgKVpbTS0wDGxKW?=
 =?us-ascii?Q?78wEj0foGVfdVsh8UlbJNjKIemYbgpCoeSieszSM8H13F7TNnG7pqxu6QPQ2?=
 =?us-ascii?Q?7hxskElc4J46O+Slx6BIse+iF7iQjSVDlVZvEf5EAVYe935PWmeVeahI4eBs?=
 =?us-ascii?Q?ieFkdmZ2+WqQ4diW8RIC9Q7xKuQfBiYUhsGfrCtxIFvpCn8HvF977aoHByOD?=
 =?us-ascii?Q?ycii+kN0XMzBwVCdaeAm2Vw7MTQrO/4C/fUJ2ryNvOkOJ8tMj2qGjzYgCWKE?=
 =?us-ascii?Q?wlxyvpT6vjM8KYp1WTBcn+3jRQSH4LCnZthiaaoLg1+RcSz47cR/hY/Vp9nX?=
 =?us-ascii?Q?EZAcIxgSqm3wcTvM2ad7EysuHStD4a4tA2e42bW5dqlQBAnuQRbNSUpG4jDn?=
 =?us-ascii?Q?NPbeSpSJg3MWfHrGPx8OsiWldzgQ9TFYcQw70l2TMY++3HQRIzyHlJxLJSrH?=
 =?us-ascii?Q?2JP8+xQXztPsapZQ4DZgDjJoj7HmaOZIBLeA9FEH0bjdpaIsUsrJpxgaOpFW?=
 =?us-ascii?Q?B/hWJkb/yBBWmwK+6qvu2dvlDgjCkyN5WdzPI7zC4xL9BFQVwZSj+8/lSjlB?=
 =?us-ascii?Q?1ro/aFqQi/BBByzJ94lw3/tbIm4onJQ09NFg4aeyymWlRy80i+w/HxGEdx51?=
 =?us-ascii?Q?xHOUUt94dr8Thorrh2D6XEvSSApwtLj5LstqJtOZ9gO+Q0fQXE9kUwpvxNWh?=
 =?us-ascii?Q?qPzZahQW68aBKuedGF/eQ03JT4mDTr/s?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:25:00.2159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 328732de-6237-4e1c-9442-08dcbdd54d6b
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6610

Add gpio pca9506 I/O expander for yv4 use

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 252 ++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 7b79fcd77c8c..f4d27f1ffdb8 100644
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


