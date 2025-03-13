Return-Path: <linux-kernel+bounces-559404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27460A5F369
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E4F7A3D71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2391B2661A9;
	Thu, 13 Mar 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MeBwQvio"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BCC266581
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866481; cv=fail; b=GNp/zd2ZxP0NTA1xJMEIRCncvA7W6xpCW2pdiMMuaJk9yzfzzIo/ot1Zl4xmTt5WQle3ooBdv+FGp6jKaOjRrTDnUJ98YH4C/acko1tJ2dehyr1PyEnUQd8+XhK0G9iifWeWaPoIBkV8xGlXhxQ61SDPfdhBb0aQnI2CviymVFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866481; c=relaxed/simple;
	bh=FAJvv5G3oZozL9Sjsq8MsK4/t82eExY2JsRpEaucd5c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jPfeqivU9MVT2Z45+vGR5O9eLJoipZ7BBZSVW/ZCcmCX+NvLZ9zkgfKVhgDwmGOtlrujfaJ8b6yQjxwDsJK+xlXX9fDdhFcwxusMvv2nG2TkdfzFmW74E34lQSJOEQX9MlzToUvvz+h8Jt/ybZ4lCohid1BA2kFChZabhwibiBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MeBwQvio; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zfacfb9XVkgxuIgKwvYrzMhx9NbCcVGKmp7DLpU/PyRqfbszHqUKlaOo6MuKcMHEsv05shm19/EiLmd3FBKFP+VNAIVjIZCbrtQhgQMpqmWex1mUmGkKhFiNF38m39YWcP1/wH0m1u1KaAqVk+CNbSdKzAI5OXel8/Gib0wBnJlzaa4x5Un0mJLK2kkILFV7dhVNvvNCBvgZWOEevEuP2BPEf+t6WEE6znjsEzf7KiLtj9+tUGU3M9qto+dA8hDM1LsHluNk/oG2+pBi2REVoCUrCTYOppyh3Ajt8M9ejKxms4RpYfABKu5Zh51ifU7mdT43D8a/fRIegjLEdsro5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIw1Dyk/STnNZzec631gQz7ryOTCu+95GYlXFCYxeDY=;
 b=n8BKd7EZDo9Oha1/h1PD/SjBxnMrenEsO3LLqujPAROfe8Y/kuOecKAr+pd6/6F+0aaj6gYRZ0hUAi1Ig5zC5Wrw5THrzpIKKHpGGl+YCpjUTATcqMq64y63jLnGi05nczj/ajkEmpgRLouwN10hkV0iqg3TQFUqSjUe1CO8pHJfZNbcNNxwzqkxesT72H5lBop/7h/MwiT0QcaJL4bYFmlpjhUDjLYzgPbUxgb2cJem6x40dnslSDsyRgUhiWAhnFh4hgeM/rRWro1inxzbNq5VficfOH8oXACHoA7ZwCgg7tbApDcVcupHdTHlpK7kMEjAozcFO6EYJZxfg6AhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIw1Dyk/STnNZzec631gQz7ryOTCu+95GYlXFCYxeDY=;
 b=MeBwQvioCRzqkEUord4N1ErM1Lr7zqovnQq525rkNz7Cn65FIHae5lh9TVsMllE6QQ/GqnQdJ0Ieuh1kjfeoKjNGU8I1mgjd4x601FDArm0Hx/1oT3bvVFaICtrs/1AJbign3I853Zyijq8ksJxNwve+sFJrFRfr1d2PO6gMRepUfdhyCJXQGkFWv6YswI+5ydyhd/a+qexdrAJPPf49BxCvlA1CR5BaXD+g9HMT7gf/AIOK9mQZYolyCD0ccdsqPedB5Alvr0cfAUyiq5DJJ8jKu87FE1czA6xt+LpY2w+aFu1qfqyIBXVNswMySDgnwk3DE8J460Qu/azK8ICbzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 11:47:56 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 11:47:56 +0000
