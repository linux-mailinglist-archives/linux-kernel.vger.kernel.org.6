Return-Path: <linux-kernel+bounces-365040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEBC99DC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A72BCB21F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C5E16E89B;
	Tue, 15 Oct 2024 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aN4FeQeF"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046220EB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728961908; cv=fail; b=aE1S1btINcu7bktncY7xjEVKNjSgN68ZhhL/OEGISQQ3SKa2f26Wu6P5tDnS7uAyhklr8ASpDlnyFEAXosZ4IinDRuZEN9hNl8n6C2nEzeoGMSQPgfRb83Se3r7v8oISgTEGfSB6rbZzneIWMwPBcpQkWQ+V9Nlf3rkmVbPoBRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728961908; c=relaxed/simple;
	bh=tVTLWzubpqS97ll49bE/7IMSvGK76UNRWMaBQSBfce8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b6cMvHD1vul8lmt4pVAmCtN5O3p3AdquRKXXGjFpQvCCbzPMVX8qqAl9x1kLu4ZiSyGQjjRrtZ5tHNwbZYUtcPAm+XSn80nMJ3jj8KTh67MDVnGd63VMRz6yQxN1dW1tChu36KYUvhh1If2HaStYQqxYu3A7AtsXpbS6CQHWI1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aN4FeQeF; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jF2vMquQnbdVfMUXT5MHY9ZVf6yE4ETcMftvM3GfFUE5yMPrYDLtr8eLIyBZNxGik+iJV9gu5e0b9x4TTWbnaqcw5gr9LkQEgIeo9D+NhnfhlVUodGRokPkmwiw1OuVTC8T1YOajHBQ0M3IiM9ZwtDOOu+OkJEniS86l/wp+nyx7rndyh+jg7g82f6q9N9uhIgGMdu9XvZmZNXh8I1G676sb3UKndewBfrmxwaOKaj2dLsxzgxnH4JQJS0A7kdooo8RRlBGrE4aBSfmXnHUwthIOpy1OZmdtBmONe511jXLUVybN73Dtqbg3Z2Wpim7PTS+V5GgYzyjulFfrCAMO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7Ruk5P45/oJwnlgqwBxa7KHVFPS68nl+9FOdXZ8vbc=;
 b=gIgNaT94lnYRl241jlxwtuW4D+2V40xMJUCLz025Jcyr1ZceMA4mjBnN71pigTVC1OiRdZ6L0YfZZPLqHH0K7kP4wKezmqvLaA9KmrUWc1mElgZJYscaxwclwHJ817A7wGJUe/A3vRhxlX1dcS62FTOGztFAE7fzRN28vGMqQwVnfbTonQLAfh6Q47vnc2VMYrHpY5Xs4Rj/guL5EmxwMbySdfFHZNIndP14mTCwzGYO5SkQSRpa9BAfxITckuKQl72HNYU+U8DFzXIQznjlTXIk3B0cQjRddOJj4+d3D41VGGkhQRCkP30msl6iM0qLXsdndv76189hmmR0BsKGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=cmpxchg.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7Ruk5P45/oJwnlgqwBxa7KHVFPS68nl+9FOdXZ8vbc=;
 b=aN4FeQeFvZbRknG/cfmvtOmVkTYxcP+Ad3LjDAsPZ0YCYceL5XZWymtjcEdwkHdTDIcaS8ZVqFFHOz4DupOnrKMPEGasPWXRglpxwBP+z4iWRxNi4Yk9/HL0CEgGosmHTi+EC34+q3nIocI3r4b7BMP9Qcxpfi1MG/c+a3aN8bk=
