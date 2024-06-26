Return-Path: <linux-kernel+bounces-230380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E77917C09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAFAFB20A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE02181B9B;
	Wed, 26 Jun 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Hzhq94JI"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2083.outbound.protection.outlook.com [40.107.117.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C516EBEE;
	Wed, 26 Jun 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392950; cv=fail; b=BKVC8cMNcbPs2NBiVd5u3Z0fcWlYiYLMeVldkBA8vNxP2r/kIHrisVP/4IREw6XY2BSpqgqwSH7rrH52j2Pcy1IMvOBVTY5kGsNAEdJu8pwPNi3SU52p0/q6CgW+QsCeBU29Xws3SpgJB1+c+JqCfewG2fpo05SneryfFqqCiW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392950; c=relaxed/simple;
	bh=0/RZfxELZSv5ixlsRWXl29JeFAUJDoCFh+RoEwRg0LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atF1G3Kdy5ghsO5Jp57QUeg7P7oAigPzuzC0v8fhZh8tvWRJ/FiEpPxf451/a9sWL3GbnZh2WrgtNDmr+L1m/UwC3rUw8nK7A9ets1rhDFeo7wPHOg8Kz7Jxn35HHl7EbudUULVFkOe/aIOInXUF7rUejNGfAXLJON3SY635UmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Hzhq94JI; arc=fail smtp.client-ip=40.107.117.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EayDvDPp/dmwfuOIoDLNv/jy5sv/bwT7Pcr+hp2qAcvlKgt4B/NRpbXw6obokgE+KSuxhTBRYppWnZ5VOU5HVVHOKcVc2OtBCx2tS+LAx5ddA0+yIORhP4baubBDgleiC5FCUpag0xHPXTbfGCr86bPmaldl4t79PQYgn++pr8fd85XB3foFXL0gz+9rwsZL2GNe0ngLInPrpZhSoB0LQNN9BJt4YuvQoTaIj6yOYJQVKHYUO4TJe/Zl7AfVQBttx4guDD4cfnbLThPaOCQ8aECf7js+l5k1GEcsDPqX7JvS9/6d/NYZnt4MpVFWYnyt6Fohu8bgqPNQPwpdtjBb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O16c89fsxykpLXkgqq5cnVpUTCPvI9O9YW+Dewzjs4c=;
 b=TMFcEVhTwvwc3DbSj117scEIS2OvBN6kQ0p2RLO8F9duheNJKrIeWZhVXOGAlMfHYWfF5s2+is5s0aA8NsCSZkWJeLMGJ5CE6HQ0OVwQvPOKIxXNoFEHyjiPfaS60Klmy3XYPzkBZPIEAcEJ8XQtXUCZhmeQGOMoVBuEGFqMcSVzAFz8T3FAzdm1jpGoiIMElUIym/gzG7IMrGqv02vlKftMt0hGaBUZoQDLDJ0XIpJu5HlyNO1xPC20mamlEFVjAeSMUBcm1K7uXUMLfk3uwROHy4YiYQEkPdqCPCgqleQ6AMGDgspv6cw/9Hq9QSgUKahWNiFTiFRdlwSDNQqnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O16c89fsxykpLXkgqq5cnVpUTCPvI9O9YW+Dewzjs4c=;
 b=Hzhq94JISiO2of3cb/2LoeIBLSXUud2IjOpg3POwR0UNferCISIoNnTJyA+ziKu13koC9hezLzRkGF9aFGU4o9X5DQstTCVv/+nP2eGzz52/jHjoklZhnMpoakqFlpt7RWnMP+3c3BnQlzwGHnTqsjoweojm9mjDJUsdBrfiOynFuWNQEm1SL8C0NsMFou/rqe3awYNHc+SQ8D75/KxDBFwpzMDH9zm+OQzZGMSlLhVwSjLe3nfXyPso8DzYtQGb3cA1hxJHgu3QvfEThHNxIAVa+Y+ktr1L46fmp/FbicWD2VIg0DVRT4dFWDSV5gjA3Ea74hyiPLH4oXTX0UFoNA==
