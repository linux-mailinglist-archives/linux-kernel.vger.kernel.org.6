Return-Path: <linux-kernel+bounces-350778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BF799099B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D36B23498
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545331CACDE;
	Fri,  4 Oct 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xsfyUzpH"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5551E3798
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060251; cv=fail; b=frFiaK4bG0usnEr+B1qU55aZZEs1/dZxBp74a2a5DMBoKMOP3rrA2Shbo3TVCse+lDFIYnljjf5ZhOap4ahNWwxKzLfkPvs8dy7o2mMuRrbwLWdfucDdHYyDAuTvjrDueFgXnPY1QVX/cy3KgUMPQljiUoNPlEIPTSIaDu8A2QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060251; c=relaxed/simple;
	bh=WD608dapVb+GET3H4owOdTcrXChs6BcoyDtirnO6yYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tclEZSH1ZKw/KULIamsFQ9Sb25nI7LdYbc++PwWlHcoyReSc5r3QBNDUwaiB+EWZ4oi0DhnlaEcZNzzr7HPTwXJDSW+n6sMHxOZQXMUL9foByIgFmsKyubOyPU1pUp/4tMV9WXDYkfjFLob2Ulhwk/EJmKTbdun2IM+EbmDf7IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xsfyUzpH; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q13E89Jp1MaG1a+osi6chpjpOwAnYyV5AxttZJorGkxMEJdMDxNCbD/53v8KjCx3QpZrkmrk1gJ4dZ70AWzJq/RnKROuTOEEAPjRAmBS+80OLks/5fRddJbZOaZF2Lw39R0TWPiiSq+9SOT37seB5kirtEZrq5nFUTgd0+7xLyGUquxnYuhRzGrGc7YrQvPbQw7Wyg6Oe8DGrKqFxvdGeumcWN2YoySQhkLZGrPCXq9MBhcyH4vAcJt2qjlHFdgQYGaKKeiyBhogfPde7qdjQ+69GcWsOfUMcYmM67eRjHZiPiV5QSDiTmPiYEyzYn4cd7NwIF7xlfHa72Na9doU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRjSf5L6rI3cNrfC/cy53o9/oAu/3AIZ8RlD9BtwoQU=;
 b=q25NZ4dVGh3cEK/wM7SrmpmwFJiP24UZzIReVq4RgDNuymiQuH7GF/CTVKTPLBWZm6Xe5wQ492TQzgeQ1S4si+u4R6/lucIaew+O3Cd0IyGm8GAKKZ5L4PYNWqAM3wbk0h5cDCsIP4SjvmGmNsW2PaDKdO4m5T9fy1dDKLUL8xARA/yg63g7hRl8GAytH+aXUrLzsADxOyrAe2pbmKGtKBB0rz9HSrJGLctFuM8NdvuEnm0jYr4SuMUXcJWHZWtn/SREuP9jSXXaLwwXjycluReiqSwAbrG25wAJg+1zQ8SV1BuqNVnkIl/KRt5GLu8UDEMRq+TxdSJiHo8/Cde1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=cmpxchg.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRjSf5L6rI3cNrfC/cy53o9/oAu/3AIZ8RlD9BtwoQU=;
 b=xsfyUzpH8ff0ae5WBCGGa5QnFpOBY+v7b2ZC2ppmWUmQUvhMLyMbrHWSCp3hIozfWpAPqa1P1C4B2xBFJ/74dQ0jfAIEn3Zn4ETKo8AY00r2BgaG4hYfaSmXHrhCTcwe9D76sftC6Gs2p6bMBp7lWGEUJ8V87Lg2qLdxH8nxM/o=
