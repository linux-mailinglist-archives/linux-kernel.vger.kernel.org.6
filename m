Return-Path: <linux-kernel+bounces-255081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 661B2933B71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D53B21F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D25D17E915;
	Wed, 17 Jul 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xSU4uCT+"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFD1878
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721213419; cv=fail; b=qHGxg/LXYzzDQJjxnbJRw8rNS5RFX4utMMXGhTeL1UVFqFiOpHMcLfmlLOTYHx7iPICrM38P1MXYlWNgBLo4lZjFNqM7le1Fnlpzrttsf9YeNL3evIBIiMEUOqbNEqZfaMbTkLMWoUvjmTjkyyTE19ikeHnRXSOQaF3xfa5gtBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721213419; c=relaxed/simple;
	bh=7wzjEufpuZb3jO5i2jk/0mDZTfEL/dWQtiZek1DX+7k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qC5PPzoLpURt0KRPrG3LdPq1CX84Ps2/rwybq2f+NE93WkclFxxtGaHkB5w7ARdrO1f9dhjOScg3/4k1HnxKj6tywg9WcegFp43975B55JZmsjv8jwvgRa860QhdUhZsXY7zdRjf64p8VM+MlmzcE2jK7ipl/ccp8jQ8Ge9Rtzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xSU4uCT+; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VypGSOsUpIIKIV7IobX5HDR767hVF98fhkO7rqF8a51GbCEun9JLEea7/WPAc/9BFSq1B6AVjFUFD4Pve9UUj5M2lYJe97Ou1OB76G8yw8DLHZbuYCkMnzCnDFcOlcA8Aj9I4DI6p0X4HLZ3+XiXV9qs/zVCQEz8Bw+RRPgelpEwxLhA1Bvi4iLJPpsj7HZEsmdYUxnCbSpfDM26+lMRYNc4XgNchbBGVpfR1QcGqfHSskamDw12zyhQtb9HOVtFMtiPagSlcPhdRzS9gXA8sFoxDPU0yqayDHxda34OWD+3PPxNd+hX0xcVNmNGraaJT1lF/oIS9Q3msCgOegw0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGuLD8lRXDHs1+fXK+FARZJVATjxvEjxu02O/guPU3g=;
 b=uFcCPoutBdR5dMZtDhDMNpy40CbBACXoSzxXFGeRpH/EYFIR8DCquolASwBFm5IYXQpe3OmM11stw99VE/vLP5BcXRlcYvwRW5nPMoJenHqPNlPmiClLWP16/GgNhTuUApaaEvQcal05kWvEFQgtge8R0r1Klvr8pQp8vKX/W2AnLSweSyHAjZHT2OXHR4pyKTYmLScCdcJinZecHhbjj//2Tnnq2S3XxxevzazOV9tbPtdi77s+lfOSaoWGgTsIqQpxY54O/HauTcr6jfnoq5F7eXawljhj5y48oZTMFQVcQ0H2RvlNgoI1zayrWGkI8qN535xgy6qiT8AHkUCZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGuLD8lRXDHs1+fXK+FARZJVATjxvEjxu02O/guPU3g=;
 b=xSU4uCT+3w4tuiTnKVg2KGV+fQgKQfuU8/v1qSNh2Dni9MljxChcy02QI2fkRWaq5x6H9G1oW4atcxEmQ1Kkgohocfs1xSMGLdQk8zl7zK7260czzqz+KLny3MW6in19zDLkZZTo3HkbZBLj8n/t+LXnAkojH2IGRcCiZxxwZw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 10:50:14 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 10:50:14 +0000
