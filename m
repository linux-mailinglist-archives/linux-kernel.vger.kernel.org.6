Return-Path: <linux-kernel+bounces-444250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E59F0357
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87149283E88
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF1A1547F5;
	Fri, 13 Dec 2024 04:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mRnmOcAp"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A568F5E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062545; cv=fail; b=o7bq5KsQM5QMcNMuSpf8TBYKq45U12XtXwehBRunyjgipiF3xRKDzuRfFsQPhVw4n7mCyZRETEc1QC5C+hNUcRyx7I/LN1KxXqGKBqdbT1zc6cdhRsz+rF2TlRQTzQxK4gKjMDnMyXIppv6KeWtROfLfVQjQg7yRJJtU3+a9x5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062545; c=relaxed/simple;
	bh=2J0eUuvokibGVrQ+AcAPZrhnpUjHAd2jGyv0QAQ/6mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VliVL2ATDSD0UHZiMuT7xEuE+vAq1pskHR/jwqJesYZAL+Fa41WuHENI6caty8L8W/S/oWrjcOKiL1R8CSmqSUdm0gezKLlEgGfjjvWvvXDoSAZYIRVffPzjb5bbglCNxAH1bdzO7By0XtnyLnwLaVNwnPZJIaisn9c8PiMiy8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mRnmOcAp; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wv4V4N2c7jn90x7Zo040Rkp2lKWHl1hEjttpVhXmuWF1HYza0zcErQGhi13WE+cyi1zB1jbu9QGfVVAsRZ6PBXWhHp8Yu41v5uJwmHMAk/q5/u2XaxTdV9oz5J56XJ7GXmd9yXCpVc3r7VsMVcu3PFJJ1KGlwWagaq0RikoEcuvf/CPZdPHhi7fAK6bxyocmZW3lH1QNZenE4WcChUZY1En6hToJb4/0uLHvKQKzoWOBgD3RbiMz1xE2Aakot8VfIAZyTxbAebMPdv/AEIiEy9g/+6FpEZif69mTkdWnVe8aL2ob/QpwVFQQYyD9+XiDHFBHKYyvf0vn2k61YR0iNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wjEGcaKKHrwZxrYqekv8V4/qBCqF8kO+9Uyut7AT5Y=;
 b=WtX7A52hhYucRPMclV5nFr3r3IosyUaCSG5xBJfSAmoX7AYiczVgiyqvpR5aT+kSmRbc3GgyIXXi8zhWcJbfQiy0BDepDn1RrNlIYMAQqtnCS7OZ8mf+DvgNYBGiD4XhXE/J2+P0kri4CsM/5GfWxgkFx1VhxCcm0UhV2LeMovF6JaUyOBVRrFhKJHns0bBVD7orTiiE0kbqp+tGGqIxyVgZD2KJhk8Tk/qcoXLWecdYblDJDxg9CKLCNw6qRB0+At51E7Uqu8F4OLunzvnOruD/XF0SMZzm7lq5wg8aZKUUpp3I4J2Hc91KFB3ge1mgXmPGxyEtaOalxaFhItYVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wjEGcaKKHrwZxrYqekv8V4/qBCqF8kO+9Uyut7AT5Y=;
 b=mRnmOcAppWnS02nICVvRmMPXs46RFfritEupK/2CsNGdcDCNmBIhYKddbDNEzqUJWAekZtawfgwwnGLPtnGipkIO0cya+qbxwaC0sQbM2HwpOrdqTKh5BTXE35+o75F7HTkU9AbZUmuS0xstW+gUHntYlG3X4Jq0pBwiV1Kgzks=
Received: from BYAPR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:c0::29)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 04:02:17 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::8c) by BYAPR05CA0016.outlook.office365.com
 (2603:10b6:a03:c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Fri,
 13 Dec 2024 04:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 04:02:16 +0000
Received: from [10.136.35.10] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 22:01:52 -0600
Message-ID: <926692eb-8982-475f-b3ef-4409251623f4@amd.com>
Date: Fri, 13 Dec 2024 09:31:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] x86/itmt: Move the "sched_itmt_enabled" sysctl to
 debugfs
