Return-Path: <linux-kernel+bounces-401055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F339C157C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843191F2253D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FF01946CD;
	Fri,  8 Nov 2024 04:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IK6eIaOz"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4617196C86
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731040530; cv=fail; b=CigDjmvL5lzMBWTlarht7oDS8iFKT4922AJmuiYvfS62nnlByL0rcIcDYpu1qpvGSzEPLXFTongDO64OYl/cadHrfkkad1PPxaj0MtS/OY8bPEGT71hSdajGRg0U5sm9Zj/bAxO4bNSh+Div81jVhw79srXsoRMu/yiDkf4mE3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731040530; c=relaxed/simple;
	bh=CF2rJUStFT6+dhR9bnFCNNjWxBY/8TwZxSk4h37A7FI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S8UWtdp/Gl3sJXHkug8EcJkinlTrhB39izsNTDxfFexPFpo+/e1YzPLRhYHCYfNEpvRVghHXn9S5wulLhjs87owK+iXVfLxk9hqabsfa5fjbRoB4jRkigeGgwr9bvYQ1+xwQgrBddFRwHgpY6lzy7wWtyju/5jxhrmkmUDF2aUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IK6eIaOz; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7rTastJBEsGv3AqkApsNUTggcoeRtnvcnT9gFRIKdG1oDaNrqBr7fpST3dcTosN/Ft5WnWgbuaC8oWZSuIj8r4Mo4XTS2W+3ixZOCqVbQH9X6BS4JZBdRfCKEUWOEBHbfAVT+CAiJX20uNgS4BzKmycfZEpdwthgl4SDso1lIE/P5jYtpl1RsZmRLNM3FV80B6m5BuZcrpLbMeUm0+bt2hSCohg/ULulDDCxYcJfCJl5AF0CuxdMOb3ZofGs2qIoEK4fbOrkf9jZPmzCIl/TUY7z1hnOV6w06Xa4gTfIbghvNfD6cRmPrNGdTmuUZB/PiUdIHAgCYNZDJO16/v3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+pNDuDjNru62yMTllMuU30V9HquGclKZgKFVNsmyoA=;
 b=nlmAplHEyCEav1Y9cdR0rdAN89zmABt6sfLk4fliwQNN5YIQo3rjkq2yMWA2Qlvo/DuVivU/7xLj+/arvhkX4KwWN2VX3Tmpr7bBN4gNP2R8eF33FHTVtJNl870E7GnTkh6n3rpQxLw4qncIm7jAmzM6EMZ9mbXsFj4DFO2gSVdrCnqIzgN0Sfxg++FI21C6cx3CIsDL3ypqpINwMkJKTBxb+lM7cI7mp0j7EBMgKh6Dj6XizoY/aFKMsGCiJC5Jz793OODy+ad8o5HeeUGQSGvefFpKhK7Rlk7BU20Si4KecGfKEb6WVHaPSQY5DyddYrQvpDKzYYHhwjXSEw0Pog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+pNDuDjNru62yMTllMuU30V9HquGclKZgKFVNsmyoA=;
 b=IK6eIaOzwQlZsaEEyv4vdihPjkAJ6n7RMCyIw/urJzOvRSFBY7SlW/i5OqtW3YFkODvLyaj6UZNzHAO+VZ5wQ03eRkln8Y+QZcP9l9lUapUSHi/PlYCFvQVUztrttWqOulfu9HU0J4e3Hj9dxfGmUyW1KDae9bXQHtJ1KG594Ao=
