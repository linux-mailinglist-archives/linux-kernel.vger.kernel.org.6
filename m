Return-Path: <linux-kernel+bounces-315169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE4896BECF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8181C2221D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9C91DA61C;
	Wed,  4 Sep 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QJyIWRZE"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897751DA103
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457250; cv=fail; b=C+/VIM9HZCxxVKVUPXtJ/nAMw/tDJ5k8cI0pQHP3hb+uE3ID64WUYRakbPoqS2B7DQ56j8ZlOKG57VYu6TUK+dpnZEw1+LWbA+o5akG6awtRWPAd8z1ZeeXrWsJhJbjBPWInd+ERugoNruTWxcDKMyOLro494CHd+rpn3qKpZ8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457250; c=relaxed/simple;
	bh=013AWfC/3vtshl8svbe879rgvSLb/qnAnV1yidQMuXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HJWToYJHjPCrkE4u5qdX2iccC07x49+E2vyHmLfFZvSh6xO0deEjoLdPvd6P0geiAouQ446EcecI3qZKnxzQcMNR9hIb3vM3tJEDMDMsmApun43nPq7c0ayIpnNqrrkcnJyizkLO8gBZOl4IieuiXswPyARpRdCsoPpGl1WTPcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QJyIWRZE; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4d/BR2EsiQELXJQ1KuGzGDRAafphgzFCrXqhuM+QOLJfIExktIPMSmrjMqNDO28jfmSAX1FPwOXO59gZASWa2bqj/k15Ps92tojf6rtHRu/JKCh8xQVbRbd6sXvxCBjEsBXzsMcSBC9Yih+27lE2WjVNaFQ5lw9TkoN3+OcaBxBtJ48Gj2FUEElMKK0Yx7/BMwzDkXL8DVq8Ow0Iu30z+irMGdZFWA0ClZDRzJrT02eSy/8B8/sUeS1EUp7Fdjrt5/zks0p6GfmMCm9ghjcHaV+ClumA28k39exNv5/6SAoGq3hikQMVWpcSZoaL7/kmPm/Tc5cpoDKDfd4i6lx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jarff6wLT5nbShdpCePPKvEgfTkGc3mT8wGOKk3+xUI=;
 b=cSgvrq9DAW+KOuNII1ckXl3g+OpKOvaoDYG1EhG6my1lcWup/THCLAmjaqcvItyJXfZ7oOmvPahd2RPYdA0bbkyDjE8lScVlhAA9KWGj6t+HWyJ6W9pBoOI9XOeIZC3rw949bApl/NMVmt5hKQhGf4rEvb2HQMXo4yDcJBwAPkMXpMjJnkNVKmBiGptT1+BysEhi3dzGr4/pwKVByzsQysZzQcfcdNM5xM7LiLlkl5+l2gn49plVF75XABJbyrflaPdBlCx5tb+VA3nkT75l+co/sX5mzH6JPd6+4lQauivFlgYQRyAEGWdVYWrDOuYY0mmijpkEGhaHEiWvGt5D/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jarff6wLT5nbShdpCePPKvEgfTkGc3mT8wGOKk3+xUI=;
 b=QJyIWRZEBjlSd51Hd9ag4tdQUNhpdLXdq6S6TmqEtIR5gnTSruL98E3h4NKfMmBudx+b/SrIWZrN9SMvrDd/1hm21Hy5BnQZdao7jGm5SytLKOr41fQqUEeccyaKsOtNOKokZ8DjPWk2yCWjbbMd+VRRH/kKz+YlUAR5r//0Ou4=
