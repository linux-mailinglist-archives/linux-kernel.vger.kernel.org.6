Return-Path: <linux-kernel+bounces-358189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C11997B38
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D61FB2265D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2189191F7C;
	Thu, 10 Oct 2024 03:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hsmDISHb"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48680BE57
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728530817; cv=fail; b=ZwrgJal/5uovyDx9XfjAKm2xr3NMwqJVXzWOYi1gF4lTGMYO7tPFYadtQsbJaEwALIia7aJxLx6R/Wb/6K5SbwqxvJt4oYVjrZSICsEkofFiHanBmkZRVCH3AyeHGbDsk4c0byGQ5KW818f+2cie5RMUcexzQG6Rn/eF0cfWEY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728530817; c=relaxed/simple;
	bh=X0GF5o9Rorm7hw8j1v168Rq75bzK/lrlLMOAowxI36U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C5hXdeCOZOw+31fgF6iw2pJl/ts+T5VBBz/oqhbDdYBp+3Heu0hDLRv4wIIdl48sZ97uUyqCdVRuO03OCLdtqthLNY4RRvjz0acXLRIwFHszgNbHSfhy3d/Vx80NHuZSn4gYDgJqVBmpw0RXt8WzW0gF5WfDlQDbR0tD7xxDC6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hsmDISHb; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZM3a9Eas5oO+p5W12Coe2wyHTWzpKJcsr7EUUUrdH0MEoiUPjffdiry8gF+62pzAy8sNtW++VyX9jtud66SihUL3AD53wmGUGgeJBnTxRYmzxjDkTzGhA+khctiUYqhApSQTA9iS7DSzhYSsGM7/wDFbV0oeBwh0znG3f5Dh+8ZJM/DlLxgJ5diQ7LKqv+jbLMF/5UmkNwYUzFb0Xa1wQ7xio6J7oclb+8GiVNxuKf720VL04cQEWXxEAChLsga5ncbq52tbLsYcNmYgIGU4FznVFU0YEh9MHQW3v/GSwuKcRHC6ZpAraPjNJVFLMYKnRLxo2IgZmZenCYkVq65+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KT+CBdxkbZmDNGJeS9GkByAtdedILagXZDlUlZR8D0Y=;
 b=jQQX7XkPz+DLVI2qytYQsggselXs6CJCuNRza4iinCI08ALqOTVF4sCVFHlGw3bzv10tPOVNV9Zxgg0lAX0nXBPznJn2RiX7WBS+nU5LnQus9fCoLBp7CQnQeckvUGLrZYolHoU7yh82GT2cVEvTFjk0Z6nKZExV8F9v/XdLbDtGzKTyqv02WMWIFO0l8fF9yBMiYMwBYgoQMVwe+a4/S8HpxdWl/XYjoVdiQ27CY9HdiHCjZRHbxNQJTxzUdIPdzVcQU+VIi9NF42nBTNk5ylRGXEm+E10mp6sOciTgQ66CAeWyQweDs2Bvg3eGIOuRtV1h4KOghtactXw7GX/2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=cmpxchg.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT+CBdxkbZmDNGJeS9GkByAtdedILagXZDlUlZR8D0Y=;
 b=hsmDISHbNh4+vCBKEaecjMDMgampNTksCCqMMx8bOuJ3R71/E5Ex3Vq9F9iHCrppxrou7frHGRxzD/kmp8pLq6E0IYpO2umDAjpM3pIV6ZwsYL25k9FKhWewUEF6tYwlmPSioy2n6G6aYAg13L/uj4dxzRHni14uLJ+gmm6uGCk=
Received: from BYAPR08CA0011.namprd08.prod.outlook.com (2603:10b6:a03:100::24)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 03:26:53 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::b9) by BYAPR08CA0011.outlook.office365.com
 (2603:10b6:a03:100::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Thu, 10 Oct 2024 03:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 03:26:51 +0000
Received: from [10.136.44.56] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 22:26:45 -0500
Message-ID: <c2969409-6614-1d25-5ee9-73fa5e1fe305@amd.com>
Date: Thu, 10 Oct 2024 08:56:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [REGRESSION] Re: [PATCH 17/24] sched/fair: Implement delayed
 dequeue
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
CC: Peter Zijlstra <peterz@infradead.org>, Klaus Kudielka
	<klaus.kudielka@gmail.com>, Chris Bainbridge <chris.bainbridge@gmail.com>,
	<linux-kernel@vger.kernel.org>, <bsegall@google.com>,
	<dietmar.eggemann@arm.com>, <efault@gmx.de>, <juri.lelli@redhat.com>,
	<mgorman@suse.de>, <mingo@redhat.com>, <rostedt@goodmis.org>,
	<tglx@linutronix.de>, <vincent.guittot@linaro.org>, <vschneid@redhat.com>,
	<wuyun.abel@bytedance.com>, <youssefesmat@chromium.org>, <spasswolf@web.de>,
	<regressions@lists.linux.dev>, "Linux regression tracking (Thorsten
 Leemhuis)" <regressions@leemhuis.info>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>
