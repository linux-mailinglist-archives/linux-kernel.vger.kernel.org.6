Return-Path: <linux-kernel+bounces-187165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9528CCDE5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1AD1F22FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1223914B943;
	Thu, 23 May 2024 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="goewM5vv"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010000.outbound.protection.outlook.com [52.101.128.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529A14A627;
	Thu, 23 May 2024 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451515; cv=fail; b=ubsOM36mnWcnQQGfg4f2sBBVcOguhaCCqHkgej/jZmBf44eK40wI+0vfV/KwUqDvltnhgy1lgpH8EEjbwgedJMB/Fn9gDADmbiee5NJ0wZ79GtEe3vlA2PstGuU1UJYEJt3Zf00dHCe+VE8my5HLWO4n0E1tTTvmc/joJ0MI428=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451515; c=relaxed/simple;
	bh=XIC3q3yzw9TGgmhnHE175vu7ugyAJzMsBFkmkSRby4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhr4WjXgPTkozmtFMixXqxxQPW77hC4sM5cFJZWWW0fP/M8dVfCDCt82Z0WzslAlAuD4B86I/sJp6t315tl9jcE84TM8W8HEDAmm/mQfxiU1u/ODH9nJlWSObnE4CvhoXpDPmkkR87tnn/73s8zL2cOKTpdLzm/t5//MQZmHsMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=goewM5vv; arc=fail smtp.client-ip=52.101.128.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPpS8J9TXV1I/QQ3S8fFVD4nqrBAULxzco645QgGLYki7fXppoSQK6Q6E4iqlej2vP9qothEjsNgqhMm8B7kH7MaoNT39QjJo/wh/sEFC+F7efCr3ExhFSjK/OjHIuDqbv+qWGaVSB6zMPBUiQa/NuyEfpyH1UCFJY1KoZxRlJ27gyltwda7hvhcxqjSM49YIFH+qNVIPdfm5hTPQRXbvFSc0tE33E5chz9025tFWVPUaFD+zeD+EcwouWAyKmb9RqH1cL4fSPUEgZBf/JgN7wPhheiE++4yAGJ1QLEwIAyGqUEWmmFYTdd3w2bWUHHoBqjRWgpR54ZIyNyUuJgkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foNIYuXpkItBjY8qUhSUDvLy6XuG5cw+SWa9LoMYeno=;
 b=Og9CIW0fpuuyI+eqYQOxy3E0NnBI8VGG/D/DD2dUkqvztFuaXehjqSFjE4VhR0Cu871JbpKyhRkN/ltOIEV4MUY0+SQy5TSJQml81u3rWnvM7FLUvQfJb3QvK85GCvA+CCW2uy0ez/L7T9qoj8yzAM3tv3Go5ZRZXUc91ZqrxkMqKGaQAP9Z2w4XIl5B9sPwGO0lbOZqPtUHGFdK0SdUu+I7t0zMJJL7GP+p15cnMf46zvc3BDWqc2wDn06dJX4N08XRWcFCtvhq/z52RiP7rO63rc4JFGQVJZcNAudE55GGg5GwYFlMV5BRxRBlVzU4TqI8DoaM27R3e/JU2uFfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foNIYuXpkItBjY8qUhSUDvLy6XuG5cw+SWa9LoMYeno=;
 b=goewM5vvC8WIDrhr8ONq901vZs5a1hn6m2aHkQln8ZR2NrWr+4QEDex/pEOiAbRb5zMDYfEVSIqrAi40dZygn7rpanB3GFMzcO2Z3DrVJNqIpJsOZ/q7wKFoLkgXIGKk1M8TZt9L8ecYmevNdJZixA9r3NJNT8Jun1Kl/gi4n7P6g3c5Yp1pBbJDH2IIZpBNWvWpvWBHHCiZzQ1uevm2/1xEXKyR7OMG0TgRYGWw6zVG1bLBb/ZGPDB/Ub0OR2fwXeN6dj8JhWBBEAP9Cl65oDrzXWaLkTm/NByvtOdaxZWgnHJmmWvXP5hABwF1GFVsVE0ZHAzVMX8hkZqlwVRd5A==
Received: from SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19) by
 TYZPR04MB7334.apcprd04.prod.outlook.com (2603:1096:405:23::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Thu, 23 May 2024 08:05:05 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::e6) by SG2PR04CA0157.outlook.office365.com
 (2603:1096:4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 08:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:05:04 +0000
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
Subject: [PATCH v8 20/23] ARM: dts: aspeed: yosemite4: support medusa board adc sensors
Date: Thu, 23 May 2024 16:03:25 +0800
Message-Id: <20240523080330.1860074-21-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYZPR04MB7334:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: df842ad2-2b09-4a21-4f50-08dc7aff0e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|7416005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eIN/4IlmtiEIMmXO42wwcRK51TXYC6pY33449jgeBVe2RAJu6yQx7sjn0fai?=
 =?us-ascii?Q?GESy+/oGfT0NeHn01FpV3ZwODaxZbd7aWjOzTWgDJvemK5bFIDTP7xZJVYYR?=
 =?us-ascii?Q?QA51sONclaNqHuhyZ7jDFQHwVmvy3Xcuqb3Ezf1oPuBIxttBjqFIVgrNPhxw?=
 =?us-ascii?Q?WchDXsGAFT29yMScyYcVQd6zHYRiaubS3RqJuJBreSJujELSfazmvbWxjzu9?=
 =?us-ascii?Q?qye+yGCbK6fbuuFXcQdsOsMH9tp5Yl5bICB3ololplDklJBq1xLszbtiymGm?=
 =?us-ascii?Q?0ZWOB0AevfdG2CnlMPil5THIV31jIDoT9VI9gh1LyAXNqi04xTowk7QJRttc?=
 =?us-ascii?Q?Px1Lh6onrn6Pq6y8kI8NgCJItSVOnG62kLxSuvF0UhQvPgthoS4uiEut7IzS?=
 =?us-ascii?Q?ZCVoDifEGSVu6VJhsqDkEY4SbsN7u9vD26akZGJ/PXMhNb6bTN1ilMfMUj1C?=
 =?us-ascii?Q?5Tj+Q12jEOxbaXj1w8LUHONQNlX23+Gk30GMSf6VcQIx0dxOM+SGubzG8jVl?=
 =?us-ascii?Q?ocJgd7hBUaCZyhfO8B6ZhFbPY1mQ1zfDdTYrurFUgWqNdCEf5zD6TYwBga8v?=
 =?us-ascii?Q?48mFXIyg+pqQAtLrE7McG8kh8cLiSJOos8F+Ng/2x4Uv6JIAfiLiHuRW363l?=
 =?us-ascii?Q?xOkktcqqNmm09UlCAyXL7fHKnhWwOI6BE5uENyeXxUeKKdmoPScNlxq06T9X?=
 =?us-ascii?Q?mTkJ2FXyskKvNWbrSd+yc1P8nG6pps/NFTtloeHH7pkP2hzKZUZ881zLetuq?=
 =?us-ascii?Q?7Lkr3dyrf9RwrEmjmlsked8/c5sjXrU65PKlTvX5wyrqZxqYonpc8flFc36G?=
 =?us-ascii?Q?1gJvhOWLi/sc2YMRL/8chWSUaj9Y/mQn6O5wfEKnM6ecLMxEoFiv7UMwsUsq?=
 =?us-ascii?Q?RzIMm8hPzUkO0N7Kdaj+RySPdUz095ViTiQLItu8T3JM3yqMjVfqcYMKOl5j?=
 =?us-ascii?Q?PFBHvmWdEDpv5pSDX63oZ64hHjMpoPCWYasyY8OYUshua6xnjh+aidmoSzw5?=
 =?us-ascii?Q?LYF0/Cy7ZcFe/1RDG5MaKC6il9u6DJXVx5ageXzY+nR6vrPMPx6LdmXvBYvK?=
 =?us-ascii?Q?p0j3cqp6j95a0f/fMRVZYlQfy4hpAukTRF6dn5EhmT7JnrKaEkR3WdA/gCDp?=
 =?us-ascii?Q?9arttOXbQztO1jgk9kblWLUhkKA7efV/kXwUFyh3Sh0suRhkx3AT5mjyLkr6?=
 =?us-ascii?Q?1sUNDKkFOS9DJEVKEG5OJk0sXmtYlf1ezPTGka06f9pF8M5zburmG+KmhDk8?=
 =?us-ascii?Q?OFMk1tCV/Tm717IvMDdkHm/WjN10j1riVIyq94bDiJ8rjzMek+9SStgk5ZE8?=
 =?us-ascii?Q?nLlWdY4uOeAXHsZv/VOgfZpo0AoR72DrTit4dVr/mXz/mvNp0WtDwzgwsyOE?=
 =?us-ascii?Q?TWvCTXo+IuePhCND4ThhIAqhSg8n?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(82310400017)(7416005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:05:04.4534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df842ad2-2b09-4a21-4f50-08dc7aff0e12
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7334

Add ina233/ina28 support for medusa board adc sensors

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f4e37187bd5b..bacaa2208734 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -915,6 +915,19 @@ power-sensor@40 {
 		reg = <0x40>;
 	};
 
+	power-sensor@41 {
+			compatible = "ti,ina233";
+			resistor-calibration = /bits/ 16 <0x0a00>;
+			current-lsb= /bits/ 16 <0x0001>;
+			reg = <0x41>;
+	};
+
+	power-sensor@44 {
+			compatible = "ti,ina238";
+			shunt-resistor = <1000>;
+			reg = <0x44>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
-- 
2.25.1


