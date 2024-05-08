Return-Path: <linux-kernel+bounces-173560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD218C0226
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2567B2704E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C7838F9A;
	Wed,  8 May 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="edUvFpIN"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE25231
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186133; cv=fail; b=BQT6FcsIZvke0KfCoYnWVQmNsB8YIMoBS2ZgdkSysDpgimQwyMqZ6VSzOgYypRhdTAYq9EKMEIIAWPoirgOUFYNeeEdoLHt9H0JDlUAY5swF6Iho1J/Qd2eX8Lx/KvG1PTGasiSK+RWnbchwZh9xmc9DcPxONTGNFETcJHkntro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186133; c=relaxed/simple;
	bh=R6h/nB6jp2fNLEu1oNU0rGGNkU2Ho6I5/dO2LpLHMIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HtfrTNXJ+6ZrvFnMam5Yg7ZtSTShHzywkyPWqoMhYiglnZqSUIoEGYshFIHopUislCFF1hkJemJ2QYilpj3lMgZVOzKSLNFcH6xJ/2D/8XYRUXMEsjCPhZG3aFT0Lw2eoQ9RlDjjpNsaVln9Uw6XABYWhN3EZRDxghR82BWJPuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=edUvFpIN; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRp6L3HNqT0GBl1nmMOsNt6Uux+Y3vK+0crjzx+4BMVAESDSLidXuCX6qJl6vsPkGwSh0BSC6lcQoFBJMLI05U9gGQf8m1vPMCzsUkUlEWALb59NwKTuEYb9+z1TmfKhcxG8NUaWVczy0MH1j+0S+r473KiYwtx4/3jCNS+mxEhYPUjvOfi7ZxWk+OWgiCUtwFhV8CO0oLPKmtMrAHk8nQk79AtqbFHZVbeANno0cNfh7rggMZBlKb1qi3N6cTwwY18GWiJudRg16PUYYJuMJQOvwJW22pLn5JtCvhd+mFBGob2LjjHTIyood+gHbzAMJAkg6a4zGZCJGAqHtcRCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIOAqdn5/eCZjR/YyjURHb1YnHHaGuqdkU26A2nLwik=;
 b=JUDa7jQ2vppEUKVWY6qSeSWeGs0ZYV6CcQbpbEB7oaQFVAaBap/kVVN+W4+iR7iXN+IB1Ze8T1CvN0KFi2/1afyTr2Umq0GC8IPZ4hZ3ovsZ3qfz/8KgOAH3JLJJ+0iKo7MVJNSZKiLH2S279mlDaAopN/OiLjakIQEiwO8mqUaLLgJdm1UyNFPVtzUGm455eGOb4bDYSm+/nKfEv+J9fFELQuEif/v4GSVpkgYvUYTKp4mISeGaiNe2Pt1kknK497PhFbh7kVko0+ZTNFaAO3BHxAUvUdsSulboLFEE0/8x60gPuvV9ESj+iUs1chko0UofBzN6lvUDMWJsWf9/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIOAqdn5/eCZjR/YyjURHb1YnHHaGuqdkU26A2nLwik=;
 b=edUvFpINF7CYXSVH7tjqQZTkzsJ3Se1aWjOT6xYACi+79egXsmTSLWm90TC59cilaT5gfLHjHKEbAaWWsk7anvT3Yq1zz+lkNr7br+0AS30lYAH3853SyTeNT1FYzlUQAp0d5cUM7WA6Jw16ig4Wc6hWxtAInEUf0KnxSiPeuWk5i/RM4Lw+ZPPhvLpu6WbnkKjYmx6f/LmobOhzI2p+afB5NPI9um1VAkp+7pZHqgVYLFdT1+TTs+P92ErTAXbyyHzCckGN1Cgpjbyqh9wUN7REXwiC5dZGyL9Z39ixAKOzPDt9Dws9LDE1Ar90ocy7Jhn+IIQI2tMqQgQIkfdDdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.38; Wed, 8 May
 2024 16:35:28 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 16:35:28 +0000
