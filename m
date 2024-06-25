Return-Path: <linux-kernel+bounces-228174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D39E915BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9DAFB21F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3901CABB;
	Tue, 25 Jun 2024 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mc+J1lTx"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24B225D6;
	Tue, 25 Jun 2024 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719280203; cv=fail; b=dhMqd/0my3vwhFvFRFFY3UNbYW6BfaxklHGcsHFbvTPt4rkq0thEolUXtkTcqAwghqH5apS37hmKVhd+me34dHix244f+G7Zdhp5BUft5ZFxlg22gG6j2TieIyvUHzy0ptToCGvO6im9uAxYGJlPCz/a1UEyJ4ZIBGXaNpTeFN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719280203; c=relaxed/simple;
	bh=qTyMefYJXszfwIUpQwTxNiKZxnovMINP79xeC/7lN8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=buqCQG7lXuVWaf/GKIKM98BqZ2m57/oCKyA3G7h1IiJggsAB0YA0GAhEkSnEwNPs3KQdWV2X/Wt2PRFzBRTpX73Ls0q6N3M/ZwobxGvyniaAAvo1TXZ++/df5O3HGp6y2KU/XSLJpaItDjUIvKD0HoRm/F2Vp4iZ9NRuSmtXBJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mc+J1lTx; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3cLEnW4yNF8MMbqehHKAiOj5oMnvq7xNWw0B2/R6tsO+2yn5pBPgiez+Ilxvz9c2irAL9QNgLjfxuX2LoMGNbu2kEOGBIirsW5s31NShdc+0D+HR0p/f8pzIJrdYCce6jWngWxS472MhItXw2+8G8JdqmC8tC6y/SNwwjAsBimPEgfBmK2aY31/0xTfZShFc71RrGhmc2KiWBGeK/tqAOli+XyXxuzzib6X2ENDi8Yaf3X1r6vsBpsPuW48qXhUGtH2uRxT3LguO68oOGEaLgUS9/ou60WBUnnsxullIfUDnT51U8yEfuzeauxgMtAHliinKJPKXnj3xC1FY8GJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zIp42QvXoEJuJq84cn76qPLWWzHapuOluPjJBgEpLw=;
 b=Rc/fklMxGF4BLGNlPvNf1wnqqyPmbTLKDfoTTuCud4eks2+1A70g4glOnuCwiRb+lqAXnJ6XTzv26ZjVHC48075SvjkcN8BYEAHlgT0mlkuCewtEqHFK8Uxz6e1WHeoEeoazdaCUsdKOObqywFldqOcIEaCiSCDwj3ug0B0gf+9iOZg6ktglpucuUKQFjhyeXVIQbUivnemw83Qy9a4mCAlnTcuz5fqkzQ9/IRLTTiMQzwWUxn5Un+gvLvcJ+28tlfyIy7xlfBXi7dlefkiT4Nlv9GoFPxQLhLINk46BvMQkh+fK4lMjPTEDFh80EwT+qTYTHjG3Mgw0hHq92MjaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zIp42QvXoEJuJq84cn76qPLWWzHapuOluPjJBgEpLw=;
 b=Mc+J1lTxxxYFucp5ZwnEPBYi3DsSm8yLe+elaYD6JmmFVKmXjTaB0AxIoxaYhST2Lg0KNtUsSjOafpULdAsKYUEl3J9PJV5KG5UZ8uk/lLdfU6pc9hKUy66ZoNz7qC+FyTlIId+rEwzCCjQtdHu/KNTNEDfPMyUzNCNROsg2YsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 01:49:58 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 01:49:58 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] clk: imx93: Drop macro IMX93_CLK_END
