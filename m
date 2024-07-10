Return-Path: <linux-kernel+bounces-248044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2392D7AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1379F1F2103C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A311953A2;
	Wed, 10 Jul 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VudZlWXI"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E434545
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633329; cv=fail; b=EOy+DumwJYTDt2/i1KSHwyj3cowwFm+823tbMoed3jCOfaD/HzTcnXu85NNxSwTOmkOAjzGQE4AIA/wdoVj8HJ95MNamjDYqWFdMvNO7K3S5gVXUdTAjWvvHeGkLmssIFAHJLPJgId1K9FPzjKgWlOcdoEUPsCx2osKih1qt79A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633329; c=relaxed/simple;
	bh=o6JJOTa29ybeviEOkcVd42Gh6OvIBOOIBZyDfCD1G/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I2hwjDG5Awv5yPBJdiAktNh0biiIYBr2PX0M37WETE4/VRBHa7QU9+GjgSXb9i8Qscg/AFewmLsxyoSR9e/FaBiMoANsk5gnT6ljRWpopSraP5ldHYzm9ecYrvWzoG9EkVPZleh7JiEbpnwbEBQNohbhfVp52Rs0C/+vlAnQFzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VudZlWXI; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPF6zm2E1IU76aZfjbStNIzQE8OCi7W/9mQF8TmzRsLKR3QmjKR4aXfb8ayVakvr3xNTLnYsu990nKy3pxnMb3hL0/25TwUHUOJJai3dxBJBvEZ/8Fi7pqEIciqcXRg7mFu5mmU1OW3o4Pht8gxv/6lp8+ZyCRb6DwP51cpG/3SWa9A26k+4qqA/LYaH+GqUa9/HiTIsOH3n6EgUZT4my+5h7f3TE9gy2ZtEvrKs/wIBnmqjzA8t2x3mlnxk04Ny8FIW535zIcsWl23qOCwDuWKO2Czcte/0/xiD9dhqJXS2M+TxVEwWukOAqictt/K5xYlEXFn3W8WfR7C4MqZhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzlC9Ekrq64mPYYN2vEBwADc7uNt5v4P//E5cI3kYzY=;
 b=Kbhy5JBh4f0vFN7gfcsv36xC7d7JrBOthGIiwIUZudTsDsVrNcFfRk7VH+ank3x4YJcWjqCa32vyLPYGfqDkXiKVjgl25FYreBJwR8/9RdpOWItBLLC+3i7O5wwmz/PtS3Xla/ykEe9l12suafdpqFH/BaO87otcRVkrKCjGIswi8G7SJIh5jg5rsTeJALtCzlqd1eh1vgbNMYp7WODzZeK+MRR1CS6OaiDEMgS2XC6dUluOs8TIjbeKaI6P8FpfIT8Py31E++WkLsbHx6Ci0Uq6TVK5m/MwYbr7/1895VLR3I2o2ttYhb1EkMIEUDwfH2ws5wsE8A25qwmaRpjUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzlC9Ekrq64mPYYN2vEBwADc7uNt5v4P//E5cI3kYzY=;
 b=VudZlWXIekG1xsHdL2Iq5ykppw+7Hjtc9lv8W3R6c+itwvgb9sUkHeJsX3+dbGyAiebZKixXgVKBHCkPxesPbfm/nWDMHo3xcJC2jmCpGKQchHFrjt6WVUurh5JPlxdFOmdJCxgkWdjh10nufOjbTb8BklUJnPdSTCxUC1m/t54=
Received: from MW4PR04CA0234.namprd04.prod.outlook.com (2603:10b6:303:87::29)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 10 Jul
 2024 17:42:02 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::7) by MW4PR04CA0234.outlook.office365.com
 (2603:10b6:303:87::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Wed, 10 Jul 2024 17:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 17:42:02 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 12:41:54 -0500
Message-ID: <d293d88c-b83b-a955-de5e-db775f20c1e1@amd.com>
Date: Wed, 10 Jul 2024 23:11:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v11 1/7] locking/mutex: Remove wakeups from under
 mutex::wait_lock
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
	<vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
	<youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon
	<will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
	<boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya
	<Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner
	<tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	<kernel-team@android.com>, Davidlohr Bueso <dave@stgolabs.net>
