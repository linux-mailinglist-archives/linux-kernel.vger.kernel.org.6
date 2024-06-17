Return-Path: <linux-kernel+bounces-218197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B790BA99
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59061C22F80
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074F31990BA;
	Mon, 17 Jun 2024 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="unABB0fE"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6C167DAC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651490; cv=fail; b=edGtVZwAbaAgD/Mfy4KEbsec9udqLniun/emAsQkx0HGs5xwZakF5QzMpqfAvG/XH5Jx7OiZEaVfcC74byaEiLBJEATU3lqT3zB7+y31HwUrPDXoqKz926OKcexDQKwIp3rIVFpSJINaSa29ghrAXqElR1lqKHvZGmGOh4IXc4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651490; c=relaxed/simple;
	bh=4L+Kk4wUdb1ZcNAxRAH+v6/aVv3eNZR/5/V4mYOlTRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dHUsNWDiZRlA2k7NSe/8+nZAQB2ZuTVDP9nunX2KmXcFRCv1AWS5fjbsb4OJDWhUYIL9EC8UznBKB1TTfyR/7oj9Q/FNxptWeaypIZ6dIRb5FsOcl8B1ZfFtqbIU0iXuB0Thl37xi4IxH/JQ8jPnaBehvLFDAEdDefNA6WMIBNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=unABB0fE; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EK2STnPJ2MmvId8UpIMnhHJbG9He0u2pIji79o4c59IYBxmuKIr58XcGjkOzkkI+WS07y1HJuxspa+hIUJoe8s0oDmm7K/UXtGXwcZMsqicts8ck/1SEnrJky/TOlcYx4JUP4WmCDAU8dIvXTNVpZ9Irx2FKwgFz7qn2AnhMf+yV6qxIoWhL9CVfYx0wxijyd47ilz2HRqG3QqqXNyr7y/73AOVxeIbpYolj0l3DJAzaQ0IT4k/dEqDXak2dI9aQFTqi9kHgmEVPENgoBT6Vi6UmPTV4WWnWOamf/WEHsFxA7ZmqeX3l0XjNBBXfQ2d/mJ1NoRJLaznGxYffShlDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dq0335d06eHdmlqnvhuSEkOCzLtaX48lROT2lAWu6Tg=;
 b=SideFWJhq5uh8364YMfvlPpzjXoSbMmX2KkYZwbMrS5KtCgk5d3RJtOO/HmEeKeEz8uQgo01G1sUUCOejP28kxGuYxuOIlM+S5CKnVRecIJhR++r+QI3Aa6JjnpG9vbOX2I0ka+IRoBISDOYGtKWALzCBzr9SSR+UqPpo3wHoaA7prxIeuk6G1X/W5/hmM9gSQyvxJJEOcsSz8SAqBrUBPAo/Mz+glrGVB1/8dYDh+43oJPtlx47qlLMMB7lVJeBI9imJFCWSv8/pNp+JLM9xOT8t9Gr5tRKTW3+GKoeYULMrA4lUpRcgTkdmqaLgVRaGm0xzKTP42cdkpG9GEEH0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dq0335d06eHdmlqnvhuSEkOCzLtaX48lROT2lAWu6Tg=;
 b=unABB0fEITBEgz4jhsxxDxk97Ek/qNEvlzDc+RJBby9FDB1MsvV/7j46rNz25HoFXMN34V3ogyFYND8XkaGfanb2r/bqe11k+SRWn55AU1W7KwPH6c2LOw1cOEyxPPY0SjcTpr37HmJ9fBi9CBEpfcZQ94ay/TAsWQq8SzlKoFQ=
Received: from PH8PR22CA0015.namprd22.prod.outlook.com (2603:10b6:510:2d1::23)
 by CH3PR12MB7619.namprd12.prod.outlook.com (2603:10b6:610:14b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 19:11:25 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::35) by PH8PR22CA0015.outlook.office365.com
 (2603:10b6:510:2d1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 19:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 19:11:25 +0000
Received: from [10.252.208.176] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 14:11:20 -0500
Message-ID: <021e0e63-7904-b952-af9c-7e1764e524dd@amd.com>
Date: Tue, 18 Jun 2024 00:41:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH] sched/numa: scan the vma if it has not been scanned
 for a while
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>, Mel Gorman <mgorman@techsingularity.net>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
CC: Chen Yu <yu.chen.surf@gmail.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, Yujie Liu <yujie.liu@intel.com>, Xiaoping
 Zhou <xiaoping.zhou@intel.com>
