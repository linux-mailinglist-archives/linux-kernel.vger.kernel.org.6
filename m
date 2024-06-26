Return-Path: <linux-kernel+bounces-230221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847139179FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39775285248
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C288815CD4D;
	Wed, 26 Jun 2024 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m7FqvCgG"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198A415B55D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387771; cv=fail; b=Q6FPUSnYpzLTlxm71HXBCuFo9DqnFBthbUT/EPkJ7I5EP4xc4QL7vtEHyetdy07fvH1fPQcInVpASIlTtb64Ok9BmY0y7cT/bdEVzlvOk64cPijhkeFb5TQyaZt/CX/9NfuUU20k5bgO3bBvSICPEX7oncHx4Rd3D62LF6hE7XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387771; c=relaxed/simple;
	bh=+6Q8vp3H6ZI5LBeagpP1GcUUFsA7yYXRieAwNzG7uTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J+VSpbe7HoJtAXA/2hZQau8oR7L7AxXjOLAnl4rkXrzwDcP7oOD0Opz3c751fpZ+fhWG6r6Qwfpf97xHcGZvp4PJ9xk7sCMRHeSy67riRf2G1BAMGKHS0tWabEUlNmDVo1Du71fS8D0yt3CbeYx4UJC7DeVttktV2pOKcwqmZdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m7FqvCgG; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjZldHx8l5OcJjfMRJJxCZyRx0C4+FSMO+dbJE7hUdqjl2UIQikCG2Velk5klvFlQ7dBzc3snX7FU+HZ6vwWlrnBS+FcbLoktUh7oNH6IQHWfKkakgZW4NlSqzIjtRviZ6ch23A5aC5sjLlQbDhlCTWtWwOd2oBHEcTBAdm9mrhV2Qqrd/keEZ8QfQmvOtL22RqNmCO00YhbLncPPOu45wlGq4b3H117kYhFE3zCrqbsHhH0Kn0ZbejtuWO9cilkQ4hjRW9PfQXjdIlihdcN9YorNbpLTnWOnmUd99fBQ4rzgEEcNN67bj7FIRg2D09J+nKNuMam4jF05rGiPld/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oB8ajsve03n/d3txtTSdktyvL9aAeeJ5xUDSrZGshUM=;
 b=bCNcoqK1py/uIZIuzr6IWBbxRrM0aDaiXBT7u9umm+tlUnMnnf/whr1hUo3fg3ACu9WVBbsju6oLCORxeaHwCZF4Nh6y+AqRgtrHN5evkJhHUOrXFL/hn04/nsBnaL/wz61EvZM4Pi2O/3fb06zN35I2G5yILrqIwygf4YnUKLtSx45Mi48bcef2J9VwVxsgVCUmos/voxZMVSdMI1q2z98DVosKLKGk+etbBihHeN3Agc6c+eHGOVPSf0gmv4K09VULszoV2pZxNOl+umS+67I3NWjHCeVx53pltYoR9MabUGG2dJpJNCjBo9ydh2AhJGOPPtTZyxcyloTygyqYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB8ajsve03n/d3txtTSdktyvL9aAeeJ5xUDSrZGshUM=;
 b=m7FqvCgGzsyo4yH8TJqK1LW/Zpd1Tfmc78GKFBSVOE14EvKZdDhK2c3rrHxNuR7PtYkWceEPSoTu6+9KfevsoWNyq03kXbfqa2L84gC0MMI8ZxMT9shKjDj82uLb8F63XRKBxFZ7rVrB5dlUt7NM/8ifxIDjofDXaYCO6dGDr4c=
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.33; Wed, 26 Jun
 2024 07:42:46 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::e3) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.24 via Frontend
 Transport; Wed, 26 Jun 2024 07:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Wed, 26 Jun 2024 07:42:45 +0000
Received: from [172.31.179.82] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 02:42:40 -0500
Message-ID: <86dee1e0-e2b7-7134-82fb-c501cc42dfa8@amd.com>
Date: Wed, 26 Jun 2024 13:12:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 1 1/1] sched/numa: Hot VMA and shared VMA optimization
To: Chen Yu <yu.c.chen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Mel Gorman
	<mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@redhat.com>, <rppt@kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Bharata B Rao <bharata@amd.com>, Johannes Weiner <jweiner@fb.com>, "kernel
 test robot" <oliver.sang@intel.com>, Yujie Liu <yujie.liu@intel.com>
