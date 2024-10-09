Return-Path: <linux-kernel+bounces-356328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17B8995F9F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBDC285273
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8E622EEF;
	Wed,  9 Oct 2024 06:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zpyi+sQB"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080614E2DF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454836; cv=fail; b=QQJNU6Ao1KYJDp8pVgTB4TVy47slGWOASK1UvgZ2Aqxc5nkj3y2y9tOkTa0/zoeEZsYU4mvKAGx8+hfJFvVdgVL71bMsyB56z5rpGdpWCiT5d+nUzXWzkn5GugY5cocj+H5kJdRI4mlB5X0N6V/jqU1kL7+bL9/0r83j1xyUgdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454836; c=relaxed/simple;
	bh=Vz/BPVL98iBFsPgZvQlgffgUQIDkcTf3zcEGaT72EIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gRBSdNUWyVBM2J8ZeVD/sp9/s8kL4+pNxCVZwgb64PY4E0BqflvYzQkYXnuIigZk1lTX9ZyXkKfWlsg1UJVfkZNAd3+3WXhsAUZqqYI5P41z+Q8ljr3nxoVTu/D5y43mr0KC9CAr7agkmUEPoeS+N2r36hngH9pBy6M4XM8Xcb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zpyi+sQB; arc=fail smtp.client-ip=40.107.96.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKTvV/1dO0m1iPGJx+mNVODBohrDe48UNfC6jk6GyxWQTdn38WJIT/nY1Gol1v0EccsHkk/V3vNZn5oIHDSr8ktpK6Zq71Nv9GNYmk5tsmG9k1r3+d7fci3h9rT1bVUNrajI7ARgL6q60sMAqP2K53ZbGi6mKb3U6+oHDFNkm9bFTiObBLpjv+zAeYcblClivbazCog09nlcxl8CsDewKo9ewD3BYxLwb7qnwUJr3TRn038NOQRJp/1hoGAb2N6abqmreNuspcVXByfNUGsZ8/6PbZ4pSSd2xIOL87YRATc1Lv1hBxAsjIpWyBblJxmkoFwXEU+3DQKKjMZhqzmLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbUUwHXSmTEdrAWnt67HmJWp9YZgE7Rew0BueWiYcJI=;
 b=ckmrLU7ZmuuRygUKVtlu1gr0A07I66GPt5vBkmrkuoW3uPYcJrjKilx98fu2Y2nKt/TrcnxWoKq0Zh/odNkz98hdIsI1cP+k7CTtiixYSP+ZfSzJZMId7RcIcjAOMMj2FI9xxKtoEeJ7G2moBFcV1ywgaR4Q5XWQponuoG/ufIWv2ogxI89VGDWSbTP1eiVY/N1c0hjjp133qmnqPMtLaRoVLdJy9I7AwniEqPV+6L89v90H8MLjtDLokYiGDh7Nu8Q7MeA3UPsYaL6mDKRsir68ELJk3Uyp5ndO8DPBrhBRdq4aEawM29G8IEtrNv+AQOWm0gzeGCY6R9u5hP26wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbUUwHXSmTEdrAWnt67HmJWp9YZgE7Rew0BueWiYcJI=;
 b=Zpyi+sQBX7W8oCK+tYVxWEmYCuOgk2ryY1U+IDixSJ75Sa6C2xe5M0zfVIokNo7+paoCc87W9AD6+TV+B3466AeKlW0BF9Ff6JTA63nvhsqlCKnxFAi/9rI7CLSJdVNjEjrDGBADUdfbQf8GlEln12lEbYjiL5AvAFwDb48THAw=
