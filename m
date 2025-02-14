Return-Path: <linux-kernel+bounces-514305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D32A35557
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92C516A527
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98FE1519AD;
	Fri, 14 Feb 2025 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JppgzV5u"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404948837
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739504072; cv=fail; b=b8jXGDz2YE4+xHLfw40lDAAlUva9Bo7lqQSIR+BLfp7ktMZLmkVoKx/Ll7TcebEbTS2qHUEkir0wEdl8yQxJqyEmYZIog47Qn5U8AAfnFezOF/6Xv9u6KEV19jp2m76a/7Uh9vpSDULeFb1exWHJBV6i2aOYvmTO34CWctWHiaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739504072; c=relaxed/simple;
	bh=rWZGauoLCqyxHTfmdEj7Ofq3nC+80AqPZ1Nb/Bg6u38=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EEbCO5DQe57PO5PII1HIsmNxqtBYRTmZkyypVKBk5yk1jE8qHnRAqfHaZgVKcLBOItzpnawqx6tXv2FQB0kXV1XBwl0fh24EHZ4gMQUmGRtfwJhCrCqnaRRRREdh6JTUKXy/dyHISUZvTjt71pBOUvIMy+7kD0AL5kvJFsZLnLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JppgzV5u; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHOZbzKOdwLp4mshmguGzgK73/vQ3LZBtyCUgf1L0MHFxAf4Oo/TR9G5HyaLk+1AztvBpdsE7D5T+O0LIgasMEag7THtUmTYFtEgtg78jrRjWjAeLkx6l8mqB9iC/6PDfMoqTiM7lzu9o6hN/6zxKMT3GrRgDAKRE0QF0oF7PPd/d2ryEPD1jJcWzfruCoyM4ITJNDZ0sc3vKDuTGL2BVNLj6+dgSBL4KIdwAiRGRLddPTdK3tH+Ql6rpZf9eMZuZfhJgyvEEF10NTFP2BAPlhTKhc29a33X/8hLRfFziiuItp6mPYvnlX/yiOs48HtZlb0y4h4FFzlVaTMG9jKmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRaYPIRTjWR10zTTf1ba8lM+LA5WuuaME3AQF7yIJyo=;
 b=pJe5clu/VYTgHbseIbVVFLXjMO+uuSg40ofIBSBW3Z2I7b5cYVi89FhGYaju/+3OB6xWTz68mK2KkNAtNHB7mecSLo1QcOLtH3JS/HN8Mbo1YPDZWPVfsrbhhvzTohECcPFhSkI01hoLbV8zB92CLywdNCA5VpJ3IQLsFMbzl6sO+i41MGfbMUK8QzaxSTO1NJ96n47/MY7zUpXMksk5Oh+3FMh1XssECy6AaV9BKuY20OWnlo4S0+9DTBTtNuQ3KZLIrGgjtPkbcGrpGIuMQ9qqsBmuLb3sz3HCKISGxCu9aS99Jx9llVXxkEnnQpENZAloC2M3FbmXyxYuFn9XTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRaYPIRTjWR10zTTf1ba8lM+LA5WuuaME3AQF7yIJyo=;
 b=JppgzV5uLy7kpd1tmMAmyJq1Ocojfxk43OWq9moNMdq2VUNMS6UX3h0NeHmRTFsHL8N29FZAps0ClClcFTfvMamakHmkXumSdfNNa79R40/wKCDlGMMlCL+TP1bo767/jm4gilS403aAOqLpBeGS/TQCFITSoLLNtHHT54ce4Vw=
Received: from BN9P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::33)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 03:34:23 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::14) by BN9P221CA0006.outlook.office365.com
 (2603:10b6:408:10a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 03:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 03:34:22 +0000
Received: from [10.136.34.113] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 21:34:12 -0600
Message-ID: <ce4f4f7a-6033-4354-972e-2a066f8d5190@amd.com>
Date: Fri, 14 Feb 2025 09:03:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] sched: Reduce the default slice to avoid tasks
 getting an extra tick
