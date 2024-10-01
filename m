Return-Path: <linux-kernel+bounces-346571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EB598C60B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1E51C23E12
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7585E1CCB3F;
	Tue,  1 Oct 2024 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ew1EKz2w"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D421CDA11
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811007; cv=fail; b=VYz/LpOEcFR4bIvPLaNox1d1xcHJ3FeZzX4VDVTUCP8/DTYtHBmXdVDkOl1cSaUfKrBi9VStj4fNNsf6YtZQp8gl92Bxp9bIgly005CB5UFVaMTcslzt8Qv3GL3FOE3w3/aOcwagYnVuE53nSOALaoNOW7Ke9vSDULmS1j5fe14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811007; c=relaxed/simple;
	bh=y8PiW//6IbjFbRHtQad0+nmE95N/zh7ihL7x9/ru8z8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GojmCjnbwz8N5lHEPLTFF3pTWq3g5P9PYIVoLRn2rt6fzEBxrpDfDA/t/PTCwMeYsWorz96PkGaDofP/1/Vmhqz8pw37T39VK9WtHolEgXiy9/ajQgxlc4gNXfZ65/0ExemZxuIPlelC4vO6PVXmaaH5k1N84nIOGVrGvBy5Zxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ew1EKz2w; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUVf/Fj8UQBElBY1KtBXK8isI7gcicYE4hIGMsk3MSICJQfaYBDfsHpjUZrSKbBx9KrEZa375kqee87QmrgXkDOgStxFt/UpLtDBA96lKVcATRHlI8MO5PB20kOMQgfvGvpZKDdtotakLEnFnj/7tsC0EThHhadhIjpw77EgzjGiAHl5YJOPCkBDz75k9lTWTts2BsK3Ewb/4BIEv+YHwzQDdJqKZ5hy6sHygNof0IWchn0S2Rj+BO3rrZSkawHe2xIUESZsk5Z1/LAePmdvhTkGgxWfsA2QwjWtXetqelNlIuXIkQD3zOmqSAIa7G2fhI3SQJ3vs3akU7mWEt9bbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rnDQjSRjsjVBwmxoz/Qa0PWFc84V4qisyEse57pM2s=;
 b=waH5Rluf/KUqqjS2xPRk7g7VFOceypGAYgZBgBcJVZ9Z4pcnv/zN9ABBpYh0F3csezNuXva5BwR1AqPBoWaKWmQIDQ7Pgz5jjo8PUtmwKOfgU3tzNGDmLXO+lJgoHLKujG1qu8Llll9sWMkN2EQH4feuFiclbzBRqoWRuNbvYdCLOIlEgI5M7bLpvwr/Ez390QUNGa5hTo7qy2GcQRpkTj/WNW/HFSSQqZlcvVXYLumeCOwhivdxhfcvJz+QBPl0lbYJlTmHqInX6XHIwYiNKrKYa4Pa5lQ+p8rR5t3f8k1kYxy5lNDTxzY9znW7KmZ1xAVBwNO9vshAGl2GGWz/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=os.amperecomputing.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rnDQjSRjsjVBwmxoz/Qa0PWFc84V4qisyEse57pM2s=;
 b=ew1EKz2wU/xzHIVHHiZxUSSQMNxco0SlVk3AzmPgXrtBp5hXp65j5WKlFW6gKYL8iYEjSNFIfWm5yJqYkJp2z0WQAd6Z/zwbnp/BQI3Lwm0PqDotVVT9rOH6tvC5r4ciFGhN7fgnt7PyoVUJCvCZiUovRojlHH8Abbj8XKgGGSBEka1PtZgksAY7zcXxrO7DV3bu6uMB1/xkl35LO5ShnNJcfM87776zdwEzhUaQYgU4BDJ61b7r7a53U6pT8ybVCuC8O3HY91V1kHAMapvqqqnLtLOb24hK13/ApZycaQniQlCzr42nLPR8Kz27S5cP6PZ+S2hujv/C+WNmkivUQw==
