Return-Path: <linux-kernel+bounces-434581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78B39E689E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930A1281C2F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462591DDA1B;
	Fri,  6 Dec 2024 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uIJY09Ik"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715FA191F78
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472897; cv=fail; b=HNYiTSV/VcHpcSapilnSRo6r623K7eznqDk25u7va8Jt7YFP3Eu++ZmINOO16dQxkfSpCOOhGI/h3w3k/dSaoG2uoV5s2AYY+vYebLOV1bDIgqsfA98hXMVIMo/YsP4CpIyXmYBkXM+PW4iQCVmW0f4wrR3qjzIcbk47AL8ixxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472897; c=relaxed/simple;
	bh=6yM6V4NGIS0D8Ew0beVSMBCq1i+y4UuwR6de90hn1vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lr2l6WAKyo3bN+o4qk4AIABTP3kA+WgY3Lq7b6NzLKba2jeljWFk8CE2bHAaH26dxVWSch+1Ix4B7Vn863BGvk5gNvWJ2kELr6hvyiCKAfW4ncmWiBe87ScPytP7eJL2UYpZEa61RJ3FRICvzT9KZ4PU+JIN2FRmq+3OcUNZ7WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uIJY09Ik; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ln5KeMmgMj/Ae7GTwXxxLH8ETwm3jicxTaNY8Mr1ByW3FAicwRe4eHller4hJoY9NkdJGv98Ya0SZgaswFE4ZRmqCiWwUbHLyHQE2meR5inDpUPAs5A3IcHloA+iKn0R9XAW7gpAK3tasv6BFP0WYPypJ7OM7Z1/ju1LYV4uOce/z+jyuw5FMKS13qUyk+Mjf2stksEfrz4zjRDa3NXB+299dOYp9u72GlptMWaoQhtUljUnMcYgvoYpvfKPDcxKBxA0pC0u1XnTRtjcV60h53cV3M9shTi5HSbHp8ttveakT+sB5KCXyq7mZ3fydpHyEUG0T9E5uKxk4K0qW8rmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=596gIwhXG/HAhDbrLEdQUtyYTFRlTFq7epkHcMI+B6o=;
 b=kk4cHud6LxeEZsbpurD7yT3ts3QOEjf0SEInq54eNmHTDU10Wa/+ZPiVgdbsH3qkkABIl1SXLDG6MSvKwsmQChaX182tl7iiAW5MT0ycqsJpzxVoEjG5XoyhU6aynnPRxfPVWE6NyqkWTVXETZpN1UDnp1gPTBZdYgPYOEVTB43iUXCPXuwJDhK8BhadPMvQgqmbUz055wJBActoUjByNlPDzCZX8jn6lpldKIQ/D9ogQ/nt47EpkH3OY6IM1d7f55a3AuHiNJmGWN/xYgA9htgjDZl6iTRqMxfP6djT6Ob8H52qPIWJQcXYG9Szu9Yb8+cFmbD+VDk9TK9C6Q7r6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=596gIwhXG/HAhDbrLEdQUtyYTFRlTFq7epkHcMI+B6o=;
 b=uIJY09IknX5b3Aa703Gv5T98PLkCVwAIb80cryydawFp4OdTnwkbME23RvjaF+fl4A8ED2XFqitrRQat9CqpocAAHomIv0AF8AgfIiQzshTqK78AjtSjuC+rijC4lruKQ+dmlDRyE9n7uhgdAW0t7RI+xOIldj/yjS4onfhU2rQ=