References: <20240830123458.3557-1-spasswolf@web.de>
 <ZvA7n9GNoD-ipjkj@debian.local>
 <1ee5f5828e2021bf1051dc1f9b6f01a8c061ffb1.camel@gmail.com>
 <2128d714-90f7-1598-b32b-559206fce5de@amd.com>
 <20241004123506.GR18071@noisy.programming.kicks-ass.net>
 <20241004135744.GB1658449@cmpxchg.org>
 <fae14e09-cd35-5feb-c3b4-8318a76b26a3@amd.com>
 <c97da254-9add-85bb-cd46-7c0d5ac77548@amd.com>
 <f82def74-a64a-4a05-c8d4-4eeb3e03d0c0@amd.com>
 <20241009180719.GD6937@cmpxchg.org>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241009180719.GD6937@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: e26f0c9d-d876-40cd-89b5-08dce8db61ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk91RmJydmFvTnVBYlZaa0F2a29HbTBPczZETUd1L2k2SFlWMzVnSlU0K2hx?=
 =?utf-8?B?eWtUc3RBRUIyZTY0d3pXRjVxM1M2UEVCaGdRbnVkVllucWkwcmZTTHlZUWR4?=
 =?utf-8?B?OGl2SHNXcGJmQlBZeFlraWw0cnVGQkxYK09qQ3RabzJoMnZIZEdhdzBWOXpH?=
 =?utf-8?B?bXNjd2dsTktGQVJqbUM2Y0Fpd0laSTFWd1VwYVhHR3dtYkZILzU5ZFBacmVR?=
 =?utf-8?B?Q3VhakhBRVVkcEVaZFNqRi9IQUU3b21jZFBMTE8xaU9WakF6dS8relROYld1?=
 =?utf-8?B?TWVtUGhQd1hvbmZEb2FkbENGQ2ExcEVZOFNxdGh3U1h0d0NPbkEySUw0N0hF?=
 =?utf-8?B?TDlzWFFkVHFlanBmdFBqcmd2ejVqVVF6cmRsaVhDdkdzRlIwVUJtbHpDVXBD?=
 =?utf-8?B?RG1abGNkZWhKYTlpOFo5YlVZLzNnS0lEMUdvaTBqUDFWWXVXYkZkcWV6bVVF?=
 =?utf-8?B?dENMU1lJajJMWDRwUEtSUDA5MmtqN1h0Mm85VEttVHM5eHA1cGVXOGN3RDEr?=
 =?utf-8?B?ekpRY3EvYVZiKzhrNzQ0MExFOEwwaVN1T1JCS2dscFV3OVZPUnBoTkJPc2o2?=
 =?utf-8?B?UXQxcG8vUE03ZlZMcDJXTk50M3pxaUR5UW1kT29jYVZyS2xZV0hIRlVaVGtz?=
 =?utf-8?B?bWVIb2V4QUVzdmJ3Z09lMGxWamxYeFJybmlEbmZsRGc2KzFFSzExVzVnTEpa?=
 =?utf-8?B?UXFaRk1sZG5jTWtNVkxuRkp3NnNscmdCY1BVVVhXd0gyQVNwOXhybkpVRnFu?=
 =?utf-8?B?dDd3bnhMQlNOR2F2eEJ1WnRHNUVRelZLSXAydGh4TmRjdTV2RlNKaGQ5RWJS?=
 =?utf-8?B?ZTVWYnBUakdiS0dORkU4ekQ1VEhSRk9zWkdWRGg0M2FVeis4ZHFjMEdmWlla?=
 =?utf-8?B?TmlKKyt4Z2plQnFXdEVET1BtTzdtZU1pUFdpODhPTTZwWThjYXBETmpEdUda?=
 =?utf-8?B?K2tVVFVXbUR4Q0pYdjBMUlE4U2VraStDSTJHdFlnRTEvcVBUd2xUT0ZHYmtk?=
 =?utf-8?B?RXpkaVZCTnN0ZmZ5dGdiNXdhYWlqK2dGMUwxSm9jQW1NYkViNkJLaklJeHhD?=
 =?utf-8?B?VnpMbmJvV2ZlNHBWcHNJNnJXV2lFb2l4VCtDRjNjV1B1MzZkeDBtaVY4Z1d6?=
 =?utf-8?B?MUhzMFFZTGxjUWpsMjVvZGlpOGNHWWVLNS92bi9hTHNTUmU5aGQ2Nlh5OU1s?=
 =?utf-8?B?aTR5VDdkR244UFlRMW4yR0M1WWxML0hWdS8yTC9xOC9JcktMNEovV0JhNDFP?=
 =?utf-8?B?L3dpUi8wejN2VXpwcXFaTE5VczZpTS80b0J4OTlQUVZVSFJGOEtnRFhCaldy?=
 =?utf-8?B?TWV4cytSM2cvZjcvTXdNOTFHc0FaaUFvY2ROZGpBVmtwSHpDUVppdU4zeG5V?=
 =?utf-8?B?Vlp3ME54VHlLMWdOV1Mxamp5RXExQmhGcGJITVl2am14Z2FxWFQ0OVhFcVQ5?=
 =?utf-8?B?anZ2b1M4MnVJNDE5U3kzMlVsNVlZOUZRZ1BlZUlFR25oeTBPVjBSbmQwaFlG?=
 =?utf-8?B?Wkhkajh5WFdtY1NhVXFib0lyaEtadU5PRWVUUk9wRFNSMmNMMmhrckJKQnZQ?=
 =?utf-8?B?c3ZtWklUT1VrTzRsUGlxbWt6SWEvNzJld3VxNXh2YWpvNUt6bVRZSUgvblcv?=
 =?utf-8?B?MXhMZ2ZZZEpEVmNWTTBJQXo3OHUyeDhtMTd2NkZ3cjBuOS9Bb2FyRWZ5S3A3?=
 =?utf-8?B?TDA3elh1TGZSZ0hqa29JY0dxVFlYNldaOFlDbTJJTEd1SXNyNmJscmdTeUVy?=
 =?utf-8?B?S0ZuQlJFbDBjWFR2a1pEbnNhS2hCci9sZHVXV1B1Zk40amFPaVJEa1NGLzRC?=
 =?utf-8?B?OWtNY1ZGeS9Da1p2SG5TUml3ak9LQ3BVRGNZL1Voaks4K0Iyb0hDa0NQL05Q?=
 =?utf-8?Q?ZEBnql6yoBMeA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 03:26:51.2540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e26f0c9d-d876-40cd-89b5-08dce8db61ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431