Received: from DM6PR06CA0092.namprd06.prod.outlook.com (2603:10b6:5:336::25)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 04:35:23 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::31) by DM6PR06CA0092.outlook.office365.com
 (2603:10b6:5:336::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 04:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 04:35:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:35:11 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 22:35:10 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<min.ma@amd.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
	<king.tam@amd.com>
Subject: [PATCH V7 00/10] AMD XDNA driver
Date: Thu, 7 Nov 2024 20:34:38 -0800
Message-ID: <20241108043448.449314-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 9543a457-2d6a-48e7-53c4-08dcffaec295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FpwBolnELLYAkZW9Q8I+3bGXo8gbfcofC/4FUDwqT1UvjVue5nrJWqnGhhSp?=
 =?us-ascii?Q?AUPeS1YLhcascQ2FYaQVTNz3/fiICpKKkFfh+qseC7TAFH3CLVxJiUJn/vWV?=
 =?us-ascii?Q?fChO5e6bPqmiS1r4ahAi+fK4oze1Kd20ry2mAXZYiw1foikYSqg9Xkgxm8iM?=
 =?us-ascii?Q?G6CCM1MJRolxy+EbjmMNqPsWMtNivrfUwA0JFrUe4yBDcIwzQZr6ROwxczel?=
 =?us-ascii?Q?aMe1t5C1fTrnGfCV4yaky4rOPet+DyBKDzmouNs2Bcyu+qQDXrIwHCVoxr6d?=
 =?us-ascii?Q?tEJ+Ta/cbi8I9ZV7kHGjWl4SkAOPT/QB2B1hNn7kJ6HZU/TjIPfAtv8rwqwL?=
 =?us-ascii?Q?5IVwhWewjN9voj5/BCXkQ7K0ZMwok08Du3FW3kwQiQdMrFDDsD+7d6sn+703?=
 =?us-ascii?Q?RCihfT85pKOFNRJ2T2cxwfQAbYzqqFCnWhYMqamdAoD15LwxTDAN/rmTUQha?=
 =?us-ascii?Q?QMnhXKGGwH/qIO592BG8bhkI4gsGS7vt9toFldINPDLVvW1FgiTfcF/AzoJI?=
 =?us-ascii?Q?xy07+swspFosgIe/AWtimRXVM2bZ6dEJZPVsoFsErLfFj/gi2oxUAyBYmriS?=
 =?us-ascii?Q?qwlCk6DMuQ6AHn79T+cHMf0Y95bdHo49ZzNXOu/SzIp42jccR/UzM4y2c7q0?=
 =?us-ascii?Q?G7r4xbcEbhyprZo9oBBj9hD+tYodJusGaPESsG4WbJj7pjd6LX3vz/grHooD?=
 =?us-ascii?Q?HKOMq6AH0T092UF1G3k2fb7wyT65AvZpBwic7BqRAqbHN6/L8Fqkt0B/SgYW?=
 =?us-ascii?Q?PnCPu51tEoSNw9iBnwoMnGN3sh5Chlt24qSDQ1cKyh06bkYYS3mq10WhluAS?=
 =?us-ascii?Q?2YXbx7R5Y57wBjdfnlPCpU/5IE0YrxjVEl3cNijnNOxxPeKFiIJmUhLAkWBr?=
 =?us-ascii?Q?smTyN27f6UxWwU9xkZZ9pcvSi1rf+t9C1dWsne1F5qNE9iR50W+j5Jy5CWrx?=
 =?us-ascii?Q?8A/+pSHUWn+GuSVSsWOOewF2+T8lNzY5myHPW0wlePj7j9OCn7/i84y2zaNg?=
 =?us-ascii?Q?G2emlk891drZx15iNTADSSrO5NB2q06lJvM44oHEHfTs+D1HcsJHiNv67crv?=
 =?us-ascii?Q?t6QNEiIrs6WCrqW96cKtfdm6+5RQB+fEm2jTLpP57HgSJ/QycmC+UH4fGsXv?=
 =?us-ascii?Q?wn4emxJ/YBb3oe4flXz31Kitw+cFpfD44a+tdhY4Elh36ve9stfQ2AndQyaU?=
 =?us-ascii?Q?B5xZAVLjt/WKo/J5gnReZifHN78rb+c/FScmkS/BZnMvxpQPRmbmbzrntZhz?=
 =?us-ascii?Q?rEKH3s4IbBXG3USZHVw76ziCOGBePh/46htepoxmHlO/gQxBjHwclZEipGt4?=
 =?us-ascii?Q?+r1auLOgAs5ZLha9fgh+lOqu1S7B0YePhuYbdZgm03FNOCdmIZol0q/NzGHq?=
 =?us-ascii?Q?EOFyy98=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 04:35:23.2945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9543a457-2d6a-48e7-53c4-08dcffaec295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812

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
 drivers/accel/amdxdna/aie2_ctx.c              | 927 ++++++++++++++++++
 drivers/accel/amdxdna/aie2_error.c            | 360 +++++++
 drivers/accel/amdxdna/aie2_message.c          | 791 +++++++++++++++
 drivers/accel/amdxdna/aie2_msg_priv.h         | 370 +++++++
 drivers/accel/amdxdna/aie2_pci.c              | 761 ++++++++++++++
 drivers/accel/amdxdna/aie2_pci.h              | 260 +++++
 drivers/accel/amdxdna/aie2_psp.c              | 146 +++
 drivers/accel/amdxdna/aie2_smu.c              | 119 +++
 drivers/accel/amdxdna/aie2_solver.c           | 330 +++++++
 drivers/accel/amdxdna/aie2_solver.h           | 154 +++
 drivers/accel/amdxdna/amdxdna_ctx.c           | 553 +++++++++++
 drivers/accel/amdxdna/amdxdna_ctx.h           | 162 +++
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
 include/uapi/drm/amdxdna_accel.h              | 436 ++++++++
 36 files changed, 8364 insertions(+)
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


