Return-Path: <linux-kernel+bounces-173512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A55E8C0179
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0603F28A250
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D3128365;
	Wed,  8 May 2024 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJ4UJIW+"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61ED86651
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183580; cv=fail; b=lXcyGPAOtQwTnkMc1EudOvfkKNepZQ8Uu3Kx9hBsTLxGeAyFipA92TC4TSwpQ9v2pu6h9r1nPWcahM+mquwlWlm6Me2s1CaYfPp3+XMLZbrhinxuVmuaUAT/68P5gcWFSoQKC5modASUjUoUBBEbhRg5GvvyyrhypxIvt6MrsHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183580; c=relaxed/simple;
	bh=D2xAYXCoa5ns7isFX+YKQ/rzqP5kES9fAzBfASLWs0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GL0FiL0fTnKZvTaOwi5zgrCjmBJka/rhsdf9PUNH4Ts9EK24Pgf62iXhlxhCOZU/0Hyt6Yu2R3N/9BWE4Ay8PkW9euGL+CwTHZG1U7We49tNpNwH3HEB3AV9mib+tgduVzKueSNpvEHKpWWSroVbyq6U/1hPsWISJ968Ca4jHkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bJ4UJIW+; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2ULwvCWhJDbNJ/LFhqsv20WwOvZjge3luU+xNYuPTLN0tRe6IVdlZ8a48hzAM//ae7SlKH6V7fuXvClVq/vz9BTa0gzbbnZrrYnUnbHrdqnMIxKbJEjovBKrEczelGHi3THScUIn7b5oSVTyWnrweeA1KU6yZ2pvAB1/2j12FEZFB5CjE6YbInhNycn/gDlInjktjU76xf+32J71g+H/RVn8aUC3kbgQzC1laF2lWS/CDbDFFlW7es9dyVtW2hVVSBj/r4IEOe1oHsfTDCEM6aiISOtRDeWP/ohc2CGTL6/a2PgkWE4W3mJRg/ziBHSrT5NHrLJvrYy/q40NxUoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9pcefZewD7EhQ4E0DRAyrFINVA87z9scIOk6YVMslo=;
 b=V5YpJ5zHpsAHCxvrqnB3MeFnXwKe3eqLCKhUQxJkD3b2uRiZd1vRRxlv8JWXPwkLlY3rAh4TBTErT/kg+GAbviwijtUeOi286a89pr3qQn+ixJLHVAOljN5noBUMfB/ia+VlkPQs5lL6SRNpBwYqmdpbBm4XaChleQZpSMGjxvZpeR+YSne3ccGAWzWA9NEAuGHz4b8uEXqZAXxj3GMcwMzwVf4dnn6Kq/hlVHQ1uwIf6s6KM59/WOhWLp3u6328FEOuOd4w6YVe4LFQRqtIKg6ndpf2qExFN0Bkjn5WlW7WOKANn26sV7LJhAMqMqgK9Ypg4dbxbyiQO5VKsASEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9pcefZewD7EhQ4E0DRAyrFINVA87z9scIOk6YVMslo=;
 b=bJ4UJIW+CAC1glPT/b2pCCRDPahIzEU8cX836Ipoh9Y0Qha1ZDIxusNJy73EFS+le26CAJ3LtXArHOHzkEAMKld5ktbOw9J3ZyxI88OJ8RafNJgb4nPqB+ZMpuJns2lOLdkkeVAQOyGNAr7S7nnKdfmXeT8qdUoV4JB17mtC5gaRLw6X5JTWwkUofeVaX3guwlmK6f3EX3qd/qxAAnal1Lrc868ClrHPpXAy8kCqv83QQizcyNgFMqoks5oB9eaLqhl2Kjg37J1/AMGlQ6689W996lEp3U7C0+BQdBcqLCqgy2SDtkCiPMia1s9mu09UoT0pTlFOVARjY8brkrVU+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 15:52:55 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 15:52:54 +0000
Date: Wed, 8 May 2024 12:52:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Lance Yang <ioworker0@gmail.com>, Alistair Popple <apopple@nvidia.com>,
	akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
	maskray@google.com, ryan.roberts@arm.com, david@redhat.com,
	21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
	zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
	libang.li@antgroup.com, wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting
 into pagewalk loop