Hello Johannes,

On 10/9/2024 11:37 PM, Johannes Weiner wrote:
> On Tue, Oct 08, 2024 at 09:54:52PM +0530, K Prateek Nayak wrote:
>>  From 2e15180e18b51e9a2bc0d7050e915a70d2673a06 Mon Sep 17 00:00:00 2001
>> From: K Prateek Nayak <kprateek.nayak@amd.com>
>> Date: Fri, 4 Oct 2024 15:24:35 +0000
>> Subject: [RFC PATCH] sched/psi: Fixup PSI accounting with DELAY_DEQUEUE
>>
>> After the merge of DELAY_DEQUEUE, "psi: inconsistent task state: warning
>> were seen early into the boot. The crux of the matter is the fact that
>> when a task is delayed, and the delayed task is then migrated, the
>> wakeup context may not have any idea that the task was moved from its
>> previous runqueue. This is the same reason psi_enqueue() considers
>> only ...
>>
>>       (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)
>>
>> ... as a wakeup. In case of a wakeup with migration, PSI forgoes
>> clearing the TSK_IOWAIT flag which seems to be the issue I encountered
>> in my splat previously.
>>
>> With that said, the below diff, based on Peter's original approach
>> currently seems to work for me in the sense that I have not seen the
>> inconsistent state warning for a while now with my stress test.
>>
>> Two key points of the approach are:
>>
>> o It uses "p->migration_flags" to indicate a delayed entity has
>>     migrated to another runqueue and convey the same during psi_enqueue().
>>
>> o It adds ENQUEUE_WAKEUP flag alongside ENQUEUE_DELAYED for
>>     enqueue_task() in ttwu_runnable() since psi_enqueue() needs to know of
>>     a wakeup without migration to clear the TSK_IOWAIT flag it would have
>>     set during psi_task_switch() for blocking task and going down the
>>     stack for enqueue_task_fair(), there seem to be no other observer of
>>     the ENQUEUE_WAKEUP flag other than psi_enqueue() in the requeue path.
>>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> Tested-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> It fixes the warning and bogus pressure values after stressing it for
> an hour or so with tons of cpu contention and cgroup movements.

Thanks a ton for testing. I'll send a proper series soon for folks to
review.
-- 
Thanks and Regards,
Prateek

