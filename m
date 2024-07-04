Return-Path: <linux-kernel+bounces-240930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E1E9274C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342D7286557
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8EB1AC422;
	Thu,  4 Jul 2024 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kCPxjI9J"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540651ABCAB;
	Thu,  4 Jul 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091815; cv=fail; b=OuTMIyz9Iy5TCu1B/Ew29p11IIDe2uVeEXl3zgfoGfLzV2I2SbuJHW3rfxeXuvdk11mzlosptVwqQqSRFTkCoDs0RmgmUp+TyRmOg3WBCEDlVoRPuKm8ill5CABvUPzTPPPxDxwhqKTEVwuUS7gXNkBTkh9KJcL6a8RWWZyMg2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091815; c=relaxed/simple;
	bh=QfIQqEcaV94cRTu8DZA/Kl8qzx5lBDPM6wijwJeBbiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Spza7/rhoGy36EWuR3u0Dw6L0r6I4EkD/2nBW82t7s7ZZLyp0kgbU3K6wqpCQGvHRE/oDDaKI8a+pq7Ab5Eilxdz213BMhsmB+TSVFxJrQVCZAuE1l7XPh9YF8IGcYgWuamST+LoA/BfwXHXPnEoVCJ5jNFCJsgH5uQgy6PeSTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kCPxjI9J; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjlmnWSsZ/3vJkm+sccnGJSnQJ/dWbHeY1ElyhDcFay/HO8aWLuZh/T/VahQpz3wMIIfySKMK6x/beyergatsrP0fUO20gOvN9Ad63KMX8OZq3IQIFqChacLHcueGq4LBuFlAlTuJI/sO/oeYMBnHuI0OBgH9fVFjVWcktk9AK38ppHkGAO71tfhWE9/APlLtCEUlmpkc3qFl5kW01vqoxD0Ggob26O2lY27RpvwvEvYIxg6IZzjHgJ3EoYPr55ULwmleG+hJ3FrsPOvu0llqIbJySp/KvpFXD7Wu4jFFfNA5rY7EjOTuVVfV6drJauV6d4QHB/hxoVfIefcEPl/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nARJ225W+O0xBwW7Z5tNiIP4Ra/rDKCLuXoyU45k3/E=;
 b=dUabNJA0najKd+7PhangvXsGEV5ca5bIke7+bnjSVplOxHiTCHYzLtJeYOTLYrKtKFjwmSDA5hP3FyDCBRedivO0slzSd6bqTusoeBSjXuZyj+Lbqv5FkAt0tPkoOkrSZhORqEpvp5f0h8F4G8d5Sf3qJ5hKkl37yarZ09ttYF4NP+noC6a+MHlYTSEOwloIFQPPL4z65rzSfZScM8eItvK7z67q63GzR9lvfHSapY0IFI0sAWhcAVBvVL0t7OGObVeroxjAksIdH+ilZzgNH70eHy8Tf+JOiS/OSRv+d/Tskes9CRWSrUHbXx/B8PMUJKobjuF2euEaA84Z61MXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nARJ225W+O0xBwW7Z5tNiIP4Ra/rDKCLuXoyU45k3/E=;
 b=kCPxjI9JCJg2nf1lLeTCsZX4YxEqHf2Om3yJAgLKc4obNn0vwhW18R7RPbwxcsrF45KoCPjI1pEOX009siNokzjzVR+cJDS91Jp3X78E6Mr7IYMABdrYhBoFfTZstsueePJFyA+si+aI7iladogEa5ATYL29hPvPIBIr2/JMc7Q=
