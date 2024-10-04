Return-Path: <linux-kernel+bounces-350234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5AB9901D9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA7B1C231F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1A14B94C;
	Fri,  4 Oct 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qtInA/xp"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF74157472
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040223; cv=fail; b=KIJIRwzCBsQ/3D1YmcRSqaxZUp8WXNkRN5jfU1xgxqhFMZ5uNK8yNXzVtimVZ+eHC8pYEYP9gL0aIlR/PY0OMxQYQ0fL6liLPHfUjJUVHesSJWEXBvRWMG1uz8eZHPJjnACk85XUZ00MzlR0E9eP3IzVCsRXimc2Bqh6nrwSl7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040223; c=relaxed/simple;
	bh=kKvKE6iHeIeRGCCXHxa/0tm9gPFx4Khv9mY46bzLi1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e4IUhLZJt1dEwtmCOXxATU5fvYmPYyzBo2mepSl9afMKLX+8fgo+GqQDMsZPDHtDq2CkygU/EAgr7cUxGgXgktKhS9Vr/uezV9rMv72//eWrSzeYmvW3BCsSn39PKROiWFWl+rGm4oaRssmCtTF6YlRtE74PWe00MeYG09ZoMoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qtInA/xp; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW54YnhlxgbK232mbfhnZqGJTUOSZqGTJl3uKTobuXOBXo+1FVnIh9EMmaxkA1HTeInAId/+/z9KbGudHZarEE8EE/uVqywpl6JvQWUB/K/xlTuFJPZ5abroHKsfWQ22I5ZdjSn2IZ7iZRGxRikLYqssy1zFUdLW2Jb/A7+E8fv81861b8PHE7H+md42u3SqnabeBYyz10UvLI537qaBhAZrK7w9GhScYXhnCavDPDVdCtGrvzm5QQs+O4nYaKMqSY77CH2RF7iW3phm55MgOylmu+6uO9luEcTXkxF3Uge3QHbwPqXf2kavGABXNyjk7cltXi/xw3s+zKdaVBm//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj5ZtUl5XwHOF9YK1mLPf0V6p7zE3G9jTt4YGLFI3HE=;
 b=TAnMHzbwIvIDubMn0/xvrpybyYzLiPw51eGWSrDvzFPkJ5b5LpQ27ess9JN3YCgV017+YToV31kidVjm8jQjjev4JaD/XbCVVoZxgIe/8sjmxuMjQnZwY6RyIbcXxcIlFagNL336WSte9yW2oGs1MEnZdrKzxJsiQWuMTFHzYzKvAorTyOMFqG5Bn6CJSwkfAqNIyvF35fIipUmBUbuoO9HizEpbh2gPlLTxsQ7MRL27t6rGTQntabv52muPvf89JUdxujdRNSqNtr8GSBt/4K2FWWobG945WtuswBU227EI+3hrRHTsOPSv8sgrFWZ0le0sdk7yYb9Bf/vjV6cfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj5ZtUl5XwHOF9YK1mLPf0V6p7zE3G9jTt4YGLFI3HE=;
 b=qtInA/xpA5gzYynsZcH0+eVLBmqEV+BmuBdy0CTDMl0hqcQ4FsX2DTV2j12RB+ngcm2M5h68oqc7jQut3L33D6ISi7Gdi98PpMlC3wo4RJfW06X+gvMD9QlcArmRPhUKwwltQRzrzVa/8w1T2yOw0QWKpmGA7LxPL6xyjHse4i4=
