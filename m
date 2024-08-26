Return-Path: <linux-kernel+bounces-300811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF795E8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CDB281786
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FEF83CD6;
	Mon, 26 Aug 2024 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="3y3BdL+c"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2052.outbound.protection.outlook.com [40.107.117.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD8823DE;
	Mon, 26 Aug 2024 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653574; cv=fail; b=PJXJsuB7oNg9rLFtk84PcWddxL/T3Yf8vOkF3tPCfdUeuFNdUmKT2d6tWR45rFFbYDB+rKyXAMLuiPuOzik4XOVEAb5rE0bHUmElZW2Mt+1tWENrOt0XnkIljvpC6Lwo4OjoGgLTWQi1eRdSTpg2S6P9Zio8KrdCOkONnhHBpJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653574; c=relaxed/simple;
	bh=Gb1cMubfab+esZE2lUZ8pmnTHC5wWT80/mJF+02OPjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stfEzt2QfjTlbqmFFFG4piufWeA20u8KxgSJ6PzPSqhsu+/84wezGJd9z3mw5Bbz1th3ZLfAWB/wdMNZVtV0HX4XLFEynXbV1IQbijlWqEwBVwNaRdIHeBzkqh7RHqtFhjxpAH5G0ytpdNRNqwp1qk92oI2xluivcR27joT+Ozc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=3y3BdL+c; arc=fail smtp.client-ip=40.107.117.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8LbeHyhgeFbXaGlHTWsGYGHm0PqcwCQusqidssOKVs86gsNpbe8xmdyi1gPgq1/HYYQwFrjF/cetjcOV2yBkMdh2H4i8tf+2ogH5vl7crqwPbZI7DhYOgSGTKgY0fKD3yetuf6U4f98BOHH6ylmGi1MJB7b4WsLpk+MIFtDUbyswKXwM0Q+ekumv7BjL2fA2rXK9IDjpCLzKP17GsD8uy/j48db1vFXeMX1DCcQPQ3jSGOvch7TT6Hz+vlqZWrQqtlW6i7AUQ/kEh9g9VbQGh9/FNwlS4E62Foc6zDwhe2QzRG+wGDhGC99fJQWMhfS+10kvckR0r7uZU9wNGROmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKDiGhY0qi6Zhw5yz3X3KRvVupBpI62BiZwruuZTFwI=;
 b=qDWain/U4MOt5oBFYTOajMyEzp5GdusGta85RWNrwfpgRGZReBJKqVNCi/EZ8OinP2cnAyhDpxPvfl7yYBC4aGwc3iffq1Dz5rUtylnZ9MvKwagRDQGZ3kVElGV8V1cYEQ5Q9uMbMNBUBtAujS7TtNSTWjX50xfyhV5nAjYZS4UJdiiHFudg8GMNodxuXAA2vyc9gnKT9S22Vzbou3y6L+DIfzLJjfgcBFA+Hs99DMFW7O7rJe5Sm34/L/1cWVG/hyG25UMga2VrJAs5lwqwNYz3MEetBr+qqm9cAevwPE4jp09jpevftaAPpOr+yH9L5rpPigGw3CHmlpH/g6MT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKDiGhY0qi6Zhw5yz3X3KRvVupBpI62BiZwruuZTFwI=;
 b=3y3BdL+cl+hj+glrQhW4xJq0++U2Bve5/u/Mw7FM0NOIj4s10XqoQZpvOR3jGny6vFlCpQAt3BWnmJQzlgUQEtzWsDRsqjVF2JgzC36j1VDfnelvf1NbGlm68bi7iW5RgB+riSCFZuxsqfX+2IxwAxZFcytFmw+oIVlmHxNhIAFuQGWuP+HmqXtF5Ru+mxHT+mmLhS/tIJcNnysHaGsgQmyf8tIzQq/jEFswexNx/wOJpBu/4Wx41ZB5+vLR/ALkDl6LYEW8PsUSxxQI7HraW06o8zGBvXdZ2eVTX1ikGyQFiISJeeuZMEFp5KROBHGClFO14kF2UHh/9qyCqis+cQ==
Received: from PS1PR03CA0014.apcprd03.prod.outlook.com (2603:1096:803:3d::26)
 by OSQPR04MB7989.apcprd04.prod.outlook.com (2603:1096:604:29c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:26:06 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::d4) by PS1PR03CA0014.outlook.office365.com
 (2603:1096:803:3d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:26:05
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
Subject: [PATCH v14 20/31] ARM: dts: aspeed: yosemite4: support medusa board adc sensors
Date: Mon, 26 Aug 2024 14:23:54 +0800
Message-Id: <20240826062408.2885174-21-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|OSQPR04MB7989:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 64a62c9c-3556-4dee-c4df-08dcc597f729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UUihK21i9+EEgVctpecCoqLtHjtzaW1sTaGNx4kcCbxoz6lvO9/3Uy8cztJG?=
 =?us-ascii?Q?6Y9V99oE9XeacKKdIADDVHBUiiDgMK2U5UojoHnkBuZyeDie+eE7h98Ezwxn?=
 =?us-ascii?Q?g5lJ5kuO5KH6Q+dQZJre0G/i6u2grjRZmSzOjsseZj5cWOLnEGJm2ddA8rPp?=
 =?us-ascii?Q?SU5vfUB5l6Xe9noW1QO3roMoI8rQw9ghC2dcXFOyarBAGGk0eapHD9H35OaN?=
 =?us-ascii?Q?w5vVj+ojYV05Uit+fKh6BBC8XUKF6HX0zoh9TE4ZiAaaIB3nBZiC9a8VM+Zq?=
 =?us-ascii?Q?j4I6KpR3gFb/3tn7oMsgjh40/sk147Zmf+Q9rj5pqA6mivUZ2xYiR0uc/uXm?=
 =?us-ascii?Q?CfjYMmGtzx/8+k7BPpe3KdFH9OBfApNPWZCyGugHT5cW6R6UXzi+KPtvbIyQ?=
 =?us-ascii?Q?QSTaPPoYxqvB8jSPlcI94vUP4obYvE+Fv6QH38UZD3m5pPkSgw1AOtJ/Q0hW?=
 =?us-ascii?Q?WKGo2BSw92zXlC51IbcPranC+aYz049QPpFWJBx5f0mIj5c4CFqPZzAv389U?=
 =?us-ascii?Q?wMBck8wLIKz0yQLg8SkEN8He8iAFA3k65F54dd8d9BNmOEBqgdYcaf3WQRtq?=
 =?us-ascii?Q?BfXOaPVyJ1gUY+EeTfbo3o+YWppicoW2O6gTknFbI/uVDEBqqp09QovOZ6wu?=
 =?us-ascii?Q?iRuswAKLOL0jDwNKa3vSK0LlviVlKJ5AdEway61moGfr2fNrlx6sLXxaKGVY?=
 =?us-ascii?Q?vJufUS2LlXQhHb5x6su7sGWsJ5AV4NpgfdVBf/5iMRYv3EpyX92uqB8RwQKZ?=
 =?us-ascii?Q?nbCEqu7TVMxYjnt47p9SUXvmoHQpY+99h2naenVt93XaTsFMZhYBHBVwaVCO?=
 =?us-ascii?Q?FUzi7CjUB2yEN4kna6ZJmuxhoe8+4I/JibCpgVb9CpYt0jMlvpP3rY0wMPie?=
 =?us-ascii?Q?sit9fQzLmnjYL5DyNSw6MZd1CcAwp3Z9wEcY4xlsdNZlJJSMmE6XsdUskB2s?=
 =?us-ascii?Q?n8j3Fis7Uw/AyYOxJwRdVBmV1cAKlDCiX0ZS0t6yDvdmueqJ1H3R4CKsu7hA?=
 =?us-ascii?Q?yJYH6+eoHxfI/JnVbwiRn21/tzWMBwp8Gaaqg347pe1kAjzfeDapRg+hkL2k?=
 =?us-ascii?Q?iLl86WOrY4kRdFq03Xcw5xaivJlbYsRwh7F/kdk6N6aCRPkhUWEbbm+sebru?=
 =?us-ascii?Q?zM3GNS6QyTTiOmiSHDUXqd0J3JZsYCidw/2nmfqSz9f0LNzcUyTywX8dgT7u?=
 =?us-ascii?Q?4SEfXjd9oWWIqZ0YbHZ8oJ7Mso/MKYQZFkiZubUS9J4LGubh48RMlagPUt6I?=
 =?us-ascii?Q?3czZ7uAWa2v3srEuiaXHB/gufCfkcPHI1QNPCWG4mOaJgY4mZVUJikZy1mtr?=
 =?us-ascii?Q?zMNlCrsKSgqJe6SylmQUDoHPVKNvx1jzqBkUNZQv9ISK+Q61X3wYLrbHfhSh?=
 =?us-ascii?Q?HvRDPiZiSjBFLVEXPDTkKlkmzfuAVGWvaPDIBJR/840RAPKxZmWKfEsN4fnt?=
 =?us-ascii?Q?aid5kkUk5JJLuLkUNfm91XrMVbBMj14c?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:26:05.4867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a62c9c-3556-4dee-c4df-08dcc597f729
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7989

Add ina233/ina28 support for medusa board adc sensors

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98eeee49b082..49500db53a13 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -915,6 +915,19 @@ power-sensor@40 {
 		reg = <0x40>;
 	};
 
+	power-sensor@41 {
+			compatible = "ti,ina233";
+			resistor-calibration = /bits/ 16 <0x0a00>;
+			current-lsb= /bits/ 16 <0x0001>;
+			reg = <0x41>;
+	};
+
+	power-sensor@44 {
+			compatible = "ti,ina238";
+			shunt-resistor = <1000>;
+			reg = <0x44>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
-- 
2.25.1


