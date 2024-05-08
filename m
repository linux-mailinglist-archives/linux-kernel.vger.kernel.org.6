Return-Path: <linux-kernel+bounces-173535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204438C01E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5F7286C17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959F12881C;
	Wed,  8 May 2024 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZQz6z7hT"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05346D1B0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185339; cv=fail; b=C4GkvmzfT3nkN+J8dAyFFyjrz0gUY0f2tOlqFTgAm1tpbrQzJN5mapw7fnouIMDoGcBRZpuMQLaFVZxO9UuB73cx97P0Aal6TNKiT0N6yv6TJXU9NxFCCTV4IvQp+6kanrtCa5X2uDGoxAL33ka/7ivYn8fujlJcRx+uv8aJHtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185339; c=relaxed/simple;
	bh=Oixgou2hwi+V47smeMCVZdN24Ehi9m8XyA1sbz/L7Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=txuYR46MpGAJMfiTyLUMB1TRYaDrFLoq0IfWTxFwvZaaERoWknXU9D0RD/9di7SBKER0ZyMOvjWNmUYxVGKiRy0FMresIf/6oat8Emn44pqSLl9hJ7TZEZDVC0YIxLSejyFoWieSBZIoRCxiV8Q09eCNBOfoZNSl5dspmrbmlqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZQz6z7hT; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSatZTgwUg8oWYTSjk6Y6zgmfHEpbD9yVXbwYpvYnO6uyyUFCZyzMUn4TnDAsq/KU9MUcV88D6YroZPild7pQV0KMe8KJ3Ikz3Fvln/VlwO0KwYHgsuaahIh0GAjQZNErzNEP0lMPnqcTzf+6LyqGQ57AhG3lgmdhR6UJO7Mvs+Oyzpi1hAjUr/XXz9NfvWyu472diN04I8nn8JY3vBzE6rQW29sqArtchslQKQbOmAKg6vYoIZDRjM/JCL+B4Gys3RDiFpsRW7AgDi4lvR4WL+tIL1lEh7t5TBWXBtVcAwBFAEG833w0gwEaH8SRzEHI6R+BgCMx1wICxg71gmImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oixgou2hwi+V47smeMCVZdN24Ehi9m8XyA1sbz/L7Io=;
 b=DLMIG/DGxVkVFcFD9Id7eNTd5HRqQqyqEv0qlZ4Go/CEJ0G39YWT/SkAwfoTwLRw12XjtWs/LC2Bab3euNFNE70/40fPPsSQXVVDHYcAEGFI7nGyqzypnXTu889jqyF0Li8kAd/m5q1xA0L+2SEFz6I3v9NwfSyexNV5ymseRbkrKkKekg0E1ZIvBUoT/lCkziBnkbvX+PkWLlJE3sr413olEndvquQspG7cJ5r1e9rVZUXLKMAaD0pzdBXSDICCmpTQ6x1U2UuseO1A9hvlGdL5ldbBbuAq+vUMROxp01h8hrDhg7bfAVjH7TdwkfmMs/vX+PUGz3EpBqw5e1EKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oixgou2hwi+V47smeMCVZdN24Ehi9m8XyA1sbz/L7Io=;
 b=ZQz6z7hTkLhIsbzeHb07a9dpLJoS9s/TN57ehPJPc+rOUinPlRSIUd+sG/oEiUAZq2SEOKsYYYGH44oA3fjGFkRhiQp/u7Tg9fdPEUsQmoGGe/jRMlNo19quLc1LkbpYZ13+z9lk9QL3RK8B07h9/dINeHzL5zWdEgORYaGLtOZP+ZyfV2FiV1AnLVc2VP/2uOwVhEU+r6MJs1uNNqu0mwG4Mj4m5xM45e7n+JmgfYdquJCVE4fi2R0wW1M4J6IRxFTpOMuVwjOp2w9K3IlzLL8kW8VHe8rHX/3oYrW+MbuIahEO25ZuwoyyxFD0ktglw3skiJDEZoS+SWG67WPNhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Wed, 8 May 2024 16:22:12 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 16:22:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lance Yang <ioworker0@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 maskray@google.com, ryan.roberts@arm.com, david@redhat.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
