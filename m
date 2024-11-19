Return-Path: <linux-kernel+bounces-414646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6509D2C62
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67910B28571
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2531D9337;
	Tue, 19 Nov 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kIc1QGaG"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDEF1CF2B6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034494; cv=fail; b=DYcHwr1D4utRXKuCuUOxWbr8arxJYcvL3Q2mzj4JgPV66hUXNQFvYq0K6md4C1FsxC7aXYkdQssc4R7ELp4db4Rlj2mfhYdcADCZPNeopeo6x5v1opgUyoUlZb1VQ+vQ3YPLGnANv9CaHp5BMsTjz+kTAysIPvur7R6TChGX/wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034494; c=relaxed/simple;
	bh=FfOilJXf220JbX6/qqM7GV0PmVxIeq2N8wbHAvJpm9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wuc7wdYoh5kx1hnhpf86rDI+2b9txRgXDLb4/E6XCcaswH3JcwLUN52kZ2pwc3rPmy8FPzCWy2sdgtzN/vVRFmuCAeYjKVJq3nWWLE540xtVBoRrvLwzHMNG2DDuAhiBZi2L8IQUoSlYdFp95t3wZdIa7MoWPk52uusn5E9bBrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kIc1QGaG; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLEEHy40Fa0wyD6RjTj70foHacw/s6xagTWV37HRklNHx04zTqlHb6Wyp/hQzRS0RduwWO9y+SxGWgJpQzZZ0y3LAx0rllMv7RzE+UqY6cDYTwQyT5W4aoRUGPbWzx7/DdGIL7MLHRMY0tBWnS4R+QJBgI54kUe2dT8zcxmbcrw/UJqZ10QhBnt3c/R4H3aNFLBABSPcDRkI38B1j44dpA9q2m/8Ybf9gRzbauSBaaNRHX6mpeqYky/4M2cYXU8N8EKFCusB9t1Kki8XYJl3N1l0FyAs8a+zuU97oGAOSbtp9GQSgYnJftljRhJv6RbpIyMecDVncyt9LbYEIsN9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5cWb1B8oOSoNqOHsYOWNhFgtSQH592mOzjMf9T1dxI=;
 b=jw6fQwjT3m86guyzVqW0mK3oO5zh2hDhj4gBIcD3riEmssB3TEcVdZILWOxDiqg7qLvqd3hY3YV3xyrF5pXl60aTCjqil0E6yjaKR0wZdiHqzQgpUuebYV0Xh+VAoV0PTd8rpMQOamxUbeozCGiOfibnH+itmWqsc3ExV1v1blrYKJL10YNLLNORjOD9ldGXOK5ZsQUMZRjEwvkGsmCxJO06+Za9/YCm/vcjuCNREp13StPYJZNVGzU2LLWcxaDr5Kdzf1QWAIomTcdk3J4ikBGZjCzrYvIcBKomR+W81S6GGwKstZvcww6oJt+l5KQ1TKg8lvU508BlDDIa/eOO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5cWb1B8oOSoNqOHsYOWNhFgtSQH592mOzjMf9T1dxI=;
 b=kIc1QGaGBcOZRqp0x4EJgYNeM9W6bJY5aUf577lHPUMhOX4fSgZJ2I90Di1bBmY94wHEahCos8ONXh7wlYwrK0QPsIKTA2U5eDWFo4FK/oUpKelD9Ok7XgKvpuCjR2kzAJCql+D5XK2+w/IimSLtkShRskg3UmgEd/AWteNBNwOmxBztUyaCToH18V4K5k6vN74WvbCe5YQXtYEGEL8lbOAlmEPYIivNUtQrryvQNdSTn24b6KG9uyTnEpFofAfGjtRnDWVr1PRhM1cOTi0e4qXW+p1y3/Y8KOiwcGBw8lljGvZOM6bh+Va/l1GyaB/KvklksYQL3bI2gB6EgIdoyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 16:41:29 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 16:41:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
