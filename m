Return-Path: <linux-kernel+bounces-550415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47344A55F3B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F3716FDD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA72A187346;
	Fri,  7 Mar 2025 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GNV5OAOY"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A85DF49
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741320626; cv=fail; b=L3LaBHB2IIlM3dE185bhBpFw4ZxkL8R3L0N1A+LL4TmxJGrxjndZCAj3b5Ur6poSpZnZjQUrvurg8QT9YeM1lO5uXIWvxDbfG+7DolLv3uADMb1azgrrcFC7AMNBPDYwRYS4pPRZFPsO5v1U0PQ4ZWiy7xAOaQ0vZkpFDJJYWHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741320626; c=relaxed/simple;
	bh=8FV8pnztsUhjDd3YwgcKW8UNcVAbIvFmIz/pTaEYrqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ht0oAp18nTqrynI84M5pp10XE5f+NhhBsQg7JJ7U0BKN3d+nHj+mBhwKgHBxLPfURPpI4JNZukL3Ca+uD7i96j3egOKXAvwqOEkVizon4zepWhe4gjlKsxZimfq0HjxwEr+QmylBZ9qIBK1+LBuRE1aeK8+UqiCnCXjpa10866I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GNV5OAOY; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vG2zT/xTJcLmh0weBcCVMwjzz/p2b/e6imAue14Rhcva2Y7yiydiuUhTnFHB4mFNB9jVBjCtgXlRTwkYtgZkiWk8cdrztASkjqcA1k6RDPpVKxBSlaRej9Dno+uUMw3q7GqudAxTOT/XQdx2CbG13t40lMxjBULbBFxAisw0r5PAhNZa52Qdf2ofgM9lRxtYl7MLfA2dIHmhCOi80aQVXu8MPxXSrGkkHjMH4KCPLQQbQUQyn13CD0bpc/wupPeIKjttWzEFY4nCqLtYAYntuWCIWu9m6FPdDlHRNc3QWzWz4gqPhaUbTth/afvAjGvzKb0wlqSSNjKhMsrfj2pBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2C/Uq/vhkffR2J5lpSfxKnGxj69FakNSGyApvNjuVc=;
 b=XhEbLlhTGBSTPVnkVoA3r0ue5lGatITfjwJXRDZJPmtacAEkqjbW7/ZhaIo3pj59OEi369rjxkvHIZLsk9/JWeipZYH1phG1yDEXCxXu2eJJek8hcw9UEpDwFCFLI+nHSauNBEkSMlRzj+GSQLKF1NmztBX5Ag/mvzbzuvDnnLMHbqQGV/guaOF42SEJNIXq+1zwmmnfDnPOs0ioUea6Wt6vKpM85VSKBKVYNtKWQrhFXBZNnHDID6yEEYGfyAStFYyQHiqDt/KidYRjUGFt6FIlgEMAZHZVBng6phf9UbWIKJGbME1+Gy6MsgPfrcjI7dncT9GdmalH3teTnw7mpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2C/Uq/vhkffR2J5lpSfxKnGxj69FakNSGyApvNjuVc=;
 b=GNV5OAOYP59NSa2ZB1Jn++7ekIqFpTKxy8Fqhv8NUoXFCEri+St2l2LFmN5KnEkkhkR0M10x66hZF11nbD8V3js+Kryubhny0X49dWshQDxg0WlTZCf5IETaZ8hVnJlb4lsFLdo5D37UuuA/oNwKjzKpgE1UJEEVZYol/tI+bzM=
