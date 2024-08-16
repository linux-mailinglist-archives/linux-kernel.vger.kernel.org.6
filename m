Return-Path: <linux-kernel+bounces-289371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AE8954593
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37ABC28399A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08223144D0E;
	Fri, 16 Aug 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="hYAxSIgE"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010029.outbound.protection.outlook.com [52.101.128.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF40144D20;
	Fri, 16 Aug 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800297; cv=fail; b=dnwJmZ2uMrfExWjs0zFZ7Tl7IH2dRlKomOvZbN+b+b25ggQ+XE+j9WJ9pcXlLiB3ftGY2LTfdjkUZT2u9oxAa66W2egh29gHDtQHpogIh4ihrEFHW6Qe1i5dKZ6C5jSs2L4TPPXnl6iTGwj9Lb3hzAc3aOYuruOLf9VvN6pBnVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800297; c=relaxed/simple;
	bh=k9TQrTgj/bmsUx8/XHB2Q72cYyInledEqhlOsk5dxvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laLpLhlgnjJM9Wb0qC6hpQV0wLFXXn26ciZo+olo9xTCF3bkwYTtR5wGpUC6YzR/Vb679/7Qde8woUImDl2CBw0QjFViPgCGIHy3po3BtAnwxjbUBUzgKEEEsWPN7Pa8inUqIOOVRYUH6utuVpZA/2Igk1afjCGv14ObnfneIk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=hYAxSIgE; arc=fail smtp.client-ip=52.101.128.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZAJ7ZgjBNxnhj3rAvgFhrEoVeadsEyZ1SuvK1OPmZ3mGDAqCV8fai6LHlaCuzz1SH4xJI4FMc3XACe7BQs5tcznaZsSw92WDBq7VTmC2CvxgMDSztXEQ3C991E89EqTwlQ8ajIfAT+dudJuH6slNuKyQdUN4O1TERLJS5KCNk+NaoDG19plo5Fn3V19MnOo24ZVKP885ryzMDBP0YtRWxfu9xM5IPX0RajyKR5uCElu6dbyAB6UxuhHiggOGyQjNxO53Do06gGINTC0aKy9OeBxg5CWjlbJptRJeL3nYzhiiDDbf3YmgMm4gc+1WeKhbWWSshxfp2wgKVM3Ho94vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTnjvURfXlo53+eVxwkhIqzweQBqIwx6vFyYMB4uolA=;
 b=gSINZVCxx9HKhuKMb1UNcpY+I8ZWgu0PZSDsMKIpkgZcqhAku6t+Xoxb5dIk75/xd1P+GwLvekXz4sx6zPuT9zhCKIM0yaJdhs7U0mQVQcFEeioavn5M20/NrsMCl8PuSMpHOol1O95ttZTlZqd07fT/k1VJhjulkp1dvfvmqnqw0x6RtCUrfPb6BQatJInw3ieQOQW+Q+OB41Yhb3oJBnrc52/uKd7TAUaIHbTIwzAXtWEiYf3Cy5IHpCCitxIQAV3ogneA44J/hf+gciHNmSeksEjfD/QnhVJZrifaYTMnZZpINtgIVlx14cIHlWDXtCJc8B+xhauS+ZZAYLYr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTnjvURfXlo53+eVxwkhIqzweQBqIwx6vFyYMB4uolA=;
 b=hYAxSIgE9tHDv0JPwYgROXQ+oskfpqgcw0go/6LA5qvUnGgmaeCZF90iUUR/mmcxEsBgwzRco3vEc5n43eVrSoyqgxyfYaWo00DReR7jO+LVQ273uXDU7hnBfUeUsj0n4Dl0WkOkumshScAvgyG6FP3iPgBeluCMHFvLWBstscMcbnAVVYUIvUI6fIg/4y5pM6j9wDCEIN63h/VRZX+Xom4v+1CbcdEzRSvqtEwcz8vD/vPV2EIQEZulehB0jrtSKEKc260WSzYn0d4uEG8HxL+ie06m/3DY+yJXGh4f1R517OvPeF+Nc7eHlNSaK/S5UQcd5ro/3aOcz2tts+sDrA==
Received: from SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) by KL1PR04MB7583.apcprd04.prod.outlook.com
 (2603:1096:820:127::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 09:24:51 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::57) by SI2PR01CA0040.outlook.office365.com
 (2603:1096:4:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:24:50
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
Subject: [PATCH v12 05/28] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date: Fri, 16 Aug 2024 17:23:52 +0800
Message-Id: <20240816092417.3651434-6-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|KL1PR04MB7583:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: abc74ecd-bfc6-4c91-2411-08dcbdd547e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?01OTJbXas7UQt1kOJvnQzOCrwd80GpIQCJwbGh2oGrqqfA3gttqD9tzGTqqd?=
 =?us-ascii?Q?19L949Ehn+5r0BFhaNLeo6qfvZ9zUiDp3Z54950/ocfU8xY//+erzrN1/n1V?=
 =?us-ascii?Q?4XxatDKwl19OOmKSQf9sWUVX0161x2VEXrfvVDgZINCDGrn4dEA+6iSrc3qT?=
 =?us-ascii?Q?nxdRmpjDYD/+YdHXLxm+yX+HjYyudrAgrMl0V9/xaL8BPZlJbtsy8A7Xl1Bp?=
 =?us-ascii?Q?r6jMNSvwp9fTBCV/SGKlW9d+YMqqhibMo7E7RZyfrBgF3W40PH44oVMYeVIq?=
 =?us-ascii?Q?wCRjo+TWquXxA0bBAHtCq1lfLEH7S0M6tD+ukQnM7N9zvXwkIPTzTemGNXM6?=
 =?us-ascii?Q?1iTQrVgHutK/P93MWnkswJHzi1ruJ9UrhC/gPxdAl2u/VCNCViomfy+GnGEO?=
 =?us-ascii?Q?SKRtvoMlZ6/Vouhz98eJZMeYjMI8DdLUpBqluVQqRqCOOh6JyRrDP7z3osa4?=
 =?us-ascii?Q?Rv37nsmekNCphHqXR/LW+OMuvA3XgkQGLoRxg406R7Iw9WBzKwh76DXnqdDP?=
 =?us-ascii?Q?Ayc9vFu633DNuq3pBvpRTuCWZNMTlrUDGUFChbXpEV3O94ErqGFp466d2hfI?=
 =?us-ascii?Q?dgt9W3Nboaf+ST+88ei0iY7p8rO05r0rQhQIbM6ouKySnnHu2qTPns8nU/SY?=
 =?us-ascii?Q?VXLk0B5iuE2TBe01vCEl1gziheAI9VHI9x9NnLVjFMZvYnl37zc6oWZIyeVG?=
 =?us-ascii?Q?SyNXByimO7SQj6ub39NTIw+vtLfgiAoTyBYxG5QSLStfUomsUunSLwT2/i67?=
 =?us-ascii?Q?FTG5DhimjFqdr1THG+mWpNUkwAjLEbMDPe6GSa4CdLro9/O6mVDW1gGcSh7j?=
 =?us-ascii?Q?fbid2qosF7sadWhtFlS7WYG51A3axEpww5JXyF5jJqwE2J6EgiXdWPS1xNpb?=
 =?us-ascii?Q?D8884zFOgdrlX2wX8jXNU0bJGftX7PnoXXJK1bdiHtweYfxzrmH0CYlef+Nr?=
 =?us-ascii?Q?bArpLzLBxrLLUCwehQ4KqpBDtmOz8dydEiCBG7BViDNdqhZl5wpEQrTlAGOo?=
 =?us-ascii?Q?/nGNpglUvz/wvozQ5QyipcNn4w1tyTULJFWi4rDKaptusk3Egr+U7IF8IGL5?=
 =?us-ascii?Q?4rfaXBgshR86xjUvPMbC3tcSkWkpwjkUxgaAAvDolGdQPgP5mAjwkatKQdga?=
 =?us-ascii?Q?mjoTqNPA4/mahXIoQ1x8YAr4mqib//EImk0O59jUHdlJrh1fvArx3rxuIQNW?=
 =?us-ascii?Q?07PvStjPbk1MhK8WkGE2IqxBoZKvzjOhjF0MJ+YDMTKkl4gP1HSHj9kUePj3?=
 =?us-ascii?Q?ZRr3hOSJCLb9HUgGClZs/1p+ipyFzsL2Z0h5RjEYQ9j5zJLmocDg7vJrD0LF?=
 =?us-ascii?Q?JUb03Fn8Mb6KX+T3YJmj1S+S9TiYyJUzw1MBJLqwaiSPdWL1qaymtZFB1Gjx?=
 =?us-ascii?Q?f5NmyF2J4/dDzXMIoIYSmTnXRW319GSYyThx8QZFFYlUY8St7G4jQnX+pLg3?=
 =?us-ascii?Q?jynSjvAiXPvldi9e7sYID53QejZSse8r?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:24:50.9659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc74ecd-bfc6-4c91-2411-08dcbdd547e8
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7583

Revise quad mode to dual mode to avoid WP pin influnece the SPI

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 51b4e9ae13cc..e5354efbb903 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -149,15 +149,17 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-64.dtsi"
+#include "openbmc-flash-layout-128.dtsi"
 	};
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.25.1