To: zihan zhou <15645113830zzh@gmail.com>
CC: <bsegall@google.com>, <dietmar.eggemann@arm.com>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<vschneid@redhat.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <20250208074821.11832-1-15645113830zzh@gmail.com>
 <20250208075322.13139-1-15645113830zzh@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250208075322.13139-1-15645113830zzh@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 493a7034-9b93-4439-f3ed-08dd4ca87950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHF0d09OUjRlelZySS9SeVlva0w5ZVFkZzJ5NWV0RmE4b2hyRS9ZdWxWdkMw?=
 =?utf-8?B?UUZZeDlhVDcxbDhyUmkwMFZmZm9Bd2F6RElKcnNkRk5kR1RDZGQwS2RzcVB6?=
 =?utf-8?B?ZGRFeVZzNDlHUDAvQnhvRkZhRmJ0L3N2M0F1eCtCOXU3cUJkSnZSdURuSi9X?=
 =?utf-8?B?cFF1UjB6b3E4eWhCNURyVStYdFJPSXdUUG83SEtyZnd2bGsybEU1VmVGdWRs?=
 =?utf-8?B?WFpTRzdIeTRGRzJkekVuRFhlSzZhVW9ScVM2SW0xeEx6MGd1V0FZbUFHenVk?=
 =?utf-8?B?S3B4ZjFBQytIZ3A4UFpCM3RyQTcrOUZRTTZGN2dlSVVMVTh2TC9HTTVnUXBK?=
 =?utf-8?B?TE9IVEJxUlh0UW1tYVhsUUxaRlNWdEhsZ1k2TlczeUszSmZuR25zMUZlK3lH?=
 =?utf-8?B?ZmVMM1NFUEdlRFJjdXlTWHNIRDBHcVVqemtXLzYzUm5rN2V5eDBKR205c0pn?=
 =?utf-8?B?dGdqYVQzeXFCV0RvNGVucmhGTW1ueEMzNThERGZjOXM4U0VCZCtrUEFRdThK?=
 =?utf-8?B?b0pwODZ6ZWd6M05uKzdJMUx4Z25HUG4xb3pPbDBNYXA4S3Voa0ROVWVweTYx?=
 =?utf-8?B?eS9YUjl2ZWlOdG1pQ2d4VlFLNzlnMHl5MStNeHBpc0h0NW1QQVBsbmFpaWZo?=
 =?utf-8?B?T3ZCbXJnRDM2Sm1NZFdnTk1SVTRxRlJpRmphNmVzZFlpT0NreGFSNEJlOFhu?=
 =?utf-8?B?dGtzREp3UzNkQ2VJcFQ4V1c5alVoWGt4VVZLcERTOFJaMy9sdDZWRHNZUkFs?=
 =?utf-8?B?c2xmTTRCb2pvOW5BVXhoWWR0ejNYQklwOERJMzdBMEhUOTZ4ckJXK1FYY0Jx?=
 =?utf-8?B?bzVJVWpnN3BIR05OVFJPYnBqczdPMmRIOThjWGFJbEZlUjFIZXpNL3cvWjdR?=
 =?utf-8?B?NWJ0M3hKS0NwbXhITy80VEJUeGZzZlRGTlIwY1B6Smh6N0FGWmtvN3g1dzFW?=
 =?utf-8?B?L1d4VzZsSEllOHRYMnZPTlQ1YkdvSVRTYnVJQ09rUmdISDBUbTBQSGNNUWVP?=
 =?utf-8?B?RG1oV3RBNjE0ZVFLbW5pNm9YNFNrUzhwLzdkOVlCa1l2L3lESjJ0bTlPTDBH?=
 =?utf-8?B?RGJ1bGl6NGw1UGlEMENZWElmMUpyZHdBMW1yd0xTY0wzOVRycUtIdmxkbnUy?=
 =?utf-8?B?WmxlbVlUTGp0Q2hxd2d6UE9va1A4eFpEUlV5dk5tRUxDb2NMNlArM25XQktK?=
 =?utf-8?B?S1B5emlhTnRldmZiNFZjZnFCYmp5cVhENFExZmJRcXhEWWxBWEpMdlhkc3dS?=
 =?utf-8?B?bTJuV1d0dFpjUEkxUENUa1VsUDFreDV3V0wzaG9UWTlRMm9VV0QzdlJNOTZS?=
 =?utf-8?B?TXVJZmpTSEkzQjRxYWdrUmNpbUpjRXRKRDE2SjVkSm5uSExzbUhDeUx2NmNx?=
 =?utf-8?B?K3VMTm5oV2ZSU3NHdDIwWjZBTzFmMDY1b1gxK2IyV1VYVzFYVlJqZ0FDdXdr?=
 =?utf-8?B?SDRtMk1ydmZYRXUydytneURGanUzWkswTmFBNXhCa3dBQk5UeUI3MU5wU2xK?=
 =?utf-8?B?QWZiZm1DMjEvUDhQcDIvTWQ4YWJoRG4vYjRibnRzZmFIekxGOEdzTm5yZFNq?=
 =?utf-8?B?dGp0QnBWWGszK0RYTUhFQUxyNzNjdm5laUUvZ0dFcHJ0RjNIaFRVaGkwYVFW?=
 =?utf-8?B?TFJTa2pZR0NxVUhiWGNob29XelJzS1pMejBjSFpEU0pWYjdtZG1WQllEOFRm?=
 =?utf-8?B?NVd3TjJPeWVmZkcxclBXbHYwUzF0R0pKU2dnT1lOeHl5STlHdjZyNmFoVmZM?=
 =?utf-8?B?Mit3VzBSTGNjUjBvek04cWRmTURqc3F2bThwdFFzNUhjSG85MS9DNk5WNkty?=
 =?utf-8?B?UXd3S1VSNkpoWlJpQnYzMVgvRGd1c0hDQjdUNjJFOTZNTEJqRE44RVI0RkNO?=
 =?utf-8?B?ZW1VbGFsZXM5dlFqckV5VzdWWm1qcHJlU0F1TVhYLzJscmptY1BMRlo3aWNF?=
 =?utf-8?B?Uy8zZ2xhcGJCRzlRQ2tvTnZYekJpSkVLcmVNSmRoNGh5VElRRVNkdzF3dm5p?=
 =?utf-8?Q?XQelIgz8VUTkKBez6L5RPRLqyuDIWs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 03:34:22.9418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493a7034-9b93-4439-f3ed-08dd4ca87950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

