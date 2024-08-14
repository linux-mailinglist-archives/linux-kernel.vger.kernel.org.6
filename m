Return-Path: <linux-kernel+bounces-286215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE9C95181F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF2EB23248
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79213D52B;
	Wed, 14 Aug 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ggcgv55E"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919519FA8F;
	Wed, 14 Aug 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629628; cv=fail; b=lK7eePgtOdqZQH4euhLvY5+h3pCEbqvOIPvMfLlWXVALKM53NapzVbPJ6bq2RchPrN7SWrY8Dt/446hONkfQcWbPQxnKd7sdRyN2ws+1M0D6mjvFifl7GFvlg/29R1EAo1YOK5dhaq2rLUoSvy2d3cL6z4RuiiH7/9SVc9BU//Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629628; c=relaxed/simple;
	bh=cqDjiYIoBrKhsf9egtIPOdVMhUIFpTNikj46l3gWq4E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DOZp9Wvg9tM90OfRR6UWQweYAAopEFcHsUwFBaMl5P66SFsVq7uAm9BhpTH/vNn5ZZQe/myktS2vNXbH/E6p/C9edag8oQr+j8Dd2fs/5W91OXmpbzLTGB4BHaDtEZy/x5m/4u4YU5Vylj0ylm5NCs5V4NoZx9Cy0pzVEk9Yx9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ggcgv55E; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/9TP3sTl6wnGF5x+9sMKahNFX1vRKpMzRhAS+e/akq0XkEY81EfhGrCWL5Z6ANo+fOm0f9vl46Opzzj/5Lb5fe8Uj1K8QJHQ7hDj+EOmIdwqcxWRTHHKT5JlxBQQmQheydlhC7zykjGxdpTZUQshB/g227P4w4fU3n8V5dtekg91OK2b2r212qqsMHG9MjXsPnYIQP/etBbr/PUxJN9DF1nLgQFIZNoOmULrobX6n/gGxLmvDp6mdMV/eBgHgLMop0sihVDTXUgm0GEF1EPrLH4CffxuElDzd9Y5yF7W9imnnTRRtbH5bNIFukYYkqkT2baBKDZmmyfUlOSn7HHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K9XpMfu51uoFgwpgeXy6TK0/K3vXX3nZzRGSXTybZ0=;
 b=IqiijnN3mxNoANPmyDc6WiHO33YiuymoGTMRVwQZCugRixAZs7Y0G68Imokl0gxAjP7ysAR+Fc3zK3fda4cvlgKeS6M0bukQFWn5P7TFL2cnIQ6SvQAJxdeZn2yPPIIRo3a5sK2AIIeTXm02dYHtCsQQzryKeiEMkQH9fpwOQs+Ev9TaPvvZR0dRMmJXVKXS0ezGCusoBp5JB8031xt4dF4O1EcD7pxpDy3QTGcMHItdq0p5NuT1WNKw7umqjOmfCTDg4RKZBJNUeBu01so1x3sd0kxNwcTroE3RFUDvhzHs1luN/oM9uZKwZYlIs0y5IA76jw4LJox/27S/xF8Itw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K9XpMfu51uoFgwpgeXy6TK0/K3vXX3nZzRGSXTybZ0=;
 b=ggcgv55EZLXp6AzQRNtRAq1FZjRtfWRd2VO4wXmpos36ag8SbZCHqF2TyfV4QBQHlAsBbQ0UDQB7gz6KnhzbwZWq9NACuCFtFy9V1lm4EbZMjy7qZ25ycFAygkdtTwGhAYgAG3BR46PesnqqicttUTfQBbwW8ApnEfDTpGg/m/8=
Received: from CH5PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610:1f0::18)
 by DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 10:00:24 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::38) by CH5PR05CA0021.outlook.office365.com
 (2603:10b6:610:1f0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17 via Frontend
 Transport; Wed, 14 Aug 2024 10:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 10:00:24 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 05:00:15 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v3 0/8] misc: Add AMD side band interface(SBI) functionality
