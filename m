Return-Path: <linux-kernel+bounces-350798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD479909D2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D24B220AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7861CACDB;
	Fri,  4 Oct 2024 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kFDIw/JJ"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBED1E378C
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061285; cv=fail; b=mtBVuA6EHJ0JIFUakpWPnYy8RF+lN0sMCA9fwUutlCmJmog5A8NkTerLkP60P+Z5o4mRJ8jQ4BPHhE8kwlpVj5X5wHcpRw9N1UIwgTMSpMsa0/gn+u7z3z+OeXEM8TBvH3li+sHX4n4oIYXtw1zphP4X4hsBM06aN0p5MlSbwLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061285; c=relaxed/simple;
	bh=Nwd1DJY1QUVDBdPlTKQSkgt/mCJsnZVNdQueCdvvGTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bpkzI9UXMDhUxw4WhGMINEbC8NFvjIuu5NCzQjzNeaewyehuEMHsS6FSBSPV9T1dAWwcQ754+hvxkY5+ShIfVXFbr+mCFeUg1R+aZvPSaj8evx0h7SlVlW0zvk0eGOOIGieZDu3JnXl5exsFw1eAbg2maJJQXoy0bzwe+5ien5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kFDIw/JJ; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHsMQuYavON5LxDZQ2s194PEiWaKog2ab18EBDJvnM/S+f5xRAFA5OVGQGDeJr5Cn5bZRpmMfioN4INX1FAymO1/seVy9ZaCiS1mG47AS6Gs/X6gSSt1S1YgSdl2nprs3utb/4bq4umdayencXcN7xxiO55ZVtbnJsqo77lOhvyruM2QyQjtZTwZBCsrMvuED5O06onbpm5ybgTN8Pjs7rLklhPLb5V1RFCpk9xxPwpexqOX3Gi/zbsNEuO5+7Z8IzIAtTph5y3FIYdDTjvTvwLNGg1Sjskj2iVgu8KGN6Zwn6SomWaj3QGwC4K5mCsqpZX87SQkc6pSHhrQquxD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+21m2uOkyuCSjcfXNYpn0zFm55hiKCtMyDASqZfxXbE=;
 b=U+U4P27uXIx+6W88Z5P/3P+s3gmfMEJTtUieo94fsBJaIiFN6rMK7KXqmxCsh5QvNom6sW30mw6oe0FuEeuvyZUvG86PEW8iXQfj+xvvFsna3zBzltoQYzDZoTCt6C/68xN1r4b6QLywHyk3FIB4YUi0zikCXFExCzfRKHgZjnd3Xd/aElmwuQsiGbikhRRqlr8g2hhR9hobH8h282Mz7cDBocnKyN60ksmA3y4CSFvuQgBVYgJTaBg6tfHVBEO2SM2imbpsIygLiwlVzqrasMkPzop1C+urMI+rFKMRUtjmf509gr3GVbnhV3CrazDBKQ3a4NRRfYk2NQPQHph6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+21m2uOkyuCSjcfXNYpn0zFm55hiKCtMyDASqZfxXbE=;
 b=kFDIw/JJfqxvcEEOUatCYzY95yyfDPGUL6xn3wOxLJXhTcype8YqOS4OXLK3IRgH0b2XUv+FFmktfjrtqiSP9A5vFEODX16bfdsDRkv0qsvxf9rqwuvkJY/J9ti99bo8vJHQIwffxWW/JscwynJ9fbs7t3m5EWvnQerAV+jwmrs=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Fri, 4 Oct
 2024 17:01:19 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::28) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 17:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 17:01:18 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 12:01:11 -0500
