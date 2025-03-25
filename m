Return-Path: <linux-kernel+bounces-574905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B01AA6EB55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1F3188AC35
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF16155C87;
	Tue, 25 Mar 2025 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1SkOXbqH"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01671EB5B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890745; cv=fail; b=O/rGsh4t7aqaetrwDnz1gx2Eb6bqN1JhvHbyV6sXRZy9D9ZblClKPYOiuaAI/HdaK20K+gRb+/qzq9RukBgmZwZ9KjqApAIeDrSF0/dABFwbOoDQdRnD8I+OKiNc157/xgSRIw827QHTLaVknYMsyOemVjNQ4gm0lyxt/Dtxzq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890745; c=relaxed/simple;
	bh=jeAdCW9nmcwmUDO+bJV3dcCN1is+b4v5A7Rueo0sOeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJNL6X3gFSxZQh3IPSJhZIB1IkUJ/n1+1Hd0WziA1CjsXiQfrjNzWAfsiHEI5MBe39Z3CYMouE2EEXZjWpNy2eXqk8vOH5cOvhG0SjonHS7a1pRKCLXVLybOHrvnQhUAMTsnm10Pfe3tVo0c/9aRc6z7vBNL8gsPUUQj9/kVUz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1SkOXbqH; arc=fail smtp.client-ip=40.107.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfeNfH1mK44AWVy0/yaeXDgYvQvD0PQ5GvddDYFIRJWa3qELr1JcVv8ijnTRmZLYAyvRnkZW0TSqE+jYPsDSBWH1EpblT0rDZia8dYj+lr4vJDirNr+JebyRqyK/1nA+LpllL2G8s3yAGUX/r78ToAtbw1UzXS856BaYe30uZMsWvLisclnAM3WwyyK0/5AgV7uhILAxUsek081eAt7sTjK4xLgHGFHY8CeKzbbubPObmgtA+igyaurIRW7cnLZEtoGRTXi0eAA811/iWN4nFmeidhtxnWXxwPN8VUjev0vipr0YRQIrJPqj3Fwv/B98Ri1DBJBJ0m5HbP7p8UWw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS4zD5SUO0vgeUE68xkbIh672reDzoC7iykbswdmRnY=;
 b=RpY347KhXESUvUtLhP8PCZdAcyzt2EMVuBZhgqdF4nDGhLPOrjhJRNFpLCLUEEFvzc5dwzkOPN6tA9XjrSq7SWuy7UGUqVBaY+pchHLtNBf65h54Io2ePepozlNHue11ym2L1Zd/B7WNkoYlONBnAi/gPyG0mR9zorLrZbCjD9mlZpVd5XezZHXjVjfb66HfcRNXbI2Zcm3X+Vh5tClCl2KoM+LGiqlsowlYknyuYHvP9GGFJ4VHuwL68vF+hODYzlL0Z/mgwpUp6ajhbq5X2HMHKueS3118COXWhd8fkFWh5EZJMV4TelYdRkUhcWFWycBz40S+9Rs8conv9Rbajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS4zD5SUO0vgeUE68xkbIh672reDzoC7iykbswdmRnY=;
 b=1SkOXbqHkfNPF35FSLJRO3pvHs7kO6ONmZkRrmvzDtlvTanaBcnkzSYcgFb7q3uDp4amQRmNA7+mqwZjHn1KXCHVZWn9apa1fsnt7Xzc8AzKyZT854CrSmSJOTL9pkDzvwz1tfyXN/OLDb64T7z6N2pHsEHRSt/19TOAnEESKQs=
