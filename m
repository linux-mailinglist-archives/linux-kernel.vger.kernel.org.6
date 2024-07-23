Return-Path: <linux-kernel+bounces-259658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59490939AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA27D1F22894
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9646513D24E;
	Tue, 23 Jul 2024 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1f+w3Auv"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3868514BF87
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717190; cv=fail; b=bxBrHXlOFmjiIGalBCBnJAslfPiiZON5vcNUl9B9Kf6kwM/xP4SzjOn9/R5rAgcD38PhRx8NoDUBL1uDxFNhhPbLI5re/wEEcbuv1hT5RHpuLKT7pLJLpSYwNYoq3HJZPRP9Ek933dKQ7MfcCmTelWXcHJSN3n5+QeOCsyNi8Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717190; c=relaxed/simple;
	bh=AQeR9W91NyG2HAUXcoMfgS35CdL17J/nlOq3/2pVsE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j1Mzjjc/AjNfkHmdt6miLt1x5gMSnUoc9TBSKCz1brL/30fooc4AgPntENrdpWqPHqRr14GuLMhjS2MlGLoeQYt3wmNtDuf8GCSKR6LUisH0vLNuNWcKl8x31wa+fPEHrDzVIRzGN4Fe2cwTpFbdSqztgdKV2JjhazJNC2bvKAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1f+w3Auv; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBNWSsl/KoV3ABkoCudWA5OhCvtIEV7l/atoI8ef2pYomVwd21pvUNRpCPFYggPGtIlWFdRPyswYddj36PoD5SEkUMGfs5ypL+PZ+DWaf6UFzYbAioeotoX4inqa+/iMYHynUVAv02Yf/AGHpaVBcx0phHHCSjFm175xfRjjdBvT2OQAP3Sy8ahYBDE/EglJyPDh+/FrYqkkfnb4nUsBHrE4wDDcsEY5vhJt2AX9UjnksqPCt5zPPNIPwSWJaSRY2zhDolDQhgO9GfbWqajN26Uq30scfd0NRSscGa4pxQwsi7iKpeguIOt0+Mk9knS/vp6YA2Z/TGmGEh0e+93d6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlY/fagLP4GSYwJzBVP5ePIUh7W7Fd+TbqV/qiF9HOs=;
 b=GD3yybuvQ14sVmuj2Au3Z3yLQzNDZZOc1FCKvlxXPuSC5xInSNK0YPUAhGYnyzDWhHR1fXC1nMVTxznKr7ecH5kENYY9bLcqxOw4ioRQfs0knn8TNu6kL/O+nx649HICDfcnYlg/cjD4mXAN6BLjAVQ2BiRkh98H+BynnIW3eFTBpWbRLgEwi3xapfkMn6jb/wZECXDIOk63PaZiLIbOdU7xeRrB5c8bynV2a1jWCS9hklvV5rVvAt3/c1GWXVWnIqkFf7cg3JC2g+J/ca1CW0eYrkSZEgparR2EUchfxuH8WCoZHFZoin+bzy2f/XAfrGiysqOTZ3qCEovLq0cHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlY/fagLP4GSYwJzBVP5ePIUh7W7Fd+TbqV/qiF9HOs=;
 b=1f+w3Auv5mfIrhizmGNObyfU07pmpQSgzMuzQtUwOF1C/TPDZoH83TaLT+kYSDUWxQXbgYQs0OlMZ2csDgbWAnud/J56JjbdavIz+oBc0/0Mxmoze3crf+nFQHvREGoS0fM2v21uwXb+1pxjrwurHzkz1Dpyqt2uT8SsR567Hcw=
