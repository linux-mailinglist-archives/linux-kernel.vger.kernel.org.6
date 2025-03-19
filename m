Return-Path: <linux-kernel+bounces-568666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D99A69918
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8721883B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC5212FA0;
	Wed, 19 Mar 2025 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hg9hnGpX"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC82F37
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412194; cv=fail; b=bWkSak6KYBhH5ZoqgvHQdPMLPqVGDGdiSDd390Y09YBAY7AvDsdvtuR80GRcG50yB5y5nQWvdpDg5YZQH6jbflHfrqJuIg7xbWbNzYZMINRS34BBM6iZlbA9FOYhJA6/pxVUsSQt+nGpGJx+c44NmfDHyFyChURXDjg0PXA02KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412194; c=relaxed/simple;
	bh=LNGyk09A6U40zNkcaKFoxfGH2SaYLZhM0ooleRc0xgM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jQiwZTwi/VePoqgJaplKSaIJI68D6ZU0y95c1aNGvLNYVU8SiNAzM9oyCQEfpsdNpH10MLstqphdb1lGEh9aynp+qfrym0sZNCkyrno+2biIXxZ4LljWd46ulxP+oEH85oBeN7vVULnYXqTQ2fXAzLsri6zMIe/+NIxn8iMPsyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hg9hnGpX; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6RtF37uZgxAnUpRcGB2iA6I2JrfC9w95uceI8SR5I/0DvXt9v6xYS5w+Hkbk+5jcbruq9fig0KqVT6mVoK4wglpK31AaXfdX4eZWCWrskF3of0Nmij3zHeS/0qR1XPo6E6JB0zi3nvs4fRZgYaXQnOWG18Y6pRKMJn9YtrmVQfWA9n6W29ui4DGy+nOe/98IXnY8sc/UUfkob2Wn5zoJdoScqL+01A2tyu+Gw3iv5fy6W6lX9hOyN8yWSpUoLHf8P23WVxieMFBeQe/0JKkcrP8N8+3XAXkoSjctKRYwazNhpvll8pKrUWdin0WRPYGo4XZFcU80xzWzcsVSao5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpjelLZrm3L9ypISzT7yGOZZBcLBbq1TDSdcmS8EePU=;
 b=AccDCOEzyMEyKXnRQ04J3ey0D945vuOiQMNyRVWGMwJJFfo5eodf5+STVfXin1iJsnAjm6jXE9tBX9Tq6Um4AEFzBm6/IlLqqnlYIlG1R6ylGiZft/uhdMQHEb11g+cCYqfB9tjZtyJxEWtF6T1YVY2eJ8leanbMtw76Y0Q2CHPDTnI2Qhtb6IssgD079bNHFhEGSgWGmnhGC3FRhyKOOCkKO0J/ezk217twiTiTKD/U6po7g+o+VYqwQTH16CA/+opZghvcVslme2PPlFOqTohEUwo4FJ0ORmK5DMrrRQ5rGI0ydDsj8jsFPHPj2QgWJN1Qrgy4XIG3IJedt+vang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpjelLZrm3L9ypISzT7yGOZZBcLBbq1TDSdcmS8EePU=;
 b=hg9hnGpXfpL8uAcNf44mbMxd+ctjzqG7yjLa7p25JGyidWNTL9U1SDC0Gf3E2Ba/j5W6ahja3Sz/T0DFNVogkmdgy0KTomfzM0989Oz3NGTjuk3rSMN1zEWzywmGRKil28vSAWqNjQHr3ntnJq/aIxwZIjA0zaRch0HE2D5MBBA=
