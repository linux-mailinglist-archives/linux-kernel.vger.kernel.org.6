Return-Path: <linux-kernel+bounces-300802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEC495E8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35667281786
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D413A896;
	Mon, 26 Aug 2024 06:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="lZk16yI9"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2058.outbound.protection.outlook.com [40.107.255.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2959313A258;
	Mon, 26 Aug 2024 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653508; cv=fail; b=m9YMYK5TS36fZwyOZpidyFnbTlqFiqpWnVSoedWjk1HjVrxPhHZotnef/dyjLrxw9o7QYxChBYIh09Ecd0W3Zb10ZWMLyvoB2j6AvHj/d3jGZlloCUnCpJwAj8DGH1Mun8RkHmClxa1o+u47GIQ7LLdtM3GoIXX7Ucp6BvQy3ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653508; c=relaxed/simple;
	bh=WC/dcjR1tUqtqDip0Xs2AM5RqTGhPS8rf/xSzw8zvQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvtJpJZoJOZQD5M8nmOKHfCsGLCCpUjW9xGtu1PmBwOa5xx5DJGRisL9lzLXH+J5HjVsyir0xqWV90JKjFyPKyhbzmYawA5AT8hHd8wPPA9MKdln7fqgdxcyqJAoomBV4WvLCExpUwT0HQwpwq/ne5Xv4yvYn1m2/AgfCZD4ezA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=lZk16yI9; arc=fail smtp.client-ip=40.107.255.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCz0PZXgvUEAZn4CEn3KDTyK0tS4WI75ZwKxqUJRl0wRmRojuSSmBnBpBUQOEPkpPA/UC5E1dqJJV76igj/0q1NJeM/wDnM6LSzY7Oh8DKEvhEKyPDP+6YDVMwNt8j4FUGR8NwDj7wOc5+zdNrmBKEedetmBvAWRfEMdThTLRJCr+60EdV9R2fM80kM8K6Y//FKFtZCx2sT3ipJg6Yg4R7m8LXA3nN+JvQnADWH7Orv5j8iP9YounKP4U0tO2LpN8i+U3B0HbD5lh6ETAuJbtgYcAq595VdO+so8AQAKKEKkiwrsEh7/qskwygd2HiIc4VNCQO0nqCqA/VL/h5Kprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKZ5ogJ9/YHI36u51f7OMva5yJpzuLKM9pz7+UUgD64=;
 b=sQ8rDYxCY7lyk1s8luQRxhjHzuQjFn4s7mxzFvLprHU7XKiQoGkqrDoav5nO6ngeBeZR5e58vQndS2hc1H/ayXPwspBbd4x7SmBduiYXF6627VACqQMGEvU+Yjv7TanGben6Xhvf0mH5oRrCL/SX83iqMGcr7JHUUr4OPcaPrB5ZJ3/7gH93rn9zKiw9EkvszQwHA283V3APrQR28YCDRD9pPpYyUm0SfB1eqjKl9uny2eSDAnrcmIAKn/jzgUeThGFAtcbITMrCeS2WXM3xVyygF2sqvx5hKlr8BHjA46rya5rnmAGjM+cz/vVYeMWuUgTa+tQ8hXFdzISrjyYMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKZ5ogJ9/YHI36u51f7OMva5yJpzuLKM9pz7+UUgD64=;
 b=lZk16yI9Tg9THunCu3oNaKS92QnF1Px3Zk0uobUBg1W8RmAvanibkagMqZ5Jsc3gCbGMLHUAIQu0zaK7mnkuqnVdjPIDedsyXxTYHPF2dgm+ZHkALPZ8r32xnvpjaJQWi2/qlbh5NPL6A8Fw9oBQrZOkeXuTtmgccDwaCtNuzKdRInTWk7PcM29TzR1lWTCpleFPAsRmg/8IImOCHfJ74q1+hHVzW5I5E4JABFepcmUs9QsrYQbguqxIRVtaZhEsm/bKNpmVmTefx3ds1zmZbLBDdA907hyBfUQSEaEwpVWzVOhXeoXf/0j7MTFUk9S87Tk2El2W7ieUTSdxPZNOQQ==
Received: from PUZP153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::15)
 by TYZPR04MB6499.apcprd04.prod.outlook.com (2603:1096:400:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 26 Aug
 2024 06:25:01 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::c9) by PUZP153CA0010.outlook.office365.com
 (2603:1096:301:c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:25:00
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
Subject: [PATCH v14 10/31] ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
Date: Mon, 26 Aug 2024 14:23:44 +0800
Message-Id: <20240826062408.2885174-11-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYZPR04MB6499:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0893c6ae-3674-4df2-de53-08dcc597d066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PLZOiNSMk00fWMyjArtY/F7Ta64KC55PQoPvusjR5mkIxFS3wMvhcjB28Qp+?=
 =?us-ascii?Q?IulaIVeAW4qHRtK/DfdhtQxpXAS6wlOhOx+MTwVqsIjNYcLXvG9bGVupvzX5?=
 =?us-ascii?Q?ObeVHptQCFHS/L4z1I4TV37SSK5AVRHU+sSw4mFPXMBClCfPLShwmAvB93kX?=
 =?us-ascii?Q?6qMdhogdwDbPPVoGOKHCQu84ZofOuipWUm/yV0cwySn8tSukbSYZUHYR15EL?=
 =?us-ascii?Q?JjVmxcKil9A9v4DYVz2ovOiL9aHoVUT/zyoSNeJYESq1/cNaKQTfHv3092pD?=
 =?us-ascii?Q?iAQYZ95yoIKiZC+TksRO8I6OQI7ggml6QxCJx4nyqPPGEa/zYRuWwBExQeTi?=
 =?us-ascii?Q?ODM0azNq9sb3rucMtHIbU7sXiojW31QyH3fF1Xm1t2+di1FTu8f65NciQc1g?=
 =?us-ascii?Q?TzVJlKezkJylWY6h7slXqkOWvTyw43c7j0bE/J1/2monelJ19pb16ig+Bx/N?=
 =?us-ascii?Q?BimTe5yQMl0k/9j0vhcctSkEpZBoWwHxgWe6HzheVnYYNQYn1WXWmydKfcGl?=
 =?us-ascii?Q?deP0tdeArAMPHEoiarXTWWeJxVmj41pe+paE53M0biVYbwXZg1oP0B4m//al?=
 =?us-ascii?Q?ewEyeYj9D65zDp8S25wnB8XwoH4k8ATkuD14qTZrtG1BXMV+t7KLrElWujyH?=
 =?us-ascii?Q?YfWff3utTDcfaQU7rJy9Q29eEnun4LvZAIn8COSbMZARl1/upeRTQ1CLkmFq?=
 =?us-ascii?Q?JKfGzzFKHr7ekoiLYypVaw4d0umTmoBIwma5pkJ8OaXa6LQXLTcU8HUbK3fm?=
 =?us-ascii?Q?0xMCQiLjXVg5L2RPSviOH6U6sAWYrE+PehGAUfJ822pbSBlUXXh+6HPHpUJN?=
 =?us-ascii?Q?lkKfiQrfD6oboFLNMFaa86zXpY85q1FMWvY+KBt9beNJKWpOQ9TTMx4g+hVA?=
 =?us-ascii?Q?rhlRy4kCrZmW8V2zHXWtq9L6tJtxuwykzMREKVHSA8/axO2XMadG7Q2cV7MY?=
 =?us-ascii?Q?i+xIRWI2Om8K1L4eDajvvIXw0TaMn1na1xnoTprg/FrXbr49ukBtTDxFz97d?=
 =?us-ascii?Q?wI08AuhKn37MakZ/IBxbvyp0+CX/AKmiz5g76efAqhgbAI/eulPrwwsEPjGX?=
 =?us-ascii?Q?NBJgb9f66baGnzAuiSNtNDwFqkMjRmXlxRLErf3bVBmFzxEaI4g/cRMTyLMr?=
 =?us-ascii?Q?n0ihfC+CCj2STmtD1IeqYdKBQP3P9imn6deP4dmxGWQS+82v/4aZr6UILjEJ?=
 =?us-ascii?Q?hGt6O90j7LzEV9B6J9n2/tc4iWkkaAkPaNlgnzwOoEcRgc6rj/3udTegCmj7?=
 =?us-ascii?Q?EU9yqryeGU4CcTCRDxAfoKzu0BmafwnEQm9ZCARcHFyjY6BtbuCdXsG5Rw2v?=
 =?us-ascii?Q?PenvSCnyI/V1AJWn75NTevu09B2C/sMRp+k/H/sQtjzGpzkmyK9Vvb41ptQj?=
 =?us-ascii?Q?C/F4mFE56jaWkMkg5EFXRtZKB7E9diNt3ax2xKrys+iIOlUlWGZF4hLw8dqA?=
 =?us-ascii?Q?J1I6YsvPU/fukgFDVpFUKbHIIrUBapZt?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:25:00.4716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0893c6ae-3674-4df2-de53-08dcc597d066
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6499

Add power sensor for power module reading

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 09bbbcb192f5..139a09de24cf 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -906,6 +906,11 @@ gpio@23 {
 		"HSC7_ALERT2_R_N","HSC8_ALERT2_R_N";
 	};
 
+	power-sensor@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -930,6 +935,26 @@ eeprom@54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
 	};
+
+	power-sensor@62 {
+		compatible = "pmbus";
+		reg = <0x62>;
+	};
+
+	power-sensor@64 {
+		compatible = "pmbus";
+		reg = <0x64>;
+	};
+
+	power-sensor@65 {
+		compatible = "pmbus";
+		reg = <0x65>;
+	};
+
+	power-sensor@68 {
+		compatible = "pmbus";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1


