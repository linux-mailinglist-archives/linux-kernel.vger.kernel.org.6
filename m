Return-Path: <linux-kernel+bounces-295072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D22E959650
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774051F23805
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD87F19ABB9;
	Wed, 21 Aug 2024 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="c+Pj7Txo"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17432192D85
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226397; cv=fail; b=dgJKJeDI9Y/VxeBhqL6ofthKjtiLVbmLAVLUaE6pgSGmHNflnT06r42gK9rnm7SWe79GiSS4xUag5qg8TtkS2xXkL/s6OswcvgcgVikcsstGECC+putsiTFoAtPzDAyMH1qGG5tLTlICWLub5ODf0WErUHF63aC+N4g4hJn50NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226397; c=relaxed/simple;
	bh=UibxDN7S42btV2XRAgxY35AN0FgZW4Rm3q4+U+HObmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tS/5NEHKrFUPFO7Z1A4PlIMHpxBazKDN3sUl/CCD3g0BtacAE3+5H6UKWBZKO9YlFtkqH4UFFdjuZ+HTloPaYlFZpG4KY8fX6Cgcgj2EafGeNWuKtIfbyGW0IJEzHrEYilnodFY95mFP4Ewr77QyOlpabKYuHHTfuIm5mHDu3eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=c+Pj7Txo; arc=fail smtp.client-ip=40.107.255.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBq5rZLwAA4fEcQwTmerlrpz+qpeux3xt7/RCf8RsfK+TljpzF6ZgVHCUDLR2GYRkqkb8+IgCqA3/4YyBaPcEDWBC68/Bjf7ZxVXdJg7yN5tjeCLIvSXqlfnYLwC+zXk6cjsqf+MzJ3nk8yaTgyilpY1ecKjTjA80Uhk3z5bo1y4GzivNOqMledtGN3YuZ+6hvL09DhXiE651meiUEDmeTju642B/z6GWATl6SPOXlCpe60+pgVH37fVAI0opiXWdfpXfjEwbMXYaK8JSCt2SJHKvkiRhJ4M3sPEdoYyg3ZiV6s9rkSXrYTS7TwhmSXe9VYiU6RANl++79UvP5ZSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHaBFw9+bIi2qBKwhuz2U99Ei1sm+X/y2E7KaDyiOMQ=;
 b=MtxC0m7omG1gLWeqmH4IaQ8hRpHaf8Z/FwLYeTVU0NhpraqhF0CbPm7D2BG2mrjTu/PDUTDdlGtD7OgW+/ZaMBm5AgOejJsKsiDy+vsMwIRkjLeDLS9BOyK9Vo/NkTd30X2dMTz8yhUOTnDYVF4UlT4XegNEUfFPp/a4LncMP6DoDYNAw9nsBR7eCMH1XF+53vNCuy2ZE79l1uAnhwukn2ooid4eX7XhIIzVchWshhLgck51Yt15hC7uHMXJgx0uAdrk1KW1HeLCpocTqXtjgjDBcs7Xg2GYfmmB9YXivuOhtDw9DqblYf43wqNh9dJ/xF/Pf6DoFe58C/Nthnn5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHaBFw9+bIi2qBKwhuz2U99Ei1sm+X/y2E7KaDyiOMQ=;
 b=c+Pj7TxobHuCrsLstzFyrGDnDB8r6JDDDmPfz6f53ByqMAmBOq6eXpFXPligvec07e35sBgYIrjuA70MxuSrOLpFnagsgDukq3jUJGOHJ0aYRLPSISRukvxDFNCo7q6LbzD1zbE5olmMOYDYzruK7dpT+i5eKFPFAw1maLdNQr8=
