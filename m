Return-Path: <linux-kernel+bounces-174933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BFD8C17A6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD58E28355B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31B97C080;
	Thu,  9 May 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XqEgeRGB"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDD3376;
	Thu,  9 May 2024 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286908; cv=fail; b=uWgyZNvuQqFtKBs3bGLDNtYFCr7ubtaqtYKLh6gwA0HZbIe4IzAB3OUa2xV9sJbRTkT1WsO05WU6BoEYSErlRI1mMjLtS8fNV9T8G5RVfaCDvu6XGW0S4N0DeMauF5bb1HB045Fiz9xpsvLZv8MUVGK+j1lyOpJmieQoRgj0qyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286908; c=relaxed/simple;
	bh=FZu7NeJVOVFIbwsXqCUUqntqmQU2pjPlo32MBWtxL00=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gFYSzqyV5YC/R5CtGQOJAw2hXGoeEa1i3eMH4yFXe0EX56epBE+O1bcC4Dr6cQBpzqP0Qzs9FoTpgNdxmdqLmPlvnL2zXD5f1B2g8Ji8Eip8z1XNtU3oQO8ZNYIwafBhW1VRzeDjYv2l7Uqsqv2OtyKxB7gpKqQH6aRhq9VtER4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XqEgeRGB; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnxuXYTe/4ebQjvrJL2RG8g4XFLiRjIvxVvULmFYOoQLwxdhx3hJonnDRq6vXMVL8SFyBHDE13oms+KBOPe4/i/XK8yfhPfZYCROIK0ItKddVFeR2bGKLdCdQjfuoHhy8eGJTAQQivQSu9UqrSCr6DY0OCEBv7qOzGDKau/yv/CY6d1fGjR86PS+U6QwmcCuyxKIbhJyviZd1KTrW2159RnILoFL3KrPhH4dYM/LTkBX3g+ubQKngkebsWeKesupoNdl62gMn0zPlHiwLDUvrQqITSoaCFKyklVbgCj5+ijYvCqtVOANBk9vQkFBWkUk/YggbcuEUkvSSIsM5KFYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrD7EDGllwEgBtEKCdYEkfd0VwYCp591cC5UF0LcPQw=;
 b=G60Gslm5YHmJSjqP5KP4NhrE+UfuF3JguOmzMED9UqJCgJqejmQ4y6s/a0+TCYxsiQnA8kgY0K2wBUjN8D2b+PK2/z4nhtpeWKi4Pd3hT5cmEUapdxlu9XRBrVL0E7v1bdhPy60UBOA/RTRMD/Ja9XdNNs1/oOH0cvxlxYCxutUBenqOckheEQvIr8GYIUKhxf536/H3tpZ3TahFupdT2A1kj+sNp9b5abX6EUAdNeKqI9RQIec1LFdtnOoyUhb0ex4AgNtsMOov6Srmq0C99/t3JjRQGZcVzVR0ga+v0k0mpGFWP45aV753DRJcSUsqe345w2BzV8hNH8NgoMNbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrD7EDGllwEgBtEKCdYEkfd0VwYCp591cC5UF0LcPQw=;
 b=XqEgeRGBjznf1sCk6cZo7IPUKUo4ir/OxQFGhEmvNhnDPUFwnX/fLuGgxu4LdxmDPH3WmOuw/j4GfuDFmDvkv2+FqzJFtajoWK6xvM/ch3SIj6FTDlM5Llz2E8JEkyBOGqhwQv3zzPbNQd/6MSut4sHBjjuEP5i1+WGgOdbaZXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 20:35:03 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.047; Thu, 9 May 2024
 20:35:03 +0000
