Return-Path: <linux-kernel+bounces-206147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B211D9004D1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A577D1C22E20
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184E215B567;
	Fri,  7 Jun 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="msJo8bv2"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429B194A53;
	Fri,  7 Jun 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766753; cv=fail; b=Ptd+HUN6EiGZEaMpDzbFrNgitwqFZ2aCMkRYijOHykqM7gEVoeAVYO+y46eWjPtSIUyZfhRB+wa3sobS0gbUgCa1fB6Az1Z8ZpEKacppclqkxQe9I/jYoihTQe3vAkF4mH3OumPfNKjtFjFtyYlSuqZkx6O9TxhZFcvvs6XGykE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766753; c=relaxed/simple;
	bh=IOVv6yPDF/ia6VFC7g6a5DQCosYmZWqSwVA3g2lf1do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kmOdqHtzL8a2M65m2tBullg+X1OdyeIqbXxSsPXs/OoDmPzKZV6S1/dmH02KQ/bDUGsehsoBMXD8b6H4sh3AXC85eWqewlLmYexFGT2QsAxmkUTq9VurpyNxwTuvjhFLnf0PFs1iqXHX3/7tBDCCr33dg0TV7sM8yeqJBl/O6Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=msJo8bv2; arc=fail smtp.client-ip=40.107.13.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT/36/BEHwFFdxjUslO+7lQI7iy1eEGBv5hrIGHT4tGD2tVEkhY4w6EO797M+b3tUyZRtkrV8KaIpD3ycwTh3JpwvkiuANzrOG4rWAqKAOG/xfSFV8EP2Hh2P8NnVnzTl6xRH8txosIGdSKclFWd8ivH64cQQCtLJDTVYsomfbseKsgAsCWke4TZ/3zyI2Yre3ev2B5qU82r/v9IRjwsYyXTdDC3QWxz0L+vS1reA0V/vOlP7AUtAMSf9NoVyu5ejKI8IzdP/dYNkkR1/cgMPhvaeAOodxbWLn7Sw+HJYBW+NKnAvBcFIhbvxyA3K0KwooBMWx3ieDuS7ylCQJjdHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVRGKmXbBbJ2mV6mhOfZE32oO+BHws2fb4m1MD522/Q=;
 b=S642z7kSKhkBAxTI5zkyZfdNKtOanEBenYgCznUj2SfvODg85/lJjbJRTaKAj8wkmV8t6HuHp419477ARR0DjmLZlnvsOsDvCi64pKWpMn3AOG2k/Yxq5naAN5aat12/Z6gww7FZ+p8jDPipTbMD5LNMYd5v70hgqn+xcPc3VND9NXIxrlIF3w1ZJoVWmLPi8lJFPY4rjhnjG/y8+iPBY/pXlWyv+1MRqdjk2cKGOaCmHatwfiElxPvPxKbEBs3NTfSY1TPducoKyjPpgC4TIbv61h6LPKSGXAOaT6cObWfrLtXC/YoOSA/mnmCv/kqCqgockVMAVdlL/LQVcG/q/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVRGKmXbBbJ2mV6mhOfZE32oO+BHws2fb4m1MD522/Q=;
 b=msJo8bv26SzuRju2Y1JFgCQt1Ps0LFZsrGemt47iIGFSibinnjAusA592RrLF/RjEkA32LGlA+ix47JRIbXW632hUjKAvTIAeeTzDXkSvXwBolOd1I9EcuZwQJsZ4sDvIBdSsBEqLKb6YraYbUFKEesNtZ4qwp8hv6xJU4g5Q6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Fri, 7 Jun
 2024 13:25:47 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:25:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Adrian Alonso <adrian.alonso@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 09/15] clk: imx: imx8mn: add sai7_ipg_clk clock settings