Date: Wed, 08 May 2024 12:22:08 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <30469615-2DDC-467E-A810-5EE8E1CFCB43@nvidia.com>
In-Reply-To: <20240508155253.GK4650@nvidia.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-3-ioworker0@gmail.com>
 <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com>
 <CAK1f24mRVam3w9CZkq4O0smGUTVUQfdvA48mqsU+NKxMUxdz1A@mail.gmail.com>
 <B1DA2DA4-AFEA-4541-8DFC-0D815249A064@nvidia.com>
 <CAK1f24mpt+ZGow4LLdXKZcwopmkZDrM_eh15SnkEgpiBXTmOwA@mail.gmail.com>
 <10BA9EED-A2BB-44C2-B80A-26527CDFFA50@nvidia.com>
 <1B2017A4-A252-4C1F-9608-D43ECEAD53B1@nvidia.com>
 <20240508155253.GK4650@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_4B9AA9E3-1544-402F-88E0-F46055751397_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0050.namprd20.prod.outlook.com
 (2603:10b6:208:235::19) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd65404-8b2d-44ce-ee69-08dc6f7b03e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xEhYJDa26K/f8vGMxRNke9cZ2ETUZqzYeklFwTM3amlOHEoalOzLO0SOzG1a?=
 =?us-ascii?Q?AApsOLBTZvLNfXO00ovbI1NdatdfnCU1HXMCNzjhs3V7T4KuCFVpGwvtM3l/?=
 =?us-ascii?Q?DUS0RtdqCtwJc48QeFeWqzOPJLg0zMy7SUGjA4iGJS9VQQV5Bjkpp+d2Qm94?=
 =?us-ascii?Q?+f3yN4sbfh2HJQRYrDWbVDYXTvUFY18ZPS/0melMym3/R+3t8Bg6LtqRhhfK?=
 =?us-ascii?Q?DjFjNEvw/6hhGJ436ag0hJn0qpeon/CIWrmQ/uOQtwdozYK13n8B9MufEaNy?=
 =?us-ascii?Q?H3xZaneWnuxIBkbKALox5NUzz7/rVxhuKDHieOCeqbuWVe7vAM8BTGswJt9q?=
 =?us-ascii?Q?x/b4T3woCqgyku/J7RR2tiPmw5UZWj92M68z0xeeJe9A5AfCJ0puY89SvdSW?=
 =?us-ascii?Q?/eVhGprnfWnG9Cg9gcqWtSqiuo8KEDAkkSDCsZNSq8YQi0/Tae1zZagev+wQ?=
 =?us-ascii?Q?VigczQa2neLs7Ey7qVIBU4vscEN3kboYXUA0VVN9wdFBXeqUD0mFHvUdS9rF?=
 =?us-ascii?Q?d2+ux+1+KhfTLrV67BAqZSfz7H6v5kiMfhDVEPaTNLHJvkzRXzrO1D77Cgbb?=
 =?us-ascii?Q?7M3VfL/UjjDLBq6feg656RHGTpzY55GnR9bCAL4e6OVLfJMZmaSm40kG+EZj?=
 =?us-ascii?Q?S6PDCNVmpPSWRVomTdvPiIStvZ7VjmfITj+vghzHbpkktdzHb7/xocWSTDsY?=
 =?us-ascii?Q?Omhpu31UDPm5Yf1r9VO4udH8RXjdQSySLezs4+R3tFj31OrLgnYhw5Pfvme3?=
 =?us-ascii?Q?lEB9b0uAmCyyOkAez+HZ3wCK9xpIsXMVRYKf3yhbU2v7s5fRji79iGQWrKrt?=
 =?us-ascii?Q?YDnAYCy1yaRPpuiNzJp+j3zQBCXsh46uC2vBhjZzEptT+5rOGiN4Nx5qAO75?=
 =?us-ascii?Q?f14P6IOGPDHLax4Jfj+6nikmdmxj7xRcEBoxPBAGrOITTpahG3ld+32Wvn6j?=
 =?us-ascii?Q?CJoQ8kdtIcgw2qvCmpFbYsOc6WFrG0l5TUN3hfxCn9bP7tlcaQmkGqhrFcRr?=
 =?us-ascii?Q?bRVJFwLIQHcI8pXo+DgqH/nIZvk3U0X+FFtTI+yt0FMFog1WcZw78HQBxrUe?=
 =?us-ascii?Q?LgYaKaDCn34iX6ugArswVNtXfLxgB0/z+GWPa+miHNZvwesLemsNaARex1mZ?=
 =?us-ascii?Q?vPkAT2ArDGLEQIiEy8S3mpIKrHfVrzFDJrrDsqi+8Aeh4j54FkbPX6m16zTl?=
 =?us-ascii?Q?WLAuMvyORIuHNQJYERZSb/InTnzJaTIeDuF+dKnnikvcAVm88UNIDkUuQYh0?=
 =?us-ascii?Q?yE8TyAa1nzi2bA05o/hk/wOQhlrOSUjVbq1c5L7Z3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oquja3nTjDYeP1NRMZNAWHp3VkyIOimTr8zgmeovniFxsXdVc6lfrDtmgoeM?=
 =?us-ascii?Q?2oPWYnTppkEYF8k6GEE+sJkxuhgd4QtymwU4+CbgeMUygzDywXsJxe2kGBeG?=
 =?us-ascii?Q?GKraXsrhxcL+uEDscZuEzP+qKgKC0oDYsHzMtHF1lKLQyEc8s6imqNltRZ+p?=
 =?us-ascii?Q?R/S7zU5VSsG+B19lEjlbGiB/IBhgxgimLiX8Zc5JxtIIUh3gcE5vcitgjmlD?=
 =?us-ascii?Q?Ai+NhKkmzCtDSNajxa3z9pjM6u8/g6cGpQisrZ3dX7Fo7TdigXA14DYENf0X?=
 =?us-ascii?Q?Xoo40LqchSm8sfdSH/qvwYL6mWY2cGuTRAiO1qguu6nGDIxGVzgp3EyW7YQD?=
 =?us-ascii?Q?9KkZUebk/O+7lp+3aN/ErzvDabmkDaDwrAEO4y13fOe25J/82EQqG8vz6QzY?=
 =?us-ascii?Q?Fc7npPt5lkkAUR8DUfrklFnDcqKBHD58FbHjWsq/IBG3zuOCXL7iw6vQlVAv?=
 =?us-ascii?Q?rx+XoRhigEHs4uU5a8pcE5zfXEpT3Fg8au6Jo5BENjCkZhEjh2ZiOdNgjoWN?=
 =?us-ascii?Q?4TlCBX6x9zLGnKbQDDsUGy9dtN4hhvnb6psZCZcYSuyJzXfTMV1gfGo2wzkt?=
 =?us-ascii?Q?E+ReFlHRMEQwzLveKmdq4r1crRKE6BPvCbOmlqS0XNm7NVidjPfG4H9XlkfA?=
 =?us-ascii?Q?8kleHqie4lXIkHmFp+EDtcj5slU6/x9P/iFkhPDuoXdZ+87fXq1nwdQ8XxII?=
 =?us-ascii?Q?e5Yz05L9RnOs7BODgWSx53FHxXuKikVee8lCagt4P/hrO9S73BJqR654OOiz?=
 =?us-ascii?Q?GNkVH343IwbMOJrZDZVF1UHPi2yeQjRz+d73EulZcR31c7LESOMMQMOHEvtb?=
 =?us-ascii?Q?U/n/iEIWQk3QBQvh2uIgDNGZQHPv05Cf9Uq+CM7lZL6p+T0khENZCmJhdISg?=
 =?us-ascii?Q?pUT9SP9iRf4jAsaugoRYgthvCrj4xRZWQXgAnLYuw8eFTrWdLyACs/sm2YVf?=
 =?us-ascii?Q?HY9HdrO7gx90QRRzP2CY6hZtXHY5ffv/de08aNC1qQrAHKNIMPgf0riTEUZB?=
 =?us-ascii?Q?rBdrfk1pBACCA76RSKn5AXy5FzI6prt/XlexeWngwdnios7SnNDYTPCzIcb6?=
 =?us-ascii?Q?UdpI/xXi2DO4yif55o/vgDbMO3NVwbdvNUDD7Wqvxd4v14sdRGejwTI97zm1?=
 =?us-ascii?Q?KPb2bcm5mFayY5Cz7nMV3wM0b3rUdbZxQEi1KqF6hPNIt3NrYe4KScBqrQUb?=
 =?us-ascii?Q?Cxm6J+w+vWvy75+7rCXHud+mYRDzsaM0X8rzQ3eVSX9OjhKCY06XpbGA16Tv?=
 =?us-ascii?Q?G6uFtrFPjdyBA3LughV+3JKMvUBcYf+mU1UE55YBRKWQIDUVBMiHg1rDts5U?=
 =?us-ascii?Q?vP0QDJ4yONXyw9sUEyYj+NvmZXbjIy5kMSogCl5o6nrOB66M2R5XGSJOHLR+?=
 =?us-ascii?Q?2gekjOJBUkJjKdtYe+hPoegsJxsysUXTdLHGgI8vz6Z5ooBsEkfsr4KltuZw?=
 =?us-ascii?Q?hiGSrNCCWMSRQ1/pP+Jl6fwvcgIvIWRSO1v+SlNVNQOWidJ/ZX8chJGzEUza?=
 =?us-ascii?Q?ZUWBBS8fDdpktfB0eZOpU4wUrqYXhZPawOGpdPJ2c1Yx0FWbZVJrQGAzkUcD?=
 =?us-ascii?Q?myzs9qTVYw6TMryjcQq+4xIRbGp4X8/ggEvEvsal?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd65404-8b2d-44ce-ee69-08dc6f7b03e2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 16:22:11.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJpsVsqm3qVAuwPpwN1PXsFuZfIRNxrL5dPsBJgj2ZTfsUBu//Q1+Y2ElBLbC6yu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385

