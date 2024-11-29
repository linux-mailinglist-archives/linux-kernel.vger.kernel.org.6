Return-Path: <linux-kernel+bounces-425876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B36B9DEC1B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B404282800
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802351A01B8;
	Fri, 29 Nov 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xz02JQmj"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF61A070E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732904789; cv=fail; b=PdidreW3vEEINLRpGJmPuSpK7yg0Vh9lmWyW2EB0dB+GdtqsmvWxv43H8dwT52fK6aFnVBf0Rl93T/ktr05riEtzJSOHiNcBHsV8HvgYME88tuJ9qnY8LJzZwMw7JlcJ8Zpz4MpSfD9bvwxHJxjJj3xyQITBg8EFmOcT087E1L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732904789; c=relaxed/simple;
	bh=rdtrM8WYHSfXOSBJCK5cgMsu55FTiXm8Be373bFOOPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=htJNEeEeSmpx9PS6oTzfES+JSJGk3r+UNEeyi0EG+d7vEYb6mT/H38wf1D/6iHPLo/vPCln17rIZwX/REmijIY+JlmcVDlw+F0j6g4DlDUIwEA/Dsv+8CCfmy6AtZGM5CKYgj5fc07i+62oxXhHmo/WzjQpQuWeWF5Ug6q8aKII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xz02JQmj; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbEqJ2N/ei1fGYzpSluFhS8VrUTbjp8JEm8gLTz7buqHv59nyx0hXyd5vyMIDv/lPL7GWkvmIg1xUHMh9wK77LQdEB+A6K2ws6c5j934y9U6RsfsT5TaWDdcfu0tOwwp6O9LjUcxn4V0xlTHVmdUMLTuQwgwNkHCMk+sZekDDMNo4978MTYfJInuVtrvAf4Pco4hAIbwUWCxfeA8XD9ydS7G95NsJABPPuuU1oOH5ZREbJWHPbGB08735NVVrhVEYTL2wQAftc9m3pFCYMbnTv3s3+uz3clDFm/frJ1ofj6TxA1BvxcfuLRZa+UaSRma/yFQglI6yTNjClFoSa/blg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo9wVeadphme0Q4ZTm4l/soTGVk07KuUvQkNIwxJt7w=;
 b=WqfLtUaA4aIN4iWOamJCQjXejKFAvXtyZNStMdwpoM5cStZWJ243zE0/FYFMjN0oRvgfdaysHXzVjX6Wnam3lEinx9WOdJQNs9lFED8/9RVHqS+REbVU7eVf816sCTUbSqeVTiU6/akajHIwyroJo0cEuM8coQoH2I/PvRBSpb0FHDfeDs7hkkKsVA8sw08hsDuyH8XxUy0I2tShhokDaC9spM08Nuupigx9IxO8TeXvEFT+2MnlxjL7+RZsEkVUf8UvoPA5EFi35F+LWNVt2Zbjm+7tuTMzO9slqN+C/q5y1gp4JmDhrYPZe8LhzG4EWitA7R44O61RNNXckN90Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo9wVeadphme0Q4ZTm4l/soTGVk07KuUvQkNIwxJt7w=;
 b=Xz02JQmjG/SdEy/VGl+F7NcUynAL+aKZr2SIYCYD1e8b+EwJqdu4eUKF0lD3hdMnGFugzskT3aoPHJ+9OA/yu7lcEbhFiQKbVv5qgkpwmIaT4IG7ce+7fZ49FNFuixN8AkNx2Pu2elfLFHW4Slrt/1CDAGI90fb9yK+y91EG1uQ=
Received: from DM6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:5:1f4::36)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 18:26:21 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::75) by DM6PR02CA0095.outlook.office365.com
 (2603:10b6:5:1f4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Fri,
 29 Nov 2024 18:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Fri, 29 Nov 2024 18:26:20 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 12:26:15 -0600
Message-ID: <c82ed217-cfe4-41a4-b39a-e7356231835f@amd.com>
Date: Fri, 29 Nov 2024 23:56:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10 v2] sched/fair: Fix sched_can_stop_tick() for fair
 tasks
