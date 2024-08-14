Return-Path: <linux-kernel+bounces-285667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A566951104
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E111C22A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F08AD5A;
	Wed, 14 Aug 2024 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DMJYIdaw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAA2FB6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723595230; cv=fail; b=bkxUXxrpVpo3UIjwk6iuIFkbxaza6f8rsJ969hxCo0u1Hg8CIIC2jsXWnygm9jV0ObmWsnUZwQDPNWhUiVP5wMARy+cxYWjn10a+4fRK67MG2KfCOxPriNLlm39et5WhAEDndXRcguU4VcyficocgFk3+bw00tcRY/sITC5+qyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723595230; c=relaxed/simple;
	bh=UrK6FWc1DiraFT8IaVCNxMvTjhqV/Lhsc+Eou0gWjkw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=LEAz79e24Z4b4av2zyexEZ7VEMYDMb1N2xqL/GhQpFjT83ZAtZ+j5uNqCO1jTKWjtKIuf5vqih/qzCg/I2DslVKjewoO/r2dSw/QEWMak/NKbQ/GA2Uj2fg2v2j8eHQbsR3H/xWgIzK4dUG0zoZfs3cn2qhMPz15bWVM2kjEMqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DMJYIdaw; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdNTFtmT7QTj62FSQd9PrbNS2/vx3qd+oV+byLatK5zOWUX+eh6HjMoHtXzJJJr9jgXM5HPGHdu1rpiBuzRfFgNV6hMIMbgX6YocT90rhRQjsSzymJt0BHJeyEl4XSOmwTFWnbHmJ6sQMuyQhp0uwmo3vlTj0+BCGTJcAFpem3jYgdSpDX5OAoW+klwBUdg8e0KQL9vn0tmeCb7Zm8Bg2zVXQBSd4klD2c9AeBQ710R17dFMNfhVGad5EZg6i6Sh8YGW8oPYG7ygkgumIXgaJLgeHdOtTXCMyIQjbrUxHTJUHXVzYBD3j84DbyQIlo27sc2YXVbL67HJNaH9vmdm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TspdvFYQYzMc2Wt61s9TPdIPM4t2Ag0ffXHkBwywo+E=;
 b=SMJFqnZkoC7qw4LUJq+v4cHgpxLKfGuwLlgewYiCKniMkTpzcVf4Fubkr0DYNXyB/vhqI9GQ9BkHgoHxbOxeerGelVDaHNB5MCaamvyicAMB0t0iMEl9+/tcmpmhV2YlngQw6CKslGZYlSuoQJVHFzvcZ4wCZMwvu0NR5Euu0rmntpmNnY5DidNj4Chwncu5Z/B1YDfdHtV5eiAQOczhXwN6RID4w5wGuLiCq6CXZK+Btt8DxQsPTtVk5Q+OheaqulHjHVeRx2+UFxXg6tCd2jJQlHK5wUUoZAOh8KwtuwYOb5R4Qgg6136upYG5953/5bMUOXYnGsJrcxHW6rLEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TspdvFYQYzMc2Wt61s9TPdIPM4t2Ag0ffXHkBwywo+E=;
 b=DMJYIdawcK5CzkW2IKmbEvMaBopRLZuM+IHaTiB6flHLc1JJy/MBP8WbbQOM9AoD7JcgdmfYwBNxkVCULI24pyqLOcetqPvSBE18ZQgdcCRBIBqDI2i9jOl1O/fsxe3G9CjNBmtW07koUtAhWU068iJoouaHHO25TqGfbcgMpFOnK8gp3Zv9CEIyxWKD1fNvvGpWmNb5hRGvZh1+hq/WpAwfgzzM6UCuaZXb6S3gSUbq5vWcBTtfjrtzTkicETa5rfaZyQuNxXf36SDEkmXfEWTW1hROF9zD2sUcfJTeIhmqTB6/ParA+b80/ePHwEcH9x0KEpqCDw7t4QtRZLTCcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Wed, 14 Aug 2024 00:27:02 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%2]) with mapi id 15.20.7849.019; Wed, 14 Aug 2024
 00:27:01 +0000
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx>
 <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
 <87seve4e37.fsf@nvdebian.thelocal>
 <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpks23v.ffs@tglx> <87o75y428z.fsf@nvdebian.thelocal>
 <87ikw6rrau.ffs@tglx> <87frr9swmw.ffs@tglx>
 <87bk1x42vk.fsf@nvdebian.thelocal> <87sev8rfyx.ffs@tglx>
 <87le10p3ak.ffs@tglx> <87ed6soy3z.ffs@tglx>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, max8rr8@gmail.com,
 linux-kernel@vger.kernel.org, x86@kernel.org, jhubbard@nvidia.com, Kees
 Cook <keescook@chromium.org>, Andrew Morton <akpm@linuxfoundation.org>,
 David Hildenbrand <david@redhat.com>, Oscar  Salvador <osalvador@suse.de>,
 linux-mm@kvack.org
