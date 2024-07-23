Return-Path: <linux-kernel+bounces-259588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA8A9398F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595A8B21AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 04:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076EE13BC0E;
	Tue, 23 Jul 2024 04:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3/QcONps"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BAE28E8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721710245; cv=fail; b=rApqZdwoM5iTzv/5mhUW57rN+xocXfKXa+OWsabl0VCptUTbPws4yQKEy4ejkzIgaTOq6J2/D1Qv5pfANZXfuKR7r7L4qQiVX8Wnp7Phk4joSfHc9c1ORSt4s9sj/PyB9CV2vq63ULAy2APHFlEOWfzl/U7r0y+ESXmbPxcFo84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721710245; c=relaxed/simple;
	bh=TNOwjCZ6RbxpduJ9tmy/T81uftazxWJGXJEGdMnswnw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=bzXjlbEA8JqiKiAy3AS7dZWb1w/q+PgtWWMLWgtmmXRdCVM/XL2hAXQDOvC/tUy98GxIdHZM8yrvVAL6MeeTPbXrlbMRiLEFOjpnwx7v++CS24ZZd0spMZSXd3bk80pljabvOIqkfOkqQYlSRGXrnfEb8DpK0qlZ4MK1V20C94g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3/QcONps; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bu2van12FsfW8V0Eoi/QUmId+9ToljxoTDDC0Rfvf0YPS6SmDl0H6blbeoMcFoGzACLMo45Dyt7XlWVFuEWXFJqh6nNtU83hsjdVqXscVytm0YO7lJVVTWzHgp6dAmEtWvIL4Y7bAu6SoJtMnq+y+xhnmlO67XAYfpRwUwM4lC1pB/YjafPMgAymA79P2Q9uCPHul9ZauQYdanhCoQBwqp4cQgQU879XchCrtAKLxdG7tTGtUgoZLLxl0+Kz2S8EzpPw9I8heDZJOlQclvk6QcXQWBB/PkcBo23tvTXV0T4ZV4mA4kyfGnzMDt8GflVtuiDtA52DJYpXngapNtqVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0K0Lnc6RSRbpF8g7M9T011t2R7VqVbwBlfqCs0ZKmO4=;
 b=S2pcLNPwdoHOEuJb/QriV1ttKWBX4WYvzOU2KW6Pcnm7baT8EcU4bjm/jQBGThcZ8SEaoehuhRNqjfM/3aBMBPDwNx3Cf1qAi5Iiw8NLq+l5vUT91LuYNi20RNdmBLiQCs+53H9+Hnse2vgCZG/bioVbvRJ0WLZV+3zECcZpLxRXUlrLRDz0qJHVhWQ8Wghslirb4QqPd5bJO0Pf36QRGJAzUukhv+9ALZXSAkzs2VBUaN5VcIgNJknaCTAixGUM4zClVwumDK6lla+P8nwmL6Nf76u8x9euD2eCmlvcOQViuR++bcHScrD3KEVPatqxtu0oTFfy9ia0dQdbwDcG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K0Lnc6RSRbpF8g7M9T011t2R7VqVbwBlfqCs0ZKmO4=;
 b=3/QcONpsVMO+AcydaGr1fA6VpghBsBI0EKm7pS7nf4DwWxuBeL2jdKPJxccgqAKzf+S+X5l+mAvI391B0ijxLjUEnQPqlu2FSSTp6xWzkH1nm3p39mRX+ZwgUYd2sUx/DxdSXjjF9jaiY2ZWCeAGrfG/dm/Z7WBZ48o6+utLTGc=
