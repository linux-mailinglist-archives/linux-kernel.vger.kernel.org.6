Return-Path: <linux-kernel+bounces-255397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69387934054
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFD9B21729
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C8181BA2;
	Wed, 17 Jul 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uxCTJW5N"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2834C1D52B;
	Wed, 17 Jul 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233381; cv=fail; b=tzuqHk9CafOVt7SMt6WQcrDMq1fFixXqcuBDuRHVgVrS0PGImxBe5TQemZcCt+fUpDkCJQEW3OIKpP1IC1rs4VPXzdFO6I07RAG/z61aXK9QvpRQc6xfGiVj8OdWp73/lLEjyAjWxnC4KYBVGUSduS+IIVXUCurLVo10rdO9vjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233381; c=relaxed/simple;
	bh=oyiPzADgFrAUT+5Xv2I4SsXC1TJumHiFW0loxOfT5Qw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eE7iaaAsM9/v+58zzk5wceHVXk9EWahrfTfFIIdWAKP/1tcdE0p2t1vbIIt0Ngls8SP0pXkyNicGrWM5oJZIFc/UVZeqGK11aWJaa5fwwVFw/fYbApnEMKlxe4eoNyWlDNZOpajDK75ZHYPm5XLZ/FV1EQy0Pv9mKm4QbIB/f5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uxCTJW5N; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/yCLDnEmhB2uDDQVME6Fdkgyb8pOiaYDdvz74SH1nmAfw9NS4h+le5Fw82YXTF2XRItW49xQoTs02V2rjftdNJ8TMVfQHVag9ofabYrVSO7K9trRbuxxbbeEdbgFI2lyZSbEHiOYNk2gOIk3+86eAwiMjRZc6Dix0XeEn+tXfAPSlztRvKaXcttVPmTjZvH65Pz2FFvZTusJ+CA+68RlILpvgJDjlQtjos1gnPSuu7WU8NLUCaIK45GpaFHcfCPElQGEieHuB/n+5v7woBoKl7d9Wpx0ZpTReBKhJhY0Vv38hO62fa54bfEGRHaQZDdFTEobolQywM3T0fmv7y4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P97RfLgWdIaro7nqnNnBgPv5RcRTf+XkrFsg7TiGG1I=;
 b=eay803s0OgVSeq03DRdgtvUWKF2lTLmLD9qC4U1tvWWbEJ+klMAvWsrorz7FhkM+4qmZt7DPibKCB7NJrb3F0T6nNf6s/FRUnp6OvrkfqFdsoj/PJHEzC7UVq1GBS20+ykwzsPFMrYJDkJg2lhyysfH+nHguB5LFYmzZTLq+RQtpCrNpfeOVJdPIGo5OJh6oLJJHnkZCzDGyj1ZPSyPRNHTw4RaX/LmU/mKtnHfGDpBM8F8c7i2YLLeV6NJz5/6bMVdBV1+4nJwPIgqcONfNFxFXck3EDV470bdf8vq98PduRTMGuN7mz+Gd6pB7QtqGHOTLw9cmJtbkOxmmp/ClRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P97RfLgWdIaro7nqnNnBgPv5RcRTf+XkrFsg7TiGG1I=;
 b=uxCTJW5NeLhvNeFpeW6Mg3+wxSVo0Fnf7ye91y0sje0m6EQZZtzWvjYunseTnRNqFKAq4oHSDg2PAoSgMe6NxNXYWe8QGY5Rg9YDQxr7VAkI7qGCo8Yn1D4AzQBsQG5ghI8Cfc3X8OlZS0C1qc08Tfwr+QiXyQkqwuctNzp4qks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 16:22:55 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 16:22:55 +0000
