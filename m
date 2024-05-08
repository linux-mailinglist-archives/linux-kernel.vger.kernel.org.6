Return-Path: <linux-kernel+bounces-173930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E523F8C07A6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CD21C21225
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D0F1327ED;
	Wed,  8 May 2024 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NtapXneG"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1193252F6D;
	Wed,  8 May 2024 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715210974; cv=fail; b=C75UtgVv2gcIeL55Ge6bYN/l55XcSikf+YTBKxDsQRp+yKBWOhGxMj/Udesk9Qfe/asw+gaTx0tyoabszBp7Tff8eDDKqiP+AolnXQuwVt0u7dg/4CfWH76MxzoOXzpgEwATzgtoaXVB5RERUFMrVIBMETMVr8xT7d4b2VX6U8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715210974; c=relaxed/simple;
	bh=LOEbwux9EOa6oCgvVSkb6yUt6H6V0ygK7SEq/1Xv0Og=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=be1dvznEOh3WcUI70GSKsxSBnqmkVIWfx6uQJQZWNnOpTlWg6VOAlrxtFnMkQnv84fl49s1SeP0ex4yd6VTE9GTn0voe/UEtJjUl9BJtLvuKqAIhA8c8l9GroqkfjwUeyExgqJW1YIb9RQt8DxZkyeyce+s6rDhqiNjrA2rob7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NtapXneG; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7Lii2mcpxGNmRLqSNmZv1YhtbmJWvzvn1+vJ4bw/P1/3FOs8QVnX8mrkt2Cv8KanoqJNJli7+NnNJiQQQCJv+QfrSytH/N+b7BDDyeRvDCqh8bDTX0vUgzJOif24fBva29ojhhnJIzCjlMeXwHuwnwsDkYetNySm9vW8pZgGP9LaRt1quL5z3H6kSuL/rLLmFE4x/OiWjvGM9GseQHBQHuMlZubA1neSMAt3Dxi2KFcOyXtUG2Qm1FhcgrtoJBfwMEBbtjZtu+XXBB+YNq8khyrmyAH9+TmG7Oc26eeIEuJ95Oj+ej0hAFR8RWbmVdG9rW7vWcuUXXzdzpKBX3QAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcvKIA4qThoqjPbkUzhNyMqNzus8YV2KxZAYn1wtY7I=;
 b=FZFtas9p1YOpoXNOk5lS1AkQ8IET6xeV8eSCpE/1H0IER6QQw6K0mYAKJLt7fNFiia3EvaQVBf2VPtdaG7ckKq2caqurXwZnlsc/tqw1sSvJYqhOS+gT76dodB/r8yYMMueMMbl3qBaWcp+3mZJ+4l+DbZ/M+0wSq/n/oQNizPEf9ZRVGCfgOvcggXCS6ccXQ9LbTvoNFPwrOHKQbRWylA6fok5zO1dRW+GZW2J9V2D3ibanueQkJOCdbafzbLQLJTs6O1iFmVNtORV9QHoPohti1bTED6qRnjPD1B5JvqZGLi0HjoY8U2xsY0MF60bbobY2oj9hSy96yUdJWdTJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcvKIA4qThoqjPbkUzhNyMqNzus8YV2KxZAYn1wtY7I=;
 b=NtapXneGnJe7o8tMHbECnx+r/viBuSNccOLsmJbMicNaqMeq5DaMlk3C4qicPfm0gjFj/TrRqjAOK6WCoohjmdQKV4bLuY2hLuhGTJkMOXLUMaXKxWjdLPGIQh7ztMeXRKDOsEHqGUonT9eHjhmfVHv6Gk3R2xRZguk2OgBfbR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 23:29:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 23:29:27 +0000
Message-ID: <379ba0ed-5c67-4fb8-9738-952289d2f699@amd.com>
Date: Wed, 8 May 2024 18:29:23 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <48b595cc-5ffe-4507-bffd-335a60fdaab9@intel.com>
 <2016b830-64c7-43bd-8116-bdfd239221e3@amd.com>
 <ea75801f-e56a-486d-85a4-85c57bce0c81@intel.com>
 <7e92200e-d68c-4dc4-85c3-7192a23f8cbc@amd.com>
 <b8a87fb1-838f-4337-8940-8eb1c5328a2b@intel.com>