Message-ID: <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
Date: Thu, 13 Mar 2025 22:47:52 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250310112206.4168-1-spasswolf@web.de>
 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::13) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 270ce802-e8c3-406d-d8ed-08dd6224e577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVZKbFlGZ01KdlU5L1hNTDBRWTZlTHFnZURTME5xTy92U25xUDJ4dWQrTXFj?=
 =?utf-8?B?c2tEeDBiTTY0THJURjFhZ2o2aU5ZSWd4RmxMTlFKMXJXaURReUhNc1d3MzRS?=
 =?utf-8?B?TnRUWjRuRXowR1NmNTBNZ09uYmFZS0xHbXFOcGlHMUpDa05QS3VNYkdnNkFG?=
 =?utf-8?B?WVQ3dFVRK1dzRVNja2JRaTFRZEZDOWRrUEtaaXpWeFlqajgyZm9Ca1JFaTFF?=
 =?utf-8?B?TzZKMlRoWkRYVHUwOWVKUUpiY3Qrbm5TRlExR0JJNisyQ0RQQTM2amNEbGI2?=
 =?utf-8?B?OHZTQTFic2c2V0NZbGhEaGdPRnFDVitqMDVIU1hwT3RvRWJleTA0R3dKays4?=
 =?utf-8?B?dUg1TnRValYrNC94ZzRidEtQa1E1TE1VYjE4bTliSVRPOGdrQlRQMjM5TnJW?=
 =?utf-8?B?b1l4QnYrdW5CVEY4b0F1Y3YzK1NNRzJnQzBpNENCUmwvakpTeitjQWViYkNa?=
 =?utf-8?B?OTdIRzV0Z3pOZWlHZm1mWllFdklhZ0VmVHJWKzVxMmd2MEg0N2ozMWwvR24z?=
 =?utf-8?B?NDBodktrSDN5bm83Y3JXMEx5dkgzTzcySVFjeUloMXpMNU5KZ24ra1VnNWNF?=
 =?utf-8?B?ckdmQm9CUy8yNm53WkxRN3Mzck9hMmpiZlJGSjYxYzE1WnJpNkpFbUNJaVhk?=
 =?utf-8?B?bTZQcC9rQ1ZBK3ZaenRqb1cvbEt4eXE1dWdCNnhhSzRJYmlYRnRPd3FQUjVr?=
 =?utf-8?B?cW1hNUxseXlmanZabC8vaUNKVEpkZm5LZkxxNEVUd2k4MHl3SjV0OS9tWnpM?=
 =?utf-8?B?dkIxbVBsTHp0MGhzbXBuYlorYkFUbDB4OHJicXJmVHZwa1ovODU1ZFB4MUR4?=
 =?utf-8?B?ZGovRTNYYkExMkdDdnNUbTZ6Y0JUaDlzSVZEMnAxMVhicXI0RDVDL0lsYitq?=
 =?utf-8?B?OTRVc3V0NE9VaDJmQ3FjUGRkQ3g0ckpaN2lnNkd3YTB5WlF4czNHd0ZFbmFa?=
 =?utf-8?B?UkVtbzk2NzZSODBPdGJ6elZVVFVOY0lVU3l0NUpJRUs1dnBxUEVIcGFqaksv?=
 =?utf-8?B?bHdyZ0FJNCtHWTRYTU13T2FlMEtpYTRxZzR1VEh1MTVVT0FxQjg3T2ZuSjJ4?=
 =?utf-8?B?QzlwcjVXUGp3V3ptNVNFNU9oTFFOYmdORjNsa0syZzBNR2tTQUJQaDY5NXpG?=
 =?utf-8?B?Sm16TjJBNnJRRENLdEhvMVdqaE9vTVNveUMyZjJSandSMnM4Qm50UHVrRXFv?=
 =?utf-8?B?TklIaTJkd05TS1BvK3ZRY0xGTHd3K0RkNERSSkFxdllPSGxZUHdVN2xHYmt1?=
 =?utf-8?B?c25qM0xGcE9lbDNtcURYUHJhQ0xWNjQ1dDJ0UjUrYVlOck1MSDZYN0lDOGhh?=
 =?utf-8?B?VTdnTDh3ODRUU3YwNUZBWk5YcDVYVXUrRVNTam5vY1pWcks2MTBqRVpvNVhu?=
 =?utf-8?B?SFRZdEFyWU9aMDFPZGlHbnJJSlpqSWhxWTJWOHBiODVnT0NsQnEzN25Ja1RK?=
 =?utf-8?B?ZVlyTFRGTmNVMGY2N3JWUjVkRlh0aGxTbWUrWnd4enJRN1pjR3R6REdRYkpr?=
 =?utf-8?B?dHhFRzkwcHc3aE1YSllhdmM0WXhRbjlCNThNaElycG5LY3Y0MkxNV3ROeFc5?=
 =?utf-8?B?WitOaDdwd1dsd2VUM29XVHpSWnc0VGhoeG5laGhRMFRkMWMya0RWUGMwOUtU?=
 =?utf-8?B?Zk1HbVBsU0FQZzFpS2Y4SDF1ZW5JSUJlZ1V3NmFCd21URlVPRzh4KzhLUVVK?=
 =?utf-8?B?MVAvc3ZwYzlOS05NUHRlOVpjRVQ0S3h4Z1ZZNEtBeTVyYzFTZHExTkM1R3J5?=
 =?utf-8?B?dDY3VGxGVUU1eVI3SVVNS1FXNTRVbFVsN1JOd2ZBUnJpWFcwamdyeUlGWC8x?=
 =?utf-8?B?eW9WMzhQT3lCQ2s0VlQwY0MwZFdZNGV2aVdUaFk4US8zMWdtWEhVNVRsMWI5?=
 =?utf-8?Q?oqBRII1kYhJJL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUZiUjNoM2RoM05SM0FWcExlYTRNZzBXTG1pV3l5NlI4L3d2UjF3MTNoTHkv?=
 =?utf-8?B?c1RTK2lMamZMR3FxQzl3ZHhCZElKVjlLUW1IYnBkL1RlVzd4NDdiN1lnbzdv?=
 =?utf-8?B?NDlYS0RPVGhHVWtYdVpJOGhOMENNb3RSRTgrTnJZdGtRMWRKeTVTcVdQcGt6?=
 =?utf-8?B?NGg1RHRCQ00vZjcxYThGSGp3aWpqTkVuRG1QcDgrUTU1Y1pzU09aTms1cVVt?=
 =?utf-8?B?cXU3WWhsVEZCVm5jK1B5QTJqb2R4R1hRU2lNK09GazV3eWhnZ09uYlpCWnhO?=
 =?utf-8?B?ektJTGtpQmc4QnN5anNOdENBU2QvMTNPQVRLZC94ZkRTbEpTYW1BaXBUVzVN?=
 =?utf-8?B?bnVsUTNUdVE1ZWtlUDFZeVVlNkIzbzE4M3NocWxMSHpXN2wrSFRzdHM3VUx3?=
 =?utf-8?B?bStvVXV4UzdlVWhLUnNLQk1SMEl6TkZVeG9TRU1vSjlISUZwaW9PbzBpVGZq?=
 =?utf-8?B?c1dNQU9wM3FOellIMUExZGdqR2MxVXlmbDRkRGxVODVxUE93Z2tDemRGYW1J?=
 =?utf-8?B?RDlmRHVvYjhyVmYvZlFPT2c1V2FTWmhjUjJtVG1iaWYzalRrdFNZSDNPRU1R?=
 =?utf-8?B?WFdxbTlUWVJuMTkvenUxWE1JMDdMeXV6UTBabXY1UCtFMVY3VjZZODRtcXR5?=
 =?utf-8?B?U0hQc213UW0xRjRjM1JZQXdFdWwzRTBvQzY5WW1Sdzd0Q2p4Y2lVTTFEazAr?=
 =?utf-8?B?SjdQMXA2UmxUc1pxQmJRamI2UUZBWXdwWmZYK3h0bXg4L1k5YzB0cjNXdEo0?=
 =?utf-8?B?MmY1aDlQRldFenE0ZkplV1ZWN25zTWQrQTNhak5kNmFoanVvdmFpbEc0OElR?=
 =?utf-8?B?Y3NvVVFGRXpCMDVOUjRlWVlaeUs0K1pnRGd4aG5GYzd4b3dVV2pwMWdXWW5D?=
 =?utf-8?B?REp0OUxZRnRqaTU3b1ZkZFFWZ2Y5aVpzSG5kWUxmN3oxRklacDlrb014V3hh?=
 =?utf-8?B?UkpFWDlpZklKNjIwY1RJNTlsUGRxNEhkaFJKbm44VzJUOW1IeUUvUXAxSjI3?=
 =?utf-8?B?UXpqbDdXUGt4UFpzT1U2ZVU3OGVKMEhHcHl0cFIrczFJTEFRZi9RN2Rpa0tq?=
 =?utf-8?B?eVJielZxUnVIaGFRVDVIRmFUbU5IQkNiUDlUMVRuWEtqWjRweVQyL1hDWkZN?=
 =?utf-8?B?UWlUZUFHOVB0RDBCRHQ1ZFh0N1NFZnVJU1UxdkJnV04yb0FPK1JUOHNlRFpL?=
 =?utf-8?B?MXZVZGhoOVpxWFRJZm5YYmJjYzQ0SUlHbkNTMWpCVWYxaFZSRSsySWlCc2hm?=
 =?utf-8?B?KzNiZnBSQ2lHNlVneHV4TlFUT0RxYzBHMVdDSlllVUszVTdZZGpLTGRVSWZU?=
 =?utf-8?B?WjYwdmZIeitmQU4zcG5DL3A0bWJoa0FEamVSVVNza28wc3NuemZqYUxyeFIw?=
 =?utf-8?B?ZXpzRVFTcFh6ckRpMlpCSDJKTWtnSE5HbGIrYXQ5M01XQWxtSTlMajlvbTN3?=
 =?utf-8?B?Mm1zRnpiMmFmUUdDV2EyaCtpWTJNK1ZpQW14ZE5CMVNlbEltUEY3TXVZTXBl?=
 =?utf-8?B?Q3p6Z0Q0RjE0TXplY1hSQzh1U2EyWHdKY1lrMUl4V1c1Z3hndFZRa2Q2ekZ4?=
 =?utf-8?B?VGFYNEhxY1JrT2tsZTF1Q2xaeFV6R09lK3lGcSsrZVdBZlc2c1RuMjJZNGJC?=
 =?utf-8?B?VkZxRlJFZGxKZ0k4UUZBS29qQzNqa3FPVWpVaEcrSk1makIxRjgvY2xNUnlI?=
 =?utf-8?B?NmR6UEVnSlB5WnhQTWYxelNuMFdHMHN4V25aQ3JnUWZKeFlpazJKYzcyUE9y?=
 =?utf-8?B?ODNITXhCc3IvdnZjQ3B5MXhrUmRkT1dZOENRZG5WdkZFRVlWVnhYOU80Q2tC?=
 =?utf-8?B?NDNzdy9sLzhEbkRtWWQxQktGNHhtSFYrbE54UkE0T2NzN0QwaGRrcW9iMS8x?=
 =?utf-8?B?aFBHbHBEUExkamFpS3B0djBsWDNyN1hFRXFsM2xSL0lCcTgyWk9vMkJLZ3JE?=
 =?utf-8?B?TUJmMk5xWW9ycWh2bnVsbjNLaUtwMlFUZnlnVVpBN25NV2NVSWxqdVkxdGVM?=
 =?utf-8?B?VXV3SU8vRU1xWWJ6SHZyRzA1eGNJdXlYSWQ4bEZ6NC9xNWZ3RTNhYmZ0UHpE?=
 =?utf-8?B?Q21UQjQ1UVd1V1M4VFc4bkJDVVZyUWtjNXZubmFRc2JmMFE1c3gxNk9LRDZu?=
 =?utf-8?Q?UytrAJdPzzjJwgJUl5zcG91NG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270ce802-e8c3-406d-d8ed-08dd6224e577
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 11:47:56.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JKU2r8+jMpnTKupjRGErRespDELMutwp2ZKCEj+dpCkYtqkWiP+EL5F9qMWhl421uCL3TYOCqpNOOUpOPZK2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412