Message-ID: <20240508155253.GK4650@nvidia.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-3-ioworker0@gmail.com>
 <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com>
 <CAK1f24mRVam3w9CZkq4O0smGUTVUQfdvA48mqsU+NKxMUxdz1A@mail.gmail.com>
 <B1DA2DA4-AFEA-4541-8DFC-0D815249A064@nvidia.com>
 <CAK1f24mpt+ZGow4LLdXKZcwopmkZDrM_eh15SnkEgpiBXTmOwA@mail.gmail.com>
 <10BA9EED-A2BB-44C2-B80A-26527CDFFA50@nvidia.com>
 <1B2017A4-A252-4C1F-9608-D43ECEAD53B1@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1B2017A4-A252-4C1F-9608-D43ECEAD53B1@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0063.prod.exchangelabs.com
 (2603:10b6:208:25::40) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: d6042949-d100-4f35-1445-08dc6f76ec90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n+LE5upWk9qmZhM3KcLA6HnKKn2wZs2byLbNkHZkuPSm4ZsMvUATGhuIeM85?=
 =?us-ascii?Q?4dyv0qttPAY+ejtQCvosytQDO+GB5egbVTy2BAdW2btNf8Yszc4u0H8pL22t?=
 =?us-ascii?Q?B3viNJ1ZjmsuaQTpPYIx8tZ+dfWLnNyhqdiTiYXm3UNA+upZww0b6rwTovqr?=
 =?us-ascii?Q?klacHRi5UmlTCX2/AuFGrM7XhERrnnUm911Bfz6G9liaIqAGpkFOtl500I3b?=
 =?us-ascii?Q?A42mWUSp2dXZYSkmh8K2fXLDI3QXy6amFLterApOj+bHIWBKMbyLGD6VXGvk?=
 =?us-ascii?Q?NRQsDc13VWoaSPjPO1Dfvf9ohYqZGn/sORfY9d52YRiLeXRjRaeU5jivSr2g?=
 =?us-ascii?Q?6hZisSuuLtKXgVfCsIcsv2i8CmcnuY2pJaPTu/BlAxYislw7uo/5VcNZYtpo?=
 =?us-ascii?Q?WvwB2Wum3VyyKf/g2t/He2nCItyuTPri67aNSae0ngl9A8vDrmPUpNvT07wz?=
 =?us-ascii?Q?GfZrr+SwaD+Spt2kLoi4GXjxd0DvBtVE4QCh/N/0TUdTdC6aI16LzsOFLMz2?=
 =?us-ascii?Q?BvCsSWJ7/5sSk53uD+zfugtao22//mrnVsMPjYfNY0bjqf8grn0cSnfTQOaH?=
 =?us-ascii?Q?FWloJC88E6z90vO60yAo+8B0D+5T6txyEo61RINZ1il6+njmxCsrsGsDyZ63?=
 =?us-ascii?Q?Gv02kYHZ+wB1eswST9ZydLyGwIV4Uniso0kOs6QxORbrScDULWXNjwD4kHmH?=
 =?us-ascii?Q?DMpiBLP2bQdn9LTQrcEd/06e+Eb8KzdG9DPKC3CFGgaQaWPt10VNAZcxGvom?=
 =?us-ascii?Q?4xTW9d1aG5CCLQklxWyJgdaaSwmKc/tM04shloUbttabAC4ZWDeKhYcQSKul?=
 =?us-ascii?Q?NBxfEkzonVNfyeWYCZHDFn6mz9g4vDmeRqxkqeUUlyIadBcx3HAUy+P2Rkh0?=
 =?us-ascii?Q?MvtILxePKb0h22kp3Y7XChSN7z0WILSH73f2XYr7+A2ip30TZYQTf79AoN3W?=
 =?us-ascii?Q?aP1LGiGus+ZZdadXMKhXF49vDi+8VGIcRzFmn1RVxoKQrIu93ALQ2px97NTB?=
 =?us-ascii?Q?mW+MaDEuMHcuL998AsHH6xnim6nhGDoHOAshjdDr/LGhiNHq7/sYxdDpUJkc?=
 =?us-ascii?Q?HQlpWSG+1oRoSs+xS1sdtP0MJ8KD7957wQr06v/GZLYtDd/1uyAiSAuBAmiE?=
 =?us-ascii?Q?2KkekxlOwIhJAL5MBUcNm66dwhFfmQRbFaygWfra1qlmiaEc88lsP3QvhYv4?=
 =?us-ascii?Q?ITpTGwtqgjQNFBhv9HhhhsA4OCJ1WhMu4uY7s5idqVSslLrtuAuA/wRekNX1?=
 =?us-ascii?Q?t/Z0JqNJq61rZptwB10baM7y3Dc8K7dL3be34ZQvYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?McSRMOERYX620VpaSAO0FQRqScO1EPpy4K+fK+Q5ceY5v7Lw2zM+6/47FVRz?=
 =?us-ascii?Q?JWgL7V/axtZZ2P6RfnFmgYnJB9qQXzAWNJ0qR+whLd3mVgtTL6LivL/iNtk7?=
 =?us-ascii?Q?ukPltOeOacVrGfNuF5/FivFU2FKjwY9QAc/lYV7R8kGfpETfImfwFKITnSg/?=
 =?us-ascii?Q?tP0YIjzCYYM1s+w4wVWPvz4j8LFn3KoYFzjEAKSrFyCFAU8QqI+nyJz+KrBJ?=
 =?us-ascii?Q?prTQVBajhC7h0L02RGxP6OsJAdik+vd+rfSuZPImsCfz6ibhq/foXKNKhiTK?=
 =?us-ascii?Q?dWP1fwTWU6gV1+HnY3VHSQ12aLEq5wn4R3lPO1Qa+Et6kxeUhB/df0qhJ6VZ?=
 =?us-ascii?Q?wIJRhIZvHbPA7TXUWrHfXadbCS8LV0SNVeMPkuxa2hcoZ7NBpQ47RFkCeBA3?=
 =?us-ascii?Q?gL1KgfJx2BZMKPXJxrJUr9oCI41lX/uYc/LyH8nNVetQCdryR43hEz9v+o7j?=
 =?us-ascii?Q?PCxWB+PnU6UUsFDr3J93QbdQ42HQ042SJrdiGyHwEPe776bgii5ofxmXyNbz?=
 =?us-ascii?Q?j5iZX0PmgGwk0VJ6IVvjSG+njMRmIUPsBxZyqYKrfZAH0tRGsekInGFsjIgU?=
 =?us-ascii?Q?syqvc6S+PuhO+WxciMjzNZtwLobSeNd/+2vbLQfA5oTZdulyst1AnCFq6GFC?=
 =?us-ascii?Q?wXdsznPEZbdHR+hcvtmGnnuYKMF7jk30/7XQjGZK+WA5sa5I+IvcENGTnUa4?=
 =?us-ascii?Q?9ae+4ioBeB0cybNgdrssQvkT0TiFn7Xel0rdVGUDIer4hvmT3+iqTR9WHZ8k?=
 =?us-ascii?Q?HTyjfZXcsQw8RaegIi6uKcEnMgQ5caVRyM8aJrx0fRYz2llzX7FKU3CfVfKT?=
 =?us-ascii?Q?TMO/jgejDL+IFQrfr3l9iJ4Z7kDfJML5t3C5yMziXTnpeabnOObPBAgpMxIf?=
 =?us-ascii?Q?knMtYYEJZ4BOdPaqVKVLbSjt6nJ+p0Ir9nQwG4ggF7kw7QjxneWDV49MyDCT?=
 =?us-ascii?Q?wDeuxLfeKPhZclTLJcHHx5IbSTah0fcvwFwsZxmkUXrb2jY66hgwoJVfZBzp?=
 =?us-ascii?Q?x0rsMEtKUn1wOG4S7r6CMvDF0aFJM/vQHhlhqb8duguiEsjqBC8YS9QyjzJ8?=
 =?us-ascii?Q?/hnPef2XyXteU3AWMD/2Tk3ngzsAn305vpCuVw7lcIWbf9QGzMvjLcDq+tBO?=
 =?us-ascii?Q?jxr74dJTCsZzrt8tGhtTvne6wqXoMlmhF4rrbuPmQSr9rCt1jnNbB4b+lVA4?=
 =?us-ascii?Q?hl76KcAO1mzsZSZLhtYxusurNQWdfTyh4wq3Yb2Jf+dBC+NdEJwZaXjpXrGz?=
 =?us-ascii?Q?aqEOCWx1dsjNklxzmIsE6/ROBX3g+muf04QfBcB630LrvuJ9lVcbSH0K7pTP?=
 =?us-ascii?Q?VUmBKVzf22Zx6HLyXzsQHpQFxf67HCOSub2uwfBM1DtlSu27B/rtEPBPFEs5?=
 =?us-ascii?Q?ehnd0hnXSFWyk4ZIfo1hP7sTrXinCkmcDx9wv5EL8aikPfz0a05faRJTS8Qo?=
 =?us-ascii?Q?f/GZLs2y7p7n0US1Lk3n04vBiGSO0O+gfOdiI278ZEzzoQy0k5zv7YQtjkgD?=
 =?us-ascii?Q?8MeHp+XsjficCIfQqgPyqMdo+cPH1cV84ORSHFEIDuB89cDpq7YYoj8+xS1e?=
 =?us-ascii?Q?j23udPkUmzTDugWGI012hw/O7oouIBCVyXN7oku5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6042949-d100-4f35-1445-08dc6f76ec90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 15:52:54.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHxTf2Ge+bu9iyloUD+VywfaxG0zK0yUlSHAFUdbgS+yH+T6d3lEcJ0c/vYCUmo/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454

On Wed, May 08, 2024 at 10:56:34AM -0400, Zi Yan wrote:

> Lance is improving try_to_unmap_one() to support unmapping PMD THP as a whole,
> so he moves split_huge_pmd_address() inside while (page_vma_mapped_walk(&pvmw))
> and after mmu_notifier_invalidate_range_start() as split_huge_pmd_locked()
> and does not include the mmu notifier ops inside split_huge_pmd_address().
> I wonder if that could cause issues, since the mmu_notifier_invalidate_range_start()
> before the while loop only has range of the original address and
> split huge pmd can affect the entire PMD address range and these two ranges
> might not be the same.

That does not sound entirely good..

I suppose it depends on what split does, if the MM page table has the
same translation before and after split then perhaps no invalidation
is even necessary.

Jason 