Content-Language: en-US
In-Reply-To: <b8a87fb1-838f-4337-8940-8eb1c5328a2b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:806:120::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b54708-505f-41b7-345a-08dc6fb6b412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1RWU3d4OGxMNzNSRlkzc2VmTlhXaDliMVBNUTJKWWk5YlVxZmlKVXgwRGQv?=
 =?utf-8?B?ZUFPdGZITlUvaWlIU2cybnpSQ2RTSnhpUWhpaktWbmhsNDZpNW5LR0xZM3pB?=
 =?utf-8?B?cUN4dFRudUJJRlNBaDZxdm05emJMOHF3bkJwQ1k3YjlSSEtRMkZ4eHI0QzZ5?=
 =?utf-8?B?WStXSlNVdE95THd1S25ZUEk2MUUyK0JyV21OUTR5Y01pdC81MW9MSXpkSS9j?=
 =?utf-8?B?M0ZveWpmUzNUNGtteW9yM0xvR0tHUVlHNHdZZGxzMXM1dlJQMVJMWkJ0d0tw?=
 =?utf-8?B?V0dxdTNMaUJCanYxeEtad2MzcEo1NzJoV2xlNmJoYTNSbFVCUS9QTVE1bHZP?=
 =?utf-8?B?TzV3M0cwRDh6V1B2SktNV0N6S3d5L282amhFN1h3dkdRTGFZMjVsakdHRkh2?=
 =?utf-8?B?SjdPdGFQa2JFT1BvM2VsWHRTWEg1T0NVN0VRNGJ6VERxT3k0U3FSYkZUOTJY?=
 =?utf-8?B?dGRPTm9GSFllc2E4dmxTSFBtRk9aaHl3ZnlWV1MrUFgvY1FPSFB6Zk91MUVZ?=
 =?utf-8?B?R0lOQXNVdDVYYkQwQnBqT1JKYmFJZWdiYVhNTUE1NWxMY3RVb2E5RTVQWEkr?=
 =?utf-8?B?djBXOFVGK3pDaXJ3VWNaVVhoUDJ0bzhPMVVZVVFlc2tKL1l5L1BSOTFQTUFV?=
 =?utf-8?B?UEErVTNUWFk2WDJMRW9hZCtVb2JOV3ZGQkVHUDNOclF4bmZmUVJGMzhLUmUw?=
 =?utf-8?B?alBWUVRpU2FLQUwyeHZZcUl2OURwZTAxNWRUNkVDRnE2TmViVHpTNDRBVHNz?=
 =?utf-8?B?MDNOaTZWZ3FERXk5VkVRS1FIdU01cjRxZFdiMGlhRWxVVVBxMHZHWTJtUDIz?=
 =?utf-8?B?SmJiZWlEdXlvUDJHWDBKek5uVlpsZWlkWFh6SzhObUhBbzVQUjFzc1Mzcnhl?=
 =?utf-8?B?ZHBHUVNSR24rVGU0RmtlUGtJN1NpMzI2TjFlWWtYRTQ4Z1JPa2lZS3gzeVBV?=
 =?utf-8?B?ZDEyeERMUmtkYkFCdkpKalNPYnJvZVFyV05hcFJQS0lHNmJGdVpJeWhFNDh5?=
 =?utf-8?B?WTBTUWFJNHFXUG9HY0ovQkJTS1FOZHNobG9xS0p0NDdNcWQ1UWZJK3FGdU9Q?=
 =?utf-8?B?T2tBMWQrazNBNlVrWXhJMzQwb0gwV1oxSzVaL1JUNzJTSi9GSjNWUE0vcVc3?=
 =?utf-8?B?dHRneUtTbnpnQmY3anhrQkJ6bUIwNytISGZqaXpkR1kzUFd5TU1mTlI5VWJw?=
 =?utf-8?B?RFhCNlBTU0VjcHRQY0FoVFA2eisvUUtqRFRncW0rcGkvakNjRGRHcG5sN2tn?=
 =?utf-8?B?RVhZSXBOQ2VKRkNSSlMzK2oxZTBkeEFsbEhScE9UN3JOTW1sQ3lEN1NoZ2h5?=
 =?utf-8?B?WVZBZm5oWmhJT1E5Uk1yN1hRa3N6QTFNRUlEVkpqODZ6QmhHOW9zVGRtWUdl?=
 =?utf-8?B?WXZxUk0wV0Y1VnVpM2wrY0lSMlZUcit6eFJSc2o5cnYrTDRKb1AzejlHOC9n?=
 =?utf-8?B?dVM4eVNJSG5nS1hKN3JjUVNzbVAvSVV1NW0xSGxxOVZqdStOUnNJbmUxei9B?=
 =?utf-8?B?QmhkWWNMVHE4M3E1dm5wbjZOV2lpRzRyU3V1c0l3UTVHYjJpRlYzVnpSWDZ1?=
 =?utf-8?B?NHZ1Vmx0N29rVGdNSktGVXIwL0lkNjFwUm1SdHpuSjcwZVFzSHRJTGlid0ZE?=
 =?utf-8?Q?DEtzx3syckgD+QFxUFEasXq0UATGHuKXlYmjYMtCQpnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEZpWTQ5Y0FlNVlicW45NnRBeWtCWFltNEI0V2J4aS9YVlVlZGJaaVlYZnJG?=
 =?utf-8?B?MnFlWU9PQlRucXZjWXU3UXVoMEtLK2lIWUJLbENlUCtDckJ1U2RYL0l0WTBr?=
 =?utf-8?B?NXVpY3JDeFMrNnNiZ2JIaUt1SEZhdXFUNVdmSU5XNVJjVWlvTHZ4azVyUkRT?=
 =?utf-8?B?enAzVTk1akpsT3o1MEt4cStEL0FSRGFsY3gvOEsxMlROYlV5RDQwTkNZL1VR?=
 =?utf-8?B?azhKcmJMbGJnUmV2SVhNNG85SjhBaTJKdWNQVFdFdXQ4QjgrSWN2cXltZDhE?=
 =?utf-8?B?R05uTXNnR0g2VzVJVnQzQ21sRmdsb0kveER6WHJ1RmNTTkxpcEk0NWpScVIx?=
 =?utf-8?B?eVd6bnNzTFZSa3hRZWttelkwMWcxWnBITUFMSWRLc2tjUmRSNjc3bHFtaWx6?=
 =?utf-8?B?UmhYRkFxRkc2YkZvYWhMNFd0S2k4WDErMlRvSmVWQS82d1hLa21kS3ZlV2s0?=
 =?utf-8?B?Z3dKbEpwQ1VVZjdGQzlXeFZrZHlWTTlxWGJMS0RuN0YrMFY3OVFoczROQ01O?=
 =?utf-8?B?UUE0MXE3eWFWNzk3NlRJNW1MVCs2clVDbmpuQTJpNUkrNWx2djJYeWlGQXJK?=
 =?utf-8?B?emlOY2hVR285Szd6Z2ZwNElQcVFXS3MrNTRvbWVBQ2YyZVprU1Q4Z2F6WWNG?=
 =?utf-8?B?akJaWXJkY2JGN0tFM3AvbkQzejdpSUwydlVHemlmMStWaWRyQVBLdHptd3NF?=
 =?utf-8?B?b0FFMzExdmFRcGFiREs0cW5lYnlSUnh6eDNmRGVVOExzMDlOOElmTDArRWNU?=
 =?utf-8?B?bEZLTzFjMGtDQ0FtenNGWjk5Vk5RVWp5TXE0ZHc0VjFRN1hOUGcxL01jWUNJ?=
 =?utf-8?B?eFFtUndZQTVUU0xGcGtjQk9kSm9ZcnZTT0dqdUdsOG1EYmpNZ2tnRVY5M1Rs?=
 =?utf-8?B?R3lkUXBYK3h6elhSZW9TdlZ3eS9uSG45Y01kUXByNWJxeUZBZ1hIYVp4SFZV?=
 =?utf-8?B?dXZld3FVZUVTdzgvVzZqeHhmaytRdERvNE9qR0VlYXhEbVRmZWhVM0xqeTVH?=
 =?utf-8?B?RWp4WG80S3NRRThhOWlKUVcwS2FESk9LT1drQk5WYkE0QzRMcFJHUVVjK1B0?=
 =?utf-8?B?M3QwTFZzbUYzWDdKZFJYWGtaa0xqUHJqaVlVMEhsRU9lUlZtNlVaZHMyYStS?=
 =?utf-8?B?UmI3TEVlYTVSK1J0MHpRbnVPWUtBL09rbmVLNGU1eC9pdHFyNktiRENUMUxY?=
 =?utf-8?B?Zk4rd3lxWXNrNW9WU1YvS0x4YVoyeEFHNVRYUUl3bWE4dGJ6ZE0rN1loR3RK?=
 =?utf-8?B?S2tEVEEyU3dOdXBiQk1wNmVaMHZoQ2dRU0dyQmNmakRtTDVuVXFCbVgyb1F1?=
 =?utf-8?B?ZXRrUTFGdFY3ankxcVdzZW1kMjI4TkdwckpmYXFQY2ZETzVBMDBhTTdhV0U1?=
 =?utf-8?B?KzRjc0dMM01oeG5PS2xsd1ZDU2JoUHhTNTY4djlwNGp1Ui9XakJoZ3NVcDJx?=
 =?utf-8?B?RS85cmNza3VqYS83aGlxSHVHcDY3SHlPMHdDei9CL2g4a0ZESjNpL2NudFpW?=
 =?utf-8?B?TXZVWm51Zy9EN1cwazYyYk1pU3RFaVhNSHlJYjJjVW9VdExrcHI2aGY4cFcv?=
 =?utf-8?B?RHNTTUlVZG1HcFc4NHpvVzN1bnVQMkxiTXF6NG9ZRkxMbUVCS2VlV2lKMnph?=
 =?utf-8?B?c1hKaDhtQzAxZWIrb3k1MVNOOVlyMTdGS3NYUmZWbUgyRWFrNXhNNkVoZXZ1?=
 =?utf-8?B?U3FwVHlmMXh4MGUydzkxK2drZTU3L0djLzNlWC91N0MzNldrWWp5T3pxZzRl?=
 =?utf-8?B?WEZwcWRyeThQYnRsT1VlZTlLdkVpUzArbGhGemdFQzVLTk01WWUxL1JqbGs2?=
 =?utf-8?B?WHhYUWdoWWw2YkVOUWJUaEIzSjNnL3JIdDUvL0hhQ0locHI2bXJFOVBvUjRW?=
 =?utf-8?B?ZjMxK1l2Q3RQMHc3NUJXWjZXRU5yOHNBQnZpRktRemZNZXpUdkJ4ODNXLzZF?=
 =?utf-8?B?WURJVzN2amoyeWRWREQ4UURYcDkrZmZYYm9GZ2ZpaUNpOGoyRVFxYUVoTDh2?=
 =?utf-8?B?UCtvK296dGh1Nmh3VmJHSEt6QUN1RzUraEdLR3Ird00xaFY0NEFJQTRMSGVL?=
 =?utf-8?B?TGcyWlNWV2Z2MThsRXprVWxLNG4xTUpXMHpZRkI4UmpyWHlkbDkvN0JFMjN0?=
 =?utf-8?Q?15Rk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b54708-505f-41b7-345a-08dc6fb6b412
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 23:29:27.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abA+dgKdV3EoQR/WduxWRIMPyeuLY/OQabuH/CXe94GB7LnEIL1tSCZmjF8I7ckL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228