Subject: Re: x86/kaslr: Expose and use the end of the physical memory
 address space
Date: Wed, 14 Aug 2024 10:26:06 +1000
In-reply-to: <87ed6soy3z.ffs@tglx>
Message-ID: <87plqclzjj.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0141.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::19) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: e5735ebe-6553-4311-690b-08dcbbf7d0d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SrYMvOfYSLwGoAnhWdytIIh9nkdF079cYoi0AKb5+eNKBA8KSv54oTcSNMKU?=
 =?us-ascii?Q?edW6ccLPLSHr/gk+Y/PZ4upY/NRAsosi3WgPxEXhgm9b5nrplVmYBOy9uc8J?=
 =?us-ascii?Q?XvQUlIVL36VlHNbsqK1nIFd61mzjCMRe1UH6Wxzu4IB/TtlXykaekz6qDnSY?=
 =?us-ascii?Q?QGpnL98fbHrwUGq4AfgBr5oyv1Fnf0jYptCsFRINFLCMPRhxGcbHUKkcMuiC?=
 =?us-ascii?Q?J7TR871YT2ZsoyKs2IHw8ycr7fikjSUDBxUAWad0l50E/QsJ1REfXxiukIIZ?=
 =?us-ascii?Q?6FZimTCECbvUBl6Tlt/OdcNKo5GS7YeDMp6Wrsl2EutQBpnMUZWyJEZ9Srq0?=
 =?us-ascii?Q?qaX8Xv5HA2BtfKTfdE3DvZ++twrIpglffgxdXduAzFNN06mnE9mUJUubVwoW?=
 =?us-ascii?Q?0GY0XP2QlTORDag83XHX3oHoJbe+mIv8ERVWo0HvO38ZL6zQaYldBihkLHQv?=
 =?us-ascii?Q?5/As/vOpXX2uxXsb3mJEM9LEbUT1KGElTAOQKQWEofWuUVmECqoqNov7Bww7?=
 =?us-ascii?Q?9nzCb+xiOw0/i5G1TayNumY1/y83zYbLdWYtphUY/VtXZIIpxwRsAH+m2WAn?=
 =?us-ascii?Q?x5ju7ip4v9vS4LLRnwOIIinMLdtw63/MheRtTnVoV9m9x2BjhXEAQeVPn2GR?=
 =?us-ascii?Q?a11x2bqFAhtVHpYPHa5GV8EiILAjaJ1gSjqC9Gy3EwV+v+JoukVS5dwHtmT3?=
 =?us-ascii?Q?fsSV1J2zo3rOwnsX+WaraN/DgOaaTn5x8KI6wMItTOriIjFqra0p08JNgSri?=
 =?us-ascii?Q?UjuO2kloR8y1DE7qiZqaZNspwTYmAa2SNum1QrwtCzzVEqrZQB29GsbsCxyr?=
 =?us-ascii?Q?qPhe/8TUXi9QAXWR/zvF9iNdw+HI7B0ys6lkfnD8KKiENc+N5nGvMhmZTGi2?=
 =?us-ascii?Q?m8HhKNlqyEDzmGq2F2a98UitLA/qYx0UTldR3vzLZM4zwO9FIdmouTfAW1tc?=
 =?us-ascii?Q?yu25vRUikUtya3UyXPyHIOQlPcJblgxVC9fBi8ajS0vpGZc+Zl2hffT+skm9?=
 =?us-ascii?Q?z9rlmi1VW9tDInhbhxncHDFOxKeMjmki3KhwOGba35YOKg7RrlU7hcAAGaiK?=
 =?us-ascii?Q?2MyC0ScbYhUfDD/wKEliV3nt4zEQRPXtvH2Tz6X1ap4IehNVMCLhsng1CRza?=
 =?us-ascii?Q?6AmLBOBw2oGEqDaexXBCMgEy3PoIjynSYFbHYFs+RDvi1eJOLTrUu4P6pZ8K?=
 =?us-ascii?Q?SRmCo7FSvvlmCLZwFblAtTNIfqA0HWf/0/rYXfGmCVqUShq44n4rcHEv2yjN?=
 =?us-ascii?Q?0w0egPuRg1aQFkVYmdxj0Gp0f/pNAxEcHXLo+lg/XcZAkpgS3E7L0OJelWHD?=
 =?us-ascii?Q?4BEfuvAdU+vTEpz+Q1MxW2NSU8bmBWXIb7byeh6L0szTNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UHRsgJLHAiVKmLm00X8n13gmhVbBFmleEa13YsdR06895+RTuf+JJ1QsuQvI?=
 =?us-ascii?Q?9j2p57tlb1cchY1CLAsZDnhH+tEJUYYFyL3sqr0pr57f/2NI8f7beDwl3K6e?=
 =?us-ascii?Q?hSLovTPEKLHns0YExlxkGVg4XTAUi7BOnnodzl4KB2YzLxatAtFxwtCuKdvb?=
 =?us-ascii?Q?x2CLDWzN4UzKqax2DDfPOQbRpOiRm4g+oW4Oj5O+yRearZuf1u83jPhjFITL?=
 =?us-ascii?Q?FOxP5o64GWVCNzRiW6X7GZHbAl9+Ebh4wDQzre7Mil1zTCEqAixaQnCyCofG?=
 =?us-ascii?Q?F2kiylLbRTbWwHO2quz90tvZgo0CoezrS9Ja1TRaA69CO4XPqgrFZRBVDsZR?=
 =?us-ascii?Q?J6eFotWAFANastkQgoDvGSRvjRXydXqXFB2S+XyoSWdWr7wtqT5pQrghRI/m?=
 =?us-ascii?Q?ltpKRXK+fLuCGLkF7MqrfCqwdBwd2uQImDb/9U7wfUT9ByAZB9hsWZaEee8Z?=
 =?us-ascii?Q?tBRCs5bwZQ3YoxPaAQTWPYUNLQdUxnDD1sSLXN/zQPVaKg5GuCSd+53KvJR8?=
 =?us-ascii?Q?X/nQfteHFCQ83UIvq+1HFDkfkOKKhyJBHYUlTsLMGWkDOvOugMROqjZaH8aB?=
 =?us-ascii?Q?UkhI3OJ0AONwimRn4xWDHSj/JQrw5JhrJg6E5s+hf6fTDMzsBM8xEmJE36do?=
 =?us-ascii?Q?363xCHbnjWGdDqUFdnmPT4piXBWjlF9lsmZY8A5h5IYmtrq5PZO4aXHRSeYS?=
 =?us-ascii?Q?3hYA+doayHOTlij29SKvPLPSKACmJVMe/iCNrQhGpRoZV1GnDvpRoh+rCPsN?=
 =?us-ascii?Q?Jlq7gvbZnvNeuztw11E+CnP/pkzEpwv+gtOjgCmauzbni41pUrN1HV4HVlMb?=
 =?us-ascii?Q?Dey2M9Qa66gnBCiBvFndovesXv2EDH1PoJjkG/el/GNTSU7M/+VZFImRQ8kK?=
 =?us-ascii?Q?vTKe6b1C5gkNHQWO6wM65m7DmVGHM7abQZs0VkOpRI6iw1Q1I6mTkuqpiL7y?=
 =?us-ascii?Q?BOAVpoZlmvxJcYGYaBH5FYaObFf3+4C5Bg9r2kZceIxcZDgo0BuijEAgVpzs?=
 =?us-ascii?Q?YpxRt4l66LaLZiRqaPy+DWP9hLpcR4EDCIUEEbTl48w/FZHoiDPzDDWSdLHC?=
 =?us-ascii?Q?MLWBOKl9am7yMZSu896KBQgipI8LygWP0MRbpG0JmWCWftSw0AqU3APxu2VG?=
 =?us-ascii?Q?5Y7ZjZSqyOj0UQ3u/pa9A3yW1E2IWvZwGoOjCVw8X1TQJ2MlC1lEwGa2+KBS?=
 =?us-ascii?Q?+jp8tU2sU7Y1eWh2nqfhyDQ8vwJnwB6SfIcH79rK2IPJ3lBLd/iKqc49cL7i?=
 =?us-ascii?Q?H3eNssZHabIVXMUoUmv1vipIl3412jIO5SrNlFxwBV/D9+sm34xK/Z+kWHSe?=
 =?us-ascii?Q?Yatf0UmnPeED3dXiYFssnxyBs1qaTwu2Q/QnQ7e1c+1g7hjayALvB86nJsQe?=
 =?us-ascii?Q?8k98bFEF0qmRrd7JOGOY19F0KLIJjbfh70qqjPpL55L4Yz2kNdJUlM4G68ed?=
 =?us-ascii?Q?LW8SYlZn3/DYOrnOZ88+6fpSUJ14RuR9Wz1H5BnHV1xPDa2oFGBfSDZNdbNn?=
 =?us-ascii?Q?Td7V7Py6viacZJrYfxWr6YSS4ugBjeovTM1PelANJu0OThuInkaeap0xdZJR?=
 =?us-ascii?Q?tG27VkeJiMOWum5y9hb8tNDtwEpoJcvp7xOWDHKs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5735ebe-6553-4311-690b-08dcbbf7d0d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 00:27:01.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uhxIG7Mpc6CvAKIWU4dKAeX1DtFC3eady+oxfM57d6nAR3eBTuRsbWoKFcHKDS909AyCqsklBv8KgXy13YETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160


