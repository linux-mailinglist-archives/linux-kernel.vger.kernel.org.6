Return-Path: <linux-kernel+bounces-573905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C42A6DDD6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092BC166CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1525FA24;
	Mon, 24 Mar 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rf6JGQfQ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77486334
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829015; cv=fail; b=t2c/9M6BBbMfcb7LRr55Rc8lJ8w8rU+vcnlW5Pl28nPEFAOAL3Bikb1jw285ljrwWKbvB2qpyUR9xzI5ebf6GuCIL0Yz/9tEU1h3hQHRTMtcnUVQQSxLXkCuy1PVDchowfJ6cBuMGZoZuBcBk4/MSSfieImeyxYkXoUzJYOZNck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829015; c=relaxed/simple;
	bh=L4pxkdRWXHkjiVIkiu2NGrF9e0ED7pQiGFsKOLmkgts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dsyr/f958wSM/hw6gJOLpywQcT0AKK0vAX5oKBzXvg5GKZ36vDVKXjPg/4TSkzXqaPYrqIseHm8lqVqJ9M5Zpovlbi5STwbJ0FCmJDxZhF95P6MwR1+xH63imWldIFyp1noIsaG9C6D+O1wWHXoYOqdzTcdxyO4KQlRb+deBxiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rf6JGQfQ; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXSd20sUqwOkaCEEKCsOvVnXjiFpz7kJz8+Vlgd4z5liLbcyw6Y65Cr4g+fQZ8UypyV8cBWKqncLlZzHu1sjMffgH05bhKNFV4B9q0XdE6QoYcXv6s8d1mfxdtKkDZ8hliCVlzfU+Fb1wY3ID5pOKjJ7nwWjCCay29fcavwRRKijtXrOxzY5WpTXrq2g2KrxGW7l4JCni3eYH7eoD78duQYh/OcL/vKEnLvmZhqdEVq0UCl/qWylcRgp9W37fBwhrMg7lfTQoF/M0iy1Yc62INTcFWvcrSFlCh69e7n2ZoUPEZ0tgYZl2SiofRnKXZ0n7W7I1jD759JBwQIaEoQfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+ni8kPYyUV4BUouINireW5ecA6CiFm1uG+/Fck8yLQ=;
 b=iE3Rb4TdJ6jcKgEdsqYhoAJv2A0PdV/yn3s8ajnn7xZxvoZJ5i+ZpRRDzQ6mfgvHdOspDA+yJHCswCv6iQpuVpFmm4nehintkg1x+9F2rWHCdBbcEnYwcmkLDsmNDdbTo51IN/RfWJBr8ER3oXkZavnu1T5JNiLbSpGIn2Mo1IN86y61LyF7eJe2jmtJRpeQwdZ1rCdGOwK64zqC6fJYSn9kIFiKk3ET2hXDJx1rcbl6mgeDJGpGWauZ6FdF752bFYi9ifRZrdpXlAU49Avl7Yt4Uj1yxlcBLXk/ijGeGbdko50c0VC/UnqsOm5x8igqxZTB+verKWQqleVsYuZLyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+ni8kPYyUV4BUouINireW5ecA6CiFm1uG+/Fck8yLQ=;
 b=Rf6JGQfQp9BxGYaD4qN9mRR6Fr70Acr8ExqbG9Z/bsl8w/mZklAWHX3U28ycG3IrmInd+1yf1mikbCHAcW+DOTzkQp22cVhMNzi/sE7Nj99DyoX0s3ommnN2P0zlEHXHrqBSw6Ss3Vks8wl9WKCeGVX7ChOdFK+CCb9bBvP5qrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 15:10:11 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 15:10:11 +0000