Received: from BN9PR03CA0335.namprd03.prod.outlook.com (2603:10b6:408:f6::10)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Tue, 23 Jul
 2024 06:46:25 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::5b) by BN9PR03CA0335.outlook.office365.com
 (2603:10b6:408:f6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Tue, 23 Jul 2024 06:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Tue, 23 Jul 2024 06:46:24 +0000
Received: from [10.136.40.40] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Jul
 2024 01:46:16 -0500
Message-ID: <225e6d74-ed43-51dd-d1aa-c75c86dd58eb@amd.com>
Date: Tue, 23 Jul 2024 12:16:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/3] sched/core: Remove the unnecessary need_resched()
 check in nohz_csd_func()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, "Sebastian Andrzej Siewior," <bigeasy@linutronix.de>,
	Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Imran Khan <imran.f.khan@oracle.com>, Leonardo Bras <leobras@redhat.com>,
	"Guo Ren" <guoren@kernel.org>, Rik van Riel <riel@surriel.com>, Tejun Heo
	<tj@kernel.org>, Cruz Zhao <CruzZhao@linux.alibaba.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Zqiang
	<qiang.zhang1211@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, "Gautham
 R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
 <20240710090210.41856-2-kprateek.nayak@amd.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240710090210.41856-2-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 764a9b87-714f-425c-0ab1-08dcaae32bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0Q3cHZoZDl1R2NKVS9udlo3VElhUU9NTC95emJQcDl1d0VONzJsSGNCMU9Y?=
 =?utf-8?B?b2grWlROQWJJNnU2czYzbjMxUlM5SjRuT3puWjJOREhtSW9OeFc1RUhuWjl6?=
 =?utf-8?B?M3FnZ3MrQ2w1eXpJOUVrbmhjSE11cCswVTZhMExhbHZpY1NPY2REdDljNHJv?=
 =?utf-8?B?N3ZkYVpnWmwrRjZmN2hQWUdva1gxMjJZaTM5b0s5ajE0U1puVjZhcEE5K2Jh?=
 =?utf-8?B?Sm9LR1ZoMkxvK3I0ZXRtSTFsTDB4d0lFcEtaM1J3bC9FeGJTdWhyMkFlUDNn?=
 =?utf-8?B?QVo5a2ZzR0dqL3ZGNUdSSmkxOVVaUlZHWnRHR1pBZjFER1JubzVrZm5SQ25F?=
 =?utf-8?B?WkIralVKeDZaUW1BV2JsSkNoNWx5OFFkVXl3bCtwc2FGZXJNNktLcTBKYnlF?=
 =?utf-8?B?RDRYemQweXJMUkJKUTFPbEdra1pVazFoc084dzA1TTZpMzlvd2VuN2RxMncz?=
 =?utf-8?B?REdqZzUxWjR1dE5KMVlLT0JaaXVtNlZ6Q0VmaTNXQ1U3YjluaUVmQ0xWT3Bw?=
 =?utf-8?B?VXcyOTdtZ21kVDRySTRKV1FuRUN2SDFDYmhBUy9pdTBHYUppdjlYNERISlZV?=
 =?utf-8?B?T3QzYTJKL095a29lY1ptSnNBeFNrcmlLYTFXQi8vV0hUS2ZBVDhEOFhYZmVr?=
 =?utf-8?B?dHdZVVl4ZUwrWkZPWWd2c213YjliMkNGMmhaOFJUb3ZnOGN3ZEEyZlQyMVVp?=
 =?utf-8?B?WWpNb1A0dVJPVGEwNEd6VXlTMkhYb0k3UHVMVkt0TllSOXNmWE5QUll2SGt0?=
 =?utf-8?B?K2RtMXNZa2JxQmJGRjVFak5NYmtTcVNGcTQ4amJoSWo5elhlN3BwVW13bkp5?=
 =?utf-8?B?SVRNNmV6L0taQXA1ZlZiYzhveUZPMENjUFBYdnFhMUM0T1VJdnROdjBZWUNi?=
 =?utf-8?B?WDV0aFdZZFdTYzZWRkVVcEc4R2YzTk5NWGJEeUR0RTkyaGk3ZXdDeG90M2pQ?=
 =?utf-8?B?Q2RWUjlVTXVoSnNXZnY1alUwRDh3UmsrZXIzYzhJbHB6eC9scXNCU3VvUStU?=
 =?utf-8?B?OHI1NlR1Ykp3bzE4c29mMS9EZUJhSFhsQWpnalEzL3hjZzZrY1cxRHRCOEpE?=
 =?utf-8?B?OE5nSmZXRy9LNFovc1NpVzlQY1FjTEh1QVhqQzI1ZWFkMSs1NExBcXROY20v?=
 =?utf-8?B?TlNDNGVZNCtkV0diWGFoaFZ5Y3R6Y3dmdy90MGI0NFcwWjRxeWhlNE5yS1dV?=
 =?utf-8?B?ZmwxLzdLdU5RNGRUVGloZDVHMFp6WDh6SDc0T0VZUXA5Wk5xMlBDUFpNZXB3?=
 =?utf-8?B?MzBRUWZzbkF3MnJYSnorVDRJcG1tTGFCdFdYNUlJTFgwb3FCUXIyTDEzQUxU?=
 =?utf-8?B?T3FZNXFKMnpOQ1N2S0NLdDJLN08rOVZxMXA1Qk40RmQzOE9sSGl5TTZXTjdC?=
 =?utf-8?B?UFUrRkpVTGRwOGJZalVBK1JlSGFIbCtNYkEzSlUyY2tEdDJwN1ZzR3EyeGRr?=
 =?utf-8?B?MjRmYUVRVjB3VjROT3V0N1J0NDZKQnlwMnJDV1kyMGh2R1VlUlk1NVNEU2lU?=
 =?utf-8?B?VGdOYVVlMzlsOXhJNDBaZ3l6ZUczOEQrYytvVzBsMXUySHYwa3VIa1A3eGFL?=
 =?utf-8?B?d1BoaUFUemV1c1ZjdXA1bHNJN2lRR1oxM1d2WmM0dm8wOWN3a0E4Y1FtcVdZ?=
 =?utf-8?B?dUlxeTJkTndVTDh4ekJxc0pNTzZEMkRoMXdIOGorZVFEMDM1K1N5WGtUVHg2?=
 =?utf-8?B?MEFzdS9ac3VBeEVGZU1IZWc5d25tZFE3OEFuR1M2dTR5OTVYSmtyWitHV20y?=
 =?utf-8?B?YlNzcDBNVDBRSFFEM1NIcG4rK0o0Z3lvSDRkQmU1ZFBJWm1GME0rNWRQbDlm?=
 =?utf-8?B?TXQ2dzcyZGwrRmRHSUZPeGloNW41Ymk1cldERHhxd3ZSM3BpczdacWNGSDNC?=
 =?utf-8?B?eHBzN0RPdjhsc1ZkYng0cUI4eXFlRWFLbnlZbVNhYThnUXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 06:46:24.6766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 764a9b87-714f-425c-0ab1-08dcaae32bb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968

