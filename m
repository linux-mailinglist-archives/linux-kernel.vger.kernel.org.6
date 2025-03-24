Return-Path: <linux-kernel+bounces-573135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0ADA6D36C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 04:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B0A169AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F417E01B;
	Mon, 24 Mar 2025 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qX8nARQF"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02F36124
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742788743; cv=fail; b=r1k1h+tRMHyufOLacVDYpbxzu/xE+ST+4NC+VcC54mYp0ano8m0SjQ5hkzOec7DXGMVO6162J3u1S0Eo0cTplrtzmJ6FFgyllax1J2N5HRDNQDcutpkgvVdEacWD5F4rKiOT+7MfMKwZftI7Yr3d5MD7esCLj8xRvAI8N3ArKRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742788743; c=relaxed/simple;
	bh=m78fqq1zgds7tvt83YoOg4LKo+cSjiP+vIqEjyjhHV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nK7kL4PZtFUODl513iR7Gih86+kgpFs/7Zq0QrGfwkf11sxPHVCaSWdsRCvF5vA5qeIUc6JiJilVwtV5QUmG2TqGbWG+915ElSeH4Oif0vndkd+NZesJiiPDPW1vAbFZF+K/Z/+1F9OeJh4ZlCU77V/Q6tch/kInR2kcc05XGCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qX8nARQF; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fe9kXXl066LP/96QBfuv6L2Jl2Pg4RtXVY0aVU2ATvSN6Oz+pJyE23CVqU3KJXYIrKj/8jIFGcNRx68klDFKWaC0G3wZbzLSunmKwvxceNXaBc5826Z/3Hz1esU5x3OVqra/U0SdYnOPz21m9MmOf3Stf6Wg4gDf5qaoqYI8roWrUluJYfEvSBlc8mQzSm8+KWKKhFgKmyUlcHZ/T81pK95aNW9JZkdu8QOYa7DIS700ZlVRzHo9wOjwfxbTtOSXYnoClb6XkYueKALsIXByDQlXMvw5ZXru/Kf7Y0qEwisgB3G2ETji05VFF59RUVC3+YjlHVdfUkcmbSMAuz8yfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4Zt3OTT3V9H3vMpEh3lbTG/d14Abh7mjMYSgmU7pBM=;
 b=DUuoVDwsxAAH6tq/oLYz2bA20Ha58sSEut7DC+CEl1FAM6b9mufdvX2HpJL85o0rV6/qvGpMu+ho704J1zF6zEyRehUK9k3kByutaOHRAplRJSy3SGsxpnCvQItF65emMcyk9gcRwV1rOYhlNYFK0XMvNMdQ76FsVTf5/Wo3ATHyYN4h7ZR0UY+YLfOboUXbHFC62BMsphlqK/L/6+M7axNG1z707758O+CTxSezMHcrrDOjpf2Wdte7FxjUV/QVSAotWvUpE49vhI4xHSxQ7nLLrvcTycPo6aa0XfYM/dGRWBsmCkjc9tKb92dzNSiZpptZD61jEHshU9+/W1bQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4Zt3OTT3V9H3vMpEh3lbTG/d14Abh7mjMYSgmU7pBM=;
 b=qX8nARQF0+D0efJqDOQ1wxG3zjpPrZIMwTWeBLxBOQJi6dkQUgjrbA8klHyggJAmxfHXncRFjCqv4Lm1mxGcBfdkyMB+6M8GnZ6H8y0gYrczh8xrW+fHgI5n1UZMBWuovJCnOqMlX3KzWBLtOyCdsdgJ3qN/MT5ELGLnh5lW8l0=
Received: from DS7PR03CA0150.namprd03.prod.outlook.com (2603:10b6:5:3b4::35)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 03:58:58 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::25) by DS7PR03CA0150.outlook.office365.com
 (2603:10b6:5:3b4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.38 via Frontend Transport; Mon,
 24 Mar 2025 03:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 03:58:57 +0000
Received: from [10.252.90.31] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 23 Mar
 2025 22:58:53 -0500
Message-ID: <f988e37f-cb28-4ac3-9e93-1e5fa6750e59@amd.com>
Date: Mon, 24 Mar 2025 09:28:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] sched/fair: Propagate load balancing stats up the
 sched domain hierarchy
