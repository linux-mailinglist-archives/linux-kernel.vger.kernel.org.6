Return-Path: <linux-kernel+bounces-408762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C2D9C833F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5069B26358
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413831E9074;
	Thu, 14 Nov 2024 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FZph6SXc"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140551E9066
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566268; cv=fail; b=ouDyrk4YUgaelyYcceq90Gd4mXP3vLGEkJd4jfRcQxfCZ7jsrpqrW/tzhvIW0kUllQGsamMZM9Bhabf5htDGOab5YfXvxOVjttvMo+Mx0zM42G0qCwyApEI1ese6tRTWEZQSNGfkA/r+Kv2SDNR+AH/t5DE6Wz9Ln5WfNVx64XA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566268; c=relaxed/simple;
	bh=S1ITSiVYcZCZSfgAvq4w2UeGU0WTmSiCFFr96ctWZPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uibrS1lBPnDu4SXQl83cHxMfD+iXfClC2rOZnx/km8MnOF6VyE7wmrUh4z7EqwNwVD0LZ7vuEJVKHjC0Jgam8vNxjDj5kW5Cx8C93270fpIeFZPLsOheNeC9yYM7WeQ1qwV3H+kG7QW8gFOS35ZL2etPVb129yC4ajnn+LFBc9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FZph6SXc; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K53SvxPv7cJsP/iJK8UvWKQp3FWgRYq9/EzfHvWhCx68ncO896j01alIHX6BRjr9WcqF3I6XsxjWP7+BUfcdIZ+eeXJKNVycmpzRGwg2wKO5jYhgZk9lgSyyjT/TtsQ6giJaooXKzLjhH9JNg16ybKJGHyis/YE5NYP5GkPqt4+/lUZJhWLeG2wH8vELZvgPE6mYphF1KS31BLGZkT/vUdPSA37zbQoccdN16GOQhmc09GLBzJcKSagJ3wje6xmhuQcld2RrZ336/eUZh8NGED84GQh9U48V3nklB9l65+aS2vz2yVpe1yIl1zoKo3qdt6MbziB7YLyjTub7wD5q8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOvuXLX2rhFAJqerfpdM/r723ToC7BTxrDappF/Y9ak=;
 b=Uqe/Ti/0GpQNeTuMvw/V40OwKNrwzUD0cF6/Whk6MDS6N4A2NZN8OrxPMXHxDN7rOfxKLHqwOq6GBU9ET/19ChtqLahyVJY22bX5mrhJ85Oeoip1Gd5oSa5AlaLA+JnxYjiIIsJNwU+rbo1Oupd+lrqc47FKM5C2U1iIr1ey6IJwPaV0nX8Ubn79SC4TwVaLBcMLPQFw40GaEqucdLxI1qv59JTsQcLGekaEN6cZ4VUDEinsNjfNRZZ7yA/qgcC4iA69rgqY5tPm6F2nD/8lDR2SE89Mx9kZ5/PXuNeeiugvmGioKmmx8IyPYqXFqJiLF8h7hXOpCVy1LRhbA26dcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOvuXLX2rhFAJqerfpdM/r723ToC7BTxrDappF/Y9ak=;
 b=FZph6SXc2l967lhpA3vsAVFt7c+OLUbBVT6RfRnCcXhlRAv7wJghDhLAfGSSUeswKOObYmVozk7k5uIq0OHMV0+OkVeTfdFjQWmucfrtSeaMsSQUOgubR4V1sR/uhkcdgi5j2LiIIujZvadzJDbTOj2ZJxgYAYud87sW/ZmyCjE=
Received: from PH7PR02CA0014.namprd02.prod.outlook.com (2603:10b6:510:33d::34)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 06:37:39 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::36) by PH7PR02CA0014.outlook.office365.com
 (2603:10b6:510:33d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 06:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 06:37:38 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 00:37:28 -0600
Message-ID: <f6dc7b18-e9af-de0f-7871-6ceb24e24459@amd.com>
Date: Thu, 14 Nov 2024 12:07:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC][PATCH] locking: rtmutex: Fix wake_q logic in
 task_blocks_on_rt_mutex
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
	<vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall
	<bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman
	<mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
	<xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, <kernel-team@android.com>, Davidlohr
 Bueso <dave@stgolabs.net>, <regressions@lists.linux.dev>, Thorsten Leemhuis
	<linux@leemhuis.info>, Anders Roxell <anders.roxell@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>