Received: from BN0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:408:141::8)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 03:11:42 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::ea) by BN0PR07CA0009.outlook.office365.com
 (2603:10b6:408:141::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 03:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 03:11:42 +0000
Received: from [10.136.43.96] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 22:11:34 -0500
Message-ID: <2b211cf7-4800-564d-d39c-8013081afee0@amd.com>
Date: Tue, 15 Oct 2024 08:41:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/3] sched/core: Indicate a sched_delayed task was
 migrated before wakeup
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Suren Baghdasaryan
	<surenb@google.com>, <linux-kernel@vger.kernel.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Klaus Kudielka
	<klaus.kudielka@gmail.com>, Chris Bainbridge <chris.bainbridge@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Youssef Esmat
	<youssefesmat@google.com>, Paul Menzel <pmenzel@molgen.mpg.de>, "Bert
 Karwatzki" <spasswolf@web.de>, <regressions@lists.linux.dev>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
 <20241010082838.2474-4-kprateek.nayak@amd.com>
 <20241010130316.GA181795@cmpxchg.org>
 <20241010130621.GH17263@noisy.programming.kicks-ass.net>
 <20241010193712.GC181795@cmpxchg.org>
 <20241011083323.GL17263@noisy.programming.kicks-ass.net>
 <20241011100803.GA331616@cmpxchg.org>
 <20241011103958.GO17263@noisy.programming.kicks-ass.net>
 <20241014144358.GB1021@cmpxchg.org>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241014144358.GB1021@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: a7eee668-4948-429b-c887-08dcecc7181d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|30052699003|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXVNeGRvQThkajdVdlFBT1cvd2xGdGRKYkc3SXpoSTRiRk14NHVkVnM1VzIr?=
 =?utf-8?B?Z3FpbmNOdkhXZnFMU3Z0N3FLMHF6cjZNLzQrSGFoMWVNQ1ZkalhMU1BwQjRO?=
 =?utf-8?B?MFNHYlFNOVcyUjFsYXJNc3F1WVArUHU1Z2x4LzJkVVhGaG54T0t4OWZKdkw3?=
 =?utf-8?B?aDh4SkxTNU1JM0YvQVdPM0xRUmRTWkdvT21EVXhRVU8xTUZ5VXcrK2RGSWhY?=
 =?utf-8?B?VmNKRlZaSlVqMHBKWWtNajJxNFU1aUc0S0FIdGxKcFR6bWpBVHk1S054TE1y?=
 =?utf-8?B?Y0RoUE95dGhodG5mTHNUdE9YaThPOE9iWmJBdUx2NzV2MUZmWlc4NmJTeHBS?=
 =?utf-8?B?ZkJ3TWZNL0JaQTF1OFJ6SUpvcWJYMzVRZW1WZ3UvcTNNUURUdHBxUlJoWUda?=
 =?utf-8?B?Q0Q5LzhWQ0VhRDhWRU1QODQ2WEV0Vzkwd3JQMXB5M2ZnZWZJeHBMdlQrRDBW?=
 =?utf-8?B?UW0yWFQ0OEp4UEpiUm4zZmNNYmlkL2w3b3BHMkIzTlFCNE5UTUp0TTRHTk45?=
 =?utf-8?B?blM0OCs0T0pXczFweENRM0VueDFIQlJ3SkVkUC9XQjBlazMrLzdYaGlhRGdj?=
 =?utf-8?B?UGJxVVdQRE1WWWIvTEJBMVZsY1NPSnoxZDZLVkxDTEZ4YTJVSG9HbFVZdkFm?=
 =?utf-8?B?Rkloa2VqNWdmTU9pekJYeXl6cUF4ejFMTkl3YlQzaG1qK1BzRlFRNGY2Y1Zr?=
 =?utf-8?B?Y0hPa2ZBMkJ3MkxOZlZMNkFZdEZYV2VHaVRzMDFkQmV3VWhyYlVEaE1YRVd2?=
 =?utf-8?B?Smo2TmU4WjdhOGpwZmJHRExoL084WVVZK0NCT2x2SXVNVlVoaHBELzE4YWVh?=
 =?utf-8?B?RlpRSUdFR1dtdFRVbklvRVQrOHNSZjMxOFRyMGZUa1RlQXl5eEVvOGZqL0NQ?=
 =?utf-8?B?bFNVdlJQd3J6UHlBL042VzJQTXVUTVRBM2gzTUxMOCt2dHRodmhnWkRxQkpV?=
 =?utf-8?B?YmdQbzBrc04xa0xhUVhIcnNZeFIxMlB4eFQvZVdOV25EcytseHNpQXBUR0d6?=
 =?utf-8?B?NGM3SUpjTU5OSTJteHBGWTdHcmdWUk14K3IwZ0VzZFdYaVRPb3Fad2JJdnJX?=
 =?utf-8?B?WFgxVmQ2RHo1QnA5bTVmUG5XOFl4bkhUT2ZEbTFQNnFORUxGMHpIOEoxdXYr?=
 =?utf-8?B?WCtTL1BOYnlkeHp3eDhiOGxXUUYwVDdNRklVV3Fsd0NCRDNqVVl3aDAzRHBB?=
 =?utf-8?B?SXRKakM2VWQrSEJLbFN4dHRsWHRQZHBXV2x4RDNyem5EUyt0NFdYRnFyZVNC?=
 =?utf-8?B?S3cydS9jWVZWZW5reE9tT0grY1k1eUNsSXE3QzI1NjhVRjNUYXU2Nms2Y084?=
 =?utf-8?B?clozU0VUR0M4OFU2d1BwWUNDR3cvSUNFVnBsR1RQY1NzZ3B5U3JxWERuSTJv?=
 =?utf-8?B?b01vNVVHamd1VmFzUit3WUtRclNDd3duWVNRL1ViWW1sZlB1aWovc3NGTXJZ?=
 =?utf-8?B?VmMvM0NVODdwNktqcUxtdG5QdTNHT2svZFBoRVV4TThRUU5KYjE3elEvRitI?=
 =?utf-8?B?K3ROSE9sMFhBVitCMENJV0Y1d1FkS3hzRlh0eGxqYllESG1wclE3bWN6NUd6?=
 =?utf-8?B?eHlyR1BKVTNpOStwN0hHbXZFbTR2SWc0RytvTmtuYjQvQVFhY2lwZ295MmxW?=
 =?utf-8?B?OVJ5VDByeTNBSTI4TlBQM0dOYXRYUHBEMnl3RC9uTElpMnA5bGQyeXk2MmVq?=
 =?utf-8?B?d0c3MXNtWWRFa3RzcS9ubUtaZ1dKQzkyYUFmbFhTVnA2VDdGd3lsS20xUm9B?=
 =?utf-8?B?VVNoeS9nSm0wdXI4c21RaUx1dk51ekNHRTc2UDlnUGMvcjdKbmJkZ09SblEr?=
 =?utf-8?B?OGF0VnhTRG1KanZwcFVBNG9yYWdlUWQrVUZCZW96MWcvOG5oZVlRVzc5MVlY?=
 =?utf-8?Q?L8N3c+jW/7/C6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(30052699003)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 03:11:42.6394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7eee668-4948-429b-c887-08dcecc7181d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531

