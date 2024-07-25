Return-Path: <linux-kernel+bounces-261784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F393BC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237BFB215B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BCF1CA9E;
	Thu, 25 Jul 2024 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q0wcqG0m"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A791C694
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721885710; cv=fail; b=EIEGMAGj6YjUiLllD0jzpCKzeClpqiEoG1n5RiekSn6LyT9Vej6FVSVVw5YwXzP2eehxFg7ZQRTHpbzpJCwn646Fn4WoKtkrh6D9JjuPm5P1cU5/l1FWJbhMnglprwqywJxdLUfFzFpv1U2GmFrmq5AnsWc3eb1r9SkB8STT6kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721885710; c=relaxed/simple;
	bh=F/S0/dXFFigdTAIWl4OySc3za8r9arTZZpF7S9CF0xM=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=TUrRZKY1DJs48mprqfLeURNnoeumV7+HLCgW/wq0cHMdESESl2IL8CJ5CAQtMiQlX8iFGmmEAjXlLd2v4ziLiKDeJi4YbVBWywhjbQE91fWCFy63LbCB1mZEl7wpJDDjX6Ict10uXsTnRZQUPvuEbIJo36NEdeWmyl0l50CYLCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q0wcqG0m; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nD0e8XJRgPqOUz8rdSFF88AxTZPeQc1oGV2XPdYEEpUIHVMc7oGaHSlmRwVfuHsEEXdTwe4foMy3AVByYCBsRkfAVJf+yHlEP6Z96//R3TKuIqcZDm0Bd2Dp1s6L0tVV14S0K9L337++SjV5VTfk8MOlwMwiJ41HnYb67B960pxFzC63hwkzKw8OZ7CvWRNLAkD7sZKEwTjauXaqCUiweowepTFgjKU1rvbT79Ox62V5sQJuqXxZeGQbahkhlcgVDhhO/aZsiaC8EiC4FTAkvXhFpV81/+cEQQUJxC1OKRpn6Xs0S5yL0/snLa2p7NCFrbSYKhrrW23TnA7EIk0wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWtvVwLlCOLCa4qvXnXELHIYQA690mpmhimAiYYsuSQ=;
 b=qYYo3TYUEpQOUZtN2hjJ1t7YrYM1nXl/HClDSiMEkwwe03OWFIf3jqLepKteGA6+UeoDPe+CWLLqzuRSAN8MiE7qkOUo4c+L2tZZ4mlNRb+zANLA65H2C4Zg/a+pRLHkn0hxhEw4Okv5ftqxbYoDUYlmO4AlMivoUc15/hnhbP92Mzga+tQ2HmFdvRhym5Ul7ZA2WLVeqUacO6Fsl9K/VK301YpLq4szOUDeVexA4Lz/nhGHCwGKZkS1F23qPqgfJaXWHy5jOZeG1OKYvwdMxrUUQ9lvuhHwl7MHoP1FdoeNazDvfHwtQG9Lwl94MjyAQcOl5xKkk6CZd3v4Oen59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linutronix.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWtvVwLlCOLCa4qvXnXELHIYQA690mpmhimAiYYsuSQ=;
 b=q0wcqG0mX9pYd34u3MkJfLmBFbnL50LTZGIQpJSYnAZ5TdNQrmu7IIzxEUg0IrOTMqejKHO2LRmjnKSnxPkgwxyhCsSQ8QkIaXfYZDiod89Dnlf6HZE8SDHGQsQh7FR7L8Ltbq4vO11ja/1u6s0abMkLrHU0s5YAkA9PbVPFz8wRzCwUZvkhdb2DUHZxkS81h5bnyA1k6+srSrbBquEwoXMILwpktJwnKNGGwfSOUOxGe6AlFYpP4UKdPHJ5+ffDfCo1JYluzqoeG7o60qbzEdSqONxspTO4OiRDJqJpYh+I+Up2LCwt9y2PjLmHEel3Q0jM/tfSwJyDkIKKp+jmuw==
