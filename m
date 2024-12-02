Return-Path: <linux-kernel+bounces-427193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DAD9DFDE8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00DA163550
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444461FBCB8;
	Mon,  2 Dec 2024 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NylcierA"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919B1FBCBB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133506; cv=fail; b=lWZxu5a+/2Qww5Zz7GeezqR3szjoykW9UeX6z0U+O8xQ867Vr6BEgl72ULdkbmku96AtuZK8F4VZVmzbpwnngfGO6/OFbQShlfzPDOTeqO934FrPSfYiu00h4sC7qlnajVp6EIC6g+omFC8Zah8hI+V1/ZzBU4Om2Pw3Aez11/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133506; c=relaxed/simple;
	bh=k/1ykPFarfhFSdO0EvAp7SaHM3PocwqLdpPitlmEn4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SkShABvanXudQlGeFxktryz+wFjc/xRJY1MG+xPOEF4BEh6Q14o8iKUtPa+GDz6+ez8Tat+STVmlg6ds/YqK4WMwFMTw4BdsHd9a+lyG5l/rfy06qeS0ILDHPu0rJI2m4Xtbwd71w2sY15cK2/sDypPpCYobprYvqi1omrH34D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NylcierA; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvsTa5EgYM1fmC/BbyvM02QQixPgmJUeydz8H3VAnCRJPVzlVsH0aEzSSq/5pNMsM5F2mIbMWiYPHfdEhM6hpZ5TKNBOtWdgH66iI/97DdjtkYDd8D0aPHTStYLIbiJNXRxS+s4oYxyA05TTbnsmt8LJKa7oTZH8WTSh+awYmyP7HLipbjJFaKeGws/Wsc+XlX2gWaNcx++NSRNgu5amiwG9e3rkPbJcd3Oc0Wj04BacZt7A/cSeDB84I/A9ogO+DNmoUayW1b7yufLK4CBtLJ2ejc//u1MyGdyRGHQJPSt7VRo4hVzbnxwtr81kH406T2Kw4gAG6MSNJwoBLu2o2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+vjBhdaSc5WBt2uElwO+6e0YA7DZR9QhqhK6p5vdVM=;
 b=sFKsJrz2YpTKYD7Ii+EUTz3WtsCN5y72dEsjJtwVIZD7VEePuovNrg2ny5qpdiwfG/1dLXPytsBrIhXyo4VZdzSwucyWC53j+VBgfv+Dq538vquE21/bRFsMquKVJjfrWM4SJ7I9aGQKtBE/WmypyrfKqhl3TE3gumpr0tjs5m0kJNRrmN/0iJNVTGRidjBxaVQ4we1clQIKpebdo2edpC+zo9J9O351JVmY8iuJ8e+6aPgVqoOh4xo+pdp0pKdvhzRpZPGtEgfwgQwOTcj0HzJV0cwp6J0KHVdGgh1So7JfocN0aVCRbUzJ4XZ9j4SyHTVJt1d6VrSMdHUfuVV/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+vjBhdaSc5WBt2uElwO+6e0YA7DZR9QhqhK6p5vdVM=;
 b=NylcierA1niNziX5C2uCNq0XpggE/0tCEwXqW9xbnU4fsdJT6OEBmoRN0JySR97TZ+XmRZilnxKSo1mZonb6B7hON3bOaaj6bm4h99pp3Tj2gjko5nIg6DdBFJPUwWPUVXIaIZ65lu7AN8sX5ugFQtRO/7iyQRKhHSu/2ndfz8w=
