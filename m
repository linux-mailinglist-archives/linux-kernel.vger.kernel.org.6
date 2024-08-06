Return-Path: <linux-kernel+bounces-275829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD52948ABC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D89281056
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7665616A95F;
	Tue,  6 Aug 2024 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lOCjL0Nv"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3A13C909
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931152; cv=fail; b=Kt3JkApk3VITg791VB84Pz7HO6U4/Ubr39xoSxTOyVuoAevuy8a4+6D+0H+LPFkxjvLxeGWkZn5RAcPE96oGg+C7tCXdUB6y58TA01Fa2uky34Chqyby6RSwK8undR0V7Iy75QTfSWesiX/+k1of4LrFXMQzU3nFu0tg0qJq3VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931152; c=relaxed/simple;
	bh=Foz8wdBF9Qi/0rG+9ga2Cq8NNkTIfU9+U1l2vBfLL+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qdD4q0ZfAUWKZjXVa5jYmv60dUXBpq4tBUJsBzNEtYon9AtfXnsdWcUIiKBMTKLOMFAobPp00XdnL3hgsQy1+8LdC9tr+DmnnAnljeDU9yTBLhB5IT9iKdBS4Lol8vXaagzTbZK78mNqYVu74MVL4Pt5GcOccmVxHgWJ0NK5/7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lOCjL0Nv; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dds+oNxg4EB8XFxyKvAfhn1BgbCnAaSLrC/v9fhV4opPIEPkXdzD5eyNxWqCHDaCS/5L5bo7Kqg+eBbVUv5uxKRD+oWbk2Wis5LiMsk1gBfaSBpeRpb0CLMJehsMzcgGrRwu8hSfPpMmN2wRNZ3HUrhWNAWh+mjA0RTzqOg1ywc4/H6mgiFsNC1e+NiExOuY2oxbxKpZFsq4z1qikM04rddw4MIWvbgdb3TdXd2buyXx6oBGxBZToxpM4ySK+4K72N08fMDCVX4CWRQ2JyeTvhEu/bB/6KkutdspsbjHXMaYAV/kS4+D6qG3q6gpVN7BF8Kie4eayHWrXfBDQhvOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0atsmJPLEIiTVCAcMnSzPIm99IKSnYoihtQvdA8WALg=;
 b=eD2a9YgymDla6D5IkPAvE24fN6bs79B3UIP98jdNrsHahamHT2sC1d+jDHqeDbY/V1Rvy274+HQszPG2hVTVcsoELXXL0vcAjHICR9/txcAnqP5mgdGbwh7Yfi9mcUD0xKbg0ySRVOXG3U0SA6ycjBqFcfCAGWK1+haYclf5I1zoAZgwATyfG79ey2iRUAv5OizO9ucVN59oUhhoQwAGPU5TSLy67UvBagaEUL4kFNsD2gAsQWm84uGN2LQELQ71B0c2vY2iG4aeyD8ta3l1i/zTi/OY7aUIlqzoGHNKMYH7SjRWkxATL2kvAeQqvWyojVZDPUJNqdYd8xNFCtIvDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0atsmJPLEIiTVCAcMnSzPIm99IKSnYoihtQvdA8WALg=;
 b=lOCjL0NvJoxyKf9NMRRhSxOY2owGHO/3OHcIKC3jm0nBs4VYh8ARChW9X72ljfN4Z1U2G5yLJwBwlBXwNFlzEBc9jpVQ96e7KXTO9x7/Va3SkwNdCzf74AlcXA5cokrtf+tkYn61OCLNvWozcqBnvSOfrLXMZlTWEg+hrcaBsgY=
Received: from SA0PR12CA0002.namprd12.prod.outlook.com (2603:10b6:806:6f::7)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 6 Aug
 2024 07:59:08 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:6f:cafe::9e) by SA0PR12CA0002.outlook.office365.com
 (2603:10b6:806:6f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24 via Frontend
 Transport; Tue, 6 Aug 2024 07:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 07:59:08 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 02:59:03 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v3 0/5] Introduce initial AMD I3C HCI driver support