To: Libo Chen <libo.chen@oracle.com>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>, Chen Yu
	<yu.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, David Vernet
	<void@manifault.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20250313093746.6760-1-kprateek.nayak@amd.com>
 <9af4bb66-83c4-4257-bfc3-dbcb2185a7e6@oracle.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <9af4bb66-83c4-4257-bfc3-dbcb2185a7e6@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e649b39-375b-4ab5-eab8-08dd6a883432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1BYaTA4RkxONWIrdEtLM1QzOFZWT0w5WlRBbmp1MkFsMlJUWkg2N1k4ZTB2?=
 =?utf-8?B?Zk0rdmpuVmgxc0FpMXh6dTVPRFhhYzhjQXpPd2Q4Z3krWDNRTkFlQlZTR0lJ?=
 =?utf-8?B?VFR3NHhQOXRpY01DQkFaSW5DVXpWN3N5RGxqd1FJazhudVVNK1pzaFM4NGFr?=
 =?utf-8?B?ZW5lS2N6V2tJNkJrVnVXdTBkbUtZUUo2RERmYTExcm54RjdiaHZtbHdweEkr?=
 =?utf-8?B?d1ZJeFBJeG5IT1J4OEx2azlla2U4V09KUFNUUXV6VWd2MVZ0QVhhZVZFZXRI?=
 =?utf-8?B?b0dOZUNETnlQNVJLcFFwdklZam1zckxNYUdvTTVMVmEwQU1pZlFZbUtxREUz?=
 =?utf-8?B?clFabm03eEE0RDVac3RuN3l5TEY4dm1wQVpyK2tucWM5aVVPMUtYd0R1Y0ho?=
 =?utf-8?B?Qm4zVE1JVGtzbCtJVXV4cDlXYmxQbldReCtKVlIzRHFoNkVFQXZCd2RJR21T?=
 =?utf-8?B?QVpvcURtNG1DVkNmWC9LTmRmZUU0REV6UTZuS3M0TVR5dGJkRTV5d2dpUjhT?=
 =?utf-8?B?c2NNWjQvcExsQjZWelNUWTMzemJ2bHhBNE0xVjhKUE9Zak1PaWhUaFpkcEx0?=
 =?utf-8?B?dC8yNkY1WndUZTIvN2lBdTJPN3p2V01zNStlV25rNHlHUmV6NUZlMWwzbkI5?=
 =?utf-8?B?cTFSeDBXTnFyUzFRNTZXRmVmUHYvMmRpUlluQ0NkWTJNYno2NlJId0ZzVkIz?=
 =?utf-8?B?TUNFTXBTMHZjc3VhT0FaQ0hZLzFXTWg4MXg2azQ0TjZOcWsxTEZGcTBKTStx?=
 =?utf-8?B?NzNXVEdJbEJxOTJJbTBuYUx5UGxMYi9KK3YvWWZIWWwvaWxVN1BxQVdSK0F3?=
 =?utf-8?B?bjVMRzMyRkY3Mmh6ZzI0TXBmYTJOK3lJdndzUDBLMk1xS2h6WE9ibElpZW55?=
 =?utf-8?B?N005amNJeVhSQUNOU1lVazVTZ1NWL3R3TjlRUFI2SnZFTWRvRmxnRTRiK3Aw?=
 =?utf-8?B?aStxZXp0ZmsxdXA5SytOSisra0NWQUlsTXVwdzBRb3loa1pYdFV6Yk4wb1RU?=
 =?utf-8?B?ZFByaVJHMXNBeVM4M3RHaldtZjNaME5XeFlKYU1LZHgvaC8zM3NaLzJvbkw4?=
 =?utf-8?B?SVYrSGZVNDZlL2lDY3hKTmZqOGdab1hGOEx5cjVqYVlLcFRlN3JzTElSUW5N?=
 =?utf-8?B?OW9DQlppSzF2S3U5MXAwOVFIVUVJZVM5RHRBZCtTSnRJVUt1S2UrYVdaS2xq?=
 =?utf-8?B?WWxUYUU4SVI1U05QY3FZSDRkZGNCaTQyeTVjRSttS1pwOFU2MzVQUXBpYmE4?=
 =?utf-8?B?Y2xJWFQxaTVZWXJkcDZPRUtMY3h1aVhOcUtIQXV4OWNJQS84L0kvRGtlYm5y?=
 =?utf-8?B?WjJIQ1BEaWJvMkNoMlh3UER0bHczYUZKajVGNmVPVlV3QnRIWFZTQ1crRTR2?=
 =?utf-8?B?RXEwUUV2Wk5pNXFQTEJuNmx0L3JGTnJYaUtwdFVMVFc2VXluYkVGZlQySFVw?=
 =?utf-8?B?eGJtQjdNSEhuY1llRDVnL0g1bnZqbjhkaUxZeXgrbEhvNWs1RUFUYTVnV2VS?=
 =?utf-8?B?b1FsN3VnUkhtblR0NWR1akQvSklpV1RGR1JjUlhLMEVqQUhKUHBWbXl5QW14?=
 =?utf-8?B?Uk1mNVVvYlEvQTQvOGQ1SktaYyt3dFo4NkpCQ0gzTXhBS2t0Q3E0cjN2L1Ax?=
 =?utf-8?B?WitrNyt1T2FUUER2SWNGL0l0V1laNmFyVDNjaFJWSUhZQkZJRmw1QXV5Wmlj?=
 =?utf-8?B?ZEVxUVpvcVZvUStZNzR6cmhjUkNtRnUzR3N1bXpicVBXTW0wbmhBYldDOEQ0?=
 =?utf-8?B?ZEtSVVFMaWZSZTdhczU2U3hsUm0wTUFTOElOWUpxUjYrbkZPVmJSQTM0Mnp0?=
 =?utf-8?B?enlKTkdCbjBXS2xud2E3M2FtRXNjMk4yMGhXalk4VEFuZ0pTZHMzVktGR2FG?=
 =?utf-8?B?MTUrZHUrTmRkV1B5cFlJUFJIYkRWNkYza3NHc1pTWG9xT290bVZXN2RxZmN1?=
 =?utf-8?B?VGVFU1c5czJudlRLbTdlbndlWXE1bDlFM0lLOW1YSStCeUhPUG5GdHZGWS9a?=
 =?utf-8?Q?aZmTYfhvhQFslQk6ufGq/XwT+cMHM8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 03:58:57.8608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e649b39-375b-4ab5-eab8-08dd6a883432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066