Received: from CH2PR14CA0006.namprd14.prod.outlook.com (2603:10b6:610:60::16)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 13:40:45 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::11) by CH2PR14CA0006.outlook.office365.com
 (2603:10b6:610:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 13:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 13:40:45 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 08:40:37 -0500
Message-ID: <8a433d3f-2b8c-1363-8876-dfd8268a9de3@amd.com>
Date: Wed, 4 Sep 2024 19:10:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH v2 4/5] softirq: Unify should_wakeup_ksoftirqd()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Leonardo Bras
	<leobras@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, Rik van Riel
	<riel@surriel.com>, Thorsten Blum <thorsten.blum@toblux.com>, Zqiang
	<qiang.zhang1211@gmail.com>, Tejun Heo <tj@kernel.org>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Caleb Sander Mateos <csander@purestorage.com>,
	<linux-kernel@vger.kernel.org>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Chen Yu <yu.c.chen@intel.com>, Julia Lawall
	<Julia.Lawall@inria.fr>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240904111223.1035-1-kprateek.nayak@amd.com>
 <20240904111223.1035-5-kprateek.nayak@amd.com>
 <20240904121513.GH4723@noisy.programming.kicks-ass.net>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240904121513.GH4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acd0925-7651-4b1d-04a4-08dccce72d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ym5lanlVVmUzbXY1aWNGdXFyU09Tb1h5R1hhMm5YOFdLWlFKSERpU01RaG1G?=
 =?utf-8?B?dWVaemN6N2xKWFVvbmZydHY0bjlMZnpFd1daMDBrVDdBbnUwbmNWVjdtS3V5?=
 =?utf-8?B?NUJEVjJJZFV3UUZQaVR4cXgwUmxUMEh6VGlGVXluWW9vOEhHMDZ0SHYxRTlj?=
 =?utf-8?B?OUxJQThISThJRFVPMkhQbVdxeUtZbUx1d1dBdFFGV0NSa2FvZTF5ZGNUZlMz?=
 =?utf-8?B?QmZBSEQwcVhncEFZdGZnK1NjOGoxYzFZa0VCQ3Q5RkpNcGcwb05obGxSSTNP?=
 =?utf-8?B?L0drWW1IM0V3UVB2Zk1iN0xIc0VWd2c0aUZLVlVNVGt5T0Z2c3JINm90dnJK?=
 =?utf-8?B?b2p2aUM5RWpsaDFRMGI2QmR2d3NZOWxWcDJmQjdXSXJjZXRnZERxV29JdnZS?=
 =?utf-8?B?TjR6ZFQvTnBOekRkM2h4WlRpS3hzY0xGNGFDc3BiK25zVzlob0hXbW5ab1Vr?=
 =?utf-8?B?ZVc0cTB4SXBLRWUrbUVmcHpKUzQ0TjJNdEpRck1XTks3dFQrbWREVnVLQ1dk?=
 =?utf-8?B?RDJhK25zaXhaUWN3L1ZBQ2pnT3BETStPbWZhZFpsd0hoVFFCUDg4eHNwYXA3?=
 =?utf-8?B?WTM5WGF5SzNlL0x0Z2w2cUx4ZTUzYURSd3dtMkdJUjZmK0w3UFNHL2pYeUUy?=
 =?utf-8?B?ZEZxV3k4SFFnUll6V3kzTjVzNkhmS3UyRnVLTEl3WkxwU1FQNGtxK25yeXRm?=
 =?utf-8?B?TFNHV0dRS2E0VkxvSlNHUUIwd1JRcU9neHdIcnpvQ1c1ck1HeVozdjlNOG5I?=
 =?utf-8?B?cjhHbkE0ekw5aDJwRm91dFdZTHhvZHVPMmEyem1xQWpNWjY1Q3FvOWhlNGpa?=
 =?utf-8?B?eXdBNHdHSW9tVjZXM3RDcU45c1cvSU9hcDk0SHNvYTZLSGhtbjhVVnJTb2d1?=
 =?utf-8?B?MWVrQXJmWTJodzA5U2lJc2xrOFZPVUZyeVJ0ZHBDQ1Z0TGovUVZHSGQ3WWg2?=
 =?utf-8?B?dk8rVWZkaFlrem1zZ1ZvSkNqZEZWN0w0MHRVbklGeXJvWkNFWk1pYlhWYXFX?=
 =?utf-8?B?ZVVNcFh6V2NCTFhtZTNIZEREdFhLSVZlaEEvbnRJT1Q4NC8xL043aXNpTmww?=
 =?utf-8?B?a0Q5WmFsZUF4SUtyUGNpRGtrNGtWZElXdXZiSmVMVFM4RTdtK3pqamNOVGE4?=
 =?utf-8?B?UklvbDY0TWE1SVRkcXpYcXFpUVg4dmxJMXVWRlpaNUJLRDFQMWRtajAxL3pH?=
 =?utf-8?B?U0I2aGxKbjVlS3hrN0h5bitzSmV2OEdIeXdwblhHdDJPc0hHRXhDVTAwaUF1?=
 =?utf-8?B?Z3VEMXl0S2VDMVhMM2hYaFVsVXJEeWJtQXNBMVRFSWNBMm91U0ZLNlNYaHlV?=
 =?utf-8?B?VjIyMWE3TjcxNm5WMUJQeStDYXcrRTdpM3E4ODIwbDhGaEwzK1ptQzJ6R3l6?=
 =?utf-8?B?U281ZUtIRlBwNVZscGJBL09OUEVUZzlOYzNBaHprT1JzbmwwUmF1ZmozQmlp?=
 =?utf-8?B?WlVEbDhTMGdZY1NWbDdHT3h1U1RSTHZSRnlXS25XVndEUTMwRGNWSVB1Rytr?=
 =?utf-8?B?aGJxaFE1a1FmN3JEeHo5TExFdGlRTlpPT1k2Q01EckZSb3ZhOFZWbUJUS0I3?=
 =?utf-8?B?Z2tTWHJqMnpLZCs1MFZleFhDd2F0RTdkOEFIL2M1R0NPc3FHQUt0WVlFcVRL?=
 =?utf-8?B?ZEovMjBrWVMzSFRTZmZWQU1ZSjJ3KzlJT2dSRzkxUlZOZGwzNU0wRktaNFFi?=
 =?utf-8?B?bTVTZjJ1SXduV0JsZUd4RDE1ck54dTVYTWNiYlUxM1FxUDRKN1huMHRwelhq?=
 =?utf-8?B?ekNFU08xeGxtOW4vbkhkMFpKVnUzMkN2Q3VQQ2FieWoyMEVKejZTa0M0bWQ1?=
 =?utf-8?B?RnNLYXIwQVBpYlUyYXQ4UmRmR0ZzaDFxdzkxSS9pR3YyTlNmRjZSRkpjV3B4?=
 =?utf-8?B?S2d0MEtOQ1dsOXZSdzZNRDMrdzEwN25vbGVFM2RHVVhTc3FpVmZSRmhQcjNa?=
 =?utf-8?Q?vFhYEKKHL1UDDoq6cXGvgD5QY+eb4tUO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:40:45.0698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acd0925-7651-4b1d-04a4-08dccce72d73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416

Hello Peter,

On 9/4/2024 5:45 PM, Peter Zijlstra wrote:
> On Wed, Sep 04, 2024 at 11:12:22AM +0000, K Prateek Nayak wrote:
> 
>> @@ -118,14 +101,40 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
>>    * the task which is in a softirq disabled section is preempted or blocks.
>>    */
>>   struct softirq_ctrl {
>> +#ifdef CONFIG_PREEMPT_RT
>>   	local_lock_t	lock;
>> +#endif
>>   	int		cnt;
>>   };
>>   
>> -static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
>> +static DEFINE_PER_CPU_ALIGNED(struct softirq_ctrl, softirq_ctrl) = {
>> +#ifdef CONFIG_PREEMPT_RT
>>   	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
>> +#endif
>>   };
> 
> With the exception of CONFIG_DEBUG_LOCK_ALLOC (part of LOCKDEP)
> local_lock_t is an empty structure when PREEMPT_RT=n.
> 
> That is to say, you can probably get by without those extra #ifdefs.

Thank you for the suggestion. I'll drop those extra #ifdefs in the next
version.
-- 
Thanks and Regards,
Prateek