Received: from SI2PR02CA0037.apcprd02.prod.outlook.com (2603:1096:4:196::8) by
 TYZPR02MB7986.apcprd02.prod.outlook.com (2603:1096:405:b9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Wed, 21 Aug 2024 07:46:23 +0000
Received: from HK3PEPF0000021A.apcprd03.prod.outlook.com
 (2603:1096:4:196:cafe::20) by SI2PR02CA0037.outlook.office365.com
 (2603:1096:4:196::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25 via Frontend
 Transport; Wed, 21 Aug 2024 07:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021A.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 07:46:21 +0000
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
Subject: [PATCH v7 0/2] mm: Ignite large folios swap-in support
Date: Wed, 21 Aug 2024 15:45:38 +0800
Message-ID: <20240821074541.516249-1-hanchuanhua@oppo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021A:EE_|TYZPR02MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 09db3271-3e79-4fbd-8d9c-08dcc1b55a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?allmSGFIZGRsOTVLRXlJV3ZDakZhbnVVcnlhc1VJQXA5K3NUWVMrb2JOL2VT?=
 =?utf-8?B?WHNEMFBBRGZnV1hGLzJQWHZrSlNWaW1HZWkrc1ZaVVZKaVZrSlhUT2Q2ZHVl?=
 =?utf-8?B?WlI0NXNpTTdXcXp5cGlKSmYzMHFKNlRDdWdySHRyZU45V3NSQzgwL1JzMWZt?=
 =?utf-8?B?d3lhZW5DV0lFRDNvZzBPbDdjK3hkekVFd0FGK05qTks1RGY2RmtpMWV1M3RS?=
 =?utf-8?B?UzM5MHJyZGRDeXFBV0x3blFCUVNTZUNNM1ZUSGpZMWJ3OUFEMUlUMTA2MGhB?=
 =?utf-8?B?VWZob0lHSHdaWDFOL2FZOTFlckJwdUZKMEEyUnF0eGpzK24vclBSMms1eUgv?=
 =?utf-8?B?enVXTG1wSHBuT3N1ZHJ0OUVuTjJhWTZJS2dhT1IxOHFyZjFvQndmdUZvZkhp?=
 =?utf-8?B?cGRkN2dSdTVadGdxZ0lJeGJQZVFhRE9mUWkxem96Z1d3bDlVY3ZoTlRSM2w5?=
 =?utf-8?B?SmRQeHFXL2xCYk1jUE1hd2NhMTdSNHMvUVhocGdKNUthQjhHRzNqc0NlSUpJ?=
 =?utf-8?B?T2Rqa3huU3hBUGd2R05CRWxjKzF2aDZxRzJNZzU2RnVSak9kbXBKbTZHUklo?=
 =?utf-8?B?UlI2bDJDaTljU1JBSjdjOFNJV2NjV2daUVRMUFo2RFpoWXpCTzNyeEdTTnZH?=
 =?utf-8?B?clZCa3c2cG9Tb1ErcUVKczFybXVnenZ2eC81a0lEL3NYK1RJdXFUa2tPUU5s?=
 =?utf-8?B?NkNZeDRXQVJjL1JMcjhuRklOQ0l0WnA0RzRCRGNybUtvOG94dEU2SjNleXAy?=
 =?utf-8?B?OThzRFZXV1dzdXNVbzljeWt2R1JyckxlR2lnOHFKbWRCNXVVUmhxRHBRcWtr?=
 =?utf-8?B?djE2cDh2cHVQemhoUjhQS3BwdGp5UWNqMmI3R3ROOFlvSjhKeDlBRW9tQ1lC?=
 =?utf-8?B?QUNybGRzUUNGcUtsUzJOVEppZlEzeU9aY3VWYXdGOE1KUVpiaVNHU2ltWkFs?=
 =?utf-8?B?cXZWcSszUmtrYzRRZWNwRURjeFA3aUhNblJoeVJMbnpoUjNJeEhOTm9WVkRs?=
 =?utf-8?B?NFZiZ2hVcktKS3IvQWRKL0RmUEQxOHZWMTZ4M1k1dUJsbFFmeSt6b1pyQlc2?=
 =?utf-8?B?ZEFzL0ZUWndvTjZORE5Gc1d6bjdsUXoxck5wRmF1ZG5zWTV5RVE1Ujl3N0Iw?=
 =?utf-8?B?MERrUnlqVFcwU2tUTWpKYXU4ajZHbXY5YXhRUVo5aEtTdUxrenBST3AzOHdE?=
 =?utf-8?B?cG1rYkJrTmx5YmltYzZpOHpxeU0zV1FNc2xESnNjVk9LYVBtalFmc2hmdUZp?=
 =?utf-8?B?ZkpUL0tXeXZNSFJ3ZzNHRkJqZldnb0MvaWRoa3doSzM3cFE2VFRBaU5yVEhQ?=
 =?utf-8?B?cDgweVY0dWI0ZTZpV3hubjduejhkbmpRb2VTUk1xeFc2dWJBNHViVHNlcjNz?=
 =?utf-8?B?c0UwVVJmczBvK3lETFhaSXpxbk93TStxdmRxZVF4OVhkMDBOMHN6MWQydVVM?=
 =?utf-8?B?UytZaWt2YjVnNWNaQnB3VXhFR1llU0syMmRiU1Y5OFpWRVhHcENsaFNzanAy?=
 =?utf-8?B?TUF5VW5ZZkw0emlTUXVrMDY2aVI4aWtiMlpOS3Z6RzFicUNPMDdLSm9BTEN1?=
 =?utf-8?B?bWZ1dVlEeHNwNHNjM3lSVE1wZ1l4Z3gwcXFEVFpsQ2xMSFE4YVA4U2hQVzZG?=
 =?utf-8?B?anc5dnl2T2E4U09yajM0Y1lEdzhadUJYbG9tSGNzN25TSi9LTC9rWU5rL1BB?=
 =?utf-8?B?bEVxc2JVTGxHWDJSOUo1b3hTL0ZIc05MNE5ON01NWk05WUxCUkRNREw5ajd1?=
 =?utf-8?B?Ulo4ZlBVQ1hvd0F2MU55QUtNWkVtelFjS2o4aWxldVRqeER2ZTBuVE94OFVP?=
 =?utf-8?B?cmYwV1IvTndXeUxhUklmZmNRcnNpdGkrQ0MwOUZFbzVJWXVsUlJVUTN0cWFz?=
 =?utf-8?B?dFNGTFRGOXRhVk1Ka2kxSEszWjlqWDEvdkVRK0FFc0tPK3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:46:21.2779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09db3271-3e79-4fbd-8d9c-08dcc1b55a68
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021A.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7986

From: Chuanhua Han <hanchuanhua@oppo.com>

Currently, we support mTHP swapout but not swapin. This means that once mTHP
is swapped out, it will come back as small folios when swapped in. This is
particularly detrimental for devices like Android, where more than half of
the memory is in swap.

The lack of mTHP swapin functionality makes mTHP a showstopper in scenarios
that heavily rely on swap. This patchset introduces mTHP swap-in support.
It starts with synchronous devices similar to zRAM, aiming to benefit as
many users as possible with minimal changes.

-v7:
 * collect Chris's ack tags, thanks!
 * adjust the comment and subject，pointed by Christoph. 
 * make alloc_swap_folio() always charge the folio to fix the problem of charge
   failure in memcg when the memory limit is reached(reported and pointed by
   Kairui), pointed by Kefeng, Matthew.

-v6:
 * remove the swapin control added in v5, per Willy, Christoph;
   The original reason for adding the swpin_enabled control was primarily
   to address concerns for slower devices. Currently, since we only support
   fast sync devices, swap-in size is less of a concern.
   We’ll gain a clearer understanding of the next steps while more devices
   begin to support mTHP swap-in.
 * add nr argument in mem_cgroup_swapin_uncharge_swap() instead of adding
   new API, Willy;
 * swapcache_prepare() and swapcache_clear() large folios support is also
   removed as it has been separated per Baolin's request, right now has
   been in mm-unstable.
 * provide more data in changelog.

-v5:
 https://lore.kernel.org/linux-mm/20240726094618.401593-1-21cnbao@gmail.com/

 * Add swap-in control policy according to Ying's proposal. Right now only
   "always" and "never" are supported, later we can extend to "auto";
 * Fix the comment regarding zswap_never_enabled() according to Yosry;
 * Filter out unaligned swp entries earlier;
 * add mem_cgroup_swapin_uncharge_swap_nr() helper

-v4:
 https://lore.kernel.org/linux-mm/20240629111010.230484-1-21cnbao@gmail.com/

 Many parts of v3 have been merged into the mm tree with the help on reviewing
 from Ryan, David, Ying and Chris etc. Thank you very much!
 This is the final part to allocate large folios and map them.

 * Use Yosry's zswap_never_enabled(), notice there is a bug. I put the bug fix
   in this v4 RFC though it should be fixed in Yosry's patch
 * lots of code improvement (drop large stack, hold ptl etc) according
   to Yosry's and Ryan's feedback
 * rebased on top of the latest mm-unstable and utilized some new helpers
   introduced recently.

-v3:
 https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmail.com/
 * avoid over-writing err in __swap_duplicate_nr, pointed out by Yosry,
   thanks!
 * fix the issue folio is charged twice for do_swap_page, separating
   alloc_anon_folio and alloc_swap_folio as they have many differences
   now on
   * memcg charing
   * clearing allocated folio or not

-v2:
 https://lore.kernel.org/linux-mm/20240229003753.134193-1-21cnbao@gmail.com/
 * lots of code cleanup according to Chris's comments, thanks!
 * collect Chris's ack tags, thanks!
 * address David's comment on moving to use folio_add_new_anon_rmap
   for !folio_test_anon in do_swap_page, thanks!
 * remove the MADV_PAGEOUT patch from this series as Ryan will
   intergrate it into swap-out series
 * Apply Kairui's work of "mm/swap: fix race when skipping swapcache"
   on large folios swap-in as well
 * fixed corrupted data(zero-filled data) in two races: zswap and
   a part of entries are in swapcache while some others are not
   in by checking SWAP_HAS_CACHE while swapping in a large folio

-v1:
 https://lore.kernel.org/all/20240118111036.72641-1-21cnbao@gmail.com/#t

Barry Song (1):
  mm: add nr argument in mem_cgroup_swapin_uncharge_swap() helper to
    support large folios

Chuanhua Han (1):
  mm: support large folios swap-in for sync io devices

 include/linux/memcontrol.h |   5 +-
 mm/memcontrol.c            |   7 +-
 mm/memory.c                | 250 +++++++++++++++++++++++++++++++++----
 mm/swap_state.c            |   2 +-
 4 files changed, 231 insertions(+), 33 deletions(-)

-- 
2.43.0


