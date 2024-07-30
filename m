Return-Path: <linux-kernel+bounces-266625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EABC940397
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320871C21F58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548D88C11;
	Tue, 30 Jul 2024 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F0CrLArW"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B78BE8;
	Tue, 30 Jul 2024 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302791; cv=fail; b=H9gJePQ70+/3D4o1XzwKWPN0K5PvTJti9OCnX39DItJQB7cc/8UtwcaeFZrlWa1Rmtd3Z1enpeV82JJ+k4CDmoIhKY+SHCD12dUOPyIvCCuPne1IrgcbnKLBTG0nOZ3WQgO55Nsxm5mOsmVmdxX5NNetm2u2o3ReobGe795ssuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302791; c=relaxed/simple;
	bh=0Qmeu3o/CNGnPV5IW0zpisHd5/4fNG64DEkHBDGjhC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kn5Lv5XbGXLnC1qnNFzl0i2Ir7tkPTNSuR7N1pDVG7EGHAjtpJdvxbMNrKf2y2v+dW3xVpxOPEF5QkCYalVf67J4knwfbbQAiNZyzyGz5qBgXgwNVPsG/j+TRa5BUKZgaINwPX5dIEH/OeMiBO/jHm7FRdtrkWFzZ8tbZpHNsuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F0CrLArW; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0dlxbLiAcJv1z07Jy0s2HuQ4z6/Wc2LWNMj+SkixtA1xiEZGckJeuQSnlT71itv3CNvsU7tmkNRvpvDpb0N5MqucmpeKhHSlPotH1y2cIp9B332g4dgSVlshWBPUOsp9FS2/bU4e63cNnRo/Axi42wGJtIJ7z4Vn0uK1FUr43wTHi0t+Oid2zrh/5biS8qs8+DE17b3CkYhSJhX/M/SSd3vmblvg9mIPr2kBOQvbqK1D4kcK1+//OMwEHKBT7yNr3r6UXcsBMpAwKWPEWnRov6D9bk/GQNmkjbUNTV3H8sau1SQQVWHhU6CgQCHfah5n4+hBVSUX93GES7Ur2PGQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8CiNQKDn3SM+JyHXhH+95cW/Ob3MUQ2Wd3w/W9cUlA=;
 b=t1GRhsb7+EB/gNnPSK03aF5/JPr+b5dyipmzmdDpA846QaVwjtDXAT2QuZdrMi7hbGR4bJPnZBlZf5AwL3l6Y2zguCh1z/FRIYglRLWfGDwPNOyeYeWilonxT9gh4opL8NE5hLcxd/v2VJ3XrWZWqRwB+V0XlVx6buoyfNH8xoAS2ibmDYm/UXW2XiWnE/TDU+oDBiI5eWM4r1QSe57itAVqj5mY26AWmnpOp14qLec5Hql+ua0+cb5QlpA9MmpzZIFO8+KOOXjIwVrYQ/IAUdnPIVCWMSg1Wo1viy16Zo4GtMxRE2TTdu3p1ZpEj9Gf2AYoeTd1owTfreGJtH8y9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8CiNQKDn3SM+JyHXhH+95cW/Ob3MUQ2Wd3w/W9cUlA=;
 b=F0CrLArWCmFZI3mda8SiB0rHcoCBlzVifoSpo+c6uclL5nebcg+sGs+x7YbJv925D0aI0q2/PAgoixM1DU+YZQSKNUh/+buphnEG3x9ggY6G+2ZyzR/wpvN4fJnzcdg22YhiPmWpQISvRLx+xpneINsf//OrEy0TKtWz4UvmusPK8A82XIB1nQI4xu4IDRV2mpIxwVHv7HibseDx4iXB3gfn7hzPioT2poEcUMwEspJQhyL2LP4uSFKQBiRjoqQ7S/9caNrTHcnKl48pOv2/dH9EHK33uQ23cYE6XQKl36EHBwlvEQyiuxG61c201/solQEohyDeT2nh6a8ZQe/Yaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Tue, 30 Jul 2024 01:26:26 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 01:26:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Barry Song <baohua@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lance Yang <ioworker0@gmail.com>, Peter Xu <peterx@redhat.com>,
 Rafael Aquini <aquini@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC 0/2] mm: introduce THP deferred setting
