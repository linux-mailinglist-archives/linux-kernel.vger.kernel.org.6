Return-Path: <linux-kernel+bounces-302983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A99605C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF650282E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D109519E7DC;
	Tue, 27 Aug 2024 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HmuP3BAs"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7C19DF9F;
	Tue, 27 Aug 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751443; cv=fail; b=oKLZ2EkMfWaHBkhJ2KBo7jUKk5NyhQ92rME4osBlQWMoe+b7NHrqoBdeQZSvlEId2IhpENJorBlptmQViQVIs9Xl4B3nZcVlCrqOwecSLPPOR/Ap6VG5bf2GggXFRheHzPuEGMMmin5ijNyKNDUI3ItquVh/BEsL6lzTttmQz3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751443; c=relaxed/simple;
	bh=8vpOOPZvEZGcjsE0agfCiWI/s2EM2ORK/grTHW1Cv6w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q4BkCjsv7Jk0bhRO3XZ5vjkhQEa/e4yDmjhNM7MlvdJr33XRLB9YU/QqNFQf29zQoaQ6iEbE4uksdxST22fCSirJHZbJMXIhktVFmbzpM5sBPMV9NBOC4mXE0NzvOIpXGEVZeFvB4dF8Q6pv5F7vIVtJo6k/pywyQjZ7mD6RMO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HmuP3BAs; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPI9elr/01BguvfXGxqdHwT2c/om/oO7L8xBBXIxEC4BgwmGQHp3tbqBtyGKR+f8oQMf+0KHCvawhqCzwvA7TVCgz0C7z4bjY6BsZohYskXvJsKhEUo6xd7TYXU7lSHHaOBkVRCnqGSwLSRvnLAKhOI5anb01CGcVlYxj56c4gJy02z50LCu+JNI8WIhj0cxUuRVYrXjXruYegSuixwIPmuY9zdYukskEu63HC2J0o1tkfucMoUTFlE5Sfd4XFkK+HDqT24mwP8lk6XRLIKR1SrJ3R1HGLWVCJq6re/UD62JuT57NulA++axPxkRWICv6yfNK47i7imdDP4W8IilYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GpQrVPkG7qVwuGt8iPfF3Gda62wIi2COZkLUdNdTlY=;
 b=PcUbCEdFMqqBxRutmAL7cbzZgtaYznqeGS99QZGRUmUKI9etdnaSYOHc32YB3b0QUAkqB1+8KbJIRDhILv+cEsfEC6l/3TMs+1QTp3fASOAXBfQcUpgb5cV+tg6/KWj2hPaiLeYDe0/9WFFAeD5U6wuqa1mui8RNjvc1cA7wCday1VLSJ6DkHvsHRmD6WSXYJeUvwfqfDSEo3G46nPqvx8alZk0D/NFa54bjz7rbYv8CzkQI7X6vVgmU6WczjQO3+4rm4KI5qZ9zbTFDCbIqRmy0sWwYxVxG4S9oJdXuAGiuN1IpLjiP0oeEA1FX7ya7NogNGsrIda5N1WsLTKgasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GpQrVPkG7qVwuGt8iPfF3Gda62wIi2COZkLUdNdTlY=;
 b=HmuP3BAstrMR1FIK6hI2k+erD6cd6bx4PZfZmjgs77dkEsYJtSDZspT0hwhc83VSpO6RKWbWBLJQ7J2qgZADfGW2nOurMFux3oaV8LAPcjTJFL96fXBp1kz57iodcJJitRg+QDU3vcnssIxzIC5iRWyyv6y2Pj+VAOeqU+l0QTM=
