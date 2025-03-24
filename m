Return-Path: <linux-kernel+bounces-573880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54647A6DD86
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2551887DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E82825FA3C;
	Mon, 24 Mar 2025 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EUYLEyJp"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2022628C;
	Mon, 24 Mar 2025 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828321; cv=fail; b=nTRBvyvKgRvz1UXwQUIp4RdZr3WbrDkjAFufJ+zZPmEdHTGhEfMbHAF1TIRIyfIto5P1ZjFAom44NshhBnI+gUtBPXZTxB9ZLQtMMm5MPSvzpjyt7Isz/RuNz+Anxae6Lj01fPn46bwrgV4T1FXEV6drkhV8gUTMu4dwwwo4lrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828321; c=relaxed/simple;
	bh=XG+DZbBGrb4zWpB+B/ArI6ofApxffZGn+UGi8ZJBZro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nYkfqpUInCaOtxcvdllmf7/Nku+ycI2OQD1Ci0RoDhGoEygJ51TyaaFljLWArb0ZAj3e+Z06r0n6Zz2k2j//gdY3tMX9KTK7657nghI/Dtb5SOkWA/plLnP6BRwxftwX+EfFO4jHKZkR3ISx5lQI3vtIDWKTp9qyHqn5EspTQv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EUYLEyJp; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=al85IZeWmmM3MHUYgC0xAeqjUc2eaiT8UqwgMOZP8D+9n6si+vSmNbmmIEmJ65/neJjux1EZG7YwBJiZ/vHPbXkjN+tPvJQSLkbR+9s7L1wBCBcRNq+YjdEyTo1L6MqdRx/pqI20nIqcBM8i/mCnUoPdnI3DMsXnraJzB87rxsm2rl+mBMMtgA8d39RWx4PVpxQ2FlLjSOob+E/N5KZzWWWanGurH7FYs+1hiX5ugQqpsj1GAXL8iRHYMfjavy+Jx6+aE99udtdSyaidn5EiOUZcvijoZ0aJAr4wkCm03+Fdvtv9FUogrkKAYmo6cOCjnTot1EeMaHfFz4l4NEayLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wsw1nHaGO3JoznedQOVKe8/Vv40OWNGJjbDL3MxZpzo=;
 b=UJf35WAqIKnm6QmwsqpcQVnz/tnznEH0YCtZe6bwzuDsSyLxC2bw72iKln3vUWDkXnpg0YrBMD/wZcKzX0kqO2i+0IPcY6KMDt9131aCjdZDRpvko+20wXZbVuhfSy8VHgqv3uYiSD4hv2Z2/k0ASx6TDZm76Ur5Y/SoLW/x6I4T3kX4d96rRQD+6hVxihcgE7WC56/2JwlKG6XWj7Uff76JcfcUcNh5df4LMd35hMc72nssSqMmoOWxXZnHlMs/0jqvXm0UbMVcVoclsBVuJHuVGK8RqbFmiQqWTvKauQQxcKvgwqpXD+hLWd2Y++m24BSuRIMejb9Y4XncpAOFaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wsw1nHaGO3JoznedQOVKe8/Vv40OWNGJjbDL3MxZpzo=;
 b=EUYLEyJpQepkbFnVbaY0lDd9yNE/j03eqt//cy3NB0loPvt6lYEB1+uDaVVG6nEr2p/aIqcn0Dct/DZihv0SVShVAoSnrP3dHpYBXl2cBRClOEYoPIvaFZBt8BCcknmBOLE1gocogugOfP/9iGzgSqDST+0+XJThxSYkGs1mJXY=
Received: from PH8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:510:2cd::19)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:58:34 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::2d) by PH8PR07CA0011.outlook.office365.com
 (2603:10b6:510:2cd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.40 via Frontend Transport; Mon,
 24 Mar 2025 14:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:58:34 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:58:30 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<anand.umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v6 00/11] misc: Move AMD side band interface(SBI) functionality