References: <20240709203213.799070-1-jstultz@google.com>
 <20240709203213.799070-2-jstultz@google.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240709203213.799070-2-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e9a200-6fe8-428d-30ca-08dca1079b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1VtMUU3NS9hUGhXdnV0bE00ZmVHY3hEMmVBNUIrVElpcngydFpPbWQ4OGdV?=
 =?utf-8?B?R1NOOVBBQzhWanJuenpSMkZYRW41RngwSmwyTUNsZlFESnhCdHEraWRIVW1y?=
 =?utf-8?B?bXN6WjFvdHI0ZVQzNUhxTElWUFQ2V3BNR3crdmxtbmJBdDhIMDYxcEErTnJL?=
 =?utf-8?B?K1VDY2gxTm9uTDc5SjExM1M4TnozQ0ljM1krUUtoQWh4aFkrVExJY3Z4ayt1?=
 =?utf-8?B?eTl4RlZZbTdxY0ZKanJPcWJ3RW1tb1pMQkY0eEVXT2dUWS80TW9vT2kwTUJ4?=
 =?utf-8?B?SDJNMCt1RTBmd3daVjBuR0JEUEQzakNoYW5lNmJ4NXdOMHJMa1MzNytGdkp0?=
 =?utf-8?B?UkRrZUhCMHFYOEU1UWFQa3NBK3V6WmsrbTJYaERsYXQ4alZNOE5ac295S2pM?=
 =?utf-8?B?NWdFOHUrRXV2Rm01WHo3d0VXR0ozRkdBdVNsbEtzbDBvSjBzR1Z1Qk1jMjV5?=
 =?utf-8?B?WEMwUEtBQWNWK0JtVGJDb3A2Q29UZ2pTdnorQUNRYjF5OGRiK2kyVGx2d1lp?=
 =?utf-8?B?ZWd2bTdMVUxNdFNCRE05aXh0M0hLU2ZVQU5JUG91SUE0NGZmM09YWnRBYU9N?=
 =?utf-8?B?dnNQd09JRFN2bFJkUEpCaGl2dGpWVGVxKzcxaFE2dWpYK0hrc21lWEhjcHdh?=
 =?utf-8?B?aUx1Um5Udk8wTjRZd1VRMzgycDVCNUdFUXdXMzhvbHFWbmtZcnJsTm1CRVM4?=
 =?utf-8?B?ZXdaejZIcE96SjhtT0lLcjJmbkljZEllTUc2QXZNeGxGM0hPUHpacEd6RGMw?=
 =?utf-8?B?OWJYdDNnTWY2QzVEZlAzdUY0Z3krNnN4RGJZQWRWVDVsek9CTkpqTG5zNEpV?=
 =?utf-8?B?TUtidWZ5cksrdmFhV0p6cmh0d2tBMFJnRVFyVW1HZmdhOEFqUVZrbHRuVUsw?=
 =?utf-8?B?WnJsQjdiQXgxeHd0WndwOHY4UnhSY2x5SWhDYzZLVGZjdGFxYjQ0Vm9qU2d2?=
 =?utf-8?B?ZUcvdlo3WGd1ak9rR2FkNWRoQXd6NGVrNkFyZzFPQ29jbWJoN3BoVFN0YUha?=
 =?utf-8?B?U2xwY1VPL1FOZ21qcXBwbHdBaUVUR1l6Slk3NTlJRTZWMEY2TEtGUmZyN1Ja?=
 =?utf-8?B?Y1R2U25mUFJxSU00MVhzdnZHZVRiU2grY3RndVFCcDVjUU5hYzJJYkFZd0dZ?=
 =?utf-8?B?WXl2Q2E4di80a01HN1lDRlZWaDZnR3Rha2xGb1BhYnBtTWR6TDZic1N0RU9M?=
 =?utf-8?B?K0RLT1ZFczFvMmNTejY0QURZUUFUVUNQcXYxRjVvYmFWY3dXV3dsVlNZc1lI?=
 =?utf-8?B?OEhtYnAvU3ljOG95Y3kxa1NkQld6MkE5UGQ3cHJEVVl5dWs0Y1ppbFlaY0FT?=
 =?utf-8?B?WFdmT0JNMlBwb2tmZjVIWlJoVHBXcFIrNi9vMFFMZ0M1bDFHQ3VCY2JxRDFP?=
 =?utf-8?B?a3hMREJwZm9Cdkcvcnk5TzZYMVBYN2tXUXBhYlhiQzhBZXlRMmpHZ2hqN2dM?=
 =?utf-8?B?Z1A4UmFLY0Zjb1lmTmJlMG1JOHc5MXJwRUdraVNZbS80SlMvSnBQaXNhYkNz?=
 =?utf-8?B?c0ZzcTNQbkdqNlJ1K3VsUFJBVXhwNGx5NjBzd3A4QmZLRW1ZUjhFNkNyMTRp?=
 =?utf-8?B?NDlPR2k2RVNxd1hkQ1dLWnY1Z2hxZVJDTXhXbW5Hait0aEVGVzVOWjVUK0Qv?=
 =?utf-8?B?bjhRelhhYUlSZElSRDg5OGVrYTc5VjFKbHhOeDl6VlJ3dUlKa3pIRkdKb1RN?=
 =?utf-8?B?K1hyUmdVNTlKeGdmZjJZbmNVT2pFaCtDWnFERzZ3c3FEWTFDWUN3TXhiSVNM?=
 =?utf-8?B?ZGx4TVlDSEFRblJHVHdGMkp3N1FxRVRqTWJBdkZMeFJUbW5MbHJEMjdkS2ZK?=
 =?utf-8?B?OGppckNMeTlYazgxV3BXdzVBeE5nQ3pQK3dHKzVqNWcwMHEyMzFvcVZIWjk4?=
 =?utf-8?B?K1NpSmVORDZ5a2xqeDVERjIyTTk2ZDJDZVZWSGE2K05hM1JEM0J5SllEU0d3?=
 =?utf-8?Q?CXVTEcGZr3gZrJX/yRbrE8x1BrhbVq1Q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 17:42:02.2138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e9a200-6fe8-428d-30ca-08dca1079b6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195

