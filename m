Return-Path: <linux-kernel+bounces-347836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0943B98DF6E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D9A1F24FA1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFC11D0B99;
	Wed,  2 Oct 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ULZmeden"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013046.outbound.protection.outlook.com [52.101.67.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12301D0DF7
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883623; cv=fail; b=CGBmzuzY1KXtbEiuAuEDN9p8XJV+ZEL+mgQ88KIeEMU60now06RKCSwila9n0CAPi1Ptqv9kwbCF549PJFyWaSHbkczCggwNW8LrCPSSG39CNB3Mu9r2kIxqkvfyR4VxSoIa764sB7i5Ln4B/hn+baDirX9KhoC97sUytkv4598=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883623; c=relaxed/simple;
	bh=ZqEcqmsSkNN9UGMc4Lja6H0YiEClZAbMkiyNeFeYfSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qweWxqs+8s4wb8t7WRxpiRD1ZysO3yEiC7VzeQLs5UXe50fay3A3ew38NLOpstVdVoIsJqaFITYyBGTEUvhMa90tRKd98YEPBeyyZEkSawp5njv0b2QvoLqvBx5CYga/qbWRsso81ITp7gN++C/UB6pFPlXlR2TaztMb5HAd+mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ULZmeden; arc=fail smtp.client-ip=52.101.67.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYQoZvfS8kyoiKlMGE2BZDF3UcOBRZ8L8TWopjgp1SHjRC0+FtOWGmepNAxhY4Xc6xTiEzaBEPHcFoX7Jf4fhu93KmupOQw98A6dixX/YA0GilUO8C7xA3yuE4JJmhaTzl1tdSBBQd6SGTIFPZDEStG94KP+UrB2wnZDendLNw4bVadNa4SVJKVBtO5g5121kNIyHr7EqnyTPW9d8MO89WSxdT5Koz40uuGUY+C9FqIOap8bqitx+Tyq0AjTQ8MldV2A6EqkYp0E9kJxWPrOY/8ATlDU9PoTO/sV9cylmwiDguyIjfrkUeiStJLx38Jyw7fubv0UDmRATGB/J0ROhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQzzCjfkLMWr0bpgVIP1oSZbfwvDcllYPWTGFraoRdU=;
 b=f+92vYCXKpmfFXathCcijVbkzFuqhGMFwx+TOzl7W7DgUTdFXYE8Lxc2kqfO518d8uEMyRl/VwZhTlAcigrNbwkAUumLCR3GL6avkq+/Rhsf97e4/bnLPEsmDYycoB4bI3K3+xJBKNXSWw9u3H/VpnOKCb64hw7T6HsSPktOM7T82ruW6DiGRbLK+qlHcA6P+c11WaVyWpPs0mT5DO0+p35Y/0MFBLT+U1B3tnAIuEt9gVL7dszRp1j26ApW43pcPtLtwqhNuUyA2CBi0qcoA6JHLKHrFo1T0T42ulD+Qz92NXtbUiSYgOwXXE1q0wGLSzos4u+nyKIicT9gLtQ+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQzzCjfkLMWr0bpgVIP1oSZbfwvDcllYPWTGFraoRdU=;
 b=ULZmeden3w8BAYVOsVvI1Vp05ieGHryIjnvJ4jJPRWl/PQR2YMfTM/jMnsSFd+CK+OO2XzVXMUF6FvU1qy4+7g7g+/D4JJZytP2FHnT0VxHatd5gQNaLxGKHo3pYzCdhcjQg+K5KuTwaVEYoYnmD+jUTpvqY2jGFduqx6KR0V3ErIK7UgHSS1BkzuxsDxjyoTwmAg8GIk7XOwbzuPrx3Xjl8GEYj3mcNEJhf3y61ZqVZS50N+MA1EwTrSpqdw9FVKim/F0Rtf5ACTTAizxbA16t73fyoV0lmnOGYn+1Yh0zJzN3GqEWm1WPObXMkwN9vkntyLSn3/lcFOLMO5MqDXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by AM0PR04MB7106.eurprd04.prod.outlook.com (2603:10a6:208:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 15:40:18 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%7]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 15:40:16 +0000