Message-ID: <32348c71-06f5-435e-88b8-14267a20571e@amd.com>
Date: Wed, 17 Jul 2024 11:22:50 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 20/20] x86/resctrl: Introduce interface to modify
 assignment states of the groups
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <49aa5321f6e81825a0e9e44cef06c243634e341a.1720043311.git.babu.moger@amd.com>
 <d8e7ebe0-e3c4-461a-b544-555d5c4cdb5e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d8e7ebe0-e3c4-461a-b544-555d5c4cdb5e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0083.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 209a4175-6f0a-4e56-fd06-08dca67cb6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEhrNEF5ajFzNEpHSVlCOUtlK2hqNkZmQWpXQ25hVjVtNndLd25jOWNtQnNE?=
 =?utf-8?B?VEx5U24rdldqY2UrL1c0RENDM3hYVWtEU0RiQ0RvT2VHdVo1dTBpV3A5NHJ6?=
 =?utf-8?B?MUYrV0JWU2xlS080ZDVHeG5JcDNhblV2U3NOaklrNUs3MTBQV2g2bmlTN2pr?=
 =?utf-8?B?ZDl4RVNmMGk4UVMyT3A3ZGtxc1pmSUcvUVluSGpqQUx3QWJwK1EyZ21Wd0ty?=
 =?utf-8?B?SnMrRFozSHRpUDZVbFg0WmxSZ2FkZjlTUUlFbjRCNVdsbHB6SEZsalVaY3lL?=
 =?utf-8?B?OFJ2S3gxRXNia0tYcUdsc05nR2Z2VG51ZmRYR1I5Tml3a1VTb2syQjV0dndZ?=
 =?utf-8?B?dTBvRXdrVFhETjlyNUM5U2NJdURqNWZtT3hVbmNxeFFNbVZKUjF1WmIxYTBj?=
 =?utf-8?B?UU9CcWhRcmRsVlV5MkF4d3N1dDhRa0kxM1BCMW9zTzcvU3BLSjIyZnl4VjBr?=
 =?utf-8?B?NEpWU3Z4TC9IRGorVHBLL2RmUnZGV24zdmU5K05vRmRRUENDRUhod3lpcGNy?=
 =?utf-8?B?MW5NS2hZNCsvQ2tXdkFxWm1xV040aUhWdHBvSTkzMWIvRWZoRmRHVU5aRnFT?=
 =?utf-8?B?N3dpTG5xa3dtZ1VZYXZ3cmFLV2l0TmR6Q3dxYlQvTmJpODExYlhZN1lTdkZu?=
 =?utf-8?B?Qks2REVFMlVPOXo4UkRQcHVWalIwakV5S0o3eUVmbkdKQnQ3WCs1NklMWkVS?=
 =?utf-8?B?UnFpSnNNRHdzc2V2ejdXWjVUQm1kQlVzZ2V4NDQ0YTRhYWUyRWF3dlQ3VFBM?=
 =?utf-8?B?ZE1HdXBCVEV5UGdGajlSbmoyRjh5VURENEpOVGxWMEYwOEhmUVhMdmQxQXZu?=
 =?utf-8?B?TU1tRjliNnFuUGVoTzFObzNrUDlzQndqWExEMXFhTzdSSFo4ZmlvU3VpRVJQ?=
 =?utf-8?B?Ym5LWUNTeHlXU1JEME5vVUNhd3UxbWU4N0RNeStJMWlPU2hsT1gyNzlDRzBs?=
 =?utf-8?B?NmV4bExKcUFmUjAwUlVHcGl2engwZGtVdnJiMW84aEFsaVVDdnZHdFJTbUR6?=
 =?utf-8?B?RkgveWtyd21QV2NjanRJTlVTb3B0NlFXQkUvY1R5d0RvL3JFQkZxT0JTMTYr?=
 =?utf-8?B?NFc2RUVJQzhicDdLU3I3N2FmQTVBcFMzaGhOd28zelNNVnpRSnQ2MEp4UzFR?=
 =?utf-8?B?Z2Mrdlkxbi9FWFJXNkhGRm1UNkFSRlMwZVBxbUFyV09TVi9odm96UUNOVHlj?=
 =?utf-8?B?UXltQlBVN3hhakJnaUhjKy9GNlRsd3VockprRzVUNTdPMFhFRjJLUVdPSTBO?=
 =?utf-8?B?TlNrVmY0MmpOT2NNQ3I5RkdXTnE2dmNaU1JiSWpJSmJSbm5iRFZUWTZ2SUtU?=
 =?utf-8?B?QVprK2pWRlZBd1JTdm5LS3dIaHlycWcxV1RKZzdGekFESm04Vi84NVpzUHBM?=
 =?utf-8?B?UG9ZL3lrNUN1cFNoaVQ4YmphaWtHUzE5NWt5SUpmamkvUnVKc0V5NVdURkd6?=
 =?utf-8?B?L2J4dURhSllpR1EwK3RsQTNXMVRqTTZ5aVBrTDNTcER2ZnRwaGFYalFVeGE0?=
 =?utf-8?B?ZVV3VXlBK2gxYXVOS2hNdTllR3pJR3AzT3FiNUhLUjljVlNkS2ZMaGZzVENU?=
 =?utf-8?B?RVF3ZDJIaEVFSlJ3K2xHcWU5Z2YzQU9PeWRDVDBMODdoMWJXRVJMSFZsNGxj?=
 =?utf-8?B?TDYzV2RHdUY0aHJuNkppRStVWit1dkhuencydkhROFJkdXNWNDlmV0RGL3F1?=
 =?utf-8?B?Ny9QQ05TRS9WQXV4SGJQOU9ZRkxmbnVFQ05DZkJtVGdJRVczVFJjalVtMnRN?=
 =?utf-8?Q?/maKIFO7QAmPqcW/8k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEhSa3pKRTJlUkE1aVowdytWZmtxMEZ5ZWRWaEN1bVJEMitzdkxQR0RxM0NN?=
 =?utf-8?B?SG9xOVh6cW1paSttOHl2WHpzaU1XQkRqUEYwSXEvc1FsakIyY01wOXBybHJa?=
 =?utf-8?B?OGU3VXpTWEFDbXI3Y1A2V3lZaXhlOXVEaGlBRW8yU3pENSs2TXYwTVYrRVJS?=
 =?utf-8?B?L2dSd3I2c0k1QnpIOHFycnJmYnZ4UGlsU3RURUhkVE5BUnIrNlZPem5DSzdX?=
 =?utf-8?B?cVpzYkFYQkZZT2ZHdG03NEVVU3V2S08wRmJrQ1VhRkhRbTJURFpVdERiVDdS?=
 =?utf-8?B?VWlyYUZwRVdQNmpseHM3UzI0UGJVN3RKMlhRZG1lcUdJK0tLUlBpZDFoUi84?=
 =?utf-8?B?bi81VEhsZ0l4RzVhZGFsSFAraHZJY2xOWlQ3dmYxSmVVUXJuR1lpUzQ3MWNL?=
 =?utf-8?B?eGpIbHJYWWpyRXZJUGhUZUtRR3V2V1UvV1J4Z3VMWlJsdDd4eG5XbFkySzRE?=
 =?utf-8?B?MHVGeS9NY3NBVzI5bUJRZG5yK3F1bnJhQVova05PcElySnRLSlpwOG1Ra1dx?=
 =?utf-8?B?Y3FxN1RZdFY4eHpwUTBSNXBjZHhuempib042MGNYNWdUS1Zkb2F0blphRXdR?=
 =?utf-8?B?NVllQ0piM1NJVHVid0tWNWw5bVpYdkVER0FadDBGa0NRb0szU0dkYWoySVRV?=
 =?utf-8?B?emJXVkdIcGJOK2pRTEl3bDFLb1k1dmJTT3NCNXIyVWtRNHpOWlE4MnZoQUk5?=
 =?utf-8?B?WmZyUkZ1ZnMvMGsvb1NEMzhkRmhSUFpKMkpVOStSZTFOaFpBbmVwZXdDSlRp?=
 =?utf-8?B?dXRsQVV1UUxaR3ZPS3BZYkZjVlIyaTVtVHFoTmh0OFc1ZmFwVCtOSXBTbHhx?=
 =?utf-8?B?ay9QcCt6V0xoOExtTlkxT3RGeTFRWUd5RDBpYWZhektQU0x0eEU5dzVYbXNX?=
 =?utf-8?B?VWErK0luQ0lKbFpEcGpOREN3K05qRDRrTWpPRkloeU5nZWdReStHMkJuYjZ2?=
 =?utf-8?B?MHlsU2EzdDFXUlJvTTJNZVIrZWxVZGpJdHRpc0NIbEo2ZkpSTzVUelFaSGFu?=
 =?utf-8?B?eDlyU0VGekRuTGxiRzdtSURwcWxaUzlaOTIycTNpY2wvc2t1aUNsb1I5dTJa?=
 =?utf-8?B?T3hkZGRSOUcxZnNKUGxZTWxoRW9Zd2ZmYlU5UlF2UjlJQ2V4amRuL1FhY293?=
 =?utf-8?B?c0hENWVINXd6WUlSejVHM2NvMENYNUhZY09TLzRuaVo1Vlg4bUkzRHJSU29B?=
 =?utf-8?B?amlVWGJZMCtMakgxbGtqbjNWekxFQjZwUU5TWEhEcWpMZUNxMXIxYXZvV3NQ?=
 =?utf-8?B?eWp4b2hHYjd3UnNTTFdNcHhhc3BKeUVVR0g4b2UwSGxFNVJ6R3h2bUtiMkVT?=
 =?utf-8?B?MkZjQ3M4emsrYnpNeHJ2S0lPZ1FRTVJuY0FaMHd5TWg3NmM5QlYzNElwdll5?=
 =?utf-8?B?VjdHU3ExdWZIM2h5Tzl1bWFtT0I5bGJYRDJPcm0wNUxZS0U0NzFWQ25mNncv?=
 =?utf-8?B?aDdlQ3JpNHR0Y0FCL01NRXFuZ2tEOTU0MCtkRVgxdUlJeEpId0ZJaHpEU1ND?=
 =?utf-8?B?aTJIUzduODk5YzBvREF6WTdXTktYS1kvOHRlcC9tQjRMRDFoMnFFcWQ2MmJP?=
 =?utf-8?B?ZWc0N0wzQ1BTUFNTR1J2UzZPNUd4ak1oUkJuM094a1Z4YTRNZTZKVnVZdmg4?=
 =?utf-8?B?aVdlcFlNeUd1TnB6djkvdnJsOFdsN2NSbHh5TnptQVY0U0Q5SHhZaXhZbHhV?=
 =?utf-8?B?NDJldnlodnNsdkdBNnAzQkVZSmFqODhUOUdUOTE3V3ZoNFRRb0hha2M0OUto?=
 =?utf-8?B?OUpxalJ4dHpWZWE2Qlk5LzFrVkthVkx2dldrMElZMHFpZURYazBTS3dXMDVj?=
 =?utf-8?B?VjlkMGRWWkJsbmEybTVEdkxUUW9zeitlbm55TkRoaHBHREFYMXIwQ3plUFBE?=
 =?utf-8?B?anY3anFaUHZZdTFvNXlsOWRUWHBLWDY0RGlEa2FjbUNuaVJPMG1EdjgybDJw?=
 =?utf-8?B?WEhWOWRha2d3dzd6UUQ5ZkFXVjFWM0JpbnhpSlBCUHhYSTE5aFpsNXZmWTVZ?=
 =?utf-8?B?cndqbkFsd2VMR2h2cVQ0Wk9IOUNKRnVqcjdxMEFMeDNYdEdwVUNqTGFCVnJC?=
 =?utf-8?B?YUJrNE9HOTltTTNVS0dpMkpsS0Y0WjhqT1dkaGREYnpvYjdheVNIZFJaOEJr?=
 =?utf-8?Q?OSqg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209a4175-6f0a-4e56-fd06-08dca67cb6dd
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 16:22:55.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phfTT4HOKMIQDqJunSJo3I2JDm2tGRZg5R5bJdF2tVSLkuPOxsCQh96eIIq0nmwx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105

