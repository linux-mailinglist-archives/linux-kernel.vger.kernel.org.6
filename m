Return-Path: <linux-kernel+bounces-178353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 409218C4C70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECA71C20B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D65E574;
	Tue, 14 May 2024 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="entCGTg4"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED3101CA
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715669325; cv=fail; b=W6hqNIm0UDK3oub4VlFvykgrtMCS4be7+6xdPbb9h+3GX6NzPxe1IoC1FbbfccjF0oMka3woooaaWg8aD+X9cDTlYdiIxEES9THucrwQVtsTWU8rd/kBYQGk2ae9rCE9b9uNPwkgE0VS1sBj6N2d6jqBZEL9Ms77Co43MnbOS3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715669325; c=relaxed/simple;
	bh=T0i0nbOb0s2u0ax1rsABIW9S6BN5wm4Dw3V5WcRarI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UrZgD1bzcvFrV1cMMlYFDd4F2+gx21Tw1gCoMg/rae2nYe90ksqeDvQFZf0NR2bLImnsEBXkgpkdaK4wLmqr2CYsgkWPFkrkWmlsx/3/CuLaSgRSf/LWEvx3GUhSj9uVbSoGfGj06SkwTMYHZt2Uw/8DrnXdg2xsdTnSJxcjEJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=entCGTg4; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8MooboGh48unMKRNNn+AG1KayYD5MKeTNDN53gRUOGJR/jlA6k8OMklpCiS3CsAK6CzHLbxahg7KeK8hjLdTbHS5/pAY4riaIXFZ7rHuYxG3rWBR7jHNwkK7VpG0eOM650xNB3GlBgnT5qEfhJCA6EGbyfbPa0dcXP55PMM+qlCczab9umF9IOkX/D/NcnW9z7GVgH/BaI9jSBa260D686vX+nkT58kwLx84onfhsqyZOQ4uvqF4eoM6HLcv8YX5jFr6lg+HwzqucHeN0GC5JNSY3n50kdcL6KQXYV3AOEevlDJ7Qnr01NTenIMKIUXKUbTJ2wVm2P9rYOMe7tmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/+ZZ+snoJ3pRJ6mkpMAPrfGrKR/U0AfW9j3/EaXSzY=;
 b=RbfjjrUzI5k+/YxRqmCTDSWdlqGdpihQJ5Hm13Er/KKtGML4lgFmJfvjWz0OoYf0u5QfvcTfRFP67ebES9qTHjXIeOgeFzq/4np9G+oEFt0GTuvFQFWQCG6MIDe9sU6kQHhIgCUgN4kBC1Dbf6TFNpt9y9ODV2AuDpDR9DAS00x8qVzVcBho6Ny9c6mpgqvMYkJVgwzgPE0Wy8w0FfM2ex+JZehZEj80aJc28LVBHmM++GPEO2x26yUgNQy7saSRniFXZw6tfyf/GDK0OcfHmpmElwwY2VdOl/46SmGg+k2IQV1LYAoRBRFVkJXoPSuCa26HDoKchOoYcAE7vFCItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/+ZZ+snoJ3pRJ6mkpMAPrfGrKR/U0AfW9j3/EaXSzY=;
 b=entCGTg4YlWO0QkTOM0mc/RAC2Fuppk+2ZYAHBDyw2hVSLJkaWHwENdK4FoJsfkdtHrJ5NRbvG2l/GIKS2BWMviHVXPVqqX3Q98MFXk8CBr2F5CecMmBYZNV5H1vnzYMtOT88lfpUxrKJkSxoWw6CIm73hQvgUJr0IsJWqCAoK9N+yB1klSFLPzQ0p4bfzxX+4vyFAfK/lqQhn1XWCT84pheb6FlIYGuj5BuOz/gSwsH5tYxmTb6UhkLc2IPxZ+/6iy68cqf0ZNgJu1XgK1SWM0VmqwUCvyPS7gh2aCEOkUfe+KAvRw32Tlx5+5nIfG30kux2xoUBvGtb0hvKcaQAw==