Received: from MW4PR03CA0187.namprd03.prod.outlook.com (2603:10b6:303:b8::12)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 08:14:50 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::8) by MW4PR03CA0187.outlook.office365.com
 (2603:10b6:303:b8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Fri, 6
 Dec 2024 08:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 08:14:49 +0000
Received: from [10.136.46.151] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Dec
 2024 02:14:45 -0600
Message-ID: <94bc116e-0ef0-475a-ad00-b994bf0edca9@amd.com>
Date: Fri, 6 Dec 2024 13:44:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched: deadline: Cleanup goto label in
 pick_earliest_pushable_dl_task
To: John Stultz <jstultz@google.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Wanpeng
 Li <wanpeng.li@linux.intel.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Todd Kjos <tkjos@google.com>,
	<kernel-team@android.com>, LKML <linux-kernel@vger.kernel.org>
References: <20241205211632.1181715-1-jstultz@google.com>
 <20241206000009.1226085-1-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241206000009.1226085-1-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b63caba-983d-493e-b255-08dd15ce0df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0IwZENCMlhvZ25ITDBCK29DVFpFbDk4RzJIeHhmTDlubklFNzk4ajJid1NL?=
 =?utf-8?B?UUtWMTRtNVdRbnFmalRUbVV3NktWeklxc09jZXFYTG5QdTIyaG1YUU1UcG5L?=
 =?utf-8?B?elorRkpoTkV6YUdHd3h4WmtLaXlKNkxvYWdzYUMwV3VydVdmRXRtOTU0Rjlw?=
 =?utf-8?B?dWlPemY3Qmk1ek5IYjVhb3VJWUl2aHQ0d2tvVG9RS0EwV2xERE1ybUpYN2dE?=
 =?utf-8?B?UnA5emltYkJVckFVK1ppMHFwU3hnMFY0azdvUGNRMHFjUE4wdHBrbmlaSE91?=
 =?utf-8?B?KzdQSUJlZXc2ODN6NFNuaGJtbnBLODdjWk5HK3BlaEpaVnlmOTAxNnBTdHBZ?=
 =?utf-8?B?TEZ6R1RPYS9waE9GZHVjbFYyT2dFVHVzb1pMQ3ppbTFvSmtad2lLODROc3Vt?=
 =?utf-8?B?aFNZNzdOajVVS0ZodDJaallZSVBpTWd2SGxBNE5KMXVRMFJaVzFrN3c2clc3?=
 =?utf-8?B?Q2oxcUM3aU1wMGEvTkpqUlZZdENNU2JTdmdpQ3ovcDUyU3B4ZXcrWnJ2dDdI?=
 =?utf-8?B?cThEQTFLZUlKS0xlSlpFL202THFYWmo2a05SckhObzdqdUJwZURJSmtrZ0Fa?=
 =?utf-8?B?amtMdUJudVVGelZ0M3haQXprS0VEYS9Ca1JHZVRGM0t3U0NWRG0yRlcrR0d2?=
 =?utf-8?B?b3JFOVBRLzkrMjFSSnVpWDlPM1o0Yy9jd3NpWmduWU5sRzB1K3FHTFV3c3dF?=
 =?utf-8?B?SXhHYkRNN0Y0SS9BUEhsVGFGMXpTdzR1NUU2Y0VHV2oycEZaU3JKdHpSR1Uv?=
 =?utf-8?B?dzQ5c3FSL3ZISGg1MGtCZ3gzRSt3amZ2cTNITUt6S1c2UkxDam5zdnhEaGww?=
 =?utf-8?B?d1hHSjZuS2VVTGpJamRyVXFQRHJoNDA5azFFT3UvMVpROEtTSUQrV0czSi9B?=
 =?utf-8?B?TGsydWd2ajAvT0k4K3NsWXJURjRUdk5wN1Iza09jSDZ0N21XQnJha0Fncjd0?=
 =?utf-8?B?UjBqMGJDYWkxczAxTDc1ckxvWGZsUkJERTdCVDBCcnJVNnNwOWZpV1RuUk9O?=
 =?utf-8?B?YzlhUk5PUzk3cnNOclpDck5uWnpKOW5LYW1FM0QralVSVUFxVWdvZm5hV0pz?=
 =?utf-8?B?cEJuU2F6Q2NwUkV2aVpXcENSK3NWd0RSY1Q3NElUS2hkdXJJSHVzTEZwTkk3?=
 =?utf-8?B?SWJEK0wrbXFGYzZGTmR1cjUwY1o0cmdlbndoU1lGaW9OUkJzTFdtVktCckNn?=
 =?utf-8?B?QkxPOFlCYzVkSkFKTE93dDFUZ0ZvQnFlVTBVN2ZFd25vRnpQYVRsZDFLMVcy?=
 =?utf-8?B?OFlZVVBvdlhxWG9MVUxuTFpSMDdwWVI5Z2ZyZHBWbUJRYXk0VSthbDYyN29T?=
 =?utf-8?B?UGdoeHdiOEhjRnUyeWtEdFBVWEtXZTNvYTBnRDhjaGs2clV6bnB6MmxWNkpQ?=
 =?utf-8?B?QUg5eTNPN05UQmc0aHZHd3FxYWpoRElDcGcvcTlDelB4QnRiNFNPV1JTRTBP?=
 =?utf-8?B?SmkzSTNvMXBVeElwc0QzaWJtMkJxemJqOGxpcDZlbnB1ZWZlNHBaMzZncCt5?=
 =?utf-8?B?aEhDanBBQUJlYUE5Wm10NFF2cTZUY1U4eGNqYjRlWHNtb25NL2tDU212alBj?=
 =?utf-8?B?eXVhMEJCdzUwaFRrdFJoOEJqQm1VL0ZEZHY5ampJaG1KNkdiVm5iV3ptVVJY?=
 =?utf-8?B?ZEVaTTRFd1Y0M0pqWGoxRXBSVUU1NzhRVElLYjFidmJQMEo3Q2N5TW9wVUxP?=
 =?utf-8?B?N0diYlJHNjl4R25QTnRadTJDa1NrbG5JYVRGTlk3NmNhVkJ5WlVUOW9jcU9T?=
 =?utf-8?B?RFpuamdzZ1FlZ05IcVZkOG0weS9kSzBqNDBwb251cmZVNS9tdXEwbFB0WnMv?=
 =?utf-8?B?K0c4WXc3UkRWNlNiNnVNTkVOdnVmdEpDQ0R0RjQzVk0ycnpXVmdUNm1YNFNM?=
 =?utf-8?B?UWVkZEl4b3VycXg5eDBvL1FEbUxWdXR4bFl3d3pscUZzOHM3QzZOeFlBVnFz?=
 =?utf-8?Q?FgR2IKkZK+qyDP7/sVRrRfFaSPHfbXQP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 08:14:49.6305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b63caba-983d-493e-b255-08dd15ce0df1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054

Hello John,

On 12/6/2024 5:29 AM, John Stultz wrote:
> Commit 8b5e770ed7c0 ("sched/deadline: Optimize pull_dl_task()")
> added a goto label seems would be better written as a while
> loop.
> 
> So replace the goto with a while loop, to make it easier to read.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Wanpeng Li <wanpeng.li@linux.intel.com>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: kernel-team@android.com
> Reported-by: Todd Kjos <tkjos@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>

Gave it a spin on my box. Feel free to add:

Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> ---
> v2:
> * Corrects my misreading of the code (as pointed out by Christophe
>    JAILLET) as already having a while loop, and switches the if to
>    a while.
> ---
>   kernel/sched/deadline.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d9d5a702f1a61..b2cc71984176a 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2501,16 +2501,13 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
>   		return NULL;
>   
>   	next_node = rb_first_cached(&rq->dl.pushable_dl_tasks_root);
> -
> -next_node:
> -	if (next_node) {
> +	while (next_node) {
>   		p = __node_2_pdl(next_node);
>   
>   		if (task_is_pushable(rq, p, cpu))
>   			return p;
>   
>   		next_node = rb_next(next_node);
> -		goto next_node;
>   	}
>   
>   	return NULL;