Received: from SJ0PR13CA0177.namprd13.prod.outlook.com (2603:10b6:a03:2c7::32)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 19:29:59 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::d0) by SJ0PR13CA0177.outlook.office365.com
 (2603:10b6:a03:2c7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 19:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.1 via Frontend Transport; Tue, 1 Oct 2024 19:29:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 12:29:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 12:29:41 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 12:29:41 -0700
Date: Tue, 1 Oct 2024 12:29:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yang Shi <yang@os.amperecomputing.com>
CC: <jgg@ziepe.ca>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
Message-ID: <ZvxNo8ZWeyBOBU8b@Asurada-Nvidia>
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
 <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 58975810-edf9-46ae-0898-08dce24f6fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZwkorAwDy1zF+hj3UnM8zlcpk9w82FOCzNWpGETR29vzqmLLpiadqCAWzEcJ?=
 =?us-ascii?Q?Sv3G6EZWzOSxE5hD7o/RedLnTKCbb+3/8EL7i3/cvVa8ORIcyPvq+jfj33gv?=
 =?us-ascii?Q?XZZNgLWEXaREV5TTVN1i/e8tIVhWq1X6qFWNC4Pa133DQHlu4sWP7hQbFr4l?=
 =?us-ascii?Q?S66QLmLLSPXreV1FgVE2l7HYZFRKzdf2HH5WSwJGO64mYdoVSj1Nmw1FKp40?=
 =?us-ascii?Q?96vZheS1/11wGlsB9AgW1I73fM7QfbncxaJ2tNEWo88mF/9eFsNE4gBhhtKX?=
 =?us-ascii?Q?sr+Z0lqU3ao/i3G602ydwyA7FGkJogfU4vjE7G3EiR1khXnBsMGqikGinXRW?=
 =?us-ascii?Q?8oH1RUepN9YnAJhKbwKNbY54y5RBuDBfi/5WgBNzrIr5gOtLD9EmcYv/UI6u?=
 =?us-ascii?Q?rikqTJjZjj/bY2xFi5zz3v0ZIGzuvOWc/RDKUeY5csTi2XIiya9sC7eaGXDX?=
 =?us-ascii?Q?Aapdek/vqf98CFY5ZgQ2WLkLaI0XFaYa48LjuV46fn8OBX77UhatvE64YbsF?=
 =?us-ascii?Q?IoYVktnuuUnhfMtRfz6WeXaGlXYZZxxmcaXI6dHXJKtAms15Ydw2qtRVDxIL?=
 =?us-ascii?Q?OMPqK3vssiw2wSvZMiLeFVoL8eI+I7LfKcgTjXBtophIM7zTTQidLnCbV90H?=
 =?us-ascii?Q?caoZf8zx5jnPeFlZx6Ja2ECV4Tp/n4b/rsLNmjo1ULqnnwziTtHovFjKDxYz?=
 =?us-ascii?Q?uYhBgmQqvGSH6R5AmaaiwNXEudUgdX0B8yqCcKcHftr5QZXnYJPlDSypct8m?=
 =?us-ascii?Q?RW0MRmev59W4dV7xcV7abvsa3EVBM7HpjW8g3mSFOanDAcrGQPBhbCNXW8BH?=
 =?us-ascii?Q?0ku0BBa7waiYCb7Z0ua+CDeSRkU98RiNf+83fKM9RAWrZwtDeGOlKZUExcgD?=
 =?us-ascii?Q?FCRZZFCyTBxZU/UOk2xlsjePhJLFuhrQDdIjcO2pPi61LiwHuMiDBxKgSnqN?=
 =?us-ascii?Q?ffYa8GAxltcKCvzb9zsh2OxSvQ431OXktjUqNEcXWIETIu/eQilZ0xOmCchp?=
 =?us-ascii?Q?FRI4AuOgGiNg6DGpv1tr2y1CeWr86UtZLmyVmsotXj4UJ+FZqhX6prIsorGj?=
 =?us-ascii?Q?qzjU5xoVyU9MsEwpAzmO6wccbKiGGOSnhpxuHbSZ2lxyMZrkZF0qAPvMqNvi?=
 =?us-ascii?Q?E/+q5Q+pp8VuUMcsCa12m5Dm/tv/RzjDVw3pHG05OVrJwv5kGpeBGoyDRNT0?=
 =?us-ascii?Q?wnXdCZe6tc8P62FtONHsNUhw7unFxlI9prKeFJuxqxhegsnRfU7E0IEeqIU8?=
 =?us-ascii?Q?0rEqw3s6t+SgTy442M07DpB0U7i2NGSCenMpO+TU9bRS27+CxVp6Hh0uecPD?=
 =?us-ascii?Q?KxqzDV+j0uUNc0Nygs1/VzQDGtLXza8IoRS8nzWtGDWa5Q4LCslYz84Sy4dv?=
 =?us-ascii?Q?xjlkmkGwx8lvIHhD0kGmbsJh9ZSTF4hLZl+dhPKEGp6Kj0akRNHvQfzGY86o?=
 =?us-ascii?Q?K2nVumSkQWV4jxlKeMFDKQYh0nsp5djR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 19:29:58.6057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58975810-edf9-46ae-0898-08dce24f6fee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429

On Tue, Oct 01, 2024 at 12:09:03PM -0700, Yang Shi wrote:
> On 10/1/24 11:27 AM, Nicolin Chen wrote:
> > On Tue, Oct 01, 2024 at 11:03:46AM -0700, Yang Shi wrote:
> > > Using 64 bit immediate when doing shift can solve the problem.  The
> > > disssembly after the fix looks like:
> > [...]
> > 
> > >          unsigned int last_sid_idx =
> > > -               arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
> > > +               arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);
> > Could a 32-bit build be a corner case where UL is no longer a
> > "64 bit" stated in the commit message?
> 
> It shouldn't. Because smmu v3 depends on ARM64.
> 
> config ARM_SMMU_V3
>         tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>         depends on ARM64

ARM64 can have aarch32 support. I am not sure if ARM64 running a
32-bit OS can be a case though, (and not confined to AmpereOne).

> > Then, can ssid_bits/s1cdmax be a concern similarly?
> 
> IIUC, ssid_bits is determined by IDR1_SSIDSIZE. It is GENMASK(10, 6). So
> it shouldn't be 32. IDR1_SIDSIZE is GENMASK(5, 0).

Rechecked the RM. Yea, max sid can be 32 but max ssid is 20 at
this moment, so we should be safe.

Thanks
Nicolin

