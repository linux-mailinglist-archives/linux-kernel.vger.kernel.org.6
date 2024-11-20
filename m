Return-Path: <linux-kernel+bounces-415817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DCF9D3CED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2848C1F23B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E851BD9CC;
	Wed, 20 Nov 2024 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fe2fbxIN"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DF81BC9F7;
	Wed, 20 Nov 2024 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111093; cv=fail; b=baZKxbYtaVBPKynuXp5OXDrA7+039s3QdlS688SD4/BC8hbjcDx1wOkxiNLygi68i4YlQvZZi4jJt+NYChemWSLTN4VIsQl08gS523p/QMxChRyAsG2fprkEk7qcd5FAl9QpX98zMt5jVSdrqIFwkPGnJrgVS/lIylZFTMpsYXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111093; c=relaxed/simple;
	bh=sA6eH/36vaEkuNx/RrCG/1sp0yXURkux3LcG556dB54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fs2ybt57s7/3kSYPlf1NskS/QWqqwJCWt+/NaL9NvT5cl17Tm26SUsWLZCmZf+lW25O8vcU5Yi4gy7Au1lBSI2pOADHgoRAJmcgIp5/TE741sP3zl4pTfbSFoiH+OkTL+FoFxJcpgojwI6Z1Jtz1EjXKT9bxwb9I4SmhGhZ0Ycc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fe2fbxIN; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0xy968KV9qBWZ/O/H+gJri8HdXN9N+6CKW4I0x4Z3cvd4R2YwFEAtckbdwua/h6X5pZQtOoVE0o3AoekfGTDzZXB8FYU5Tjoing8onYXJs4Sg530LyFKTu/n8M+Mpjib3U8Ji4zQBYHOBxEAqYOrvNYnl6bctrLBL+fQErQC0R7r3vwiCAXOj/OYFVr48M98wVQ/WUQq4QHYjx4XY1+LP7ly2bHI+DViHn8vYhOqUTvr96FFq/OMBrabUnSeKbhE/Ie8El/fOgHwo5prMmqYizSavNTOjjyMGUAHxmfGSb0JYzHHNOia/bu2XYNUXN1W3DsWYEQ9zyyRWVzboZv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL/VZRLZoCjyIlIGQnIKiUV4QmzWrnAJjgHq7d0XmlE=;
 b=b+d2MoWnCbGj5AS48rocSWIU3RAuIT1SS0rOr3wZw/JxOijOlbvbQp5YTN+3Lat3YP0NGouYicZR/UxWcejUlpjcHlpuvGdSX9GqIvZJA7bJdCaojnQ1+T+/G2UxFobtP2badsiGfZkOM58aUXqGmhj9DMu7S8jgnKIuW2/ACyANQsnXy0EskJQWZZzjS1oKn0WWJZbDAsJpLzpGMLeFTt5mG9bbQ0qD6OJ5+wIiyyYFUrGAGDMakD6k/kEpOXnB2++JdVjeo8lmppSw8HelYYT7vxVmUBq/is1a/WsLlZovN0l4Ry6pANju5mhW4bcp+b6r0g+dLTrJYm7YvFMlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zL/VZRLZoCjyIlIGQnIKiUV4QmzWrnAJjgHq7d0XmlE=;
 b=Fe2fbxINu7OrAcl/zF7exAUuzc/VGvvsYGV4NnVS/hO1cwO+/HnipJmfW0O8T+nKJtqbFfNJnRWOHg545CSG3+orD948ETVZX0tj+p8XCIlSjABPB7M8zvH5AxybKBaC5qi9zeZ1ieiNr2+x0duHy+g4YArAFeqh4HW9+JSodaOiJOwgTT0PLd2Wd9F2bQdeyQ/XEKWjimrtLxzQ1jCjFE4xLi0YP3drPC38AKeDEEoGZ5dT1NxQzYpMlTpr7CLM8tVou3M351hMIXhDqjudj7vi2iOJDFGBACP8bjBgKMO4OELRvO2uGzBmpuxZ+tvzNFhoRqbC8sJFxfgEknKZUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:58:03 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:58:03 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 4/5] arm64: dts: imx8mp: Add fsl,dsp-ctrl property for dsp
