Return-Path: <linux-kernel+bounces-362041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6A99B038
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2E0B21AD9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A91CFB6;
	Sat, 12 Oct 2024 02:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VtSp8sD/"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A59D1A270;
	Sat, 12 Oct 2024 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728701037; cv=fail; b=SQocmeqZTuzHHkQUeD9dXOd2FGBC71Q9C6k7/vcY5deKf9IEdCRVDpRXIQCP4xuWg1gXGih6L/yOvTLSCyRx5RtXjixj7yo7Umoy4rP8hVaxGw2UWkM4ZiUM1CSN08z5S5/azHc12wgDS2Gg19E+2SCn5o66OYa/jLdoFPGkFw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728701037; c=relaxed/simple;
	bh=TQZqYHr9ujHgcp+t/QauK22aUHiGo9i02ivyqy3fmZI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZbVb4kSvspfePcNfsQ5FVxhFbSPLWiFGeWt06BgF26QNaYbrfWd6xFE+dxfoPqC3CYSnZPk841LOex+pH77zSjmErEUcKsmAv5Ic6wfx1XExWBC/QUwqSXhxHIl6lDxUYgPu9G3c51j6KPU9C2joKgd2tmclmHtRAwMYnEQce+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VtSp8sD/; arc=fail smtp.client-ip=40.107.103.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4ON0lEwJ+KgxYUexqPTGU/cLAnAGn7Bqe80CU9uMB43jnOgILI18WK2/zu3svjHEmOYBW+VDJa+HqCuCxX4NLMas9ES0+xykZK5fDU2E5UTnFev03jTkwZTcuSffJXxudgeTHF7zvjwKVZUPQhFL6dWKF+M9WcHLBDKprS5BHSiSyirBujxYlCcLErHEPN/oSFM9oTpm7eUr1Ou2W+oz0HjezbvmTxfEo7IoBwTQYORUxrKabjtEbK6w2zl5Ruaa3sgfWNNTNFK3UoQj1SRMwoMujxn8D8XtJp57PfpYWx95ydQz+V2CxTdFHWO3DZfDfjTG8lL66Go3FBl6VUc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU90SGUYau4i2xBSKySA/xNGHiOfTH9pmwgavjZrDRg=;
 b=BOcmOap4C1CnUoD6S7DK60LMoUWX960UFYcw1Gj79ybArtzOnL9gAINML6ScpK2t0gmW2lx4O526k4B3ubWObyUeqwxA1h77Od6e0D2wzAO8lE72FmtfaAl+KNqc4yw4vrbawvDejKxZxiIt8V9VsTjBL/weN+IdB8r45B1g4iM9S2NI8exriS19eEaNm5PQtVns2kAhj3G3Q80X1miTFUeddr6PftFwO+Jh6Br4P80Cot0Deg0GOn/agKh9WWFeHJj/rm0Vhk3JvL1iN6AZ44hFuhDtJHrd9mh2nPiLXVK1St6HPRKqIHslcbrKBMoX0DQ8x9WKP85F9iLDjK1hPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU90SGUYau4i2xBSKySA/xNGHiOfTH9pmwgavjZrDRg=;
 b=VtSp8sD/10Ht0kjuakdhMtgVkUAIZfHxssVhZy25EcTEwpQIMU3UFq/sB49kWR5gZRFNSX9BhplFCKOQFCYYYyWQkKPsWC0szvOYuJH3LaKNd92H1vlBVATw2UdAd5W/u2vOxgpDT+5MYsS/Mze+C1ohTSHRo3t/ocX2Lxe/aQA6UZx483T72YZdIz8tYVejVEpT3tFIiQpx1GAmN0F7EXvWbBEsKGBa+DV/vTHTRYmmGJ9sLY516OJy+Z1Yee1KOzV4HRIrMNRnshsk72a0/UkLqo9TwWLnrC87/qNcNSLVG0CC4/lu3DICjeJG/0GFGF+QpN56tNEdf79SfT92RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Sat, 12 Oct
 2024 02:43:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 02:43:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mp: correct sdhc ipg clk
