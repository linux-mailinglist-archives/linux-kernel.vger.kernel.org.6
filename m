Return-Path: <linux-kernel+bounces-233066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B170691B1D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926F41C22299
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD35A1A0B06;
	Thu, 27 Jun 2024 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X4tMDa1d"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9419AD93;
	Thu, 27 Jun 2024 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525622; cv=fail; b=t4uK87gWrIND+Cv2lBJZCg6+t7UNRZpBKe+Fl4o2IiM3bZfEvHGlFXwl0rErub3MBJhLWwQC51wBk6GyS2kA9Lt8tG6TlmdpGDp7fWnfU6fU9v+KJjSB/orTNEgbH8sDVFBhrDQ5CzKgbrYxnMJr/gga2zl+M1x/DcJ6NO6s3fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525622; c=relaxed/simple;
	bh=mapawrh7cxMgTXjVCbgvhNl3QH2tbXbuAm4cMU8aeOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A/AbSNQMgtso4eFKoHuTWNFSMUA1fNVrom4yGCD+YDoTlF0ZcBW1Iiv4fhrnjzyiIW3D1W4RTBHHGjOh8qZOGiZfK4xEzXsf3fYOJve39YnNEBMQLx9W6F6LZkdsjmKqmQ147+yzSGhrluc77N8/Ld2M5DuZr45SUmvb8dR1o30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=X4tMDa1d; arc=fail smtp.client-ip=40.107.241.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nyf2pq7rgKWCcBgVs7jm1RaYBtbCOz5LEtLDlXzAS0v9teBLRq6wv9KONq30A1eV9vVhbNSX/xVRY3S0mCsTO/FZFzDlFU+6970HTihIkurWjjns8NEON7istx37k+iylQLrICB/20bx+YMB9FQBVwJFS5ZklmOFnu8PqhloD4pUr5cJfapYqfftfVkRjQkK30Ae2jcWcl41pnaWPsvsCJN9X/BDJ4nEcotD6Fd37W/6WxNsHIESWbT2zdwLyTF37EiuOElUF30BnelcZzP5d79a95QOPsrCHH6XME9jRg7jlqW6UT0TTu4V/zSKZUQdSJEbMb3VGDTFZvflBC20Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpgusfJdy1EDwPVfp51czlGETUgCyRjBchtrL7Yi9U8=;
 b=U0Kcr0Kzks1p35L4y+bjYwpx/zApQQIHZa8HRsfWo6MQHaXSMPrQx8Pk+54DXMoZ67GntI8eYnCSrXg3wnNHHO3F2HvZnkl3hcWDp/C9S+lGA7mzSbv4KDUbzzzq2gHrE/b6ESB9zq5qcpKS8zDQiLTa3tQehjPQ/HPj2yH18T3XUwjW3YIi+dsVdO5A4UQiHcNmSbev/tBYYCIswyEH8PiGo9DcbrLZ4JXKoepOwPjpszNJ24GdYfYlIBYgApr++8yYLlk9duIOPZ5dAs9DFeVw+xqtbpSOxHDf+16Ceq+LDi3tTzCtTti3zdNuEjUQfyM5ufUw1OKTZv2ZJEKT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpgusfJdy1EDwPVfp51czlGETUgCyRjBchtrL7Yi9U8=;
 b=X4tMDa1duyXTirN7oIpJROPkhMicDnyy7jr9IMlPi8GexA1mckEQG1XoqEC0ZLvB/6QdMBcXTeOkkx6O8Tpd3nfuzaiZZvYgr7kD9xqgu/vx/6IlZVfXOhWJN1UrjgcH7BAyXB0uZoIZ4E8QzChHnoEGcMB2gaCscbY9Vd1csaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 22:00:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 22:00:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/7] arm64: dts: imx95: add edma[1..3] nodes