Date: Wed, 20 Nov 2024 15:58:57 +0200
Message-ID: <20241120135859.3133984-5-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120135859.3133984-1-daniel.baluta@nxp.com>
References: <20241120135859.3133984-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::7) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cf808e-e859-4ad6-d197-08dd096b59ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l8iWEXKNm0UatdBvqA7scL5QDzdCEc2jDUoIKrJp+o1+OPf5kXMwc1gDf3aK?=
 =?us-ascii?Q?mhEaeMDluFcHhkiGDf/vWSmyeX0l8kdE0qXfEJzGhjTmltUC7Xwm07Tz/YE3?=
 =?us-ascii?Q?S7wfbIwPyd7Ai8AFlPd98l7Rzny5lvw5YK1lIHg4QkfogPxD03QJnK+xTCy5?=
 =?us-ascii?Q?QZLsuzjlSoH5owoBdLg+r+beGZaqreRwNn18jf/f9U4pZXXzYNhJlqU8TGld?=
 =?us-ascii?Q?eJMUsN+T8OPX31hE50TMrM94HpiztDFGIJj7E9I9DhtRyOx0VlpO+/BIZJTp?=
 =?us-ascii?Q?PjVQZpOq2rtKeaJaGGginWd3FYeBu6X9poOxITcwtbbC0+xdcUFjhXSrKkV1?=
 =?us-ascii?Q?2L5tZhpiJTFVU3+zFFXvghVo+WZlj0baa9X3/qzS5TjZfmSwoC7f7k3+Rvsh?=
 =?us-ascii?Q?myqaVuJ6g3vzb1GoMDFxqC1MZXDgU+Ouu50t4z2x0QRNhc8ghjGxIwTpXMU7?=
 =?us-ascii?Q?cu5jqqv2HHLaW9lNdIJ71WGZcmUObHCoFiUHad+9K7Z2eNMQLOY1O+nkp9Sc?=
 =?us-ascii?Q?eGH1NgOkAGain/NXYm8NVy3pRWyxBSzjSsUMs6Aiaz1Qsnw847Ayr64CC+OD?=
 =?us-ascii?Q?Fb8JcdikbIIuTX9hKJay8t0a1XvKXJa2RUkAXq0cTWbBbLI5A8uFWLIe/1wi?=
 =?us-ascii?Q?3XlU3s84TljPtd7XlloM6S5hD5/xdE4f7yr/9/gN+UYAl8Caq5Gx84yErFO8?=
 =?us-ascii?Q?m4L+UJXgjVNf5napou+JaZZOCyQye8YQE0BtPx0rtqMhw7zEyudKFwZbGIXF?=
 =?us-ascii?Q?3IZqRbGhFVqPydM4hsTDePuy8pypq/4mvLlKwGDl8kI2mzyDcxCnAxHEM4bv?=
 =?us-ascii?Q?8wTf27oB34ijzMR24vO8+hqSGdwFSVr1WUgAhcyRoCgg12P9kYqm9uQm7q5N?=
 =?us-ascii?Q?aJQ4Bmf1qNM4mo9HKYnDQin21pXieqEeL6HW9nCxKQU9sY1oc9HUpIIvseTM?=
 =?us-ascii?Q?TanJZdRZMPe/IOEiQUEaq6G2b2in2v0sCsx+hUnaVfMNC78JZRsBDhICRVJG?=
 =?us-ascii?Q?3IGdN5KPBRxWh1Bh8sOOoRGuyz/V+Kx2qOcc/ZxA8P/3KdTicSAofqYyrsO8?=
 =?us-ascii?Q?uln5xSo2I1A/9pfxcrGWFiB7lBTYuu+KIEAyi9LNb6WHAnFrukshvLbsoX9g?=
 =?us-ascii?Q?ajdqEI1Dlcom/EP17CEYxiTf+IdafuJAXfDN2znDKY/Eh5O1V1uxsQ6SG+Et?=
 =?us-ascii?Q?UkIe2Pt57rUVpn/Ti3o0YTpxQUKfkY/EIE8wNG+wxITeldaSxFwMvqBQimlg?=
 =?us-ascii?Q?KxNXNsxRGjHvrCfFyx+Aad7/P0/SXptGuL0dZm+w/oNo6WddqiEC3JfByhEr?=
 =?us-ascii?Q?8uNh8nYmAss8yn20Z+aLVl1g9rsGwlySJlwSsGCAb29g+OqbG0sN2WLjjxIJ?=
 =?us-ascii?Q?VZQ2YYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TfyzRAaeqU4+xS2C2QWh9H1l5lJkFu3d/KZHiZjL/A7sque9t/AI7CAeO9u6?=
 =?us-ascii?Q?Xk7OI+HyPyLgtftF/GBauedS+/lXxo42XjLL4+KXr3ZTeMSFaF/4EitTgEM5?=
 =?us-ascii?Q?57LT8TBdJSlTCYwUP/L53ai3fUgv8h/J0AOZ4rTaQo2PCh/ED/s33RheR7J3?=
 =?us-ascii?Q?e+OnSV56V1cjKi9JCeApOIhG5XXB2BI1VwRuHldjGnkG/YfpMiFoAgXz+Ou7?=
 =?us-ascii?Q?H9wEDo+98BfVfyVT/RyUTjARMu4ZJQrVhy7+gfRzEbgtofAxzdnf84+HIDc+?=
 =?us-ascii?Q?QR5+wS5V3fj8ur1Dzxa/ubAwoMJ6dZvfaIwlM56t/oR2ZakSwjrgkgU1Urcx?=
 =?us-ascii?Q?/8JpYPh8qHb253TCvhiP993Vac1CS5c6MZhz1rlsCQlUuciRIjQ2xGGqJnb7?=
 =?us-ascii?Q?DucV3/OpN4qnkF9Lj9wL9rkP7kF7zm90m7d/WrTM8JxSl9PnXne89PMAwu+o?=
 =?us-ascii?Q?tCXAb60vGiPMzI+nX+TLGhgyZgFV0QB9jMqH+DTpriyHYVi5/grtqiYva6iv?=
 =?us-ascii?Q?LCgosQGnQrHdcQ+YL6CEzjOqC9VJZm2Fl/wZcKsmF+EwdfKZoxt86NU45JLB?=
 =?us-ascii?Q?daO4tw9klBcNnFkkGvIiUdDQeboTGiOQAUCBCmJdkR7iD2opI/aedkKa5Yf9?=
 =?us-ascii?Q?0/53kFthHK4hwCChuK4c6w1q/igOToZD7n+FEVI9hEFzI50UDBeCN3DOLAii?=
 =?us-ascii?Q?EYgSuJCVqRYijOCjNnkczJ/5XrJByQJbdiUNo7geq2m5bQX2q5VHhWrM4B1R?=
 =?us-ascii?Q?tDw1LYgDpgU1k58i6syVgkOajt52jMCwOuJAq+vx1KHjuiuBwdVtpQqsi4EV?=
 =?us-ascii?Q?Q+UuP0hxE0CfhJbjYlsrYw2JiDWKVjf685IPSIdDzL95s5Nxoe+B8dLFTOJ1?=
 =?us-ascii?Q?plmp/quPRjolHJ5ASBTyg6khoJ/l/bz4W+lU25K6PBzjv/pA14KqzhiC5XST?=
 =?us-ascii?Q?1OhR9NqPM+wV+tVlVdiz9f550vFRuTUA5ijFq4nCUiUZmgkXhlCrUagjil/x?=
 =?us-ascii?Q?w0mEjcGbhoPCdmys5eDxapeHy2nulhipXP7TGf+Gw74NkqIhpA21wpkL3HbF?=
 =?us-ascii?Q?vxh50kDyBlY4Fil6hzauwx4bfx4YJ3atbCZRoU2l2vd7xVh1FReBvqIj9UEk?=
 =?us-ascii?Q?/gXpXV2ztjijQnsGMsL2P1DLglhFL8VUJYqPtTePP7uNc3fO/kx31qy+Yjjr?=
 =?us-ascii?Q?1htTtqG2XIcjnaPqVDnvgm4olzKzlUNBbIkeXmZhooVQKZmIG4UUPrt8mELm?=
 =?us-ascii?Q?n6jFziLo7/SqxK1JlyUdPR+Q4+yugsyjWRvJr83kjCANvHD+lmIfqibcyn57?=
 =?us-ascii?Q?64/z8PjOMM+ahRX9K7FSYvLLgtEHPuC8Jkaqe8XyJmsdfwuKIUX8GxgsDZLP?=
 =?us-ascii?Q?uXySAUg/8RJ0LWQFKVIAJNuymI6pWYZagvTtIeSQvhdw2tveUHMyTdQ0zPPK?=
 =?us-ascii?Q?6uxanA9uFqIuyxWfzkv8Q5m3tTay1/W+CJH5wlfSm0IpJSXTuQAdpRwUY5qH?=
 =?us-ascii?Q?7p8Gn7RDUd6xeV3ifXRdKluelbsrzOMWIGafxvvoezIHU6C15ELCegQ1pwps?=
 =?us-ascii?Q?WVCfvGLNgZZ3cj6Dkh7HmM22d6AZU1edFwXRXYRZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cf808e-e859-4ad6-d197-08dd096b59ad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:58:02.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXwKZ3X7j6fLv4OZOBIPkiH54NqmNOCxjcPgq0qVvuxC3qnwVVHSZGsUaBTI7v5RfsKAbZsa6aYiD4E+5xV8Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825

Audio block control contains a set of registers some of them used for
DSP configuration.

Drivers (rproc, SOF) are using fsl,dsp-ctrl property to access those registers
in order to control the operations of the DSP (e.g for start, reset,
etc).

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 41ff40ab5da2..fa4ff75af12d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1616,7 +1616,7 @@ sdma2: dma-controller@30e10000 {
 			};
 
 			audio_blk_ctrl: clock-controller@30e20000 {
-				compatible = "fsl,imx8mp-audio-blk-ctrl";
+				compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon";
 				reg = <0x30e20000 0x10000>;
 				#clock-cells = <1>;
 				#reset-cells = <1>;
@@ -2433,6 +2433,7 @@ dsp: dsp@3b6e8000 {
 			mboxes = <&mu2 0 0>, <&mu2 1 0>, <&mu2 3 0>;
 			firmware-name = "imx/dsp/hifi4.bin";
 			memory-region = <&dsp_reserved>;
+			fsl,dsp-ctrl = <&audio_blk_ctrl>;
 			status = "disabled";
 		};
 	};
-- 
2.43.0


