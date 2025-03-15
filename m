Return-Path: <linux-kernel+bounces-562660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77234A63015
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBB51769DF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCC41F866A;
	Sat, 15 Mar 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pnHFYNfh"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397021885B8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742056521; cv=fail; b=q33xHaxUQuBXMhz+aY6iapXXulbHFmOKPY0ELp0WVq9yofMUcEHntyRwR4sYskHUGzvFQTvX6Ei0ehTnX90LNvgqKXSv14y0PWLf8btQPMmvfpywJgeD8IaIByJvJdz57rnnBp4pM1N2UZPdVHcE0tlpKu6Bjnd3IQEpWZDkGVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742056521; c=relaxed/simple;
	bh=i21faXSFtoIJjh6Kfjrhn/EaqJM6NWtZiMsNq0w/LBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qKiQgc67TbbT5XyiGribE6AWTzgFymIDac7JRTUolqkRTJ8jnqeX/jvEsv01zN3xzpX2+CNYl8rsAscs6lefoMyn0ds7mnFP3GZdWPyWbV7uRzO3aYpssHTMIDgQEfjVa7hDkfFe12Wre/fd+3R9Cd3EhoytXS12G2cI55nJLVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pnHFYNfh; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wb6HJ5E1rezCKkJUt7OdpEt5dcyN0a/Il7fTpbs++1DhnSpkEyMB44Ft/fycKQHVNBl7AaBMeyqXXpXhmfj2+xmNwSDMlbn+2ij3DHzmNYO9f9z6oxiziegqNrsBXSecr1p+mo1neXv3OSTtqoxL3WFeMqerkiLTUVajHf+93PDe0IYowr7COykOsXUT/n8TsEzmC6ydW9I0tPHDBTn5uGrSSWWcrB/Vzq1q2dHcjCt2Qfm+GzSBSKjXchgz62XKlXurLCiKCw6urbn8QwkzxrI5zA3FkUGYD5Cp9FFKAU8NZSUWL+adMy1KGF+jWRmPPwFbRz/LM3FooATyERhZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCGv4g+QMXjz6ikdhrV4Kt8PZlJm2DBK0joaCUoUTw0=;
 b=ZYAop5uam1gPGy+lDfYDGrgkWMOjrstJrlLwuEHCntghurekF4DXqrnjD0jEHwQ5N/Evlj37OVH91jCzG8oAyjSyVohmMAGAZNLEoCRZc8eU6QKkP3zHL8sC3GQWazP8vN7bH/9fedZIAT+kEH9FOwdKY1LxmVzuFNgTBmtdPNyz20ZS5bhoGLriZZvzFhgbY3gr6zhNoT5PGfwJEamRrP1b/Z1IVzpm2VHoUep7sfA8iIYDge0Z9guApvs9PKWGCaYiMfHOpJ3PxqjGCURwCh9NRV09yrhUI5uySkBsVrJBMLAQ88HYTrQW5VfnEdidyhwzX7YWkwEYUS9bP4REXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCGv4g+QMXjz6ikdhrV4Kt8PZlJm2DBK0joaCUoUTw0=;
 b=pnHFYNfhsvnkLZeoA2IgsYwdrvZJyhFdzdZ8EYFmfT50JQHCp+85iJUfFkOTDIoNuKoTYk8s6QN3bkLSckhWm0MENOuwi+FxE+3q++H72HX7cGxe1djg5cs9lEooZTMDB0rHqSQ+grJM+e0QYwuhnmzjFVhIWV5bdlr1XUheEtc=
Received: from SJ0PR05CA0096.namprd05.prod.outlook.com (2603:10b6:a03:334::11)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Sat, 15 Mar
 2025 16:35:11 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::7e) by SJ0PR05CA0096.outlook.office365.com
 (2603:10b6:a03:334::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Sat,
 15 Mar 2025 16:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sat, 15 Mar 2025 16:35:10 +0000
Received: from [172.31.188.187] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 15 Mar
 2025 11:35:04 -0500
Message-ID: <cb735bbd-e4db-41b4-95fd-b7b85f040e4e@amd.com>
Date: Sat, 15 Mar 2025 22:05:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v15 5/7] sched: Add an initial sketch of the
 find_proxy_task() function
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
CC: Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
	<vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman
	<mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
	<xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>,
	<kernel-team@android.com>