Received: from CH5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:1f4::23)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 08:18:59 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::69) by CH5PR04CA0023.outlook.office365.com
 (2603:10b6:610:1f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.38 via Frontend Transport; Tue,
 25 Mar 2025 08:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 08:18:59 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 03:18:49 -0500
From: Bharata B Rao <bharata@amd.com>
To: <bharata@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Jonathan.Cameron@huawei.com>, <Michael.Day@amd.com>,
	<akpm@linux-foundation.org>, <dave.hansen@intel.com>, <dave@stgolabs.net>,
	<david@redhat.com>, <feng.tang@intel.com>, <gourry@gourry.net>,
	<hannes@cmpxchg.org>, <honggyu.kim@sk.com>, <hughd@google.com>,
	<hyeonggon.yoo@sk.com>, <jhubbard@nvidia.com>, <k.shutemov@gmail.com>,
	<kbusch@meta.com>, <kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>,
	<leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <nadav.amit@gmail.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <raghavendra.kt@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<yuanchu@google.com>, <ziy@nvidia.com>
Subject: Re: [RFC PATCH 0/4] Kernel daemon for detecting and promoting hot pages
Date: Tue, 25 Mar 2025 13:48:32 +0530
Message-ID: <20250325081832.209140-1-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306054532.221138-1-bharata@amd.com>
References: <20250306054532.221138-1-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb88b75-c323-471e-f4af-08dd6b75b1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dcE/Q4Qos7ADtkER1uqR2rstwJmPgDBKKbcxrkab4E5XA9/OX11IiU1XaqBa?=
 =?us-ascii?Q?Bye6etf2BCw22DrrUDJmw/VCNKok1Z+UU1t8olsDFl0MfZkXHKBDvPzaY+T4?=
 =?us-ascii?Q?2ZZ0xTmtpgkM7G25C4s5o7AQkW8mjivelSK88hH5amLvpjft19FnSuZQsFN+?=
 =?us-ascii?Q?AFhp5YDkiR3d/59yDV28aw7bk471HCXag4gfuRjlEvHFCmx1rts30JkbrCbB?=
 =?us-ascii?Q?+8ha+1Wz941f0Nt7wywpEJfMT4cp2MGIMlKpFTEIw5DV1f8DfCCGBTQuLym6?=
 =?us-ascii?Q?MPp+4Su3MAZpmhHysDhLchqIodXyboI+wsukYrbcNtz5BQcxh6Ls35YLmkFy?=
 =?us-ascii?Q?lIrVIGzh+21zfwjqVHeJ3iC6wU3QpAwoB/4vGrNxh4NPoXUwxgP8GJyCOKOX?=
 =?us-ascii?Q?p7uGs9dHOGXG1IX1Y85cMMjflR3sgZ55E2ARdoEaK36dEvZM1XTUmm8i6zrx?=
 =?us-ascii?Q?sr2/bHWQtYkc9zQOM0CZEKws54Pi2OCPiqVKVvGT54cIHpD6P34y9zeSvatq?=
 =?us-ascii?Q?sjZc4Vvv3P68aJQKOn73psKXCVXrRD3XviBg6U+aD1wYm6aE4NS7oeK0YUw7?=
 =?us-ascii?Q?uIqKdHOc+NyAS3pvIfPfqarVTDDvDt6zUNJhSVDPNt4AONsUUeaaVrip3LbS?=
 =?us-ascii?Q?YPQDGhk58UMjT8bzRpLdTBKS5mXpk2cE+hHZt2tZOWw1qYcCoqPZ6cJsIt4X?=
 =?us-ascii?Q?i8lDWqCOu5i2zKMqI7f6lj8ah2yy03i26RxbqF/pN3ceh6jXz3E52KSSV+3W?=
 =?us-ascii?Q?KFpnjthBrbV4zInbDc4Hh6Paa3n05M7/KLoee1baPQH2j1eII1b67ezrPtmp?=
 =?us-ascii?Q?xjkRZaczVh3P+v5B8knxqAsGBEa6C0cUuk73ecZypsCdU7H8EjHrPesfx07C?=
 =?us-ascii?Q?dnMzIZbQU3fbdRgERmKxLmd3yRK8Bg+7+K0yIR5FBFCLHTmV9lSVUuTZQGRO?=
 =?us-ascii?Q?I9bM6DoxE3KxT++uUavxA1K+/AEyV/XlJapt9dnRlcHK/eV9XXsFDgx5wtjF?=
 =?us-ascii?Q?uM/s+nO8i0Rq+/ezzmw3sTN+KyAhze4rv4Iaj4sUxdIJBJ3TWrZlUmflPBKm?=
 =?us-ascii?Q?/vBIyBlKfpjrumVjjOP72PJZEf4Papoa3Kxl8yMxvOgJyiNUFREvIvL6MaQi?=
 =?us-ascii?Q?NBVlrCGyBYhJzy1bSAF6jbWtYV84S13D6+xDX2NXLLNFLOYVp7NRvLvmzARq?=
 =?us-ascii?Q?8yhPzmhXIycUksfm2Mw+ZoucPU/NzsNDUmOr1odhSaUpw2p6NRVgYKrF5amF?=
 =?us-ascii?Q?1HCA2QlhA8KRPfnLb3jYxDRvIFaZezSKy9t4YJir21YPjIZQ4DG4L4KfO9Sm?=
 =?us-ascii?Q?9dy5rw085rrzq/62sgNVLEqWKpuEjGeLb2vFd35TlB77B4+prFNXKOuqxfwP?=
 =?us-ascii?Q?g085EFvJPqXyJEwf7VwqWK60M/iu9EvUGy8ao7n75/uqRpBw7nIUwiUn3N/R?=
 =?us-ascii?Q?yfVdPt55yDR4OgJggMgfGNwbwCLVejafb7/V8FfqLibuRxNMHku8pQVlb0io?=
 =?us-ascii?Q?fSD/q7ofAVNvRiw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 08:18:59.2035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb88b75-c323-471e-f4af-08dd6b75b1ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810

> Hi,
> 
> This is an attempt towards having a single subsystem that accumulates
> hot page information from lower memory tiers and does hot page
> promotion.
> 
> At the heart of this subsystem is a kernel daemon named kpromoted that
> does the following:
> 
> 1. Exposes an API that other subsystems which detect/generate memory
>    access information can use to inform the daemon about memory
>    accesses from lower memory tiers.
> 2. Maintains the list of hot pages and attempts to promote them to
>    toptiers.
> 
> Currently I have added AMD IBS driver as one source that provides
> page access information as an example. This driver feeds info to
> krpromoted in this RFC patchset.

FWIW, here are some numbers from krpomoted driven hotpage promotion with
IBS as the hotness source:

Test 1
======
Memory allocated on DRAM and CXL nodes explicitly and no demotion activity
is seen.

Benchmark details
-----------------
* Memory is allocated initially on DRAM and CXL nodes separately.
* Two threads: One accessing DRAM-allocated and other CXL-allocated memory.
* Divides memory area into regions and accesses pages within the region randomly
  and repetitively. In the test config shown below, the allocated memory is
  divided into regions of 1GB size and each such region is repetitively (512
  times) accessed with 21474836480 random accesses in each repetition).