Received: from BN9PR03CA0506.namprd03.prod.outlook.com (2603:10b6:408:130::31)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Tue, 23 Jul
 2024 04:50:40 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::95) by BN9PR03CA0506.outlook.office365.com
 (2603:10b6:408:130::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Tue, 23 Jul 2024 04:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 04:50:40 +0000
Received: from [10.136.40.40] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 23:50:34 -0500
Message-ID: <880f13fd-753d-2c5a-488a-d75c99e8dfa3@amd.com>
Date: Tue, 23 Jul 2024 10:20:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 3/3] softirq: Avoid waking up ksoftirqd from
 flush_smp_call_function_queue()
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Imran Khan <imran.f.khan@oracle.com>, Leonardo Bras <leobras@redhat.com>,
	"Guo Ren" <guoren@kernel.org>, Rik van Riel <riel@surriel.com>, Tejun Heo
	<tj@kernel.org>, Cruz Zhao <CruzZhao@linux.alibaba.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Zqiang
	<qiang.zhang1211@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, "Gautham
 R. Shenoy" <gautham.shenoy@amd.com>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
 <20240710090210.41856-4-kprateek.nayak@amd.com>
 <20240710150557.GB27299@noisy.programming.kicks-ass.net>
 <7acc5dd0-8cc0-be08-b08a-6f36c1964961@amd.com>
In-Reply-To: <7acc5dd0-8cc0-be08-b08a-6f36c1964961@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 106d6beb-26ee-4181-59df-08dcaad30083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU5IRHZraDR2NHZyak1IaTl3Q3IrWDM1WkpDU1R2TCtjM2VTR3VnbU9xeEt3?=
 =?utf-8?B?TGVTVzdhUG9ZOHFNcnJjaU13YUM5bFMvbzNLWWtPUVZSa3lIZUFVVWt0VXZn?=
 =?utf-8?B?T3lGZ2MxdXlzTktGZHc2dzliQTBEaDJocEUwNUd2K0hyRGJmZ1FnbVkzQ2lS?=
 =?utf-8?B?cC9mQ0FoNkhCcHg2THFTdTdtVkZ6TmtuR1d4Qy9qZGQwVk81aUZsSWxjc2ND?=
 =?utf-8?B?SHg5SzdvdERFL1BnV2twdkNMazd4SjRjSVVaN0hXczFTUUdENWIwd3VsdmJN?=
 =?utf-8?B?YW40RkVMendxYnpQYUZOeDU0U2xYdHAxZ0RTN0ROMlZ0TzBpeXVmcmszdVFO?=
 =?utf-8?B?cmtLVFRaeDJXQUg4ampkZWZVR0E4OHZvR3A1QmptUmIvaFMyNHd6TmhHcDdt?=
 =?utf-8?B?NWpxZ3JrQjllZEhnajRlU0pENy9HcVBWUDRIUEovQlZIOXdHd05vTjJJSC91?=
 =?utf-8?B?NEptSnpEbVhqcldOTXlwMVBVYTRCTXliV1dmbkpGOWZ5ckt1aU1uRHUrRjZ5?=
 =?utf-8?B?dWNuM3UxSEp1YWhMREQ5RlNudzlvN0RoZ1lxTWVLTHRzbnRKdkZOSzRYbVMy?=
 =?utf-8?B?cnBsTE9reUwxQm4vcTN4b3kvcnQ5bWg5SngwQW94SVhhOElMNm5jSUwxY2pI?=
 =?utf-8?B?bmdZNVROajgrYUlwaFpiVnF3aHBrTHdmaHpqdC84bG00UW5CTDIzOW5pMG1v?=
 =?utf-8?B?Y2ZDcko3ajdvbHZXNkNkUEFjOU0yRzZiMUZ2MzZsQVpvajI0T1RUbG1vQklt?=
 =?utf-8?B?WkxmaGdyWGtsZ3BjL1Z5TVozblBJY0tYWmpyd3plL1pxSFhtVy9LS0c1N3NX?=
 =?utf-8?B?azVjV1dsV3cxby9BblVqSTBZZHg0NWRoQjV6dTRrMCtGYmFBWUVqdEhMemRJ?=
 =?utf-8?B?bFRsbmo4Yk9WV0E5dWloOGdGMmo1TzhtaC9nbk85WHJWUFZRbytpMnJseWg0?=
 =?utf-8?B?MEkvbkpiV1VvM2tXSVlUZTF0MElrQnY3VVBOR041alRsY3BnYlpJUFJhODVM?=
 =?utf-8?B?dTNxWHFBVWE0dnBWSWtzc2lJcHRwQXppZzJ5bXI3Qk54R3A2QzgzZ1NJRzU1?=
 =?utf-8?B?OHBhZlZpeG9GQ2lzdTRkK1ViWlhBSi9Zb1pxdHNsSjduTWUybjdNVjd2NmNE?=
 =?utf-8?B?eHRxbE5VOXZnWGpyc01pY0VERWw3R1Qrd1dvZk9Hd0Vlb0RnRGpyOWtySjJ1?=
 =?utf-8?B?SHBvSFZRbjZzaERCV2RwbWNiQ1c4MHJDT2ZzcVN2THQ3ZldodUU0eFlIQmRG?=
 =?utf-8?B?WjJ2b2ltcE5BdGMxNDFnL1pVYWJNbjk5ZXdQL1NmSHJ2Tkk0NXR6SGV3V3dk?=
 =?utf-8?B?NzQvL1g3Z2NlUVBRZXBtYlRzUGpYK2xoT0xQV0hCOU9wT2VSRnVjS0Q2Tis4?=
 =?utf-8?B?SEJsd3BJRHdCWU1IYmNMbjloamViM05Lb0tWYzBlR3NmRWhDbDJXK2ZLelRr?=
 =?utf-8?B?UHdMLzdMdDlaL3dwWFBESTQ0MGF6M3lZbm8vVFI5VFZIRmNWTnNnOVk0QU02?=
 =?utf-8?B?K3BnTkhWNllBMFdYaUNwcmtadG1rUW9pMkpocUpwNjZTN0wvcHBRRTdVek9B?=
 =?utf-8?B?dzhGRU5WU3c3SUJmd3lGT2xrd2h6UGxPLzUyRWVxZG00RWN6Z1FTaWk4bGw5?=
 =?utf-8?B?Yk15WTFLQVh5aFZMcy9iRU40WVk4YTVoTVJONjdOMlBnN1c3U2U5RE5xZHlN?=
 =?utf-8?B?YlcwbHNqbEoxQWNqN2pJV0kvSXhnMmY1VFFpWmE2ODFSN2JoUmhXOFliODh1?=
 =?utf-8?B?MllWTGZHaWM4dFVENnRKZnp1YmZYMkRveklCY2Z3WEdTeVBPa3FqRVcrY1g1?=
 =?utf-8?B?Qno5WTFMZlRBemlaZExWc2R3N3AvTThjZm1ES3ZpSG9xZEVXbXI1YmxuYitw?=
 =?utf-8?B?MmpCZDNuNGtJLytmbDlHOUVVMzdMUHVMU3VjWmRab2hDazJjQXZPeFRzcjJF?=
 =?utf-8?Q?HZGzBsHLcT0np0dOh6Vg3eKPIXMoxelz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 04:50:40.2103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 106d6beb-26ee-4181-59df-08dcaad30083
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229

