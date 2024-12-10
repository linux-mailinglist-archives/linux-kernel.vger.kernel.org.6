Return-Path: <linux-kernel+bounces-440272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF539EBB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F80E1888538
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1894C22B5A6;
	Tue, 10 Dec 2024 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dd+P2L23"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679923ED69
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733863862; cv=fail; b=LOxIjxO2pUx8X8hikZoiSd/vEChiU6c30bjmdsp6Xlht8CXS8ZQ6A+MpjyqNqOppnEprL3CjCooiT4fLivCMD6XqzA3fpE5LoByn66bg3Wzkq1+DN9iomHG87NRlLX0mwdo9doSkgsgZmcqFlZn7q7hmtE15a4rY8h+bSgTmSzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733863862; c=relaxed/simple;
	bh=QeQT9ylqAEpIM2pBKYa8uN6yIzNeEVpMGIyDeM56KSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tls9iEzvbANTt2T2ouI3OdC0ZgxBtkrWFoi5ksOyJhtUhwQWMqrBdvZ9NjMw5nvv4BbySb/ULINkZsQE56SKKePmlDx/JHXVX2nc4SL6MfmnmaM3tMzeR1r9e0KJ3Cl1LPywSWRWgXcsU8FK2n/ZtW8S9TJO47dYUJcoFhTXg5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dd+P2L23; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRYkI2BwKrTouJ4xjMT1UDtopBngXLQCVm9HIgPjBp5/sWuQy5injDHXt4c1ldOpLcaaVprLRmMiP1tiELo/JWbEJgRyvWRS8LKUbWqz4nca6xKlBdIvRmnSeT2aLQ2u94t3LNcV9yRqoTfokSzX9qxmCAzEuaRRBF6skkKC4BboWNpVXq8mbUf0DlH5RM4Rq2skbFmwNm12k4e2LpPXqirouHSaXNB47XqUjzKlxau7+SztdqagLctwUyM0qoO3GULdMpjnxCgkHb4Q3JGs3CAoEhNLlOtHClD4iY0zqNXMjzpA0SW221onas9wJE0+73Y6k3uQ5DU4UOy85Um1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeQT9ylqAEpIM2pBKYa8uN6yIzNeEVpMGIyDeM56KSU=;
 b=S87A2ST7NHX7+ye4IUgINZGg1ug/0TECoDCIoM6f1+u0/WQ90x5VaL8GhGTR+ES5FyAIjwHd42ks4q8jwzhmnNhlaC0hLDksWUdd5NP7N8R4rsN/q8CLy/TeUHj2bYz5tkQCtht12sGlhrNYjxs0p6/M50+sBeB8uQKTgdcFKxOTBwF7z7tVADBBgHCDdsyj/Sp8MuOecuDvoHCvaUtXZCJaHhu4ZvkZCXpJhw0VhAXYAT2eLyydRU9+Xfx3p0H3KbN1zO3pLYoWhMGIHw2SFcNdJb48wl7x1LHSccJvV+Bs6DC9rDmax5T4wk11urnQpU8t6nXTOtkC2JlKgBw7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeQT9ylqAEpIM2pBKYa8uN6yIzNeEVpMGIyDeM56KSU=;
 b=dd+P2L23hhiiqCRoxkxjRf9cN3yj+sfKqaEBUIvjy9gRJoyfdeO8vEVfkfhCCRRmUggwd86J0dxsCo/gK9S/bZjc0FpIAGCokf4ETvIM/CkLFoi05xmSK2JTtKtS0qARg6lQF3IzvnoUQx3JPnlkeaKamBHFI4Q7nQIBSpnDhRtX3yentCBrACaMKcWqptMAObwF3F2C4dJ0nUws2wfa9vLWxz4/P6mLKTx83CTK/TcOgo/S5NPWoe2zf6hEB/FLPf1RRopVRevZtInae0nwqu/HFfI2k1QA1iyUp3sBA1Nuy3lZJ/SgUDhHc3ucb+x3PbChSaMi1IlZ5h3t5Q8Sqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB8091.namprd12.prod.outlook.com (2603:10b6:a03:4d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 20:50:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 20:50:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 6/9] mm/truncate: use folio_split() for truncate
 operation.
