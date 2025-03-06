Return-Path: <linux-kernel+bounces-549905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECFDA55866
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA3F7A5D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48372702DB;
	Thu,  6 Mar 2025 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RbvzVZed"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFCD207A0E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295447; cv=fail; b=M5LHVaNGY4mop05QDvgmpa3TndvNo+Ysk81VBGnGJ4yjHeOm2TUz7lLF2RbamKiUGJ+czybJBuznCtDSFphUrC4YLcvETVGSM53DMiR1tcd5Krvm+cGKea2XgpVsJL9jrBL/BoeYwfT+h29MDdpOAWo/2SbMagjMvlEITesYse0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295447; c=relaxed/simple;
	bh=Jzx8W/jfB+0dYCdHLcY5C4boTuIujXh5Xvuy8DTaS+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W+umIioNMcIOWx72RakqyOvpTgdApZGzLOCFtXkQOy1dMavw8cPfNASfiNBl8TezNN+AgyqvouG30Mi+0h8ewyt1L1WkEd+6av+Hix/NxjvrIoO2Jnuw1up/t3tOurASUs3M1KpUljjBmvG5xJniWJEKCdxaNhpEbUJGnORCCkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RbvzVZed; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKhnTM74B0IUa1CicYXP7QjZVY/t95rPIRJkXVkJ3hrxoICkie6bavf2VmwvWD8f5xIfmbEL30RFa6JUzYwI9h+tuX2oEk1H7AwSxdyeU0JZCw04PxowP2fCnTKERmkD90ggvfnZaDLbClsMPUQMVALYNxEwSROzJgwpEyvzHNgEMWlCZ2q2tERgEvp45TYhQW5CKXcjHugdZ//Am86w9++8HP1UM+rChftvFa8P0dqNvuEAlUPFCxzF4nujTH6Cia8uk97R/qIshp7eq3CuYlGMOrNDmy+AtoQGINUfJCuwN8PljOIo+bSLpoJqlKsMEjjdlYHDn0YoYxbApWBKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jzx8W/jfB+0dYCdHLcY5C4boTuIujXh5Xvuy8DTaS+c=;
 b=nhPg+YO2v8ilJmVnLwH9TXVXZvtKchjVYEdXBgD+W+6ldz3oQkWFdxuNd3C9AyA9Vgl86ArjCFKEH808XFQ27knHdKuLFngaUls2hK1uc1mdZFORKWFKetW0fC+7lusTJJCv4He0XSkb/Xxw3+2nXd7OFfTs6gwMZbFlttIlDdCgnXFPwnMn/V0c2BRzhfc+jJDiQSLaAWGusRA5zQA1i8bFTRntKsEmt8/G4MWBt0N7xWl1VbPBrIpi6L0O/efh4V2hnE+MBMxeJdJoA98Mqax5D4mTNl3WFV0/YhYeOgoGG/1luNmnSTsmvS+SHaF2CBLrLT8FvgOCUB+cU6i1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jzx8W/jfB+0dYCdHLcY5C4boTuIujXh5Xvuy8DTaS+c=;
 b=RbvzVZeddiDdrMXJor/mSuqPBDpD3UaLoKaG9qdKQV/+gg4sNmfR6A+mTYs8sCXgFio2wZlc7V//EnOQdpWcde25yCRFny+8dO7TjirbLKEafO/A7N5abIx5B+SvntVkHkyT88Pu/L9rowXpUZP0AoF0j47WQG3mvIM/0nFrVqumNA7602f8ZTRmJ7oM+JmWP0E49+cdzsvufpdok9RtZaSlIiIluFK11HhuIDQtCMlN2+8EdXWZyY7dqU8M7KynpxPjEPHe/Bx6k8b6W4t1fkxWG6AXXlHpTADdyO8wIt1QOlHbmrXlKeu2YkYd9FrlZ/1ee6MJD1ykP/RDUwtZFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 21:10:40 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:10:40 +0000
