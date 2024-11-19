Return-Path: <linux-kernel+bounces-414770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394BA9D2D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAA12819D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8826B1D0E39;
	Tue, 19 Nov 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z7EucVp9"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7721D1F40
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038731; cv=fail; b=X8t5KiVYQTCpiCir/7KfQlG25ifSuT+LNBPpYa29EPQThk+lLtpiTFZLhiU3Db4BgcWszx0FVj9006lewOu0rSvBEAIom6eTVp6gwGSNngrH1l8tmr5vdU1mXK6wMOVg6qeaN28i2DfJJehJJMNefjJhHqt7nxdX80Aaju8KeG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038731; c=relaxed/simple;
	bh=961SO70LbUSkVqJW4AM0UkNczxuhiwudR1C+fmsMCIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WxjVyXAAtmzSNtcbhL0+zGOc8M/1Ppdn2sn6Mzmc2gNN3Y49K+cXjmpME0N/0Yy4DVSoX1QrVQQ9kMVbL8Ch7Cj2hFhM1C8LmO75i+lnQF2gpwd70lVY3Jc90/Ucrqa6Vh3PwbKPNW82EIaNZzo81H6ODeEPw8z7roS1VkC/mmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z7EucVp9; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1aq4bn3WRXtrNbPKY7iJ1iVNLPjRP452JbpI4fwNCHwago51n6nW7YLLbHoWMNqIHOU8FOLmSCCkZlyKhdCcJrgbaL3Lr4anfHB0SX8+fWG6wRTaQ+/pyTtQ9Mztq2O6LldpqOqDxeJUnE5se55Hnbz23EqZsCKpew1gMCYsLHFXmRavBKiMbBKQieomdKAroC3cXul9FSz12mblYopl4GY/tM5edM8EefvI51WAE02iqce0NoxeQBkc7V+FpfKnUk/2/BcRb7DralWf81X27T9k/hZZ87rKgy8uEGhnkLx9oVUrMB3gj0GfeG0vHc3OsjTYRNxuT8wFjDsv866Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOrQdVgkKoa/ApL7BqehTia6p19LJ/UQi3Cf2OiAL/8=;
 b=Qp+Gf9Lg8b6qx7OuH+UIXV0MJv2LBsvFlWPSgA+jhfxZWrTfyxnoorFcUjQ4e8v/aHGvBaG6NDUcGMXpXMuFojmPoaQBqdrAtuSmZT7OiHcD0eLXPQ1tqWO8pKpHHh5nu6DjvYZtyTvo9p+7Yiv7XMlTSOrmqberZBM16VC46s9D1Jju2y7IMzckz6iZQ3obq4iXf8TI7EneOG2ZbcB50JZj4+3RQjqcP5pJP7CjvZzcJeKqZqOVe9YpGNa+d2UgpLOEZ1KR7sYfrztuHZTIVpxBrYgNQZ3gx6KyxTBmQ2yHWsD+oKh5olhA+AKo7pofu5HRFPFR4AvdxRHagXKRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOrQdVgkKoa/ApL7BqehTia6p19LJ/UQi3Cf2OiAL/8=;
 b=z7EucVp96N3C1RK90hYR55pe6pYA3jIdDOCpfduKpuxqDJeG0Q3mVHRThp6uhFlv7WuWS/FQzqKgmx7m0yZgTIjQvHLEd+haE1dWaUNPt5qjn1nGQelKawitHtY0+7w8ZKIQEo7TrVbbeCa8MQGVJ9m0l7CkgX8mewLEEjrcMXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH2PR12MB9460.namprd12.prod.outlook.com (2603:10b6:610:27f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 17:51:29 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 17:51:29 +0000
Message-ID: <c5292bcf-4e9b-289d-c6f4-c587a879e07e@amd.com>
Date: Tue, 19 Nov 2024 11:51:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] x86/sev: Initialize ctxt variable and zero fi
Content-Language: en-US
To: "Ragavendra B.N." <ragavendra.bn@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, ardb@kernel.org,
 tzimmermann@suse.de, bhelgaas@google.com, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20241118225828.123945-2-ragavendra.bn@gmail.com>
 <fc2202de-595b-f561-dc59-08f32c56ff73@amd.com> <ZzzMeHFyWTVT0-cI@desktop>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <ZzzMeHFyWTVT0-cI@desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:806:120::32) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH2PR12MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2ede3c-7b02-4f11-4b6d-08dd08c2cbe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck1qaWdqSko5WFdhWEUrZUtZeE90YjhDb0l5OC9zUDhNWEZiYVp0WTJXU1hK?=
 =?utf-8?B?d3dUYlZmNzdUZUVjRnpIaFZybTBON0owM29hYVlYRVZUQnhWZ2pJZ1A5dGh2?=
 =?utf-8?B?eHJQOGgyT0EzNHNwTDV0Ny9qakNpNUY5Y012UUV4M3hHSTRiQnMzUkFTZ25Y?=
 =?utf-8?B?RTEzM2xjTFNaTGlwRUFod0ozbFZWVzU0WGtHLzAxM1hWWkVqdkx3OTkwOW5m?=
 =?utf-8?B?ektOZUNKNGFqNDBaY0V1c1NveklOcS9nVDdxeVBuaVMrcVAzUFkyOHdBK2lT?=
 =?utf-8?B?UFZzZTlWYmxpZFRabjNXTlg1Mm00MEY1UjZMTitxL2haUWI1YWovZk93MVlQ?=
 =?utf-8?B?aVdyV3p4Ym05LzFQRHFpdlovOURzdUFlZEhoaEJzSTJaSVZDeldJWWVGelBx?=
 =?utf-8?B?WUpHSm1wOWVRMHVSbTFCc2VpS3hkYnRBUDVvdU5WdHA4TEFhby9PWklOZjFP?=
 =?utf-8?B?d0c2TlRzRkQxYmpXZFM4bWpyVFhIOGE4SSs4T1JSZ1ZyelJaT1Y0dE9VTUZF?=
 =?utf-8?B?R1V4Vk5vMVcrbHg1VE5xY0k5OEZCMHFFTDhza0tneUxXc3BoM1dTSVVTeWo3?=
 =?utf-8?B?NTJXT0dRS0h6YlZveEdRc09OVHVKdDVjaFluVG9lbUZOaVlsYjVXajExbGRG?=
 =?utf-8?B?NzgzU1I0NDEzL2NOcUVqYW1QdlJzbWs2WVJTM2FQdnFjR0xqOHQwZTdlZlkv?=
 =?utf-8?B?ejJxbFZZMW1sb2g5b1VTM3NmcFN3UGZLU2VCWTRnMnBmVitQVC9xYUJCcGdG?=
 =?utf-8?B?eWJwUkVtVUlDNHYvNCtZSUxDL2hmdnV3UkFwOGp4YVllb0lPOVllc1BKRUIy?=
 =?utf-8?B?aG9qVnBhNTZpcUZPSnplelFUbklzRG1pWHh1dENNdEUyN3VKaG9hZDcwMDNx?=
 =?utf-8?B?SU54RGlmT214NmdTRWVSdjVGbVQ5b2tOWVhZUlRuYjBmK1ZwWEE3MlNuYTFu?=
 =?utf-8?B?bFFmTDRlM0JHamxKWllxQ0NQbnZ4UVg4VkRldzgway9IWkRtazhXNkdtZDJo?=
 =?utf-8?B?OWdWQjhpMGdKUlF0dXRaSHQxcTZsQ09GMG5GOXo5Nm1sdXRvQ1JvSkNVVFNF?=
 =?utf-8?B?QlZiQ2tBYnd3OXR0QW84UStDQUhzWFhvZHJtTFR0RlQ5cUN5ZUlYODNSK3l3?=
 =?utf-8?B?c2EycS8yZ3JaeDdqTkxvZ1RDQXhoSDlKSWxTWkdtcEsvb0VyMERtNmlEU2lp?=
 =?utf-8?B?WkFYUXptZUdFeVI4eDFNODFubEs4NmxiVkNuS3JEeUNiNjRHNi96RVQydEJL?=
 =?utf-8?B?TFJZRWVnMGduTXJXN1BoLzVxQUloNCs4L2tpR1I0TjRCUnZJMGZMR0RkclNr?=
 =?utf-8?B?YmRSNkdFNkNkOW14bDBpVWtvYllpVEE5RWpSdEVRdFd2T3dNa3hyVnBWTTB3?=
 =?utf-8?B?b3FyQlNFaVcwcWtCazI0TEZkd2I5aWRYTDBKRFQ4RXVNMTA0YVJuMXlUZEN4?=
 =?utf-8?B?NXY0djR3UmlwVWdZMkJPcmM5T2lsaXFUTVNXSmxwS0hNa2hUSHo2R2JRb2xv?=
 =?utf-8?B?d2VWd1NpQ25WWGlEbEhvZ3VTY3lLVi82cDdVMzdlNWlJL25sdVFaLzh6SUk1?=
 =?utf-8?B?cDFUT0YydkZMaXBlcjJOQVM3L3lmZ0FKV3ZhUFFXQ2JtKzZvbXpaSHVaRity?=
 =?utf-8?B?RlNCMFNWT3UwZ2lSN3l2RGFzNHV6NUZQSktWY1kyeDkrZ04zU2g3ZGpJdWZk?=
 =?utf-8?B?ZFZqc3ZqWGlpSjkvbnVOTXN1Z2NGQjNCK21vUTQ5TEpkQm1XYndsS2VjMURV?=
 =?utf-8?Q?Y9qcf3G84fyg6XWSdtGwI9Tscm7WcJ+14cwBBdi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1RFUDdCVFhzWTYrYnU5OG1hZEpjUW5CazFvM0VxM081UjR6dEpnVGs1MENm?=
 =?utf-8?B?R1dWOUJ3QzRRK0toZkEvTnlaMTdIdTYrbkdDd0E0b3hsZUpCdkFGQnVaUlJC?=
 =?utf-8?B?M2pLS1kySklFZGROays3bDRLSTB5K2RyZW0xMzhvemsvUktsTHFnMnZ0dEtP?=
 =?utf-8?B?bENSZ09QSndkczJST3dBSHprb2tVVU1ZR2N2WERqTm1qWlZFWmZDRXViWWQw?=
 =?utf-8?B?SHJVaDc1S1JHaTlCZktEZVVaRGhDTW0vNWpPUzBZdVlsWXNWeCthMHdSWVdw?=
 =?utf-8?B?QmFCMkZCdjJRRDVwMTdNam85d3Zvazk3enZuTGg1OGNxeWVBcS81WGhtNXhv?=
 =?utf-8?B?T3JIbGIxVVpVWDdqcjJNeU0wNDBLMG91Y29DTGZGbkdsVjdkanUxSVV3R3lF?=
 =?utf-8?B?NVpFSHlkSklzY3NLbk1PczlvVmVOcUZrWHB0Tnp2MCtRaXlEdk44a1puVm1G?=
 =?utf-8?B?T0psRFJwSEJlNlZwdWtidzVlWFl1S2cwN3JDRVZVODVFdWxoWURwOTFlam8r?=
 =?utf-8?B?V1lSckZ5azAxMXhzRFZyckNOWlladjFwV0VBSXBjR3AvUlhUd0pOdXhmNEpw?=
 =?utf-8?B?VjNnMm5oSU1qNGd0K1FJdk5ZaXJ0aDlIMUtzYWFKaFYvRklvUi9aelBaL1Nv?=
 =?utf-8?B?WkZ2VXdKRHViejdFZkwwUkc5TU53RlVQaWRaT3BPYURjWlBEdFpoL1E0S2xp?=
 =?utf-8?B?c1kwQldiZGlEcGgxbDI0VjFKWWRLOHcxbnB2NU5hRFhhQTA0MzhVQ2FOZVF0?=
 =?utf-8?B?Q2s1UkR1QlFUV3pMeGpDMmJEV2dNZUNzcjBMTDZEcFhhMGVjeTloU3dmQnhF?=
 =?utf-8?B?RFJxcDZWNklsUmZvQ1R3ZDAxN0grcSs5QTRuNS9odUhZSUxKTlJOak5UbUVj?=
 =?utf-8?B?Y2JoRCtqZzBZT3FpU2xmWVkrai8xMWtJWmo3cVJDaVQybW9VcGJuTEViVUlG?=
 =?utf-8?B?WnlMV3p5TDN2SjVkWUpWcTU4MHkycXJXcytpU0dDRllIaFo1V3p3bExPcnZy?=
 =?utf-8?B?QVo1MGtEOHZGcDVaTHJZVG5kQWlIV25wcjhnRVR3aVBVNHg2S1FoYXpnSE52?=
 =?utf-8?B?OTB2dG44cXNCalBuNEJvaE5pL1dJcHJCR25xb1l4SDhmNENDMkhybGI0L1Bp?=
 =?utf-8?B?QkZiaGt0Nno4cjFndWxEV1pmVHE1Ukg5azFQZTIvakt4ZmZSekc0TUI1d0Js?=
 =?utf-8?B?dWhlMjB5UVVrU3Z4T1NWbHJ4d2I3M1VOVElrWC9rUE42d1RwdlkvUkFHbTRK?=
 =?utf-8?B?eHpGaFh0Z29memRpbG44NUt3clRydFIyTVNFazRZUHB1ZE9FdXRKbUg3Rk8x?=
 =?utf-8?B?b2dlWGdackdzTU56NTRNZmNVdUN6QW1BUjFId0pYblJTZDRQY1ZhVVJwKzUz?=
 =?utf-8?B?VUFHdEpFNkRkY01JY20yRmVVTHFwby9WZWlWVTI2SFlSQ0c1cm5IRDRzNmVU?=
 =?utf-8?B?L3BWTU9paUg4NE5odDhWOGJOVndOeWhJY0tuVU9uNlRzeVhyazJ4UXJBVHRq?=
 =?utf-8?B?eGpoT1BwNTcxNXQ0N0tKdWxmK2pDKzJtSURJbzJKVGg5TjBsSjdKZTJjamtB?=
 =?utf-8?B?NmpaTkk0bTdPYWp1bkpxK0pCdkVaNGZ5L2RqNHdYZ2ZzS29uMVZhU1FIWUV6?=
 =?utf-8?B?bk1IeUlXVDAzb3dESk1uNys1TUsxR2U0L29hektXWU0vS1dPNjJkY1hGUHNW?=
 =?utf-8?B?Rll4OUU4MzEvemlYUlRFWkRpdmcxRVMyWHlXaEJha3V5b3RSTXZnNnZyM0Iv?=
 =?utf-8?B?YU5GYlpWN1FBY29JRkcxRFp1T1ZGaGtGcFJYWTRNZkNUdW5tYzF5YkphVFVq?=
 =?utf-8?B?eFRWMzJKTHgyVFhtOVhFeXRQOHZKRGNYTytBY0VzTS9vY0M0WlhyVFQ4ZzNN?=
 =?utf-8?B?Sjd5bWY3ODhOUlg1bnhpNmJNWmZaTWJHZVZyK2ZzTFI5U1VvSUlLT1o1ZS9q?=
 =?utf-8?B?VWpHUUJBNnowWVV0ZlIwdFU4MUs0Ymk1N1VIRVlid1pwY0dvdkp0OG5LY25U?=
 =?utf-8?B?M3E4RzNmRkdNTXlnb2I0Q0R0ZVVld2JVcUJReVNwUW9GK2k0S016QnQxMmVo?=
 =?utf-8?B?dDlPWkdvcWcrOXZkZHA4Zm9vNi9IL2ZVUkxyend3SEhBeUZ0RHNkNHNZejF4?=
 =?utf-8?Q?xFMliUaDL0qvfE8Afgpz3UlpG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2ede3c-7b02-4f11-4b6d-08dd08c2cbe2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:51:29.6086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IN+FmAIL5C0zvBb8fHzNJ8fqpVgJ5a4HOfX3OOVLubpj1KBvU5aqwGielHMIGeMYwzXqoPIWwXpwtG9oLCnzmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9460