Hello Zhou,

I'll leave some testing data below but overall, in my testing with
CONFIG_HZ=250 and CONFIG_HZ=10000, I cannot see any major regressions
(at least not for any stable data point) There are few small regressions
probably as a result of grater opportunity for wakeup preemption since
RUN_TO_PARITY will work for a slightly shorter duration now but I
haven't dug deeper to confirm if they are run to run variation or a
result of the larger number of wakeup preemption.

Since most servers run with CONFIG_HZ=250, and the tick is anyways 4ms
and with default base slice currently at 3ms, I don't think there will
be any discernible difference in most workloads (fingers crossed)

Please find full data below.

On 2/8/2025 1:23 PM, zihan zhou wrote:
> The old default value for slice is 0.75 msec * (1 + ilog(ncpus)) which
> means that we have a default slice of
> 0.75 for 1 cpu
> 1.50 up to 3 cpus
> 2.25 up to 7 cpus
> 3.00 for 8 cpus and above.
> 
> For HZ=250 and HZ=100, because of the tick accuracy, the runtime of
> tasks is far higher than their slice.
> 
> For HZ=1000 with 8 cpus or more, the accuracy of tick is already
> satisfactory, but there is still an issue that tasks will get an extra
> tick because the tick often arrives a little faster than expected. In
> this case, the task can only wait until the next tick to consider that it
> has reached its deadline, and will run 1ms longer.
> 
> vruntime + sysctl_sched_base_slice =     deadline
>          |-----------|-----------|-----------|-----------|
>               1ms          1ms         1ms         1ms
>                     ^           ^           ^           ^
>                   tick1       tick2       tick3       tick4(nearly 4ms)
> 
> There are two reasons for tick error: clockevent precision and the
> CONFIG_IRQ_TIME_ACCOUNTING/CONFIG_PARAVIRT_TIME_ACCOUNTING. with
> CONFIG_IRQ_TIME_ACCOUNTING every tick will be less than 1ms, but even
> without it, because of clockevent precision, tick still often less than
> 1ms.
> 
> In order to make scheduling more precise, we changed 0.75 to 0.70,
> Using 0.70 instead of 0.75 should not change much for other configs
> and would fix this issue:
> 0.70 for 1 cpu
> 1.40 up to 3 cpus
> 2.10 up to 7 cpus
> 2.8 for 8 cpus and above.
> 
> This does not guarantee that tasks can run the slice time accurately
> every time, but occasionally running an extra tick has little impact.
> 
> Signed-off-by: zihan zhou <15645113830zzh@gmail.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


o System Details

- 3rd Generation EPYC System
- 2 x 64C/128T
- NPS1 mode
- Boost Enabled
- C2 disabled; POLL and MWAIT based C1 remained enabled

o Kernels

