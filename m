Return-Path: <linux-kernel+bounces-246486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839DC92C293
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A87282C9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A0157470;
	Tue,  9 Jul 2024 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ir+9fs7N"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530B1B86CB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546460; cv=fail; b=nDvnQN4Lp9q8RyvtPnkbvcUD7T9p01jWKrDgyDWc+75AuOFWCjYzobwASYQ/QJwG5CdK9dZgidKVCqTVkqMJGMT/K/Axf5Z+EEbo6nAaLraYlJd0jYzkYSQiwLmTQ9G+babRAQXzyPqKDY1U7imFMvmZErKGn69PFCoBH7xVQ2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546460; c=relaxed/simple;
	bh=zygQOzi4QlKTF9PHuni1youCrpXjdauMmuYHIM+Uzkk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0sdGL/Vc9S5uhBBsEE3uBBGYJWkJ0zrnF3zi7tVFqvSJfZugsxQkyokgOn4wj+fqXSIjB0c6NiK1ClYIulUBmCcmHZMC1wI9E96OvlAGkQ2EpBWv4ekAUTX5TQ3Fw5sKvWG6VYmojDq9LIFGylODG5+Xx/FczdWrBcv/wcVchQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ir+9fs7N; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrM+wlYwmezn6D4P+gXYpcdSiJ5HgUfgf5ZDx9ORrcWpdmZlP4ePYZVdYbDhPB+7VdDU0uaH/gn/PHEwl2XFAwoz3xh3dw+BbBB0F3wXZnlRGf5y7/AkPqzztT+/cwUsatJlCGu/XG3Kt2hlulmBX8+QPJquQvlOvCqjwCT1iU1qNd+IfHfdNcE2vQVqScuHT5OlJGx3y6txlb8P41ryts/vjqpqflGWexAPVUZH0bZkDTiC5gvQvv+mgCOUfxS/wsmXSCNCx/QaNtGYgiOWAukeGmad2m4J3IQeTrAkn6vpC2iCIX1yyIfai6DhDSxCXShxSyE1ZN0Wnu7WoH6pIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bfWD5G1ux3TVzdzwDEYR3UF45pBLdztoq8b8RLtdzg=;
 b=jFnN0PM0mf3tyCWacqsOo1icMutxSjh+YjYpoDTtMcGTYi7Y5I1dEL8KjG9PPdNAJ0GhM1zUcFojNXwuMEunv7Z6lFjnV0yrbqm5BHlOlMTR9H0c8x1IkApglccA5AyxN77Vq32idNKuYmDcKW8W2dK8Wp5VUzy/Bb4mcrzqHsHExQtT1IDRyPUL3zc3UAriuBGLSb1otSuS7QuuDyEjrDsrz/swkZWOPWgvfX33cGMGt0O54MHnW1pJBhee6EqmqZCLg9x21zlqYQlo1Jm6u14+0YHQdeVZNpI7h/MxunpVdBehTybLCMa0O3O8hGuASKVM6XY3vHlcnNgTBHc71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bfWD5G1ux3TVzdzwDEYR3UF45pBLdztoq8b8RLtdzg=;
 b=ir+9fs7N9FB5cQTzXOJFHaRy8+jC56P04wrfJakM0bYr19jwzjRoVmZsWYVxCBdP2gBTK4vVg7+2xMrP/rcgOjwNgsVlm+GisbIWqFkEsj+UctQdMD+VJDi736zjbkoTpu1zkll1PdhOcwMa8AaVJsf60Kwcumcvl+9U3um+qa0z/ZJqtqC9+NkFCLUHyOQ/xogVhpGNOYrIG6wuJVJNQVazWJ5JrtujOr7OCW1808mDs51MXaNIPWSWn7VCJWUbjPpuQM7wrPcfGkxelGVDIQh7G5OMheOW4MEXhTym1zgGmtJeJubGcFOG9TyRBViAHRqhmyXVLIXh2GYFcXahFg==