Date: Tue, 6 Aug 2024 13:28:38 +0530
Message-ID: <20240806075843.277969-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: d923079c-1d5a-4766-7823-08dcb5eda649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vdYmFuhJZCPQWqUzJqg4mw/L9plpCHyALy0kp7GTsMo4ucobRfoBpVtkM/M1?=
 =?us-ascii?Q?6Yf55ROoW0dreF6VM56gjwiVRzaaKYS0sVI33Jzg8a8TNeda2BKpV+JnR9rz?=
 =?us-ascii?Q?KcObutiaTp5VuHjQ9b+IcANms8mTK+GGP57MDxzmowPZwoWlsazJSzLl0JIS?=
 =?us-ascii?Q?6qDq6x1eXnG89wE6H96RCF1bKk7JNoEKlO8lLFFG2NiC7E9+xmszEOwAkKKv?=
 =?us-ascii?Q?N0Mb6k/AdS8Cvfs5CLfNPBakzdbwwO1ZuDyFsC+gUdmgjcv4heiZI20Q9SLJ?=
 =?us-ascii?Q?t0AKmLSjt/6QGa2vUv2JSbliv41+vPcxYrZGDbfAqmnR0nmkrNcyfpI4L/Xb?=
 =?us-ascii?Q?OeHMkwRrys1UAdX1/esGEbgu7TddQkz0Yq5EkjfJo4ThO5rUbg+9MmwG1wZi?=
 =?us-ascii?Q?hAEwTmxSbKLf8/uP+u0ZHD7OyHXJ50uG5asFoW+VfEvkReCdISscDTkb0xPH?=
 =?us-ascii?Q?Sz7XYLRBZXGkTEpr2ntY7fRraobVdbWvlwmgrHdrVrLfx6NbNY7legk1ZKHl?=
 =?us-ascii?Q?8LgTbzWXU8/5VnyjhzOGWyFvNupBsZ8wCNNDzzqaWN9IvReeReYX/j2eMiLX?=
 =?us-ascii?Q?//6WGdJLqQuSxgPPQiRqQDX/ZlOtPnTttm0qurho82cFkswXyWdNUsTop/J8?=
 =?us-ascii?Q?u9hY8+39vT6FGjHpY+hrPb5Su9GEdTjJEFNBVFxGdBRC7UgbsHfBV8+d/FXz?=
 =?us-ascii?Q?y1tZiu1lvKG5nU4k1gf7aHQ3emKMZxtCKXeSdE+iAhzOT+vGzCauvo7T8xKw?=
 =?us-ascii?Q?BJ8WbLzzoFwYrVXyvdIe5ZczuIhsNYSdeMjwNy0ik50fzAY8h/5vFrQO3lRx?=
 =?us-ascii?Q?/LVvhvndWEkuKgY3R8ShggbghBgPTHUPwPTSA/qki2vW4yMBV8NnUmM7Myl6?=
 =?us-ascii?Q?kETTAy1PcZx+EwxGjVa21wwZGMzku/4du1vGUPFLnhQ0HIsXjWINt+t4UQo8?=
 =?us-ascii?Q?BkTlCLG6aV1GfuThv46SbYA7TJB8kTb9j1VzRI9tAvIDQpPdJJophu2IoMD+?=
 =?us-ascii?Q?rGkJYmfd6DodwUhXCq8FaPxLodkz4X2H36WOJcWasqg+WkESh13ldTmCJRLu?=
 =?us-ascii?Q?zbUa97F+DPp+j5qYZ4Z+K8tdrUyKfv/5kNUmjUgu8FFjwFoyELje9aE17ze6?=
 =?us-ascii?Q?FpkUSwYxLoUwlYLh+UhtmoLe/UD3BOgn8rwqU4OIQ1UkBQqosMe9I2wQRQPe?=
 =?us-ascii?Q?3nOzvlKQ/pNPZBaKnyK/2+4+wowoszcavmPdwAfBkOIZ4cUeLi7yjxkCrgL1?=
 =?us-ascii?Q?Agx3XmBw9xEHghHxD0Y9vZw+mai5yAJcpBZSpEmv7/jDWQAeRCOXk7agZb5+?=
 =?us-ascii?Q?R3HiTL+lHHsCakD3zGzsui/dXRpeAw3SAvzsCEnhGKLegwbaIwu2SFv86tsG?=
 =?us-ascii?Q?kWJxy2oQVlHxB68Ot4RWHn/z/X4EXVSWok18/G5kL+yYnvYpzvZ9QtsCKdoP?=
 =?us-ascii?Q?ObVJRAu+udk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:59:08.0695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d923079c-1d5a-4766-7823-08dcb5eda649
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285

The AMD SoC includes an I3C IP block as part of the Fusion Controller Hub
(FCH). This series introduces the initial driver support to enable the I3C
IP block on AMD's latest processors.

Currently, the code is closely tied to dt-bindings. This initial set aims
to decouple some of these bindings by adding the MIPI ID, allowing the
current driver to support ACPI-enabled x86 systems.

It was discovered that the AMD I3C controller has several hardware issues,
including:
- Non-functional DMA mode (defaulting to PIO mode)
- Issues with Open-Drain (OD) and Push-Pull (PP) timing parameters
- Command response buffer threshold values

All of these issues have been addressed in this series.

v2->v3:
-------
 - use MODULE_DEVICE_TABLE()
 - realign patches
 - address remarks from Jarkko
 
v1->v2:
-------
 - Address LKP reported problems
 - Guard boot_cpu_data usage with CONFIG_X86

Shyam Sundar S K (5):
  i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to the I3C Support List
  i3c: mipi-i3c-hci: Add a quirk to set PIO mode
  i3c: mipi-i3c-hci: Relocate helper macros to HCI header file
  i3c: mipi-i3c-hci: Add a quirk to set timing parameters
  i3c: mipi-i3c-hci: Add a quirk to set Response buffer threshold

 drivers/i3c/master/mipi-i3c-hci/Makefile     |  3 +-
 drivers/i3c/master/mipi-i3c-hci/core.c       | 36 ++++++++++---
 drivers/i3c/master/mipi-i3c-hci/hci.h        | 12 +++++
 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 55 ++++++++++++++++++++
 4 files changed, 98 insertions(+), 8 deletions(-)
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c

-- 
2.25.1