Received: from DM6PR06CA0054.namprd06.prod.outlook.com (2603:10b6:5:54::31) by
 IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Thu, 4 Jul
 2024 11:16:50 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::3) by DM6PR06CA0054.outlook.office365.com
 (2603:10b6:5:54::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29 via Frontend
 Transport; Thu, 4 Jul 2024 11:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 11:16:50 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 06:16:45 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>
CC: <naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH 0/6] misc: add amd side-band functionality
Date: Thu, 4 Jul 2024 11:16:18 +0000
Message-ID: <20240704111624.1583460-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 4587fb0e-603f-454f-3a90-08dc9c1acd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xWqcz+oE0pgBM/f0590WhD+5GVhdJKMJj53yFhm6eWeVv3wyzZIjj3KIOtJ0?=
 =?us-ascii?Q?YjCL1CyKayNCrdvyv0v2ZFp2POvV0/eiiIWFRLjOIigIND0ap7A0/0k6Dggy?=
 =?us-ascii?Q?M43Lw6K6B719hbb7TNXcUSzYd/uPO/HTS1sdGU7HgmdodY0lRzZZ2W9WUm7r?=
 =?us-ascii?Q?qU8L3UXQns/hLDpoBkZTBGGr08p7/X8ad5zmikeRvJzxYRho8L1acHL7gw4t?=
 =?us-ascii?Q?jMkCcoQRM/J4t/OGjCKCzxn+mizz4OZerZrj2v2ZkK0OQco/oshMDSeAcPCJ?=
 =?us-ascii?Q?rBRIoREGea+ldosiddsGwFOLhjptn8MI3xkTwT1CRUQsOEb7bOn9hCvEw0YM?=
 =?us-ascii?Q?bFpzuAJAmXWVrvSyFypKjPy9ZyjHRwWhDzLeWFejw7gNLvNjVJtt+3PZd/Ok?=
 =?us-ascii?Q?7t/xAxvYkJsRgXCmzejUiY+fTklTH92yjPoEzpJy6EighbJ6QvPv58a2CCzg?=
 =?us-ascii?Q?tXxbF8FmDKPLTzddXofjsCybIqmKVbY0CyyvUk/1awyAtBkpCNYlXxiSf6/I?=
 =?us-ascii?Q?q+Yeiko/LqdwCVssIw+FDHk71b9aiLtC/pQsaQf2EO/c8J//yy1tHSvbdsJX?=
 =?us-ascii?Q?raMEwF38WuTPvy0Piv5Lu8JMt5Jw2O9jiDSeruncNtMH2WBgFxYx+s1Q2m0s?=
 =?us-ascii?Q?SmKjwlUjrIWIMc6wgnJXrVJVXtM7sfwDQY60Qeq7YIi2yFp1N38rJDzS+5KT?=
 =?us-ascii?Q?tWZBz4wkbYqzfJq2HpFasOwm+MnP9PHOLK267k4NygfheLpGPgwIbMMoS1hE?=
 =?us-ascii?Q?+1luOcuZVRMUS60i+sg4vVm1SVKvwIAqQubAGmY2LpW0HvHzZAV0U0gw2rRg?=
 =?us-ascii?Q?GiUsqFPPlOcK1obCVdktKMlrM9/gpdJ/y+kVThA3k2Yjh9jjUjFMsmQvcFPo?=
 =?us-ascii?Q?96wkTIURwsNJzmdIr+MDfWBAGcSd/Yw5ctqE9mAMuGII1u1iHdzuX/vcB/5W?=
 =?us-ascii?Q?ALC9W/TpCWDpmebrtetN8kUYLY8lwwr5jJemWLEPvfX1NHVN7KI0v6hcBl62?=
 =?us-ascii?Q?4khHoVj34fBRei5yeDsDSMVJjjZDH7TYS8i9I+Qxgd+B3U9MtUGsV0eRIprp?=
 =?us-ascii?Q?01TSqNXkQ3I8kuQRlrb1d1nPfx4PLEXj0oUzkiw1kjHdx3lqpktDitSqsTkd?=
 =?us-ascii?Q?ww6Pw7MYSsK4OeT5q1fMJPBNVPznceTKR5dJvM6D98pHjpjmGDm/pqDfXUsE?=
 =?us-ascii?Q?b3qR+GNoys5FIrQggsgQvMfyg9Miw4kBH2PHE/FpqwhIQDBGzqLEUZHk0PGg?=
 =?us-ascii?Q?8QPSkeEhoa6H8I4zOjIYAY2XyPqWU29o9dnZIE3JMNF65icl3YLDdS6SSf3O?=
 =?us-ascii?Q?qaBZnCb3bvm7YYyBY0MfiJFKTfR8wv0BhQH8F43DAqu4GqzC32lZ7RsenAj7?=
 =?us-ascii?Q?+cLQ3qa+g/XaYrbOblL/Hq3YBe/XuSNu/kvAnUZGOGmaaZQeiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 11:16:50.1494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4587fb0e-603f-454f-3a90-08dc9c1acd06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078

AMD's APML interface provides system management functionality accessed by
the BMC. Sbrmi driver under hwmon subsystem, which is probed as an i2c
driver and reports power using APML specified protocol.

However, APML interface defines few other protocols to support
full system management functionality out-of-band.

This patchset is an attempt to add all APML core functionality in one place
and provide hwmon and user interface
1. Move the i2c client probe and sbrmi core functionality from drivers/hwmon
   to drivers/misc/
2. Add a platform device, which probes the hwmon/sbrmi and continues to
   report power using the symbol exported by the misc/sbrmi-core.
3. Convert i2c to regmap which provides multiple benefits
   over direct smbus APIs.
4. Register a misc device which provides 
    a. An ioctl interface through node /dev/sbrmiX
    b. Open-sourced and widely used https://github.com/amd/esmi_oob_library
       will continue to provide user-space programmable API.

Akshay Gupta (6):
  hwmon/misc sbrmi: Move core sbrmi from hwmon to misc
  misc: sbrmi: Add platform device add to create platform device
  misc: sbrmi: Use regmap subsystem
  misc: sbrmi: Clear sbrmi status register bit SwAlertSts
  misc/hwmon: sbrmi: Add support for APML protocols
  misc: sbrmi: Add support for EPYC platform Family: 0x1A and Model:
    0x0~0x1F

 drivers/hwmon/Kconfig            |   1 +
 drivers/hwmon/sbrmi.c            | 271 ++------------
 drivers/misc/Kconfig             |   1 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/amd-sb/Kconfig      |   9 +
 drivers/misc/amd-sb/Makefile     |   3 +
 drivers/misc/amd-sb/sbrmi-core.c | 617 +++++++++++++++++++++++++++++++
 drivers/misc/amd-sb/sbrmi-core.h |  36 ++
 drivers/misc/amd-sb/sbrmi-i2c.c  | 239 ++++++++++++
 include/misc/amd-sb.h            |  57 +++
 include/uapi/linux/amd-apml.h    |  74 ++++
 11 files changed, 1072 insertions(+), 237 deletions(-)
 create mode 100644 drivers/misc/amd-sb/Kconfig
 create mode 100644 drivers/misc/amd-sb/Makefile
 create mode 100644 drivers/misc/amd-sb/sbrmi-core.c
 create mode 100644 drivers/misc/amd-sb/sbrmi-core.h
 create mode 100644 drivers/misc/amd-sb/sbrmi-i2c.c
 create mode 100644 include/misc/amd-sb.h
 create mode 100644 include/uapi/linux/amd-apml.h

-- 
2.25.1


