Return-Path: <linux-kernel+bounces-289381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D3D9545B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C45AB2380A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3632156F3B;
	Fri, 16 Aug 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="qGqCVgt1"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2067.outbound.protection.outlook.com [40.107.215.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341A13D890;
	Fri, 16 Aug 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800345; cv=fail; b=FUa7jrKwdQ4CweULVV0vZWCyu2N2ynpdggP7dhiurBP7JpjZlSpbSQ8vYMbbLVZp7N6Wv90gAd+GIFu5+CMOpgkuWQFHQhWOFLExYd3ttzBNUAPlwl2lvYQan0XeufWSflv1LyE3oERgFx72sVvQsD9F7dDzpoGAkA6RbPxANlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800345; c=relaxed/simple;
	bh=jW0gVemZ4cl5PWpH2fNOD4IT7gRDiRPR9A8KhbqEULc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMzPJ5B/LU3SkHn8iol3a4A9lWIS+iJbDInBOPh/j2Gxr52ziQNLqsy2tmVWD3Qn0RxjS89A3H/W2IXvyaNpo06IXVSrTYt5LL6/O6HF6CKHSpVikQeZzw0iz3ep3DLUuQWgLjSPZ8b15+khhxYxHH0qZxBkvjymvxYswP1cc4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=qGqCVgt1; arc=fail smtp.client-ip=40.107.215.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XntAE0l5jE7UeoT5FCozJLUxl/FJFX0UVAw841uWePIXtqOBphTD0vdJBheTdo//sYWrnHxQoX/De08KiBl/CoDen3dugpg7Z3L0shmGK4Zf9QYpcO1KtABwUjfowrnMIU/uve+bAUqU3lwfKaJi19QRg4W0s3XDR+NLkLpFeZpNKdzNAbkam345rvt8D5zOnsSLUcrhhD1bhZf392dmtrBK8oJiJ7AD+kNFjgzk4tbVIlHcdc5wKEUVC63rN3BwvyfFtztOzb2l5xkib3/3pLeEju6FyeJfQWQZhdZy33GXA6TuidD+0iigb+3HcDirTvGSwLQ7VPKHYDoQQEq/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP7PVLwcCxjPpagISxynxIAExRDCx7daqT/H5FzbdV8=;
 b=eu09ZYbMRdHszkIGhPTAVTiudvWJGj2yIXHdamge/Rwyh+O0MiKJyPEpkOZNRR53ZX9CNQkSn8h+lv0y6WFDDrtJ22TKJ+mcJAe4NUGLUKQe5QSLUcw98mJVDNnafv6pQDGJrd7k5X0OYHIpYJm3LXWaLFXI4J4ws2dD5vBzSwJxVISSeM1E6tcXimitc8Z5pXRwHCyCk4msAcn2Mu0v7fbeE4ZkHLnmrRcpCutAae0mh/ok1i/oALSf+yJsUy0NVHnz5kGKufetD3xdUJ6yX62zHkLkjaK8zv+fiwB5M47eshIaI14ft8cd24pM4ntVZ0dYdVVYVPm5mxhfb38CdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP7PVLwcCxjPpagISxynxIAExRDCx7daqT/H5FzbdV8=;
 b=qGqCVgt121CVNWMBr3VPjE7Cc6VB0xEFUXRNFpYUpFXlrW+JyDyiwPLCHcHP7fSlcwuGASKiczSW/ynBcC19kTvKxb2/ygooB5EKBHNKT1aQ44UfBigI+Recexf8pA+UIu5EjmE/fPCb7TLIBS9ftusbku/njb4VtfHEt+KzGeHuRq91+pnhbmoxCP8NdIbYhqf41Ecq4IirnuozE7LotaXl9qyfgC6TciqzD7RDBXo356AHiDSZ1QNYhzOjUFi5ZAppsAa6GtqLPZbla/v2cWzA8matRJtmY6OvtNHG6ErHWnMy7TQ/HPsDqw2vx9d7edRBOg9esx3hjhnc/Y3d0A==
Received: from SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) by SEZPR04MB7497.apcprd04.prod.outlook.com
 (2603:1096:101:1f0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:25:34 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::26) by SI2PR01CA0052.outlook.office365.com
 (2603:1096:4:193::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:25:34
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
Subject: [PATCH v12 15/28] ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4 NIC connection
Date: Fri, 16 Aug 2024 17:24:02 +0800
Message-Id: <20240816092417.3651434-16-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|SEZPR04MB7497:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5a245cd6-f851-407f-43eb-08dcbdd561a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Zy5BdSUhi/ovj+TCx0CL/u4dBQYVIJ/buBp118Xv6vJQzlaM+xgja0ntx/m?=
 =?us-ascii?Q?jrJnkpZlyFxK+pB7djqhXkt4fGTSmFg8khtW/QdswbrywjydLaxqn98ekAP/?=
 =?us-ascii?Q?/NsCz5m54TpqHljToQMqZouNH1HQmw5CxZMQFPSez5hZ2n27GI/hL6JG9GAu?=
 =?us-ascii?Q?0WUMJDkZlN++L+rz/R2HojNGreNdzYI515cCfLPttjW4z3787OAm3XF+SUt8?=
 =?us-ascii?Q?2J2+hhMDWnfrGrfMOn3HNjRRE17b9nifa0qNMWAnASIO/EbJrTgmeAG1GrWc?=
 =?us-ascii?Q?HMbPbajWPLoLt0m69rvBMyrerrch5I2D/yGlg10PndyRCQy5JJmBUllOXQ7m?=
 =?us-ascii?Q?L45w5YbMXPB+S2rVLtcTRRgJWLWPwnJjc0Exr48BAa/UgpMQEJpaWkmStYtG?=
 =?us-ascii?Q?N16NpwR+sGvMozR1/vH91xYMjKy/5eDTjXv9+YLGz+KVbvWGIuLCL2ZNoY6b?=
 =?us-ascii?Q?ND9ds3DonrfEh/aDCDlLdQpOPtV0coGVMj8oV2gqzw3GFSF2jmg6fq5gs3sN?=
 =?us-ascii?Q?hvEyMIhr0Zc/vOqNqRJmUkF9roekj0S4JNLEHkYDLHI1VmC6+vkwSubu2yrq?=
 =?us-ascii?Q?vrYAqN887HwDIyfdxfgcpCiRrRK6Hid5tM8YIb4QxNodXdH6erz2COOV99d/?=
 =?us-ascii?Q?lUtsUbCvZJXxiHAXW66HLDHK88T7dkT4KjaYy5cCq3e1w6teJre9z/OLTh9+?=
 =?us-ascii?Q?WhQfLl4kHGN0MaHw3cprDepQ1YN0g8q/uKByUO8FyiiXz0gWOcMfFtb55bLl?=
 =?us-ascii?Q?7WhrPNyi/qmSnP34pBl0ZoKdUYkSZ/zEeJvMMi0AsBFBOhTdr403OeAMyt9X?=
 =?us-ascii?Q?Ek7iV3KZSSfWdWd6z69+EojBcbFEHB3ma/tADaEMkVW5YCX0OdrGE5RbqN/T?=
 =?us-ascii?Q?k6Z0V0JpHbvC9H4cFyTEDWkqKL4vR+535S4ey0+hIZp1Cr8kzg3BzfjuJjnj?=
 =?us-ascii?Q?GBg3iPUHD+C6erauJml3PQOm7AMwa0ev5DQU1iJqFoWR+b2BCp51D+Ou1YO8?=
 =?us-ascii?Q?lUbJUhQoBEX3tXaEPX28riARRZEwcbHFMlk+SgHdmL5tShJkE7i85DdkjuD/?=
 =?us-ascii?Q?oiaQhq81F/Mpg3HE0svey/KmnIOl3UXFj73J3f+iWRLbPiEBPDtMyZJZu15i?=
 =?us-ascii?Q?5bwbra9ERup0iDHdHl9D1xA/I8CwYFRtn07fhGi2JMJYCcaaM62E+47McVrA?=
 =?us-ascii?Q?kVIfDTeYmwQc82zVI1m+E4/n+PwdXhZWHvavIxlFL3uARNHcYT/DSgdwXgww?=
 =?us-ascii?Q?tpslTChurc+7xEjA9FgPl0CaIdWL6iUeoiS5SVdxzwDT+RAO1V6tMtnu44lF?=
 =?us-ascii?Q?RwaQPaxeSoAt3TwO7ZWNMiNZxJTISxfrjpMEHiaXfxwhC47wCOYUS2kTNl+3?=
 =?us-ascii?Q?b+EJYqEGPRFYkOInRma1y0a2IYIGDzHyC5MRIjGhpmRHtUHn2C5ZUkUcEoDw?=
 =?us-ascii?Q?xxrA/iUFsju6SF/w8wxCynoaqqBIkoTq?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:25:34.1222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a245cd6-f851-407f-43eb-08dcbdd561a1
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7497

Remove idle state setting for yosemite4 NIC connection

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index df389b506b4b..c0497a1aa93e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1235,7 +1235,6 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		i2c-mux-idle-disconnect;
 		reg = <0x72>;
 
 		imux24: i2c@0 {
-- 
2.25.1


