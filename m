Return-Path: <linux-kernel+bounces-257000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672F29373BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA061C2328B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43688145B0B;
	Fri, 19 Jul 2024 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="hWB++8v0"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2061.outbound.protection.outlook.com [40.107.215.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345814533E;
	Fri, 19 Jul 2024 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368865; cv=fail; b=HWM7uH99df9wpP+ukfF2OVipIMxFfxAzOk7+KdH7YE7WDmeK92O32/o97FRX9/PN36MvQx1Q0yXS/GpXL59VxCL2sTbdiZe8PkPrvDNRzser2YiQzbzWby1XdpfVsI9tEN+kJvfbXIjR+DjLdMp1D8Yc72WK/iztVEKj+HBaTTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368865; c=relaxed/simple;
	bh=zOjmrymwC1otB/hHdeoT7sl0/a338HDX1WAAgh+ITkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sb5ptjxFDav8+i9/F9ZsixWUZxb2jmc8Kv3Eo+/JUhXhGqLVwZDqRo73P4s4CWdO+Ijl2WLNcUhgAFEMXjnbwNMrP+XN0RzorkueoLcCwaVcNO8ZZqYzehiK7d/B+CznH2JmbLQB3owJFVlBQDYdyWMjyG+jmz/PZNB2zCyh3+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=hWB++8v0; arc=fail smtp.client-ip=40.107.215.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYrTJ+jdXNeZLais35PF9IDDbiKIuozMZnnr1UEIrsF6I/oQyV9jW6jQVHezDwwM5HaLOUFpZFGP9Cah+RGuebxLXlXzMhm5AvpB1zpt5JQVpeXXDMN0WetHdFK4PTy181feV/XlAuKcJ88st3Exe/Nmvcoj2Q/jqdqZpuYh5+hJCEoUYRg1wB2GsrfBi7PRDdaDBnjzzWv0YXdHpRzNqjz1fgoxpYStw8R9huFyGaq6cR1kNbRdUIhrJ4tMjOJmrXF3jWPoJwCqenIFlyKMuw+wpOWx1tshCAUBtF8cNp0AzJD/7C57rQ4BcAiJ0TX5u0GPQA7+a7/5RMh8q+lYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ao7fvAjK3IQD6iJqNX5CwQBfagrwWymJ/gnXrH1K0Kw=;
 b=i7qQLkDpMOuMyIV34/g9UVJuxj36N0xMWYYEGKHylxEO6vIKWdHfHe8xldevTTTVSr/kTz6rwN4OcazUfNtX33az3KGng3BqMttiTr2fBL9pcWmmnvC2eGt0Y2DSHIhP5VikgYBg0K2QL7z9O1fEgqVsI5VG6dcad8jSyHLpTVhDsTb9AeCoBAHJhOz+tjZJMrW2e4H7EsAswtPcyiUQvnDuEvjtloYq/M2eS2bXwHTTL59qWB1c9+23R1y5iuzHJ2jXCyNf02u93/rpZJ+GB/02CJvyQsSLCFaUrPYh8/vssZN81639Pu8V3jyziNzffQhlZCWDIRqnifJhdebIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ao7fvAjK3IQD6iJqNX5CwQBfagrwWymJ/gnXrH1K0Kw=;
 b=hWB++8v0eibsmqC7ErZtklvtZ4+Fuo3KqQdSHMjBFbru2F0QpM3pbWd7v0kxX3eSWAaco3SDwZ0UqXISvgAZTbaGyHbWXRY+y3T47wtPnrIn1RY2ga6o5gC1RZTCwiJqrTV29kLW7ttlE4xaUi7DSGjVrAnlyw2D7F7UjTctyTgMJDX86RF8CAzP2jM2W0KhTOXZBfWg+/RAIlMZ22h3vP4MMm6C9GxahDutFlBU4zj1DC4pYH1+TDI+XQ5xofKGGmlCSuysbJEeyRme0MUVmXa8hYiifKFaKzG4CTAARkHKLkK7P0j9ox4NUfrCXQTTT8kIwNLfe0tNAJGwsrow3Q==
Received: from KL1PR0401CA0019.apcprd04.prod.outlook.com (2603:1096:820:e::6)
 by TY0PR04MB6292.apcprd04.prod.outlook.com (2603:1096:400:267::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 06:00:57 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::53) by KL1PR0401CA0019.outlook.office365.com
 (2603:1096:820:e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:56
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
Subject: [PATCH v10 25/27] ARM: dts: aspeed: yosemite4: add RTQ6056 support
Date: Fri, 19 Jul 2024 13:58:54 +0800
Message-Id: <20240719055859.4166887-26-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TY0PR04MB6292:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 621a1e11-25de-46ce-7097-08dca7b8280a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YMpmk+gdxGIpb6Yl39K8fWBg4EYiVvZhft0VtPDyNrxtkSe6aX+PnmrbZT77?=
 =?us-ascii?Q?CGbRRh4uapCoEKgNAeftKpBmVmPQjkVTCDV3LLnS/wzcaGPxLKFncJAUZGOX?=
 =?us-ascii?Q?owXwROApdDrCeWWP9ZMO1F01e/2kVPo12Vm505zYPqQqZlIQ1tV6l/uPtfBG?=
 =?us-ascii?Q?+NWFVRDh5G690J7vO0grt8MdHPJwSk6XJB0E7CBGmSjVr7ccCWcTZeiRFRGN?=
 =?us-ascii?Q?C+M7V1Z4FNxhe31H9eWGq83WP88EjqTCHsg4GbfQzmkl/ZUapvyKfzR2ii3k?=
 =?us-ascii?Q?DZCLL9RTLIMSK+nrqdy23lXfl/ZHebLDgYxtDHkO61b6ZQBz/BE5zSO0X6Ul?=
 =?us-ascii?Q?HDh3skXMDeI7J0ZwRKffIim6poufghicY4kTlP79NMa9pQcsiuDOZSqV776C?=
 =?us-ascii?Q?RiKOaB6XOhqqjHlihgI+bKYo5JFyep+B0sek4ynj6vrJ7WtA2OFDGduKcM7X?=
 =?us-ascii?Q?8Q9ULfpKGGdDHtLNL56wjpBO6Y2QWtWWsS0+pHzLkL8j/XVBd0Xl0z65eXt+?=
 =?us-ascii?Q?iskkW9S4ZYX+GLTLEgNY1hbzkgc2riBkXSNQd5ooLtg4azzsoRsGSu+CjAff?=
 =?us-ascii?Q?9Nz9FqhfzZPiyLgEkuNWTKMrg7/+vt+pLs7sDD3MLzeeHpyBGbee/7sb+hYv?=
 =?us-ascii?Q?wmOapzwaUmDNDYVqg1t7liAq5wlXuL2Kuy8syKIT7p4RJUMm0p7WCLUtQrva?=
 =?us-ascii?Q?+N++RfBq1p4uOYR7Yg45qMOz1EVt35bjBxfJM/wzO+SGkp4ojottdbyQcjo4?=
 =?us-ascii?Q?Sf5bfeffFY9AASiSUYzF5wCNHR+R7LImTMSWxKDyim+5SSgKDRJ4s7Se2IRB?=
 =?us-ascii?Q?sYQxut20B/ICW7I6RXYd9AdbEzUc1Tmxds7PDeUXXD6qFF+8Mi8KaAAg0V0g?=
 =?us-ascii?Q?Fw2dOTKdxlcDaQSZjrzJWkGvWvhH3qUnHCmuT7mSRWxK0Ia4WYra++p5vKIZ?=
 =?us-ascii?Q?WengYd9DRlkl/oHdlaCCexlvJsTYmewXLeA/pwCAB51TpjfYqVBOwGgcEh/5?=
 =?us-ascii?Q?RLe+KLYeP/Wzgq9eN3YZxRUTb5TAVFQivB6Ys8XxZtYRVdzAgl69bu6mD/jT?=
 =?us-ascii?Q?lP0d+j6ZZVQqIbwO9Ej2UaCpM3oPmcd+eoC+JoICK2xdC9At449pouyLEbAU?=
 =?us-ascii?Q?z8O6TUUexj3ALAIlq3HS3NpwVlzz7D4XiUoWOWf5HhedWMpceIrzSyFB2vkh?=
 =?us-ascii?Q?GMW0ahLiQec+5mGeOxsFhQqdViAR08w2BoNCaX44/ASCsGb+qUAhL5oeDhkx?=
 =?us-ascii?Q?3QvVY7Z4uya5XKxZMLZuX7p3SNo1RBhC5npYVNRY+r2dC3eMyPokSgO+z/zd?=
 =?us-ascii?Q?BJKLM+8Wt7StxZOTS8GEfvZ/If8XaKl792YLsGTlmbCqEoaBjX7ADYdWP/tN?=
 =?us-ascii?Q?OqD1F0UokRKmeNCPvTY3IUfkZMgAKW/8CQBG0Vh9gE+EUI5KmC9wb7EPrWtU?=
 =?us-ascii?Q?+JYz4hJLcpI1oMFQco93fZD5/IB5j8ev?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(34020700016)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:56.4080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 621a1e11-25de-46ce-7097-08dca7b8280a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6292

Add RTQ6056 (spider board 3rd source) support in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 05f109687ee2..b0eb38f9aa7e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1240,35 +1240,35 @@ adc@37 {
 	};
 
 	power-sensor@40 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x40>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x41>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x42>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x43>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
-		compatible = "ti,ina233";
+		compatible = "ti,ina233", "richtek,rtq6056";
 		reg = <0x44>;
 		resistor-calibration = /bits/ 16 <0x0a00>;
 		current-lsb= /bits/ 16 <0x0001>;
-- 
2.25.1