References: <20240614045649.133878-1-yu.c.chen@intel.com>
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20240614045649.133878-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CH3PR12MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a8c0ee-f5d3-4115-c478-08dc8f014874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTJSWlYyRHlyR3VRTHdNMFRBY21mamVWQzMwMEpjWDJyVlNQcGkwNDFySW9z?=
 =?utf-8?B?TmxubU5DMnRiNVl0M1RVWEQ5ZldVdHZlcEpITVBpUDUrOGpuazNESGVzWEZ1?=
 =?utf-8?B?T1hSeWNkU2ZKS3lvSFRXNHczVGEzd3VsV2puT3phaE1lKzVYQXI4Z25nL01F?=
 =?utf-8?B?VkxSYUpuUnlNb0FrRytycHYwSlQ2alpJVGZsaERhbm5oNy9DdjZocEQ0c25p?=
 =?utf-8?B?QTAvaGd0MWNuc3lSVStLZDdNY0d1SklOVXdxSlFOVStaRVpQeXg0WitjK1A4?=
 =?utf-8?B?YTB6WXdEbjdMZEU1TCtpazRmTXdQajRNenBLNGFpaW9GY3NTaDRzUStMMFN1?=
 =?utf-8?B?c3BoK2pKTUl3R1h6dmljV0k1K1pCTEJVNGMyZGt2NTFmUGJhcFBJSE9seFJy?=
 =?utf-8?B?Y0twRmNQVWxEc0pnbzRTUUI4VW52cDJRR1piUENsTnhlQVhWMjlYalhBTXJw?=
 =?utf-8?B?TlArMEJ1bHc5QWVDL24yaTFrUUl5WGM3UEFEV2VtcGg2UGdETnJQZjhvUXRB?=
 =?utf-8?B?QS9PaVpCRzZyUW1ZeGJrcFIxMXF4WnRSRUVhc1Zac2FBSFlxMi95bXg1MWZw?=
 =?utf-8?B?YmtnU1FuTFhxMGlYMWwrc08ybjgreTd4VFAzMEhpbUJTSTdwTk0vbW51WFBF?=
 =?utf-8?B?NHhBQkpBTUlNTFFwUU1PWWp3Q05wSkc0NXNPdzNEMGNRR2QvWVN2SGtSTXhj?=
 =?utf-8?B?VWZ5NXZOVGRITklzNWJYZzE0Tnc5Y2lIMkR0SENheGlaeTZOUGNFVG11eHBs?=
 =?utf-8?B?cmoxbXMza0FrbCsvQ2pYelp2QlZtSlhoT3pvemtHclFsRWFjc3JPcUtkYitw?=
 =?utf-8?B?VnVoeWR5ZE92NkxvdjdyVVgzbzJPOFdlYm85a3RCRGFuN1lZQ3pHUHEyWmFW?=
 =?utf-8?B?TUdaeGNaZ0lDUWorK1Z4QnFNTytIUkF3ZXJGRzhsM2tzSnhpS2J2YlpaZVlG?=
 =?utf-8?B?UHZoayt1N1RwOFZUa241cWV3WVZza1pVaU1pWk1vKzlTbXlhZGdsZm56RU15?=
 =?utf-8?B?VnMrMy9kSCtqQTFtUTZvSXREOTZCNXZTbnlTbWw5KzhQbkFyL3Mzc1dFQWJj?=
 =?utf-8?B?ZTRUWFJCNkNjTGpnTlM5Z3ZrWnhZenRaalhDZlo0V3ZBcTZSTXRCSUtaQjYy?=
 =?utf-8?B?VmhXa29kQ1VBU3U0Tmc4QnFKSFNsRkprZ3FPQWd6aGo5S0ZKaW1LQzNDbElm?=
 =?utf-8?B?WFgrYXRwTnNKcE9YcTRobE41ek9MRHlDalhKT0ErTHJJZHM0djRjdzBSR2NJ?=
 =?utf-8?B?ZXhkaDBMdEUzY3FSQy9Beld1TzA5ZWt1WEpTK1FIbXZtVmZDcEdMZC9ZcTd3?=
 =?utf-8?B?V25jSjR1UnpoWVFJUXFmRGI3Tjc0Y3VGdUtEMTBRMFljRzhqUy9IeGlYNGlp?=
 =?utf-8?B?NG5JZ2xqL1VpTnJjRzRla2RjNlFwWU5Na1gxbTErTFJoQThpcGxXWjFSRzRH?=
 =?utf-8?B?OW1RTXNPd1NzMTFTcGdFd0Z3dGxXTkdnSEV6eWtTSWVHYkRUV3JNZlVqeWQ2?=
 =?utf-8?B?NmUwRkx6TU5GYmwrdyt6b0phVVgzMCtzdkZxQ1A2c2V5MTZLd1g1K1kvR1RV?=
 =?utf-8?B?cnFNYkxCc2gwRUp2U1F1SFVJbWRLc0w5UlZXTU5CWVNWbFh6dzU1RFhMTUNo?=
 =?utf-8?B?WXZ3VE8yRG0rb1hkWE9VOW9UMUkyK2NoK3BxeERIU1FlU2lMNjRtVWJvR1Fi?=
 =?utf-8?B?YnFBYkRhbi9aNFRMTFpSa3JuMzVZdFBmeEwvQngxWG5DTFZOMFdBUE45elRp?=
 =?utf-8?B?ekcrTEU3Qnl4UFV4N0VLdm9FL3NCWDNyWTlTL0JSa2NQWndTUDZjcG8wbzlk?=
 =?utf-8?Q?/JydHRSZMjzyhH5iA+0DI6k/2279hrSwCN6O0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 19:11:25.2181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a8c0ee-f5d3-4115-c478-08dc8f014874
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7619



