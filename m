Return-Path: <linux-kernel+bounces-275710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65A29488E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDFB2844E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 05:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65C81BB686;
	Tue,  6 Aug 2024 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xy3Bi6mL"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67891C32
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 05:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722922011; cv=fail; b=MZ5XMIJA1J63Jc6NeY2VeBPjC7324kdx6MdWMU6En/U4lck1JG05pY7VVi3dCoNuZ/yLF7w05TmR7fmNdyMOCE68Vu/9N9glu8WpW6il3FevnfBj1ynzf7mV34uQ3jbK+aJPFgNynr6KeQlzTxgr412iGuxwwA2v55UJzcMRFuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722922011; c=relaxed/simple;
	bh=cyQqGom01B6nriJAcpK5TrJHoScdy4QO2kF/zRc1WHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eKnQNSZk0UHNdg5ro1q5BmDmYhmNqttur/hsqcZm6oabBreeLDGf9C6Xnv46tvjp93Mo8379PMqfUxyb4geWMjgFr1a1PpK37cfln7kEwvqV64bgaq0abaIlMEeb0H2oH1lE5kN2C5lWLvlUfpANjwLutuGg4kS0cU4OIYp5pwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xy3Bi6mL; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wuw/Wwk4EpAsT3sU6Bx4BYTCJy2F9S2avSCd4C16aW5SkUi+6f1p1xhIJ/Nl8bPdgss2vW2pNp2ZLviPnfqSj0WWbbaHBSo2p0WRZn1Gi0YjDByoPVdExvepigKU2KeTNvWm8b9YVbBYb/eiqpAkZLwwiAQyxmXmBeY9654zpkHwS6gJLGDZQA5KV71Z2XtnK2+I3DQGZFlD1FvU8aUaY+kNvdtQEDFfxPvFTRpzg//c7L4njFYii+HHkVSQzk7vqLhTiSttTUGu02j0eryjWsoI++Cv6CsD2a4Pt2X0vs9OAQrnlNl56HG4z91XMo+RRVvf2vYJMJQXF4/iYQbqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17Ou3iEbFk4iofoF/qQ9njnswKG7UMOuN8mRH8nviSY=;
 b=AuGEO7ipnv7+z0E4nfDbX0Kg0eEaBKFT+SEQL1OW419wCdTyKR7VsPiqCV2x0r5mEQPHh32BM/mT3nKBAscIhphbB2JoYhcsUT5WUxDVG+f5m5QZqNIFfRq6qw4zMWteCUbEw8zu3YkzczjJ2a8EX/+/HI3Q7cWp/RYp5EIOniuQEkfUwrqkvIanLaJlHJQcqwcN0qQiNGHSJxa3n9H2ZPkPIkHeGZVr9IwXHiNiMMSkGj1X4swYdPdMbkNkaGs2qMsu1sMw4Jnntx7tx08WebKLgoKEnqZkpsEXRYf2VrNexGiPzw+p/JZS8Dtzjb/lWtpWccUPAHzGUkdNfvwu9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17Ou3iEbFk4iofoF/qQ9njnswKG7UMOuN8mRH8nviSY=;
 b=xy3Bi6mL+jDTlx7dimP7BDyH/DfTzQ5+xZrVrIGLp3a6iRwPglEQl4bq3yRjisJX8unbaG7GPb3QdjI97WCKIaxEJLp1uqpyS3WTeQUVjcuqTCb8s6ooyv9ItOXlhbOJSz5iiSyYDYb589u26FS9KH2luY62xYzSVd7AWSPJH+Y=