Hello Libo,

Thank you for taking a look at the series and sorry for the late
response.

On 3/21/2025 3:34 PM, Libo Chen wrote:
> 
> 
> On 3/13/25 02:37, K Prateek Nayak wrote:
> 
>> Benchmark results
>> =================
>>
> 
> Hi Prateek,
> 
> Definitely like the idea, esp. if we can pull this off on newidle lb
> which tends to be more problematic on systems with a large number
> of cores. But the data below on periodic lb isn't I guess as good as
> I expect. So I am wondering if the cost of update_[sd|sg]_lb_stats()
> actually went down as the result of the caching?

I have some numbers for versioning idea that I got working just before
OSPM in [1] The benchmark results don't move much but the total time
for newidle balance reduces by ~5% overall.

There is a ~30% overhead of aggregating and propagating the stats
upwards at SMT domain that offsets some of the benefits of propagation
at higher domains but I'm working to see if this can be reduced and
only done if required.

Some ideas were discussed at OSPM to reduce the overheads further and
shared the burden of busy load balancing across all CPUs in the domain
and I'll tackle that next.

If you have any benchmark where this shows up prominently, please do let
me know and I can try adding it to the bunch.

[1] https://lore.kernel.org/lkml/20250316102916.10614-1-kprateek.nayak@amd.com/

-- 
Thanks and Regards,
Prateek

> 
> Thanks,
> Libo


