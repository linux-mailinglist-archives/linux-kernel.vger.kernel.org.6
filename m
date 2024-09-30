Return-Path: <linux-kernel+bounces-343444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFFC989B01
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27895281F44
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF671169397;
	Mon, 30 Sep 2024 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="VwT1qHNR"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B315D5D9;
	Mon, 30 Sep 2024 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679927; cv=fail; b=o6tq1tjlpXSlVB0JA6qvF06mG1Xq5Ha1T/y0xpHpvk4DA2Xox3LxgNGmpEk2FoLMHRU04SVSLwwUlEGju/sXCwPWZd70ofHMsD4olJGl6Sclw8ETmarfPmoifwl0FHqiEEcLupZqEq8vPhbPiXcpyXJbcGHjOqPL4n2TopZYxkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679927; c=relaxed/simple;
	bh=2cen8jp2JKsEbbJBrwgzNvI7/Y4v3IZhYAFsB4nevjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0CWe8B6Xut6Ty4loTe9lkTkFxzYpnm5+WQe9TIKpFeTgvSKvMCk7aNtised3iIzlYNkpzrh9fKECmbDDJTUzOo8ZmP1zdjC2VG0w5RnLXc3UBscOhdVqerMff0DO1DQQbJYK/EgnWaw2qFAgQcU1CaLQtVxWiNU45brIT7lcuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=VwT1qHNR; arc=fail smtp.client-ip=40.107.215.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMpmzuVbJoMBjdCZtuxUu2VK0/NWAHQlYULfrMJh1kkKw+xdNRPmMNjHZJm0MFzieOE2lJowKeT4aybgYSuwvlMRSqx+Zcz0TwftPMb0APrsynZshf3y4gfMthALRYfrtv0EI0lOlmUJk1M5QPr3wxwPjVj6t1BkEUe6u6SpPUemDyFa3gVoypx28mBZpatHmT4RhYpPMjpYPkO6JipmPE67TI7EHkSB9X+voVKibhXR0rVYOuquCHLr27sQznt4CxDyF6aSrWslvK6y1zjJMTAuzPHXDVRaw/nUQdrrw58L22gvHNZQOZJAvX3hsdB0ghIXPz3d3gjn0puWIGuOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOYVVAIxLjGzudrvHzxQ+/GQr9w+AadDtRwQ4kO0X9I=;
 b=D8mPPg0AybelPxmXCkQPWGhdlS32Y5ncmi1k+ZxE6SU1yg4yKNlw3peM1dGCIpZ7xsWXfZCqBLcHE9OeY6kLkYAt18f1tJkHJHxj7XF3QQeNQ/AjDalRzIja5y/z/JwNJjbnKnkigKtiZ1ToD3+yCpSHsnA06AgJl7QSF0++QqwQHdGougnH+jOXqb1shWS5dki3OU6ZtXmwvt5EyrOXvkPeoKhoh8OVGcLyyuu5hAxX8WVbMDKPeu49Yvn+V147GYAU5w1TEq9VsjkOFT+no9rhxrcVBBCbx96VwrmteZZX3pmEl6G5It6iJRzuBDMIcA3y04ur4ezuLWT5PnlAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOYVVAIxLjGzudrvHzxQ+/GQr9w+AadDtRwQ4kO0X9I=;
 b=VwT1qHNR4wd8cpqIres0Eo49qEuNA7IbKDMDtZJTWku7MBl6mDIpczYJg+xHWCH7U7hQ5dwKS327CTeYGux3mwP774xZ5GkqIV3CvlLoSOcD/gK+xCdA2JnofLdNwo+AMGFB0UUL+NswJI1r/wbbOLKCTGkBfbNN0ZQGiVYH+WG3cvedYrvIuRd/pbtJGFmN3NBOwpOM5xu06kBEq1l3MebgOzlwHpaThcsBoHqATk0B2drVIe40jLXCi9QmfRB2fftw17hRdcScLt08WexSiz8U513PS/CfcURXZm/clC/8Xin1L8VYuBCYL5N0Wv6e5yePC/+kVTiNu8TXDgh+IQ==
Received: from SI1PR02CA0048.apcprd02.prod.outlook.com (2603:1096:4:1f5::11)
 by JH0PR04MB7564.apcprd04.prod.outlook.com (2603:1096:990:61::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 07:05:21 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::58) by SI1PR02CA0048.outlook.office365.com
 (2603:1096:4:1f5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Mon, 30 Sep 2024 07:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server id 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024
 07:05:20 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/8] ARM: dts: aspeed: yosemite4: correct the compatible string for max31790
