Return-Path: <linux-kernel+bounces-346498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080098C54F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1418828717D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BAA1CCB3B;
	Tue,  1 Oct 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E/90Z2sN"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8BB321D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807302; cv=fail; b=hVqCigFkpsNRnGJc/zfmKaKvl9l3pfbRiXotUYIfx07i0UaNIJv3mL1vxxPVKGBOD4sYiRb2jianxIBxuWxmR704/nVZmktdM5CZZ0BNp9N89eyFrTWX698kGvb/azZuK9D/p/E2N2d/ZaHXR546nTuI97LlkJjHWKV2sLtA6l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807302; c=relaxed/simple;
	bh=jzbXk9PogTChHnAgvKeMgeE+SthSW0IzLZWFCxwMnj4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVMiEyH5DgDtOjm8nnMZV7ELwLA4PXye3HhkGpEhSs1RmqRSa5Sngfa7NvWB7kDA4YV+GRBcmjGbd3PbW1bXxBvDrcz0/z/lZOau8YfOs4znw1MiHGFkJuCuUbzuy2vNpzgVFLe2J9wq8kBEunYmwT6PiTbRDcwm3AeaVNpsZsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E/90Z2sN; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Idpt7ACqwSgKLmIAuX7lbULr6VeKF4BDuuIpbrgnf8sahcziYP8p+mk4Afv8tqGZh7Xzm84Nx5SQhYPUrtmRufVP7E7VYtiGAzxKLlwnz0/WUrHL4K4Uo0bjIw/pjIyYK5WZM6b9y0O3Jorl0xBg4kkDw0ogBLDX3y8AFWOg+8cEn8APXWCnocXJ/jk2Ig4mzuh5m2Ys1/frq4aRY+/y1qgUKqeEEaOZ691S+VhRR2uASAI+KUhLPZSo8Vm8MgvXviWJNafDh0iJbD0FBlho+wEO8ZyL8G1SV2GbNNp78wpK+giroNpUA/rXYWALDXZBHZ26+fCBZQvAZbtY+IGD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLzB+fC7s4ZTjL+88fUsgA6ZfRx5D3g3PUBRp4cU2Do=;
 b=VNs9/kEchgTfZtgb8oBFmY2Ahh0XTYFe+rD4+HsreTH9FAb5jD48YLRlNfHE3VO7/lHSgUtSiPoMOS/e8AqA8p0Y4r9gYFcz+mnLTCKENaO+6Cifz9ZgesihI/D4l1zcqEVfwbGA5T1zoNJ7xZEeaMP53mRHR40RS7/Av42mfWeZFKZ+SuGtHfwQh8UJDf+ONud+8we16BO0ScuhHrbQq0QbJ2IM3hDdXMQG7MgQyjB8fPRlfg/w32xQpVllwVvS6MlI6pHGLGz5EHX3S7YlhvxnDCdGPIg73cMiJdUsrLOzRsVIDHm26rkkxq36IEEq4vyOvKxztBuYo/hqtGiQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=os.amperecomputing.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLzB+fC7s4ZTjL+88fUsgA6ZfRx5D3g3PUBRp4cU2Do=;
 b=E/90Z2sNYP+ajUoSRYiAkCyEzPH3CT9G+39HH0mYlCmuzqa2WyKLmMTeSeQ0FylqHouHce31s82vufxUAamYaa/DjlSBdB5BX/TgF8c55I0OwadCubYigDwSGl4IlnyWojmY02wm1ZgS7dsB6ouIOO5eQ5zONvXpXWZcV7y9PlmnGqySBzeI/6UEHjImUyUnbYJ1AY6YCkbJnDEeMJHsQjd1SnyykKIMj+Xp3lLdcKA967SXKyBnD9LBzNEj3EeWCYDZAelX9CrMcDwBHCpOdXnHYn3con2uZI1cpEDD4BdzXxFPwG8zQrsF3Yyou7kwbZpC9FonSEWd+25J0vwzmg==
