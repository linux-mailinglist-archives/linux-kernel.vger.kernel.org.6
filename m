Return-Path: <linux-kernel+bounces-368858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 927759A15BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50B41C20EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF691D364B;
	Wed, 16 Oct 2024 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JUCRkjAg"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03D18BBBE
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729117044; cv=fail; b=Uy2KrmtndRKFdw2PF3Al+AGssUXy4zxo8CUYo7JRkw6+2dXYNyRsKYBwSkIXWLiuZDr3l0Xgl5mrf7MzEgv0SRgNVQ0U6syHjBDUt0BaDU7r7Vskbyri+TmYQjqRIx3fjDP5DmD0+DTY3KM85fUMUdhEB1kOS7/mQhGqkWhwrdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729117044; c=relaxed/simple;
	bh=KnpcgUTFBB4b/JHGiBFe/UPwWsSYCE/47gNhPhUPchU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=kc2h2hp8FalSVVIA2X9ZY3gQdh61Zwp2Sxx732SA/zSSEXKQBFB4RkA2FivMgZsv1tq0epgn3KoW1CIZT8gnaAd35VUl50UuHAHb5Z4wUkz2K5l7jLEmJUZ2pnmB/zFmGzrBINLluQwujaArTx+nAGrOFwoAiBLeumetPkt8LSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JUCRkjAg; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K33l5KVnhznccbAJbniljFG/qdzOGPHcsAxRPQY18ZXnzK7nTsyku1hZym6TCoaHdgkYngCPWs4C5tYHnu1jNDf1rAYVTGvD3DMC+S2ev7Lfw4DPmroOw0cGwEU3AwaJUKkbcIBz9u67HYWrmPuARoJlZOl2ugca59Cg6CKLm5e3XzEIi2wn/9GUuI80dLhTbGrMeK7ByvjQa9CzwBm3vPW7O9b6DnFKyDyd4Upnzilwlo3kieuy7wZX4ViyjaHieKOsCDkC8ZoZEkX4org+sW6d5j1GBpxUlFivaQVgwdzm/Co7W36UyNqePHdfyodbz6YJtCe1FQWtkRQEdNdgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p3Fd4MWvIdhDFX9svRUYG0oiFvfUQue8R3RYFRhgfw=;
 b=xaszbDZ1xvArcDGKg0psvjjtH10czl10C5hXQWvC75h0D09XRMn/dxemRYAqW34ysLvRA1+kXmEg+atgEExaTKT7cgMznz6kBdIEvObVPBk+Dlv5HzznNCPwmgsqRbrTaueudQ/YYx4K4vpLPbnNNJn1EdemyPJDd7R6xtN/n+UBQrUoiNJtLe9OO0iYNOY4lInHjFIZoiAmJnrmGCMisSHsxYjR33T2WFs8yCFF7U0Vr4sfBxjnhokoZYK+NGUvP9X8g5d0/zsrorO2SdKrv3xOl1EDEAQyjU68Dneun5GJBQAYCJb/s2oB9PBQs3m1WwI0Azb0L/dQHRR69hugPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p3Fd4MWvIdhDFX9svRUYG0oiFvfUQue8R3RYFRhgfw=;
 b=JUCRkjAgo1SnAaQXFkKVBoVhFJQSlRXy114SSAQahpSNFsFROdM38tT7NOhsnUTZ1ZZC6ccUtevcluaKt59vn7/1pZKdnhA93ijBIyLOnzUK57HDI8o2SibYUAmn3GqZ+CszC8s/6+UVKXwYvYFWwVIy+KIQ1eUG7UUdjk7MxDxXGOcvvF9ci5JZkDiHuEjGeZntvd0YF3jAJYIYj43yJ0fZkMmVb7Q0DVbYLJAFSebXxESJn4FPvMfOfrTTgfTWlYFZ4CsK0eSVaW2jyfJ+m+OEMU4cAkBvMERn3fSyRHlUucEtPGRmKUtGAGv7e8xkeO4p8+rWq6vMv+CZIs2JEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Wed, 16 Oct 2024 22:17:19 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 22:17:19 +0000