Hello Johannes,

On 10/14/2024 8:13 PM, Johannes Weiner wrote:
> On Fri, Oct 11, 2024 at 12:39:58PM +0200, Peter Zijlstra wrote:
>> On Fri, Oct 11, 2024 at 06:08:03AM -0400, Johannes Weiner wrote:
>>> Completely untested. But if it looks good, I'll send a proper patch.
>>
>> Sure. Thanks for doing this.
> 
> Ok here goes. Built, booted and runtime-tested.
> 
> ---
> 
>  From 91f230caa0119877cb861047e1af1371bf00d908 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Fri, 11 Oct 2024 06:18:07 -0400
> Subject: [PATCH] sched: psi: pass enqueue/dequeue flags to psi callbacks
>   directly
> 
> What psi needs to do on each enqueue and dequeue has gotten more
> subtle, and the generic sched code trying to distill this into a bool
> for the callbacks is awkward.
> 
> Pass the flags directly and let psi parse them. For that to work, the
> #include "stats.h" (which has the psi callback implementations) needs
> to be below the flag definitions in "sched.h". Move that section
> further down, next to some of the other accounting stuff.
> 
> This also puts the ENQUEUE_SAVE/RESTORE branch behind the psi jump
> label, slightly reducing overhead when PSI=y but runtime disabled.
> 
> Link: https://lore.kernel.org/lkml/20241011083323.GL17263@noisy.programming.kicks-ass.net/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I tested this series on top of tip:sched/urgent at commit cd9626e9ebc7
("sched/fair: Fix external p->on_rq users") and did not observe any
splats related to PSI or otherwise. Please feel free to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> ---
>   kernel/sched/core.c  | 12 +++++-----
>   kernel/sched/sched.h | 56 ++++++++++++++++++++++----------------------
>   kernel/sched/stats.h | 29 +++++++++++++++--------
>   3 files changed, 53 insertions(+), 44 deletions(-)
> 
> [..snip..]