Thomas Gleixner <tglx@linutronix.de> writes:

> iounmap() on x86 occasionally fails to unmap because the provided valid
> ioremap address is not below high_memory. It turned out that this
> happens due to KASLR.
>
> KASLR uses the full address space between PAGE_OFFSET and vaddr_end to
> randomize the starting points of the direct map, vmalloc and vmemmap
> regions.  It thereby limits the size of the direct map by using the
> installed memory size plus an extra configurable margin for hot-plug
> memory.  This limitation is done to gain more randomization space
> because otherwise only the holes between the direct map, vmalloc,
> vmemmap and vaddr_end would be usable for randomizing.
>
> The limited direct map size is not exposed to the rest of the kernel, so
> the memory hot-plug and resource management related code paths still
> operate under the assumption that the available address space can be
> determined with MAX_PHYSMEM_BITS.
>
> request_free_mem_region() allocates from (1 << MAX_PHYSMEM_BITS) - 1
> downwards.  That means the first allocation happens past the end of the
> direct map and if unlucky this address is in the vmalloc space, which
> causes high_memory to become greater than VMALLOC_START and consequently
> causes iounmap() to fail for valid ioremap addresses.
>
> MAX_PHYSMEM_BITS cannot be changed for that because the randomization
> does not align with address bit boundaries and there are other places
> which actually require to know the maximum number of address bits.  All
> remaining usage sites of MAX_PHYSMEM_BITS have been analyzed and found
> to be correct.
>
> Cure this by exposing the end of the direct map via PHYSMEM_END and use
> that for the memory hot-plug and resource management related places
> instead of relying on MAX_PHYSMEM_BITS. In the KASLR case PHYSMEM_END
> maps to a variable which is initialized by the KASLR initialization and
> otherwise it is based on MAX_PHYSMEM_BITS as before.
>
> To prevent future hickups add a check into add_pages() to catch callers
> trying to add memory above PHYSMEM_END.
>
> Fixes: 0483e1fa6e09 ("x86/mm: Implement ASLR for kernel memory regions")
> Reported-by: Max Ramanouski <max8rr8@gmail.com>
> Reported-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Thanks Thomas. Looks good and it fixes the issue on a system which
always ran into the iounmap problem. So feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>
Tested-by: Alistair Popple <apopple@nvidia.com>

