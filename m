Return-Path: <linux-kernel+bounces-399769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E0B9C03F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859CB2832B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B51F582A;
	Thu,  7 Nov 2024 11:28:51 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087461DF72F;
	Thu,  7 Nov 2024 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978931; cv=fail; b=GtmvyH4jddfxbk1efltWvk2SYkLIknAF5t65bLwjoRySu9+HL69JO2NkNJw3IShaAdpNaFQy/KUMmlnoJntyw5o0ojosoFEseHBQH3zteoytApV+6b9YzCdCUtINnw1z/LLdbfbBDXeGoftv22KBVFTjNDq7zcCbk4bt5a5PH5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978931; c=relaxed/simple;
	bh=I/PWyf9ghtamq0cj4foDuQtOZuj3D2uThkx/3CmEHjM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VeH/spfKBrUC3VpaPh18y66ycAOKaDP+hN1Hk3dpOb3wzREAce5zOpRazQU/CGqfqPWZKmIUyCjjjsa3HQRgv275Q1JRugG6B6koFTbi4LIzR+2yfTGuudOdJCNaPZ5MsWdAgBn5IrXUDnZ0okWOcO3FW/zWAkDLguwNawsLXv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7AnhXL016358;
	Thu, 7 Nov 2024 11:28:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42n9a0nu19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 11:28:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkGkmKDk6Gyzf8tRGkYAKen6jW+WaHx+UqgdDR0kfq1fTRDmI1o2w1aK7FtmbaJzeRFcyPurvRUWix+xf4VGmYFfKiqlXo7i7ZzZlpJctGQh+0GLsPx5/61Sp3w1XwbLg/KGluXT317vsgBs2W8IOGezX3pmuSCOtLIt10U4V8s4S9fFWwi86/gvQbjeZKt0Xvt7uNBearo7zzT3Uo5x1BxAHo0Wz2dCn+vagk3BMcTB5IZo/RsJHOdQr19hj0g3uJdW4D1QTTVygqM51dSqumoYFfpGofozJ7d0YJjIlKvs+Zzv7BYVYBcWRr2ndp7WijuAS0alqjd75bbJpnm7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGZIUU9i30uraJOVgCvLBVBjrSztCjW5xQsYH/xVpus=;
 b=gx2vF5mreQOlws2tY6xlRqdek29HaPVuBEwAuv+tdL7AlfkwAEL8TNiZ3XFWuFW/TrtE4e7G71zBRRJhLu6Ni1sSIkbVHiVgRWh2gr+TB+fj5JHjqjAx0ZUYllmTw9RTpMJONORCpmN7X0wH02YXYa3L+wutw1tV5kgUG2995xADBuJU4VkVbdnE3ObpyNiahYDowNI3Pfp8bdbkkOv2OBFx/qK7HesUi972znE7Bpka07DTDcRrarOaaL4CcmGY6yz8U9VDDnP/SJfXbXmG833FJVPhCwDs8Ii6DZNLiRVAzf3saj30d2EPu0UfS6rLmVE8oLb+WpWZh1cmeK9nHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MW4PR11MB6667.namprd11.prod.outlook.com (2603:10b6:303:1ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 11:28:11 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 11:28:11 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, akshay.bhat@timesys.com,
        p.zabel@pengutronix.de, Ranjani.Vaidyanathan@nxp.com
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx6q: No need to repeatedly disable analog clk during kdump
Date: Thu,  7 Nov 2024 19:27:50 +0800
Message-Id: <20241107112750.3590720-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0313.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::8) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|MW4PR11MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: d0de052b-da4c-44e6-4dae-08dcff1f42bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BFDXOUGoaWexcOUc1LQJdPETKBPhM0HPmO7h66oKd9Mnwr9byIybEK5z6HvB?=
 =?us-ascii?Q?rU5LelLjn4ysqBrjWYJ4J+wnpjERPKgSmkYsi0WMbsaukQuU7KTF6vvssS8u?=
 =?us-ascii?Q?w2wVK855OTuFZWpgkzYmGZlsV16rGhSwoIMhBbEOYfOgifRKxO+8857qGf9i?=
 =?us-ascii?Q?C3zrPI3A2vx6cqSTscVpLhf4aFE1Bo2JOxVMLNO4etr7ZzlU76sYqnakTDHp?=
 =?us-ascii?Q?jGE8+bLCYApCeM+mfRLfehtcr5f6x2uyoSeqQwTBJFGwhNGILlsrjWGK6c1C?=
 =?us-ascii?Q?U+dyXAmLL+he+KJKcjzMqR8v82q86UKkJ8Fsj17jqTrs+p7uvLe5j/Hy5IpD?=
 =?us-ascii?Q?wviZ3vv+2SyOrjAHtKS4n6WLQsP3xgy0lyubBOB2Pco5uYVGJYnvbUfIPS5l?=
 =?us-ascii?Q?iBe3fDMcaAh2dgRBR1wIMNhg7LR7Ct3scHIhk1eqsnSjK57YMQ0ma1XadFbn?=
 =?us-ascii?Q?fp4DzURZHy+cM+T35HEQ0T+dYxs+EqoCoCCPvhU8u/3NzChPnMJmM3BLH6J9?=
 =?us-ascii?Q?kjF+7bPu0MC7FcDc+jwY9pT1thrSQuYsC9nzSW9hZB2wxPFOz/LTtoNEgnr1?=
 =?us-ascii?Q?hI/3DgYKL4JUpAYal2uJP7gtODrFWffC28rOtEJsP220RW3D4xxcGOiT65xo?=
 =?us-ascii?Q?9mABVPQyXbl+RLEzXyi65xNgUhF3sRow7/bwFSwZ/Ek+ZYgMnd6OqcqymhOT?=
 =?us-ascii?Q?oi21R5V7DEZQxCEyxLUwY7S7xQG9iunGt7Z+w8GKXBlt1RPKKdgXj9bePurw?=
 =?us-ascii?Q?457VxPVxftMyfvKyUhdF78UVnTFB4JSvWEq/cuia60CUZ+pDgA/mQub4/pnj?=
 =?us-ascii?Q?3Xi4mC0/flQ9wQJg7fIi7e8P55x9CxkAudY7OxJtOpWFc+q3EQ3ZhpGqK0Ka?=
 =?us-ascii?Q?f3wMV/O2FT3kjLyrddJRAamAJYIjXqXzgyPknzsB5kpxLxIigBzpqJX3n/7F?=
 =?us-ascii?Q?X0sXJByGVDLtaWMjpbDELl29jsWLhWTz5WDu4jrX/ng+HveQNYJADFsF8wkA?=
 =?us-ascii?Q?hQdY1Gmqhc35oIugzMfcs21aZS5V49wCjKJjLmup4k1xrvmQQK9p19j0Az33?=
 =?us-ascii?Q?zsGQnsn16Jcf58jdcs8y4YjY1i34QJHYjffg+1sCKyFdkdQCP1ub14KKr3rm?=
 =?us-ascii?Q?TGpHUBy9vPnIbg8DlgmvtbabqoC5gNUwjY602LGEc85P+GdoHTJSBTXhBnGM?=
 =?us-ascii?Q?wa903WQiRGj9Fw9LvfhYJwnasGKfZQMGlwD9XI2oy/qyS8BVtETJ0kMDI1Yh?=
 =?us-ascii?Q?u5AdsLeN9JOB4+B2lyzUK0yIV5EybfLoUB6Vd+KXGqC3HuCNrJIKEtAJvmJx?=
 =?us-ascii?Q?7t/75nPl4sMxalBV/mlKnVTIC0iw57In0EvT60BGMtz2NXggIEYGGtiSqaf4?=
 =?us-ascii?Q?k04zxcmgxSi7U+DDzzsZLMMwEhL6kOZYkp2N2PRweBzrI0CNWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EMT/S7f7noPMSj2HBSUhruXuS0a/68zosTQJ9L4cduvEpq6Thlg5lHP8C5r0?=
 =?us-ascii?Q?Rx7BCwoXufl8XuVGvPrazpE3CiECsG9Ykng+4BatlPoct74Jgq4gnmhgnoMN?=
 =?us-ascii?Q?49VZLmPhzEhUuJ2V4gwuZnaCQJkeEQNrOxtI7X5yZobSpxMqxU59JOCXRgVm?=
 =?us-ascii?Q?xrTeDl43ZYGeg36pjE6k/7qwaYrhh/vUul75eOKfgMRI21X9g7SSu8jBRWVf?=
 =?us-ascii?Q?o2nR28vGqoPnNLa+IUeAyrOHNLCMnsmJtnzgJyK3bo5yIpLC9fipu9QK66fp?=
 =?us-ascii?Q?+FeLI9/7EIO19VN/Pww4PwYYCPFYkEe3T/6CLjTsWlq22np2IQGPvchmnNvb?=
 =?us-ascii?Q?omarbg7ikMOvVUJ/eOMiZI8CjTCywcBScPnB3Zq1TOkG1RmPTuVaDO9C1Faa?=
 =?us-ascii?Q?4gqgzZAVtn1R/oOSwOZFLRn29J5GfNEmjgYiq1tBzZhQYWWgccKxfALL+nhY?=
 =?us-ascii?Q?W7fYVIR6o/iiuNgrcxf4u1IUWhGGXEoo112jTKWrfSJh1H16XpiFFc6OlX2U?=
 =?us-ascii?Q?PV9h+5YVtv2GXx7nmqBlRkzRrV/WuBDXWjSffeHqhQUu5g2IBmWaS/CcIny2?=
 =?us-ascii?Q?0e4iuRQ6wQlQzPR9gc5W4paqicvfnR8A56Q2MD7dQP5WDLXo/WXPjk9XUDuC?=
 =?us-ascii?Q?Pgx53cJJWSasPvWbrlMYD0ESWnKf74xfqx8bNYVo4SYiJFkdi73enU2oUNhX?=
 =?us-ascii?Q?872iSTi63jMILiVkWH1bDhyn4G9kYusazVvv2J8Nz4JLwvDIbYSbcxt3D5WO?=
 =?us-ascii?Q?ITUBYTeXu6lTYMU42P9GJy4iHC7mqRYrVim1mkmOqSEZjzXrHVWW0v/pR0Ji?=
 =?us-ascii?Q?F0IDtzvPmMIwu8C8VFSKdDpsoKJdp3ruhsV93Rv8MHRHh/wNn58p4wvyQcrS?=
 =?us-ascii?Q?xlHX9VYBxFK3uvNe4uZZlxzRxd8p4ygjV53EEaU7YUUXiDM0IE2lRzm+dLPM?=
 =?us-ascii?Q?Eib8qjEBjxSKrSsL8wo4Uic+WVL3WrIGKgjLANoFCxa+IfC17BQebcYIzZ0K?=
 =?us-ascii?Q?+omqhXD4nnfTxa6r7PFGpIqka9BIO8iFmsMMW1RUF7f6ydbb1LCL+t7/8pIq?=
 =?us-ascii?Q?MLuBF9O8esKKsXIwcOnkTzE6sJF7HXEk/Erah9tKgD2pHrK9sx8dwUq0rAWO?=
 =?us-ascii?Q?Mu/ks1vC1dxHS3UdfGo73BY/rzwET68e6GG95hg+UjIo8777u3dtLuzFxupS?=
 =?us-ascii?Q?v3Cw/Ub7GWyNUvWuqMg4vMEnjpUZMQCEEpOa6X7AyXOl3OjLzLHcu8Qsddvt?=
 =?us-ascii?Q?0EwDyf+u8UHs3Hfhi3O3QfkyO7f90RPlAwjUxIw/cMM13LHjUM/DLyxBBcl/?=
 =?us-ascii?Q?Hgh5EDfY1A3l3kHaRy54VL3KLD4wg4aPaP32twdetIAWrnz1SXfhggYtEK+Y?=
 =?us-ascii?Q?v3F6my9iz2JqBzklnTLl4+3pmBPKHMT0y6qMFFQosbaHihrVeJ7UcILuQOK0?=
 =?us-ascii?Q?6h8/Sbr3TiN04ZjxT+XtUF8JA8Z2S/d3yfnUjJMgt5GWOeUIPQrsgaLO8cd/?=
 =?us-ascii?Q?F68VSSqz4HOz9q4xCikJHXcfZeirgWdKPbrI76cPbo67/gg/A7jbzPTih8WP?=
 =?us-ascii?Q?THEbjhBeRKXb/6319Ih+eURvh//3kEmzfErYTWzyQsqZY+B8rOM7K1RpZddI?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0de052b-da4c-44e6-4dae-08dcff1f42bd
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 11:28:11.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbAS4gyMesuOddkfb9YiwUzHrXWrmWJq3rywcfEHgg6moN0k28r2CMaXK9y1RQTpNjfmJ2VMgTQiHpLvPr7gMfT9wVekLPWIchw4gRTgQmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6667
X-Authority-Analysis: v=2.4 cv=H7mJwPYi c=1 sm=1 tr=0 ts=672ca44d cx=c_pps a=fpyyTn7Kx2iM0+fj1eipXw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10 a=8AirrxEcAAAA:8 a=t7CeM3EgAAAA:8 a=SQFjrBGcJuBdRaXFCRgA:9
 a=ST-jHhOKWsTCqRlWije3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: oD7TTzjQmnvctzWPuIeJsoMbXdh-kfgg
