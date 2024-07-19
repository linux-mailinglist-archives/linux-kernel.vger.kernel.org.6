Return-Path: <linux-kernel+bounces-256998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B629373B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120D81F24BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6174402;
	Fri, 19 Jul 2024 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="OS76kLSp"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11012071.outbound.protection.outlook.com [52.101.135.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D674079;
	Fri, 19 Jul 2024 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.135.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368855; cv=fail; b=F/gHtTsr15hJTk+LwiDzTgE/P9k6lCKaZ8i3kPLXWj02QnDWNevSEGzadwoLm0sA3bUZegcFSFR3ZDGYSTsB0uTeDwTIrBRw8UlmPlBbfeigHfvFfuGccj7NdHYr3MqWUCzsLoxm+4gzHId1DT0TZQRhuxdCpgS7lU1dK9Fum1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368855; c=relaxed/simple;
	bh=hlO3lXCni/1q/kb7fxUehMkLx79dHWk0XBPB/to4DPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0xJMKSM/sXBQTmVoXxSHyEvJRJ2uyNku0iW6K5ChR63cyJZ5ZGwXf3KmSBD52u3bIOx/nZBtGeV7BlhGRJib85TqEY4su13exzG6BOGVFgEgVaK1rTF+9f8WOOO7a5RNZ0avFPS0Bi63DqndBgPO1qqSZbp2lrogiPvw0x/MiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=OS76kLSp; arc=fail smtp.client-ip=52.101.135.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6GSJVmxCfN0OHflX71lHd3/RWahiH0liSKCyqBOiI0wBfXZ9lkXOnTBqnikvwyUv9EitvKigmG2xsss8MSQDuBozIzZBcroaOXNIIwAHaldXl7WwVV27y91cC4iSkBoTwZSiLrMuEYWhh6XpeGHqIngpwFnB6gEG7uZQGdZ8R54Qn3pbehC03aonI8yuJGRx0p5upWdDUMUcqndQ4sRSOMEzXNOi4xolOHEZxKHUzV0Riz8vJjtO4liybAmMMtBwtQRag3yj3EnuA05Dt+1mIrCOZlyQPTHQ7yNoEfNOqPoV1aHO+CoMtoooNtNgzCYEW02F6INV2ljam05fw/OjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPuO9qcjCRKT1hG8tAOI8QlF9L4C9eaYFzPaHsZZ6p4=;
 b=ZLUWjeWgLNKZBr8OF9odyUVKqYSA+xNyye3Uct95mpX7uCFTD4GyQlqO1sufM+xfvO0EiKTtHc4M/93RAJZkwQdLaX/SIzCv7cp2o44+YgiurwpmmoO7NRq4yObJtZMM5iwnwRxagbnuJkYxfkK+6Pxk004zGE3kECmey9pEUEu11Jm12Eh1/eYr0wbjYBoqz1RjcJ+ds0KzlbNPNpU8G5F5PH+0n0GDwMmqiqQdIZ3xXKXbO9kXsLLLCt8ipnfyq6e/UZilS/1OGOs1YRABMiiqC8o6Xs+ksvY8zr7ZznRrSU094ZSylCLN2cTAaTQneg2v1whW3+wRfKNdsk6aeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPuO9qcjCRKT1hG8tAOI8QlF9L4C9eaYFzPaHsZZ6p4=;
 b=OS76kLSpUIhVilEHVq4J8Pap0LKuG8c5ueHVC5AT4dNosbhrbelRCpsniJWdE3BrJMSL4hBYIhj5N0xmP5I34GAWE1VOPFXyu3xHYElvs0MyM3HAHMQTHjfUwIC9NCKXeSLSTeS9z6Gg9f8Gt6Nx/hc45wJ2nh1c2wEs2zkhvcLfku9LW5kf62eA0cGcyc7k95Hr9aZEzTLn58Nj2mKB5zvt44FDdg/FyHodAvagOVSgtRLTD9z+YiffIrzW6I5e1FTBJHMtsHP6zyseszkaQkhiTd0so3hMGxPjuxKJoJpzMljt2TMtVerPYYjq62e8sm9UR8/p9aOhH7OIfZ5Orw==
Received: from KL1PR0401CA0026.apcprd04.prod.outlook.com (2603:1096:820:e::13)
 by TY0PR04MB5635.apcprd04.prod.outlook.com (2603:1096:400:1ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.6; Fri, 19 Jul
 2024 06:00:45 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::8d) by KL1PR0401CA0026.outlook.office365.com
 (2603:1096:820:e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:43
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
Subject: [PATCH v10 22/27] ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
Date: Fri, 19 Jul 2024 13:58:51 +0800
Message-Id: <20240719055859.4166887-23-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TY0PR04MB5635:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3f73bc6b-fe66-48eb-475d-08dca7b8212d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|34020700016|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PMOWvkk3kXn0zgHewbkNny0dv4o59lTA8y/Zs0ntZzWI45hF6G4wJF6s83fS?=
 =?us-ascii?Q?Vc4qMa81izvH4tqR2rfvcbR16KbHP/PZMiHQ4vtvu+i8qT6zgGouq81SdXux?=
 =?us-ascii?Q?CMM7Th+lEt2m7/03sAWhfHkxcA20voJG0tZ3zUm/hehI9tA+P1P4UM1VJbqz?=
 =?us-ascii?Q?EnaQOEG4iLOJR9kf4rYF+3MEYnjVPQc5b9t4lW+dQgbd5cFvJBo+Sq+rTL7I?=
 =?us-ascii?Q?geK0+ZfqlJ80wbehTB7TCGiMMNYEyf3FU38g9I9blLwTk6syae0/3sauwt+R?=
 =?us-ascii?Q?CkGRmrCgbDqGC8aMX6b9uyGk+xGOu/Ar1hpRp+UfxrlpQItK22AePZDsThgi?=
 =?us-ascii?Q?/r0xt4f2LuqBcfgVBjoFjz3ZTehY8DvjajXPPVbvxr0g9yrJCT4C7Y8fX+DT?=
 =?us-ascii?Q?TTzA4PVt0hMCdB2ogzuBSPVPKGnr57q2pzTHPU+FnyD6WEBlTeXwEi1Ynzor?=
 =?us-ascii?Q?xwwCwRGlB1d3mROIBeE4yKt1yUqS8/nhF43X+XY5+5IAfJ2Q0CraS6K426xd?=
 =?us-ascii?Q?4q9gQhpKWmaMjZ36E1QzmZqonBmJRZAGzwIn4Wkey1u7Egw/8+kroexbnRU1?=
 =?us-ascii?Q?IfNGkE4Wi0eJ+5GidvD2jLPcl6S7m/Nst5lwmKnh3e5jaiFpAe5F+ME4WKG1?=
 =?us-ascii?Q?CFVdxSKqZ0a5Cz39Zj6IVtqsuAntQwpTaROCL3GN9iKMqgUv6M2Bb7OCl8u/?=
 =?us-ascii?Q?YpGfBV32NvXIgngRlNA6eaxGgwpuli9EB4ZUpIkCsvujWne2DrtHdBIEMJhk?=
 =?us-ascii?Q?Nlw/e8CelNhrnLyJKLkGqcAa6tMeFL66svn3ozFXfszf/YlteOEbVj0dN7/o?=
 =?us-ascii?Q?4971iAJMiFuugnAi7KfXnPLTOxzGVe0fSD5Oc8w5i6hUDEiwS7tQ6vCDS+wD?=
 =?us-ascii?Q?jBiELVKv9n7lVD0q9XL0Ee4mQWfv5cv9HKa3ObDjzKn8vXMW8NsI2lmQCSa6?=
 =?us-ascii?Q?1wRK0pf8uWurxMSlDNDp9wZSulBt+CvFUy/nN8Pp+xBlgdRxwxT7/gI7QAr/?=
 =?us-ascii?Q?lURyXmwdKbJl8j/3hhYrIr6hTUSnrTpGfjq8uuNCnEJHRvnRzWQTJEdK/mba?=
 =?us-ascii?Q?r58ZDlYLDbwqH1/QFxjZUL+IGuYvbaDmALIfvTbJVk7fohUBgIo1q71bI1kO?=
 =?us-ascii?Q?fNAzRGK3IDu0cOrENAsI9eneFlNWXRS9ZrjtqXcRelb0KccMe77Ey/AE/XF3?=
 =?us-ascii?Q?Z/7uuxPxcAnv7fYdhM0KiWT01UTDv+S4m2/kSGcr+fhGzBZJWpn67lBvFJ4H?=
 =?us-ascii?Q?vrOoqGzrPx7vJCA3ksqnRBF8LN5A+i4olM5noM0lxgnVaWI/hnx/4vBH4Cyi?=
 =?us-ascii?Q?YGzKfBGWBf/c+pVhWN2T8Eehl8AzL93nwA/wcghgfKkKSNUCb41kETmVGvo3?=
 =?us-ascii?Q?o91aegfrttY27qY/TToRu+JpCPAdDB28iUj98yY1+wOQkJTt0etC46h4H7Hr?=
 =?us-ascii?Q?lOI8n7ju53SVldH4UheASsNaIj9wfiGg?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(34020700016)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:43.8766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f73bc6b-fe66-48eb-475d-08dca7b8212d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5635

Revise duty cycle SMB11 and SMB16 to high: 40%, low: 60%,
to meet 400kHz-i2c clock low time spec (> 1.3 us) from EE request

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 62dfe935cbcd..21ca22281ef8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -761,6 +761,7 @@ eeprom@54 {
 &i2c10 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux@74 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -1314,6 +1315,7 @@ &i2c15 {
 	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 
 	mctp@10 {
 		compatible = "mctp-i2c-controller";
-- 
2.25.1