> ---
>  arch/x86/include/asm/page_64.h          |    1 +
>  arch/x86/include/asm/pgtable_64_types.h |    4 ++++
>  arch/x86/mm/init_64.c                   |    4 ++++
>  arch/x86/mm/kaslr.c                     |   21 ++++++++++++++++++---
>  include/linux/mm.h                      |    4 ++++
>  kernel/resource.c                       |    6 ++----
>  mm/memory_hotplug.c                     |    2 +-
>  mm/sparse.c                             |    2 +-
>  8 files changed, 35 insertions(+), 9 deletions(-)
>
> --- a/arch/x86/include/asm/page_64.h
> +++ b/arch/x86/include/asm/page_64.h
> @@ -17,6 +17,7 @@ extern unsigned long phys_base;
>  extern unsigned long page_offset_base;
>  extern unsigned long vmalloc_base;
>  extern unsigned long vmemmap_base;
> +extern unsigned long physmem_end;
>  
>  static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
>  {
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -140,6 +140,10 @@ extern unsigned int ptrs_per_p4d;
>  # define VMEMMAP_START		__VMEMMAP_BASE_L4
>  #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
>  
> +#ifdef CONFIG_RANDOMIZE_MEMORY
> +# define PHYSMEM_END		physmem_end
> +#endif
> +
>  /*
>   * End of the region for which vmalloc page tables are pre-allocated.
>   * For non-KMSAN builds, this is the same as VMALLOC_END.
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -958,8 +958,12 @@ static void update_end_of_memory_vars(u6
>  int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>  	      struct mhp_params *params)
>  {
> +	unsigned long end = ((start_pfn + nr_pages) << PAGE_SHIFT) - 1;
>  	int ret;
>  
> +	if (WARN_ON_ONCE(end > PHYSMEM_END))
> +		return -ERANGE;
> +
>  	ret = __add_pages(nid, start_pfn, nr_pages, params);
>  	WARN_ON_ONCE(ret);
>  
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -47,13 +47,24 @@ static const unsigned long vaddr_end = C
>   */
>  static __initdata struct kaslr_memory_region {
>  	unsigned long *base;
> +	unsigned long *end;
>  	unsigned long size_tb;
>  } kaslr_regions[] = {
> -	{ &page_offset_base, 0 },
> -	{ &vmalloc_base, 0 },
> -	{ &vmemmap_base, 0 },
> +	{
> +		.base	= &page_offset_base,
> +		.end	= &physmem_end,
> +	},
> +	{
> +		.base	= &vmalloc_base,
> +	},
> +	{
> +		.base	= &vmemmap_base,
> +	},
>  };
>  
> +/* The end of the possible address space for physical memory */
> +unsigned long physmem_end __ro_after_init;
> +
>  /* Get size in bytes used by the memory region */
>  static inline unsigned long get_padding(struct kaslr_memory_region *region)
>  {
> @@ -82,6 +93,8 @@ void __init kernel_randomize_memory(void
>  	BUILD_BUG_ON(vaddr_end != CPU_ENTRY_AREA_BASE);
>  	BUILD_BUG_ON(vaddr_end > __START_KERNEL_map);
>  
> +	/* Preset the end of the possible address space for physical memory */
> +	physmem_end = ((1ULL << MAX_PHYSMEM_BITS) - 1);
>  	if (!kaslr_memory_enabled())
>  		return;
>  
> @@ -134,6 +147,8 @@ void __init kernel_randomize_memory(void
>  		 */
>  		vaddr += get_padding(&kaslr_regions[i]);
>  		vaddr = round_up(vaddr + 1, PUD_SIZE);
> +		if (kaslr_regions[i].end)
> +			*kaslr_regions[i].end = __pa(vaddr) - 1;
>  		remain_entropy -= entropy;
>  	}
>  }
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -97,6 +97,10 @@ extern const int mmap_rnd_compat_bits_ma
>  extern int mmap_rnd_compat_bits __read_mostly;
>  #endif
>  
> +#ifndef PHYSMEM_END
> +# define PHYSMEM_END	((1ULL << MAX_PHYSMEM_BITS) - 1)
> +#endif
> +
>  #include <asm/page.h>
>  #include <asm/processor.h>
>  
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1826,8 +1826,7 @@ static resource_size_t gfr_start(struct
>  	if (flags & GFR_DESCENDING) {
>  		resource_size_t end;
>  
> -		end = min_t(resource_size_t, base->end,
> -			    (1ULL << MAX_PHYSMEM_BITS) - 1);
> +		end = min_t(resource_size_t, base->end, PHYSMEM_END);
>  		return end - size + 1;
>  	}
>  
> @@ -1844,8 +1843,7 @@ static bool gfr_continue(struct resource
>  	 * @size did not wrap 0.
>  	 */
>  	return addr > addr - size &&
> -	       addr <= min_t(resource_size_t, base->end,
> -			     (1ULL << MAX_PHYSMEM_BITS) - 1);
> +	       addr <= min_t(resource_size_t, base->end, PHYSMEM_END);
>  }
>  
>  static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1681,7 +1681,7 @@ struct range __weak arch_get_mappable_ra
>  
>  struct range mhp_get_pluggable_range(bool need_mapping)
>  {
> -	const u64 max_phys = (1ULL << MAX_PHYSMEM_BITS) - 1;
> +	const u64 max_phys = PHYSMEM_END;
>  	struct range mhp_range;
>  
>  	if (need_mapping) {
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -129,7 +129,7 @@ static inline int sparse_early_nid(struc
>  static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
>  						unsigned long *end_pfn)
>  {
> -	unsigned long max_sparsemem_pfn = 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
> +	unsigned long max_sparsemem_pfn = (PHYSMEM_END + 1) >> PAGE_SHIFT;
>  
>  	/*
>  	 * Sanity checks - do not allow an architecture to pass


