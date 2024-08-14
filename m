Return-Path: <linux-kernel+bounces-286994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6AD952157
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F181F22E39
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FB11BD00F;
	Wed, 14 Aug 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tuHfITAC"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3591BC9FF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656923; cv=fail; b=nR375skYCSYoLcodgl2hY8wH83J+QBTrBB3pu0/Mq2t71aeVpO2f4Vke4+n1WqpAxdqcJCko4/JaP2E1LLkp+/AJy5IgppAE4mY/t63Ejej9/ulBgARK8I+2thf7rb0D/dFWlA3Aat9UlGCojH+11Nisa0xZVmu5LCXhPm0aYoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656923; c=relaxed/simple;
	bh=WKQh19vCh2/cn06dQQG4a252mIXXwqLLVO7p6i6Q4ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qYzm797zrgZrEK5HO0mjpQG8mo0WiwV0odB+IYH55EKe3MQzssehl/L/CSJyGOQFHTCHUpL2MlYjNSknXsQHnUlEON8i6Yo2j0JebUkmaYvySsG6vc9JruxNJuknFpmmqRIQ9RqwNGj3/Gsq1UUzCTthpRS0NOlEeR7P1B1/itQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tuHfITAC; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inIVXMse1Jx466eU7U+eIfDbmGh4l7A2fv+A9F9n76fD1TMucqN7jyiFkREwE73ClhFZtpJ0FvDbIdqyx59wLjAglOASRWgxHW7p7OtJBsC9hPBAli5wF9k1+o7xJQSfSJGAhPjyLUv0zO6xYbX6fiPkxePKsbSq5MggUJbAJ1Y4LA8HyeM5G3tDEs5Y6Gt6D2Ll0KRthiUOHNAYTuwDCwbGpKa9fZ9xQCbwOXksR0QDrP6b1GHgz54VxtGr0Y9sXAuZxAWCh044R/sDL2Oy+OYR+u33epWggQ3m1VivcT7l5GE++n8SZQxAq99al0b0/x4GYlrKWX772Y9xCUACUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GARkHwlOL5fG83Wyd8V6MhpSD+VoTwFvGN/Rj41U2Fg=;
 b=AjC7uSa+lC4urTexMwtsY33uCH4AJUyRRa5RVuXMKz4f+QelDrT/qwgN8BJIbxtPopitM25DpfpHi2wK9TeSfBrOdJ63NiXaQn0WW4VkSUJ5aw+R0LtT3fXnhfpI2C/EHMMhQACs/U9ZsHJN5n2vrQkR3icmHDLCsFuCW+tdpIqZXCl9h4yZfHtCaXSwKzKOQqgx/dUck23YK7mJloavD6xq5X89A9AbEBErcQ/W4WtwM+rp3JDikq0TO+/jByampJGzCpRMp26ntf54iIjDZ+kuMPfv+1lKR400GuTwvaS1IZHupUdWMr+GqASs1RjJxtuF2RQhfXbKGNLN+eX6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GARkHwlOL5fG83Wyd8V6MhpSD+VoTwFvGN/Rj41U2Fg=;
 b=tuHfITAC66PDL/T7crl7HZE1EFlGVZFhSeg1am/lbP4XjmKxYf2fJpkueiTC9NVNi3jh50t6H+7AlAsa6V1eTxc0QAHnP6f6EfdjBX3cOBxAFeh0iQKxcPGDmMsSWbs3k8jb0vTecv7WXFlfD8biStJuJ5mxrUxDXy0NiPXdo2Q=
