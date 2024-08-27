Return-Path: <linux-kernel+bounces-302988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2377D9605CD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EE01C2272B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E925319D88C;
	Tue, 27 Aug 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xJ9NX8Qw"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378E19FA7B;
	Tue, 27 Aug 2024 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751460; cv=fail; b=kxhVQfFqayZZRywPc29SahV2DE9eOX5vhdwKDv4M5aTL4JyRpYz5IMgZ4LRfQxMBTcSyU8fH9bJVDmW2XX/yJqNSlLjgnCjktReo47QEaxdZTPrw5jbhoV2MBqojEry9Cd3f2xIKEJwiGZlW+c2IjN7zZJe01v/OimfueHJN1BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751460; c=relaxed/simple;
	bh=l4XkFxfSzKibQ1eBv+4yODaRrq+SrejBuE1mMyrEfnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGmMCmXEhwZpbDI6pPP+SRE0MEGrIWGh0V8VaA1F6NEA8lbFIfO8QSbNQNdJ5p9Ud75W+NEL712nJLn02Njo7zD0yh1s8wwyQodhEfKzOmMPbjgIp7xyLor3InVwR8OG423vCiNVElmzTGqG/LyF7ClfpVK1mRDl/Se1wO5x50I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xJ9NX8Qw; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esognMKxQAy3Xe3suxTALWRGBitoSRpOjgDqrk/9ndG/Zcq977OKxGp1y/mtLBlSJiUr0xzorZpPMloGenjKO9Zia0vmeJVz4abWU0jlS8Y8AbmxZrayUzlG/C/ffdG4JQLPRd8nlW6aFpTR+Po9rNKxX6qhqH0C5O0BEEtBbR10l9nycSMNbHLjoJX6qU/fNtmCl4F1KAW4KlNxBrGrmKhsU96UuWZLsq3Z/Wej8aWcfxY0ev9tOcdMdeWkqtURSZ3TqUP8a6kQWNPKYHA3RywzJU/NRUkoypisYynv1pk6wz4G6USy2t8DNVuEowYXVd8CdjEJLWMaK3Nq3CDGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVI/CiHxcPCx4S1knXybWUT9l2XPYzJS5B84mmHsk1c=;
 b=WTUH5nGOMm9yNznJSXBAXGRdskhMrlZQDSBLBBnSIklnre/t64TSraiUu38Y67l27Pxuei0eNoT5wTtVnKKA2AvB8tJ5fJLsw74YdbGcoKaT4ilIORQeDWVpIDNu/d+4oKH8kijXXSZ4M5rTmNC7boCLea8jXj2rw0RJUAvxUCGqNM4qfSPB+QqkTajWwaBO1aYNT2ZX3DvWkOJbDN+JvXJDQ/oN7SmbHAuuG6Pu/IcNDzdeFnzJoKfX/yW3NzPw7mem8HZ7+Q2cL3+6hsPs4R3iTtuc6T7tvJLTosOxncXM7CRoEdgTTfSN/dYs+dbg3FnpKDveIo2yUDp6eQ1Xrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVI/CiHxcPCx4S1knXybWUT9l2XPYzJS5B84mmHsk1c=;
 b=xJ9NX8Qwzdbvewqmkajsa0g1DM0ocYmgmnktzrWeK0k+UoG6HHFHq2hei0sJIOv3jHKrsYU59JUiaD6Z/vprdes2KbqUdktqKJt/K+EPouJZ8ZnqvC2f9pAB5DAFbrT1jHAJHYHfytn8dER1enT94FWbJ4hD9UkTprfUnmFtR1c=
