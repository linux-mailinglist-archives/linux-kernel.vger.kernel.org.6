Return-Path: <linux-kernel+bounces-413303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2569D171D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3321F23078
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31DC1BE86A;
	Mon, 18 Nov 2024 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="taJrxGKc"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7F199EA3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950999; cv=fail; b=bIq0ZOwUsdQcch/RF17KsL7E7Mzii7ttTf/pwyunTfJq7hpg121x7HbLiIll3IxPuqQXAluOZ7ukfeWydw8PzAujeE6Nab3ZcbnAZbhGQHJxdwz2R/8dtgTv7lqFubDJmHkzaVM21FrSQu30mfrT7JVC5fW3XTeVoE0p7FzJbXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950999; c=relaxed/simple;
	bh=w1q8b3bQXce9v+ZcJsS90abLMXNMoA0qp2KxRlcpcVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wffuqm88kA5G07lvLyT10kX/ATrtK8FbliAPB7a6Soz58TY1jg4egnAKy9GhQZAw/XlBuMa3Do5XR1XhnZliw+uOBQa+99Ut9qHf3GjKmY80XS47891sEzdAu/9wisDV+4aho2HDeWkJM/zMD7HvDq2HZDZ6b/GfIRG9sB8+3bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=taJrxGKc; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdWqwTmYJvdMHxW/mnbGcY+rHQTvmPzjTirJcTfNW6mFI3uvYb1tKO3B9slq/e8SFyf3UeZCMGVKYFyKTfeywvgcmKvuBEglW5TMPdWSvc32H8YfpxrQWgIiom3WnvA2QMEZpXJLJsldgAzsFmybakqV3VzdXsynrI2Yf1jMfHai1MKL1i0M8KkonA2AM0KlMGwgPmbf/HDyJ9NzQNIQDEFPYh0XqTkxKEn1x1o+YaLsj4q8OGfBlNWffUwaYrxSK2unKati+7Rm+6JESLWFp8ijSWfS/OPABTV290beDMF1aCcs9PFwkz30HeE/zmO++WGm8I43KG3dZcDFoZuVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRpaPcO/RXuq4Qde8hUEHqFx9hLMe4m11ddf1p14D4g=;
 b=OTTFOlLcC4foPA1ysrnBa8PvA2y7csXQ0XkKM4pNId78OVuMZbYjy25/kx9EXs0eZ6QiG3W5pZaqi+flfT9A51TgmvRXuXzMUEQ84uQMswR+pko1pCRKeFAw0pH1goOeEVs82l+iWiAg97bz2KigvpWX4ZDTXD8GSYuyxIlrdTq5/TA1V6Tl/wzpsa1ajTTzJrzA7AOHBir2s4j9II7ZhugfCqAhvlBLLSqDsNOPmq1n66LBCu3G2yFKlKMjfdFtZIR4Md2yZ67Qo2h/mF9wd8++BMn7XBVIW5VnmfFzoeD3Vd6dB1zkdY3dETqkXH3bhL/WM3tbPyt7yidJGH2KVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRpaPcO/RXuq4Qde8hUEHqFx9hLMe4m11ddf1p14D4g=;
 b=taJrxGKcXdIMzz7iQlLObY2nn0rrXS138IF7k48pcMk+0ZBWFMA21kRR2ZaT9NY1hfgKZPyh0uaJWag+9b3LONP40mV4YKci0bNVn4ZTRvdksDWKaUo4aP51yrDfbSAyBgsIz0s9DL8tQYLEZh3jtreaeiytjyu6wu11bkS/8Fc=