References: <20241016202242.456953-1-jhubbard@nvidia.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Shigeru Yoshida
 <syoshida@redhat.com>, David Hildenbrand <david@redhat.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory conditions
Date: Thu, 17 Oct 2024 09:13:32 +1100
In-reply-to: <20241016202242.456953-1-jhubbard@nvidia.com>
Message-ID: <87ttdbofpw.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0118.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 5beefa60-ada1-4758-cb37-08dcee304cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KrNhfB0hAhIZq5j2uf1efppg5mII/7vlTrusrvSCPjt33Yys9I6dAIDdBnoG?=
 =?us-ascii?Q?vY2Tl2zinLAp2hBXN8zFSncbQt1n6+BnGttsZw4+sQTypMNVlVkDJUbJ0c3H?=
 =?us-ascii?Q?7z2yA0ZV0w4wYQLVyX0rQMhAKFmi75gnPD2l7ZTb6TMnOuguPoekX6kAr8tL?=
 =?us-ascii?Q?5ptOTiTmiLleI/PKIYfSJYwrYYdIZLQUDpVWCDVspfvJxc8f69G4lmBJfRhw?=
 =?us-ascii?Q?JI1JeuFwWvQs0tAEAWLJUdn7eypZB/NltW96QB6oK+EUSSL6sxJdz2jYa+r/?=
 =?us-ascii?Q?p21D0WvycGxjMwWFHFSQsOYG0B04iY3b5T264MpGGha0mEaDAUmU06J97JuJ?=
 =?us-ascii?Q?/KOugkMKgZt6NQXv7XHvBl3TnPfTEwU6qNyjyiynft2MVqjD/puQHHeFoHp4?=
 =?us-ascii?Q?seZzsuHCtL6BbLByMjEHrUwHakuVuYaqI4CgtEKSW14xWAWn5i6VGHWv/wc3?=
 =?us-ascii?Q?YkA0A8Bjmdyc/oi/cNUy1EzdYDyXkkw0xx5k4zXYodxFGy2TBMRS4xxVljzc?=
 =?us-ascii?Q?9UBtlyCWSaWAuTTBs2AC1IBvK4jRDVaRLuAJLFp7u17DHYUjq0xSSeFomPpB?=
 =?us-ascii?Q?/OZbf5yU/citg5wh3bPhANgTTUwdPoBVHxHmbKTot/Nsgjt+hIlcWmoT6fmI?=
 =?us-ascii?Q?6UwxwEbpseo67Q5k2JzuEnpBd9aVtHwLllba7lklucRFi5g0S8G+2+2N2WaP?=
 =?us-ascii?Q?PD/SQ9jPpEa2GNQIEkhFDbPTc5J4i4VmBCcODADLzKjXgZb7j2QU5/D9TWi8?=
 =?us-ascii?Q?pGkKuHelR+bkJhvoOxcHmlFfLs+KgIu1IOal+z87c0yqPuQwxdAd1S/ldqJ3?=
 =?us-ascii?Q?yNdq4JjuI+XhD+0csbedACMYYI0ZJv6DvX1iJWLQSrLQqaQImF0+3Cf13QFn?=
 =?us-ascii?Q?SRMEF2Px6bH8SfT8HqPESyLpO2fB5oJcWISQytU2/Q71gYxkfb9sYGl2RTTM?=
 =?us-ascii?Q?kFNHaI0Vjj1GYuxnOQM3aNtEFm8+JyfyHuJa8BrXB/p6SdoqzZ+y3iCHKvBb?=
 =?us-ascii?Q?axsfyCD/G7lZJT0dLYBDJ3FaLprnWbQA7dL7qOnIUmi6r8PyQmTGfXqwqzyY?=
 =?us-ascii?Q?VPU4FfCWeiUYHaRZwt0SWXwFRWSI34z/BOFCCP9saDFYs83Q+sY+eX4o0x5C?=
 =?us-ascii?Q?T5Wq9Rw/pTRJXe7ZUOherw4wgowJ+ykPLo+2wr0z2RWF1lus0xqFDujk3zdN?=
 =?us-ascii?Q?3S2nLK+ix8T9lSaTNoWFtqEffM1N1FPulq0ex6mcRRWUE+++l1GSGItAJNLy?=
 =?us-ascii?Q?WrymeZe2Hrft4N//1cCaw4tIDeXsacGh9grpLas7B0dgFoCBO6Tz3GZufsYn?=
 =?us-ascii?Q?nFHHybV6qUggL5Hv8wHwPjE0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QF5GT3zO1ni7q/Ynon0rve69VUZOHS0n3edhuFMzto96HSrS1OiK6iRWX0Il?=
 =?us-ascii?Q?tQ6AGhrQ1cBvFKoNvNnOBv8vEb27gHnfrknRH2THQT7UyIWTxIeeRe910/E2?=
 =?us-ascii?Q?rs1MzMQSTKqBdLPukXKLkMjkiVmGxIwja6nQdjOxL5Q1AnzKTolgkYUPT+1z?=
 =?us-ascii?Q?dDtyKfvRZpkPP+g6JSYBUZCIfuTJ6RNcIZGC09jMX5dB30vhcHSvHxmUL2d1?=
 =?us-ascii?Q?iPTnAS7Qvkyt0As+5UBO1LwRriNOWFiqpoGGlMqt+ED/YNLBwOe5aDBQaYP3?=
 =?us-ascii?Q?UoJlD2XqR2PPivdwxnS7DV806zmpbgO2VgLFLMWPVxpep8hnohRaMsLNap7c?=
 =?us-ascii?Q?c51u10MCiMFShm7L5/Grpgi86BZ9NgHr/um1siOcDfDBZBunJOcdKzlbyQid?=
 =?us-ascii?Q?XU9CsuuKsZIttjFw09vD81vskHRXsfzdYubYylIZyXC9ZPjdYrnCbEDsi1X5?=
 =?us-ascii?Q?2vUfabOmsuxCB9xw1lCVRDxzTYvsfZc0vlWui8CyalSFlFmcqzoWsyFEmjYP?=
 =?us-ascii?Q?EyNbtg98raGO45zQAUulEPB1j2OCl0ZhQz3Kzu9UDU4mxgIEyGwVPwCd5uF4?=
 =?us-ascii?Q?hxz3TYuD+XSPvj7WBN10dLuZoJ0l5hEly28R+M8yGAiSiI6FNjSSD6TcrnIn?=
 =?us-ascii?Q?NV4gKC2DQ7kzBpk45X70UkSNa7vB1oJY1OazDmWIUB3g4Ct9CqrRnz/R7GDE?=
 =?us-ascii?Q?000+TEwaQVjUFzvSVT76w6GYiP/R4HusWicc5I/QmM26mMKjcbwHVJWOL4N3?=
 =?us-ascii?Q?zHTB+6Vo2hKLeaQLI5r0PQbaplvYOPvlYv3565J8Q+9C1lNGclrXkMUXzPXJ?=
 =?us-ascii?Q?tec29WxaI8lYQgZdD6HSuRpe8FDIIKCygTqrCFGVZvUqQxM7SsFDYaWSIgrg?=
 =?us-ascii?Q?CIsX3nSvu4dvhf+cOhhZUmCZM1OAS7eiwgRQl1mqdWRuniZN2RUulE1dMHBA?=
 =?us-ascii?Q?Huoi6ClRHZyodYPsY+5tvMevmOYTysheW8LQ4FYqm/0kuYsYL3gCEx5IdDoj?=
 =?us-ascii?Q?c8aTHS6QMiJWjEtJT4eOnJClmCgV419ykordntMEBsd1DVAMRr7i4HIyi8Io?=
 =?us-ascii?Q?IGs2nlp5l4zi/dU9S5xFJRXwJzq5mxn8tDZ0mAF/GyMp6fg7z/kluS/CPPhT?=
 =?us-ascii?Q?524AF4vPR2iPjif/04lNgnbJzpZOpxwm+QRLMGHmkpLLnZofUagi0KmXhM7U?=
 =?us-ascii?Q?2knhRPWSGKm/i685yQvPFgG9yzr3/MF4U7knY+P0un38LsZ7iluu70EnH1kN?=
 =?us-ascii?Q?1OTCpBJ5BSKx24XX/GFoUbwVzndv+pJxy2tZwdae4Qo2Pt2TrrO+RqkhTbNn?=
 =?us-ascii?Q?eycgwzlKN8M8K/tdfQAbCdEepEB61gkIhH4T9wDYHgZoagleICsXBqoZiIN9?=
 =?us-ascii?Q?R1x+ynQAgZgZAY6luKkO0p6UU+XzwrUpJBaVIwVgs4OxASqUqgPdHpUERXvm?=
 =?us-ascii?Q?UlYQxrn/9s5lucaBcvbm46AwmxnNgvyYRxT3mIMDDd1iwuCyYqH/ShFoRi5b?=
 =?us-ascii?Q?N0MISUSET3QlXos11XMZ3h6jG92CWVKs/XHV5F1ip8yLitGW6pcuF5EoWpvd?=
 =?us-ascii?Q?RsfnD147J3JP/jWalup1KX/bB+O30BEOuuhQw0ah?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5beefa60-ada1-4758-cb37-08dcee304cc9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 22:17:19.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bzjv8ZmZauog1XxP2O6wqBx4XNb8dAN6hV2A+8C8PTorVlUpp+JigYT9cGjl2EcSaRpHxvbsy9j5ehoiiN6EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325


