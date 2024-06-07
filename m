Return-Path: <linux-kernel+bounces-206140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2B89004C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7CBB272B4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBC31990C7;
	Fri,  7 Jun 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gktwym57"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE5E198A02;
	Fri,  7 Jun 2024 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766716; cv=fail; b=gLR1ySrizYjonUJlUZ7HmHsZrqwPQ5wpDf/0q93+tz5cVWXwcVOdEuxd2gnDB0fuTAHMpwu5esvs2MMIJuGx1H4EANH4asUJJzQgz+bbsWsiWpDPbmpVnQB6xYQAehnu3v6vloQoDQhF8z7BpF4sar2IZvZZecjBGh2CS84v6nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766716; c=relaxed/simple;
	bh=a+I5O2q8fcbRhig/D91w8wW/uG5rhHbizJomnQzb6DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XjlUSmtuZrw9GNCioaFNWDGcjGDJKE8lq2/fQVGyz2gdx3JtpjMo8EJ+mzaMIhvyW4iEmYOthz3w5VdpGmPi/qgGQOo5xdNhtOKHJ3PQnQ8ShNjVmb+pS9qajdSK8KALS+xoRxD2MIK42hluyolvczDTj3ydewzxAAFeYqABU2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gktwym57; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/s+JUOemzFcrEkO4+Mwbg75UZ4QZH/QF/GO10pOYQbe5fvCliaks/0/nSkPIH8QlRApp1uMs08D1nilspgSzmAi9WXy3n9ZdvXYElFV4tMZNuE7X6sCeXy8Dh4T2IXEhHdT/ingEiJcBb05YPUV3flAyiHoU1HMVNtarLZh4DCrbsHN94vhF9/aaCoqVXka33r73HsUnZVDhABuru9JXQ2L8k6bEiIoQK5IAkW7Xmyzxh0Hls5fVnk9vQhWBmeF/k34PQtESUVFV7/Z9S/e8jEvQWnIssm2NUwtf1dK0zL/RPtxFVlhxGeRmIzlqNnqs0VrfKbu8+aL23RoLr+o2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcoNZOkkPiwAXnb3hZRkHB9HaNK6lpx/9PQmO8/T27s=;
 b=RboD1jdictKo5G1lnAcK09nPZnPoWYy/KmqBIkxsUvtZQgl5cCl1r9cJxM9vd8KT8bJiFSV/nIoh5Qq+571V2A7rgaaTT6PHJGHZ1PNjT7JutfHc/emBgrFu1/cRP+a+ZSE4QgZicPXzMNwsJGACi2mKdrssIfGjtHk+qBrHr5kkQlKvWXw049R+yDLNtsDmdQQekO3B2bLIwGPIknQOcblfjUqa/wbrBAKIO8WaEJOiNm8QCnygWF3QpR6Kg51YDwVHwo2cJ5ea4FyvMrurXshq/81Ipaa0GrVLe5JHpOs75wpBlyOLVN6CJxII1EvIISMZDDPsok619T91N+DSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcoNZOkkPiwAXnb3hZRkHB9HaNK6lpx/9PQmO8/T27s=;
 b=gktwym57ku0fep887n6FtvW9CAO0pYf2wz15Azb0uNJHC25MyiR4UsdclxN885qsMkaZkN6oYHrCgohkHG9vUMbFciLdwwm+dKalV2Xn0FCZYnCSY9xgbyo/4Mf+6TajXtb4OKm1HkziUFeWwk+k5HIismuEWGeTKkNEdQ2pCPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8944.eurprd04.prod.outlook.com (2603:10a6:102:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 13:25:11 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:25:11 +0000
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
	Jacky Bai <ping.bai@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH V3 02/15] clk: imx: composite-93: keep root clock on when mcore enabled
