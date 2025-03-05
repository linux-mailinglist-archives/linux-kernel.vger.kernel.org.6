Return-Path: <linux-kernel+bounces-546059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 800DBA4F5D6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14F81693E6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918EA1419A9;
	Wed,  5 Mar 2025 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2FbP/iJt"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898E2E3388
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 03:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146885; cv=fail; b=cb3b8IVNUl14LNUuXvVL9y5Xa2izJIyo1DiSmk/Cn+qFCrYIutKoQvync5nssPXd6XZJMr+QsB/WPETNkJZ+Jgq1PCsKG8H13X5NrZAcSt70pM0UIZZYM0PfhcSh6Iv1eOVolKboalUQH5KmuGJjPtPt6rwZQxMDRaK53JnApuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146885; c=relaxed/simple;
	bh=vYdZAXe3gkj4uoyYi25OV5nQ9HjV4SPN3CCNN6mMOWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FgEJmjsi0Go5arrQiQmdpGSihzHPtd3UKSK+57WkCUS68DxeaxcEZbdOLgoYgt89GBNnd9t+AjFZwtgUmwc7nzdnX4kqeXyBHzvM4HwSA0NPBCrnTmlV/e4bQInkwV3iV+YL0We4cmGMuBNiON5FkxJ3kOj/VqwUbKE9O9/tPPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2FbP/iJt; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuM/Q/azXmXVH+3CRNhA2JxNl4rs0apPK5AmAPpqE10ilN2CxV6Swhhp8Xpad3m5P0Tl8f5Z/1qDpgBEKsfSfNl+kdDH44+YVE6lTZYcRDpxI2DrxzwwrjrQq/cVG/jmYuxh5X8UF3z8LV+XM4Gcs3Jk33hGwdVtrm9iel/07GqaS32jb9+2CglC1REhrXUaRUFO6eMMP/f9E9BpFxwetmSBoNVYPkmvBTWjAclTIyOQyKzOnXjzBU9wXaep8HtGiFI/vh2WT4HWIduIjb94Z6SmVx5okZAIYtgp98vforxUXAOpSRLs54lucItJYMYPxwRSR+XRgWsx0+AQFo+Clg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiV8N8tPXK5EFOrMkDnbrwvzjOzMXrqN1vOxDnlQQfE=;
 b=cwnXYsMNj1yIu6eNjvTC4KYLRd68Q8ovTvrF0+5wfCCOC209Di1CgQUS8CIgVdJpm5PAO+PiWMFsWYWGHQ89E7m/tHqU5dMXC8btNmBD4HaatBe2oy630jiS24CZoJJjoaG7xWZc/SjwQAlFdfB43VTJ2Dr1ziWABzNn9k5hPuQrZMR7GYjKZUgChPd65vKJIcktRjUJ9Y3iIQu0+gk/yHkcLmpXmPSSV8Dw9sm8wi2c68dzzPkZYphaeVeNXRV5KW5FYb3YO744H/1zWZYCocXETaLyzBLt7Xnjx/+X6W4AHkII73hhrRKYgxR2C/VXSLXcbt2xOHEvJ31y1fY6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiV8N8tPXK5EFOrMkDnbrwvzjOzMXrqN1vOxDnlQQfE=;
 b=2FbP/iJtG06Aa/3LMmGw+pQvxc/DMpI1kj5by1OSppppAZXZbzzFjPxRLfjq0nPKXRIcTxFfElR868whnOuu+M1sbfFs56O8nPLgFS5gIvR9iJPHTcfCHlV5PdJTiJmOqTYQVxuxlY6F6ecVWKv3IXRO/x8MEV5LFEYHSVZp/z0=