Received: from BN0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:408:ee::26)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 04:10:18 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::b5) by BN0PR04CA0021.outlook.office365.com
 (2603:10b6:408:ee::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 04:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 04:10:17 +0000
Received: from [10.136.39.36] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 22:10:14 -0600
Message-ID: <3d0f9c2b-8498-4405-b178-9f6c8615f73b@amd.com>
Date: Fri, 7 Mar 2025 09:40:11 +0530
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
CC: <bsegall@google.com>, <dietmar.eggemann@arm.com>,
	<gautham.shenoy@amd.com>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<vschneid@redhat.com>
References: <ce4f4f7a-6033-4354-972e-2a066f8d5190@amd.com>
 <20250222030221.63120-1-15645113830zzh@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250222030221.63120-1-15645113830zzh@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM3PR12MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d3cca1-58b8-497a-66be-08dd5d2df855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDdHdE54dUFBbUkrQUpUOHp5TkVOd3ZWL09EOGRsTUc0bWNudnNqZVRxaHVT?=
 =?utf-8?B?b0hYTEdrRmdQMWlHWERZeGlUdHc3enpKMjVYa0twaStON2RrTjFJU25tY2tL?=
 =?utf-8?B?MUdMVDZ5UGxTRUREZUtVN3pmemxVZXdSbjJxTDZVeUIyMitQNTlXQi9NOFcv?=
 =?utf-8?B?UzkwYlJuMnp4aktBMjExeWh6K3dsTkNidmpWbnNxUkloeWE4Tk1vM0pldTE2?=
 =?utf-8?B?aXkwODVJWlZENjh0K3B1SDZ6RFJ1YkJpZlpKZnRNQWkzQVRmN3NuSlJGNFhY?=
 =?utf-8?B?T3JpQTB6cVZMYjF5L05rODRNemlQczd5VGNDT09tU1M5Q05WRlBSd0hCZHE4?=
 =?utf-8?B?QkRJTStGSXVqUC9OeUYrTWcrSHVRK1ptRHdYVkxHQm1QZFBYMHdXVzBCZWVk?=
 =?utf-8?B?cE40dWdKcktISTk5cVRxVHEybG9NS3FNc1pxcGRyTjF1WldyVkhxWmxvSFMz?=
 =?utf-8?B?ZjlRdHhxY2NsQWdTMTRpODNrNDhOYjEvZHZLM3VlNW9tZkxhMG1IdnEwS3VT?=
 =?utf-8?B?TGJBTVNMbUhFcGpBZDlPc3M3SlRZSnRBL0J4RURraUNPWGdnQ0N0bnpQUzRI?=
 =?utf-8?B?R3RkMmlJNDNGWHNKSktITWpMenFtb040amFUdGhmSEJFeENGNXBYaEllbkc5?=
 =?utf-8?B?M1JzMkNaQXV5WEZWdzBJQ2c2RzNNZGN3azNFdmVmQWd1aW1vMnVReVQrdUVy?=
 =?utf-8?B?NzEzMEQ4c3EyNExIVCtUUFFpNnhsZEcwMytNcit5TFlWRXRnL2xGcjVXUEhY?=
 =?utf-8?B?bDBYOU5kSDN3cUNQNTdMRGY0U2JwTmV2K0dKSVJQa0pUSVZlRUxuN1UrbFY4?=
 =?utf-8?B?anVvZkEzNkg3enh3ZEdaL051UUlJUnF5Y0lEbUs4WFZ4VG1GSm9FbjA1NEdu?=
 =?utf-8?B?RC9aRzJZTDdUM0dpN2QwVTg2dzFCTEpmOVc5UzZhZmlLaDRzc1IvaWN6NHV4?=
 =?utf-8?B?ZFZxUXpjUWJWWVNNcVRYZWlsaWROaXl2eDkzUXVOMnhWSGFvcWhYSTc4WUJx?=
 =?utf-8?B?Szk5elFsT0xKYzAzZDRROUZCMTAvUmFBdmNLcHJXTlVKaGhNMmUveVRDeHhT?=
 =?utf-8?B?YVZoSG9JOTVjdmhHMkxPMWNVRGkwUThPS01yYlA0NVNJdWF1emU4UUpEbXZm?=
 =?utf-8?B?RTJ0NFRjVEkwTU5WS1U5cWNRWURKN2dVRXVSeUt0d3NjSWdjaWhJQmRDUjR6?=
 =?utf-8?B?K1ZzaUF2K2VqZGpwZ1ZCQmNmS2grZEFvZmJLdTdra2t4Rll5a3dobFlOaUtS?=
 =?utf-8?B?UVFkeGVDUTRjbCtGVjNOeWxobFZXUlZmVFdMRDJlazlFVnRVYk9JZW5QRmNm?=
 =?utf-8?B?V00zNVIvRTBDRENxVU85aDg0dUdlZ204dWNHMkJpcm92cHNxdFFYb0NzbUJD?=
 =?utf-8?B?bk5hQTVFVEdvZ3NuTHdnbHcxVjNrcUYwL1JyRmJad2pNU0V1WjRCL05yaDkr?=
 =?utf-8?B?QlJyeFpjSlVJNWYyaHpDRWFXenZmUnRPZEpoaTFzcUUyMUpraS9sdkZQQnRF?=
 =?utf-8?B?L3hoM1cxeFpBWktSTk9NMkRVS3JRYU5QRStxQmRKTU9JNnJwaFpINWRJSU0y?=
 =?utf-8?B?a3hRNVFrNnk2bmlaNm9EQnNiRCtaM1UvUnhMcXZRTmNKTFpyTUp5aFBtbHlO?=
 =?utf-8?B?S01NSjVtQ1R6TktHaGdhVS9PQVU3eEJ6Q2lKWkNlUWM4K1pvOW9zaHlEWWsy?=
 =?utf-8?B?TjFvNFFvOTljRm9HT2N2VnNpT2pDcVdkTHM1dUM1ZTNxTzlIUVlNa3g2c1FM?=
 =?utf-8?B?aFZ1bHU0SnM4NnRDdFphc1VvV2M4TzNZVU1zUkd4MHJ4WjlOUlpZWGp6enF5?=
 =?utf-8?B?NTV6N1YwaXBMZ081RmRVYXNLcysvay9qN3dEaTBDY1IwQVFSOFFlZnJOQ2dW?=
 =?utf-8?B?UjVROFRsYUR1WTQ5Q216QUtNT1NiT0pUQ2l0K0o0VXQvZFBuTXd3cklMKzM0?=
 =?utf-8?Q?bGMYrS0XSe8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 04:10:17.7111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d3cca1-58b8-497a-66be-08dd5d2df855
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288

Hello Zhou,

Sorry this slipped past me.

On 2/22/2025 8:32 AM, zihan zhou wrote:
> Thank you for your reply, thank you for providing such a detailed test,
> which also let me learn a lot.
> 
>> Hello Zhou,
>>
>> I'll leave some testing data below but overall, in my testing with
>> CONFIG_HZ=250 and CONFIG_HZ=10000, I cannot see any major regressions
>> (at least not for any stable data point) There are few small regressions
>> probably as a result of grater opportunity for wakeup preemption since
>> RUN_TO_PARITY will work for a slightly shorter duration now but I
>> haven't dug deeper to confirm if they are run to run variation or a
>> result of the larger number of wakeup preemption.
>>
>> Since most servers run with CONFIG_HZ=250, and the tick is anyways 4ms
>> and with default base slice currently at 3ms, I don't think there will
>> be any discernible difference in most workloads (fingers crossed)
>>
>> Please find full data below.
> 
> 
> This should be CONFIG_HZ=250 and CONFIG_HZ=1000, is it wrong?

That is correct! My bad.

> 
> It seems that no performance difference is good news. This change will not
> affect performance. This problem was first found in the openeuler 6.6
> kernel. If one task runs all the time and the other runs for 3ms and then
> sleeps for 1us, the running time of the two tasks will become 4:3, but 1:1
> on orig cfs. This problem has disappeared in the mainline kernel.
> 
>> o Benchmark results (CONFIG_HZ=1000)
>>
>> ==================================================================
>> Test          : hackbench
>> Units         : Normalized time in seconds
>> Interpretation: Lower is better
>> Statistic     : AMean
>> ==================================================================
>> Case:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>>    1-groups     1.00 [ -0.00]( 8.66)     1.05 [ -5.30](16.73)
>>    2-groups     1.00 [ -0.00]( 5.02)     1.07 [ -6.54]( 7.29)
>>    4-groups     1.00 [ -0.00]( 1.27)     1.02 [ -1.67]( 3.74)
>>    8-groups     1.00 [ -0.00]( 2.75)     0.99 [  0.78]( 2.61)
>> 16-groups     1.00 [ -0.00]( 2.02)     0.97 [  2.97]( 1.19)
>>
>>
>> ==================================================================
>> Test          : tbench
>> Units         : Normalized throughput
>> Interpretation: Higher is better
>> Statistic     : AMean
>> ==================================================================
>> Clients:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>>       1     1.00 [  0.00]( 0.40)     1.00 [ -0.44]( 0.47)
>>       2     1.00 [  0.00]( 0.49)     0.99 [ -0.65]( 1.39)
>>       4     1.00 [  0.00]( 0.94)     1.00 [ -0.34]( 0.09)
>>       8     1.00 [  0.00]( 0.64)     0.99 [ -0.77]( 1.57)
>>      16     1.00 [  0.00]( 1.04)     0.98 [ -2.00]( 0.98)
>>      32     1.00 [  0.00]( 1.13)     1.00 [  0.34]( 1.31)
>>      64     1.00 [  0.00]( 0.58)     1.00 [ -0.28]( 0.80)
>>     128     1.00 [  0.00]( 1.40)     0.99 [ -0.91]( 0.51)
>>     256     1.00 [  0.00]( 1.14)     0.99 [ -1.48]( 1.17)
>>     512     1.00 [  0.00]( 0.51)     1.00 [ -0.25]( 0.66)
>>    1024     1.00 [  0.00]( 0.62)     0.99 [ -0.79]( 0.40)
>>
>>
>> ==================================================================
>> Test          : stream-10
>> Units         : Normalized Bandwidth, MB/s
>> Interpretation: Higher is better
>> Statistic     : HMean
>> ==================================================================
>> Test:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>>    Copy     1.00 [  0.00](16.03)     0.98 [ -2.33](17.69)
>> Scale     1.00 [  0.00]( 6.26)     0.99 [ -0.60]( 7.94)
>>     Add     1.00 [  0.00]( 8.35)     1.01 [  0.50](11.49)
>> Triad     1.00 [  0.00]( 9.56)     1.01 [  0.66]( 9.25)
>>
>>
>> ==================================================================
>> Test          : stream-100
>> Units         : Normalized Bandwidth, MB/s
>> Interpretation: Higher is better
>> Statistic     : HMean
>> ==================================================================
>> Test:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>>    Copy     1.00 [  0.00]( 6.03)     1.02 [  1.58]( 2.27)
>> Scale     1.00 [  0.00]( 5.78)     1.02 [  1.64]( 4.50)
>>     Add     1.00 [  0.00]( 5.25)     1.01 [  1.37]( 4.17)
>> Triad     1.00 [  0.00]( 5.25)     1.03 [  3.35]( 1.18)
>>
>>
>> ==================================================================
>> Test          : netperf
>> Units         : Normalized Througput
>> Interpretation: Higher is better
>> Statistic     : AMean
>> ==================================================================
>> Clients:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>>    1-clients     1.00 [  0.00]( 0.06)     1.01 [  0.66]( 0.75)
>>    2-clients     1.00 [  0.00]( 0.80)     1.01 [  0.79]( 0.31)
>>    4-clients     1.00 [  0.00]( 0.65)     1.01 [  0.56]( 0.73)
>>    8-clients     1.00 [  0.00]( 0.82)     1.01 [  0.70]( 0.59)
>> 16-clients     1.00 [  0.00]( 0.68)     1.01 [  0.63]( 0.77)
>> 32-clients     1.00 [  0.00]( 0.95)     1.01 [  0.87]( 1.06)
>> 64-clients     1.00 [  0.00]( 1.55)     1.01 [  0.66]( 1.60)
>> 128-clients     1.00 [  0.00]( 1.23)     1.00 [ -0.28]( 1.58)
>> 256-clients     1.00 [  0.00]( 4.92)     1.00 [  0.25]( 4.47)
>> 512-clients     1.00 [  0.00](57.12)     1.00 [  0.24](62.52)
>>
>>
>> ==================================================================
>> Test          : schbench
>> Units         : Normalized 99th percentile latency in us
>> Interpretation: Lower is better
>> Statistic     : Median
>> ==================================================================
>> #workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>>     1     1.00 [ -0.00](27.55)     0.81 [ 19.35](31.80)
>>     2     1.00 [ -0.00](19.98)     0.87 [ 12.82]( 9.17)
>>     4     1.00 [ -0.00](10.66)     1.09 [ -9.09]( 6.45)
>>     8     1.00 [ -0.00]( 4.06)     0.90 [  9.62]( 6.38)
>>    16     1.00 [ -0.00]( 5.33)     0.98 [  1.69]( 1.97)
>>    32     1.00 [ -0.00]( 8.92)     0.97 [  3.16]( 1.09)
>>    64     1.00 [ -0.00]( 6.06)     0.97 [  3.30]( 2.97)
>> 128     1.00 [ -0.00](10.15)     1.05 [ -5.47]( 4.75)
>> 256     1.00 [ -0.00](27.12)     1.00 [ -0.20](13.52)
>> 512     1.00 [ -0.00]( 2.54)     0.80 [ 19.75]( 0.40)
>>
>>
>> ==================================================================
>> Test          : new-schbench-requests-per-second
>> Units         : Normalized Requests per second
>> Interpretation: Higher is better
>> Statistic     : Median
>> ==================================================================
>> #workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>>     1     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.46)
>>     2     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.15)
>>     4     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.15)
>>     8     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.15)
>>    16     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)
>>    32     1.00 [  0.00]( 0.43)     1.01 [  0.63]( 0.28)
>>    64     1.00 [  0.00]( 1.17)     1.00 [  0.00]( 0.20)
>> 128     1.00 [  0.00]( 0.20)     1.00 [  0.00]( 0.20)
>> 256     1.00 [  0.00]( 0.27)     1.00 [  0.00]( 1.69)
>> 512     1.00 [  0.00]( 0.21)     0.95 [ -4.70]( 0.34)
>>
>>
>> ==================================================================
>> Test          : new-schbench-wakeup-latency
>> Units         : Normalized 99th percentile latency in us
>> Interpretation: Lower is better
>> Statistic     : Median
>> ==================================================================
>> #workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>>     1     1.00 [ -0.00](11.08)     1.33 [-33.33](15.78)
>>     2     1.00 [ -0.00]( 4.08)     1.08 [ -7.69](10.00)
>>     4     1.00 [ -0.00]( 6.39)     1.21 [-21.43](22.13)
>>     8     1.00 [ -0.00]( 6.88)     1.15 [-15.38](11.93)
>>    16     1.00 [ -0.00](13.62)     1.08 [ -7.69](10.33)
>>    32     1.00 [ -0.00]( 0.00)     1.00 [ -0.00]( 3.87)
>>    64     1.00 [ -0.00]( 8.13)     1.00 [ -0.00]( 2.38)
>> 128     1.00 [ -0.00]( 5.26)     0.98 [  2.11]( 1.92)
>> 256     1.00 [ -0.00]( 1.00)     0.78 [ 22.36](14.65)
>> 512     1.00 [ -0.00]( 0.48)     0.73 [ 27.15]( 6.75)
>>
>>
>> ==================================================================
>> Test          : new-schbench-request-latency
>> Units         : Normalized 99th percentile latency in us
>> Interpretation: Lower is better
>> Statistic     : Median
>> ==================================================================
>> #workers:      mainline[pct imp](CV)    new_base_slice[pct imp](CV)
>>     1     1.00 [ -0.00]( 1.53)     1.00 [ -0.00]( 1.77)
>>     2     1.00 [ -0.00]( 0.50)     1.01 [ -1.35]( 1.19)
>>     4     1.00 [ -0.00]( 0.14)     1.00 [ -0.00]( 0.42)
>>     8     1.00 [ -0.00]( 0.24)     1.00 [ -0.27]( 1.37)
>>    16     1.00 [ -0.00]( 0.00)     1.00 [  0.27]( 0.14)
>>    32     1.00 [ -0.00]( 0.66)     1.01 [ -1.48]( 2.65)
>>    64     1.00 [ -0.00]( 5.72)     0.96 [  4.32]( 5.64)
>> 128     1.00 [ -0.00]( 0.10)     1.00 [ -0.20]( 0.18)
>> 256     1.00 [ -0.00]( 2.52)     0.96 [  4.04]( 9.70)
>> 512     1.00 [ -0.00]( 0.68)     1.06 [ -5.52]( 0.36)
>>
>>
>> ==================================================================
>> Test          : longer running benchmarks
>> Units         : Normalized throughput
>> Interpretation: Higher is better
>> Statistic     : Median
>> ==================================================================
>> Benchmark		pct imp
>> ycsb-cassandra          -0.64%
>> ycsb-mongodb             0.56%
>> deathstarbench-1x        0.30%
>> deathstarbench-2x        3.21%
>> deathstarbench-3x        2.18%
>> deathstarbench-6x       -0.40%
>> mysql-hammerdb-64VU     -0.63%
>> ---
> 
> It seems that new_base_slice has made some progress in high load/latency
> and regressed a bit on low load.
> 
> It seems that slice should not only be related to the number of cpus, but
> also to the corresponding relationship between the overall load and the
> number of cpus. The load is relatively heavy, so the slice should be
> smaller. The load is relatively light, so the slice should be larger.
> Fixing it to a value may not be the optimal solution.

