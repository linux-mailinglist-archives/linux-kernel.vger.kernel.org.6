Return-Path: <linux-kernel+bounces-364640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8762099D74B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D8E1C2137F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505991CC163;
	Mon, 14 Oct 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nK1gymFi"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44421CBE8B;
	Mon, 14 Oct 2024 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933828; cv=fail; b=oHQmFE4jNYPcbiQajtJjR/xiCG4bL3fuvnjWOkplQl4AsND8ZoSZAA6bFyF6j81y719UMSjM6mi2j6AEmNLBb9pggXTwhAdIUIg+A4G4a9FZ44R833qXL0SkefgomTSLUbp2s0Dq3GyG3JaC003HHQet8v/DRsMm6UQT7FBhyWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933828; c=relaxed/simple;
	bh=CmDKQIygm1gUQriGL/ux/2tYEdeuOZz+G55euTsO5zQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k8Smwfb5T6oc4TQIW/s7oY5dgUPiaB+NAP28rVt3VzFdBhc3/7uUjhYIXgZUt/Iu2jgEuadRlfoJnrutJvLChMmnB2piyKaYT0+Y1FsVwhkkQdzqIYpkbuK1EIHddIieo9+sgM5zfZsYahc01j/XV0Gj1NmkHe+Wnd3CvrphHVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nK1gymFi; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2TB1ItUb3J08nGGD8DLE1Eub+XRWyWeipngk/kUQizp9se/VOCNkjlo0ZgelZG62WHeZxYSWFv2zfAo2jFPWE/u6fSLTl84/jmZU9/FhxqZ0YPT10mTG84lC9Hfm8Abt5lkMzwGIUXSU12Lgl8yeSskXJQu6lcPPSIIwOHMTPSux6KmZTrbAzZbBoo3fK/iDEBYxhNgUl4r+dlGTfVEF9azEZmcWKl5+Da76fKHlSVnkQu5UXtQVo7iufgVy6bUvrE91PRynXVWd2XvcZ+XVim98QPqsEgA2XOkQhgs9ijck6Mc4Ro/S9ZbU9okzsINEK9SAzXSSw+1V7RwPl+5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqay7TiEIP3YthQnW/IDRFAZpE3NtsTx2+hNUKayAY0=;
 b=dIU6bjnvQbQwAWVQ3TKPlfS7PLhbmqXZk8402QXaCls1tR4mPq23fU1EhYtfBquHKqMcURo3BEkIXUWMsFHbotD59dvJy1YkenS4zYMmKWSm7hVlM79123woAyQoCHQSfM+CuSs9k5GCd6VRDJ0IoCaEwzK1avHV8OIdxFT1jQ+BdND5GUNRyVZZf3caavXOxo7wrgLtIbFfECr/cE/UrvqSRqn6kMVpi1RztR6VRmyC2VCOlMC7huMWNifZ5SLwOXIborWLSiT8BCJCpLDl6dCJVigzXFAsj+89N7zoACWh/pTsiK7b3Zy0mIxXLT8H0o1xnIvY8XUyiXjUKXXCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqay7TiEIP3YthQnW/IDRFAZpE3NtsTx2+hNUKayAY0=;
 b=nK1gymFi+7oT2VJ/ZXSXZmjUJVtVGX1Hks3WaGBW4zWs6tD83fLJUAFzuvUS6QjmmnFTUkZ3YhuPvT6YMZdW0AhUVX7MeotrjcJBKYFNlfaleOMAT/BH29YNyFSoUdbjp2Bk58HMJwaLdNmxNscyDgoN+eB6sBgsaRGqMRfzAM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 14 Oct
 2024 19:23:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 19:23:44 +0000