Received: from BN0PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:e8::13)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 16:44:04 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::3b) by BN0PR04CA0038.outlook.office365.com
 (2603:10b6:408:e8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 16:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 16:44:04 +0000
Received: from [10.252.216.179] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 11:43:58 -0500
Message-ID: <fae14e09-cd35-5feb-c3b4-8318a76b26a3@amd.com>
Date: Fri, 4 Oct 2024 22:13:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [REGRESSION] Re: [PATCH 17/24] sched/fair: Implement delayed
 dequeue
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: Klaus Kudielka <klaus.kudielka@gmail.com>, Chris Bainbridge
	<chris.bainbridge@gmail.com>, <linux-kernel@vger.kernel.org>,
	<bsegall@google.com>, <dietmar.eggemann@arm.com>, <efault@gmx.de>,
	<juri.lelli@redhat.com>, <mgorman@suse.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <tglx@linutronix.de>, <vincent.guittot@linaro.org>,
	<vschneid@redhat.com>, <wuyun.abel@bytedance.com>,
	<youssefesmat@chromium.org>, <spasswolf@web.de>,
	<regressions@lists.linux.dev>, "Linux regression tracking (Thorsten
 Leemhuis)" <regressions@leemhuis.info>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>
References: <20240830123458.3557-1-spasswolf@web.de>
 <ZvA7n9GNoD-ipjkj@debian.local>
 <1ee5f5828e2021bf1051dc1f9b6f01a8c061ffb1.camel@gmail.com>
 <2128d714-90f7-1598-b32b-559206fce5de@amd.com>
 <20241004123506.GR18071@noisy.programming.kicks-ass.net>
 <20241004135744.GB1658449@cmpxchg.org>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20241004135744.GB1658449@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ac3a30-58ed-49a4-9f7f-08dce493c1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDZxY2VHdUtLTjBLRXZDNDJVQkk0aHlNTFZnYkw1Z2k0NHBnYUZFaThPQWty?=
 =?utf-8?B?Y2NuZFhydGhvallTd29UZmI1TlVSMHhtbGV5ekxuMzFkUHJTY01Ja2FEOHNh?=
 =?utf-8?B?elVLS1BTeS9uQ2pkazV1aTVhT0ROS0dQUTRhdzVnaWNrOUJ4R05ERXpSV0lh?=
 =?utf-8?B?WU9leW0xbVhSakdTOVVhbnpabGo4UnlkenVMOXNwSHFrRXFMdXowdC9pQ0th?=
 =?utf-8?B?aDNnTHZuUlZqSmx4b2EyRm1yQXIzYVBLYmloWU1zT1Z0UVhXdWU4RHY2aGpa?=
 =?utf-8?B?MFlTaFdFZ0NtbG5BTEtqbkVTbzNoR3hTazJoNnFaNFdIVkxVS2Y5MmM1aTA1?=
 =?utf-8?B?QnN3ODFzMFhXU2lSaHAwclAzMnRvcnhMRUpkd2JnYnQwSlpEUis2ODlOeUVq?=
 =?utf-8?B?WkZhUXQ3dStMTytScFF4d3RQcmsrYUxpdS82VjZyakhkSy9aSXJUUmI0cUNE?=
 =?utf-8?B?dSsreTNUWXVUZ1BiaXU3MVdIZkVyUTUwNmNNaXBxOVN2S0FkR0NjQ3BobHJK?=
 =?utf-8?B?Und5dm1KMlhnbU1ZU2xFWGlYdm9ZamRGNjRlMFJXODlPMTVrb1pxMzVpc3lI?=
 =?utf-8?B?SGtKM3k2TUtic3VhVCtMbUw3ck93eEVjTVF1dHhjaVM2dGVPUTBhTWdDWkVw?=
 =?utf-8?B?ZjVDZ094WG9ncjFhMUdQbmRyNFNnVlBhVndsdGhDRUxlTW5jK25WUzFZQ0tK?=
 =?utf-8?B?TjBtN2FEVFJmL0p1WVJnelAraDBJdVVVWUd2RXpOMXN4STVYbllFdmtVeVBC?=
 =?utf-8?B?aFZCeHh2cWp5U1hJUGg2NUhqR3JOSlp1cEhGYW5XTHFqdEUxNkhXSVdWeUNj?=
 =?utf-8?B?SUVKZmpObFFaZVJobEVYcmhTOGJHLzAxZFkzR3JkK09CcE5aUTlXQURoTVRa?=
 =?utf-8?B?S3JaamRQbVYvdU1EWFJzeGZLdWtaM2Z5UTJBTkRvRS90Tzg4a1p6Z2JyaGNS?=
 =?utf-8?B?ZUpzRUZJWVFqbVVKNnV5MzJVUy9MeTJGdGg0Qk5IV1NOaXFVZDdPNG9KcWMr?=
 =?utf-8?B?TkhNcHE5RkRNWFdDS2VZQ2VFTlB1RXA4T0ZoMlBjcmNLbFRoQlhmZVFqN0JF?=
 =?utf-8?B?SXVXR0tNd2ZXcUJqUi84RXNRVlFwUEFNQ2V2Q3dIU3phZlIvektzMlEzV0hS?=
 =?utf-8?B?dzhYNHJScFROdUgzVkNvZ2dlSzJBYkF4bS9GUzlCcWYwNHMzaXhpM3F5dVVl?=
 =?utf-8?B?TS9neUwwakI0VVJHQkRzQThsSnpSZ1ZyZXgvNTYxOW44c09DWlNEMHlDSnJl?=
 =?utf-8?B?WENZdkpxUUhKK1lPN0JyVFN1dnZRd1RNY2xqN3djQ0FOZlU0djZYclZVZFV3?=
 =?utf-8?B?b0twTnlqOWJpbGVxMHBvZ3N6UDc2d3hBQlppZWFXVVEzL1ZlelJJRjl2RjRz?=
 =?utf-8?B?T1dwWVNYeXFNT0VpS3NiVUlZM29Fb2c0L2JIc2lXM3JDeFdIYTZiMkZTVXdF?=
 =?utf-8?B?STZOSnk1cXJiUTc1czJxcnhvNEVEQUhLQU1EeVJRSy9NblliTFNOUXh5M2ZU?=
 =?utf-8?B?b0RnT21qSEZaQXNJT3RpOGpDUFFSNmluQ0RBWlg1TmdQNVhod3FSS2NLQ1Fp?=
 =?utf-8?B?SUtGQkdXeUVFeWZ2TDBFTHFDVnkxb05GNTR3VVBXL1Y2QlN2TXFnRkdKM1VK?=
 =?utf-8?B?dFdLeXBpUzZMNnJ3OHNWSVRSQWp0eC9LdGVEVG1ONzRGNHRwOWVFc05wejRt?=
 =?utf-8?B?ZldyNnhNU0ZPbFBDMHlNVWtJWkN5Y3ZDb0FDbkR6U0h2MmhGSHl1cERVM0Vq?=
 =?utf-8?B?TVE1eXhZMXdYU2xjMG11UytBNUVpdHRxdmZybEMwWXFFWHFJVkEwd0FyMlVW?=
 =?utf-8?B?ZFZENWwrVWpaYzNsNXVkNnI4VWNEZUo1M3ZyVy84YmpZclgxd25KYVQyUlFJ?=
 =?utf-8?Q?sJbum/U5RUNpw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 16:44:04.3035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ac3a30-58ed-49a4-9f7f-08dce493c1e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485