References: <20250312221147.1865364-1-jstultz@google.com>
 <20250312221147.1865364-6-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250312221147.1865364-6-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4f1e07-3b9e-426d-eb12-08dd63df5ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azNBbThqZlEvZkFOMmhyT2Y2TGV2V2hWWEVXUUhhRnRlcUhxNnRCNDAvL1Y0?=
 =?utf-8?B?T29jWTE0eTVsVm9FY0xaTXd0M3lKWUVjM2VVamtJLzFOdS9Pd293MjZWUzZF?=
 =?utf-8?B?Vk9Ud2xOZHYxaytGdGFSRlFIOEk2OHRCYTFsTVhuaHJ5eVZweS9MTVJKeXJD?=
 =?utf-8?B?Y0JQUzM0c1F2SUNWLzFVQ2Fha0V5dHN4Z0hkNUhsWEhVU1B2UU9nRExvNVUw?=
 =?utf-8?B?WUh0eG11b1hYMUFjRU1SNHlrNmZVNFFMR3NaQWxSc3g3YStudm5Ha1QySS8v?=
 =?utf-8?B?ajN5VWV2MlEvd3RNM2prSzNBbmQxUjdTSEtzcThXcEttbG15VXVUbGRPSE5C?=
 =?utf-8?B?UkRuTm53Um1KVHdKWGE2UU5Fd3RPY1JjVUNCTnc0SlVSSmJ1UmpaZklIV1VP?=
 =?utf-8?B?ZFhKVHdoSEU5eXlpZE9VN1loa3FrV1N0d3FHa3VrdExzV0JPek9YMmg5SzRp?=
 =?utf-8?B?MVRmNmJUQVB3aWZTa0RpNXBLWWxldEpORU9BME5zL3BYSXR2bERjMVAvNmNx?=
 =?utf-8?B?dUlCendOL3NESFcxZUFJV1Nrb2dpOUxpT010d3FuaTZWVkwwZU9NaDQxL1pL?=
 =?utf-8?B?Z0lUUUozVmZEQk4zY2NicGt1REF4ZmdLVGE2emRlSWN1QWVlMXc1MVZHZkhP?=
 =?utf-8?B?UEZzQVpnK3lyeXkyZGhmSzVObXA1MzQ4S0xqY01hbHB4b2tIY3pDK1FIOGM3?=
 =?utf-8?B?OGZXK0lMVnZzTVJwcXlvQys1NWVNcklJaXpvdFFvbDBFZEpVbWlrc2ZqS1lj?=
 =?utf-8?B?ak9teEx5VUJpWWhwMFZRdTVVcy9sRlBrMU1JbmwvekcwaFNFOEdZaCs4SEZ5?=
 =?utf-8?B?ZDhMWWxuRFBIU01oL3Zmd0RsVlU1QUdLZGMzbFpFaUlqRU1QMGRuaDNMenRz?=
 =?utf-8?B?TVJMSHl1NktaeXBDV1FCaEJ4cFloMkczKy8xSDhMMnZOTm1Qd1kxQ1cvUEZl?=
 =?utf-8?B?bnFPYjFJYklIZldjMXJQVDhPcFZaN0hyRVYzZk5mbHFyOTNpWTFReFIzRWNG?=
 =?utf-8?B?NHNuRW1scVplSlFIZ2N4ckhHWFdtMmRJSThVVW94UUd5dDg4WXZmd0c0NnlO?=
 =?utf-8?B?WEJxY2JKNjgxZVAwOUl2RTlxYjNoMDcxcHUzVVlBUnRpOXU1aVR4cHoxQWU0?=
 =?utf-8?B?cTRpQ1YxRXFqOHYza3lIaEJVRzkwK0lSWFRwRU5HaGRZYzFlS2JKWndZaDdR?=
 =?utf-8?B?UTJEV2RzbnVyRW5iaXlyMFhlR1VKcmdUK1dDd1hsQk5NU3k0MDVzeDBQWjZm?=
 =?utf-8?B?bUpqVzIyMkpoN2VNdlVyVDZnT2RDYTBCcjdZSzFxeVk0a1VPNk80QXFaM1FU?=
 =?utf-8?B?VjhCaDkvTUJhVDNLSmREMlYxZWFIcHZGc3ZoSGJBWG4rblpNSGNnc011RUpn?=
 =?utf-8?B?YUtYRlBEaEhSaGV2M3VVNUQ2ZGRGdlVGMVc5YVQxalc5Q1lNenlpZ0VSeDhx?=
 =?utf-8?B?a2VpY0szK0lTYXdhNGJqWVdZRFJSUTlJTk1QZThQa3FJek1jdEtUeFpSNDVH?=
 =?utf-8?B?RlR2WWJ0R0dYa0laWkpXOVV0ZFFrVENqSTAwU01PREdjUVR4UzdTd0ZFSEt6?=
 =?utf-8?B?SlluVDQ4blpRR2NCRWFoM2lHb2J1eHJwbVRoeWVCdjMvRUtxTmtacTA2Skwv?=
 =?utf-8?B?Mi83SmY3dU16eXZMVDdlV0lQL1J2Z1pMdllUdnNJam5YYTkzMWYzYWZLZllo?=
 =?utf-8?B?Tk14YWR4SnBuUGQrY3ZWK1NKTHVyRVZQVlR3V0ljN3NBLzhSSXlzY1ZMVWtX?=
 =?utf-8?B?MFVveUUvb3hUK0NlaDNMY1ZITHRKVHUvMUZGbDYydkQ0bEVuNGhPV0poM0FZ?=
 =?utf-8?B?VlBQLzNTS2xWcGVsRjhSYnlISjFMOWZidU9sSjRrMkhwbGJCOGk2Smp2Yk5V?=
 =?utf-8?B?MjN6MEZlazU4WmRUb011TEhFaWZ5cUdmYmVwaU15N0RtMlZENko1L0JZZUYr?=
 =?utf-8?B?OFBSbWJMMUpWcEFqYXZVeFlXYjZjbUJiRVljSzQ4eFJqa1ZJcmFJR1dFbmI3?=
 =?utf-8?Q?4eILZosew81wCBYHkYzadULsXM3wu8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 16:35:10.6561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4f1e07-3b9e-426d-eb12-08dd63df5ac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247

