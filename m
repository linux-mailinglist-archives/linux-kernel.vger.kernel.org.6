Return-Path: <linux-kernel+bounces-403565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0812F9C3743
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA975281620
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D4148838;
	Mon, 11 Nov 2024 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wez3HpDE"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7AB32C8E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298081; cv=fail; b=YwvDPXrDjDslf6acWrpxcDPNulOdWdlBeL1i/3OW+fPElEz1rw3vp6GvcPwHnG8AyfsosKWlLvFUv8Ki8z3ISfNZJjEnw1qvmq8kokvz+jLAWv+KUowg+n4l0qb5siXNtNmfw7BhuEs3ZA0ZTuPqcqmqRQwYB8oLryFX1zaeJEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298081; c=relaxed/simple;
	bh=q/Aeot7c3ZJcQj1DcrDSMQ74jgGfUcsD1jY9Y8Tqw9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RpCbPyKKGv6T5JYpczKfVKS+1eADVIbOM4S9PZTYQvPT1p2+49iOl7So0R3HJssL7OEEufEyzb0YzzMmWBpGczj0Vm7RsEBWD3s0LMK+J1SIQtW2blB5s+LSWsKHZt573SaZgrrfDrLBepzmLI1aulH1Tn/kWgeFMKEO0fgH6NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wez3HpDE; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sS212FomSm8IZjVs85k7zrBRofQNE12t4CCejhC7zVAfcI+3Pr4Egx3xxQKIdXeY8KADyiLh7lzdIbybGwEJ23T4RcA+tiv9qCy8sJc4KZoCOD7NwDYHxrG0qg6WRNThm/AmKuWIOsJOqb5xGR6NBBF0ALpkulUUwO8WKON0F2BrsdFzzKn4zt19Xv1VlPBU5tdfuWvmg7KGoC8lMXq4QQbUTPujSMYXsCcj/HTlLaiMdPafmycC3JzWVq2gEqfzTLqLM/MuMs8evVzc1WhZws6qGMuo1Q2FAlb2ZMaCwJ3DV2uPzmW/yIKa8hfNxS+wNJZnw4tnqgtSMycbvGvchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSbKwfJAqXEsbwTF53L6CrG20iZnHYYQhRDlgjDHmKc=;
 b=fuq/QDC/JsZMGd2e/MPujsvK2WmD7W3OvN1dRhl0RYPdfgJV4+uPtLZMZfFJ6a1Nov7+6+rOJ0NfKjpGbUrt7NaNwxn70gzyS6fNYDXeq6930CM8OTmwR5Ten1ZJzZdKvp1drjk1BwSvCO8K21YRPyqzNIrzAyrLfv9BV/Fljiq09w17mfG5tF7Ag8vZP7+8jO5fnZI6tXKPlgLkwy64AVb4Tqhue+hXIR9U65oahEP/RNkpXo5DB5agPGitvnGbskq4IbyOwv8pRYAqlv29is0vRVSvK/6IHKonZKZqYLk8ai+WWp1KDxd5R1H+9nRGPBNi9hGiRBP0CaafVWCE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSbKwfJAqXEsbwTF53L6CrG20iZnHYYQhRDlgjDHmKc=;
 b=wez3HpDEJEj4S5xiylUL7Wg/7zT14AvbFwfXH/WTP46HBu93LuDiZbv+Gx8GylNHDXCVb65OglOM+joF5MmwcKSILIhNK+beKUqr1JiNgJTEF/pBH86NkBbnqY+oRBm6G9+8wOBSYVJsvD/t7mPnaJRKK7Hlzsk8JxTb1VVB4Bg=