--=_MailMate_4B9AA9E3-1544-402F-88E0-F46055751397_=
Content-Type: text/plain

On 8 May 2024, at 11:52, Jason Gunthorpe wrote:

> On Wed, May 08, 2024 at 10:56:34AM -0400, Zi Yan wrote:
>
>> Lance is improving try_to_unmap_one() to support unmapping PMD THP as a whole,
>> so he moves split_huge_pmd_address() inside while (page_vma_mapped_walk(&pvmw))
>> and after mmu_notifier_invalidate_range_start() as split_huge_pmd_locked()
>> and does not include the mmu notifier ops inside split_huge_pmd_address().
>> I wonder if that could cause issues, since the mmu_notifier_invalidate_range_start()
>> before the while loop only has range of the original address and
>> split huge pmd can affect the entire PMD address range and these two ranges
>> might not be the same.
>
> That does not sound entirely good..
>
> I suppose it depends on what split does, if the MM page table has the
> same translation before and after split then perhaps no invalidation
> is even necessary.

Before split, it is a PMD mapping to a PMD THP (order-9). After split,
they are 512 PTEs mapping to the same THP. Unless the secondary TLB
does not support PMD mapping and use 512 PTEs instead, it seems to
be an issue from my understanding.

In terms of two mmu_notifier ranges, first is in the split_huge_pmd_address()[1]
and second is in try_to_unmap_one()[2]. When try_to_unmap_one() is unmapping
a subpage in the middle of a PMD THP, the former notifies about the PMD range
change due to one PMD split into 512 PTEs and the latter only needs to notify
about the invalidation of the unmapped PTE. I do not think the latter can
replace the former, although a potential optimization can be that the latter
can be removed as it is included in the range of the former.

