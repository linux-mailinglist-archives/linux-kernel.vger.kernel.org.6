Return-Path: <linux-kernel+bounces-348072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9870E98E22B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD75B20E80
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD50212F07;
	Wed,  2 Oct 2024 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CDLndpeb"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB5212F01
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727893068; cv=fail; b=ucP09XRRS84ESIKfbsyK0Qjbx0jf8IyAhLfNWIjpthOUezkzj6btPn2LeRPzr5kMojWfHlyUbePmDpKuEREA/6VDfgCfExjIrFvsgkLM8YkkllFU4F828aj5HB5X6s7PgccvbdwupcBAHL5n3CHawK4zZeQdaUbGlN5/AyDW0Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727893068; c=relaxed/simple;
	bh=jdeHMFyC8i9iCPsX/OXbGuTLQu4Q8osUEcOvzspgQN0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGQZmbKS3WfsQ7Lemgq8fnI823+CBeZp8eIwR/5P8Xo0+8YVg1YfyEe4cLygMA9yO7KEVHtOYF3/AqQIZIeqb8m2xk5wZNApwNiJ6+Ic1tPRBbV2yUzoCU9pSBVFTZTAqq41IaQyWj0hV4NTJH5gcyDeLWSrWKQz8pOiQtzsCzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CDLndpeb; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p96+hdzC+yY5QfQGU/1+nym3OMtdIEM/tCgesmMP2kxlHlcbh7MXnuBvZRnTKucuOS2svuoNurm1OqLGq48dsT4WXdKg61GTnYVivDHYjvf6ptQkLEGBFRs+L3S+QgNiKhp2kgJtm0py34J8LsEPIxvSMBQ9hxqzmpOxDMyuLfr+CcV6SZFKJFxVX3nOzAP45g2J7XcJrYlPlUMvm6C+8MGpfZ0lkzUFULprB29mc4FMLCFI5a8htIFIEBtTz8F4gSO6kBLozEKVHp2URy3ObLq2kKu+4uA8h2ZwQfekvSiEXhY7w+tGZ5wptHy8lHqNfIqIKl4YhJdTKelMqSAzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbTt9V5elJ6YH4Mselh30JUIxe1STZfD2tmZmgEl/6M=;
 b=xAkXdzDv64o27qUhaRvEXk+v2UexaKWY0AOh1liyO1Y5q9bMuEfKy1jAEZ1jJhGE6qG0KtxRysgMRPH6D0K2JST5J/ltlqKImffcVhNSQIstT0xzYe3f/Y/4sObWVHTZF7RqLbVEteqGfjHX7BqvGSt7RpABPqs9l2FjhEJnXUucckYJAsg1aN8vaRI+ja1bRHA3CCF1Ima/uhyiJyDwSifmRr1kGBbTeWqObOvGCL27rHBghuVh7tG6+1GhgEzzwzchB2EtBC24Sk7DKSSjaoyUqgkdfaR5BoOQWPb6yNtZwAmdCqWPqO2DZEz014aMXxD3ZwSGS/zfARoGiR+SHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=os.amperecomputing.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbTt9V5elJ6YH4Mselh30JUIxe1STZfD2tmZmgEl/6M=;
 b=CDLndpeb0edXxDr3TNdlrPNQ/DkJ9S9DmV0S+BfvGsfEzjOhF1HKZG3uDYNeTtCU/0YrUd7fXtsTIpgOlZY7s0YAOYkdZ9lVeMEs2tEjy7ItixKCjVzBscWSrqEJDBU2ttD9/J6FkHgLm73MkmprENRaZqyTd6rDQbbPcGzOby+EHDRl7EKTeZwnjqBi/BhzE62TSycMa8W+NVYb8ZecJBe6eVjXVXClK+4UwinHySfvyayMQiySGofTYAscXJN8PM+57QLV3S7hLIZUVOHEvTZfvRmRjZsNzXQjPRP+tQxfhnvLCRnbpY55PoA5+52L5fPYDK8I6xiGNgcqjDcxgw==
