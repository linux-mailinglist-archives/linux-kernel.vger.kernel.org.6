Return-Path: <linux-kernel+bounces-368122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6A9A0B76
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4989E1F27129
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F1C205E3C;
	Wed, 16 Oct 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IP5YtHjZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41933A8F0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085440; cv=fail; b=f7QtF6hXEKD0LgiZ4U4BgdiTBQhFUfJCIK9Zz6nM6chbR3GGjLB+wfPyk7eFl3jreC1dnWYskrLL7k9oyTovjl+jURjNw7J8uesFUPwwaOr0HLGNNwlO9UkPIlZip+DccdUgWubTquPfSIqSEHonCzqBtUB+uczQVlapBYLxC1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085440; c=relaxed/simple;
	bh=OApF4DHyg8qI30P37KhV1cc1bi0iXR67Bwo9NGxALQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uPTkzKQEng0EyMRP2xfbYuXy3N6Ba/WOuJoXiFyxRCYfKToqc8rUQQUDrhNqJ0BXPAQmERTL1JalfVAa24gij9k4XnXfb2yqxTKSsuDpHRK3cGUN3WAuZQGfo7RZWsSDKbi6wxXGrkMpwX8aiijN0gm/NBO6NRZ7P8QyeEAjlzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IP5YtHjZ; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCz1IvAh9/fztiuMuzGdVabNyK20Y6f9qSpk8nUhb5hbSdBkqRmY+51F2JG2Fl2RAy7B6Lqfw2MFh3hDLpfO8Cr6OQIyVSxEhRoji4gvSgLUlc5WQKzDGg9zKsNi3QDq1J4r0NvnXpq5Wy2AKbKjwRLK4gtEOifNemsIti1juKUj7UNNt4YYxXr77LVNIUeh+koegiyJpfvlgYJ8DaMykAOxxpbMXUbQXO+1jtk10F8aNJx8cQLzH741iiXHU2xwHAe7bguAABVUkBeRNPnSsk/WrkY4zIOYTyX+y5IwD0+6A/mf/nYLgduHhWR231gF4koWCYZElrXPECe0qqIRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21cQ4uluXg7hh4yknQcSApYp+eXVQXonxcbI4lAEAYA=;
 b=X2r4UjIAqQRUNjixJPNsrrWuw1MiwKfRD0NQTpImOQD81HaiU5n/to85etStl0ypVKUTY7Mj7E41PdBZFuTB1SzkMZ0POUlPU/6F03a/XEPLnoQHPZzQM8D0uCqfzWKJi3QkEg0Jw1LIzhCs+pVYdTDzK8GkLUMyTw7lpzbmVwI68q/fF7AY5K8AoTDYybMZ2kpbxMAWiJLo4mo1VQ/JEkgKQ/ogIGMdt8iKqtsns4NnJ2bovyJq7OevI+QwSy3E7/XPk/XYBTjUkcQ6MOXyQhkHU5T1kJI4EaNVrlBOzW3W4/D7d+nFrQWKttqyJiweP2PztjwwtHZvglmiX5YMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21cQ4uluXg7hh4yknQcSApYp+eXVQXonxcbI4lAEAYA=;
 b=IP5YtHjZ4xrkpLpothR0c/Ol67EcjpQSTdJeMRUPdiP7IVXjfTFcL3soXl1vao1Z4EOHSQRRAPYj8pCptTDM7Nt9PGW1BV6u3bVLhGT30TfNCJI7m9cloW4Bp3tqvDS638eIcw8d4FobtOTpQ5JoYsUhgsSujAhZs8cIEMAgjchOkrgyeB+vxBYm9xY/pOUbhfbXBgUUyQx0D8d3k8a859Ws1ew+dQY2L3WzitQMq/9Xn3+nFhpawKtq4ZG18lidvJk36UjnSjvfWI4yrQ3PgQPBmkeEH5cQnPIZpm+G2bhMU0es02HeVz5nRnE8hOuzUFVGwRJCD+DD35hr8vk5KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.24; Wed, 16 Oct 2024 13:30:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 13:30:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko <glider@google.com>,
 Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: avoid zeroing user movable page twice with
 init_on_alloc=1
