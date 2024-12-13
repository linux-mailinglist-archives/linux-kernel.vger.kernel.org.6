Return-Path: <linux-kernel+bounces-444264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E949F036E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD5E1887B18
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6A417C7CA;
	Fri, 13 Dec 2024 04:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vU8prkyt"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151DA1459EA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734063194; cv=fail; b=EXS9jxgQ/LjM7jItAmjwHnSuqYSKu4uFAdeia2RzO8e4SEqIKplz/trvjY9ubXZh1ndtN8biJHD1tUI+pmInCD6KN6v1YtJZF1HYmllY5iOQUwczr9hUJtcKkADgqtH9+xqAEu+X1CgbUZ1k3F77jH70I0kUmAQHau4yo3G6hRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734063194; c=relaxed/simple;
	bh=yHVXuNXtjOuP8N6LH8W2X3WdJINVUxRXLkYK/59uisY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GbqzHFBI0gsc7+oaWT2fmRweIGGUqYozcoXvi4obCPyYA9b3wCwqEyyfoalR23f/INR+CXX97/e0V699BZi4VOdrM0lnlOqUm4FMn54B+I1KlMw1PIpqr0ZJzQnOIb2+HXX9JlSZcbgSuUjJwfTLcBQL3saRJPiULlSo+5hH6NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vU8prkyt; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJU93pd1NgiAAyLXcSEtvL9G3JPIXGH7XSobakSYntDEtezr29hK9P9niZi8Ed9uI39clgXPbq0uCLiDdHPiFsinLOG2Ic9EX9UaJbwmYWhFvA9ToOx+kBv7RoyXY/d8lS67tAb62iD0K0Wov3VYdlG0FYDm00qP2npaxRpU75tMAFcOc9pbioYOm6L8XE3PC1gl4r8jL6/GA0+ZNYDUaIKw4USkps/kM/FkW67teR7POcg5mQzGb8U+rHNKNasbEmO546YzD5t0iEEpO36PKDqJZZxGYHaVACaLKi5ChdVbQiz0BuyKqzeFd7RetauFUibsVCTYqzOy1xioyxBcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nf2sWNOIbShvbKVKaAzKQp/hj8NX/Lx+Q3fDOnteUhY=;
 b=AZZZqx57HTR+2Tsy8YrKt9XVc/jSUz/0SK0dplXLj2pniWcQ1hLiDaZvyfnB0QgaKy6Vp4zLY9KNZ5mtZZfOugoLniRbcETUJjVeQb3+BY2+ehhmVB/Xmp+Kfs2TTjbqleSltl/htvg3b06+Vl9gYl6J/mHYFubSJusfOZzR9SthexzrTl9FIf5IEUm2P7WEJvXieH8a1/yZGctWR6ScP/2nl6D9926ER+mYFkpj5s9TlB/hD3O4rShsyJONtmS9wz7rFNyrezwhWdrzo5f2tz9bbrngNPQA0KZswes7VOS+QnOGjUUMY6Uhr7axPX8V0DcV09r/bYVAxbQdbDNU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf2sWNOIbShvbKVKaAzKQp/hj8NX/Lx+Q3fDOnteUhY=;
 b=vU8prkytEHtUgGq9uEyF+q6v1fKHsXdgpzjT5RlEwOYz2M7leUiMYAUeHynzQiWp9Ym0cTY+08oCaAYEHYi+qr2UTfCcFTD5FJ5vECDl89kE/SE0gYT+H8aulYcOz9FaOc7Z/I4fBFqsDzcDTS/CIyGtD3vuI/WYlOdmbML8/Q8=
