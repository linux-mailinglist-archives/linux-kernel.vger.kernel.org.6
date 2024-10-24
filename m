Return-Path: <linux-kernel+bounces-380748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162329AF581
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7331CB21737
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E1721859F;
	Thu, 24 Oct 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lTelMXLW"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC622B641
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729809439; cv=fail; b=EU7dtkbSJlYIogew7BN6MccSo+dKrfgUM+hXmdBiDdNzV0G8poi2ggTsR5LibN6l87xVuvX8I7ABudYo/Gp+BiXmeDeNIkKV2XuvGFtKB9K8tFkFp+gzoqUWxnBL75alh4vJDnIR4sY5OIokQ1fwE4PTsNmay5WVvBLc1YZDpkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729809439; c=relaxed/simple;
	bh=ohyN1rYjGNBWZ1s9WuftaZgpRb1CV9ndMxCu7Bv1B7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TDppomytti7xXQ33sett8hxCaUv07IQn6ddgDwlgbHyxMrsNZzCUcJLdU7v9Q8sTdQ+zHDI3oweXWGvPtVzcIv95ggCy0HYPFbMKjrzpqrcOWjaBk2bFaJLFru6lBubuNviEEUJkLX7VVmZoQkYrPUgSV6Od9vu51H5nqlIF7lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lTelMXLW; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4C0VCzw73v6MMBDETsBAdiIhRh4Dd/e/BdYFxLlGn7nCJItgqOb8xRoQANj8reXvV/7/A6uvJF6g3jGA8ESgKfnL2F6kxDfHn/lyU5WUlJl4sz/+ex3hHRqdtkKTfTB7NvbErsdoFnbmOfEljE4ThK47w7MNO+gVGrOhkKpQHBGfxzvoRdAXTogxSI3q8t1HFYWDJBL9FWw7O7z9UKl66rzfFsaQOPd7kHsg7JrnTQVkQ3o0IhobS702XrAkw2nBUDVFVBZfA9kQ7f+OWES3z8qLctdWKyxYWxHSWnHCBp4hjtJEPpUvDtAbCL9/gbJhSs6EwFbVFhdboSXL1TNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO0aBztOqml7SEWNuuJrcoqXr+DfRK7SnbFKxkCB1zg=;
 b=JNkIV39yo63itYkNvcsl1DqS2ZJmcQI7S1HwffMhDSoa1IGNmffwbp0CTig0MjZPslc3lLJtk7u5h2ZahF0IKBjznXRuK6s7fyiJfM/yIvN5e634kzvPSxmmeAcA6WyTHxtBMCkeSVuIghFWYE8nNUJXrY/mRJe9lUgGn2eoE462i6xiFp27ErJeuLaRAQ59Nd0b/VWtZKQOMy349nkE/5zz08uaIEB+pAMAhk4PUk1Rt2D3LNO3nqU94cQuryQlA+u1xcykyFuwJinG3cWUcxHosl8iTL8BkGaGbltQQ+WhMLxMhfB0n4aqmIhcRvS7pjxyfJCYUgXZP6I/1mgKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO0aBztOqml7SEWNuuJrcoqXr+DfRK7SnbFKxkCB1zg=;
 b=lTelMXLWLzde3O760Tb4i5p0bOEaY9UgnZpc6gJwYIXvNtoiA+6tlB2mbS0Aa3I6E0rxkGuV+zbjYZfQF62+1cjVPIQ5WCjZywIT7MUl8gLsLxU2BkHyisgqpIuXyKtCuf0gw34Fng6itzRCmpWFQHpq8TlcsBo0e646bQqR5bjil2Wn1oC9L1YTQ3IfuOpkM8D0aJvdODxF1CaySk0ZA/u0+8kx0Sl8FM+3llKdKz7iDabn7j5E7nu2W25ZGzW3NRgfLvqDVufIZHeSoDxBsypA/eowjTdMybY8x2Qb7qWs4zng8N9jMcI/OKmEY9L7ZZG9W6auWoSdQqPe/HdEkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Thu, 24 Oct 2024 22:37:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 22:37:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>,
 Wei Yang <richard.weiyang@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH hotfix 1/2] mm/thp: fix deferred split queue not
 partially_mapped
