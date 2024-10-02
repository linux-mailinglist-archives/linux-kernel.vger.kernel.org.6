Return-Path: <linux-kernel+bounces-348153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0A998E367
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F375C283973
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5598212F1F;
	Wed,  2 Oct 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DRx5hpHg"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D151D0DCE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727896996; cv=fail; b=k1mJd4GPr/UeAxCr/bahvIPnpwB1gfHgmg4/vVBmXyGJooMWPkNUZyTeSWRR9FX9kqlOukDhB+oXB74FLW1NYQr5IqgRRau9PqJ4IRs1n372c/ZTj3SvvkW2jEJUvmV9VC15VO0N/LtcwyAojDvAlYpBG42UEXp7gIVrnAELLxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727896996; c=relaxed/simple;
	bh=YGIwrJGhuMTi/G1TwT1bIXJkXTbQeecFWMuuP4TKpUI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOYhRt5MKcGn0uct72lo+5VN7oqxBdBLpQ2E/1cly2bqvhmhIyDA/V/oQ0cVHIa8pDUDuQUhAvBPHcu6BKwiyujcZZ00KUMU0esjk/zUUg07GJ4l2RNdmD6WMSmuLLzIVI2Rj7mh6MqKKfFCCJSNhVxrf1YsVMkF4fKuvwOApMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DRx5hpHg; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdPshZEtUSUgKvxdRIUvO2nSRKEnB+ydqbkptcLd7rtwowUJhhSHLb6KTnbotML14Tad8fKT66TQfuZnn/UEROIjdxSUZRXSPengSzPILCQ5nxjRNGogiSNk9dI2+lbjAWimP6tD1v+zJW0dpSmWo/DThH2gS5lK2V43sT0oId9rYS8agpOnkCpDh7028aEef030MjERArKMgSb7q96yGdUpeu/0W4aKEEHDrCpBnmDC1GHrtwlp4OlwVqg3lgNXEPT+zivakg47WGfI60ko+Eewkm44hRqUFwBrDFV3GvfgDHCQyQPEb0sJbXVYPgKQPIrKsmhG0GuoOpdVrO3ZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIgBwkCCu5/eQFjk2DAVFSGMG+OvY7nzKKDG8GFzEK4=;
 b=L6duPfAM3C02y2EnJJq2R/70sSbxQFXtdAtgkX6wi6WfZoWtTLVVt0djPgiple6hWOt+v9fnJSdp3EZFJO/9IG2O6aOFleIiu+PSfYKG4aT5rfG07XdthLqqu60XRQGN6Q7LSPDIsxB9SD3kjX71ASa8btKnKHTu6aA1M28RZ5WKjQoVA3nX2TEIBRT4kVbHV8u2BETQYUVVNbG0Iq3imYWE7EU2GSuGfRH1tYlsZmUO8kW6g8GL+Da9iUTAQa0AzBzWcfh/7WfCTtATsRDjO66vmtsPr/DHLnodC8vG+M9uYGBtRfSmhgggScmUO9kyNF9FrnK43MuF6+n1JHluQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=os.amperecomputing.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIgBwkCCu5/eQFjk2DAVFSGMG+OvY7nzKKDG8GFzEK4=;
 b=DRx5hpHgGG1parkiaXNPd1joKHva6EbtPxfgLpRErcF6t3Ob7SNuvMzDv4vqtjnDEFTrDbfl9VODQ7+CZFjhiZ6JPIa7ps/4smMg4QJEoH9yDhD/zpovFOJvGNXwvrnSFutJ7DHpuurtmdbfjy3v/PpSKWpD4icxqTnLWvmR9vFWD8PXaSeWSrKP7mXniLmF13YZgolIkpI1YUDbxEt2GgZoaG1d5W4MILP/WIWzDv5VYCWVk21Vqlay7q2KWtSWilBdHGEynmufzjgpt/guI2TBZuyC6BmAb3KDc/S+80Tm7F5AJiTB1yA1JKOmM/a62voLR6QtMFdmO/eJJ4cPqw==
