Return-Path: <linux-kernel+bounces-250245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AE092F5A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBC51C21DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50C13D533;
	Fri, 12 Jul 2024 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="to+5WwXn"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14324567D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720766459; cv=fail; b=P1LqIGsCX7ZVivt/qoXKnjh48tJVDtTz/LHDt0t8BhjnP9R7FEJVxnE7S3RFUR2loV2btsKqxYXBz/orYHyCwueu7IFMkRZ851Tg+k2jgVxgToAznx6GwpfGkdbBGcXBtfvE8FDiDLfyLmTRm3FZvEpcx2n1D7EBTadAAjdk59o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720766459; c=relaxed/simple;
	bh=qtNtchaSP+ij8hDE9Sc8cf99/YXDPaqsudAVn2tGbCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n7SD3mt2jQaao0oV03fDOo0b0Z+OkKnvrNRWAWtC9USxP5oGfSzxNScOHlfDvIeFwDFv30ZLlhYSuJWGoz9AUC/HIlv7UdP35KTHqvdi5PCJkt4gFgMWdNX4cZLtJx3Q/mFcWCGr5WqXoEmcErJ2WfbhtcWXMYEVAxmaHu8xS+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=to+5WwXn; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHObyKlwPuNcNkwcSERBR0VaM1QxhOihicOm0cCzJx02UFKPGFRXU+T+qSeLzTyC1D9aTPC1p8Tx3XpCJd7YYAygZGixrkfKBr+uaRR1ukiirwDBsn7mTLuyii92xcjZGUDuJrT4kUeuOs59lt0bcvBPpKrhFmL3NF14vXno3cOP+vaU93ovQcQVP/0NOnsoTZrSsnM6qDMylDjqCtMgcv0nKEGA2EdhYZhKlwJyuj7OWTImy8jucjH9fyMvPcavk+xhr7ZhFDz8+9ZeLkOCBY7A0TUIV7UzmIrwzxEyw9TsksOp1hwgBaYIAma2jJogIos0xHbhgxM8EEkNujyE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9+meeKbqcREQ+jIB/wduntdstilgdis8dsW2MOeHlQ=;
 b=m6PWyGr/9X4Lu6pR5NxAsgfMuLavBKkHvHytQ9zGY8Bi5t6ibr93d9VHlWsqNjtGB1UpBlTkYUON47H3g0ZO911LqPI7jCFjxWBKwfoQmB4sYBd/GUAEaohZDnkxTTpjmdM0PBQTiR/Ut35N7AP4Ntrzy0Gk5BpFccVGEECFHOKftSNvid3yIowb8HzytE32UB55WBlO52MrJEPAhPytHBNkWEP/VxH1DIM5g+T4I10EC1tbbEPr+y0TWanfJPbqLapFO8diPYQQFaYOY+oSQa+WPDmmOLuMgr+l7O/yh0Jnm9/r9AxchIL3vhsbK1J+NqR346P+yTp2NrN5bDCM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9+meeKbqcREQ+jIB/wduntdstilgdis8dsW2MOeHlQ=;
 b=to+5WwXnATJe+gYopdyiZBzhKr6uu9jDiNThDYcCE+LxQqeiYxda215xZLo5dZrHs9+Pn0kQsGgHIvfTpJFDNwIdNRQS2XEfHIGoJMeKgs+MQ5KpcrWXjlmEoH798siNESNk85Rko36E236acu0K6c/S0kvIy05Fe4LPyf+BrwU=