Hi Reinette,

On 5/8/24 15:41, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/8/2024 1:07 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 5/7/24 15:26, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 5/6/2024 10:18 AM, Moger, Babu wrote:
>>>> On 5/3/24 18:24, Reinette Chatre wrote:
>>>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>>>>
>>>>>> a. Check if ABMC support is available
>>>>>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>>
>>>>>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>>>>> 	[abmc] 
>>>>>> 	legacy_mbm
>>>>>>
>>>>>> 	Linux kernel detected ABMC feature and it is enabled.
>>>>>
>>>>> Please note that this adds the "abmc" feature to the resctrl
>>>>> *filesystem* that supports more architectures than just AMD. Calling the
>>>>> resctrl filesystem feature "abmc" means that (a) AMD needs to be ok with
>>>>> other architectures calling their features that are
>>>>> similar-but-maybe-not-identical-to-AMD-ABMC "abmc", or (b) this needs
>>>>> a new generic name.
>>>>
>>>> It should not a problem if other architecture calling abmc for similar
>>>> feature. But generic name is always better if there is a suggestion.
>>>
>>> "should not a problem" does not instill confidence that AMD is
>>> actually ok with this.
>>
>> The feature "ABMC" has been used in the public document already to refer
>> this feature.
>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24594.pdf
> 
> It is clear to me that Assignable Bandwidth Monitoring Counters (ABMC) is the
> name of the AMD feature. The question is whether users can use the 
> same name to interact with "similar but maybe not identical" features from other
> architectures, which is what this series enables.
> 
>> If there comes a conflict then we can change it to amd_abmc. Didn't see
>> any conflict at this pint.
> 
> How do you envision this? The resctrl filesystem interface is intended to be
> architecture neutral so it is not obvious to me how "amd_abmc" is expected
> to look? Why would it be necessary to have different architecture specific names
> for a similar feature from different architectures that users interact with in
> the same way? Sounds to me as though this just needs a new non-AMD marketing name. 

I think I misunderstood it.
It is not a concern to have a same name("abmc") for similar feature across
the architectures.

ABMC is also kind of generic. I am open to other generic suggestions. I
think we should have "assign" and "monitor" words in them.
-- 
Thanks
Babu Moger

