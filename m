Return-Path: <linux-kernel+bounces-397562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B319BDD63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA131C230B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5064A18F2F8;
	Wed,  6 Nov 2024 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gyQv/Eor"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB3523A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 03:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730862171; cv=fail; b=NUBfVRGzfYQBOYl+hx6VHaUALDiC0XoN8VSfhWh34hRkbwjN//bA0dTPCaLV3dmCsJWiR38GaM7s657OlFk3wUOqAxXT/rKxBZkxPkBVnNNihalHEG6F6fkwvn6LsoMAjI59zjsHs504YfZtF4tt71IOYxsyai9OSok04Yj8E+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730862171; c=relaxed/simple;
	bh=UlK9LAy7b6RzL/qR9dvvksCxsu8DFv40g7sCmnFoTvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FhRyBPO8jG1CayXtzzvEdWKRJ+f5eG0z1L0LMXa1dz7i9wvynMnZCTkaeUvS40A5Cprc2Xr8oTYFpogkWRFdqDGDsTbR0UMKs8dsh1npfb+HLtShJYwnDkp9a/igpjno+I/siNd3DTI5gf3ijpTJGcA2JS9pyXtMx5VJMiuL1Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gyQv/Eor; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhigVRcsY6lE8F5jvaGU+1tbbAr6yy76+mrTXTOZk7ylbAkl0ZukD59Fk7ftYYcZof4VrIkXceaNElNDo96piG945wOwpu7kkfP6yRIs19/zFVbgelLHuzAxX4cw+HTevJhaIe1O0DG4BzdLncNSd2pQ+f2EKAbBGNKjyWs29fKc/77cLFHkNuCms68ujd238FBcp5h+2jK+Ud/PwtqxXAQmT9L7kW9Yi94slwXmH14oeZmgAW0VHKwJMCAo0HYzQ0uA/WUJ/4vqJ18iQOB8WCholjCftyCUr9RixhVszBewzgm0qEij7rFNzF8N3395xKTUpCgKKpFj3fUcwp2FLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sfqii1SvA7rNK0blIt7gsL0JTyJcIPyawvKDcVNYSP4=;
 b=mzV8nQv1MWXzOjVBowOJU3j/iouIPNSTkf3qbpzuVK3cqjZcwoOZ/HC+kiI6bkxNsrdS+EEhiZJhVU7AfWtSu+yk1ppGInHHJ0jLS/bgDhpxSArwGcN8hPLItnV9fP121fDCDhwMesQ7UuWu6hHc6Nbe2ihQtFxvH0lz8qWkjWz2TOAo8h3g2yYqcDysI4HCzsu5JuPEqcqf6kJXH3l48ZdL1st/E88s/J/PTWbqw47HTIvBiy1NSGNQZ0+2g3CEjKUHdAMKJKeLhuH/jFw7Ry9GAQGpXJxcGPVsw2fBDVzMmTRZ9z7n8Xw8hAkvsodgaoLPqyI8qvQSJUvVmOzu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmx.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sfqii1SvA7rNK0blIt7gsL0JTyJcIPyawvKDcVNYSP4=;
 b=gyQv/Eor592o6sWyoQCA7OruWBz0c7kF3IiyUxfJ053QgOtWzFlryIWsV2WhOLCCqZP9NqwzrlsUhCnrNPU42gsfNKB2B9PBLgKzWfXpd+bdHCl/4y7DTekmSbWSJdwp0KXdqzHhnuDE3gvBXX4FkVMKrsJ9vccYEmilJsuOG/o=
