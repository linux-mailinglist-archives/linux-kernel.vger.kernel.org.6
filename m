Return-Path: <linux-kernel+bounces-561042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C292A60CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1278A189FF8C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A2A1DE8A5;
	Fri, 14 Mar 2025 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sFh5/Ar6"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590FA153800
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943581; cv=fail; b=PXlpSLNlTi49f09GO03krTYJ6uMtM1OadLceuJQWIUWcCt+4rbCJgoU4E5qbDPjI97+CQhxm55cKIzNilWmJiySG6rCM4ymrDtEKzc8ayDBRh3VkJW6pmRSOm1/ja8pNgZoeDY4R25mFgjoFE/lExjQXSUWUBgcedFYusyEvU2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943581; c=relaxed/simple;
	bh=kg+9TJD7W+/RnZU5O/ksk8ZBa0XXv3SbeSR2Ws9Ht40=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YXZuCXFGfgi9ZI4Y0AJruqSwrTbbaBPVqn9ceVZOCI+3fLekcAQhecBU/JuRPNh7fQ/yePvUdDShhtp6hUWLlrIFo44148lo3eCjOujSeW/5YpB8Q4sLhgPYgvLXxnu3rHMV36Xd+K7C1WtMV9gjAB1RsdCAKbU2j2C4PUm1k2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sFh5/Ar6; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORf4R2JIIMp4Ln/DauOYOsAGQ8GeZvJH/hD9f+a2fqnDX4zgGJGqAXWBX6jVv5fl4AqzsenAHQgYX1tbPEcK7kQpCNRRk2JOdese8HT57CZUyLBzvytYZwUXQJyTA8mujas8M0ZMrTnaBqAi7uWLbLqYaQdbsic9cPR3xJOJmjld/TKaIcUd8Zo1HEm/6CjBFQrPw+lLcYQ06oQJ0E/Jaj+zwaI7vmDceBKS/t5XY0KTSGMFD1ZwiKde3XaSPwJZCvfld7sMmQvCfwCWHy0TkwbZp1rJB232TZ5iBWO0NZ9f74yZKmIB5EuK+FgmcZ24kbP6wYqQe6MKHfMuovENMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBpmMtnGXsYNWBN3rl3hZc+LdFXgUZ8c+ldDw0ZuU4k=;
 b=gjH1hxkZaE0J7cOivs+PVBjLw+cSdjb8dC3cZ9CGGI44g7J8uJqhAuJ0S9BrmrQoiBJ7YE+6y+aPrM2c6dOVSgIFIISyFEpK6ibH19xENPgzPmMD/di2dBCzSgcihekurig7jIrAh2mQHc/j6hZ8u0orpIQv/t/1XKhV5SpoldKUU/PyDks7f2ImcwfLN2fr7WfQibaRF+WTWHq3O5i2hbqaqGPSpNd1ntBmyVnVxXa0bmim6TgbDSP6v+A0SU3RsVekEoO9SYJ6h636vDIMvjESa6y1t0xYiCfsVhP77JwXX4JO31gTkjo46k7q17z/cONW5FpqEIwkBj8JjJro1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBpmMtnGXsYNWBN3rl3hZc+LdFXgUZ8c+ldDw0ZuU4k=;
 b=sFh5/Ar6Z4yU+fcJA782p5+XqIj3ObfgQuqCM9xSJcUY6cJjr8v27XdsODZWHAu1l9UwODd4wiDpBw2Dr/orgPtfq56p3691F++lKCn/P2D7pcwrVMixEyFa1nvO2GxelfkaDZVBvJhtRUOjtVJtcfHoCknrYYGnPwPc7Ds43sg=
