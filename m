Return-Path: <linux-kernel+bounces-259821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE6E939DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1991F22CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF21C153561;
	Tue, 23 Jul 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="etAlQHyY"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2080.outbound.protection.outlook.com [40.107.215.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679EA1534E9;
	Tue, 23 Jul 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726674; cv=fail; b=MRfLI7cO+yBxrunH3gnRsA3XQ882rwH3+52NDAfIzg/Jm1b/VXu7G0z25NloyP+S6zlRpA8AVoco+Qul6NZk9d36eTrf8rq3aPvxF6sIc+Cy+yGDwP2InrcwmUQCoeXdt723XDFsvdjKTAjSwvuwHok8YV9eftGvjn+27x581po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726674; c=relaxed/simple;
	bh=1cxP5pczgJ7valwzodgjXvVTCSFyJVT8lUAovr6nm6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILUa060J1t3dKadGLDoTtXQrUPuHM3yHYEiXPl7PNJBq1QhQqK50B4uPCEIvciAYLpqNxR4nWWYxg9+ZacfOV6s36uMEDIyjHwCyfzzD4AZxu7pKZHjYAwWSQH2FHyjdq/JBgTYxBU40X1DNp+7X8n2rOeXilaYFMQ5oRHFRYIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=etAlQHyY; arc=fail smtp.client-ip=40.107.215.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwgNTiKsU/AXpLQ8M9iQlcL/phYM2TSIP88MzoRKKbTpmyICf/RuIB5EXL+xKbQ3qFLLA/QAXcw5xr+SNaM989h3CemUCdawwnkyMkOq5R9toWpVbMjoZGh4rpwgfsmugcIOUUudjIXXPHKCzqPjze+mA9wIeTlUajZSPOiLyYNUVV00Mh4Kgdd/JAUN/5OSka9tA+SfpSc+gz/C40Dmdliogft4KhG/Y0jihZHE56h5JK8nWvxAuY6pL9x+O9Dgg83Z8PFxwimarvSJl2DVZOoiauagfZg1SubOOFJNJ8W2soa1JjtP8hXTZ39e7GI5cLKoJFxDf8GbnYhu48rI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deWOYRp1IarhLB5qRFgI0h1ErIRC5JkaB/gNs5HJuG4=;
 b=PU9viYZccI8rEzadN95d0cxKWzHuQSDj8dN3mNL339j89OmBJK7XVu6Y+hBL3+Dcy32G5EbZC7347CPpZTvQEAkdvbc6tjHgJZB3d4zlv+EZP0wJRkT6NVzCBnKRNwtxuAvO/8LyuR1AcrmHVx/LyOSlpLvHZgvagG9dInuYWv2TwFMERvbARbPafPZMkrN036K0cLdJ/9P8CArBjcgFqh6RrbFDE7w12kvtYiOnLANfPDcG+/W28jcNhVnNF/pwEUvdDc0Edd40KTupw+uR9UKqRRlutQAhPeE9vn4oxJJOs4AK0nK5gDSNRdyJhf0dQq6doxdfkaxf/I7/Z29IHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deWOYRp1IarhLB5qRFgI0h1ErIRC5JkaB/gNs5HJuG4=;
 b=etAlQHyYNmmoiW3AnUKY56SZWeaSy5kXQLvJ7/dTbJvAM848W9iNRwZCGgtMGjpu7BZ05vtkbYAQEyf3pjvNqmWzQAPNBiMCM+A/ZIHtsLlieYbOihbztawmbjop1hKdWvDIRPFk4gwh3aGdUPDQ66JKuBMpfpFufeu7EudCWBqLnjH4RtHpRNNNyjI3khb48kSKRZtPxntK379QSUyXMlyRnUWlBCvY1ouVcVshFs8aAhAje7HfeRhzFObzvBGI48vemSjblQPaGiNACCqJRdGrdOFVex6LmcETuwEFDZPqbwtcK2hlWhcC/R5UC/fTjphcz5ZMiYar24bnQeQVwQ==
Received: from PS1PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::17) by SEYPR04MB7138.apcprd04.prod.outlook.com
 (2603:1096:101:169::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 09:24:23 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::a8) by PS1PR01CA0005.outlook.office365.com
 (2603:1096:300:75::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 09:24:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:24:22
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
Subject: [PATCH v11 18/27] ARM: dts: aspeed: yosemite4: add mctp config for NIC
Date: Tue, 23 Jul 2024 17:22:59 +0800
Message-Id: <20240723092310.3565410-19-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEYPR04MB7138:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 70ed04b4-5902-407b-dfd6-08dcaaf93d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZohlssJK3UFUJObRPTiKHvmmeFBRAv1/nCZG46kBmP4YyPMApRUgUFAyOaPW?=
 =?us-ascii?Q?m2boOwmCijMuyLipLj8J1OLexh6cfcJQrtz92z64LlT57YfLncAXVy4GibKZ?=
 =?us-ascii?Q?HRiQsGHcoW344HQUu3NSLyvaqOn4jkymI3noFDrAcEvnIri70Hus6RbNyv5g?=
 =?us-ascii?Q?9KCYH679cZ9EDExgZZIogD8F0STBNSLNwYD43fCHgylJ3snEVh7AhGJnEEyh?=
 =?us-ascii?Q?tQhe+s21dYaVc/gK5rK/pGOqyIiO3ksZvdnGU2WOGdcXrUI/9c0ul5Du6UWq?=
 =?us-ascii?Q?4O7GPyW7tkMUsee6h0PQCDnU+b8OqaAt7ESgP8jBgJ8gOvLaDcj7CGmbHymu?=
 =?us-ascii?Q?vPHpu1zJR8ZeBRzLwHSoCi8bO05It0xOD+41xMPiJLp1jne+Be7zxjAPD28I?=
 =?us-ascii?Q?CJq/BzpR5ZDgPCsB52PYi88iGeTh3mjJJx8epWStRlN8nJKiNeqkHmL4KRNK?=
 =?us-ascii?Q?r/i+wqkrgmgfqFhZ9qpmDe4eDrJvA1IpHpr2boogo8TPqdMQgthW+Tte595w?=
 =?us-ascii?Q?Axh7id0KoqLBpG8VhsIs9ZndtwTI42kSjKTNnudevnjz6Yccw+LMUJQjY/CD?=
 =?us-ascii?Q?uAtMM+sY0MLnLlWc262WlXs76jpJ/bN9GGzSqhhIWSGoW59vvgzOvjI6qGjS?=
 =?us-ascii?Q?btBfzYN1VaYnGebVIq1nLQcOtXG437yKdrem9UQcEEpCDiHbRnN8wZ0KN0pA?=
 =?us-ascii?Q?z8AjRKBtICVsb9BN3t2HXCQklTgJr1YNI92CBqRAFrvbM/BesSm/2aA+7zkz?=
 =?us-ascii?Q?nbe/Bc+9J8AJn2rhFYmywpT4J9ttU/uxBU7uyS3s4Eg+OORVXGi0tUR1JJh4?=
 =?us-ascii?Q?gZNC4LSrhoDBmIgewFk2TTKhjPlDkgH6dPeAb88pA6byr5EgiMWXgyxWJJY2?=
 =?us-ascii?Q?bfVX9+jWKAu+DrX28X7Ng27syZ5T/e04xbkY9DAJLk41HQhWlK4O0AgS+Qzu?=
 =?us-ascii?Q?1yenJEiakMfsKF9k8XrLG98U/0zeJIA10UFLHB+XKaOLjdGsJWO2wEcicQt0?=
 =?us-ascii?Q?s9hFJwRFrGSoUAcsjyxJiTjxiJ1L3b7+Mwp+pTdVn/oKEggHnmxdre2SBKpy?=
 =?us-ascii?Q?JaE6Exwgi5f9sjbfyFP1fb/yTFQtEzicdi0h5AeIUUoCHM8C8Qj/aiWFRvSo?=
 =?us-ascii?Q?cexY9poJ7nRrJGDpP0/lql643n/9XMhFzjXdnWMzgpYWiyE1syn5qmcefkU4?=
 =?us-ascii?Q?VqcC232GmXdArEu3vdkX89fPztV3WDY5P/CBkI1uBVdtFgD9u+JO3WhLBKBX?=
 =?us-ascii?Q?ptsqcLawuWg2vEPUkFsxpH/39UCdB/eIHbOVcNM8pWqb7WeDJ3K7/TOVM1aX?=
 =?us-ascii?Q?dXO2HFlClkb2eIDANQQCx6KSFn0AEMjxpiMnlgM/kZ4LLQmtvmIVrOIv2QdB?=
 =?us-ascii?Q?EBpZa9qYb/xULLcPQXXJTpVkZxgM0W/NLgCBvgLyt3ROBb88wmUfrGd+PE/I?=
 =?us-ascii?Q?nSxaAJ4bKymPlZQ8p6kMBGN7+j1lhac8?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:24:22.9571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ed04b4-5902-407b-dfd6-08dcaaf93d55
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7138

add mctp config for NIC

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b46a0b9940e2..7b8a2384d99d 100644
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