Message-ID: <0901abdf-19b3-4266-9bcb-466a7432a457@amd.com>
Date: Mon, 24 Mar 2025 20:39:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V1 01/13] mm: Add kmmscand kernel daemon
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
 Michael.Day@amd.com, akpm@linux-foundation.org, bharata@amd.com,
 dave.hansen@intel.com, david@redhat.com, dongjoo.linux.dev@gmail.com,
 feng.tang@intel.com, gourry@gourry.net, hannes@cmpxchg.org,
 honggyu.kim@sk.com, hughd@google.com, jhubbard@nvidia.com,
 jon.grimm@amd.com, k.shutemov@gmail.com, kbusch@meta.com,
 kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com, leillc@google.com,
 liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
 nphamcs@gmail.com, peterz@infradead.org, riel@surriel.com,
 rientjes@google.com, rppt@kernel.org, santosh.shukla@amd.com,
 shivankg@amd.com, shy828301@gmail.com, sj@kernel.org, vbabka@suse.cz,
 weixugc@google.com, willy@infradead.org, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, dave@stgolabs.net
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
 <20250319193028.29514-2-raghavendra.kt@amd.com>
 <20250321160628.000033a9@huawei.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250321160628.000033a9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::30) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: c04ef6ae-b3fc-4f7c-f29c-08dd6ae5f872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aERwVnJvOE5KMG1UeFVxUm43VG1VMWhyUXpPcml0b0s2SjZybnNEcHFIbmla?=
 =?utf-8?B?cC9xUjVnOXI5OUVXTGR5RGx4ZmdqM2Jyalh1TGxRVUMvT1lQQmtYbFNPYzBJ?=
 =?utf-8?B?TStsVC9iZEhIWnEvdDZRRnFvczlocGFpcnBxTERoOU1jWGkwa3BMTEhIcTMr?=
 =?utf-8?B?T0NpUDQ0K2FLZW5VU1FwT3JBV1d1ek9TUVlEVmR1dGlteHk5UGdKUzNBVnVQ?=
 =?utf-8?B?cTg0cXUxaytZTkpja0loSWplWGdYcC9PaGxnSTMyVEE3SDdpYnBSY21QbnlO?=
 =?utf-8?B?RlluQVMvcXZWZy8vTkJBVEJsZ1luMW5Fb1dPS3drZWR1dGwzTDBBa1dVNFox?=
 =?utf-8?B?Mmx1cHN3elZvWjhPM1lwUmFWbWdQbHJ3emdxZEREa2dHS3htOFBod1hueFJ3?=
 =?utf-8?B?UmlhNnBGeTVCWUNtajNUVUp5b0d2cHlUVmxCbVhNa2NnS0ZWZWtiNjFIOStj?=
 =?utf-8?B?RTB4OFdXUDZFUWpvUTRUaVpjTGtSM0kzM1QxdFN5TDZleE9MSUtLK0VSck0w?=
 =?utf-8?B?bHJRMzVTaVpXeUl0L0FoakR5bk5sTEZEVlJNMTZZa3lPbWhJdG1kd1VsNGo4?=
 =?utf-8?B?TThjdFNXdmFaU2hLdFNPeC9kQmkrT2VDSHJzY2s4S3lKbExOUTJvaFRWTVIy?=
 =?utf-8?B?Um1DVytJcmJmL0FIemxJRUN2bytGbVFkS1R1aStBZHFjNVBkTFZOcXF4bGpj?=
 =?utf-8?B?cWdRaVdUWXZEM0kxUitJZzlYMEczandGcnV3THpLUWk1SncvM1RLT3FHRXJY?=
 =?utf-8?B?SThGcGk4WWVNZ1YzZkxqbHlvN1R0b3ZFS0lxQTZjMjZabmJnSUV2TXA2VEZL?=
 =?utf-8?B?SU10SHYvYnpSSHBjanhXZ3hxdnNoZ2hJZThZLzdEVmFpVG14OHFyUWl5SjNx?=
 =?utf-8?B?VlZoem5Hd25FRlZSbFZhOWRBRk5ZRFVnbHBZZXVaeC8xei9VRVplRXVyai9r?=
 =?utf-8?B?L2FtMW0zbWN1MzNXTXNMS1Nmd2djMWYvOGZwcHhRQ2xxK1BXYmphSHV0R1ZH?=
 =?utf-8?B?Zk5FNGlXazI2LzFXeTJQOU5FVm9hdlhQLzRNUVFaWWIxZ214bENacUhFakJo?=
 =?utf-8?B?NC9UV05RNU9FTG9pdHBqWE9wb3FuRGRxS3lLWnovVVFRNzVndnUzOE5FMTFs?=
 =?utf-8?B?MVdPWHc1NzNtK0wreWUzZjFZRUxYSFUwQ2tzRkVia1NFNFJnczJEbEpLU0xZ?=
 =?utf-8?B?dEZXVXFaOXo5c1JTbTh1b0RnS0RKRE9ySmI1TWhUM0FsZ3NMb1ltekcyLzdt?=
 =?utf-8?B?dnplWjg4bjg4S3JHL1pTM3ZpdWJiejV6VytJMEhPN1BzUU5hUEltRlpYc29I?=
 =?utf-8?B?Y3VIVEVWTlpBOStSUUFSWUhTUi94b1UzQ0UzRW9qY2JNZmpmVHFrRU9JSDNl?=
 =?utf-8?B?UnNIUVFCQ1FQYzU4WEdkMnFjb2IrTkJiS3kvbmVpUVNaNkRNcEswejIrbzFv?=
 =?utf-8?B?YmI1WFgyMHVlalI5TXFFR2hCaXpXTHFwNXUwNXNYSm1IK0FDeUtXcUtpeGhm?=
 =?utf-8?B?cDVSZ0dMZ2NQdHNhWlpRU0p1a1dudXFOOWNua0lnSXl0am5XaEdMby83Rmdy?=
 =?utf-8?B?RXRQM2JHdVR2eEtkN1BranNrSWlrdVQ3UFM4dzBWaCtmU2luYVZsMmN6aG5H?=
 =?utf-8?B?eW03L1VwVXZNYTBydmhuVFgxd01tSUd2TmdqWEhnSDV4Qm94cUtKZHdIbmdn?=
 =?utf-8?B?NTZjT3gwMHlpcDR5VnQ2ZXlJOUxxaXZ1bnlRNVR0dUMxM2F2cVI2WW9tU1RG?=
 =?utf-8?B?R0VQRVo4OC8xVUd5aFhuUGlwd0ZLVzVMMnl5R0dPUnBlSExFZ0ZnMXh0TmQw?=
 =?utf-8?B?bDdzOXRKc0NETHJlaDJ5UmMxandOYnRqMy9BN1JuWWdyY1FRWk00SnBuZXVQ?=
 =?utf-8?Q?1N7tA1/EPyvL3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0s2bTdXcEc1YXhJT1pKbGtuYW1pUXN2TVMzNS9HOUhham1WT2FNbUNtK2VU?=
 =?utf-8?B?UjhFTG1HekIxRnJBcGhPOS9URWorSU5HWEJxNFRNOWtpNHJ5d0RCK2UrN2Z3?=
 =?utf-8?B?RXJaSzhSQU5TMjhjWkxIdjY4a3ZMdXBaTVF2Y0hiVVdkQlRUR2VLOFUrN05R?=
 =?utf-8?B?b2ZNd2pxTmdRLytwUXdEUHJITHJQWEtmYVZKUTh5OE9iZUdPYWVZMS91Q2U3?=
 =?utf-8?B?a21vckJFVHovcEthb2pwOGs5ejZFQUZBZU9Bb0lzT2E0cnNUbVJyMFNsbVNW?=
 =?utf-8?B?SkVPbllxQ2lreUtqdlNaNE1FM2JTVTNyWmljOWJoRTJoZ3dSMG1FUVZFSEFJ?=
 =?utf-8?B?KzNFZnJGdk1CUDhMZTZLM0M2S01pUFNHN0M5c2t2dVNyYXg3Ulp3MVRQWlhT?=
 =?utf-8?B?MXg2R0l6REJuQllFZThzMmVtQUxiRXpnL1BpdmUrQWpjZDd1RWs3YXNBZ1BK?=
 =?utf-8?B?VFNzZDE4bStOUmlTejVPQmNicjNZZmV5S3B5c0FQQXZ5ZVVjSjlISTBvb2R3?=
 =?utf-8?B?RVZ5ODZhUmgreDJHRElFNU16WG9hdEhiWHFwTXJXM3NKUzdDOEYyWHVCWTBV?=
 =?utf-8?B?RngwRFFraHl3V0M5NTFoNnVnUlhZL0dmOHpGVVNFeXg0MCtUTk9hNUFsK3A2?=
 =?utf-8?B?MzM2SmFxa1UwUjNlWUpWdHRWTnhuR1RQZkJqMlRxTDRra2lBZlFIdVREaTJ6?=
 =?utf-8?B?SDd3Q1VDMzNFYS9pZ1NXdTg5V1BncDNxNk56MC9SL1dDbGE4dTN1N2hIY09l?=
 =?utf-8?B?NEhWUVpTN01PcTNGdG5CWmhtWEQ0T0QzNms1djQ4MVVRT25LcHBCcVU4LzZw?=
 =?utf-8?B?R3FlVmtRTGJ5VWhMR08wL0ZwRFdNeEpqSEtOT2VqMW9xNVRtMmFkMFBrVXI4?=
 =?utf-8?B?OStjaVIvTW4xNXhTZUc1RHN5Rkt3MHRaMDA3M2RtRXBKVjNXS0FUdmFUS0lW?=
 =?utf-8?B?NDlyYjB4NUdIVlcyNjAzQy9sZFVOeE45RUxTVDJMcFF1QUZSOTNyQ1orMWY4?=
 =?utf-8?B?bFB6QUhRdUFsWVFxMVR6OFVHSGw5ZXBxUlRJL3ZZVlR0T3BJUlhDa2dITVdi?=
 =?utf-8?B?eFBDbGhFWUZDSmFyWTl2SmltS0JVNzB1Vll1M0ZsU3I1S0JQU1FJdlRZdHlj?=
 =?utf-8?B?MGlOM1BHY2MxV01rcHhNaEc1SlVRckswMkdTNWw0bGJ3Y1ZHdGZlaFpQMlcw?=
 =?utf-8?B?M09qWWlNcjk1NHk3MUNXUmhPZHJvbmtzZ2RlckhzUm5nTysyR2c2Um1NenB0?=
 =?utf-8?B?eDhsMFdEUi9KTVpTVjJCVGl4b0tYN21NakRURUE4bU9hMU1WakZUTGFXR0FY?=
 =?utf-8?B?eGhVeHN1am9HaUs5UnBZR0J2UUloNnZmNUpYZVhLNGFTU1Bqd0ZqRXBiamtQ?=
 =?utf-8?B?NUd2aDJQd3FWZnhORWtFTmU2ZDFCdjJadkxiNEplSnRFcmFydy94Z293Sitw?=
 =?utf-8?B?SEtRSWp1K2pGa1pZTzdQaGxSZjdlSG9rR2cyLzZlNW9URnU4SzdjTkxtU2pQ?=
 =?utf-8?B?TFRhNGVmZXdBY3NrblE5cXFZc3ZiVXRYNGJqckNDRFFiT3Q1ZW9GalRoOHhB?=
 =?utf-8?B?V2JtUmFZQnpxaEUyYkM2eU5UMG1LUkNEdHh3eVRXVHhrNDBuVE9jaHI4WC9a?=
 =?utf-8?B?WWp5c0tlaGJrWjcwWkE5VWp2dXE5WWd1blB2L2VXV1pZQ1VFa3VraHNIaUxz?=
 =?utf-8?B?NWNPOHh1a0JaSkcvcVVSOTJhUG9UQnpKL0FQdDVIQ0ZwaVFoeTJmcDdqOHBY?=
 =?utf-8?B?OWhLQkxGMWV3Z29QczZwVTRYWFZQSm9RWHRMdENsZmFhbG9SODJaeXdSMDNl?=
 =?utf-8?B?U1RzZkh6SWdMNHdnQWxvd1pEbkRoR3NJV2Rxd25aY0M0d2k2QWFMZERoZDRz?=
 =?utf-8?B?OVBwc1UyZUIwTjZTVW1FQVhDNW1Kb1d0bEZzSk5ZYWJTbjVCNmNuUGVPL3lK?=
 =?utf-8?B?YjFHNWVqM0hyREJVcXhYdSs3UDU2clVITDVYdWprRFJEbTNaQVFjeEgxY0M2?=
 =?utf-8?B?UXIyZkNIVDlIY2E4STBSaUtpMDBmd2loSCtyRWN5THcxV1ZYdm9tRkpRUUpU?=
 =?utf-8?B?Vld6Zkd2ODdsSFRXSzUxS3I2Rkh5QXFvV2w2S0F3d0pzcUpHdTlmTFlNOEMx?=
 =?utf-8?Q?2vNHaEuXK3Ug30bR3dk3NDeNi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04ef6ae-b3fc-4f7c-f29c-08dd6ae5f872
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 15:10:10.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfuLC9+tjm9t6+At3+Ui+tOYKlOYebuuxHkViPSwzRW6i5y+svg99GmJGaEubsLxtb4eF/nxKmB4vYkp7+EB4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103



