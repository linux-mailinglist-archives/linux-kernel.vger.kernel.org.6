Return-Path: <linux-kernel+bounces-270605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0F59441FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67EE1C220EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D162713D2A2;
	Thu,  1 Aug 2024 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R3yMzI+H"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA3D208A0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483766; cv=fail; b=N71wKrh4B1kFUYx3aotaLXF496yZ/I5tBtw3M3RYzIdaJxkELtjW++R61XBQvkOPv0m0/hvWdOtW9yOI2hCLx1Zd0tKKYBEpu0vKiiq+AEokrlj2OK9+w9nan4k1znOYHpKoFiyCKH3jSI+LMUVw6Jyxuqlk2VZZ4a90UOo9Yvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483766; c=relaxed/simple;
	bh=qcOXSPtFF1QcO7KN/inwRmWO0HIp15m5tsrM9EivhM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sh7P6bnPSckiHeqnZSnzOEScpDjxEyPoKWoF5/vXpqlWcbxEL4ylEC0WvosSUMSouR0PuZh1hUhkZp5j33kZTNBOEwWXnha/x2c9kJ4Ei0DWAgdr99afV0y+b47Pm6AJ5dvhzo3xgZsk2XanLcrjokVLDX5raZ/UYax0XX74w0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R3yMzI+H; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUQPGXKHDIebUjn5h/8B95qw7n0qXJWhxtN8lRRzXwq8tNSZQNLykgj8z2/btlR4oMq95FyuFf2LAq8YKxSWArwBRGH9w+RZXRoWxPDkWFepRrO5JOMaoO+NgazRsWt+KItQPwx5ppa3Z+QO5zhqMRfCeGPv2v9IJMVKPshaX4Xwcwn7ldAFNZnjgJlSZ0uSFIlShnHnb9vD4GStrEvF5rPs4+DNPXLyPruz2O7J2QvLnJ4oj93vNN0UJFRr07FVbs+10g4hkkLeAzawhFDfchB3u5DHzEkjBWITIpJSwqyStAIM3T8rHLEFoHcGbGgWk3mhxHk8e1sE85H6s4vajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyCc71PF5xbDgA9Nywe+9oqcliKVkyIj7Sj0EUNLzUw=;
 b=tGF66GarhKyRsIKoQbgTETZtSk0VqoTBz7EqVSFSIrdMLy8OlW3GnVk8gXJhCZGVrQRm6gVym3FmA5Nk8D7Ohl0YkOAErioH/KWPj0BYQJ2crF7BfunrI/kbQox/oBuGa/OyMOG7Ob1YuvSNddVN/3i5GoqTJRIrQb7rRRbsMleAMhAgKVuXaZtFoIjU/ifydudmsiILWs0Gdxis0wxloziKgQE1gmjZ6fGmh6vKDzy8blP3MvQ1Q6xvoHvED+P2VahfCaYZmvaou1K21+fVyBBTDR57W/dJPUTmdijoC6jpa6Y/YmzAL6Kzd7b7lDW074Cl/Enz5CmKyyYSUPpPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyCc71PF5xbDgA9Nywe+9oqcliKVkyIj7Sj0EUNLzUw=;
 b=R3yMzI+HIex+sfKULmgzibtWQz2hoEw0xowrSY0Y0OpDRe9DomF78v+qY5Y6CcayZMFVwJbDu3nL16cZY6J7yk59WzGSQeil3/7aoZ8kbe/XiWqenOREpJFY2ZhFgWYu4CfNG0LYmgwQEE+toT2CPpXHRleZ7H8hvVSNd9KrPww=