On 6/14/2024 10:26 AM, Chen Yu wrote:
> From: Yujie Liu <yujie.liu@intel.com>
> 
> Problem statement:
> Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic"), the
> Numa vma scan overhead has been reduced a lot. Meanwhile, it could be
> a double-sword that, the reducing of the vma scan might create less Numa
> page fault information. The insufficient information makes it harder for
> the Numa balancer to make decision. Later,
> commit b7a5b537c55c08 ("sched/numa: Complete scanning of partial VMAs
> regardless of PID activity") and commit 84db47ca7146d7 ("sched/numa: Fix
> mm numa_scan_seq based unconditional scan") are found to bring back part
> of the performance.
> 
> Recently when running SPECcpu on a 320 CPUs/2 Sockets system, a long
> duration of remote Numa node read was observed by PMU events. It causes
> high core-to-core variance and performance penalty. After the
> investigation, it is found that many vmas are skipped due to the active
> PID check. According to the trace events, in most cases, vma_is_accessed()
> returns false because both pids_active[0] and pids_active[1] have been
> cleared.
> 

Thank you for reporting this and also giving potential fix.
I do think this is a good fix to start with.

> As an experiment, if the vma_is_accessed() is hacked to always return true,
> the long duration remote Numa access is gone.
> 
> Proposal:
> The main idea is to adjust vma_is_accessed() to let it return true easier.
> 
> solution 1 is to extend the pids_active[] from 2 to N, which has already
> been proposed by Peter[1]. And how to decide N needs investigation.
> 

I am curious if this (PeterZ's suggestion) implementation in PATCH1 of
link: 
https://lore.kernel.org/linux-mm/cover.1710829750.git.raghavendra.kt@amd.com/

get some benefit. I did not see good usecase at that point. but worth a
try to see if it improves performance in your case.


> solution 2 is to compare the diff between mm->numa_scan_seq and
> vma->numab_state->prev_scan_seq. If the diff has exceeded the threshold,
> scan the vma.
> 
> solution 2 can be used to cover process-based workload(SPECcpu eg). The
> reason is: There is only 1 thread within this process. If this process
> access the vma at the beginning, then sleeps for a long time, the
> pid_active array will be cleared. When this process is woken up, it will
> never get a chance to set prot_none anymore. Because only the first 2
> times of access is regarded as accessed:
> (current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2
> and no other threads can help set this prot_none.
> 

To Summarize: (just thinking loud on the problem IIUC)
The issue overall is, we are not handling the scanning of a single
(fewer) thread task that sleeps or inactive) some time adequately.

one solution is to unconditionally return true (in a way inversely 
proportional to number of threads in a task).

But,
1. Does it regress single (or fewer) threaded tasks which does
  not really need aggressive scanning.

2. Are we able to address the issue for multi threaded tasks which
show similar kind of pattern (viz., inactive for some duration regularly).

Having said this,
I do not have any thing strong against the approach.
I will also try to reproduce the issue, mean while thinking, if there 
could be a better approach.

(unrelated to this, /me still think more scanning needed for tasks with
  a bigger vma something like PATCH3 in same link given above).

> This patch is mainly to raise this question, and seek for suggestion from
> the community to handle it properly. Thanks in advance for any suggestion.
> 
> Link: https://lore.kernel.org/lkml/Y9zxkGf50bqkucum@hirez.programming.kicks-ass.net/ #1
> Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
> Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>   kernel/sched/fair.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..2b74fc06fb95 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3188,6 +3188,14 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
>   		return true;
>   	}
>   
> +	/*
> +	 * This vma has not been accessed for a while, and has limited number of threads
> +	 * within the current task can help.
> +	 */
> +	if (READ_ONCE(mm->numa_scan_seq) >
> +	   (vma->numab_state->prev_scan_seq + get_nr_threads(current)))
> +		return true;
> +

I see we do update prev_scan_seq to current numa_scan_seq at the
end of scanning. So we are good here, by just returning true.

>   	return false;
>   }
>   

Thanks and Regards
- Raghu