Message-ID: <f445e7f0-0d70-4f4a-8262-eaf3eb09478f@amd.com>
Date: Thu, 9 May 2024 15:34:59 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
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
 <379ba0ed-5c67-4fb8-9738-952289d2f699@amd.com>
 <0d94849c-828c-4f10-a6f8-e26cc4554909@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <0d94849c-828c-4f10-a6f8-e26cc4554909@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0190.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d604890-e734-4e2c-6487-08dc7067816b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWQvY01lUWhQWlJqckc2RDNzVDZHWFVqcUxkb1hjTlJIbkVMektCWHA5UG5u?=
 =?utf-8?B?V0ZOT1J6Qkltem85WDFpa2RuR0g5UnlwTHhLNjEzT3FBSDYrb0htKzF3Nm9Q?=
 =?utf-8?B?SFpHbmNoMWxVSVdUZEdsSFdJSk1URFVrdGJRdDd0ZFQ1dHRPQ21oVW9lZzBM?=
 =?utf-8?B?d2RrQzZDRDZJeCtJTU00dCtzRVQvbC9pNWQ3YnhhQW1CeGtBUmNCZDVpRHA2?=
 =?utf-8?B?WHFXajU3QW8reDNzTEFvNi85clROMXhCZXdVN240NWYxMlRhaTBZaFVvcTB6?=
 =?utf-8?B?K0JUMkxZTXVjM2k3aGVmdmZQWmdqaHdMNFAvdUc3YVZQc1d6a0NsYUlSeG1i?=
 =?utf-8?B?ZU5XYm5TdU0xZk04MzdKSE5HRmpXc1J0YjY2VTVHbjBxSENFUnh6QXVyM0tO?=
 =?utf-8?B?c0xZQVlDS0lXRk05SXIrNUw5b1FhTlpxNlZkWkd0UTlHZ2dtdkVodnlrR1VO?=
 =?utf-8?B?VmxTTFY3dHRQenN5eE1SNHZCZDJyRVRHbmtOTDlHdzlyODMwQUVvTUh1SnVp?=
 =?utf-8?B?ZWpLUkE5MEpOSVdiMXN5bE81UjUwdEc4bHQzSnUxWTZLL2JYYmI0YVE5Q1hQ?=
 =?utf-8?B?UmdoaCtyQ3V6TlA0cGZRT0NtOStaaWFka09hS2l1aG5jZnZkemdPaWdHQjRU?=
 =?utf-8?B?Nm5JY0xyajlIWkxsek5ENVV0RzhZT29TVXh2djU5RTVHWVBGSEtzc1ZNcmta?=
 =?utf-8?B?K015dEpMczRmaWZrWkpUdzREUEVQL2JzK2llNWdPTG44eXlyaTNuWldSamRB?=
 =?utf-8?B?aW4vRXU2ZVBrTkt5UWkycFM4Uk9rdE1WRzVGbGhSOElJQlBUZG1LS1l2WHdr?=
 =?utf-8?B?S2U2d0tMM2NmUzZaUTBzZUZZbkRGdUZwOWZnNUVMUzZhem9mS1c2WnhLNUc3?=
 =?utf-8?B?SnFSZlhRMXlUd2MxS2JaQVhSN2QwRXFjbnlNbGRoaUNyUU5YQ3NUdk1RZXBG?=
 =?utf-8?B?eFBGL3ZoK0FYVHJIeEFtb3k3SEFWYTl0Y1lMK3NBMkdwN1IwRHpaSy9wMUdv?=
 =?utf-8?B?bGxyczM3YXc2MnBsb214NjhXdE5qZlk1TUVtcFVlWE5Cdk82TWR1SnpueHNL?=
 =?utf-8?B?SmdkUUtXRnJNS3gyQ0kyRjVac1Z0MmVqVXFzSFptUWRhYzRmNThOTVhNZnV6?=
 =?utf-8?B?Z1BWV1ZrUE1QaEVXYktEc0lMWUlPWGFjV1dIUytWamNoQjlLcmh1MUI0VE5n?=
 =?utf-8?B?NmJENXYzdEFjOSswcjJ5cG4yYUNGSWE5emptWmJhaFMzRXErYmNVc1dmY3lt?=
 =?utf-8?B?ek1TM05QbnNYSFdZY01HL1BneUpPYTV2WCtOUnkvTjRnVGJjazNqcWlwdGJH?=
 =?utf-8?B?MmgrVnBOaWR5d2hTelBBbDVZemdUN1Irc0UzUTRjNlREbm5YdkZuWWN6alJy?=
 =?utf-8?B?d0xaT2pPRUV2anI3dlhwYit5UnVtelRBY1A5WHRhbGhJR2NuM2hQRHlYZmdy?=
 =?utf-8?B?TUMrZkxDZUZMNnMyV3lqaXRLWk4ra2k0VytMSFNMdi9qV2dDTHJwQm00VTF6?=
 =?utf-8?B?dnhzWFlmTzBPVWxGRjAxTnE2SVAxUFJjVmd4ZWRWU3lhUGdCZUVTZ2ZEejEz?=
 =?utf-8?B?K2VLR3J2b3UxV0VYdDFrQURNbFYyVlNhVkw3SHNnb0gweG5ISTNmc0pmc0ZD?=
 =?utf-8?Q?fZC/7bLf2MP/ydQIYATNaHJXh36dulTYg5Ms+cxsW82U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enM3cnAvb2hvTmo3cURMbW0yRTRySGl2MlBRdUloVWhybHVVZGJIeVU0b05n?=
 =?utf-8?B?aXg5R0RuS0N2T3hkSUFIZ25YQ1NiOG14a0RJdlV0cFNZYzJpUGpRMkZXMTND?=
 =?utf-8?B?VTFPVDVkTjc3bk4yN0lQRFhxUFRaTjh3RmJsNThHTG9DNW13aUozbHA5dnIy?=
 =?utf-8?B?cW9lL0hDQlFtdGNWL3NYcDdld2Fvdkk3enBoS1VaV0VRRGRUcTVHU2IrbXQ1?=
 =?utf-8?B?OWhZNzBWNTZrSHRQbDMyQWZFZHMxc3FPRzA1S3hOcDhGbk1LMmNZQ0NhRU8y?=
 =?utf-8?B?cHlKWStMZ1krV2N1VjF4cmpGN2J1d1ZHQ3RsVHIvZXBZNmN3azltRnBZNU1R?=
 =?utf-8?B?YWJSeEE3eWd6WHV0TE9mMHhTa2dPTUVaUmk2Mm0rTHRldU82MVZyNC9WbmRD?=
 =?utf-8?B?RFk2cXVpU1dmcWI1dzZsMWwrMlVuMVVUM2RadUZSYisxOU4rT2hEU2l6RjFo?=
 =?utf-8?B?NFJEVkJUUXhkTXFsZkpKUWxnUXdzVEtmSDZKVDBYVjJIdVRzVjFWWUxvQXBX?=
 =?utf-8?B?SkNrVHd6cFRCQ1pERTgxMzJaT1lNUmtBOVlzZFAxWUoxMjNod1FnMFBYWkJz?=
 =?utf-8?B?SGpHdldRY05iMjlyT2NVTkY5UE54bDNqR0ZqVk1zYm5ka29YaHVVd2VJSi9N?=
 =?utf-8?B?K3l2YUppekRTV0JKNnlaVS9RTmJCTjBCanE4YTdvMFFFSnhhYjJsWUFLWTkx?=
 =?utf-8?B?OWhDRkFtclpJVm5lY3JjMnllUXVRQ1d5amdkcVFISW9zZDN2ZEtzNDZnMFNL?=
 =?utf-8?B?elNZTlJWSXJYSXBDYUkxTkV3M3JTaXJqVmYyckpqN25oZVJBcU9GWVF5cjl5?=
 =?utf-8?B?WnJWVXZtalRvKzQ2Y3d2NWVoV1NBenJpU1hyUzNqcHNOei8zbmhrWnJPUE1q?=
 =?utf-8?B?ak9DOXFGVTNveXVWc3daa3ZCRUhTL2l4S0toZEFmOHd1TzZPMGZOYUgzZ2NH?=
 =?utf-8?B?YzIzdG1PRG1leUg2NzZ0T3lEbGpONE54eTA4NloyRXhlZEJrbHNNWDBtUzJU?=
 =?utf-8?B?enhVMmg5aVUweGxsQkxOaFRIclhsNFIreHhUeDRSOHBwQytPVGs0ZEpvMHVS?=
 =?utf-8?B?cHR1T2ZjY09Nam9GaXdFZkFHRnhXSENnOTRJTVRFY2ZrR3p0N096RlBxWWZy?=
 =?utf-8?B?Umc3UW1rQ1dQSG1RekV6ZVpCR1ZFMXJ2UTJMOVNKMXJkUGpsT09BaGNnOVN3?=
 =?utf-8?B?ZmNXRm9YcWREMS82blhNUW1JQnBFWFc5am11QkkwYXB1czNCM2R3ZGVaL1E2?=
 =?utf-8?B?UWFodmN1c29VT2tDLzJUTU44cFZxL3JRa01mZ3dlV1phSk9lVDF3S3RyeVhl?=
 =?utf-8?B?aExXL3l1VjVBcXhwYnNqNmlWQjFQcDhUYVhnbnJ2NXA5MEJDandUY0JBWjE3?=
 =?utf-8?B?VnVhbVB3MzB2VURxL0REbVMwV2N3dXFjdlhudEFVVzlxdFRzWUVQRklqcjJi?=
 =?utf-8?B?TmloaXJmbGdheU1NYy9UWjEyeHUxUk1JeUZ1T3E0RWdvd3dIWnduSENzZTdK?=
 =?utf-8?B?S3lnKzNRVGdIRFhTdjJHaDdHLzNqVUN6dEhGOWdhVmR6UWpFWWExTmlaTndy?=
 =?utf-8?B?NW1aS1N0RHREMUo0TFArK1h2RjZFU2RGTVR5OFp3ZGJ5OGJaRkdHdnA3QXRt?=
 =?utf-8?B?RURzTDB4K2k5dW5lblFSdFZuOG1KZTlIZXNleTFHZHhpZDczeVJWNmRDaEtV?=
 =?utf-8?B?bmhnaTY2NVJrUlMvK00wdnR3U292WENyRElGcVZaelZCdk9CQ3FmOUdCRXp1?=
 =?utf-8?B?TDJ1a0RGdHhvSVFwVkNSazh3NXJwVFhGWkNKc01mYVVxaHFFSDdtOEw2eVpm?=
 =?utf-8?B?OVJ5OHhxb2RiSEZZVGF5c1Q0ZmY3a0xRVzZLWUVUNzRPcmRVR2dPSTh5TE91?=
 =?utf-8?B?QTJFZmN5THFtUWkzQ1N0anZlZ0dlbk1tUkNaWjQ1ZXV3eDE0MUx3T0FjbkdT?=
 =?utf-8?B?ZWY5YmFpajVaSjZsRHluWVdYRkxqTDd3bm9OMnRENjlDMzdqZzNCcDZZS1hI?=
 =?utf-8?B?N2tjbXA4cTh4Q0lRUW5qdCtLVmRTRDQ4eVVFWkhMTjV6Q09VKzAyYWxtQUtT?=
 =?utf-8?B?Tis1bDJuTGhwVzgxdEx0VndWalJpeVl3WUd4ZTlhU3Vjb3JHRUtJTk5qTVlu?=
 =?utf-8?Q?jrzs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d604890-e734-4e2c-6487-08dc7067816b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 20:35:03.6639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypwHSp9dTWTbZVBi8u8QlX2VxnOsKhEiWyzxMZfLDXBxqgvEOfCloXVdrbj8fQvU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823

