Return-Path: <linux-kernel+bounces-245345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B092B188
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0CA1C217A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF8A14A615;
	Tue,  9 Jul 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nYU+fdsf"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013000.outbound.protection.outlook.com [52.101.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149C145A08;
	Tue,  9 Jul 2024 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511406; cv=fail; b=TpM31xL3G0pdF0yof+hyDZfSLGjzjdQ1M0iglQhbv7Iz81ZtIKOTVMAPLMRNFobNO1MYoygeenEZilThA88DRm8hXcPtD4ll9nxd65vGW1Sq1RfHQ2Ae78qCx5qG0brwPhI7BeL+NfguvMZi15LaVerxFqzwdnlNODaZocBysTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511406; c=relaxed/simple;
	bh=cfhv9PDDZ+d0yrAIXBV7zA50BhjCAGkPLSWXjRd/RZw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AhqPN6jLwAd0YouxWoDl19473mDnOtiN/WwmaHw5GJE87fTHWnkbOu7z4LcRuwwfQrqBO8JfWkG577kL4h1ufraIc4nNtMnFSJoGu9COEqK+ubgakq16ihIXX7FcxceQGz+UekMKmaLUp5FhzyrmJxMtXLlozaI6+Twul6ljzWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nYU+fdsf; arc=fail smtp.client-ip=52.101.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/biwnx8IVxQyNHdV3wl9/+mTrDFo2erVNNcwKQbwWuLiyXfkhlh7QUtHraX5m8wT9YHiqVz+AQzwkU+rnPj5uKj5qLlFucHWBYnE6tz8YoURVKr3Cma8BA2sz7dvLrfdwoVqNItk7aXD1NLlW7uHFMoia/A36XNz1zfx3jgngmKuaWwcsS8PrX46tU5eSpGapI7Gp3mu0fcOjAxMWoTxQ2ViDxBIdQud8UJDLKkwsPtwj1tMdPHU1s5dJMQNxm1jlOotCwJItmK+gCBx40Td6zY7S6H1iUci/IUKZVPR0wfA0bLBQg+C/Q8OJrC6/9crPa9+1UOW4h0FuBdVjrvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQhUVPtbaSsiO9t9t65sUuCWJ+kBSryiC0p+qKTC+ns=;
 b=BsOB/nXPBWIV19FgSfvXd8Q1YmGQDV0KqLQ+O8oJ5OIj+jYN2su8kacm5caudmQfpR+jAvpuGC3JCmmVecoiy8h0neKxjBbUT/0YFNc+hrDm9Bhl8NuX5Mfia27RVFxKMMk+tXvx02hdaidB9IcKStfN/KZ6Is6MHsq7smcU6KwsUS51PvOD7WaYN9Ms346pCj18S9CDzJZRxFXx3/qq63itkDO1jKk4mOFZilIh7ItmiWxVfJlwNyg9PEEA1DtUxr42s65X4T1z5tr7ZZJKBmmjev31u8yE7ptLSeSy3FRxwa/A0yhBiuNtFQX32KQcx4siEaeC5BwJhxMA+BVPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQhUVPtbaSsiO9t9t65sUuCWJ+kBSryiC0p+qKTC+ns=;
 b=nYU+fdsfj1Fu9ISJlg8fdc3C44fjD63cQJv7McoCTAQRPINkLW6ftjrN8BA7HnTB+IADJ9lme113Lb/EzrLHMtUA4gCYUk1d/SWtLCAQ5y8pUSYRX7XkuXZBQW80aMRaV+qmt64PF9N1OhIOk8Hcwlt9NFzjFaLaLuF0qvo6VE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AM9PR04MB8652.eurprd04.prod.outlook.com (2603:10a6:20b:43f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 07:50:01 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:50:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] add NETCMIX block control support on i.MX95
