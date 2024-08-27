Return-Path: <linux-kernel+bounces-302989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315509605CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23EC280C98
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C621A00E3;
	Tue, 27 Aug 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w6ic+jAU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10B19EECA;
	Tue, 27 Aug 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751463; cv=fail; b=HNoESKaklekKmILZ38pSH4R4lxEUjfqAv1+1koMYmm+jTlfhxBfp5wA6PV8Hd2MPjpxjZ2XPA4pHzygDplmq4njcC9YMAZYKUAMxWzXvQfBfeihi/iAkf9VKlpon6hAIHVPcDe4qvRrTM0gsnsnaF0NNsUYt8FGtj++ut1Aru9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751463; c=relaxed/simple;
	bh=ipYvIKCxu9XioSFZnnP6+kJoVgrms49ZtoKaqwYYJGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFAHe0RdP8N/IVl7p9Sd2H1LMkZjo8HF7GFMST1mGeP1fNXwrRxcPvDeXD8AHg2E7xqMGwe6WLKDMnBb3k7kFIa8FDxJAkQvMDNV594tEs9evTiXy9dD0Yh0sSwidEBOsRI8JJe/XD/9Ei3nZQVJK3dfB1aVQyWFDroLBebeJME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w6ic+jAU; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4V5njOnX38LHpl20o6rStdhKltO9lJGTwhr6UFXi5cxTQcLEqBQGCtYHaxz4sYXSeJF05FwcvDIpv50eVMTerek+KpMjdMiFDdI52brNsv77c/iYc8BoA75TUwB5hNSyaB3ARe/B/19WKD+vq/YzYHnxPbkwk9KQ9ah7AcfYAaftxpwxN1ifbDkpmLAUdtGR/fFC4H3S+f5QL2arU8qGDmUdMX7lQfuRz6chCqSrRzviRYugsijSsFBpBWfy4+P2LIR9N297/tc0CqIXM6OywQ3DVElhyxVAwXAWC9H/OVbi7AwaRYP6wc+qly0dlQY2N9/QrVu+n0twb4eHtqxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+p3fHCP0MXfnBnECaOFF5wBQ75lBrF/UmJQZGbcPsA=;
 b=l9wL6wuYh4eb6lFQIFS4gcwxODgxC6zPU9UMadwIurLOT7IdWwKkzG4lD0MXT5qVPUgsmG+1R8Il2+aZhshhKdaTM0tt7Jij8uH/BS1NVNy+uuVbj362ADKIRv1mkMTcyxY/XfgBrBy7D2Tz/zrlbvXm5nEQSav99r3emCH/auFei31kwDeRWyQ96s0xDEcHZqU18xpqStp/QAucpY/BEbqa+GbE0uprIrfaKQod3PLsuMf1X5XT7aWTaU3sHnnvGlmYlakfWBkAgGa3LDudO7DBOKQtURyx5txG+X6rLoXR9pDAS9vCSN13oAW8li7Prd3LNJR0DLau33I+Qk+HqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+p3fHCP0MXfnBnECaOFF5wBQ75lBrF/UmJQZGbcPsA=;
 b=w6ic+jAUUssjHo2fkPlNb7OK1X8O3P2b9a2vetTxHdiNBqakO+ktSEOlQuCrcdsOb2+2WtnLP041AjKVWaZahRB8/LGsXwGOrwp6Cpvj0+xCQSDUMpAP2PMFASwPCgNTPMeOkyjK59iDGWdo3qVtu7LJsiXqV9af6Hi7CP8jhfs=
