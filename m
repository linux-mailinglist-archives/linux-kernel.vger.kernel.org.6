Return-Path: <linux-kernel+bounces-248078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A7B92D82A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4170E1F24236
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318C01957E4;
	Wed, 10 Jul 2024 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TUj2P34r"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4A83BBED
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635638; cv=fail; b=qgKyz7iCS+Y0o3/+6EGUfn5GJh6QOxNeMZxRzVEEQ44w6PihLZVwTaLPSuTzkID+dY6YlE2Uz1Qb8d1T3jZd70JPC6y7imtWxvJzwR83I9+vjwgiqFtQrC2xE/aDzyS4h/GC3lD15CjS8gsH/hEbOofBGDceXRee/CtPF+q1oQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635638; c=relaxed/simple;
	bh=SeJ9UCdZW+AkOa5fJCHtg6DGiQ5gCT6gScf5LJ29Dyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tR4ABpCMvQ46PLtb6Wi+nLDKwbv3fqEoPzOKr86a7+XXfkC0sYzwYAqJykgU8FntdRAY/t3lrm3Voxfd34Efr70prXHVVQNsYRk1A8PafdeYHMS9cp95arOGDS0VYu1aobO9ZIBsSH2V51qNictUBVu5l7/iET0hWMA2HU7Ir10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TUj2P34r; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdBJEU4DYF5uVCSkDcjF+5KxI+UrN77BEq1El+E+kL5MsCxHlMxd6QgutN635RNDX3rdDrotmyNnWbUosIaFowGlGEYyDeW/wfRiQK42v1XTWDqcPtsUzebWZh/YoDhxwH83yU77tld2bN+IMLh3ID178BmeMtoWmbnxwfHwEcRJAyYrVkNl/iwUaUsxtHV4JHRs3QNE8yo+njPDGhDxzwMwysQjj3CDaDVgB5EXlVwi/6iuFZ/aTZisPlmYQSePowZe8fJjA2MZhO+iHoW16MTB4H7ov0xtaJFnkRwON/fbvt3mXS62i/3ZdTdzY4ySqotpZg/DdFRIPYJFxQ1xYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyXBkT6N4dcr1+lhOzxXqG+6RrGXAWsz56nQn3oIsb8=;
 b=ikSuQY8qBhwqZpV0QekmnjlmdzLK+OdkvV34fDvfd2jdLYWAXILCPc4cAAgyIEk+wgigYz6h5i+eKM3cYnSyTxBtXorTeny7FFRgeuyn3LdyeBz26ZzsGRoIO6nFbff/iyWVpbBv4gS3Dp62UQ/YfPk9skAQClHoPhtvp5N2g8OKv2CG/zFWfoUqBnfQUkBtVApkducF2CkgLU8/2VUG1djGEfNgXsLRpNOAcoEFVjNE4nldNx6BuHFMEvaibzzSvDcKFE6/JXz3LEojCfBbctwu9Ur6ltHLQDg6HvllCP03cwnQGq1Qz90BHWWYROLl5yVutgQ9oodpuhTHb1qiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyXBkT6N4dcr1+lhOzxXqG+6RrGXAWsz56nQn3oIsb8=;
 b=TUj2P34rY6MIIfkTNi/VXx1xUEG5WkxNYt1W1c/4CTio0RXS3qh2WqXMu+QwBTc5ZSrMpegzpEG4sNmVGcIBag32hGbVseaZFKYqJOujnmfjJOZpcceOjYOj459/qIK5XpBojBBuvODVGHe8h8eI7sgM6BpUZ9LT9NtjnlMY4yo=