Message-ID: <9a53c5cd-6215-4ebd-a17c-1706077a9e65@amd.com>
Date: Wed, 17 Jul 2024 16:20:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com,
 "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, willy@infradead.org,
 kinseyho@google.com, Mel Gorman <mgorman@suse.de>,
 Petr Tesarik <ptesarik@suse.cz>
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
 <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com>
 <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
 <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com>
 <5fe190eb-ae8a-4e24-989e-3b967b57aea9@suse.cz>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <5fe190eb-ae8a-4e24-989e-3b967b57aea9@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::10) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: d87e9c58-b34e-4bb7-951f-08dca64e3d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1piTWRQeFlSS1BHVTZyZjlRTFd3Y1NoMUE3NUk1eXlySTAvWUNFUytzNFN3?=
 =?utf-8?B?emNyRUUrZ0ZVMWxTQnNmcE44OE9Ga29rTFNLRDZIdmJFREVMOWZ2ZnpaYjU5?=
 =?utf-8?B?L3NoYXpHcmhFZVlUVzAwVkdEeG9wR0ZPNkdRYlFVUWNlazZ0WVdLazREb3A4?=
 =?utf-8?B?MXNyZENFMkd2eDNkTWIyV3I4c01hWGN5dW1UMSsvak9EYk9rYnNCZFc3K1B5?=
 =?utf-8?B?d2lxZW5YLzZhUjVNTk5iWStsSEJmUTFwSjBZUVJncWJtUGUyVk1zMk9DTktN?=
 =?utf-8?B?MTlQaEt1enJCN1MvRFA4OHVFUFhTaEpHbmpjWDFVaHdVcDhaQ1AwdFluT3VV?=
 =?utf-8?B?WGFWUnpPNmVMNThOblJZYTdaQWRzcmhkWTBmekhoRURDZXNmaE5VUTM5dVhX?=
 =?utf-8?B?MHArZGk2S0RrVkpPUWo4ZXowV3luWlJZbFNDYm8raWpGNHYzRHdlYzl6Ui9z?=
 =?utf-8?B?VituRWZEK0tmMjdqenBWQldKTWVhOUw3YjVPWkZqMEI2dTd2ZDZRMFNBaGpr?=
 =?utf-8?B?OGNOTk5aOExJdHdONklyWHhPRlFwbk1KVDNIOFNDR0hLQ1RVdVhoSWdkUGtj?=
 =?utf-8?B?c05yOXAvTlBEdnJ1MjZqNi9QVVgxQjB6WG44eWx3dnVHWUtHRUJrS1ZqeWlz?=
 =?utf-8?B?cDBicldnUzIvOUdsWnF0TVJHSVFGZDkzWTlYVWkzMDZYTlhEQWdNdzVhRnFE?=
 =?utf-8?B?MnZyd0p6b3RxcUYzZlVHVlVZcVoyYlpDMFlpUGpNak80dnRNV3pJNTNWTUYy?=
 =?utf-8?B?Tko0ZFB4cG9LN3JNY0greElkcGdoT21ZblNIZVZtQ3VzU0dUZExQcXM0YWFH?=
 =?utf-8?B?N3h6eDZRdFJyNVBLTUY0MUtLUTB5NktsSFJUcXFDbkd1TUxXWVg0clVTdUp4?=
 =?utf-8?B?ZVUzc1pibGp5c2p2NzBGeFBrUkJPNm8vNXRTdm5EYk1VMEhTdWEza0xzYml3?=
 =?utf-8?B?UEp4YUdVY2RWRmVGdGFvZVBCMkYwd293V3RXa0d4ZHFCcXo3T2gwRlJEOTlB?=
 =?utf-8?B?UDdFTHJwRzVyejN0M3J6bm9rQkFWd0hHR01CVGVUSGRwaU45bEd2ODNMTUlM?=
 =?utf-8?B?WFVnZjJVUDFaVW84bGpwNFQyUWdkdzZSZW5xQ0xmRkd5TVIvVzA0OVAyb0Rz?=
 =?utf-8?B?cTVwMHd0SVE4cE9mQklPeFUzZzNVS0RMdGxSZGx2LzBjMWJOd1REcEtNYldM?=
 =?utf-8?B?UTdlVXFheFFkNmxHcjZmRHhkYkIrcmk0UXVwSS9QRmFIYWxrTjIyWVlWWVV4?=
 =?utf-8?B?WnVodG9kSmdHeWJlcXQ4dFZVQU1Ka3RPQlVxUTRGbzUrbTFjTWtJUkV1Y3dx?=
 =?utf-8?B?azBnSWZOb3B2NVYwaUV3ZktOV1kyczU3M1RNcmNaRDlGUVBFZXRMeC82WWhN?=
 =?utf-8?B?bXpzbUNsaiszempGM3Uxa2NYdndpbjJ2VjZpVDhudGhmSXllcC9oWVZFTnhU?=
 =?utf-8?B?SmlaRHJGTHNQUnp5MUVwN3ZPOHY3SjRzSzJRTTFrb1hTNUdhM3c0aHhTN3Nx?=
 =?utf-8?B?eHg0a2plWVozT254cnBtbzUrSW14TE9QSzFKN2pqLzBNc2lkdmRWRktGL0lQ?=
 =?utf-8?B?b0EyVklsdHBudFI4Qyt2QkI3QTZ2cjkxaWVuelFzWno2eUd0MlVuei94aWhE?=
 =?utf-8?B?c3Q3SWtIcXpWelZ0dngwTVBXOTJuaTU3QUt1enE0QTRLOWFCK1JGQ21mcXY4?=
 =?utf-8?B?SUVNaGlPa096VzU1S2lOd3lXVWNWckRmMDQ5ZmJoaDRRVnRQZkhVcmZMdlY1?=
 =?utf-8?B?cDFZcjU1VlZOVER6cjcrNW9MZWhZL3p2N1hzcnZjdHhSb1RvWVJOODltMGRn?=
 =?utf-8?B?VkFUQ0Z0b0tpdnRHcFFxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0lBa3RuSFN0eDlPd0VHR21QeEwzMW1kTTRKdUkyWGdETk5JMlpPMUcwNmVI?=
 =?utf-8?B?RkR1MjJsdmsxM3loeURYQTdHMS9BUnpTbXlSeUt1OFE3SkovZWkrcytmZEcw?=
 =?utf-8?B?bEN5VHZwa3JhbXh6QjBZWFJFR2ZXamFyTm1halJrb0dOdEsvZXo0NVZzdlJX?=
 =?utf-8?B?SmFBT2hGVFcwQ0VhR1d6M1BJNXU2cUxydkV2MC9zbHZvZ3RWdHZ5dHpyeEND?=
 =?utf-8?B?dGx6T2ZoM2pVNDl1UnJLSjVZWmxvdmJhcmJmSU5Yb1FabHVMZVpvb0JSbElJ?=
 =?utf-8?B?UWg1LzZ6WC9md2pQczZ6dnMxRC9IRmhuMXI2Yi8vMGxtRGhCRHlRZ0FLNHFs?=
 =?utf-8?B?UE5Wb085YjR6NnRpZmRucEdhYUJIK3dYS2IzaXgvUDVFTjc2RTN1L3ZmakZC?=
 =?utf-8?B?bGwzd2ZjdXoxMzIwWlJXb3dtUUd2N0RlTGQ1OFEzZWcxS29sOW5ja1NJUjRr?=
 =?utf-8?B?c1k2ZUQ4MEUwbUNYQ2kzWXUrU2lNK2IwL2g0YThNbVlaRUp3T1hrSUpydEZs?=
 =?utf-8?B?ZjVsbElNR2JmU3VhOVdLQ1Rjd1BIdElodlhhaGxvc2trWGJ2b0ZqR2dBOHlS?=
 =?utf-8?B?U1lYY3A0NjF3QTBFUitKY1NXL0VjYkdrOWFuRDdmMWExZ3JwRkgxZ2NyZFNF?=
 =?utf-8?B?akQrTkRoNFJkR2Ixd0pVeFBVeGhiMCtwaHhvTE1GVWhQT3FXSEl6OXI2WGpk?=
 =?utf-8?B?eDVWSWlBRXJIc3gyc2hQQS95QjVPZCttSU55YlY3bnNwZGExaExPdE9pY1dY?=
 =?utf-8?B?VEZNS0RPVjg3aHBNeVVtTkUvRUNOSGxZcjVxQy9sK0FmWU1DN0p4M0NvSERV?=
 =?utf-8?B?QmMvY2VnUnptc1AzT0tncTlmZFVDUlk4YmhhRzZ3d2JaUmlEVU51K3V6aUps?=
 =?utf-8?B?enBoeUQ1RzdvQUdSTzhEd1ppVTFkV0xiM2RoMThIOVo0M3VZRmF1NUlyYStR?=
 =?utf-8?B?eUxRWWsvcGdtT05QT3hDNW5TZ1VPb3cvME04VlpTUjZmWHplSElHWjJ3Z0VL?=
 =?utf-8?B?MTBPMzhWLy9wUE5hR3FqTC95N3lnRGpyYUhtemFNdUdjNjlldmlGa0R2T3ov?=
 =?utf-8?B?K29DQzlKNVZlZnBoK1EwZ0xQMlJXVjFSRnR0MmJ4TTJDMC9lbWRWeE1DVlE2?=
 =?utf-8?B?dEVBQWMrVnAwYjl5MjRacTNxazIvMlQ2S2JGMjFOZ21vdEdqdFNBZVpaR3do?=
 =?utf-8?B?VUsvbi9EU3JubiszaURLQ2o1OE1aMGRCbkFRZ3pBSW9keExHbkFLRU9zM1dJ?=
 =?utf-8?B?LzROc21aQ0hXU1ZPaHIzNUhpMjRsS2N5ejR3aGxtdUZ0QTJzekJ5YWRUZ2hL?=
 =?utf-8?B?ajNraXNlSWZHSENBeUZMSVhkVXQ0SDdxdE5lQnRqSGZpcWVmM3Z2eGQrampD?=
 =?utf-8?B?ZjUveXBDRVVxNjN5ejdTVCtxdEx3TTRYZGpkc29qa1U3SUF3eE9relovR2la?=
 =?utf-8?B?cVZsWkFPZ3hjM2JqZWxnMi9pMWNDQW5QUXhlYmhCZm0wZHA3RWlLelBsTEZH?=
 =?utf-8?B?YXRoc3BuZ3E5MzU0cktvMnRQZzNQbi9saVhLSTBoR2FKQktFcEpyNTM3S21W?=
 =?utf-8?B?dys1NktqSHFuTDR4ZmZTY0I4MjRUMWU5VzdvbTRYK3dvMHRITDk1T3ZJUEJT?=
 =?utf-8?B?eENNL09Wa0JlNGRPLzZPZW9XYVlxR1hncW0zRlVZQzhPTVZwa2xXc0E4MWVo?=
 =?utf-8?B?RFlHb3JaYnd4MmFPUnZpcm9HZmVUTFcxMEdyMEd1bGZPUmEzbk1DbkVNMWx0?=
 =?utf-8?B?UUQyeUVJQ0ZUeDVzTHJSemhqUXoxdEJhNGZTTUx4Zk1wRUtFNnhYUkRBVElh?=
 =?utf-8?B?VUpraWx6eEl2UEx4clZYYWhPMGxScWk5Szc4VUgwZWdyaWhjN21yY2tCUWdu?=
 =?utf-8?B?UTMrbkNLcUNSdk9yblI4QThBZS9XZEZoTTVFQWxKVnI1Y0ZuRkc3dytsM0xt?=
 =?utf-8?B?YVhXQjljQTNlMFlTWlpjRWVQVitLUW02cHJjOUFHeGlwT2ZYU0RsTEFRYWlx?=
 =?utf-8?B?SFc0ZllBblZSS2Qra3g3U0w1MnBDNWluVEdmeEZpaDNubDBjT1VFWGxDaWUx?=
 =?utf-8?B?R0NpYTFkWWQ0SVoyVE1ZaS9vS2JxNnVTNTNFN2VHZXdNdEZJd1QyOGFYUUNq?=
 =?utf-8?Q?ZqjGil//1VdSqD/3GJac/E/Pn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87e9c58-b34e-4bb7-951f-08dca64e3d2c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 10:50:14.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUjgBIuj5jV+ovl0NED4oQ16zIH514VVtqanyHVWkvXdHq3j5n+LHD0EyFCqSSLiUhfD2x7BonW8+rtj7oKB4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976

