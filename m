Return-Path: <linux-kernel+bounces-421879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA79D915E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63068B2444E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D64912F5A5;
	Tue, 26 Nov 2024 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wcYdemsl"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3128FF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732599186; cv=fail; b=H+8R80nhNJB5sL2axhXsoH3qx3CbxHaQV3vEq4kaUXAK73HMkBqIg4ykmn9SWdbI7fQHHwsxmXvfrWX+qJx/r2d6d7UTW/LsbDyHKpgjHPztq2IfqjBSofOphmmfESjtIj7pTefWYVQDvtRopxwESEdMi3EgDKW3JnWM+ZDF7fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732599186; c=relaxed/simple;
	bh=y8tu5SHx5R17wyVvuOKllCo2X72cCyiiDOfN6Og4nDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XH41v0YrcDETZD1EqLVwPWIqdvvC3mM9SOBDFDQOwPXe4ZOJqLiTcpBc0XkN+mPcydE7YY1K46kzQlo8VwD0GCvMFfCEogkV9PoQnXIBBOgs4yQ3rd/dmE4E2sUG7ECAadqAwxLCK7MkgQJ53zvttUFRXTPpkdMv29QB/3c5+ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wcYdemsl; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwS68BARGHAI3MYE7GU0Vap3Io5vfu9a9bfn6tSIYxoN5zFLCUJmuB12ZTSyE4JyurlOokfVwY+DZtDUk0g4XDnbJbLyoe1A6Hg1JC/N7Xs/DV9cg409Kuw79B8jyJKtIfVfWg/sOHjk6o6ezwmwxHUH5TDeIWX0vMfR3SFw+QaAaMnq8XrAzzRxf9tYaBxg8a2XXYUEN5P/OLNN/6BLwXYnUtULn2biIIiMBlgTUWU0Wny5XeYFF0LfG9zzSQCaW7ePevYMXWvkCaR7uGpBH8UB2KDLfENb0pKl3c6sNb5mzKvFfObPZvH4bOst9kVqoQrXKsYaOhtvR+Uz7WHLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdSRRT5KMAnwKe6nSw5Xr9TZtXz6R+DIqpfAA/Cf/Mk=;
 b=KfaXH/wkhK/lJ2tuNMYcJ97ZS9Nz9l1ZCoAiNZidOm0ZYzD3g5pzakU+wgpxplC0StzJ/xg21BTNFmRC9E2wqufNYBOtQ8wAhuLkkRyNB3ZpzP5ZPLDgtng84CxW0g9X+M0Ox2vPsCxAR9rUpyqaYhAwUdp5HWctPSxoO5uuBQtRjv4pjbMhNIKiSpK1i0pQ5OD2z2+BUimHYyuInZiPc+uS67xGFhDIZLGPJcHrqLLTJ+OYrxl/hjtaXQOpJWLoz4GL+/RzYFB6kD5gnJ9T0RuoLvol6nZpLJi+Vkh+Cc+fUAkwmrzqsI97WhsIXeOcqiAe43kVv3ajS+qKiu19fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmx.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdSRRT5KMAnwKe6nSw5Xr9TZtXz6R+DIqpfAA/Cf/Mk=;
 b=wcYdemsldU1EB1cA8saeeNQrPSEhEYC+SVysv5/E7Dsd3YbWyRbW78v6+vAesojDNeDkOMVQsc3g8Bs5leeUASvITty2Teeu1+5EHGnSTmtbf/wPzOlOMo5IqFjJ+WnV6R0IBM1YABCrNIRCvuoCpYX+9Ip8KoQkIkf6BBaU3fM=
Received: from BN8PR12CA0025.namprd12.prod.outlook.com (2603:10b6:408:60::38)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 05:32:59 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:60:cafe::b8) by BN8PR12CA0025.outlook.office365.com
 (2603:10b6:408:60::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.17 via Frontend Transport; Tue,
 26 Nov 2024 05:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.0 via Frontend Transport; Tue, 26 Nov 2024 05:32:58 +0000
Received: from [10.136.45.86] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 23:32:53 -0600
Message-ID: <8df808ca-186d-41f8-845c-c42fd2fd4d45@amd.com>
Date: Tue, 26 Nov 2024 11:02:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] sched/fair: Dequeue sched_delayed tasks when waking to
 a busy CPU
