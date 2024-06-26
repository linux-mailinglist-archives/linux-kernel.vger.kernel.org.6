Return-Path: <linux-kernel+bounces-230364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499C917BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFF87B23B05
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA48716DC08;
	Wed, 26 Jun 2024 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="a6sMt26F"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2084.outbound.protection.outlook.com [40.107.215.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443C16CD0A;
	Wed, 26 Jun 2024 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392898; cv=fail; b=LRw4CJiUmRD3hTquWqt6Fgi3BdB48gbGyisyt45L6M5/U9B09qHY1mq9k3ia+DYwbe6jvkfbBldypKah5B6GU3gHbT5AymH1bSM3WSbN0w9xrqzoT+4rogyavyVE2sLZ4CvKinB/LZ5X0qSOaTsHJDXU2hxjRKOFzJ0S5cJr+ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392898; c=relaxed/simple;
	bh=aiaTf8XPpaA3BScB6mYDXX0MorBG0OGd83cATmJc2GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rq82urPZvPNsB7WzYMXqBOl5Nx77R1eX8m79qQyvPcyXiMIzve9xE75S9pMhQ/xVsgVvxwHqZOpWUoC/WKodP5ULBXSlbudAfcT3B1yeUPuOrU6L87+GVxZfqTdQFmx8Q04b0SgEMM79M/OIy1YGf42P7Mgl/1pibBUcm3YCgCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=a6sMt26F; arc=fail smtp.client-ip=40.107.215.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6VDn2VDivVC7ssIqzpOxcWI4nP0Mua12aRRqzcODTzigzjwJKb+91ixZ26b6Pk3PDGMtGkiaW0UhbF0c6SFBMnPMU4Y2kaF+l1Y7FF4RwFFY3VJ/Z9znTWjAWVSsaTCfyGqmMYs5S2a8GAWWzrHxUiMiIRIFbVyNOUfHx9cyP5eiEaqZq0IhSzmGhi7Yd8I30QPhOhNH6LZQpLyugKwWeNNKdbf5aO76hQRgqXdQFLV7wYG0GQk83LaQk818EmyQQRsqydRT4D5zo7drSRaL8R+PG1mZcHjEKPREXDpcMPgYoEYnzi+EpUQyTLAW4DZlek7Ik1RiClTDVFjD7opRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DIe7675LKkKmPyG6VqKrZMsMV8GiNtMS1alBZCvnz8=;
 b=H48YKs7la2CdUEPqD1KJjXEPpRCvfAVRRrlo75Fp8ymSHuYsbQDrec7DUYHlXfqQvs0PAM/773KDZC7JtvfIOes/x0EG96YZ24gNCKytHpwe+hQKIQKVespqm50RuSU79Zc/OUsQSmf6VLJmf1cUndNWeeEMS68m/GtFtnYCK8bQMTb2q6Y7JPKpw/QTNzLj7WXQ8pA1UqJi9Xz5XIeEWkNX042Q3wVEXjRHB2j8O+OGwcb+PuctOy/It7r1A8/LHW1iJ5ej5D/8vtpFgJZiwIoZryN1WHWEPHWgC1wJi+vl7FzIdMEhjLhxj4nq1QLAK2FzHSkM3t7MfKR2VfWiFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DIe7675LKkKmPyG6VqKrZMsMV8GiNtMS1alBZCvnz8=;
 b=a6sMt26FiUQzw3d1+wiaLcc2v973O83Cbd9lIrttnwD3UhU6GW+xiDUHR18d0pIyRQDer/mVW+raUP1JjVgP29NKdKM/tcIdS1EHZ7UAgFhcbahDScigJTT2xqyBpB/QyvdbcpIdJhWjrJxlf4XE5VVgYzOcGEllpaYg/G5URB7+eIbV/rV14deuY8A2OjcU2ce4/VMkYp8GQA+uJYQ9y2WDD7LDc8N+AXV12QTX1jrZ+AQ5WvBfw1AWc8AN0SXMhqbNKUgSMy8L0A9CHJKns7n3g4ro3piNqAY9SUaF42sIh4J2wjj/os3zoTGvluLsEWaMwHi9FYVARIOJuWMqQA==
Received: from KL1PR02CA0008.apcprd02.prod.outlook.com (2603:1096:820:c::13)
 by TYSPR04MB8002.apcprd04.prod.outlook.com (2603:1096:405:94::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20; Wed, 26 Jun
 2024 09:08:12 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:820:c:cafe::20) by KL1PR02CA0008.outlook.office365.com
 (2603:1096:820:c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 09:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:08:11
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
Subject: [PATCH v9 03/26] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Date: Wed, 26 Jun 2024 17:07:19 +0800
Message-Id: <20240626090744.174351-4-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|TYSPR04MB8002:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cda25366-3c07-4c2e-4ae0-08dc95bf8111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?psIuPNTNkQsrVYONGJ4Xhjiwi+Z20A1zCDOSNzSVLs3DmbCzvJhjVW9V8wSv?=
 =?us-ascii?Q?s1gQ/7htQueJDAbbQsqvXb48WngHU0Ja+8Nw493+SivjRc84uYLOKa+r4KIw?=
 =?us-ascii?Q?hph9hwYwEqjKGbRQYe4Yc35Wayv7wjR6UZptvPyrrHfOH3oUsYj7pqiuSHe0?=
 =?us-ascii?Q?Yf+z8LFa9ZW+yCn3Q5EcWsYWiHsZKSAifoeFvmRP5Gj1zEedCFmq+kAYHkz8?=
 =?us-ascii?Q?lGV6yzghIIz1CQ2ipvKMlA+G9O3AJW8j7FAJjc3avaHuhrGn5zJYBMVgNPQA?=
 =?us-ascii?Q?BsgMvw/OnT1EykduecwiqmncglhnJp3BQF6d8WkwEXy5a/lL3aTLwHPWcjAa?=
 =?us-ascii?Q?YVPk1gbs3u52qga5QwzWZ42YGKJcsjux5ZkT7AsqGsvnR6tYgK7XtAzV3JvQ?=
 =?us-ascii?Q?7y/Pf4dbszdGIaMi9jwo4FV629E6SafXc4R39nhRlDCS4VMzbvmn353ZDetM?=
 =?us-ascii?Q?IkFGAUNaPsHz6WdoFWD8TyiCm6tPv3G3r0zws5Ly4zDtkaYFqtzQPCKVelNg?=
 =?us-ascii?Q?IYr4sr9ImjuOHRupY03FgriCkgJ2wWUTiAN9h0x64cCHoF7IqreKQzsmURLt?=
 =?us-ascii?Q?sNRC68LsBW9ZVTbql7Qwn/9eeKOmWC1rWw9AW/S56G154zacblBkWjiHGJpF?=
 =?us-ascii?Q?7ClACSibXCJP8/tRa+fcZm/w9PNqdznpQuzHksN3SeU+ER+dzUKm72o7kedC?=
 =?us-ascii?Q?dDDArdVBUEbhM3fSXNWCy5OeBsPNdGdfS9nl9OfpnXm0mrCVtaI02IsTEj2n?=
 =?us-ascii?Q?Patcp8mkIhLslofCcYZT8gfTJ9rn+w561DgzeTbAwcLGcLrcBA92OHrFZHWX?=
 =?us-ascii?Q?03pN7/6izPpaluh13pMzIiqSM6HG+94sPre3M6GmQyWwd6BrFm9/uEzq96iO?=
 =?us-ascii?Q?mWvItLL34DkoSqcdsVBRJ0FzXXuTJpKURsMfGVr7dvtCBI8abf8BfAKko1/v?=
 =?us-ascii?Q?wZVr6DPPCSfbmAp7t9H4ib/kTRRFJ1tmOrqw2cHT/HhicFAaUtkaQHBJHqMA?=
 =?us-ascii?Q?ALEokrnqG+jD1tUb9+ehlu/8404EH6NWF0xs0gSq71ypvS/ic5suWKKnuflk?=
 =?us-ascii?Q?mDotBg2PoDoPvjujLYQy4kVvFqvLJ4IojWLY2GeCEeD9Cc/XJKdbOLnHKkT/?=
 =?us-ascii?Q?4L0yNT6DnS4jnr32KUN2+vRDElwMOYUM1B6eEgWr4dWE26evdZ7HKKQSppfP?=
 =?us-ascii?Q?TSLSZdZ44yzpk9hSrlvr9P+5zzH/i18ztJK9u/yQQrLPbcm4iIpd643I+4iH?=
 =?us-ascii?Q?NGjWrW3mroMzDGWUxwq7c/8pIZo29hV6syA8JDRyQ3PY7YOZcRd2ibfaU3l9?=
 =?us-ascii?Q?p7U/lrbBqLFMYQ/kPaqlmlO6osNETTWLRPD/mUHn/1U+4ClfDkgGvFyCVHtz?=
 =?us-ascii?Q?Ff0+LeE6xDZlt7rCbfQyi0yPOS4kGLX6+gV4YIGctbcggwGj5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:08:11.3797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda25366-3c07-4c2e-4ae0-08dc95bf8111
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8002

enable spi-gpio setting for spi flash

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index dd88be47d1c8..effc2af636a4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -53,6 +53,24 @@ iio-hwmon {
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
+
+	spi_gpio: spi-gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 &uart1 {
-- 
2.25.1


