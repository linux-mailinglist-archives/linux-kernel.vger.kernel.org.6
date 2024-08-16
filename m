Return-Path: <linux-kernel+bounces-289392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9AA9545C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EAA1F291D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6D2BA33;
	Fri, 16 Aug 2024 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="wqgXS2vJ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2061.outbound.protection.outlook.com [40.107.117.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85FB15B57C;
	Fri, 16 Aug 2024 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800391; cv=fail; b=A8oHELpU9RhOD4G0Z8M/j5Rz86LVIlnz7LUxQ0/h0yoCUKrpLKNb3HsHOciGGWtIxr0HdWl5rRFYWR9NZpS/xu4OUPQBGwK/rQmvh4+7x0t82rUIRpCRIAzByVdEkly4uUdHkiZDE43L6JarujesdfMaJUMJlUCR89Dni02bAyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800391; c=relaxed/simple;
	bh=PfdifsAGi8tVEbQhQBk/QLDU4FcIeWEIdnzHhekGd9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rM/Pg+b9Mhm5W9WZf/zUd14/2tfiF7lFORM/gF4Tu8aG0TJs6uoB6b/NS7jh3bFNeQclO9+QHJyFzVChbnq1BqiJovsVye2cFz0SW6/SZV7ylpr7WknMlAkzGAeLJ+UPkPlo0zOYUizEYg/twWz6kwkQ1/Gd3Y0+krRRLWEMq/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=wqgXS2vJ; arc=fail smtp.client-ip=40.107.117.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiU5FzCpp77PLhs7ptBf98xalvty+eaVBP0z5eiGbY6iQVGesbTUNeizjfRPzwKsHM7xsKnXoNarhbBTkuB5VPbWYc3DyR37RCDdJ+7WA6+U5W6Sx3PCVp3SwhwwB28H+WTq0jfYbRhM1ScZwprIfuNZV8YatSvEAcMJXyz9PhIZl1agVJ6KeN+hqL+DP8aij7EbkZDkU1aNmU2MHXW6D968665hu++Vw+e33vwH1dFZYpqox/xY17KLcawxzoWW+WsYU2VQtQVegQWVE1/+08GGvm5AaEwKJYsqdWQd2Og5KdD7bbx11j1btMQpmrL88BYM8wKbmN0M3vUzAt/CUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGEY6kFHCr93vzQaG19EtYDkCI9Rttn+5U+iGfkqrRQ=;
 b=h9/g2iaKEesy4goiFdlrmspOoThXWxmQ8O/TuiclMHuh+hsotOpHWQ5YuObB/4TfwlYLTT7O9KhSdr41zAVPo2jZ/jzYLCQttODu5hnQgP0bJxof1d7cETgVTWZJ2XXUCgRdNkDHLW/XgT1ELqHXcsz+JTTYLS7V2IPIQoo7VozYRHLqk7iT0Xh+ky8gcLKkx5T4W+macrBmeUMuWKqK42MwUsl+dujyvf9glyW+JNd535bVdIoi5cUjLJYmIz9/XYMePh/ONiGxLdt5ZMQkgXurzoCeri1Nytwx2yPxEePMoj453h5Vlj6/VBDldSx+058MQSrKuiFdA5YateNl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGEY6kFHCr93vzQaG19EtYDkCI9Rttn+5U+iGfkqrRQ=;
 b=wqgXS2vJHigimROHRcvqjohvMHbRwRAQXTifJX+hgqr5eSegKT4Joqyz8j7IqQMpUcW7Cqjh2MKN9npQ2Y/AkKJbbFVcEh6OGyiFMvdXku637sWvI8tRblhM/oFH4G6Fd9lfQ7GIXXB7/sOZF+GsqgfUanlEYxyhKtAwPQ4z5NONDqWSmDkUmjGTsY4iEvTOuK2E4x/DpJsgsQ+uq88+0ERQOvodEgwUhOO3zRLWYFKex28Movtp/wuLZdAnQ/KyY7p78NpZ8LiorNp2wPWgmm5fpR+EpEpmi1HGUJjrFFBp0kPC+PlKsO53Lg8TxhsOEKz4hXiLWgSnj3ouhpCTmA==