Date: Mon, 29 Jul 2024 21:26:21 -0400
X-Mailer: MailMate (1.14r6038)
Message-ID: <72320F9D-9B6A-4ABA-9B18-E59B8382A262@nvidia.com>
In-Reply-To: <20240729222727.64319-1-npache@redhat.com>
References: <20240729222727.64319-1-npache@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B6FF6B78-AD9C-4A64-83AE-E41024EBA060_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:32b::8) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbf7c4d-288d-491a-d08c-08dcb036a111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/dbUw0/jesTktl6pQ3crPrf0hV3cdO47dF1vd2LEcoavHBLOBuXU7/4M1sX8?=
 =?us-ascii?Q?MevZZ2rb5bTp+uK/9BIZCZENhdUWrgLuYNNi20Xst7rCnEGDhXkXk2FjCocW?=
 =?us-ascii?Q?Cfs0ACazAPZogXhcFJkpg+tvWX8/6gE5JBfxaQhB5BpFMLuOeX1QdfkUc7Rc?=
 =?us-ascii?Q?1ly7cqltr0SJiJvIg1RQGZNvJ0K9ibwaHiQkF1SEeZRinEBgVyUM3XJjMOpy?=
 =?us-ascii?Q?q+IqVRHXTOHp0tjQuITTFg1dMrLqd412te9Rz6kDiVcUxkkQnxp5OEKLgmMc?=
 =?us-ascii?Q?5wk05921LwrtO2L7frVbeT5mvrJHJF61xgiF9tw191MehqbpjFBVfx6tIKAW?=
 =?us-ascii?Q?iIGjh0ZhoqvP3K/4WEnbjSjUxDe2zCC8Xu7IpgIJgjexP/PDFH1cNJlVXqC9?=
 =?us-ascii?Q?N6j1TepV3OErLQZl0tDmaHCW6hwnpGGqY3C8pzeXzJX9Gj2iUBeg0ZC27hAd?=
 =?us-ascii?Q?YS6uY9heNfF+k//aX2jHDE9X7LJCj7aqGb4VRkPnJQ/P5s2CZ01MUe//WJx5?=
 =?us-ascii?Q?SseyliVXST7pMN7Co1siP8eOaMhZUwYTzJXF0h4pIP2coSpHenx0Rf8J2/e9?=
 =?us-ascii?Q?b3AwxMHdYC9NnyU+WH1A9SGR4s0LxB/nmfILsu00+YcVqiDh9ZOVxCkZXQ65?=
 =?us-ascii?Q?zQ46UHVX7NIw55QRmwKdo4tc/n2LVrEaurGFXT2bUNdPhauJwPvM+/r1G3CA?=
 =?us-ascii?Q?g7WuuFDL5Dd2CkHe+lbpSWSGTwC7xlWw+Eomjv0Mbr+7NsheWL3193iTQ6iT?=
 =?us-ascii?Q?xE902/mPpZlLkHyHtHaPofZRgNJoA2Q9zIbQ2MTL56Q9bGTz5yO18i/+Pf3C?=
 =?us-ascii?Q?qRxIYCgp0CCa4USIUK1NzVILQMNsNgbcBiEBc4636B+EcNPfWzjAy89S1v9h?=
 =?us-ascii?Q?6b1pY83EA2Fo5Sw4AhJb6otyAjgeyQ5mkbIQwVUmNv2fSA+JGhnuKs0GiVYS?=
 =?us-ascii?Q?KgkOAE8wY6Elra+frC2zED21i4GmPcwVSfgsFbOdHvS6S98kVR3jK4cLuhpH?=
 =?us-ascii?Q?/+6yb7Lb7gFMwMj4LfjR9nsoj65y4zvWXNrNXk19WVal8zDrLYDKlILWYjad?=
 =?us-ascii?Q?Kx7E8rqLBBEdWpccRKBk5b0Vd87wjefqbCM2p+vtNCWf7iLQXdtn7sAv8XlP?=
 =?us-ascii?Q?3R4aHwOnOVIgLAYs/9hsfjf6fgTQNFumC84vv5nf8JLuw8xo9awjiv/prSOj?=
 =?us-ascii?Q?Y1lRXq97XZhl/TQS31/7Z59KZi33gm+j4+u7sVkHa8OMoLTXmUhSapXTgxAf?=
 =?us-ascii?Q?lVxwhBjFU8DuZtoKk6Is8AqyL0yr3bDb3z0hBSDDwu8kKzI4BF29s27Cz0VY?=
 =?us-ascii?Q?WOeKZ70SDA5UBHmTCEm8q1XpwH1DFHMjXdUccuuFF2JAZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/FsZzjjwfxxQAT/VC6V4fX5Iv14TLDDeiTeLFuqCYgVVy+B1WFai4nDUjCbn?=
 =?us-ascii?Q?3QyZtPeRu3wllqbifVsCBo+bvYcuClbD+ThTvypX4VUn4fGn6YaFyM8fNTAv?=
 =?us-ascii?Q?f61e6tEYefdjhAQNTRLyA/+tC5GMcJGnXAU/cLJ4odjmaoeLomCkCMjCQi2d?=
 =?us-ascii?Q?Fr2kEH59+Ldr5Fx+vA7dNfYm9sRxBdMGczJ0Mh5UZ0s/gw0Wi/4H8qd0fBtz?=
 =?us-ascii?Q?B6tSvhyqKoCY+grXiNl6WfGILd3tYdkoPHHZIqsp6vn7dXP1+JkPLTmARkQE?=
 =?us-ascii?Q?Q9XxBbTz1F/yx8wxSr46oWT8bnHgMZ/OOpPLSbyQKmpktu+XOGmWwaHqGNtq?=
 =?us-ascii?Q?gVE/gzU2Dd6C6eZ3ZmNNsinSWOFvM5ncb6/Zal7RvOMqankkzMl0o8o/j3PQ?=
 =?us-ascii?Q?p1DrfP6FOW8RLI3nl6t5G0IjAy39nPXleYBhE+cQyfKq5XObym2qvwX21HFA?=
 =?us-ascii?Q?Qu0jt/vsSj0/za6DeQhxy0ausJz8Z2BLx/mC2Sv00W0bIpCxHLhN2DvhOhlY?=
 =?us-ascii?Q?TQARI1Hv9x4DZZyZaxO3aP/iE04VCLYs//J79XPmMsHs+/EuJb8v2Puy5vfn?=
 =?us-ascii?Q?dgW451GJod5DJdt9ll3WaL/pqOTG7yEHBaZbGL1jtO0QKfhedVXTlSD3STRD?=
 =?us-ascii?Q?70itKZhrWwfuIZJ0PiClWAYa2Ev7fiGzvuPopTY34tupLX9NBvZx/GixSdzS?=
 =?us-ascii?Q?ZJ9pMAxiGmDaTbtF598Kqh6ZiGkGH86tpfcvqAVlZjaliZXYI2ThRGjWlNao?=
 =?us-ascii?Q?zbqEKI4vBGRQ8zaxCVmA3ogdSnn7+v34io7CuT5HizbxOXh2jjJt6hrOOZGX?=
 =?us-ascii?Q?DWGkvq3w9WzjXtw+XYirWR+NTcTMidy3YUEM+vlYCKkuLMnm6hVJnnr+B9Hz?=
 =?us-ascii?Q?MS8apf0k/PTXHRShnnSK7PXkbxrEDkNr2faJYmFt9tdlEXtrgCb5Ts5zoVt/?=
 =?us-ascii?Q?7g0eL+mzTHHZdc9QVX001W+gpSZCRS0gNr0BzEGvXtRSWE0B9oYBztwZgWkG?=
 =?us-ascii?Q?aOtueKnxHGwS1hRxZ+brMGDqySexW7uJr8BYhlD6YEq9/17KvGRHbXVjuvsb?=
 =?us-ascii?Q?m3S0ME60MLTOtibr+DBNbuZs1aMMueoo2io6ogipQDMTizTmiYROTEisUNKZ?=
 =?us-ascii?Q?V1HhPgjv+2HsZnv/r9TYH6INtCa1UhTbOO1TbiKgz97ODs+NWu0js0rcdgKq?=
 =?us-ascii?Q?MLWMEFx5BzvrSEz+mdUXeg9WvhFqEo+Zia/yyHxBJ6oVxJ98SECjIYawXZLE?=
 =?us-ascii?Q?dnborqmkAlkU+wUs+qz6xDn62p1mpTSUemjh4JoGtXsfgPc0JTQFh29xn/vl?=
 =?us-ascii?Q?LxpP4lwG+Z9EUL8HdzDLLSaj+kpz7E6Fr+lmjrXKZ0oeCwjc3X61etseUAZF?=
 =?us-ascii?Q?wvShCiilYEMrCnvBJsk5l7QLodK/xs8+4l0XZf2vetIRtp2cqmngOqodEgUI?=
 =?us-ascii?Q?1vSpB+tXKeLemjVaHJE25OlagxniBAaaO0q0m0OJiI3B4uIDmxUq6+/bjZaN?=
 =?us-ascii?Q?ZGWaoooTPsh7+0wpGybrMkFv4kUWkiZufIbiSZyVFuuPETfpNEjyLigigymz?=
 =?us-ascii?Q?v/9FTpvKEmH/rOpeOw4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbf7c4d-288d-491a-d08c-08dcb036a111
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 01:26:25.8229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEGvl4ZD6G+N2gKE10RAZedBixyOXZrtbSTpspCxvTwChTOYH7uaTse6LF5yVtAg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472