Received: from BN0PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:e8::13)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Thu, 1 Aug
 2024 03:42:41 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::db) by BN0PR04CA0038.outlook.office365.com
 (2603:10b6:408:e8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Thu, 1 Aug 2024 03:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.11 via Frontend Transport; Thu, 1 Aug 2024 03:42:40 +0000
Received: from [10.136.40.92] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 22:40:39 -0500
Message-ID: <810b0f1f-d490-83b9-efce-734ce7734c8d@amd.com>
Date: Thu, 1 Aug 2024 09:10:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [peterz-queue:sched/prep] [sched/fair] 124c8f4374:
 WARNING:at_kernel/sched/sched.h:#update_load_avg
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, kernel test robot
	<oliver.sang@intel.com>
References: <202407291328.761441a7-oliver.sang@intel.com>
 <5e3b9b29-8d17-6a04-f2a5-1748a52d1a6a@amd.com>
 <20240731115418.GD33588@noisy.programming.kicks-ass.net>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240731115418.GD33588@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c53ca55-9a03-4e84-40aa-08dcb1dbfeb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WElPZW5kZFU4bmo4bXpwQUdZTGJhbWljMit5M3Y0UjVJNW5STm5BSkxTWFNX?=
 =?utf-8?B?SjJEZzlhTFNOYWt5dkdMV1lRNjRGWk1UQ3pFalBpVFY3b2RtOGljb1puTGNM?=
 =?utf-8?B?K0d4MU1uZVkvZjZ6Y0VUTmRUdUd6d09aRWRLSHdGL21JMXFTMjZDMFdqeFd3?=
 =?utf-8?B?WjY0elZpV2NGUnM5c3hIZDFBdEw1NDRMbFNJR2FoSFRJaSs0SEJ5ZEpjMnhY?=
 =?utf-8?B?SXptVkt6MG5oSDBvZFNXM3krZzBteWRoYWYyZVhnTTVkem1qNU5NYlVMTC83?=
 =?utf-8?B?bHFPUFQyOWdDV2ppWTE2WHJUeVdwYno5eFpOQnFrWVJneUc4VmVEL1NMQnk1?=
 =?utf-8?B?UEJpZXloSmZlOEpkR1g0NUtlRWxWOFlZY2pvenRod0RKMjIyeTdwZnVUTmR4?=
 =?utf-8?B?bkNOeXpYaDNvbmVENVZpdUxOa08xVmorVVhmeFNsN3NySmUzMENwVk9McThr?=
 =?utf-8?B?dFg1d2NVZDFFRzR3ejJzbHI3Y0NxaXBOV1A5Q3A2QkhVamR6SlhGNmI3NFNF?=
 =?utf-8?B?SjVXVGVLVm1qWWFsd3dWajcvaXprRE4zVVo2M2ptaWwwNWhUMUVLZ05kVm54?=
 =?utf-8?B?WGlkYlBSYTlRYVVFRWxDbnkydDFjYU5uTmQ1SFkvUS91QTlIb0szWTZKM293?=
 =?utf-8?B?bjlWa2twWi9UakthL2lHZXlCUSt1SkVEM2ZWNU5id2hFeXVtREI2TTBJZXQ4?=
 =?utf-8?B?QjZIKzlHTThPOVczZEZCa1Jra0ZUWnpxdSt2RHVpeSt6M0w2RU5nNFhuNHla?=
 =?utf-8?B?VlFQUllIT3lmdlFBMEoyRkJ2SXdVSDJrMk0xVllQRVB5cFJJNElBbFk5SHlh?=
 =?utf-8?B?elFIRmFUZmlFcllxcFBjcVVjUDVuZXY0V0hxUnEreWFicm1Ca01CSy91U0dr?=
 =?utf-8?B?c1NJRDVZcFdtV3NuTjZEaXEySW81ZmNhOVdhbzA1bTRvWFE5SlM0dDV1NVNh?=
 =?utf-8?B?eXA1VTQ4WlVaTURHaE94U0ZwQUNSQUJsZmp5ZC93N1k2VHllRTU1ZlBLeml2?=
 =?utf-8?B?VytMTmpkQXNiS09YUi9BTXZQSUVUK3QrM0pMMnNGQXBMM3plREs3d1NxRWdt?=
 =?utf-8?B?dWVVWXV1QjN1ZWtyMEhhTU14UnNkSVpiSENwZFd5MkhTbGZFY3JlTHJtS0M2?=
 =?utf-8?B?cEszdmFEbE16S0dNM1BpeXQwQ2RMckhpQWd3WlhXR2tldG5zK2NYY1JPVmJn?=
 =?utf-8?B?a2ptWkZLVVVDZkxVY1djQTZJS1loY3EzRWFxOUZ6c3REZm0zZlVqYmxiUjcx?=
 =?utf-8?B?cnFLRDdBeklsMzcvSkprZzZRU2dIbmV4S3hIL2d5bTlGZFhwZENHdXpwQ1Mr?=
 =?utf-8?B?WGdaU2ZmUCtuRmFNQ0pjOWVyaWRCWXJ0TDl6UTdjOTJoODZ3WGV6bjVJL3JE?=
 =?utf-8?B?bVBYQTduUlkzUGM4b3R3dkpRTVU3MWdKNldFczBoS1VEa0Q0cWxBOStsNEdq?=
 =?utf-8?B?ekFjL1dkNm9zNVBYbW1Rc0dwTG1YVk1lNXd5ZDVPdFo0ZVpZUEJlc09HN0g0?=
 =?utf-8?B?MkViZzRzellsZXF1Q0JJYWJGY1EvUDI3MUhJdG9PdGlNR3pkN0dZYjBPUFVN?=
 =?utf-8?B?eWZTMjd0SGZrUkZqbVVacXllQ01xdmpqam9lekV0UzQ0TXhLM3pPSlpSTG1X?=
 =?utf-8?B?UkwzYnJHaksrenFkRnh1VWJ1LzAxNmM5aVBYZUgvS3BLWmdxc2hTd3gwcGlh?=
 =?utf-8?B?TFJIcmMraVd3V2hhbG5QSkVuKzcvNUpUVU54d3NxY2NPd1dqQitvbWRudHoz?=
 =?utf-8?B?OXEvTzZTMjRMaERvdmIra3R0YW0vMEhQNUdOR3lXdmw0eXMwTHVKWGFHaEhS?=
 =?utf-8?B?emJnVVVUVkpzSkljMjBGRE41SjV2ams4SWRzbkZPa1pNM1hDZGREV3pVUGo3?=
 =?utf-8?B?ZFpGdDA0NkEyZ3lGY1hCSkZvcE5IR3NSTVorV3o2cXJiclBNOTc4Q3BlV1Ro?=
 =?utf-8?Q?lQ5sM3mon5REuPSZV8ucBPJsz+wrxDNY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 03:42:40.8494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c53ca55-9a03-4e84-40aa-08dcb1dbfeb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718

Hello Peter,

On 7/31/2024 5:24 PM, Peter Zijlstra wrote:
> On Wed, Jul 31, 2024 at 11:46:48AM +0530, K Prateek Nayak wrote:
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index cd4a6bf14828..c437b408d29b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -13297,10 +13297,34 @@ void unregister_fair_sched_group(struct task_group *tg)
>>   			if (se->sched_delayed) {
>>   				guard(rq_lock_irqsave)(rq);
>>   				if (se->sched_delayed) {
>> +					/*
>> +					 * We can reach here when processing RCU_SOFTIRQ on exit path from
>> +					 * a reschedule IPI. wakeup_preempt() may have set RQCF_REQ_SKIP to
>> +					 * skip a close clock update in schedule(), however, in presence of
>> +					 * a delayed entity, this trips the check in rq_clock_pelt() which
>> +					 * now believes the clock value is stale and needs updating. To
>> +					 * prevent such situation, cancel any pending skip updates, and
>> +					 * update the rq clock.
>> +					 */
>> +					rq_clock_cancel_skipupdate(rq);
>> +
>> +					/*
>> +					 * XXX: Will this trip WARN_DOUBLE_CLOCK? In which case, can
>> +					 * rq_clock_cancel_skipupdate() be made to return a bool if
>> +					 * RQCF_REQ_SKIP is set and we avoid this update?
>> +					 */
>>   					update_rq_clock(rq);
>> +
>>   					dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
>> +
>> +					/* Avoid updating the clock again if a schedule() is pending */
>> +					if (task_on_rq_queued(rq->curr) &&
>> +					    test_tsk_need_resched(rq->curr))
>> +						rq_clock_skip_update(rq);
>>   				}
>>   				list_del_leaf_cfs_rq(cfs_rq);
>> +
>> +
>>   			}
>>   			remove_entity_load_avg(se);
>>   		}
> 
> So I did update this to simply add update_rq_clock() before the
> dequeue_entity(SLEEP|DELAYED). I initially had, these, then confused
> myself between deactivate_task() and dequeue_entity(), where the former
> updates the clock but the latter does not, and removed them. Then Mike
> complained, and I restored it for the regular exit path and forgot the
> cgroup exit path.
> 
> But now they should both be doing update_rq_clock() here.
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/eevdf&id=5b3a132d4dd5c91f26beb3e8973c03cdb77d7873
> 
> Since this is all with our own rq->lock held, I don't think skip would
> be relevant here.

Thank you for clarifying the nuances. I'll continue testing with the
latest branch.
-- 
Thanks and Regards,
Prateek

