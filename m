Return-Path: <linux-kernel+bounces-259830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790CB939DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303312879A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EA6155386;
	Tue, 23 Jul 2024 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="TAHLt7cO"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2077.outbound.protection.outlook.com [40.107.215.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF23155332;
	Tue, 23 Jul 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726698; cv=fail; b=R5AVruIHKx72IauqEGhLRY6M5cXOlkEZhk5Ihtt8DlNCwkxm4vHXT3W9ueYRWLXvxzaCNXqx7QmGmy4DOplxHAkHLbnx07Y/bdwJZcLAoJNQeSQiRduUZOGG1kR6Pj0NdlUwcf8J2hSBAvjeB3YREYALXx0XydhoNqtii+01BbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726698; c=relaxed/simple;
	bh=PfdifsAGi8tVEbQhQBk/QLDU4FcIeWEIdnzHhekGd9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbIGV22lI1gLmeuy9iX4p6C3ad38/VUUtirCkptBqahizzgzrijQLSbCS0u6yL/aAdiB5/pX2pHqtl5AM5SHuT6OEowxXwm37pf8nSFdG/iB3KuN08Xe05px6T+mCpbyrNM5j95PX/40EsnH1mADWwaH+W61mgLO8IGY/jALTJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=TAHLt7cO; arc=fail smtp.client-ip=40.107.215.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5X6I50KMiWg/XhiCJ2wou83aMN58o0wJLB6p62bGwzK2hZps/QSncXfrEPob9OWRI3UInSWuqiANXEYp/OPNfeAqDkXbqn3VBMFXRbd3v9zWX/2oPmozj67Pxcgjc+i6qnvpeXz+7z069hadra7fAsPLADk9FWDJuBACYqEAGk2HQM57bI5DIgoSlhpa2u/EQihZsW6QpWUKB6sZTU9E7H2uDi4CDrQZEJDPBDcj7WS+V6RTinn0/Ng2J7qaEyj7/IfjjsNQRzTibGVAnr8xXCG0xEd8DrolBcl6dUGQ8rnXcwzzxCgWvoM11G1Ln0NPo80Y/gtfljCYFFWwO0slA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGEY6kFHCr93vzQaG19EtYDkCI9Rttn+5U+iGfkqrRQ=;
 b=KO49pS0nr/7uHC0NWBriyqHXgkIThAPChkCAPCNZB28QGiDXVKLGifEXU6/Qo50aXoDgxrqZOiKs8/H+gKXQ81zhm6sHp0n5uF3IXrBe8AEirvcZZrBHpwjQLYLLeW+5OlJONzycJt/6yDcnbqgVqyZ+WDBarkCg+3iRs6hk+Q/RUhixXFQ/j8zIujlxfWbFmeHVjTNtFNTvmYBsizwC+7sztd7OLIjQ9AK6NHywTwqsD1dbSDejh9vTd8PDA9FBvr/t4kFyiSnPxfzTNJAG4Bic+kJNXN9ejdSBBfUPvKkD+mHDBr7RL41a++2jiGZP4t2SJwfYN8proe8sEykzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGEY6kFHCr93vzQaG19EtYDkCI9Rttn+5U+iGfkqrRQ=;
 b=TAHLt7cOQt+H2IfiF5MEdKQ13KyvVYOT15lPkV+JznskpKAQEyBGCyzZUtwk/AsOkS8osqCForL3DDK6oZ1rAJzKz9aFr6OOfFhf3ob+8WOqBemztwJ5GEyZ4CrkheX6KBEVehqFZtiOunl41fxi+iVOAiO64WeF6QaGsh6WPnH/UuGJeKL+gt9sBbMVwis78sUMfeya9ok+92Q5o/uIej1wb+TqxKhvmFv9/1UsJb6T1oBtHjSaYFuXavFnJtsbesprfiVJcyQRgP9xHAWCbXJcvNaC9U9rI54haHZNqYwOa/PrAsi6MlsFczaLbn2ZOA7cEhjjt/tFMct/5ARqww==
Received: from PS1PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::17) by TYZPR04MB7074.apcprd04.prod.outlook.com
 (2603:1096:400:454::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.8; Tue, 23 Jul
 2024 09:24:53 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::78) by PS1PR01CA0005.outlook.office365.com
 (2603:1096:300:75::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 09:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:24:52
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
Subject: [PATCH v11 26/27] ARM: dts: aspeed: yosemite4: add MP5990 support
Date: Tue, 23 Jul 2024 17:23:07 +0800
Message-Id: <20240723092310.3565410-27-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYZPR04MB7074:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a5f52e07-007b-4afd-90fc-08dcaaf94ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g24y5DfY0xiuIxhclAslfC2yJfinSmsrN3w1UY18ThcIXYZ7DVS0FQu/btjZ?=
 =?us-ascii?Q?qLTDA/46K6yRIIC3hPxgPDJRsujQlJII3eIB3PlI3sAAizpU7CqjpoIf3B2C?=
 =?us-ascii?Q?Sl+1MXqGOxt9VbPAaGb9fi+SQ+ukyDb4vTDcmW4rr96lSAbX44l2H1GQrEaA?=
 =?us-ascii?Q?+hOTbsHK1TkYwakC/pUp8yC5AXLvOTDDyh1Fp24hEQUYvbwNdmURj1p1cS1T?=
 =?us-ascii?Q?PBdv3WsEGtWFuQ6FU4p/Db6hvzttZ7y5ob7C2TQUa5exibEMeTO//igoRtoz?=
 =?us-ascii?Q?ZC+Lm1cOp0CdzITBEh6962dsYsfysyUG1d9KhpUTX0KwLBKTs+cPo87kznWb?=
 =?us-ascii?Q?0ZnkLeE5SQvTxvKyfIIlKbABCXlUxjgYscKXFECFvdvMewhgUSFfkOqCSBCS?=
 =?us-ascii?Q?f7GiC79YODDVo5dcpgAxRU7GpZTjQjR4sUSjVUhe4zHOt2h0gVSmWAinRjPG?=
 =?us-ascii?Q?RtXBhVpKGk6eAZllPNmQeeUTiFR6FLV+z/9kRPi5fefqQkzJtl7stFHdg6Pt?=
 =?us-ascii?Q?hfwpthWHO1RzaUduG5MlqxQhckF/8JsK0xokH4tXAIcGOT6DQmCmC51TwnXW?=
 =?us-ascii?Q?grKvK6HY0JCVfF3pMfp/9Ns2e1yyUPXhAYLNadDfWwCicALYvRrUvVTUv34N?=
 =?us-ascii?Q?/qO+TktXgVDx9nf49sJPvFCDDfWo5CukEM18cuagPS9d1/So/N2jUM+vjVlg?=
 =?us-ascii?Q?+ACRSeQUalf6xMQaFpiRtAGhqm/pqF3XtHBHUKaruYdD84Q37aSyej3v59rh?=
 =?us-ascii?Q?zXSTeFdRwHEGgb3StXdlNHyJqsRpby7AIRAQ1/6H2gBtXp2fwhDCOVTS5r5i?=
 =?us-ascii?Q?DM5kM04+OvemvHRY7fE6t9VB5wrljr/9VlaOBSu9XrF4ApXI44Kux52jPCXU?=
 =?us-ascii?Q?vv6OdwQ8kHSWNvo4f02l4aZ66ogVAUrxCdfR4qJWq5mtChwetjXsNmGKgK5O?=
 =?us-ascii?Q?YYbWr9hkYL8Nv3vWRIJVsLD3yHZy3ZNawfFXXgAEM+Lj6wHvugG76eZ0hH8Q?=
 =?us-ascii?Q?cl/l78TUosppdCZ1zngFP5ZG5OrXXDTgY5sSr2zICg+Crm4ohd1XiLUP47Aq?=
 =?us-ascii?Q?2DhkVOmfA+9tKlhpfHlvK5l9qF9vPwIA1NRHlYNgaY17B6g/PmVBHRPjEf4v?=
 =?us-ascii?Q?VL/RJGgdQ4v9sag5RJukV39+u84ZAvxcqbfzpJ1JunY0CSigb9f9QuusPdHg?=
 =?us-ascii?Q?M+jVo2eqOW6aSqDYG1BPL3Ns99IkWcArX9geio5x2Wdgu91RqejojtR/N9zB?=
 =?us-ascii?Q?zyLg/T3RSit0PBP0xaSqT9bqUCQsyP1F1vB1UshjmgJ9gAlVipQABomh+Wew?=
 =?us-ascii?Q?saIVYlZekDfKGRQLHBHyOZc+OARw0dYc1BpwuqsjbQO+PfiOhzeKSdTA45oK?=
 =?us-ascii?Q?RAN6SCKnVxuFFuhXp2uWvj7+9h//0/GjnCDQ4vDTZ9sTRGaV7dbL+N78CVdd?=
 =?us-ascii?Q?2b1T+9Nkzas2GkH4DcAwZSHMnHUP14cR?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:24:52.6137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f52e07-007b-4afd-90fc-08dcaaf94ef9
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7074

Add MP5990 in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 03a1e41312e3..f139f426099e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -356,7 +356,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -402,7 +402,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -448,7 +448,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -494,7 +494,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -540,7 +540,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -586,7 +586,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -632,7 +632,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
@@ -678,7 +678,7 @@ gpio@24 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1281";
+		compatible = "adi,adm1281", "mps,mp5990";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <500>;
 	};
-- 
2.25.1


