Return-Path: <linux-kernel+bounces-317275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEB396DBCB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A931F22A11
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C5617BA7;
	Thu,  5 Sep 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZDZs9BOC"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A6171AF;
	Thu,  5 Sep 2024 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546683; cv=fail; b=L4geWNau33YccckuTlZ6VehsGD3h/guiOhcMD62IIEZ3kKGQEBM17O/R+o4T823tOH0uZP7MuX2W96U5o1Xk0rqFyE8VKmXGX0O6NwbG4YpoV+bAP6v3RTK3tFy5ZoSRRppRL2SlwOplGseTS4iFvP36rWWudEKDaZ+WI1KLjdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546683; c=relaxed/simple;
	bh=+cTDOuRWUIMq9HUIDeelPGUcXjrUYwTqiaJ0e9JIVcw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LIHJAgrx2ucF/g85SikXLEcM6ZLoxl/9FfHbtdb/eZcVzJVSbUabicqgtF3RPffD9T241+9bJso1AghdJez6v5sXwqx5R/MNiS0vi6uBu8hfTp7SRAU8a7TF1IMvmPZoYWBJw2gO1S38fTl8QOAKYdXqmazLbP+wVB6239hCsLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZDZs9BOC; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyOM3h3NCfXMg6MKlcfhvPf0wZG+7mXfPsrCqYHb9e/CPelF2tYQxc1m7g08gLwKv1YNM3s2q9S3KMPVakecpP62Y6Js13j6HyWonbdKpeV31drAQfDaIrKT1wFjqSC2AZ9d7BlAYDVmE3ugBD9p3+52eJ6A6r4UQXMHFeMEB+WRA6/Fsb1KKbX21gatTbcb79PlypW0jJCB2kcCCyoxrjUm/wP9PJQOtvsPn9igRD0J5G49yOIthv6FIfeF0WBAK7deGbq7zt1PlGX9tm/G3DcJiU5j8rGU0J/nBs1Wsk+bEQ43Ue4iB295MthitHrlcbiKaWJ8TIIZ6sYSdOJSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pz3cZ3XlA6+MZl9O8FVjE5CAh6omj4Wge0+EvnHPKv4=;
 b=W9TxSqfts52xYRpV1IACZftm63VbVFOrLXXkOMK/eoJlK75/jCFp1Ukg49fijdFGBfkiqqQc8iifi4cph5Gg4nBAgwTp5fDqqF1kn9eMNfFrMPT3bSNou2oJZizMLTRDkTKJjKuzSUsdxYu2UX/Rk06329U4P0VUqWrSZCzVZg+gREvm6XAKPd5umkVdn5+iDCd6CVA6zD34ElE+OZ5AK3T4z59szKZzDjOANsgUy0nebu8+WduXt5qJsHkIzcbsFdOme7oBv6S7Siew8H5AOmehwIl05hxXXBObgILGK+RauiHx6kg2f6NmaHKtMYPGQ0x3S1vipBRw54LApyngtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz3cZ3XlA6+MZl9O8FVjE5CAh6omj4Wge0+EvnHPKv4=;
 b=ZDZs9BOCMtjBXZ7Sa/YS7ZMzMALplD7L7iD74pb6K2vgjw95JiuQvL/2z67DO74cIoQMpigR0IEJHGQ3+Sa4r9baYlY3IDYVKNSRZNIyxvrfY0a0I8wcOsr4okneNShJZETZpE7XzceVVgYE3cCAec6SODP8vTfAlmGw/Wg1Eeg=