Hello John,

On 3/13/2025 3:41 AM, John Stultz wrote:
> Add a find_proxy_task() function which doesn't do much.
> 
> When we select a blocked task to run, we will just deactivate it
> and pick again. The exception being if it has become unblocked
> after find_proxy_task() was called.
> 
> Greatly simplified from patch by:
>    Peter Zijlstra (Intel) <peterz@infradead.org>
>    Juri Lelli <juri.lelli@redhat.com>
>    Valentin Schneider <valentin.schneider@arm.com>
>    Connor O'Brien <connoro@google.com>
> 
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
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
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: kernel-team@android.com
> [jstultz: Split out from larger proxy patch and simplified
>   for review and testing.]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v5:
> * Split out from larger proxy patch
> v7:
> * Fixed unused function arguments, spelling nits, and tweaks for
>    clarity, pointed out by Metin Kaya
> * Fix build warning Reported-by: kernel test robot <lkp@intel.com>
>    Closes: https://lore.kernel.org/oe-kbuild-all/202311081028.yDLmCWgr-lkp@intel.com/
> v8:
> * Fixed case where we might return a blocked task from find_proxy_task()
> * Continued tweaks to handle avoiding returning blocked tasks
> v9:
> * Add zap_balance_callbacks helper to unwind balance_callbacks
>    when we will re-call pick_next_task() again.
> * Add extra comment suggested by Metin
> * Typo fixes from Metin
> * Moved adding proxy_resched_idle earlier in the series, as suggested
>    by Metin
> * Fix to call proxy_resched_idle() *prior* to deactivating next, to avoid
>    crashes caused by stale references to next
> * s/PROXY/SCHED_PROXY_EXEC/ as suggested by Metin
> * Number of tweaks and cleanups suggested by Metin
> * Simplify proxy_deactivate as suggested by Metin
> v11:
> * Tweaks for earlier simplification in try_to_deactivate_task
> v13:
> * Rename rename "next" to "donor" in find_proxy_task() for clarity
> * Similarly use "donor" instead of next in proxy_deactivate
> * Refactor/simplify proxy_resched_idle
> * Moved up a needed fix from later in the series
> v15:
> * Tweaked some comments to better explain the initial sketch of
>    find_proxy_task(), suggested by Qais
> * Build fixes for !CONFIG_SMP
> * Slight rework for blocked_on_state being added later in the
>    series.
> * Move the zap_balance_callbacks to later in the patch series
> ---
>   kernel/sched/core.c  | 103 +++++++++++++++++++++++++++++++++++++++++--
>   kernel/sched/rt.c    |  15 ++++++-
>   kernel/sched/sched.h |  10 ++++-
>   3 files changed, 122 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3968c3967ec38..b4f7b14f62a24 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6600,7 +6600,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>    * Otherwise marks the task's __state as RUNNING
>    */
>   static bool try_to_block_task(struct rq *rq, struct task_struct *p,
> -			      unsigned long task_state)
> +			      unsigned long task_state, bool deactivate_cond)
>   {
>   	int flags = DEQUEUE_NOCLOCK;
>   
> @@ -6609,6 +6609,9 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
>   		return false;
>   	}
>   
> +	if (!deactivate_cond)
> +		return false;
> +
>   	p->sched_contributes_to_load =
>   		(task_state & TASK_UNINTERRUPTIBLE) &&
>   		!(task_state & TASK_NOLOAD) &&
> @@ -6632,6 +6635,93 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
>   	return true;
>   }
>   
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +
> +static inline struct task_struct *
> +proxy_resched_idle(struct rq *rq)