To: Mike Galbraith <efault@gmx.de>, Phil Auld <pauld@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<wuyun.abel@bytedance.com>, <youssefesmat@chromium.org>, <tglx@linutronix.de>
References: <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
 <20241112124117.GA336451@pauld.westford.csb>
 <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
 <20241112154140.GC336451@pauld.westford.csb>
 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
 <20241114112854.GA471026@pauld.westford.csb>
 <20241119113016.GB66918@pauld.westford.csb>
 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
 <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
 <20241121115628.GB394828@pauld.westford.csb>
 <bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d08dbc0-6d05-442a-f21e-08dd0ddbc967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|82310400026|7416014|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alhPM2tEY3I1aHZmYlpIZkdyZ1A4TXp1TkV0d2p6M21VS3lwV3duM21hZjVx?=
 =?utf-8?B?NzhMTlpqZ0tkaktjcU0waUFIOElzQ2FCZWVKODBMMytudmtvdU5jN1F1MEV1?=
 =?utf-8?B?T08wT0E0QWVjZkJXOU1PSE9wbzJqMHdsV2g0ZVZsN0VnbFVOTUg0NUtubWJD?=
 =?utf-8?B?dzU3eW5nOCtneWVRYmIvTTMwMVMzRjMwSFF6amFxT0VpTFQ2N1BkNGgrUEJG?=
 =?utf-8?B?eUtaT2lZME5VS3hFb2h0ck1wekFKVFZOTlFMZnFuMTcxemJxV3p1Mi82MEd3?=
 =?utf-8?B?aTNuOXNzZDlQRmtRK21XRFJMK1h2RmdscUN2bUxIVTN2bW1iOTZhQUEzMkE1?=
 =?utf-8?B?U3RuK0RwMnE0Y20zV0hrRDBic0J0Nk5RU3BodFladnVRRHhzcG9Ea0tkaHVQ?=
 =?utf-8?B?eTJ5RjZCVkZKQ0hxRFN2bXl2dlFYaTFEMk9OcEZrRmhtcWxmeG9BWHE0U0Za?=
 =?utf-8?B?bXFiMzl2UHFxZlR4NXlHbys0Q05GYlZ3S1Mxb1dVc1JZMDloWUFSS2dPbjIz?=
 =?utf-8?B?bUJuL1gyamptSjR4WVdJKzkwdHZ4SUYzR0Y2L09KNlltSkMrZTRqd3NJV2RL?=
 =?utf-8?B?TTBsVGc1aGlLbUs2ZVpNOWl0ci9HM3gwWWc4ZGFldXpYYTJaY1puNnpvVURM?=
 =?utf-8?B?MHlWUmZGYjlRUTF2MCt5QjVvVmlhSCthOG40MjBEVHVaNjlvYjBMMjBPcTNk?=
 =?utf-8?B?d2QxL0hXSjU2dlJrUWlrQ3RBenlxSFE0QnFHRkdFc1NkVnRkN012ckxqdFNN?=
 =?utf-8?B?RzJ3eHZ5RTN3a1lYSmdob1lxWWRvS0M5VnVKVDlHSGRzUFVPMVNDcGVqK2ln?=
 =?utf-8?B?S3pCMlJxYms3VysrZnp1cmM2NlBNb3BOQ1BjakZFQkM5TXlVa1VDcWpUdXA2?=
 =?utf-8?B?Vno2eWxFMksveXE2RGo0endId2h4QnJtVDlYWTVuZDdXMGhSQmZMeUt5SmUy?=
 =?utf-8?B?c3MrYVFCYW1IbWM1REwzM1h2ZFQ0ckVUN2Q0RVdUbFBneTVsZHZ6Wjlsa0JG?=
 =?utf-8?B?bDQ5UXUyUHFDeGp3MnNjbjRwekhTcjZDS0hoTEJUOVZ2RFZYNXRGM0V2RHg1?=
 =?utf-8?B?dWp0QitkVnlYaVFnMkZrVXVEeXVodDJUNmxkckJvTDQ1dG5rSkw3c0hNVHRI?=
 =?utf-8?B?ZmcraFV4VGZCd0dmbGQ3OTFmaUtGQThLTlgxT2tDWGFiSTJ6Z1EyLzRqSlM5?=
 =?utf-8?B?b1ZXNzMyenlZS2MxQVY1YU94cmtybGN6U3l4OWZjdlROZEQwRFcwOERMRmUy?=
 =?utf-8?B?UnoxRFhtN00wYWhjbkM2RzFZZjkweEduM3liM3JCRFBLRjgvWEFUdmRRNXZS?=
 =?utf-8?B?TmZNZG9iVEJJOFNzamxWQWRkbzQyMWJ0K2RIODFvamhycVpzcUlYNHBUTmJw?=
 =?utf-8?B?MHRsTlgwVmk1aTdsOEtxd1dWN3F4KzZVWlE4YWZXNGRpa1NoZUtpOW9BaFlk?=
 =?utf-8?B?eGI0YXBhV1A0ZWNVdndDWEM0eXhrN0RwT2k4SjRjU0ZJT3RjQTVOZlhzcEYr?=
 =?utf-8?B?Q0NIQ2ZHUUZ5NEZ2M205TzRXNlFsOUlMdVUzKzZRVm1mUlp2Y05lS0dOYzN5?=
 =?utf-8?B?NWN4WTRZREdYdzd2NzZMTXlKQWJHcTJDRUV1SWgzbFhnUDlML2REQitZK3dC?=
 =?utf-8?B?a1hxN09jSkNSVEI2cnZkUWpTQVJ0K1VjZzl1NXR1dWorMzdoYjJFQk1LcFlS?=
 =?utf-8?B?L2tzdXBlT3Z0cForaTc5YkVBYmY0Q3A2SS9uMWNyVXdWQk1OeW9zbTQxdW5m?=
 =?utf-8?B?WWZpWkkva3psZ2VWT29ZczRhM3hzSzFpcGxQOVJBc0hJb08zclp6cklwbjFZ?=
 =?utf-8?B?c2R3YjNFUXVReldTT3Q1T2ZFRGwxVW1XK3ZJaFZhSFF5TTlaajZrb3JiSmJi?=
 =?utf-8?B?WDh6MThqKytveTZNbjNEK2ErN2pGMDlpWEIydnBxZkRKMDdaa3VSU2o5aGxT?=
 =?utf-8?Q?3/IEk6YBAkY/jw8z9M3FKghXhYoajXqr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(82310400026)(7416014)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 05:32:58.3728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d08dbc0-6d05-442a-f21e-08dd0ddbc967
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029