Received: from BL1PR13CA0284.namprd13.prod.outlook.com (2603:10b6:208:2bc::19)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 09:37:16 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::fe) by BL1PR13CA0284.outlook.office365.com
 (2603:10b6:208:2bc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.16 via Frontend
 Transport; Tue, 27 Aug 2024 09:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 09:37:16 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:37:11 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<kprateek.nayak@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<bharathprabhu.perdoor@amd.com>, <poonam.aggrwal@amd.com>, <Li.Meng@amd.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Xiaojian.Du@amd.com>
Subject: [PATCH 00/11] Introduce New AMD Heterogeneous Core Driver
Date: Tue, 27 Aug 2024 17:36:48 +0800
Message-ID: <cover.1724748733.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: da594d49-9ca3-4cf7-0b66-08dcc67bd6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ponWx6bjcFLNXh9CZ0GMN9D9AyZ2WWSJ3bNxs8lAQLOrqvfQCdR6uRjTrMEs?=
 =?us-ascii?Q?VQ3yBLD49ZOGUOqRs0oO3DU5hsf3K6eqjKRYxrbP85Fn9HzaD7cajVhAdrAm?=
 =?us-ascii?Q?7p42tvL3i0qkXeYWNgWwgjperY0W9aX17wLbgwT8kay96Pqmt4YsZMYtLNkz?=
 =?us-ascii?Q?iQ5c3/MNCaTeYxNFLC9oi32XanBcnhOkL32UQqWGq7Nu1mmqg5CYd8Uevr/J?=
 =?us-ascii?Q?gZ6MX/iv53MBGqvhcwo2WX2PQ1l6YYHCIdAlkogxRdUsZDcD472rjdFdEnQz?=
 =?us-ascii?Q?xHhEpeuWR4ImCYfNvAtE3bRCr5dNTuW09rmaFAmHaEJt9IgmXKvvb+ThSiME?=
 =?us-ascii?Q?j+AEDLsfHiFOesZoQuq5iul1wGs+DN7J+Fo3kuUi0jPrm0Ymg4D+EIQjftkJ?=
 =?us-ascii?Q?iev8uzsFLRTICpFZE5121V04OWOwm9HWpWuwQNN+/1nR2PNsBpMm1Z5upouY?=
 =?us-ascii?Q?e7cnEX0sxjwPrTCJIv6eoS5lT1Yvx0mww7MyCyWoGZDOh/d3H02MM4r5qAdd?=
 =?us-ascii?Q?U0FFztevPulRNng/k2z706/WPiXXqm5k2sUAXrbYngFLgGBVtIvuPIigkQOa?=
 =?us-ascii?Q?nywDFYT5zK3R9DTJzjxH2JENJDTdlJ2Z6JWEvu/DaYlbFOewH9WPELgdNOu9?=
 =?us-ascii?Q?Edd2kw5f5kgM0Shn/zq8tYe+k3cGbPDMf7gg8DrnrqoNG3aNbSqCkfOkL7Fe?=
 =?us-ascii?Q?fJEPnpW0wtMGZmWh5YWmGQnbzNCU8gzFvXG+/v3q4aitUtpBwxB0+ZDpfz6X?=
 =?us-ascii?Q?SPAJa06qtRS4tB41m9Neny4w08e4AwE8n/impxDQBRSWVJ2eFNEYFcCjQ4G5?=
 =?us-ascii?Q?S6oH/KvNCBvdxuplbaxB20fY98xiSDxYcngyP9Yzilma3dri2Y0pJjXd4Ifs?=
 =?us-ascii?Q?raz1qyiC3qD14iNnnpMwfpu9ekAqWaiYWxESa1a7EyX0hf9499kNkRsG/vW6?=
 =?us-ascii?Q?OkyUWfjO3T6XhsTcobe+IqB5TxduH5KmHo+k7W6agWGD92BLtdw0Z7pAsjWz?=
 =?us-ascii?Q?opJB6U860tdQvrbAY1bAgffZ+BtoPCTDXyAWhEKrANsqW7cvMAC498qMyair?=
 =?us-ascii?Q?h+uXuL4NL5V7UypUguAyaziGPJtglmioNyFT1W5Tmp4jMRkzwW8Ar3zDTTIo?=
 =?us-ascii?Q?U3dyKJsnxDjc6SRouQbnl6K72UYRjg2xP867XNnEetJV1oaZJ6UArGEB+cKE?=
 =?us-ascii?Q?pbUKnLLqz8bMysCPqaA3MRRa56flp7l2JjXDiEni6cerWVsDhWU4YprbeeNk?=
 =?us-ascii?Q?q9PUp1E0k2xogFMLQEsGrSBBMPPzD+74Rrx2FeDHXycNrpa7HTQeKsVbR1+v?=
 =?us-ascii?Q?GiBuabfxnEZYz1sueekHAJVrdaEcyGN/aKmV++bsVUO3o//3kpXBTOo/fTBS?=
 =?us-ascii?Q?OUyH/YkdQkh5dzpa+q3em1V0Ov2Zp2bQZpdyCs5TL1+o+WEKbyXvwWSTIl6Y?=
 =?us-ascii?Q?NhDgWK09pPG4qEqAh//cNzEbuqzasE8v?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:37:16.3001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da594d49-9ca3-4cf7-0b66-08dcc67bd6a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946

The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
provide behavioral classification and a dynamically updated ranking table
for the scheduler to use when choosing cores for tasks.

Threads are classified during runtime into enumerated classes.
Currently, the driver supports 3 classes (0 through 2). These classes
represent thread performance/power characteristics that may benefit from
special scheduling behaviors. The real-time thread classification is
consumed by the operating system and is used to inform the scheduler of
where the thread should be placed for optimal performance or energy efficiency.

The thread classification helps to select CPU from a ranking table that describes
an efficiency and performance ranking for each classification from two dimensions.

The ranking data provided by the ranking table are numbers ranging from 0 to 255,
where a higher performance value indicates higher performance capability and a higher
efficiency value indicates greater efficiency. All the CPU cores are ranked into
different class IDs. Within each class ranking, the cores may have different ranking
values. Therefore, picking from each classification ID allows the scheduler to select
the best core while threads are classified into the specified workload class.
The cores ranking table is provided with PCCT subspace type 4 shared memory, which
includes the memory base address and length

The series is based off linux-pm/bleeding-edge branch firstly,
will be rebased to platform-drivers-x86 in v2. 

Thanks and BR,
Perry.


Perry Yuan (11):
  Documentation: x86: Add AMD Hardware Feedback Interface documentation
  MAINTAINERS: Add maintainer entry for AMD Hardware Feedback Driver
  x86/cpufeatures: add X86_FEATURE_WORKLOAD_CLASS feature bit
  x86/msr-index: define AMD heterogeneous CPU related MSR
  platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
  platform/x86/: hfi: parse CPU core ranking data from shared memory
  platform/x86/: hfi: init per-cpu scores for each class
  platform/x86/: hfi: add online and offline callback support
  platform/x86/: hfi: add power management callback
  x86/process: Clear hardware feedback history for AMD processors
  x86/cpu: Enable SD_ASYM_PACKING for DIE Domain on AMD Processors

 Documentation/arch/x86/amd-hfi.rst    | 116 +++++
 Documentation/arch/x86/index.rst      |   1 +
 MAINTAINERS                           |   9 +
 arch/x86/include/asm/cpufeatures.h    |   1 +
 arch/x86/include/asm/hreset.h         |   6 +
 arch/x86/include/asm/msr-index.h      |   5 +
 arch/x86/kernel/cpu/common.c          |  18 +
 arch/x86/kernel/cpu/scattered.c       |   1 +
 arch/x86/kernel/process_32.c          |   3 +
 arch/x86/kernel/process_64.c          |   3 +
 arch/x86/kernel/smpboot.c             |   3 +-
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  21 +
 drivers/platform/x86/amd/hfi/Makefile |   7 +
 drivers/platform/x86/amd/hfi/hfi.c    | 665 ++++++++++++++++++++++++++
 16 files changed, 860 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst
 create mode 100644 arch/x86/include/asm/hreset.h
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

-- 
2.34.1


