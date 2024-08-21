Return-Path: <linux-kernel+bounces-295256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F281959917
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB66B2466D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489621FB2DE;
	Wed, 21 Aug 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="R5QyeoT4"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2089.outbound.protection.outlook.com [40.107.255.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B21FBF58;
	Wed, 21 Aug 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233344; cv=fail; b=PPOJGxRV+djjfs9jeSgPcSH8PtnQDgiMZA5TCZ57m41z+fVnOGWoW4Tqz1lzsoVAUHP1eIQn0xVHB26+tHNWmRNY3uwPzpkJgexpZ7Ql1Y50r6vgRBTgP0HGWm0mDvwaKPIM9O/iFqU7gUKCuKFHl9Jd2iFmFmoVrxsf2YHv+/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233344; c=relaxed/simple;
	bh=9vedNn4zZ5Ih4XUlJByZ0k4YoTGBuTwqHj0FUTJT7YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1tnu4hImWj/W4mv7STI2iSOzAHvS/Bhu8zRNGusppcVc2TcHpHTBz4EupKFIkGQFDmRA9VszTNKzhtO1OeKENc0DhvGQVRT7Iw8JyqKAx5FLwcYqwJ+/tpXUNoyvtmZHpHVcYX34nyW9z1YOyjWp7H6E04KIPaiIJ5k4WRA/aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=R5QyeoT4; arc=fail smtp.client-ip=40.107.255.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8l++K0XUD4/yx3P61XZWZqmTbN/8xg4Xy6g8tuWBRoFEWh6OaZPGt8dQqYz02QOJsIpt5jebCIRzrI8nFFz5EAnu30wDfY8I1qpBHDHghust/QBOHcQrJNLYjCj9ZvfSGZSQWCyS2qdogQVpuTdIOFXeI0wVThnxrMFmhGDmJYOT7esHFdb3ZieEOnFDPQ1khg5Dg3FQ16BFZVPMhKXG+5F50th2rVe+I4ETLbPqnYSh+c+KLtDmRWlX+IzXVRRIX+QXGS/PSGrT9kkqUB4nE9HCZ/5iAi/S5XywlgyXMm6daG+JqTNUmTOh4XPDV6NXI4uGmGSIA7B/l4HryRYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ8R9uD5dS2CYOtc4xvne6zIrhYDAk0BYpQGanDefRc=;
 b=mNclSdvmLrEyl9+vZWRauC6SqutDxo0rO6l9D3zWvziYbTytGwLKJgDpxUfbe0804Ed60Xwkhsi2Aya4g3cczFpdpsd/sgLOI/rZ/2jLL3RZxD2ig5y+9gXj//UCYNlG45Gc7XrXge2a/0yhxqz8UtSCYhaLnoHMXUkUITYeUqkaI6lMBKvz+oUEFPT9xDR3+GY0qiTNHfjNUmPnSJD2wjY+74HhcA6NTImPxPCXIURUdEub4rmymEC0oBFg3rObBEcfmUaL8/LIF3sijUKRnMS3SWStE3F/v1y0lCwH0S2/zq2Sj7H3YEg1813uTBBp1MCd06Eurt0L+4d57v2vJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ8R9uD5dS2CYOtc4xvne6zIrhYDAk0BYpQGanDefRc=;
 b=R5QyeoT4OIXVHoE6XGp9IWtu8rXu9BS5RytK4r7SMnozrJ+GEpUCEkEmgpgRT4aSe3RKU2rttSA3UmF3HWyzGzIcYbQlIqvx2RuMcc+FWaI8Z99SgesvVb97xP61PhIpRgqaoT1gQBFGO2wfu6UqZEbKN3i1b7BipkbyFqrh9p6JrDOG3333FFTBgP3UQsSblZKcaQh1exjuwq2qiRwrOSqLeF1aoEgJ+ny8wbypQUAAngLYSER26VSWXCDZVjvHRdm1AakQTCbWRCXkby8FIp8t7jX5AyFV+/8ePELKNyHm9il2aoeyeKqEEuaIqsnbLWuQGwxcnQXJSTEEl9HqYw==
Received: from SI2PR02CA0028.apcprd02.prod.outlook.com (2603:1096:4:195::8) by
 PUZPR04MB6368.apcprd04.prod.outlook.com (2603:1096:301:ea::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.18; Wed, 21 Aug 2024 09:42:16 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::80) by SI2PR02CA0028.outlook.office365.com
 (2603:1096:4:195::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17 via Frontend
 Transport; Wed, 21 Aug 2024 09:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:42:15 +0000
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
Subject: [PATCH v13 12/29] ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4 schematic change
Date: Wed, 21 Aug 2024 17:40:23 +0800
Message-Id: <20240821094043.4126132-13-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|PUZPR04MB6368:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d2f31fb2-3766-41ab-b9c1-08dcc1c58aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2n0D0NtBJDIxG34cSVZ2FwUVwXBLru68dMzudTZMy0Uh9PB+UEtE81+RgEME?=
 =?us-ascii?Q?FJ1GYWTEz+LqgHbNJjOMU7VwTrUjEENj1QALKegf/QOua2FF+/DEl0f5JreZ?=
 =?us-ascii?Q?DtEIDi5ieTW6JXlOAYNyTi+e5CU9vqNl96QcpM70wgq4Dsa3/v1H2ex65lY3?=
 =?us-ascii?Q?85PIesp4G58pGQN4zEkc0fFAXBS2GEWPIHRidpwZZXZEUFdGOLQa5NMpLR7x?=
 =?us-ascii?Q?bcd6a7W+7SUANHnqrhwP9x/XOPPWEmVokrT9H+uLoVIfhkgF6fPqmSS66L22?=
 =?us-ascii?Q?p+Cxwoq1aTM+hsGU1MORI3n4q+72GhoiIk5tangPFsRB7fvaqpIV+Riol+t4?=
 =?us-ascii?Q?pyaEmPjDpO2zLtDgSIw1sEZEYHdsg0tNsbpErZ3xO7KUCEy1o+kbHxLaeJwb?=
 =?us-ascii?Q?qD9YoPi1utj7CpPYMy83S1yFviMTVU4KXdlNnifztW9NjuH5kn+sGbgbgi0K?=
 =?us-ascii?Q?tQCxGM8t52PePq55mN/Vx6mSbwJtIWfncD92xCn/55evZJpGr0prYmu03MIY?=
 =?us-ascii?Q?dWp3BlLZy+v1mfz9agacltRnPznEJ5N5teRdySHEdYwRYBSltGfJr6rc7naY?=
 =?us-ascii?Q?EgQNmVb/CqOq3BTq/8r++IIsv0PVX8wCjgykt62D6xeV/gEnsHmHAIGWdtcJ?=
 =?us-ascii?Q?RRIpvxZ7Gn4QF1TAmgxQuoz3JXdnhYndlImFYk4GLpRiFEsMme73mJogsTTH?=
 =?us-ascii?Q?u3xLSXab4V45aNXPoOXdNL9V0rZRQkDOXM9MNJrsjpDwdi34aVCoRitu9ceS?=
 =?us-ascii?Q?av7ZK9ya0SxlcVoNZ+Ennp5Rt8HvJSAaq8OQ6FrsF23jbzVxrjSFPGehlZN1?=
 =?us-ascii?Q?hu2azzCOG8b96+taSAy4Q0F9JlHSywaUj+r5wmMFm2bjOok1wiPJLPwopg/1?=
 =?us-ascii?Q?AUbgXXWbV/PKVpdLmWTFkEL1CNdKQsJI4W/vBcnj3PF+U+1hdG2IW/OWoaJe?=
 =?us-ascii?Q?2x1lJBvw6qgdE9uNATzR0WW8Gkc7sVqIUYo8BsHUbJK+Wn6sVQILnyduBjvQ?=
 =?us-ascii?Q?N09sui9cU0uD4ArklWxzFZObBuxfDRgUZ0t31s3hznqCaDn/1wFVa5fPWgfH?=
 =?us-ascii?Q?QEn6ObGkVGBkeQIH8vLNbdTpEV/ZBB79LJBiho0RAD2WFFjGWR+FWiyoY0BN?=
 =?us-ascii?Q?tQ4Si/0Ouc/3UBW8k/lTtXjg1fxo52FYDiiz8kDtk/yF76b1PQwQZPwZO3Si?=
 =?us-ascii?Q?+3y2gkBhbR3qY2UVNQdFsezPQoWhqqcotQJ6Ono0KQmFXCu1V+tqSj4pyzlH?=
 =?us-ascii?Q?AwgD/Td3/exyS04s+9t/Z1K5/md66byJ6aIEJNIC58bjuagMkUX7nZHa5svr?=
 =?us-ascii?Q?vAVx3ojGsiNZhvgJd8uR4L0axhBjsyCKPpAUnBnDBMKrBvRb4tv0+ypUbN+z?=
 =?us-ascii?Q?/J7EZaJKw4culef5ljM45A8gdvXkCWzLAuNpUA6ddGNJLmiazcOE+coq2FAf?=
 =?us-ascii?Q?pi0ydKq1RNjHax4A5gBfqlkcHfFB0sdg?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:42:15.2156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f31fb2-3766-41ab-b9c1-08dcc1c58aa2
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6368

Remove temperature sensor for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index e83cb51ac19d..2c0c37b3ee5b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -921,16 +921,6 @@ temperature-sensor@49 {
 		reg = <0x49>;
 	};
 
-	temperature-sensor@4a {
-		compatible = "ti,tmp75";
-		reg = <0x4a>;
-	};
-
-	temperature-sensor@4b {
-		compatible = "ti,tmp75";
-		reg = <0x4b>;
-	};
-
 	eeprom@54 {
 		compatible = "atmel,24c128";
 		reg = <0x54>;
-- 
2.25.1


