Return-Path: <linux-kernel+bounces-300824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E783795E8D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F76B22805
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8B914A098;
	Mon, 26 Aug 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="qgiKP1MN"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010064.outbound.protection.outlook.com [52.101.128.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251213A87E;
	Mon, 26 Aug 2024 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653622; cv=fail; b=rCuZEejjfQBjihj9a0iYbK4vvzxx397Lj0qt4OCHCVLlWmyqb3yPZi1BXjlYAnlp+q7zb2NBk2jQwwmUvWkgRGhEkfpuCl+cO11rMHGGUmPY1mwKmZ5iZj3RK7J77ujyj1mVXdvT/CCNm3obrRzjjDRGy19rGhljKSx0JHYlijs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653622; c=relaxed/simple;
	bh=Vj5r86kZZjWqZAoGVax+5aI2ZyamKvx5GqKmfCR5sq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcMTgEhTN5q827vbtykFYozzl+lj6DJm+2M5oTjimGcIpu0L/AOtf8Bx3UCHw/ynv2aUMK2P2YtIDVLFOBib7JUIufPqDVdaPh1FKm+Kzd6ZpgKNOrOqnboMBui8tJvhmdyUShpulDqDzNlX8Lf3rKwrY+xGAGSvGznlib33P0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=qgiKP1MN; arc=fail smtp.client-ip=52.101.128.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZrym880vqPxs/y+zzXHgltpLKD0WxEcx5QpkKBizHm2fM88FNLdb9zMdzh4Yya7vWGrPkQkoQmL1ojonKhLlHrBPVLnoEW1ZkW9bbUXBftVfO4fcPaCADCqFHE0s7FaZh1+pLuWQGScPKqoGVYlm35dKEbvopUljajM0J2sbDkNXwhTRM5Um13BhylWzz2zMGupuMhvw4gVY1nnpzyRYDdQ7fuc3/2wxZLrR4f0YdJl4vaig0GezhOaOybMvH8HGeHARAxXh59lEg0/f2e9K6PNo5XfcrblRmkDASNO8Uxigf8em5zHv1p3Gbrzi7iKKLogYuu1fSoUJy8EgLhEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JER/NX2UhjnDDNBj5f33z0uFCbRT9/QvpzhQON2sExY=;
 b=d1h966O/PkNOzL651A2zeu1krK46koEdiwlgHaUo7E7FQuq2oBivnpjyVaDrbFm799Vn+cI6+X1KAAcGiwVXMlNFW/djhA66PsyAY+3QhIgyTjbVsXqFJU5FA3/LtulxeF7r+aIh8nFAgMHF7XpeWGGLpCLl2VFC4xGR/FHfYfutamwUjtwP8huZM5yVUVPonsoBakYqh4wA/HBIl42eYsE4H+/v6P6o2mqoNeHbDxyCoaN79QEuTMwulsHTxFosQAvjJ5QJDKaK0EH4kFAiJRbw2Kr55Nl/I72MG/2RYLpGepVrJvNazIbgas7sh+jB+MSz6DDqw0mEE//b6GrPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JER/NX2UhjnDDNBj5f33z0uFCbRT9/QvpzhQON2sExY=;
 b=qgiKP1MNH9xS6hW2KrujsnkjzMhUNs8EepbGY2qyiMHNSnL2M7lOp6JAK8muoVMcRHKA8cOpFsoBK/pirQgRfIqwckQDuUHf2fYQtI9gxMbaGJgR86ywX4ad1PclFeji6m8wYxLuELSDNGwKj+poWVT85+wk1GKdB5Y8LPRdfmxYlun90K4StzHq+trxqgDrzr8H9Zztxv+1iDTi15Z6xTUs7JhTqRKIPxIiBczsC9gDA9Ubh7swCryW2Wv4kg2QYACFlflpHBkTR9E7tikD+n60msBIV5JAxQgAxz3cxKUbjvzp48jKi4aXzLmcB5HlSOUWRFAWbCTVFgZi2kQLRA==
Received: from PS1PR03CA0017.apcprd03.prod.outlook.com (2603:1096:803:3d::29)
 by KL1PR04MB8119.apcprd04.prod.outlook.com (2603:1096:820:147::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:26:55 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::4c) by PS1PR03CA0017.outlook.office365.com
 (2603:1096:803:3d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:26:54
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
Subject: [PATCH v14 31/31] ARM: dts: aspeed: yosemite4: add GPIO I6
Date: Mon, 26 Aug 2024 14:24:05 +0800
Message-Id: <20240826062408.2885174-32-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|KL1PR04MB8119:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7a10473f-e6d1-4df0-bc7c-08dcc5981497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4y+i6oZzWiEsFB3sm9iNif9PDQTHOdqIpBrf4eprgskyfBQyNfMq3PzmGzDv?=
 =?us-ascii?Q?jFB5NV8TOeWmlPLhJak6erkAFwmrtD4KhV4cmhrWVmyUbvowrrnVh+wjK77w?=
 =?us-ascii?Q?0itjeaGlgEQUsUM+3D2ugPxPbYcq+orQZJ01IPdc7h9AR+yAAz+2fbxv26oZ?=
 =?us-ascii?Q?wLMjPyd2jBbBdfei0wkCEYm4Nh8ewF6I9+p9XBpcAmNHLgxjcxlANenGLT7M?=
 =?us-ascii?Q?qkYIwf65xE5iJesB1kdGo0T06sjuwJ3tMg+vRnO2b34Df848HVKIAaaDQp0A?=
 =?us-ascii?Q?Om08yi7aW27ImnQjb800eaHsSFGjUey3xfME6LVzNkWPKBMDGfkOYeKLWmFR?=
 =?us-ascii?Q?Cf5nkgOKsyMmquT+/p+Wn+IBIe5W3GMq8nsmdz+eZJZe0uB+cq6L7Yz//QAi?=
 =?us-ascii?Q?zxBUpnRqCFbuEbJeYvqbgsMm4RqC/3fQG4C6xg0aY9hBpo22uBAQCmG8e7JR?=
 =?us-ascii?Q?iwbHmoOHDiU7Z1pEReMCXo6E7v1OsBM5GiJdCNoEg7qyfUXVPOPX7U8Oxq3i?=
 =?us-ascii?Q?b09n+VAi9ukFZ+Se74mEQRnj9BvG2iuxUOY+YEsO4k53yC3Wa0Rd3bPCO+XY?=
 =?us-ascii?Q?uIt6XYLr1MJ3ZdPhrl47Z7uwcPgiGyjMKoKdhqfOglP6A29Ojv+k7UOsvT0e?=
 =?us-ascii?Q?TM6iyPcRwKEvYD0etxuOD+0/CPRtdPOULfZprK9/MU3vB1RFjjXQR6B8EeFV?=
 =?us-ascii?Q?XVnsEwIbgTrFTfg1CBOKYKAK890GBry0/xWP6YFOtDtoACFyp1a5ADxXvQEw?=
 =?us-ascii?Q?/tTz3QfZHE4rkUYJ0Wf13jc5jpuMXD3uxln0w00t+G3m6psP7ZjT8Zzm1ErB?=
 =?us-ascii?Q?im/7mWXasb00JDl2+8QnjVqffeSRAydVggAOOy+XZ7vP09VYOge45tq/5u9g?=
 =?us-ascii?Q?hUb/GHnA4oATcjyGFeyJvrGdTQPo7jgmpytVwMaXl/371SHdM+MtH0c/bvP8?=
 =?us-ascii?Q?OMBV68knlJZWJClswqxA3lTXNSfVu0RzzLsV6erAgjo5G/vF22TJTSHbs61i?=
 =?us-ascii?Q?cogHonItbV2TCd18/Mt1LqFV4FDWRhs9ucIR4ZP0AN8HHcUMjBN7hoiGEQp4?=
 =?us-ascii?Q?yQXTDJ7BMzmQJcAYKRPrLNJz+QxivlVcR0L5N/CC983liNh8oFAG1dk/UT2l?=
 =?us-ascii?Q?eLYaqrBPrro/NM32tNnT0c223dwq/4jADC5ZPNb1cuT1NtvU+4kEyYADkJnO?=
 =?us-ascii?Q?2dx63BmYQCTxmSouoSs9mdEcapRnBcYIy5NlyJMnvVgyWG1ClC2m8MbQujpz?=
 =?us-ascii?Q?dNy8O9kPo0HzTUg3lPj6Bsw4PtFe3vDS44FrLsQmdyHapM5xHRJ8x4Uw0urD?=
 =?us-ascii?Q?sX+EQj0j72h7x1o1mGGehjfx8lucry/DcgvMek9Z6G8xQg1iKb01HGfbs52L?=
 =?us-ascii?Q?JdEYLXSkbtsAhWY6LFhQhzX8Mst29OnqR6Reqt55iWrb+g8EUoyH7r+GQG1F?=
 =?us-ascii?Q?zyypd1mOWA8fvsqVNko/wBnIlJ/5tC4m?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:26:54.7832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a10473f-e6d1-4df0-bc7c-08dcc5981497
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB8119

Add BMC GPIO I6 for ALT_SMB_BMC_CPLD2_N.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 04aa428f94b7..0341b61aa1f1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -2011,6 +2011,10 @@ pin_gpio_f7 {
 		gpios = <ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
 		input;
 	};
+	pin_gpio_i6 {
+		gpios = <ASPEED_GPIO(I, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
 	pin_gpio_l6 {
 		gpios = <ASPEED_GPIO(L, 6) GPIO_ACTIVE_LOW>;
 		input;
-- 
2.25.1


