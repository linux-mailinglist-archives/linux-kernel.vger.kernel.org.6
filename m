Return-Path: <linux-kernel+bounces-407054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E729C67EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629D7B242BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F8E16EBE6;
	Wed, 13 Nov 2024 03:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SGIHKmNG"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CF83D97A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731470301; cv=fail; b=C52cSwPnQosMTjPOc8Od2mHbye3G4HFUv1nKDi3JjsEmR5YoN6S+SzdQSRGHtoeIgMA4tZZvzIXbxsXbK7ZDQUTJ9uWj6/KSyB5xNiaR26bdobsun+azyEY+lPpYGygV6ajs78Fg66hJjhfiG5/AUTNYFlupHWCg0Luu9BROcjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731470301; c=relaxed/simple;
	bh=OldyZ3zQGCC7b/pZX3Vt8uyne5EbnKwx4JzpuBCv5iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VSATB/seMftKpe+F0CrDHnTJQEYJzc/eN3Jy8N+izmfpC4DgS4BJMeJvzcXNU7Jr8ijplCWfxm+YIK7kck2YzNhIRuSieGH8HDdyeVnk7wN4pnq+DrxpxMSCg2D5uZvKBjngUfVWcck/HM9aAXUmIoixKAGSUBorGJeJG8U4ro4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SGIHKmNG; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6Adl7riiVZ/wbkKCxrZR8wud2j6KFwzlmgvV5WxLhksXm3Z2cA1HGmyS5eMsgHcyNhnbCskyWbXJNcGkzNaBzdxTFhsPDtDm1uNnPqbTcy2acPFCoKEAiLrdCzxy82lNQ1qviTpInnZUMHF4+6fF4M29KX57r3NkLl6JLi5V1ezYK/xpY3BuUgs/IiDQdB3EwwPvQeMlqrOTlGvrJxuRNNBUe5E36EwD4y3G9jAps8+FzABKoAyPknhJsPmIdgdHBi5SiKFCvnVEIzwMejCBKMwLBZDoF5Lw9HmM18UcM8Ia8u6JSXkHy0f9/UC+ay8Cg/EtQ64E+lP6p7Y2x180Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ5Sj55OPTWI0fUe2m2B7HBO2V743jDujDLRTnL7VlQ=;
 b=whS7YFlq3uPn9YXosMwk3i6atxiuwjaklx+aGN6+aBJ4gvM3CMpi2mbLeW1pcl2uRbWckFkFgXZpKUYSVdRXAE2VazWJfdmGCTQwwhhWEuf+gpVIn2AJmevu0yu3khia1Cei/p/9hCgGET/njXJkZoQP5kWSHBVey4dErXQH+vFotkplHp4cFi8dbv0Z+B1tEAlig7ghMyHe03jN6sw4Mp11QXFN54VzuBm4BH5nQK0ii4Sp+vJgrwGrbIA6Up/2bJsLuXiOsGJ4KbEMnQz1jlGu3q6rZM3k68vIvNJrzexh69AyYWryXD38egbS5acWL4Bju2XWL5EJWELywmXi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ5Sj55OPTWI0fUe2m2B7HBO2V743jDujDLRTnL7VlQ=;
 b=SGIHKmNGkpgtfE9LrflTwPQilba6J0EKsfIGUMj/JBUyB5gORSIDfV4hA1+YF8aNEsRUF4We+BqYJkptJAvM9hvAm3zrW3/O66d3gFy1O0u/2NOqEKC1dZvtKDrLtxJiaLHVjYp8egXVZlzJgcZQBnasQU1j/Z5eMn0QNdRTaV4=
Received: from CH2PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:52::17)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 03:58:17 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::e7) by CH2PR04CA0007.outlook.office365.com
 (2603:10b6:610:52::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 03:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 03:58:17 +0000
Received: from [10.136.47.222] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 21:58:14 -0600
Message-ID: <2d059175-cfc0-fee2-5bc1-fb750aa5acf9@amd.com>
Date: Wed, 13 Nov 2024 09:27:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 2/4] Scheduler time extention
Content-Language: en-US
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
	<linux-kernel@vger.kernel.org>
