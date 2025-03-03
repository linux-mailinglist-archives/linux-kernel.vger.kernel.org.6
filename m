Return-Path: <linux-kernel+bounces-541468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4EAA4BD2B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F677A888A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFDF1F30CC;
	Mon,  3 Mar 2025 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OOXove+N"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE71EF0AA;
	Mon,  3 Mar 2025 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999566; cv=fail; b=LDEeUTQMc9vodde5wPGKVnRpfJNvoRWQYDkFKvJAYpEp7R8enRQeoL9Sz9KVmsN+Kf4cF3b+imGv24jmtsAMx3USIVGnFcxdMvqHI8iZ0IGH00g2lG10vLWq9uqTTQSENXkjexJIvc1LotL77t4gOjqj+pW9NRKvOJx2wO11sGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999566; c=relaxed/simple;
	bh=qyoBO3G/PYn3AncJz7lLq4LtjdircCRIr4VFtbVCSRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dBdjn643ri+W2jmVXJRqT51G4NMynzz/HwxJV5vkentZ5XKmQetQI0URghz4oGx0i+qM4yWfZ3SFBBiLTvdg5X4hDFLNeu8561xnbitSvycvUiNN+J+E0S0fOAGe4f8T+uxDE5YKODbZclGDk1/hgQH2lNtIV9N/UfSCblJf05E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OOXove+N; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mikvgYaSZTeIoA2kOppaOZO6rrlWcoHLka+c/gvjVSVNNjOwLVnqnanhe+ORCTB8VpzGUmc5O4OjrgBADaSN5uscaLOr0SuiX2moSa6+xkb9YG9GDYUW5glDS0CwOnSFCn9Yno7FZZQlWNXQqFK9lrxLAS0frlWBWSuqF0M2zge2KGpMH0U0Jb9VMdLOSKd17Ps/DtIklWXwgj4q6nCC0RtSVfgFvQzy1CPZjh7TEYoYUhPx43HUnBMeOdjSLKLs6vgTN2+nDKg+iwbMvvLtSSWJnad/yBjsw/yNCBEGGi8VRmpxyyiLimOf/E3DpZRxOaRVzdjhzbyHza18f0QQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeQ7peLR3O7jf3M4nsVkU+S6KrQpWoa7p8JJEfwC1TY=;
 b=Ao76ABHjJp2IBaKzIrMJQmgsM6fMfRC9efhlBoo6s0KDOJeT4lTKZ6aI1ooZhN6zOioK9Lbvl75q5TXUGU+ROhLxRWlWeoLWdKpAk6C9+uEaUdwHi38iDQZ9EjORrklZknx0Pkyp61hfI9jbLABpNn2YU/mrsTkaAjAsPokoRgQFtl8rRdQRwIDzUzLdlCiyJuKjR4qr8svZTcuXi6f+q3oNVnDnsfoPuFVEfLk3C6sWO2rvGiLRtdd6ev0VKrSN3OKfWijSx2NSwqLbFQqckTrFUllxwoAAI/Og5dQnhDXH6NkMKLF8DMxC/L0Udp7s6s4IqTuD+nYzlHSgc4Oo9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeQ7peLR3O7jf3M4nsVkU+S6KrQpWoa7p8JJEfwC1TY=;
 b=OOXove+NyzqWwkUIXyoXkX4jCUM0iebA9ENevqRBJvErELMue10wiziEPgrPipWS9UcYkYfRlWB+r7/pNogFLxvhgAO9mEhnyUNhVij+T4WgDtwZDdyrMy4cS919EWypGOO/lMhnzhBYDND0yQmZoLqjTjiJ5naRYmrhC8ejzvY=
Received: from SN6PR05CA0035.namprd05.prod.outlook.com (2603:10b6:805:de::48)
 by PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 10:59:22 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::58) by SN6PR05CA0035.outlook.office365.com
 (2603:10b6:805:de::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15 via Frontend Transport; Mon,
 3 Mar 2025 10:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 10:59:21 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 04:59:18 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 00/11] misc: Move AMD side band interface(SBI) functionality
