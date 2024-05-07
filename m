Return-Path: <linux-kernel+bounces-172258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A858BEFEF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB921C2184F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FA67E58C;
	Tue,  7 May 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RAEnUL18"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC68578C76
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122213; cv=fail; b=tuqbPlzzAz1UWeF4SqARIv374O1GtcPYsO91cf5vuoJMIsSgafe/xaeiq0JmFIa11WItjfq2I6C8hlWHKtxOflta9n/m+a5JLDRX8wqwAgnCgU5LxfN46c5ID1ourDNNhEPiqgsvcuuqxUldMJ2zF1M+Jt9G7RjuOB/05l/1h8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122213; c=relaxed/simple;
	bh=hXQQKBufbH+l9m+NLh94hRkDG1+j9xX7Li6d6XTz/RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U5cOIKmXHHj74ocYiOY/+xVJK6NU0dvZ/R1+gI0mQ/uvDYFcaBZdALL3VKmJx/9l5vXMhPzrlQIezk/wW0v/+t8KV7l5BhaM5Np/ixtc7YyHDxPrwE3u7WMhEvcFjaF52z0pRxrsUr+D1LQAtw2VSsTq5KB6CX/RPKV8FM6TwXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RAEnUL18; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI2FUSM4BPz4WJ2BfDr4fUF7a24PXWllpnfJY6ICcqW4YbeURwM5DccCpyfJ1YzNicLavUnTc/oxrMXgvTJA3a24Ndlg6vDdYV9KIwy6C6tpDTaanM6hzVkPrqXtNmZNkcePbt37fr5n10anit6C0BixB/Dk9/1EJYCzMezaBsCysX6pV4DT0KwxZjJ4PEiPjM0hCEsuReGI4IzwLosmpceWQcCc07ZrW/xs92ej7CXZRGNZnUUGXY2WnNMsQbEeMj0PscVfFBk6Z1NW/shWxO4a1WA1uAH8//1ZW+LtLUYyRb4EJv7l39DaJTjWWPZt0jUfezi3bzg7g2pqPlYYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI1z2gIxnTKJlvtF1MCuc5t9jD0AvTAaJDeblSXIkfI=;
 b=hTxrOaePQEwd1MzrZxiom0veb5tG/BJw/b2vmwyGynxWQ6PALdc4YSHw4aMktFT9rbgUMDFIvzp/dAWDHSQXZ6oe6zAYP93WSBvT3eaFfhSU8+RZLbaQtdqNsEuS+TF9EGR9cZ1o14yFgncLVn8M1x+WfwM9vVD1OMw2VnpaNIWr0aN+6BmaxyBditdR/FzYWzYl/gwPE5Do5qBe7OGJTbsqks7M37r355LA3kbnLgKHp8vvpihZDy9mjKpICdEd/e6CWXyLlBpU0Bv5hnRdRMmDtnZcqo19gCsw9uJ5Jm99MEmXM4g/+l4+MlMkKrP3dvCuECcac0g7uE1pdNvplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI1z2gIxnTKJlvtF1MCuc5t9jD0AvTAaJDeblSXIkfI=;
 b=RAEnUL18aULHymb1zf37odMiMyV0guWQUHnvmfvDZIB34t9OQFWIxvrxJufMdX94F4Xd91zqpNjDQZG8C+ZoSSqkP59dKXe3nr/wdU5Ics2ePLT+EqFkTpSZqnh69NGfYyk+rb72PfGElC8CVOZFV5BPlU6ZCm4OQbtPny3RYHUfs87PZm/ugo7OSJq9dR0YJXvdRkINtS9Z9SoXodGEvNhnXQtEMpXgdX0N/3Kq1V624SlDkdHBMTptVdqc/myk1fs3hnBeY1ygI6SuVeGXjfAI5/UAlgouSael4RkAbnKKx0wTqeI4UPxEwTDk7Ae+Jf1VXmeFxe7xOoxfJyFSOg==