Received: from BL1PR13CA0333.namprd13.prod.outlook.com (2603:10b6:208:2c6::8)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 17:29:54 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::3e) by BL1PR13CA0333.outlook.office365.com
 (2603:10b6:208:2c6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.13 via Frontend
 Transport; Mon, 18 Nov 2024 17:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 17:29:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 11:29:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 11:29:53 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 11:29:52 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<min.ma@amd.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
	<king.tam@amd.com>
Subject: [PATCH V11 00/10] AMD XDNA driver
Date: Mon, 18 Nov 2024 09:29:32 -0800
Message-ID: <20241118172942.2014541-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c4c120-201f-4393-620b-08dd07f69d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W+f4PMStg/HOmKIUCmOns41BgXiAetZdOjbR/C/BXRCxVv+pM+mIDD5blA+n?=
 =?us-ascii?Q?00x9kxn94ZMode7SxPp6KwbuCWs5srmmhdSFgPPzJTprvGKsr62M5ICSrc+v?=
 =?us-ascii?Q?l6kpmOXHcp8CK6+unog8EtjBjqazP7/1OcOgJ4p0TvgRve6XBUztLwG/+s6h?=
 =?us-ascii?Q?TsereqGHL4GFjqjv9kTnwWaKYpYeU5AE1znZ8B9iUp8/Vd24kGL2YKBwquw3?=
 =?us-ascii?Q?4HDtKSFyfpg3j8O9Nwbu2Aglj+Q0e4IEUQshvhm/cbEHyFE1gWJiOIKGgr57?=
 =?us-ascii?Q?BeoGpNcUAmqj2DTcjAOOpE9X+CYdPkuqq/AxsMZ88QEZ/mD4Bwxkt5oXNLVr?=
 =?us-ascii?Q?RCrcJCXs1IMv/th+DL0bbeOJdAWXU/HlpCQx6avigr0139uYE0b9UkBOcFBs?=
 =?us-ascii?Q?q1qIh44LJk8oXZg4PvV6ZoD7s9mrab/r0gAcg3EYCZRLuht4L7ww6PeYw+Cn?=
 =?us-ascii?Q?bqud4KA6dLuDyXrabB3BxUzkO3qaWqSdC9NjhInLRiTGZWcqzmEZ4aPkgz73?=
 =?us-ascii?Q?NHwhIxpqSUPhMeHoRjIsmumg2NMWenTuLCODSX8RqG49B2bgF8XrBxJSJRdI?=
 =?us-ascii?Q?zgq7UrYEKb7+GBYgYB9iLr1UeHdtaDCgqtZ/q4CxLNNAAxSq/vKv13wBCjcY?=
 =?us-ascii?Q?wrsbvd7pU9kAWDYXq4iiTHy0XLTHwxnjsrwzod0Bo476NtoPIaEpVYxjHfKm?=
 =?us-ascii?Q?Mv83cCf/s/au6Dc85skTGrT06/a5JUS85qi0jYUeJA50MVDQuirli682GQe5?=
 =?us-ascii?Q?eSAKaheRfIpB1j1KB2XpFlgI9yIFLHSCeIldoejYFMyr911vfRKDQnZKb8SZ?=
 =?us-ascii?Q?gVOYgCh4yxWv5xb0WS8EyNqb9cHtqDsUm1h4GnSQT8zeQL9W8Q7XawXBM9Hg?=
 =?us-ascii?Q?PUguDDZFZ2B3tIcsVZS+5Z9+ASWk7GciuL4Ng3iKnkzqZumlJhwY/HQUHtoj?=
 =?us-ascii?Q?DtD7CHdYgYSmFSPR90h9u+J6wq2p4bTVAjQn8fDKPWTam5PcjQ48gUx4hTVi?=
 =?us-ascii?Q?+nEli+niHfGIjqaQ6JvWfPmn9jbchr5j1bxIyA+htPb67RPCXev6WAIBsnP3?=
 =?us-ascii?Q?QheJS1J3g9XAhoytWkBAGVGmXC3kmeXS3XES7zIifFjRYfUVUdTHa7bsaqsi?=
 =?us-ascii?Q?Z4W9WeoVBuPn4ltKitEcutl5Ogfe6CM6RrJOZPpIXKCJJP+HAGRlp9dqQjxw?=
 =?us-ascii?Q?gRwL/fmNVAikZuK+IDgDcFOkcIaVJKIJXSx4iDZEdxCikdcVKL0utzHDXU+h?=
 =?us-ascii?Q?1bzRhNDykUmbgFp7ZDiXzR8E7hucCc6bslg5K1Ai4Ftd6qUlVZNVJeppmZWe?=
 =?us-ascii?Q?V1IjZOACQMDnhe32n10CSCPYQ4RLm0CLryDyfnnHIbxp6j42wUGwTbpi994G?=
 =?us-ascii?Q?8fpx2Dc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 17:29:53.7510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c4c120-201f-4393-620b-08dd07f69d41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908

This patchset introduces a new Linux Kernel Driver, amdxdna for AMD NPUs.
The driver is based on Linux accel subsystem.

NPU (Neural Processing Unit) is an AI inference accelerator integrated
into AMD client CPUs. NPU enables efficient execution of Machine Learning
applications like CNNs, LLMs, etc.  NPU is based on AMD XDNA
architecture [1].

AMD NPU consists of the following components:

  - Tiled array of AMD AI Engine processors.
  - Micro Controller which runs the NPU Firmware responsible for
    command processing, AIE array configuration, and execution management.
  - PCI EP for host control of the NPU device.
  - Interconnect for connecting the NPU components together.
  - SRAM for use by the NPU Firmware.
  - Address translation hardware for protected host memory access by the
    NPU.

NPU supports multiple concurrent fully isolated contexts. Concurrent
contexts may be bound to AI Engine array spatially and or temporarily.

The driver is licensed under GPL-2.0 except for UAPI header which is
licensed GPL-2.0 WITH Linux-syscall-note.

User mode driver stack consists of XRT [2] and AMD AIE Plugin for IREE [3].

The firmware for the NPU is distributed as a closed source binary, and has
already been pushed to the DRM firmware repository [4].

[1] https://www.amd.com/en/technologies/xdna.html
[2] https://github.com/Xilinx/XRT
[3] https://github.com/nod-ai/iree-amd-aie
[4] https://gitlab.freedesktop.org/drm/firmware/-/tree/amd-ipu-staging/amdnpu

Changes since v10:
- Fix build error against drm-misc

Changes since v9:
- Change notifier_lock to rw_semaphore

Changes since v8:
- Fix mis-merged line

Changes since v7:
- Prealloc dma fence chain before publishing dma-fence
- Install the job's finished fence in dma-resv rather than driver fence

Changes since v6:
- Revise command submission flow

Changes since v5:
- Remove wait_cmd ioctl and use syncobj instead
- Cleanup spelling errors
- Add dependencies in Kconfig

Changes since v4:
- Fix lockdep errors
- Use __u* structure for struct aie_error

Changes since v3:
- Remove debug BO patch
- Changes based on code review comments

Changes since v2:
- Add document amdnpu.rst
- Change AIE2_DEVM_SIZE to 64M due to firmware change
- Changes based on code review comments

Changes since v1:
- Remove some inline defines
- Minor changes based on code review comments

Lizhi Hou (10):
  accel/amdxdna: Add documentation for AMD NPU accelerator driver
  accel/amdxdna: Add a new driver for AMD AI Engine
  accel/amdxdna: Support hardware mailbox
  accel/amdxdna: Add hardware resource solver
  accel/amdxdna: Add hardware context
  accel/amdxdna: Add GEM buffer object management
  accel/amdxdna: Add command execution
  accel/amdxdna: Add suspend and resume
  accel/amdxdna: Add error handling
  accel/amdxdna: Add query functions

 Documentation/accel/amdxdna/amdnpu.rst        | 281 ++++++
 Documentation/accel/amdxdna/index.rst         |  11 +
 Documentation/accel/index.rst                 |   1 +
 MAINTAINERS                                   |  11 +
 drivers/accel/Kconfig                         |   1 +
 drivers/accel/Makefile                        |   1 +
 drivers/accel/amdxdna/Kconfig                 |  18 +
 drivers/accel/amdxdna/Makefile                |  21 +
 drivers/accel/amdxdna/TODO                    |   5 +
 drivers/accel/amdxdna/aie2_ctx.c              | 900 ++++++++++++++++++
 drivers/accel/amdxdna/aie2_error.c            | 360 +++++++
 drivers/accel/amdxdna/aie2_message.c          | 791 +++++++++++++++
 drivers/accel/amdxdna/aie2_msg_priv.h         | 370 +++++++
 drivers/accel/amdxdna/aie2_pci.c              | 762 +++++++++++++++
 drivers/accel/amdxdna/aie2_pci.h              | 259 +++++
 drivers/accel/amdxdna/aie2_psp.c              | 146 +++
 drivers/accel/amdxdna/aie2_smu.c              | 119 +++
 drivers/accel/amdxdna/aie2_solver.c           | 330 +++++++
 drivers/accel/amdxdna/aie2_solver.h           | 154 +++
 drivers/accel/amdxdna/amdxdna_ctx.c           | 553 +++++++++++
 drivers/accel/amdxdna/amdxdna_ctx.h           | 162 ++++
 drivers/accel/amdxdna/amdxdna_gem.c           | 622 ++++++++++++
 drivers/accel/amdxdna/amdxdna_gem.h           |  65 ++
 drivers/accel/amdxdna/amdxdna_mailbox.c       | 576 +++++++++++
 drivers/accel/amdxdna/amdxdna_mailbox.h       | 124 +++
 .../accel/amdxdna/amdxdna_mailbox_helper.c    |  61 ++
 .../accel/amdxdna/amdxdna_mailbox_helper.h    |  42 +
 drivers/accel/amdxdna/amdxdna_pci_drv.c       | 409 ++++++++
 drivers/accel/amdxdna/amdxdna_pci_drv.h       | 123 +++
 drivers/accel/amdxdna/amdxdna_sysfs.c         |  67 ++
 drivers/accel/amdxdna/npu1_regs.c             | 101 ++
 drivers/accel/amdxdna/npu2_regs.c             | 118 +++
 drivers/accel/amdxdna/npu4_regs.c             | 118 +++
 drivers/accel/amdxdna/npu5_regs.c             | 118 +++
 include/trace/events/amdxdna.h                | 101 ++
 include/uapi/drm/amdxdna_accel.h              | 436 +++++++++
 36 files changed, 8337 insertions(+)
 create mode 100644 Documentation/accel/amdxdna/amdnpu.rst
 create mode 100644 Documentation/accel/amdxdna/index.rst
 create mode 100644 drivers/accel/amdxdna/Kconfig
 create mode 100644 drivers/accel/amdxdna/Makefile
 create mode 100644 drivers/accel/amdxdna/TODO
 create mode 100644 drivers/accel/amdxdna/aie2_ctx.c
 create mode 100644 drivers/accel/amdxdna/aie2_error.c
 create mode 100644 drivers/accel/amdxdna/aie2_message.c
 create mode 100644 drivers/accel/amdxdna/aie2_msg_priv.h
 create mode 100644 drivers/accel/amdxdna/aie2_pci.c
 create mode 100644 drivers/accel/amdxdna/aie2_pci.h
 create mode 100644 drivers/accel/amdxdna/aie2_psp.c
 create mode 100644 drivers/accel/amdxdna/aie2_smu.c
 create mode 100644 drivers/accel/amdxdna/aie2_solver.c
 create mode 100644 drivers/accel/amdxdna/aie2_solver.h
 create mode 100644 drivers/accel/amdxdna/amdxdna_ctx.c
 create mode 100644 drivers/accel/amdxdna/amdxdna_ctx.h
 create mode 100644 drivers/accel/amdxdna/amdxdna_gem.c
 create mode 100644 drivers/accel/amdxdna/amdxdna_gem.h
 create mode 100644 drivers/accel/amdxdna/amdxdna_mailbox.c
 create mode 100644 drivers/accel/amdxdna/amdxdna_mailbox.h
 create mode 100644 drivers/accel/amdxdna/amdxdna_mailbox_helper.c
 create mode 100644 drivers/accel/amdxdna/amdxdna_mailbox_helper.h
 create mode 100644 drivers/accel/amdxdna/amdxdna_pci_drv.c
 create mode 100644 drivers/accel/amdxdna/amdxdna_pci_drv.h
 create mode 100644 drivers/accel/amdxdna/amdxdna_sysfs.c
 create mode 100644 drivers/accel/amdxdna/npu1_regs.c
 create mode 100644 drivers/accel/amdxdna/npu2_regs.c
 create mode 100644 drivers/accel/amdxdna/npu4_regs.c
 create mode 100644 drivers/accel/amdxdna/npu5_regs.c
 create mode 100644 include/trace/events/amdxdna.h
 create mode 100644 include/uapi/drm/amdxdna_accel.h

-- 
2.34.1


