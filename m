Return-Path: <linux-kernel+bounces-548252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E806A54266
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7370F3A72BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC1718FC9F;
	Thu,  6 Mar 2025 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hr6FClkx"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61CA94F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240020; cv=fail; b=NIApA9ILz39MjDmTWs6tDT6tJVRbH7OdHVxfg8fX/jE2otXoEpi9kE0PdvSmO/ySJl4x8K0CYhoO0uCppWifZZdJgTmfIunKGboWoan6otB4CPljx4wp3VEA3Q9/Q22uuhJ6pZjhcrhr/a7DnomQu9hPsYuw5CbPPNi9BBw8RMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240020; c=relaxed/simple;
	bh=/rjw2Ih7fCOQAO2xHnPXbZtu8igCtidXk1tv5YDQMds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DDJqrOLiwlzdGYvMCKo0pxeT09kNluT1kxQlmgmpWHwRPk95c+oFpr9KiKBu5AEA6ulhHw4jUVww8k6+LpHsP2lWv3DMUgNCN+9YTFqTsWOWo/wvPZe8/MjcxT5qQSNZd0fSTPE7vqBwHcG4OrOJtv8XQh6YAob6eYWqTjyb96c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hr6FClkx; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDDYDIAXfIIy6/gLFX/bLsDnhpP5yX/7LAQCbO875GGlnkmSfMIDfKgtH0DOtShLHOtCu2V+p6w4zLOftiu2Ucs5UTS7Ad+ixml1rrG8TLasjPOo/gmxsKmdyo8D7j7bhUqR2q9No9qMbJtKufu7uoNzyXKouQnzyGVF9aNOx7BzBalna16agxk0OftdyrpqhI/L7Y1scO+SkZCL9Brbi/vRwgZd+E6SrgjGU2qWNzDAs7IkAuV+tS+q1yBh3VXc94Eyk+mL6iPawRs3Hgdg1INb8TvTz/KGpUMWMR0u+ZUfY+N23b0CUNUQTnS6jjLM7jZKCblLrFmnRvPOqKTcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QFKCbUCNC9TWnvnxFhbG/VkxsA1ZUaVDH8DZejw4kY=;
 b=ujrCipfjZlN1dMWRUFqv/z8gViCNx8qSKNuE7PaBkkR4yJaNGV6WJFuHAE8e9PH1dw1b0xAssi4y9q4/ZxvtgY0PxTOHK4DEYzDxfCsCZi9jICrEJ0zX8drTML73+XxOdkjLqHaT1Z18w8y2vdy0EwSyyfifLgQGFCHoVRXg+Pi8wG2hTkOEXTVCAbdoKbXKbJfyewjkasKurG+i/x/RE1GoFLOaYJe8+invYckqltEc1RDsQ+SOx6EZNyJI6uIjtvuqq0JH2TwHwvN7L0FZfMDLKS61cLYLtnHDrXtCl/YUMyIq6lu75GtDkwawsU2r24vwazQ2q9PwfC6Zow0Qfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QFKCbUCNC9TWnvnxFhbG/VkxsA1ZUaVDH8DZejw4kY=;
 b=hr6FClkxNIJ9TMv3ThAXnIfW7P4iV3jLa7IsOxjqPZFEmnzvdk5pRh/Ni5fsX1gs4gN/WwIHlU5uGMfRWXK6vN9VEfsuKQEwflYOtSa1r+EuVK0dcKJ2sGK3az4fEVPU7Rbl5oIeDMU8X9mwqDQAoLKIGgozn8i9w04RuqDsvGM=
Received: from BLAPR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:36e::25)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 05:46:53 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:36e:cafe::b3) by BLAPR05CA0023.outlook.office365.com
 (2603:10b6:208:36e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.20 via Frontend Transport; Thu,
 6 Mar 2025 05:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 05:46:53 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Mar
 2025 23:46:41 -0600
From: Bharata B Rao <bharata@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Jonathan.Cameron@huawei.com>, <Michael.Day@amd.com>,
	<akpm@linux-foundation.org>, <dave.hansen@intel.com>, <david@redhat.com>,
	<feng.tang@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<honggyu.kim@sk.com>, <hughd@google.com>, <jhubbard@nvidia.com>,
	<k.shutemov@gmail.com>, <kbusch@meta.com>, <kmanaouil.dev@gmail.com>,
	<leesuyeon0506@gmail.com>, <leillc@google.com>, <liam.howlett@oracle.com>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <nadav.amit@gmail.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <raghavendra.kt@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <yuanchu@google.com>,
	<hyeonggon.yoo@sk.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH 0/4] Kernel daemon for detecting and promoting hot pages
