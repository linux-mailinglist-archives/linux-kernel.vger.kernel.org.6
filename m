Return-Path: <linux-kernel+bounces-346353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BA498C37C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B4428261F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ECC1CB53D;
	Tue,  1 Oct 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g0LnAqxL"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70E1CB52F
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800314; cv=fail; b=t7scwx6ZqmDmtYHaMF8q4g3qtnbgGnxTKeioQDjS9n9AQ9bPCObihiqRQCyN39lfYP/nzqKbIBEGrAEefiPFhJuKgb3dCYDM7Axpr9GML9q4kVTWSN4GMYBncAF1JTDXVuHnc7lqWwN+poslC3Ov4rhwEWPb8bM2SwtT6mxqwco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800314; c=relaxed/simple;
	bh=4phIDOKUps4AQV2CZa0teoZO3X/4FBtLAp1/bugjv9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XzwalesN9EohfsKnlVLWlmujbGSjm2bv7Q8UOz1VwxQc1q5GbS+u6PNnghyefqRU6g9fQpT9DIJPNXro7T0H5Du/C4rZ36GIeofl6ITPzT7vI5fDa8RF4FjRWy8cB2VWK0G5xwdaz+F8+4A8EbHjmtXev0Yudj69XD7agyIcaJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g0LnAqxL; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWRxEqPWYQQRcFSUP8fXF7Fdw6o8Jy8p2cIfwV85rJPxQh6YGOP/YqEmAusOMI1wkIyb4wtNvlgVy9ghAXBRRKEmhGDl6VOz0YGd3LaipPl4Nq1TGM6QArh2DYSG58j3KkeMb7Uhu42FvOFc4Z6H2j/xnqifZxrbzlFOMhepkYR5RwLo2FwuDxt7hwNOvh4yYABa+fmkWwq100ddvVrEVADxKh23ApaequKEbsOGXYnE4klMTYm8gmWJ4GWfArcpGQ9tyfitp9kx5kzLrIjABqxG0jS5ZZH7uv/25OOeSVayYeeqN4Xn8JZFnE9QVfaS2V7mRtb+PqY2G3Q2MuUvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fx8xY3E18MvOf9diE4WlbJ3OvlDURnuqZr5DxknEdS0=;
 b=kqc9HESamIvvwNLf4V5ID3hn9orOdawZC7LGZnR28HIp4bBDWIoTVJxDR7VHzL03bAwL+RAJzLQLtAa6lRkX9V2a3jhMlWx1tPHL9bsfzJv9AnsS3Xr5HhKXjqihxKMeUMiARhAyjrKqZESD7xWK4MfN6yLAMSvNuytMpD9erH+s8KsJxe8QvnqLx1NQvhLPvYLaLNnHFHY0v9JP4Xll2QrpDL+MsjJyrCVu5XMhqnqty8Kxv4lyr6YGJ6fz3PlYoC+HHs9dCNx3HYU04q3Kfdwdc5+d5fnN5fKdQ/bQ2725auILhsEjyALQMD5wCPHmZh5S7ThMysYGGIlO0faWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fx8xY3E18MvOf9diE4WlbJ3OvlDURnuqZr5DxknEdS0=;
 b=g0LnAqxLClivzo6SXpwg8spmFZe2bThXYPXlfEUgtNA04p0ztBCSTTkQzGKhBftuZdW6y2V3X0DmcSZOdz6aE8SzC6xp90pcQO/yrnRwY8b7f5NH2J/aZG15S6jy6W+bgMut68Lnu7/2vZvP1DyBRrHzVG1cfb72JIpxBzsCiGw4jwzPHIvpTgJAqJ2L+/Da4LPutTWiCUMOnDTvZCK8Adnr8ZQifEWcIT4l2b0fDa8SIsxLaZG5D0Sr0pMpc5E4QwNGesPjyK5548p3CYODIUx5d4nZg9f2YRmNXGnC3mNgcytT6lundevvWHIjU6d7rj45qZZ5k4B5hnTGsfjNew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by VI0PR04MB10805.eurprd04.prod.outlook.com (2603:10a6:800:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 16:31:49 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%7]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 16:31:49 +0000
