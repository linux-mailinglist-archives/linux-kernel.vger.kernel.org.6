Return-Path: <linux-kernel+bounces-549976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF54A55965
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB5B7A9D48
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F72327605B;
	Thu,  6 Mar 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J+qkD+8+"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA6519E967
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298894; cv=fail; b=Xw87hO7j1h/htwozsTBeti3NT4yQV57X9++79RlduZP9uxsWm/GrS8ABA+ZE7R6tBNBTIglAOT7iAa6RU6MYBlo+Opo59bbmrgLUifygQBLVSzJh8fCWuIY1Y1LsIQTWQ0ktkI1iE7c2fnZ2IvQPxb0jZXYzpEfhvNuzvhqMyr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298894; c=relaxed/simple;
	bh=Kx2Ia4wO3Z8GCyh1+xM1WaAhPlT4ZsWPC54uBZOwu+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f0HY2UtwZuOtvRmkoQzfleThr8yISAX2x+9EiKUG5LXEEA+nrMqAcl0TIR6m2N//ddBS95qVl78i62spdBmdQ1phSFFTZV4HHvqqNm9oz6XMP5WhFY8vJwrE1Kz2e7KM4jfzqQgZJPTlvVmcc2xUMU9BS2ZBC1fqGbch2OM06CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J+qkD+8+; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXuCijEEqMyzsHpC01bwGcm601XuomsFul8Q7IsGdhjvy8lGikskponmpisNODOrNreRErLlZq+h9ihiU03p9FvQ4mTT6q4ycn+45BLgYPxr8c6RffPFXRnxiu0gS/QzIuLUQ0b8FAg4Skv1AT50sqLB3M6du3l0VBsdCP05ZhHVI7mfxkREtALz7/tkh0jypti/MZUsbs3fKnJm7toWSkvche/8knQsjT9yLZHM2GxSlHPL58TdYx4eBXUoRwc/1XJjybA3Dj8XvBRUUWnyKwqP8/4sBw2X6EG4Zpqmmy+lXnZhDRu1csmvGuZ8QUb9lHb3WlYiuYHc58vfh2QndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx2Ia4wO3Z8GCyh1+xM1WaAhPlT4ZsWPC54uBZOwu+s=;
 b=XW9NwfKhZHoQThx1BZQHtsYR1QoHEG0RmZv71hqymMPPG5iAv+jMjXHSWf+ljgLlAdIMw6HB10QnII+oCOUxcUcSXectg+YjcoPhWDwd81HTZdPby6sI2yHgV7bgD6Q6XI5jTWskWyVgbZXfmOaULpexiBC4A9yh0ze+NZlnmjwfIYry7Rb8lLbpp9ALfG27gW4t91kVTGnood/exY6GdRDokZbUVtcFDs0rwcFcLySUzE6crJEbA4He0Kr+egBsIPrq8x1L4Fpc42aQAdvokiosgEIWot8cqkna5qxoAOuEJUmgyhNVShRiGt9VEXD1JG2ECB1vpwU+2G6dbckWFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx2Ia4wO3Z8GCyh1+xM1WaAhPlT4ZsWPC54uBZOwu+s=;
 b=J+qkD+8+83+OkDEC26N32c4yNU/TETf7r4RLWZP3TGhOTUEkUVBptBGDsJ7yvZuxGgdIt7iW72mXZf05BBtOoQF6mnpssUDTe00uKI4YGARQ8Slmm61CPE7mCqLwmAmZ/BrfQ1MGiO9xsHxNam9JarC9YoJI8Ofd17apAfjwF8vLHQNHje677thaM++7aG514X9Md11SiYJ34N+zoJPWQabvbAEhEGcgEU0bQH7Gwhvf62DSxx+7QDFJDr1gZCC1nCkIqXeVGfjeDxj/2n1x7CcnVEQjFrCdjMolyEzjX5eYRBHp4WlWnHe/P3DoSBC0voMwaMkaKMXR0Wc6YxZoeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 22:08:09 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 22:08:09 +0000
