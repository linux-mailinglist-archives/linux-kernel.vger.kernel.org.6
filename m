Return-Path: <linux-kernel+bounces-228175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4983915BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AF61F226FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9051E2D600;
	Tue, 25 Jun 2024 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gofaumJx"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73221B7F4;
	Tue, 25 Jun 2024 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719280212; cv=fail; b=eETwgY4NfguRvTUSD8XDzFTINCM12GCrLWcTnK+It5fklOCrsRjKzliBfwOszJ+CGW067ziAzS9pyjR8NRAmFDcvto+TL64LPkiVINqOshB0SXM/la0yeB7N4J2JK00po0Eg/MvfHC+kHxf+bjr6udTlr2sKnhOIDNXOqFl91Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719280212; c=relaxed/simple;
	bh=zSc3MjhCIfC8AjDbARmYT+88SyirAU3GV1ZenT6zc2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AIxDnNfyOyZAUBK8lzjFDoz2cajgdvB8mxkbXfGZu9pLwsYRCyX0Y3RU+xk9HsHUsBciNe5ASVd7DLTPaAr6h+7jkQSB7iOTIJjelQhK3EbtZaHVsVfmoAGE6OkaE1/QziTwRtmg9vKIzijxHl1vfPbqszoPzVTkCSlsT1ri5pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gofaumJx; arc=fail smtp.client-ip=40.107.7.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoJvvvXg1uNaW37qK4Pn84QE8agrtjNBoTkYxp3Iis1pg7+r5DbCXthgizCa9rCyV6QTaB6f+HZGeDiCjWBgxYuXBvmiLJk2GJHqYa83Lt2nCUYKvzwbk0RGExMOYyYdRfCkp3iK8/bcYMFQJMhaaoEOC9f+f2CPngwlfoGUq2G/XfndbPul9BWjixN71xe2Oz8agl7sVCfeSWhEo2x50F1pX1qed+o5oulsFPF1VuJTjVw6iwDud9PuJWJ/z+UomUe0QmO4j1nEt1BRhYpCDZbGPRYB5jss1Nn5ldLY9TsOe9rF+aKqQKA2j32ZGoYuaDk3ycVnodulObuT9WAIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyB8OvVTfRDbfqjh7YCnCbwhZc3Z75NK3flFYNlKZRI=;
 b=HMgGtVni3Mo5CFuWO0gjd99jTwFTQJiPBZboJZ8dGeo4xpWfGbhUjOBjzmYaHM6uCb7M3kXUiUvtzk2dczLDeXgyVEoKmXkas4uMTqAkFOHlsDwnf84qrQ3XkxB7LQawCs+FdCQVJr3DP/vyE0+LgoaPsG0ss1s0Xv4y0yGUVGskwcnk+r74QIGydzphxFQrhuvuroM+vNo/1Zi6GCMaXDKBRYiIKacPjqC+XSYKuxTvKVAz0qZa8jkHdGiK21d/l6F3Uj8Gr+OVvpSNr4nRmfQovMwpsVKgVYxN08D0HcF2/8XxxswweGtlRBkOBuIBw+Wycvok6k2OW2iIhl8Edg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyB8OvVTfRDbfqjh7YCnCbwhZc3Z75NK3flFYNlKZRI=;
 b=gofaumJxMbXFncwN0tU4tCDlsjAroT8Dqi4E+CXQuxxsjOaOvJhVzGm3XO9EC6KAJs7b6wO26kDCXCQGvYNPMchiRkTleqt5wXypTLorMelCSPt7PZmEn+UT5U/6VmefY1q7gCF4+32QoRuKPkyn0KvrJ3NUZakdnyOiWnD+KwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 01:50:08 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 01:50:08 +0000
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
Subject: [PATCH 1/2] clk: imx93: Drop macro IMX93_CLK_END
Date: Tue, 25 Jun 2024 10:51:46 -0700
Message-Id: <20240625175147.94985-2-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625175147.94985-1-pengfei.li_1@nxp.com>
References: <20240625175147.94985-1-pengfei.li_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1adeaefc-bfd8-410f-8fe0-08dc94b92412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|52116011|366013|1800799021|921017|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M1WHTeNDZAKN3xFYggXJEr9HoHOk2mQA8XpL+FZAy3ozRk7iBH19txBQxsNC?=
 =?us-ascii?Q?kiYxIqazGXhhBNvxcKBXvYi0TLzaTelB8/hFHCqX26fAE9Tvan7YoYVQckal?=
 =?us-ascii?Q?Ahl6DeG5VJhEr2PTH/kXtT56Rx9wG44UeMuBUuH6Gw1Wa6T9QJmAC2j/0D2s?=
 =?us-ascii?Q?+lDCtzLhjByCU4b69WO3ZfgTRB3rK05G00y/5PR1xS5Q2vEnUxf7Bn8k73vd?=
 =?us-ascii?Q?CprgfiF7JZyyKBd6dzWYQBCSvCTfdCF31CGE0L+WW+qdro6q2IQj4vr8kC67?=
 =?us-ascii?Q?7tTbyKocOvHk+wZ2AS7xM0RgaSWJZneV7pYz7yEze2OUX4Y5Mbt3vNeROnuJ?=
 =?us-ascii?Q?X5Fb9BvXSmY/5Vp3YhKCclwRyBQEHixFFcw5LKI2WpkH37bLOGmsu1GXwxSE?=
 =?us-ascii?Q?ptfWZs9wB3N8uIuCzAn1IqSbB8cnA6HnfpPkrI88ORaPBnl+e7P3NjQhJ7if?=
 =?us-ascii?Q?V+xBjkPrAuxZNmYy2Ku2tMdCveWz12vT3Gs6Oc+eQVATRLnt/cJamNpA84Zn?=
 =?us-ascii?Q?jprdLaK5auvJ7bptouF9FiLyNjo3gyvFx34yK+dWsu+L7YUVZK0G6q+cbcMV?=
 =?us-ascii?Q?YWH1L/fA7dYIduccizUh0Zdu2wczQQq6Pn4imc5TcpKuwC1eLXTyuyqM4wTw?=
 =?us-ascii?Q?D9S2YPrEL2i0i2Oce4DAPWna1RKTGZ6y9oOYdI9/bCJYEevB82kpf9mwfIfc?=
 =?us-ascii?Q?WdyRm6ZINZTYWxpdI/bypa46AMN3kLlkOqxuhXogLya2tRs7pofQYmsQcVU8?=
 =?us-ascii?Q?krgoahduyAR7Pylhxn0NO7ZRZOG2mulMoiJJwAPP3s5mnweem8Da7cb1qilI?=
 =?us-ascii?Q?pY+SiE9sBKgA1c0K4lG7OG+/FTqaHLMRDUnoRmF9kLrbFXwQL32dmf545B8t?=
 =?us-ascii?Q?2qRhuF5MTwBvd+8DWqCGvFeygJDWzRSYBaOVuksycgAuLg0UumZBN9HhXZeH?=
 =?us-ascii?Q?wlvUdmbCxFIrYQgIr6f4MavQxQIbU4hKYM5PxDyXawubrOoB61xVmKzlcy11?=
 =?us-ascii?Q?DM4ACISvn++DQKsQ6pZFL8fhDn1+CxjJE4OzLsESTWFewvEIehfHFyz9qqcA?=
 =?us-ascii?Q?s/xqdUrnIP5Z+wRgC6FXys4cg69r14jd9tDwdnU0TfxrOzMr6yj1TQryzwMF?=
 =?us-ascii?Q?T8fxvyiexU16e55UpcODyxoa7ddZWoFkMOXWlm9AfGLmFBOfbhcE+TaHDucD?=
 =?us-ascii?Q?QDTQQD5pjrDi7rhkrr3muWuZtdR2n7HQCgZbqxuCAaWvPdTefJbyyy9ite/2?=
 =?us-ascii?Q?C7gFf6N30tTQcW5GbZ5FsRAb0gX5uEwdnoifY2ouzla/LErKN4QgeJaymrYp?=
 =?us-ascii?Q?EpFnwFKP7/VQJM0ng4T6jY3dv8vKQRqvVl4BXdxNuFar69QU6w1fBNXIDwe8?=
 =?us-ascii?Q?abwCpgOsA67bRlQ13h9sOwkFrlrh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(52116011)(366013)(1800799021)(921017)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DfZXvjiN+W9DVdDBi+2dlVt4L+Ld/jdJKFG7f4xMFuomXYcKoTFZpYW/0rmj?=
 =?us-ascii?Q?P+iOzR2hfONjmLQ1bbLt/zFgM1gvA7lkYbIYYDOcnIH/m2L9IuhK+arrwbIv?=
 =?us-ascii?Q?dipF0mO/ns+5giwGIYzymrxklaBwRakHSfKkIPj6ara7Nn58JnGue9cla7Cl?=
 =?us-ascii?Q?e8O4qcYrIIMz2WEo01M/3xS1i4a/wvzB2V7QxNVPoBHOdV8PFP5wfWyswWLU?=
 =?us-ascii?Q?aR00C3mD4MbCPyPRKU/Pe9VUoh9W8RwFjWG2k1r4qqMG78E3hjc6t12eiPGv?=
 =?us-ascii?Q?1cJfRYV71jqnqLjGK/I0p+EHrThMmK2OKWI6BHeyspHM//qIEtv6viZmQvMl?=
 =?us-ascii?Q?hfOEoghInigkxGD6AiDBvIjf0xg02rQeX5Dc5JTgsQnl2/XfsOZPI/7N0AUC?=
 =?us-ascii?Q?aRk9K3uTJzGzkjDlG0VYgzAmv8PBTFjvq+XIxepjgIFMmtslah8hUu3RjYGl?=
 =?us-ascii?Q?ITFDj6lvhnSAtpQKJ/QTH9YeE4aAnyf0UTS7k3STlwGHUAF/wEhBAnNNwJ2o?=
 =?us-ascii?Q?4RDyPmt6vDVspMggwdW+pfG6CEEjx4FM20Hb4I/8wA7VIyNdbPEx5O5boFIt?=
 =?us-ascii?Q?KrHQQNTvRnibZADVlzqS6t3mSEp5XctXnO95t5WouR19ggdmJH2uH/Jvwodq?=
 =?us-ascii?Q?jvsh5JpE0I4EYF+rOsimhY8W8dPwowds6hIBRVKIGwOtyN2PdOgpw5OspFlz?=
 =?us-ascii?Q?+nu8N0ltETOIJ7Zj3d0uOpq+HX9UOc1/cuJOxKpa/31eC57S0HfnMxkJyXOV?=
 =?us-ascii?Q?dIW7Jqoxf/5tAy6IlJICxURE0ham0GS4e81/Kmp6RCT5P+QLOsu/XO2v78NP?=
 =?us-ascii?Q?DUtH0zqMUWMAPpAUqXs8w6+RHZyj6avpBAxlstDHLgEHpodwWTynqtNT3y5Q?=
 =?us-ascii?Q?iWRqL0P6XzSPsCBHzim3TNLRgSUsVRqWD1j3QD9Vprl1G7pujD1QqaEWY7uO?=
 =?us-ascii?Q?SZiLgScSHfNtB91W/MjEcCRhtc99bJiyA+iF7ew4f4pvl87DLD1ojdHFbqEi?=
 =?us-ascii?Q?MA1Wh83kXOFmqLdKJaiJSAeR3kG9ZVrDuPbFTTDTpalbMhujuL7GWPb/TuCt?=
 =?us-ascii?Q?lfnDwQutc8NASSIyIpFaVSCT7OvzDPL1/0k2zVDED6wY6plfXruo2bRRH8FF?=
 =?us-ascii?Q?RYTnCSkgAVT29pYfII/t3nFsZ341UGKYZV6e+Ud+40S+PeXCMLfDrp4bKv4i?=
 =?us-ascii?Q?bF5P6Te4RHmxLCQ4VhtKZt6DJhs9FUhtvCC6poTIqfT5zo6F+bq77B8ou4P/?=
 =?us-ascii?Q?qvRx8sdM2UBY9G0Kg+G/XXY9F0rx2oNZDr13tSB6SD8mNeI85Ig5tNd5X6G5?=
 =?us-ascii?Q?8xafHEvVlGCywaU3r2oi9ZQq2Nif5BYvJ3fQDElGCUDGP9h9+i5PTm+Su58t?=
 =?us-ascii?Q?M4DSC0rU2+OY6uwaqcd1zSieusJX+KjAbUlGhvGjS1Qxy90/PLH5uRcLRkdg?=
 =?us-ascii?Q?t2Rq2HLpJ4/2VYjwvx0sZ7g09JdbRL3phsk9EN2Vobpd5ldYANQ+IEoE0awz?=
 =?us-ascii?Q?r7x8LFOLAiotisQ8SK7v1gxPHDoaty+Htz3lHMEypFR8a6JfsYBTXxHCrATs?=
 =?us-ascii?Q?xlh4Xr/S0/QAJF+XKhj5Flj7lFRBrQ1SZaevxWmW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adeaefc-bfd8-410f-8fe0-08dc94b92412
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 01:50:07.9697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9svq1uYBDFLJric7p2ig4j8scoSt0XYs7fdbowTj5dSy+0Wq9HHx1wDU6tV8c9qv0zTECRkaSdUipPpUCdvuEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965