Received: from CH2PR18CA0032.namprd18.prod.outlook.com (2603:10b6:610:55::12)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 11:10:16 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::62) by CH2PR18CA0032.outlook.office365.com
 (2603:10b6:610:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 11:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 11:10:16 +0000
Received: from [10.136.45.74] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 06:10:10 -0500
Message-ID: <2128d714-90f7-1598-b32b-559206fce5de@amd.com>
Date: Fri, 4 Oct 2024 16:40:08 +0530
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
To: Klaus Kudielka <klaus.kudielka@gmail.com>, Chris Bainbridge
	<chris.bainbridge@gmail.com>, Peter Zijlstra <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <bsegall@google.com>,
	<dietmar.eggemann@arm.com>, <efault@gmx.de>, <juri.lelli@redhat.com>,
	<mgorman@suse.de>, <mingo@redhat.com>, <rostedt@goodmis.org>,
	<tglx@linutronix.de>, <vincent.guittot@linaro.org>, <vschneid@redhat.com>,
	<wuyun.abel@bytedance.com>, <youssefesmat@chromium.org>, <spasswolf@web.de>,
	<regressions@lists.linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, "Linux
 regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <20240830123458.3557-1-spasswolf@web.de>
 <ZvA7n9GNoD-ipjkj@debian.local>
 <1ee5f5828e2021bf1051dc1f9b6f01a8c061ffb1.camel@gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <1ee5f5828e2021bf1051dc1f9b6f01a8c061ffb1.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef43952-1d7f-4e33-75da-08dce465201f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDVTMEJXTGl5VE1DcCtObko5andLMkNrSGpLUG9OanQvWFkyYkl1V2dCOGI5?=
 =?utf-8?B?ZTBCZE4wMmk5M3VuQUhnbFRyb1d2cEJaQm13eHFQNFFQUkJOR3ZoK0l4d1cz?=
 =?utf-8?B?cXBLczRXMllmdGkzVHJLOFl3eVlqYmRQZ2lPaFVLK2w5SGR3aXRYSWJPc0ph?=
 =?utf-8?B?aHFNTWN0bUgxZExYRENJZEtoN1A1Sk4xMEF3SHZkczJoRGJzWTFsQVNOMC9y?=
 =?utf-8?B?Vml1Z25Hdy9QVFNCUWpwYzR4bVk5QlMrQTFZSXk3b0FyTG9TQkJPS2o2Misz?=
 =?utf-8?B?OFdsRzdOY255NFNHVnRzYTlKZVdFOFpLQVI3UFMyR0tYSUZPaHorMWhWTFVQ?=
 =?utf-8?B?SUVlUDR3eVZiZlIrMnUvVXpzSGNNa09ZZGxBcjRCTHQreStRNkVxekJzRHdB?=
 =?utf-8?B?cm45dkdlclR1L0tKbndzUGRDZENhMWp1dXZtOXAzMExQdXBCbkJMR1dRN1Fn?=
 =?utf-8?B?SGpZRDJ1dExQbHpVVzY4QTZFSEFBOEhCSWxBR2tEVk1RNkRGMkdOR3VhK2Ri?=
 =?utf-8?B?WTlocGNTY05SQ0pQdTdodnd0aEgweEJBOERkYlFEb0JiK1NlSC9LWGFoZ0Z6?=
 =?utf-8?B?amtKMGdSOUxyUnNtaDU1U2h5ZWdMcFVHNCswZ3hGT0xoZTFDWGZsZk9VTmxJ?=
 =?utf-8?B?NUM5UllpaFdXZDVQQUFMLzBzVDFMcTYxQWNxaGI3L0FuajRBcUxSdU41bHdY?=
 =?utf-8?B?L3VGMTRFMG5Tc0RtVDJzVmZuazdUTnpDQk01SWJ6My84L1NwK0V6U3ZEOEpY?=
 =?utf-8?B?dUFObkpJUFBPQk5TakNWNWtNNHJXRFNSQlpnaXY2Y2VZUTZJN2RhMkZTWG1n?=
 =?utf-8?B?eUhsQ25QVmI4dWJwUlVtY0FDcjJJWGxNWWZOQVRCV1Z4VGhSb1lTaTZEdmZu?=
 =?utf-8?B?SE5CQ0I5Vjh5cnFNSHgveDF5N2RScVFtM0ZYV081UTZsNEVPY0JGbTVnNWJS?=
 =?utf-8?B?NVlhaWU2aDFmb08zWHFiWnhHYU9aVERtMjhTRTBOeHlaeHdEY2hrbUptOE5j?=
 =?utf-8?B?SERhYzdiRzA1TlpNUFl6d0Y0VnUwSEV4SVJKZ1loekNZTmN4UU5oeEp2cFR5?=
 =?utf-8?B?ZkVmUFJzSkRZUjA2WTRPc1hwdDJHU2tpd05udm94SzYwQXFvWTRxd1JoM2hn?=
 =?utf-8?B?RnpxVWpBOHd3Wko2Ri9DOTU1NHpNTG10eTlwQzVpUUNlNlByK3F5YlkyU2Vx?=
 =?utf-8?B?dVZCOTA3Ym02blp4eldJZ1hCdy9DQ3VnQytweGx3MFUyYVdJejZXaDZMejA2?=
 =?utf-8?B?anllcktzN1lSMTFYOE5mUkhLNUZWRk5qK0NhSEtYRVljUzdMRjR4N29OdGxr?=
 =?utf-8?B?QlNjMFgyMnRndm5PMVVDWmhjamF3WFQwVjlHVlNsSTRQQ3dIL2lVNFdMdU5o?=
 =?utf-8?B?dTF1bk5uV1M1QTRrQ2VXZGpmYnUyK20waEpyOU84NXg5OEVDTEkvd1RPc2c3?=
 =?utf-8?B?SmRLaGZSSWF6MXpUUkx6Sk80ZFRWWGQzUThlT2tvVXZNMjAzeTk3RHpMdnpT?=
 =?utf-8?B?N1JaRU52MkVWWUllMGtWQWNlVGtSSCtCWFZ6L0dGeUhkMTR0Q1llZ0ViUlgy?=
 =?utf-8?B?cjg3NGg3RDcyUlpsOVdoY1BkbmhLTnBXNDU3L2lmc1JUdEZta1hJZFExcVBU?=
 =?utf-8?B?dDRnVlA5aTlqTlJvVnl3SEpCQldpSmtnZjRUcENwZ1h1RU8zMTE4Z1dBT3Yz?=
 =?utf-8?B?OGV6a2RVajdFd0JYNkIzWFQwaGM2dWJtVWdTTXkvY0YyQmNSQzJCdUJMY1pI?=
 =?utf-8?Q?K3ju2VfJGFapf3864faGggE3s5Y30cDqh3+R4OB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 11:10:16.0592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef43952-1d7f-4e33-75da-08dce465201f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785

Hello folks,

On 10/3/2024 11:01 AM, Klaus Kudielka wrote:
> On Sun, 2024-09-22 at 16:45 +0100, Chris Bainbridge wrote:
>> On Fri, Aug 30, 2024 at 02:34:56PM +0200, Bert Karwatzki wrote:
>>> Since linux next-20240820 the following messages appears when booting:
>>>
>>> [    T1] smp: Bringing up secondary CPUs ...
>>> [    T1] smpboot: x86: Booting SMP configuration:
>>> [    T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  #1
>>> This is the line I'm concerend about:
>>> [    T1] psi: inconsistent task state! task=61:cpuhp/3 cpu=0 psi_flags=4 clear=0 set=4
>>> [    T1]   #3  #5  #7  #9 #11 #13 #15
>>> [    T1] Spectre V2 : Update user space SMT mitigation: STIBP always-on
>>> [    T1] smp: Brought up 1 node, 16 CPUs
>>> [    T1] smpboot: Total of 16 processors activated (102216.16 BogoMIPS)
>>>
>>> I bisected this to commit 152e11f6df29 ("sched/fair: Implement delayed dequeue").
>>> Is this normal or is this something I should worry about?
>>>
>>> Bert Karwatzki
>>
>> I am also getting a similar error on boot, and bisected it to the same commit:
>>
>> [    0.342931] psi: inconsistent task state! task=15:rcu_tasks_trace cpu=0 psi_flags=4 clear=0 set=4
>>
>> #regzbot introduced: 152e11f6df293e816a6a37c69757033cdc72667d
> 
> Just another data point, while booting 6.12-rc1 on a Turris Omnia:
> 
> [    0.000000] Linux version 6.12.0-rc1 (XXX) (arm-linux-gnueabihf-gcc (Debian 14.2.0-1) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP Thu Oct  3 06:59:25 CEST 2024
> [    0.000000] CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt: Machine model: Turris Omnia
> ...
> [    0.000867] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
> [    0.000876] psi: inconsistent task state! task=2:kthreadd cpu=0 psi_flags=4 clear=0 set=4
> 

Not sure if someone took a stab at this but I haven't seen the "psi:
inconsistent task state" warning with the below diff. I'm not sure if my
approach is right which if why I'm pasting the diff before sending out
an official series. Any comments or testing is greatly appreciated.

The diff is based on:

     git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent

at commit d4ac164bde7a ("sched/eevdf: Fix wakeup-preempt by checking
cfs_rq->nr_running")

My approach was as follows:

o psi_dequeue() relied on psi_sched_switch() to set the PSI flags
   appropriately for a dequeued task. However, psi_sched_switch() used
   "!task_on_rq_queued(prev)" to judge if the prev task is blocked which
   is now untrue with DELAYED_DEQUEUE. Fix it by checking
   "p->se.sched_delayed" as well. I also added a matching check for
   ENQUEUE_DELAYED for psi_enqueue().

o With the above, the warning was put off for a few more seconds but it
   still appeared. I dumped all PSI flag transition along with
   "tsk->se.sched_delayed" to see what trips it and I saw the following
   state changes for the task that finally tripped it:

     psi: task state: task=18:rcu_preempt cpu=0 psi_flags=0 clear=0 set=0 delayed=1
     psi: task state: task=18:rcu_preempt cpu=128 psi_flags=0 clear=0 set=4 delayed=1
     psi: task state: task=18:rcu_preempt cpu=128 psi_flags=4 clear=0 set=4 delayed=0
     psi: inconsistent task state! task=18:rcu_preempt cpu=128 psi_flags=4 clear=0 set=4 delayed=0

   Note that cpu switched with "tsk->se.sched_delayed" still set which
   got me looking at the task migration path. The warning added below
   in "deactivate_task()" tripped without fail, just before the PSI
   warning was logged.

   To prevent migration of a delayed entity (XXX: Is it a good idea?)
   we do a "account_task_dequeue()" in the delayed dequeue case to
   remove the task from the "rq->cfs_list", thus removing it from the
   purview of the load balancer.

o With the above change, I only managed to trip the deactivate_task()
   WARN_ON() and immediately the PSI warning in the NUMA balancing path

     ------------[ cut here ]------------
     p->se.sched_delayed
     WARNING: CPU: 75 PID: 473 at kernel/sched/core.c:2075 deactivate_task+0xa6/0xc0
     Modules linked in: ...
     CPU: 75 UID: 0 PID: 473 Comm: migration/75 Not tainted 6.12.0-rc1-peterz-sched-urgent-psi-fix+ #32
     Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
     Stopper: multi_cpu_stop+0x0/0x110 <- migrate_swap+0xd7/0x150
     RIP: 0010:deactivate_task+0xa6/0xc0
     Code: ...
     RSP: 0018:ffff9f210e12fdc0 EFLAGS: 00010086
     RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
     RDX: ffff90116ffa18c8 RSI: 0000000000000001 RDI: ffff90116ffa18c0
     RBP: ffff8fd2d8559ac0 R08: 0000000000000003 R09: 0000000000000000
     R10: 64656863732e6573 R11: 646579616c65645f R12: ffff90116ffb6500
     R13: ffff90116ffb6500 R14: 0000000000000004 R15: ffff8fd2f28f433c
     FS:  0000000000000000(0000) GS:ffff90116ff80000(0000) knlGS:0000000000000000
     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     CR2: 000055748a34e000 CR3: 000000807974e004 CR4: 0000000000f70ef0
     PKRU: 55555554
     Call Trace:
      <TASK>
      ? __warn+0x88/0x130
      ? deactivate_task+0xa6/0xc0
      ? report_bug+0x18e/0x1a0
      ? prb_read_valid+0x1b/0x30
      ? handle_bug+0x5b/0xa0
      ? exc_invalid_op+0x18/0x70
      ? asm_exc_invalid_op+0x1a/0x20
      ? deactivate_task+0xa6/0xc0
      __migrate_swap_task.part.0+0xbe/0x180
      migrate_swap_stop+0x1b6/0x1f0
      multi_cpu_stop+0x6e/0x110
      ? __pfx_multi_cpu_stop+0x10/0x10
      cpu_stopper_thread+0x97/0x160
      ? __pfx_smpboot_thread_fn+0x10/0x10
      smpboot_thread_fn+0xdd/0x1d0
      kthread+0xd3/0x100
      ? __pfx_kthread+0x10/0x10
      ret_from_fork+0x34/0x50
      ? __pfx_kthread+0x10/0x10
      ret_from_fork_asm+0x1a/0x30
      </TASK>
     ---[ end trace 0000000000000000 ]---

   From some logging, I can say the "dst_task" is the one that is
   delayed but I could not go up the stack to find out how it is
   chosen for the swap. For this RFC, I just block the delayed
   entity in "__migrate_swap_task()" and set the "p->wake_cpu"
   to redirect the next wakeup to the appropriate NUMA node.

I haven't encountered any warnings with my machine going for a while now
but I haven't tested any fancy cgroups scenarios yet either; Mileage may
vary :)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..b55b52b081ba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2014,7 +2014,9 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
  
  	if (!(flags & ENQUEUE_RESTORE)) {
  		sched_info_enqueue(rq, p);
-		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
+		/* Delayed tasks are considered dequeued by PSI tracking */
+		psi_enqueue(p, ((flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)) ||
+			       (flags & ENQUEUE_DELAYED));
  	}
  
  	p->sched_class->enqueue_task(rq, p, flags);
@@ -2069,6 +2071,9 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
  {
  	SCHED_WARN_ON(flags & DEQUEUE_SLEEP);
  
+	/* Delayed tasks should not be migrated */
+	SCHED_WARN_ON(p->se.sched_delayed);
+
  	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
  	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
  
@@ -3298,9 +3303,21 @@ static void __migrate_swap_task(struct task_struct *p, int cpu)
  		struct rq_flags srf, drf;
  
  		src_rq = task_rq(p);
-		dst_rq = cpu_rq(cpu);
-
  		rq_pin_lock(src_rq, &srf);
+
+		if (p->se.sched_delayed) {
+			block_task(src_rq, p, DEQUEUE_DELAYED);
+			rq_unpin_lock(src_rq, &srf);
+
+			/*
+			 * Make it appear we last ran on the preferred
+			 * node. See the comment below.
+			 */
+			p->wake_cpu = cpu;
+			return;
+		}
+
+		dst_rq = cpu_rq(cpu);
  		rq_pin_lock(dst_rq, &drf);
  
  		deactivate_task(src_rq, p, 0);
@@ -6667,7 +6684,14 @@ static void __sched notrace __schedule(int sched_mode)
  
  		migrate_disable_switch(rq, prev);
  		psi_account_irqtime(rq, prev, next);
-		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
+
+		/*
+		 * psi_task_switch() is responsible for clearing TSK_RUNNING
+		 * and TSK_IOWAIT which psi_dequeue() skips for a task going
+		 * to sleep (see comment there). Consider a delayed entity
+		 * as one that has gone to sleep for PSI accounting.
+		 */
+		psi_sched_switch(prev, next, !task_on_rq_queued(prev) || prev->se.sched_delayed);
  
  		trace_sched_switch(preempt, prev, next, prev_state);
  
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ab497fafa7be..cf02d202ab0c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3661,18 +3661,40 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
  
  #endif /* CONFIG_NUMA_BALANCING */
  
+#ifdef CONFIG_SMP
+
+static void
+account_task_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	struct rq *rq = rq_of(cfs_rq);
+
+	account_numa_enqueue(rq, task_of(se));
+	list_add(&se->group_node, &rq->cfs_tasks);
+}
+
+static void
+account_task_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	account_numa_dequeue(rq_of(cfs_rq), task_of(se));
+	list_del_init(&se->group_node);
+}
+
+#else
+
+static void
+account_task_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
+static void
+account_task_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
+
+#endif
+
  static void
  account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
  {
  	update_load_add(&cfs_rq->load, se->load.weight);
-#ifdef CONFIG_SMP
-	if (entity_is_task(se)) {
-		struct rq *rq = rq_of(cfs_rq);
+	if (entity_is_task(se) && !se->sched_delayed)
+		account_task_enqueue(cfs_rq, se);
  
-		account_numa_enqueue(rq, task_of(se));
-		list_add(&se->group_node, &rq->cfs_tasks);
-	}
-#endif
  	cfs_rq->nr_running++;
  	if (se_is_idle(se))
  		cfs_rq->idle_nr_running++;
@@ -3682,12 +3704,11 @@ static void
  account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
  {
  	update_load_sub(&cfs_rq->load, se->load.weight);
-#ifdef CONFIG_SMP
-	if (entity_is_task(se)) {
-		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
-		list_del_init(&se->group_node);
-	}
-#endif
+
+	/* Delayed tasks are already dequeued the first time */
+	if (entity_is_task(se) && !se->sched_delayed)
+		account_task_dequeue(cfs_rq, se);
+
  	cfs_rq->nr_running--;
  	if (se_is_idle(se))
  		cfs_rq->idle_nr_running--;
@@ -6943,6 +6964,10 @@ requeue_delayed_entity(struct sched_entity *se)
  
  	update_load_avg(cfs_rq, se, 0);
  	se->sched_delayed = 0;
+
+	if (entity_is_task(se))
+		account_task_enqueue(cfs_rq, se);
+
  }
  
  /*
@@ -7190,10 +7215,18 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
   */
  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
  {
-	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
+	struct sched_entity *se = &p->se;
+
+	if (!(se->sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
  		util_est_dequeue(&rq->cfs, p);
  
-	if (dequeue_entities(rq, &p->se, flags) < 0) {
+	if (dequeue_entities(rq, se, flags) < 0) {
+		/*
+		 * Remove delayed entity from rq->cfs_tasks list
+		 * to prevent load balancer from migrating it
+		 * away.
+		 */
+		account_task_dequeue(cfs_rq_of(se), se);
  		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
  		return false;
  	}
--

The above changes were arrived at by experimenting. If there are no
obvious objections, I'll send a clean series after some more testing.
Any and all comments are highly appreciated.
-- 
Thanks and Regards,
Prateek