--=_MailMate_B6FF6B78-AD9C-4A64-83AE-E41024EBA060_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

+Kirill

On 29 Jul 2024, at 18:27, Nico Pache wrote:

> We've seen cases were customers switching from RHEL7 to RHEL8 see a
> significant increase in the memory footprint for the same workloads.
>
> Through our investigations we found that a large contributing factor to=

> the increase in RSS was an increase in THP usage.

Any knob is changed from RHEL7 to RHEL8 to cause more THP usage?

>
> For workloads like MySQL, or when using allocators like jemalloc, it is=

> often recommended to set /transparent_hugepages/enabled=3Dnever. This i=
s
> in part due to performance degradations and increased memory waste.
>
> This series introduces enabled=3Ddefer, this setting acts as a middle
> ground between always and madvise. If the mapping is MADV_HUGEPAGE, the=

> page fault handler will act normally, making a hugepage if possible. If=

> the allocation is not MADV_HUGEPAGE, then the page fault handler will
> default to the base size allocation. The caveat is that khugepaged can
> still operate on pages thats not MADV_HUGEPAGE.

Why? If user does not explicitly want huge page, why bother providing hug=
e
pages? Wouldn't it increase memory footprint?

>
> This allows for two things... one, applications specifically designed t=
o
> use hugepages will get them, and two, applications that don't use
> hugepages can still benefit from them without aggressively inserting
> THPs at every possible chance. This curbs the memory waste, and defers
> the use of hugepages to khugepaged. Khugepaged can then scan the memory=

