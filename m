Return-Path: <linux-kernel+bounces-348693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D598EAAA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2ACE285369
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CA614431B;
	Thu,  3 Oct 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="HKsRjzrF"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2060.outbound.protection.outlook.com [40.107.215.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9E213F43B;
	Thu,  3 Oct 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941394; cv=fail; b=NFmz/AU3bsXGuCTbDv94hoHN70ZN0TyhrWtPc71SFTxUgbGuvR5LYsrK6fF5oKeyxxWmH/9ZbOjYdfZOaqA362VVk+DmZvAP1yskjadCKinQk4Jfj47fq5DYDXRFyeW0fBKDm8TgiuTbNgjS3evmB1++PCOegScskf/2pMTPLKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941394; c=relaxed/simple;
	bh=RhyyDXyKppJ2H0BdqDczCxKakdPBAgWgujuFzUqahKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgD9cVYchWE3qQkr7s7EARsIEoLJ/UjI6ZNJcjEskbC8Tc23+wCjjv6QnK0H3tlU5dsO1g7byipmMJulLbF+IXOKc8uvJuw381wMPggsTseDKv9uO6Ck0zPvq+Ah2vO8vBU+uqZHgg9v8NJgzydcx7UIobHL8nPSSyYJwpAItQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=HKsRjzrF; arc=fail smtp.client-ip=40.107.215.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cA2r/XSNRHn28iuGN9jfUs5QByFq9sYU+sskFVKBnwUHMBE3Uldc9Rq0TDcO6hgLUiCK+5vj5FbPLQPVtnQacgJHzog/pSAjNCiO9CZDFAndS5oXk1aBUPXKAyZEbjPXO13jEBej3GwNB6FUHx9f/b9+oXErqHJ1V7pHZgbkIipeLljtW/Xc+bdkoNr9NgEpid58TsR7li4C7W75oEx50/NvvVFIp5oOBt3/5nboCkEfcgPQ7SR1wJ6byUT0qVOJR9fqV458TKioBL86ELzrFtMGw4FYfSbKUYPt08elptxSMzsFOvGYEHcT/yjkE1UxvK2RoW+26kps35TqivFhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVk1jw2E6gIcbOSU2htwOPXmE0+0ppjK2N4w/u8DFHM=;
 b=nf9UWu+W++HqrE8pwNsO7t1ao9SJzbAB4uJfeTQn2p4jtwo7NQqPJaOR/+lrZnWFnV4vsj8NF5KtfWD+24xVvN3aX4zaStFCe3U9nWAhIedVYA4QGuPe6ZfaSsgf52WVKpHyOemNBFARdvaXlTxsuoVrYy5Ee91ycLOD6rlMjxnayBrV2XP5saJdUcUYonMgR3DUgITDj941DRCO2nxwl36pyzM77ifcIWZfMkPEqjhhkqoi6pcF2bq0GRdkkCVDC1QltZu/3+DBrCV0bsf/sElSyZC8R/jAhDxH3adZfkDRcdoXx8Y9fqW9Jq/lWf2wTDZE67ozNUkRLlBOy3W7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVk1jw2E6gIcbOSU2htwOPXmE0+0ppjK2N4w/u8DFHM=;
 b=HKsRjzrF/KsxP7gDSp39YGosMWRFuta9W+iqaFS7R7h3bM+km9y1kBkuZuIWnEOvDnSmpW6ObISUad8/9nIj1KWuYhe6dZQBWhXDnovBbOQZ+MO9kY9G/e2uD3iD8kZyYisbU9TwSw4IX4O5pcQIB/rX8tLVFp/cipUmRaZrLUM1nruOJPMj2N3Wu1yO3H+EQw9DSbdCCJdZ1WvpXS0n4TbgaZLUkBK20R/BC8med91x8wVYPgLZYzePkg9XfIv5T8gvbpuGLTgnwfYD8aRYSjagtftIvW/zl7JeGB3Cup6nP4T7aNpVTVi2Cwi7jbMSKvkv5tZ1VzXUAJonO8GmRA==
Received: from SI2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:4:194::14)
 by TY0PR04MB6424.apcprd04.prod.outlook.com (2603:1096:400:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 07:43:06 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::b3) by SI2PR02CA0004.outlook.office365.com
 (2603:1096:4:194::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Thu, 3 Oct 2024 07:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Thu, 3 Oct 2024 07:43:05
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
Subject: [PATCH v3 5/9] ARM: dts: aspeed: yosemite4: correct the compatible string for max31790
Date: Thu,  3 Oct 2024 15:42:46 +0800
Message-Id: <20241003074251.3818101-6-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|TY0PR04MB6424:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 550cf651-62a0-4b17-204d-08dce37f052d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/7xzGCrS8nEHY95ZXXUYKwrbtvxY9Rzi58/xqMLXZZs1ErYvMKVs4e4X09X4?=
 =?us-ascii?Q?G46M544uk5OHFllpKrtFtt1kxezyjaBy633LbHRA/WumR90BT0uqkM9XdJ4r?=
 =?us-ascii?Q?oaNhReCBet8kVXhsZe89yulNWRTD+a0AveEGDIBuBYxP7C/gOOZspD4xYZyV?=
 =?us-ascii?Q?Nv85sNJTrJS6G9kihUONGICNsaSFPZBRARF0sw24TF7w/kbGAfBhJJIPBjM4?=
 =?us-ascii?Q?wsuqcjqJetFjyIikjNaOXr6t2JiC08lj+0n5tnBmTbyQazRGdGwRmrN//jgN?=
 =?us-ascii?Q?Rn8722iEWh6YroHcVZLiUrUt93HxJ2gK9s7048xGnIC0YFufpSDiqjOXyqM2?=
 =?us-ascii?Q?yML2pv8hKJoLwJD/oEuVhN3x1lsGuEgWwdnC7Hp68n6hIu6LD17+xT+XBorm?=
 =?us-ascii?Q?0u6zHUyzEQNXXcxHnkwaN6yprvq+jchInaVZDWxojYsfulV+1DLaVMWVofe6?=
 =?us-ascii?Q?LVjueKJAxOsl2mMpGTWHsFuMpICzpgUVo53xoTDRa4G3cJmAnoyP1gZXc3fE?=
 =?us-ascii?Q?s7kOm0AKRJH7rR2JuGAGJuNfWMb6LTJtWLOj4PgCVjd7pSZSgPhx8EPdlG9H?=
 =?us-ascii?Q?jxCugGD0JpntoT+NR3ruBor5AJmgcH5iEnlNlh7CSJmQkiZjwCxrF/oFD6N3?=
 =?us-ascii?Q?JIweyrGPXIkM7LDc1AK4EFS20gEozYkCHVfCBTpCaP/QHPMJqkd0b677x9tB?=
 =?us-ascii?Q?iRTEs6xcs+o0fAyA3NIsyqxHPHriqifX+R18bMWusGV2dajuEbtZLG7NU1rr?=
 =?us-ascii?Q?c4iG4zBFgl430199YZNTXDbc1dbbolU4cLpjT5cJB5L6OgkSWSOdJIWChQ7C?=
 =?us-ascii?Q?AQxfKaqJTuSE6r60r3syF3OmucpEBS5xSmxX3ptSfmqkVewO75A3EdlfQCji?=
 =?us-ascii?Q?nO/Qul8qEHuY6P7UuOShS2NKinWEBWkQzc8NZB5Tb2v+Lw9qkPmRncGtkFjt?=
 =?us-ascii?Q?Hd1duY1IX8SplvQGRupbwWT6UYFVZa2RfejBOQxTtoRU/in8TbOKOE96Djxu?=
 =?us-ascii?Q?ckqduFhGYN9xSY59azSOGwHV9HW76yYJGQF42aiXlGSuaZ+Pvb8wKIMM92tf?=
 =?us-ascii?Q?KfQz/A/hQz3XyiSc8189gD9EpcDx2tFEGOJ49mVXRtZX1WQ1S354pAYu5JrT?=
 =?us-ascii?Q?rUEFSxUCBsG2/2ItT2tVZE++8dleRTy+SAHPWXJ0YEl1c57dXemySu+LtCCD?=
 =?us-ascii?Q?NjevQbUOK7W5oiaS5KW2iZGMABMdWe+H5PD8jojsPPMD09a2/Z3hVk2VXcFj?=
 =?us-ascii?Q?Ecj2Yp9+ecfvRRL+66gs6s22SM0CUWjroskB27jnrEioD/UpFo94MESPVp3A?=
 =?us-ascii?Q?9FYUPGl9YH0KjRYVeYLNhYU7d78MBKTbC01fXqDfWWGrE5miQLH/JYBHmqkJ?=
 =?us-ascii?Q?UXKQsgcDuWGfBtcLxIt564v865W4?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 07:43:05.9150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 550cf651-62a0-4b17-204d-08dce37f052d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6424

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Fix the compatible string for max31790 to match the binding document.

Fixes: 2b8d94f4b4a4 ("ARM: dts: aspeed: yosemite4: add Facebook Yosemite 4 BMC")
Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 5a995d8c326a..9a9096c94328 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1115,10 +1115,8 @@ adc@1f {
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
@@ -1129,10 +1127,8 @@ gpio@22{
 			};
 
 			pwm@23{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			adc@33 {
@@ -1167,10 +1163,8 @@ adc@1f {
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
@@ -1181,10 +1175,8 @@ gpio@22{
 			};
 
 			pwm@23{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			adc@33 {
-- 
2.25.1