On 11/19/24 11:35, Ragavendra B.N. wrote:
> On Tue, Nov 19, 2024 at 08:23:14AM -0600, Tom Lendacky wrote:
>> On 11/18/24 16:58, Ragavendra wrote:
>>> Updating the ctxt value to {} in the svsm_perform_ghcb_protocol as
>>> it was not initialized. Updating memory to zero for the ctxt->fi
>>> variable in verify_exception_info when ES_EXCEPTION is returned.
>>>
>>> Fixes: 34ff65901735 x86/sev: Use kernel provided SVSM Calling Areas
>>> Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
>>> ---
>>>  arch/x86/coco/sev/shared.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
>>> index 71de53194089..5e0f6fbf4dd2 100644
>>> --- a/arch/x86/coco/sev/shared.c
>>> +++ b/arch/x86/coco/sev/shared.c
>>> @@ -239,6 +239,8 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
>>>  		if ((info & SVM_EVTINJ_VALID) &&
>>>  		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
>>>  		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
>>> +			memset(&ctxt->fi, 0, sizeof(ctxt->fi));
>>> +
>>>  			ctxt->fi.vector = v;
>>>  
>>>  			if (info & SVM_EVTINJ_VALID_ERR)
>>> @@ -335,7 +337,7 @@ static int svsm_perform_msr_protocol(struct svsm_call *call)
>>>  
>>>  static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
>>>  {
>>> -	struct es_em_ctxt ctxt;
>>> +	struct es_em_ctxt ctxt = {};
>>
>> This isn't necessary if you are doing the memset.
>>
>> Thanks,
>> Tom
>>
>>>  	u8 pending = 0;
>>>  
>>>  	vc_ghcb_invalidate(ghcb);
> 
> I can go ahead and undo that, I fear that Coverity can catch it. If no harm I can leave it.

Well, can you remove the line and run Coverity and see if it still
thinks there's an issue?

If it sees an issue, then it could be that Coverity can't follow the
flow completely in this case. Doing the memset is enough, as far as I
can see.

Thanks,
Tom

> 
> 
> --
> Thanks & regards,
> Ragavendra N