CC: <rostedt@goodmis.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<daniel.m.jordan@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113000126.967713-3-prakash.sangappa@oracle.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241113000126.967713-3-prakash.sangappa@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 8878aa0a-ea6b-4c9c-21be-08dd039767cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDlPekp6dVh0WHFlMUxTLzU0b3dDcHp3eGxRcXMxVUFaTUJTcmNBbzBqa0lO?=
 =?utf-8?B?V3JZS20wRk0xbEk4dmtGaC90NGxWWVhqRlpWRHdzQWh2bkp2Z2VtR2hsZEZj?=
 =?utf-8?B?NVpzNm5FbkV2ZDV1bXdRbzJTcmcxSWl1YnF0VldaSFp3Y0twSGl5eGNrQVdz?=
 =?utf-8?B?c2I2dXJqQWtMU0tKdXVpd2JPQmZWUFh4ZW5uYWpYRitLaEcvRWR6RVlUaEx0?=
 =?utf-8?B?YlRpdmwvaXpkVWVtR0pJM09kM1Z5M1RodnVoREN6a3lscXgrTzE2b2NFRWV0?=
 =?utf-8?B?MlpJalcyU2VRVUN2cHBudVo5V080dTV1akpnRTRQY2hwbk1LcjRrN2NCWjJL?=
 =?utf-8?B?V0hvR1kvVU5iaFZ1aGRMN0hIajl0NHdwV1JWaUFraC8waHRrMmFoQTdJMmR3?=
 =?utf-8?B?WGNUaTlkOWFNd3ZXaG1GbzhTNkRqVjZnOVM1WjJlci9NRjVHK2ZYUmZ3YTdN?=
 =?utf-8?B?NjdPOXFGbXhmam5adWg5YmRVb09CWGx1R0NVeDMrUzYyUHZ3Y0JRK2x1ekxE?=
 =?utf-8?B?M1QzVzRsMit3WWw4eDc3NFdHbW5Za1Zhc0lKVXRWS3V0T3NEUGlOYzNBNjJD?=
 =?utf-8?B?aHE0TjFrZG5ZeUlEVWNGYzVPWk1HeHhiaWFQNy80RHlaK3NPOHhGOWo5b3JT?=
 =?utf-8?B?QVRtcHJYVmFmUDIwQldiTXNDbUJET3FJNnVneThQREYxdjhqV2xJL0Y2Z2lr?=
 =?utf-8?B?K1c5QzV0YjVuTXNGTmxISXdLKy95ZE5WZEw0UEt0d2tZbGZWRVM2OGE1Qmdt?=
 =?utf-8?B?ZU56S2cyajZDenZNL1hwdTBNSnFReENGOGpBUVZWLzgrV3l4ZVd0T1AwTHNY?=
 =?utf-8?B?SjJsTW0vOE9KWldmSEs1Nlo3Wll2THE3bVBNelhCZ0xPckk0VHJXWXhLQ0h0?=
 =?utf-8?B?a214SnYwSUdwa1JWcUlSajdERFhvUEptcTRmUjB4bmpKcnlWZExuZC9LMit0?=
 =?utf-8?B?MW8xYXBjcWxzNUVoMldRTjd5N1BqN29qSlFGYlJWQ1JYNy85enhhV0d3ZjJl?=
 =?utf-8?B?amt4T1ZmaWFucStnVzg5RHFBQWo1b1JyVkhhMGpMRWFTOWxEOVN3RG40TDZ5?=
 =?utf-8?B?emdGcWpjakxHYUZTYjNkVjJwV0VxWHBZdktSYTZaUHZveWJ5WjF6V2lkWFNv?=
 =?utf-8?B?VEsyTWM5R3lHYzVESmRnYm1qdEtMYXZpWlVUTllBRWNpdVloRDdVMUlTdEdD?=
 =?utf-8?B?WnVUcXBvSnB3Qno5bm9XbmY0T2Y4dnl5Ykx6bXNOc2d3YVovcXlTS0pENFNx?=
 =?utf-8?B?VTA2R0NYZEpzb0ovanVpNFg1MzJmOGVQUzVyM0xJTEJYVUwyNHlFd2wwdlJJ?=
 =?utf-8?B?T2RCNkZ1cXBUYmJxT0tKTVFNR1gxZmY4dFFsRmJUWXFPYTJZOTEyMkYvcXZa?=
 =?utf-8?B?VEg1Qjh4ams0YkxuelExYU5lcFExWWN6S21DNks0UFFlOXF6NGtUQzQxUGVs?=
 =?utf-8?B?MUFlRjArTTNrQXdQM0NtSG01UTRzcDdNalZGbTl4ZUd4UENrUGxJSDFXUnI4?=
 =?utf-8?B?VnNia3l0bVBzd1Z6ekpVZEtpOW1XQzkxbytQdG13eUZiZzVjYzM0TldlQ3JB?=
 =?utf-8?B?OTEvNmM5cDFFZ1NzdnhnNCs3amtPYzFtMThuUUdEVlV5b0QveFZzbVRmRjZ1?=
 =?utf-8?B?WWhYQlNNVkhMbStrdTRaR2FtM3hJeHMxN0hTQTJMaHEydDQzaUIzbzE2TDl1?=
 =?utf-8?B?NEVNWk1Wc3ZLTS8wZGc2dEtSUjJBUkNJY0Foc2RTcmVJVjdYcnc0S0VzWm9m?=
 =?utf-8?B?R2tkbWJmRFRSd01PK0xkeTZJc0RDZ0ZMcU1BZUxPdld1SVNZT3lCcEN0T1lY?=
 =?utf-8?B?Tnl1ZkJkRWhqZWVGOEkxQkZWZ0JkWmlmdHdJT0xhL21xRkplY0dGU0ZtdUhG?=
 =?utf-8?B?MUhCYUY2Z0l1YkhobEJ3RXMyZ25Ga0ZmZFA4Snp1MUVYeXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 03:58:17.0551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8878aa0a-ea6b-4c9c-21be-08dd039767cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465

