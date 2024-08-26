Return-Path: <linux-kernel+bounces-300800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B3A95E898
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D568A1C20FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D872E137747;
	Mon, 26 Aug 2024 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="QW8Q2sEI"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2052.outbound.protection.outlook.com [40.107.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C55A13212B;
	Mon, 26 Aug 2024 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653502; cv=fail; b=e+2c6mlFaOnxOXpLXH9QMWKwnbBhuc/6ZIvVjGvaoeayTr3LNSLIXoASGPhBEDNZv6WeTM1HTEQ3cxD18RyQpcwd37R0QhzE0sakKxYYhPyB4s8z80PasNurTTUULJKexDEXTVjr7wb1i1K8GAryuTF4CbPNfid5HfjgJ6rbX18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653502; c=relaxed/simple;
	bh=NPl1LaIuLqsInjrJcLDVPdw8RVKGkEQ+SanwCXdYN2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuubGk3kuv169FKLKuKqSJvehSJyNlP2EiCmb01ZtecmLggBZJJhACde7Xq6GA/Du5XMrR+yyZg4iOs1I8gMVTmWk8yr3Qo46fEoF3mkyBw5daMrj4kEvCD9Dq+jjZpVh0niGi+Z/XNZFeUUzDP60wFO4sbSiDYyiD+REOdoP0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=QW8Q2sEI; arc=fail smtp.client-ip=40.107.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLpr3/q+1AozkWwCqjeWMk12ePSZqDzkf+GrrtKc/ZuaY7GoeY9l7qS4oMBSkvS+mw8fWo5gfdQzhA46zuxHiFPVhpp35Zxcpc9beknxgECUj3Go1jsQoSwLZxKUDxeSBeKELB7pU32/OvfSNVh5fh7H7hyynxGvzew3V5EJ6dZFTrqeK1jYcBQ80ufsWswNvxBBCE0m7sdaeI0B216+OIHZwy6qPJc/M6NIsFKOpwZmlb0tSJkBm0rBhqCS4TUXFzt5cGXXNJoVgsNz1DVajwGx87uCHhlCwHz4Vg7ZrPtr57mLFgmFknCfompQDQ8kYPmgytg6hb7mzKhJxKgeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwPnCRRMIs7FMuQZx/G2KDCYulqMsDb1BS3wTt124H4=;
 b=qXPSqbX+prbeE647qrNcSjbKlLsUo7gFYzx12OqGFN+gE4J4B1/eTGOP0HwVLlQHRB/LvDj/tQjYL9ceOnO6QYeTLqhgC10CpRjtCz4MGT/9VGzGNaXVVqOwuFiySw9aX/zxu3G/RsjWmOGfa5V0v8fDDLISANwNQjV3M0gJUmqdBzAM55tF6frD0r/N+hAq98Xp5Dtjp50HVTAywwfuaki+fdBsCTM5hlmF+g1AJkT+pDyl4ykwzwsooFqDwjaBFcX4oUw9lPuL7lHHUVEvQZ/2gPN16jmc48hhgzpeFr3/S+C5wTmW13gupakEXSOMsmWmk3etBH9v8SelDa8U9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwPnCRRMIs7FMuQZx/G2KDCYulqMsDb1BS3wTt124H4=;
 b=QW8Q2sEIxZps4rBh5iagJcx6uwEZf/f0suewQGDyJHu9NXAALS/OgFpwocXpGEJRTr/DKMMd6NdhcDYrgrX71vmSGM56DIyYF/ESuXjacZYal7nwsG0x5l4PUKxC0TuRZeefCCC+jDjea9pCK2XQUBWerrKNImkUn6YhGKoGcdhERhn6cBlquTP6S7j9gED0sWNdRG3JPG/uH+RB3HiU5SmaK+712PZx0exiSgpwb/yUoWNHwzheoqhfdU+ckJWqDWfAh3MZt86KDxNFc9HCtdQtUy5ioXpQXyHD8lxFcZAcqzDqet07LtzHG4L3VZabRXDnfPDb2Kohxov1OXzUug==
Received: from PUZP153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::19)
 by OSQPR04MB8236.apcprd04.prod.outlook.com (2603:1096:604:28e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:24:53 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::db) by PUZP153CA0017.outlook.office365.com
 (2603:1096:301:c2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:24:52
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
Subject: [PATCH v14 08/31] ARM: dts: aspeed: yosemite4: Remove space for adm1272 compatible
Date: Mon, 26 Aug 2024 14:23:42 +0800
Message-Id: <20240826062408.2885174-9-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|OSQPR04MB8236:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 081e5648-9676-4ea6-a213-08dcc597cbb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0OoW7l/iY6yg7eXioTgMAOa4ai1uabezT9XITJJkzbnfzQiMkWPXdMVbT+CP?=
 =?us-ascii?Q?0DPtCVkXP1L+seoS1ApT8CNr6IN6sg/8eeKoLFll14R8rMzaj+cwOCotBkbQ?=
 =?us-ascii?Q?5VMER+xXQojI+byJk6DzKL/Mvr1+DDbQEfXkr73mQErgKDxc0rF5czHn0LUu?=
 =?us-ascii?Q?H3XNSXh6XLrd6vDLMmf3F+PFjgPok5aGXZ0ET8kBJmDMdZtEMMgLAoBNQJBp?=
 =?us-ascii?Q?d1pxRdO/yK63g3SRBIYo/yWj8dVyHD598eEDLSaEbbjAk7Fu/qmgxG1jK2NG?=
 =?us-ascii?Q?w/EVljAkB89zqmmZh3N4yfe2IOgZMiBAcuD1mYhPc4nLleJUmCIaM+mpZ+Cq?=
 =?us-ascii?Q?OGwaX/3rGTHXM2sR9Zr2s1Ga6i71/qY8CVPS53+bMLSPU0h4limsbc82BvGS?=
 =?us-ascii?Q?lXUMVSxgEL393PhYBc4GHxzmr2S8TmaEEm0s9Je8GOLFp1NXp7ADkym/csv9?=
 =?us-ascii?Q?Tr5gl7Hdn2IwpuTOE8ycnluS5q7w/nwBaTbdwWciMFwFzJHYXqzAmc+4rAh9?=
 =?us-ascii?Q?8Z0y597J0MQt1JkuXiraA2jfhqpc3ZsqzGr8FZ/ZlgvSJemr37CnLl6tYrbs?=
 =?us-ascii?Q?8bompewA9TVHqjcvLhD71V+X56Fw2CW/JPyFBF7NtxnAWogNMTwopWFHj0Xe?=
 =?us-ascii?Q?KoN56owLNr/acMJwfrZZkly4GY+MGssyoV0IkGkjJu3GqK+kULLBQGefGvyG?=
 =?us-ascii?Q?u553I22T0FDvbbIepG88mEsdhvkrP7RAM5xRSKes7uln2pgvWWEwh++4XHqI?=
 =?us-ascii?Q?AN1N8+/Fon91Vroi5hASbgzD3JVfpz7Ew1yREQx/f1FQuNbCO6yW4gDQuhqr?=
 =?us-ascii?Q?ym50cggIKNE1DFvVjFnQ69aznKFWDW/9RHGCsJ9CK64GgjLbwwEzrJ7Yom4N?=
 =?us-ascii?Q?tXrwfUukh3TjurpEBn0vRog7bxf3tyuZhhrIVm4jPxz/GZ+BUThjZyN9L3uh?=
 =?us-ascii?Q?Pivl7y+jzX3PicM69kO2eh+DJH2YFQqBgypzoY6mzLmL8adK2xV5hmZwD5ZU?=
 =?us-ascii?Q?IIqvF93kpBYcyXLfMG+rAE5N2H26G2dRV0SwTnXQCFPfWaQEzMOw65yqdkm+?=
 =?us-ascii?Q?VbY8EP+F/LzcfCJ4RSVs7eHucTx1RXJ6ScZHSZqDY4uL2jO84tMDjfe7Iduh?=
 =?us-ascii?Q?6fCZfzWrs+Kk2i1eisxejEfofcLdIbM7tI5E1xWiNO5tb3DgWCaaU0bOIDdw?=
 =?us-ascii?Q?+w9fIHyRtO+1nQUygilzxAQt2rKsjG7f4tzvmXkodMA7FUtPUqJq4FUyyA1L?=
 =?us-ascii?Q?FOPcqiD7bnHalDHKic1FjWPsYbDzH5vJAAMytTHeFySmRkBLUoiSM3aAgmnG?=
 =?us-ascii?Q?YAwkkncqSWgNYtNRDi2WxDkxajSD+WQ24qIPIwFNdtXWrk1jaQeXDHKL3Ldr?=
 =?us-ascii?Q?Q6QoZ7eIWTjbFnSqITlzDkOUkvsb0lJtV7yvkAZt5Q1zQRI636rWGqeMLgWj?=
 =?us-ascii?Q?QuZ+8B7oCgVoYbh6muDzpRfk+94Aeu1X?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:24:52.6123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081e5648-9676-4ea6-a213-08dcc597cbb7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB8236

Remove space for adm1272 compatible

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f4d27f1ffdb8..b11951c2f71e 100644
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