Date: Fri,  7 Jun 2024 21:33:41 +0800
Message-Id: <20240607133347.3291040-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
References: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To DB7PR04MB5948.eurprd04.prod.outlook.com
 (2603:10a6:10:8b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|DU0PR04MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb3c9a7-2f37-4831-56ab-08dc86f5578b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AnCkCj62nVJflDEQqJiJeLQdSk+m/m4owlM0PcdHNLlJEK6UZwtNNsYVgpNT?=
 =?us-ascii?Q?YANhhE+JeGFkh/ZgDcP9pSjcB/CpXNzGH4CUWnNLyuOK98Gjy/tkWkbGLDsf?=
 =?us-ascii?Q?sMWqRzJoOJt/7dHcIo3jnqFtny35UjKm5uxhv+xYyO186zmc4UYN387pnlF6?=
 =?us-ascii?Q?CqoBxWFsKKSdW7qIvJUgyIo+FSDX0TiUPA8nj2O9nUHE3NgpILscOt4tLvzy?=
 =?us-ascii?Q?G0VZvCt4crLkX8dKmShML7q421DVRe4gc48nrZ5HZBjKL0S7Tzp1+fEC4wPo?=
 =?us-ascii?Q?BEH7CtK+FtvEDqYujVes+FQxGXmJJ0nO/nb2kdN/iIU50lo2AbCY8Fy44kLd?=
 =?us-ascii?Q?kbPL3vYa7A6aahEVqYgjxakitzIDPGAwks6ADsoQU9M1u5WXUM6UjgLlDDop?=
 =?us-ascii?Q?5LYwpddkrcaMKc1oOR9VMMDj9PS2pMhKAEj221lh0agmWoA6eijU17lPuoN9?=
 =?us-ascii?Q?f8OTiEZbrE0cRoydczMTGcrOAP74fWHK1MuR/E/QivsOHtYOhi4zN14wFEyK?=
 =?us-ascii?Q?yIk8UV5zX1q2yXagbALY89GvWhnOyX7kveyHK2pOY8vYg+0S8BJx3CpVebIf?=
 =?us-ascii?Q?Uve4mr6ZALY781cJ9oL5sJGjvjpLLxSPZRC/yRwRU/2OvzJ5O503bzv7rn8O?=
 =?us-ascii?Q?U/FAxn1mciBeOdHS4uqCISTd91WPmqcmou52pHu1ZQS8nr3MNqUjn30dRJ3V?=
 =?us-ascii?Q?g6kETHICtq/L2IVPU+QpzFXXOZcC9+IWMCsrQ+rIpivERxcQZvb/cwGoXfPS?=
 =?us-ascii?Q?ZohMGpk9KKXmLm4ootINOjFdIZImzr+2PUiGcsI97EmrioPnyQGaOw166fj+?=
 =?us-ascii?Q?2mD4zR8ZOBelHFnMvumjPGaqNSvzGfHFkQifYgykjOmb8LCj39bieDcK9LKZ?=
 =?us-ascii?Q?x/h87ZLHjOJOF+rJHDqXzqjFAy5hrkKRNneXkELJdzpTQbKWgazMSBo+TLVx?=
 =?us-ascii?Q?AU05QZlzumwyC787/8lQoGbJwFSVROhRonKI+uooEGCYeoXjFbpw2HI+ElHE?=
 =?us-ascii?Q?Jl48MHOKX2xkLj7CJym6YcdDrjrfijCsoHwWrJx2qp2Xc3zSRgrMEVswzfS7?=
 =?us-ascii?Q?a9W08ZSaGQ1O28qPGT8BvMhyJz98gjlb903YDFYAxB5/vvJpXdmaDBEWxcwh?=
 =?us-ascii?Q?LVy8WnKtXHR+m6OASbSsbl94FJA7RO2F6PMuC4+KTRMgy0lAJ5m+snWeiavL?=
 =?us-ascii?Q?A+mFga82TyHZEtboHNeUn/EcvfQcXLyvPhXN46j4KUbziU3Hzu1xk0l7ic/j?=
 =?us-ascii?Q?PTMVbCXmwHgRYJpzzfBQC0PTvC+/eGXhe5Q/v2l7+8jPL3EZkRor6nYQZirf?=
 =?us-ascii?Q?OIKwmU6XRV4B8ZWvxm1TbMRSJ5rpJKnZ4uOY9J1kjOatdBF854ng9Zcg0odo?=
 =?us-ascii?Q?A0kRV28=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8CsOtFY/DRKX/+1y6mIXuynQHHmLD/Wg3AGiLmf4Q/RLW4u21tFv7l1GZUY1?=
 =?us-ascii?Q?28Mzb7VpOKuALlo0E8FMK0JKx1R8/9pxvdvkPL9Dlo+l6SkVNIqJt8fzw6DT?=
 =?us-ascii?Q?Zu7YKDxE582dTRhzzHBHFF2G0ZGuWYtNwjGtqaej5coB+Gm6127EvMi+BVUv?=
 =?us-ascii?Q?LYcsKNTD/L9zdFOOSFoj2sPArc0LMrKdLgE/Wp76xbWCxUXh4ziwQr3lsDDU?=
 =?us-ascii?Q?/iLvwN3u363ZQl/0a0qyQzSLj/N7fz+UN+TisT0bk3X2N99Y9KppVyPVfF0O?=
 =?us-ascii?Q?bGqmFlibFthCNunXzdCJt5np1Auak41/CtfVcXiXEzVSa9JCUsHnSICi3vxw?=
 =?us-ascii?Q?b+CEyFlG5TGboOcSbDpjZY0qnymkzWZtn/nCaYqhwTfCOXZ1qztA7Yvkk/mH?=
 =?us-ascii?Q?o00tTaAS8YibFA5DNTgQmFEmBIRFXkx9zkrt6b+JRz8AuQ+/hb8iHfLk0wDl?=
 =?us-ascii?Q?zdYP0HqWo3lTvfPee5HwOUTGj6k7pTNNfk+Jk5YdryEVpIoFJDVvjwUzWhh8?=
 =?us-ascii?Q?YQ8m3W5nrdbWD9XN2ZJz336nMwRgSiZxGtAPMJj+ajgi0jcOPAryJMr+KEth?=
 =?us-ascii?Q?PpENCYT+Rt2OP3cKioLwihQ0l8uO83VLVbJezce3jDtEaevSw9n/C8rS3YC/?=
 =?us-ascii?Q?MSfFRrmAj4kWz7A6WS48lSP9C4UcY22UzhNIzAVHbuzE1u3Hme3wn2egWoVr?=
 =?us-ascii?Q?fpKYkf20KwAwIevr82g5dQcVNRjozjMAyn8xomEjXF7ldA4WUAJLs9vUPZb5?=
 =?us-ascii?Q?CGyPDzkMhgUw5bsQ+Ez06kt2ouUubftBp3cxYRnQqBA1YCzigOBG4+BkY3U3?=
 =?us-ascii?Q?+1SOGohfyaHxDEoCRw+UjJBzJgImQT4smDPic9r5Dt+R8uCw8GV2cPEZn//l?=
 =?us-ascii?Q?v29pQs8WrgCnD6/3lNn9V687Arzq4H4qOkh/faHhxtfxVUOHXWUPyALDFKwt?=
 =?us-ascii?Q?u7pBZE9FprDjVzv9f3IYOFUZrtG1GHLUFQyEkggBfM0iK7ne6+3vKUwnXgxk?=
 =?us-ascii?Q?OxKBdy4YzTjYh9JCHwpgoKaWvxIIaN7PxlMpWObVPJH6riXAI88G4MyetzSS?=
 =?us-ascii?Q?e9wOKnHou6sNB5jVG8Y8RdgG2iv2hYLt0TappYnIPMKhUcRBmn4oOaa3TBYR?=
 =?us-ascii?Q?yKQ7U9cjhenAiUutAdGVu5fpgNu1NhCR4FMlqw21WrHraIKMb/GsLfG/N7Y+?=
 =?us-ascii?Q?H4CIR5NYP9qzxr7luRuLl05Fh1Hxd0JsWsNe35LlGe2FIfB/jkVY8dVRSb+e?=
 =?us-ascii?Q?mlvMw7ENyvJPGzsTHWTMZEbkuI+BHbGHfCEpXb/5qBiHq1wzF501RjkLzFyW?=
 =?us-ascii?Q?a25c0qGbXwKsR8mp3Wwsh1EAziGygGrcL6PcXzXPLkuPPxHhkee5ojbxkhF2?=
 =?us-ascii?Q?XJrDaTmjxC5pxVjr4s3gayGZd2uBuu8hZyHefgER63QOS2DvgGbvnx5cYmJY?=
 =?us-ascii?Q?GPCE2rNz9J4MPimEkj4K+3hHMNf241/Z0bVHvbWEgQQ5nWAztuBEqcPU8kfb?=
 =?us-ascii?Q?JaIoxAdwm2cGOisizLrsoMNq7qGe6tvRvTTaWQwSU8bhSCBMK0N6xGGGSSrl?=
 =?us-ascii?Q?fyzh5n/oh2+/VU6Wyb1Xt4MoEQ0GZ53HB0fztxGh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb3c9a7-2f37-4831-56ab-08dc86f5578b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:25:47.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ghxow1Tjeh8qoce2OjBBY1m5GGw9Ket5BMdlvhTc/8gTNoClMtxg/7usuP1OfN0SIBSd9zrhWjIce+bjIfZlEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249

From: Adrian Alonso <adrian.alonso@nxp.com>

Add IMX8MN_CLK_SAI7_IPG clock entry.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Adrian Alonso <adrian.alonso@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 4bd1ed11353b..ab77e148e70c 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -583,6 +583,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_SDMA2_ROOT] = imx_clk_hw_gate4("sdma2_clk", "ipg_audio_root", base + 0x43b0, 0);
 	hws[IMX8MN_CLK_SDMA3_ROOT] = imx_clk_hw_gate4("sdma3_clk", "ipg_audio_root", base + 0x45f0, 0);
 	hws[IMX8MN_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root_clk", "sai7", base + 0x4650, 0, &share_count_sai7);
+	hws[IMX8MN_CLK_SAI7_IPG] = imx_clk_hw_gate2_shared2("sai7_ipg_clk", "ipg_audio_root", base + 0x4650, 0, &share_count_sai7);
 
 	hws[IMX8MN_CLK_GPT_3M] = imx_clk_hw_fixed_factor("gpt_3m", "osc_24m", 1, 8);
 
-- 
2.37.1


