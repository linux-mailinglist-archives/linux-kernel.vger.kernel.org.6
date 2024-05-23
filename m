Return-Path: <linux-kernel+bounces-187237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F458CCEED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FAE1F2201D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4811448C0;
	Thu, 23 May 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="d+ynekwy"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2084.outbound.protection.outlook.com [40.107.255.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6E1143740;
	Thu, 23 May 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455920; cv=fail; b=MvYc5ZpCLzBDFU+x6S63IOg7uSgQ1vWv4U8MI3TUcwHzm1MfyxmuM9anUyrc3B+ew3uLbMR0ie7I1Jni8Llr8xdXE/clmo60ZfmnYe80FewublcfolzPtEJhGhonMp5doIneCdw2YjKoYdLFFukh+RY8uFo36Q8ACEjgE4vl2cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455920; c=relaxed/simple;
	bh=p46/iEbtucdsAZ5iLyBpexuMThuhsad8XBAxzF3ngFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PS6wTDHhxJCwDL1MkQFnRUlnHjdHWEl1fhUbmrgnjkSSXdv3ED1+X5Z9rEPLJlA7Fiv6TdRNdZLeZ4Uvv5qgt/t4ZRn5KzZM9C937YVIB1diYiHYfOZXx4p5BY8o/2ES9OXDqMKDWczSN3Hk8vjq92qVyBNnzBG0JmfhijylkTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=d+ynekwy; arc=fail smtp.client-ip=40.107.255.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUFQpcERy/1Povk3WI6QI6b5z9qoBrrh6nX2ftbeQ0nlYcEDYJPZDIIrgcWMibo3NVGvW6DzjvUC7pPEBKg13oQwjIbcXz+bm0Zc/Or6becv+SsGtA1ipfYH/I7C/xoIkgX9//BUweNl7f1PPyEeEk2Fdp+ECcZ3bAEwknnnJphPZLbUqGoElFxYfxH7V8mEFz1lU6h3GRBpXjLjU2AIgPdG07ORUvjhS9Hzye4WgSTKwbWreCUVx0GWxvHyKpx9XfRyv8FqF5T7d+ifHrf24qEr+gHHtWdvXBxSkK06f0IZuAdWpBLb+wxED0m6LWaWVhhHPcMifjhTVrvny16EEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFKimFjZ/HhebE08E0uoD3C7UlaPmpkE4lfEBFrj+a8=;
 b=dJd1RsnrsBEP3KTR1iNxWM2/4nHQn4PPG2pLR6TeZ5SWWc3FyKDiCOFPPNiiRJTL35pFijOQofS9LGCu4KgiK84HxF6A6hHHbPMsVl8y8B2c0ha2ayFGzB66rPJAxC8qeWNusQnWroifhMHbLhUL1RBO//9/syu1WLHd0rvicuL0cgVdUeX+229wBBYCGbrzIoPZywey9a6T7EUNqsYr4hU1AXfM/3ID9PEGg3nQiTQb7j4+VUpIi0PqZZde1qUmCtEp2jOS9UkKOi2f9GWsHE4EkCbxB7w+/BFEPCmOQGsWXl2yCgeVli7gS1AAz05dCAqsGH47RxURNnMrmEgGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFKimFjZ/HhebE08E0uoD3C7UlaPmpkE4lfEBFrj+a8=;
 b=d+ynekwyw/3v9dXSsqU8DSkxoHpApcwMhwpocWY02ZyPd8CeNMObmcvsLppMgrc0BuUy9f/7+QUo4Bn93v5YCVrT5lZvovdNaNrWbm+OirZIC1AYI+FNWsecbfK54Q4LKj9Y33iyldL4apcxQmgYixyAY/d81XskbslB1cH+98wRoP5Gf/l9kTlCxIqmtNy2yu4mJfR1vMQwOtbxo6GcFStmQTmWIdLiDeoVZ+dh09VbNoYVi75lLO0d/CT9SxGi6IXO5+ThXaHg8MX6qByZ+zPPkI6k4ShH/wa4T8bQd3WhgO0dS0EViXMqcv6m43hrEpks2J5XC1Vcp9dr6CRKtA==
Received: from PS2PR03CA0008.apcprd03.prod.outlook.com (2603:1096:300:5b::20)
 by SEZPR04MB6708.apcprd04.prod.outlook.com (2603:1096:101:f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 09:18:35 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::8d) by PS2PR03CA0008.outlook.office365.com
 (2603:1096:300:5b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:18:34
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
Subject: [PATCH v8 06/23] ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic change
Date: Thu, 23 May 2024 17:17:53 +0800
Message-Id: <20240523091812.2032933-7-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEZPR04MB6708:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 85661e84-eb9f-4ec2-c072-08dc7b095294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|7416005|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gmRykPM9QMK5keVb8R1CLqgVmiKuCMfLNWZQFfWW2pXfjXFkUvXxIhweU6ll?=
 =?us-ascii?Q?5SVc9/6np1VjAnn6b1Evcyx5YavPtK2mSxXDpv5zd3mKtQp8bTFJXF5cfxyz?=
 =?us-ascii?Q?Uk+egHxSSqfoUdNcOknEePTchRDcA+3/ssJ7UaqEyneoMADNp5LOCsg15KBL?=
 =?us-ascii?Q?i2iY+DfQ13fMUk32OA5Ei8btpKHp1PGkktUFi+hLvshzgA1NzuXBqCIQLxzM?=
 =?us-ascii?Q?Bt8J7SUJuEtZ8F/cDgGpEguc7eeoAqKFtLzmlATfaVlO/aFAAeGJgV9k7t25?=
 =?us-ascii?Q?tua2VSm+MyofmiTtKsGE58yV249gPbC4v8pDESZJxRbGmzqnlpoZrh+kpR0I?=
 =?us-ascii?Q?VIBWITbDVk+vCqvKF8wcN+YaZWkRCtZ21dWv4hJcMVE6POy/HlSCTclECNVD?=
 =?us-ascii?Q?Lbp/a47erZixHKantYK6M5PTllrgMs7BylvJd/4W3D/B1HClCtcSqao8OIZW?=
 =?us-ascii?Q?gfZJJ8D9uh1Cv0G01paS/D+rw+AWxK1TgzF2roAK60xJoNIrck6nXVVswJ8W?=
 =?us-ascii?Q?/xgrh5AJvlC+HA8fEII8IPXO0IsxrL+mWHpN9eluD0At5yh8xy5oTJV8y5I4?=
 =?us-ascii?Q?pr0If+lcdU8DLew9aLF/kpdmKNDnd64BdmBHYBDHK3VQXheEEOJ5y4lI/8VB?=
 =?us-ascii?Q?gteFrWlcG9s9eRvwfa0Ue2RZjWxqwQ7+F5YouPtFe5lnYq1AvOh4V8dlA3gq?=
 =?us-ascii?Q?PAKvvWAoyar2U6UAQsKbFBwGd5QlW/POgELozpaZRWUzf1QfLL21nLnLj0WM?=
 =?us-ascii?Q?zuz94VH1KIka1yAiYjovNoAqZzZa+sWEqVQV2o2zjNEm3Uiii+tpZBfidgyG?=
 =?us-ascii?Q?3M8rBZFtDKVcvVAxL1tp02CIzbpyHLkoAYStnRAGcbLjdZl4sqfybCk0M56X?=
 =?us-ascii?Q?Q6LwwIesGhsbMvqg768Y7pd/KayPArxXXmv/vko91nolCnlD6urXe7fhk2hX?=
 =?us-ascii?Q?F2BHM8UnbujKRhpC/52PxgW6g2c7kujN9qKkHOvK0DQaLlOZMnjrnbHrnML3?=
 =?us-ascii?Q?Jtkudk5EEbWrQr6hdhLmI7XJQcDDAMIrgMHayEqadCozVZe0++0Qb5IL7poD?=
 =?us-ascii?Q?bKyqMeg3cRn9d6kI1vrXBykFb2sE1mO1nMjJyB+17w1xRbMPEte/ua3c7uZA?=
 =?us-ascii?Q?B1Or1cD2xbkxdfceLYaEeyMDYdQIUc23fEIZNr9Mlc0K8NOi/GPHGpBjrM+j?=
 =?us-ascii?Q?O6RCV5NYFbe53eL73/YDAo9fnsgxXE6DOOSgTrq1MIPyFZp3QDYGsKF3oCtf?=
 =?us-ascii?Q?vOMws2W7b1yygRTTE021o24nJHudO+K+TGm8Kj2JHd857yKq9W8jV/BI8SC1?=
 =?us-ascii?Q?PsFjjkdsdl4Odpkw/hu2ODULJntxgsSDN4/AiDRL+9qDuFcbYX0Kv26Xpk6t?=
 =?us-ascii?Q?F+HPrYk=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:18:34.7357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85661e84-eb9f-4ec2-c072-08dc7b095294
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6708

Revise power sensor adm1281 for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index a708e56b7ec3..f0f714c7bc77 100644
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