Message-ID: <c31a258e-81b6-46e3-828e-80b565059a66@nvidia.com>
Date: Thu, 6 Mar 2025 13:10:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/49] x86/resctrl: Add an arch helper to reset one
 resource
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-15-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-15-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc3633a-5670-415b-bd36-08dd5cf35928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzJYUmZ1WDU2SkRZeklTYkF5V1ZRUElvU1U2REg5ZXpaZm5rZ0pIS0I2Ynl5?=
 =?utf-8?B?cGkyZitPODlvY01ud1Vod21PbzJlTUV5anhHTmNWWXVDYUFuU1ltR0JkdXAv?=
 =?utf-8?B?VnR4U0FkVmVKZ2NUeEpxQTd1amQwU0h4elhhRjhrZGpIOEFvQ3cxNVdOWmJM?=
 =?utf-8?B?UUJDL1ZJdmJwejI0akhDVVNIQTFaVE1Na3RvMGpHdkZxMUtZQy9Ta2RaeUZz?=
 =?utf-8?B?c3VDS2J1cVJOK3kvMDNHMjlRb092UWUvOEZwYTRQVzVhelgrWEtQQ2hzK0c3?=
 =?utf-8?B?dnh6NWJSM0lOa2VGelcxM3UyeDFYNVVwU0krdjJ2MjBKdHFaY2k2VC9oc0Vo?=
 =?utf-8?B?WkF5SVdDUVdieTU2RFRmVER1WVdBZjFlUUV5Uk9SUXdacklLUjNHbG55amVI?=
 =?utf-8?B?NXZ3SjZoMnlRVEYwZW0rNnRMVXZ2TmVjQkFzODk1WmRjTitTWERwb0taQTlV?=
 =?utf-8?B?MVJhT0Y1Z3FhRlVlLzZEcStiUG9mOUlHc1I4UlBlMVJSekJUWCs2RDFaaDky?=
 =?utf-8?B?SE5JOWVXc2xLMjdES1VtTTRWdW5adEV3dENjUTlIRHVHVGRlRjVsZllJUzUw?=
 =?utf-8?B?d1FOb2dxdDdrREsvakFvakt5NVVHK2xsTUpUZHdyU00rbm9qQkN0YVlJSDlL?=
 =?utf-8?B?ZTlDTjBWa2xqWm8rZmM0U1JyU01CRDdscXlIVEpQSmZITk90dGlxdVJpZm45?=
 =?utf-8?B?SmxENW5jb3BLL1ZhNTA4VjJ6bWFuaVh4WWhNWVhhOHZFd2pYZDFHcHAzeWth?=
 =?utf-8?B?MllkNVFOa1cyc1dUdlJ1c0JlSm5lNFF4RFFNdXBMaGxmMTdlRFVYOXR1OGpJ?=
 =?utf-8?B?RDF0a3I1K1lZT0hYVis3NmxiZjBqNUNuNWcxZXhKWGJsS1J1dmJyeGRoQnpt?=
 =?utf-8?B?b0Q0bldyY2lEUE5CTHRHL0w2dnF4NjZPWHF0bzVlTFFqTmNlY3F0UzVqYVVL?=
 =?utf-8?B?MENZSDl5Y3FCS0F5bGNhR3RITnBuVWxPcXJLbi9IelZqMmYvY0l1cDRlbnVY?=
 =?utf-8?B?SzBZUGJKMFc4RXNJeFBzYllUTHBadldnSTRWeE16alM4MVg2aFcxdVd2cjVS?=
 =?utf-8?B?Y1VYMlpDNE1BY3FBT2s1MFZNdStXK3RKL08yRmFNQ3RET0FvYlR2QjE2ZDVI?=
 =?utf-8?B?bk9rdTVJSE9LVVhEdHViUTROU0gxYlptWDVRNThpdnJjdjRnWUxBcEFpcXdr?=
 =?utf-8?B?VWVxRmdHQnRzc0JLY3JMMFJiYnVWMVkwTTIxZGFwKy82Sk4rUDJtcnI0SjRl?=
 =?utf-8?B?VnRuQVVQeW13TVpMSXUwSTNHd29MNVRqY3g0YU5Icy9mNldNV1NlajBhUXN0?=
 =?utf-8?B?N2FRcFRnaEJSZC9nR1hXdWVOdUVVQVZMMHMwenVRYjU3TGFCbnFyRVhjSTcx?=
 =?utf-8?B?VjlpWkxDOFBRSkRZUWpDa3NnZUsyMWdLd1VvYlFDV1VOMDA1ZVpjN3lnN3Na?=
 =?utf-8?B?SnNtYXlPUmFPckdReWZrRWgzcjlWQ0xWVHBzMUJ2QlRZWTB2a1RrK01Dcko5?=
 =?utf-8?B?NEQvYjltV1daSzZCbThNdEZiSEU3WWpJcGdqcjNtaEd0ejJ5UTFUMmVTbmRv?=
 =?utf-8?B?SmFrVmN3NlhHbWlvOGFQVWE5SlRCRGx4UG5HOWU2bnVsKzNHb0s1andPWWpB?=
 =?utf-8?B?emViUjN3TmphMUYxKzRhMTVJaC9sK1hYWDVsS0JPeHN6a2tVQUI1UjZmWmEw?=
 =?utf-8?B?alBZL0cxUFJocngrMGo5Q0VqYSt3L2dlSVJ1azM3RzJFQ1pEaEh1MWRhd1k1?=
 =?utf-8?B?NER6OFdVY1NzenFqcEVhM2ZER3dnbzBndG5jajVLVWp6NGlES0pheTl3dlpu?=
 =?utf-8?B?WVRISGd6V3NXNGdCMGZpNUIyeDQ3aDF0NEM0bTZTTVZBbHYwdlRQbDczQ3Rq?=
 =?utf-8?Q?Y9gRrwZS9XIVa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHl3bTVOd2h5LzMzWUF6V1laVWM0cXZEMUJKTlJlakhZcTZvaTVwT1o0eUVH?=
 =?utf-8?B?cVpNaitxL0xNcWp0cDNTSWJiVEN6NWdPNTVzV25va2ZNM3F5aHlNTlBNckl4?=
 =?utf-8?B?Mkg3UWh4QjhKNU45RDJzOGZnbkFCYURPSUtjM2o0UzMzZC8zRC9aSVpnNW04?=
 =?utf-8?B?OHdUVmVFcE1KSStaYjJ3dzkrTXlVdXUvaXMrRnNmTlQzOTlLYlRJWkJQRlNK?=
 =?utf-8?B?aTJkU0RWVWIvUkV1NTRYZlNTenhSWC9pWVVJZHRKc0ZBYzZyVVFudUc1S2VM?=
 =?utf-8?B?US8yODNmK0prU1BTUEJsNEpuUi96eU56cjd3OXlRc29ONGNFd3hhM1lTZWRm?=
 =?utf-8?B?WVFuOHVTOVpUbDZhUDdraGhod1I2Ym5jNEVnaERDVmtmR0laMjVBanJvc1Iy?=
 =?utf-8?B?NGZBOHRTekFHaUtDTWtXa1NJWWJ1eVR2MWlNb3JoTUJ5dEZ3elEwRjFNQm9x?=
 =?utf-8?B?Qi9CUWl2YityUnVkQnNkVkE2L2I5UFVjNml5QTdVY1FiVjhzS3hYMXp3ZHJJ?=
 =?utf-8?B?QWZlMkNYQnM1OGcvOStnNkFjTERnclVEV0dxQnB1c2Z6SHhBK3FnYXVtYnZk?=
 =?utf-8?B?S2pWMzNQSmh1dnAvdG12NXRRVE15cFFCMzB5b0lXVUNGZmtSRnUxOGNDVTFP?=
 =?utf-8?B?TGFOQUhPNGZJeW5QYkJWTWk5SEY0R1dWZVVFRnV0SFl2TFFBeDA1M2R2bjU2?=
 =?utf-8?B?b1B0dEVWNXpWRmRPNEhxckVPMkJnQTBydUxCYjdCZjlOdC9IM1g1YVhNMzhq?=
 =?utf-8?B?K3F4STVJRm83STNTemtrRlM2Rm5lWmhHMm1IaW1aM21zK0NIbGRnN3RHYjNy?=
 =?utf-8?B?eUlxNWJjVVNZN2FWeGNoZ0s0M2VUWEZ4ZHhLQVRNK1Q4d1pVa1ByRXFMT2Ju?=
 =?utf-8?B?eng1d0UwbkVxS0VHaUVHWlNGUEZqb2treWJ6Yzl0SGo2OE15L3JRMGhDVjh4?=
 =?utf-8?B?Y3BvN3ErMEhEUFJSNjNMTjhIaXBFME5yNWcxNlFpZUNxelNCbGNDWU9TY0t3?=
 =?utf-8?B?QjA5TzFvWDZhT3gzMElPMEUrbEU5OHFPaFo0U2tLMm1GMDN2Uzl1RGg2OVZq?=
 =?utf-8?B?RVI2dlg0em42WVVQWHI1MDVQaXJ1aUU3dFVZTzJhZVdLOWVkdWVjdnBJTWU4?=
 =?utf-8?B?cXkrY3Z1V3VwWFg5RkhTMWkvcWo5cGphcEJzY0RZRWdQVHRFYkREUXkvY0ZY?=
 =?utf-8?B?RXBGU2Z0cUxqZzRuOXFKM1hNd01xVU4vZXZtMHZ3Zitwd0NPb1k4THNTSGF6?=
 =?utf-8?B?Ukc0OXRlTDdLQzlPSHhvMjE2SHdWZjVDR3JhMmZUQjlzRWZWdWFxSmRFNnky?=
 =?utf-8?B?Ykh4cXZBZHM2QWVXbDdIWlpXZ1B2anRWb0lMc0p5cVJRQ1pwL09tVEltalhB?=
 =?utf-8?B?UEx4TGhDbitDTDV1MGdxNUVOMHNxbmd0bnNVOGc3NVJQMDZNZFJCaXFhbFRM?=
 =?utf-8?B?cDhhUGJ1ZnVNbnA5KzNYTmF3VU01ZlgrRjVEZ3VrQXdVanNFdG9lN0dwTWph?=
 =?utf-8?B?QmNjZ043L3hlbXpqUkhEUkpNbzNiRzNqWmNDZWdVd3pqNGRxcEh3TzBpNkJw?=
 =?utf-8?B?bSt6VlU0NmVnLys2UVF4N1BpNDdITVg5aldISmNLNjNxclJaYmNBT2Q4bEZY?=
 =?utf-8?B?YzdyR3pGM1NDS3JjbGZkTU9SZUhVdGVxN2dTMjJQY0lCNVkwWE5QeGdRRmFm?=
 =?utf-8?B?NnRTVk1ZS05Ea1V2NW9XQXY1YlF6NDNoaVd6eEI1VmpnZ05yOWxERVE4UGly?=
 =?utf-8?B?OG93SEFWdTRNZnlFR2lob3ZicW1QbnlJZmpzb3F0VlFhM2pzMEZpUG5xcEcx?=
 =?utf-8?B?SGkwQzNSL3Mwc0xQWWFmRXE1Y0ZSLzkvNzdkVGYvTXZxQThVaEI0UG92Y0tp?=
 =?utf-8?B?UkJwZ09LMGVCUGFxN21KelJkQ3VLL1VTbXhoaGVrVEFPY3I0S1MwZHh4cDBV?=
 =?utf-8?B?MHNIOGdhZ25kSEtna3FzTFY1ZFFVREVzYjJDYkdhamFJMFhMbFJ1b1JlbEt0?=
 =?utf-8?B?MC83eE5sYjQ3ZTgwK3VqV3k0VWVFM21LSGxyZEZidFAzK01URm80K3JWSEYy?=
 =?utf-8?B?Zk9MRlYyeTc5ZlRZd0x6Qkhlblh4RTJNOFVkckI3U3hkVHBaMnJTNFhRUWR3?=
 =?utf-8?Q?zdc8RW8SfLR5CKEWzi0AZ497u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc3633a-5670-415b-bd36-08dd5cf35928
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:10:40.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YM+B+C2e6RfiBoHgZhtXqvogFrNTXwTqckhFYqrcQNqR5yEnN1Kq6xmRPTdr2KA8CipVxbD8wG5LFjw3+39emQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237


On 2/28/25 11:58, James Morse wrote:
> On umount(), resctrl resets each resource back to its default
> configuration. It only ever does this for all resources in one go.
>
> reset_all_ctrls() is architecture specific as it works with struct
> rdt_hw_resource.
>
> Make reset_all_ctrls() an arch helper that resets one resource.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