Date: Thu, 6 Mar 2025 11:15:28 +0530
Message-ID: <20250306054532.221138-1-bharata@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: a66aac34-be70-4e12-1afc-08dd5c724c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rv4zw5NrgjByDUjFdLMWpFl8OIKTrIcxewWeSOlUfwGdsdCaLOcokpBuZyvz?=
 =?us-ascii?Q?+ZULR2DgCcdEPkPxdXml7CXjrGtX+5PKM0Ueo3RIeHXPwElyssHpE6D6j7n/?=
 =?us-ascii?Q?b3xB7jS9mygWmhYHnCifTdteN1IpMmlVQ8rOES0dewHYJJ1meNBQVIBB+xrv?=
 =?us-ascii?Q?JX03PidR/W/c+VNoYhB2CdNIpVhTB+8d6BL6q1TYhDVGqZMiFfUXaAzSk42r?=
 =?us-ascii?Q?N3ipEZvoKsWJmCymRnJWoYMIhAiDRN+6yo9EoetGXq6tPqjeipZXVdOHXpT0?=
 =?us-ascii?Q?q3M5tu5zA1JB1Ve490O4RJr1LGhVFeN6+p44aS2DxJBVnlcXIiKbPgctyhXg?=
 =?us-ascii?Q?JPlg9FduNdCX0A9jZfrHZtg+2UpT3PMftAJ0hwYoJEq8vRQ5wJmbBfjd5YXL?=
 =?us-ascii?Q?4/7d18NyNCjCb4Ne11s/pV9jP1Yq4P2gF54XEnRpVW6T18SQjxEd3/UKZ7ml?=
 =?us-ascii?Q?+ypr6m1LuYM+eFlOQVSWu1HLiP9CJp4J0hZnKnTrH5smEkEZJ7jAZ2luwbHa?=
 =?us-ascii?Q?oZOwNfUmP82eizTwqc+Iu8EORN57A4rISDjbxk7s2NlkJkY75o4xgQFhdXoM?=
 =?us-ascii?Q?uOGd4u4SnI2jMgwX6JHnkQdQrlWWGtFdHfVxFdJJQ+i6LwrHaXxpxqfeW9/v?=
 =?us-ascii?Q?zV5jegT6z/sWQQ/2qjXxZ25XViM+FAL/rxlrA3GzSKXMMGOcDbwMP/lTnUDd?=
 =?us-ascii?Q?666CLMm9T+E9dqwpp4lSx9Gz5bUC/V7V69I/BC6TYY0g7GP93Dt30qC9EHRW?=
 =?us-ascii?Q?kDqykxWss2rOgE5XDYAWkDVVmlekjPoyguiyzZJ3hFf+t7GcVnut3sdEWUMR?=
 =?us-ascii?Q?m6Z7S5TEx7b822kmHAMauplOeLpkNV42rD3BVpvbJjz1bPqlUqETKTVKlGJi?=
 =?us-ascii?Q?QBwrq22mnm5tiKHTKzEjzdezMNqGk1l5VkJ85fcZYcR3porBtQzC4iIlx8e2?=
 =?us-ascii?Q?5+mbP9TFJDpJia/9Kteqy6evFMSSARJ8IaUkxxGwVRypG2gD0Zaf8Er61v3S?=
 =?us-ascii?Q?6CCKBIjmt7EMsroQEEUENpGCVQqDmtdBYfy4/FgmwRvL5FG3p95C6p88qBZO?=
 =?us-ascii?Q?6WzJs/iMtsUriAYyOaCCSXtZQjPVxrnc8we89nJcirJJXH8rQqdkuDXB4bWz?=
 =?us-ascii?Q?CaaSZpEjJOsTS8o1ugqMN5/jb4zdKHyazR9Z7UPddFLViZyoTCK0NB+UdjFl?=
 =?us-ascii?Q?lwLGOLSGFPPIURiYqaOKfK46oH852CsAnszCQ2T6c3HQAcVo3wrRoEidUE6J?=
 =?us-ascii?Q?LnlWwbKS3916KOMKNuaqq5t7zEwC3F/vdAqnmfMR03CUKe0ZvdC31AjBeMJ7?=
 =?us-ascii?Q?SI75V+9Kssybz9f+8BywDW4tNe4du/KgEaOtI2R5hATPF4VvYKUXOCyjeCVQ?=
 =?us-ascii?Q?E7OJvSDzz68bd8qbatXzyYA5B4vj4wnyBJAvVEdCdmH5ONwbscZ5NtiR3df8?=
 =?us-ascii?Q?z+6y8mSREXwk9K4OsiStFwSkt23X4Cr7nPJ72dPEikwMhbcqlJJfBEaQIuBt?=
 =?us-ascii?Q?sSpASgJbutKdw2w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 05:46:53.4583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a66aac34-be70-4e12-1afc-08dd5c724c72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229

