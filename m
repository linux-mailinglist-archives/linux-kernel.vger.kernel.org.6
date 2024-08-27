Return-Path: <linux-kernel+bounces-302984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 053F09605C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEAA1C2252B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB5D19E83C;
	Tue, 27 Aug 2024 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m1gD1VsM"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2819E7E7;
	Tue, 27 Aug 2024 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751447; cv=fail; b=WRdhsAew1riml3Uvf+tIg32O+UeLI+ySdXEc/ouXH6ZLkihE5osjNKnD1tjg10SVu+9FH74kLt0ml0XrHd5O6+SbWLzKLmrHbQkPMXvVE9qRtmd7ETsswykvQv5KK+NlhKfnxay+9Ki7d6qtdvePSWhc1GVWM57t9uSVoX3WLoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751447; c=relaxed/simple;
	bh=f1HJrwMyY8NsIOBau7DUjfgfPFrRI5n1Z/QQpTxm1YU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AylfNte3DdvioURB33el8qnDaDGV8Oyr4Vax657eK/1AxzGleqT5Dyp8fWnwCNYP5HiW3Uj7w71a699RcaVTXIf7zAYrf9HF8jpem8dnI63wz7m5JdqM6U50rCslmqPW7l95cMhEFvuhejrsiiwf3scG8N7TeVifk94R2VQJCBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m1gD1VsM; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6Jbxt7HRAzrvgwpU9Rnc9io1TXHyE+zoC4QkS23kQQwltmJ0B/1z4Boa2yVOxi1cMZ8cWVaR7WevzAIdExPyalvG5oVkO1RBw3Tx3wHC8QdPAAM6olgkAtFlacDSBS18VhKumnyIpOU9OZy6btQVepBMQtnH33OCfY9f690opq2ct19JPE+nhq28VUbFs1W00gsi42oxeluBKvwPlps9H3Oiiv4dHm6AHyW4hodpS8NNzfW0JW0BSoYDldeJKs7Eq4mnB3jnz8HPt4eDDD234+kN+F82b7hDp1YnagtZM/NATWRmqi6wGwXY7+yCDq5UbyGhVIWr/H5/VmQ0EPkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfEcAdoq4PWvoAXcQ/AMfw63Fvi6El4jlWXjBlokGoA=;
 b=VZczT+Au5J1yWrsNLZlQ+iQJNUGGxGkOornBeLsqcRWuNvAZrU+pKaBWyCwYyOwWy4sePaY7qGjvQ7tLZgzL/4F/dfEOkAN6AbpdUDZr5wQy7x623bkyhs9FUwTkF4n4ywEDvF7ynjmAUvSN8pXoEPSYbZGLgfUOTuIbEhKX61Z9glJsPyc/fLxDOfh0WPJYiCWgtNCC0SLbgQ+AiaZ99+fm8AAKheDg4Sy7Ps19rkySnXNrybN0X9l9xTOm8sdQmKrjIjJNNRQ1PNKmYyt+vaRo4N0YQCuPP1XQfmmVG6BbP0OavvQwtGw0PvD/CI11hUIOUe/hTeHilIqriqNY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfEcAdoq4PWvoAXcQ/AMfw63Fvi6El4jlWXjBlokGoA=;
 b=m1gD1VsMSLhh7BShYtXXohI/HYNcjkWklrUn8HrZZ5jcvkaI6+JLLXOKUd5pYKjkbQEH4u4kHt9OpKUkQZsJeL8JzjWIMbj9zPzcGovfg9D2IIoQE64vvRRI7CGo0WV+tmLZl/nlzqNEr5BfOXTLsSIYk478dpcCJY3bZ5qSd2o=
