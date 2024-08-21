Return-Path: <linux-kernel+bounces-294761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D2295923E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7AB1F22EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4B44D599;
	Wed, 21 Aug 2024 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KbL1EOsN"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010028.outbound.protection.outlook.com [52.101.128.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AC6A55
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724204359; cv=fail; b=sJo30iP3U7o7kP9MWxy06hEWf8Ha0rd+oD30eyqx6kiip/eKKB5n6M6nQbpXzO9mWp1XbIHJtOy7b/1Md/eFum1NR+vvvIQ5Ob+mS2FIQpHotTQAPJPZSwMkHvB8yekzxKoFGHKpytKdpv/TBpb6jaSGsQ7PYDrXDJ3vvbQUSGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724204359; c=relaxed/simple;
	bh=a1S10KZbaUgIJScO7Zom7asS4irLRlqS2dQAN4kVHM4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WfLzpapAHH+2x8OAaabbuOmUBbGJAlFNvJW/GFTQL+fRRIxARmOgGEzEpBPoXCWYLxUl9OiDLWLSBdN2Wsv3eP8qLvu246uzCsp7CTBdr0ru6spn5dg+QB2hzq+4D4UUMQaip0GpIz1gK4RzuLAtFRGRH4VldODGPNYV7snSJYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KbL1EOsN; arc=fail smtp.client-ip=52.101.128.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrvW8/u88W6EOOOfP+UM+VZj98pD5tKOei6CGUcw+ubjjrEz3uhllCZ/dlwiMX2R6VrzDy9N/X96HE0x7yvKRZI4HL2T4YPIOF2jaGPMm79CNMg9iVXD9O2kPqCLgDU578pf2CzeHOwn7s71Im4//hCfxnOhTcuAgVGhcHofUJJC7eLuHlxBXrJYt6pgInSLCIBsY3x12IPUv1lR5h085+BRwHzv7hcyHQRJT6vFvTfQHnjbRTnyvzxJM6BgbULJCh1lto6ccUUNxBqB/fCjEEz1AYs3ps2+p5CpprIbM/AML8Lwi+pxCctvS9ZD8w+Z3kMNTrQyy0vOx5VH0u6rIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szJ+qKdmlIxa5GUq9/zDyL9WkAhreNrgY/dzpbTsrF4=;
 b=h/vVeelZHCYjRH5TjlT+HZdq48QiApLSwC0My3hM3e6mClpT4A7zlRnl8zrEkObzphSkb3wP0q0x/iPF60issI0auIoJnPDCQSd/QHjO5ZwQ94WImhdG6OvW3MHvoIDQtD1n3ERcv1kQ/nV/yUr9pzvvfbX3C8mXZzln6Q4lTzBp54HrRFQYHWO3g+P9Kw9iXcu33te+9pxdcLfluyK0kw+VbNqlLXbG4bIn4WfR+ane0qxIlGl8zQRrip9fSNoCYCWJhhx57S9xDXq+MztwQA0RvuoO1J0O2Q61KMNsEtRQkU5CeoIkyqYd2uG5YGQ50JQohgwQ1Hlute0dxRTKZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szJ+qKdmlIxa5GUq9/zDyL9WkAhreNrgY/dzpbTsrF4=;
 b=KbL1EOsNbOGgAEsw0GdKdDO1iaoUIU2Qlb19sKtl5Qc95MPyedvORFn9yuRkpCU2T7Pu8VY2lJfg1uR4W2gtzrqZCO8nNV0M+aOA6BnfrjG3AVavmCzxVhBrKMHEU7O2QG0KnoS1E8Pxrlol+SsCVn+Lqjtdd7Y0YoOE6HMyRPUydaIH8if7lN/RyC2PBKBzdd01MP64Dz+yngrIIbdl2+qiqAAYNPbkYC14x2DVX2BONL+jV7UC0afsQwToalY6QxOeqoI+s3X13vjIQ2KHtZznkmfAMj2MH9TsMxa0DsNEb3nPX3Dgx2UJ7qkQn9RnITUslmV0cRxyREHrn47qWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYUPR06MB6002.apcprd06.prod.outlook.com (2603:1096:400:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 01:39:12 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 01:39:12 +0000
From: Huan Yang <link@vivo.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] mailbox: sprd: Use devm_clk_get_enabled() helpers
Date: Wed, 21 Aug 2024 09:39:00 +0800
Message-ID: <20240821013901.787555-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYUPR06MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 1558bf77-4bb7-471c-52d1-08dcc1820f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pSRnEla38y4xVFa5QwBJ6VlI+vbu7bx1wbu/hbq2GNY0nb1TwetotqfrmOyf?=
 =?us-ascii?Q?mDxfBdH+9qnqcvvu+4G+G26aH1MvvvQe6YB6vOXPfL4BDDfgcKn3Kgkq/et+?=
 =?us-ascii?Q?Pij1It/g8q8soT/ecLYIRUxxFafa4wol5DvmU6Ut4NnAldyIbs3kxQNnLLe0?=
 =?us-ascii?Q?M/cSMLYk6cFhrXQdCOCmrx4pivZ+N55VuTlxIdYZ9jBT8WsipiiA+2UaMfzw?=
 =?us-ascii?Q?KBNbXCKol7yAKl8+A7q6NkHJSAijXO2IpfY427qXOI3fc0oE9SCAmiR2+vcL?=
 =?us-ascii?Q?99XFYCJGpz3mOh14aiW9Gm/DDUmvgOKJ3YQKWjaoALH46W23J8q0hCPcUGyz?=
 =?us-ascii?Q?rgDwV9FUeXqhJHfbid7kVAOnct5muqXkT/re45kfd9SqjoDYKLvqLaDFkhGA?=
 =?us-ascii?Q?XtdkskNR0558embhuPeNuFVGJlPNm1SUaK8p7UhGT7lFG83Jk/2JOkIXPxeW?=
 =?us-ascii?Q?NyMLEqRG5v1Mu1ZGtyBZo/CAVivA/YfewwdOSNmKm+bI6iUTVNoZT6dyplLK?=
 =?us-ascii?Q?xDlwwGD6Z1//T9q/QBnYy4PiGzs1b70++CjmSXUXI/axjDFfv+QGMWxvVOUw?=
 =?us-ascii?Q?esPBMt/WKzNlgQh6czGMeluJ73ukJOqKXTpoHlbZjl/B4ukkIMDVJ1SPFPr5?=
 =?us-ascii?Q?g+9QNLziR87LymZ0/ARMsQz9mmwJXYMvMbnjP+TRiMzuObwnD9CRLM+bhErz?=
 =?us-ascii?Q?nl/pHeyD8NU9jZbh2POy9O5+vOVOWLJFA+gVGo28lVlTmj1XJ4u0OeTynYBZ?=
 =?us-ascii?Q?A6MrFk9zmEa8V+8xLS1MUIs7MdM7Ye4lM15r1FQwB/fWpegBLObqXOIGBZPG?=
 =?us-ascii?Q?UZQjsGPwPhNZa8aSvTE1WFliQs6cQbMeo2IGkFyNPqE+s1zkXxS0BPo4NCJQ?=
 =?us-ascii?Q?P6SZLJ3a5mAwfuVpMUIYdXestZ0eB1ydW2W3QMD5gOGRVfLVTl9sYz5VI5lL?=
 =?us-ascii?Q?LcV2p0usk3/JkK0w8FvUY0ygVpjGxGcN6+yx1bfJH9a/asTasSIZsk/DQzdN?=
 =?us-ascii?Q?FrTLCaaCd34a0sElBbhvSj/L/B+vI9InrLuRG+/3HFMRu2LtkVoMOKihjsCt?=
 =?us-ascii?Q?O8uBaWuksqhTi1ZE4dpZfHTZv0oNlMPa4wMZxNosfxBoRTjavMWk2/CEEcLS?=
 =?us-ascii?Q?LYS+LAVZZ+7n94h4nOKPk+LyUOHPCVfmz2E2wl/3zkf8+ViQGSaizwwql7yw?=
 =?us-ascii?Q?3XKd3/Ktq4fzqD2Qtf/3H4l83lX+sSu1bjac/v6Gxge6jwBdbqIeY1j+wNaP?=
 =?us-ascii?Q?34xC/i8d0I7ImPvPlzZZyzkVEFLtyzmCamj1aHYfl1Thl/7UoN+FEmsrEVMP?=
 =?us-ascii?Q?Qsr4jOleGXg3clKSMMBvT7/kSuxfgWO6pJpjI8xWpWTlGVdOvq0yj4N0itDg?=
 =?us-ascii?Q?eKc0E9H9Lr47nQhfTYjd8ZmIdVG9Dk0U8VN42SP/D+OuyVgd1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FYt2RrrVAMTBbs1OPCdG0XWMqDdae5zoTn83thG6QlyOIKUhrfs2JEYzho2p?=
 =?us-ascii?Q?dKuSNwhV/5TnhyLT1ANC5rB8OdZwWNeK6pDXL6jcJJENkxfN1BKfXyWq96B0?=
 =?us-ascii?Q?jO8g1Qzk6L/7ESMvgidT+fPqbEEyoOwDl/Zzfyp48aXQnLHHpewkJleeF0jE?=
 =?us-ascii?Q?a5wI/wvGBJUj/sBk3EGDcGw7hyDuMcxddfdP5mA/4vUm+yWMoEvpdkrUK2Ao?=
 =?us-ascii?Q?V4sfaNmUgUElklXhnvUG22R/EmgrXj5syfCjW0Xr8vTB/mJNNqY6fWdeNc3n?=
 =?us-ascii?Q?3fCv+cRZV1XxHkDTnXqu26DD0jOAp7i9hXJtvVz+ZVvkci6mIEhsodXotwvf?=
 =?us-ascii?Q?WIt/abJeFT7C5mTip/NS/8Iw8LC/BIeRVfWGeAEtUA/pqAYy8KWGYMZIK3VZ?=
 =?us-ascii?Q?8lybKQQzV9qh6sBxke/Gs5ZR6sflZzB3WE4Mo3l96P5j8LotgL56nv9TSA1T?=
 =?us-ascii?Q?XEzsYTT7rJRWkPN7evd+AMtztDkwsGKBeDXTfrzxwrpl3pdMkgLdmIVwfH1Z?=
 =?us-ascii?Q?H476ViP+56wEQzd9O8Q+Oc1lURMdSKjcCaTRTK11i8GJ2ViRAmVQeBBdRlbP?=
 =?us-ascii?Q?OGgL3DFohrWFJY9/sv1vOMcCVzWZdxXg11Fo77KcQ4B/+WElggcyqoBOcmF8?=
 =?us-ascii?Q?Zt2vvXWwarruIIOgIOKhSygStFqhlvgwCuoj4/5sedZp4KCCtyeH/d1V3L/O?=
 =?us-ascii?Q?xdaogHlReNMDn6y9/wA7jFUL1+pgQDv0CsHBiY/1VH/TAwQXes8AY2dZyCEQ?=
 =?us-ascii?Q?GPWs46PF014sYdjLd0IShaZJEXJWmhT9YAa1LYYbeOA1r4JapfMQRZ/SXB+H?=
 =?us-ascii?Q?qky4vTV04eG54DSpsxC3hhAUCCG+/yTvpBWT5tzON6COcRp8IRBZY3+rrB0c?=
 =?us-ascii?Q?M4uSwm+wfhwLpIsFLwAcagVz16f53k0Z564lvuJW6r41N2444sGBXwXnrzaB?=
 =?us-ascii?Q?GjMzAo6Fz7vHSgoizaeVeEAriAwkeBbSSYX2pVratunoKiae6Ntl3XlKvw0D?=
 =?us-ascii?Q?aLGGg8N7ucCy1vvI8Q0X9F2XpHAsNS3CDo5CsfnAtt9KoE9lMpWTkWdcrdkI?=
 =?us-ascii?Q?j1JdgXE3/zfIoDar154ixxX+7qWGx58m49qlE5i5vRYoTeOOqh44BIuuQcrZ?=
 =?us-ascii?Q?rk7IKXiHZfiT4WuLBZQ4UfvSSNVC/7y9hTiBV0NknmNuqpE7Z78q3x5Ecqvq?=
 =?us-ascii?Q?MUW5h8pbcqw9RLDoczx5fGMXyqXBlH5RZyQyygTrmE2YqHh+xisgSmzBlNwa?=
 =?us-ascii?Q?XmHKj/mcdr1vuQGnsdJhdp/E8bM25wigw14qSZpcI4xkOX+D6dCNylCSJnax?=
 =?us-ascii?Q?UvaUClWkHe1bzPxHN6GNt4a53M1yPDsPkTlZ4xNlhrdrurwe5c9m5yZ1MqkX?=
 =?us-ascii?Q?PN3wWWAfdnVKA75nzdPuMOZVKCDdnb7/mTdRMvAqYWYeX5yf8LpghpKvmn9I?=
 =?us-ascii?Q?Xev8CGJ1VtgLRSs8BTZtQhdphXvq/bj1ycxHSaaxqJ0itzEYetKpPtGnOU5m?=
 =?us-ascii?Q?jp3uSuce9kAUlQ7ZKYbSnC2r9AhaWJHHTALxZ4DEATn+dbzOi8pKfiPYZH3T?=
 =?us-ascii?Q?pTPiLWANZQK/iTHXbrTEOeJzClZhX3SIrMZyDbdl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1558bf77-4bb7-471c-52d1-08dcc1820f00
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 01:39:12.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc6TM3UA0QlJEWaO8l/wsmpUPjt7M8XfN2mQf1CEuT0z5pNsCHklcusPkXe9DULh9tG2YesjdSyWC5Wc1fn0qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6002

