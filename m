Return-Path: <linux-kernel+bounces-322310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E645E972716
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21834B22EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2971494CD;
	Tue, 10 Sep 2024 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="uq/y+jfi"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2043.outbound.protection.outlook.com [40.107.255.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7181EB5B;
	Tue, 10 Sep 2024 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934967; cv=fail; b=IP17S1Y3m0xnMlMp+4Sd4CBfHLViXiYb37d2HTq04ta1x5R1Xo3+tIfT5Y6NQHsseZ1ACjEhwDiLVA+TEGyxrnzesK63migBmifBQL/i23hlfZ6UaltToYG1LRBeOM+H5kNuCqVx1AyLr12yqmQQVDueEsk6Neke4zzPkYorwrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934967; c=relaxed/simple;
	bh=YHbbkwVsVT9tG19+IMXnaeyAZO/k+WHXZVQO5Ln7C9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M+bo05m4znkqdZqsTPd+QGOEBeFRpTybwF2mGdcgJwyEQ9+Sp7HFSNOTgev0txEYvE9fipzjYLOCRBqVnGMRshJyyJEkQHRk7bxiPCBfM1I7IT5z+epRJwHQew3W17XfvWYJbEgUrM/Ahk41xsoFqWVkFzDZMVvzj+XmmGETz+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=uq/y+jfi; arc=fail smtp.client-ip=40.107.255.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThhgeFfVeIHpLV4P8KuenkyCJNtZp3rImRwYjHDYj8CYlRhFxvSeHXB31vGt5nUgnsXIK+BwAsII2PWoEIe+kyiebbQrY4HE218qMHHB0LjDhmaEDGdja1xhXLv2biDKjdhc8q5w/kdXSMWhVRr9wpNVzgfMtUww4LK0oo8Utd9P91wOExfDrWSX2Yi1h+mj0iU4tEhWCWcH6CEOIWugWppyoA46KMBys8DNLIyOXdo7OG3FgmymrKsA+ZXKOk6QbLiEEx8OshzcP+5uSqgMp4mjA5A0YkSbM/cRCucNI3tfJyluBkHOP31oYaQo8bnIRQDY1raMEEJaQuUL3RQgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SNZFdiDJ6UWUP0Ebv25obxa6HFLGTGPyNGvWVcvhqg=;
 b=yAoH2Yu0dG8brWPjJnpc1qieKr1XBnwVbzFX7rn9B39HCzjJ35Zo+z/CyjcN/LIF8/ekMgbZAKYsKp+vv6sYQSPxzdxg78LaUd+2N48zDkZC+0u4kf9+NuT04skWNc9LwkCe8sLHRHG6QwBMnUelinnTC+VbXIlR8niyZUa79pnkTac+0PuPNZdA0AcJWk5DLrlvIzmL7gnSN0peCu3jAs9KJUEOVuO+Nsl+Qk3sVBye+yAH9vWbrm4kTsHHFI8AS9JjM/2FKH8EK1AdUK2+8MPFdCqD6QrG27Pgnf/wJpW2LDXgqySOsipjaTRZWbGISSFYyYrVtwhI48D8SqVKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SNZFdiDJ6UWUP0Ebv25obxa6HFLGTGPyNGvWVcvhqg=;
 b=uq/y+jfi5A7EzOyPyZHoNbTSHdCvTui51LZInOwcJOcI8qoOG1b7JBHwqqEjkMu7UgXaJJEftxg4VnYjWpsnSEAk0kqt3fYnnAJQEZ2N1zdgmhaB7Y2dF0BRs2L/mp5Q0HWPzS1zA6DP6Tr9mQRb6nR9XiPWyGpj/UuVrpiXMAZnFDqS/8mjJy+zdSnWYfTJJvFOQMx3J146lhwO1iv9NFy5YkyEXtIP1f/RfyBi8R2b1jesb/IpULL2JtA7TbqOwg7X/nhpPbpQxpCXTvkGwTacW5OkD2XAXzJE6yPf47sDNg2QNDFtg3E3AqP0XyqTmyURqX8Tk8fddT8giBRL0Q==
Received: from SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20) by
 TY0PR04MB6375.apcprd04.prod.outlook.com (2603:1096:400:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 02:22:39 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:4:c6:cafe::2a) by SG2P153CA0051.outlook.office365.com
 (2603:1096:4:c6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.5 via Frontend
 Transport; Tue, 10 Sep 2024 02:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 02:22:38
 +0000
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
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable adc15
Date: Tue, 10 Sep 2024 10:22:36 +0800
Message-Id: <20240910022236.1564291-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|TY0PR04MB6375:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9efe5c7b-3eac-40f0-d3ab-08dcd13f709f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2IJvcr92O+AQ5xmAMMZf7u7kpIIrm8q52GiG7v6FlE3+HJv8jGZIqwK3fhR5?=
 =?us-ascii?Q?OfPEEvQ3Sbnlhwp/amKI7yZSfOJC8TXP1M6gVRevhXZVZQuurjVlLglNsHM7?=
 =?us-ascii?Q?dRiQi1Rp+TxQFJhllt1xiPFqXI98KeuKG/EJtRSs08eR1H6//dY0JYLydFCP?=
 =?us-ascii?Q?G0z5XuMQsEAhVIObUHbja1FvIvGJFMtjv2+Cr4r7h1rQRLmyASTwNErei0mT?=
 =?us-ascii?Q?tcn6h536SQIxJoCAJB7+0RIBTWw0jgFOFbjwHF4BfrSRoNTSuwyqyglgFsls?=
 =?us-ascii?Q?ms3gj9/uM2Nom08bAvIVrTQPZ6QsCJNcvJUs8fmye2isgFsISLCi4m9blupr?=
 =?us-ascii?Q?KCSiojWPKm51Ejh07pDuQv6zpQAFQvbcOCkZNwPFSYU75m7+O4CqAin0Zrrj?=
 =?us-ascii?Q?+2KHWT2behF0hGq70PE/3E6lN11jS3B+clipRRu/0lipNxG/Jrx8yjuGmiy5?=
 =?us-ascii?Q?gyqi5tfbi9+vJfHduwQUqM6BFBh5QybWA5rSR1ZOWM9PPSrnDAbmjgTxA8Uo?=
 =?us-ascii?Q?AvYj8B58WhzU4TB/WS3R2R7N2vEbCfQUzJElEIXR0X9Z7bfl3d/skNgfH8ul?=
 =?us-ascii?Q?zgaUHr6mJ4hGGS8rQUB/QE9M+Fj0uZRquOoyZ9bBLfu9XxgBV42h2c/fzn6L?=
 =?us-ascii?Q?QX8L7CGvrqmOQAw8WBwOKB9brfBvgMO/55iHlmAkiWsdQ6FO8UtoBJ0CzeAO?=
 =?us-ascii?Q?ZtVGb83YXu9MTkmFzy7AX//L5tG4P41IE3BSGGry1CP14hp8l3Z7f0P9MrZu?=
 =?us-ascii?Q?sAS6ISemOzL7sAFvqNDrOT00f95RKAzRH1fgYgE0BOIQVjkY+qAMvEJ9WkrZ?=
 =?us-ascii?Q?ugMutnHqkQ3F5BEX4vcfH1oCFWYrJEnl/urKv82yO6hHUeZHDBDohYWtjMLt?=
 =?us-ascii?Q?N6FFVgJwb2oRAmy4iRL+Caxl4R2UhZIdAOKeRu6SXhUJczDkD5MqTvEYYZJZ?=
 =?us-ascii?Q?PRUt9833GSC6o5Y2DEc9zeA1gQs7bqG371HxkYKk9Kcpo13ce9NKP5tSM399?=
 =?us-ascii?Q?8Eb3BW9zF2xdM0A0WclnMJSdRPv35elBc4LauBI+syQOQCrRy5Tbgvp7KXWm?=
 =?us-ascii?Q?VpMgGi7SLt3ARIjDw/NgmPrv+j4LQBqVCxYIcCz60Aj+XS0UBtmTuHoXP998?=
 =?us-ascii?Q?P5ntXJJNzkCOA8dldU/yHh9AQghlVfHU/toPGEkCN0s8x2RRqCpdOyNfbYQY?=
 =?us-ascii?Q?tN3KU3tPiO5WL88RqZAKK9XfmJcWqoC/H0YaQssn2R4Cr7GJfMUJnn8k20t6?=
 =?us-ascii?Q?CNzd3tU9eSOBP0RokpusWl41cP+YOJPgxRq1nF0yEGMJf7Z9LILGW+0LLWfk?=
 =?us-ascii?Q?QPwndTAm/MDtbsp8RTH0SPaqRDVtPDffgI8CIWtyt2ww2efTWsM3G7Cbre5o?=
 =?us-ascii?Q?oxqDvaYOxozq/kcYu6lDEm+QhBNdDmvtidhwC0xWPveL5yT4piaBUcV3ow3T?=
 =?us-ascii?Q?tr/o7jh/c6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 02:22:38.0091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efe5c7b-3eac-40f0-d3ab-08dcd13f709f
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6375

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Enable Yosemite4 adc15 config for monitoring P3V_BAT_SCALED.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..2d46f7d40ed1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -32,7 +32,7 @@ iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				<&adc1 0>, <&adc1 1>;
+				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
 };
 
@@ -612,10 +612,10 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 
 &adc1 {
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+			&pinctrl_adc15_default>;
 };
 
-
 &ehci0 {
 	status = "okay";
 };
-- 
2.25.1


