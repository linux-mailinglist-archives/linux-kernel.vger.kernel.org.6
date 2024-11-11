Return-Path: <linux-kernel+bounces-404428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF629C43D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF721286BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AD91AA1C3;
	Mon, 11 Nov 2024 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aViaCK+D"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3E51A76C6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346359; cv=fail; b=XCFuelS+jTNtyKWhFs6k3OzKDvQP3dTnPDYdvut8HkaH3AxFWQ6/UxX0xsjH8lgeuNMHA0/4/tUuvYDAprEqcgZW/2eTyYEjcrSBkT8YEQ5+8ZFSYEI88ZroH+QuBjBgyd1atd5pzCuZ9OeTn4/03nLyLlyz5vByb3VE5AdOThs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346359; c=relaxed/simple;
	bh=bBz7zUUnADmup4w8vRPK1I2E9gkFfP8gLygTAcTMiz0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eyVxv9ypZ9id58sa9glvOHXjmgfAyNqi8E1W3DVcX1Q56uFZpeNeXz4MtBSDEmNm+asNR6cfb73UIdd8g+f5n3kN5R4WerTIu/PxUzimVAV7Za2cDifEufpPIAFtho0vcvaIHoxbaLNyrDfxLKE37ZrsfL5O46LQfiukVdNjB7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aViaCK+D; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyUYnBKYv+S5HoebohM0L6eoSGBYSEdrvs2BlMTouHs3fXStZvG8Jbn9ZU6eew135iFxTtFB/k3xD3yZB4yZsAtuO1XEHBnDtGDwjEJt56Y7lybN4cFYsqKk/sMzEycfSn5iAnnfY28kjWuotGYHE9jn2q+fSoZvOqJrPrHUxLp5r6iWeSrM//TgMU7vc2wtPuB+/R3/dzq5p3w4rbe/rrhji78qwap72xOpdznz9KVFV/VcGHwqBNp7u1Ei+jEDs0MM4I2mh4EkScjE2XDq6EjuL+F8XK+BQDjH0pmPm3emyAjWuDri/Go4PYp2PsdW+Uj9DtFtmXINsaecDfqoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmF96TlT+PR/w6hGwdGNrrojWyWQIbrAtESFU+BdrEA=;
 b=EH4UtAL1lV8n2px+c674B4BWFwDAc3N9VEoD9hFHKvSmdQvsIZZ4Ps5pSAMvgEbNQIMIytCgVhJYry9BBn8EiItJFwP1J+gioiBf/5ztaOm7Tq+wsVADDQudHOQHj6v9PgDHjGvldDZYVIectqazt13i6D6eFrDhBXQf4WeNXJHvRlVG/VIE4To2v3Cri66IPT1m/7D8a+VbykMGtFgglqTVTgsM0bFmJfSetW8lJi9+uv/pU4Ak2F8GMk0Td/vFnrXnahxLn10h+oPm4gjfkfX/YhJp4el5CiqrY1AWxU8Aes3zcnQ31Zz61HSLbthjHCrOP3TZrawcPWSmMhYzMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmF96TlT+PR/w6hGwdGNrrojWyWQIbrAtESFU+BdrEA=;
 b=aViaCK+DsLmHGfDJ48pur9pqFiAGtx0P70tOQbuvw4ZsHbaT/dETf0yTbGboP1KfpPmnIMCy6cbpGU75VASdBCXbHiWBMPjh0KFLbSo64nejS2dkgrR1TacJiBIHiNIYONstBhEckoagjbgjjrM9Rp44QS+8bT+EpoK8VzSUy90=