John Hubbard <jhubbard@nvidia.com> writes:

> If a driver tries to call any of the pin_user_pages*(FOLL_LONGTERM)
> family of functions, and requests "too many" pages, then the call will
> erroneously leave pages pinned. This is visible in user space as an
> actual memory leak.
>
> Repro is trivial: just make enough pin_user_pages(FOLL_LONGTERM) calls
> to exhaust memory.
>
> The root cause of the problem is this sequence, within
> __gup_longterm_locked():
>
>     __get_user_pages_locked()
>     rc = check_and_migrate_movable_pages()
>
> ...which gets retried in a loop. The loop error handling is incomplete,
> clearly due to a somewhat unusual and complicated tri-state error API.
> But anyway, if -ENOMEM, or in fact, any unexpected error is returned
> from check_and_migrate_movable_pages(), then __gup_longterm_locked()
> happily returns the error, while leaving the pages pinned.
>
> In the failed case, which is an app that requests (via a device driver)
> 30720000000 bytes to be pinned, and then exits, I see this:
>
>     $ grep foll /proc/vmstat
>         nr_foll_pin_acquired 7502048
>         nr_foll_pin_released 2048
>
> And after applying this patch, it returns to balanced pins:
>
>     $ grep foll /proc/vmstat
>         nr_foll_pin_acquired 7502048
>         nr_foll_pin_released 7502048
>
> Fix this by unpinning the pages that __get_user_pages_locked() has
> pinned, in such error cases.
>
> Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes")
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Shigeru Yoshida <syoshida@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index a82890b46a36..24acf53c8294 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2492,6 +2492,17 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>  
>  		/* FOLL_LONGTERM implies FOLL_PIN */
>  		rc = check_and_migrate_movable_pages(nr_pinned_pages, pages);
> +
> +		/*
> +		 * The __get_user_pages_locked() call happens before we know
> +		 * that whether it's possible to successfully complete the whole
> +		 * operation. To compensate for this, if we get an unexpected
> +		 * error (such as -ENOMEM) then we must unpin everything, before
> +		 * erroring out.
> +		 */
> +		if (rc != -EAGAIN && rc != 0)
> +			unpin_user_pages(pages, nr_pinned_pages);

I know this is going to fall out of the loop in the next line but given
this is an error handling case it would be nice if this was made
explicit here with a break statement. It looks correct to me though so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> +
>  	} while (rc == -EAGAIN);
>  	memalloc_pin_restore(flags);
>  	return rc ? rc : nr_pinned_pages;


