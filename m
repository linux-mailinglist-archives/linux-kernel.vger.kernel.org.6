Return-Path: <linux-kernel+bounces-337952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5688B985164
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91F41F260F7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A414A095;
	Wed, 25 Sep 2024 03:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uxv10dFw"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A168E148304
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727234329; cv=fail; b=Vje3tdQYCQqwgNea+mmJBn/e7G9jUzgY93IY+ktmnAH98FAl2pczQeA6CEO+zAOo4npPAyCzvFz1UHLuWhT/wXGAVvTEFBnhr2u9BWTgK1O1CGgKdwEJ0MusDx99xh5KoQ2bJe0TO8VudUz77gpuM5OUBx/E5TG961khsjVWyzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727234329; c=relaxed/simple;
	bh=Xbmd94M2+52Djq1RF/ET3i4dYIP60i22VWR1p2NW/Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WaKdJ9SEHtLlXfcJ1oxIwgh2LdSZrwUgGBozwgKPo0RcnStTKAp6ASawlzxVtjvVkJNoboKKdYQ9e6VhJKft7cp4l8ctMSwVj8qxuxDVYyW8srwK0EULcLXiaWzEyp3AMlVy/gTlwDFpAm0XAuVJzbIPAy9b/aHvfpZnv+YDmEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uxv10dFw; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaVqSnQvP/YbmZTI1SmFp6UX6h/1u0B255dFHZFLJ73PClHmhqIGCaWeBICi1+mnOiTiwLPInqqHkopBNVbq8tXvtjO2jqrKlO4WHzRfn8rXOCuNubwgfXS/aNGzmITSLUe9P1rZskntiJTcvkjxoAhu8BKNQVRZxEV6ELGo/bh3Sfe8sfHQdQSnM4tWlTu4zLuY5iGt0xoIy7UJ1zovJkn6bJot6nYZ0VvgPaQU+M4RUJ+pMwzvHNYiJ+5yN2QtG0T/KlB0c3253w2x5Wx5ImrFEoldGmxEPrvDUHO+e/fYLsJ5x2UJCaKShPbEwfyKO/Mtn5AAdKxQCR6S2mtqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m6hfsB8PYP6b9qaHDqRR3ccct9QoaMMwth0pc+KHPI=;
 b=IXeM7HLkSjMzZvRHOPamgBgkuoEWqf2DPpxxvlGsDgzOcevntDiombvMf7YnNSNcN+iZvG97rRbzli07B7hegjlVUjITDmkMg+yCsBzym/TRYQU8HlGltrNC3bevF9Hxub5NUsbaa0ydSlrGFBTX2+TdHGCpb3yAFxEETSAVS3OHWGQxL+hVq4hNH61LaESWeIC4eijHrIycfN8UybnAdRkYMxH8RJfwlk+f7IY07hp37bwLHRPUB6dFUyiGQD9Ji+lF+v8Hnlc49gEnML5IDv8hCTQR1/SJSKgnuftm9gx2POiGjUtTaHv/ApMgUHg4TMRefDFUJsu/VINYW9LHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m6hfsB8PYP6b9qaHDqRR3ccct9QoaMMwth0pc+KHPI=;
 b=Uxv10dFwZYCFQ8x/gPzTGkuKT/i0scsOZD0JofTRMQ4/aBQB3V0awtOG/GLkKffR8DeqikQ12hSVK5xCQyQhKsPzIlk8ewQckvgwjyoMcPBCFx+roMuUVDLK/u8+alUPdWRrw9iyfGQ3anyEbdSDAkPMB2rgIc5IhMCiFt/wxU4=