Message-ID: <b3d65d17-293e-4f28-8655-c8a33c56417a@nvidia.com>
Date: Thu, 6 Mar 2025 14:08:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 30/49] x86/resctrl: Move
 get_{mon,ctrl}_domain_from_cpu() to live with their callers
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-31-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-31-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::35) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd234bd-8fce-4647-c812-08dd5cfb60eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am91V0ZIRFJTbVVtZDFNOU5JSnl0cFA0ZjhIaE00N3Eyd0RNdk5EWEpBeDBw?=
 =?utf-8?B?T3l1SFpkREZFZWJlRjFXYUx6QXNYNTRBTUxQMWR4TVQ4czZTLzZQWWN4L2J2?=
 =?utf-8?B?bm1Ic1QwTmhYNjRBbVF6ZUp6b2FhcVdBV2dUVVpmWllVRExHRkk4bUJkV2lh?=
 =?utf-8?B?TzFObjBERWVvMnRSeDFNOWk0S3JBa2tuZEdXQ1VnMjRmcE1jeFpvd2ZsVndT?=
 =?utf-8?B?cU4vM0ozd0pwMHJnSjcyaUxKdDkxV2FsbGxSdTUrdmErWnhFMVVUU0tVaWIv?=
 =?utf-8?B?RGpCWC96RFp1cjJEU0JEajQwWXhBYzBTajdOb1VSODZmWktMSytyZzlpRjRa?=
 =?utf-8?B?a1JQVUNoQ2V4RFVBOFI2bkRVbkNNSWY4di9lVjdJRDJKTThqTis4TFg0Z2t6?=
 =?utf-8?B?eGVudkpjMzdZWXQ5YVBGZEhDN1NzSkR5ZGhBRjBlQ2oyMkxOdjZuQ0h1UUtm?=
 =?utf-8?B?UW9wYXFiTEVKWnVnRWdOZHFSVFd0dGJqT1BnZjFjOU5qdWdaRjdEODNSbTNq?=
 =?utf-8?B?VnpSNmdwTDJIc25TbklVNDh4cjJwY0VTUnpjTmtTM1ZlQmUvVWdZZDR2WEpG?=
 =?utf-8?B?WVovK3czV3Z1RmVmMXJScU14bzVlT2R4TUpBamVtV05nNk5QZjlZNWREZkVk?=
 =?utf-8?B?WDRVT0Q1OXhqM2VPNFFrejAyMUZFS01nNXgxL1VBZTEweEljYUkrekJiNFR4?=
 =?utf-8?B?UElueUc2OUFkYTlHb1RVSXRFem92RDMyd2sxQm51NUs5bnlrUUVUdFIrNFdx?=
 =?utf-8?B?YjdZc1NQTmJETHpJMFJHRlBFampZc0pKKytuTlFlNW0vSkc3bFkxU0hnaFh3?=
 =?utf-8?B?WWpDa1Z6RVR4b256WFpMNDV4Y0N3TEtCcWNCVFhUNnNhMHpOYytsK2lSNk1N?=
 =?utf-8?B?OFg4UlZDT1k1WWpVT1ZsbDJSTHlCbGVoVmxXNEVWbXJPTklwcFkwYjl3Yzh3?=
 =?utf-8?B?cW5wWm4ycnpWREI0cVNSRlhybUIwQ3h1ZWU4c1JFSTlMTUJ1NkNoSU83NVQ0?=
 =?utf-8?B?WmRHSC9IeXpGMlREWjVjVlN5SVc1Sm81Zzl6cWdIZ1VTWmh4WEtmOGFjdGhC?=
 =?utf-8?B?RmJyREhpTWRObk52MHh3L2NoWWZlZjNHcDdaempYTmhhaXBDNDZSYWNIN1I1?=
 =?utf-8?B?SmFHdUNxaXFubDlXS25sSHhDOG9aTVJkaHZDRWNPdGhOa2lwSjh3dkZnUlVD?=
 =?utf-8?B?dWZDOXNObFRJQmFjTVdVYzZFeG5tQklMQjhiRC8yU3pmWHVlc3VkdzlxZ1M0?=
 =?utf-8?B?T2tmSEZBM2VrbFNuZUVZK3VUK1BZK1FqdXBJZ0dFQzJ1a0p0Zk5XVldGeFRF?=
 =?utf-8?B?NzFvSitqdFVNSlpWZU5lU0ZjdURYSHZ6RzdJbzZXbU04N2NlV0pYSkYyN1FT?=
 =?utf-8?B?WUxjT1Z3NWowV0c3aUJwcVEwQjdHbU5odElLSnNtSkduVng0RGh3STR1cWI4?=
 =?utf-8?B?cXlOeVRVUXhyejlEbVE3enhuY0RPNlorSnY2SUROd3F0U2M2UnhRdHdSeFdU?=
 =?utf-8?B?eTRTTlRKbDh1RFNiU0ZEdmpQcmlPa3hUV2U3OE10NGxaNncxdEk4c0xkTUNR?=
 =?utf-8?B?RWRlQzJ5RmVScDJOV043Tm9DbnVlalZud2YxSGM0L1k1cW5tNHZVbDNVc2FP?=
 =?utf-8?B?RTFoK0lBN3EvZE1GR01LNU5EMzhoVjczNCtSZWJ3V2JpalFtRkQyUC85dFlF?=
 =?utf-8?B?QjVCTnVDRlBITC9rVnJkODlBakp0YUJ4emtuR0VTWWp3TGE3MkdWZVFhbGE0?=
 =?utf-8?B?VzFlUjBkckpEcFNTeDU1N2JVVU1nZFRLTGo1SmkzNC91MkNRTlRkU0lXMzlh?=
 =?utf-8?B?WVZoWms2bmxnZU5jeGl4cFZVUzZPRFVIdVNXeXFVT2lQRGRQUDdVVWVEYThv?=
 =?utf-8?Q?sT6YuATX2vAl8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVZEWjNGMEYvMkJFays4ZGlXSmY0anRkZXkzTlRjTU1UaVpUZzUrN205L2xz?=
 =?utf-8?B?OEx4YUlLYUhnTjFxb2MzKzFOd3ppc0lDUVlpVW5yZWhlWkQ5Q2xBbWZtbS9i?=
 =?utf-8?B?UGQyNFVuUnYvanU2VlE5WWZMM3oxQityNGtRemVWWWwyL2NVY3NCQVNEOXVF?=
 =?utf-8?B?eHVZQUltMVVOWEJnM21wVWVKSUl5VWtlY3Q3T0tJWi9aUkZ1UVBXZGhua25y?=
 =?utf-8?B?bVYybE1Mb1p2N1JhMjA4dnE1UUdXSzJCVUxaQ0hSUWJySk5IdHh2QVFUdmFx?=
 =?utf-8?B?SFRoK2NaT3RqOXZRbWNQZzdDNUFoRTEzT3F2ajBhdGZRV1BBS1FTdmtsdHZY?=
 =?utf-8?B?ZXQ4Qy9EeTVGRGpUSUplTTd1M2x0TUdPazl4Vk9yUVlxNkJyNWJsaklLYTFE?=
 =?utf-8?B?dVN3aEUvUXQ1UnJxQXRHWTkySnR1UFFaam5OeFNoZFNHVU5BM1FmVU02bWZP?=
 =?utf-8?B?ZEVPMGJSUUdLdzk2dTRZYTIxU3M1Smg3Z2hHR3BjZnNKbitSMkZKMkw2am1I?=
 =?utf-8?B?K2IrQnB6ZFVQTVVhMGh5VnJYWmxha1VNWnR3S29XNkdOc2VaZDRrV0F3MkNl?=
 =?utf-8?B?Ujkwd1dESnBCL3N6cXE3c1JWcmhXM1RYczF3Zk9wQ2UyZndjR29WQnE2L3Mv?=
 =?utf-8?B?aXJFUjZ3cVM2bjJrTnVvdU5KMXdyNkZhUWdNN0dLS25LbytLY096cTAxaDdy?=
 =?utf-8?B?eVcyQmJ1RjE3cEloOXdoT2tMRFNSY0c0KzBOMXA4ZUxLTjJlODBjczF4bmwr?=
 =?utf-8?B?azd2cVJuTzFSdm9xZStydTlUVmFZaWFheWtTczNSU0c2Z3JsZlQ0b1lvK042?=
 =?utf-8?B?bFBHdC8wSUpyUkYrWTZsVzBybUR0RjVIVVBZeE5RL29icTFZekR4dEpBMGdw?=
 =?utf-8?B?YkpOQ1FDam4rM29HTTJKbWUycWQzaEJxSzZEd3B4SWFabVJIT1lWOWl4aGx6?=
 =?utf-8?B?TnQ2clcwd1dpR0I3aC9PU2NsbHJzYitkbzJCN0tXbW5BQXFwazcxQzV1dEtD?=
 =?utf-8?B?b3JjbzRWR2lPY094N29Ldmh3a1REZXhWZ1QrTHU4eU1uZkJtL1NJOHNkcEdk?=
 =?utf-8?B?bWhPNnNPOVgxTmlKS1pTSGJBeTV3eXo2bWRDQ2E1aU43Y21wMTJIOEFQZ0Fv?=
 =?utf-8?B?RnE0S25SbUxSNVJkTWlTclVlS25LN3dzR2FqVVhiMEVDTXdUbFV2ckVzVjlr?=
 =?utf-8?B?cUVteHFaNW1PZkRyMVA3T2ZMeUxpZEZma2tHVHI0OE9GTTBwQk1od0RWVy8r?=
 =?utf-8?B?aStzRFM3bkpJY0RoT1RXYk51NjRJemUrTkVKb3pzeDNTZGs3ckxCVUZMS2Ro?=
 =?utf-8?B?ellrOG1XbkhSdFZONityMEtIQ3Z1dE1nVmR0ajlnSlJBSVV2bTJkTWFZYWhq?=
 =?utf-8?B?UHhLcDBZOUxnR3FaMk1QajVGY2VFNGlxTHVzdmliY2tyRHA5aUFPYXFTdUU4?=
 =?utf-8?B?ckdZb0hlNm8zNngvTlgwZ3o3b2tGQnIyYy9hNnd5eTFOUHdRc3JkZUNBMlVu?=
 =?utf-8?B?N242UWxBVjFGY2NrNWJETEVTeUZmeStBbG9iNUMwYzN1VVB4YnZlcFJBMWc0?=
 =?utf-8?B?cTltbUh3NkNncTJDRHJXZUVuR2krMHZacWRWRGZLdnM5TlZRYjBORDVTdWJz?=
 =?utf-8?B?SUl1d3ZmYjlUdlM4WGRicW56TkNqckR5Wjg3YmVUeVRjcmh4SUFpVHVrZU9G?=
 =?utf-8?B?UllEemluQjZwNEhpc2JUZnpoUEU3ZWZJM2haRmoxdk85NUR6TDl3a1RJZWEy?=
 =?utf-8?B?S1c5WlpLY09sOHFEMEpiNUdhOWpsSjB0MkYvbU1hVW91MjN3TGZqeXJaeXBD?=
 =?utf-8?B?enZHU0dLeE1aOTd5aExQVDl0ZG5TZEVPWDdvMmhTR1BOVFhqbzh2ZFlvcW5O?=
 =?utf-8?B?OENROHpOYW9aY2ZrMFpNVHFzMUloUTcvMWlITEU4S0dHNE9pVXRJZ2FZWGRS?=
 =?utf-8?B?V1Y1ZDZNd0l6S0tpMmEwNno2TXpQb2ZxbnpEQTJFczZiZnFJVDJXNjFYem1s?=
 =?utf-8?B?M1RxLzMvK01aenBsMndiUzRVUzMrN0g4dnZENk9YYXRkTUpEay9FSXpONURH?=
 =?utf-8?B?b2dUMHRRUm5WVG5oM3FNek9sUnV0S3M3Z0Zrenl4eXB3aDE5L3FhakppUlV1?=
 =?utf-8?Q?woHGkpK3NW7jzG9jnj0gZBVsO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd234bd-8fce-4647-c812-08dd5cfb60eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 22:08:09.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oeIWU5vptYnbK687RHCAa7/ihYtAMln0PYqT5Ipx1KwxppkQo9X+mo6X5Q58RrF62JPV3KioFQNO4UC0dxQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455


On 2/28/25 11:58, James Morse wrote:
> Each of get_{mon,ctrl}_domain_from_cpu() only has one caller.
>
> Once the filesystem code is moved to /fs/, there is no equivalent to
> core.c.
>
> Move these functions to each live next to their caller. This allows
> them to be made static and teh header file entries to be removed.
>
> Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua

