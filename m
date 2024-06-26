Return-Path: <linux-kernel+bounces-230375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D85C917BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70D12864F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92717F399;
	Wed, 26 Jun 2024 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="QvK/4Bpi"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A937A16DC00;
	Wed, 26 Jun 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392933; cv=fail; b=eS1gFSFfCvcvgevX6s4Pi8nuLd8AJenPpxHnKT6UtkxDNQ0mz6mOIymsGyaNQafq4QQg7zf3vvW7orjSZdCfBNKtlWASkFU1we4KekX9kejO/5a+C1FoQrNRQNsT0oKoQLNf/bmrmI2v9CwE9fIbbdv7nTyMl7YKvBiIBi9oSOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392933; c=relaxed/simple;
	bh=FReh6MBF7e+wsHlImkrS7+qksdnnHJVP3YlsJeVxPf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y70xuC2tbMd7m4QyyggxiYxuCR0gG+QjI/ibCSP/yIutDo6K9BXruvJ7DsoU51VcxuqT1iLwjK6zyAxn4qlbbqnudczsrUTTHekbKxwvaG/VoayR+Ukuz0+yNJju9sPgcBsUXEh718l7x7fPjihT2pxrgvRq9yt9PxUPccNgHy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=QvK/4Bpi; arc=fail smtp.client-ip=40.107.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuqQMZu0ycQd2quBakRBGsNbSBAZP+YiVhXMWAaBIwhRw+PA3f+wFbuqILCWhMfM4Yqd5LtSVakXy7wnopcxCp7mnF2cJYZCz6hNDEuW4za4fV/s+8ZNlNVJEC76R2P/eKCbDPAuhUrZ2dBDI6CtVK2Tr9uvJ5GEcxnRXSLfxow6MZ7a0hYisUM82P4Ksf5lHy0DQB8oSIcpZmArOjI74t+DqSdwgsN7fDaW/VHdxwJYzi9qbZpO6G8qqklTOeUE0i3D0X25L7aw7wQPTCx2V6wGKPfbCSMDLT+vlwwL0LIkTc4uRXeZcF/8F7MKbEszV1e5juqRKcgwWxpdvCIn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrss1LFTszE1pis/nUOnfDY03qkapLfO8Yjsln0bIZ0=;
 b=NVIMC2eqij6Thie7+xanxJo0gEPZoQgOxgeoId9nMoP9Lm7Gm7sFZV6QPoh0geDQMULEazRHAgXb7fFelJ8nJXbLc/mJ+tokENiTg5j761OEKeEoceW835L+jxqu92E5QLcAphnjOv3hP+r+TMSY1DV/om5ASsKXpDUcpx8wVW1Ps/ToPDtyNjbQLX5HcvKUjivP9wJ4dqOc+2nVXzAKz0oPzfOoRJq9M5qYcIj9HBBt0MiD5ztuzZLgGfyDhEL8mHZ2OQ0/GdIXIkvlr+xSap92/eb3FGbOxev+T1aBhkVm3LoeQ4x+Y21Pj29ZmU9QOs03wx3Lm+OIasxVH16bXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrss1LFTszE1pis/nUOnfDY03qkapLfO8Yjsln0bIZ0=;
 b=QvK/4BpicelI5Kj3+NaroYMJdZnzjfysk/CBcW+2JX1O+ZhR9HCnursh5wFEtR7C7iHQ4vYzBLPwA45wNtzzX3gia4Gac1NeWq8qcMfJJApbMnW+5JBq+q9EtaqH4GwWs925r9V34fM/S9UWdPiNmk3TnbjPikM7zKyu7c57xXszKG8CseQ8i+qJ2IxxdSlInroiQIT9kgw6Olge8uc6c1qOPaNT4ypNUn3mlbuiJdDgfUbGHBguyjMg0DwKpxhuoX7zmD0C9jHsra7NHtYm5owwwe3b1AgxMbBbuQGoDnSegbRFPg7WR5LPutAleE8brYKuyfCeo3CMcMlBWIKhDA==
Received: from KL1PR02CA0009.apcprd02.prod.outlook.com (2603:1096:820:c::14)
 by KL1PR04MB7255.apcprd04.prod.outlook.com (2603:1096:820:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.27; Wed, 26 Jun
 2024 09:08:48 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:820:c:cafe::5e) by KL1PR02CA0009.outlook.office365.com
 (2603:1096:820:c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 09:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:08:47
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
Subject: [PATCH v9 14/26] ARM: dts: aspeed: yosemite4: Revise ina233 config for yosemite4 schematic change
Date: Wed, 26 Jun 2024 17:07:30 +0800
Message-Id: <20240626090744.174351-15-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|KL1PR04MB7255:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 45b41115-da75-4682-189a-08dc95bf96c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|82310400024|1800799022|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/EFrGpO7RB9EkQ8O9BZDxA2oCFOrFQ5vFezXclQbgyERpjPjdQXJP9SXHGfE?=
 =?us-ascii?Q?JdYqkx7RSJ8pPFFNV9NzvDUyO86+ekA+nTg2CsX3RuOwsz0N+dw499UT+cA3?=
 =?us-ascii?Q?q/uPcuUjJ7dIbja/zsLoH05ByFv1pXuAv4MxgwGrmRQsS0lysq0BrK/4Ujch?=
 =?us-ascii?Q?7+qMndaNfL7SNweveHjOI0jnST6PL5s/5gBRkurObQ6XxVs798uhdZEDpTfL?=
 =?us-ascii?Q?94elyi/YRBxegh74ozxxqIXecGjADIfHn6nwueE7+VhiGRnmRHS68GyFO/3L?=
 =?us-ascii?Q?jz4jpRQqVwILM89/xLKqSBz5IaYy4xl1coSTqdyHpK5okwUVx4vkePwBg/hZ?=
 =?us-ascii?Q?zN+4UBu8Qxq/bTMJrEGMdIuGzSFlv0+MiglGbm1w1jwZUGSKxI1ut0sp+oRC?=
 =?us-ascii?Q?Gezb1CisHc53roNBmcbJKO7p6UIRpgnphcy3oMe2EOBi6erHZn2gSUB/anUD?=
 =?us-ascii?Q?76cSW9b80EdcrFFR+/xDza1L5aZOia1DaEWwGMNRZF2LbBNHWMjKj/wnO9Os?=
 =?us-ascii?Q?PIA9QH21OjRaHpAExjNyAUvQhSu6RK+SoiPfW0LFl1T4Bn6r3ObMWDFr2ZHj?=
 =?us-ascii?Q?H5oPLYC8x8cAre9uUZUHvJVmElXYfTKE4ZTcpTSnQohA52alZVz2QrQvP8eW?=
 =?us-ascii?Q?TsRZRkVaSQAhxQpfdtU88WayW68CIhePSGKl6I7TZ81vS67TZBlCYlG/4egS?=
 =?us-ascii?Q?OBtAI5ixcHmo3E2pO1iX6Da5MKBFV52SuD9tgAhggEloV1KnGN11MDxqGL/3?=
 =?us-ascii?Q?wt4PZz62bxABjz7e1tTcEHxxaa+pLcF+k+qRyxJCFqVwMZTECxtKzH6uiHAF?=
 =?us-ascii?Q?oeYAEe0VlJUL51HMt2/5ZCPVjDwxp6+5puw/wwoLCKP0MVy0cgzWJfwgBtZK?=
 =?us-ascii?Q?4aIPsCDb7ypmgiN2ZvVPMNt44iy5RB6r84wLwhPjJkGGQfxpCk6axsI2U7ce?=
 =?us-ascii?Q?1h1IQBpHv2ArbES0qEgTKcNXUAiIP+vCAhgR5JZnO9NfMfH/b2UlFGER1aCb?=
 =?us-ascii?Q?gzZLyy4bmdVXUF8odmew0Z+wStFsUQ2wAo0EGrl1A2gQwJBF9kq/Zushh1M1?=
 =?us-ascii?Q?06o/15CqzozqBjAQMQludTFnKx9U36by8Aq/vySjWUsOtE0dLxlDCtjUd8Yp?=
 =?us-ascii?Q?5/erhqhcOriLNeImXwf2rZ/4FCMLiqHwHqpa1p+Hk5O3R6xjZ2hTVUTLBJbP?=
 =?us-ascii?Q?TipcAQ5cD0Ee1Xs8pIw0uxv4s+whxlLchmC0kg/IzIUVDLpPYzQ1n1itRxYd?=
 =?us-ascii?Q?aoPwED0r7ZVa671Oh2zNgqUFdvEuICOuzGjmjLyuopxNboNTzSsZE6fxI/II?=
 =?us-ascii?Q?cBmu82ZZdpHRvkzPnKhDfFTGqhHsSSmYsO8uIwxm9fwse7QcUTcriFndwTl4?=
 =?us-ascii?Q?JDwz2CK/M7ezHpfbb/eWGpUfhxqGGQcyP6GDNHqhGFdicRXyQAq9iCo67vPZ?=
 =?us-ascii?Q?ZNZfDH1pf8KD8KX7HUv2JEOt/rC9LMI7?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(36860700011)(82310400024)(1800799022)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:08:47.8175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b41115-da75-4682-189a-08dc95bf96c2
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7255

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


