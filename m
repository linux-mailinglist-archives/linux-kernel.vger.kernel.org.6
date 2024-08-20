Return-Path: <linux-kernel+bounces-293769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E61958453
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443FDB27CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0DA18A6BA;
	Tue, 20 Aug 2024 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QHe2WtO3"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2051.outbound.protection.outlook.com [40.107.117.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5AA18DF82
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149393; cv=fail; b=He2GxOOWmNBO7Yi+nfbrhMUgpY19t2/PW2mRqIWgerrj0SXbapzmAqiFua81NKgr2FjUsEjQrBj2GCpXqnKIXKUzZeS0nx+NUeCBb6BhhYka+NvZMudp1ih7Ph1IO/mAXitXgzFP3K8S0umftadYVsqTuNmwkATg3zTMqhfw8R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149393; c=relaxed/simple;
	bh=Y9iFEwV+IxgT0/OpUZ4sAITCpTUTr9tOkVMvIhDNTfY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X9SkC4vccYB7inhAtxOdx5VIvIEJRj30tTCfAxGVgrjWcgX8QblJN+3sGVi+3GiNIKUgzt3E30kiVQV++qnwgJzsmttcZl8x2t5kIF754JToW+cBO62hLYbf/8QEEU7uCVNnynPGMd5d5MxDPAWJc+MRFnntB4Hz8fcbNfQWI+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QHe2WtO3; arc=fail smtp.client-ip=40.107.117.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rn3dJ4BEQs5om102nEt37A/SFx5lXjgvhooUSm8HOg6TkF67zPg3OtyueEGj9+1/ue87uEk8vBtjqj9yccCcQ6s0WsDRjl17GHpIy0WhYyIEwLeqY9VTNNWcD4BGCIRCIddHrJkTk8aOWRLa1lpacPZf4YUtkz0OPVPfwbeDDGRClDQ7kgckjlG8waFx5RwvfVVgFPPdR+GMAeGxUKukf1+fd7MHeJr7zPpbW4CSmvLf367wQT1RQ//dPTcVxnPIshRPzQrSbpGePRHhPEl1ZyyxWold6K5pwpc5bmXVekiuOM+Y8XSD62FlFSEXXpF0MaH3pqDFc06bwkS8+qE3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1ImVLsj9mC4Anu5h7Tynm7FHhyFaMdM5TxNpoeOM7w=;
 b=jTYuOOgao2MfV0Cp4FLDtLaYhWUHotRZRvANYa9jr8ougLIy4E2vQGlOXtfN/lhizfGZMsABhlbfNonjgmuZD5pl633byZzxncMvqmk7p/BmXsreLv0My4aTEYB3YocNoLX4L/Ndh2Rjv2T+Yc5TqjKXEL8scSGtURCFPY9a4hborYhrW9WFEnytkcIW7rC2kO+LCKI8LrtM6rSTqHo7/s2m/8thH+thuu6YLa49OH+tbKGAAO47havhc1EFeteo8iHt7YfzcinQefjL35JWwFLuZ3clC+DXDaVDbQ6U/IkQ09LlfGCwi6o+MnVsJtcWttZgyJsaBUWSGevUKzS5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1ImVLsj9mC4Anu5h7Tynm7FHhyFaMdM5TxNpoeOM7w=;
 b=QHe2WtO3R4bia63VvOT7F9kYcoZEka6JXt0x2xMwUHmHQkvwjpvdiJhnriXW4ON7itbtNDKKb3Nuj6wxSchgpv1lRzDa4LOUdVogXCwaCqywJQbB/pc34vblLwetVLIzB+n3Evhs49GVZjcXNEUnbrXd29DRX6LzhsPiKaiZjJi9aX/00eOFOGeK0FnlImeF0MpT3m2vkSjN8d5Ucpmubcbf8ZmaOG2BnPgVWIGx98rx5kUP1pDa/zxmZ2Z6prImL2EPbxNBEvPBoaQx8+mL2ismIny6D2iQ2hBOcL7DSVYPU0jDpkJGcF798TBKyVIK1GxXBKDdg9k4/q472z7l0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB5247.apcprd06.prod.outlook.com (2603:1096:101:77::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 10:23:05 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 10:23:05 +0000
From: Huan Yang <link@vivo.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [PATCH] mailbox: sprd: Use devm_clk_get_enabled() helpers
Date: Tue, 20 Aug 2024 18:22:54 +0800
Message-ID: <20240820102255.132605-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e634b1-219f-4f2f-4475-08dcc1021462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n6J10E16s2NDuO3rvMoRlvW9KxbHXIShikYmgOb7g705BInapnYPSZ+9tAqt?=
 =?us-ascii?Q?vE7N4XqrcVBNWvIgKFrpjAGNs8ThJRfo1hReGR+4G15XSXHRkd99OJpXDUGp?=
 =?us-ascii?Q?YWCZaxFxvWvaqq2I8WWy5VigQVgEUKWZZv/BrFi3gmSUqMM/SoE5zkmXumRc?=
 =?us-ascii?Q?D3diVmpBcBleN3jkZz9jhduCSRUnf88eac+L0QEgSrrU0Dcs8aAaXP4qS3++?=
 =?us-ascii?Q?qHDClZnYw177oWk5q8xePFbdmszRbBf1cKXWuXvCjzPqBfkGUc3C49VMk33E?=
 =?us-ascii?Q?2vs5kbHZ0o6Mlq571Bv16kJGHoWr0USMVAY7NC+LEch4UOhKgGhNKDpJ5X+j?=
 =?us-ascii?Q?wy/z9zTx3HRDy3/SR90Lkm4VO5mmphTTFDEteBaeKbFXe1wcTUkJb+oBexhq?=
 =?us-ascii?Q?gK7wpLU3zQk9845N0un/CYvk72dGQ7mgsTXUp699n/CuZCIZPS1X65cijW76?=
 =?us-ascii?Q?1o8Aahdo+TD+z/3a/gFAXoo5XIZT9yZrB8KxiocmuCivzyyIvRBR4iFhMKzj?=
 =?us-ascii?Q?Z447laQOswBI2RJVldQttNPzLL3WYsoVm47ZuXb/VPdbZZzvXwSP23wNmpen?=
 =?us-ascii?Q?qEnSWJXXeeyf4W/v03zL6bJ9AGwfnnqN6z+Q7qXVHsEYeuQ4HZgssjfaLelN?=
 =?us-ascii?Q?nAHpzOUxSGtAgM1LjsU4INwhIZNiWcGcXQzTgynSTKQQmgGmm31GKrUc+PhB?=
 =?us-ascii?Q?y6K5+dvY4QHFdj2n3eWzHy6bJ5nS82C6CgWuKN0bUt1ygroam4NKczZLu3hU?=
 =?us-ascii?Q?bJ09qbZeRs6KhHncb5SFT0eT9gA9tyENx7vLh0k6e6bJ3rn8RNUoAlzcs5UA?=
 =?us-ascii?Q?/y6WpEWYgYtKP5UwRFTLO5DED5aMKz7Xo49JsGIXBtsQ5UlyFkYwi/6M28eI?=
 =?us-ascii?Q?Izy8Fv7grGNh7ex7fSU/8mN1RD53r8eqID0ZpkM6IniuM+COKmmpAw8D/oG5?=
 =?us-ascii?Q?hhMrelaPR3QI2mgSfWaRnx2DeKshS3vfTT972/yUEDTJEcwpy3xyB9ss/jgt?=
 =?us-ascii?Q?paM7/RYjIy6iOVpOkWq1WGHi7AMmHw53qUxcblm3fFI+fZH3ZybiRAjOm2e9?=
 =?us-ascii?Q?bv8tJYq3JAWjyyD+bfyhAhjzxRg6rSVOiWjrij77PlLyFbMKEcuTUsEkzI8u?=
 =?us-ascii?Q?d3u0VSXd6TGIG/LadYnGwr6O4MFes8nICUIo/w9aKym0R5hVgUizqaVoDRl8?=
 =?us-ascii?Q?CJ2w3oj0lB5WlrBCHUj3UJgvvDAhzrx8f8qTFho+XfYlzRDYpyjvFSmh+Ycw?=
 =?us-ascii?Q?Ye3lbxY5YXp1hSDy5HViC0Ne4nCuHOveE4nPnowJ7U4kwDOdRqV6ubUQtehQ?=
 =?us-ascii?Q?VrxkgY3LugemooQZtqw6YMO84m51grHVy6YorqlenOmOtao6IHY3S62/GNId?=
 =?us-ascii?Q?4QHl3T5QSE2+qa5bnsTAFRanjnZNWJYwPEEu6Dla+paWyPuKFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G/Uc0VlXT2R438KU8inlNitk4k/Y7HVXrZMt4xljGmaZm2mF2pJdmAAoDTqW?=
 =?us-ascii?Q?2R1M54HGsvLM00IjLzIxugNcME2gag+VbQWwEiZbNPqdkqH3bXTXzi/xwBDl?=
 =?us-ascii?Q?ZxPPYmb59aGXakDu9Fx04mvq4ZUMxMCCfPViOhPAB2XwT+Tzo7WsGg/s0NGL?=
 =?us-ascii?Q?vs8PnKkYsAVeXeXvuEnlp56JA4Gz88mxMtyLCvxdXeWCqTdZ0v+rFoBQuIo3?=
 =?us-ascii?Q?gJSND3dHSahGAg/vQdeThdF6rAMgDlLqBqgk6ZK2RULKrXWKvwfGlweLCQwd?=
 =?us-ascii?Q?wi/E0E0Kk3E+pFwcktgeRbuQkJgEjhInYfShluMVqK8uvt0KFFaSoM3v6eHG?=
 =?us-ascii?Q?F8oawYCgf91rP5oNnOT1AoO1TS4xap9xG6XSybuChbuRrATHMEln1h6tGfzD?=
 =?us-ascii?Q?6DYv/EgFrgU0rlMsVY0NeQZ4IGCA8vuIx9voq3P7A+PFtRNjWpqSjapuFa3K?=
 =?us-ascii?Q?L3XuoYDgSGjSIymUg/N0ghFhbPA9jHrfDsVxVp3B3dx1uD2j8dGV4LFb+x/B?=
 =?us-ascii?Q?Otbe2aJnuAFwD6xkU9RiRY0sP89apu8iqJUnw2QHQXlhpKH9FnEJe9ITHORH?=
 =?us-ascii?Q?BZ5PpNfBjXRcSGb/QRB9X+I2wdJCcZsrfmTeU9O30rSN5ZmChjjpc/4S/5Zj?=
 =?us-ascii?Q?mvM84WHXnDr2z0g33sZ1PhR0qbfENHYp71Kbaer1myI2Xeb9tiBkBPETkI1p?=
 =?us-ascii?Q?KCvbE3bgnr+DFXjcM7fPPMphxu8VMoDVd28M0MRxXFhQnjGSA/hM38st6ZAp?=
 =?us-ascii?Q?a5guFxur9GWXrba7FQRXI8YKLU2L9WrBlGwPIYL3iTCM0c8aAF67vjGvSxAW?=
 =?us-ascii?Q?m6Hhiz7Eh19Cq0aLxXbPQrLKbdVlQCXFNINXrWzXpesagzPzqh94t9IQ0xh/?=
 =?us-ascii?Q?oALTNtisOYJI3FLc71ZlTQEUogDSg81TCZ1D0zGavEoCnvym28zv9mmXPmVm?=
 =?us-ascii?Q?QBmo52YUSYMLe3jlR1JaiKdgTDjj75PYLnib6q6NQnUonjQN7ktdxH9b4M5r?=
 =?us-ascii?Q?QLjtsFYy8c8/pMza7OdxKki9C+I21IMB3ankN7/JE1pSsowyCxMGBajfrbgG?=
 =?us-ascii?Q?Q1mHsCiL/WINQa9bk+uXnOoZVsSvGS+V7zwlgGRop2GVSgcy4UinN3a814e5?=
 =?us-ascii?Q?y2kiTz57qg5C8WlTiSj97kS8FkxOxDpAEodk0EqYRCwwN6I8t0DaHkD2PD6t?=
 =?us-ascii?Q?qCIwISKVxQJcShpsE3xX90CyeIhtMGA5gCRqZyW0hlTvHsjP3V0aXbZGGdH9?=
 =?us-ascii?Q?67NikP+agfIO/IrGy2YafoJ2CH5krUfUUS/5utyHAJnSKyOVXhhJjyl1LA7N?=
 =?us-ascii?Q?vFv6z8ZBEEr7wW8PE48Mv9+v1K3U9V0JvEo5DybTLknezgrMglI9mP947gqK?=
 =?us-ascii?Q?BdMNQPiMAm1zI2+QDogOo9dTk/TYhVauWGAcvZLhqW9PrLzGZCSfstIZDRtM?=
 =?us-ascii?Q?Z6CLdwnhyQ6MshWyF6XnCZLrVTYJnXyTIb85capH0MOWq8B5IcmjTUoJ3r+g?=
 =?us-ascii?Q?TTkap2+3c/1M0XchhtjGT9ktN9CwXMHnFHR1IHJhhY+iuvdRGzc950B8XaSm?=
 =?us-ascii?Q?f4KSNeJWdQyBFLlys0V43UhJZp1ZeiHkUi5cMjTC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e634b1-219f-4f2f-4475-08dcc1021462
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:23:05.7104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFQFQbMU7OEERKGAPRSZ+ikSUHEoSoyQfjSNeSWAluoNC7E6Z5h3uCKODd3/LTR39o7pelkHY7SBKOQbPIqNlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5247

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Signed-off-by: Huan Yang <link@vivo.com>
---
 drivers/mailbox/sprd-mailbox.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index 9ae57de77d4d..dca83026928f 100644
--- a/drivers/mailbox/sprd-mailbox.c
+++ b/drivers/mailbox/sprd-mailbox.c
@@ -291,13 +291,6 @@ static const struct mbox_chan_ops sprd_mbox_ops = {
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
@@ -331,22 +324,12 @@ static int sprd_mbox_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->outbox_base))
 		return PTR_ERR(priv->outbox_base);
 
-	priv->clk = devm_clk_get(dev, "enable");
+	priv->clk = devm_clk_get_enabled(dev, "enable");
 	if (IS_ERR(priv->clk)) {
 		dev_err(dev, "failed to get mailbox clock\n");
 		return PTR_ERR(priv->clk);
 	}
 
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, sprd_mbox_disable, priv);
-	if (ret) {
-		dev_err(dev, "failed to add mailbox disable action\n");
-		return ret;
-	}
-
 	inbox_irq = platform_get_irq_byname(pdev, "inbox");
 	if (inbox_irq < 0)
 		return inbox_irq;
-- 
2.45.2


