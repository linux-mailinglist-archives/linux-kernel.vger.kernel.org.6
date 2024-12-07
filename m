Return-Path: <linux-kernel+bounces-436083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC099E80FC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47891282364
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F21DFE1;
	Sat,  7 Dec 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y53HCQH1"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1814A4C1
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733588434; cv=fail; b=qXNcf4i6Z5cp0Vb2hJUDieGAf9b4pBCr/8023cpESM+xQTDrIzRyL+0CJSvGrO1sYQQvj75TAEpkmc2tIXhHwko+mo7il4DtjaDR5lD5mm/EDzlejM3f4FpZMuX+XHtcE4d3EsPuOcyMU/4jwDysGAXzQDCw6/ZjnIDCIOhJcyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733588434; c=relaxed/simple;
	bh=E+mQWdTF7Av12EWGGU9A8QckPWC7Mw3MkGlXTyiEoYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ITb4YBph1VM31cxrlDI/au9boPdE6b1LU2X3BbF2Cl+Sw5YVaE3jP2SQBC7VxA9Ic1XbrQ2HS8oidasLWjfXlX4+jDB290EwTNna/A7z/l1LOOBBwUKwZ0aqcofPaKfeiebAWFYOUmBzhlm6s7b0JrOzQitTZvxxO0MGtO3Iy7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y53HCQH1; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzNH1E4tBdpwh99l+KOI4POjjOFqmtkVxq5husOFRZejqhpcfGThAu2F/YxPF9/9SWgpCxkpFi6b7o5KkCx2kOvgh3sKGiFIy7CQ8JOqGVJy2BVLN513UltntDI4WBwiAOMjFd7BSnPluZN60biiwsLtm3mGM7a2yvBZSchEiaJkRRb/Zq+cRbSs0RREC19PBVvSnJGsFMblnHxP3v5mIpaOg1w+zfFwuzx4qlrd5x+qFAvRNzBwtjKThhOge6nI9akTomkJdEYTl+Bwm7l5G5c4t+oUz3bO0iFL1l1hNh6dpxFfL74JbNe4ooh7ppUSCL6ek8crMUJ+wWrf6Gk30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPk/2sgajBVZO4HKLpBilBdqaMtS5wPzsyukQTP7au0=;
 b=vLEvr1gzkyoo2TtNFv7rXkzLw9Obe4+WD8G+7IJrpjXGz1x9ai3/c49wJfgcEqt497LpA248x3x/f5d47PHNTg+ys8Pz3UsCL4fFZMXn++hwwin00e3mevSXt0q4MPQJcvPZZLe7bQKInniUeIFWJ18lvC/vrCQ+xWiNzIyxczbjuij1N7//PMsZqsXsa2kvCLm2OWUrL6p06ZmXNGXoQQOGXA6s3lyGFt5nSxvzePFzIPAWlvWUXsRHPPnuwvjuer0YTkPICN/Hw7fcMe9SbxM+uPW1lpwMi0yI1HoQKDZ2MVtlpAidIixy2UFq39rlZua7R5QT2sazK9a7zCbuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPk/2sgajBVZO4HKLpBilBdqaMtS5wPzsyukQTP7au0=;
 b=Y53HCQH1gr49cG7gvgQsNIHrFSvqy2AjY++7drPh+hEuDg8J1RMYOHcJr26pgmzxWjoXmQad3E1NNRUxVn3Y1trRw5RTLBLKY2aVfxmYL0H0oYsCXVtUzQqwrdVhJNWdpbAyvlQNgDIW1XFkvyqqDEG9tjx2g4fEE9BwguaDyPR6Z7Y7WpZp0trIW02ouT9VttfekbdkVQ+cGyKSaSCRcuQxD059AuZU/sNamXWUkOGy1bo8702pOhJ1XtNIbLWDXnLurJyBvw+Xqqj+5eT3FKuo4/L2K6FjSDBFbYLZkI45fDdLMkvl6A73O6GdGAKTajbvvsi0DBBfjFYi7+lg8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Sat, 7 Dec
 2024 16:20:28 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Sat, 7 Dec 2024
 16:20:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Vlastimil Babka <vbabka@suse.cz>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko <glider@google.com>,
 Kees Cook <keescook@chromium.org>, Vineet Gupta <vgupta@kernel.org>,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] mm: use clear_user_(high)page() for arch with special
 user folio handling