Hi Reinette,

On 5/9/24 13:07, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/8/2024 4:29 PM, Moger, Babu wrote:
>> On 5/8/24 15:41, Reinette Chatre wrote:
>>> On 5/8/2024 1:07 PM, Moger, Babu wrote:
>>>> On 5/7/24 15:26, Reinette Chatre wrote:
>>>>> On 5/6/2024 10:18 AM, Moger, Babu wrote:
>>>>>> On 5/3/24 18:24, Reinette Chatre wrote:
>>>>>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>>>>>>
>>>>>>>> a. Check if ABMC support is available
>>>>>>>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>>
>>>>>>>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>>>>>>> 	[abmc] 
>>>>>>>> 	legacy_mbm
>>>>>>>>
>>>>>>>> 	Linux kernel detected ABMC feature and it is enabled.
>>>>>>>
>>>>>>> Please note that this adds the "abmc" feature to the resctrl
>>>>>>> *filesystem* that supports more architectures than just AMD. Calling the
>>>>>>> resctrl filesystem feature "abmc" means that (a) AMD needs to be ok with
>>>>>>> other architectures calling their features that are
>>>>>>> similar-but-maybe-not-identical-to-AMD-ABMC "abmc", or (b) this needs
>>>>>>> a new generic name.
>>>>>>
>>>>>> It should not a problem if other architecture calling abmc for similar
>>>>>> feature. But generic name is always better if there is a suggestion.
>>>>>
>>>>> "should not a problem" does not instill confidence that AMD is
>>>>> actually ok with this.
>>>>
>>>> The feature "ABMC" has been used in the public document already to refer
>>>> this feature.
>>>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24594.pdf
>>>
>>> It is clear to me that Assignable Bandwidth Monitoring Counters (ABMC) is the
>>> name of the AMD feature. The question is whether users can use the 
>>> same name to interact with "similar but maybe not identical" features from other
>>> architectures, which is what this series enables.
>>>
>>>> If there comes a conflict then we can change it to amd_abmc. Didn't see
>>>> any conflict at this pint.
>>>
>>> How do you envision this? The resctrl filesystem interface is intended to be
>>> architecture neutral so it is not obvious to me how "amd_abmc" is expected
>>> to look? Why would it be necessary to have different architecture specific names
>>> for a similar feature from different architectures that users interact with in
>>> the same way? Sounds to me as though this just needs a new non-AMD marketing name. 
>>
>> I think I misunderstood it.
>> It is not a concern to have a same name("abmc") for similar feature across
>> the architectures.
> 
> Thank you for confirming. This joins BMEC and SMBA in this regard.

Yes. Sure.
> 
>> ABMC is also kind of generic. I am open to other generic suggestions. I
>> think we should have "assign" and "monitor" words in them.
> 
> One thing we can consider is to move to a simple "enable"/"disable"
> interface for events. Users do not really need to know that hardware
> needs to "assign a counter" to an event for it to measure. Yes,
> user space can infer some of this by the number of events that
> can be "enabled" at a time, but the concept of "assign a hardware counter"
> is abstract and does not directly map to (as I understand) the soft-RMID
> approach for other AMD hardware. Peter reminded us a while back [1] that
> "assign" has a variety of meanings, even among AMD, so we should aim to
> avoid any confusion.

Documentation will refer the events as enabled or disabled instead of
assigned or unassigned.

For example:
Event flags can be one of the following:

        t  MBM total event is enabled
        l  MBM local event is enabled
        tl MBM total and local events are enabled
        _  None of the MBM events are enabled

It is fine.

> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/CALPaoCjg-W3w8OKLHP_g6Evoo03fbgaOQZrGTLX6vdSLp70=SA@mail.gmail.com/
> 
> 

-- 
Thanks
Babu Moger

