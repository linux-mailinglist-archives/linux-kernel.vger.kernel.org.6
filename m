Return-Path: <linux-kernel+bounces-256487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B268934F39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CCF1B22B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A5914389A;
	Thu, 18 Jul 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="je4wEX2G"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269F140E30
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313647; cv=fail; b=Yv16b05hgHJhCd3MvBWaNOvJPfHhWC/ks2z/gBic8IY52L4tmv4XnSSAvXpNYdQzNEvt7N9NcYmUfQdFq63bsyMbFWqYkOLFy0feRC2NFqEa5d9rPluZJAmfMOWfDHn5VDb7/RWjirfFlHuuSFV3WNSHZZKcidjCWItalRLJS4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313647; c=relaxed/simple;
	bh=YKJLcEEbu2b8hIs9VlRJUoksMe8bTg0ojb1VHk9HN2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BmG1UShgT1jXXPw+NQMF0HVJeAqdU5CyEdPHu0K4XUhI4nZ/eg0CeKuMEQHc6n+bsts0Gr41R8RxXkWeOz2xSjRSJv6bjQjq8zyhpBOu4PN4pQtfPWUaeCjqK403Ry0g6yziE8bJoBDN/N9vKKmgE8zu+Qt/NReYII+I2L9VW4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=je4wEX2G; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLkwFakQM5/QfDulogAHxoZAFKXJqLQJstMCV+FAJ9yu3hTBwuMOpecP1A5lx8fTZGrF3mW3LgRTRn0wFjl3GLGjMuStD1bObgKp76Gfsvl6x7VKHFDrMwnUmo5FlgzJu4yCPyTWd4IxRmS2vq2wOdHBCI9J57pZrOAce5jmkYJ4l0Y1KJZ7JR0yl6DKFyh7YolFKo1TD3RT99hOQu+Uz8z4rKX4U/oSGQzoL/U9ksLU8aqNKE0xF0TKfkLQIZVZ0quLCgENoUxhvP94hCFX85mvn77Psx4iaBAvqmaqgCuQ6NdXyn2D2gQEfbl3Wiz9xi6ymnW0FFnJWwgXnI35PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zGYiZ8EHmpMJ1GFmU5PfLNAfMDy2RuAHxg8xXbwB1U=;
 b=y3ibIX/sdSMfB8XDDiOS3Hp71GVPX8UnzoOUY6hC8/nM6msIdJTcu9FcXGu+XC3LPUazQD9Pa0vYeYgRLTDjR+dwbdmioyFn7k+Ti2FXQx15hwUOzuw+/DMbP/Or8wqMDgTksgEQzofsa4LzuuhhW5GV2hGLp1+os1VfGDVKU25rtB/Mq9oimsvQRtJfuPGbt9lg+q3Ishx7BWHLxXM0tf5NYy43tQFt04JgedmYui4uroJd2h0hMG37WtYl2Eht7L+KX9d+r3Etw7/squKwAozg0pCmKBhnr3zeD3NHpeKHwTHz0WVAq0t4baBbrhKP93/9PwetpAAIeHbL1UumcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zGYiZ8EHmpMJ1GFmU5PfLNAfMDy2RuAHxg8xXbwB1U=;
 b=je4wEX2GHz4xOVUcnz/tlN+myeigCf6zfu3V4oGG4J6Oh+D+S3mzhjZVbSPxOE/uQyVGbD2FGClrvg9HRahguj9i9GhSiKcY1J+NhbcuW79GFysDSRfLrNkBiqVYWQwic1Vo1+WYn0LaD6o/cH+ZbwUCOyhsJQkdWt4IZuFWKW/MF1D+5u4ZWE0RbgMUh9tpkT2nMRDG6PChQPVMSeYBT8tmmzm5FepMnlhqtPmdSY2LkNv62+XoohO6jDqDt/tapx0QVRgFlAhYyjj5jX+KQ/b0H4r1Fhvay9eu0w31Kmht3inCCqSDmdW9LmhwjvcLG+/c/uQJ+XBVZ5NOQgSejg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 18 Jul
 2024 14:40:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Thu, 18 Jul 2024
 14:40:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] mm/migrate: move common code to
 numa_migrate_check (was numa_migrate_prep)
