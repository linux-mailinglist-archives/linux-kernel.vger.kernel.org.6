Return-Path: <linux-kernel+bounces-257001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA649373BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097661C2343D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A5A146591;
	Fri, 19 Jul 2024 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="h+0OM1ZI"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB9145B01;
	Fri, 19 Jul 2024 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368867; cv=fail; b=BnaprXlOg1nHkSCirMYzhaR2vRaWP8ESgJgP8Dflg2rpnMW2GOIEhtZ/pXT9J+9hKX2aYzxl04peaqG2BO0GvPZtm15ZPYV3iLjANrlimmhv+aWymxEKLh0ZfNfjh/3Itj0NUTZ8wSqlKA/sH42dJMCkq38KKmFml56DJaJX8mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368867; c=relaxed/simple;
	bh=pdoQ8UlRIK9EHRyTxZ4VK0qdAdbJgf+zB1P3lVO6iQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nm4ZEAZOsI4rUpOilgu7jGvHaSpHRkAZEC7EjG2SDTjrtZDpVYIIQHsECv4+3z3ymGkN2LMpbn9canxxToeOfK+1yKJgGAYkg8/uWsOH9YCSzSm98fEkpx0pQ5VZXa93h9VWZqeadn4/GPqem35F038CNd6hUhE171UQgl6VhSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=h+0OM1ZI; arc=fail smtp.client-ip=40.107.215.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJ4oWffiCKEtvBbI7BmTO0chKxSZcomcKhUCxvKoNg+CBZUj2tDW84vGjzjSukT31V1MoZ502RVbsW58fRp7YuRnJ6F0VGRUzO1DeKz5qNMOsrWGZdKOPF1GYeL7bGYVV+pk8OS07arH1ya3/Y6kM4V65B2FQR0Ofg+S3LAlYZqaFFnd0OHvbXCFBo8+v0YG/dW7uhzT1S3Jr1I7fQARrVoN3R3kyuDttLS42tbG0STCj00PLfkCtdohEhfpBFXTzVLekjr08H/ty162rRYWDR+b4HlHdH93JU+dijiPRuzyiuswcMeoBFUaaGrUb1L+4OEIWC8GMlj6zBx6CUFcag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/bQfKhYxgR4PXNMn6B+jPqMYJhYuyz0n/Gf4miQ1Nc=;
 b=dvr7AiNwTDmXR+ZX2xkDpKHDUEcnqd8hiJ5uXkuuSoGgGYdTRuMPRCZ6Sfpf0GL//SnN+tNWlNAiMTrB+6DhgxhsZgX2EoAo73d3ZRHuKb1RCY/0xxeZ3hTiq/oN0VQUheWmXcsavsUCeFSQXYBNmxQQNwZ2kDAHBG1yUuVLu9+dK3Bi/hBlD9mvWnhSSgCOMZ5I1XOhBDWZbQuGLXQ5N1+L8aiXF5lYiT1+BGRqnOPOXQKj4HjFj7a+wZXX7JFKnlgbRZq0l8/Gh70zS1zuyh9KS8hQc5OKs3Frd2cei4eeNqitdKnyavMdL+qAg7ruTxy1xI2J+ShwxhgsHeYgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/bQfKhYxgR4PXNMn6B+jPqMYJhYuyz0n/Gf4miQ1Nc=;
 b=h+0OM1ZIT1EOK94EkczD38DycoTJnI75uzmwym2BdiJUeuDZitt7iKqlm1bcxrn6r/Mot9xYi+XuOQZ01OJJ7gb2ZlN7ToOvG5kdtSQn7qIBy3+D9thsOwuafFpj8aNl5ckpN+YogPiX06x10e7IU7Mrr0J0S2yri1yd8yE/NRUJubsRh2ujsfWfJaBlHsH/m/3OKowaMBUcY7snvnuzNd1oSzkZhT+fqzdZlfRoyMRoW9lUWOPdXfBUSpdS4ux1XwEFxv75hSB1f+v703car5/nz6e5fYOQuuDjMGcZ7E2JSNnrkMQMjCKPoZCWFsmTSdXZG+aUg9ONDmLHwqWIWA==