Hello Mike,

On 11/23/2024 2:14 PM, Mike Galbraith wrote:
> [..snip..]
> 
> Question: did wiping off the evil leave any meaningful goodness behind?
> 
> ---
> 
> sched/fair: Dequeue sched_delayed tasks when waking to a busy CPU
> 
> Phil Auld (Redhat) reported an fio benchmark regression having been found
> to have been caused by addition of the DELAY_DEQUEUE feature, suggested it
> may be related to wakees losing the ability to migrate, and confirmed that
> restoration of same indeed did restore previous performance.
> 
> V2: do not rip buddies apart, convenient on/off switch
> 
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>   kernel/sched/core.c     |   51 ++++++++++++++++++++++++++++++------------------
>   kernel/sched/features.h |    5 ++++
>   kernel/sched/sched.h    |    5 ++++
>   3 files changed, 42 insertions(+), 19 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3783,28 +3783,41 @@ ttwu_do_activate(struct rq *rq, struct t
>    */
>   static int ttwu_runnable(struct task_struct *p, int wake_flags)
>   {
> -	struct rq_flags rf;
> -	struct rq *rq;
> -	int ret = 0;
> -
> -	rq = __task_rq_lock(p, &rf);
> -	if (task_on_rq_queued(p)) {
> -		update_rq_clock(rq);
> -		if (p->se.sched_delayed)
> -			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
> -		if (!task_on_cpu(rq, p)) {
> -			/*
> -			 * When on_rq && !on_cpu the task is preempted, see if
> -			 * it should preempt the task that is current now.
> -			 */
> -			wakeup_preempt(rq, p, wake_flags);
> +	CLASS(__task_rq_lock, rq_guard)(p);
> +	struct rq *rq = rq_guard.rq;
> +
> +	if (!task_on_rq_queued(p))
> +		return 0;
> +
> +	update_rq_clock(rq);
> +	if (p->se.sched_delayed) {
> +		int queue_flags = ENQUEUE_DELAYED | ENQUEUE_NOCLOCK;
> +		int dequeue = sched_feat(DEQUEUE_DELAYED);
> +
> +		/*
> +		 * Since sched_delayed means we cannot be current anywhere,
> +		 * dequeue it here and have it fall through to the
> +		 * select_task_rq() case further along in ttwu() path.
> +		 * Note: Do not rip buddies apart else chaos follows.
> +		 */
> +		if (dequeue && rq->nr_running > 1 && p->nr_cpus_allowed > 1 &&

Do we really care if DEQUEUE_DELAYED is enabled / disabled here when we
encounter a delayed task?

> +		    !(rq->curr->last_wakee == p || p->last_wakee == rq->curr)) {

Technically, we are still looking at the last wakeup here since
record_wakee() is only called later. If we care about 1:1 buddies,
should we just see "current == p->last_wakee", otherwise, there is a
good chance "p" has a m:n waker-wakee relationship in which case
perhaps a "want_affine" like heuristic can help?

For science, I was wondering if the decision to dequeue + migrate or
requeue the delayed task can be put off until after the whole
select_task_rq() target selection (note: without the h_nr_delayed
stuff, some of that wake_affine_idle() logic falls apart). Hackbench
(which saw some regression with EEVDF Complete) seem to like it
somewhat, but it still falls behind NO_DELAY_DEQUEUE.

    ==================================================================
     Test          : hackbench
     Units         : Normalized time in seconds
     Interpretation: Lower is better
     Statistic     : AMean
     ==================================================================
     NO_DELAY_DEQUEUE	     Mike's v2	  Full ttwu + requeue/migrate
     5.76	           5.72  (  1% )        5.82  ( -1% )
     6.53	           6.56  (  0% )        6.65  ( -2% )
     6.79	           7.04  ( -4% )        7.02  ( -3% )
     6.91	           7.04  ( -2% )        7.03  ( -2% )
     7.63	           8.05  ( -6% )        7.88  ( -3% )

Only subtle changes in IBS profiles; there aren't any obvious shift
in hotspots with hackbench at least. Not sure if it is just the act of
needing to do a dequeue + enqueue from the wakeup context that adds to
the overall regression.

-- 
Thanks and Regards,
Prateek

> +			dequeue_task(rq, p, DEQUEUE_SLEEP | queue_flags);
> +			return 0;
>   		}
> -		ttwu_do_wakeup(p);
> -		ret = 1;
> +
> +		enqueue_task(rq, p, queue_flags);
> +	}
> +	if (!task_on_cpu(rq, p)) {
> +		/*
> +		 * When on_rq && !on_cpu the task is preempted, see if
> +		 * it should preempt the task that is current now.
> +		 */
> +		wakeup_preempt(rq, p, wake_flags);
>   	}
> -	__task_rq_unlock(rq, &rf);
> +	ttwu_do_wakeup(p);
> 
> -	return ret;
> +	return 1;
>   }
> 
>   #ifdef CONFIG_SMP
> [..snip..]



