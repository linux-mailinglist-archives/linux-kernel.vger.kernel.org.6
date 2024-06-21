Return-Path: <linux-kernel+bounces-225300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610BF912ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109312825BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6BA17B423;
	Fri, 21 Jun 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZD5NxhhM"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB41C6AF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002946; cv=fail; b=mxs+MpGn9WGWn8S+U+dzntNDROAuI+DOEloCmy9EJG7Z5S3e63OFoLms4KX25QrL1+NeP7p2P9CpHontYWv5UcmdQQc/Kh8kyOiz7LvcuQ8nlKhVhTj035fQ25Xi21K/JBcGw6bp7f7KAH6yy7mpVj+wPVIMrIYvYpeu6NaL+ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002946; c=relaxed/simple;
	bh=J2Kth+WdiXCnLzmYadSyz2zlW6pO7ISpWkYJKLewlDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D50CzWHipFYiRalKEmePIETPXIGR92mWIZ83zIcbP65IkeWjBzsPeP4bLjA9fGwQ3F2PWbM33YII1weaC/OFhbeZAoSR0wLeL2BaOXTHDZrEGns5tNB3cfDsA+mVR5+pJ+JwrxgzwmGSgh8H2SwEm8NzEZNvV1QPVx9anldtEzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZD5NxhhM; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCGLCwZ3dQqIlpJqMBnrpUTp23B3C9Jlrpe5rnnB4nPwux3fN25DFo1xjuVEdU24AQUbBXmG/+GylxbSy4v3FG/Ut7PU3wf5UAcubs8/gRLsKZzdBtHC+8a5JKBETDgcQxTS3APr/1C0ioW4vPjwLC8M7th/Pm7XNBHTNNvXqvXFSOL55Pirdq4ZsOX5Oi4rE4b8D8+zyTdO3PMgvfEROKrJfVU7RHod2kf6g1fbeBqbkVtgTpbhxZ9BTlLCkMZ6+W1s4+B2p1525Wqb5rEKY8CKZsiOkuoY+EOVI5lfjHJYcbzi4PdO4B4GmiWIsphgQpkrhERpxmjnD2443xJomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTXd9F/AXBzCL7EaJbzT+9nKghesD1wJJBayK83CC8A=;
 b=dtH/NyPRHGSw7rTEQ8kbVOwQBOI8H5pm1yXwrpnbps1JaoiznkVpr4lPAwbSJcdDLYWrYVH7/Qqw/Fo76fMKlPM+6Ja/aMtNd7VU+kavlYdUxhC4OFG67ElgPqFxMhT79cc30FDFVdPyVB4+N7LfybsqduViNpotzvyABHadb5tMHKDQtuzt2yn6mKcf5chuwyF9KatrcQ/ldh/1BqpUZo1s3IH3SJOdN1fw/82NfL8R1TdEPFZTVorD4xXufAcZKSGsBZFl3HoPa6cB9jg6JnZ3lv78kfI++Iw+iCxgNbxksmT5gKnrPsw0LZFoIoPPWYZMUPuCy9qZVtWC1yh/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTXd9F/AXBzCL7EaJbzT+9nKghesD1wJJBayK83CC8A=;
 b=ZD5NxhhMgAJT+amtMXGAxwLaj1dcLELjmyQA20gF7O78Rv8N9iw1rpzfZhz8gt7UfXAH1QLIl+vzDR3RA4RIuKLUJrSXpHyT55VXSDIn3vfON/1GsyKR5UbqWkQVzGMN8g6BJvW2SBciPqTh0Xhtr5lg6jIcn4WaKpfTsIgr7ZrdZYOBZyUtqksqw9aTFRZCRYeJGyZdgqPMJJR6dP8wdGvcpMZk1zfWJ15NTRL8lEcUQeQT67JDusExBX703ZtAW4LK088AIe6+FDbmIXR18Ke7tRv0U+q9HEYGTQgGc/4IP9rtnxdUUh4cqEQyA4Eu8U2UBppmmsyp+gcNJZl7hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 20:49:01 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 20:49:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
