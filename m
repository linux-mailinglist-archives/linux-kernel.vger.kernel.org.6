Return-Path: <linux-kernel+bounces-206144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0D19004CA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6B8B27918
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF68194152;
	Fri,  7 Jun 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bwk3o6Z2"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3DC19922B;
	Fri,  7 Jun 2024 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766738; cv=fail; b=NQmAd+ho1dqRX0S/ce2Bz8Dk1IAkpI0Z7gvVifekBYGM0/dVNUIThP1PshCSpRQ0QUKCGTzEh2G/xAMneXyMLId3p5ZjYqHg1+0QpsFgR6Ce7LtK5zivwJnm6oLrCDmf9vWDp0doTJG6e4shEVxYyExEymn4hqo9hmQgEYtxTIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766738; c=relaxed/simple;
	bh=kl8fWQxKq7NNcddeEOL5scHCXX9FmOhhpdrihfcxJro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZsnashS3EPUmCyX61eUVU7eFHHZ+bNoW/jnVHhgaGyOzvVE2mKFChak/zcDGywmOd4yNGh36BkpHfdC3lHX6B4ks0QbX/ilYQkdcDNFV5eyTvC8JYk+73pa3mzPszGNo1Y3or+RBhqMm+k3eCcGRw+UUd+vqhTOh+I+bX1d3bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bwk3o6Z2; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH/bbFvAjiGv03ugg/RyxTKS+uvs2nzK6dO3l4ka2Caq9sc+GE8uXr1Jxm+LkUR7KXSYCKsuXYS4f/freNXI7/77wq1hBWV+1QBxG/QWHU6DOVBSrU/TO+SIWJDUHDInECnyDy4cYQy5xiUmVac/5vfox0g32GNBbyXy0Cxces3IQLKL6T9tfw+qpYIZ/HN/m9jLSz/MzFo4OG1CohnAGP2P8c4Nz7Bi3yWdJhwLBzF00GCwMfVMpuljVQ3vgeoEnDU21lV34sGNJlus9JO7M8s9T6pSNzHdsFoj9eqYasLpBnXC7Q6tT8Xah7qKKCGZGiOhutLkBs1Gi2EHI4HEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91bgiOZHs/TZ3l9vewFFwS+5GI5tm73vN8/uuPYEIec=;
 b=YgBYF9mCio1WgzRe2rAXCuK/pwop0QoRmyyT6sWfPmENwkPZHuMkg5sI7eU1snRcZlPQFSTrTbVg8AnYjkgfnyVg7wkKU/8DVRHDU32yJiR+nzvQjOCpioFq4thNxwQ9yffTARuaUMT1joYueJT5/0gB40fAMW4SzTX8zLTRMtERAN8n1X/ofgZ/Dkl9v0RhWoYsGCbHG2s/JzdM51qZxBBnTWj3T1KACjA0WM2aLARiIN5XVHeSBboH0t1mFKdLWxy0RsYQ559q5fBg+XD9mmuXa8PMWU0qSTizCWBKuEIKpK8bmxp922beGuawH/CHuVPcvG2sl8HUyl+N2IOCrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91bgiOZHs/TZ3l9vewFFwS+5GI5tm73vN8/uuPYEIec=;
 b=bwk3o6Z2Q+6pT0uFXYYISRDvgvxcpMp4emv2fzh1KW43CAhj0hOxUKdO53QOlV6s4d/4oDD8N1WrtlhL0cIvv9HAZ3RKHjZQWIDURLu8YAML/agxa4akZphvBHg8boivnNcxnqVcsYNHouZSk47WhLZN+FF4G5qKhS4fRNOhzUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Fri, 7 Jun
 2024 13:25:33 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:25:33 +0000
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
	Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 06/15] clk: imx: imx8mp: fix clock tree update of TF-A managed clocks
