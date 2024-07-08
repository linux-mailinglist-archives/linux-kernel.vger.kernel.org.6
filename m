Return-Path: <linux-kernel+bounces-244472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28D792A4A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEA928210A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302FB13D8A3;
	Mon,  8 Jul 2024 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A7I7J3Ez"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618F13D887
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448930; cv=fail; b=j0OsJV6yEm14CkqlQ1v9LmzTAc6w0otCV2n/Tun/t3aZEnpS17fAMX6yOL11jMMpzwSzq6kWFRg+FUBBndhky1zcNOpPQlt3mXvuM5htYB4UBLqVsWOs77ZxmLMdQZU+gQNTR10VC+ZqtwX4XKN/zKxl7n5HGORQc7lUV+B0psw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448930; c=relaxed/simple;
	bh=QtdaQ2UrmwCo2O1v8DrCW/NivQul+LGj0dZ0iDlgsXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TluYc44xQJgNUuBSlNMZKgN2UP3K0lBGlxuSh7rlcHSA7obcGMeJ6m0LEpWTj6WGaxEx6Saxl92aosZGLCWuAF2ehwzySOIoYHlMnMJWU5OdVgpBXmrW/4E63RnQYNHPoHJXytOJtQZi7S8slkSU/nUW8sjUp5xjxQkI9Kc5TAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A7I7J3Ez; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btYVD7Sdf4+OJecfd6gwsmxwhaqNF6N0eoDDZb1elsrDxQ6/zz/FkQ3BldIqr3/PqEb6oNQEYQnT4bI9x0IXvXXRGrK2+cOsoSTJjyyvRkY8q+4lPiDRltCSPRgKRYr/LR/EnYOAUWdas3vZue+3Uv1vQriH/0V+tI+kKctxNGrRUmZWoly5LW4MHaqNYgiG0zfpzRRYFazocrLqYSX6MC8tAVs7fec0FlAzaGCadki7hMgKmkZtz/UnplWCzQxga4/whwYQ/Kjkn4WCVyKzaJby4By5PqsgcxcwYKJgHpm+g+Z1bbP2wDvVyIwY53a83gHWAQw/u8PSc8Yid2LoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtdaQ2UrmwCo2O1v8DrCW/NivQul+LGj0dZ0iDlgsXg=;
 b=VN58PdmIS0qCvvTNxCvElgU2WhxsAG3YGq9Z1uGkkXxYy6lXfPwsThECBS3W6+3TnPzOnwHVFaKP1UxNvu4pgzmrzNd4siVOlS2Vh56rWHIlS8EfwlQYTI2vBIA8VU6l0K5OAd24j325lo7v5fr0s9acFVTiCsWeBHZmHyDNSScNjJxFdvsROdUMkjnzbe9AJIJz1NZP+pX2slOdSS21Q7UdpsCNS9Ay3y3RSsXHjkW008bmXBY3yvZbz3EEh0onMf4Vhf/mMOg16OQNhHDrvT2+ArtQmNv3gnjFNjnbUV11xVau+ZlDJqvIwOK6MQ1wiRDLNGcMddbNYlpgazsM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtdaQ2UrmwCo2O1v8DrCW/NivQul+LGj0dZ0iDlgsXg=;
 b=A7I7J3EzyO0SRp6VsEeRb5BgzP8u5ansDfxt7WqmVd6aZCdHZQsAVqjxW0BNM44gqnxYN/xoPaZUlTXyQ7wkmSXK2rCq6AmSc8BIvWPqs5GQxKXhN7MUKa2/x/nIbxmTIOKwvdDAQdGly7P9HU8nB/T6hGaZh3xBAVmOC+yUe0hkLzrVoMXTYL3FHr3DgKL/UvCR5rJyI0rRD4VfImQGeHXIXFgFnFDP9LI58W1hd8gAXgxpWkj8JQoXNsJPf/jiz2pK8pQ5/7vNMvW9crvXHfyrrFAzhgM+6FD18nM6Kncq9lEneBryaCVmhEmfuU9ACFsdwO1Ep9kVB52MrpC0Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 14:28:45 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 14:28:45 +0000
