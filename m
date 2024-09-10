Return-Path: <linux-kernel+bounces-322343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D21097278C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521391C23FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400DA16DC01;
	Tue, 10 Sep 2024 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="s95YbUGs"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011005.outbound.protection.outlook.com [52.101.129.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B7157465;
	Tue, 10 Sep 2024 03:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725938071; cv=fail; b=C3lDZRe5t4RpQvz0rJJjZj2Xiu1/HAYiA+/zIMEFaLrLmBW4bK/+sX42m0xa1rnLCf+PK3xlEIz26pK4DsgdOVV1IBy9xeIWrsAkImdnJKiQqP00zUPqupQy3hpuvjKg/O14TWtwbNnLZrA2NXeMMcpyj7pFd7Y+XRXh42bnejo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725938071; c=relaxed/simple;
	bh=TNYN1HDGvLfrIZhzJ6os82zN60iYSRtSlRyjuUv2BB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Uzbk2CMa9DGfAv/Xg390FOLu7JXECf8pZY4cLqcy8t17S/Tv9Tf2HdLgLj18VgParTepy9yjTNbes1QUtnX9H23gJ8WdDRjDE73jnHFp/1tVASKkdjJSUMGN2kOKVPozL2n0iNYNJGN+CojytlzqPQL9Z3+FSNWfLmmzYpU5xnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=s95YbUGs; arc=fail smtp.client-ip=52.101.129.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgNLmhlC4DhuW4PQf9weE6ksxJOBx8IDsrqSyisk41T83OR4U4ZTlBJaoAFqq7byfSbEwKfiaJUy3En1c7RWeK5eb6kmdCtzpYmBVOgkpKggDNBuBBlribdNCNTOCmLwU3cpoJxoW5460dfZ1SMBkltXh7cMbSfTpJbXOnpATfZgZqRUdAtSVvKvTNKnIlmbmyGpAGmX2gTNJG9jvJU0/z67GyPXJgNRLMul+5sX+uhLe9p9ixu/cdxHS+S8iZ9DHd/XRZwfIgGkdMMQTZcbCPfK30mRIGzAjK9tLr4XjcDZL4sGiWuUfdWH+JIZeogNLq1K9LvmCichHHslBViS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eLOfRy1O9CIq8PXazbJE5wEMn2JL0rsvV6UeIi0NRo=;
 b=o4xMxdF9ovQP5MmmsC+hMne9ptcSl5RMtwzx1D4V/dBlEIpJTv/iP96zapO8sIu0EiLeDb2UP2zdDadCt8qsTRI9kszjGgR/4XPESa6kkawC9K7bPKxE7ukrki27W+SVU7ma+Szqo1t+F0qBUbNHFyUfIKjImatW34loePwWJg5qAiv5CUnFb0ykX3WsC88BHMpQojVltp4N5lIgXHVVT06UODVsLUZTMtMqeJK23L6/c5Io3YrMdHjG0wYeV/ISlw9yjriTycQYfWabBQ2hWlvuyFeawkmiqg/JrdvCVidbboRsHOGgefPqWmice+W51Wduf0KSILqnXWGns37Zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eLOfRy1O9CIq8PXazbJE5wEMn2JL0rsvV6UeIi0NRo=;
 b=s95YbUGsq15pWo9NSNILEZ9UaWium8SReAvWi+pL0gD3i10ysyILIB5s1Lv1jams2IBn8now1s94pzxJ/oPIWXznFqOauv69//MBHpEm2/ic+RVReOYdJfGL2rYBhJHo517fJXqwcz5miQ62YH328Ddh86/u4hZnUThNXNXG0dLHVCd7/g7F/IfE4cp1gR9gOB6b1p8wC13zfknhdeP+FPELr9icuIwVyF+VzXzWZo5ynl10bG6FEB2oQJwvajIdABit9zQcl+d6qq1TR6Cq3chZgoifmkIJ1UQKvXbYJn4B3uO6l2df37/yye8c/oN6DbYhwvkcjuBeAcejyml4Hw==
Received: from SI1PR02CA0029.apcprd02.prod.outlook.com (2603:1096:4:1f4::20)
 by KL1PR04MB6852.apcprd04.prod.outlook.com (2603:1096:820:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 03:14:23 +0000
Received: from HK3PEPF0000021B.apcprd03.prod.outlook.com
 (2603:1096:4:1f4:cafe::97) by SI1PR02CA0029.outlook.office365.com
 (2603:1096:4:1f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 03:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021B.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 03:14:21
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable watchdog2
Date: Tue, 10 Sep 2024 11:14:19 +0800
Message-Id: <20240910031420.2295727-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021B:EE_|KL1PR04MB6852:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 623474df-3c40-4201-68ba-08dcd146ab14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u+pvcp2Y01QwH+/jR6daL+8c+3k3gkLdcsiNeXoVyzN9cuC2/CgRKndRoQqf?=
 =?us-ascii?Q?MkZQBLQl3e9TlHQbV3m+P3Cz48xxMYe50gc7Fmkt7b6vhrxve1vruPOB2ooZ?=
 =?us-ascii?Q?LyesShapuBr/PKTtpMZfB+ZPy99qx0LEcy/k++duA8LRHiXxtwSULTtZDrPk?=
 =?us-ascii?Q?Zqf5Ib9NH7ceqIRabhiC4sotfREXKNIA78Y8tyNmZ802gZAAKuXO651oCEu4?=
 =?us-ascii?Q?wmwXmWzNHqYZ+1adrLtfHXGhUqS96sAf+sTXATlQ7WAxCy8VcAGyoFNQ3IHz?=
 =?us-ascii?Q?VBoMnvJ6aKTQvIdhW6svYJt3udogh6REnoxx4rGYQID1rmYYL+R7tOUBnDIE?=
 =?us-ascii?Q?goDt2QtCxvAK2CUfOtoGW92S9WrYmy3V4JQgljwBugpgjr2B2JdNW0Q73hPd?=
 =?us-ascii?Q?TJsay81G5AdAYbcx9IKSY5URsdTsYA68KRjJ6Xe2boAMShXPEUUdCBzq4vNF?=
 =?us-ascii?Q?rmXz8WRwxSHGzWVTQ/Yxz5lz7//fe74NcGxO3a9kH9Pq9pT3uAJR23czsouj?=
 =?us-ascii?Q?1fM6mTDSLMYHa+HoB1I8BRc1Dp7aEd/0feqKOgGMlYIHZuRgc3bH56f+qWjj?=
 =?us-ascii?Q?btpl32LVEmoJRnl1d6OL6lq9F+1FckVANk0hDi3TNDpdVhP9LA9qXLi8HP7n?=
 =?us-ascii?Q?s7w/2wikvEFYCm7EhKn2mk5+3D90so7WCsR41PSNjhG17ubAS5Ek68z9nJWa?=
 =?us-ascii?Q?KqHhLEAoWVTQpmgzcv5tjRQGYXTClBmZGCUsGPpdypflDw2N4AI/UYm6vJjk?=
 =?us-ascii?Q?1dGiyc32N7dXN/MYy6S8eNUdHQJDzjxn3l9DxHKyxKilgmB4PfXaweKjfKwN?=
 =?us-ascii?Q?8N8f+tIm4/lWJ/+IyXoElnC+UweEohM8A4n8aUihpIDB8YaOEOmrfrXWDmXQ?=
 =?us-ascii?Q?NNpdd/wNSRNUUuPayfOTSNEI+4kF0dSlOdqI3jtu4Ms9Qi35jcXGZmWaaMrA?=
 =?us-ascii?Q?ejC0mu6i0oXVCoD2aH6AZaRCF9wA54PfI6PZ+emXwqZwAo5fCVoW6PkcYxcs?=
 =?us-ascii?Q?WCoudp9t5yW9O+aemuMt003NWZc7I08pXPynsoQS6dyiRLwCvwpUFDWXm/EJ?=
 =?us-ascii?Q?sKkdaIeh982gFCsjLURQSYjPaFfRDPjYoJVG8dyZvN+RK409Cz1dmxnu0Y4G?=
 =?us-ascii?Q?z/RfGFH2tBlGvb20gZ/nnXxFQWvvAtv3rLPEivF15TrJk3Vn4F8Qgf/zn+ko?=
 =?us-ascii?Q?YeEwSbAnOt5ULGiClW7jItiERXROJVSbxGdIxzTmwUxF7Y74Wf2CrYMn2yAc?=
 =?us-ascii?Q?QN3dM+UJE1T3/Fy94YHLo2eA86MYWEcaovk+dzmQB2QsUX2MjhuY22QdRIEQ?=
 =?us-ascii?Q?+TeB2gNYpNx0nrsq7ZO6VBi6PQEmOCWTtm3oniywN8PSFiRyDOy1hwgSeUYm?=
 =?us-ascii?Q?f5oumiBK73PAch1WlzgjwJ2sVjA3fBSSLTMWBvT465S4VDAw7HDx1ylNyCU1?=
 =?us-ascii?Q?hEwhVuXipVJST8GMu2FOsNrb9E3gNtOi?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:14:21.4800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623474df-3c40-4201-68ba-08dcd146ab14
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021B.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6852

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Enable watchdog2 setting for yosemite4 system.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..c2dd17e0c5fd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -83,6 +83,13 @@ &wdt1 {
 	aspeed,ext-pulse-duration = <256>;
 };
 
+&wdt2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst2_default>;
+	aspeed,reset-type = "system";
+};
+
 &mac2 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1