Received: from PS2PR04CA0020.apcprd04.prod.outlook.com (2603:1096:300:55::32)
 by KL1PR0401MB6307.apcprd04.prod.outlook.com (2603:1096:820:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20; Wed, 26 Jun
 2024 09:09:01 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:300:55:cafe::27) by PS2PR04CA0020.outlook.office365.com
 (2603:1096:300:55::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 09:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:09:00
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
Subject: [PATCH v9 18/26] ARM: dts: aspeed: yosemite4: add mctp config for NIC
Date: Wed, 26 Jun 2024 17:07:34 +0800
Message-Id: <20240626090744.174351-19-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|KL1PR0401MB6307:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d791f2a0-ebb6-4e15-4c7e-08dc95bf9e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4PxnfW30qgPyuaS4g3w0AqTKu0e9d17j8eyWkwaMjATccWSrvcPYeQSr4cER?=
 =?us-ascii?Q?KORZlokGtkBCBhvhlaOFQUou0U0aH+tS+p21n1Yfp/sV9LqpuvkFS2BA4C2Z?=
 =?us-ascii?Q?XFHWBwnoeVn8meyS2x7Jg6CjUG1VQsMJcZQ8EjNAQ/I4GMU+oP9CO24MbNKv?=
 =?us-ascii?Q?WRfPAlpVqvXLGTfp4E2FwLX0/jRhQKKFs0SWiZax+a5Qds25lOr1CKGTsUJP?=
 =?us-ascii?Q?iBHj176RFEdfE66fl4+2g12wogNmiiDQJarBe+QG1OkmSohaivfGADO0F2Mu?=
 =?us-ascii?Q?qEELvRviIcauy1TFnVj1LOWSqzTaWet53UFvb1Sy2xpxdvfKQzXhiW8JQb8I?=
 =?us-ascii?Q?DoGSM8yCfo/nH3ik215Z4tj+S9oqc7vRzTCqjIGGluyBZ7xC4EBgveFddn4J?=
 =?us-ascii?Q?jwW+6BLNuhvQmdYCmzOez1UFRlgOEwjm8GOWgsp4fJkArXPaLDngXRs3PsA+?=
 =?us-ascii?Q?p2G9ANvUGoQgFYzfsyu9hcR7juDWAjRyybCAjwKMruBzZn1LuWVUcP4N/ySR?=
 =?us-ascii?Q?geNZxgt+zThGs+naXHEj8kU+75S8yhW+YXAp3vZzogtJQA+Q8OvOAZ1V+SDD?=
 =?us-ascii?Q?wy54VLZXa3YbONcGE3VaY4i7h7bRF4aViT0bdnQZSVLyf0YjjraJSB2OPHxY?=
 =?us-ascii?Q?ELbJT1WGLNiSvLxSMuV3qNuO0Ki2n/EGIOIOYq44EoN7UFaVgFV37SkQQ2gT?=
 =?us-ascii?Q?FVI0wZ2cHI/DXpPiH/ED1jhe1ggqgquxvw2QSzPeWvdFJ44Rld2+mXMKog/s?=
 =?us-ascii?Q?Jtq7EblahL/ddcQ8p9gaRGBTnxg5mwiPMZMkUp/DXNCRxzLaQQPD3gaio7c3?=
 =?us-ascii?Q?PdUq/JxmGantVh22ksxjDOC6eCHW+E9NyjsjGYROAqlFB4m7G9tGMmbYKip7?=
 =?us-ascii?Q?UGg8P7HhfALINp3+3JkabpnM78peOGiGXnd0/9g5WGuXAtJs1oGeMSjsnuJT?=
 =?us-ascii?Q?MBK4Xgpc27igRHaRbK0e4OgE62b6XsWs2UfOAGOWK0gl1MRBwaNeJmNMsVBf?=
 =?us-ascii?Q?eD5ujN3+FM+dqjLI89wIzEU2RyWmQNJhPzyJ5lyEi4M7hSoBmYEi/1YR69RD?=
 =?us-ascii?Q?P8PaLMpqlVojnptIb5r4yBpP0cfc3wQv0cXlXybGCIciN9//XtELmWcF+Pwt?=
 =?us-ascii?Q?d57O46W5dJXruBO6NdgrMmR90EEi9bNzpJYkxfTx1AUPGydcr+ONZRd0Db8E?=
 =?us-ascii?Q?HIq0QT6FT5tLPIY/X0NM9xPGOEeezxUpos+bIiCt63HDW0HwytGWYt3O62DU?=
 =?us-ascii?Q?XGMZbcPPDKawCnaZNcqGUz7u3vEjuG15YJt2395K+Gsz6i8upcS4fndqQkEs?=
 =?us-ascii?Q?quRQGOGhwBOEGlXYX2quKOCq212RkXZt8vKIqemfP1XXfZHm2Yvxuz+tBu0t?=
 =?us-ascii?Q?C+jMlgkh1Wrianj051f7a13eQcqLbPom7PAcAUCy2g1d4FCUZe+a9c7/vwoF?=
 =?us-ascii?Q?KzjutcpRMXBLcD3QI/ej7OFGmh5MqFeI?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:09:00.4738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d791f2a0-ebb6-4e15-4c7e-08dc95bf9e4d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6307

add mctp config for NIC

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 59615a6958ec..83c9d76f5a11 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1281,40 +1281,64 @@ imux24: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux25: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux26: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux27: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 	};
 };
-- 
2.25.1


