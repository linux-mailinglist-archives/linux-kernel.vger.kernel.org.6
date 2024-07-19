Return-Path: <linux-kernel+bounces-256983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED95937391
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 793AAB21EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755447BAE3;
	Fri, 19 Jul 2024 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="KTfJznwq"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2082.outbound.protection.outlook.com [40.107.117.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3279B96;
	Fri, 19 Jul 2024 05:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368793; cv=fail; b=NNAxyqiLQOEmhfL4VEdop7bTvhXX2GzRraWuhmjh/ae6LZBUMFLry0wkIwwUnBUJUvCrd003AL7446c+0CV9OO9ibbtM1K5dD1M+jHVnvxR8ec6DpPoH+SwyAY7yO03zz0ZIyT3TULgMVHfu0wWKTMDSw4BHO2FGaIyMbEUOOYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368793; c=relaxed/simple;
	bh=AzUdi0zJNRywe/hzeEuDOFHkQ4MQRZ8PHccKu/FaOKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMy/MEPVV5K0ZJX+yBpL69xogKUiCkGoMyUQOdAL6hR6h+IgrTaXSTesP0ezqn1ZA6GO88P9WN3ir6/0y0THyLRmKujjXkYEDeG3UANjp+Bdlxa2BhL6dtI3/PLJbw+K3aLZMF//fTL3BmGX3v+voZkAt8G8YUyW7MKWRLZQtJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=KTfJznwq; arc=fail smtp.client-ip=40.107.117.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+/VkcvTYaHIFbl+ZnJRkWjsK5peVPV8J3mncy0/2AaURT42XOq+XxAotnorq8u4Vr/rdH8rh0LOjaOPPBM3Fnn8exeO8xL6EhLJs1oVDcVAyLTDH7xtSf0lnOszPipc2H414rsARjNXPfBUkh4CRpc9XKbqDOhsiDr9rKB1hdqCMBN+tZ93319jLHAgVi/85pLrnwGWky9U0XpeKTKYGK4JoSDtismwZmVIFDAfXpNwu5ps53MYPY2TmganxEfupeUln3+zPUcpoLyajm/dX/iFyq2It6ReQ1NAMXK3SOFNDTrIZptatzIDk3D4ctWfLKKcXXeYhMs4rSAcUDhnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HypuHXBWroWYlUbZ7+/af+Usbe6kheKPtiyQQytzoQE=;
 b=vbInBH9SrJHcjQW9bUu+xZu37pliZ8w2HqoktFgRtXY8qjjyA0opHerQ40eFcmQhaY8zrpn1Xs/8t2h2ELlijuFVaryyexJOZZEXHESd3ZibEBS05ptSSD/DGDNh585DuUUyAgkHawuct5voJxXInBgI6qWKuzMRRa3UYOLZwfJNp+WjrZ2KdxqcU+I31l9oCrI5VzVD1VYBJ/I8r24RGof0o/NxzghDSV1sEdoVWuR4lzZVQLWujrC7YNHnHdAfsGTCh74az1OpOXG+Gt1ShA+K4Y9+Rh64mjHuBSDHCG6FD4rLSyULPuf0GnxG1eUb8BHpgaORCRPBDI3o1/V3vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HypuHXBWroWYlUbZ7+/af+Usbe6kheKPtiyQQytzoQE=;
 b=KTfJznwqJF6CF1gPhSZujRDdYYD4YFcTPnxQVxu1t5vpAiK0Oe8YFt6kRaoMEn9ygP8KljfLG5OZDp7PJ0a+HeRh7xqwccaJuY8nMeZKVmeOvezc33Re52v9ySGgK2Dixvs3c4tnr4CxRvRl5219jfRmEFUg+VuJ7zE2Jj1kfwZr3Wn8lvzxqjU+mJW2bSBfIlYn5XUalhuBeSxNAaFOH7J3f6Oz9rTBxUFT4iycKm2vXpUe5x10RM7SNchStAMkm9WVy5AdvN7SgRmoxEZYKTZY6WrQo1OAi8BYwSfsElfp8JzDAz9XjsiwG+Ln24bPGUv+/4zHLqVlFKJlCq6ZCw==
Received: from KL1PR0401CA0029.apcprd04.prod.outlook.com (2603:1096:820:e::16)
 by OSQPR04MB7911.apcprd04.prod.outlook.com (2603:1096:604:293::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13; Fri, 19 Jul
 2024 05:59:48 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::67) by KL1PR0401CA0029.outlook.office365.com
 (2603:1096:820:e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Fri, 19 Jul 2024 05:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 05:59:47
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
Subject: [PATCH v10 08/27] ARM: dts: aspeed: yosemite4: Remove space for adm1272 compatible
Date: Fri, 19 Jul 2024 13:58:37 +0800
Message-Id: <20240719055859.4166887-9-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|OSQPR04MB7911:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c63fc995-0092-4bfc-3d70-08dca7b7fee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|34020700016|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A84s9xx8gg16akSghqKo+7PltLuYHbOykUVlIuXkIPzsNnHSA3zhB03HsNal?=
 =?us-ascii?Q?raDuO1wIwtl/6BA50v3VOq2gtPMckvGr5sDDlVLMD7z/1IeaUtQzVEk9sPne?=
 =?us-ascii?Q?rdyQLbej36uTtnVxPhTeASwe/6yERGVL6qJk6I7apkqE3s+wvNPyvtWtb0mP?=
 =?us-ascii?Q?IE0vNLhBLycMnVqD4IFJr+XQKyL++M4uRak4edxTbyefXFayM/5IkdVuwtb+?=
 =?us-ascii?Q?BOVqqR625pYcpJsGohdPTZZeHMSZSe7dYuyH5IeEkrpfSCh9kslVWL9WUsPy?=
 =?us-ascii?Q?fPFRhd5LbR0h3ceDVNEicQfn52r3tj0oALmLwsJNotvryOmKI+Ku1wDy8rc1?=
 =?us-ascii?Q?jwjvMOUGcRnV+F2UJbAMGIS9Vgwaph7FnHOfXNPMbKiuJjnBV7NGfHGI2oU0?=
 =?us-ascii?Q?xfqZs3QRl/xpmmtmytjmV3fe5xMKDPkyteOovtvcLD4qL56EP8HpgmPcn9S0?=
 =?us-ascii?Q?ejDOjrsvGR8Ph8lnFL3AQlot7fQWSVuU9qt5O/sk//yk4UpYxb0tKyO/fz7p?=
 =?us-ascii?Q?AJLl6ycmgB/XXvVAQ/OCcdmKaosvCbAy7NergZLY5VbUp4mYxtxj6FAdeEp/?=
 =?us-ascii?Q?iZGtWPEw7dXQvknU4T03/3nSyRMGpktdDVHzYlPEWCo+sCPmtwQutIjrHrjl?=
 =?us-ascii?Q?jYBvu+3ohA4/Fda+wmUCu87X3XjA7bFEYyIDKWLv0S9/gek1zHg23Ie9OFzE?=
 =?us-ascii?Q?D7RYo3B3ctuKyStn39VztNGFWvQNJfADMp4fEmhm9RC1i3p8EBJ2kZZkICZR?=
 =?us-ascii?Q?ydQBbco9WJeDvZwE5Vq3T1WkzZbzyD7I0rHBxRAdIfY1ON/Pgfiag9T4/hq7?=
 =?us-ascii?Q?v+sIdaCcZgCxgfNaSWtff42CdQ14kpW5UWDhfGnugqsmM6/YU8fy4TrFJMqo?=
 =?us-ascii?Q?N28BTWRxM4OtsiP2sj8ekdDfeevT0jYIjt8bQPchce2nO8lJoOaQKrWuWYVq?=
 =?us-ascii?Q?FeGumCN8aCZIopPoy2lKfipbmxdVJYgTVKdRSwPpm3NXoa6eNo5v65nQpU/Y?=
 =?us-ascii?Q?nVaroFdSgGps5mjMSg4DhVIK4/iiTjOhMRVXTAOJAJ8uMrhHKtBfI8+CZ3Qf?=
 =?us-ascii?Q?4DP5NIPJTxrFfSVOjLIF5elmu9kVdjEtpHTLNBqtqpKkh/n4equCuSRXQGGA?=
 =?us-ascii?Q?pTYSutUUDs4U8MUtZ4FbMTwlQBEtMtHRN6G7hR7FYj0xhZ/lz8xiviP8bJbA?=
 =?us-ascii?Q?BG3bIIUqFEaO/78qgLR4i+nfar8qkucVjSqWjx6Ob68tlr4prTOM0d2UTP5a?=
 =?us-ascii?Q?lgE91DPaRgkXdtyMxjNDGrsQcuUtoJtpQpOwrPMPuA3v14+CIIYG4yoQPj2b?=
 =?us-ascii?Q?H1RRQBzA7T53moP/m3pPhsla1vhpkoZEgB0/9taFoKvJGO7M7WIwFBLjvKQG?=
 =?us-ascii?Q?lWdfJFKVEFRLW13E0PUyULNtPNMZT4yWldTnGP0Df6YMwHVcZekxMWfvJbR8?=
 =?us-ascii?Q?3w0OP2+l2e4MSPsoizLDqtRG1cm12sfc?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(34020700016)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 05:59:47.4386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63fc995-0092-4bfc-3d70-08dca7b7fee0
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB7911

Remove space for adm1272 compatible

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 33dcb2451ae3..ee11b3b8e81f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -821,12 +821,12 @@ imux29: i2c@1 {
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