Received: from PH7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::20)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Mon, 11 Nov
 2024 17:32:34 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::ad) by PH7P222CA0017.outlook.office365.com
 (2603:10b6:510:33a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Mon, 11 Nov 2024 17:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 17:32:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 11:32:33 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 11:32:32 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<min.ma@amd.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
	<king.tam@amd.com>
Subject: [PATCH V8 00/10] AMD XDNA driver
Date: Mon, 11 Nov 2024 09:32:20 -0800
Message-ID: <20241111173230.655325-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: a67bcc23-252f-4678-e86b-08dd0276d419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OsvctLfOajVm+Eij2NAtcgv3YOzrQ7PzibTYCMLd6tHM3CZQ77OJfE0yUrSg?=
 =?us-ascii?Q?lc2HADMU4DXA/C2kOVvPjRxmVBfSWaoyGNXywDlcWYN1cWOS31/8l9Ru3EHw?=
 =?us-ascii?Q?/mcKXrmh2B6n91y9AOcQOF2OJsCFGPIRimpTuxsee20MvD5V2QhlTbpuUzLi?=
 =?us-ascii?Q?+IczgJtdiGevEL2n32l+JP9NmXdZ77jw/JEK7kWphSBJh2kOisOpvFtC/7zG?=
 =?us-ascii?Q?wjXMQSnyDu/6YdzL8oBUdimDKEmi/WM50Q7WyPMMZrCsR1qpimISh2F4gN3R?=
 =?us-ascii?Q?R+P3oHwfSKI33z4YLG1oemKz7QmQSbB4v89IDQEBWYvpC8rOtj65kKRXMw3Q?=
 =?us-ascii?Q?xO9x7uPMBDR0PJ9Uxa2RL8pKRZ6rQ84ZFrJQjYoh5mt1IpXN3y/fwB6hqJcR?=
 =?us-ascii?Q?8kSXDc370WwI4u6uhYWw6CrEtWkIIcZTXbUcOvCJGBuhNRM8fi6x5JNQRORp?=
 =?us-ascii?Q?dMY5tdGzd6/xP7Hj49OmC5xUR/l4L/nh/85qDeJztKgsAwTWPQq0XpmwIuYX?=
 =?us-ascii?Q?cIWyU68uZtDA/p/SpygmZLM9d7dY/pp+PE1KAM/vSs005zIYJKwG+FZ+QJm1?=
 =?us-ascii?Q?bqJt80roFtQMFGnGAujbvioGj2GsDa+eF55y2YOxUHqsXoxza4q3gduNOxOj?=
 =?us-ascii?Q?FJhNtmQFSNZcL5cxb1a0JDCO1whEp23GEepiIGCiw97ywxnShXwSk98wQirZ?=
 =?us-ascii?Q?MIFcXWySPh6WtB/AxQya4IfgGmo44agskSxdWv6p7/GtIfVqnsdKVPCw9t65?=
 =?us-ascii?Q?wFtOp2jk5uRFljH30jtt0nVrenfquCJgTR06W2RNkq5wmhHrazCRvrb8rVAV?=
 =?us-ascii?Q?sDLZpxIkz9HLv279PYrsKsM3o19Z8bhmp6eisRH8i+vLP/f/FICBZzK3K6O3?=
 =?us-ascii?Q?Ttaf1LY7zmCdy+zquYAFTN1B4eeALGye3wwrJ/bVGrWvRHfM0Beqj7BcZFLh?=
 =?us-ascii?Q?NWiYIAC1syLx3aHcYTVPDW7+Yrs96a8tKnJmTvwwUTs+JQH8i0C6J8TEZB5a?=
 =?us-ascii?Q?qcU2HeZMqP5iEZhxOeMiOJZPLK45q021/za6HVJegVL5GbtS4L/bgu2L8nEM?=
 =?us-ascii?Q?esuIC974Dz0MKMwzZHnrDuWq2nsn3HuuJ+Ni8z2an21YTuQugDzI3eT71vXb?=
 =?us-ascii?Q?zsAtjYQPPxTX+1b+AhdzzD4W3SPsPzCqSEZUkiZz85XejVo/mAeUX59Zb3XC?=
 =?us-ascii?Q?15XsZS1uXLCzXMZShRNiVEywlHwzTFiAyuMgDEjOrKQZKIX3hbVYfQ3BcwyU?=
 =?us-ascii?Q?dS5amv9ljfWw4z9c9rq6ZvhUsv7IbbTnbMTs0is8A/OHzdEiZ5Yh8At7AvT5?=
 =?us-ascii?Q?k2ZWeGoe5HKX+5OTNgL7JKNyybVc2EODP4NznJ8v3jRGvUZE2XRxfzFhF6qV?=
 =?us-ascii?Q?cHja0+U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:32:34.2623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a67bcc23-252f-4678-e86b-08dd0276d419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011

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