Received: from BL1PR13CA0295.namprd13.prod.outlook.com (2603:10b6:208:2bc::30)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 09:37:20 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::2f) by BL1PR13CA0295.outlook.office365.com
 (2603:10b6:208:2bc::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Tue, 27 Aug 2024 09:37:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 09:37:19 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:37:15 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<kprateek.nayak@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<bharathprabhu.perdoor@amd.com>, <poonam.aggrwal@amd.com>, <Li.Meng@amd.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Xiaojian.Du@amd.com>
Subject: [PATCH 01/11] Documentation: x86: Add AMD Hardware Feedback Interface documentation
Date: Tue, 27 Aug 2024 17:36:49 +0800
Message-ID: <c4c66679fc6f8432c0402c8def2dc1b09eaa812d.1724748733.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 93360697-4a1d-4cfa-cdb1-08dcc67bd88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4RzumS178sc32/z+sNoSJh8Exmc6cDiT8f03gnBVRf3nuyYjadFsmAcy4qSd?=
 =?us-ascii?Q?KmQT6Qr9uQUCA+KHU2yo2Py/11kgyAXpzSYqpKdWSLK7J5tD5c9riOAyD4xT?=
 =?us-ascii?Q?D2XXFr7HidGCy+bJx39P2ddTwXLeYFsyX5yFfKhFusPrlWctYON4vtwXW7sl?=
 =?us-ascii?Q?+WjdjLxr7WUYrOJWCNZ8OGEiRkCaxRBPQcPAhaEwyqkOFksL4DGQwNjhGG5Z?=
 =?us-ascii?Q?AncfOYXyRPT8KSLJkQwyBbcxcRRUcCMDiIGOjv9hHZzIQ6tFB3F5NGc5mkhB?=
 =?us-ascii?Q?C3f4Z6/FH4ehF4kNKOgkwuNzSI/C5PT42wWCJJIWANrxMKkXjrEjPh3b1q0O?=
 =?us-ascii?Q?A7r4/s1CAHDeYWC3cUxg9HbqxGkNS38kJeJn/mmw6aX7ZkM+jbAsaashiapH?=
 =?us-ascii?Q?IDRuS3T8H83h3fjpZBaD0I4vCrGm3zPqLSFyAfhO1dBu6rEsXQhY9n4+9PgQ?=
 =?us-ascii?Q?BYVjnQbiy5xN0UIEJwXknelp52wI2FMeGlW/rxSdxIEXQXzabsLQAzRKaS9U?=
 =?us-ascii?Q?kQ6j+o7aX8LhsTpS4qH8rtUd1iJ5+W5p9sxpxd57XSQn8PFpet0XJIZU7Lon?=
 =?us-ascii?Q?cOwJtqg4qA3c3In2uzGGtWErT/HHq+9tQthpS658e6CXkjRvmuo8baGsKbsF?=
 =?us-ascii?Q?yhfKDsM7ZMgOMT3XSPXB6QGhJg4xseCeiRm++TgFOywxbBZ3xsufV0pzW9zU?=
 =?us-ascii?Q?SlB6tsihRYCjrT+6lGV2nwjdX0jUqCxcwx1dB3faA5k7YKlX2gl1VqSm28cU?=
 =?us-ascii?Q?BL2fr2yTgg4j4j/h/r9ngkQBRAAp3G1MNUHz5+yUcGXaYHaX9w8X36rMY6y6?=
 =?us-ascii?Q?U3s0NWXY5FaqPDvJ3+imoKavdCm+OFhTMNf4uJcT6UILmuvPD6t0ZXDslpMT?=
 =?us-ascii?Q?yIsowtgrRxKcXu+2AJ6tfaU9L9wJ0RdPu/ZZGBB9bXuEpf3axbnueEIrRtG+?=
 =?us-ascii?Q?PY5rPk9M7Y1+9bGcQmk4+KxcYa2XtmJqxCKve4xZi9cwEPRKscrgmIVTKo7F?=
 =?us-ascii?Q?7YL1FRIDNlhzqoYHSOSGrtfDNooj0tZgxP0/Cjkau9BzlRDwxMh8YWrGo41e?=
 =?us-ascii?Q?Hyzxo3Izps6z2EIHiG9JKxrWL99xTs2cV0YbLBGy2lS5U8Dqfga4Og6lB4iV?=
 =?us-ascii?Q?uN6V4bbIwh8A+37wACRgLa1DpiMmxDKEZcMSR3kC4Ln4WuqXB+DXDsvhv7h6?=
 =?us-ascii?Q?FLustrWrsEdr1k+m6QqAM4frbsh0sND/WZXH4dC4692whaOLegGtL2v4EeyZ?=
 =?us-ascii?Q?k6rUjmycBonVwsrtU4vuymAOKF8DvZKjO1nD8QqkK1sJCO12KLlr057YJB+R?=
 =?us-ascii?Q?K1QqG4dqkAgx6XKA9U5CkLts8cYc5J7rQR194opBJYFZH8SrAW/QA6FSq6lb?=
 =?us-ascii?Q?cAdItLi5KbH486TQoGvdPA0GcCIx/CcgKOenCuSRQj70AMxtmSnaS/3G9Z7L?=
 =?us-ascii?Q?GUQjJzRKRU70yl2QlOYIS4CQIeScjckC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:37:19.5032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93360697-4a1d-4cfa-cdb1-08dcc67bd88e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce a new documentation file, `amd_hfi.rst`, which delves into the
implementation details of the AMD Hardware Feedback Interface and its
associated driver, `amd_hfi`. This documentation describes how the
driver provides hint to the OS scheduling which depends on the capability
of core performance and efficiency ranking data.

This documentation describes
* The design of the driver
* How the driver provides hints to the OS scheduling
* How the driver interfaces with the kernel for efficiency ranking data.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/arch/x86/amd-hfi.rst | 116 +++++++++++++++++++++++++++++
 Documentation/arch/x86/index.rst   |   1 +
 2 files changed, 117 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst

diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/amd-hfi.rst
new file mode 100644
index 000000000000..351641ce2821
--- /dev/null
+++ b/Documentation/arch/x86/amd-hfi.rst
@@ -0,0 +1,116 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================================================
+Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
+======================================================================
+
+:Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
+
+:Author: Perry Yuan <perry.yuan@amd.com>
+
+Overview
+--------
+
+AMD Heterogeneous Core implementations are comprised of more than one
+architectural class and CPUs are comprised of cores of various efficiency
+and power capabilities. Power management strategies must be designed to accommodate
+the complexities introduced by incorporating different core types.
+Heterogeneous systems can also extend to more than two architectural classes as well.
+The purpose of the scheduling feedback mechanism is to provide information to
+the operating system scheduler in real time such that the scheduler can direct
+threads to the optimal core.
+
+``Classic cores`` are generally more performant and ``Dense cores`` are generally more
+efficient.
+The goal of AMD's heterogeneous architecture is to attain power benefit by sending
+background thread to the dense cores while sending high priority threads to the classic
+cores. From a performance perspective, sending background threads to dense cores can free
+up power headroom and allow the classic cores to optimally service demanding threads.
+Furthermore, the area optimized nature of the dense cores allows for an increasing
+number of physical cores. This improved core density will have positive multithreaded
+performance impact.
+
+AMD Heterogeneous Core Driver
+-----------------------------
+
+The ``amd_hfi`` driver delivers the operating system a performance and energy efficiency
+capability data for each CPU in the system. The scheduler can use the ranking data
+from the HFI driver to make task placement decisions.
+
+Thread Classification and Ranking Table Interaction
+----------------------------------------------------
+
+The thread classification is used to select into a ranking table that describes
+an efficiency and performance ranking for each classification.
+
+Threads are classified during runtime into enumerated classes. The classes represent
+thread performance/power characteristics that may benefit from special scheduling behaviors.
+The below table depicts an example of thread classification and a preference where a given thread
+should be scheduled based on its thread class. The real time thread classification is consumed
+by the operating system and is used to inform the scheduler of where the thread should be placed.
+
+Thread Classification Example Table
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
++----------+----------------+-------------------------------+---------------------+---------+
+| class ID | Classification | Preferred scheduling behavior | Preemption priority | Counter |
++----------+----------------+-------------------------------+---------------------+---------+
+| 0        | Default        | Performant                    | Highest             |         |
++----------+----------------+-------------------------------+---------------------+---------+
+| 1        | Non-scalable   | Efficient                     | Lowest              | PMCx1A1 |
++----------+----------------+-------------------------------+---------------------+---------+
+| 2        | I/O bound      | Efficient                     | Lowest              | PMCx044 |
++----------+----------------+-------------------------------+---------------------+---------+
+
+
+AMD Hardware Feedback Interface
+--------------------------------
+
+The Hardware Feedback Interface provides to the operating system information
+about the performance and energy efficiency of each CPU in the system. Each
+capability is given as a unit-less quantity in the range [0-255]. A higher
+performance value indicates higher performance capability, and a higher
+efficiency value indicates more efficiency. Energy efficiency and performance
+are reported in separate capabilities in the shared memory based ranking table.
+
+These capabilities may change at runtime as a result of changes in the
+operating conditions of the system or the action of external factors.
+Power Management FW is responsible for detecting events that would require
+a reordering of the performance and efficiency ranking. Table updates would
+happen relatively infrequently and occur on the time scale of seconds or more.
+
+The mechanism used to trigger a table update like below events:
+    * Thermal Stress Events
+    * Silent Compute
+    * Extreme Low Battery Scenarios
+
+The kernel or a userspace policy daemon can use these capabilities to modify
+task placement decisions. For instance, if either the performance or energy
+capabilities of a given logical processor becomes zero, it is an indication that
+the hardware recommends to the operating system to not schedule any tasks on
+that processor for performance or energy efficiency reasons, respectively.
+
+Implementation details for Linux
+--------------------------------
+
+The implementation of threads scheduling consists of the following steps:
+
+1. A thread is spawned and scheduled to the ideal core using the default
+   heterogeneous scheduling policy.
+2. The processor profiles thread execution and assigns an enumerated classification ID.
+   This classification is communicated to the OS via logical processor scope MSR.
+3. During the thread context switch out the operating system consumes the workload(WL)
+   classification which resides in a logical processor scope MSR.
+4. The OS triggers the hardware to clear its history by writing to an MSR,
+   after consuming the WL classification and before switching in the new thread.
+5. If due to the classification, ranking table, and processor availability,
+   the thread is not on its ideal processor, the OS will then consider scheduling
+   the thread on its ideal processor (if available).
+
+Ranking Table update
+---------------------------
+The power management firmware issues an platform interrupt after updating the ranking
+table and is ready for the operating system to consume it. CPUs receive such interrupt
+and read new ranking table from shared memory which PCCT table has provided, then
+``amd_hfi`` driver parse the new table to provide new consume data for scheduling decisions.
+
+
diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
index 8ac64d7de4dc..7f47229f3104 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -43,3 +43,4 @@ x86-specific Documentation
    features
    elf_auxvec
    xstate
+   amd_hfi
-- 
2.34.1