Date: Fri,  7 Jun 2024 21:33:38 +0800
Message-Id: <20240607133347.3291040-7-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 43b80a38-8d64-44ed-6f18-08dc86f54eda
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RGzg+KfDWOFOj77U87K4F/y2v207W8ky2aMHqFDFilNm/Ugc68XxyV0QkbIo?=
 =?us-ascii?Q?tH1Jhnm+sBt1xpEw7oOd+EVKd+epaFo1xJJT4XKLGpaVTYx2O41P8P3NhBgh?=
 =?us-ascii?Q?r15qSHjmz6oXJ428fW7MP0k73ePh8BS9ee3TPk1fS1tiOYLWeSGRSieaelN1?=
 =?us-ascii?Q?TXvyBw/fusXhp0D7uW4Ob3iQaLIhw3ZbZrUeqHXWpZ8JmhhHZ9+NUHVVvyb4?=
 =?us-ascii?Q?+Ay+JQjjdjD0k0YTZLEJNzZiCP6imWW2FQe4scM2LtMIL1wluurAeiSnq3+P?=
 =?us-ascii?Q?Z8Wx49XxmpT7Uy8rt9GM/hkfPkxarrax27tXYz7aWnHRWvT9BzrPTkISSjgc?=
 =?us-ascii?Q?3sdHoCt9kUWJ4d3ZB6uSrMjyHKs99KUTa+rs/zN5bqBHBCq9OTK3ZEw6+nlp?=
 =?us-ascii?Q?tCyooTq9qG3Eq4wXoiGqZLDK9J5gJn25wctFlXF0jEbHLz+n/iH5cTWT7Tzr?=
 =?us-ascii?Q?hP6VG6pqFOWU0GHYhgsrtSxbrk9lQ9+58fLwWUDBDfU86baJEwJWMMnXyqFk?=
 =?us-ascii?Q?lU91q13vmYsbMfcf/zP8ULy5k2kxCx+1Va298zQpX2ehBgi+UlZvpQqlN0MR?=
 =?us-ascii?Q?N9GtyuazLRDo129+FlTwenKDf845oqQqtKcldh3Epr2r3yM0mQpbRkwfceFJ?=
 =?us-ascii?Q?Byk7g9zanPoZ4aarBN2iFZKcatQ9OWQntHYN5NKShTVWqarK1AJD+Tl9OBRF?=
 =?us-ascii?Q?49PTH95mlvy/8oEaHix3iuiVwDIq4hXgiXAMbKyh25JkzWPc1Lpd0d6XIIxq?=
 =?us-ascii?Q?iJMFz70f4cnuKZ2VmILV3UVFUsvQsxdH2vwInNHknISk2dFwdaD2esOoLVI6?=
 =?us-ascii?Q?W5PnyI+RRzLTga9bCHfqYKlVgB9wAqRhUqAFWAUoC8tu5+B2KdUAkL5r3Gu+?=
 =?us-ascii?Q?ijtIY6/3FoQrkqXNdCdSE7dH3pTIP+f7VtAdHdLZcgnj8We63t5ZYA7NGWV7?=
 =?us-ascii?Q?OSt31Yu9Zz4RnqUz2+i5aFB6jPHc+WAEdtdMRhP8npig2FqI7gfzYkvXTPmp?=
 =?us-ascii?Q?+73bgtIjFQGwRMkOfNhII08Zao5Nz8/03yy4nCrJwQRSMIMpGkqZ2n3IgOC4?=
 =?us-ascii?Q?wAlifgHQPOCjHWxFOQlUbN5y+7nLSbQAm9cAU91VjlP1jcxh/KwJQ7oUdkYt?=
 =?us-ascii?Q?rbXZJYfauH4kYUr98Om+J9q9yfdXkTSqB6jFjD+Sqg5oBVxGjR0R/yqrsDT7?=
 =?us-ascii?Q?6o6+FuAOMWS7g261utq8TTd8WGdQl/My0e+upog/WUYm2bT6ZNmF1L27C6BX?=
 =?us-ascii?Q?Oaz9M+pMwYBIjsDtCDnBFSKPkdt5svOH6KP9QBPWXF46GBIxW30Lmi69MFK9?=
 =?us-ascii?Q?Bs3cwR9u5vYQXctNSrgYy2d2EH6NXmuIlKXcqo5N0yG8yLaJODbsrSxcFcYW?=
 =?us-ascii?Q?wxR8lfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K2JP1lr6+F1D8wIZAP1zT/Ql+ooBRN0kF71jefCt1HfZLcKTreV8pPmBGIA4?=
 =?us-ascii?Q?u9jFmxnQEGQ8w5Xhbo1IKwQwaDfdD043GYmBdxLRdp5It04KvSq3tjY3pXcy?=
 =?us-ascii?Q?VEMXxn+AXZYzoe0RmAX/s3ifI5vAC5qKE5AzccIWhn4GXn40EVqHvEol/XO/?=
 =?us-ascii?Q?xN27zaDO+yJw1/mTxzqMh6+WaKRRLYcoFUAWf7EXKNJNohX7DaNwrF0O9nGP?=
 =?us-ascii?Q?lIVxm1blvyNvUhWU1Xekd6M05v91ebqHfseDFpd1G80eXdXdjIrZg30Kc0OJ?=
 =?us-ascii?Q?yiHKQ0hSPwRZUlGzX0hnXIkwWmS/XbnykBvf1kYffAw7bKFMleVarLWobMyx?=
 =?us-ascii?Q?/u0pCWXExYQSB39aXjWf6UbmDIHAisfPmSf6r173tM5Z6WNeIevu9VjPg2Tj?=
 =?us-ascii?Q?p/z2Rl6S/WeovRnjYIWmFquFvV4WOEY1EdCAdI0vJOvhR3EcIugkFrPfAp6+?=
 =?us-ascii?Q?sftpg3M/jC//UzphEPvajGgWEbIHnVg2mXbdmb9VR9CUN4Kil8qId9v5UeGP?=
 =?us-ascii?Q?2+zehTOJnZmQmM2eYkOrpTc9EfU0mBaYswTQr+//9fUqiUuSUBp6dThmG348?=
 =?us-ascii?Q?auM53I20AaZuc0LChTxxPlXW36Q1mFLCAwOqYh6KqzE783RTK4hSKw8FcNDW?=
 =?us-ascii?Q?O/niaITcP8jxnB2zfATX9RRwerNw5leqaDQPCTPTBdfDarTiUV5QLL+jpJHx?=
 =?us-ascii?Q?zdKfz5m9rkivdPrG5PEtBKj4McMWRNurEcEqRitqPqvTrAmEJF3wcuMs8HEW?=
 =?us-ascii?Q?A1yyI0MaRWRX4SvwdqKxBKo4+NSTLo+R0dEg7551hvWPE80lSJQMIV4O83x3?=
 =?us-ascii?Q?4c9d01C6idcOHbcQHA4cThxp9Gl5elLzWQ/WtBt2GNQcEECkEE9HqqpDL49o?=
 =?us-ascii?Q?anNFmLXOzkKRKLgEkGmhdduICV22l1TgecjUP8kwNTcBsTNjRokPE8BqlJur?=
 =?us-ascii?Q?S+fVvyD3xjnNHeJZRNsN+o19knF1YQd8Vt7CA2Dbtl9dsnceix3W0+C1d1Ox?=
 =?us-ascii?Q?745Hq3l4x0fAyAAP5Wa7ktslq/zxu608KYu5bg+l1MZOTd8hQgp4sIa+8ux9?=
 =?us-ascii?Q?DRORj6ley9C8COxCZ+CHWvWuIRkuLH17K2AadWPaMup8Ko/cb0Zc9JiznEA6?=
 =?us-ascii?Q?VKhq2GxeJA6dkW/gMSTj62foPEGfmzhE9OgFD3vkun1y5MWf66fCmjwrh8YS?=
 =?us-ascii?Q?t1xfmZlA13MD0WsN+P9HkwDChWoKkY/QEprfHIMk118tPkYVNmEBb4JS9FXE?=
 =?us-ascii?Q?qoi4tYNZDlCxrKpk2ofpZRgpq+VtljgDNqONCsyLp2fkNgkesmkj9vdBO2or?=
 =?us-ascii?Q?oK/iGwlFdfFp0mGzXaFnoea+enaauGwfb6uLKnYlVaWXEPyUUxwcOeLky5y4?=
 =?us-ascii?Q?xxc7SeKP3752u9JLmzi4wfMhGWZ5dhj6z1nH61CPeVEhnefRsl1PzD0D2wQV?=
 =?us-ascii?Q?vx2VVdUZ8YwTDbPmUA6NgPNXujDv+hlbzPA4rc//BNLDAF8zOxcjyNuMWqpU?=
 =?us-ascii?Q?ZpzdKncxOijhENK/Av8LGCUyHpCcTE6tJH4cF01hyqBeHHI81rLV9W/Pyz5m?=
 =?us-ascii?Q?+/msfA2oHHrpmhg8p+N524TmEnDsX3Ui5o8oovcu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b80a38-8d64-44ed-6f18-08dc86f54eda
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:25:33.2014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoPtgOx7iDyeGbXXA5ZzP0uH/CxnjHW+59c8YIbcVD9oitaZSPXibli0P89YGfoIfwJj80iWoJFSeAfxoEdHxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249

