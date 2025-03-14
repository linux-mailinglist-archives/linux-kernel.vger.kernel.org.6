Return-Path: <linux-kernel+bounces-560675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE9AA60800
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68E1880706
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200186F30F;
	Fri, 14 Mar 2025 04:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qOYpWPSr"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFFC2D052
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741925213; cv=fail; b=HPnDK+WY6k4MgtD+YWXqQ1u8+nXnqRFA9q2M7nk5nxv7ZwGbP9bUTiilFypaMDopsegtqaOsIp3VronzreOk8kzHMed10HQM90mMd7JF0iClk0afkEH11kyDQoyx55F5Jz9P2OP170TqalaMJ9hm1k61Z1v9dv5RnIxNdw1ADcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741925213; c=relaxed/simple;
	bh=Fpe4I8MxSqWet6kOWiv20J6Tzw25HiFiN23OUcmbjXg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=qeQTrP9pxAkhCUJEmrL3/ZqsBojgelpsbG6HNX2DRW/i+wJd9x5cfWeSyn+lJ1+UI5CtwdnfNR/ugjZDgXDPl1FCIjD1ThycUuhTwK8oqT2CHuMM5S4SxFOTjUEkyHBYUV2MQes31BJWeSYIfAF+mpCD65nCx8WaI32MCVWBgYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qOYpWPSr; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9+QoCxACp2S9aAjZcfANYPi9CDpTlbEQ1FY22cdLn/6svgvx5+IZ53mX9KKCxKj3nlPDWsbJgIJB602Hmyr1Y9uIOGSjeIg6S0V1KBGjx/QIfxaHclCy7bUGNsvs+AoNoYANTGaCNr+AMA4u7qAk5wZwO31X1HLYXV/fV2zoryivcvP6oExdgFG6dvQfm3oV0zRAJAhecfoR0Di/V2M7R3Ph/KUgFpc+nQweetFq/HD88KyZTA8CUeAYXVjZ8j10M3EUa8oMvGNHRn90yX8zZuvAQ5U10RNTg978pQDu003X9abnTgiW1DUxUbcxA3qX1c4LPpaGLB5JdU8R7AhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbpA8fUmxKhW2+FX+Su9i4T1EiCYqa6+2vW696jR2QY=;
 b=RpmN7VgFeD751/X6l83idrIXRCT2H+1fYoffaECo22jmgP/mTyLJAciEBjFKgJ5Jn+35SuuF3w23TpkMSuknaZmf5DRN9NUnZkotYAyxHEhIi5L8B7CPDwxC5j9FopsqFiS0Jsm7cUdwLcn2+E7ELgrmvdqj3XMGKKZQaqvQ4zL+YomHOmpy6rQ0vvxu64jZGdlkkqlZhY/9t+QBNzkzY7uWKpd83Xy7aicIiU1rRztEo71pWq4N4b3GK7WY4NaMp5EAQ4PX03Q7p8TAklNqVxbEmiklVv9xrwH+zQwxVZhhUNDKkzdZ8H6bdHNzfBVtLEDHkVTAvy5SnfC1B5QhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbpA8fUmxKhW2+FX+Su9i4T1EiCYqa6+2vW696jR2QY=;
 b=qOYpWPSrOosih6fOs/Jdr5KuS4vOdbcB/44aeQQs5qwTn+rJGzPGqsfmShkrFKXxNGrOUFhVoJa7d3hi5udpJoArjysS11OYbWf+UxhcuZ6QjbKMd565ryRrqCc2sqF5P+kRtaNIriCZeo13kEGz1Y/hgts9YSqPClSiDYsx1cw=
