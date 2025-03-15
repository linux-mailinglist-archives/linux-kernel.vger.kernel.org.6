Return-Path: <linux-kernel+bounces-562657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACB4A62FD1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF177A3D47
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BDF202971;
	Sat, 15 Mar 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w5pFWCKZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2CC17995E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742054816; cv=fail; b=Iy8hGG+E3G6QCa8xJLuQXmuvM8GmDOKVJ4DYZTvsEQrFwrYsC6kqZCBLm3cHi41OLwo77sJaPQ6rL8z+giDsr2EV5i6cL99arNdvMhHL4igmf0uQL6WYfWnhQpan40fbquzMkan4pCU7QjSu2VLNbZt/sdoDQsP/Mj+LdWnZT/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742054816; c=relaxed/simple;
	bh=1v7kAQoka1c5wKXY2dBDxej5IcAscU4qGd5JG3yptWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b0b0KWzFiY/R6VEdfpG9XA/ZD288w9uInf8oTl/MHQtmA0gm4nWb6b9i7pPeAl4EFrULvgU0pBCmOGfgi/Fb2Y135czoGow1nWMM2C/8s7u2GiCdhOs/AA73TUblOZP7yzZMDBBdmCwCvTtQWF6QqQ5v3jJ62q2lkLGo9bCWCNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w5pFWCKZ; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+uB4YFEjyfKpY/t694Awf68a+Lp15807fVbl8vDWDwmUQt9IyyjbN8zCH8XdWI1lvQTglf/c8+YEUYX5or+Y8qjY9/Utd3X5C7flyF7BzHYBmlC9v/+3yjui/3n8BfDTtcmcFsgBQNOoQrMfZfSVd7TMkS2ZsWgpYhOKLY4POuCwDzwTWFL2/0AO6iwPD9uLpn3PrF+txqOjQjy/zURqzmDRh4dekBzaUaQfrUvi3unHGLRLtsflEobxWmhZX3MKFjZ07akQ20EgvZdwzftQDAlACPV6dxqWf5Qo7vtYvtpcg1ZgxGSvDaD383LycnxxehdbKUza1wpGes88cNa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XF3dt22crBZ7eZks5UnDrtWSD5rRoj7+zvm6pInHdZA=;
 b=xevnOfnVVsN+GlbaqNN78hTsmRlMh4ryN6jYHMJ23cW7Jw14ePU8oIe6TxsPy2w+8M4RONMxOpDmDzVPzzBkzGw+T0VkdTP255H4erMJrz72nX3rTtZfR18ZBwD58OVU5rDGW6nTHFMdNKZmJDHBZIwB4UmK80Ud13dsVo84klLicSWCArURvDQ1UgbkgiJmTzdr/idFcdvE8ypGMr20+dPKcHoXUZ/BX03L03w5s1hKOQr5FJgFn+8SvJTvNkcsQ6Q1ROxcZ1Hr3UxXH8w5Egm7LxZw41uPb7AvgbeHo2zTc+zEAJpCUaW/N9P2rsmkSoX3YddHNKYnwSs5SOnFKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XF3dt22crBZ7eZks5UnDrtWSD5rRoj7+zvm6pInHdZA=;
 b=w5pFWCKZ2Ek2eDGTJIfMkTmRoSo/I9WjqwLXSw2pk+dpRu3dtNyWWcRWTilUjwLtzTz2U6jz4PamzDs7jqCqXH8rgPXZLb3QNlBQlj88cjCSkzk5cId7Ralio4PFS8GwBTCUHApTDv+5KayOige84M8Q2J75wO5Bn68v6ufcKL0=
