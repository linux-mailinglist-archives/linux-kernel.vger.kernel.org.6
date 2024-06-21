Return-Path: <linux-kernel+bounces-225110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D90F912BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEEC1C27487
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666617107C;
	Fri, 21 Jun 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bv4Zeazv"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2068.outbound.protection.outlook.com [40.107.103.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75757179204;
	Fri, 21 Jun 2024 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988742; cv=fail; b=hQ4b6KOhiclhuQgNBYOTyGddAmoc22ZnN86AKT8aE9SCPo+t0KNQxADC+a+qT4OX8vNgQxsJxEZKie56UBjMtdFttGHtDMHqxo+nc4f+cHmDvzoaQEQRQ6jH3dFTZtQ4g6p1KQ4GLy/OFFSyu1u9Rpo4ua25irfA98wGvTypl8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988742; c=relaxed/simple;
	bh=LA0swwNbuALJQogqufNgbtVfOnBdh7BKM+1Dw/RfV3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N9bES2E1RVA8ZrVeYa3rBRapeUVuImSj95Dc/ZVTxXD/SAWZ94+10BWzxcYIHtm+6J7O4Kp/mOOOtUFsegSPMooKf3VsXAn1l4l/J7MuOMC7QegGVKvrKn2cP/3KDGDkytbqo3xTti2T475mJDQY61kO1ANrfs1SajmEarpbS1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bv4Zeazv; arc=fail smtp.client-ip=40.107.103.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKReRriWc4jyiR4zozkHch+yKMyuACHAhKUIgbEslWNzrN8zi0En6OexgpcCn03BrH/C5EPxTlcP4LJbkOjYfTok7/UVG1vA/clpdoz57yj+gshvjwolpzc1e8CE1n9xqbSEiG8qnpzeUakXyPzC9XPYr6vCxg4dyqVNlm97CBabYcULX0z57tfp4wuy+HBxSli0BBPevyXMOSRyTI0OQ7yeqE7JJ5NfSaXfXtwwn1RCpMRhawlmsqsU4xPJ8adLSlCLxFRaDR1LiYbslGaerpryxYsmeR11lic+vzXOd3KeO6ExmnqrEzie3tZbX+whANJdyRLaZqk2SWcx3exuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zX3FvaZ/li5tEh2SFYZ2pr9C+MWlhgzLDW+v67iFA4A=;
 b=FUPFMgaGd8gHb6hSZ1JorRoPDgbtDdXNj87U5yoINxV7QQNcM0JxbV2w9B0EJ3sKsmAzFyJagUtLFpXmF49d7mcvmG1hL3OefHZOX/SKzKuWwCtPiQR7zSS6rOIGaV6yOUcJkl5EftUM8QovCAZ9Fcd3d/TeLXGMy5m+/gF7mD2SrEIbEYbHriqVaHlvrcdjgAQid6O2f6bue7KepOQZD1luwRQBgxLJbOK0VIbMuqZ7z/Y+OzDtUYVeSq7B3b7N7dD1cIsCphTVUgsKNhZwLojhm++OgSsCG13nBtGHl3hTkSStu8OZwupeTsUv1Yje6pMQ94aFdu/vNxiaom+oCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX3FvaZ/li5tEh2SFYZ2pr9C+MWlhgzLDW+v67iFA4A=;
 b=Bv4ZeazvUVBAe/zy8vFVkEP3t08QMj/YhCozhRl2q+UH9ilmS2tH1joaqxqCStYiYZq5r1de+j7Etz/LPC+EO+L9snefJeJydCVSUD3qej0MAXiVo7oClnTUrH3ZlxfdFc6FRmQO8C8ElViv32926vgL6KylAUyLpUiFsTlynoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 16:52:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 16:52:17 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 5/6] arm64: dts: layerscape: replace node name 'nor' with 'flash'