nit. Any reason why this was put in the next line?

> +{
> +	put_prev_task(rq, rq->donor);

Any reason we cannot do a:

     put_prev_set_next_task(rq, rq->donor, rq->idle)

here? I don't see any dependency on rq->donor in set_next_task_idle()
and it should be safe.

> +	rq_set_donor(rq, rq->idle);
> +	set_next_task(rq, rq->idle);
> +	set_tsk_need_resched(rq->idle);
> +	return rq->idle;
> +}
> +
> +static bool proxy_deactivate(struct rq *rq, struct task_struct *donor)
> +{
> +	unsigned long state = READ_ONCE(donor->__state);
> +
> +	/* Don't deactivate if the state has been changed to TASK_RUNNING */
> +	if (state == TASK_RUNNING)
> +		return false;
> +	/*
> +	 * Because we got donor from pick_next_task, it is *crucial*
> +	 * that we call proxy_resched_idle before we deactivate it.
> +	 * As once we deactivate donor, donor->on_rq is set to zero,
> +	 * which allows ttwu to immediately try to wake the task on
> +	 * another rq. So we cannot use *any* references to donor
> +	 * after that point. So things like cfs_rq->curr or rq->donor
> +	 * need to be changed from next *before* we deactivate.
> +	 */
> +	proxy_resched_idle(rq);
> +	return try_to_block_task(rq, donor, state, true);
> +}
> +
> +/*
> + * Initial simple sketch that just deactivates the blocked task
> + * chosen by pick_next_task() so we can then pick something that
> + * isn't blocked.
> + */
> +static struct task_struct *
> +find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
> +{
> +	struct task_struct *p = donor;
> +	struct mutex *mutex;
> +
> +	mutex = p->blocked_on;
> +	/* Something changed in the chain, so pick again */
> +	if (!mutex)
> +		return NULL;
> +	/*
> +	 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
> +	 * and ensure @owner sticks around.
> +	 */
> +	raw_spin_lock(&mutex->wait_lock);
> +
> +	/* Check again that p is blocked with blocked_lock held */
> +	if (!task_is_blocked(p) || mutex != __get_task_blocked_on(p)) {
> +		/*
> +		 * Something changed in the blocked_on chain and
> +		 * we don't know if only at this level. So, let's
> +		 * just bail out completely and let __schedule
> +		 * figure things out (pick_again loop).
> +		 */
> +		goto out;
> +	}
> +
> +	if (!proxy_deactivate(rq, donor)) {
> +		/*
> +		 * XXX: For now, if deactivation failed, set donor
> +		 * as not blocked, as we aren't doing proxy-migrations
> +		 * yet (more logic will be needed then).
> +		 */
> +		__clear_task_blocked_on(donor, mutex);
> +		raw_spin_unlock(&mutex->wait_lock);
> +		return NULL;
> +	}
> +out:
> +	raw_spin_unlock(&mutex->wait_lock);
> +	return NULL; /* do pick_next_task again */
> +}
> +#else /* SCHED_PROXY_EXEC */
> +static struct task_struct *
> +find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
> +{
> +	WARN_ONCE(1, "This should never be called in the !SCHED_PROXY_EXEC case\n");
> +	return donor;
> +}
> +#endif /* SCHED_PROXY_EXEC */
> +
>   /*
>    * __schedule() is the main scheduler function.
>    *
> @@ -6739,12 +6829,19 @@ static void __sched notrace __schedule(int sched_mode)
>   			goto picked;
>   		}
>   	} else if (!preempt && prev_state) {
> -		try_to_block_task(rq, prev, prev_state);
> +		try_to_block_task(rq, prev, prev_state,
> +				  !task_is_blocked(prev));
>   		switch_count = &prev->nvcsw;
>   	}
>   
> -	next = pick_next_task(rq, prev, &rf);
> +pick_again:
> +	next = pick_next_task(rq, rq->donor, &rf);
>   	rq_set_donor(rq, next);
> +	if (unlikely(task_is_blocked(next))) {
> +		next = find_proxy_task(rq, next, &rf);
> +		if (!next)
> +			goto pick_again;
> +	}
>   picked:
>   	clear_tsk_need_resched(prev);
>   	clear_preempt_need_resched();
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4b8e33c615b12..2d418e0efecc5 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1479,8 +1479,19 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>   
>   	enqueue_rt_entity(rt_se, flags);
>   
> -	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
> -		enqueue_pushable_task(rq, p);
> +	/*
> +	 * Current can't be pushed away. Selected is tied to current,
> +	 * so don't push it either.
> +	 */
> +	if (task_current(rq, p) || task_current_donor(rq, p))
> +		return;
> +	/*
> +	 * Pinned tasks can't be pushed.
> +	 */
> +	if (p->nr_cpus_allowed == 1)
> +		return;
> +
> +	enqueue_pushable_task(rq, p);
>   }
>   
>   static bool dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 05d2122533619..3e49d77ce2cdd 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2311,6 +2311,14 @@ static inline int task_current_donor(struct rq *rq, struct task_struct *p)
>   	return rq->donor == p;
>   }
>   
> +static inline bool task_is_blocked(struct task_struct *p)
> +{
> +	if (!sched_proxy_exec())
> +		return false;
> +
> +	return !!p->blocked_on;
> +}
> +
>   static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
>   {
>   #ifdef CONFIG_SMP
> @@ -2520,7 +2528,7 @@ static inline void put_prev_set_next_task(struct rq *rq,
>   					  struct task_struct *prev,
>   					  struct task_struct *next)
>   {
> -	WARN_ON_ONCE(rq->curr != prev);
> +	WARN_ON_ONCE(rq->donor != prev);
>   
>   	__put_prev_set_next_dl_server(rq, prev, next);
>   

-- 
Thanks and Regards,
Prateek


