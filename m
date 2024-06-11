Return-Path: <linux-kernel+bounces-209218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F837902F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C1D283B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9653216FF22;
	Tue, 11 Jun 2024 03:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fP2equoU"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52916F917;
	Tue, 11 Jun 2024 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718076468; cv=fail; b=OkQ0se7VY4zRceBeRV5xuKHQeusZLmD0CBYbXVNnh6ixUUE2x9XbleqV9Gq3q6puD9Psogn1lhIiMYI5W1YY3LWuktl0kE51qx9/ws2uhaxUKcP/1PDyP67SI0txnMiuQNsfLQn6E9PJUqN1X39WWKhwlL2KZ8m0+M98i1er9fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718076468; c=relaxed/simple;
	bh=GpVQjROZzs3zbp3hHRHM/vsc96dC2Vd77kbbf5LDerg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9VtFyHOmNlJkq2AmoDI8rc7BJTHSmSK7P7hwda/B2kqkWB9nOvKGhKJy8Yr1wQYqTxisa9nT4WO4HtDbhvCRSvAZGjpO26rh4xLCgKrTiz4G5Y4MeMcJ7I7OGchLFVlSTRW8n0wk7QEs7M0P2++m4zL0AGN7oE5WqbMdlOw9vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fP2equoU; arc=fail smtp.client-ip=40.107.6.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxOCeNIRP+0FyZm7yvfrwfGuPcsdV07amrAc2EoipChMZswIUijugBH/x+5n/ITAY1UqbftzcXi9/AUJlejWR+5NhjpTCZIg8T43XPE5zBPJ0z04A+nuh9WZunNpVjMdC9XappcSJ1K26jbaRx6GPQdUHDytAOoROsu+EZ+hnjoO5iF4m1PZDBkL3tenslxP2sUFMHlQjjDUj0oO+jMb4GYYpEyfFEV4/jEJs7m+d3cqdY3cefl9bsQVlBA2+rWpOZg75/Qr0BpDj4SDuS29egBNAfV5gzZ+3+50eKbhm+arPmWc+bZrE2EEtUcVXSnTW8UT7ZzcwCFTsTJEVca31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aedSP9eBtn2LnnfjIvzYfsFtFyBkJiPuIjD8XaDEp5E=;
 b=HEwvehsTDljzigG227bvQM8/R+1cM7bo/Qz86WiMGSGg4b7rdSn0KLTgeqJeLpRtfvHn3k+4WI8ZPmK68pwDXRLNVKyJq/BpyegVUHKvGgNlaiR91cW+gNaG/zdujkHPracY669M1prO7Y4uZ9p7tpLR2osN9UBe7yqADmgLbC0b2isOhjJ/WkQW0T7QTz7tI/P+QOhEEMsuxaryyi3yaM8dbyboj4O9wwvbGF2AW0UbVKpVGBRLMtLZwnVxd4KhVXOw/XkQ3XdJvBhBokJXjRC3SqfSVHuf0UDc4E2y6r4g0dDS5Eu3Yw3H5WWp1IV+V5d+N1sAOifFZ4Wg3ofMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aedSP9eBtn2LnnfjIvzYfsFtFyBkJiPuIjD8XaDEp5E=;
 b=fP2equoU0nVnVc59HsV+LtN7tFECI12SWK6IZcjihJUV1kqlXnCC8Ws4JR0CtTjFF6yfWBwyHqsEIVtRMofyB37EuOfarxSCPiV8t/Tqbs+9GuBFo9yAAzpFBokmYnMsvL3Au18I+O0XL6w9V1/Gb4dKkIH5U+/gdlzlFp7Wh4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8959.eurprd04.prod.outlook.com (2603:10a6:102:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 03:27:42 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 03:27:42 +0000
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
Subject: [PATCH V2 2/2] arm64: dts: freescale: Support i.MX93 9x9 Quick Start Board
Date: Tue, 11 Jun 2024 11:36:37 +0800
Message-Id: <20240611033637.3521514-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240611033637.3521514-1-peng.fan@oss.nxp.com>
References: <20240611033637.3521514-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PAXPR04MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: aa013316-1dc7-43b6-d3a5-08dc89c67416
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?28bkuMJjokFfOeEP3NknUBlbV6G74vKfqDsN80Ey1C7lO/DPEaPLG4uGHrT1?=
 =?us-ascii?Q?iTmDvWEJ0AZdrZr8X8InPFenV0aPhBch5H3qVA8HnWleeJzvVLZsJZ4pma+I?=
 =?us-ascii?Q?wBkFy2/d3zTTX4/0yhwZaUZQRptTXVaJjQl9BbqqbmCBD2hKDAUmxv7PtEF7?=
 =?us-ascii?Q?nl9oCuTfnuEGwEY0A2aHHhDiawVT2+rObfnFy1e7iucpDR7LXaKaTysdYmVE?=
 =?us-ascii?Q?y7oXfx/MinE/wdp0NLn0IGtjrRtl46FXimvQP2WieizXdd4nOOodrsa+/h+q?=
 =?us-ascii?Q?9gPX0LgelOW5ZKKaV0Ymmn+7OEBvILa7K9p+eoWLMQeXErFzw7eJiH/r3ziU?=
 =?us-ascii?Q?E6T+BpMSGnCiI3Zpw1mehwPWB1giYKRtpQ2ZHm5wMD3C7NpSX/PlGwMF/djl?=
 =?us-ascii?Q?ZWhAabEtBdvelNNAq7I8KChB0RREXLwPxIidOhXjtuM2bKy0jb9HtNhpxioi?=
 =?us-ascii?Q?R34uX1tCKqYJfwz6ENbzVg4uqCJvWUVn7xngYrRjl1JmqK854mS4b3oiVcRs?=
 =?us-ascii?Q?22LI5cvRl1ZQhZRezthexR9x52dXWj16VCZQjA5UkiPzp2HOdFFfiokeyUCX?=
 =?us-ascii?Q?yflc2ckp7aHZ8fyX+SMcBxTCErOb4DvH1EHQMD6OCs8ZtU8wAnelNzmQ3pRx?=
 =?us-ascii?Q?3STGeyMULsXSVmMyrdSB9Pi+tIIff1pyV9b3zpmTEh3V+W1ATNJFq56VoDdK?=
 =?us-ascii?Q?FxCGiV12/Lg0AybH9qgnwyZizF/z8Y6a9VG8xut70pQj75RJF+EzkktbY0dr?=
 =?us-ascii?Q?1QBXI++0OdXeq8D3x9AbhoahnoWNAKujGrEaKjBkUV82zyDhWMlSNsj5jXq8?=
 =?us-ascii?Q?AlM3zO/08VT2x7C2B4OSgcIQn6ydKevNP8ij8/6WQkISuJ43nlKffPrW/g+x?=
 =?us-ascii?Q?bV66q83KrpXmU2Rr6jZjtm8GVr4iWfpDcUuIZOiwTAI5pbv66+1IqHxqKyrp?=
 =?us-ascii?Q?kUdphjJBQpEIcfQNsADQfpTUmYemEzr0KutyuL0m8NRzpfWGpHP38/kFIbQW?=
 =?us-ascii?Q?TNENbcfTZYa2qXLp0/d0Gzdl8eedP6T1WPM3EolN4LHH2hx+T/UNfcq5QpTU?=
 =?us-ascii?Q?u5I7NBjwqNKsHarE5mThbljPtmYws6UZGph70gL1t7vrs/pPVxGG/wMmm8Kn?=
 =?us-ascii?Q?6t2hldSjd02sWgx9uhqGniAFAJIqzrjAfmrD0oB3b/w5/5VPOrunpL1bhMyz?=
 =?us-ascii?Q?Ok/S/UJe8Z3P1DcxravzSERhTj2PoaasqSxujgq5feoAj3KABVXE0Dayz5SK?=
 =?us-ascii?Q?ZrD/4mpqjZaM5GQiTD7UVKTShQ1m3Pc/qG3lh9+28V5oVWDj77cLoxXWAlBB?=
 =?us-ascii?Q?+t8cKB/4KrxYIFeLjtONEbMmL61Az8iypxHZaRBxWUOGCHVALQ63YXIZekOw?=
 =?us-ascii?Q?IEOx0mE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L3uHLjiUPJYu+qbeEHtmIKmd/pJr7by6naGxQXj7gCkVt1WCq2Y68xCe3M34?=
 =?us-ascii?Q?Tli2/P2SKd/WJoWRzql/cyfmabjJjiy3KDY5OPpJnCEtNPIWANCOPaTRw45x?=
 =?us-ascii?Q?dRbmEzAZn3CMHq3LmzsYXSIZTlhoEuhIEYo9Al/n5l75GL4t4oyyLDN4dUjU?=
 =?us-ascii?Q?z0zkIzKTUJ/uMLgoRO4THdwu/rDtQ0wyTTuxOQWDcw2U59Q7B3tJV2MfXar2?=
 =?us-ascii?Q?RSl6R9Nk+JNejFXM9sdPdeDiaVHGy4CybEkkJLBppVXY6ePa+S8IRlhJDYV/?=
 =?us-ascii?Q?76hyjndNfe1pnRI39GEF3+XnLQdhWsXUOwzN68keQTozpbLNYOhFFdk/ZrLV?=
 =?us-ascii?Q?/lUCTe4J6C5DN6iKEUw+fr/vC4xORPkCy7TUvlB5UtRQO1YwHmkxeqd61qgC?=
 =?us-ascii?Q?ZX0McmS5A1aEMBcpIEDnjgDILK5qh1ngbLzMj3QgBPR0Uk/mROkkw2gkiaqe?=
 =?us-ascii?Q?V7Sk+fNYm0oEwbBl/KTn5pqDj6Eyb1AUep81Pk28CSrfZQVaVgkt7ORGyMZM?=
 =?us-ascii?Q?NlHsvQyHaY6inYoGvHj+GrjQAaz0iwj+rt+oSt8nzipAmdcD9CByvq13JQc7?=
 =?us-ascii?Q?TcMdJ+zmfT872KjO+6KS828g53gyltdskRFCp5qrx0IvwVZ3W8yHdBcudVIW?=
 =?us-ascii?Q?ZfO8IqGxC1gGb/1tObqi47vyzS1MyW9HKGaGQ8D9JhFddxZfZXO7ztG4e95a?=
 =?us-ascii?Q?RRpCdV68R2qwFfqNBTHaUBTVt6xzHkX9PTcGdt4cR8T5DIoJmaJubTAiteRq?=
 =?us-ascii?Q?4hqtDnBS5SwGp/OGpaJkalgo0W/jxMklLpFFd4/fF9G0xDi2S//ILnCP3Omu?=
 =?us-ascii?Q?B66Bib/4fHEfOa2+LXur3UNPHJ7s2DbOtNLZygWJAl1T38L05X8Ks2RgZ4sv?=
 =?us-ascii?Q?l6db46mMkPt4caP89ebNGINLScKQm2QtOcOrozzgJMdTDvdWn+VhONi/K/YY?=
 =?us-ascii?Q?maOofpm7CPggz2+g3x8eCSjxWBH2LZVulP3irB1nq+srtdZ3zqNgSlSfXSxc?=
 =?us-ascii?Q?mVnL+ZLQlN2tT2HQd1VHuLt3/gKk/M/A/Q/VXp0xf+iqrDk49RCPaPX7m4SK?=
 =?us-ascii?Q?Dyy0L1t5FHtnWuqGwsocPtUPPjcssHrmLIWKC1CMrFV+Ydc5TSawg63tJrYX?=
 =?us-ascii?Q?RTPV/Sdr3CT4fnsKibeHexXUjFxRSHBblriy5vOxD6b685uuHs9u8xUfSAQr?=
 =?us-ascii?Q?r7jV1MVVeBLl44XhWFbQ3MLlkSxPKDuCFvE06BTrEacn9hjWpjxGQ6cFW82W?=
 =?us-ascii?Q?w8zoLe3/djjTJOM7GWWptBk5qq/d4xWsLDJEjHw7lFvp72+2VmdTO3wXSwjw?=
 =?us-ascii?Q?PFrGEW4zsTp78bsAw8zWcZN4R3HPo8RDMRsD9mVCEV7YVg1WRsiIdOgjoiOg?=
 =?us-ascii?Q?hLOVdfAfbcN/0GWu6qXV/nATNMQoa2pXFkW4pTTVkyhrS4qlAw9Or+bt9Dol?=
 =?us-ascii?Q?tZ0qmY8xy2pOPY80tr2AYXVAUPwrLx+EMpOqesWEjkv9S5NjxYkKhhRc1yWv?=
 =?us-ascii?Q?a5C8GePxPbYZXHQ5pbIG6OfgmiOelIL/hUHykw4P0rRLc3HnLvBnvm2Lv97o?=
 =?us-ascii?Q?hSU5eOEkMkz3D7lD/lj8rBoInj9ewh3Fu+5C6+/z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa013316-1dc7-43b6-d3a5-08dc89c67416
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 03:27:42.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdm3jfkParzaWLbOxubFBKCFkoBBb89fxkxukMVmCrJCdn2zknmW9V2ax8Ezmzrfz4D4tUJD2Q8kbvUe6Aypjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8959

From: Peng Fan <peng.fan@nxp.com>

Add the board device tree with sdhc1/2, cm33, mu, lpuart1, lpi2c1/2,
usb enabled and etc, which to support the i.MX 93 quick start evaluation
kit that provides a low-cost platform to evaluate the i.MX 93 applications
processors in a 9x9mm package.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Drop non-sdio per Fabio
 Drop duplicated address-cells/size-cells under lpi2c
 The address/size under port still kept even there is warning when W=1, the
 warning is false alarm.

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx93-9x9-qsb.dts      | 502 ++++++++++++++++++
 2 files changed, 503 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 1b1e4db02071..2f7c5ca4ecf2 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -234,6 +234,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
new file mode 100644
index 000000000000..fe542c939de5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx93.dtsi"
+
+/ {
+	model = "NXP i.MX93 9x9 Quick Start Board";
+	compatible = "fsl,imx93-9x9-qsb", "fsl,imx93";
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+
+		vdev0vring0: vdev0vring0@a4000000 {
+			reg = <0 0xa4000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@a4008000 {
+			reg = <0 0xa4008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@a4010000 {
+			reg = <0 0xa4010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@a4018000 {
+			reg = <0 0xa4018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table: rsc-table@2021e000 {
+			reg = <0 0x2021e000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@a4020000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4020000 0 0x100000>;
+			no-map;
+		};
+
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "VREF_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_rpi_3v3: regulator-rpi {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_RPI_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524 21 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <12000>;
+		enable-active-high;
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&cm33 {
+	mbox-names = "tx", "rx", "rxdb";
+	mboxes = <&mu1 0 1>,
+		 <&mu1 1 1>,
+		 <&mu1 3 1>;
+	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+	status = "okay";
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eqos>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			eee-broken-1000t;
+			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+			realtek,clkout-disable;
+		};
+	};
+};
+
+&lpi2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		typec1_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			op-sink-microwatt = <15000000>;
+			self-powered;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		status = "okay";
+	};
+};
+
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2237500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&mu1 {
+	status = "okay";
+};
+
+&mu2 {
+	status = "okay";
+};
+
+&lpuart1 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&mu1 {
+	status = "okay";
+};
+
+&mu2 {
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+	no-mmc;
+};
+
+&wdog3 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
+			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
+			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
+			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
+			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
+			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
+			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x58e
+			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
+			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
+			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x57e
+			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
+			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
+			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
+			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL		0x40000b9e
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL		0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA		0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
+			MX93_PAD_UART1_TXD__LPUART1_TX		0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
+			MX93_PAD_DAP_TDI__LPUART5_RX		0x31e
+			MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
+			MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x1582
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x40001382
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x40001382
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x40001382
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x40001382
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x40001382
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x40001382
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x40001382
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x40001382
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x40001382
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x158e
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000138e
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000138e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000138e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000138e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000138e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000138e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000138e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000138e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000138e
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x400013fe
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x400013fe
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x400013fe
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x400013fe
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x400013fe
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x400013fe
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x400013fe
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x400013fe
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x400013fe
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x1582
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x40001382
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x40001382
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x40001382
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x40001382
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x40001382
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x158e
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000138e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000138e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x400013fe
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x400013fe
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x400013fe
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x400013fe
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x400013fe
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+};
-- 
2.37.1