On 3/21/2025 9:36 PM, Jonathan Cameron wrote:
> On Wed, 19 Mar 2025 19:30:16 +0000
> Raghavendra K T <raghavendra.kt@amd.com> wrote:
> 
>> Add a skeleton to support scanning and migration.
>> Also add a config option for the same.
>>
>> High level design:
>>
>> While (1):
>>    scan the slowtier pages belonging to VMAs of a task.
>>    Add to migation list
>>
>> Separate thread:
>>    migrate scanned pages to a toptier node based on heuristics
>>
>> The overall code is heavily influenced by khugepaged design.
>>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> 
> 
> I'm really bad and reading code and not commenting on the 'small'
> stuff.  So feel free to ignore this given the RFC status!
> This sort of read through helps me get my head around a series.
> 

Hello Jonathan,
I do agree that my goal till was mostly POC, and yet to harden lot of
code. But your effort reviewing this code will help miles in converging 
to good code faster.

Thank you alot and appreciate.

>> ---
>>   mm/Kconfig    |   8 +++
>>   mm/Makefile   |   1 +
>>   mm/kmmscand.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 185 insertions(+)
>>   create mode 100644 mm/kmmscand.c
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 1b501db06417..5a4931633e15 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -783,6 +783,14 @@ config KSM
>>   	  until a program has madvised that an area is MADV_MERGEABLE, and
>>   	  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
>>   
>> +config KMMSCAND
>> +	bool "Enable PTE A bit scanning and Migration"
>> +	depends on NUMA_BALANCING
>> +	help
>> +	  Enable PTE A bit scanning of page. CXL pages accessed are migrated to
> 
> Trivial but don't mention CXL.  "Other memory tier solutions are available"