Date: Thu, 18 Jul 2024 10:40:37 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <DDB73347-5EBA-442A-A631-E533EE50EFC7@nvidia.com>
In-Reply-To: <87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240712024455.163543-1-zi.yan@sent.com>
 <20240712024455.163543-4-zi.yan@sent.com>
 <87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D0DFA83B-A433-452B-A082-ACB074B8FB34_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:23a::21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 8491a19e-d065-466e-0df6-08dca7379869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e455NEXCAxbwCM3fZtSCdAlaOZB5kdpWNr0Et7jf87PJj4a/lCRygxR/4q9U?=
 =?us-ascii?Q?Ox/7ty5lOS5qWgp1A5JBPz6iLuHtghX26chGUZoY/DT2SdOaVt+UJ+zXwAkq?=
 =?us-ascii?Q?NLrDzlN31qhlZ0WnQIYVQ4rk/L30yBr+SBiqxFOeCnXaALcClPoC7OyGtG4C?=
 =?us-ascii?Q?0CbHVaomZNMFUWaV1fsqcquT/jVi6EcGiEfN0rwQHJ7FNE58xKQSaRtNIzpu?=
 =?us-ascii?Q?JOz1Vl3uArgn/uYUns90nsLIpVaRSHdTNJA6JcD/CjJUYfLmrX1ZckITV/Bo?=
 =?us-ascii?Q?vTsInuLXtofCIPzQ9KP08FR5SYxk78E9Av86f8U731YLjmOcAGw/Hsu2uYj7?=
 =?us-ascii?Q?ySIlcq2XJSC6MufLJyKc9/KvIw0lGa4t7XU+g5JnXBA9jaRgHN21joPoOLLD?=
 =?us-ascii?Q?rIrq7Fi4msXTCpIkjMNnYfGRkv3k3zMLilNptVr/izMo7sVVJbvWzrfd1dV6?=
 =?us-ascii?Q?ZROMTiZUrl6oCgYVETQY9i1pGvch8zcho8TKX5nSUjgLkAj7WnLgO1dVdgKO?=
 =?us-ascii?Q?Dqi6DKfqGFVVSjGuRRj0PKFr7//PuCW0Lp1IEw7P7614PdYXT25psx4G/B+J?=
 =?us-ascii?Q?VLtFB848ZEJM4nNcW7npdQPYbBea6DEGcwqczjTmjcuWXe78hOhaNz2+gH4c?=
 =?us-ascii?Q?A0LAM1j8eqgmEhl8ommkQ4ajg8FC28wg1Bo/s+N1KwfZHR4KaLYFMeT9TIZD?=
 =?us-ascii?Q?p4bH8T8D2xod9izJxJhmOzZZjp5m3x6HVw23hMd4A+bAtfinjhL3i4RJ9NnA?=
 =?us-ascii?Q?eaQodlRRJ0CvRWTSqQWCRnepv6ucWqrsu/DUKowB2OLr10T2Ku+0ZkpdJIwo?=
 =?us-ascii?Q?CdOiv075I4A49g6vlStYKOACbS5eBPbzEa5Qkv9azoQUZMTNsA7SfXsfJnoj?=
 =?us-ascii?Q?LakAmOOMbvNofp9HEV72ARKz5lIGklKYJ2CN/9dQaotMZAiVSQ4Yf11Rc9qU?=
 =?us-ascii?Q?2uythwdPxbP0XYQHqnXX+WYlMrOTy4f/fCK0SPWatYsBl+WyQdp7H1T/Afjn?=
 =?us-ascii?Q?rywe4i/M+yBEeqBjMoR0VzZFo3CzzB6Iae4D3Xpnzn/MnOi5DVvc0oQgvn/2?=
 =?us-ascii?Q?nJLNncmsp5lJ8x9wwdu6dsMPfYLN5Jt3IevDn0F5A6a37+JqqBV2oKPhHw1g?=
 =?us-ascii?Q?PwYWlBraFPIy0xfLLQac1kXRyWqHegoUPBrs3ITOE/LyIQPFQZvU6lxWCtgS?=
 =?us-ascii?Q?t9a/YytviLJU4ijvLZRehWBevLjtXqv8ABig0t0itfLCJ4IV6QGGcJOSyzD3?=
 =?us-ascii?Q?7i5GSTmkyh16ln77Jr/+qkgcFdnX+txQ6icVeANLgEag4m9I7AN72rgcTLDX?=
 =?us-ascii?Q?G/5IeValuXSBlLubLmgsfOVEIy1otvzWDYLxNjeO6alSaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQHAZOzBENwflCm0Ea2sYxNBp3xQ/zvmqpBIj4pHbKssbukH3ZFPSTx0VHPg?=
 =?us-ascii?Q?05To8T574bXDPL2fTyHa6jAcFd+uNhW4v9KuEwCO1KX9s7u0dmf6OFfMkUeZ?=
 =?us-ascii?Q?i1nfng9J0lAxDNu2D5yGUgka1HQbXWDeOIlUakGaTDFXqkQ1DZUV2W8t4sNr?=
 =?us-ascii?Q?vDUF3QbYSKS7i/o7sIXQaQacz0kKDvEnbEkKhAFb0EX5D2CnzSogxUI79oDr?=
 =?us-ascii?Q?ENapgo1a86V+J4L/3EUiEaE8kAoiVVy4WF1XepHlyt4RdA3cpsRDMhZFeTwB?=
 =?us-ascii?Q?2FKT5PTyZyPhu0MV6aDsWIlH/p40zmzilowm+X/dGDrfZpj0lwGFtWC8wbt9?=
 =?us-ascii?Q?0r/JaeJx2MMyWM8eFdMNT2zdxO0jbC0DoNCbkYX9lSn2FIIsR1zQ0q19SRKi?=
 =?us-ascii?Q?wH2yEXjIxLSOktd7EbplDdfjk6vzE91lPCqTBZ/mAMIj+Xe6iKSdEFNU5R7J?=
 =?us-ascii?Q?uBvrYaeXptHa1+H+jD2YPE/pCiVvv/TFmDm2FmFT9sz2bqNaCLIG77BCNKvF?=
 =?us-ascii?Q?WgE/x6ZosU1UiRra6NcVOf0YPUrA/wvuFs8r0Bs6ngohUVOqkVTzzlX6lQIk?=
 =?us-ascii?Q?zXC7O6FZ46aCapaSdvZ/7Ogm5Wbtr4KHxVI7epJ6DxtbGp+pIgoOgilawSuF?=
 =?us-ascii?Q?TGTHLKWJY64zqpLF/A+0YixyBL0mdUmvAZ4eU6L/T+OdFAyjlz14KKPQSRQq?=
 =?us-ascii?Q?hTY/Rq5tys4c2Gc3Yj1noJQCoZ+yXj0dxiO2VFwLl2MxUQbCtaJMQxHhywxg?=
 =?us-ascii?Q?K5BFH4WENloJq/CDragT22GGRlqm54JfLY5vR9QPexZz+wsNfhQ3jsynB3P6?=
 =?us-ascii?Q?SmwfwcN5BpZE9awGoOFQGWGqk9kL4O+rNrnn0Yjfv/RcnAWuXPeVmcaVDQCi?=
 =?us-ascii?Q?Lc/Gww4i0pch6su/GhU+qjziUkW9Cysfh/HHRMTFv8KKxa4vPAmoNNM48ZgW?=
 =?us-ascii?Q?r4WRTfYvs4P0gPGO3YucLTUAkfPWIxnLfdZnWKvsHa+Xe6YcqV5bh1IIHEsN?=
 =?us-ascii?Q?prXxqUL5I7TrHD8fMdqWFJUp1Yf3XCZSv/26O3hb/bSw2eVvmaVfyZoLxQRy?=
 =?us-ascii?Q?wyRE75QpKX/qcMnIVOJjrYOZNZtWCoQ1XmSD6bY2BkwhuvwITHpPMATq6rvP?=
 =?us-ascii?Q?oED5hL6rWhnl01XJfHmQn6tR3xUwJfksFcrdgsZX2024EftYnUp3pJ9JSRJn?=
 =?us-ascii?Q?DkDlREiQPu658afOxjL8yAmIHH+H071IV60gs6xuLn0fVm4ZVoQWnu3nmoxP?=
 =?us-ascii?Q?Xru8R6LNPJxQPqU63iL8m6XVn/66z1ITb84M5xrLGYSAP0sytl9RDrVvzkuD?=
 =?us-ascii?Q?ijViPSc6oXVYaWrs1RLPpFRzAAM/vTlkvQjvSRVvu1V34+vakyuecQKZwvvY?=
 =?us-ascii?Q?Q/S7qVKGiRi6DMvl2rLqqxtU34iuMmwt5ce/j11581vMIYB87jidAKeWO0N/?=
 =?us-ascii?Q?5O3nkW8s1oYXCBzVgdPm428p44MMxmVa4uUVr/eE2fzb3FDJAcUE80VLgwGy?=
 =?us-ascii?Q?osd8L8/qVs9hLQhuCifT/S5BTysgNDYXQkEHQqgc3ZFyibHYLQlL0z1JGX9I?=
 =?us-ascii?Q?nluo/BXG3h4nBtHdRqaTNtwGaA8+tx1EHSTwuyVa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8491a19e-d065-466e-0df6-08dca7379869
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:40:40.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zi7jACjt7sQlmNtzb67COuh7dlF+ldtngFaRuvJNgHxIVqSWGxHjhi8LOqasvLQG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470