To: Vincent Guittot <vincent.guittot@linaro.org>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <pauld@redhat.com>, <efault@gmx.de>, <luis.machado@arm.com>, Tejun Heo
	<tj@kernel.org>, David Vernet <void@manifault.com>
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
 <20241129161756.3081386-10-vincent.guittot@linaro.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241129161756.3081386-10-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 275296d3-4a6d-47a4-8de7-08dd10a352c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1VqVGVOMklybmg4NTBjeTR3UllGOWd0TEVrdlFIcmkzUjBBN3NNV3pITkdX?=
 =?utf-8?B?L3RxMW1FQUpVVGkyNUFDWEhTdmdLYTd6VEFieEV3SHhoc0NIc0lpSm5VNGgx?=
 =?utf-8?B?TGNiMmFFcWtVbGVoMlRZQ3kvMng0T0dROHRibngrckRwQjdOMGZVbitTcW81?=
 =?utf-8?B?T28wallFRm45eFVIem0wUW9aajc5Qm1GWEQxck02YWVPdWRLRUJzSjZnMGUz?=
 =?utf-8?B?ZjJmVDNadnZnSkk3MjhsMFZ4dU1FTjZlYTBNRDdXKzlBd0E5V0QrN3MwYkdO?=
 =?utf-8?B?VWhnZ290K1hzUUNSNkdHSTF3eFg0a2lDTFM3UUk0azVZdllqSCt2NmNtQVBO?=
 =?utf-8?B?SldNVlNIa0hQUGlTc3ZWNytRS1BZdDVIQlhjYkpabHNvalVmTEtJNG1uQTMv?=
 =?utf-8?B?OVRxVFVXczV6UjkxWUZYSzl2NnBSYVZTU3lPWjFSN0VuWUd1MVM3VDEvckty?=
 =?utf-8?B?aVlTVlZ1c3VEVlNyUCswaDRjdXpEWjFzRGxrZVpBZmJlWE5EMnJUNTdwMnJh?=
 =?utf-8?B?WHQxVXpuM2FCK0NCNElqVG1GOVluOVdYdTNYaUJicUNNamtEN0h5UDY0cWF6?=
 =?utf-8?B?aTRybXBHL0c0OFJOUDBOeEp5MDZySGhOd3FzZWxROWJqYmM2RG5CMExSaDA0?=
 =?utf-8?B?aHIxYXVTS1JiMGR0RVRVckJwaDVTcTZiZVd4aHJzU0doRGg4Q09ZUVY3T3d6?=
 =?utf-8?B?dkNPQnRzYVlsdTZ0NEJDNFZ1aEFnMSs2UnBraW1OM29pZVhyYktKVFRxK2ZY?=
 =?utf-8?B?VXRHSkZhemQxM2N6Z2s1alVTTXNPQnAvTjI5ODhPZ3dHMTE1cmtvNVAzRTZp?=
 =?utf-8?B?UTI0NXRPZittc083bVZHeXNVK2k3c2lzNXZXWXRWYzR5RzAxRHZQS3dkeVV1?=
 =?utf-8?B?TXBzTS9iZkFEZkkvN25KTGgzWkZtN1lQNXNtTWhsWTZpb1RCS2FxY1VwU1BR?=
 =?utf-8?B?UzZoNGFPTmRrVElyemx5a2U0L2RHWWNqdDk4Wmh1RmYxVUFSOXhnVzk0d1VQ?=
 =?utf-8?B?WSsyVWhMQXVITVA3UFVDQ3VmckNINDZua0Z0aEd6Qm5Sbm51NC9MdG91Mml5?=
 =?utf-8?B?OUgwK1duNU5PcGlFNXUvK1ZvZkdlR2lGb1daUjExYnpyKytLOVo2QXFSN25L?=
 =?utf-8?B?ejRXZmZNdXV4R01DOGRndUtUdDFiM28rQ0NIMFVvMmIyV0h0SXFWWG92dVps?=
 =?utf-8?B?WTVNV3dxK1RsZWhlQStueXVtaUY4UTJ6TU5QUUxBOWVtazd6YWhJKzAwWnll?=
 =?utf-8?B?aG5URWpKZGFuWm5RVGYrdjJFaHIzQ1hxbTlLQ0UybEVyVlV2eUEyZXBBcjF2?=
 =?utf-8?B?QndOaFU1WmRmbTZCK256dkRIS1ZvNXphR1F4VUtUc3E0eDdFWHRsWUU1Zytw?=
 =?utf-8?B?bjJFeXpsMVNQeEMyU3JCQmZhY1NHbHh6MUVtOEkzR0F2UXhsY0VmYkcrMlMw?=
 =?utf-8?B?NjZHYWN0cng3aEJPZ2pyV1IzN2hNWmc1WDhFcnlteGd3bVNlUEZDUG9UcVZ6?=
 =?utf-8?B?ajQxWlNxSUw3TmlHZlpYZzZCSjFrSkZSM3o0T1dUdjJZYm1PMEZRYXNrb1pr?=
 =?utf-8?B?bWFBYW5JbHRua3RqVWJ4RTkydG9zamVGK2F3bDNLYkNJdFE0NVhJUzJYR293?=
 =?utf-8?B?Skd2eDFPWVUrQkovd1MwbUgvWU1id3g0dmpZNnQ3SnU1VVVkamFxN1ZUamJF?=
 =?utf-8?B?TTJQeWhscDNkZHlpcm9wb2JLMDgxam9KVW5HUDBpV3lwam1KV2VMb0RBZUxy?=
 =?utf-8?B?NE84WC9HUW1ZUG5zbWNlUlJMY24rSDNkOWJWMzc3MmdGc0VkRUU3QlFhUXY0?=
 =?utf-8?B?NVV6NlJEZ1VCWVhJWGtNR05rZDZSeUhiVkN6cmpxOThneGdwdFQwQ3ZYVlZt?=
 =?utf-8?B?TU9Uak5aVDFSYTJnWlRjNDhGWTlaMlVMQUc2QnA3T2NSOEZpazVRVlBIbzR2?=
 =?utf-8?B?MHVXWXNablNtVHpxaGZtMldzRDg3QXlIWXQ1eG1keFA3SkRDcGZxbVJObWZl?=
 =?utf-8?B?Q3NLcUd6RDJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 18:26:20.9908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275296d3-4a6d-47a4-8de7-08dd10a352c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081

