Return-Path: <linux-kernel+bounces-314872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F091B96BA3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F2CB210A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AAF1D9D72;
	Wed,  4 Sep 2024 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xd1WrY4f"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5161D47D8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448705; cv=fail; b=LYSKQ98F40ExHGDzkWH4AyUpQ82W7BZPebt4wEZqilIqNwgvXLkqa2E8K5MWRKNyJPKesRSmrS2CeazNz4FX42Z6i16WtHmNB1cOOpZaweXGhsxPPHwpgBhigqDmlpjY48KAkHPEKVMNYHppPHOtXVXEkZhJMJSxKu1pHFdtMpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448705; c=relaxed/simple;
	bh=7hykKWGfzi1t3pyCYJC+q+mbR2Na7lcKefM7l1/4UGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dSc2i8JVB6h/sGrI2hLWxJWf8MeVhCQzdAu5CD87jvFxaY+btk97FwGw/6jOwwGAdyeerWXa2SEi4sZUUQbmtYYtpaeD4g4zqltY/8mL3eedvbnwjFfFQP9IuaNXJiwB61Xn4iBnB5HfYVR0+HM1PEoHb1jXtu6TZA+o5746vlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xd1WrY4f; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llUmF94jffv3Typ0GfPLIpaV8DmBlMBiUBL+p2kFFWbzSdlzhZtMUsPKpc3pe2SMcIHT82eHRDrSEBOujHs9wRXmzqXhELHiNTWM8rO+xKmJqIEhRCBrrN+uWlmPK2EmWbd2LmN5p87FkKOL5kLmTH0cP8nijhQcbOYVWi3mJkR5K4sxJSzxebmCl2tAm8yi7zHw1PqXx2rvcxuzbDoN6spEh4Ej/TLeXJANi8RwG6azYZMbRj+GIKv7g3y8EbsR5GN7Mv6Zw7mRQnOTKGvBtHs3l7IJ2WLl02lQtw4mfR9MdS8xmjfoWgZvdn/nw6Guc2Ba+4qBEHBz7hGbW0qJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy7PeCtX5IRtuVmvH9zuRWJN8//RoRAIPLmLIQ6kgnQ=;
 b=jGxJYTzuaNi2b4Nf3Q6EKirq/guT4xHsQC3kN59MQsBVJ/S1Kkh/jYR/sWocPANvS/Vg59FXzs75YrmclbfSCcMdgoUAXf8OhLih4BLwO9RG9He7FitSYLCtqK+YDAronJU8V4xZnmkUa/s+UDNaCtH6SXcjIW/QinEanb70McgCgT8BbFxMc1LMS1w3KJ1Nq0+3kqIgOCZHNdNvy7p3THOTPV4EYuxLHX9GgM7wb1yK2/deuH1oeL3WdIxW0TbpqB9afTcpIaRjo0lYWxgQi+iiIe9NBXnW/aKP2fRp365xrL+44r4D2j7bIXUiZPf6QeoPUCDxY3FE2QP63Wx3Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy7PeCtX5IRtuVmvH9zuRWJN8//RoRAIPLmLIQ6kgnQ=;
 b=xd1WrY4f/vSKQslvc8LCtg8EzlvjDSsAklmQ6xsBke/5hhNd2g9simcwWbnqH9cCgHCs4eVi7vaq0ha2u2R7OEr7l6pngv6VuDyMjGuR1PTmDyBhjrtIqDGev1qufZIXAI3dpe102pTomfNL/Ls2m6Jq82uQ05UYWLhZJqm9pdw=
