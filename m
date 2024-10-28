Return-Path: <linux-kernel+bounces-384067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2A29B23D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 05:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDC81F21E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 04:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C054B17BB03;
	Mon, 28 Oct 2024 04:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="COFIysTN"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE6A59
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730089444; cv=fail; b=r0csKGMw93pYibtdMAYX9kkoh4kPEFxKGN3LfySZNDpRIY8SnfJbJYEuqHQXO8Psi1jL0C/Pwz50jrZ3ZH77bDa2nUiz42YsR6KBH6hc+K0jOxV6Xiffc7sxMRKM6JQTi128u24w7DFIfwXyKwovG6XdkwECFSiJiZZRaaTMJjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730089444; c=relaxed/simple;
	bh=DoyWCYjjPSSljq7Wa2i4hYtyzb2KHIj3IQfoqactlIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DTr2UjXmxrpkJt9NTFw06eXQaGElsAuKtsVHITjyqoqsyo80EMtwkmyykmEHC+lBcDYLsIttNf66KQwxxUMa6jSZos9yeVJJdB0f7Sj01+szcd3/760/4EWOFR1xyTesm0Mx2qOt+zIyBI+wi9zAeShOdqq+5eQ9W0koAOjbDQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=COFIysTN; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KR5PynkS+62Tqq75vIetvXJz5o+2djngbr1JpnW5UDQCstt27TD3HaurXkrCicDswd6LeZMDs0BjysMrUvKe8ijahdSGoPKfZ+W2zeFtGmaXk22eTsHlm7/DOePaSDhY4p9UqXAVowhnIVoFMxKWjU36UkqLBZF7J/Q/Z/8njFtwK9qmJ5uNwmYgN2eHtVlf6Drq7InD4QIsRu2+0ymSUHXokyREipHnEzWsJfXftiKco6t7vzy7vXVRTFwbXY7Qym5v79khXsbeNkKs2R/ZRCrjQy9l7n3SfFij9HsjGe3YZYCkjYHI+tRBJ1MpGGzNV00ihMik1CSY8+oTbt++Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JhhiVyxlBfgXciVGEuWgT/dhP7m1x/AqShQ9wMkRLc=;
 b=Q2kccXAMC75necBGjjLr5FSj8FDrycn28JSpo9M4TVDEDEpyR+qo2qLW5lWJJb5HBUoMjJlo3q93zDYRgTrDnq97y8ip7JGSyFXQl3Uj8Uygcvu7fvtmlWZDJqzARO/Vv/aj17Eihm3kPI+Qq0WVMFzo8nzXRypqhDOOUb/JiBWlA1nlpeeL5kYQHWZZ+X0N8EvBqC9fTJvh5e4EhxPJK12H1DF/AXVZvv/wb8SbWfQsOPxsVv/2PyAf1JBqTFJu8YUUrNeazWe1lQ1dneahRX4H1r2sz6giNl+FXxUBJec4p0yGvD9G/ilfkPH0uUHNaOsYCRvjNxCooRRi1GSwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JhhiVyxlBfgXciVGEuWgT/dhP7m1x/AqShQ9wMkRLc=;
 b=COFIysTN0s9uzAFWaK9+hhOJttGQCI5SUht9ofEUMfcbCri2EL6g8inh+t1QC4OaXu1qLjqCOGVeqsnz49ypNFXEgBgDXeC2lJqEBy1UAQIARzKlLtFtBpKpBI66fnS1AZMGb2PB0Mg3dwhFm1mSq6NG5/lGVkktdmfZEPdlahc=
Received: from BN8PR12CA0010.namprd12.prod.outlook.com (2603:10b6:408:60::23)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 04:23:59 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::e6) by BN8PR12CA0010.outlook.office365.com
 (2603:10b6:408:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 04:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 04:23:58 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 27 Oct
 2024 23:23:52 -0500
Message-ID: <957632fc-4ac9-76d8-cdee-dbf02c98ef31@amd.com>
Date: Mon, 28 Oct 2024 09:53:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 5/5] softirq: Avoid unnecessary wakeup of ksoftirqd
 when a call to do_sofirq() is pending
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Rik van Riel <riel@surriel.com>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, Leonardo Bras <leobras@redhat.com>,
	Thorsten Blum <thorsten.blum@toblux.com>, Zqiang <qiang.zhang1211@gmail.com>,
	Tejun Heo <tj@kernel.org>, NeilBrown <neilb@suse.de>, Caleb Sander Mateos
	<csander@purestorage.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>
