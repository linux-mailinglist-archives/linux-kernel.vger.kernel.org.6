Return-Path: <linux-kernel+bounces-256989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5139373A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11CB281036
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4622685656;
	Fri, 19 Jul 2024 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="HHMcIknJ"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2077.outbound.protection.outlook.com [40.107.255.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461584D2C;
	Fri, 19 Jul 2024 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368823; cv=fail; b=LJI0NGgeVirAUUgcgx2+3IddaRUFqqckjV+q7n8GHPP3dWDSdT0k5umRK6TQcbFKYoCwcuaDUeKSBWFmwySpR6Y72Ybx34l8hsGV+GqP7LBxqXBiBzPe6SW8iJJdqSd8H5u16w+gZ1wL1UF67ARUpktzsLjc8kQfFOqUxapYzQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368823; c=relaxed/simple;
	bh=FReh6MBF7e+wsHlImkrS7+qksdnnHJVP3YlsJeVxPf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBO0UjXL5MpFho8XDHtL46BlQ/NIqzWg2JBSjAqhae8Emwpzz9V28BQ9cxe58UVqNHGx4/T4kL3tsZJip1k9BaCx73WoV9W39RPmYUy2PB+8J5Wh2geh76I+AX0eue8kL+LD96WlgG6biUbJPhHbIq3dSoRk7G6UZi+mPu1kD5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=HHMcIknJ; arc=fail smtp.client-ip=40.107.255.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUSfmMbK7dulFmLFrC6x+wd0Iv3Ap/c0Gs1lw6g1T7OsaLprmxgxNd3mjxkLlirMbxKYnXRjkXGsDDC+eVdT67wd/rZtuEvFLbhostrKHCVD0tuBr2DLiX5UBUajq5jsaGNqIwguwMkIk1n+aak2ARjdpZkOMwux8pPDPk79RWs3JmvmvGMrPdt5Dmv8g2D8yxb6pn1D+d2hwoSq7lzGJpTl+WMPLdxgoR7jyXUCYgKxMwAD8bNM1Uw2zyLOFubA257JO2f9IgdJ9JdlpuQ28SZmsi2p4kYHxE0kOY8Cp3bHjcs6kUBNj0nx26an8Qir90Fqt6f+jJS6STKxIAHUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrss1LFTszE1pis/nUOnfDY03qkapLfO8Yjsln0bIZ0=;
 b=M8IlFFYZc6C93QrRRlgpUV0JFVqur6nVUgrXArXBBfM6nlossHJfZ8FhLJphVhTW1A7zXtU+pa16nLVa7JTHkz2ShF7+uKSeOpyyBavm69mUbDvImcT3LonrFzceRulzF0NGOw2RvWLSHr3TRL+2j7TrMSOVOUHGkTfuO2iGUMTe8kkhn8vB7o1v5IHxmAIZ4Zd9HQqZ6Q+h75Zl88Ie559WMVo1Oftj8SP3uXjYT+UEF/StCW21Q+5m3B9afdIVgN/dW/Y0bXQmE7J+h8Dv1bj2CtdMpYc3R5bqk7QW3rAsw5PLo8JSD4ex+Bf7qyn7dDbZm+6eG/uWnvkt9VG+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrss1LFTszE1pis/nUOnfDY03qkapLfO8Yjsln0bIZ0=;
 b=HHMcIknJqVS6GCXZ5clbImsCs1BoCGMZQJ9r9o7/CglgXV4fp1RpXseflF9drn2khwcS1z7ilo8lfDIe2GAH0bzsX08GWag2FhGxKnCwmtW3PU5SbRjuZp/hGy1KrZzPJeN/qZljv2HtAOFG43Kaw3xbMzNJfkW5bfbPpv1EFHhbkAmdSF1dgaj4NNq89/1Fug97IhXg4p9t4MGwYE7AVJ78anViBSfMgeKbPSBSNmozcHb986QZhuj0X68dgPVzUhBdkLQgocLOLQGihrTqlKW3UZS3t9P58GGVZ4C08EovCrRi8XAQk3XjqAqVRBhU+vUBEgHcCVatHWjW3A78Lg==
Received: from KL1PR0401CA0034.apcprd04.prod.outlook.com (2603:1096:820:e::21)
 by KL1PR04MB6899.apcprd04.prod.outlook.com (2603:1096:820:d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 06:00:12 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::d5) by KL1PR0401CA0034.outlook.office365.com
 (2603:1096:820:e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:12
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
Subject: [PATCH v10 14/27] ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4 schematic change
Date: Fri, 19 Jul 2024 13:58:43 +0800
Message-Id: <20240719055859.4166887-15-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|KL1PR04MB6899:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6c3485fd-70ec-4824-82c5-08dca7b80dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|34020700016|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eH8ZUZNy1VIKqxUszTfCuWQkaNuM0zC3KRz17xYLH06rU4HLPQZfGCXmpbtp?=
 =?us-ascii?Q?XpJIJqHbzB7PucPPckqQktvUOwktJQ3rBp9ht6d15wU6J9kg7JHjMCbYVBwV?=
 =?us-ascii?Q?Wv5kVOjvWxrY4M6B+nsSPYve9PkqpWFkyzTXi/lgHrNm0+qWygfFNa7nyGf6?=
 =?us-ascii?Q?Edt7gZOMUQTtTenSO9aeRQS6gdGFMiB9Z9b35o9ZEgImdFLZfmyBREcBRmYl?=
 =?us-ascii?Q?0zr40JAfLMSMd0ZyrqnHlu6JbVDjB7TkEgDUyBNOfDLWbDC1Pag93Xbrw9ET?=
 =?us-ascii?Q?ElWv9a4Twye6A+DB3697mgBfE8qhEMKm0GfZuaXi+BsPIrHr6wEQBat3XGAP?=
 =?us-ascii?Q?vNB5goZNp024VClcpLd/q17lgg397SWe1nxOt5YMN3fR+cksEwgFTkGxr3pV?=
 =?us-ascii?Q?tVmcDNPs6vTKUZYFuPChY7Xpaec5CQTtCwxaYkSI05g2wjlc/9YsntQzdnHy?=
 =?us-ascii?Q?tHF7t0Tcsa2Qnw7PG+uO42Its749KYdStBKPJ46RNST602NOalu7+E2A2CQ1?=
 =?us-ascii?Q?9K/BSmODfg5e9fq7gM7Iw2/EiwyCo88fgzChiYiauaFKmQC7/Wls/FDQ0Sxu?=
 =?us-ascii?Q?BdsFU46v4nH/4kC2qQAbn30Zg1bMvvCqOngLXYDjriYHqupXMo+QTXzISsVJ?=
 =?us-ascii?Q?GXiRPgALqbzBKUjq///ddHikhHkW5YFT1AMfkceMzpdZodtJTZFRycD0MgvJ?=
 =?us-ascii?Q?QDEvbk7DgYLw6zW3kqAGxddQmxBKEutGSTRsgkfGcSwgQcFBwWxZWv7dZlUA?=
 =?us-ascii?Q?8h9VyUJkLjlcAQtlk4hHy9ogHMC9hbkDPpvDux12KL3uHb+IJ12nY2xsNBXZ?=
 =?us-ascii?Q?KQhVNc5SYjnAMO1MbjvLTeUjxMDtsGABHV3TS2CxaulC51RkmpWJmpKo2u1z?=
 =?us-ascii?Q?94KQ5T+Pr+aBjILvLBGzOhJXizHYh19oYCas+fNMfUpTy/9CiA0F4BqmPO7J?=
 =?us-ascii?Q?4mzPEbxzom/RWldHjVY+9Wi+Cg27kQm/ZlWO9xJZ3+xFbKHwfFSbfNwWu3Mq?=
 =?us-ascii?Q?mMbMGz0X4PMvMxWy/2W9Yfa7JyLwvs74IP6CFPAw3G4xd+kbPdGy5PZz3SiI?=
 =?us-ascii?Q?aCBv3dy6sKf0MKNd0IxmQK+Vgo7rSh71A5psCIVpJfexo0lqEQe5mDgbxCFK?=
 =?us-ascii?Q?X21sGn43AGBnNqkaA3AxDgAqzCaWZeUEoQyKJkyTpE7bhf5NDlzeWbvv2P1Q?=
 =?us-ascii?Q?7TkLah72XK4wpyiV/nXpmEepUgB0LqGC/jtUmOSnsFpXaabEju8X04C5jtMF?=
 =?us-ascii?Q?PLTu934YAx3qVQ3U9FcoYSeiws7K6Xpi9xmG/9Iy31+BuVRaDD6RTM/nSLee?=
 =?us-ascii?Q?2hKminyBWGR37NdJQBjoAwi3RG9dvqGIe5TbiByTSFdxIXa6azH6UN5jD0gz?=
 =?us-ascii?Q?nyHAr4bDCsQdf3xvmsgShaXl7YtBJ8ENKC1m4gjfH0JuL1aXsXRlHpUp6tMn?=
 =?us-ascii?Q?1bBSaMiy2B7AI44KmnbFDlYy9Rnbt7vn?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(34020700016)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:12.4701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3485fd-70ec-4824-82c5-08dca7b80dd0
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6899

Revise ina233 config for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 0c7d85ff4360..67e3c787d675 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1034,28 +1034,38 @@ adc@37 {
 	};
 
 	power-sensor@40 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x40>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x41>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x42>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x43>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x44>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	temperature-sensor@4e {
-- 
2.25.1