Sure.

> 
>> +	  a regular NUMA node. The option creates a separate kthread for
>> +	  scanning and migration.
>> +
> 
>> diff --git a/mm/kmmscand.c b/mm/kmmscand.c
>> new file mode 100644
>> index 000000000000..6c55250b5cfb
>> --- /dev/null
>> +++ b/mm/kmmscand.c
> 
>> +
>> +struct kmmscand_scan kmmscand_scan = {
>> +	.mm_head = LIST_HEAD_INIT(kmmscand_scan.mm_head),
>> +};
>> +
>> +static int kmmscand_has_work(void)
>> +{
> 
> Unless this is going to get more complex, I'd just put
> the implementation inline.  Kind of obvious what is doing
> so the wrapper doesn't add much.
> 

Sure.

>> +	return !list_empty(&kmmscand_scan.mm_head);
>> +}
>> +
>> +static bool kmmscand_should_wakeup(void)
>> +{
>> +	bool wakeup =  kthread_should_stop() || need_wakeup ||
> 
> bonus space after =
> 

+1

>> +	       time_after_eq(jiffies, kmmscand_sleep_expire);
>> +	if (need_wakeup)
>> +		need_wakeup = false;
> 
> Why not set it unconditionally?  If it is false already, no
> harm done and removes need to check.
>

Agree. will change. This code had wakeup from sysfs variable setting
in mind :).