Received: from BN9PR03CA0245.namprd03.prod.outlook.com (2603:10b6:408:ff::10)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 04:13:07 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::53) by BN9PR03CA0245.outlook.office365.com
 (2603:10b6:408:ff::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.21 via Frontend Transport; Fri,
 13 Dec 2024 04:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 04:13:06 +0000
Received: from [10.136.35.10] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 22:12:20 -0600
Message-ID: <ab1b16a6-766e-4cb2-8ab2-ab6d942a5889@amd.com>
Date: Fri, 13 Dec 2024 09:42:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] x86, sched: Dynamic ITMT core ranking support and
 some yak shaving
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
	<ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Srinivas
 Pandruvada" <srinivas.pandruvada@linux.intel.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
 <ddc249fc658b394f39b23e3ff0fa7dcbf2060695.camel@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ddc249fc658b394f39b23e3ff0fa7dcbf2060695.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: 6816c63f-a4d1-472e-f04d-08dd1b2c721c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUIvRm15TkQxM0h5U0d3bzBSTmg1b1I1cjNXeHdwbk1OaUZ1T2NZeXFjZWR1?=
 =?utf-8?B?QlQ1TzVBZkVoQ011eFRHNVNhT3NvWXQvcS9WSDV3TE9CeUR2Zm15L0lmSThh?=
 =?utf-8?B?R3FCWFR2cy83KzY0S3R3T0pYbDZCb00wWXJ6MDBLclZnZVEyc3hVS1RJMTRH?=
 =?utf-8?B?bTAyVWs4OElqcXRGdHRNZHpDeFZDdm9BQk80WEtDTTMwZDN5U2lPK2kyRWxy?=
 =?utf-8?B?ekROSG1oYkZFQUt0VytOMFpBUFQ2K0hwNzB0RGY4eVNjeUcyZ0t5ME14SS9M?=
 =?utf-8?B?eDVnM3k0THJCUG41Q203MFFrQ1NQRVZZSXhWRFovUW5EOU0zZFhpUTlOVVll?=
 =?utf-8?B?VjFXeSt6ZFlSM1NRaTJEb3doVEt4eFk1ZFR5a0ZjUEkxMEhqZVFwVzhmRnZm?=
 =?utf-8?B?b2Y0WGwxYlduK3dtajlPUGxCczhJU0xmR0p6KzFuV3drRkdLaUgyalhyODBr?=
 =?utf-8?B?NkhIK0NQYXAxMjltWGxxZE9DRk5ickNoOXJob1phYUFvRnpqRjlNOFJEdFpw?=
 =?utf-8?B?M2wvOENJeUVmdjA5TUswaXg1Zndqd0UwSXJ3cHVlSkViWVM3TjIzNE9ZUVVT?=
 =?utf-8?B?elNHUll4MlQ2bnR6SThkQXBYQUQ5bmFXb1dTbUo1WWVWMitaZUtlYVBWSW85?=
 =?utf-8?B?eWp3QUMwZkpGQXdjUzBoYStzdkxwWnRJNE9jM0RaNXhldXFFR250aDJNQ2xy?=
 =?utf-8?B?Mm5rcVdxT0JaaXcyTlJCZWJHSG5rSkp1SmxFOGpoZFlXakZqQVJpRjVtRVcx?=
 =?utf-8?B?cngzaGJYNUxEbjd1eENORUVJU1Y5N2duK1ZuUUFHbzFZOWVGbE9VRnA0cDBB?=
 =?utf-8?B?eGJleHd4QURpN2Q2MkRTZTRNVFpKRUF5VXpvQng1amUxVWNxYjc0dVk3N3ZQ?=
 =?utf-8?B?ZmgweThBVjZ2RGpBSklVSkk1d0s2UmVIc3RmVEZmVGlJaUZsY25GZ01MY2RY?=
 =?utf-8?B?RzhzdllLK1VuUU5xeDNVMnJqZVFiN3NWdk5SRjF3Mi9kUDBCYjJlOFdaY0g1?=
 =?utf-8?B?c2hvSEVzbUcrZ2tuU3ZndVdvbTZvcFFvSUJzUGVRRHo0cG5hakhpYjZtSWlI?=
 =?utf-8?B?c3c2Qlh3czYvcUI3bnQ3Z2RDWFlPSVVDeXV2QU1kWmVqNTBpZXhhamIwQXh0?=
 =?utf-8?B?YVo3Zk9mVmU0aTBhSlpsZmJybG1MbTlDdnFzbFBqU0podktpNTAzeHZsc3lw?=
 =?utf-8?B?Y204dWFIWmRRdzNxRUlUWVJuZnA5R3ZDMVJqV2dWZ3NDcUdua090OUZXRHBj?=
 =?utf-8?B?a3pTTERkUFlGeUxsTlFzNUtQWFRZeW1DSDFoVHR3RGFmUHp1bHp5alNSZzE0?=
 =?utf-8?B?UGFnUW85WjhZZUw3c0Zob3ZISHMwRzZGa3JGaHpXQUFBdkFLdVViVC9sWkxv?=
 =?utf-8?B?VklLZmFBT253OUpzcG5KeHJZdTN4WkptaWZNZDZuNVU0YTZMUDQ5RHpFbGlP?=
 =?utf-8?B?VG1STEtpZlRCN0FNQkk3MnV5bEFmRGw1ci8wRVlHaXN1T0ZFS1cwQ2dvQUhC?=
 =?utf-8?B?cnRvbUh2dGNDeDVhNmpnOHFicEZiYjhzZGdFWjRiamhCNFpzYWtTdC8xMko3?=
 =?utf-8?B?Yk5lY25mZnFaWnhqRHNvNWRDRjRRREU5WW9Gcmc5QmxlT0NwVitybUg1NVEr?=
 =?utf-8?B?VTliSlJibDJtWTd1VVNiTlYyZHV2R0VuNWhwM2ZlTUdwS1p4TGNxT3VSNjlr?=
 =?utf-8?B?eVUzMXFpaHNYYU1sbmdlSm82T0pWeWZjN2h5SmxIOVhiTzdFZHVpMytxa1dC?=
 =?utf-8?B?VVd6WlRBL3ZqZDlOMldKUS9JQXBVdG8zWEpjdGlnaDZxZkdXbi9qanBUUmhW?=
 =?utf-8?B?d3g0Qis1QUwwRmFWcnVOeklNS2UwazN1Z1NKbnVWUjFWWklnUkQ1ODR5Uisr?=
 =?utf-8?B?ODU5M0V4UkQ5aW5PaHkrWjNpMjR3aWYvMkk0ZjE2NkVYOFk1UENEcjZTemJa?=
 =?utf-8?B?c1hBV091aFlMcXVCMFBRdXowdWVHc3QwN0FMRi9tdU9DM1FhcjdnSmZiZXB2?=
 =?utf-8?B?UjBEYlFod2N3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 04:13:06.2863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6816c63f-a4d1-472e-f04d-08dd1b2c721c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083