On 3/13/25 21:53, Bert Karwatzki wrote:
> Am Donnerstag, dem 13.03.2025 um 21:40 +1100 schrieb Balbir Singh:
>> On 3/13/25 20:22, Bert Karwatzki wrote:
>>> Am Mittwoch, dem 12.03.2025 um 12:24 +1100 schrieb Balbir Singh:
>>>>>>
>>>>>>>
>>>>>>> As a sidenote, I've tested several kernel with nokaslr as command line parameter
>>>>>>> (6.1.128, 6.8.12, 6.12.17 (the debian sid distributional kernel)) and nokaslr is
>>>>>>> not recognized as a command line parameter in any of them
>>>>>>>
>>>>>>
>>>>>> Please see my comment above about booting. How did you check if nokaslr is being
>>>>>> recognized, is it via looking up dmesg?
>>>>>>
>>>>> When I boot with nokaslr I get the following messages in dmesg
>>>>> [    T0] Unknown kernel command line parameters "nokaslr
>>>>> BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc5-next-20250307-master", will be passed to
>>>>> user space.
>>>>>
>>>>> This also happens when I use the debian kernel with standard .config
>>>>
>>>> That is quite strange, I can see nokaslr handling in choose_random_location() in
>>>> arch/x86/boot/compressed/kaslr.c (which depends on CONFIG_RANDOMIZE_BASE)
>>>>
>>>> Thanks,
>>>> Balbir
>>>
>>> The command line parameter nokaslr does actually work, I tested that by booting
>>> the kernel with and without nokaslr and checked /proc/iomem for the physical
>>> address of the kernel. With nokalsr it's always at 0x1200000.
>>>
>>> The warning message in the code
>>> 	if (cmdline_find_option_bool("nokaslr")) {
>>> 		warn("KASLR disabled: 'nokaslr' on cmdline.");
>>> 		return;
>>> 	}
>>> on the other hand is not shown, because warn is basically __putstr() which
>>> outputs to the serial console and the screen, not the log buffer (Which we do
>>> not have this early in boot anyway, I assume).
>>>
>>> So with this solved I tested stellaris with a kernel without CONFIG_PCI_P2PDMA
>>> and nokaslr and found the same buggy behaviour (i.e. laggy input while stellaris
>>> is running).
>>>
>> Thanks, the system/game is not working correctly accessing memory at 64 TiB
>>
>> I am beginning to wonder what your physical address bits are set to?
>> I can't figure out from lspci, the capabilities of the iommu on your laptop
>>
>> Could you please share your full dmesg/lspci before and after the patch/nokaslr
>> command line.
>>
>> Here is the what I know so far and based on some search I did, I could find
>> your laptop might have a CPU like this one
>> https://openbenchmarking.org/s/AMD+Ryzen+7+3750H
>>
>> It has 43 bits of physical address and sev supported and IIRC sev can change the
>> amount of physical memory accessible, but I am surprised to see that 0xaff...
>> which is the 10TiB range is accessible (44 bits) and the 64 TiB may not be.
>> I am keen to know if the system works or is it just the game that is sluggiesh?
>> Does graphics work in general, do other games work?
>>
>> The arch/x86/mm code assumes we have 46 or 52 bits of physically addressable
>> bits. There are experts who can correct me if I missed anything in my
>> analysis.
>>
>> It seems like kaslr has been hiding the issue that exists on your laptop.
>>
>> Balbir
>>
>> PS: We could try some other experiments once we have the full dmesg and also get
>> help from other experts.
> 
> According to /proc/cpuinfo my CPU has 48 phsical address bits:

Thanks, that is helpful

Looking at /proc/iomem

      fc00000000-fe0fffffff : PCI Bus 0000:03
        fc00000000-fdffffffff : 0000:03:00.0
        fe00000000-fe0fffffff : 0000:03:00.0

This makes sense and matches the BAR address ranges in the
lspci output

...
3ffe00000000-3fffffffffff : 0000:03:00.0
is interesting

Anyway, I think the nokaslr result is interesting, it seems like with nokaslr
even the older kernels have problems with the game

Could you confirm if with nokaslr

1. Only one single game stellaris is not working?
2. The entire laptop does not work?
3. Laptop works and other games work? Just one game is not working as expected?

Balbir Singh





