Return-Path: <linux-kernel+bounces-295073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D31959652
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677161C20D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A9C4B5C1;
	Wed, 21 Aug 2024 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Ep8nPDWG"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2053.outbound.protection.outlook.com [40.107.117.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B013192D9A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226398; cv=fail; b=p2baRSzRhHgWKvLJHEVtW8+bQebFdG3d/4T4CM6rVsTWmDqinRUhlXlntvE6RyhA7WRyFW4jP0grdfhk+n/NO28LYLKS40oKE3SEX8LeM7Zv3mab+If7CCU1s0OoovzHVUlMu0m+aK2hS4FR3NovdmtMVbp3Cre2L+tcvUbNqr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226398; c=relaxed/simple;
	bh=DT7W/gN1reTTOj09xr+QYb9HVeNa4ZXNWDThA7SiMFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLLf5OZFlIkI3RmLBOuDqaKkf+yizgeadkv3Hgax6SLeYVNTyBfi6S1riwdCusx82PC+/J9VVwGf1/V57krnzxi6DoZe1OF4pVpjfbudBmirIswyFUd2X7etMgddkHkYYYLiE8zkQjRgG1norG/QWmcmbMvLYDloVFmKmgFIP7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Ep8nPDWG; arc=fail smtp.client-ip=40.107.117.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6H8vIQhmuWslIKGDnMkpg6mSYkYVoNLvrwqH/t7w9uDIvlO7e5AEAA2LVhi4co9A02aeqobbylGoknxd7Y1yjUE+Ifdo38wj+ErEpT//p/8AOEhAjBZ7BDoTgh1iU3Lh1U95HsPIGaMlJW+NAqAeyNt7j+VBKT1YvdZ3pggqaNYBMnSmAn6qkPscKGGxQvSTYcxLmeJamww28PaFmJ+a1TG1m30SxTTLzGx+JhBzUAmBvwYIq8hPupdKwkUYfsE5lslEoxOIMu85Mx0+i77tT7Qmr8uTqwpqG/YOz46Wy3cJ/4/fEun0Rx5OcydMfe6bFKjKnsbnVewkmsB+y+ANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqu7mtmRwYRQNWR3puKoVdA/0XNY8g5SYZR3rqVFIPw=;
 b=JbmZgnsPlEQb+KoqC8b9E8h4rzA4hmGEx/kJhejaPstyfvJZ+xktuSetHbFbKCjBJqD4ICFImou4EGbcrX3K5gHORsmGwjWLJRowjn14sYgmKb73huJzRpMf4EnfiKTWDgVwd0+33EGUashJXRtwsFvQodSxOAK8uNtQGP71SYte0MUc/g1TXoTf9tMMUrDTU/9p/4VCccxLBMd7vBOKVCpXcQlrYOBAeUSkzRv4j7Az5zdFAPg/kwSDi5Qxn8QxeRkfA4zLJCfb3uM77VD63ft1rt796WTixMhqNr1gtvjawehT/Yl3YxMDfJrsQNc9Q4VzjrNXcyddTHbsNQKNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqu7mtmRwYRQNWR3puKoVdA/0XNY8g5SYZR3rqVFIPw=;
 b=Ep8nPDWGOePu8JROONE9Mtt3Zazp+Bcx9vObRm7cKs9+Q+Nw7AcI4Abj6OaVUKoZDJo8J3+h8EWqyE733vaQ85AvAn/bugbTFlTI1g/ZpvgNhwQBDtiIEOZ7HFpmBh/4Jr2GKoKsLGPxfx5n/E8/pA2s81lsX+ydOoDEQ2BmNqo=