Date: Sat, 07 Dec 2024 11:20:24 -0500
X-Mailer: MailMate (1.14r6065)
Message-ID: <34C615C1-E1CB-4D8B-81D2-79CE7672930D@nvidia.com>
In-Reply-To: <acd263a4-824c-4c8d-a3e2-8b2f391fc775@efficios.com>
References: <20241206174246.2799715-1-ziy@nvidia.com>
 <acd263a4-824c-4c8d-a3e2-8b2f391fc775@efficios.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0439.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d543b2f-6ccb-476f-d39c-08dd16db0f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lmaSiY1xohjQrQfYItr8JrorBVA0jEhhyZwcPCERIgQXAYSD243f3A5Q04Hk?=
 =?us-ascii?Q?8gcSDuFgvTL5eJNUCAuKs46KE/D1DTnSvmBelvtv9296Wiyvi4bJE0tYrA4u?=
 =?us-ascii?Q?1W4PKKV6HjFTW3Q+5JrXQf1TmvMXiSEsGWnrscqV2xnwlnVyEbgPGUYnf8Zn?=
 =?us-ascii?Q?vITiGFJiMyTd98ZLVAg77+IMsoG5LNdWTGUSzzsvfvsRii4k2ID0V0bAmRe6?=
 =?us-ascii?Q?4T9/b6xXyXS3oMOhPgPJXViLGFYNqESOBdBTzqgXvxhfx1Dwz2ePDkjDsA2H?=
 =?us-ascii?Q?J0mj+7v9+yveQHx4CO62zSGfwc8aJa0/JSSy7lngIyZcAHQ/DYe/GjuxQQgQ?=
 =?us-ascii?Q?BIaFo0jeXCuIHguE93g1ge43yFPJuUSHXv9U/vdOFMSJd8anCSZ3SysHMakC?=
 =?us-ascii?Q?TwsLn2zGzOxXRI/Arver+bO5qgBA3zyeqhluJhP7u+CjlC29uIOaHf0DILJt?=
 =?us-ascii?Q?QmeX9K7M0f90Fq7OcVCvFm1xvijhb7ae2nMpfKJX0OaFKnKsSG7igWqeA5jm?=
 =?us-ascii?Q?ZrADRB0ZkkcPQ/8bC1deIHGqjctxzch2C8+8mXEa7TlEyQksOHUY7+AiA8tf?=
 =?us-ascii?Q?fwwzdAcrwVLAmd2hhzA1WO9+ul7ckp8poZOQ3LqYIvPTepljTgcpYrVvS2Fw?=
 =?us-ascii?Q?/X2bRII9cFEKGrLB0yaEFwIC5tAx5LnhY6Rw4c6C1zTsOmwn7B9jJ/8W1g10?=
 =?us-ascii?Q?/pyHYlUtOI86rznhwCGtykpOnKQpa+D86641GqmB6zmM3nNEtpS2kvNS8aEW?=
 =?us-ascii?Q?pm1EmfWI4mYvRHvdHgwhU7u+NMXzWnVF5CE3uiyIZ84Pbh3C7RFYcKyH55en?=
 =?us-ascii?Q?nlrA1Ob58DgLF9rdzfelHxchE70LME002rQwjCuxSBADPQgHoNyISRev2Ubh?=
 =?us-ascii?Q?JL0M+DP+T2fq7acIM7dku7IbPxHHqe03F9n9UrakNsIWV8zrUEo6QHjHvD5d?=
 =?us-ascii?Q?2mJrWzko0RD14VMVAB0zKXFqqZSsQTRIAjm/CblSB7OcxJsYJM0/xjKckpWn?=
 =?us-ascii?Q?H22/8cWVjiDAYxA6Q8hTU4YXHM2hB8y8MYlLmt/e+BBlOfRKwo1gcHaQxKrU?=
 =?us-ascii?Q?Q7BH7jNpot1kZTdbEAZdE5jjKSi9P6FlVOGGVfqZve9/ddpPWfNMrp6Vf97X?=
 =?us-ascii?Q?DxjZpCR3kopewuqFziiEJzMYmrdWSFI04QtZ/4bi25lmFOOj6YyowJPsPxiK?=
 =?us-ascii?Q?L9ZOmSx5rEJgHB6fXIReJFVk6tnzpsVGaWY4xvZab9nt99zJjx+wwd5mHwWA?=
 =?us-ascii?Q?lS86THkpDmSaJ5ExVLpA1eBHV0tbWs/LdIQ6yKAObFxv9VyWhxhPCausd9Oz?=
 =?us-ascii?Q?jRqtwFxd4By38XrkFLeGZViVzYtAXttgjXXjlHIGaAukA954UeWUe55sZLhD?=
 =?us-ascii?Q?KFy0w4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1JSypMLxcrrEZcx4FaxDR0CzagPwK17eSdmPpLsHPCkaf770CQbnq8s/tpFi?=
 =?us-ascii?Q?cMbevHidz8Yz9wbiNICrcWCG02QJr1Z/y74YoQjGY5GNmIXuj/r+OF6r2wjI?=
 =?us-ascii?Q?NGJPlSDL5GrDZErsGhxwgvw7/9f9p89V8/S+Z8Swey9kxa9oUSnZ405rMF62?=
 =?us-ascii?Q?NYDUcrZFOS5vR0T9SXEWI2lziPADg+qpmeEZKnQbXVaWpLS71puG++/aIqK+?=
 =?us-ascii?Q?x0crpqOaxWjPsS3A7FDGgGfxzbOVgRY8kOpaSZ23mZv0JEo44oLfuJ7vgXfz?=
 =?us-ascii?Q?1oPWrBq2vyqmy3qspa7o6mWH23RH2k2nw+NmiIGkqoMwCM8INFTBR99aRc/v?=
 =?us-ascii?Q?TPLft80AvLpmYtY2StmStE8GpHpv2Pg2YGn2XbrF9h037kXn6GR49lngaN9W?=
 =?us-ascii?Q?tpquFhTcLy7z9Oejr6gn43OaFzWgY2+xEBnjlKQKNj453LFAUf9U7FeXuOG3?=
 =?us-ascii?Q?PxPXEY5s31cebJd5ngxMh09zcg53pY/zsdDOiyR8wqOsQSkwjZrhv3yXQs0c?=
 =?us-ascii?Q?ovC98ZojovClGzeTVLMKetuVNKjHd6cYPZnHzCFMFoDNSzsUed73OrA8U9l8?=
 =?us-ascii?Q?yUJmhoKKS89N8N/VN1Zoc39M7VMgpwth9VsPpl+wsalwGb3Tlu/020LLjAJm?=
 =?us-ascii?Q?gpHi/LPvM0++BlAfdkN1m9LDP+oUNGYu5OpLpm6RVrCYL8+Ms9z6/cTcb/6C?=
 =?us-ascii?Q?7h9Zro8O4eVb1EizkdE79opHpaCEoGl3LTFmQvrYTsewLOvi/KqpknvdqAZC?=
 =?us-ascii?Q?DzQd6CABOvXNBaXHKXEDrH8tHe97k0cMp+UHJXCqMKGQocg254ruDqrpzDpT?=
 =?us-ascii?Q?8dF6dCTuTF9yDqhg32qHaOgFnB0JdJ0a+MJGdA4sV8yHfcJTok5kTyrNyo7t?=
 =?us-ascii?Q?rIOLPLLhI4zq1+W0Zal/otZcw7vJcGm3yITym6a2PhXrSL3G9B2t5XeiC11W?=
 =?us-ascii?Q?YrjRnOQAknTkZqSWxpwyGPo3Hk/k920fT5OwDcfrWwFuctmFT0jBCb+IxkpZ?=
 =?us-ascii?Q?eeMbIfj8Zmdf3lDBE3Pf+eFm7EIHt3KkmcxFwBgfJNDDYnRl2e6EgKjVOwhK?=
 =?us-ascii?Q?tpCb7hPSEdFjzVqyM4V/rPH4MR4g4dAyrsjycX4f6tB8iKGB6LmuShiKZUtU?=
 =?us-ascii?Q?8di1y6Vx8jPNCIzQDhrVQYik/wmooce9aFvrT14kaStBsDVYq7JIiBLDpQpZ?=
 =?us-ascii?Q?+uG9jvOri5cd2G95THUZpLy3u8IiUM1MWa6J/o/lXWXnSGVZlBraUividmUa?=
 =?us-ascii?Q?3UNu77vsM5s2JQ+eHifZhHN/wdJzhokhuTMMnmfGu+R1wZXCuI9JWra+1TRT?=
 =?us-ascii?Q?EbfL+Lp8oFGyNcZ6B5qYSt12Svotwzj6cZyMEs1kT2OfRA93cNPi8NR9JcIE?=
 =?us-ascii?Q?iROFB4/Z1H4RomWWW5LQxBlQNuwDm9o228pZfGm4zcyAvA/9rbKp5L9Yultp?=
 =?us-ascii?Q?SD87gCZWOhlcwuir4snAfhSJB5umEEqkwyEQVb/k08Zar3lA+7vILadCkRg1?=
 =?us-ascii?Q?tzucxrxZw3F4Z5o7SyIC+B0rNH/ALHu2+Vczgn1OMqcDwmUh6TIPorlBL+pz?=
 =?us-ascii?Q?Bb4J4p+CatX07LfPd08BElElgzpm8DiPMmwu6sgA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d543b2f-6ccb-476f-d39c-08dd16db0f69
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 16:20:27.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoDMOs2XwNIRxTB5E9d5mOROjq/gGqrb4glnkvXHJmm+h3GEn0Eu14omVnC65Dhs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411

