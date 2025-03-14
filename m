Return-Path: <linux-kernel+bounces-561957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF90A6193B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A783D19C51A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3B2045A2;
	Fri, 14 Mar 2025 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jvu8thx+"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850661FF615
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741976315; cv=fail; b=GOrhqa59UYkcBuTPZy3PDBIFtHO+2MIBgxI6QyDFznKEJmm0X9aoVbN9V8NuMIdsaxkyKwITQBRf950qVo8tRMr4IIFfNn9lVc/2iP5FBJT/Kc9MeGFPqrk1zE5Mbx0TQoIna2pDik6ps41KamlE+i9lopTIRKuvyU2TVUno3DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741976315; c=relaxed/simple;
	bh=e5lGeI5hdP9tT0bVzw0krQumn0wfsmDJ90KmBy5eGXM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bu1eivmjOd/ae3L+jMdGe+41XzsXIvt1kpDkCTGl3L3pY9NRjZwjCdwWER3BvisKXEH7qHeELHdSGxM1Cy4j/d0tEYBIQpjT9jQyeVqmclIIxjeDB9WRQRj8gjW8SdXN6CADTfpYWVu3jrO+mRuH7BgktCH4e8mnwsmtH4yXRv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jvu8thx+; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKZWHAFGpp9PLaElv2keqNWNGmj0LMnNliUFiVyGLnEVgCthMkp6/LSC1+fHBtv+E6qsxymsHZnfmCXGAcuUB5xyWdeqeOoRjWzOQKBCUWAPsq8c4mQupGQNeD/dTe0i2l2UGDoVtd1WiKtOJywTl232UVck/QlZhRbBaka9IAtS+wRVTMwosNqbAFVZZOZiVQneGm1uvaDBEchl0ZYaizTeCc7xpkU2uZjAlqq9jXy4FDbrEXTs5amVuG9VGVj3qyWCuU6SFUaRvuUS8ycUs0zr5/QxlWdFa8nG35Rp+xn90kuCSGfaaibfwp1YYfWMSf5n5LFN+T2NrY12hxNjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys1sOS7Du9/OLwdC/XFVZrK+phPub0PeBlbkO15K0tY=;
 b=gpUnt9M491wLdoGMHoqqPmv3vaXIWjzNb39jk89ByOSs7uHXcCq4F7S9m6U47XSXZsOfopStKt5yKmZ1ww+b+wM2UJyR1OAre8I1D8BslOZxHLszK/Rc71vBv8a8fb6ms5Lk1vVD1nI2KAjStCIyucKGJel7atl74ErQmX5T6FNRO+rJXfpYxNgH39cSczB1Utm5Dk97Ofhccb9EAmBBrMjjEEFdL6bh9sebVBlE/lmp42Fp+cEeXVKHCEWDX5sZasFYvPMidnC4rzM3oDfUS3py8FBMUZKKd6R05sOYbGM5o/rFTM4UYwy6Je1PSDK+5d4Xs4wvbgXWBwrGGEsy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys1sOS7Du9/OLwdC/XFVZrK+phPub0PeBlbkO15K0tY=;
 b=jvu8thx+nNbss8bWF3BjP79vum0sefM9F5Br8eWah7SBu0UEZnse8Yev/fIsoi+aCvh3hSa1RrSjaErFg181wjTPpj7hfXozEt+EBMEPt1+eDTfR74iYAYbIrAvPgKTJW56mo/fGU3HSi9ebaoB8Vv/xRLsatNLec2hhJ0gFlV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 18:18:29 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 18:18:29 +0000
Message-ID: <8828599d-e251-7b8d-c6d5-31383d8b5b9f@amd.com>
Date: Fri, 14 Mar 2025 13:18:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Hansen, Dave" <dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
 <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>,
 "seanjc@google.com" <seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sagis@google.com" <sagis@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "bhe@redhat.com" <bhe@redhat.com>, "Williams, Dan J"
 <dan.j.williams@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