(+ Thomas, Sebastian, Christoph)

Hello everyone,

Adding folks who were cc'd on
https://lore.kernel.org/all/20220413133024.356509586@linutronix.de/

On 7/10/2024 2:32 PM, K Prateek Nayak wrote:
> The need_resched() check currently in nohz_csd_func() can be tracked
> to have been added in scheduler_ipi() back in 2011 via commit
> ca38062e57e9 ("sched: Use resched IPI to kick off the nohz idle balance")
> 
> Since then, it has travelled quite a bit but it seems like an idle_cpu()
> check currently is sufficient to detect the need to bail out from an
> idle load balancing. To justify this removal, consider all the following
> case where an idle load balancing could race with a task wakeup:
> 
> o Since commit f3dd3f674555b ("sched: Remove the limitation of WF_ON_CPU
>    on wakelist if wakee cpu is idle") a target perceived to be idle
>    (target_rq->nr_running == 0) will return true for
>    ttwu_queue_cond(target) which will offload the task wakeup to the idle
>    target via an IPI.
> 
>    In all such cases target_rq->ttwu_pending will be set to 1 before
>    queuing the wake function.
> 
>    If an idle load balance races here, following scenarios are possible:
> 
>    - The CPU is not in TIF_POLLING_NRFLAG mode in which case an actual
>      IPI is sent to the CPU to wake it out of idle. If the
>      nohz_csd_func() queues before sched_ttwu_pending(), the idle load
>      balance will bail out since idle_cpu(target) returns 0 since
>      target_rq->ttwu_pending is 1. If the nohz_csd_func() is queued after
>      sched_ttwu_pending() it should see rq->nr_running to be non-zero and
>      bail out of idle load balancing.
> 
>    - The CPU is in TIF_POLLING_NRFLAG mode and instead of an actual IPI,
>      the sender will simply set TIF_NEED_RESCHED for the target to put it
>      out of idle and flush_smp_call_function_queue() in do_idle() will
>      execute the call function. Depending on the ordering of the queuing
>      of nohz_csd_func() and sched_ttwu_pending(), the idle_cpu() check in
>      nohz_csd_func() should either see target_rq->ttwu_pending = 1 or
>      target_rq->nr_running to be non-zero if there is a genuine task
>      wakeup racing with the idle load balance kick.
> 
> o The waker CPU perceives the target CPU to be busy
>    (targer_rq->nr_running != 0) but the CPU is in fact going idle and due
>    to a series of unfortunate events, the system reaches a case where the
>    waker CPU decides to perform the wakeup by itself in ttwu_queue() on
>    the target CPU but target is concurrently selected for idle load
>    balance (Can this happen? I'm not sure, but we'll consider its
>    possibility to estimate the worst case scenario).
> 
>    ttwu_do_activate() calls enqueue_task() which would increment
>    "rq->nr_running" post which it calls wakeup_preempt() which is
>    responsible for setting TIF_NEED_RESCHED (via a resched IPI or by
>    setting TIF_NEED_RESCHED on a TIF_POLLING_NRFLAG idle CPU) The key
>    thing to note in this case is that rq->nr_running is already non-zero
>    in case of a wakeup before TIF_NEED_RESCHED is set which would
>    lead to idle_cpu() check returning false.
> 
> In all cases, it seems that need_resched() check is unnecessary when
> checking for idle_cpu() first since an impending wakeup racing with idle
> load balancer will either set the "rq->ttwu_pending" or indicate a newly
> woken task via "rq->nr_running".
> 
> Chasing the reason why this check might have existed in the first place,
> I came across  Peter's suggestion on the fist iteration of Suresh's
> patch from 2011 [1] where the condition to raise the SCHED_SOFTIRQ was:
> 
> 	sched_ttwu_do_pending(list);
> 
> 	if (unlikely((rq->idle == current) &&
> 	    rq->nohz_balance_kick &&
> 	    !need_resched()))
> 		raise_softirq_irqoff(SCHED_SOFTIRQ);
> 
> However, since this was preceded by sched_ttwu_do_pending() which is
> equivalent of sched_ttwu_pending() in the current upstream kernel, the
> need_resched() check was necessary to catch a newly queued task. Peter
> suggested modifying it to:
> 
> 	if (idle_cpu() && rq->nohz_balance_kick && !need_resched())
> 		raise_softirq_irqoff(SCHED_SOFTIRQ);
> 
> where idle_cpu() seems to have replaced "rq->idle == current" check.
> However, even back then, the idle_cpu() check would have been sufficient
> to have caught the enqueue of a new task and since commit b2a02fc43a1f
> ("smp: Optimize send_call_function_single_ipi()") overloads the
> interpretation of TIF_NEED_RESCHED for TIF_POLLING_NRFLAG idling, remove
> the need_resched() check in nohz_csd_func() to raise SCHED_SOFTIRQ based
> on Peter's suggestion.
> 
> Link: https://lore.kernel.org/all/1317670590.20367.38.camel@twins/ [1]
> Link: https://lore.kernel.org/lkml/20240615014521.GR8774@noisy.programming.kicks-ass.net/
> Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")

Turns out the above commit + commit 1a90bfd22020 ("smp: Make softirq
handling RT safe in flush_smp_call_function_queue()") will trigger the
WARN_ON_ONCE() in do_softirq_post_smp_call_flush for RT kernels after
this change since the nohz_csd_func() will now raise a SCHED_SOFTIRQ
to trigger the idle balance and is executed from
flush_smp_call_function_queue() in do_idle().

I noticed the following splat early into the boot during my testing
of the series:

     ------------[ cut here ]------------
     WARNING: CPU: 4 PID: 0 at kernel/softirq.c:326 do_softirq_post_smp_call_flush+0x1a/0x40
     Modules linked in:
     CPU: 4 PID: 0 Comm: swapper/4 Not tainted 6.10.0-rc6-rt11-test-rt+ #1160
     Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.7.3 03/30/2022
     RIP: 0010:do_softirq_post_smp_call_flush+0x1a/0x40
     Code: ...
     RSP: 0018:ffffb3ae003a7eb8 EFLAGS: 00010002
     RAX: 0000000000000080 RBX: 0000000000000282 RCX: 0000000000000007
     RDX: 0000000000000000 RSI: ffff9fc3fb4492e0 RDI: 0000000000000000
     RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000ffffffff
     R10: 000000000000009b R11: ffff9f8586e2d4d0 R12: 0000000000000000
     R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
     FS:  0000000000000000(0000) GS:ffff9fc3fb400000(0000) knlGS:0000000000000000
     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     CR2: 0000000000000000 CR3: 000000807d470001 CR4: 0000000000770ef0
     PKRU: 55555554
     Call Trace:
      <TASK>
      ? __warn+0x88/0x180
      ? do_softirq_post_smp_call_flush+0x1a/0x40
      ? report_bug+0x18e/0x1a0
      ? handle_bug+0x42/0x70
      ? exc_invalid_op+0x18/0x70
      ? asm_exc_invalid_op+0x1a/0x20
      ? do_softirq_post_smp_call_flush+0x1a/0x40
      ? srso_alias_return_thunk+0x5/0xfbef5
      flush_smp_call_function_queue+0x7a/0x90
      do_idle+0x15f/0x270
      cpu_startup_entry+0x29/0x30
      start_secondary+0x12b/0x160
      common_startup_64+0x13e/0x141
      </TASK>
     ---[ end trace 0000000000000000 ]---

which points to:

     WARN_ON_ONCE(was_pending != local_softirq_pending())

Since MWAIT based idling on x86 sets the TIF_POLLING_NRFLAG, IPIs to
an idle CPU are optimized out by commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") and the logic instead relies on
flush_smp_call_function_queue() in the idle exit path to execute the
SMP-call-function. This previously went undetected since the sender of
IPI sets the TIF_NEED_RESCHED bit which would have tripped the
need_resched() check in nohz_csd_func() and prevented it from raising
the SOFTIRQ.

Would it be okay to allow raising a SCHED_SOFTIRQ from
flush_smp_call_function_queue() on PREEMPT_RT kernels? Something like:

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 8308687fc7b9..d8ce76e6e318 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -314,17 +314,24 @@ static inline void invoke_softirq(void)
  		wakeup_softirqd();
  }
  
+#define SCHED_SOFTIRQ_MASK	BIT(SCHED_SOFTIRQ)
+
  /*
   * flush_smp_call_function_queue() can raise a soft interrupt in a function
- * call. On RT kernels this is undesired and the only known functionality
- * in the block layer which does this is disabled on RT. If soft interrupts
- * get raised which haven't been raised before the flush, warn so it can be
+ * call. On RT kernels this is undesired and the only known functionalities
+ * are in the block layer which is disabled on RT, and in the scheduler for
+ * idle load balancing. If soft interrupts get raised which haven't been
+ * raised before the flush, warn if it is not a SCHED_SOFTIRQ so it can be
   * investigated.
   */
  void do_softirq_post_smp_call_flush(unsigned int was_pending)
  {
-	if (WARN_ON_ONCE(was_pending != local_softirq_pending()))
+	unsigned int is_pending = local_softirq_pending();
+
+	if (unlikely(was_pending != is_pending)) {
+		WARN_ON_ONCE(was_pending != (is_pending & ~SCHED_SOFTIRQ_MASK));
  		invoke_softirq();
+	}
  }
  
  #else /* CONFIG_PREEMPT_RT */
--

With the above diff, I do not see the splat I was seeing initially. If
there are no strong objections, I can fold in the above diff in v2.
-- 
Thanks and Regards,
Prateek

> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>   kernel/sched/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0935f9d4bb7b..1e0c77eac65a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1205,7 +1205,7 @@ static void nohz_csd_func(void *info)
>   	WARN_ON(!(flags & NOHZ_KICK_MASK));
>   
>   	rq->idle_balance = idle_cpu(cpu);
> -	if (rq->idle_balance && !need_resched()) {
> +	if (rq->idle_balance) {
>   		rq->nohz_idle_balance = flags;
>   		raise_softirq_irqoff(SCHED_SOFTIRQ);
>   	}