To: Tim Chen <tim.c.chen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Meng Li <li.meng@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
 <20241211185552.4553-4-kprateek.nayak@amd.com>
 <527d53cded892aea8f36b498ccd42f1bed0a347b.camel@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <527d53cded892aea8f36b498ccd42f1bed0a347b.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: b5027928-9a1d-49ff-d4c2-08dd1b2aef01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1VrSXF1Mmo4bFJ0dkRwUnhFMXFTKzh6QzJRSWdJS25vbVFrVmhCeDlLNU5i?=
 =?utf-8?B?cUhrSnNaUDdSOUY2eTdPbVk3Y3VQUm91OUZBald2WmtmUUpsaXQ1MVluRlJP?=
 =?utf-8?B?UzdjcUNyYitZd05FVnd6cEZ0OTlzanBmcis0MWpaYjNLVy83LzZ2MUhVdDRK?=
 =?utf-8?B?aEs1MkdYV0lhMTFuOStpcXlSZWhybDlDaEFOejlUQldLVHpWdi80Q1NpTFpO?=
 =?utf-8?B?RkNYN2NMbjFVNWpXUVFBVFI2ZmhFVFJmQU4rRlc4OVlDNjZHMVMwNHJ0ZlFG?=
 =?utf-8?B?OU12NVZjMlJxcmp2Skh6Ny9US29sV1lhMEdLS1MyQUhsbTRVaXZtMndsdThG?=
 =?utf-8?B?OWdxcHB5QVkxd1lFU3BJNFNvMjNCbE8zMzZtZEo5clFwdzA1Q2NkTlFtL3BD?=
 =?utf-8?B?NW9EK2N5WmJOR09KUE12NmUvWkN1bUhHcG9YWUJmQjl0NEhSc3N1ek5pT0Fa?=
 =?utf-8?B?VTNMbm11TXZxbGpYZmlGN2JmSUVQenNRQzNYN0tOWlN0R0p0REpFY1hleThy?=
 =?utf-8?B?SkVQeGFPR2dRN2ZPSmVON1NkaWQ5SzBpNnFBTy9iVHloOENHMFRsNjFyYnV5?=
 =?utf-8?B?emo5QkZUQ3RLclNtY3B3Y1VHZktlNUNqdW5UbFFMaWMvN0s4SU9UOElXdEt4?=
 =?utf-8?B?L1pscS9JYXdLSEJzZUluTkJyYnZUVzY5UEhORTEwbjErQ3pyNHQwQjVKWUh1?=
 =?utf-8?B?dFIzbWpuMXNxcGh4N2dxM1JnYmZhZ2Yvb3J6RVNJRkM3TW9NR3dnQ3R0TitL?=
 =?utf-8?B?WWVDOWdGc1Bxelk0cXJKUHVJTWdoem9wUm50UCtRdkl2ai9BUm5UQVYrUGJD?=
 =?utf-8?B?clhNaEJZZ0prcnl5VWlLaXp2OEVQeCtJODliMUxTOGd5MjFFOUgwV0VhaTU2?=
 =?utf-8?B?SWRjaXhSYkp1RFRRY1JPU3NPZ2M1M2g1bXdkaExEREpNajcxcTdPUlBnQUV4?=
 =?utf-8?B?eHZyaDNGTDBXRFpTRGpaeUFUcjlvYlAvcUwwY25hVEI1SzZqMEpSWVJ0aTBv?=
 =?utf-8?B?RHdWcVdnemFac3cyVENKMVFnbVdlRnFtMmFzY0srV3ZnK1dhYkpXZm9oblFw?=
 =?utf-8?B?WVdFeU9MbWNOTkNPTFJGK09NRk81QnJ6TXNwZ2lyWHdnelA3U3E5N2ZkU241?=
 =?utf-8?B?c05SR0h1eFNkSEJHZnZscVhmbFJ0N3JsaVgzZWdKK1dGRXRyek9PdkN0aHVT?=
 =?utf-8?B?MlZlS2k1RGhwazlaZFp0UmhuclJESU4wWXNiWWxWWmU4Vk03ZDVyT1FNcWtH?=
 =?utf-8?B?TVV3K1hkanI5cU82aTg3eEJJU21zUEpPaTl0L0h6VDZiT2dnelVLN3l2Zkt2?=
 =?utf-8?B?NzFDeVNVZDRpOENORGdEQ0JBK1AwMGwyYlpmTUV2WlJ4T0gvZzBIVlAzVFJF?=
 =?utf-8?B?K0NHWG1EM0xzWmI2alEzYzByVElWRE1mcVQvRy8vT1pQTmVSbG82MVU5R2Nr?=
 =?utf-8?B?aXRVNFNaTHh1Z3NkdExhNmFObDNHZDMxZndjQkdtdTRESlUvMmFCR280SFFN?=
 =?utf-8?B?RG9qaEhmdy9YVCs5d1lrM1RmYWJ1ZXpaMytjemhRbzhVbi9wMlhjQWdWcGg3?=
 =?utf-8?B?RWpWSVArbzlTNExFSVRVU1RUTTUvY2ZIVVFxZ1llNDV0akhQN3FIOVFEYkVO?=
 =?utf-8?B?bmlXcXVkYXhTdmhTOUkydkk0V21EREZidlQ4Y0R5akI2RDljV2J2OXJDejRu?=
 =?utf-8?B?R3k0bytCRnlHK2hEbEt4bTBuNnR3QWdRaEg1WjdVdno0L1JPR0R6V3ZBeDg0?=
 =?utf-8?B?Mi8vRVFzdytoalgxR0JqNVVjNk96M2tPeDd6d0ZXSEFuSncxeW1tdHFyaVA3?=
 =?utf-8?B?MmdFaC8wQ3djeTBjR0xBTHZmVjRIMUwrOHRxSHJGTHg1dWRkVXd4TWwzT0U4?=
 =?utf-8?B?MkdObXFJZ3RKT2U0ZmtYY0NlSE53WnkyS2tEUmdzZDNxdUZpYnV0a3R1RzVH?=
 =?utf-8?B?R3I2cjVqNkQ3akdMZGhwZlNYejdheFdQdFRMODBDR0IxY2xwQU5zTmQrTDBm?=
 =?utf-8?B?SnRIQWlGQnBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 04:02:16.7210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5027928-9a1d-49ff-d4c2-08dd1b2aef01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

