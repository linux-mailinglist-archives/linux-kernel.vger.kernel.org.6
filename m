Return-Path: <linux-kernel+bounces-302985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 046F99605C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC2B23805
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3A819DF9F;
	Tue, 27 Aug 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="00pnEXng"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C9519E7ED;
	Tue, 27 Aug 2024 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751447; cv=fail; b=QDtow729OCs1F8Q9z7BUjSu96hf0lzAfdXwlWjunleAqyx6oKEEhIgMLlWPXTApsKiQchRxV9k36wShI5wtfnUilgUYJ+zjCDa5hSsburYAt0UD/FsKCFXKgfW2aHT8TVQB3tw3kPpFrXtEC9X+8fwEEtrR5AjPDFvlaJT3HLeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751447; c=relaxed/simple;
	bh=A2VBT/H8M5b+TvXnZtnXWfeFNqLZXOIkwyo8AOCLEqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBgmir8cR3rKFMCY5sgOGjGXj1qa2IkjywrGtYkY3w+pGJ2brvR+/eyMyQdz1WMhnYw3TRPHaw7Wr2dp4qo14gZr3cyIRuLIl6bGKXdIxJjhI+FwtBCU9hR82isYYDml7z0zMbsVbZ+DeilxOhTArO9znJ4wJ7q6PJLubItS/OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=00pnEXng; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynBUYFE83kpgKEQ25490D7zEufiG2lALVnkwsBYFOhD5LoD16HFSa4+qySp0/Ratr/wp+Gv0c6b4TLAgNhYNb29JPV7bHfa82BSFA2BF9tTEG5Al1YWrgQ0yH4wKKGOJYXQz3eJ3V14IJ0/Ux7TcTHdxv4bO+AKFN82Vw+EJ7FAIUXuPMD4sZd/u5ejyQLBRML1zktkix0TMy843fIVgP/y9VLfMUl4uExNTIDZ2s3E6OKbNKHG0z57MtK5jeTeJYHSMZ+5ueqYINginjofeKcKhqCWNshdnvHN3KTI9gmA8LoCTOh1DiYzvQ1sKjeGIrHD7zIHvRFkxkPuA1txMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpjYKwQZMF9AegQHrTsnTxpSmNrhCwTnBHGDXrb4CSI=;
 b=P8d/Hp7IcmnNcEZvGr2IkVWnCcSCWDNyAP+WUH4UqLsT6yFGQinYaXwGdsL99g2XIrMOmwjJRHIeMmy02jtEFQy/o+8YyfTkKGgYFP9xVo/+6LMVmyK6ZzzxSsQVbkGFg7RmUJ54vtoFh/J1PPT455a7SRz7pB3LFQgRkLGgkyKFWHZPxcdCmvYrUF2ntAkau0qvKTfHTf5MF/2656t6qhKaVCANjPbWRyISFmFvZeWFSvvj2sZ+JPqa3hpeF+LgB+BHWJP98sUwdyrwMVizIxH/roIt7imJ7dW+TeV5AePPPUKm2t6SSywy4f95D935aIbkjdXeJqeXBoWXlABtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpjYKwQZMF9AegQHrTsnTxpSmNrhCwTnBHGDXrb4CSI=;
 b=00pnEXngOQHAz1E/jHdwdLQQaDmW8gXnd2L5S1QWigSqJR9qg9tUmfPNl8NU8xFhpOMm0MVpqMGbdP9NamjYwqtj3k/aepYBABuPilqk+le94dZYKzUbB+tkTiePDglM+ws29jUCPLJs2RU10RoVuIjE7wD2AHy0cC7duvnTOyU=
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 09:37:22 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::fd) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 09:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 09:37:22 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:37:18 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<kprateek.nayak@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<bharathprabhu.perdoor@amd.com>, <poonam.aggrwal@amd.com>, <Li.Meng@amd.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Xiaojian.Du@amd.com>
Subject: [PATCH 02/11] MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
Date: Tue, 27 Aug 2024 17:36:50 +0800
Message-ID: <834ba08575d9c183f38927c9b46105d38170a25e.1724748733.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724748733.git.perry.yuan@amd.com>
References: <cover.1724748733.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: e40bbfd2-4446-4e38-b5ae-08dcc67bda3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4qXtwiq09HwfLO4neFsqeFNj5NnR3PWP3QN2ZRGaHiCcuiYtmYIe0mO/ufIR?=
 =?us-ascii?Q?oTbYDHll83+Kb4vvRCzq5a3tXtkrNP+hbPN4Ck9C9lrvps4HBGuqfY1n+tj0?=
 =?us-ascii?Q?9N2dd6yjytEcYixp1UqSGemNZ96PPVNK7iniKkVpaMNmgbVh1Ne3wdvGwWS0?=
 =?us-ascii?Q?nyW7TJTDajSpc3Mw1OJ02ZO4wjL0RkSdik8VlTXFieMd9Neh6bYXI61CHlGl?=
 =?us-ascii?Q?aJjEq7KR70wZ7pj8rUG8bYkIN9/9KqPbmhfDJPTLY1GoYMezKG+0ijmqe9t9?=
 =?us-ascii?Q?whO6J8NzDdbhfT3dCCxjPeqwSYXdHtZDKLdr6A34SPegmO2DYnWs9sakLYMs?=
 =?us-ascii?Q?qATkWRwkpguWpZ9YmrJCXElonBOQwJZFSSLWVmIed6pZewcYh1WUdUCc5mE1?=
 =?us-ascii?Q?7UcFhZB3AoeL8I5+PPJ+KnZ1qQpfMcNgV7Eo+Kj6H7DKi9ZoCBTPkfBH3KDK?=
 =?us-ascii?Q?RRhZopW2JFnyWWN8h6q9yKj2BrIDlrmrFvI8CDorHajiEEKFLE718Hlwl+V/?=
 =?us-ascii?Q?RJIcQKIfAKLJvutDMJIkxaBgHJFpn/cJFp00m3YeDznh4b0Oh6OZklDwG3Ul?=
 =?us-ascii?Q?uhw2kErpog/erGdUv6kdIadB9d1x7wWh2snNAJ43fnP3eLvm2P3+9nkOppln?=
 =?us-ascii?Q?sZFaoPgMOR8xVXnCu7qRtU0WH6wWw7TLs1JV38GddzHbbHC83Q9F8EmoP1si?=
 =?us-ascii?Q?R6Mud9LCNZxREk1rZ4/Mxq4Q95NtE2aLx8P2uQTTb+jq2vU+A2MvgR1GbRIE?=
 =?us-ascii?Q?Zod0twSGAz1KnNC+FpnJeAqaWhB+ziisdxE2HMN2aTetUuVNVQlMWop11RHe?=
 =?us-ascii?Q?Uj75fJbfrEtdet9ORlFdv/T1iUrWD2oz321dugiRIAuqkf1K9vsqIgq541ji?=
 =?us-ascii?Q?3vanRJ/yakQBQ1vQ/AcbklWXEr6gKHWG2vzPpB1iLYmFOlzyNKRgCvE3eIYt?=
 =?us-ascii?Q?zr3kBNLacZ7LMn8gXbcdRHJNSOAdQtonASD0pv6cw6nH91rB/dAKCoTje3z3?=
 =?us-ascii?Q?q+Va7nGDwQsWlCeGGRBtBxkw9a9C1UrU5sAXJ54K5W1Xon9kCpapkSjx8DoL?=
 =?us-ascii?Q?2xPMRMNGCFzT5R/ENeNLb3JmRy/VBS2ElbEpIdPeQlIbp/bsevR2LkAMhgbt?=
 =?us-ascii?Q?nW6ui6Lcau4Y9t2RBuccM1tD3nE3rMarnYZUHaqRltX4Zq7bvRRYLiQBdBwf?=
 =?us-ascii?Q?FjITtEGdIy0ic8AneD95JA4x0mgXfwMYfZWc+cXCU5WcbVNNKYt98ruS3vly?=
 =?us-ascii?Q?N6YVRGHnByzMaHy0g4TfzwgxhKsMr5vU5YbB90EW4+2bYJrAy0y9oTOL6drl?=
 =?us-ascii?Q?to9d2ETalcm5Jv1AeIPSbsOmDWHA7qeDvSA6/36SHTBg0554P3EeAnyNph4O?=
 =?us-ascii?Q?+FMDwUoaBWJSmWn8un+b/vQh8GMY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:37:22.3272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e40bbfd2-4446-4e38-b5ae-08dcc67bda3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce the `amd_hfi` driver into the MAINTAINERS file.
The driver will support AMD Heterogeneous Core design which provides
hardware feedback to the OS scheduler.

Moving forward, Perry and Mario will be responsible for the maintenance
and review of patches related to this driver.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03090276a416..3ccc782095f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1039,6 +1039,15 @@ F:	arch/x86/include/asm/amd_hsmp.h
 F:	arch/x86/include/uapi/asm/amd_hsmp.h
 F:	drivers/platform/x86/amd/hsmp.c
 
+AMD HETERO CORE HARDWARE FEEDBACK DRIVER
+M:	Perry Yuan <perry.yuan@amd.com>
+M:	Mario Limonciello <mario.limonciello@amd.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Supported
+B:	https://gitlab.freedesktop.org/drm/amd/-/issues
+F:	drivers/platform/x86/amd/hfi/
+F:	Documentation/arch/x86/amd-hfi.rst
+
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
 R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
-- 
2.34.1