Date: Mon, 8 Jul 2024 11:28:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 00/45] hugetlb pagewalk unification
Message-ID: <20240708142843.GC14004@nvidia.com>
References: <20240704043132.28501-1-osalvador@suse.de>
 <617169bc-e18c-40fa-be3a-99c118a6d7fe@redhat.com>
 <Zoax9nwi5qmgTQR4@x1n>
 <84d4e799-90da-487e-adba-6174096283b5@redhat.com>
 <Zoug1swoTOqNUPJo@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zoug1swoTOqNUPJo@localhost.localdomain>
X-ClientProxiedBy: BL1PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::32) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: f3007fb4-0c39-4d37-9dd3-08dc9f5a4621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?22EZGwlAU3YMmE3RNN+cSttEpInUV9ltPB86GWbXAfduE00yPN3G7CqoXOZB?=
 =?us-ascii?Q?cBLlvtX1GZim5nHbGFT1qUc4J3MLST70SKRB5SuVEwuq28e2CpzwGg7iBsCv?=
 =?us-ascii?Q?/JpRlqgn+wVFmINwWJ9Fkco13iI9ndHjZ4VcZfkO2rzqVMMBGyYuXPH6lr5z?=
 =?us-ascii?Q?gteKdf0PuR2+9JH7qgFkNiYsSvAfblJX27rCFEx1HCNlVo7z5HmuY3/qI3BX?=
 =?us-ascii?Q?DyT2EDZGUkcKGmj8dxiwFra+7Mu1QzW6CcTfpdJWyVI1tQ7KiXBmopYSl9bV?=
 =?us-ascii?Q?u8yAwTjz8RuX3Z7h1YO8ERo4woEPtWY8nuda4VUoII5fd+1reiW+nMuU5OLt?=
 =?us-ascii?Q?oU58oPpbrDXipE9FJ2THjnMYWsiaslCbj02tM0nlDPA3XdesQqP3I3MlksiO?=
 =?us-ascii?Q?o7BJIpndyUp58PQxJsTir3wUCCUN4bXJR78A38ErHB8kzx46Ik8u3lQbF14+?=
 =?us-ascii?Q?pYzqQt1EsNwjx5AdLWynQ13hFCLT9wfuZSESHF3uTVj4NAY7j1z2sdzC2O/h?=
 =?us-ascii?Q?vFy1tyZy5JlUSYE5Q6lzkoYwoWd14EdmH9Ys6iRuihh3xOHrh/GjD2cmbTHr?=
 =?us-ascii?Q?qU/740I+MgslRrGYZozkMoPNErTMMq1xL+nCikbR35ui0BqnsKl7hhWJ+9Lo?=
 =?us-ascii?Q?LwQ51jn41jJS3ENXP+CNggb0nifsi+w/2OH7mui644DpxtpF3eyUxouRRam+?=
 =?us-ascii?Q?yhvUreXloy0R5uCndYC0/lFc/CY+GMKVs+igdd20ZveqA0vInmhK+p2jeP1Y?=
 =?us-ascii?Q?ibfQn2VHpWwCQ54Cbg3csU19wjsqN+DWRZrCwI6omB+f/7s5HJsN8uotpiZJ?=
 =?us-ascii?Q?yLwyWLozubqFD4MIiLPmB+Q/Ufe+6/L2iGpjYaSlp/cDR1XcScu3P9+M3B8s?=
 =?us-ascii?Q?lnuoy+Bjo3CpFQPJVNaF3rfCOdPm2fXUz8ZhqYPG9JzWBkvb2FATDcpKNcWo?=
 =?us-ascii?Q?wAYA5sWltUvrzUsvEXilBv8xN4fdwdGyIacP3N3VR9ktoTd6ExrJOBB+hzGn?=
 =?us-ascii?Q?aSkkIGeYABQDNukWCFdlY72CarqONeyq5whQG/3myJEaDfmfc6WD9zIN4Tfs?=
 =?us-ascii?Q?FunLjPoeyZ3rOazmK6WrzF01LO/W/3AEfSX0NLvL9TVB1y1h50CJ40Ufosl5?=
 =?us-ascii?Q?+PGl4TvhJoP9nuHs8unSLGnEhQeX76QwsRUwgf+kDS21+D2hBO3q4kaNR0NU?=
 =?us-ascii?Q?oE7hMQcvcAZJdPudzs2gEjAeghWrqUxUu4OMJtYBE47FIBz8BiU/REu5VVHS?=
 =?us-ascii?Q?HwhsNa1Kd/nYXuTMtkpc2Z5EcjbsWb76ZH2rZG/kwWG9pWLmKye2SThy2cDn?=
 =?us-ascii?Q?jG98Ru0eadf349PNgCl4+DWJF51rgGEQhHUv3472GSDfKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t3t80pcGWJoqe8uCiDY2gqLhtamm4EHnEg4xNbMZopnqjYDNyazhhuJAdK+8?=
 =?us-ascii?Q?G8KubRoM8wmXbKHhny0owndoejnGH3pO6C5KALFB3gJX4sb4ChhEzCGa405z?=
 =?us-ascii?Q?eooQwaxuzF4fTFu8uwH0V16PBU9cOOSGvLrCbj1ANsXvMJ4qLeqcTSrK7/Qv?=
 =?us-ascii?Q?g37Topd4qGONTjJjwsoA1sE0BlZ32sj/if/ZzQdANUWxrr33cjM/X0cT41CK?=
 =?us-ascii?Q?Eoto8JqJtW0pHqNS3jlMpWrAaqHEDPr3VqHYYXz/6twA3l/Mnr41vwfeF2Ju?=
 =?us-ascii?Q?EfrapRgsiZpXlpN+1q+vi6tve3YHTfIUL0X6VzlMFowqNfVvfhofEqAOWRPZ?=
 =?us-ascii?Q?QkJHMPCKMDLjvYK6JYbHeEuUYrBL6K4rHmtr00ecHk4yC4OcnoAihlo8JtPr?=
 =?us-ascii?Q?4t8wvKQJCSK1Ny17UflLWC4/JoIqVggO3fzM+5KgjO4uOBUWSyGa43ZWg+CK?=
 =?us-ascii?Q?+/jxCO7v1X6qQ1bmxppjKwKxXmEhNn0oCDsQIRW94emtD/ySlOUrI1GcTKdx?=
 =?us-ascii?Q?8qO6x5p8cA0Zjwk2kD/EJhLW6CP/vFbZcgADhHIT0fCbG0rfNKCwcO2R6amx?=
 =?us-ascii?Q?r/IAibhEsrwXiRwmIstHsepgLXnb7bAyTSpV7lna3dO0OjbmDNpfek8eU06n?=
 =?us-ascii?Q?PMRkcbAOg+t63YVh8CazVLC6IIjGcqEVCGoCD3VIY+ieldgR0FPfVBG5Cxq/?=
 =?us-ascii?Q?uFVvCA10nvmuyc275ddY3z+1H/dWixfDtMA1ZcTVaOYClv6M9S6JneSOUOHI?=
 =?us-ascii?Q?pTj+6faq+IlbH+6m8n60Y1Ek8l0/Mu0M8tQSHhlB8YRHWqkODv1T95AWYVwA?=
 =?us-ascii?Q?3PGT796SRb61QT8FWv3vLAWdphxxQgQ8U2NP7VSu0elwpygi7xXsQOn1ceTd?=
 =?us-ascii?Q?qa6yoiHomeHGzsRg7GWrqW28OwtrgrR5dVGEZ6HN3JbZdWyFFqpKgt5TC5Zg?=
 =?us-ascii?Q?s9rYdyKG/tBbBQpmTIbxVnjcGqoUvTEnWUyH54SrgnvF0rkQyiGxjv7D6+p0?=
 =?us-ascii?Q?4ZxvPDztA+gl/ELs5P3H4QPYpHbhzG2SgWL6ejpQIaqAXaQMdj4+tkxyGn8Z?=
 =?us-ascii?Q?qM+F81MvM4choX0H7SQgMNXzUfldp9DpEYI26BH32NcYp6/ZVfFkd5RtgOYm?=
 =?us-ascii?Q?jWbEBrCEeYLzLlnb9+3U5Z/xB15lAbdaByWOFKuYEx5YQJJ/wMjry5PRXhm4?=
 =?us-ascii?Q?kMpyYZgriEpGPqwpxEBaIycBZD+CuDIAr5+OBDW86iKzoeWVdYwF3+2NU7sI?=
 =?us-ascii?Q?Ocf/iPfC+3BQa22lhMavaj2f5g7ste+FlsNrVSe6AyqvKb3LQB07oMEFt9ED?=
 =?us-ascii?Q?zNLrhmlh2tgcIGvQR+i6ZkrRMt9/DC3Mjg4jRGgfSXNfU9KN33MVD2tgmk6T?=
 =?us-ascii?Q?PwiwNe2D8UzKrxDaZE7FcNa3MgyAuUy+yg9OwlgswiIXUx6O9QCEO7la9wJ+?=
 =?us-ascii?Q?svotXhhhJhvW6ffmjsWm0weisFIikMlEX1BtvYDBGnTHvtxJmi3B9IsuO7XC?=
 =?us-ascii?Q?i2FPIGg9IUDIinP3Ty/pYOtRJI1YOaEPsTc2XTBxAUtf8Ssj0ku0eubm0goM?=
 =?us-ascii?Q?cNAQoA3yvVMZYE4P/mBfg9vhHz4wMIO+l3h/IFmz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3007fb4-0c39-4d37-9dd3-08dc9f5a4621
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:28:45.3553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq97WJhX5vkIh9tCUm8AhSi3LcMvi69dcTapxA56ZTalzRiow8yhtgXC3lLDdg9O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183