References: <20241014090339.2478-1-kprateek.nayak@amd.com>
 <20241014090339.2478-6-kprateek.nayak@amd.com>
 <20241025170326.ChR4tfjG@linutronix.de>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241025170326.ChR4tfjG@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DM6PR12MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: f78ce0c6-60e8-470c-36d2-08dcf7085827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anQwUHZwclhsejd6OGZhN2lhSjk3WHZ5R0xURXh4TE96dGlDZ1hMK1pQSUNX?=
 =?utf-8?B?MEJoYlhpdXlTeDZSTFFVQm5vQ0Zqbkc1UjcvbjFvdW44dThLS3d6S0ZaUlFS?=
 =?utf-8?B?WTdrcGlMWWhlaXF1VFA3WkJsQWI1a2h2S1pTQVJXTlpJS3U2YlNvdGpqL3ZM?=
 =?utf-8?B?U1lpeVorTklhMnRQMlRrTTNvdWpBQVdTd3d1RVZzNXd6dG55ODR4T0pnTkFT?=
 =?utf-8?B?aXVQZGFGRVhVWTN5WmpkTEplMEwvYUljaVhVTVcydWQwbXJKUUxHa1F5YWw2?=
 =?utf-8?B?Z2FKdWt4Z0xaM0dpWTlwSzdxQThYcTJmL2NSWUNNZDl5akVHMHRBS3V0Y1Ra?=
 =?utf-8?B?RGFYZW54RFN1KzJvaEIyNmtXbmhGdDNuSm5EM1JrTUZrd0RmK3Fvdm05Vytp?=
 =?utf-8?B?VE01S3REQzE5dHlDYm92eUt4ZG5HRXNHTG1ZaFIrN0NwUjh6aFNlLzhRMEVn?=
 =?utf-8?B?Q3VUTHcyZWFEd1pNb3hTTVFyU29TdWJMbGV0Mm9PS1NvbUlRNXRvTnZDVzJG?=
 =?utf-8?B?c1NOM0RrT3grc0o4TWlIV2ZXN0pia09Yem45eGoxSnRDQTIwMDA0eUM2KzZF?=
 =?utf-8?B?YSs5UWtxS3FSOXlUK3NpWlVFcER4K3NYNXd0bUNMbmZyMzNWVUNoQXI0Y3hj?=
 =?utf-8?B?aFFwb1EwenFHWkRBRiszRFZRS2FxWVFzOEJtNU1IZlpweVM3cHVWdTZRSEw0?=
 =?utf-8?B?MmEzNVdrMEFqVGNHcFhyY2RiSDdZOXJOd3g3NEV5Z1ZBM3VDMEt1ZU9iaS9Q?=
 =?utf-8?B?OVl5T0VBZzJOOE0ycFZYUmFCbm4zOU5tWEh1ZDFYVUp5NjB5OVpiQVhVQm1E?=
 =?utf-8?B?MlJyaldqdWptT0JFVVB1RFBEVDdSVTh1ZWViNTQvNytHWDZaZElWWWxiWXFZ?=
 =?utf-8?B?b3YrdVlvZk5MZVliUVhmcGdqcUhiRW5XN0h0TTNKb1k2amhGTDBpM0o3L2Zn?=
 =?utf-8?B?Z0duUmg3Rnp4dU1zZ2R5aGZnWHQyeXlOeHU2eEQ1MDBQbkZnb0wvK0FHWWMy?=
 =?utf-8?B?ZHFZQ1Rtc25HbWpJMHVIS1RBVDhHYitUU3poNUVOQ3VybVRhREJLV2hHbmNo?=
 =?utf-8?B?elBnQ3d1c2pGWHpzOW1ncVBlUm5HUDZWM0RDZVR3VjFBSFFLVm1FRVFlRUNl?=
 =?utf-8?B?TFBiZXVUWjV0RGRNcCs2REZvWjZheW10cGZvSkVMd0V6ODdETnBKU2NCN3Rx?=
 =?utf-8?B?SHBmbEJZSmpZTG9PZzZzOXNvYlIyTDcrNFBUZmJaVVZ1N2R2M3FwSlVGOGxO?=
 =?utf-8?B?MlpmbU5ZeURHUTlDVzRnNG01Qm9oMW1Cek85M0ZFTmhjd1NjTXF0K2FZeTJN?=
 =?utf-8?B?aGNhNFd2bkdPZVdQY056UDBMQlB3bGd5Rm01c3FYNDZlRUE0VVhxcnlsdFV3?=
 =?utf-8?B?bFM0RlRvNWFPSnBuY3U1L3BPNXBhb2J2a29YYXdudHJ2RE1VdkpFZ3R2SmV2?=
 =?utf-8?B?Y1VIS2FwVXVpU2ladUhuNUtCbDJFb3J6RDZZb2VUNU84bDl4Z0E2OHFtYXBL?=
 =?utf-8?B?Q1Fsa3JPM01xOGc1MHRHTUEwLzNFTDgrOWh1TXV3RGxnUzVGbXE5ZFRHbUFk?=
 =?utf-8?B?NEswUTRBU05RMjYxRGhmandmWTBnQmV6MU50TzZHcFFvU082R21PVXZyQUFr?=
 =?utf-8?B?NmVnc1M1VStTeDcyckJFa1NMb0Qza3AzV1VxZlJENUhCUjM4MVNmTmxpcWZ6?=
 =?utf-8?B?b1ZIKy9rR0JXQVRkUDI4Z2NNZjd0ZmpLTU01R1VjY2tOeUgrSHZvWmNzUE9v?=
 =?utf-8?B?RU0xVTE1YWQ0UlVEV3JJdDg4bEdycmJmVGRIR01CVi8wUXZlQmtzVjVtV3NH?=
 =?utf-8?B?V3NVOFJidHptVmh3NXRsSVRYZ1BreFBsdlBQTFBXNlVaQ0J2YzBXbGZtYjQ2?=
 =?utf-8?B?RmFxdDhqNXB4azBYOE16NmMxQTZOZ0U2aE5BdjB6YU9GelE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 04:23:58.9750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78ce0c6-60e8-470c-36d2-08dcf7085827
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138