Received: from BLAPR03CA0113.namprd03.prod.outlook.com (2603:10b6:208:32a::28)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 18:28:16 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::60) by BLAPR03CA0113.outlook.office365.com
 (2603:10b6:208:32a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 18:28:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 18:28:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 11:27:56 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 11:27:56 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 11:27:55 -0700
Date: Tue, 1 Oct 2024 11:27:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yang Shi <yang@os.amperecomputing.com>
CC: <jgg@ziepe.ca>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
Message-ID: <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001180346.1485194-1-yang@os.amperecomputing.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a943f9a-e793-47e8-40a3-08dce246d0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?etfEy7QTtdNx9RjbYGsCG8mX0SJqdTmEhu58I2RqcZJj1PmVr1/2Q87bV1lS?=
 =?us-ascii?Q?xenOyqknSJqY5mSfu8bOpsadJ5woPNCiKSSDA11BVfVjppy+UfSvAhMkS1BU?=
 =?us-ascii?Q?suIdWr2fI9lPa1nouYSX+5VQx6b4YA0GXPgDcN3sQue00wMigXfCCmvuq0Oa?=
 =?us-ascii?Q?/sNGQmOxyzheXJj+J/RIuXj6eRT2K8DiClfk2x4TFZn75O6Xd9mjgw4vM7QF?=
 =?us-ascii?Q?lQsOvv3H7/+vyb4voQbmvPo/KzhTTxV1ITWtBsPH0qTLlAxACgpiQO2NtBLO?=
 =?us-ascii?Q?CRJ+uPXIrf0kAk1Mw5li9+Tgis6sc5SHe9oRE55ksiPBtR9oMUt9pqB60FJl?=
 =?us-ascii?Q?DevXjLeWVsaXu/4okdyeFh0hNZXVPcfg9escnIMwpE0G0D3l2+X+LKIK6qSI?=
 =?us-ascii?Q?VMYBLoCOUbruxuGy3l0dFYKr9S6nrpq5a9r0wXM5J7WfnJuRiI6+HjFCjpBh?=
 =?us-ascii?Q?EuUE2abXZwQ8Nz+qZjMoAaTd/PkvhKarhy81M6H0+SpI6cQGM4ormwghfOuh?=
 =?us-ascii?Q?F5n36OqxBdVFlQaOp6Mi9Z3uHE1+Ia6ei9lCPpl6S4e+qZAK4BLiIAP6DURM?=
 =?us-ascii?Q?P590QLI1QCVErZi4Het4iId80xHULoY50P9GEDNsX8bt6eU/tsRdOjho8Kkl?=
 =?us-ascii?Q?Nny6ePtvyGCdEIC43xCIZT/8bte7wdlyfNjB3h38XYNHAHwQ/rbXLMcz70mA?=
 =?us-ascii?Q?2Lu0DXDRjmV2qh9HdbsdmOx1MzhJys0QO/9+LOch9Lg9/OBkqzsma8vwHgDE?=
 =?us-ascii?Q?isxsNQlhZMNnI6e0FEiIXp4fcb+qlmvBhT8vAeTJ24DVK3PE6N6RA/UGIClj?=
 =?us-ascii?Q?km/PzKFRNF2Fz4WOfZtpObkA9E7+KRP9mTAOKbTf+tHp80XIgAksZh1uCnWg?=
 =?us-ascii?Q?KPkPgCmkCM7FJ4hOVfL59atGMZ9HXLCal9mfT1uky97QGbxuwl1dGTQRMP5d?=
 =?us-ascii?Q?IYzCywHRqlPEHHrAPBtmYL7jFRhW7Av1lHRxk2Zd8DHfYn4jUv2XR4wl1Lj7?=
 =?us-ascii?Q?cQezZpEZj4h7HcBdDjX9kN/mqk23G9ZF3daTP+UHTiOwVZFpveBUaeMFvSgf?=
 =?us-ascii?Q?/xQ1bwrmi9ys+OQgi4UVRj+JElV6iAm3/TtVu3Q4k7jZ7PnPe2FiwyY4aH38?=
 =?us-ascii?Q?F8Wo5Aq7zb+YySMBRoyt08bjsr3IxeZDxzq8WYjhJ1lLiXLk49L5MEzV46ne?=
 =?us-ascii?Q?8tvi0+vVzGSzMO24+PF9WPFZ3se4UkhpcaOdA2KkmTi4qypWKc3KM8eZnelV?=
 =?us-ascii?Q?lj/2KTPY2BP57/B6clLoyssnpnseRo19uBkcc3OAD4+1oEuGxFrknfPooaOw?=
 =?us-ascii?Q?VE+hX5Z26WSGaOMxv6xRlAMhUNFgXbvZTcgHb8wwPa35nOgcnlDTlZQ+3+KJ?=
 =?us-ascii?Q?yMc/ds/x362ewEgyQ2coKBScmgboHksb5Rny8q9W2RGNYxY8CJLt1+YWTwLa?=
 =?us-ascii?Q?vEB0BcbnKWfSfBE6bkIqRsOh+DSJKl5T?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:28:15.6240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a943f9a-e793-47e8-40a3-08dce246d0ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788

On Tue, Oct 01, 2024 at 11:03:46AM -0700, Yang Shi wrote:
> Using 64 bit immediate when doing shift can solve the problem.  The
> disssembly after the fix looks like:

[...]

>         unsigned int last_sid_idx =
> -               arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
> +               arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);

Could a 32-bit build be a corner case where UL is no longer a
"64 bit" stated in the commit message?

Also, there are other places doing "1 << smmu->sid_bits", e.g.
arm_smmu_init_strtab_linear().

Then, can ssid_bits/s1cdmax be a concern similarly?

Thanks
Nicolin

