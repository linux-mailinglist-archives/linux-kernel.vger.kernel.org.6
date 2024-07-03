Return-Path: <linux-kernel+bounces-239546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911859261F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2262D1F23A07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4271817A58A;
	Wed,  3 Jul 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HsbIPUyl"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23C1741DD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014025; cv=fail; b=jcUYuWpj76ypSbNM/Ius6vx/wUDOILghb1Q57kcolGE1KPgUN2Sof3BcbXY5LCwoYksfhWyVc1p2wS5SzrFP01jZ780UQ+jduSGDjXHP/Uepayg/02/wydFfYrCxYnt5jht5tNx0ZOVoDpjYIepdpbxVSBpYYJE6dB5jSQlfuvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014025; c=relaxed/simple;
	bh=QxWzvIVtuyVWh1VQnH2GnTpDzQBmnr8i9d7ILSL9XJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FkrGLNjDHkq0JuIl9wIgizOsV35RuXmToLwIDKz3AlM+W4VgyFvsl8HAPyxfgxgqwtDYcLeMXjioADeg6mjE3EpY6HV/wHTWdI0QYcFui/Xpc/22CLOmnUDpLoyZ0a9aa4VQtFSyGQ/F7+T59fjigv+zKcshjPGBPplKOMydW04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HsbIPUyl; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgoOeH/595L2xjt8rCv64vs3ivgE3d24ZZXGWX36cIIxVx9ZfwzcZgNpl/4EsmN83wHDVG4+IuEhqkzALDvaRMxt019ZBYsTWg0ZeAgdbTqTPEz8OJFj7YNG0ueZM7DyT1dF/SjuUUsaWp4ASXzv1SjHPZA80Z8HFHRSXoZuJ0Dtc1NzIfF6Hhemg1z5g/xlYS1Ci5wfEE6BPsBuwXWfkCPM5iY3sQo3MyCPoNXMLbzw1aoBKIgAQigX93oZM+wns59jNxEbwCsdrM3RsQsknkHt8sBsKWyX5yQmnW3ojxugeamNphSGdC3L1PWXKa5o98p0MTmANKyqhnw9xONLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSI1329oCwQx6IcHF8T527BDaFNrXHbbJlWG0CbIMnQ=;
 b=k0SM2W2vL5nm/Jr/8hPJ78/og6RAh/3rufFyqrPs6nPen3Q6Qc+4BVyv9Co4t+Eb7FSiWLUWqLDkkYdFNMfOegTbC4bov7yjsofBcyjqn/oLFKL+0Cfd7pmFmE3FHfE84HpDCSwcRMleF2TDuIPrNzsWWyp9EX4qM1A/9l1V5M396GPcYTgRAUwyhn9aBQZG9xWAPeAoo2sfpOQ9p809crq3PuEKBHDNma0GWsbVMikZbO/GYk7a1W4fWVL3aFanoSCyeJ2Kw+3MI3winRiB5vKQ0ejghz/pU0gUD4q82I70ZvQ3FWWAsY9iLw1nbUOVqmYRoVZxb7mAV5rbMalDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmx.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSI1329oCwQx6IcHF8T527BDaFNrXHbbJlWG0CbIMnQ=;
 b=HsbIPUylmV3BBL9qRJGnFtWI/OqBtwkGXEsAmzYNoIQDMdWxuaZrbePbCAnZCbBbItHfbIfgS5LQZfObu2FRgKXT4zf8FwzmWf4IHiaDn///XErPkaTP0zUHcXD8F7d0mpZOgyMIamHbZwad+zSPz/FToqmrraAQnaW+JBXcf4s=