Received: from MN2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:208:23c::25)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 18:17:39 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::57) by MN2PR18CA0020.outlook.office365.com
 (2603:10b6:208:23c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 18:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 18:17:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Oct 2024
 11:17:26 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 2 Oct 2024 11:17:25 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 2 Oct 2024 11:17:25 -0700
Date: Wed, 2 Oct 2024 11:17:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yang Shi <yang@os.amperecomputing.com>
CC: <jgg@ziepe.ca>, <james.morse@arm.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241002175514.1165299-1-yang@os.amperecomputing.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9f660e-5944-4191-89dc-08dce30e7fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K4MnUJ69RP3+LZt8GsdrlHxF3En1veBnnVlqBUgtIxe8StTjslByKub5YgIx?=
 =?us-ascii?Q?KCDm75IRPznbwIA5iHbG7XdGpCQLWIfYk3Ldf0kLj0SWmNKwh+l7aVvNOZQj?=
 =?us-ascii?Q?dAryU20qAqahQejOO1hoZkAe6RHqFHJ+Lj5OIHaQ4pZIPdtd836TEaE0NlIg?=
 =?us-ascii?Q?EWXbFuhZlZ65ReQ8Niige+cpO0jTmM5ga253EW5mx/mekZ3L4NPhhJtiJfzE?=
 =?us-ascii?Q?/gm7ma7xF5wOgjApXa9fLCWjli1uUgZ9IrR0jln2/FS5vl6TyZP9az6mF8Y2?=
 =?us-ascii?Q?4M+PGn+4Z+/kZVmvY4/4vY0sru5z3ng3Y5PyGb713LC+WeDQF9Hsw0IOT0bj?=
 =?us-ascii?Q?z8TMNrrli0E0b670oPYnj3khnqRazG+5fO9aUuQyMAQo5tqu1ogjdBmqs87Z?=
 =?us-ascii?Q?IHJyHw3iqH/cd6xMsL4pmpdrHqz2jc19r5V5FyzCrcFnhbvwMnT7FliMe0sJ?=
 =?us-ascii?Q?EZI9tVXugzd1+zfbAyAOMM4n5oUS8NVa1009is6VIqE72k8MoXEgqkWDQd27?=
 =?us-ascii?Q?5TKC+Paa6vbYz5wMaUa/gvueCEpLQgKeFTyV6309oVhhytPv6K6RG/q8dd4j?=
 =?us-ascii?Q?BKSLFuhiIHG33NgRUCEMiUPN8lr/FvFW4JV4iU/fSBqNehHHHZIepdnIjhV2?=
 =?us-ascii?Q?GsiVuXDTaYGlzwNqXkjhfyDm4vb9uHmJVRZuMjBUBTZs/2c1L0tiOtpG0q0F?=
 =?us-ascii?Q?wRfJ5SnC0vJUjFcL5YHJcoV4kL21sPRtvg+5PsHI2gSCbFpm6UqKymrfpCq2?=
 =?us-ascii?Q?1h2/qDQy4umJVQSlpqOaK3q25biiC0hxZNN6CVunmlFS3d9jALEbC/KpQRWQ?=
 =?us-ascii?Q?JqsE/WH84xYgSeT1p8cFLZVGIP0VtNfxQchTfLzW+s/uoTJkFeSVUbORO19j?=
 =?us-ascii?Q?rVndbSTiWJ+R7OaP1OugxpXR7NeudhnTW8Bkl/BDglGyS0rJ7ZdHVLTr92Fm?=
 =?us-ascii?Q?ZnjOZGZaAvLv+CeEs4gFu80TofHdWHK4nzeoJXd4NIV02bAZkxBT6suA6axt?=
 =?us-ascii?Q?HDYtJCYmF+PqingZ+R6xf/I4RmySyn8iN4nw9yRNVmxDkYcpkgPf31r7hZyC?=
 =?us-ascii?Q?r48w5BhE8/l5C5LDFEI+DYkMG8LGkVJx8iUaDsbY5iy485NEb8z+4yUhhlzI?=
 =?us-ascii?Q?kQVetNmsKFrrd5bFyIHexT58g7ZfUf+rgQsnAJj34C8kQXhZEYjW/dt/xOV9?=
 =?us-ascii?Q?BCucLpLt3qxv+k/L8Fe6O5zmrjZ4ervs7OQpBUIdxv4wlzfv96SVxD2VMtng?=
 =?us-ascii?Q?T3iswiYOphUG/8tScFgvAT/AyZ/Sk/raM/+YqsKVZfRwNUjtt7gId1H8rQRu?=
 =?us-ascii?Q?hUtoocNQyEpXFlIIbR6+/2qn+eyxXPGxlFUCP94gojXOW0Cs1X9T288vd2U5?=
 =?us-ascii?Q?gI2j4id+E8aHBiD+F8anFyWhB6X6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 18:17:39.3057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9f660e-5944-4191-89dc-08dce30e7fed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078

I think both v1 and v2 are missing iommu@lists.linux.dev in CC.

On Wed, Oct 02, 2024 at 10:55:14AM -0700, Yang Shi wrote:
> +static inline unsigned int arm_smmu_strtab_max_sid(struct arm_smmu_device *smmu)
> +{
> +       return (1ULL << smmu->sid_bits);
> +}
> +

Hmm, why ULL gets truncated to unsigned int here?

Thanks
Nicolin