Received: from SA1P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::28)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 05:26:47 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::b9) by SA1P222CA0021.outlook.office365.com
 (2603:10b6:806:22c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Tue, 6 Aug 2024 05:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 05:26:46 +0000
Received: from [10.136.40.92] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 00:26:44 -0500
Message-ID: <6043863c-0343-32b8-8521-3e2fcdbc01fc@amd.com>
Date: Tue, 6 Aug 2024 10:56:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 sched_ext/for-6.12] sched/fair: Make balance_fair()
 test sched_fair_runnable() instead of rq->nr_running
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, David Vernet <void@manifault.com>
References: <Zq2GJMEl0nG0DMyX@slm.duckdns.org>
 <ZrFUjlCf7x3TNXB8@slm.duckdns.org>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZrFUjlCf7x3TNXB8@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: ca885eca-679e-4cd5-1b3d-08dcb5d85db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmQ5WGtRdUUyYVFIaHYyZW42QjlUNkJEMTZ2bW9xajlOVE5ubms4RjZUb3FM?=
 =?utf-8?B?K0NJNnhZQ1lNTnZnWU5ja2djMjdFc25NSnh0Z1l5Ty9xa0lnaFBLeWRlQXVH?=
 =?utf-8?B?M08xVndveDlXb0xvRnExTTEwRTVlSy9ZVWhKenhTd2RiY2lXMGV0MkNsZ2tO?=
 =?utf-8?B?Q2Q4QzNDeEJiVDMyY3dTakdXL1Juc3NrWEFWZm5uRWZqT0hHZllXVGtieWdr?=
 =?utf-8?B?L3JzbWMrWkpFWHhyOGhkMlVmUmdacTRyTkw4d1kyeGRmVmlqdXpieTZkVDNz?=
 =?utf-8?B?ZHRHRExEWmYwblkwdlRGQTNGMnBEQnJkODZYZHp2S3dacjltRWhWWXVUT3d6?=
 =?utf-8?B?d3B6dm1LczUzQXVvV2JtWENGZzZqNitxSkpneWpyTXNPM2xlTkVRMy9JUWxl?=
 =?utf-8?B?eExQWHZNSXgvWk9Qa292VmhVUmsxQTUxVU1BRGJCUXI1dzRDRjRsQVNjWG1s?=
 =?utf-8?B?MEd5S045UDVwQTFrZS9LTXRPYy9kd2dXZHE2WXJQR2NOeVlQYUIwVVpRNCs3?=
 =?utf-8?B?ck0wSWJ1ZGs3bE53Y3U5Wm1pOEZqZUxlT2NYUnZhVGtzY2pZYlY3c2JaZWxs?=
 =?utf-8?B?aVR4SkFHa1RBczdsQThjRVQvSC8xcFByb1dCYTV2cVJqcmZtR0t1eHo2bDYw?=
 =?utf-8?B?Kzh0aWZ0NVNtNXR2QkF4UEd2L0dXNjV0NUtjcll6NUdQa0FFOEU4akpEdXMw?=
 =?utf-8?B?aStqYXA4R1NkV1pOK0xFaWpiN1B6MFg5bGFCVzZZQWxVV3pVMjdZZ25teTZl?=
 =?utf-8?B?TTdwWWMyTGJPM3gyNGJ0WW9kd2lpdEZDY1lQcnE0Qk1mMVg3cE1OQlpSSy9B?=
 =?utf-8?B?ellVRjZPM3N5Y3dYUFh0cXJHQ2xhYXhrSDljSmlDL3JrazBjWkZzYU1ibUsy?=
 =?utf-8?B?ajdZdmk4REt1dnN3ZjVtc3VYa3FDTW9Ea280SHJROHI5dGxvVExzQmtIVnVQ?=
 =?utf-8?B?TzAvZ3hqVjY0di9WQmhGSjBiTVVXQnVqMlZSaHUxclkxYmx1UlpxMzZJSjZs?=
 =?utf-8?B?STlUdjFJVnNzcE5zb3NFTVRlRy85TEVEMDBkNFNxRlUyS1JqeVFlSzlCQ1B2?=
 =?utf-8?B?R3hhcGpVUGttWTdsSDNLUDRaelZRVmcyTDYwOFZ1T1hwWlRjVkxsOVdoY2xw?=
 =?utf-8?B?QzNYUitrOFFEY2ZKb01SUnhWOHFja1BzejBza2lNcVg2RDdPMklVNTNpV0ZH?=
 =?utf-8?B?SXMySGNpVTl3UFI3L2dQNGdhRS9VNVBpT2gxWUQra1NQZmhHNXIxSlYreHNR?=
 =?utf-8?B?ZnpMRzZjb0FKMWNNTjlVZzhnOG9KQVJnUUo5VTl1L0NDY2liUlBCMHRmU09I?=
 =?utf-8?B?OG5nbExpWWY4NDRSc3RhTEtHMTZ6THZJQnZrMFFNNmxUSkJ3MjlaTU1Senl3?=
 =?utf-8?B?cGJrQmIxRVdTdzJzaStnR1I4MzczN3l1VEx2NWIyWktSaFBzRXRUT0p0T1NM?=
 =?utf-8?B?LzNpZjFEaDdpQXh4RW0rQlhhMXlRclhnL0NNQzlGQUNnK2trL0kzdy9HaERk?=
 =?utf-8?B?Qk82dVZhTzZpcno2WjRLY3JmN1dQdm5QVXNyaHlGZ2RFVitCZjUyd3JtTllu?=
 =?utf-8?B?VEk2QUh5UWcrWENEWjd5OGhZTHprTVFGaU5HU0NLWHBHQnFveUJIWHIraEkz?=
 =?utf-8?B?SGtNMzUvaW9wVDFub3E2MG5sNDJPbGxxR0NsYXRKN2JLNFBlSzc3TlVoOW5U?=
 =?utf-8?B?VTFXS0MrTDZxalB6VmVVSFBITTM2VzNyblp3MW5EUGlNeWxKVllrNytQcW10?=
 =?utf-8?B?Z0hOdkd0bVIwOUs5WWJZUzVpU0lPWDRpWlhQMkZueW9SZkpOdWFObXJYN1Ir?=
 =?utf-8?B?Yk9lN0F1QUtUL3lrSlJPWEdmNTRFcXIyOTNnZ1BGTVR0R1pWNmVlOHRtT0pE?=
 =?utf-8?B?a1FvMzNndFJHRVJSNWRHMmZzb25XMEczSm1KY2c1MmhqbHJ6T3JxWnlNTlg3?=
 =?utf-8?Q?Up6k37GI3kqT5q33YS6edPek+QrisOiv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 05:26:46.8412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca885eca-679e-4cd5-1b3d-08dcb5d85db3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633

