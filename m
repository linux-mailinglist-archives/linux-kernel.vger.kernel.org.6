Return-Path: <linux-kernel+bounces-256988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53D29373A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282D81F22B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CA584A5B;
	Fri, 19 Jul 2024 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="mgQqZu7z"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AAC54FAD;
	Fri, 19 Jul 2024 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368819; cv=fail; b=Uvks+XX73x/wSj2CCSHdvHkUTZ+EdcYoim/cYXadZQ5k+6TTAKz2NfzFwfmLzkyQvwzy0dgDh+mVT5REA0OObgp2VwIFMLJC9DgAq04nGCUy1d1wN5C8NfxIaiu+4v/VyU9+zmBvJo74XNf2lMvcuaJRznLzoc2JpufYkffDkqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368819; c=relaxed/simple;
	bh=gOTtY0AKzJ5lAs89ZBm4Azt5lpi8hiQG+0fSEaBa1jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2k47wEhq92slKuLDM6/znq94cPmwtxywPYZrvBB/6AnQwOY3gyVHAaLtVBtjRkMCpOqMaOujQJC+xuxKrS/7aTnF61OH69fwX0qLl3Qnku59QuKBjw9efuqgmjvpzJjpXPBp4s8OFl2oZ77gI9Z9aGI8Bwn1aOo/2f++7pWCWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=mgQqZu7z; arc=fail smtp.client-ip=40.107.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwQ/6703ljGkDC+yCS2NRg5gVUFUr9ZK1nPU62wZdYG1BWcJ2L43hN4Yh8HpumjKQvj7eDGmIGDZR+ikNdh2+kkexxh1Kv+zGXKXdgkpminJGO1eMIbXi9D4pVY/5SuFLjYYO4A+BVSRFU3wNPxbHnFxdhhsJeDbmC7QQlWjGpQ8v5wu4BrG5ZrBaBS8yZeGzR39+hlqDHyj01nbtxJVdPR9SVfoVuf7kFXVPRvdpo1hcu80ZFVDSed0ksaFO/YDsk/tnOrXRwoSLzv/k/b/75kHOJFIM92Xi7NdAMHOHoDgwFf+c7DGdszN4Se6l4YZX+66V29eMz1jiX4XYZbuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vQQ3x+PmWObjM/+/9aZu+RrnQuFpeCkTBq+qesncHc=;
 b=Idlgjl3P/Gnl3Faz8Lx/yFY6jYVik9CYNVrqhi5bFAAye+PWyuGiEJI4x9qwtUCxhm4s9osrnFR/+zumq5VKDyaLcVd77alA5w+XIwHgNGfzC3uvTn8MYDypoiv+Dt6siZQzgDupHy0EFT8J3uvAXRiMZy3+2jWWDJlzVtuTqlJ7P5KJMR7gVVTIWczBTqj40g6GLc4MRDLpDCf/hnsxcV3EhK1us4N6GC74KqqQWsoHato4ipHF8P8OjYKj6s4buMeJYC1ROofhFLK6db5Zxnj4FEaB3rt2h0If8xMtg+CWtrVSofCBw3Sq2FMrx05aCsEKqQLn0yL7PHCvjx6aTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vQQ3x+PmWObjM/+/9aZu+RrnQuFpeCkTBq+qesncHc=;
 b=mgQqZu7z9pZ0+TAK/YIJG7TUOIfBYEXkFYEY51ZxMKBm4EqLsINxlbGYca20SoROe8jCDSmizcWhXpW5n/r5ajpBHlxk8cAlUGPuefsBbZBQ+aqgKvBbcQbaIjcs6uqcNFC0Gb5v14AdHsK2l3yMhyqDI3qoESmIdgQW98EhjkJssk5Wyo1c05ri7PBekvNUH+orwrMkjcpAJI1bE+DKn9onGTxyu3QqWRcNVPFNX5Fzhr9ECBmu7X2ATt3Iii/5tg/48U6PqISi0fCkyru6aYUnmVjaJSQV+KNCAdAhs1mY6xCqkRgHNTeZfuGkfEc5EFgo4Rz0A91Zmo8sQXP+xg==
