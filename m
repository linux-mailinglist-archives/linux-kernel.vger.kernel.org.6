Return-Path: <linux-kernel+bounces-339848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD503986B57
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B771F214D0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A777188928;
	Thu, 26 Sep 2024 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="MaJF/3sl"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932B187554;
	Thu, 26 Sep 2024 03:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321319; cv=fail; b=NJ9HHojn8xqkKJM4CKj8fYaV6ph53f9/CFh9JBtUBiAQHlQCbIpS8r5G5+PBY1R5q5xvLHohWkfvPKWJ8sjqZFzqDE69aiVQgNZT6IM+zpwuVT+FBVBo2+xec/yEvubApWaSay70LMkQT2eYsMh5JHRJXInz/4+yDGeRfDL1uvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321319; c=relaxed/simple;
	bh=fRPG8QL54ZG9rgdkPfEuvSzWlT3S9+n75YtueCzBS0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnbpBRKqzJxFM6IHO8kn8hiudfB+Hble4Uf+yXy+W5+Ei+gLQrEXK1Cl4YgIif+Et/t3264xH5an3oc8WnpCEfPDjNbu7GPGIASPmY7DAy3WS+LpxBBf6XrPPI78qb1vuD5rGZN/zYzTTa9BqfvPIu9Tm1UBpf98+7DxrVFZF9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=MaJF/3sl; arc=fail smtp.client-ip=40.107.117.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyC3phm2nVNszGBp1n8O+YneQ9TgNzOKqQ5SHJEghcvowI/6b4GUSZWTKVpzMhRcT0rrPv9PuWAL5yQP4iDwcZPs4ho+SyDPjbjUYhAKtWGKc/BwBDDw2lGHrZLmyTnn6XjMjnVh7LXmKqcR3IRS8QtRLV1SngoHIb6nv7uXIFTmDhU0fSQ0xxkl8l7EwNZ1z+IO1S4KaKAPtCGAEK9c93uw0YE8/Y6tagP5C/+3GAfe3UUz7r87zm7yTAMjzxoSE9yMBpUFFo7JlXFn4v30b13Ilogwtm0hscotSHF3flo4V/mTjJY6vFghlT0HLUH7iK1fiU4XK/YDX5OUyBRWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrN/JdHLlngRG9xB3OEJXaUo89xm58BMqSeJwEGwl9k=;
 b=SPzJgjEpiYJLNtKrnruZLzzLDAMaOWjahXz+RDrxRW0KhqZ+DZkDn3E5VR/ELGyK1N1Pm0SnHML24cbOXyPL1alUbkjEQhzUOENL1+3KVQLrmsPJXJQgceK/CUApQyDgbbpIpwjsVaakmIEg80D3qKPXKtKB8+G13UGw2EiOK416xuvm/l1SL91OelokZCRmxyZucVJ406jiGjshsZXmuc4+qjNis0IKxRdoYG7WDB5W8bMdCa0uqzIFAWoj8f1JUYx6ajP6PdD3B2hz68kE7lV8ofGyNZkxh+uHpOAZ+UM4cmEAAz6FuIW78LiArztBKzc4x6ET9bQEC2mhyf8j8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrN/JdHLlngRG9xB3OEJXaUo89xm58BMqSeJwEGwl9k=;
 b=MaJF/3slhLzmZkoCdIdfVTNTlTAo9KdV+d4xwHtjuFTJlFz09k3TIpX6At1DCXRhikFqPFaqPkKEmb2qqZthucrq1849ZG/RBwLueEPg76Mj3IzbKIlnIFrzmxUyPzru/bekN4NYP5kRCei2axG0ZPe34RPbc76EfOylYpPftfzIUUgFvrhqCY5090yFe1O9594nVIbj4jaekQq/Pprt1e87yyYK+mgq6AnX+mhGAle4xfZik0lAGb9Bs+bmm3l84viM3WuO26h49MMXTHXo+zGH/HV3JUGewAcgRym03ZEX0ONPPU6q2167Eq2u6q+u0PZpNeRenJgD11K7KJbirQ==
Received: from SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) by
 SEZPR04MB7929.apcprd04.prod.outlook.com (2603:1096:101:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 03:28:31 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096::cafe:0:0:1b) by SG2P153CA0012.outlook.office365.com
 (2603:1096::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.5 via Frontend
 Transport; Thu, 26 Sep 2024 03:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server id 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024
 03:28:30 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] ARM: dts: aspeed: yosemite4: Change the address of Fan IC on fan boards