Received: from KL1PR0401CA0032.apcprd04.prod.outlook.com (2603:1096:820:e::19)
 by TY0PR04MB5885.apcprd04.prod.outlook.com (2603:1096:400:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.9; Fri, 19 Jul
 2024 06:01:01 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::fe) by KL1PR0401CA0032.outlook.office365.com
 (2603:1096:820:e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Fri, 19 Jul 2024 06:01:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:01:01
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
Subject: [PATCH v10 26/27] ARM: dts: aspeed: yosemite4: add MP5990 support
Date: Fri, 19 Jul 2024 13:58:55 +0800
Message-Id: <20240719055859.4166887-27-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TY0PR04MB5885:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: afb01f52-099a-46a0-3d7f-08dca7b82adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|34020700016|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9YtGwzeCqHnKtVBtyABN7PiYf3PdBcKO99crbfsQykfH3xV4ZF/Bd09dSbuY?=
 =?us-ascii?Q?NUP9Jso2WoKeUhV9XNDCjWFE9Ni48xoUh9LyDhXte/AcsDMjWMU2k6ugFePW?=
 =?us-ascii?Q?Aey9aJa6ZULivx55Bi+PDWiwERzR4mqDD9a1BxGnu8B2hjPmFK+BOxyjs/Bm?=
 =?us-ascii?Q?u5HalULKpRdm4GSrpO8SakaNhqGqNgDZPoKgSBmKKmsnCt0YonMH1ZpkJHwK?=
 =?us-ascii?Q?Oo7aMzh/dyQF6tyKgk63BhNTPBEz0ZULl4vqEBHh38T5nuPOl3xH6RTnyA2O?=
 =?us-ascii?Q?nHyPvAgKjtpnq12noYK8LxMh7fHkrvwlB69tYjfo5XoPsH5wDnHOYZcueXxU?=
 =?us-ascii?Q?sD659sq21Om2xh7VjRY2DApKc/GsGUl2ynqQ4A+WQdrtqx3Y84JIUOHLJMVD?=
 =?us-ascii?Q?Yy+7WaSz7QXLrPgW5qtb9MGZMjLtk4ppUrUhNZAiDgf4FEqdQtfXw9BYO8jM?=
 =?us-ascii?Q?EWt60eEz+eC28hJMFH0NOiVYd7U/FHvWHEAITPnzt4xCSNgczAO8VVCddXT6?=
 =?us-ascii?Q?Z7OPLBUOtu/oFQ588wat2r0VkOP8xt8E1UkeONo5O1A1L20FdRhMxmTuXcEc?=
 =?us-ascii?Q?XDKkRe8H6JoPJl5z7BPd+/zFr1WfASXeKC7iXWx2KWtwxg11M39xD5Tl8gRD?=
 =?us-ascii?Q?ajo1318lDKzYlP5osSz2tmRBi481aXqVJvRgLcPhB9GzrjKfMd/n3BVqtQ9w?=
 =?us-ascii?Q?nfN0GTNkeiHjToNHnvFd6LtH50DHmKbdD4212DNavcner7ZogUbKUeEcgNnH?=
 =?us-ascii?Q?CyP8NH6ipMi5HwmKsO3gDDLmDsula/e264ddZdifzED+yoMKy0a5eMeG0pOw?=
 =?us-ascii?Q?uiMric7FCzXHQ6XX8/nHxgk6gr7OziHbynRsiPTmg15szFVdyHXlRxcjmfoJ?=
 =?us-ascii?Q?AxIOqJz8cMSVEOUfgJlYwenDnSXUtJ05p9h9Tu+4tkwFKiD2Uprw3Ih21PhL?=
 =?us-ascii?Q?13WcIhdO9sTMBLbp1wlUjypVa72sksu5YO3J+n+qqzvBy2ZKq+ZpxP/B9EvE?=
 =?us-ascii?Q?R1XUVP+BAp8hJbeZ3vypkM9dv8p88Hh+c65VndiO6BptvtqVF/DjiCDNkwAW?=
 =?us-ascii?Q?TZVWAD2Zh0W6g4XmGUHd1RmztEdQszPEE1nO6hw23bu7hOlwslS+OnCpV9HZ?=
 =?us-ascii?Q?dhhpXNMkpWMfo9N47or34cZJMDbxThji1PWqIkIJnkCk/wGYuvgqPOzClYeA?=
 =?us-ascii?Q?neCcKnV7ua1qDebKwaprvv2DmK8StNbQxfIT+ki2gotfabQgYUEhMEuwQz+5?=
 =?us-ascii?Q?JWt+E8eTgot8PsMPoB9N05MHh77FGStQLR/igtKh4aha7B1q8FY+v/4lhXrg?=
 =?us-ascii?Q?wEvDeQBoV12Q/bXKBzq0DQNT7D/jpR90hWdz20ZcKJZgWOBMx2rlAVuyPAXj?=
 =?us-ascii?Q?bYgTd5dslvXocrb4ARmcdp42aBBsor3dXBzZT9yRqTobjswJdv0uDurEfVWX?=
 =?us-ascii?Q?Sulil7PcQHsO/JJ3TB2FGoxBpI5euLv8?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(34020700016)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:01:01.2362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb01f52-099a-46a0-3d7f-08dca7b82adf
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5885

Add MP5990 in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b0eb38f9aa7e..7ad080e3f432 100644
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


