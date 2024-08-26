Return-Path: <linux-kernel+bounces-300815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D080995E8C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024F01C21500
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972CC146017;
	Mon, 26 Aug 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ZxN0MchO"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2087.outbound.protection.outlook.com [40.107.117.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57C1459F7;
	Mon, 26 Aug 2024 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653588; cv=fail; b=d9iUbIKDFfG6AtIH6TlDVXoAULf/VS2dM3ksczVqrxoXbn45lM06ug4W4x5lKgHwjSoAvok36zB0R/L9n56Y6BOOCSaOrpG/thkRV7tizvQ11pWciF6e301EeGm1UsRwcPkiSXY8EM4NYtsYxeh+N0JhleuilMzmtmYTirBvYLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653588; c=relaxed/simple;
	bh=javoh9yV7WrDdF6nED6Caxxup6WdbdzzX/IVbBhNWOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Om5l9KJm72o0U0yx/GLZ+96tU1ALueu2e4h8BWwEcB0u9yIOUJGoJvm2PVZO1JqoI0FTalzl9JB9zIhSHZAtYA6XdKfxuxmizvqtWc17sgEgdnN7glHalzD/JABWbjICMiQd/m8WAaP+OGwdLZfgSUEtp9oknI70d5YtCa2/1JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ZxN0MchO; arc=fail smtp.client-ip=40.107.117.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0NlWzgaViQPmhb/Yd8E2Q/LbM6o9LD0GuvM7c+D0CXVEfvQmQ4VJveZDQ1DgK2bIN8aYEkvcFRAnLDxIuajrH5KDUH3RW81keK2LpJ8QhH8JK+GpqyZeI4kBshhZ892Uyt7UYjo0rravMr9rMRsmBzLQlOea1+AfH47yM+jzpwX+5NvcdLr1nZSpXdyvyn4+7ouaOjepcwS/3OI3krb6lRr5mpZiwHtoXtfjSbswn/hBhVXOFGZAw25JJ1xSUuG79mbvhvmMMvBRwr3tsEvOJcaXa7kwfKkaOZFVOVjHQXAwcu1vxx6lYRevW8muDxdtncS6za7puiqvCkXqse+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE8IuzdQZjntYqD6nUPQnwn7C+BubHdv/yTEbKi/B1Q=;
 b=sE/fbpxJSyebFtKgugm/1AXzpNBe1eY3Gs3OZL/Nfm/1LkslMcBc4qcTocQfniccXvYuiPajhcu19j3TMQRGPLRrwCmltbmSxua1+PFQsk25Yu4VFil3oA1hOTd1CrcNbfXyxlhc4cf5PiTdmdneA0UWBk3R/cSfHg5qLu3lHFxB0YrMZ5g5eAQO/oqVsAuAgAWKP+dXm1vSNng8v7l8Pqg+/Pn0uVXtO+Vwyvo7IzFVYc1iiyCENKQRm6yaBNJDDEv5LXIesd1TLYSq3r56110sHWYE9+0Q8huFdEZ4XbdasSLYyiaKpax62sKpT8Q5zegrnQLcKKxMYjGhGB8b5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE8IuzdQZjntYqD6nUPQnwn7C+BubHdv/yTEbKi/B1Q=;
 b=ZxN0MchOTvM5q/P9I98Yzlqp6I2eGH4XD7WkSB/b6nk4dUnFWk5vdBSxr0tLskXjkYjP+RG41hlEyCaFvsEfMIMQCQY5tucpcEaMJIkbXmNI9F1flNYnhmkTvUy4f0sYLwY1dGXoDcv0rkypSOSpMPeXO8vBlVm8X2mCTpCOVXqWXu5q+QTEHHJSf6Iy2+BtTfLoJxu4r6BXyuMEfrr2/Z8h3Xkw5q4qo7GRi4Ry0hMJveaeCXqjuDyZonGsxr9L7hjzAFUZotwjdwX7zAiB+yfjupHzFbo7MM2b/JBEmiTidklkXRU4T3gE+KTfjaMk9fQUH5nwtXByrNDU0d4/hA==