Message-ID: <8ae45988-9c5b-8a68-b351-5e1d41da59e6@amd.com>
Date: Fri, 4 Oct 2024 22:31:08 +0530
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
To: Peter Zijlstra <peterz@infradead.org>
CC: Klaus Kudielka <klaus.kudielka@gmail.com>, Chris Bainbridge
	<chris.bainbridge@gmail.com>, <linux-kernel@vger.kernel.org>,
	<bsegall@google.com>, <dietmar.eggemann@arm.com>, <efault@gmx.de>,
	<juri.lelli@redhat.com>, <mgorman@suse.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <tglx@linutronix.de>, <vincent.guittot@linaro.org>,
	<vschneid@redhat.com>, <wuyun.abel@bytedance.com>,
	<youssefesmat@chromium.org>, <spasswolf@web.de>,
	<regressions@lists.linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, "Linux
 regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <20240830123458.3557-1-spasswolf@web.de>
 <ZvA7n9GNoD-ipjkj@debian.local>
 <1ee5f5828e2021bf1051dc1f9b6f01a8c061ffb1.camel@gmail.com>
 <2128d714-90f7-1598-b32b-559206fce5de@amd.com>
 <20241004123506.GR18071@noisy.programming.kicks-ass.net>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241004123506.GR18071@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d70d56-6e7c-47d9-dd70-08dce4962a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cE1VOUdCak9YOXBCUmRZQVA0N1F6MTBHTDFDdUIzbFVwajdUSDZHL1BxWm5J?=
 =?utf-8?B?Ri83RzBCMDVZNnNJdHBLWXFydEprblJvZWV4V200SlRORFRGaHlnZ2VZcWlZ?=
 =?utf-8?B?endFSGR6Ri96MVhock03eU5ObmZndy9UcWhOVFBDSUcyRlNUVFAxYWRROFRt?=
 =?utf-8?B?U1VvWUZISTlENTdKSFhQSzNPMEdPbk1IRnBKRGhnUXFTZ2M5Qk4wbWtZaFFx?=
 =?utf-8?B?MmJibEQ2djkrUElKRjAwUGl5bWNwUG9RWis5UWFIeFduS3dJZW1sZlM5OTly?=
 =?utf-8?B?WTBqc0lSbjVhbUkzNExNaHhjTFdUK2V1MlRDVTM4NkY5T0V2VzJ3NE1oQnI2?=
 =?utf-8?B?M3ZWckhQWHR0MXlGL0hBS0xDcU5BZWJGdnRRSFRmMG1oS3MrQS9ONTlzckNH?=
 =?utf-8?B?NkJia1RMNHgwZGdsM0hmdHRmM3ltU052TGI5dlBoU1FkS3ZNckRwQmdsRHdN?=
 =?utf-8?B?K1Z4elljZ2JpR082QXBGQ0dOUjlNTktqQUErK2FRc29hSjlvWXZsY2VWK3J4?=
 =?utf-8?B?Mk1ZZE9SZWhQNU43RHpTVFNOQ1BTSXo3N1dQL3FVNGc0QldrOTNXQWtWcmhZ?=
 =?utf-8?B?amxqNGh3czVwRkhNS1h0UUJSRmpnUzRUbUlNMnhjSmNrdmdIUTFQU1dxRnRN?=
 =?utf-8?B?cG1sSUpzTWJuS0JsWEo4K0VaTGY0amZ5cXhENVJxeFljbmRPZ3Z0bnJrUVBH?=
 =?utf-8?B?TEU1VHk2cGw4Tkw3UUZoN3dDSE03cmtydmJZV0x5Q2ticmF0aEVMczlneUFq?=
 =?utf-8?B?cnNQbk9iNWpIWHpFeWdVbmNpc2lPWm55OFEyRlBwSWo1YmpPZjhPUlJtWmVl?=
 =?utf-8?B?Mlp2V2tLa0xvMzZ2WjRSWHFRRklzSkxETnVHRVVBdUU0WmNXWUpKeGJZM200?=
 =?utf-8?B?MDllZ0JHRDBhdVVqZXcxN1FVSE5yMDYvc0c3NmU5NGFIdnc4VWJaeW9nanh6?=
 =?utf-8?B?UzFQZlFQR2twMmUzMFVTWCs1VTVzYzlGZ3JUaktXMndxS2pXb1hkMkc3YUxG?=
 =?utf-8?B?dThDMTZjM2dzaUpGbU4vWlZwYjRBRkRtdC9XWmNMZERwQ0ptdzRNcDBnOTVy?=
 =?utf-8?B?ME5kQzgzVjhjNm1FYStBSHdqcW43UmlJOWxhdjd1YVViaVVhaU5rYTAxeGk0?=
 =?utf-8?B?ZjFnaHNTRTdNblVmd3ZtUnU5RDIyUHNNSlFqQ3BJSm9CQXBmVUZkUTgyWjRP?=
 =?utf-8?B?NEY0Y0tYenhlRWxyZzVyb2ZzTlRicWdhU3Z6RHdFVUFyLzVBVmx6TnpsQXlV?=
 =?utf-8?B?cHdVa3pCVXl2bUQ2b1E3NldNNWZQbEMvWlJYcld6RzBXUmtWNXEvNWRFK2sv?=
 =?utf-8?B?VGNJTWhVS3pWYVhBZXd6a084VEJWNlF6bmNJeExzU25SSTIvVFlVL2dwZGNP?=
 =?utf-8?B?UjVwT2lNMmxHanpicGZueCt0WlFETkRPcEw0c0ZRNDJrbWJVS3VZQ0lrMkN0?=
 =?utf-8?B?b0FoUGhCK0JWTzJBWUN3dDEyTzVBWVFla1k5a3RDYWl0Z1Q2MHZVR2JBZ21x?=
 =?utf-8?B?U0RzWWI5MHROYTJKbWFVYXkrRUwxMmdQSzFhcjFmRlJLaTVEVnRySy8wTVI2?=
 =?utf-8?B?ZG82azQwSzJoRHRUSTJybktaOTV3cmFOL2ExY291OFErWGgwSVRDSkhVdStL?=
 =?utf-8?B?OWgyaUVidW9HbDZNb0h5dWs0Nmw5THo3cnpSR0E5TmN0OVp4MVh1aFVGQnYy?=
 =?utf-8?B?S3hORHIvTVcyak5xMzk4UjI3eS8wcFpSNzdvckwrTzE0cWZmb0Q4SzlJUW5j?=
 =?utf-8?Q?D6NnjhxWydKI1XLul5TFocxdQDEg+QxPXAvpOSc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 17:01:18.2238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d70d56-6e7c-47d9-dd70-08dce4962a4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921

