Return-Path: <linux-kernel+bounces-360455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1895F999B31
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F2B1C228AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5FE1EF942;
	Fri, 11 Oct 2024 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u1spARxz"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A2804
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728617496; cv=fail; b=BcQvriFJWDh6psrv/wOyFuZFfnG5NL3wiqnAqMcacxBh5KBJkRVi8qDZopQNptW//ps7s2clg8EGqVDtt7u58M8LsUuOmk7m+rhKJlOPBOmHc6ppoZ8uIb7TbOLGK6Kv+PEWKGpEnG8Ik0RWi66OzIT+8D3AuechxMl5RgDSeoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728617496; c=relaxed/simple;
	bh=PjhHHEpOitlXy6X7Vm7zZ+U9JTF/Eg/Jb4gdlmwoB6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NMZg7PH5L/LGnDfThcPy0hH1gMkkxN2gyewACgJJ95lOtaSJZv6BVFUmIpUiUKSot2t0PEPnH2GRUdkLoCySApfFFXp0cGII/KMlnlBEHtK9nIqW3WQRNW5J8NKQad/zkobo1//UZlCaKANaMurP7PFGfpILZ8sqQMLBJjxy/0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u1spARxz; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtWBGYs79Iz7NCOIV4L2tIu06MfRKKUN9vy+iTGyqSZeL5Ssusf9DMU/q3205btxHDE0JFAYRimS15jWt9S6pRxx8D1xe9J9pNecFiGmTBGfBlqZ80f9pMG84uv1tvdS4rvzZmLTYq+d9ZWGs+lKNNVHDblpqCceJwchda+jj2zvBvQl2psEW92hQXxEz1EVlHQlMlS7D5Le5+gyQjPb9Bsq4p/UOgYatkOPkeUfpFpa8oM40lT3ReTP2Ty16SWrvLjaTxL+O5YXGp9bwtyWkJ00CG5LyYLjpaB/Xn6FdE8ZAJEfu68REd6uz3d1eFfmtO1Y3hiMU6x38b1UWIZa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1zjzPtrbcukDfcm6fCLlKr5Irv+O4E/2SdC+Ydhwc4=;
 b=qlO6nSkrvj10F3hp0rub1bGZyZxYoZJwUk+62UY1tAzexM4ZZNc46yIXUHoXkSqZYNekwUbE4KTUGIegrvxQMbBCMBFcU1f6wDIXEf430yzmHhGOcrTJaZDx5TqgvJcKYps0L8tyv2XVl2yc8AmWgRBKLxRfyxSd+JaSjpUCB8uf4QslmgdWW/vcaPahGboYD7AtpHbZ4MufPjW2eRJTD+Q8EU6ITeKW8BJ5lKL4M00n3x9Jlafr2b9Cl2MsflifTNUV7Xt3tWyz5lp49ZRv+drjO97/782ez4ms7Kxun8O89zZzK40fVw4eS8U/pe5EsASbSw76uLs3RdRXoiKt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=cmpxchg.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1zjzPtrbcukDfcm6fCLlKr5Irv+O4E/2SdC+Ydhwc4=;
 b=u1spARxzknXpX79lAGnBQG/E1xPLzhc2HzgkoSEjXKqH0Vun6aqieXyMSN0zhbjOXOyf6OymJVzkPGrJCLaqF/GtK8pqeTmhKGSf8DKRAhHah2lFFASBlq230oq0MC7nt7Wh1YdLukCvUHhEmeBPlyq3VcI7MF7s0bhJrjqrGQk=