Received: from PS1PR03CA0007.apcprd03.prod.outlook.com (2603:1096:803:3d::19)
 by TYSPR04MB7446.apcprd04.prod.outlook.com (2603:1096:400:468::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:26:24 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::e5) by PS1PR03CA0007.outlook.office365.com
 (2603:1096:803:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:26:23
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
Subject: [PATCH v14 24/31] ARM: dts: aspeed: yosemite4: add XDP710
Date: Mon, 26 Aug 2024 14:23:58 +0800
Message-Id: <20240826062408.2885174-25-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYSPR04MB7446:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ccda3cb5-c89a-4afe-2d78-08dcc59801dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U4raCMl6hEZQ/VmBPvzkVmyjFzv7PvdzjtrzdVtjfLS3OumIsJC07JW9GFtH?=
 =?us-ascii?Q?FoimjcTt8BWeZOBJ+tUbOnvElz1EnS1rf0gD+dnftUptLxqpIDgqZBECx0Jx?=
 =?us-ascii?Q?m933yqRkLIWZy2gzzXT8s4gPmYW/FN7Xd1VQRUk9/dsDnv8X86C49sxaTIOs?=
 =?us-ascii?Q?XDDyPpASIdL1EahXy0YFcVM14VpkoqLUSDKicSxVzaPBXqdBhC5GSu0wQDPn?=
 =?us-ascii?Q?JXCiPQCVD009CnapiJI53TAj81q90DXVGKckRXTf5xCPWfUI+8zk9L0/ko4F?=
 =?us-ascii?Q?1tUaeHkr0BUZZc1n4ArPSt3/JCi+p/vhBbFDV84zvR6vVkWPt1HgBk87e2Ca?=
 =?us-ascii?Q?bwxloMaA25/HgTJEsD1JWU272GyZTQY4vRAKgUqQjuNp9a1Q0guGgRJC+wrb?=
 =?us-ascii?Q?j8dQxQHXGTAnLn4xELEHJzHSYtGp3hJ/mcx6r8aiedm6Irzv9sNyPD5OeNdM?=
 =?us-ascii?Q?Eoy5bOV3ENhGXfKoZvNHQK/dNs95hnJC3O/bMn13UUu8wplf2mgfM/tfA5qY?=
 =?us-ascii?Q?xWfP/kq+5PWml74rlUIc2Gul1YH40n8zFAEtCrZ+MUof/BR2BbrgeAsj3Fqs?=
 =?us-ascii?Q?gNqwfqlJc3B41Bbo8mGedwv6vwsuYdnaRTvw1cGVJx2Ad3D0k3Pa5YriQB4O?=
 =?us-ascii?Q?BkSAm71xW2e1+Lclr1kRmovayBC0A65BDZLXlecZDVmPa0CjJ2rENiontpr1?=
 =?us-ascii?Q?7SbbQ3SdNixmmavIWamUtCxeSLlAypb0e8gChLgLSl8SAH8pJHmIu7OHi4E2?=
 =?us-ascii?Q?zCBNw7kay3HENH4+dULIpC6S17YzIeKqHCiDelEU1LeVAxe30bXaA+aDh0Jm?=
 =?us-ascii?Q?uYgysPXdcq8f6hwFf/iTUfQhCCIhLfF/Ld85B94meDyiNxALOJn9iGBlVHFg?=
 =?us-ascii?Q?0+cFNjuOCL91RHdHUTenhTrZ9RfyP2BSi8Zng8v8TS0Djzv7x+vdmN9ZRzvd?=
 =?us-ascii?Q?tzgjNtWzPaSibwYwMbdkT8dPdTH07wtJTfnVmM/z/GNSy9WoTJsdlKrKeULK?=
 =?us-ascii?Q?7SjtiqALE8nfMjZ4Wja5elpDlSXebD/3fxYg86a30fnhf0R/a1sy/bcJ9Or/?=
 =?us-ascii?Q?6/n6AD/tuHOBvvou8VwUqbcmxCOskhlXhjosohTXJ2Mj2buN4WVqltugrJZO?=
 =?us-ascii?Q?uiWqB3h2bKVr0hi0CYy9km+T9fVUyEXu+Vhd4WB0+Ci/kvMCHEakKHx6XOBW?=
 =?us-ascii?Q?JswKxphAR0HEdeVwWZd0yk3YLCRBd5qGWkG2d3DkQQ2nBR1LvwdaMyGWSc3A?=
 =?us-ascii?Q?jtUrpLFchP7Lsw9b27Rx5thraGaMeEh8QHjL31QNzvD/+Jx0f4I0nqDYZaMW?=
 =?us-ascii?Q?kU9gDkqJEX7eW/CUi3KEjNRPcs6XYw0CKxftqMDZ00DSe8mLwweXgr4RjCX3?=
 =?us-ascii?Q?AmjRa2ORwdM3BH2WI9FCggi1dGWaRh+pmqyMq3JI/Ip3XCwv5KWKWu5DjtSJ?=
 =?us-ascii?Q?XsQJ+7+gDnYQbdTFZOhzrpbomOlHyiG4?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:26:23.3928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccda3cb5-c89a-4afe-2d78-08dcc59801dd
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7446

Add XDP710 in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 2f4e9c5edd5a..f73719b3c2f1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -978,11 +978,21 @@ power-sensor@10 {
 		reg = <0x10>;
 	};
 
+	power-sensor@11 {
+		compatible = "infineon,xdp710";
+		reg = <0x11>;
+	};
+
 	power-sensor@12 {
 		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
+	power-sensor@13 {
+		compatible = "infineon,xdp710";
+		reg = <0x13>;
+	};
+
 	gpio@20 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
-- 
2.25.1