From: Han Xu <han.xu@nxp.com>
To: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: imx@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mtd: nand: raw: gpmi: improve power management handling
Date: Tue,  1 Oct 2024 11:31:06 -0500
Message-Id: <20241001163106.4169421-2-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163106.4169421-1-han.xu@nxp.com>
References: <20241001163106.4169421-1-han.xu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|VI0PR04MB10805:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e4e0b6-cc1f-4e12-78b8-08dce2368c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xb3eRpmfGy5gRuk1MVT1utVlQF6FArjQR1ni2VrI2xqL7y3etxrxQHsXM46+?=
 =?us-ascii?Q?qzuAhHajEmfFeCoA2UGpVlFK3W5Xr4P41gKN39IOoJUzQ+EhX2sHV2ggo0jG?=
 =?us-ascii?Q?mSDFq6WunoPbVsANg/bz9FuXkXKuf23z4kfUTW/d/lJneqV5HvsNjYOGXN+L?=
 =?us-ascii?Q?c2yWighXd57L5PrDY1JcW7CCV1+yYkAk5lPbiLU8x1gRKEqOehL/FQL3Kvch?=
 =?us-ascii?Q?4uTAiR87i8/mQiheij3yw/oIMvDi3y6mFbgT6G/ATsLcvI0LHM/R6iAVB0f+?=
 =?us-ascii?Q?yBz7TTalaunikYLMMHGakk2fesJoOrMi+O+p8pHsdhBjTFyCtuz2Nkt2lbK4?=
 =?us-ascii?Q?quxT6RNCSDwPYRximYrczP8/YL5wqRhkWexVB5Zfa57harOY6t7N4s6S8GWr?=
 =?us-ascii?Q?3SH5BAlNHjBs72F7ZvjZ1kidPN/DDulgNKfdfPCBpFQIEY+kcCeW8aK3WJx1?=
 =?us-ascii?Q?7jaoF3nJm79WwXmA53VEfMAfJ6VXwf1fE/Shr7EjLYDvqCm5wCdG6/UGV4Nx?=
 =?us-ascii?Q?gO6TWdOYG0ovDLHPz3lxt3qEqzMYlPBjBByMjBMl+ZGoB2AfNkDqxoHlX+FQ?=
 =?us-ascii?Q?XmD642od6NNvSmK629Wx+wgvt8u4GVuouQKV+FMATGwwkCJbV/Gw1pX7RCDL?=
 =?us-ascii?Q?mAbjaNggwiX2/NB9J3umw9c/0WCm7CAvvV3CwwirC3A69/y2MBOIyCRj5Hoj?=
 =?us-ascii?Q?h0o5nbjpvdhChCKhTHegW/fW4lIQPWlP7eXud9zaczyEkz2bIk09ox1PzG7a?=
 =?us-ascii?Q?cqGLHcl9VKlre+ll9bouOynyJr+5jsNsFOExXRgdo/8+N7Oe+BcRo9+guorC?=
 =?us-ascii?Q?sPMR2LTDTjzy1RtVQAF/FSkR8960eEQzuteHTPNGDSzuZfpGWdbD/ZkZjhmz?=
 =?us-ascii?Q?CAEbcroEu1ure8/HFHlLYfQGE903wqYibEngAv58O3rqcVaPdiEtJ9Rphkpk?=
 =?us-ascii?Q?gvQdBzL0G0i5GqTJZfPLRB+g+4r4y/lnG1VfPalx/BwGFtNJKzNK9eXGMKst?=
 =?us-ascii?Q?A5fysmvYRFMV3UublzPVefNIGFE/dVLHd/NIXT8TQELsHJ7Wb7RQXpWjZxq5?=
 =?us-ascii?Q?hn5wQGvJYkEFobjv3uRdBwtCeneZO15us5vyyKMCuODYqgpC4wcmFrriXYCW?=
 =?us-ascii?Q?kDb4EU9xJ8DJhDKSIR3Z85AzW5lVR4HwrCbvVJ7Q0DSW8/9Rr3anUqGTzIkt?=
 =?us-ascii?Q?0uiG/tQA1kqCQp11RkBW766ZQ3wFFdKdcNNlXo0LZCoWOFhaiOHitzFTHO1V?=
 =?us-ascii?Q?3PcFfR57dYkjACSRHKfziC7oTullCKvt5hmXRWq5kHIIiL99AyGfg18R4/Qc?=
 =?us-ascii?Q?U/+8x2ExtfGjTDmqWiuvi2H0m/1feesxs96CUiodqNF1hOmnV7YkiPsk6o8r?=
 =?us-ascii?Q?iF45kZ7Eo/7IN2vxH1Vl1JIiJRIc3X59fNoUzD3xOHVgCWDyOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LdGJ9PNMxRiWAplxBbpSCtyOrw5zPnTw134D8ly97gZ5zgi6fBnmDGLaI/Gx?=
 =?us-ascii?Q?2gxXpBgYqIiZrfAcmmarpPDbbv0T7SANvKRD8FexBnMc9qH2lRAzZ/+nHpUi?=
 =?us-ascii?Q?zGfbxIRxgdCsUHrFs2RS9kC0fe7lGqgBKaFtaJ7FRyUyYFN9wpSI5phXlSzN?=
 =?us-ascii?Q?F4QbkkWQRspxFx1k4YkZ9MjudnnTekl3q4A4wRH0JI6oT3HS2RXoe1ved52z?=
 =?us-ascii?Q?VVNUkBlwkTs0Xge5McIe3O1UbM9jBY17avyRCXMMhnn+7TpS8LSrJ3GGhGhh?=
 =?us-ascii?Q?SE6y9W5riQH/oCQf+1Jb9LpUWju0OrSDoHXTxRuG/fbo+QmlQwUZRujmMsa9?=
 =?us-ascii?Q?W7hXnP7bXTc/nWxGdgmX2CZ9Tflh8iMOiWnFQfBQBGdsBlMaHW+kBw99qqni?=
 =?us-ascii?Q?UJ/HXtNBjqhVhZhCykW7wF9RdE6fH6yyaaMpZDnuzu1dYJZZS9xBd5XnJUJm?=
 =?us-ascii?Q?a8ZS0n9OGXSvEO51xLC3HvgsGBRML7sIDYhcaYWQ0/ACJLnOVCKPUWgPHb/P?=
 =?us-ascii?Q?QGlTdk99nnrZO1PNXERU6Rc8EZVxhLoaPEHx/otF+T4d22bHVbL0ZcYk4t7L?=
 =?us-ascii?Q?hiSrXBcts9wrfXPZ+NX/jghZax/s+LSPBisOjtx+DAkMx1/MTSmd9CzV7PFb?=
 =?us-ascii?Q?bVAUY+5XQe+XlOxncIBQ5Z8WVfqhWNY6fePbOJ7KNlj/brMm93tIUwiFmOxZ?=
 =?us-ascii?Q?kNBRtHRHlDZHpVYB+C+3rebPReIoaEjg33fn1oZHbD6s/61F/qeB+B7ePpr+?=
 =?us-ascii?Q?Rb5ZZvL0osXkYhdH4eQUVbviBaHye9wnXVyKGZHiOVsaPUS8ri3DG3qpRb81?=
 =?us-ascii?Q?xPIxUz5Ubz6wFRWBqh34q5BL25c6q+ySUKpap+6jG1jWI6s5L+fSeOYqHR5t?=
 =?us-ascii?Q?bZ38JZ6oJq7LtfKIINaiP0VOJ9LnYR0r34tJfmEAuglB2AmatCOi1mNi6paI?=
 =?us-ascii?Q?mkGu0Yu7S3U2DqlUSLemz/7JtoZHOzM5Ai2yhbrQ9nPP3v0qfO3dwFXHHeMz?=
 =?us-ascii?Q?Rc4kz896N3dCaB+9ry4wIdJqpTC1uds/npz1zOw1EuyeQIMNGLaCHcKCL/w8?=
 =?us-ascii?Q?wNRZMCfvmq6cnzieCMPdhCe6Rsi6/n2QLtNShji0/ATNRasRcsf18C7QRpCl?=
 =?us-ascii?Q?tJCnNUG8FcqZk+Z9CUF4M4t8ReaYcbIDkwvF+3XLyRTtQxARnf1/Qb5MYY74?=
 =?us-ascii?Q?nwzzopykhWzqNJt7+5mV5fNq0r9u34Zjbyn3Jm34QNFqGTqQgxr/AXA3RU9u?=
 =?us-ascii?Q?vIabNibibygTPkXQoKLmk/GKLgXtRmK+b0Yoe4iq8RKZdBrVW+7wawiMx1/2?=
 =?us-ascii?Q?qWf6YBZB295y6Yr1KSyJmTnrG2EvggSoVKY/eOjEQxCt8xPhqk/7rDaMMoJq?=
 =?us-ascii?Q?rYBlP2QtygBLkduPX4S37+5P5RoX5pBW/YYihxU8zczf7u6hn+ENg4nvejJm?=
 =?us-ascii?Q?awXbaQNMSJwxGguicKCQ1I56KGkmKFjEQgi0i5RtfsdVl1LgIe363zHZqKrY?=
 =?us-ascii?Q?d3SZmOmn1piwBCDk3cvzkzb/t5GkTFyhXnCGLsmUjYtp5EIo6C20f6daHgvm?=
 =?us-ascii?Q?T3HuPRfqACtEwftvrBjB6rqUtzVPnyM31JsmZmw+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e4e0b6-cc1f-4e12-78b8-08dce2368c60
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 16:31:49.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08PJjBbGg6sxz+KKanMwGYIYqw8bn0DRakt5RwqqUKLB+UJgZKkWnKMS3bfnyzai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10805