Date: Wed, 16 Oct 2024 09:30:31 -0400
X-Mailer: MailMate (1.14r6064)
Message-ID: <B40D6646-9914-4E14-B20A-C31CC77E4F79@nvidia.com>
In-Reply-To: <25d5f12f-28ca-4320-919a-0cfa2dad1d01@suse.cz>
References: <20241011150304.709590-1-ziy@nvidia.com>
 <25d5f12f-28ca-4320-919a-0cfa2dad1d01@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_62EAD609-98F2-4606-A8B9-95D9AB59BBBB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:208:236::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f45f46c-3643-41d0-62ec-08dcede6b669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qbYTUeioJ1rt/9Frz59YI3Edvy+fuse59FDO6caIzP67vGv9urLnVXwVltPJ?=
 =?us-ascii?Q?TmHxcjJpZeldfvOEveUrzMbMbHFnwfd6QFFTMXs8OrfmvTyXdPNigVnMQeYz?=
 =?us-ascii?Q?Na3tHLiAVgUSUizfogRiase5MZSjlO5C8PIJcoAwWYgHlvv6qI0Gv3/ODYKz?=
 =?us-ascii?Q?NUuKE09mRc+8YnrKU/+vDQyZnQ2Z4xiE+X56asjZb3jDulnrHmKMSyUPqNDK?=
 =?us-ascii?Q?MwnKscwBSI0JLVFf0uZ4l5dNgjCOvcKIvgsi7m5Hg7nm4rbLlhr+jRaNr1F+?=
 =?us-ascii?Q?JB4E6y9hJFqSFfmZrAsOCAQl1bK/LC9wtJ12Cctw8K1BqSHmSs7l2AxByjW1?=
 =?us-ascii?Q?CEAMmsRNWJRVzlhgjMv7vr+s8RslkF6yYEhEt2lYerbHeS8rYhWdR/OVxlnB?=
 =?us-ascii?Q?cJ1JUH9INGetLoA3AgceJgHxHdFRr/lAEXsWRk40nH7s34VuJ7sxR7p9iPtc?=
 =?us-ascii?Q?3wcaLWGqTWxy7bVD96ZFRQLAugqw+XDrESEJVS7gczBEYZx1bKN8xbjjeqb6?=
 =?us-ascii?Q?24C4me3CwGQ48HAP/G9w24orXs0srAQgfPYeqEEC2c7qwCaJByw4/CXyVDXn?=
 =?us-ascii?Q?OZnH0rQwcw8pGIHOokNNYJ0tDkwcIYNCswGMlqORkMunDLM0iUndRm04BGZJ?=
 =?us-ascii?Q?/rvixmBU6GW6bWmOJ4EhzKJRr70g0hmsxe0QR5QezQeewr2lnrKCtoGEScEU?=
 =?us-ascii?Q?1AyiI3gc1AVhWwdg1P7ofoE8ujvQPIxspfZIXqQYB3o41Hm9hpVj0/EfE0h8?=
 =?us-ascii?Q?y4vQmm0mGXKPePS9gYIO8Vs2356gMkIKosDRXGqnpJW1+tgfRnL5xa2BVU3c?=
 =?us-ascii?Q?TluoS2xphzvB0xIdF33hkHNI9m1n95zA6HvbbN8Hp0wvrHh1BKXMPDrHsyQX?=
 =?us-ascii?Q?CHmWQ21hV89Mg2dAUqRurnTUkPjUa3SaL8h/cqJdlk0tuoAdqldrDptca5cl?=
 =?us-ascii?Q?ExofawKWcEjBRNZC/A3FUvevbKin7YxPyZuhlOprfLluFmB82Hmdt30QmJhM?=
 =?us-ascii?Q?c8bI538tiZmKkwCWE1CdmN3K5b/0NntGLziO99x9MOpypaTfQZOd+i9PyRr1?=
 =?us-ascii?Q?m0CL0qhWdlpUnPJNjbBlOOA40S05+HGhS3J7fEtzVEUxENa13Xkj80+ODHFr?=
 =?us-ascii?Q?u7I53llvii3KZsp3mGLU2bwFzQ9NOL/O4WJVnuVFtIOVZYB3C38q0M/fs+qE?=
 =?us-ascii?Q?UGgpLO7Tl433D90VRb7tASRow/tzFJev3mCr5DBHYl08Fly5rNrwA0ke5lr+?=
 =?us-ascii?Q?yIXm05ZrtKXWgZVwtA+F/pND8ZysrcDpt4rbCHigdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l3HNTolZEoctsdgLRYWcgSXmHxC7RDf685omw8046C6ZcOICfuThEVqV7v0y?=
 =?us-ascii?Q?osA8fzArmszcYMuv/h/F+sp6PNg79z9k9PNrQxsyKxBFxpNHAhyMm2L0asAJ?=
 =?us-ascii?Q?QyM9VylFKyApU8000Szdw1j3yksfL0jE8lQs//KBAw5K8ZLWlBWUfdQUG/KC?=
 =?us-ascii?Q?zk9W64gUbH6AyMP3WfbuC9Gq4nXZsmzIJuzesqtQSGKRbKs4Dftw5AXhE6Xh?=
 =?us-ascii?Q?QosC+uxo1E/qC/bAhnmkYqqCb1YzFu+9e39y9yTZeGeVjU6f47F1oZCrUuYY?=
 =?us-ascii?Q?eevzgPB+LiRc/dUlL9nZy2BhVAAJD6YHbn8fttsElHUsFDkvs/Ipb+tEZdRz?=
 =?us-ascii?Q?SKdgu9wIjJlTW+nhA58fNMQYvp3ChOlVN62iRtaJ9RsoKKOv0NQGgs/5lIQ8?=
 =?us-ascii?Q?lQcQXq9hoTt4OzE087i0vPjIXtqb6HaS4wWRxoW6HgjfEHlUNkNBK+Ikv7cZ?=
 =?us-ascii?Q?T9gKJb2XDVmgCP/QT5oae9lg1EDWwEBNJdn3mkgbttnnv8sGV++9EnbLeNtU?=
 =?us-ascii?Q?WiY2UbS6cVSObaJ9zUhaYhlkHhFasAtwIH+nkjF8YjnqSPD285W9JmnUveFe?=
 =?us-ascii?Q?Zcm5xU5mUCAlvpKXcywzdOnGLpeLeIHjdnzns1tGixVL3RVNInHPAZTXtS6n?=
 =?us-ascii?Q?VI41oTW8mFRKRXECKI0sYO8/fJOjEP9TXbc+E7oVMDJX2Vt0X4GZbeHuanAm?=
 =?us-ascii?Q?9ZxHeemMKYK/zRRlFh0KgdUYA+T9ff4k3oTawvu9YCvdohU2TB+jFK3pDudf?=
 =?us-ascii?Q?OU0hGlzb58/Az5YcHP++oDYZZ0G7MJC0NNnfKoLxzTqHR+CDFJ+Ev7BdcDvz?=
 =?us-ascii?Q?SBDMPJVABzIUS8ALcA6KnlfxHAycPiz0Ovys/aHdQmQTbDcmMx0X/KBG2VO4?=
 =?us-ascii?Q?107lXs9hUkpr9Bn6boCpXgae9MmP7iEi4IJhcJjwYPidF3ueCDwxi8MHkwJY?=
 =?us-ascii?Q?veD4kw65piAeBFnHk13TTNk6foB5g0jI88v5krB+K3MsBJpPuOP5KofpsjXR?=
 =?us-ascii?Q?Nwv6uGbaWAO2bLqNYFayhp2G1G7b5rXt3p7yUg7EiJp/uUqEN3UccUOoyLE2?=
 =?us-ascii?Q?BiXC8EbDnlU71l4WokfKg6zFslfxDRfzflOFPzhUddsGGPqlmczgH8fbJBWR?=
 =?us-ascii?Q?guIKJHXmYo9NLoyiV3Zy5mqdLLlc/HLF2zafGjvGnsPaKkwSUPOD51M66hY5?=
 =?us-ascii?Q?O0Qg8/l0A2e8ZxjLFxfKqyDe1SFQdTbNvQXlvLfV8uulNn9/22d/zCblGQC8?=
 =?us-ascii?Q?2m9RRrlPkuA5CXLa0i9JQ1gjdeGYVCvwMZq/BJI82JrQmkJ1LYYJcFjQxmzB?=
 =?us-ascii?Q?gNt2ni5roM2Gz8S5mLYtJGOE51aq/vOGxMs17lh/1fxXLJpVll/jXVag+Y7y?=
 =?us-ascii?Q?fowC/A+BA1se4P0LLTxBcrPiYRoIpwq90yv4o8RiesiKqh/TwmbiGGrXRcGJ?=
 =?us-ascii?Q?1DJQjcxPzcvwKC8fGArememYod9Lv11qGv+FfK4/VexY+QkQVnWyEhtofZBj?=
 =?us-ascii?Q?M81D7BLUxyV+wIXvwPcGkx+eyOIqxSVG9jGAdUayXI5ag1FldJKaDG756J/b?=
 =?us-ascii?Q?9WoHC8PcG/TnuMOVP+I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f45f46c-3643-41d0-62ec-08dcede6b669
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:30:33.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baueebcI/HGKyIdHGOZmtpeTOQY5wDDOo9mdHE+03OoHgtuwVc3KthkvvBGHrq26
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707