Date: Fri, 21 Jun 2024 16:48:58 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <0F4ABC1D-7A26-4AE2-BCAA-3EA906FB13A7@nvidia.com>
In-Reply-To: <c8f9d6fd-310d-4b13-9871-556b6b9a47e1@redhat.com>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
 <B726B923-E023-4E56-BED1-BFA5CEF644A1@nvidia.com>
 <c8f9d6fd-310d-4b13-9871-556b6b9a47e1@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_260DC541-C1B9-42E3-977A-4015ACA02C57_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:207:3c::30) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: da86b92c-7721-472f-b12e-08dc92339449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fRuE5CdSG6r4lOXAU5I7m5raxLqewexpTEY+xET5W+YrGmYk4iTCoNBlpwwi?=
 =?us-ascii?Q?5hBfGczEGOgINV5XAIQlpvVfNFkF63IDyulaDBb/UqQ2v3QEGqqoM8WLpVFv?=
 =?us-ascii?Q?1zIcT2wbiaWXFOhv83uyDSUWEwSMS/EO9enNY8j/UVNgG1Y5QgAmwijiBda9?=
 =?us-ascii?Q?hYqRWrFKQ6dqi+y8hhi42PpRlkpDAoNt9rfv+wf1CE42Id+kYCWhFLSSrUyT?=
 =?us-ascii?Q?/2oxCXb6jU6xSfoYj/Bxj1m3zXUbusMMEHRnd8tYHQR136cFc/p8Y1GlOuK9?=
 =?us-ascii?Q?8ggSHC19qIMupwDA1wgB1JcYbKGu/Lc9+F2D5JfOBG16ryk4jOn3QSIin+xF?=
 =?us-ascii?Q?i7So34xunQ+10XE9YtjVsjZfz71boxlEywxFSRJAVBdX2OlCRHiYrBRvWP8t?=
 =?us-ascii?Q?17UCSPBceA4+bfAVAduteEjfuPFMMTsf+akYE8bHt+RkvhDtclEGTtoL5ndQ?=
 =?us-ascii?Q?pKUXy+3awrU2q9ZTvHBjjyNQdeKXqmQJDI5me+EozP+4DubJmyFPI5JL5YnC?=
 =?us-ascii?Q?qUmHC2H/VK9jD4xYHw7ooRfX9FVg3yotpEgFnpY0xw+WCgy1GoPIWwTfABZ0?=
 =?us-ascii?Q?3IpntV11CfLbvJHJb+S9FEzjD15XwmW+zzUUrzpWZ4TdFDpX65iKJCz0++Lc?=
 =?us-ascii?Q?KXi1Z1VLYHvKy7ZgLyRH7rRJ6cvSL54f0KKCvrepi71NLVutMBdnwljvZBAq?=
 =?us-ascii?Q?aRcu8ffZ5aslPqMKfLmqyaqPNO1TOM5HuYLNqVClbJEjc8k/9Sn6CVU5kzo4?=
 =?us-ascii?Q?ziV9S7Bvm0Pg0rJHceVMn6KYQ4e9bLct/PnpBMuPOBBjrZpZiQmBtjGFAxUN?=
 =?us-ascii?Q?UbZngOcs1s0ae+VRpTjl40wuhmFb8TbWe1Kd0yskM2tSv9BzvyWWVyGDOkqF?=
 =?us-ascii?Q?sCWpJ8thO83lCdjcnRASBauyfe9paewCOex51ylNDVwsqNdHD4twKWpoYl/x?=
 =?us-ascii?Q?MyYovNSt5VsoJsB9N7QCkROQBcjwi76R14lOxjJWIvpoj7/uO7XiN3WEnyDu?=
 =?us-ascii?Q?51Nl8IJYNqMM6PgjyQclqP4WXWs6cI4w1Vn/oltUzgGuk7B0vMVZe1Bq3WXZ?=
 =?us-ascii?Q?OhDkQQrtBjc+1nSE6nXg9jvV8SHSXNgSrvz+mVayMvf4gkOsMz2WWylddvxI?=
 =?us-ascii?Q?m4rJYTWi+QEaqVy8zJugKoDeoamyulQZWXjJwZvr+2ut99TpmMMIkeyI+3Cg?=
 =?us-ascii?Q?gvndLMZjhvnv/JBA1VCOXjZXRDIbAMiKYjSctFHB24h7qnMlv03HSIr4QjgY?=
 =?us-ascii?Q?4vF/5tRgWjKeRKU9EiyBkKc1weMCiEDW9V4/p6qm+sSjPiV9KdkE4GiIkNsX?=
 =?us-ascii?Q?7SBYRq2o4l1R4+XeEmQ74UKB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mz9s1Twt0Lz98q640dJ9wLNi2iANaeiDkOlRL5GIyolXqmTAaFAg19eO6Gx4?=
 =?us-ascii?Q?pQPOj7Ho075Z7BvHkjVers6EeIhdpTP0yW4ZyCzCURU7N+i7gMViAdPX1QwF?=
 =?us-ascii?Q?EMOnBhXk3jfGBwOv0j6wUx2/cGHCp+GQjcIQ8O2TParUuZbvdpyJzPPdDgps?=
 =?us-ascii?Q?oUO8TAAXS7AXccsjpyQG7HKiRD3hb3XC0WGoEqgSka5liZ+e5hmCQie9fxCc?=
 =?us-ascii?Q?qZ2aPHaF+hNyp8F/keaAh8ZMfpq3jq3U9+GcnOyyEazBduITDX+xJuiuqoSS?=
 =?us-ascii?Q?Mqv0oe+UJ9YNcdk5XxeKT0e0ZXajODJg6FcOk/fY/qCiDkmf9yUufOvqVku6?=
 =?us-ascii?Q?0nNLO89ToZbNKeSlDM8jMsYqGbuUxQuHq+KpZhFFOv4mRALbFcjtJlcZmADp?=
 =?us-ascii?Q?RYUPOB1q5GUzz8h5P3j2JdE77SzcbhQhmxzK8mpIo9oNCYzGocfe++VR62p0?=
 =?us-ascii?Q?iPZ64+fe/7yzglszIUFe1celRuzTlzeGxLNRKTJeHRICcFo+1hXDf62qKIn5?=
 =?us-ascii?Q?DTIUD+SZtyisTp6byKKN1Biw9bGHxEOI35b8+CgXJ3Dg2zAtiuubu4jU+ya0?=
 =?us-ascii?Q?JzSU67HJnb/KnUsxExaInhCWs7Ci7pibGQbB1wHvK7/+aTeT8Umhx6g4d3AU?=
 =?us-ascii?Q?p5zHIGQq2Bh/CoBnxJ9BurE72MxwGQTe1qvoOzBfKVnnCEujZtth8S6iqara?=
 =?us-ascii?Q?d3tpvF/Gk8Lb62F45aBmXACoZEbopW2uGL+MHq5c8nxYdjK0R+3u5ZeU0NW7?=
 =?us-ascii?Q?2mTgHoYuIJKPUzYmihtvXi/9JI+Qj8z5KR64XKWTBQs15QlmkCkgonSMWnN3?=
 =?us-ascii?Q?Q8oDykFf+n200igGdayKaWc7OSIJjHrH4VfOeALgEstjmpxo/d+2R96VjmO8?=
 =?us-ascii?Q?OXCuE69jmuuyNQTInm5cQY+vXdNrQhPl9TRrTQVZ0ep2St7GTTD/vCszwg1Z?=
 =?us-ascii?Q?WkIFluYA4xmc10zv6w37SZbfICoTuVSXL9RczIoW3BGIfV9qNsiL1pqo1Yvx?=
 =?us-ascii?Q?+zkUyJYKPn1oVCD/7swcJTP5WrtQqpAO9G6uMnRorAnSPj6plmDix0QAEWUl?=
 =?us-ascii?Q?gR+6qzUfUg9Lq5Kp2QvYhWHJR+Rkc560+mgbLWjvULwv2csrcPj8BLrNIOzy?=
 =?us-ascii?Q?a1+/sbV8tlJCKwbz6iT3fp29KKM/q3wreC22RHjngQucStSN0snNhlWV6lkL?=
 =?us-ascii?Q?MzcZdGh/R7VH3KeyMkKVHeG8aFztutDUxhdm3l1qRs3lqmN8nfdCROUETeql?=
 =?us-ascii?Q?iENmy6r5A9GOeHdv9hM5PGdHH/8jEJtFPMWmg+MxlZw7bax+TbBVcnlPdRRZ?=
 =?us-ascii?Q?qbF9RyGkt7LBIvWHyT/bJXvPobNLopn0x49JBbxwaBSC/6R0ii41wy0yla2w?=
 =?us-ascii?Q?GazRYUDnEwOH1ZJ6DvZp+stWy1LylYDjuveH2AIE+xlMl1ZB/Q3fmb68aDAO?=
 =?us-ascii?Q?4TPdwAnsoT9uBplRUwrUtWI1FClDtJ7/KfdYMLr3w55yrgsdT92ygL48pisQ?=
 =?us-ascii?Q?J22Ti11hsiZ7PW6qLYqb0mEiZh7Nnk2wYM4r3i5fRBSvlgjK9vU7RIoX9a8e?=
 =?us-ascii?Q?ccz22VreythW4IxAimI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da86b92c-7721-472f-b12e-08dc92339449
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 20:49:01.0259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaTVXaTEcIjyEPImFX1/7RQoqSC01zj8ymBhRdKM1U5dTeNmZuETp5MCI/860oD2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860