* Benchmark score is time taken for accesses to complete, lower is better
* Data accesses from CXL node are expected to trigger promotion
* Test system has 2 DRAM nodes (128G each) and a CXL node (128G)

kernel.numa_balancing		2 for base, 0 for kpromoted
demotion			true
Threads run on			Node 1
Memory allocated on		Node 1(DRAM) and Node 2(CXL)
Initial allocation ratio	75% on DRAM
Allocated memory size		160G (mmap, MAP_POPULATE)
Initial memory on DRAM node	120G
Initial memory on CXL node	40G
Hot region size			1G
Acccess pattern			random
Access granularity		4K
Load/store ratio		50% loads + 50% stores
Number of accesses		21474836480
Nr access repetitions		512

Benchmark completion time
-------------------------
Base, NUMAB=2		261s
kpromoted-ibs, NUMAB=0	281s

Stats comparision
-----------------
				Base,NUMAB=2	kpromoted-IBS,NUMAB=0
pgdemote_kswapd			0		0
pgdemote_direct			0		0
numa_pte_updates		10485760	0
numa_hint_faults		4427809		0
numa_pages_migrated		388229		374765
kpromoted_recorded_accesses			1651130	/* nr accesses reported to kpromoted */
kpromoted_recorded_hwhints			1651130	/* nr accesses coming from IBS */
kpromoted_record_toptier			1269697	/* nr accesses from toptier/DRAM */
kpromoted_record_added				378090	/* nr accesses considered for promotion */
kpromoted_mig_promoted				374765	/* nr pages promoted */
hwhint_nr_events				1674227	/* nr events reported by IBS */
hwhint_dram_accesses				1269626	/* nr DRAM accesses reported by IBS */
hwhint_cxl_accesses				381435	/* nr Extmem (CXL) accesses reported by IBS */
hwhint_useful_samples				1651110	/* nr actionable samples as per IBS driver */


Test 2
======
Memory is allocated with DRAM and CXL nodes in the affinity mask with
MPOL_BIND + MPOL_F_NUMA_BALANCING.

Benchmark details
-----------------
* Initially, memory allocated spreads over from DRAM to CXL, involves demotion
* Single thread accesses the memory
* Divides memory area into regions and accesses pages within the region randomly
  and repetitively. In the test config shown below, the allocated memory is
  divided into regions of 1GB size and each such region is repetitively (512
  times) accessed with 21474836480 random accesses in each repetition).
* Benchmark score is time taken for accesses to complete, lower is better
* Data accesses from CXL node are expected to trigger promotion
* Test system has 2 DRAM nodes (128G each) and a CXL node (128G)

kernel.numa_balancing		2 for base, 0 for kpromoted
demotion			true
Threads run on			Node 1
Memory allocated on		Node 1(DRAM) and Node 2(CXL)
Allocated memory size		192G (mmap, MAP_POPULATE)
Hot region size			1G
Acccess pattern			random
Access granularity		4K
Load/store ratio		50% loads + 50% stores
Number of accesses		21474836480
Nr access repetitions		512

Benchmark completion time
-------------------------
Base, NUMAB=2		628s
kpromoted-ibs, NUMAB=0	626s

Stats comparision
-----------------
				Base,NUMAB=2	kpromoted-IBS,NUMAB=0
pgdemote_kswapd			73187		2196028
pgdemote_direct			0		0
numa_pte_updates		27511631	0
numa_hint_faults		10010852	0
numa_pages_migrated		14		611177	/* such low number of promotions is unexecpted in Base, Need to recheck */
kpromoted_recorded_accesses			1883570
kpromoted_recorded_hwhints			1883570
kpromoted_record_toptier			1262088
kpromoted_record_added				616273
kpromoted_mig_promoted				611077
hwhint_nr_events				1904619
hwhint_dram_accesses				1261758
hwhint_cxl_accesses				621428
hwhint_useful_samples				1883543