> for eligible collapsing.

khugepaged would replace application memory with huge pages without speci=
fic
goal. Why not use a user space agent with process_madvise() to collapse
huge pages? Admin might have more knobs to tweak than khugepaged.

>
> Admins may want to lower max_ptes_none, if not, khugepaged may
> aggressively collapse single allocations into hugepages.
>
> RFC note
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Im not sure if im missing anything related to the mTHP
> changes. I think now that we have hugepage_pmd_enabled in
> commit 00f58104202c ("mm: fix khugepaged activation policy") everything=

> should work as expected.
>
> Nico Pache (2):
>   mm: defer THP insertion to khugepaged
>   mm: document transparent_hugepage=3Ddefer usage
>
>  Documentation/admin-guide/mm/transhuge.rst | 18 ++++++++++---
>  include/linux/huge_mm.h                    | 15 +++++++++--
>  mm/huge_memory.c                           | 31 +++++++++++++++++++---=

>  3 files changed, 55 insertions(+), 9 deletions(-)
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Lance Yang <ioworker0@gmail.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Rafael Aquini <aquini@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> -- =

> 2.45.2

--
Best Regards,
Yan, Zi

--=_MailMate_B6FF6B78-AD9C-4A64-83AE-E41024EBA060_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmaoQT0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUcXcP/jROEHwfShbTn9Fn9nIOL34PqgT1WCbf6rCE
X3JSTsjBgzPfvpCdJlYDhMkAnjhuXJFcAEsQbvzC8RvCnPkA6ndti1RD0QzWbTc9
hkL+oMYfXEMk3f/oaxt7ZGvVcLqF2TUC0nDLXVjpNZC8pMw6SdzJBMO8iwtYOrRI
uFRpDAhI9HsTlxmMwGPh6EO5PIZ9mTrWoSIHEhhVZDQdLziLVgBxt+Uondb1LXG3
AbUb0XPztAevp1lYQycb22wUOTpDwISaAQhAxSkBkuv9wBiK0EizI1OZTqI7pdhn
DurRt9SHriVcgIJKi7kwItxFNtyvxdKdMHFxWndc1CS7elbPObRUtMNZNDSBdwYw
iH0J30bdw/DUsaq1XzSN5gJjYBz4s5uF81hBJnl/7dsFd8kI098aZfrqJ3DxON+F
V1g+SLapnR6Y4cXpSe2Mo2Xe0p0MQfe/8ttIU4RLouZW8XzuNDpewgI6RqbQm5xo
DQ7pb21v0tWPvZ6D1GPW2r7d4tk5/WAj4mcye6OkS+vbkC4AFfP5yf5HVZ8GUHD+
TU4iI9nHTdrB6W5Bfzi/c6DvPB2hnu41gmw3P8stMD6WuWGVs5n5d/fQrlRKSgQG
GOOSbsAe+QnIrQJZz0BAgasTD/YaTk5DcokAhhCgriRyWLclJ5P9oMjE6d9l5EHe
JTAQkGwD
=UPbo
-----END PGP SIGNATURE-----

--=_MailMate_B6FF6B78-AD9C-4A64-83AE-E41024EBA060_=--