Received: from DS7PR03CA0044.namprd03.prod.outlook.com (2603:10b6:5:3b5::19)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 09:12:54 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::f9) by DS7PR03CA0044.outlook.office365.com
 (2603:10b6:5:3b5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 09:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 09:12:53 +0000
Received: from [10.136.37.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 04:12:48 -0500
Message-ID: <2c38d5a3-4d00-4139-a71c-00ca90375489@amd.com>
Date: Fri, 14 Mar 2025 14:42:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
To: Aaron Lu <ziqianlu@bytedance.com>
CC: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Josh Don <joshdon@google.com>, Ingo
 Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	<linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <ddd839a6-916b-4a23-a998-0d44486588ab@amd.com>
 <20250314085709.GB1633113@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250314085709.GB1633113@bytedance>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2b86b4-adab-4f30-00d2-08dd62d86719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlhBVzVGdVJYQUw1d1U1YkJBY3NhTXFTM2JRbVNQYzk1Y3NpSGZ1TWkxS0xo?=
 =?utf-8?B?bHZuQzh3OWVoN0lEcXRnZzZodXJhOWV2YUwrejl3ZFpydmpNR2dFRWtreFZj?=
 =?utf-8?B?clIyOHNjekVCNXdiVDZpL0tpejBVeHpESmJjazBvUmRCVzFOa1JmZjFWcU9m?=
 =?utf-8?B?dnZyaFJTaWhlMDdUcFc3aHl4SmdTRWliQ1J0UEJHR1FFejdTSUJQS3BIdXBT?=
 =?utf-8?B?QXU5WEtxZGVKbVFERGlMOTBGT1BWczZZdHBoeUloQnkrZCtYcmVGNGtFeG5U?=
 =?utf-8?B?cXdSenNEaG1JRE5aOGprekVyQkVDanFUN2c5MVVxVXF0cnozdUN4dStZdmhK?=
 =?utf-8?B?WXpXanM4eW44Qk9tdmFqcXpXdkZiRlR1NVludW1uM2FIeTdlK3BHNDRUUUhV?=
 =?utf-8?B?UWxtUFZGcTNVTDhISXcycFZManBtVG83Q3l5ZXV0SFRXcGtXMVcxVGFIdkw1?=
 =?utf-8?B?aGI0YWJmN1JFOUdmMGtuOW02U3ZPQXJPYWFQV0lLMzhYazRESnk1RlUyeXp0?=
 =?utf-8?B?dWVPcUtPdzVRRk9laUREMHk1UlNxMkk1bEcxQkVsa252UGtVdk1UaU9CVlhU?=
 =?utf-8?B?dGJFa0ZVeFNOWmxKMDVvQmMxV2xBdTZ3ZXRjbnlVNFpoR1lJdkRVV1JXa2ZR?=
 =?utf-8?B?MUVRaDlPS1BYenVybmNZZTNWaXB0NEhFMGJjanJQVnprMG5xcHFEdjArcXFY?=
 =?utf-8?B?d3VBR0NlaWFzNkZNNENJbjRUaWMram1uTWQ1SjZLSzJsYXdtS2RydXo4eWV6?=
 =?utf-8?B?TzlpMy9zM2w3ZDlYMWNMdTF2d2ExU0QxQ1NwOWpacjRFK0R0M2lEeG5HeDVG?=
 =?utf-8?B?bHQvZjRFOVVaZmNlTk9kcG9BV2NiM3YzZEYyT1FzaDRqTXBReWxHUnVFVWYx?=
 =?utf-8?B?b2ZNd3ROMnAwSUM2Y1BlTWhtRS9aNjBRbTNqNnh0eFdlaEpqT1lzOUpGSC9h?=
 =?utf-8?B?VGdqY3FsakV6b0xEbkZHcEdnbFpnQUtZWUxQczFFenZtTitqVkpmZkFTNnB1?=
 =?utf-8?B?aTBaTUFvSlVUak9YSkFjbVgzVVRvbW9QeVk5dHN6RkFtQnZoY2svWTVVU1cz?=
 =?utf-8?B?ODVoWHk1clJjRzluKzIxUSs3MEpqUjg4MTZkdVdCTXlWWWNpL29JMEErelNq?=
 =?utf-8?B?T1lyTHFlYWYyZk5qOEhudnR1T3BhOFdjRi9yQjRwZUNndG5ROGgvVmdCWFhP?=
 =?utf-8?B?Z1lOUWludDRzTkNXbnFEd3pUdWtiZ2RrS3JBOVMrQUtpTll3NXNXalkyc3g1?=
 =?utf-8?B?VTJXSFE0WWFnWEkraE4wTytzYTM0ekE1aHRSLzhUMG1pbEl3V3VzQ2VLRFZC?=
 =?utf-8?B?ZmoxcVNJZU9ibzAwSjFBa0xCNkMzQnplZjFCd2x4NW5ZamhTWmlUbC9wNDBn?=
 =?utf-8?B?QVhucm1OWVJhUFlIQ0VpTFhONkdPajhYUVZVVUVib0V1SHZLM1l4b1UyeHhW?=
 =?utf-8?B?aERpcklVODEzb2luK0pVNGl2djdmN1AwUDRsT3FGZ0V6NzhLWDBSYWxCcTJv?=
 =?utf-8?B?eTBWQ2Y4bS9ZQTlwMTdOc2RoZStyU2syaGdDc3htbHY5TDZ6ZkNPTDlBSlRE?=
 =?utf-8?B?YlozdWxTWFYyVFBHNDBxdVBPZmFrbVdubmVZWG02cHhHUnltTWRCYkhScW4v?=
 =?utf-8?B?ZWhuYXF6cGtQSFR0VG1ucEVZanl2MjFmTFVsbmVLc0ZJVUlTNlg0UHJNS2pn?=
 =?utf-8?B?cmtHMXcrSmY0T2VUNGwxbW1lVUh1cStMMU1FcTg3N25CSTE4K0tZMVFkY3k3?=
 =?utf-8?B?bUt3TE9VRjdwY1B6dXRZUmV6MGpnUno2NnFjRmpSRFZMbFZGQXRHQkR6Rmwz?=
 =?utf-8?B?azNDNzVZQ1ViY0VCRDlxS2NsZFQ5OC9xazFvTkVJazlPU1VDMEtYRm9CbnBv?=
 =?utf-8?B?TUluVnpOSlczVm9aMWJ3SWRsb3dKZGh4UktCNTFrSFlNakZ2ZnZ4aE1lQ0Y5?=
 =?utf-8?B?MGhzQTdZcTVLcWtmSzVnV25IREJtMG94YkpGeC9ESDEyUGNwb0FxbXRnTjhJ?=
 =?utf-8?Q?aIPOnfwBcMObM4T1rT9sE/2XzLheHg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:12:53.7690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2b86b4-adab-4f30-00d2-08dd62d86719
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521

Hello Aaron,

On 3/14/2025 2:27 PM, Aaron Lu wrote:
>>>
>>> +static inline bool task_has_throttle_work(struct task_struct *p)
>>> +{
>>> +	return p->sched_throttle_work.next != &p->sched_throttle_work;
>>> +}
>>> +
>>> +static inline void task_throttle_setup_work(struct task_struct *p)
>>> +{
>>> +	/*
>>> +	 * Kthreads and exiting tasks don't return to userspace, so adding the
>>> +	 * work is pointless
>>> +	 */
>>> +	if ((p->flags & (PF_EXITING | PF_KTHREAD)))
>>> +		return;
>>> +
>>> +	if (task_has_throttle_work(p))
>>> +		return;
>>> +
>>> +	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
>>> +}
>>> +
>>>    static int tg_throttle_down(struct task_group *tg, void *data)
>>>    {
>>>    	struct rq *rq = data;
>>>    	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>>> +	struct task_struct *p;
>>> +	struct rb_node *node;
>>> +
>>> +	cfs_rq->throttle_count++;
>>> +	if (cfs_rq->throttle_count > 1)
>>> +		return 0;
>>
>> General question: Do we need the throttled_lb_pair() check in
>> can_migrate_task() with the per-task throttle? Moving a throttled task
>> to another CPU can ensures that the task can run quicker and exit to
>> user space as quickly as possible and once the task dequeues, it will
>> remove itself from the list of fair tasks making it unreachable for
>> the load balancer. Thoughts?
> 
> That's a good point.
> 
> The current approach dequeued the task and removed it from rq's
> cfs_tasks list, causing it lose the load balance opportunity. This is
> pretty sad.

That is fine. Today we have the throttled_lb_pair() check since tasks
on throttled hierarchy remain on the fair tasks list and the load
balancer should not move the around since they don't contribute to
current load in throttled state and moving them around will not change
anything since they'll still be waiting on another CPU for unthrottle.

With per-task throttle, we know that all the tasks on the fair task
list are runnable (except for the delayed ones but they contribute to
the load) - tasks on throttled hierarchy that exit to userspace will
dequeue themselves, removing them from the fair task list too.

Since a task that hasn't dequeued itself on a throttled hierarchy is
runnable, I'm suggesting we get rid of the throttled_lb_pair() check
in can_migrate_task() entirely.

> 
> I'll need to think about this. I hope we can somehow keep the throttled
> tasks in cfs_tasks list, I'll see how to make this happen.
> 
> Thanks,
> Aaron
> 

[..snip..]

-- 
Thanks and Regards,
Prateek


