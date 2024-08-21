Return-Path: <linux-kernel+bounces-295269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11E5959930
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577EB284E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA2200991;
	Wed, 21 Aug 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="pF3mt6aM"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062.outbound.protection.outlook.com [40.107.255.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A85200977;
	Wed, 21 Aug 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233409; cv=fail; b=Sz420BrBWseTyP6QZrpQp/3yVr3yfMbCuvGoAPpUEFEeDOyFCIpp8mU0HBFLjzZ9E23admiqDenQAamh9nOdqW12cp5uHZlgz1PlDdEW5APMJM1knjtkqGFPwg6C7DKBVgNwLsVX3NEe+cppk90WHK/k8obHnZb7XZV4XCQDCho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233409; c=relaxed/simple;
	bh=PfdifsAGi8tVEbQhQBk/QLDU4FcIeWEIdnzHhekGd9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDGaQfodru3OfsrnC4jWVCYE4UEi12FJhx+E4l99LfZw1I9kQV1GbJcM3PKxYby1r3p2dRiyuZ5O4GiZpW0h+gFn3vzAd9o2WAhBTkl8Omkv4qETiDGxp1LBwukK/xxZe3gDToBeqRSO58ngIAue7SCzo8Jgkl2ygBVyPW3AsiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=pF3mt6aM; arc=fail smtp.client-ip=40.107.255.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftKToEFBjn9tFV4Ljx+mvMjdNEIheVy5Kw80hvW6i+vkG2EQLfAeffcN1dTbO7CK1amMaswX/MXsxJTL104P1Tao5rzcF2uxBs8qM0n5FDcXeWs7pg6uRp1g1tgqIiJ8PRvTOtE399FF3e9R2liT0tpAlkQ5IOKf2sL7kCwCpytrxY1z2wnyVkNeKY7gf5GGQj8ySmBKeMsttYmnCIPxaTI2EBtVNQxIA620QUykAIKljA6rBvVmw+kbeMg5vmgdPFTwJPSLxhi/uXb15Oifv/SuyLtXD8ongSkhn5tRd7WfNCHLO3OTGIKQBX8b0EnIIYt9MzueYUqCYy3zDapRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGEY6kFHCr93vzQaG19EtYDkCI9Rttn+5U+iGfkqrRQ=;
 b=op91nr7QVKLnhoUzYWftSE5Zj9LcTH7PWMyDgTNPSBhh1aHp/jkTDb8p96lpdssUfBNi8iZ2nKodtIo6E0hBEHJYnj3wRzEagPVReDEjV9EEQE1iaEXPZhUOyIOu2AUI4vP1gD0LitolWSzb/CD+LMCY659L17m3Zuc/Y91cDoVXqllGt2qO681ayfqlCecAWMrxetjOw5LqYd5HdZ7gaFbUMUL7RiW3DI+pGS136TcBLQ4ZmNiBGqIuC9/RWCSyDrJqd7MwsPJuz+u1G7s6xbO8msg8oCDOhIhMvSljVFCqu36sL1lOIhNdxXlPwLEkIM8A+Ow2o7QjUCTZZ4jG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGEY6kFHCr93vzQaG19EtYDkCI9Rttn+5U+iGfkqrRQ=;
 b=pF3mt6aM1lGWqLN6BgclFR/iT5VKHfFIIjmdS7MBFUWWbN7aZ53qoC4q9o3opHfrUV7s9uN0zVzdV8fJfMIqEJOIlzkTSosImkLXoMl25qSrWzCfaLWq93St86KjDoHiQph5zd0Ai86AtL+uelyi54EKBz/VVp7YL6SQ+6dEAazuI/iemKnjqw8rVCQEQ7ZS9wzGE/7LWBnoiZXatQrO/Xx6GnLNCG3knvZHKmtyDUB4kL8bmXKvls0wMdMKqi9hNAQES7J7QUCG15skeU6uKVR5vFbLJgDpa7Z8Gq6v5KKU2LEg0uFpCxjcCXHkbGlMjfSXcLdaC2G7lPr64Z3lgA==
Received: from SI2PR02CA0026.apcprd02.prod.outlook.com (2603:1096:4:195::19)
 by PUZPR04MB6293.apcprd04.prod.outlook.com (2603:1096:301:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 09:43:22 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::88) by SI2PR02CA0026.outlook.office365.com
 (2603:1096:4:195::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Wed, 21 Aug 2024 09:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:43:21 +0000
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
Subject: [PATCH v13 26/29] ARM: dts: aspeed: yosemite4: add MP5990 support
Date: Wed, 21 Aug 2024 17:40:37 +0800
Message-Id: <20240821094043.4126132-27-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|PUZPR04MB6293:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c7f2c9ca-2c77-47ce-767b-08dcc1c5b24f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XsnDyeY4NOJVTsHffSzmSpnPvyBnsyulqw3Toe+8MULT2i1wnlNxeFWjo1B/?=
 =?us-ascii?Q?yRVUIodZa3XL6Bi6T1Hyv1MKPmAJJCGKsAbUMKdiB1JFkvvMwM9HR3BKYz+b?=
 =?us-ascii?Q?Jx7UZwPMT9vjn9zmuHWBwloX5JdXzOu7qO27LjMG6T0oKd4WaeyqxbLsiO1d?=
 =?us-ascii?Q?g6aFTvn39q4XxwPl/sc2GK1EQZeEFPaWVwJRx/tZxS3wakQoP6JQNByKEGan?=
 =?us-ascii?Q?K4QqUaBJaC8rJwgGfqtcDTvxY7BQ9NT7dupbwPJKEIzJh8b4ZnDKmdlquObF?=
 =?us-ascii?Q?Niw8ay1TVFEbP38YgsadcccLdQOJxBhlIwQr5Fe/Bsw7aFP6SI7d2Xf/3PYi?=
 =?us-ascii?Q?cTtiGEmdrynJpymoT9Xd5fzXTPpBFGjtMwXGvrayJ4jtJO+TP96FGu2c+ZFS?=
 =?us-ascii?Q?JbCqxV5fmWXioMmLepjslrQpRfDlcJ31SUPtvO/YJ9MAUJTaQnZ55ZN1Hnu3?=
 =?us-ascii?Q?qfqTdnbEenULtQfw1SkQuq3YooosNxcj0oGk6+77PDkJPKiPUM3T5cP7GrVb?=
 =?us-ascii?Q?itrxu4XSqr3tDSt4edhBCNIikd3u2+Yd+07OjKGsLQV6uww0oH9HjslmHwFL?=
 =?us-ascii?Q?wy0b7vBOXGFPqAdjEMtCL8Mw8Ovrt/MG41y7s7jHjmtGCG/jhRgJtFDVxs+o?=
 =?us-ascii?Q?9lMmfJOIe2QzVWN911qJk+PbourSXdZUOckJ7Cep+uY0hn4pFNaR56NKutYz?=
 =?us-ascii?Q?Qkn+Y3P19ivTUrJ/QItx4wOJo2ph7yEGNbzFx1e5ksuWbSuYu5j6AAse/9WL?=
 =?us-ascii?Q?Pisc5KdJqYc63+7YJC/N6F07yzvWrlvbeqNmGgy04NZR++uD+WrpvKAwQtjd?=
 =?us-ascii?Q?32iX3gCK2Lan9SfqYLup4m57yP5ZmuLUEjCOEyH6VaDus24AiEeOs43BzNbe?=
 =?us-ascii?Q?7UhJwppllZxHf+rzlCuF2FiqXiI7IFCukQYF+JXqr1C9MZU4xL91AdDE5IdU?=
 =?us-ascii?Q?KhKp8vgHwu/sdbIEP2lr/YN+I1uTOUDasGMKEz7xizTiAj4w3QTHDL4cFPSC?=
 =?us-ascii?Q?ZyjyVsArutV1VFPc1SQHg/NHPSdFkZQPjGMuH7hJFLHJ8z8bX5XMcTaa5cIh?=
 =?us-ascii?Q?Dv5zc77F7Wwjon8ebAgyBmyPiJh4fupKpycvR6KLtRXL3qrM1KQLJgcMtKIi?=
 =?us-ascii?Q?YliyouDKEwg9ORCZaTno/DtCmU9OuB+LE3Rm3gM0vidimfkrd57OToYolD2N?=
 =?us-ascii?Q?8IPMKsr189x7Xc85mk1F688EXDDCmQEtFXvXtJLcmVddUk+al7tTi1b41Niq?=
 =?us-ascii?Q?nYscmcvHNmKQiewtDwo/tMC50mUaN1cnAccvtJ/sB/FVG0EoUaU8ZEoT/RUr?=
 =?us-ascii?Q?6+gfCmlU8c6TS+PxGiUQwt+nirH7cM89zM79p9G+/gIJEOJjMJJAhHTcvRto?=
 =?us-ascii?Q?/6ntPHHBzM0U+PzbKwTVUKmAztnLT4DtpOTzqNgWthqssy1rZ3kGKyt2Wnwm?=
 =?us-ascii?Q?W1Wf8GfSGqmfID2VKTsVJgi4EssCPi+0?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:43:21.7319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f2c9ca-2c77-47ce-767b-08dcc1c5b24f
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6293

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


