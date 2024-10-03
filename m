Return-Path: <linux-kernel+bounces-348698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC82598EAB3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374FAB25264
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC11112EBDB;
	Thu,  3 Oct 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="iaGkzbMz"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2049.outbound.protection.outlook.com [40.107.255.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A341B139CE9;
	Thu,  3 Oct 2024 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941408; cv=fail; b=aUp72WgfLDWEHKZprYfIhZz5OJ3PLqi/82+qtOMeO5VbRYVWnIvGCBRqKwTg82DZpb4S9i3MDWS6L+TOPX5nFyR+f2KYipNybTXUgZ2pxEZL6phxsnJKMr5n3LRdp7dm2YK9jIGgDU/1tve/QpUV/nYrmyI3utAy8Gh55Ihj4Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941408; c=relaxed/simple;
	bh=QESVgBwHWzMr1DJwcWFSl4a/+hzXgYgDRHCG2o+Cxjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdYBad7UwbuUm8woC4790p1P7BlHOyviDQBoxoBvL8/3qMWFVT4w2SnTykoql+HwHJUnj0+3JzJv1WdJXBxdIGKIt87MWrqYAms9ISlb7juTVHGuC0Sc2UOHKvVXUhfVZCgkX4Ge8snkHV2CTewWzBoab5OTEGO8q3QF9mpB0wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=iaGkzbMz; arc=fail smtp.client-ip=40.107.255.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKlZeNrKhifSxne3BIsViC+io7+ufREj6T1qQMLpjiOLQl4eFKNy652ElbF3ZU1+CAOwAP0qORQkkThlSXwCNclB9IqoRilMXofgWuhSEMQEic9TJ9uJ60IltVMGP6krOJmQ0Nhgx7Xx0ckxUQTCBK5KWg9LSqt4Orw2/ovIVIcK/GK1Ljsq7jORr6QOHWq4eR9KMQMl7JPe+lJtIZqUGicDOMCqy026JzBLf8gIRfnN0ujBA9TjZzRDOwuBQuUh5mRZiD8kqtWyF94LbnXzjONQTge7gKv4y0fBtcIgMQ4RPFLAuoH1E1XPPXEGVAg74axPcO9En50d1EHEOnr45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8EXqVr6Gzq+ihzDYW3k94hfHuot/FrKhwqin4FkW+g=;
 b=nuxZ2R7QwI+mk7TNuK/q5Zg354LHfhuv8+lTEpx8WcSBF8DAEv1Tq3+dXXa7dkoT9YQpcBerA5OzPyj1asekUCOyER/dFvbld1hPK7rMfsYxLQGnYzSicEqgLDhlxiigxDCtmbuJWp/aKLExy2il1RXmeOPe8ikXFEHUvyR4Fk/Fd6tUxzfy0dohvzitOfSK88TP0z46oAqQwsnqKMuwWniy+57K9Rw8JgXF6/pu1xdmCkUogNQKKDimkZPxaLxKDuNkEAZTTNHs8h+W6t+LRyvirtdMYHwuAW0Sh9s8p41cB4DA/WcP2R6FRc+lfx7+LwpP14YtF1akdnVTSvfH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8EXqVr6Gzq+ihzDYW3k94hfHuot/FrKhwqin4FkW+g=;
 b=iaGkzbMzywjUelh/cSPfDtdFIpbQN6Q5nBTH/PR66s7lFcqg05ooYiuDECzlFYuF6JgKl0Ej2fpB69/izCUmlfmVSjoPXGHav+CmfM++zdfY4sCa3W3KVXy/sFiTwpi2ko+Hcu1L/1ZqXge/ujLYpG7fgrZFoOQ9LulpE2pts7QEJxPy+NrT+RLyRBeBX5pXYD5djyERvZy5v6NAL3XJqL/evMlf+qG1DPzvy8S4AjRcQCI42kfoIkm1E5hXJdtRQeyOLRAe51/r5hYZyPg6vA52QO0GG48wFnrJucmEtWB0joktXhfY7Iknvlham/laSbztyhoY+jVd1cY2J3FxuA==
Received: from SI2PR02CA0012.apcprd02.prod.outlook.com (2603:1096:4:194::7) by
 JH0PR04MB8155.apcprd04.prod.outlook.com (2603:1096:990:a9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Thu, 3 Oct 2024 07:43:17 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::cf) by SI2PR02CA0012.outlook.office365.com
 (2603:1096:4:194::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Thu, 3 Oct 2024 07:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Thu, 3 Oct 2024 07:43:16
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
Subject: [PATCH v3 9/9] ARM: dts: aspeed: yosemite4: Add i2c-mux for ADC monitor on Spider Board
Date: Thu,  3 Oct 2024 15:42:50 +0800
Message-Id: <20241003074251.3818101-10-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|JH0PR04MB8155:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fd6e5f69-fe71-4236-670a-08dce37f0b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?poy4lyke/PXCRrvCcOlH0wOSqjJoXbUnXOCNM8VMixg4VNrrZW2QN+dTP97D?=
 =?us-ascii?Q?XdTt8ZO4/doKKPJu7RYpxxiiuxRasEHjmV+bvFNPXuJPO9Dp+bpGmq7Y8kAT?=
 =?us-ascii?Q?p8UaHUmw5/66UgLRjVdLS+HubFdXdZ5/Poj734GuStyIbEZ9Zulf15DpOZ0N?=
 =?us-ascii?Q?x8qEQ256noGda0dpfhsjqpsBKYxkNSLwbN6cfTrPQnn1IKTxYNsqEWmrixPo?=
 =?us-ascii?Q?YbsPTMUvaSJ3EuzbQZQ27MChAsML+ah/JGLpRFKdTDoc3Nvt40ydmtVtKwNf?=
 =?us-ascii?Q?HrPLBeas/k/ZJwVpCrS8DciRiRE3sa7s6uPqEhKL815wzIv5niPwSIj2vuaf?=
 =?us-ascii?Q?9BRNcSHVoRV7w+hHlBaA2KqB3IuSdnTSHwsw/j/5dvtCYyg58kCEx0XEX2vY?=
 =?us-ascii?Q?ZpWxR0sY1vYV5dSqm4kOBWhI/Sh4TKMD9kcGpCcASQGqDzXYEjD+4N9Dk2as?=
 =?us-ascii?Q?34GmhgrDOocB2goWrYCpy5xUwi86U6BIRDISK3N7PlKPmj03OXUUX2/z0QQL?=
 =?us-ascii?Q?S9An21jAMcOJrIjACbU/CNuNo6XpG/FQnrhA7wyvY4MDIdsd8pU2PYslIgjg?=
 =?us-ascii?Q?jEuBnI4JtQVM63zHs4u0fpP+bG2EorTsvEvWln8BBOX18XRGeQUOYVjtvKAp?=
 =?us-ascii?Q?0PDdDEbFDdZSG1aplS1qwQHe/SgCyKjzIYWJeslbchEWdy6ppWnqWY3y4AwQ?=
 =?us-ascii?Q?fXFbsbxKJnEwgjcsgRPmA8p1R0MTWxHXg7qZ6BfiOyzmWQA39kH66OO1UbUG?=
 =?us-ascii?Q?L01AJjw+Ds1ugbyNUv+08Qv/TjVSzhNq10fgdjdvd7j+QqcubIVZjR4HJsww?=
 =?us-ascii?Q?+9a/6/edDFl+3zrD9DtbAE7+Jm9G1O3BllbLbJ7ilaA79K0TFNMeJZFpl7zJ?=
 =?us-ascii?Q?cus9mneTffgmFL213tWIPqh9JYI+jbuxV+ayrv6UESIVpgUx+f/L59A+5zn7?=
 =?us-ascii?Q?Jh0GnZMoGEqBsCidF/tcLXd/FoyVdhh5uuo3SNy9ZHQI5mUI2SbMLEp7ypXb?=
 =?us-ascii?Q?vnGe+Hr8Q4lumRD35sfE9fM3KWi5NkPKi1uldCUACT+whrMtC5u8Ekslny6E?=
 =?us-ascii?Q?x8PSY8av6kneq6Qh3EEGAJ2O3lVAN++fcciq1BAKLCskiWOegU0VGcjQ4lKE?=
 =?us-ascii?Q?VEbMHAMIAjRcsInrSJ/HqC1LXZjaHr7oT8NQbsPKs2s7u1yxW55kl7m67CWh?=
 =?us-ascii?Q?ojz4mlLid/VPLvfKAqC8YTrOM0lr9O74D59vpjMfSxMMhETVKTWcuEZ5eN2L?=
 =?us-ascii?Q?c4/yrOlLCCPknKfo2esva0TKnbxKEDaqxQR0//oyiJHuc+xwD/wqaySk2ZOn?=
 =?us-ascii?Q?9WbIjMZVskmIwBf9tA3u0VkV8jVTKXGgj4CBRwaiGUdBdVsVJPgZWNRA3aTU?=
 =?us-ascii?Q?jxFR1mo=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 07:43:16.1026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6e5f69-fe71-4236-670a-08dce37f0b63
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8155

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add I2C mux for ADC monitors on Spider Board.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index bc25c11df255..ab4904cf2c0e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -34,6 +34,8 @@ aliases {
 		i2c29 = &imux29;
 		i2c30 = &imux30;
 		i2c31 = &imux31;
+		i2c32 = &imux32;
+		i2c33 = &imux33;
 		i2c34 = &imux34;
 		i2c35 = &imux35;
 	};
@@ -1100,29 +1102,25 @@ eeprom@51 {
 
 	i2c-mux@73 {
 		compatible = "nxp,pca9544";
+		reg = <0x73>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-
-		idle-state = <0>;
 		i2c-mux-idle-disconnect;
-		reg = <0x73>;
 
-		i2c@0 {
+		imux32: i2c@0 {
+			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
-
 			adc@35 {
 				compatible = "maxim,max11617";
 				reg = <0x35>;
 			};
 		};
 
-		i2c@1 {
+		imux33: i2c@1 {
+			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
-
 			adc@35 {
 				compatible = "maxim,max11617";
 				reg = <0x35>;
-- 
2.25.1