References: <cover.1741778537.git.kai.huang@intel.com>
 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
 <e7adcb16-ff6c-d901-155b-866be4de2d40@amd.com>
 <d7805e17b7f09b08384406168571d1bfd019b77b.camel@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <d7805e17b7f09b08384406168571d1bfd019b77b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:806:d2::11) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: dc99673a-ccbe-4781-6028-08dd63249efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFZQUVFXbnRiczRieWNVSThBYjV0L3NTa1o4OVhlV2VkOTMwd0pkRDR2TjFl?=
 =?utf-8?B?andZMFA4TjcreStKZGI3NHV6ZXFZRzZ0ck1Td2I0UFljWkw0ZENSeFdRcDN5?=
 =?utf-8?B?TTh5N21Cc0x0aFk3bnlEaDRkbzJuL0pjTXQ0REJJYkFweUJrRXd3eG5aalBt?=
 =?utf-8?B?SjJEWFdLL05zMkswUTJwUDNta2RNVGExc3NjOEp1eUFwbWpYQklpVU1FSDNZ?=
 =?utf-8?B?L25sZ3ZoYnJDblFiK2dHK0pCS2xZeXUvbWxwL0lzTkhEcUg0M01ud1hKTm80?=
 =?utf-8?B?R0MrNi8xTTByYkxPMkR5Tyt5L2dHazNRZ2JkQitnS3ZzYS9ySkZ2ZGtzNXVh?=
 =?utf-8?B?ekM5enN0WXloR0hBcXZ1TkdqVjEzM1Rrdm9PZE1FQlJxdGppNVJKQzNXSnI1?=
 =?utf-8?B?YmxJVXR4N1ZEWUVpUFR5OXBnTXpqWnFidWZvUmNicVdtY3d6UFJKV2VpY2Vq?=
 =?utf-8?B?NS9mYkZRYlgzU29FUzRFU3U2YTZMcm5mcWRFOXIwY3o5b2paZWFVdnM0NStK?=
 =?utf-8?B?enNYeDdMbVlRc3VOekpQY1doUHdxTllRdnN4Z1ZCWHVicmkwUk5Gb2kxSWpN?=
 =?utf-8?B?YWFJbHpvRUdkWkRXaGJHNkIrb3czZTFEODk5cHJ4TStqUVFlSFp4VVk4aHEv?=
 =?utf-8?B?dDc3WEVNYWpPRmlmb002czR2RHY1N29NbmRvR1F5Z1hsZFdPMFppeWFaREJL?=
 =?utf-8?B?YW1tczVqUUtCOGlXakcwS0swZzFUc0dVUisxZklDZXNFQTlsb2NtQXFnZWRR?=
 =?utf-8?B?NXRla0xvVzdRbUZSWXVVc25ZeWlzVnBpZHJsNnlZcjlDZHAra25pZjlReEQ3?=
 =?utf-8?B?akplNm1MRXlUd0E2MDJOeXFETHpXN3oxb1JMVzF5anJvQllGaElwaDBJcjFl?=
 =?utf-8?B?YlhrNDVqUEJFc2ozSFVuMm40R1RUUEwwd0F0WkNkd2tTWXVabWJ4QWRIWWNF?=
 =?utf-8?B?UmJ2S2YrK1JtMlplT2tnV2Z3RW9RdUVUbklYR0ZnOGtxUHdYbnVjL0NUeVFW?=
 =?utf-8?B?aUpKdzROU0wvNGZwS1RIajRRTDV3S1ptSzV2YUlNekd4d1liZEVkWUNPd3lN?=
 =?utf-8?B?RlFFUUpzaW1veVpSYk5UVzFjcXVsVUE5Q3VEWGczZW45ajVKeHk3ZWFmQmJp?=
 =?utf-8?B?UmU4Wi9UWVFONVhoaXZNQTdXek9EOEZHR0dkdWlsRWp0QkhJNHRuOXM3cG5o?=
 =?utf-8?B?ZkxCNURaWnJMT2Z5Q1BrbW9uMkdSeWFKNXZ0TnlzMUdRajJ6aFR3UDdNR2t5?=
 =?utf-8?B?R2JyeGdZUWNKdE82TUxWbC9pQlVnRk4vRlduVTVXdDVTaU0zS3lDUGo2WFJG?=
 =?utf-8?B?ZmdFOTcxcmd2eHk2Snh6ZGpSVE9zL2Zzdi9WNkJaUmFtYzJhUElVMWhDcmRl?=
 =?utf-8?B?dGVzUWZwWm9RaG5rbDIzUkwyN2Q4QkZOWmI4dFRPNVVsMWU3R05ZelV1YUpz?=
 =?utf-8?B?UFVQSlp4YjZaV0ZTazFRcjVCcWI1U3JYb1N4eURMcXBnWmNvQ3JsaTlEK3Zz?=
 =?utf-8?B?YVJZVXJuUFdtS0NWckpEeFJlTDlScVBFd0IvNWZ5dGVYWWlwbUxQTjJ4UmVj?=
 =?utf-8?B?UVVubUxGSThVcVJaU2tDWW5MU2RTUmxNQ1ZVVGV1R2d2a29PeGxZNzRFY0Zv?=
 =?utf-8?B?WHRQaXFIQmZ3WmlGdHZLdUtqQ0NhNVhpSmMrdXhjZ1UvbC9QMDVBSlErTFBN?=
 =?utf-8?B?U2pDcDBNa1BwS1E0WW1JWUJ0VHVGOHh5TnBXVTJMeUh3VjgvQTRxeVIxRm1k?=
 =?utf-8?B?VktGS0tvMnEyZ0p2cFE1UnpsNWhqb2lIempZVm5HVUdZRUlKQ2dYaUhwa0tC?=
 =?utf-8?B?KzlYRGhNSFNrckhZb3NJaldFYU83ZmRWYXZzR2I0NnlHUXlYLytrRVJmR3dM?=
 =?utf-8?B?Z0xHbkFVY1lGWnJWeWxzdjVZb3RuajFFL1FManZVMlVXV3pqZmZSdjVjR3hu?=
 =?utf-8?Q?qd8k6thqCmE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REk0WmdHaE1yOCtNRkI2TUF1THhuWUViQTJqL1pBUmdBZzErN3ZhWHV1emY5?=
 =?utf-8?B?bEtTZWx4QXlUSW1keGtCM2wvVHNaZjF3M1d4WXNRK0xqeUlhTUd0aldvbWN0?=
 =?utf-8?B?Zmx5TXpnM1E3bU10WUMvdXJjSGtHcUcyOVBBWTdWTUM2SkRTQWtjczFQWlJh?=
 =?utf-8?B?Um8rczIzUGFWT01VMmM1blE4SjBxL1g2YTRQblZWV29YWkxSdmJ5MlhsUkVM?=
 =?utf-8?B?QXgxaUIza2NVUXRoNVdHeHlDdXhlMk9PSUVlVU9UQ2o1MkJHbEpNZkRaWUpk?=
 =?utf-8?B?ckZVdHUvdWZaTDBTNGtQa3RoRE1JWTMwY0xZVmpnQ3JiajNwOVpjdFcyL1Q5?=
 =?utf-8?B?cGNrZDhQOTY1aDY1RVJyeUtabzJheURxV0NuenVrTmJoZmhzV1cxdElYNENY?=
 =?utf-8?B?d2NlTGR6SUVqV3JkNll3eGVGc1Z0K0RUaDBnc3FyeXZSVm52ZkRHYmxuTVMy?=
 =?utf-8?B?dUtTVmZmOUNoSFpHOUw0eVc0UVRob1hiRkY2NHRYYVd4ZHl0YThmcUNzekxL?=
 =?utf-8?B?M1h0eVhhTWQrWnNzWExPT1BNMGpoeTFKUHZLWk03QlJkMDBYVU9GaU8ybXJP?=
 =?utf-8?B?T09yL3RkbDR0bTE5L1FIZTJnRi9mZTgzTkd2QWZ3dTEyVlB0NDVvZ2swYUxP?=
 =?utf-8?B?WEhyQVRCdjdVWE1HbGRQczFVMWRvWjZ5WitVWjV2S3BkL1hBRHdOeFl1NFlL?=
 =?utf-8?B?MkZqRkNELzFMUmFRTkZjNzBvSTNMWHh1c2YyQmcyZGtQNFNweTlwKzVISlNV?=
 =?utf-8?B?UjZRZ2lULytQZ2lLd3c5V1ljQmFPYU45VFk1VXRSb1lRYTdSWS9FZFdFb1Bn?=
 =?utf-8?B?Sm1SS0ZHQ0pWSTZrSU8vbXBEZEFIbURZVmlnWDBNS0lVSGZFRmpSS0pxSEJ2?=
 =?utf-8?B?RTNYc1dXMlVicmREQkVlOGl0WjNLUVoybkQyZVhSMXF5cVA3U2RLam9yOUp3?=
 =?utf-8?B?Z05odmxwUlA4M2k5SC9ycDZhOVVVTDZkZm0rRzV2VFNTNU1IRmpWa3Rxa1hl?=
 =?utf-8?B?R1F1MTNTYTN5bkUzVWVKTWFYSVF6dDZMNW5qRFl2K3hKSlM0YUQ2cUE5ZWhh?=
 =?utf-8?B?c0x6Q3NtQk1yQ1VHejk2bDRORCs2Z1VkWTFDdG8xS2xZKzJGNGF4akgrNTJY?=
 =?utf-8?B?R1hnditCS0xuV05mcjZpamx3MDVGeDlvK2ZyR2pqQWs3Yi8rUG9Zd3FOZlpJ?=
 =?utf-8?B?TURNWnp1ODlqSnNvelJQSk0wWkpubG5Ma3VYUUJ0U2hoVUI0NFR4YVE2Q1Rt?=
 =?utf-8?B?M1o2c2pDTFlTWkx5d044djA1RTI3a1o3YVVpRFVENmF1eElhT1FqNSt6Z0R6?=
 =?utf-8?B?OFVuelBwNDcyRTR5TVdmQ2Z5YjEvV200bTE0UnAvREFtVnIyTW1LOTBCWjFs?=
 =?utf-8?B?RXhhY1ZsUG8xZnlwWHYzVkkySE1DZ09oWnBRT0c0cFJ6ZEpZc1JkeXZlN0VI?=
 =?utf-8?B?Rmd1dDJCYVdSWGlzdFdkcWxxT3pMWktaUE9odXJXS1JHdisxWi9COXp1dXBG?=
 =?utf-8?B?ZXRTU3IrbEhqZGRpQ1ZONVBaVjZGVHZzWVF1Um1uMnJQSkFhOHlTY2Q5ZzFq?=
 =?utf-8?B?OXZoTWJxa2ErWklwZVhsSzNJWHNnMHBWL3luNDIxRzFuUUczNnN3RnJwWEFy?=
 =?utf-8?B?VzAzUUVkTU1yaVhDaGdiSEc3NGJjZzJncFlGall4VEZGUndFc2I3Z1Y2a2Fw?=
 =?utf-8?B?aG0rSnR0dFpWTE5jSThkRnlueEtOdVlWZVZaNElFVmtsM1llelFXcGROZnV2?=
 =?utf-8?B?clRBMXVQdVpJU1FSWG1JT1dsYkFhT0d3WlNqQUNkMU9hNWdMZUxDZ0djSEd6?=
 =?utf-8?B?Z1hYcU96WUY0MUsxNmFvR21iQlp5eE1BelhIUFFCWlM4NlpNaDJLeTRCeEVr?=
 =?utf-8?B?SUJ2S0pLTkdncW9nc2xLcThCRVhUS3E3OVBqL1hyZnQ4V3pNeDJmV3JmM21j?=
 =?utf-8?B?bVNudWJpQnNvVzNlT0hpY0xjUUQxRGpqK1drc3BNZXhDSkNDNzk5dVRiSGZP?=
 =?utf-8?B?dlo2dGNtc2YyOVdFYjBzQ3hmQnBzQ25NdmVXblkweUpDQithUThMaHg5blVY?=
 =?utf-8?B?QVFucTJGbWkrcFgzT1hZSFRua2d6enU3L0E1d2RsL1JqK29XZGlyeVIvTStl?=
 =?utf-8?Q?EDZbFyaFDeWVwNMD7S8sH602f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc99673a-ccbe-4781-6028-08dd63249efa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 18:18:29.5512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFZr7jrA/x0Rb7VYohNCwYbso/eTJ9s4CMS721X12SWZGn0uB6ZrHUcgPwq03o23M+tb0VKBNUaNXktNPVHNgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