The commit refactors the power management handling in the gpmi nand
driver. It removes redundant pm_runtime calls in the probe function,
handles the pad control in suspend and resume, and moves the calls to
acquire and release DMA channels to the runtime suspend and resume
functions.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 66 ++++++++++++----------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index b7a05ca4409c..c273c08c756b 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/dma/mxs-dma.h>
 #include "gpmi-nand.h"
 #include "gpmi-regs.h"
@@ -737,9 +738,8 @@ static int bch_set_geometry(struct gpmi_nand_data *this)
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_get_sync(this->dev);
+	ret = pm_runtime_resume_and_get(this->dev);
 	if (ret < 0) {
-		pm_runtime_put_autosuspend(this->dev);
 		return ret;
 	}
 
@@ -1301,10 +1301,6 @@ static int acquire_resources(struct gpmi_nand_data *this)
 	if (ret)
 		goto exit_regs;
 
-	ret = acquire_dma_channels(this);
-	if (ret)
-		goto exit_regs;
-
 	ret = gpmi_get_clks(this);
 	if (ret)
 		goto exit_clock;
@@ -2761,15 +2757,9 @@ static int gpmi_nand_probe(struct platform_device *pdev)
 	if (ret)
 		goto exit_acquire_resources;
 
-	ret = __gpmi_enable_clk(this, true);
-	if (ret)
-		goto exit_acquire_resources;
-
+	pm_runtime_enable(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
 	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
 
 	ret = gpmi_init(this);
 	if (ret)
@@ -2779,15 +2769,12 @@ static int gpmi_nand_probe(struct platform_device *pdev)
 	if (ret)
 		goto exit_nfc_init;
 
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
-
 	dev_info(this->dev, "driver registered.\n");
 
 	return 0;
 
 exit_nfc_init:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	release_resources(this);
 exit_acquire_resources:
@@ -2801,22 +2788,23 @@ static void gpmi_nand_remove(struct platform_device *pdev)
 	struct nand_chip *chip = &this->nand;
 	int ret;
 
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-
 	ret = mtd_device_unregister(nand_to_mtd(chip));
 	WARN_ON(ret);
 	nand_cleanup(chip);
 	gpmi_free_dma_buffer(this);
 	release_resources(this);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 }
 
 static int gpmi_pm_suspend(struct device *dev)
 {
-	struct gpmi_nand_data *this = dev_get_drvdata(dev);
+	int ret;
 
-	release_dma_channels(this);
-	return 0;
+	pinctrl_pm_select_sleep_state(dev);
+	ret = pm_runtime_force_suspend(dev);
+
+	return ret;
 }
 
 static int gpmi_pm_resume(struct device *dev)