Date: Fri, 21 Jun 2024 12:51:48 -0400
Message-Id: <20240621165149.2275794-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621165149.2275794-1-Frank.Li@nxp.com>
References: <20240621165149.2275794-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 695f7808-dead-47de-3535-08dc92128277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5keybxSRRUEX3+PNdAuRYcIfH7dsz7yFWxpX+2R9b7j/b/jC3rHGgHErthUQ?=
 =?us-ascii?Q?eYFYlQvqfILhsUrHt2cEQRvWe0mnx9+e5KTwbTbGkSRcazDdn6FUorU4BL4k?=
 =?us-ascii?Q?ZDzAq1vE/83fuOaS2XRrfnyO5/Zzd9xeiedX7vVM0c1+iofGHQ3NpMzcfiPW?=
 =?us-ascii?Q?Nq2G7dL/NBRJzzEhIuLcCV8eEkfq1Zi1tJsJT37T4Adm5t5i9T+X8XS2VpDM?=
 =?us-ascii?Q?Eu7i845Hq6ceU8oDB7jEE1vhLa3iXLvUzy3S2FSz++K/PNAnm3qr4vgFMj8k?=
 =?us-ascii?Q?tyDHyKD6e1oU1cj0ukrgI2EHrd6ovuPmPtPVl5KfsO9jR1iDZzPremPCqw6w?=
 =?us-ascii?Q?BHR3NJciiQ9AkeV5r62PQidUo7P503DIkQGTIZrh1bYrUKMhU9yZ95xeWp2F?=
 =?us-ascii?Q?7nYh3Wss8hdInjfLyPdfKEwyIE0qo0IvQrTSLaaoKq7ZJ7UQ/RZn3pEOn4mw?=
 =?us-ascii?Q?mJo8KOJTxoYHqSwDslha7B4EFL8ezrrKLIy4OrTg7HozU0F1+TLuaOCaYGnn?=
 =?us-ascii?Q?rM/3JwCSUB8KbdjQLDwJ7BErqEut2DGQO+OxpRUvIvDqF32a7kji9inBT68D?=
 =?us-ascii?Q?ZUsNCfDHSTuKmGtvI9U3klByF2duMC6+NKRtsD9hfjekX4+Rnzpkv7nsf2jP?=
 =?us-ascii?Q?AyvUPtf16zYdAkKG9Va6NwRA8LYBfK0zwXzo/79IxZ/T7+g0F6vlUXAyeTl3?=
 =?us-ascii?Q?McizjwQVm5ZMY40PmgxctcSBv7waz/dMBrEyqklXBZWUPMEVefweALtPJlZl?=
 =?us-ascii?Q?KB1QRXzZHU3e/L1n1DgafvQZAE4lrYb0y70AqYeEq0WELoNjZMXqptICrtzn?=
 =?us-ascii?Q?axEWcqrHRoxDCMXXYtdyl+9BQXggQWp0GhTSJE58NylhTF09WDQyTIxnJ+C8?=
 =?us-ascii?Q?Abz5M5hr47tcbFJAiBoX0RbHhXkhH1BXJlXMpBtq2pOE+0LOL10xs5GKT99n?=
 =?us-ascii?Q?1whTtoGwOySNoR4nOYNv2+0rLXC0bVaaht8Gf8otZdSPOHjNTCZLf16hs3do?=
 =?us-ascii?Q?lG00GiuyNO8JKeR6vL/9eX2NiXIaFS6F25TWSAvSbr8pTa8F8sGCCgXryzWz?=
 =?us-ascii?Q?kP2wRoaboiQ57Fv+JN6wU4JPFAqrFqWU/JYPK1sOeahbYQnpjttSkRJkGIHE?=
 =?us-ascii?Q?87ueLwHoHiji/n1DuWWUq7VLIxhxC8zAnLQ8NcqsrX9CpudWQow1iktjCZjC?=
 =?us-ascii?Q?/NASxUeyjxhUWWdB7zeS+1viifoZ+fJtxteQQXeP/PuVrYovdbj2/1SiOICA?=
 =?us-ascii?Q?ThgwysE0ou89uwyW2qCxPiYOAJo4QumOUGxQEhwL8O1OW4f8q9puQTtX6/uh?=
 =?us-ascii?Q?dRIZjkUMhhLWqXx/hsTjzewp/yQl2FN9KjQhrBEaAXqruUkv8eXZIdqQqGRA?=
 =?us-ascii?Q?a1kLzjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zCsf8OxK7AY9HnNNMyHBGV3fhHUe4wYb1G2Xyl8+b92EFdnkvo9+tZm2xi1b?=
 =?us-ascii?Q?ipfeSHMfzo7fPWpgx/3LHSQr1QWYrA3VVFiMRdqDAtO7RRyftuZaohAXMyR1?=
 =?us-ascii?Q?a0j1MPI323CA2hkLpS7IBmtKRemEKL5z3m9f13lS6Ey3ZusF0KzDb1ZhzsRo?=
 =?us-ascii?Q?bp9qAFvIlbl4wBjAPhqAShJNdcbWTTob1LvAQt1dUqtVU743K4+WZ9AitwNV?=
 =?us-ascii?Q?PFTnEhZJvgkR3rvUxngdHrfP/P4hx8UxlajBS0X7Infvgzq2zX388EMBy22g?=
 =?us-ascii?Q?4NPNn+BH03SjhaSSSo+YSI81PmksElJnioX5XCi4ICx4APyB0VFBd4wjNnUS?=
 =?us-ascii?Q?m9iN0Uwfy+INbm+d9bStS2AcigRxDjmBQ59iqQ/IWiHawX7Ji5AjabqcyMVt?=
 =?us-ascii?Q?ENtdjrV8qWR5R7XQxSdLWz8eLLBcQMHYw7ZEo9mcjbotUoiRk+u//LmV9MFD?=
 =?us-ascii?Q?eeIYEKnFgnzHWtYFQKporiPu2rPxt58RKYOukR9zeSgwsjW64eUFRABodPMf?=
 =?us-ascii?Q?WuKKYEqpIHZhHlj4Ka5Rz7qrhLESBMX0gCQZ9wWbQDKjDIgjNouX+PeaFrny?=
 =?us-ascii?Q?sVt4kKvGClA4c1qet5IZcJ35Ki5wg2srTUraGTvilQ/oPJCErKbj5088N0dE?=
 =?us-ascii?Q?CfsHPlNkKwvFv7KSLENHfJlpWNL7FRTBUBAWjVWFgmIkZ/hONfbAFegLA9uT?=
 =?us-ascii?Q?7Z5WaG9wasn+TOQaldw01bq7aPEapobxoQc9VTKSIctA4OgU49lyJly+NQv9?=
 =?us-ascii?Q?Tj8nqStLcypxmu4R8/eu/2b1Dd8JKfwNEhOhW+AfS6Ww8xtzYctZkFrLtCwu?=
 =?us-ascii?Q?C9sgJhBdMxBvwvHnVqydaqj0m66RLufswqYmWCZXjifVvvCY1eoOR2cCkbyY?=
 =?us-ascii?Q?N9+KvbU7r1gI9c76q40/KGo8LzLFck6n8TInYuS1XpP17Y2umzbNC8GFOdqa?=
 =?us-ascii?Q?yCogHOYlST3fGJcjf0x/HXBN9QthAa9TTt/URtyqN8v37lYI5+6oa8ZAAQNH?=
 =?us-ascii?Q?/Gdt9h/wn36RJqVKrpn0IT1QcokcNxRLlQn/jPsxF7oXQfqJir9kShhcfUmy?=
 =?us-ascii?Q?OXWbywKI7u7gmw9C+5hvTOpBq0typzQbu9Ya3OPkpBZ3hwVUmot08Ft1lTvu?=
 =?us-ascii?Q?p2cLkI50s71OGRhjFw/n1k1QJd00hswrdPzHHi3BaoeNCBX4Lk23TekNuZyv?=
 =?us-ascii?Q?TbFNPv3NAL/GkR2XWfljnoBf8Z138EbsUzGxKGhtKsNi7x+YmZ1xCpEnXjGI?=
 =?us-ascii?Q?xIqZfBsEI5I51JYhopW9wI2KJQya9esYcO+9FLxswrcOtuftZct8ixz4rZrs?=
 =?us-ascii?Q?abBAlvxkPl5sKOM6f3b6mclPrptOiXU2iv7lI2ZZTq4v3eT3g6MPdEq6E6TY?=
 =?us-ascii?Q?MQuvJ7P4g+Tzya0+ELL2HPl706eQuPVpxW8tcWa/8FK/dfblpnl4LxOKgSAL?=
 =?us-ascii?Q?QjjUr586UVQRgJ6JCmfbclPpMlhpBfCEBXtWvL0LWZkmmD0v5BTFKRFsWqyo?=
 =?us-ascii?Q?xsEHk7VQR1+xQsH0I0q87SEzYD/QtoBHfgPbWUd8P207coWrRkgkvnUERm7v?=
 =?us-ascii?Q?jZJ6x7YjvZYD0QPJBWltwF0ld4XTLNwHKkPfGtk2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695f7808-dead-47de-3535-08dc92128277
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:52:17.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fV8+HsFGgvpo6bakYYpSQjEoIzCeOmr3fEdLyw/ZnjHGzBcrK1wafhtSw8+vYQRsyrco49zVuxw3rDeSiTCOyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