References: <6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com>
 <20241113215252.3977066-1-jstultz@google.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241113215252.3977066-1-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: 8890cd21-c1ae-477e-2b27-08dd0476d53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm5CTVZlengzY25PMEQzcklCbEIrQzRaSlJvOFNySUJaNXlySEw3ZE12Vmc5?=
 =?utf-8?B?aUpuQ3pMN2R5eDZUVlFNWVBuOUpXVDVsME90NXg4UzNmNEIwTkQwTks0N2N4?=
 =?utf-8?B?aWZ5VHMrU3VqVnRTdCtYcFVaay9OOGtQWWRkdzIyMDZJdnJmTDNnOFU3SU01?=
 =?utf-8?B?NUpteTY3V3pHSlJkKzF0NkNHTENuRzJXT2FXS2VsV3RoTVE0WmhTWnBCL3JP?=
 =?utf-8?B?REVEbERyOVRXWStOSjdpSTRoVFFaWUVYQXptUmdTRVIvZDdrOFEvY3NKNFNv?=
 =?utf-8?B?dkFrWmQ2NzJDMWVCTmpaNmp5VDc0RS9reFhkRjVsYnVpWmZGalUxa3VPYUVr?=
 =?utf-8?B?K2xGalA4d3pWcW92UGc4QUFTUzkzZEUzUmswVHNxSXlmWmNlU2xZK1VHVm9n?=
 =?utf-8?B?V1dwNDdnbHIxR20zUzJtUGpDSUdzMmRXRkwyRy9VSUxEYWlCWGlaSHdlVGxG?=
 =?utf-8?B?dU5TbXM1alFhcVd3RE1KNnhNQUpINnFNeDZTdyticVFYUnROTDZBS0RzQ1RU?=
 =?utf-8?B?cTFzWUVNSmI5UXVKUnR6dDk2WmdIdVIwYjNzT1BxZ2laZHJlSnJvZEl0ZGtr?=
 =?utf-8?B?Skh1VElsaUtJZks1KzRDZXp4RGo1S3d6UEdhZmRIVGtJRmxpMFp1TVd6MGVn?=
 =?utf-8?B?QWhoZ0l0ZEZZQTRlZGI1VVVJYWpPRHhiV0ZxNi9kMjZnSCtxRm9WL1BhTmx0?=
 =?utf-8?B?ZFpSRHNqSFgrbFFibWRRdUFRdkh6MElhVUtnVGxaN0ZadXZ3am5RbWg3VXU0?=
 =?utf-8?B?ZnBBZmpvNHhuTU1FWElDeGlTUFp3NG5IWWVNWHdJQVAvTHQvMHkvK3JjcUNv?=
 =?utf-8?B?Q3lqNzFlODIxOTllTHJwZi83SkFsY0xjaXVQWmFtY2dNaW1aVTNKUzJ6K25a?=
 =?utf-8?B?dnBNUTVRMFZpMGFOY3pVczA4VWJXaEgrZE1YRFIvR3FqVGVNTUJSMXRUT1ZO?=
 =?utf-8?B?Vm1CckhUUmZ1anJUN2x2NmV6UjFDNXUvc1NQMlNudG9PSE40cTArdGJ1Ylk0?=
 =?utf-8?B?NkxZYStIVVZBL240TUZJZTh1S3A1eTlVSkZ0YXVHeTlKWnpSdGFNVU1Db0w1?=
 =?utf-8?B?a3AwUDFNYmoxb0tiblZqWUlGVXhuYm5HRjNTQjJ4TVlrejc2aURMUlNCRFRO?=
 =?utf-8?B?STBDSVFmMFNLdDdXcEl5d2RxY0lRdDlnUVBCRHVCR1pVS0lrVmx5MEh2VHV2?=
 =?utf-8?B?T3NPWFhMbkxITTZjQmxNdkNLaGhnRjRnVFIxa1Nha0M0ZzRlVEl6dGpTcFVn?=
 =?utf-8?B?N3pnL0dLRDlYSDY3T0o0K2duYkxFUmxmOUs1RXBMTHpmRXlpQmdXd3l1dmg2?=
 =?utf-8?B?WGQ2ZTNsdDlaTitnelYzRmVqUXUyTXdtelVDOGpiaGNoYlVjUkFNMjF0Q0Rt?=
 =?utf-8?B?d2lOR2NtZ3VocS9CQUczbkc0SlFPbWdnSE91OWluRmxUcTZNK1ZPWitDU0Rk?=
 =?utf-8?B?RjdZdS95YkpwaWVaSWpiNVMvdnlhSGlXU2JYeEdGZWUrNXkwNWFnU24rY2li?=
 =?utf-8?B?azhJZjU2U2JqSGprajhxSWJ0K0hEeTgxZ3Vya3NhQTRweXlYeWE3N3FOenhz?=
 =?utf-8?B?YmtNSTdSUzhGVzVnSVJpd05GOUhqa3dLM01HdkNIM2l3WU9KM2lNb2hFZW5X?=
 =?utf-8?B?TzJPU2swbHlZeFRtNDQ1THRRODhpV2ltMXYvZnJCN0Q1YWxrQXQzdFloZFhV?=
 =?utf-8?B?T2RFN1VRaWx2eWNPdWV0b2JSR2d1UzhYMXZkcytpOXlrdXVjVnFNRTZBMytY?=
 =?utf-8?B?VmF3WGtUWHVKOUJEeVRRWjNOeXF4SEdDbFM3bnorTmNkZUZkKzNra09wSGZh?=
 =?utf-8?B?aXFEano1YlhkY0l5TnBZWk8yYitYVEdVakQvVWJzalhaeEpaSEpWNzB0MXcw?=
 =?utf-8?B?d1hTckJXY21ycDEwZnorTTlrRWp3MlVkVGRTVElpVkc2K1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 06:37:38.4836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8890cd21-c1ae-477e-2b27-08dd0476d53b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047