On 7 Dec 2024, at 10:31, Mathieu Desnoyers wrote:

> On 2024-12-06 12:42, Zi Yan wrote:
>> For architectures setting cpu_dcache_is_aliasing() to true, which requ=
ire
>> flushing cache, and arc, which changes folio->flags after clearing a u=
ser
>> folio, __GFP_ZERO using only clear_page() is not enough to zero user
>> folios and clear_user_(high)page() must be used. Otherwise, user data
>> will be corrupted.
>>
>> Fix it by always clearing user folios with clear_user_(high)page() whe=
n
>> cpu_dcache_is_aliasing() is true or architecture is arc. Rename
>> alloc_zeroed() to alloc_need_zeroing() and invert the logic to clarify=
 its
>> intend.
>>
>> Fixes: 5708d96da20b ("mm: avoid zeroing user movable page twice with i=
nit_on_alloc=3D1")
>> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Closes: https://lore.kernel.org/linux-mm/CAMuHMdV1hRp_NtR5YnJo=3DHsfgK=
QeH91J537Gh4gKk3PFZhSkbA@mail.gmail.com/
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   include/linux/highmem.h |  8 +++++++-
>>   include/linux/mm.h      | 17 +++++++++++++++++
>>   mm/huge_memory.c        |  9 +++++----
>>   mm/internal.h           |  6 ------
>>   mm/memory.c             | 10 +++++-----
>>   5 files changed, 34 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>> index 6e452bd8e7e3..d9beb8371daa 100644
>> --- a/include/linux/highmem.h
>> +++ b/include/linux/highmem.h
>> @@ -224,7 +224,13 @@ static inline
>>   struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *=
vma,
>>   				   unsigned long vaddr)
>>   {
>> -	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, va=
ddr);
>> +	struct folio *folio;
>> +
>> +	folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
>> +	if (folio && alloc_need_zeroing())
>> +		clear_user_highpage(&folio->page, vaddr);
>> +
>> +	return folio;
>>   }
>>   #endif
>>  diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index c39c4945946c..ca8df5871213 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -31,6 +31,7 @@
>>   #include <linux/kasan.h>
>>   #include <linux/memremap.h>
>>   #include <linux/slab.h>
>> +#include <linux/cacheinfo.h>
>>    struct mempolicy;
>>   struct anon_vma;
>> @@ -4175,6 +4176,22 @@ static inline int do_mseal(unsigned long start,=
 size_t len_in, unsigned long fla
>>   }
>>   #endif
>>  +/*
>> + * alloc_need_zeroing checks if a user folio from page allocator need=
s to be
>> + * zeroed or not.
>> + */
>> +static inline bool alloc_need_zeroing(void)
>> +{
>> +	/*
>> +	 * for user folios, arch with cache aliasing requires cache flush an=
d
>> +	 * arc changes folio->flags, so always return false to make caller u=
se
>> +	 * clear_user_page()/clear_user_highpage()
>> +	 */
>> +	return (cpu_dcache_is_aliasing() || IS_ENABLED(CONFIG_ARC)) ||
>
> Nack.
>
> Can we please not go back to re-introducing arch-specific
> conditionals in generic mm code after the cleanup I did when
> introducing cpu_dcache_is_aliasing() in commit 8690bbcf3b70 ?

OK

>
> Based on commit eacd0e950dc2, AFAIU what you appear to need here
> is to introduce a:
>
> cpu_icache_is_aliasing() -> note the "i" for instruction cache
>
> It would typically be directly set to
>
> #define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()
>
> except on architecture like ARC when the icache vs dcache
> is aliasing, but not dcache vs dcache.
>
> So for ARC it would be defined as:
>
> #define cpu_dcache_is_aliasing() false
> #define cpu_icache_is_aliasing() true
>
> And the Kconfig ARCH_HAS_CPU_CACHE_ALIASING=3Dy would be set for ARC
> again.
>

Sounds good to me.

> I'm not entirely sure if we want to go for the wording "is_aliasing"
> or "is_incoherent" when talking about icache vs dcache, so I'm open
> to ideas here.
>

Let me know if the code below looks good to you. I will use
(cpu_icache_is_aliasing() || cpu_dcache_is_aliasing())
instead of
(cpu_dcache_is_aliasing() || IS_ENABLED(CONFIG_ARC))
in my next version.

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 5b2488142041..e96935373796 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,6 +6,7 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arc/include/asm/cachetype.h b/arch/arc/include/asm/cach=
etype.h
new file mode 100644
index 000000000000..acd3b6cb4bf5
--- /dev/null
+++ b/arch/arc/include/asm/cachetype.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ARC_CACHETYPE_H
+#define __ASM_ARC_CACHETYPE_H
+
+#define cpu_dcache_is_aliasing()	false
+#define cpu_icache_is_aliasing()	true
+
+#endif
diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cach=
etype.h
index b9dbe1d4c8fe..80725010c38f 100644
--- a/arch/arm/include/asm/cachetype.h
+++ b/arch/arm/include/asm/cachetype.h
@@ -21,6 +21,7 @@ extern unsigned int cacheid;
 #define icache_is_pipt()		cacheid_is(CACHEID_PIPT)

 #define cpu_dcache_is_aliasing()	(cache_is_vivt() || cache_is_vipt_alias=
ing())
+#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()

 /*
  * __LINUX_ARM_ARCH__ is the minimum supported CPU architecture
diff --git a/arch/csky/include/asm/cachetype.h b/arch/csky/include/asm/ca=
chetype.h
index 98cbe3af662f..838c7e708d19 100644
--- a/arch/csky/include/asm/cachetype.h
+++ b/arch/csky/include/asm/cachetype.h
@@ -5,5 +5,6 @@
 #include <linux/types.h>

 #define cpu_dcache_is_aliasing()	true
+#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()

 #endif
diff --git a/arch/m68k/include/asm/cachetype.h b/arch/m68k/include/asm/ca=
chetype.h
index 7fad5d9ab8fe..4993846354f4 100644
--- a/arch/m68k/include/asm/cachetype.h
+++ b/arch/m68k/include/asm/cachetype.h
@@ -5,5 +5,6 @@
 #include <linux/types.h>

 #define cpu_dcache_is_aliasing()	true
+#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()

 #endif
diff --git a/arch/mips/include/asm/cachetype.h b/arch/mips/include/asm/ca=
chetype.h
index 9f4ba2fe1155..aac25ee27cd1 100644
--- a/arch/mips/include/asm/cachetype.h
+++ b/arch/mips/include/asm/cachetype.h
@@ -5,5 +5,6 @@
 #include <asm/cpu-features.h>

 #define cpu_dcache_is_aliasing()	cpu_has_dc_aliases
+#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()

 #endif
diff --git a/arch/nios2/include/asm/cachetype.h b/arch/nios2/include/asm/=
cachetype.h
index eb9c416b8a1c..4b492fbb4a39 100644
--- a/arch/nios2/include/asm/cachetype.h
+++ b/arch/nios2/include/asm/cachetype.h
@@ -6,5 +6,6 @@
 #include <asm/cache.h>

 #define cpu_dcache_is_aliasing()	(NIOS2_DCACHE_SIZE > PAGE_SIZE)
+#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()

 #endif
diff --git a/arch/parisc/include/asm/cachetype.h b/arch/parisc/include/as=
m/cachetype.h
index e0868a1d3c47..53180ff9d09a 100644
--- a/arch/parisc/include/asm/cachetype.h
+++ b/arch/parisc/include/asm/cachetype.h
@@ -5,5 +5,6 @@
 #include <linux/types.h>

 #define cpu_dcache_is_aliasing()	true
+#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()

 #endif
diff --git a/arch/sh/include/asm/cachetype.h b/arch/sh/include/asm/cachet=
ype.h
index a5fffe536068..f711631b9451 100644
--- a/arch/sh/include/asm/cachetype.h
+++ b/arch/sh/include/asm/cachetype.h
@@ -5,5 +5,6 @@
 #include <linux/types.h>

 #define cpu_dcache_is_aliasing()	true
+#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()

 #endif
diff --git a/arch/xtensa/include/asm/cachetype.h b/arch/xtensa/include/as=
m/cachetype.h
index 51bd49e2a1c5..89560b325006 100644
--- a/arch/xtensa/include/asm/cachetype.h
+++ b/arch/xtensa/include/asm/cachetype.h
@@ -6,5 +6,6 @@
 #include <asm/page.h>

 #define cpu_dcache_is_aliasing()	(DCACHE_WAY_SIZE > PAGE_SIZE)
+#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()

 #endif
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 108060612bb8..a2dd3d00e080 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -155,6 +155,7 @@ static inline int get_cpu_cacheinfo_id(int cpu, int l=
evel)

 #ifndef CONFIG_ARCH_HAS_CPU_CACHE_ALIASING
 #define cpu_dcache_is_aliasing()	false
+#define cpu_icache_is_aliasing() cpu_dcache_is_aliasing()
 #else
 #include <asm/cachetype.h>
 #endif



Best Regards,
Yan, Zi