Date: Thu, 26 Sep 2024 11:28:19 +0800
Message-Id: <20240926032821.4171466-4-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|SEZPR04MB7929:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 38bbbe6b-5c69-40ee-6431-08dcdddb4b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?auUgmYGPIaZlLRlzcFpD1azlG+rzsjbEOwIW3FJP6UT034JfiUTPHtLN3KF8?=
 =?us-ascii?Q?dCHSYa1Pwb7ds7wj5BbwNKIAxeOH9KJK7iisiTcj2z4euHmG3we6bV4UlTfH?=
 =?us-ascii?Q?aeSCPO7kazZv/jAb0PXER02MDWSycSIZqjEkcEb/UrZe8oKTnTN+91LIuobD?=
 =?us-ascii?Q?cjHRP5T+gHYjhDo0oLkGu9GiX5msstYu6scaVZwTeU7L7KXY68fir0DMYuMn?=
 =?us-ascii?Q?la/GAde6Nqa2qBG3jbM3m+dT17BnHAj4L1a20T8jHiy9hYBH8Mrm+0SplNq8?=
 =?us-ascii?Q?zol9dn0KtnR7C6ikRNgwbO1br9IqSIvKQ1lgTlXT6BkjNxbbiSz9/ev5HOSj?=
 =?us-ascii?Q?IWuweeoQNetpAhr8Ns/HLilN0VeRULQTU+iHOZjbIfVABzEyqFB+pikAV47Q?=
 =?us-ascii?Q?owgU5XTK0W5Iy8EwkpgIYzwZBStLguumMZKdLLPc2yRdArS6cx17vZ0TUhzP?=
 =?us-ascii?Q?uwRGzLR4RPzEBHVKTrgSZlrwxAXr9TEvUZfRbZZ+GND0M+g+uKxhVsrH3LH3?=
 =?us-ascii?Q?1+QNzdZiiygLUdsWGXv7m6OLn7JJi2+ZS40YZsp/RO7QQD3jl7SwsTsfX8xq?=
 =?us-ascii?Q?JWyNLrXiBNvJWU2w4rgoKXiU4RqlJr8FhVObVeneVbUZhdJfon1efEID85L0?=
 =?us-ascii?Q?ZdIKSE42JWufaejwvsgBAcD4GzUHOnZ0UBQesEm4HaOe0l1Iwy3nIdOCY2De?=
 =?us-ascii?Q?kCnHyWNZ0WG8r7Oalj8DHUT4wp8ZWTUySVlMAKWB4/apUQCApuW1CWbQoXeH?=
 =?us-ascii?Q?3xbclK1Mmbe1wvv4d9jJond7hJw3dVyArA+nvjzTw0PWngMjcPFgSoOxW6EC?=
 =?us-ascii?Q?V27JjwcGzHQk0F4K3BvZJw7yoXfMM7XxEk9+akJJLsT03vV0cfpgpOJ45don?=
 =?us-ascii?Q?N9fJeBJZuNRqov/hf7Sjqj1tNpI5193i73QHD1Wqrp9UaFGlKifSQb8O2oh8?=
 =?us-ascii?Q?G+qKviWmZalk3ilZr/dZIbBYQsmpS8yM7PSGql9ymdakkImDKZjMezbzxu4K?=
 =?us-ascii?Q?VXFiwknm1RlTBXSJ004C4GpZtuZSYTfH85mmAFfFjoLz6wHJY5C3/koykS6K?=
 =?us-ascii?Q?exMUKEiIFq3fimp/5Uj8XiBn8GfUfWLTVZJG7KGvNSXR05ookdgsRtURL8+7?=
 =?us-ascii?Q?5ogoiJk0aFjpiVnGf50abcCagl5/NRMMQ330GvY6M16d6ef3Z5/FZTxJKLBY?=
 =?us-ascii?Q?lTgI3VEogqagdjVgIdVcXIovLd9gBXAs6COFlFHHKpi0o+rzSpBj7q8aH6vX?=
 =?us-ascii?Q?F1xrXhpO6nAZ4fubHg+9hSDC7hPntjeUih5Kyn9cZe9xETwbkJ/vesmIZqo+?=
 =?us-ascii?Q?wW9xdq+Xup0p2pXMmmhCapxzC2og3jq3pw87STVVjeoeXdq4tydX+k7sMD52?=
 =?us-ascii?Q?j2oVtIHxyWKgXp8dyw8RjCyDTEVC?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 03:28:30.2955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bbbe6b-5c69-40ee-6431-08dcdddb4b42
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7929

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Change the address of Fan IC: Max31790 on fan boards according to
schematic.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 430c28bdd314..a7e51725c595 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -496,10 +496,8 @@ adc@1f {
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
@@ -509,11 +507,9 @@ gpio@22{
 				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			pwm@2f{
+				compatible = "maxim,max31790";
+				reg = <0x2f>;
 			};
 
 			adc@33 {
@@ -539,10 +535,8 @@ adc@1f {
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
@@ -552,11 +546,9 @@ gpio@22{
 				#gpio-cells = <2>;
 			};
 
-			pwm@23{
-				compatible = "max31790";
-				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
+			pwm@2f{
+				compatible = "maxim,max31790";
+				reg = <0x2f>;
 			};
 
 			adc@33 {
-- 
2.25.1