Hi,

This is an attempt towards having a single subsystem that accumulates
hot page information from lower memory tiers and does hot page
promotion.

At the heart of this subsystem is a kernel daemon named kpromoted that
does the following:

1. Exposes an API that other subsystems which detect/generate memory
   access information can use to inform the daemon about memory
   accesses from lower memory tiers.
2. Maintains the list of hot pages and attempts to promote them to
   toptiers.

Currently I have added AMD IBS driver as one source that provides
page access information as an example. This driver feeds info to
kpromoted in this RFC patchset. More sources were discussed in a
similar context here at [1].

This is just an early attempt to check what it takes to maintain
a single source of page hotness info and also separate hot page
detection mechanisms from the promotion mechanism. There are too
many open ends right now and I have listed a few of them below.

- The API that is provided to register memory access expects
  the PFN, NID and time of access at the minimum. This is
  described more in patch 2/4. This API currently can be called
  only from contexts that allow sleeping and hence this rules
  out using it from PTE scanning paths. The API needs to be
  more flexible with respect to this.
- Some sources like PTE A bit scanning can't provide the precise
  time of access or the NID that is accessing the page. The latter
  has been an open problem to which I haven't come across a good
  and acceptable solution.
- The way the hot page information is maintained is pretty
  primitive right now. Ideally we would like to store hotness info
  in such a way that it should be easily possible to lookup say N
  most hot pages.
- If PTE A bit scanners are considered as hotness sources, we will
  be bombarded with accesses. Do we want to accomodate all those
  accesses or just go with hotness info for fixed number of pages
  (possibly as a ratio of lower tier memory capacity)?
- Undoubtedly the mechanism to classify a page as hot and subsequent
  promotion needs to be more sophisticated than what I have right now.

This is just an early RFC posted now to ignite some discussion
in the context of LSFMM [2].

I am also working with Raghu to integrate his kmmdscan [3] as the
hotness source and use kpromoted for migration.

Also, I had posted the IBS driver ealier as an alternative to
hint faults based NUMA Balancing [4]. However here I am using
it as generic page hotness source.

[1] https://lore.kernel.org/linux-mm/de31971e-98fc-4baf-8f4f-09d153902e2e@amd.com/
[2] https://lore.kernel.org/linux-mm/20250123105721.424117-1-raghavendra.kt@amd.com/
[3] https://lore.kernel.org/all/20241201153818.2633616-1-raghavendra.kt@amd.com/
[3] https://lore.kernel.org/lkml/20230208073533.715-2-bharata@amd.com/

Regards,
Bharata.

Bharata B Rao (4):
  mm: migrate: Allow misplaced migration without VMA too
  mm: kpromoted: Hot page info collection and promotion daemon
  x86: ibs: In-kernel IBS driver for memory access profiling
  x86: ibs: Enable IBS profiling for memory accesses

 arch/x86/events/amd/ibs.c           |  11 +
 arch/x86/include/asm/entry-common.h |   3 +
 arch/x86/include/asm/hardirq.h      |   2 +
 arch/x86/include/asm/ibs.h          |   9 +
 arch/x86/include/asm/msr-index.h    |  16 ++
 arch/x86/mm/Makefile                |   3 +-
 arch/x86/mm/ibs.c                   | 344 ++++++++++++++++++++++++++++
 include/linux/kpromoted.h           |  54 +++++
 include/linux/mmzone.h              |   4 +
 include/linux/vm_event_item.h       |  30 +++
 mm/Kconfig                          |   7 +
 mm/Makefile                         |   1 +
 mm/kpromoted.c                      | 305 ++++++++++++++++++++++++
 mm/migrate.c                        |   5 +-
 mm/mm_init.c                        |  10 +
 mm/vmstat.c                         |  30 +++
 16 files changed, 831 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/ibs.h
 create mode 100644 arch/x86/mm/ibs.c
 create mode 100644 include/linux/kpromoted.h
 create mode 100644 mm/kpromoted.c

-- 
2.34.1