On 3/14/25 11:28, Edgecombe, Rick P wrote:
> On Fri, 2025-03-14 at 10:11 -0500, Tom Lendacky wrote:
>>> I see that this already has Tom's RB, but I'm not sure how this works for
>>> AMD.
>>> The original SME patch tried to avoid writing to memory by putting the
>>> wbinvd
>>> immediately before the halt, but today it is further away. Below this hunk
>>> there
>>> are more instructions that could dirty memory before the halt.  Ohh... it's
>>> new.
>>> 9 months ago 26ba7353caaa ("x86/smp: Add smp_ops.stop_this_cpu() callback")
>>> adds
>>> a function call that would touch the stack. I think it's wrong? And probably
>>> introduced after this patch was originally written.
>>>
>>> Then the cpuid_eax() could be non-inlined, but probably not. But the
>>> boot_cpu_has() added in this patch could call out to kasan and dirty the
>>> stack.
>>>
>>> So I think the existing SME case might be theoretically incorrect, and if so
>>> this makes things very slightly worse.
>>
>> But the wbinvd() is performed after those checks, so everything gets flushed.
> 
> Oh, right, duh. Thanks for checking. Yea those shouldn't matter.
> 
> Does the stop_this_cpu() part never come into play for SME either? It looks like
> it was added for TDX guest kexec, but is a general ACPI thing.

It is a general ACPI thing, but I don't know of it being used by our MADT
tables.

> 
> Regarding the kasan thing, I was looking at this too:
> wbinvd()
> cpumask_clear_cpu()
>   clear_bit()
>     instrument_atomic_write()
>       kasan_check_write()
>         __kasan_check_write() <- non-inline

Yes, this does look worrisome. Too bad there isn't a way to turn off KASAN
for a single function.

Thanks,
Tom

> 