Hello Peter,

On 10/4/2024 6:05 PM, Peter Zijlstra wrote:
> On Fri, Oct 04, 2024 at 04:40:08PM +0530, K Prateek Nayak wrote:
>> Hello folks,
>>
>> On 10/3/2024 11:01 AM, Klaus Kudielka wrote:
>>> On Sun, 2024-09-22 at 16:45 +0100, Chris Bainbridge wrote:
>>>> On Fri, Aug 30, 2024 at 02:34:56PM +0200, Bert Karwatzki wrote:
>>>>> Since linux next-20240820 the following messages appears when booting:
>>>>>
>>>>> [    T1] smp: Bringing up secondary CPUs ...
>>>>> [    T1] smpboot: x86: Booting SMP configuration:
>>>>> [    T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  #1
>>>>> This is the line I'm concerend about:
>>>>> [    T1] psi: inconsistent task state! task=61:cpuhp/3 cpu=0 psi_flags=4 clear=0 set=4
>>>>> [    T1]   #3  #5  #7  #9 #11 #13 #15
>>>>> [    T1] Spectre V2 : Update user space SMT mitigation: STIBP always-on
>>>>> [    T1] smp: Brought up 1 node, 16 CPUs
>>>>> [    T1] smpboot: Total of 16 processors activated (102216.16 BogoMIPS)
>>>>>
>>>>> I bisected this to commit 152e11f6df29 ("sched/fair: Implement delayed dequeue").
>>>>> Is this normal or is this something I should worry about?
>>>>>
>>>>> Bert Karwatzki
>>>>
>>>> I am also getting a similar error on boot, and bisected it to the same commit:
>>>>
>>>> [    0.342931] psi: inconsistent task state! task=15:rcu_tasks_trace cpu=0 psi_flags=4 clear=0 set=4
>>>>
>>>> #regzbot introduced: 152e11f6df293e816a6a37c69757033cdc72667d
>>>
>>> Just another data point, while booting 6.12-rc1 on a Turris Omnia:
>>>
>>> [    0.000000] Linux version 6.12.0-rc1 (XXX) (arm-linux-gnueabihf-gcc (Debian 14.2.0-1) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP Thu Oct  3 06:59:25 CEST 2024
>>> [    0.000000] CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7), cr=10c5387d
>>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
>>> [    0.000000] OF: fdt: Machine model: Turris Omnia
>>> ...
>>> [    0.000867] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>>> [    0.000876] psi: inconsistent task state! task=2:kthreadd cpu=0 psi_flags=4 clear=0 set=4
>>>
>>
>> Not sure if someone took a stab at this but I haven't seen the "psi:
> 
> I'm aware of the issue, but since it's just statistics and not
> anything 'important', I've been spending my time on those crashing bugs.
> 
>> inconsistent task state" warning with the below diff. I'm not sure if my
>> approach is right which if why I'm pasting the diff before sending out
>> an official series. Any comments or testing is greatly appreciated.
>>
>> The diff is based on:
>>
>>      git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
>>
>> at commit d4ac164bde7a ("sched/eevdf: Fix wakeup-preempt by checking
>> cfs_rq->nr_running")
> 
> Thanks, I just pushed all that out to tip/sched/urgent.
> 
>> My approach was as follows:
>>
>> o psi_dequeue() relied on psi_sched_switch() to set the PSI flags
>>    appropriately for a dequeued task. However, psi_sched_switch() used
>>    "!task_on_rq_queued(prev)" to judge if the prev task is blocked which
>>    is now untrue with DELAYED_DEQUEUE. Fix it by checking
>>    "p->se.sched_delayed" as well. I also added a matching check for
>>    ENQUEUE_DELAYED for psi_enqueue().
> 
> We already determine the whole sleep state earlier, the whole having
> called block_task() is a clue, perhaps we should propagate that state
> instead of trying to divinate it again.

Yup that makes sense!

> 
>> o With the above, the warning was put off for a few more seconds but it
>>    still appeared. I dumped all PSI flag transition along with
>>    "tsk->se.sched_delayed" to see what trips it and I saw the following
>>    state changes for the task that finally tripped it:
>>
>>      psi: task state: task=18:rcu_preempt cpu=0 psi_flags=0 clear=0 set=0 delayed=1
>>      psi: task state: task=18:rcu_preempt cpu=128 psi_flags=0 clear=0 set=4 delayed=1
>>      psi: task state: task=18:rcu_preempt cpu=128 psi_flags=4 clear=0 set=4 delayed=0
>>      psi: inconsistent task state! task=18:rcu_preempt cpu=128 psi_flags=4 clear=0 set=4 delayed=0
>>
>>    Note that cpu switched with "tsk->se.sched_delayed" still set which
>>    got me looking at the task migration path. The warning added below
>>    in "deactivate_task()" tripped without fail, just before the PSI
>>    warning was logged.
>>
>>    To prevent migration of a delayed entity (XXX: Is it a good idea?)
> 
> It is not. By migrating the entities they can get picked sooner and the
> delayed thing gets removed sooner. Less 'hidden' weight.

True that! I was thinking moving queued load could also potentially help
delayed entities being picked faster on the rq where they were delayed.
Both seem to help in one way or the other but I don't have any solid
data to conclusively say which might be better.

> 
>>    we do a "account_task_dequeue()" in the delayed dequeue case to
>>    remove the task from the "rq->cfs_list", thus removing it from the
>>    purview of the load balancer.
> 
> Anyway, assuming PSI wants to preserve current semantics, does something
> like the below work?

I've updated the details from my testing on the parallel thread by
Johannes.

tl;dr I still see PSI warnings, some more tinkering on top of your
changes altered the warning to "psi: task underflow!". So far, no
luck figuring out how that comes about.

Thank you for taking a look and for the quick patch!

-- 
Thanks and Regards,
Prateek

> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 43e453ab7e20..0d766fb9fbc4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2012,7 +2012,7 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>   	if (!(flags & ENQUEUE_NOCLOCK))
>   		update_rq_clock(rq);
>   
> -	if (!(flags & ENQUEUE_RESTORE)) {
> +	if (!(flags & ENQUEUE_RESTORE) && !p->se.sched_delayed) {
>   		sched_info_enqueue(rq, p);
>   		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
>   	}
> @@ -2039,7 +2039,7 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>   	if (!(flags & DEQUEUE_NOCLOCK))
>   		update_rq_clock(rq);
>   
> -	if (!(flags & DEQUEUE_SAVE)) {
> +	if (!(flags & DEQUEUE_SAVE) && !p->se.sched_delayed) {
>   		sched_info_dequeue(rq, p);
>   		psi_dequeue(p, flags & DEQUEUE_SLEEP);
>   	}
> @@ -6537,6 +6537,7 @@ static void __sched notrace __schedule(int sched_mode)
>   	 * as a preemption by schedule_debug() and RCU.
>   	 */
>   	bool preempt = sched_mode > SM_NONE;
> +	bool block = false;
>   	unsigned long *switch_count;
>   	unsigned long prev_state;
>   	struct rq_flags rf;
> @@ -6622,6 +6623,7 @@ static void __sched notrace __schedule(int sched_mode)
>   			 * After this, schedule() must not care about p->state any more.
>   			 */
>   			block_task(rq, prev, flags);
> +			block = true;
>   		}
>   		switch_count = &prev->nvcsw;
>   	}
> @@ -6667,7 +6669,7 @@ static void __sched notrace __schedule(int sched_mode)
>   
>   		migrate_disable_switch(rq, prev);
>   		psi_account_irqtime(rq, prev, next);
> -		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
> +		psi_sched_switch(prev, next, block);
>   
>   		trace_sched_switch(preempt, prev, next, prev_state);
>   