Hello Peter,

On 7/10/2024 11:50 PM, K Prateek Nayak wrote:
> Hello Peter,
> 
> Thank you for the feedback.
> 
> On 7/10/2024 8:35 PM, Peter Zijlstra wrote:
>> On Wed, Jul 10, 2024 at 09:02:10AM +0000, K Prateek Nayak wrote:
>>
>>> [..snip..]
>>
>> On first reading I wonder why you've not re-used and hooked into the
>> PREEMPT_RT variant of should_wake_ksoftirqd(). That already has a per
>> CPU variable to do exactly this.
> 
> With this RFC, I intended to check if everyone was onboard with the idea
> and of the use-case. One caveat with re-using the existing
> "softirq_ctrl.cnt" hook that PREEMPT_RT uses is that we'll need to
> expose the functions that increment and decrement it, for it to be used
> in kernel/smp.c. I'll make those changes in v2 and we can see if there
> are sufficient WARN_ON() to catch any incorrect usage in !PREEMPT_RT
> case.
> 

Reusing the PREEMPT_RT bits, I was able to come up with the approach
below. Following are some nuances with this approach:

- Although I don't believe "set_do_softirq_pending()" can be nested,
   since it is used only from flush_smp_call_function_queue() which is
   called with IRQs disabled, I'm still using inc and dec since I'm not
   sure if it can be nested in a local_bh_{disable,enable}() or if
   those can be called from SMP-call-function.