Date: Fri,  7 Jun 2024 21:33:34 +0800
Message-Id: <20240607133347.3291040-3-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PAXPR04MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: f23d632d-46a8-4641-268f-08dc86f541e9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uRtlEwjXyPVnyZPtq2iQPQuwz1Hhp6BsD1Plx0uuBxvI6As518YHHlze6Rff?=
 =?us-ascii?Q?7KOjO0eYjKDYEQ0ICJLhHW9w1I1Vd32qCuWgLy01a34VFDw8fwQS9DJf/ID0?=
 =?us-ascii?Q?Y3EX0ysWb1B8+JrWnxh0l5AXrUiSIW6mYFFlBntiRDuas+U/zxk37ySXCb6+?=
 =?us-ascii?Q?0AnW9qDmGCO+l3FuKYSz5vxdXUpkgmvjod3KLZFnx6cjNu1Bh5Uu9E7Z82CE?=
 =?us-ascii?Q?ryNE3ojI+A+GtujPLlDQDR3eLFyo7i2J3iTnIki5663FE9GtMhf4ZOn20KvV?=
 =?us-ascii?Q?a6leGB5CuflwWbEFQBz2m/YwwVbF5BiOLBW0oD1hgATAoAdkEtopQf4dfpp4?=
 =?us-ascii?Q?r9GAIKGxFiwsgh1IC00WVxoH5QTHZoc7wMsa35QGqnbE96UX30SRHsdFeCcO?=
 =?us-ascii?Q?oHrJ1mRkJ/qVnUaSW1kF2LsaSmAlhBaf59HVJBQ0uvrmN4BpvRRONLaORGXI?=
 =?us-ascii?Q?XGPcwmGRYDaZ97s27c4cS2zayJm4mg2Ljk511xgiJETRnKQrNCdWeY/Oz6+u?=
 =?us-ascii?Q?uAbfFdJSltjXOYGWuVAb17fyz4SdKrJlluCaLbzmbDPlEzWnVV33/UKwJx/m?=
 =?us-ascii?Q?NVsaF3u+U1ZsarlAbAUxyJPkH7WeGxy/MW0rZhQrPW6I9MAy7n7+KEzpuuGW?=
 =?us-ascii?Q?tKTYdCcF8GwT2bjM+1ygBvacwQJK7nKjsBdbe81xUd65mOAXT19nsRKUUAH9?=
 =?us-ascii?Q?3FsuOqIbYZuhaY4hQf6ehViT3JAczXVg0zYxuzO2XBsXJ0AUhTfLqeOCy1bv?=
 =?us-ascii?Q?BrfJRUhSeeqTlYBb/R1odmOqRRhBASfey78hR/56usJaItMkJVU5ctGhqERn?=
 =?us-ascii?Q?iCp1Vdr7DUqIVNz+ckROkJlDoffw9uoytw2BYZOczo7QijOOpX8tY7c7tf9F?=
 =?us-ascii?Q?exW6bqyrRytQZryAYAEXFzxIK3plyu8SmPwhLH48Cl+GWSHwWOl7WQapMLQB?=
 =?us-ascii?Q?7YdTcBoIiBDI8mGJ5iDjvRbAMxWreOBRn8ERJmeafhAfiTOXDNTRQUJ5z0w1?=
 =?us-ascii?Q?wgTgxHNFjo5UUNTUV87rG3iq8pQh1craOT+AjbANdULaTSWBgjAeVbnOw20A?=
 =?us-ascii?Q?O6iRM3LH2wtNSzm7zljQXy+dlry2VggeIUTqAQuORHTQS3DRGB0QOfFJ/hbA?=
 =?us-ascii?Q?SO1RlvmImg9ptQtdh5/m+T4QfTC+5dytVxy3oyo5D5g9ohXjZ2bVnpKELzhc?=
 =?us-ascii?Q?ILREDLNPRIyYvqKnTwvwYN1aY0wtnX0dbC1FHZYzEVL58ZQnywACx2NpV96n?=
 =?us-ascii?Q?qcT+E2F9qbQ2U6uDBC0H+Yg0IKjhTJjNNuMFA/jlU01zqTlp6VuyNRAypE9C?=
 =?us-ascii?Q?GoTFJrjfiIyuuMAV5f5slcyZZo6miAXTWdLHlXZsNInXGAev/pndypfvPsmI?=
 =?us-ascii?Q?+a4GLwM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P2B4zLYKBTJJIhBc1steF8vEIQcfYbRQSfuJwDIf8cpD8ingIgeX8toZKgqk?=
 =?us-ascii?Q?yuBYERiBVGy9ojRmQMopNha5znMi6onU+YLqN50tN22ukKXB5fs9ahgaqSuP?=
 =?us-ascii?Q?PbPxCL61tQkZur1BRAL+qN7BCRxE9zbm1vaZvaYKepcVBfktmwC2ur+9NJcN?=
 =?us-ascii?Q?3l4tMTOReZZPy4P8zGjZyofhXLZDE+nYNrNOiUYZDF2Qb50eyBlQOwRrV9xY?=
 =?us-ascii?Q?DXLYHTr0t33qTTQGNrEabpOB+O+/Uius8lKYEa9odLZAkT03qMqx3tgXKXRh?=
 =?us-ascii?Q?zie5cq38IHNZ1n04xJrKTsobzzy/qiZ4ewEYdCykHYO42U5Oi2xd8ykc2ynj?=
 =?us-ascii?Q?7eoXa4/Prz3PYqBYzjYcReI0HAaXop3nchkcBXUCNd11zgRGrBNeeEPdmy7w?=
 =?us-ascii?Q?vSCE6fjgu51c7tOGeM4Fwh6c9iFYfMMBIzsHzxDZFbPvesgMkB/EQdV+EuI3?=
 =?us-ascii?Q?QxKy4BCiTfBQrjNfWauKjiBJhCPeqgBCYOjWjmk5ZWc5MIgtco3dMzISUpYm?=
 =?us-ascii?Q?FxxgRekYPvpRbPMajNISA8G7qqIGGdxVudkNn5Lbc1BlqXkHaa4fQ6OaOIja?=
 =?us-ascii?Q?cfn9Xhy1dKhfzKirPRIZhrLwJdZfo/23eoFuK8uuGb61kCZ3yplaygUiEEMl?=
 =?us-ascii?Q?vtOHNn9e5EBl31tNIo6xJQzHs78rpMiv++wyavqNUn9jBos/3UyVdwERo+x0?=
 =?us-ascii?Q?7V+Bf2HX6rIFriZZH1rak7ryYhqszMitpATUScVjsdglllHFmc4xnplhop2Q?=
 =?us-ascii?Q?PdlW5QGCXRSQpWdKxi8V9RbyZxWU1t5wMDijLLdjCzEgrjCbBtPtWUt9v+kf?=
 =?us-ascii?Q?avorFNLWeFldv6Q5uk0zgILH4+8E8x+ZeOTi8NzIJkGlEKesObQ6U5pvKfIa?=
 =?us-ascii?Q?eAbhkTKqFzGuxhkqeeuDjaIX+i2n25Oy2yFQHBmByG9YMbhuYj52O6oJXz16?=
 =?us-ascii?Q?P3vyyW8Bq/eywMwwIIWKNLkqFk6nlj5DdKXn8vUl1wnUMiXh4sAXywe1s5tR?=
 =?us-ascii?Q?1M7W743rEdgYv99tuWJ+/6qDFHyNUS3JSxictlWqVJFlMPbxEiCQ+kxe7zDB?=
 =?us-ascii?Q?a+gs83hZJt+JK8bpkjPsOq+4vnPS4jNiJ3hEe2nGxygBU46kn3nc/415KrX3?=
 =?us-ascii?Q?jOh/Aj5yrXMkz6mZfIEwuYiDPM9fA6hyRTjgj2Vntak5lSuO1JpRcIeL/FGb?=
 =?us-ascii?Q?+uwr3LkPQ19e8nmXQqMcu+cbyWu3Q1bikj3XMRhNP5kvRBODsTAdEhjjMp2/?=
 =?us-ascii?Q?8MCQmbODDOmcMR2vxdbGzd+slcIbJWqNozuMw7jg+/tx52l8V3LG+aE1tCN3?=
 =?us-ascii?Q?hu6eH7yEsxJIEYMdSp+9fVCoI5yIDwGxsoRz2ii13+VQWTcuIA7GaUg7LIBP?=
 =?us-ascii?Q?qSo4JQ1mHyi8Pk5DLTo/+YnVXFOaNZWlfUEGaRrtUwWnBQbBi2FeVyANjzdf?=
 =?us-ascii?Q?r7g3Br81AigjzCvY8IZ5nYV+YDem953DSmbJmgm9DlZKuSs9UBfRTwcs/k5T?=
 =?us-ascii?Q?Qu14OztQVD+ZDZLAdFEErq9AyHNb7f2CxNPXtGxOKQh9ppEIvC9dciFQJhgu?=
 =?us-ascii?Q?7wIdPrtLhVo6g9L+/OxjLoayieYtgNYogomxBrZX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23d632d-46a8-4641-268f-08dc86f541e9
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:25:11.5027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FX95z+bmzhmAL5XCUPIXbba081XDzCs8ui5HtZ/eRfPX5QFwH0cc74aX8Oc8aNYrR1T/CnBdgqujbh7/oXVo5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8944