Received: from MW4PR04CA0199.namprd04.prod.outlook.com (2603:10b6:303:86::24)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 03:02:45 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::14) by MW4PR04CA0199.outlook.office365.com
 (2603:10b6:303:86::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Wed, 6 Nov 2024 03:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 03:02:45 +0000
Received: from [10.136.47.53] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 21:02:41 -0600
Message-ID: <a8e07694-2b3e-3c5f-bb2e-e1d0cfa3503d@amd.com>
Date: Wed, 6 Nov 2024 08:32:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Content-Language: en-US
To: Mike Galbraith <efault@gmx.de>, Phil Auld <pauld@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<wuyun.abel@bytedance.com>, <youssefesmat@chromium.org>, <tglx@linutronix.de>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
 <20241101124715.GA689589@pauld.westford.csb>
 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
 <20241101133822.GC689589@pauld.westford.csb>
 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
 <20241101144225.GD689589@pauld.westford.csb>
 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
 <20241101200704.GE689589@pauld.westford.csb>
 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
 <20241104130515.GB749675@pauld.westford.csb>
 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
 <b8ed9d5d-4186-4b2a-aabf-d027d183c44a@amd.com>
 <9af1bc3d9b0ddd5a4d672004cd9182017c320ec0.camel@gmx.de>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <9af1bc3d9b0ddd5a4d672004cd9182017c320ec0.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: b48366b8-3916-41b6-9625-08dcfe0f7cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkM0WW44QnJodEZlcXFFdXAwT2ZrYzRBWDFUTFpTbmV3b08ySk16NkRQTzVP?=
 =?utf-8?B?TERWNWluQTdDWEFqUEZ4dmkrSnhkdGVLM2NOSmVIYVZUbllUcVpncVlVOUFn?=
 =?utf-8?B?dUk4Q1hBM2RDeGpydVppQThXeUtWbEpoVEZWV2RFQXpHampnbTQ3K09ueHcr?=
 =?utf-8?B?Q3lFVGd5NmRGeGFTd1FxaTBpYjY5Q0xYb1RwSy8zcGV5OVhDQlNkSlA0RE5H?=
 =?utf-8?B?WHU0Vnhyb2RhUll0Z2NVRS95YWt3ZXhZaUpJODZDN2ZZOVdiS0FRbGo1N3ZK?=
 =?utf-8?B?d3VEbVJCditqRW15dnJQWEhqRmZlQWt5V29sK09ERWE0Rmw3TmZWRTRmV2J2?=
 =?utf-8?B?RUQ2YnNXZW9EcC83SkZ4UWlTY0JvQlUxVWg4YzkreVVuUlh5ZU1pWTRFb2p1?=
 =?utf-8?B?V2d6T0pQWnNVY1BNN1hvZ092c2NySExhZnR0a3V3YkJENG81Z1NCRWlFNGYy?=
 =?utf-8?B?NFBRR216ejBwOHQ5SjdYWWJFZVFtQmFxWSthS1M3a2gwWVU5c2cxZ2VyMk80?=
 =?utf-8?B?Sjdtb3phRHNaalB3NjQ4K0dHdGMwNElyNldqc3ROS3RRQnJWOXE5aGF5eEJB?=
 =?utf-8?B?N05tR1hGUHU0dGdXZGRJMmw2cSt0WjFCTXVBMC8vZWU1NEt3b3Y3VHFreGZF?=
 =?utf-8?B?QUFHVm9kaDcwZ0hNVkZxS1l5ZzkyZmVyRFhQN1NRWnJkdzNUYTQ3RkkyN05G?=
 =?utf-8?B?MFd5VDBCRkw5UEU3dmh5SEdnS2hPQ016SjBNQ0VjWjlXakRUOVBXdnp5NjA2?=
 =?utf-8?B?VVRzS25PR0Q4bDJDbE5XK3c5VG1IL243dmNKOTVPeWJidFBMaTJiQVZDcU9O?=
 =?utf-8?B?cXpyOGhpc1JUbWhuK2MrckFIK1luMytHOFA2eFZZNkhNSGJZdFYxTEt2bWRU?=
 =?utf-8?B?YTYrZ3hBaEpQeWFPbmtpWGZLVWlXUlg4eUZUM3VUUjRPMkwyaU1vRElHS1FR?=
 =?utf-8?B?WmZ1eHp3ZS9mdk4xNlJ3TUZlR1poeS8xT1RQdjRZSzg1TEN5Qjgwa0g2N1Vo?=
 =?utf-8?B?N3VsTTdKMmVzY3dvb0M3c0lvZjJKM3hRcDk5d2RxRDRRQzlobEo3bnFpN2My?=
 =?utf-8?B?Y1M2YjlDTklpTi9FSGxIMXphRzFTTnlPaG5sY1dWY09wcDl0L3crWEhsWktn?=
 =?utf-8?B?VHFFT2lHOGxZTVRERXdVTVArdU1jWThYZjZVVUg2THYxVmRxRlVqTmU5dERm?=
 =?utf-8?B?ZE5OVHcvZVNvc0FIRDUwdkF4NHJxS25iYW9MVEdielNqS2N5NXdDOHhpeE94?=
 =?utf-8?B?V3JQVk5XMWd6OWl3YnZmbXJZQ2ZscEhWWmoxVlJnbGZDcXJhZ05nSHUvQTBC?=
 =?utf-8?B?Nm9IeFZXWWlwTy9xaHpLL1hiRUw1cGFSb2JkbFJJc0lHNGNycTgrQU9INEVv?=
 =?utf-8?B?RUZwdDFUeFE4MW1YSW9TRXp0elZiYVRrTTFBaURyRzZnNDIxblRRcndKMW4z?=
 =?utf-8?B?Sy9KNFlnNHpwM0NYcTNQblR2TzhmWG9pS292blR1Mkk0Y3dPTi9EK1h2S0xM?=
 =?utf-8?B?dEc1ZmVvd1FFRnVrNXd1bGxQTFRlY2NKZW1kSWNwcUJRR1FwQW5uSmxKRitp?=
 =?utf-8?B?MXVPRFU3ZVVLU1h2VHllUU1EK0FtNDJmYnFLOFgwZmZEZ1plb3E4alR3bkdl?=
 =?utf-8?B?UURXWW4yK3hVOVQzT0hpeURZY1cvYnc4V2ZaUGNvOW5hcDEzR1l3Ly9EVEw4?=
 =?utf-8?B?MVJNR2w5Q3NiYytBY0VwV2lYYmdsb3lTRlRLalppZnVMSi90Tk94eDJyNnVY?=
 =?utf-8?B?M1c0aWJpZndvMWUrQ1daU1YxVDhSSmhGbHI1emVMVFEyL3dmbitXd3VjOFRl?=
 =?utf-8?B?VXdoM3dDWUtRVGZRYXkvUjhHVlQyV2pjZlZoRW9raDFMRHdSTmV3eHI1ZC9D?=
 =?utf-8?B?OXVvbVNvUWVDWkZBU2M0WFZveCtsRmpPNkdLQThPU3lwVGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 03:02:45.0633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48366b8-3916-41b6-9625-08dcfe0f7cf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965

Hello Mike,

On 11/5/2024 12:16 PM, Mike Galbraith wrote:
> On Tue, 2024-11-05 at 09:52 +0530, K Prateek Nayak wrote:
>> Hello Mike,
> 
> Greetings,
> 
>> Would checking "p->nr_cpus_allowed > 1" be enough instead of doing a
>> "cpumask_weight(p->cpus_ptr) > 1"?
> 
> Yeah (thwap).
> 
>> I was thinking, since the task is indeed delayed, there has to be more
>> than one task on the runqueue right since a single task by itself cannot
>> be ineligible and be marked for delayed dequeue?
> 
> But they migrate via LB, and idle balance unlocks the rq.
> trace_printk() just verified that they do still both land with
> sched_delayed intact and with nr_running = 1.

Ah! You are right! thank you for clarifying. Since the sharp stick seems
to be working, let me go thrown a bunch of workloads at it and report
back :)

-- 
Thanks and Regards,
Prateek

> 
>> The only time we
>> encounter a delayed task with "rq->nr_running == 1" is if the other
>> tasks have been fully dequeued and pick_next_task() is in the process of
>> picking off all the delayed task, but since that is done with the rq
>> lock held in schedule(), it is even possible for the
>> "rq->nr_running > 1" to be false here?
> 
> I don't see how, the rq being looked at is locked.
> 
> 	-Mike