Date: Mon, 24 Mar 2025 14:58:04 +0000
Message-ID: <20250324145815.1026314-1-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: e2413564-ba6e-42d6-9737-08dd6ae4598e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sVAWd8GGOpxelglHvsBABnX5t2LuRE6kJhAGT1UB8nLfDsnEsoCPlZfH+/sc?=
 =?us-ascii?Q?PwkY7yn+Zm13UYoD61odUuLP+veHA7ODSgOcfasIncoPT+4QoCIqSfoOQP9o?=
 =?us-ascii?Q?2kuVjp1q3XXiALtDPSX6Ic9X7hE4i3DoAVmrYv5ZYCRv8buc3PzWbtYi3GtR?=
 =?us-ascii?Q?Aeazw/PnYxJ5QxxYjdT3GINHGFWA7RSUuXcA+KC/rwrBMjgls/iHYrNmp4lz?=
 =?us-ascii?Q?mUggXFRJxxqy/GjZNK+KQN3ZvWH7HKbEahpjYASVdWK/I6yqrOhtN3f0dN3K?=
 =?us-ascii?Q?U4hPrg7MeMHUQ46wPczVxD3hHOWP9zn12lfp+YWnxblgAXLzD2ezdOnwqWyu?=
 =?us-ascii?Q?VVUVG9EUBF4927725dGWwfZPUwuBhdMDMyWPXLqo623kyPgbAK4wy/CQk/vs?=
 =?us-ascii?Q?DfofxC0IVNQT/PLeHm5TuH5UsYB+XBgNpqLrvUC7Azn/kHuUPOHp/Dm3IsME?=
 =?us-ascii?Q?opLIxt/nXHslDWfCEwV/sUwuR7cjPoJCm60Y5Cn03ziGZfuie84/CH1IB15Q?=
 =?us-ascii?Q?El2LURWQ0AnSJ1oe/IOe5wb2Al3ZSJBaKz/PSe2vS4ENrzOhGid/xLiG6evG?=
 =?us-ascii?Q?ZPVL7ZoU88DdwwlC80pdWPF6JwGJsxGJ42eIblK/a7gfOXpuV8SwAz/EA33P?=
 =?us-ascii?Q?kp4Ojuse3/pIogA0cSbMbvHxUYQSK4UqTe0snGIvGHSGf094YAid3/HPl3sc?=
 =?us-ascii?Q?Bf1oCgOiLQ7JY1K3dWRX14ib5hCubFdhsuWJm+pXp8ZcDYaJzqCFkg0IbNlR?=
 =?us-ascii?Q?Zz3dJlg+Xh73pNDWpTpK4eEGcWH3ilGnQ9OvCy23TFcfPZZ5WtzyVJR8o/48?=
 =?us-ascii?Q?tZ3p1AuZ6FDvPUHja9A/A//8xUZUp6DQrC19v/1RtiwBjYlJIyJO3tJX2Fnf?=
 =?us-ascii?Q?vpyadR3zhukslUjWm/qY2SRt9MBf53V/jXa1IKHyJN3C2N3NY6kw/Al39ZK/?=
 =?us-ascii?Q?6z8opMeR1M2eQzcT8roglFc2ICPzvrmKQYeIakuOHbt+bGP6khYsTrNOwZBk?=
 =?us-ascii?Q?QeEJp3wpOpBErng05nHVssXsWv7h0XKiZetci7O8P2L/o9qu4P9ukQVUQXsn?=
 =?us-ascii?Q?SkP77UDgkXhV0bzZ8Cd+KM8A5U9S9cm57N5dY2JpPrPQ/YVBducw+rnPXc7J?=
 =?us-ascii?Q?bZMWXX564SEf04a4cu5lwg89o6qqvDIqb+NS3cdO2vjYVLpTIqVWn0Vr4y+O?=
 =?us-ascii?Q?dRPsUSgMUNQcX/M7URf+8QMRb71dUwuRCEha2FCykrjLk7E+HUoAndPyvk11?=
 =?us-ascii?Q?z+1Yy3MgUlA5Ti9f1NgiTOEQKYWM45VZ42YK627RScotdJ5FTk/7xJSbRS5K?=
 =?us-ascii?Q?WbhNIFNw2E+eFu7m2NXFcb5+xNLiqxw63mtpZy/l8y3z9r8X6SGlIycKxs8W?=
 =?us-ascii?Q?JnU4k0ZUj74V572E2sIZwyr9D2xFtvMXVpQEfGx98ehZGOxjxmZEHprorUvo?=
 =?us-ascii?Q?ZYNY1V0YNNDXgjv3K3UAVYq+PmOGWltgSfx4MsB2rRkQjdrWFs9iN4LiMYNt?=
 =?us-ascii?Q?0ppAWKgZBBD1xL0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:58:34.2676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2413564-ba6e-42d6-9737-08dd6ae4598e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

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
 drivers/misc/amd-sbi/rmi-core.c               | 449 ++++++++++++++++++
 drivers/misc/amd-sbi/rmi-core.h               |  67 +++
 drivers/misc/amd-sbi/rmi-hwmon.c              | 124 +++++
 drivers/misc/amd-sbi/rmi-i2c.c                | 134 ++++++
 include/uapi/misc/amd-apml.h                  |  95 ++++
 14 files changed, 973 insertions(+), 367 deletions(-)
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