Received: from BY5PR16CA0008.namprd16.prod.outlook.com (2603:10b6:a03:1a0::21)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 14:31:15 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::df) by BY5PR16CA0008.outlook.office365.com
 (2603:10b6:a03:1a0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 14:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 14:31:12 +0000
Received: from ethanolx16dchost.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 09:31:08 -0500
From: Pavan Kumar Paluri <papaluri@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Pavan Kumar Paluri
	<papaluri@amd.com>
Subject: [PATCH v3 0/2] nosnp sev command line support
Date: Thu, 5 Sep 2024 09:30:54 -0500
Message-ID: <20240905143056.48216-1-papaluri@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 40aceb49-d167-4dda-9f1c-08dccdb76467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?31FLfLRFtxI0By0YVdVuI+PJJKfPYdy3QV07aVRiaK4O74WMV2ZaHuzjLKgG?=
 =?us-ascii?Q?4NsXutr0VqERalPB6xd4TMtPf9nFhqgmyvjmYltPQJEcQujf16ZLSESr2WiJ?=
 =?us-ascii?Q?tuoZfCdM1apt9Swqy5iLtdWlFEvy9l3orjhkO96bBbgP5eq5sMHGXLZvBiUC?=
 =?us-ascii?Q?mTKpZ3vE/ilMqIBs6i9xm5M2dqLToTdRR1w5UFDs9BGvzhKxyKxblstlzY97?=
 =?us-ascii?Q?3IrvIM7r7MZavWMqf14543bnOdVHqCs5YcHpTDXwg5v14t/EJpvC25DUIO8n?=
 =?us-ascii?Q?QnVWjFl816B1M8vyEYlU1Fd8i/s6I9Y7x/jasr5EGhkPHnKOraAdCqHWJ76l?=
 =?us-ascii?Q?w93mN1Po8KAPqvxG8fu0nMbJoTgUoe2T+NAmlvaUlGKWYenbfSWP1N1Hv64B?=
 =?us-ascii?Q?cy8BequjEOIGaL1WQxYKCtuwcg9m9KvmpRnOsQHNMlMFCObukCh1ONw2zpre?=
 =?us-ascii?Q?kW0lqpJZH+Uq+AdFbNm02ASBTfjObbkCja6NUouOqnayFO7bK/apQMUXXkSp?=
 =?us-ascii?Q?Z5/8Nyv1Ee0a7d0pEC6BgIZtsd5azTRgt/U5nYQJ3H+gajlueZAVGQMb+5P1?=
 =?us-ascii?Q?4UVt5u46FaYxoiA9O1saZl6DfkHAUEy6PkBZoXlBzCAAmk38ZOTArvXyyXrD?=
 =?us-ascii?Q?+ey9Oi0Xs0x5dTXrHjNIC7jiXZtavDCtB4OSXsdGdNbWwjNHmgwNNw/2wMqk?=
 =?us-ascii?Q?J/iv+m1mIzRybC6RQ3SRhZt667oV91A3dkfAgDt8W6hx1mcHAdZTaPep9GIV?=
 =?us-ascii?Q?edq/wTP9CWViTFInz/b+v1d/D4wh2+5zVVxFTArO9NkR3jBYLRBdZH1SexkT?=
 =?us-ascii?Q?dMQEJV4b8trQIsSaKdwOEOUrgmnGrDutzC4sUhwuzFVqWlFcz2LZEFLsULi1?=
 =?us-ascii?Q?Oby6wzx7aJAofSXEW3awHY7dedkUmUg+DbSlVhjiEQWRyGx0+qeDVi6MHZ4k?=
 =?us-ascii?Q?7ZoaSWR6GTDD6RCT3IBHfvZq/zPonhl4rLgMgOb2RG7wCyt30aW6IxvSZLse?=
 =?us-ascii?Q?BvcWrUKylPU2Lqs+x/MZEwgiWllExo4m8YpC3zFQBKeoNitRIyDT27SUFFSe?=
 =?us-ascii?Q?TKnroeb4Yt+EyPXf+o71KTJ2jvRaW7mWcJDTIku7or7SR5pjADEuZWajTVZq?=
 =?us-ascii?Q?9MguGMduKKSwUSj31sp9K645Uy4AeNqWmVEKgSvqvPeIysC6dKV52Bqqt8jN?=
 =?us-ascii?Q?7+MGXoi8c/dYAfWRgmbGNb6RKTTIQ2tlnWqT19AoYseG7+1T1qkMMoq2Lg1z?=
 =?us-ascii?Q?CL1uIY+lo2z2umR0Y89HEqqp/FU3Om6EtxXnll8QVVkmgFLF1q3d7R9i2BTj?=
 =?us-ascii?Q?a5Htn3Yd6H8aFfRz/ucvvTymtPRcl48OSgQHS4xP5rb7fBDUoCXEtS2LsbLK?=
 =?us-ascii?Q?jb69zQhOTfvbgRgVWtjMaZLJB3TXTlosX3YHOp3ACjCWYtgCPec6Y5L8JRCQ?=
 =?us-ascii?Q?1pyvnOZAI0EOZLFpWqAUq/1Hxh6Jj01M?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 14:31:12.5583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40aceb49-d167-4dda-9f1c-08dccdb76467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772

Provide "nosnp" boot option via "sev=nosnp" kernel command line to
prevent SEV-SNP[1] capable host kernel from enabling SEV-SNP and
initializing Reverse Map Table (RMP) [1].

On providing sev=nosnp via kernel command line:
cat /sys/module/kvm_amd/parameters/sev_snp should be "N".

This patchset is based on tip/master.

Reference:
[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf

Changelog:
v2->v3:
  * Fix the build warning reported by kernel test robot
v1->v2:
  * Pick R-b's from Tom.
  * Include only those headers that provide the necessary definitions (Boris)
  * Provide appropriate references to SEV, SNP and RMP (Matthew)

---
Pavan Kumar Paluri (2):
  x86, KVM:SVM: Move sev specific parsing into arch/x86/virt/svm
  x86 KVM:SVM: Provide "nosnp" boot option for sev kernel command line

 .../arch/x86/x86_64/boot-options.rst          |  3 ++
 arch/x86/coco/sev/core.c                      | 44 -------------------
 arch/x86/include/asm/sev-common.h             | 30 +++++++++++++
 arch/x86/virt/svm/Makefile                    |  1 +
 arch/x86/virt/svm/cmdline.c                   | 39 ++++++++++++++++
 5 files changed, 73 insertions(+), 44 deletions(-)
 create mode 100644 arch/x86/virt/svm/cmdline.c


base-commit: 566644cc51d0b1ab7e98ea479808b1efd0bbe261
-- 
2.34.1