- I used the same modified version of ipistorm to test the changes on
   top of v6.10-rc6-rt11 with LOCKDEP enabled and did not see any splats
   during the run of the benchmark. If there are better tests that
   stress this part on RT kernels, I'm all ears.

- I've abandoned any micro-optimization since I see different numbers
   on different machines and am sticking to the simplest approach since
   it works and is an improvement over the baseline.

I'll leave the diff below:

diff --git a/kernel/sched/smp.h b/kernel/sched/smp.h
index 21ac44428bb0..83f70626ff1e 100644
--- a/kernel/sched/smp.h
+++ b/kernel/sched/smp.h
@@ -9,7 +9,16 @@ extern void sched_ttwu_pending(void *arg);
  extern bool call_function_single_prep_ipi(int cpu);
  
  #ifdef CONFIG_SMP
+/*
+ * Used to indicate a pending call to do_softirq() from
+ * flush_smp_call_function_queue()
+ */
+extern void set_do_softirq_pending(void);
+extern void clr_do_softirq_pending(void);
+
  extern void flush_smp_call_function_queue(void);
  #else
+static inline void set_do_softirq_pending(void) { }
+static inline void clr_do_softirq_pending(void) { }
  static inline void flush_smp_call_function_queue(void) { }
  #endif
diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..c191bad912f6 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -583,7 +583,9 @@ void flush_smp_call_function_queue(void)
  	local_irq_save(flags);
  	/* Get the already pending soft interrupts for RT enabled kernels */
  	was_pending = local_softirq_pending();
+	set_do_softirq_pending();
  	__flush_smp_call_function_queue(true);
+	clr_do_softirq_pending();
  	if (local_softirq_pending())
  		do_softirq_post_smp_call_flush(was_pending);
  
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 00e32e279fa9..8308687fc7b9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -88,22 +88,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
  EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
  #endif
  
-/*
- * SOFTIRQ_OFFSET usage:
- *
- * On !RT kernels 'count' is the preempt counter, on RT kernels this applies
- * to a per CPU counter and to task::softirqs_disabled_cnt.
- *
- * - count is changed by SOFTIRQ_OFFSET on entering or leaving softirq
- *   processing.
- *
- * - count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
- *   on local_bh_disable or local_bh_enable.
- *
- * This lets us distinguish between whether we are currently processing
- * softirq and whether we just have bh disabled.
- */
-#ifdef CONFIG_PREEMPT_RT
+#define DO_SOFTIRQ_PENDING_MASK	GENMASK(SOFTIRQ_SHIFT - 1, 0)
  
  /*
   * RT accounts for BH disabled sections in task::softirqs_disabled_cnt and
@@ -116,16 +101,56 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
   *
   * The per CPU counter prevents pointless wakeups of ksoftirqd in case that
   * the task which is in a softirq disabled section is preempted or blocks.
+ *
+ * The bottom bits of softirq_ctrl::cnt is used to indicate an impending call
+ * to do_softirq() to prevent pointless wakeups of ksoftirqd since the CPU
+ * promises to handle softirqs soon.
   */
  struct softirq_ctrl {
+#ifdef CONFIG_PREEMPT_RT
  	local_lock_t	lock;
+#endif
  	int		cnt;
  };
  
  static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
+#ifdef CONFIG_PREEMPT_RT
  	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
+#endif
  };
  
+inline void set_do_softirq_pending(void)
+{
+	__this_cpu_inc(softirq_ctrl.cnt);
+}
+
+inline void clr_do_softirq_pending(void)
+{
+	__this_cpu_dec(softirq_ctrl.cnt);
+}
+
+static inline bool should_wake_ksoftirqd(void)
+{
+	return !this_cpu_read(softirq_ctrl.cnt);
+}
+
+/*
+ * SOFTIRQ_OFFSET usage:
+ *
+ * On !RT kernels 'count' is the preempt counter, on RT kernels this applies
+ * to a per CPU counter and to task::softirqs_disabled_cnt.
+ *
+ * - count is changed by SOFTIRQ_OFFSET on entering or leaving softirq
+ *   processing.
+ *
+ * - count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
+ *   on local_bh_disable or local_bh_enable.
+ *
+ * This lets us distinguish between whether we are currently processing
+ * softirq and whether we just have bh disabled.
+ */
+#ifdef CONFIG_PREEMPT_RT
+
  /**
   * local_bh_blocked() - Check for idle whether BH processing is blocked
   *
@@ -138,7 +163,7 @@ static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
   */
  bool local_bh_blocked(void)
  {
-	return __this_cpu_read(softirq_ctrl.cnt) != 0;
+	return (__this_cpu_read(softirq_ctrl.cnt) & SOFTIRQ_MASK) != 0;
  }
  
  void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
