Return-Path: <linux-kernel+bounces-279011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9315A94B7CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A50228C9BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35E4188006;
	Thu,  8 Aug 2024 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A2KMu9Qw"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81E7A724
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101904; cv=fail; b=It9dW6XmnDxa8cFA60X9WUojDsfwgBOTZb9e1u4jZGtoDd9L3tSIQgihd/nAFlIxnR0ES1Z4NChesOcxyr+JCzuDlalyVDhVz2jANW2AxTCMrEO9k54tIeWhVUInRUd6VAihCxe0F5TQRn9LwZyZnCWj8bBDZO0pYaCegkEsoZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101904; c=relaxed/simple;
	bh=o3ruu6A/KjFptTnGvoEAsUT3fQ/5p97fjnum1WDylZo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rrDU6ilVLf0MwrH2fHCnlFWJAYyQ8OyaW/Pd3Meo90H3xhimxu3/kR7K/C4+2xxeP5zQuuGFjVrpBgT5TSC1tGoDL5VutpIhGdhrrSJk7bZxLSyeD35xNE+nxEDhKbvkpEoU3ydxuMVEYxWdTMpPuzjVGkijE3C0CJfBK7pOgGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A2KMu9Qw; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QL1Os/+aaQvnfGenW6RkguDmlJm3rYN1XFgdFv4j2ldElIydftaZVD0FgWvBO4prt6Vw84GbdPkxr7mPvXQFerwBTr5wugLc2mPa1NmRQa6Kp/USP+Xw8y4JZRt5NxZ+SkZ3xkwzSFcgtyu9UHLtZtGzx2qDiDwJxBkc6Q1u2kskObpb4kfxft4h13DRkYYR18ESjqSNtUmKs+5uvTHMJtIvZ+HJVFuRRR2kBCJH3xKi3AOibhQwU+uk1r98/1u+HbmuBXh3irfBFHlPHKNX4WaoY/41biZAsltettw0oxXp+bh3Lhub/b4deeRonmix2Gxmkb/7lmU1Oj5sZUpHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jyb5e5/xN7QuLeKEo4rp6jeGChO7rIXS8IooWVUYpM4=;
 b=gvEwVt26JIZqNlmZkCu0wHqIy4A3EX63TlLiEk+GeSQ+0BB/tCTcB1B/WVGxk/oH1eH/cEFw749sESNivcOOTQdFEgjXehP2Wv00clqyi9tw62OJGkbJ/7vUck+32Usg7w89bd8FDB3sXHY1B3o/7DrcvhjekUSHbhUwOItxMdWdrBtjmOytYptQYODOLqtzcU800hkstegD4pM4HtORxSUHzjAVPCSw0T/t7U2FXYPxrnVqE1I9ORAvJBIJZ8y1/+advrzDGlYYeO9DRDJY9EkjnFw8yhR91XQRK2zXGyFes4tYQ0237oUgsFoVaAdDRnW9SQCzplXXvuJIBYLTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jyb5e5/xN7QuLeKEo4rp6jeGChO7rIXS8IooWVUYpM4=;
 b=A2KMu9QwsKriduMSOFu8tNQWN1lRGoCNDro77PwzliHRFGRZ/Zbov3bb2o5WPnxBiywKxTXUYfXEZJx8SMmQ2yrmqfIecfxwGuM3320cfKfmURiVLhVaxTbqPcYw2ZMROoMp1i0bqEOx+LU9jeI1/e2cC8W93WzfBY3RHFBIkwQ=