Hello Tim,

Thank you for reviewing the series.

On 12/13/2024 12:45 AM, Tim Chen wrote:
> On Wed, 2024-12-11 at 18:55 +0000, K Prateek Nayak wrote:
>> "sched_itmt_enabled" was only introduced as a debug toggle for any funky
>> ITMT behavior. Move the sysctl controlled from
>> "/proc/sys/kernel/sched_itmt_enabled" to debugfs at
>> "/sys/kernel/debug/x86/sched_itmt_enabled" with a notable change that a
>> cat on the file will return "Y" or "N" instead of "1" or "0" to
>> indicate that feature is enabled or disabled respectively.
>>
> 
> Valid values of setting "sched_itmt_enabled" likewise change from "1" or "0"
> to "Y" or "N".

Turns out you can still use "1" and "0". Running:

     echo Y > /sys/kernel/debug/sched/verbose
     echo "sched_itmt_enabled: $(cat /sys/kernel/debug/x86/sched_itmt_enabled)";
     for i in 0 1 N Y;
     do
         echo "Writing $i to /sys/kernel/debug/x86/sched_itmt_enabled";
         echo $i > /sys/kernel/debug/x86/sched_itmt_enabled;
         echo "sched_itmt_enabled: $(cat /sys/kernel/debug/x86/sched_itmt_enabled)";
         echo "sched domain flags:";
         cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags;
         echo;
     done

Yields the following output on my system:

     sched_itmt_enabled: Y

     Writing 0 to /sys/kernel/debug/x86/sched_itmt_enabled
     sched_itmt_enabled: N
     sched domain flags:
     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_PREFER_SIBLING
     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_PREFER_SIBLING

     Writing 1 to /sys/kernel/debug/x86/sched_itmt_enabled
     sched_itmt_enabled: Y
     sched domain flags:
     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_ASYM_PACKING SD_PREFER_SIBLING
     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_ASYM_PACKING SD_PREFER_SIBLING

     Writing N to /sys/kernel/debug/x86/sched_itmt_enabled
     sched_itmt_enabled: N
     sched domain flags:
     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_PREFER_SIBLING
     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_PREFER_SIBLING

     Writing Y to /sys/kernel/debug/x86/sched_itmt_enabled
     sched_itmt_enabled: Y
     sched domain flags:
     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_LLC SD_PREFER_SIBLING
     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_LLC SD_ASYM_PACKING SD_PREFER_SIBLING
     SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_ASYM_PACKING SD_PREFER_SIBLING

Would you like me to extend that note as:

     ... with a notable change that a
     cat on the file will return "Y" or "N" instead of "1" or "0" to
     indicate that feature is enabled or disabled respectively. User can
     either write "0" or "1" to toggle the feature off when enabled, or
     "1" or "Y" to toggle the feature on when disabled.

for the record?

> 
>> Since ITMT is x86 specific (and PowerPC uses SD_ASYM_PACKING too), the
>> toggle was moved to "/sys/kernel/debug/x86/" as opposed to
>> "/sys/kernel/debug/sched/"
>>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

Thank you.

-- 
Thanks and Regards,
Prateek

> 
> Tim
> 
> [..snip..]
> 