Date: Sat, 12 Oct 2024 10:52:21 +0800
Message-Id: <20241012025221.1728438-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DUZPR04MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e2f3c8-ad26-43ac-e41b-08dcea67b378
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0j9xQk/8+MtjyGo13xcdYN0jPjKw5WM+483lvCmAVW0yePxTi59hraNzQ+sP?=
 =?us-ascii?Q?yzRy1tbRwrSwXtzLuBYSyPG5DXSgTb54D8kjsReKTrNSkuA+U/ipFDIoCGHe?=
 =?us-ascii?Q?WN8RxfC8JPqYC0Y3/bVzPPgzvku7/Zq5lsdogZ2Gliab/5zVepEYnKAfj1A1?=
 =?us-ascii?Q?RIX99EqAwJWNH4PjsJ95rF7iFDUWB7t+MYjLn8phg3CMNNEMAXKvoHifWl8U?=
 =?us-ascii?Q?S009RToLiuplzx9lunu4mx1DUY0qBs9etgytl+y0CXu/645ErNGj3fIsh2iH?=
 =?us-ascii?Q?tBRDBSxWFV5YkhgDwlq6/ubyvilfc0u0wSl8d7UsMHgp3/1OKofj8AXsMvTq?=
 =?us-ascii?Q?+CQQmIAFZomgpLl/5r0q7g3fR/XfoPsGUatXGYFjo+U4NBb7F1bwd6NUsGph?=
 =?us-ascii?Q?TBiu2MB+7v5VYIx54E1ic8KdNEqVIsOFHHoxRNcslMd/teUvSj2Up/Jh05dq?=
 =?us-ascii?Q?d329K+cxMsMZS6QOtildZ90As/fsBiHiFtW/g/dsqxULb06VJ0J9Doy/iD75?=
 =?us-ascii?Q?8bAuLrNXMKG+74FUQh9DRe7oeU0aR6jQCOhqhwxznT79UQ3ANdFE5DZe6hDi?=
 =?us-ascii?Q?e6kM80csvea6dgQIN2KLflbgaox/M4aHOJELjC6mS6fkAgMMXjYVWVrl90S0?=
 =?us-ascii?Q?W1jcrKswSRjPTpjx0Omb7Pc+y3LzZbKbUXv70Y4oDrThl+YVm+DobMjNTBWR?=
 =?us-ascii?Q?VeVkoNvkclBXedMDX52ZwwyHzjgYXiAKn+gQmPgQmQZ97aTB275XNexFlMcO?=
 =?us-ascii?Q?rK6PhN/bL1qfaGEV2a5JgfAMlg6Z7M0ExWRAAbDLhJoPLRRcg/237laW3dlR?=
 =?us-ascii?Q?Dv1lhhIbNXHP0XMDdX3jKYZC3UQnRX/RUxOr5KQ2flzlTCYffioMzvcrL3vU?=
 =?us-ascii?Q?l3Oh54rOpxErlXhSfJt0hnQsnccVbm/5FVBsHfPbHWopqqznN7Wyosg3Kbjz?=
 =?us-ascii?Q?ffJMLBEUz6ahqrpHYz2w1QtOGkGIU5cvW0qw6Phk2GfJHOZ7Nx5gnQENZXoS?=
 =?us-ascii?Q?o228wklQ9VhbLNGNTMmZ/sW99B8ZtNpFpS2Uuf+gj961mKNYIDpIEAd7zeNT?=
 =?us-ascii?Q?aD4ExEOn6vFOgZy7SJgvjy8+dFdQnlS80AGMFC3Jw8Qas+3YGOy92AGQZCw1?=
 =?us-ascii?Q?2bkXsIMj7V03pcA7PujBKdn94Pd/hkxnKnMhfotAFz88zbhS8Vp78DrNAh0v?=
 =?us-ascii?Q?FqX0y0CNXYJaOUn7HhE/zExoyhJfqEV3u0D4GVh9COuEfseFiTteFLrB6G/r?=
 =?us-ascii?Q?4qzCHueh1asD5+p5tP8YkuXrlUruqjyq8pIIDtJZVLzQY5nN5qShN69/2HBN?=
 =?us-ascii?Q?PE/SqFjwI8eY0eRaA0h5O4oRiq2hfzMkHjZ9co6728PXKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EtvbHA6k0Nair4l0i7riHBUvTRr5dmzYLRWc3B7S0Bs7CpREw2rWcaNZjlcR?=
 =?us-ascii?Q?Tnkyp8LOlNOhzPdnpz+pEGDDQSwS+Tby5lhi71l5/9n7YESVYzQV5fK6tr9A?=
 =?us-ascii?Q?dTnSPHi1cDU9PmhLROkwdBxSsR/ReFqxukr0yocYHVGwEYFn1yLcICoQL9Kh?=
 =?us-ascii?Q?Mb3plRd6TsjRhtFyZ30g3KmQP4V9pW+Z2upxC4tEaFlOxoLjGULTO4ZAR6Ub?=
 =?us-ascii?Q?vra9+Q6VqrhJKo+G8WiSr0y94QHBEpNqAXGh2vrZu1syRSPwUEsq9SaXktIk?=
 =?us-ascii?Q?X7kS9QzAQvzbOUO8qIR0P95eef/jiYGEBsJmaUq0XWA3+whBMRW2gjtZANUD?=
 =?us-ascii?Q?wwFj32CLapN0SeVD2WO3Qa7WCHT2NWLsHDXyM4UH6zX/CULHVtseqfFc+GY5?=
 =?us-ascii?Q?vB2WHkdfgi1NJD8VQMdS7k6arDmN3NtrkxQpqw8ZlGFFET4+lxIbV/bMWZWf?=
 =?us-ascii?Q?ZmRu+8VT7HRsGiG+DUDSxuaDdjM+lcPlmhfeF/9CddtL77VYQbnb2LIIhkNZ?=
 =?us-ascii?Q?E+oGnX6SHZTccxKGjDyoE48nAImb4twHhZxxqVwR3ns8TuzbdIqiIUhv/82i?=
 =?us-ascii?Q?egNP81yMZhj8kqCzzHAvbxZy641LuL7CaAXLYayXxuKPsGWRPjAavHh1INxH?=
 =?us-ascii?Q?3bx7ZSop2NC6WNeGSfTqjOTpO5G3nxSes7Y6rFg3fhzDIuiIIjMNFHWHfV+8?=
 =?us-ascii?Q?GAMwf9ogz1XCmvs0Wb0n33yEsC9oM5epHXXACmitedkKEeLHDajoh+miQ11t?=
 =?us-ascii?Q?fuExUByu6mMqh53lka5AK+8Ymvi5tjaQHr0bvmsG9VpJt/IsookpLEKbXkS4?=
 =?us-ascii?Q?ZS7qpotvZMNSGSin5FqXgT/0COEqkRtLazJH/Qf/sQvFS8gqladYejPdWiWC?=
 =?us-ascii?Q?VEiBejdQunBU169Qor+H7rZsDE5b6oj/gTXPwyHr9Q8nn73bld/LuQZ662p8?=
 =?us-ascii?Q?sAx8tjoFeHeCg+ujxj4K9SJlu2io7YzXIxEKm9CKzY2QgDgorrPs9fYXlvp4?=
 =?us-ascii?Q?I2G8W7vpZn27fUaJBPpYDhxnvqZ/BBghnjA89L4jyVJAfM7GojlV5R3hcce7?=
 =?us-ascii?Q?6AAXkmx8CDsRfbvviL49VRwRQGYeeOSoyY4L15/7SKQPvNhtJRWKU05RFmDx?=
 =?us-ascii?Q?3Nx+7MFMRc/uitsqzdR/E9Y0hEiPxniTX3O9TVvi3oaWZdYoB1vixqHsWATA?=
 =?us-ascii?Q?K1tWVo/QfrweZnBEh2JrFckcYFz+k4GODPe3I33EjFu76ZDXvEmgoV1kLw7S?=
 =?us-ascii?Q?eiuh3YLqEc4uer9eymOzShQNY6zyjtrEAofFqZKfH1lAliM/lTVS+5NszvDy?=
 =?us-ascii?Q?2+o3fJplszbMrutJ4qboW/UjB6dMmBb2iTVf4XST6CwLVfEmGHFTMOlSupeV?=
 =?us-ascii?Q?ComOJFi+oRslGMRAhoCVkuxtDv4WcqTWc1+i/bp8hl6ddseoIkoIlugv6bdf?=
 =?us-ascii?Q?zfQl6IYhljJdW1gXakoxnGXdO0iXAmiSGrv/9XaYDLD65kaJs5yynfs+cqAQ?=
 =?us-ascii?Q?hoXBGafFOJKdJ3qRN10ylIdmpPpJESV5dAK+Se/X0RKeojyoatCU4ZA4npcW?=
 =?us-ascii?Q?8bHJKlVO0AmSXe8CjHf89Bj0hFWi7C1QWmdtbcUO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e2f3c8-ad26-43ac-e41b-08dcea67b378
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 02:43:50.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLScxi9ZBfXl5bW9wYecc6UNsbvKi25e+fwiome8O/aWregQBuAk6LlnGkWWRK6Rh7+bFKXAnzm0yxMuN3/Zrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784

