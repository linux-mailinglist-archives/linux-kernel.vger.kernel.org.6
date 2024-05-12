Return-Path: <linux-kernel+bounces-176908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1295C8C36EB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4EB1F21577
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6BD28DD0;
	Sun, 12 May 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gy5O2tWX"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EEC42077;
	Sun, 12 May 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715526163; cv=fail; b=LxXjCjbpeIxl8lX2QJBq3hhr6i4s2bRZRZ1lLzu+q1kORYz41Z9G37+AIOuyZdUDXGvJrRF3NH96XpPOaJ0x/3EcXfgaVMQeFdX5Y5qq2fLVJfoCDSeivj49He6kQBtitSDO7mSmmbMZ0tqgUFx81HH0hTCwM3qpZsbh9LlBeS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715526163; c=relaxed/simple;
	bh=W2rhQ4yRgofM/lJx2Nc6Z3L/xRS7nmByP91vG6G5128=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gYyNS8xG5hfsaxdnfQKTloPCi6bKwa/hQfDiIMdESTKoSu+8VQj2B7pmEN0UVtJK9ao5jQF15UgKZxUQZMNnZk/xFDielPD8jUDZaCSXdMSeXQ2YDUzC8wUOcbjHGnkFrlfeXrFTJ7Z51db0KBdoVTt0HtUT1Uf0nsxVJ1VcBAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gy5O2tWX; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmLmJXhoO1zn1k09jpnYmmjUksvk6qcvbL2d494TzUBse5R9our4204LJKlc0nfQBGv06D/jB45oWGSPV8+qBBR8B2S9lMA3Fg1OF+Sq9nnreJOAyT71LDRjvDz6W/upRqo3VQgQZpPuQT2wiGoYh9OIOxDd6yzKbbF34omlXj4f82NNV4z6jN+0kQDYV+976ufrFLtO7oyoOd2G47v/jXtgTdX1oipswnBkAgWTBkAxLdWIaoGNW1fNQki51f8rHFXdjumB6RuUw1ltWBJJoM7jDe0qf/q9/G/aNayRkXdZP5K5XYPDbdg62AFYvFXYvz4hFx3PxgASUgKxqxbzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgAjyHgkRl+IKDoqoxey4ePLznWX5zWEiMYXwJ5W2uk=;
 b=HlZbjazM2N+JXCAubDgqWnAsweBcz5InxFGtudLamm7KoeKjvZzhi/hGvtqZjl2IGgVJLrlBwFZdHRLJjr1QDQxdBemV43RiU39+R32VGnoIzWUbV8BwnL9a615tzGaAmnQlU8DbAWx2UvTzgo3eh/YJosXHkGbnYJ0tfQQ2C8T/AkZHHn/Kqj3M6SLTgDAyC6oJwc0Y7+m5bZABVFey1Y03oHBRO2WYPJu9Tn1jt5I20wEni8KjYb5XPmA4Xmz9NzQH05/4KVW+zvWNnFp5ZACPsAlB3jKIiWaZNOC0NYVFgilIio9Fg+0z+Tgtee8Ojf95n+qnxJwvxIOKMNUOWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgAjyHgkRl+IKDoqoxey4ePLznWX5zWEiMYXwJ5W2uk=;
 b=Gy5O2tWXWwsrXyDRXyjqxcbLZAMsBvL9uuFWV1978fdU6EAj5fue+fnJrEpjBsiMuAy50wttO/IrdTWuyryVdRBwg4gSoGdBQqzQUv3G0CEPjMu1MxKmDtDInq7d6YN+x2dPXQ9gdNYzZ8MdIxDvL3D/CBNkWnjs+l8icEG3gQMafXa1Z/GFzjNzyPiVFDbh1wP+wwczgqKXyW+M8RvV3R51jkFaGw3boz4mca+xT6+6kgkd0w1ASs7z9PwjsxOLD1FPOOTgiepZF1KG94rw8uX/jr4cS8+tfCKvvD6fLkR9DEk8fCmPpuQ43LmaK8AYrSDgYn1DsXBmFYwCD7/Xow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 15:02:39 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 15:02:39 +0000
Date: Sun, 12 May 2024 12:02:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 12/14] iommufd: Add IOMMUFD_OBJ_VQUEUE and
 IOMMUFD_CMD_VQUEUE_ALLOC