Received: from BYAPR01CA0029.prod.exchangelabs.com (2603:10b6:a02:80::42) by
 CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.20; Wed, 4 Sep 2024 11:18:18 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a02:80:cafe::f5) by BYAPR01CA0029.outlook.office365.com
 (2603:10b6:a02:80::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Wed, 4 Sep 2024 11:18:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 11:18:17 +0000
Received: from [10.136.43.3] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 06:18:14 -0500
Message-ID: <62fd45f4-3324-8cdd-9ec7-bf47f95038ce@amd.com>
Date: Wed, 4 Sep 2024 16:47:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] sched/core: Introduce SM_IDLE and an idle re-entry
 fast-path in __schedule()
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>
References: <20240809092240.6921-1-kprateek.nayak@amd.com>
 <CAKfTPtAnX3a+XfeCbFzNGJKiUyA2VGYowsiofetHra=ODOsYJQ@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtAnX3a+XfeCbFzNGJKiUyA2VGYowsiofetHra=ODOsYJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: a3824eab-51c9-49d2-e351-08dcccd346d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVNOUjY2aE9rN1l5RlhXS0dCdFBSRGpHVnlNQ1dSRVNxalAxSzcxUWpITnlx?=
 =?utf-8?B?UDNMU1UvaUJkL2Y2T2VZZTN4YTdVK21aV0l1RHRsWU9ObXMra3pTZWZmYzZp?=
 =?utf-8?B?dU9SR21wUWsxRCtYNmRQNFFYU1NDa3p3WlhkSXFEQUt6VDlRNmR0K3ZZTkNE?=
 =?utf-8?B?aTE0QVB0OUN3QVVMQ1l1VS8velBidFBBeWZYY3R1S0hRckdCSkZvZE5QOTBy?=
 =?utf-8?B?VzNlR0tpT25vMXFxaG5CY0FSYnYraWp3Tmp6Y2YvK1cxYkU3bWlHL0srb0l1?=
 =?utf-8?B?aGMrS0FKYzRidFNMMTcrRFBRUEwrWktBdy9UK1I0NVBuQnpWUStwSU1kODZC?=
 =?utf-8?B?Z3BOUWFEenB2ZzF2bjZyMWZVWHpzcHFnUlZ5Q0V0K0hyWGsvand1ZjUvdEJN?=
 =?utf-8?B?VkNzYnQxZDMydjNOZGhMalQxMGgxL1FXWTVLMlp0N1h2cWZ5N3NZM1pzTU5Y?=
 =?utf-8?B?Qm5ORC8za2cyOFVKZHFSUjl3T0ZZeDBuR0FwL3N6MmZOTGpUbzFVNXJkOFBJ?=
 =?utf-8?B?OG9CRUV5cGphM1B6K3pPTjh4bExNZklRUTVpTXlNejNTZHEwaDh0cVBFRkRI?=
 =?utf-8?B?STNXU2pieE9XNGpCRWM1Sm1MVVZsRi9JWTltZFZPaHE5TEFVMHVjMjVtM1VE?=
 =?utf-8?B?a3VxZXFkTXdsSGNiRTBnUVdmZXZuWHhpZVFGbGpvQS9xSU9lbzE1Tjdvcitq?=
 =?utf-8?B?d3QwSDRsZlRwNkFyYlpSYzZZRm5zYUhDMUtTV0MwaGJYUUtuZng1NHJpaS90?=
 =?utf-8?B?dm15azJ6L214eVcyS08xWDlhanJZQWw1dFkvekd5U2dzQkZUc0tweU9oUDBk?=
 =?utf-8?B?UnlYSkREMVBzdlJwTGxzY0ZlanNpR0Y3K0RnSEZLT24xbGlrb2FIV0JpUHJM?=
 =?utf-8?B?cTBhVmg2a0tKdEtrYXZuRytHQmNRZGV6bDZPUE5mcmpzKytLdVozSTBuTVpM?=
 =?utf-8?B?Y25DYWFtNXU5VWNhNlNKdGdZTklPbWJzVkwxZXFWWUNRdlNOVHFhWVhqb1Nx?=
 =?utf-8?B?K0xMVXZyMHZzd3RkeEhaM053OEhZeUdQVmtDNUI5WGovdEoyRmRnUWYwRTNz?=
 =?utf-8?B?QWVTU0dDck9ETlcyWU9BM3RoSG1reGVYa1h5L2VFbk5jQTkraEZHWHlsVXRz?=
 =?utf-8?B?Zksrbkh6L3Z0VlBQM1dUUjJsM1JzUTVvM3dvZDZRMHZ0em45a2FaUGo3RzNi?=
 =?utf-8?B?VUFEOVVlZHNKNzRWZFBQVVc2MWpWejZ3U041MDVsYUl0Yk9uZHdwN1loeHJM?=
 =?utf-8?B?bDRuUTN3Nkd3aDFaSlJpM1g3QVNGc0U1a2F1djBSZDV4YTkrQUJySHJMaVg2?=
 =?utf-8?B?cTh2Wm9KeWYwVjZaaGREbHdwejFBKytldW5sMmlwZ1BGMDBIU3RkQUx1QmxB?=
 =?utf-8?B?VDJ1ZDRlZjlvRHhwV2NDOUFzeE0rLzRrclJRYXZEbVAxTUxWVVBORXBES0Na?=
 =?utf-8?B?SlNrSk10R1FROFpOMEZHWWpSbXBleEF0TWVodGtUUjBpTGRzRE15WUlhWVRl?=
 =?utf-8?B?SUlBRStnV3ZQb2xXM2JIdWh6UFpXbVVRTUhFdWVGQ2V6QkM0RXFVaVRDcHJt?=
 =?utf-8?B?TzQ5T2h2R0J3Uit1Tkx0REFiVFVnV204NFdHeE9uWWl2WHg5am9sck1JekZT?=
 =?utf-8?B?R0VyeGlVbHZxN3hVclozSEU2WkMzWFdWYjBiOHRsQnBKTFdVUWIvZnJNUk5D?=
 =?utf-8?B?VnZ2UEg4L1VCK3puWERrYU81QmFaeGpveGp3MExVdVkzWU1rZUdoWmNraWNV?=
 =?utf-8?B?NCtTUjB1VWVmUTQwZEd3LzFobHRaY1Z4d2xBOVFJdXhYWGZIS1V4KzY5R3RU?=
 =?utf-8?B?a2Rxb0ZEazA3VTlGSWhMV0ZaTTRrNXY3bU95SkVCNDAvNFFsQW5GZVNiendn?=
 =?utf-8?B?cXltWTJsQWtOTlhiaFcxL3hYT2hhMTdhWEhQZ2ozMjR2M1FIUS9rSFIzQ1hJ?=
 =?utf-8?B?V0o0SEhpa2VrQmIzM3hBTWltbmhIU1JFQlV6RldDc0p5empyeFFCcGdYcW80?=
 =?utf-8?B?Wkk4S3lrQVBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:18:17.6843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3824eab-51c9-49d2-e351-08dcccd346d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149