Received: from BN8PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:60::26)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 13:40:17 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:60:cafe::a6) by BN8PR12CA0013.outlook.office365.com
 (2603:10b6:408:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 13:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 13:40:17 +0000
Received: from [10.136.18.229] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 08:40:12 -0500
Message-ID: <8c4f0bf2-0e8e-b94e-070b-47dbd407b70d@amd.com>
Date: Wed, 3 Jul 2024 19:10:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
Content-Language: en-US
To: Mike Galbraith <efault@gmx.de>, Chen Yu <yu.c.chen@intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Tim Chen <tim.c.chen@intel.com>, Yujie Liu
	<yujie.liu@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R .
 Shenoy" <gautham.shenoy@amd.com>, Chen Yu <yu.chen.surf@gmail.com>,
	<linux-kernel@vger.kernel.org>
References: <cover.1719295669.git.yu.c.chen@intel.com>
 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
 <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
 <db81ba7fba622e2a1b7186e66471cfb9ad8490fd.camel@gmx.de>
 <ZoLDxQlTR7fxoXWs@chenyu5-mobl2>
 <683663e3-cef0-bb45-e1c7-5bf1cf44209c@amd.com>
 <4e28fd17d7a2f7146aae10a76982f0e58b22befb.camel@gmx.de>
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <4e28fd17d7a2f7146aae10a76982f0e58b22befb.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3ea10e-c719-44c3-8b9e-08dc9b65acc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkxEb2J1dkh1eEZ3azB3SHFTSitTVmpQQ09YaUZQbmZkSWFSb1lOVXN6cllu?=
 =?utf-8?B?RjdWNmJPY3ZQNWM3aktIV2dqZmFhRmNMNXNtL1MwekJ2ckptTTdVS3RLMTVB?=
 =?utf-8?B?L2NpdVVjdytzL2NMZXdiVVJIcVBOT0Z4U1BMcStjWHRldWNOeThFWnhNcUtV?=
 =?utf-8?B?R0Rlb1RFS2xHK1NrWk05eWVySE00QmZrRG1kd0tEajNiZ0xRc0VDWTBZWGZJ?=
 =?utf-8?B?NzVwamg5UExQK3dXcjBESzM2QVVYemVhNjlJOWNpTnpLcWxpNVJUdkQySGY3?=
 =?utf-8?B?d0MvUHRaaVdxdlJjaVlPZ2NoWkRSbWc3aXp5UGdFNHIrZ3V5NVE5em12UzI0?=
 =?utf-8?B?ZVg1bFZlU2hlZitJc05PYjN2R3RQZGtyU1p4aHFvYVhsTmdLeDF2M05wcU4v?=
 =?utf-8?B?MXNFVTZhamNxOWlyNlNkL3lQMHdxU2lBaHM1RWI0bGVNa2V5WmxwZUdCdUlS?=
 =?utf-8?B?RkNTRVFYYVhmUG12Szh5OWNXRzFUSGY2U0tDNm5XaTZYZ0U3aXVPVU1YeXJT?=
 =?utf-8?B?ZVNxRGNuUUdCUWVJT2hwLzJyU090c1FUSWlMcmNFNkU0c3NDY1AxYnpLMlBk?=
 =?utf-8?B?SEd3TEp5bDBzbi94RUxTTDY3YldwRmVDMGFXeTBtQ2tReTBFeDdJV0xaL04y?=
 =?utf-8?B?ZnNLb3ZZeDVzb0s0dkxacDArWUhxWlJBSTBQVE53eVQwM1JLdGdGb2pjMzc1?=
 =?utf-8?B?TzRuQ0dlM2dJWC9VaUI3QU9tQS84bCtOU25KWmNqQk1oSDdWbXB4anMyOVB4?=
 =?utf-8?B?OVZZYnBxS1F5ZVRMbHJ5cTVpdFFXWnE1c09ieUZ0NEo5QS9EVzBrM2V1cnFZ?=
 =?utf-8?B?WGtOY2xienZJZTdMZU84M2Y2R2I3SmV2cHdMbzRVazVaaTZhQ2F6VjBOR1RG?=
 =?utf-8?B?dlgxUnp1eWZuM0d1WVBNdVBuazJGNWxLZ05obm83KzUxOC9aM1RqTGs1UEox?=
 =?utf-8?B?MVFobDgwZklwbzZQS2g3bXNKSlZPMlNUc3g5aVVIaC96dWNwOCtLMnFKRUo5?=
 =?utf-8?B?YWhlQWxZRk1vQlRNVnJpdDM0S1VaNmxmV0g0aFBGYW1nZnBqNFlZci9NNFF2?=
 =?utf-8?B?Q3BNd01TaWJVQlNtd1lJNnAvWFVBVUhXYTNMaHFVVlY2WlJoWnJGUzRxSDlp?=
 =?utf-8?B?WlZycnJNZVhoVnNBR0RiWEhPTEhWM2xPa3RtWjB2WnZXSXFxSXpycEVjSkd5?=
 =?utf-8?B?L3hxcGFmSEthbzVWd0ZCb3A5d1FWVi81c0dob1gzUlJubHNYTlVQWHhnZG1N?=
 =?utf-8?B?S1pLR01CWEVTUUVEenJidGJtT0pGTmdobUcyUFcrb0h3aVJCNUtpU2hVdmZX?=
 =?utf-8?B?K0lLTktLZnkzbm51eFFLdkhPeUprZ0hHV3pBWHltdVlUdldDNEY1SG1HUWs1?=
 =?utf-8?B?c0tDWTVscSsvamp0eVdOdTVmdzlSa0VSU25wWVZVVkkvTW90VUhDMTg1SkFI?=
 =?utf-8?B?c2o1Um1CZXFjZ2x0cThOdFBIODhNUGFCODNiQjA1TVQzNHI5by9mWWwySkZy?=
 =?utf-8?B?S0Y2Z0QyQ3JNajlGVS81UlNFa1lSOWxaVU9mS1pWa1RERVV6ZlY5TWpCUHdI?=
 =?utf-8?B?ZWVCVXNpam5MamowdFUxR2VTTWkvMlFkcEswVkxJU2tJVFk2TndORkU5ZXhi?=
 =?utf-8?B?cHcrNmtMSWt6NWV6RW5iUHpxWi9XOU14NnRITEVVV1dCbFNqUnB5MnMyVGdn?=
 =?utf-8?B?T1loVVlHdG5OOUhOUkRrWjVLSTN0VUp0WlkwL1lqeDM4T3BRbUN5dnNTSHBW?=
 =?utf-8?B?eGlLQW9vT1JBbjhxV2VqYmlkaXBRalNhdXJ4bzhWY0tYVzU4N05xZTRXN3Nv?=
 =?utf-8?B?TVJDYXRsZnVIRndiRW96NmgxS2dwL3JyOGpCb21QVmNSaFJYZEhSN3Z1SGl2?=
 =?utf-8?B?UDhqRm1oWDZodWxLR1Bocm5TNjhEVENRWHRVQ1FOTi9QQjRGT0hkNlZiVGJO?=
 =?utf-8?Q?x/u1S4llJTh/AD14jMZpoefZWqISIWFK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 13:40:17.1772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3ea10e-c719-44c3-8b9e-08dc9b65acc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579



On 7/3/2024 5:27 PM, Mike Galbraith wrote:
> On Wed, 2024-07-03 at 14:04 +0530, Raghavendra K T wrote:
>>
>>
>> On 7/1/2024 8:27 PM, Chen Yu wrote:
>>>
>>> A thought occurred to me that one possible method to determine if the waker
>>> and wakee share data could be to leverage the NUMA balance's numa_group data structure.
>>> As numa balance periodically scans the task's VMA space and groups tasks accessing
>>> the same physical page into one numa_group, we can infer that if the waker and wakee
>>> are within the same numa_group, they are likely to share data, and it might be
>>> appropriate to place the wakee on top of the waker.
>>>
>>> CC Raghavendra here in case he has any insights.
>>>
>>
>> Agree with your thought here,
>>
>> So I imagine two possible things to explore here.
>>
>> 1) Use task1, task2 numa_group and check if they belong to same
>> numa_group, also check if there is a possibility of M:N relationship
>> by checking if t1/t2->numa_group->nr_tasks > 1 etc
>>
>> 2) Given a VMA we can use vma_numab_state pids_active[] if task1, task2
>> (threads) possibly interested in same VMA.
>> Latter one looks to be practically difficult because we don't want to
>> sweep across VMAs perhaps..
> 
> Oooh dear.. as soon as you mention threads, the question of who's
> wheelhouse is this in springs to mind, ie should the kernel be
> overriding userspace by targeting bits of threaded programs for forced
> serialization?
> 

Yes.. There is no ROI on this option (mentioned only for completeness).
also we are not looking beyond process. Rather than "Practically
  difficult" I should have rephrased as Practically not an option.

> Bah, think I'll just bugger off and let you guys have a go at making
> this stacking business do less harm than good.
> 
> 	-Mike

