Return-Path: <linux-kernel+bounces-548294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1757A54307
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B8816D12D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012051A08A3;
	Thu,  6 Mar 2025 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J6G4h2Bu"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B3433D1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243626; cv=fail; b=irR2xL0c+wqnhtWtE4ZeiLiYINkLvmL4L/RkOpTuwJ1XgEj6ww9/XldEUrkQmYmbKHRNgsWVDWTN2U4kQ8/0Y/Cy0UuFLMet+dhqZxpnEGAljcU4kUU/mUxYXXhUoVazocw3EdwE2WGtuEAnjVUCQ4Ru/oGBITLKObdSTUWXm/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243626; c=relaxed/simple;
	bh=G4NncgMBdYc/kTIMfNDuJSCHjsF86o7N/ZPE5izU8mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bk2fZQ6uhZH1RwpCBMJuF7evQCyKciAqKCAy6hQ5nDq7pGQAP6vddbyNZLOha0ZjDULK/2W3Q2i1oyrffgrkU4HN7e+M2fqLwMeUnk4uwnZPlhti4AnxMjaPmtVPqQZ4zJb0VkFA9JMW2TEk6CRi/rcc5DsftThXOZ5h1444mGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J6G4h2Bu; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEggvQy7BsRzfiMFWQdAmP3/K1yaat/4my+f0TgNY1wUe2RXzpHea1q9sZ20Qrvx7H6I55cLxy0nhblR8MVfvJTRdqxupI2MX+XiwYdiHCeu9ieTS/yEq8eDZvgNr6HBk4/QZtd7j/83WQZdNaH/49WeRSHZDLHQ7rdl2KypqVl8QY84d6fejklTma6AchZy8merDFN3QtC1BxkTV1kuvCcnjam8NrN1+aYukAatISYaQvIGhmmSqK9/vdcnJz7YQG90FUtL0vXnSAiiMpFbasUcoZvHd62V4nsSh0JVjyxfL+MV25tgiySdoQgR/Mzh7bPbNT0BMu3m589dHVxHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAcXC9Eef7/1OjdljyGbfi5ToAMirrIT21Vbkiq7hKk=;
 b=V3Eggpi4zGTG5XsnjC6K6OJ26/OjqvcDKb/yiRleezhTqAaeqtOAoxfCYSnoa9g807Bnm2tlFqGfGdw31pthdon3fa/x3G+7BvRmH3m1aQDhWv7UFoo2QypUTDNgxjud6jzPdSTnfRuMhbu/wM/3iKkdvG/lgP9YQJv+CPpAiGIyx/ZXJysZ+gmsBmRDnmNSEMQoVCjOL7QdJV1iLKoNlCRkgm8q1D13FY5w/LVUQKRgz/XRnIPM1oshcRAd9BZAlIhULB2CpntQVjULBwKZQdlvEFGbK1APNyHOEQRxfjiK+hzada9H5WPTu6cLgRfEZ6Gls+OpqqdDXgWVraw1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hpe.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAcXC9Eef7/1OjdljyGbfi5ToAMirrIT21Vbkiq7hKk=;
 b=J6G4h2BuabquchXApcu8HlQvbw2vlIZM4ZPqqONJsyAyLLVm2ALZI/6/KAHKqpO2ODpROdmkmfCsCgbuzqB9RUpQb9oY4/bvn7OuEGj9b1hkHvEti9givXg0PnAdsp9v9nCIhkcSPyq94ty78wfhGxsb3Bj8r+6cGn16NJjtk5g=