>> +
>> +	return wakeup;
>> +}
>> +
>> +static void kmmscand_wait_work(void)
>> +{
>> +	const unsigned long scan_sleep_jiffies =
>> +		msecs_to_jiffies(kmmscand_scan_sleep_ms);
>> +
>> +	if (!scan_sleep_jiffies)
>> +		return;
>> +
>> +	kmmscand_sleep_expire = jiffies + scan_sleep_jiffies;
>> +	wait_event_timeout(kmmscand_wait,
>> +			kmmscand_should_wakeup(),
>> +			scan_sleep_jiffies);
> 
> strange wrap.  Maybe add a comment on why we don't care if
> this timed out or not.
> 

You mean why timeout is not harmful? sure .. will do.

>> +	return;
>> +}
>> +
>> +static unsigned long kmmscand_scan_mm_slot(void)
>> +{
>> +	/* placeholder for scanning */
> 
> I guess this will make sense later in series!
> 

Agree.
I will surely have to think about right splitting that
does not hog when bisected separately.

>> +	msleep(100);
>> +	return 0;
>> +}
>> +
>> +static void kmmscand_do_scan(void)
>> +{
>> +	unsigned long iter = 0, mms_to_scan;
>> +
> 
> 	unsigned long mms_to_scan = READ_ONCE(kmmscand_mms_to_scan);
> 
>> +	mms_to_scan = READ_ONCE(kmmscand_mms_to_scan);
>> +
>> +	while (true) {
>> +		cond_resched();
> 
> Odd to do this at start. Maybe at end of loop?
> 

+1

>> +
>> +		if (unlikely(kthread_should_stop()) ||
>> +			!READ_ONCE(kmmscand_scan_enabled))
>> +			break;
> return;  Then we don't need to read on to see if anything else happens.
>> +
>> +		if (kmmscand_has_work())
>> +			kmmscand_scan_mm_slot();
>> +
>> +		iter++;
>> +		if (iter >= mms_to_scan)
>> +			break;
> 			return;
> Same argument as above.
> 

Thanks. Will think about above.

>> +	}
>> +}
>> +
>> +static int kmmscand(void *none)
>> +{
>> +	for (;;) {
> 
> while (true) maybe.  Feels more natural to me for a loop
> with no terminating condition.   Obviously same thing in practice.
> 

+1

>> +		if (unlikely(kthread_should_stop()))
> 			return;
>> +			break;
>> +
>> +		kmmscand_do_scan();
>> +
>> +		while (!READ_ONCE(kmmscand_scan_enabled)) {
>> +			cpu_relax();
>> +			kmmscand_wait_work();
>> +		}
>> +
>> +		kmmscand_wait_work();
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int start_kmmscand(void)
>> +{
>> +	int err = 0;
>> +
>> +	guard(mutex)(&kmmscand_mutex);
>> +
>> +	/* Some one already succeeded in starting daemon */
>> +	if (kmmscand_thread)
> return 0;
+1

>> +		goto end;
>> +
>> +	kmmscand_thread = kthread_run(kmmscand, NULL, "kmmscand");
>> +	if (IS_ERR(kmmscand_thread)) {
>> +		pr_err("kmmscand: kthread_run(kmmscand) failed\n");
>> +		err = PTR_ERR(kmmscand_thread);
>> +		kmmscand_thread = NULL;
> 
> Use a local variable instead and only assign on success. That
> way you don't need to null it out in this path.
> 

Agree

>> +		goto end;
> 
> return PTR_ERR(kmmscand_thread_local);
> 
>> +	} else {
>> +		pr_info("kmmscand: Successfully started kmmscand");
> No need for else give the other path exits.
> 

Agree.

>> +	}
>> +
>> +	if (!list_empty(&kmmscand_scan.mm_head))
>> +		wake_up_interruptible(&kmmscand_wait);
>> +
>> +end:
>> +	return err;
>> +}
>> +
>> +static int stop_kmmscand(void)
>> +{
>> +	int err = 0;
> 
> No point in err if always 0.
> 

Yes.

>> +
>> +	guard(mutex)(&kmmscand_mutex);
>> +
>> +	if (kmmscand_thread) {
>> +		kthread_stop(kmmscand_thread);
>> +		kmmscand_thread = NULL;
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static int __init kmmscand_init(void)
>> +{
>> +	int err;
>> +
>> +	err = start_kmmscand();
>> +	if (err)
>> +		goto err_kmmscand;
> 
> start_kmmscand() should be side effect free if it is returning an
> error.  Not doing that makes for hard to read code.
> 
> Superficially looks like it is already side effect free so you
> can probably just return here.
> 

There is one scanctrl free added later in stop_kmmscand part.

> 
>> +
>> +	return 0;
>> +
>> +err_kmmscand:
>> +	stop_kmmscand();
>> +
>> +	return err;
>> +}
>> +subsys_initcall(kmmscand_init);
> 