Received: from CH2PR17CA0011.namprd17.prod.outlook.com (2603:10b6:610:53::21)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:48:41 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::87) by CH2PR17CA0011.outlook.office365.com
 (2603:10b6:610:53::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 06:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 14 May 2024 06:48:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 May
 2024 23:48:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 13 May 2024 23:48:37 -0700
Received: from 717d7c0-lcedt.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 13 May 2024 23:48:37 -0700
From: Dipen Patel <dipenp@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: <dipenp@nvidia.com>, <u.kleine-koenig@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <timestamp@lists.linux.dev>
Subject: [GIT PULL] hte: Changes for v6.10-rc1
Date: Mon, 13 May 2024 23:48:12 -0700
Message-ID: <20240514064812.183839-1-dipenp@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ba27a4-7b85-4b21-aff5-08dc73e1e411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFI4dGVUSFhoOGc3WDZpUVplVnZtZTg4YW5RTXc4OTROVC9Hd0R2WmJLYTRu?=
 =?utf-8?B?SDQvOU41WlRMU0hJdmNBNzZzajBYVlp2eUFwbzk0dGIzZVg2M3hKTzAvRkZV?=
 =?utf-8?B?cklpczIzdkNud3kxTVB4aTdncHYvcys4bDQ4WTJnbkZLNzBTTnh4eEhNY3hl?=
 =?utf-8?B?bG1OTkxBN0JpMFVWeTJkeXlzNjZiL1lZQnlJWGx4ZExncEo5V0RWYXRucDc0?=
 =?utf-8?B?RmduSmFlQUZBcVhjTlVtVzFMN1dwUWorRmowdDVJM1AraTE3a3hxQjAxNVQ3?=
 =?utf-8?B?NlpwRys2bUpqaWZYdmxUditCTVczZmJCdFVMU1MwNzFsNzI3SS92WUNqcUF3?=
 =?utf-8?B?WnlMNU9wSnZ3a1ZlNklqL0lhV3dsdC9Ea2NXLzhTbTBPL2JER0VoSnJxekht?=
 =?utf-8?B?L3c1SFQyazV4RUV1UzdHMHlLS01LQlBnWWdCWHZvdHNKZWQ0dldDSmVkbXcx?=
 =?utf-8?B?RXVLa1VrMndwSWt2VW4vL1JUMjRrM2d4czhNQ1BhS01LZ1pHTVFseUNnUThB?=
 =?utf-8?B?a3A0K0RUZEhTcE5lRzU3S3BZMFBic3d5eXVTajZRWGZ5dldUd3BoeHJCVGNJ?=
 =?utf-8?B?OUFyMzhBbTl4WlJ1SVdvTGZ3UVUyQUZsbVNPV29VNm11RHAwbVZrdWN0akp6?=
 =?utf-8?B?d1lLdzVlWU0wOGR2c2E1bDJNY0EwLzlDVkxQSkd3NTJ6TjVyWTAzL0FHVHRn?=
 =?utf-8?B?U2R3MkFHTUNxVWx4dUZyZVVTWmhiSC9lVW8rMWRBODRKaE05SjkrY1YrUGZx?=
 =?utf-8?B?MnBueUdpVkxlZVFyOVNWL1FLdStSVUw1KzE2UjFUUUdJT2JGeFZ1ZTl2Unc4?=
 =?utf-8?B?UUlNalBCMDFyd3hSQm94UFZqbkxWNFFPRi9aREt4RXErKytxQWpBMzVONVpr?=
 =?utf-8?B?c3k2eVJxazJwWGRUMFkyQjNqNTdvQjRKdUVhSWtkVm0yS2xsYXV3eWV5TGJ4?=
 =?utf-8?B?Tk5lWEdpVWxtd2pVK2N5ellGT1UrTjVCK3pPZlJNSHhCYTdSRzNVMmVXRkhl?=
 =?utf-8?B?ZjI2VEhmRTJpd2JCVTJTTGJwbm5PYnNSZHVPNmh3bE9pb3pjUXRZeFVwZFI5?=
 =?utf-8?B?VWFBSnpqdkxhTG0xa1E2Q0pkL0gzMml1UllJTDJWbGFORWJPdlJPa3ZNR1N6?=
 =?utf-8?B?QmJMVEV1cTVENHVYU2dDc3pxdGFYUmU4MU1aSlZXU2Y2RnVKM2s1Um0yTUh5?=
 =?utf-8?B?bVlmZ2xJanpra3Z6MXJjMFJCVk5tQjJpSUlGS21UaXlYMEExMzh3emVjV09T?=
 =?utf-8?B?cWcwTVdtWTU5d1ZKb2FraWhnMzAxL3BXQkFEUFJhS2dMUlk5YlFIMlVNdDFn?=
 =?utf-8?B?UWdmaUFXQ2ZEaFBpN2lwdm93VUowNVd2aU9sbEsvSDdKSTJoN0R1ZHZURElV?=
 =?utf-8?B?WTlkRjRPbllQUUROY2NYUVREZnlzbjdCV240KzhWVFF1UktpSmZNUHc5NXoy?=
 =?utf-8?B?WTU3U1dlUURJUUdqZEk4UU8vaGxSQzFuVHJhdTJtejZUL1RNeUdtbHdzeks4?=
 =?utf-8?B?N2Z2Rk85UUN3eW9XVUtRQ1FFUkwxaXVaZEphcGExOEhKckg2SzF1Z3JxYld1?=
 =?utf-8?B?aGt6ekF2UmpLQU0wMmxxc1lXQ0tvUWM1Z0xJYTRGVWpPWTYwMXlSWVF3L0Fv?=
 =?utf-8?B?VzRQUUVKK3pHcUYzTUJrNjRBOWxSWFFZNlhwbkZHTmJLZXRha1c2SlA3Z2k2?=
 =?utf-8?B?ckIrWnozaSs4bEFOaEJQLzkwbWJBaVdYQ0FnM1h2RHF2WUprem9OcmNWZ21M?=
 =?utf-8?B?YWhUd3RpakNMOFVBR1phWkFCWG16dDRaUlBaQVpySC9acjhhckNNWTZ0VGRx?=
 =?utf-8?Q?UG1cVw4GoFDtmzXREf9dfcug1ir7ypvYMRLnQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 06:48:40.9404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ba27a4-7b85-4b21-aff5-08dc73e1e411
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pateldipen1984/linux.git tags/for-6.10-rc1

for you to fetch changes up to 297f26dbf870d4f19591b74a0ab535c327917b81:

  hte: tegra-194: Convert to platform remove callback returning void (2024-04-12 11:02:58 -0700)

----------------------------------------------------------------
hte: Changes for v6.10-rc1

The changes for the hte/timestamp subsystem include the following:
- Improve hte-test driver platform remove callback by replacing it
with the remove_new which returns void instead.

----------------------------------------------------------------
Uwe Kleine-König (1):
      hte: tegra-194: Convert to platform remove callback returning void

 drivers/hte/hte-tegra194-test.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