Hello John,

On 7/10/2024 2:01 AM, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> In preparation to nest mutex::wait_lock under rq::lock we need to remove
> wakeups from under it.
> 
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: kernel-team@android.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [Heavily changed after 55f036ca7e74 ("locking: WW mutex cleanup") and
> 08295b3b5bee ("locking: Implement an algorithm choice for Wound-Wait
> mutexes")]
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> [jstultz: rebased to mainline, added extra wake_up_q & init
>   to avoid hangs, similar to Connor's rework of this patch]
> Signed-off-by: John Stultz <jstultz@google.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: Metin Kaya <metin.kaya@arm.com>
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Metin Kaya <metin.kaya@arm.com>
> ---
> v5:
> * Reverted back to an earlier version of this patch to undo
>    the change that kept the wake_q in the ctx structure, as
>    that broke the rule that the wake_q must always be on the
>    stack, as its not safe for concurrency.
> v6:
> * Made tweaks suggested by Waiman Long
> v7:
> * Fixups to pass wake_qs down for PREEMPT_RT logic
> v10:
> * Switched preempt_enable to be lower close to the unlock as
>    suggested by Valentin
> * Added additional preempt_disable coverage around the wake_q
>    calls as again noted by Valentin
> ---
>   kernel/locking/mutex.c       | 17 +++++++++++++----
>   kernel/locking/rtmutex.c     | 30 +++++++++++++++++++++---------
>   kernel/locking/rwbase_rt.c   |  8 +++++++-
>   kernel/locking/rwsem.c       |  4 ++--
>   kernel/locking/spinlock_rt.c |  3 ++-
>   kernel/locking/ww_mutex.h    | 29 ++++++++++++++++++-----------
>   6 files changed, 63 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index cbae8c0b89ab..4269da1f3ef5 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -575,6 +575,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   		    struct lockdep_map *nest_lock, unsigned long ip,
>   		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
>   {
> +	DEFINE_WAKE_Q(wake_q);
>   	struct mutex_waiter waiter;
>   	struct ww_mutex *ww;
>   	int ret;
> @@ -625,7 +626,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   	 */
>   	if (__mutex_trylock(lock)) {
>   		if (ww_ctx)
> -			__ww_mutex_check_waiters(lock, ww_ctx);
> +			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
>   
>   		goto skip_wait;
>   	}
> @@ -645,7 +646,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   		 * Add in stamp order, waking up waiters that must kill
>   		 * themselves.
>   		 */
> -		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
> +		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx, &wake_q);
>   		if (ret)
>   			goto err_early_kill;
>   	}
> @@ -681,6 +682,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   		}
>   
>   		raw_spin_unlock(&lock->wait_lock);
> +		/* Make sure we do wakeups before calling schedule */
> +		if (!wake_q_empty(&wake_q)) {

nit.

This checks seems unnecessary (to my untrained eye). Any harm in
skipping it and simply doing a wake_up_q() followed by wake_q_init()
unconditionally?

> +			wake_up_q(&wake_q);
> +			wake_q_init(&wake_q);
> +		}
>   		schedule_preempt_disabled();
>   
>   		first = __mutex_waiter_is_first(lock, &waiter);
> @@ -714,7 +720,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   		 */
>   		if (!ww_ctx->is_wait_die &&
>   		    !__mutex_waiter_is_first(lock, &waiter))
> -			__ww_mutex_check_waiters(lock, ww_ctx);
> +			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
>   	}
>   
>   	__mutex_remove_waiter(lock, &waiter);
> @@ -730,6 +736,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   		ww_mutex_lock_acquired(ww, ww_ctx);
>   
>   	raw_spin_unlock(&lock->wait_lock);
> +	wake_up_q(&wake_q);
>   	preempt_enable();
>   	return 0;
>   
> @@ -741,6 +748,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   	raw_spin_unlock(&lock->wait_lock);
>   	debug_mutex_free_waiter(&waiter);
>   	mutex_release(&lock->dep_map, ip);
> +	wake_up_q(&wake_q);
>   	preempt_enable();
>   	return ret;
>   }
> @@ -951,9 +959,10 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>   	if (owner & MUTEX_FLAG_HANDOFF)
>   		__mutex_handoff(lock, next);
>   
> +	preempt_disable();
>   	raw_spin_unlock(&lock->wait_lock);
> -
>   	wake_up_q(&wake_q);
> +	preempt_enable();
>   }
>   
>   #ifndef CONFIG_DEBUG_LOCK_ALLOC
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 88d08eeb8bc0..7a85d9bfa972 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -34,13 +34,15 @@
>   
>   static inline int __ww_mutex_add_waiter(struct rt_mutex_waiter *waiter,
>   					struct rt_mutex *lock,
> -					struct ww_acquire_ctx *ww_ctx)
> +					struct ww_acquire_ctx *ww_ctx,
> +					struct wake_q_head *wake_q)
>   {
>   	return 0;
>   }
>   
>   static inline void __ww_mutex_check_waiters(struct rt_mutex *lock,
> -					    struct ww_acquire_ctx *ww_ctx)
> +					    struct ww_acquire_ctx *ww_ctx,
> +					    struct wake_q_head *wake_q)
>   {
>   }
>   
> @@ -1207,6 +1209,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
>   	struct rt_mutex_waiter *top_waiter = waiter;
>   	struct rt_mutex_base *next_lock;
>   	int chain_walk = 0, res;
> +	DEFINE_WAKE_Q(wake_q);
>   
>   	lockdep_assert_held(&lock->wait_lock);
>   
> @@ -1245,7 +1248,10 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
>   
>   		/* Check whether the waiter should back out immediately */
>   		rtm = container_of(lock, struct rt_mutex, rtmutex);
> -		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
> +		preempt_disable();
> +		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx, &wake_q);
> +		wake_up_q(&wake_q);
> +		preempt_enable();

I'm trying to understand this - we enter task_blocks_on_rt_mutex() with
"wait_lock" held (I believe the lockdep_assert_held() in the previous
hunk checks for the same). I walked down the call chain (although
briefly) and could only spot "task->pi_lock" being locked and unlocked
before this call to "wake_up_q()" but the "wait_lock" seems to be held
throughout, only being unlocked and locked again for
"rt_mutex_adjust_prio_chain()" later down.

Did I miss something or is disabling preemption for this specific hunk
enough to enable safe nesting?
--
Thanks and Regards,
Prateek

>   		if (res) {
>   			raw_spin_lock(&task->pi_lock);
>   			rt_mutex_dequeue(lock, waiter);
> [..snip..]

