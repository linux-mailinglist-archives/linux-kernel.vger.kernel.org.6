Return-Path: <linux-kernel+bounces-187234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE878CCEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC541C20C40
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4013D619;
	Thu, 23 May 2024 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="bX4Pl8nr"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2083.outbound.protection.outlook.com [40.107.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500D13D2B9;
	Thu, 23 May 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455908; cv=fail; b=lFdGPRj7qR15EwWRITSrHqKRn9STJVT/flG7FCIEyzwHQ0xFW1B8KD9OPScn9PKEEblpUX04aiSnAzfL/lRymqh0YQpbz/7rAstNvmsCfS0o9BhBJ7QmoJtaJHsybCg4k36YAZ/i3EBvU2JxNdZ7D/9UHEE1/SOSMFW7LOAP600=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455908; c=relaxed/simple;
	bh=btgdBgFxtTzunG2/lrrBUYJ1QxP+cTltq/6I9W7+wPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cg7PowVIsm9tF/UqLwXxevWhD1HQRduvTmAdnWQ52vjIt+1g2pxoqI3SdPaCRk0KgNk7xPQKR+5/j3iWFS7GJhy4M8Bx8yBnJKBfty/dChUjxVgCiSPt7+v+HiLErgXxTnrAgn3JmiobHcRgUNdUQlsWFKEvC3+RShGhJt2gnnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=bX4Pl8nr; arc=fail smtp.client-ip=40.107.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjVuOKPGrh7s6VZgmN29IxLtt+E1NSQZ+90FCO78gkrcB3oc5NQuvGMZ/XJJaxXdzNDvvO9uJH8nERH3lqIhb6LaHlRvJ/u/jnbKAigAFxN/3AghLxoebOZ1TLM0vB39svgrtMpqgiSsKHfoa7fxYQZiyfhRht980574KubE5DUJnlN263jovwPUnIKZxjW6urzXqWbSoVUxmhWQLXWKMRT5AKEwODfcLjoRhqWyKvRFkm/w1cJ3EBixuoJwMJ8kXZQ/We62cEp8j0OB+R+Q8c/bd+IJVqfLb+X0gCtD0Hviis7UghkZkAkd19v9UUhO3ofwHAx5vV5fYIVFoSOSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsZr14PNPmBXIPZ1202IghyP5Yyu1YMx3BAbXzof8TE=;
 b=aArcK89M6InGEJrAw+DPPZJDp5YUAXl6rCwd0ub10g630T/dLPVqTTDvUpFssklnPsrrYKcBvnaF0rFbzP7H+TvCngcHq/uLVbClfKHcON8dxrgr9SeCf+XrM7XJDy6qmAp5a7OKrc6m/deOvHBSq2Jpx5abOKMBq7w11ez2DSqoC5ngPeGhb2zNQ8LgFzga1odQJdz6U2uMA1A7NJl6kCUUXDajE+yeu4UECUeheH3I8WyYr7BqxuM1d8KDPRQERKZD4jd7564ug1wcyT7rHqTXppoN/R501S6cSVhVgkiGqv9Yz4+SSuUYtUOK6yvza1mJKcpcKPCKxW+9TZteMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsZr14PNPmBXIPZ1202IghyP5Yyu1YMx3BAbXzof8TE=;
 b=bX4Pl8nrdVy4X4hTv4w0cpLyV9USb/eh8RFQRuH/fmDo95+4KH32cj859QFfSi8c+KgrjXjRo1+ukCNYMjayN0ujN3YPwoL7477Gv/oCOJWA4CcxZVh2zyj/u1il8qaFZWXPEFtuSDVxewr+ogScN8McbdILor16ZKrjJ2yegQlckhWn6xe+YYpp+i6JqX5jIuBxo/GrwGWUO20YToqtm8x/iirWIGgx3zzsdeI8QVy+kuATXzyDUJH5DKAbX6hwFvzh5sscfDCkR9NcZOv5XntdTzyrPPMkR34R+Qji0uta2YzUKJGOUAqdkkRoFrVE/cPMuHfhulfoWSIZHLszsQ==
Received: from PS2PR03CA0020.apcprd03.prod.outlook.com (2603:1096:300:5b::32)
 by TYZPR04MB5680.apcprd04.prod.outlook.com (2603:1096:400:1c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 09:18:23 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::69) by PS2PR03CA0020.outlook.office365.com
 (2603:1096:300:5b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9 via Frontend
 Transport; Thu, 23 May 2024 09:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:18:22
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
Subject: [PATCH v8 02/23] ARM: dts: aspeed: yosemite4: Enable adc15
Date: Thu, 23 May 2024 17:17:49 +0800
Message-Id: <20240523091812.2032933-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TYZPR04MB5680:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 81f66b82-37e6-45d2-3ba3-08dc7b094b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|7416005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FO0MNGT9esrzLlsS0JFtJiXr1BktaC9c6QEv/fWZm+20rL2C2H78yjV6TlJE?=
 =?us-ascii?Q?/F/e32fm1/lk+JNllahq70hz+QOWvMEwBuMEJMZzROm/3SDDaDvMb1qmoZul?=
 =?us-ascii?Q?kJl6pYcxBmXWE6Bu9b/+wKGOLmv0CKd2jVeqQsoN0OPRh1uGmyU++nT0bCRe?=
 =?us-ascii?Q?X1ZHVa1SLVPPfVddjjvOw/PRm2fDADWhTyeQNQe3rfcpgJ87ozZ2egKCf/2B?=
 =?us-ascii?Q?aM5/Iv/BWqJP2vEQyzymfksCe9GdEQufTqy0CkHQo9Y4KssWc5HI1QdAEXXB?=
 =?us-ascii?Q?q/P32YNJH3J2lFt5F8OTy98BhopSlzRTl6TKzLK3nQvvAq7Bp960WqfqNKo4?=
 =?us-ascii?Q?7Kp+uIJnR8EWFQBcHT6gBg04UUfA3rR0ZOv4kBMb5pjyoNqNMdEH9co0HSGE?=
 =?us-ascii?Q?i5GDW5fIQNtlbuOx9I7tYpPMhAQD1wtzx8X919MR4Fi5aaix0PxakNKqbSS9?=
 =?us-ascii?Q?ZGbnDbBSzi3Tpwa2MGRQg0t46PuirF4xHsVCZZqI1+6oKAdBnQh3D0b/80eY?=
 =?us-ascii?Q?KNHhkYS3YxPB3vgy71NhjuTPyO4sdU8BjUelZ+2lbIFptkyeql53X7kP0rNl?=
 =?us-ascii?Q?mFLGx67Ul4RTQu76896boDOX16ZwgrRsG0WDOiiDQ19SeP7rf6tQZS53fhE1?=
 =?us-ascii?Q?87zTWK1UctRslicz6U+VnDSzya7AY0VKrAv36VjEKJPNZ8Elal2qS98RxolP?=
 =?us-ascii?Q?VWsph3nl+a/9vLlE7rPoF5uc/bmZRNemSBRH+x9xxAgBgOYBn1lU4sdKOUrk?=
 =?us-ascii?Q?SeXsC9gCy9UNGNuXJqR6AOWhfbNe0ZlEr1JZJgP3BqwGIOXtr2ni3oQHDa8c?=
 =?us-ascii?Q?m9BaTl1luWleIIYU8Sew6BV6WdTf9yQXcMV1Zcc0QjM/Ug+nO8k3Y6kZUa0Z?=
 =?us-ascii?Q?2aExpXCtJpu3HOe6XP7U+cGps9lsjzYpiwCiOeIc9NnHub1q0RONecwiGe7C?=
 =?us-ascii?Q?pWrNIQCE6hO6c5gcnrX7XUM6C+0qHONiEWpt+3hZY3uxC8UPcZ/Q+2FhqgZy?=
 =?us-ascii?Q?y4wxQ/9q9uszYnQiLLlxrGkrxMCOtuxNXdMC6DvCFHbPNhgOETigkO7kQwJC?=
 =?us-ascii?Q?yOG8r0dR7Ctfjvvb6zTeZv9xxYeJQjD1RDW8fgmhfJJNFFCpbUAjx2Hfbzao?=
 =?us-ascii?Q?decmaSRe+bGgWFxNq0Bc0FGGBP8V4uZ+zrFq8lf6EJmiB+mmM89rOmfbWekK?=
 =?us-ascii?Q?kz+4TD5d4CQEGWzrBk82hIolg8StxYusMSg3mcvoN1hekf7mw1OmldFozD2J?=
 =?us-ascii?Q?cAQU7X69ikRP8OhMUCs31JMwGn3mYUt0IKwrup+Qh7xt6yD4Sg5ph8UtLOh1?=
 =?us-ascii?Q?k5LBT7SjJALnIUToMNTnGRr4nFrUw/kgojaH2KwQuAxLz4xOivwwQw+cbo3U?=
 =?us-ascii?Q?5m5eUJs=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:18:22.8138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f66b82-37e6-45d2-3ba3-08dc7b094b77
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5680

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