mainline:		For CONFIG_HZ=250 runs:
			mainline kernel at commit 0de63bb7d919 ("Merge
			tag 'pull-fix' of
			git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")

			For CONFIG_HZ=1000 runs it was v6.14-rc2

new_base_slice:		respective mainline + Patch 1

o Benchmark results (CONFIG_HZ=250)

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
  1-groups     1.00 [ -0.00]( 9.88)     1.09 [ -9.19](11.57)
  2-groups     1.00 [ -0.00]( 3.49)     0.97 [  2.91]( 4.51)
  4-groups     1.00 [ -0.00]( 1.22)     0.99 [  1.04]( 2.47)
  8-groups     1.00 [ -0.00]( 0.80)     1.01 [ -1.10]( 1.81)
16-groups     1.00 [ -0.00]( 1.40)     1.01 [ -0.50]( 0.92)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
     1     1.00 [  0.00]( 1.14)     0.99 [ -1.46]( 0.41)
     2     1.00 [  0.00]( 1.57)     1.01 [  1.12]( 0.53)
     4     1.00 [  0.00]( 1.16)     0.99 [ -0.79]( 0.50)
     8     1.00 [  0.00]( 0.84)     0.98 [ -1.51]( 0.71)
    16     1.00 [  0.00]( 0.63)     0.97 [ -3.20]( 0.82)
    32     1.00 [  0.00]( 0.96)     0.99 [ -1.36]( 0.86)
    64     1.00 [  0.00]( 0.52)     0.97 [ -2.95]( 3.36)
   128     1.00 [  0.00]( 0.83)     0.99 [ -1.30]( 1.00)
   256     1.00 [  0.00]( 0.67)     1.00 [ -0.45]( 0.49)
   512     1.00 [  0.00]( 0.03)     1.00 [ -0.20]( 0.67)
  1024     1.00 [  0.00]( 0.19)     1.00 [ -0.14]( 0.24)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
  Copy     1.00 [  0.00](15.75)     1.21 [ 20.54]( 7.80)
Scale     1.00 [  0.00]( 7.43)     1.00 [  0.48]( 6.22)
   Add     1.00 [  0.00](10.35)     1.08 [  7.98]( 6.29)
Triad     1.00 [  0.00]( 9.34)     1.09 [  9.09]( 6.91)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
  Copy     1.00 [  0.00]( 2.19)     1.05 [  5.06]( 2.16)
Scale     1.00 [  0.00]( 6.17)     1.02 [  1.65]( 4.07)
   Add     1.00 [  0.00]( 5.88)     1.04 [  3.81]( 1.07)
Triad     1.00 [  0.00]( 1.40)     1.00 [  0.06]( 3.79)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
  1-clients     1.00 [  0.00]( 0.14)     0.98 [ -1.66]( 0.64)
  2-clients     1.00 [  0.00]( 0.85)     0.98 [ -1.52]( 0.82)
  4-clients     1.00 [  0.00]( 0.77)     0.98 [ -1.72]( 0.77)
  8-clients     1.00 [  0.00]( 0.53)     0.98 [ -1.60]( 0.59)
16-clients     1.00 [  0.00]( 0.91)     0.98 [ -1.79]( 0.74)
32-clients     1.00 [  0.00]( 0.99)     0.99 [ -1.32]( 0.99)
64-clients     1.00 [  0.00]( 1.35)     0.99 [ -1.43]( 1.39)
128-clients     1.00 [  0.00]( 1.20)     0.99 [ -1.17]( 1.22)
256-clients     1.00 [  0.00]( 4.41)     0.99 [ -1.07]( 4.95)
512-clients     1.00 [  0.00](59.74)     1.00 [ -0.17](59.70)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
   1     1.00 [ -0.00]( 7.39)     1.02 [ -2.38](35.97)
   2     1.00 [ -0.00](10.14)     1.02 [ -2.22]( 7.22)
   4     1.00 [ -0.00]( 3.53)     1.08 [ -8.33]( 3.27)
   8     1.00 [ -0.00](11.48)     0.91 [  8.93]( 4.97)
  16     1.00 [ -0.00]( 7.02)     0.98 [  1.72]( 6.22)
  32     1.00 [ -0.00]( 3.79)     0.97 [  3.23]( 2.53)
  64     1.00 [ -0.00]( 8.22)     0.99 [  0.57]( 2.31)
128     1.00 [ -0.00]( 4.38)     0.92 [  8.25](87.57)
256     1.00 [ -0.00](19.81)     1.27 [-27.13](13.43)
512     1.00 [ -0.00]( 2.41)     1.00 [ -0.00]( 2.73)


==================================================================
Test          : new-schbench-requests-per-second
Units         : Normalized Requests per second
Interpretation: Higher is better
Statistic     : Median
==================================================================
#workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
   1     1.00 [  0.00]( 0.00)     0.97 [ -2.64]( 0.68)
   2     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.15)
   4     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.15)
   8     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.15)
  16     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)
  32     1.00 [  0.00]( 0.42)     0.99 [ -0.92]( 3.95)
  64     1.00 [  0.00]( 2.45)     1.03 [  3.09](15.04)
128     1.00 [  0.00]( 0.20)     1.00 [  0.00]( 0.00)
256     1.00 [  0.00]( 0.84)     1.01 [  0.92]( 0.54)
512     1.00 [  0.00]( 0.97)     0.99 [ -0.72]( 0.75)


==================================================================
Test          : new-schbench-wakeup-latency
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
   1     1.00 [ -0.00](12.81)     0.91 [  9.09](14.13)
   2     1.00 [ -0.00]( 8.85)     1.00 [ -0.00]( 4.84)
   4     1.00 [ -0.00](21.61)     0.86 [ 14.29]( 4.43)
   8     1.00 [ -0.00]( 8.13)     0.91 [  9.09](18.23)
  16     1.00 [ -0.00]( 4.08)     1.00 [ -0.00]( 8.37)
  32     1.00 [ -0.00]( 4.43)     1.00 [ -0.00](21.56)
  64     1.00 [ -0.00]( 4.71)     1.00 [ -0.00](10.16)