Received: from BYAPR11CA0092.namprd11.prod.outlook.com (2603:10b6:a03:f4::33)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 04:07:57 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::cb) by BYAPR11CA0092.outlook.office365.com
 (2603:10b6:a03:f4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Mon, 11 Nov 2024 04:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 04:07:56 +0000
Received: from [10.136.47.222] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Nov
 2024 22:07:50 -0600
Message-ID: <aef0df21-7cd6-8e92-dd58-f571669b2115@amd.com>
Date: Mon, 11 Nov 2024 09:37:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/24] Complete EEVDF
Content-Language: en-US
To: Samuel Wu <wusamuel@google.com>, Saravana Kannan <saravanak@google.com>,
	Peter Zijlstra <peterz@infradead.org>
CC: Luis Machado <luis.machado@arm.com>, David Dai <davidai@google.com>,
	<mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<wuyun.abel@bytedance.com>, <youssefesmat@chromium.org>,
	<tglx@linutronix.de>, <efault@gmx.de>, Android Kernel Team
	<kernel-team@android.com>, Qais Yousef <qyousef@google.com>, Vincent
 Palomares <paillon@google.com>, John Stultz <jstultz@google.com>
References: <20240727102732.960974693@infradead.org>
 <CAGETcx97SEHP5MspzBHsMkmSExnY870DQ-F5L077vzOGnPx0UA@mail.gmail.com>
 <4a3dac53-69e5-d3cd-8bc0-3549af4932b3@amd.com>
 <20241106110925.GK24862@noisy.programming.kicks-ass.net>
 <345dfc04-753b-4411-be2d-e4f604c1c4b1@arm.com>
 <CAGETcx_ZkvCgG0F41-cW9NLXn8s__6zZF8=yjEqR05ykhZAtiw@mail.gmail.com>
 <CAG2Kctp9LpVybdhNURSVe0Xgk65AiJ55qDg+GL2+NiTXAfWYKA@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAG2Kctp9LpVybdhNURSVe0Xgk65AiJ55qDg+GL2+NiTXAfWYKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2f4573-49f2-476f-cf98-08dd02066c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTl6ejRqdnpTTVRJYU1KSndNV09RSStrekxkazBSZkZuVTdTN1lSU29VcnNx?=
 =?utf-8?B?ZUZ0aGpwUUlhVU55QnpsSFVZRFg0UCtSaDFTZEt4MzZ3YkdkT3JHTnN2TFF6?=
 =?utf-8?B?aHkzQ1l3dDNjZzRSY2ZDVWtKeXhvbnhhZ1NSeWNQZERNTlJHN3VRVyt1bzB6?=
 =?utf-8?B?Qm1FQUtERUxoS2M5TVVid3VhdnJ4ZEFJbXlRWkVSVVVGc3FKeFlDRUlNeCtH?=
 =?utf-8?B?N1ltVDFxT0FidnUzZThSdlpqd3IvYkZldkN5ZVcraTAxWHJCNE9TenI1dy9O?=
 =?utf-8?B?bklHOWdkVDdZWVFzU2pBelhVQ3lvUnJCdEhFUU03WGFYR2hPTUVRa0NRUWFH?=
 =?utf-8?B?TzR6ZHlsVFJsWE5tamdCRzl2N1BUejQ3YVVkN2pTbmV5SG9YaHVXV2V1aW04?=
 =?utf-8?B?S09WZkFFTEQyOTA1cjgvSFJCLzFTWjNTcDRtVmM1S0ZGYzNmY3pPcUNLRm4v?=
 =?utf-8?B?QmJUU2t1Mk5NT0pxTHVyUHZYSUVWakZLaTREZnVVWm5iODM2blV0dEtTN2Fi?=
 =?utf-8?B?Sk8rQlJSR21QNlhLQUx6RkU2RjhCY3V5WE9OU3E1UDY3WUQzV2NnQWpISnFt?=
 =?utf-8?B?NDUrYnBoWHp1cTJ4MTVUVUIyeWVTeHJEbDZCc25rNVZERk5qUVJXVWM2bDVh?=
 =?utf-8?B?ZnJKbmdWWk83R2krTlc2VVY0d25BRGpMRGRBQUZ6VDQ5TWFhNkhJTjYxcWho?=
 =?utf-8?B?ODRjamNGUDMrdE54NGlvalpZalN4SWt1dklPRGM1c3VybmlaTitBQU5oRyty?=
 =?utf-8?B?alNweHhZZUppeGVLTWdoT016akQ3VG1KNERIbUZtRVRka3ZsckpQNFk0MHJz?=
 =?utf-8?B?Y2tIMHNMWmtKRGJhQlo0K3d2dTZZOVR0MDlKd1hVVVBTWVBzcjFscUZpNDJm?=
 =?utf-8?B?NlpiM1RoVjRnRGJrOEp3Q01NNmtYaWNmb2FLSHFZanl6TnlvUkpZMzMzUjkv?=
 =?utf-8?B?cHI3dU0veUx2V3JvRkpUUFJFTGdrMlI0d1E1N3BKYnNBN3hGTDExUVhDZzRO?=
 =?utf-8?B?UzJER0hZM0pOdmhOWG9YSWNwbXF3a1ozZ29SMG05SzJUVENXSHFoeitKL2FF?=
 =?utf-8?B?dmFBYW1WZjFHSlJMcTdyNFhlOFNqbTYwS2MyV3J4SzdjYTVTMnNTMlZRbVJX?=
 =?utf-8?B?NWpuRzJDOHB6TkQ3a3pmclBwRVRMcGxGWlpKUXNHOElvUDE4aERONndvRHpJ?=
 =?utf-8?B?cXFxeTd5MDJ2M1BFYjNRR2hjanhSNzZva1gvcWdkaExSM2NrRjk1R1JYMGwx?=
 =?utf-8?B?RlhHblA0OUpSQmNjNzVIVDZMVCtTZzRzSWdnd1QxZndMamVrWGwwNEQzNitt?=
 =?utf-8?B?anR2dEQwTmQzRFhNTmxzNXEweTlaUm5Tdkt0OGFEMEFTNmxGRHZock9aalp0?=
 =?utf-8?B?TzdNMUw3Ti8vNkxJaVhjeHVLeGwxcGl6WUtZd09WdkVKbVRKTVd6NjBzYzRP?=
 =?utf-8?B?S21EN2QrNE9US1Z4YldwaWk0S0hPak5xcDEvRndlUDNaalY3MU85bVJuWTR0?=
 =?utf-8?B?b24vYmtIaW1WZWZVZ3NmWUR2bFI0b2VhUmJsSWQ0SGpCY05uUUhKUTF6V2J3?=
 =?utf-8?B?MG1nd1FvVFhnRGpjS2tWSlcwRlRaK1oxQUNabStzTUVkbGo5OTB0RTQwWERZ?=
 =?utf-8?B?SW5FdjJRb3NnS3F1R1dra1NqVS9lUzdQMXFZckVjbmpnWlJic0dPeXpXUlFF?=
 =?utf-8?B?djFwVlFseGRwWXU3aGFKOVdXcDNYU2M0Y3UxcHllTU85cC8zOTUrVm9hQmIy?=
 =?utf-8?B?L3Z5K3Zsc2k2V0UyMVQ5cjdTand1WVZIWnNqbmhuUEFxVERwdU9sZGZuUTIw?=
 =?utf-8?Q?206UaPh2qI5N4lBoJJ9Vm5oeIE66HPg0UdJkk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 04:07:56.8129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2f4573-49f2-476f-cf98-08dd02066c92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321