We've seen that assumptions go wrong in our experiments; some benchmarks
really love their time on the CPU without any preemptions :)

> 
>> With that overwhelming amount of data out of the way, please feel free
>> to add:
>>
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> I think you're worth it, but it seems a bit late. I have received the email
> of tip-bot2, I am not sure if there can still add it.

That is fine as long as there is a record on lore :)

> 
> Your email made me realize that I should establish a systematic testing
> method. Can you give me some useful projects?

We use selective benchmarks from LKP: https://github.com/intel/lkp-tests

Then there are some larger benchmarks we run based on previous regression
reports and debugs. some of them are:

YCSB: https://github.com/brianfrankcooper/YCSB
netperf: https://github.com/HewlettPackard/netperf
DeathStarBench: https://github.com/delimitrou/DeathStarBench
HammerDB: https://github.com/TPC-Council/HammerDB.git
tbench (part of dbench): https://dbench.samba.org/web/download.html
schbench: https://git.kernel.org/pub/scm/linux/kernel/git/mason/schbench.git
sched-messaging: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/bench/sched-messaging.c?h=v6.14-rc4

Some of them are hard to setup the first time; we internally have some
tools that have made it easy to run these benchmarks in a way that
stresses the system but we keep an eye out for regression reports to
understand what benchmarks folks are running in the field.

Sorry again for the delay and thank you.

> 
> Thanks!

-- 
Thanks and Regards,
Prateek