@@ -2824,9 +2812,13 @@ static int gpmi_pm_resume(struct device *dev)
 	struct gpmi_nand_data *this = dev_get_drvdata(dev);
 	int ret;
 
-	ret = acquire_dma_channels(this);
-	if (ret < 0)
+	ret = pm_runtime_force_resume(dev);
+	if (ret) {
+		dev_err(this->dev, "Error in resume %d\n", ret);
 		return ret;
+	}
+
+	pinctrl_pm_select_default_state(dev);
 
 	/* re-init the GPMI registers */
 	ret = gpmi_init(this);
@@ -2849,18 +2841,34 @@ static int gpmi_pm_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused gpmi_runtime_suspend(struct device *dev)
+#define gpmi_enable_clk(x)	__gpmi_enable_clk(x, true)
+#define gpmi_disable_clk(x)	__gpmi_enable_clk(x, false)
+
+static int gpmi_runtime_suspend(struct device *dev)
 {
 	struct gpmi_nand_data *this = dev_get_drvdata(dev);
 
-	return __gpmi_enable_clk(this, false);
+	gpmi_disable_clk(this);
+	release_dma_channels(this);
+
+	return 0;
 }
 
-static int __maybe_unused gpmi_runtime_resume(struct device *dev)
+static int gpmi_runtime_resume(struct device *dev)
 {
 	struct gpmi_nand_data *this = dev_get_drvdata(dev);
+	int ret;
+
+	ret = gpmi_enable_clk(this);
+	if (ret)
+		return ret;
+
+	ret = acquire_dma_channels(this);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 
-	return __gpmi_enable_clk(this, true);
 }
 
 static const struct dev_pm_ops gpmi_pm_ops = {
-- 
2.34.1