Received: from BN9P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::21)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 03:31:27 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::39) by BN9P220CA0016.outlook.office365.com
 (2603:10b6:408:13e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Fri, 11 Oct 2024 03:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Fri, 11 Oct 2024 03:31:27 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 22:31:07 -0500
Message-ID: <ae7bd73b-63d8-941b-ba7c-5c857a013346@amd.com>
Date: Fri, 11 Oct 2024 09:01:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/3] sched/core: Indicate a sched_delayed task was
 migrated before wakeup
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Suren Baghdasaryan
	<surenb@google.com>, <linux-kernel@vger.kernel.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Klaus Kudielka
	<klaus.kudielka@gmail.com>, Chris Bainbridge <chris.bainbridge@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Youssef Esmat
	<youssefesmat@google.com>, Paul Menzel <pmenzel@molgen.mpg.de>, "Bert
 Karwatzki" <spasswolf@web.de>, <regressions@lists.linux.dev>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
 <20241010082838.2474-4-kprateek.nayak@amd.com>
 <20241010130316.GA181795@cmpxchg.org>
 <20241010130621.GH17263@noisy.programming.kicks-ass.net>
 <20241010193712.GC181795@cmpxchg.org>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241010193712.GC181795@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b554e24-f4b4-4ee2-5ac6-08dce9a53068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODNkemdBcEJvNDI4eVhQZmR5OWhkdlBTekhLaEs5UkFsSFJkRUFIMHZqcTdQ?=
 =?utf-8?B?L2poVXIzNGg4dHdJNkhvbE9HLzBTdW9pVTRoZWlaOFhSVGVKSHl5Z0g3TlpZ?=
 =?utf-8?B?TTF3M3lhTE1maEg3QkJaNXlWWkxRNzd3QmQ3cFpVY25pbFJ4akhRb095N1VJ?=
 =?utf-8?B?SVVUa0NFQVhYbUVXbTd1QWtQQlI0SUI4QlBmRFgrcW0rL0xCU2tQNXNIT2tW?=
 =?utf-8?B?aE85S3UxazAxWGxmSkFoeFVaWUZDaFNkSEs4QkVDS1M1VHVCWXBNTjNDM09a?=
 =?utf-8?B?NUthSVo5cHZQY1NjV0hLRGFsWkFBYkhDZytxb2VYTVJPZmFtTmtkbGtIbnF3?=
 =?utf-8?B?V1ltMkNEaXBPSHZaekYwS2NJcEFNRDdKV2RPSWdKTVRMWGZXZXBoRUVOeTdI?=
 =?utf-8?B?M0g5c08vWnVZNnVXWTY3S21VZUgxL2dIQWRvR0ZOUzBpaDJMc2RZNDk3cDZV?=
 =?utf-8?B?SEdFbmR2aTBlSU80dDYyU0JoY1I1eTRKUWQ0eEZxc015bVJZZjh6WW9mejJL?=
 =?utf-8?B?UEczNkYrNTZOZ3hLbk5Sbzd2WkdGcTNoK0VLTTExSGtSM25wYTZFSHdtOXpv?=
 =?utf-8?B?WHk2azdmNjVFcThsMzNrZWZIZzNhZUNZS0xndWhHMDZBRlhaandhVUhGbGhM?=
 =?utf-8?B?UjUyeU5kc01TVG5rOGpHVWlBVEliMGtwZVBRdjlPS2ZhazA5Y0JmTVQ0cFFS?=
 =?utf-8?B?NDhxN043UE1VU284eEt0ZXpXY1c2K0lLOHlMa2psckJXZTZEdEtPdzFpTjc3?=
 =?utf-8?B?TEJ3ditsSnFHeFRzRjhBKzk3RzYzYlR1RTE5NllBekdpQ3pNelBBeHRUSzVs?=
 =?utf-8?B?WG9UWVZLOUhKK3cyOGs1bWZqczl3UUJYRUx2OVdVSldYcGE2ZFU4WUplbVEw?=
 =?utf-8?B?U0Y4WERiZ2F0aFpMTG1TNjBmZzN4TFNSQUw0TzF5a0xsQ0tRS0k4eTlGN24r?=
 =?utf-8?B?dVY0bm9RTE8rTHRxMXJrZG1Fam5zckpMM1lHR1Q4MEVrMTdWWVNiSERhYndX?=
 =?utf-8?B?aU15UE1JRmlML2tTWlNDZGVEdS8wYjFEdVYza25XcUpDMEViSTh2U3FhRlcz?=
 =?utf-8?B?TnNRNTBQTjl5UnJVU1NQWXBvVThRYkNCbWlOcUV2cnBadm1VRzVGK1A4alZ6?=
 =?utf-8?B?OGRBV3lPZWJ4aTd6bWZscEVXcGpDNjB6eDJBSjVVdzhxUE9TMW92QjUzUDVv?=
 =?utf-8?B?bFA4SnpBbFY2V25SdnljQklTWkNDYXFBSzlqSWgzN1ZkSWZoZlB1VWYvbnAx?=
 =?utf-8?B?Tjl5Z3VaOEdKaFN5SEthMFJxY0N4OGhCVTNqTlp4WWRqK3VxUVVDcjNSQXZN?=
 =?utf-8?B?V0Qyd0ZwMHp1SFdibEFNbVN6WndlUGUrYkFUK3NiQzZOSExBQW1OazA4cmFo?=
 =?utf-8?B?RDRnNXgyWWZZNDd4WVdUeE9MaFNoNDZ6Uzlrc1VuRnI5T3VTVUJkb1RqUnVR?=
 =?utf-8?B?M1kxVDZYSG1IUkgyNUVIbmpGRmFZaFVFZmVicUNJc1NOb3E2bDJ5WENzeVUy?=
 =?utf-8?B?Z2VCSXVkMEhtSkxFMW1vclFiWDc5STZxcU51cWwra29lS1cvUEgzelFaQnFu?=
 =?utf-8?B?ckoxSFJjMURxR1JldGVYMythdlUzejdXdlA0ay82VHo3SFFmOS9wZlRCZzdN?=
 =?utf-8?B?Q1R2bEdCbXBleVk1WGtpMHJobGlaRCs0emxYNk4rSjlwNlRrd29hVllSd0JD?=
 =?utf-8?B?Rkp1cWRwNG4xZkVoZkx1UWU1clF4TElwbnJSMWlDbFpNbEhBV0FJamhIZUJ4?=
 =?utf-8?B?VmpNUFhzd2JQLzRudTB2VnF4RktFQ3E4K1hQYnQzbzNJZUhaMW1QVGlzQWJk?=
 =?utf-8?B?dWpBUUF5YTFBVHl4ek9ja1k0VjFXbWhwbVg5Um1uRWYwNUtWUHJ2NlZtYUVp?=
 =?utf-8?Q?DyttPkp9gO+qp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 03:31:27.0007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b554e24-f4b4-4ee2-5ac6-08dce9a53068
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791