Hello Sebastian,

Thank you for reviewing the series!

On 10/25/2024 10:33 PM, Sebastian Andrzej Siewior wrote:
> On 2024-10-14 09:03:39 [+0000], K Prateek Nayak wrote:
>> Since commit b2a02fc43a1f4 ("smp: Optimize
>> send_call_function_single_ipi()"), sending an actual interrupt to an
>> idle CPU in TIF_POLLING_NRFLAG mode can be avoided by queuing the SMP
>> call function on the call function queue of the CPU and setting the
>> TIF_NEED_RESCHED bit in idle task's thread info. The call function is
>> handled in the idle exit path when do_idle() calls
>> flush_smp_call_function_queue().
>>
>> However, since flush_smp_call_function_queue() is executed in idle
>> thread's context, in_interrupt() check within a call function will
>> return false. raise_softirq() uses this check to decide whether to wake
>> ksoftirqd, since, a softirq raised from an interrupt context will be
>> handled at irq exit. In all other cases, raise_softirq() wakes up
>> ksoftirqd to handle the softirq on !PREEMPT_RT kernel.
> 
> Stupid question. You talk about the invocation from nohz_csd_func(),
> right?.
> Given that this is an IPI and always invoked from an IRQ then the
> softirq is invoked on IRQ-exit.

Yes, there is no issues in that case.

> If it is flushed from
> flush_smp_call_function_queue() then the softirq is handled via
> do_softirq_post_smp_call_flush(). In that case couldn't you just tell
> nohz_csd_func() to use __raise_softirq_irqoff(SCHED_SOFTIRQ) ? This
> should solve this, right?

I cannot think of any reason why it wouldn't work. Let me check real
quick and update the series if it works. Thanks a ton for the
suggestion!

> 
>> diff --git a/kernel/softirq.c b/kernel/softirq.c
>> index 0730c2b43ae4..3a6b3e67ea24 100644
>> --- a/kernel/softirq.c
>> +++ b/kernel/softirq.c
>> @@ -99,6 +99,10 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
>>    *
>>    * The per CPU counter prevents pointless wakeups of ksoftirqd in case that
>>    * the task which is in a softirq disabled section is preempted or blocks.
>> + *
>> + * The bottom bits of softirq_ctrl::cnt is used to indicate an impending call
>> + * to do_softirq() to prevent pointless wakeups of ksoftirqd since the CPU
>> + * promises to handle softirqs soon.
>>    */
> 
> The comment that you are extending and the comment regarding
> SOFTIRQ_OFFSET were nearby. I don't like that those two are now far
> apart.

Noted. If the above suggestion doesn't work, I'll rearrange this bit and
refresh the series.

> 
>>   struct softirq_ctrl {
>>   	local_lock_t	lock;
>> @@ -109,6 +113,16 @@ static DEFINE_PER_CPU_ALIGNED(struct softirq_ctrl, softirq_ctrl) = {
>>   	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
>>   };
>>   
>> +inline void set_do_softirq_pending(void)
>> +{
>> +	__this_cpu_inc(softirq_ctrl.cnt);
>> +}
>> +
>> +inline void clr_do_softirq_pending(void)
> 
> there should be no inline here.

Ack. Will fix in the subsequent version if the alternate approach
doesn't work.

> 
>> +{
>> +	__this_cpu_dec(softirq_ctrl.cnt);
>> +}
>> +
>>   static inline bool should_wake_ksoftirqd(void)
>>   {
>>   	return !this_cpu_read(softirq_ctrl.cnt);
> 
> Sebastian

-- 
Thanks and Regards,
Prateek