Date: Mon, 3 Mar 2025 10:58:51 +0000
Message-ID: <20250303105902.215009-1-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: a943a595-bad1-4b93-5765-08dd5a4273e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XM/VZK12lJh3tKGmMRQe5Qepn+RJHDjUYNufeoNXxMVMXfFIDR3qFQ53sF+o?=
 =?us-ascii?Q?250O0VZszC6zAsE8uHWUKivlPH68pPxNgxDw9sXuHuWgvC7GxEnYi/gE8hgF?=
 =?us-ascii?Q?PzXQay1OS9LngBpPy5WMnMqQUefnphoh1IEwMnZb+xZ0RmjPAQbhknBhQQZ/?=
 =?us-ascii?Q?JvmaHOglbRIFSCU8mMH+GxVpjiuFC5INeOP67t/KXJ70eXGX9uy5Y9FM66ag?=
 =?us-ascii?Q?AL84A7E5gfojZJTX5ydOSc+GXn5bEjt8SSBj6FFs8Yd9arFDh9GlkzIfRGSL?=
 =?us-ascii?Q?TsznWat1s4OjJ9cdPfLu2BYvjfzIHha+6PJwBvqpAolVj2ye/tB6cNRHjX4f?=
 =?us-ascii?Q?GdbdkRD5PsNzr2kKozeHLLCb0D0LGmRTbR3DdfgL9TboZjVdv9tH+n34UBeO?=
 =?us-ascii?Q?+B/kggQyDxJBr7l8MOR8+I++C2qa64rSMFAF19p3oS89MhyUpsaE0w4Xz/gQ?=
 =?us-ascii?Q?EwWexJ7LcopPaiIPAWAei/SRyfIocvnjZWRpCxIoxFP7zGTFjh9vKa2pky2o?=
 =?us-ascii?Q?RvdaQ32b4pq/hnu6e0ow3VVioLoolc09tdGkUGgO3k1vIiIz8AUizG44YhSI?=
 =?us-ascii?Q?pSdcULLxDei7aRRskQaEUKrEUgLx2rgjnuhYdtl5r8ogTPc7MGu/sRhCKC8s?=
 =?us-ascii?Q?vymzI/OCIoerQGLf+jfUNh16SN1q9IBEl1Cj8tv3nFi+9GweSeCvpCyteNCa?=
 =?us-ascii?Q?+t3dH2TYrhEiop5cw6ax8pobIw/7Z9vBCH7r6lwN+fH+KUWcWcBr90cJXvRk?=
 =?us-ascii?Q?sZutVzWQJl9tLA75TQZsFvG6dD2mfB0Ed3oZ4bAaKMpj4zd73lSiCJWnnQ0c?=
 =?us-ascii?Q?E5RsXKnSb29i549LHA8N2MBMWyesDRggJjJdI6YxWi6IWPBjNmSS01Da8S0p?=
 =?us-ascii?Q?BXauit2xYr/2CpiDEtSAfF+7S3YkLl931Tno/IakplST8iWS94+zwpFdStsI?=
 =?us-ascii?Q?xviF2kRybMf3/ELAU0SImqmIQJ1TcmuT+Pbz82uF0Pv1azrFdjCwFOY0r2XO?=
 =?us-ascii?Q?FnC2bt5W699fxKd8jeXQf5EHg7PxOrYkKCvXg8GV5c6vPBlMVj79aGou67Fd?=
 =?us-ascii?Q?+PH1JX59l1SnoGznorrcubwm7Zold89bMqaKeZUKVyC1zTtRXlc/8UCJCy4U?=
 =?us-ascii?Q?Whn2l4aTAI/VEZ9s1olR2bl/mftcJwQGlXQS1gCakLqCzMC7fWnE3RfNnS08?=
 =?us-ascii?Q?qYAwlCMKhdItRJQN3vYjKIbmZ2NItClh+DVCnIieRCqFbrhwBQ9VEZl5SNvS?=
 =?us-ascii?Q?uYGSZlMOISe9rwT/Ml7ujpgZBGUqPNlcszN0qcOYQhuu/qdzwYUoij7uhn3J?=
 =?us-ascii?Q?2Lc+OcLvFHPclTC0tSv2wMYiuALrPq+rALim+ZU1XuG/Bstm2ypwbx5P6NSg?=
 =?us-ascii?Q?74f5BYJPfc4SiwStBdX9qOKicR91cV8+bm8jtTuc3qZbkmpgBWX9zENUx+Uv?=
 =?us-ascii?Q?yvEvBnOlRM/oKoyqAQ4mfSYuKj/FMFbWsHhWzYnZWMCwssMs+XCPzzNXDqgC?=
 =?us-ascii?Q?A2Vb3HhkinXkmGk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 10:59:21.4423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a943a595-bad1-4b93-5765-08dd5a4273e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281