Date: Thu, 27 Jun 2024 17:59:55 -0400
Message-Id: <20240627220001.692875-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:610:e6::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 5770ec33-1702-4b64-2754-08dc96f48657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqF+HasiSH/2ap4Lx8tZhjDxAGCP/d0i7sUJ4FiVHw5G1OqA9Vmp7hw88xWN?=
 =?us-ascii?Q?nHGqmNMZRF1X5vph/8qbV5OY/nJuH/lOwkkfuXGOCEFhE2Whxi7b42v1RdXK?=
 =?us-ascii?Q?1zbTbysUThYF5EmWwLaC7yaVikuzQc9CRpZSvCuFW1UvTwQ7jAEB83ZoqELs?=
 =?us-ascii?Q?HS5cWtuE1+n1Ub6P1XOkaVqZ9pzXZrBL/WcY8akpf4UZM9ifZXGCjmdyfJPP?=
 =?us-ascii?Q?2fhnhyHPzxF9+AP5QEULEIiH9mVn9BWhklki+lpEiNXeniwkvaM1YpNbn8Wm?=
 =?us-ascii?Q?PYLuWkdKFYOd3U2/1E9J+/Zr67SHUmYKSPpYYWbpcbx0/rhLnj5jIUuWqHck?=
 =?us-ascii?Q?L7N1W6alWN2IgrHhhB1s+edvZpa5Cm87VzbqMPBUV87aG3ikqwwKoY6CotsW?=
 =?us-ascii?Q?xlGLN6WuGl8Gnavb/CWk/55Hy3HneNxVITmiKA57Yez1lqMMEPsoP0vGP7sV?=
 =?us-ascii?Q?KRxTvScvnBj7VAqeKk/d1frQ470p5h2BZP+gae/swaf/riNYYl7pFi6euXtB?=
 =?us-ascii?Q?nunzDjPvbYGELQwsYIdHbJqFqDOIPjxHo+Car071Ivd0fBqOOSjagOuOEdse?=
 =?us-ascii?Q?mxiJDwwk4HyIK/f79OY4r4LpHQDvULegDYbauB+sEcNxkEdQezbdvptZ/TwJ?=
 =?us-ascii?Q?3A0erJxJlHYkW96ETzPH259jYfAuT+DpI4B1jZSWCCpD3bxzdtFX9ILpSKmT?=
 =?us-ascii?Q?PChfVc9ISWPgFznVP3xbLmNS4uPSurARwnmfuO9Gu23eRQfQKeLFThWsEQ+K?=
 =?us-ascii?Q?Ez6qzjeSUJ55n/cjb/ebpC0PHzrP0ZJKoSNl7mhxIAQ8dYpbVEygM2MPZHmF?=
 =?us-ascii?Q?9CdFJTH1UsY93PTdQITuS8dpVBPn05AIV07G/JAD+fj2JDU9UDVhnrds4WqP?=
 =?us-ascii?Q?WvzPMz3KRc18xTjhdXyXJsstSM9MGFBL39NYHbOx2zFJfwKSIw4Of/nS1CWh?=
 =?us-ascii?Q?JJLtodzHNlOfe68yVQ3N5pOFsz9oxKDqizeFaAnyTBuzH6OMnU4DJzhLXoq0?=
 =?us-ascii?Q?9lcBw1n8KfUiDMEzBacBJZwo/geHvs9z9J+xweiwhmQTYKFzf6RlJMte/OLO?=
 =?us-ascii?Q?kTYR475B050DIqhF4L6+AtLB0GWEw05+fWvCZEIEIGiZb4YZcYkQMgLdtpu/?=
 =?us-ascii?Q?7+RO9YdtX6C3e+0b92xEPic1epltk29haOVI0gEqz2lZASmUN+6P3Lrl0qGB?=
 =?us-ascii?Q?KY1tCQ1GQSVuChKGcaJJh9ilxkarIsELWmM9aB76rWQ2PX5XF5GKUb3v3DwU?=
 =?us-ascii?Q?WRsrUkb50ZLOGLPqXNbgC5BM19hYn6Jjmxs3xpOiyfajxuidJjnLNBQ2/7eZ?=
 =?us-ascii?Q?jbDtaMtAxF63MpQqHohXeaaXnq5ugaBZnuFOthVRVmQ/K/qjh7Ck6CDmU4OO?=
 =?us-ascii?Q?b+W2eV1k3DnXHAD3Iqkze81eE7VY2m5EPBapHntqyNtNgLU+sGgH+ew57w85?=
 =?us-ascii?Q?9uzgjE0NQNI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hk4iJj9x0B6BmzNTCXlAN0IhhEmrDivw1qVsmVtKpOrX4gI7ALy0ZF198oNV?=
 =?us-ascii?Q?TcXhwVZJiRojvSnr/CxJ6XjvdHKwarhrWWCFB4tDtCTHq0pkCK7yGwxFAvm+?=
 =?us-ascii?Q?NGaZqhrNHmiTHfJTZmmXqknvOgGejtQ+03DllwhuZLflN76p+2jjPrEaD8o4?=
 =?us-ascii?Q?ofbsvlhqcFqmutAIA/WJmvEtIHsMkluGBdW6jaD2tNvzt+75tvpXCv+rdw5o?=
 =?us-ascii?Q?xj/yC3xKqpJq3wLS5AHtvz/jnzBNBNVpAbuTtgkdGCzImavFQ2w0HG4+hO4q?=
 =?us-ascii?Q?QQNPJE23zNdize5C3K4yvtNNRHCQqWZ0xE+NUAEaijaAF3RjMNeRDlyDssP4?=
 =?us-ascii?Q?ubVYwJGM1Jm8PgtVdArHxi1kEBojZNhyKLQToqI0MP6y8ueq+IqXIzRKkf9n?=
 =?us-ascii?Q?6Wr5osHQJx3iA5g/SV2M2ZL8bHuTVZzRTwXJtrh2Ei7uZCcJfjY0yjQ2Mdhb?=
 =?us-ascii?Q?uFb+TGZ2GjTLd+yg34jxbnY0W/gevI8MO+yBGRVIPIOdyMcJepNmi51byvok?=
 =?us-ascii?Q?QPeM9aaotElijZooWJ1B/LNIw7HFcYBuaV0D36qIwRENVa5wTiqE1ncLQXyU?=
 =?us-ascii?Q?k3fBuBNNaJlMi9cLML5j/1lCIs09it4hZ5TPpypDMAp6QCElZ0INIiq5r3zA?=
 =?us-ascii?Q?MdWHTxNBbKmAXbjt36eII3rln06C9rFsRtxwSZ17fsoZrYOLohIe++mQm26q?=
 =?us-ascii?Q?rnNUK7TW4PSfImEc56oI10ZD/gy7UavGyzURkJE152HwU4+O2kGGKOL7SQTD?=
 =?us-ascii?Q?3ZPLLGV8xf+Qsx3Nu16hgeAt73BvxFbn9zofNKo0H+DMl4jXwt+I1fK7v3Br?=
 =?us-ascii?Q?ZZNVb/QGTSIFOS7zjySMzYUtyiLqUPkn/uItetVBnX6u7N/pUDB/g4dpNRY6?=
 =?us-ascii?Q?wR12m/5WYEOJh6/pMUNIc34oKYWFrYNyZqGc8JNkNsMnfCpQm4ieVIpBTmhu?=
 =?us-ascii?Q?UtUPFv1EXbK0luvfFn4DRZEC1eY55ISJ5CJA+6ugAd1c2ZW9KK5myd6/GkEr?=
 =?us-ascii?Q?5fjU57GnNmOpw5dqno/w3ReLgxcj4WLm8sgXcqpLgSxfcIeKHtYE3s+WxEYA?=
 =?us-ascii?Q?KmYo3uMMz64FWuuFPw8snYgzvAnQn52XF7VNJvVOT8mLWv7WksnJk4/mPvyR?=
 =?us-ascii?Q?beIHwUuqUfuNBulkiSCvKcpbAkfRWxdlbUuIm8659FksLz+MKHI0IzXOCB6+?=
 =?us-ascii?Q?bFlUssWMQb93kGhUiU4TmQuJcp3gcdqR/GXFWwUTg3Z17iCPtfmVcUJddE+Z?=
 =?us-ascii?Q?fo/yyuDm6XmUzbS5PSoARgjKvDOcEi480OSIMw1JhM7idXBfbe/kDvLIUieb?=
 =?us-ascii?Q?RbLD2glwE9wKV6IINzJ8JcrVCZoo6u8sgJ/7zVoeRWrFwmX2Cm2pySaCsHht?=
 =?us-ascii?Q?f5PsqV+QQ5S2Ytithl1LuZymOaH5SfcLraKoNo7feKDowXPDlO89aIlfMX6X?=
 =?us-ascii?Q?D3BcV3x2YHvSaXihJo8j4T3MjCHyeqlsmz3AY7YjmvltmXkLCg74aUmnjx0d?=
 =?us-ascii?Q?l9undHfFgGHgcQaDrgC8AWseySC5A4tz3iNrkERPXH1u0shNm9fGvkccZ172?=
 =?us-ascii?Q?Cpoi3CJ8jxVzmdc0v9I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5770ec33-1702-4b64-2754-08dc96f48657
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:00:15.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gFjvTsq2ymVDhj6teT+7HBCJ+spj886KDV+XDX9x2aNkhssBU1VGcGtdPzAd/htv6q+GmNmRW/FyrBky5I/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

