Return-Path: <linux-kernel+bounces-406647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F7A9C61CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FCD2855E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1F4219C96;
	Tue, 12 Nov 2024 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c9ui5jJ2"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9921503E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440888; cv=fail; b=GQBQPpriu800t7LMOtGdQZVOh0qulyLHhVAY4TNOH6Ta6c5/dyyroarukgyD3v1Zn8XK0C4jWYBk1o/WZAQR05ZFxTE6t0EYuVp3yJ4ocM5LX5m/5tzVbInmT5IoKc1QStZ2/BhBOPdZuWdFSxGWllz2ae8tV4Mm5a3GixgUFGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440888; c=relaxed/simple;
	bh=UsbGcf13d+I+G7qD0kIHGvyvTzkFkolqbGJAGf7IakM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ok8ue1LsOVHPCart7bdxZSZfqTjo/b4wcVIlEA3hMEfjeD/Y1VLg2kOD060GuYmOfuZyXPRlkDVeSJ8QFzrqRFhCOAx/VOeDjoLMYugN7OqpnvWgV9g1VXvf4V5fwa8xBeSzMgPPrV8h6MRhaImpukoZPvqLVEiq6RLDmfkN3lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c9ui5jJ2; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOg4ertMi6i8EaN8l9hmkGJnFmA6720cg8P9EEDrGRARO0mPKQexc7I6yTAOnUqs53Lr5wmvN5FmNL500V11e8cnxCFFeFpjfVhyjEnfQLLJzLMtubRAHBrTHQQ18FOlknNFYqYag2/ULuP/YE25GwC79+8I0xc7aQYmRPCGaQd/XTcfk2oyNSocwKzci0S4InTsthaIlP/B6V2yv7jhfPWdyNs/iJeem86+n+Gg3Bz2vcKriJsZbzyMyZx7wRpgmN2Rm/fZBt/bmn19bw4IR5KF3UhYtyWl2cT3PgjZSdIi8l4NOfTV7ZSB9/lPOFt/NfFKgPjU5q7s+677AsGd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVnTh90STkHLtxh4lH2Oi4lprjo/yzoCa+xelUlrY08=;
 b=KQiWuU3gM9vAiKwkDK5+hluZ4+vOfC5102BmZG7kRF9M4qL97MrXTyzUfO/S0xele7Lypf9Fc7Sx8T+8ycduTIjlfa2MfKzJlOoBSoWaJX13Tj3L1d7deAIkpNwnDcyms/zkIFtaOYN76eBRbm8zwyfD5IqITEHR6N7pa1gZPHQ93Gv2tpPxYjM9zV8bCDUELPl0cAlkCe3S1HVwz/eaGTPpKvNI9jlyMmkgylFLbfv+gZNnp2dt1V/6G/ZlpiNzlW2vEv9cBPXtO5i4qHFg4Jtqw8CoEdfx3qqWROzyzp+WXUh7xIxyh2qi6KqNKMWrYpRS0eOylQLKmTek6wnH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVnTh90STkHLtxh4lH2Oi4lprjo/yzoCa+xelUlrY08=;
 b=c9ui5jJ2b5MA9ps/EnKce25cKcOwahDPnvg0lAxy/6xspckV3TkhnRLamas7h0nWKQdc0/5Bm6saVDQN0fJRX/2P0M6Vgs4KYPZRAUZjN/s7tSXGwH3WKV5v3k86t92rYjDO5XtEHMVwxqCp+FzrPrD97JcqEfXKR4M/vLbnreU=