Received: from BN9PR03CA0582.namprd03.prod.outlook.com (2603:10b6:408:10d::17)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 09:37:36 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::59) by BN9PR03CA0582.outlook.office365.com
 (2603:10b6:408:10d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Tue, 27 Aug 2024 09:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 09:37:36 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:37:32 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<kprateek.nayak@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<bharathprabhu.perdoor@amd.com>, <poonam.aggrwal@amd.com>, <Li.Meng@amd.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Xiaojian.Du@amd.com>
Subject: [PATCH 06/11] platform/x86/: hfi: parse CPU core ranking data from shared memory
Date: Tue, 27 Aug 2024 17:36:54 +0800
Message-ID: <e2f17f3915f072d283c1f34774b3d069e670ae36.1724748733.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3b406b-d783-4cd8-25eb-08dcc67be2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a7aWpST2vx6CZKEn1EwemhYiI1K7STtoUf6Kgwtbek9JvjiommRzBgEjqko6?=
 =?us-ascii?Q?HpvNd9jsj4NSqUca3iWfZAmVFvOldENckZk1gv1oDNSib0vR/9okU0cARDrM?=
 =?us-ascii?Q?XbZBMlhHdHn546h/IuFbcikh2/AH7Cw7LQYjLbWZ7gxNS6iWN4GGLhKKB9Qm?=
 =?us-ascii?Q?8pgn0kMO9oH8ogjwjA6U7+fwXZmVLtHkkJOX+OyT6wbL8psM+k1UXeg5qjC3?=
 =?us-ascii?Q?Ygyof+mLxO3zttFEM0Up0VYL5BL7wDzHcAvaieaNlm9L3uKJjb0b0C/HtJjo?=
 =?us-ascii?Q?1IjCwuiUMk8rTogcLrf9iYu4UXjfKNKf/ZyaJRlInKdvs0Z3jN/PtzIM5St6?=
 =?us-ascii?Q?0xS0GVP2S1EufZzzh15WguWD1S+1J5euoD6NMG1m0DDipYVkYy3Gz0Ni6MKE?=
 =?us-ascii?Q?UrdO4RLZTpbkMo6rdqtnnv4CGHwUCwBAWgrGyPBZK6TafbDsJNFdbZC/8Azf?=
 =?us-ascii?Q?ewPSc0KILHT7kr4uag7j/YKyYO0ZpEwLPvU9ej1InoqF2fSNM2EvBE49OZZl?=
 =?us-ascii?Q?BfEFO2yb91dvEj77KBWZVwIXmnL+87idFPliQ00iUJ6zrHzbd4JSsMqZhIGL?=
 =?us-ascii?Q?xxlBiUq4BRBA5j0E82M7zN2v6TgMip/AqmM5SGEVXjeICdgstxv+UO86Vv8u?=
 =?us-ascii?Q?RNxjKYVqCTb1sdolAT7iPLLzUiI97PLkMHdZ+XLRQAuEQ+UOU+hTJwatSsFv?=
 =?us-ascii?Q?1WaJCUrdp5d1aEOe4rcWDw3jbgQn/eP+nvndoxU5sii3qAySckLepPsqnuA+?=
 =?us-ascii?Q?drW0n1L/bMkfupXsC0HbuBXOD6jGjIXB8ESqo4UWLDKQkazJjU7I99tQfQ0b?=
 =?us-ascii?Q?w9N81BoqnuOR2zxkmtvOWK67I1YZaZswksAXKjDT5iGhDusnt3Y2DySaa52q?=
 =?us-ascii?Q?b/8T66Zui2+puie3Vj1NJP9fr7NeIFnkovC2OV8inbpwthmEQHzi5g49hGNL?=
 =?us-ascii?Q?wbwhmy0WqeFZ8bxvpHjnjSdKPYoQLV0Egw/322XS7gjwQPyMINfcqkzbkaYt?=
 =?us-ascii?Q?kbGHumGd+p6NH/RULC7L4vpTn4wamOfadzeXWMDDm4Gsk700YM5k0T1VauB/?=
 =?us-ascii?Q?6m055uQg7++ozuBnIBNFRL9aWojfOzkfLnFPPOix9LzM3Q1lJ0STsoSKdFdM?=
 =?us-ascii?Q?cxt4/XH/DziWRJU//cCu2C3QtVIHqaPa5JhQ9Ny7YU6/GQAIV8dYgFSfyJOc?=
 =?us-ascii?Q?ByctRczkLxOzRFzTR379IxatkYEn1H1svANKcD7dxDFxl6fCJv1g/yq07Z3D?=
 =?us-ascii?Q?GxbKm2npL3s9jOzmCfZj+8dUgytUVP444bj47oX4PKWcuiurydM0YNYSPi/E?=
 =?us-ascii?Q?vdkcEBP698y61nviwP3JZuVD2XWJqAcBNUs4hpD+TkWYe7yVkb872vR8Jh+O?=
 =?us-ascii?Q?PeKmPowCUcR33D6Ktu1xfwnqybGSjAn8mglzqSN9ShfmYNDavicLxnveHqeP?=
 =?us-ascii?Q?fUrQ97+i6AG9i38I3+5n5nVgGsSaH/yF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:37:36.4112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3b406b-d783-4cd8-25eb-08dcc67be2a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951

From: Perry Yuan <Perry.Yuan@amd.com>

When `amd_hfi` driver is loaded, it will use PCCT subspace type 4 table
to retrieve the shared memory address which contains the CPU core ranking
table. This table includes a header that specifies the number of ranking data
entries to be parsed and rank each CPU core with the Performance and Energy
Efficiency capability as implemented by the CPU power management firmware.

Once the table has been parsed, each CPU is assigned a ranking score within
its class. Subsequently, when the scheduler selects cores, it chooses
from the ranking list based on the assigned scores in each class, thereby
ensuring the optimal selection of CPU cores according to their predefined
classifications and priorities.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 267 +++++++++++++++++++++++++++++
 1 file changed, 267 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 914390682fef..50f6ca9c148a 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -19,23 +19,108 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mailbox_client.h>
 #include <linux/mutex.h>
+#include <linux/percpu-defs.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/smp.h>
 #include <linux/string.h>
+#include <linux/topology.h>
+#include <linux/workqueue.h>
+
+#include <asm/cpu_device_id.h>
+
+#include <acpi/pcc.h>
+#include <acpi/cppc_acpi.h>
 
 #define AMD_HFI_DRIVER		"amd_hfi"
 #define AMD_HETERO_CPUID_27	0x80000027
+#define AMD_HETERO_RANKING_TABLE_VER	2
 static struct platform_device *device;
 
+/**
+ * struct amd_core_rank_table - HFI capabilities for the logical
+ * processors in the memory mappep table.
+ *
+ * @signature:	The PCC signature. The signature of a subspace is computed by
+ *		a bitwise of the value 0x50434300 with the subspace ID.
+ * @flags:	Notify on completion
+ * @length:	Length of payload being transmitted including command field
+ * @command:	Command being sent over the subspace
+ * @version_number:		Version number of the table
+ * @n_logical_processors:	Number of logical processors
+ * @n_capabilities:		Number of ranking dimensions (performance, efficiency, etc)
+ * @table_update_context:	Command being sent over the subspace
+ * @n_bitmaps:			Number of 32-bit bitmaps to enumerate all the APIC IDs
+ *				This is based on the maximum apic ID enumerated in the system
+ * @reserved:			The 24bit spare
+ * @bitmap_of_apic_id0:		Bit Map of enabled logical processors APIC ID for 31:0
+ * @bitmap_of_apic_id1:		Bit Map of enabled logical processors APIC ID for 64:32
+ * @n_classes:			Number of workload class
+ * @dynamic_rank_feature:	Table update mode
+ * @diagnostics:		Reserved space for diagnostics
+ * @timestamp:			Timestamp for last table update
+ * @table_size:			Table length of shared memory
+ * @shmem_info:			The table data read from shared memory
+ * @bitmap_data:		Bitmap data read from table
+ * @max_index:			The max data array in the table
+ *
+ * A memory mapped table is used to express the capabilities of each logical
+ * processor for each thread classification. with dynamic table update feature
+ * supported, the table will be notified to update for all the cores while system
+ * running, each table update can reorder the cores for much better performance and
+ * power efficiency.
+ *
+ */
+struct amd_hfi_metadata {
+	u32	signature;
+	u32	flags:1;
+	u32	length;
+	u32	command;
+	u8	version_number;
+	u8	n_logical_processors;
+	u8	n_capabilities;
+	u8	table_update_context;
+	u8	n_bitmaps;
+	u32	reserved:24;
+	u32	bitmap_of_apic_id0;
+	u32	bitmap_of_apic_id1;
+	u8	n_classes;
+	bool	dynamic_rank_feature;
+	int	diagnostics;
+	u64	timestamp;
+	u64	table_size;
+	u32	shmem_info[64];
+	u32	bitmap_data;
+	u32	max_index;
+};
+
 struct amd_hfi_data {
 	const char	*name;
 	struct device	*dev;
 	struct mutex	lock;
 	acpi_handle	dhandle;
+
+	/* PCCT table related*/
+	int		plat_irq;
+	struct pcc_mbox_chan	*pcc_chan;
+	void __iomem		*pcc_comm_addr;
+	struct completion	done;
+	struct mbox_client	cl;
+	raw_spinlock_t		table_lock;
+	struct acpi_subtable_header	*pcct_entry;
+	struct amd_hfi_metadata		*hfi_meta;
 };
 
+/**
+ * struct amd_hfi_classes - HFI class capabilities per CPU
+ * @perf:		Performance capability
+ * @eff:		Power efficiency capability
+ *
+ * Capabilities of a logical processor in the rank table. These capabilities are
+ * unitless and specific to each HFI class.
+ */
 struct amd_hfi_classes {
 	u32	perf;
 	u32	eff;
@@ -61,6 +146,118 @@ struct amd_hfi_cpuinfo {
 
 static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
 
+static int find_cpu_index_by_apicid(unsigned int target_apicid)
+{
+	int cpu_index;
+
+	for_each_possible_cpu(cpu_index) {
+		struct cpuinfo_x86 *info = &cpu_data(cpu_index);
+
+		if (info->topo.apicid == target_apicid) {
+			pr_debug(" match apic id %d for cpu index: %d",
+						info->topo.apicid, cpu_index);
+			return cpu_index;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int amd_hfi_fill_metadata(struct amd_hfi_data *amd_hfi_data)
+{
+	struct pcc_mbox_chan *pcc_chan = amd_hfi_data->pcc_chan;
+	struct acpi_subtable_header *pcct_entry = amd_hfi_data->pcct_entry;
+	struct acpi_pcct_ext_pcc_slave *pcct_ext =
+		(struct acpi_pcct_ext_pcc_slave *)pcct_entry;
+	struct amd_hfi_metadata *meta = amd_hfi_data->hfi_meta;
+	u32 header_index = 0, data_index = 0;
+	struct amd_hfi_cpuinfo *info;
+	u32 offset, offset_begin;
+	void __iomem *pcc_comm_addr;
+	int idx, ret, length;
+	u32 *shmem_info;
+
+	length = pcct_ext->length;
+	if (length <= 0) {
+		pr_err("length is less than min table length required\n");
+		return -EINVAL;
+	}
+
+	shmem_info = devm_kmalloc_array(amd_hfi_data->dev, length, sizeof(u32), GFP_KERNEL);
+	if (!shmem_info) {
+		pr_err("failed to allocate memory %x\n", length);
+		return -ENOMEM;
+	}
+
+	pcc_chan->shmem_base_addr = pcct_ext->base_address;
+	pcc_chan->shmem_size = pcct_ext->length;
+
+	amd_hfi_data->plat_irq = pcct_ext->platform_interrupt;
+	if (amd_hfi_data->plat_irq < 0) {
+		pr_err("invalid irq allocated in pcct table\n");
+		return -EINVAL;
+	}
+
+	pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr, pcc_chan->shmem_size);
+	if (!pcc_comm_addr) {
+		pr_err("failed to ioremap PCC common region mem\n");
+		return -ENOMEM;
+	}
+
+	raw_spin_lock(&amd_hfi_data->table_lock);
+
+	memcpy_fromio(shmem_info, (u32 __iomem *)pcc_comm_addr, length);
+
+	/* extended PCC subspace shared memory region */
+	meta->signature = shmem_info[header_index];
+	meta->flags = shmem_info[++header_index];
+	meta->length = shmem_info[++header_index];
+	meta->command = shmem_info[++header_index];
+	idx = header_index + 1;
+
+	/* shared memory region for cores ranking data */
+	meta->version_number = shmem_info[idx] & 0xFF;
+	meta->n_logical_processors = (shmem_info[idx] >> 8) & 0xFF;
+	meta->n_capabilities = (shmem_info[idx] >> 16) & 0xFF;
+	meta->table_update_context = (shmem_info[idx] >> 24) & 0xFF;
+	meta->n_bitmaps = shmem_info[++idx] & 0xFF;
+	meta->n_classes = (shmem_info[idx] >> 8) & 0xFF;
+	meta->bitmap_data = shmem_info[++idx];
+	meta->max_index = meta->n_bitmaps * 32;
+
+	if (meta->version_number == AMD_HETERO_RANKING_TABLE_VER)
+		offset_begin = idx + 1;
+
+	for (u32 bit_idx = 0; bit_idx < meta->max_index; bit_idx++) {
+		if (meta->bitmap_data & (1u << bit_idx)) {
+			int cpu_index = find_cpu_index_by_apicid(bit_idx);
+			if (cpu_index < 0) {
+				ret = -ENODEV;
+				goto err_map;
+			}
+
+			info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
+
+			offset = data_index * 6 + offset_begin;
+			for (int i = 0; i < meta->n_classes; i++) {
+				info->amd_hfi_classes[i].eff = shmem_info[offset + 2 * i];
+				info->amd_hfi_classes[i].perf = shmem_info[offset + 2 * i + 1];
+			}
+		} else {
+			continue;
+		}
+		data_index++;
+	}
+	raw_spin_unlock(&amd_hfi_data->table_lock);
+	iounmap(pcc_comm_addr);
+
+	return 0;
+
+err_map:
+	raw_spin_unlock(&amd_hfi_data->table_lock);
+	return ret;
+}
+
 static int amd_hfi_alloc_class_data(struct platform_device *pdev)
 {
 	struct amd_hfi_cpuinfo *hfi_cpuinfo;
@@ -96,6 +293,56 @@ static void amd_hfi_remove(struct platform_device *pdev)
 
 	mutex_destroy(&dev->lock);
 }
+static int amd_hfi_metadata_parser(struct platform_device *pdev,
+		struct amd_hfi_data *amd_hfi_data)
+{
+	struct mbox_chan *pcc_mbox_channels;
+	struct pcc_mbox_chan *pcc_chan;
+	struct acpi_subtable_header *pcct_entry;
+	struct acpi_table_header *pcct_tbl;
+	struct device *dev = &pdev->dev;
+	acpi_status status;
+	int ret = 0, count = 1;
+
+	status = acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
+	if (ACPI_FAILURE(status) || !pcct_tbl) {
+		pr_err("acpi_get_table failed!\n");
+		return -ENODEV;
+	}
+
+	pcc_mbox_channels = devm_kcalloc(dev, count,
+			sizeof(*pcc_mbox_channels), GFP_KERNEL);
+	if (!pcc_mbox_channels) {
+		ret = -ENOMEM;
+		goto exit_err;
+	}
+
+	pcc_chan = devm_kcalloc(dev, count, sizeof(*pcc_chan), GFP_KERNEL);
+	if (!pcc_chan) {
+		ret = -ENOMEM;
+		goto exit_err;
+	}
+
+	/* get pointer to the first PCC subspace entry */
+	pcct_entry = (struct acpi_subtable_header *) (
+			(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
+
+	pcc_chan->mchan = &pcc_mbox_channels[0];
+
+	amd_hfi_data->pcc_chan = pcc_chan;
+	amd_hfi_data->pcct_entry = pcct_entry;
+
+	/* parse the shared memory info from the pcct table */
+	ret = amd_hfi_fill_metadata(amd_hfi_data);
+	if (ret) {
+		pr_err("failed to parse core ranking table\n");
+		ret = -ENODATA;
+	}
+
+exit_err:
+	acpi_put_table(pcct_tbl);
+	return ret;
+}
 
 static const struct acpi_device_id amd_hfi_platform_match[] = {
 	{ "AMDI0104", 0},
@@ -120,6 +367,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (!amd_hfi_data)
 		return -ENOMEM;
 
+	amd_hfi_data->hfi_meta = devm_kzalloc(&pdev->dev,
+					sizeof(*amd_hfi_data->hfi_meta), GFP_KERNEL);
+	if (!amd_hfi_data->hfi_meta)
+		return -ENOMEM;
 	amd_hfi_data->dev = &pdev->dev;
 	dhandle = ACPI_HANDLE(&pdev->dev);
 	if (!dhandle) {
@@ -132,7 +383,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	amd_hfi_data->dhandle = dhandle;
+
+	raw_spin_lock_init(&amd_hfi_data->table_lock);
 	mutex_init(&amd_hfi_data->lock);
+
 	platform_set_drvdata(pdev, amd_hfi_data);
 
 	/* alloc data array for hardware feedback class data */
@@ -140,7 +394,20 @@ static int amd_hfi_probe(struct platform_device *pdev)
 	if (ret)
 		return -ENOMEM;
 
+	ret = amd_hfi_metadata_parser(pdev, amd_hfi_data);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to parse PCCT table data with %d.\n", ret);
+		goto err_exit;
+	}
+
+	amd_hfi_data->hfi_meta->dynamic_rank_feature =
+					cpuid_ebx(AMD_HETERO_CPUID_27) & 0xF;
+	dev_dbg(&pdev->dev, "%s driver registered.\n", pdev->name);
+
 	return 0;
+
+err_exit:
+	return ret;
 }
 
 static struct platform_driver amd_hfi_driver = {
-- 
2.34.1


