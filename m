Return-Path: <linux-kernel+bounces-560981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80640A60BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11AB1895D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5041C84AE;
	Fri, 14 Mar 2025 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LCjYztVi"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221F81B414F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941650; cv=fail; b=H+vEWUBsECTVgyAz/QJPMeqdqA3acL3aBjdga17RF7IZz+9m1YkWUtj+8JEZzK1UvX1jpyEuXAW9m8L+E9pQ8YQMO71vzWNfrqLuGRioTP3kbno2s7P2I4B3b3fRGKKZu47ipQjaKvdWw+MtxTWvHfS1alGspVQ4T29fLXjfzo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941650; c=relaxed/simple;
	bh=odtAcmv8U39hoG1LlUSnlgT2dxJwGAyICTIDFMHhMsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cKOCvT4mNJe0lC7b96UoO/x01mSnSVgqrUBlyVo2BY0LT2Slb6S99sYlGpu9dimElfOdK4Y9iCTZpb4+OLAYbv/Zxbe7+hf9jpJfROphmG46c+xwihtxERCl56ht4svsi6V/Ryl4GP0E0TRf/HHE+cwFruR25+5N42DY5DeKsQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LCjYztVi; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfExDRwNA5QK3t2mVypcqks2y7bL6O6TeQUuUt7oDYxJGEHsYT87nDRGKyHaobckTiqm9VCf3ukbZ4fSTyDCZLcTEY51cAM1TquqQZ6xjPeDwgRSeISsiDl7O8FN4BchzRzBgyElNUeZMvZgm/kw+mfL/6XnXnwS6LvpOlag91EV7EYn7QtxRVpZ8TFcLg9I9XTPHgYKtP4HmvVxlm5t8dNFIDwtFxEWHfzcX2fi4HAwChRa7fj7G/eXFfONABfcMx0N3OezIpIxd58e9AD33WGMc4qiyLKUqN8tGur8dyIcwDcbZM0Vohz0lYv8GX4eI3yEjzbG9iWx2OA/KuEAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZFFlpyfw0UQr0nG1nRFhirbGs9XUGL1zkkWaeKp+ug=;
 b=IMbVe29OM5Htnab3glV09xBXfSiXc0r5sNjpgR8Ajt3w8QR6nk20rgjzco6YPNib1VuMDircTaBfpH6HDrweetdX50XuE1SgCEdaVtFfqh06huQAAPioOTUFVvb5ZVQjpQtx8nfUvEUtaZ6GQNpxlwwqLn0Cb6w6Sjzqzkbb+am9upFvVUBNs9JYFaruWdW9eUSfAuVroBSqekl2hva7ak/ucHP3buDUghD7mlhtr+gWOvtaXpg2a7PgI9tyDE8kIAHBE82umlMW11YEwNbEuf6g40aLrkp2ROvCZUuRSspQYFgbc75Kd9ebVTt8lN0YQAhohnPksxV/0xy+TYOhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZFFlpyfw0UQr0nG1nRFhirbGs9XUGL1zkkWaeKp+ug=;
 b=LCjYztViPyYdPSgQdP1Z4UbYTzK5oPWBXrC+6HgC0EniMXyuv0n8hCZuFRnMSyOOu35odiF+qGQNktpQKgtuegtaLwCOy4vVcvODeMVqIb9DXKme1/U8WQ/NeVeRirrexYEMjI3s/GpipPgm2+GEQrncWSCPZoLtUkdMh5SQa5o=
