Return-Path: <linux-kernel+bounces-560726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF10A608C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1B117F255
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8FE3FBA7;
	Fri, 14 Mar 2025 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VTobF99h"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2075.outbound.protection.outlook.com [40.107.249.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621E2F3B;
	Fri, 14 Mar 2025 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932173; cv=fail; b=c8/uooiI2uK/PUp3Uzi/E29zoTm5lD3Ymqkc+5UQX8v8R/pCLjGG+bW08WWM9s2qusQ990ob8mgGgRkIhlifY//syCDidRVfI/0CfGd5J23mVhu625swaNtCqgGgpJ2u/NUYk2tcT+LS5vXpk+JNjTRpjBBcyiljEPYC9PRH0GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932173; c=relaxed/simple;
	bh=A2tR+sI/F25/R9+h1MErz6wCoJxvnmhr3fTpeeujKMs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jRxLeTWFJiO248ymHGuluCPlIu56LcgWAGuef1taNVVWP73+xJcx0yPFA7uKXs0IVcHI/y4RbRxNVlROtFQPlyrzLiFwD6VSHbanrmlZbryEJWvqlQqcQiaP2Eq/6Cvqkuf1SPzSsTB8q12fsvRdl6qpzrRQbvmsn6A8xb/Z+SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VTobF99h; arc=fail smtp.client-ip=40.107.249.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xo1haDNsrF/MRfdVq22DGETb0bB/ePkMAMVsuK/JP+oH1qmqzn1WuRF7iRPHHR5UtKBhjpOXUBmIX3GR3kHYMvbwyrWEsZ+i1+Bp5VXEXbVRAP/pivtLRgv3rzLHOG4r9C1TG/ssM+oG6su0LC0NV34cO2HCTheJ7rG6E2aD3zzK0jTLRtIEQfCvqWnJHJ+Hb5gwJlQzrxi7beGfrFCxm6/47XpmSDWAcqgbp/rwD80F6QoXvWmGC3V+/kRw39KyMdc3gbVsKqx7Y5dHj88aCUZ1oINuyhm2kKLlA/CsLPLaq0VmhLhrWK1Lv5jT7NTilxHX+Tckvw/h6/9tPGck0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAAUP8owXBwbZ90/a7pUKXIErzNvIYENt/NbS6H8+xw=;
 b=NSfpGgQHzUu1qlXzbauVMZaZ+0OvASagfFdzoLhZyddgcP2QnCj11FvWG0HJprZCxm7hfhlwGEv3MB0FzfssKsK2uCGjtejo3FLsUYDE8yP7CUBVFqGr4oskd9Q6pW8W5zc9xDGZRHRtY3Wi36FsTbLOwa2NcSrxtum2dE1OoRcx54Ma5I08EIn9tY5pNU3dWJhUnKxrDsfEvddSc2b2omVaoM7u6046xkTJ20OMDLuMLBdaIX/FAIT3K/sRAN22aWQoT5KtZhtK3sbAOlPPWk7yhSY8zF5yrtgXCkuKDxmx1JuG5CTEDSVQ4YMqNFJlSk94QFa1hVNB0ll5sheuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAAUP8owXBwbZ90/a7pUKXIErzNvIYENt/NbS6H8+xw=;
 b=VTobF99hc30rJ2ksZpLPhG5mGWSStPdDT2jVND4Pm1zPI//PwtUv8siGb+JLgSo1A10Q6kWoIMDaX6XD4hxknMPewT1EJtp/ugj+ZDr5/AL3DSNppP9N+I40JokhSm2aneK86aLHmbJEvXKUdgfKv/rCGlftpTP0AvEkpSEcsZOZWruYU0Dpo1mW/F91rFgJWPZUDkeF2MhK/F2LVhcqXAvRTK/4zg2vPT+eEE+9F74Rze7vYnCfubRLmOmVgPcBW10PbukhxdmYSBlfZryuD12hqGyxeRsRi7hNZqLwZhDAVFYpkE6xV0Janbch37DutIFmHFQ8xYl5wi3mAbUvpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 06:02:49 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 06:02:49 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1] arm64: dts: imx95: Correct the range of PCIe app-reg region