Date: Mon, 30 Sep 2024 15:04:56 +0800
Message-Id: <20240930070500.3174431-6-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|JH0PR04MB7564:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 929eabdb-9716-4f07-b2e7-08dce11e3fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wIb0/uNCT5LMnR+sVqoMe5dzCZ81TYCYYugLaIMji6nNptLEMdG3Kcs7keY4?=
 =?us-ascii?Q?yxVkyuhuGNC6FQbmzfMTL5hLuO0KriDZh3of2CnAYhAZhsp89gCb9m8DhL9J?=
 =?us-ascii?Q?rPYSB/9O3BlvSoUeGKaXXqaeQX2IGHqhdz8L3x4bVfSoY3WR+wopx+2qAkAq?=
 =?us-ascii?Q?pNYP2p5as8UcbewMQnzj1W3HPhcD3OQkjfqu+IAVRrthmMXRrvCBfBFQzEM/?=
 =?us-ascii?Q?q7MrUEaVGw/kKyRq91zjDoB19FCZbWoJh5ynW+yJi5hXSTHqe2sLO8QgZN27?=
 =?us-ascii?Q?MAhCtRIFgtAUiu1pgAyiPeVSMJm5s5n7RtPOOLpcszbCVIzsoT4NjbePqgLo?=
 =?us-ascii?Q?pUmBt2AeF48BUJQSgNC/fQfBplErqkmIg1CuuNtyJ4phQC/AF9bzcUhAMfE+?=
 =?us-ascii?Q?tqQyA6wf4b+IiRtPnd3gNzkWpDpUAtcnVqQs0D8163LI9hpSu5//mSrl3FGl?=
 =?us-ascii?Q?3ZugO9CL7rXMCHgFe0DQkRLLJQWipHo/b+n48jUlcRmCCgOGHrZYVU5hM2Us?=
 =?us-ascii?Q?glHEgdOFzzDZN1G8AmkMbIyerycS2vU3bOk5STY7v87Cv5JgFAGXpxGOHU9y?=
 =?us-ascii?Q?jPQt20cRRzKS7mXv5zTYPPWK/L6jJMK6jfDhE1M1Ie6VSL/2knneaP70FrFo?=
 =?us-ascii?Q?zOOr7YXaZ0tfZnyhP8yUfID6DWBkVP3pgNEsrhSO1rhWvxRGs01Jx5nO+ne6?=
 =?us-ascii?Q?aqR9tQJL/eD2GVThTkuo1pe1Orz3H8E+2dl2AXJOWWCaeCHYYzSgfFCUYTeR?=
 =?us-ascii?Q?pUZmMuKhbl9lRNmjvgkyTRgqe7BUmJN1UDVnhMZ5tEhR4nsKSu0yNlHujCv/?=
 =?us-ascii?Q?LAC3Krm5dEVx5Ypp5aBnMZotvUcB/tuCi5m6EFzNK9ieisddwjWJCN+70Usg?=
 =?us-ascii?Q?yKIWUC82vTihRjfQKD/ImAx1lKiTiuvGzu3ym4CMVaqD2FnwzocR3E/G8hNp?=
 =?us-ascii?Q?y+8mDmlP4SLlubl8z6RhYisTPnHgpoAwEH/ygbjRfx+is60v2jakc7Dxh7tS?=
 =?us-ascii?Q?45xijxC153UjiRTGOV4oQkMlzKQ95U+c0DkRxAsapUAiYfTuh2j+nJIc0tDc?=
 =?us-ascii?Q?K3sUNcElCRhsaldYNGI0QljFpTFGkdpiVANKcZI4rbiTwFdcQjoaRjefh3SA?=
 =?us-ascii?Q?2GIlFvP3KZp41v0LS0KiI1QPusUB4ItzNRpGfpWM18ZlsTianfVGQIDAW29a?=
 =?us-ascii?Q?oAqnACiUwjgehQWEPKo9Dt1JWTSMYTFVPPL2sDKguUfU7uFpeGCW/Le2dd2R?=
 =?us-ascii?Q?KBCXuw2oJyAPCTmFmHWvA28F/ADBR4Nm0Vr4+s68MII0QfVcEK+gJgjB9KCO?=
 =?us-ascii?Q?LXH4/U7rWLG1eTUQftIw9BeFN5HXFrx96JAzqW5ijZ9oXMA/WsHr3uDaJm+R?=
 =?us-ascii?Q?Okhg/hnAAEYRrqJWJl86yjB7xbRZcgy1d8NjZqdRzGqDjhInoCTOInFB60Kv?=
 =?us-ascii?Q?CdFi+WZZzLFIWS2whZ0haVt3XyGCe+pG?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 07:05:20.6655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 929eabdb-9716-4f07-b2e7-08dce11e3fb4
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7564

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Fix the compatible string for max31790 to match the binding document.

Fixes: 2b8d94f4b4a4 ("ARM: dts: aspeed: yosemite4: add Facebook Yosemite 4 BMC")
Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ecf012c9cbbc..01ee455c41b0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1177,10 +1177,8 @@ adc@1f {
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
@@ -1191,10 +1189,8 @@ gpio@22{
 			};
 
 			pwm@23{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			adc@33 {
@@ -1229,10 +1225,8 @@ adc@1f {
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
@@ -1243,10 +1237,8 @@ gpio@22{
 			};
 
 			pwm@23{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			adc@33 {
-- 
2.25.1