Add eDMA1, eDMA2 and eDMA3 support for iMX95.
Add dmas and dma-names for each peripheral, which use eDMA.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 235 +++++++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 1bbf9a0468f69..12f7ac52c2589 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -3,6 +3,7 @@
  * Copyright 2024 NXP
  */
 
+#include <dt-bindings/dma/fsl-edma.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -405,6 +406,152 @@ aips2: bus@42000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			edma2: dma-controller@42000000 {
+				compatible = "fsl,imx95-edma5";
+				reg = <0x42000000 0x210000>;
+				#dma-cells = <3>;
+				dma-channels = <64>;
+				interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "dma";
+			};
+
+			edma3: dma-controller@42210000 {
+				compatible = "fsl,imx95-edma5";
+				reg = <0x42210000 0x210000>;
+				#dma-cells = <3>;
+				dma-channels = <64>;
+				interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+				clock-names = "dma";
+			};
+
 			mu7: mailbox@42430000 {
 				compatible = "fsl,imx95-mu";
 				reg = <0x42430000 0x10000>;
@@ -464,6 +611,8 @@ lpi2c3: i2c@42530000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma2 8 0 0>, <&edma2 9 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -476,6 +625,8 @@ lpi2c4: i2c@42540000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma2 10 0 0>, <&edma2 11 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -488,6 +639,8 @@ lpspi3: spi@42550000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI3>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 12 0 0>, <&edma2 13 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -500,6 +653,8 @@ lpspi4: spi@42560000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI4>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 14 0 0>, <&edma2 15 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -510,6 +665,8 @@ lpuart3: serial@42570000 {
 				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART3>;
 				clock-names = "ipg";
+				dmas = <&edma2 18 0 FSL_EDMA_RX>, <&edma2 17 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -520,6 +677,8 @@ lpuart4: serial@42580000 {
 				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART4>;
 				clock-names = "ipg";
+				dmas = <&edma2 20 0 FSL_EDMA_RX>, <&edma2 19 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -530,6 +689,8 @@ lpuart5: serial@42590000 {
 				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART5>;
 				clock-names = "ipg";
+				dmas = <&edma2 22 0 FSL_EDMA_RX>, <&edma2 21 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -540,6 +701,8 @@ lpuart6: serial@425a0000 {
 				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART6>;
 				clock-names = "ipg";
+				dmas = <&edma2 24 0 FSL_EDMA_RX>, <&edma2 23 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -550,6 +713,8 @@ lpuart7: serial@42690000 {
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART7>;
 				clock-names = "ipg";
+				dmas = <&edma2 26 0 FSL_EDMA_RX>, <&edma2 25 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -560,6 +725,8 @@ lpuart8: serial@426a0000 {
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART8>;
 				clock-names = "ipg";
+				dmas = <&edma2 28 0 FSL_EDMA_RX>, <&edma2 27 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -572,6 +739,8 @@ lpi2c5: i2c@426b0000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma2 71 0 0>, <&edma2 72 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -584,6 +753,8 @@ lpi2c6: i2c@426c0000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma2 73 0 0>, <&edma2 74 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -596,6 +767,8 @@ lpi2c7: i2c@426d0000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma2 75 0 0>, <&edma2 76 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -608,6 +781,8 @@ lpi2c8: i2c@426e0000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma2 77 0 0>, <&edma2 78 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -620,6 +795,8 @@ lpspi5: spi@426f0000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI5>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 79 0 0>, <&edma2 80 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -632,6 +809,8 @@ lpspi6: spi@42700000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI6>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 81 0 0>, <&edma2 82 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -644,6 +823,8 @@ lpspi7: spi@42710000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI7>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 83 0 0>, <&edma2 84 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -656,6 +837,8 @@ lpspi8: spi@42720000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI8>,
 					 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
 				clock-names = "per", "ipg";
+				dmas = <&edma2 85 0 0>, <&edma2 86 0 FSL_EDMA_RX>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -796,6 +979,46 @@ aips1: bus@44000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			edma1: dma-controller@44000000 {
+				compatible = "fsl,imx93-edma3";
+				reg = <0x44000000 0x200000>;
+				#dma-cells = <3>;
+				dma-channels = <31>;
+				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>;
+				clock-names = "dma";
+			};
+
 			mu1: mailbox@44220000 {
 				compatible = "fsl,imx95-mu";
 				reg = <0x44220000 0x10000>;
@@ -830,6 +1053,8 @@ lpi2c1: i2c@44340000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma1 12 0 0>, <&edma1 13 0 FSL_EDMA_RX> ;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -842,6 +1067,8 @@ lpi2c2: i2c@44350000 {
 				clock-names = "per", "ipg";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				dmas = <&edma1 14 0 0>, <&edma1 15 0 FSL_EDMA_RX> ;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -854,6 +1081,8 @@ lpspi1: spi@44360000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI1>,
 					 <&scmi_clk IMX95_CLK_BUSAON>;
 				clock-names = "per", "ipg";
+				dmas = <&edma1 16 0 FSL_EDMA_RX>, <&edma1 17 0 0> ;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -866,6 +1095,8 @@ lpspi2: spi@44370000 {
 				clocks = <&scmi_clk IMX95_CLK_LPSPI2>,
 					 <&scmi_clk IMX95_CLK_BUSAON>;
 				clock-names = "per", "ipg";
+				dmas = <&edma1 18 0 FSL_EDMA_RX>, <&edma1 19 0 0> ;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -876,6 +1107,8 @@ lpuart1: serial@44380000 {
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART1>;
 				clock-names = "ipg";
+				dmas = <&edma1 21 0 FSL_EDMA_RX>, <&edma1 20 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -886,6 +1119,8 @@ lpuart2: serial@44390000 {
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART2>;
 				clock-names = "ipg";
+				dmas = <&edma1 23 0 FSL_EDMA_RX>, <&edma1 22 0 0>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
-- 
2.34.1


