Return-Path: <linux-kernel+bounces-256990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351229373A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA591F232B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4659155;
	Fri, 19 Jul 2024 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="h89el/0g"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2067.outbound.protection.outlook.com [40.107.215.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669F55C0A;
	Fri, 19 Jul 2024 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368823; cv=fail; b=BcWpSIPm1prwN+Jcq1ptd/XqUCjQ9fBWo7BcbIhxNDeFmJ3JQK5Wfktj8ne6uUpykbVnQG+rDxXf/P0tko2reVRp69sM3arBBO05mZXqJG9cYt5MZ8ULGKdyrXXA1mVcTmODNxalJfbQ4zrcL+agLfFfTvKPTRf+Bwn9fo8I2wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368823; c=relaxed/simple;
	bh=zxSLAJW6pbU3CgfYbjG8pJzx4jH9s83cmqcWyMwgprg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXOwzExhDGHZ0xCAL0vWrUdeXB3lR7NzohXaXO6GKs9ZIJIvRKhryvMOdW+2s/W69tozAmCr4+ZBIVZn4DM3ueH+4RcN3kXJfQnefzZh9ACjpKqOBAaYLZDpy7NL/ANaaOe/zcVkOmFjvXMTgRD8rdc+6MR5JaYrWEg8zxOdbp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=h89el/0g; arc=fail smtp.client-ip=40.107.215.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGFfrCuHPWJJjJ5nuL5Ss423f0WTWN4+yNW+X9p41RIK+NOH+BsTTh2RN9R1hDkKcp3NZU5EQGgTAN2skr/u0auirogkcqxuRboK8nT6nJVQ1+9iZQlSoq+TbsfABYXIdMJGTQ3YQhOIwjN8ltrQvK+HB/3/KhGabZODGX2YohyXN5nTH5H37xAerGNma1W9R/0fkSKxR92N52YEkgu8l4aohEAweoxpurshcLCCbQeAWYhRU0FgS3xWr6HvmgP63EDpHc9MRyX3zMFeC2V5IJEet19L+NWa3kmckhqDihAc3YLVL82nl5YxVKhWBnzcIFEyVb5wmO0gyJKGc8gmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajdRlofMdvo42OVOqGXyRTdshC61xKgWuLqNg7HObWU=;
 b=wRr89L3TvEPxDiU/D56SefOXt89HLDUcsm6C63d41DDH5xwdwBKPmEgMx1ElKbX4A3+ygBbBBURjwMs5mlcjKALoZbWp5rzOLL6kMMgvsvznqKakYGJEjea6b4LVTNENIC5xnXwqrNcPQ4ZQwTmqsp1zXnMtyDzotGnhX4sigVitBI7OGFe9wqqnhp71rNVXfablyRdW6xbbNgmSrH1qwtyEE7Y5SyfsqnKQ1CPCfIdDe9Mw459l7+XmyuAHbaBHd9DkvmaVDTDTlQMP9KF9vCG6uHJm3mDKq4KlhusfooxPFP9uju6Th7lPqe0lbjWet1ezKan5jDoFzCliD4zkJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajdRlofMdvo42OVOqGXyRTdshC61xKgWuLqNg7HObWU=;
 b=h89el/0gv5kNU/r+JlxHLK3DIEkyaiDiFptJdFVI1U8zM9aSaMbmVI6wntZ236SM6iVt5oV0WWeuAdfyCYJha7TY83yqA+TLunJlzJ1TOWb8AfndYIyhNZJCsQVnoZPxquAJwvCyij6SFFy51TkSv5RkRUoDssiposHclWN7cYMY6WlO3thGGMdzxi8pNPgovh1wQPVUsMeQeZThaAJ0TIVDgMSvfei6mcURqqfUT7CNPHg/Z2AFay+pXiNeHqQ3qpJhgGyyWXrS+vE4bi1a2XUJhuFbV/gqLMOkDO0Mu+rBMiuV+3PDzf4jbRxWLPiSxzaGT4kaPTCXWGPhFVDb/A==
Received: from KL1PR0401CA0032.apcprd04.prod.outlook.com (2603:1096:820:e::19)
 by TYZPR04MB7154.apcprd04.prod.outlook.com (2603:1096:400:465::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 06:00:16 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::76) by KL1PR0401CA0032.outlook.office365.com
 (2603:1096:820:e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:15
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
Subject: [PATCH v10 15/27] ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4 NIC connection
Date: Fri, 19 Jul 2024 13:58:44 +0800
Message-Id: <20240719055859.4166887-16-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYZPR04MB7154:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e2c950cb-8b20-45d8-d0ba-08dca7b80fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dRscF9v3yMOatPtAlBx7nzj09KDkpXIRBk6wdt88IPHQGSFzEjFBh90N2wHm?=
 =?us-ascii?Q?BuNcSnHVYovdeJCPMexn6a2nrzgke+jQEFEKMMikwOpw6t4f/IRITmift6Ih?=
 =?us-ascii?Q?9gg8HKNrWTlLE6qLUQnww0SbqacJPjBSooNI5FALXIY0Aso563RUrIrzEZDf?=
 =?us-ascii?Q?ezpS3Ld1mUiV7k5vbFDwdcKCuwBXPiGaZ7SsIQKEfgBQZxE3/yD78ysEem48?=
 =?us-ascii?Q?ZpwkDtUcKJZJk8Q8guRWYTlu3gAwUhmb9lfGarQ789KtLQd2vfJp8f+6m76o?=
 =?us-ascii?Q?vfozW6etvq+OBa1RIfolwob0TJjy1K36ynJ3JL1+eZGSGydsuG/H4EUaGpGG?=
 =?us-ascii?Q?JePQTz5XlvZUxfcuaHqOuJRRY3bLkw7RfiPSd4aG5aOjgvjeDiAkrREULKL0?=
 =?us-ascii?Q?Kgk0Zibu5Vynn+HeOPt1eGXhub0EzYwg0/sXL/4O5eGX5foJ3D22cbspqAr6?=
 =?us-ascii?Q?xEEsHYw8qRQ66EunRxuqlC7AXgjKXwOqS8i9DO1CeOmL5cxhyXe3eb4xYtVn?=
 =?us-ascii?Q?87ZJNL2fAdcuKU0/xSpDAKDvsyCNYzfyLLEXIu0t3sOxKIVAf990hB98AuDF?=
 =?us-ascii?Q?Yf4uvhoMrPe0zKpaG0ocNgRCOmt5TVSiGT9W7ieQq30XWwQNgNd/qT2PPf7O?=
 =?us-ascii?Q?UOBBCZ8ED7kpNJPT4IMaIejgEogTXtNXODYCvjKDoPXotVs90gfLemb4f1fE?=
 =?us-ascii?Q?oAAvzJfOxfxFuh7jvPQ9zaUnsf7+yQ2FTTNpbmTQf3lOWnBdJTpqfPk9iCCa?=
 =?us-ascii?Q?pzLnhGEDTFWzUPkQtyfpSxTk8xdwcfTfrm0GwgFo4M3HdvRMCCG7E9RZo5iJ?=
 =?us-ascii?Q?WHEYLzLBwhlw20j5pRPTO98XMIeLZM2Ixm+pyKeam62dcTxHYoLELf4sCBZ+?=
 =?us-ascii?Q?j4Q4pYfqRnyA2NWq3+7erPOX9qp86QDyXU8jaaQbLTsglyNFbW4BQ1tNB+Q3?=
 =?us-ascii?Q?yDaURg/g/i53dodtYqugainr8V00+12+AMN0rfJoImPFXN3ugixW1KpHgXDJ?=
 =?us-ascii?Q?8Clo3L+eh3Z4C0OYIOMKzRQVBa6Fm4JRkhfL075eg0bjO4hPyvI8lOcKuQ0M?=
 =?us-ascii?Q?0OOmtCR+Q87724BQ4N8lpuS8cJLvhBL5EByYvQ2aT6Ybg85AdVD+GbpzC2hB?=
 =?us-ascii?Q?XvORo+wigyvaloR+xYxkRZLkbWoewsD/a1bSf3oSLQacWZ/XmuPNfXVSPSn3?=
 =?us-ascii?Q?1rRsYcn9G2Iuq41pNwt+wHAhquKGIgDuAmOkh7znc2CTQYFgqgWWDhJA5NvG?=
 =?us-ascii?Q?BC3tZr+2h9UQzOix8BRh0EvNtquWcDjx5WD3S5XPJni5xjNb3p9/x0Df5fKu?=
 =?us-ascii?Q?GFhBSOvo8PBPvKihkvld90f7HZ3H9dXAsIAg+sU24LgJV4V0yfU1HT3uCAga?=
 =?us-ascii?Q?uGzf/yfkqogTN8L18XrQG3PLbP8XZxRLVwTASBKVowXAIsB3KJxdeMIWUI14?=
 =?us-ascii?Q?RSdtEsMxd8lQ0n8HQrdc7h89Z4uu0VCt?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(34020700016)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:15.5639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c950cb-8b20-45d8-d0ba-08dca7b80fa3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7154

Remove idle state setting for yosemite4 NIC connection

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 67e3c787d675..8b23b012d6f5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1235,7 +1235,6 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		i2c-mux-idle-disconnect;
 		reg = <0x72>;
 
 		imux24: i2c@0 {
-- 
2.25.1


