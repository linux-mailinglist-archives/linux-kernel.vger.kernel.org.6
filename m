Return-Path: <linux-kernel+bounces-354059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F5993703
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519151C2229F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9793F1DE2C8;
	Mon,  7 Oct 2024 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UTQ4CGVe"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBB1D9A43
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728328428; cv=fail; b=a0F9irdMVeQROCgVSi4MfBNWvEFT20yku6CUZGji5rDulP5v0EemX7oZ7Z6xYISXhxn0q20dhYeuvQ6pHAmyF64EYSSAMP1PsJQqaqYuAGeNAZy2w/Dcrs7yMZ9jn/47WCY7eA3p7r3sW6vKfyiv5xRrSBExCDRKQ5AM7IXZLD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728328428; c=relaxed/simple;
	bh=MtWv0GtqTnf7m6qmkKh6Yvh3Ff/I1tkWdtrEYCyF64U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iGrMP0h/FCoYBKu+gwfevXBxfAxjdOwEAb0PuIBOUl4KlmCfTEbR7R3crGIUe+b7baV9wYDcfV7GGTsvNTCYC7gfnBY7Au/lDq9q550s260s9gXWMF4ZTymuMYBkMDYuJX3YyRXr2kHMxHl8R/0L4XiD2UUQnSsbLNQf6hYOA1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UTQ4CGVe; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydxwgCOdBiQl9S3nY0KpElkCDhXKpSU65pROv0LA1B+ZW6jx2MzNsTP4OGJGYO4YJN8xNiCoTnhIu97C6v8nSfVS1s5rvnsLoI0BdIoTmlwcc8yMwAycJ+2K0ha/uK5EEgfgttaTN5jUzLuAxKQ3ajQigcwqN5vFmLjh6G9q/8Z8LjkLeiTcaYaPBAUNclRIBIJLxnHHZtLzMfETlIezt+DzvCmGeKjZY0jjrCl4SouSJPRNnjGG9yB9samXD3rVBoVycm6jATylZQQ61xnW+zMXs2+026weYpFCkzfPFzc3C1j0k4VZzb+gCHJ5TsWlli1v+aAR8172k+GKjeXekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDDbD1cdL9bnOfVz2NLMVtD0sxy0tRFWRkk4O9fc52w=;
 b=IQ3zG/tJiJhB4frre8l93vxGpesgltlEKZfv7xjQ9+9vjEz5GKKJRrOmXrCzP8lc+Fz+rYB5JfA9X0CwiuAwwNUNXt9+5uBr64WDwJ9rkTSAmsvl416909TOJ/ZJrZmQs1kGUnq59mjjfQ14IITmwXr3B5vHeQHrKlYlP7rrI1tUCnzgcMvzSQbqd52WQileBCwTIxqYvZvIpntVudf4L1MFVdLw3QOvIVSAmlE5p1ENlcr0LIhEufJ4jG/jd4VkJCEdvRoNfUGWD2+tCVY0e54qPYymIGGzZ9aQbhqIVQKeR1meEuahmXHyuflMztY3LDnS1NHujgMXoKzxAyxUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDDbD1cdL9bnOfVz2NLMVtD0sxy0tRFWRkk4O9fc52w=;
 b=UTQ4CGVeGFvN1jMUG0/xxvlfo16Jf9lW2hCnK0EbsNZpPbde2G2BVWf+z/xeEXU4QLULE/7F4TRiMxRlH86x/heookOdHwZpHcidvaESzxN7jdXRkxk6/nQRQZ5Fv0tc290mm+/wli4ZNYNwkRvlJrCP+EY8GpQjPWABMTSMNJqfKhHZay49F5dIFg/ZO9skz69N6kc++ywVlRmsrPCjUdGmHg32mqH2FNuhjCI/o9yyIDZHiRQ5XwtNMp6Ni8IoXnccH8pZbkSYT+dyFAjum4q8Ib0f3C9PSR/DJD7dyg/iM+7ZsNXfDcN9PTPU8onLOzHn30M7WwT2Gl7ufdTGpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by PA4PR04MB9413.eurprd04.prod.outlook.com (2603:10a6:102:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 19:13:42 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 19:13:42 +0000
From: Han Xu <han.xu@nxp.com>
To: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: imx@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mtd: nand: raw: gpmi: switch to SYSTEM_SLEEP_PM_OPS
Date: Mon,  7 Oct 2024 14:13:18 -0500
Message-Id: <20241007191319.220775-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|PA4PR04MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b98f58d-cc7e-4ffc-1395-08dce7042812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yn/CFiWGgDS9tirt3sZfp9eZbnUppJgWJyrrExDbKSGl7H8GOwzXXUh+YA0T?=
 =?us-ascii?Q?BTyKmEWMonboXUdp/1AJKrRjQoC0IX/kpSIk9w2PODu7Dml2KztWn3LLfW7p?=
 =?us-ascii?Q?4f6oN5X/iECFadx8W771bxNFjdz7uiaViGGtGR9vNd+I8s+6tGHaShTm3u7I?=
 =?us-ascii?Q?g+cTP9sUakFwCjVkKT4H/Z051VM8twIaIev3lsc0EpaQ/YY3dKtnLm2PUwuF?=
 =?us-ascii?Q?tBq/cXd4Q/YR4nAVpSuilXCtfV4px/uv406rzVHm1GU9rVNHfCUK9oLqqVvh?=
 =?us-ascii?Q?KJao8kTANlr5zRbjdOlYXmyT1liySAjLz0PwXoiQK5S8PBphNtOz30RHwC6s?=
 =?us-ascii?Q?8UCJE3yI7yx9s6MFS81ryZeLDl/4N5je9nQERSaC1MIcgmNXsiXkqyDI6e1s?=
 =?us-ascii?Q?NrfCYxMu8+Cvqnj+jcK/qa6bg/nIfdA+shEP/uow/vDRKRcw2ay1ceCEzN7C?=
 =?us-ascii?Q?uE8tFRTUxc4ztrC6MxHaC5RhdDNNMC8Sf9szGbcsEb0wJtrvccX5cEWbf7LY?=
 =?us-ascii?Q?U3PxADkjz7bB9SLK6osDZiN9e+c3DlcRD1j7vcF7FBUnWZRyAz7Jzs3+uKMc?=
 =?us-ascii?Q?WzxJgI6s+uUgS629ucAHsKF+2V/WJI7BrIyN1XdkaFomKuJMw/12IMockzRM?=
 =?us-ascii?Q?FZ5de/92ZnKMv7IS5Qm7rzZELwzrb9vx3dH2FcKc0sFg9wIbBSHC8PhPjdQ6?=
 =?us-ascii?Q?wT3GxvwQMO8JQhha/QrDToUy9GVOsR8RNDU74/yqI1EIfatogLforNEyGYIB?=
 =?us-ascii?Q?P8ihUQrwLuoQ0mZ9pWAaFmVTOXwceGUvZ0g0ua3KU7y+8LBZMqfRrDjuvYl1?=
 =?us-ascii?Q?mAP6o9oumPqgdBLEaxRVERvOMt9hkvHmxoZ27K0et3vhGhW1cMDKyficijuG?=
 =?us-ascii?Q?+UBt3leTJ9DmmtV8TLOGNGcJ+G1xrIgHAN8NSeYQVKDsNjhAw7kx+GNOlgUc?=
 =?us-ascii?Q?Nni3S3R/YYHPg9xRMFsirZ2h5kD9Qfd5wWT502dpnqC29p7NX4Xtlwzz2IUL?=
 =?us-ascii?Q?t+mySNQjkSPArxioM1zciUeSduI/yUkh6NjVlMBITZ9H9b2ryhbeaU3ZMK9P?=
 =?us-ascii?Q?g9Z/weROxXos9ZdZky5M1ybv/l8ISI1ZzmF9VRaRQQysFCm1tXXOkA2dj92s?=
 =?us-ascii?Q?wtWV2yqs0GJNCdnOa6R7HJyhSWPQe2NnP4IarKI73DeHxz8nQJUwHzX9g1wJ?=
 =?us-ascii?Q?9xqjYBi9VTTP2wuaDFpYMU2c0hhnaKw2/nwRgQDawgp3N415oQ3q0I/dUgw3?=
 =?us-ascii?Q?V8n2BVGA1v32zYUqnUL9xi7vT+56D92Y3eKgke7Nz/pZiiQm9Js+1mQQgbig?=
 =?us-ascii?Q?Z8sNfoLsrhgZzuHgjsrHvAbP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m1ulqIhiGQ0QIuKVmrpzjkc5ISlr74mxFWE/J+rObqgbnw0J+U1UZuVQcvJ1?=
 =?us-ascii?Q?dbOjsfHIAu9Xa2waXoar7eB4pxRN5FKUAyJIMz9OR+4nl8WWfsfwGWWutntt?=
 =?us-ascii?Q?eaHqO+XpBztusZK9FEM5AUjVQcw+VPKbPysbwKSs9SCUTlKbHsECzIcbcxHm?=
 =?us-ascii?Q?t0Sb3iYeWlRrwTb2tS/SkIuG5NhRkFlXOiwKiDf+d9eHf7Ixah5pjJI02xyV?=
 =?us-ascii?Q?phiOBI3dFnCSOsCG9ZjfFcAKtQOXLfG2bDhWXb+drddDRFqXctrXYMnRbxMd?=
 =?us-ascii?Q?3XJ2f5qqdbRWn0zQyW7RMBatcCe2BV8yOo4fdXSubd3ZomJ9sXh8EYmfcklT?=
 =?us-ascii?Q?U9Gir322w2WgtwfSui5b57eknVclUfF39LhhqfTd66HuMDdxVIkBVnriEcJ8?=
 =?us-ascii?Q?wSFVjrCxU/nsrCxpb85OsRKaZjD8xGJtpMIYTB5uVCPy4B2/CK2Dkcyp7bZQ?=
 =?us-ascii?Q?TVdOpsDAtPZq9+W5/dVVSfa/9hSCHYJ/54d39fRUwg8je2QlIiIGWvmgu6O3?=
 =?us-ascii?Q?x0wofXmYEkK4S+XYzsSDi4MOnxUkgFGstguat+qLJfBANj2txCVMR7QEl9KM?=
 =?us-ascii?Q?5j4azHDoaPv4k0cZai0CAl7DtWova9F8saXKF3KdRvkF2IMqOXsZ1v3eG33k?=
 =?us-ascii?Q?/+6f8anzthYkPUYhoAiLWtm0T7Rci6etXC5ixoLP5j6ZZK/kYIn2/Azb7kMj?=
 =?us-ascii?Q?adOju4p6llD3H5YX8GvcZ8pVjnaMpCkJWkverPcIuJdUqTmldnxvH9neoizb?=
 =?us-ascii?Q?IM9f7Jc516XZSoRmzimA6HTK1ehuhcKrDXho1Ig9cjcSwdXXb1OZACK5v0H3?=
 =?us-ascii?Q?an0QI6vHwBAIZPQQNCTcx1WmnoLskrWKiULVYuYl9NkkFfHmclBdLs/R8dND?=
 =?us-ascii?Q?38O/vBa64pDUJzcBJ+MJ3RGJfjbtfB1VCFZ5H0uSjY8vian6sxwVhsWy1gDl?=
 =?us-ascii?Q?IOkONnM7dPW9ugj+Zp4DWcJJDFRuBYYHg0l5qH/hlyc1nWaaESkjM6Fjl9pL?=
 =?us-ascii?Q?YEpO40rBYwxuCZl7tPMhCBUhRIcWuHITb58CqLQ2G+caGhDb7Adsdy/Yn5qe?=
 =?us-ascii?Q?e5ttVY/4kV5lYLgsE27dWydyQ5rlODuxOhCjjg+kV2McLZ6JRvTBEGXKazz1?=
 =?us-ascii?Q?IPpUWIr/emDF0WxmLy9gwkVHcrXSE2xMZ5ucDSBcykqX8qgFJmf32rMbhN5b?=
 =?us-ascii?Q?dCmH02GB/DBzJJ4RxqtMK2YYSVjpPu7scaQwxMCOYigcatyo0pmxSPBzRGVt?=
 =?us-ascii?Q?GjCYYnSJKX9KTxsDARqVQYSU30vbYImc9ezJ1XDh1nsWnG5EX7AwrnUL9mm0?=
 =?us-ascii?Q?OVR/MMrDeh9wsFptTUPBbXGAkUBkIXrTfRFVTWJeAuUTFAE8mTDktvdp5Wz4?=
 =?us-ascii?Q?lRxw9cHGBaUfDzqJtUnJQscS4D+zH2s2PtkPr7cwi46xj7eY+/1VzeRQxHES?=
 =?us-ascii?Q?G2HLtVHzOBCsJz2mpibV9lj9EuOtBpPfqCYjLK9sIjPKxJXY+Flf8aj7O2XD?=
 =?us-ascii?Q?tp71JGC88XqOLyYLRrEd8d1KV+Luz0016xwiSQZh4MYs6jDTN+jFbzNMCqv7?=
 =?us-ascii?Q?VlYA84EdE1jh06wDH8w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b98f58d-cc7e-4ffc-1395-08dce7042812
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 19:13:42.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/Pl/qzJE0K/w10bEL/NsMFFewFLh2OSG6tjHL/YchJiJFXKZa5pUTHXtQS0ZRHF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9413

Replace the SET_SYSTEM_SLEEP_PM_OPS with modern SYSTEM_SLEEP_PM_OPS
alternatives.

Signed-off-by: Han Xu <han.xu@nxp.com>

---
Changes in v3:
- None

Changes in v2:
- Add the missing pm_ptr() macro
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index e1b515304e3c..a7d79679248d 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -2811,7 +2811,6 @@ static void gpmi_nand_remove(struct platform_device *pdev)
 	release_resources(this);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int gpmi_pm_suspend(struct device *dev)
 {
 	struct gpmi_nand_data *this = dev_get_drvdata(dev);
@@ -2849,7 +2848,6 @@ static int gpmi_pm_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static int __maybe_unused gpmi_runtime_suspend(struct device *dev)
 {
@@ -2866,14 +2864,14 @@ static int __maybe_unused gpmi_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops gpmi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(gpmi_pm_suspend, gpmi_pm_resume)
-	SET_RUNTIME_PM_OPS(gpmi_runtime_suspend, gpmi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(gpmi_pm_suspend, gpmi_pm_resume)
+	RUNTIME_PM_OPS(gpmi_runtime_suspend, gpmi_runtime_resume, NULL)
 };
 
 static struct platform_driver gpmi_nand_driver = {
 	.driver = {
 		.name = "gpmi-nand",
-		.pm = &gpmi_pm_ops,
+		.pm = pm_ptr(&gpmi_pm_ops),
 		.of_match_table = gpmi_nand_id_table,
 	},
 	.probe   = gpmi_nand_probe,
-- 
2.34.1


