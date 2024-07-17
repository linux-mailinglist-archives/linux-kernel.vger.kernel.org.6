Return-Path: <linux-kernel+bounces-254861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F90993389C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA43284236
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4B922611;
	Wed, 17 Jul 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EcMUgZbY"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002A1BC49;
	Wed, 17 Jul 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203852; cv=fail; b=i/OD9OK+lNYGMNmHPdoi7Ka+OMGW4zUjYFS79Amlwk2Cwg8jX7lKKam5T9icssYOW654LH5Z222e8TSt/OfFOsSbsGZK/wnAvDkOIe0Y/9omTrM018bHboA3g+ZN+ahDU4V5ra9PGIsVh8tzHMNOUhURrYcyOPmDIPfUDQoJP+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203852; c=relaxed/simple;
	bh=cqDjiYIoBrKhsf9egtIPOdVMhUIFpTNikj46l3gWq4E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UMOejw/JbioiZ8y1qvXNhnFK4zKc79s5mrTAHuor4sfgYLAIGqKSTzAzNcNmXpXEpbDKjBW728cHoWWsQQ0SCco2+4Lc5SyBZX1IOa88GvOYlI6BmCMomR6/hgRLmZFpMtPFre+QkaAT9L1wuoVmVVhu+T5BCHZx3MmA7vcN83M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EcMUgZbY; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdYplsKTBoEu3C1H6Nju+7hJqrvMj7W6jFUhkvA0ljOJoOCFXhs18aPdMo/1AFyjOXmzZIhBuf6BiYuirVEk0Q1WZrVUvWE+2UamX5h7tjiHFU4yQAmiC4TORljTFTZp/UJTq1WYK4okeMGECnhZ0Kn1tf3pX/wQYkLkaGFQeza1V8/PuEMYB3dq2jblqkDwIxGbKmwo5Kj6nGKgNmO8hEruSrDXjftQE2+WblDwgpSNYYKs4VHXJ+PGsjIQIZ8KibJo3hpEmaYPUvTszBSXsN6Dz+9UhhBg9EV/Pwu6QnKBm3oLXtAG+fK9CaWp78tN/v489D001jPaxaks1KoxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K9XpMfu51uoFgwpgeXy6TK0/K3vXX3nZzRGSXTybZ0=;
 b=THu57IAUTlqbpSJFXgWfC+s/smJwtaTmWCAhqZoozDoS9ocUhn4xontYYziL80O9xH7qDsVnHh9mM7Db5kRT6+b2L7Zm+e4n9ICXl4E1IU6FERz7haDIKbQGS6ZUvWOIqTwTmWsNLSFP9RL6D0RrZmF9LWKwquDi/Owr58yKnFUQSl4T46wHsWko3fgtvevkpoevzyALyC0I077iswXnGiruhixH2Fm6/wg6/bcF4qKX9UOx2fedwhFEngmNdYD6wE1oc1wcFtDtOy5L5YNdFhHsiPDpNGGvXHWEscHqlAiEuyi7IMDB8EWOZJKrgb67QVBUICyluAmp0mtOjE7JvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K9XpMfu51uoFgwpgeXy6TK0/K3vXX3nZzRGSXTybZ0=;
 b=EcMUgZbY4geOWg5JWoibDxwQVvlCIxecsqPMOlGjRnZIE8FGEHcepZSOs14cddLAA1o+p6fpbELmjSGeWoDwIknKlXmPqRCvCE4SxFiJ9k4An+P79Z6InqhlkvACC9W7WI4KUzAhSYj6NB+8akm9PxzV8l92h/FXu1qKTdvO7jY=
Received: from DS7PR06CA0009.namprd06.prod.outlook.com (2603:10b6:8:2a::28) by
 MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 17 Jul
 2024 08:10:46 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::5d) by DS7PR06CA0009.outlook.office365.com
 (2603:10b6:8:2a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 08:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 08:10:45 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 03:10:43 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v2 0/8] misc: Add AMD side band interface(SBI) functionality