Received: from BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37)
 by BL4PR12MB9484.namprd12.prod.outlook.com (2603:10b6:208:58e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 08:40:45 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::c8) by BY5PR03CA0027.outlook.office365.com
 (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Fri,
 14 Mar 2025 08:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 08:40:44 +0000
Received: from [10.136.37.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 03:40:34 -0500
Message-ID: <931db71f-a13c-48ab-a315-f04d671bdddb@amd.com>
Date: Fri, 14 Mar 2025 14:10:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v15 6/7] sched: Fix proxy/current (push,pull)ability
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
CC: Valentin Schneider <valentin.schneider@arm.com>, Joel Fernandes
	<joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
	<vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman
	<mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
	<xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>,
	<kernel-team@android.com>, Connor O'Brien <connoro@google.com>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-7-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250312221147.1865364-7-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|BL4PR12MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f854c6b-2706-4fb2-9fe4-08dd62d3e92e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3pNNTVCalY0TTd3bWM1c1NFak5aMkM1Wnk3eWdXU0V0MlF1cjgwMjdmRW0y?=
 =?utf-8?B?MmFNNThCNzV4dU5RcVVTU3lvNlNsNnNlamJBUTQ4ZHp3aWEvRjRqb2FiZzBP?=
 =?utf-8?B?VUFpajZNSUs0bVB4aXN4dXdFYlNTNzE5YXlmNnd0VWU2US9mMTJKZEJTdE0r?=
 =?utf-8?B?RUdQNG1nZEduSlZRL1FxQkZkK2pKbW1XSit3SkxMaUFGWnQySEk2YmFlaWwy?=
 =?utf-8?B?SW1xaWRsK2xZdG12ejlybTZKeFc0VTVsVFZyNnZUMFMvRkRpMHBocjVSQU41?=
 =?utf-8?B?Z3RPN3VVTEVJSmZvTnBmeE5XWk05dS9mSWdINFNPT0NSTHpVQWtGL2VMUUQ2?=
 =?utf-8?B?Q1dmSDU1Vy9JSVQvaFRpenBOYnNLSk0wTE1IVTRGWW1EdUZQeTdsM2RkNVFU?=
 =?utf-8?B?UnB3SFFwSFpGajlzeXIyZzlabWhlckZOL2lzZm1kTlVHejRsSmptQXpnTnd1?=
 =?utf-8?B?NDVqQ2l3MVB0T3EvMkgrRXh0VzR4NEFGbzNlRjg1UjRRVFRpWkhobFg1bVQz?=
 =?utf-8?B?WkRRampXTkJpYXN5SGErV1RnK0RKZXZyTTJUYU40T2pmZE83cm5KbjV2NkRF?=
 =?utf-8?B?UnFZVnZDV3VWd0RHaHl1VmtoQ0xvYnFuS1BYY3JjamN1MHUwZWRvRmdSczNN?=
 =?utf-8?B?K3hJalhKSE1tUE1lOWtnbldwV3pKM3FBU0Y0Rk1FNlR3bGFaaEtmNHRmYWJ0?=
 =?utf-8?B?Q0VTRzVHdFhSeXZlSjIzaXBibWFsaC9zc3NuU01Edmg2WWFtOVY5c2k1enJ2?=
 =?utf-8?B?OS9mSm9KVmtESTRjckxGVTc5bDFMWnA5RDRCZVBhbmdxdll1Vnh3c1h3azZ3?=
 =?utf-8?B?akJqb1A2MW00d0Rrb0ExM0JOM1JhYmFLbGY3cC9vVXFCbm5EK3NiamtkSkls?=
 =?utf-8?B?N0Z3MGR1UkhRdVd1M29BQ0VoTTByRGV6RlJETDd2aDdVeW9OL3JONC9FeUhT?=
 =?utf-8?B?Vk51a1JqZFdiT0pXc1AvTGZna3c4N2xJeVlSWXBEUTFIdWtvYk51cC9iZUdH?=
 =?utf-8?B?bnlaTlRDNG02NmpSYkIzUlBmVWtPZ2krckJaQ291MU9UdEtCSWdCbmhsc2Fr?=
 =?utf-8?B?MUN2YVRDbDU0anhCNVNGZ00zaUR4Zy9UaTV5dXdzK1g1VDVjUWd1VHp3eXNo?=
 =?utf-8?B?V1pGQlpod1k3MDFUMXFDcmJQYWZXRi90alpheFJhcGsyZ0ZFR0ZiUG8rU0lJ?=
 =?utf-8?B?cU5DSjZIOEYrM2ZFeUtpa0dpSWNxVVpCaUVqN1hWSUtJbUZNRjA2VHdCaGcz?=
 =?utf-8?B?QUtMREJvQW1RdUVKMkZ5L3d5c0VaMGRxMGFYN0hLcnVIbkJxd1E1RS9nTzV5?=
 =?utf-8?B?OHR3azAvRzQybElxOXB3L0ZRZEw2b1VKZEl6dGRRYTZsbjJ6V2pDQjVSU0tn?=
 =?utf-8?B?T0RRYWw5MGhUVUZkaE1DS1JTZHpwSk1vSklXRmM3T2ZXNFliTCt0YWMxYUg2?=
 =?utf-8?B?eTRvSVBDNk9GWGtrTVRGK0NkdFdzK3ljRWxyVHVyeXY2cW9Ed01zQnFYREcy?=
 =?utf-8?B?UG5WeTA5UHVyOW9VZFVNZGRXMWNja0IvTGZqeUVNRkI3cUkzbVRwWHhzckI0?=
 =?utf-8?B?Z2NCOXVsMHdSclRvRnpiOXZ1bEdxekRkZHNRaHV5UDVMTkdsa08zb1ViRXZp?=
 =?utf-8?B?ZXY2YXBWbmI1MEFiMFNXZWJEVEhwWDhUK1RuNHFpMGRydWZOSDUxUGFoYzJJ?=
 =?utf-8?B?bHg2NWF2b0pOZ3FaUmt5Z1FUL0h1L3dkL2dRNkE5Tm5Kd0RnbkJYSC9ZNVZr?=
 =?utf-8?B?MUlRYm9tWjVmSTdTYXU4TkNjWE1YcDZHdlhCNFhGaVRGUUFCTGNJazdCN1ho?=
 =?utf-8?B?amUrbzZSbFQ3NGJIaEJrMWhZckhVa0wxZUhveFlZUmRqeVRtcFRzTTdDTm1k?=
 =?utf-8?B?d2FwYVZRKzg0Tm0zZUZCbzNuQmR3U1Z3MWNKb0ViQnhWamIxME4rd2k2aWQz?=
 =?utf-8?B?WEJqUUFnSi9sL1NoZkY4VUFWZ0I3Q29mcnFOSWpwd2Zsc2d4ZllPZDNCY2V6?=
 =?utf-8?Q?MfvbifBYRL0jrs4Y475CUyiJXQFw2s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 08:40:44.5309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f854c6b-2706-4fb2-9fe4-08dd62d3e92e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9484

Hello John,

On 3/13/2025 3:41 AM, John Stultz wrote:

[..snip..]

> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b4f7b14f62a24..3596244f613f8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6722,6 +6722,23 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>   }
>   #endif /* SCHED_PROXY_EXEC */
>   
> +static inline void proxy_tag_curr(struct rq *rq, struct task_struct *owner)
> +{
> +	if (!sched_proxy_exec())
> +		return;
> +	/*
> +	 * pick_next_task() calls set_next_task() on the chosen task
> +	 * at some point, which ensures it is not push/pullable.
> +	 * However, the chosen/donor task *and* the mutex owner form an
> +	 * atomic pair wrt push/pull.
> +	 *
> +	 * Make sure owner we run is not pushable. Unfortunately we can
> +	 * only deal with that by means of a dequeue/enqueue cycle. :-/
> +	 */
> +	dequeue_task(rq, owner, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
> +	enqueue_task(rq, owner, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
> +}
> +
>   /*
>    * __schedule() is the main scheduler function.
>    *
> @@ -6856,6 +6873,10 @@ static void __sched notrace __schedule(int sched_mode)
>   		 * changes to task_struct made by pick_next_task().
>   		 */
>   		RCU_INIT_POINTER(rq->curr, next);
> +
> +		if (!task_current_donor(rq, next))
> +			proxy_tag_curr(rq, next);

I don't see any dependency on rq->curr for task_current_donor() check.
Could this check be moved outside of the if-else block to avoid
duplicating in both places since rq_set_donor() was called just after
pick_next_task() or am I missing something?

> +
>   		/*
>   		 * The membarrier system call requires each architecture
>   		 * to have a full memory barrier after updating
> @@ -6890,6 +6911,10 @@ static void __sched notrace __schedule(int sched_mode)
>   		/* Also unlocks the rq: */
>   		rq = context_switch(rq, prev, next, &rf);
>   	} else {
> +		/* In case next was already curr but just got blocked_donor */
> +		if (!task_current_donor(rq, next))
> +			proxy_tag_curr(rq, next);
> +
>   		rq_unpin_lock(rq, &rf);
>   		__balance_callbacks(rq);
>   		raw_spin_rq_unlock_irq(rq);

-- 
Thanks and Regards,
Prateek