Received: from BN9PR03CA0706.namprd03.prod.outlook.com (2603:10b6:408:ef::21)
 by SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 09:37:33 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::56) by BN9PR03CA0706.outlook.office365.com
 (2603:10b6:408:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 27 Aug 2024 09:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 09:37:32 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:37:28 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<kprateek.nayak@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<bharathprabhu.perdoor@amd.com>, <poonam.aggrwal@amd.com>, <Li.Meng@amd.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Xiaojian.Du@amd.com>
Subject: [PATCH 05/11] platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver
Date: Tue, 27 Aug 2024 17:36:53 +0800
Message-ID: <8d3d75941a87839ab88dff20e89b73c0f5e6cb2a.1724748733.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 746349bb-03d8-4642-86b5-08dcc67be072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0k14rxh9bp3pkjPek8Jh410MtZx9PFC4/t0C1dJQg9zBwVN/3IUrSuni4nkB?=
 =?us-ascii?Q?YeDoRB2TXj5w0s1QiYAoqv+QUjJjavNPYnz4/ZkZNr3+mO8oApiaPHWyliJI?=
 =?us-ascii?Q?2JxigET2Kz0S0/8qycX0dY6SS8g3A73TG0FkHBDvy+63OvLWsDFwBMG2q0wX?=
 =?us-ascii?Q?2ni+y9y7f25wzpJw0CIC/DtLrYr7JEjOTngYkuz5Zdqh68dQ/Jkqodo+qYyk?=
 =?us-ascii?Q?9XwHKgQ7UAl/8ytkift/zkP1ey2qb2uhhnx7T86fYg5/n7vPxly2hKO8aVD5?=
 =?us-ascii?Q?XCxmy+3GVfJr1ikd7e7oqL5TWaCsU5bHjIBKMK6vKL3Tm33/lBGxKlnqsArN?=
 =?us-ascii?Q?Sh8njMTZlKDjBwBAQ35bVV7V407ff4/+0hHVLdHJrEz/WRk7J4ieBz4ttmMp?=
 =?us-ascii?Q?Xn1BtqxxJjMCYZNrnpaSvzAglwYjXP3YFfo8DWE+75+zLe4iKxAp88tlLZXT?=
 =?us-ascii?Q?N86ZRuxymisB+vH+NtpaqMK0UxNw4P/XU2tSvoYJ9RiyFahxND6tBkcGV2HJ?=
 =?us-ascii?Q?Ssc0MvUjwsDRedAemywGsD77O6t7gSAVg+y2wHVl49tQjl9xyfqzA2b7WfL4?=
 =?us-ascii?Q?9t0pm1pOWD7JSb1YLvGCSg3suobouZI5mZfNzShF1W2tYmhlCynWTgmKyKDu?=
 =?us-ascii?Q?yy4HQxpqJwXNiCu/0MEkIie4C7t8llB2rqE9xeEwMg7LH1QsQCh1mrPi3kfZ?=
 =?us-ascii?Q?SQARC/evmCH8uRG3bIDPpfEeW0+YW5Cc8jLSWo7IX+HWiM9Nd7li8xwYCY+f?=
 =?us-ascii?Q?e5RWNYgkh7nYkjwCMkWMQtwK+KRH5muHB1S/pbSiA82AOLLljo2pZFyFYf0o?=
 =?us-ascii?Q?Sq3+3PcPRSrybw6OLsypRNmZNBAZfdtsCsxC99NESYfd3MKUH7gWz9W/1OOo?=
 =?us-ascii?Q?KWkXPMRFLIQJ6mkwCo9TL4dDi1lToFbMQvEohQLIpwFZHRwSN7WmMW2718zv?=
 =?us-ascii?Q?WVB5Z7zw/Re/cGaPSizaepqN7/AYOYXmJua6e2W1Q74S0xVnCbJm4p45zwNX?=
 =?us-ascii?Q?6q7roGX4sa3I20pWIvEsJDTJtt4aNoUeoZAsQxnkaPV/m0Fsf/YVf+4MIk28?=
 =?us-ascii?Q?i5aZPvGGWhsO/16+O7i3/y+UKfQ5U75mmqUDspjxO3mDqFtZCiEESlH2DpQl?=
 =?us-ascii?Q?ObuhV4lOd8JRmKW4VmmCEIKMvB4mDprlKehoDI/jf2kpwJXGLdPLQWS6l+kB?=
 =?us-ascii?Q?xRilDQFVf7LiC0i0vaWgtm0TtltVdnBXovqLWciJwR2IjHEYzLJNSwSxxTeV?=
 =?us-ascii?Q?MLR02hQBKdj30JSIkiwrmchsg9x4aGO3fNNmg3A8x9HXv6D/RnjPqUvaAwoj?=
 =?us-ascii?Q?5CZWlfANIi2xLAKlkVZIzA/JL0FTpHOzU/VyF94SWEzmqBn58a81ebZLly+d?=
 =?us-ascii?Q?88MyactZ8PVUFen/hPcr7aON5TTUr2jAukVbt/Teh626JyqQQdXl8NpOuxER?=
 =?us-ascii?Q?jawYs+ukhBGgJd69ykdJ+HZcsvvEjgyJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:37:32.7396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 746349bb-03d8-4642-86b5-08dcc67be072
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163

From: Perry Yuan <Perry.Yuan@amd.com>

The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
provide behavioral classification and a dynamically updated ranking table
for the scheduler to use when choosing cores for tasks.

There are two CPU core types defined: `Classic Core` and `Dense Core`.
"Classic" cores are the standard performance cores, while "Dense" cores
are optimized for area and efficiency.

Heterogeneous compute refers to CPU implementations that are comprised
of more than one architectural class, each with two capabilities. This
means each CPU reports two separate capabilities: "perf" and "eff".

Each capability lists all core ranking numbers between 0 and 255, where
a higher number represents a higher capability.

Heterogeneous systems can also extend to more than two architectural
classes.

The purpose of the scheduling feedback mechanism is to provide information
to the operating system scheduler in real time, allowing the scheduler to
direct threads to the optimal core during task scheduling.

All core ranking data are provided by the BIOS via a shared memory ranking
table, which the driver reads and uses to update core capabilities to the
scheduler. When the hardware updates the table, it generates a platform
interrupt to notify the OS to read the new ranking table.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/platform/x86/amd/Kconfig      |   1 +
 drivers/platform/x86/amd/Makefile     |   1 +
 drivers/platform/x86/amd/hfi/Kconfig  |  21 +++
 drivers/platform/x86/amd/hfi/Makefile |   7 +
 drivers/platform/x86/amd/hfi/hfi.c    | 209 ++++++++++++++++++++++++++
 5 files changed, 239 insertions(+)
 create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
 create mode 100644 drivers/platform/x86/amd/hfi/Makefile
 create mode 100644 drivers/platform/x86/amd/hfi/hfi.c

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index f88682d36447..c3f69dbe3037 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -5,6 +5,7 @@
 
 source "drivers/platform/x86/amd/pmf/Kconfig"
 source "drivers/platform/x86/amd/pmc/Kconfig"
+source "drivers/platform/x86/amd/hfi/Kconfig"
 
 config AMD_HSMP
 	tristate "AMD HSMP Driver"
diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index dcec0a46f8af..2676fc81fee5 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -9,3 +9,4 @@ amd_hsmp-y			:= hsmp.o
 obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
 obj-$(CONFIG_AMD_PMF)		+= pmf/
 obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
+obj-$(CONFIG_AMD_HFI)		+= hfi/
diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
new file mode 100644
index 000000000000..4671cc1037a0
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# AMD Hardware Feedback Interface Driver
+#
+
+config AMD_HFI
+	bool "AMD Hetero Core Hardware Feedback Driver"
+	depends on ACPI
+	depends on CPU_SUP_AMD
+	select IPC_CLASSES
+	help
+	 Select this option to enable the AMD Heterogeneous Core Hardware Feedback Interface. If
+	 selected, hardware provides runtime thread classification guidance to the operating system
+	 on the performance and energy efficiency capabilities of each heterogeneous CPU core.
+	 These capabilities may vary due to the inherent differences in the core types and can
+	 also change as a result of variations in the operating conditions of the system such
+	 as power and thermal limits. If selected, the kernel relays updates in heterogeneous
+	 CPUs' capabilities to userspace, allowing for more optimal task scheduling and
+	 resource allocation, leveraging the diverse set of cores available.
+
+
diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
new file mode 100644
index 000000000000..672c6ac106e9
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# AMD Hardware Feedback Interface Driver
+#
+
+obj-$(CONFIG_AMD_HFI) += amd_hfi.o
+amd_hfi-objs := hfi.o
diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
new file mode 100644
index 000000000000..914390682fef
--- /dev/null
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Hardware Feedback Interface Driver
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
+ *
+ * Author: Perry Yuan <Perry.Yuan@amd.com>
+ *
+ */
+
+#define pr_fmt(fmt)  "amd-hfi: " fmt
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+
+#define AMD_HFI_DRIVER		"amd_hfi"
+#define AMD_HETERO_CPUID_27	0x80000027
+static struct platform_device *device;
+
+struct amd_hfi_data {
+	const char	*name;
+	struct device	*dev;
+	struct mutex	lock;
+	acpi_handle	dhandle;
+};
+
+struct amd_hfi_classes {
+	u32	perf;
+	u32	eff;
+} __packed;
+
+/**
+ * struct amd_hfi_cpuinfo - HFI workload class info per CPU
+ * @cpu:		cpu index
+ * @cpus:		cpu mask of cpus
+ * @class_index:	workload class ID index
+ * @nr_classa:		max number of workload class supported
+ * @amd_hfi_classes:	current cpu workload class ranking data
+ *
+ * Parameters of a logical processor linked with hardware feedback class
+ */
+struct amd_hfi_cpuinfo {
+	int		cpu;
+	cpumask_var_t	cpus;
+	s16		class_index;
+	u8		nr_class;
+	struct amd_hfi_classes	*amd_hfi_classes;
+};
+
+static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
+
+static int amd_hfi_alloc_class_data(struct platform_device *pdev)
+{
+	struct amd_hfi_cpuinfo *hfi_cpuinfo;
+	struct device *dev = &pdev->dev;
+	int idx;
+	int nr_class_id;
+
+	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
+	if (nr_class_id < 0 || nr_class_id > 255) {
+		dev_warn(dev, "failed to get supported class number from CPUID %d\n",
+				AMD_HETERO_CPUID_27);
+		return -EINVAL;
+	}
+
+	for_each_possible_cpu(idx) {
+		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
+		hfi_cpuinfo->amd_hfi_classes = devm_kmalloc(dev, nr_class_id *
+				sizeof(struct amd_hfi_classes), GFP_KERNEL);
+		if (!hfi_cpuinfo->amd_hfi_classes) {
+			pr_err("failed to allocate memory\n");
+			return -ENOMEM;
+		}
+
+		hfi_cpuinfo->nr_class = nr_class_id;
+	}
+
+	return 0;
+}
+
+static void amd_hfi_remove(struct platform_device *pdev)
+{
+	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
+
+	mutex_destroy(&dev->lock);
+}
+
+static const struct acpi_device_id amd_hfi_platform_match[] = {
+	{ "AMDI0104", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
+
+static int amd_hfi_probe(struct platform_device *pdev)
+{
+	struct amd_hfi_data *amd_hfi_data;
+	const struct acpi_device_id *id;
+	struct acpi_device *acpi_dev;
+	acpi_handle dhandle;
+	int ret;
+
+	id = acpi_match_device(amd_hfi_platform_match, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	amd_hfi_data = devm_kzalloc(&pdev->dev,
+			sizeof(*amd_hfi_data), GFP_KERNEL);
+	if (!amd_hfi_data)
+		return -ENOMEM;
+
+	amd_hfi_data->dev = &pdev->dev;
+	dhandle = ACPI_HANDLE(&pdev->dev);
+	if (!dhandle) {
+		dev_err(&pdev->dev, "dhandle is null\n");
+		return -ENODEV;
+	}
+
+	acpi_dev = acpi_fetch_acpi_dev(dhandle);
+	if (!acpi_dev)
+		return -ENODEV;
+
+	amd_hfi_data->dhandle = dhandle;
+	mutex_init(&amd_hfi_data->lock);
+	platform_set_drvdata(pdev, amd_hfi_data);
+
+	/* alloc data array for hardware feedback class data */
+	ret = amd_hfi_alloc_class_data(pdev);
+	if (ret)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static struct platform_driver amd_hfi_driver = {
+	.driver = {
+		.name = AMD_HFI_DRIVER,
+		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
+	},
+	.probe = amd_hfi_probe,
+	.remove_new = amd_hfi_remove,
+};
+
+static int amd_platform_hfi_init(void)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		pr_err("unable to register hfi platform device\n");
+		return PTR_ERR(pdev);
+	}
+
+	ret = platform_driver_register(&amd_hfi_driver);
+	if (ret) {
+		pr_err("Failed to register hfi driver\n");
+	}
+
+	return ret;
+}
+
+static int __init amd_hfi_init(void)
+{
+	int ret;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	if (!boot_cpu_has(X86_FEATURE_HETERO_CORE_TOPOLOGY)) {
+		pr_debug("amd Hetero Core feature reporting not supported!\n");
+		return -ENODEV;
+	}
+
+	if (!boot_cpu_has(X86_FEATURE_WORKLOAD_CLASS)) {
+		pr_debug("workload class reporting not supported!\n");
+		return -ENODEV;
+	}
+
+	/* platform PCC Subspace Type 4 driver init */
+	ret = amd_platform_hfi_init();
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static __exit void amd_hfi_exit(void)
+{
+	platform_device_unregister(device);
+	platform_driver_unregister(&amd_hfi_driver);
+}
+module_init(amd_hfi_init);
+module_exit(amd_hfi_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");
-- 
2.34.1