Received: from SN7PR04CA0175.namprd04.prod.outlook.com (2603:10b6:806:125::30)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sat, 15 Mar
 2025 16:06:50 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::29) by SN7PR04CA0175.outlook.office365.com
 (2603:10b6:806:125::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.31 via Frontend Transport; Sat,
 15 Mar 2025 16:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sat, 15 Mar 2025 16:06:50 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 15 Mar
 2025 11:06:43 -0500
Message-ID: <eae1f0c4-ea9e-4bc3-ab97-4ef7caa7fbd2@amd.com>
Date: Sat, 15 Mar 2025 21:36:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v15 6/7] sched: Fix proxy/current (push,pull)ability
To: John Stultz <jstultz@google.com>
CC: LKML <linux-kernel@vger.kernel.org>, Valentin Schneider
	<valentin.schneider@arm.com>, Joel Fernandes <joelagnelf@nvidia.com>, Qais
 Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Zimuzo Ezeozue
	<zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon
	<will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
	<boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya
	<Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner
	<tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman
 Souhlal <suleiman@google.com>, <kernel-team@android.com>, Connor O'Brien
	<connoro@google.com>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-7-jstultz@google.com>
 <931db71f-a13c-48ab-a315-f04d671bdddb@amd.com>
 <CANDhNCr24WBBhvSQQEmgL8EmC8e9og_LQ8=EEE5DXtY6Twth0A@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCr24WBBhvSQQEmgL8EmC8e9og_LQ8=EEE5DXtY6Twth0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dccf0c1-2690-4be5-51ca-08dd63db6525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEpuemFBTE9NYzUxVzB2RmJaREczRDFVWGZHZkVQcUljKzN4VU0wUXBzWnp0?=
 =?utf-8?B?VkhRb0NBQlVtVHI0SG01MFpqcW94SEJBQThJTXArSUdjWGphZnVjelZhdVlq?=
 =?utf-8?B?L3ZvbXpNNkF0L0xYaGh6ZG5SUDR2dlRzMHJXM3FBc2FkY1dXcjczbm5BUnZq?=
 =?utf-8?B?eWlQZEErZzZZMW84bXdmb2lXTVBhcGpGZ3FCYlRhRCsyRmRwbjJZWW5sR0xE?=
 =?utf-8?B?a2xnOVlDc3R1OTZDbVlWZUV1OCtJZGRsYmdJYTRqWWg2NUNlOWxzQWxQQ1dI?=
 =?utf-8?B?TnZLbDlrcVRwVnBJdWJQMHRpSHVqNDhaZDJQYlhxTVowWnkveFhlWG1RU09q?=
 =?utf-8?B?K3VmMXRMdU1nVVk0VkdhYmZzWThlb09Eb2RGdWhpcnlHUHBzVFBleWdlcjhh?=
 =?utf-8?B?YlNHUDVtT2JhRy83TkJZTkhIMGlMOFVhT2s3c29xbVkrTWdYeEtpNVRXZXk5?=
 =?utf-8?B?aHBtU0FJQ05ZZUxpN3QvczJ5NCtScUlsc1pkSVZJdFVLWlBNWDNRSmFKVlNs?=
 =?utf-8?B?MXo4T1ZmWWVkdVZhWHprVzRRL0VkelNBcnN6N1R4QVQ4d0NSWGpiQ0hxN3dL?=
 =?utf-8?B?MkZqd0VuNjV1R3lkUENuNWJLM2NWZ3l3bU0vSUFQWnN2VXduUW1VWkVUSnFW?=
 =?utf-8?B?VDhZbk11bVUrajhvcDNXU0t4V0RBYW5QUllCeUo2bW1mV21HZ3ZIWk5GbVZ3?=
 =?utf-8?B?Q3BIUnBma004eGkrcDJueVpKOGNHRldZWVlia0psdlVsdjN1ZDRMMW9Qb1hD?=
 =?utf-8?B?cVdNNXVML1IwNjF0Q2JENGxIT2grVG1MbEdpY1hyVEV3OFlvTlZkV2kxa2dL?=
 =?utf-8?B?OCt2WGErbThiUmEzbzk4cGRFNUhMR1pjVnU2UUpDS3VsUU5NdFpEODhhS0tP?=
 =?utf-8?B?Y2JrODhjU0VXL2NoeVo4UXZONmJ5QmFIRmg0SzlzOXFCQ25ZNkQ0Rmk4TnVO?=
 =?utf-8?B?YjJGRTk0ekZkZVY5T3hLVG1INWNMNjA2SUdQc3hka0pCaGptTStHMlEvZkky?=
 =?utf-8?B?Rkw1V3M2RVJVV1lUaFFQTER3L2xROHBNMEEyVkpGSUxiWHBQaHBpaHUvV0Fp?=
 =?utf-8?B?dVNZUzFTb0gwQTUvUmRDbU9zU2lnY3lLRGVGUG9EcGRidS9nbVlRUkNJY21X?=
 =?utf-8?B?YnRyZVBydllHZ3BMamxBTk41cGx4ZER2RDB1a2ZxUS8xaG5STE1GanFpbXEr?=
 =?utf-8?B?RFdmUDNqcVdqZFpjS1ZxeWlJZGlCS3RSR2x2a01WdXhXeVhDcE9ucndRQ1Y2?=
 =?utf-8?B?VkZiSHM1Z2JTMVVSZ05kTzFzTnBkaXl2SGRGRk8wUkxYS1g1cjhQVEdUSFFN?=
 =?utf-8?B?SURhTFJQYjdoUVJkOFU2MEkzMC9NYTZJeXc5RFljWWpvWlozQUl4QklSM0ZK?=
 =?utf-8?B?QXZEdkpjL2F0L1U0UGlJYzJkeTd4czVuNTduMWgzb2xCV0xEbWpKTmdMd1kx?=
 =?utf-8?B?UXUySVJVcjF6ampuVjcwTC8vdkREWi9NNk9qcXFxYStKTEdXKzdYYXQyOHpP?=
 =?utf-8?B?L1pBSkVmQkdpdmJSQVBJZHhxZE9pck1hcGp5a3J5L3E1dSsrTHVIMlRJb2tM?=
 =?utf-8?B?VHFiMWIzRHQ5c2k5aHN3dTQwZVU3NXdzMUlNODVHaVZDaVRQNDRJanlublp6?=
 =?utf-8?B?QWJNcVJWWDdrcDJ6TEJJUmVTSStFdFhLSEF2NDlZN0lGbmwyd09KN0RBaVV1?=
 =?utf-8?B?UldmYWgwQjQyM2ZWVWs1OCt1RnRIdWpmckV6WGdvMlJoVjFJRENCbXRocGxw?=
 =?utf-8?B?c1ZiQlhKMGV3WStnb2NCQ2gzU3RobEh6TVRWQUFVZWZ4eDRPWmxudTk5UktI?=
 =?utf-8?B?dlpSZXFoSWdtN2dsL0V6akNHN1pod280SHdNY2tKbk1QUkFFaVpvWXkxSjNR?=
 =?utf-8?B?OTgwaEFaL2cwWkQzOFJ1M0s2c2c3SlRvd01McDFodU1VZ1l0RjJLYnFJblFE?=
 =?utf-8?B?VmY1YnpTcHFRNTNGZk02UWczb3pOUERYaWJ0WHQ2ZWxFVlFKWnhDS2VvSGgr?=
 =?utf-8?Q?+/gW+Qb/MbhChv6GQFCOymJQ8uEuCc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 16:06:50.1785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dccf0c1-2690-4be5-51ca-08dd63db6525
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378