Hello John,

On 11/14/2024 3:22 AM, John Stultz wrote:
> Anders had bisected a crash using PREEMPT_RT with linux-next and
> isolated it down to commit 894d1b3db41c ("locking/mutex: Remove
> wakeups from under mutex::wait_lock"), where it seemed the
> wake_q structure was somehow getting corrupted causing a null
> pointer traversal.
> 
> I was able to easily repoduce this with PREEMPT_RT and managed
> to isolate down that through various call stacks we were
> actually calling wake_up_q() twice on the same wake_q.
> 
> I found that in the problematic commit, I had added the
> wake_up_q() call in task_blocks_on_rt_mutex() around
> __ww_mutex_add_waiter(), following a similar pattern in
> __mutex_lock_common().
> 
> However, its just wrong. We haven't dropped the lock->wait_lock,
> so its contrary to the point of the original patch. And it
> didn't match the __mutex_lock_common() logic of re-initializing
> the wake_q after calling it midway in the stack.
> 
> Looking at it now, the wake_up_q() call is incorrect and should
> just be removed. So drop the erronious logic I had added.
> 
> Anders: Can you double check this resolves the issue for you?
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Benjamin Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
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
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: regressions@lists.linux.dev
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Fixes: 894d1b3db41c ("locking/mutex: Remove wakeups from under mutex::wait_lock")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/6afb936f-17c7-43fa-90e0-b9e780866097@app.fastmail.com/
> Signed-off-by: John Stultz <jstultz@google.com>

I've been running rtmutex_lock torture test in addition to a few
standard micro-benchmarks with the fix on my system on top of
tip:sched/core and I haven't encountered any splats there. Feel free to
add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> ---
>   kernel/locking/rtmutex.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index c7de80ee1f9d..a01e81179df0 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1248,10 +1248,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
>   
>   		/* Check whether the waiter should back out immediately */
>   		rtm = container_of(lock, struct rt_mutex, rtmutex);
> -		preempt_disable();
>   		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx, wake_q);
> -		wake_up_q(wake_q);
> -		preempt_enable();
>   		if (res) {
>   			raw_spin_lock(&task->pi_lock);
>   			rt_mutex_dequeue(lock, waiter);


