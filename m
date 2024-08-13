Return-Path: <linux-kernel+bounces-283966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B9E94FB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A281F22C21
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E36979C8;
	Tue, 13 Aug 2024 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GWezLAaF"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B011711
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723513212; cv=fail; b=Z93qRVJQcOpzl0XhxapMJuc6W9nwRBHbCHcgw6oX+sZJpRHD2NXoVMQx1GceYHId02UlBu2v8XyqROlBMYDlZU3bgRaiMtHfdQ/ilgTm3PoSS6hGdEr8iqanEDmYLZNYyBLe2xX46dMisTKNJ48sqrqxwvYxJm/ZwaFZevnn+gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723513212; c=relaxed/simple;
	bh=8l0fQLcquRcCTqkgLYoNxdZJr7C78dCxYtN1k5JI5mw=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=WIeupW8ujvLFlYGGW1ZmHhF/gnECuu/bjOEfNudzlagXH5v9O8kfPetXhLyG4UGwYhm1rMHdhL+oiP0/K41ZekSANHqtrzo6v0nMU787NaBhSup2HKAIbYGJ/bnRDCe58c9lemmRs25c5cMgpTrREkuuxUzpAUEyzBu6+RLPIcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GWezLAaF; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXa1nHY6srusZnxnR3kVIsWfFSQJ0G+PG0cqDEHPyd+mh4SwB5EYCTn+/m8n3Cap9Hx6sFDuLyyRZGIInJpj7rMR8sugh40eiNC4eI/9nCRpdEXpN/1/2JcEfNH6Vq5DzvJW9MkemPYUDOUpDoP6L0N+1jtnzIwIfIQ2ElEV4iUxDdxn2RNtOnYt2QtmunX6vhhho7lOVpnXB9W0Xxn4TeLq7Ndd3l89Mf1h2L/OIUxQhuTyH4Q2jjGW/6f+gwPmjnHd1Zp/LCEeHp6QAXm716csId4LQhJfKIqngOGzCANLI2cfYz6RByZbr3Zz1kKwpoylhK5FmzkeycYm4XIHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8G4+rGHjGADdFW9Hi9A4EUpONGqJezzPn0+JOBYxcU=;
 b=hxJWPZs/+tX3EkEzPa13PXWnV8IgmLV4Cuy4QwicmsfEl2sy30ckiI/EOS5O29MlPdTqxR/lV3kqN1J4f7jp4jc6JIJ+TNlJPNZEiez3sF5Dq4hN63KW1eD1QFLoHBv1DqCq9ecqAi7/9oHF3W4wAwj3QDekj8QxqIIwG0/PbnuYzrFP9NUFTlA05YOaVvqkyYFu/Y4UORvd/uDEw60Wpn2zY5zlOUqAir+B6PM8kB16doGPJCCHb9M0Obv+4J3zsTKM5RT5H1Tqpx8b2hUCd+M+h+pK9NIQHv8EF5xjv8pcFHd0hyZhbny0IhP8FS1OVGy8Nxwi68m7McWre6LCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8G4+rGHjGADdFW9Hi9A4EUpONGqJezzPn0+JOBYxcU=;
 b=GWezLAaFo2G/nm6+miC2FNSDclGpdgNSgO5+OkXJ/0vgPDTPvsN5amEDvfj8wxrGRRb0ftq3lIJpDFV9O9uUqIgOnBZWjQjEkaZ21E7A0+SIhQwQ7uCI2g310Nc03lNpReSrrIw7naUEfM2IuPgCIF4+Emkk21slqZOOuCeUjfF9Cho+mEvFztqQmiTlInX63nYgJmf5wmOCCqb01NYKE8uL2/gbtw/+rz0tactAoSHShZxyaHi0mxtiYPOJ4K1LvpqYBCuCBJ085y5c5tqd2SLgTDu/GEXaWX0NiGZ0amat85XsLxxKCteStY7V6enXVmdGnMhzfsmfuoWYOjSO8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 01:40:04 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%2]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 01:40:04 +0000
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
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, max8rr8@gmail.com,
 linux-kernel@vger.kernel.org, x86@kernel.org, jhubbard@nvidia.com, Kees
  Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