--=_MailMate_260DC541-C1B9-42E3-977A-4015ACA02C57_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Jun 2024, at 16:18, David Hildenbrand wrote:

> On 21.06.24 15:44, Zi Yan wrote:
>> On 20 Jun 2024, at 17:29, David Hildenbrand wrote:
>>
>>> Currently we always take a folio reference even if migration will not=

>>> even be tried or isolation failed, requiring us to grab+drop an addit=
ional
>>> reference.
>>>
>>> Further, we end up calling folio_likely_mapped_shared() while the fol=
io
>>> might have already been unmapped, because after we dropped the PTL, t=
hat
>>> can easily happen. We want to stop touching mapcounts and friends fro=
m
>>> such context, and only call folio_likely_mapped_shared() while the fo=
lio
>>> is still mapped: mapcount information is pretty much stale and unreli=
able
>>> otherwise.
>>>
>>> So let's move checks into numamigrate_isolate_folio(), rename that
>>> function to migrate_misplaced_folio_prepare(), and call that function=

>>> from callsites where we call migrate_misplaced_folio(), but still wit=
h
>>> the PTL held.
>>>
>>> We can now stop taking temporary folio references, and really only ta=
ke
>>> a reference if folio isolation succeeded. Doing the
>>> folio_likely_mapped_shared() + golio isolation under PT lock is now s=
imilar
>>> to how we handle MADV_PAGEOUT.
>>>
>>> While at it, combine the folio_is_file_lru() checks.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   include/linux/migrate.h |  7 ++++
>>>   mm/huge_memory.c        |  8 ++--
>>>   mm/memory.c             |  9 +++--
>>>   mm/migrate.c            | 81 +++++++++++++++++++-------------------=
---
>>>   4 files changed, 55 insertions(+), 50 deletions(-)
>>
>> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>
>>
>> One nit below:
>>
>> <snip>
>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index fc27dabcd8e3..4b2817bb2c7d 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fa=
ult *vmf)
>>>   	if (node_is_toptier(nid))
>>>   		last_cpupid =3D folio_last_cpupid(folio);
>>>   	target_nid =3D numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>>> -	if (target_nid =3D=3D NUMA_NO_NODE) {
>>> -		folio_put(folio);
>>> +	if (target_nid =3D=3D NUMA_NO_NODE)
>>> +		goto out_map;
>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>> +		flags |=3D TNF_MIGRATE_FAIL;
>>>   		goto out_map;
>>>   	}
>>> -
>>> +	/* The folio is isolated and isolation code holds a folio reference=
=2E */
>>>   	spin_unlock(vmf->ptl);
>>>   	writable =3D false;
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 118660de5bcc..4fd1ecfced4d 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>
>> <snip>
>>
>>> @@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct vm_faul=
t *vmf)
>>>   	else
>>>   		last_cpupid =3D folio_last_cpupid(folio);
>>>   	target_nid =3D numa_migrate_prep(folio, vmf, vmf->address, nid, &f=
lags);
>>> -	if (target_nid =3D=3D NUMA_NO_NODE) {
>>> -		folio_put(folio);
>>> +	if (target_nid =3D=3D NUMA_NO_NODE)
>>> +		goto out_map;
>>> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
>>> +		flags |=3D TNF_MIGRATE_FAIL;
>>>   		goto out_map;
>>>   	}
>>
>> These two locations are repeated code, maybe just merge the ifs into
>> numa_migrate_prep(). Feel free to ignore if you are not going to send
>> another version. :)
>
> I went back and forth a couple of times and
>
> a) Didn't want to move numa_migrate_prep() into
>    migrate_misplaced_folio_prepare(), because having that code in
>    mm/migrate.c felt a bit odd.