The devm_clk_get_enabled() helpers:
     - call devm_clk_get()
     - call clk_prepare_enable() and register what is needed in order to
      call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Due to clk only used in probe, not in suspend\resume, this pointer can
remove from sprd_mbox_priv to save a little memory.

Signed-off-by: Huan Yang <link@vivo.com>
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v1 -> v2: remove clk pointer from sprd_mbox_priv

 drivers/mailbox/sprd-mailbox.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index 9ae57de77d4d..ee8539dfcef5 100644
--- a/drivers/mailbox/sprd-mailbox.c
+++ b/drivers/mailbox/sprd-mailbox.c
@@ -62,7 +62,6 @@ struct sprd_mbox_priv {
 	void __iomem		*outbox_base;
 	/*  Base register address for supplementary outbox */
 	void __iomem		*supp_base;
-	struct clk		*clk;
 	u32			outbox_fifo_depth;
 
 	struct mutex		lock;
@@ -291,19 +290,13 @@ static const struct mbox_chan_ops sprd_mbox_ops = {
 	.shutdown	= sprd_mbox_shutdown,
 };
 
-static void sprd_mbox_disable(void *data)
-{
-	struct sprd_mbox_priv *priv = data;
-
-	clk_disable_unprepare(priv->clk);
-}
-
 static int sprd_mbox_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sprd_mbox_priv *priv;
 	int ret, inbox_irq, outbox_irq, supp_irq;
 	unsigned long id, supp;
+	struct clk *clk;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -331,20 +324,10 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->outbox_base))
 		return PTR_ERR(priv->outbox_base);
 
-	priv->clk = devm_clk_get(dev, "enable");
-	if (IS_ERR(priv->clk)) {
+	clk = devm_clk_get_enabled(dev, "enable");
+	if (IS_ERR(clk)) {
 		dev_err(dev, "failed to get mailbox clock\n");
-		return PTR_ERR(priv->clk);
-	}
-
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, sprd_mbox_disable, priv);
-	if (ret) {
-		dev_err(dev, "failed to add mailbox disable action\n");
-		return ret;
+		return PTR_ERR(clk);
 	}
 
 	inbox_irq = platform_get_irq_byname(pdev, "inbox");
-- 
2.45.2