Received: from DM5PR08CA0040.namprd08.prod.outlook.com (2603:10b6:4:60::29) by
 SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 25 Jul
 2024 05:35:06 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::b1) by DM5PR08CA0040.outlook.office365.com
 (2603:10b6:4:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 05:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 05:35:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Jul
 2024 22:34:52 -0700
Received: from [172.27.19.212] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Jul
 2024 22:34:50 -0700
Message-ID: <ccb1b2ca-0d62-4c74-ada3-89cce13b8de3@nvidia.com>
Date: Thu, 25 Jul 2024 08:34:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>
From: Shay Drori <shayd@nvidia.com>
Subject: pci_msix_alloc_irq_at() affinity
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: d553c8b1-ac70-4940-e1c9-08dcac6b8a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTMwMUMvU2FpUTZzUFFjcnhvRE5GdVJIT2RvREQvZ2tiQjZVRVIrWmN1THM2?=
 =?utf-8?B?N0RhWU5hSXBPRDJqSitZQm44VUcvL21BbXh0a3JHR1c0cS9ncWlVUk1ZaWlD?=
 =?utf-8?B?LzBkbHJiaEFKeFlpbkhOL0c5OUdaZXE4TnNvSm83Sk9sdjVhK2hsOWZ3Q0NO?=
 =?utf-8?B?b3Ava3UxaGQwN2dRZU5yUTRSWC9Sb2tNRG9xYk9FUkJJMG9vN0lMVU1kUWEz?=
 =?utf-8?B?KzJ4WDM3RXFMcktUaExDQ2FqeEtSS3pUeDJYTEN0ZHc4VzZZUm5sZGRLZUNp?=
 =?utf-8?B?Sjdxc3U1RzRRQnZURzc0NGNyMHRoTVdPNlk2R1BvdDcveERmQ0EycDliQksx?=
 =?utf-8?B?TmRIazRjaHc0Z3BhWm1jUjgxN3FQeHZGSEhoTEYzR013Z0hXclNVUjdqaGtm?=
 =?utf-8?B?NDNpYUZsOEszWVRwWU5ZSXcxRGRKUE5NRXZpZlRsUjFja0syVEczRm1HeDNE?=
 =?utf-8?B?ODg3QWxONWpPWDN0cWlJa0gwNEtYUnJRR0Q1QUZRbXFXdkFZV3Y5d3ZVTm9B?=
 =?utf-8?B?bUtqbklXd0NqR09kL1lCeFNUdWFFb1NqcVhOYWhSVWcxcENBTHlMNUIxaVE3?=
 =?utf-8?B?L3laSGw2L1JKNFNXTWllNkE4QzNFOGpZOGJNVzJrNkdsNjRTZjAzYmFnSHRE?=
 =?utf-8?B?VmZQSXFTN1VLalE5RkdDWjRiQ0E5TzBPeTlZUlNxYStWdkllWDFRVUIzeCtV?=
 =?utf-8?B?OVd3UzUwOWhveWVDblFXcEFMK3Y2L2NGbW1idFlvcmt0VHkzdklycS9RZDZR?=
 =?utf-8?B?SG5JWTh3RUNVQkNHeW9kYitzVUpyOEV0ZEJwSTJMODUrdjlUaWV1Q2ZqL2I2?=
 =?utf-8?B?akd4dkp5SHF3T25BMDJxN0kreHczbmJGSm5yY0FBL1RzNmRZVUVVTE16R05M?=
 =?utf-8?B?TnB5bkFHQ3g1cW9Ub0E5c1AwMUFuUTg2UVRsVi9tM0xrL2diVHh1REJNaE9P?=
 =?utf-8?B?azc4eVdtaVRUTXZQcE5VbFpFY1Qxc3JtQm5UWVVrMmkrZUZYOU9FV3Ywa1Jk?=
 =?utf-8?B?OWIrclRXbTJKUFFCUlpNY29mbkFxYk1QSVFxOVVzSG84YWxqTkRyU0NvMkFJ?=
 =?utf-8?B?ZmRpRnRwRzMwaUFENmlpOGlCWVNkbExmUVU4bXFYRzMvQ2JFdGx4RFlHM29q?=
 =?utf-8?B?NW1xTDNCYnpocGhJQUJWaE9WeXI2Wi9zd2VVMGw2VzdpaEFDSTAyOHJFbGNO?=
 =?utf-8?B?bG5Sc0htMG81dmc5M0pPTW9oQkF4Ym5OVWY1aGZobGhOdCtnT0RkL3FMZFBm?=
 =?utf-8?B?N0IwQ3BldWNSWlpBRlBzalVaVWh0Q2E1UVB2c2RVaEVhSFRRTUNaWUltR1VS?=
 =?utf-8?B?ZUI5eXJBeGcxSldZRkNPU2dqbTZYaC9pczNIQXc3K0tGdkpQZFBSeDJOMXg1?=
 =?utf-8?B?Nnd5RU92RDFPa2tGTFlIaXQ2YkdVMGlReW45bjNuUzRuNXJFTWE0SEZlckg3?=
 =?utf-8?B?L3pDSHVqdVpZWjRiVS9aZEZhOFFHMVNuTzBwWDFZWmh5NW1oVWl3WVFvTEp1?=
 =?utf-8?B?VGtIU1BoOGxYZDAzS2c2MzhhVnZOekxVSzEzWGcvcTVON2t0WVNuV0FoZXVZ?=
 =?utf-8?B?UkV3SXpTS3Z4SHNNS1B2aGRuZVhuUi84djNCaWFMVVl4OTZ5cmdzTUhlSUJM?=
 =?utf-8?B?aHI2MUtUTXk4NFBkSTlkQ0JVcm5KZFdpbUY2Snc0VFZyYW9GUnF3RXZRRXJR?=
 =?utf-8?B?aGc1RnpYTG40eGliakhsUFE5ZkJwOVdvUVk3UWVBNCtUUFJiTkRkalVzTFZB?=
 =?utf-8?B?R2JEQnJPdEVnZUhpNU9aYk41RnpSeGtucDFMMzBlUzdyWFBUbGRHUWlUcWFh?=
 =?utf-8?B?c0h5RGtQMHVrZThxbHR1ZUtLamJ4R01BOHpOMEtZR3kwUW9TYkM3a0tVaSti?=
 =?utf-8?B?SnhzU0lNY2g3R295bURuWURiaEN6U3FsU3dSOGJzMWlsWWM3ayttZjNmZVFI?=
 =?utf-8?Q?8bVaMkdAE5x6body7YkDYtrX4xu5huwa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 05:35:05.9609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d553c8b1-ac70-4940-e1c9-08dcac6b8a44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845

Hello Thomas

I did some testing with pci_msix_alloc_irq_at() and I noticed that the
affinity provided, via “struct irq_affinity_desc *af_desc”, doesn’t have
any affect.

After some digging, I found out that irq_setup_affinity(), which is
called by request_irq(), is setting the affinity as all the CPUs online,
ignoring the affinity provided in pci_msix_alloc_irq_at().
Is this on purpose or a bug?

P.S. The bellow diff honors the affinity provided in
pci_msix_alloc_irq_at()

--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -530,6 +530,7 @@ static int alloc_descs(unsigned int start, unsigned 
int cnt, int node,
                                 flags = IRQD_AFFINITY_MANAGED |
                                         IRQD_MANAGED_SHUTDOWN;
                         }
+                 flags |= IRQD_AFFINITY_SET;
                         mask = &affinity->mask;
                         node = cpu_to_node(cpumask_first(mask));
                         affinity++;

thanks
Shay Drori