Hello Prakash,

Full disclaimer: I haven't looked closely at the complete series but ...

On 11/13/2024 5:31 AM, Prakash Sangappa wrote:
> [..snip..]
> @@ -99,8 +100,12 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>   
>   		local_irq_enable_exit_to_user(ti_work);
>   
> -		if (ti_work & _TIF_NEED_RESCHED)
> -			schedule();
> +		if (ti_work & _TIF_NEED_RESCHED) {
> +			if (irq && taskshrd_delay_resched())
> +				clear_tsk_need_resched(current);

Suppose the current task had requested for a delayed resched but an RT
task's wakeup sets the TIF_NEED_RESCHED flag via an IPI, doesn't this
clear the flag indiscriminately and allow the task to run for an
extended amount of time? Am I missing something?

> +			else
> +				schedule();
> +		}
>   
>   		if (ti_work & _TIF_UPROBE)
>   			uprobe_notify_resume(regs);
> @@ -208,7 +213,7 @@ static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *reg
>   {
>   	syscall_exit_to_user_mode_prepare(regs);
>   	local_irq_disable_exit_to_user();
> -	exit_to_user_mode_prepare(regs);
> +	exit_to_user_mode_prepare(regs, false);
>   }
>   
>   void syscall_exit_to_user_mode_work(struct pt_regs *regs)
> @@ -232,7 +237,7 @@ noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
>   noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
>   {
>   	instrumentation_begin();
> -	exit_to_user_mode_prepare(regs);
> +	exit_to_user_mode_prepare(regs, true);
>   	instrumentation_end();
>   	exit_to_user_mode();
>   }
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 71b6396db118..713c43491403 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -815,6 +815,7 @@ void update_rq_clock(struct rq *rq)
>   
>   static void hrtick_clear(struct rq *rq)
>   {
> +	taskshrd_delay_resched_tick();
>   	if (hrtimer_active(&rq->hrtick_timer))
>   		hrtimer_cancel(&rq->hrtick_timer);
>   }
> @@ -830,6 +831,8 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
>   
>   	WARN_ON_ONCE(cpu_of(rq) != smp_processor_id());
>   
> +	taskshrd_delay_resched_tick();
> +
>   	rq_lock(rq, &rf);
>   	update_rq_clock(rq);
>   	rq->curr->sched_class->task_tick(rq, rq->curr, 1);
> @@ -903,6 +906,16 @@ void hrtick_start(struct rq *rq, u64 delay)
>   
>   #endif /* CONFIG_SMP */
>   
> +void hrtick_local_start(u64 delay)
> +{
> +	struct rq *rq = this_rq();
> +	struct rq_flags rf;
> +
> +	rq_lock(rq, &rf);

You can use guard(rq_lock)(rq) and avoid declaring rf.

> +	hrtick_start(rq, delay);
> +	rq_unlock(rq, &rf);
> +}
> +
>   static void hrtick_rq_init(struct rq *rq)
>   {
>   #ifdef CONFIG_SMP
> @@ -6645,6 +6658,9 @@ static void __sched notrace __schedule(int sched_mode)
>   picked:
>   	clear_tsk_need_resched(prev);
>   	clear_preempt_need_resched();
> +#ifdef CONFIG_TASKSHARED
> +	prev->taskshrd_sched_delay = 0;
> +#endif
>   #ifdef CONFIG_SCHED_DEBUG
>   	rq->last_seen_need_resched_ns = 0;
>   #endif
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index d23c34b8b3eb..0904667924d8 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -1419,6 +1419,13 @@ static void do_sched_yield(void)
>    */
>   SYSCALL_DEFINE0(sched_yield)
>   {
> +
> +#ifdef  CONFIG_TASKSHARED
> +	if (current->taskshrd_sched_delay) {
> +		schedule();
> +		return 0;
> +	}
> +#endif
>   	do_sched_yield();
>   	return 0;
>   }
> diff --git a/mm/task_shared.c b/mm/task_shared.c
> index cea45d913b91..575b335d6879 100644
> --- a/mm/task_shared.c
> +++ b/mm/task_shared.c
> @@ -268,6 +268,56 @@ static int task_ushared_alloc(void)
>   	return ret;
>   }
>   
> +bool taskshrd_delay_resched(void)
> +{
> +	struct task_struct *t = current;
> +	struct task_ushrd_struct *shrdp = t->task_ushrd;
> +
> +	if (!IS_ENABLED(CONFIG_SCHED_HRTICK))
> +		return false;
> +
> +	if(shrdp == NULL || shrdp->kaddr == NULL)
> +		return false;
> +
> +	if (t->taskshrd_sched_delay)
> +		return false;
> +
> +	if (!(shrdp->kaddr->ts.sched_delay))
> +		return false;
> +
> +	shrdp->kaddr->ts.sched_delay = 0;
> +	t->taskshrd_sched_delay = 1;
> +
> +	return true;

Perhaps this needs to also check
"rq->nr_running == rq->cfs.h_nr_running" since I believe it only makes
sense for fair tasks to request that extra slice?

-- 
Thanks and Regards,
Prateek

> +}
> +
> +void taskshrd_delay_resched_fini(void)
> +{
> +#ifdef CONFIG_SCHED_HRTICK
> +	struct task_struct *t = current;
> +	/*
> +	* IRQs off, guaranteed to return to userspace, start timer on this CPU
> +	* to limit the resched-overdraft.
> +	*
> +	* If your critical section is longer than 50 us you get to keep the
> +	* pieces.
> +	*/
> +	if (t->taskshrd_sched_delay)
> +		hrtick_local_start(50 * NSEC_PER_USEC);
> +#endif
> +}
> +
> +void taskshrd_delay_resched_tick(void)
> +{
> +#ifdef CONFIG_SCHED_HRTICK
> +	struct task_struct *t = current;
> +
> +	if (t->taskshrd_sched_delay) {
> +		set_tsk_need_resched(t);
> +	}
> +#endif
> +}
> +
>   
>   /*
>    * Get Task Shared structure, allocate if needed and return mapped user address.