Received: from SN6PR04CA0086.namprd04.prod.outlook.com (2603:10b6:805:f2::27)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 06:40:53 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::8e) by SN6PR04CA0086.outlook.office365.com
 (2603:10b6:805:f2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Fri, 12 Jul 2024 06:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Fri, 12 Jul 2024 06:40:53 +0000
Received: from [10.136.47.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Jul
 2024 01:40:47 -0500
Message-ID: <a01aea0c-f5bd-ff19-4c90-63e94392bd6d@amd.com>
Date: Fri, 12 Jul 2024 12:10:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/3] sched/core: Introduce SM_IDLE and an idle re-entry
 fast-path in __schedule()
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Imran Khan <imran.f.khan@oracle.com>, Leonardo Bras
	<leobras@redhat.com>, Guo Ren <guoren@kernel.org>, Rik van Riel
	<riel@surriel.com>, Tejun Heo <tj@kernel.org>, Cruz Zhao
	<CruzZhao@linux.alibaba.com>, Lai Jiangshan <jiangshanlai@gmail.com>, "Joel
 Fernandes" <joel@joelfernandes.org>, Zqiang <qiang.zhang1211@gmail.com>,
	"Julia Lawall" <julia.lawall@inria.fr>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
 <20240710090210.41856-3-kprateek.nayak@amd.com>
 <CAKfTPtCNJUC-gNNPkEBRT5a2UVcPUHLdzUJ+-egZGQ5ihnU0Kw@mail.gmail.com>
 <20240711091936.GJ4587@noisy.programming.kicks-ass.net>
 <CAKfTPtCDUhqZz2Q=k--=y8o4iiSeseLXMMruhZAuEd2Bb6iEoA@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtCDUhqZz2Q=k--=y8o4iiSeseLXMMruhZAuEd2Bb6iEoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 2904468b-6d36-40e0-4a0c-08dca23d93dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHMzR0RCbXU3eVlXTk5LZ3BWc0wrdHRDVzRya2htN3dsSmsvVUJEZlpOdVZX?=
 =?utf-8?B?bnhvbC83Vk1IM0EyMTRHalRodnUwZW1jaWsyUlZFcjl4c0huU3dxZHE2TmJm?=
 =?utf-8?B?djhrTW9RejZkSEV4VzlhL284Wm0zN3lvSTNZU1MxbnYvMkFrUFJ2bVRYQzBD?=
 =?utf-8?B?QVhhVFJ6S28ycE9nY08zR2t1aFJKeklPdlJUSFVYdEJEY2FaNGVHQlh3d3I1?=
 =?utf-8?B?M2hPMUdLdHpJaG1PWVNWOFVickFycjRvTkU3aEFhZGJCZG1sLy9idi82S3U4?=
 =?utf-8?B?RTQ1TTgrMTR6emtyWWxmVFZyMU1TVWdETDR2dFdjaGlQM1V4TnR4M1AxSVR5?=
 =?utf-8?B?cGFSZUIyS0JUTTA4YlAvUWUyYSsxeXFsMGIxZm5SUmtMNjF3cVRkRzFKUkpX?=
 =?utf-8?B?N1VYTFhKdXpaYUt5T3ljdTRQV0JSL0JBM1FYUXJMZmVmTWFFQ2JCc3dTVWN0?=
 =?utf-8?B?S1krbUxWc2ZXOHZnMTVuNk9kR3lXdHArMjNHZjEyWU5ySDdITmY0S1VYVXo5?=
 =?utf-8?B?aE1zOTc1aGFzd0xvOXVFTUZmOHV3ZUVydlF6SENpNWhxUWZDVFphTjNPanVj?=
 =?utf-8?B?VEJjVXpYQ2MwRlBpNUZkV211TWthaXg3Wmk5d0RvcVNidzN6Y1lZeXFBc0tD?=
 =?utf-8?B?TFJ1Q01IMHdKUGkxUUxoeGluRWdiM0xQK25Ba3ozUkxObW1qeCttaHVoTzBx?=
 =?utf-8?B?bkR0NHJMNEtzYTZ6cUkva0dxSk5VNlpUT29mUVVqaUpxS3lUWGxhRGsyOTYr?=
 =?utf-8?B?Q2MvQlJuS2t0NUlXZUwwMFpyRDBoZjFhdmxZbWxzTVIrN2lXYmNFc3JDSVVQ?=
 =?utf-8?B?R0t6U3dGa1JHWVhRaEFQSU51aUNQQ1J2ZWpSbmw2dFV0a01xdDNjNEVJeUdS?=
 =?utf-8?B?c0puSkFVeU5ObVQwaitqM1pNa1hhRFZGamc3aWtLczl0cEs0VnZwaUVjclFr?=
 =?utf-8?B?R3dXRWlwNXpEQmIxcFVIeXBuOHZZcHZwYnc3NHJ0aHBCL3lQZ0hJWjhZTnhG?=
 =?utf-8?B?Zi9yOE9MWFhIZUdVMEZDSGJRL1d4WnlydzlqUlpHS2oxQWY1Y3pnVkJjRXdM?=
 =?utf-8?B?cnl2dW01Y3ovczJPejBraU13aHl5eTdKMHoyajdUMEdNdXN0WVRaSUNUb0NR?=
 =?utf-8?B?c2RCMnJLb0ZyS2lZQ3lnM3JLMm9JTEN6MFU3R0tkamRsZDcrMzJXN2FvUFJN?=
 =?utf-8?B?NWlaVWxyMmRWWE5OT0k5STZuaHBGNHk2Tmo2WHVFaVZCeGxRQWNxWlFwemhU?=
 =?utf-8?B?MFBLakJuUjN2ME1iV1cwMXU5dEk2ZEFlM3ZtVWpDZTJyYk9ydWphRXVLd2pO?=
 =?utf-8?B?RUVwbXVDY3VBYzd3WDVyY0djbTNwT1BpN0RSRCtudHRxbzZrc1lHa0tqbnNV?=
 =?utf-8?B?Z1lMdis3OWw0QTIzcVNZbjFXV0Q0K3pqa055MXB1R2lQcVZ4N1c4QUpVeU11?=
 =?utf-8?B?U3lhOWpLNFAvMUdGS1R1TGU2ejJYMEhmRnc2Z3kyS2x1alZ4UHFUcDJZTEtw?=
 =?utf-8?B?dmF3dXJzVm5ZbTY1b1haTCtLWVZOdWxJYkRSYk40dGh6cXJaTk9KcW1zRjZh?=
 =?utf-8?B?SHZhSXRVZHgrLzVVdlNZU1NWOTBnYTJBMDFTNk5JZjRWNzNFVTcrMkM2S2Ix?=
 =?utf-8?B?SWtEMlN0dUo0cUtxcG82OFozNzJ4TjhGVjQxdnpyY2lBbUwwVEcvS1Y3aXA1?=
 =?utf-8?B?N3p5N01uMkxSMkl2Q1I3ZDZxbmNCVVNidUpuYlZiVTkvb0FsZXBUTzJrQWtV?=
 =?utf-8?B?cHU4bXNxUWRDRGJIWExiUG9hNC9nZnhrWldZem8zMnJhWS93RlRQYTdURDg2?=
 =?utf-8?B?TGQ5WmZpQzYwOWh0TXR5QmtnS0h3RGhrY3VIaXppZjl3UkpkRlZuYkRuUVBn?=
 =?utf-8?B?N3JlY3NUbGt0QU5EbXd1b1Jpa3NtUm5aU21iaVdiVFBYdzVYTUc4aUdkRm5o?=
 =?utf-8?Q?nKRbogJqMnIwkh2VMbbyJTrCF/0W3z8w?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 06:40:53.6288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2904468b-6d36-40e0-4a0c-08dca23d93dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549

Hello Vincent, Peter,

On 7/11/2024 6:44 PM, Vincent Guittot wrote:
> On Thu, 11 Jul 2024 at 11:19, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Thu, Jul 11, 2024 at 10:00:15AM +0200, Vincent Guittot wrote:
>>> On Wed, 10 Jul 2024 at 11:03, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>> index 1e0c77eac65a..417d3ebbdf60 100644
>>>> --- a/kernel/sched/core.c
>>>> +++ b/kernel/sched/core.c
>>>> @@ -6343,19 +6343,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>>>    * Constants for the sched_mode argument of __schedule().
>>>>    *
>>>>    * The mode argument allows RT enabled kernels to differentiate a
>>>> - * preemption from blocking on an 'sleeping' spin/rwlock. Note that
>>>> - * SM_MASK_PREEMPT for !RT has all bits set, which allows the compiler to
>>>> - * optimize the AND operation out and just check for zero.
>>>> + * preemption from blocking on an 'sleeping' spin/rwlock.
>>>>    */
>>>> -#define SM_NONE                        0x0
>>>> -#define SM_PREEMPT             0x1
>>>> -#define SM_RTLOCK_WAIT         0x2
>>>> -
>>>> -#ifndef CONFIG_PREEMPT_RT
>>>> -# define SM_MASK_PREEMPT       (~0U)
>>>> -#else
>>>> -# define SM_MASK_PREEMPT       SM_PREEMPT
>>>> -#endif
>>>> +#define SM_IDLE                        (-1)
>>>> +#define SM_NONE                        0
>>>> +#define SM_PREEMPT             1
>>>> +#define SM_RTLOCK_WAIT         2
>>>>
>>>>   /*
>>>>    * __schedule() is the main scheduler function.
>>>> @@ -6396,11 +6389,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>>>    *
>>>>    * WARNING: must be called with preemption disabled!
>>>>    */
>>>> -static void __sched notrace __schedule(unsigned int sched_mode)
>>>> +static void __sched notrace __schedule(int sched_mode)
>>>>   {
>>>>          struct task_struct *prev, *next;
>>>>          unsigned long *switch_count;
>>>>          unsigned long prev_state;
>>>> +       bool preempt = sched_mode > 0;
>>>>          struct rq_flags rf;
>>>>          struct rq *rq;
>>>>          int cpu;
>>>> @@ -6409,13 +6403,13 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>>>>          rq = cpu_rq(cpu);
>>>>          prev = rq->curr;
>>>>
>>>> -       schedule_debug(prev, !!sched_mode);
>>>> +       schedule_debug(prev, preempt);
>>>>
>>>>          if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
>>>>                  hrtick_clear(rq);
>>>>
>>>>          local_irq_disable();
>>>> -       rcu_note_context_switch(!!sched_mode);
>>>> +       rcu_note_context_switch(preempt);
>>>>
>>>>          /*
>>>>           * Make sure that signal_pending_state()->signal_pending() below
>>>> @@ -6449,7 +6443,12 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>>>>           * that we form a control dependency vs deactivate_task() below.
>>>>           */
>>>>          prev_state = READ_ONCE(prev->__state);
>>>> -       if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
>>>> +       if (sched_mode == SM_IDLE) {
>>>> +               if (!rq->nr_running) {
>>>> +                       next = prev;
>>>> +                       goto picked;
>>>> +               }
>>>> +       } else if (!preempt && prev_state) {
>>>
>>> With CONFIG_PREEMPT_RT, it was only for SM_PREEMPT but not for SM_RTLOCK_WAIT
>>
>> Bah, yes. But then schedule_debug() and rcu_note_context_switch() have
>> an argument that is called 'preempt' but is set for SM_RTLOCK_WAIT.
>>
>> Now, I think the RCU think is actually correct here, it doesn't want to
>> consider SM_RTLOCK_WAIT as a voluntary schedule point, because spinlocks
>> don't either. But it is confusing as heck.
>>
>> We can either write things like:
>>
>>          } else if (sched_mode != SM_PREEMPT && prev_state) {
> 
> this would work with something like below
> 
> #ifdef CONFIG_PREEMPT_RT
>            # define SM_RTLOCK_WAIT       2
> #else
>           # define SM_RTLOCK_WAIT       SM_PREEMPT
> #endif

Since "SM_RTLOCK_WAIT" is only used by "schedule_rtlock()" which is only
defined for PREEMPT_RT kernels (from a quick grep on linux-6.10.y-rt),
it should just work (famous last words) and we can perhaps skip the else
part too?

With this patch, we need to have the following view of what "preempt"
should be for the components in __schedule() looking at "sched_mode":

		schedule_debug()/		SM_MASK_PREEMPT check/
		rcu_note_context_switch()	trace_sched_switch()
SM_IDLE			F				F
SM_NONE			F				F
SM_PREEMPT		T				T
SM_RTLOCK_WAIT *	T				F

   * SM_RTLOCK_WAIT  is only used in PREEMPT_RT

> 
>>
>> or do silly things like:

... and since we are talking about silly ideas, here is one:

(only build tested on tip:sched/core and linux-6.10.y-rt)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 417d3ebbdf60..d9273af69f9e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6345,10 +6345,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
   * The mode argument allows RT enabled kernels to differentiate a
   * preemption from blocking on an 'sleeping' spin/rwlock.
   */
-#define SM_IDLE			(-1)
-#define SM_NONE			0
-#define SM_PREEMPT		1
-#define SM_RTLOCK_WAIT		2
+#ifdef CONFIG_PREEMPT_RT
+#define SM_RTLOCK_WAIT		(-2)
+#endif
+#define SM_IDLE			0
+#define SM_NONE			1
+#define SM_PREEMPT		2
  
  /*
   * __schedule() is the main scheduler function.
@@ -6391,10 +6393,15 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
   */
  static void __sched notrace __schedule(int sched_mode)
  {
+	/*
+	 * For PREEMPT_RT kernel, SM_RTLOCK_WAIT is considered as
+	 * preemption by schedule_debug() and
+	 * rcu_note_context_switch().
+	 */
+	bool preempt = (unsigned int) sched_mode > SM_NONE;
  	struct task_struct *prev, *next;
  	unsigned long *switch_count;
  	unsigned long prev_state;
-	bool preempt = sched_mode > 0;
  	struct rq_flags rf;
  	struct rq *rq;
  	int cpu;
@@ -6438,6 +6445,14 @@ static void __sched notrace __schedule(int sched_mode)
  
  	switch_count = &prev->nivcsw;
  
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * PREEMPT_RT kernel do not consider SM_RTLOCK_WAIT as
+	 * preemption when looking at prev->state.
+	 */
+	preempt = sched_mode > SM_NONE;
+#endif
+
  	/*
  	 * We must load prev->state once (task_struct::state is volatile), such
  	 * that we form a control dependency vs deactivate_task() below.
--

>>
>> #define SM_IDLE (-16)
>>
>> keep the SM_MASK_PREEMPT trickery and do:
>>
>>          } else if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
>>
>> Not sure that is actually going to matter at this point though.

-- 
Thanks and Regards,
Prateek