--=_MailMate_62EAD609-98F2-4606-A8B9-95D9AB59BBBB_=
Content-Type: text/plain

On 16 Oct 2024, at 8:53, Vlastimil Babka wrote:

> On 10/11/24 17:03, Zi Yan wrote:
>> Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
>> init_on_free=1 boot options") forces allocated page to be zeroed in
>> post_alloc_hook() when init_on_alloc=1.
>>
>> For order-0 folios, if arch does not define
>> vma_alloc_zeroed_movable_folio(), the default implementation again zeros
>> the page return from the buddy allocator. So the page is zeroed twice.
>> Fix it by passing __GFP_ZERO instead to avoid double page zeroing.
>> At the moment, s390,arm64,x86,alpha,m68k are not impacted since they
>> define their own vma_alloc_zeroed_movable_folio().
>>
>> For >0 order folios (mTHP and PMD THP), folio_zero_user() is called to
>> zero the folio again. Fix it by calling folio_zero_user() only if
>> init_on_alloc is set. All arch are impacted.
>
> 		   ^ not set?

You are right. The sentence should be:

"Fix it by calling folio_zero_user() only if init_on_alloc is not set."

Hi Andrew,

Do you want me to resend this with fixed commit log?

>
>>
>> Added alloc_zeroed() helper to encapsulate the init_on_alloc check.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_62EAD609-98F2-4606-A8B9-95D9AB59BBBB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmcPv/cPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUPo4P/jYRbKGd4JR1bR/Sxd833zDeLdhn4yY6yu1b
iIOIj+aH2gs6pU1D8xUUnstSU/QiItnYxGteoI6+Qcrl3r8BC15pAwHlvOOFQeim
LkhVFGsDTaP3EkDNVNmg7hWUhVx3Yn/FHu6xpmc3H318VcdAuc7SehhDDjgdup6a
+a8+yN4/j+7grG3H9+Pld4XnggF8i0285c98toj+o+TB+VVnqAgjGXiP9Omg1SD2
k0J2EJqZDls+CoVnXHYBRf5x598UFcRBObkWJToWHQOJrOCOIwmUaDVno5KKsv7f
gobuBqhX2v72b41hPEdsdz74NjiElyzDaZ74qvLDw2XVnO9KY2P+WtNHhDDv7E2E
hbiGaHB7S6xmJHhgNiLiKIa1wBo5MhesDvzztdd2Za9QdWd1dvtZEV7b7nWA32UZ
YMoER5t+jjAB2u1dl+UEiTdx+FTRz/Y/jTkt4z5/mv1QbiuSrgC3zmcZX3X2D3ab
HHCm5zxMBVgHRehil43QskaM+ISYbfoqIYXuV9rcu5kQ+g+tk+ollPb0MOtaNnH2
FyCtKDE6nNQNfRhKAOg0vpNH1qEz9f5GkL6jpkuZjOmrAQ+Ig7E3r8nS3Vbi/rHF
mrzExO7zyBOitJ4IMdsT4WnMOc8CW5KtcAcst0H8vS1/uOIVV5rkq8nM10iNTB69
tB21IOIz
=trSU
-----END PGP SIGNATURE-----

--=_MailMate_62EAD609-98F2-4606-A8B9-95D9AB59BBBB_=--