Received: from CH0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:610:76::20)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 22:50:05 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::9a) by CH0PR04CA0015.outlook.office365.com
 (2603:10b6:610:76::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Tue, 7 May 2024 22:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 7 May 2024 22:50:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 15:49:46 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 15:49:45 -0700
Message-ID: <adfd804c-a3a4-4a07-babb-0a957dafac4b@nvidia.com>
Date: Tue, 7 May 2024 15:49:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fault: speed up uffd-unit-test by 10x: rate-limit
 "MCE: Killing" logs
To: Axel Rasmussen <axelrasmussen@google.com>
CC: David Hildenbrand <david@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>
References: <20240507022939.236896-1-jhubbard@nvidia.com>
 <016d8cff-efc3-4ef1-9aff-7c21c48f2d69@redhat.com>
 <302d50ac-45ff-470e-90a0-b349821706a6@nvidia.com>
 <21d88422-7378-4a63-8fbf-f70889f309c1@redhat.com>
 <CAJHvVcgYsZJ3Hm1Hpc1pifH49uVniAedL-YxUpS8q7=Y8veZ5g@mail.gmail.com>
 <cf7eaed2-6331-45cc-a66e-76abb5448afe@nvidia.com>
 <CAJHvVcg2FQCGBwm0Y41YGgpMYKs8_KJaonwyDg7SPuQipxqH2A@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJHvVcg2FQCGBwm0Y41YGgpMYKs8_KJaonwyDg7SPuQipxqH2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da8d038-0d9c-49f3-cfb8-08dc6ee809eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTM1Wko1VVVwb2duOEdxMTBqYTQ0TTFXMm5nVEJlS0NDLy80U3puVHd0M1ZT?=
 =?utf-8?B?blljeStYaENFQjFKK0x2eldrWGNnTWdzeDFRclJZRmg2cE1tbEdHNGxRT3Az?=
 =?utf-8?B?bmN6czhPNExlcU12WGgybDlSbEJDZlF0SWwvdWNJNnpGVk52M2dnWWZvQnhn?=
 =?utf-8?B?RGQvRUUyenJpaUJrRjBVWE44MG4zQ2pTNmFwckJNQkptd2NNN21CaHNUNnZw?=
 =?utf-8?B?RnFJS1FpVmg5R2tTMSt0OW4zSUZjWEx4ZmhzdS9nYjJ0UnkwcUZOR2tHQUVU?=
 =?utf-8?B?ako4SXdRSE9pUUN3dFpCVGZLWWlkSUZCTkhjYXBDY091RW1FaHVad3drclhx?=
 =?utf-8?B?cFNWamI2YjNHTHluMHpmbXE3UjhhQW1LcFhaWUJtVmIwWW1Ec3VMQlFxSEhv?=
 =?utf-8?B?SmtpbG1UTUsyRm1nQ2VQSDNSMkRBRk9WMnBRQVprV1luMEJ0VkxCY2lEWWxZ?=
 =?utf-8?B?N0VnMVEvYVRadW8xVndZWjFVR3luOGtUTXlYN1FScW9BZzZ6Smg2Y09JejMr?=
 =?utf-8?B?Y0lZbWlrVlFoQnE0NDd1M2tsQVNDMURmYVdXVlBjeVRUZWZXZ2h1RGpKZ1Ez?=
 =?utf-8?B?RFhyUFNpTHl1a0hXZ242MU1vczVXVHRJS0lhOXphc2lCc1JUV2oxeTM5cGl5?=
 =?utf-8?B?VWRVV0ZvRDY5WjBub3lBMTFiS2FidDhNa2JVWGZQMDdtaEt6NlJmR3hFeXZF?=
 =?utf-8?B?c3JDY0xFemlkMlMyRzgwNU90VlNRdzBaZEhJYWN3YUExdEV4VEVBQ3FyUlNB?=
 =?utf-8?B?bVNuYTUrVEdHL2o0RFNLRExrQUJLYVFhOGx6WUVuTEhYZGJFWVpKMmlCY0pl?=
 =?utf-8?B?M3F6WERPaXNPOEZ4MjdWZDFObXVwSmhpMVdmOTlsbnAzQ1B1cFRSR1dCQUVQ?=
 =?utf-8?B?aUc2ZVFFR201ZThZSjJtbmV1TFNzSUw4M3JlYzh0MkM4djVXZ1dkR1NldUJP?=
 =?utf-8?B?WllKeG8wZVMyaFZtamJFcGY3ZEFPWDVpaUtoM1Q2emZ4U0pRWDE2Y3NtcytP?=
 =?utf-8?B?NlBxUm4zT3J4cmtaRUhMYVdwMmRUNllFZG91WDFFUEQ5ekwwT0xmRG5LcXpM?=
 =?utf-8?B?L3VGYUFZV1NiNUt3NGF1SGNxOG5XVytJb1FaSU5RSjRHZHVjZlpickpuNzlr?=
 =?utf-8?B?UTEvNmNFYVVOdDZXbWp5Q0hWY1lhNFdxRXFjTWc4dHd5NklBMzFvamp2bTV5?=
 =?utf-8?B?VWRvaGpkM1FhUXArTkZFdUVCeE9yY1VtUFNtR09QVHI5aUhvSVNMdENKM0kx?=
 =?utf-8?B?SG9Ib1h6TFk0bWxvOEtuRHA3K1dyekVFWFYwZ0kxTGJyY0FTeW14RkZrOHpu?=
 =?utf-8?B?WVBrMmszQ0NIaVdzT2JOSVBac2xVWUZMdTQvT1p5b01acGduSnUxamxxUzRD?=
 =?utf-8?B?RTFFR3o2N0ZNMHBlbzY4b2dJNC9xQ0xCaXUrR0dPZithb20yL3RYZ1pkZUJI?=
 =?utf-8?B?M0h4cXNNNmNmZGdsWDdqY2JPS2w4clN6YzBlOGR1VmxVUVp4SmtuNVBPMTdM?=
 =?utf-8?B?SDB1dkZENzJXQUhySU92Ykhad1k1RlZyd0x1V2ZhbE5jVGNGMjllYmI1SEM0?=
 =?utf-8?B?ejNJam5JK01IWm5LQUs0R0NwdHNWK1g3K3l1dFhIRjVFYVVucEg2b2NPQ0wx?=
 =?utf-8?B?RFFQYnMzb1oydzV2WjVHUVo5SVJxODNjclNxcU5QdVljZk9GRWhmbjFZTU8w?=
 =?utf-8?B?eFZuRnhlbjVvRUpyaEhqN09vNGMzS1FjaXpIc3gxREhtOVdVUHFzWGJHQndi?=
 =?utf-8?B?TmZicjBTQXVCK3VhT01HamtKY2luQzFyL1JLMjQ5VHFtVVkyNk9aZjlqU1N1?=
 =?utf-8?B?Rk9kcm45OTY3UlhLNGcvd2ExZWNkZ0E4bVpFR0dtQjNIb09mVHBBOG5HR3hK?=
 =?utf-8?Q?h3Xy5AVKx3AK+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 22:50:05.5966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da8d038-0d9c-49f3-cfb8-08dc6ee809eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546

On 5/7/24 11:15 AM, Axel Rasmussen wrote:
> On Tue, May 7, 2024 at 11:11 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 5/7/24 11:08 AM, Axel Rasmussen wrote:
>>> On Tue, May 7, 2024 at 9:43 AM David Hildenbrand <david@redhat.com> wrote:
>> ...
>>>>> That thread seems to have stalled.
>>>>
>>>> Yes, there was no follow-up.
>>>
>>> Apologies, I had completely forgotten about this. I blame the weekend. :)
>>>
>>> No objections from me to the simple rate limiting proposed here, if
>>> useful you can take:
>>>
>>> Acked-by: Axel Rasmussen <axelrasmussen@google.com>
>>>
>>> But, it seems to me the earlier proposal may still be useful.
>>> Specifically, don't print at all for "synthetic" poisons from
>>> UFFDIO_POISON or similar mechanisms. This way, "real" errors aren't
>>> gobbled up by the ratelimit due to spam from "synthetic" errors. If
>>> folks agree, I can *actually* send a patch this time. :)
>>>
>>
>> That sounds good to me. (Should it also rate limit, though? I'm leaning
>> toward yes.)
> 
> I believe the proposal so far was, simulated poisons aren't really
> "global" events, and are only relevant to the process itself. So don't
> send them to the global kernel log at all, and instead let the process
> do whatever it wants with them (e.g. it could print something when it
> receives a signal, perhaps with rate limiting).
  
OK. And seeing as how I'm not (at all) in alignment with Borislav on
where to apply rate limiting, we'd better go with your approach.


thanks,
-- 
John Hubbard
NVIDIA