References: <cover.1710829750.git.raghavendra.kt@amd.com>
 <88d16815ef4cc2b6c08b4bb713b25421b5589bc7.1710829750.git.raghavendra.kt@amd.com>
 <ZnrSIGKBpyeTmSJt@chenyu5-mobl2>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <ZnrSIGKBpyeTmSJt@chenyu5-mobl2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: c63100e8-55a6-4bec-3c46-08dc95b391e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|376012|7416012|36860700011|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDIra2V5QUczSDErdWpQTUcySWJjeksvdDMzc253VTdDWHZqbTJVOTFTNmZR?=
 =?utf-8?B?TWplQXFwSFNuTWgyVjVGWEhSblJXWlpYb3RKL1ROZmN4YnNOQ08ybG1rTUp6?=
 =?utf-8?B?RkJmc3pabExxRElwZVZxU1ZTT1NNVUxaYWhBb2IxMW5FN2VLOWhGQ0JkV1Nj?=
 =?utf-8?B?WmJ4SUw2OG9lWFpuMmpoeldHOVlNc1cyb2xrMXUrMEF4Q0JjcEFPc1lMejdZ?=
 =?utf-8?B?eVZ0bEtlN29ySTh5WHBPVG5FUERBRlo0SExza2dlUEFHR3M3N2h0Mzg0YUZU?=
 =?utf-8?B?MUFBYlVkT1A4ZGRCamQ1cjhlMHhtaWEwWGwzSmpidUEzUVBNcjNmVnV2TnFj?=
 =?utf-8?B?U2xBVmcwUm81MTBuai8zWVdMTjJWSE4vOTJOZDVCK2dwRjFoRXZxR010cWlM?=
 =?utf-8?B?dlRydEdaZUlmdUVxYjJvbHF4SFB6M2liazZXMERxOFAzT001dUxhN25uYXJX?=
 =?utf-8?B?aHlMTVhKTWx4Q2pPMzZVRVdTWDV4QTZ1NHhkMVR5NnI4L05iVk92VE1uQlUr?=
 =?utf-8?B?dnlYbGtPa0t0RVFKRi9XazVMZWxHWC9qOTJPQnpzVjY3dmc3Z2NEVVAvSVVH?=
 =?utf-8?B?aG5najJhUS9KRHBKVFQ0R3A2eWJwSlMxSFp3RGs0eGJ0UERrTENXdlV3RVRO?=
 =?utf-8?B?eG5Eb1ZPUkM1eXZ2OUlnM05wVjZYL0MySkJ2NTFKcUpWQkp5NU9oWmk4SWE0?=
 =?utf-8?B?eXprbkZnMnhDdDl6bjBDNVNrMEYrMGU4ay9vREVhVnA3T2JYbzBIa2ZOU2NB?=
 =?utf-8?B?T2RNeitFaDlUYkZxbjRJV0xCWFoyUkc2VVBZVmV2WUtscGgxZ0laSUZZOW8y?=
 =?utf-8?B?OFMzaklkTDJkMnhNSnI4ZzNGKzhkdEtycGNmbGZ2dEloVS9PVGcxQlZrVmhL?=
 =?utf-8?B?NlhKZ25GcFFjR2UvV0I1ZzlQSS9QVmZHVUxyamhEUGx6OVRlQ1hlWFZDNVB0?=
 =?utf-8?B?NG1DZUJIZGVFaDZ2eWFEcEhhcGlzNVNlbXBDR1VMbGpNektYKzBTTDY2Sk85?=
 =?utf-8?B?cWFYS0E0cW9sV0xIMW9GcSs1WGdLenlob1ZZa2NTTUlCVnBWbzkvUFgyakhJ?=
 =?utf-8?B?cER0TVFBZklSUzRDcCszMWJHck1qdUZTcXcwTklVL3o2TnVyS1NrQ1ZJaHFn?=
 =?utf-8?B?cmV4RHdlbUFTaGtRbEFkazFKdGg1UXNWM3MvbEpuSjAvWnRhTnhMVTJMbFI5?=
 =?utf-8?B?ZndiM1BxM0tkczRRajhvWW5vL2JiZTNQRDJMNDVkdG1OK1hYcjNzSEZTVlo2?=
 =?utf-8?B?bnViU1VEUGhxNU5WaDJJNmErOVhJS29mQ3pVMmVpUm4zb0ZxczdyWk1LNkxs?=
 =?utf-8?B?NWdTTXBCMkQ3ekJrZVRYeTEwWlB1ajk2ZDlkM1RJU05NUm1rbVZjR290MnBt?=
 =?utf-8?B?UTloOElVbk1GcXQ3dDlVMEVQbVhodHhJNmlwVkN0NFY4Z1RVbzFrK1NnM1Ev?=
 =?utf-8?B?dS9IdWJzcmF3V3MyNEQ4QXpjZk9mMjdyQkorRUZrU09HWVpMZU01Nk1DcWVC?=
 =?utf-8?B?emlSOEhvMmsxN1BPVzJQaW5rVVFPSExWbmZRa21kV3JxbHJaZmM3RTYvOXMw?=
 =?utf-8?B?VktPT3NwbmtFZDAzUUJ5dW8wdW5GSmprOW9PN2tNQTR1SmJaL2NsaWdXUUZy?=
 =?utf-8?B?RHRsYU02aDR2ZEFqUFAxWnNXSlN6SDJNbVhxQmhHckJ1L1ZyT0ZLSTRQVC9T?=
 =?utf-8?B?TjlhVEJiZjVOaWhBc0cyQlprelJNYXNobUI5TUdYZTNuVENKeDFrbGFUOWN5?=
 =?utf-8?B?c0hBTm9JRk1RYmVIcEhKOWFRMnJoTENUOTBRd0Ewa3hUL3FZT1RDbVVSUUZC?=
 =?utf-8?B?dlNCVWZsQWlmdWYzM2VVWldScWpaU0xZU2xmcGR5aGljY3lzcWY4UmIxTm4w?=
 =?utf-8?B?V3J4LzlVNVV4SkRlZkwzNnlHeUpxdmIwbEJDNUJxeXFyN2NJOWFKOWNrMWZO?=
 =?utf-8?Q?yfWiISBoUHtFrYIckjhf6vuqrIzKphPg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(376012)(7416012)(36860700011)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 07:42:45.7453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63100e8-55a6-4bec-3c46-08dc95b391e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037



