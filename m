Return-Path: <linux-kernel+bounces-300819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9220195E8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F41B21E60
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7568146D7F;
	Mon, 26 Aug 2024 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="wdZ642/Q"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2042.outbound.protection.outlook.com [40.107.117.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179AB146A93;
	Mon, 26 Aug 2024 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653601; cv=fail; b=OQznpSUXrKOq0BqELh22R9Dpu1E+xFdIdHDAOx1BVJbL6uD9Hlu0U51uYn6K/A4t+C02h50Dtw+Ru8QZ0hesypIwEDC0qVJqwb1AOyRrxPiwGMrUIhq+nYs5U872ny/OpLEtgx73JrATHQpu02NmJ24jRJ0acRxrsbPXapPXlkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653601; c=relaxed/simple;
	bh=PfdifsAGi8tVEbQhQBk/QLDU4FcIeWEIdnzHhekGd9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTh4z2H8BOo8gIiUcBmk7drfovhpoioj1b+GbEBBbkvtw79TsuvRKdQXolD+z7pC4600FNQH6dw5ihzWSWCTvq9kBaNQUQC4CWbfxSmHGIj4S1i/CrPwgkKXhO/mPGrhtQl4BPgt0sIo1xDDVbhqRq3b5fNBQGa/ipNe2kpSnoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=wdZ642/Q; arc=fail smtp.client-ip=40.107.117.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fqdh9trry/TqKanFoyUh2uxIZj60f0zyIZ9W7IU0XnR0SD0srIp4K/ixg5C/YVQB9KP0cx/6Dej72uDE5S8T5xIwuOzZdTw9VDb6yR9j2Ge9zC17lp9YXHHimJ0QPhtfzn71Ff0KIRXWpuK6Bao+/g9HvUwKSBoRXNyDP93CfhQeI47+97fc40GfS15TQXAK2ZvpmLqdlLV+qLxV/iBu2WUlJG2hVQqtOot/nau5EHLRuOmMMUhEciSOKcbF8mbPUeUKAZXwY+3WnvH7ql0EXxRUWoKijqkgiOEmZcfRjxW5iF2xlq06zUh0aXpHr5cYXuiSwbIy3k1Au/tjKykF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGEY6kFHCr93vzQaG19EtYDkCI9Rttn+5U+iGfkqrRQ=;
 b=ntOQDee14MIEWeJoBSsAEks2VleLpyUrd4ZMG+HLzpMPqGCklnB3pfYg1UCD5UJyXa5oTtzsBr7lmbcdM60oA1UmM223RKQamg+Tpw5Lix3yHDWAV88+VyYITU0Q8yj/JCNnCniWdrvHOlq2knKOxMNoQ+iUjI2h3LXFpjhhuslxKKktmM4DseFKv5wwcC8DXI6QSw/uRY5f0MiL3EGfsamCyQYF4GuXLIwmoZBNAUqv5ag8eIezd5vYn3hAy9dZXDUiH6z9WWa0Jd54ZMx0t3cdROQHkgE0ObCcl79ca2e71lUJZk/n/SD2DJuUGJd+OY13OrlDNi/zkH3G4Aj45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGEY6kFHCr93vzQaG19EtYDkCI9Rttn+5U+iGfkqrRQ=;
 b=wdZ642/Qtp00qhHNVFyX4FxNM+6JY9BY1YoNBWNcvJD1esuxezTOPxbUoJvjqSah3Sy0+VzTPX5vBvVIC1AcGbCMS/aFxRId6avB9UsIeSg+W7+0Y+H88gUFww9tJou6jwLxljBTTWBJlDJ00TAAn3DZIH9gEkdyYscwo73cKvS1nAfLU/yecGiVbJ3ArL1cPlhYnMXFr92hP10lab955naCu8oRWFpB24t/f7Tcpnf4nouObZhiMJewE3L2ObIk/KU+SYNInMZizV/VI+YuuiMbrOKXlALmGiakHIfdUPlyCHd2lLDyplt4XMOgkLiYM8yojR/nRMfEnv8Eb53MDQ==
Received: from PS1PR03CA0004.apcprd03.prod.outlook.com (2603:1096:803:3d::16)
 by KL1PR04MB8102.apcprd04.prod.outlook.com (2603:1096:820:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:26:34 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::b3) by PS1PR03CA0004.outlook.office365.com
 (2603:1096:803:3d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:26:33
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
Subject: [PATCH v14 26/31] ARM: dts: aspeed: yosemite4: add MP5990 support
Date: Mon, 26 Aug 2024 14:24:00 +0800
Message-Id: <20240826062408.2885174-27-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|KL1PR04MB8102:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4324256b-bb28-4bcd-a5ca-08dcc598080e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lfnnzvJ/4nkUad9m4+XZNmNiKpgV5ndCI9OlUevcjgLyUp3BVgmXLntDwlDe?=
 =?us-ascii?Q?Iswvg+1FFWm7syRp1qVWT1VG9Qn7eqA6ZRGnQROF/bokf0Pm76gZHCu00YZE?=
 =?us-ascii?Q?JjCFgd0dkFzabNWET4+x+4THLFlUfjJom6e1kLFc3ZuabVNpKejhmIV3ZdAJ?=
 =?us-ascii?Q?Bodl0f7FCYfIDuj8rlM69LQPSYSekFxOFDmDR31tq8ADiCqwgddBqXfbX198?=
 =?us-ascii?Q?PX2dBi7Q/ggNZTHP1Ar75Q8Ubi9jR6QuLBmAZakFupcDFIPJ3MhZvUrMrZLC?=
 =?us-ascii?Q?4F6+eejD7pwhfTaLT9RyHF+5ZHjoFiTSD8nh3q+Ah5X6XDmEovzSH8MvLAn/?=
 =?us-ascii?Q?TrjiPePSkM0Mhn+NuY/E6pxoayvKUbSXjAm/SHrBeLiGXnoiOOazh//PwqIG?=
 =?us-ascii?Q?BLmFPJ1o6catnOFVh6rJl1rvJYm0khDbM8FV1mQRKtsFFtABhr7UivyYR7Zx?=
 =?us-ascii?Q?Xeg39G62v7XEF4HNR8adXbAxB14XtT0CLZ8pioS8GJd4LcTj1z7uzsvw/CSm?=
 =?us-ascii?Q?/UTrxNvWosxDWysmFbAmAWJ+UtJnPTjvaGKCWbX3CIZvK9TPzwViA3mUizTi?=
 =?us-ascii?Q?IPex2jZbnrBe9onh0jRjbURFyXNMHfzMJk9WfF9Lak2gv4LTKBG98WeqkgxV?=
 =?us-ascii?Q?SEEuXWk7k5lJC+5y8G/ltFjjVnBmHlMZfeezva/+mBd8XVvTMPP3ZMnZpmNx?=
 =?us-ascii?Q?ESUE/3jGj8RQqIjZVDpt7gwivlVpDWbrfcqn8meb4BejWgRNTLnKNkYJo2OM?=
 =?us-ascii?Q?1pbU2+DUCDzogmHtYjmQGK/wa80NC5dUYnDwkV3YuasZyfSB5wyxX5ypn6hY?=
 =?us-ascii?Q?Fl/LrnLB8mM2JuPuyv1AA6Q+LF3GbYnSsX7iccfOQi+XdJJ5nl8HuyX1HqvC?=
 =?us-ascii?Q?7rYLfxZ8tiGO8z1t4NKLjRP5vg2xp6ntwDzpNj2am05qHTa0RCapGQILueZe?=
 =?us-ascii?Q?9Lu8T4lno4i4LoHt/S7hwL2xdVU2aG9kr/Kr5yQovuLMFZKkIACvTVakjFmk?=
 =?us-ascii?Q?vbNRYdeNQuQCIhmQriTgY5UaYFtBGmcxF5m9nwpUOW5gxGL1p/uF+rgJ3Xb6?=
 =?us-ascii?Q?pMbpsF/xJ+k2Fww9SmBoYa+voXE8tc//pKagvpZTCpN9yqcy23G4OsJQJNwC?=
 =?us-ascii?Q?NMEBjIVrfxj65zBzh0gDz5Yi5zhBmrPRdZfDbKLamPZfT12neUsYo4RCENTy?=
 =?us-ascii?Q?PM/ot3nXY2JrJZhdtMT0tUozceisI+1kCG5Ut8g4RUwHgBDED3VLwynfsWsQ?=
 =?us-ascii?Q?svjJ6et42AfWIxt4ryoOhRCiheZILvABxU0LbZnaqC+U+QJE71PSaogVtRb+?=
 =?us-ascii?Q?T4cTyECLDvLb8Z5m6UwRUfNK5LgR73kL3aFZQdUlbRlkOg5y0ObMPZwS0wuj?=
 =?us-ascii?Q?atwij38agfgh6u1gE4P6Sxwr4yOnUf+QnKsdqNV3mquBNxf8K2GNJQJ8QUOb?=
 =?us-ascii?Q?nhddVOqE0Y+FZMc5F4MX6mbn6TCju5xa?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:26:33.8458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4324256b-bb28-4bcd-a5ca-08dcc598080e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB8102

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