On Mon, Jul 08, 2024 at 10:18:30AM +0200, Oscar Salvador wrote:

> IMHO, that was a mistake to start with, but I was not around when it was
> introduced and maybe there were good reasons to deal with that the way
> it is done.

It is a trade off, either you have to write out a lot of duplicated
code for every level or you have this sort of level agnostic design.

> But, the thing is that my ultimate goal, is for hugetlb code to be able
> to deal with PUD/PMD (pte and cont-pte is already dealt with) just like
> mm core does for THP (PUD is not supported by THP, but you get me), and
> that is not that difficult to do, as this patchset tries to prove.

IMHO we need to get to an API that can understand everything in a page
table. Having two APIs that are both disjoint is the problematic bit.

Improving the pud/pmd/etc API is a good direction

Nobody has explored it, but generalizing to a 'non-level' API could
also be a direction. 'non-level' means it works more like the huge API
where the level is not part of the function names but somehow the
level is encoded by the values/state/something.

This is appealing for things like page_walk where we have all these
per-level ops which are kind of pointless code duplication.

I've been doing some experiments on the iommu page table side on both
these directions and so far I haven't come to something that is really
great :\

> Of course, for hugetlb to gain the hability to operate on PUD/PMD, this
> means we need to add a fairly amount of code. e.g: for operating
> hugepages on PUD level, code for markers on PUD/PMD level for
> uffd/poison stuff (only dealt
> on pmd/pte atm AFAIK), swap functions for PUD (is_swap_pud for PUD), etc.
> Basically, almost all we did for PMD-* stuff we need it for PUD as well,
> and that will be around when THP gains support for PUD if it ever does
> (I guess that in a few years if memory capacity keeps increasing).

Right, this is the general pain of the mm's design is we have to
duplicate so much stuff N-wise for each level, even though in alot of
cases it isn't different for each level.

> I will keep working on this patchset not because of pagewalk savings,
> but because I think it will help us in have hugetlb more mm-core ready,
> since the current pagewalk has to test that a hugetlb page can be
> properly read on PUD/PMD/PTE level no matter what: uffd for hugetlb on PUD/PMD,
> hwpoison entries for swp on PUD/PMD, pud invalidating, etc.

Right, it would be nice if the page walk ops didn't have to touch huge
stuff at all. pagewalk ops, as they are today, should just work with
pud/pmd/pte normal functions in all cases.

Jason

