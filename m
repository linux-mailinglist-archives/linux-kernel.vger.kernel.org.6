Return-Path: <linux-kernel+bounces-348696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A281C98EAAF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4694C285885
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC2613174B;
	Thu,  3 Oct 2024 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Sb6PMmAO"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2060.outbound.protection.outlook.com [40.107.117.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E171145B22;
	Thu,  3 Oct 2024 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941398; cv=fail; b=WiRaSIliB9LgE2n1nghY28SKFGuaJ3MYD+v6xP77+QL05r2iKrLAZyjgvDVvT7nkJEWRzJprf7VorPgd5UTz89gX5zeK9mAq1pvbZB4LN7ayBM1DqNXZRTYL0GhYQjb1FZgGDHIM4Y3hL6IwbaCTjp2h4C3kEKel2SmRHfJtonE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941398; c=relaxed/simple;
	bh=zyUXrU49vdeiQ6+VPd6lg0+d3IBLH+eoH+iwR+mGWso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tc7tCyGk+Zz2q31OMhD0dLaeDx5pRaxG2h9j+bR5mv8YL4eaJKPyLazUdMYXPqRah0Z2xCHWdeE6LSnQj3qANcAA8ufZlzTz6REhBl80GZeebZeZiuEOo5pQo1AT+Jj6DaL1YO4iogxDgSVq+wKMQ2cq+8Ayn27HUzv0FLYwkOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Sb6PMmAO; arc=fail smtp.client-ip=40.107.117.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AN+hgInnDJAm0c4kpZ3+AJMgVCO6bzlEoP3xX6eedvg2lQhfrwWlivCAgkY3yE1MT6ajthk8Vt49AQ+C4ZTkrGJMpRNTuF06jcLJTyVpGnaoFQ2PiCblShnKM/emYPLeGlh8NltfOG4q9ng+ULC4pnNC/nkAEfTqBGRgvexiz+qtyFtDl/nx5clkW9aJn2T7IHl0cAYFvenoCfSZ8rkqDAaT3FA7s7y3xa0QK9YpDXK/mzsYOzzNvHLxBEGAZ+nfNgtZAyNFnQrsIppa7HEic29f58tmWQnlHenvHukuDlfFjJfbX8qczb7aGfBXDkVSihvqMrUiGRyuHx4suzCZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkxvIwnkYZFIS1Zfelb68GP/oZV0OWXzpR4GQrE2Y3A=;
 b=iZBKLW2rul2qbb1XQxv5PugXgH9HkppQzWG5tYulLoVIkgnRrOIk8P+ypiytzcyxNUmyrYeo59F0GLy4Y3TSr9PHBqHrkiyJQ/w29TdM8bTu5wf9W+Fl7GwfrWkTC4JlHge8s6daGzPLa+KAAXu+oG1Xko+ZGO55oMczYtEdPXKJSQrkUarPYJumfBx8aLCe1n2JcYjeEvgToExHKu2q9y7BUPumEEKFWhZDy436fGssq5M726wTjv+44ruKmICfCyKIfGiVtUWyBjucJ6wb6dEMjXuK92I5HqPdXRXwe/8S+6qQDzrCNuiGsXyDCh7YgNe1u00TVlFU/9L0EnXKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkxvIwnkYZFIS1Zfelb68GP/oZV0OWXzpR4GQrE2Y3A=;
 b=Sb6PMmAONLZAFbViqa+C06aVr7glwMTRrIInBSscCUtiAOWShYH+2PtfcuBzGARNJMCDK+5vKbcZrKRgcUrEhA9QxyHWhRpvKZqklBSwPzO7fWU1SUvw3R7KD2+1U+EiBUGP2TmTROTU71JJzWOytvDqQMk+rU0IxHzLk2diMiXXuqGP30foCYvl8l+9OJlsLHAyi8hb+eR2A+OJQivAwI8EPni6A/JZ2Q1tWARYEeGSNNarLz9B2/U64dQkychaH6w+ORjQZ6zJU6G7PG8v3/zRRf5CbJhwbYksXd88HxUbXWstkW9pn0mCdleTPbck72PK5aK+BIOkwAEJs6h+Lw==
