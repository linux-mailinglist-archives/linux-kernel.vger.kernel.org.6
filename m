Return-Path: <linux-kernel+bounces-206148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6749004D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105131C2124E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39919AA77;
	Fri,  7 Jun 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J1CNPhW3"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592F193099;
	Fri,  7 Jun 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766763; cv=fail; b=gnZlT/mvrT6euImxXgj8VSjMKHl8xNrQwrPYj4v5TtHl4mDtQDOSPoFUjj7JtsC5F2K509Yj9bxFZ30TjudUQ8iuKow9cTUhkMWItK9W7jGxjR2YuYtzLCavz0cGD0BJu0OOYzyGKsfOl+OuoEMnQkcO53e9K1PSvZLBkWEcE2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766763; c=relaxed/simple;
	bh=lZAt0EMCJGd4bwrk5j4Tb9MiqxdG68bmacQEa4d6fTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VZZQyyxbzaV5KoZ1Idrg9lrJLJZLkTyEQK/gTG5S1C9BKHjShc767XJeeMNqXVlFHeonLfkANQJy9J7eUpV6wk/JgeQAkwkeqzvYCPmBF1b+VX5/HGhj7mMKKIDxsv0If4SY5lH+M++lAQh/mr7e9D0yjP+1WXYQDO4i9PXnzys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J1CNPhW3; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHu4wWZaDg0hs+fYtEqJrkcP2muuIcMc2Pykn6Ef1Ih9piD6kQP2dsOIPhiBvCdEnH28RyEeNmKvdt1659prJuz6vmTmrsXgBzDYFuvrUfroaB7J7HCKgWc0Jm2FmK2cPRK1PpwEyfGcn/mw2qLvgVQAg0kKsIQ/jy+/XA1COVnCWOl3v402u3p0BBJN3QrVAvzlC+UZS4GoGIG3ZsyjTrhIBTdbMrschCQuZ12lFTCenRdTNW0zPO5g/lUuUHNnemqGMuqz1tV4uAIxa/B4klsX27Xw2yUFS6R4Fmy1tKEB6/95KJfCOQwEWx1qxRMa+FAwPjYVLqoylJHhZP8Evg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XE3vWYJxEeTLaV5kIKUZwPoVeAeNNIkBe6hFoRsciw=;
 b=WkZ3qGEQaYaUxyvQxYwZHPih5Crle12zbVHmwKQhqfLDwIu5VjcLU//XhKoCZrqdxuAaOIJci+XWkSRCHmIos79Bmp9vdbNF+FypczOkqpnQ+z05yIn8OV44pvk21Q4XWXlyydXkdxvCktkwEDgrKJFWykpKR7wMFzXP8fY1i4nQx58s4nHF55/TU8yor0gGGmnwfF3gzfgrf1ituIyodmN7Yb96V37vd/2GNDaO5ophvR5Hwo7nhV4UBJz/EfpWWFjjTMyLiOTgdfdnPCZRkysNT33jO7jBaQDNHVHDoOnhV7g+irPkyzE43fhtVCbKoEhWY8OLU4UgRqrYIJXslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XE3vWYJxEeTLaV5kIKUZwPoVeAeNNIkBe6hFoRsciw=;
 b=J1CNPhW3rL0VuQPnCbaUBeamwcdPf9RRxY6nwCs/Jx0hhSyspnqDlREZskgKlZYowDf21yExVZwpa+z+cxlfLwsKL15q8089v4CUKuMxylal7+sQkInYQiZd8uj7U1uGyknb5uamrfEScauwHoKZoqKpWb6p1xbOzE22nmqkJ+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 13:25:58 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:25:58 +0000
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
	Peng Fan <peng.fan@nxp.com>,
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	"Oliver F. Brown" <oliver.brown@oss.nxp.com>
Subject: [PATCH V3 11/15] clk: imx: imx8qxp: Add LVDS bypass clocks
Date: Fri,  7 Jun 2024 21:33:43 +0800
Message-Id: <20240607133347.3291040-12-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|DU2PR04MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3c5643-acee-48db-bb0b-08dc86f55dcf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?trlj2MvvwoQ0SAtRcmX6DIBaHW71htNFvr/jPOnWZaKFfjoiLmLdRWnFGZ2g?=
 =?us-ascii?Q?Gu5jLd5KiOuH5Ee4MMEhPWpqlUMCBVc8Qa0dqUvzalw+ul3nOpoUmqiR/P1P?=
 =?us-ascii?Q?wWpLF1kdi4stSxH2VNBxt1v477oX+fvVMRIzLk4b9CphcZd3xTNDES73/8Dg?=
 =?us-ascii?Q?Tz/Wrj+L40u34aDQ2pRv88550Z9doJhuuCPI/3JoFwUUOoQW3GFMJLWrFzrU?=
 =?us-ascii?Q?p3CvgsoNHAcMxxo6A2kzEkUFdmRBISch8Mq+eiAh3nJ6xFRESmxo2iOikp+3?=
 =?us-ascii?Q?SvZkxc9Ums/Gwp8vYgXnWttFxvcTkkpmHGVh9LoXyMGFhwhhmyou8RsKKX7I?=
 =?us-ascii?Q?bjSZKNysMjVOKBXOG6ILkJ4rniGscCjIcmVoYktLruUOxXnyEnibacniK1xW?=
 =?us-ascii?Q?6svI1l6SCRrhWwxMo8Dh2MFG8yD+6b+agFyXbcHCSEikfsEhDbJZM7Q56Atf?=
 =?us-ascii?Q?W5k6gPUe3vY9zbzJKjn4yF3jzQD149M9rszOg6KNZ0drRn1Xn7FGRO+Vpgso?=
 =?us-ascii?Q?CbfpAl9vebsggf7mNF1913i0BPb88rUE6gLSxHJZKMUcFOggoolXyXkX9pv+?=
 =?us-ascii?Q?/xDwWba5OEBVQv+CxJJoL5WWOBa2GquB554VSJ9xFRiD3z3RyVSBdtdso4XE?=
 =?us-ascii?Q?j7xC5+wS2WumOem54DiDIObKY3HVCLLVdVZID7+1fJCOhvCRR8iPcmmEj95G?=
 =?us-ascii?Q?DLkS+8kIfPWLsJs0rLxXTJgC/wIJliM4BSRcCGcjuuPaslC9V12lAy7V/3CZ?=
 =?us-ascii?Q?42foSaxrbpfCZZQYLEyF8gu+1xVGJGJbcPxSsoG4ItKfDBtH6TjuLU5PrTQc?=
 =?us-ascii?Q?h35Xj18U6ropNGq9VLWzzgIk5qqmF/T07cW2iJHwpQZROehh+6duRCimOkSZ?=
 =?us-ascii?Q?PEOD5XStg5oVQA7zpqMY/WlgPjmlIdktPB3mvx1SuUIHf4MKFCKEb79W7k5p?=
 =?us-ascii?Q?CgPscbkVaC7xxjVv59SVc+GCDUGeeTJMeuBjzlfYqFxI+4bGtp1BvmXCVMX+?=
 =?us-ascii?Q?yygFjZcYciTjh5T5OdfHq4e5m3pZltjLhuumVgud/QWgl+WFYOht59TGsXe1?=
 =?us-ascii?Q?S4Du/3DS13UE0jZOkBi8niBCVzxGsllm0PmP3WHP4ulfWypmcA7YAvzHgpbN?=
 =?us-ascii?Q?Rx2sfhYOFiZ6kNACOfYqB+/Qj8IKmWjtxpZW/uPiIhl7M5zR8+C+27FPyU9D?=
 =?us-ascii?Q?EjCW7D/MPlgcHOA4coO/NuI+ODVIi9I6Mw/6MGb2AiNrtj8Pl/s967jo0bie?=
 =?us-ascii?Q?TCF5jUljLdx1huqhOg3OUjUTeL20r34bbHRqzXA+W9CVZL6RyFNUZ2ubEEgr?=
 =?us-ascii?Q?OeR98wgFpQsIc7Wiqwl25x5B+8aSt0yUq/SMNMRz8hLyDlRxmAQB33o7CgxX?=
 =?us-ascii?Q?DUPBMyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/U5lKtWiI/xNRtlmavz72TysPzsHqeoPdzBIZgfbjwIG1pZ59dUwnWjXz+AF?=
 =?us-ascii?Q?LW+x1zXy2OveI4Oy/tw2wpAi4leV2Rw98x3CLvwmb7Diz9L+GNQHZTY157cZ?=
 =?us-ascii?Q?bIYe3kErZw6iOTp3hQ1/bG4pGBGDfvkVKlKTDLohj3VE4WlcFvGlHJSGvW0G?=
 =?us-ascii?Q?smq4dLw7fvAqId/VSZbwqFKtLR1fpHYUsJxTR4fiZDnIqz5uacJxEX27JUR5?=
 =?us-ascii?Q?CXAgl7Ky+25aX6lF5yLDsSgMueVhtyl7gvcj9et9o3/NlVkg7zYT5OXJ68TU?=
 =?us-ascii?Q?4dMlaoL9sVB+A/dy1qsUyqboBpQT441ToZ2rPtMHbijfWfp/DS3T+YMPnazH?=
 =?us-ascii?Q?7IdGmoN0DIavLgch5mGjqjRWQvPs0QTPKM8TP16/lEhe1Vwbk2/O39MBqzpo?=
 =?us-ascii?Q?Cw+wsIVzztd+y+L/CR51QkAHy6uxmh+zTYodfv28hwGx46+vX8JKb+XsLc3T?=
 =?us-ascii?Q?0/Qh8zek9cpZmo5bXJSscbXPcqbArRik5osWaeJyX4NeQMhvm+G7ka7NUnB+?=
 =?us-ascii?Q?pOTtyTalW8c5sqnHfCfwOIX6cNTXCU4Ue3jxqSBtotCFm42igKyE4FRUdLt2?=
 =?us-ascii?Q?milyjpvFBog13l9Sqr1ifB+EPiXYfGIZmivk4GFfli+ibU50OKJfZY/6ZX5l?=
 =?us-ascii?Q?ciAbtQGCnFlrISfxEW4ikMJoIRTGJedP9nfmzmyFH3NIbs4Zdwr73JZoTc4k?=
 =?us-ascii?Q?QBTNGgVZXyuixbyMOceDkD6bh2qyPEicOvpmNVt2aNdd7O3c6NE+2uKLY7+I?=
 =?us-ascii?Q?paVfs1OQkOrUsNw3Twm1CCye/JD0uKIHvfHdXnKL2Kg9Xyghlss95QJ4D6lP?=
 =?us-ascii?Q?bq7I745MNcdVHyh96DeyYgUzDkklm6N5WUIWXTbUlNiuE58kRRlV5eBphvW5?=
 =?us-ascii?Q?I/vqZQTpCtCZp7gIq/ynGpeslriwu9zoLrIC1ZeV3aBPt34Fp5aeaqVfz9m5?=
 =?us-ascii?Q?LEZy7Xm3ZI9KY4Lu+E9aYnWLg1phRUnBDvi64E3krv5MvaoTcOiKhNwLmmBV?=
 =?us-ascii?Q?wjOzPv8riKYhLsdZsTbZXZKA6+xkxtKz4ErkSJXzOf86s+Q0A1aGWtbIETpy?=
 =?us-ascii?Q?8pKzxXGOWEOa4IuXrcsK3Ilwky0mQ/Exd2zCqWumGma10Hpkh1aYD/pPLVRr?=
 =?us-ascii?Q?2QPvSyt47BP2X7iEX8/S3ylxwsCKUqvtx6phNLOnnAhNg/xT+bu2pv64UYwG?=
 =?us-ascii?Q?Qg05zZF13ffdYjKURsX1tBLOSese0FA5SOcxtyu8ZfKr/If72bPM0C2IJ/MO?=
 =?us-ascii?Q?PpboV6jiYcWPFgf0g0eL1uwdePqUtSbRVLcAcZLsRmoxVo7F0TzosOGHcho2?=
 =?us-ascii?Q?v04MicG/U8R8B7g9HttK1TkrpvbGm681HlA5viLFhTkilI9V62WFoe+SrqYw?=
 =?us-ascii?Q?+aWiSMzYuEasCEzDFSr+qsoOYp0HL2hNnMNEgHEEtVSWo3brJC3DkRsGPbIk?=
 =?us-ascii?Q?2Vaibenvb3INFVZho1JkFeNbPSgJo6XfVjv+FdASV6ADJ5fYmWW+qEhObIbv?=
 =?us-ascii?Q?JnIiD3PRFVp8wuJuDfhRKKrQwL4BxQzHZBMuGED7gSMrtd5VQvpIzChshucu?=
 =?us-ascii?Q?CsvCxgWk+0eQSt1Gw9fPwch1ykz+jV6cYxgCCF8o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3c5643-acee-48db-bb0b-08dc86f55dcf
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:25:58.3369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YHQ5ptR6K/PqHdm5s+oNQ/0aP6m2yu9Hz3bQ76VJM2WstaDGgkaLG8n9qJH4xRZaQ4ggJmp/nv6Wa5DcULHEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9020

