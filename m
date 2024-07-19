Return-Path: <linux-kernel+bounces-256977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4072937374
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A9F2811D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 05:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4844D8A1;
	Fri, 19 Jul 2024 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="SCxZTGfe"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2078.outbound.protection.outlook.com [40.107.117.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503B4776E;
	Fri, 19 Jul 2024 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368772; cv=fail; b=ALcnXLt1reHPe1a1K0EGKa4nq/1VDm9Qi4HdjxugzUQw04wUftbPttPlI0Vw75Wo4v1LI5KJnskyJqUzTeElJTQAUvZH7ENi//M85DGo2S0xryLgsgweH03xKOClL84IgP7ttqZqs5eTYi1RpH8bLM7j4mjZpV/W+3awn7Shaas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368772; c=relaxed/simple;
	bh=btgdBgFxtTzunG2/lrrBUYJ1QxP+cTltq/6I9W7+wPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTyHqsxMsWIOQDnLCDqkaDi4dw3LgrO25oAbtvKjsySrC4QHdlcffgHKI4pcqWH2uxV/nnHWca+sBi8P6P30JprDI71Zcy9PNP5RikaOprN1oAKEkXlJH2m+2s1Eo1Sjk3EZNNra5Y8OvO9jHCLIgtCAFgooyLVGT4XfUTGD4kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=SCxZTGfe; arc=fail smtp.client-ip=40.107.117.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVy7k/7VtcsoiuN//oY5XFDBc9GTzTgZ+2xdw+WAIQNXmbWv/wnmn6BrnZAOMrBo4jfuOmIopVVHK1JFIS77eLqNjMub4v84VfF3r2v2swLmBOCNqutJzjDdtJVvrS2u4mayR1GL59QvTM7iaw9Sx+xQTYWNxQBctLLYSa/UD8IPBZ638Oz81z7lMUnU/pfG4tzvgnu664QoG196KM0lKAp+ZWW8RAt7qGXwjdr4KbhpMJOfci5IrIGG6SU8UPaMLkcuEI/JBWV4lZ2iEXEHORlSOX6mBVJMuzWoAvL+G2lSKtQaIUhuzj/BcVKXtK4IIDcFumqS2zHNi58SkCFYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsZr14PNPmBXIPZ1202IghyP5Yyu1YMx3BAbXzof8TE=;
 b=po+OUmuq8S7RX43MbpvaGeyQnv0BGuVRWR4hDens4LXtcOifJVX7dZFwqjBZvZw46wTuMNPWAGfP/liLplXnL7g3bTBNqTv6980tLqJJppaYF4Rfh7KVx49hDF3sbUYI+XMRkg8C1FvNqjw1Yl5DKKftE0Ze/1BKDJSbnMyaHTbkpH+j94mxJePWKh4zKyDqSX+TUJdUGluhJPCamPi9GxZvi/BBULb1+hwJjmhKc8p1BtOKrrzyUosu6iQZs6eYUcplenKDnQZrDgYfSy0kZYOKCzV4bptbG4EIOCYYHSi0OfAKw4CYGlEUAWJtvj3qAp+Sz0EgnPytUig+kb/l7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsZr14PNPmBXIPZ1202IghyP5Yyu1YMx3BAbXzof8TE=;
 b=SCxZTGfev45rs1Atz6zuczUdk/wFq3nnH95rUdK15JBA3CopSBHVjf7nW7BrxONZ+7w/RbKlQ68wLPFv6OMVzrPoZi8rgb/njZ9riwnQG2mCNP2+psdQFFYacPNvkfGbU39Y4GBmrFOX7R1a6Qg0f/6vPCsYZlTWAdR/c1L/4V8FA9WVUJjheGshrlLn8cs+N/2mkh2NnBGCDVHNyFJMQknp4/1D8G79Mg9ggnvcLO7ZjNdL77SzjZzyEuHEgjJq4FXqo460/Yt3dEAVrs9g6KwJRbytAOKTMxGJd44OXozSu5lBQ1jHFgUUaaZeDcKus8GfeK/R4+VjpIawFfUabw==
Received: from KL1PR01CA0095.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::35) by PUZPR04MB6111.apcprd04.prod.outlook.com
 (2603:1096:301:e1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.9; Fri, 19 Jul
 2024 05:59:25 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:2:cafe::b9) by KL1PR01CA0095.outlook.office365.com
 (2603:1096:820:2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Fri, 19 Jul 2024 05:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 05:59:24
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
Subject: [PATCH v10 02/27] ARM: dts: aspeed: yosemite4: Enable adc15
Date: Fri, 19 Jul 2024 13:58:31 +0800
Message-Id: <20240719055859.4166887-3-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|PUZPR04MB6111:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 16f9342b-9bec-4488-2648-08dca7b7f121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+02sX+KGu3BxceuiKJ0bwlxIDxMZvDWqs0KE6zRN5F81wRphqIMM8oPOod+2?=
 =?us-ascii?Q?jmYj3saKsWpSH/xac8ZPHAyoASfxsH8yoVqG43dZV8HSfraAYy+BTXkp7Iu/?=
 =?us-ascii?Q?qiz+wb8+71QuT0WjbjM3Brmm/vuH5wqzjnwjLQi7ArDLP8pYfzY08YsiRhr/?=
 =?us-ascii?Q?CcVV0lYcdo8EEcpmTHuoe1YrKl5tGHmAUUrKUQqbINX8/cyTGfXxPylJE4jZ?=
 =?us-ascii?Q?CJDOuOru4eTpw3FTtaC4H4JVxtZIY3oeUf7mC3at6K2WO8G3LsTMAGxGTqbq?=
 =?us-ascii?Q?OL2V6TkY5Jl/+pyuP/y4rLzwYheQzLICYG/2uWqBaZ39Xkt7hYdtx0agVJr4?=
 =?us-ascii?Q?UMfSPd5M8akMwyC7Gf9HSpo6aMeCgGwhLUxIWcKu+ocsch0q/ggDhhOmTXFW?=
 =?us-ascii?Q?ogmIXeOXsvpxBmrzKUFnzoJEAUtg4f05USMyEcmwIrWbFyyjmQHswJi0GVAe?=
 =?us-ascii?Q?qD49s5tYffZil8IpaKly/IWbLx/UeJii0e4IgNzCshYKYxWPOp2LaD10otWB?=
 =?us-ascii?Q?bkj9LJ1QOttEqXAmRNnSEUoueFr9kplC++wDg+6kwMvcNYmujTNVECBKq/ES?=
 =?us-ascii?Q?mxrEJPd8/JpVMDrlh/jjwcbqjHIWQ7Aypx+gxxH8oUgIGHEeqQdKTKG5FV8u?=
 =?us-ascii?Q?tVBeZrxENP4mg6fhMxsMwLHqwQU0jurmAThpGE5oASTls/XCspRrVBH2IU4O?=
 =?us-ascii?Q?BFi9bimBZ0zyKZbStynzzEQ7RA46YLO287z4hCOnm10EXasTPKB6MCviPBk8?=
 =?us-ascii?Q?gjNFSGSsj/ZBhnDfrJ/NREr53Ng1v9CwuVs1IhF1KJf92zKhLVkqjVtrM15C?=
 =?us-ascii?Q?yKRtBVztSYpxlW/3iiBiZZ9B9Y+7eLE2p5ZM0/O9nblEta9567RlWPIaGd54?=
 =?us-ascii?Q?ZW5mHvykyyuS2/5cDaC26cAIbfga5ev1Uot5zWVi+rLt1cgaDcDrYvY//Tkv?=
 =?us-ascii?Q?HBhvnyPhXmd5PDcZ6buMhrVTNi+dJgToTpv7dO+Dsj6xNrQxNdP9Mtal7Y7Y?=
 =?us-ascii?Q?stMgjIYwWMn2CWQC+B4ty9vdE2hQBvTklVHzARe8GnRf8XkjsKmP2rLBxwU5?=
 =?us-ascii?Q?/heXh0ZrZtIWCurDU0vuQTz0WXtNuJXDD9uOErQeyv0B8WAaW8aEv9/EK4za?=
 =?us-ascii?Q?6LR4Nak8tdBTjBacOIgWYEfSuWh2MLUMVFpPSBQhOcQZYPOvPS39DyzAJWse?=
 =?us-ascii?Q?6XPH86UwOMB2dQ6m1y0LTKrRLt1OEfGKDtx0lAZLZkdNAi9WPp02JRi6N/Ef?=
 =?us-ascii?Q?J3eY0dYctOK94W2Oc2nlNcbOw5aJEGoHbfBZaueoo7taRnhTY4GGnnLm34sX?=
 =?us-ascii?Q?EShpLLgNjb+AbtOUp0H8Kk9+SoJNd/Q1X3oVbrK177K1nVxOsR5fwZ4SXpsr?=
 =?us-ascii?Q?gtLSzwMyWlx7NKMvVY4LiBXJvkuoEyYqGSTomrFxZqjOborDcCcuCKor0Rya?=
 =?us-ascii?Q?wcUvBfTStXk=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(34020700016)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 05:59:24.3759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f9342b-9bec-4488-2648-08dca7b7f121
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6111

Enable Yosemite 4 adc15 config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 66855efa0b4b..dd88be47d1c8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -51,7 +51,7 @@ iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				<&adc1 0>, <&adc1 1>;
+				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
 };
 
@@ -925,10 +925,10 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 
 &adc1 {
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>
+			&pinctrl_adc15_default>;
 };
 
-
 &ehci0 {
 	status = "okay";
 };
-- 
2.25.1