Received: from BYAPR07CA0080.namprd07.prod.outlook.com (2603:10b6:a03:12b::21)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 19:23:08 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::4c) by BYAPR07CA0080.outlook.office365.com
 (2603:10b6:a03:12b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:23:08 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:22:59 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>, <ziy@nvidia.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <baolin.wang@linux.alibaba.com>,
	<bharata@amd.com>, <david@redhat.com>, <gregory.price@memverge.com>,
	<honggyu.kim@sk.com>, <jane.chu@oracle.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <leesuyeon0506@gmail.com>,
	<leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <mel.gorman@gmail.com>,
	<Michael.Day@amd.com>, <Raghavendra.KodsaraThimmappa@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>,
	<wangkefeng.wang@huawei.com>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <anannara@amd.com>, <wei.huang2@amd.com>,
	<Jonathan.Cameron@huawei.com>, <hyeonggon.yoo@sk.com>, <byungchul@sk.com>
Subject: [PATCH RFC V2 0/9] Enhancements to Page Migration with Multi-threading and Batch Offloading to DMA
Date: Wed, 19 Mar 2025 19:22:03 +0000
Message-ID: <20250319192211.10092-1-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed11274-5489-4745-dc1a-08dd671b7b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0VzWkNaRmd1MmZRa2JpODQrc1JnQWZZVDJHL0duR0N0RlVDTVVVV2lQNjNW?=
 =?utf-8?B?a3JLTzd1MVUyTU03OGhmWFFrSFFHUzc5YVpBd3VYL1pMUllqZStkaHQ5MXlT?=
 =?utf-8?B?Z3czQTBCU1hjVEx5eDVGTEZGYUFFSzZUWnFOTmpkTnR5b3o3Y1cwM2JSQ3R0?=
 =?utf-8?B?MUNzTVk4YU5QTjhEYURISXU5V0kzOHQrbjJ6VnhWSERESVlQYzdGd0FMRFJI?=
 =?utf-8?B?NmNucjI0VXlrSlU4ZWM3WExLSDZBWklZNmVadUhkUFRkN3BLNTYzNHhzNGRD?=
 =?utf-8?B?ZjFsUTh0T1J6VFhVS3lEbER5bThra0JuNnQ4SkpqekcxSnh6d1JCN3Y0b0xP?=
 =?utf-8?B?aUZzbmdsT3RuWGFUamVUQkhwN2pRVXpqTWFCVDFtZUQ3NjN6MzA0ZmZIaGpB?=
 =?utf-8?B?eno3V3RyYjJORnlPZVdlNmtuNmpZZTh2dEFQbEtlQkhnQmx6R0xvb25UZll0?=
 =?utf-8?B?eDBOSG95SEV1d3FFLy9Pc2ZBajBwOVNsdy9JRUc2bGV4VS9YS0JQTHJPNXhu?=
 =?utf-8?B?QkU2VzdSL2RGcWRIcnJoZFRrRDV6NUdBSDNndktVQks0VzUyY1Z6NVJmRzF5?=
 =?utf-8?B?MjFLaFc3UXBOZzVVb2xsaUU2UjNoYWFUaTYyR2ZSU1gwU0hSaENRdVdnb1NB?=
 =?utf-8?B?R2FmdGZtQ05IMy9CdUpLZGpLOVc3S3luQWt3RXJIYWtGbGl1b1hmRkFSTDd6?=
 =?utf-8?B?ay9oN2J1ZlNkZE9FTWo0L3BJWDJXLzYwNWV4Rk15ZUFSZVZPU21OZDNYMFpE?=
 =?utf-8?B?cmVtTkRUNHFaVEpLL1YrQ0VsNWRpZGJVeWtxb0ZydXU3WTFaak93RVJENUgv?=
 =?utf-8?B?eUR1ZlNXeXUwdkNUbkFpVnVBUld2ZEhIbkhORGRpMzZ6eTdwMDhDN0hpeVc5?=
 =?utf-8?B?QTM0V0kxN3kxOG1HZ0E0dDJqS0JPNEN6bmxpclRHZGpLQzg1Mlp6RkZyWlNQ?=
 =?utf-8?B?ZXJNWWVhcVdZb1JOeTNTRW52ZkQ2dG1nZ3RCcm10TldYazI1VE95b1QrdXYx?=
 =?utf-8?B?MTQydnBnS2tuL2tGM3BsZmo0ZGN3ZndXc3BuU3VYcW5qSTdTMll5U0ppamtu?=
 =?utf-8?B?T2pWK0draUpVL043QkV0d0NrTytvNCtDU3hURmZHeGk3VGE3NlQ1RmtCRzk1?=
 =?utf-8?B?Qm4vVEJ0VWM5dTAvTUpPVjRIVHhJQkkyYlhCRGorVG9MNFFERWtOVUwxZlRM?=
 =?utf-8?B?TnZMQUpKK0FHK2pwZzNXdWl4b3VXQXUvaVkvYTZkOFJpd3F1Nk9CdXJxek0w?=
 =?utf-8?B?d21hWWxyWG1SZGpuajZiRy9KbGRIaS9wb2VLR1kzK3NRbENZdTNiVkUxYmRD?=
 =?utf-8?B?a25tWHExL0ppWjFReUZPVnk3OVVRZ1dZV3hrc1daTUZVdVpzNnN3aFNUem0v?=
 =?utf-8?B?YVdDaS9nV25tRVNsSXI0bTJ0RU5HalNzcnJrTVBXSG1RcUw5V0tXU2dDOVNw?=
 =?utf-8?B?NU1BWlNSUXRiSkpQZEJPZmNZajdjemgxQitiajJJMGRxcnBrYjFVUFMyUy9l?=
 =?utf-8?B?bTNmTHBFdWhSbDJwRVdiWHVxcWdnSFRaeTM5bmZWb2syRnFQZmlRKzZLKzc1?=
 =?utf-8?B?eE1nMm9rY0tTay9rdDRjN1R1Rlo2ZTdLV1gwcnBCU0IveEN1QTJ2RVBBZnNo?=
 =?utf-8?B?Z2tVdXoxVUw1MzhVeWFEU09zYW9qbGFDdzJPeGJMRzV6dGl1dDRUSDBMMlA4?=
 =?utf-8?B?M3J2RUhqZmlKOFBCSTVJVVZmYlJDMUNqZS90USs1NnQ5cFdDbWYrQmZsMldU?=
 =?utf-8?B?MUhnRXhBTXZmZDIxT0tuVHc1Ykkxa0RqOHZEcDVWSDBKZER4bVBNWFFwYkVB?=
 =?utf-8?B?Rk5vZ1lseXpUeDlzU2NseUdQSUVIZy9mRkg2dUJjcWtubW1sSDEvc3JiVmND?=
 =?utf-8?B?WHR2aGVnNGFhVFRhdGlhL1ZYQ1hFTGhiYXRrN3d0ZzR2U1pZNEZFRXk1ZGZX?=
 =?utf-8?B?cHdWUW1HOFZXZDZPMjI1SXlDeTQwTWk4R3RxeEZUa2k1TkpRc29RWkkydFZs?=
 =?utf-8?Q?qok98hfQLlHmhdMwVKpVF0TlFCoEgg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:23:08.1724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed11274-5489-4745-dc1a-08dd671b7b15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200

This patchset introduces enhancements to the page migration by batching
folio-copy operations and using multiple CPU threads for copying or offloading
the copy to DMA hardware.

It builds upon Zi's work on accelerating page migration via multi-threading[1]
and my previous work on enhancing page migration with batch offloading via DMA[2].

MOTIVATION:
-----------
Page migration costs have become increasingly critical in modern systems with
memory-tiers and NUMA nodes:

1. Batching folio copies increases throughput, especially for base page migrations
where kernel activities (moving folio metadata, updating page table entries) create
overhead between individual copies. This is particularly important for smaller
page-sizes (4KB on x86_64/ARM64, 64KB on ARM64).

2. Current simple serial copy patterns underutilize modern hardware capabilities,
leaving memory migration bandwidth capped by single-threaded CPU-bound operations.

These improvements are particularly valuable in:
- Large-scale tiered-memory systems with CXL nodes and HBM
- CPU-GPU coherent systems with GPU memory exposed as NUMA nodes
- Systems where frequent page promotion/demotion occurs

Following the trend of batching operations in the memory migration core path (batch
migration, batch TLB flush), batch copying folio content is the logical next step.
Modern systems equipped with powerful hardware accelerators (DMA engines), GPUs, and
high CPU core counts offer untapped potential for hardware acceleration.

DESIGN:
-------
The patchset implements three key enhancements:

1. Batching:
- Current approach: Process each folio individually
  for_each_folio() {
    Copy folio metadata like flags and mappings
    Copy the folio content from src to dst
    Update page tables with dst folio
  }

- New approach: Process in batches
  for_each_folio() {
    Copy folio metadata like flags and mappings
  }
  Batch copy all src folios to dst
  for_each_folio() {
    Update page tables with dst folios
  }

2. Multi-Threading:
- Distribute folio batch copy operations across multiple CPU threads.

3. DMA Offload:
- Leverage DMA engines designed for high copy throughput.
- Distribute folio batch-copy across mutliple DMA channels.

PERFORMANCE RESULTS:
-------------------
System Info:
Testing environment: AMD Zen 3 EPYC server (2-sockets, 32 cores, SMT Enabled),
1 NUMA node per socket, Linux Kernel 6.14.0-rc7+, DVFS set to Performance,
PTDMA hardware.

Measurement: Throughput (GB/s)


1. Varying folio-size with different parallel threads/channels:

Move different sized folios (mTHP - 4KB, 16KB,..., 2MB) such that total transfer
size is constant (1GB), with different number of parallel threads/channels.

a. Multi-Threaded CPU

	   Folio Size-->
Thread Cnt | 4K   |    16K   |    32K   |   64K    |   128K   |   256K   |   512K     |    1M     |    2M     |
===============================================================================================================
1      | 1.72±0.05| 3.55±0.14| 4.44±0.07| 5.19±0.37| 5.57±0.47| 6.27±0.02 | 6.43±0.09 | 6.59±0.05 | 10.73±0.07|
2      | 1.93±0.06| 3.91±0.24| 5.22±0.03| 5.76±0.62| 7.42±0.16| 7.30±0.93 | 8.08±0.85 | 8.67±0.09 | 17.21±0.28|
4      | 2.00±0.03| 4.30±0.22| 6.02±0.10| 7.61±0.26| 8.60±0.92| 9.54±1.11 | 10.03±1.12| 10.98±0.14| 29.61±0.43|
8      | 2.07±0.08| 4.60±0.32| 6.06±0.85| 7.52±0.96| 7.98±1.83| 8.66±1.94 | 10.99±1.40| 11.22±1.49| 37.42±0.70|
16     | 2.04±0.04| 4.74±0.31| 6.20±0.39| 7.51±0.86| 8.26±1.47| 10.99±0.11| 9.72±1.51 | 12.07±0.02| 37.08±0.53|

b. DMA Offload

	   Folio Size-->
Channel Cnt| 4K   |   16K    |   32K    |    64K   |   128K   |   256K   |    512K  |   1M     |    2M     |
============================================================================================================
1      | 0.46±0.01| 1.35±0.02| 1.99±0.02| 2.76±0.02| 3.44±0.17| 3.87±0.20| 3.98±0.29| 4.36±0.01| 11.79±0.05|
2      | 0.66±0.02| 1.84±0.07| 2.89±0.10| 4.02±0.30| 4.27±0.53| 5.98±0.05| 6.15±0.50| 5.83±0.64| 13.39±0.08|
4      | 0.91±0.01| 2.62±0.13| 3.98±0.17| 5.57±0.41| 6.55±0.70| 8.32±0.04| 8.91±0.05| 8.82±0.96| 24.52±0.22|
8      | 1.14±0.00| 3.21±0.07| 4.21±1.09| 6.07±0.81| 8.80±0.08| 8.91±1.38|11.03±0.02|10.68±1.38| 39.17±0.58|
16     | 1.19±0.11| 3.33±0.20| 4.98±0.33| 7.65±0.10| 7.85±1.50| 8.38±1.35| 8.94±3.23|12.85±0.06| 55.45±1.20|

Inference:
- Throughput increases with folio size. Higher Size folios benefit more from DMA.
- Multi-threading and DMA offloading both provide significant gains.


2. Varying folio count (total transfer size)
2MB folio-size, use only 1 thread

a. CPU Multi-Threaded
Folio Count| GB/s
======================
1          | 7.56±3.23
8          | 9.54±1.34
64         | 9.57±0.39
256        | 10.09±0.17
512        | 10.61±0.17
1024       | 10.77±0.07
2048       | 10.81±0.08
8192       | 10.84±0.05

b. DMA offload
Folio Count| GB/s
======================
1          | 8.21±3.68
8          | 9.92±2.12
64         | 9.90±0.31
256        | 11.51±0.32
512        | 11.67±0.11
1024       | 11.89±0.06
2048       | 11.92±0.08
8192       | 12.03±0.05

Inference:
- Throughput increase with folios count but plateaus after a threshold.
  (The migrate_pages function uses a folio batch size of 512)

3. CPU Threads scheduling
Analyze effect of CPU topology

a. Spread Across different CCDs
 Threads    | GB/s
========================
 1          | 10.60±0.06
 2          | 17.21±0.12
 4          | 29.94±0.16
 8          | 37.07±1.62
 16         | 36.19±0.97

b. Fill one CCD completely before moving to next one
 Threads    | GB/s
========================
 1          | 10.44±0.47
 2          | 10.93±0.11
 4          | 10.99±0.04
 8          | 11.08±0.03
 16         | 17.91±0.12

Inference:
- Hardware topology matters. On AMD systems, distributing copy threads across
  CCDs utilizes bandwidth better

TODOs:
We can further experiments to:
- Characterize system behavior and develop heuristics
- Analyze remote/local CPU scheduling impacts
- Measure DMA setup overheads
- Evaluate costs to userspace
- Study cache hotness/pollution effects
- DMA cost with different system I/O load

[1] https://lore.kernel.org/linux-mm/20250103172419.4148674-1-ziy@nvidia.com
[2] https://lore.kernel.org/linux-mm/20240614221525.19170-1-shivankg@amd.com
[3] LSFMM Proposal: https://lore.kernel.org/all/cf6fc05d-c0b0-4de3-985e-5403977aa3aa@amd.com

Mike Day (1):
  mm: add support for copy offload for folio Migration

Shivank Garg (4):
  mm: batch folio copying during migration
  mm/migrate: add migrate_folios_batch_move to batch the folio move
    operations
  dcbm: add dma core batch migrator for batch page offloading
  mtcopy: spread threads across die for testing

Zi Yan (4):
  mm/migrate: factor out code in move_to_new_folio() and
    migrate_folio_move()
  mm/migrate: revive MIGRATE_NO_COPY in migrate_mode.
  mm/migrate: introduce multi-threaded page copy routine
  adjust NR_MAX_BATCHED_MIGRATION for testing

 drivers/Kconfig                        |   2 +
 drivers/Makefile                       |   3 +
 drivers/migoffcopy/Kconfig             |  17 ++
 drivers/migoffcopy/Makefile            |   2 +
 drivers/migoffcopy/dcbm/Makefile       |   1 +
 drivers/migoffcopy/dcbm/dcbm.c         | 393 ++++++++++++++++++++++++
 drivers/migoffcopy/mtcopy/Makefile     |   1 +
 drivers/migoffcopy/mtcopy/copy_pages.c | 408 +++++++++++++++++++++++++
 include/linux/migrate_mode.h           |   2 +
 include/linux/migrate_offc.h           |  36 +++
 include/linux/mm.h                     |   4 +
 mm/Kconfig                             |   8 +
 mm/Makefile                            |   1 +
 mm/migrate.c                           | 351 ++++++++++++++++++---
 mm/migrate_offc.c                      |  51 ++++
 mm/util.c                              |  41 +++
 16 files changed, 1275 insertions(+), 46 deletions(-)
 create mode 100644 drivers/migoffcopy/Kconfig
 create mode 100644 drivers/migoffcopy/Makefile
 create mode 100644 drivers/migoffcopy/dcbm/Makefile
 create mode 100644 drivers/migoffcopy/dcbm/dcbm.c
 create mode 100644 drivers/migoffcopy/mtcopy/Makefile
 create mode 100644 drivers/migoffcopy/mtcopy/copy_pages.c
 create mode 100644 include/linux/migrate_offc.h
 create mode 100644 mm/migrate_offc.c

-- 
2.34.1


