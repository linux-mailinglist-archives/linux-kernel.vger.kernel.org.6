Return-Path: <linux-kernel+bounces-403598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3849C37B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EBB1F21DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C9D13E3F5;
	Mon, 11 Nov 2024 05:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nvUehxDT"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E24C74
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731302254; cv=fail; b=TXzEKMWh7baZMGEYUtHLCuHKz3kk1RTOLVCedCj0x2MFH+exV8XGACIc09mCL3GKGJ6WAsuMckZj5NahtSoqQ4J0nj5Ibs9zBwE0U57n6gw051tKXDdTfHb6F5/X2YOz/bc9RRptLHr4NonpoPlip3aKneg9gg/qT0AzxzBo/OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731302254; c=relaxed/simple;
	bh=pMZ+EP8iVwHQ9L5Bi/SzcbZBf/imhOH/MLqewzibFvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=okZfSIkgo98MATqT4dbjDehwMywCMkF29rPoe4mONidT6G2C4GI2AlN8S7H/9tCHhWIhmM1q5KbMhvoIzbJexn3q2b/KF1iEwRQN/wFXtjAoHr1cOO8StwrHhWAvmExbB1pWwhtasrta7k66AjBRzuhFdzDVxOLlTFizA7zAQ2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nvUehxDT; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdypBgiBeyU6SeXBe+G1REvs/ImmG8dVgqN5V4duJa4HcD5tp51ehaxlrQG/PP5BtaIh2n/OBiwZcLYtfeOT9U8gQ634AzrdZD/c70prT+Vzj5ET/pP7tNpj34LEqP0VJfRBxwMC94GOAEWvuC7p6kpNwOOUE5Yb0ch5PjtYNc+JtpHWnMNtN6TC7es2L4H6MXWU8DHKasPMy5A1H+EiX53Nw9LGcLH1b0Rn5eyOhNBIb7KS2XRMd10w6xr/ErWZThMpeC4MsGrsBcSwT4QAS+q/sgEdQpdtsiNeu2QJFmsbpP4tMnsBBZ6x7PFz0UsXz42Sk5/PRqagCdexCHnQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ss9JtYCqb2kA3dTVMQgEkZV55u4Lc4AqialWK+6ul1Y=;
 b=mk7P/oAgNov7/uZgeV5MhhbOYE0DR0qUawZW+qFbdPJGmrglGs0vI5lNa6X5D6AP468s5RqpzHTAHooVI/tM1V9/QmV2dJqtMEq51N2wPjqchQKaLpJu3uDK2GHVO8xWOKgFvazY7i6GkgPwgX2nddnWghOXzNGoysE/iuUwJ9JGcpFhXHd8PWAwpEiEEYSg0w20R7CUaE6cc3NqLwhdyQmN+TzWijsC/RvoVgB2Y5OGJjwXZQiy9UPYt02uyHoUpMi4fbprAbsu0eqXFwvh+nQedeDF55IWPeGXt0nuW+X3OzTdvc209ExZh1jmCVYuQbC2FSFuNgu9xscDPaX25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ss9JtYCqb2kA3dTVMQgEkZV55u4Lc4AqialWK+6ul1Y=;
 b=nvUehxDT8afw2O/OgCs49rQuId46Ug/rdJl6e660pIZffziim3/vZaf/dooSNuKVz2+GECPpD1PTTaYzA+O00ucEwfLD6dylOXt6RA3l9U0neDujzHgVdBDKoMgMc/dBTi+GsWTwqjHYuC3KWeix2kLP58CClxfLXjaimw/XdM8=