From: Peng Fan <peng.fan@nxp.com>

For iMX8QXP and iMX8QM, add bypass clocks and register some of the LVDS
clocks with imx_clk_scu2 as the parent needs to explicitly set.

In order to make sure MIPI DSI works well after suspend/resume, the LVDS
pixel and phy clocks must be initialized before the MIPI tx_esacpe
and rx_escape clocks. LVDS phy, LVDS pixel, tx_escape, and rx_esacpe are all
on the same MSLICE. They all share the same clock parent. So, setting the
parent source or rate affects all of these clocks. In the LVDS use case the
MIPI tx_escape and rx_escape are not saved and restored. So, LVDS works for
either clock initialization order. For MIPI case, LVDS must be initialized first.

Signed-off-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: "Oliver F. Brown" <oliver.brown@oss.nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 7d8883916cac..a0654edaae83 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -71,7 +71,7 @@ static const char *const lvds0_sels[] = {
 	"clk_dummy",
 	"clk_dummy",
 	"clk_dummy",
-	"mipi0_lvds_bypass_clk",
+	"lvds0_bypass_clk",
 };
 
 static const char *const lvds1_sels[] = {
@@ -79,7 +79,7 @@ static const char *const lvds1_sels[] = {
 	"clk_dummy",
 	"clk_dummy",
 	"clk_dummy",
-	"mipi1_lvds_bypass_clk",
+	"lvds1_bypass_clk",
 };
 
 static const char * const mipi_sels[] = {
@@ -223,9 +223,9 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	/* MIPI-LVDS SS */
 	imx_clk_scu("mipi0_bypass_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu("mipi0_pixel_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PER);
-	imx_clk_scu("mipi0_lvds_bypass_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu2("mipi0_lvds_pixel_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
-	imx_clk_scu2("mipi0_lvds_phy_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
+	imx_clk_scu("lvds0_bypass_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("lvds0_pixel_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
+	imx_clk_scu2("lvds0_phy_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi0_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi0_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_SLV_BUS);
 	imx_clk_scu2("mipi0_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PHY);
@@ -235,10 +235,9 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 
 	imx_clk_scu("mipi1_bypass_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu("mipi1_pixel_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PER);
-	imx_clk_scu("mipi1_lvds_bypass_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu2("mipi1_lvds_pixel_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
-	imx_clk_scu2("mipi1_lvds_phy_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
-
+	imx_clk_scu("lvds1_bypass_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("lvds1_pixel_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
+	imx_clk_scu2("lvds1_phy_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi1_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi1_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_SLV_BUS);
 	imx_clk_scu2("mipi1_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PHY);
-- 
2.37.1