X-Proofpoint-GUID: oD7TTzjQmnvctzWPuIeJsoMbXdh-kfgg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_02,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411070089

During kdump, when the second kernel is started, the LDB parent
has already been switched and will not be switched again, so
there is no need to repeatedly disable PLL2_PFD2, PLL5, etc.
Repeatedly disabling PLL2_PFD2 causes the system to hang

LDB Clock Switch Procedure & i.MX6 Asynchronous Clock
Switching Guidelines[1]

[1]https://www.nxp.com/docs/en/engineering-bulletin/EB821.pdf

Fixes: 5d283b083800 ("clk: imx6: Fix procedure to switch the parent of LDB_DI_CLK")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/clk/imx/clk-imx6q.c | 84 ++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index bf4c1d9c9928..edbdaeea68b3 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -291,6 +291,42 @@ static void mmdc_ch1_reenable(void __iomem *ccm_base)
 	writel_relaxed(reg, ccm_base + CCM_CCSR);
 }
 
+#define CCM_ANALOG_PLL_VIDEO    0xa0
+#define CCM_ANALOG_PFD_480      0xf0
+#define CCM_ANALOG_PFD_528      0x100
+
+#define PLL_ENABLE              BIT(13)
+
+#define PFD0_CLKGATE            BIT(7)
+#define PFD1_CLKGATE            BIT(15)
+#define PFD2_CLKGATE            BIT(23)
+#define PFD3_CLKGATE            BIT(31)
+
+static void disable_anatop_clocks(void __iomem *anatop_base)
+{
+	unsigned int reg;
+
+	/* Make sure PLL2 PFDs 0-2 are gated */
+	reg = readl_relaxed(anatop_base + CCM_ANALOG_PFD_528);
+	/* Cannot gate PFD2 if pll2_pfd2_396m is the parent of MMDC clock */
+	if (clk_get_parent(hws[IMX6QDL_CLK_PERIPH_PRE]->clk) ==
+	   hws[IMX6QDL_CLK_PLL2_PFD2_396M]->clk)
+		reg |= PFD0_CLKGATE | PFD1_CLKGATE;
+	else
+		reg |= PFD0_CLKGATE | PFD1_CLKGATE | PFD2_CLKGATE;
+	writel_relaxed(reg, anatop_base + CCM_ANALOG_PFD_528);
+
+	/* Make sure PLL3 PFDs 0-3 are gated */
+	reg = readl_relaxed(anatop_base + CCM_ANALOG_PFD_480);
+	reg |= PFD0_CLKGATE | PFD1_CLKGATE | PFD2_CLKGATE | PFD3_CLKGATE;
+	writel_relaxed(reg, anatop_base + CCM_ANALOG_PFD_480);
+
+	/* Make sure PLL5 is disabled */
+	reg = readl_relaxed(anatop_base + CCM_ANALOG_PLL_VIDEO);
+	reg &= ~PLL_ENABLE;
+	writel_relaxed(reg, anatop_base + CCM_ANALOG_PLL_VIDEO);
+}
+
 /*
  * We have to follow a strict procedure when changing the LDB clock source,
  * otherwise we risk introducing a glitch that can lock up the LDB divider.
@@ -320,7 +356,7 @@ static void mmdc_ch1_reenable(void __iomem *ccm_base)
  * switches the parent to the bottom mux first and then manipulates the top
  * mux to ensure that no glitch will enter the divider.
  */