Date: Wed, 8 May 2024 13:35:26 -0300
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
Message-ID: <20240508163526.GM4650@nvidia.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-3-ioworker0@gmail.com>
 <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com>
 <CAK1f24mRVam3w9CZkq4O0smGUTVUQfdvA48mqsU+NKxMUxdz1A@mail.gmail.com>
 <B1DA2DA4-AFEA-4541-8DFC-0D815249A064@nvidia.com>
 <CAK1f24mpt+ZGow4LLdXKZcwopmkZDrM_eh15SnkEgpiBXTmOwA@mail.gmail.com>
 <10BA9EED-A2BB-44C2-B80A-26527CDFFA50@nvidia.com>
 <1B2017A4-A252-4C1F-9608-D43ECEAD53B1@nvidia.com>
 <20240508155253.GK4650@nvidia.com>
 <30469615-2DDC-467E-A810-5EE8E1CFCB43@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30469615-2DDC-467E-A810-5EE8E1CFCB43@nvidia.com>
X-ClientProxiedBy: BL1P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::33) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 0355b6ab-4452-4a1a-4af7-08dc6f7cde70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mle/dKkbRKf9gbHl9veG9MiYi0hK/35lha/h28qkrULD/WX/0tbLfpexZriq?=
 =?us-ascii?Q?yobxK3ONyG5wTQmGeNVrUNiruDVhMCPGvtwXooKd+0oLBDFXhK8GbbgQMkLV?=
 =?us-ascii?Q?/qd0v2UK1fzC+C8EWt7jvkFNaraUy3wYBQN1U1onQzK2deUXTIKV6TqT6onl?=
 =?us-ascii?Q?O6eRkJmAzrH4pJa4WefZ54oAn/A4iZZjTPywCeCl76MXSmkcwj2JEz9u1pC4?=
 =?us-ascii?Q?qftsZ3iLdeYvhd5OjyNE66L3VK4tTeLJw4KWk07npM6FQV4lxQzjKT6s33HB?=
 =?us-ascii?Q?pFNj07IFyMHk0KmHSe4ftBMLdgroapR50KbNNPkiYvAiMjrHB62aiCSRkp1I?=
 =?us-ascii?Q?/Yax+4V3hvJNu5Sknc/U4430wkMzES1QSUybgKDKQfYzHoluc1ta63FkU5SQ?=
 =?us-ascii?Q?cCeCFFH5kMK5BpUHoR9LR0u4/nG/1e/zIHD8H/Cn7rWGs74WXyXs21gPJOlv?=
 =?us-ascii?Q?c0Q6Hg6UKODD1wlsSXIal9gJRuuq9fs6sYjKCrxhh11qh+88l+FEF6fuh4Zx?=
 =?us-ascii?Q?TpZMMO4ofKsIkshakoOYPOnHuIpmJTMHCf7LAhFbm7Oa4JaF1APLDElB54x7?=
 =?us-ascii?Q?SWI7KA5sP6UE9HYbBCDB7gxLzJcAY9UBCv5kJUN7sys2M0DgRZ+qwncIhPgA?=
 =?us-ascii?Q?rAxCe1vNY/Bp1nWMz6zGbx6lmOxlAQX61PDCwivitRrcKU1Sal1PryKA1p6y?=
 =?us-ascii?Q?sbcLv0cNPf+TP344a8S4E53t6h7FkeG0cZNPuhIsxc+fYOj4XfC0mAIodwWv?=
 =?us-ascii?Q?S3okueoP+jXUrnCe72Ysi6sqGkgpF5/+BrnlM/flGvE4rKgvjuu5CH7n1JPp?=
 =?us-ascii?Q?WoHWvW1gozBs1oyymIQu3CfcmEYQTrD8k7iTmWH2BQ1v34kD+g4flvIZ84jn?=
 =?us-ascii?Q?usCgyuN29hISkzAFCC04YG2flXe5JhQ2hI644XCux7Lm3thzlRNoz+k6aOTP?=
 =?us-ascii?Q?iHlF5MEnbOZ9Bp0aLu3imVqHqgEJZqOnfNy7EQv7PinVykKZnvCH+dXsD6h7?=
 =?us-ascii?Q?SIVST7+2ewQOzZ5UZSeZpsbLO2OapHqYsluxTnqk5j6O5DQG51cLYJB9Hh1H?=
 =?us-ascii?Q?wr2nEXko+70ZlCgfV9AnoW69ZkDzqoDVMRJPVn2BhbczsKnjfU+LR5hPjiIs?=
 =?us-ascii?Q?4VRPQBOrk07nlUmcD9VBy4Jy5m+yog9hlQqecip/L+GXNnEB/f6tcYjIznmq?=
 =?us-ascii?Q?tkVl4TlPFfOJ+Sq7GlQizWjyPxlQO7PKzMK5Cn3iPMkmKw7MkeDh+Voy2E5t?=
 =?us-ascii?Q?vUUpvKu1lUt+52erc1BploH3n5p6Z3ZjMdQT+SshHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p76T6yqTsQOHnQpcWmThksxrKFYXd/AkW4bqSmwYUz8bz2Hdfg/Ao2VShGvW?=
 =?us-ascii?Q?BRm4jgx3Vwtu7Az2gTjRJA7lKAOj4HbbkIiutNl0rGAcCe7Zgk+ZIZpDFkr8?=
 =?us-ascii?Q?6/5oTnoDUTfvz9mx1da7QnXn1kxptHFn2R2nJULgaK6dlLd1v+C5/590vvd1?=
 =?us-ascii?Q?KpsSZzhOo1VX7jAvTifWmmCKBSWiSBjEeTPcE3abyqAxTyBhlgH5Txyc1LOk?=
 =?us-ascii?Q?XBazbfZLKv7LUVqjSDZgQF0qlq9ZIfhaGd0xvj3t+rjCRSwOeICdQWRqyV+O?=
 =?us-ascii?Q?XV/JRMDJxdGWwXQ8yQ5KcJo3df8zw34X4TT0vMWBl9hLAENJk83pttDC7wWa?=
 =?us-ascii?Q?D+KD3RT6VfmR9X/xD4CxZAxvHgaZqj3eLSgY3O2hN3AzjvyIAjGsQXWfFUwD?=
 =?us-ascii?Q?4rZ4IKQ9nSxTKulFlwu0H/KEcrdqk7c4aKAe+LEKWm/PBmISBfDtNe4T2alH?=
 =?us-ascii?Q?GrRIwZQKdt8S43pwZpLHBH4JypLYD9CogFbgGVgJYzGVi75wy9qAUpVA70fm?=
 =?us-ascii?Q?sd47XLjFDLalvIjCAPnPamRGi1QGGyb6idM1rO5OD/r3EIQ/PXc2tZ6XYg7G?=
 =?us-ascii?Q?WZKTWhFS7/z6r0CxciVn8j+yCiLGBfdW0kpmjJBVgvg1AMhNbGfJUJSCy7sa?=
 =?us-ascii?Q?dgir/LZPysYiBGefYiZwlSaiuDQ38S+7CsOqGvs6vRUxRuOVl7wWMScebkkz?=
 =?us-ascii?Q?1aL2aUQ4ouH/s7+AfzVE3Yp2PUz40bfaZJRkHV2O9miULwH9C47JiUa7bbxN?=
 =?us-ascii?Q?u6/PmFnAa0HDCK2eMHAfTS1qsd8c3o3w174FKbRdyxLiT4HCrG/AJCKHiPtR?=
 =?us-ascii?Q?6UENhFdYzrXxjdIpsDSwdje8h5pbFgwuYRWATuY4JNjizD5YKQERTXpfmk0r?=
 =?us-ascii?Q?zbS0wN7whbw85Yyg4mHGgiUPCOZEV1xlGjHu+hqZSrHRemYRGHhZTxZwmpgS?=
 =?us-ascii?Q?G0R+8zZy1OtKWhesPmBDFpnPHQeQ7+S5yQMaBdWCVefDYtZF2/t1HiDy+k3V?=
 =?us-ascii?Q?jkDEEIru9HQgTx6cuI3Z377FMKDM26vB59tu8ladGxDRzytcC+MbpcqG0gFq?=
 =?us-ascii?Q?Z72gBHzRBGMPzcA/CosGk1t6zy2sVBtAPwTEuvC75GcHVEvmv0zGfdQ4z3MP?=
 =?us-ascii?Q?3gcRzmxTJoWV2b2vbxtH3LwBfOQ5vjBI9+Op/MtpZUQ3GZqesK9IHyxWI8yI?=
 =?us-ascii?Q?gfDUwEFr43km5uUoY+XojK535nLxYd15GfVeY/rz+ZQ7FzaON1penByQpZSg?=
 =?us-ascii?Q?3V0v3f67iWGowsreeOu96imzFy7mmcLl09VGs9VaRlC7O41fSaJt8hIRm9U/?=
 =?us-ascii?Q?yapsYM2Rl+o+ec0v3C9eGFIaCN2/q5mdlgIXCEVPRmr2yKmZt5VHOzC7E7XN?=
 =?us-ascii?Q?H7RilTJV4wBErjHMx80NeoFAntk27/SYp0fq9N4IqBC58AaBwfRJG+UhxIFa?=
 =?us-ascii?Q?8+frIHpPLeLXFSAzQjx47ntcQDwySiAvfI+JShPbIcdcaCKZya7NgNoVn0uO?=
 =?us-ascii?Q?GzfNrU0TNbaDitfiwek5Hn0FKqLT7LtRKhWaVPsnGPnrCZYWQtOUHNNcn61L?=
 =?us-ascii?Q?TSfrqRyJV7CSDXXErhHnqpp8OMaPrDgOxl3bI2S1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0355b6ab-4452-4a1a-4af7-08dc6f7cde70
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 16:35:27.9658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPyMdqyK3WysIKrMlcxTEXfhGBXQ7JcEM0uR5J5NhAwaewpodyhxx3wdVeb3GBz6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368