Hello Sam,

On 11/9/2024 4:47 AM, Samuel Wu wrote:
> On Thu, Nov 7, 2024 at 11:08 PM Saravana Kannan <saravanak@google.com> wrote:
>>
>> On Wed, Nov 6, 2024 at 4:07 AM Luis Machado <luis.machado@arm.com> wrote:
>>>
>>> Hi,
>>>
>>> On 11/6/24 11:09, Peter Zijlstra wrote:
>>>> On Wed, Nov 06, 2024 at 11:49:00AM +0530, K Prateek Nayak wrote:
>>>>
>>>>> Since delayed entities are still on the runqueue, they can affect PELT
>>>>> calculation. Vincent and Dietmar have both noted this and Peter posted
>>>>> https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219.tip-bot2@tip-bot2/
>>>>> in response but it was pulled out since Luis reported observing -ve
>>>>> values for h_nr_delayed on his setup. A lot has been fixed around
>>>>> delayed dequeue since and I wonder if now would be the right time to
>>>>> re-attempt h_nr_delayed tracking.
>>>>
>>>> Yeah, it's something I meant to get back to. I think the patch as posted
>>>> was actually right and it didn't work for Luis because of some other,
>>>> since fixed issue.
>>>>
>>>> But I might be misremembering things. I'll get to it eventually :/
>>>
>>> Sorry for the late reply, I got sidetracked on something else.
>>>
>>> There have been a few power regressions (based on our Pixel6-based testing) due
>>> to the delayed-dequeue series.
>>>
>>> The main one drove the frequencies up due to an imbalance in the uclamp inc/dec
>>> handling. That has since been fixed by "[PATCH 10/24] sched/uclamg: Handle delayed dequeue". [1]
>>>
>>> The bug also made it so disabling DELAY_DEQUEUE at runtime didn't fix things, because the
>>> imbalance/stale state would be perpetuated. Disabling DELAY_DEQUEUE before boot did fix things.
>>>
>>> So power use was brought down by the above fix, but some issues still remained, like the
>>> accounting issues with h_nr_running and not taking sched_delayed tasks into account.
>>>
>>> Dietmar addressed some of it with "kernel/sched: Fix util_est accounting for DELAY_DEQUEUE". [2]
>>>
>>> Peter sent another patch to add accounting for sched_delayed tasks [3]. Though the patch was
>>> mostly correct, under some circumstances [4] we spotted imbalances in the sched_delayed
>>> accounting that slowly drove frequencies up again.
>>>
>>> If I recall correctly, Peter has pulled that particular patch from the tree, but we should
>>> definitely revisit it with a proper fix for the imbalance. Suggestion in [5].
>>>
>>> [1] https://lore.kernel.org/lkml/20240727105029.315205425@infradead.org/
>>> [2] https://lore.kernel.org/lkml/c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com/
>>> [3] https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219.tip-bot2@tip-bot2/
>>> [4] https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm.com/
>>> [5] https://lore.kernel.org/lkml/6df12fde-1e0d-445f-8f8a-736d11f9ee41@arm.com/
>>
>> Thanks for the replies. We are trying to disable DELAY_DEQUEUE and
>> recollect the data to see if that's the cause. We'll get back to this
>> thread once we have some data.
>>
>> -Saravana
> 
> The test data is back to pre-EEVDF state with DELAY_DEQUEUE disabled.
> 
> Same test example from before, when thread is affined to the big cluster:
> +----------------------------------+
> | Data            | Enabled | Disabled |
> |-----------------------+----------|
> | 5th percentile  | 96     | 143    |
> |-----------------------+----------|
> | Median          | 144    | 147   |
> |-----------------------+----------|
> | Mean            | 134    | 147   |
> |-----------------------+----------|
> | 95th percentile | 150    | 150   |
> +----------------------------------+
> 
> What are the next steps to bring this behavior back? Will DELAY_DEQUEUE always
> be enabled by default and/or is there a fix coming for 6.12?

DELAY_DEQUEUE should be enabled by default from v6.12 but there are a
few fixes for the same in-flight. Could try running with the changes
from [1] and [2] and see if you could reproduce the behavior and if
you can, is it equally bad?

Both changes apply cleanly for me on top of current

     git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core

at commit fe9beaaa802d ("sched: No PREEMPT_RT=y for all{yes,mod}config")
when applied in that order.

[1] https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219.tip-bot2@tip-bot2/
[2] https://lore.kernel.org/lkml/750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de/

> 
> Thanks,
> Sam

-- 
Thanks and Regards,
Prateek