--=_MailMate_D0DFA83B-A433-452B-A082-ACB074B8FB34_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 18 Jul 2024, at 4:36, Huang, Ying wrote:

> Zi Yan <zi.yan@sent.com> writes:
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> do_numa_page() and do_huge_pmd_numa_page() share a lot of common code.=
 To
>> reduce redundancy, move common code to numa_migrate_prep() and rename
>> the function to numa_migrate_check() to reflect its functionality.
>>
>> There is some code difference between do_numa_page() and
>> do_huge_pmd_numa_page() before the code move:
>>
>> 1. do_huge_pmd_numa_page() did not check shared folios to set TNF_SHAR=
ED.
>> 2. do_huge_pmd_numa_page() did not check and skip zone device folios.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/huge_memory.c | 28 ++++++-----------
>>  mm/internal.h    |  5 +--
>>  mm/memory.c      | 81 +++++++++++++++++++++++------------------------=
-
>>  3 files changed, 52 insertions(+), 62 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 8c11d6da4b36..66d67d13e0dc 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1670,10 +1670,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fau=
lt *vmf)
>>  	pmd_t pmd;
>>  	struct folio *folio;
>>  	unsigned long haddr =3D vmf->address & HPAGE_PMD_MASK;
>> -	int nid =3D NUMA_NO_NODE;
>> -	int target_nid, last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>> +	int target_nid =3D NUMA_NO_NODE;
>> +	int last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>>  	bool writable =3D false;
>> -	int flags =3D 0;
>> +	int flags =3D 0, nr_pages;
>>
>>  	vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
>>  	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>> @@ -1693,21 +1693,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fau=
lt *vmf)
>>  		writable =3D true;
>>
>>  	folio =3D vm_normal_folio_pmd(vma, haddr, pmd);
>> -	if (!folio)
>> +	if (!folio || folio_is_zone_device(folio))
>
> This change appears unrelated.  Can we put it in a separate patch?
>
> IIUC, this isn't necessary even in do_numa_page()?  Because in
> change_pte_range(), folio_is_zone_device() has been checked already.
> But It doesn't hurt too.