Received: from SA1PR04CA0011.namprd04.prod.outlook.com (2603:10b6:806:2ce::18)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 05:17:29 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::b2) by SA1PR04CA0011.outlook.office365.com
 (2603:10b6:806:2ce::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Mon, 11 Nov 2024 05:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 05:17:28 +0000
Received: from [10.136.47.222] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Nov
 2024 23:17:23 -0600
Message-ID: <cc8831c7-8ea2-0ee7-061f-73352d7832ad@amd.com>
Date: Mon, 11 Nov 2024 10:47:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Very high scheduling delay with plenty of idle CPUs
Content-Language: en-US
To: Saravana Kannan <saravanak@google.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Benjamin
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	<wuyun.abel@bytedance.com>, <youssefesmat@chromium.org>, Thomas Gleixner
	<tglx@linutronix.de>, <efault@gmx.de>, John Stultz <jstultz@google.com>,
	Vincent Palomares <paillon@google.com>, Tobias Huschle
	<huschle@linux.ibm.com>
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <20241108083133.GD38786@noisy.programming.kicks-ass.net>
 <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 9daea93a-1b1c-4b10-00f3-08dd02102319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0Y2d1BQTUV6QlQ5OGNMNlkrUm1iZEJQQ25QNHJsRkprZWYyL1RlcWgwczRG?=
 =?utf-8?B?NTBybmJHY3VIUXV0QkNaSFRqU1hvbmR1cWk1TmpiSXRoS0hyNG9HSW5HUmYx?=
 =?utf-8?B?RVF5eWVoRXk0SWcrU2VrUE42ODArWE9sZVhvMHcycDhiVVhrS2xxZnd1NXZT?=
 =?utf-8?B?dTZXZzVzRUZmcjV1UXpxLytnT2RlYktZQzl2c1lMZkw3dXZDaFZnZFRwS3k5?=
 =?utf-8?B?MURETlpVempKdzRURkZhanlTM3lNU2FQWW5KbkRCdC80eXVYTEM0cktmMHJX?=
 =?utf-8?B?QW1RV2tpdFV3TXRMeTJtNm9MMXJVaDNKK204ZmxMcXdhWWtmOUpnKytkRW8x?=
 =?utf-8?B?SHE1bis2cmE5ZjB6Y1htVytlc0hDbkFjR0tUSk1kaHpBaDNlNlo5K2RDUitD?=
 =?utf-8?B?b21QcTRoZVhVZ0FMMGFWRXhCOStYaDFqcjRxQ20zOGJpdFcrelY0cEdObjgr?=
 =?utf-8?B?bzRvSHBDVzh2OVF1Z1VwUlpRMU5YYzJRbDFlY2MyZjFRVVNxM2w2WUJUVkdr?=
 =?utf-8?B?Vkc0ZDJqSFVMVFg4U0RhUEVyUURkQ0NwNFROUldIMitrb015LzNuYnNmZmU0?=
 =?utf-8?B?TTAyRXFMeFBxYmV6TXJRRTA5OTQ1ZWZxc29rczhJR3Z6L1ZUZmYwU3ZvaWhh?=
 =?utf-8?B?SVczeWIxaDdQRGJITUV6bkZSbWFza3h0RUd3UzArckpSdUJVbmkvR2xtamZ2?=
 =?utf-8?B?YW5wQkZkaU0yZFUwMGxNMWNJWmpDSEJiNVBXTEdBd0xSN2NaQ3JtcXRkcnFQ?=
 =?utf-8?B?VlQ3SkRIemFyakFHQkcvZnVWQnhGbTNVdW11QUdWdUU0b3M0OWxOaVZ5Y0c0?=
 =?utf-8?B?TVhFVlNVTkZaM2xjL29OdC9LWDVOQ1YwYWNKaVI4TmlHbGZPRnJ3RnZ2NEFw?=
 =?utf-8?B?QUh4NGJSamdOa2hRWXkyWTRGSkxRL0V4c25TSWJMVUFReWFJL290S0J2Mi9C?=
 =?utf-8?B?YThhYUxvdVlnZ3krcm84ajlSbjJPbVZJcFZEK2FkM1BMbXhlTHZublptNHlK?=
 =?utf-8?B?VDNPbTAvbmJrb0Z5T1gvMWRCSkZwcXpmY0ZKd1lBT1pyMUE4d1p4c0xEYWJO?=
 =?utf-8?B?UEJVRDRjZU9rN0poU29wY3NoYnRaUE4rdWxIU2ZjZVZ6bitFT241a1JIdHRE?=
 =?utf-8?B?dUt5U095SkFTaERvcnlEWjZUVlhkYlBPNlY3c2hMbUt1ajhTVWpveDREYmZC?=
 =?utf-8?B?R0RSSWEvcURjMEdmYytxTnU1T1BLb0o4TTZKN3lYRHQ3YVJUYWpFb3VoWHBn?=
 =?utf-8?B?SnJqN21MQnpQRjNNTXQ3QVFjODNnb0JPd2I3cWluTWlmUVBPU0pkV053S05X?=
 =?utf-8?B?amlEY0luRDNaSlhrNC9hdFpIWGxtTFI3dGNDM1c1eHZkWndZVUs5OVJWZ0hC?=
 =?utf-8?B?M2tBUzFwRldYaDgyTER4aWJGRjhkbEVyT1pMcXV2cGt1bTYxU3EvcGJwYUov?=
 =?utf-8?B?bk4yTm04amZaY3h4RXpyMWczcjNuT21leEJ4dzljM3BtanpDb0ZjaU0rYllj?=
 =?utf-8?B?ZGdGbjBJVDBqbngrUEd3N0Fhd2RESUJibS9OcTk0MVlTTzZET0ZDd0Y1RjJ0?=
 =?utf-8?B?S0MrZisvdHVJL09ZTDBtNnM1dXV3OWRtdVk2V0lTajRYb24wbXNIK3NTZXd5?=
 =?utf-8?B?RThYZUJtWEpReHFoM0tmSVRBUGFpRm5SMzNKQ2QxRXlmOVhCWUg5R0xRcG9K?=
 =?utf-8?B?UXQ1OWU5UzZweVJvTW1IOWp6elNlRHh2MkYwdWRQVHVGREVUck10U1JRWXY4?=
 =?utf-8?B?dHpXTTNFUUV5VUhTeEJaT2dCVXN5N09OS0RqV2gxZHd0dEZlVFEvY011WUpW?=
 =?utf-8?B?aEFwME9qMStTdkJieUdRcFN0SC9QUVAvMmI5b3dHZXVOV0RLZ2VOeDlHc3Fn?=
 =?utf-8?B?RkR0Qzl0QzRjU0s0QWpJUWxnUUdCTTgwWTMzL3cxS3g1bWZaNnJTeTQxdVFE?=
 =?utf-8?Q?9QQKQmY1/eM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 05:17:28.7114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daea93a-1b1c-4b10-00f3-08dd02102319
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780

(+ Tobias)

Hello Saravana,

On 11/10/2024 11:19 AM, Saravana Kannan wrote:
> On Fri, Nov 8, 2024 at 12:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Thu, Nov 07, 2024 at 11:28:07PM -0800, Saravana Kannan wrote:
>>> Hi scheduler folks,
>>>
>>> I'm running into some weird scheduling issues when testing non-sched
>>> changes on a Pixel 6 that's running close to 6.12-rc5. I'm not sure if
>>> this is an issue in earlier kernel versions or not.
>>>
>>
>> It's a bit unfortunate you don't have a known good kernel there. Anyway,
>> one thing that recently came up is that DELAY_DEQUEUE can cause some
>> delays, specifically it can inhibit wakeup migration.
> 
> I disabled DELAY_DEQUEUE and I'm still seeing preemptions or
> scheduling latency (after wakeup)

On the scheduling latency front, have you tried running with
RUN_TO_PARITY and/or PLACE_LAG disabled. If the tick granularity on your
system is less that the "base_slice_ns", disabling RUN_TO_PARITY can
help switch to a newly woken up task slightly faster. Disabling
PLACE_LAG makes sure the newly woken task is always eligible for
selection. However, both come with the added disadvantage of a sharp
increase in the number of involuntary context switches for some of the
scenarios we have tested. There is a separate thread from Cristian
making a case to toggle these features via sysfs and keep them disabled
by default [0]

[0] https://lore.kernel.org/lkml/20241017052000.99200-1-cpru@amazon.com/

> when there are plenty of CPUs even
> within the same cluster/frequency domain.

I'm not aware of any recent EAS specific changes that could have led to
larger scheduling latencies in the recent times but Tobias had reported
a similar increase in kworker scheduling latency when EEVDF was first
introduced in a different context [1]. I'm not sure if he is still
observing the same behavior on the current upstream but would it be
possible to check if you can see the large scheduling latency only
starting with v6.6 (when EEVDF was introduced) and not on v6.5
(ran with older CFS logic). I'm also assuming the system / benchmark
does change the default scheduler related debug tunables, some of which
went away in v6.6

[1] https://lore.kernel.org/lkml/c7b38bc27cc2c480f0c5383366416455@linux.ibm.com/

> 
> Can we tell the scheduler to just spread out all the tasks during
> suspend/resume? Doesn't make a lot of sense to try and save power
> during a suspend/resume. It's almost always cheaper/better to do those
> quickly.

That would increase the resume latency right since each runnable task
needs to go through a full idle CPU selection cycle? Isn't time a
consideration / concern in the resume path? Unless we go through the
slow path, it is very likely we'll end up making the same task
placement decisions again?

> 
> -Saravana
> 
> 
> -Saravana
> 
>>
>> You can either test with that feature turned off, or apply something
>> like the following patch:
>>
>>    https://lkml.kernel.org/r/20241106135346.GL24862@noisy.programming.kicks-ass.net

-- 
Thanks and Regards,
Prateek