-static void init_ldb_clks(struct device_node *np, void __iomem *ccm_base)
+static void init_ldb_clks(struct device_node *np, void __iomem *ccm_base, void __iomem *anatop_base)
 {
 	unsigned int reg;
 	unsigned int sel[2][4];
@@ -368,6 +404,10 @@ static void init_ldb_clks(struct device_node *np, void __iomem *ccm_base)
 	if (sel[0][0] == sel[0][3] && sel[1][0] == sel[1][3])
 		return;
 
+	disable_anatop_clocks(anatop_base);
+
+	imx_mmdc_mask_handshake(ccm_base, 1);
+
 	mmdc_ch1_disable(ccm_base);
 
 	for (i = 1; i < 4; i++) {
@@ -382,42 +422,6 @@ static void init_ldb_clks(struct device_node *np, void __iomem *ccm_base)
 	mmdc_ch1_reenable(ccm_base);
 }
 
-#define CCM_ANALOG_PLL_VIDEO	0xa0
-#define CCM_ANALOG_PFD_480	0xf0
-#define CCM_ANALOG_PFD_528	0x100
-
-#define PLL_ENABLE		BIT(13)
-
-#define PFD0_CLKGATE		BIT(7)
-#define PFD1_CLKGATE		BIT(15)
-#define PFD2_CLKGATE		BIT(23)
-#define PFD3_CLKGATE		BIT(31)
-
-static void disable_anatop_clocks(void __iomem *anatop_base)
-{
-	unsigned int reg;
-
-	/* Make sure PLL2 PFDs 0-2 are gated */
-	reg = readl_relaxed(anatop_base + CCM_ANALOG_PFD_528);
-	/* Cannot gate PFD2 if pll2_pfd2_396m is the parent of MMDC clock */
-	if (clk_get_parent(hws[IMX6QDL_CLK_PERIPH_PRE]->clk) ==
-	    hws[IMX6QDL_CLK_PLL2_PFD2_396M]->clk)
-		reg |= PFD0_CLKGATE | PFD1_CLKGATE;
-	else
-		reg |= PFD0_CLKGATE | PFD1_CLKGATE | PFD2_CLKGATE;
-	writel_relaxed(reg, anatop_base + CCM_ANALOG_PFD_528);
-
-	/* Make sure PLL3 PFDs 0-3 are gated */
-	reg = readl_relaxed(anatop_base + CCM_ANALOG_PFD_480);
-	reg |= PFD0_CLKGATE | PFD1_CLKGATE | PFD2_CLKGATE | PFD3_CLKGATE;
-	writel_relaxed(reg, anatop_base + CCM_ANALOG_PFD_480);
-
-	/* Make sure PLL5 is disabled */
-	reg = readl_relaxed(anatop_base + CCM_ANALOG_PLL_VIDEO);
-	reg &= ~PLL_ENABLE;
-	writel_relaxed(reg, anatop_base + CCM_ANALOG_PLL_VIDEO);
-}
-
 static struct clk_hw * __init imx6q_obtain_fixed_clk_hw(struct device_node *np,
 							const char *name,
 							unsigned long rate)
@@ -641,10 +645,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	hws[IMX6QDL_CLK_IPU1_SEL]         = imx_clk_hw_mux("ipu1_sel",         base + 0x3c, 9,  2, ipu_sels,          ARRAY_SIZE(ipu_sels));
 	hws[IMX6QDL_CLK_IPU2_SEL]         = imx_clk_hw_mux("ipu2_sel",         base + 0x3c, 14, 2, ipu_sels,          ARRAY_SIZE(ipu_sels));
 
-	disable_anatop_clocks(anatop_base);
-
-	imx_mmdc_mask_handshake(base, 1);
-
 	if (clk_on_imx6qp()) {
 		hws[IMX6QDL_CLK_LDB_DI0_SEL]      = imx_clk_hw_mux_flags("ldb_di0_sel", base + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_PARENT);
 		hws[IMX6QDL_CLK_LDB_DI1_SEL]      = imx_clk_hw_mux_flags("ldb_di1_sel", base + 0x2c, 12, 3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels), CLK_SET_RATE_PARENT);
@@ -654,7 +654,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		 * bug. Set the muxes to the requested values before registering the
 		 * ldb_di_sel clocks.
 		 */
-		init_ldb_clks(np, base);
+		init_ldb_clks(np, base, anatop_base);
 
 		hws[IMX6QDL_CLK_LDB_DI0_SEL]      = imx_clk_hw_mux_ldb("ldb_di0_sel", base + 0x2c, 9,  3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels));
 		hws[IMX6QDL_CLK_LDB_DI1_SEL]      = imx_clk_hw_mux_ldb("ldb_di1_sel", base + 0x2c, 12, 3, ldb_di_sels,      ARRAY_SIZE(ldb_di_sels));
-- 
2.25.1