Date: Tue, 19 Nov 2024 11:41:25 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <57A6BDB9-119B-4C1F-8715-2584046A5EA8@nvidia.com>
In-Reply-To: <1a77f16b-d637-40b4-bf47-a8236729a0ca@redhat.com>
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-2-yuzhao@google.com>
 <402ff3e5-4fca-4452-97ba-5b1ec4a6eeb1@redhat.com>
 <00721702-78FF-4690-8EAA-31C367FA9FC0@nvidia.com>
 <1a77f16b-d637-40b4-bf47-a8236729a0ca@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:408:e9::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e12b9f7-52b1-4dcc-2dfc-08dd08b903e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ma15CC3g1MhfRclnrDTkHSAosfKZRQSDpiYj7AX21Pba9G6jnCb/aYEaqoZx?=
 =?us-ascii?Q?pPxeT8/bn+f3mQnpo0lewEeuFAwQ/HVQ3a8n5YxZdGAU5wiZI/PpzqBQ0hGM?=
 =?us-ascii?Q?pbqCrJkMk1U/CYIVCTb5EVIYo/+Pr8eAxfYRPhgbJW3vQz7dnIVuYoAT9/9J?=
 =?us-ascii?Q?4c4Vq1fB89C5Pry0KnIRLLSzVEp+rmYh9aN8fLBePR5A7pc8y+TYesb4WkA6?=
 =?us-ascii?Q?mPmdDryaHS8dVFXITYKorfljMzzyI/P4RSAVpezqnUAWAfZiP5Gc2C5yc/Fc?=
 =?us-ascii?Q?+NtgV1pXhxKFyiZRe75ys7NMHe/5oLMLmUFvMCtarGQf4ZEuN2tpOQzPy8yp?=
 =?us-ascii?Q?bdiYNdUOGISYYq8/kHmZwa0UM3rqOcJqUGd3wjbofCpAXSNumkqI2U6cOjUB?=
 =?us-ascii?Q?ZCdemGS2iaZkYzENDjDsUx9R0hffRrex7A9Nuu9wj4xzGwDgi7LLiAqnJ/Pk?=
 =?us-ascii?Q?WlQYmrKShJETwMYQYJGlSnDevwLTym7CKFN6s2hL6AtZBtsx3OVTuua8SHOx?=
 =?us-ascii?Q?kX09zacRuvRQDqzLmaywpo++pCUiwbcbfIp0A0xRINaRJTEYKNJgqoSjScSe?=
 =?us-ascii?Q?5NKjzVdNyeVd6eoIJY3SaF+bwZgazp0l6HGP2M/WeEhlt1KHhn3aNNL1TrqX?=
 =?us-ascii?Q?BFTaDA5vX4sgWgyKNVSPCEa/w88AIzFpTOAcJG6sVrD0M8Zx38LyoE9sctx5?=
 =?us-ascii?Q?I28Ztr0OSS0e+uHQT26Ts24etWk3GqAdOvZp1UpQgLKossdqG1fX3HQqckNi?=
 =?us-ascii?Q?cZbTrXU+w8H0N+IrSRSB9NaP2VKIEZw8uyYOVvl8UxWBfumMP3kYoXaAYf3w?=
 =?us-ascii?Q?m7M6QLdaJCM5W5YnZ4h/NwvyO/ykezBu6CAsRPgCY6Y6HiBGWM+DlLRst5GO?=
 =?us-ascii?Q?AoNxBxkKBijhcEzeQ6OIiZLdcxaz7bNGCcP2LNOxe7e9wn01ySxAV+cYl1W1?=
 =?us-ascii?Q?JYCqgT6zA9z7QtQh8u2yVHsfrfh8hLMSiq/m3wT49YG9TephFjrNb6QDBXih?=
 =?us-ascii?Q?n9olQPQ2ebXX+snQSGM46Q0wssAIzJxrPpPd1nGEI7lWR0WEdRxsygPVV/+U?=
 =?us-ascii?Q?rMu4Cs14XMYd4qhrfarX30kDv2WYcdNrXvebjpkINZJ6ptc5Pn4d2VkJROOS?=
 =?us-ascii?Q?+zVO1B9KnUwFJ5lnMUG/v4PIHPuIeXhV9BBlwAz+4fKFhbOJNN3Eb3Iechpt?=
 =?us-ascii?Q?g1U9T9ZD5egfhVsvf7EFWISwcPFlUn0b3iJgQUsgdsF5nirnRPuOfmujC0/Q?=
 =?us-ascii?Q?rOWUvjDANG5DkuatgivJNbjgqoCnNhSBmW7Fk1IteJxTRCDnw0WcNu6iMAVf?=
 =?us-ascii?Q?Ctc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkRUGBRPUgpO9prXJcUQHhhebV1E5mx8zZsQJOD+4Po5TjkG2uF+Bu5iM846?=
 =?us-ascii?Q?mku/TolPHWd8ftBwfp1J4bfrPQA4W9JHQ1xqUKBPIqhO35JUzDYLhUWmdHY/?=
 =?us-ascii?Q?3NIsm0bJoa9CEk8UIB1p66EnExio9dlpArRl4HnUEfrRY6HFvuNSWh9oiUld?=
 =?us-ascii?Q?TefZ6gOju4vQHIceBKZaDr6moO0RBCBUw28iI2nhrEDiB+i96FO/X+THoqzx?=
 =?us-ascii?Q?lWBWdbXmdko3ZADRgfpCLxCIxadHZFp36bUmZtlVP3QUNjqq7ZQyQcdY199B?=
 =?us-ascii?Q?BdX8xdSewutheCUuMP+t/4XH/HfjUz0m32FBuEm7yoP8JCAA3Xq46V6hplm5?=
 =?us-ascii?Q?pdPSKrSWGOVCugIrCg2rzwpsscn5sJTlPhMz6JJBrYcKe904Kq66y7/ulCcL?=
 =?us-ascii?Q?L8nyKFZNXM9HTtJUjj/wkPgzkE6ZSgeaKLDV3VWZlSVI9y22/ODQiz7B0Sp2?=
 =?us-ascii?Q?1mVnOPV5YxowkQzcbiMile6qPpnpKhh/oRrs8hSvplZ6z5zRjosV9CY+BuXh?=
 =?us-ascii?Q?WO/8xH2oATUpEodZk9TKkQzplVGgEJmSmY3ZzvXYcEE2M37OJu+w6je3tSXA?=
 =?us-ascii?Q?ivlS4/1LcCeuBeeGLLEwMCtC5F6iaQx1nBtatBZ0/ce3L4VKRfCXiAMwcxj9?=
 =?us-ascii?Q?jjiElhWLiic2fK/0eTn1PSs/1cKVGX2abf9fxEvR8ohc3TlJ6k9F/In4T+kz?=
 =?us-ascii?Q?UGQKW/JquJWZA1Alv6i43S0DhrCiOId35Div5dEblOyZ1R5lGqzR1N01NsX2?=
 =?us-ascii?Q?dPFd9laqIjpC8YkDbJeJrq2y9WLakd6WjmmXh1KnKge1TJqShjGDmUy/s0EZ?=
 =?us-ascii?Q?rz1EU9EU7F6B8VbGoSg5Q5DbzKxtY5Q8Ya/i5LwYklx71M8YBXhgvk7U74fF?=
 =?us-ascii?Q?L9LinD2bIZr5IlOlgAbKGoETKPcnlheqVPEFHYiHpJ4dQ/NBH3wEeI0cvtCj?=
 =?us-ascii?Q?9oFuofVsUrbZ12PikBBEO7hA9UoVZOJNQsXV4vyuRG1yHvYa4rezw+D8pezP?=
 =?us-ascii?Q?nYKeFjirhYhUkH2MXToQIA0xHDe1CgAAbQ93dqrvakOyHKy/HN8am9p6acxU?=
 =?us-ascii?Q?b06xZPpWY/mnxzMZ8byfbCH09Dgd57T5Mc5GPWxvUB8zo9nGOk10OQ9GoO3j?=
 =?us-ascii?Q?F/IWDsTYVcyzMva0zDXnz+iDHgEyd0Bq1n1zZf8KmZcEOZnm9gU3LOjrky1O?=
 =?us-ascii?Q?TZrlX7WZr9UCPzBjlQHzSLWgKyJVWGQ+GYuBjIQ2YEeXgCcMRlEVO5DgUvpp?=
 =?us-ascii?Q?1NIezPzcqBJYFVkc714iY6zAL0kXRQKeKUbJ/JXy9yxnOn65xhRQT3dR4mi2?=
 =?us-ascii?Q?FSVquw71/NtplgjJgYBYuEH/hdayCsCw8gxKevA6oThEoYVqJt22dw9rSxcI?=
 =?us-ascii?Q?OUk8abh5ADveVrTcoun7xP0fv+XSlgeepmcxIXueaRiZaXpvCUZqxvhYC178?=
 =?us-ascii?Q?DVwVDH1aUqTUa+C3cRozysdYhnlTuI8qZ1FrdsA0yO2s3EeMt0kT0dSDtVRC?=
 =?us-ascii?Q?eWb5qxSNOZQeeCZX/XKBwuSvjoReI/ZpDPsHKwsP1WgifPNysYztYI9Edpvw?=
 =?us-ascii?Q?uqkktcCzIsqeWqF0Rdifot6Lh3fy9e+7N+G4feqd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e12b9f7-52b1-4dcc-2dfc-08dd08b903e7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:41:28.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUxF4Y6u5ilVvZvsaGMOBzlqW73ZiEHZpOb3EjScopahAqZh+HYgeAy+V/8GfFqM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