From: Jacky Bai <ping.bai@nxp.com>

Previously we assumed that the root clock slice is enabled
by default when kernel boot up. But the bootloader may disable
the clocks before jump into kernel. The gate ops should be registered
rather than NULL to make sure the disabled clock can be enabled
when kernel boot up.  Refine the code to skip disable the clock
if mcore booted.

Fixes: a740d7350ff7 ("clk: imx: imx93: add mcore_booted module paratemter")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Tested-by: Chancel Liu <chancel.liu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-93.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
index 81164bdcd6cc..6c6c5a30f328 100644
--- a/drivers/clk/imx/clk-composite-93.c
+++ b/drivers/clk/imx/clk-composite-93.c
@@ -76,6 +76,13 @@ static int imx93_clk_composite_gate_enable(struct clk_hw *hw)
 
 static void imx93_clk_composite_gate_disable(struct clk_hw *hw)
 {
+	/*
+	 * Skip disable the root clock gate if mcore enabled.
+	 * The root clock may be used by the mcore.
+	 */
+	if (mcore_booted)
+		return;
+
 	imx93_clk_composite_gate_endisable(hw, 0);
 }
 
@@ -222,7 +229,7 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
 					       mux_hw, &clk_mux_ro_ops, div_hw,
 					       &clk_divider_ro_ops, NULL, NULL, flags);
-	} else if (!mcore_booted) {
+	} else {
 		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 		if (!gate)
 			goto fail;
@@ -238,12 +245,6 @@ struct clk_hw *imx93_clk_composite_flags(const char *name, const char * const *p
 					       &imx93_clk_composite_divider_ops, gate_hw,
 					       &imx93_clk_composite_gate_ops,
 					       flags | CLK_SET_RATE_NO_REPARENT);
-	} else {
-		hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
-					       mux_hw, &imx93_clk_composite_mux_ops, div_hw,
-					       &imx93_clk_composite_divider_ops, NULL,
-					       &imx93_clk_composite_gate_ops,
-					       flags | CLK_SET_RATE_NO_REPARENT);
 	}
 
 	if (IS_ERR(hw))
-- 
2.37.1


