Return-Path: <linux-kernel+bounces-173262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F5C8BFDD6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A01C282B93
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D80559165;
	Wed,  8 May 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="YaAhApHd"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2046.outbound.protection.outlook.com [40.107.255.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE545787B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173115; cv=fail; b=CJ4w/TP32Ovm0VFmItY5/Q+qrqXlNmb7MIwTIeyYNPIB7ce1GYZZnuJZ6uKR+rONXQuU+aq/NFTyvwS1+pWKaMpGfmOKUgllN5aJRuXsMiVFRRBmPtOg7mGIvywflzocoKcKG6WHbRmnJmaJvkLeUiFW1Se9MepI9Yodot8tJX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173115; c=relaxed/simple;
	bh=C7MUNeOyxVCtXTZX/JSlCefDqX6pmZngbA80wa2P8pM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d4X4Ul85+G5C+s48cl9Femzl3LlTvQfHGdOyXc4gyCT18ZW91KIVFILgxn+9Gd86LECfVFq+CCj0CtVJJiEBCTC29KkbOvG5DRfZ66t2eP5hHoWeitJN3UdVlpZqWRL5yn9x2Db4qoqnj+TAfwgpiJiC3g8OxyQJCVMef7/ikxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=YaAhApHd; arc=fail smtp.client-ip=40.107.255.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hszAub+7MeC6fedBCKE4PEO/JJMiaknRsr8YlZHzsSkf5ru4AaH6du3g59aK/V3bS/Uwyi+r6ibu8qny1XbP9Uq8EYX0nmoN8dDLbS6C+BWXktyzyzxCOC+wXsPFoY5gVmI+L17Ke2fe6mhGAmWmRs44Tek23IKP3rUULG3glnFO9Da3HZip1FdWN2yVkcg7FUtowzeoEY2X2aTbNoMbHmzSxXn/MvsBfsV0yJHCGmP7UGPDiPS/tzeVxxGGSQSxlMw+b1C/AS49fZAPbQUVXW65+OTUsACZjafGSgxuJ9Ls/dmZpT9BCNUGpSudPBTuU9LhIhNijeX76VQKH16X7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAKGxuau+zdh5ldhQgYIuJGzScIPltlXMA8cN6yOibg=;
 b=bbpDgpBP5QDBlU+iqPyLhoaRQDk08LwNpSLc9TQd8+IR2M0tVNgA4zga4fhYN3maTCe2GBjbdAwHtdIqhNXGtKbKDTmssNvBKZApkTh67OVhnzpSjgdgl0A/FrfJvh7nIbOuWD7HQIpHQ+0kBUzejg5nt0KlM5x8jrOW54K3Id8RjySl+hX0D7oilHrllRGUH1jLpp2UvjqycaqjV10m3DkbMKj2uGKaSggDh3JHnuYASUeoClcz6Ci34Yk4rIvvuwCErHakz+O4gZ5JIJg3bm8njZKH0OuzjrzDXn4EGdsoEDTOkcNvDmdcbLdtJbZOE2YrXJjkFityDOwqzxddtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAKGxuau+zdh5ldhQgYIuJGzScIPltlXMA8cN6yOibg=;
 b=YaAhApHdt1ran+48+u3+JTNkQXrwVB2pn+FJLG/An0E13FayS483TlfPn930fvBJQhWVr6qyMXUqx/HjuVfE2kz4jkrmV/k+3dCjlti//ZuvI0hjpBx5+b33mordat9ayHHyEIl1pGD4QN/oetUxOwrvNkTmajwY7sFQ5m0idcY=
Received: from PU1PR06CA0019.apcprd06.prod.outlook.com (2603:1096:803:2a::31)
 by JH0PR02MB6438.apcprd02.prod.outlook.com (2603:1096:990:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 12:58:29 +0000
Received: from HK3PEPF0000021A.apcprd03.prod.outlook.com
 (2603:1096:803:2a:cafe::e5) by PU1PR06CA0019.outlook.office365.com
 (2603:1096:803:2a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 12:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021A.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 12:58:29 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 8 May
 2024 20:58:28 +0800
From: <hailong.liu@oppo.com>
To: <akpm@linux-foundation.org>
CC: <urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<xiang@kernel.org>, <chao@kernel.org>, Hailong.Liu <hailong.liu@oppo.com>,
	Oven <liyangouwen1@oppo.com>
Subject: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if called with __GFP_NOFAIL
Date: Wed, 8 May 2024 20:58:08 +0800
Message-ID: <20240508125808.28882-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021A:EE_|JH0PR02MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d36560-5d0c-430e-b0e1-08dc6f5e8ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LDy49rz/NenaJ57q5e4u/v/1xBSds0zJVxvVrbuFR79qM6ZV2sOru+KlNoP1?=
 =?us-ascii?Q?OWsPlpjr+HX9XbpbAh9KjI0TSxPpBgIm3e027Dc1MK96YsyQ+l04TvJ6jGz1?=
 =?us-ascii?Q?cgVROOLig+Yg6+DXl+RKc08cAiBwbcVAo+aDSEqflhE2wIEkXTS6uBJSoGre?=
 =?us-ascii?Q?LvyBhnD4hvazrS6SPU1JoTfZJ9zVV0z97CQX07JU6MoWEBsJoMBra/7Ds1QO?=
 =?us-ascii?Q?uVwZveZBBoShUPMlSOTyHhUb+rNBWH57k8uIeGH2VKZZVGGmooV5Y88HNJo2?=
 =?us-ascii?Q?tCTDIL7cnrKIVXgYa1bhvfLwQ4+Hk9kIffm+17Xnv42N+OsffrCgHzxFkG+L?=
 =?us-ascii?Q?lAWYritC3py3vR5ty2q5hO6+y6JwhJR2pR1sxxHFwXYwvcg07k1RVcZgIt4s?=
 =?us-ascii?Q?Ch5NRZFihxTaFTHtRCAbSCWX7PrjcQFAiKjxhAaUvlifDSfPUk2zrvAQr8iy?=
 =?us-ascii?Q?hWgJGe9kz6A6X4dcClVKwKDnzn1fdHcmT1dVtl5pW0qeebB6V5X1234vj1SO?=
 =?us-ascii?Q?aa/OpFQVh8qE06w70I5mbliMrw8xRfVxLgPMPTtpUAC2nLNP/kVgUYcUsehq?=
 =?us-ascii?Q?dFOXqxsrvAXxaN7EyvGjKadQlE2nrS9H1atHTPfldjiLpNdP2n3sqJX/0a50?=
 =?us-ascii?Q?Nygmb7MmZc8Pvzn1uzQYjmGoVtanLX9LMEBI+Ve2DRH5ORZdIULVn3Udv8JG?=
 =?us-ascii?Q?XwXH0oVirN7svFGEyjDIwxzd6JZWA+nHm6b62tdY9dlvVL8xpumAAYwGf4Pz?=
 =?us-ascii?Q?YKLWeqFkp5yQWnfTOtpCLgP9kp+vBWyIYkmqTvI6Ysed5jnsW3X1xBK5r3Td?=
 =?us-ascii?Q?vS2GIr0ZNCSiAOGm4+2Y4EculaNQede6A3GJndXlgYBXUlFhoj0JYPYUL91O?=
 =?us-ascii?Q?VGplPpqmPaK3NEZ+kHd4Bap+4LVQQhQbFrIR9qcXUTXcO85WhHv5YpVUCFAj?=
 =?us-ascii?Q?N0CwtQjKiW8Gq8v8864p/Cgy5pOONAfYnQrX0jMbE5ywhQ5Has8f9YAZysuv?=
 =?us-ascii?Q?5mSLqtnZMm97zUOWtPY8JT4fRNupqz89nlmdLtxO7jj9ferySoQMIg0K2Uhn?=
 =?us-ascii?Q?B+Dqwfylhjpua47g6ZeeyhC/QGNDNp2AjDWJ5nIa9XoWM0x3cyW15IoRFYPQ?=
 =?us-ascii?Q?4noqKT5YCf58HFdUG3/02OWsY/wInMSIOjCXweDu8vSd2oE05U85eLPb8OAf?=
 =?us-ascii?Q?aL4syvzd50oGlvf5uU0HU/kzCUJPhr+lAE3Vbm03pS2btmVELKJUtaGV3fHc?=
 =?us-ascii?Q?0bpKKoV0fzkkzRD4ZLXJksA+ut8LgiJY3tvC20MtITWDkmkli/onABOd46dY?=
 =?us-ascii?Q?H0fZh5rLOkaAqXPRdq/bNKsxe4sURUnhFyUFEHOcTMOywmt93tlrRBWAIvej?=
 =?us-ascii?Q?GbT6l1IclATfxXA5GfJyJpNZi1jc?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 12:58:29.1134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d36560-5d0c-430e-b0e1-08dc6f5e8ec5
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6438

From: "Hailong.Liu" <hailong.liu@oppo.com>

Commit a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
includes support for __GFP_NOFAIL, but it presents a conflict with
commit dd544141b9eb ("vmalloc: back off when the current task is
OOM-killed"). A possible scenario is as belows:

process-a
kvcalloc(n, m, GFP_KERNEL | __GFP_NOFAIL)
    __vmalloc_node_range()
	__vmalloc_area_node()
	    vm_area_alloc_pages()
            --> oom-killer send SIGKILL to process-a
            if (fatal_signal_pending(current)) break;
--> return NULL;

to fix this, do not check fatal_signal_pending() in vm_area_alloc_pages()
if __GFP_NOFAIL set.

Reported-by: Oven <liyangouwen1@oppo.com>
Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6641be0ca80b..2f359d08bf8d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3560,7 +3560,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,

 	/* High-order pages or fallback path if "bulk" fails. */
 	while (nr_allocated < nr_pages) {
-		if (fatal_signal_pending(current))
+		if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
 			break;

 		if (nid == NUMA_NO_NODE)
---
This issue occurred during OPLUS KASAN test. Below is part of the log

-> send signal
[65731.222840] [ T1308] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/apps/uid_10198,task=gs.intelligence,pid=32454,uid=10198

[65731.259685] [T32454] Call trace:
[65731.259698] [T32454]  dump_backtrace+0xf4/0x118
[65731.259734] [T32454]  show_stack+0x18/0x24
[65731.259756] [T32454]  dump_stack_lvl+0x60/0x7c
[65731.259781] [T32454]  dump_stack+0x18/0x38
[65731.259800] [T32454]  mrdump_common_die+0x250/0x39c [mrdump]
[65731.259936] [T32454]  ipanic_die+0x20/0x34 [mrdump]
[65731.260019] [T32454]  atomic_notifier_call_chain+0xb4/0xfc
[65731.260047] [T32454]  notify_die+0x114/0x198
[65731.260073] [T32454]  die+0xf4/0x5b4
[65731.260098] [T32454]  die_kernel_fault+0x80/0x98
[65731.260124] [T32454]  __do_kernel_fault+0x160/0x2a8
[65731.260146] [T32454]  do_bad_area+0x68/0x148
[65731.260174] [T32454]  do_mem_abort+0x151c/0x1b34
[65731.260204] [T32454]  el1_abort+0x3c/0x5c
[65731.260227] [T32454]  el1h_64_sync_handler+0x54/0x90
[65731.260248] [T32454]  el1h_64_sync+0x68/0x6c
[65731.260269] [T32454]  z_erofs_decompress_queue+0x7f0/0x2258
--> be->decompressed_pages = kvcalloc(be->nr_pages, sizeof(struct page *), GFP_KERNEL | __GFP_NOFAIL);
	kernel panic by NULL pointer dereference.
	erofs assume kvmalloc with __GFP_NOFAIL never return NULL.

[65731.260293] [T32454]  z_erofs_runqueue+0xf30/0x104c
[65731.260314] [T32454]  z_erofs_readahead+0x4f0/0x968
[65731.260339] [T32454]  read_pages+0x170/0xadc
[65731.260364] [T32454]  page_cache_ra_unbounded+0x874/0xf30
[65731.260388] [T32454]  page_cache_ra_order+0x24c/0x714
[65731.260411] [T32454]  filemap_fault+0xbf0/0x1a74
[65731.260437] [T32454]  __do_fault+0xd0/0x33c
[65731.260462] [T32454]  handle_mm_fault+0xf74/0x3fe0
[65731.260486] [T32454]  do_mem_abort+0x54c/0x1b34
[65731.260509] [T32454]  el0_da+0x44/0x94
[65731.260531] [T32454]  el0t_64_sync_handler+0x98/0xb4
[65731.260553] [T32454]  el0t_64_sync+0x198/0x19c

--
2.34.1