Hello Johannes, Peter,

On 10/4/2024 7:27 PM, Johannes Weiner wrote:
> On Fri, Oct 04, 2024 at 02:35:06PM +0200, Peter Zijlstra wrote:
>> On Fri, Oct 04, 2024 at 04:40:08PM +0530, K Prateek Nayak wrote:
>>> Hello folks,
>>>
>>> On 10/3/2024 11:01 AM, Klaus Kudielka wrote:
>>>> On Sun, 2024-09-22 at 16:45 +0100, Chris Bainbridge wrote:
>>>>> On Fri, Aug 30, 2024 at 02:34:56PM +0200, Bert Karwatzki wrote:
>>>>>> Since linux next-20240820 the following messages appears when booting:
>>>>>>
>>>>>> [    T1] smp: Bringing up secondary CPUs ...
>>>>>> [    T1] smpboot: x86: Booting SMP configuration:
>>>>>> [    T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #12 #14  #1
>>>>>> This is the line I'm concerend about:
>>>>>> [    T1] psi: inconsistent task state! task=61:cpuhp/3 cpu=0 psi_flags=4 clear=0 set=4
>>>>>> [    T1]   #3  #5  #7  #9 #11 #13 #15
>>>>>> [    T1] Spectre V2 : Update user space SMT mitigation: STIBP always-on
>>>>>> [    T1] smp: Brought up 1 node, 16 CPUs
>>>>>> [    T1] smpboot: Total of 16 processors activated (102216.16 BogoMIPS)
>>>>>>
>>>>>> I bisected this to commit 152e11f6df29 ("sched/fair: Implement delayed dequeue").
>>>>>> Is this normal or is this something I should worry about?
>>>>>>
>>>>>> Bert Karwatzki
>>>>>
>>>>> I am also getting a similar error on boot, and bisected it to the same commit:
>>>>>
>>>>> [    0.342931] psi: inconsistent task state! task=15:rcu_tasks_trace cpu=0 psi_flags=4 clear=0 set=4
>>>>>
>>>>> #regzbot introduced: 152e11f6df293e816a6a37c69757033cdc72667d
>>>>
>>>> Just another data point, while booting 6.12-rc1 on a Turris Omnia:
>>>>
>>>> [    0.000000] Linux version 6.12.0-rc1 (XXX) (arm-linux-gnueabihf-gcc (Debian 14.2.0-1) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #1 SMP Thu Oct  3 06:59:25 CEST 2024
>>>> [    0.000000] CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7), cr=10c5387d
>>>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
>>>> [    0.000000] OF: fdt: Machine model: Turris Omnia
>>>> ...
>>>> [    0.000867] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>>>> [    0.000876] psi: inconsistent task state! task=2:kthreadd cpu=0 psi_flags=4 clear=0 set=4
>>>>
>>>
>>> Not sure if someone took a stab at this but I haven't seen the "psi:
>>
>> I'm aware of the issue, but since it's just statistics and not
>> anything 'important', I've been spending my time on those crashing bugs.
>>
>>> inconsistent task state" warning with the below diff. I'm not sure if my
>>> approach is right which if why I'm pasting the diff before sending out
>>> an official series. Any comments or testing is greatly appreciated.
> 
> This fixes the bug for me.

Thank you for testing :)