Received: from BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29) by
 CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.26; Wed, 25 Sep 2024 03:18:42 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::65) by BYAPR01CA0052.outlook.office365.com
 (2603:10b6:a03:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Wed, 25 Sep 2024 03:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 03:18:42 +0000
Received: from [10.136.36.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 22:18:21 -0500
Message-ID: <ef409c01-1588-6e3a-aa3c-f142c80657c7@amd.com>
Date: Wed, 25 Sep 2024 08:47:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH sched_ext/for-6.12-fixes] Disable SM_IDLE/rq empty path
 when scx_enabled
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
CC: <void@manifault.com>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <sched-ext@meta.com>, <peterz@infradead.org>, Pat
 Somaru <patso@likewhatevs.io>
References: <20240920194159.158152-1-patso@likewhatevs.io>
 <ZvGMjn1Va3aNbieH@slm.duckdns.org>
 <3e6fdedc-a87c-ff8a-a75c-5c1282a122b5@amd.com>
 <ZvM7UntdPJKioomO@slm.duckdns.org>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZvM7UntdPJKioomO@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d4bfcd-3611-4ce1-3dc3-08dcdd10c200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0RKbjdSYTlMYmZ4aURhdFVJNWkybzlGOEFQSmtZMnY0K2ZmWEN6amJMUnhK?=
 =?utf-8?B?MzlvQkg2TFl0cU5pVlJVTE5nOVN6Z1ErM3JwWUdjbXNMcU94WEozNENzUzgv?=
 =?utf-8?B?V0FzVHFlWFNvL3VKNUkreFM5WmpMWElFRzBwKzV2d0tRbE1rOHptUkdkN2VL?=
 =?utf-8?B?ZXFFbDV0SzM2UTJiaFJZbGhrR3lqcklybUg1dGZoSDE5L2Q3UWdqSW9JSWlr?=
 =?utf-8?B?aXE3NXRnTHJUZ3pJNXZxb2hjNE1UV1dYemNnSEM4YVovbkNTd0hXZUMvdWRo?=
 =?utf-8?B?elV2ckNTaWptaXJRMCtsSlBMN01XcnJlQjZXRksxN0pwQ0RjY3MxVDZkZEhH?=
 =?utf-8?B?aGFqbUEzT2c0eFkrc1lKL0w2aXBlY1R6QTlpQkRrUFdab3d4VTZXRDJENk1T?=
 =?utf-8?B?ZWhBdi82NmQrQktuUERDU3Y0bk03MjhhaVk3MmNuREpBdVBSbm9SeDdRdDB5?=
 =?utf-8?B?c05lMG51ZW1wdzhEN3YxWWQ5aUhVOGE4TmZEV2Z5RG9CeVl0V2NYemsvbmhq?=
 =?utf-8?B?aDN0SmdFNm95b284MWtaZlF3MTRwUkJGWWJkL0hjNmxuOFlUcGYzNDBCTVpE?=
 =?utf-8?B?OHNtNlJXanJzVVpOZkpCNzBFN0FvZzR6M2dpNXdxVlNuSDN3c2dzYmtYOUxw?=
 =?utf-8?B?RHU1dndSdXNrbXQ1ay9UUzMrQTJlOWY3M0xJYWFVN01mQzRYZ0MvWUJnZzZW?=
 =?utf-8?B?a1BXbWh6cUsyczJUMVoxeC9BSjNaV0ZXYnNsbU1JaDluS215QUZoR3ZmVVRl?=
 =?utf-8?B?STBiTjBjV2ZZdmFQWktReXoxWS9XaEZvcGFEZzhIa1BTZ0RrZGE4TFZQeE5k?=
 =?utf-8?B?Vk9vb1RHUHYzWGM4QTRkOVMxdTBtRUNjbHpoRkxiSHUvVmdUc09oYVNYZ1Va?=
 =?utf-8?B?RlVGR21EbXZpejE5MUNJU3F2c0k0VXh6Um5aWDFLcldQQ0p3MC9sYUllWnVk?=
 =?utf-8?B?Q3c1MU9UZi9RREJ6cEJ0OVV2NWJCVzN5SmhCTnBZQ2trN1ZXTUdQQU96SkZD?=
 =?utf-8?B?V3RFYUxUWm45TmYxU3pEUmpXeFBrQWQ1V0J0QWl5REFNaTcyOERlWVZ2ck5F?=
 =?utf-8?B?Y2xmbDVkMFB4NXArK0R1UjZVRGtmeEJDQlF5Mjd5QWJpY3V5elcrc2RKWEtM?=
 =?utf-8?B?TWJKZEkwMWVJQjdvTkhHNjMydnNSR3psUnlqaTNYNFkxMUZ6NUNTWUFGQ2dV?=
 =?utf-8?B?VnJOR0c5RGNycCs3MXFaSUsxTXFLUkNGTjJacThPNFZtZDB1ejBFaVRWYXp4?=
 =?utf-8?B?ck5YTkdzNUpIWVR6NUlpUS9DM1ZsM0VKMlZ3cUdab3pjaTJFQ0IxSzRHTHpQ?=
 =?utf-8?B?clBmVW5JVndZdUc5RDFEajNoY0N1NzBIMzJXT2lRUjlCK01sUmdhL0ZDaWZ3?=
 =?utf-8?B?RnRucnAwQkM0c05RNEdIYmxUWEQ4SHlmWFMyc2VSTUFHSkZFMVlIUFVHSEFh?=
 =?utf-8?B?QXQxKzNUZ3d6SlhyYWZXL3RBV0E2R3pyekpBaThyWkNISVBzTEVOYlF1Qm1t?=
 =?utf-8?B?c0pkNWZTNk5wcjRrOXUxbXhjd3BGbUpma1Zpc29NR2grSERFQ0RWdUJzUUh1?=
 =?utf-8?B?NXNIbURyRStic3lDN1NaNkFZcTh1YUthRS91ZDQwWGkwcFZQYkFZb09TdG94?=
 =?utf-8?B?Q25peitNYi9zcjFMVGlOSkRGS3d0TGFKeE9lWENZcC9RbVJFanVoam5VOUtJ?=
 =?utf-8?B?K0NKckhNc0ovR2ZVTkd4ZVJ3eFROVDdJdjUyc3ArZ056Qm5XNitLNEgvR1dE?=
 =?utf-8?B?MFE0dDVjUHFLaTJ4aWsvNmZsL2JqUXpRQnhXcElGN1VackI3VkNzWTdVWlow?=
 =?utf-8?B?dmJpUjBFK29PNDdHeHJhZmlwbnJwRG1rUWlLU0RjNEk2TkVkMWtVRzZBZGZD?=
 =?utf-8?B?R083QUZZTytLUDBOSDZWZEpiNGw4TWh3bVNVZFkvTG5MenFPWlhJeksxZi9H?=
 =?utf-8?Q?qNOkrYl67VLo7hZmIiMMOF3t0m0Zc30Z?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 03:18:42.2216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d4bfcd-3611-4ce1-3dc3-08dcdd10c200
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646

Hello Tejun,

On 9/25/2024 3:51 AM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 24, 2024 at 09:10:02AM +0530, K Prateek Nayak wrote:
>>>    	prev_state = READ_ONCE(prev->__state);
>>>    	if (sched_mode == SM_IDLE) {
>>> -		if (!rq->nr_running) {
>>> +		/* SCX must consult the BPF scheduler to tell if rq is empty */
>>
>> I was wondering if sched_ext case could simply do:
>>
>> 		if (scx_enabled())
>> 			prev_balance(rq, prev, rf);
>>
>> and use "rq->scx.flags" to skip balancing in balance_scx() later when
>> __pick_next_task() calls prev_balance() but (and please correct me if
>> I'm wrong here) balance_scx() calls balance_one() which can call
>> consume_dispatch_q() to pick a task from global / user-defined dispatch
>> queue, and in doing so, it does not update "rq->nr_running".
> 
> Hmm... would that be a meaningful optimization? prev_balance() calls into
> SCX's dispatch path and there can be quite a bit going on there. I'm not
> sure whether it'd worth much to save a trip through __pick_next_task().

Probably not worth it given balance_scx() is indeed very complex and can
release and re-acquire the rq-lock (I don't believe it should be a
problem in SM_IDLE path but the given he complexity, I could have easily
missed something again :)

> 
>> I could only see add_nr_running() being called from enqueue_task_scx()
>> and this is even before the ext core calls do_enqueue_task() which hooks
>> into the bpf layer which makes the decision where the task actually
>> goes.
>>
>> Is my understanding correct that whichever CPU is the target for the
>> enqueue_task_scx() callback initially is the one that accounts the
>> enqueue in "rq->nr_running" until the task is dequeued or did I miss
>> something?
> 
> Whenever a task is dispatched to a local DSQ of a CPU including from
> balance_one(), if the task is not on that CPU already,
> move_remote_task_to_local_dsq() is called which migrates the task to the
> target CPU by deactivating and then re-activating it. As deactivating and
> re-activating involves dequeueing and re-enqueueing, rq->running gets
> updated accordingly.

Ah! I gave up too soon going down the call chain. Thank you for
clarifying.

> 
> Thanks.
> 

-- 
Thanks and Regards,
Prateek