OK, will make this change in a separate patch.

>
>>  		goto out_map;
>>
>> -	/* See similar comment in do_numa_page for explanation */
>> -	if (!writable)
>> -		flags |=3D TNF_NO_GROUP;
>> +	nr_pages =3D folio_nr_pages(folio);
>>
>> -	nid =3D folio_nid(folio);
>> -	/*
>> -	 * For memory tiering mode, cpupid of slow memory page is used
>> -	 * to record page access time.  So use default value.
>> -	 */
>> -	if (folio_has_cpupid(folio))
>> -		last_cpupid =3D folio_last_cpupid(folio);
>> -	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>> +	target_nid =3D numa_migrate_check(folio, vmf, haddr, writable,
>> +			&flags, &last_cpupid);
>>  	if (target_nid =3D=3D NUMA_NO_NODE)
>>  		goto out_map;
>>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>> @@ -1720,8 +1712,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault=
 *vmf)
>>
>>  	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>  		flags |=3D TNF_MIGRATED;
>> -		nid =3D target_nid;
>>  	} else {
>> +		target_nid =3D NUMA_NO_NODE;
>>  		flags |=3D TNF_MIGRATE_FAIL;
>>  		vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
>>  		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>> @@ -1732,8 +1724,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault=
 *vmf)
>>  	}
>>
>>  out:
>> -	if (nid !=3D NUMA_NO_NODE)
>> -		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
>> +	if (target_nid !=3D NUMA_NO_NODE)
>> +		task_numa_fault(last_cpupid, target_nid, nr_pages, flags);
>
> This appears a behavior change.  IIUC, there are 2 possible issues.
>
> 1) if migrate_misplaced_folio() fails, folio_nid() should be used as
> nid.  "target_nid" as variable name here is confusing, because
> folio_nid() is needed in fact.

Right. Will fix it in my code.

>
> 2) if !pmd_same(), task_numa_fault() should be skipped.  The original
> code is buggy.
>
> Similar issues for do_numa_page().
>
> If my understanding were correct, we should implement a separate patch
> to fix 2) above.  And that may need to be backported.