Hello Vincent,

On 9/4/2024 12:54 PM, Vincent Guittot wrote:
> On Fri, 9 Aug 2024 at 11:22, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> Since commit b2a02fc43a1f ("smp: Optimize
>> send_call_function_single_ipi()") an idle CPU in TIF_POLLING_NRFLAG mode
>> can be pulled out of idle by setting TIF_NEED_RESCHED flag to service an
>> IPI without actually sending an interrupt. Even in cases where the IPI
>> handler does not queue a task on the idle CPU, do_idle() will call
>> __schedule() since need_resched() returns true in these cases.
>>
>> Introduce and use SM_IDLE to identify call to __schedule() from
>> schedule_idle() and shorten the idle re-entry time by skipping
>> pick_next_task() when nr_running is 0 and the previous task is the idle
>> task.
>>
>> With the SM_IDLE fast-path, the time taken to complete a fixed set of
>> IPIs using ipistorm improves noticeably. Following are the numbers
>> from a dual socket Intel Ice Lake Xeon server (2 x 32C/64T) and
>> 3rd Generation AMD EPYC system (2 x 64C/128T) (boost on, C2 disabled)
>> running ipistorm between CPU8 and CPU16:
>>
>> cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1
>>
>>     ==================================================================
>>     Test          : ipistorm (modified)
>>     Units         : Normalized runtime
>>     Interpretation: Lower is better
>>     Statistic     : AMean
>>     ======================= Intel Ice Lake Xeon ======================
>>     kernel:                              time [pct imp]
>>     tip:sched/core                       1.00 [baseline]
>>     tip:sched/core + SM_IDLE             0.80 [20.51%]
>>     ==================== 3rd Generation AMD EPYC =====================
>>     kernel:                              time [pct imp]
>>     tip:sched/core                       1.00 [baseline]
>>     tip:sched/core + SM_IDLE             0.90 [10.17%]
>>     ==================================================================
>>
>>
>> [ kprateek: Commit message, SM_RTLOCK_WAIT fix ]
>>
>> Link: https://lore.kernel.org/lkml/20240615012814.GP8774@noisy.programming.kicks-ass.net/
>> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

Thank you for the ack.

> 
>> ---
>> v1..v2:
>>
>> - Fixed SM_RTLOCK_WAIT being considered as preemption for task state
>>    change on PREEMPT_RT kernels. Since (sched_mode & SM_MASK_PREEMPT) was
>>    used in a couple of places, I decided to reuse the preempt variable.
>>    (Vincent, Peter)
>>
>> - Seperated this patch from the newidle_balance() fixes series since
>>    there are PREEMPT_RT bits that requires deeper review whereas this is
>>    an independent enhancement on its own.
> 
> What is the status of the other part of v1 patchset to run idle load
> balance instead of newly idle load balance ?

Just posted the series out to LKML. You can find it here
https://lore.kernel.org/lkml/20240904111223.1035-1-kprateek.nayak@amd.com/

Sorry for the delay and thank you again for the review.

-- 
Thanks and Regards,
Prateek

> 
>>
>> [..snip..]
>>