Hello Tim,

On 12/13/2024 6:03 AM, Tim Chen wrote:
> On Wed, 2024-12-11 at 18:55 +0000, K Prateek Nayak wrote:
>> The ITMT infrastructure currently assumes ITMT rankings to be static and
>> is set correctly prior to enabling ITMT support which allows the CPU
>> with the highest core ranking to be cached as the "asym_prefer_cpu" in
>> the sched_group struct. However, with the introduction of Preferred Core
>> support in amd-pstate, these rankings can change at runtime.
>>
>> This series adds support for dynamic ranking in generic scheduler layer
>> without the need to rebuild the sched domain hierarchy and fixes an
>> issue with x86_die_flags() on AMD systems that support Preferred Core
>> ranking with some yak shaving done along the way.
>>
>> Patch 1 to 4 are independent cleanup around ITMT infrastructure, removal
>> of x86_smt_flags wrapper, and moving the "sched_itmt_enabled" sysctl to
>> debugfs.
>>
>> Patch 5 adds the SD_ASYM_PACKING flag to the PKG domain on all ITMT
>> enabled systems. The rationale behind the addition is elaborates in the
>> same. One open question remains is for Intel processors with multiple
>> Tiles in a PKG which advertises itself as multiple LLCs in a PKG and
>> supports ITMT - is it okay to set SD_ASYM_PACKING for PKG domain on
>> these processors?
> 
> After talking to my colleagues Ricardo and Srinivas, we think that this
> should be fine for Intel CPUs.

Thank you for confirming that. Could you also confirm if my observations
for Intel systems on Patch 5 covered all possible scenarios for the ones
that feature multiple MC groups within a PKG and enable ITMT support. If
I'm missing something, please do let me know and we can hash out the
implementation details.

Thanks a ton for reviewing the series!

-- 
Thanks and Regards,
Prateek

> 
> Tim
> 
>>
>> Patch 6 and 7 are independent possible micro-optimizations discovered
>> when auditing update_sg_lb_stats()
>>
>> Patch 8 uncaches the asym_prefer_cpu from the sched_group struct and
>> finds it during load balancing in update_sg_lb_stats() before it is used
>> to make any scheduling decisions. This is the simplest approach; an
>> alternate approach would be to move the asym_prefer_cpu to
>> sched_domain_shared and allow the first load balancing instance post a
>> priority change to update the cached asym_prefer_cpu. On systems with
>> static priorities, this would allow benefits of caching while on systems
>> with dynamic priorities, it'll reduce the overhead of finding
>> "asym_prefer_cpu" each time update_sg_lb_stats() is called however the
>> benefits come with added code complexity which is why Patch 8 is marked
>> as an RFC.
>
> [..snip..]
> 


