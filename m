Return-Path: <linux-kernel+bounces-296417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0F795AAC5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C20A1C21D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4607B673;
	Thu, 22 Aug 2024 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="o+XXvd4J"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B0F848C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724292015; cv=fail; b=EcyvKsXmHtHvKMFPgFMd9BIFTYWLKnc9z0T1vE3p7/rOMlB/mgrAc0uPdFThCK+2IWQLFSCvR11C5fUC3E8E3+ZkHxdNtUVjUMSs3aHWQzNJzrdnB+9pREL9iyppx0ayW+qB6sRzXELOOSXK7pjsJDV4fZQCXXlE3cAR8G+YwWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724292015; c=relaxed/simple;
	bh=nhw7UU/vK83x4u+GywzHztcAAHz8BIpSp46t+7me40A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mpwHi5vrrxsAvII7fd98JwaKg/HpTLgq29uJZhsL50k/KBw4WprVBxw13goeuqkYdv4NQmlbCwYX9SPDI2saPyQ6QytqOAXAZ7lFITQOJj+WpazUNMGlXscN90/rky9Zb4aEyxBKYQ3HSTfblPkXgA6Pdoau4EREVOWp+U4QGQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=o+XXvd4J; arc=fail smtp.client-ip=40.107.117.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhuGmfnATxO7hYhoCcqAsNx1k/RXbUaGptMCzPOCBtysREVVJ6VrzOWbWweLt1IjnY/ToDHA/4vuqNJ9aysyBbyJRK0Q/ahiHlIGZPBkZghPm26EQvfwMkh2EONj2dI/sg9gtUAuG6Cg1yn9VIi7Xj+xb+82w1WHVokRHwSJwThzUygbHCg0iz/EZ2Ece3hMnO9UPkVUk9BzAorYGFH2PK7m3dR7hzFlHZRjZkRMVN/t7P3wdrFiNlZfDoSXXQeI1AvtXuVnJYcEilHdEDH1kyh+V7gqFTY30Ngf7ChJ82BOsp74Hba46Cu2mbYqSbdL03Bse8peZzuaXKBV/8WA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdWP9PCwJJC55+9OUEG4fR5VKWlal0bT0Y1LaL0Fwg8=;
 b=i4cW7cGoFhFyUZ8xG4EGiWwh/cT+j6sAmiU7ND6v/5IFdE8cIVxBb8YsXsLaeE3uR9a0BLvZUuYs5xkVlSjst6v4KxZD+OOR6wBfesWYhA7OJyGPpbkzjV3/5X7B0b5ECXX4lAqr6LmjRHINzh8mPurVFUz0JtwbyQ/W9ceb95KPD67AJpXUJISS4uWj8sJKtT8QSgAPCS1kQAHrikLSDdx+jlT8a88GdVatrgG7dx2jijA6pZP7hzkTXu9Y31sPST1sYC6KYi47WL4aa95ZGR3imakNkpyuGFx8Uxc4QNsqVFRG6iJ24Oh9Eo4uhzbXOL53lpcBKddefrKaLPpOig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdWP9PCwJJC55+9OUEG4fR5VKWlal0bT0Y1LaL0Fwg8=;
 b=o+XXvd4JztYlEdoTp0YHQ5ixquZg9j4CMDMZmaS9mDHiqJzt4rj/GBV+wnf8IbVSWRGFEGZLCwM7E/gLrcp9Hs56ASRA0zy2IjDLEHCGjxOGC952ZsPIb/seXC8+EStfnoJ11Uq9QSfSyDYIrPgDXEN0O8NRAdbxpneZKB9fg9lUkkoD26LmcEGsLAZbK4OlQ86GBLhFZuxFsfqUJt/oibar5SfwgR1DNehThmkbVGycD2/gbgTCkloXGnyKtbhzrelO7PRSAgs7HNkQ2tuQ15g2t1ziTqTvz4qT3x/0u1NsXPl7zle55veGGVZb21Vc/D0N9NHnOgeOMfEHcjmDZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR0601MB5654.apcprd06.prod.outlook.com (2603:1096:820:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 02:00:07 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 02:00:06 +0000
From: Huan Yang <link@vivo.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v3] mailbox: sprd: Use devm_clk_get_enabled() helpers
Date: Thu, 22 Aug 2024 09:59:55 +0800
Message-ID: <20240822015956.468945-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR0601MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc8355b-3546-4cfa-6290-08dcc24e2505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hgLFoRGEofNWNa3J2/FsfPp6F/b0+htYC/nUYIFP0eCUoffk2pWJvCpse6nH?=
 =?us-ascii?Q?vgtJO4ekk+AKKdLLgDG9ZpM7FIP/+rYMYi+5u0yM3FXKQJbvPOQ8JRKfQp6L?=
 =?us-ascii?Q?A6aTlTtYI/tGP1ZWhKQumHTGHXigT0esiP+KMTm/DUlmmjaqjb+Q3InuUWPq?=
 =?us-ascii?Q?1giKuGejbPR1sQAuk1CpZEZMrph8CipxXBvSvjgI70PiYjqiWg0n218s02hx?=
 =?us-ascii?Q?zF8UVyR4zVcfY3NKZViUcnw1GLIqLtgzwL7Z69SiquRxRZkkhRYto/Lclf+l?=
 =?us-ascii?Q?OZA6cME2O/+ZuWdH1/iPPHvQS7zNhei/13ms4aHpACRtk7xSm2mesQL3pEHX?=
 =?us-ascii?Q?ZVAHqO8nRTFvVHxnCv0yYFkBtwnpgT2+ZYBkm/5s41V9W6U819hTOKKPhDNu?=
 =?us-ascii?Q?dDpYqMKlrBi8jUAESd6k7gVXa0W9otOd8kOdyYx+owQWrM9d94BRM+tPOlfH?=
 =?us-ascii?Q?Q68ffTai2hikMmwCj9/TJHrVd/Wjzq9+lLzJee6uIcFVxiKwL/EmP/hdOGgu?=
 =?us-ascii?Q?N8tCv2YQPMUFmLrqpfsgT5BXJXIWYM+npywwWOwtm5M+NYm+GhARFf1Wzwgj?=
 =?us-ascii?Q?GxubHMF3QAkqm5MbZQSkUPQ/AXdXBrSkqrCo4ewxcfaDtdQTTdG9CgaNDh23?=
 =?us-ascii?Q?o3aPwPzIU94QxyVefrV40Qb1a3zKeW2Y7H6DHeo6bkdcf9yEJstLO+G0I177?=
 =?us-ascii?Q?VV6CrElkuERFpiXBgJ9wUgn22g0NnGJWzic2VOksSBCm9U1hhD+LxsFwNRM9?=
 =?us-ascii?Q?hc7lS9mnOgW7xtvXMWZ15+IFiDaXTr6IMyNsxEXwEXHOlGsPb9QB52yeSsCt?=
 =?us-ascii?Q?4f9QJfXpCmfszsMEhOb7k/wZQRga1sbAjtOu8/igg5mJLjZ3SkxBTFQDF/7k?=
 =?us-ascii?Q?Cj0tJvPKEz9ZyEGoBpXG5ml3sBG3WeHjnp/GEIOvM4beJqEwDhoxXDLLOfAi?=
 =?us-ascii?Q?h+9mJaBwgyqjyTP06bsKs3NPe4OWSkcodkHTd+zn4atSpBwQSoOD00NVHU8/?=
 =?us-ascii?Q?CXWUoqyBJXTxUqD2sf0PL2WlmcJQx3/RT71IO4mR8dfMvDcVaKKgtQ5Oe+Wi?=
 =?us-ascii?Q?YaR7DkidI7lw2UdKqcIBD9YFUNr4MoRbMBqSY8bal7iOhJozyUc93HWldYBs?=
 =?us-ascii?Q?3lBWQJRjNa7j02A8qwuisvexEBOQm+T/nX3UCzPdKcyMnvHOllbeu0CB70y2?=
 =?us-ascii?Q?qab+ZvQk0VYTgwMMFWzD7cVtDuMzHTVMUMP/wI5tBBJADRIwMNsoFM1laGnA?=
 =?us-ascii?Q?yHgH/VhnNKFCSCcEIChzcAWi9LUsweJrlyPj5NIs3j7cCfOrOoJRuU/83gG+?=
 =?us-ascii?Q?Sj5d8MDX/w2CUZfF2W3kY/1HDH8SEge7Qn/RQ9yG4tG02xhaXp1LcMtZjm00?=
 =?us-ascii?Q?eh/KRqgf+KRMNAM3mp5fEKD+rCUA4Pp1NopsyxSHYvV5F/9fwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ym2YObz33zXORLDLO+2UEd/QWlaI9D4Y2rVVdk8IUbWc2HcH6x2R3Vgs6ocm?=
 =?us-ascii?Q?FjTdu9u5mQ8nZfOc0F991laO8LSIE0A9iZ8T/5Jh/DForq4Mj/E8uV++Rnx3?=
 =?us-ascii?Q?RIrMPxM93R1UpaZrokMDoeBSQSe7GTUCazWDfS4rNP5tbMdaEdeSF6xrnVCk?=
 =?us-ascii?Q?qiCPMbM4Cvpmz4mmQrjub4Y0CIp9IVJYPcFt4QGZOAyZ/wyFT7RK8/Kn4w4L?=
 =?us-ascii?Q?olOcd83vELoHucLYn6Buz6L9tMIwyOcZPfogsdjtTNRG2EigNb0685mnK+S8?=
 =?us-ascii?Q?5SBiqBEUWrz1mnjJCRcRt6Fnk/pDTDu8WPgWxTWhxPJoKsspi5bLnVD3bq5W?=
 =?us-ascii?Q?u7k+x8tEWDAxOpnFOC21PMe9V0DPMUSEL/cTLKeck/ZGnLOF64Bj8FRpLWtq?=
 =?us-ascii?Q?ICmGz85itdOwtRayNfQCpra6HhWV1dhtIjthHCc/q2tqQ2qEUeyKtcSAzgFh?=
 =?us-ascii?Q?hP7fVCBNA+Ygwj5FIyzrgm6qqWd4Pw7n7ejrwr/GFv1Rg1SjGxhq7hRhbQaP?=
 =?us-ascii?Q?y73MuMx0o39F2aX84BU5dlgUUuR/vp630Wjson8I8tp34Gc0dZFhSipMKWql?=
 =?us-ascii?Q?1GmoDMfB1QFk3deucVOFxQBlc/aoWkrzb1z4kXnoR08XA/DsF64VWYVNFexA?=
 =?us-ascii?Q?nOEWakIi4ZOULLvpsYL9bMeaXJagRK27Ad3B3AjTRdtnX9FFElCTYtr2W0OK?=
 =?us-ascii?Q?nQEuEkXjWvfGGhUkpJ1EaQ9ei+In8F5PQ2m0fTGNhKdyCXnqagRpmcdgYl2+?=
 =?us-ascii?Q?lcxkn66d6z6madU4g9D9T77kwIer6cY3fCtTXTNgJsBwtOzDu/kOZ7NA/Rxz?=
 =?us-ascii?Q?axSvizTa/diyGal8Ph722QFQMfBBa04h0gWLKXjK5eculg5N/kuztWpkiRtY?=
 =?us-ascii?Q?R/cbAosvF3j2IP+W2MNUz7/BBefTPPq35EUvPX3/TRiyH/t4BtVsBwk3C8GK?=
 =?us-ascii?Q?AMzUtDYFV+0bEdBWjiyC5SLX9AAM5pcyxWUrb06Z0Uhysc4CIPLx2hWYzZfR?=
 =?us-ascii?Q?mNTwqseOFEQ02kOEFkpcu/if10RHSzYKE5sx6KsvULYQ6h0x4o5zJ1OIdN4d?=
 =?us-ascii?Q?SrdSYI0Eqwnou2XLs0FspJ4VOobBzwNNuyUqkyH7omNRP8LvEGC8hDL/duZj?=
 =?us-ascii?Q?Wl5CiDNuAsLhr3AG+K7uExsfZuBXUR2A2deZaxqFXtfsABA03LlRWNd/WqYY?=
 =?us-ascii?Q?FEoPYnJslU6zAATWrLHILCRFT4AEnKxF+aRLAVrCkYLDyVeECXI6IZlVop8F?=
 =?us-ascii?Q?LNOiX8fpjdOUXGd6jHZMgsp0x7lnPhXzABybugi4JtQQgK/QaEXR3nF4tpII?=
 =?us-ascii?Q?/Oohxtw6hX+7zm/Wr8m2Ee52DVXZijJ3UCkGmdtHemdYSFPTMdnEcLqZJLtG?=
 =?us-ascii?Q?scdDmAcZDgVi6qWquPbclD87Rap/vIwhVhZtXBJFPa7uoSshhERK7ttYcI8o?=
 =?us-ascii?Q?KRNbU6XWRd8kI3VbQuXB44JLN0DJvmnapmETn9RP07aO7a55QpYF3YGC/P4E?=
 =?us-ascii?Q?M4HLUFyWMrjbYhSc/g8gTNfuQmkQJcTlsEjz//cpfYLalsD9zWJc8UWO/oLy?=
 =?us-ascii?Q?K8feBzIsJ5TceZdBMscZfE+GorKSWFdoUwJwioy4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc8355b-3546-4cfa-6290-08dcc24e2505
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 02:00:06.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zm4USHz7ngRaRMn9xqcYUZIH2IrzBGbupl65xNSzcq8CoQA2HMsKqvHzij+zXmmoPbAAujNKONP4tm5ThhmUrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5654

The devm_clk_get_enabled() helpers:
     - call devm_clk_get()
     - call clk_prepare_enable() and register what is needed in order to
      call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Due to clk only used in probe, not in suspend\resume, this pointer can
remove from sprd_mbox_priv to save a little memory.

Signed-off-by: Huan Yang <link@vivo.com>
Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2 -> v3: remove unneccessary suggested-by, add v2 marked reviewed tag
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