Got it. Here is my plan:

1. Send the first two patches in this series separately, since they
are separate fixes. They can be picked up right now.
2. Send a separate patch to fix 2) above with cc: stable.
3. Clean up this patch and send it separately.

Thank you for the review. :)

>
>>
>>  	return 0;
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index b4d86436565b..7782b7bb3383 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1217,8 +1217,9 @@ void vunmap_range_noflush(unsigned long start, u=
nsigned long end);
>>
>>  void __vunmap_range_noflush(unsigned long start, unsigned long end);
>>
>> -int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
>> -		      unsigned long addr, int page_nid, int *flags);
>> +int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
>> +		      unsigned long addr, bool writable,
>> +		      int *flags, int *last_cpupid);
>>
>>  void free_zone_device_folio(struct folio *folio);
>>  int migrate_device_coherent_page(struct page *page);
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 96c2f5b3d796..a252c0f13755 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5209,16 +5209,42 @@ static vm_fault_t do_fault(struct vm_fault *vm=
f)
>>  	return ret;
>>  }
>>
>> -int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
>> -		      unsigned long addr, int page_nid, int *flags)
>> +int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
>> +		      unsigned long addr, bool writable,
>> +		      int *flags, int *last_cpupid)
>>  {
>>  	struct vm_area_struct *vma =3D vmf->vma;
>>
>> +	/*
>> +	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as=

>> +	 * much anyway since they can be in shared cache state. This misses
>> +	 * the case where a mapping is writable but the process never writes=

>> +	 * to it but pte_write gets cleared during protection updates and
>> +	 * pte_dirty has unpredictable behaviour between PTE scan updates,
>> +	 * background writeback, dirty balancing and application behaviour.
>> +	 */
>> +	if (!writable)
>> +		*flags |=3D TNF_NO_GROUP;
>> +
>> +	/*
>> +	 * Flag if the folio is shared between multiple address spaces. This=

>> +	 * is later used when determining whether to group tasks together
>> +	 */
>> +	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED)=
)
>> +		*flags |=3D TNF_SHARED;
>> +
>> +	/*
>> +	 * For memory tiering mode, cpupid of slow memory page is used
>> +	 * to record page access time.
>> +	 */
>> +	if (folio_has_cpupid(folio))
>> +		*last_cpupid =3D folio_last_cpupid(folio);
>> +
>>  	/* Record the current PID acceesing VMA */
>>  	vma_set_access_pid_bit(vma);
>>
>>  	count_vm_numa_event(NUMA_HINT_FAULTS);
>> -	if (page_nid =3D=3D numa_node_id()) {
>> +	if (folio_nid(folio) =3D=3D numa_node_id()) {
>>  		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
>>  		*flags |=3D TNF_FAULT_LOCAL;
>>  	}
>> @@ -5284,12 +5310,11 @@ static vm_fault_t do_numa_page(struct vm_fault=
 *vmf)
>>  {
>>  	struct vm_area_struct *vma =3D vmf->vma;
>>  	struct folio *folio =3D NULL;
>> -	int nid =3D NUMA_NO_NODE;
>> +	int target_nid =3D NUMA_NO_NODE;
>>  	bool writable =3D false, ignore_writable =3D false;
>>  	bool pte_write_upgrade =3D vma_wants_manual_pte_write_upgrade(vma);
>> -	int last_cpupid;
>> -	int target_nid;
>> -	pte_t pte, old_pte;
>> +	int last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>> +	pte_t pte, old_pte =3D vmf->orig_pte;
>>  	int flags =3D 0, nr_pages;
>>
>>  	/*
>> @@ -5297,10 +5322,7 @@ static vm_fault_t do_numa_page(struct vm_fault =
*vmf)
>>  	 * table lock, that its contents have not changed during fault handl=
ing.
>>  	 */
>>  	spin_lock(vmf->ptl);
>> -	/* Read the live PTE from the page tables: */
>> -	old_pte =3D ptep_get(vmf->pte);
>> -
>> -	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>> +	if (unlikely(!pte_same(old_pte, *vmf->pte))) {
>>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>>  		goto out;
>>  	}
>> @@ -5320,35 +5342,10 @@ static vm_fault_t do_numa_page(struct vm_fault=
 *vmf)
>>  	if (!folio || folio_is_zone_device(folio))
>>  		goto out_map;
>>
>> -	/*
>> -	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as=

>> -	 * much anyway since they can be in shared cache state. This misses
>> -	 * the case where a mapping is writable but the process never writes=

>> -	 * to it but pte_write gets cleared during protection updates and
>> -	 * pte_dirty has unpredictable behaviour between PTE scan updates,
>> -	 * background writeback, dirty balancing and application behaviour.
>> -	 */
>> -	if (!writable)
>> -		flags |=3D TNF_NO_GROUP;
>> -
>> -	/*
>> -	 * Flag if the folio is shared between multiple address spaces. This=

>> -	 * is later used when determining whether to group tasks together
>> -	 */
>> -	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED)=
)
>> -		flags |=3D TNF_SHARED;
>> -
>> -	nid =3D folio_nid(folio);
>>  	nr_pages =3D folio_nr_pages(folio);
>> -	/*
>> -	 * For memory tiering mode, cpupid of slow memory page is used
>> -	 * to record page access time.  So use default value.
>> -	 */
>> -	if (!folio_has_cpupid(folio))
>> -		last_cpupid =3D (-1 & LAST_CPUPID_MASK);
>> -	else
>> -		last_cpupid =3D folio_last_cpupid(folio);
>> -	target_nid =3D numa_migrate_prep(folio, vmf, vmf->address, nid, &fla=
gs);
>> +
>> +	target_nid =3D numa_migrate_check(folio, vmf, vmf->address, writable=
,
>> +			&flags, &last_cpupid);
>>  	if (target_nid =3D=3D NUMA_NO_NODE)
>>  		goto out_map;
>>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>> @@ -5362,9 +5359,9 @@ static vm_fault_t do_numa_page(struct vm_fault *=
vmf)
>>
>>  	/* Migrate to the requested node */
>>  	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>> -		nid =3D target_nid;
>>  		flags |=3D TNF_MIGRATED;
>>  	} else {
>> +		target_nid =3D NUMA_NO_NODE;
>>  		flags |=3D TNF_MIGRATE_FAIL;
>>  		vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>>  					       vmf->address, &vmf->ptl);
>> @@ -5378,8 +5375,8 @@ static vm_fault_t do_numa_page(struct vm_fault *=
vmf)
>>  	}
>>
>>  out:
>> -	if (nid !=3D NUMA_NO_NODE)
>> -		task_numa_fault(last_cpupid, nid, nr_pages, flags);
>> +	if (target_nid !=3D NUMA_NO_NODE)
>> +		task_numa_fault(last_cpupid, target_nid, nr_pages, flags);
>>  	return 0;
>>  out_map:
>>  	/*
>
> --
> Best Regards,
> Huang, Ying


Best Regards,
Yan, Zi

--=_MailMate_D0DFA83B-A433-452B-A082-ACB074B8FB34_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmaZKWUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKliwP/3gsVQbYc5aR5yacacsVLs68R4Mg02B/r2Kr
pVagl98kaLPtXgpUUJvrawdA+QyvBKDR0HRHgIsXciHMFXIjUxAiFs7dmU2qs8JD
tLKfKnR+cZkXxK95jzFOu4VXdr8//J8ai0RXzljvys8oyA1usMqBE87fot2OcdMy
Tcvg5Isyp67+T/xQvhE7XSch4jzAOPrkLbuxe/K4YekwYGRrz+Djk0z6qVhM66we
uxXif4SF5XQmJk9jcZW1GU6MxTpN8Swv2SDFBpvjhU1AMDsHJvf6craj8bHpip8D
XVl3+J+4AOF0qZfqg7zjo5dnToNxylyk2DXcNbmR/kkyEgQT4Ivxo6mYSwFNEMax
yZAzjOdaZ6Yuqn0rB3XkjGk2jye806QOg/kWHPTRd+Moq6MFRKxZlvJmjfoGSQeh
H3BQZay4uwTOvwMOBKzsptH3lzWhoVMOZYRlVH+j4tx/Ey4+Xy2n+Pc8xni+2yK0
2ueDCchauGiDXKlqqHNQ3cOJqgpX8RmkHf6Kr5Ip8IInydbIsqLZyKccn5iDkk/9
kw4fsULT125C0MhSXTBS0WpV5ozkNKN/MaVv8N0+L76zDPqlI04UGMRESPGgdop3
HLMGxC+NA0DPDLBi0R15vWw7zicTt0uXlz/qBu9BXYabjJDjucX70KGrkn9L5LA4
3z0aQN+8
=Msnr
-----END PGP SIGNATURE-----

--=_MailMate_D0DFA83B-A433-452B-A082-ACB074B8FB34_=--