Received: from SJ0PR05CA0205.namprd05.prod.outlook.com (2603:10b6:a03:330::30)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 06:47:01 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:330::4) by SJ0PR05CA0205.outlook.office365.com
 (2603:10b6:a03:330::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 06:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8549.1 via Frontend Transport; Thu, 6 Mar 2025 06:47:01 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 00:46:55 -0600
Message-ID: <2584aac4-fceb-422c-bc35-a52f6c988c13@amd.com>
Date: Thu, 6 Mar 2025 12:16:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Improving topology_span_sane
To: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, Vishal Chourasia
	<vishalc@linux.ibm.com>, samir <samir@linux.ibm.com>
CC: Naman Jain <namjain@linux.microsoft.com>, Saurabh Singh Sengar
	<ssengar@linux.microsoft.com>, <srivatsa@csail.mit.edu>, Michael Kelley
	<mhklinux@outlook.com>, Russ Anderson <rja@hpe.com>, Dimitri Sivanich
	<sivanich@hpe.com>
References: <20250304160844.75373-1-steve.wahl@hpe.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250304160844.75373-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DM6PR12MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1b094e-4bf3-459e-c4a8-08dd5c7ab2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700017|1800799024|36860700013|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGNRaGVpUTBHb3VRNXN1aHZnSE00SXpuWW1lcUdjSTBYRTYxUzJscGx6cW5J?=
 =?utf-8?B?aXBqa1ByaWRNeVJ1TTlqSFVvY2JlUjM3QURhV1AwMVFTdHZSNEZONUh2QzE4?=
 =?utf-8?B?YUpXaEViY3FuUUg3MTdBZFBEc1g3eDQxcWIyZEd5UlpIdWxVMHpTc0xxL0lJ?=
 =?utf-8?B?bzZDbE55cjc0RHczVGwrT1ZWRW1WY1B6U1pqWkxaUVU1ZlhlQnBnM2x0Q01Q?=
 =?utf-8?B?M3h0cVRrazVGRHhXdUs2akhrVHpJUkwrMnFoaFVWelpTRU5TVGZJLzVFdC8z?=
 =?utf-8?B?bjlUM1ZKQ1NtQ3Y4SHFUYUs1WkNnUi9RT2Z5VzdJNFVDUHhVUTNwck9aazlU?=
 =?utf-8?B?emQzMUIxc3Y0SUZSY3UxRkxwcmtHZVhET2Jmc1hqRDRzTFlISFplbVl5ZmtD?=
 =?utf-8?B?RHhZb0FoQ2ZTUnE1ZVdyYVk3Zm9RUlpNNVhicHNjcTRZcFMwaXRIQ204eW5V?=
 =?utf-8?B?RDNqS2xxdVlINXI1bFlYbTZ5NktCTVZISUorbDRMV0s3YjdtQUVsRWluMU9K?=
 =?utf-8?B?cll4ZHVpQlpvZlRxQWJzL0tsRmduVmk1MGx4M290S21LY2JUQnduaDRvTXN6?=
 =?utf-8?B?eSt0K2h0bk9wbGZXTFdlVGVrM3Vnb1lkNGxRNVlwZ29JWWlLcXl1MjV3ZTcz?=
 =?utf-8?B?NWkxcnlwWitIYTRLM29DaHVSODY1dXFTa2xjc0VYU0FVbGNlQ2ZpT2ZmU0h6?=
 =?utf-8?B?YWovUnZFMi90Zk1JWXZ5MzRaN1lXWStjd1hia3hJcFVta3dlNmpZUE5TUHZW?=
 =?utf-8?B?QlJRM2Jhd1Ftd1E5SStLYytab1BuSGd1OHFzQ2kzdENSNzc5bHBIaTEwTVBo?=
 =?utf-8?B?bHBjdDhHd1V2cUNqekFTcndwZ0pQNmNQY3NOcmRCMFAvRm5scC9VMDJGaHJT?=
 =?utf-8?B?VDFlcGYyVzA4N3FqRG1mazQrRFlzZ2lxUnNaWmNPZ3JLOFNpblBsckVna3My?=
 =?utf-8?B?V3gxK3ErVTYwdXA1YXhqeXhCQTZmSGdNc1N2Y0tLcEx1VXN2YVF6Y3FwanJw?=
 =?utf-8?B?RENQUUVxUWtyV3BWb1VuNndnY1Y0ZmdvL1ZaRStaRXdtRXYzaXQzNHl4RTdo?=
 =?utf-8?B?NE1UWXdlSmN4Z0ltcmVTZ3VMK0ttbVFJTllHdnJ2cllmQVNmQmdsSG4xclZu?=
 =?utf-8?B?Y1FQY3BUQVlLbGdnV0Yzbys3WmtBbkhONXZ5WWZqY0hCd0laczFMOW1xY0lF?=
 =?utf-8?B?TXJ2TFFTRUlybFNjMmo0OEZmTEVlQWNVNE9vMGY4K21CekhmTnl6RzRkRkFL?=
 =?utf-8?B?bVVoWmR1M1RuNEVDanVmZnhadVVPOXN3eGJUZTkzNDlSS2pKeGhMVWNqVWhQ?=
 =?utf-8?B?Y1RxMEJMOG9tREloUno0RktRc1NOWHFZVkdRTGd0U1Q2aFdXbEZFZ3UvaUp4?=
 =?utf-8?B?ekFGR2cwemhSQWdnVUxtcmNUdTYzVlBFRzlaZW1oR1dTZWVVWWROMmpKR21F?=
 =?utf-8?B?Q0VidmxjdXFhUGpNbTRxTk5zUEZaVDN4bXF6RHBUdXZ5OGZxZzRvNTNxbEpH?=
 =?utf-8?B?a3NJbTFBUy83RGZZbmNZSEtFRUZ2RXowZ0pJZXZXV3VabFNxVW91VHAydk9O?=
 =?utf-8?B?S2dKOUg4SXl3MjNZSzlKaGtVTlZuVEYxRDRaRzFlcmdEMDdCdHlhR1hKSXow?=
 =?utf-8?B?Vmp2MjhCRDFPd0kySU5nNnQzVnduMndKUG4wbjNXbE5IYU81NkhieVlpNjV1?=
 =?utf-8?B?VGlML1c5R3VEMHJBS2dqeWRocW51NnFBNExySVNlVHhtRnZ6OTRhS1dnK0la?=
 =?utf-8?B?MUFCcWhISFRUK0xSdE9YWWIrMGtYYjhQOW1NL0E1emdDbGNBQ1RXOFpTMDJH?=
 =?utf-8?B?UVByekR6bTNtK0V3bTB0bmpncVBRR2h5cnFzQmJjc3lMcTk5bnlWUytCMlBt?=
 =?utf-8?B?bzh3MmFEcEVia3NTSVFjNllsUVIrbEtSai9ibEYySzJmbi9yVUpRbDR4MjRC?=
 =?utf-8?B?dUs4ZUxrVkJibC9wTnJNdFNNZWY2N0FkVFVMbG03TWdzUEZlbDBXTVNlMUZE?=
 =?utf-8?B?NUoyY2JrNW55ekFNS1p3eTlNQzR5RlJ5ai9iQ0h5WUhzbHBVWmliZkJzU2hi?=
 =?utf-8?Q?DBcjSp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(32650700017)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:47:01.1206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1b094e-4bf3-459e-c4a8-08dd5c7ab2da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266

Hello Steve,

On 3/4/2025 9:38 PM, Steve Wahl wrote:
> toplogy_span_sane() has an O(N^2) algorithm that takes an inordinate
> amount of time on systems with a large number of cpus.
> 
> The first patch in this series replaces the algorithm used with a O(N)
> method that should exactly duplicate the previous code's results.
> 
> The second patch simplifies the first, taking a similar amount of time
> to run, but potentially has different results than previous code under
> situations believed to not truly exist, like a CPU not being included
> in its own span.

I've tested Patch 1 individually and the whole series as is on top of
tip:sched/core and I haven't run into any issues with the optimization
on my 3rd Generation EPYC system.

Please feel free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> 
> Version 1:
>    * Original patch
> 
> Version 2:
> 
>    * Adopted simplifications from K Prateek Nayak,and fixed use of
>      num_possible_cpus().
> 
> Version 3:
> 
>    * Undid the simplifications from version 2 when noticed that results
>      could differ from original code; kept num_possible_cpus() fix.
> 
> Version 4:
> 
>    * Turned the patch into a series of 2, the second re-introduces the
>      simplifications, and includes further simplification suggested by
>      Valentin Schneider in the discussion for Version 2.
> 
> Steve Wahl (2):
>    sched/topology: improve topology_span_sane speed
>    sched/topology: Refinement to topology_span_sane speedup
> 
>   kernel/sched/topology.c | 73 +++++++++++++++++++++++++++--------------
>   1 file changed, 48 insertions(+), 25 deletions(-)
> 



