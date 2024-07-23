Return-Path: <linux-kernel+bounces-259808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C57D939D80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ACE1F226AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F514EC57;
	Tue, 23 Jul 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="WzPULhc7"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010070.outbound.protection.outlook.com [52.101.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD39614E2EF;
	Tue, 23 Jul 2024 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726619; cv=fail; b=aKBCPOd6/5lIYtupIxZh/3jQvhHcl/jYVfJcQDcZ+XeRqEvw/hGjBSUUDtvcHEQwHoESyPcQrN7O1x+Pb/gC4OHhjv9M1UIRhcGjpZZLKlklbzABk1uNzVFJwgvqWBhwcAa34pORzrN8Fm4U9Rs6hGGn/KxMC58L+Y7ZFK2typc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726619; c=relaxed/simple;
	bh=FOb8jOZM6I/Yf4bmbBSziNy2HqRVQUfHDF/sd4v9AWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORnLytbiytqwzOerRHwaRexX0fypcS23U8RfaIpHdMLlWgxeB/HSY3Ct8zEYEOk4s+QHwHlWywlT6gIG8l9msP7C3Oew7Hi+PPpCZ2m28fdT+3Dg/pNRQls5qaomS9aNFlB36B0AJtHiY3AkjnGLSD9E7tMuyvhyhlKmGgIkyCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=WzPULhc7; arc=fail smtp.client-ip=52.101.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIRmyPgqo1/ThI8V1eQqnfvPNLdbwXhviR8NvZG8wB68ck5Z9FSu1FmgfCaGEP2o1TRemojbtBDnw8eDodMocOtCDL8gaEM1Y1/ujmxATiMZsSBoXU3X/tfNWz3bEzAtf7D8RxOHZTjMHe6pH08dY3uw99uwLji1rvJv6Dq2yvuOem37CO409h+/JPXeSouB7YL/A+rV3t94Y9KwZ67tHExyUR3l7QdB8m5UpTWL5zTrp+/SDptFDmjEAjzgGYm4dSUk8E+9yskR7UIaYQ4gnBAs+MZ9oxu+KWSpHKcIwcYV/0na04EZz/kTXhAJIXlzoysJJ+YxSq0fv9LlIU81nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2AzjfJFXFA/0WPUqtPxoFn2BZSzzb91uVzc8URhJAk=;
 b=rp4dhbXyL3I6fob/TcWFu/1+g2Wuv6C8fuuSM/qfKZEQ+oGmuGLtqGCKgwF3ey27ahjkTFSxwCfOqnBfNGOfS4uJ3zOeKWNaLWcbNypxPnmQDL7WYasfgZC3SwLgC7KWZRVg2GCAOZBEHipEUunMzoHb+sD+Udcn5+nYWD7w62XkCjRVRUbxekUp9l6PsoCn+rhx0hRftAzKrxt9rr/za7jiw5Bz/Pj3J20CSgh9W7Iqpn/j94EXWXy1t9AdmqxVJsFfMgNjpY9Vz7vssGrNzlkAUYgIx0LOhQ8CDooVRXOD4hZVNCHkX2a/8GK8iAMOWxm6IxX+wNoNesqL605LwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2AzjfJFXFA/0WPUqtPxoFn2BZSzzb91uVzc8URhJAk=;
 b=WzPULhc7zK8n9tyEYj6Itq9RomEm4x4anHYOFXoxCZgjtaygjMsFnRQNVAkOQNZxWlqjm9a68+QfDre/UXFPnnP9BzFoxw3qrdlk4CECYgym68Aa5f1NnTxU5Z2HRRjbUvnGP72Zu4iwgZ1ZBgc0xObWTaxi+a8ga5Fk75r0H4c2Gnp7F5qNOmDeeMzFLIi3EubNUdqAevWU4i+BavsLutzjVMvbvolSdMl6YWj1UD43pFEVl8PPONU1ZMUI5BvHWWJTJtvhxdWt/UASKKSonCB1xHykiRGFDk1f+ENmeSXV65l5OTuXGck/TrQB8oU0b1ig7B1zYCl/tkLpllZuXQ==
Received: from PS1PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::30) by SEYPR04MB6872.apcprd04.prod.outlook.com
 (2603:1096:101:da::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.12; Tue, 23 Jul
 2024 09:23:33 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::df) by PS1PR01CA0018.outlook.office365.com
 (2603:1096:300:75::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 09:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:23:33
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
Subject: [PATCH v11 04/27] ARM: dts: aspeed: yosemite4: Enable watchdog2
Date: Tue, 23 Jul 2024 17:22:45 +0800
Message-Id: <20240723092310.3565410-5-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEYPR04MB6872:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 64c24943-56e0-4d80-0380-08dcaaf91fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CZ1BRvOIcJ6HF8tycLl7qZLrZz03RKZY6+3FOvOv2Cb+kwWPQ4YEd7TmE/FS?=
 =?us-ascii?Q?+CGaFZBw5UuNgQx1KNX1246nJdKJBd/cpsDlO96wSifCdkQv0xM6UVGaD4OI?=
 =?us-ascii?Q?xABR2y/qvjceduHFJs6ZcTRs0k/RhypXI7tSI4Enalz1ItBc3Vwjfcvkazdo?=
 =?us-ascii?Q?IuxLCMpR9mVZK7S4KnFTuxRKEuScy9NakxtqWTANxVmlZ8PjmK+YXbA5yPF3?=
 =?us-ascii?Q?2Vua/8QBXxVCtWf8fvpcLHWa1K6yEPJckJEGIHBRPHFDCx9QrDhM7KaneE+9?=
 =?us-ascii?Q?qzF7twOlx4LZEAJ9Op7duNPUC9LFO70PQn0h85Fh9USfgXFWnHtKK6YGO0Xx?=
 =?us-ascii?Q?Q103ENa1ibON62Xk2wbSFziAZyvVj1c05bVovH/kX1sPRUAQiMJ7UB0DlTh5?=
 =?us-ascii?Q?QdJTeXRoMKjj6nSEMjvvO4nQnTrMg74GIsQu0ENuxEWDZtuAAzZ4NjQZLZsC?=
 =?us-ascii?Q?Cmp7qeDedbs1Gnyf9M71B2nNZXoKNRCw9JWiYhcwrkId/AlTNuy6iIVvgZn4?=
 =?us-ascii?Q?5MTz9y2a69ERmIAx7MUo/xmURHom70N9l6/JXJ/43gn1u1IJUTTHBj4lm+2W?=
 =?us-ascii?Q?dXAt2K4fdBtpYpk7zWuzsNvGHPb5ATKlkCgV4wwUibXi01yUst/u4QsOXT4Z?=
 =?us-ascii?Q?oV5Z5nhCbek2hzGIBCgvjf7A0CTxYr/1jn+FKnejwPLRdakTqPf0vlsv3D5j?=
 =?us-ascii?Q?dglX0ilpzX0ByWbQzw0TLMAs5hf6zPwsOjjx6qmT7+ky2D3qmH50n7Y+nFjT?=
 =?us-ascii?Q?qJcH8qz8skJVPjiEkrFSW1ChUe98Orc46jW/X7tXJh0gHC+uFNxaM3hvohhf?=
 =?us-ascii?Q?2Vov4xRXRb/LniQFiR+fKo6FapHY7LtocDealY0GKzZA85tykGXyapKVi3I2?=
 =?us-ascii?Q?8zBR6VE0Smc+L6N2wTgf8VD1FVhJd4hulbBrl4DpsabCvNFqB3F5uzb8pj03?=
 =?us-ascii?Q?uTF9LHVD1oBQB2XDffWKL/pVJpRq1svJZ4Uno3SilzRe9V4Gvn/anWWRBBqy?=
 =?us-ascii?Q?FcQSVeJ1tPvHPUxMi74/jsYoaknTnhj71tev7lK9HB3znDXJXUekXj7pzumH?=
 =?us-ascii?Q?DQ3savWLaqrqFzIVbAD1LfSBKw5rdg1R45aOmOQnTodwqVSflOvgfnbQq/OL?=
 =?us-ascii?Q?zsBafithFdmFlkX7N6jCHhmLtGQQrmpr5X/TJRL31NlA+OX63SHGs+mQNvdv?=
 =?us-ascii?Q?DyxqoWAp6bDw7rJ7etNuU+amek4f0erzdNI8jDpesSGiud6frW+hu/JSR11x?=
 =?us-ascii?Q?Dl+/pIdCZywbEiJF3KT4fE8nmhwv+C3jG32yfV+gaz3HVKspzlQnEZWfcvy4?=
 =?us-ascii?Q?pj8GpZMcsCZuQT3cFig/Q3pd0VTtmuSUHazPYlnT1fLZ67drKM0JC7htAFSn?=
 =?us-ascii?Q?dcPRyCL1hCNn07nUDBPeX1fyWYBinHvR6AYf2QbYOjbm+ujwg6W2YRj8GXoK?=
 =?us-ascii?Q?/hS9PbHTcs3vl+BH+Eeba86rvwy2EEWk?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:23:33.3161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c24943-56e0-4d80-0380-08dcaaf91fc4
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6872

enable watchdog2 setting

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 575abdd530df..51b4e9ae13cc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -120,6 +120,13 @@ &wdt1 {
 	aspeed,ext-pulse-duration = <256>;
 };
 
+&wdt2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst2_default>;
+	aspeed,reset-type = "system";
+};
+
 &mac2 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1