Date: Wed, 14 Aug 2024 09:59:45 +0000
Message-ID: <20240814095954.2359863-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 43716b57-b8c7-45b1-9104-08dcbc47ea7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0VEjOfnKYwWSoTRHv/iOEbo6p0iDK5LJBIP024g60q5JPAfMm9K/eCiYvrla?=
 =?us-ascii?Q?dSaqoCUrPIPGvGGqFzJ9+jMBg1aWVeXI0wT4bHqhdC7ip581mOlK+JvzQgF4?=
 =?us-ascii?Q?oGEEcoYZf2Oczpi4YyjBbEbnIUtNfDieQnfqSFwhzABJ1TkealjvCUygMMWt?=
 =?us-ascii?Q?a6kyAB6nXP2CLuCBnwQlCTWk7PxCxaVlLrBQUu7+6nTEx/Q3zIuQeoqrUsMi?=
 =?us-ascii?Q?OqT3hkTzUIa1I297NODKGG4Ourkq2fM07zAwROWFKolyJjQSDoMSYc5vd7CO?=
 =?us-ascii?Q?WnKJcwK4qm+6B9Kv7PKDrxh2Jvt4sDc6tDbFge92juO1OmbLq+xnEZEIzuD4?=
 =?us-ascii?Q?seT0qB3CWrqMMZR3qJZimYaImo7RwvPsuuzdRdhbVvJPFn/El2p/qhyO4iku?=
 =?us-ascii?Q?gYInPlIYEcuJHCX5XhSLj6Zmlppdjw68hZLO8PT2+YbRX3/6l2pKVS5qhKB1?=
 =?us-ascii?Q?ccmZX150ifXPXux5awjwJQ1GlyKH3xBAM5d9up2l/t2fdRUGhmC9dUQfShV8?=
 =?us-ascii?Q?dlxPxORKq1qTU+gBSyjzJ6wZi28WBmLioAftGePI8D8KWXI7sXJf4tc5fqnb?=
 =?us-ascii?Q?TY5kmV4AVYziBpFE90GxMoQRLAEqxkFK9sVRksgzH1XBjWpd/YIsbS0npBOt?=
 =?us-ascii?Q?ApPq/73dM/Vw10dvfOS0AOjVvmK3NgX+wRQuzE+s+UCDHD/4CbTti9AAOjs+?=
 =?us-ascii?Q?g9bQig1GJOWUodEzr8ZwYfiiQLmUjKlZdtOaRe4PjqNdbvN35JxQdoKgdyIx?=
 =?us-ascii?Q?U3jF22w1UBCH334RuTbP/Lfr4PXpuEeyMrEreB2E7lEb0zbYg/dUU6xIFADp?=
 =?us-ascii?Q?I19PKs9yC8pre8D1GgZoDqMtW0HiW+EpRzeFKnX7m+AMUlLN7HjPvPNqCsWk?=
 =?us-ascii?Q?CBHbrhVbtNs3wXzQpnovI2mvQFVLjcoftbP8rObIZMywrjVkS+gOf4NHklj8?=
 =?us-ascii?Q?X5njNoaFwvi5+/xm5LKqkAGAgpzWZa0M/2/Djx6W9gp/TYx+HMkkMC5VtZCC?=
 =?us-ascii?Q?4oc6ZLPxK73gJp5y2TuilMx86BTPYd7rBraqSW76jUNItawEq6Jh0LTjP6Wm?=
 =?us-ascii?Q?apoFPWoKac0nGu2Q7YGM3AgaTDxneXvQoUtl7/kcLtC9XmYKJ289RXXZcnUh?=
 =?us-ascii?Q?Fh0vFgA3adVq0jW8xseiCletTytsXQfbOATIo1Za490+G3iRDAFlYMbp0RMl?=
 =?us-ascii?Q?nKIhqgxw+ie3mJ71x302fNO/w4swDaR5JERgRe1uFXTklofzXZDZNbnwqexW?=
 =?us-ascii?Q?zTRxHgDeBcEJmU/Rg+ymMqsiBaJ0wDjQEuqp1QHMUR1O8IK6f9+Z1gJsuxnl?=
 =?us-ascii?Q?y0mbyb6vDeNROhFeFAQXpeecSTRlg9hqfolmSnKdxlzswo+q7OD/zjjCXQH8?=
 =?us-ascii?Q?DRecYr2pBJ/OboQjK9BHTqCeEt3+vS59dXn00t2BhxzvZqf2fw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:00:24.1693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43716b57-b8c7-45b1-9104-08dcbc47ea7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528

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