Received: from CH2PR17CA0011.namprd17.prod.outlook.com (2603:10b6:610:53::21)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 03:54:42 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::a6) by CH2PR17CA0011.outlook.office365.com
 (2603:10b6:610:53::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 03:54:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 03:54:42 +0000
Received: from [10.252.205.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 21:54:37 -0600
Message-ID: <6409142e-d535-4ddd-b58d-41ea793f61b4@amd.com>
Date: Wed, 5 Mar 2025 09:24:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix potential memory corruption in
 child_cfs_rq_on_list
To: Zecheng Li <zecheng@google.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Josh Don
	<joshdon@google.com>, <linux-kernel@vger.kernel.org>
References: <20250304214031.2882646-1-zecheng@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250304214031.2882646-1-zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fb8a89-0659-4f04-5caf-08dd5b9975f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1FVWXd2VlBLUStPY0llenNTSk9MTm4rZ0JocTZoVG5hOVBhSGFvQ1I5RjBo?=
 =?utf-8?B?T2dNall5MUYvdnk5VFhVRlBiMEh0NVF6NWtqeVhyd2E4YXRqVnROTmNtNTVa?=
 =?utf-8?B?QUFnNVJOdWxyQ3hWV1NTQkhhVUZ2clJhdk1JSGJJOFY4Zy8yZXYxSEVGUURZ?=
 =?utf-8?B?alo4SmxCNUdPYm5SOG44TEtnTHhzMmtYNTR4WnJ2THpoTU4rUUJOVlZQVldC?=
 =?utf-8?B?Tk1yUFRLSmlnYTV0TGtNQml5UjJERjREZmZvMjZzcWg1N25FL0syaWJKMXFK?=
 =?utf-8?B?YVBnTjd0RjljMHozYXNLYVdWR3pPVndvcTBrd2ZEOSsra25JWWJkMUVmRmMy?=
 =?utf-8?B?aXVTSzVtZ0p4OU9TT0RDdzhBMVNjN2JWNUR1YXp4YXFFZVlHS2VaNWxrMXRV?=
 =?utf-8?B?UTJGNmVRUGJHQ3VkYkh1bmwySEtEMlZwSEM5VUNrZWZEeVFaM1FMVEN3d05p?=
 =?utf-8?B?Mkh1VVFodUgrUUZsQ1lwc0FrQTA1aklHRytoOFgzTG5DeDNPYjFCNnVoMkRT?=
 =?utf-8?B?dWQrQkJaazVOQ1RtMlByZmFCZnFVWmtZc0E1U3BmRUFIWWpoVHVmb3hXeElz?=
 =?utf-8?B?OURZSUg4WE9RV09Wd055SXlTWkIvQnZrSHpqTUkzdlpkTFR3ZXk5WlRPKy9o?=
 =?utf-8?B?NXR6MXJWdHVGVjYrZGMyVkwxclE5U2djSGRuYXFsQnBSYUNtbHVEK0tZUFFJ?=
 =?utf-8?B?T0Q0M0RrbGpmaWd4Yis3RW5ZZjFNS0lGWjlhZEllS3d4d3Ryd0NXZjI5Ynhu?=
 =?utf-8?B?RndnM0p6eitmaGgrVHpDRzF4c3J2ZjQ2ZFkrSnRDcW1uVlVoVVgxWlhabG9T?=
 =?utf-8?B?LzM2Y1hGZlIwS01wWG5ZQzFDN0NUOCtqWUpRS2lxalZXQVFGamZLbGhHTEow?=
 =?utf-8?B?NDBybDBSRC9vTGd4RVk3SW9jMzJCenVFQmlqSVk2Zm9PVXBLZnBFcjFqdTZH?=
 =?utf-8?B?MVZieGFQKy92ZUVtVDQ3czhic1ZrZjIzVFd2a0RYNXZDb1FMZUIyb2lUcnZL?=
 =?utf-8?B?Mm1hcEU1SEtpL01nTTQxeXo5alFUM3o0bXZMT0x1THZSMXQ2RmJwT1AzN2k3?=
 =?utf-8?B?aUQzdldGUW4rUDlsakwxc2VxT3EwYnlJVzUzdGdQWTBTcTFweVlmVFo5MXZL?=
 =?utf-8?B?YVd4Rk9JOHFoQnN5VGJHRWZCZldrMTVYVklqVHUzMExYdEM2aUl2ZU1jS1ll?=
 =?utf-8?B?QWdncnpzei9PV0hFb3NGL1pXUVFuZ0dOQnpZcWFFMTYrKzE2aVZzejFFNjYy?=
 =?utf-8?B?Z2xvM2JSQmR0ZzhOVVdKMVdNSGtpeTlQOVNZUGZHWE5naUhlNGVSZVZLRDRl?=
 =?utf-8?B?bkdUa08vMHNrQW1SR2VVMmpZNzFFK3JSQUk2cHpBK1hXdWZHV1AwN0dnRUcw?=
 =?utf-8?B?REkxUWZCNCsxVUhKZk43bUl6cTAzbEk5MmZPcmtmMmltMHd1dGREZFluSkNw?=
 =?utf-8?B?YTl4TGxkdWEyUmp4UWhMYkQxOGJvdSt0bHZ5M05DQnBkbUlQODVMdCtmcmF4?=
 =?utf-8?B?cUNJQnc4bGpPUW9iSzRCbEVkdXczVXJPaUNnZE8wTDYvaEYzZ0VKbUs4OFB0?=
 =?utf-8?B?RGhxVWs5VzBZV0p6ZzJOZGFscnpDZ0FOWUtEVW5UZzJWZlhjdStpYkhyV3RB?=
 =?utf-8?B?QVo1QVBiQTlDQ1ovdHV1SjdCSm93MmtXcVRIQlBmcXFkUlg1OG1iV2JiTVVt?=
 =?utf-8?B?MHVZMUZLMlkwZUcwWG13RUJPd0pnVnh0cVdzN0tLWUhxemZYWG5TYnYzNFJO?=
 =?utf-8?B?WnNKdTFTOHRySUx5YlBlSXVIMUhWWjVJL0tGNUVrVjViWEJHTjMzTTJ5QU1B?=
 =?utf-8?B?VXF1WG02MmtiN1p2S05ZbkdicEhyZzZZSTAycmZrSmlCY2RDRk9QMXZUUE5Y?=
 =?utf-8?B?Zkg1SmlZWEw5L3p3alJVNEE2WERkS09WM2tpUmMzajd5SjkvVGd2ZENQUTU5?=
 =?utf-8?B?NjBIejNVMEc4ODdvc25SbkVjdVN4MTVxVEpHdkRpMGs4dkUxeURhSzlZZ3Vz?=
 =?utf-8?Q?iZvTE1Daxh8rfNlUs3dCUMLahSMN9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:54:42.3057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fb8a89-0659-4f04-5caf-08dd5b9975f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148

Hello Li,

On 3/5/2025 3:10 AM, Zecheng Li wrote:
> child_cfs_rq_on_list attempts to convert a 'prev' pointer to a cfs_rq.
> This 'prev' pointer can originate from struct rq's leaf_cfs_rq_list,
> making the conversion invalid and potentially leading to memory
> corruption. Depending on the relative positions of leaf_cfs_rq_list and
> the task group (tg) pointer within the struct, this can cause a memory
> fault or access garbage data.
> 
> The issue arises in list_add_leaf_cfs_rq, where both
> cfs_rq->leaf_cfs_rq_list and rq->leaf_cfs_rq_list are added to the same
> leaf list. Also, rq->tmp_alone_branch can be set to rq->leaf_cfs_rq_list.
> 
> This adds a check `if (prev == &rq->leaf_cfs_rq_list)` after the main
> conditional in child_cfs_rq_on_list. This ensures that the container_of
> operation will convert a correct cfs_rq struct.
> 
> This check is sufficient because only cfs_rqs on the same CPU are added
> to the list, so verifying the 'prev' pointer against the current rq's list
> head is enough.
> 
> Fixes a potential memory corruption issue that due to current struct
> layout might not be manifesting as a crash but could lead to unpredictable
> behavior when the layout changes.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>   kernel/sched/fair.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 857808da23d8..9dafb374d76d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4061,15 +4061,17 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
>   {
>   	struct cfs_rq *prev_cfs_rq;
>   	struct list_head *prev;
> +	struct rq *rq = rq_of(cfs_rq);
>   
>   	if (cfs_rq->on_list) {
>   		prev = cfs_rq->leaf_cfs_rq_list.prev;
>   	} else {
> -		struct rq *rq = rq_of(cfs_rq);
> -
>   		prev = rq->tmp_alone_branch;
>   	}

A "SCHED_WARN_ON(prev == &rq->leaf_cfs_rq_list)" here is easily tripped
during early boot on my setup before this fix.

Only nit. is perhaps that return can go into the else clause above since
"cfs_rq->on_list" case will guarantee a "leaf_cfs_rq_list" pointer that
is embedded in a valid cfs_rq struct but I've no strong feelings.

Feel free to add:

Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

>   
> +	if (prev == &rq->leaf_cfs_rq_list)
> +		return false;
> +
>   	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
>   
>   	return (prev_cfs_rq->tg->parent == cfs_rq->tg);
> 
> base-commit: 7ab02bd36eb444654183ad6c5b15211ddfa32a8f