Hello John,

On 3/15/2025 10:40 AM, John Stultz wrote:
[..snip..]
>>> @@ -6856,6 +6873,10 @@ static void __sched notrace __schedule(int sched_mode)
>>>                 * changes to task_struct made by pick_next_task().
>>>                 */
>>>                RCU_INIT_POINTER(rq->curr, next);
>>> +
>>> +             if (!task_current_donor(rq, next))
>>> +                     proxy_tag_curr(rq, next);
>>
>> I don't see any dependency on rq->curr for task_current_donor() check.
>> Could this check be moved outside of the if-else block to avoid
>> duplicating in both places since rq_set_donor() was called just after
>> pick_next_task() or am I missing something?
> 
> So this check is just looking to see if next is the same as the
> selected rq->donor (what pick_next_task() chose).
> 
> If so, nothing to do, same as always.
> 
> But If not (so we are proxying in this case), we need to call
> proxy_tag_curr() because we have to make sure both the donor and the
> proxy are not on a sched-classes pushable list.
> 
> This is because the logic around pick_next_task() calls
> set_next_task() on the returned donor task, and in the sched-class
> code, (for example RT) that logic will remove the chosen donor task
> from the pushable list.
> 
> But when we find a proxy task to run on behalf of the donor, the
> problem is that the proxy might be on the sched-class' pushable list.
> So if we are proxying, we do a dequeue and enqueue pair, which allows
> us to re-evaluate if the task is rq->curr, which will prevent it from
> being added to any such pushable list.   This avoids the potential of
> the balance callbacks trying to migrate the rq->curr under us.
> 
> Thanks so much for the review and the question! Let me know if that
> makes any more sense, or if you have suggestions on how I could better
> explain it in the commit message to help.

Thanks a ton for clarifying. I found the enqueue_task_rt() bits from
Patch 5 and then it made sense.

P.S. Could the enqueue_task_rt() bits be moved to this patch since it
fits here better?

I couldn't see the dependency for the enqueue bits in Patch 5 since on
finding a "blocked_on" task, the logic simply dequeues it and since
proxy_resched_idle() will nuke the rq->{curr,donor} reference before
that, it should be safe to move those bits here unless I missed
something again :)

> 
> Appreciate it!
> -john

-- 
Thanks and Regards,
Prateek