Received: from SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) by TYZPR04MB5757.apcprd04.prod.outlook.com
 (2603:1096:400:1fa::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:26:24 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::a) by SI2PR01CA0041.outlook.office365.com
 (2603:1096:4:193::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:26:22
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
Subject: [PATCH v12 26/28] ARM: dts: aspeed: yosemite4: add MP5990 support
Date: Fri, 16 Aug 2024 17:24:13 +0800
Message-Id: <20240816092417.3651434-27-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|TYZPR04MB5757:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 06dd025c-e0ca-4fd5-7711-08dcbdd57eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HgSi4ykrVy1brS3fTM+3P7jUg4vBStiHpEsYbmBM82ci0Fk0qWhynP6zg2Yj?=
 =?us-ascii?Q?yVVl24YTcD4Jd06fq72AjgqawUXeTUkOu9bXWtljLFK+N08+yqkXYcjceTZH?=
 =?us-ascii?Q?9P3tVdZylpmprpwoxwj77rF76vYHlNKoltbH7eCYZ6ssFWn1l6FmeCBmkW6Q?=
 =?us-ascii?Q?ZoYMz+nuH8rEs2H5B0Ke3mIWtrUT7RlZvuqnnVKz9JTJCDS/01Fjbg0Z0Ayk?=
 =?us-ascii?Q?K18akhu2rvoeiffh4r4mPBlsH+uXDpTF8YxfZWPRl93CwWhneWKFj0ZrR10C?=
 =?us-ascii?Q?Yvw57E9K1mGGk43SIc9gAgLJB5dnrXcleFg89Z+aKsFracFO4CpJgJCos6Pi?=
 =?us-ascii?Q?W1z8K6JwxnPty8xMVk6KfEu7HNetQhAvH9pmku0Y39GYMxiKBozh9IprGoJ9?=
 =?us-ascii?Q?JASvWKFzcNqV6q1tnMQbUsT/wkLzh6iVVVRKtxZGamTQ9v8VcFhTeBry1+s4?=
 =?us-ascii?Q?tQ+0MX4ip274huqZWG5mB1ZmclxjeWjwGmaqPrE31OdipMK3+uau+tlo2O0O?=
 =?us-ascii?Q?JNWFf+6f0fTy0hVHhL47aavlPU49f4gQ6ZtHU70ogp1Ubh7Nx0HyywLdECPd?=
 =?us-ascii?Q?1ojFESMlsVzplK855JCO0G5Aj46S7NRUk+BDEcyWB8dT4RyIe/7BpVFuZiAw?=
 =?us-ascii?Q?uxoAt7GhnJ55Rslx8yCYXQHSqWaW4aifsyJEnJf7iRCWeh6EM04Te3NnXM8d?=
 =?us-ascii?Q?BjkE4VPqLrpYy05IZggeP615CS6I6Bb/2EEXHOINNhrZ3tvmKwWWHjdc7csa?=
 =?us-ascii?Q?EFE+8xOafIQKMH2OOm5Pn6SH9BrJCQh4JCQbpaN6IH7PMMEc+wrI/yBZ8wrf?=
 =?us-ascii?Q?TWZIcPPqnRDahj80FBsGIHkHBrwG5djIIAPZFf4b5mFS3uclGv4V4dWaGOHI?=
 =?us-ascii?Q?39rKq+flwFWJYZbpYfxhhLEYfsqzOqoIiiRhu8eeyVTa8hd1BPvoKV9KTMEW?=
 =?us-ascii?Q?b9y9GSe+x2sD5gOiKUPTG9ZSnOyKroH/VzrwunJlZuFPSOguIfDSWZJniw8f?=
 =?us-ascii?Q?MmGBDIlDNuXZtAm9WKvgcrvmK9idnuMygQROt0QdI+AMJJ4CvuQzd9+8aucL?=
 =?us-ascii?Q?NcqZF5UupCM+wummX0loMORgdkBbph7mAqhfQa85X4a30Q/xnTLp2R6pSoZk?=
 =?us-ascii?Q?OaTRaeSBR8XbcPUVLhmgOG9CTiGMjN7LA3HBjZFa+88EzhirjDp/a7zGer4T?=
 =?us-ascii?Q?x9HQx6B+yA1lJQKXtDzJMgl/cz0Aldz3Xj3RnyewkhLg9VjlQ7UToXU/lHjy?=
 =?us-ascii?Q?QWkndcgYHwW0OpGj0OH60q4oSBCe+GyU+xGaabGuxIuFj9SuN7M5/aSWovvw?=
 =?us-ascii?Q?H3Jkk4dC3um4WJ1hyYi6ZSlXrRFzV+WeMUX+DlTKd5EL0099iVa13C1w+4Pc?=
 =?us-ascii?Q?Gy3K8WlgNwE3zNNNBbmhFnY9XEMbcjqOcWy8j24owI9pWA9XoZeHw5bo+Xe6?=
 =?us-ascii?Q?fJv+CE+BoFy/zZKoFD3gsJIZTICnXZLd?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:26:22.9347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dd025c-e0ca-4fd5-7711-08dcbdd57eb9
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5757

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