Received: from SI2PR02CA0007.apcprd02.prod.outlook.com (2603:1096:4:194::23)
 by TYSPR04MB8127.apcprd04.prod.outlook.com (2603:1096:405:9d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 07:43:12 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::bd) by SI2PR02CA0007.outlook.office365.com
 (2603:1096:4:194::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Thu, 3 Oct 2024 07:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Thu, 3 Oct 2024 07:43:11
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
Subject: [PATCH v3 7/9] ARM: dts: aspeed: yosemite4: Change the address of Fan IC on fan boards
Date: Thu,  3 Oct 2024 15:42:48 +0800
Message-Id: <20241003074251.3818101-8-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|TYSPR04MB8127:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 96ae80ec-d029-4890-26be-08dce37f083b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5sAF5nE4lzL/Xy8hUNGc+4U+prCtCCCGEQrqgyzWVDfvoTFSHEwXhxodx2LT?=
 =?us-ascii?Q?xbo1RnUDJS49Kqh47IdnguiUYG2yHJCwq9RGjsryBpfzLiwi3gxaBqcfc5vv?=
 =?us-ascii?Q?PNj/qnldc3uikp0+CypglpTMljm/PLUIwMBYhNBc9yu0/1gC2MDO17KDfiFm?=
 =?us-ascii?Q?91C+BwMlx25mqoST3kmhoTh/Ca7X9Zm1kt+QyVMj9+7d9yjEbS3yX1HnzCp/?=
 =?us-ascii?Q?TAcBVO9wiinwsPRRajNteDcp2RHoQQAKdcVOfe1Q2lJfykIogoCbSdSLMoYr?=
 =?us-ascii?Q?QE9NSTGgFWc45TKZ8A7pmKgMTeOGZy+3U+UmCkop86aPvapKHzl6b9KLGmfx?=
 =?us-ascii?Q?Zy4RnRsHVws6sfWm3vPtYM/D8raelhP1I5LK+y2jCFl3tgh28KAA2A171aKi?=
 =?us-ascii?Q?1v1kHvUfqMXucGMJTwd7XfvMATM3u+dSFsaMd0YIvd7YF8CafCe/X6faOj4x?=
 =?us-ascii?Q?MnkRjPyJHQy7Vm3x2eIJZrWSgQ2FNTCdBc9m7raDcV5oK1GAHgvnDI+Xak74?=
 =?us-ascii?Q?m0I0/GUMUHwnCKBBSA38JzygiPAOS9+WpqREs92Mz9RZ3Hur4n/ttw/fUyqe?=
 =?us-ascii?Q?gVDDpRAO4n3pkQruL+/+dZ9n8okb8wO6b3K6N7cXpBCc4Gg5pG7L/gRGzoDu?=
 =?us-ascii?Q?3GVK1v8zSRV5xNuT0YEk3Y9hThz8LFudjWfteh9CdIjsFKFmFnhuxscUC1KJ?=
 =?us-ascii?Q?TT6RWk+7KRFrYHEnl78RlGCPmF5Hu+McuLTzdGNSYaPAD3ukqGeeAncmb+tG?=
 =?us-ascii?Q?ibl4UuAIjBttjGQJ/TsLZW/S/N4g3P1uQ2F2eA/CQ44qpvv464Ijoc1kfXho?=
 =?us-ascii?Q?ZaNgipWBC025IdZYjF0YtJMOmALpK218wp4gPPXEvF8Wff1IdMOPhMPDu9Ms?=
 =?us-ascii?Q?qInHooYz9YDC4C4S+RJSl6+PIL7AVt9u38K9xUgBrKsMc5x40VrnWrB53G1I?=
 =?us-ascii?Q?GLszFWbGrg0Rd1yFkXWgxGZQD80EG2NzwAL+WiJOYshTnIClxXMP/p3ophpp?=
 =?us-ascii?Q?H61KnqjCYS25KsPLe/H2Lj9TiVM49gClUvbz2wi1uhTdPY5s+1Meq+qvj3h+?=
 =?us-ascii?Q?5dZMdprh61KSckGyDcFJxLwOuJ2Pf5zp+NQULyJ4LicMPsRIAQZr+0vAJ8+d?=
 =?us-ascii?Q?QhJ3AYcri/OCnme7Nn+QA+K/obsmzye5BC6a6F/qKrtFBCuYhpTIevDG87p6?=
 =?us-ascii?Q?dZT9ZVdSM/eRnPn4X7HOFtSVhHGB4nWPBBT8FeqH6LNeZ4vjgzrudada1zBg?=
 =?us-ascii?Q?7TG5PjC4y46JwYD+rhZajGhnOvcu8WqeYWu0oLAowl3IDWoPHTzOCHE06m70?=
 =?us-ascii?Q?HRbsAkGNcHMFfPsfIGdHams6AELPJZOQoBwc3OdjWKg+cQLuCSPXaFqvwzEs?=
 =?us-ascii?Q?JNmKXA2bELBjuMjaFte9zwuIMS0S?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 07:43:11.1026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ae80ec-d029-4890-26be-08dce37f083b
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8127

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Change the address of Fan IC: Max31790 on fan boards according to
schematic.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 7531ac217c81..6b8fce786963 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1160,9 +1160,9 @@ gpio@22{
 				#gpio-cells = <2>;
 			};
 
-			pwm@23{
+			pwm@2f{
 				compatible = "maxim,max31790";
-				reg = <0x23>;
+				reg = <0x2f>;
 			};
 
 			adc@33 {
@@ -1208,9 +1208,9 @@ gpio@22{
 				#gpio-cells = <2>;
 			};
 
-			pwm@23{
+			pwm@2f{
 				compatible = "maxim,max31790";
-				reg = <0x23>;
+				reg = <0x2f>;
 			};
 
 			adc@33 {
-- 
2.25.1