Date: Thu, 24 Oct 2024 18:37:08 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <3A1E5353-D8C5-4D38-A3FF-BFC671FC25CE@nvidia.com>
In-Reply-To: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com>
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:208:335::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: d22f114a-a6d3-468e-2648-08dcf47c668d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q3BKZqv2xREmKAoUel5SplPJT1VPHUog0/Md2wHgpIl1iqvLwXYgK2Fe8Xva?=
 =?us-ascii?Q?vT+e2RNg5USK/TQY+ri4RNMjnoLmlD8/IMwu8pRE+CTwz/KLOl0Si+fvbk4n?=
 =?us-ascii?Q?KVG1WGoiarLue0Z74I9mybhaZpZnjpEDuUCChkSso2KMu3dk8n+cyv9lowOg?=
 =?us-ascii?Q?hRlM4J3hs+YIDz1oaAxNjeaTsWNo33wl50RpqFFckDQVCf9EOmRcEZ1Or4M1?=
 =?us-ascii?Q?VPGkB+1RV/+o0tZdFRae343W6i8OxrTiutvNTapSMNtHOHFAEDUOGO9ss1GC?=
 =?us-ascii?Q?T2Jvu7u92TqoEE5YIuDv8UTpBOt6ZbPClI3ZSVTFxShXXwGDygegTOY+J0Dp?=
 =?us-ascii?Q?TA+uesqfX/ipr69spxNEWqKLQUpUd/83a0cAptB1KHbJqXB3/XpUVwZ4PCkp?=
 =?us-ascii?Q?aeyc0v2xJrt6uGYoQHDwHyRx+rnDN6QdWFekr++XniHZLulxfDk5sFlZ7l7h?=
 =?us-ascii?Q?8rKo2fZ9Jn+g239fWTjKuXr3ssrBqGOBpuaQ6q9JFkGi7SDMcepfkSK8TOZn?=
 =?us-ascii?Q?n9geVGNRy5f03hKlPQYrW6611MfiaTxe82FvQuYBzy42G19m2lwyNeMQKSNT?=
 =?us-ascii?Q?/fcbgMhCESMqbS2CqDEvXQbwNEfFdjsasSyOjgqE+4yfj5LtqjOpxWbGhwsN?=
 =?us-ascii?Q?LY/9e5Zm4NkeYhPRI/MO4vECTAaepBgKA4hpozn4R1Dma6q/N2Pr61kEmUcX?=
 =?us-ascii?Q?xTF97EXRZKcb0f5kIEgmofk24miRmH6B2gmj/R/6h2wBlMEbYOOgQ4iilLUz?=
 =?us-ascii?Q?O149v8EcYS9KxvP27AWel0I5hv9Rshsj5BRALxqrzO7+TkW2ftu7PkD3ARiS?=
 =?us-ascii?Q?VY76LPBknP3kBrhR+yHDB51DScuXV4tiFFgpA+U/ZRuiTW9ln/SrubzaEnX4?=
 =?us-ascii?Q?gvmv2ENgBhp/oxB4OcgoPCtRRPB3b/b7LIgqLTFDSgtIY45ehYY8samNz3U3?=
 =?us-ascii?Q?AXmH3p+4loynvBe5o4SAM4IszwurvRVg3Ps044nBlSOZDhqjwFvvWWMt0TWr?=
 =?us-ascii?Q?Gv6yP9gr9roVnZEsFON8ZWizMFFZw338rh+IuUDT9rjyBb494tzRE0PVKNRL?=
 =?us-ascii?Q?87JlMl4lV74ApH/CHWLEQn7PkjBdFUpXG8x80JMNp67vWyd4M+l21j7jq7ur?=
 =?us-ascii?Q?ZRqfBh169XPkx3LrpPAftRaB/Q4KTbr9WiRGuYFnTc3ZXz0/ZcUiLznphga+?=
 =?us-ascii?Q?Sb79Mnqskg52JGFRg1B5iJbe+OR7Mawt9ziNZgJh+GXX8QwSewPAbLQErI83?=
 =?us-ascii?Q?zLA6UX5Ksmd6FMN+as5iGpnAnw8mn/OoIb2agzmPR2zqOIx8IZN7QRixVEfJ?=
 =?us-ascii?Q?d5kQTQwOHloOItetRVMBPW6e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFGFlQN38Tf9r/mxhbe6RSkypP0LFnE5O8RwuIjk5xMJ7W9nKMyizyD7IjJz?=
 =?us-ascii?Q?vvkYr+RnCo6GqkFBNKIaYTHKi92Npzr9I2MpzUcI9RE12VgtcxsnHRyPL+kU?=
 =?us-ascii?Q?36/KwCSJNlikulbc1X8vx67dXODaePC7uHoQoFx/CzV6e+zkZSP9qzFzCzzM?=
 =?us-ascii?Q?Tlzlc6mr9N//eZ1iaNGmdqiz2FvOs/s//PopGENPElTryM1d+pCwkUv0pMr/?=
 =?us-ascii?Q?asMB/hEzmyZXIbruLU5HM9sr59THwBGixHcjlQj96l9ysJhgmUy6/jCCDJxF?=
 =?us-ascii?Q?EskqrIkzL2RgOS/BKQjz5Ysrs0GX4LxsAEt11IQ4yw6wRzczveQijCkGucnf?=
 =?us-ascii?Q?oJxA1VmWQR9+u3GHluDlu2AoNUXG/ev6vheCu723zujuXdvvRsQlekTVk2Fu?=
 =?us-ascii?Q?/UWCuks0O5rhiwIdbZH+LLMOAl1CQiGIQ8i8xWf5Wu05j/YC+psGCPpKUaMF?=
 =?us-ascii?Q?gp3uVDM0K2WVgAdeZaRzwsWGFBQytEXiXlMQiO0fuuKlyOanrVKvjNBrT8Px?=
 =?us-ascii?Q?JQ439Lx5od94f/bcfBIoVo3UbCwOxoAYyzenbdVNPz8BdqjHvqjNHWTDgkNS?=
 =?us-ascii?Q?/iOE0PVlGbgMID+UmDhitsT26iKXdLG0+6jCUz8DHkOvmjipWUOGKAGbh8ev?=
 =?us-ascii?Q?BZGY1bDLdv+RocEC5RmZIkcOobhGD0wbOOnxgb5Q52Y3Nva8Yp4lMnRApDWc?=
 =?us-ascii?Q?WqdJGnXgX4w7XTZ9E5JI1NFNPRN+vC3tRc2rbED5UUjgx2xj/iURJtlAh/BA?=
 =?us-ascii?Q?SLLVy7edKVfmasqbJnTiGW9yxqhRI3vUGT+o7jIYCbn7RuVWTmftAuwjYeqs?=
 =?us-ascii?Q?vN8gETIUVLjL0Hh3VFAqJJvbsQuRfR9xfwpH0qJHUuu4Ct8Vr+YcoiOLcmb2?=
 =?us-ascii?Q?9WVW39nzUhYG6x1wb6vfI170pT9Jt6FN+pEvuTQR2fHppCtlsHkJuOIbQG9V?=
 =?us-ascii?Q?JINR17X+2tkTysAQZt2nm/jO3CuznEaLUR1Zbl4ywg6Mlj/GM6saG64GvYqf?=
 =?us-ascii?Q?mCudNLBssL/2XntVf/d+IB83c/hDkZPPMqLHZZZUZGCPLQnTJjdnu7r4UWI0?=
 =?us-ascii?Q?4ziUGsZCDBBtvj+mGIpB512ZDN77gu6fTiaRic2M6cF9m3VwMmnOlVn9wVFZ?=
 =?us-ascii?Q?YNw6IYdqTkGbD9SADehWCIbyHNiVMYdWpK22G7NJZKvysANVXAKNAF5/b+kJ?=
 =?us-ascii?Q?rDB99PBbUgeqBt84jyYNeUl3aw2KRHxNj2NcVoie33mDD6C1M0AIKJdtCV16?=
 =?us-ascii?Q?YC6rnEQC31qEhhG8AL/wyFpKiqoPv/Rh2IFzIluorU5s2Wkczf4hCtil3bWB?=
 =?us-ascii?Q?8upHWjTbI5gvGP7pXEbqiGeRnjALrl20/X5f31UJ/Ke318p4GEXgzT7IQ6On?=
 =?us-ascii?Q?e8jspP0l0fvDonmQOK9mil5NcecDqT4XDyu5NXPO2L1lHhnxbNUkZc3HJGPJ?=
 =?us-ascii?Q?fx2/dqbhH4RBLi/KEcgQvXp6XSuvaEV2G53EjHcdGrDH8dLSUPXedwU47+G4?=
 =?us-ascii?Q?2/OsG8E6FxnIToY9AB4mkvziTEe+STIBL91S5FHdrZYg7KPxhocUPkYW6Xnw?=
 =?us-ascii?Q?akZSQ/XisFX0dIzoHiSQvL+X49aSEfRC5bihdxbm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22f114a-a6d3-468e-2648-08dcf47c668d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 22:37:11.4563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Opl654xOdLFVONVG89Kahpk9EqJ0OVmQeSLowcVHI7j8ocTGnNYtXLemnD2r+VWz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828

