Return-Path: <linux-kernel+bounces-354061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD8E993706
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2641284B6F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86A41DE4C4;
	Mon,  7 Oct 2024 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HAS+Xfvz"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34441DE3A8
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728328433; cv=fail; b=h/cIIUtZcaE+ZE5cL/4HNuG3j/57WH/rFnTBlVf+wj6WWFghN4t/wN6WoGRURO46gZyfbpi7TOmOPCxSvMRoLoUHoV5Gsoa6tVggtiQy/hHAYjKnsWscXCHGKn9SDNWbE5Yi0jzEiq6YTcO8TGBCCn+3++ILyN5g+LHGhGExZ7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728328433; c=relaxed/simple;
	bh=RJUixFnlTBvwuwT2fByJ9mucK9vmQNUFTHc5frMn+sE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mt8fuc17sLF8btqUCgubmtalTg5zMLSmfcPck+dZO6qu31lTHyiWS6un/5duPHKZon+hTrqLSFLh4Tqq4Hy1w8OG4l1ui/JKrrMQON4Mbe6aTeVAztTujpiaR+JnFRlDu6xMisoXez6oCRT5fJEP2J+D4leeXyqrBhbCADUJ9mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HAS+Xfvz; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mc8w0xMisUY2gOxVXizpRabJ79zi198bVBr57pWEkgE/8nGbBCTaq8VUgLH9fOBXGnD9bC84CR6Rx5/Rfpc08FQj8BMlLmjAvVCmYaco9UHzPKvfxylbLqWEcUcoAfhYixyuUSaxjqjt4aa73wMV6gXYQjTAFd2YGM1MLn4v2Dvp8n7lGq3QzqLMifbh5Ff6txhqjL+5BOWBuWfN9+ao+0/GwB1HACe6RbFVnTebmbUO+FVF1GsYFdqXBnFM5TN2XbKaeV5U5HMO/NjhRJFUgp3R3mC/DauWVgMhfqjQJ/S1B9tgtTK0Zg/fcYO/ZUEoRJqL4bqFbtWd4y5eReZ98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfksOxHJJl435TBrC1L03dhlO4qDaF9VbPYIqVwSM7o=;
 b=hrAUYQbYT3MPWKreapvJ37DMg9wt1ozw+lFW3c4RLb/+mcyzHZMUKHh29xpoYggyw7HKNi8Nl7jVHcqYMacy4Ejs9JU8v6uRG4Y+sIkggo3l1Z463mdJo9X6gLq/aarXtJyAtGt6rP/EA9x4w/t33qlylzpTJbmu37CweDWcmRZHAFr9xbDkiMHuEj2pF1n6Mduir/O23bxeVfBV9rslvddjtvVehXK5Kl9NY7xRM1FQ9tSYsh3SdvdY2S2E5PI2SkMdptnXWOFpRAnBJ9TMmz35NJa6zx5XdFVGWIPKYbjsRStaoCrhJJiUxlvmOj9HfR9ni3h5Grg+xH7F7VuA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfksOxHJJl435TBrC1L03dhlO4qDaF9VbPYIqVwSM7o=;
 b=HAS+Xfvz31Fp7/GHMe1PL4oc91Oo9Hmn4DY3nEFNAdJMMmb4bhRM4mw8K4PRpVfxGYCatbqWkLCslR9qMsBcL4SrIYuTo8ktx7Gzz6uDlk8Sj/GWCMbB8NXqcdjkzZQSMCQcU+kuSUH0zg+CatKth5/49cjes6BcY/dpcroArNJz5zsp3ZOg3rARQQZBNOiXxFEwYOr/aoQja1nVo6otbpEb+fAR72tyib3agn8xPBXo9bA3DeZKCJpSdAa/Dxv/vw5mL2V4ok0mEkNoSjHBa/ma1Or39qSJ6G2Y1dw/uivQjtSUu0jIzZ/tYWRvHNCZHvOE2ZnuKeXZidywwoxU/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by PA4PR04MB9413.eurprd04.prod.outlook.com (2603:10a6:102:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 19:13:47 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 19:13:47 +0000
From: Han Xu <han.xu@nxp.com>
To: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: imx@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] mtd: nand: raw: gpmi: improve power management handling
Date: Mon,  7 Oct 2024 14:13:19 -0500
Message-Id: <20241007191319.220775-2-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007191319.220775-1-han.xu@nxp.com>
References: <20241007191319.220775-1-han.xu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5c7c00bb-a71f-4ad5-9d97-08dce7042b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wo/zV45u8hGi7vZst+1CMjYpfPeZqAkgL8MOqNxxL+DyrMg7jli0B71q8/Mu?=
 =?us-ascii?Q?bMkxRlKQOPKHlt5ed8T1nkQZK5oyShR9IMg5RXWyQeM7Zb8oPhuH2VoRXDW1?=
 =?us-ascii?Q?oo16b3Uwvxt74rDHfCtUq2i0ywDr881uMnZMb0mOxJMvh4SyhPSsXyJ8BRwU?=
 =?us-ascii?Q?P6samkv1B3MUJ6O2O7w+943AYHvPaG9eqRkorXFYfQwpuLssBvNsE9gWdz+/?=
 =?us-ascii?Q?8Jsr6BT9rAgGctsqgb5Glxtc5HmzV/QE8FKUs9bRp1rGCh2em8sSr2DhUXM2?=
 =?us-ascii?Q?iTlMQ/go35bv4IooKV68fD13yLdKZxxtD3X1/Mr35Q7KTPtJMRwr3zKOMkla?=
 =?us-ascii?Q?6YgLF19pM77NpvBmze++BMri6Q2nhJiSJzAwyVvNm16KxH8nlPCHCNSMe+zn?=
 =?us-ascii?Q?CEtjkXGUEIbDg21NT101q1Wu2gQM7aeptu1MrBNfaTP+/QS4YYo0eTKE6r7s?=
 =?us-ascii?Q?QhTBylZGsFrYphGmhEiE4s3msTZ0xSyXuXzafeGSyC1G8366o/eFCzlO5m+I?=
 =?us-ascii?Q?a6BlSYaxCAbmJEfGmLQq9PyyvOi1JNEx0dfxeTUKm5SflGVKXurjV9HkqyBq?=
 =?us-ascii?Q?XmRA23NRwegRZYfNN7CeUKQpzss1eOc+9AyyDZCsq5ACM9n0RuAzId4JVjYa?=
 =?us-ascii?Q?Yhnadj1CABVEgz0wynXCfz7nRXwWLwJp0PkEcejUm1PTFi+M4wBP8QheSDqR?=
 =?us-ascii?Q?U6FV+hRYYTiHRGz6OClyyYGnMqwy1DjDq140w5kqfAOM1r4vervAZQ+i8gwx?=
 =?us-ascii?Q?ji0YrnLQvHwUzPTCaAznrL530S6G9BeTCS20pZ5iv+NepV0pJKYQXyuBmrPA?=
 =?us-ascii?Q?H/mq08+b+wSCaauNj3N7xdI4BrmC/Wqu2Ck1BeNiX6DP7RBifqf+EGquBUqv?=
 =?us-ascii?Q?eqHWtutroB2pv0OGQtejGWZLkx9g8240y4FV+fKemYUIMxwh5l4CfpoUgCS6?=
 =?us-ascii?Q?lhm78WGitZcyMCQrgGVFDj7SaB8n7+VIti2LjAGjqmciAg7CEbTUtMRwIHbi?=
 =?us-ascii?Q?4Z0SBaU9mBX15OS7x1APPN/uA1Pa7QqDffJijxKzuS0pFjyYh73lSDDQvDqe?=
 =?us-ascii?Q?hznhbKVFhVIPxMUQDQOdzGWwD5s52IXV38NYKQhIq3SMSh1d6N8mGv1Z2hS7?=
 =?us-ascii?Q?HnGIFdac9sZtMF/RQzdBmblVF3uvBPF0xgsj8cSy2IYw3m7hLrHj/4iGEpTc?=
 =?us-ascii?Q?jalzlEygIq5bmdskxXKMbvnjFTRqEDI/DaU2T5bbBCbfGZGoOX8xvrm8hBFk?=
 =?us-ascii?Q?+bAj/ioibQ+1KiSLhoUi79LjGv9Ejpcn27kjRZBfYQVZuG4tpmTQdXxaHcet?=
 =?us-ascii?Q?q5hIrMFkcSvhusLuI1KDlHjB/QbegQHGNvAnfBvrK+EUqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U3sDRqSZBPiw8UjqeLTghNMXNCY3ZDV0jK0ck3IUsOLqMqaQhd6+gKd6vmFA?=
 =?us-ascii?Q?QdWvQVucvdaRnXxG3brUMqJYFLvVZSLs2akZDHeYtymwi2XjUCTtSeAX05Wc?=
 =?us-ascii?Q?sHxgzCVRKTlWpwSLAg6jODt974iR1XS7Xz0Fsp0VfGYjhuHXKjrcssRIGe9v?=
 =?us-ascii?Q?ZlpeTBj6MnN2793KZsJ0EVBdRfv6SJ/uJw+t8ZDesY9jUFpJ/nwvnjQdjN2j?=
 =?us-ascii?Q?9ubIc13bK0w3Eyr9OiqxhiSvK5GTMtwHIU7kNkByllQ8c13U8cYFhpUGp57o?=
 =?us-ascii?Q?KD3Lf0djlZi/7tPFxXWRcKhm6ZtRFsgiJhkol7xnr/nmvecKr9Pd5GFkhf0j?=
 =?us-ascii?Q?OEnbiOhGFEzeoy7bNS963sDZg+jNeyc77uJ3Kq/HbkXECCEQumMT2qVShZ9h?=
 =?us-ascii?Q?VJOEW3GjZz/utNiv0ei5UpyrBi/shLesmP4/VTbmlMp7SlIe4Z4aA4DdR5U7?=
 =?us-ascii?Q?kNzMDQWQfUUr6AqE7F/DzRbJeCccMnhJGxC5VdYXffQ0KxfGSF0lw5TiE+2O?=
 =?us-ascii?Q?oryDlOlwrJC+UNY50fL57veKcIakbiNgxH4qGuQe21pxOnac9OwwM4GY7l9y?=
 =?us-ascii?Q?Li8oDCsYyAV9mfJfPu3VafsMUxs7/oYILNzg2ta2p9HbFyUKEN9HvSf3Jeyt?=
 =?us-ascii?Q?N0sMNGwVgFT8iATWyKduJmW8pipHzfXhVwYIptt7uEVJ9ksmMe0jw1FQKkIE?=
 =?us-ascii?Q?siGSeMj8G66a3/dwRiPmiaCR4GghnEhCOv22MywI82K4RiLCTJ85EpbqbDKN?=
 =?us-ascii?Q?y+mB1jyxqExwypDXiRSeuNWfQ5pJpWuBOsZ8PJM4Cgtuz4zoS2L25WoEmzFh?=
 =?us-ascii?Q?yZehISBKPjbyQVnyj9PtPj4BRaIPDtsRTCGwltM9sEgp9/7LcTA2Ja3kvPuC?=
 =?us-ascii?Q?2IoJnN3v4KU2hW4lSL5ML5WvFkTiZWUDutTPAGz1kiqGRP1A3F6w2NnNjfNL?=
 =?us-ascii?Q?pCO3NEFPKizBkZSCCBithgnSo8gmJQqrOmnVNRqdt93G2JQQTC0MreCFkyc6?=
 =?us-ascii?Q?uY+38h1Zu0tvFQYEJCS7fwlI2XjDBlOPe5yN2hxHXiz9P9EWtBiGjFjFnFgK?=
 =?us-ascii?Q?G3eHvrMeP4KgK3H25Ig4coo23/APWNWHjnzEoVxGfak7jUALNB9Xk2pK7J7D?=
 =?us-ascii?Q?0j50BGWigP4QNCoe3B1TU6fmeqMmZS6p0JpCUHrJ59P7T0M+8yGKgeLtKtQb?=
 =?us-ascii?Q?sxaclDTaM4Hah7Sf4AqdXXcKutreAEPusRvqEhCZVZzW19NueHFkoHFeJt5M?=
 =?us-ascii?Q?qnOGXnzSlorgejxZJS3Q7Hv2gEMDF0DbAXiwkp2XCPUAamerHNIQ+GgcY2Yw?=
 =?us-ascii?Q?7tOiJbZfcWYnQVbVkVKmdr3HBo0EFZzFYx4HAtwl7v5ZXomaasHaKoJyBXCm?=
 =?us-ascii?Q?bHQ2tEs4HGCJVXo1GkTtqID/HY2W+2n5avDp/J5qmTfv2MtDtWD/R119TlIM?=
 =?us-ascii?Q?o1+E6sZrxwWRb6FjazJ5B/uax3DzAwUr0qaXZ5jP96I8eLo9ru1sWwSSvjx4?=
 =?us-ascii?Q?3uZDp7WOZiIllLvGuvYiXqN8uKOcVfUKQSPHp6ClohBcMFbJRhqy4LDzJ7qf?=
 =?us-ascii?Q?6vkklLauEsZ3aqpH6Ig=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7c00bb-a71f-4ad5-9d97-08dce7042b92
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 19:13:47.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bzvq8HFXTvtWBQy5CYuRP7zLOyX27ppag6l5dBGh5cP1oRBMnV0H+qqwZyrGILI8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9413

Refactor the power management handling in the gpmi nand driver. Remove
redundant pm_runtime calls in the driver probe function. Handle the pad
control and use the leverage runtime suspend and resume calls to take
care of clocks in system suspend and resume functions.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
Changes in v3:
- Delet the DMA channel acquire/release in runtime pm ops.
- keep DMA channel acquire in driver probe.
- Refine the commit message

Changes in v2:
- none
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 57 ++++++++++++----------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index a7d79679248d..cab6d7b4f4dd 100644
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
 
@@ -2761,15 +2761,9 @@ static int gpmi_nand_probe(struct platform_device *pdev)
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
@@ -2779,15 +2773,12 @@ static int gpmi_nand_probe(struct platform_device *pdev)
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
@@ -2801,22 +2792,23 @@ static void gpmi_nand_remove(struct platform_device *pdev)
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
@@ -2824,9 +2816,13 @@ static int gpmi_pm_resume(struct device *dev)
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
@@ -2849,18 +2845,29 @@ static int gpmi_pm_resume(struct device *dev)
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
+	return 0;
 
-	return __gpmi_enable_clk(this, true);
 }
 
 static const struct dev_pm_ops gpmi_pm_ops = {
-- 
2.34.1


