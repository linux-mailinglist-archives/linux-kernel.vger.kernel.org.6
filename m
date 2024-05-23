Return-Path: <linux-kernel+bounces-187248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF218CCF05
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9332EB21D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF9B14E2E1;
	Thu, 23 May 2024 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="p57qLBW7"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2057.outbound.protection.outlook.com [40.107.215.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E48C14D2BC;
	Thu, 23 May 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455953; cv=fail; b=rZKpfGZ7hPJZ9W2JJpLXUaBp0sm9Cgk/rZATCfzJXeqpcycQlWkMEpEm4HspdtcVwEs8fHSn0th4xZnZeJkx/iK2iehu1e1MG1lsRqTXwA1yJsvwcolf7AQ1pknZEGBdMKZQj5+Vq9MKXcyFEK1BOAoGgVka91/lWvhRBLDv9I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455953; c=relaxed/simple;
	bh=zxSLAJW6pbU3CgfYbjG8pJzx4jH9s83cmqcWyMwgprg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E22Qc0LwOR8GxqwRQ2L3O3i3a0RApa9c7BJkuBVQPZyi9nruQI/PGfiVjD5Ct/Zf2bksZIbylQqhd8HXRtppTgexdtjtMbTsnfP67D8BwRN9yH9DGilIeT048W+mOdYU1KzNg53/0cOZN/ZR7NxzdQhsVR3WsxcKlvNOwAo/FGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=p57qLBW7; arc=fail smtp.client-ip=40.107.215.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4wEGzIrCzAGqVmLc0KE3jjoZP5d20gNjFxxL0WrZjsxsLyJIb8r4KdawCeW/1xQslf8nFT9GqGgqMGz4hLHRQnmhXuxt5xKLGl4iSIAGrs6UV9lFsDJgDQZa+YT5WW+JrxfG6Z485x/4c427L/kHlIXBf7zQNMSar4HfWdCXHe+eWs5CzxBqVfmIjz37/q5jTMPnGQtco2drWdYNxUdEAEY3Fb21ScRFPA5oZOzAraa19NjuqcspsSna3JFkaLj6LjVtnK0rE+DYCpXdO9OtdrTVbwQo8l5N+wxKRCpg0QV00fNsBp60OwYggpEJm18NMHuI0I4e8tbMbpYHBnvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajdRlofMdvo42OVOqGXyRTdshC61xKgWuLqNg7HObWU=;
 b=H+m2wXaaGr7UOW/uQVriR5OFNEE6ye08KOEsmumjZaDdMGiejayEsaTxuny+5VscEip4uvJYIvRqAp2NQIuOsytTapa3Yt0PLzw1uc7i+CHVcQ0Koo762bscbiFBO3Ei+VijvgfNcXvJS1XARIdj5MUMg+W6Fy9DUuiTBgTXMmBoJdpzySgpcBn+/UwxYLwOt8R6f6cqu8r5GQWknaYoe8dW3sqWuP9ssUtAvNGsvJJI9zeh1NTvknSMfM8hYp5mJm3jk4pbY2gLGjElMMac1vZ+oVYn6TD+BW0tGzHH4jOR3lYJvNOdy0SzOLKtH63WFLlswQ98n2gszJELwiAP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajdRlofMdvo42OVOqGXyRTdshC61xKgWuLqNg7HObWU=;
 b=p57qLBW7d2OrO0i6Qdjus71wO9b2WFmz22MC0eRDd314y65eXS9TtGpN6D4UWe6+xXlAFnJZgac/X6lzAMgbrIW3xmKcU0TVCvLkQoiper4hnTmkwkIXgBh16+cOZ9YmKe8Z39VGcl9Uj+lJ0siVj+08D4I2uRk8tScEpbuEVlBIelWlMFb3KhjA7tI55ZCBE58Mwz0dL05R962jfsvUyPXjRI2ASmPA1jVJq6P07F3st1nirEDAn4KrDuU4/d18tQYGv5By60r+N3+siEnh61Z8Aa2MFVJWxxJi1HJTAA1JFHBMPKo6RTujN6BhEKyCvdNV+RelGCP9OVHrY+BrMA==
Received: from PS2PR03CA0011.apcprd03.prod.outlook.com (2603:1096:300:5b::23)
 by SEZPR04MB6355.apcprd04.prod.outlook.com (2603:1096:101:cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 09:19:05 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::7) by PS2PR03CA0011.outlook.office365.com
 (2603:1096:300:5b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9 via Frontend
 Transport; Thu, 23 May 2024 09:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:19:04
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
Subject: [PATCH v8 15/23] ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4 NIC connection
Date: Thu, 23 May 2024 17:18:02 +0800
Message-Id: <20240523091812.2032933-16-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEZPR04MB6355:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: feeb44dd-b8dd-4df7-004b-08dc7b096474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HG3gCMLGcc30sDMwQ9L87Oe3s1rI1dU7V1RyEGA+mo3OgTOk2DxdOZmMJWdm?=
 =?us-ascii?Q?x2giT1w2/68usHnYolTTO/TaSCee87EmywgYHJmGNKbMRrghQdjps2s0SG+f?=
 =?us-ascii?Q?1NWMgoWVLwB+xBZSEMrtHzDv8q1fVp3itbsg5mc7MBIVdtHyHQ1AieM0rVHI?=
 =?us-ascii?Q?XB5UKPtuihKNo8se8rk+YNtq9A5O5tlp6DdCL1gOzqpI8a2CEkLEbn6IwWJ7?=
 =?us-ascii?Q?352NbWicvUTJlSKANDXtfrLBqFuIvt30NFVexn/+S0VYipTa/r4ELJD1QycG?=
 =?us-ascii?Q?gqwwZ5rsxR6x4rrnEXjjkePhnqZ/twrGgT3r9/PMLOIRW00s0t4o5RtpNxDv?=
 =?us-ascii?Q?j84aqkaIauuYi2n5Ob5MfGU97GmIRuaW/u3x51bRq42LWgB8QOHX6KA6S+9X?=
 =?us-ascii?Q?Jugk/BRhWlg7EUl/XdfCM03wOxnpUshuk4WRAwjiwGGlMpvJEOFitepny+j0?=
 =?us-ascii?Q?RXOdZrGjghTlzZN+CHqwcG3fvbjLbx57EkSbyTf8sfOjnJh5MIKBBRhO+ysQ?=
 =?us-ascii?Q?Mg18GziX4pQl3SC1vzrnuwr5gOYk+THOf0ZkSK4BoyjsYZ9MEvXz46+J6eS7?=
 =?us-ascii?Q?qPFaQgWJD9JggDUkmMTme9Sk7+DEm4LAU/89dVKXtdoEaJxq1ocZqEwos1tt?=
 =?us-ascii?Q?sTEIWyiNdvNcdaoPQHH4Dmyh7OIuHWW0DRyI1q5nTb0APIurAY+8zym2QV/A?=
 =?us-ascii?Q?Uno3W1k+DVP/gpDHKJOYaz6YTBSnwSWcJc2Oo+0Z4PmJd1s7/vofBwHthF0r?=
 =?us-ascii?Q?EwN61/aQ6ZAllqo7+MGX0ZPCobxbxH1IKNnW2wsUBHo2WIBu8UOnIueh7/EP?=
 =?us-ascii?Q?26q4LwvzCD/05fsqdWJEGdjMOvC/xvMOY3bSSuvxrH4bwhVd9ioeG29htwn6?=
 =?us-ascii?Q?6CL+RmVesn75a48aIEGpOSZIwqVzsRM/snVeZHnezoONnAGc4rDSQYwdXJSY?=
 =?us-ascii?Q?JQOwhnjiPX7LJIGnO0l7UpAhr7I93Gbiwse1adN8CTAbOiSOo+lEkcM24UuQ?=
 =?us-ascii?Q?9H60yYG/ys483hZsbTPcxOFTK5S1uk6LtMOP4psQP0RqNpkPCZZztI4BO0Hd?=
 =?us-ascii?Q?CZhIR3Ae//knv5nPY7jWi+A+Kty4fY4g9MF6qnbAWV9dysF1Qxk15FE3w2Jf?=
 =?us-ascii?Q?aCisAs1CdhA3zGgll5BSS9hKKJbzVOTIZBMjF3XIHoFkvdQjUPWO8MoZRFvC?=
 =?us-ascii?Q?9o8jWEzEZHaHsm9Jl7Dy4b0k9q5prIa/ucF1d2RPzkm7FZPSlv0nDaBwGtIk?=
 =?us-ascii?Q?LM6Q5UVGC/ibPFPPRB54viSs9QHSJkhzUYhBt56qoZn3Qwr2LFGFsYGSWdPL?=
 =?us-ascii?Q?aHAFkTaqRknxWrsQTxtU+znuWahLfYR72BwyblguywDKsnHUmJoDHi3mf43V?=
 =?us-ascii?Q?kgfyJDBKoBcMubFoHbE5IrsE5WeW?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:19:04.7826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feeb44dd-b8dd-4df7-004b-08dc7b096474
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6355

Remove idle state setting for yosemite4 NIC connection

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 67e3c787d675..8b23b012d6f5 100644
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


