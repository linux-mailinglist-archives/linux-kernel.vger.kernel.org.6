Return-Path: <linux-kernel+bounces-345494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46098B6F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF8B1F217D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4511919B3D7;
	Tue,  1 Oct 2024 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="WR1JpDEv"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2089.outbound.protection.outlook.com [40.107.255.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061897DA6A;
	Tue,  1 Oct 2024 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771434; cv=fail; b=ZFXyCuYdXIeVkYzPYzGprEvquDu5kPTb06vlMygUZzFl4EwBMYuwUt+mdNCJsomZ8iCfvM7ItT/pkVZQlaEAjdLQy1Z9wDBFTB8NMhl49nw0AUtVtaVEneS/PTHc2rY5ogTyJK+2GPJ8K7DG8EY3fLS51GUePTnjidw1dgQWwjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771434; c=relaxed/simple;
	bh=OlrMLllDpAkKndWGLs2sKRdZg6od96UmKqHa8GjQ0IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Dm5eEtmXqyt1w1KVlrZ1pROdgSae5t9T8BvSI6al7NzGV41IaRunT6krsnf669bw1F7agPjBUwe8YG+hN7S73FSehB0hTy2jcON4iJ9vcns7lMMJYwjmvUCxZCoaR/7sLUP9RouPOq0FNzcpfSjR2nuKm11kxzxpbPXazbqBep4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=WR1JpDEv; arc=fail smtp.client-ip=40.107.255.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaNKttczzn4/P5ChThRr4lihepW3G6ZcZK23OMDXl81UHRbcl9r4pZJw75dQQ3qLCJc2H5E1DPrC93+Mx5lbAm4LnnsBxDaOKy1pCmgqzwHEf3CZI7JcpqDc74QCSJuimE0OiLJTGHpfgFpYnnE/NxT5PLh7plLFHkj35v/urvY1w7oEeNm8AawJypk+5eHlkJULFH1+xX5iy60VBJK7ywdZippNmQmI6lPSkxIedQQhOsoZ2bLT4XePh+KGVHZPIKoB0/q5e1hPiIU5ZSurBYJpOLXGs6E6+tKrpTV6YT9M+uT+WYfLW78lstJd5gslUUcoa/ZYxsfNXgHJpTcfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vnAcf4zent/lDbgrq7jYqXFnK8Aph7Qmy7uw9rdIMU=;
 b=CkOPaK6PWQW7M7oZ9kbvj61nDAbUdY2PFgWeCvH37tmeWH6YiZO0z5s9M9UMZjmjcGVis9h/mBk6dBYd1ifsus8FN06O2btzxFo22mdqZNLXeuC9atysC0Nwi+mAnrMHb+6Ix67BDPyvjHkIn8dkMThoYZoNWGVtfWUZGBDRoluBVd2EEKJnP/+8+j1nYZIuKoDd+ogbCwKFrK8Jfys6xLIhYlz6bIWZyGrElL9J1wtZCIham4U2+7bE5uKueu27vL7QPGsqdQLoM/E1nifN+lwvKbaq0l/t00UDdHyFKh3jnZzcloeK8PVOYpELFTw0vZa68GfTkN5ZJM3RkwzyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vnAcf4zent/lDbgrq7jYqXFnK8Aph7Qmy7uw9rdIMU=;
 b=WR1JpDEvKYZDwDIDiySBJN6LRN/YUV3bB434cO4oupgMXHVoPSdbsEHFpiP4/n5WG2HzDESlqhbGAxi+ty2LdWVUsqEpk8h2zoVXXDnpj3x9CjNald2RsGlaQb7aQbNzk6BgnfpzkqXwc0o461u4L0DVRRN4jLWI98JnYnr4sFSzwlrOLzdatThupvp5e5B3kJj84Exz8ShBz3s3kpC8IQpUCgZdwSHBzf5dhQady8fc53/r2YzoLevk4n43A8fDguP4471ungl/WUpvmBXnqCQHMjO6208v9PcsMyTFXAwCwaiWLQZRce5pZ51DN1gHNiKO/ndy+WzA+ObfVCzvhg==
Received: from PS2PR04CA0014.apcprd04.prod.outlook.com (2603:1096:300:55::26)
 by SEYPR04MB7493.apcprd04.prod.outlook.com (2603:1096:101:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 08:30:25 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:300:55:cafe::69) by PS2PR04CA0014.outlook.office365.com
 (2603:1096:300:55::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Tue, 1 Oct 2024 08:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Tue, 1 Oct 2024 08:30:23
 +0000
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
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Remove IO expanders on I2C bus 13
Date: Tue,  1 Oct 2024 16:30:21 +0800
Message-Id: <20241001083021.3462426-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SEYPR04MB7493:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e919817d-f0f8-4075-c240-08dce1f34b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sInJA//JwD2+S4gisIE5SDxAyfzIJz7ZcLBiIl8R4zEYKY3yCFlraYzFJ617?=
 =?us-ascii?Q?Rt6LAVkHKciYy8WyVmAAowkpkdT66oW5SqK0l8YirtXHskGEx+sXUDLEDRSX?=
 =?us-ascii?Q?Jseml1Mip6RQjIHfUC1a/8muHMyD3JzfYqBkPkCif7jxUUeNTassWf58uQyy?=
 =?us-ascii?Q?O7DmM4Y+Cwu07Owep3BeNWHTHsD6dBYBRL6m2FKd6rrH0WtIk8RusTOvivdE?=
 =?us-ascii?Q?Yr6mjNbq3j69QuokHhd3AQzrMPojBQtECjA1GccA9+nmSicpfRmLw1GSorN4?=
 =?us-ascii?Q?4RaYZw65aK4mq0I3BhqnLLXItxUd40GrQPoS4s/czCmOynmcwMql4QQIBimU?=
 =?us-ascii?Q?1WLbwr7RRnS8gVzFTNzuo+ZX7y9KgoiEGKJdBPvslekof4uTV3M6up95im6N?=
 =?us-ascii?Q?OX2YZ/JumjNp6g3xqk0tg9zFX8qYJ1vG+VNqW0f72hcTX+pzHfTOLLK6d+DW?=
 =?us-ascii?Q?5++fEo2STtHE089iK++Y7GcA9+i2g7TjN7eDVbPnDwMkFpHONAHLmeknQWU5?=
 =?us-ascii?Q?xYhbEYIpQNh+YUiJZ6x7Ct/2AbYKMHb31Yu/1fgRLcHVZvjjj+DEMFe5/JE/?=
 =?us-ascii?Q?eqbGPrr6OC9rnGEj8DU+kGnOT/AlzEe3tu4OJ1ZwqJs+6+bBFLEZHRIBDMhC?=
 =?us-ascii?Q?VGi3ybrbsmT7Irqmw43ZiX7C/wnGCjeIM+lfsK/cH42DiNg6sNgGsGbyIEf7?=
 =?us-ascii?Q?CQCGKh8v8IN/syZGzByld/14pTfk8fFAnkZwo7vCpIafvt9JuIwLVFy6w516?=
 =?us-ascii?Q?cL6hZ4J19dlUcItP+oiASsjuy6Ao86icoj5SbIFJ1zHjiDQWZrZhUbLtkGnv?=
 =?us-ascii?Q?IzOtTF6tORJgZdPEkgaHmIOhDuZGKnTekraul9wTD2T3ss8qfY1o5sHTNfY8?=
 =?us-ascii?Q?6p010jWcyIgFKQxC/OBeAdZFDVCeXLc94qRANX4+fDDgTOZkzsyP2VT6Zn/v?=
 =?us-ascii?Q?iUTmiZPBuuRTq3e/D/J71+25U9/claQzkN/Qk6/VOcv0dvy7kPPMzILl+69L?=
 =?us-ascii?Q?GwgBY9sxvddM11fSn+4bhMFu7wZCSkccwi98JzRb+45oW9wUh7t4umYjv0OD?=
 =?us-ascii?Q?r8HlJ04f90Og1/O8uzj9JapjQEIrUEsA27VnVd9titEPHjh7t0fjnXsZW0hc?=
 =?us-ascii?Q?veOAmPQkAetiWz8mrkxI3JdoEbz5KHmDR4NCOlJCoLmcmrvs+GNd4suCPxs7?=
 =?us-ascii?Q?/BJM+T2xHMk0kZbElSck0XNjEW34QcqdMTy8o5argBxL2et3F5W14wEIiZZb?=
 =?us-ascii?Q?pLXesw/8XeDTvSSo56IH5qci3IB95MmVt5j2dxlDYEOrR3H6ncQP7M7xA7Z7?=
 =?us-ascii?Q?xWYpkC//ocXs9BwbwbFVtOCvyZCRzZDif+UJiAR6xA9cPm1NdrZ97Yx/NZ1i?=
 =?us-ascii?Q?q5m7I9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:30:23.1336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e919817d-f0f8-4075-c240-08dce1f34b25
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7493

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Remove IO expanders on I2C bus 13 according to schematic change.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 28 -------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b6566e2ca274..ae2a2ed603ff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -731,34 +731,6 @@ ipmb@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 		i2c-protocol;
 	};
-
-	gpio@20 {
-		compatible = "nxp,pca9506";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	gpio@21 {
-		compatible = "nxp,pca9506";
-		reg = <0x21>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	gpio@22 {
-		compatible = "nxp,pca9506";
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	gpio@23 {
-		compatible = "nxp,pca9506";
-		reg = <0x23>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
 };
 
 &i2c14 {
-- 
2.25.1


