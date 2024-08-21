Return-Path: <linux-kernel+bounces-295245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90534959900
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4703428415E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5771C331B;
	Wed, 21 Aug 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="nMRgZa5w"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2075.outbound.protection.outlook.com [40.107.215.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439901B3B1A;
	Wed, 21 Aug 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233301; cv=fail; b=lLE5WY0HTn/NWuccgd7tQlx0DOjJYNLcG8VaFi/T9QuHCohpLhyIFc7JRe3Yt3KRpNEUCCU6h3qhZtcnUg09zO7BKu3rg0NvqS/tRLNW2NWuce+ZnOgSxbXQ257lpUDiFSsvjj8cxHQ+Sr860sIEh/URTPTr/aQ6iCicwSzUNYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233301; c=relaxed/simple;
	bh=73ACY2H/XC8HiFGPQdCgZZUhtUWvlcJspY0j/8nbnW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CV7LLBthPr4uveiRoTgimtf76f7g2yzaWebgV+ypimqGksAko9MhL7ysV1dJ15EzclAlrIZYqvCmGVJ4JKY9x7tMvISJF2G0BG8AI+ltDKoDhRneEhjdr4j0fqMvlNTQ4Gk4Xl8v/EJMTFaOJxa56syqTzAA6kjBv/AC1P3tdc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=nMRgZa5w; arc=fail smtp.client-ip=40.107.215.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIla4IEtdef4M8+8NxrZ/YTZZI/cnDfcp+PzZxbX5FN89VvqVNu9KCIpQgfVbHfrGOEz6kA9jYMEZPVi6HTs7i3kgybDTUJ3Tl0umfO3ImuriIUSCXyml0csh5OxBvgZ7k6nbw3DgNbJ5N1G99gs6v9Ky68YVpmyDhFbjWerbQUKvz8c2UgHBGUE2jz6SWWVFRSPSC0nT9xES2aWGQHS7rOAKVfpLvHCfSAz443OWpgk8nM6teyN2obqO1CEvntaHct/wih+UfDGOH8RwGIxu9aybr7dp+Gb5Xtk+qX2VBfZJv1d3zjoeTgscDeCFvgKX9w7f/Q6nj16lR8DbH7szw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmNKl6yn93kcqul1yKpNviuiMr4uSmPfzjmHAX59pcs=;
 b=fHDuMLpCxh7qIFrYxr/T1n5Fd9jCJIrlq7JRTkFzWJV4sb+h5tvPUkZyxPNgc+XGc9HozDno819aVK01qaiTifsCep4AxKjY3ZtmKkpqBz2g2n0D7msbUaQP8AkR+nDvXDWkdO0VBp2wkg5Yxu2SX+vhNhKTip5syJtr8wMEGaWNgoZ3ZnvbjqE08TJf0RbDfoBVrZx5EPWTa9mKaeSxvvtClONPP4KbWmvT8Q2oJuiJP5BTCIrXQzBP/x/+Fd502Ki0KP2h20/48uphZNMmrcUS9+K6hzNrzPTuiVE7+rB4A6e7+FmTmfTfymCHmLs9YHMPEzt7N2P+v17gwI63wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmNKl6yn93kcqul1yKpNviuiMr4uSmPfzjmHAX59pcs=;
 b=nMRgZa5w7zD/MWfsDWN6y1W8H8CjbO4aY3lwrEsdD7I1lwlxR4AnDlTcAKUQLcqdTSv+0L/NNB9pa43We7dHGylhZJe1jn8kJIjKnnjCnlUAYwzb4KTLtOhd3d00VFYnMGJphm9VjstzoaKC3PZgtes8wj2JQ1WVG5K6MQDt4yqGy2XLEfaAgEg7QnIQWJUtXgv/FdVxllFYQqaMv1X3C4aXP0ucXk3jQrHtM7EZqa5mpYBm7WrnmD6J8TaX0VJu0ZrNFkSu9ncNW7MKeCuJQEeN1GtQ7jFv9IzvfKGcYi5fb4E85C5/Ld+kAPW8nn111zdC97aIU2UUxinyloDwow==
Received: from SI2PR02CA0021.apcprd02.prod.outlook.com (2603:1096:4:195::10)
 by SEZPR04MB7698.apcprd04.prod.outlook.com (2603:1096:101:1f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 09:41:29 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::f2) by SI2PR02CA0021.outlook.office365.com
 (2603:1096:4:195::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 09:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:41:28 +0000
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
Subject: [PATCH v13 02/29] ARM: dts: aspeed: yosemite4: Enable adc15
Date: Wed, 21 Aug 2024 17:40:13 +0800
Message-Id: <20240821094043.4126132-3-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEZPR04MB7698:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b7b482ca-85bd-4df7-790b-08dcc1c56ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4INs1jNQ9i0qdRK9dVOxZ6V4dyMGs7aYECd0FgFUMCpX2D8D92pbhQcVfd9e?=
 =?us-ascii?Q?1pZsOVDY86ZKK165XSIqthn+RSU3MZIY60xfKQdzihUzrVbPTNhq8I0rp+P9?=
 =?us-ascii?Q?hiFX29+FqgJ8YXeTA25cOpA2rKzxPk3g3jNi5dEgRxVoHbjF0d+zAflNS50q?=
 =?us-ascii?Q?O13etY/5ChB+V9YIl6gCK59nhy7vSRsquaqB2UBHb7BxcfcHWYIb1uPz+bCJ?=
 =?us-ascii?Q?Wbcgnch0/0btB4GUQPH3IE+YDyAm4ckpK+heP/7Gh1fa1cQxoOdt0EJZwhbn?=
 =?us-ascii?Q?PBZ/zjGCBkqQIRiS+9A/4oS1f9ddcBnCFWHV/S5F/g2arZYWSbepUR2f5gxB?=
 =?us-ascii?Q?2FpQ6lHxhPpY/gQeUi14bmDF6k2KtJ5+jJJ5YgieajysbaWV9L+lGs1Khjlv?=
 =?us-ascii?Q?JOtcuxM8kL2tnJuzUvmiDRZXunrnyjnHD42ufUR16i36kSm8DuUQAtuC9hSC?=
 =?us-ascii?Q?CcLyAZEFbdtZLvZWIQlgSeFDiI2OEj0aJefCzZBsVucIRUfOTabXDiMMJrYI?=
 =?us-ascii?Q?5ZhYwFMTu2TdFdxqadm4I9/SEGGoo1/9BECmA1W3qSlGQzci0AC6XqGel4l4?=
 =?us-ascii?Q?BietNu58n+Lc/94kxB2eG9Nw+nArCJqZGJwQqq6VbxoifQwUZDJZndlTdE77?=
 =?us-ascii?Q?3YWFkLdcYw9DlNwrsQQNev/MovvYv0VvX8p9qvkvnkA7L9Pf9ArIhsBveI7h?=
 =?us-ascii?Q?w8RlZX8JEhkr8ckVZiyj7tdIX51KsLtV+65E4dcMcANeD9ikAhfW5CRG7bGA?=
 =?us-ascii?Q?jYGDz0bbUCPHFPPUFCWGsK2ijaEx5SyR+lAxzH8mguFxp8LH0PVjY6lpMMwX?=
 =?us-ascii?Q?96Jn5xoOZWZRui6PfKqDeoi/KmjGgc1Kt+BZuZrR+yHBAUj4gCcM0cRI4134?=
 =?us-ascii?Q?rIWU6DukTLA99A03crLy/HCIqw+fjrV2lx37LMouwpMddD6kwmews5p/4WEe?=
 =?us-ascii?Q?Mmt3+Edml+uWiQ9v0XJTc2KEbqln8/9mVdGp4v2KCYKgh4fH/CRv6NA3fFKT?=
 =?us-ascii?Q?Cgdw5xbN3lmm5IwupBRYTRAsoqXdYXBs1fD0NUaUO6t6Iykdq5dBuJVqvNXf?=
 =?us-ascii?Q?9/iedeSGRKa1vYzU3vGgY4XxOG5pyr/OXddUym56jk6dU+ZXfuXr82sbdFiz?=
 =?us-ascii?Q?0tpt4/62Ryhvp5GdrLovJhEThsDwoNUYg96+deblQANpEbbBtY5ucdjIWwyW?=
 =?us-ascii?Q?CdOAhnEem5Eof+H805fT/QNAgl9rD8NQQAZGUpdCPBnclr3QycFauQ5GP2Gt?=
 =?us-ascii?Q?+oLePi8AuRz1seL7/UG8cgNSAz48BgnRvJ4cWYUsnTmQQnmDdXYZmanO3Brw?=
 =?us-ascii?Q?aPYc2mKaGnw4r1rw+wHIbN4LLEdTw64EiG5Gt3GdHHXMFSQIVgXrMJBJ1r07?=
 =?us-ascii?Q?N+5cbRjPSfRXLDscdonYEA28dISMndU6YPRgww1lwkUFw+ZzTTyfUwrYdcn6?=
 =?us-ascii?Q?UJqRbtSaNRI=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:41:28.4807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b482ca-85bd-4df7-790b-08dcc1c56ed3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7698

Enable Yosemite 4 adc15 config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ce206e2c461b..0d659ee2bc19 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -51,7 +51,7 @@ iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				<&adc1 0>, <&adc1 1>;
+				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
 };
 
@@ -925,10 +925,10 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 
 &adc1 {
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>
+			&pinctrl_adc15_default>;
 };
 
-
 &ehci0 {
 	status = "okay";
 };
-- 
2.25.1