From: Han Xu <han.xu@nxp.com>
To: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: imx@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mtd: nand: raw: gpmi: improve power management handling
Date: Wed,  2 Oct 2024 10:39:44 -0500
Message-Id: <20241002153944.69733-2-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002153944.69733-1-han.xu@nxp.com>
References: <20241002153944.69733-1-han.xu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|AM0PR04MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae2eebf-7c2c-43f2-5b6f-08dce2f88314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vBgQigix2GMhFXt6b60Yt0jOr2YxIRStDKWE9EQDzMY4wt0IuhDEqFD/IJbb?=
 =?us-ascii?Q?aq1LX/g4WIKBMjelNKVMyXVbcipoIZREqBc3r+0hYr+ZOLtP/8ET5/IKl3+O?=
 =?us-ascii?Q?MCZEAjYxqmrfcN+gkYD3+6LW2D39d/ezoQnB5tvxSo2NMBtphtZ2R7Yb7iX+?=
 =?us-ascii?Q?9EYXbkYaaQzENqEeaq9kUWR3iQ01n6usfRPD9AK+dssp9f1weiHqHXuisEfX?=
 =?us-ascii?Q?oSD+Si6eSgqdHa9yUdTJCrePQNZP6zTfzrY8gvblhptByBXHKfQi0j6NQWEE?=
 =?us-ascii?Q?YiIeGGtxEdk1lepjRmcEswK5gSnbpE6ANdygOZ4QRM8Sqy4JfXcRi4KHFGWm?=
 =?us-ascii?Q?cIV7JginO7YG803Owg1rym8qbeuwaHa80KmQH4TAwIaf9+NtiKHOMumr91XD?=
 =?us-ascii?Q?SnGgEUO6GmNrVLuu9XoJgWmvfGCybMOptUwiG7bxiuEWmjxhK2S7PXURRcNy?=
 =?us-ascii?Q?ffZ9coPr6nnop40XnGO52FMudxdf39wdEp8xfA8Cc2p81pdNOPhTZgkGfWTp?=
 =?us-ascii?Q?WAxIi48DhvVLDPICCeKw7bmuGIOBGoyS2riPRK5Tg9kdeDZGeMoijcqTmsB3?=
 =?us-ascii?Q?OYQbUgfdA3UbArJ5u4QBTleJSXoSMddxvXIa2J75y14S7zvcuqv8YiT4EWOs?=
 =?us-ascii?Q?DjhqHx5REElb4uJ2gB3SlJKef65bDaSSHBJfEfdkiwQtgUg1ngvCi3Olu44u?=
 =?us-ascii?Q?B0vDkO49gIyo6842hciD7mv1Fbf+8RlVag6cUb3FV2vt9dZh5HFaVysxPxJE?=
 =?us-ascii?Q?F7e/nPvVPuiMWJ0OBar2iD8Ke0r5ikYRu5VyKLstBxwsZ1aP+03I3PNoNW49?=
 =?us-ascii?Q?fPioUURau3/t+NLO9quVlNI3QnXMHMd2QO/aFlDPzR70/InDxnjxZx6U06nq?=
 =?us-ascii?Q?1Jy7jPhcBT/LB4B2EH/BY7ZIA7ML+HjWM/8Eq3NHlhBvlzgSFvceMfMIlGHm?=
 =?us-ascii?Q?nLX5LKq0RLwyM6xya1mToq38jF+3T69wmeHREl3LJUc9NOeB9UJZl0RqjHFA?=
 =?us-ascii?Q?JMw4vXxKh/u4Kbj75F93Qw4xCBjm47ozpkC8BfU41KUODlR1nyqSXXdsu7xa?=
 =?us-ascii?Q?JW6fqa+UccV7omIKBy0/IHJ1iUYQqR0RYXobhMmV329IoxfTojnNyCjuaQoW?=
 =?us-ascii?Q?4jj9W0OgYfVF+wqc3/2AKYANpZ+nD4DcXPNQNLrPYD/h+hQipYywRk4cpDm6?=
 =?us-ascii?Q?2R0+B4jE77RP/5H4ZypjWdTpEmQaxTowvHcTRI7I/vh5Mmbhy2mw9tordxDY?=
 =?us-ascii?Q?x2m8YplXyJJBlmYHBwQvsieKIrlEs5Yda0WQrfTYwFpgdeSj8Poruan8avuZ?=
 =?us-ascii?Q?TarXOMN4HSf73bWFRfbSrRm03zzLnujOMVj3k6JhSZOfKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JKQjG8Z4kKWQRIbmIj/SiHBSw3IcU0JrEyuzgWksxtkr6HkdfwaTwsRg5Hqs?=
 =?us-ascii?Q?tK0S8y/JWa9xk9vmFVQcv1J154CTpQ2qUptJ6G7MuROipCchKGeFh4/53Jr/?=
 =?us-ascii?Q?L70ahAFlz7AvQQV7RHYCE4jueC7Hn4DT5rmonOpfgzrfsdtHTJ2OH+sMxFfM?=
 =?us-ascii?Q?VEvil63j4YrEaVAOUlwAGsD2WhJEvDKHiqNMtfQJdeBhxlhU4BSvJhNxk2z6?=
 =?us-ascii?Q?Mb8cBvF0Rbkk3I29Y0GdCzCLYdI/Adbsu48mf9AvkoxwOf662c/BlUbRk2hg?=
 =?us-ascii?Q?H1keDXHu7CMr5n1tYt+h+ky1tl8QnESbHsg9GpgjQ6d1e7Hu82KDD/jlxlYP?=
 =?us-ascii?Q?Z3BVyahtcRdH1gX5rO3jf7lrkR/yWZ4MYe6gBnGiDwRhGZE25vxIHpRFrchB?=
 =?us-ascii?Q?jFZLswnxdN7XZDkLQP4JZ3CI+TQJnfiI7TtboNO1Hnf819d/85o2QvkjFf1V?=
 =?us-ascii?Q?12mPe2Dl+CZFpLOaiXOgs5FqT7ORfKeIu3IsrRscM4ToTOz1Uesj+XmbQZwv?=
 =?us-ascii?Q?qyxz5kZHv9+S72ECbwvjgReFhTm7XOocjn0cryoMnE6LRGHvNvBKc4lvo2oM?=
 =?us-ascii?Q?JGuflEixXGh2YzdJ2Fj9GuZaaGfwo8izvRCXOgRCGOZueQUgNor3lVV/fxIk?=
 =?us-ascii?Q?03s1iZQwPfDeCQIeC9qVpJgi8K0XQiqfNAv0Ea+AHsUo5fB2eGENNRHbfPmu?=
 =?us-ascii?Q?O94Q6NazJCQfwrFx1zXFmgt41v4pou4ivbT8z47RZuOFJcSxW4o5cvKopXj1?=
 =?us-ascii?Q?5z1C3Xgs3MpK7fT4ADbUPquP+4I2qPI3v2KAq9JOQXEZD/tDig0w2BYBg1Xw?=
 =?us-ascii?Q?oRcXMOSN3RLZg9IyGdPpjWweMtKac37/H4OOpR005UxuIeuknTYtHH9yTGjr?=
 =?us-ascii?Q?KWPa+tXQdPSZjLcz/hewS782AmOLjgLszJbpiNVUwC4cvwe8R0Fu2OOAnWDM?=
 =?us-ascii?Q?2bcnGldHGIIEg6KGRyd2Bzk1q0idf9LjYF4bMnm2ENmx0BstJF7VjVZpjK9D?=
 =?us-ascii?Q?btl2yM8bu1apH1dow65/nUkZYiWlsBu9+mx/O9Oe0AJAhEh/A8B/iY1j6yTA?=
 =?us-ascii?Q?CNahICRUVvHQFKLf6l0d3+GEjFOKrPsxvPf2gNA1SuUoFKwkByzaze8Ae2T0?=
 =?us-ascii?Q?V9IPsKKjB0Z93kSOSJr7o9mWAF8qPi4ODVHm2dfQPGSW+Fj6g3N7pm4NLGO3?=
 =?us-ascii?Q?oFzNg1KPuib/dJO10F2yW0i++eAJAh4kvVHLbDpJ4JqzGbN2vtpMxcnYZI5L?=
 =?us-ascii?Q?/HepJbMG9gQEb81+ryLwbEJFUNjwTEATZhG4i0FcWFLYynr4p25CLUEuB+m0?=
 =?us-ascii?Q?QJflud0tzpIH74lylBoLOOROF+Vx69hu/ubHHXxROBS2NEdyDnmrIvAe+cLV?=
 =?us-ascii?Q?tIjyAh+iYpeaVQisBe9emed4B5RewA199TZU2DMsdf7QCI5skVbppEJSX8vQ?=
 =?us-ascii?Q?F+Tp7xW49z7Z8kiNDx2IM66keoqmnpbNg0Hv89CDhyk67fyH54nhfK98gtIO?=
 =?us-ascii?Q?vdYm6ey623O4gIcES0R4FVd1yPIgneKLai3krIdNNRlFnExXNZ39V7gsUCtN?=
 =?us-ascii?Q?wjpsAjZIpfdLX4eTxl6Stzwz1M0J/q76nVOQFc35?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae2eebf-7c2c-43f2-5b6f-08dce2f88314
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 15:40:16.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nEXzRxZhsunaTT3ajLTnkNPAMsXKLH/pPqeOKM0cn5wsDc7bIY/yyOItv9/MeYj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7106

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
index a7d79679248d..76e4b89e2451 100644
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