Date: Tue,  9 Jul 2024 15:36:01 +0800
Message-Id: <20240709073603.1967609-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|AM9PR04MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 03757fed-2c3d-472b-b171-08dc9febbcbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OrkObAo+5gXPX59maDTufVSJ/avxf8jhRkI9E1IDxLP5FoqyRwPgsVlxtAbG?=
 =?us-ascii?Q?wKLS+RNz0vhT6pLNRt5vySQptpBENiNYunR5g2cysEwfJlNDGxHxVi+0eQWf?=
 =?us-ascii?Q?1EUqEpsKpCo+SULNdXlNe/VDFb5yX+U9XZYaVU9sGrDGH6SMCtielefCXpUB?=
 =?us-ascii?Q?2AtgZP8BSiFmdJtRtDO2bRvb6GBQtZQp00xg1lj1xniTgD3KS5fmgJxkdHSf?=
 =?us-ascii?Q?jfjBEzBmFLQXOxgrEUvIW4mfpf67YqOIWMoLTe18xr+QTgPB0lGdy7AygJgz?=
 =?us-ascii?Q?eLfafIx2CO3x0xm9/eaVnQBeV7EUJ8jwH3au3UQBnwDbtT6qBl8eibgCLvDy?=
 =?us-ascii?Q?nVb2G2zhegW9/Jn1OuKYdy35t+pT0SepHwB9yjKPNn4SzcG4OGnJC0vNNePo?=
 =?us-ascii?Q?+C7mdjRJoMtdWVvuehjsqVopO/kCQ4HmzAdrJ4nASQJu/1wi4ShYcYhI64Lo?=
 =?us-ascii?Q?M7NLpwndBOlBoxEGjdNAHyjnCaVVj3i5gNI6fbB/3KMF51YXnarhxkr0RV/n?=
 =?us-ascii?Q?CXnhfo1hmi1/DGt+W6JwO6iYpDGJVKVs59ljzdg6Zd0Sf3Bfwif/pq2PPU1L?=
 =?us-ascii?Q?m90IHzxyNH5pY3rrW+aspfWkX4AHhKJVstB2lqfC4y7bqNd9ANjc8EnLS0I6?=
 =?us-ascii?Q?KXJFn2NgECMpp/V0/GX6k46ecXu3+91EClo4b18AV6LehJePZjM7DR0eaIjz?=
 =?us-ascii?Q?JBiW4NmjNO4lHDnEB8JmVhSTeVEAiqG22fLZ4EmWFAmuNLxUbCAnfWauNEmE?=
 =?us-ascii?Q?yxISpH8UU/NitLfyRbkHUpYCFOI8S0GxU9AtHymhTdOx/lCqQjxw7ds4EtPi?=
 =?us-ascii?Q?P/wSpbMpyrSxpocptrUDF4XevXbP2i4BVss2kpeG8qdqSe+k479eBS53PTjR?=
 =?us-ascii?Q?jsSeAMZ+XOW6CQ1er5YMHqG7HaYpc2R+rhwMo4IzCaIzX9OIejbtyP85l8q0?=
 =?us-ascii?Q?9bucbgzXwGqiP1MK/aYF0fBkSfp9n2+wrMu1rtn06N0O1N2nmjHMlKsCOpUh?=
 =?us-ascii?Q?3F3c4z5vnh2CmkOtMRSTF3CmEnj0lgzLu8u2Al9LU0dFaYlZFmvzVAjd351v?=
 =?us-ascii?Q?CD2DPeYllLKofqw5eAuK1NPHrw3u7zXNPLJq6Jm9xzMyi0HosIHkD3uP59gW?=
 =?us-ascii?Q?7KTsW1yVUDsknRyAy8L8XOIq5v4KwKPfgPaiR0qQho0YA2NrOiqqkO+2kwgG?=
 =?us-ascii?Q?B/Cy/2bJEx91x0pYjIB19i6GR1tuBQ2LXjvvoAVg8m3hTqjyLbsJbuKG+R31?=
 =?us-ascii?Q?ab0H7THNqbeUdz4EZh//ry62ehziy3nzvpYLt1/kVjEeEdnZb2T8oodlkekS?=
 =?us-ascii?Q?yC/ujqn9vQnqmkBTqJuVwETjhhllnNsDXSLtW1TzWJHKEtcYW2LRnsaDqvW0?=
 =?us-ascii?Q?pqHDvEQPTR0sOgR8zRRJHfjlDs715xRK6XcLVyHpioqxHIyqFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?07kSHtvgQx7xZGAbTAq5VB5xev7jMNA/rfsX2b9ICpmzd16qTEKLtsljfC94?=
 =?us-ascii?Q?bJtnTpwJip8M1SbskYo1Yr/6zf/74AYUXeiVXngEB3Eov4IV3wsY0MwS+BEJ?=
 =?us-ascii?Q?mIl90/DcUQCBp30D2CCJTLMWOOLTsCrbviq8E93UBMTfH1xMVbOCNElhsjL/?=
 =?us-ascii?Q?XrPIfLvIM1fhCgFHC5Tex1zZltGHgzFFAx2C6slJZcyb0fCPTs6Xm7SMGJlH?=
 =?us-ascii?Q?T9AuHdH9Vlg7z2yxGYZMSDnWdS0bhN2rIDlP8AaKkFEkrrIIQoyZXpohPkOr?=
 =?us-ascii?Q?TUns4MTSmjecQuJD3b0QDeSB8Jjp9tyGf3Fg9AEkR1F9i1KV/vE/WNdyTnSR?=
 =?us-ascii?Q?Y9g6VzrpBriNeyZlLabf4DXe1fU0MEt8TKAy4H8c7PzF+wzADHLOYJl2zX7s?=
 =?us-ascii?Q?AE94t0BPyJ7PSJv99xM1qw/4IUhKqdumwWEl+7n8OUJpyN0I8FYzzMWmNwGU?=
 =?us-ascii?Q?5NQBFhxhTRD8K9kme7g8GAdKNfafe0p363etUiwHQH2i6/s+qP16C0/ieTNY?=
 =?us-ascii?Q?Fs4ZpmeqDInZD0NSKqTniEP0VXGQeG5s+xSuFpla3rVm1NmkR5k+/EKHgeD5?=
 =?us-ascii?Q?AdFjDG1K0YgPsKTe2midLjnA1hCiufHLY3I91BvkRV92XjP/aMKJ06nx1icg?=
 =?us-ascii?Q?8/Yk2F+bXxmrt8kM/iENt8AkqzWEHd4U4OQ3/7Oaelo2gu30MlxNN+/1kvJV?=
 =?us-ascii?Q?adwsdKV4HaLmvInEnMRGaDLhXhl8P4qB1crJEORYzztrjKRmp52iKLeG4Qqx?=
 =?us-ascii?Q?9lwgCdAYlUO4t67ZELe6I03K+LPJLeq4ww5Sf1gbE/FYmllPjay+j7mTHQV1?=
 =?us-ascii?Q?iz2lnP7aPMjcnkEGKbfGlempxay19gTaosruefZP/3pwmoViHyti5CJHGHGA?=
 =?us-ascii?Q?Brfc10wceXsqNgxt294UW+kmCqVfLSCUaPvUu5TRsi9wX/PSQaMf/0qNRLRo?=
 =?us-ascii?Q?IhQWlrFncKDkyOxC3INdVMLlxkN7MnXgUu5jyUslwN04KclQfjEF9bPJwdUD?=
 =?us-ascii?Q?FFcy/RK7E5IF1u7yAUn/ZLWF0TDL9/rofAqqYY9rfVdIkx4d1XaauGR1FMPb?=
 =?us-ascii?Q?gIMjZk4X34y3873Tn2H4pMs7fvBM/5lENdwOn2u/OdIcDHoGaQCzoO8VtWof?=
 =?us-ascii?Q?XdPxljlHULchsctFUmgiyxn3MRXQdpzZ7b7ecTldhRJkQhjWVDoaeonp9/kn?=
 =?us-ascii?Q?XiLyqOlWpTsbJQBg+h0EgxHaFiQ8T3O0kKO1Y6kirVIjGTA+W5QEOkCWxlU7?=
 =?us-ascii?Q?lYisjbjURo0TWu+IQ9ZSGgZSIqnQCze3VOPOoZF1DR0CUgp6mC201Dy2DwTs?=
 =?us-ascii?Q?ImzBRJR9nfX+skksX6L0i4rVyLu+BYGCu5Vt76d6kyW5vACymeuRab58DEcX?=
 =?us-ascii?Q?qpsLwCdt1re818DCxdjl1//X8sQ9kjOB7YAic5aIKQmVfApjouyYKmPf7DGN?=
 =?us-ascii?Q?QYYyE+f8XlI0JgK9UJ2nbxVXS/ZjsjFifxacLHn5xic5qtW9yOL1cKwtN63Q?=
 =?us-ascii?Q?LdEYyOWW8OYZ4Z4u9qYjut5P5s5AZcAL2U8rRGHgIDZ3FA+AVg//CUonYiAv?=
 =?us-ascii?Q?yRpqZYwUrHsnavsdX0fSORBihctwGyLMnV6lqVWV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03757fed-2c3d-472b-b171-08dc9febbcbb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 07:50:01.6995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqR9eP8t8iTntEXWhCcLaIsQZa5F9bwZ+4yrg9PMKj1SA0hcp/EjM6K82IRiv7Q0lnVwQaKG1dFYEU4TmHq1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8652

The NETCMIX block control consists of registers for configuration of
peripherals in the NETC domain, such as MQS, SAI and NETC. So add the
NETCMIX block control support on i.MX95 platform.

Wei Fang (3):
  dt-bindings: clock: add i.MX95 NETCMIX block control
  clk: imx95: enable the clock of NETCMIX block control
  arm64: dts: imx95: Add NETCMIX block control support

 .../devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml |  1 +
 arch/arm64/boot/dts/freescale/imx95.dtsi             | 12 ++++++++++++
 drivers/clk/imx/clk-imx95-blk-ctl.c                  |  1 +
 3 files changed, 14 insertions(+)

-- 
2.34.1