Received: from BN9P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::6)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 04:06:48 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::6d) by BN9P221CA0013.outlook.office365.com
 (2603:10b6:408:10a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Fri,
 14 Mar 2025 04:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 04:06:47 +0000
Received: from [10.136.37.23] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 23:06:44 -0500
Message-ID: <c4f999f1-6086-4849-92ee-23a5efa2a9d2@amd.com>
Date: Fri, 14 Mar 2025 09:36:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/7] sched/fair: Handle unthrottle path for task based
 throttle
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
CC: <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chengming Zhou
	<chengming.zhou@linux.dev>, Chuyi Zhou <zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcAic5QThYG-r9CaXPgZtXJuB0RuCW5Y0SyBn7VyOQi=g@mail.gmail.com>
 <3fdb7163-d1f0-45c8-89fa-7c904b567696@amd.com>
Content-Language: en-US
In-Reply-To: <3fdb7163-d1f0-45c8-89fa-7c904b567696@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a447b7-90a2-4808-18ac-08dd62ada41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUo4N0lFVXhic3JTMjZORlBrb3FLZDJGcXVXZytxRVFnS0tVblpYcWkxSitj?=
 =?utf-8?B?TjI3cUlXR0tKaHZvc3A0c0ZkKysyTko5bmhtSkdZSEZIOVJnV0JLK1REYUVV?=
 =?utf-8?B?T3RZbE0xa3QvZ3RIRG1xKytWOElIZUVlak5QektSRmJJS0NqVnNubndGSW0r?=
 =?utf-8?B?c3NzbE5DcFhnNWx2QS9jUE5zRG42akFKR1FtQzd2Q0tTZ0dvN2w1T0NkbktR?=
 =?utf-8?B?RVlyUzlEQ2ppQWJsYjlMTEZmRnVXSXpBQk1SRHFjblppaWRoSVlWRVhWOUY2?=
 =?utf-8?B?b3lKUUIwSXlpb3BTT0ttKzZEUUJWN09acThpai9CbEU3WlF4azJmOVRQTlZi?=
 =?utf-8?B?WWo4aEJuZmlSYWVnNE1MV2FxSnN3L2lxNE1MTFRBd29oWEs5UzJXa2xFdkh5?=
 =?utf-8?B?THRuYjVKSGJ2OVdibitEZUpoQ3FlTXJKUXZ4OC9yTjU5bXRCSnNPU0UyL2JZ?=
 =?utf-8?B?bUJ2MW5yQWJZU0Z5Y21LbXdLaENiUEtoS0hmdGtSREh0SWNZeE00UkNRQ3dz?=
 =?utf-8?B?eDZ1T2U4TlVCUHJjNWdRRzZiWGJ1VndBS0QyN3h1elpTTkJpNmVHU1AzMVRI?=
 =?utf-8?B?SnUzUWh0MTlqT3VDbFJyeTNVdUFNQ2RGT2x3ZVVSbHhYdkoxYitqRWhpd2xE?=
 =?utf-8?B?OXJ6bGtYM1FkTXB3S2hBcmd1emYvMzhvelQ3akhTdVhublA3Z2ZFY01PVUpJ?=
 =?utf-8?B?NHB2VDBGbmxRZ2FueVJTWjhieXJFQVo4Qmg2MGt4UURRSVBLenFsL3hzZUVr?=
 =?utf-8?B?eUJIOEZEa3g0cWxwdFVhem90WGVjUGxLUUhhUjZJMlUwOS9vUmJRVVJUaFFQ?=
 =?utf-8?B?MUowQVhOWmxsZyszVldDQjFOamxBeTBCRFREMnErNEFXVWFtWDMxRHgyUXd2?=
 =?utf-8?B?Rm50SlZuMjNBZGk0SXBLRUNYTmEwejlEMlFRcW1ZeWdnYTUzMFRlaGdyVWx0?=
 =?utf-8?B?M1hQQUdSaTJDTXMrd2p4WUNjL1B6ZnNtL0lmb09KVzhvcmI4aXZzVUppWm52?=
 =?utf-8?B?c010dGxSRUJFQ0MxUnMyYXBpeVNSVTBpV0ZTcVZRa0M1YkZUanJ4UEwyaVNo?=
 =?utf-8?B?UlR2RUZGMzBDSUVYZElveU1kbXRxWklLWU8vVFprUnFnYVlXVHl2cEpsdU90?=
 =?utf-8?B?TG9TbktKbytFcktab0FFMDZGdVhyeDJ1Z3RrUWZHaTdWc2ltUzVxL05KMmNx?=
 =?utf-8?B?eVBLMzZkMFY3UDd3YmtnT24zeklHUEtXNkRUU0o3bXBhWjVSSTlQNTl4dmtI?=
 =?utf-8?B?WS9SRlhyc0hSclpYTWFudWRGWTZ1UkdUNUZTYTdQazgrVG5zN3ZNdEJ4Rm1F?=
 =?utf-8?B?eHJnWWdqQTJDMk5JazNadHZDNUhrWXZSUmE3dDRlYnQyZUhhWk1wbE1yeTBF?=
 =?utf-8?B?L1RQWStkRTBSaSsxWVREa1FqTkhxdi9wL3g4M01Lbm91aUoyKytoVkxWemNm?=
 =?utf-8?B?ZVVXRGh3bk5aME9xeDdld1p6R29EeFZCcE0rb1dmL01hYnFSMWhEQkhSaTFa?=
 =?utf-8?B?UUNFYkNYUTdzV2lqYjBMU1owMzZlMTloM3RTN2FKRllFUUkwUWtDODdjVkJk?=
 =?utf-8?B?Sk1MSkpkNFNhTnVnUlBxcCszcU1CcFM1Z1hXU1NLYzYvSnRjTnNZS1NoSjRB?=
 =?utf-8?B?RkFXa2Q0ekxTNS9LQlZHNG1jNWtHRk1zTUhOTzBCdGVVMnhiWk9IYXFjMmlp?=
 =?utf-8?B?RExoVFYxMnQ0aXNTR2lyN0g2TjVyNUFwd3YrSmZUSWc3ektkU01mSE95M2NO?=
 =?utf-8?B?R05GaDQ3bGZWK3dSUTYraVZvSnJsdWtmME4vVjVYR0JKS2ZGNHEvdkUxZ00v?=
 =?utf-8?B?VkJqQnRudncza0plS0ljRWhneGNZQmQvb1QwY1Y5bzFQSW5US3lkbzNKdHVE?=
 =?utf-8?B?N0RRYzBNbzFHZjJ0TUYrNUhONG5vejYydXFxWEEySFp1dExZKy9CR2FyQjhO?=
 =?utf-8?B?T3A1eDZCdDlBQVgxSGVsVG9zeGJMK1VIZzFXN1d0OUdJd01uWldDaitoV05p?=
 =?utf-8?Q?zUUdWlIWv/Xd9h+2fyM+e/ZTtelEHU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:06:47.8113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a447b7-90a2-4808-18ac-08dd62ada41b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257

On 3/14/2025 9:23 AM, K Prateek Nayak wrote:

[..snip..]

>>
>> +    /* Re-enqueue the tasks that have been throttled at this level. */
>> +    list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list,
>> throttle_node) {
>> +        list_del_init(&p->throttle_node);
>> +        /*
>> +         * FIXME: p may not be allowed to run on this rq anymore
>> +         * due to affinity change while p is throttled.
>> +         */
> 
> Using dequeue_task_fair() for throttle should ensure that the core now
> sees task_on_rq_queued() which should make it go throgh a full dequeue
> cycle which will remove the task from the "throttled_limbo_list" and
> the enqueue should put it back on the correct runqueue.
> 
> Is the above comment inaccurate with your changes or did I miss
> something?

Please ignore this, I just reached Patch 5. Sorry for the noise.

> 
>> +        enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
>> +    }
>> +
>> +    /* Add cfs_rq with load or one or more already running entities to the list */
>> +    if (!cfs_rq_is_decayed(cfs_rq))
>> +        list_add_leaf_cfs_rq(cfs_rq);
>> +
>>       return 0;
>>   }
>>

-- 
Thanks and Regards,
Prateek