@@ -155,7 +180,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
  			/* Required to meet the RCU bottomhalf requirements. */
  			rcu_read_lock();
  		} else {
-			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
+			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt) &
+					    SOFTIRQ_MASK);
  		}
  	}
  
@@ -163,7 +189,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
  	 * Track the per CPU softirq disabled state. On RT this is per CPU
  	 * state to allow preemption of bottom half disabled sections.
  	 */
-	newcnt = __this_cpu_add_return(softirq_ctrl.cnt, cnt);
+	newcnt = __this_cpu_add_return(softirq_ctrl.cnt, cnt) & SOFTIRQ_MASK;
  	/*
  	 * Reflect the result in the task state to prevent recursion on the
  	 * local lock and to make softirq_count() & al work.
@@ -184,7 +210,7 @@ static void __local_bh_enable(unsigned int cnt, bool unlock)
  	int newcnt;
  
  	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
-			    this_cpu_read(softirq_ctrl.cnt));
+			    (this_cpu_read(softirq_ctrl.cnt) & SOFTIRQ_MASK));
  
  	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() == cnt) {
  		raw_local_irq_save(flags);
@@ -192,7 +218,7 @@ static void __local_bh_enable(unsigned int cnt, bool unlock)
  		raw_local_irq_restore(flags);
  	}
  
-	newcnt = __this_cpu_sub_return(softirq_ctrl.cnt, cnt);
+	newcnt = __this_cpu_sub_return(softirq_ctrl.cnt, cnt) & SOFTIRQ_MASK;
  	current->softirq_disable_cnt = newcnt;
  
  	if (!newcnt && unlock) {
@@ -212,7 +238,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
  	lockdep_assert_irqs_enabled();
  
  	local_irq_save(flags);
-	curcnt = __this_cpu_read(softirq_ctrl.cnt);
+	curcnt = __this_cpu_read(softirq_ctrl.cnt) & SOFTIRQ_MASK;
  
  	/*
  	 * If this is not reenabling soft interrupts, no point in trying to
@@ -253,7 +279,7 @@ void softirq_preempt(void)
  	if (WARN_ON_ONCE(!preemptible()))
  		return;
  
-	if (WARN_ON_ONCE(__this_cpu_read(softirq_ctrl.cnt) != SOFTIRQ_OFFSET))
+	if (WARN_ON_ONCE((__this_cpu_read(softirq_ctrl.cnt) & SOFTIRQ_MASK) != SOFTIRQ_OFFSET))
  		return;
  
  	__local_bh_enable(SOFTIRQ_OFFSET, true);
@@ -282,11 +308,6 @@ static inline void ksoftirqd_run_end(void)
  static inline void softirq_handle_begin(void) { }
  static inline void softirq_handle_end(void) { }
  
-static inline bool should_wake_ksoftirqd(void)
-{
-	return !this_cpu_read(softirq_ctrl.cnt);
-}
-
  static inline void invoke_softirq(void)
  {
  	if (should_wake_ksoftirqd())
@@ -424,11 +445,6 @@ static inline void ksoftirqd_run_end(void)
  	local_irq_enable();
  }
  
-static inline bool should_wake_ksoftirqd(void)
-{
-	return true;
-}
-
  static inline void invoke_softirq(void)
  {
  	if (!force_irqthreads() || !__this_cpu_read(ksoftirqd)) {
--

Some of the (softirq_ctrl.cnt & SOFTIRQ_MASK) masking might be
unnecessary but I'm not familiar enough with all these bits to make a
sound call. Any and all comments are appreciated :)

--
Thanks and Regards,
Prateek