Received: from KL1PR0401CA0031.apcprd04.prod.outlook.com (2603:1096:820:e::18)
 by SEYPR04MB6601.apcprd04.prod.outlook.com (2603:1096:101:c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.17; Fri, 19 Jul
 2024 06:00:09 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::fb) by KL1PR0401CA0031.outlook.office365.com
 (2603:1096:820:e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:08
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
Subject: [PATCH v10 13/27] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode for yosemite4 schematic change
Date: Fri, 19 Jul 2024 13:58:42 +0800
Message-Id: <20240719055859.4166887-14-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEYPR04MB6601:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 09e46106-728f-4577-8acc-08dca7b80b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|34020700016|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6iBdWs4r1fvpj+RiDMhRvMmLqgO4+buxzTaCTT41kyJG8RTHc8DHtU54ftZW?=
 =?us-ascii?Q?/0GqIRcK+fVXW9qLH7WhWS8MnH1EltX7985RicROsDIqMWAc+USCF9HwHq1A?=
 =?us-ascii?Q?GmAr1ALCvVuNd3zX/up8ut79FhFpgQH4GZpahU1GLlv0kkKHl91qO0hE6AXL?=
 =?us-ascii?Q?P/27jXoM6dBafNrGO2WCPhlvJJif0x4RJS4CN/kY2EOETjhBC1j+Ig1Fn1AI?=
 =?us-ascii?Q?lHk3xJHBTtUvcmpcnXnM8zZxNL2E1+slTKjR0Ej2exkOam7PNsFXgoGuSsxB?=
 =?us-ascii?Q?xvojciPtDt2X15tiHvNdjkRDXvCvY5a/cPM+8b/13L1toRKoVedIua04ARzw?=
 =?us-ascii?Q?+10ZsC46CEmt3Za6tDceuElyUyU+Ubd20mmrqOY44pRZc1jCJxyLIcOrGiyz?=
 =?us-ascii?Q?SctovQZ4j8ILOHKavo0DBzXbkMkcwvb8HHPyakqs8VWLtT6Y4ymO227mgYJ8?=
 =?us-ascii?Q?PsyHSZy8VmrK4cwJ49+APQMviuOnKlA++9IQET4vruPG3VhX5vvuEsXP6SUi?=
 =?us-ascii?Q?luFKw6iDgSTivX84C5R1+qxtIswQTHyk3Sf5QBVPuPw6tqD3+TaGSTOVuJi8?=
 =?us-ascii?Q?CO1g9ZyvEY2RoaCdh1kbhr8AqwbdfsSEYIyJf5w3A8+HDLs0LIUvLaNzyyBs?=
 =?us-ascii?Q?G7ieSZdXKD4n9l7+/+eOdsi6bPCKRtFziMXF6etaN+Wf0cfWT+9bc5NWaJoO?=
 =?us-ascii?Q?iBcAxtgTuEXhOV57Ct+XNlkO9IEvqLj1gpBCbAXlUvvstSCKV5fUd2pmfQFs?=
 =?us-ascii?Q?UKxgsX1CBoUJiKJcBr/QmCV5OyaXT4e+O00B/K4qIag5bHBTilAKQ47Yak5r?=
 =?us-ascii?Q?iUIafR7ORN6rUikOG510DpWIETRhblavfhzL+jkBohAFxUC5GaSrZyYlblbd?=
 =?us-ascii?Q?RsIOZixV3tEDKlJagA9ygEUNvC6D4hVW0g18LIg5FGG2f25R04HdFC+3bNRB?=
 =?us-ascii?Q?B/P8vHHa2xiwhyrciqfDofdOAHAuHkwpMe4bZzEUfVvjgpv+GnE+2/IVRfKv?=
 =?us-ascii?Q?vlKebu5kTW1P6+4fPIBE6G0dsLANkMxfAPnbiiQgMDKID9BoPPiLRJ5BhMsV?=
 =?us-ascii?Q?PSBAXuQh5zlbqBO3VS7BIR1G47s4eWuvUtXSqcJm368UK3gqCr+C+7/5vC7P?=
 =?us-ascii?Q?do3R5kfhwamLi0WS6U+SlcPMDQSrwPb8f5pSeT83+thgk5OTfVMtHYS3Z63/?=
 =?us-ascii?Q?0KwxajFclvmXTDCEISYpDOicFDxhAwGT+p5/Ltnk+cfGI44iNdvDuKZpR1py?=
 =?us-ascii?Q?NfFcFMn5ktiZ5Ajg6SgIvUeh47Oo7jX+iJHqksOc+b37PJPyxi7JMa2QozPQ?=
 =?us-ascii?Q?bRR06AeicRGZBkscG1vP0+tJS/nGjIany7N+n9fIrYhkCVunjLKFq13AsC//?=
 =?us-ascii?Q?7LL1AWosvDc+8bjAqm/d7GbGgIzY1AQWZkkj6zHm1e+ctPaQX0Qs8FXF+CAV?=
 =?us-ascii?Q?RxryA9ebDHtq4zLt1ngFX/1lbi1o/MGv?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(376014)(34020700016)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:08.3138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e46106-728f-4577-8acc-08dca7b80b51
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6601

Revise adc128d818 adc mode for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 8f3bbdd1bbc5..0c7d85ff4360 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1018,19 +1018,19 @@ &i2c14 {
 	adc@1d {
 		compatible = "ti,adc128d818";
 		reg = <0x1d>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
-	adc@35 {
+	adc@36 {
 		compatible = "ti,adc128d818";
-		reg = <0x35>;
-		ti,mode = /bits/ 8 <2>;
+		reg = <0x36>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	adc@37 {
 		compatible = "ti,adc128d818";
 		reg = <0x37>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	power-sensor@40 {
-- 
2.25.1