Received: from SJ0PR13CA0143.namprd13.prod.outlook.com (2603:10b6:a03:2c6::28)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 19:23:07 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::34) by SJ0PR13CA0143.outlook.office365.com
 (2603:10b6:a03:2c6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9 via Frontend
 Transport; Wed, 2 Oct 2024 19:23:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 19:23:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Oct 2024
 12:22:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Oct 2024
 12:22:50 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 2 Oct 2024 12:22:49 -0700
Date: Wed, 2 Oct 2024 12:22:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yang Shi <yang@os.amperecomputing.com>
CC: <jgg@ziepe.ca>, <james.morse@arm.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <Zv2diJDU6v60hKtU@Asurada-Nvidia>
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
 <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 051fb762-1a19-4d34-63bc-08dce317a519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FfOfHlWmu48j7KQo3zf1CEdjylmAzR1dU+0xbeuofhCVcrK0LJ0asDaw+ZXI?=
 =?us-ascii?Q?7yXhex3T7qJ39vYs9QYpjVc/4h2PHGMtedAux4DU+9Py5u/GR37PV0C4dIko?=
 =?us-ascii?Q?rpuqPwCS94WPzeGfIwyBiugWJ4aXR4+4w2GpgOmbqm+jI19nSE/foOE4O2x6?=
 =?us-ascii?Q?uiVMDu7g/7+P4JKqmTVTso4PJIFiazCIJIqF3jR0xsoTlgCEC88QS6EZAkSC?=
 =?us-ascii?Q?9K6Xn68z2JomBPkZacdW96eYrkX2794kn+CJVBv9SfBiht5cnimh5iXLIdKh?=
 =?us-ascii?Q?aPP5jOCMRuzWuP3+GaBIMl2qU7Ot+0iQ6ibHypaGDcMOzijvr025FGNI6ItZ?=
 =?us-ascii?Q?EUqjPyrZcVoFCgul7fryGOF7ZAGgWAJiIeesG42FzCAbveAn9rJoUhZcPMRD?=
 =?us-ascii?Q?Hs31FesDlJ8MMBgwSO7vr5DTOWTrpMeBDECmPI7vHhyw8Van9o0KiXR3Yfs1?=
 =?us-ascii?Q?AX2cTkagaPcEPsX44HHLhZepsO2Pno26yrXdnIbs0uossS3A+d22r2QzGFCx?=
 =?us-ascii?Q?Eqg26co8SLqVGJ0eUEAumXeVm/H4fo9UzNExpS15vvF+iByAXYrddDNJODNs?=
 =?us-ascii?Q?Snc5p4dJX/Rqjj3LItHooQGwvpxQE8qn/Yq6BCwPzMM+RYNiI87IsktSYcUB?=
 =?us-ascii?Q?JhapkqBlPAeM4jbtlRAfnp7pkOWT0C+DKjhXtSLff/kc1tqZWWTSod4qeXm7?=
 =?us-ascii?Q?KbhPO/YBnXBpcH8mDpn8gsYdCKTNX4m2qaXL9XgsDAf9NoNcbEFaTRiwjZos?=
 =?us-ascii?Q?Q1rePBMLzSL0yPdiYur5faqmvysXQL2eo6GYochiTG45Yv6vcqp7LJTlUxit?=
 =?us-ascii?Q?q/Nl9X+iHLguv0dZ4TzwOQcj1T56m+YpL+iXYwhtZy/sV4jSr3JVsAbutHqu?=
 =?us-ascii?Q?kmENNoOQGgX1oVHhmz4LEoyRSudId4BgEM9vl2tEEPYKv0Iwp9crdvtbCCtN?=
 =?us-ascii?Q?uhxKKNIE6xFNJyqJTmcIGdorndPGTmCch7Ju2iObw9JORtvHEcG36KY3sNLt?=
 =?us-ascii?Q?aI456OC0nDu9oGmJsn+ocfvqZUTGS4+bYwLWF2ZDz9cnOf7/buyClL4tzk6F?=
 =?us-ascii?Q?JfY1/nLYkbRbMMYjuA2O/SqZzkUDjB2BahGTiu+frSC3zTsABvxxBwd6dSDj?=
 =?us-ascii?Q?c9b8j27rPG4U673sFzYIQV250GB63fBw8z9S24FJIjh+bQKCAKe4n5ohBEM9?=
 =?us-ascii?Q?lTR1VkH3CMWAAI41lKRSI6AbXpW+L5NH4r2RF6dRGWFcYG5XnI8Jc/fmTPIR?=
 =?us-ascii?Q?1r5eX4v3RFntM7B2uFmq82dtgvw4sjuj69GIv7cH7J+7Air0KPSMaOJYWmSZ?=
 =?us-ascii?Q?bQUVl8RoY+0NzcpAmiBdy2Z+0ji6XrIleVqUuqjVLED51ZNLdny7h8n5Cks+?=
 =?us-ascii?Q?7GKnoHk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 19:23:07.2644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 051fb762-1a19-4d34-63bc-08dce317a519
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346

On Wed, Oct 02, 2024 at 12:04:32PM -0700, Yang Shi wrote:
> > On Wed, Oct 02, 2024 at 10:55:14AM -0700, Yang Shi wrote:
> > > +static inline unsigned int arm_smmu_strtab_max_sid(struct arm_smmu_device *smmu)
> > > +{
> > > +       return (1ULL << smmu->sid_bits);
> > > +}
> > > +
> > Hmm, why ULL gets truncated to unsigned int here?
> 
> No particular reason, but it should be better to not truncate here. Will
> fix it.

Yea, and looks like we are going to do with:
static inline u64 arm_smmu_strtab_num_sids(struct arm_smmu_device *smmu);

Then let's be careful at those return-value holders too:
-----------------------------------------------------------
static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
{
	u32 size;
	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;

	size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
        ^^^^
        overflow?
[...]
	cfg->linear.num_ents = 1 << smmu->sid_bits;
                    ^^^^^^^^
                    This is u32
-----------------------------------------------------------

Thanks
Nicolin