Replace node name 'nor' with 'flash' to fix below CHECK_DTBS warning.
nor@0,0: $nodename:0: 'nor@0,0' does not match '^(flash|.*sram|nand)(@.*)?$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index dda27ed7aaf2b..11b1356e95d5b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -64,7 +64,7 @@ &ifc {
 		  0x2 0x0 0x0 0x7fb00000 0x00000100>;
 	status = "okay";
 
-	nor@0,0 {
+	flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
 		big-endian;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index 3b0ed9305f2bd..e5296e51f656f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -151,7 +151,7 @@ &ifc {
 		  0x2 0x0 0x0 0x7fb00000 0x00000100>;
 	status = "okay";
 
-	nor@0,0 {
+	flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
 		big-endian;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
index aa52ff73ff9e0..d238a8440a814 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
@@ -113,7 +113,7 @@ &ifc {
 		  3 0 0x5 0x20000000 0x00010000>;
 	status = "okay";
 
-	nor@0,0 {
+	flash@0,0 {
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
 		bank-width = <2>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
index e2c94da6d6e82..9178cd61c7869 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
@@ -43,7 +43,7 @@ &ifc {
 		  0x2 0x0 0x5 0x30000000 0x00010000
 		  0x3 0x0 0x5 0x20000000 0x00010000>;
 
-	nor@0,0 {
+	flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
index 537cecb13dd08..69cd05a30b853 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
@@ -21,7 +21,7 @@ &ifc {
 		  0x2 0x0 0x5 0x30000000 0x00010000
 		  0x3 0x0 0x5 0x20000000 0x00010000>;
 
-	nor@0,0 {
+	flash@0,0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "cfi-flash";
-- 
2.34.1