On Wed, May 08, 2024 at 12:22:08PM -0400, Zi Yan wrote:
> On 8 May 2024, at 11:52, Jason Gunthorpe wrote:
> 
> > On Wed, May 08, 2024 at 10:56:34AM -0400, Zi Yan wrote:
> >
> >> Lance is improving try_to_unmap_one() to support unmapping PMD THP as a whole,
> >> so he moves split_huge_pmd_address() inside while (page_vma_mapped_walk(&pvmw))
> >> and after mmu_notifier_invalidate_range_start() as split_huge_pmd_locked()
> >> and does not include the mmu notifier ops inside split_huge_pmd_address().
> >> I wonder if that could cause issues, since the mmu_notifier_invalidate_range_start()
> >> before the while loop only has range of the original address and
> >> split huge pmd can affect the entire PMD address range and these two ranges
> >> might not be the same.
> >
> > That does not sound entirely good..
> >
> > I suppose it depends on what split does, if the MM page table has the
> > same translation before and after split then perhaps no invalidation
> > is even necessary.
> 
> Before split, it is a PMD mapping to a PMD THP (order-9). After split,
> they are 512 PTEs mapping to the same THP. Unless the secondary TLB
> does not support PMD mapping and use 512 PTEs instead, it seems to
> be an issue from my understanding.

I may not recall fully, but I don't think any secondaries are
so sensitive to the PMD/PTE distinction.. At least the ones using
hmm_range_fault() are not.

When the PTE eventually comes up for invalidation then the secondary
should wipe out any granual they may have captured.

Though, perhaps KVM should be checked carefully.

> In terms of two mmu_notifier ranges, first is in the split_huge_pmd_address()[1]
> and second is in try_to_unmap_one()[2]. When try_to_unmap_one() is unmapping
> a subpage in the middle of a PMD THP, the former notifies about the PMD range
> change due to one PMD split into 512 PTEs and the latter only needs to notify
> about the invalidation of the unmapped PTE. I do not think the latter can
> replace the former, although a potential optimization can be that the latter
> can be removed as it is included in the range of the former.

I think we probably don't need both, either size might be fine, but
the larger size is definately fine..

> Regarding Lance's current code change, is it OK to change mmu_notifier range
> after mmu_notifier_invalidate_range_start()? 

No, it cannot be changed during a start/stop transaction.

Jason