On 24 Oct 2024, at 0:10, Hugh Dickins wrote:

> Recent changes are putting more pressure on THP deferred split queues:
> under load revealing long-standing races, causing list_del corruptions,
> "Bad page state"s and worse (I keep BUGs in both of those, so usually
> don't get to see how badly they end up without).  The relevant recent
> changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
> improved swap allocation, and underused THP splitting.
>
> The new unlocked list_del_init() in deferred_split_scan() is buggy.
> I gave bad advice, it looks plausible since that's a local on-stack
> list, but the fact is that it can race with a third party freeing or
> migrating the preceding folio (properly unqueueing it with refcount 0
> while holding split_queue_lock), thereby corrupting the list linkage.
>
> The obvious answer would be to take split_queue_lock there: but it has
> a long history of contention, so I'm reluctant to add to that. Instead,
> make sure that there is always one safe (raised refcount) folio before,
> by delaying its folio_put().  (And of course I was wrong to suggest
> updating split_queue_len without the lock: leave that until the splice.)

I feel like this is not the right approach, since it breaks the existing
condition of changing folio->_deferred_list, namely taking
ds_queue->split_queue_lock for serialization. The contention might not be
as high as you think, since if a folio were split, the split_queue_lock
needed to be taken during split anyway. So the worse case is the same
as all folios are split. Do you see significant perf degradation due to
taking the lock when doing list_del_init()?

I am afraid if we take this route, we might hit hard-to-debug bugs
in the future when someone touches the code.

Thanks.

>
> And remove two over-eager partially_mapped checks, restoring those tests
> to how they were before: if uncharge_folio() or free_tail_page_prepare()
> finds _deferred_list non-empty, it's in trouble whether or not that folio
> is partially_mapped (and the flag was already cleared in the latter case).
>
> Fixes: dafff3f4c850 ("mm: split underused THPs")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/huge_memory.c | 21 +++++++++++++++++----
>  mm/memcontrol.c  |  3 +--
>  mm/page_alloc.c  |  5 ++---
>  3 files changed, 20 insertions(+), 9 deletions(-)

Best Regards,
Yan, Zi