Date: Fri, 14 Mar 2025 14:01:04 +0800
Message-Id: <20250314060104.390065-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: d305c141-72b5-496d-7d19-08dd62bdd938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OWIXC/MNnkDecLOC7OfzjW787OcrDVMWVDEbstC2G6lsi3Zt3b+qdVgYCMBc?=
 =?us-ascii?Q?vZs0E77BmCpEgFbVceB54mYRQCHEAe83s3Gz171XoMnsqyduE6fIwylksBN2?=
 =?us-ascii?Q?4YREVKdJNvXz81dbo6n9fOFM7idwNVCiaZ6ksLWJYnpOoNSuxTEEyeD2VqCX?=
 =?us-ascii?Q?gbV5N7atRHiaCOUU7MrbHTlAwpHCthL7aBiK01areeBH9y1aK5uzmsrTp5zj?=
 =?us-ascii?Q?CGn0ROVFSdKGjmwUrIBCZMkrKAS5ck+/M6uNfE4mNlEZKobDlAFTgLyu+Zmm?=
 =?us-ascii?Q?ESyxqBYArr3RZ1QSSDnpLHwpi02/BCzQNq9s9TP5DA3Z1D2y2wS/Gfqsq0Ox?=
 =?us-ascii?Q?+TTjYYwgryZS+hNnTxuj3jGv1XZHvd2UaADfIKuZwvO3XkxVvIiJA89G8Gqm?=
 =?us-ascii?Q?U09NQXKxfOiDNV9Vt13ECZ8tnFYnd+tvUJNoNPL6lrDYtgw3nxUD8n0sEZ+Y?=
 =?us-ascii?Q?I8Y7MW04twz+WtjQF+yyU4JOPXdMRPqtzdGP8+Mxb04w6Nq0xgIbT+m0Bczm?=
 =?us-ascii?Q?e4DXqGAEnN4K8PDyPhGSfyv8OltX2XtHvtmtvpsHdCSHOYy9KDPO6oPGJ3Cw?=
 =?us-ascii?Q?4NGF/Wwuzvu8Tr4hA6j7hdI6xtOocrClE09mjkgMaF5U8eOR8ea7+a3hlYg7?=
 =?us-ascii?Q?sj2+R7WhvQxJ/xwsa+Ol7ONSEWtHdjH8Bh7L14A3fluc7T3ZDzciMmw2pc0a?=
 =?us-ascii?Q?weeDViT4pC+460JtHe/IADfCibW2hHZm7+Mq9waOfGZO/jKZsnDoRnSoJzuq?=
 =?us-ascii?Q?9RcLycMtgOlI6kkLDqAQhP0xvPCwjvljpZj0eDGefDl8hCFX6TpJdxCvLFa2?=
 =?us-ascii?Q?qrpgGydFc5uVG1fwcQgnO27+JPeeYK70uEZGZLCtbEZJzFAK0onoecqopxgz?=
 =?us-ascii?Q?CXjZfses0N/Bj+3aNh6S1wjWtytcGMz/6tH0JnP8m3gNGjguXtaSuKYSMyxy?=
 =?us-ascii?Q?lKuf6cuEdd3n+t4CRwv0R5q0VhZTC2pjq/5f9fIsbOpgO31e+4XQKDvcAiTl?=
 =?us-ascii?Q?HKUQfOvtDDbPehP2ikZkZuMqqywwurovRnFDu4mDnDb8g4EeOOK9HxCO/Ca6?=
 =?us-ascii?Q?mrHdpMDE2qt7OMclluPMwzmv7fccohL0vC0knqxpw4YNlCH+ojt2uUJcK9AI?=
 =?us-ascii?Q?sfFYmXcSqb3A0ck3G1k/2gw4rU30zD9KdUVDPmPhl2491EXYapMftfYl2RK4?=
 =?us-ascii?Q?upq4YybKyRpbFuWLRAehbHjxA8RDNlXJ2DbP/m5zzn1+XXfLs78AJ5ZHaj8p?=
 =?us-ascii?Q?MyjFnZC5uZkauQMckTSBYg/2CpjYe5DbHfCRfMz1alsJDsnavqlymu4gd0RN?=
 =?us-ascii?Q?sS4ghEcVrmcMERy2o8OexrgjPSm1YzjYR1oplNNt0R1relQZr2eoA6/WcOoD?=
 =?us-ascii?Q?+xtUWi8w9P3ezzUCtE03GwW+pWxMyk/6FoOO+ITHrYjbOrktc1Q4EZ1Db/6B?=
 =?us-ascii?Q?kMJRCZxhdULenrxznHPC2QZlTOHRq7Z9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Si6u+1tGDqfOObyYGWYF8N0WIb+DFM+WadUbvAaPXy9epb480VoI425DaPr1?=
 =?us-ascii?Q?tYELsd5meKTtrswvxhsKMjSPv0tFADCs3Jskx2UsHwElRsL7ePH/0ocFgiXz?=
 =?us-ascii?Q?n4Fgay7THtCSINC22KlWsYIg37Uk3BpxRbGvSOp8md0BBN58Pfwv6ey6ThHw?=
 =?us-ascii?Q?2rgPe3kuNBWaidEOybrWSPtjznhQTyP3Wj1tjvmJuPiC8aFIZ+vbhwQi0fiv?=
 =?us-ascii?Q?tu2aUMDI/mhhttxHSdfN7tZ0ZgYiPnG3thSp6Zut4bJEbFTRMHeXnU8aM0Hv?=
 =?us-ascii?Q?pXu9zQ9U3SExOvJUdiocPR7HoWlLLFlGBOVE+ougdhROSSXfMg2CtnFEjM6p?=
 =?us-ascii?Q?rBGio5oTg91aFwp/TXBRbkHPU0otDgtirPSDNXuud33+eazUAiel9s6+/PSS?=
 =?us-ascii?Q?l8s6DKUrq2ze+UpSuaWks4F97skJYF8vOYandVZsR3LqZenJqIIYjDxvq6p/?=
 =?us-ascii?Q?WxsuOdRgUUsUxVA+RVya/JHJYXeO6Sg3sr89ecEC9iI7v5LWYDcG4s6dGL5H?=
 =?us-ascii?Q?jdxKy9CFRLGDgkIq3g1abM56+tIWDMASCey4EhW5GWubNz8Wsu1bNeG/AmNG?=
 =?us-ascii?Q?2L4pq3kc7u4QlC8/hpsNJ9EZ/8a2pD1ddOC2RpsTTiScReOjVnrz4azYSLCh?=
 =?us-ascii?Q?KoaBBheLCab9dDNbaawCk3sUf510WUnNAxz1R85e55tyXmaqJJO/pSAbxP3V?=
 =?us-ascii?Q?sCQPidHTJJmoeXOjUJQENYVDYGfS4XW0yuVO16IFUnW7KvKAFuyqqb6+6Cv5?=
 =?us-ascii?Q?xeUyGaVYwhgISDRspxuXDh1yN9lYEpkvnGByEyAK4nqsTDcKxIyGhNkPj8MP?=
 =?us-ascii?Q?DAcwpVSsb3xybG7u/kwYC6PjpImAjD3L+v9PhNtYygysKEINyU8aJlIUopNc?=
 =?us-ascii?Q?sxvpR63sKPcw3y60lVSTAqomZ46ybjiIMq1YyFn8mn0AZZXgmnJAQ7kLL7AK?=
 =?us-ascii?Q?59p1Y2CL+z3GHpyUdPvReLjCIasX1uvfLX2Udh8wsF1+gh+fF+7CTzPmnEss?=
 =?us-ascii?Q?6Kfox+ppA6ThM22m5AXdPp5ZJ2vH2nEF92pl/WxBS8jsAyTW8LJcJzzKL8mF?=
 =?us-ascii?Q?+YaNhI7WZTVJz4JSh7tvZi5p8cycGZbClJoIP0Unm8UdiXPvW2Tr4vXvfWwF?=
 =?us-ascii?Q?AE81thNHYnyl8GG563L0yz+Qn+OkJGxSC0uy5dkNOyLFDcxWhB5cYnX/g6Ld?=
 =?us-ascii?Q?ThcxMNVuinlNGvGMMzVk3RmtTnlK1zeHd4SX7euFghudXGtWPsJiBNjU83+s?=
 =?us-ascii?Q?eRkVVFOQwpBz4Pg3YA0Q+OVp49TpCGqDC2VG8wO+b37XoAqHRmUrmuPgQKjN?=
 =?us-ascii?Q?Z3j5lfNyYUUvcCrPZ1W3kpKTE01cNEiUu1MLsUTBB9HWv6/m1kxBtqmty1g8?=
 =?us-ascii?Q?Yqg4DxWgAofe5hc4edsbCoOs2hIYplbGOa+5rZj9vn7fCX1+DwspZmDFxY2c?=
 =?us-ascii?Q?TFLJrIh19jwzgbUOHCdTybag1oIcFILmd9hQsrQkzinJA1PZHYzhsrDm5+ph?=
 =?us-ascii?Q?9qCZAuIs0BjwqQcgDq41FixrakiTsVX0fPGzlOcykqiFmO7oCGROK8eS3dAp?=
 =?us-ascii?Q?3hNeKLj25aHS+7Co04FBOvSXKfj8UMgwiALIB9/j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d305c141-72b5-496d-7d19-08dd62bdd938
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 06:02:49.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a30BBYWSZtrXKnn12Vfyc8DJfiE+UJ90zPyhqWseQT/6VuoQ/gAUw3KmkI+afiR9pwE33PcC4QoU8ope28278A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142

