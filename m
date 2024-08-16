Return-Path: <linux-kernel+bounces-289372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A5995459A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CC228363E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB4814535E;
	Fri, 16 Aug 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="jw+qvMg6"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2063.outbound.protection.outlook.com [40.107.215.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8150144D20;
	Fri, 16 Aug 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800303; cv=fail; b=TtNuPDIL6kXA98XFKrUR/4JCUsnGngl+tgbwrYuCsDKYyl2TR8IwaVkoLmOuLfODgUhqPQ4tdg2on7gvCwK4VGg6xiggrFlcdRdPzKQs2pZgxja4V2mGhJt5C9VstC4F3kKZKC4KOGlLiSY6XSBPFEi2NuejnsrilcYWoob4uiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800303; c=relaxed/simple;
	bh=Wbkb7AWPjYhKrtGbgOzA/rhSvxJ8PegMzEHm5IEuWnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atvCenRR/GVl9lGrsnZVf+yhGn0E8epa5QFA2EKR6psLynzD7+p1vr2jbVUC/+juLLhhAeoSNp4HECKR/dnJnDhti3mA8jDupL9hOYKhryTz5gi9V1avsHZWeyRZXs0yUE3bAP/LXNdvOtMP0lq1X08jJf/vY3OZp0GUpW7AHtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=jw+qvMg6; arc=fail smtp.client-ip=40.107.215.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C03odKV0gKkqn+KJ4Z/pcctzNcln49n5l3++mPL6++ZeJq9rcE9kTeOfO4g8OYj7DDsKmbQSQXQgaBpG5NZCe8JvE5xISK4V5gKZp/9BKIxFeKhn1DdWVom+5MThzkGpG6mw+Y0X/nqcIHIovha9mV7m/MMVzWkPKt0WTMWlVsdnPq8MTl1cFh8rxCFZ2L+cY0Yf3hb0DGSVC8Iuv6Q6TN58Mspubzudzk9m6iXw0lzey8Ekzir01/yzDAExoa9pGAIeS2H0lZ8JImz3vcPHL5u7caX7i1aI4MOJ5UrRkn39oqjTZX15S0HkxvvR5RI6di0LBdOKt/A4xRqygghemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0cbZAgnLmtnZUJUsofCz9gNyd7yXSZFoo6OAwbZAno=;
 b=hnBhwQl4WvtzslOLLHSDDftrw9GZba3huYwNuZ2q25dyux1zPOftBBJYs1eHkcFpYuE+NRob6wOor3voIzNjK8Uiqd8iFoilxxJWMMRz6s1MoeP1xVvZXIVkctMG239h0zFEvYcs0Jki9S9+6UPpU3oW0HponeM3wyks0/k78lWwblhDZfosh+b3ODNRnH08uHTH1dyRatQ+Jn5JD1fx/WpPW5cNZqIVCoiIDEWhTtN+4kPJqUdQTsiiX3I8ss50lJUoKRZbMhrkqjfx+6/Ew7MJGIEq7MIxsqXPZJfmYL80aC29yV6taG7PnjcJ1u1SJs8Srkvk5x/ACF8CbySvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0cbZAgnLmtnZUJUsofCz9gNyd7yXSZFoo6OAwbZAno=;
 b=jw+qvMg6EDZVXNT5+drQg9QwpTW1s//OxtyTeFQKqUj848OkGTyl1ad5RamF3FbGaSBsCuL1bukayz943R7q+zYl4mOH3kKqcbsCAt2Ze6PiZjx8Thq694myZ0jnddeEWdkYWgBiXz0zVp1Fmw8mztL43XxYtg1yjXqnBVo/A/zoFep22oxRfDP8+dZ2kFP3EoMdzUOz6xv2/jm/MhyjpRRlzmCQY1PgG0zifm67CbeIF7akfdesqiflcaBfRJuQ7mKnkfdrwRzZgbeg6Wm/JeMUDrrR1uBkfsZXfK8zYz42sJJJCovGDcR0JqsMNuwjnZbsIYgVGqxzWe54yCacvA==
Received: from SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) by SEYPR04MB7632.apcprd04.prod.outlook.com
 (2603:1096:101:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:24:56 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::a0) by SI2PR01CA0047.outlook.office365.com
 (2603:1096:4:193::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:24:54
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
Subject: [PATCH v12 06/28] ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic change
Date: Fri, 16 Aug 2024 17:23:53 +0800
Message-Id: <20240816092417.3651434-7-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|SEYPR04MB7632:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9ff2c31b-144d-4790-f332-08dcbdd54a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rQnjpkw2gvyz+BaLChmQ8gXX7tXz5mYT+i6Ya5rg+mJsSBex8BfYQMY+JpTr?=
 =?us-ascii?Q?VWdyoxW3D4X3VXLEI/6jnWXmqUC/hZut3HXVm98YGoHIDCkfrwR12mBV8y/3?=
 =?us-ascii?Q?D6OXXI8okXRe0ppyKu3gLtEd8kiyaeAuusZZDufQhtCeQ3qA/cNqZ19+oh9u?=
 =?us-ascii?Q?dPcHdeKBtsyM//IuPVcdgpH2uoZPa9XGuDoalN+VfqNakmOB5UEJ5hLh9utc?=
 =?us-ascii?Q?YTXKmVuIszDjwG5+fubyO+IwuSkG0LQ/62bgDQBTKNqLX3l30K4J35UOyNv3?=
 =?us-ascii?Q?y9YssEFB27HV3gtPF+qjJZoPUd4LsF/l5bZI4FOBD92SNQs9lv6Ka1QNJVPJ?=
 =?us-ascii?Q?oy9klxFWx90PTJtUdSJWNsSzbPU9OJtDUAGFto6mgKJ+X/yKR4FdzXSmMkxv?=
 =?us-ascii?Q?Q3U682p1MbnprOvOCfAi2iF0OCEXK40RmuaTtEgfHpBs1y8m7fnueoTRe50x?=
 =?us-ascii?Q?Hg6Y8TfJIcjnCkFkceomzN4V5oVQIQnQAVxS11rcKRxMSZxvGT6smJ44LQ/Q?=
 =?us-ascii?Q?DzWW0k/KVcYEKkwiEocxmLQp8uTckSldgR48HLNZ/QDzkjzrN8jzxU3HV0bF?=
 =?us-ascii?Q?2RxYRb/WNKYZCa5HGH5Gkdsot5tiPpoEAtFVLfIBblx1AOhg7PJoKlOH+Z2o?=
 =?us-ascii?Q?Vl562uudBnntdRwCq5cvIPNXGCaiPu4yJDr1A45rfRNDc5UZRUKGOJl1g+IE?=
 =?us-ascii?Q?1vbJozSi+Elll9Zk5p95q7aRPiQBR1hGjqbBYH+FclMM1/4G/THKCxM/Jud6?=
 =?us-ascii?Q?Z5JB88Y/47AbRFhtAWDMWBm2jjcKn1fVYx4IWBTsb8cOoi35dddVxXDg8hfN?=
 =?us-ascii?Q?g1BRi7LmkMrT6bBi5R5YBeC/vjx+sN6CXFY9qBXSZm+BPemiKgapx0+9koKT?=
 =?us-ascii?Q?ake4I8JmYAApnAh8DSOsFS6tIlLP4S4Q6cNBuwpnN9L9aoucc6FJrMy4QMb2?=
 =?us-ascii?Q?F8AhUGGi349G1TC1WP/etXAGveyrUO3jStgU+d+FCBx2xBg7jxvDEDOcpbSK?=
 =?us-ascii?Q?1V+AZaq3JpjnZFYmyS/jOVdSnY2Eaj8wdp96+7jDuDNaYBmipkhZ4a12r6DD?=
 =?us-ascii?Q?ZRWq6SPjyub5bda4vj/zQRX9Q0Y5aoFXT1jwwlO78em+7hFCYVr/07AusZQM?=
 =?us-ascii?Q?r6F5ucoAB44oI8U+K7LxrEyYVRb4McaeV8ymoTfAwEKttCCa6yO+2VokblIf?=
 =?us-ascii?Q?F2HqoqXIb18ygCOC7wxNS3oeHZ+JEPovj3mli7w3I8zOSNAaLTbaqe9P2Rsx?=
 =?us-ascii?Q?kytxWM1zheF3TfXQBFCTLyfYY1Ta6+51jQD0tZt3mPDeIFvMoYR0CcUSIZX9?=
 =?us-ascii?Q?NvVB6rRn8RrnNsTdWcrEAwpHYT4qdbJdmng1xpme6Jlq3VIUz1ULuLIKe6LR?=
 =?us-ascii?Q?HdX4zjbyjgB2BOij2JABpym6hWfeHPpxKt0A5tNZg/auTEEtXUzomIpIBLZ9?=
 =?us-ascii?Q?w506xLCefpWiNnndCcm+gVS66GOWigR2?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:24:54.9034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff2c31b-144d-4790-f332-08dcbdd54a5f
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7632

Revise power sensor adm1281 for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index e5354efbb903..7b79fcd77c8c 100644
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