Received: from SI2PR02CA0038.apcprd02.prod.outlook.com (2603:1096:4:196::22)
 by JH0PR02MB6991.apcprd02.prod.outlook.com (2603:1096:990:44::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 07:46:29 +0000
Received: from HK3PEPF0000021A.apcprd03.prod.outlook.com
 (2603:1096:4:196:cafe::33) by SI2PR02CA0038.outlook.office365.com
 (2603:1096:4:196::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Wed, 21 Aug 2024 07:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021A.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 07:46:27 +0000
Received: from localhost.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 15:46:20 +0800
From: <hanchuanhua@oppo.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: <baolin.wang@linux.alibaba.com>, <chrisl@kernel.org>, <david@redhat.com>,
	<hannes@cmpxchg.org>, <hughd@google.com>, <kaleshsingh@google.com>,
	<kasong@tencent.com>, <linux-kernel@vger.kernel.org>, <mhocko@suse.com>,
	<minchan@kernel.org>, <nphamcs@gmail.com>, <ryan.roberts@arm.com>,
	<senozhatsky@chromium.org>, <shakeel.butt@linux.dev>, <shy828301@gmail.com>,
	<surenb@google.com>, <v-songbaohua@oppo.com>, <willy@infradead.org>,
	<xiang@kernel.org>, <ying.huang@intel.com>, <yosryahmed@google.com>,
	<hch@infradead.org>, <ryncsn@gmail.com>, Chuanhua Han <hanchuanhua@oppo.com>
Subject: [PATCH v7 2/2] mm: support large folios swap-in for sync io devices
Date: Wed, 21 Aug 2024 15:45:40 +0800
Message-ID: <20240821074541.516249-3-hanchuanhua@oppo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821074541.516249-1-hanchuanhua@oppo.com>
References: <20240821074541.516249-1-hanchuanhua@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021A:EE_|JH0PR02MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: a55ebdac-7426-4a62-ee17-08dcc1b55df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7HxtBgaD2Nbv5wjUXQ73sXq++k9+uy6r0H7cttJHeHhbiIJKfv7V4x0ZOVrj?=
 =?us-ascii?Q?Ko4beoiklKX1XsPLC3tkfqUQp/ZIVxDA3pcUhVp4Cmy+XTOSeXORNdNGVbit?=
 =?us-ascii?Q?r8CiCzHmAV+OsCqDuzm2RR1gmIeryY+OeEnhwbqybGV0bin9vQwfHr4VPy/i?=
 =?us-ascii?Q?NOZdZ+Tlkgj5RkhVBNWiQg2wOPZGQPtrWk0T7zaWjsX5Afpptu285/b60lS6?=
 =?us-ascii?Q?hCGYzubbIuWmYIYMIaNeOa83kWZkyN0Jr4nY2oGv4FnZGGclnuTIPs+A10Pz?=
 =?us-ascii?Q?Qf2jTah7ojpoWEnetvn9VLEjuY2Rsw7G7bH+PobTaRQkBEOUj0OoHlwN/Pvu?=
 =?us-ascii?Q?7gSckXTpyRkQMZKGRIUn5A61ROl88+gwImeUEpnTmjiFdSIjYDcd8ZyC8w6d?=
 =?us-ascii?Q?QBN+wiCzGwbcKz5AMdeoaPMnUeRQvf1bPpFS+eJyG+oVsgtyDP5AuQZ8Hidu?=
 =?us-ascii?Q?oo857UpGcCAqT5G2czaOAdBo2fJcYomeIjaqAGaIPnTamKDSG977U6yp7KJe?=
 =?us-ascii?Q?B+uvKWX+4G+Qorw73NptoYbUy0BQzRtgWKwR1pG9CD/aCqzxG++YEzLTKabK?=
 =?us-ascii?Q?IIvELE1ZHaqGHD8KNMzO9gCADz2gPp/7k8sUluyPQPxXVnSBPvNi/evdMcGR?=
 =?us-ascii?Q?iKZ1lsnuJ9weKq7uaHrPR3tSZu5/x8qyvJkJqXVrNYd/5/1qoHyRSOe0PJ2m?=
 =?us-ascii?Q?2DD6IRKLXcp0Dl0uiugQ3uDrMHxgAErh7SJp+B8XknQTQ9H209vi/60Bmkri?=
 =?us-ascii?Q?YLJZFcenZVLeEM382FuF+n3XfgUMeBGf+wmCEr7OdnV1qSoyalhvMS3UsLHD?=
 =?us-ascii?Q?IZ3B4J+zxCOUo3lE1Mu+oedFAKE4ARcu9MbRY22ZwnE8h9mJOIuW546tegud?=
 =?us-ascii?Q?CYQnIAvz84AMdaK9jjmNWhf95uW/TU12NoG5ZgdM5Z6gaafF+ppybEPk/IP0?=
 =?us-ascii?Q?MRV160Isv2EpGBUidCC0ob6oCSa3sJwQ+Ycq5AyvlG97Tf9AtdBPnZxY143P?=
 =?us-ascii?Q?UgCG7nVYaB2o5NfetHjkGKgwH0sIIkQuRc+GoK7LS3MRpA8X4W5f03WSQSqU?=
 =?us-ascii?Q?Wq9t5eHiUrU5GU/3fXBu/6rRdWoLhJcrQBVdzQtl68gQzJUPzyW8IC8AYSou?=
 =?us-ascii?Q?41aHLlAfogEGkqTLnXDghP8hbZMDg4iPLpSSxolkxZLQjGQreNLFIPuelmeH?=
 =?us-ascii?Q?wAYELY6kASDKlw4Ahp0Ey4WdCpMQYX6kqhXefsivH1mfvVKdiGSizcQWvd6G?=
 =?us-ascii?Q?VDvI/ZkoAIJnVr4Tepte07a6zjzyJebimcbSvRJx4MfslFlg/yl5XsegqLDd?=
 =?us-ascii?Q?9QvuxYYPv797A6HwCprPKt+QXEmDatByEGIB3z1S9na4dytnx2xdT7Y+hyEQ?=
 =?us-ascii?Q?UM6aXTNxX0GRJnuYLedPTX/HdPHZaIksbUX5vPJIWmznwzEfxvNcmZ+8M0zb?=
 =?us-ascii?Q?NlXDCGoiYS3frM0DmLrIYTd1QYllKOhM?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:46:27.9341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a55ebdac-7426-4a62-ee17-08dcc1b55df4
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6991

From: Chuanhua Han <hanchuanhua@oppo.com>

Currently, we have mTHP features, but unfortunately, without support for
large folio swap-ins, once these large folios are swapped out, they are
lost because mTHP swap is a one-way process. The lack of mTHP swap-in
functionality prevents mTHP from being used on devices like Android that
heavily rely on swap.

This patch introduces mTHP swap-in support. It starts from sync devices
such as zRAM. This is probably the simplest and most common use case,
benefiting billions of Android phones and similar devices with minimal
implementation cost. In this straightforward scenario, large folios are
always exclusive, eliminating the need to handle complex rmap and
swapcache issues.

It offers several benefits:
1. Enables bidirectional mTHP swapping, allowing retrieval of mTHP after
   swap-out and swap-in. Large folios in the buddy system are also
   preserved as much as possible, rather than being fragmented due
   to swap-in.

2. Eliminates fragmentation in swap slots and supports successful
   THP_SWPOUT.

   w/o this patch (Refer to the data from Chris's and Kairui's latest
   swap allocator optimization while running ./thp_swap_allocator_test
   w/o "-a" option [1]):

   ./thp_swap_allocator_test
   Iteration 1: swpout inc: 233, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 2: swpout inc: 131, swpout fallback inc: 101, Fallback percentage: 43.53%
   Iteration 3: swpout inc: 71, swpout fallback inc: 155, Fallback percentage: 68.58%
   Iteration 4: swpout inc: 55, swpout fallback inc: 168, Fallback percentage: 75.34%
   Iteration 5: swpout inc: 35, swpout fallback inc: 191, Fallback percentage: 84.51%
   Iteration 6: swpout inc: 25, swpout fallback inc: 199, Fallback percentage: 88.84%
   Iteration 7: swpout inc: 23, swpout fallback inc: 205, Fallback percentage: 89.91%
   Iteration 8: swpout inc: 9, swpout fallback inc: 219, Fallback percentage: 96.05%
   Iteration 9: swpout inc: 13, swpout fallback inc: 213, Fallback percentage: 94.25%
   Iteration 10: swpout inc: 12, swpout fallback inc: 216, Fallback percentage: 94.74%
   Iteration 11: swpout inc: 16, swpout fallback inc: 213, Fallback percentage: 93.01%
   Iteration 12: swpout inc: 10, swpout fallback inc: 210, Fallback percentage: 95.45%
   Iteration 13: swpout inc: 16, swpout fallback inc: 212, Fallback percentage: 92.98%
   Iteration 14: swpout inc: 12, swpout fallback inc: 212, Fallback percentage: 94.64%
   Iteration 15: swpout inc: 15, swpout fallback inc: 211, Fallback percentage: 93.36%
   Iteration 16: swpout inc: 15, swpout fallback inc: 200, Fallback percentage: 93.02%
   Iteration 17: swpout inc: 9, swpout fallback inc: 220, Fallback percentage: 96.07%

   w/ this patch (always 0%):
   Iteration 1: swpout inc: 948, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 2: swpout inc: 953, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 3: swpout inc: 950, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 4: swpout inc: 952, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 5: swpout inc: 950, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 6: swpout inc: 950, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 7: swpout inc: 947, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 8: swpout inc: 950, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 9: swpout inc: 950, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 10: swpout inc: 945, swpout fallback inc: 0, Fallback percentage: 0.00%
   Iteration 11: swpout inc: 947, swpout fallback inc: 0, Fallback percentage: 0.00%
   ...

3. With both mTHP swap-out and swap-in supported, we offer the option to enable
   zsmalloc compression/decompression with larger granularity[2]. The upcoming
   optimization in zsmalloc will significantly increase swap speed and improve
   compression efficiency. Tested by running 100 iterations of swapping 100MiB
   of anon memory, the swap speed improved dramatically:
                time consumption of swapin(ms)   time consumption of swapout(ms)
     lz4 4k                  45274                    90540
     lz4 64k                 22942                    55667
     zstdn 4k                85035                    186585
     zstdn 64k               46558                    118533

    The compression ratio also improved, as evaluated with 1 GiB of data:
     granularity   orig_data_size   compr_data_size
     4KiB-zstd      1048576000       246876055
     64KiB-zstd     1048576000       199763892

   Without mTHP swap-in, the potential optimizations in zsmalloc cannot be
   realized.

4. Even mTHP swap-in itself can reduce swap-in page faults by a factor
   of nr_pages. Swapping in content filled with the same data 0x11, w/o
   and w/ the patch for five rounds (Since the content is the same,
   decompression will be very fast. This primarily assesses the impact of
   reduced page faults):

  swp in bandwidth(bytes/ms)    w/o              w/
   round1                     624152          1127501
   round2                     631672          1127501
   round3                     620459          1139756
   round4                     606113          1139756
   round5                     624152          1152281
   avg                        621310          1137359      +83%

[1] https://lore.kernel.org/all/20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org/
[2] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.com/

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 250 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 223 insertions(+), 27 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b9fe2f354878..7aa0358a4160 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3986,6 +3986,184 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
+static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct folio *folio;
+	swp_entry_t entry;
+
+	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
+				vmf->address, false);
+	if (!folio)
+		return NULL;
+
+	entry = pte_to_swp_entry(vmf->orig_pte);
+	if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
+					   GFP_KERNEL, entry)) {
+		folio_put(folio);
+		return NULL;
+	}
+
+	return folio;
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/*
+ * Check if the PTEs within a range are contiguous swap entries
+ * and have no cache when check_no_cache is true.
+ */
+static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep,
+			   int nr_pages, bool check_no_cache)
+{
+	struct swap_info_struct *si;
+	unsigned long addr;
+	swp_entry_t entry;
+	pgoff_t offset;
+	int idx, i;
+	pte_t pte;
+
+	addr = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
+	idx = (vmf->address - addr) / PAGE_SIZE;
+	pte = ptep_get(ptep);
+
+	if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
+		return false;
+	entry = pte_to_swp_entry(pte);
+	offset = swp_offset(entry);
+	if (swap_pte_batch(ptep, nr_pages, pte) != nr_pages)
+		return false;
+
+	if (!check_no_cache)
+		return true;
+
+	si = swp_swap_info(entry);
+	/*
+	 * While allocating a large folio and doing swap_read_folio, which is
+	 * the case the being faulted pte doesn't have swapcache. We need to
+	 * ensure all PTEs have no cache as well, otherwise, we might go to
+	 * swap devices while the content is in swapcache.
+	 */
+	for (i = 0; i < nr_pages; i++) {
+		if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
+			return false;
+	}
+
+	return true;
+}
+
+static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
+						     unsigned long addr,
+						     unsigned long orders)
+{
+	int order, nr;
+
+	order = highest_order(orders);
+
+	/*
+	 * To swap in a THP with nr pages, we require that its first swap_offset
+	 * is aligned with that number, as it was when the THP was swapped out.
+	 * This helps filter out most invalid entries.
+	 */
+	while (orders) {
+		nr = 1 << order;
+		if ((addr >> PAGE_SHIFT) % nr == swp_offset % nr)
+			break;
+		order = next_order(&orders, order);
+	}
+
+	return orders;
+}
+
+static struct folio *alloc_swap_folio(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long orders;
+	struct folio *folio;
+	unsigned long addr;
+	swp_entry_t entry;
+	spinlock_t *ptl;
+	pte_t *pte;
+	gfp_t gfp;
+	int order;
+
+	/*
+	 * If uffd is active for the vma we need per-page fault fidelity to
+	 * maintain the uffd semantics.
+	 */
+	if (unlikely(userfaultfd_armed(vma)))
+		goto fallback;
+
+	/*
+	 * A large swapped out folio could be partially or fully in zswap. We
+	 * lack handling for such cases, so fallback to swapping in order-0
+	 * folio.
+	 */
+	if (!zswap_never_enabled())
+		goto fallback;
+
+	entry = pte_to_swp_entry(vmf->orig_pte);
+	/*
+	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
+	 * and suitable for swapping THP.
+	 */
+	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
+			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
+	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
+	orders = thp_swap_suitable_orders(swp_offset(entry),
+					  vmf->address, orders);
+
+	if (!orders)
+		goto fallback;
+
+	pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
+				  vmf->address & PMD_MASK, &ptl);
+	if (unlikely(!pte))
+		goto fallback;
+
+	/*
+	 * For do_swap_page, find the highest order where the aligned range is
+	 * completely swap entries with contiguous swap offsets.
+	 */
+	order = highest_order(orders);
+	while (orders) {
+		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
+		if (can_swapin_thp(vmf, pte + pte_index(addr), 1 << order, true))
+			break;
+		order = next_order(&orders, order);
+	}
+
+	pte_unmap_unlock(pte, ptl);
+
+	/* Try allocating the highest of the remaining orders. */
+	gfp = vma_thp_gfp_mask(vma);
+	while (orders) {
+		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
+		folio = vma_alloc_folio(gfp, order, vma, addr, true);
+		if (folio) {
+			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
+							    gfp, entry))
+				return folio;
+			folio_put(folio);
+		}
+		order = next_order(&orders, order);
+	}
+
+fallback:
+	return __alloc_swap_folio(vmf);
+}
+#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
+static inline bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep,
+				  int nr_pages, bool check_no_cache)
+{
+	return false;
+}
+
+static struct folio *alloc_swap_folio(struct vm_fault *vmf)
+{
+	return __alloc_swap_folio(vmf);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -4074,34 +4252,34 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
-			/*
-			 * Prevent parallel swapin from proceeding with
-			 * the cache flag. Otherwise, another thread may
-			 * finish swapin first, free the entry, and swapout
-			 * reusing the same entry. It's undetectable as
-			 * pte_same() returns true due to entry reuse.
-			 */
-			if (swapcache_prepare(entry, 1)) {
-				/* Relax a bit to prevent rapid repeated page faults */
-				schedule_timeout_uninterruptible(1);
-				goto out;
-			}
-			need_clear_cache = true;
-
 			/* skip swapcache */
-			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
-						vma, vmf->address, false);
+			folio = alloc_swap_folio(vmf);
 			if (folio) {
 				__folio_set_locked(folio);
 				__folio_set_swapbacked(folio);
 
-				if (mem_cgroup_swapin_charge_folio(folio,
-							vma->vm_mm, GFP_KERNEL,
-							entry)) {
-					ret = VM_FAULT_OOM;
+				nr_pages = folio_nr_pages(folio);
+				if (folio_test_large(folio))
+					entry.val = ALIGN_DOWN(entry.val, nr_pages);
+				/*
+				 * Prevent parallel swapin from proceeding with
+				 * the cache flag. Otherwise, another thread
+				 * may finish swapin first, free the entry, and
+				 * swapout reusing the same entry. It's
+				 * undetectable as pte_same() returns true due
+				 * to entry reuse.
+				 */
+				if (swapcache_prepare(entry, nr_pages)) {
+					/*
+					 * Relax a bit to prevent rapid
+					 * repeated page faults.
+					 */
+					schedule_timeout_uninterruptible(1);
 					goto out_page;
 				}
-				mem_cgroup_swapin_uncharge_swap(entry, 1);
+				need_clear_cache = true;
+
+				mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
 
 				shadow = get_shadow_from_swap_cache(entry);
 				if (shadow)
@@ -4207,6 +4385,23 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_nomap;
 	}
 
+	/* allocated large folios for SWP_SYNCHRONOUS_IO */
+	if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
+		unsigned long nr = folio_nr_pages(folio);
+		unsigned long folio_start = ALIGN_DOWN(vmf->address,
+						       nr * PAGE_SIZE);
+		unsigned long idx = (vmf->address - folio_start) / PAGE_SIZE;
+		pte_t *folio_ptep = vmf->pte - idx;
+
+		if (!can_swapin_thp(vmf, folio_ptep, nr, false))
+			goto out_nomap;
+
+		page_idx = idx;
+		address = folio_start;
+		ptep = folio_ptep;
+		goto check_folio;
+	}
+
 	nr_pages = 1;
 	page_idx = 0;
 	address = vmf->address;
@@ -4338,11 +4533,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_add_lru_vma(folio, vma);
 	} else if (!folio_test_anon(folio)) {
 		/*
-		 * We currently only expect small !anon folios, which are either
-		 * fully exclusive or fully shared. If we ever get large folios
-		 * here, we have to be careful.
+		 * We currently only expect small !anon folios which are either
+		 * fully exclusive or fully shared, or new allocated large
+		 * folios which are fully exclusive. If we ever get large
+		 * folios within swapcache here, we have to be careful.
 		 */
-		VM_WARN_ON_ONCE(folio_test_large(folio));
+		VM_WARN_ON_ONCE(folio_test_large(folio) && folio_test_swapcache(folio));
 		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
 		folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
 	} else {
@@ -4385,7 +4581,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 out:
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
 	if (need_clear_cache)
-		swapcache_clear(si, entry, 1);
+		swapcache_clear(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4401,7 +4597,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_put(swapcache);
 	}
 	if (need_clear_cache)
-		swapcache_clear(si, entry, 1);
+		swapcache_clear(si, entry, nr_pages);
 	if (si)
 		put_swap_device(si);
 	return ret;
-- 
2.43.0


