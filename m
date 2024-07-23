Return-Path: <linux-kernel+bounces-259811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D139C939D92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7DB1F22BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E024514BFB0;
	Tue, 23 Jul 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="u5z1wk7X"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070.outbound.protection.outlook.com [40.107.117.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C65614F9C5;
	Tue, 23 Jul 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726633; cv=fail; b=GDeeaVjSxkc4nrul7ytWZUOU40XuCPWtS8qa+RsbX+L/XYKOmNdg+SEVa1BcjA4JtrRfx6qLrjE793GknhvII/se6CTNjS6hTwN0mXNPu9lE2RsDfsj58QVDUM/2CuE5F5Kwlf9TAiY2lsgfBTHlilcf0CfJx28uCqwYXVFHI5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726633; c=relaxed/simple;
	bh=NPl1LaIuLqsInjrJcLDVPdw8RVKGkEQ+SanwCXdYN2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlMRd4FXb9QEFxplhv6C7iW9PanFf3U6HtRgHsnGVghzycqfjNyW18c5ORq0k11E5/liCmxYMzA1U4gs7pxukbsrJVLpk8HEoyKAQN2JGKgFggW85FOpfwmPT5DN1vXEbzGmA1tSzNzQUYnmhzIR4iK2F+VRbNf4yKd/6MEucOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=u5z1wk7X; arc=fail smtp.client-ip=40.107.117.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7iAlICY/cHGZPPz+cVVAo2p/9yuQxbnibXHtcS5IkGuW82we6rh4WfXNtGntOP57lFbyr2t/v8n2pvjJ6rT01p9Bz3/lGtbdb5ldM+2X3zmHuweyHEClOVVpj8M6Rreo8Bo7EHZe6dHLel4IKVGO7KBFfH8CCEaZPDbpwngEtuULlMkPPe8QEGwwyrV+upLCovHRaQLf0VSpTnEeeZLjJvuayIElzZbnn5BxKtr05qjIrXpeNxF9W4ZU/I9NGSfCsba07Sa8qoSI7l5AmKr9eArLgqT/53xTh+NavXQyPp/g8Xf9vhEtPWS7LFG/imk/Zxeq7eN5aZ5P1h/aWo1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwPnCRRMIs7FMuQZx/G2KDCYulqMsDb1BS3wTt124H4=;
 b=Y8tw5V6I1SbZ23IWlRS1NHsk9GdHzC44D2Cog9hhWBBKup9CO9jvE8GtA4be/23DAJaOZ5BuWjfbgbojuLTUjXsbYxyMpSQzHh/mRk1Dc5FuIeDYYiuuTzmO3cpyPiM2KSGPWsRKLc3byB1ZfFi4is0kWSfb3unAPgQ5bYpE6VBsVANSsHaQNKRljKPZe6QiB57pNSsRNgKx3sHWGymVdy4ZxorWk/PKelah+uQOetwK15RIXTXPTU+/SEHNTi/9AXVwlgqSKZIGcIQvd/etPXKLrB5yDybtPqjQszwexae+ZAZdsWa0Tmi3vbchlOYNAbSSvcDfxibQD8ulaNTdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwPnCRRMIs7FMuQZx/G2KDCYulqMsDb1BS3wTt124H4=;
 b=u5z1wk7XuqlsBKf3tvN+ZKU++6DX+cwWvdTx2I7Qi10yr6X8qZhbRpa+wSRpZWKK8dG59669TTtH2Zuu+Q5hJ697zKXx3T0kvu6FMznvSKIJtoP4fY4Mupmp95cN2SKY5CJs93qq0+kG4nsH6/W99Kk1C0NAEd9m38ZyPCFv70znCdSiwQBCznZ9FdVgb5QhJB7RZ4qkOj6gxRi15qA2pd0q3uDL5rITs3xLXmRUkspjyyzIIp14EpEF6HadClllW1oC+f578MF8r+4eSGl6nYPm+uiT/SXHNlQogc95zF6kBvSjOHTqd/Z8tj/YHm9OSGFbMbTsnrZtfGDuHz7qyA==
Received: from PS1PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::19) by TYSPR04MB7127.apcprd04.prod.outlook.com
 (2603:1096:400:481::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.9; Tue, 23 Jul
 2024 09:23:47 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::d3) by PS1PR01CA0007.outlook.office365.com
 (2603:1096:300:75::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Tue, 23 Jul 2024 09:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:23:46
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
Subject: [PATCH v11 08/27] ARM: dts: aspeed: yosemite4: Remove space for adm1272 compatible
Date: Tue, 23 Jul 2024 17:22:49 +0800
Message-Id: <20240723092310.3565410-9-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYSPR04MB7127:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5858b25b-05c9-4597-8196-08dcaaf927d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8aT6ox16zjc4m9OysYSyKk+uJXmU3pBXinaD2bD//xMUHFGEIqM0fkHvQfwN?=
 =?us-ascii?Q?y+2ow78Q6wpL6tItK5iF2NLUgU2P2vY8Ull8k06Bx/n9cFb7qflxCgMF9PDv?=
 =?us-ascii?Q?pxrEa9aWYlhJs9L6Dfm202Sm5FvnUKLuW1DgNaldCTyJ5bJfU3o7rgyYifIO?=
 =?us-ascii?Q?6mOmp7Ct8vgYHjyZmtnyII8GZ7/Lj4A/VQbAksDnRjjoCp04P0mz3VIiEB2D?=
 =?us-ascii?Q?V3AOS20mvG8Fd8LZjWK6hKLNMa8/1Vw0Z/qa1YsuTfNFce5FRwSO6OeIXVYe?=
 =?us-ascii?Q?H6ojlB+MydRKWmkPc7fdI6PxfOSBfuLmEDAs+ygv9xntj7IM8ZrvR5MIaLIq?=
 =?us-ascii?Q?bHIqrWH0FALFeQdn9QSFlSZuQpBzQNC4mxLeoNs+ShxeKo5MB3mkcQeDt/YA?=
 =?us-ascii?Q?fl/hY18as5SmcnvSbMQ0/fIoHSCI3K1BFrTSLx0cIva8jMzRwvm4xhnwsrJ7?=
 =?us-ascii?Q?wtEaBgkWmKLZxojN1cZFtx7FH8xg/RjiO7GQehZLvR4CHSFwtDnc1OpHCVoB?=
 =?us-ascii?Q?B2TUnXFI4Yjf3uQCwOkZRxXYIimWhHSPSkNjuOxZTPg8XDqjGipiiy6Z7lKA?=
 =?us-ascii?Q?1OlYv1DOcixxdNCCeQuqNAP1FIL/h9twSJnwaiuu8tJHGLiQ5eapsKolM60W?=
 =?us-ascii?Q?o8EKWnZgzL5CRkKnTS3nMjPirF3eSCTdLOxvGo41sEOLQzo3BQYRXB8kiFq/?=
 =?us-ascii?Q?UK1XIAYfRJipc2JTWzVhndeqVRrMGDUoDmVIykjQA/BH7yXyZub6bVsqa/7c?=
 =?us-ascii?Q?YSjIAD32gwDPOk5oZvkepOCxw8b+jw7TTGFvhABOlcTuAhasMhi6rfz+IaG5?=
 =?us-ascii?Q?9PMmzMgRuLU1Lz9ZfuzDKrRLWfmTZ/vGXqQ4BFShiddReJLGvw41rputOHoW?=
 =?us-ascii?Q?3ep+hanGppYZQAmdFUch1ryGDK3Q2lKXjdElTcpzVeQ/hdJc6g7MQ+bzQNgA?=
 =?us-ascii?Q?XTvdkeFCeRjMFjzmZFTdAqQMk9P56yH3L+4sg15aOpY99xvOVhrS81Z6sAfo?=
 =?us-ascii?Q?6+9HjEBK9gGNR6gNiBdP0FiGCErsuvNqVlaB6AS/pW7MSoSInbBAkoFHOH29?=
 =?us-ascii?Q?ryzFHMtSURcN5zuwrmf3kTRpwprAJN+fsnx8JlaDMipUpmE4VJteWNOk3gu0?=
 =?us-ascii?Q?xlRN7dMqFROYlCfT1ViSfXBXxAq7+E8Ew2B7jj2TfxqVs8hU10T12puxmaNN?=
 =?us-ascii?Q?U8hQpuupUXuy6Zwrmie+lGONXxzCP1YbAOG+hWwHQKAT6ULdRQV6oYoqiHRz?=
 =?us-ascii?Q?X7mU3q34YcJDrP80xAbKdHKJzF6bvOGzslmV8B1Cyv2naJNzqb5oviJdO3lW?=
 =?us-ascii?Q?sBM7IWhHTjNTvMAfZHmP5HNKUGctyQcaofGTsDIEtPQPbKUMEL3JTjP4vMXT?=
 =?us-ascii?Q?78OS2V8qfJ4uuw8IOm7hmKU47aaAQBTPftXd95/YfLIUmMSNDNAs7gKDOw1B?=
 =?us-ascii?Q?sxiXBcqJ76Yoy9aLGLYOIlHYib2Fnqcl?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:23:46.9725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5858b25b-05c9-4597-8196-08dcaaf927d9
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7127

Remove space for adm1272 compatible

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f4d27f1ffdb8..b11951c2f71e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -821,12 +821,12 @@ imux29: i2c@1 {
 &i2c11 {
 	status = "okay";
 	power-sensor@10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
 	power-sensor@12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
-- 
2.25.1