Received: from MN2PR15CA0056.namprd15.prod.outlook.com (2603:10b6:208:237::25)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Thu, 8 Aug
 2024 07:24:58 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::90) by MN2PR15CA0056.outlook.office365.com
 (2603:10b6:208:237::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Thu, 8 Aug 2024 07:24:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 07:24:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 02:24:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 02:24:57 -0500
Received: from xhdsswupstream.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 8 Aug 2024 02:24:55 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <tglx@linutronix.de>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] irqchip/xilinx: fix shift out of bounds warning
Date: Thu, 8 Aug 2024 12:54:55 +0530
Message-ID: <1723101895-3470952-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 99731308-035a-4bcf-1e6e-08dcb77b352c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?StjNuJO6kS8DprBsHXGw2LlV9eXWw6VM9hLwLRtzXDoDijZMFHH1LPYvwL96?=
 =?us-ascii?Q?vPYbq5Ob0EMqg8NlIrqI+Qv16c3i8mk1B83OlNudCh0FwVxM9d4pvCzhfa1N?=
 =?us-ascii?Q?wmItHwX8BadMoBAQxy8kLrFI1e/l9u9O8X0TUzAciQp6qGQHWboIox/yJeB7?=
 =?us-ascii?Q?eDrLV+mR1IxG/bskAdA3KCfecGuC+vMCR5ZjcZo0NwXB5ww6CsIrYipk2GuB?=
 =?us-ascii?Q?epcgz6TDbeKa3cVIKgI1fkw3BMUCwbRy1fn2u9UjUTCwTtF/9SrOtsalQ7PE?=
 =?us-ascii?Q?UBn50dzsDxVNSH8MzK8e6TqKvLcAh5CxJblNHtoc1MDp2hICt2e5wS4v9t8R?=
 =?us-ascii?Q?jQAk75cP/KcRSYzuxQ4teASQXtR7ERDCXNxuXkBaJFT5ZLXW8dNu6g/OFA5G?=
 =?us-ascii?Q?ZwWqcH2Z8ZTBV9UAvLnU0Q55GNEmcWXpXgTqHnkM6VuT1tFl0NCdgapwZ/A+?=
 =?us-ascii?Q?lKberxMsl1gGDfL42aLf3Y43Lnd4I9qepHt7SWFaGoOk8Yyc/e6YE8NSWMfG?=
 =?us-ascii?Q?Gg7UL1uF8zXanwnlMU79NugJIw0uTrZf+PgEv55T8H47XzKsluOceUpr1eE/?=
 =?us-ascii?Q?JsZdchiJSrODLEVlE8vaYO/YFW3EjpYnz2Qn730wRRTHT+hL7LaHj2wLH5we?=
 =?us-ascii?Q?cJU6/LKOW8a+KBWfdF9y/BXqVCsCSIAJaC5ykKT7SI9UpxP9zoRnh5V1XQH6?=
 =?us-ascii?Q?FdssS+TUVzMhJv53btgenh9smNjmLTyjSBVtmAsJHUlDh4FT+SBmTnax9MNJ?=
 =?us-ascii?Q?+7oQO08s4T69HNOonJ+q8eBFw1D0IiBoQv9JGjkkAbG+C22HgmehdE68Rxam?=
 =?us-ascii?Q?evJiiOgTHdYFESQXfjXvitmZx9ORNBRKwgRmQ8z7UO7VBnyB9kMZFhH5JS0K?=
 =?us-ascii?Q?ySTtAdaApz43cG43JzkSxBK2EDAtw1WKi2a74iDo8dfYpbX/+Hnh52U1z9i6?=
 =?us-ascii?Q?NAqbXGGQaicBRY6SPaCc/44TUBGh/qdET55fu90OEW3Mo6yrRKrP1GQxa+wb?=
 =?us-ascii?Q?VZXR9CHZCaLlsq6XFk2OeFvlcNud7flSaaj1rqoRsHFlEe8f8wqiqT9y8aGj?=
 =?us-ascii?Q?cEzKlvw2Ludg3lzjj26E7wN0zrg7p+GpXLS+RyPkzNMq/mRW0NgwBUzgO2Kn?=
 =?us-ascii?Q?YuGZvlXHcgflJfvWO/PM3Ec6TciszQ+3B2060GuE9zltZIy2n+RX7iY8cvwC?=
 =?us-ascii?Q?fA8GuBot4oKVQV6Q5mMG7sM38ugflN+1r8ATXx3oTraNeL2z4e2LqHdxA4qe?=
 =?us-ascii?Q?/hCrtfTvlmp0WZia9hYpozrb7Zqqdhi4nPjybAEW1eAg5KgYCMMjWg8gzV/u?=
 =?us-ascii?Q?2C1n42XHBB6KeqxrmwItW4VLjDApW6gQ4Q4hJsLw7fdsfI8NPiTrZOo1g9co?=
 =?us-ascii?Q?v8gM4MJ8z+iimJkAWEaYuFoUSauJzLPX47r23Xw+2Z2xxldPwVe/Gvc5sXi0?=
 =?us-ascii?Q?BjDywuH5bBbEFeZKaZR67gOxmNpshoGr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 07:24:58.0087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99731308-035a-4bcf-1e6e-08dcb77b352c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847

In case num_irq is 32 there is shift out of bound and result in false
warning "irq-xilinx: mismatch in kind-of-intr param" . To fix it cast
intr_mask to u64. It also fixes below shift out of bound warning
reported by UBSAN.

UBSAN: shift-out-of-bounds in irq-xilinx-intc.c:332:22
shift exponent 32 is too large for 32-bit type 'unsigned int'

Fixes: d50466c90724 ("microblaze: intc: Refactor DT sanity check")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/irqchip/irq-xilinx-intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 238d3d344949..7e08714d507f 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -189,7 +189,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		irqc->intr_mask = 0;
 	}
 
-	if (irqc->intr_mask >> irqc->nr_irq)
+	if ((u64)irqc->intr_mask >> irqc->nr_irq)
 		pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
 
 	pr_info("irq-xilinx: %pOF: num_irq=%d, edge=0x%x\n",

base-commit: 6a0e38264012809afa24113ee2162dc07f4ed22b
-- 
2.34.1