128     1.00 [ -0.00]( 2.35)     0.93 [  7.11]( 6.69)
256     1.00 [ -0.00]( 1.52)     1.02 [ -1.60]( 1.51)
512     1.00 [ -0.00]( 0.40)     1.01 [ -1.17]( 0.34)


==================================================================
Test          : new-schbench-request-latency
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
   1     1.00 [ -0.00]( 2.46)     1.04 [ -3.67]( 0.35)
   2     1.00 [ -0.00]( 3.16)     1.00 [ -0.26]( 0.13)
   4     1.00 [ -0.00]( 3.16)     0.95 [  4.60]( 2.82)
   8     1.00 [ -0.00]( 1.00)     1.05 [ -4.81]( 0.00)
  16     1.00 [ -0.00]( 3.77)     1.01 [ -0.80]( 2.44)
  32     1.00 [ -0.00]( 1.94)     1.06 [ -6.24](27.22)
  64     1.00 [ -0.00]( 1.07)     0.99 [  1.29]( 0.68)
128     1.00 [ -0.00]( 0.44)     1.01 [ -0.62]( 0.32)
256     1.00 [ -0.00]( 7.02)     1.04 [ -4.45]( 7.53)
512     1.00 [ -0.00]( 1.10)     1.01 [ -1.02]( 2.59)


==================================================================
Test          : longer running benchmarks
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Median
==================================================================
Benchmark		pct imp
ycsb-cassandra          -1.14%
ycsb-mongodb            -0.84%
deathstarbench-1x       -4.13%
deathstarbench-2x       -3.93%
deathstarbench-3x       -1.27%
deathstarbench-6x       -0.10%
mysql-hammerdb-64VU     -0.37%
---

o Benchmark results (CONFIG_HZ=1000)

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
  1-groups     1.00 [ -0.00]( 8.66)     1.05 [ -5.30](16.73)
  2-groups     1.00 [ -0.00]( 5.02)     1.07 [ -6.54]( 7.29)
  4-groups     1.00 [ -0.00]( 1.27)     1.02 [ -1.67]( 3.74)
  8-groups     1.00 [ -0.00]( 2.75)     0.99 [  0.78]( 2.61)
16-groups     1.00 [ -0.00]( 2.02)     0.97 [  2.97]( 1.19)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
     1     1.00 [  0.00]( 0.40)     1.00 [ -0.44]( 0.47)
     2     1.00 [  0.00]( 0.49)     0.99 [ -0.65]( 1.39)
     4     1.00 [  0.00]( 0.94)     1.00 [ -0.34]( 0.09)
     8     1.00 [  0.00]( 0.64)     0.99 [ -0.77]( 1.57)
    16     1.00 [  0.00]( 1.04)     0.98 [ -2.00]( 0.98)
    32     1.00 [  0.00]( 1.13)     1.00 [  0.34]( 1.31)
    64     1.00 [  0.00]( 0.58)     1.00 [ -0.28]( 0.80)
   128     1.00 [  0.00]( 1.40)     0.99 [ -0.91]( 0.51)
   256     1.00 [  0.00]( 1.14)     0.99 [ -1.48]( 1.17)
   512     1.00 [  0.00]( 0.51)     1.00 [ -0.25]( 0.66)
  1024     1.00 [  0.00]( 0.62)     0.99 [ -0.79]( 0.40)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
  Copy     1.00 [  0.00](16.03)     0.98 [ -2.33](17.69)
Scale     1.00 [  0.00]( 6.26)     0.99 [ -0.60]( 7.94)
   Add     1.00 [  0.00]( 8.35)     1.01 [  0.50](11.49)
Triad     1.00 [  0.00]( 9.56)     1.01 [  0.66]( 9.25)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
  Copy     1.00 [  0.00]( 6.03)     1.02 [  1.58]( 2.27)
Scale     1.00 [  0.00]( 5.78)     1.02 [  1.64]( 4.50)
   Add     1.00 [  0.00]( 5.25)     1.01 [  1.37]( 4.17)
Triad     1.00 [  0.00]( 5.25)     1.03 [  3.35]( 1.18)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
  1-clients     1.00 [  0.00]( 0.06)     1.01 [  0.66]( 0.75)
  2-clients     1.00 [  0.00]( 0.80)     1.01 [  0.79]( 0.31)
  4-clients     1.00 [  0.00]( 0.65)     1.01 [  0.56]( 0.73)
  8-clients     1.00 [  0.00]( 0.82)     1.01 [  0.70]( 0.59)