> 
>> Anyway, assuming PSI wants to preserve current semantics, does something
>> like the below work?
> 
> This doesn't. But it's a different corruption now:
> 
> [    2.298408] psi: inconsistent task state! task=24:cpuhp/1 cpu=1 psi_flags=10 clear=14 set=0

I hit the same log (clear 14, set 0) and I tried the below changes on
top of Peter's diff:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d766fb9fbc4..9cf3d4359994 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2012,9 +2012,10 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
  	if (!(flags & ENQUEUE_NOCLOCK))
  		update_rq_clock(rq);
  
-	if (!(flags & ENQUEUE_RESTORE) && !p->se.sched_delayed) {
+	if (!(flags & ENQUEUE_RESTORE) && (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))) {
  		sched_info_enqueue(rq, p);
-		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
+		psi_enqueue(p, ((flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)) ||
+			       (flags & ENQUEUE_DELAYED));
  	}
  
  	p->sched_class->enqueue_task(rq, p, flags);
--

... but it just changes the warning to:

     psi: task underflow! cpu=65 t=0 tasks=[0 0 0 0] clear=1 set=4
     psi: task underflow! cpu=31 t=0 tasks=[0 0 1 0] clear=1 set=0

Doing a dump_stack(), I see it come from psi_enqueue() and
psi_ttwu_dequeue() and I see "clear=1" as the common theme. I've
stared at it for a while but I'm at a loss currently. If something
jumps out, I'll update here.

