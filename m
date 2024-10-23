Return-Path: <linux-kernel+bounces-377237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098D59ABBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C082848EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135DB81749;
	Wed, 23 Oct 2024 02:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CRFBsOm9"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2042.outbound.protection.outlook.com [40.107.103.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2BF12C475;
	Wed, 23 Oct 2024 02:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651646; cv=fail; b=MdMZVeYPfN4y/Bx3umcpOyER2mn4z5LgfK+kTKi9aaJH4OEdBgF/25oZN+R/d027lGNGBXeUrO6MqtFuSZ1rWPITQp44sLja6b8PuLdMK3Jb+QzSEaEL4U34wU6dv9SIpKt1Osf1ujEfH0QQOa1yUlKSHMM0nTXjmWIf4c54iUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651646; c=relaxed/simple;
	bh=wTkA3ngYBhMsulTRh/8lBQFKmSkAkOePEg2Kmiq1HAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gJMldaP2gTpUg1nMFjMtuHyBboeJxv0OLmwfL9819nWCtXg+x0aEJtLMm24WtF3WH4LnN6KxHif6e3F4b7Yu3wJTQNOGy7ohjRQTRcWbWdiFGuTMAZ8sUgWYVGl1ABb2O/9xwI4TuseqQ4QB3pPz3YPKXsstQ7aJBzjFCGnP0nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CRFBsOm9; arc=fail smtp.client-ip=40.107.103.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs1IqIahjEh3fd5GjgkKtZTySTMLbl+8Z9P8a7rurX2y8pA3oAWpDbA4lJZ/JFRZOJSAVBoSENP7ZB5aHD5l0ucL8mZQ0ZbuqhjqhqFqFSYs2jBo4yiHOKRck323+VfUyH7dVBsB1/WtC5K9rVGVmvXmXPZ1lSFQ+z4NzS7sYqPx/UOQw603eQrbcQow85I2Y3uBVp8ru6QIBc9zRLRq3EFDGytgbIdLNL6SmTeSAqeYjABy61E/dr/pFyIjTA5nroZQsQO48Vhw8yZ7YEO9tyXdJoKUIbscTyuoMFbNla0aTTAZkX+eTbRiRUiyFJqeRPwr4/+YiMsJ7mRuAq8Q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MJPG4jjD/tGPJ2fbTa4lfbpamOfTzslr5V3dRrJePs=;
 b=uiIrZiHMtqkjFGm+GB0wrsjzJaR6Q0LjI4c/ORcGc9o4km0UduW/UZqPtZLG7A5pBlrx8J+/1cE3uoDK5y08FSQie2VVChxTNB60rrz9w8AwTJmUrN6CM3PsOOlgqc+5kpQaafHgIrZi4Jl1cM++Welk4cgxVVtleHw4+pGtIXdRHMbR2pRkN9kV0sbiYSCLK6StLwg5+cwekqaSJlmUrGqA8z0ao5HFHrrBc6NuWERr4qUeYDH46XTKGJkIk45ZnwHLk2il46Kgk+bZzK5BSNHYMvF1qvVKqD/MxfXzqiqxIgxV5oVMwAiuWO1gk/M9cy0LtTAHdfzXzcgdXpwGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MJPG4jjD/tGPJ2fbTa4lfbpamOfTzslr5V3dRrJePs=;
 b=CRFBsOm9HbdyeYvjx1FkXMlGsRlFffvFwe4CsiLDef0kJeXAqxvzSER6M1/rzPWavzAB3HpUNiBzaiSCau1Ci6mFoakiqV/hobI04GZxNPJqNDHiDroNRZLi6ejfjYdxXs1VoRNbPqCrVG32EaRb+IoHp7f2lrd+xq2TRu1eNDhSDOQ6WuIqXcQnAwE82lmDb601k7TbDdHJoeZRzIVcdryKvvT5zPkgrz/9xVNkXGq3ZsmWKznDF/jyeH3usC43QKNsTmi6n9P4XEzlqvcW6Iw34jlYZ+ESCBztGhfYeijxjbgXYP7ZCTnfA2j+l6iRIwlra+uoZRUCSmqEZPuVvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 23 Oct
 2024 02:47:21 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 02:47:21 +0000
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
Subject: [PATCH v6 1/4] clk: imx93: Move IMX93_CLK_END macro to clk driver
Date: Wed, 23 Oct 2024 11:46:47 -0700
Message-Id: <20241023184651.381265-2-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023184651.381265-1-pengfei.li_1@nxp.com>
References: <20241023184651.381265-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|GV1PR04MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 35479956-c7c5-4f37-aadf-08dcf30d0416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fi7AHDAuX/0LQi5zCyZMv2yCCJuq1LIAb1epnkkQwnyu9C4kSnusqIGDmRmM?=
 =?us-ascii?Q?5YITAKTZJF51DdPEMR3q5fgmGxAvP3tnMU0/qtd4pAy9rve/BEMTX7EoXCNP?=
 =?us-ascii?Q?B3MIxcngbWufIvjyK/065ZVIif85G85UFoqLr5XjJV0NjzQ8Wo4lzKmLeKQg?=
 =?us-ascii?Q?11Ko1bwuE3ItMz2DSosSYMiOkgs5bEB4kJAezY5ecVGcTXRwpe7dAQjEQ6u9?=
 =?us-ascii?Q?jq2PPH3fy0njEVjRo0ynhz+lTOerBQtFo/IsRpCPoIz1TeKZfc/cAVjFGU55?=
 =?us-ascii?Q?RliTrOG5u9rWzBfrQz/TlcaelLEiGIPepHk5mFpFB9njP/TEDd/fCG0pWtp+?=
 =?us-ascii?Q?FvYUARIxOCO12YICrk45+jmPKQhMiJ1OiNFe74o6WUvZATXVUpoByz+xxMlh?=
 =?us-ascii?Q?naJaTcibo0SJF9JukFWDQ9VrBM43EdHTvXkDO+KkidZ4YrRwfLfLu3dKhj48?=
 =?us-ascii?Q?P34TZB3rVnKrfPhmW0C2L15hTenwRt+eqljfeVZM0b/pYZp1ecpa+f/68hes?=
 =?us-ascii?Q?tgjVNG3nH8rN1aDg0COHIlJQ+ihu+ffnHVzPp6zyUeP6Jyv9TisxkSKSZ06M?=
 =?us-ascii?Q?Ijc4fgLqkeDDctH23z7zHn/zV3D/+qapd/hhow0FfFj+t/wVTR0cspFRDLEz?=
 =?us-ascii?Q?rNsKMBIGd/zq+r9a4kqanaQmmLoXidq1yOkHu3pLARjGzQMiKMX+IrCls3Mx?=
 =?us-ascii?Q?gfxnkgmJPlovW6dt/1fh5gfF4DbrM/vb3WAzgzYpx3J1ZNFI1VR5l685H/mx?=
 =?us-ascii?Q?9yYiccYSPaJMVS7Lrt+AvBzXwHJyBcKHuAXXRMQ1UvPL2QnYO9e4s6FwIKiK?=
 =?us-ascii?Q?5sm8onoMThr4XuG5odTQ8aV4FeBTVZMJuqZIfJHAoAvOhjcjkCqR5q5ps+Rf?=
 =?us-ascii?Q?wr5maLnIhoJbWRP+sNfwBiKFNluMlCc4syY8vCnzp9i8cjpFxUhhQghKpOKH?=
 =?us-ascii?Q?JewXMkN0IKwaIhTepvL7dbBpC40/lzAHCVtpFZ/Y84VObk/Ok9GyloHM/kNX?=
 =?us-ascii?Q?2stgBO+Sx8OSW+5SCxU1gke08Q5iOQZYXFN1aEr1ySfEQmEFbB+Yw1X5u6lC?=
 =?us-ascii?Q?u1gJN+UpvvuDxinPuevzVn2NWTH6HXlP5cFDjQnhJrXE0rhlu1Eg2D7oOnRw?=
 =?us-ascii?Q?5RvVBostZzTbq83Moff682vvS2ekFawxvYK6HK4NPV3LJuzGc9npjK4t5EYG?=
 =?us-ascii?Q?XlDkAIEnN7QuhIVNZ3pHvRc5QIKnKhdhE59+txhBKr4E5fDhC4qhh4mU4Lxf?=
 =?us-ascii?Q?fNci8YdD+vv8fDTqcHEcZYH6zxtvBGVGhYvNyWB9yK0XzI2GfGeFqyhA2tzE?=
 =?us-ascii?Q?7arVEUZtB+ScVT6NnI30NQ1DolNgkFW1FY9NCEgJNs+dck080I7NIltfGdO2?=
 =?us-ascii?Q?gsr4Iu0nqOmtLK4ZZef5XLFX/u6g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/lAxsReEcHr4FOGMpGw4Qf2p5+gn+ICeJFf1Z5ubb2jn9iiLbTIv4D2jbpnl?=
 =?us-ascii?Q?NIhqtRGcaOLaqNiv98HKq40O8LbmNmNVLI9Pw4DiZOUShm/gDIcA/l+sDCGD?=
 =?us-ascii?Q?IOqGUQg2RKzvXoGzPJuq+w9rp1ataw7Np3TLHny/wiy0yEyb+CurQ7mVDzIJ?=
 =?us-ascii?Q?+kXj5BCpl5KEZ0NBp3sCxEArt4+O4XVm7yztbKGg6G/wZtQqn/fV45R2bTZ3?=
 =?us-ascii?Q?M/nmNKxBeCqDqY6PRnA9kqDHo0kQo9IGYLB46QlWKoQ2V/LhE5aYC16GTDSL?=
 =?us-ascii?Q?k97wUcKFy0+LXxq7nnVCIWaFjH3j/5dGtCC+ivHdYKYkqTaJ+OJvUa1ZXfcE?=
 =?us-ascii?Q?+sa4jnXIJhfWjQBBYa21qvdcC0mAjlOoFud8YeMkV62WhiTvVEQRC7m6wX6P?=
 =?us-ascii?Q?BrnbG6hyCfEZO3P8JdOItDrXxVuUkNDgETC9Zz5O2Iffn0nc5jRQnFF5vQX0?=
 =?us-ascii?Q?nKLEkWD97vr1AoqLy1NCD2qmkPpU6O+gg0FDRLNYFBhf4KAtazSdpcr3pWPn?=
 =?us-ascii?Q?TlPCRZfLwLhb2xEVgwqkbsa7NLYoWZuMRaIR7cRxti/RHvaGopqU49wgzSOg?=
 =?us-ascii?Q?DxvCB8lkTGdog7VmQzCgl2Gcx3OjM4FkVU2mw34s0FRo5URtHN54Ij2m38Mk?=
 =?us-ascii?Q?QAZJu1BZWj7Xwoyb86sfNy/Npd1sX4NiOapM0tURbEr5iP/PFhJWUcKpJNtX?=
 =?us-ascii?Q?i+2ynGkCPdrx+UQ9THjpH/txHMi07MuJQ7asQieAtjruKq3N+/AXVQDB3sF4?=
 =?us-ascii?Q?Z69q1K52anRUIzTCiyq1+XGjz2uQnS2cEfvQgxefPYlRDTWPZZJahhQi7WRW?=
 =?us-ascii?Q?y0pSSZOTIbCbvu3bbfAyvXP2lTP0wI9vBHgDaXHZxoOSqb6vmO9gUBZpp45G?=
 =?us-ascii?Q?sBYxG31Mtpuj3cT0yGE5L6vYvI6w/KymV6tZuP8NLYaXTky30lbEfVtBIdBA?=
 =?us-ascii?Q?duhu5jLKovqXgWK1Z+jk16KWylanVheFbeTJbwl8g/jGSOkerrkQGnT8Om37?=
 =?us-ascii?Q?Bwb4S53EK2EnJ7mXb8hBbF21sOn2r6YkGB6fg/St3b0IRzS2VL765MrvAzRn?=
 =?us-ascii?Q?hU+W2Gro8kEAMaNkEqmfvymJ0430FJ+NZ9VXLwBWMz899ypxEUPdj7OUEn/y?=
 =?us-ascii?Q?/uwb1AXg5xGaJQePBK90LRT6IzylIGZasTQT50IwBV7sBWV+OhyYJjNrwxTK?=
 =?us-ascii?Q?lcJDkL+15DHTI3p087T7SLKa5J97FIgqCc6RIOItmt8xu8k4pt9tNS50l6hG?=
 =?us-ascii?Q?vT21AwAe7HcQO/QZnNzVaNPZBhgFYiGuQj78S9c49cnFUPycbLWKiuUGQ9y0?=
 =?us-ascii?Q?adI2O5/sR0QEAMvIfR9MeywrjE+aGp/SNC8JZwyU7LszW2R+ZinHcy1q3WV9?=
 =?us-ascii?Q?pazpzEKxX3lPagNLPPljuCqXmJHH7jKtsn/h/7ajvZC+JkheWE8wjlQaCcxK?=
 =?us-ascii?Q?A41xNNv3BB3IK35vO+bHdvi4tCLRrR/bW4x62WBTn1ZPYBaVrKKrA9UyhGE6?=
 =?us-ascii?Q?EazWTa8nF2qQBMI10bgaxTLZFwrFoKSyRMys6AyUpUznGcbP2sf+oysxCWR/?=
 =?us-ascii?Q?Hx+9DZ0Fz7WDF13Q1pW88JKKVOrUtQMWZ5UhPs/B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35479956-c7c5-4f37-aadf-08dcf30d0416
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:47:21.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aq9qfIzRY3hvj9JVYYrCc/Ew+6XiRsSyxfpjt6S1Xr4ic9R+IDJxXmXmPkXEqBrkNvJlT6lm5kl9fCm5pL+6ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216

IMX93_CLK_END was previously defined in imx93-clock.h to indicate
the number of clocks. However, it is not part of the ABI. For starters
it does no really appear in DTS. But what's more important - new clocks
are described later, which contradicts this define in binding header.
So move this macro to clock driver.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/imx/clk-imx93.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index c6a9bc8ecc1f..c8b65146e76e 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -15,6 +15,8 @@
 
 #include "clk.h"
 
+#define IMX93_CLK_END 202
+
 enum clk_sel {
 	LOW_SPEED_IO_SEL,
 	NON_IO_SEL,
-- 
2.34.1