16-clients     1.00 [  0.00]( 0.68)     1.01 [  0.63]( 0.77)
32-clients     1.00 [  0.00]( 0.95)     1.01 [  0.87]( 1.06)
64-clients     1.00 [  0.00]( 1.55)     1.01 [  0.66]( 1.60)
128-clients     1.00 [  0.00]( 1.23)     1.00 [ -0.28]( 1.58)
256-clients     1.00 [  0.00]( 4.92)     1.00 [  0.25]( 4.47)
512-clients     1.00 [  0.00](57.12)     1.00 [  0.24](62.52)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
   1     1.00 [ -0.00](27.55)     0.81 [ 19.35](31.80)
   2     1.00 [ -0.00](19.98)     0.87 [ 12.82]( 9.17)
   4     1.00 [ -0.00](10.66)     1.09 [ -9.09]( 6.45)
   8     1.00 [ -0.00]( 4.06)     0.90 [  9.62]( 6.38)
  16     1.00 [ -0.00]( 5.33)     0.98 [  1.69]( 1.97)
  32     1.00 [ -0.00]( 8.92)     0.97 [  3.16]( 1.09)
  64     1.00 [ -0.00]( 6.06)     0.97 [  3.30]( 2.97)
128     1.00 [ -0.00](10.15)     1.05 [ -5.47]( 4.75)
256     1.00 [ -0.00](27.12)     1.00 [ -0.20](13.52)
512     1.00 [ -0.00]( 2.54)     0.80 [ 19.75]( 0.40)


==================================================================
Test          : new-schbench-requests-per-second
Units         : Normalized Requests per second
Interpretation: Higher is better
Statistic     : Median
==================================================================
#workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
   1     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.46)
   2     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.15)
   4     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.15)
   8     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.15)
  16     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)
  32     1.00 [  0.00]( 0.43)     1.01 [  0.63]( 0.28)
  64     1.00 [  0.00]( 1.17)     1.00 [  0.00]( 0.20)
128     1.00 [  0.00]( 0.20)     1.00 [  0.00]( 0.20)
256     1.00 [  0.00]( 0.27)     1.00 [  0.00]( 1.69)
512     1.00 [  0.00]( 0.21)     0.95 [ -4.70]( 0.34)


==================================================================
Test          : new-schbench-wakeup-latency
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
   1     1.00 [ -0.00](11.08)     1.33 [-33.33](15.78)
   2     1.00 [ -0.00]( 4.08)     1.08 [ -7.69](10.00)
   4     1.00 [ -0.00]( 6.39)     1.21 [-21.43](22.13)
   8     1.00 [ -0.00]( 6.88)     1.15 [-15.38](11.93)
  16     1.00 [ -0.00](13.62)     1.08 [ -7.69](10.33)
  32     1.00 [ -0.00]( 0.00)     1.00 [ -0.00]( 3.87)
  64     1.00 [ -0.00]( 8.13)     1.00 [ -0.00]( 2.38)
128     1.00 [ -0.00]( 5.26)     0.98 [  2.11]( 1.92)
256     1.00 [ -0.00]( 1.00)     0.78 [ 22.36](14.65)
512     1.00 [ -0.00]( 0.48)     0.73 [ 27.15]( 6.75)


==================================================================
Test          : new-schbench-request-latency
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
   1     1.00 [ -0.00]( 1.53)     1.00 [ -0.00]( 1.77)
   2     1.00 [ -0.00]( 0.50)     1.01 [ -1.35]( 1.19)
   4     1.00 [ -0.00]( 0.14)     1.00 [ -0.00]( 0.42)
   8     1.00 [ -0.00]( 0.24)     1.00 [ -0.27]( 1.37)
  16     1.00 [ -0.00]( 0.00)     1.00 [  0.27]( 0.14)
  32     1.00 [ -0.00]( 0.66)     1.01 [ -1.48]( 2.65)
  64     1.00 [ -0.00]( 5.72)     0.96 [  4.32]( 5.64)
128     1.00 [ -0.00]( 0.10)     1.00 [ -0.20]( 0.18)
256     1.00 [ -0.00]( 2.52)     0.96 [  4.04]( 9.70)
512     1.00 [ -0.00]( 0.68)     1.06 [ -5.52]( 0.36)


==================================================================
Test          : longer running benchmarks
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Median
==================================================================
Benchmark		pct imp
ycsb-cassandra          -0.64%
ycsb-mongodb             0.56%
deathstarbench-1x        0.30%
deathstarbench-2x        3.21%
deathstarbench-3x        2.18%
deathstarbench-6x       -0.40%
mysql-hammerdb-64VU     -0.63%
---

If folks are interested in how CONFIG_HZ=250 vs CONFIG_HZ=1000 stack up,
here you go (Note, there is slight variation between the two kernels
since CONFIG_HZ=250 version is closer to v6.14-rc1 and CONFIG_HZ=1000
results are based on v6.14-rc2)

