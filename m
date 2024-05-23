Return-Path: <linux-kernel+bounces-187239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613898CCEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9019AB22376
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA39145B2C;
	Thu, 23 May 2024 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="tV+vMfoN"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2054.outbound.protection.outlook.com [40.107.215.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C413D28A;
	Thu, 23 May 2024 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455924; cv=fail; b=NXLI09NcKEvQr2obdG68D8kjdWinVl4jRqWgCyiMDCyyYXNbR7Qdo7BGszB65RC0wK9fC2oWFYtuJZj8ux3hljqp2YGhkoHpCI+nAVTzBuXj/FNc4a9VMUVYvE/UBetIxCsz8X/bi5KSV4Q/HGFAtR7HUQtlw7bxUWDvFtiZ2r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455924; c=relaxed/simple;
	bh=9rqdb3bweZo+DREd0kHWSfrwaBZM0bC0snPT9FyLXh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwbqGvfqVA1tpcSNLKMeAG05DFCFjEpdCtgKL+oQN4u7tfy8tP9iTR7RurCdLEr9wa3+44ZOswpZ/I4T1PVfvV58lK4G6Qjv8kO06OGVAprx9sErTmjSsNaysnVmx3gIsqT8HYnBh6JwRixPRDbfIwe2u+jRq2TU18MjTrfjnOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=tV+vMfoN; arc=fail smtp.client-ip=40.107.215.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI5uWdee4/+/NsHmbyFbgrlEsP3icV+BGN935xTXXpl+BE5F6860SnKQ1frDdRLszazpVhrrfmkuIrcv1+nsNFPT77ok9JyUfZszhzTmtxMHqeKw/5QZd2CXQgsOWMk+f4kjgtzcwkpGHIL7SvmsmGyeFd/QhvKaMGLvQ/G0/eUWYLggdyupkUvXB9z92rKhdj2mSzDqdLmP99Xni1iYk/4cP+WviNjdBVsreVDuE5xnjpAE4Kkgw/ybMZG/KceZu7p5iIoSV0gLXwQS5aNlBtidN4eT5vpFDN3EK+B76sPDOpIRAVOatGHphAbdM6EfwkJt0Bz1OLyzZp74nJ2wDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB96pUAHPYpne52+aZSEHu32dSiQWPF5XIERkA9QsJk=;
 b=I7D8oFRMwJbkmj51e7u2+lq9/3VLnNGGoeWxLKcS7QlhLmatrH2oUB0Ga6zkw5SUhkREQkDnh4kqNAhfUHxC98RBOP8623TaAHP1ZKtew4N6bcWyaqzW9WKcwXq3io8UcyDsnwTSWsN/fKvgEs88Mpl0Itf69xFc+C8su4sunUrCKl/HlixiSUUZRmlE+vFZtMJfIiavPZDjTAz7dXljnYb+HK97obmiMsVBcOsSbDUkXiB999AsGJtpfPN0ZfV98wGGjrTjBybjBXd49bjB6BQEEOBg2piX7ikcA5/2Y3qSOjHe0PtDXJpA4+fE6iq2kUz06KxMJ/NiKrMKFhSOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB96pUAHPYpne52+aZSEHu32dSiQWPF5XIERkA9QsJk=;
 b=tV+vMfoNLP5XS/Ry7Pte590huzWU1ZOUIAFVo9ZXtMZ/lq6yNWwPOLoSJHOLmqUg7taPIGktnXg/TxUJ/LQbOPEeq1kY4OUQZeF2ZNs7L5Oan842steCFpdcgCL442HwauXAvBJZtdM5Ho7olh6AxIPA7/BJM7bHdNwu11l4Nvke8sLLRvZ56RiizP9A/Y8xaztSgTyw0yn3zCKg2teyzvSHUi+BCG6w7iqi691Gce4eo6dKf8DPjIWZLU1/E75kANUoSMaTp+s665ccMgKFmjPOpAQUd23Q9PM2UMMlOnbakqrA8PeYIYAJJ3eGFD+w39yJr8ZFaJvH02q336vf6Q==
Received: from PS2PR03CA0002.apcprd03.prod.outlook.com (2603:1096:300:5b::14)
 by PUZPR04MB6350.apcprd04.prod.outlook.com (2603:1096:301:ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 09:18:38 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::bc) by PS2PR03CA0002.outlook.office365.com
 (2603:1096:300:5b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9 via Frontend
 Transport; Thu, 23 May 2024 09:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:18:37
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
Subject: [PATCH v8 07/23] ARM: dts: aspeed: yosemite4: Add gpio pca9506
Date: Thu, 23 May 2024 17:17:54 +0800
Message-Id: <20240523091812.2032933-8-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|PUZPR04MB6350:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 50ae2694-1bd6-4e9f-d188-08dc7b09546c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Shkfpch5d73kpzbWu6vOvG0siN/zBpgF6luhA2mGVqsd8NH6Oef2WV/egTbp?=
 =?us-ascii?Q?Z+J/CiOX0QBdYVm/oCZ7kTZRl35V0cl8qiNEXu9FxmcNpsMDMUQmQXXMLtEt?=
 =?us-ascii?Q?tgJURTpY3ZlwIGA9h2Mc1yDXUin688zsr39oyR018pcArMrg3pJFYIFHEVhE?=
 =?us-ascii?Q?/Tq+ovtjmOLL+biipX2FJzPGe2RAFwPZMULYbHbjiQd6GPL5dikFK/8R30iZ?=
 =?us-ascii?Q?VO3MmVZD16k6JlhEYar7MVWLQSCdZWHBpORWhD1pU9/UVvTuSDg6xYg7Z3pJ?=
 =?us-ascii?Q?PxLR5/vCsx7Q6+oL3UjUy4OSiiW64vJ1Ku5wdqyhbt1Dz9TZqX7//9Poog+u?=
 =?us-ascii?Q?/qAlmekdTsZTtWHIu1r3Gje2N4sS8Od/CjuKahfg1AlUep17+3apmPDxCjVH?=
 =?us-ascii?Q?LNz9rWQofIcOlgKT/7kcxnDblWPzGxg+zz1jHFuFdhsxK2MDmoi440sgLJ2m?=
 =?us-ascii?Q?uWDY093GBKFbnQ4evh+X5XWxXurpFoh1egM4jzEUb74HDldgpzjmxkb5qP3H?=
 =?us-ascii?Q?9nfCDrKnWMecbg3PoSSZTRTxLBl2PPUBnVN9HVkcHAm/9Aj+x79AWB6vW0gI?=
 =?us-ascii?Q?LyVijZovQtEi+0yYJYNsCsNEr9fcrx75i74QIWGcu29pS38b2KNkBOT9f1pv?=
 =?us-ascii?Q?58r4PpunvtJlbY6HvitnByRi3MtiZvE2oTLcyCLcoNrtw68WiJuKA3we5GgU?=
 =?us-ascii?Q?/yn3gjAWkykpPxqSHVMX8GriHLN0TTjQbd8ytde3T5gMGzEPlAywkOQK61VT?=
 =?us-ascii?Q?SsU+i6F5G/C+usroxCFI2Ohwf+EFgFvwSdd2lrAUixeLSGCHVcxi0T6rdMru?=
 =?us-ascii?Q?XBgR2wLDNrm0eQW0oCD/iPPSj/MbmBGfYLa2QNPkldOF+WabpQBQI2pZ3ZBn?=
 =?us-ascii?Q?323+2yUNonr0uPBCUMG/puUwwgyzQ8pVTpPeO5t4zKe75aKos/7z/y0cbHqn?=
 =?us-ascii?Q?8V+7oX+dant75rBiEkhqPSSfitQctt9+YusdmmDprVff6bUrpc0R3m0EAzE2?=
 =?us-ascii?Q?BiEgROqaC4M4QfgiZ+TeenXaHkG5txXALO75GL1FTocWf1Zby/aB4UE1SvWd?=
 =?us-ascii?Q?zJ75mxMgnptyA8J6tHuYziT2CsCwL+3zEjBoIRUe2zSwIWcNL50wtgMqXWzc?=
 =?us-ascii?Q?bgABVbImnMY9XbhUMOEQJXd/Jo0xDk1+tPVb4AFsOvt5uNQNkWRULroK8W4U?=
 =?us-ascii?Q?hPEtzXUVCS/oA3M9XCnpXjW16oKEn7wjPvJrox/3g3kK9UQS/MIq6w81xinP?=
 =?us-ascii?Q?mat49AoSI0dQndJs4tBEczkE6LkpoCcpA+DopdwViQSiaOTqVSiJlHWIc8Q7?=
 =?us-ascii?Q?gH6foOf0pdjFGOSNwiBspWEXX0wQswOlpAqgT6ijubS0C+ECCwKQdHUgZuQb?=
 =?us-ascii?Q?s7gWyBI=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:18:37.8920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ae2694-1bd6-4e9f-d188-08dc7b09546c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6350

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