Message-ID: <ZkDZ/YO0jqZOlRtA@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::35) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c794343-5819-4dc6-bc32-08dc72949135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GlC3/l+xfOUo46G7YR8NP4kdvtt5rjyzQJgWffVOSU6y948BthdYUnO+YI9R?=
 =?us-ascii?Q?6TxrorFSWS3aTBFeATaL7xEtLM39rbyQjPXEWRPLkARFGYz3Lke9qZYynu6o?=
 =?us-ascii?Q?W6IWxURoD+mgI+55pqXeRb4zoC1YDC0wFrgTpcsj+BxoROreQ4LmbSyEuald?=
 =?us-ascii?Q?SzSWd+lF4d+2e/V5YRkMAR9n0BYDZ4bt0fU5zSbl0mADnXAJ6TKG1wlofDOu?=
 =?us-ascii?Q?ldKvGEmV61fXAr75Fld0gPvbyf45G70Rd4EH4CQ4fRK2rihsCsZtg9hf8z/Y?=
 =?us-ascii?Q?lnWLgm+OvRzIlNdWlPNF/0vXTMwGccAHBBh94oFMpJYp8F9zhVpeBw0cZH3s?=
 =?us-ascii?Q?rAUY0p161A2B0dM9WS2iF82sPzaCEQmgATVh0t01cm/XgK6xiUdZ9IJF0i5p?=
 =?us-ascii?Q?9NzoqOhl4rOgVKziWfbV2XsCO13PElkILi8oOybPw1vr4kzAxYb/ZNuOrDvl?=
 =?us-ascii?Q?CJVL9aDfCibG7eQazTOBW1kpDuWSVvkVFLtxsHaPzXdf/UbG15vqiDwVwmL/?=
 =?us-ascii?Q?/7xHBJGhgXTbIAvsw9MlDiEfliP+QE8Y9rijHIhXAkvtmGpVjCYPJgxqaKrc?=
 =?us-ascii?Q?eEw2s/DRFUn9jFFduNEiwWALRIRmXvr3z/FnbJBTCEzPSEUvG0wLnYScc6Hd?=
 =?us-ascii?Q?8lQ8cd/UUmKKMxsVDdzO61fHnhwqh1PpsQQ/sJhodG0oyIOwH9TSzFWA0WWp?=
 =?us-ascii?Q?K2Luia9FXWjZnyqsCt1AwdBbeZ5LQj8xUuW7hZMgPJ9pQMSOzr52ZyhQmO9d?=
 =?us-ascii?Q?o9szl8B14I8WorGX+eWQttfGOuIxWkQcvdXpTjM+g9GR69iKECDjKieJS5BA?=
 =?us-ascii?Q?N1I9NHIUfh4Hs9K6wKSNhbP4XqPwJKz5yDlZJ1ohTQItkKlKIpa15hievULk?=
 =?us-ascii?Q?xwX/eYPE5pYj7ybqAEMoldQPVSAb83WcsHvdrkjYRlGKikeXtKQRQvC5Lu4B?=
 =?us-ascii?Q?4PwAddbOUEEzAJJEfmnWYD0KTocRB3JpEdiS0sYQ80OcwY8DAyNqh3fzM+oT?=
 =?us-ascii?Q?MddDCOZ9aOydkm+CxYcjqKUVcH3O2w+20gEh8kGKYZny/QXPqVZTXxHjz/I3?=
 =?us-ascii?Q?c99s5mKFaRigchxKNb53TLCxZwBoELBJiPB18oVQVy2hg73//tAdSKSbTvWE?=
 =?us-ascii?Q?uv6DBNwFV92k6aDjsXSdt/WEoxuGYNtziUiFm1QXzk0P9DHnNVL6Y/OUXw5A?=
 =?us-ascii?Q?vGOesn/osqLFv4YVMSLk5J8xw7ok+kW6bZAQ876eV2pA9yx2wvI3YKl8o9i2?=
 =?us-ascii?Q?mSAfCZI8ZKfOKxaxZ6vzMF0v11SqbA47Eyr1utzLrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9vUEw960h68DAgNDfQngOZCpx1qUQ9SsxY6PBkUSXh30BpRNGn4aILKQLSoF?=
 =?us-ascii?Q?pPolChQVKooO2AJb8VrZIyBnyF61jOqix7upkwR4uW2OXI+pwUgoKTCpaMpk?=
 =?us-ascii?Q?7IOkOoQ4IdjF4QTie9SC7hJaY+4Oy7cua4pgA2eoESEpkMJUasJFRlAspyxV?=
 =?us-ascii?Q?QCJUYZf4fP4jDCmbAuy5/BBliOZ6QJQgzYaN2/9JJ5EmKExwuBampqK+mZfA?=
 =?us-ascii?Q?iYP3WHnbyBkX+8Wl7pkMGaRy8SHyGm+BOUSYGv1bYdxgivvNXHobPV95c9mH?=
 =?us-ascii?Q?8iSzBGd7CvxoparFbACbdgj4mGB5l5aMS7Qc0mshd+8owffsXhqMqxu3msvu?=
 =?us-ascii?Q?Im/pgF5k1erBO9mKmoRmkq/wZOWAZQR1tVh/vtkjnRq+I8lhk0X75bMx/WAk?=
 =?us-ascii?Q?oS0A18XlI+ht4f60ToF6eXtQhQCYD+9b+zrqTwC7wSPV7GMVDwSStKRCGTtl?=
 =?us-ascii?Q?k5CEfkbKXFgGPGSpP5ylZvzHcDRgbcEgDaZQ7j+dqV1eVzNzAxFzS8R8SPtc?=
 =?us-ascii?Q?AEYBwMw4hCZX3H7giBCDMgUq6byw+YF6nAg7RtX9hmU/QQFja+ZGChtK5GP+?=
 =?us-ascii?Q?RfMr51J7ulpwE9xsXLLrt3uEZrAnLOziiWCuIi+VtvOx/D5MpftcaZu+IJw+?=
 =?us-ascii?Q?j0D6A+JpL3qCwjbaXKQGCbQDZZS3X4EtZmElu+kzVAoSqkXpq4vpj+nUDCKE?=
 =?us-ascii?Q?z6vGE+5SPAy3ixS7z4wUF5Ga5OK2/FcKyw0bIFh3W0xKSRSb2WQBLvb4IgbY?=
 =?us-ascii?Q?yNySvv5frE+gZtAh7eOAKCdtTXXxt0NLNR+6YpIURpD0m4Sr7+LecH9UiZMa?=
 =?us-ascii?Q?MQSqdt1VtFKblZ7chQ/DPqXxhQBGwGD3Li5DYEy6PMCoqg3BipAW7quMHkm0?=
 =?us-ascii?Q?oXoFHLiaUDUXpzhGu1CCrGnzujZJZ67ALGCS4tvrQaAnDcfzOr15dWwFQfmH?=
 =?us-ascii?Q?GOxBMbnQSH344c92WZtFs88r6mHcRH3Try+be330RsdjZ7fNq6xMxl4tAq8P?=
 =?us-ascii?Q?G8WB+dN6LtgzyqJHx5eXz90ovg3wdUsOzPfgutnYN5nahU/8EAz5RSfTk2h0?=
 =?us-ascii?Q?vFC0BAY8zA8KV2hcHfRU4ECegeeBsWx3+CNSKM36a+a3qsPtAmW7HWJTanQ3?=
 =?us-ascii?Q?bEOehS5/RUnsHnE6JZgtGEbUZeyeQ0XD0BewuAHRcPqHxHKAWF61pc98aUqp?=
 =?us-ascii?Q?tQ/73Nh/FJE0aOwPs1KOoPDWzE8naUzWsdkeGA7oeeIoXsvRoS4h7X8WM7RI?=
 =?us-ascii?Q?vfz4smNImF1MyPAqd3oJJ9wqa6PaZGOr8cH04NVICHLeLaOw68myEQTt3IBy?=
 =?us-ascii?Q?7QLqQaqgfYXtHHUI/zBcSdc3179Q6bxByzRMGy2mlhUnof5liTTlt8pfjS3z?=
 =?us-ascii?Q?Zz8NI9dpi2CVm1ycAeaOqQj+2PpVOWTgsmFnk/KBqSVKiALZyXOCZf/XPa7M?=
 =?us-ascii?Q?PA4sodoNY7BKHgSDdFY0xhJfosH6EmW4C4U8C1HlN/1xakg8eI+noo7tjXoh?=
 =?us-ascii?Q?MEUkv6MzjltKZGPE7qZClpJuneR10GA2PSSwMjOPsKpEGBTabUnQ+vExeGpe?=
 =?us-ascii?Q?gO/o+Xnu7uJKdIWL6cxhPUKcWh1AU5w3BV1yEQ9w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c794343-5819-4dc6-bc32-08dc72949135
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 15:02:39.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNFr4lQ7UFSAb0iVf2snXFTQ7XiX3zrsNoL/lVUMgnvS7PneZg92lo6cfxxOsHJ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

On Fri, Apr 12, 2024 at 08:47:09PM -0700, Nicolin Chen wrote:

> +/**
> + * struct iommu_vqueue_alloc - ioctl(IOMMU_VQUEUE_ALLOC)
> + * @size: sizeof(struct iommu_vqueue_alloc)
> + * @flags: Must be 0
> + * @viommu_id: viommu ID to associate the virtual queue with
> + * @out_vqueue_id: The ID of the new virtual queue
> + * @data_type: One of enum iommu_vqueue_data_type
> + * @data_len: Length of the type specific data
> + * @data_uptr: User pointer to the type specific data
> + *
> + * Allocate an virtual queue object for driver-specific HW-accelerated queue
> + */
> +
> +struct iommu_vqueue_alloc {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 viommu_id;
> +	__u32 out_vqueue_id;
> +	__u32 data_type;
> +	__u32 data_len;
> +	__aligned_u64 data_uptr;

Some of the iommus will want an IPA here not a user pointer. I think
it is fine API wise, we'd just add a flag to indicate data_uptr is an
IPA.

Jason