Date: Wed, 17 Jul 2024 08:10:19 +0000
Message-ID: <20240717081027.2079549-1-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fdab58-6817-461a-72f8-08dca637f601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FaDxsY4oBJaI7S92a3fBiA/deLI0IaaVX5O0sEqGfeyPVmXhZcc1Dl3fYUfy?=
 =?us-ascii?Q?ZrvQaiT7/aywMq8q3xMkMhmCQXbcqVryxIaXPVX9/jVonWCHhg4iDuZ1/JH6?=
 =?us-ascii?Q?tCvk23TaCOXmResFMSIDzYWDYWguhitfeBT5ITomsHSQndptrWghBffx4s+f?=
 =?us-ascii?Q?9UWvucsEeyNS1Iedkmr9Z7rYPM32yCbHyGFQO5Twsl4bIAqcKPOwFadkRsvW?=
 =?us-ascii?Q?jl8QOmeewxt1baDcrsD6sJeGM45hLGHFM1z/K0nbKhmUGIjPfL8mkiQ4qU8D?=
 =?us-ascii?Q?rFcSvRLxxBTrASqdYZvthKCb2PA1UNn6VMGveqp62yB+dcn9RDkSWO8KGwey?=
 =?us-ascii?Q?LyEqxruJG6ifQ9UaS+quY0M4jMqL/Baj3bH409YAy0Z6akU3yD3pW/4I2hEx?=
 =?us-ascii?Q?qnD4IEl5DqiEqeg6BjmhqamYRzOL3fy/gVUk34Lhcl4JQqQfY2BgjR+vXMiV?=
 =?us-ascii?Q?8I+jCBqQeHK/Jf5wyqRIb5L6EuJUyWB9q+XWfJ4cZ6L4CYqVGu+y4Rc47QLd?=
 =?us-ascii?Q?dqBd7C1IM9DwTOFpK36oxeUTdlimPXJ48bIGvNJlNisAShsZeAzQ01Iljj3/?=
 =?us-ascii?Q?VcXmPVcC4iP1XVCEobv6JiFEIj6dchCDE4lWuAAhnR7W2TJUqf9cwi448q1x?=
 =?us-ascii?Q?kVuYBdZxy/rqBABVxhgjE3yY0Gciw5SNHbBnEMA/BL3OMa9aF/pZqQjkpF94?=
 =?us-ascii?Q?d6xumoGxCaTzUkuwvUL9Td2QmLdvuuMJk8DnQw2b0z/fv/m+83ZPX8NqsHgc?=
 =?us-ascii?Q?uwlH/FWZydv3TTowVNXN75pxZavqYwKTVSLe4G1XyeBidwWW+58HZQHrkBt1?=
 =?us-ascii?Q?JDoYRwb4ERwZRD7lCH9gFzMGRgmWvIjsqQ3rQGipXDpga2HQPt9lDi13sKxo?=
 =?us-ascii?Q?sdYFToXWVyk3tkBZTy2iNuzuaoKV9ONDKgWqx6rbl195pbZpaTrkfVALQNld?=
 =?us-ascii?Q?lRn9xs7ghHw7G771yS21reAsrV9O07mUZCm0PePRC+I8sYXJD2lO0BN4xxmL?=
 =?us-ascii?Q?MrQzhY2z4apVCSMxRrSGlj2zfSsLDkiQQxrIu7bg1+O+foQCcsTC6k/KcBS9?=
 =?us-ascii?Q?MP0bHkx+Mc/Bc1Uyj0PFlYPM/0NBMiqwOyqpjBuINNZg1ACio1VbaxSMyFeP?=
 =?us-ascii?Q?sWZBJcINo1CXOqs1cXENzgZOI//tMYIy/Oih3dXeRJtFjSGn4OQNh9Pc0+8W?=
 =?us-ascii?Q?LRXwiOdlMQ4Q6FaJLPsNziClmcXERednmklJAH5P/tJNEh4WORX58OWkfrrc?=
 =?us-ascii?Q?f8qA8EfT0ORjzxXT+KeuowXTMA5RGG0PmvyiXsiy/nvPA+ouB0DTedFlJZOf?=
 =?us-ascii?Q?GO5nAiAhBiZAdim2XUDGgnCxwMd1Ny7AA5gzNKsG+ct9vPQP9x3w7bpnJ9mp?=
 =?us-ascii?Q?mYwL7Nz0aw4wH2DS+83s/eTBOz9j0n2EuPyPAoAFOtaJW+cMNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:10:45.9376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fdab58-6817-461a-72f8-08dca637f601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779

AMD's Advanced Platform Management Link (APML) interface provides system
management functionality accessed by the baseboard management controller (BMC).
sbrmi driver under hwmon subsystem, which is probed as an i2c driver and
reports power using APML specified protocol.
However, APML interface defines few other protocols to support
full system management functionality out-of-band.
Out-of-band management is term used for BMC talking to system management unit
(IP in the processor). AMD's documentation called this link as side band interface.

This patchset is an attempt to add all APML core functionality in one place
and provide hwmon and user space interface
1. Move the i2c client probe, hwmon sensors and sbrmi core functionality [Patch 1]
   from drivers/hwmon to drivers/misc/
2. Convert i2c to regmap which provides multiple benefits [Patch 2]
   over direct smbus APIs.
    a. i2c/i3c support and 
    b. 1 byte/2 byte RMI register size addressing
3. Register a misc device which provides [Patch 3, 4]
    a. An ioctl interface through node /dev/sbrmiX
    b. Register sets is common across APML protocols. IOCTL is providing
       synchronization among protocols as transactions may create
       race condition.
4. [Subsequent patches 5, 6 and 7] add support for AMD custom protocols
    a. CPUID
    b. MCAMSR
    c. Register xfer
5. AMD side band description document [Patch 8]

Open-sourced and widely used https://github.com/amd/esmi_oob_library
will continue to provide user-space programmable API.

Akshay Gupta (8):
  hwmon/misc: amd-sbi: Move core sbrmi from hwmon to misc
  misc: amd-sbi: Use regmap subsystem
  misc: amd-sbi: Add support for AMD_SBI IOCTL
  misc: amd-sbi: Add support for mailbox error codes
  misc: amd-sbi: Add support for CPUID protocol
  misc: amd-sbi: Add support for MCA register protocol
  misc: amd-sbi: Add supoort for register xfer
  misc: amd-sbi: Add document for AMD SB IOCTL description

 Documentation/misc-devices/amd-sbi.rst        | 121 +++++
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 drivers/hwmon/Kconfig                         |  10 -
 drivers/hwmon/sbrmi.c                         | 357 -------------
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/amd-sbi/Kconfig                  |   9 +
 drivers/misc/amd-sbi/Makefile                 |   3 +
 drivers/misc/amd-sbi/rmi-core.c               | 475 ++++++++++++++++++
 drivers/misc/amd-sbi/rmi-core.h               |  67 +++
 drivers/misc/amd-sbi/rmi-hwmon.c              | 122 +++++
 drivers/misc/amd-sbi/rmi-i2c.c                | 135 +++++
 include/uapi/misc/amd-apml.h                  |  74 +++
 13 files changed, 1010 insertions(+), 367 deletions(-)
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
2.44.0


