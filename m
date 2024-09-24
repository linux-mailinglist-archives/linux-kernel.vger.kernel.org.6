Return-Path: <linux-kernel+bounces-336979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0294598439D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902CFB2840C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AD17BEA2;
	Tue, 24 Sep 2024 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ojn5kIat"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E017BB12
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173685; cv=fail; b=P6tNfNgvPfUxy8DG7z6cxdDx+EWqmHydrrJmNwnJLWHqiwyAm3nPeSZcZv2ODUEbnvvYsR//6t9+/S1RsDinG1LrVpxdFrOyC4Le9pt3EzTM7Jr0xE1eKB2cWZriWBpOyfJ71CBegrmVT8P8yAxf0p7wcxbpM8DAFZ3jUteXiC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173685; c=relaxed/simple;
	bh=L4B8aw6j3U7WZRsxdU9xraxGGbB8tlptihA1p9qY4C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F3y16g4Jkyoqp2iQ9QbpzNXY+fmkICpdSFoL7jjl0tiy+2z8OF8dF5K59Q7pPu+kSaoSx7OlCssTkpC/wwYzrZbwVDttWZQILLXR8k5n4Es7mnOXFstQ14tHcxPwPMrTpC8Mhpbo0gbDdMQlqaYT1Sf/Suyll3N0H4PHSPG3kzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ojn5kIat; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=my/KP7r4OS7+zBE2+CfwtW6dznMiNaVE1xzv+VmumuVuyS6Rve9sDKonI/Kq329nz/1TNFE7ky4/s5712WYTztDODj2nyZDPgVD7tnGNaT6Zp70+ekRBG3MOLo6m3y7d8lLwm9R5FHRPhdr29Y4PuXFTgKNbCseoQ5g15Er/keNU4dcraLP1hhXb0dpqZ8MfulJmdNomXE2RilG7LUnL8GMVBLy7ADJDIA+DpHyvB9MaXiYMy9ebm2AaUuThqzr8B4tT+c42OzWIYypbOFrH8YBeZTtJ+VU3z5pws/cEvAXk33YmhbU803FeiY8oQ51jn5eY53mPtZ3nFlJDnuAFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly0Sqw/WT6LQ+7g/DbKP52+TRqlOCYF2lh3zXf33VMI=;
 b=FEq237SqPbRQctB9ITpBGEige56RE9jXqHj5hFId5JhIvErmY6ZlY5lxacNU5HiW4P82G4a9ncu34H3H3IzBkLbCK9c5D2ZBJ48o2zCfq9YMVBvGYwfon7BUjmYZQ2NzGWQvlp6Aq+qTaxJOl0yx9YDD+Z3hK20oLaj0zzIirct46LK5C0Xl1zXk3i65vrgXh1mu8F3TeSnxDXp752nHVht2ZvKRFvcvrJYTcxmkAXuPEjd12nrNG3/yyhtQxWBPKTd4vPLPZ+4hDrLqabPS8XSTyfvFtzxh73+6G8hw6R34vpjeA+s5agt8tTdi8mXih7B6x3suQ7d6shJ3duAdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly0Sqw/WT6LQ+7g/DbKP52+TRqlOCYF2lh3zXf33VMI=;
 b=ojn5kIatWrvP2serCMGfQR+h2eXUgtVQfNPcTwWCAF3WfDvevrrw00v+wXQjjvK3cPxodsqvlo5ldz8nDEjPsJoQPx+/mtX3gJe6GnM+eGltpKH3aqQL07IK9LTYtj6+gJl6LTIrqMqgAA2+VE8egHtcOPl5oK8pKVEBt5vbI7o=
