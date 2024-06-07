Return-Path: <linux-kernel+bounces-206146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 979559004CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9021F216FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75975194A52;
	Fri,  7 Jun 2024 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QSSvzKBA"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13B819A2BD;
	Fri,  7 Jun 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766747; cv=fail; b=F31n7OHFutm962igqmFzYPM7oDRJxz4Pg91lDANasvcMvZ/TNHQqY+Kz5ODGHACt64IjYlYy2k7rT84NEqahTS22DVDo3xbsx8kKmzvadhF8oYsxYz7870CiviDhjJ7aR3IMH0VOK0TvWwqo9rwSc+ieVWoIGbyQ7Ol3wPnXKoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766747; c=relaxed/simple;
	bh=ZtVoByOF3Kse948pgLOboAaSRQqHHV7ctAa2NkPHW0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LBdbH4KVLwT1D35bgCScQ6jIdKavCxapeluUcBP3TPuaxBSNgKVAhF8JqzRl6/tslwPaFs6jN66UMW9qjZQLoBUQ/6YxZXD7/qmp83qm3EzqCRwGFK3b2St5gWHxoz7bY9qMHjjUCKbYFd8ep1AYinIUoRsckYzxUDxlPYWS6KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QSSvzKBA; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRKHO+ajM/la0vQrzvAuwSj4qYfopO10XWHO5g8e7HppTuwzE8S5/OXd7gxoEL3B9R7YugOaFRtCVVNAUs4+3POWI7bQy5UJ5QqepxowGzMZWjfSwOH71ZZ7AEi7E5WKC5lVtPtRXkJc27syC22bINf0E3ftIKCHFNNZtfyII2hlrvo96tawRUkPj6zj3BEj6i7w8YgLVSALNCOKck21/b3HaQwO7pnyk3csmplUnCNSHMX74csE00DAUp6AfKRiype6UgVTvohKnPagsyrWsNPpmApUxBTMfKWMd04afuG8Z3Qe9ZK9E8Jqt6md14gBQqeezTYb6T7Yqk+gLwUOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7B7ckCKaaqtPNWdvZBtjTCCWA+EV/JjsvbYzGxFHiio=;
 b=S/SDOD1FbWGbPch/0gD/9syVkHv14Sv4tUlGkU5mNYAYpohJ1tfw8y95ZiC9NX5wC3GWeF/kEuykRWh7KKxKFP//2lx7b2sOpb35z1hFhnaUzx125GBamcRo6Mpi+E+3ePubO7dZJtwV7yINLSmhKsHVaHP/I9k38CMEbe6B1JMDD0gEH9D8wszw8SnERfeEzxx0tzB0rwIAf2804lfn+Gce+8sjkFealMTR8SF/9+O5W4TDWmUX17F1n9SSX2Af+UMZ5LNvo6FpT9Tdd+1jF+5RAYxFc960gzosTefDU9ni4Lf64PZolamXmon8sdvJ8MItb+iWzO39Q6vyPQhD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7B7ckCKaaqtPNWdvZBtjTCCWA+EV/JjsvbYzGxFHiio=;
 b=QSSvzKBAAkQ9wN1UI9QaLHMNy5e/j228dsCYjfazj9kSl32JN5aq6J4qrsyD95hb/mt61xB8/LCZWu4iRnYJ6BuJmILkpvpju8Q27XnQtQ5lGxsWrsJ3y8MWWJrWmpaleWRJqE96/ka7ZA7KHJA0e2lJhIE9Sht4RCUUljMphbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Fri, 7 Jun
 2024 13:25:42 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:25:42 +0000
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
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 08/15] clk: imx: add CLK_SET_RATE_PARENT for lcdif_pixel_src for i.MX7D
Date: Fri,  7 Jun 2024 21:33:40 +0800
Message-Id: <20240607133347.3291040-9-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cdce25a1-6684-4320-b5ab-08dc86f55494
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NKgDyp22WcYcW7Xfh2Y0L3eGWe7axjLT5lRbt2ctiAS2C2aae6BFuPKHgfeA?=
 =?us-ascii?Q?9GbgH+3BLaLlPlsNz4ympxGgq2OhxlCNrUMqtsfmI90yE2wJwM8gPgaAu6n+?=
 =?us-ascii?Q?sZUsfyyMg4wjDcjBBlrdfanp0Nn07x0aSdzDAqLS7fyVtQeS8p3mb8C6eg7E?=
 =?us-ascii?Q?ZfbhTrzS/7c9GmG2KQXQt4touxHYIkOfClaggIgT3Orb7RRDRpxcoxfhxiAB?=
 =?us-ascii?Q?N9P1iea1lYxrn1s353T/eSsrpW27j8uDV1R0rbyAjrgU/oV15GKmrn6p4X02?=
 =?us-ascii?Q?VfYyej92FbvkXkYLxmraSRS2SM2hNY4BZ/N8SOCaHhGpjTW/fBi93FqA6CZI?=
 =?us-ascii?Q?DFScREi2k/XRYG0GF+M6vJ+nyYkdYHNXkGX7v3pwQ2QC1yem9ZTERJWJS0qm?=
 =?us-ascii?Q?HJsUzF6fjcybApS2Hs7L3CX7VLV4wMzHknVmUpyHv4QrQdYbAmpO2XXYWzOV?=
 =?us-ascii?Q?sZRrGhXkppoFzQK98/DxTBGwWz+GpwdEjJTXTL+i0ksSqv18N2Wuu873FVCX?=
 =?us-ascii?Q?jOUfxcBnoOK2oM37QmErbvT//8AIXogf/fV3SGdAJ4NPs9XK1PA71YRF2yO1?=
 =?us-ascii?Q?MjY/C60kSjnQ/ti4JmQoPxiWPEmhTmZwfdq3uJSRm36n2CiW6S1XHMl8cyoF?=
 =?us-ascii?Q?mLzPYgx3P1QJ/Np3sAqtviLF8SSbuc8qCGby5la8sxP4xzfQ2Z3od+AeP3NQ?=
 =?us-ascii?Q?KVoKEviqQhdMhdw019vUDX5cooqZVESNiQ6cLfLuaEyOkmlYWTCE/97UP+Hw?=
 =?us-ascii?Q?jlXuFiq8ClTvP+xHt2XPzo7mGEV6ysbPNEr2DTklq43kF+DDC8E9Md42c3Ck?=
 =?us-ascii?Q?rJ1/pYVCduJ21xuJpzuwRNUKVDFjYL+m0nh52MTwMIfd7Y2rS8CRk5suNDff?=
 =?us-ascii?Q?FIyr1e3bpZ9LJfRdy5MTNHjuu5fCUHkqs4U3CvkNpJdad05lObgtDyWxuyPx?=
 =?us-ascii?Q?MzbTyyXCVN6QvSqoRyEFWf/bJVODz5GEUB8gZTCmyWOO/kwihfPrmB4ygQ4f?=
 =?us-ascii?Q?mJEcLR4upBC8FkgsZJPS8ltsnzuRNM+RJTtjk/rdm4eOIqJoOhDYL9BHmtcr?=
 =?us-ascii?Q?7xTvDWXjzJjvGYn+h4Pd3AjC5DrDirXZuMJsWASpVXc8I+7DDlqL5Xopl42v?=
 =?us-ascii?Q?j1JTjeJ9nFo7xp0jgYxpAIfsOwvbm7jP0JBjCeXtx5IN0lGj3tF93uLLp5gR?=
 =?us-ascii?Q?4DKAGTf3FPPNviKSmV0Nmv6n0CPIffJbNijUfebwwDieZmdyjAN49emvF6B7?=
 =?us-ascii?Q?XHqCtaiAw8iy7+440bh5xMnj5PPWoLLuREPrH4ey979eXIy9Oe5EvNXtPxnV?=
 =?us-ascii?Q?nx66G3Iws7ZLn8XJ/Lnm5vFIMAWhb/s8WmZrDWActlaw5IZT+5do6SFze1GR?=
 =?us-ascii?Q?0aXghKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AHEF7RHzP0Nbb5KfBbwvVDVZNKwUvLTWWUb68vJftAvVVFjjHsAlgzox9S4X?=
 =?us-ascii?Q?hiD1S43AQ4nZfiadN2eKT59CO/ni877IG++w3Tm3bjV+MAMnWBmalNm/kcsh?=
 =?us-ascii?Q?S9yQ9kU22ddp5X1HcPBYlTkCwZKOHeQanErdZzpxkQA6AmqpWN1S8Jil/jZY?=
 =?us-ascii?Q?Wjpfw3XH3HDXSKfOXElfx2Z/k4Rv/kdPtsOrHZVMu0LuIDfZkor/z6PJFYLQ?=
 =?us-ascii?Q?lBFVv2V73zfepobZJHLt4vLMU5io4oN8QfQXDPyoszIETCDAergOPkm0/cPC?=
 =?us-ascii?Q?LQOKuHRrHt9vr/6lkfHPQm75SCeEyD2E8sx23iFMnElaUU2yoGtqUi1TeBW0?=
 =?us-ascii?Q?kMAmRZ1FhdlaO1ROCSmI7LFXO8/oSbTSTE/SS6Pu3u4pllcHJX02ppkeZN2V?=
 =?us-ascii?Q?mbxMxgW37S1MGVo/eUPb3aojS3BzCpxivjEhPptlgYWwS1oBQTeQEtzRgyRP?=
 =?us-ascii?Q?armWjfhoZ1E/QxaEO43b3kROpD0iHufOP4UaJwYjxX/S714QxTrCPGZ0xl+x?=
 =?us-ascii?Q?eBI05CU3qSscd0+wGqYHdRCr0Q894/Ud2OI7zigRhHozghh7/GZcGQK14pNo?=
 =?us-ascii?Q?vKPr9H5rE/t+Uf/bhpgW2CEOt5zfNaRfwsaM9S86EpohE33mD9II4rAQexXw?=
 =?us-ascii?Q?roX+BS+xLMxjs2o11dqWOsq6lVvu0E7LlxIdixYQevBGT8d2z+gLvEIiy9gq?=
 =?us-ascii?Q?ISHDTazmBdw2JdbXDkBBNnUUqETnD16DTeQFw4038pJ2SOLyXcj8jUjDJ8hq?=
 =?us-ascii?Q?fwIy5Vsp3Fp/Isa5I+JWgL/UEvM4bmC4tTpXxZj/xdrgRRexJKdDKUtDJzm4?=
 =?us-ascii?Q?KXj2e087Ez7Unh872G7XnN+ZFLv2t9/yvw5vBPzMm54YFwhCEf2ub2jjCnwa?=
 =?us-ascii?Q?NH5Cz5dto2secDTNEtQxTm4ydjh3KuL/K7eGKwgMogZ2KtfGm5jWaQT+qV4t?=
 =?us-ascii?Q?/ierhOzt6BmID4cl18sbQF46XwZ/kmdcn1ziik21JLs9Pfk+fcyaBIvDt5oK?=
 =?us-ascii?Q?sldcDk7+fanWInW64DEeMmYX6r31AxVzN1f5WSh+tLGe+E4dV2BpAL3txerr?=
 =?us-ascii?Q?j5CsWWZ/JCI2V3ioGsFdbYHvW532Rdxk/2wxVZlgNadLMd5a5c1qvP2k6iG2?=
 =?us-ascii?Q?IumKqHd1gVXvt2/W3Gi82JtHKuh6D82yAH7PhKkDcah+98t0lU88yo2djmng?=
 =?us-ascii?Q?xtkWeYQs4n/QXitirH4lrWfxWL1ZNNtgRGA5FkE+4e77o/+uSy/8hgiHbRic?=
 =?us-ascii?Q?RkwtL8/HGKyMxd+WATHoypt39rAtxfTiZ/+YMsFwzSFmO+y3TFVQNhaFd6ml?=
 =?us-ascii?Q?ssg8S1CjCZWiXPoQfIf6MalxeBXDbvmN00W/eoq3yvdS3eCePJItKTq6hVAy?=
 =?us-ascii?Q?bPheh33mnfIY6F3W6Ng31O7bzEx5c7fQzzv0uBsUchc0wpHULdl9KW6RNI4X?=
 =?us-ascii?Q?cBYXx+8RXmPXDFIpknhtbwOW4+lIlBvl/nuEHfu/KmeIwOjCP/3PG98AvHph?=
 =?us-ascii?Q?suwtbP1HRceWoFCefSpa9OLnbH5W1uomjjcRvno6DHLpjBORe0K1JIywUD8w?=
 =?us-ascii?Q?frWneobD0nW9/YzL7jPMlkElCvqOA171jgbuOUq/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdce25a1-6684-4320-b5ab-08dc86f55494
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:25:42.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfPj4EhgxD05CwrxgFKY682PYk8CvAOAPt38XNRTqBjUyj2MYpHWQp8DrYvHzdrW09e0O6YoOhhJ+a/N8u8pTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249

