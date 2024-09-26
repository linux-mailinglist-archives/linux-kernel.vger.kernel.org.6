Return-Path: <linux-kernel+bounces-339778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FE3986A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D651F225DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34043170A07;
	Thu, 26 Sep 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="j//TLb/a"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011053.outbound.protection.outlook.com [52.101.129.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE94A3E;
	Thu, 26 Sep 2024 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314466; cv=fail; b=g8N58P7F09PdBqjtoTKoehz3596143lIoCcxEFGLgmexll694f+PCDza3VMo03vtIxybH/Una3aIo+0O0oOTUeu4XiMTerMjE7y3GIXV0QKdXLjFGMJHr/wGHDx2T244u/QaKd8kjG+q9+LP+WByzg2ELPjb35+o8+28GRnAZzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314466; c=relaxed/simple;
	bh=qKTPZYs1r/6kjfFI+exDeby+GM0qTUny6fCun+SLsPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nrnXwWA5DwReuwQZTH7IGxbSJf9f80LVW0UKJxaUfiZmyo682JmijfPALiynRLrMjYVGI/lojJxDwN23Yih+4s+r5QhTXe092DsUA8IhE1gRcTrpG6Yua1XHmfuSYbQfXkGTMtm4thRS9Lw/hHZtyjAjjaiJTsG4Qbpo0bkH0Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=j//TLb/a; arc=fail smtp.client-ip=52.101.129.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwPsNL07I1E82fRP2XXpDhFF6qMCWu/R6oeA8rmNrdvwc4loHR+H2nr/OkiI0991emovJpdWfgHFoxTIhI1lqTSnQA8vgXA7m8iEI8+q/NbD6n8xFn+vHdIGFw59TMQNrkNvc6Uaq+nnRJ2LvhRPSCWYZMJZ5hvi2/hWkJultc2EWLbBQH3dZDw0Z3MbkhJUK13dYH+nu7NvtNMYbyc8HvA6/nlMIJ2IPYPCr7vfXWXni3gfV+S2RiJPWe3J+cCdwmmNaRpF4zSLNhpN8yKtLVOCQ2Q3Aw8HGZlIzP0PROCKxfz2kx7SWjQLjZ+1NZhGwObHrhPNcgja8uNOzPHQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2TDy7iOdR/wUjJFHM2RR1HQM9QvSX9Swk7w0/MPqEA=;
 b=xS+Q2ZWvcCVeIIHr5P+Vp7jBeBSBpHHrcc1NDKimUDegPJtoeUaylo03gA1t3KG0Q4FlvlJvsjWtXd1iRhpaz2nr74qCxyKkVYP3SejWtMRAA0Sf+novtbNiO7eMTf4f+uiqhQkuqLoyPRRvKsT8MKCw2vMFYALzOtwz4biJbt3gv9FabvvwL8xOZ8unPu86GJfgGbSrWnsgm9CJvt9Z3UqeHrQn91ZKFU9rikZOd0e6y4wjW+FchzCLIY+Ts16IZhixaDoOFV4D6VgxrtXj57sSPh18C65CtQW3wZy2Rd28DFckX34FoDCojtaKdm7Pj5dfXiatiA7/0Tsb+zqHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2TDy7iOdR/wUjJFHM2RR1HQM9QvSX9Swk7w0/MPqEA=;
 b=j//TLb/aHiEgsH9NZB2sEU1hyhVhDnJUHBO3PznM9kmDvh+v0vGwhfdmOpUX2NNZoREBZUOszOCfv1ofK9gnFRJ1ccmTC6eA21Xo6x8cyrQkkm2fcu8Fv/FTFz+Hcj0hoeAJmSxTpjTJiOQh78PAcfYpvHGjEXF+2LCESq1wUawpiktrJzsXAUiDRrm1sgUvK/q9PpaeuQVKpRp2i357lYMEYEhtdZeshv5WIu+6Bq1t0/sO9FR34YNEKZT7FfU9e7dhGJi3UwUeM//Hn0wS3+1QVTgkmkhRReLQ1yeRLR+9hSOfVoDXmkG6ZBP2L0GqIxoiOGsP6doMGKybSOn6Uw==
Received: from SGBP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::25) by
 SEYPR04MB6555.apcprd04.prod.outlook.com (2603:1096:101:b9::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.20; Thu, 26 Sep 2024 01:34:16 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:b0:cafe::15) by SGBP274CA0013.outlook.office365.com
 (2603:1096:4:b0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Thu, 26 Sep 2024 01:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server id 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024
 01:34:14 +0000
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
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compatible string of adm1272
Date: Thu, 26 Sep 2024 09:34:10 +0800
Message-Id: <20240926013411.3701546-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|SEYPR04MB6555:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2322b598-5295-41fc-c3a6-08dcddcb54fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TaqZl/pwXb21WWsmNY5xtxuvmp/CGumbrjLh1+j77Z1pJbjbYItFu+/cwY6K?=
 =?us-ascii?Q?jU0pFtBBK1AZz/E0dOtRPgmc5XHjSW1L1pr4fie4PG/6aI60etq9q++VQ94m?=
 =?us-ascii?Q?e9rrEO7jgaygDddsruYI2ZtblcVEv0CVsNSdUhO1RaS8VcUi3GcrECe3X5R8?=
 =?us-ascii?Q?ryp4Ur1k1UmN9wfQSIuLR2RSGV3jouAk+goDKupkr/5kBmk7ymZPW+kaliwz?=
 =?us-ascii?Q?35hExpqj/xUfT86KYq+S7CyvbjAGgLy1TJAPxpfsCW6NTvIYtrwWovCzQHAs?=
 =?us-ascii?Q?hYp8iey91EuP+srui70Dv9zQdUI8QpNe/xDba1fDMZcp8RRqWgWGZecakhy1?=
 =?us-ascii?Q?cgm7/ULnVgVJCBdGXV5rQqoZ1AIr9B8XQkrhCSuZqB8hDu2fld+Gf4myY8Ki?=
 =?us-ascii?Q?n7lbMO52AmOn+GSe74jOlTwtzkzl/wlW96wOJqaHAQyZ8Kftb64rNeKycVf3?=
 =?us-ascii?Q?sF7V+DzPs9VhDp2NmErkvl/25BdaLgmaeY1pivNMX1nPubtjz+UXumGw0eh/?=
 =?us-ascii?Q?5ihrZU6qzIkhtrlBFI1VwMdX0yiztVxuj9Xd+5ZrbexCCyuHKAn6eQLdIWpz?=
 =?us-ascii?Q?dCPB/jUrtPgeS8K+114qghUOhld7jQRyHso1PB0zq6j+ZA/F7fs8cu6SHgH3?=
 =?us-ascii?Q?bN3R/AGIVZCIPltft1FwS7+B1ijv/qdlGjUiI+2mKeJtkYJK50X8jtsAFxjn?=
 =?us-ascii?Q?sm85TVKK7rDR5jwI9zFAfZMzZXDfiHaOxn4yqtXFjFWbniXOD45jKo1mBDdz?=
 =?us-ascii?Q?ng3Rgt5PXIqkvwejNCw7l2JVbM82bzObdI/nlU28vArxla1DwortAGqHt4T7?=
 =?us-ascii?Q?XEsTwHDSvkdjVXgY0abpu9BlxhNXgDlnpcprvgrAU1XVi+OcOlI9Bmh1WCrA?=
 =?us-ascii?Q?shAmcxpGaAyK0CBmFVhsM+DuDLRhsqlnuDwcbdwi0U79hSFItGvFSGoAnd14?=
 =?us-ascii?Q?L89Qil1vGpjCY3a9M7C9lP4mEaVLYo/Izbp1UGU2i45hjdq29z8AdCMCNkxh?=
 =?us-ascii?Q?z9+0ywsmZY6w3dOJz7SaihAcewM8S61B1WNWTQgLaCuBINoT2B7JZgDNhs6K?=
 =?us-ascii?Q?g/eyqOBqRoC49Hfa1toPhnX0T2mZhySuksXtozzJEtxGiqlCChofpVfAeHSq?=
 =?us-ascii?Q?XL7ljzgfGzA2VMqI7gZYHB9dVgEEUJJhQ1KpsEl5cnlRO9bHPz8cutneH0JG?=
 =?us-ascii?Q?6EiMq63ov2YES43gpnOdWfYz0mSrIDVDxPnvGOcWZWfR5xCNgB06e2mNXifp?=
 =?us-ascii?Q?8pR18n4d+P5VQ2I9QNASx1HnfzHcAb9Bcc28+kpTc5bvZhdplCB5u4gJMvG2?=
 =?us-ascii?Q?7cctu9Os+G/6NPlARgfJtLomWzEcDUEi1sh7stzKXm2j+g9aAiT+ohmV9foN?=
 =?us-ascii?Q?WE/8ObvA/oBl038ytIvQp+KvBoCJ/F3PzsYpBfqVHDPJ52El39FKZan3+ia1?=
 =?us-ascii?Q?y5Iwro7cStO3PmSWPRx0Niu1CVO3f8iJ?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 01:34:14.5996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2322b598-5295-41fc-c3a6-08dcddcb54fb
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6555

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Remove the redundant space in the compatible string of adm1272.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..7ed76cd4fd2d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -284,12 +284,12 @@ &i2c10 {
 &i2c11 {
 	status = "okay";
 	power-sensor@10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
 	power-sensor@12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
-- 
2.25.1