Correct the range of PCIe app-reg region from 0x2000 to 0x4000 refer to
SerDes_SS memory map of i.MX95 Rerference Manual.

Fixes: 3b1d5deb29ff ("arm64: dts: imx95: add pcie[0,1] and pcie-ep[0,1] support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 6b8470cb3461..0e6a9e639d76 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1542,7 +1542,7 @@ pcie0: pcie@4c300000 {
 			reg = <0 0x4c300000 0 0x10000>,
 			      <0 0x60100000 0 0xfe00000>,
 			      <0 0x4c360000 0 0x10000>,
-			      <0 0x4c340000 0 0x2000>;
+			      <0 0x4c340000 0 0x4000>;
 			reg-names = "dbi", "config", "atu", "app";
 			ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
 				 <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x10000000>;
@@ -1582,7 +1582,7 @@ pcie0_ep: pcie-ep@4c300000 {
 			reg = <0 0x4c300000 0 0x10000>,
 			      <0 0x4c360000 0 0x1000>,
 			      <0 0x4c320000 0 0x1000>,
-			      <0 0x4c340000 0 0x2000>,
+			      <0 0x4c340000 0 0x4000>,
 			      <0 0x4c370000 0 0x10000>,
 			      <0x9 0 1 0>;
 			reg-names = "dbi","atu", "dbi2", "app", "dma", "addr_space";
@@ -1609,7 +1609,7 @@ pcie1: pcie@4c380000 {
 			reg = <0 0x4c380000 0 0x10000>,
 			      <8 0x80100000 0 0xfe00000>,
 			      <0 0x4c3e0000 0 0x10000>,
-			      <0 0x4c3c0000 0 0x2000>;
+			      <0 0x4c3c0000 0 0x4000>;
 			reg-names = "dbi", "config", "atu", "app";
 			ranges = <0x81000000 0 0x00000000 0x8 0x8ff00000 0 0x00100000>,
 				 <0x82000000 0 0x10000000 0xa 0x10000000 0 0x10000000>;
@@ -1649,7 +1649,7 @@ pcie1_ep: pcie-ep@4c380000 {
 			reg = <0 0x4c380000 0 0x10000>,
 			      <0 0x4c3e0000 0 0x1000>,
 			      <0 0x4c3a0000 0 0x1000>,
-			      <0 0x4c3c0000 0 0x2000>,
+			      <0 0x4c3c0000 0 0x4000>,
 			      <0 0x4c3f0000 0 0x10000>,
 			      <0xa 0 1 0>;
 			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
-- 
2.37.1