Received: from BYAPR07CA0096.namprd07.prod.outlook.com (2603:10b6:a03:12b::37)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.38; Tue, 9 Jul
 2024 17:34:13 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::a8) by BYAPR07CA0096.outlook.office365.com
 (2603:10b6:a03:12b::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Tue, 9 Jul 2024 17:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 17:34:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 10:33:44 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 10:33:44 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 9 Jul 2024 10:33:43 -0700
Date: Tue, 9 Jul 2024 10:33:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Yi
 Liu" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Joel
 Granados" <j.granados@samsung.com>, <iommu@lists.linux.dev>,
	<virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
Message-ID: <Zo10duoguPCADKSY@Asurada-Nvidia>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <20240708162957.GB14050@ziepe.ca>
 <ZowxyUQAcqDJ4yZ6@Asurada-Nvidia>
 <20240709170038.GG14050@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240709170038.GG14050@ziepe.ca>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 9812d138-3028-470b-fed9-08dca03d58b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Fjk6ewiMs0j6m7YIXjsTdgPAoPLv5FncMAOP2ObELnNiWr3R/fx5RD5gaLQ?=
 =?us-ascii?Q?UBXuI5uCtG5sDmYiTXvPDtxHuynYIxLd59pezbhD34SZoCjzQ7mxI7zBMazH?=
 =?us-ascii?Q?1NzNdCJIQDICedjjfAS0jHoC1w859Jin1TE9eAMyLxGgaxn/6kozDnFzyzZO?=
 =?us-ascii?Q?fDH/Jzc9IPXkditphAyOImKtgJyS9GqtCdpQEU7kx3RposBRshYOLNUtcK+6?=
 =?us-ascii?Q?AEgH6t6Tc6s+aOIdzg7MH+2orXVHcKkZWq3dShVGV/J1HxIm0QQYOMe5EYH4?=
 =?us-ascii?Q?cU4qTNukSoHRWi7h1fVvyPPlmk/PAYSVQJuHXTofiV7lJNwIQdvkdMmGqR28?=
 =?us-ascii?Q?ehBi2eHKRWHs3K78ZWxz/aQ1qWlPWK0P4wpE3o261QzWxE/mycwCIfpJjXuA?=
 =?us-ascii?Q?1O8wkzoeBB70EBp3lFf8gAZvrAU7OXNiDzG/nsVquq7DYyNEUQoX0DI0p++t?=
 =?us-ascii?Q?zW/XU1dk+nZPjvBsCj4YpD34qPbGLakyVZuHPBIHKlvijm+vvTE9XkU/RjaK?=
 =?us-ascii?Q?5eSV58mlR/GwODycehLYRNyzVOJ9L7gG5HPTdGsrhNCzG9T9ZOXOJ7HBt1MD?=
 =?us-ascii?Q?BjLhIt7JzGp2GAHRiBYvuv8wiRTr4lnPbgj5kTXSV8KPWTm21ZlBAlDJ35rc?=
 =?us-ascii?Q?NSylXWnnKf8hBqe4Nf1CNdzSoPiPUXiitqRN/guvtwG9qWg1j2MMi8yLYy1g?=
 =?us-ascii?Q?n8p4dxuCIHYUUMTU22KMzyQ9SeAzfnOWBGrj1Uidj5S3G77ISl+GBfFjYFrL?=
 =?us-ascii?Q?OYDUm1dJUPJFqlyKkfFj0lrvYDmB9PY9ge+UjWhkCEXbHZRm5Y+mPp15nX1h?=
 =?us-ascii?Q?Djr/1RtNFZ0IO/VmSsByKda7mFTxYmhsTdUEuBmvyVQfTfghav+amlYha99B?=
 =?us-ascii?Q?q8HHKqVTNY6LnruSxzIpPupgpkmbmRuWSi0DG+aqlyY4Dg4WiR9ivSBYoIVj?=
 =?us-ascii?Q?0n4UNNdCpcwkzzLHI1G59ensJ4otL8C5omrCf/ToUEAcApimNSC0b8r1IfFF?=
 =?us-ascii?Q?B0rTF3Oq756F3jLEC9klYWH/Ps/DSr/Xz9zR9UpM2IjKlvsAZ7U258n5p+ez?=
 =?us-ascii?Q?Pt+IsiUanyCsP7rx/AUL0/rLr8Vfx9IqSoEqEcViQKnI3dgxQ/kTtX4YQxaJ?=
 =?us-ascii?Q?g798lQlzlIG0c1j3urgwg1W+gWaQla6XGTpG1XxS6g9tJsYotdsxCnfb5sHV?=
 =?us-ascii?Q?SyXpD0cSIg54q9wuw/8NVLFWlAhNVRPbrigjfXL40hBH7uEUJOrsSPPR3YKV?=
 =?us-ascii?Q?VDtYTzSw8ZqaTFWAEiOElmjIgvYYigT1P6oduCHOoajQG2rNW5uK1djZdsqA?=
 =?us-ascii?Q?u6mVyWcn3K4+Ww8r/nILklnytGsCGb2rhJbjtEY9tspkQxnnIMPTuPCoPDgN?=
 =?us-ascii?Q?pLNyaCVv0CrhBFrGdfgBWiZ6zjYZalh3ipUiEf2jBME2nSKm8wNo80WdLQz1?=
 =?us-ascii?Q?Q4f45Is14QTL7cdxWnjE1kPeV1Oqbfxb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:34:12.0536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9812d138-3028-470b-fed9-08dca03d58b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181

On Tue, Jul 09, 2024 at 02:00:38PM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 08, 2024 at 11:36:57AM -0700, Nicolin Chen wrote:
> > Maybe something like this?
> >
> > struct iommu_viommu_event_arm_smmuv3 {
> >       u64 evt[4];
> > };
> >
> > struct iommu_viommu_event_tegra241_cmdqv {
> >       u64 vcmdq_err_map[2];
> > };
> >
> > enum iommu_event_type {
> >       IOMMM_HWPT_EVENT_TYPE_IOPF,
> >       IOMMU_VIOMMU_EVENT_TYPE_SMMUv3,
> >       IOMMU_VIOMMU_EVENT_TYPE_TEGRA241_CMDQV,
> > };
> >
> > struct iommu_event_alloc {
> >       __u32 size;
> >       __u32 flags;
> >       __u32 out_event_id;
> >       __u32 out_event_fd;
> >       __u32 type;
> >       __u32 _reserved;
> > };
> >
> > It can be "report" if you prefer.
> 
> Yeah, something like that makes sense to me. The other question is if
> you want to multiplex the SMMUv3 and CMDQV on the same FD?

I think at least SMMUv3 and CMDQV could be the same FD. IMHO,
a TEGRA241_CMDQV type VIOMMU should include all the features
of SMMUv3 type... otherwise, we would have two VIOMMU objects
per pSMMU on Grace, which doesn't seem to make sense either.

> Or multiplex physical smmus on the same FD.
> 
> We are potentially talking about 5-10 physical smmus and 2-3 FDs per
> physical? Does that scare anyone?

I think we can share the same FD by adding a viommu_id somewhere
to indicate what the data/event belongs to. Yet, it seemed that
you had a counter-argument that a shared FD (queue) might have a
security concern as well?
https://lore.kernel.org/linux-iommu/20240522232833.GH20229@nvidia.com/

Thanks
Nicolin