From: Peng Fan <peng.fan@nxp.com>

The ipg clk for sdhc sources from IPG_CLK_ROOT per i.MX 8M Plus
Applications Processor Reference Manual, Table 5-2. System Clocks.

Fixes: 6d9b8d20431f ("arm64: dts: freescale: Add i.MX8MP dtsi support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 3b02c6e2988c..2ea2fbf2bc20 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1261,7 +1261,7 @@ usdhc1: mmc@30b40000 {
 				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b40000 0x10000>;
 				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_DUMMY>,
+				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
 					 <&clk IMX8MP_CLK_NAND_USDHC_BUS>,
 					 <&clk IMX8MP_CLK_USDHC1_ROOT>;
 				clock-names = "ipg", "ahb", "per";
@@ -1275,7 +1275,7 @@ usdhc2: mmc@30b50000 {
 				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b50000 0x10000>;
 				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_DUMMY>,
+				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
 					 <&clk IMX8MP_CLK_NAND_USDHC_BUS>,
 					 <&clk IMX8MP_CLK_USDHC2_ROOT>;
 				clock-names = "ipg", "ahb", "per";
@@ -1289,7 +1289,7 @@ usdhc3: mmc@30b60000 {
 				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
 				reg = <0x30b60000 0x10000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX8MP_CLK_DUMMY>,
+				clocks = <&clk IMX8MP_CLK_IPG_ROOT>,
 					 <&clk IMX8MP_CLK_NAND_USDHC_BUS>,
 					 <&clk IMX8MP_CLK_USDHC3_ROOT>;
 				clock-names = "ipg", "ahb", "per";
-- 
2.37.1