On 17-Jul-24 3:07 PM, Vlastimil Babka wrote:
> On 7/9/24 6:30 AM, Bharata B Rao wrote:
>> On 08-Jul-24 9:47 PM, Yu Zhao wrote:
>>> On Mon, Jul 8, 2024 at 8:34 AM Bharata B Rao <bharata@amd.com> wrote:
>>>>
>>>> Hi Yu Zhao,
>>>>
>>>> Thanks for your patches. See below...
>>>>
>>>> On 07-Jul-24 4:12 AM, Yu Zhao wrote:
>>>>> Hi Bharata,
>>>>>
>>>>> On Wed, Jul 3, 2024 at 9:11 AM Bharata B Rao <bharata@amd.com> wrote:
>>>>>>
>>>> <snip>
>>>>>>
>>>>>> Some experiments tried
>>>>>> ======================
>>>>>> 1) When MGLRU was enabled many soft lockups were observed, no hard
>>>>>> lockups were seen for 48 hours run. Below is once such soft lockup.
>>>>>
>>>>> This is not really an MGLRU issue -- can you please try one of the
>>>>> attached patches? It (truncate.patch) should help with or without
>>>>> MGLRU.
>>>>
>>>> With truncate.patch and default LRU scheme, a few hard lockups are seen.
>>>
>>> Thanks.
>>>
>>> In your original report, you said:
>>>
>>>     Most of the times the two contended locks are lruvec and
>>>     inode->i_lock spinlocks.
>>>     ...
>>>     Often times, the perf output at the time of the problem shows
>>>     heavy contention on lruvec spin lock. Similar contention is
>>>     also observed with inode i_lock (in clear_shadow_entry path)
>>>
>>> Based on this new report, does it mean the i_lock is not as contended,
>>> for the same path (truncation) you tested? If so, I'll post
>>> truncate.patch and add reported-by and tested-by you, unless you have
>>> objections.
>>
>> truncate.patch has been tested on two systems with default LRU scheme
>> and the lockup due to inode->i_lock hasn't been seen yet after 24 hours run.
>>
>>>
>>> The two paths below were contended on the LRU lock, but they already
>>> batch their operations. So I don't know what else we can do surgically
>>> to improve them.
>>
>> What has been seen with this workload is that the lruvec spinlock is
>> held for a long time from shrink_[active/inactive]_list path. In this
>> path, there is a case in isolate_lru_folios() where scanning of LRU
>> lists can become unbounded. To isolate a page from ZONE_DMA, sometimes
>> scanning/skipping of more than 150 million folios were seen. There is
> 
> It seems weird to me to see anything that would require ZONE_DMA allocation
> on a modern system. Do you know where it comes from?

We measured the lruvec spinlock start, end and hold
time(htime) using sched_clock(), along with a BUG() if the hold time was
more than 10s. The below case shows that lruvec spin lock was held for ~25s.

vmscan: unlock_page_lruvec_irq: stime 27963327514341, etime 
27963324369895, htime 25889317166 (time in ns)

kernel BUG at include/linux/memcontrol.h:1677!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 21 PID: 3211 Comm: kswapd0 Tainted: G        W 
6.10.0-rc3-qspindbg #10
RIP: 0010:shrink_active_list+0x40a/0x520
Call Trace:
   <TASK>
   shrink_lruvec+0x981/0x13b0
   shrink_node+0x358/0xd30
   balance_pgdat+0x3a3/0xa60
   kswapd+0x207/0x3a0
   kthread+0xe1/0x120
   ret_from_fork+0x39/0x60
   ret_from_fork_asm+0x1a/0x30
   </TASK>

As you can see the call stack is from kswapd but not sure what is the 
exact trigger.

Regards,
Bharata.