Received: from MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::18)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 24 Sep
 2024 10:27:58 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::b7) by MW4P222CA0013.outlook.office365.com
 (2603:10b6:303:114::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.30 via Frontend
 Transport; Tue, 24 Sep 2024 10:27:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 10:27:57 +0000
Received: from [10.136.36.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 05:27:53 -0500
Message-ID: <3c969a0b-812e-dedd-b9ed-6378f61d5735@amd.com>
Date: Tue, 24 Sep 2024 15:57:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, Chunxin Zang
	<zangchunxin@lixiang.com>, <linux-kernel@vger.kernel.org>, Oliver Sang
	<oliver.sang@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Ingo Molnar
	<mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
References: <20240923072156.343623-1-yu.c.chen@intel.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240923072156.343623-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: cd26b523-7e6d-4e3f-0ba6-08dcdc838ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmw1S3M4ZkJwdmZEQXFJVkRaRjZ0TWhzeU9DcUtpOHN5bUhXSnlwMkpYMDlw?=
 =?utf-8?B?dm1MMDdUZ2dWYkkvL0xWb1ZZOXYzWmZkanh3MHNnYkdoUlMyalc5Qll2NXJk?=
 =?utf-8?B?Q2g3ZWhHbytVREVJNGdPQlFBR3JpT2VFUlVMNHZQVDVRcWJwZ2llc0J0eXU1?=
 =?utf-8?B?VG1CSm5ISG9xYjArdjZQak1oME5oU3NSR1p1ZTZINFdxZDlrbVFRek9Ram9Q?=
 =?utf-8?B?a0UvenBsYmdsajFNVFN1Y1g4Tmp0cTJKc1N3NTR5Qm5PY3l2TnJmOVFZOUdp?=
 =?utf-8?B?TUk0Wm9KZEtYZmJKalhib0Q4ZjFHeDlMZE9pZEZKdmhNZzE1bFZnUkZkdVQ3?=
 =?utf-8?B?eHBySlZNaVFGaFM4R1hidEJRc2I4aWZJUndsanAxZldib0M2cU5rV3dza1Q5?=
 =?utf-8?B?ZmQ2TmRHMlZIZFphcExaSTAzQS9EdUQrRnY2TEZHeHcrTCtrL2JKaDAremlT?=
 =?utf-8?B?bHlCRThTaDR6T0VBSDVudUhBNXJheDM3WXFZUFN6RG1PalAxUFNtTW1pTFBT?=
 =?utf-8?B?OWFDTWk4WURkY2gycGhTVzdPYytub1RUcFBGQmRoM0I0eklxMFcybUZtdXQx?=
 =?utf-8?B?RXhqaFkyYmNHd0x0VC9PWWhuK3JoWXNKc0dlL3I1MXA0WVAwUWxIVEJaY3p6?=
 =?utf-8?B?RnJ6OCt5dFBDckZpSkY1N2NLN256cDBsZ256UlJka1dYdGhoMTRyTkQ3K3h1?=
 =?utf-8?B?NDUwb0VSRnRjQmkrRUF6K3pqS3ErRmJ0ZmVKVW1WRkVzTVVpQzl6ai95NWhr?=
 =?utf-8?B?aXVydFFUb1hJV0RyRHlFaXcreUlCQXRRTm5rMC9UTW9SVXdSYkY5Vis2MmF4?=
 =?utf-8?B?enRhNVVDUWlvWXNQTjVGbjVZeW00OHo1YU1NbHc5Mnh5OGRaMnBBYzM4VURV?=
 =?utf-8?B?enpMV2t2S09vVHVnZXpQSndTRlJzWW9nVlBkczEyK0tEUUVQY1lmNm5QM3VI?=
 =?utf-8?B?YWxzUVFhWHhKRWN3bEd0V0IwNnRreXZtdUViVkR0K2RlOTE5Q2JZMk5SMzk4?=
 =?utf-8?B?eWJwUVZhTDhNY3BpTHNETEtxclROd0xIaUdjc1FRTnpwUTBCaGVNRFAzbVlj?=
 =?utf-8?B?azBEM01kQXRHNUtiY1Rxa1Ewdi94UCsyVjVJd2ZwS09XNGpudzRUQTRqUXNH?=
 =?utf-8?B?VnRMSGlJeU90aFA3d0dja3ZWNi9hL1d6aTdibG1XdytWd0ZJNU9sMVI3WDNG?=
 =?utf-8?B?V2dQS2ZjVS90YTZXa0U1TzlMRjNZY1E0a2tNYkpWa3poamx4aUVQZzg0NnN3?=
 =?utf-8?B?Y2I4ZTRTcWIzVWpOUE1FN0hwV1R1eGZOc3M5M0Fudk1jTkxZOFZVRks2TGZt?=
 =?utf-8?B?MnlBbWhGY0VTVHR3QmdFKzZBeWFWeFhhY1cweXdwNnBsUlJXWGQvVFFOdmRS?=
 =?utf-8?B?dERpVVZNc2kyaGp0a3M1N0xRb0theXRtMjFHNCtpL3A3UmlWU2h4K3lJQSsy?=
 =?utf-8?B?QmRhRXhIZVZENVJ1dk12Sy9Qcnk4WXE2aHA1dTZybGx2cjhybmFHbTFBMGUx?=
 =?utf-8?B?a3FRTjcvcFlyWFZUQlBldGR5UWxpcnU0L0RKTnJGd0NoanhWdXN6OWsrYkRh?=
 =?utf-8?B?MGFxRnZQQitzOExTT0ZJT3hZRkdsVFh5eEs1RVRJdjVSMTNtTzNHZFFvdmM3?=
 =?utf-8?B?UTV1RWtVTGVzalhlNUcwOUNLWHFra2QvUWMwYnYweWtITkExOVFURk82RzVF?=
 =?utf-8?B?UHNhRHozcnc4Z3NPK2tmWksxcFhLOGVCUFpoNm4rQWxETGEwRXFUOXVGVkFO?=
 =?utf-8?B?M2VIa3ZSeFZQOE5mUllZTGd2MURmWFVuc0ttaXdSQSsvUnJvRjhOYVVqV2ty?=
 =?utf-8?B?QlZ2U3JoeTUrRUFkaWJCZm5SemFHTHVWNU8zSWQyK0V6Z1I1amxWUVlEQUM2?=
 =?utf-8?Q?UxlPOiDfVAUvw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 10:27:57.2703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd26b523-7e6d-4e3f-0ba6-08dcdc838ecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254

Hello Chenyu,

On 9/23/2024 12:51 PM, Chen Yu wrote:
> Commit 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
> introduced a mechanism that a wakee with shorter slice could preempt
> the current running task. It also lower the bar for the current task
> to be preempted, by checking the rq->nr_running instead of cfs_rq->nr_running
> when the current task has ran out of time slice. Say, if there is 1 cfs
> task and 1 rt task, before 85e511df3cec, update_deadline() will
> not trigger a reschedule, and after 85e511df3cec, since rq->nr_running
> is 2 and resched is true, a resched_curr() would happen.
> 
> Some workloads (like the hackbench reported by lkp) do not like
> over-scheduling. We can see that the preemption rate has been
> increased by 2.2%:
> 
> 1.654e+08            +2.2%   1.69e+08        hackbench.time.involuntary_context_switches
> 
> Restore its previous check criterion.
> 
> Fixes: 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409231416.9403c2e9-oliver.sang@intel.com
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Gave it a spin on my dual socket 3rd Generation EPYC System and I do not
as big a jump in hackbench numbers as Oliver reported, most likely
because I couldn't emulate the exact scenario where a fair task is
running in presence of an RT task queued. Following are numbers from my
testing:

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:           tip[pct imp](CV)    preempt-fix[pct imp](CV)
  1-groups     1.00 [ -0.00]( 2.60)     1.00 [  0.17]( 2.12)
  2-groups     1.00 [ -0.00]( 1.21)     0.98 [  2.05]( 0.95)
  4-groups     1.00 [ -0.00]( 1.63)     0.97 [  2.65]( 1.53)
  8-groups     1.00 [ -0.00]( 1.34)     0.99 [  0.81]( 1.33)
16-groups     1.00 [ -0.00]( 2.07)     0.98 [  2.31]( 1.09)
--

Feel free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> ---
>   kernel/sched/fair.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 225b31aaee55..2859fc7e2da2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1025,7 +1025,7 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   	/*
>   	 * The task has consumed its request, reschedule.
>   	 */
> -	return true;
> +	return (cfs_rq->nr_running > 1);

Was there a strong reason why Peter decided to use "rq->nr_running"
instead of "cfs_rq->nr_running" with PREEMPT_SHORT in update_curr()?

I wonder if it was to force a pick_next_task() cycle to dequeue a
possibly delayed entity but AFAICT, "cfs_rq->nr_running" should
account for the delayed entity still on the cfs_rq and perhaps the
early return in update_curr() can just be changed to use
"cfs_rq->nr_running". Not sure if I'm missing something trivial.

>   }
>   
>   #include "pelt.h"

-- 
Thanks and Regards,
Prateek

