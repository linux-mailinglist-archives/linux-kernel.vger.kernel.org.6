Return-Path: <linux-kernel+bounces-345474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8645B98B6C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6205B220A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C9319D069;
	Tue,  1 Oct 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="A6fmLMcr"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2051.outbound.protection.outlook.com [40.107.117.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2BD19CC32;
	Tue,  1 Oct 2024 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770875; cv=fail; b=gYWeDlo7cXbbfK8bE97t3g39+VgPI7Tk/wEs7a/H8M7lc2O/gvQtuWOkdeQD+Zg75dCeuvRMfH18lPcLbzD1444lU26Hg1a7QHWKM3Pqrao89qe2fPioZ/IPVTDyD3tGxEB/aocVwt3GnJuHQM52ggWG1zAl83m7M/Z/8B3LKXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770875; c=relaxed/simple;
	bh=/opvT+mXOg+XtwMBqHeR1fsY1Bep1OxNQY2jIemDB+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQoI2yDnMyjovkIpv96Ja972v7VfLppzQE8E5BzgAZPSj0hBSf4EIzPKiMLs3FaCvREc75K7Vq8yJjfUf/Sjk6yICfAgF11a2Ks87TuNyZJ0j3o6S5+vP8F2wNfYUrUVHq7WCMzK5lkC8nMSw4v2H+qqpFXTMPU/xvhQSIFPRVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=A6fmLMcr; arc=fail smtp.client-ip=40.107.117.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJy/fjrFrVEjSnasLq/fL//mC4CAMul+MfRdU9nu+OEK3ztklJ4joFczT/QyncMWCQHNkFoUYrNbNa+5qwswxVOOP13KJzInqfLE0QPPqZbm0RGYZ8+NZSg7f1ON8z8WSgEEZgx7sLkhztLh7Xv46y1Bw70Jx6jkLDaAF7XZv0uHiqEZ9iV9sIm2Ln0GBwMA4fYdbRfdTyUx9p+XQY55+2s3mAAdho3Rj3LqZC2YGYXCVKvRXwWYUaExj3V9cGN566pUVmI3N4Io0wEBS4whfBMahfmtw5NehFw5RtmblDaVNyBPykUmIpRL3kftooxHq64RdxD+tcr3+9tNSqHu/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eZceqFKLddY5TxYoE9EYsI11S2/ZQET+IX3mxvnios=;
 b=Bp2SGzI2ckikTZNHYRpBd4+OR23YCVqf2v+7X4YDQC0Fu84G0TqUDoh/heH1R8pWqQczL68lD3PIEsIR2pxZyu9xQzWPttXTk3KHKqyXnrajkXy3Zz37Kx873oNH8x0IDx9LLVGjjOdZphuFGdjhihXMkA3KOoJokW0B1suurhJ6XQLs1DvZ2AUI/3/4zGfkrMZOaq2GuooEUPckl36mOZqrsG0Rto4nOEQrU8/Ek4QPBoVWbKdixKLCfGFhJ/RumXHjjOqX4EMjo8+yZJCcE/lEhnXmT6W7oNec9M3A7KRL1q46y+722Ip4uQ3hKzdrCEmoYr0W2A++obs8tCpjKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eZceqFKLddY5TxYoE9EYsI11S2/ZQET+IX3mxvnios=;
 b=A6fmLMcrHGWeh6YN2sFIQW99sqbhS3nJmhriaPg42gHBOXadZbpPxbTGq4bvY6WARI+2NsDQrZeeYEhzHye9ar7/bfJ1qcrJTEqbJ3BRg0r73B2HW7XYRm+vL/+ZBhHSABqbqyaH65MT9tsRf0QqC26aZWM+8df1gBsqGF1rSbRFT0e9r1hQG8DFymKjXVXzBIj+YcOXOWHVbMe1XKSUYsd42nQjix7sIfxnYgM29KWTSx9GhW1P0QBssUUVJhqPZdrEL0cvD497/qBUwvvVeu3UM0YbuMjiGHYcW26+kVbNVW+NBMPhFYQcOaa/6e6JikHWRhx6MGH7woZ8/BhwOw==
Received: from PS2PR02CA0073.apcprd02.prod.outlook.com (2603:1096:300:5c::13)
 by SEZPR04MB8026.apcprd04.prod.outlook.com (2603:1096:101:238::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 08:21:07 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::20) by PS2PR02CA0073.outlook.office365.com
 (2603:1096:300:5c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 1 Oct 2024 08:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 08:21:07
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] ARM: dts: aspeed: yosemite4: Add required properties for IOE on fan boards
Date: Tue,  1 Oct 2024 16:20:47 +0800
Message-Id: <20241001082053.3455836-6-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEZPR04MB8026:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7369422b-3555-4f8d-f50f-08dce1f1ffaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F9pC1OtHspG93VhWO9MtU0USwr61KO7Py+SwICLnpxN5YdTngXc9dBOftS+D?=
 =?us-ascii?Q?N0OR7VAK8vtxTD0VFvn8tkJo7TqRlc3QstfXpAxhEOkfvOnU8b3p3Ll/urXU?=
 =?us-ascii?Q?zqu9GpAKrk9iie8iaxBwLpGn8aiQeuDLviiLLBEdfxMvRBCisgZxAR4w2XMJ?=
 =?us-ascii?Q?SJugIK3W+RsomfYz5DfdnCadYo7dAbsGZNml/VgpS+H3K0JZ3Y9dygezYkJV?=
 =?us-ascii?Q?/n+bbLZKtWbA/6SBwK8meYmYCQ5QJh/csjNuM8pU8Ey53SXg9SAeICFItziL?=
 =?us-ascii?Q?KrQObpziJA7+/8G49VCw8AIt/PhuwDk7XEqkrh+vkoX4WKlmAlgmBdm+6BVh?=
 =?us-ascii?Q?e63unRTMqpa12vfF27tMdmZDKPIPZtAxMtR0FTa2hfIX7TPKFYixKQY571D7?=
 =?us-ascii?Q?H1hFhFRiMbtJcNhKu22hp6CgsPT/bClKZdslXWy5ZwFsgDmQ3RfKIQqhLXeg?=
 =?us-ascii?Q?15yEcbRMlvD6lWnCSrGcio4lpGwFrI6ajMlNpRxmNQ521gADH2dsJgGezqjB?=
 =?us-ascii?Q?hOHK+gUu8s/OmILgHXESAUQ+aH0MZGRtOwXqVU6XMfu69tb7nUIdujvPRHdV?=
 =?us-ascii?Q?btJ/Pj4BKU3EJPylx4NSRAvLphq5znE0huvAQkcQFxMd6RH9KDUwyxLvq0TB?=
 =?us-ascii?Q?+bKoDbyWDJBiYgJtxqBDxoezAH4wZiBxG36VaIAlVe1ZDuitlsVRde66n6cm?=
 =?us-ascii?Q?skSzKzDAPFW2fRHJpvDH+X7s3mlvWxZm4nV1EW83M4fQNOH/lRg1cIvnN1xO?=
 =?us-ascii?Q?kfOytg/JI3TSj+jct6WgfxBArvK3rgK6bBBLLj+/qevWhSFhiy+W12GP0Lkc?=
 =?us-ascii?Q?78dT3nesetoqIiASLXhLKRLCroi0S/Qhv8qKXmk8iCiCjrtl3dL29IVg+wX1?=
 =?us-ascii?Q?deI8fYLHlZKcGvHBPp8DodTyyAfrVTyBW1Ki7Df9ZLiskmjAN1+JKsUZQK68?=
 =?us-ascii?Q?9CJb5cHjcc5b5uS6q60eWcoexD6OdPBiwfhMuc1TtXlEaUAFsueqKdZv9vcK?=
 =?us-ascii?Q?cQXeFjpd89ORZtz/JwsrldA98HlBzp/ZNwPePf4UC9jPfHDOyLKNVKv5V8f8?=
 =?us-ascii?Q?4lgsdPSUJHOVHYcsEXbSE5s/6A/EXwIuy5O3u35jDrQ4nug3t3Wx8OuyY53P?=
 =?us-ascii?Q?3bSD7GPBJgCA0P8EBxaoc7mePhnDzvwNB/3lWn48sZN7l5lp+eMvJBqaNoph?=
 =?us-ascii?Q?e6kAIsmJJdOF2S79sxPe/wQolO8cMZ6Vvc7StY1pnrRw70coHCSkZ/jdkDDy?=
 =?us-ascii?Q?t7wO/0CSH2lwtwhAiy/nxWkGS+yJQm2Jn1crMp42liTrBeJrbU+jGrEJAZ1I?=
 =?us-ascii?Q?gDTkBta5w+2yKMCk4hoO7OEJuyNfWp4dhRoLOeGqXIe5OSrjJnJsWcQg265o?=
 =?us-ascii?Q?7wCMNE4tJGKzRjHq012XCBBlB1S/?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:21:07.0185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7369422b-3555-4f8d-f50f-08dce1f1ffaa
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8026

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add the required properties for IO expander on fan boards.

Fixes: 2b8d94f4b4a4 ("ARM: dts: aspeed: yosemite4: add Facebook Yosemite 4 BMC")
Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 26e0fcbed8d2..3ff22ec8de02 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1152,6 +1152,8 @@ pwm@20{
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pwm@23{
@@ -1202,6 +1204,8 @@ pwm@20{
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pwm@23{
-- 
2.25.1