Received: from BN9PR03CA0489.namprd03.prod.outlook.com (2603:10b6:408:130::14)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 09:58:19 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::64) by BN9PR03CA0489.outlook.office365.com
 (2603:10b6:408:130::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 09:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 09:58:18 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 03:58:15 -0600
Message-ID: <ab68a4ae-f640-4057-8607-6cca9b5ce90e@amd.com>
Date: Mon, 2 Dec 2024 15:28:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/10 v2] sched/fair: Fix statistics with delayed dequeue
To: Vincent Guittot <vincent.guittot@linaro.org>, Mike Galbraith
	<efault@gmx.de>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<pauld@redhat.com>, <luis.machado@arm.com>
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
 <227863d758551e75cd0807a5f1f31916d695205b.camel@gmx.de>
 <CAKfTPtDwS4+t0Fnacre6dtxKdxtrgua_2v=s7pZHqDsYoMMxFA@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtDwS4+t0Fnacre6dtxKdxtrgua_2v=s7pZHqDsYoMMxFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: f656db57-3bb8-4b8a-379c-08dd12b7d93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUx4RnJCdHdrc0l6UUc0emMvblJkWk15aklTdXBlNWE0N2hjYmd1NFNzcTZN?=
 =?utf-8?B?QXMyOUlYd3BJNmdKTDEvWExLRkN3OVhGMjg0QkpLeDdoSGZCL0NtUmt0a2Y1?=
 =?utf-8?B?K1NwSFVRQTNBMnRrZVdKSGpnQTNuY1Zja3YyMVN3bCt5Ykh1ell4d2tPTmF6?=
 =?utf-8?B?bFJraU5ORzRmQWl6TUtaQlZYUmQ0Q0hGcWtGUEI0d05PeGRUR1pSWjlieW8v?=
 =?utf-8?B?SEhTTHlaTU5kaUZIWUZ3Mnh2Y2JrNnZxZWJVbnBrRjFCNVFXY2c3N3JobFVp?=
 =?utf-8?B?QzZYZHlFTmtSY24rOU5XKzA2WXcvUHFhYVluV1JlOXlBYkY1TU5ZcmxIanFD?=
 =?utf-8?B?RDhyc0grWlM5aDdvamc4ZXNXcnUyWXk5ZVg2VjJtVGp4M3l4VGZLVEx4M0FH?=
 =?utf-8?B?TUlNVm5TMlVzSEQ3TU9ZblI2cTJBSlByQXJwUkNTdUI4YUZtNEFHM2hxU3pH?=
 =?utf-8?B?Qmo1NHZyMlZsSGpybWxYK1JjblR3MUNLaTRackJkZ2xFaW9ZSkFyUy9jLzVs?=
 =?utf-8?B?TDdIN2tCMW1rWmZicC9YbWMzU2dodG1sMHFSN25ONGFMcHp3amIxbFBRcGpU?=
 =?utf-8?B?WWR4akc2MUt4amZUeWhBaEhCaktlZkc3NFZLRXc4WldWOCtUeW1qTllMb25P?=
 =?utf-8?B?Qk5SbXl1Sjh4cG5BeU9xWnVpS0p2b28yaHJRZFpKRDNudjBja0lINkpSbTFs?=
 =?utf-8?B?Mk1SZTRNSGY3L1hHb3ZNenBoU2ptT0pVeTRQaGxnbW82T0lYNEw4Y3IwZTBZ?=
 =?utf-8?B?THkxTGNPNjE5OVlrK1J3alVwUGEyVVFDVnZERkZVZCtaam1rOUIyQit4Zzln?=
 =?utf-8?B?Um51M2lrcldxcFBwa294UlFJMnp1NTZLWkFEMnlWODFJWW9hV2J3UThqTmxw?=
 =?utf-8?B?djg5MC9ISDJPWUpWUjN1MmZVZXRMR2V5QnR4cW5vMlQxMXljWlNLZS9ZQVRo?=
 =?utf-8?B?eVhmYTFPRVJQWXNkQ1pubG8xaUp1MVhyLzFqNjhKb0dtYmZHTzh2VWlnbldG?=
 =?utf-8?B?RklhT0ExQWZaMkRiZ2lnUGdEQXZsSkhDalJhS2JmLzBTMjgvUGYrQnFZakYr?=
 =?utf-8?B?ekZtZ0ZnNVVsT2xIUXluQ1pDbWtjbGNpQUNLUHg1NUlWNzdtVFVqNEdzeWps?=
 =?utf-8?B?WUZkTkQyVVNpSVVKeDcrelFoeWEzMEhSWlZRT0ZPWHhlTklreFRsczY2R1Q4?=
 =?utf-8?B?Wks0cGhoZldsU3JOMWsvTFRmdzRaS1h3SzByTFFUZWY4Y1hOQ0JnUmRqUmNq?=
 =?utf-8?B?V3NhcXNGMFNiczRqRTNyMlZ5L1dWZXg2b014Q3U2b1ZMaUIwcXBJd0Z2dkk0?=
 =?utf-8?B?b0czNENuQUhrWE5aUG9YeStUWUxaTmdZbzdvRHY1MWgrZytabEc3OWRJckdQ?=
 =?utf-8?B?SjE3QUpiTkV5VVJTOTR0azEzODVXZ2FUWTFMaFE3MFljWnRtcEZ5ZUhFRzc1?=
 =?utf-8?B?c2dCOURMTWpoZFNnM011MHlkanNrQWNrL2NJZnFuL0h6cVc2aVRXQlczZ2VF?=
 =?utf-8?B?UWdHYm9USGM1VERBUEVLaGFHYzlpZTdXaWNEdXpFL05UZjZ3ZTRZcHY3M1dV?=
 =?utf-8?B?L2hNYzh1d3p2TG9xV0lFS3RYSHVQU01RNVFzc3Y3ZzJBdEd2alEwd2wwODNH?=
 =?utf-8?B?WWhyWldOcGY5QzlMd1kzUmUwdTI3OXA4WGxhVU8zNVp2Nm0rVmNsYnUxdDRt?=
 =?utf-8?B?Ykk3bEM5WHNGL2JjMnpBdGhRbS9DTXhDejFmUFNKeDFPOE9BNDVCZ1ErWDZB?=
 =?utf-8?B?ZHZJZjBqMDZXNGJvYjNFU0pFNitraDM4am5QczFMMHBMNHpPZU5MRUxKNGky?=
 =?utf-8?B?bzExaHRNNTZzSXl1VWVqTDdGaU92NCtNSmp4NWs4NGZyN2tFY2VPTmpmRDUx?=
 =?utf-8?B?eDA1Vll4djhjbVpPRkdycWJLNWdBRGFEN2dPZG9CZXMyTDRreXIxNjVjRUNC?=
 =?utf-8?Q?5mX/QgN9xcaFh63uTn4sL5xJABVI1IH4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 09:58:18.8901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f656db57-3bb8-4b8a-379c-08dd12b7d93e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267