Date: Tue, 10 Dec 2024 15:50:54 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <A0EB7412-743A-4B6E-9FBC-FB21AEF40CE6@nvidia.com>
In-Reply-To: <9DDA4D1A-8546-4B70-BCEB-7D98E69375ED@nvidia.com>
References: <20241205001839.2582020-1-ziy@nvidia.com>
 <20241205001839.2582020-7-ziy@nvidia.com>
 <ee92b309-db6d-416c-97ab-25abf8b12957@redhat.com>
 <9DDA4D1A-8546-4B70-BCEB-7D98E69375ED@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:208:32e::7) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: c92ae0fc-6998-46c1-1f22-08dd195c58aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Km3CfUKV4UeP8bnFFUdTilrem6w3kJU4DE9Uy1Zt6/39ZdGuUA5qz6ppQQXr?=
 =?us-ascii?Q?T4FSySRLJx6zbZR6ZzA/69XdcFShktr97DAci6401/xgsgnFU4rJa6T+49zT?=
 =?us-ascii?Q?76Rx31ZacDFWiA86vCuowGlQO9rPvrS96cfly9jjLy5kSdYL4GW5RW9+/9Bu?=
 =?us-ascii?Q?Ov1aRzmuJvdKXPmxhWEc1mlrM9peYaPwBQmYvoUU5MFp+HUD5pgLiiYs3Gg2?=
 =?us-ascii?Q?veqr7GOGb6AboKi6qBRENqSmEax3tPnRpdqU6+J409nHiJDUVQUjwv4Ho+Zw?=
 =?us-ascii?Q?wLLeVhMjgkFQNyiAKhGRP5/nbcFBPngM4lmLGkPl+yHVmiOD/rDhZoLaQXxv?=
 =?us-ascii?Q?FG2sdnDMp40/YLqzZjnVR8gYcwcVU0BLNrG1PQevVR43/MBPhEVzgAqACixr?=
 =?us-ascii?Q?wa6lLyqpILftygP5paonwuqliAcTg4tWgmtHvvbqwbj0T3pfHakpEcRyOMBQ?=
 =?us-ascii?Q?O7/zvq09wsydp4vn1B4h1mzhxYubTifG+CKALL6pi+v8IFC1qt8uQC+rUary?=
 =?us-ascii?Q?DUDSgiq2wD7ZkvD0Z4DH+Rd0td53RWBIqMjvLcqajQVu5K1PK6cosyhF4pvm?=
 =?us-ascii?Q?Ji7zyJAn9m4zFrsitVlSmLLfY4E6iF2VkSnGO4NDyEi0l/9V5e9o5sx+KE+d?=
 =?us-ascii?Q?ybfJ7x4TacS/EttGOoYdkhEwhlI0qRvQg6E1RBtUt6E7dlLwqLbz2CqOZNER?=
 =?us-ascii?Q?4i5yYV+F+8ZVHCvzY87tU9SZ07Tvzbbyr6wrxfS/4NXJMUwH75nD83Pa5Pt6?=
 =?us-ascii?Q?8i1Rrk2AJg0Z8fbJMdAqlDp/AB/VXz8Zlr1uHsmdPu2sjUqbdl+UpFWg4PMJ?=
 =?us-ascii?Q?g6q1iMhfFFTNPaUthIkwt6l18DFrkmXiIsIHcnGAOehpMOEzo87/Bnk7BgrE?=
 =?us-ascii?Q?G/L0nYbeZJXU0Y7lo01DHQbHADLTQ0aLEZ/ymSRcxbB7LPAIv2QegeGEYAdI?=
 =?us-ascii?Q?uM/MSqvo2WrFMmKSi4Uxvw5UXvAaVHbxKkRCI3OyyLA//Rq+wYfQXAhwKghB?=
 =?us-ascii?Q?tJktPa7bZF9uOHkMwMYNvH0Gybb8q0jl+WcX4TBcZnQjIridc38GevE283j9?=
 =?us-ascii?Q?0nVDcvni9q/a9SqehLV4MzTySsW9wjRnaDUDybQ+tVALEaZqx/LoONPUMb4v?=
 =?us-ascii?Q?xghWrRz+QEWrW0fjp3/Pu9/hTO8KRDcosDExsx+PkBgRYmZXcETRATngXKWJ?=
 =?us-ascii?Q?WP4UNAo/HM/5IP9uSoeYTqOLt3qLKx6zdnY8WFFEWcJ/Q0R6OPhmLwIRcff4?=
 =?us-ascii?Q?q8ClxvUuhC3xb2TE3Y3LhGPmtRHfEhVExQe9JS375Da0+D1XBGfd//AItJJh?=
 =?us-ascii?Q?kNXOmoJpVuDIcfOAI9M0weiaOm1wXZowFkYDDX7gXxP/pA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OUWD+KdhWkF65yc6Jpsx7s+81SDlME+daQxuPt7JyVX+ClC6GujBPSwpsqeJ?=
 =?us-ascii?Q?ZPLZe0IHIbkzCFqBeiwXAyYh1t2gtrCeJ9AqUaTgIzQUQIlvPFXRQcQX1NvM?=
 =?us-ascii?Q?wXCYn51UAthL4X0BQVJ6TgyCxGt4EV9rFFx87N1JU4cz/aqDz+Y1JWiwcvIC?=
 =?us-ascii?Q?77q2j6MfmqvvNY/ZtRclp3CWsWBMVx5tgvkR2tdmrwt3Xp6WE9y+iYjkl75H?=
 =?us-ascii?Q?CRACT7K/HZvHn8T6rLIuv7Tqak/yAJGfHEHJrgeZQwOEBh4fPmYqTYTR9uZQ?=
 =?us-ascii?Q?Vcsw/zE7CdcNZmUBoim50DV6JAzukcLTIVjNIyZeFoHlv6eNUuP5CrqC0C+H?=
 =?us-ascii?Q?THOug7ZZETH6g0UPjTj2WXCJXMfooDYbFj4bPKbYCaBaxiEl4jt1pTfOCQNY?=
 =?us-ascii?Q?pXtTd453QV3QdF1r1qfY46LzbFkoj1pqQWBBqyXmzLjTYVuksXTFaYJim+Cb?=
 =?us-ascii?Q?p2jTi5/dI5TRFBMpP2dp2K3VxjWikVktnlSmU9Yf3q8fLCGm5IdYb3ZiQ0fV?=
 =?us-ascii?Q?uI6n3e24FrlLWGp7rJxzNAjtPbIDrdt38CRJP7uFvM47V9MGWYJmgkIPsnoD?=
 =?us-ascii?Q?Iyibs7k/xP2c+RkR9KLh/mvjRqt+snSBvDuVtU+YVP18fOUklh2orqsGVPzk?=
 =?us-ascii?Q?kBhUMUzoM+i+7Yi7iT7Q6dYQp986BofC8CH+ad7Ac97RCB9hPDOIi0zEGaA3?=
 =?us-ascii?Q?DKeP7X3uGl7tXmp1aFMiBLmj4AkPUlO5wVrnVX8op+Kql7SuP4Yt325wACuC?=
 =?us-ascii?Q?CZE7sE/LjIXz4cxe8Hk0112h/k2YHFauTZ5lU5TtovBsWJ2N3jHZ7rpRVzGf?=
 =?us-ascii?Q?UGv0ymDGg7dtme/V3JVyQVTFAKcr3sTuXBeXGF1Zlo6QRYjgPb2Wz4pqbtgb?=
 =?us-ascii?Q?C3Sm1N/GsAXmCvVbVinKEq0UK8SrpOFtmrQCaKIrVRNgREsL05TBZrXLe8/q?=
 =?us-ascii?Q?1JGbtE9mdq9m+VPRdXjzUHarlH2is0d+1lLhltbvkg6/+pWFROwCjo4VpL9N?=
 =?us-ascii?Q?NvA3NF1TeLbmNf3H6FZa8w0cjXkqBR4m0/t5D5v5j7UeUozs1GcHQ1TwIerl?=
 =?us-ascii?Q?xzosex6gWKTXfysY7J5bWWq7XP4OYBIWSPByeyEbSm+70g0V0kN1acqg9GmD?=
 =?us-ascii?Q?zivsUYV5R9zrjucIioLRYQ7oQqQvXp2GfaQ8cf37mxY5aMDgdHFG7OUeMNpr?=
 =?us-ascii?Q?/22Bsnayd+QzKsh7/Y4m+qGtL2UKGip2vIBsox6zkNRcnvRaOtao8XfVMTSH?=
 =?us-ascii?Q?IgVf1TbM+hyiUS06SCjJvn3IsOl0tm/2w/pI8tj1mCuxAquhWTNLn8WUOtAl?=
 =?us-ascii?Q?+hj4+gtxgGi9QBrJvq/6kjZnb1g3jA37oMSnlczzYwwcrTyUkpiXaO/76FGh?=
 =?us-ascii?Q?FBYf9dNq96Jo5bSqMThG0MrNmA5V0e1g+Lc+CJ1uipWmXTFEaOq4Oe1IZncL?=
 =?us-ascii?Q?xypfWiuBSH5eOgq/Y06HIw/UjqssIrLjgAsNMsc2LB6XTZJiwT9rCe+OgszY?=
 =?us-ascii?Q?Q6mFbV8sn6vj/7nY21BNvtu4mrJk8bUTi1WeCovEDdH7gdqfNVNqbCOm0z7w?=
 =?us-ascii?Q?3yy0SWy0/AKCj9BwU98Fes/OPW2irxwyh7IDsv3G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92ae0fc-6998-46c1-1f22-08dd195c58aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 20:50:57.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TvZp/02gv6iGIljVRmIpMvSj1S0EjtJbd9iQmm06wkQPM0olPt1eGVGJgwE7ZAU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8091