o Benchmark results (CONFIG_HZ=250 vs CONFIG_HZ=1000)

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:      mainline[pct imp](CV)    mainline_1000HZ[pct imp](CV)
  1-groups     1.00 [ -0.00]( 9.88)     1.02 [ -1.57]( 8.66)
  2-groups     1.00 [ -0.00]( 3.49)     0.95 [  4.57]( 5.02)
  4-groups     1.00 [ -0.00]( 1.22)     0.99 [  0.62]( 1.27)
  8-groups     1.00 [ -0.00]( 0.80)     1.00 [ -0.31]( 2.75)
16-groups     1.00 [ -0.00]( 1.40)     0.99 [  1.17]( 2.02)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:      mainline[pct imp](CV)    mainline_1000HZ[pct imp](CV)
     1     1.00 [  0.00]( 1.14)     1.00 [ -0.45]( 0.40)
     2     1.00 [  0.00]( 1.57)     1.01 [  1.40]( 0.49)
     4     1.00 [  0.00]( 1.16)     1.01 [  1.16]( 0.94)
     8     1.00 [  0.00]( 0.84)     1.01 [  1.24]( 0.64)
    16     1.00 [  0.00]( 0.63)     1.00 [ -0.33]( 1.04)
    32     1.00 [  0.00]( 0.96)     1.00 [ -0.30]( 1.13)
    64     1.00 [  0.00]( 0.52)     1.00 [  0.27]( 0.58)
   128     1.00 [  0.00]( 0.83)     1.00 [ -0.45]( 1.40)
   256     1.00 [  0.00]( 0.67)     1.00 [  0.15]( 1.14)
   512     1.00 [  0.00]( 0.03)     0.99 [ -0.73]( 0.51)
  1024     1.00 [  0.00]( 0.19)     0.99 [ -1.29]( 0.62)


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:      mainline[pct imp](CV)    mainline_1000HZ[pct imp](CV)
  Copy     1.00 [  0.00](15.75)     0.93 [ -6.67](16.03)
Scale     1.00 [  0.00]( 7.43)     0.97 [ -2.70]( 6.26)
   Add     1.00 [  0.00](10.35)     0.94 [ -6.42]( 8.35)
Triad     1.00 [  0.00]( 9.34)     0.92 [ -8.26]( 9.56)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:      mainline[pct imp](CV)    mainline_1000HZ[pct imp](CV)
  Copy     1.00 [  0.00]( 2.19)     0.96 [ -3.52]( 6.03)
Scale     1.00 [  0.00]( 6.17)     1.00 [ -0.22]( 5.78)
   Add     1.00 [  0.00]( 5.88)     0.99 [ -1.05]( 5.25)
Triad     1.00 [  0.00]( 1.40)     0.96 [ -3.64]( 5.25)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:      mainline[pct imp](CV)    mainline_1000HZ[pct imp](CV)
  1-clients     1.00 [  0.00]( 0.14)     0.99 [ -0.94]( 0.06)
  2-clients     1.00 [  0.00]( 0.85)     1.00 [ -0.43]( 0.80)
  4-clients     1.00 [  0.00]( 0.77)     0.99 [ -0.63]( 0.65)
  8-clients     1.00 [  0.00]( 0.53)     1.00 [ -0.49]( 0.82)
16-clients     1.00 [  0.00]( 0.91)     0.99 [ -0.55]( 0.68)
32-clients     1.00 [  0.00]( 0.99)     0.99 [ -1.01]( 0.95)
64-clients     1.00 [  0.00]( 1.35)     0.98 [ -1.58]( 1.55)
128-clients     1.00 [  0.00]( 1.20)     0.99 [ -1.38]( 1.23)
256-clients     1.00 [  0.00]( 4.41)     0.99 [ -0.68]( 4.92)
512-clients     1.00 [  0.00](59.74)     0.99 [ -1.16](57.12)


==================================================================
Test          : schbench
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:      mainline[pct imp](CV)    mainline_1000HZ[pct imp](CV)
   1     1.00 [ -0.00]( 7.39)     0.74 [ 26.19](27.55)
   2     1.00 [ -0.00](10.14)     0.87 [ 13.33](19.98)
   4     1.00 [ -0.00]( 3.53)     0.92 [  8.33](10.66)
   8     1.00 [ -0.00](11.48)     0.93 [  7.14]( 4.06)
  16     1.00 [ -0.00]( 7.02)     1.02 [ -1.72]( 5.33)
  32     1.00 [ -0.00]( 3.79)     1.02 [ -2.15]( 8.92)
  64     1.00 [ -0.00]( 8.22)     1.05 [ -4.60]( 6.06)