Hello Tejun,

Thank you for updating the commit message.

On 8/6/2024 4:09 AM, Tejun Heo wrote:
> balance_fair() skips newidle balancing if rq->nr_running - there are already
> tasks on the rq, so no need to try to pull tasks. This tests the total
> number of queued tasks on the CPU instead of only the fair class, but is
> still correct as the rq can currently only have fair class tasks while
> balance_fair() is running.
> 
> However, with the addition of sched_ext below the fair class, this will not
> hold anymore and make put_prev_task_balance() skip sched_ext's balance()
> incorrectly as, when a CPU has only lower priority class tasks,
> rq->nr_running would still be positive and balance_fair() would return 1
> even when fair doesn't have any tasks to run.
> 
> Update balance_fair() to use sched_fair_runnable() which tests
> rq->cfs.nr_running which is updated by bandwidth throttling. Note that
> pick_next_task_fair() already uses sched_fair_runnable() in its optimized
> path for the same purpose.
> 
> v2: K Prateek Nayak pointed out that the bw control issue described in v1
>      was incorrect. Patch description updated. As this makes the patch only
>      relevant for sched_ext, I'll carry this through the sched_ext tree
>      unless there are objections.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>

Looks good to me!

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
-- 
Thanks and Regards,
Prateek

> ---
>   kernel/sched/fair.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8323,7 +8323,7 @@ static void set_cpus_allowed_fair(struct
>   static int
>   balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   {
> -	if (rq->nr_running)
> +	if (sched_fair_runnable(rq))
>   		return 1;
>   
>   	return sched_balance_newidle(rq, rf) != 0;

