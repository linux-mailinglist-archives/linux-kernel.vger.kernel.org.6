Return-Path: <linux-kernel+bounces-289388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAB29545BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1F328281F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BE015B143;
	Fri, 16 Aug 2024 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="nxitIW53"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2069.outbound.protection.outlook.com [40.107.255.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95D1448E7;
	Fri, 16 Aug 2024 09:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800374; cv=fail; b=JZ2x53ZIGAiNhYESTU2zzWl104fN5Bqm9Mcnue3IaXP0UokLdPXp87jRJ79Qu8g7Vu3ZkA9X8fA474cnAb4ZbQmR0a9ES2Ja3UYGmUbTgtLDHck4EMdsAACMoBFKyMQDxNrCjeTbLsH21hyknXPIho0lJ9kHiQIOi3jigouJRGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800374; c=relaxed/simple;
	bh=bJyTPwQ6HLIm9WpJFkRqKJv3EdjekWxcOSacyOXtKik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5ZPVPXclPibSXHJMQARIPykPziiYujn/y8ztfKI9R56hTNobBzBu7/Jr/J8Zl8H14p7OSp7/bu0tucDd0vP0eivbH1abFliZRVgJyGWL9dOI1aI0plDDafjRlaCu+ccYPHnamco8IKEeVJF/wVZemit0rnDstqOWqVp86cZwQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=nxitIW53; arc=fail smtp.client-ip=40.107.255.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLBT4RM5j1y0f7Ig54sGF2GLbQmL9X0tOq7ssBORr/3kj01SHs2hhtRmiQAPWNMtWomm1ckdxU6vJSiOOldlifUmEpE/G1IB7R8xO/gx8y3sdROUBl+e9RKqLVUXlo3cgvPmuRyis92a1e5+QXrj7TCDDH2IA6BCMsPs4zE50ANO96db69oVzyAnMVeaCCxMxzX+BXrz3e7HEeeuBgCKUxA24859RZ5bhX8RX2tLOrNmJld6bdi1fQElKHJzVZ+D+WKsxoSjcdKOiGkHgAzFzA6rx+p/C+47bQcmbhybSXASn6dh9OJnu94HpEkPWzfJfWPMcHP1iwwcu1RhEQighw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQFQ2bKjxnUV6R0l0iLzwvLwa8mKW3x6TIVY3QTprt8=;
 b=zQ78KNeCxzQDJyD1ogF5fP7GwaNU0BL9Ww7tu0mb1TZl8ojunsQjx3ILrTlDKSTPd7O5gFIjeCuOY/C/BMNL0EBkQeMu1mup1Cfnu6NK9bmASDIi0vnYPAxFbiTc4ztXykkWFOIg1//SIq9zFQg450/Qc1dii57DykYK+FwSECFX5eolbmNVAvBKgFeKj5hEzGwMTj2K0ZZ9XkLYnf7xVLn1xffMzTjTX2naAhS6hadMzpkXzhbxUJIXkuruE6DVd6g9Kd8tVf/V4GFb3EjMeFleJ5Fe2zADC/4llFSnD8J1oq28+O1DobOyjFTjY/XnioFPjLSlXvmtnoUL1ek+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQFQ2bKjxnUV6R0l0iLzwvLwa8mKW3x6TIVY3QTprt8=;
 b=nxitIW53gEDSuT4ZmPq61OO8zxgNhj9FzRru+x0XUbkYg2pe/mpw7onoZ9iPtDA3aUSnmPTKYyFPza/QPpCV+vla6+ibACVJncr0iMuz0+TqGGFYx0JBy+xVR4V+wELyr/9MJCAvRTmjolsrBOlV9gUFuVkObhW76weNztcKOojQAYSoBPT+Dp2TcUXtXV6flIkJfbyuFM7Ennt5elrcS8+XjQWH4BK18w6k+nYNYldYr0+w4Y5jTUuNIvgF5EQ7v/e+NFd8WxhO5ezP5eMGExA/jGSFjIMfxOdNZ1+GJtec2wGfi/JNusa82UIyH95gL2qAdF1px2uqoNimzb9AOw==
Received: from SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) by PUZPR04MB6351.apcprd04.prod.outlook.com
 (2603:1096:301:eb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:26:06 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::bc) by SI2PR01CA0054.outlook.office365.com
 (2603:1096:4:193::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:26:05
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
Subject: [PATCH v12 22/28] ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
Date: Fri, 16 Aug 2024 17:24:09 +0800
Message-Id: <20240816092417.3651434-23-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|PUZPR04MB6351:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1aa63a05-6a1a-4425-da7b-08dcbdd57499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VXwRpea+kfHf4aaQ7wGFrEbHw7CUAtEX5BAS7JTXcYuhiqCcIfX2LSE/8dl6?=
 =?us-ascii?Q?+JxzbAxAtApZLLph9tWl5+v0GWufuqJwWlz+lzzaVVDciXdWB4oBxMj1Znr3?=
 =?us-ascii?Q?vdQVgC9K/KKfVXWpRAitwpJk7gtzhLfQ1Fvu3aquDakICOqKDPs7HYwpqT8z?=
 =?us-ascii?Q?FX95OAqVKy8o9+D4BJXc9wEB46637AOL6wR+9WdkxjkcfwG/pebTfoiUNNO4?=
 =?us-ascii?Q?SEa0TdoE7cbI6WLAppCB9cmr+ZLBBLbgf1vTuQImKSmsFSboX46RpYqTlzuL?=
 =?us-ascii?Q?M2bxzOWzlvSW/gZZxhcuxZdQgmr/WgT8Gfn+eN9nkAVGAuT+gCjnTSz5TyHE?=
 =?us-ascii?Q?2pSdGwFB753+Fo/Osp79VnxFLPgNMvL+2hG1pPUW6qb3mvJWOUgXhb4ednuJ?=
 =?us-ascii?Q?I6080opsC5zRvPfJQmWwH45iWRjJlahVMA1CTIiMuBiDtg22m9rAdaN0K3GF?=
 =?us-ascii?Q?phLtQl6mnFxNuoqqO6kTn4KDH8f+YRcGK0JxI2rlBet/WB/vTvG5G/fjukuw?=
 =?us-ascii?Q?WpiA3TIQ2sVC2dPutkb4lZlOV/GZzEkRWwQyiBol1fiqtUXtXVLAkV3nxyYj?=
 =?us-ascii?Q?jOY7W5jdLKOVC4faSWlt7l4jiI73DZGTD4ok2UJgKAWIBG+j94R2qitPfToh?=
 =?us-ascii?Q?3Z4RlJurAANRKdH5QhCZZlJnhdhJmv29cjGU7rWq6w7RLEU6VeDdvaPX1JYd?=
 =?us-ascii?Q?r4dPCAxj+ZQ8QjuwnxuGt0NNJU+xqkz2yaSmXg7cCml9/hlA6Y7V4PHa56gu?=
 =?us-ascii?Q?l246sVq10zY5/KDPDFPn83HZMq1X4GwrAEo07PTNTscy6CcEeXxiPqVUsKIi?=
 =?us-ascii?Q?0CBLcmCZ9wQ16GLux9hr8d+wOkIoj+IDadX3Ao6bUTEc45OAKiGacbsfrmJ3?=
 =?us-ascii?Q?5HOs1vmzONdikOylRdvTZDJeHMGUL7cUJTsQj/8xJ2ynudh3KCSN+q+/Xwh7?=
 =?us-ascii?Q?kCdjhzZVyodCU9Hpy5bw4rPr3jlH2+A/pRIC0ezkVxlC4v8Y7mIF4yIrVHyq?=
 =?us-ascii?Q?8D2uMBqugdrjWZWkzJOr50DnMWb4w5j1Cx6PeV5Hm2PWRhXox12tbUjcC38/?=
 =?us-ascii?Q?pC+uAyOneyDX6Z3FfrlxjkqKlNpmviEi/XUY65cz3nzIq1lmk+BBm7vSRx5i?=
 =?us-ascii?Q?lrisF7VNAgacv+L1/YOHrILcGBGHa1uldUfSWjw8LWvyJIlnnfcQ0sKy0/ro?=
 =?us-ascii?Q?bFyEZOu3EL8SOIIpzJ/wrqVVbiorpYoaeIGkGZ7cQwzP36iODfpqR1DTMtV0?=
 =?us-ascii?Q?8r1ap903TN/unBQt1raUg1Zr/IMyJgBil+I/P4GX235FqRY1aTsrGfXE3mVw?=
 =?us-ascii?Q?l1QtyRhP16CK4/6HZv01qBjUnWxmEHqa5l+VI4575UvOLTRxan0cgLWlHLSE?=
 =?us-ascii?Q?iNunhHp2QERHM9zalX339fSo/w71/duAZCKi5DHItXrfewZTGTk7ft8W4CpQ?=
 =?us-ascii?Q?w8RV5Rdxnu8YSvpKXItC/awpWATEC6Mh?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:26:05.9191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa63a05-6a1a-4425-da7b-08dcbdd57499
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6351

Revise duty cycle SMB11 and SMB16 to high: 40%, low: 60%,
to meet 400kHz-i2c clock low time spec (> 1.3 us) from EE request

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index c2994651e747..c940d23c8a4b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -761,6 +761,7 @@ eeprom@54 {
 &i2c10 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux@74 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -1314,6 +1315,7 @@ &i2c15 {
 	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 
 	mctp@10 {
 		compatible = "mctp-i2c-controller";
-- 
2.25.1