128     1.00 [ -0.00]( 4.38)     0.91 [  9.48](10.15)
256     1.00 [ -0.00](19.81)     1.01 [ -0.60](27.12)
512     1.00 [ -0.00]( 2.41)     0.91 [  9.45]( 2.54)


==================================================================
Test          : new-schbench-requests-per-second
Units         : Normalized Requests per second
Interpretation: Higher is better
Statistic     : Median
==================================================================
#workers:      mainline[pct imp](CV)    mainline_1000HZ[pct imp](CV)
   1     1.00 [  0.00]( 0.00)     0.99 [ -0.59]( 0.15)
   2     1.00 [  0.00]( 0.00)     1.00 [ -0.29]( 0.15)
   4     1.00 [  0.00]( 0.15)     1.00 [ -0.29]( 0.15)
   8     1.00 [  0.00]( 0.00)     1.00 [ -0.29]( 0.00)
  16     1.00 [  0.00]( 0.00)     1.00 [ -0.29]( 0.00)
  32     1.00 [  0.00]( 0.42)     0.98 [ -1.54]( 0.43)
  64     1.00 [  0.00]( 2.45)     1.03 [  3.09]( 1.17)
128     1.00 [  0.00]( 0.20)     0.98 [ -1.51]( 0.20)
256     1.00 [  0.00]( 0.84)     1.02 [  1.53]( 0.27)
512     1.00 [  0.00]( 0.97)     1.02 [  2.16]( 0.21)


==================================================================
Test          : new-schbench-wakeup-latency
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:      mainline[pct imp](CV)    mainline_1000HZ[pct imp](CV)
   1     1.00 [ -0.00](12.81)     1.09 [ -9.09](11.08)
   2     1.00 [ -0.00]( 8.85)     1.18 [-18.18]( 4.08)
   4     1.00 [ -0.00](21.61)     1.00 [ -0.00]( 6.39)
   8     1.00 [ -0.00]( 8.13)     1.18 [-18.18]( 6.88)
  16     1.00 [ -0.00]( 4.08)     1.00 [ -0.00](13.62)
  32     1.00 [ -0.00]( 4.43)     1.08 [ -8.33]( 0.00)
  64     1.00 [ -0.00]( 4.71)     1.16 [-15.79]( 8.13)
128     1.00 [ -0.00]( 2.35)     0.96 [  3.55]( 5.26)
256     1.00 [ -0.00]( 1.52)     0.80 [ 19.58]( 1.00)
512     1.00 [ -0.00]( 0.40)     0.92 [  8.09]( 0.48)


==================================================================
Test          : new-schbench-request-latency
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:      mainline[pct imp](CV)    mainline_1000HZ[pct imp](CV)
   1     1.00 [ -0.00]( 2.46)     0.99 [  0.52]( 1.53)
   2     1.00 [ -0.00]( 3.16)     0.95 [  5.11]( 0.50)
   4     1.00 [ -0.00]( 3.16)     0.94 [  5.62]( 0.14)
   8     1.00 [ -0.00]( 1.00)     0.99 [  0.80]( 0.24)
  16     1.00 [ -0.00]( 3.77)     0.99 [  0.53]( 0.00)
  32     1.00 [ -0.00]( 1.94)     1.01 [ -1.00]( 0.66)
  64     1.00 [ -0.00]( 1.07)     0.95 [  5.38]( 5.72)
128     1.00 [ -0.00]( 0.44)     1.02 [ -1.65]( 0.10)
256     1.00 [ -0.00]( 7.02)     1.19 [-19.01]( 2.52)
512     1.00 [ -0.00]( 1.10)     0.89 [ 10.56]( 0.68)

==================================================================
Test          : longer running benchmarks
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : Median
==================================================================
Benchmark		pct imp
ycsb-cassandra          -1.25%
ycsb-mongodb            -1.33%
deathstarbench-1x       -2.27%
deathstarbench-2x       -4.85%
deathstarbench-3x       -0.25%
deathstarbench-6x       -0.86%
mysql-hammerdb-64VU     -1.78%
---

With that overwhelming amount of data out of the way, please feel free
to add:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> ---
>   kernel/sched/fair.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1e78caa21436..34e7d09320f7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -74,10 +74,10 @@ unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
>   /*
>    * Minimal preemption granularity for CPU-bound tasks:
>    *
> - * (default: 0.75 msec * (1 + ilog(ncpus)), units: nanoseconds)
> + * (default: 0.70 msec * (1 + ilog(ncpus)), units: nanoseconds)
>    */
> -unsigned int sysctl_sched_base_slice			= 750000ULL;
> -static unsigned int normalized_sysctl_sched_base_slice	= 750000ULL;
> +unsigned int sysctl_sched_base_slice			= 700000ULL;
> +static unsigned int normalized_sysctl_sched_base_slice	= 700000ULL;
>   
>   const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
>   

-- 
Thanks and Regards,
Prateek