From: Peng Fan <peng.fan@nxp.com>

Add flag 'CLK_SET_RATE_PARENT' to 'IMX7D_LCDIF_PIXEL_ROOT_SRC' to
propagate rate changes from LCDIF pixel clock to video PLL to
provide more accurate clock rate for LCDIF pixel clock.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 1e1296e74835..99adc55e3f5d 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -505,7 +505,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	hws[IMX7D_PCIE_CTRL_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_ctrl_src", base + 0xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_PCIE_PHY_ROOT_SRC] = imx_clk_hw_mux2_flags("pcie_phy_src", base + 0xa200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_EPDC_PIXEL_ROOT_SRC] = imx_clk_hw_mux2_flags("epdc_pixel_src", base + 0xa280, 24, 3, epdc_pixel_sel, ARRAY_SIZE(epdc_pixel_sel), CLK_SET_PARENT_GATE);
-	hws[IMX7D_LCDIF_PIXEL_ROOT_SRC] = imx_clk_hw_mux2_flags("lcdif_pixel_src", base + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel), CLK_SET_PARENT_GATE);
+	hws[IMX7D_LCDIF_PIXEL_ROOT_SRC] = imx_clk_hw_mux2_flags("lcdif_pixel_src", base + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel), CLK_SET_PARENT_GATE | CLK_SET_RATE_PARENT);
 	hws[IMX7D_MIPI_DSI_ROOT_SRC] = imx_clk_hw_mux2_flags("mipi_dsi_src", base + 0xa380, 24, 3,  mipi_dsi_sel, ARRAY_SIZE(mipi_dsi_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_MIPI_CSI_ROOT_SRC] = imx_clk_hw_mux2_flags("mipi_csi_src", base + 0xa400, 24, 3, mipi_csi_sel, ARRAY_SIZE(mipi_csi_sel), CLK_SET_PARENT_GATE);
 	hws[IMX7D_MIPI_DPHY_ROOT_SRC] = imx_clk_hw_mux2_flags("mipi_dphy_src", base + 0xa480, 24, 3, mipi_dphy_sel, ARRAY_SIZE(mipi_dphy_sel), CLK_SET_PARENT_GATE);
-- 
2.37.1