On 10 Dec 2024, at 15:41, Zi Yan wrote:

> On 10 Dec 2024, at 15:12, David Hildenbrand wrote:
>
>> On 05.12.24 01:18, Zi Yan wrote:
>>> Instead of splitting the large folio uniformly during truncation, use=

>>> buddy allocator like split at the start of truncation range to minimi=
ze
>>> the number of resulting folios.
>>>
>>> For example, to truncate a order-4 folio
>>> [0, 1, 2, 3, 4, 5, ..., 15]
>>> between [3, 10] (inclusive), folio_split() splits the folio to
>>> [0,1], [2], [3], [4..7], [8..15] and [3], [4..7] can be dropped and
>>> [8..15] is kept with zeros in [8..10].
>>
>> But isn't that making things worse that they are today? Imagine falloc=
ate() on a shmem file where we won't be freeing memory?
>
> You mean [8..10] are kept? Yes, it is worse. And the solution would be
> split at both 3 and 10. For now folio_split() returns -EINVAL for
> shmem mappings, but that means I have a bug in this patch. The newly ad=
ded
> split_folio_at() needs to retry uniform split if buddy allocator like
> split returns with -EINVAL, otherwise, shmem truncate will no longer
> split folios after this patch.
>
> Thank you for checking the patch. I will fix it in the next version.

I am going to add two functions: split_huge_page_supported(folio, new_ord=
er)
and folio_split_support(folio, new_order) to perform the order and folio-=
>mapping
checks at the beginning of __folio_split(). So truncate and other potenti=
al
callers can make the right function call.


Best Regards,
Yan, Zi