Received: from BN0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:408:141::10)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 17:35:17 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::46) by BN0PR07CA0010.outlook.office365.com
 (2603:10b6:408:141::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Wed, 14 Aug 2024 17:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 17:35:17 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 12:35:13 -0500
Message-ID: <15f65062-545c-9750-b296-040053edf5a6@amd.com>
Date: Wed, 14 Aug 2024 23:05:06 +0530
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
To: Vincent Guittot <vincent.guittot@linaro.org>, Mike Galbraith
	<efault@gmx.de>
CC: Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
	<bsegall@google.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>, <wuyun.abel@bytedance.com>,
	<youssefesmat@chromium.org>, <tglx@linutronix.de>
References: <20240727102732.960974693@infradead.org>
 <CAKfTPtALe942tjoyq1RqSYyM40PG+tfEY8skRDxRM1daWLSKUg@mail.gmail.com>
 <1572d0f2646312767a3ef8b72f740c9033163bf3.camel@gmx.de>
 <CAKfTPtAjXejbsGS+Wd0maiiUyCgSb2xPVZGUXUPCSw_kNLJRDA@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtAjXejbsGS+Wd0maiiUyCgSb2xPVZGUXUPCSw_kNLJRDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c2bf8e-3648-49df-474c-08dcbc877670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTVVblpPQzltdUROTjJmSk13UDd5bWZNZG5WZSthV2R3VDdNeFEvWTF1YUx2?=
 =?utf-8?B?aFRZeTQ0ZGxiVGo0WHB0b081ZCtSQ0Y4dUlNcWdUL3dON3BRVGc5WjhDdEdo?=
 =?utf-8?B?RDdXNnJIbmM0MFBuRnlmdVFTcjY4UHR1OVhYTmxUN1FNSUZ0T2hCRnZMY1ds?=
 =?utf-8?B?d1pKTnU1ZVNITXQ4aENHekVoVWp3b3E3c1RBNFFSZGZJM2hHdFQ1dkF3blQ1?=
 =?utf-8?B?c2syVTFTdGxoUjBFcjZWMnptNnMvWFZrQmFvUm92Q2JhRnRjNG9yZGtUQ0pN?=
 =?utf-8?B?QzhFcmVjTko0bkNhSjVINEx1akJBS21oZkNGS1FIaEZlZ3pxZU8xSmFwS0Y5?=
 =?utf-8?B?dk1lMTk5NDNZc0IrQnpxWGtjZjAxaUMrQTg1NkYwMkl2bklxS1hqZk00dkJZ?=
 =?utf-8?B?Wmdmd2E4SDFGUk9rOGlndHR6SkkyZmQvZHMyOEFMRHMvc0VPMWI4bDBIdm9S?=
 =?utf-8?B?eU10V2h6MkdYTW16KzBxR2E0UG9RVm9KRTVXOUZIVVRjNG5VTVVQSlpXYWMw?=
 =?utf-8?B?RnFJbkZVV0FrTVJLV0ZTTkRURFNXU0V2OEdpem9XQ01hc245NXNBOTM2MjZl?=
 =?utf-8?B?aExIc2E5RFNLeGE1VFBkNWZjMGJlSTMxS3JYaTFnR1lyYzUzQTNhRkR1N3Zz?=
 =?utf-8?B?a1JFSG92UjVJWFJOQjRmVS9CMEx3M2JsSFRlUzZmNThiYmM1TFZkTnlCL09o?=
 =?utf-8?B?RUNOQTA2Z0x0aENrTXZUVTh3UWkxV3JSWHU3NE9FNU4vekJsNzVoWDhrMUxz?=
 =?utf-8?B?eEJLM2h3aHlmaW4ybExMS2hyZGFHYjU0UWo4YVA4RmFFWHRmc05FUTdIbW9N?=
 =?utf-8?B?SkNkVzBoN2MxcDhTSHR0aWM3Uk5LaHRYSk9UWS90WUpxbnJSakh1RytGYVRh?=
 =?utf-8?B?WjZlTnlGTXJJbngva2hZNXVpUitHLzRRczhDNmZ1R2RKMXF3Z0RUcE9lVSt4?=
 =?utf-8?B?MUNsRE1iSWpiK1dqVEJSNENMYmVFV2VLQnBNbG5sWjVjakxPZ3UydmpIYytI?=
 =?utf-8?B?T045S0kxV25xd0d0by9LRE9id1VuK0VjdWFDcXp6cTUvMzhmMHNSb3RqaHBh?=
 =?utf-8?B?ZmxGNHh3Nk1CNnlNblAwZmQwRiswNW4raEZTSVYwOG1rbWVEaW1qTzlFTURF?=
 =?utf-8?B?Zm1Sb3QxZHZOWndNdTFpUTdrNzVvYlllMzdhbjZBcHhDbHdsa3RsdnZpL08v?=
 =?utf-8?B?ZldGUk4veHV6eGhVVVFXdWdPZWJnYzBiZkdsSGtZOHRnWEdoc2ZYUG1qeC81?=
 =?utf-8?B?aENhZ3E0SDQ0V0hYS2liYjkyQjVRWEtoS0kvKzhZRjRqMk5BUkNNaVo3RG9k?=
 =?utf-8?B?Mm1ra1QyNmFxRWlGTTNMVU5PamNMSExpZ1NESVE4RXZSc1ZGN3NRQkVxaXAr?=
 =?utf-8?B?ek1XMmlwMjFXSVV5MFg5R3pMS0FMdDVsbktDTDNEUFA0YVVwV1E5RGhOYmdO?=
 =?utf-8?B?c256NmhMUFFYZlhDRGorMG9HdVlxVnZ6bzMrcUxrdDF4Q3g0RHBpRGhSakpt?=
 =?utf-8?B?emRnK29LUTlsOE45bDV6LzRCVmFVcXN0eGZYZ2Z2OU5aem9wMlpURVhXMEFL?=
 =?utf-8?B?K3lmbUpzSHpXeFk4UkkxNk1Vb3JFZUdzdWZPczFSZGo2NmJWYjZNSDlIYWln?=
 =?utf-8?B?R2h1eE0wVVBvNDBxZFlMdmZGM1o3MjRjTEdiS1VFb3B4MFJwdVNvNXlxL05H?=
 =?utf-8?B?blc2SWo2enlpRk50UDc0N3lFSnJCeWYyczhyV0FyZHRjdVA4UG9xNlJLZ3NE?=
 =?utf-8?B?YW9xNDNMTHZwcWVJaTRRb1JzT3k3ZEdhUVhpeHgxMTMrN3NBb20vUUJqTmVy?=
 =?utf-8?B?NDliWTBJaTZ4YlUxRXMyYkFIVW1xeW5BVGdLMEFaMWpCMTIyTElIRzZhS1ov?=
 =?utf-8?B?eXlxYjh1VCsvVjJBR0hBNHJEOElPclYxWFNOSmt2SElYd1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 17:35:17.2819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c2bf8e-3648-49df-474c-08dcbc877670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578

Hello Vincent, Mike,

On 8/14/2024 10:29 PM, Vincent Guittot wrote:
> On Wed, 14 Aug 2024 at 18:46, Mike Galbraith <efault@gmx.de> wrote:
>>
>> On Wed, 2024-08-14 at 16:34 +0200, Vincent Guittot wrote:
>>>
>>> While trying to test what would be the impact of delayed dequeue on
>>> load_avg, I noticed something strange with the running slice. I have a
>>> simple test with 2 always running threads on 1 CPU and the each thread
>>> runs around 100ms continuously before switching to the other one
>>> whereas I was expecting 3ms (the sysctl_sched_base_slice on my system)
>>> between 2 context swicthes
>>>
>>> I'm using your sched/core branch. Is it the correct one ?
>>
>> Hm, building that branch, I see the expected tick granularity (4ms).
> 
> On my side tip/sched/core switches every 4ms but Peter's sched/core,
> which is delayed queued on top of tip/sched/core if I don't get it
> wrong, switches every 100ms.

I could not observe this behavior when running two busy loops pinned to
one CPU on my end. I'm running with base_slice_ns of 3ms and the
sched_feats related to EEVDF complete looks as follows:

     PLACE_LAG
     PLACE_DEADLINE_INITIAL
     PLACE_REL_DEADLINE
     RUN_TO_PARITY
     PREEMPT_SHORT
     NO_NEXT_BUDDY
     CACHE_HOT_BUDDY
     DELAY_DEQUEUE
     DELAY_ZERO
     WAKEUP_PREEMPTION
     ...

Also I'm running with CONFIG_HZ=250 (4ms tick granularity)

     CONFIG_HZ_250=y
     CONFIG_HZ=250

Enabling sched_switch tracepeoint, I see the following:

             ...
             loop-4061    109.710379: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.714377: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.718375: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.722374: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.726379: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.730377: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.734367: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.738365: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.742364: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.746361: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.750359: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.754357: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.758355: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.762353: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.766351: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.770349: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.774347: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.778345: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.782343: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.786346: sched_switch: ... prev_pid=4060 ... prev_state=R ==> next_comm=kworker/1:1 next_pid=1616 next_prio=120
      kworker/1:1-1616    109.786412: sched_switch: prev_comm=kworker/1:1 prev_pid=1616 ... prev_state=I ==> ... next_pid=4061 ...
             loop-4061    109.794337: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.798335: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.802335: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.806331: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.810329: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.814327: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.818325: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.822323: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.826321: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             loop-4060    109.830321: sched_switch: ... prev_pid=4060 ... prev_state=R ==> ... next_pid=4061 ...
             loop-4061    109.834317: sched_switch: ... prev_pid=4061 ... prev_state=R ==> ... next_pid=4060 ...
             ...

(Trimmed traces are for busy loops with pids 4060 and 4061)

I see the expected tick granularity similar to Mike. Since Peter's tree
is prone to force-updates, I'm on

     git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core

at commit 4cc290c20a98 "sched/eevdf: Dequeue in switched_from_fair()"
which was committed at "2024-08-14 08:15:39 +0200".

> 
>>
>>          -Mike
>>

-- 
Thanks and Regards,
Prateek