Message-ID: <b77c4a7c-af22-4a83-8e54-9355b52fc07a@amd.com>
Date: Mon, 14 Oct 2024 14:23:40 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: Reinette Chatre <reinette.chatre@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
 "kim.phillips@amd.com" <kim.phillips@amd.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "jmattson@google.com" <jmattson@google.com>,
 "leitao@debian.org" <leitao@debian.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Joseph, Jithu" <jithu.joseph@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, "kan.liang@linux.intel.com"
 <kan.liang@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eranian, Stephane" <eranian@google.com>,
 "james.morse@arm.com" <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <aa991714-0f08-4f30-9bfb-b34e4aebcf86@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <aa991714-0f08-4f30-9bfb-b34e4aebcf86@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:806:22::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e78561f-d426-49da-05b0-08dcec85b81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVdRUTFCbEpNOGlVWTZIUExweXZHOTV3NTNPNzR3dmdGMk0ycno4U1d0RUI4?=
 =?utf-8?B?S3drK0kxRVc4WXdOVDliQ1RYZkE2UTE3S2tsWEgzTmJEOGZtdDBNZjI2TjNI?=
 =?utf-8?B?MlRyb21IaUFSWkZCUTlJcGFldlBVSWozUmdCSXNkaFJPUmlUaUtmSGVMRUFp?=
 =?utf-8?B?azFobkVlcDNkY1RCVm9qRHA0WGx1bDJvdmNHYnpPNzBZdmRQbFBxUFluQjln?=
 =?utf-8?B?K0FrNTRKelR0U2dQTFZ1b2hYK0RNb2Jrd2FOejhMOCtxQXVpemp6bGhleFUv?=
 =?utf-8?B?M3F5aTRLcUZMbDZKZ3RKQ1lhOTRlSkYzNitTV012TC91TCtxMTdYUDluanQy?=
 =?utf-8?B?VmN5bnVDeEFIRGw5VVo0ZGJUQ1NLaDVCcWRuVFRQSVlQYVI0L3VTT1NROFdn?=
 =?utf-8?B?SEs5ekh4UXZWd05sRzFMaytnbVVnUS92anlLKzdKWmNyWHR4R3djMWtaZTc2?=
 =?utf-8?B?M2Y4ZTNYZWRpTWxITVVuek9PSkx0MUhSdEYzUWp1Nmovbk5RbUcrQnJ2TzhR?=
 =?utf-8?B?SkFEUzdWRUtLdFNIQm5zOFEyVkNrSUJ1ZW9Pb1FNbFR5eHdCUFZMWlZMTnUz?=
 =?utf-8?B?eWg4cENvMVYyaElCa0tpeTZFa0Y0eUpSekF2ZkI5WEpicllqM2dGUDV6SmVM?=
 =?utf-8?B?aHEvWW5NSG1jVlRiT1dwNFFOdzRmdFV5d3ZwT2RUdkZvVTB5K3h2QVkyQVRR?=
 =?utf-8?B?UDlubEJzSVVrc1pOdUtWTHNUS21qbjFYV1I2NDY0VUx2M0RmS0dOM01oZHBM?=
 =?utf-8?B?elV4ODl0ZVBnR2phMXVrVE5qUHI1WDQ5L3pld3JHK1kzaFF6Y2VaQzFCa3Ew?=
 =?utf-8?B?OTBIM2duNVRzMTRRZ1k3akgyYVhiemVjZWdsS3lZaTBZOVhjcEhtWmZVTTJP?=
 =?utf-8?B?OWpQTVBFWGxPZVA0eStmRVhsVUczRUk1U3pFU1BjaHJlMzdqMCtIWUU1QTkx?=
 =?utf-8?B?TVprK01TNGQxcnFVclJBQ0hDSjdaRjJiYnBrTzgyU1g2ZlFaK1hXdzM2RkQ2?=
 =?utf-8?B?ZDRhbERSekx2YTlTWHN3d3VQbSt4RVhKdDVLVGhaTTVSWUJBOWRSdE5yUmxv?=
 =?utf-8?B?MjA2SDhuQmhQVWJEVDVVemIvbllWUnVtVDhQZGt1WHB0WTB4YXF1RlRRWVZa?=
 =?utf-8?B?bVFOVGU4eFJpcFlueitNRE1yNHJWc3JpU1M3UWU4WUxMY2pDM3JwcGM3OEg3?=
 =?utf-8?B?Z3BqMTZlTmdVN0ZGMEJnVTFUcWpWbUlQRitxQ2ZTMFdwejdJdnBhS1lWNTRL?=
 =?utf-8?B?QUFOcHRySGVpVkhPeUxyYXowVGxEb1U4cENNem1qNDBMZnRmNW1pd3pmd0FC?=
 =?utf-8?B?RXZvazM0eEljcFhmTDY3bk1SZHlzUVVpaTh4NWxGOWFzV2gxMFkxak94R3I5?=
 =?utf-8?B?QTBqWHc2NHMxMDVIRHdqUzBkdUw4V2hLTENNazBxUC9vdHI2U0xrekx3MkhH?=
 =?utf-8?B?aTErSU5MREZSK0VJK1BwcklPQ1FPQk5SbmhaOC9zWDJCbE9ETXZqVW5YakxS?=
 =?utf-8?B?ZmZhUzNFSVg2cXpHTFBleVFZSDZQU210cFQvaytObTdwdDBaNkc1VnFOT2JL?=
 =?utf-8?B?TUdsbHAyenVjejFLR0FXUjlkV1ZHT0Q0c2p1cFBZd3JndkdOWWtINDY4T1Rr?=
 =?utf-8?B?ZGFxcVNqZUx4MEFaZmkwWDBJaXM5VVpkMVNLUzB5L2tnT0pXb2xWUklkT3Vl?=
 =?utf-8?B?T1RhSWQvSFB3YXpKWTFFYW9sd3JUd0hFNDJRTC9xSnZZTzBIZHJnU1VBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGFmYzBsVG1yRlNZVkJJQVNwRDVoRE9pYmp2L1dNMEdobEVGZTY0K2hEcHdG?=
 =?utf-8?B?V1Mzeno0aFQ3NDFCL1NvSDhWZVczRkVNTi8veC9URllYT05HMGtpcGdaU0xD?=
 =?utf-8?B?SFFHVDB6Y2JLREYrTTZvYURuOXE5ZFhORlFIdWk2S1QwSGZZNXRhV2FTTTFu?=
 =?utf-8?B?QjRnMzZFVlVFdDdZeDdOazFic1ptZGIzb0tBY0wxTFdRTUxaL1BzS05QVVhr?=
 =?utf-8?B?UWV6dDJieGZZWjRNVkNmZWR2NkpPZWYvQ2IrbFRHV3hvQUVPcE9Wb3krN3dG?=
 =?utf-8?B?eHdyWmhlblhSWEcvK3ROREtWam5YdVhvQ3NKVktZd1J3bzNhbDRUWFFxR2FW?=
 =?utf-8?B?OGRHUDM5M1cyUGN3L0lWQzlybGppaUQ4RUkrMytubFdIK25FYnVvUExsc3dj?=
 =?utf-8?B?Q2RSUy9zZVQvRXpFblJFNUpZMFZRQ2IzQkIvcVRsNUQwaXN2SzM5UFFFaGtM?=
 =?utf-8?B?NmZORzdTWFg0Sy9QK0xVUVBETmRMTTRIanN0YnVMWkRwVi80RExLVUpra1FT?=
 =?utf-8?B?Z0pNYnhiYW55a0Rxdk11dGxvdzBqT0l2Qkp5RmJWc1lwTnpVUzNnRzR2MnBP?=
 =?utf-8?B?ZFhNS1dYcVQrbDJ5N2RKYVg0Q0V3eDZURlU3azNXdjBlNFFzVVJpckxEcXU5?=
 =?utf-8?B?QVRDR2lDL3JYRGh0azQ4V1NRTDc3Q1ljSDdNRjNBRjE2Z1VHaER0RjJZVGhF?=
 =?utf-8?B?cEozL1ZNZkhyMEVBZzdiYWRzRUNidXd0TUZvVXRxZklFRHhjVUs1YTVJUEZW?=
 =?utf-8?B?bEdKT1o4c2hvZG5MWTBpVmpkT3lYNlZTbE5vSXMwM1hUa2JNV2h0YTZqLzlS?=
 =?utf-8?B?ZVdjN3dZTlRXakJMeUZmL0k5dVNtK0lFOSsyL25sQ0Q5VU51Qk5HZUxYNnpv?=
 =?utf-8?B?WE1QVGt5UDFkNlJmK0tnU0xXT1h0OXRpV2VwUExzVzNubXNjV2FRakFrMmNG?=
 =?utf-8?B?eHk5QmxTZlpQV0t4ZFdtYU1NRkJWZ2MvaEFSSWFNWEs0QnQ4SGNPMXJOcCs4?=
 =?utf-8?B?ZHRka3hFd1Nzd3lJeWU5T3lta2F6YTNQSWhnMG1HQU8rekRsQTdrWWNWZEVU?=
 =?utf-8?B?WDZWRE1pNlZPTElXdFhMd1d6UjdwVHlzVUJGRmZLUVpCc0UyeXBCdjZ3Q0l0?=
 =?utf-8?B?Q2Q3V0ZuT1hVVkxtN0ZWMGtKWmhaWWJNQnBMOEhoV3UydkZQb0s2NVpmVys5?=
 =?utf-8?B?UGZyc0pLNEhaMHlkTUFLeWYrYVpqY3dSbERYQXQ5a1N4eVFvSTlBbmZIWlBH?=
 =?utf-8?B?azM4cmFrKzJzMjloZUF0RG9rZ1VacWFJWUFFaldzUUZLeHd6Q1V3ZEF5S1dS?=
 =?utf-8?B?NWZqMlNPZTR0QXlzZE54Zk1UeU14YlkzK1RiblBBUVRibVcrc0VadE1HZEZW?=
 =?utf-8?B?ODJCQVVIZkxjVmR4SDVhSVQ1dTRjM24zS2swL09Db1dMd1NsekoyMm9kVllC?=
 =?utf-8?B?OWZTUy95Qi9vWllVMms5SFU1MTNPc0hJZGl6ZjdVZXl5dWpmOEhpUWIxSHRV?=
 =?utf-8?B?MXpaTHlSczNadDlEbVc3Mmt0b1B4WWsvc0x0SnZySlQ5anI5Q011dUlhWUp6?=
 =?utf-8?B?clR2NzYzUW5Sb0hkRnk1dnNBdGRhclQ3bloveU1aKzhsbmx3cjZLNTk1WlFX?=
 =?utf-8?B?ZFZQL1N5Uzc4dHBlZHFGVWl0b3gvejd6YTRnWGZ5ZkszVU9td3hvN1dhNS96?=
 =?utf-8?B?bUczZ3owTENzbVRwRjdUbHpSTWlYNnkwUm9uQ2txREZ4clpiK0wwR2ptakda?=
 =?utf-8?B?NnFxTWppTXRiODVSR1Y2RGRDWHdTYkFyQXpZbWFrQyt4eG80TnU0bFBJNEdM?=
 =?utf-8?B?V0pDeUJHQmJ6N0hHS1EyQ1RueHdmMmR6NFA3TU1BQ3haQTJqVmV4NTk3U2U1?=
 =?utf-8?B?Zi9SV1NsOG5iUjVkN1U1b0ZaQkZhL01SZUFsVnUzc1N5cVJjQlpXUWNzR3Jl?=
 =?utf-8?B?S0w1R3JCbDh5LzJkQm1WVC9Vb2tXbzBtKy96UGk3L0hmYm5KQ2ZMRGt5d1FS?=
 =?utf-8?B?MXA4Y3lwa01YdCtuSzl5T1lzYjROQURaTnBNbW5xcGZmVUQyazdOVkxGVGVL?=
 =?utf-8?B?cE0yZ1N6MWhaMVpDYksyNGZlay9HY29lSWl6MTBlRERhcHFNdkhQcEFKUElw?=
 =?utf-8?Q?CloE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e78561f-d426-49da-05b0-08dcec85b81b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 19:23:44.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVBsiWjbDQIk1LvA6JbyK0hoQIlMcsxdeySApJ9jwIw8GdX3i6I22VI+2WT69HMm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

Hi Reinette,

On 10/14/24 11:59,  wrote:
> Hi Tony and Babu,
> 
> On 10/10/24 11:36 AM, Moger, Babu wrote:
>> Hi Tony,
>>
>> On 10/10/24 12:08, Luck, Tony wrote:
>>> Babu,
>>>
>>>> We have the information already in r->mon.mbm_cntr_free_map.
>>>>
>>>> How about adding an extra text while printing num_mbm_cntrs?
>>>>
>>>> $ cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>>>>   Total 32, Available 16
>>>
>>> Either that or:
>>> Total 32
>>> Available 16
>>>
>>
>> Sure. Fine with me.
> 
> I think separate files would be easier to parse and matches the existing resctrl
> interface in this regard. How about "available_mbm_cntrs"?

Sure.

Thanks
Babu Moger