Received: from BN0PR04CA0167.namprd04.prod.outlook.com (2603:10b6:408:eb::22)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 06:20:31 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::b7) by BN0PR04CA0167.outlook.office365.com
 (2603:10b6:408:eb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 06:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 06:20:30 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 01:20:28 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>, "Jiqian
 Chen" <Jiqian.Chen@amd.com>
Subject: [PATCH] xen: Remove config dependency in XEN_PRIVCMD definition
Date: Wed, 9 Oct 2024 14:20:14 +0800
Message-ID: <20241009062014.407310-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: cb681f3e-52c7-4b4e-c8e9-08dce82a79a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G4r6HOPec4sxWbfDeksrwjsAY9XvU1onbeqn7Hs3PoqUfG3n3GncUNRisk1C?=
 =?us-ascii?Q?WekCEMAZZXifxkgO9t+jO1V1Qu4IQcfKQWg1JwKJDo3mQwN0v+9k/Pzhu+q/?=
 =?us-ascii?Q?7WgwXotG/HNYkGK/NQVVMG3BZAGE8HADwN2+KpwOovbaZyStbIaJyjguY9Ot?=
 =?us-ascii?Q?y68rFJpL1jXh9hERp41HZlNNofmU6mCLjUJbGHpXv+J/ZEe32zV3L4oZHu5B?=
 =?us-ascii?Q?K33ERIrc+uE6ZwLdQt/DMebppPL+/ybh4IJDhqmK1caK+MhHBWPJP6zOu3lD?=
 =?us-ascii?Q?7m+RDA7xSmy28E5gI2EL+qlPQSjMYLqrZyqA1XEQspC/vrIe3iw3HKxzeRdH?=
 =?us-ascii?Q?hHzU7/2m1GYNaUO+Pib0kPx0Uw1tElQ4Hb+FfW8+5y4XaRorpmojRVGqGqE/?=
 =?us-ascii?Q?mFsUU/Kw5ge5F2be567vKfPRhuR+k3giRkDZ7kO6jyQc0aUP6tDPg9n3F8Xg?=
 =?us-ascii?Q?sPQjsAH/SVCoenEshzB9bzyPV0l79+7/27KK6TcPBxKJwL+DyRAmkjtoD5Xa?=
 =?us-ascii?Q?e1RtNvTvqSbvtkTkaC77dY8bXKbcmFSufAZmPZC9xDCQBltn3m+BMeGUpEak?=
 =?us-ascii?Q?bCGrFslSD0fziBntlkjo+Q8eV3mOaBc9eVmyP43717Kc27HWaEAqnT1AdHd0?=
 =?us-ascii?Q?AR17o0tUxGlbsZ/oHukd047/sRh0AmKYO+UyaCirwuS2BLVQNFAdreXU+ufa?=
 =?us-ascii?Q?DnEwGZCJ9ivS9N8KTIspjARYFdDt8ZuXE2j5O7P2tfixchCFMr3M7eK1pSEW?=
 =?us-ascii?Q?OCXG7717/3Sg2WNmxtmYRfdBEnJGGHG74vJn0GhuZHyuCvbM7Ky7Kv/Wa/Mp?=
 =?us-ascii?Q?VjYNwzuaZakaftsCr6jIqAxM6++he8DpWE10oTBdLDSr/gnb0fp9eW3+bmaW?=
 =?us-ascii?Q?cq4qBX7CuqbLbglSBH98wqq6r/LEgrfff9kf0OYw7THjG3J6x0c55+8Tu/ym?=
 =?us-ascii?Q?uc6xyVIxFzD3yYhIwPXN08nTUjmSr3ZI4ibxtPx+L9Sp4EQqYFLJP2JOnelM?=
 =?us-ascii?Q?oFB6uxTGYr4z+9CWaMksZSZZL7hYNRuPkKVp3B/2ZiaVQDGBtWXGQJJBi3lb?=
 =?us-ascii?Q?d3667PkK3W2n0DbWCBcxduybVs0B3Wv2KOyVrt2bseBySlijZorXcF9EOG/L?=
 =?us-ascii?Q?AcmlON2l6pvrdxEKpgvfhdW12m7LHVizvD0lpKMP9s6gUTBbQFTkbzvmzTi4?=
 =?us-ascii?Q?xz8rbEEiPVkyR8uU0n8rruv5J1AyDznE1aPDK9SVq2ib3xhQa6j6FJ7D5EuA?=
 =?us-ascii?Q?hM4/5UYLKCvDP9RcDTsv9IKJyuY7t08+WkrC4D2gY0pyiT3WAY5n5u0fmug2?=
 =?us-ascii?Q?JzBV/FABe1bu6BsH1vsXl5Gj/14nDsl4KkeqwbMESQO89zmVAcyDuZ0Csn6T?=
 =?us-ascii?Q?+4EK7emuxYCQnthtKDeq4xz73KTw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:20:30.6190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb681f3e-52c7-4b4e-c8e9-08dce82a79a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771

Commit 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
adds a weak reverse dependency to the config XEN_PRIVCMD definition, its
purpose is to pass the combination of compilation that CONFIG_XEN_PRIVCMD=y
and CONFIG_XEN_PCIDEV_BACKEND=m, because in that combination, xen-pciback
is compiled as a module but xen-privcmd is built-in, so xen-privcmd can't
find the implementation of pcistub_get_gsi_from_sbdf.

But that dependency causes xen-privcmd can't be loaded on domU, because
dependent xen-pciback is always not be loaded successfully on domU.

To solve above problem and cover original commit's requirement, just remove
that dependency, because the code "IS_REACHABLE(CONFIG_XEN_PCIDEV_BACKEND)"
of original commit is enough to meet the requirement.

Fixes: 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 drivers/xen/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 72ddee4c1544..f7d6f47971fd 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -261,7 +261,6 @@ config XEN_SCSI_BACKEND
 config XEN_PRIVCMD
 	tristate "Xen hypercall passthrough driver"
 	depends on XEN
-	imply XEN_PCIDEV_BACKEND
 	default m
 	help
 	  The hypercall passthrough driver allows privileged user programs to
-- 
2.34.1