Thank you again both for taking a look.

-- 
Thanks and Regards,
Prateek

> 
> It's psi_sched_switch(.sleep=true) trying to clear the running state
> and the queued state, but finds only the running state set.
> 
> I don't think it's an erroneous dequeue. __schedule() has that
> block_task() dequeue before the switch, but the DEQUEUE_SLEEP makes it
> a no-op and leaves the combined update to psi_sched_switch().
> 
> It looks instead it's missing an enqueue callback. This triggers:
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 020d58967d4e..09a251e3986d 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -922,6 +922,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>   	u64 now = cpu_clock(cpu);
>   
>   	if (next->pid) {
> +		WARN_ON_ONCE(!(next->psi_flags & TSK_RUNNING));
> +
>   		psi_flags_change(next, 0, TSK_ONCPU);
>   		/*
>   		 * Set TSK_ONCPU on @next's cgroups. If @next shares any
> 
>> ---
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 43e453ab7e20..0d766fb9fbc4 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2012,7 +2012,7 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>>   	if (!(flags & ENQUEUE_NOCLOCK))
>>   		update_rq_clock(rq);
>>   
>> -	if (!(flags & ENQUEUE_RESTORE)) {
>> +	if (!(flags & ENQUEUE_RESTORE) && !p->se.sched_delayed) {
>>   		sched_info_enqueue(rq, p);
>>   		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
>>   	}
> 
> ... we must be skipping here when we shouldn't.
> 
> I tried moving it past ->enqueue_task(), like we did for uclamp, to
> get the enqueue when sched_delayed is cleared by the callback and task
> is considered properly queued again. However, that results in yet
> another problem:
> 
> [    4.624776] psi: inconsistent task state! task=161:systemd-ssh-gen cpu=1 psi_flags=15 clear=14 set=1
> 
> This is a psi_sched_switch() trying to clear running|queued and set
> iowait. Task is already running|queued|iowait. It looks like we had a
> genuine wakeup that was signaled with psi_enqueue(.wakeup=false) (so
> it didn't clear the iowait).
> 
>> @@ -2039,7 +2039,7 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>>   	if (!(flags & DEQUEUE_NOCLOCK))
>>   		update_rq_clock(rq);
>>   
>> -	if (!(flags & DEQUEUE_SAVE)) {
>> +	if (!(flags & DEQUEUE_SAVE) && !p->se.sched_delayed) {
>>   		sched_info_dequeue(rq, p);
>>   		psi_dequeue(p, flags & DEQUEUE_SLEEP);
>>   	}
>> @@ -6537,6 +6537,7 @@ static void __sched notrace __schedule(int sched_mode)
>>   	 * as a preemption by schedule_debug() and RCU.
>>   	 */
>>   	bool preempt = sched_mode > SM_NONE;
>> +	bool block = false;
>>   	unsigned long *switch_count;
>>   	unsigned long prev_state;
>>   	struct rq_flags rf;
>> @@ -6622,6 +6623,7 @@ static void __sched notrace __schedule(int sched_mode)
>>   			 * After this, schedule() must not care about p->state any more.
>>   			 */
>>   			block_task(rq, prev, flags);
>> +			block = true;
>>   		}
>>   		switch_count = &prev->nvcsw;
>>   	}
>> @@ -6667,7 +6669,7 @@ static void __sched notrace __schedule(int sched_mode)
>>   
>>   		migrate_disable_switch(rq, prev);
>>   		psi_account_irqtime(rq, prev, next);
>> -		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
>> +		psi_sched_switch(prev, next, block);
>>   
>>   		trace_sched_switch(preempt, prev, next, prev_state);