Hello Johannes,

On 10/11/2024 1:07 AM, Johannes Weiner wrote:
> On Thu, Oct 10, 2024 at 03:06:21PM +0200, Peter Zijlstra wrote:
>> On Thu, Oct 10, 2024 at 09:03:16AM -0400, Johannes Weiner wrote:
>>
>>> I'll try to come up with a suitable solution as well, please don't
>>> apply this one for now.
>>
>> I'll make sure it doesn't end up in tip as-is.
> 
> Thanks.
> 
> This would be a replacement patch for #2 and #3 that handles migration
> of delayed tasks. It's slightly more invasive on the psi callback
> side, but I think it keeps the sched core bits simpler. Thoughts?
> 
> ---
> 
>  From d72a665d7c7c7d9c806424f473d13452754471d3 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Thu, 10 Oct 2024 14:37:43 -0400
> Subject: [PATCH] sched: psi: handle delayed-dequeue task migration
> 
> Since sched_delayed tasks remain queued even after blocking, the load
> balancer can migrate them between runqueues while PSI considers them
> to be asleep. As a result, it misreads the migration requeue followed
> by a wakeup as a double queue:
> 
>    psi: inconsistent task state! task=... cpu=... psi_flags=4 clear=. set=4
> 
> First, call psi_enqueue() after p->sched_class->enqueue_task(). A
> wakeup will clear p->se.sched_delayed while a migration will not, so
> psi can use that flag to tell them apart.
> 
> Then teach psi to migrate any "sleep" state when delayed-dequeue tasks
> are being migrated.
> 
> Delayed-dequeue tasks can be revived by ttwu_runnable(), which will
> call down with a new ENQUEUE_DELAYED. Instead of further complicating
> the wakeup conditional in enqueue_task(), identify migration contexts
> instead and default to wakeup handling for all other cases.
> 
> Debugged-by-and-original-fix-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Closes: https://lore.kernel.org/lkml/20240830123458.3557-1-spasswolf@web.de/
> Closes: https://lore.kernel.org/all/cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de/
> Link: https://lore.kernel.org/lkml/f82def74-a64a-4a05-c8d4-4eeb3e03d0c0@amd.com/
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

This approach looks good to me as well! Thank you. I added this on top
of Patch 1 and I haven't seen any PSI splats after my stress test. Feel
free to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> ---
>   kernel/sched/core.c  | 12 +++++------
>   kernel/sched/stats.h | 48 ++++++++++++++++++++++++++++++--------------
>   2 files changed, 39 insertions(+), 21 deletions(-)
> 
> [..snip..]