Date: Tue, 25 Jun 2024 10:51:45 -0700
Message-Id: <20240625175147.94985-1-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::22) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: e63b8174-38fe-45c6-093b-08dc94b91e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|52116011|366013|1800799021|921017|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oLD3YKQLS0EwP6CcN19fowa1M/MLOnss23oIJE36bBEOl6cxJzGpLhSD6MGH?=
 =?us-ascii?Q?khOB2LGZRIcmc++1wm4G3051C5V0k3t0BCUoVWK+h3/O/yWqbo1lSsyKbiP1?=
 =?us-ascii?Q?dKYHTPXKnQW3dxnHu6zdtMerXxkEPdCUTqt+/lr2YYiFH9pi6RlSyTv4r4+T?=
 =?us-ascii?Q?NTa0oJJDCAHt49RQ+wPvBAaArLTXoNnyne7G5IyZcAjy2Et8JvHSxu3mjNLD?=
 =?us-ascii?Q?+3VsX0fQh2SgTG1BDaoqurkuNg9mdi5DD4L33C5zG2tJM5jwf1tcyj0IGMXJ?=
 =?us-ascii?Q?/q3PiN+LKVACwcYHLoKmPxXCKYmUWZPts5VdTVkAlrM5ytZ/8sV5P4rmpOkJ?=
 =?us-ascii?Q?6YFODqDtGIMao/3jVrIxh2gLu1PRUvbupn/R+agc1jRLP8Y8idPAtUZL72xJ?=
 =?us-ascii?Q?llQDf8B5GoTdRTh/fsC0+9DZMigtMFSan8PlXMLxrpTbkpJ8HgtIpiH7cKpb?=
 =?us-ascii?Q?/a6V4hYMabjuqXtG7fvCYgsedxTQHcfuRpThjwXSpVvD8z7H3X4gPvbfkWj4?=
 =?us-ascii?Q?AiXJ+o9TKVGKf3Oz5/t7xXbQbqZys2oW2R4o0HPQ8CoFO43ySXlfpeMeRzcj?=
 =?us-ascii?Q?fjlWrJUaD9AxmbuWLKTeBzpNdJVqFTA7AkqYc1WgbMQ8woHy7pDG51gtjUPM?=
 =?us-ascii?Q?ljSe5hHp6bQ5jrIBOBh501j2H11nJYQZxhC7IcSmE35hNDMsJi9Jn6fP3Pz3?=
 =?us-ascii?Q?f6GjNTiw7xi87ST6sPbuej6BwLz5mAboXvvqO/P+h+RTAl2RT33GEfFhe82Y?=
 =?us-ascii?Q?Pugm8lww/qVCpXD7uoWfmYDw/bShoHodXH9E5V5WJmML3foc6q/aC21uZbqW?=
 =?us-ascii?Q?9CJbq05yrftr8C2JbDhhYZDQWni7omLFZ6m1ZmkyEfZdO4NvOyLrwkjKzxro?=
 =?us-ascii?Q?Aa1YBfAkTvZbaxdQ+ztgW3sL6/j4ppWtvPCZfqKSt6QW93+B2VH4Yg+6YAgj?=
 =?us-ascii?Q?MmN6uxKKiYTfVSD61NmsBZcuwLLUj02UpYkDSvfyHLjX+AF6v/qmX+Mv9Tek?=
 =?us-ascii?Q?ZYxMiM3XWl0cnz95FFaxiGCRnzN7Q9yIk4dhHH65D6nx8QZroxEN7KTtqilK?=
 =?us-ascii?Q?zbUx3XvDZAAQnGbbvKE3mOsIUm1mTxDUxHYCTzRNtkSg16xK15QpotX75VnK?=
 =?us-ascii?Q?kuefoF+JPHK7s7IH0VekQ3kDRCywGFnRG1YIp5ESI4alFpcw6uaJ3PLxCVdd?=
 =?us-ascii?Q?YA1Kz9B4NSh2wUNycCuF10mUznjbOcmrLEnK5q1ycikfBd3Z90cdXt3D76hJ?=
 =?us-ascii?Q?9+57IcilHCzfXzyfGjyHTsP8Z9fJ87M8gCeThpErJ5+rQ7+BQ5A1hlB0SdR7?=
 =?us-ascii?Q?QyFrJinMPRIBLwOlD7U3fZ7ZT3v9nqBo39N05gddTgKzRAybRqnaZYH5TGss?=
 =?us-ascii?Q?vrExMpQWenmR0YaQgFrpMw/2OLOj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(52116011)(366013)(1800799021)(921017)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w8Qpw7a0DobLYIg54c2pjpmjP8Z6Wr6P4m0gZKejB+g62umT8EF+whKKR/na?=
 =?us-ascii?Q?NMLlu1cCttNe90v5Zdeh7kKJJx5/CpxlRTccTcwe/4APcIUItzHHl7fUBvWc?=
 =?us-ascii?Q?QK59IzYps5uiNc4o2wyfHQ0Vqvf0tXSr2GzBgMTwNVtTSQ6MHOUqRDrkoR6P?=
 =?us-ascii?Q?SuUoRQDOenJxxL/fn48LtRuRtD7Re05fz0rIJ3MPhgdDU04tyRJZtuwAoR4/?=
 =?us-ascii?Q?He3OVh99p1RSUpT2LUfoLH0mN+Blhr9Z1ULsvs9CAHKcXaWvQn72Nf7cp0pk?=
 =?us-ascii?Q?MrmEwTdeDguG/ga2FyvR8BAOcOxEN1rx5I8QTTYTYQJoPP8o2G+U5v1cSAe9?=
 =?us-ascii?Q?9sSfUxdrXODO9beDmpZw5gXDubLEaYKB8o+jppTkuqcqFSYrfAS9GbxhaILb?=
 =?us-ascii?Q?3iLzH9dg0nIAIQfZj+hEralThdLctkqK21ardhy8POgT6eFW5mFYc/MSPHnb?=
 =?us-ascii?Q?9cSikWgYqsna+9FFqO59z91jrfWD7XPLXbtBW/DvMGsYy+HtqjMfM4c8N0Xv?=
 =?us-ascii?Q?6cdVwijLQhKIbxP6BR62fMUIieRzQ3as1tZcf2M1R4vbpmLdV/bYxtAdm/Jt?=
 =?us-ascii?Q?gVxFiRKhtWcASicYIiuBLnUK6AJTiFRwl+yuVcWs6qGNj7hk+y2EjDBt2QR5?=
 =?us-ascii?Q?GKTj2muaLZGCTQENytPir9OaQXTrqLA0t3lNalTG7WF3/8vo2alAYapYgChP?=
 =?us-ascii?Q?gTSnk0VkF0iaFuzOc/aXubPzg1Zz5mszAbQ7cwdK+0D4+CZtCqFckYWvxrTD?=
 =?us-ascii?Q?fuZHf1yyrtUtvF42AXH0kNa5WRAYkhfIoIfoqjvW/mO59ockEuMAmR2LLL3z?=
 =?us-ascii?Q?mi4L5rvC5P6mn2b/IapyrTbh+9TK/lZSkZSEoknby2iJb2t6KV5lEYIdsV7p?=
 =?us-ascii?Q?hq2H64kNjefhySSFMCsVcNHA+iDo7M8X45p8hfEdGs5ybriesT6shNodsB9V?=
 =?us-ascii?Q?9+HOMLtkoqOdW8lB7mEpluKyosqjNpzxCH0aN4Y0znSd5tqGL/yKDhHuVo/A?=
 =?us-ascii?Q?jtApgqhLcNvGSnkpxiu7pmRBkbbBSwH5YuU4+Bno7hmgjg7ouchUNMoUDr1O?=
 =?us-ascii?Q?+B4eT7ikCrv4EWqlkqo51OKaeHTriEYw7LizwWNxYS98okjKxQ+D6suLE/VZ?=
 =?us-ascii?Q?sIYujCdPnowV7LXehvJc9R5Vx43JVNqq48WgsQkTjGPsHA2rJmyx+LKQzzgJ?=
 =?us-ascii?Q?MnerncJ7HJhPXapvst5Nzyz/SYhZf1PCekVhqfcHPIIY5J+6ByNljiSPQNjs?=
 =?us-ascii?Q?RWM/mkZFqW1rAGjsWs7Q2tgSbYo2YdHyfBVQ07v5vdSpkN+9EVkOpPMaag1e?=
 =?us-ascii?Q?mUCRFZdsr6YkPnY0+I5HXznw/Y1MPUb3ziJdYGVNN2vQb9/qd0w7Jjo0wyJd?=
 =?us-ascii?Q?+Pz17rq9WPo7JYLFvSantejUod9uOxszMgDvYWKOLHyU5EvWBz+Uho6H/m0s?=
 =?us-ascii?Q?q+4TyuwUtOHpHOygUuKHMli31+Z/Jczo7Qu+smmqrKY6Iofn2V5GBamB6KnA?=
 =?us-ascii?Q?GySr1HDgWv7Q5Oqf5ONY+klox6vqoFN5ndEoRhOqahw4f59zpEbEG9wsksWK?=
 =?us-ascii?Q?sSUZzUFcF3387DrHjzghtI6ypSJdSCM3jzu3RT7C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63b8174-38fe-45c6-093b-08dc94b91e16
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 01:49:58.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwQ/1RbuvrqpfZfP0KJkr5e3VGT/ZhU79CtjnSgNoMKGhq11FxhipSrIF1h5QUlEJbQQBXcaiGS7eVdiDHw8aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965

'IMX93_CLK_END' macro was previously defined in imx93-clock.h to
indicate the number of clocks, but it is not part of the ABI, so
it should be dropped.

Pengfei Li (2):
  clk: imx93: Drop macro IMX93_CLK_END
  dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition

 drivers/clk/imx/clk-imx93.c             | 25 +++++++++++++++++++++----
 include/dt-bindings/clock/imx93-clock.h |  1 -
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.34.1