IMX93_CLK_END was previously defined in imx93-clock.h to
indicate the number of clocks, but it is not part of the
ABI, so it should be dropped.

Now, the driver gets the number of clks by querying the
maximum index in the clk array. Due to the discontinuity
in the definition of clk index, with some gaps present,
the total count cannot be obtained by summing the array
size.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index c6a9bc8ecc1f..68c929512e16 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -257,6 +257,20 @@ static const struct imx93_clk_ccgr {
 static struct clk_hw_onecell_data *clk_hw_data;
 static struct clk_hw **clks;
 
+static int imx_clks_get_num(void)
+{
+	u32 val = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(root_array); i++)
+		val = max_t(u32, val, root_array[i].clk);
+
+	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++)
+		val = max_t(u32, val, ccgr_array[i].clk);
+
+	return val + 1;
+}
+
 static int imx93_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -264,14 +278,17 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	const struct imx93_clk_root *root;
 	const struct imx93_clk_ccgr *ccgr;
 	void __iomem *base, *anatop_base;
+	int clks_num;
 	int i, ret;
 
+	clks_num = imx_clks_get_num();
+
 	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
-					  IMX93_CLK_END), GFP_KERNEL);
+					  clks_num), GFP_KERNEL);
 	if (!clk_hw_data)
 		return -ENOMEM;
 
-	clk_hw_data->num = IMX93_CLK_END;
+	clk_hw_data->num = clks_num;
 	clks = clk_hw_data->hws;
 
 	clks[IMX93_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
@@ -335,7 +352,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 						  clks[IMX93_CLK_ARM_PLL]->clk,
 						  clks[IMX93_CLK_A55_GATE]->clk);
 
-	imx_check_clk_hws(clks, IMX93_CLK_END);
+	imx_check_clk_hws(clks, clks_num);
 
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
 	if (ret < 0) {
@@ -348,7 +365,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	return 0;
 
 unregister_hws:
-	imx_unregister_hw_clocks(clks, IMX93_CLK_END);
+	imx_unregister_hw_clocks(clks, clks_num);
 
 	return ret;
 }
-- 
2.34.1