I agree after checking the actual code, since the code is just
updating NUMA fault stats and checking where the folio should be.

>
> b) Didn't want to move migrate_misplaced_folio_prepare() because I enjo=
y
>    seeing the migrate_misplaced_folio_prepare() and
>    migrate_misplaced_folio() calls in the same callercontext.
>
> I also considered renaming numa_migrate_prep(), but wasn't really able =
to come up with a good name.

How about numa_migrate_check()? Since it tells whether a folio should be
migrated or not.

>
> But maybe a) is not too bad?
>
> We'd have migrate_misplaced_folio_prepare() consume &flags and &target_=
nid, and perform the "flags |=3D TNF_MIGRATE_FAIL;" internally.
>
> What would be your take?

I would either rename numa_migrate_prep() or just do nothing. I have to a=
dmit
that the "prep" and "prepare" in both function names motivated me to prop=
ose
the merge, but now the actual code tells me they should be separate.

--
Best Regards,
Yan, Zi

--=_MailMate_260DC541-C1B9-42E3-977A-4015ACA02C57_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmZ15zsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUkLcP/26UQrHSIZ1SBF4e30q/cObla8oLOnN2RFPX
p5/80hcftjEK4yc1neij/61OZfZ+/AfviORbFCodAflAI21MmIgr4laEdqhI1p4G
2ecf+WojggbYvQ++qFA17+qftqY56EqolMojLl6W5pZOtlks2/USuZZlDT1g/Blb
fg2SFAsaudi28I3KX7QM4bc2XSA1yXQRSjjR+3vOr+fpQWL6OXSoffd7y7hdaBTR
ZHMn+KDHtJHsrKBYDjSbD1EdL1hTbzXcnar9DF5bKfZMhxegPvqiq+2d1W+7HIU2
mBA3Dgc3ujTTvLBjZbQ3f4LKnoQ+ID/467yH0h93/Gu/d3t+Mc2O5Fkmnqn/6u4w
+sZYRW5UsFbP0IOFfQcQUSIbn7wSz+tMadad4EIlMIZtWG4OufXt6sAgq+eyivjB
9FQOvaSjgCDfL5K/JPo8K8l4XOHCDZz/L2TgRyEnro7f6Yw9+5zzpf6LcFl3ergR
U17We9/jVrD9ayWEVLjRlgcuO8btRKiRhjazOUwnepQItHZF32O5R9l3xZsD+CA0
6IBIHeAmtMCvxPhuVhfH8PSc0soJhv9DfkA91kRSfDCsLpf+zvRRWxP6E731raMO
AAQGciEW3XZCkEdcXdm+Y7kaQhvuNMartLb8DrKD4q0bso5ykhD2cyfHAGpYLEMe
RdcRL+o2
=bo+L
-----END PGP SIGNATURE-----

--=_MailMate_260DC541-C1B9-42E3-977A-4015ACA02C57_=--