On 19 Nov 2024, at 11:31, David Hildenbrand wrote:

> On 19.11.24 17:12, Zi Yan wrote:
>> On 19 Nov 2024, at 10:29, David Hildenbrand wrote:
>>
>>>> +/* Split a multi-block free page into its individual pageblocks. */=

>>>> +static void split_large_buddy(struct zone *zone, struct page *page,=

>>>> +			      unsigned long pfn, int order, fpi_t fpi)
>>>> +{
>>>> +	unsigned long end =3D pfn + (1 << order);
>>>> +
>>>> +	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>>>> +	/* Caller removed page from freelist, buddy info cleared! */
>>>> +	VM_WARN_ON_ONCE(PageBuddy(page));
>>>> +
>>>> +	if (order > pageblock_order)
>>>> +		order =3D pageblock_order;
>>>> +
>>>> +	while (pfn !=3D end) {
>>>> +		int mt =3D get_pfnblock_migratetype(page, pfn);
>>>> +
>>>> +		__free_one_page(page, pfn, zone, order, mt, fpi);
>>>> +		pfn +=3D 1 << order;
>>>> +		page =3D pfn_to_page(pfn);
>>>> +	}
>>>> +}
>>>
>>> Hi,
>>>
>>> stumbling over this while digging through the code ....
>>>
>>>> +
>>>>    static void free_one_page(struct zone *zone, struct page *page,
>>>>    			  unsigned long pfn, unsigned int order,
>>>>    			  fpi_t fpi_flags)
>>>>    {
>>>>    	unsigned long flags;
>>>> -	int migratetype;
>>>>     	spin_lock_irqsave(&zone->lock, flags);
>>>> -	migratetype =3D get_pfnblock_migratetype(page, pfn);
>>>> -	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
>>>
>>> This change is rather undesired:
>>>
>>> via __free_pages_core()->__free_pages_ok() we can easily end up here =
with order=3DMAX_PAGE_ORDER.
>>
>> Do you have a concrete example? PMD THP on x86_64 is pageblock_order.
>> We do not have PMD level mTHP yet. Any other possible source?
>>
>>>
>>> What your new code will do is split this perfectly reasonable MAX_PAG=
E_ORDER chunk via split_large_buddy() into pageblock-sized chunks, and le=
t the buddy merging logic undo our unnecessary splitting.
>>>
>>> Is there a way to avoid this and just process the whole MAX_PAGE_ORDE=
R chunk like we used to?
>>
>> Probably split_large_buddy() can check the migratetypes of the to-be-f=
reed
>> page, if order > pageblock_order. If all migratetypes are the same, th=
e page
>> can be freed at MAX_PAGE_ORDER, otherwise pageblock_order.
>
> Thinking about this: why do we care about the migratetype?
>
> We only have to fallback to pageblocks if any pageblock is "MIGRATE_ISO=
LATE" (and maybe MIGRATE_CMA), but not all. Otherwise, we can just ignore=
 the migratetype (or rather overwrite it)

There are VM_WARN_ONCEs around *_free_list() operations to make sure
page migratetype matches the migratetype of the list it is on. Ignoring
migratetype would trigger these WARNs. Overwriting it would work but
free page migratetype accounting needs to be taken care of.

An implicit reason is that __free_one_page() does not support >MAX_PAGE_O=
RDER
and gigantic hugetlb folios are freed via free_one_page(), where
split_large_buddy() is used to work around the limitation.

For the two memory init cases you mentioned in the other email, maybe a n=
ew
fpi flag to make free_one_page() use __free_one_page() for them,
since migratetypes should be the same across MAX_PAGE_ORDER range there, =
right?


Best Regards,
Yan, Zi