Received: from BN8PR03CA0018.namprd03.prod.outlook.com (2603:10b6:408:94::31)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 18:20:32 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:94:cafe::a4) by BN8PR03CA0018.outlook.office365.com
 (2603:10b6:408:94::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 18:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 18:20:29 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 13:20:21 -0500
Message-ID: <7acc5dd0-8cc0-be08-b08a-6f36c1964961@amd.com>
Date: Wed, 10 Jul 2024 23:50:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 3/3] softirq: Avoid waking up ksoftirqd from
 flush_smp_call_function_queue()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Imran Khan <imran.f.khan@oracle.com>, Leonardo Bras <leobras@redhat.com>,
	"Guo Ren" <guoren@kernel.org>, Rik van Riel <riel@surriel.com>, Tejun Heo
	<tj@kernel.org>, Cruz Zhao <CruzZhao@linux.alibaba.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Zqiang
	<qiang.zhang1211@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, "Gautham
 R. Shenoy" <gautham.shenoy@amd.com>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
 <20240710090210.41856-4-kprateek.nayak@amd.com>
 <20240710150557.GB27299@noisy.programming.kicks-ass.net>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240710150557.GB27299@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 5841cbda-8c8d-4e64-fc4e-08dca10cfabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STRaZzZFczJFdG0veFVDSzhacEZIQWVvOHVoOHF1NmlXV1FJWkxhTDgrTUVK?=
 =?utf-8?B?VXova0d4b01leWVjNWdObTVsemdLdi8vU0RVRnJ5cFV2VjIyRlBtZUM0aXAx?=
 =?utf-8?B?aElMSWJrMURTcmtZNjBRd0c5aW5zdS9oYzVjdXA5QkJWTWF3aVVoMTh5aGt1?=
 =?utf-8?B?aG5EUWZpYTJEbE8vV2tzUUFxejladm11YnFZM0ViN0xNTW95clV3NWdGMU5N?=
 =?utf-8?B?aGJMRDdvanpZSEpwR3doZ2Q1b2tkRjZvMENDMURiWVJ5QlR4TUoybjBsUDEx?=
 =?utf-8?B?ejhZd0VFaHd6b0laSkxjQlJ1U2lCMHgrekkyd0xob0RPOHBkSTlwV3lWUHAy?=
 =?utf-8?B?ZVdEdVlkaUd6djlwMFlJR2oyRjBuWlliWUMzWHZJUzE1cWJxK2N3dFZYQWNr?=
 =?utf-8?B?T1NzcUcwbVhmeFN5UGNZVEpJdnVGZklNT2RhcThHVEZHOC9mREd3MnE3aWpk?=
 =?utf-8?B?R2ZaVGloU0ZHbnRRWWcwNVkxdDlYKzBEbzUyM0doQ1psS2h4bE1iV3UvWEVF?=
 =?utf-8?B?YUhPYUYwekgya002VHoyblQ0M3cyMkU3UkFzR2JqRFBYbzhBOFRSU09ndzNt?=
 =?utf-8?B?WVVOT29pQTJSVlZvTFJmZFNhL2tEd3VvUmE4b2JZWEJLSVA2VjM5eGxCYkRU?=
 =?utf-8?B?S0ZENkZiRW1ycHVTN2k4YlFRL3VkWGlJTTZOcVhpNzdjaGc4WmFaM1kvTWlO?=
 =?utf-8?B?d25FNGFVNFM3bU00UFp6WEtFSWZKSERPWitpWndENzhCR2h3L21FWVdhZnlB?=
 =?utf-8?B?L3E1UkszZWdwVlZJMkpUQ2VXMU13dEUvdVBvQXI4a0FmT0JoM2F4Z3A4VFZw?=
 =?utf-8?B?RmJxUGdmODhMSlphaSs5QTFsRVJyOGM1NFY5K2Y3VzBvWFFyYzIxenMrdjVN?=
 =?utf-8?B?OUVOb1U5akN1Z3o0dGFQbFdIcjU3OG1PdjdzYkFsWG1DcEJ0UTNzbC9lM0d1?=
 =?utf-8?B?OTNMbWNHQmx6TlZxMU9YaWoybk5yL1lIL1NBMmdTcHQ4NnZhd0F0SWR2NnVa?=
 =?utf-8?B?RE9iSHlHZTFDUlhSU1NXMU5BdXBNcm5CUThZQmRnbE0yUW1KaE1XTUxQSHJ5?=
 =?utf-8?B?VllVRXBWcldLKzU1R3BCaXdHcUQxK3paY1YvMVFvQU51YnpvaUVNM2EyenVy?=
 =?utf-8?B?ZHBoOTdSWWk1ZzM0RFdqZUVkTDJpT2tmdlNpMXF2VlVmdERJVll5UDhpS3pl?=
 =?utf-8?B?enltcEJvZ25OOXNONGFOWTF0YmN2VHpIL21qUzFYVFVGQjNPL0EvUWlaNVBx?=
 =?utf-8?B?UEkzMDk3dkZxTzgvRkFUUy9YbjlRUW0rOVFBL2NJb1FvS0dyRDRCRlVMWHVq?=
 =?utf-8?B?S1lXaUxiME5xTnlsVWRTK2x6b3hoTmtEZVFzUWpBdHVaa2tsby9ZYnVyT2Fq?=
 =?utf-8?B?S1o5MmJFTU02YnhSL0FnZzBIaHl0VUZqWks4WENETmVjak9KNHVVTGFCRG5S?=
 =?utf-8?B?b2IrQVlpTDZreDVtMUNhSGoxU1lSU1dieUcyR3U4M3o2cCs4MVFXTTZOcm01?=
 =?utf-8?B?Ri9pMmNraFBjUXpWMEtzMmxRdTQ2YWZnUUl5RXB0bTdiSC9EMmN1V3lzR00v?=
 =?utf-8?B?WVZYMHcrV1daK2ZYYkdLR0FON0VGano0MU5FNnpXR2YrK0htZWk3a2JCNEVz?=
 =?utf-8?B?c3NLRkNJektSd01FM2hyR29Gb3QxODdCUm40MjFoVTVoV2lFWWR2cURZM29I?=
 =?utf-8?B?eDgzSjNlU2I4VFRjMk9DQmwyemhyYThIRHB1ZEtla0VFT1FSYmpLRnk4eDBJ?=
 =?utf-8?B?VXJSWkRkVzRSTlZwd2dRTHUrZmo1RVR0S3o2UWZlaitDQmFJUWNHMGs0ZEtm?=
 =?utf-8?B?RFdQcmhMcklpVE81V2diQmJtelRHS3Y5SkVoNVNrMHJua2JDNHA4WFR3dkJZ?=
 =?utf-8?B?OWhvWDY1OHB5OHFOU1VXMld2N0dORGRJeVJhY0FpUXVQcGRrM1lud1Uvc2dj?=
 =?utf-8?Q?Q3JGy1uaLTaf2IPKf3OcTPujypWcoRyW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:20:29.5727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5841cbda-8c8d-4e64-fc4e-08dca10cfabb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011

Hello Peter,

Thank you for the feedback.

On 7/10/2024 8:35 PM, Peter Zijlstra wrote:
> On Wed, Jul 10, 2024 at 09:02:10AM +0000, K Prateek Nayak wrote:
> 
>> [..snip..]
> 
> On first reading I wonder why you've not re-used and hooked into the
> PREEMPT_RT variant of should_wake_ksoftirqd(). That already has a per
> CPU variable to do exactly this.

With this RFC, I intended to check if everyone was onboard with the idea
and of the use-case. One caveat with re-using the existing
"softirq_ctrl.cnt" hook that PREEMPT_RT uses is that we'll need to
expose the functions that increment and decrement it, for it to be used
in kernel/smp.c. I'll make those changes in v2 and we can see if there
are sufficient WARN_ON() to catch any incorrect usage in !PREEMPT_RT
case.

-- 
Thanks and Regards,
Prateek