Regarding Lance's current code change, is it OK to change mmu_notifier range
after mmu_notifier_invalidate_range_start()? Since in Lance's code, first
mmu_notifier is gone and second, whose range is only about the single PTE,
starts mmu_notifier_invalidate_range_start(), then the code finds that
a PMD needs to be split into 512 PTEs. Would changing the range from PTE
to PMD suffice? Or the code should call mmu_notifier_invalidate_range_start()
with the new PMD range? I am not even sure two start with one end is legit.

[1] https://elixir.bootlin.com/linux/v6.9-rc7/source/mm/huge_memory.c#L2658
[2] https://elixir.bootlin.com/linux/v6.9-rc7/source/mm/rmap.c#L1650

--
Best Regards,
Yan, Zi

--=_MailMate_4B9AA9E3-1544-402F-88E0-F46055751397_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmY7prAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUwJEP/juV2ZebEx7Bo8cgIA4UiWMq7pG/iMExCP2U
8loEtknGwzcx1Qit4aYVLlXpan16egJnOGJFmy8G1702cqlFb3LpoUNNb1xSeGd4
x5zNH4hrKN3xpP00in0cpWl3iYmuW8JTgdkO3BjGoESwH7fRAROy4JiR037epoWP
fumQnKc7GlbZRap1KqbtABM0pCb1+Ajg5B/+feojUJXLSAcGjXs2X2wmjqApvkYX
19E2brS+NjOwxamnQMPWUSOFydIhvnOrc6t5bpajJRU0qWd85PFjP/Vcp7Gr0O1Z
wJt/bZvlYeaoOd3Rm7WUDdy6JGwMmXdpz3fN9FfFld7/FZZCT8uygBHKWaeE1jHs
tRvN/OVEU7hZU8ghQyxsQtUjwaSArGX6llCs3+piLGsjVZQ9eTxot19Gx/UF98ho
WATzR6GqAIL+1yXC3RDegLAVRv949Ucxx3sh6aJOvd47JmZ7eWaRfkVEgk2YDSY/
nBTizzkciX++1ehyygQ+CQQP7bz7vdNXmO4g72kUw1KPdm+YgZ5JmwOyHBp1izcN
Y0jBlMdRTv8tHuf4i7cYNMymBILqwNv+lHnKJ2goX/BVMIosMcoAnk+WW7GpNSVM
jtCTE9Zco+m4jWJZ+y2L82r2WuUAjaB1lRpegraaw1oQrTDr0YTtqWyC7IOzRkIl
3CZmqGRN
=w7YB
-----END PGP SIGNATURE-----

--=_MailMate_4B9AA9E3-1544-402F-88E0-F46055751397_=--

