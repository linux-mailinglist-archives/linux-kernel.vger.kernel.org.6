Return-Path: <linux-kernel+bounces-334069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB09097D243
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463F01F25A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884DC2AF0E;
	Fri, 20 Sep 2024 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="tGZc51sA"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2047.outbound.protection.outlook.com [40.107.117.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A872762EF;
	Fri, 20 Sep 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726819357; cv=fail; b=QYndyQZg9B5cA2GcZyv7sHQ6VPlYzIb/RlPWUp+/0IFRT2GSrbNjkFIxiR0u7c5is6d6ouoGIl8VeXKX8wjo7Ipt1RcerEfrjIgmoehUa6iutmR41bF644Xl2+S/koST1vuEJ0izaJxfuA/1ZuxMhXrlMcdhvSfHKYLmEG1YyL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726819357; c=relaxed/simple;
	bh=bC1vaDlTXL6KkbaCo+RYJbMY8DmwtNVaRMxayp36R9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=vAUQczIqRKIPJAbBbVd3Q8thJ8b8zL718U3l96O7V7jazXnMg8QhADfBVfBDkN9psg/xGrfjPYxPzCze499rnCqID0f9kOalMa5Oh+HD47IRwMntDllNXm5Ci+Ed7cnp4Zg3AJzUiL2DR7laP5+odW1CLQT2I7+YqwpnvsSq4Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=tGZc51sA; arc=fail smtp.client-ip=40.107.117.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEBTCIN9L09y12JqtJHDKBi30Bvt5NA3XZxvw1diqgLzIhtCWU3R85XhVMzskSQkXmsFz1aXSXE/V3s9Gy2mfGiBsIBxwKELvvuwRM/OqWsidDAm8H4vfFgiqpkADDfJLQYDDuhszSAOQCDzh+VPtXkEyeZqnnZd+q0Z2oIMH/N6j8ijewBAMqCD/Iexgtb/vRy5BCIy7XC2DpbhlHKBGcjGWyW2D4vYGHhXN8UB7b3Iou4N+nBTcJPZNdvuOSJZaA6i2MtkDzqAkErzINc4NNLycts7CNGu0cqBmXdSzk37B0aQwe+rctwklfJt08GcEkMv/bXo3dhXMSY/TWCShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCjI4Z4PhO+v3yk3B6XlKuJlSm6m/P2L9KbKt/2/bxE=;
 b=v02EoFHeOtepwAwilYsWG1gBX6NA7+z02VRVnReMAXhmXhdaBXGYUo7GoaVNFKcVymFn2jtVYHm0/dYQxy34DG4JkszNDY9gVFhakdzSN033zs1piTJPpt86ocL8Bb9x9P6kVd3O6P1djKfEDkkYhM2gvonWRZ98f5pNKHaMJDLdYTUjl4Yi5epASwkxhuxQpcuulHcOyYEgzBm0pZuHbzGy0VpwiHrJCCwQ7KGq4LGXrazp/8sGpIBvvcr4OxizwLo792PF1sud+LU8V7DPiOQlVSkcOSqFWjgPymnI5tzGpQsVVh3t7FvndzpY7qMbXsNrsUBR6hZc/IVgRYZj4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCjI4Z4PhO+v3yk3B6XlKuJlSm6m/P2L9KbKt/2/bxE=;
 b=tGZc51sAnu02UAzkFWrWhew7afcUGbZTzHcn5vDOHalH4HzDMsqsNI0Uv0SFt+sA5BV/9eTFmN+tlIFkdBhayCvNArPJzseffo/YpO8ghZfiMHcUQixzKiWFP2UtX0Rc6f258EsczY5Ghmo5GIU9Wy7EX4TE695nOFEYj5QDwaJliDFDWYUXidCgvq2jBQYYLHmWUAJnMP/coXSVz9xXgTcqgQGk7YkD1uP+8GAPta+quxuG6iD9RSwWFf4xQVSgnCY5ApLNNvEd4ncxZei99wdcHvgNagPZuuGEj+arEIZosYl3FP0zPM6Lix31XFKUF6Zw480jcWHquflf7hwFAw==
Received: from SI1PR02CA0017.apcprd02.prod.outlook.com (2603:1096:4:1f4::10)
 by TYSPR04MB7275.apcprd04.prod.outlook.com (2603:1096:400:471::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 08:02:29 +0000
Received: from HK3PEPF0000021A.apcprd03.prod.outlook.com
 (2603:1096:4:1f4:cafe::11) by SI1PR02CA0017.outlook.office365.com
 (2603:1096:4:1f4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.29 via Frontend
 Transport; Fri, 20 Sep 2024 08:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021A.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 08:02:28
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
Subject: [PATCH v2] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting for TPM
Date: Fri, 20 Sep 2024 16:02:26 +0800
Message-Id: <20240920080227.711691-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021A:EE_|TYSPR04MB7275:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fdeeac0d-6cd3-4ab3-2591-08dcd94a9284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jW94vp0s6WfkdB0u1KNql1Up78u6DDtPfNmyad8mt+p/0RsmctZxHUqphDsM?=
 =?us-ascii?Q?9bvvFB0LBJpsoG0S7DO3c8KbO882p/bcUXaTyfSJ9Dh18asgIAiOOTC8jZLA?=
 =?us-ascii?Q?JX5XjJ+25rpEIPgt7+C+HBwJr4Jr44eCgXcLPZ3jWj9oIFmRVIZO79qokiyN?=
 =?us-ascii?Q?BgFWW7EbYDLrNS0xHPdwWslNqPD/no+LuDIqxzyQtzV9jesU8JLcEZKyZCI4?=
 =?us-ascii?Q?qa/3oQXfvSFi/Dqj6anw+2XAeWlNPzuK8nxunyMST/WQjjTdcl9v4baM7O54?=
 =?us-ascii?Q?WJ6irLJ5cUcr6RqsNzyT881rHroRZHmrG2XnqEZiY4u7hFopS/IMC15EEOsL?=
 =?us-ascii?Q?Hen3CK5rtNnx4mgdc5gAfE1whbfmtOl0zAiwD2H8NsBTSU/CsIO8JRAgHxgp?=
 =?us-ascii?Q?JCWwmHtnAdogwqxB+Al2kSR1G5GIdTHw9vpanG+44GQxt3gnfdjPgMZ3dLhD?=
 =?us-ascii?Q?Gs4abgD2BU+9h14v5/lMxKb/2hSe5EMiKt4EJYfSprgvTjKLVKD9nKTcdEkt?=
 =?us-ascii?Q?rUX5IS4N9akBWmcvryzpBUhaDDbIMkg0lMBXeeudzyJs3HecpuvRJiNXmBUn?=
 =?us-ascii?Q?mXgT3PlDOuARz8iLu+vYLHd/AZdyqjqjpwGGh9rPqYihHA20kFvO7nitJfr+?=
 =?us-ascii?Q?mROwjA4hG2MV1IpcbifRympZTZd4UVbgJBk7EeyVP7GuJgISweL3wfpQ47BK?=
 =?us-ascii?Q?p7UIVPJmyiPD92S9+ghNpnoSl4/YNbnsbU8JPEKeIAZRDkr+v0eq+fznBVBC?=
 =?us-ascii?Q?zVmKi8JJQzdhabGxO+wqGMq/FuX194goRtzDytGYgFkaIwpVgjxBrknlZpO2?=
 =?us-ascii?Q?yrTVg0v2H30+mJJ7Y+wNlaXB07cqIVUo9MByFF9nWMKZpllTUMa3KDDJAT8+?=
 =?us-ascii?Q?4nhUYSFRdxqvV+y8wPU0DuV7F8+FgY8Ej0MzjPvujaYXOD2QJSAxeVfZL9ET?=
 =?us-ascii?Q?NkF2j1yZZJik/AFb4q5AhHR00e0rnME6wxaDfYqCgTlMtH+8aJwMMzTcAf95?=
 =?us-ascii?Q?yzGDpjNNsXVESLMr7N9bNt/T6FFXdEBZXVIvzNk/crYwCSzxNXsBfhZzPeqT?=
 =?us-ascii?Q?vRMDf5y8WHNkVJl9hc/MIiq+gawuNCD6rdyOl+X7hO4NR+YQHKf841NO4px4?=
 =?us-ascii?Q?W100u4gt0EkyjtjJtXFjM0xCGzpELV5bd5amyIH9RhFiaIodke3yy9dkYay2?=
 =?us-ascii?Q?NFKgmpHSXyUnc2q5HQ2NINP/FOQmcBt5b1tUIMQoE+Vuczp7kRlDTV7Mzd9B?=
 =?us-ascii?Q?DxU2gAXVD7Z/lE6Am8XwfW7oSAd2YqmvtXhj5KRfm/Q2AofcvOj9GBKgGL1S?=
 =?us-ascii?Q?4uDmDji3ZyKaQi4Kcoj7j1V/WcuRFUM/Lni11u666RwFWn658+++4iIfxGuD?=
 =?us-ascii?Q?ER7SJcw=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:02:28.6365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdeeac0d-6cd3-4ab3-2591-08dcd94a9284
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7275

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Enable spi-gpio setting for TPM device in yosemite4.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..869aa8b3f411 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -34,6 +34,24 @@ iio-hwmon {
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 				<&adc1 0>, <&adc1 1>;
 	};
+
+	spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+		num-chipselects = <1>;
+
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			reg = <0>;
+			spi-max-frequency = <33000000>;
+		};
+	};
 };
 
 &uart1 {
-- 
2.25.1