Date: Tue, 13 Aug 2024 11:33:24 +1000
In-reply-to: <87frr9swmw.ffs@tglx>
Message-ID: <87bk1x42vk.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5P300CA0027.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: a65197b4-c5c0-47e9-0e23-08dcbb38dae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bh3LuZDv9AMorOS2QHWAOaOYG8DIFkFDjtMro89emyQu4Q2EYeNufUUs7/Pc?=
 =?us-ascii?Q?9mBHxv163hmVLO5pTMlaCtirIf3LZx8g5n+UFjocrIydAZh/ChFFLieh5Cq5?=
 =?us-ascii?Q?c9As1ZTbHAh/2gNngWzcU3TEp5MytV1HDhPJZeoFqcbY/Pn5zk189QtcOjqc?=
 =?us-ascii?Q?ztL7Oa2MXy+56S1zh1TQCqkXHHwMsIG1LrGetpRudHM2fQAdl7fWsC7LUvYa?=
 =?us-ascii?Q?fVCfGrmlKodafaqLrvqvBaXPSQqFmIfgu71885hWgHORVAx791LqPsJA6Eyp?=
 =?us-ascii?Q?/wl7lLV8XvIsaQQdzCVLs07ENqbLksNoTffQUT3eieb5pqjkT4og/qTLNagJ?=
 =?us-ascii?Q?Z9H4iqYYA6NDCg0FkgrsQUTvGsG3JkphjKZYvsCclTu4WT9H8aHKi8orrg2a?=
 =?us-ascii?Q?oeqCHl9xR4jiAJdIqTyqKBggnhmfIzfnFXb4t+KFA7zkkmhYfseN6jRuVRPX?=
 =?us-ascii?Q?pnN8FLeGjM7I7c9Evt07vByj8Tr9NC1fUQQ2j0l3hcbUyPGNSpvSGDKuz4kd?=
 =?us-ascii?Q?mEsPuK1Xl4UTyEJ0MKy1Dx3Fdczrf1Ngdpi9VJxJknsKMfvI6J1mc3EFBxTe?=
 =?us-ascii?Q?M9X635LnshrOkDgx/9pLVf95FSL9BCkc0rFD2DlSroHzdGf0wDiMgwkAvGd6?=
 =?us-ascii?Q?EjHaHLbnUjUiG50RlCujsB9vDlaAAPpTFATfWL11LsoAe22j56pA1oooTyLh?=
 =?us-ascii?Q?nS8kRuyQaUvUE/LNLqFhCZq0kOzABmXVOxwD/fSj8xQGZy+mhuAejb/KxmeP?=
 =?us-ascii?Q?L8KtcDyKKlYaDJBCbadwK5WrqOxJnCBGJORUg6izK4lEyiJ9nq+bhkllXqEu?=
 =?us-ascii?Q?0LqFcnq4m7jrvjOYFz/fotSwsI3UkzsfkRLBxWxYSXxHyNlCn1cW8K+RlEak?=
 =?us-ascii?Q?vy2JecUzCvraDjU1xpl2oh2A5zNXV9hLx2DvLVcehNIJfKFZuhXSs2PQU7wh?=
 =?us-ascii?Q?VkpGqk4ouzjkOYO9dAeZ7V3wqPwt2HqfUW0scGMkNBkcmPNM3fQCiZwi7TSD?=
 =?us-ascii?Q?vr6rfeDB+PmQ1KD/JxORatCAw7DkBBnuzoMxOyGbs7vBqB59GVZj+UvM9UK5?=
 =?us-ascii?Q?i+Dw+8NapGz0wMYZMXYt4WAqCONpezzezmqyXMCkMh734vsrLvCW3x0ZfnDu?=
 =?us-ascii?Q?JJmDxO6C8Q0m0/j+K1JxQDs8iqZ0HYyk1C7DWBBsngOZYGqbvDqbPW0tQZk3?=
 =?us-ascii?Q?7VyMhRaJrymsf2o4RrQ8u6dHFuB14gX86vUsqYxzwN6aNFIBrut2IQw/FL33?=
 =?us-ascii?Q?LXyquaULfxH1dtYNPbOwbnQXAMdcV+YGjmqf5GEzbpp62pJDaOZvnKOewINX?=
 =?us-ascii?Q?fZQNQhWGJYAKmFjn04ImgcE1LfFVGrjMnXQI+BTCPOQ10Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KoNUhhYcnzGNX/kOPn+32SgKKYrEhDZjq+Ej7Z2MyHksQDY3kNKswC9zljK/?=
 =?us-ascii?Q?l8EnJH1FJAjoQAWZI76sK6/AlcNVbCSXgHlKe278O0zkz3sLMqQ1PYlXBS39?=
 =?us-ascii?Q?n8Tg1cJumzD98pCfXEfF3X7wG+mJdttbpF7OgdItWzeLpAetBzxsj+8vej9d?=
 =?us-ascii?Q?6YzZuBChL1DV93rNJYo6JGOToGKQMP6EU7r7q1NjgVtoNwIh1JhlOI234tyM?=
 =?us-ascii?Q?VfMwSlEU86zjnlV4fskBmraszTpqsNq3NVRWN5t2MyGP2E6nWKMZL6Bnf7vt?=
 =?us-ascii?Q?OuDlK7nl5iEKlgBRiNf7LEY5Mp6TlGvnZEnNTiiLxcFTEqvOGWSNWu5vof+r?=
 =?us-ascii?Q?LVZUZCi0dXgVJEt98iHMiKmXkkhRuc61YWwlw3nHFD2k6Snk5wospu1pjEh3?=
 =?us-ascii?Q?UlfZNHH384GyJZpaMOS8Wh07RWH1E22mKNyU4hL/eg9O6cJUrNTcdDY4iSNw?=
 =?us-ascii?Q?xFMRl88ceTqsDLhF6x5nllOj1sAstjcVz2eExDB9ooa9qr8iPS/4gW0rTGrB?=
 =?us-ascii?Q?5Az70WYyb2B0QnwZURnUEUL2ZufhjR7tuMTDQkfaqWrPn6gxckDZSUVI4KUY?=
 =?us-ascii?Q?JazYiZWiUls1uMtUhOsxghf+KIXIUhq7zOR0bqm8XsJHlcDMBfjifJf58+/g?=
 =?us-ascii?Q?8WlR7IzFILXHRq3GOFOu3I+b7a1ZZYV5VyGRCYzn0KuOBLTok6KxjgBC7nHY?=
 =?us-ascii?Q?g+73NIZ0ksewLgQ6s3ObDHF6pt/wOh9eJro40m1ui9RuJ+Vh+tqqjcWvVp8K?=
 =?us-ascii?Q?ucfcSxOs3aQAPjO/VxlLKnqPpdq28li+OFQEP2P+rx3aQ5D0/UlUEWuHy3uW?=
 =?us-ascii?Q?v4hpG7869lANy7C3ul/jkiiLdS4ksqzsqaJsRH2jmNVsURSZ82WDRF6rARJN?=
 =?us-ascii?Q?Ebul4AuO7ipijHNBkfrp9I4ZPPb6tt+6/VHehkzX8Qo0t69qSLlVZlvAGPck?=
 =?us-ascii?Q?GR7i8R9Olr78aeuEO13IXB2B7v8EedCwx/D9560helgW7vUg5R2qXCf4TuMa?=
 =?us-ascii?Q?Y42EybnusTBZGg7N3HytYtf/QPWqkxT0GFviM58MiFx+u842rUdjltpBEmsZ?=
 =?us-ascii?Q?Azd2xfcLVqHeonqFuzm+18ozDo69lui93fGfWBEDwpDx8p/kMj2u1CsGXS4F?=
 =?us-ascii?Q?FzaCkwEd+pZVMN7Bd0HdgdrgvUzS6qrbD+JN+4KRguxld3xxeYVzNesoo5OP?=
 =?us-ascii?Q?lMxyYSPXxgQzDknrkfRIU4hoHaaXnh0+OShe5fRK5664slrNrg0quuZATqt7?=
 =?us-ascii?Q?pvL9ccCVYl7R2KDlTOHQuWHbliEv8oZimBS8QeO6m5g6oxSzqPIhXfsVPsUd?=
 =?us-ascii?Q?uhrbYV96Jdqcir6P+FUsE+oQrqQjBOrNcVifFSJ9UcE3LjkPYj95ugya08c+?=
 =?us-ascii?Q?GMs+4KG6pC4W/HcAo/LjYpFNMdJ1d7OE8YkS4nSV4yLQjFDbXMDYEmuTmB49?=
 =?us-ascii?Q?Vq1iNfYGwGqo4sxthVKL1LG/0zuAn3oI7WK7sDXFCC0SuZC9Em7jidpgGtL7?=
 =?us-ascii?Q?uasONjNT4xrzcOvynIEcC7lIkYVmPOOkOrEDO/2uXMDDex0alrzZ2FiP9iLQ?=
 =?us-ascii?Q?Z+PP8FaqTJodQtIHGdALFmH9tafiU1O8Nz7oJ6ky?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65197b4-c5c0-47e9-0e23-08dcbb38dae8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 01:40:04.8105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKPZYrj/Kt+S6TEXWQMkS38KAVNpfklu/On0jxdlrG+yKzDs2aHTSwPcOFSt4pCj89Qu8ZtMcqHLWuceDigEjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257


Thomas Gleixner <tglx@linutronix.de> writes:

> On Mon, Aug 12 2024 at 12:03, Thomas Gleixner wrote:
>> On Mon, Aug 12 2024 at 17:41, Alistair Popple wrote:
>>> The same applies to the rest of the DIRECT_MAP_END users here. Perhaps
>>> it would be better to define this as DIRECT_MAP_SIZE and calculate this
>>> based off PAGE_OFFSET instead?
>>
>> Duh, yes. I shouldn't try to write patches at 30C :)
>
> We can avoid the calculation and expose the end of the physical address
> space for memory. This time I actually built and ran it :)

To be fair the previous version did actually build and run fine, it just
didn't fix the issue. However this version does so feel free to add:

Tested-by: Alistair Popple <apopple@nvidia.com>

[...]

> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -97,6 +97,10 @@ extern const int mmap_rnd_compat_bits_ma
>  extern int mmap_rnd_compat_bits __read_mostly;
>  #endif
>  
> +#ifndef PHYSMEM_END
> +# define PHYSMEM_END	(1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT))

However I think this should be:

# define PHYSMEM_END	((1UL << MAX_PHYSMEM_BITS) - 1)

 - Alistair

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