Hi Reinette,

On 7/12/24 17:17, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> Introduce the interface to enable events in ABMC mode.
> 
> As mentioned in cover letter, please take care with terms. This
> interface does not "enable events" - note that events can be
> "enabled" even in legacy mode. This is the interface to
> assign counters.
> 
>>
>> Events can be enabled or disabled by writing to file
>> /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>> Format is similar to the list format with addition of op-code for the
>> assignment operation.
>>   "<CTRL_MON group>/<MON group>/<op-code><flags>"
> 
> Missing a "domain_id".

Yea. Will fix it.

> 
>>
>> Format for specific type of groups:
>>
>>   * Default CTRL_MON group:
>>           "//<domain_id><op-code><flags>"
>>
>>   * Non-default CTRL_MON group:
>>           "<CTRL_MON group>//<domain_id><op-code><flags>"
>>
>>   * Child MON group of default CTRL_MON group:
>>           "/<MON group>/<domain_id><op-code><flags>"
>>
>>   * Child MON group of non-default CTRL_MON group:
>>           "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
>>
>> Op-code can be one of the following:
>>
>>   = Update the assignment to match the flags
>>   + enable a new state
>>   - disable a new state
> 
> (note comment in cover letter about consistent terms)

Sure.
> 
>>
>> Assignment flags can be one of the following:
>>   t  MBM total event is enabled
>>   l  MBM local event is enabled
>>   tl Both total and local MBM events are enabled
>>   _  None of the MBM events are enabled. Valid only with '=" opcode.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v5: Interface name changed from mbm_assign_control to mbm_control.
>>      Fixed opcode and flags combination.
>>      '=_" is valid.
>>      "-_" amd "+_" is not valid.
>>      Minor message update.
>>      Renamed the function with prefix - rdtgroup_.
>>      Corrected few documentation mistakes.
>>      Rebase related changes after SNC support.
>>
>> v4: Added domain specific assignments. Fixed the opcode parsing.
>>
>> v3: New patch.
>>      Addresses the feedback to provide the global assignment interface.
>>     
>> https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
>> ---
>>   Documentation/arch/x86/resctrl.rst     |  81 +++++++-
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 250 ++++++++++++++++++++++++-
>>   2 files changed, 329 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst
>> b/Documentation/arch/x86/resctrl.rst
>> index 05fee779e109..5a621235eb2b 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -331,7 +331,7 @@ with the following files:
>>        t  MBM total event is enabled.
>>        l  MBM local event is enabled.
>>        tl Both total and local MBM events are enabled.
>> -     _  None of the MBM events are enabled.
>> +     _  None of the MBM events are enabled. Only works with opcode '='
>> for write.
>>         Examples:
>>       ::
>> @@ -358,6 +358,85 @@ with the following files:
>>          /child_default_mon_grp/ - This is a child monitor group of
>> default CTRL_MON group.
>>   +    Assignment state can be updated by writing to the interface.
>> +
>> +    Format is similar to the list format with addition of op-code for the
>> +    assignment operation.
>> +
>> +        "<CTRL_MON group>/<MON group>/<op-code><flags>"
> 
> Missing domain_id

