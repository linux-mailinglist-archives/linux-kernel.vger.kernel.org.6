Return-Path: <linux-kernel+bounces-256986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F299373A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD851F22D53
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE0283A18;
	Fri, 19 Jul 2024 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="WiKvPg36"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2047.outbound.protection.outlook.com [40.107.255.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821C824B3;
	Fri, 19 Jul 2024 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368806; cv=fail; b=ffiSBIV3WxiMgECUzXchUciqS65cI5yseq/FUQUHMslWcVh12OD2sHqrlciI+OWhPkOYvLc7RJgopHkslfc8mEF/4NTPlD/M8GgKFQZ9+c4CIcLpb8I43DNg30GL3hLNwlK79NSz+KfG2dxvs6Ys1WN9nTdlUI8APasp29LkFRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368806; c=relaxed/simple;
	bh=9yrxjPBeJF1QV/4lSbFupr+SCdbmhwNHFRniZXb4Y50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvXFfKcGYwuqpep/5qlfsiJJgEnif9CroqVFX1Ju5Sk1y955rUyAoXFOYkKNV2ZRg4n0gdj8HzlymryCOK6GxXLWYTyGwv1++rSVmtjTBAXk00vJhlKyQW65MF9cvyLsgVgqwW4muQNbjuLeFt+FNkxNNOoBKGUZAh5BH2hdZxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=WiKvPg36; arc=fail smtp.client-ip=40.107.255.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6qbvVgDTIjWxJWxhX5oYKWksovm1QZCs4lr7grWugIPlSj+jgclTE9jTgQEZjZ0lOE1qYK4LySysHl5ckhdMKbUhDMMrhvC/crTbIaCUT0AgtxCSQuoFocmyOmTiT5G5Eh/afADnDmlxHQVkiVh0u1eMkvbBp9eF0zekkpMou4P9hjg9VZ38TGySGbCFt3x86NlfjaNdg54nF68jDK4vkTJUOkjZYtRdjbbQ/HFRfA5wUkVKQ/kbX/8ZvfNr8OeEgUIObJfWzYwryzt6dW7PcwZ312ZHs7VsxggbvcEJNoQ7iMHIpI3pZWVA7u8mtHCQ1V6TKF5DQ4ajrBu5yJYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pjrbPmUmdku7Zq8bJDb7/0Mq2EK7dm/UVhdSc/M8aE=;
 b=mYKS8LW+bfSfN4NL1W/IbEVq1zK3d8llJH2Immgatk4NTCxam5xlD24OtouLqWqlnJiQ/X/5bIFLt3nfhHTi8LTXHB7D4o9msLWj2MUpHQmAg0jsGOyP4l9hHPvMbsBCs7bso+OlEU4Hfs+aVXv5eeTyIMXwU7KksO9Ocafa+1h9w/wCmWIwApHhPT26fpdxI3rTkN7Yj/xcC3P7cnOQslOUky1+9BNPRMxjxsUdGIzEEnhfO4VweCzklOt4XG7cWnJ5e+6JLMthBLlQFNd2TyHL8eNBekqbDPwI6OVADT9GH4GeebZliSFW4uT8EIs2U8FEvu1jZtwC4URCBmJCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pjrbPmUmdku7Zq8bJDb7/0Mq2EK7dm/UVhdSc/M8aE=;
 b=WiKvPg36SjyZ2Q/Fxo4N5clGoBgnRk252jDcsN7gG8AJZ7tnU/D/1LdDVxPXnKMU/3Zkh5YGbHj7ki/IcaSmPTKja+OiUczvRoh7HBk2G94JyCp2q/y1eDhoHzE2iOF+pokfZymkWoWIEl7mnfSu+CLfCAGd9oVXSoc//Ek54XeOGrbx5XtPmdKsB1D/lA2nvHvuL3/GDyg3vDVyR7QtV9ufpO30xmfBLC0U3p2/37Q3RSka8+nbRI7JKOnB3HUz8NBNyucT7YLtvnbZb6n7NQOOK0cEJ7TDb0C6RxdNekHGw7gOK85Bb71ojnNnOaij/Zf8tCMwR7zPDS1TMPUG8w==
Received: from KL1PR0401CA0026.apcprd04.prod.outlook.com (2603:1096:820:e::13)
 by TYSPR04MB7716.apcprd04.prod.outlook.com (2603:1096:405:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.7; Fri, 19 Jul
 2024 06:00:00 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::87) by KL1PR0401CA0026.outlook.office365.com
 (2603:1096:820:e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Fri, 19 Jul 2024 05:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 05:59:59
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
Subject: [PATCH v10 11/27] ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
Date: Fri, 19 Jul 2024 13:58:40 +0800
Message-Id: <20240719055859.4166887-12-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYSPR04MB7716:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d5c41772-2989-4d31-3bbf-08dca7b80613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ezj02kzQ6GoS8eIiUuXHoflLfsOkK6AxfzaN7UoCNBFss7cAxGNZssptevyo?=
 =?us-ascii?Q?+NDF1gIocrx2LUEffCDaZMtiqqaUfD0L9XWtJqG6nmGO8wEJdUNoTN7PjLqR?=
 =?us-ascii?Q?ASgtr47AtBkn93c7WOyIqdYl5b+iVd4TvfwdB1k+tpr6MZg2N43rj6By0MYw?=
 =?us-ascii?Q?/roQ1plmwtAJQrctAm/QyGLU4pHJULRQwia7iCQn5hLqEWrjvTHQ88My7MY7?=
 =?us-ascii?Q?cJM80t2Hm0uYyRm/FANkK8BXJGuPLlAGgq4m94P9V1ydZgPa+/Wtx/zx5qYS?=
 =?us-ascii?Q?XhwrPplv0ABkT2+i7mS3aHowRKMzfGB5VWP2xraTGsQPRPZnInyBq4PE97w9?=
 =?us-ascii?Q?h8jQa+FC+WJR19oPkeISpx4SwKK2Jewajo/PXWIDk2zUlHAAPCn6I0fgGEl9?=
 =?us-ascii?Q?/++vpOKHNmwM6ArvC6+Rc99sGAV+OebjstNQXX9xR+Z7R+7ThkFB+NurjBPh?=
 =?us-ascii?Q?fRB0pxom+cvguZcidl+Owrmk8p3UrtYxjaRUgu1C+PogkiK0kOLC0cLYTYHm?=
 =?us-ascii?Q?rN2pYpeVYpHb4MAWIu1q1JEb6XVrpNX9OIAeU/ZRfgJ5FShxWUxYCJ4xzRje?=
 =?us-ascii?Q?TquePtC5Pxm/hTJW505WgzOLyUWJLZ1wH4TNRiNWUmkocO7wle0JMuEwxLJO?=
 =?us-ascii?Q?VL69XpwISeq8kILX7HgzYExgzQUyQ2bku30NyqlE4ASz5Iiy63jH0pTnM4hR?=
 =?us-ascii?Q?nl22mGiaC7YV5TWQkLBE4UrE8fF99PuUldEzVxHu+glxzhroDwGJuX7dH+ag?=
 =?us-ascii?Q?Lgkd3/7zAd1g6aeMB4DwNJXOU7zRcx5e64ruEy05NfxdMo2BpvQ5DAeA+Ou6?=
 =?us-ascii?Q?ZQYGRwq6yQIsWzFH5iJtdFP/T/NWx29+IFi8FcqsWlhF9s55bAp2Rfd0g7DN?=
 =?us-ascii?Q?RWTI1Pgc/yXncqLTcxpOfZrzdnS2zNnGbOJ2dZXkUmvvCK3gDo7EENCYNDbn?=
 =?us-ascii?Q?9TSYaLRW7oPaxCSjGpnlX218QsOpyreYD0V9q/gSXxsA6/DdYbRCAuB4kv3k?=
 =?us-ascii?Q?i+7GIamPZZm9a3XvK3FJzmiZHT37FcEz+PEBZX5Sj6aI7ALKVKOdLB/fgVdH?=
 =?us-ascii?Q?ZrOf7H7zxS8JQK2wt8jHqf0xIy51Blk1y8kKtGP0Vqc4ElK+LjNjw0q4YTip?=
 =?us-ascii?Q?kFrX5esvayuJTHHO5uzkOnFyRmF+FEHIrrx8F0brNUPA/CLGMKptc4NzVFBQ?=
 =?us-ascii?Q?oXHaV/f81V5aLi52vf2bMsXFBcOJcHM2RfTR0QpnZhiE5fGaI/kJH4Ie0eaU?=
 =?us-ascii?Q?xLPhNGg1RALaWRg2XDXyXgaLQXKxwT5n8GHLGrr+bI6ATOMhDzbAn2rqbuhH?=
 =?us-ascii?Q?eYUHweb6RL1nTwVAp29wvGuKgrPDih9k2DfvURXN1JHlnpjwi0mKdk1j/Gwp?=
 =?us-ascii?Q?S9Bzvbmvc7zpKS0JxRIn1QUzFbgmX5P/yyDZwosjN99cWZzA65oYcEjsT6Wr?=
 =?us-ascii?Q?7RlhmZ5FupSYoTVFRhczqwI6bhQkTCcu?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 05:59:59.5012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c41772-2989-4d31-3bbf-08dca7b80613
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7716

Add eeprom for yosemite4 use

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 2ac872878acd..9a14f0220cf6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -932,7 +932,7 @@ temperature-sensor@4b {
 	};
 
 	eeprom@54 {
-		compatible = "atmel,24c256";
+		compatible = "atmel,24c128";
 		reg = <0x54>;
 	};
 
@@ -971,6 +971,11 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
 	rtc@6f {
 		compatible = "nuvoton,nct3018y";
 		reg = <0x6f>;
-- 
2.25.1


