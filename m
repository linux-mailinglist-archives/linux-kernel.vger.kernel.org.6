Return-Path: <linux-kernel+bounces-187243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8748CCEFA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD827285837
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213F14A4D1;
	Thu, 23 May 2024 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="wuPPJ0Ws"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2043.outbound.protection.outlook.com [40.107.117.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917614A0A9;
	Thu, 23 May 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455939; cv=fail; b=Si/ETfj8eRHt1eCqt26N5HTz3DSBe5Sbr7ijxmt+XBeBZp/1E6Vz5Kl3umsa9823wX7ncz5+GvS7BWYrfIzfB9lR2AX+oqJ9U3hrc0jU14tFgPmWJA+v7BPileDC4kQ8Gy1EqQKw+Sg6BpSJp2vsOYdzt8ZKHJZGw1e+wtwy+LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455939; c=relaxed/simple;
	bh=9yrxjPBeJF1QV/4lSbFupr+SCdbmhwNHFRniZXb4Y50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1NQZ3Te9laySbisu4c+5T8AmtCiU5ZpVQhTe4bi3aZOebhKjg1955378Rf2z5GnB4Jt66mQsepdoZf6VI3fl/37J9oEnzV9ehtdqFnUxnrZ7QGKTc3AaCbajGyYfWit+0hXxRwNxkcJNLfhSLV82fPHL0xuHfdBYvaWJAVm87s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=wuPPJ0Ws; arc=fail smtp.client-ip=40.107.117.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBefVbdgnbdHv0vbP7zdRaPfhAXLBRn7v95hr71IWVm5esqw7aMn39V+2M2ZTSVJa3wv5DbAUrsIAdxZvoUqyBFVxp6Pwpgl26jq+ted0Tqq4BHh89/LeQQ+R8SE85/+fciIEDiq5Z+B3fJ0PA+oWJeobu2uWE+zTQVV54To4wHUnsIvcD4us76JPXMiTTZ8amLOmXGlsWHA9WHRTfCqcVf+3DuBThlK8EF0JTy0Co328Y/AD9agGIAasl9Nh7asXW4d7F1YKNk0IQ1gyLIcDNlfxBYcnGcmLUJhHRrXNMy1XzXhlC+9S7v0936K7Bas1qYHPJ7QJiY5GgfK8XKg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pjrbPmUmdku7Zq8bJDb7/0Mq2EK7dm/UVhdSc/M8aE=;
 b=Qd80aVTfTKI4GF1HyUAdP03yhuucAL7j2MD7XI5UIiEFHKT54Z6QDJQcG2nwl8U/QsmFiJ3o9sdQk8dwD6PiGr0FfJYuEVd/+7Xv3fgXbac1eo4l6YC4GUDWx3t76TZjx7+MimwAHias00nP5nyMn3iHCxBI3fn3SnxCywapDBKPCvep/zBxIYZKiVH2i9zebtYfD1M2DQRaM/G53x3vCYh6NsZacLShEYIuqosvWkkn4qoRSSWyKJpEnr9qd4BLontcnoH752zSa9AauvsZe+9mBFy3qgp11GlS6Dk1w4s2xZ9m99VFanM7WlKeAO6W9UTqhoE59aOn+PCXneehng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pjrbPmUmdku7Zq8bJDb7/0Mq2EK7dm/UVhdSc/M8aE=;
 b=wuPPJ0WsbTknwa11OSciPSwL1zuKvOlSkPaNDxQ17cG2AJeJsFpM0U0NwuF70GrACSzxv2Re4oho1Uhpf7a7D+ltC+UwX3wFuJbsP6oFJobzEtW3FVb2hEW+aJCpLlcYAZxsU//jTXcIAFLT/0q21z/8DwoV6AF6aMa4kq67QJ9Ub3GTzMxoX4oVazZOF6aj+241f17ArJC3/xCAkGv0Njomrulg8x+HxSxsjbDam1afOtjFtjnNh92Zjv0/zBViNCEq8Ni+uQirIqu6Xl/INLLZvIT10ZDIZiAbqyxiGtukwAEBz30j5m7m5JZW0oRKKihTkhlJFYHi9e4iVtrZeQ==
Received: from PS2PR03CA0024.apcprd03.prod.outlook.com (2603:1096:300:5b::36)
 by TYZPR04MB6427.apcprd04.prod.outlook.com (2603:1096:400:28d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 09:18:53 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::17) by PS2PR03CA0024.outlook.office365.com
 (2603:1096:300:5b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.6 via Frontend
 Transport; Thu, 23 May 2024 09:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:18:52
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
Subject: [PATCH v8 11/23] ARM: dts: aspeed: yosemite4: Add eeprom for yosemite4 use
Date: Thu, 23 May 2024 17:17:58 +0800
Message-Id: <20240523091812.2032933-12-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TYZPR04MB6427:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 50e1a0b8-249c-4b06-905c-08dc7b095d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|7416005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YLRPy4DBAugVbqBbKFGbhe2vn3O+xLEOB8svGyiL5khXR6jjtExss7OGUfQv?=
 =?us-ascii?Q?F6Kp+EK0iufWaIi1RQVmrThNvR9IvPrX89yYBVQHetW04KrXRynybjdIZCFW?=
 =?us-ascii?Q?uxOCizjTwpaMGtwWKIl7xjSTI9SbkeEBaz6MP56dMc5BZ6EkUc9yOieJywuw?=
 =?us-ascii?Q?/XrIWlnq1uPFLWUCyAjTBWcjwvIpFGBWr98SSY9lr5yJ/WLTdqYQchQ1+QRs?=
 =?us-ascii?Q?CKfzcKFe/qxZ806+WZJFAL2Hf3LC4mn20l1rJ3f+hs+U6zQSYw3IB9QMcWEg?=
 =?us-ascii?Q?KPZIU6bO59Ep2Vz36IS/7puytbpGYNAeAObS5QcC28/yh+BOxLTBX5egBx1c?=
 =?us-ascii?Q?xrXzZBRTQFjadhzcefk8Y7maqHCCk24aN8zs3DO3xhr7f7ZqptHTJKZKlXDA?=
 =?us-ascii?Q?1Tibbbgltm5JRGHd7NdGU+zp8WYZLHW3zfGBx8vxjAGtJSC9nnroFZNm+neO?=
 =?us-ascii?Q?nGAKbLxk6ymhcNYw9BuaSGhqlfnmX+4cb/x5neqbKQpNaSvhtT9RYE+9zNgi?=
 =?us-ascii?Q?cRBM8h6wumMIG10nMfsjYFdoI4QH1Pz0Do6Fg92ugRURL0a9rczvoJG+UG82?=
 =?us-ascii?Q?4EXwwe2E2E8jRwBXpORfDSU3ao74/AIkJX8+E745ZVsXjFBgw3HRGL+ugECx?=
 =?us-ascii?Q?KsGHz+t5eKXg9ZxzRzEEkNwVdNajnxf/G5oq7mJ7XZEV9abXVOZ9RAe83TGv?=
 =?us-ascii?Q?roHpsQBtozGRYwAPR2K7asBlC4I4Lgd/tb+MZAn7siU3Y4xCPvO4ntpO8gFQ?=
 =?us-ascii?Q?pyTdN/4g4pv8B4A8hChQfJ9Gol4yckR2jC832w7T5d5KemADQbrNeoz4SqLp?=
 =?us-ascii?Q?PeKGbBRLgBjWNaQn22rMBcYZcGt0yQUDngzI+u6nWoBg1BhL3XQND26DdUej?=
 =?us-ascii?Q?2NHsIYRKf7j5wQeflh7DrS6e1Hf8bR8cD9YOxw43wIqiFe9U8CTUAfRHHDka?=
 =?us-ascii?Q?pXWw+Ir8PyB7oCvZMPW4Qv64vH2UigsopsQsFWYWrCZrZVwwv9tdPACyxdvC?=
 =?us-ascii?Q?OuMhSGL72Md76ROAhTfOSejVNuJxZem13DA5j30K98G9sAcizZXzSLyoeXIR?=
 =?us-ascii?Q?3pxpKAxsAjpbgvR5vbYoUxWlurBSYPpWd0q7sebPO63uy6Zmw8g0YXpKV0VO?=
 =?us-ascii?Q?1DXCiD1uh6faqvasFOFmmldLGujgNSOcYRCSuJxYAXjNT2m8NotWyB/6QsZt?=
 =?us-ascii?Q?ndLXQR9UfLaDYDNtJ8l51nHsseaRHJlUkbLiGpIz69af6xf6wPdHun6H73qg?=
 =?us-ascii?Q?ylmt2InBL8/lOGRWszJRrWAFTw7Q5jRABSIZ4yFpIuVtlOb4NEMW16EO3H8C?=
 =?us-ascii?Q?FAn3D0zOYkYz1en3ExC+oMNcBpHrS9mvJQikXuihCDXUZib12Eo71Rurbd49?=
 =?us-ascii?Q?Stc07R0=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(7416005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:18:52.7670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e1a0b8-249c-4b06-905c-08dc7b095d4a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6427

Add eeprom for yosemite4 use

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 2ac872878acd..9a14f0220cf6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -932,7 +932,7 @@ temperature-sensor@4b {
 	};
 
 	eeprom@54 {
-		compatible = "atmel,24c256";
+		compatible = "atmel,24c128";
 		reg = <0x54>;
 	};
 
@@ -971,6 +971,11 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
+
 	rtc@6f {
 		compatible = "nuvoton,nct3018y";
 		reg = <0x6f>;
-- 
2.25.1