At present, sbrmi driver under hwmon subsystem, is probed as an i2c driver,
fetches data using APML specified protocol and reports through hwmon power sensor.

AMD provides additional information using custom protocols, which cannot be
enumerated as hwmon sensors. Hence, move the existing functionality from hwmon/
to misc/ and add support for following custom protocols
  - read Processor feature capabilities and configuration information
    through side band.
  - read Machine Check Architecture(MCA) registers over sideband.
    The information is accessed for range of MCA registers by passing
    register address and thread ID to the protocol.

NOTE: AMD defines Advanced Platform Management Link (APML) interface which provides
system management functionality access to the baseboard management
controller (BMC).

This patchset is an attempt to keep all APML core functionality in one place,
provide hwmon and IOCTL interface to user space
1. [Patch 1] Move the i2c client probe, hwmon sensors and sbrmi core functionality
   from drivers/hwmon to drivers/misc/
2. [Patch 2] Move sbrmi core functionality to new core file to export core functionality
3. [Patch 3] Move hwmon device sensor as separate entity
4. [Patch 4] Convert i2c to regmap which provides multiple benefits
   over direct smbus APIs.
    a. i2c/i3c support and 
    b. 1 byte/2 byte RMI register size addressing
5. [Patch 5] Optimize wait condition with regmap API regmap_read_poll_timeout as per
   suggestion from Arnd
6. [Patch 6, 7] Register a misc device which provides
    a. An ioctl interface through node /dev/sbrmiX
    b. Register sets is common across APML protocols. IOCTL is providing
       synchronization among protocols as transactions may create
       race condition.
7. [Subsequent patches 8, 9 and 10] add support for AMD custom protocols
    a. CPUID
    b. MCAMSR
    c. Register xfer
8. [Patch 11] AMD side band description document

Open-sourced and widely used [1]_ will continue to provide user-space programmable API.

.. [1] https://github.com/amd/esmi_oob_library

Akshay Gupta (11):
  hwmon/misc: amd-sbi: Move core sbrmi from hwmon to misc
  misc: amd-sbi: Move protocol functionality to core file
  misc: amd-sbi: Move hwmon device sensor as separate entity
  misc: amd-sbi: Use regmap subsystem
  misc: amd-sbi: Optimize the wait condition for mailbox command
    completion
  misc: amd-sbi: Add support for AMD_SBI IOCTL
  misc: amd-sbi: Add support for mailbox error codes
  misc: amd-sbi: Add support for CPUID protocol
  misc: amd-sbi: Add support for read MCA register protocol
  misc: amd-sbi: Add support for register xfer
  misc: amd-sbi: Add document for AMD SB IOCTL description

 Documentation/misc-devices/amd-sbi.rst        |  87 ++++
 Documentation/misc-devices/index.rst          |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 drivers/hwmon/Kconfig                         |  10 -
 drivers/hwmon/sbrmi.c                         | 357 --------------
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/amd-sbi/Kconfig                  |   9 +
 drivers/misc/amd-sbi/Makefile                 |   3 +
 drivers/misc/amd-sbi/rmi-core.c               | 445 ++++++++++++++++++
 drivers/misc/amd-sbi/rmi-core.h               |  67 +++
 drivers/misc/amd-sbi/rmi-hwmon.c              | 122 +++++
 drivers/misc/amd-sbi/rmi-i2c.c                | 133 ++++++
 include/uapi/misc/amd-apml.h                  |  97 ++++
 14 files changed, 968 insertions(+), 367 deletions(-)
 create mode 100644 Documentation/misc-devices/amd-sbi.rst
 delete mode 100644 drivers/hwmon/sbrmi.c
 create mode 100644 drivers/misc/amd-sbi/Kconfig
 create mode 100644 drivers/misc/amd-sbi/Makefile
 create mode 100644 drivers/misc/amd-sbi/rmi-core.c
 create mode 100644 drivers/misc/amd-sbi/rmi-core.h
 create mode 100644 drivers/misc/amd-sbi/rmi-hwmon.c
 create mode 100644 drivers/misc/amd-sbi/rmi-i2c.c
 create mode 100644 include/uapi/misc/amd-apml.h

-- 
2.25.1