Sure.

> 
>> +
>> +    Format for each type of groups:
>> +
>> +        * Default CTRL_MON group:
>> +                "//<domain_id><op-code><flags>"
>> +
>> +        * Non-default CTRL_MON group:
>> +                "<CTRL_MON group>//<domain_id><op-code><flags>"
>> +
>> +        * Child MON group of default CTRL_MON group:
>> +                "/<MON group>/<domain_id><op-code><flags>"
>> +
>> +        * Child MON group of non-default CTRL_MON group:
>> +                "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
>> +
>> +    Op-code can be one of the following:
>> +    ::
>> +
>> +     = Update the assignment to match the flags.
>> +     + Add a new state.
>> +     - delete a new state.
>> +
>> +    Examples:
>> +    ::
>> +
>> +      Initial group status:
>> +      # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> +      non_default_ctrl_mon_grp//0=tl;1=tl;
>> +      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +      //0=tl;1=tl;
>> +      /child_default_mon_grp/0=tl;1=tl;
>> +
>> +      To update the default group to enable only total event on domain 0:
>> +      # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_control
>> +
>> +      Assignment status after the update:
>> +      # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> +      non_default_ctrl_mon_grp//0=tl;1=tl;
>> +      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +      //0=t;1=tl;
>> +      /child_default_mon_grp/0=tl;1=tl;
>> +
>> +      To update the MON group child_default_mon_grp to remove total
>> event on domain 1:
>> +      # echo "/child_default_mon_grp/1-t" >
>> /sys/fs/resctrl/info/L3_MON/mbm_control
>> +
>> +      Assignment status after the update:
>> +      $ cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> +      non_default_ctrl_mon_grp//0=tl;1=tl;
>> +      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +      //0=t;1=tl;
>> +      /child_default_mon_grp/0=tl;1=l;
>> +
>> +      To update the MON group
>> non_default_ctrl_mon_grp/child_non_default_mon_grp to
>> +      remove both local and total events on domain 1:
>> +      # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
>> +            /sys/fs/resctrl/info/L3_MON/mbm_control
>> +
>> +      Assignment status after the update:
>> +      non_default_ctrl_mon_grp//0=tl;1=tl;
>> +      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +      //0=t;1=tl;
>> +      /child_default_mon_grp/0=tl;1=l;
>> +
>> +      To update the default group to add a local event domain 0.
>> +      # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
>> +
>> +      Assignment status after the update:
>> +      # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> +      non_default_ctrl_mon_grp//0=tl;1=tl;
>> +      non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +      //0=tl;1=tl;
>> +      /child_default_mon_grp/0=tl;1=l;
>> +
>>   "max_threshold_occupancy":
>>           Read/write file provides the largest value (in
>>           bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 0de9f23d5389..84c0874d7872 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1068,6 +1068,253 @@ static int rdtgroup_mbm_control_show(struct
>> kernfs_open_file *of,
>>       return 0;
>>   }
>>   +static int rdtgroup_str_to_mon_state(char *flag)
>> +{
>> +    int i, mon_state = 0;
>> +
>> +    for (i = 0; i < strlen(flag); i++) {
>> +        switch (*(flag + i)) {
>> +        case 't':
>> +            mon_state |= ASSIGN_TOTAL;
>> +            break;
>> +        case 'l':
>> +            mon_state |= ASSIGN_LOCAL;
>> +            break;
>> +        case '_':
>> +            mon_state = ASSIGN_NONE;
>> +            break;
>> +        default:
>> +            mon_state = ASSIGN_NONE;
>> +            break;
>> +        }
>> +    }
>> +
> 
> No. As I mentioned before this makes all this work for nothing
> by preventing us from ever adding another flag. Please do not
> have a default catchall that unassigns all flags.

Will remove default ASSIGN_NONE.

> 
>> +    return mon_state;
>> +}
>> +
>> +static struct rdtgroup *rdtgroup_find_grp(enum rdt_group_type rtype,
>> char *p_grp, char *c_grp)
>> +{
>> +    struct rdtgroup *rdtg, *crg;
>> +
>> +    if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
>> +        return &rdtgroup_default;
>> +    } else if (rtype == RDTCTRL_GROUP) {
>> +        list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
>> +            if (!strcmp(p_grp, rdtg->kn->name))
>> +                return rdtg;
>> +    } else if (rtype == RDTMON_GROUP) {
>> +        list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>> +            if (!strcmp(p_grp, rdtg->kn->name)) {
>> +                list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>> +                            mon.crdtgrp_list) {
>> +                    if (!strcmp(c_grp, crg->kn->name))
>> +                        return crg;
>> +                }
>> +            }
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static int rdtgroup_process_flags(enum rdt_group_type rtype, char
>> *p_grp, char *c_grp, char *tok)
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    int op, mon_state, assign_state, unassign_state;
>> +    char *dom_str, *id_str, *op_str;
>> +    struct rdt_mon_domain *d;
>> +    struct rdtgroup *rdtgrp;
>> +    unsigned long dom_id;
>> +    int ret, found = 0;
>> +
>> +    rdtgrp = rdtgroup_find_grp(rtype, p_grp, c_grp);
>> +
>> +    if (!rdtgrp) {
>> +        rdt_last_cmd_puts("Not a valid resctrl group\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +next:
>> +    if (!tok || tok[0] == '\0')
>> +        return 0;
>> +
>> +    /* Start processing the strings for each domain */
>> +    dom_str = strim(strsep(&tok, ";"));
>> +
>> +    op_str = strpbrk(dom_str, "=+-");
>> +
>> +    if (op_str) {
>> +        op = *op_str;
>> +    } else {
>> +        rdt_last_cmd_puts("Missing operation =, +, -, _ character\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    id_str = strsep(&dom_str, "=+-");
>> +
>> +    if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>> +        rdt_last_cmd_puts("Missing domain id\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Verify if the dom_id is valid */
>> +    list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +        if (d->hdr.id == dom_id) {
>> +            found = 1;
>> +            break;
>> +        }
>> +    }
>> +    if (!found) {
>> +        rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>> +        return -EINVAL;
>> +    }
>> +
>> +    mon_state = rdtgroup_str_to_mon_state(dom_str);
>> +
>> +    assign_state = 0;
>> +    unassign_state = 0;
>> +
>> +    switch (op) {
>> +    case '+':
>> +        if (mon_state == ASSIGN_NONE) {
>> +            rdt_last_cmd_puts("Invalid assign opcode\n");
>> +            goto out_fail;
>> +        }
>> +        assign_state = mon_state;
>> +        break;
>> +    case '-':
>> +        if (mon_state == ASSIGN_NONE) {
>> +            rdt_last_cmd_puts("Invalid assign opcode\n");
>> +            goto out_fail;
>> +        }
>> +        unassign_state = mon_state;
>> +        break;
>> +    case '=':
>> +        assign_state = mon_state;
>> +        unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
>> +        break;
>> +    default:
>> +        break;
>> +    }
>> +
> 
> this flow is not clear to me ... I see how an existing counter is
> configured but I do not see any counter being freed/allocated, where is that
> done?

My bad. There is a bug here. The following code updates the assignment
states if the group has the counter assigned already.
I need to add the check to allocated/free the counters based on
assign/unassign state requested. Good catch.



> 
>> +    if (assign_state & ASSIGN_TOTAL)
>> +        ret = resctrl_arch_assign_cntr(d, QOS_L3_MBM_TOTAL_EVENT_ID,
>> +                           rdtgrp->mon.rmid,
>> +                           rdtgrp->mon.cntr_id[0],
>> +                           rdtgrp->closid, 1);
>> +    if (ret)
>> +        goto out_fail;
>> +
>> +    if (assign_state & ASSIGN_LOCAL)
>> +        ret = resctrl_arch_assign_cntr(d, QOS_L3_MBM_LOCAL_EVENT_ID,
>> +                           rdtgrp->mon.rmid,
>> +                           rdtgrp->mon.cntr_id[1],
>> +                           rdtgrp->closid, 1);
>> +
>> +    if (ret)
>> +        goto out_fail;
>> +
>> +    if (unassign_state & ASSIGN_TOTAL)
>> +        ret = resctrl_arch_assign_cntr(d, QOS_L3_MBM_TOTAL_EVENT_ID,
>> +                           rdtgrp->mon.rmid,
>> +                           rdtgrp->mon.cntr_id[0],
>> +                           rdtgrp->closid, 0);
>> +
>> +    if (ret)
>> +        goto out_fail;
>> +
>> +    if (unassign_state & ASSIGN_LOCAL)
>> +        ret = resctrl_arch_assign_cntr(d, QOS_L3_MBM_LOCAL_EVENT_ID,
>> +                           rdtgrp->mon.rmid,
>> +                           rdtgrp->mon.cntr_id[1],
>> +                           rdtgrp->closid, 0);
>> +    if (ret)
>> +        goto out_fail;
>> +
>> +    goto next;
>> +
>> +out_fail:
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +static ssize_t rdtgroup_mbm_control_write(struct kernfs_open_file *of,
>> +                      char *buf, size_t nbytes,
>> +                      loff_t off)
>> +{
>> +    struct rdt_resource *r = of->kn->parent->priv;
>> +    char *token, *cmon_grp, *mon_grp;
>> +    struct rdt_hw_resource *hw_res;
>> +    int ret;
>> +
>> +    hw_res = resctrl_to_arch_res(r);
>> +    if (!hw_res->abmc_enabled)
>> +        return -EINVAL;
>> +
>> +    /* Valid input requires a trailing newline */
>> +    if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +        return -EINVAL;
>> +
>> +    buf[nbytes - 1] = '\0';
>> +    rdt_last_cmd_clear();
> 
> rdt_last_cmd_clear() should be called with mutex held

Sure.
> 
>> +
>> +    cpus_read_lock();
>> +    mutex_lock(&rdtgroup_mutex);
>> +
>> +    while ((token = strsep(&buf, "\n")) != NULL) {
>> +        if (strstr(token, "//")) {
>> +            /*
>> +             * The CTRL_MON group processing:
>> +             * default CTRL_MON group: "//<flags>"
>> +             * non-default CTRL_MON group: "<CTRL_MON group>//flags"
>> +             * The CTRL_MON group will be empty string if it is a
>> +             * default group.
>> +             */
>> +            cmon_grp = strsep(&token, "//");
>> +
>> +            /*
>> +             * strsep returns empty string for contiguous delimiters.
>> +             * Make sure check for two consicutive delimiters and
> 
> consicutive -> consecutive

Sure.

> 
>> +             * advance the token.
>> +             */
>> +            mon_grp = strsep(&token, "//");
>> +            if (*mon_grp != '\0') {
>> +                rdt_last_cmd_printf("Invalid CTRL_MON group format
>> %s\n", token);
>> +                ret = -EINVAL;
>> +                break;
>> +            }
>> +
>> +            ret = rdtgroup_process_flags(RDTCTRL_GROUP, cmon_grp,
>> mon_grp, token);
>> +            if (ret)
>> +                break;
>> +        } else if (strstr(token, "/")) {
>> +            /*
>> +             * MON group processing:
>> +             * MON_GROUP inside default CTRL_MON group: "/<MON
>> group>/<flags>"
>> +             * MON_GROUP within CTRL_MON group: "<CTRL_MON group>/<MON
>> group>/<flags>"
>> +             */
>> +            cmon_grp = strsep(&token, "/");
>> +
>> +            /* Extract the MON_GROUP. It cannot be empty string */
>> +            mon_grp = strsep(&token, "/");
>> +            if (*mon_grp == '\0') {
>> +                rdt_last_cmd_printf("Invalid MON_GROUP format %s\n",
>> token);
>> +                ret = -EINVAL;
>> +                break;
>> +            }
>> +
>> +            ret = rdtgroup_process_flags(RDTMON_GROUP, cmon_grp,
>> mon_grp, token);
>> +            if (ret)
>> +                break;
>> +        }
> 
> can these two blocks not be merged? strsep(&token, "//") and
> strsep(&token, "/") do the same
> thing, no?

Sure. Will check.

> 
>> +    }
>> +
>> +    mutex_unlock(&rdtgroup_mutex);
>> +    cpus_read_unlock();
>> +
>> +    return ret ?: nbytes;
>> +}
>> +
>>   #ifdef CONFIG_PROC_CPU_RESCTRL
>>     /*
>> @@ -2282,9 +2529,10 @@ static struct rftype res_common_files[] = {
>>       },
>>       {
>>           .name        = "mbm_control",
>> -        .mode        = 0444,
>> +        .mode        = 0644,
>>           .kf_ops        = &rdtgroup_kf_single_ops,
>>           .seq_show    = rdtgroup_mbm_control_show,
>> +        .write        = rdtgroup_mbm_control_write,
>>       },
>>       {
>>           .name        = "cpus_list",
> 
> Reinette
> 

-- 
Thanks
Babu Moger