Received: from SN7PR04CA0162.namprd04.prod.outlook.com (2603:10b6:806:125::17)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 19:48:02 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::61) by SN7PR04CA0162.outlook.office365.com
 (2603:10b6:806:125::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Tue, 12 Nov 2024 19:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 19:48:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 13:48:01 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 13:48:01 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 13:48:01 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<min.ma@amd.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
	<king.tam@amd.com>
Subject: [PATCH V10 01/10] accel/amdxdna: Add documentation for AMD NPU accelerator driver
Date: Tue, 12 Nov 2024 11:47:36 -0800
Message-ID: <20241112194745.854626-2-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112194745.854626-1-lizhi.hou@amd.com>
References: <20241112194745.854626-1-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6ed5c3-3f3f-4660-c7e3-08dd0352eb3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oqN8p1ypnFL5VlfEQL5KGZCh9yAnZjfJ7/81hYTVofWxwAvwiwrwaZ5F1y6e?=
 =?us-ascii?Q?vA+zTojCQ7ExiC3JGMtXetIGUKw5/Cal/NezWpvVlhtRdYzj9lKvAjCcF091?=
 =?us-ascii?Q?AQ/6NIRuiCrPqf3KSMLLY5NHHvnR+OOFsw5WgQSf1UtMidLh2enF7xXZT3pQ?=
 =?us-ascii?Q?rav3cpQPwvBGlc0B8iKNs+0DvEgXc57gD0KU5ot8+yaym5PQkW4hYbo7DIwi?=
 =?us-ascii?Q?nrbeK2YiqCx/b5k/5iZgCf/ecuooajxV2KFst7nY0gavIR70fZNRKVDP/RBZ?=
 =?us-ascii?Q?E2AL1rht7y+xr2PuEk3mO6CzpIWR+9L9kc+i9DDhyOVTFeI1OCR7lY+nTU9L?=
 =?us-ascii?Q?EquVim7pDb1KSS5/Tm62nzUOGg5glNsyyR0ChtmdhNqyVCrI6DS8YXxf/Vq0?=
 =?us-ascii?Q?HZksOCmnGne0bttavguPzuDwwPUbk8dmkiHsDq7d3JzgOqt0oyL/U05NV6Hb?=
 =?us-ascii?Q?7/P1LkrsU137vMlcjA9xA4Ez6GMRnedPeW5ht56+Z7/LBARMrzi5S38mMNgE?=
 =?us-ascii?Q?o75fxNvD+zI9AytTvx7PYZhHNtUSRauggDdXONX0Tq5DSkYgkJEN5QmR+lnB?=
 =?us-ascii?Q?JsWU+QWwUWdk25CeeP+ZP4yS9k1mFUcE0cyytane/jibcwuShu9Q0AUyLwZO?=
 =?us-ascii?Q?nRKieeVsY74RmFPnpqcVTTWOUYSksJDB3pOzxKa4c4viciQHmI2ZuAMLZ3Ue?=
 =?us-ascii?Q?V+BeCOCc4hF1uOB1Ugx2721y4KZQ5FhyC389eVPHnP+v0Fqlo4QVv3xDU1HO?=
 =?us-ascii?Q?XbTvb78+ndzsNxE+vNAczfyesU+hWyINDzwIotAPMq5dKn/drF49LQMf/Wfr?=
 =?us-ascii?Q?yRZzV7S0vF9AKVo1nsrH+T6+pxwm0CArJVRHBAv7jJZ9IXbPBxt3YikniE3a?=
 =?us-ascii?Q?GWrUHgHTkh8Upw4S7itSCMvjspg9sayi5/psy2UBG/KMhhiVAtsh3AHPDk/c?=
 =?us-ascii?Q?vymCtYUzq0Ft1FcHrfGf404oSMqkb+emj6mC6KDmqIDIDhWRw5CzoZHODrZn?=
 =?us-ascii?Q?UOtavCkOyc+oNPgqKDqBLKhB1uXGvYQXWk9eBshWezhs7uwC0DB7iWWT0oCK?=
 =?us-ascii?Q?LLwwSBvWEfx+M+KMaJiV2GIUFq42qbVQiuNAQVf9g6PYzXdV1FieV1unza6U?=
 =?us-ascii?Q?TyLoIVmgL48oA/GZW3oe+TxdUkZ+5Ednwr3hBV1hjSi/zMmW+QPcl/bYw44s?=
 =?us-ascii?Q?V/bJrLqHGFphvq7T9UCOV3ak7buXn7QX7neeK0eJlMElVNdKMRB9V4ngtpPF?=
 =?us-ascii?Q?v5XDHiUj+e1p1DCGGjh4J9bXq39kycf+2FGSh7T1LxqG0q7NcB/da99KmolA?=
 =?us-ascii?Q?P5qZcAjsFNe4wuluJUaK+lGsUqfsbYos3wJezGY9eAoH0x3Kt5f7YiUqHgOP?=
 =?us-ascii?Q?qkpN76g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:48:02.4240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6ed5c3-3f3f-4660-c7e3-08dd0352eb3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306

AMD NPU (Neural Processing Unit) is a multi-user AI inference accelerator
integrated into AMD client APU. NPU enables efficient execution of Machine
Learning applications like CNN, LLM, etc. NPU is based on AMD XDNA
Architecture. NPU is managed by amdxdna driver.

Co-developed-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 Documentation/accel/amdxdna/amdnpu.rst | 281 +++++++++++++++++++++++++
 Documentation/accel/amdxdna/index.rst  |  11 +
 Documentation/accel/index.rst          |   1 +
 3 files changed, 293 insertions(+)
 create mode 100644 Documentation/accel/amdxdna/amdnpu.rst
 create mode 100644 Documentation/accel/amdxdna/index.rst

diff --git a/Documentation/accel/amdxdna/amdnpu.rst b/Documentation/accel/amdxdna/amdnpu.rst
new file mode 100644
index 000000000000..fbe0a7585345
--- /dev/null
+++ b/Documentation/accel/amdxdna/amdnpu.rst
@@ -0,0 +1,281 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+.. include:: <isonum.txt>
+
+=========
+ AMD NPU
+=========
+
+:Copyright: |copy| 2024 Advanced Micro Devices, Inc.
+:Author: Sonal Santan <sonal.santan@amd.com>
+
+Overview
+========
+
+AMD NPU (Neural Processing Unit) is a multi-user AI inference accelerator
+integrated into AMD client APU. NPU enables efficient execution of Machine
+Learning applications like CNN, LLM, etc. NPU is based on
+`AMD XDNA Architecture`_. NPU is managed by **amdxdna** driver.
+
+
+Hardware Description
+====================
+
+AMD NPU consists of the following hardware components:
+
+AMD XDNA Array
+--------------
+
+AMD XDNA Array comprises of 2D array of compute and memory tiles built with
+`AMD AI Engine Technology`_. Each column has 4 rows of compute tiles and 1
+row of memory tile. Each compute tile contains a VLIW processor with its own
+dedicated program and data memory. The memory tile acts as L2 memory. The 2D
+array can be partitioned at a column boundary creating a spatially isolated
+partition which can be bound to a workload context.
+
+Each column also has dedicated DMA engines to move data between host DDR and
+memory tile.
+
+AMD Phoenix and AMD Hawk Point client NPU have a 4x5 topology, i.e., 4 rows of
+compute tiles arranged into 5 columns. AMD Strix Point client APU have 4x8
+topology, i.e., 4 rows of compute tiles arranged into 8 columns.
+
+Shared L2 Memory
+----------------
+
+The single row of memory tiles create a pool of software managed on chip L2
+memory. DMA engines are used to move data between host DDR and memory tiles.
+AMD Phoenix and AMD Hawk Point NPUs have a total of 2560 KB of L2 memory.
+AMD Strix Point NPU has a total of 4096 KB of L2 memory.
+
+Microcontroller
+---------------
+
+A microcontroller runs NPU Firmware which is responsible for command processing,
+XDNA Array partition setup, XDNA Array configuration, workload context
+management and workload orchestration.
+
+NPU Firmware uses a dedicated instance of an isolated non-privileged context
+called ERT to service each workload context. ERT is also used to execute user
+provided ``ctrlcode`` associated with the workload context.
+
+NPU Firmware uses a single isolated privileged context called MERT to service
+management commands from the amdxdna driver.
+
+Mailboxes
+---------
+
+The microcontroller and amdxdna driver use a privileged channel for management
+tasks like setting up of contexts, telemetry, query, error handling, setting up
+user channel, etc. As mentioned before, privileged channel requests are
+serviced by MERT. The privileged channel is bound to a single mailbox.
+
+The microcontroller and amdxdna driver use a dedicated user channel per
+workload context. The user channel is primarily used for submitting work to
+the NPU. As mentioned before, a user channel requests are serviced by an
+instance of ERT. Each user channel is bound to its own dedicated mailbox.
+
+PCIe EP
+-------
+
+NPU is visible to the x86 host CPU as a PCIe device with multiple BARs and some
+MSI-X interrupt vectors. NPU uses a dedicated high bandwidth SoC level fabric
+for reading or writing into host memory. Each instance of ERT gets its own
+dedicated MSI-X interrupt. MERT gets a single instance of MSI-X interrupt.
+
+The number of PCIe BARs varies depending on the specific device. Based on their
+functions, PCIe BARs can generally be categorized into the following types.
+
+* PSP BAR: Expose the AMD PSP (Platform Security Processor) function
+* SMU BAR: Expose the AMD SMU (System Management Unit) function
+* SRAM BAR: Expose ring buffers for the mailbox
+* Mailbox BAR: Expose the mailbox control registers (head, tail and ISR
+  registers etc.)
+* Public Register BAR: Expose public registers
+
+On specific devices, the above-mentioned BAR type might be combined into a
+single physical PCIe BAR. Or a module might require two physical PCIe BARs to
+be fully functional. For example,
+
+* On AMD Phoenix device, PSP, SMU, Public Register BARs are on PCIe BAR index 0.
+* On AMD Strix Point device, Mailbox and Public Register BARs are on PCIe BAR
+  index 0. The PSP has some registers in PCIe BAR index 0 (Public Register BAR)
+  and PCIe BAR index 4 (PSP BAR).
+
+Process Isolation Hardware
+--------------------------
+
+As explained before, XDNA Array can be dynamically divided into isolated
+spatial partitions, each of which may have one or more columns. The spatial
+partition is setup by programming the column isolation registers by the
+microcontroller. Each spatial partition is associated with a PASID which is
+also programmed by the microcontroller. Hence multiple spatial partitions in
+the NPU can make concurrent host access protected by PASID.
+
+The NPU FW itself uses microcontroller MMU enforced isolated contexts for
+servicing user and privileged channel requests.
+
+
+Mixed Spatial and Temporal Scheduling
+=====================================
+
+AMD XDNA architecture supports mixed spatial and temporal (time sharing)
+scheduling of 2D array. This means that spatial partitions may be setup and
+torn down dynamically to accommodate various workloads. A *spatial* partition
+may be *exclusively* bound to one workload context while another partition may
+be *temporarily* bound to more than one workload contexts. The microcontroller
+updates the PASID for a temporarily shared partition to match the context that
+has been bound to the partition at any moment.
+
+Resource Solver
+---------------
+
+The Resource Solver component of the amdxdna driver manages the allocation
+of 2D array among various workloads. Every workload describes the number
+of columns required to run the NPU binary in its metadata. The Resource Solver
+component uses hints passed by the workload and its own heuristics to
+decide 2D array (re)partition strategy and mapping of workloads for spatial and
+temporal sharing of columns. The FW enforces the context-to-column(s) resource
+binding decisions made by the Resource Solver.
+
+AMD Phoenix and AMD Hawk Point client NPU can support 6 concurrent workload
+contexts. AMD Strix Point can support 16 concurrent workload contexts.
+
+
+Application Binaries
+====================
+
+A NPU application workload is comprised of two separate binaries which are
+generated by the NPU compiler.
+
+1. AMD XDNA Array overlay, which is used to configure a NPU spatial partition.
+   The overlay contains instructions for setting up the stream switch
+   configuration and ELF for the compute tiles. The overlay is loaded on the
+   spatial partition bound to the workload by the associated ERT instance.
+   Refer to the
+   `Versal Adaptive SoC AIE-ML Architecture Manual (AM020)`_ for more details.
+
+2. ``ctrlcode``, used for orchestrating the overlay loaded on the spatial
+   partition. ``ctrlcode`` is executed by the ERT running in protected mode on
+   the microcontroller in the context of the workload. ``ctrlcode`` is made up
+   of a sequence of opcodes named ``XAie_TxnOpcode``. Refer to the
+   `AI Engine Run Time`_ for more details.
+
+
+Special Host Buffers
+====================
+
+Per-context Instruction Buffer
+------------------------------
+
+Every workload context uses a host resident 64 MB buffer which is memory
+mapped into the ERT instance created to service the workload. The ``ctrlcode``
+used by the workload is copied into this special memory. This buffer is
+protected by PASID like all other input/output buffers used by that workload.
+Instruction buffer is also mapped into the user space of the workload.
+
+Global Privileged Buffer
+------------------------
+
+In addition, the driver also allocates a single buffer for maintenance tasks
+like recording errors from MERT. This global buffer uses the global IOMMU
+domain and is only accessible by MERT.
+
+
+High-level Use Flow
+===================
+
+Here are the steps to run a workload on AMD NPU:
+
+1.  Compile the workload into an overlay and a ``ctrlcode`` binary.
+2.  Userspace opens a context in the driver and provides the overlay.
+3.  The driver checks with the Resource Solver for provisioning a set of columns
+    for the workload.
+4.  The driver then asks MERT to create a context on the device with the desired
+    columns.
+5.  MERT then creates an instance of ERT. MERT also maps the Instruction Buffer
+    into ERT memory.
+6.  The userspace then copies the ``ctrlcode`` to the Instruction Buffer.
+7.  Userspace then creates a command buffer with pointers to input, output, and
+    instruction buffer; it then submits command buffer with the driver and goes
+    to sleep waiting for completion.
+8.  The driver sends the command over the Mailbox to ERT.
+9.  ERT *executes* the ``ctrlcode`` in the instruction buffer.
+10. Execution of the ``ctrlcode`` kicks off DMAs to and from the host DDR while
+    AMD XDNA Array is running.
+11. When ERT reaches end of ``ctrlcode``, it raises an MSI-X to send completion
+    signal to the driver which then wakes up the waiting workload.
+
+
+Boot Flow
+=========
+
+amdxdna driver uses PSP to securely load signed NPU FW and kick off the boot
+of the NPU microcontroller. amdxdna driver then waits for the alive signal in
+a special location on BAR 0. The NPU is switched off during SoC suspend and
+turned on after resume where the NPU FW is reloaded, and the handshake is
+performed again.
+
+
+Userspace components
+====================
+
+Compiler
+--------
+
+Peano is an LLVM based open-source compiler for AMD XDNA Array compute tile
+available at:
+https://github.com/Xilinx/llvm-aie
+
+The open-source IREE compiler supports graph compilation of ML models for AMD
+NPU and uses Peano underneath. It is available at:
+https://github.com/nod-ai/iree-amd-aie
+
+Usermode Driver (UMD)
+---------------------
+
+The open-source XRT runtime stack interfaces with amdxdna kernel driver. XRT
+can be found at:
+https://github.com/Xilinx/XRT
+
+The open-source XRT shim for NPU is can be found at:
+https://github.com/amd/xdna-driver
+
+
+DMA Operation
+=============
+
+DMA operation instructions are encoded in the ``ctrlcode`` as
+``XAIE_IO_BLOCKWRITE`` opcode. When ERT executes ``XAIE_IO_BLOCKWRITE``, DMA
+operations between host DDR and L2 memory are effected.
+
+
+Error Handling
+==============
+
+When MERT detects an error in AMD XDNA Array, it pauses execution for that
+workload context and sends an asynchronous message to the driver over the
+privileged channel. The driver then sends a buffer pointer to MERT to capture
+the register states for the partition bound to faulting workload context. The
+driver then decodes the error by reading the contents of the buffer pointer.
+
+
+Telemetry
+=========
+
+MERT can report various kinds of telemetry information like the following:
+
+* L1 interrupt counter
+* DMA counter
+* Deep Sleep counter
+* etc.
+
+
+References
+==========
+
+- `AMD XDNA Architecture <https://www.amd.com/en/technologies/xdna.html>`_
+- `AMD AI Engine Technology <https://www.xilinx.com/products/technology/ai-engine.html>`_
+- `Peano <https://github.com/Xilinx/llvm-aie>`_
+- `Versal Adaptive SoC AIE-ML Architecture Manual (AM020) <https://docs.amd.com/r/en-US/am020-versal-aie-ml>`_
+- `AI Engine Run Time <https://github.com/Xilinx/aie-rt/tree/release/main_aig>`_
diff --git a/Documentation/accel/amdxdna/index.rst b/Documentation/accel/amdxdna/index.rst
new file mode 100644
index 000000000000..38c16939f1fc
--- /dev/null
+++ b/Documentation/accel/amdxdna/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+=====================================
+ accel/amdxdna NPU driver
+=====================================
+
+The accel/amdxdna driver supports the AMD NPU (Neural Processing Unit).
+
+.. toctree::
+
+   amdnpu
diff --git a/Documentation/accel/index.rst b/Documentation/accel/index.rst
index e94a0160b6a0..bc85f26533d8 100644
--- a/Documentation/accel/index.rst
+++ b/Documentation/accel/index.rst
@@ -8,6 +8,7 @@ Compute Accelerators
    :maxdepth: 1
 
    introduction
+   amdxdna/index
    qaic/index
 
 .. only::  subproject and html
-- 
2.34.1