Hello Vincent, Mike,

On 12/2/2024 2:47 PM, Vincent Guittot wrote:
> On Sun, 1 Dec 2024 at 14:30, Mike Galbraith <efault@gmx.de> wrote:
>>
>> Greetings,
>>
>> On Fri, 2024-11-29 at 17:17 +0100, Vincent Guittot wrote:
>>> Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until its
>>> lag has elapsed. As a result, it stays also visible in the statistics that
>>> are used to balance the system and in particular the field h_nr_running.
>>>
>>> This serie fixes those metrics by creating a new h_nr_queued that tracks
>>> all queued tasks. It renames h_nr_running into h_nr_runnable and restores
>>> the behavior of h_nr_running i.e. tracking the number of fair tasks that
>>>   want to run.
>>>
>>> h_nr_runnable is used in several places to make decision on load balance:
>>>    - PELT runnable_avg
>>>    - deciding if a group is overloaded or has spare capacity
>>>    - numa stats
>>>    - reduced capacity management
>>>    - load balance between groups
>>
>> I took the series for a spin in tip v6.12-10334-gb1b238fba309, but
>> runnable seems to have an off-by-one issue, causing it to wander ever
>> further south.
>>
>> patches 1-3 applied.
>>    .h_nr_runnable                 : -3046
>>    .runnable_avg                  : 450189777126
> 
> Yeah, I messed up something around finish_delayed_dequeue_entity().
> I'm' going to prepare a v3

I was looking into this and I have the below diff so far that seems to
solve the post boot negative values of h_nr_runnable on my setup; it is
only lightly tested so far:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 87552870958c..423981e65aba 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5464,6 +5464,10 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
  static void set_delayed(struct sched_entity *se)
  {
  	se->sched_delayed = 1;
+
+	if (!entity_is_task(se))
+		return;
+
  	for_each_sched_entity(se) {
  		struct cfs_rq *cfs_rq = cfs_rq_of(se);
  
@@ -5476,6 +5480,10 @@ static void set_delayed(struct sched_entity *se)
  static void clear_delayed(struct sched_entity *se)
  {
  	se->sched_delayed = 0;
+
+	if (!entity_is_task(se))
+		return;
+
  	for_each_sched_entity(se) {
  		struct cfs_rq *cfs_rq = cfs_rq_of(se);
  
@@ -6977,7 +6985,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
  	struct cfs_rq *cfs_rq;
  	struct sched_entity *se = &p->se;
  	int h_nr_idle = task_has_idle_policy(p);
-	int h_nr_runnable = 0;
+	int h_nr_runnable = 1;
  	int task_new = !(flags & ENQUEUE_WAKEUP);
  	int rq_h_nr_queued = rq->cfs.h_nr_queued;
  	u64 slice = 0;
@@ -7124,8 +7132,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
  		p = task_of(se);
  		h_nr_queued = 1;
  		h_nr_idle = task_has_idle_policy(p);
-		if (!task_sleep && !task_delayed)
-			h_nr_runnable = !se->sched_delayed;
+		h_nr_runnable = !se->sched_delayed;
  	} else {
  		cfs_rq = group_cfs_rq(se);
  		slice = cfs_rq_min_slice(cfs_rq);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index ab911d1335ba..f4ef5aaa4674 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -457,6 +457,7 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
  
  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
  {
+	SCHED_WARN_ON(rq->cfs.h_nr_runnable);
  	update_idle_core(rq);
  	scx_update_idle(rq, true);
  	schedstat_inc(rq->sched_goidle);
--

I'm not sure if the change in dequeue_entities() is completely necessary
but I added it after seeing the (DEQUEUE_SLEEP | DEQUEUE_DELAYED) in
throttle_cfs_rq() but there the entity cannot possibly be a task so
perhaps that part is unnecessary ¯\_(ツ)_/¯

Still testing! Will keep an eye out for v3.

> 
>>
>> full set applied.
>>    .h_nr_runnable                 : -5707
>>    .runnable_avg                  : 4391793519526
>>
>>          -Mike

-- 
Thanks and Regards,
Prateek