From: Zhipeng Wang <zhipeng.wang_1@nxp.com>

On the i.MX8M*, the TF-A exposes a SiP (Silicon Provider) service
for DDR frequency scaling. The imx8m-ddrc-devfreq driver calls the
SiP and then does clk_set_parent on the DDR muxes to synchronize
the clock tree.

since commit 936c383673b9 ("clk: imx: fix composite peripheral flags"),
these TF-A managed muxes have SET_PARENT_GATE set, which results
in imx8m-ddrc-devfreq's clk_set_parent after SiP failing with -EBUSY:

clk_set_parent(dram_apb_src, sys1_pll_40m);(busfreq-imx8mq.c)

commit 926bf91248dd
("clk: imx8m: fix clock tree update of TF-A managed clocks") adds this
method and enables 8mm, 8mn and 8mq. i.MX8MP also needs it.

This is safe to do, because updating the Linux clock tree to reflect
reality will always be glitch-free.

Another reason to this patch is that powersave image BT music
requires dram to be 400MTS, so clk_set_parent(dram_alt_src,
sys1_pll_800m); is required. Without this patch, it will not succeed.

Fixes: 936c383673b9 ("clk: imx: fix composite peripheral flags")
Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 670aa2bab301..e561ff7b135f 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -551,8 +551,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
 
-	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
-	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
+	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
+	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
 	hws[IMX8MP_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mp_vpu_g1_sels, ccm_base + 0xa100);
 	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
 	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
-- 
2.37.1