On 6/25/2024 7:50 PM, Chen Yu wrote:
> Hi Raghavendra,
> 
> On 2024-03-22 at 19:11:12 +0530, Raghavendra K T wrote:
>> Optimizations are based on history of PIDs accessing VMA.
>>
>> - Increase tasks' access history windows (PeterZ) from 2 to 4.
>> ( This patch is from Peter Zijlstra <peterz@infradead.org>)
>>
>> Idea: A task is allowed to scan a VMA if:
>> - VMA was very recently accessed as indicated by the latest
>>    access PIDs information (hot VMA).
>> - VMA is shared by more than 2 tasks. Here whole history of VMA's
>> access PIDs is considered using bitmap_weight().
>>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
>> ---
>> I will split the patset and post if we find this pathset useful
>> going further. First patch is from PeterZ.
>>
> 
> This is a good direction I think. We did an initial test using autonumabench
> THREADLOCAL on a 240 CPUs 2 nodes system. It seems that this patch does not
> show obvious difference, but it shows a more stable result(less run-to-run
> variance). We'll enable the Sub-Numa-Cluster to see if there is any difference.
> My understanding is that, if we can extend the NR_ACCESS_PID_HIST further,
> the THREADLOCAL could see more benefits, as each thread has its own VMA. Or maybe
> make the length of VMA access history adaptive(rather than a fixed 4) could be
> more flexible.
>                                            numa_scan_orig    numa_scan_4_history
> Min       syst-NUMA01_THREADLOCAL      388.47 (   0.00%)      397.43 (  -2.31%)
> Min       elsp-NUMA01_THREADLOCAL       40.27 (   0.00%)       38.94 (   3.30%)
> Amean     syst-NUMA01_THREADLOCAL      467.62 (   0.00%)      459.10 (   1.82%)
> Amean     elsp-NUMA01_THREADLOCAL       42.20 (   0.00%)       44.84 (  -6.26%)
> Stddev    syst-NUMA01_THREADLOCAL       74.11 (   0.00%)       60.90 (  17.81%)
> CoeffVar  syst-NUMA01_THREADLOCAL       15.85 (   0.00%)       13.27 (  16.29%)
> Max       syst-NUMA01_THREADLOCAL      535.36 (   0.00%)      519.21 (   3.02%)
> Max       elsp-NUMA01_THREADLOCAL       43.96 (   0.00%)       56.33 ( -28.14%)
> BAmean-50 syst-NUMA01_THREADLOCAL      388.47 (   0.00%)      397.43 (  -2.31%)
> BAmean-50 elsp-NUMA01_THREADLOCAL       40.27 (   0.00%)       38.94 (   3.30%)
> BAmean-95 syst-NUMA01_THREADLOCAL      433.75 (   0.00%)      429.05 (   1.08%)
> BAmean-95 elsp-NUMA01_THREADLOCAL       41.31 (   0.00%)       39.09 (   5.39%)
> BAmean-99 syst-NUMA01_THREADLOCAL      433.75 (   0.00%)      429.05 (   1.08%)
> BAmean-99 elsp-NUMA01_THREADLOCAL       41.31 (   0.00%)       39.09 (   5.39%)
> 

Thanks for the test and report. I will split the patches and also test 
for N=6,8.
(on top of your patch perhaps to make sure we have benefits further).

Making adaptive may be little difficult. How to assess which size is 
doing better dynamically seems to be little hard to imagine for me. (/me
Need to think here)

Thanks and Regards
- Raghu