(+ Tejun, David)

Hello Vincent,

On 11/29/2024 9:47 PM, Vincent Guittot wrote:
> We can't stop the tick of a rq if there are at least 2 tasks enqueued in
> the whole hierarchy and not only at the root cfs rq.
> 
> rq->cfs.nr_queued tracks the number of sched_entity at one level
> whereas rq->cfs.h_nr_enqueued tracks all enqueued tasks in the
> hierarchy.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3571f91d4b0d..866a1605656c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1341,7 +1341,7 @@ bool sched_can_stop_tick(struct rq *rq)
>   	if (scx_enabled() && !scx_can_stop_tick(rq))
>   		return false;
>   
> -	if (rq->cfs.nr_queued > 1)
> +	if (rq->cfs.h_nr_queued > 1)

Perhaps we can move this fix to the beginning of the series and add:

Fixes: 11cc374f4643b ("sched_ext: Simplify scx_can_stop_tick() invocation in sched_can_stop_tick()")

before converting the h_nr_running to h_nr_queued  since prior to that
commit, sched_can_stop_tick() used to check "rq->nr_running" and since
we check the count of DL, RR, and FIFO tasks up above, it would have
captured number of fair tasks running before sched-ext. That way the fix
can be backported easily to LTS too. Thoughts?

>   		return false;
>   
>   	/*

-- 
Thanks and Regards,
Prateek


